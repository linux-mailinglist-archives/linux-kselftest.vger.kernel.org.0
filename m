Return-Path: <linux-kselftest+bounces-31258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77254A9550D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3037A3DF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D16F1E5B93;
	Mon, 21 Apr 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB3E96zN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42C1E5B82;
	Mon, 21 Apr 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255293; cv=none; b=Ijc7dufRsIc+07QTkMSdmrZruhayxJ35Lqdj+NhQJ5KRTbYDzx24mVy1K6d48kJ5m5BoCwfDijng71xiORFO9Xkv/CQTjvhJUrHYwYky/xSZuGT5OY9mTGcSVhchB35D9x5Bn2GHmAiQcTwYm/CzghqCMLLI4tZVuPa/9DBS3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255293; c=relaxed/simple;
	bh=aFqGH0paYxGxHUjSJw30+gqhavTKRlHfTAmSY/feUhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TM1/5YahSv0lwSchwI/aiQCLRptCtH/syjE3DyXGuXw+Xs7M0BuMOdP2+NiE/93JCBDr8x0zBPQi95mtxkSVS0Mf7H7J1/UXyMgVSyfKxRo4ckqomYwTyIVnh+omuQNzTVA8m7RPlTuPH6jMJLw4CUiZbZFYIhzT+vD4NWBdNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB3E96zN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C1C4CEEA;
	Mon, 21 Apr 2025 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255292;
	bh=aFqGH0paYxGxHUjSJw30+gqhavTKRlHfTAmSY/feUhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IB3E96zNGsPSIrWWQpwDyy6vjnLhVLxsO3ylLubuDB3vAfi73esoOvLAzwIvCSpdn
	 XywG8B1E4jYgFcyqw7vA4YR14ymyKyXLny7VTN8J1qtR5iQaQ4zY6llrBmQCuZ48b5
	 BgJb2/w8w62/QRGTIP7FgTDn4HG9/Eu/nDdUIKY3axPtc9yBchEXA0bIj26Pi11H61
	 FJiwp009mu3/aAu5erFE2TYdhp8Lz1W6yIC9JdbOJKTzWQAwP2GJ/Og3SVoCAg+VhS
	 oZhMgS+v7H9VS47kBA3x8ydL6UPuuzBmCWqpCnzILKpXl05CeX8lALR0pcL3//PanJ
	 MGzxgWbSta6hg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Apr 2025 19:07:13 +0200
Subject: [PATCH net 1/2] mptcp: pm: Defer freeing of MPTCP userspace path
 manager entries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-net-mptcp-pm-defer-freeing-v1-1-e731dc6e86b9@kernel.org>
References: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
In-Reply-To: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hG631LGYz4PCLJEqqRwKqfnXdY9WVYg4k+smAbalb/g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLYqksPtKrL5IhaNZ269ibFkFvcd+bfwCkvdy9Y8/DMn
 8XZ7d80O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYS+5HhrxjLg/PbJhpk/Tps
 +HqXzk//ez3Lr/a4Fb7YH9dm2LlNUozhr8Q7Td0l21s0mg4s2PJS7qmyarIJQ8ELHQHxtFM50r3
 HmAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Mat Martineau <martineau@kernel.org>

When path manager entries are deleted from the local address list, they
are first unlinked from the address list using list_del_rcu(). The
entries must not be freed until after the RCU grace period, but the
existing code immediately frees the entry.

Use kfree_rcu_mightsleep() and adjust sk_omem_alloc in open code instead
of using the sock_kfree_s() helper. This code path is only called in a
netlink handler, so the "might sleep" function is preferable to adding
a rarely-used rcu_head member to struct mptcp_pm_addr_entry.

Fixes: 88d097316371 ("mptcp: drop free_list for deleting entries")
Cc: stable@vger.kernel.org
Signed-off-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2cb62f026b1f4420c549ab8ee6f54ffe3880d453..a715dcbe0146ed0c055d071c63257047a90a9afd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -337,7 +337,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	sock_kfree_s(sk, match, sizeof(*match));
+	kfree_rcu_mightsleep(match);
+	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
+	 * with allocation of this memory by sock_kmemdup()
+	 */
+	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
 
 	err = 0;
 out:

-- 
2.48.1


