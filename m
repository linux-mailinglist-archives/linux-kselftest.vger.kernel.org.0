Return-Path: <linux-kselftest+bounces-20927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2729B4744
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4101F241E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409862064FD;
	Tue, 29 Oct 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OmY8aJtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A60204F7F
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198887; cv=none; b=KvFCa9+2r8cN3d0A9fk6s02+iDd76FdrTm7fk5LQtAr/im3NG5ZQiWx/hgxkr8TV+kTDlDjBb8FtuZo5Q/SqVf8et6vMgYrf9iszwDoESm643MKlFlIluCM6+TRUWGjHdEBD/HRDwD/F/JlkO8cG81HyFdWvCQTze+F5oNdH4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198887; c=relaxed/simple;
	bh=lvzd94ZX1xO5KCS5W5DswGWNobQJUM2Qovs4Wo1NJKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qv4/ZNdmN5hSdXaZqTuSLGzJba9kmXFTzNXO+GaG9G1UcEN2pnajXhSfa27erIPmCmiTFoUllpGeaxg0ClnYdFNoWaEHzjwc87bH9o8zrPn1cttn2Na8Fkw+LsXzGSMoBdpGSc2dvXRnacR2dBNiB72gZEN6h8/ML7CPE800rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OmY8aJtJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso69947235e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198881; x=1730803681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3JtKHlTLWDllDEplXSlYsK9XviCHGby3URyJk5nrzo=;
        b=OmY8aJtJafrvMsbVsb01evC96YMIdVk0rlELEX2b0MOf87COg/KSFWao4vlEblnk8g
         nS/mDwUtuJAR/fxbrTj5HoDsvYr+S1Qg2SdCDvqrFAEO0+uCvYuvIu4mGG6lwhN0tMGM
         1IqrkCHNvsd/6HuVkOP38OAQANYmkD/5wAmvri1E66cyIshW6QPxPHCwwBjHocse8PXS
         pMqLVPP123wP1ECffNK9jie89SLpeZwLk4L0Z4BXALycNQ+44IlzI2kl3hq8TDmj888G
         5xWq1xUo13eBH1Fg2uVQFpQ0j41KxrHug+CUg4oAydzmp2WBs6WizXx1sftyfVRXGfuK
         ZW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198881; x=1730803681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3JtKHlTLWDllDEplXSlYsK9XviCHGby3URyJk5nrzo=;
        b=aLFmjNq79+lX3+jAD0hDA7pgZBLs+WtWUdZo+H7EPxV4KIZPsbU36VpoT1FEaA7Q8i
         hdh5KewDd7m8K0OGG4AhydiqlegPd/YwB5/Qsx0YN5z+OL3nEbqnvspNUbUaDceykfph
         s/t1UsgbVYKYwETjKO6eKtclTnkvY8AvrgcIPYQEo4heEjcxMgKKBnUdjEyJLcGvC1t/
         LKU2XF9e9QqUG9D+3KUpuraTYS6BchGu+27TESA5Dz8cvHms7OJK85lb3xppAkgd0Z9/
         XRqiNFNZxHN+Yj/korzsOhR4lfbg0aeLjTwZnVITICzOfDEXBgGy8oF3lzK1GcEGYE6R
         0Iig==
X-Forwarded-Encrypted: i=1; AJvYcCUskRxXToZGomrqUQ73ItvCebZm3y+AdpUdT/tBbCeHvmflUsVFIICaXMH+qj2j1srP6Ypn1KgRdh2yjQ3jNq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZt9njpAKcfVDmUvPZg6FYrMfyTvwAq63W2b1YflkGUeqCw3Y
	rQ1HogkMh+r2Ia8ueEHytjpNZZbqtW6RE6ZLgdeN0w7oQJ1lXImP0CdWIQEs8DI=
X-Google-Smtp-Source: AGHT+IGTd+SrbfBGpujOFADTA+IXvTm3AaxN4xdOwVtHQtfKHl1zNjq4kVOvmh00QDxaAx0qxPek+Q==
X-Received: by 2002:a05:600c:5249:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4319ad293bfmr101822675e9.35.1730198880748;
        Tue, 29 Oct 2024 03:48:00 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:15 +0100
