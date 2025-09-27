Return-Path: <linux-kselftest+bounces-42545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE4BA6474
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46A2A4E0558
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61723D2B4;
	Sat, 27 Sep 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFM3+7/N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8023C506;
	Sat, 27 Sep 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013669; cv=none; b=RUjn/Os8z8Ap3im20946GYfjFV/m/4VbIL7BmjhU4dn+1ipn00OeCl7Vef/nIfAOCLHOE7zuLbhmmrsGWC+IGjNZ26xVeBwj8lKrd1U6PqfGnv0gpt5+0O8SRAZW8FuThDvfpE/nOaAjT9r/KTUdRu58cC3S2Xk3F4XJCeOB/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013669; c=relaxed/simple;
	bh=0qpf33ygN9dRiSnyPlhq0TYBewPecMUopcDqajyLhMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV+IelIXkYcS5gc2YVZZcrCFdbv8QIr01qD576Fr0hWTTTOLyY7Fdf/mkEH9AzOCtEG1A3vQh56xUF0DJTzNmfdbfIswQ6vtNkC7gAxFdZ9UPOKtVHUVB/0AmZNsuhVguwh7Sz1LoILhuOzTqK9eHK1HXwROSP4TNcdg4FTBDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFM3+7/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A80C113CF;
	Sat, 27 Sep 2025 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013669;
	bh=0qpf33ygN9dRiSnyPlhq0TYBewPecMUopcDqajyLhMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFM3+7/NdxakW//KzyKO9Wyubbt1gpcJHr4YncTbVjJnKGoU65yjtlphNehz5fjIX
	 jEMgkEXzVOUwYE3LPRwnrwghdwffk2/4ViIxAGwKye9HVDvlkeRvsPksj87+MfSoy9
	 6XWJV9EFsvm+S1BkHEy2Cx+ssTqQk80NhLjWe4to+jQMjDqxrFPLFN1KnHKXPEGYIx
	 0Y/TnQ4uxgBRXsZEqd8US2GocG+ac6GxbmqIxLxs0XZ4gUtmlcAjzsciLgHoiZenTj
	 ggozkVbn4mm2i7yurThARBgVDgn1b7+HNB6/eryw1zjbn8vd3drEYBFQGn88W84q1o
	 Ocd2Cgb/hEvzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	shuah@kernel.org,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/8] netdevsim: a basic test PSP implementation
Date: Sat, 27 Sep 2025 15:54:13 -0700
Message-ID: <20250927225420.1443468-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927225420.1443468-1-kuba@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a PSP implementation for netdevsim.

Use psp_dev_encapsulate() and psp_dev_rcv() to do actual encapsulation
and decapsulation on skbs, but perform no encryption or decryption. In
order to make encryption with a bad key result in a drop on the peer's
rx side, we stash our psd's generation number in the first byte of each
key before handing to the peer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v3:
 - fix init error path
 - fix unused variable with ipv6=n (__maybe_unused, all options seem
   equally bad here)
---
 drivers/net/netdevsim/Makefile    |   4 +
 drivers/net/netdevsim/netdevsim.h |  27 ++++
 drivers/net/netdevsim/netdev.c    |  43 +++++-
 drivers/net/netdevsim/psp.c       | 225 ++++++++++++++++++++++++++++++
 net/core/skbuff.c                 |   1 +
 5 files changed, 294 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/netdevsim/psp.c

diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index f8de93bc5f5b..14a553e000ec 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -18,6 +18,10 @@ ifneq ($(CONFIG_PSAMPLE),)
 netdevsim-objs += psample.o
 endif
 
