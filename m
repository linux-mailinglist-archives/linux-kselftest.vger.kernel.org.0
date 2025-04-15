Return-Path: <linux-kselftest+bounces-30842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656AFA89BD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219EC440AEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E392949E9;
	Tue, 15 Apr 2025 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IkdlQqZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCE2918C4
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715853; cv=none; b=Vz+7a2nk2HMa4n1eK9z4cjPTQH+uQWN448klm7gz+qyACHpiZhwwHVvE+p+uOeZKS2gCXBdL5XC2C2Cv1SOCXHAkfSmbxqUWnIHLU0u8vhV5jusUqXgd+jY+Pz/30bnZmhhvfTHBSP80eq9+bRWeXzPzFOU/Br6eWIhxeihZXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715853; c=relaxed/simple;
	bh=6M7VDPb8ZaAkBDxdil55Uh4SFR0vRpCZSKRlt3aKnP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/1tIFiSUDh47Q0e5IB7Up1m9vKk9pwv0TeLt2l/PLHzzQbUXYIXMCQuwQ32zhQl/qtyhTSepUwVHCXyXnmXR4JS3jKEdMPlCV1X0u7FtLYOu6bWRRdk5Tg+zBp7ADDF6KyZThP51ex5/GwUA91fAOxgIteg3CDZ1BbNNHI1+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IkdlQqZQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso45050905e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715848; x=1745320648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnYz6AacJi8VsUnoFC+BvwQkfCfPj0BvzCFwTKyd1FM=;
        b=IkdlQqZQKb19JuSb/qN8WQCyOr+OJx2GuhQhhVVDuLP5rQTDwHhOEFvS/htjw6ZwRk
         dkz9oEh/Wcd2piurfYch0Vx5xjM1mIZyP+PR/GQOJcskQ1ttw8iMcMblGe2fIEocXV5t
         kbf9fzHjEdNkIoof+0/vHbAXL/Jt1xV+wupQ3TzpQFKoY+ls5yHTOBSHET0yqdHtsmrU
         a+i0VR4YrGFA2kL5ozesgO4jbnkTwv4Ag4gxEQz5niSs6GG55s5dpkKKY87NQEzcMcqs
         VtRawkpEV2sM6gCE1KDlOmc59fXtXEsM/r3sizf5N1WXJ6udkgySFVQQua/tsV9Yf7r6
         DAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715848; x=1745320648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnYz6AacJi8VsUnoFC+BvwQkfCfPj0BvzCFwTKyd1FM=;
        b=kqpIyBLXASzb7bGWqXmnD3pKUsPwDPCRJUx2FLcrryGJZ2XlPgN8RVPMxef+MZo76q
         +oHRBs+IApf7PzjBrfzcmkVzAlyiafLoyQo7aFO+Nm2PNnbT+zOojYF5j+To/aDhlzb4
         /Ef0uh2wUM01607fqoMkHmQdpS7yg3SlU+46BhiQqq5DHKb9pqt3tJuEUfSCm6jBJ/+F
         QZfIcYXG0NQLSNPoRxNhE53KKm3S3GJ+QAS+QUCu+ldovmS6N20sn8w9nwmM2rr6dp6f
         gMa2XWOZQbS9a9DOtJRwPN/XL+w9uwRxrfJimVcB6x8m+dsgorQxOYiqWbqxovAT1lNG
         OJXw==
X-Forwarded-Encrypted: i=1; AJvYcCW1u2k8EL0mkcXpOavyL6lJlUh2Jll9ItwKbeJcSLiowtEKP/05d5crjlUEIyiWC98/vZ/iSXaQBZm/4CA3aAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gAbQBJMAc0PqtFyv1Euss+qcPw6G73xIuaDsuVUw7neeSum8
	jfzvygIm4I5gmJXv+zNPN210UgzFcV0DW4TcNCNhSRgzfOK12lQmfX4Ff3X4WL99sXVe64Xq9Pm
	RyiEI9t/Ylenfr503DPITSJbv1Y7oEpqKDRhIosntD4YIWIVgbxUNHLGG6sM=
