Return-Path: <linux-kselftest+bounces-26302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80563A2FF88
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2A2188AF43
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07391F03CD;
	Tue, 11 Feb 2025 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fxj9Pxtx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306511F03C5
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234498; cv=none; b=mzkDO9zg+oe6TxZscWDJfKLjPSHFGdhg767GhfiI4k0L2IkR7UVJJ/yArVfjB2WshuXu4Scpwh0wIxsHTtrC3S5SwQu/uvOoas0MzH3A31A2GL4JWNyG5Mlo5qSSe8BIZ4L/EK7bGnDRvupJwRHJFHhWy5E1K07SEqCozNsJc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234498; c=relaxed/simple;
	bh=EYnyLwUfNc/BvCrdAHkp1RmPDq4HPh4r2Zz9vyUOYAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4W6HNNBhaEkpn2uUBeDFQvEvEoUNplDPCwRirZ5zPtBDmyHfB9UhJH93xB32PvJkdVK90zfAj9WfjNAoeIAh/VzOVCQLd8LJofvBWaCdm9vNorEHA+GA87hDqqhQnYR+GFjoefUFJ+au21tRGW61i61o013lQ+awjgzwlQhJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fxj9Pxtx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38ddfee3ba9so1252499f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234492; x=1739839292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXo6xZocIRzlc0t5uNNOuBLNVtQWODldTIZ/hpFJiog=;
        b=fxj9Pxtxf8z8hQgDEzT4ITmrB7SYe9TRKPR7RZn/M6XFjoNmVJes1tWr/X7XFghJFb
         EgfHEXJmvo1Sn+HYyjiXCWuPeZp1lz7DQ1DgoXxWczF9YS9RxlPNbN1qUn8A7y0gD03o
         5vlf8Hg2FXktAwt43BYJnkNWGjGOIDBxGOhSCfFM3RsVePNjeMnR4gn4lRjPi5SPU2GZ
         LFvA3HzJJKDUHiGx3Dwj9RQKxr86kTyrHhP8OMu6qor/PId0E3BA9mm9ESWsCued9zoe
         9UijA5U67toTxyvor4p5Xt51mXhr/iD5XWvrtm0/kowqngyx2aJ2cEcyR/2oNKo4+Evm
         hGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234492; x=1739839292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXo6xZocIRzlc0t5uNNOuBLNVtQWODldTIZ/hpFJiog=;
        b=FP+nbG7z1rVQG/P0qh9UW+jaZ5g9gV+qViK3szqqwqbL9CVpaj8LsAl8gBeW+D11Dk
         fJHZ3NIrNHO1V23OB+gm1WZVOVxN6I83FQfj+mIdsRfjx5e9DgDhYCdvPBUqrkRevcO6
         GSpRfypVKP2+ibrjcdSRJ5WcJM0BgvF0ElBUr/QgVdXPN2VZ+FwVHfkrDeyr7NveBVDR
         gOyKaLFg595bmaNUSAAynndNnQbnfgJN94kdo7buZJKiNldmBwOklxVtKiZ1qyZdvaU/
         VLBIgtOsoGjlNsKxbzTtg46DDJMLbs4VO5onfNLPTGdf9cKEdY5SnMRG7eA3zNON9Qhr
         EEnw==
X-Forwarded-Encrypted: i=1; AJvYcCVtoOUGEIWDnL0WG/Uo89iqktBZxlCr4cSwIqDW2zqNO9qpMh7/HNk8KS7LSQzoN/gSbgbr6eL6WLkGYY3DWhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSbf/r4pgbfo6sclId3a5AzWQxr4A697P+pHC4wAxdTF9KDU4
	TKr02pV3ecDjIWHP39tPOKVYGj8Jfo7pqbcCcZePvfJ766G6MwmQk1S9AXxzHUM=
X-Gm-Gg: ASbGncsMzci9X9n9dYNLB/zlJYcmCYggedrzWYwu62oAdKyywCTKrhKV0Jo2FH2yV/0
	OQCJyAMokLh//7z+q9YGsSQCbU4SdPlxj4KRq4TQodNgi8tGSKav8IHUJd801AYHoBZ0GEnwvqI
	bivdKK1IYbANNq9DR2bJ7rHdKgswr5fZoTVq7i9uN0K6qmivHAQJM1LusbJ7QYIy0kPLdyfrAjD
	aEIpwKwLBEJeE36Q/qCi4hmY7pS9kzbW306ZbnmwNjRBw8/0UotQBLy5z13vVC3Eyyi/iUkK8U5
	C62HxB3tL+M3wKoFqNtPvSHdL4M=
X-Google-Smtp-Source: AGHT+IF2vjnF/mfO7DPkNFP1pjzkrtzpjWq/01kdNjsemhLzW1mYbEpbBZQE8tnX/1U6/cd0ayGIaA==
X-Received: by 2002:a5d:47cf:0:b0:38d:ca55:76c3 with SMTP id ffacd0b85a97d-38dca5578ebmr11616930f8f.11.1739234492236;
        Mon, 10 Feb 2025 16:41:32 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:30 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:15 +0100
Subject: [PATCH net-next v19 22/26] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-22-86d5daf2a47a@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=EYnyLwUfNc/BvCrdAHkp1RmPDq4HPh4r2Zz9vyUOYAs=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyOtwboo9lQ9JxR4Gl3oUGXofAKHBfebzePA
 YeHNlBTzKCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjgAKCRALcOU6oDjV
 hwFNB/96q+tZuOOROCYA0JheQ4UDlewWjiWdn4kt5Q8RW0o2sluOasEsGniLP2mUjq15V3wgBpZ
 swp6s+38vq4PbkYP9AczL6xP1Eb3a6PgaaqB1hfkMBi/C++xDongrJHXjXa83CYQ9sB2bkirUt9
 j4sgNwfswX1UMduAn/XwabCoIxFeoDSbGBDkJzz642LuH+ygjtUuy/U6qSAfDILeHo2GCQRuXCM
 wFi3lrIJ5sxNPz/kcdHHISbFhNPlVJCi69pjdOmD+3+KPa96ZMWPfzKXiZaGtRwEny4vid1DdnB
 DLJUSl9dZwSlpBa6AFQzExcW96oksRbQ/J5B+mlidyhP3ott
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
 drivers/net/ovpn/crypto.c  | 19 ++++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 13 ++++++++++
 drivers/net/ovpn/netlink.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 100 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 5f382d8a46f21af3e9cbbdf5651659c10292e857..8e7cdf8dd8ee4f9e67982f918ab163913a805f3a 100644
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
index f95fe52d84b1767334c3b8a4fe20210cc6f0bd04..4a56e8420c4a8efec11b5ea1b1561df20b3c6e12 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -255,6 +255,19 @@ void ovpn_encrypt_post(void *data, int ret)
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
index c62ac542d6dbd79229d3c6457b5c910b77ab533a..86114e5aa76be1595edfabaedfd8996c2d9398b3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1093,6 +1093,70 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	struct ovpn_socket *sock;
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
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+err_unlock:
+	rcu_read_unlock();
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
2.45.3


