Return-Path: <linux-kselftest+bounces-24822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91038A176D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 06:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE46116A205
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 05:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084241B0408;
	Tue, 21 Jan 2025 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ivXF9FVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657331ACEAC;
	Tue, 21 Jan 2025 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737436179; cv=none; b=oG2IlAmFg1VGc1amuEKZPA4PUs9UF/w7mn6da3x3E2Jc5l1wW5RA4J6sSKDit9qW+sX3Wd/dj0ykYqvo6U1b7PZrd5VfFVgzuW//g9PyBh/uegikPBWXXGP4PxbkIw7T3HaSc0BhYXTdE+PP+K4kPJNzNYg3aWjJ5LOSfvDZLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737436179; c=relaxed/simple;
	bh=hEImoseKWo0E9B2QFiXPKIHFFWsmwpeTSuHp7MefVr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbvtsek2kToazr8bGK9d1OP45jFlVsWMD1usqAElKMBSuPth4wbuw724yzDcLS0O5iGSWP/JaqCBQ+f5TVlMPyAonSZvxRw+005uFhST26UYOvIl37IgWNRt7a5FKlvclF8mb6Ih2qWehV4VO+By7dZtSflFUGdsBmmtcf0rPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ivXF9FVh; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=jR9Ap
	pvosdVIS01cytFrRWp0HPq2UnOWrUcF+0NyLKQ=; b=ivXF9FVhZK2aev6aztgv8
	Oh2Pc/nhsQ8esQjQcOLES+FlIN4APcomLohRzFRvE7sfGLziOKmz+RLKJ1G5nrl1
	DaZSdvsZ5PHV/PbOJuxX/u4ax/ETu/uSxk/+dQrN6CtkMQJn9fjdBJqNxzq7HgcH
	iLPvMo4W9gpjC1aLYBcMbM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHwYeaK49nTErMHA--.41409S4;
	Tue, 21 Jan 2025 13:08:12 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v8 2/5] bpf: fix wrong copied_seq calculation
Date: Tue, 21 Jan 2025 13:07:04 +0800
Message-ID: <20250121050707.55523-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121050707.55523-1-mrpre@163.com>
References: <20250121050707.55523-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHwYeaK49nTErMHA--.41409S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryrKFW5JFWkWFy3ZryUGFg_yoW3WFyrpF
	1kA3yrCr9rGFyxuwn3AF97Gr1agw4rKFW7Cr18u3y3Zrs3Kr1fXF95KF1ayFW5Kr4Y9r1a
	qr4UGw43CwnrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pETa0gUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWwnbp2ePHkP-dAACsS

'sk->copied_seq' was updated in the tcp_eat_skb() function when the
action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
the update logic for 'sk->copied_seq' was moved to
tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.

It works for a single stream_verdict scenario, as it also modified
'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
to remove updating 'sk->copied_seq'.

However, for programs where both stream_parser and stream_verdict are
active(strparser purpose), tcp_read_sock() was used instead of
tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
updates.

In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
in both tcp_read_sock() and tcp_bpf_recvmsg_parser().

The issue causes incorrect copied_seq calculations, which prevent
correct data reads from the recv() interface in user-land.

We do not want to add new proto_ops to implement a new version of
tcp_read_sock, as this would introduce code complexity [1].

We add new callback for strparser for customized read operation.

[1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 include/linux/skmsg.h |  2 ++
 include/net/tcp.h     |  8 ++++++++
 net/core/skmsg.c      |  7 +++++++
 net/ipv4/tcp.c        | 29 ++++++++++++++++++++++++-----
 net/ipv4/tcp_bpf.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 2cbe0c22a32f..0b9095a281b8 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -91,6 +91,8 @@ struct sk_psock {
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+	u32				copied_seq;
+	u32				ingress_bytes;
 #endif
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..06affc653247 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -729,6 +729,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		  sk_read_actor_t recv_actor);
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
 void tcp_read_done(struct sock *sk, size_t len);
@@ -2599,6 +2602,11 @@ struct sk_psock;
 #ifdef CONFIG_BPF_SYSCALL
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+#ifdef CONFIG_BPF_STREAM_PARSER
+struct strparser;
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor);
+#endif /* CONFIG_BPF_STREAM_PARSER */
 #endif /* CONFIG_BPF_SYSCALL */
 
 #ifdef CONFIG_INET
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 61f3f3d4e528..0ddc4c718833 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -549,6 +549,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	psock->ingress_bytes += len;
+#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1144,6 +1147,10 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
+	if (sk_is_tcp(sk)) {
+		psock->strp.cb.read_sock = tcp_bpf_strp_read_sock;
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+	}
 	return ret;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..285678d8ce07 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor, bool noack,
+			   u32 *copied_seq)
 {
 	struct sk_buff *skb;
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
+	u32 seq = *copied_seq;
 	u32 offset;
 	int copied = 0;
 
@@ -1624,9 +1625,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
 			break;
-		WRITE_ONCE(tp->copied_seq, seq);
+		WRITE_ONCE(*copied_seq, seq);
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
+	WRITE_ONCE(*copied_seq, seq);
+
+	if (noack)
+		goto out;
 
 	tcp_rcv_space_adjust(sk);
 
@@ -1635,10 +1639,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_recv_skb(sk, seq, &offset);
 		tcp_cleanup_rbuf(sk, copied);
 	}
+out:
 	return copied;
 }
+
+int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		  sk_read_actor_t recv_actor)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, false,
+			       &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
+}
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 47f65b1b70ca..4dcf88ad8275 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -646,6 +646,48 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	       ops->sendmsg  == tcp_sendmsg ? 0 : -ENOTSUPP;
 }
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+	struct sk_psock *psock;
+	struct tcp_sock *tp;
+	int copied = 0;
+
+	tp = tcp_sk(sk);
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (WARN_ON(!psock)) {
+		desc->error = -EINVAL;
+		goto out;
+	}
+
+	psock->ingress_bytes = 0;
+	/* We could easily add copied_seq and noack into desc then call
+	 * ops->read_sock without calling symbol directly. But unfortunately
+	 * most descriptors used by other modules are not inited with zero.
+	 * Also it not work by replacing ops->read_sock without introducing
+	 * new ops as ops itself is located in rodata segment.
+	 */
+	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
+				     &psock->copied_seq);
+	if (copied < 0)
+		goto out;
+	/* recv_actor may redirect skb to another socket(SK_REDIRECT) or
+	 * just put skb into ingress queue of current socket(SK_PASS).
+	 * For SK_REDIRECT, we need 'ack' the frame immediately but for
+	 * SK_PASS, the 'ack' was delay to tcp_bpf_recvmsg_parser()
+	 */
+	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+out:
+	rcu_read_unlock();
+	return copied;
+}
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
-- 
2.43.5


