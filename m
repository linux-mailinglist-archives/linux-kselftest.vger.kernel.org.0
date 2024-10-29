Return-Path: <linux-kselftest+bounces-20942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D39B4773
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5820284D89
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12565209F2C;
	Tue, 29 Oct 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ceiB7muN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474D208223
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198907; cv=none; b=WWoUG4qlF7ggwiMQkeCHZhjXs71OsdJI28WecFs+AogNt1iHM/l9oNMzuBsQ678Ti4Azk6KM/ieQdVK3orCItmWu4UZc5ql74Uaj3VNM0fB5Ni1GbVJmAsscERgQ2qAsWRprNMruh1HBXl8lFptnPpTGQ/c+O9uYp9CyXYiySTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198907; c=relaxed/simple;
	bh=EM1n5XLP46bbcYieB0EmGrRjiLgTqXNxQB8X9Bg+dYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzMr9cqor2wReru3BIaxgGReQcOHeNVH+ad4BfEsiiaYr2FvMpkn6zTtoC1itJl79Wb4VrTePXqNoahFyrYFwLFPDAcolnLPHwSJtTZ1bQif2blDivjcjggn6BRBHqk9KPyMbmR+1vDVGVQ4Tbt5FhywpuA9nc45GGPqs1/L3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ceiB7muN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so48530441fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198901; x=1730803701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HuX1GHq5pWI7tPD2JZWNHEsgeBv5B6S2VikoBpUMoI=;
        b=ceiB7muNaTHgqTNfAUzcmT0NjdWtIRZVijT3r+Xfeusrw1Qd/tTSMEHXL95NM65yb8
         qRQ8D20AMhZt4eo7j4nNyempQYaC0+c2z5+/QzD63qTDz4GN8ondrjO6bmNiYDj5dhIl
         uveAClw4HVf9i/ygAg2Gk4v9IwxKaf7wFmQMLIvt64gdWlkawxL/Jl0zzdinEyIxgk2K
         g61Aa8qVNFjiNO1Cohz/SLQu1B6wiG4RmmaKAgSmwZ1NR8VfLHafw5zTmiCuelsxiA8F
         vLKE8mByywU6okgdhC8PHLdiwS1/CY6S9sBSuAiA/gJp/wPNybF6hglQ0uyhX4G44TPq
         7hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198901; x=1730803701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HuX1GHq5pWI7tPD2JZWNHEsgeBv5B6S2VikoBpUMoI=;
        b=XRVraWG+11ic41HziDLY73wr6hSV8YILUNFPMEENdR6mZ4L9GY1dBjtgVXuASoKXmA
         fIBxI6zABDsaR+nPLpooraz/V/hbLYlM5hpdpUIMV8a9jb+Muc8/burPHaQUkeSPfUF2
         kklLFaGVYLvk0Xlu2yJ/YfZHU6blaj8jiTKQKCxWwZ96jEJZ+3sxYl49f8mZhOX459Sc
         416y7EsEDgwHEbWNQgeHK0Mv4DPK5/ZUgAUMMasPdCjMYd2F9LllA2azaL10WoEmUIEw
         pidaC6Q4rV1r1zhE9I+NTd8b/xIghkrDtZkG1sjOaBMIwcMaL0RsxHtpf5RZL5MbZTm5
         T6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVVMAMjGNNBuXCtQz5ZNbidI8kXThjWzE2k85rItAIKcffgYJXWyw/2G+4EhRgUjkiUGuavWSQG1/shQlRhgPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4v5qfoknbsSY5m75BT1PQFWULwSxYyqUDQKnLysGp5XdjYJZ
	0TbdwFfA6KmPty3KDjqew9gp+Wy1qSjloyqeiM2WBrXlKCrVz3TKr/IjphNxUMk=
X-Google-Smtp-Source: AGHT+IE0pYlhSUaTN/QmBQxp5C5y8evJdYUSslFxQ9uxOougBniFAhHsPr90aCl6rGQJqGfCCKJgxw==
X-Received: by 2002:a2e:701:0:b0:2f7:7ef7:7434 with SMTP id 38308e7fff4ca-2fcbe095e65mr43431271fa.37.1730198900594;
        Tue, 29 Oct 2024 03:48:20 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:20 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:30 +0100
Subject: [PATCH net-next v11 17/23] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1sl6QOnfFcdHksfhI53f+23XDOT5mhNfLV1
 ppML4GrjoqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9bAAKCRALcOU6oDjV
 h/xlCACY/bgEK0XxuXg1IsxPO6ZuGwhPaYIs8TujPsDIgH09rNMSxPHAUvfSRnpa/gU5B8yyW4t
 cYZyzXnAMttnP7Ia8kacaex/0E/8hmnKbsaVKiQrck3HvkKOWvMpqgqlcWT3Vbwr8Y53BLM9447
 92IqxKCQlIdYSV0OO2SbKCRnH+O9xMfbwhYsDE8S1JAMYwRooM/kMZzig7SU2JAdDfsNIU0jouv
 LZzA4U4syPMu++7I9Vb4a1fArz1FYj0Qyo/ulLMy152hy/uISYMeIDCxXvX+hAiIQk0ztHEdJdM
 plZISfYuQIIq+WaZzX7pdVuvXyaAxodjA7bxlM18ANDFpR10
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


