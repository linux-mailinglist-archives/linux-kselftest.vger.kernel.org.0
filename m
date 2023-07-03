Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E97746199
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGCRxY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGCRxW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 13:53:22 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A279C2;
        Mon,  3 Jul 2023 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=4091; s=dkim-tub; t=1688406797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sVFj5XSEpvbTR84sGLSbUV0+aK9N+w+4xBjQ6fw0+Us=;
  b=Y4sY+8LHxjCriKGa+njKADQCwaP9QMILCz1d447SBA18w8YGm0VrVr8v
   8ZrexQXgNt/ZnTTSgHr3tyslGNXqX4efiv7TfWViv8fxwQ3lhcv04ZxgC
   FPdIKPIuvvJUJIZhzBeuGu/UI1G5R75llIxAe+fpLPFYCcK13bjM16L+q
   0=;
X-IronPort-AV: E=Sophos;i="6.01,178,1684792800"; 
   d="scan'208";a="1320359"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 03 Jul 2023 19:52:08 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH 2/2] bpf: Allow setting SO_TIMESTAMPING* with bpf_setsockopt()
Date:   Mon, 3 Jul 2023 19:50:46 +0200
Message-ID: <20230703175048.151683-3-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
References: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A BPF application, e.g., a TCP congestion control, might benefit from or
even require precise (=hardware) packet timestamps. These timestamps are
already available in __sk_buff.hwtstamp and bpf_sock_ops.skb_hwtstamp,
but could not be requested: A BPF program was not allowed to set
SO_TIMESTAMPING* on a socket.

Enable BPF programs to actively request the generation of timestamps
from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
network device must still be done separately, in user space.

Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 include/uapi/linux/bpf.h                            | 3 ++-
 net/core/filter.c                                   | 2 ++
 tools/include/uapi/linux/bpf.h                      | 3 ++-
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 4 ++++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..3e64b8137931 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2640,7 +2640,8 @@ union bpf_attr {
  * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
  * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
  * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
- * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
+ * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**,
+ * 		  **SO_TIMESTAMPING_NEW**, **SO_TIMESTAMPING_OLD**.
  * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..af0f3a6762de 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5108,6 +5108,8 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SO_TIMESTAMPING_NEW:
+	case SO_TIMESTAMPING_OLD:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..3e64b8137931 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2640,7 +2640,8 @@ union bpf_attr {
  * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
  * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
  * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
- * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
+ * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**,
+ * 		  **SO_TIMESTAMPING_NEW**, **SO_TIMESTAMPING_OLD**.
  * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index cfed4df490f3..8d526db8ceeb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -15,8 +15,10 @@
 #define SO_RCVLOWAT		18
 #define SO_BINDTODEVICE		25
 #define SO_MARK			36
+#define SO_TIMESTAMPING_OLD     37
 #define SO_MAX_PACING_RATE	47
 #define SO_BINDTOIFINDEX	62
+#define SO_TIMESTAMPING_NEW     65
 #define SO_TXREHASH		74
 #define __SO_ACCEPTCON		(1 << 16)
 
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 7a438600ae98..54205d10793c 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -48,6 +48,10 @@ static const struct sockopt_test sol_socket_tests[] = {
 	{ .opt = SO_MARK, .new = 0xeb9f, .expected = 0xeb9f, },
 	{ .opt = SO_MAX_PACING_RATE, .new = 0xeb9f, .expected = 0xeb9f, },
 	{ .opt = SO_TXREHASH, .flip = 1, },
+	{ .opt = SO_TIMESTAMPING_NEW, .new = SOF_TIMESTAMPING_RX_HARDWARE,
+		.expected = SOF_TIMESTAMPING_RX_HARDWARE, },
+	{ .opt = SO_TIMESTAMPING_OLD, .new = SOF_TIMESTAMPING_RX_HARDWARE,
+		.expected = SOF_TIMESTAMPING_RX_HARDWARE, },
 	{ .opt = 0, },
 };
 
-- 
2.39.2

