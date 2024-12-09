Return-Path: <linux-kselftest+bounces-22974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAFF9E8DE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DDF1628DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922322163BE;
	Mon,  9 Dec 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PkZ3ZaqA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A6215F67
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734387; cv=none; b=GakOO4kyyD3Mo7RJqzNNAPyTJpiriPBeqz9lhmsgh90EjXyQPau3y8BUKJVbopqwyUGhAKCmQCkJ3WwhR1n+q91lG4flHDnUOO9AJpVB2Untm/5w4To62KvdGVO61c4TzkszHOWX/EvFs0Sowr/Xleh/zkEQRaUuPYLyCTSiqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734387; c=relaxed/simple;
	bh=8aJ3PfQubjODk4QdgG6fySgSnEM3R8Ru+ZvI0tMVZEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NH+41v40FfUGkKNV4yb0LLKM5Cnka4ZijAWhsV0V857O3g1NfCOTxz6f2XDAQAsvlI15W3UlEavPHWqF7QI09Lk0bPadyzSLHof/LzTT55B3D3q//kq2wNiaXSEzxOhcdh597OvmiDmunhoWSI1pvSLqgMp0glaHi1VPZJu/njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PkZ3ZaqA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dece873cso1833153f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734382; x=1734339182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZNS2/ZN6evv6701XGrZ2MdmYKbPXjFP4nK7Mh9RrRY=;
        b=PkZ3ZaqATfnoA44p7rMX0VGn7nzthtA+BQwwl28H9TWKM+wA9qOjmo6wgZ9+U1amZw
         xtgY0uzTjUcfqhVeMfTcpakCRIU21cOLS7xnmCyOHVG/2fUJ7BHhY/8frtmybjGZZRFB
         FYZype3F1nVFB7+yzQJ8s19OdB/JikxS6tSefvwwyQjSuKKtcOWbr7T3uthRnja91hLZ
         15dLKOmKO6bPfCzP8j3v2SD0JGVLwu53F0HQWqswCN/Fc5bUjMH8/PH7G1rB6pE631kL
         +duuEIuVGuhdq+6PjBI77Zt4j4G4/Ox5gRyqP+RI3IYupHu43iv5SxKHZPifPdnDUosR
         EbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734382; x=1734339182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZNS2/ZN6evv6701XGrZ2MdmYKbPXjFP4nK7Mh9RrRY=;
        b=RRA1DMK0ERZcuoU9DsvqRfn4EzonprLf/0sBQnAKnn4P5O66d2XHuAVfgG7leC//WY
         PQKlcanU/CZf5fi+eGN89CmtPHHJE3B+nkRT5XSoHS8alvp0HuSjTiasbfo15Ph/kgUk
         Id4ufiqO2tvEiXVxSrfV8JtAfpbvIwoFeTbySSxhPJFBOYMoxUQJfKyf59DVXAgvCovz
         Td0G+1SU13wvfaLglAlMrPPtd3PU8bVDFFIfR00qHurPDZJn2D69LwDOSo6KNi0yIz/H
         FzoZPxWPfC6fBQrpVdLEg0HNndcXAuTVMN8dk/CvHp/WgL65yfkvl08pKghjrs+dvh/1
         N3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcpkI4vCBQE1EH0HfIhVBrdjCNv850COjfln6I3jo2KY78CeKeA9ZoQbh3NtUvHX96BeP60Jwqg9lWtG0Al0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AaYDJqtiv+6rDLIVIIL1+icglHKm2/XoBzy5uaf1GDo8+Kq1
	7zCrEMVtCbawswaYlY4Z9uexYt0bWpEuifabcw6PQM3k8p4m1gLy6R7IaxIhnlko0DDmdRTwz8Q
	H
X-Gm-Gg: ASbGncvkxubT4f77XpEfkbm8S/BQTVK7BuKTb5Cw50MAzVXSg5jdk4+rhS83ND2rxZe
	v5gQQjc/KG/ZrODElb3oGse0bGn12xgE2fWUN5BKgkHNGIHC/iLS3avntYkpnSjsJjOxpGN1IGb
	85B+Unq0Lh9LytybUQ4ndMyDII4RnZ5gxphxaJ2Zz2lqW5GgsnW9xZ//hiJtieKMzga8ZBCJ8Tm
	HAg2YS7Q0VfZ5gAf55dPNzpyHxtg+FGGO3cCMjUfOEptDXwFlX6Rg2hwuNq
