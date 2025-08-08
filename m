Return-Path: <linux-kselftest+bounces-38538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E46B1E051
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F579188D2D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558017A31E;
	Fri,  8 Aug 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEWN04P5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B817A300;
	Fri,  8 Aug 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617808; cv=none; b=iCA8511x7zmD7sAPedDQbdlbKKqW4WiLQh6MwJ3prtzF30QLRrb2B8LBQEyOD511D3Yz+LAaEdsV+beRMdzFqiMHqDOtecxiy2YlTi0p4QwDbxG3wBfUdOhSeam2daHGMv0wqWyys41sXemdUPzBmko1DaVFRzTgDK6smx1Lne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617808; c=relaxed/simple;
	bh=/byPVV+VMNKmftJfebXwe65jG0gcjrDuEVrZbGQmN7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgvsJeAR/J+lC1roDqxBvl2NsxOcRL0e696iQgyoF+mhiHwPMPZSm8P4g0KWCfsQJBZA4gSn22e34a2qbLM76WfhMfMBQHD9DrH45dPNvSEA+Hk1IxckCnxgiDDxN/rg/fl3ebDFgGZzldBch043smkZ8J5XVFFWAft35wqRUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEWN04P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B12C4CEEB;
	Fri,  8 Aug 2025 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754617808;
	bh=/byPVV+VMNKmftJfebXwe65jG0gcjrDuEVrZbGQmN7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEWN04P5/VRVi8RPH3nkMgeRVfYUIwp58MJBOvtppo0/iesA8atOib7phv/nd7Icb
	 bvvxX/anER1Ixt5RJEH+ePQirjh87N1Qz5b/2RUu1gIgAgJCY+f91TdSKOsLZJNguN
	 VPIlrqorO8IuYW6ZPGnhB+RbF/28iHU1vKzfg/hU8MvqRVaP6D1k1z3H8FO2IySs91
	 p+I1OBKRemSxe8fPU4PZSLrzypsKIWDKAOJL9sYEVxslqIpLF78W5OrbNCxf3W5PFB
	 XvVL7r/BU9/6LImyRYVqZhJkBATRVCMeFNUFjCudQv3xj8rLy/cUoVxTcSmUwB45bp
	 WpJ7i7WeUNrjQ==
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
Subject: [PATCH net 3/3] net: prevent deadlocks when enabling NAPIs with mixed kthread config
Date: Thu,  7 Aug 2025 18:49:52 -0700
Message-ID: <20250808014952.724762-4-kuba@kernel.org>
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

The following order of calls currently deadlocks if:
 - device has threaded=1; and
 - NAPI has persistent config with threaded=0.

  netif_napi_add_weight_config()
    dev->threaded == 1
      napi_kthread_create()

  napi_enable()
    napi_restore_config()
      napi_set_threaded(0)
        napi_stop_kthread()
	  while (NAPIF_STATE_SCHED)
	    msleep(20)

We deadlock because disabled NAPI has STATE_SCHED set.
Creating a thread in netif_napi_add() just to destroy it in
napi_disable() is fairly ugly in the first place. Let's read
both the device config and the NAPI config in netif_napi_add().

Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.h | 8 ++++++++
 net/core/dev.c | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index ab69edc0c3e3..d6b08d435479 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -323,6 +323,14 @@ static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 	return NETDEV_NAPI_THREADED_DISABLED;
 }
 
+static inline enum netdev_napi_threaded
+napi_get_threaded_config(struct net_device *dev, struct napi_struct *n)
+{
+	if (n->config)
+		return n->config->threaded;
+	return dev->threaded;
+}
+
 int napi_set_threaded(struct napi_struct *n,
 		      enum netdev_napi_threaded threaded);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index f180746382a1..5a3c0f40a93f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7357,8 +7357,9 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 * Clear dev->threaded if kthread creation failed so that
 	 * threaded mode will not be enabled in napi_enable().
 	 */
-	if (dev->threaded && napi_kthread_create(napi))
-		dev->threaded = NETDEV_NAPI_THREADED_DISABLED;
+	if (napi_get_threaded_config(dev, napi))
+		if (napi_kthread_create(napi))
+			dev->threaded = NETDEV_NAPI_THREADED_DISABLED;
 	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
-- 
2.50.1