+ifneq ($(CONFIG_INET_PSP),)
+netdevsim-objs += psp.o
+endif
+
 ifneq ($(CONFIG_MACSEC),)
 netdevsim-objs += macsec.o
 endif
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bddd24c1389d..02c1c97b7008 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -108,6 +108,12 @@ struct netdevsim {
 
 	int rq_reset_mode;
 
+	struct {
+		struct psp_dev *dev;
+		u32 spi;
+		u32 assoc_cnt;
+	} psp;
+
 	struct nsim_bus_dev *nsim_bus_dev;
 
 	struct bpf_prog	*bpf_offloaded;
@@ -421,6 +427,27 @@ static inline void nsim_macsec_teardown(struct netdevsim *ns)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_INET_PSP)
+int nsim_psp_init(struct netdevsim *ns);
+void nsim_psp_uninit(struct netdevsim *ns);
+void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext);
+enum skb_drop_reason
+nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext);
+#else
+static inline int nsim_psp_init(struct netdevsim *ns) { return 0; }
+static inline void nsim_psp_uninit(struct netdevsim *ns) {}
+static inline enum skb_drop_reason
+nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+{
+	return 0;
+}
+
+static inline void
+nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext) {}
+#endif
+
 struct nsim_bus_dev {
 	struct device dev;
 	struct list_head list;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0178219f0db5..ebc3833e95b4 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -103,28 +103,42 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
 static int nsim_forward_skb(struct net_device *tx_dev,
 			    struct net_device *rx_dev,
 			    struct sk_buff *skb,
-			    struct nsim_rq *rq)
+			    struct nsim_rq *rq,
+			    struct skb_ext *psp_ext)
 {
-	return __dev_forward_skb(rx_dev, skb) ?:
-		nsim_napi_rx(tx_dev, rx_dev, rq, skb);
+	int ret;
+
+	ret = __dev_forward_skb(rx_dev, skb);
+	if (ret)
+		return ret;
+
+	nsim_psp_handle_ext(skb, psp_ext);
+
+	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
 	struct netdev_config *cfg;
 	struct nsim_rq *rq;
 	int rxq;
+	int dr;
 
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
-		goto out_drop_free;
+		goto out_drop_any;
 
 	peer_ns = rcu_dereference(ns->peer);
 	if (!peer_ns)
+		goto out_drop_any;
+
+	dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext);
+	if (dr)
 		goto out_drop_free;
 
 	peer_dev = peer_ns->netdev;
