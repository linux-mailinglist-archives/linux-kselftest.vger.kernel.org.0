Return-Path: <linux-kselftest+bounces-23545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E39F71F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6891892587
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C6154BE2;
	Thu, 19 Dec 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Q574POie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BA8633E
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572531; cv=none; b=pgEyMRSOqaAvBCSrR9haP6Qop1ZVU/aQcI7li+2cyxn3nyfWSfjmSuY2A3PtgSsJmH3kU2IMbYaHGts9D1EAsoKbT9IqCRQTWs6sbkP7aFuArcwz9PC6lA3dxpAf8ilR9GgEjIg8g82+oz+FwBKHx9UrOmB7NeU6+7Pb72ROUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572531; c=relaxed/simple;
	bh=+VqApLc93XphEBkhD3y2Cca2l1oUrati1A49qZ9w/Mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/ftWgXBm+nucsMPaPKDlRs2pQEZJVwAF6Lbq+OpH+Wg2FptbBxkrnWcOQD667acP0GHH2RR/4yqrSfE1T4zpEm+FmM2CiOMlTbkrt1UqLDmNdF5Kt0tmWDv6L6cApFmB7hy1BvoPIiDHAzOVhmZAyYJ17AZy9ct4VPGmI87GTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Q574POie; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso252291f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572526; x=1735177326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNlXGTPGjVF1jzYREYfq1ygvL+0uk21e7OpuYM40qlY=;
        b=Q574POieZq5Wdd3cUBPl3JcdTdQJlzEZfjtqH1N34ecxdEn3d0QEH/Gqc/6jmjtQsN
         +3L5e2lZ0lYwBahMV3lX7Omhycv614EfXWud/vZAtQPb4TEktUtshRGroOeJ85f2dL3t
         UGpopDPJnP3D7B70hh+UFO2FRAanV6ECjvcMxKw1Qwlf8ZWfIRgASblY85Av9Uzq3QQc
         WTPH8qwVECny/m0zr1j/PGj4XV4EyRGWmPCCcXJS7bByu0ztliE/X2cm7tnFGEa4/zUv
         Ki0Ksfk6Ew44IuOof2DqHWxDvuXCDGdQK0R72k7jVyB1klpOpv//BzVs/elELwoFKrb5
         uOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572526; x=1735177326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNlXGTPGjVF1jzYREYfq1ygvL+0uk21e7OpuYM40qlY=;
        b=mldm1lX903O/KwB8eU3y1+vdXuizn1H84SeDymp6hiQ4Nj+BakU5n5/AvNj/JVyJIt
         7SK41fECJ7Mtfk0S/+0e7SkpKWpYZDPYEE9T7O6/Y68qpfQLZ63GqEFH2CMsCnRvAwp5
         loA35j6z5v7rKEfrOJ325jtQk1sM+B+zAPrIh/q7WvzrkAXpO7egBPrAGcG3Vc01VrPC
         UDxOf+ePXpf3g1yUgKKNyBDNy8Vcc+tcv5Kdmn2yj2D0CN30C5Je0WZ737it2Ne1VygF
         h3KwjTVApYTz6t+pcnfQezSW5guSDkOfZEMXtVPuWdXirf+AW9bwBaakm7jhR2wI0Vop
         9y0w==
X-Forwarded-Encrypted: i=1; AJvYcCVpdwreiwpA4uFdtaBsouxT/zDsOmzDgdrIAwUVbCPe8gAAv/FPLhzrpOknf5owiFBu+BoB9Db/1Q5zkv6X3g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEacQctqNrAHbHiyBxZwnCZcxvNSZMT6wZqOQpgiSoxc09Q25
	s0K4y7gWgY28IfmG1Opk/S6CmyAG6a/EM13V+8AZjzSyi/6/18RyG+3x+f1sS/I=
X-Gm-Gg: ASbGncsxkpFJxUEgD4lbUNrAVNGdNLBf4CsAfH7WfVr6/IMDv24AupWsApLmNwqQ1up
	V1rUHQ1ZVHhoAy543Eyod22my476nVXN/tgB6GWurGK1YiD4iAgD/7qHqymg4eSA2WL3LcZwKLG
	GbcLvhDshEXpZroElmIN+fKCQkyTnF8p5yKMCAyOGb/XBqK3pIgx+rxMeK4TmgSnTwPoq/5dq4w
	9XNusRjHOzPVbO05fWFA8ava87KP1mpdi7lj0MFCeaVSZ5cPYMd3NkZIA2IvNs+gOb0
