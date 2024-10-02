Return-Path: <linux-kselftest+bounces-18871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9CE98CF7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1841C2243D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745A1993B2;
	Wed,  2 Oct 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="anYIKqgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9A1990C5
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859806; cv=none; b=A4hPclBhGl+HSSleP+mbSp3zHhC6FPONjpeAc/Ahe+VxNcCn9Se1eOp2qUxrcERxYsZbhlFM8uTJIOJvZPGNC0+vS0Bcc0K0pKnr9Gcm506JwhxuSv0tBYLweJx+VCFopXHeIfyVzC4ymkA/j/cGQZb5/Hl2NQ9fArw5MT3Ryp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859806; c=relaxed/simple;
	bh=DIpuUUDY3GRlEUUrEhbuRpskwknYIwZYdipVwnz546E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKOdYQ+IHD0rGWa1OSROWWCaxp6wRImL5mZeEST3uXOw+9vhzpOPYNA2iZW8vGUV/rRJOirGQcRKgxh2seSEeeqs6XepTJkSSptMpaO5teQB/1C6GOiBpUCPZiL7EyTUb20yhBrX0vUW3HSC6IT5+uzp+T6E3OsXmKVNBK43/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=anYIKqgD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so78950035e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859803; x=1728464603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z8ZpLfimM7LzCfY1ZNyuvgF6DFul/5gZSvdvpf3KJk=;
        b=anYIKqgDbw3DoeWC9NWZbDeYHZi7fSvRqTiPLm6bPGb3HXqCWVmcKtJ1WSJWkz+ZWL
         Cw2idP0KV52pnTKnQyZVmEpl5rtdq4rCB7YuX9odxWfMnEHplIpE/3wk5ifEZ29knVxf
         gjcjXKsRlLM+H2npdI1ojIGZn0PPj+IBJRJ3b0M155TEq9FIVw8WODUfMpvYlFHCx/y2
         8A3FI4wQxo2lYWo54Jv3hwYfnmVLPLR78zfaEuKeuUFE6p0bHHzaFnWzWRjhlGsDfzEO
         iEB+yS9DuSCVu4wYNiw1grUOfY2OLBaz1l/b1DL7UfNC8Y6UeUiMJ9CfNc1cwbSA0S/1
         WFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859803; x=1728464603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z8ZpLfimM7LzCfY1ZNyuvgF6DFul/5gZSvdvpf3KJk=;
        b=LzEleChG4qF8Sa346IvPNQ1JfB6XxWk1QvG9IV+kMAutKddFH7gY+dDIbYp7gquEFG
         8IYrT1h+VsEzguzCql9k72Sap+nRXDWAVP41mLIrzoW83efFpqh+XAyZSiIyhJNwP0WZ
         eH1I6vi3YbCQFi7ncuFuyuHZeoEF2UFXpSScJLOMdaY5YGwebZP0FCtb9x397jdOcJNe
         V+IRks7/yarr9PnK/IOVw0/Mq1AP7aa9ZbJVmp6+4/+imqwSIRZZoy/xwS+nhxJNXq9i
         x1QPazPZ3hLKgQWxbQqf/2t99tUPfGbnevnrgIBspBXmmQSft3PMmFEV4rVAAn8eMhk3
         IWNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/5mJCjqCr7iaXQPNfjnPpYQ6s636CRExCNLHVjw+hoGFS4qCnxjPhDUbMRmzyAZAyx21qazRaH3pZUtv8syo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+/9gFn3+Dc3Lb88ies/8MBjSt5fJdvJ/HHgJuhM+fn6Z+Qaj
	sHVZctE6oq37LYUrHpHQvVBa3/yJjmUuY/NLYGiHNw6KIAJUsCHDX1ui7CqcbKs=
X-Google-Smtp-Source: AGHT+IEOpey/bP6bSL4EQuxf2z/duiQC8NL+7U6+rWg9esJtKpHy98fQnYAapgwc0M/2pCXHTz69Lg==
X-Received: by 2002:adf:e712:0:b0:37c:d1c6:7e45 with SMTP id ffacd0b85a97d-37cfba0a614mr1829865f8f.40.1727859802575;
        Wed, 02 Oct 2024 02:03:22 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:18 +0200
