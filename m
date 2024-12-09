Return-Path: <linux-kselftest+bounces-22971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D79E8DE2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591FA1619C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C5215F61;
	Mon,  9 Dec 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="f7lb3JCy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A0215708
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734384; cv=none; b=KDUIUBydqSNt2J46cimt/guxu5O3dTOAzxC2vjtXFGn1x0DBPaiNjfbaexTEwj1V/BbbwvFbvhsSkGTh9QeeTC9IcjUQQf5BSwayVOp/qtz6Gafmio2t8Ou+wOMH+0OkJ/hjGKCjVWSVlJYsHCN48AEK5TgH0759Foyy9dIXKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734384; c=relaxed/simple;
	bh=5Mo7kUsSthjf2pTKVTWYhiDzbVmrYuPCk/LZcuF8sJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vl19WF43akw9Xn36AX3vH1jyv9dWSHb3WghR6RZEl9M+o67yJxkwc8kvPsZgo8GMrgiLp5JagEfcGk14BgKg/jc659GInkYTFhy0n+1v8OPW1Pu8PXY1YrpFqigjrn7hs87R2Jgs/JpGr7rJqgDxehV1zcRn7vOQwNYlLqosoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=f7lb3JCy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a766b475so39918905e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734380; x=1734339180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cu6sYC1wFJqKW6IeUOOvDtfl64yeLylD4eKp3jSs1OQ=;
        b=f7lb3JCy6K5QZnAVBrFzbxPXgAeqdJoCybgsc+RIeOC09o4nZF7XWyBHgEjJontxvZ
         Izk8+8Doouk6qROTe32nHIQwb8y/l8xPKJGN7YBW0NGCEAzCp+sLSfqDzQTpCCgIVGpo
         ta6Wo0iF4OStETD/RVT9yXfmP8FLOiZB53XAXGPU8H+06MpLwM0Ud2rQmug2TQgaetip
         FrQ8BUEvJ6GzZDYGQHGhz3zDg2vYoB0BKg8BN2IY8S286JesQrzPrdM1LDLO0SbHUL5u
         auJFfz+1RBUJpeIHjLveXjH8ld1aSQ6uzed6qR6qGWDCDkrhWhvo7JaOoo5cHdd4cim/
         bp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734380; x=1734339180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu6sYC1wFJqKW6IeUOOvDtfl64yeLylD4eKp3jSs1OQ=;
        b=wkYlYYL3ENYdd4S0OSupiyor0im8sE9BKdbeIRRvetGN/3+8OQ9eNm02c5NvIzamaE
         vKWAaHU6VQGm6SqVSAUFjekBIvG+Yd3Vpg2ys1CXmNT3B/P9NVvVtRh+tyYsaTiEEQcn
         SU0N5KWqKqKZfznO/gUKs2Fog+J08giRJid/8nAWuY5pWNVKdayj0W9p0zMUMUMjv4cU
         eKp5n2mGPXL+Wpx8l6nvICiACscyH07a6Mm6PpAJlz1HA2G1uiOa96QU68kTfitfvQAP
         nao/dbeBdrvQz3R68lea8ILaVZkk9kDiGDTpi+ureoj+OopFGySQUY6hdllHL0qdtZjQ
         OKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfv6IR14C6Np61kPh9zGem43dp3PwBF4ptFXFHjxoGMh6Fs6EO9W78nXfnOuCG2MxA1sy9h7Rx3m7S/FBQrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7X6HAgYOK7RBvc0kT2V7Ypn5Wp1j8L6dGe2CpiI5vBD60gwzZ
	qEP11CBI7JyW+1YNHwGa5d127wCP4kwE7u+KEO8vTFiFMwyJPdAXgqpgqZ61wkmJAYTZ0C6pYNn
	U
X-Gm-Gg: ASbGncsK9x0HHXO+Km1EavoVP9Sa2hy1SBsE4tDbONgu6hQe6d0mD5kLpejpxui6c+v
	kshc/MFekd8Fb15Asr1oomVb9p25cavcsk4vxJDtKHnUevHp+ymb4DKazJzprHENgoKVLuPfZ1g
	L+HjaLHdmqBczozPEgq3rvZW+USERP2GY0pa7FGEy9Lo0Tg+cInfWM+wndF6m13uBfnh8PPU+aJ
	oWRy+FAjx+50Ci+2JGTlWw/Kikntj5cXO9yCXuJlAk/GNAAXkyQET/fdhoe
