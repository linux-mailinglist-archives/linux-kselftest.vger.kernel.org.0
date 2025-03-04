Return-Path: <linux-kselftest+bounces-28114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12901A4CFFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3B73AD5F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C286353;
	Tue,  4 Mar 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dRYQ/frZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1073C6BA
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048474; cv=none; b=GQMvj+MfVbSgIWZZCdGt4Dq+bYhQ70SfxQNZmxg4xCIKxd00BCexp/hYDMaA31qzjfWuZOHZYtX5FEiIOtA5V/pFD86AV6QQR/vfS899Ejw1DBmFNF0+2Kl14orEU3q+oaHY6OX1lib8tHFyOfoz5Ipj3RVbAQH3l1WhhzxgbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048474; c=relaxed/simple;
	bh=25WcvXTXXfxmaAOMMXXVGWiLyABvuKjQ8rGP48etX7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNOzUGKjbVQ+iLYlhT+19eRP8xg5q8JCYPmXOccFgAwttt3gzu+v1USSNV+IIlWtMEYoQ0Nr4yObXU8bBbFOXTUMxvGY5pe8RJbqvAMjhvyq6QmK7WJms0xrtFWoboD7vrWrTiWUF5/S4SxpoUHOXknL9RhuCPfGDscw67nRwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dRYQ/frZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so46000805e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048470; x=1741653270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xykxWwQtRQScKaKMa944tYFSQu7MzdfyLK7JpJAtJQ=;
        b=dRYQ/frZmHo/N/UCb82uzPg1pt2EIHerAoSb3/+lzhah44RvNPCJsE3xG4A7PEn9WH
         M8VOGpz6K0V+ELLOplyhVrO8Aj0CLXrODPZJH20bs++DsksHqqZ5y03VDezn9ng63vXZ
         IGAMBE5N4U9+kyXUwB1jRdJRFRrQaGT7Knkp6Je+iZ0uBjJpBRo8TaYz/LWdd2wKjdw4
         SodSnjrZ3obtZzK315nEliLW/PRSOILBU6O/qGJq2jkkqC8mpRFHorf9LPNgs9ytwyEW
         54y9lXl7Uzoj6AS/2Q4NcFUWMM0omZpOci5+u4zFwTAAkp7+OH8RtmrAgfUe4ZSIPFEg
         6GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048470; x=1741653270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xykxWwQtRQScKaKMa944tYFSQu7MzdfyLK7JpJAtJQ=;
        b=sfIgG6+GDXMgP71Ikq8yCFpz0a/VKhimR70sF5CNJHUtUDH8I27/cpailRrcs21RlE
         Nh2UkEpqH5KlFNelu+sCPChoeHuei9uXP+7cqT/AoxNo7n7W+SKaTDYij/PRmixCeZj/
         6Rmhv9DF/u2epP90sFyRMK2bEOR3tj/kzust8pu7kOTVdPzqlpV3ZrpOVu5yxdNHGkEP
         8owjOG895bQt26CnzM8EgYbB++9TEL7osajShVjcG4tl2B9SkynfYoWFH49EQoUomD7P
         yGxnYFLs41qPYh9SAn/17EIcFf01Uogh+I5qHWwQfmpESrSSqtOIpKUgyxt8N9wJ5V51
         zvdA==
X-Forwarded-Encrypted: i=1; AJvYcCXPj0GyUVLHdxIBMngOWKMdXVS3PxIJHBTiFHDjcCpHNZ9azEgWXcU1Y3uWt7TG4doGOlCIJzcRBYrb6NiLVyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmi1Oo/dA4pEpdclUpk2bG5RTs1xyMAC04X4B/4sht/GJmZrgv
	VR3PaL8/yG0bgmLEzdGFmJS00WVh5BusIRx2K0qTFTe2XDmAz/UkWZ0Cctvpen8=
X-Gm-Gg: ASbGncsDwJIbJAnfvs8gx5KKJKZx5xNmZprlR5p0kYyhYJZkNDr3kAFgY3smTATOODc
	WarEciNSOSsLYlwWJGSZ+zaeSBujH0p71blUQadVQdsjUxM8Uk2kyS06Q7iBJeoUwT1QBWdzrgZ
	jIqQQqE2Aenk++h2UkdzbcvAhqgNlM9meTzRCAKfSUhwroX8eijdmQXW3Oqklwfa+bJmIIDwQrl
	08/fRq1nMsFEl1saiXOFamRZECuuLoCYdDJbhPK0uBmVrTLIC4P1jjlyud1kI8IhExA1x09JP7y
	Vbzc//51o/yvErnDduSmrROFAKTqzfjgfOsttQYziQ==
