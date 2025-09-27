Return-Path: <linux-kselftest+bounces-42535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B3BA5CBF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C61B21543
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6152D949E;
	Sat, 27 Sep 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMobheC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BD2D9493;
	Sat, 27 Sep 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966067; cv=none; b=jOpBdyome0d8fpGDIJhRg9MibUs0oYVRt51ZkEVxWyW5WgQvpz1vYIECv3D4NOfmc+Cb9fIS+3GIx05krPJiGbULWci5fu3luMFZAwRsTTV4MR377uUXYa6hT+lDFpyXUQqMM0Hh/YbWmO/ia+oS7sNkxkbDMnVgPCmrJAJcaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966067; c=relaxed/simple;
	bh=96liQdHyINpJivQjUfjO8HeHUporkIbfcFfp0+dhHG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9HTRYo+BhnwHFYR+GYSY4IvRn1C8JU82+jBmJkHINGBxVbu54m+4SEu4tk3YE3bBwDlVOx77+UU56LuOlb0rHOC6pOOBajytMjzHGKk69c3e7zfyiaGbtvUvuyauutS0fQPgroFq0IQGsuvRBINPakIwBlSvCNF3sceJNbeWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMobheC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6144AC4CEE7;
	Sat, 27 Sep 2025 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966067;
	bh=96liQdHyINpJivQjUfjO8HeHUporkIbfcFfp0+dhHG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XMobheC8xpqQI9PdzTTIOPIzADDk2dZV1bPpObMbqugCRQSP/npfBUl4P2MhUlUdo
	 6NdDsXEzIkUcgsAgx7Xh0rVhDn74dKom5bY9n1LLHGOBoN04FTxHd+bn7I5uFHKsGj
	 qXlqY9fV+lW49a3GDp+u6uF2Dt+EzfOkh/zFeDBWMrblmPayGmrWy/bJr2y0bvxLmT
	 /TZgAiNnYdL/2KpDkDIKEetHQm77o38cyIK7ywFghhmLG9BpmTI8YhnLEVB6tXBlwK
	 42fNZf1TnfXS6lGTpz2Co99HNs4Gm2IaE8iEvVKnSNxpvIDkmE6XOY/ViPUk0pbo3e
	 XDAbePLvx+K8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:39 +0200
Subject: [PATCH net-next 3/8] mptcp: rcvbuf auto-tuning improvement
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-3-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6824; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yGaelyAPu5uQ/arGQNIYVdDpszzRp1Ye2ABH8DkBfPM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub5R3v7fr5LWr3rtKKwRtr5oy5XXuLjZf1Du/ZRZ7P
 ZvwScGjHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNR/c/w3/+8MW/+A//QPx8W
 /i28Fd6YI/JyzbKI+6wPAnXCn/58psjwi/ny6XMzvHMYrudvcmLsvJ12IOlf5yPG1SsWTHt9sPm
 fOS8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Apply to the MPTCP auto-tuning the same improvements introduced for the
TCP protocol by the merge commit 2da35e4b4df9 ("Merge branch
'tcp-receive-side-improvements'").

The main difference is that TCP subflow and the main MPTCP socket need
to account separately for OoO: MPTCP does not care for TCP-level OoO
and vice versa, as a consequence do not reflect MPTCP-level rcvbuf
increase due to OoO packets at the subflow level.

This refeactor additionally allow dropping the msk receive buffer update
at receive time, as the latter only intended to cope with subflow receive
buffer increase due to OoO packets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/559
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 97 +++++++++++++++++++++++++---------------------------
 net/mptcp/protocol.h |  4 +--
 2 files changed, 49 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 62cdd2bcff9da12783b97fd40813ede85b5c83d9..f994e7f45f7b96c280708d7a29c1423a91e4cfee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -179,6 +179,35 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 	return mptcp_try_coalesce((struct sock *)msk, to, from);
 }
 