X-Google-Smtp-Source: AGHT+IE3rEGH7cMPYOS0vBAgAgcbdOApg9Imz+cpYZ6XTXWPxRU/afdOHjaMFTHQiDSiu1dljGhnpg==
X-Received: by 2002:a05:6000:709:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-3862b3e7e9emr9230779f8f.45.1733734380016;
        Mon, 09 Dec 2024 00:53:00 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:52:59 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:10 +0100
Subject: [PATCH net-next v14 01/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-1-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8900; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5Mo7kUsSthjf2pTKVTWYhiDzbVmrYuPCk/LZcuF8sJw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrASBasV6l3PqujfgzG+HCTQRgvTJYnRGJ1gG
 2+qkPvOHyOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEgAKCRALcOU6oDjV
 h6X6B/oDBlFHU/KDWaPAe+dehmHJI41naew7AZw8EEFn1GvDgV82LWe0hO1FgnjU55RyuadXf6x
 wKeF5fNqUgtvcdXD23OGKoSS9PHk1s5HiWw5mEyVCO9eBPR7vy14O6Uc2P4vEm66bkxLYMGNLIm
 5CTbs6MHh7RKNdItRTcVgJxg2Xy6M9XnzEXSjleQo5ugxarR7b7IaKicslVpsmiOWQ3Gv9Fb8yc
 VuQfMn7gEpgae6HIagCxXvuF94Ug0yf6SD6m30FkbsszXbezjBUAeZ3dROKjLzkn9AYNET2t35y
 1FTmUgxbsDwxNYIM95E+IZM8DawBlr5K+DsN9Gba9ClGGv0X
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

OpenVPN is a userspace software existing since around 2005 that allows
users to create secure tunnels.

So far OpenVPN has implemented all operations in userspace, which
implies several back and forth between kernel and user land in order to
process packets (encapsulate/decapsulate, encrypt/decrypt, rerouting..).

With `ovpn` we intend to move the fast path (data channel) entirely
in kernel space and thus improve user measured throughput over the
tunnel.

`ovpn` is implemented as a simple virtual network device driver, that
can be manipulated by means of the standard RTNL APIs. A device of kind
`ovpn` allows only IPv4/6 traffic and can be of type:
* P2P (peer-to-peer): any packet sent over the interface will be
  encapsulated and transmitted to the other side (typical OpenVPN
  client or peer-to-peer behaviour);
* P2MP (point-to-multipoint): packets sent over the interface are
  transmitted to peers based on existing routes (typical OpenVPN
  server behaviour).

After the interface has been created, OpenVPN in userspace can
configure it using a new Netlink API. Specifically it is possible
to manage peers and their keys.

The OpenVPN control channel is multiplexed over the same transport
socket by means of OP codes. Anything that is not DATA_V2 (OpenVPN
OP code for data traffic) is sent to userspace and handled there.
This way the `ovpn` codebase is kept as compact as possible while
focusing on handling data traffic only (fast path).

Any OpenVPN control feature (like cipher negotiation, TLS handshake,
rekeying, etc.) is still fully handled by the userspace process.

When userspace establishes a new connection with a peer, it first
performs the handshake and then passes the socket to the `ovpn` kernel
module, which takes ownership. From this moment on `ovpn` will handle
data traffic for the new peer.
When control packets are received on the link, they are forwarded to
userspace through the same transport socket they were received on, as
userspace is still listening to them.

Some events (like peer deletion) are sent to a Netlink multicast group.

Although it wasn't easy to convince the community, `ovpn` implements
only a limited number of the data-channel features supported by the
userspace program.

Each feature that made it to `ovpn` was attentively vetted to
avoid carrying too much legacy along with us (and to give a clear cut to
old and probalby-not-so-useful features).

Notably, only encryption using AEAD ciphers (specifically
ChaCha20Poly1305 and AES-GCM) was implemented. Supporting any other
cipher out there was not deemed useful.

Both UDP and TCP sockets are supported.

As explained above, in case of P2MP mode, OpenVPN will use the main system
routing table to decide which packet goes to which peer. This implies
that no routing table was re-implemented in the `ovpn` kernel module.

This kernel module can be enabled by selecting the CONFIG_OVPN entry
in the networking drivers section.

NOTE: this first patch introduces the very basic framework only.
Features are then added patch by patch, however, although each patch
will compile and possibly not break at runtime, only after having
applied the full set it is expected to see the ovpn module fully working.

Cc: steffen.klassert@secunet.com
Cc: antony.antony@secunet.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 MAINTAINERS               |   8 ++++
 drivers/net/Kconfig       |   7 +++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  10 +++++
 drivers/net/ovpn/main.c   | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79756f2100e001177191b129c48cf49e90173a68..6126b7a37839f977750cb594d202a47e318191db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17547,6 +17547,14 @@ F:	arch/openrisc/
 F:	drivers/irqchip/irq-ompic.c
 F:	drivers/irqchip/irq-or1k-*
 
+OPENVPN DATA CHANNEL OFFLOAD
+M:	Antonio Quartulli <antonio@openvpn.net>
+L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
+L:	netdev@vger.kernel.org
+S:	Supported
+T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+F:	drivers/net/ovpn/
+
 OPENVSWITCH
 M:	Pravin B Shelar <pshelar@ovn.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6af0e1a861867039c3624fc618e25..a7c5c166f9ced748d73843f81efb802072e15434 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,13 @@ config WIREGUARD_DEBUG
 
 	  Say N here unless you know what you're doing.
 
+config OVPN
+	tristate "OpenVPN data channel offload"
+	depends on NET && INET
+	help
+	  This module enhances the performance of the OpenVPN userspace software
+	  by offloading the data channel processing to kernelspace.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	help
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5fde479e9b30ad736be402d880dee..5152b3330e28da7eaec821018a26c973bb33ce0c 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IPVLAN) += ipvlan/
 obj-$(CONFIG_IPVTAP) += ipvlan/
 obj-$(CONFIG_DUMMY) += dummy.o
 obj-$(CONFIG_WIREGUARD) += wireguard/
