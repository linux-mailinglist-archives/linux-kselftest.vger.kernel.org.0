Return-Path: <linux-kselftest+bounces-34885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EEAD89A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880F6189D676
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC602D5C6D;
	Fri, 13 Jun 2025 10:40:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216402C15B9;
	Fri, 13 Jun 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811212; cv=none; b=MYKHD7lYyS0JzrIPlZ2ZgdYS+/CiQVsu8jpSDvCFgJIgdB+lYB5+pN7JTOewjOCHz7UC5Dpq7fI09o1okv7hbAHNcbIvuT5fIG0sMYcEyDToIBymagv8cgRhQ7SRKB/PVp0cPZnf4lzLPgENLl/1dAFLh4M4dlbGXHkdTOmu+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811212; c=relaxed/simple;
	bh=Ya02A6KSQP7IifJw9ze9oqhqSpeNuf34AYwn/7z5joU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqnDkA4wlJWNj+KHVqFW2As/7sZgdDMd8WVL39rLne/Qu7sUyAgsK7Y1LnPYvkWiDyMQ24DC8HCLyxosd8oLD6ey9UnFTgeIdhTQneKbkhxZPLtqyWQvBKraAdlUFMDsPkxZm/Rh5ImVOXMq6Fn5c05zwGCOxn+fDi9ga26H35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607ea238c37so4082240a12.2;
        Fri, 13 Jun 2025 03:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811208; x=1750416008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBnJcIZF2UCEJDwnnA5SfZDnvEUhOFTZwy3JCGcNINI=;
        b=tO/kXTzfZTn+ctY+Cnn3wS6izTfHzr/+83QsGOB6OyE0wGoj1GhlG/C5sX1tpupRBf
         5yUl8TU2HsCNQwjQAV/HtIxiYBqpjsdfHxyiFCOEIiIgY03QpM+x4kyEQgQbjwtwjg+E
         O0P+7xnboTuJRXAtJ4WBbYY68ojzNhIV1DwvPhWPamsAAdyoYFBNt+dbtGRyy9A33hIl
         7Iy9fRnTKrKAageHoR0XoNDKsCykJVNzM/tR5Fj+PZkoGFygEib60xEXQpekYbK4loY+
         Top6fXqjnyy/8+pv6C3eFZg3GFjzCovsOmPEXLByUB2xcl8QxEF/6CP0bYRF40RieIae
         Ouhw==
X-Forwarded-Encrypted: i=1; AJvYcCUraiYLBg45rJ5R7u1sxa6djR6e2sT0AvQoIe+Js7DoOhqsd3YsfBlKtoUVeJeJanw6psRq9nB8HYpvlXo5VjMh@vger.kernel.org, AJvYcCVq4Q9UKDN1RyLCB4E1Cvr/4r6VX9BdlLygsjmXYtFSp6ST4/jwn9bEw+NzymkcRZwXoVLSje5fxa3V6Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEf3VMOEk5USXDKD9NZaSfpT+Yx1NnHcPBd8Y7qp5uqyvHqe5
	lVTUpdakOQbtC93IhTx+g4vf28tr4XORj6iXge1M3ewICZASv8QbLhkB
X-Gm-Gg: ASbGnctw+uqFOtND9R9h7NkW48e12uwRYqTiqcpLKRquWWfI18B0lrVVQZI9emwOvFN
	jbqjPmpbpO5TWDLt1l4uyAtKFZ+I046IWGPGAALzVCpmP3k3AT1f5wUK+FiX1FpWgPYoTyp3zCL
	HNq1NswHu1E4SKKW/Hq2VLJkiyF8Cue3md0RDuTMmmpCB8gCMqVvLDYLXJSJC7QD9F6gx/9T0S6
	XRU7/veZhFkQi0c53q3eGuC/j4MSXKHhy9k3cN3GwRx+dW3nJfi8OnE0hsuFyz2XlzNJ+rZnlzV
	N4f/jaW/xecrGlIeZubAu/nnN9b6F+5xEHVMrOnBRud/lZsqJiDkWw==
X-Google-Smtp-Source: AGHT+IEZ31K/q168BxmKVo6zXsSdU68snMlPe7e636po4guk+DVQCiuyT/KjVXk4PDHV+QzruwuDtQ==
X-Received: by 2002:a05:6402:2787:b0:606:aea6:15d6 with SMTP id 4fb4d7f45d1cf-608b492a36dmr2035522a12.9.1749811208100;
        Fri, 13 Jun 2025 03:40:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48cd687sm1030080a12.18.2025.06.13.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:40:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 03:39:58 -0700
Subject: [PATCH net-next v2 1/4] netdevsim: migrate to dstats stats
 collection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-netdevsim_stat-v2-1-98fa38836c48@debian.org>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
