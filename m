Return-Path: <linux-kselftest+bounces-2993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC1B82DA61
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5A11C2048C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6A17585;
	Mon, 15 Jan 2024 13:42:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wp716.webpack.hosteurope.de (wp716.webpack.hosteurope.de [80.237.130.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7F1757D;
	Mon, 15 Jan 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alumni.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=alumni.tu-berlin.de
Received: from dynamic-2a01-0c23-606a-b500-b981-1935-c9f7-1531.c23.pool.telefonica.de ([2a01:c23:606a:b500:b981:1935:c9f7:1531] helo=jt.fritz.box); authenticated
	by wp716.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rPNEg-0006AL-4K; Mon, 15 Jan 2024 14:42:42 +0100
From: =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <j-t.hinz@alumni.tu-berlin.de>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <j-t.hinz@alumni.tu-berlin.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Deepa Dinamani <deepa.kernel@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with bpf_setsockopt()
Date: Mon, 15 Jan 2024 14:41:10 +0100
Message-Id: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;j-t.hinz@alumni.tu-berlin.de;1705326171;87aeb70d;
X-HE-SMSGID: 1rPNEg-0006AL-4K

A BPF application, e.g., a TCP congestion control, might benefit from or
even require precise (=hardware) packet timestamps. These timestamps are
already available through __sk_buff.hwtstamp and
bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs were
not allowed to set SO_TIMESTAMPING* on sockets.

Enable BPF programs to actively request the generation of timestamps
from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
network device must still be done separately, in user space.

This patch had previously been submitted in a two-part series (first
link below). The second patch has been independently applied in commit
7f6ca95d16b9 ("net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)")
(second link below).

On the earlier submission, there was the open question whether to only
allow, thus enforce, SO_TIMESTAMPING_NEW in this patch:

For a BPF program, this won't make a difference: A timestamp, when
accessed through the fields mentioned above, is directly read from
skb_shared_info.hwtstamps, independent of the places where NEW/OLD is
relevant. See bpf_convert_ctx_access() besides others.

I am unsure, though, when it comes to the interconnection of user space
and BPF "space", when both are interested in the timestamps. I think it
would cause an unsolvable conflict when user space is bound to use
SO_TIMESTAMPING_OLD with a BPF program only allowed to set
SO_TIMESTAMPING_NEW *on the same socket*? Please correct me if I'm
mistaken.

Link: https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-berlin.de/
Link: https://lore.kernel.org/all/20231221231901.67003-1-jthinz@mailbox.tu-berlin.de/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jörn-Thorben Hinz <j-t.hinz@alumni.tu-berlin.de>
---
 include/uapi/linux/bpf.h                            | 3 ++-
 net/core/filter.c                                   | 2 ++
 tools/include/uapi/linux/bpf.h                      | 3 ++-
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 4 ++++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..8825d0648efe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2734,7 +2734,8 @@ union bpf_attr {
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
index 8c9f67c81e22..4f5280874fd8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5144,6 +5144,8 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SO_TIMESTAMPING_NEW:
+	case SO_TIMESTAMPING_OLD:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..09eaafa6ab43 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2734,7 +2734,8 @@ union bpf_attr {
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
index 1bdc680b0e0e..95f5f169819e 100644
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


