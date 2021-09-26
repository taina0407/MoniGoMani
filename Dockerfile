FROM taina/freqtrade:3503fdb4ec31be99f433fdce039543e0911964d6

# Switch user to root if you must install something from apt
# Don't forget to switch the user back below!
USER root

# Switch back to the normal Freqtrade User
USER ftuser

# Create monigomani directory
RUN mkdir -p ./monigomani/

# Create an empty log file if non existing
RUN mkdir -p ./user_data/logs/

# Create an empty directory for downloaded StaticPairLists
RUN mkdir -p ./user_data/mgm_pair_lists/
RUN mkdir -p ./user_data/backtest_results/
RUN mkdir -p ./user_data/hyperopt_results/

# Install and execute
COPY --chown=ftuser:ftuser requirements-mgm.txt Pipfile Pipfile.lock ./monigomani/
RUN pip install -r ./monigomani/requirements-mgm.txt

COPY --chown=ftuser:ftuser . ./monigomani/
COPY --chown=ftuser:ftuser ./user_data/mgm-config-private.example.json  /freqtrade/user_data/
COPY --chown=ftuser:ftuser ./user_data/mgm-config.example.json  /freqtrade/user_data/
COPY --chown=ftuser:ftuser ./mgm-hurry  /freqtrade/mgm-hurry