+/* "inspired" by tcp_rcvbuf_grow(), main difference:
+ * - mptcp does not maintain a msk-level window clamp
+ * - returns true when  the receive buffer is actually updated
+ */
+static bool mptcp_rcvbuf_grow(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct net *net = sock_net(sk);
+	int rcvwin, rcvbuf, cap;
+
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		return false;
+
+	rcvwin = msk->rcvq_space.space << 1;
+
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
+
+	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+
+	rcvbuf = min_t(u32, mptcp_space_from_win(sk, rcvwin), cap);
+	if (rcvbuf > sk->sk_rcvbuf) {
+		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+		return true;
+	}
+	return false;
+}
+
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -292,6 +321,9 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
+	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
+	if (sk->sk_socket)
+		mptcp_rcvbuf_grow(sk);
 }
 
 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -784,18 +816,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
-static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
-{
-	if (unlikely(ssk->sk_rcvbuf > sk->sk_rcvbuf))
-		WRITE_ONCE(sk->sk_rcvbuf, ssk->sk_rcvbuf);
-}
-
 static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	__mptcp_rcvbuf_update(sk, ssk);
-
 	/* Wake-up the reader only for in-sequence data */
 	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
@@ -2014,48 +2038,26 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
-	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		u64 rcvwin, grow;
-		int rcvbuf;
+	msk->rcvq_space.space = msk->rcvq_space.copied;
+	if (mptcp_rcvbuf_grow(sk)) {
 
-		rcvwin = ((u64)msk->rcvq_space.copied << 1) + 16 * advmss;
+		/* Make subflows follow along.  If we do not do this, we
+		 * get drops at subflow level if skbs can't be moved to
+		 * the mptcp rx queue fast enough (announced rcv_win can
+		 * exceed ssk->sk_rcvbuf).
+		 */
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk;
+			bool slow;
 
-		grow = rcvwin * (msk->rcvq_space.copied - msk->rcvq_space.space);
-
-		do_div(grow, msk->rcvq_space.space);
-		rcvwin += (grow << 1);
-
-		rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
-			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-
-		if (rcvbuf > sk->sk_rcvbuf) {
-			u32 window_clamp;
-
-			window_clamp = mptcp_win_from_space(sk, rcvbuf);
-			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
-
-			/* Make subflows follow along.  If we do not do this, we
-			 * get drops at subflow level if skbs can't be moved to
-			 * the mptcp rx queue fast enough (announced rcv_win can
-			 * exceed ssk->sk_rcvbuf).
-			 */
-			mptcp_for_each_subflow(msk, subflow) {
-				struct sock *ssk;
-				bool slow;
-
-				ssk = mptcp_subflow_tcp_sock(subflow);
-				slow = lock_sock_fast(ssk);
-				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
-				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
-				if (tcp_can_send_ack(ssk))
-					tcp_cleanup_rbuf(ssk, 1);
-				unlock_sock_fast(ssk, slow);
-			}
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			slow = lock_sock_fast(ssk);
+			tcp_sk(ssk)->rcvq_space.space = msk->rcvq_space.copied;
+			tcp_rcvbuf_grow(ssk);
+			unlock_sock_fast(ssk, slow);
 		}
 	}
 
-	msk->rcvq_space.space = msk->rcvq_space.copied;
 new_measure:
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.time = mstamp;
@@ -2084,11 +2086,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 	if (list_empty(&msk->conn_list))
 		return false;
 
-	/* verify we can move any data from the subflow, eventually updating */
-	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
-		mptcp_for_each_subflow(msk, subflow)
-			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
-
 	subflow = list_first_entry(&msk->conn_list,
 				   struct mptcp_subflow_context, node);
 	for (;;) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 371084a3fc225391fe98ad42a2e2f63465119989..52f9cfa4ce95c789a7b9c53c47095abe7964d18f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -341,8 +341,8 @@ struct mptcp_sock {
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
 	struct {
-		u32	space;	/* bytes copied in last measurement window */
-		u32	copied; /* bytes copied in this measurement window */
+		int	space;	/* bytes copied in last measurement window */
+		int	copied; /* bytes copied in this measurement window */
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;

-- 
2.51.0


