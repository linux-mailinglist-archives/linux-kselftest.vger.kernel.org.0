Return-Path: <linux-kselftest+bounces-24260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B0A09DF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF0188E73F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09710226174;
	Fri, 10 Jan 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MbgTRL9t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833C225764
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547995; cv=none; b=Jdj3cETHlaz1B1/ztZDgyBlFdg6+z4Y0UPlVh2gZROx/h3ulelLdCLoZcIWUV/HzCiDltPBBz2F3Q0b3hMt5kOKl0oePnemVItnEvcNdZo+3HERB3R4EBJjKo3AC9aV5okiydW5SKhTVGMYPiIB9RUyhR4n7Ir1hPkKYK0kuHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547995; c=relaxed/simple;
	bh=GV0uql+HUPnwpGrzLN7wDHsF1qSft7MQMfaGPcLLTCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNsVEhBU56DpaVeIJXllE+iIRcksX9cXF1ZAVVL2pPxHVUzCDvesnT4K3ZBZ68z4JypMWYnkrPmdguAxeX2t09ZdquwKmV1OerHaFimuCPC7rxKaBpX/KL9WkWws8asKMrB/0l3ewTvqOD/o7xEGFhXgcWm+kW2KPSNM6dhQxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MbgTRL9t; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38634c35129so1925291f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547990; x=1737152790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDb9tnvNRFBk4xTlm9riSHBY5zMNdG09YvBDP7sp4oM=;
        b=MbgTRL9tYo/3e79gO4arIzzdHdXvor6he/0M/fwtPWBCzqGeHvfu6LnFCZEvFMGSdp
         Ymg3qaoSiPKORs/WxzyXafP7WvkjLeqp4gE5/Hxsj0I/tBzdVM+0OfaswRR/jzVaNtx4
         lnoCFV+nzszJAk7Ps+ITNAOHYIIDNIMA75aLPbn1GCBDn5ThQrHJGI/Mjgbzq43quTjd
         b7+HRfBJvx3Se7sytAjvTji9NHX4ZcmA57OwmIK6qHokpYcvlxQ9zy2N1Oj66D9WsF79
         ExtzGzw/OMLvNZPgrWSQkBofdowNgpfSEo7w+s5ShMmbZgW3IYX4P+EefJ3TNa5BMzRH
         LjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547990; x=1737152790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDb9tnvNRFBk4xTlm9riSHBY5zMNdG09YvBDP7sp4oM=;
        b=GBELZ7vdyeqWHPgK03k/e4AQXh/Sipy7kPW8jTZABpXnquSUWGcM5Nk5MtdLtEVghW
         fJsyyZlRXeqe0a79TCjOYLadUiZSZBTCpT4dYj4074NUMSdo52aG6pxVzZScW9v+GM1t
         uidQ4sF1qEHPlxGy41y5XI03KHd4LWS1a5TMcD6AqNvThFUL5YKsk5y+fXHJ6j+/5B1w
         QDFEecJV4eBV1SEhthRexf3VCrAhQipWFwrEKkxoFy1ZSS1FEjCktO8U/B1qAns2kdgj
         5rD1qjJDa8uF01Fo5Jb6DKvzSfSg8jQoof5tUKmPBD50JXQOd1ZBv7Co2iZe1zwamK7T
         A8+g==
X-Forwarded-Encrypted: i=1; AJvYcCW+vK0uKk7LnUhUcOcOsK0IrNlsXpZx2UX8vJX8fYbUbAAh6eEqjUEulxa8ZbNL/hJcXLDY8jr7LHHggWcE0NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29PU3Uo3xNjNYSt+rHZPouaHw0FrU0fwzFBFYJ1vL7ytDqakg
	c08SGxKuCaigGhxIRDq7/gcyxRhIT5ZdaYa/RrqwY6ahZIpWOPRM5Vm2W/JAHNk=
X-Gm-Gg: ASbGncsQqvu4kwMAAJObLGEhJcMHJ3p2yiARPj1KX+RGMWq6Ryp2uzCLpjz3KIjSc9K
	/sjnK41efWYJBVHF8k6yTx4rUdf/dYklXMTclT79pilTjv3GFjmTpspN1OwqE3vyPRUJuthF9YR
	/KQpz8ZkuOHJibWFA9uyMaNjs/AHTlOxPQ91SNljavrMopX/+VdfeRjBVxawieYK9yay0nbDW9U
	FSDur0anS/DrDNZzQuft2otWTS7UcxeVSkAYGz590uyVZevpB4UpTLxW78n1pdGy4qe
X-Google-Smtp-Source: AGHT+IEMBTU8t6+pH2t2B5IBWZ3AkbU8bSw1G345q1BbDD6QFJs5aw3hfs9RXXMD0do/+atIrCcnag==
X-Received: by 2002:a05:6000:2a2:b0:38a:8906:6b66 with SMTP id ffacd0b85a97d-38a89066f45mr12273384f8f.38.1736547990427;
        Fri, 10 Jan 2025 14:26:30 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:30 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:31 +0100