+obj-$(CONFIG_OVPN) += ovpn/
 obj-$(CONFIG_EQUALIZER) += eql.o
 obj-$(CONFIG_IFB) += ifb.o
 obj-$(CONFIG_MACSEC) += macsec.o
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..ae19cf445b29367da680e226f06a341c42c892c2
--- /dev/null
+++ b/drivers/net/ovpn/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ovpn -- OpenVPN data channel offload in kernel space
+#
+# Copyright (C) 2020-2024 OpenVPN, Inc.
+#
+# Author:	Antonio Quartulli <antonio@openvpn.net>
+
+obj-$(CONFIG_OVPN) := ovpn.o
+ovpn-y += main.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 0000000000000000000000000000000000000000..72c56e73771cdece22e50645b29c79962f06caf3
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <net/rtnetlink.h>
+
+static const struct net_device_ops ovpn_netdev_ops = {
+};
+
+/**
+ * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
+ * @dev: the interface to check
+ *
+ * Return: whether the netdevice is of type 'ovpn'
+ */
+static bool ovpn_dev_is_valid(const struct net_device *dev)
+{
+	return dev->netdev_ops == &ovpn_netdev_ops;
+}
+
+static int ovpn_newlink(struct net *src_net, struct net_device *dev,
+			struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct rtnl_link_ops ovpn_link_ops = {
+	.kind = "ovpn",
+	.netns_refund = false,
+	.newlink = ovpn_newlink,
+	.dellink = unregister_netdevice_queue,
+};
+
+static int ovpn_netdev_notifier_call(struct notifier_block *nb,
+				     unsigned long state, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (!ovpn_dev_is_valid(dev))
+		return NOTIFY_DONE;
+
+	switch (state) {
+	case NETDEV_REGISTER:
+		/* add device to internal list for later destruction upon
+		 * unregistration
+		 */
+		break;
+	case NETDEV_UNREGISTER:
+		/* can be delivered multiple times, so check registered flag,
+		 * then destroy the interface
+		 */
+		break;
+	case NETDEV_POST_INIT:
+	case NETDEV_GOING_DOWN:
+	case NETDEV_DOWN:
+	case NETDEV_UP:
+	case NETDEV_PRE_UP:
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ovpn_netdev_notifier = {
+	.notifier_call = ovpn_netdev_notifier_call,
+};
+
+static int __init ovpn_init(void)
+{
+	int err = register_netdevice_notifier(&ovpn_netdev_notifier);
+
+	if (err) {
+		pr_err("ovpn: can't register netdevice notifier: %d\n", err);
+		return err;
+	}
+
+	err = rtnl_link_register(&ovpn_link_ops);
+	if (err) {
+		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		goto unreg_netdev;
+	}
+
+	return 0;
+
+unreg_netdev:
+	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+	return err;
+}
+
+static __exit void ovpn_cleanup(void)
+{
+	rtnl_link_unregister(&ovpn_link_ops);
+	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+
+	rcu_barrier();
+}
+
+module_init(ovpn_init);
+module_exit(ovpn_cleanup);
+
+MODULE_DESCRIPTION("OpenVPN data channel offload (ovpn)");
+MODULE_AUTHOR("(C) 2020-2024 OpenVPN, Inc.");
+MODULE_LICENSE("GPL");

-- 
2.45.2


