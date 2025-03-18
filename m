Return-Path: <linux-kselftest+bounces-29309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DDA66554
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49A17A8892
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B1191F74;
	Tue, 18 Mar 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J00h25sB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97014EC60
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262069; cv=none; b=N+g+2zexmCg3X58A3xLGaRqZDP+ygdlfEyaZ3nQ9HkPGp7a22lUFSkd88PZeCGEvfl/ILhUu17AefUBtJ5aERc4or+2lMSVtdeV2/ksRl6PxNmZiR5wnmbrRhv9vla6DfxaFyrk/9BT6xpoxLFWt6U18wTHda1CFoBJWcS4fU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262069; c=relaxed/simple;
	bh=bDKZuviAY20IZ/1LOSZzXATQR29igS+laWQ4mQV6SF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhjMFQvJfyQhTgaOkyIAjunqTEvXFwV47ChC5Kvui6n6JDznRLQd4SFYhhmQI7/gHEOFsircccnZfbGyg7IOkHqm0VcCLeme0+bUGYxnZtzk8N8BhofD2/4g/4CnVGuhHW8pcVHW5cNwy8GFyh7sTBPaBZJF45X6Q0zxrmVmvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J00h25sB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3965c995151so3391883f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262065; x=1742866865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GsbPPoZ1bLKw9ud3y+SvcehyU6Mdn4kN0l3aZP0Qcc=;
        b=J00h25sBlGb9WktuK+kCtUgGj6yk+eV2jwiHFsbKfrMHmHYIab7PWdUq4j5B3baBJX
         PQA+VUpFqxGX5yquhY2aATohHRs2euDeV9n/MDmn8W2EqLU1jWDyDG3eMgNd28d7YeVs
         +rOOuVix3CoOZvVlMNU4iNwdrcBtPVAcX/p72gv2oTAV5GLuRglgAKg0BZZ/QklLkX2L
         +t6NaR9rCmY/J0VWpiMSWysfTNKBSQ5IPX0kgrXEX+9l0Iq3jZP7P+mG2ezJU8IyE+E0
         QNug1gvj2iMOuI3dVhTmaV4xX4/yfpOEGV4oDsFiXGfTZ8gK+T827DJyJ69slqz2pztf
         C9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262065; x=1742866865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GsbPPoZ1bLKw9ud3y+SvcehyU6Mdn4kN0l3aZP0Qcc=;
        b=hvn4a5/fCsn3vBSbmSPPG27wWWAaZP3V8ryyzaJWkOhV/WuMufvE23qMQ36vLUOJag
         CiMrtfuBOVF9TQOTJJCPz5h+c8l0cFJryD4Dgd1jo9Tk0LdhFu8xTz2vNqKP9GN5zjYh
         Pe8S5kypacCSrRXkXUCoh6pO4TbdK+DeRrFNo7rMSFzt3BFuP1ZeZVkGooh8eZiLcK98
         FgzBF0fONdzlNFQy+WOvF3hI02nQPZVMWMPZ/TdWBUkjFMqOsNaveBaqLyz079z9Qjfd
         1jTVWmC6WCm0PU/RkGc/2GvoOoxv357pPp+XN5BpxeezyAqD1hP/ILYyfXaIBy0Wc3Vp
         XrAw==
X-Forwarded-Encrypted: i=1; AJvYcCWgSyYNKUxDEFNylQS7vYlThf/0U6bNJMJEt8ogDCzR8zUf/ZKbIjEkNz+NLrQX339uIX1zi804+387cBGjyls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpvx8AJ4mGHz5jJRjCJl4vh/JWy97YfL8qcdtZ5IchTWGFrRfL
	F6wKLQVWsZwJe3mu2fSyQRI1QBNQGzy1HAMXsTkeks/lkDq4u7hm5i0aywEmz2dukv3Qq6uoTXQ
	isetmP99SviCTkaGLtfHXk0WDJr8fjUU4xIrY4TGug6KNxVsiAA8SPH22+co=
