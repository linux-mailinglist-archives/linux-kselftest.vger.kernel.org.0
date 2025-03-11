Return-Path: <linux-kselftest+bounces-28710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D662A5BFF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED6A164E3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0582561BD;
	Tue, 11 Mar 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bXIl1CH8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E22356C4
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694586; cv=none; b=FJiTHWhAfrx1tySDxVjHdTfMX4r4xay3ggOo8kMEyItFgGzy6Gjw1dzvjKERrG+IrLMcFbyGel+uqlYteBPOxeeLulf5ZMkeKOIEbbuY3NzYT+zr88yX2dNSZ85qfPOEo+zBRFW8Rf4PWBFMvlycGeqPlgDnIY3zWNthMcRzhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694586; c=relaxed/simple;
	bh=qrcxE0EqgqzAnuRUGVALfk1/B+ytxKSC2TxSlb4fiIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVJ98ZEkwtrMhhOINRz1mWD6Bha+j+XoKUuO2h8TC+3w8SirVbIT0WSWqc4Hm0L2/+CX7NgMtqoIv7bXwA0Yf5MRD2HY3SsBnYiXyTYfMcxdmFvUl/O7hV/dQtnkbpoNvGbQ43e8EQMONV3WCdtKQ5st4UcoeKpJ9jqK3a89zko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bXIl1CH8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4649598f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694582; x=1742299382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7tOSXgaxVwrRu/skY2HdkIPgv+l5TsuEIw+nhxjPD0=;
        b=bXIl1CH8fp+V9bIqCqBbc9veThBTRWEirjBUHsb1t36FBzwksfNpovri/uIhll9V3E
         6hjd+4NlniD0bT76nQxSHba+gLPLJvsaG5G9MfeldDEaGXJrB05TZSOzQGJSj20LeK/6
         xM6a17M2lnS7oj8XtIAGFqC4URNnOUB5F3L1Sre1q9RWDzfyiw4NH1uEozfOHzewwD2V
         Ik0j1UTFHuCCdFiAZK9YMWfZCeS3v5R2lAzXgrm7oovYVWaHfh3d9mVS5Q4njZZmVPcX
         zCaFiwC5QrkgmZXBbRie1YzElU4qMqus+b2yP3pZ5b+srtuC7EwF4nsFkU4nE5b1RcZd
         Q2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694582; x=1742299382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7tOSXgaxVwrRu/skY2HdkIPgv+l5TsuEIw+nhxjPD0=;
        b=IRD9/GS2ru+3bafw/WGmr32PPpYmSB03XNcKTdD2ymEzFQ6urV1mkMDNlkzJ67vp0F
         wlkMxkwCRmDiVhlbFXLWiQQ/S3SOPCJvNqyQ7MCAYkHHZ8L4SJ3xl6l8ZaEq5QwmdKa4
         0Q0+g+Ie2Kq7regB1Yk1n0nfKNa4/SH9WNuYrD+7rHz+UcR3a3DSNSH+EEUOL9BfcgjB
         zz5EoTTw4eM/9/sVQZEyTdles0xhH/diAqmoDlS7aGYbVd+BcyC6RI/9/yfq8EHPWZCb
         XUV6459JFK1txbJdcVEp4hxt6km0ViRmD/YVS9k1icqqiQr03o74yt8O3B1mM2bzU4OR
         LJvA==
X-Forwarded-Encrypted: i=1; AJvYcCUkqUzsdoX7+2Aqpb2PQ+W9cH98772CO218nbPcp9am8BZt4TiQ8u/0sUnXJcAQI521NNZySkzUJEi2FyJUIxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJaaxDqx96kvCbBRhDKzhaSqCAoEc2fM4vktCSnVG+ua+Hvkx
	+tZjFXc8VYv8nMmNMdot7fV7RonKGaJn4x2joWdHXIA5dnzs0rwBLld4mmGh3eo=
