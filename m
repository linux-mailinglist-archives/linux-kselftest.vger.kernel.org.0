Return-Path: <linux-kselftest+bounces-30294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDFA7EE16
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCBA3BDC2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AA2550CF;
	Mon,  7 Apr 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fSP64EP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FF25486C
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055253; cv=none; b=XZks7xBEyT2xwDwRo02sw04GWoDRqLQq8IAWuKByrfAWctRAfPo3j27X/R6BZ0QJbuNt6Ir2aj5aK8MUdPx0m3UA61Q/xHcnM6Hu624q2cxD3to268LHECPgbi6HtBPrxsZyU4yLbAjcNNyF135ExMqHe0FfqOVqoFGtuOv9xFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055253; c=relaxed/simple;
	bh=rDn/n4pHcK8UhYpJyYhZfXDHSVUot90103YurjxW9Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umZXuHs9FCAASjuaJ6QlFWG/NsrBnd7awSWs6FEVZW941qEMADq9AqI/xiWkMhY/u+LdYePl1gyxTaMaj/MJ+yhpd1Sib5wV91qG55Io0KG8UCob43osjiTe6kdzi79Mb696LOVVaNCXW2EFfI415laDR9g9PcoCoB7RGa7VlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fSP64EP6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so44128075e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055248; x=1744660048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqRc6L6d22soUDQl56FfrpWTD7OgWZJe2Ww8SV60mSg=;
        b=fSP64EP6pX4SoyyHWFN0QJngwYMm4g4MNTsUFWztX2NMdQJ87QYE9R6agoVFWY8cHf
         RirfSRRCImBtgsxHIT+B3KNZwuDx3ME7Oe5B1d6ZZg7pWa5ST2x4Esj4hwRW2LsV0p+z
         T/Lt+wq9/Svo0x7/nIz0BaQyQbZTCNmvnsJgqyIq3dG2Ba0NxN0z0eB8xJX4wvu/kzRk
         Zf8COBvVLVIc2ZlpPk04v6i04ZK9/L5WNqp5oWQM3k2ftnN/sCou0wtX3ENxKO4pg/aW
         8N7o7+OuB3qBFURQnypqDwkVxi65KZWHn6iFcdHTnxzNKT/UTzCcaJeoJKZrJuBUrmd1
         Lm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055248; x=1744660048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqRc6L6d22soUDQl56FfrpWTD7OgWZJe2Ww8SV60mSg=;
        b=FZEI2BJ5tnpnGewQfyEak15Vu6KZV2a0BcT/A5p6933nOLpG8ucNMvEybaONyfH+zw
         Ej0j6EjQ/VQEDg13Vs4rOGkOZK8Vj8TMMefxMZqMfWqMrSVt3GGUPqr/fdnNBTRZik7Y
         2+FReD+R3gctA61x4mR1Yckws/xfpx+R1TqK6U0mMZetex/mgbw2W4DE66hXBCwbx6YU
         f2+kRnufdlEDgiRsl6OlQqMjTlulXgNh4dy07krxoJpBORx2DuRSJVPmBx3LunP4A0CQ
         pNrhKAQb04sddwjFitub3NAZXGAlioBhV4jUSp+7slwmWcFCgBC1glM+rQWo6EXGdWti
         GYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmaEq0zZYQKLQrhfO2fTPqvxBxUHLNS3sAHv0fQ32zcS+9o79ekTYqythzWgmFqw3WDcXHLEBqkfYEOoHPgfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzekvq+gfVd+1AdlssMNWNYXe8UFB2WlTK1c2y89eTlH85sTidt
	c1fgnuDcwrojLCqNHmqDHA/GL3FzUgwI7qe5pIP4wlyiwg2sjgDOwd8G1Y4dshjq5LxpE/Vm0Eq
	qA8We3stF3JCeata95Kigf8mMjYlOzYDttHRToNTWit7OxZJeVz3IAedyERU=
