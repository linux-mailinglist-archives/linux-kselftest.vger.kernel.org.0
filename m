Return-Path: <linux-kselftest+bounces-29311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753FA66559
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06A6189EA9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294661A9B52;
	Tue, 18 Mar 2025 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Tnk7cuey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6961917F1
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262073; cv=none; b=LgOOoqWPivqFMWCIdnB2XZlbOwscushyqLf7Xbdye2eK8EEkZ/UAykmzEnqkMi93kdVlWbH3Y/aCihXSBLn1WMPROew96wPAXLtTIEmjSHn39CluJIX2BdRQfNsH5zUFBFGt6rJQNq5uGAXOKByvvW2w1PUFpR/Da859MGBU9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262073; c=relaxed/simple;
	bh=HdOx37hJI0+NcNGy7kyfLsCrP6Nsi1mjmQ4ZuNXX7wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qU6t4cYs67V65Bvb+4Xm39ma7RRGVTo3iAqOOWK6H3s9KrG/rqbkyVXZ1Uw5iOxbEw6a68WA0C2I/sEX+H2BSZPUNOuIqqcdLtPRm6if/acOFpxH3I9nf2L2GBbfoD1uDrqzSgxF7y/v6WGpMeXYxHpUD5/d4QA0hrMKnkwSMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Tnk7cuey; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so16049165e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262068; x=1742866868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMm5Ixy1RI8QzormMjNTkkh0n4rwT9XW+0TmmGZRwLs=;
        b=Tnk7cueynGlulQJZCfP001BTwqEZTstZ7MF4UmoHKCjRTfZEX1lrEjQrD9kRXDFI+D
         OrMhOYS3FJyEG3qRnEy+8DT3pP8Df975EWj/4PoX8FfiOoOb51Vv9IvzqC9yFt0AX6cx
         0zoSq/H7GypPq6T/NvoneEUZk3kg/4eNFddritz1XuPtGcIGOphHGtEsO82A9/mB7RF7
         GN6VbKrmwXN3LO0MGudk59QMQA7tqX1MpUO1iMMHlX0ZtcxTd0ziKlln5YosLT5iWtMb
         ujIZmqbIfZj/F8cFaqYUQkw/q0V8Z83QO5ruxKbmlkJVTlkI3QycQWdbdDT3FUzjlhC5
         BGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262068; x=1742866868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMm5Ixy1RI8QzormMjNTkkh0n4rwT9XW+0TmmGZRwLs=;
        b=Dcyu1Ibu1zCBb+Lo2Apx2/iTqplb+02pDrZ3ym5im1SwwnnxxAzNmuXIIqZRs/dV6Q
         DKPYL1PvKAYzlmk91Zju04QDb7xDeg6RhpKCrBE8NJA/4t3N1h6+RyWtK79c9Sq4j5AM
         c+EgreOlvCfvd9Jp7sCHkiwMN/34jhT/sYbmAm1Q8UuuveLJbGdn83Hg3gnccmeYjbln
         B5EyEYbRYJ65jTSL7WGaHrKON5EU30XiF0hHn/PvcFvmgo94dbjBzcrN8g5W3J2pR0o+
         eP1DUlkdnhq45YcZ8qZlMyAuIV96nyJP379Kx1wNSodILyA2ikYaBy4nDJmA/gt735jV
         xWRA==
X-Forwarded-Encrypted: i=1; AJvYcCWP10/+K3olfGkKuOvG7lfgI/ZA8O96uPw3uSkvUaLdRVDdNZFKy200w9BDFlFWDoCc+zexjew5DfOhTjoE1q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRNyxQWbsOsoONTe3OHjkT7WRHp1cM5EPVlHZHuUOtl0Bydwq
	7SQVYSaV2ozieoj1DngizwEc3wXKs+/xiHIF6CAMDtU77EI4IikGnBIFzPIvVv3eQVG+loxk70e
	Su5k6z7UuidAgNQgqQEwqozQ+N5JyPLwpibhV7lg+ixWY2b/p8+9ty5zd1/k=
X-Gm-Gg: ASbGncuqsXony/0gcpdGFXP34PxJq7HpYE0BVMhjXlgIi+/S/xsqRWYnMwnkiALGHa8
	zKmNQJXkuHe4xVk/Xcu/hEmxKL6NZbx8h6ZI+Om8ULtL7W9vOE5Q+3C/DHM84I2CJ72gNN0BrnC
	Z1S39MITpSmOPmmQkk1hJSpErTlUQAHRc6QJVaQabVv7ugLCz8aBsvHHv8rpiLbyLG1ANiz5lbS
	o7Ol2Sz4c4j/re0Cl1TyRo7TMMEK0sZCLut2pGx2P52wHXYcE9lmqpGMQ53Pf3HJW8Xee308f6E
	o6KU8vdf6nkdt/vTGDdhqr758fEwLfKftvQMWWVHJg==
X-Google-Smtp-Source: AGHT+IHxeXkFIk7/AEQiWqIn4PR94kaayR5szqM6wnFe7CpSjO93oJvmwR5SYE6wYmB2AlqNLPPCkw==
X-Received: by 2002:a05:600c:198a:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43d3bcbec7dmr1848375e9.12.1742262067729;
        Mon, 17 Mar 2025 18:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:06 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:40 +0100
Subject: [PATCH net-next v24 05/23] ovpn: introduce the ovpn_peer object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-5-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22731; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=HdOx37hJI0+NcNGy7kyfLsCrP6Nsi1mjmQ4ZuNXX7wo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8p2IEmvGPGulpGO9dcbnp698aTbUzGLlpYE
 HECNwN3kPCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKQAKCRALcOU6oDjV
 h/RZB/9e6PZYKND2JLWrSQFk90MjHOBxooleWHJ7cTFubnDq8JCFhJYlZmB0Y3SrhpCYvz4TX+0
 18VU/KcVwUraGS5fE44ok9LCyMyTA2+MuWAAMjBr6FozQfzvyRJcO7oVPiCNyYTC21eW+CMVtYp
 YA7U/ayl97gwg9HyR6/9GkCC1SwpIigcXvyLKHoP0cgvsb0Ap/Ff7u7hVD00CmLQsc2jufKuZYO
 FlznoFN1J+Su/X0HRCZLOFdYX+SLruqL1i+MGpQM7fOyhB+z/FPuZT8r2molq066jvol3kJlh9X
 +i9D5kaa78ldI3h4e8pPsnTk5ltEceb5R6Y3KwhvkpZYLtQg
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
index 15802dfd26fcbcad42c387d42f665b8b47604e8a..49e39ca11310e6f583ce44371202f14859a2a1b9 100644
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
@@ -36,6 +42,7 @@ static int ovpn_net_open(struct net_device *dev)
 }
 
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_init		= ovpn_net_init,
 	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
@@ -107,6 +114,7 @@ static int ovpn_newlink(struct net_device *dev,
 
 	ovpn->dev = dev;
 	ovpn->mode = mode;
+	spin_lock_init(&ovpn->lock);
 
 	/* turn carrier explicitly off after registration, this way state is
 	 * clearly defined
@@ -166,6 +174,10 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 
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


