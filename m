Return-Path: <linux-kselftest+bounces-4800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7200856C7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7121C21CDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F013B2A4;
	Thu, 15 Feb 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcfqZGyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B113B29D;
	Thu, 15 Feb 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021557; cv=none; b=Ao/haotF1lERtWwdybP4gCPrRVmvmWNrn4gGZgwQjXYWMjav64b2j7sF6356dZRbKcmPG6UDgueHfA9gIMublanHKZBK6wqiYqv+TafzrpmrHTx4gxFafTYoBkkunMghZ+vMJeSD8B+rTLZeLom5MyVJmyTxDJe178OxzPKF/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021557; c=relaxed/simple;
	bh=g7fXBxyk3jJrnTY6KxuB+UW8rqnCEuU0+GG9X+ksv04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjJVczpLRiA3R6MU6vpnCbKj3GHI6JQx27srChSNot/PAsjlHGC/DAWJf9bd+lj5T1blurl5dXIJPMNEqfz+oYv2uR/qrXwhIcuZPlv34AQoRmdEIFLffBEb508dcGWEmUn2FqVqVBAr2v3YtJ1zSUXc7BmQq1//uU26pGfUg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcfqZGyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A979C43394;
	Thu, 15 Feb 2024 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021557;
	bh=g7fXBxyk3jJrnTY6KxuB+UW8rqnCEuU0+GG9X+ksv04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jcfqZGyZLvtbM1PJwk7WBqIsm3ltcaTJcRD9X+ZRjAchR1bBA6AMfS11ZWNm3ydOb
	 fkjgAIkybNWaQSUmiGYmrHySXBukhS4PTI1HQTU/V2HQQgnpCZM8HWySwxrYGSMZvb
	 wocAhSvZCuyOIu0E7DeVKXbbECubkJpV+RGlZaxgNEKj1JIgjOrLtr/JEwpK0g5lCy
	 W8WUSyvZea5HF1sNy1JJlIEkLLpsclL3SRiKhB3qhpbmWiydIAZzEe4b3KtYf5X9cO
	 Cf61JeFKX3AvyktyvLx+n5yDnoGcG3DVH9iyugX8lbEMB0lfT3Wq9SftBNyRmQ79eR
	 SUDHRGFbkyy5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:33 +0100
Subject: [PATCH net 06/13] mptcp: fix duplicate subflow creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-6-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3034; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ws82kCFP+tNaGXtybdfXTs45hTTSHMXbFSuBqCwGyG0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdS6rUmaz1x4lw/43gIP3ya597R0wIip/bn
 86sZXUJotKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 c03UD/9T+Ps9qSZ36F+qV9NwB9r5qhdozBVeEKhPgZ+2oJlhCAqHVNQlOH/PnJOH/VSvyTckQaP
 kFSJEDM4ErR4sa6fxUnDq+gNtCxW/k+H75zmjxO6ScjNGvxUp32XZJVkYMux8GfnORkdjrIEU3r
 HS3wh0dPxyMoy7ceGchQzbN8AxufkuMQx0Vu65pLPUzKMP9oSHtYjv1Kutq2OLboYiHPSPTV7y6
 fQfgS4NVi6NOIVumJ62VLMM+lcDIThpGwfdiADDp2mj/Ru0yun9sD9wnOCnTKFACPTqc3RTbREw
 0KmUI7TmPwkHXLGf5fhMMJsTyoyF07aFIYh+m7USOnWDnoLkZQVmGw6AE/qeidsnBk0Sj9tagX4
 8m0Hqjg9oqXyjItTrxaQhrHXXrO1lom0BgEaIIHZ6FpcwCdMWQmma0KElMj2rJ78WGAnYbLnjQl
 jCjXBi75aCBg8MDtLtwOouf8Y5ZxAOLtMm5h3OC/k+MwJW0cDlrkovWA/zrM3fHDZvUyIgacbuF
 Rg6j62h17iswnIUQY2zXZw6L902ZWJoXi2QY/PKWLWO6WSIC+9SvJpYU7c798m/QqYsx2rcAvh0
 mIZgrRa/xgq20qZF758p+utxUKlJ6hZjnpD1l6XhCcmaQ0onoJb+ONFmbqNnlEkyCEcRoLLRhcC
 XRDbmqITwPjwFYQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Fullmesh endpoints could end-up unexpectedly generating duplicate
subflows - same local and remote addresses - when multiple incoming
ADD_ADDR are processed before the PM creates the subflow for the local
endpoints.

Address the issue explicitly checking for duplicates at subflow
creation time.

To avoid a quadratic computational complexity, track the unavailable
remote address ids in a temporary bitmap and initialize such bitmap
with the remote ids of all the existing subflows matching the local
address currently processed.

The above allows additionally replacing the existing code checking
for duplicate entry in the current set with a simple bit test
operation.

Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/435
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed6983af1ab2..58d17d9604e7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -396,19 +396,6 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
-static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
-				  const struct mptcp_addr_info *addr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++) {
-		if (addrs[i].id == addr->id)
-			return true;
-	}
-
-	return false;
-}
-
 /* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
@@ -440,6 +427,16 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
+		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+
+		/* Forbid creation of new subflows matching existing
+		 * ones, possibly already created by incoming ADD_ADDR
+		 */
+		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		mptcp_for_each_subflow(msk, subflow)
+			if (READ_ONCE(subflow->local_id) == local->id)
+				__set_bit(subflow->remote_id, unavail_id);
+
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
@@ -447,11 +444,17 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
+			if (test_bit(addrs[i].id, unavail_id))
+				continue;
+
 			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
 				continue;
 
-			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
-			    msk->pm.subflows < subflows_max) {
+			if (msk->pm.subflows < subflows_max) {
+				/* forbid creating multiple address towards
+				 * this id
+				 */
+				__set_bit(addrs[i].id, unavail_id);
 				msk->pm.subflows++;
 				i++;
 			}

-- 
2.43.0


