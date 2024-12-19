Return-Path: <linux-kselftest+bounces-23560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC69F722B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707331895A5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599D1B3933;
	Thu, 19 Dec 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VV8LHDiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F221ABED8
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572561; cv=none; b=FwKoABw5qtNyW4gI4oH/U7imtSwxQ2WGtbZ3whvdE9RlBPfjz9TmpVVo7meC33diG/zSvpzzl9TPdPItWc1GIH7RLwr9jJPnv9lvQpZZGzY4salpkS2y3OI94soabg2LzSN/7dLwkCGhmZLCKQLy4KFRZ/RcRCPMP+fN66bLOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572561; c=relaxed/simple;
	bh=Ner+Y9lOD0QCNOn6JDNe92zZ8x1b/XkYzIyJ9VMN3oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vi+lZRj47TkMc+aV41RaeYNRp4+F7bq6c+WhZfmf0x59uhqk7F3io5hH5ASetbcOF8L/QG4Ss30NRMMqAiE9QVRicaSJ2Q0G0U6imGZ4inrKaRLJ7/jcb06abzCHaeTekTlmt1MtWAoo1k16v1ffqHdBmY+KmqQgQVuQliLZOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VV8LHDiw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso8789505e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572557; x=1735177357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMIKMSMhdh7i6wcGv+anytJj7LF11ZgbArmxkgabVi0=;
        b=VV8LHDiwaG6ECJLPlNDIFfT+83lw9a+vs7EHopcj/ESQWcQssr/o4MvWbtitl5wyw7
         YNj3k2ZyWU52Ilpn+Ww6fslFWmcOJ54f2vvKBnjsVhbGJqSPUsw+DE0aK4KzpXAZiIQy
         UgRJLHq2Rfl7xIs8qDbfEusTdU62N7gC6fN1BxZCNUR925LNFzLRs1zQKg0PG9iulqUN
         4h6tqq/pEzUxaXXnorxk/L/9zkw70AHTtPZbXFmwFA7yaT7PvGBtSqZxN4zfTsTmxB7/
         wN7T/i/Qs+oKhpjawmXopf6IZDkXGaVrbvjLAl9+Th/fJdWtPBJItmlXPFRmkzoCjVuH
         r5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572557; x=1735177357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMIKMSMhdh7i6wcGv+anytJj7LF11ZgbArmxkgabVi0=;
        b=UZMkyxUPtPOXbLN+IbHLaRS/rWSvprn9SmLrvEvQu9mW5jbDDrL4fMD8ECSaiIsxGC
         +ovXYYHMbrJDZDzrL1WQijEMAeAkLBSXGC09q75xyIcYf6Kur+PpcufSn4CyFo1MGCeo
         Dm8ODK4uKAQGK+F1LZmDWeCM8zhXfabwiDwSTpxakmyFdsIvKv3yhBXdhFvIvoVvsKEI
         J5xxTQSvpHkS9DW8r4ThMsGQqbpwQDuc4eZaUnGNKGYd82qjf+eIhLQFJQS1JnpJFCqR
         k5ynF0zIKqpqQNlUz4HTNeTWZP8jrakubdKGcHu7MLCAvtlWjCRTszBWn7FyWu9Vzfr9
         OTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+lGur4PCNMUoJAQgT+vSRiHlUwtNdp8XG5ne2B26SdfzleiW6XkeGlWX0JupYGm6nvoskyRN2NiVhe1gLNXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoix3+KRahcfK5Fnd1nkMG2eDP65VEdKVMjEXN1dQpVIHmqnvA
	eu4kINV05cltUxgclnmV90B4fMOpR+OR8WMIjpMs05/EbA4IE9bVKIpFYfMiDcg=
X-Gm-Gg: ASbGnct1OFiU4OXsFxMPUHofEQCXT2OFiGSBcY8WcxUZk5p2oX8Sn9lnVa92yjOGuWT
	NoP5j+GrKoHNscFLEvjU8JwqdmlAvXkYJzn8VGh+xaZnZB7lo3h5bHVGwReqdWzCqDqLIrNluqL
	Bgi2ql1y9vYAJh065gEgqc65ArF2GpZta42AYfMg8teL0HHQD6bf7qPstNo3pkJHpSkO0qXAUao
	5hVTdC/FFdINnfdQyIM7OLL6ktB9rP9kjWjJNdQDCeWpqJ697qV9G8dge1Ui2x4PVbG
X-Google-Smtp-Source: AGHT+IFau3YOFckPLvA7VtABFYQ4Uij85TkFaRkqUP+pYHDWboGRDIaihok3tmrwE/VipMTANVaaaA==
X-Received: by 2002:a05:600c:4e87:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-4365c7796d7mr10513185e9.7.1734572556750;
        Wed, 18 Dec 2024 17:42:36 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:36 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:14 +0100
Subject: [PATCH net-next v16 20/26] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-20-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10078; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Ner+Y9lOD0QCNOn6JDNe92zZ8x1b/XkYzIyJ9VMN3oM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oX5c2BNKo4FzpLE0hJqNvthROyInJUVzCch
 ZKZdAE0MDKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FwAKCRALcOU6oDjV
 h8o9CACF8Ab3DLmXLNSVyTtoNdi2ska8UpCpDizEUvf02UP+AQW3LXUyXR6BDIhDW2pDPnwJk3c
 7GGE3NNZ6jblbHiSu9qTUchll8mOZojlPb3mwOKintGeN3z9qdZA0M9VKunHLawWsm6jysNuM3X
 Xg1k+hmhHdd24xR0WeUJp1g8YC5YF7avt+8iZnyQj/CrEvjRaVREGQ1AaLMWTveVucyPPTr6shS
 sw8pFRxsZnvrR7SetKwcfXUE/feE1yVv7JqOspoSEl4ztszwBUBxy7e8iUyNvVT8Q47KVAsPme4
 Fo+9lCEjKuUa5raCdP43g5PZBEHXC4dgY5j6eJdxO8v3dy1i
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |   4 +
 drivers/net/ovpn/peer.c | 243 ++++++++++++++++++++++++++++++++++++------------
 drivers/net/ovpn/peer.h |   3 +-
 3 files changed, 190 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 0bab35fab06b4399c57e49732453df2fc12e9334..8162b12f7a36b897d685c70f1befd87d774826a1 100644
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
index 56c3788a2b4b8c2a85826b1b23fa84943e4cafbc..8a33595cbfb565ae5577e82f615a5ac83f46101b 100644
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
@@ -495,51 +667,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	ovpn_peer_put(peer);
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
index 8e2dc1152d29d9a322361c7ad9b04cef07d18206..e0e9c37ceddedec5fb271722260178937fc22e4c 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -149,7 +149,6 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
-void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
-				     struct sk_buff *skb);
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


