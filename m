Return-Path: <linux-kselftest+bounces-24246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1EA09DC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7E03A8B09
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E833218599;
	Fri, 10 Jan 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F2AUhafF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986F215F40
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547977; cv=none; b=gMtnC9T90TeN77JtVcM+kHqb5sq1E0fxqrfgKcYTpwvawDoBIrP02q0Id6qdL1uhBHT8ydoxP7FRPjwixyRuyQsMxPPNrhD6MNgWMb6Xy/OfvzjUK4WOs+sZSH8LdhofC/1yBKcWGTSnvEY6v80/UK+bpancz0CX7YVPypxansI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547977; c=relaxed/simple;
	bh=MtFsQqfkWLnSmYY+yVDoPFK/owgdlrNwRU3ksMmDrAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ut1F5bTNhOLqQRE+aMN/ChYIcX24bwIoRY9+mLW0kYQ1PAdFXHqQh9C0dXnr29xJBqVuV/xd/25QbG4MWje96zJK7p//4Gk2ZRl/N7RpM9LEBa2lz5d4zVUb22h+pjLdzpZLkD88Ch6bcBMsV0EuExAXMe7vOM0iTOY1/RNxJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F2AUhafF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436281c8a38so18657125e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547973; x=1737152773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMtIidlseqAVU2mwjq0O0X5tCAt8KkFhvpzEkA1DELk=;
        b=F2AUhafFOXG49NKBQBNbEfYjCoOz5km2PrAHiO8n+Z4BC2mQvUD9Pt7sHEZwDJWciv
         1dgPCf6JMwiJSs86aaLtnU+XR88y4Doa9X9uCeuLkPqDmHO7ZcTlAas+mQ3EIEQu33yD
         /5tjBxTbxz0XDJ/7xLGOurSMil+rQktSs2WDnZIDrecStSelknZnOWymMLoyAgWwt8kd
         LT86ky15dJJPPFPBbjJvRYb4xvfBd3GJ2TSkvbYSigzqB7OFjbk3MVrrLPBWTRSgwq3B
         DxkuFX0OIlM+2hKpBwO+KgjgqUSasKkO+TzFECkfz4ampMTJUV/xCWYxKXPJAPm/hACA
         ipyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547973; x=1737152773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMtIidlseqAVU2mwjq0O0X5tCAt8KkFhvpzEkA1DELk=;
        b=DAOaU+Qo2F63MBFEOkD/Rx6eVkIrETSyusWCq0qdWdJ2HXUFQNA/woguu5+S/DWd7Z
         06q+hPnZHafdnB0a9PlYntO/UUlDEICcBBuwNAljYPULArWU+K1DkoOanshasduKm4wq
         TXCh2I67PdlmGTuXjM+na6ddPl5vWRzI32M+5mm7ie+IaTM234JlnbiMxUzPQYIn7E+3
         X5v57RAFmv1CPS+tzfCw4r3MBRuSlUP+IsIwpUgJD9BoOKZIw9u5YI1gqfOKTu6FO65N
         6ymXVmS6/UG5mRCKlA2dhCfyc7NSr8mw//sP6flmRypNR6pcXuKNzAUeFhbYY9ObJZbG
         Up4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAAIVx+mRo9xfNq8ErIhs8y01VYlBXfI5FZsWtoPc7ybg7WoKFKlXyFdJjmtTX8QyuDfy9BXqWY4L7AB6DXUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlqm9+FZIaRvWCcq4qoLmj67+NKARQPyk80uaHFs1jMlKVi6fq
	/xj2pZuS9Vq2gfm1+xlOThzvubbrtOfEXDjvD9ajfsiMhcCUTYCpPYjgad2D4aYA7euhp7k8zPO
	S
X-Gm-Gg: ASbGncsz8PWGRxDBoU2jOXwY687PdKdvU0nSf7hLK5FHNekJ/kzlVOOqWNAcXid8osa
	taKbBaOJmiP2q/p0/qMME+czn5KQ5WdtoPqk4ORuzTXHUKY+PWt827JXLmhVdIGzu8JUTQoHeHf
	KUOwPN1rR8dvRi4jdkq5p+PlPfeSc/AytdtMS66KquvPsks94OMolp9FYMxlSzLo3EoamCrPM4h
	1vYSQ49UdidPhOTlcacE85z5B886+XM70hopXBcSmz/3iI5xKuncF23iF62KNeHWzfI
X-Google-Smtp-Source: AGHT+IEHp9nF8TgqX15mVngSkyilBmShihyW5cLRzLAPn4SzcmAB13/55yKQPRYaYwcb6yyP0dhggg==
X-Received: by 2002:a05:600c:138d:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-436e26849f1mr125651785e9.5.1736547972828;
        Fri, 10 Jan 2025 14:26:12 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:12 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:17 +0100
Subject: [PATCH net-next v17 01/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-1-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8929; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=MtFsQqfkWLnSmYY+yVDoPFK/owgdlrNwRU3ksMmDrAA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6vMrohTLDpyOzhaSClviRnkDQ4iGx70NPrq
 jpK5WXg+MWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GerwAKCRALcOU6oDjV
 h9YWB/9Mb+zzXsBdoVEhm57GygtCUJJCfaxPmxGjSJesPXxB1dCjgVDUyutHk8CouZ5Eg0QPweS
 rnmj4lfQYMGBB/szwiaVimW7/+tjlTYY/asIEVax9SMV8whWJTPqmaxdXiQUgJ3faBG0MnMqMz1
 wdYBdPZvAbwJgWEfSIlMtlAPpHNrsoTDhTm6+/TCPWk8OWYcXWnajSLsLqxVJwn4G6vDGMTnZtF
 jky4djTSbWGAmUVgxIfQn6OHZiX43ISsv8KLJIj61ktRXEohvDhlTGWx0uITJFEtEsS1sY7CKy/
 /5mrvTlbao4gz6wfIuT4eeWzTfEh5POkRdAJws3eHj3JC4Tn
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
index 3f3e289b391c3196165114eccf6dc932d892ff81..ddb53e7915ddf71459ca249fd8ac0edea2d571ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17556,6 +17556,14 @@ F:	arch/openrisc/
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


