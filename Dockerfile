FROM atlassian/confluence-server:6.6
MAINTAINER Marcus Li<marcus.li@qq.com>
# 传入破解补丁
ADD lib/atlassian-extras-decoder-v2-3.2.jar ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar
# 设置文件属组
RUN chown -R ${RUN_USER}:${RUN_GROUP} ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar
CMD ["/entrypoint.sh", "-fg"]
ENTRYPOINT ["/sbin/tini", "--"]