X-Gm-Gg: ASbGncsGUHrmV81VjfK71h74Odp1+2yzyhTSufstIhyqaqjPAzJGDeco8aPGs3yBWzZ
	41/wufrEDAWPVb6V8FzKPYYU0+WBAjy3oDJrXme8LM5gZcVOwG0R6Gm7X99JmZ6WjhY/5kniTk0
	mkOfoPl0LKWbwBluoeaPegJEnP0vn5ZjDgcSQXo87XzAVObF90moE9M+YwC/AQ4Kbnls9BA+3hq
	zuAN4Ep1+CJ7p0bhZr6yIlGkUtUtMfD8CZGTuqGcd2ZOGk7NZsupXMxS9NZrkEinSXn4ywHbRx/
	fGQAFcZ2HuhBmd4zTvDv9KQDDnClGadDSUQsU1yMk0YP/BnLjN03
X-Google-Smtp-Source: AGHT+IEZlSpoxvHRAEgGDmBx21FsER3atc1RFG3xOztfYQza4n3ipM/mUSiiTHrdWqY6q+tv/P2rdg==
X-Received: by 2002:a05:600c:3489:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-43ecf9c77ecmr109433705e9.21.1744055248399;
        Mon, 07 Apr 2025 12:47:28 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:22 +0200
Subject: [PATCH net-next v25 14/23] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-14-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14854; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=rDn/n4pHcK8UhYpJyYhZfXDHSVUot90103YurjxW9Vg=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOlftLcW+XoZzWyXud2ldfnLK6HJ3GZi/gF88+9JvT2St
 UBZctarTkZjFgZGDgZZMUWWmavv5Py4IvTkXvyBPzCDWJlApjBwcQrARKQKOBg2c7MyfS6L6xeY
 ErYmrecHV1nEHI/tuY5+Rle2KN5q8/rS7+abViu87JORwvT7RrpbFp1nsT75Ptv8aefrG/crZeR
 MT9nFf4zRmZLm/G/Kznny/71tA08sO2iZzL/KXUa39r5YzgLtlJrHb3VbTkUVtMvL+ybI+V8TeL
 Bz+5cj9zdUL9948W5LBv//Iv4LjxXnPuc2YGbaa7GJK6Enrq796PpQg9drctufLhc7Xqbs8UauV
 +ehcMULU1lRceeL2kE1H26qP/jyrjy27dI9UT5NvVupCea+m1zLnTLZqq/JCWeZes1htDhiX/Sg
 unvenDmWYu90Z6gq97kdWrWC79CsKvXKkI/xAvUeN6xcAQ==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c     |  64 +++++++++++++--
 drivers/net/ovpn/ovpnpriv.h |  19 +++++
 drivers/net/ovpn/peer.c     | 189 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h     |  12 ++-
 drivers/net/ovpn/udp.c      |   4 +-
 5 files changed, 272 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 948c36129914ca45fb7118b821c7c60359e600f6..1b3d5b6c839999202743a15f38029251bf102f45 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -25,11 +25,66 @@
 #include "tcp.h"
 #include "udp.h"
 
+static void ovpn_priv_free(struct net_device *net)
+{
+	struct ovpn_priv *ovpn = netdev_priv(net);
+
+	kfree(ovpn->peers);
+}
+
+static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
+{
+	struct in_device *dev_v4;
+	int i;
+
+	if (ovpn->mode != OVPN_MODE_MP)
+		return 0;
+
+	dev_v4 = __in_dev_get_rtnl(ovpn->dev);
+	if (dev_v4) {
+		/* disable redirects as Linux gets confused by ovpn
+		 * handling same-LAN routing.
+		 * This happens because a multipeer interface is used as
+		 * relay point between hosts in the same subnet, while
+		 * in a classic LAN this would not be needed because the
+		 * two hosts would be able to talk directly.
+		 */
+		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+		IPV4_DEVCONF_ALL(dev_net(ovpn->dev), SEND_REDIRECTS) = false;
+	}
+
+	/* the peer container is fairly large, therefore we allocate it only in
+	 * MP mode
+	 */
+	ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
+	if (!ovpn->peers)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
+		INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr4[i], i);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr6[i], i);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i], i);
+	}
+
+	return 0;
+}
+
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
+	int err = gro_cells_init(&ovpn->gro_cells, dev);
 
-	return gro_cells_init(&ovpn->gro_cells, dev);
+	if (err < 0)
+		return err;
+
+	err = ovpn_mp_alloc(ovpn);
+	if (err < 0) {
+		gro_cells_destroy(&ovpn->gro_cells);
+		return err;
+	}
+
+	return 0;
 }
 
 static void ovpn_net_uninit(struct net_device *dev)
