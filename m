Return-Path: <linux-kselftest+bounces-38537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E1B1E04E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E8A5827D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F116F0FE;
	Fri,  8 Aug 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIG6F0FJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE740158DAC;
	Fri,  8 Aug 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617808; cv=none; b=iMSinWWk8fKjh2SWhwRBeziZFAV+X7muwe6v1yZI1fOrkWhlWGG0bKWPYd3MjsPSiEcrKBUNGbkNL5WFPhJkYDZuHENB0HsLwU6k+rmRcgzOdF4Zh8LSLaOFunlO9vWes+cARrOCZQZXeOL/GUQO//RhX1WOQHBgFVuc8jFoZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617808; c=relaxed/simple;
	bh=o0t1kKcCnAvEDUf3xvJwZSBBDcXAbuRunO1YZAlgXVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7Yg9RuiBupTERvNUyUryLsuotaaphgy4yNgPDSYamycsovRL5RP9qYJPkJcD/H36vHp8EZnf7gae6jqhnOw+cQXeye1Knikkv74sYM5snLMPN5JCIb+vdzUf02OdLpjNT/R5aMzRTXqwW36rOO9b4Z6o9BraQQGRCkOiOm8kgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIG6F0FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF7C4CEF7;
	Fri,  8 Aug 2025 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754617807;
	bh=o0t1kKcCnAvEDUf3xvJwZSBBDcXAbuRunO1YZAlgXVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIG6F0FJ0F+14owIYqAFec+PcRFTDGP8f6JDZn8TsmG40O3EH9XLaHvr11qHONmN/
	 ZOi3SkVAj/58VWOhO+Qgtt21fNmw7d5cFjXTTVtd2u8ECQTgwQ2CztQbNMwLmKMQ1R
	 DGbmJjYBBZLL1boqQUXxbRVK/NS6tB7L0aowYpMXe42ZQwPKeXR9LiMpsNUOBbR/SF
	 A+tTrtgdoweKUJRC8FKo85i7SiZ7E4FK6G3aBv2F/p4CcYgKZxNps4C/BWLSZiFBpB
	 TeE8el7yrvxue2wVoeJKAsdovCi+Z5vDBXacQWFrSRoMg1kbm+0XG0/NjUeBjcbFhu
	 knPzQI+QpG3Jw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	joe@dama.to,
	sdf@fomichev.me,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/3] net: update NAPI threaded config even for disabled NAPIs
Date: Thu,  7 Aug 2025 18:49:51 -0700
Message-ID: <20250808014952.724762-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808014952.724762-1-kuba@kernel.org>
References: <20250808014952.724762-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to make sure that all future NAPIs will have the right threaded
state when the state is configured on the device level.
We chose not to have an "unset" state for threaded, and not to wipe
the NAPI config clean when channels are explicitly disabled.
This means the persistent config structs "exist" even when their NAPIs
are not instantiated.

Differently put - the NAPI persistent state lives in the net_device
(ncfg == struct napi_config):

    ,--- [napi 0] - [napi 1]
 [dev]      |          |
    `--- [ncfg 0] - [ncfg 1]

so say we a device with 2 queues but only 1 enabled:

    ,--- [napi 0]
 [dev]      |
    `--- [ncfg 0] - [ncfg 1]

now we set the device to threaded=1:

    ,---------- [napi 0 (thr:1)]
 [dev(thr:1)]      |
    `---------- [ncfg 0 (thr:1)] - [ncfg 1 (thr:?)]

Since [ncfg 1] was not attached to a NAPI during configuration we
skipped it. If we create a NAPI for it later it will have the old
setting (presumably disabled). One could argue if this is right
or not "in principle", but it's definitely not how things worked
before per-NAPI config..

Fixes: 2677010e7793 ("Add support to set NAPI threaded for individual NAPI")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 3 ++-
 net/core/dev.c            | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433..bfda1d7b9ee0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2482,8 +2482,9 @@ struct net_device {
 
 	u64			max_pacing_offload_horizon;
 	struct napi_config	*napi_config;
-	unsigned long		gro_flush_timeout;
+	u32			num_napi_configs;
 	u32			napi_defer_hard_irqs;
+	unsigned long		gro_flush_timeout;
 
 	/**
 	 * @up: copy of @state's IFF_UP, but safe to read with just @lock.
diff --git a/net/core/dev.c b/net/core/dev.c
index 68dc47d7e700..f180746382a1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6999,7 +6999,7 @@ int netif_set_threaded(struct net_device *dev,
 		       enum netdev_napi_threaded threaded)
 {
 	struct napi_struct *napi;
-	int err = 0;
+	int i, err = 0;
 
 	netdev_assert_locked_or_invisible(dev);
 
@@ -7021,6 +7021,10 @@ int netif_set_threaded(struct net_device *dev,
 	list_for_each_entry(napi, &dev->napi_list, dev_list)
 		WARN_ON_ONCE(napi_set_threaded(napi, threaded));
 
+	/* Override the config for all NAPIs even if currently not listed */
+	for (i = 0; i < dev->num_napi_configs; i++)
+		dev->napi_config[i].threaded = threaded;
+
 	return err;
 }
 
@@ -11873,6 +11877,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		goto free_all;
 	dev->cfg_pending = dev->cfg;
 
+	dev->num_napi_configs = maxqs;
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
-- 
2.50.1


