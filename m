Return-Path: <linux-kselftest+bounces-7039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE689628C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC21C227F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6B2230F;
	Wed,  3 Apr 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9E03IQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52191F94B;
	Wed,  3 Apr 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111675; cv=none; b=sZ9Bud96dBDGzaJPrNvvXb0ALA27nRCxbwQ2Wka/sNyS0t2jEs+g9st8mhO/9HCcmBBQvT8obXZ77KBEapRpj1RFbUGK375XCHFMlERQAcrH6g0dFMGcJwhCZe81GhElywW45f75dhLkT23UGOS4lpkqparSsmht0wyiDI+xjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111675; c=relaxed/simple;
	bh=mB0I4kjtTnexpmnvDZ8oN+gQdUayrzeuXIYIsr+D/5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1akaeaj5kHD470m+nkhI8teyF7MQiIrO+13hxj42XX8mk5SocPyO5nCngT0DPEk06e9a8hVtLvvXoOccl0bDm/D/0SpT20Ca/lJbeIq23yDFw5YsTFs4Wfayeuk16CCPfzO5gCPOfxF3Ie2zgAXzpOlDN/Da0yQvIbPhEQuA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9E03IQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA887C433C7;
	Wed,  3 Apr 2024 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111675;
	bh=mB0I4kjtTnexpmnvDZ8oN+gQdUayrzeuXIYIsr+D/5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9E03IQEW25TS6cdQgWsVeSXYJGNcuLOHhV2jxkil4geunqCyUEQoa89ez9PANoYg
	 a/yUxz9bDYjsy2KltiojM21Cvhsrv4N3iti/CyK7Z9uZ+hg51aPFuZl9jX0PkTcgx1
	 GLFW0uO/7feGzlyg1HJmNvMDsgee+F+sE/AfeKqmMp5rOGMuQtr/LOIoaX71oSpe13
	 ff7LfyIzlmAqfR8R7yUY47pY8VHNroegQXuVI0QTX8llrd7j1akX28TJvBCR5cEWUW
	 3PbEhfTMq2X2OwLXldSb3xBvkM9jxY1uIelXGzq8iCWKswSQ1T5eDHkEFFwSeKTprL
	 FikgZX4zIXjrg==
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
Subject: [PATCH net-next v2 5/7] netdevsim: report stats by default, like a real device
Date: Tue,  2 Apr 2024 19:34:24 -0700
Message-ID: <20240403023426.1762996-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
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