X-Google-Smtp-Source: AGHT+IGjYq7OY4LiLfvQX6ewAxQE68i9ghrPUeuhZxHOOBe0/Tofng63yZLSevoctaqGymdpXEOfHg==
X-Received: by 2002:a5d:64e8:0:b0:385:f5b6:9c9d with SMTP id ffacd0b85a97d-3862b39751cmr8336360f8f.33.1733734382453;
        Mon, 09 Dec 2024 00:53:02 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:01 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:12 +0100
Subject: [PATCH net-next v14 03/22] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-3-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9741; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=8aJ3PfQubjODk4QdgG6fySgSnEM3R8Ru+ZvI0tMVZEc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAS1Nm8cIeLjyjeDdcnEIjRLuN1ns2zWiExm
 KkM/NXCcEKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEgAKCRALcOU6oDjV
 hyj7B/4/80n+JRWKNGx3OqFCYEk3SurtGkAxDrhSKRsVQKuXmgUeHQ+Rs80NDCnsMz8T9Z7i36z
 aupt4p7Spu7BJ3A8KRjYNEZw6PeW+x0cqUh4Ma5ul0NjUAgXXWq9T/AmX2Csi7A7e02tyd2hKSq
 L7yi2twKUsd9xQGKIBHj+6kSUE2zOaTQDlVSnXn7nmCiTQ00tQvri5LxBWJOhRcSGhr0YGclZ7P
 efGbTdpAxIMpRZAIVKH1ZdtRvlZXS2Uuojl5bDwLSbZ7QqWmKnz+XKmDByBXuK65Q1ZmjkErRk0
 egnf0ZilpFMrF/WAISD9DSMJ3FJeGqRXtAlgSllSQ5IUNWPN
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile     |   1 +
 drivers/net/ovpn/io.c         |  22 +++++++++
 drivers/net/ovpn/io.h         |  24 ++++++++++
 drivers/net/ovpn/main.c       | 102 +++++++++++++++++++++++++++++++++++++++---
 drivers/net/ovpn/ovpnstruct.h |   6 +++
 drivers/net/ovpn/proto.h      |  38 ++++++++++++++++
 include/uapi/linux/if_link.h  |  15 +++++++
 7 files changed, 203 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 19305a39e57eede2dc391aa0423702c5321649a6..201dc001419f1d99ae95c0ee0f96e68f8a4eac16 100644
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
index 0000000000000000000000000000000000000000..ad3813419c33cbdfe7e8ad6f5c8b444a3540a69f
--- /dev/null
+++ b/drivers/net/ovpn/io.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
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
index 0000000000000000000000000000000000000000..a90537e9af6c0d2f38da229bdc2d8c639f2d11d1
--- /dev/null
+++ b/drivers/net/ovpn/io.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
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
index 3475dab4b40f3edd882e05dbdf8badd03d7c78a3..60954c5b2b9254db1d24d01ac383935765c7ce5b 100644
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
 
 #include "ovpnstruct.h"
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
@@ -31,16 +59,69 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
 static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_priv *ovpn = netdev_priv(dev);
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
 };
@@ -49,26 +130,37 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
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
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index b4e37e922fe5a5659e030174f1e42b3935967ca0..312bc22199383fed0746335fde3339646bb68b2b 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -11,15 +11,21 @@
 #define _NET_OVPN_OVPNSTRUCT_H_
 
 #include <net/net_trackers.h>
+#include <uapi/linux/if_link.h>
+#include <uapi/linux/ovpn.h>
 
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @dev_tracker: reference tracker for associated dev
+ * @registered: whether dev is still registered with netdev or not
+ * @mode: device operation mode (i.e. p2p, mp, ..)
  */
 struct ovpn_priv {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	bool registered;
+	enum ovpn_mode mode;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 0000000000000000000000000000000000000000..00bb3725ac7ab7040c97eb012c2639b2d6967de1
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
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
index 2575e0cd9b482e78984ca6528dd7d4a24f03e290..9914f8963060ba6db56fc379c3016458002bc93f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1976,4 +1976,19 @@ enum {
 
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
2.45.2


