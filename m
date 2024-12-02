Return-Path: <linux-kselftest+bounces-22683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B89E0653
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1492825AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F2205E0C;
	Mon,  2 Dec 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y+z13LD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A2204F78
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152074; cv=none; b=THYsFzZJLzW0nKmHy4wzZbPId2cZPg3hSR3loUOVowbPTeUijCRDC0fsAlerlCEKZ4yOOwPv8QeDIPytpn6VG3GRcSnGJF7OOZTMN1NLqxO1eFr3bY5Wkh6RHAlS2dyK54ludcDjL1hF1bnPKTqa63aKJbODvXgyV+eFXDRRP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152074; c=relaxed/simple;
	bh=Gm3qMOOrhFS5KbClvr5Vuxn/Cz6BoXOHLi0W7qkVsCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBv+qn+x8fbyq4sGX/3CfYEshRwFDWbT3jQHW0mZEV4/PogsrulGwN1Kymtif+8qtvAUIg/aegPf1Go7CgMx0wRd5k0Jv0e1H6RqrlSjo5kaJBG9Nk3S+y9JiK9p2iShnJ3keLhRc028TfcC1r9idzsWIofvJXXph3JZZvZ58Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y+z13LD/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e0e224cbso1789034f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152071; x=1733756871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giwDlU+R5dTUnBam3akNI1X1xsvwSGinfbQy4l6MDTM=;
        b=Y+z13LD/VovdnW/rPQ5NACFtImBSif7q8HXj0gLL5BPOZ27272D6r8YDibf2g70Jxd
         gBUGY6k+7biNmye3w9wUxJR5pJT1sMpLAiepn928LjLWpf8OXztdJkY39Opu+5IAhFDS
         EPZWt7xt8pKx9w6Zd85I5TDmy7CpwfEZ8lZUT5InatB68F8rvSLWBhmUr38IrrVrJYBX
         IqNo3I2AkDSbGYUiN43NA9BGb8hb21T8rwO8+npBti3Kk04WbJ9tI0PhFAGcafGmkSl0
         Hy8wHU7C7pccxHS3yWB8E91QB7sa48V+jGNlOdhNC5i3FHOZ7aIvh2XnDzSVhTL9SVWO
         CdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152071; x=1733756871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giwDlU+R5dTUnBam3akNI1X1xsvwSGinfbQy4l6MDTM=;
        b=kU4BVe9C+QgY3AYAv0wuMxsHD7auo2cm7DG+hiT4DU2hTBFhknKvGqB8qGCJNWj64I
         l1keLtBYwAUjd/F7hc6vhcMP7HPEWZ/l5lI7NOu92GinrWcGu8/J/xY0adVJeDQCNuHT
         z/zmRdCxvr6XGPwYSuOVspiGZzJ9B4VGRQ3heYp/AWR+9kimQubYVZyK45QBODbMRJEI
         jegrqRdNlpKREKdIA7TQQf+RgPJO+EYHZyIaRiUgoftdheERckWqQ5CQCM2eDBQmRD9m
         +MIeAFw/YiFQuRf9kMSYQdjAvdny/fGZpiQ3BOWUS88mLI3ZcmJhH5fUPBciyp4QvnA4
         IDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYnMif6jJFteHXOEjWWtInCpJfTQxU8skQOHOKU3cVSSBrwZ0DCq7YRTGuIZ4hosmzbyvwgE/ZRpH+GnwdSXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAHoAnRQFMXFF0HBPfMuqQOxQGUc7yzzzg9Xe2mEGMwBUuKL5
	OYv+9eqSsbl33R03SVa1sw7b9YsoFvwZew+9axoOyAUSVhLSZH88hk/0QGZWFsE=
X-Gm-Gg: ASbGncs1jQgRxGf2sTKpj+41K1Iu1iW50z9gyoKxTBaXFNlYP6l/pXSdYqYjKt6LAL9
	d4Aqtbl/gTkwikhFwWe1ToJQ2yR6wE+MPj+iISmyqj6OsJQ6ArlmmuONmP7aIkbsKFQ3CldvP0/
	fFagKYANIUR5/CIkAUakCrWGFtvR/X8wXpdm9+B151E4Wqft24IP4SvRZC8IlytSuJy8rI1jZAb
	Vpbg6MVMKhLeXcYxn8qt5r5CF05njuj3bdr2//oWno9zZDcjEoyzDDPyoAL
X-Google-Smtp-Source: AGHT+IGSYmMmUceAaB98cMz6fSPd8hROL8mEZRHb1C+MfYB6TGRvzFggjUkbg1OSqPqAqKO3Zl1q/Q==
X-Received: by 2002:a05:6000:4024:b0:385:e968:f189 with SMTP id ffacd0b85a97d-385e968f21amr5853832f8f.51.1733152068919;
        Mon, 02 Dec 2024 07:07:48 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:07:48 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:19 +0100
Subject: [PATCH net-next v12 01/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-1-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 steffen.klassert@secunet.com, antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8900; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Gm3qMOOrhFS5KbClvr5Vuxn/Cz6BoXOHLi0W7qkVsCo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1lrm7Opb533epcWFROSe3yzLnBzibVWer1z
 rxhXfJsYTWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZQAKCRALcOU6oDjV
 hw42CACjz7AJEN8EoJLea4mBcqtDYSzZD39kuQmehBqvSV9+KcTaQ1vmQpjVwgvKIWTx+j7vm3B
 6AZku9vNl0jdtQwWU5I3el00rnOaxJKVowrUIh0ZowlDzW8A6Aap138RHNVjqNBVds3SEwjkbAj
 vNS9Fw3d42ZWMO2EmbFStu+ekRM3/9caZ9ch+Z8s71nWxf3jcHm1eAhgzGpXJpSVTPI3LMyg9dR
 SegzQWaioqOnVxqbfROrNoY92gt0G+g6siR/7JsfXfKYyE+v6Va43X2SP5DCOhCx2+qT/gufwRs
 tX3H4eXOYMKB2nQ0hNmPJADHtfOle5X37hfcK1i8X8QiDOsr
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
index 0456a33ef65792bacb5d305a6384d245844fb743..6de1767f7cc80a571e0ab6e9f4dfe5650eb704d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17472,6 +17472,14 @@ F:	arch/openrisc/
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


