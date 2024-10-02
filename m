Return-Path: <linux-kselftest+bounces-18881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB92A98CF9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD4CB250CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADDF1BDAB9;
	Wed,  2 Oct 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="L/YbOIw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436A1A01BC
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859818; cv=none; b=F7dGC3NQz+A4+rp0ZLYFGyGsSfN0+sYXKxPJ9ZO0G3WhPSheZSZ+wuQNCCy3185W7ejeQJpBZiEOmJ0uoGr6tn/VF3GySTJIfV++5AcgcjSR4OrQDpquY2rHqAjVE1/zyP+ZBel3Uc8M6JCc3o08zmD4LR3NMBXZOXPoOKavmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859818; c=relaxed/simple;
	bh=/jyZFCitrzzTMegwb3RUVnyedfZN21mXFMy5IfxSzJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5cYx7ocr+WwxAsn+zSEL5FqyfyqJ/e3vXkzPMy5MDyhX3KHrXeMuFxqHO5tq9zb/IQ/foEibs9oh/hIAB9xkO2WjZNPntdmWbm3qzhMMxF8gq9OlqfctOFl1yBvSOEgGPmhPmUX67zYTlP/X+fxCRowylW7aeoTHnFo3pCLm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=L/YbOIw/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso3655208f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859813; x=1728464613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTv3ai7RTqlCKNTR3vLfU8stwy3llALadHqfw0c8P9w=;
        b=L/YbOIw/IHjeir+JDBezh1+u2u4NuTzpaPupFVRR5csSUzvDgq0L54x0N3/75UiHH7
         E9z85zCsCEpjh+PFHftkTyLDusXIv6SMOMq/MAfy2FT+GVHUkg3fdQ2r8ffC18I1kr1l
         7+U9qsXI0nDLx3CCMwMReNDzzoMh3sTPTA/6nws1SvvCObfou48W7f3LiXbg5uLFj7Vw
         +JMctOR0NIA1cQJ+C72AY6QDUm6po8x0AfRe59EG6XI6nFMFDMKU1bFO7/VChwtVBKEi
         fsXPm+C0ZByKx7O/sKu3+3Uvr0fvi0cN6UT++Zkjhgl9noEF5LvEhQTrpkNHHVbkqmQn
         fw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859813; x=1728464613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTv3ai7RTqlCKNTR3vLfU8stwy3llALadHqfw0c8P9w=;
        b=B4kaq/IA8m9/Ug4kAwHw0ghq8mGfJYsShIIWrzBHkXF3+rhQciR/d6xQkUSOD3JeT+
         ntoLYGGioxfE0paH83SYPo/nWwSy7S8PksD2iNCOdAws1JeWA1hSo2WxY+wlQFFmTh6Q
         MKInvvlvLkTE2I1T30BlRZSZ1+PmVMvJ40tvf3CMjX+mQtZO/nR9f+o0lZn0PRZfSuA4
         ZSOBosQ5JxQBe0SA5Ou8jFInN8lVwwvjx4a2vFc6vWgM8h81RomMjXU9gi5wKj9hreaU
         vBIBTDKYl0RYR/1z7F9JfODspsst+vKyOo0/cGC0FHfwJZjuT9PfDybrl6YIirc4mFcD
         BKCg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Mhcpvo6/7/lG96JVowOrkNsU4i9dbWFdH1dq4manH2tgt/1wedg02wnQ0dU7LUd32YvApCGXURg56XF4ruE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mPykX3VCIwylL8DhojjJdMHfWJLM7yTRxgAEAXBPvMFn9/wV
	g88l81fYjSx2wu/jVYqE3xx2RRcmkbsuLJt7gAGtuxMfRt1cIYJjo5T9DiebOC3W1d1uqST8GYX
	X
