Return-Path: <linux-kselftest+bounces-15706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3741E9574C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91BF284069
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA991E3CB3;
	Mon, 19 Aug 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fujYw9oY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A271DD38B;
	Mon, 19 Aug 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096742; cv=none; b=B8Dh3N6YhVRm82mTvG08y2KhPMpbwqcCoXQ9ReJ//ZLgRsKaO5hoIj6IcEK+7855luhEicL4CLvxXtzbwtmeHTTpknz+8FexHgb995HQE3V83GGnY5OrUAgAJ3aGpNcyhA23LWmIyEqpab/81+5gK9qotVPEAXXwyywf+p8InV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096742; c=relaxed/simple;
	bh=ntTt2Nf5fS/2mcfHtb4bPPKUjO530QR3Xzw6s0Sn6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELw1Il3R7vo6WrLgSsE/GGmYm99l2qyCzOmRz+f/Z5Gj0wuwJMN4IZCSqfMSNDRxp6fr5qPdBnDTKXjK9GcyadARZYUIIH83DjhJMfXdbXjT4dBkq1uC1PKGwnzFXRhqbFLryFf3SMFYeI9pDXpSimLc2CdIdu1DGYYnbNGFmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fujYw9oY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3691AC32782;
	Mon, 19 Aug 2024 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096741;
	bh=ntTt2Nf5fS/2mcfHtb4bPPKUjO530QR3Xzw6s0Sn6JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fujYw9oYtwKQaXF2thHrVzOzBTpbECxisUS5guS2EvWvV+Qp56YS/yrQ/h6c2FNlE
	 faEMuxJTKnniuPonAp/R2DZPS8QvcOMroVc+Nm64gFsGfp9smsfJdJ9gU0LR07iOnc
	 PeBlnGMAqWOgeE/G20v4L03HkmWkNQSUJ1k3y8yl8auPSBqO9FONG4L8/tHCUaEh2X
	 NCI3LFo/A3GlJ9N+y/yKqK1hPnBO0pYBJq65r3mO/6hwlG/LAzuw0lStu8Jqgfn+QA
	 u5mMyoSkB08wWAJUwr3eS67G12jYgosaggV+EJPRtsA2Rhjb702Q+wW9efOPZ28XqB
	 CPTaiiz0hv6Cg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:23 +0200
Subject: [PATCH net 05/14] mptcp: pm: re-using ID of unused flushed
 subflows
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-5-38035d40de5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ntTt2Nf5fS/2mcfHtb4bPPKUjO530QR3Xzw6s0Sn6JI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DScf67eUXQfJ6D+r8doyT+NgdgXyiQO8HrB
 vcVhs6PfM+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 c8XBEACn2aI1GQ0qKUKPXo4XvDgPuQ04vanm3OwwN7E3VRCQfQcQQ5jQkzMc3Gjyi6+chzBeQsH
 vyH+D20vvqXqGmzz+sH9MOJswVIvQ2ExEiaZ7pM0mfvDrr3ILdojpjKg4uamle9BpCoTKqHDTRt
 fiC8s5AzYdrFCeADxAUGBWRM6cuRH7946ZnfpXJIvH6X502r7INjCwmJCE3aZJHmzlePaFNvxu6
 /bG2/vS+jqb7WK+v9W0xFiQhNa/Kbe0xDKMWOhIROz3vYyqmBQ4dRVwsiKGEIn35KNABUy5zb3c
 1eD9y0UMXPY6OwhBthzP8Z0RV4EzqzIKMBUQANniONuz9A1yJIT1IgTjrU0WPst3svHfrm004OE
 Yop/8ovGXWldoR97rbM7RAMOUy7CYx/0cGnyVsPcsdEd0orfWQviIDy3SkkVPqWDeneOkavDHWO
 4LJbQbspJUkwSwDpnzHYKhZPlj6+BXuQzrXcCiUMU5rEOJW6ubvKRyTd2llLdnpljmEUVMZCikc
 bTH6cEisDzfJ9PYPV8mK8ghuxcuXC9qg049R2K98hjUY+sEzJ4DkTrOS5HX9+Hxymj9tXF6B+Vg
 QSfR3JpP3+djyeD/4U8Mdr02hV2aJwYL4qF59puDNF93ORZggWP1nVwIWFQna94GY37sGB3adLC
 5ix/zaQlOJlzPow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

Note that mptcp_pm_remove_addrs_and_subflows() helper is only called for
flushing operations, not to remove a specific set of addresses and
subflows.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8b232a210a06..2c26696b820e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1623,8 +1623,15 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,

-- 
2.45.2