X-Google-Smtp-Source: AGHT+IGqgrorMUrKzaeqqL6qe0h7/qXp+8hlLDS19rgjhzSWaoXfIiWr0MYfJ08Si96kMc6qMzp3Pg==
X-Received: by 2002:a05:6000:1867:b0:390:fb04:f930 with SMTP id ffacd0b85a97d-390fb04fb52mr8726802f8f.34.1741048470434;
        Mon, 03 Mar 2025 16:34:30 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:30 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:33 +0100
Subject: [PATCH v21 03/24] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-3-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11062; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=25WcvXTXXfxmaAOMMXXVGWiLyABvuKjQ8rGP48etX7A=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqOD+vf7rLajLPXPjiHVBzrPMnqHCdje87aJ
 JKUT3oL4PyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjgAKCRALcOU6oDjV
 h7vEB/907ihDPOoFnHhL+kJ8RXkfOsgEK8c4gg6qoPrdq4MrqFCf1WfngB6BMHVAD2kN0P12ipR
 94bCLm7s2KxaGD1NV+47V1zUfdtrJgQwMntLhhfXU4qxpGkhdE7WoZyx2RezFhjNWQL4W+G1m+6
 dSLOiVvJF4aMOzjr90irjC0SQo1tcUff81vwFVVkWVLykKYUx62jn8BrDqwtSNoYT9/WheN+AlZ
 fPpvoi2sBwNd70OJXxnmZxCJCZu39d9/rSqe675xY0WkWemNF0VM2+55fyVfvGPN1gRkLMxLWtb
 CnnuG8HQXpROsj/ZUQmpK0LCY1KJe95anAhPY1Z9nXinONQs
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Tested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/rt_link.yaml |  16 +++++
 drivers/net/ovpn/Makefile                |   1 +
 drivers/net/ovpn/io.c                    |  22 ++++++
 drivers/net/ovpn/io.h                    |  24 +++++++
 drivers/net/ovpn/main.c                  | 114 +++++++++++++++++++++++++++++--
 drivers/net/ovpn/ovpnpriv.h              |   7 ++
 drivers/net/ovpn/proto.h                 |  38 +++++++++++
 include/uapi/linux/if_link.h             |  15 ++++
 8 files changed, 232 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8b5c0f067328553dde5e29a8aaa25c8e6aed3b42..d604f8752d73a607e987cc516fce0acb2f3a469e 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -938,6 +938,12 @@ definitions:
     entries:
       - name: none
       - name: default
+  -
+    name: ovpn-mode
+    type: enum
+    entries:
+      - p2p
+      - mp
 
 attribute-sets:
   -
@@ -2269,6 +2275,13 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+  -
+    name: linkinfo-ovpn-attrs
+    attributes:
+      -
+        name: mode
+        type: u8
+        enum: ovpn-mode
 
 sub-messages:
   -
@@ -2319,6 +2332,9 @@ sub-messages:
       -
         value: netkit
         attribute-set: linkinfo-netkit-attrs
+      -
+        value: ovpn
+        attribute-set: linkinfo-ovpn-attrs
   -
     name: linkinfo-member-data-msg
     formats:
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 75ac62bba02937bc49cb2a0dec5ca3cc31a8ee00..0e5f686672fb5052cee5a2c28797b70859514a7f 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,5 +8,6 @@
 
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += main.o
+ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
new file mode 100644
index 0000000000000000000000000000000000000000..4b71c38165d7adbb1a2d1a64d27a13b7f76cfbfe
--- /dev/null
+++ b/drivers/net/ovpn/io.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
+#include "io.h"
+
+/* Send user data to the network
+ */
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	skb_tx_error(skb);
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
new file mode 100644
index 0000000000000000000000000000000000000000..afea5f81f5628dcb9afda9a78974bbf6f2101c13
--- /dev/null
+++ b/drivers/net/ovpn/io.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPN_H_
+#define _NET_OVPN_OVPN_H_
+
+/* DATA_V2 header size with AEAD encryption */
+#define OVPN_HEAD_ROOM (OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE +	   \
+			16 /* AEAD TAG length */ +			   \
+			max(sizeof(struct udphdr), sizeof(struct tcphdr)) +\
+			max(sizeof(struct ipv6hdr), sizeof(struct iphdr)))
+
+/* max padding required by encryption */
+#define OVPN_MAX_PADDING 16
+
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+
+#endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 28133e7e15e74b8a4a937ed03f70d9f83d7a14c8..e71183e6f42cd801861caaec9eb0f6828b64cda9 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,14 +10,42 @@
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <net/ip.h>
 #include <net/rtnetlink.h>
-#include <uapi/linux/ovpn.h>
+#include <uapi/linux/if_arp.h>
 
 #include "ovpnpriv.h"
 #include "main.h"
 #include "netlink.h"