X-Gm-Gg: ASbGncsAO7FAdZFk8gx3sblkwXun4/r+Xa4P0itWNuhWEXxMcNW5h4mVG7GSn8NjAg4
	9FaRlYeVpy9mjBeELp2FsT94hmhposl78bVQMqsi/8SaKWXWcsuw8zCWrVOkGRKQvhd5ZOtTYjH
	MSoO0tnj1o0L/3qfuhVUzB8Q4jc4V8BsOX9KEqUlnyKAhmyCwVp7MDYiGIdASbIxSTWEqDJdJXh
	FP0nVJRzDa3oeXA9vmMJIBSB0xSpvXRiJShqBQma24e+CV/AXShzI2RhPABjiPBgZ1xDh8ZRyDj
	NAA5KphmKg0vuMR5s9xyfH1PtCnAfr1Mwdl+rKT8P9NOU0wm
X-Google-Smtp-Source: AGHT+IE9LEzmJp1QzwcjiF3SEAuGpxqNUVUvkP9pjx7dy2rC+1r0ZI7NB22tcyguysQ6gSySJelrow==
X-Received: by 2002:a05:600c:74a:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43f3d15dbb8mr84900145e9.21.1744715848568;
        Tue, 15 Apr 2025 04:17:28 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:20 +0200
Subject: [PATCH net-next v26 03/23] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-3-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9683; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=6M7VDPb8ZaAkBDxdil55Uh4SFR0vRpCZSKRlt3aKnP4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBBeOmBEO9y7J/WmXrVwFtQlKYnauiXkqwQ4
 5fOKSgslQaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQQAKCRALcOU6oDjV
 h2yoCACkm8HCocLP6NM4VaB0VnZO1dw2/dAT9FEx+18r1FS32gf5OQzUaitboQpCrA/qviv3reu
 iVfC9F6iit6OlFZiNiLKQe0xaSpzDnAS3WOVdm9cqst2inucJQQvnQD48vahMXTafwY4CX+4cy5
 R0STCXfz2O2x3s7hZrUMPF4qTZVirkPOkjZEAiNcduTDSQSvLf2QmS6UF6R6zGLO0A+E6gwYNIE
 vHCvymQwyZI+YQGhkAdK7F/MycOQW7O3781xBtaH4ByZ3wsEc9SKR5xbkV8DFJ3hURtx/LchF58
 g5dFcV6IV/eRZc8Fm0u7QsYJ3IZL5tGH+C5FdZ3ooF/rAr86
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Tested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/rt-link.yaml | 16 +++++++
 drivers/net/ovpn/Makefile                |  1 +
 drivers/net/ovpn/io.c                    | 22 +++++++++
 drivers/net/ovpn/io.h                    | 24 ++++++++++
 drivers/net/ovpn/main.c                  | 82 +++++++++++++++++++++++++++++++-
 drivers/net/ovpn/ovpnpriv.h              |  5 ++
 drivers/net/ovpn/proto.h                 | 38 +++++++++++++++
 include/uapi/linux/if_link.h             | 15 ++++++
 8 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 31238455f8e9d29531884cad4951391fa47ccfaf..a50d9d7d882e7e4f9de29b2a4e7acc602972f6b3 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
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
index 719cac3db6ef4e06b089790afefb2e66223d43d3..ea7dad374c0088cab46282c61cd8fef65bab0d5c 100644
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
@@ -31,18 +45,82 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_setup(struct net_device *dev)
+{
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_GSO |
+				 NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA;
+
+	dev->needs_free_netdev = true;
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
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
 
 static int __init ovpn_init(void)
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index f9322536b06d6baa5524de57cd7d69f5ecbbd194..b6b644668d46604ad0f21d59cf479386f4ec1e3e 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -10,12 +10,17 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <uapi/linux/if_link.h>
+#include <uapi/linux/ovpn.h>
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
+ * @mode: device operation mode (i.e. p2p, mp, ..)
  */
 struct ovpn_priv {
 	struct net_device *dev;
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