X-Google-Smtp-Source: AGHT+IHEjkOeBEun/Xsvp1QCzEdephCC5mwpKVumRXLB7ffiuz3BMrEIzghL+EVaW2EwA/3DOXKUCg==
X-Received: by 2002:a5d:4c87:0:b0:374:c606:df0a with SMTP id ffacd0b85a97d-37cfba0a6c0mr1534988f8f.36.1727859813469;
        Wed, 02 Oct 2024 02:03:33 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:28 +0200
Subject: [PATCH net-next v8 14/24] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-14-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13149; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=/jyZFCitrzzTMegwb3RUVnyedfZN21mXFMy5IfxSzJU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxSMMpUcsBjjFpYFEvQt63PpGHoH/WNli0Cf
 Ihh5Ho7IPmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUgAKCRALcOU6oDjV
 h2euB/oDijAue0yLnLzz9VFOJs+esn7rFyTxmkRO8C2CmrRZRZ572pzTJ2NN20jyRwjghY23j6e
 xd/rNlXA9bdThmrpHhTzQlarzrRmVvDV6EvHRqe6P1QJGAOwRyeUdauHNpqUvpAjIk9LEnDn0Jm
 5COgeUwl4zfpYLEnK6HFh/SJ3oYtVNOAiqhiPHpplMQGHQblyr09fiBpQIHGhK5HiWFazBX1VYN
 H0UUjXLEJxqs4vMENTI0srf6n9XwJjI7q5AeeuswD82ejX7YX653A30QYPxiYZmErTpXoKwbdfQ
 csAXai/srb5g29xr0I8F23Td0fPmyg5Pu302oLvjYyld0NjY
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c       |  50 +++++++++++-
 drivers/net/ovpn/ovpnstruct.h |  19 +++++
 drivers/net/ovpn/peer.c       | 173 ++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h       |   9 +++
 4 files changed, 241 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index cb5cc3d4b5620f5a1e401e06e52e67c32e57aa78..7604f0970d3c283f8680f6800a125427999bb174 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -50,13 +50,53 @@ static void ovpn_struct_free(struct net_device *net)
 	struct ovpn_struct *ovpn = netdev_priv(net);
 
 	gro_cells_destroy(&ovpn->gro_cells);
+	kfree(ovpn->peers);
 }
 
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_struct *ovpn = netdev_priv(dev);
+	struct in_device *dev_v4;
+	int i, err;
 
-	return gro_cells_init(&ovpn->gro_cells, dev);
+	err = gro_cells_init(&ovpn->gro_cells, dev);
+	if (err)
+		return err;
+
+	if (ovpn->mode == OVPN_MODE_MP) {
+		dev_v4 = __in_dev_get_rtnl(dev);
+		if (dev_v4) {
+			/* disable redirects as Linux gets confused by ovpn
+			 * handling same-LAN routing.
+			 * This happens because a multipeer interface is used as
+			 * relay point between hosts in the same subnet, while
+			 * in a classic LAN this would not be needed because the
+			 * two hosts would be able to talk directly.
+			 */
+			IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+			IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+		}
+
+		/* the peer container is fairly large, therefore we dynamically
+		 * allocate it only when needed
+		 */
+		ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
+		if (!ovpn->peers) {
+			gro_cells_destroy(&ovpn->gro_cells);
+			return -ENOMEM;
+		}
+
+		spin_lock_init(&ovpn->peers->lock);
+
+		for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
+			INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
+			INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr[i], i);
+			INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i],
+					      i);
+		}
+	}
+
+	return 0;
 }
 
 static int ovpn_net_open(struct net_device *dev)
@@ -201,8 +241,14 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
 	ovpn->registered = false;
 
-	if (ovpn->mode == OVPN_MODE_P2P)
+	switch (ovpn->mode) {
+	case OVPN_MODE_P2P:
 		ovpn_peer_release_p2p(ovpn);
+		break;
+	default:
+		ovpn_peers_free(ovpn);
+		break;
+	}
 }
 
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 65497ce115aa4be719ed03f89135a80b73f9ef9b..4373d1bbc4874dc2f1d1f1697e7b847ec2f486c9 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -14,6 +14,23 @@
 #include <net/net_trackers.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_vpn_addr: table of peers indexed by VPN IP address (items can be
