Return-Path: <linux-kselftest+bounces-5353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8486177A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1695B2569B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC81353EA;
	Fri, 23 Feb 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvgOV89T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F21339BA;
	Fri, 23 Feb 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704902; cv=none; b=UgQ4+Ii04giTtoRxApBBPd/71AbfvWxssQkr+lu2R+yB6fEyxjXRLVcqVvRBfAQVC0WOxe9kp3qbu6+IXSMdfFgI99bz+r7rX6Ow/FDnBhgLcb4tNDYKA6fGq8G1TjWPkQBy6jO+87ZpPGPaOwRZ8akKH9rV55CIfL9WpTUscF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704902; c=relaxed/simple;
	bh=PMAgnDXhRdjsNXlI4ncyw/rBYaRC4RspgOy+6WHSdWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f36yjnYO+ZWsNFYFGUmIGyRo1SWlL0w3q4enB67LR7F7N2Gir6oT/Wow61dHpjwP5tRkGM0k5IIRCMbCnOlT33RqtRmLeeT9q17j32wpckUnUWYarx3kyhXWkine/86odSf0NVB6CGP04W7tdoK+ZiDAHgPdrJyVJHK79x/F1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvgOV89T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A50C433A6;
	Fri, 23 Feb 2024 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704901;
	bh=PMAgnDXhRdjsNXlI4ncyw/rBYaRC4RspgOy+6WHSdWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OvgOV89TM45dHS4EJWpLaYraLn/38cckE4E+eT3MCuPy8SwYHyui++rb7pCzY5+S/
	 Oxh81DF7cNkEgKb7o3xNv0/s6ZCMZU59P+zYgF9RNAOPW0Ie4DjX4GtHHeWc7KXZVy
	 vhyTFkExltayTKpfA7EJez/XktuIvuVy7e2Iet6XG2KyxfFmT1KpB0VP4QnI7rVgNS
	 76pM+zysvpM3+dgoDKokjUJxzhTDpGnmoQUq1IbVzXhZc2+RKd2CenDnlKfuC993gQ
	 89/Qk8C90Q9aLpTE5L/N99QWj1T3vwSf48UM/M8Ip2FtwIEwD7kneSCgBQFLjnmvdN
	 uEp9laIZmgANw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:16 +0100
Subject: [PATCH net 06/10] mptcp: fix potential wake-up event loss
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-6-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g/43TBB3hrKxL6qqQvc2rdv93ajqIAHOvqscdy4uC4w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqCbiEqi91LPDSjON7evvjjl9b9JVJOG87I
 M1OsGNpSQWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c+w9D/93xfwHlSJBSVqSLBT0GCGAdy/yW9dEoRKB5dYOpjitE+UaPM6ahF4MDr+d0oifWMkOvsO
 d3gKJvtohzSE6ngKrEUVgXuDVaDhT4wSEq5mVAjdF5Y7Z27gHVB3CCkWwc8qm2OmeVV7nE7i37S
 Rz7rS6ISlpyFwu3mqEFtbN7+i8x/OPU5SuPHftYOsb6tjnIaLSXSNgNmKxDFd7iw0SMrORhwzMM
 1k/lixDMZfCPJfwacw1HAhMJfPhaVzWy+aJ8YYSOd4Q1TE4fegKjLpNttYITlUiJ0IEE1sd+xN8
 PwTSXDHXkTTPcBY5Bxukzby3/gka8zoawTTsh19TRXF0yUftyi7S+aGftlTgDWRZQvV4chTZ3+P
 EJ4hIyGQbDvjkHjPoBMOWjZpfAXmGnLJ3BXanibfIUMTTHE0BU1MnGWPERd1ONBLNrqasU0dVcB
 6AVr2TocXsR8mBRz9V5YR/Tn6R+MWSaggno9lCEFHQsP33zBi9FUCpzRxH6Nk/zQmDZwn/2bEh7
 8NRmVDIqjX16L5Ls+k0InABhdNaGM5UeqI765EXlffFKWP+nVPFC7cV/yDG0JgjpDz+vY/cCnl5
 h4P4sMJYRnh1Hgtl09CCB3Fcna1xoGldbRjF96naFtPHpDsTj6uLw3ONv/XRZUsVKqgDyL2SYvB
 46QX9oR4Z29LSnw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the blamed commit below, the send buffer auto-tuning can
happen after that the mptcp_propagate_sndbuf() completes - via
the delegated action infrastructure.

We must check for write space even after such change or we risk
missing the wake-up event.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 631a7f445f34..07f6242afc1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -790,6 +790,16 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline void mptcp_write_space(struct sock *sk)
+{
+	if (sk_stream_is_writeable(sk)) {
+		/* pairs with memory barrier in mptcp_poll */
+		smp_mb();
+		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
+			sk_stream_write_space(sk);
+	}
+}
+
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -808,6 +818,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
 
 	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
 	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
+	mptcp_write_space(sk);
 }
 
 /* The called held both the msk socket and the subflow socket locks,
@@ -838,16 +849,6 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-static inline void mptcp_write_space(struct sock *sk)
-{
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
-}
-
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4

-- 
2.43.0


