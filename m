Return-Path: <linux-kselftest+bounces-24266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B54DCA09E01
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38260188F98F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA4227BAD;
	Fri, 10 Jan 2025 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UYUvcjjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355F227560
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548003; cv=none; b=eHiIdacL1eAz/KUQ/fAmYgO272utEsWTk0Jg5DhG7mz/u6CgU2G8xL2WHe9WZmIiAMsdX6GdFvmkYiLa8F6fdfs21xMC7JLdz+p1grYcbUPJhe6fhOdKZIifYEuOMBwole9JC4nwtV61h9sRDKVljwP2RKxTyiGzTNi/TAE4NWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548003; c=relaxed/simple;
	bh=vwLoLN4YnsgmjdqopQeYZlkHRSINCMrVRTtH6vQ7aO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8YCCiriZVUkReIIGzdB5/Q29n+Ezkby25vFZgirP0UCHEBMYqthvc+IBy8cPk7o0mfbI26yED5ohxFzGTlFw0VrKlLgHtY6dBYNzjcAcNPgbcyDTIF/1KMOHtsAlUeudSQeCtTOpLyjQP0AWKJP6xX9ppp1EoHkaJMYqSCtZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UYUvcjjp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-386329da1d9so1359660f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547999; x=1737152799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmxVGPQVpj5AgYJ+ZtTOk0PH40+Jbb8Q7F5gvxbacyI=;
        b=UYUvcjjpLEAqJJIiSAHUfc7uKOxKeilm+ZyOejbK+4b1lqJ2EFCdyD/XENlbubA5qR
         uosEZxszdX3gWMzDAAUmczDUUuQXV4J3AqZKKrUKEFbQivlWKkuxccbvfBKtnXJmwLyl
         IRBUSoX6nEj7NZeYN/PkqJImLHXK0H/aKNII5t3tP6YxWzuoOBz4VLzyqi7nXGQGLSLE
         Sk4fXXDgYLus1ycRGP1bmozUyIVCFVYZTRa8sN73NAswWOKrBNqgvAVuUCtdDdeIBGmu
         zpAkFlkkrMsoQujPFeOuFmdSxwemBMBR5DiQ8jeyGw0lGJQ5FeyC9AJvx8WG0Knx7UDY
         Mq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547999; x=1737152799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmxVGPQVpj5AgYJ+ZtTOk0PH40+Jbb8Q7F5gvxbacyI=;
        b=jDGTTa8WwNTlsdZdYCfpbVQWu52AXdbDome4XTJv2tK+pEJLfqWEf/6BHlk05COEpk
         PkbwaVy7eFc4mgFDtDb6G3r7IcyLexxcMBsDnpxHenabB8mBrk/YVp+Pg7h+ZP6cEscI
         H8py7YmDw2SEPv6D4HNTu8WLeENaQEGwZOn5+fyssMUiqX8WB0kakn/mbTPqBiN8UKfs
         4VAppWL5zV6B7zDvgdkQYDh1FqzebKUyKfYpYOGgc6lMeZM5MYVarFv4qQHGPoePHmdj
         hn1vfxJpoMjLNEAtNxm4QguhqW0AYwAp+NAe8bHHpCqp/bLkoluI1ZRL5/jI0vHWrOdI
         l0fg==
X-Forwarded-Encrypted: i=1; AJvYcCXwzjWUltkd7ayJ25g4ikEvndt4+Am/q/IQjKRNmmx9BCl785G6BCVQDqvqE9treVuqh//nPCDsWp+BJ5sPJ1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyyRlMRaf66pzwoopWruaBgm9iKOPmy4tJJNdwU9FfbENCXhB
	c447bbRgKH6bd6CGbhO0lcMMc/GtCVCRnDegi8KEcUc+PiCVCYfEi1ZTNqyp+Blm3QcgKMP/jzF
	L
X-Gm-Gg: ASbGncvrOsmATfoiXk26eRNDs5brhbIexZLr7xI3icjJBQ5FHLz2lrx0uW6vclNbR3n
	nomgPdLo5KQk0kvzlmHQRTChVQVUgmujBR9aAmAM+no4/bibrB8rKJNfgzEVW5kicWOyLMkyojq
	zqhgx5LFJXReDClDvduNvOeD9b7xMy75c3zRU8ck9mEr2fy5IzQfkCs+cFjfAw9keoA31xmYUQV
	rQ4GFaXGRoZRltP0e4S/zjlaewynUDLXVwwWNh/0+VpWwh4gRKgeEr9DhoUTgQOhXpn