X-Google-Smtp-Source: AGHT+IHGMHe7IeRugMPUsRE22wlqM3NrzH3cznNJEnsJFD6ABZeqnXztk0SlTngN0Z/ND8FEptBKhA==
X-Received: by 2002:a05:6000:1785:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-38a19a64335mr1744428f8f.0.1734572526392;
        Wed, 18 Dec 2024 17:42:06 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:05 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:41:59 +0100
Subject: [PATCH net-next v16 05/26] ovpn: introduce the ovpn_peer object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-5-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22181; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+VqApLc93XphEBkhD3y2Cca2l1oUrati1A49qZ9w/Mo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oU6sX0v6xv631RjoyoGJFYwHpzDFhFvLfzZ
 zaKGHcY1d6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FAAKCRALcOU6oDjV
 hxUBB/0Y2AZwkKGU7Za044BMo45fght4vTR5PAEmZZIZWfod0mGnUrRDa8Q9tce2VA0HHawXgaE
 /zycteoAdp5vKwLEsz9hKWM0rEiIH//a1PUe81UYjPDpC7oCYDo7Fg8ShxP+S+XNjBq4efdbnaW
 kAMbOilgZtAAMS0Vho+NOXyvDRJBqRkI/tqjvF3vujIAYi6dl+2+/3+Ce5UkX02c2Ix26AK1tBE
 qYr5rh3InXm1f0+VW1v7qvScfQrwViRgMoM43wKDWrgpLvCUb+NJkgbxr2lztXRhzupa7idakZn
 kc5no1TMB/RLTf8AjqUw5QW0amRQTVW3LRkrp852vtxaeHT7
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn_peer object holds the whole status of a remote peer
(regardless whether it is a server or a client).

This includes status for crypto, tx/rx buffers, napi, etc.

Only support for one peer is introduced (P2P mode).
Multi peer support is introduced with a later patch.

Along with the ovpn_peer, also the ovpn_bind object is introcued
as the two are strictly related.
An ovpn_bind object wraps a sockaddr representing the local
coordinates being used to talk to a specific peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig           |   1 +
 drivers/net/ovpn/Makefile     |   2 +
 drivers/net/ovpn/bind.c       |  58 +++++++
 drivers/net/ovpn/bind.h       | 101 +++++++++++
 drivers/net/ovpn/main.c       |  18 +-
 drivers/net/ovpn/ovpnstruct.h |   4 +
 drivers/net/ovpn/peer.c       | 383 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  78 +++++++++
 8 files changed, 644 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 2ace5e27c37ed3bad2e0000775cd172cb6de3225..dfd1ad96230317c4118b63c9c98d0a631f6cbb21 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -119,6 +119,7 @@ config OVPN
 	tristate "OpenVPN data channel offload"
 	depends on NET && INET
 	depends on IPV6 || !IPV6
+	select DST_CACHE
 	help
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 201dc001419f1d99ae95c0ee0f96e68f8a4eac16..ce13499b3e1775a7f2a9ce16c6cb0aa088f93685 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -7,7 +7,9 @@
 # Author:	Antonio Quartulli <antonio@openvpn.net>
 
 obj-$(CONFIG_OVPN) := ovpn.o
