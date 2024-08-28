Return-Path: <linux-kselftest+bounces-16513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2532C961F77
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529961C22E40
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E2166F31;
	Wed, 28 Aug 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qechXARc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6C166F25;
	Wed, 28 Aug 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825716; cv=none; b=bXe44LA3z/vCUKvmIkUy4GPkmGX0VHS9JhJwGtMciwgkf3sE9+U7U0AnP9Nr+nCJv3ouUkv4YO0ZTJo5XCmwvTYpKoBaalc2qWXmqG7KAgFHz7ntapHCcpnF2c2zWKFHRn2KnK7OyY95RvfX45HaqhfT29drHuyXPmXrm/WMV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825716; c=relaxed/simple;
	bh=b9pW0NpN2cusaKPOAAILmTGRKTXjZXbZC7Jt+QGLOKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLGy1wmBtDznGmgHSkhHieezzAfRP5dAi702WhjejwdDZF/2pHvWQrBhOyuFW/j/oqoL1vYTAaoVO19den3WO/LVf8aMPKk8G4CkwvHgq0+c6IumUCoo/TLAsRNAhZvgAkYnHChTvkazgM6/LEKydDZgLTpCC4ZGlqH0g4Y2KsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qechXARc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30093C4AF60;
	Wed, 28 Aug 2024 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825716;
	bh=b9pW0NpN2cusaKPOAAILmTGRKTXjZXbZC7Jt+QGLOKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qechXARc72RwP5WqypQz+LbZExyOtRBLSg8Mw5zPsi26edVSSceGrDGWHzmkdXvbb
	 5sSmFbFVho1B0Ssn0fkZd6RuDtj/pmjvqbQV9Du+JejthMxdrkiQZZJdlVPphYFy3N
	 zPgzOEtyrlVKYpSHPIe1RmjafxKOOfHPiJepdga0zC5X/QDUH9Hc6OGU67whilfZDc
	 tWQ/RaXlWCClaa3k9AAauxy+r+bDJ9jWYQKnwzmqYtDdyR2Cz4ADesppszjj0InVIr
	 HekFEPUuX/Zzu4E+sIQ+mgyUYPVf0llDBlRXXEOlrQK/oH7R62XhfyfA0oGWLqE2LS
	 N93x86bOYrJ2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:35 +0200
Subject: [PATCH net v2 12/15] mptcp: avoid duplicated SUB_CLOSED events
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-12-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b9pW0NpN2cusaKPOAAILmTGRKTXjZXbZC7Jt+QGLOKY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHRJZiKlm9R7SfwCYWB6BvnEhZeFNfVfeQ9
 oUFpmAY18yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 czE4D/4qFNdxd4SHTu0rxIs1KQvDF2NOSYjGJI3+bkvcx4x/tyD1TihZLvcvpD9UllOv+A7L6bK
 qirDwvBwhxPh7Sg1JkvRMO0Uq3hXa9Y5BbU+zNsG+83MHdoRHmUddYNg9nQZqubuYK2170xgrJk
 jRHiKENOMeG5h/X2cWWaXev+zxTvvhQuugK5DjGXUW0ZRJTWB7Z8FrPCR1efzjuAWBotMVCmjs4
 KOATsV3CMeV4lAI3BNqSBl7aVakizmRPo0AW8mi1cY6lY2J8gHhI86VlAfRtPhuqHbWizkdRL4U
 W4F18XYHOk9iCC6kX56k+766Kl2QJYLAthIqlQM3CXHDwCMIps4dhFXGGOVA7E+YuyuIvjT6geQ
 HX2YNxYV4WZhpebQEpPkKYd5x6Te3x0v0BOBLrzyv4pm877qO7Tb7qoFi77+uf36/I7pK/MxrjR
 HpNJCNNVsCgiyoW7BkxqZE21tab3MJ70f7FwVX0dYzRIUkInCJ9CwOjoS8CCnY+R7mHjt8q/TgV
 F/3XSM2p584XaZROFgyoFPQ/bU2e1MCZpx5iv1R4T5mce1UwTcLjaA0wkPFmL4OCwpqB0eBuTrX
 snxsNbD1mHz6BPvhQ5s5hJIjldRNoCz639kIIzkJ8EdMRRIV7zQ4FmU7j7x72OwuyB5/NJRhDzG
 1bc+o+uqeBoyE8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b571fba88a2f..37ebcb7640eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2508,6 +2508,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 240d7c2ea551..26eb898a202b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -524,7 +524,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;

-- 
2.45.2


