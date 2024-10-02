Return-Path: <linux-kselftest+bounces-18874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58B98CF89
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D99B2459B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4419CC33;
	Wed,  2 Oct 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="S1wD9WtV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6E199EA2
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859810; cv=none; b=Q3DJ7HANbetvV97k5yDV/8b3e/iIDnmo+mo+6JOPKiPYTHvUUqFp/K/e6axfEhc59zLwQ52oGYhQF+v8/V57WmO1GDKT+SYu2DmkZ0JnMzBMHR+Yr5aeymvRZEdBKKqjAdr5yiZ0LfY2yRXUcpKWk23gFqUfACCRKwUjQE7KNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859810; c=relaxed/simple;
	bh=Gu3ELoUvxUytdBW/KmHoQAlc2H7Ar7o+VA1yPiLFG88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KspD9Vrk3L16liAx3Q6/h9Tf9AKnGgV3BEB8hPKJ+IK6oD3NVwsu7qzzWAdVLSlfY0jU/uV+LE5iDqlb0j+WlL3t52WT5/NtNbGqUX1kOStph2EsPdHLdk12gTo8OtGGCC0HeZ2l+bMzGUkUChHyt8rJaZ+Hk5rMRmNwhy2jCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=S1wD9WtV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd8972738so3250764f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859806; x=1728464606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+nXpvfUj++PdGKmuzvTa3CLwJjHC/iystct+ibzPbk=;
        b=S1wD9WtV6MI+9cy5VDIqNxBmUVrMFX5hw8yCFu+sPYv5lovAU5uxpbtdFLae0IdUPj
         qrBDrYcRZRKIxMmdRQyIABGEeFsL7upKX7YiHDWUCsF7rhc4DqgwsPjIDt7zJlYOVzOZ
         b4wAbQcpNOvdJUtk3b3mR4iu4lhwG/qreze2/iV3pJkMXfaOB0zeWwV2V9iNg/CPAM4B
         Iv6K70EX7sCFbNHK110o+qxHr7PbOZaduGkzn6Wioje2Ph30K8WyUPES8npGgQ8dl1gO
         X3+cKjodoB4CI0zuU6JItk7lMY+OZ8Iwc1vQtlgc7GNe9l26JsIQgyZevbxFDtRLTifB
         mfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859806; x=1728464606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+nXpvfUj++PdGKmuzvTa3CLwJjHC/iystct+ibzPbk=;
        b=j9INFOgBu845PQgnGZgUzAiP25RDIIGw64UitSwyhhnEDDssBgOvpXNBt7vSf2wHxL
         eN3WohMKdxgeqcxwrHCKlksB2uNIMu66QtsDeuu6tvFexVBXnQL1Yn8NLGoLOFYRNoG4
         s2ekOYD2EhT49oPT+IpsPoU+rrZ5dxSKoFrImy3zJ5MICG5OQ8ZyqnJM2QfYmCaGh2SA
         /K0wsjRSdvIACgsL3+tLUaU9vuYNS4F2oTe2LZd3ML0DVJ2psh6AV1gxE2B7dCflZgZH
         OajZ1EIVCxRi/YS8zYqEC03cJ3G212B94SBySoD7wrc+qhcXpdy7RqLrYTEphBiVFoyG
         uhTw==
X-Forwarded-Encrypted: i=1; AJvYcCVsNrpUatiU9RtN/WUIL9tPurQP0WHKVDrL7eEPuUuNBy0KO3Vdz+gvQQnu8JPrwl93V2qfJ+Y7KIT5YwL7a8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLXs9G4G8onO3CCdHg1ps6xX6FysxCV/hvV5w0OvkAG8BLnLm
	YqImBl6y5kML7Lp8xx2/bT53PycSaPa4Rgz1EzAom5Rhex+cFZlwgQB9je0W11o=
X-Google-Smtp-Source: AGHT+IGTpfhbWKt7SH/mhNmefN2HhTMqdsgEIms5bMzmhC50E55QSolfMNeQcN5z4nACPtnDdCubpg==
X-Received: by 2002:a05:6000:4616:b0:37c:d21a:3d61 with SMTP id ffacd0b85a97d-37cfba0a3e4mr1964248f8f.39.1727859805628;
        Wed, 02 Oct 2024 02:03:25 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:21 +0200
