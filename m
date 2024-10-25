Return-Path: <linux-kselftest+bounces-20645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C19AFDF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009891F246F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32BD205121;
	Fri, 25 Oct 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FLpEJFQe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97992036F5
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847722; cv=none; b=qIEBSEjGeEA/SWTLGKVPQ2K4ivqBTAHQlx4vFozvGCxLUyOiH8fMKHbq/Mom2hd9anRXXpC+EnUeNuI8m44QQ736QulcfgtFd5kX3P9gSVC5AuiSODCLlQu+62wHBPLLRFb7ySFPJRtZrMAoRQLeu0k3TqSIJQGE9HTZs8j4RXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847722; c=relaxed/simple;
	bh=EM1n5XLP46bbcYieB0EmGrRjiLgTqXNxQB8X9Bg+dYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQnRMYpaZxUVRGgqEfGrpKJL4dv7aV7f648oZJFhCF9TXE44Z5WYN9BTSYinriCAhKdWkgSPago5uaVQRnibx8/AAoYBMYh8PA+BNINctH/I+K2Gf3BejnJZt0El+1p9iMXdtAsvdhYTLYVOVA+YhCaULo+nqi+k3E23I2iMW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FLpEJFQe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431688d5127so18211015e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847717; x=1730452517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HuX1GHq5pWI7tPD2JZWNHEsgeBv5B6S2VikoBpUMoI=;
        b=FLpEJFQeNv+qC8+MYxHSj94ga3kVIDw/4S6nPBuTDCqkkNG+xoS5AueYABfzhBE/BG
         SQOM+oP3nz6UMp3r7lkzWcHnJDIzUrBG4Il5f2K44U3q/TrMCHjBznLJZwxE4Oi9cYHD
         RFhrJGL4UilEjpMFkl2P2lk0d4p3hKpqb3db0wDXUZDxjATpKgmsVz22OJ1cOaDruobO
         zcKNATGodzIETLy9iZQB3yXf/gCtt3jqXU5zBmnX/1x/pCplUTRv+4fydtZp9XEgPMq7
         bPB/W0u+6TW/v8zG4mcFVMqNqsM4Te5n3B7knrJclUG+oj48UsVcFrS0zj5cU2zatmnw
         hbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847717; x=1730452517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HuX1GHq5pWI7tPD2JZWNHEsgeBv5B6S2VikoBpUMoI=;
        b=qrL3oatc4Le17xvNcrKAtWBEL/EPvUBw8hwvkvtfbA1URsuzQUxPS97kixYX16K4J2
         DA9ZSTzWGs/NAeCFZFNr9muogg2ev0hW3wsaQqcreT2xcz+v+KGrQEnXDTlKh/HMHfke
         v7V9nkNuPJZQcCK4p2E1D9Q/6P6vOp1kiN/nWTF1b3FIpJijFv3MXzdFOZ/T2Xsdilb4
         xxWi1A9zglWJ+jOw/hCoM5oQlsBO6J/BbvwwmGv4xeBAH8VGpRZ1fXbVBURTtLrpDB8k
         uSCNP6f+4jzD9s6c0vhM4aLfv+GTKQL++tSdcBvM/j1rN4ror2zqhMFTSqbUXPYQHy6L
         D47Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTo+ivvvZVfwcbbabuZ29fwdB6WjgA4q1z/dbUgwTlaWmFYNlwAjZtDWUYhwnaz6eKIVWPn5JNgH5rfDnxUaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwsIOgJ5XZgTOOLHxPp77VFFDXudKDFobGl4Tv77Z0whiAhbDu
	xTJ4ody5Etgl0xlcU+LqnMNyfkqsuybyvB740Fv+yGYzW50Drk0/ijoPCkwA7Uo=
X-Google-Smtp-Source: AGHT+IEqm69d/t8TSxL9SEucCDp6LRL9ZPkPUDda4bj7bHSfjlLtbyYnplH4J3IZYmDwgg2stuBv5w==
X-Received: by 2002:a05:600c:1c91:b0:431:5d4f:73b9 with SMTP id 5b1f17b1804b1-4318c73a475mr47669715e9.26.1729847717073;
        Fri, 25 Oct 2024 02:15:17 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:15 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:16 +0200