@@ -141,7 +155,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
-	if (unlikely(nsim_forward_skb(dev, peer_dev, skb, rq) == NET_RX_DROP))
+	if (unlikely(nsim_forward_skb(dev, peer_dev,
+				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
 
 	if (!hrtimer_active(&rq->napi_timer))
@@ -151,8 +166,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_dstats_tx_add(dev, len);
 	return NETDEV_TX_OK;
 
+out_drop_any:
+	dr = SKB_DROP_REASON_NOT_SPECIFIED;
 out_drop_free:
-	dev_kfree_skb(skb);
+	kfree_skb_reason(skb, dr);
 out_drop_cnt:
 	rcu_read_unlock();
 	dev_dstats_tx_dropped(dev);
@@ -1002,6 +1019,7 @@ static void nsim_queue_uninit(struct netdevsim *ns)
 
 static int nsim_init_netdevsim(struct netdevsim *ns)
 {
+	struct netdevsim *peer;
 	struct mock_phc *phc;
 	int err;
 
@@ -1036,6 +1054,10 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
 
+	err = nsim_psp_init(ns);
+	if (err)
+		goto err_unregister_netdev;
+
 	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
 		ns->nb.notifier_call = netdev_debug_event;
 		if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
@@ -1045,6 +1067,13 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 
 	return 0;
 
+err_unregister_netdev:
+	rtnl_lock();
+	peer = rtnl_dereference(ns->peer);
+	if (peer)
+		RCU_INIT_POINTER(peer->peer, NULL);
+	RCU_INIT_POINTER(ns->peer, NULL);
+	unregister_netdevice(ns->netdev);
 err_ipsec_teardown:
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
@@ -1132,6 +1161,8 @@ void nsim_destroy(struct netdevsim *ns)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
 						      &ns->nn);
 
+	nsim_psp_uninit(ns);
+
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
new file mode 100644
index 000000000000..332b5b744f01
--- /dev/null
+++ b/drivers/net/netdevsim/psp.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <net/ip6_checksum.h>
+#include <net/psp.h>
+#include <net/sock.h>
+
+#include "netdevsim.h"
+
+void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext)
+{
+	if (psp_ext)
+		__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
+}
+
+enum skb_drop_reason
+nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+{
+	enum skb_drop_reason rc = 0;
+	struct psp_assoc *pas;
+	struct net *net;
+	void **ptr;
+
+	rcu_read_lock();
+	pas = psp_skb_get_assoc_rcu(skb);
+	if (!pas) {
+		rc = SKB_NOT_DROPPED_YET;
+		goto out_unlock;
+	}
+
+	if (!skb_transport_header_was_set(skb)) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	ptr = psp_assoc_drv_data(pas);
+	if (*ptr != ns) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	net = sock_net(skb->sk);
+	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0)) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	/* Now pretend we just received this frame */
+	if (peer_ns->psp.dev->config.versions & (1 << pas->version)) {
+		bool strip_icv = false;
+		u8 generation;
+
+		/* We cheat a bit and put the generation in the key.
+		 * In real life if generation was too old, then decryption would
+		 * fail. Here, we just make it so a bad key causes a bad
+		 * generation too, and psp_sk_rx_policy_check() will fail.
+		 */
+		generation = pas->tx.key[0];
+
+		skb_ext_reset(skb);
+		skb->mac_len = ETH_HLEN;
+		if (psp_dev_rcv(skb, peer_ns->psp.dev->id, generation,
+				strip_icv)) {
+			rc = SKB_DROP_REASON_PSP_OUTPUT;
+			goto out_unlock;
+		}
+
+		*psp_ext = skb->extensions;
+		refcount_inc(&(*psp_ext)->refcnt);
+		skb->decrypted = 1;
+	} else {
+		struct ipv6hdr *ip6h __maybe_unused;
+		struct iphdr *iph;
+		struct udphdr *uh;
+		__wsum csum;
+
+		/* Do not decapsulate. Receive the skb with the udp and psp
+		 * headers still there as if this is a normal udp packet.
+		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
+		 * provide a valid checksum here, so the skb isn't dropped.
+		 */
+		uh = udp_hdr(skb);
+		csum = skb_checksum(skb, skb_transport_offset(skb),
+				    ntohs(uh->len), 0);
+
+		switch (skb->protocol) {
+		case htons(ETH_P_IP):
+			iph = ip_hdr(skb);
+			uh->check = udp_v4_check(ntohs(uh->len), iph->saddr,
+						 iph->daddr, csum);
+			break;
+#if IS_ENABLED(CONFIG_IPV6)
+		case htons(ETH_P_IPV6):
+			ip6h = ipv6_hdr(skb);
+			uh->check = udp_v6_check(ntohs(uh->len), &ip6h->saddr,
+						 &ip6h->daddr, csum);
+			break;
+#endif
+		}
+
+		uh->check	= uh->check ?: CSUM_MANGLED_0;
+		skb->ip_summed	= CHECKSUM_NONE;
+	}
+
+out_unlock:
+	rcu_read_unlock();
+	return rc;
+}
+
+static int
+nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
+		    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int
+nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
+		  struct psp_key_parsed *assoc,
+		  struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	unsigned int new;
+	int i;
+
+	new = ++ns->psp.spi & PSP_SPI_KEY_ID;
+	if (psd->generation & 1)
+		new |= PSP_SPI_KEY_PHASE;
+
+	assoc->spi = cpu_to_be32(new);
+	assoc->key[0] = psd->generation;
+	for (i = 1; i < PSP_MAX_KEY; i++)
+		assoc->key[i] = ns->psp.spi + i;
+
+	return 0;
+}
+
+static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
+			  struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	void **ptr = psp_assoc_drv_data(pas);
+
+	/* Copy drv_priv from psd to assoc */
+	*ptr = psd->drv_priv;
+	ns->psp.assoc_cnt++;
+
+	return 0;
+}
+
+static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	void **ptr = psp_assoc_drv_data(pas);
+
+	*ptr = NULL;
+	ns->psp.assoc_cnt--;
+}
+
+static struct psp_dev_ops nsim_psp_ops = {
+	.set_config	= nsim_psp_set_config,
+	.rx_spi_alloc	= nsim_rx_spi_alloc,
+	.tx_key_add	= nsim_assoc_add,
+	.tx_key_del	= nsim_assoc_del,
+	.key_rotate	= nsim_key_rotate,
+};
+
+static struct psp_dev_caps nsim_psp_caps = {
+	.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128 |
+		    1 << PSP_VERSION_HDR0_AES_GMAC_128 |
+		    1 << PSP_VERSION_HDR0_AES_GCM_256 |
+		    1 << PSP_VERSION_HDR0_AES_GMAC_256,
+	.assoc_drv_spc = sizeof(void *),
+};
+
+void nsim_psp_uninit(struct netdevsim *ns)
+{
+	if (!IS_ERR(ns->psp.dev))
+		psp_dev_unregister(ns->psp.dev);
+	WARN_ON(ns->psp.assoc_cnt);
+}
+
+static ssize_t
+nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
+		     loff_t *ppos)
+{
+	struct netdevsim *ns = file->private_data;
+	int err;
+
+	nsim_psp_uninit(ns);
+
+	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
+				     &nsim_psp_caps, ns);
+	err = PTR_ERR_OR_ZERO(ns->psp.dev);
+	return err ?: count;
+}
+
+static const struct file_operations nsim_psp_rereg_fops = {
+	.open = simple_open,
+	.write = nsim_psp_rereg_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
+int nsim_psp_init(struct netdevsim *ns)
+{
+	struct dentry *ddir = ns->nsim_dev_port->ddir;
+	int err;
+
+	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
+				     &nsim_psp_caps, ns);
+	err = PTR_ERR_OR_ZERO(ns->psp.dev);
+	if (err)
+		return err;
+
+	debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_fops);
+	return 0;
+}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index daaf6da43cc9..618afd59afff 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7048,6 +7048,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 	skb->active_extensions = 1 << id;
 	return skb_ext_get_ptr(ext, id);
 }
+EXPORT_SYMBOL_NS_GPL(__skb_ext_set, "NETDEV_INTERNAL");
 
 /**
  * skb_ext_add - allocate space for given extension, COW if needed
-- 
2.51.0


