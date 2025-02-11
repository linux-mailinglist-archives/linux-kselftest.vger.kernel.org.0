Return-Path: <linux-kselftest+bounces-26299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C4A2FF7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFEF168574
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A71EE7DF;
	Tue, 11 Feb 2025 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="apWzL3j6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8771EBA1C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234491; cv=none; b=EL9CWxdUnEJqS5RMxf6uQGPzzA2pdk1ShXYAD0Xt7m3+s5Ns/5aioW4k3PXPEooOvLhBIDIx8p+64I0gyexJG1ybxExxExt5moK6BI6Iz0GGg4KyTWlQYn9n7QZlohW/sLNEZFtb0bX2EYHhxDqS8rXtkaymGIRXYpW6oyzVNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234491; c=relaxed/simple;
	bh=uVl/jnMHf/rIEGIDroH30UBLplKm0663aOBHd5cNtFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5HluxEPK4OyiicAwK6n+qR4SCrXBbFIQzQYlhGaImMB+54VzNTwoYI1hCmIj5I1gsoQ72VIp/BWSAxa/hs7DtnrT2GWGhGgOPdI5o6xAZlADyzcPGcmdzlXyGNIjq4LcR089LlQpbQhnWfM86tr6ipZgOiwejcHLt+J3+JNkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=apWzL3j6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2602991f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234485; x=1739839285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeOffvcr442D/yTnyX1CuqX7RJYYoWczCUth7JvTEJk=;
        b=apWzL3j6197+B9gFBJusk49E4z52PumrUzq+p/dLpcwbpeBIPdfpdm424jwN9JNK7d
         G9vJ91pRuMJBVVQrULGaokgBX4sJ5DHddUJOxoVHB7MtlpkGDlgWTDI49ZjhgJUIu2Zd
         XTCeRVhsOUXqGknJN6K4ivj8NCNt2RABmgotTYXGK1ADchJKbpLY4jKQ8JhoyiMrpfDd
         bfuzRwQ6Ocv+08R6IJ4SC6rG/axur2FOo56SEm++8oG8EbWQLyTRLdyqJcRftoHm0QYM
         5IhS3t1gWNocxjWaoRzVwV7OAlaF4IhpiPmXzuyk43Uh3Iwz52ibddmZstKrq60xk1F+
         i0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234485; x=1739839285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeOffvcr442D/yTnyX1CuqX7RJYYoWczCUth7JvTEJk=;
        b=hjLDC7cW4siVPJcZALyZiV+fXYeYaBlVKSDvCxLwdt4nZjKrQ8ybz462QfDTIy+vgg
         36j+Gzl7jQaNUcG0Ac3U+klJWA9FVj8axk4Ppa0xNEzHvuQDZ50szJ42+YgLeimEaSFW
         tGTCbo8aghK8ghoMLWf6hpjm61nwDHzKB/og5AyCX8mxdBbRQ8MCIPggZHhvqMUQMTfg
         40lo5H0bsdt1u0E9+hEc+5OPzguRFGvFbYX2MsI3Ct30WodU/UClyAYr+SKy5Il3WIDh
         FrMcPn3gfooVMXME8m3FZefjBfa+d1EW4aq2JTQ/TLLrqkeiFQQIcTRDX/dEKGf4inrj
         +JYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT9c0nKcasxk6Szh1itZ018ysArJIzlmskbG/stQiQHnpbtXzCq3yEXvT4I7GRNXLyqO1HqxkCPua8Ys+qM+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwET5CyrUXGSLsZh31FKZCr49zrdhRKh/TwDG7RSBKQ+Ssl02A9
	0DjXkqTsmcBhmFthL4cFtSuOXjdEt1ckU6Cc7+ssT3djCat65ZZpwgkIByB8zUw=
X-Gm-Gg: ASbGncssIeMN3zPy13/x2N9eibgX98cZhU9/hY6djtOu2uSkHNtiyi44HlGYvP8PBky
	HpZMVEPfb/o1AZva9qlhhRxIB2jaxHUXrYmJ4gaQ5WJAM/5Gq9y+OuFLj+Kcrq2BonSJAZ0z5gN
	FBu4nD8JrlOm6qKbAecOWwaS+bQK1GFx8NbyAqc21TrXB17G8RLCtX5LprRcNmt7QCZcjn8TPTp
	7X3QGF6Zee9Wxnlln8H4jtRqPq1MURvdoq0Qt5FV+ereLEjpuM6U9XEkVRDz5NjG/z7rEUv9Yrh
	okvNzEOGZxAeqaOClyEa7Dzepc8=
X-Google-Smtp-Source: AGHT+IGhwov/JvGJkV1cuVHbrfWHoe4RfG15zZpUaLpWV87m1XRaM7Rd6oaxJOL3jotcanTgdj0Waw==
X-Received: by 2002:a5d:6c64:0:b0:38d:e190:b6f5 with SMTP id ffacd0b85a97d-38de190b843mr4032491f8f.43.1739234484598;
        Mon, 10 Feb 2025 16:41:24 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:24 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:12 +0100
Subject: [PATCH net-next v19 19/26] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-19-86d5daf2a47a@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10431; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=uVl/jnMHf/rIEGIDroH30UBLplKm0663aOBHd5cNtFo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyO5/H3xd1y8EK+55nGD/GSBDIhp1smij5FX
 BTxjBnaZ8yJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjgAKCRALcOU6oDjV
 h3LdB/4yuUDk+dClHrlehpqmGalyH0KlzBRSWkS1Y8ybdJJq+KkQvY/miHCBjkgQ2MMLKjRqnoP
 O/aIxMsqUthL29EqwLWD64us5AP+eB6MLXqM1vNOzTf4tV9HE/r6DpoQsGRICnFkmE3e570/d5g
 O1arXB+S8uIJ+sPeX27hI4l1b+pGFEC7inNqWI9lEakYEzF7OuliWogEVENOjXnMajsVo9SuqCP
 GnKMSDdGDrBqzpRXBDffBKl0D924p4EIonLNfFJ+7vZa5sQuPCe8oWqQhbdy6StDadonrEH1BUW
 jpWgjNy15Fvi07SAEehOxHCDx19BvwT5Xi3unHLVfwH9S9t8
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |   8 ++
 drivers/net/ovpn/peer.c | 243 ++++++++++++++++++++++++++++++++++++------------
 drivers/net/ovpn/peer.h |   3 +-
 3 files changed, 194 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9cc01cb0ed72b694e3f56b3f20cd6f7c73929237..f95fe52d84b1767334c3b8a4fe20210cc6f0bd04 100644
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
index 6cd83bbd85a8ffbe8ccb32598db2a5406583f886..40d9520c7d25f0856ca8911e8a1dd55c2d29a7e5 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -113,6 +113,191 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
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
@@ -216,19 +401,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
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
@@ -513,51 +685,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	schedule_work(&peer->remove_work);
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
index 18dd9c8acc06c8a9c9e1393d76506da80fe1b25b..cb3de08099bd7b40f526e69a9591f787a0132074 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -152,7 +152,6 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
-void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
-				     struct sk_buff *skb);
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.3


