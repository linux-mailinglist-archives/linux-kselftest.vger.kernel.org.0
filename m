Return-Path: <linux-kselftest+bounces-45730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91137C63C09
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 12:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 797404E927A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78932F740;
	Mon, 17 Nov 2025 11:08:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B07328B50;
	Mon, 17 Nov 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377680; cv=none; b=tusIc7sTX8nv3/YKtlYFrp6H21GW2zna3WS1gkKSEYNg7CKgdozU8DF1jh9kRdB+KdhpCYv09gARdSg4+QeIFXHZhqwCCtY6VUvX9b+2YMxIud7vBt0Rm7qbPWNKT8dI66y5V2a1cHlvlzNTj+A5EFA4dEdky3euF1g5EHgplTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377680; c=relaxed/simple;
	bh=4TXoPt5J7w4JVjajJC2ATz+/0q8IWe19znt/MRQ5EEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IW9oF+1mkbJ4bgIeBv24Udbiw1KaKqY2ohmeNKLS0kBuwgA4aKvDM1XQ6ggerWwimq15vTRbWm0/WU6KJbOAQz7cRwNjA+BigwMhbOFV2IC0iIkBNPQS+bbA7mTdMEO3WncdRx33wWvlMRpv+CLLCNJ5tpHURbdxaJHsOYL3HYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 793218B2A0D; Mon, 17 Nov 2025 19:07:51 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq calculation
Date: Mon, 17 Nov 2025 19:07:05 +0800
Message-ID: <20251117110736.293040-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117110736.293040-1-jiayuan.chen@linux.dev>
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A socket using sockmap has its own independent receive queue: ingress_msg.
This queue may contain data from its own protocol stack or from other
sockets.

The issue is that when reading from ingress_msg, we update tp->copied_seq
by default. However, if the data is not from its own protocol stack,
tcp->rcv_nxt is not increased. Later, if we convert this socket to a
native socket, reading from this socket may fail because copied_seq might
be significantly larger than rcv_nxt.

This fix also addresses the syzkaller-reported bug referenced in the
Closes tag.

This patch marks the skmsg objects in ingress_msg. When reading, we update
copied_seq only if the data is from its own protocol stack.

                                                     FD1:read()
                                                     --  FD1->copied_seq++
                                                         |  [read data]
                                                         |
                                [enqueue data]           v
                  [sockmap]     -> ingress to self ->  ingress_msg queue
FD1 native stack  ------>                                 ^
-- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
                                       |                  |
                                       |             ingress to FD1
                                       v                  ^
                                      ...                 |  [sockmap]
                                                     FD2 native stack

Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h | 25 ++++++++++++++++++++++++-
 net/core/skmsg.c      | 19 ++++++++++++++++---
 net/ipv4/tcp_bpf.c    |  5 +++--
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 49847888c287..b7826cb2a388 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -23,6 +23,17 @@ enum __sk_action {
 	__SK_NONE,
 };
 
+/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate data needs to be
+ * redirected to the ingress queue of a specified socket. Since BPF_F_INGRESS is
+ * defined in UAPI so that we can't extend this enum for our internal flags. We
+ * define some internal flags here while inheriting BPF_F_INGRESS.
+ */
+enum {
+	SK_MSG_F_INGRESS	= BPF_F_INGRESS, /* (1ULL << 0) */
+	/* internal flag */
+	SK_MSG_F_INGRESS_SELF	= (1ULL << 1)
+};
+
 struct sk_msg_sg {
 	u32				start;
 	u32				curr;
@@ -141,8 +152,20 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			     struct sk_msg *msg, u32 bytes);
 int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
+int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		     int len, int flags, int *from_self_copied);
 bool sk_msg_is_readable(struct sock *sk);
 
+static inline bool sk_msg_is_to_self(struct sk_msg *msg)
+{
+	return msg->flags & SK_MSG_F_INGRESS_SELF;
+}
+
+static inline void sk_msg_set_to_self(struct sk_msg *msg)
+{
+	msg->flags |= SK_MSG_F_INGRESS_SELF;
+}
+
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
 {
 	WARN_ON(i == msg->sg.end && bytes);
@@ -235,7 +258,7 @@ static inline struct page *sk_msg_page(struct sk_msg *msg, int which)
 
 static inline bool sk_msg_to_ingress(const struct sk_msg *msg)
 {
-	return msg->flags & BPF_F_INGRESS;
+	return msg->flags & SK_MSG_F_INGRESS;
 }
 
 static inline void sk_msg_compute_data_pointers(struct sk_msg *msg)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..25d88c2082e9 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -409,14 +409,14 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 }
 EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
 
-/* Receive sk_msg from psock->ingress_msg to @msg. */
-int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
-		   int len, int flags)
+int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		     int len, int flags, int *from_self_copied)
 {
 	struct iov_iter *iter = &msg->msg_iter;
 	int peek = flags & MSG_PEEK;
 	struct sk_msg *msg_rx;
 	int i, copied = 0;
+	bool to_self;
 
 	msg_rx = sk_psock_peek_msg(psock);
 	while (copied != len) {
@@ -425,6 +425,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		if (unlikely(!msg_rx))
 			break;
 
+		to_self = sk_msg_is_to_self(msg_rx);
 		i = msg_rx->sg.start;
 		do {
 			struct page *page;
@@ -443,6 +444,9 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			}
 
 			copied += copy;
+			if (to_self && from_self_copied)
+				*from_self_copied += copy;
+
 			if (likely(!peek)) {
 				sge->offset += copy;
 				sge->length -= copy;
@@ -487,6 +491,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 out:
 	return copied;
 }
+EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);
+
+/* Receive sk_msg from psock->ingress_msg to @msg. */
+int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		   int len, int flags)
+{
+	return __sk_msg_recvmsg(sk, psock, msg, len, flags, NULL);
+}
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
 
 bool sk_msg_is_readable(struct sock *sk)
@@ -616,6 +628,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	if (unlikely(!msg))
 		return -EAGAIN;
 	skb_set_owner_r(skb, sk);
+	sk_msg_set_to_self(msg);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a268e1595b22..6332fc36ffe6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -226,6 +226,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	int peek = flags & MSG_PEEK;
 	struct sk_psock *psock;
 	struct tcp_sock *tcp;
+	int from_self_copied = 0;
 	int copied = 0;
 	u32 seq;
 
@@ -262,7 +263,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 
 msg_bytes_ready:
-	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &from_self_copied);
 	/* The typical case for EFAULT is the socket was gracefully
 	 * shutdown with a FIN pkt. So check here the other case is
 	 * some error on copy_page_to_iter which would be unexpected.
@@ -277,7 +278,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 	}
-	seq += copied;
+	seq += from_self_copied;
 	if (!copied) {
 		long timeo;
 		int data;
-- 
2.43.0