@@ -91,6 +146,8 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->netdev_ops = &ovpn_netdev_ops;
 
+	dev->priv_destructor = ovpn_priv_free;
+
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
@@ -187,10 +244,7 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 
 		netif_carrier_off(dev);
 		ovpn->registered = false;
-
-		if (ovpn->mode == OVPN_MODE_P2P)
-			ovpn_peer_release_p2p(ovpn, NULL,
-					      OVPN_DEL_PEER_REASON_TEARDOWN);
+		ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 2e3f4baf305f0b37b474d7b7d94751aa4af8a2ea..b26ad97215a3d42242ba349b348c2749f570797c 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -15,12 +15,30 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_vpn_addr4: table of peers indexed by VPN IPv4 address (items can be
+ *		  rehashed on the fly due to peer IP change)
+ * @by_vpn_addr6: table of peers indexed by VPN IPv6 address (items can be
+ *		  rehashed on the fly due to peer IP change)
+ * @by_transp_addr: table of peers indexed by transport address (items can be
+ *		    rehashed on the fly due to peer IP change)
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	struct hlist_nulls_head by_vpn_addr4[1 << 12];
+	struct hlist_nulls_head by_vpn_addr6[1 << 12];
+	struct hlist_nulls_head by_transp_addr[1 << 12];
+};
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
  */
@@ -29,6 +47,7 @@ struct ovpn_priv {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 };
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 0fe5333c6b8104913526dacc4d7d2260b97f62aa..bed2e591c000c4efecdcd92db484e590f97f9f7f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnpriv.h"
 #include "bind.h"
@@ -280,7 +281,19 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 			     enum ovpn_del_peer_reason reason,
 			     struct llist_head *release_list)
 {
+	lockdep_assert_held(&peer->ovpn->lock);
+
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		/* prevent double remove */
+		if (hlist_unhashed(&peer->hash_entry_id))
+			return;
+
+		hlist_del_init_rcu(&peer->hash_entry_id);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		break;
 	case OVPN_MODE_P2P:
 		/* prevent double remove */
 		if (peer != rcu_access_pointer(peer->ovpn->peer))
@@ -292,8 +305,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 		 */
 		netif_carrier_off(peer->ovpn->dev);
 		break;
-	default:
-		return;
 	}
 
 	peer->delete_reason = reason;
@@ -357,6 +368,89 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
+
+/**
+ * ovpn_peer_add_mp - add peer to related tables in a MP instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
+{
+	struct sockaddr_storage sa = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+	struct ovpn_bind *bind;
+	struct ovpn_peer *tmp;
+	size_t salen;
+	int ret = 0;
+
+	spin_lock_bh(&ovpn->lock);
+	/* do not add duplicates */
+	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
+	if (tmp) {
+		ovpn_peer_put(tmp);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	bind = rcu_dereference_protected(peer->bind, true);
+	/* peers connected via TCP have bind == NULL */
+	if (bind) {
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			sa4 = (struct sockaddr_in *)&sa;
+
+			sa4->sin_family = AF_INET;
+			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
+			sa4->sin_port = bind->remote.in4.sin_port;
+			salen = sizeof(*sa4);
+			break;
+		case AF_INET6:
+			sa6 = (struct sockaddr_in6 *)&sa;
+
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = bind->remote.in6.sin6_addr;
+			sa6->sin6_port = bind->remote.in6.sin6_port;
+			salen = sizeof(*sa6);
+			break;
+		default:
+			ret = -EPROTONOSUPPORT;
+			goto out;
+		}
+
+		nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
+					   salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+	}
+
+	hlist_add_head_rcu(&peer->hash_entry_id,
+			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
+					      sizeof(peer->id)));
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr4,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr6,
+					   &peer->vpn_addrs.ipv6,
+					   sizeof(peer->vpn_addrs.ipv6));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
+	}
+out:
+	spin_unlock_bh(&ovpn->lock);
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -399,11 +493,42 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
-	default:
-		return -EOPNOTSUPP;
 	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ovpn_peer_del_mp - delete peer from related tables in a MP instance
