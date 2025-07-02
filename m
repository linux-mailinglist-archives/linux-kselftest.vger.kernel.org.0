Return-Path: <linux-kselftest+bounces-36275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B8AF0DF9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F5D1C25A3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F2238D32;
	Wed,  2 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PW1cs0wB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB71D63F0;
	Wed,  2 Jul 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444903; cv=none; b=HFthRYwN2RX94zwBfM4kT/4I2VRhLfKRHnbrIptiLP9Ico61lZVIhjgqzPPKjM7qhaAz7QWGX6JRd2L+MDRu9J7VgiSbrhmx5zhbKsaC/+VmL88KbjCErgwdDAWFatjV7mz9VQ4NPSAt34x6CsddXLgB4Xn5niy5ev2FfP0RdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444903; c=relaxed/simple;
	bh=sn8g3unGo26BPxNeO0g2d1bQHfSByODUe1q/hWDxN5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1rHFq5xZIUI3EuH8U/G5B0mlrN9du7QG3tRVPDIMB+vl8VV0O0Iz5Mq9E5fmpKGINwvlzSkrLE0ax3Q6fviXhRGmQ4h84/3qciDmH/+dcTrhXfWLG3GACvIRA8DF4oqLQMEUb5eEK12NP1z1KXL7qAuE+sHDdRTXdhZWwOu3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PW1cs0wB; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8896D43140;
	Wed,  2 Jul 2025 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751444893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I4UDpXJzumU4lXzbJj7GOv7F2E97tNMNa57a6Nocn4=;
	b=PW1cs0wBs48vSr33ivCmgzrs8vswQDRBoXYRA4aGLLccTwoXRalCRRZ0GMilccRbAwn1Rk
	DyTKpFrRHZ6BRzKryt/b5dEX12W/LfXnepSem34GKpX+41Wybas2BLUux3AMfz0C3V1M6a
	Y/4Qj+4KLnGdG1uJNEn97Tb/+tzKpyWeJoCcT8BBl1Gaeubrpo6zD8IPyBKQasKJf+PaUe
	tXVkoxUD+9BEIF1UCgqCGpre6w+5pb8xkrHfK0YQFpfsSs2rtQfPZwmn6auKWhmBTJ7nKi
	vCfO/rZ58Es18bB7WanpoKkUdXacYOjmBdykrMYY5QyNlqTBaDv64WyGfWybDw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/3] net: netdevsim: Add PHY support in netdevsim
Date: Wed,  2 Jul 2025 10:28:03 +0200
Message-ID: <20250702082806.706973-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh

With the introduction of phy_link_topology, we have the ability to keep
track of PHY devices that sit behind a net_device. While we still can
only attach one single PHY to a netdev, we can look at all these PHYs
through netlink, with the ETHTOOL_MSG_PHY_GET command.

Moreover, netlink commands that are targeting PHY devices also now
allow specifying which PHY we want to address in a given netlink
command.

That whole process comes with its own complexity, and a few bugs were
dicovered over the months following the introduction of
phy_link_topology.

As devices with multiple PHYs are fairly uncommon, testing the corner
cases of multi-phy setups proves to be difficult.

To that extent, introduce PHY support in netdevsim. The main goal (for
now) is not to be able to test PHYlib, but these phy-specific
netlink interfaces.

These netdevsim PHYs use a custom phy_driver that relies on
re-implementing the phy_driver callbacks. In other words, this is not a
PHY driver that relies on mdio emulation, and will not work with any of
the genphy helpers.

The debugfs API for PHY creation and deletion works as follows :

PHY device creation :

echo $ID > /sys/kernel/debug/netdevsim/netdevsimXXX/ports/YY/phy_add

if $ID is 0, then the PHY parent will be the netdev corresponding to the
port's netdev. The first PHY that is added with the netdev as a parent
will be attached to the netdev.

if $ID > 0, the index must correspond to a previously added PHY. This
allows creating any arbitrary tree of PHYs.

Upon PHY addition, a phyXX directory will be created, XX being the
phyindex of the PHY in the topology:

 [...]/ports/YY/phyXX/

This directory contains a "link" file, allowing to toggle the virtual
PHY's link state.

One can then list the PHYs with "ethtool --show-phys ethX".

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/netdevsim/Makefile    |   4 +
 drivers/net/netdevsim/dev.c       |   2 +
 drivers/net/netdevsim/netdev.c    |   3 +
 drivers/net/netdevsim/netdevsim.h |  14 ++
 drivers/net/netdevsim/phy.c       | 387 ++++++++++++++++++++++++++++++
 5 files changed, 410 insertions(+)
 create mode 100644 drivers/net/netdevsim/phy.c

diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index f8de93bc5f5b..49f4c515e5e3 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -21,3 +21,7 @@ endif
 ifneq ($(CONFIG_MACSEC),)
 netdevsim-objs += macsec.o
 endif
