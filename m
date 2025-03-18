Return-Path: <linux-kselftest+bounces-29323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B33A6657F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDD188C76E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494971DF990;
	Tue, 18 Mar 2025 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ksk54b+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FD1DDC10
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262088; cv=none; b=sF70yz22ubiIoPX4DImTCOL//uXTa2+IiifA7ReZquZVm16UHNxq1GU5/7LAwWdcYR0aJkuIQQEWdStc9oaH/jcjeNKvbWaslBWk1wWq5q/rVuRCNIIO9Pr3gxNjyM6S+1sGF0BySeZ4FuEVMzVAk5ip+SHQudOr+h2HanrqEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262088; c=relaxed/simple;
	bh=0Ct1EXaLi0EA09Bg5/0/MSSXYNAJL46agRawkihgLqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpvcxFUkWLxTO2hRLcV5sfCo6mP6AmYNE0dWbKAIGEurcYdBdoKUAqBJC9LcV++a/E2A86aybPPgCzAxucPbBtJ0vgobxfMslEL81/izxI6Z58UHdaId7xYWZ2BY5OxIczRmIWfAvyMCFqnR2hjxIwifXTyzz26J+kuGpdHlNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ksk54b+U; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913b539aabso3184079f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262083; x=1742866883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sH7/PFRE3oKyyjZaXR8B84Mur5iz2fAi//BdVT23RzE=;
        b=Ksk54b+UZIhGnPzipssztQQZ7b0NNYUN3mT/HQBZRM9JcclckjmncyfqBgKECj9TiL
         dmOm2m3AWPRRjvqb82UbrViuJIY3CTSopN2PMBK1WZTRuB0nAJyIfM8sy6pHb0Z9YMR0
         UPr5eFuKRzJHeTWLBZNp1XCAj+Xcy0R+/4A29iBcNAdM0Z1FWNUheCCPB7SSDDc9kxWV
         Lwu8jVTkSBwz9Y+3+7foHx5O/gEjN+bFwhXjoR6q5h4R/OWk05k5EpCqF98wLQV0h4ub
         3zyX9jF1cyvcSzt/+Ojqbp9dddxChkH4b0q6jJ02esHJOjZJ00M17Zvgi4c4R5zSnII8
         uQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262083; x=1742866883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH7/PFRE3oKyyjZaXR8B84Mur5iz2fAi//BdVT23RzE=;
        b=ke0CEZW0aGiFHVRkj3yGTDfLXi7t1O3swSnHzjY1SAIK68HNMDNpX4fnKbYahf82pl
         z9gMuz1nX5p0cWaNeClOJZJ+fNMpwGFxBKHbeWvYR73SWGZdBg0C4tJcreJjK4Q6gg3S
         2H9wxMs8rtZ2IRbckre0BUYV2Uqmwo9NLMFd5HARMfMqilqWWIDXfrbyWl4suBnnnOv4
         xUvjM64pYJIvH9g7y9lyXJsMDXrOXkYIHkCARCI4gIsuaf6GRFIYZrtv7DkRKHQDDmfJ
         87VcsFKNJQaP2WDux5utVdd09ZooJLxSVFxjW/vTmsIGRtTNGVr4fQRM3WC0nCDax1Nm
         OVdg==
X-Forwarded-Encrypted: i=1; AJvYcCXb6zc4kLiwLeLk3PIJkS1KXwJjOel2OKy+osTXbsVKE2XWOfgKgOyJne0158WHwHbYuMzJV4mdYMGhGgAPh5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVheLJ0XKP2ZXNilKQhquMfswLUb/zrP3bB8IEb2VvAZR5eR3W
	beqMfNHTSF+qvATIvNOnDT79UK/9V3+kKZ87noPLrFJbwdC2iG34BdCq90T6JRrrxPoHP55mDtG
	c7d+hQ6HJTI82OcpdtjEYAiGvwDe0dqNdgbQC5yIjGSrungOX3TiS+nuNWGw=
X-Gm-Gg: ASbGncvdEQw0kvR6CbTMR1nnYierQN5zhTZlXr0K/Efr6H2FhYdc2wOU+uyNVmT4ySt
	W+7Yi8WSgAhU+viEQDMqhQjlPlFHTGyLqCaNqXVhMc3O3VjtVtHZyfYj8i/P9BiUFWOz10m5Fje
	+5S4aaUcC9grtUyWmpvAI6WVNUOfX/rhuQUF+Xzj6l8gHoXb7Ndkd7uM3C6zy0GBX4pfCoDkpDn
	rh0lVld+DNQx8UVZsJIrC0hHuvyWMLk7FHuLt5Nb4AsUQKZ6apK4in/Q46NhcC9Nz339XMQVl8F
	8kC2oMcaj/6+R0rju+Ux24oOK2OAo7jLFIxHrUINBQ==
X-Google-Smtp-Source: AGHT+IHx2Oo6Xgn5NoS8FOpph3pZnODvy8HVWLNv8ZgQgvwdDU3O8wt0larsR73Q4JJ0zwHQiMUjdQ==
X-Received: by 2002:a5d:64ed:0:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-39720d47607mr14547209f8f.46.1742262082929;
        Mon, 17 Mar 2025 18:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:52 +0100
Subject: [PATCH net-next v24 17/23] ovpn: add support for updating local or
 remote UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-17-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=0Ct1EXaLi0EA09Bg5/0/MSSXYNAJL46agRawkihgLqw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8qSWM855bYhV8AMAGqID3iAM7t8y1kuDat+
 qMo8gl7AeyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKgAKCRALcOU6oDjV
 h8DtB/0cKObFLopkJQ10fsffYbC6JNnAvQU20PmpkXsF4s0W7pZJkofyWfG8xyZoDfS7ovc594/
 iAQ3PgNbWG1+nh5I02yEOqfXHNCbpcNGjpuRk3mtXQ5b3KrZRrpPzpJJZtayXJ31RwEiZOPl1iE
 iNyThLBSaIsBEAK2pZMkGyyB5b+xhQ1InGrptAvFDVcKPnd4djvyjwlMXcE0KglYYZMlCJy695W
 JU5AaPmh+lsUZxUs+6hQTLkSKSeXsyEf+3o3LWsj/98VUBIeX2Mfs4HFHZT9v1lp2TXl4YqVZye
 CYWiiETH41TJQb7xBjcU652jAuSOcd6WF0RWmZi6apvAJhA4
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
index fcba094ed412068af88cf74baa82ec2742e0b634..49bb58868053e2d1542a8a5849c4bbc256083efc 100644
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


