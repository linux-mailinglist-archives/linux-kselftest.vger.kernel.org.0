Return-Path: <linux-kselftest+bounces-6966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EE894896
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636041F22A3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849FD52A;
	Tue,  2 Apr 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pov85QyX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4ADDC4;
	Tue,  2 Apr 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019942; cv=none; b=MILE70OxPfkHxrFVxh7dvaSbo3T05qQPfpPG5ZlEniQNfuzeCSXp6J7taJItY7HojuZFIls90mAybdmfsBblGuJ82hAYH+p0jF+3v80+mxwAiVo089ej2KLMnGJgKVtfRfQSdfnhBmNkUASXMAsDQ3+0X3rpLjr0ijCfqgMHMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019942; c=relaxed/simple;
	bh=mB0I4kjtTnexpmnvDZ8oN+gQdUayrzeuXIYIsr+D/5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7hdv6D+GgHpPwDyQp+QIn2QadD1+0bBUlo07RmQXRoxB+SssJNeASwPr8cLYV+DZ9q+8K7KrM9AcbRdOt6g8y8wR79vTxleE/1BlPXo8rK0L66ZkD723p5pPrE9LZVbx74oaRvH+jOarv/wH5Vfl1IEB+uhi3fZFFDkzr6Zra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pov85QyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E4EC433F1;
	Tue,  2 Apr 2024 01:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019942;
	bh=mB0I4kjtTnexpmnvDZ8oN+gQdUayrzeuXIYIsr+D/5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pov85QyXJ3pVzdPuhagSJlJpaJP4eNWXK1C3qkdgtYXOxI2T+YB/lA4EASxiqW2Ek
	 14ust3zTRqPDpuSxZ+2CEnR+OY+0EtdYPrNMPw6JGCJ66g93x2inW4v3VBTzMLgdRv
	 YKybm1gWIzM7crk1YWAQci24rkG4q48vjmfzKqgxV7WHM6Ro5uRLVx4Z2/F5Xr/jef
	 +d/Ihy03xoVFU5zSVDI+XdtLtGDYJ+0mGr7CGv+hvf3R2VZTxcsxNxXWkpGSnfIwE1
	 EMjqdIrH03YEESfWztq4X8xV9eQ2q/1wV6WGf9JMeJQb+Wf5MS2y/n0iWbQz1t3uMf
	 9u61BNFiUJbIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/7] netdevsim: report stats by default, like a real device
Date: Mon,  1 Apr 2024 18:05:17 -0700
Message-ID: <20240402010520.1209517-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402010520.1209517-1-kuba@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real devices should implement qstats. Devices which support
pause or FEC configuration should also report the relevant stats.

nsim was missing FEC stats completely, some of the qstats
and pause stats required toggling a debugfs knob.

Note that the tests which used pause always initialize the setting
so they shouldn't be affected by the different starting value.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/ethtool.c | 11 ++++++++
 drivers/net/netdevsim/netdev.c  | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index bd546d4d26c6..3f9c9327f149 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -140,6 +140,13 @@ nsim_set_fecparam(struct net_device *dev, struct ethtool_fecparam *fecparam)
 	return 0;
 }
 
+static void
+nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
+{
+	fec_stats->corrected_blocks.total = 123;
+	fec_stats->uncorrectable_blocks.total = 4;
+}
+
 static int nsim_get_ts_info(struct net_device *dev,
 			    struct ethtool_ts_info *info)
 {
@@ -163,6 +170,7 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_channels			= nsim_set_channels,
 	.get_fecparam			= nsim_get_fecparam,
 	.set_fecparam			= nsim_set_fecparam,
+	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
 };
 
@@ -182,6 +190,9 @@ void nsim_ethtool_init(struct netdevsim *ns)
 
 	nsim_ethtool_ring_init(ns);
 
+	ns->ethtool.pauseparam.report_stats_rx = true;
+	ns->ethtool.pauseparam.report_stats_tx = true;
+
 	ns->ethtool.fec.fec = ETHTOOL_FEC_NONE;
 	ns->ethtool.fec.active_fec = ETHTOOL_FEC_NONE;
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8330bc0bcb7e..096ac0abbc02 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/slab.h>
+#include <net/netdev_queues.h>
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
@@ -330,6 +331,49 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_set_features	= nsim_set_features,
 };
 
+/* We don't have true par-queue stats, yet, so do some random fakery here. */
+static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct rtnl_link_stats64 rtstats = {};
+
+	nsim_get_stats64(dev, &rtstats);
+
+	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;
+	stats->bytes = rtstats.rx_bytes;
+}
+
+static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct rtnl_link_stats64 rtstats = {};
+
+	nsim_get_stats64(dev, &rtstats);
+
+	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
+	stats->bytes = rtstats.tx_bytes;
+}
+
+static void nsim_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct rtnl_link_stats64 rtstats = {};
+
+	nsim_get_stats64(dev, &rtstats);
+
+	rx->packets = !!rtstats.rx_packets;
+	rx->bytes = 0;
+	tx->packets = !!rtstats.tx_packets;
+	tx->bytes = 0;
+}
+
+static const struct netdev_stat_ops nsim_stat_ops = {
+	.get_queue_stats_tx	= nsim_get_queue_stats_tx,
+	.get_queue_stats_rx	= nsim_get_queue_stats_rx,
+	.get_base_stats		= nsim_get_base_stats,
+};
+
 static void nsim_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -360,6 +404,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 
 	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
+	ns->netdev->stat_ops = &nsim_stat_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
-- 
2.44.0