Subject: [PATCH net-next v11 02/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-2-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11823; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=lvzd94ZX1xO5KCS5W5DswGWNobQJUM2Qovs4Wo1NJKk=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1qNhjylsDwAB4OFy0pRopIzLoxG5rREtcxG
 8/WOCJC4lOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9agAKCRALcOU6oDjV
 h+9PCACsWVxbQZjIZ6EqpM0fh5fzB1jXyb2H90YfqQ4c36fI+0LauqSTNk9YKqnCBXkIdTSc5xg
 /tovT8kp0SwTIgvfRbvUrVkONmc5OdKp/Z8XKV5HgWh5YnhhRJFp/OhBb0vtPZkHlAxWdT8Qzgo
 n0wnPSEEfVIAm51qK/eT4sQmWhSanPdzqg37gcLYfWfpRKlsXxPU2IMfDGh5Gj9k4UUdR2IjmiA
 tAjCrZPHUc8mCZ9zwqLLv1FuwamEWZQ5idPnra3ByqGZwJ5vGtCtLQHPbY7bI1/tJNPg4qFr6/2
 G9uoeXo4GgHuo52bYcA0t1ZCSs5TRD4Ry50QC/g3NVzDWYq0
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

Both UDP and TCP sockets ae supported.

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
 drivers/net/Kconfig       |  13 ++++++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  11 +++++
 drivers/net/ovpn/io.c     |  22 +++++++++
 drivers/net/ovpn/io.h     |  15 ++++++
 drivers/net/ovpn/main.c   | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/main.h   |  15 ++++++
 include/uapi/linux/udp.h  |   1 +
 9 files changed, 202 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f16b1245924bfe381cd64d499ff8a..09e193bbc218d74846cbae26f80ada3e04c3692a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17286,6 +17286,14 @@ F:	arch/openrisc/
 F:	drivers/irqchip/irq-ompic.c
 F:	drivers/irqchip/irq-or1k-*
 
+OPENVPN DATA CHANNEL OFFLOAD
+M:	Antonio Quartulli <antonio@openvpn.net>
+L:	openvpn-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Supported
+T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+F:	drivers/net/ovpn/
+
 OPENVSWITCH
 M:	Pravin B Shelar <pshelar@ovn.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6af0e1a861867039c3624fc618e25..269b73fcfd348a48174fb96b8f8d4f8788636fa8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,19 @@ config WIREGUARD_DEBUG
 
 	  Say N here unless you know what you're doing.
 
+config OVPN
+	tristate "OpenVPN data channel offload"
+	depends on NET && INET
+	select NET_UDP_TUNNEL
+	select DST_CACHE
+	select CRYPTO
+	select CRYPTO_AES
+	select CRYPTO_GCM
+	select CRYPTO_CHACHA20POLY1305
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
index 0000000000000000000000000000000000000000..53fb197027d787d6683e9056d3d341abf6ed38e4
--- /dev/null
+++ b/drivers/net/ovpn/Makefile
@@ -0,0 +1,11 @@
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
+ovpn-y += io.o
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
index 0000000000000000000000000000000000000000..aa259be66441f7b0262f39da12d6c3dce0a9b24c
--- /dev/null
+++ b/drivers/net/ovpn/io.h
@@ -0,0 +1,15 @@
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
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+
+#endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 0000000000000000000000000000000000000000..369a5a2b2fc1a497c8444e59f9b058eb40e49524
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,116 @@
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
+#include "main.h"
+#include "io.h"
+
+/* Driver info */
+#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
+#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
+
+/**
+ * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
+ * @dev: the interface to check
+ *
+ * Return: whether the netdevice is of type 'ovpn'
+ */
+bool ovpn_dev_is_valid(const struct net_device *dev)
+{
+	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
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
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_AUTHOR(DRV_COPYRIGHT);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
new file mode 100644
index 0000000000000000000000000000000000000000..a3215316c49bfcdf2496590bac878f145b8b27fd
--- /dev/null
+++ b/drivers/net/ovpn/main.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_MAIN_H_
+#define _NET_OVPN_MAIN_H_
+
+bool ovpn_dev_is_valid(const struct net_device *dev);
+
+#endif /* _NET_OVPN_MAIN_H_ */
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index d85d671deed3c78f6969189281b9083dcac000c6..edca3e430305a6bffc34e617421f1f3071582e69 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -43,5 +43,6 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_OVPNINUDP	8 /* OpenVPN traffic */
 
 #endif /* _UAPI_LINUX_UDP_H */

-- 
2.45.2


