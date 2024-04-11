Return-Path: <linux-kselftest+bounces-7662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A038A0583
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7071C22BEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882596997F;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UERWqJBi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D36996E;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798921; cv=none; b=OLayARxkCw36yxJWTJ8EkGiP3d6um2AR5eIvIwDjg2MNl67oiYF9cYldCSWaJDD6Fd1iEhAvSKNZHqeYMqn8/7wB5O2yanNIvp13YkYFwWNHpGKH/FWywjxOxYjn7kSuBtzgUL3Z/FieyymbQD4jA/naz8O+153+0ULxAgOy4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798921; c=relaxed/simple;
	bh=OWzNRL9wTAL3ZZ/3fyuNRkKpjlzyc/9bE7pYUM6rX1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcaORRjhe1GwgWV1NezKXnf/fk/IobBhlTXffJmEBt2ufTOrvRaPanhiujN2QjWWNRRyWN3ZhZCfwX3hOL2cUzxaD0/wkT/d/DnKXfum9wqjsOEqdqL0bNGBZSLHJunrg2eJGpieHMz7ZTG3UIx6J3mIJ/bHmwKt5k6Usyc0f+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UERWqJBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849BDC43390;
	Thu, 11 Apr 2024 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798920;
	bh=OWzNRL9wTAL3ZZ/3fyuNRkKpjlzyc/9bE7pYUM6rX1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UERWqJBi5H8rZNqahKJD6h/+wCu+IgGolpLkrQx8Jnsdg+BkNaoYWr6eLeDLNxeYg
	 iE90uH1Gf6YSW+84gsgylZmXs+IJbJXpZkEHshClIgCCXiYZgb3fl4yFaF1itO8wjO
	 cTor+cBEnhwuMbPDLhQNtOXHwj9eWDvWxXh0i/kdfwooHFcQjQCctE9SGyCHhKjYM8
	 eU4q1lxlyhepbHzzJFrBTZbRFG8wlmYf2lIzKHRHtybFBVZtHm9My2Tu2zrHTHrvwG
	 batGVPTRw6CMIXfSkDIaAvXxp36Elayzhaf2oBaRsDbjissvaf2/on0DseuInICN57
	 EAzcI9NXCUD8A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/6] net: netdevsim: add some fake page pool use
Date: Wed, 10 Apr 2024 18:28:10 -0700
Message-ID: <20240411012815.174400-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411012815.174400-1-kuba@kernel.org>
References: <20240411012815.174400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add very basic page pool use so that we can exercise
the netlink uAPI in a selftest.

Page pool gets created on open, destroyed on close.
But we control allocating of a single page thru debugfs.
This page may survive past the page pool itself so that
we can test orphaned page pools.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c    | 93 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  4 ++
 2 files changed, 97 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d7ba447db17c..d127856f8f36 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -20,6 +20,7 @@
 #include <linux/netdevice.h>
 #include <linux/slab.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
@@ -299,6 +300,29 @@ static int nsim_get_iflink(const struct net_device *dev)
 	return iflink;
 }
 
+static int nsim_open(struct net_device *dev)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct page_pool_params pp = { 0 };
+
+	pp.pool_size = 128;
+	pp.dev = &dev->dev;
+	pp.dma_dir = DMA_BIDIRECTIONAL;
+	pp.netdev = dev;
+
+	ns->pp = page_pool_create(&pp);
+	return PTR_ERR_OR_ZERO(ns->pp);
+}
+
+static int nsim_stop(struct net_device *dev)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	page_pool_destroy(ns->pp);
+
+	return 0;
+}
+
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
 	.ndo_set_rx_mode	= nsim_set_rx_mode,
@@ -318,6 +342,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_set_features	= nsim_set_features,
 	.ndo_get_iflink		= nsim_get_iflink,
 	.ndo_bpf		= nsim_bpf,
+	.ndo_open		= nsim_open,
+	.ndo_stop		= nsim_stop,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
@@ -378,6 +404,60 @@ static const struct netdev_stat_ops nsim_stat_ops = {
 	.get_base_stats		= nsim_get_base_stats,
 };
 
+static ssize_t
+nsim_pp_hold_read(struct file *file, char __user *data,
+		  size_t count, loff_t *ppos)
+{
+	struct netdevsim *ns = file->private_data;
+	char buf[3] = "n\n";
+
+	if (ns->page)
+		buf[0] = 'y';
+
+	return simple_read_from_buffer(data, count, ppos, buf, 2);
+}
+
+static ssize_t
+nsim_pp_hold_write(struct file *file, const char __user *data,
+		   size_t count, loff_t *ppos)
+{
+	struct netdevsim *ns = file->private_data;
+	ssize_t ret;
+	bool val;
+
+	ret = kstrtobool_from_user(data, count, &val);
+	if (ret)
+		return ret;
+
+	rtnl_lock();
+	ret = count;
+	if (val == !!ns->page)
+		goto exit;
+
+	if (!netif_running(ns->netdev) && val) {
+		ret = -ENETDOWN;
+	} else if (val) {
+		ns->page = page_pool_dev_alloc_pages(ns->pp);
+		if (!ns->page)
+			ret = -ENOMEM;
+	} else {
+		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		ns->page = NULL;
+	}
+	rtnl_unlock();
+
+exit:
+	return count;
+}
+
+static const struct file_operations nsim_pp_hold_fops = {
+	.open = simple_open,
+	.read = nsim_pp_hold_read,
+	.write = nsim_pp_hold_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
 static void nsim_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -485,6 +565,10 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 		err = nsim_init_netdevsim_vf(ns);
 	if (err)
 		goto err_free_netdev;
+
+	ns->pp_dfs = debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir,
+					 ns, &nsim_pp_hold_fops);
+
 	return ns;
 
 err_free_netdev:
@@ -497,6 +581,8 @@ void nsim_destroy(struct netdevsim *ns)
 	struct net_device *dev = ns->netdev;
 	struct netdevsim *peer;
 
+	debugfs_remove(ns->pp_dfs);
+
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
@@ -511,6 +597,13 @@ void nsim_destroy(struct netdevsim *ns)
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
 		nsim_exit_netdevsim(ns);
+
+	/* Put this intentionally late to exercise the orphaning path */
+	if (ns->page) {
+		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		ns->page = NULL;
+	}
+
 	free_netdev(dev);
 }
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 553c4b9b4f63..7664ab823e29 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -125,6 +125,10 @@ struct netdevsim {
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
+	struct page_pool *pp;
+	struct page *page;
+	struct dentry *pp_dfs;
+
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
 };
-- 
2.44.0