Subject: [PATCH net-next v17 15/25] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-15-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13192; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=GV0uql+HUPnwpGrzLN7wDHsF1qSft7MQMfaGPcLLTCo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xia1RDwewz1qSj2aXqy2/LAYFnqOmDadSe
 N77J2FqYoqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h6mdB/0Q1MIzeeG4uIvI7hulyycrcMJ2sHrRVdnJmJaxraOPsyzblEalU4Wxrbkt93mMGKBcri9
 3aA6PykMt+1F9uhXnIQIa3Attzvw8gCo6wwWJrKcHmzUocbegWhnXqk/XqwQnkzH5Bcxt6qPfoK
 NyRqCi2dEeW5R/ExqkwXIuaHaX7f451VDOJLysVZgvEqLUmqlTv6VbXXGF3QJ4iG+Mll06dhnVl
 5QoYLkrrlBRQLk5Ad+l7YlTwjBNjfQKYgY1F7MVWsHBfqfCDmATEMHOfOzTNNQnSQbiCBZINwKn
 RL/xwDLluKH0mqIl/uSXFecWoY0B/MFe92Ml0Ja8b9QWwQu4
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c       |  67 +++++++++++++++++-
 drivers/net/ovpn/ovpnstruct.h |  16 +++++
 drivers/net/ovpn/peer.c       | 158 ++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h       |   9 +++
 4 files changed, 241 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0f291c540f8e05dbfbc15d835d6c71e796114b03..17cdd5a732132de71b854fe0b76c284bd9f3d918 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -24,6 +24,13 @@
 #include "proto.h"
 #include "tcp.h"
 
+static void ovpn_priv_free(struct net_device *net)
+{
+	struct ovpn_priv *ovpn = netdev_priv(net);
+
+	kfree(ovpn->peers);
+}
+
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
@@ -99,6 +106,8 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->netdev_ops = &ovpn_netdev_ops;
 
+	dev->priv_destructor = ovpn_priv_free;
+
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
@@ -120,12 +129,50 @@ static void ovpn_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
 }
 
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
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr[i], i);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i], i);
+	}
+
+	return 0;
+}
+
 static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	enum ovpn_mode mode = OVPN_MODE_P2P;
+	int err;
 
 	if (data && data[IFLA_OVPN_MODE]) {
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
@@ -136,6 +183,10 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
 
+	err = ovpn_mp_alloc(ovpn);
+	if (err < 0)
+		return err;
+
 	/* turn carrier explicitly off after registration, this way state is
 	 * clearly defined
 	 */
@@ -195,14 +246,26 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
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
 	case NETDEV_DOWN:
-		if (ovpn->mode == OVPN_MODE_P2P)
+		switch (ovpn->mode) {
+		case OVPN_MODE_P2P:
 			ovpn_peer_release_p2p(ovpn,
 					      OVPN_DEL_PEER_REASON_ADMINDOWN);
+			break;
+		case OVPN_MODE_MP:
+			ovpn_peers_free(ovpn, OVPN_DEL_PEER_REASON_ADMINDOWN);
+			break;
+		}
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index f6636cf4c287928ec005c94ad011f978b609069e..3ba01159afd237edf5941f3af194be8f292f37d9 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -15,12 +15,27 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_vpn_addr: table of peers indexed by VPN IP address (items can be
+ *		 rehashed on the fly due to peer IP change)
+ * @by_transp_addr: table of peers indexed by transport address (items can be
+ *		    rehashed on the fly due to peer IP change)
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	struct hlist_nulls_head by_vpn_addr[1 << 12];
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
@@ -29,6 +44,7 @@ struct ovpn_priv {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 };
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 85505fd9fd72cf10aea792bab92eaa8228075cf5..ae712b64e5092cc5759fb7141d98444dbde7aac7 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -280,7 +281,15 @@ static void ovpn_peer_remove_work(struct work_struct *work)
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
@@ -288,8 +297,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 		 */
 		netif_carrier_off(peer->ovpn->dev);
 		break;
-	default:
-		return;
 	}
 
 	peer->delete_reason = reason;
@@ -353,6 +360,89 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
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
@@ -393,11 +483,40 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
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
@@ -453,10 +572,35 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
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
index f3c5ad969fdad337afda23dd993805ed342cb218..52632215bb531b3dec4e0dae358f4e315cf33d7b 100644
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
@@ -58,6 +62,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_nulls_node hash_entry_addr4;
+	struct hlist_nulls_node hash_entry_addr6;
+	struct hlist_nulls_node hash_entry_transp_addr;
 	struct ovpn_socket *sock;
 
 	struct {
@@ -119,6 +127,7 @@ int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
 			   enum ovpn_del_peer_reason reason);
+void ovpn_peers_free(struct ovpn_priv *ovpn, enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);

-- 
2.45.2


