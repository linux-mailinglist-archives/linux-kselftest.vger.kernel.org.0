Return-Path: <linux-kselftest+bounces-22698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019DA9E06D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF64516DD46
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27520C032;
	Mon,  2 Dec 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FN3AD5/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E320B7F4
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152132; cv=none; b=nrNR8KHetVRWF9GVLzdbx+SAUc9vMbjfnH6Xqh2b8ykMUhMO9uIY4ioNujKpWBElYbqC0mlJwjQM3wIwfLsR/yXiVyx0wN12LJnO7auz9anOySpIWjbf6bxGObhCv5ZnpwFx3GRSdEPnCHQi+Q4sCMAAoO+v2JQGeUi59lMXDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152132; c=relaxed/simple;
	bh=2qIz2p0fw0aYKbtD0sIQmGm8WFwVQ83diG3BR3Bkayw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzYUleaCnH4VO1Vc60bEMGEmdgV3mATovSYjUXBDr807qPy3zyd837omxSWGK8hWPy7v2JddDUCv4alRRA7dJaT89IuTtSF143ed+FYJdjpqymTeOecegZVKyBIeraIklWnE5mojtnyZ15aLPJVfTi0i++1gmK0qVOJbi37GvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FN3AD5/r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a10588f3so27938855e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152127; x=1733756927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggaE+5wPjKoAPNX3M2/uy1Q8P5VYEq4W790qDE/hRZ4=;
        b=FN3AD5/rXZZy6pbg2EjNbUuS7YtP5skm9zCHdosYcFfBkpkNghwLzn21Pw7RYp+yeH
         FoWSjXfGONyUn1zKM7QoeRJVmmtKeQMykYNJfb2aeTPzj/R7S8BKATQb/GX5aRoANStx
         fHTW13ii33N5RG4HxH+biiHcDMBuFwJabtoi4k+QVZRm9nOj5ybbuUZdg/C8b+DZRuMo
         QfO0NL0RgXDePU0jS+7sJXqn9BMXpH2lxn7VBBstj4BXhS0ImKUW20GKaiaYLDLfqfD2
         fNTiG0xMKsIheJClAVrfKO2KPjoQDnUENkwYDRQPhGa1xokEefQOPVd67rNhpwajvfVv
         5buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152127; x=1733756927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggaE+5wPjKoAPNX3M2/uy1Q8P5VYEq4W790qDE/hRZ4=;
        b=K14qElrovR4blu76/P7tVPpLJ2vo6UP4/82ew3pRlN8mLi3DL/vpFQ5yKJdtBIiiAC
         1f7ODLMat7FxG9ynnhDc8b2JeumnWCqZqaLSyJU+yhAtfBkLg/ITmsk30kfHJxPpZAvT
         0sUpwnA53g8vxVVCfP60j9wNiIpv3azQLt2xC/6ejT5HoEGlAl03iz8SIt+C3zz4LtKc
         Z+wlC6KpO/JWrg8pmbvl2dTEesjz/QQbyuXDrgoCRWvz/mxeTPwuMD/JCjyKbXRmtxKx
         PZNkwG0o6Xo59XoQaRPqobZwIZ+sfpJ0t8Wk5zOMyKF/93/GXoq0hbMf08movcNIKFVB
         g4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEH6m6uH4ZZBRDbzvEU5yzytK591L6E4kzAnNUrdwEk82Y+FP/LwRCBTBXGlErD17atScCte5OI0dHw3G3gPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDz/Ib6MRVo00jnNs8XYQamwXY+rnooBQmbosC6Vwo/Hj3vIp
	6HB/55hNdSyZdzFrn5aKke86tongEQmg23ztEUr1c2hRTf88h2MG9WeRNeLKYvQ=
X-Gm-Gg: ASbGncvsCpuy2DuSnE067LmDAViZCvbTojhkhukWFfC8UbL6ppa2F1l8jPAazSnlhii
	NUID8XhRK6YztyLb9C+r72Kfdg3z7Tn09JVaa6EnIx3Qx3POKPNguWiQFZnqxCFWUxl2FIiaWvB
	5wLUkjhlvWmirAzVkmcLUASML21Sa9K4DQhC6i1FBqILM+IXW9S92alpHlWAyXeUMJWcC1NhB59
	atkOi8bTaVsmTru0wGANeUTx67p5H8lhw1CSnm3k9/Dey47EQ8etvpvS9fY
