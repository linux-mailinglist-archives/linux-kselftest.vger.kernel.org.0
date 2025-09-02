Return-Path: <linux-kselftest+bounces-40654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4129B40F1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D95701062
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD935AAD4;
	Tue,  2 Sep 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjLDBHmN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F535AACC;
	Tue,  2 Sep 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847521; cv=none; b=EV5AxcmcqO5spo9vS9GQr9HjpzztgEGXcOFxWK4N4j08sYUM8WWbe0D82A5nsk8fDDo7mr2Zah2n69YJgOJzmoiulMu9Md0ZUfuAToa3gxsKPLZoyWt00eSGKku24aFz8NDIHWMl0SnX5fcyNTnjdKPTwkRPs/1HHL/kaOJ1Vfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847521; c=relaxed/simple;
	bh=QWEeyydJNsvze58/VXuVLfkDwLyhW9ikxYVMzbLVxSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOJ+5ZPP7cTlHTZzFIOI9L0w6ARQ6M/xbH6Xegcwp/+aRJVF50Il5eKzzbbnskBqv5vogpdQHA9c5u3v72pORedazv6lwf8xjYGE3LLtMES9pSq8Y801NC6fleRPlcNnl+9ZqPR7rK/9BN5N8Mvmie7UzgOcsrhHrIRBk5qIwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjLDBHmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853AAC4AF09;
	Tue,  2 Sep 2025 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847521;
	bh=QWEeyydJNsvze58/VXuVLfkDwLyhW9ikxYVMzbLVxSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HjLDBHmNklBUpTPiHsz5Lly6McFYph1lu9FotzR+otYiD/1BRwBXfZu28UGVDJ8VV
	 fbVG+DuyZ4GKTVbL3QjiGIf2JY+O0CeL1086LOuWti7kwYwHnqn4nMh4N7XYKcrbA1
	 v+s1FH02o/hXm6K9i81DQUQ07gpLTlrfJQGPfA5lwxhchtqBklq0US2yqCCMzOMnsj
	 nZ7+uqo+S3wA8ogmnZwrlIw0YpOboh2iXC30UK0bbhXcb7YiPe+cbFkjcyJKue3Wh7
	 N0Kluro53owZEflyQXLIyJpJ/qdtey8lHG8rKjbM5WlyOnjdmhIpRy8o2hjJFhnMQ7
	 bprXwwcdlYXnQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Sep 2025 23:11:35 +0200
Subject: [PATCH net-next v2 3/4] net: Add rfs_needed() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-net-next-mptcp-misc-feat-6-18-v2-3-fa02bb3188b1@kernel.org>
References: <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
In-Reply-To: <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/xEF+Yn6Gngp+jxk4ymxVk3ZRYSpju3Y/fcC7uXVS2Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2x05+3WB66YiP6L7G2YvfrtLli3kis/Hewu9JbC+Wn
 Vkyp4TVoKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiZyIYGb6FfPdU6rk8Qdtr
 ZVp0FEP9K+16k9fnjjbZntzubR9UvZqR4adLgv3KVGW2j1F8ll9X6ES0LblzLrjonEzb7k4m0ec
 7mAE=
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
2.51.0


