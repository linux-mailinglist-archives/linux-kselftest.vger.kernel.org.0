Return-Path: <linux-kselftest+bounces-48823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B36D165FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F1630341C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2972FA0EF;
	Tue, 13 Jan 2026 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eeHkoyEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAF2F12AB
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272739; cv=none; b=ht+wUBi12adtqmUFOiChJ5Q/a56hSWuAAGPD8O+NgmgTtja8qVQ9b46WoQUFwrbvuDzfiPS8VDT2fwqnM2D+nlG5nXN4GxU3BZqipYUjphJ7lxmut1WtI+PpZZWfsiKyP7zWR1cOXVKTGe+6+cSHZvBgSqiA1ymmMCMgTbzmHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272739; c=relaxed/simple;
	bh=7UX45039VJMAdclIjnKBsOmUzFyLlU0NGNTS7X8IQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia7U6F1zgVGhciXNjSJsIjhxg8Dw+qx4ekcm/E6cNY+a8VHyISfq1e/C1c1ZYulc0Qal1s8+yGLSJ+5GR1SwHTZduznNC8qCmPdTaKLuWo9Io9xCnV1aUY3RNPgdKNZHSH9sLY6eU4vl/dH/A841s7lrtVE/rqT66/jOzTl/acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eeHkoyEq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768272735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vHSp1L27LdGHzrANfj3mnkamJ401bdjPkD4arvnEiQ=;
	b=eeHkoyEqa/SBLiCRgSpaMJX7nGGPt859hJcRw8RhT76juHR+7LVHkVp7PXff0Ffi7kxhmZ
	AMzea0GV0mkDGtveMNGOOz84EIY5V7Aqwc+qEk/UoX4zcRfLl0OF/gwdOMB6k0vFCmLTrB
	yrnieAygLc86phQl73H8XLpFSi5q/7s=
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
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
Date: Tue, 13 Jan 2026 10:50:50 +0800
Message-ID: <20260113025121.197535-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260113025121.197535-1-jiayuan.chen@linux.dev>
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
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

This patch adds a new msg_tot_len field in the psock structure to record
the data length in ingress_msg. Additionally, we implement new ioctl
interfaces for TCP and UDP to intercept FIONREAD operations.

Unix and VSOCK sockets have similar issues, but fixing them is outside
the scope of this patch as it would require more intrusive changes.

Previous work by John Fastabend made some efforts towards FIONREAD support:
commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Although the current patch is based on the previous work by John Fastabend,
it is acceptable for our Fixes tag to point to the same commit.

                                                      FD1:read()
                                                      --  FD1->copied_seq++
                                                          |  [read data]
                                                          |
                                   [enqueue data]         v
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
 include/linux/skmsg.h | 68 +++++++++++++++++++++++++++++++++++++++++--
 net/core/skmsg.c      |  3 ++
 net/ipv4/tcp_bpf.c    | 32 ++++++++++++++++++++
 net/ipv4/udp_bpf.c    | 23 ++++++++++++---
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index dfdc158ab88c..829b281d6c9c 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -97,6 +97,8 @@ struct sk_psock {
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
 	spinlock_t			ingress_lock;
+	/** @msg_tot_len: Total bytes queued in ingress_msg list. */
+	u32				msg_tot_len;
 	unsigned long			state;
 	struct list_head		link;
 	spinlock_t			link_lock;
@@ -321,6 +323,27 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static inline u32 sk_psock_get_msg_len_nolock(struct sk_psock *psock)
+{
+	/* Used by ioctl to read msg_tot_len only; lock-free for performance */
+	return READ_ONCE(psock->msg_tot_len);
+}
+
+static inline void sk_psock_msg_len_add_locked(struct sk_psock *psock, int diff)
+{
+	/* Use WRITE_ONCE to ensure correct read in sk_psock_get_msg_len_nolock().
+	 * ingress_lock should be held to prevent concurrent updates to msg_tot_len
+	 */
+	WRITE_ONCE(psock->msg_tot_len, psock->msg_tot_len + diff);
+}
+
+static inline void sk_psock_msg_len_add(struct sk_psock *psock, int diff)
+{
+	spin_lock_bh(&psock->ingress_lock);
+	sk_psock_msg_len_add_locked(psock, diff);
+	spin_unlock_bh(&psock->ingress_lock);
+}
+
 static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
@@ -329,6 +352,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 	spin_lock_bh(&psock->ingress_lock);
 	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
+		sk_psock_msg_len_add_locked(psock, msg->sg.size);
 		ret = true;
 	} else {
 		sk_msg_free(psock->sk, msg);
@@ -345,18 +369,25 @@ static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
 
 	spin_lock_bh(&psock->ingress_lock);
 	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
-	if (msg)
+	if (msg) {
 		list_del(&msg->list);
+		sk_psock_msg_len_add_locked(psock, -msg->sg.size);
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
@@ -523,6 +554,39 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
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
+		inq = sk_psock_get_msg_len_nolock(psock);
+		sk_psock_put(sk, psock);
+	}
+	return inq;
+}
+
+/* for udp only, sk is not locked */
+static inline ssize_t sk_msg_first_len(struct sock *sk)
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
index ca22ecdbf192..dd1965bf8f6a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -458,6 +458,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 					atomic_sub(copy, &sk->sk_rmem_alloc);
 				}
 				msg_rx->sg.size -= copy;
