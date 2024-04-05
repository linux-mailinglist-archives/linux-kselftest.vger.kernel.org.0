Return-Path: <linux-kselftest+bounces-7249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3089934C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 04:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654C91C223D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 02:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473E1B299;
	Fri,  5 Apr 2024 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfWWnXN6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58719BA3;
	Fri,  5 Apr 2024 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285135; cv=none; b=a+J0YEtkQfTuCBdJe6jPFiCZPsR8e4ZxOkBCg5RUtx6Xd5qccz705bTgngulMq823WiG/Weu0iK/DC4pmN7eI6GH7h4bOiu28g+YnVJQa6QpKWqZbcGaKrnIx4y5azwoIIkNVyyQW/znlwg/kbaGowXr5CxzwSbYUsO58IeSf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285135; c=relaxed/simple;
	bh=8zBOozCsRUE20wUotX0eaUXsRl6qJOhNiqFBWZmLX4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgIxHghqzHYqykqUMAzyC8Ea/OPfLzFFRNby1+Pzu5/Nj/BW3dZEqJ2jPCC0u0RhxCUjgyoX8iACahNuvv1fJ/oOuL8mzCJ4wBH9oTCZzdwAL3yoXil5ELKJoGF3SjItWAJxKjBL8Rbq9PIW8UT5Qfsbss64u/j48oAgWB0oT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfWWnXN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DFC43394;
	Fri,  5 Apr 2024 02:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285134;
	bh=8zBOozCsRUE20wUotX0eaUXsRl6qJOhNiqFBWZmLX4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfWWnXN689gX8u4dgs0mmnWWHWTr/psYHV93a6WZYXQt9KsLYUFJgXwpccgC6U5LO
	 fgbjQnemZgYPRLsu/oYyFBJZ6LtEz4ZLxDpO6NqfUAxrBHl+k8+QG7+h9nzjBDc00h
	 Vbwqg2GoRVznZzyaNXdqMUa8P75xR/xa96qiwy7N9ddpQTWIArcUTBjUtMd/DduToq
	 KPYVvNwa/MnNyB1839yCAxE9wUPo5e4vnwbpjFqxXmCubFzfEG9qtUdR3iFQkP9zHb
	 QmcKsPca72Llk9yUnjvWh3eWCdehyjjfb2A4F/DhfhAMxv6fa8UPhrE9BDmxiDnODi
	 2D7eVY531LLNg==
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
Subject: [PATCH net-next v3 3/5] netdevsim: report stats by default, like a real device
Date: Thu,  4 Apr 2024 19:45:24 -0700
Message-ID: <20240405024526.2752998-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405024526.2752998-1-kuba@kernel.org>
References: <20240405024526.2752998-1-kuba@kernel.org>
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
v3:
 - spelling in comment
 - make sure we don't break when more queues present
---
 drivers/net/netdevsim/ethtool.c | 11 ++++++++
 drivers/net/netdevsim/netdev.c  | 49 +++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 8330bc0bcb7e..d7ba447db17c 100644
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
@@ -330,6 +331,53 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_set_features	= nsim_set_features,
 };
 
+/* We don't have true per-queue stats, yet, so do some random fakery here.
+ * Only report stuff for queue 0.
+ */
+static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct rtnl_link_stats64 rtstats = {};
+
+	if (!idx)
+		nsim_get_stats64(dev, &rtstats);
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
+	if (!idx)
+		nsim_get_stats64(dev, &rtstats);
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
@@ -360,6 +408,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 
 	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
+	ns->netdev->stat_ops = &nsim_stat_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
-- 
2.44.0