In-Reply-To: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, joe@dama.to
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4957; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ya02A6KSQP7IifJw9ze9oqhqSpeNuf34AYwn/7z5joU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAAERrFUdRqPkaJ3V2hlkCU1PJ9swKb/ygWzd
 cif/Egzk0CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwABAAKCRA1o5Of/Hh3
 bRBcD/9hIvSHV3GaEEGsaq40I+sD2dy4u529mwHO4e55fz89yZ+fH84TFSV5PyQusfBaTFdwyRm
 aIjMDKIC+kcgRgO0HEKQXYJpWkgYTTuBR6MSSNTDwyMSPDXwAY4c+K9a4Caw3xz6TZ+TBLxxTCG
 4ymgeAp+IqT1y0a7G7HEEOgFO9CC14SBe5+NhM+vE4OtUGumSfneldAKz6bQqLcSn3aiZOusI0O
 8E9wamvKMMS2kBIe6YR5cf8YXErMhmRrJwiT2/fjBd8zoJXSva/9ghTChN5e7e15AKk+Mg3L0BS
 Y+Wzm3nWMtI+RIngtIyp7a9R/4XqlxFdMvRfpqBN2QA2DB2aBTbwnmgBaDx1MsIwf3oUV0iDe/T
 SsAvAp0kXitR7YoeCHryDCJgMES9Irnop36hhNFZOjwrCljE0gJQLP4Eeec/pOSBpcy66firODc
 ADzkEUS4EZa8yYEENWO7wTBdZBIfVDtylI8axXZv6XV1XGt2O++3gXcHD568pUqCgGHaOLaQlvw
 HNnEwY8quvMlvUL0t328X7brfS/HY8jiZ2aTwqBLhPj3a0DKGOTZBZ50zTGQxWmS2anrironUBH
 yO6RPqS6uX73Fh3ObL3+xiIFl609sDtm/hY5NVkM2s3MqC9o8pEHnWjYLfHGOj6FBZJVvUGXDyc
 4YqAzB7YMnvtRsg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace custom statistics tracking with the kernel's dstats infrastructure
to simplify code and improve consistency with other network drivers.

This change:
- Sets dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS for automatic
  automatic allocation and deallocation.
- Removes manual stats fields and their update
- Replaces custom nsim_get_stats64() with dev_get_stats()
- Uses dev_dstats_tx_add() and dev_dstats_tx_dropped() helpers
- Eliminates the need for manual synchronization primitives

The dstats framework provides the same functionality with less code.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c    | 33 ++++++---------------------------
 drivers/net/netdevsim/netdevsim.h |  5 -----
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index fa5fbd97ad69e..5010d8eefc854 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -93,19 +93,14 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
-	u64_stats_update_begin(&ns->syncp);
-	ns->tx_packets++;
-	ns->tx_bytes += len;
-	u64_stats_update_end(&ns->syncp);
+	dev_dstats_tx_add(dev, skb->len);
 	return NETDEV_TX_OK;
 
 out_drop_free:
 	dev_kfree_skb(skb);
 out_drop_cnt:
 	rcu_read_unlock();
-	u64_stats_update_begin(&ns->syncp);
-	ns->tx_dropped++;
-	u64_stats_update_end(&ns->syncp);
+	dev_dstats_tx_dropped(dev);
 	return NETDEV_TX_OK;
 }
 
@@ -126,20 +121,6 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void
-nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
-{
-	struct netdevsim *ns = netdev_priv(dev);
-	unsigned int start;
-
-	do {
-		start = u64_stats_fetch_begin(&ns->syncp);
-		stats->tx_bytes = ns->tx_bytes;
-		stats->tx_packets = ns->tx_packets;
-		stats->tx_dropped = ns->tx_dropped;
-	} while (u64_stats_fetch_retry(&ns->syncp, start));
-}
-
 static int
 nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
 {
@@ -556,7 +537,6 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-	.ndo_get_stats64	= nsim_get_stats64,
 	.ndo_set_vf_mac		= nsim_set_vf_mac,
 	.ndo_set_vf_vlan	= nsim_set_vf_vlan,
 	.ndo_set_vf_rate	= nsim_set_vf_rate,
@@ -580,7 +560,6 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-	.ndo_get_stats64	= nsim_get_stats64,
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 };
@@ -594,7 +573,7 @@ static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		nsim_get_stats64(dev, &rtstats);
+		dev_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;
 	stats->bytes = rtstats.rx_bytes;
@@ -606,7 +585,7 @@ static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		nsim_get_stats64(dev, &rtstats);
+		dev_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
 	stats->bytes = rtstats.tx_bytes;
@@ -618,7 +597,7 @@ static void nsim_get_base_stats(struct net_device *dev,
 {
 	struct rtnl_link_stats64 rtstats = {};
 
-	nsim_get_stats64(dev, &rtstats);
+	dev_get_stats(dev, &rtstats);
 
 	rx->packets = !!rtstats.rx_packets;
 	rx->bytes = 0;
@@ -890,6 +869,7 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
 			    NETIF_F_TSO;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
 }
@@ -1022,7 +1002,6 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	dev_net_set(dev, nsim_dev_net(nsim_dev));
 	ns = netdev_priv(dev);
 	ns->netdev = dev;
-	u64_stats_init(&ns->syncp);
 	ns->nsim_dev = nsim_dev;
 	ns->nsim_dev_port = nsim_dev_port;
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d04401f0bdf79..343b8f19dbed6 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -108,11 +108,6 @@ struct netdevsim {
 
 	int rq_reset_mode;
 
-	u64 tx_packets;
-	u64 tx_bytes;
-	u64 tx_dropped;
-	struct u64_stats_sync syncp;
-
 	struct nsim_bus_dev *nsim_bus_dev;
 
 	struct bpf_prog	*bpf_offloaded;

-- 
2.47.1


