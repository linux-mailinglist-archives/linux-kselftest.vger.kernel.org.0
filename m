Return-Path: <linux-kselftest+bounces-27690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A35A47130
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76AB1882671
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD11E5200;
	Thu, 27 Feb 2025 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="b3F+JVqN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8D1DE3CB
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619388; cv=none; b=G4fcbCmdzljubRejJa+4YKpDyPQ3TxkNvyCdISpMudaYH9eo9gkG59apP5E17TmNM/sA6ziHyTAMAu015QYEROUUm+acuAI+aqttq9WV5WAykbZTPA7wQkFARfRLw76bux4ELgD5jdwICPllDxUcu0gBMy4lUD1So6/gWondU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619388; c=relaxed/simple;
	bh=JWvhzx8a/Z3EQjpoRO1HyBAcJrW4K+FafUpc5/aA3o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0uz0XLwf2vRqMB4zJquuVDQ0uSsrd1pmmeN4W/2cMuYXb77C+PWGecpyNtNmuAXfCpnEatnYu0ByTqYhzpFwAiL3VvWKahTP3XCCxhOL8Ntcd6oPAUhGQk0GRgW6m1H+K99aWfrjAxrQ82EYLgGSXM87i62stosl0CPIgvLXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=b3F+JVqN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso2989095e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619384; x=1741224184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Gn8xHQCt+taICnjDI3AVAOMhCauqUCMiljs5LBxDFU=;
        b=b3F+JVqNNV07TiwtOD/y8pjty99IoOccJORiy0vJca8PXz+06DSlKUJ1+gEQV3n1a0
         jV+2Qd23u8C9gKc9bpiRz/FlGRdl98WYHOmMVvzA66lRI/9OmekBDZe47C2CiIk8+Rm0
         t7+b2rE5ZQe1e24nylyoctgpVPbJfFcHqPSm34+e30iezV9Xtb1cVa1edtMvk5XhpfRD
         3pCt5pqo17oZaz74iloaq5xqOFxB+AiNpUKvalgCAHAzR+S8OcRbnvdwA1XgWYg4pwG+
         Hk7lGCJy+EqE7oXvlVmXeNIM8wRws/PSicYrcz2I3jrnfBdLp2+btYMnfRoeoDc4p1NB
         CgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619384; x=1741224184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Gn8xHQCt+taICnjDI3AVAOMhCauqUCMiljs5LBxDFU=;
        b=EgTvjxFOj1drjF5OJjeV3N7b7mi3jrQKlHSuGpVjK8wOwfUf3Wk4FHiVIFEWMEv6h5
         ABIqJQJDLfCONEbmiBpJamglX430PCXBCRyee1FkKkThWr8kBRCL6KVI5ai//9lMdRWY
         B/llzkpdpcN+GzjfpSmfuWgn+7oWVq/+AxMQJW+952ikXmFWfGHrrI89wwQBuMHuxn9P
         sBsn2+Knj/BKVFQDfxwf8y33Gy29Xz1nlVoXMyWL5ws1F6io75dbF6513ED0p2ly9FkQ
         xM4gdXmnYGpPEbj6Ub7Z6m1Sujj1+SlZwBdEM+DdSV1hNsIzfQf4pi6204grxxvsIwoF
         Ur8g==
X-Forwarded-Encrypted: i=1; AJvYcCV9IW1ixzHmdJDk0E6sil0AirN6L475Y9ftTJgGupNvpzi6tvy1IbXSZ63gWuqKhGS3QZ0xep9u09jLIrP5RXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBu9iEFyZuaOSMNx/WTRiZolm7gkBXEvGqtq8whONf7/f3VnpD
	H7AVy+Wphi7qa8dfee6trgDjFwvjzQzG/fsyqdDAJX2mhBpeYo1OFLb7sRzF0P8=
X-Gm-Gg: ASbGncsFGoyCl/BQ1mdu3og1isf1wGB52xW/0vt84bh5tg4e++NDGOLAJMbrsZiFW6Z
	1DqLH0SxmUFjUp42bInjjPGIZcm+d4HZSfh17BSPVgbfWjdU5YKzMXvOpoMNSPnAfgIupg8ZvdG
	G+npPd5XhQMh6PZ/sIWHastGyyX5R6yFH3ilKTA+X3MOcIke94gvpgRn7TJdc7y/ZQMAGwoEKo9
	hzjnhqNbIJ9aSYKp5rdq2H06qRZ/MyFdH41SHM4MC5qTLglHU26FHag/XpSAjqFOkfEEinnzWjl
	9PX70KBzHkPTn+vhl3TSwyz5p1OEe7NGMuH8+Q==
X-Google-Smtp-Source: AGHT+IGUzNlDjaDmMkYVgnhQALqiFGgmfgY3w6JNDwvM0JD7Lvw1rL0y5z6alYncRHre0iq2I3dVmw==
X-Received: by 2002:a05:600c:4e91:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43afddd10dcmr11144685e9.9.1740619383994;
        Wed, 26 Feb 2025 17:23:03 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:03 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:40 +0100