+ *		 rehashed on the fly due to peer IP change)
+ * @by_transp_addr: table of peers indexed by transport address (items can be
+ *		    rehashed on the fly due to peer IP change)
+ * @lock: protects writes to peer tables
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	struct hlist_nulls_head by_vpn_addr[1 << 12];
+	struct hlist_nulls_head by_transp_addr[1 << 12];
+
+	spinlock_t lock; /* protects writes to peer tables */
+};
+
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
@@ -21,6 +38,7 @@
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
@@ -31,6 +49,7 @@ struct ovpn_struct {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 6d34c56a4a51ce407b20b6175e6140aafc4b4e33..3c6fbf99f696c18d8a2dbe169c7f6f5933fb71ac 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -65,13 +66,12 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 }
 
 /**
- * ovpn_peer_release - release peer private members
- * @peer: the peer to release
+ * ovpn_peer_release_rcu - release peer private members
+ * @head: RCU head belonging to peer being released
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+static void ovpn_peer_release_rcu(struct rcu_head *head)
 {
-	if (peer->sock)
-		ovpn_socket_put(peer->sock);
+	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
 
 	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_bind_reset(peer, NULL);
@@ -86,9 +86,10 @@ void ovpn_peer_release_kref(struct kref *kref)
 {
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
-	ovpn_peer_release(peer);
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
 	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
-	kfree_rcu(peer, rcu);
+	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 
 /**
@@ -309,6 +310,89 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
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
+static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
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
+	spin_lock_bh(&ovpn->peers->lock);
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
+	spin_unlock_bh(&ovpn->peers->lock);
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -349,6 +433,8 @@ static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
 	default:
@@ -356,6 +442,51 @@ int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 	}
 }
 
+/**
+ * ovpn_peer_unhash - remove peer reference from all hashtables
+ * @peer: the peer to remove
+ * @reason: the delete reason to attach to the peer
+ */
+static void ovpn_peer_unhash(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
+	__must_hold(&ovpn->peers->lock)
+{
+	hlist_del_init_rcu(&peer->hash_entry_id);
+
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+
+	ovpn_peer_put(peer);
+	peer->delete_reason = reason;
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
+	__must_hold(&peer->ovpn->peers->lock)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp == peer) {
+		ovpn_peer_unhash(peer, reason);
+		ret = 0;
+	}
+
+	if (tmp)
+		ovpn_peer_put(tmp);
+
+	return ret;
+}
+
 /**
  * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
  * @peer: the peer to delete
@@ -411,10 +542,36 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
  */
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 {
+	int ret;
+
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		spin_lock_bh(&peer->ovpn->peers->lock);
+		ret = ovpn_peer_del_mp(peer, reason);
+		spin_unlock_bh(&peer->ovpn->peers->lock);
+		return ret;
 	case OVPN_MODE_P2P:
-		return ovpn_peer_del_p2p(peer, reason);
+		spin_lock_bh(&peer->ovpn->lock);
+		ret = ovpn_peer_del_p2p(peer, reason);
+		spin_unlock_bh(&peer->ovpn->lock);
+		return ret;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
+
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ */
+void ovpn_peers_free(struct ovpn_struct *ovpn)
+{
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id)
+		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
+	spin_unlock_bh(&ovpn->peers->lock);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 86d4696b1529c45025b63d2973fc48ca81ca8f63..9481eb41742ca2a6c88ee0262dd448fd947614fd 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -30,6 +30,10 @@
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
@@ -62,6 +66,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_nulls_node hash_entry_addr4;
+	struct hlist_nulls_node hash_entry_addr6;
+	struct hlist_nulls_node hash_entry_transp_addr;
 	struct ovpn_socket *sock;
 
 	/* state of the TCP reading. Needed to keep track of how much of a
@@ -126,6 +134,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
+void ovpn_peers_free(struct ovpn_struct *ovpn);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb);

-- 
2.45.2