+#include "io.h"
+#include "proto.h"
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
 
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
+	.ndo_stop		= ovpn_net_stop,
+	.ndo_start_xmit		= ovpn_net_xmit,
+};
+
+static const struct device_type ovpn_type = {
+	.name = OVPN_FAMILY_NAME,
+};
+
+static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
+	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
+					    OVPN_MODE_MP),
 };
 
 /**
@@ -31,44 +59,120 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_setup(struct net_device *dev)
+{
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
+				 NETIF_F_HIGHDMA;
+
+	dev->needs_free_netdev = true;
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	dev->netdev_ops = &ovpn_netdev_ops;
+
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
+	dev->min_mtu = IPV4_MIN_MTU;
+	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
+
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	dev->lltx = true;
+	dev->features |= feat;
+	dev->hw_features |= feat;
+	dev->hw_enc_features |= feat;
+
+	dev->needed_headroom = ALIGN(OVPN_HEAD_ROOM, 4);
+	dev->needed_tailroom = OVPN_MAX_PADDING;
+
+	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
+}
+
 static int ovpn_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct nlattr **data = params->data;
+	enum ovpn_mode mode = OVPN_MODE_P2P;
+
+	if (data && data[IFLA_OVPN_MODE]) {
+		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
+		netdev_dbg(dev, "setting device mode: %u\n", mode);
+	}
+
+	ovpn->dev = dev;
+	ovpn->mode = mode;
+
+	/* turn carrier explicitly off after registration, this way state is
+	 * clearly defined
+	 */
+	netif_carrier_off(dev);
+
+	return register_netdevice(dev);
+}
+
+static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	if (nla_put_u8(skb, IFLA_OVPN_MODE, ovpn->mode))
+		return -EMSGSIZE;
+
+	return 0;
 }
 
 static struct rtnl_link_ops ovpn_link_ops = {
 	.kind = "ovpn",
 	.netns_refund = false,
+	.priv_size = sizeof(struct ovpn_priv),
+	.setup = ovpn_setup,
+	.policy = ovpn_policy,
+	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
 	.dellink = unregister_netdevice_queue,
+	.fill_info = ovpn_fill_info,
 };
 
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ovpn_priv *ovpn;
 
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
+		netif_carrier_off(dev);
+		ovpn->registered = false;
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
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index f9322536b06d6baa5524de57cd7d69f5ecbbd194..33c2a41edf9b3204e8aebd2679649cb7158f05f2 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -10,12 +10,19 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <uapi/linux/if_link.h>
+#include <uapi/linux/ovpn.h>
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
+ * @registered: whether dev is still registered with netdev or not
+ * @mode: device operation mode (i.e. p2p, mp, ..)
  */
 struct ovpn_priv {
 	struct net_device *dev;
+	bool registered;
+	enum ovpn_mode mode;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 0000000000000000000000000000000000000000..5f95a78bebd3702868ffeeab3ea4938e957d568c
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_PROTO_H_
+#define _NET_OVPN_PROTO_H_
+
+/* When the OpenVPN protocol is ran in AEAD mode, use
+ * the OpenVPN packet ID as the AEAD nonce:
+ *
+ *    00000005 521c3b01 4308c041
+ *    [seq # ] [  nonce_tail   ]
+ *    [     12-byte full IV    ] -> OVPN_NONCE_SIZE
+ *    [4-bytes                   -> OVPN_NONCE_WIRE_SIZE
+ *    on wire]
+ */
+
+/* nonce size (96bits) as required by AEAD ciphers */
+#define OVPN_NONCE_SIZE			12
+/* last 8 bytes of AEAD nonce: provided by userspace and usually derived
+ * from key material generated during TLS handshake
+ */
+#define OVPN_NONCE_TAIL_SIZE		8
+
+/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
+ * size of the AEAD Associated Data (AD) sent over the wire
+ * and is normally the head of the IV
+ */
+#define OVPN_NONCE_WIRE_SIZE (OVPN_NONCE_SIZE - OVPN_NONCE_TAIL_SIZE)
+
+#define OVPN_OPCODE_SIZE		4 /* DATA_V2 opcode size */
+
+#endif /* _NET_OVPN_PROTO_H_ */
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3b586fb0bc4cddf6655d48ba7b31ab1c200532d6..cfae55af7a36b9581cd74c50e15fbc992501265d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1985,4 +1985,19 @@ enum {
 
 #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
 
+/* OVPN section */
+
+enum ovpn_mode {
+	OVPN_MODE_P2P,
+	OVPN_MODE_MP,
+};
+
+enum {
+	IFLA_OVPN_UNSPEC,
+	IFLA_OVPN_MODE,
+	__IFLA_OVPN_MAX,
+};
+
+#define IFLA_OVPN_MAX	(__IFLA_OVPN_MAX - 1)
+
 #endif /* _UAPI_LINUX_IF_LINK_H */

-- 
2.45.3


