Return-Path: <linux-kselftest+bounces-27911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F295A49C39
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC10E7A8457
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5A274245;
	Fri, 28 Feb 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQhO1PQ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CE27293F;
	Fri, 28 Feb 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753557; cv=none; b=J2EBDI7gQDrxYRggqcSj4r3/kRw2eihgf1qblaLSnqpnPW3FETE0Ogxo/TsPZ9Mp49rHwKI21PfcQULTmzMueiaJ3mSzSc+XbVp1MDtfc2NqfwZr/vxGr8vdKsSo8rERL9CNKPSfnmPzKxvVvA1zR3qCqfXmA/C8pbmoEMkeHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753557; c=relaxed/simple;
	bh=J8Tl2NKMo+qr7ei2meOGOP4gBjitzEyJVWkZmB4YUcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOzLDkCu0VPr+Pl7LVeDLr7Pf+MjoKi+wGMz5/VOCcLQ8CVQZxchjmOoHfdFoQ2DRov7V1vpTZpVLttmquizdvUuW9e2m/c1rs6qB0RRfxmWw7S/A3zHcj8HAfoGuPGnh6safCKkZ7ke3I9+SnkXOLo8ycdWGackoPF8VlsovIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQhO1PQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CEFC4CEE2;
	Fri, 28 Feb 2025 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753557;
	bh=J8Tl2NKMo+qr7ei2meOGOP4gBjitzEyJVWkZmB4YUcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQhO1PQ+4TjZ9Drewusd7vanS1n2Ye1bJhaffnbxhsWkx8RxlqqQ9zRbNCkOXEWqE
	 gEg4v70GbRmE1GuLxVaGyZ4HHF+WDyC0OmLVGbMRJ4Ae84vkpRlhah6TjRbRLlMov+
	 BFHGo/3e0QJ1ijBldNBUpA6s+ILczCHnXU2txFogQG2hT2ju/SPGBsTJo6/GzKswlZ
	 CkSnVkrL6BXFLa2P6T8YKzm3iSK5LqrZ3HCqS5g6cySsOvqGfNMGxpGQfYI2O8RwEE
	 spMwaPQEopuJS4JZRc3VxxUFXUWr7c1mF1jdDDP1/DYDp/z67L1QiPTClunJMzGQ03
	 MO4AqaNd0CL9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 15:38:38 +0100
Subject: [PATCH net-next 4/5] mptcp: pm: in-kernel: reduce parameters of
 set_flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-net-next-mptcp-coverage-small-opti-v1-4-f933c4275676@kernel.org>
References: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
In-Reply-To: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gAvAYApL2HJsNtessX1RPs02bE58IWJJTWitllsLOPU=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGfByoWgSM9DX9bP8UFav8hhqSHKVwNJpXMMEPtG83Owe+xWf
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJnwcqFAAoJEPa3gk9CaaBzrDQQAOzh
 kqIjMeZ4MDSuShXg2GV884zgDLnPfQLVFDnfgElMKwpzzRjsz9+NMk/RmsGsTZATcU73oh5U1TW
 BCvlF/gb1FEXG4sLQEU0L41ZXBWtqk0aT1rNKDEADLYprPKH8I2Mwdckh+pQ8U8F2Xy2JRAbhow
 j6v4+VCmtKN4EnGO6yeOI0nltXhctDyLAXQ6xDlftjI/42hPm3bAvKgYiYoELuB3wZodc/q227c
 Ev4vpwOXUB+1WvWM1yU/BVfO8gGU60SHaXZcM4VJglgMyCfp3ngy6GMxrMlZXmSfye7LS/ebgRw
 +t9s6625KaTzMqUaAUyzGDhG5kPoy2bYZb5mGCbdDZVgGkEeuKo+Xzxe6RuNhjUhcA7IWW4c2kG
 PbEV997sv3KhwuMzy5uEWf4Yy8BWIHkDuu44I0POFE9ZZ+YRWE6bS1hVYuokcnd2u6Z9f7qfcSU
 urlVzqyBLNnXQmop1vPdx3U9xIE0PK7g0XcfRJ0bMNQkOWnzA5RUe/zQhjP31gx5OsN9Yn22r8C
 PkJtT4NgfotNilt5pFAG5QHEM+4VXtLHg07kFAeM6A5fkDghO93XTHrwSdGNGvnT6M83ysz5Jw+
 aG6pykSoBwQ8ODrpAcjA0GZ0TKcdqAsRZDWlX+zkfpV0v8N6TVRLz80kySrKECelAeaw5Xdbsjp
 3dG9v
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The number of parameters in mptcp_nl_set_flags() can be reduced.
Only need to pass a "local" parameter to it instead of "local->addr"
and "local->flags".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fb83eba041f17c09923a8ed1a033983692962c5a..4bebc4963c42d481f041999ef8976a58889919d5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1907,11 +1907,12 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
-			       u8 flags, u8 changed)
+static void mptcp_nl_set_flags(struct net *net,
+			       struct mptcp_pm_addr_entry *local,
+			       u8 changed)
 {
-	u8 is_subflow = !!(flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
-	u8 bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
+	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
@@ -1926,10 +1927,10 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
+			mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
 		/* Subflows will only be recreated if the SUBFLOW flag is set */
 		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
-			mptcp_pm_nl_fullmesh(msk, addr);
+			mptcp_pm_nl_fullmesh(msk, &local->addr);
 		release_sock(sk);
 
 next:
@@ -1983,7 +1984,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, local->flags, changed);
+	mptcp_nl_set_flags(net, local, changed);
 	return 0;
 }
 

-- 
2.47.1