+				sk_psock_msg_len_add(psock, -copy);
 
 				if (!sge->length) {
 					sk_msg_iter_var_next(i);
@@ -822,9 +823,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 		list_del(&msg->list);
 		if (!msg->skb)
 			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
+		sk_psock_msg_len_add(psock, -msg->sg.size);
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
+	WARN_ON_ONCE(psock->msg_tot_len);
 }
 
 static void __sk_psock_zap_ingress(struct sk_psock *psock)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 5c698fd7fbf8..476101533349 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -10,6 +10,7 @@
 
 #include <net/inet_common.h>
 #include <net/tls.h>
+#include <asm/ioctls.h>
 
 void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 {
@@ -332,6 +333,36 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	return copied;
 }
 
+static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	bool slow;
+
+	if (cmd != SIOCINQ)
+		return tcp_ioctl(sk, cmd, karg);
+
+	/* works similar as tcp_ioctl */
+	if (sk->sk_state == TCP_LISTEN)
+		return -EINVAL;
+
+	slow = lock_sock_fast(sk);
+
+	/* sk_receive_queue being non-empty only occurs if the sk received
+	 * data before being accepted, and no new data has arrived to trigger
+	 * read_skb. If data comes from the sk's native stack, we will also
+	 * consume sk_receive_queue using read_skb.
+	 */
+	if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
+		unlock_sock_fast(sk, slow);
+		return tcp_ioctl(sk, cmd, karg);
+	}
+
+	*karg = sk_psock_msg_inq(sk);
+
+	unlock_sock_fast(sk, slow);
+
+	return 0;
+}
+
 static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			   int flags, int *addr_len)
 {
@@ -610,6 +641,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
+	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 0735d820e413..91233e37cd97 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -5,6 +5,7 @@
 #include <net/sock.h>
 #include <net/udp.h>
 #include <net/inet_common.h>
+#include <asm/ioctls.h>
 
 #include "udp_impl.h"
 
@@ -111,12 +112,26 @@ enum {
 static DEFINE_SPINLOCK(udpv6_prot_lock);
 static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
 
+static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	if (cmd != SIOCINQ)
+		return udp_ioctl(sk, cmd, karg);
+
+	/* Since we don't hold a lock, sk_receive_queue may contain data.
+	 * BPF might only be processing this data at the moment. We only
+	 * care about the data in the ingress_msg here.
+	 */
+	*karg = sk_msg_first_len(sk);
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


