Return-Path: <linux-kselftest+bounces-28893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC33A5F087
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42DD17D77E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27A264F90;
	Thu, 13 Mar 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+xhbSkF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798F1FBCAF;
	Thu, 13 Mar 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861299; cv=none; b=km/fly8IBOeveywzYuNwc3spPEzuUCs+ztoyzZsy1Db50sjjAgX1IJqWdIBu1VhGkhM+6azdxs7GFQT6T1QkHAo7tmZrObGuzqy+HN71dtdzAkWY2CHbq5+S9rVkax6vKqChSsLadOv7dlcNrgG6HE/bddPjip0ww0CEAFavc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861299; c=relaxed/simple;
	bh=XJYoviCyRiisxNYLzayrswDE7DdaaQCIqUHpY/vk9ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKUfBmShGJsrjqwwFaHRY16Y5lFuR3SDa22uxhqjNo/1YpFZAlN8qHhV/xUaAj0I2z9uhFFG+23c3bOO5ghzYouUQI9uZeeXOf07107WrWmWNKfSuInNVZ9IIJiqzAiG2NGSUsdxzv35ehWEKJRxS6z/roaxIze9e/Q1qq2eNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+xhbSkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4344AC4CEF3;
	Thu, 13 Mar 2025 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861298;
	bh=XJYoviCyRiisxNYLzayrswDE7DdaaQCIqUHpY/vk9ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f+xhbSkF6F3rdD1ocQ+43DH10X9hcU+7giKRNyn44bFctcsEjWa/pgK48ueE0nTHj
	 4IZ7f/PAY0x2ACE7dGSUdDDfMdIhhbC+nSAwjbgDUfXQtiQuQIxw2WFItrbPz9z882
	 ps2YLZPuEe4sVlGMOf/72G6sygm/xl5aadSjxRr523RxsTkub1XICvENocvujhhBC0
	 zrEoYAptnMmj/bKDT3EyGUE40ehghsyREXxZTE118SS2QoG1N7MD3OiP3lWD8eMZ6C
	 xKPi2df9LJ8d/jWOaIaGcPTezli3DTEatd+PEQB02DWkdlfnyuf15+Y2oDcJ1r53yt
	 cn/OpsfChR7Ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:50 +0100
Subject: [PATCH net-next 01/12] mptcp: pm: split netlink and in-kernel init
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-1-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XJYoviCyRiisxNYLzayrswDE7DdaaQCIqUHpY/vk9ss=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGaMSh4OMDNqyVG+QuN2O0c9A/ZGBmefdFVS
 Su/Ct4Lm7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmgAKCRD2t4JPQmmg
 c5A1EACgj4ocDuDkl22qAgqp04unOYJsYjtu60TFhTcJfsmL1i4icF8YodueGrkZhvsG3au+c6w
 gckQ4h05Wuo7m5O9D6JaW4MX7n4JnZ03S3R39djyfC+0wu/lv5gI7Jf7+krnIN4RuYE58/CMIvg
 pGxSx0/4ZTfAgCgWJ+sIiMJFQgajajyoSSLwhFwmr1qb3aEQO7bsDH8h0gphIqWDl5iHVHp03/W
 ACPUCEBrgmrhRik9VT2x0HKxjzeaozLylrSy9t6WN9bl0g7oiWHFS+IQARibWGxb6iOvjuDNGXt
 OKrwASKkGDtw0yMMpZrvphKolhDowbVjL5H8EMs1JU9yUazk9GwCnePBDdWjMg1IDF9kuwyPaKY
 SQ+LLLbXU69sNu2zIqoTrFoUEPY53atm+81gQxxfBzI9TJWRUa+zX35tsm3e0Rl4Yw1wWj1jPLk
 0ncX3cedNu6YsYRQp+4dX4FTfdtFRQZKDWfDPP+iA+Fwvwyq2HJwG1iYAM6XHuJvkQxfX2fUWjJ
 ZJPNdUrRE16Iq7mYh3fnefTR9iHX25PDas029wIkhdD4tWbczG8bgsQh/uUTuLKPqpL7IYKffat
 Gr/qSu2x2ukjgIwc9RQZoAd2Fn0tRB4IOb8vv5u9G+67RDRvmTpVwnk8MhCSEZMMl2unljdA2lq
 JYk1IioW37zUeJw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The registration of mptcp_genl_family is useful for both the in-kernel
and the userspace PM. It should then be done in pm_netlink.c.

On the other hand, the registration of the in-kernel pernet subsystem is
specific to the in-kernel PM, and should stay there in pm_kernel.c.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_kernel.c  | 5 +----
 net/mptcp/pm_netlink.c | 6 ++++++
 net/mptcp/protocol.h   | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 833839d7286e717599579356af3117f70e39de0a..8e6a325a389803196c35175cd5ea7637624d0ee2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1022,5 +1022,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 
 void __init mptcp_pm_init(void)
 {
+	mptcp_pm_kernel_register();
 	mptcp_pm_nl_init();
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index daf8f98a316439a67c12f63f2388ef497dae08dd..62ae68abb2cb0066a30a3fab88ae5f082c523413 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1400,11 +1400,8 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
-void __init mptcp_pm_nl_init(void)
+void __init mptcp_pm_kernel_register(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
 		panic("Failed to register MPTCP PM pernet subsystem.\n");
-
-	if (genl_register_family(&mptcp_genl_family))
-		panic("Failed to register MPTCP PM netlink family\n");
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b2e5bbdcd5df920887ffbd9b6d652f422b32d49e..50aaf259959aeaf36e7ab954c6f7957eaf2bc390 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -625,3 +625,9 @@ struct genl_family mptcp_genl_family __ro_after_init = {
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
 };
+
+void __init mptcp_pm_nl_init(void)
+{
+	if (genl_register_family(&mptcp_genl_family))
+		panic("Failed to register MPTCP PM netlink family\n");
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c51b6a22d5e099c4486cc76fc4abc9a91c574c4a..ffb70fe08181815c23629354f78e3bdbe599e703 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1147,6 +1147,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 	return local_id;
 }
 
+void __init mptcp_pm_kernel_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);

-- 
2.48.1