Subject: [PATCH net-next v8 07/24] ovpn: introduce the ovpn_peer object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-7-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21963; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Gu3ELoUvxUytdBW/KmHoQAlc2H7Ar7o+VA1yPiLFG88=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxRDOqDunpfA4ZzT4hBYMCMS2X8QMJAlz/Fk
 cXMs/fkaeiJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUQAKCRALcOU6oDjV
 h6s4B/9H7DapensA4wN7ABsXdt6YWwf+MPMZhGHivui3FWXWKWdY/iU35XcIyw5jEgh+CHQ7qZu
 Lqf1+Bbqi4Lo2tqiGRgHH58n0z1NsLYNMqIjXy47Lox3zwIVr2eLYTMPNvGDVO3kbCh1BZ3tNWv
 vmfqTUsJ4uc+FHH7OW4zbFqLPM5uMVpcnjUwGeHD7L66Zh+qdTPHjg8o6YXA8sTLaMh2XMGTrlr
 RFaSDD4cDxF+pHLgikwqCgjan8HoSzllT9ld2RdE80RDaQSKnGsuLNa0ROG5k97pb5ia0tN6IYg
 M5tbq5FkBiLio1HHDytKKZz33f5KK1WvBTt2WtcX1he2WFTf
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
 drivers/net/ovpn/Makefile     |   2 +
 drivers/net/ovpn/bind.c       |  58 +++++++
 drivers/net/ovpn/bind.h       | 117 ++++++++++++++
 drivers/net/ovpn/main.c       |  12 ++
 drivers/net/ovpn/main.h       |   2 +
 drivers/net/ovpn/ovpnstruct.h |   7 +
 drivers/net/ovpn/peer.c       | 355 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  82 ++++++++++
 8 files changed, 635 insertions(+)

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
index 0000000000000000000000000000000000000000..859213d5040deb36c416eafcf5c6ab31c4d52c7a
--- /dev/null
+++ b/drivers/net/ovpn/bind.h
@@ -0,0 +1,117 @@
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
+ * skb_protocol_to_family - translate skb->protocol to AF_INET or AF_INET6
+ * @skb: the packet sk_buff to inspect
+ *
+ * Return: AF_INET, AF_INET6 or 0 in case of unknown protocol
+ */
+static inline unsigned short skb_protocol_to_family(const struct sk_buff *skb)
+{
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return AF_INET;
+	case htons(ETH_P_IPV6):
+		return AF_INET6;
+	default:
+		return 0;
+	}
+}
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
+	const unsigned short family = skb_protocol_to_family(skb);
+	const union ovpn_sockaddr *remote;
+
+	if (unlikely(!bind))
+		return false;
+
+	remote = &bind->remote;
+
+	if (unlikely(remote->in4.sin_family != family))
+		return false;
+
+	switch (family) {
+	case AF_INET:
+		if (unlikely(remote->in4.sin_addr.s_addr != ip_hdr(skb)->saddr))
+			return false;
+
+		if (unlikely(remote->in4.sin_port != udp_hdr(skb)->source))
+			return false;
+		break;
+	case AF_INET6:
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
index 87d49b83107aa9c276c5b200ac919965379c99be..4522f2f8978614c96d529f807bd2cf32a44f8216 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
+//#include <linux/rcupdate.h>
 #include <linux/version.h>
 #include <net/ip.h>
 #include <net/rtnetlink.h>
@@ -22,6 +23,7 @@
 #include "netlink.h"
 #include "io.h"
 #include "packet.h"
+#include "peer.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
@@ -38,12 +40,18 @@ static void ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
 
 	ovpn->dev = dev;
 	ovpn->mode = mode;
+	spin_lock_init(&ovpn->lock);
 }
 
 static void ovpn_struct_free(struct net_device *net)
 {
 }
 