+ * @peer: the peer to delete
+ * @reason: reason why the peer was deleted (sent to userspace)
+ * @release_list: list where delete peer should be appended
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_mp(struct ovpn_peer *peer,
+			    enum ovpn_del_peer_reason reason,
+			    struct llist_head *release_list)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp == peer) {
+		ovpn_peer_remove(peer, reason, release_list);
+		ret = 0;
+	}
+
+	if (tmp)
+		ovpn_peer_put(tmp);
+
+	return ret;
 }
 
 /**
@@ -446,6 +571,9 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 
 	spin_lock_bh(&peer->ovpn->lock);
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		ret = ovpn_peer_del_mp(peer, reason, &release_list);
+		break;
 	case OVPN_MODE_P2P:
 		ret = ovpn_peer_del_p2p(peer, reason, &release_list);
 		break;
@@ -463,8 +591,8 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
  * @sk: if not NULL, release peer only if it's using this specific socket
  * @reason: the reason for releasing the peer
  */
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
-			   enum ovpn_del_peer_reason reason)
+static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
+				  enum ovpn_del_peer_reason reason)
 {
 	struct ovpn_socket *ovpn_sock;
 	LLIST_HEAD(release_list);
@@ -490,3 +618,52 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 	ovpn_peer_remove(peer, reason, &release_list);
 	unlock_ovpn(ovpn, &release_list);
 }
+
+static void ovpn_peers_release_mp(struct ovpn_priv *ovpn, struct sock *sk,
+				  enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_socket *ovpn_sock;
+	LLIST_HEAD(release_list);
+	struct ovpn_peer *peer;
+	struct hlist_node *tmp;
+	int bkt;
+
+	spin_lock_bh(&ovpn->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
+		bool remove = true;
+
+		/* if a socket was passed as argument, skip all peers except
+		 * those using it
+		 */
+		if (sk) {
+			rcu_read_lock();
+			ovpn_sock = rcu_dereference(peer->sock);
+			remove = ovpn_sock && ovpn_sock->sock->sk == sk;
+			rcu_read_unlock();
+		}
+
+		if (remove)
+			ovpn_peer_remove(peer, reason, &release_list);
+	}
+	unlock_ovpn(ovpn, &release_list);
+}
+
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ * @sk: if not NULL, only peers using this socket are removed and the socket
+ *      is released immediately
+ * @reason: the reason for releasing all peers
+ */
+void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sk,
+		     enum ovpn_del_peer_reason reason)
+{
+	switch (ovpn->mode) {
+	case OVPN_MODE_P2P:
+		ovpn_peer_release_p2p(ovpn, sk, reason);
+		break;
+	case OVPN_MODE_MP:
+		ovpn_peers_release_mp(ovpn, sk, reason);
+		break;
+	}
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 5ef00ba6523d7bf6608adb86fa7c7029f559ce2a..2a3b1031f58dd73925a9ed74aed7ac4cb7b8c4c5 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -25,6 +25,10 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @hash_entry_id: entry in the peer ID hashtable
+ * @hash_entry_addr4: entry in the peer IPv4 hashtable
+ * @hash_entry_addr6: entry in the peer IPv6 hashtable
+ * @hash_entry_transp_addr: entry in the peer transport address hashtable
  * @sock: the socket being used to talk to this peer
  * @tcp: keeps track of TCP specific state
  * @tcp.strp: stream parser context (TCP only)
@@ -57,6 +61,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_nulls_node hash_entry_addr4;
+	struct hlist_nulls_node hash_entry_addr6;
+	struct hlist_nulls_node hash_entry_transp_addr;
 	struct ovpn_socket __rcu *sock;
 
 	struct {
@@ -117,8 +125,8 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
-			   enum ovpn_del_peer_reason reason);
+void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
+		     enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 9fdbf16b410ba4e09f78b8bfe581442ea90e5fa0..ca9021017eac5e3f0973ff6a93ebfe2c3320fbed 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -367,9 +367,7 @@ static void ovpn_udp_encap_destroy(struct sock *sk)
 	ovpn = sock->ovpn;
 	rcu_read_unlock();
 
-	if (ovpn->mode == OVPN_MODE_P2P)
-		ovpn_peer_release_p2p(ovpn, sk,
-				      OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	ovpn_peers_free(ovpn, sk, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
 }
 
 /**

-- 
2.49.0


