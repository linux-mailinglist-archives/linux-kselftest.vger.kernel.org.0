Return-Path: <linux-kselftest+bounces-28725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE2A5C03D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEF17A7EDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9E25D53E;
	Tue, 11 Mar 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GTkhj3x7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83A25CC67
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694612; cv=none; b=HlQOGtYGzdihifE+6LvfRURVxmudvjtTp59cqsmLqC461plcWt9VoyX/xt/Dn2ppsxOV/8hjUnrpGNAs1InmsfEf4fICzxnk+No4VDQrx0q+NquvMYNtpVFKTxwQrFJdbnnBe6y8RVZgiixlzTbSi3AC6wjMdQrYHXYfhIBktTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694612; c=relaxed/simple;
	bh=hWDVMOTtTG8kzSL7EXcquGSgf8JSTQqIzV4s/5vY758=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiA4A6mcQj2Syo4fURNJuEcAOa0fmAMIKO7GUwAka0Sz1o8spsWkjSHpuAlSA1uKtj1BCR4H0n5f5nHYLXOnbTwe0sht7LtTo82wKL3aEp6qm+NXZvFFPfswwekS8ogL27Xa0Pco1G4mv7cP18O1M6JPbkKajxrO0763jZzNIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GTkhj3x7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394036c0efso31690535e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694607; x=1742299407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SdaijiYImbVHQ86OLZGBo8ZqPFKIkT8IkG7Vksf3us=;
        b=GTkhj3x763KWbv+Y0hUQEDGwT5XAhlNkAljDPv2hS0LW0e62BfRYoELbH5dddfhMV9
         EzG/NEtgiw7q/3cvPhSJ4IICcBE/H8d+tAnO968ZwrcUdmmBKE+OuvhpuIl2wPB6H3g1
         jMmQvDRV43lpGGh2YOeP6ekEjPf0SdQEm0IHkFtVF5RaOF5SLBYgfhXNm+JFyrpqj8Vu
         qWi/YzBPK+WRd8ecjSGyqajqkONLnqieXxRW8YjE2LcKGDBBSTLPQ0Gb6liBkb+lHl31
         /OZO1EMvgT7qS9ttPg2plyY+67zCtQ3cd8KyLVZjtkrwjBI+OSZnIq19RCLABrCM0Lwe
         uBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694607; x=1742299407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SdaijiYImbVHQ86OLZGBo8ZqPFKIkT8IkG7Vksf3us=;
        b=O985uSviT3qUriDTsRoAb2c6pBvktGI65x21WeoxgIchdufK/oFNYfdaUuUMM6R4yO
         mNPwlte0KYG30w2n3PgBmRVfP19PMJpICoqICFP835U8T8Gf6ASW8Zg5U/zYCJ1MSP5Y
         RcGtBwWGfP2n3/KHvC2D104D3EOz3ySnP7XH8EVNwLYMvvVUYCDLWLwORMWBk8FQvIHt
         P1zbCR8cVs2akI5J3ah1hVIORFYkXp9x3xDvRLt/Hl/w1qVkb4QNXtYTprgemP0cR3Qg
         GlMs0ioWe8ED5EdSrGAju/IAnqiKU9I7SOtFQPNYb6Ph4B/V8H1N4IiYuHpzgQF3KUvv
         7KwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSbr7t7RC3yXjpIpgQ5l/5i9y7D7cbIevtdgorQUK9vbFAEm3mGWri+DN7yhznLjGUSgnACQVjr1dKH+Nf2AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQq2GaapwgMeNJhvvAhejB5+Lw39Rhc2ouEA34hmXkXUH2RBJO
	2P4o2HkL/w/0Yxzv5dMqg5xjEg9DK0gYK4kGqfw/o+PRjZWu0SAlm6ZhQ+sirB4=
X-Gm-Gg: ASbGnctm5+iwxSJJKUk2vYNM3SfTs6p90+asV+S46kdqjBRRRXCzk7dH2yz3uAwxWI2
	TblKuJxGqmIRxFEByp8ZOzNbQev6hKWl/9pDoRlixjNNT1Nqc++La6VbQ37zjDCHbtkbM/8zRaS
	b4GYYxtzNfYWIWIjVDBiYDca2h5ZP5PEWvoKwOLyRnm+BHC1grs+4xCy0WKZXMy0mGKZ/OzBTvb
	fixq8btGhNT3d1k0U3H24IjVzSgYFT6N1tpPpyvXghxzkXk9taNOXg+vbiBkCBfjkDtQGivtsA0
	Rr1G9+Ogo0ciq0stexHzVh/BMVk6KeWbX+i98cDjrw==