+ovpn-y += bind.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
+ovpn-y += peer.o
diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
new file mode 100644
index 0000000000000000000000000000000000000000..b4d2ccec2ceddf43bc445b489cc62a578ef0ad0a
--- /dev/null
+++ b/drivers/net/ovpn/bind.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2012-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+
+#include "ovpnstruct.h"
+#include "bind.h"
+#include "peer.h"
+
+/**
+ * ovpn_bind_from_sockaddr - retrieve binding matching sockaddr
+ * @ss: the sockaddr to match
+ *
+ * Return: the bind matching the passed sockaddr if found, NULL otherwise
+ */
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
+{
+	struct ovpn_bind *bind;
+	size_t sa_len;
+
+	if (ss->ss_family == AF_INET)
+		sa_len = sizeof(struct sockaddr_in);
+	else if (ss->ss_family == AF_INET6)
+		sa_len = sizeof(struct sockaddr_in6);
+	else
+		return ERR_PTR(-EAFNOSUPPORT);
+
+	bind = kzalloc(sizeof(*bind), GFP_ATOMIC);
+	if (unlikely(!bind))
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&bind->remote, ss, sa_len);
+
+	return bind;
+}
+
+/**
+ * ovpn_bind_reset - assign new binding to peer
+ * @peer: the peer whose binding has to be replaced
+ * @new: the new bind to assign
+ */
+void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
+{
+	struct ovpn_bind *old;
+
+	spin_lock_bh(&peer->lock);
+	old = rcu_replace_pointer(peer->bind, new, true);
+	spin_unlock_bh(&peer->lock);
+
+	kfree_rcu(old, rcu);
+}
diff --git a/drivers/net/ovpn/bind.h b/drivers/net/ovpn/bind.h
new file mode 100644
index 0000000000000000000000000000000000000000..343e6055deef9223a11176f62b94f6c8ed3eb18f
--- /dev/null
+++ b/drivers/net/ovpn/bind.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2012-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNBIND_H_
+#define _NET_OVPN_OVPNBIND_H_
+
+#include <net/ip.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/rcupdate.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+
+struct ovpn_peer;
+
+/**
+ * union ovpn_sockaddr - basic transport layer address
+ * @in4: IPv4 address
+ * @in6: IPv6 address
+ */
+union ovpn_sockaddr {
+	struct sockaddr_in in4;
+	struct sockaddr_in6 in6;
+};
+
+/**
+ * struct ovpn_bind - remote peer binding
+ * @remote: the remote peer sockaddress
+ * @local: local endpoint used to talk to the peer
+ * @local.ipv4: local IPv4 used to talk to the peer
+ * @local.ipv6: local IPv6 used to talk to the peer
+ * @rcu: used to schedule RCU cleanup job
+ */
+struct ovpn_bind {
+	union ovpn_sockaddr remote;  /* remote sockaddr */
+
+	union {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} local;
+
+	struct rcu_head rcu;
+};
+
+/**
+ * ovpn_bind_skb_src_match - match packet source with binding
+ * @bind: the binding to match
+ * @skb: the packet to match
+ *
+ * Return: true if the packet source matches the remote peer sockaddr
+ * in the binding
+ */
+static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind,
+					   const struct sk_buff *skb)
+{
+	const union ovpn_sockaddr *remote;
+
+	if (unlikely(!bind))
+		return false;
+
+	remote = &bind->remote;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(remote->in4.sin_family != AF_INET))
+			return false;
+
+		if (unlikely(remote->in4.sin_addr.s_addr != ip_hdr(skb)->saddr))
+			return false;
+
+		if (unlikely(remote->in4.sin_port != udp_hdr(skb)->source))
+			return false;
+		break;
+	case htons(ETH_P_IPV6):
+		if (unlikely(remote->in6.sin6_family != AF_INET6))
+			return false;
+
+		if (unlikely(!ipv6_addr_equal(&remote->in6.sin6_addr,
+					      &ipv6_hdr(skb)->saddr)))
+			return false;
+
+		if (unlikely(remote->in6.sin6_port != udp_hdr(skb)->source))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *sa);
+void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *bind);
+
+#endif /* _NET_OVPN_OVPNBIND_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 97fcf284c06654a6581be592e45f77f0f78f566f..a2d953dccd2cd9372f486b6f35479fb0180760b8 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -19,8 +19,14 @@
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
+#include "peer.h"
 #include "proto.h"
 
+static int ovpn_net_init(struct net_device *dev)
+{
+	return 0;
+}
+
 static int ovpn_net_open(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
@@ -43,6 +49,7 @@ static int ovpn_net_stop(struct net_device *dev)
 }
 
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_init		= ovpn_net_init,
 	.ndo_open		= ovpn_net_open,
 	.ndo_stop		= ovpn_net_stop,
 	.ndo_start_xmit		= ovpn_net_xmit,
