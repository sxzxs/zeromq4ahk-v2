#include <log>
#include <zmq>
logger.is_out_file := true
logger.is_use_editor := false
zmq_version(&a := 0, &b := 0, &c := 0)
logger.info("版本: ", a, b, c)

ctx := zmq_ctx_new()
requester := zmq_socket(ctx, ZMQ_REQ)
rtn := zmq_connect(requester, "tcp://localhost:5555")

logger.info("client")

send_str := "
(
大洋网讯 北京时间11月21日凌晨零时，万众瞩目的第22届男足世界杯将在卡塔尔多哈海湾体育场揭幕。本届世界杯是历史上首次在中东海湾地区举行，也是首次在北半球的冬季举行，东道主卡塔尔更是首次进入世界杯决赛圈。另外，本届世界杯是新冠疫情后首次举办的世界杯，也是最后一届采取32强模式进行的世界杯。面对诸多变化，本届世界杯将呈现哪些可能性，又将给全世界球迷带来哪些惊喜呢？
)"

loop
{
    zmq_send_string(requester, send_str)
    rtn := zmq_recv_string(requester, &recv_str := '')
    logger.info(recv_str)
    Sleep(2000)
}

zmq_close(requester)
zmq_ctx_term(ctx)
