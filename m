Return-Path: <linux-kselftest+bounces-28714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C0A5C007
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992EB176A42
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA2253322;
	Tue, 11 Mar 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JjJfwSyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E32220696
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694592; cv=none; b=JKblVCR+REpOTv5N41wNbglI+AIQ4wOY/uLQOu/tidBSGTu9yRzZ/+9fA/0WAkcUcSzdNp8BSGaR8RLPp6AXuMkOiBdQfoW1UgbnuPRDW032htMBQQY5N+xzlszsFQ92NOEgrfMJimn9i8bubD7hPBvXjFHMMctiPwtKpn4UGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694592; c=relaxed/simple;
	bh=nHmNAqTMEQ/DCUzCZ1vDlROUMztTfGGfdxLPdsUj75U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtDLl8Q0wdX2qIxqoLrNsgJFl7n/rhSN1br8jN4GpXbJos9H5Lf8YqIyJdrFWRA/pEJaSU50OBFOKuCAIYNGhlDSxnyIHbKoGRs1CuKFEuXRKh5l0ZjNEcgrFJWz0pRojrpzK/YlxYwsqgumR9Y1MPTYk1HexU47gR9XsKkRmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JjJfwSyD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso27190375e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694587; x=1742299387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YF7zqczbS2Cx8MLTpZ02e1Em/j9QOqc4grZHeKb4KY=;
        b=JjJfwSyDsIG7+n6BsMq5FDd67B5t+CotpL5qI2+rpW83GmCoftIh5RUdEnlQpz1jgZ
         Vl3Dd9oLp1zypCIBTxcl/i7vvPwNuwT0K4udYed+xx/BxZlQ4ZSMjtTNrJsKX50PRXXl
         u9rW8GBVP2c9V2gft+Idno7OaZCyhbROk2+Gm6/DcS9rtHY0I4tux9nGTQYdecXFN4HH
         p4nHuTmZ1J7zXnWBuPNuNfZV3nl8tph30QWM9VN8o9ViHRm0bk3kaJ+5mxabaGppJMG9
         +jGxyJWg2Thsn4SnU7Ea3ulQzdTDMz7QiJnMKlRiihHwzuQhGe/Euj+Z4aXFhgKr4Wf4
         vdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694587; x=1742299387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YF7zqczbS2Cx8MLTpZ02e1Em/j9QOqc4grZHeKb4KY=;
        b=G0TEMfB7/gzXN5I7Qd/S3dwE7JJskN17Cctp0TfYJXygFJomTOybvAXD+XlllINh/E
         HTfX0LMXwQUkgsP9XbdQQm7lnI7GGnE+6Jbw6FacxWzkEf7WJREgvOHt46tG02pROghS
         Mp1yPex9GJUO4HRkFcjzC/+BAm0QunmWm3APH1aeObOgvL2yk0kfnxZEeV2ikbBMDfEb
         2BvZaL9LuFqsolv6bXxr/DtPinhAb2O7iIAFr6fBUBX48GEOQsPZaYLiLQQXZErcuLR0
         sepBD2Y6e/iokPUTgUgjbCpWcfT1bP0zuYfEp9MFxSqNq0+PX5NHmDRAhI9MWfyl36Um
         iHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUDpuOgwQErPsb3e/li7K/VEQ8SP32Hw1tNwkBtdFxAAVBkDUS+demnWSTGFoGyNw7pRmEPHb6wl99frjdTQ94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEke5M2VjkWJyFLV7SJTEZ/gemGjFIsZVsdcUuzkylOH42NY40
	u95A3MPehicSc8EzGmNYxH2WfHP9WHQQyQFZH7r4mUEewaTmVhJeLIOE8a53ALg=
X-Gm-Gg: ASbGnctuTovdHDtneschqwrWDzR8SffEAbQpQg8VCc1FDlSNVzx7oqbMYjJJ3t+Qrst
	cxdlSLhLFSJm8Hh0zksXHenpEWA6B4BS705jxCNrRyRz57+84owuPVTSV9SCEILhllEAQ1n42YG
	s+rNEQ66gsCK1NYFjOCtCUAA+9kViAHjArQHbVp841sxhIXSyaUtOAJvBgKElAiyfzqblRfSqIL
	CGbEtI5IoN/qmQQfeWtnk6X92kMDrdEeGgacYO6FEL3tgNWpm5dV9fJrsQGlgGX3Wjyy8/gTxg3
	4YHbIbeBdnMkB9IOc4uOkkjOBikLHbGR72x2Bfv54w==