@@ -115,6 +122,7 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 
 	ovpn->dev = dev;
 	ovpn->mode = mode;
+	spin_lock_init(&ovpn->lock);
 
 	/* turn carrier explicitly off after registration, this way state is
 	 * clearly defined
@@ -174,10 +182,18 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 
 		netif_carrier_off(dev);
 		ovpn->registered = false;
+
+		if (ovpn->mode == OVPN_MODE_P2P)
+			ovpn_peer_release_p2p(ovpn,
+					      OVPN_DEL_PEER_REASON_TEARDOWN);
+		break;
+	case NETDEV_DOWN:
+		if (ovpn->mode == OVPN_MODE_P2P)
+			ovpn_peer_release_p2p(ovpn,
+					      OVPN_DEL_PEER_REASON_ADMINDOWN);
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
-	case NETDEV_DOWN:
 	case NETDEV_UP:
 	case NETDEV_PRE_UP:
 		break;
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 312bc22199383fed0746335fde3339646bb68b2b..a6cfb436f3d0d79a0c438e647f8652021119b0ed 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -20,12 +20,16 @@
  * @dev_tracker: reference tracker for associated dev
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @lock: protect this object
+ * @peer: in P2P mode, this is the only remote peer
  */
 struct ovpn_priv {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
 	bool registered;
 	enum ovpn_mode mode;
+	spinlock_t lock; /* protect writing to the ovpn_priv object */
+	struct ovpn_peer __rcu *peer;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
new file mode 100644
index 0000000000000000000000000000000000000000..4dc6bc20ece25abc1827c2e9cf6074fcc580fa77
--- /dev/null
+++ b/drivers/net/ovpn/peer.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/skbuff.h>
+#include <linux/list.h>
+
+#include "ovpnstruct.h"
+#include "bind.h"
+#include "io.h"
+#include "main.h"
+#include "netlink.h"
+#include "peer.h"
+
+/**
+ * ovpn_peer_new - allocate and initialize a new peer object
+ * @ovpn: the openvpn instance inside which the peer should be created
+ * @id: the ID assigned to this peer
+ *
+ * Return: a pointer to the new peer on success or an error code otherwise
+ */
+struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
+{
+	struct ovpn_peer *peer;
+	int ret;
+
+	/* alloc and init peer object */
+	peer = kzalloc(sizeof(*peer), GFP_KERNEL);
+	if (!peer)
+		return ERR_PTR(-ENOMEM);
+
+	peer->id = id;
+	peer->ovpn = ovpn;
+
+	peer->vpn_addrs.ipv4.s_addr = htonl(INADDR_ANY);
+	peer->vpn_addrs.ipv6 = in6addr_any;
+
+	RCU_INIT_POINTER(peer->bind, NULL);
+	spin_lock_init(&peer->lock);
+	kref_init(&peer->refcount);
+
+	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev,
+			   "cannot initialize dst cache for peer %u\n",
+			   peer->id);
+		kfree(peer);
+		return ERR_PTR(ret);
+	}
+
+	netdev_hold(ovpn->dev, &ovpn->dev_tracker, GFP_KERNEL);
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_release_rcu - RCU callback performing last peer release steps
+ * @head: RCU member of the ovpn_peer
+ */
+static void ovpn_peer_release_rcu(struct rcu_head *head)
+{
+	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
+
+	/* this call will immediately free the dst_cache, therefore we
+	 * perform it in the RCU callback, when all contexts are done
+	 */
+	dst_cache_destroy(&peer->dst_cache);
+	kfree(peer);
+}
+
+/**
+ * ovpn_peer_release - release peer private members
+ * @peer: the peer to release
+ */
+static void ovpn_peer_release(struct ovpn_peer *peer)
+{
+	ovpn_bind_reset(peer, NULL);
+	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
+	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
+}
+
+/**
+ * ovpn_peer_release_kref - callback for kref_put
+ * @kref: the kref object belonging to the peer
+ */
+void ovpn_peer_release_kref(struct kref *kref)
+{
+	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
+
+	ovpn_peer_release(peer);
+}
+
+/**
+ * ovpn_peer_skb_to_sockaddr - fill sockaddr with skb source address
+ * @skb: the packet to extract data from
+ * @ss: the sockaddr to fill
+ *
+ * Return: sockaddr length on success or -1 otherwise
+ */
+static int ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
+				     struct sockaddr_storage *ss)
+{
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		sa4 = (struct sockaddr_in *)ss;
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa4->sin_port = udp_hdr(skb)->source;
+		return sizeof(*sa4);
+	case htons(ETH_P_IPV6):
+		sa6 = (struct sockaddr_in6 *)ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		return sizeof(*sa6);
+	}
+
+	return -1;
+}
+
+/**
+ * ovpn_peer_transp_match - check if sockaddr and peer binding match
+ * @peer: the peer to get the binding from
+ * @ss: the sockaddr to match
+ *
+ * Return: true if sockaddr and binding match or false otherwise
+ */
+static bool ovpn_peer_transp_match(const struct ovpn_peer *peer,
+				   const struct sockaddr_storage *ss)
+{
+	struct ovpn_bind *bind = rcu_dereference(peer->bind);
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+
+	if (unlikely(!bind))
+		return false;
+
+	if (ss->ss_family != bind->remote.in4.sin_family)
+		return false;
+
+	switch (ss->ss_family) {
+	case AF_INET:
+		sa4 = (struct sockaddr_in *)ss;
+		if (sa4->sin_addr.s_addr != bind->remote.in4.sin_addr.s_addr)
+			return false;
+		if (sa4->sin_port != bind->remote.in4.sin_port)
+			return false;
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)ss;
+		if (!ipv6_addr_equal(&sa6->sin6_addr,
+				     &bind->remote.in6.sin6_addr))
+			return false;
+		if (sa6->sin6_port != bind->remote.in6.sin6_port)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * ovpn_peer_get_by_transp_addr_p2p - get peer by transport address in a P2P
+ *                                    instance
+ * @ovpn: the openvpn instance to search
+ * @ss: the transport socket address
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *
+ovpn_peer_get_by_transp_addr_p2p(struct ovpn_priv *ovpn,
+				 struct sockaddr_storage *ss)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	rcu_read_lock();
+	tmp = rcu_dereference(ovpn->peer);
+	if (likely(tmp && ovpn_peer_transp_match(tmp, ss) &&
+		   ovpn_peer_hold(tmp)))
+		peer = tmp;
+	rcu_read_unlock();
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_get_by_transp_addr - retrieve peer by transport address
+ * @ovpn: the openvpn instance to search
+ * @skb: the skb to retrieve the source transport address from
+ *
+ * Return: a pointer to the peer if found or NULL otherwise
+ */
+struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
+					       struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+	struct sockaddr_storage ss = { 0 };
+
+	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
+		return NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_get_by_id_p2p - get peer by ID in a P2P instance
+ * @ovpn: the openvpn instance to search
+ * @peer_id: the ID of the peer to find
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_priv *ovpn,
+						 u32 peer_id)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	rcu_read_lock();
+	tmp = rcu_dereference(ovpn->peer);
+	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold(tmp)))
+		peer = tmp;
+	rcu_read_unlock();
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_get_by_id - retrieve peer by ID
+ * @ovpn: the openvpn instance to search
+ * @peer_id: the unique peer identifier to match
+ *
+ * Return: a pointer to the peer if found or NULL otherwise
+ */
+struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
+{
+	struct ovpn_peer *peer = NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+
+	return peer;
+}
+
+static void ovpn_peer_remove(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
+{
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_P2P:
+		RCU_INIT_POINTER(peer->ovpn->peer, NULL);
+		/* in P2P mode the carrier is switched off when the peer is
+		 * deleted so that third party protocols can react accordingly
+		 */
+		netif_carrier_off(peer->ovpn->dev);
+		break;
+	default:
+		return;
+	}
+
+	peer->delete_reason = reason;
+
+	/* reference from ovpn->peer or hashtable dropped */
+	ovpn_peer_put(peer);
+}
+
+/**
+ * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
+{
+	struct ovpn_peer *tmp;
+
+	spin_lock_bh(&ovpn->lock);
+	/* in p2p mode it is possible to have a single peer only, therefore the
+	 * old one is released and substituted by the new one
+	 */
+	tmp = rcu_dereference_protected(ovpn->peer,
+					lockdep_is_held(&ovpn->lock));
+	if (tmp)
+		ovpn_peer_remove(tmp, OVPN_DEL_PEER_REASON_TEARDOWN);
+
+	rcu_assign_pointer(ovpn->peer, peer);
+	/* in P2P mode the carrier is switched on when the peer is added */
+	netif_carrier_on(ovpn->dev);
+	spin_unlock_bh(&ovpn->lock);
+
+	return 0;
+}
+
+/**
+ * ovpn_peer_add - add peer to the related tables
+ * @ovpn: the openvpn instance the peer belongs to
+ * @peer: the peer object to add
+ *
+ * Assume refcounter was increased by caller
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
+{
+	switch (ovpn->mode) {
+	case OVPN_MODE_P2P:
+		return ovpn_peer_add_p2p(ovpn, peer);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
+ * @peer: the peer to delete
+ * @reason: reason why the peer was deleted (sent to userspace)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_peer *tmp;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	tmp = rcu_dereference_protected(peer->ovpn->peer,
+					lockdep_is_held(&peer->ovpn->lock));
+	if (tmp != peer) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -ENOENT;
+	}
+
+	ovpn_peer_remove(peer, reason);
+
+	return 0;
+}
+
+/**
+ * ovpn_peer_release_p2p - release peer upon P2P device teardown
+ * @ovpn: the instance being torn down
+ * @reason: the reason for releasing the peer
+ */
+void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
+			   enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_peer *tmp;
+
+	spin_lock_bh(&ovpn->lock);
+	tmp = rcu_dereference_protected(ovpn->peer,
+					lockdep_is_held(&ovpn->lock));
+	if (tmp)
+		ovpn_peer_del_p2p(tmp, reason);
+	spin_unlock_bh(&ovpn->lock);
+}
+
+/**
+ * ovpn_peer_del - delete peer from related tables
+ * @peer: the peer object to delete
+ * @reason: reason for deleting peer (will be sent to userspace)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
+{
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_P2P:
+		return ovpn_peer_del_p2p(peer, reason);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
new file mode 100644
index 0000000000000000000000000000000000000000..c3458732b2cfcd439644423ec8cd77595f9ed5f3
--- /dev/null
+++ b/drivers/net/ovpn/peer.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNPEER_H_
+#define _NET_OVPN_OVPNPEER_H_
+
+#include <net/dst_cache.h>
+
+/**
+ * struct ovpn_peer - the main remote peer object
+ * @ovpn: main openvpn instance this peer belongs to
+ * @id: unique identifier
+ * @vpn_addrs: IP addresses assigned over the tunnel
+ * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
+ * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @dst_cache: cache for dst_entry used to send to peer
+ * @bind: remote peer binding
+ * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
+ * @lock: protects binding to peer (bind)
+ * @refcount: reference counter
+ * @rcu: used to free peer in an RCU safe way
+ * @delete_work: deferred cleanup work, used to notify userspace
+ */
+struct ovpn_peer {
+	struct ovpn_priv *ovpn;
+	u32 id;
+	struct {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} vpn_addrs;
+	struct dst_cache dst_cache;
+	struct ovpn_bind __rcu *bind;
+	enum ovpn_del_peer_reason delete_reason;
+	spinlock_t lock; /* protects bind */
+	struct kref refcount;
+	struct rcu_head rcu;
+	struct work_struct delete_work;
+};
+
+/**
+ * ovpn_peer_hold - increase reference counter
+ * @peer: the peer whose counter should be increased
+ *
+ * Return: true if the counter was increased or false if it was zero already
+ */
+static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
+{
+	return kref_get_unless_zero(&peer->refcount);
+}
+
+void ovpn_peer_release_kref(struct kref *kref);
+
+/**
+ * ovpn_peer_put - decrease reference counter
+ * @peer: the peer whose counter should be decreased
+ */
+static inline void ovpn_peer_put(struct ovpn_peer *peer)
+{
+	kref_put(&peer->refcount, ovpn_peer_release_kref);
+}
+
+struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
+int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
+			   enum ovpn_del_peer_reason reason);
+
+struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
+					       struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
+
+#endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