X-Google-Smtp-Source: AGHT+IE+0O16KQuHrtXAFGlI6hGTyiHshsFfye/oYWhaMACrf1M38aNCQfqMi3vKfE9IiZghXS40hA==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr94680005e9.14.1741694607268;
        Tue, 11 Mar 2025 05:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:18 +0100
Subject: [PATCH net-next v22 17/23] ovpn: add support for updating local or
 remote UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-17-2b7b02155412@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9204; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=hWDVMOTtTG8kzSL7EXcquGSgf8JSTQqIzV4s/5vY758=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZxiWtJsKn8YaoM3h/YYT9VjsdFW8EnjUM2L
 7gFwfX3Dr2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcQAKCRALcOU6oDjV
 h8GjCAC2rcBNx3KvSQ1jFPIqbGn1jLSNSpi5amluhTt7dzc5L7pB5PWZSkYc6b+VP+UAHa0CHZz
 q/2pLWJ8uQ2qDfKR22K0pIJTqRVu0FXKO3ny66K6zl+4EUrPf1ztWE52voVAGs4DcwsAQI1zibi
 hIoNSc/KddphsZMX1YWVaaVb5KvLX9zUjgjV0By+Fijg0TStO1bH1r3qVPqUFJaWvQeXFY6W+Yw
 RZUg8g/czdhooa+t5fjf1KNC0p8MmRKrsSqMbGxLPY/05g3q98NyxGnkPTya5SXQxW/wrh8TkHs
 2INQ2x6sGIgd4yIpbF8Q5kv4VZ3ox2IS6WzjDAslbvaojmBV
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local or remote endpoint used to communicate
with a given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |   8 ++
 drivers/net/ovpn/peer.c | 213 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/net/ovpn/peer.h |   2 +
 3 files changed, 210 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 6ee1a40082ef637285d7f7f8183c53140583b716..5b673eae255033b9d7d6e7890a46686403d7c222 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -96,6 +96,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	unsigned int payload_offset = 0;
 	struct sk_buff *skb = data;
+	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	__be16 proto;
 	__be32 *pid;
@@ -137,6 +138,13 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (sock && sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		/* check if this peer changed local or remote endpoint */
+		ovpn_peer_endpoints_update(peer, skb);
+	rcu_read_unlock();
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 45e87ac155b554044388490a403f64c777d283a6..0d8b12fd5de4cd6fe15455b435c7d6807203a825 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -127,6 +127,206 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
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
+				    const void *local_ip)
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
+	if (ss->ss_family == AF_INET) {
+		ip_len = sizeof(struct in_addr);
+	} else if (ss->ss_family == AF_INET6) {
+		ip_len = sizeof(struct in6_addr);
+	} else {
+		net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
+				    netdev_name(peer->ovpn->dev),
+				    ss->ss_family, peer->id);
+		kfree(bind);
+		return -EINVAL;
+	}
+
+	memcpy(&bind->local, local_ip, ip_len);
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
+	struct sockaddr_in6 *sa6;
+	bool reset_cache = false;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	const void *local_ip;
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
+			/* unconditionally save local endpoint in case
+			 * of float, as it may have changed as well
+			 */
+			local_ip = &ip_hdr(skb)->daddr;
+			sa = (struct sockaddr_in *)&ss;
+			sa->sin_family = AF_INET;
+			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+			sa->sin_port = udp_hdr(skb)->source;
+			salen = sizeof(*sa);
+			reset_cache = true;
+			break;
+		}
+
+		/* if no float happened, let's double check if the local endpoint
+		 * has changed
+		 */
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+			reset_cache = true;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			/* unconditionally save local endpoint in case
+			 * of float, as it may have changed as well
+			 */
+			local_ip = &ipv6_hdr(skb)->daddr;
+			sa6 = (struct sockaddr_in6 *)&ss;
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+			sa6->sin6_port = udp_hdr(skb)->source;
+			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+								 skb->skb_iif);
+			salen = sizeof(*sa6);
+			reset_cache = true;
+			break;
+		}
+
+		/* if no float happened, let's double check if the local endpoint
+		 * has changed
+		 */
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+			reset_cache = true;
+		}
+		break;
+	default:
+		goto unlock;
+	}
+
+	if (unlikely(reset_cache))
+		dst_cache_reset(&peer->dst_cache);
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
+		/* This function may be invoked concurrently, therefore another
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
@@ -230,19 +430,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
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
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index e747c4b210642db990222986a80bb37c9a0413fe..f1288734ff100ee76b0c41ebb6dc71725ea33261 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,6 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.48.1