X-Google-Smtp-Source: AGHT+IFzL3RT1/n3XldSAitJ7AHWqUuz8kGXWk0swnCJwvuuF2VEpTNM1kBbSgY6abjVzuRgUM6z4w==
X-Received: by 2002:a05:600c:35d3:b0:43c:f1cd:3d78 with SMTP id 5b1f17b1804b1-43cf1cd3ecbmr83470315e9.12.1741694586994;
        Tue, 11 Mar 2025 05:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:06 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:06 +0100
Subject: [PATCH net-next v22 05/23] ovpn: introduce the ovpn_peer object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-5-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22757; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=nHmNAqTMEQ/DCUzCZ1vDlROUMztTfGGfdxLPdsUj75U=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZwvYE3ztNQcyd2SK1CdXz7qBtxBUsT2HglY
 J7NIFbHSYeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcAAKCRALcOU6oDjV
 h+qjCACjVL8eLqWgqUTujH1JBNxOtHvvP6QMDyRZZOukZfqjXjJmNM8we3Rh6+ChORxOd55ugNT
 z2zLZC4UBUXaJkWqZqsfT/RcKPEq8nzlfZFXYPOKL1zYoTyho+vMA3IUnH1pZ6t0gKM/UU9AOUr
 fx21WtzBEraSFkXUDSrABFBcS9g2gxU94sA9+4jXj54oBCj5F24heSWIP0DGDr2JUA5T3p67zom
 R69PAneXBD3yC0k993sIeksnCagnM6PbJkWweRBNIAZWV2det7dhUSZi9b0h1FGN89qrKPrab1u
 UyFtdaCjzeA1MjpPkbd+QIC7nnmgepoRh5D82X7yDray6RC/
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
 drivers/net/Kconfig         |   1 +
 drivers/net/ovpn/Makefile   |   2 +
 drivers/net/ovpn/bind.c     |  58 +++++++
 drivers/net/ovpn/bind.h     | 101 +++++++++++
 drivers/net/ovpn/main.c     |  12 ++
 drivers/net/ovpn/ovpnpriv.h |   4 +
 drivers/net/ovpn/peer.c     | 411 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h     |  80 +++++++++
 8 files changed, 669 insertions(+)

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
index 0e5f686672fb5052cee5a2c28797b70859514a7f..618328ae338861b9764b42485df71ebd0fc1fe90 100644
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
index 0000000000000000000000000000000000000000..d4a1aeed12c99c71eaf5e8e9fc9c0fe61af6aaac
--- /dev/null
+++ b/drivers/net/ovpn/bind.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2012-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+
+#include "ovpnpriv.h"
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
index 0000000000000000000000000000000000000000..4e0b8398bfd9ed60ecb01c777c61a5e6841d7dec
--- /dev/null
+++ b/drivers/net/ovpn/bind.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2012-2025 OpenVPN, Inc.
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
index c5e75108b8da5eabde25426c6d6668fb14491986..3c72b80095a0ed8f2f2064fdfa556f750f1c7061 100644
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
@@ -116,6 +123,7 @@ static int ovpn_newlink(struct net_device *dev,
 
 	ovpn->dev = dev;
 	ovpn->mode = mode;
+	spin_lock_init(&ovpn->lock);
 
 	/* turn carrier explicitly off after registration, this way state is
 	 * clearly defined
@@ -175,6 +183,10 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 
 		netif_carrier_off(dev);
 		ovpn->registered = false;
+
+		if (ovpn->mode == OVPN_MODE_P2P)
+			ovpn_peer_release_p2p(ovpn,
+					      OVPN_DEL_PEER_REASON_TEARDOWN);
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 33c2a41edf9b3204e8aebd2679649cb7158f05f2..fae2682b424b03222a5ce881a4a1b4518a7ff311 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -18,11 +18,15 @@
  * @dev: the actual netdev representing the tunnel
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @lock: protect this object
+ * @peer: in P2P mode, this is the only remote peer
  */
 struct ovpn_priv {
 	struct net_device *dev;
 	bool registered;
 	enum ovpn_mode mode;
+	spinlock_t lock; /* protect writing to the ovpn_priv object */
+	struct ovpn_peer __rcu *peer;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
new file mode 100644
index 0000000000000000000000000000000000000000..338069c99248f42b0c4aeb44b2b9d3a35f8bebeb
--- /dev/null
+++ b/drivers/net/ovpn/peer.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/skbuff.h>
+#include <linux/list.h>
+
+#include "ovpnpriv.h"
+#include "bind.h"
+#include "io.h"
+#include "main.h"
+#include "netlink.h"
+#include "peer.h"
+
+static void unlock_ovpn(struct ovpn_priv *ovpn,
+			struct llist_head *release_list)
+	__releases(&ovpn->lock)
+{
+	struct ovpn_peer *peer;
+
+	spin_unlock_bh(&ovpn->lock);
+
+	llist_for_each_entry(peer, release_list->first, release_entry)
+		ovpn_peer_put(peer);
+}
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
+	netdev_hold(ovpn->dev, &peer->dev_tracker, GFP_KERNEL);
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
+	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
+	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
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
+			     enum ovpn_del_peer_reason reason,
+			     struct llist_head *release_list)
+{
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_P2P:
+		/* prevent double remove */
+		if (peer != rcu_access_pointer(peer->ovpn->peer))
+			return;
+
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
+	/* append to provided list for later socket release and ref drop */
+	llist_add(&peer->release_entry, release_list);
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
+	LLIST_HEAD(release_list);
+	struct ovpn_peer *tmp;
+
+	spin_lock_bh(&ovpn->lock);
+	/* in p2p mode it is possible to have a single peer only, therefore the
+	 * old one is released and substituted by the new one
+	 */
+	tmp = rcu_dereference_protected(ovpn->peer,
+					lockdep_is_held(&ovpn->lock));
+	if (tmp)
+		ovpn_peer_remove(tmp, OVPN_DEL_PEER_REASON_TEARDOWN,
+				 &release_list);
+
+	rcu_assign_pointer(ovpn->peer, peer);
+	/* in P2P mode the carrier is switched on when the peer is added */
+	netif_carrier_on(ovpn->dev);
+	unlock_ovpn(ovpn, &release_list);
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
+ * @release_list: list where delete peer should be appended
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason,
+			     struct llist_head *release_list)
+{
+	struct ovpn_peer *tmp;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	tmp = rcu_dereference_protected(peer->ovpn->peer,
+					lockdep_is_held(&peer->ovpn->lock));
+	if (tmp != peer)
+		return -ENOENT;
+
+	ovpn_peer_remove(peer, reason, release_list);
+
+	return 0;
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
+	LLIST_HEAD(release_list);
+	int ret = -EOPNOTSUPP;
+
+	spin_lock_bh(&peer->ovpn->lock);
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_P2P:
+		ret = ovpn_peer_del_p2p(peer, reason, &release_list);
+		break;
+	default:
+		break;
+	}
+	unlock_ovpn(peer->ovpn, &release_list);
+
+	return ret;
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
+	LLIST_HEAD(release_list);
+	struct ovpn_peer *peer;
+
+	spin_lock_bh(&ovpn->lock);
+	peer = rcu_dereference_protected(ovpn->peer,
+					 lockdep_is_held(&ovpn->lock));
+	if (peer)
+		ovpn_peer_remove(peer, reason, &release_list);
+	unlock_ovpn(ovpn, &release_list);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
new file mode 100644
index 0000000000000000000000000000000000000000..fd2e7625990a73f61bf5bb4c051929828d9996bd
--- /dev/null
+++ b/drivers/net/ovpn/peer.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
+ * @dev_tracker: reference tracker for associated dev
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
+ * @release_entry: entry for the socket release list
+ */
+struct ovpn_peer {
+	struct ovpn_priv *ovpn;
+	netdevice_tracker dev_tracker;
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
+	struct llist_node release_entry;
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
2.48.1