Subject: [PATCH net-next v10 17/23] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-17-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6844; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=EM1n5XLP46bbcYieB0EmGrRjiLgTqXNxQB8X9Bg+dYo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GaZKFBQZBg/wFlHoiZNSHJQTbzMj3I2Z1ux
 tmEOMp2msyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmgAKCRALcOU6oDjV
 h/uPCACIfdBPreUkQynULHjX3TLO/XpYoavX1qxmiRVBFFhJA7McRHe/C10XyI55WyeReKIMhPx
 f5avpMotrq83ODklrFE9PZY5HSqOTsn/KeT7EmQL2+jXQx6ID6lw66RanWscIpTtwy9L2XEY+js
 Bp5ClaVo05FlyrHZU5g/HGtYA4qsKjdcQBj/FA6vFRaOF+2l6bDwbD3TZTQzxgH7mI436MJhOcc
 CdNQmdlCieW019UBjhxgGjumXSGZBCUj4/Ij/EjCuuyssM95oPCBowf/n4P3J0QEwxabaZdjAr6
 owRIYfB3rREeKB+jnDobAPNsvUppaYYXverXLPvLMadCHz0l
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c |  10 ++--
 drivers/net/ovpn/io.c   |   9 ++++
 drivers/net/ovpn/peer.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h |   2 +
 4 files changed, 139 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index b4d2ccec2ceddf43bc445b489cc62a578ef0ad0a..d17d078c5730bf4336dc87f45cdba3f6b8cad770 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -47,12 +47,8 @@ struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
  * @new: the new bind to assign
  */
 void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
+	__must_hold(&peer->lock)
 {
-	struct ovpn_bind *old;
-
-	spin_lock_bh(&peer->lock);
-	old = rcu_replace_pointer(peer->bind, new, true);
-	spin_unlock_bh(&peer->lock);
-
-	kfree_rcu(old, rcu);
+	kfree_rcu(rcu_replace_pointer(peer->bind, new,
+				      lockdep_is_held(&peer->lock)), rcu);
 }
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 63c140138bf98e5d1df79a2565b666d86513323d..0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -135,6 +135,15 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	peer->last_recv = ktime_get_real_seconds();
 
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		/* check if this peer changed it's IP address and update
+		 * state
+		 */
+		ovpn_peer_float(peer, skb);
+		/* update source endpoint for this peer */
+		ovpn_peer_update_local_endpoint(peer, skb);
+	}
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 3f67d200e283213fcb732d10f9edeb53e0a0e9ee..da6215bbb643592e4567e61e4b4976d367ed109c 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -94,6 +94,131 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
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
+	__must_hold(&peer->lock)
+{
+	struct ovpn_bind *bind;
+	size_t ip_len;
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
+			netdev_dbg(peer->ovpn->dev, "%s: invalid family for remote endpoint\n",
+				   __func__);
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
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
+
+/**
+ * ovpn_peer_float - update remote endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source address (remote) from
+ */
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_storage ss;
+	const u8 *local_ip = NULL;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	sa_family_t family;
+	size_t salen;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	spin_lock_bh(&peer->lock);
+	if (likely(ovpn_bind_skb_src_match(bind, skb)))
+		goto unlock;
+
+	family = skb_protocol_to_family(skb);
+
+	if (bind->remote.in4.sin_family == family)
+		local_ip = (u8 *)&bind->local;
+
+	switch (family) {
+	case AF_INET:
+		sa = (struct sockaddr_in *)&ss;
+		sa->sin_family = AF_INET;
+		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa->sin_port = udp_hdr(skb)->source;
+		salen = sizeof(*sa);
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)&ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+							 skb->skb_iif);
+		salen = sizeof(*sa6);
+		break;
+	default:
+		goto unlock;
+	}
+
+	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
+		   peer->id, &ss);
+	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
+				 local_ip);
+	spin_unlock_bh(&peer->lock);
+	rcu_read_unlock();
+
+	/* rehashing is required only in MP mode as P2P has one peer
+	 * only and thus there is no hashtable
+	 */
+	if (peer->ovpn->mode == OVPN_MODE_MP) {
+		spin_lock_bh(&peer->ovpn->peers->lock);
+		/* remove old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		/* re-add with new transport address */
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+					   &ss, salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+		spin_unlock_bh(&peer->ovpn->peers->lock);
+	}
+	return;
+unlock:
+	spin_unlock_bh(&peer->lock);
+	rcu_read_unlock();
+}
+
 static void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	if (peer->sock)
@@ -186,10 +311,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl = &(_tbl);				\
-	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1a8638d266b11a4a80ee2f088394d47a7798c3af..940cea5372ec0375cfe3e673154a1e0248978409 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -155,4 +155,6 @@ void ovpn_peer_keepalive_work(struct work_struct *work);
 void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


