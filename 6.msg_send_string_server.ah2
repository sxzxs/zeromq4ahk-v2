; zmq_msg_接口不需要考虑内存大小
#include <log>
#include <zmq>

logger.is_out_file := true
logger.is_use_editor := false
logger.info("server")
ctx := zmq_ctx_new()
responder := zmq_socket(ctx, ZMQ_REP)
;设置超时时间 -1无限等待, 0立即返回
buf := Buffer(4), NumPut("int", -1, buf)
zmq_setsockopt(responder, ZMQ_RCVTIMEO, buf, buf.Size)
rtn := zmq_bind(responder, "tcp://*:5555")

loop
{
    ;rtn := zmq_recv_string(responder, &recv_str := '')
    rtn := zmq_msg_recv_string(responder, &recv_str := '')
    if(rtn == -1)
        logger.info("接收消息失败")
    else
    {
        logger.info("接收消息: " recv_str)
        ;zmq_send_string(responder, "我是zmq, 我接收到了你的消息" recv_str)
        zmq_msg_send_string(responder, "我是zmq, 我接收到了你的消息" recv_str)
    }
}

zmq_close(responder)
zmq_ctx_term(ctx)