X-Google-Smtp-Source: AGHT+IF6GGDGLNbSnXxoZLpfGmOkYYekQAsBX05iNqKD5czipmvufc74zVBXUTSagjoxgmxZZHSsNA==
X-Received: by 2002:a5d:6da6:0:b0:385:e3d3:be1b with SMTP id ffacd0b85a97d-38a872e8f19mr11680615f8f.28.1736547998787;
        Fri, 10 Jan 2025 14:26:38 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:38 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:38 +0100
Subject: [PATCH net-next v17 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-22-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=vwLoLN4YnsgmjdqopQeYZlkHRSINCMrVRTtH6vQ7aO0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6yWptB1K7j8qbw4iJKUxdPx28JssTb6ITS6
 NelqAeH7vmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesgAKCRALcOU6oDjV
 h9IPB/9jRmrqsBoywvqqamZTSIZLAvJBGgm9lZ3W20//W6YapGeS9WQcvbq1S3MtyqxoWBG1nyU
 ChY1Gi9hGdLX5TYMVaKXJoQyNZUgThqhBdalOmqsg2Ch8T1sOKhuEBC9dmDY0DTCq/n+LMb57bq
 4aGVJjEX0Ch3PVBX75bB8kcjf72yzF0kZJSLQHsATL1veKiSisMv+5F0JwSybZevnPc6FWwdjKn
 fbIhrGtTztNtdePAtUO8klr6n9VF25TJERzRbtMUTrapeKiM/HgAJy/r7nDUf1zvEW3HrdDEnWH
 qlYDrohZMjAUH6V2y/qBmz8gGfy9daK5XW0LzW8X9Z2sFOqw
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

IV wrap-around is cryptographically dangerous for a number of ciphers,
therefore kill the key and inform userspace (via netlink) should the
IV space go exhausted.

Userspace has two ways of deciding when the key has to be renewed before
exhausting the IV space:
1) time based approach:
   after X seconds/minutes userspace generates a new key and sends it
   to the kernel. This is based on guestimate and normally default
   timer value works well.

2) packet count based approach:
   after X packets/bytes userspace generates a new key and sends it to
   the kernel. Userspace keeps track of the amount of traffic by
   periodically polling GET_PEER and fetching the VPN/LINK stats.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c  | 19 ++++++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 13 +++++++++++
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 91 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 6fccd73c6cf7d2566d1b819cb6d5d7b2ea98e81d..47a627822e95e3a1079a710c66037ec74173e653 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -54,6 +54,25 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 	}
 }
 
+/* removes the key matching the specified id from the crypto context */
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+
+	spin_lock_bh(&cs->lock);
+	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->slots[0], NULL,
+					 lockdep_is_held(&cs->lock));
+	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->slots[1], NULL,
+					 lockdep_is_held(&cs->lock));
+	}
+	spin_unlock_bh(&cs->lock);
+
+	if (ks)
+		ovpn_crypto_key_slot_put(ks);
+}
+
 /* Reset the ovpn_crypto_state object in a way that is atomic
  * to RCU readers.
  */
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 87addc7bf07c02c3c23da7e6d1f86249d1d867c6..30df70525bbf106a70da758532f1bd6ef1a02369 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8162b12f7a36b897d685c70f1befd87d774826a1..8b9b98f9e962f17464e9d436b23c130d9ca0d764 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -244,6 +244,19 @@ void ovpn_encrypt_post(void *data, int ret)
 	if (likely(ovpn_skb_cb(skb)->req))
 		aead_request_free(ovpn_skb_cb(skb)->req);
 
+	if (unlikely(ret == -ERANGE)) {
+		/* we ran out of IVs and we must kill the key as it can't be
+		 * use anymore
+		 */
+		netdev_warn(peer->ovpn->dev,
+			    "killing key %u for peer %u\n", ks->key_id,
+			    peer->id);
+		ovpn_crypto_kill_key(&peer->crypto, ks->key_id);
+		/* let userspace know so that a new key must be negotiated */
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
+		goto err;
+	}
+
 	if (unlikely(ret < 0))
 		goto err;
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c90ba3711b3edeb6f6f867048dcc97845b7378db..6f637ce68b4524c248d4015eec2136d5e4495d8d 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1047,6 +1047,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
+ * @peer: the peer whose key needs to be renewed
+ * @key_id: the ID of the key that needs to be renewed
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
+{
+	struct nlattr *k_attr;
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_KEY_SWAP_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	k_attr = nla_nest_start(msg, OVPN_A_KEYCONF);
+	if (!k_attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_KEYCONF_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, k_attr);
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(peer->sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_register - perform any needed registration in the NL subsustem
  *
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 9e87cf11d1e9813b7a75ddf3705ab7d5fabe899f..33390b13c8904d40b629662005a9eb92ff617c3b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,4 +12,6 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
+
 #endif /* _NET_OVPN_NETLINK_H_ */

-- 
2.45.2


