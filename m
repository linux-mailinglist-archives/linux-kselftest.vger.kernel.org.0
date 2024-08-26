Return-Path: <linux-kselftest+bounces-16295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE7A95F5B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD79328326F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E2194ACD;
	Mon, 26 Aug 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1TvMDvW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F6194135;
	Mon, 26 Aug 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687966; cv=none; b=dK+RaXS1Y6LBJr/8003T+I0icrz/TjvWeB3GhkZo9hJbpa3/pylgYbaRbzMqbqR8Aox4xz3V3wRzAt2YPn09S06uiErBoHcsNsYZ7BS979Na3N4HluiLZxfXBOBbumDxpRjNi4dtjtu+Q6chO4vTCCYZRBaXIGpHwt6NcJ7hX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687966; c=relaxed/simple;
	bh=eH+2wuCEf6ULWeN4oFAYdU9huILl507IPxdL4JUgAA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9kvxd8R+NMmB32hEOS3x/GmnUQ3wnawMQOS6niGkOJ7UslFqydoSBddkgyfpYKqUV9ULFhsqR0ql4UhC94Q7AaVSF8lgluPhlZnMWSeuamH07nYnyEtRFcfcW+LVMNvmhAb1oS6G6O0K12i44b2TN4PC59n7Qbmqji9ThU8Yz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1TvMDvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52463C52FF0;
	Mon, 26 Aug 2024 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687966;
	bh=eH+2wuCEf6ULWeN4oFAYdU9huILl507IPxdL4JUgAA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r1TvMDvWlNypBpzpJFxfrLqVGgMEemIsW62Kw4dF+JmKsojS6/B0aBBB/U9xMSues
	 iV4UgTHqXoC+zk4YZ2qX8/uGQpS5v1GeXsJuZqeS04plrlqnyI2WAz7A8njJ9sgBlQ
	 VgvnxxJqo0Yo5wA3o7xajzlzUL0xrOUuGlqTYVtFNGmYP8hFm+gYpe6dMa+aX8Elo7
	 H/1jzrt8w0egg53qx8z/uVNVItmU3UXhVss+YaVvXcqBmBzZg/a1bsVR96pJfJXfcl
	 t+Kz2jhIDsgqfKL8D1LpCSdewtJsftqaR70CkCB7tCsLDgrPnOSzKI1JEBfdWyQI9H
	 QiXESrsNNUh+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:00 +0200
Subject: [PATCH net 01/15] mptcp: pm: reuse ID 0 after delete and re-add
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-1-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eH+2wuCEf6ULWeN4oFAYdU9huILl507IPxdL4JUgAA0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWN1RjCjLcUQt47le15GvR8p6uXCKDOYRtR
 wLC94BpQ+yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c53wD/918QDlMD8wY2ISMeYjOw/6pBVwMWJu52U0EzyImG3dhvqU3o16FOFdpZ5pQ7d2kgfc4dE
 ZuV9dJKE10IOfOk16HyUASK48drOgTO7Ge5RiCVryIhi/9mfAZ2hTGvBbjnHjEEoeSkuo08FLqK
 SF4cbBLdC/kjrvKWBs/CfCmMnoYtbwM5WK4+3J+IbUHDNihRvxJ331y2GdRoAndKcl+Kex38FoL
 YVm9CZtWZOQ0GWcvEl6DYyUqTpCEwfylnG9rJ4UvhAmNM8xsfcwoqRhhY2kU5ml6Y9eUFKwATeJ
 +7lyyoa5ecV2EsWP0RMQAqMcbS3Sj4AIQ0uvyjq2X9I2OVV8gaq3ngJ3434ULUaeoSDUS0G88+N
 td9dcIx77nQkGOymwD3P9YSi+M6rtN88pfvceYTr8X1uEjOdoKyIDJ+d3/neRORrQajqNu7uPCM
 E47jLg2Y5azsQNgjTbg8ESgwlAQTECoamJwwY+0fiVHMAjDKi6kuujFaUfG0iJTpKAOSphGFyIZ
 mEe93QmjYU5xCscj3yNZrcHzCMBIaFUzdfhqgtkg36aiFzFnVa3UJzRFGNFltHvt5+/sYcK8igT
 +RGR7BPt3bQvreJQt75tAQLnygMRh/91WqiPXTrqvDUJhNmcD/Tu2egsMTjbyNMKU09vUNzrwWD
 cK7HPTfvs6Hp6wg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the endpoint used by the initial subflow is removed and re-added
later, the PM has to force the ID 0, it is a special case imposed by the
MPTCP specs.

Note that the endpoint should then need to be re-added reusing the same
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..9ee68ab4665e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -585,6 +585,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -609,6 +614,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;

-- 
2.45.2


