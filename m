Return-Path: <linux-kselftest+bounces-48279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7BCF6C1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 06:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE9F330116E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88621B196;
	Tue,  6 Jan 2026 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UheHO3tU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8931CDFD5
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676549; cv=none; b=eYq3XiqkkexM857unpgl/eiAC5smH/xM3O5LD/PGQ0R92FdZDi8TDyw4tcvdUsZ28Yvv5qX2vHrN87rTwDj1cbhKZBaG8RNJm2uUA6UPH0x2K6nuCTL6g+xarDFh0By7kv23oBr84TsLgSMC+kT5ODcTHVY8gMEDy+GjLiv711U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676549; c=relaxed/simple;
	bh=UWQMLFVDfp57j4IOrVMUi0FroYowi2rU8Demy9PX8Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MykSZIp2F94gwvSb2HMXLC+pw94DlC5Mjy83DUE56zcZDVwV8JOM17Bq7dd0Ha2pqKv3meopVsueyT8t5EoddwA3S2L7HjnuJ4fqMhUjzKbhq3ZDXCj1oPm0jn4Fc8nH9uQiN0GXw2IJjAaPeCY6Dvevg+maBtSh3yDOKTNJoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UheHO3tU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767676545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzcrnOKmf2Dd1PERTgsvJmtxpHkwDVV0BvZ9oXoP+Oo=;
	b=UheHO3tUtb70TKpB3WYHRyFvaSwwd+nzldon5tWd0uU6ajrzbcQl0tPjpZQ28oHAv9D+bI
	U0i7ptMYpNxnQH0bxiJPMivPpiGos9Z+TI98Q6SDs9kxZzWVZJmhIoqD3NFS62AGdk8NWW
	JCvc3h2/0tS4YwNvNVqiY7Ho2yNWnRk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Stefano Garzarella <sgarzare@redhat.com>,
	Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 2/3] bpf, sockmap: Fix FIONREAD for sockmap
Date: Tue,  6 Jan 2026 13:14:28 +0800
Message-ID: <20260106051458.279151-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260106051458.279151-1-jiayuan.chen@linux.dev>
References: <20260106051458.279151-1-jiayuan.chen@linux.dev>
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

Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
calculate FIONREAD is not enough.

This patch adds a new ingress_size field in the psock structure to record
the data length in ingress_msg. Additionally, we implement new ioctl
interfaces for TCP and UDP to intercept FIONREAD operations. While Unix
and VSOCK also support sockmap and have similar FIONREAD calculation
issues, fixing them would require more extensive changes
(please let me know if modifications are needed). I believe it's not
appropriate to include those changes under this fix patch.

Previous work by John Fastabend made some efforts towards FIONREAD support:
commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Although the current patch is based on the previous work by John Fastabend,
it is acceptable for our Fixes tag to point to the same commit.

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

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h | 67 +++++++++++++++++++++++++++++++++++++++++--
 net/core/skmsg.c      |  3 ++
 net/ipv4/tcp_bpf.c    | 21 ++++++++++++++
 net/ipv4/udp_bpf.c    | 25 +++++++++++++---
 4 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0323a2b6cf5e..1fa03953043f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -97,6 +97,7 @@ struct sk_psock {
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
 	spinlock_t			ingress_lock;
+	ssize_t				ingress_size;
 	unsigned long			state;
 	struct list_head		link;
 	spinlock_t			link_lock;
@@ -321,6 +322,27 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static inline ssize_t sk_psock_get_msg_size_nolock(struct sk_psock *psock)
+{
+	/* Used by ioctl to read ingress_size only; lock-free for performance */
+	return READ_ONCE(psock->ingress_size);
+}
+
+static inline void sk_psock_inc_msg_size_locked(struct sk_psock *psock, ssize_t diff)
+{
+	/* Use WRITE_ONCE to ensure correct read in sk_psock_get_msg_size_nolock().
+	 * ingress_lock should be held to prevent concurrent updates to ingress_size
+	 */
+	WRITE_ONCE(psock->ingress_size, psock->ingress_size + diff);
+}
+
+static inline void sk_psock_inc_msg_size(struct sk_psock *psock, ssize_t diff)
+{
+	spin_lock_bh(&psock->ingress_lock);
+	sk_psock_inc_msg_size_locked(psock, diff);
+	spin_unlock_bh(&psock->ingress_lock);
+}
+
 static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
@@ -329,6 +351,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 	spin_lock_bh(&psock->ingress_lock);
 	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
+		sk_psock_inc_msg_size_locked(psock, msg->sg.size);
 		ret = true;
 	} else {
 		sk_msg_free(psock->sk, msg);
@@ -345,18 +368,25 @@ static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
 
 	spin_lock_bh(&psock->ingress_lock);
 	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
-	if (msg)
+	if (msg) {
 		list_del(&msg->list);
+		sk_psock_inc_msg_size_locked(psock, -msg->sg.size);
+	}
 	spin_unlock_bh(&psock->ingress_lock);
 	return msg;
 }
 