Subject: [PATCH net-next v20 15/25] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-15-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14123; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=JWvhzx8a/Z3EQjpoRO1HyBAcJrW4K+FafUpc5/aA3o4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75gV6nk8hmblLSGTup/7Kl4adzU06p7kz5YX
 mKSR9d8JcaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YAAKCRALcOU6oDjV
 h0sTB/4jVTfNVZcrBY3ZGLoEy6UEN6AHTJyF97tzqWrKo3O3VPftMIHLVRaBM+3eFezHS7pqtOm
 /RiTftNI7iq8tjFDQJ9gNP7u885dvARO31uHuIxqQrHEYMtqlSoFsuY8IKREi8YNi3eip7wBecB
 NGHT+mGjhIMv0dKZbjGBdS/MZC70ZqjPtf5sGXfiFSEKe1bZkWWkCz3pAGDoJxDqpX5FgsFwOF9
 sXtVYvPE0670nLDyxXFTV13UMaDBR+CMxQMGhgFhdRrr3ibueyNGun9GcSRYXy3PFhZWxqEp4YN
 Rwz4UrBPPE/gDMaiJ45rXaO9uPjtpUOU4tLa5WcOQCFCW8cU
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c     |  68 ++++++++++++++++-
 drivers/net/ovpn/ovpnpriv.h |  19 +++++
 drivers/net/ovpn/peer.c     | 176 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.h     |  10 +++
 drivers/net/ovpn/udp.c      |   9 ++-
 5 files changed, 275 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3498c0dafb1ee64b974a77dae882447e317352fd..bcbbc2200edd2e65190f5a7de07161321e16bb34 100644
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
@@ -100,6 +155,8 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->netdev_ops = &ovpn_netdev_ops;
 
+	dev->priv_destructor = ovpn_priv_free;
+
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
@@ -197,9 +254,16 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		netif_carrier_off(dev);
 		ovpn->registered = false;
 
-		if (ovpn->mode == OVPN_MODE_P2P)
+		switch (ovpn->mode) {
+		case OVPN_MODE_P2P:
 			ovpn_peer_release_p2p(ovpn, NULL,
 					      OVPN_DEL_PEER_REASON_TEARDOWN);
+			break;
+		case OVPN_MODE_MP:
+			ovpn_peers_free(ovpn, NULL,
+					OVPN_DEL_PEER_REASON_TEARDOWN);
+			break;
+		}
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
index 1f4148475c8b93aabc72694da5af97ae00a3a59d..b21ef6f10a7138e9f10c01b809df2cb0adf0abad 100644
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
@@ -480,6 +605,9 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 
 	spin_lock_bh(&peer->ovpn->lock);
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		ret = ovpn_peer_del_mp(peer, reason, &release_list);
+		break;
 	case OVPN_MODE_P2P:
 		ret = ovpn_peer_del_p2p(peer, reason, &release_list);
 		break;
@@ -490,3 +618,43 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 
 	return ret;
 }
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
+	struct ovpn_socket *ovpn_sock;
+	LLIST_HEAD(release_list);
+	struct ovpn_peer *peer;
+	struct hlist_node *tmp;
+	bool skip;
+	int bkt;
+
+	spin_lock_bh(&ovpn->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
+		/* if a socket was passed as argument, skip all peers except
+		 * those using it
+		 */
+		if (sk) {
+			skip = true;
+
+			rcu_read_lock();
+			ovpn_sock = rcu_access_pointer(peer->sock);
+			if (ovpn_sock && ovpn_sock->sock->sk == sk)
+				skip = false;
+			rcu_read_unlock();
+
+			if (skip)
+				continue;
+		}
+
+		ovpn_peer_remove(peer, reason, &release_list);
+	}
+	unlock_ovpn(ovpn, &release_list);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 777a0b24843ed03e83ae8821837103a979e2c6de..e88f1e695bd7a4cb0827f8d552ee900a2b3f722e 100644
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
@@ -117,6 +125,8 @@ int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 			   enum ovpn_del_peer_reason reason);
+void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
+		     enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 81f0ec332fc885d53e5a357512628f245ef3774f..4201ccf00bfb50a768eaf2d6e28a2fd4470e8644 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -448,9 +448,16 @@ static void ovpn_udp_close(struct sock *sk, long timeout)
 	ovpn = sock->ovpn;
 	rcu_read_unlock();
 
-	if (ovpn->mode == OVPN_MODE_P2P)
+	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		ovpn_peers_free(ovpn, sk,
+				OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+		break;
+	case OVPN_MODE_P2P:
 		ovpn_peer_release_p2p(ovpn, sk,
 				      OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+		break;
+	}
 	sock->udp_prot->close(sk, timeout);
 }
 

-- 
2.45.3


