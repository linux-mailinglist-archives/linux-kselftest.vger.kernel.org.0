Return-Path: <linux-kselftest+bounces-15704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F769574BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E315B1F21EC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708991DF69F;
	Mon, 19 Aug 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRL1PwuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED91DF699;
	Mon, 19 Aug 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096736; cv=none; b=P0+CDQO1T73LqOgdL6cfSnB0tMAqsn35IIiDzfMM5wlXTidl1yGzm+VOsDWi7urmW/qxLoPeKB5OqZjuGDArydVrbkzXo6dNj+d0ZVuaHmJqXRxJ033r90AqZ9QPNVtoZJ1Sp735R31MWxMPlVVrE0AGel/qqPI/o6zxJP7w2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096736; c=relaxed/simple;
	bh=e6zkinGzyHZuqufn3PvT5I44EByDELDaTnVXsfjtp50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGETt2O19VtkttU6Xs33K6qcSuVkyD1omIWKOVgxlCPqINObmyqGzQIsXQcK9q9LZWHHENiRHklCTGwldrk4mWi1iJwM5iayeOF3K/J6/KhWse9Xu2Xr/15zOaTcfIkbsibYKT/qV7Ams1kx+bb0WkoWI3Zw60DTXJ2MW0HDtho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRL1PwuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED96C4AF0F;
	Mon, 19 Aug 2024 19:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096735;
	bh=e6zkinGzyHZuqufn3PvT5I44EByDELDaTnVXsfjtp50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XRL1PwuQWpABS9nJVMXetS91thZG8KLYviygk4BpkvTd755ruwXBmSYPTEijPT86/
	 qi5ClvqWNK2cYSe4xQRF3n72aXO4VZ9hvsQxLUQhDmGodF2vbF/Ttdiy+pgAgS3LBW
	 2E4831pcze7r2oU0jiyj8/TQ+cOGhjTfkO8kLL2x0Ppp7TK0s8fe+3OQshPXlMwPDL
	 ynqN+QgVp/gZy5+Tp3PAFbNB5PVbRIZevjs2Jtg2p9f7rvXNpKiRdcBbbJDFkHxHt0
	 8Nvwb3uAcckZXvA0rlXMKncQ6mh8NZ4gVKObH2N9LOxTyNVQ8sM4clilYZsPd+bFlY
	 j2z/FjoQUcKkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:21 +0200
Subject: [PATCH net 03/14] mptcp: pm: re-using ID of unused removed
 subflows
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-3-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e6zkinGzyHZuqufn3PvT5I44EByDELDaTnVXsfjtp50=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DS3O6nMV3haSBgRiDbVkjH5T4nwrxXX/G8I
 H7swPv/0OKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 c9QVD/9Y+89LmOmjArCRkXagsmPAvAIQD/u7kGfMS3oB0FsFbh9VKiuijgpeZIKWUbQZV1M/H11
 zN67MjgTgKGp70S6bC2QQwVgefON749w8hsKnAsApcaS7UwekcNRBPXZLrASDM1vIJpGyzfH8yt
 zmTajTgEpmzLiO5I1ymahXbQ1wJjYVul67/VbN1Ez+6SOXssEMeHY+aDbAH0q1nqlS4ZNV7S+Nl
 56wNu9T4ZFFnHn2R9I3m3u7ByJhPQ3C7uYHCL45v4WalNakKC5tkuHPlYo2EUmzOYDX+ASeXwSw
 assbEOAMJt2MYGPP1Lj1fJftL9M1ZrUjHrS2py8Xnq19RjYLohBU5+LfLP19QZMFpLoQhj+XHMv
 HA3XpSTB2tFeyLhjUVFwZQsolYrTgRwOX5ogZoyB7cxmFsRpnb5udGe1bNh6o/TLWeZFnW7YdIn
 jjMgVjCaBgxifUQappPvrgGEs69E944/0eHIlnUR029ZBni30g6ZuWgk73LUA4MdZyCPiAtvdF7
 40YroNQuRbvuGYiB0nGGRsVBn8Y612iuCsObG2PqCDeGT6vuKubCgPNAdjRkrEFimuvavvtmyaB
 xE5qT11qB7UBurgtHeX3o5JSc7lb56iuhlGkWLgiyW9qoqAivPWYgiMsvaznG7Sq7rIAg3fH6kc
 osXKAXmz4bElLbw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'subflow' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the 'subflow' endpoint if
no subflow is attached to it.

While at it, the local_addr_used counter is decremented if the ID was
marked as being used to reflect the reality, but also to allow adding
new endpoints after that.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 26f0329e16bb..8b232a210a06 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1469,8 +1469,17 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-		if (remove_subflow)
+
+		if (remove_subflow) {
 			mptcp_pm_remove_subflow(msk, &list);
+		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			/* If the subflow has been used, but now closed */
+			spin_lock_bh(&msk->pm.lock);
+			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+				msk->pm.local_addr_used--;
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
 		release_sock(sk);
 
 next:

-- 
2.45.2


