Return-Path: <linux-kselftest+bounces-19807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF499FDF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4139728728B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AAC1CC8A6;
	Wed, 16 Oct 2024 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hOoewSjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5171C07F7
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040662; cv=none; b=JohsALqYiEcJR226w1jVUTrc95BXCIPIO48dE8JdKKNEoI0lxUC+gxQuOcf+yRhQidgZydOU7WpGSgb9C5TVRIZju5DIbHF9FrKPIPwHjDhum83CmxpkAaSNQnCj3kQHO0PvFgA6dKMOJKdF5A/UwpmYxQOihDTY89GJo+zmln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040662; c=relaxed/simple;
	bh=SY3TCdP0NF7kMR4g37jWPl3RyDYOMbdiDBRkOrn0Xkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZM4BnIKTUDGgdvdmZ3ZN4E4RZqQvNwVhVYi2OtO2Zxzufz0ySOV983gqJ/AqeMzFXBtsIpr2O+Sch9zKLDWDjVyKCwqSeqXpouYWI5Mfi9sfuwRB02YVQvyPj80kfxMRrameOB1FmwmqFHTeCHBtGqH/LhHxH1TjnJEGkoyoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hOoewSjp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43140a2f7f7so11183355e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040657; x=1729645457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZM55HSOTJuT4mvFK4MBi2MjDdJ3YZMBF8e95H5jr4U=;
        b=hOoewSjp/PYMJVxA7kDHzPEURb8kerj3rp4Jc2t8p58Ntqs3ciNrZ1sdBQxS5/IB3j
         DlRxk16U4ZLhzLPHJgnB5445DTPVPUKzHg1hVwvDZMKtd8tT84giAK1kpMBKs1QNvK5c
         RYWH9rgzxLtRXJfBqvv+PMB4KYWHJPaMXK8jw6+rfsfHAJ4IlYWYwG1y+grU4C6ye5yf
         sn+Z0/lGUHz6yTKGCr6bwI5eImfJUiMOJOTmbDurx+s2aMDLWhafYgo4n5IXvrObSpYD
         W9FMU76bd32WkTYT/9f/iIZTuIzYy0oSPOxngNKun/EL9j4J+xTtTzZqAIn9q7o0Zo8f
         LGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040657; x=1729645457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZM55HSOTJuT4mvFK4MBi2MjDdJ3YZMBF8e95H5jr4U=;
        b=izLWZZvrJkNfI+xPd4l2kEMiB3YNfjfTcIcRbcKfrEo4gi4BpHk1XPTB9RUfK7+nLm
         VQzDAZkVd2DeInTHwOVhJoH7gPZjAy2VrfngOyIEnJzVGbBYhrCbGZlMpLU6+87jm5N1
         CS/AKIRNdJEe1I7iBysQKxR9xWpgpC9EhPU9GOS5EX4YzV9N1l7muK4NJFlHQ5VOQIpT
         sabQbEnplKn6EeKHbE3I9cXidPM1waK/3upbR3gYCJ9BKuok5/ElDFYNuwrwi2UG5G8F
         IuHyi8rrxYvon9AvsMVvfME4nEF2PqQynUG580doHTWAkqbz+qB9RtL5AZHDAIw4EgSD
         hWPg==
X-Forwarded-Encrypted: i=1; AJvYcCXdqFkf0pgz0nGe0LqOnXHU1IEJ5sqnSeKzO4Zm0+Cu67X8vb0kIZiqViE3K5FMk8o6GCgZsve7/EIerAwQXtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZ9/vx0yYNCmibx7LcYWpCFBh0Wnod6Ug4tPdkQFvguSG3JuI
	vBkxNiztiIW/yDfJZyJwqyg8K8M8zN9C4a69UupzrlootnpZKbVG9BTcDMkjPH0=
X-Google-Smtp-Source: AGHT+IEHNCrmfMjvc+CWDM2qtFpZfqiOHDDg1SVLXZOpeuGbTYaqTlMiRiVN/ZpDloz0+T4oeiDq9Q==
X-Received: by 2002:a5d:444f:0:b0:37d:525d:5a60 with SMTP id ffacd0b85a97d-37d86bb6707mr1176798f8f.8.1729040656718;
        Tue, 15 Oct 2024 18:04:16 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:04:15 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:17 +0200
Subject: [PATCH net-next v9 17/23] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-17-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6779; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=SY3TCdP0NF7kMR4g37jWPl3RyDYOMbdiDBRkOrn0Xkc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDwQU0vFcndi20RyanZbYXSZ7N9SNiwIPS8e
 Bl5uJicTnuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q8AAKCRALcOU6oDjV
 h8CFB/9/EQTOqELMdAI3jl0b8ycQfqgeuRlTaDAl2h2/z37m7hgq5HlOREzfwjODTh+XNyUR/dR
 G3hKVM56+4FUMB01XTN8f5mr70u8whx1eKFB5eLgeWasVl678pVcwxAwuiGf57m7CJNKrre5vAA
 AcCCnZ+SilCEMMP/92Q/2u8R+YTnRz+HNtiq9/CdYozwdj6Al3LtTNqk+6sfmSlybb1zxeVBSbs
 W/2TZG2hNx9dZyPi8U2rdNx+kM0oBV1c8ibPpuuP5HT7LeS233GhFbDhpWKw7jYKGyzL8toNxYr
 IoQgxuKmq+561QTCF+kaecIP0yLiF/8Eh2OytIX2F1RbXmlF
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
 drivers/net/ovpn/peer.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h |   2 +
 4 files changed, 136 insertions(+), 11 deletions(-)

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
index 1c4cdbb16df4acc5c87707919c671f7a84bf4295..c857ac9015b75530cf3ae40f8db0d4db4c08e2fa 100644
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
index f3b20a561d614da98a8bee80272095b15bc6650d..0718051bb57d2e874e0a4e873ee24ab88eb3a38c 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -94,6 +94,128 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
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
+unlock:
+	spin_unlock_bh(&peer->lock);
+	rcu_read_unlock();
+}
+
 static void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	if (peer->sock)
@@ -186,10 +308,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
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


