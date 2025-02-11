Return-Path: <linux-kselftest+bounces-26295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15DA2FF6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99A4167DC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492C1EA7F6;
	Tue, 11 Feb 2025 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YR9R4QrQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B81E7C3B
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234485; cv=none; b=U+TnSuX3Jl2n8fM5bz10CXDuzLP/Ry01DjigamZyHFGUvZwEPIrPMTXDTM67jiMPxdfZfat9nIifGhPjFkH5dynvmEAjgrRs2/EOB0w3RaDImqp0J2Meu0lGm7TXfZee3K56WWlG8+FT+zMxv44dAPqmlAGAL1G2f2ZfS5NWN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234485; c=relaxed/simple;
	bh=5AX8LSjWm50tpBU3WO/SeiVZBROcriPPCqEfB8AV5Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOfe3YBBVVO+Me5VMwpPQ/JzQa4GHR4/+EY5vgBdPsnbCkmvs1kR2HotEAHlo4kadvOUopEQR/srKK+eBNgEdAxlFb6NDLiMnELefz4nYeJnaTwqUHGOgzJL7TudgjUOaTeba6G0YRt9NN6R9PvNfjjlPceeCSgJMRcOV+yP3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YR9R4QrQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so11865385e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234480; x=1739839280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upZMoieJlKu0UcZPVZkgU794HDIvtqWllXvalzxHnJM=;
        b=YR9R4QrQSfFwLZzjx78jiiKICjXVxwkpTgniPo6xiBPyT1/iKJOD72pMGzmvksBaF+
         +2FVVr9jtkoAM85C2crc0dhS6a/ljhHX+iOqZuTM3+78kaX2Eo9sg87JSYLt5tvDnuQJ
         S/edkPsjRYEa++VDIuO967AQpDnCDHGqmWGqHD7CzDFUnQ7tksdGz+feTda9bvX+C1Bg
         LvEDcGcKrT+gwHpvt5chq3wbsh/PKPRwVyh5Bv8ud7GYPD8m/y9GJoryMxhzZWCyhUe6
         RRYBL2ut77u+vlRvm35cPf3KAVjLRPSie4deYr7IgWXUHvY/qAiJVTRcuauspmoCX38v
         9z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234480; x=1739839280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upZMoieJlKu0UcZPVZkgU794HDIvtqWllXvalzxHnJM=;
        b=PczI3DXNayRZ8YANCsy6VDgQtcrJk08gbSXQ85p+q6eJCJ2CHbxFJWc03RwnPWG+z3
         llfNni7q45Zm1bdA9NaTA1iS+AwAcxbyGeBRyOm31Xw++mmhS6FDmwX3gPvgAiuSoE8H
         gDhOZOUcNqGC1KJqCaGfjBxSe4tvRduvVmnJCtM2HXD35QCaeku34ZeUHuwONH29SxOG
         eYYcSfXqMj8ka8Pdf/kq1AUXqkClVEhgn5EGomECd7pjUWllcOzvwsKRVWNH4kb0DHq8
         AG15GWZ+H7p4nDcN3DgXe6oaf64P+Pf1qRbFhm2lrf9CZAwHFVzoiRewtNMVTWY6ChDa
         fwOg==
X-Forwarded-Encrypted: i=1; AJvYcCUs7JjwZ7M6kebXyExYvmMeEF5wWM2PiDj9LnuMOzIbicX2jySeZyBks887L6VRmBzM1mw9fXEEStNpcYM7hRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkEhgTVaNo+AjZtxlC9ZWX8aoM1wcI8T+kN/KajwbhE47r1v9
	yXFRqw5Yc2DPyHFc9lqkOB6p+kz+bnS0XN/45O6leS70l0zw8hGxE1vcvggwmUQ=
X-Gm-Gg: ASbGnct9vPEeRBCoFhsQuP2VQOIbkRXiL31qp1w6bPZpwCN8IjVKP4ggBXj43y7FE3N
	zcr8X2Y7oteImy0/Fqdv5qG3OqJp0cDStAi0NUrFFs96VsE/w0zD5r7NLLfMhAeg7bHC1AHMcgd
	QutxUENvUW5uHBRiO8NYnVjXVmL+k0hCi+GlgtC9cQs6rEOVCyKHiOtpLbsN/+vDOyUOLTUlilS
	ah6PQZQtfhhNsWXaOmFRdd1RFeAp89tEHpbrBQ58V4nLYDebGoW//jj9Dz0ohQqQ94lbORVOZJY
	d4kujTxkUhSCw5XcQt/l+CYwmuM=
X-Google-Smtp-Source: AGHT+IGJhIJfSfO8wh2eSXtimNYXJ0BC6W7SiKUbkh9CdF5441F+2BBojPFxzRVR149BTXRuN8MhYw==
X-Received: by 2002:a05:600c:1f09:b0:439:4d37:7f49 with SMTP id 5b1f17b1804b1-4394d37819emr6576255e9.28.1739234479766;
        Mon, 10 Feb 2025 16:41:19 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:19 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:08 +0100