X-Gm-Gg: ASbGncvo2/0YlB0odr++7x0tiHiKCZtUOZD6mP2EN/cNRZfYi4PiVkl0aFZpD2DOTQ1
	ciAbHLF8HjDSfMXdertx+MEBGe0r+dPNrn8PzV82jdyLeC54Ld9+2Q5yTtj5c9rXxGINR9JW6zS
	w/cYjbNPNU9h9MsCqA7M/2Nvh9cPyr10fgi7RRL4N0Y2yo2Pv+YUSL6UnPNdJ2eTP8N0Q/Ei/AQ
	zTQY1/Xdyqh5izbIZV3kqhn/s2t6LGJr+oVe0mHb774J8IMkvj792h6+nYdHVO79EB3dclgfgag
	0wk78AcoDRD1O3NQfpVt/zDI5nJOUOP1UJgLxudNZA==
X-Google-Smtp-Source: AGHT+IERa1mu6b559ulicFZkA75QX1LDUWz7aEKKuD0v/gUuj3SU45jkF7ZYciM3cFv3a6EckNQZ0g==
X-Received: by 2002:a5d:6d8c:0:b0:390:dfa1:3448 with SMTP id ffacd0b85a97d-39132dbb23emr16745514f8f.43.1741694581614;
        Tue, 11 Mar 2025 05:03:01 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:02 +0100
Subject: [PATCH net-next v22 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-1-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 steffen.klassert@secunet.com, antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8900; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=qrcxE0EqgqzAnuRUGVALfk1/B+ytxKSC2TxSlb4fiIo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZwx62FT+D41Fd9lT9XcwyX5MJKSDcngzafp
 RjcwgPGeHKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcAAKCRALcOU6oDjV
 hxtdB/41twrkc3gpxa5Hw8nimJGjkJCxDdHNcyNNmvHujPoszEdC9bMkfmnHaPMVw/Vil3SXlrt
 uMCbb3qudYTcDFFzHP4mw/FQujnmJ8/ASJb4+wep2RnJ0c4nv3NIVSonG+mRhjxpZB514Vf8XM8
 UIZL/wlzCjWJQKT5MlgRjCzwrwhhahKpYLwvTqNJ/M5zjDZquK1o+OJg6s2ibYJRQeCcLmxf941
 I+B32ZSC8GWMHt7e10xeZs39/TT9YaA72e9WBNJj5TuqOSLh95ZWL7E7dXvq0CujtYf0KkpZq5A
 LYE9s5CBom/FIoTDO5ZiU1mL3yZB6KpyBm8FrI7VtsYg+rQi
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
 drivers/net/Kconfig       |   8 ++++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  10 +++++
 drivers/net/ovpn/main.c   | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffbcd072fb1440b5cc922af348253ed11d00ff30..d03ba2f9eb345969755957645542417fb1ee1be4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17764,6 +17764,14 @@ F:	arch/openrisc/
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
index 1fd5acdc73c6af0e1a861867039c3624fc618e25..2ace5e27c37ed3bad2e0000775cd172cb6de3225 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,14 @@ config WIREGUARD_DEBUG
 
 	  Say N here unless you know what you're doing.
 
+config OVPN
+	tristate "OpenVPN data channel offload"
+	depends on NET && INET
+	depends on IPV6 || !IPV6
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
index 0000000000000000000000000000000000000000..876800ebaa21a5f758ddf60f637801710437f70e
--- /dev/null
+++ b/drivers/net/ovpn/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ovpn -- OpenVPN data channel offload in kernel space
+#
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+# Author:	Antonio Quartulli <antonio@openvpn.net>
+
+obj-$(CONFIG_OVPN) := ovpn.o
+ovpn-y += main.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 0000000000000000000000000000000000000000..e816e8fbbfeff1086a55c858b1941b7d82d7aba6
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
+static int ovpn_newlink(struct net_device *dev,
+			struct rtnl_newlink_params *params,
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
+MODULE_AUTHOR("(C) 2020-2025 OpenVPN, Inc.");
+MODULE_LICENSE("GPL");

-- 
2.48.1


