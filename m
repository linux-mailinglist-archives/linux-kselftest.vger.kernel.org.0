Return-Path: <linux-kselftest+bounces-20632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2669AFDC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8C91C21BCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9EE1B0F03;
	Fri, 25 Oct 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AFbKW+oW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7C1D54E2
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847704; cv=none; b=gqMQxMgdgreQTAHIUn9tkzhiNrt75GEXBY3MdM9Hw8htle4/Swe6qnQJrkcZHo4xd7eNr11J0XYdif9aHPJrnzF0sAYf8Lh7cz1jO1cibMo+KYEKye9rLlIfEpLWcePLwhXmSDTNZhPDFn5POhGH9qv+REsMG3zstAKoTi7XtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847704; c=relaxed/simple;
	bh=NHB8DY+derJjmpIyfM7tZseTb7zJiJA5OcsJ97CZXUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCcvJAej9CMfhgw85RbOuLLxkmWYNA3LnNYUPrgKvbS0b7n5c11NM93Oq8sFbEA/MMIZHZsUSjdNCTNt0BkknMjjpob9Z2BtfRlEaAEvHPJmCdhG8Hd6E2qoTXFiPYAzSCKhv1AqLGs53J66wNrgQZLpI07Z3NV+gk/2F8hzL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AFbKW+oW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155afca99so19581795e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847699; x=1730452499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpOrbfvwpuTF+GzXl29fSyJFnaQGQgrW9YLo7vYL7GQ=;
        b=AFbKW+oWgHgRYUIdMXmXm8GIv9x8C8WofaMk9n5gopC2Yk+XJ5lzskt2eHzGjGD+FP
         9LzMUNG39G/YP4qlvxDVFB0i+NewalQYNUxolxYFhvh1KXWJd7dfuC3rcdcIvQ1jOI8N
         HuOdqupVE6LvpAUyyi91u76lrgOR7Otqrjmo32xW8yqZcNtqgRBfhEj4nHUFAEGdmVQD
         uudLbyKVsDv2IVbhfPiudMo2Infh3rJpStDtWHihCkSi5VMW/e6b08IVw+/6vDI2tp0i
         vtnE0d6CyiumXBxf3ZPWHtJqaX/pG8MAS1WoOycYFsu1UdNf/BJdMtJ9+e35xBHnTpFA
         UupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847699; x=1730452499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpOrbfvwpuTF+GzXl29fSyJFnaQGQgrW9YLo7vYL7GQ=;
        b=GXrIJ3Ac6/etDI0OOi72HAGJC9eEDDGSPpQ9ohETGmCvZ1ObHbXf/bNJGcn/eu+A5w
         yerrKhwLOeabchReQUjwdt2ZPR/kGutjnWXGUd76TQJSMh6BM32ZewUNEDsxw176Zr0+
         EqJDIx/pY9boHh+FmQ5cjoDgdccwQveQfiRRg/pdhE8PPa90TsdMNQMFek8Ea6d4y/yS
         57MFSA/iVYb35nbmJ2KXQ37CwhgCR1FvNXcqiX47y6fZEft+713p5nXoY2TJ83tnwnMP
         NBKvjMilDMbF0sByXBtO0S2KE9k/rqgXjGhXMiJUoRxKZzUuTpYo7XgBdh97jADbu3yS
         Pwkw==
X-Forwarded-Encrypted: i=1; AJvYcCVxej0S55goOh7FtaOzoEyHn5GzhUkhB7KSnh8vj06q0zPbxbfcwH5UHl9LG87OGjsGF/Y+R/OMer9ApcZrz9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5gDfiwDWoSavXMRrwSiDTiBOiH1xvJMUWQxt8pEyzf/w7JSi
	FQzkRVUZOQzgDYdEgpOsVNFrfs38ZOkwz3OM2dF/d1+ASC2qQ1/YK8NWffcPnh4=
X-Google-Smtp-Source: AGHT+IG77+KbHvkxlJQDbqmfLiTOSMnWsDeEmThpIwLS5v4uzjizAkNCiG9ot5DqyJpXYPTH/bZTIw==
X-Received: by 2002:a05:600c:3516:b0:431:4e25:fe31 with SMTP id 5b1f17b1804b1-4318bc8a372mr35051045e9.12.1729847698831;
        Fri, 25 Oct 2024 02:14:58 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:14:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:03 +0200
Subject: [PATCH net-next v10 04/23] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-4-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8751; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=NHB8DY+derJjmpIyfM7tZseTb7zJiJA5OcsJ97CZXUw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GYGEzAUjR6mDIcvWuYGZbfm8ATX6IaFMjdy
 UpjjWUniFWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmAAKCRALcOU6oDjV
 h6BeCACDQv15QbzlXRSejuLys6ioWgs+qzms29dkyfEYtVmpq4JL61M120/KkNI52tMnkizzTq9
 R2Rj9ptIHL8xgrxNldCUiOuyUIkN0zHhUxapfgYLvD6zyHGNdGrv64P3XbKPXsqwL2H054uEduz
 JiNDahgxRG8mus75qiSrHJV6/v9xycqJUc/Q29JgxvFI2VpL48RWi039nPzIs+0hsiDV3knWgSR
 ZbxKsTKKS3Y/HN3Cn16u6ynqaxKP4qkE2qxvC5bZOD2q7TiOtO4C3IvnjQD0Z1hzz57rY+vPnsr
 s+r7IVLESEfvE5hEdvh87YMywA1ZIsnhr8eLARrv80Z01aH1
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/main.h       |   7 +++
 drivers/net/ovpn/ovpnstruct.h |   8 +++
 drivers/net/ovpn/packet.h     |  40 +++++++++++++++
 include/uapi/linux/if_link.h  |  15 ++++++
 5 files changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,18 +10,52 @@
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
 #include "io.h"
+#include "packet.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
 #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
 
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
+static const struct device_type ovpn_type = {
+	.name = OVPN_FAMILY_NAME,
+};
+
+static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
+	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
+					    OVPN_MODE_MP),
+};
+
 /**
  * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
  * @dev: the interface to check
@@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
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
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	dev->lltx = true;
+	dev->features |= feat;
+	dev->hw_features |= feat;
+	dev->hw_enc_features |= feat;
+
+	dev->needed_headroom = OVPN_HEAD_ROOM;
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
+	struct ovpn_struct *ovpn = netdev_priv(dev);
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
 	.kind = OVPN_FAMILY_NAME,
 	.netns_refund = false,
+	.priv_size = sizeof(struct ovpn_struct),
+	.setup = ovpn_setup,
+	.policy = ovpn_policy,
+	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
 	.dellink = unregister_netdevice_queue,
 };
@@ -51,26 +145,37 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
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
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index a3215316c49bfcdf2496590bac878f145b8b27fd..0740a05070a817e0daea7b63a1f4fcebd274eb37 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -12,4 +12,11 @@
 
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
index e3e4df6418b081436378fc51d98db5bd7b5d1fbe..211df871538d34fdff90d182f21a0b0fb11b28ad 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -11,15 +11,23 @@
 #define _NET_OVPN_OVPNSTRUCT_H_
 
 #include <net/net_trackers.h>
+#include <uapi/linux/if_link.h>
+#include <uapi/linux/ovpn.h>
 
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @dev_tracker: reference tracker for associated dev
+ * @registered: whether dev is still registered with netdev or not
+ * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @dev_list: entry for the module wide device list
  */
 struct ovpn_struct {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
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
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 8516c1ccd57a7c7634a538fe3ac16c858f647420..84d294aab20b79b8e9cb9b736a074105c99338f3 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1975,4 +1975,19 @@ enum {
 
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


