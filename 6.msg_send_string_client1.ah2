; zmq_msg_接口不需要考虑内存大小
#include <log>
#include <zmq>
logger.is_out_file := true
logger.is_use_editor := false
zmq_version(&a := 0, &b := 0, &c := 0)
logger.info("版本: ", a, b, c)

ctx := zmq_ctx_new()
requester := zmq_socket(ctx, ZMQ_REQ)
;设置超时时间 -1无限等待, 0立即返回
buf := Buffer(4), NumPut("int", 3000, buf)
zmq_setsockopt(requester, ZMQ_RCVTIMEO, buf, buf.Size)
;rtn := zmq_connect(requester, "tcp://180.141.156.23:5555")
;rtn := zmq_connect(requester, "tcp://linshi8.f3322.net:5555")
rtn := zmq_connect(requester, "tcp://localhost:5555")

logger.info("client")
send_str := "
(
    client 1
)"

loop
{
    ;zmq_send_string(requester, send_str)
    zmq_msg_send_string(requester, send_str)
    ;mode := ZMQ_DONTWAIT 忽略setoption选项 直接返回
    ;rtn := zmq_recv_string(requester, &recv_string := '', ZMQ_DONTWAIT)
    ;rtn := zmq_recv_string(requester, &recv_string := '')
    rtn := zmq_msg_recv_string(requester, &recv_string := '')
    if(rtn == -1)
        logger.info("等待 server 回复消息失败, time out!")
    else
        logger.info(recv_string)
}

zmq_close(requester)
zmq_ctx_term(ctx)