Subject: [PATCH net-next v8 04/24] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-4-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8913; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=DIpuUUDY3GRlEUUrEhbuRpskwknYIwZYdipVwnz546E=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxRPVTa12H/yL2qOmwI1c6KpjsMMs57sm/A6
 bIhOxtOIliJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUQAKCRALcOU6oDjV
 h5zDB/9jFM84v2mA/ZkKXmBfEBTQAadCBkvp/EUdya+6R/lHa59dADFGRrzlEl2Ets74OPIzI+F
 X93gTaccliJH5SxWQ7Pp9J4qXMh/3NxdwxxyZKXnLeSSkWT2LlyF8sNdai6F/jjSWDz1p6yniV3
 IM7iBiYWjLlUqSBd1/DO2/qqHvdEEZsRbep5FfeAL4kz/CzlLh4P0S94ck2s5u4TiXQ6BCKgQcN
 EDi0O7c5FjbatO7PVMOkjKK06Pbjr2Gpdm/h1bmntxa8HVkmw1dLnH3IbE4SHP7qB3IgfnmcbNh
 Prm4tfgdAxlELInFZSBPSRi7M5DEhWIrn2CgJITJZGvKTn1o
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c       | 155 +++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/main.h       |  10 +++
 drivers/net/ovpn/ovpnstruct.h |   8 +++
 drivers/net/ovpn/packet.h     |  40 +++++++++++
 4 files changed, 210 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0274ddddbcd25080d7f85347f79aad0259771508..12f6258f94c8baef855e2ce90cf70380d5af5ca9 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,19 +10,58 @@
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
 #include <linux/version.h>
+#include <net/ip.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/if_arp.h>
 #include <uapi/linux/ovpn.h>
 
 #include "ovpnstruct.h"
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
+#include "packet.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
 #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
 
+/**
+ * ovpn_struct_init - Initialize the netdevice private area
+ * @dev: the device to initialize
+ * @mode: device operation mode (i.e. p2p, mp, ..)
+ */
+static void ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
+{
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+
+	ovpn->dev = dev;
+	ovpn->mode = mode;
+}
+
+static void ovpn_struct_free(struct net_device *net)
+{
+}
+
+static int ovpn_net_open(struct net_device *dev)
+{
+	netif_tx_start_all_queues(dev);
+	return 0;
+}
+
+static int ovpn_net_stop(struct net_device *dev)
+{
+	netif_tx_stop_all_queues(dev);
+	return 0;
+}
+
+static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
+	.ndo_stop		= ovpn_net_stop,
+	.ndo_start_xmit		= ovpn_net_xmit,
+};
+
 /**
  * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
  * @dev: the interface to check
@@ -40,30 +79,140 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.dellink = unregister_netdevice_queue,
 };
 
+static void ovpn_setup(struct net_device *dev)
+{
+	/* compute the overhead considering AEAD encryption */
+	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
+			     sizeof(struct udphdr) +
+			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
+
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
+				 NETIF_F_HIGHDMA;
+
+	dev->needs_free_netdev = true;
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	dev->netdev_ops = &ovpn_netdev_ops;
+	dev->rtnl_link_ops = &ovpn_link_ops;
+
+	dev->priv_destructor = ovpn_struct_free;
+
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->mtu = ETH_DATA_LEN - overhead;
+	dev->min_mtu = IPV4_MIN_MTU;
+	dev->max_mtu = IP_MAX_MTU - overhead;
+
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+
+	dev->lltx = true;
+	dev->features |= feat;
+	dev->hw_features |= feat;
+	dev->hw_enc_features |= feat;
+
+	dev->needed_headroom = OVPN_HEAD_ROOM;
+	dev->needed_tailroom = OVPN_MAX_PADDING;
+}
+
+/**
+ * ovpn_iface_create - create and initialize a new 'ovpn' netdevice
+ * @name: the name of the new device
+ * @mode: the OpenVPN mode to set this device to
+ * @net: the netns this device should be created in
+ *
+ * A new netdevice is created and registered.
+ * Its private area is initialized with an empty ovpn_struct object.
+ *
+ * Return: a pointer to the new device on success or a negative error code
+ *         otherwise
+ */
+struct net_device *ovpn_iface_create(const char *name, enum ovpn_mode mode,
+				     struct net *net)
+{
+	struct net_device *dev;
+	int ret;
+
+	dev = alloc_netdev(sizeof(struct ovpn_struct), name, NET_NAME_USER,
+			   ovpn_setup);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev_net_set(dev, net);
+	ovpn_struct_init(dev, mode);
+
+	rtnl_lock();
+	ret = register_netdevice(dev);
+	if (ret < 0) {
+		netdev_err(dev, "cannot register interface: %d\n", ret);
+		rtnl_unlock();
+		goto err;
+	}
+	/* turn carrier explicitly off after registration, this way state is
+	 * clearly defined
+	 */
+	netif_carrier_off(dev);
+	rtnl_unlock();
+
+	return dev;
+
+err:
+	free_netdev(dev);
+	return ERR_PTR(ret);
+}
+
+/**
+ * ovpn_iface_destruct - tear down netdevice
+ * @ovpn: the ovpn instance objected related to the interface to tear down
+ *
+ * This function takes care of tearing down an ovpn device and can be invoked
+ * internally or upon UNREGISTER netdev event
+ */
+void ovpn_iface_destruct(struct ovpn_struct *ovpn)
+{
+	ASSERT_RTNL();
+
+	netif_carrier_off(ovpn->dev);
+
+	ovpn->registered = false;
+}
+
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ovpn_struct *ovpn;
 
 	if (!ovpn_dev_is_valid(dev))
 		return NOTIFY_DONE;
 
