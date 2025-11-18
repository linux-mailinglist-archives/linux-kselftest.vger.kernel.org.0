Return-Path: <linux-kselftest+bounces-45836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC01C67EF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 792AD4EF2E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C7306B10;
	Tue, 18 Nov 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+/BqPOB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDB3064A7;
	Tue, 18 Nov 2025 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450472; cv=none; b=Nz4Wazl5Q7x7ZLKZJYcqKKUvdfOyASn+hRsBKEcrowuTz2ywG2r5eY45s4sKClmt2KzfCcAXOhZViGANKYwKEwYmCzhDVrkbqstwtpliKQh3MmWIoskHSD85t47FUFgLS59BN9uc+Tfq/KSwQZGwWZJ8y1cNSnBTHRhnVouKvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450472; c=relaxed/simple;
	bh=rN00PkD+rofdzTv8Iit9dTRPmFxKtGBef6EoZRFIrd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5NFAE5LRInFhc8gMXY6+tcYOl/kqL4IslUjGT8dP9ZIxMLfeovgqL3NRdDXGIpsLhJrGb4ZmNS4W2f/Rr8i14SMnLn3AWsAalbpH+DSl/3zjDBWw0TApE9h+3QdtHTMnnOJq2i4n2ZRp05pPffVfq2I4Gbp4wJzcQCAPC78ZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+/BqPOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53371C4CEF5;
	Tue, 18 Nov 2025 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450471;
	bh=rN00PkD+rofdzTv8Iit9dTRPmFxKtGBef6EoZRFIrd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V+/BqPOBPN4z3AN9Qe6yM45N/xqBSvjYf5Nv3kwSRQFerThqUY6Egg1Dg3cdx1RSc
	 d9C1GvZ4NZSdxAdJf6gTnMANISS8OOAZbWlDB337wRbhRGx6QY7szxukcdNloee98t
	 /OoTmRGeE1iJCPaPY8RsS0OFUcU1Iu7UVXJDEjAvqKA0AumYHEQ6lxeoxQArn6Sxvj
	 037dLKGPXB+TPDYGyCdpCg4vnnQ0WLM29npJ5NRS/2LloXbSXfhWYRliquADXd11Qq
	 e3DY9wpUPsTtRRlJ6eNe48t6zzrHbqAwkC69mwaGp1hXVz55n9a26CzZ5lZzly6xbS
	 yVkv71SWU9mCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:24 +0100
Subject: [PATCH net 06/11] mptcp: fix duplicate reset on fastclose
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-6-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LYEAjFlwBNcLPv3BhiEyg2jvdxLL/0HMlIDSK6hafA4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5HyKTn8tiF9WsZs36gT/BoXVO5hvWik+uFK40ecUc
 7j+9jaPjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkoRzH8s9YPzTot4sQ+mz/s
 lkiv9OdNalccYy09Ll2c9f3ZfMF/Hxj+pz07rr9XInXzhtDjkUzFrrGLZQveTtBojQ2V1mJ9yVH
 ABgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The CI reports sporadic failures of the fastclose self-tests. The root
cause is a duplicate reset, not carrying the relevant MPTCP option.
In the failing scenario the bad reset is received by the peer before
the fastclose one, preventing the reception of the latter.

Indeed there is window of opportunity at fastclose time for the
following race:

  mptcp_do_fastclose
    __mptcp_close_ssk
      __tcp_close()
        tcp_set_state() [1]
        tcp_send_active_reset() [2]

After [1] the stack will send reset to in-flight data reaching the now
closed port. Such reset may race with [2].

Address the issue explicitly sending a single reset on fastclose before
explicitly moving the subflow to close status.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c59246c1fde6..a70267a74e3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2409,7 +2409,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
-#define MPTCP_CF_FASTCLOSE	BIT(2)
 
 /* be sure to send a reset only if the caller asked for it, also
  * clean completely the subflow status when the subflow reaches
@@ -2420,7 +2419,7 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 				       unsigned int flags)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    (flags & MPTCP_CF_FASTCLOSE)) {
+	    subflow->send_fastclose) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2467,14 +2466,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_close path
-		 * to generate the egress reset
-		 */
-		ssk->sk_lingertime = 0;
-		sock_set_flag(ssk, SOCK_LINGER);
-		subflow->send_fastclose = 1;
-	}
+	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
+		tcp_set_state(ssk, TCP_CLOSE);
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
@@ -2779,9 +2772,26 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
-				  subflow, MPTCP_CF_FASTCLOSE);
+
+	/* Explicitly send the fastclose reset as need */
+	if (__mptcp_check_fallback(msk))
+		return;
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+
+		/* Some subflow socket states don't allow/need a reset.*/
+		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
+			goto unlock;
+
+		subflow->send_fastclose = 1;
+		tcp_send_active_reset(ssk, ssk->sk_allocation,
+				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
+unlock:
+		release_sock(ssk);
+	}
 }
 
 static void mptcp_worker(struct work_struct *work)

-- 
2.51.0