Subject: [PATCH net-next v19 15/26] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-15-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12669; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5AX8LSjWm50tpBU3WO/SeiVZBROcriPPCqEfB8AV5Oc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyNEde/QdLmRlFh5Herxy1kb4+IPULBgkD3G
 +0BMCqkvleJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 h1GDB/9D2CM+vESMzyzcjijpDpxUCncuQTqrBNW9aGuFKMD3WFinC+BofP8d2cK6jOvuPnnP8c9
 AtKr7Pgfa0ZfvrXpcxcpVdrdoI5SRbz833WbH2j1nUTXXB3sHdsRKspN63VR/qVdPZCmvgRBPBO
 4TdNq0HRP4NEYHm8PalZb8wt7jXVuR5C81i0TlnWCvx0fXqYeHbBHzVghkRh0sFE31rtIiIdzXr
 z9veM8ePDbzg0ZjD+41YO4QYb0kevzhjxVbb3jpSyWKnAl3MN+9YjSoY3f91WizzoA+ph+uk7oz
 ckhXSzYeGpC56/LnsYfZvJDqNgx4q7Azl+U4D2k+vhHgcl7Y
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c     |  67 ++++++++++++++++++-
 drivers/net/ovpn/ovpnpriv.h |  19 ++++++
 drivers/net/ovpn/peer.c     | 158 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h     |   9 +++
 4 files changed, 244 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2190926ce37dedb0877a4db1d482b7dafc405df2..28f83995677cd0d306ac1843fa8f4a68ebbf303e 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -24,11 +24,66 @@
 #include "proto.h"
 #include "tcp.h"
 
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
+
+	if (err < 0)
+		return err;
 
-	return gro_cells_init(&ovpn->gro_cells, dev);
+	err = ovpn_mp_alloc(ovpn);
+	if (err < 0) {
+		gro_cells_destroy(&ovpn->gro_cells);
+		return err;
+	}
+
+	return 0;
 }
 
 static void ovpn_net_uninit(struct net_device *dev)
@@ -99,6 +154,8 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->netdev_ops = &ovpn_netdev_ops;
 
+	dev->priv_destructor = ovpn_priv_free;
+
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
@@ -195,9 +252,15 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		netif_carrier_off(dev);
 		ovpn->registered = false;
 
-		if (ovpn->mode == OVPN_MODE_P2P)
+		switch (ovpn->mode) {
+		case OVPN_MODE_P2P:
 			ovpn_peer_release_p2p(ovpn,
 					      OVPN_DEL_PEER_REASON_TEARDOWN);
+			break;
+		case OVPN_MODE_MP:
+			ovpn_peers_free(ovpn, OVPN_DEL_PEER_REASON_TEARDOWN);
+			break;
+		}
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index f6636cf4c287928ec005c94ad011f978b609069e..bb6eed5095d921b178f0c702af0d8b9e710e4140 100644
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
index 2e69b098d53bd8c2e549b712530d746f5125cff0..ede0e2afc05b22882e1720aa44cdacb44a42bcf4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnpriv.h"
 #include "bind.h"
@@ -279,7 +280,15 @@ static void ovpn_peer_remove_work(struct work_struct *work)
 static void ovpn_peer_remove(struct ovpn_peer *peer,
 			     enum ovpn_del_peer_reason reason)
 {
+	lockdep_assert_held(&peer->ovpn->lock);
+
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		hlist_del_init_rcu(&peer->hash_entry_id);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		break;
 	case OVPN_MODE_P2P:
 		RCU_INIT_POINTER(peer->ovpn->peer, NULL);
 		/* in P2P mode the carrier is switched off when the peer is
@@ -287,8 +296,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 		 */
 		netif_carrier_off(peer->ovpn->dev);
 		break;
-	default:
-		return;
 	}
 
 	peer->delete_reason = reason;
@@ -352,6 +359,89 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
@@ -392,11 +482,40 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
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
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_mp(struct ovpn_peer *peer,
+			    enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp == peer) {
+		ovpn_peer_remove(peer, reason);
+		ret = 0;
+	}
+
+	if (tmp)
+		ovpn_peer_put(tmp);
+
+	return ret;
 }
 
 /**
@@ -450,10 +569,35 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
  */
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 {
+	int ret = -EOPNOTSUPP;
+
+	spin_lock_bh(&peer->ovpn->lock);
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		ret = ovpn_peer_del_mp(peer, reason);
+		break;
 	case OVPN_MODE_P2P:
-		return ovpn_peer_del_p2p(peer, reason);
-	default:
-		return -EOPNOTSUPP;
+		ret = ovpn_peer_del_p2p(peer, reason);
+		break;
 	}
+	spin_unlock_bh(&peer->ovpn->lock);
+	return ret;
+}
+
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ * @reason: the reason for releasing all peers
+ */
+void ovpn_peers_free(struct ovpn_priv *ovpn,
+		     enum ovpn_del_peer_reason reason)
+{
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id)
+		ovpn_peer_remove(peer, reason);
+	spin_unlock_bh(&ovpn->lock);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 5b0fc94522ff1915ec3ed1f1f3564e58cdaac971..fdfa3f4153978ca94006dabb8feb7556f3bb6680 100644
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
@@ -117,6 +125,7 @@ int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
 			   enum ovpn_del_peer_reason reason);
+void ovpn_peers_free(struct ovpn_priv *ovpn, enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);

-- 
2.45.3


