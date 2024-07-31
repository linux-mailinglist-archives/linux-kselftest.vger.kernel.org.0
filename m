Return-Path: <linux-kselftest+bounces-14534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E614942CC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D71F217AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8B1AED55;
	Wed, 31 Jul 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyXPVGwE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBF1AD9C6;
	Wed, 31 Jul 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423986; cv=none; b=moS+5P6DqM7pQgh6mWhNJUpAWY7fjXqyNmtGua04F7EgQt+7pbMJedlvlLgcbr6xadATgsYvngkBej34ToMtGFwNIQtFnXzkrmnax9jMb6y3tiWGvSP5dsQgvc3wVrnnGSTaEk/awiHbOSG51P42N5bQqAtIgSTihuOCA0hCMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423986; c=relaxed/simple;
	bh=ucPLpyidAabxDmr1HFVxowabnIMprlmWSuibzybqmAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WP1ogo+ROg9PfA2f060o+ECfz43Tlai3lm7LxW0yjVUmXAw4iVQ0nlxl0Vlz05vFX2m7po6Orv/9CP4q6rcFZd6N4FAYoQLrkqB8bT81cuJJ5JS/1J4UdAujv1dHILcPDFpn+KOl+JCCErJtNl16sAdfCROWEUxh+9hWm1IyvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyXPVGwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF3C116B1;
	Wed, 31 Jul 2024 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423986;
	bh=ucPLpyidAabxDmr1HFVxowabnIMprlmWSuibzybqmAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AyXPVGwEjyG6x+3m+yBeLcssWdtZx2ABrkQYAA0Fm7BFn+BV2znAMxYk35LdEPXyQ
	 MckvKrBJ/qtHrWeR4onoYTm7hW+HCcyAdUmn0QURcJcABGa80cmPL2pZan5Ytev8k1
	 94tY4dobSSLKeohEjI7jyzgdDPL7icn6gt7sMxf/H4icIGV+LPCL1lAL4zwOxDhHAk
	 RYbx/V9cZ6CDsuFQYsm/V6equZ4Cxt+3NYShC6u5EOPHV4mFtu6tgwocSciVWddmX1
	 njFIPM06MDqITCH71qy59vPnhM0cQf+R+6THxRK6H3VFLjMq53URlIfeCclPAjrMfM
	 Zk4j1aiuDFV1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:56 +0200
Subject: [PATCH net 4/7] mptcp: pm: don't try to create sf if alloc failed
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-4-c8a9b036493b@kernel.org>
References: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ucPLpyidAabxDmr1HFVxowabnIMprlmWSuibzybqmAA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqiEzR0/Bx3PYsDk6c9qKT1TOf03HKnCKWrW
 Cp4i7OpwJSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 czScEADD382M04ZC2EZjc7pwk7OJrYE+/GJgo4BQnBAINQofX8YQT+krva4UQS6haHZ82kfqABO
 H7VEUSRBeu71jEGsp2CwopTcR/gRr20BBKyOOAAmY9nA9Ti2uMFFzOt6UFz7PQN6X/8i8jWfMGz
 M+Y59imDUwedWHR4eZ1a2KazMmcm+Y4Ly6ng+RcVNYD8eI5oZAOpVP88IOJUe1oa0sMB5PCfON6
 cJPZVooOMsIz69eFJWzkWN1vEksvNHZ2ERkCga+dJjE8AmezLISVbonVyFOdtrnKb4/pMyK+xlz
 6P49u9GLh11YZOiUPeSaARr1dnFeYbZhxqFi4a2IXzCHbYsWF0ObCDGFPjDZPx/Lsrvp/Z56E19
 vIerovE3Y1g8YklatplfGvTbwTtZHbriakjhJ9Vl9C25siqJR5tVmKRTCNH5bTWUH6eH4jJ3R+W
 gaFyz/gZmoxTKqiacZW4GyYIhvY1et9KJLH7J2ihTffK9XQHCok2Yx1BRzeoKlApx91Yxo0QHiu
 8BkszTlx2b2OOudk913MIxmaKYHdWvA5FbDsXBZgrBk1Xgicj9vYLJXsp/Wn4nmjilkMJ/LTQBn
 sPMquwWb5eMWpaHfikM0xs4Y09eHAnwLa/yaFgEQTW1EB7UJLeoNd3LlgrpIo+Aa1DVkddkWTfT
 5bTgstTLYFGt35w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It sounds better to avoid wasting cycles and / or put extreme memory
pressure on the system by trying to create new subflows if it was not
possible to add a new item in the announce list.

While at it, a warning is now printed if the entry was already in the
list as it should not happen with the in-kernel path-manager. With this
PM, mptcp_pm_alloc_anno_list() should only fail in case of memory
pressure.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 780f4cca165c..2be7af377cda 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -348,7 +348,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -555,8 +555,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -567,11 +565,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
+		local = select_signal_address(pernet, msk);
 		if (!local)
 			goto subflow;
 
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
-			goto subflow;
+			return;
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;

-- 
2.45.2


