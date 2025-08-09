Return-Path: <linux-kselftest+bounces-38619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EEB1F16E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 02:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AB83BAB4D
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317B15442A;
	Sat,  9 Aug 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peUYp2C5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045414A639;
	Sat,  9 Aug 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754698330; cv=none; b=oPIGVA4AzhXnLAQGHC0mvHNztEqUybHIl4/TP4E8vV3gsWsll3NVnCo5vsMNio/QYivYWS4EySrs7NeY2cgD7x7dV9TKMd0OZf1jVZxt396cc4S6Es4XFonK+2tupK7YJVpN6v0IB+xMdwQyseP+vW+vPd2v7356SYz9eI/41bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754698330; c=relaxed/simple;
	bh=sK+PdmujQcimk2c9Pz7lNXhG4fblg8DGTt+qtxRuyI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSSjJY/W0OkVGnJUefJz4RrUrQldWhvj1Qb1wjbEENYvOXx25MSK3NgEyXVfYWTRFS9BJxeR9tt2ngIUtCKeHmGbrcHwXO/yUq1KmudDEzx11PleX5fUxaBgMvFOuTItO3F5G+9nUMjsPU00jRJeZRwMFJQs+WgtF3eeN0pHuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peUYp2C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B7BC4AF0B;
	Sat,  9 Aug 2025 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754698329;
	bh=sK+PdmujQcimk2c9Pz7lNXhG4fblg8DGTt+qtxRuyI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peUYp2C5zK9rItLPflEAwxjkHfW7ZT2wZAyAVN48S/eWkFtwnFTtngYF7btUfwA+6
	 sky7HQdZThgfuWPqHBrilIEbu64c56iNT0nDrFqAqcinswGOsosvVUNobPlvWVmaFi
	 C0V07oTemNRP6xx7QQSia1YaHW/PwRpSLioecd5bpt13Hvsc8RSpeQKrah28xCV/ih
	 ZMJCspfCz3xcO6c60AnHp/1CbpgYx1JCEuh+m7nHMZl9Uw4g2oqz4H124i7MU7LnR1
	 8+BTVcdbQbQ+tthKws91HNQHra9eSrq3iA11GU9EOQrqLyKWjqtsjAXVDhSqdXs7iY
	 S62ltSlT6BCOg==
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
Subject: [PATCH net v2 2/3] net: update NAPI threaded config even for disabled NAPIs
Date: Fri,  8 Aug 2025 17:12:04 -0700
Message-ID: <20250809001205.1147153-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809001205.1147153-1-kuba@kernel.org>
References: <20250809001205.1147153-1-kuba@kernel.org>
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
v2: add missing kdoc
---
 include/linux/netdevice.h | 5 ++++-
 net/core/dev.c            | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433..f3a3b761abfb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2071,6 +2071,8 @@ enum netdev_reg_state {
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
+ *	@num_napi_configs:	number of allocated NAPI config structs,
+ *		always >= max(num_rx_queues, num_tx_queues).
  *	@gro_flush_timeout:	timeout for GRO layer in NAPI
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
@@ -2482,8 +2484,9 @@ struct net_device {
 
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


