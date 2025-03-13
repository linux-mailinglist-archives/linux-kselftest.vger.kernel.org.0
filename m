Return-Path: <linux-kselftest+bounces-28894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308FA5F089
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E2519C147B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152E265639;
	Thu, 13 Mar 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cePu+dHc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19D264A74;
	Thu, 13 Mar 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861306; cv=none; b=P52hYqTh3nYyDLJK2odbT9O31w1LKK+hVXdAowaD+KClG4ezHZzlYcb6ofL0QHtKAwiZiA9QyhRK8WNGSnsVql9IOr/t3SOVm9ihKdKLb71nyIgpxjaoY1Q8ljwkfYWQV3gT868ye2YlXu3RZC1KsIhgJh4hORYZ9fynzGQXJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861306; c=relaxed/simple;
	bh=32UPKDewotgZNZKsRYb6CV7jInCkNa88x0jv073sCDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhHQsR+EhfX/3nCFAzVVTXUTFByGLXHmvAcsxi6x/5OIOwqGJuuT8RKjxzMkwyIUQNANF1FQUgQ7A73CJD+sBJckW8qhBMIAItK8e0o5q7E3g6SbofIkPy0K2Z1QczE6Spkr+cfgR8IriqPT2KomSFFiN0ri/C6B1zIL/DCD5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cePu+dHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3002C4AF0B;
	Thu, 13 Mar 2025 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861306;
	bh=32UPKDewotgZNZKsRYb6CV7jInCkNa88x0jv073sCDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cePu+dHc5f8rXvXxNK/Xb2hCyb1kKTEOtYYVjcuA96J6lVY9zZz6FswesWnTOUEEA
	 tmUklB9ohS8kEYy0PMq/MRTf5sjnF1RWG7mjVB28qVvr0C+cDbdAy+WDwXzdtpiiyF
	 1v16lqgVYOVQCdXPyW45IbReOWFS2s7GXTzOgq5upqYqNwHB77CgfO5IoDYIP0cV1x
	 hdLZ5GpqtvRJ8gyHtyXjO190dzVGJsFFwMz6dJX6n2ufAVHKFNYWvGhVmAdyUN+6go
	 VlS3sY1wvYQnc/dqKV/CQDzhoqjktGoPPBGgyf5YiEbBB6w16AJ5tmPIKHEkj6ea8l
	 xU8s2vZlx1K/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:51 +0100
Subject: [PATCH net-next 02/12] mptcp: pm: in-kernel: use kmemdup helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-2-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O65qeAx5zjZUEHdX8kg332gnhPoA2Gjq34agpMfogHE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGaTZ7KzefJTwuvsq/iGYwusaT2hH2OmdpOq
 vJjdaTPMbCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmgAKCRD2t4JPQmmg
 c0m/D/9zg0gP50RjEapXNSiEL44GG50/o+D9+01Q8vuMK6hpQJzUa3tc9ZhGjum5VsPl6mvcOsD
 Q9vo5AQ5OJPi31RXBpRgyPFEhLA54mzvwGgAukh8WEysbIN9P2jXUS7v+yLZp+EiElkS6AWdf23
 NsRduY4ei8ZXhRSvpEOfolhSIipxeEPWhq1+P6SWEKEaKvwnr9iRtPhEXohTB/PBFju+GBXPU9O
 8+p6aRUGTW/EE8YsTf/XdrPkB2pY5d27Mpx3r0o3DC0zpAQPSP8FBvNrmpa0Y+xZlAXM7wE/PFa
 weIko+lvkZVd+IDDFqpOVfUDpGG4cP+uxgiu6EsJ2sQRAErFCobm8K2ycZ7CcU8EosEpobKrHvE
 Kcdd2YH/LJqY0NXNe4IstV+fVA7/hfdYkfwWHGCtGp5/9F21F2P5YzY2kPCwMzE1xr8UlO1fZZE
 nm6xXkAoLW+t5ICHHZtn1K61hbs52qUoZtP4bjAeKo1pqIYPBa0Yh5Rbl5Rx/qIXYGxBtj7Ilzj
 c5rNa50dQTLZi+F6ALTIxBIB76VDy4EGrxU/8/S9DvJTWSuguP0sokqi1XE4ahWVbIGCAqBMlOp
 2PlAvy2O9XKwrzHiPPol7whM43DASZAfm1GB9IIUsrDepWnMFr8XXtFv7uB5ggXAHAjydccSnHh
 n2kQKCAsMEt/i4g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Instead of using kmalloc() or kzalloc() to allocate an entry and
then immediately duplicate another entry to the newly allocated
one, kmemdup() helper can be used to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 62ae68abb2cb0066a30a3fab88ae5f082c523413..806a9b5b3c07a350c20ec7085183c26af9f50d44 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -710,11 +710,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 		return ret;
 
 	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kmemdup(skc, sizeof(*skc), GFP_ATOMIC);
 	if (!entry)
 		return -ENOMEM;
 
-	*entry = *skc;
 	entry->addr.port = 0;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
@@ -817,13 +816,12 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
+	entry = kmemdup(&addr, sizeof(addr), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
 		return -ENOMEM;
 	}
 
-	*entry = addr;
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {

-- 
2.48.1


