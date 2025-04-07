Return-Path: <linux-kselftest+bounces-30283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2AA7EDD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17837177800
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D423221DA0;
	Mon,  7 Apr 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OdlFiJ0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16F22068F
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055232; cv=none; b=H+FFJYJb+dgmul+gBKL5M5qVUqMfiGrdC6IrHHZvgdTGrU9W5l0h/zu5vEsoNhsNHgozYxLafbPghkUciQVifH4RLq24HJoQgvnqCbWPudN2guBi8Vbx3bTx0y9DFU7nuzs0XJ2O2dHDe8iLgwzWy/W5NVcUCI27gDJ0x4j3owA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055232; c=relaxed/simple;
	bh=pytGxwHyu6LVaVFxntyFDb3G/orkOJCawDO7wnhiL7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caSRp8Bz8hDebJAj3gbyf6xUgGW4vFtK793A2OTGHG2DbLp5a3ilgJ+w2delHaeesA1EeaVR8lZgIYjbB9mtazBeiI9u58wsYv259tZkaNWURV/jpDM+L+r1rdq0xfpYOEdvqQaXhCIOLvIuTE4CTJ2v+JVd7EJujLN81Zub/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OdlFiJ0i; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edb40f357so23501475e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055228; x=1744660028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YllzlG7ussk9QGsyT6DKt3FVh+agV124atFvqUBwsl8=;
        b=OdlFiJ0iPG6Kc/KOtOywACYGKnL97oDIc5UF89qZGhmaAdFJFwN73FzFJhZ8xXQMWo
         9Zq+IZWPUP/DUYif4PN7r+oWWFhaqaZSqIa/2/41JWwwRLvC3WxYnAilfF2YTCvu0Caz
         K8Qw4ZSJIVvSUMJAh9VCpZ81Bi1G+bsNi+hFoG1PnpBOw4prerYkoQPTxzVI22juun0m
         /S6IKk1pjrqOIZ9ZsWHOlzV1cN00cM0hcs7kspEYjf9SE8Fg7pfLQsV0vx3UwMV1Uwcy
         bOld/lsekwNsx0KYPwXX1l2nqj+JYFIYP66Tdw6N4b75MT2t+toyrT7T87Zxre/gcd+T
         ClDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055228; x=1744660028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YllzlG7ussk9QGsyT6DKt3FVh+agV124atFvqUBwsl8=;
        b=B58UrLlAKct3KZ91GvkTCqyBr3FeU+Pqcx+7EWcGBrkZJy0lfirdy8ksf2733ejaLa
         euYAFalRXrmKWm/SJUjlOzy9M3ZvuZRIE1n38RnyvTrSG46vPDYaQzEI55Roagal116l
         tEQWBQB+zyG4q9dEgePy/X+frYSXyRDjPQjF8AK3tndEsNkYeSGTxHTpVhq+CH4zZ8Mv
         MkOGSX6L8drfioAZSBHWlaLx7QY+sDR6Kjw6jTS7hKizppbackRw1HyP4d+ZEN0pxck7
         Q3j2SRRydVh2FFwpmxE0LADfaKDfGKSWJNXbVa7cWHfWNXBUArQm7/66kxi7p4OHZA6B
         zsOA==
X-Forwarded-Encrypted: i=1; AJvYcCXrX7RvKBJiEY2L4DdcpObb/kEKXNi3v/EO+ZTTHo4M38klI0Jsl3Jy+f19Jha95hPrk5sIuYUlMBJtzQw/7LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZtA0i9A/yeeNM0H3NqlFOIj/HgIAkg/F9v8zCD2qf0bLlbjN
	clukzTtRq4xVi7venhhhx2zu1/ffoH00V+bYzMFvwQb/fSGuokw0fizQHYPa+B3vnxlxJMf/uz4
	68SknzPG9znMNujcW9eEiHgiR0amVIgcGjAKzH0N1e4xOt1VSFhYJVt0kHin9+7Cmf7zqLZUJ
X-Gm-Gg: ASbGncthwXCn0fT1AKZWTV+qLbvWvn84gXsb3Gnyf+Wf/30URCBnUQBfYlucDD4QCzn
	2EUM+es4czcu6ebeDVfy9J77bIYWvj3z7Kci87KfT67eUwnkFGL+tM5jFDqOg88UkFOhoQ96rcu
	k6t0ErUVvA3vx9KkvpayUe/9Hya9PsAVaMU67XvS/ljJSD4WDA+aACXzY9iP4iHGAd5KAaNe25p
	uWkaYIvnk51yHbb1QpwliUq5C/13CADsvIXNdp1Lgyg5rDk3I6Mqtcr0uTmP7oqvexAztvVC6ej
	qLmrKcY2ZRJqbUZHWXlqyjtaXZ8YTJBF+ElEgAcGiw==
X-Google-Smtp-Source: AGHT+IFW1F9jmcO+8Nh/ocNlp4vWQryVUvNyQiP7cCXaocdLYthjc/9G4pUX2dfOrocFGTVrluYjyQ==
X-Received: by 2002:a05:6000:4310:b0:391:3bba:7f18 with SMTP id ffacd0b85a97d-39d6fc01096mr8228306f8f.12.1744055227840;
        Mon, 07 Apr 2025 12:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:07 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:11 +0200
Subject: [PATCH net-next v25 03/23] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-3-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
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
 h=from:subject:message-id; bh=pytGxwHyu6LVaVFxntyFDb3G/orkOJCawDO7wnhiL7U=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu04GRsIr4dEOUrwx+ho9T7dBf+m+mkGfdY3
 MLKKZ9bxY2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtAAKCRALcOU6oDjV
 h9zcB/9Ppb72ZD2hMN4iw25tF9fC6it2Uwbu0MhTcI9ac9wDyoeWyoy4V338Tv/liNztB0oMTFY
 RC/0CbsTfkc+HxgjJ+zT4SZopCQ85oK3Kc7MC1OYsOqENjHi40p/xO9XqZNkeJTmv4utKsQFuRI
 75dNtNo6RxEbP+N0FUTN+Blab2S4epzHPlX9GPdp9iFurmvERWTu6w9U6HM0O0535Sqqr1NunFv
 AVAp7hlI1qcuyVl68YJbC0fb3Tq5ktNBVoRP//SGPmUzq2/JpzR6/k4N3K1oKQlXt+fC/+yagpg
 P+1/tpzi+BmawBYL1z5qOSUd4buoznjWxTAGly0NXqYXQ0MG
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
2.49.0


