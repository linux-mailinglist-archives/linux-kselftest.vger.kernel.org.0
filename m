Return-Path: <linux-kselftest+bounces-22950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF769E7ACC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6718894FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CD215064;
	Fri,  6 Dec 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fHqZfVYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF6223711
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519947; cv=none; b=S1igFPxvYbzawNIjNQOo81epR9dsESlSoqZrUFmLz1V68yZog2hotYo1GwM4aXpToWGF3Jvv+2vDUSIgwRxgXMb+vX2kCGxCJOS/78mlAZwQE15LlFosrkyJ90g+MSCq2xcZ2L0uBKIFT6VvxDFuqELRXK1YCa5d74e9z4L4dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519947; c=relaxed/simple;
	bh=qQPepHYVI0tddTzJCKJ8KWAb+8kdHQ9TYafwXNMa9WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnjDaIKHjB22MjtCH6LoVsxytQxw4x+/1L/DJhRdrSje2ZySbVN89Frezi/ApcWYlBbTpGJW6H9TdT1M3YnDhvqTor5eBGtuFH0E2XGm8kKxHTax49WGLhpTLyL4038XovbAg6ZHLTWjSnBWbrsX4wkJ5B7I4NMiyizt42sdofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fHqZfVYS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so23677885e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519942; x=1734124742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJku4th2J7HpIgjnFqftbdRCg2gbRfVpbDyy5ZOQ+KI=;
        b=fHqZfVYSBg8zXBB4M0WaSlcBNtDBzCjBQFeYbTwlU+BDbRCGjriHF5k4iFaiTkLXu2
         4OKgr5+mr8YysF2o+mc/s8PzYRdKba1GbcyaqmV9eQEzxGA9BnrYm9jBXl6tFDVQhBzu
         h5aIcxrVtG5ByF9ptFgP50B1U92PkWqlTlwvY2r/VnMlGit6WkisitrlmN/MP50KMO5/
         jeWyt8WswjMUs8HGzaZ+s1tImTAnqIUJXNv4gRmri/LsD3p9h8ciFv5zP632hNJ4FNsD
         vQ69CxcakTMBA/vloPxiwQnpL1L+BBqJF657qCvimVf4SIJq84zXdP+GW36lM1z4MJ4a
         n51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519942; x=1734124742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJku4th2J7HpIgjnFqftbdRCg2gbRfVpbDyy5ZOQ+KI=;
        b=oF5TuLIwBiXS6ftooCWgQIgnyId9Yw5Szh1yAfje5VFIPQdW5mzJG+0gBcmLp1IgAQ
         C4n4yKq00iJUUCOonIL0gKDoTlToqzLwyr+hKqycaQ5cwVl1BNdKyGeZ8LGLPHaK9CBm
         fA4LDtZ3hahCmFhMZJDql7NFVC4UTrDu6evyIwoZqcm2qjqah7Rhl7ltlBeT9TH5sNQT
         +Te46GQ1eN0oSMai+Q59Hplud/CWFiQ03OD9HDKqwSM9fq1Rie5f5um7jGnwbw6Mnrkg
         nbdfyk3oh+Cbtbwie+eCIPUYbcXArVphyhqZWD+R4ZehTkVETadRuchGPkpwU02wGBig
         UhuA==
X-Forwarded-Encrypted: i=1; AJvYcCXsyo2X5OT78juzBRd9KFky7X61KVDphe/nxNUJUAdpeqffE3lIoAew+aypTI77FT9ZUHlK74E/DTT/iz0Psko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycw9PySwiXXXqpIV1H24MhMzkO10L9myTTSxI0JiuGvxbFILoJ
	+Dpgu5Oa2tUTZ5nMAW4NVVJx4RY8QoQE/fjLny8+1sUWPOHT11xGN+h2sG2BOBw=
X-Gm-Gg: ASbGnctuygRppP5+IaRLp13N5+oPHaM/UAtTj2aDw36m9AP2gn1zzG3eIR8OoO6fwpd
	+p9VJDLS9XDWNJJ39LVAsAbJxXsHu1nO9lY7t0IaloYYdzYoOr3n51YvwBRoZGWaS07GDxx5Err
	wglF2rYtxqP5CZjLHDi3Bykq7mT7+zuzlBJ6saEJ6kgTVRCxda/4afSHvPNo5/lAbKL0BlXC1MZ
	ILUGsebagWyV3lVhuIWSAXOFxvjg2THYLC2E5fax7y/DUrmDoxYq+hysk4NCg==
X-Google-Smtp-Source: AGHT+IEpOfy2HOT2mlI+rxIWr3rfIad9hkq6OghcX10ClO6cMeZxa33fIAisEvc0fP3oWh0qbNppWw==
X-Received: by 2002:a5d:6d84:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-3862b3e3acbmr3426767f8f.50.1733519942333;
        Fri, 06 Dec 2024 13:19:02 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:19:01 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:41 +0100
Subject: [PATCH net-next v13 16/22] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-16-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10838; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=qQPepHYVI0tddTzJCKJ8KWAb+8kdHQ9TYafwXNMa9WI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYZY8P4i3aFLg6Y2+lUKvpLiL+CxhDTWvCv
 Xok8aXFodKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 h4jiB/wMiua+j48uX+JQ3lRikScYnDU0wCyffw9alXqh1rE1szhR1kXZvKH+7Il3InO9V/7qzeb
 Y9BzgJ4rLgKs2mLNWAbdBB73fKL3vyuX/9FXqSlzti3fm3BLbUXC5ZGV709FGEM5FCxuuAnEVtn
 6KMLKETqmlIbbrXfhjzABHfybsHXCHakiTfKjE0wWR+CaBqmVS1ve/71wYg+S1wSPLGpDTCk8WO
 /GesCi/fIxcObUAAZiiY5TuXpWkMfdeP4bbUmJEXiCUG6zrPvU2aWDnmokW3dzjLGGq/ytgTU1x
 urSFufKvq7iohVIarILQ0V8z7XNX8pD8FTr0rxKtf9qXx0C+
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
 drivers/net/ovpn/peer.c | 243 ++++++++++++++++++++++++++++++++++++------------
 drivers/net/ovpn/peer.h |   3 +-
 4 files changed, 193 insertions(+), 66 deletions(-)

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
index 19c4e4750c493cdf134f550c779d8b9dac0009ad..b1e2f976b4cfdf1a6f8a644eb5406f21830026e6 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -134,6 +134,10 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		/* check if this peer changed local or remote endpoint */
+		ovpn_peer_endpoints_update(peer, skb);
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index decc80c095d6a82787d42d0b4d50f85016e942ba..2711ecdfdc767fd252e1cce9f6d2f37fa1535646 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -107,6 +107,191 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
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
+/* variable name __tbl2 needs to be different from __tbl1
+ * in the macro below to avoid confusing clang
+ */
+#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
+	typeof(_tbl) *__tbl2 = &(_tbl);			\
+	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
+})
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl1 = &(_tbl);				\
+	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
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
@@ -210,19 +395,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-/* variable name __tbl2 needs to be different from __tbl1
- * in the macro below to avoid confusing clang
- */
-#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
-	typeof(_tbl) *__tbl2 = &(_tbl);			\
-	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
-})
-
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl1 = &(_tbl);				\
-	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
-})
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
@@ -466,51 +638,6 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
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
index d12fbced1252f84665b084f7a24b6d515bed833d..361068a0a40fd11cd4d3d347f83352ed3d46048e 100644
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


