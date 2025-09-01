Return-Path: <linux-kselftest+bounces-40422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A1B3DECE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C293BD261
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1B30FF24;
	Mon,  1 Sep 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PddF6V6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527530FC33;
	Mon,  1 Sep 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719617; cv=none; b=Z++r1+AbYTv7rdx3Kqu/vN+YBKwld665uLR1IP5g9LvFYITZMWFh5wOf9Kun1y0fTmc46rZK5EOEKtCpLmaqu3+GXG0e//ZZOr8s6oopCFarPyZw8gnYWY/eqgh84xlRXZgvelLzju0oZVcKU+tKRNtI9a1/ox/iYNHddxy9hN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719617; c=relaxed/simple;
	bh=drdbAkdFpvZAJ6wkGaaJxaCs0z5c3l+uoYeiTtWqED4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E29G2pvktZx5aqADI4OU59WvA1FUZw9jFBiIt5PsK5FzDZzoDZBaQdaTNZdCiZGWTlam6q7cAIl1+wJbC97hH1RtaqSCPaFsRvJ5pwEnE7QxFKX4+LqyYXlxVm/UdQkwoGuLXWFaw9JTyjO6Nz3ScL0tcrGveovNr5FTwGt3Qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PddF6V6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2395C4CEF4;
	Mon,  1 Sep 2025 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719616;
	bh=drdbAkdFpvZAJ6wkGaaJxaCs0z5c3l+uoYeiTtWqED4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PddF6V6VqWIW97vOpKOtwh+Yhp8vXwH53jxVRDQZPAW5XlKfsuh6HzyfJnjG1lwcQ
	 6reG5E4eVE3zLDmhkA7qyZdaTB7dTNL6SYWadMu00ZHru00y5MMGD3RBYrtY3I3y4r
	 wO+/ax/JQc4CS+djRimqYjSx4S1MtIXP0tJshhzhJKsQ9B4+yb642EqF2b428X0EHT
	 0YBtZClpBp4awGYO4LpahThYA/sfRxdg91Wm4pmfO3ApK2gj6lR5WDIfe+ifsH9NWg
	 +KEOWYFcprstHVXkAkBNTH33OCn7cIokFqxwA6GU8LSyQG6TWnDSbyWvmHRiNpuH/H
	 GfScABwFMCFUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Sep 2025 11:39:14 +0200
Subject: [PATCH net-next 5/6] net: Add rfs_needed() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-net-next-mptcp-misc-feat-6-18-v1-5-80ae80d2b903@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
In-Reply-To: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+SDaulRT9vy5zXdtLFurruXTPo8//MkS7+WIicZWa9E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2Zr4yy+r+ErUyf26xge3dv1rSLo3bu/+IlM87bMu0V
 KZ6xV/pjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlov2Rk+LxIQy+j8Vn+ZsvE
 2VoXdr7eKpGU3iF7WHF7aeO8rIQX2YwMh0/HvfT/IjlXbGO79mK/g5eKu+7+5Ww5brZBkeemp2I
 SPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Christoph Paasch <cpaasch@openai.com>

Add a helper to check if RFS is needed or not. Allows to make the code a
bit cleaner and the next patch to have MPTCP use this helper to decide
whether or not to iterate over the subflows.

tun_flow_update() was calling sock_rps_record_flow_hash() regardless of
the state of rfs_needed. This was not really a bug as sock_flow_table
simply ends up being NULL and thus everything will be fine.
This commit here thus also implicitly makes tun_flow_update() respect
the state of rfs_needed.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/rps.h | 85 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index 9917dce42ca457e9c25d9e84ee450235f771d09b..f1794cd2e7fb32a36bde9959fab651663ab190fd 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -85,11 +85,8 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 		WRITE_ONCE(table->ents[index], val);
 }
 
-#endif /* CONFIG_RPS */
-
-static inline void sock_rps_record_flow_hash(__u32 hash)
+static inline void _sock_rps_record_flow_hash(__u32 hash)
 {
-#ifdef CONFIG_RPS
 	struct rps_sock_flow_table *sock_flow_table;
 
 	if (!hash)
@@ -99,42 +96,33 @@ static inline void sock_rps_record_flow_hash(__u32 hash)
 	if (sock_flow_table)
 		rps_record_sock_flow(sock_flow_table, hash);
 	rcu_read_unlock();
-#endif
 }
 
-static inline void sock_rps_record_flow(const struct sock *sk)
+static inline void _sock_rps_record_flow(const struct sock *sk)
 {
-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rfs_needed)) {
-		/* Reading sk->sk_rxhash might incur an expensive cache line
-		 * miss.
-		 *
-		 * TCP_ESTABLISHED does cover almost all states where RFS
-		 * might be useful, and is cheaper [1] than testing :
-		 *	IPv4: inet_sk(sk)->inet_daddr
-		 * 	IPv6: ipv6_addr_any(&sk->sk_v6_daddr)
-		 * OR	an additional socket flag
-		 * [1] : sk_state and sk_prot are in the same cache line.
+	/* Reading sk->sk_rxhash might incur an expensive cache line
+	 * miss.
+	 *
+	 * TCP_ESTABLISHED does cover almost all states where RFS
+	 * might be useful, and is cheaper [1] than testing :
+	 *	IPv4: inet_sk(sk)->inet_daddr
+	 *	IPv6: ipv6_addr_any(&sk->sk_v6_daddr)
+	 * OR	an additional socket flag
+	 * [1] : sk_state and sk_prot are in the same cache line.
+	 */
+	if (sk->sk_state == TCP_ESTABLISHED) {
+		/* This READ_ONCE() is paired with the WRITE_ONCE()
+		 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED) {
-			/* This READ_ONCE() is paired with the WRITE_ONCE()
-			 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
-			 */
-			sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
-		}
+		_sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
 	}
-#endif
 }
 
-static inline void sock_rps_delete_flow(const struct sock *sk)
+static inline void _sock_rps_delete_flow(const struct sock *sk)
 {
-#ifdef CONFIG_RPS
 	struct rps_sock_flow_table *table;
 	u32 hash, index;
 
-	if (!static_branch_unlikely(&rfs_needed))
-		return;
-
 	hash = READ_ONCE(sk->sk_rxhash);
 	if (!hash)
 		return;
@@ -147,6 +135,45 @@ static inline void sock_rps_delete_flow(const struct sock *sk)
 			WRITE_ONCE(table->ents[index], RPS_NO_CPU);
 	}
 	rcu_read_unlock();
+}
+#endif /* CONFIG_RPS */
+
+static inline bool rfs_is_needed(void)
+{
+#ifdef CONFIG_RPS
+	return static_branch_unlikely(&rfs_needed);
+#else
+	return false;
+#endif
+}
+
+static inline void sock_rps_record_flow_hash(__u32 hash)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_record_flow_hash(hash);
+#endif
+}
+
+static inline void sock_rps_record_flow(const struct sock *sk)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_record_flow(sk);
+#endif
+}
+
+static inline void sock_rps_delete_flow(const struct sock *sk)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_delete_flow(sk);
 #endif
 }
 

-- 
2.50.1