X-Google-Smtp-Source: AGHT+IGxU/XR/Upr3Ab3tRhInXYUac1ex6IqqewbVOYRCK/zO7zwNTyK13wjuJmQxIQzGY92MKeCDQ==
X-Received: by 2002:a05:600c:4fcf:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434a9dbbd8amr215126495e9.2.1733152123969;
        Mon, 02 Dec 2024 07:08:43 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:43 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:34 +0100
Subject: [PATCH net-next v12 16/22] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-16-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10598; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=2qIz2p0fw0aYKbtD0sIQmGm8WFwVQ83diG3BR3Bkayw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1neKSW/LerriMkWx6f0I6646POr/Gp3GkM/
 /La6SOLQ32JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 h9iKB/9uH09Orsfl/Md5gU4hmP0SEEOUPSnsCqOiGqKBuomIGpfNtYd+K/0WEQgx6a5etHAn6NH
 Z7dDO1lj1Tncz+vRkS6bcAPc84K/XJm9gw3+yK1U/f4tz2J+G9tJKZqpzHAwm0PHEmQF0VYMndw
 sFHFKat73UAeZqQFsr/pcgApn2Y651wBpqUduGE/A6OQBWkMKh7ehrEEDdCWv22yU3gI3iowfI1
 IMshQdqAs5otc6SySM7bfq/0mkSlEkVD8fy0jDob+2R7RKC4+bHbw7IZqWWNrJjbn0lgqO+VnnS
 J8/0NXRBcMAtDZ+gONOXEQ/Xj9sOGqvhAb0hF+gpIgX9+rQx
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c |   9 +-
 drivers/net/ovpn/io.c   |   4 +
 drivers/net/ovpn/peer.c | 237 +++++++++++++++++++++++++++++++++++++-----------
 drivers/net/ovpn/peer.h |   3 +-
 4 files changed, 190 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index b4d2ccec2ceddf43bc445b489cc62a578ef0ad0a..c8ca340cca936a357409e9458807f27831511975 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -48,11 +48,8 @@ struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
  */
 void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
 {
-	struct ovpn_bind *old;
+	lockdep_assert_held(&peer->lock);
 
-	spin_lock_bh(&peer->lock);
-	old = rcu_replace_pointer(peer->bind, new, true);
-	spin_unlock_bh(&peer->lock);
-
-	kfree_rcu(old, rcu);
+	kfree_rcu(rcu_replace_pointer(peer->bind, new,
+				      lockdep_is_held(&peer->lock)), rcu);
 }
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index bad6c0782802a993e6da04ecc1629ffd3ec59f62..ee3bb650ed4700d8fa2c9a128b6d2318e1653f5c 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -135,6 +135,10 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		/* check if this peer changed local or remote endpoint */
+		ovpn_peer_endpoints_update(peer, skb);
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 7df9fedd593a74e2349922557ce299a0fcf03038..8c5643ca497f78282d6171a8ddbe9896cccef7ed 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -94,6 +94,188 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_reset_sockaddr - recreate binding for peer
+ * @peer: peer to recreate the binding for
+ * @ss: sockaddr to use as remote endpoint for the binding
+ * @local_ip: local IP for the binding
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+				    const struct sockaddr_storage *ss,
+				    const u8 *local_ip)
+{
+	struct ovpn_bind *bind;
+	size_t ip_len;
+
+	lockdep_assert_held(&peer->lock);
+
+	/* create new ovpn_bind object */
+	bind = ovpn_bind_from_sockaddr(ss);
+	if (IS_ERR(bind))
+		return PTR_ERR(bind);
+
+	if (local_ip) {
+		if (ss->ss_family == AF_INET) {
+			ip_len = sizeof(struct in_addr);
+		} else if (ss->ss_family == AF_INET6) {
+			ip_len = sizeof(struct in6_addr);
+		} else {
+			net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
+					    netdev_name(peer->ovpn->dev),
+					    ss->ss_family, peer->id);
+			kfree(bind);
+			return -EINVAL;
+		}
+
+		memcpy(&bind->local, local_ip, ip_len);
+	}
+
+	/* set binding */
+	ovpn_bind_reset(peer, bind);
+
+	return 0;
+}
+
+#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({	\
+	typeof(_tbl) *__tbl = &(_tbl);			\
+	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);	\
+})
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	&(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];	\
+})
+
+/**
+ * ovpn_peer_endpoints_update - update remote or local endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source/destination address from
+ */
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_storage ss;
+	const u8 *local_ip = NULL;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	size_t salen = 0;
+
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	if (unlikely(!bind))
+		goto unlock;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			if (bind->remote.in4.sin_family == AF_INET)
+				local_ip = (u8 *)&bind->local;
+			sa = (struct sockaddr_in *)&ss;
+			sa->sin_family = AF_INET;
+			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+			sa->sin_port = udp_hdr(skb)->source;
+			salen = sizeof(*sa);
+			break;
+		}
+
+		/* local endpoint update */
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			if (bind->remote.in6.sin6_family == AF_INET6)
+				local_ip = (u8 *)&bind->local;
+			sa6 = (struct sockaddr_in6 *)&ss;
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+			sa6->sin6_port = udp_hdr(skb)->source;
+			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+								 skb->skb_iif);
+			salen = sizeof(*sa6);
+		}
+
+		/* local endpoint update */
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		goto unlock;
+	}
+
+	/* if the peer did not float, we can bail out now */
+	if (likely(!salen))
+		goto unlock;
+
+	if (unlikely(ovpn_peer_reset_sockaddr(peer,
+					      (struct sockaddr_storage *)&ss,
+					      local_ip) < 0))
+		goto unlock;
+
+	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
+			    netdev_name(peer->ovpn->dev), peer->id, &ss);
+
+	spin_unlock_bh(&peer->lock);
+
+	/* rehashing is required only in MP mode as P2P has one peer
+	 * only and thus there is no hashtable
+	 */
+	if (peer->ovpn->mode == OVPN_MODE_MP) {
+		spin_lock_bh(&peer->ovpn->lock);
+		spin_lock_bh(&peer->lock);
+		bind = rcu_dereference_protected(peer->bind,
+						 lockdep_is_held(&peer->lock));
+		if (unlikely(!bind)) {
+			spin_unlock_bh(&peer->lock);
+			spin_unlock_bh(&peer->ovpn->lock);
+			return;
+		}
+
+		/* his function may be invoked concurrently, therefore another
+		 * float may have happened in parallel: perform rehashing
+		 * using the peer->bind->remote directly as key
+		 */
+
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			salen = sizeof(*sa);
+			break;
+		case AF_INET6:
+			salen = sizeof(*sa6);
+			break;
+		}
+
+		/* remove old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		/* re-add with new transport address */
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+					   &bind->remote, salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+		spin_unlock_bh(&peer->lock);
+		spin_unlock_bh(&peer->ovpn->lock);
+	}
+	return;
+unlock:
+	spin_unlock_bh(&peer->lock);
+}
+
 /**
  * ovpn_peer_release_rcu - RCU callback performing last peer release steps
  * @head: RCU member of the ovpn_peer
@@ -197,16 +379,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({	\
-	typeof(_tbl) *__tbl = &(_tbl);			\
-	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);	\
-})
-
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl = &(_tbl);				\
-	&(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];	\
-})
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
@@ -450,51 +622,6 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 	return peer;
 }
 
-/**
- * ovpn_peer_update_local_endpoint - update local endpoint for peer
- * @peer: peer to update the endpoint for
- * @skb: incoming packet to retrieve the destination address (local) from
- */
-void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
-				     struct sk_buff *skb)
-{
-	struct ovpn_bind *bind;
-
-	rcu_read_lock();
-	bind = rcu_dereference(peer->bind);
-	if (unlikely(!bind))
-		goto unlock;
-
-	spin_lock_bh(&peer->lock);
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
-			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
-					    netdev_name(peer->ovpn->dev),
-					    peer->id, &bind->local.ipv4.s_addr,
-					    &ip_hdr(skb)->daddr);
-			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
-		}
-		break;
-	case htons(ETH_P_IPV6):
-		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
-					      &ipv6_hdr(skb)->daddr))) {
-			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
-					    netdev_name(peer->ovpn->dev),
-					    peer->id, &bind->local.ipv6,
-					    &ipv6_hdr(skb)->daddr);
-			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
-		}
-		break;
-	default:
-		break;
-	}
-	spin_unlock_bh(&peer->lock);
-
-unlock:
-	rcu_read_unlock();
-}
-
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 196fa0a04f2db1986fffa6d51b42b68c9837c8e8..a95ec054a8c2224cc0a4ef3800d30e76138f1fe6 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,7 +153,6 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
-void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
-				     struct sk_buff *skb);
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