+static int ovpn_net_init(struct net_device *dev)
+{
+	return 0;
+}
+
 static int ovpn_net_open(struct net_device *dev)
 {
 	/* ovpn keeps the carrier always on to avoid losing IP or route
@@ -64,6 +72,7 @@ static int ovpn_net_stop(struct net_device *dev)
 }
 
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_init		= ovpn_net_init,
 	.ndo_open		= ovpn_net_open,
 	.ndo_stop		= ovpn_net_stop,
 	.ndo_start_xmit		= ovpn_net_xmit,
@@ -184,6 +193,9 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 	netif_carrier_off(ovpn->dev);
 
 	ovpn->registered = false;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		ovpn_peer_release_p2p(ovpn);
 }
 
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index c664d9c655734263fcf58dd8f2fa5446565a29cf..7e957248af6ab44ad8555318c74cc94be99844ab 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -24,4 +24,6 @@ bool ovpn_dev_is_valid(const struct net_device *dev);
 #define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
 #define OVPN_MAX_PADDING 16
 
+#define OVPN_QUEUE_LEN 1024
+
 #endif /* _NET_OVPN_MAIN_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index ee05b8a2c61d7c5887e80c7f79e15a1336d99644..25f4837b798b1a2c9b11763dfb5b44e8ec337e6f 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,19 +10,26 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <net/net_trackers.h>
 #include <uapi/linux/ovpn.h>
 
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
+ * @dev_tracker: reference tracker for associated dev
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @lock: protect this object
+ * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  */
 struct ovpn_struct {
 	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	bool registered;
 	enum ovpn_mode mode;
+	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 };
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
new file mode 100644
index 0000000000000000000000000000000000000000..23ded79eb7748a10b683d9aaa351b361ae79847e
--- /dev/null
+++ b/drivers/net/ovpn/peer.c
@@ -0,0 +1,355 @@
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
+#include <linux/workqueue.h>
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
+struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
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
+	peer->halt = false;
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
+		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n",
+			   __func__);
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
+ * ovpn_peer_release - release peer private members
+ * @peer: the peer to release
+ */
+static void ovpn_peer_release(struct ovpn_peer *peer)
+{
+	ovpn_bind_reset(peer, NULL);
+
+	dst_cache_destroy(&peer->dst_cache);
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
+	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
+	kfree_rcu(peer, rcu);
+}
+
+/**
+ * ovpn_peer_skb_to_sockaddr - fill sockaddr with skb source address
+ * @skb: the packet to extract data from
+ * @ss: the sockaddr to fill
+ *
+ * Return: true on success or false otherwise
+ */
+static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
+				      struct sockaddr_storage *ss)
+{
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+
+	ss->ss_family = skb_protocol_to_family(skb);
+	switch (ss->ss_family) {
+	case AF_INET:
+		sa4 = (struct sockaddr_in *)ss;
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa4->sin_port = udp_hdr(skb)->source;
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
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
+ovpn_peer_get_by_transp_addr_p2p(struct ovpn_struct *ovpn,
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
+struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
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
+static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
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
+struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
+{
+	struct ovpn_peer *peer = NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
+{
+	struct ovpn_peer *tmp;
+
+	spin_lock_bh(&ovpn->lock);
+	/* in p2p mode it is possible to have a single peer only, therefore the
+	 * old one is released and substituted by the new one
+	 */
+	tmp = rcu_dereference_protected(ovpn->peer,
+					lockdep_is_held(&ovpn->lock));
+	if (tmp) {
+		tmp->delete_reason = OVPN_DEL_PEER_REASON_TEARDOWN;
+		ovpn_peer_put(tmp);
+	}
+
+	rcu_assign_pointer(ovpn->peer, peer);
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
+int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
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
+	__must_hold(&peer->ovpn->lock)
+{
+	struct ovpn_peer *tmp;
+
+	tmp = rcu_dereference_protected(peer->ovpn->peer,
+					lockdep_is_held(&peer->ovpn->lock));
+	if (tmp != peer) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		if (tmp)
+			ovpn_peer_put(tmp);
+
+		return -ENOENT;
+	}
+
+	tmp->delete_reason = reason;
+	RCU_INIT_POINTER(peer->ovpn->peer, NULL);
+	ovpn_peer_put(tmp);
+
+	return 0;
+}
+
+/**
+ * ovpn_peer_release_p2p - release peer upon P2P device teardown
+ * @ovpn: the instance being torn down
+ */
+void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
+{
+	struct ovpn_peer *tmp;
+
+	spin_lock_bh(&ovpn->lock);
+	tmp = rcu_dereference_protected(ovpn->peer,
+					lockdep_is_held(&ovpn->lock));
+	if (tmp)
+		ovpn_peer_del_p2p(tmp, OVPN_DEL_PEER_REASON_TEARDOWN);
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
index 0000000000000000000000000000000000000000..6c51959363c78f22e5bbeecbfe65dc90c67e86cc
--- /dev/null
+++ b/drivers/net/ovpn/peer.h
@@ -0,0 +1,82 @@
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
+#include "bind.h"
+
+#include <net/dst_cache.h>
+#include <uapi/linux/ovpn.h>
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
+ * @halt: true if ovpn_peer_mark_delete was called
+ * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
+ * @lock: protects binding to peer (bind)
+ * @refcount: reference counter
+ * @rcu: used to free peer in an RCU safe way
+ * @delete_work: deferred cleanup work, used to notify userspace
+ */
+struct ovpn_peer {
+	struct ovpn_struct *ovpn;
+	u32 id;
+	struct {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} vpn_addrs;
+	struct dst_cache dst_cache;
+	struct ovpn_bind __rcu *bind;
+	bool halt;
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
+struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
+int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
+
+struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
+					       struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
+
+#endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


