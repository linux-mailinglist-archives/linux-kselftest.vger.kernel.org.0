Return-Path: <linux-kselftest+bounces-48524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6AD03AF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0653F30AAD09
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B1341653;
	Thu,  8 Jan 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luXrKEP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B13451B5
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884499; cv=none; b=TUeGDQu8DbUEXaslUG+1EGH7t1Qh5kdG0BnrqQY5HlY/T62wXNnkWp2U9eXHlzsGJ1z2bssSCf0cG/BDCbmCD8TnQziNqtDXFn2J7ExRh5GXmWgWXeJL2J9alYZG5/Qr5rvxEzZW3MgeyJNXiIQzXRXCrz3Tk4a9Ll9M0k5XHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884499; c=relaxed/simple;
	bh=1wM+Umqivq6fi2g259smDi3EfrM2ZQeywOPoTMUrnO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwEkaPBLP+E6BeZIVrxLlJ8fY0+mOA40GU57MoCDOFA6g0KZRGS3A8ZcoO1WGG5F8Zwh4q4sHvrFCEA5RzYbv4VpADrFLd43fT4TwjKISbvHi3fS/5FYWgqf+ZMIYiQyuyRBcG7RIbthdCKpbFyvfl5c6C8/RMgw5b5+L/A/JsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luXrKEP8; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767884495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V53pa5S0H0LfMXP8GS8ZkZDhqoGNJL2k82MVkgcqumI=;
	b=luXrKEP8a2U0fRquefBFUZYo3y1muSEH6iaJfq3oHV4qU7Lh1XrAulkhf6hSvmrpkszmCX
	GofQvJ5m6Xi3wSo2h3sT01x0rLYTK5OuxUAxS2Ozyav3kRUwnDfoCNHSFiMy4h4cJVy5th
	XJG7BFY+Jt+UvLstQblELfxtSqZH66g=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf-next v6 1/3] bpf, sockmap: Fix incorrect copied_seq calculation
Date: Thu,  8 Jan 2026 23:00:30 +0800
Message-ID: <20260108150102.12563-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260108150102.12563-1-jiayuan.chen@linux.dev>
References: <20260108150102.12563-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h |  2 ++
 net/core/skmsg.c      | 25 ++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    |  5 +++--
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 49847888c287..dfdc158ab88c 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -141,6 +141,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			     struct sk_msg *msg, u32 bytes);
 int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
+int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		     int len, int flags, int *copied_from_self);
 bool sk_msg_is_readable(struct sock *sk);
 
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..3d147837b82c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -409,14 +409,14 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 }
 EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
 
-/* Receive sk_msg from psock->ingress_msg to @msg. */
-int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
-		   int len, int flags)
+int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		     int len, int flags, int *copied_from_self)
 {
 	struct iov_iter *iter = &msg->msg_iter;
 	int peek = flags & MSG_PEEK;
 	struct sk_msg *msg_rx;
 	int i, copied = 0;
+	bool from_self;
 
 	msg_rx = sk_psock_peek_msg(psock);
 	while (copied != len) {
@@ -425,6 +425,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		if (unlikely(!msg_rx))
 			break;
 
+		from_self = msg_rx->sk == sk;
 		i = msg_rx->sg.start;
 		do {
 			struct page *page;
@@ -443,6 +444,9 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			}
 
 			copied += copy;
+			if (from_self && copied_from_self)
+				*copied_from_self += copy;
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
@@ -616,6 +628,12 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	if (unlikely(!msg))
 		return -EAGAIN;
 	skb_set_owner_r(skb, sk);
+
+	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+	 * data originates from the socket's own protocol stack. No need to
+	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+	 */
+	msg->sk = sk;
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
@@ -909,6 +927,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
+	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a268e1595b22..5c698fd7fbf8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -226,6 +226,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	int peek = flags & MSG_PEEK;
 	struct sk_psock *psock;
 	struct tcp_sock *tcp;
+	int copied_from_self = 0;
 	int copied = 0;
 	u32 seq;
 
@@ -262,7 +263,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 
 msg_bytes_ready:
-	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
 	/* The typical case for EFAULT is the socket was gracefully
 	 * shutdown with a FIN pkt. So check here the other case is
 	 * some error on copy_page_to_iter which would be unexpected.
@@ -277,7 +278,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 	}
-	seq += copied;
+	seq += copied_from_self;
 	if (!copied) {
 		long timeo;
 		int data;
-- 
2.43.0