+	ovpn = netdev_priv(dev);
+
 	switch (state) {
 	case NETDEV_REGISTER:
-		/* add device to internal list for later destruction upon
-		 * unregistration
-		 */
+		ovpn->registered = true;
 		break;
 	case NETDEV_UNREGISTER:
+		/* twiddle thumbs on netns device moves */
+		if (dev->reg_state != NETREG_UNREGISTERING)
+			break;
+
 		/* can be delivered multiple times, so check registered flag,
 		 * then destroy the interface
 		 */
+		if (!ovpn->registered)
+			return NOTIFY_DONE;
+
+		ovpn_iface_destruct(ovpn);
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
 	case NETDEV_UP:
 	case NETDEV_PRE_UP:
+		break;
 	default:
 		return NOTIFY_DONE;
 	}
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index a3215316c49bfcdf2496590bac878f145b8b27fd..4dfcba9deb590bbf119f51a40dff1517fe227b22 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -10,6 +10,16 @@
 #ifndef _NET_OVPN_MAIN_H_
 #define _NET_OVPN_MAIN_H_
 
+struct net_device *ovpn_iface_create(const char *name, enum ovpn_mode mode,
+				     struct net *net);
+void ovpn_iface_destruct(struct ovpn_struct *ovpn);
 bool ovpn_dev_is_valid(const struct net_device *dev);
 
+#define SKB_HEADER_LEN                                       \
+	(max(sizeof(struct iphdr), sizeof(struct ipv6hdr)) + \
+	 sizeof(struct udphdr) + NET_SKB_PAD)
+
+#define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
+#define OVPN_MAX_PADDING 16
+
 #endif /* _NET_OVPN_MAIN_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index ff248cad1401d00c5bf0aadf9341e40d0a4aee4b..ee05b8a2c61d7c5887e80c7f79e15a1336d99644 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,12 +10,20 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <uapi/linux/ovpn.h>
+
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
+ * @registered: whether dev is still registered with netdev or not
+ * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @dev_list: entry for the module wide device list
  */
 struct ovpn_struct {
 	struct net_device *dev;
+	bool registered;
+	enum ovpn_mode mode;
+	struct list_head dev_list;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ed146f5932a25f448af6da58738a7eae81007fe
--- /dev/null
+++ b/drivers/net/ovpn/packet.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_PACKET_H_
+#define _NET_OVPN_PACKET_H_
+
+/* When the OpenVPN protocol is ran in AEAD mode, use
+ * the OpenVPN packet ID as the AEAD nonce:
+ *
+ *    00000005 521c3b01 4308c041
+ *    [seq # ] [  nonce_tail   ]
+ *    [     12-byte full IV    ] -> NONCE_SIZE
+ *    [4-bytes                   -> NONCE_WIRE_SIZE
+ *    on wire]
+ */
+
+/* OpenVPN nonce size */
+#define NONCE_SIZE 12
+
+/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
+ * size of the AEAD Associated Data (AD) sent over the wire
+ * and is normally the head of the IV
+ */
+#define NONCE_WIRE_SIZE (NONCE_SIZE - sizeof(struct ovpn_nonce_tail))
+
+/* Last 8 bytes of AEAD nonce
+ * Provided by userspace and usually derived from
+ * key material generated during TLS handshake
+ */
+struct ovpn_nonce_tail {
+	u8 u8[OVPN_NONCE_TAIL_SIZE];
+};
+
+#endif /* _NET_OVPN_PACKET_H_ */

-- 
2.45.2


