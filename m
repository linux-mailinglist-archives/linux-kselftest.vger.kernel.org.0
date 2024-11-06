Return-Path: <linux-kselftest+bounces-21514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C5B9BE22C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 10:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE861C23057
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8E1DA0F5;
	Wed,  6 Nov 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ArqnVZKW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB11D9A43;
	Wed,  6 Nov 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884670; cv=none; b=IbTNvva7TxLT9HQbnTBX/AOOtXLAB2VqQdYX1R7A7i56uH0QsrTMuFIsGBmiUGAuC5vUdFa2jCgjN/2qfCmCHAGOpcC2n4nBZLisDubb+7++mZZnJXUxOZyYIEOhzuYkB4LCDLTUshR0HKC+ncYpeJwarxh1ISFwgMkXT2sMMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884670; c=relaxed/simple;
	bh=iybPhtj+VaqBV+8Z7GPMqsFnnqq4saROenEfCPkI7EU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9EtcpdsYior4OFA6o++RbKA3xcQV/K65iJBkaTzVYlr21Tw51/QzZ68aGS5FryuwdG5SWPtiz9gNHKcVlMr8w+JqjK3/QAFTHMpbJPH27D+5OaOXlcGFPOZi6yNF/WHy3y7srVXR0OiUosYioTRRMyH9qbBcv8MQE5aEWfK3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ArqnVZKW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HHux048286;
	Wed, 6 Nov 2024 03:17:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730884637;
	bh=xfFsXCilJAWJMiM7vp79c/LdD1Soku/0QJA8c8QwWkY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ArqnVZKWwG87Er10+uMO1WqEapkRMC14fbSvdzAA408LuPBvdsFGjZTgkvQanzSVE
	 Nv5SMg/MgVWvPbQ3LWwXV2/4yAxRQ30gNv5r4AUaktLOqEdwYncVF6DjlD/TElWsBk
	 A3iYrr1gmIcWcPS+LWACPuDzkJ+AxQFzJ/XdQ8GA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A69HHdg116859
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 03:17:17 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 03:17:16 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 03:17:16 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HGNn081242;
	Wed, 6 Nov 2024 03:17:16 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A69HGN6020787;
	Wed, 6 Nov 2024 03:17:16 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <jiri@resnulli.us>,
        <w-kwok2@ti.com>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 2/4] net: hsr: Add VLAN CTAG filter support
Date: Wed, 6 Nov 2024 14:47:08 +0530
Message-ID: <20241106091710.3308519-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>
References: <20241106091710.3308519-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Murali Karicheri <m-karicheri2@ti.com>

This patch adds support for VLAN ctag based filtering at slave devices.
The slave ethernet device may be capable of filtering ethernet packets
based on VLAN ID. This requires that when the VLAN interface is created
over an HSR/PRP interface, it passes the VID information to the
associated slave ethernet devices so that it updates the hardware
filters to filter ethernet frames based on VID. This patch adds the
required functions to propagate the vid information to the slave
devices.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 net/hsr/hsr_device.c | 80 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 0ca47ebb01d3..9e64496a5c1c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -515,6 +515,77 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 	}
 }
 
+static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
+				   __be16 proto, u16 vid)
+{
+	bool is_slave_a_added = false;
+	bool is_slave_b_added = false;
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+	int ret = 0;
+
+	hsr = netdev_priv(dev);
+
+	hsr_for_each_port(hsr, port) {
+		if (port->type == HSR_PT_MASTER ||
+		    port->type == HSR_PT_INTERLINK)
+			continue;
+
+		ret = vlan_vid_add(port->dev, proto, vid);
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+			if (ret) {
+				/* clean up Slave-B */
+				netdev_err(dev, "add vid failed for Slave-A\n");
+				if (is_slave_b_added)
+					vlan_vid_del(port->dev, proto, vid);
+				return ret;
+			}
+
+			is_slave_a_added = true;
+			break;
+
+		case HSR_PT_SLAVE_B:
+			if (ret) {
+				/* clean up Slave-A */
+				netdev_err(dev, "add vid failed for Slave-B\n");
+				if (is_slave_a_added)
+					vlan_vid_del(port->dev, proto, vid);
+				return ret;
+			}
+
+			is_slave_b_added = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
+				    __be16 proto, u16 vid)
+{
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+
+	hsr = netdev_priv(dev);
+
+	hsr_for_each_port(hsr, port) {
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+		case HSR_PT_SLAVE_B:
+			vlan_vid_del(port->dev, proto, vid);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops hsr_device_ops = {
 	.ndo_change_mtu = hsr_dev_change_mtu,
 	.ndo_open = hsr_dev_open,
@@ -523,6 +594,8 @@ static const struct net_device_ops hsr_device_ops = {
 	.ndo_change_rx_flags = hsr_change_rx_flags,
 	.ndo_fix_features = hsr_fix_features,
 	.ndo_set_rx_mode = hsr_set_rx_mode,
+	.ndo_vlan_rx_add_vid = hsr_ndo_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = hsr_ndo_vlan_rx_kill_vid,
 };
 
 static const struct device_type hsr_type = {
@@ -569,7 +642,8 @@ void hsr_dev_setup(struct net_device *dev)
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
 			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
-			   NETIF_F_HW_VLAN_CTAG_TX;
+			   NETIF_F_HW_VLAN_CTAG_TX |
+			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	dev->features = dev->hw_features;
 }
@@ -647,6 +721,10 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
 		hsr->fwd_offloaded = true;
 
+	if ((slave[0]->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    (slave[1]->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		hsr_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
 	res = register_netdevice(hsr_dev);
 	if (res)
 		goto err_unregister;
-- 
2.34.1