+
+ifneq ($(CONFIG_PHYLIB),)
+netdevsim-objs += phy.o
+endif
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 3e0b61202f0c..56209c5cc740 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1467,6 +1467,7 @@ static int nsim_dev_reload_create(struct nsim_dev *nsim_dev,
 	devlink = priv_to_devlink(nsim_dev);
 	nsim_dev = devlink_priv(devlink);
 	INIT_LIST_HEAD(&nsim_dev->port_list);
+	INIT_LIST_HEAD(&nsim_dev->phy_list);
 	nsim_dev->fw_update_status = true;
 	nsim_dev->fw_update_overwrite_mask = 0;
 
@@ -1540,6 +1541,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	nsim_dev->switch_id.id_len = sizeof(nsim_dev->switch_id.id);
 	get_random_bytes(nsim_dev->switch_id.id, nsim_dev->switch_id.id_len);
 	INIT_LIST_HEAD(&nsim_dev->port_list);
+	INIT_LIST_HEAD(&nsim_dev->phy_list);
 	nsim_dev->fw_update_status = true;
 	nsim_dev->fw_update_overwrite_mask = 0;
 	nsim_dev->max_macs = NSIM_DEV_MAX_MACS_DEFAULT;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2d..34bd48fc5b56 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -952,6 +952,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 
 	nsim_macsec_init(ns);
 	nsim_ipsec_init(ns);
+	nsim_phy_init(ns);
 
 	err = register_netdevice(ns->netdev);
 	if (err)
@@ -968,6 +969,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	return 0;
 
 err_ipsec_teardown:
+	nsim_phy_teardown(ns);
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
 	nsim_bpf_uninit(ns);
@@ -1058,6 +1060,7 @@ void nsim_destroy(struct netdevsim *ns)
 	RCU_INIT_POINTER(ns->peer, NULL);
 	unregister_netdevice(dev);
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
+		nsim_phy_teardown(ns);
 		nsim_macsec_teardown(ns);
 		nsim_ipsec_teardown(ns);
 		nsim_bpf_uninit(ns);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 4a0c48c7a384..b4ead16137d7 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -313,6 +313,7 @@ struct nsim_dev {
 	struct list_head bpf_bound_maps;
 	struct netdev_phys_item_id switch_id;
 	struct list_head port_list;
+	struct list_head phy_list;
 	bool fw_update_status;
 	u32 fw_update_overwrite_mask;
 	u32 max_macs;
@@ -418,6 +419,19 @@ static inline void nsim_macsec_teardown(struct netdevsim *ns)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_PHYLIB)
+void nsim_phy_init(struct netdevsim *ns);
+void nsim_phy_teardown(struct netdevsim *dev);
+#else
+static inline void nsim_phy_init(struct netdevsim *ns)
+{
+}
+
+static inline void nsim_phy_teardown(struct netdevsim *ns);
+{
+}
+#endif
+
 struct nsim_bus_dev {
 	struct device dev;
 	struct list_head list;
diff --git a/drivers/net/netdevsim/phy.c b/drivers/net/netdevsim/phy.c
new file mode 100644
index 000000000000..aee97167e4c2
--- /dev/null
+++ b/drivers/net/netdevsim/phy.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Maxime Chevallier <maxime.chevallier@bootlin.com>
+
+#include <linux/debugfs.h>
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/slab.h>
+#include <linux/phy.h>
+#include <linux/phy_fixed.h>
+#include <linux/phy_link_topology.h>
+#include <linux/platform_device.h>
+
+#include "netdevsim.h"
+
+static atomic_t bus_num = ATOMIC_INIT(0);
+
+/* Dumb MDIO bus for the virtual PHY to sit on */
+struct nsim_mdiobus {
+	struct platform_device *pdev;
+	struct mii_bus *mii;
+};
+
+static int nsim_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
+{
+	return 0;
+}
+
+static int nsim_mdio_write(struct mii_bus *bus, int phy_addr, int reg_num,
+			   u16 val)
+{
+	return 0;
+}
+
+struct nsim_phy_device {
+	struct phy_device *phy;
+	struct dentry *phy_dir;
+
+	struct list_head node;
+
+	bool link;
+};
+
+/* Virtual PHY driver for netdevsim */
+static int nsim_match_phy_device(struct phy_device *phydev,
+				 const struct phy_driver *drv)
+{
+	struct mii_bus *mii = phydev->mdio.bus;
+
+	return (mii->read == nsim_mdio_read) &&
+	       (mii->write == nsim_mdio_write);
+}
+
+static int nsim_get_features(struct phy_device *phydev)
+{
+	/* Act like a 1G PHY */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, phydev->supported);
+
+	return 0;
+}
+
+static int nsim_config_aneg(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static int nsim_read_status(struct phy_device *phydev)
+{
+	struct nsim_phy_device *ns_phy = phydev->priv;
+
+	if (!ns_phy)
+		return 0;
+
+	if (ns_phy->link) {
+		phydev->speed = SPEED_1000;
+		phydev->duplex = DUPLEX_FULL;
+	} else {
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+	}
+
+	phydev->link = ns_phy->link;
+
+	return 0;
+}
+
+static struct phy_driver nsim_virtual_phy_drv[] = {
+	{
+		.name			= "Netdevsim virtual PHY driver",
+		.get_features		= nsim_get_features,
+		.match_phy_device	= nsim_match_phy_device,
+		.config_aneg		= nsim_config_aneg,
+		.read_status		= nsim_read_status,
+	},
+};
+
+module_phy_driver(nsim_virtual_phy_drv);
+
+static struct nsim_mdiobus *nsim_mdiobus_create(void)
+{
+	struct nsim_mdiobus *mb;
+
+	mb = kzalloc(sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return NULL;
+
+	mb->pdev = platform_device_register_simple("nsim MDIO bus",
+						   atomic_read(&bus_num),
+						   NULL, 0);
+	if (IS_ERR(mb->pdev))
+		goto free_mb;
+
+	mb->mii = mdiobus_alloc();
+	if (!mb->mii)
+		goto free_pdev;
+
+	snprintf(mb->mii->id, MII_BUS_ID_SIZE, "nsim-%d", atomic_read(&bus_num));
+	atomic_inc(&bus_num);
+	mb->mii->name = "nsim MDIO Bus";
+	mb->mii->priv = mb;
+	mb->mii->parent = &mb->pdev->dev;
+	mb->mii->read = &nsim_mdio_read;
+	mb->mii->write = &nsim_mdio_write;
+	mb->mii->phy_mask = ~0;
+
+	if (mdiobus_register(mb->mii))
+		goto free_mdiobus;
+
+	return mb;
+
+free_mdiobus:
+	atomic_dec(&bus_num);
+	mdiobus_free(mb->mii);
+free_pdev:
+	platform_device_unregister(mb->pdev);
+free_mb:
+	kfree(mb);
+
+	return NULL;
+}
+
+static void nsim_mdiobus_destroy(struct nsim_mdiobus *mb)
+{
+	mdiobus_unregister(mb->mii);
+	mdiobus_free(mb->mii);
+	atomic_dec(&bus_num);
+	platform_device_unregister(mb->pdev);
+	kfree(mb);
+}
+
+static struct nsim_phy_device *nsim_phy_register(void)
+{
+	struct nsim_phy_device *ns_phy;
+	struct nsim_mdiobus *mb;
+	int err;
+
+	mb = nsim_mdiobus_create();
+	if (IS_ERR(mb))
+		return ERR_CAST(mb);
+
+	ns_phy = kzalloc(sizeof(*ns_phy), GFP_KERNEL);
+	if (!ns_phy) {
+		err = -ENOMEM;
+		goto out_mdio;
+	}
+
+	INIT_LIST_HEAD(&ns_phy->node);
+
+	ns_phy->phy = get_phy_device(mb->mii, 0, false);
+	if (IS_ERR(ns_phy->phy)) {
+		err = PTR_ERR(ns_phy->phy);
+		goto out_phy_free;
+	}
+
+	err = phy_device_register(ns_phy->phy);
+	if (err)
+		goto out_phy;
+
+	ns_phy->phy->priv = ns_phy;
+
+	return ns_phy;
+
+out_phy:
+	phy_device_free(ns_phy->phy);
+out_phy_free:
+	kfree(ns_phy);
+out_mdio:
+	nsim_mdiobus_destroy(mb);
+	return ERR_PTR(err);
+}
+
+static void nsim_phy_destroy(struct nsim_phy_device *ns_phy)
+{
+	struct phy_device *phydev = ns_phy->phy;
+	struct mii_bus *mii = phydev->mdio.bus;
+	struct nsim_mdiobus *mb = mii->priv;
+
+	debugfs_remove_recursive(ns_phy->phy_dir);
+
+	phy_device_remove(phydev);
+	list_del(&ns_phy->node);
+	kfree(ns_phy);
+
+	nsim_mdiobus_destroy(mb);
+}
+
+static int nsim_phy_state_link_set(void *data, u64 val)
+{
+	struct nsim_phy_device *ns_phy = (struct nsim_phy_device *)data;
+
+	ns_phy->link = !!val;
+
+	phy_trigger_machine(ns_phy->phy);
+
+	return 0;
+}
+
+static int nsim_phy_state_link_get(void *data, u64 *val)
+{
+	struct nsim_phy_device *ns_phy = (struct nsim_phy_device *)data;
+
+	*val = ns_phy->link;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nsim_phy_state_link_fops, nsim_phy_state_link_get,
+			 nsim_phy_state_link_set, "%llu\n");
+
+static void nsim_phy_debugfs_create(struct nsim_dev_port *port,
+				    struct nsim_phy_device *ns_phy)
+{
+	char phy_dir_name[sizeof("phy") + 10];
+
+	sprintf(phy_dir_name, "phy%u", ns_phy->phy->phyindex);
+
+	/* create debugfs stuff */
+	ns_phy->phy_dir = debugfs_create_dir(phy_dir_name, port->ddir);
+
+	debugfs_create_file("link", 0600, ns_phy->phy_dir, ns_phy, &nsim_phy_state_link_fops);
+}
+
+static void nsim_adjust_link(struct net_device *dev)
+{
+	phy_print_status(dev->phydev);
+}
+
+static ssize_t
+nsim_phy_add_write(struct file *file, const char __user *data,
+		   size_t count, loff_t *ppos)
+{
+	struct net_device *dev = file->private_data;
+	struct netdevsim *ns = netdev_priv(dev);
+	struct nsim_phy_device *ns_phy;
+	struct phy_device *pphy;
+	u32 parent_id;
+	char buf[10];
+	ssize_t ret;
+	int err;
+
+	if (*ppos != 0)
+		return 0;
+
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
+	ret = copy_from_user(buf, data, count);
+	if (ret)
+		return -EFAULT;
+	buf[count] = '\0';
+
+	ret = kstrtouint(buf, 10, &parent_id);
+	if (ret)
+		return -EINVAL;
+
+	ns_phy = nsim_phy_register();
+	if (IS_ERR(ns_phy))
+		return PTR_ERR(ns_phy);
+
+	if (!parent_id) {
+		if (!dev->phydev) {
+			err = phy_connect_direct(dev, ns_phy->phy, nsim_adjust_link,
+						 PHY_INTERFACE_MODE_NA);
+			if (err)
+				return err;
+
+			phy_attached_info(ns_phy->phy);
+
+			phy_start(ns_phy->phy);
+		} else {
+			phy_link_topo_add_phy(dev, ns_phy->phy, PHY_UPSTREAM_MAC, dev);
+		}
+	} else {
+		pphy = phy_link_topo_get_phy(dev, parent_id);
+		if (!pphy)
+			return -EINVAL;
+
+		phy_link_topo_add_phy(dev, ns_phy->phy, PHY_UPSTREAM_PHY, pphy);
+	}
+
+	nsim_phy_debugfs_create(ns->nsim_dev_port, ns_phy);
+
+	list_add(&ns_phy->node, &ns->nsim_dev->phy_list);
+
+	return count;
+}
+
+static const struct file_operations nsim_phy_add_fops = {
+	.open = simple_open,
+	.write = nsim_phy_add_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t
+nsim_phy_del_write(struct file *file, const char __user *data,
+		   size_t count, loff_t *ppos)
+{
+	struct net_device *dev = file->private_data;
+	struct nsim_phy_device *ns_phy;
+	struct phy_device *phydev;
+	u32 phy_index;
+	char buf[10];
+	ssize_t ret;
+
+	if (*ppos != 0)
+		return 0;
+
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
+	ret = copy_from_user(buf, data, count);
+	if (ret)
+		return -EFAULT;
+	buf[count] = '\0';
+
+	ret = kstrtouint(buf, 10, &phy_index);
+	if (ret)
+		return -EINVAL;
+
+	phydev = phy_link_topo_get_phy(dev, phy_index);
+	if (!phydev)
+		return -ENODEV;
+
+	ns_phy = phydev->priv;
+
+	if (dev->phydev && dev->phydev == phydev) {
+		phy_stop(phydev);
+		phy_detach(phydev);
+	} else {
+		phy_link_topo_del_phy(dev, phydev);
+	}
+
+	nsim_phy_destroy(ns_phy);
+
+	return count;
+}
+
+static const struct file_operations nsim_phy_del_fops = {
+	.open = simple_open,
+	.write = nsim_phy_del_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
+void nsim_phy_init(struct netdevsim *ns)
+{
+	debugfs_create_file("phy_add", 0200, ns->nsim_dev_port->ddir,
+			    ns->netdev, &nsim_phy_add_fops);
+
+	debugfs_create_file("phy_del", 0200, ns->nsim_dev_port->ddir,
+			    ns->netdev, &nsim_phy_del_fops);
+}
+
+void nsim_phy_teardown(struct netdevsim *ns)
+{
+	struct nsim_phy_device *ns_phy, *pos;
+
+	list_for_each_entry_safe(ns_phy, pos, &ns->nsim_dev->phy_list, node)
+		nsim_phy_destroy(ns_phy);
+}
-- 
2.49.0