X-Gm-Gg: ASbGncvBqHZV4McBnwWfDz3tkq7iag75y/gcZvBf8QCP28yU+vOYtDXAo17CpA34FK/
	giAi/+Zvf3SR3xyHcJuxg7N/EPvg9eehRitvTHTyWX/g4EWHwAiGAlZm4lGai/nNnFbusIMNNri
	E2V2xjHjBgzr/FXemI08er/DrwU6Sr7TQTvvBsBh2E9o5PqCyfikwNu43RR9IsMVAhYtB+oU0EL
	ndutpzPLckCIf86nl5Zf2M7rxbs9mHZ5W4LowUNxCv/AhfocaZkhPSz+bq6YKV8BnWUlg0U/qzs
	0g58wmY5SkAe2ev2kIfmbwppG0RkErdIzGNV41UpmsrlJREZK0dF
X-Google-Smtp-Source: AGHT+IHRb+EonfPLOgt+0ZdfXOVSkJRUumzJby1DpK/DyfTqijcjpbsN1+mmZTfdUyGrGTX/GfGcbA==
X-Received: by 2002:a05:6000:270c:b0:391:39bd:a381 with SMTP id ffacd0b85a97d-3996b47cff3mr792707f8f.30.1742262064612;
        Mon, 17 Mar 2025 18:41:04 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:03 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:38 +0100
Subject: [PATCH net-next v24 03/23] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-3-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10738; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=bDKZuviAY20IZ/1LOSZzXATQR29igS+laWQ4mQV6SF4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8pkJGGhnYcJCFQEgReRx1TfNs9pS5TL83QL
 D2GJREcOgmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKQAKCRALcOU6oDjV
 h0TyB/9XgQwvTQzSN2rZ1kon7bVHkIyLMj1fN+/pjtWi3hcPRoPjRpdMeZk6RbvVhWeXZMuifnX
 ccsmvxRNBJUSTSWV9AR7qL4LdSuCF1y9hlrSzB4IWj/FnlAUURFapDxpslM1u1dV5HKFL3XDmLR
 3Jek3MY2rsFYw/vfMD0h994ecPFRtDohF6SUmYa89yfOi/UZeVcaum/nEnSPI4ZOzv9/x6RW8IY
 1sZrDrSIfyXC+Qf1ID2IvNxAuvkZEeEXKFuf0Pr5eue3zC9GNlzHx/Zx7olYGtlRIX4xfhSA0O0
 /58ejO0cX9mzyeD16d2lpJGbmfwm8Zwi/BYOV8j1QaXd9DlM
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Tested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/rt_link.yaml | 16 ++++++
 drivers/net/ovpn/Makefile                |  1 +
 drivers/net/ovpn/io.c                    | 22 +++++++
 drivers/net/ovpn/io.h                    | 24 ++++++++
 drivers/net/ovpn/main.c                  | 99 ++++++++++++++++++++++++++++++--
 drivers/net/ovpn/ovpnpriv.h              |  7 +++
 drivers/net/ovpn/proto.h                 | 38 ++++++++++++
 include/uapi/linux/if_link.h             | 15 +++++
 8 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 31238455f8e9d29531884cad4951391fa47ccfaf..a50d9d7d882e7e4f9de29b2a4e7acc602972f6b3 100644
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
@@ -2272,6 +2278,13 @@ attribute-sets:
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
@@ -2322,6 +2335,9 @@ sub-messages:
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
index 28133e7e15e74b8a4a937ed03f70d9f83d7a14c8..b19f1406d87d5a1ed45b00133d642b1ad9f4f6f7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,14 +10,28 @@
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
 
 static const struct net_device_ops ovpn_netdev_ops = {
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
@@ -31,44 +45,119 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_setup(struct net_device *dev)
+{
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_GSO |
+				 NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA;
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
index 318386cc5b0d19ed6a37734feffb450353dd9440..3ad2d5d9803479a10a6b2cfab2df98ce0f823926 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1986,4 +1986,19 @@ enum {
 
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
2.48.1


