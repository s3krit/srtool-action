FROM chevdor/srtool:nightly-2020-07-20
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT /entrypoint.sh