+static inline struct sk_msg *sk_psock_peek_msg_locked(struct sk_psock *psock)
+{
+	return list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
+}
+
 static inline struct sk_msg *sk_psock_peek_msg(struct sk_psock *psock)
 {
 	struct sk_msg *msg;
 
 	spin_lock_bh(&psock->ingress_lock);
-	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
+	msg = sk_psock_peek_msg_locked(psock);
 	spin_unlock_bh(&psock->ingress_lock);
 	return msg;
 }
@@ -523,6 +553,39 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
 	return !!psock->saved_data_ready;
 }
 
+/* for tcp only, sk is locked */
+static inline ssize_t sk_psock_msg_inq(struct sock *sk)
+{
+	struct sk_psock *psock;
+	ssize_t inq = 0;
+
+	psock = sk_psock_get(sk);
+	if (likely(psock)) {
+		inq = sk_psock_get_msg_size_nolock(psock);
+		sk_psock_put(sk, psock);
+	}
+	return inq;
+}
+
+/* for udp only, sk is not locked */
+static inline ssize_t sk_msg_first_length(struct sock *sk)
+{
+	struct sk_psock *psock;
+	struct sk_msg *msg;
+	ssize_t inq = 0;
+
+	psock = sk_psock_get(sk);
+	if (likely(psock)) {
+		spin_lock_bh(&psock->ingress_lock);
+		msg = sk_psock_peek_msg_locked(psock);
+		if (msg)
+			inq = msg->sg.size;
+		spin_unlock_bh(&psock->ingress_lock);
+		sk_psock_put(sk, psock);
+	}
+	return inq;
+}
+
 #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
 
 #define BPF_F_STRPARSER	(1UL << 1)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index d73e03f7713a..c959d52a62b2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -455,6 +455,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 					atomic_sub(copy, &sk->sk_rmem_alloc);
 				}
 				msg_rx->sg.size -= copy;
+				sk_psock_inc_msg_size(psock, -copy);
 
 				if (!sge->length) {
 					sk_msg_iter_var_next(i);
@@ -819,9 +820,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 		list_del(&msg->list);
 		if (!msg->skb)
 			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
+		sk_psock_inc_msg_size(psock, -((ssize_t)msg->sg.size));
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
+	WARN_ON_ONCE(psock->ingress_size);
 }
 
 static void __sk_psock_zap_ingress(struct sk_psock *psock)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 6332fc36ffe6..a9c758868f13 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -10,6 +10,7 @@
 
 #include <net/inet_common.h>
 #include <net/tls.h>
+#include <asm/ioctls.h>
 
 void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 {
@@ -332,6 +333,25 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	return copied;
 }
 
+static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	bool slow;
+
+	/* we only care about FIONREAD */
+	if (cmd != SIOCINQ)
+		return tcp_ioctl(sk, cmd, karg);
+
+	/* works similar as tcp_ioctl */
+	if (sk->sk_state == TCP_LISTEN)
+		return -EINVAL;
+
+	slow = lock_sock_fast(sk);
+	*karg = sk_psock_msg_inq(sk);
+	unlock_sock_fast(sk, slow);
+
+	return 0;
+}
+
 static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			   int flags, int *addr_len)
 {
@@ -610,6 +630,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
+	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 0735d820e413..cc1156aef14d 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -5,6 +5,7 @@
 #include <net/sock.h>
 #include <net/udp.h>
 #include <net/inet_common.h>
+#include <asm/ioctls.h>
 
 #include "udp_impl.h"
 
@@ -111,12 +112,28 @@ enum {
 static DEFINE_SPINLOCK(udpv6_prot_lock);
 static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
 
+static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	/* we only care about FIONREAD */
+	if (cmd != SIOCINQ)
+		return udp_ioctl(sk, cmd, karg);
+
+	/* works similar as udp_ioctl.
+	 * man udp(7): "FIONREAD (SIOCINQ): Returns the size of the next
+	 * pending datagram in the integer in bytes, or 0 when no datagram
+	 * is pending."
+	 */
+	*karg = sk_msg_first_length(sk);
+	return 0;
+}
+
 static void udp_bpf_rebuild_protos(struct proto *prot, const struct proto *base)
 {
-	*prot        = *base;
-	prot->close  = sock_map_close;
-	prot->recvmsg = udp_bpf_recvmsg;
-	prot->sock_is_readable = sk_msg_is_readable;
+	*prot			= *base;
+	prot->close		= sock_map_close;
+	prot->recvmsg		= udp_bpf_recvmsg;
+	prot->sock_is_readable	= sk_msg_is_readable;
+	prot->ioctl		= udp_bpf_ioctl;
 }
 
 static void udp_bpf_check_v6_needs_rebuild(struct proto *ops)
-- 
2.43.0


