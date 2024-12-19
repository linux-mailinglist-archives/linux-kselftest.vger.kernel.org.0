Return-Path: <linux-kselftest+bounces-23563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDB9F7229
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6396163C49
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028371BEF71;
	Thu, 19 Dec 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BBTsDQVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CE1BD50D
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572566; cv=none; b=GvERX4lsR43gH/mdDQlO2ePj2YQJdLur12E9JdnYSDK8eM/4KHJ0z/k+ox+1huLOq6aSCcNV/Y6uc7/P2+HkH8NoHEhBMUeYsNIl0AmsxhmUHInt3/VFXCP2JcOVuqbs5zhpxj1ueg6XH2TiWrOeHlwEVX0dFsidENd6d7BlBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572566; c=relaxed/simple;
	bh=QAA2RLNQHUmK7adEJ/c3kAWoITrR9Y54QFq1f+CgvYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2xeF0BJ0lESmnT0r2v9tIm3PlGzc6VYSNLzYf28/0lXdXiKfSSq4EJGvPNQto51WKFxnxpxZ+VF1lOVk7VixET3DlSygluBg1C9CNYHjhGjZ4ojIMoj2LwI5nxn9zRc2eIuxF48yWk9gUL248MaW6pOn44pNSBDm6YIpUwq21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BBTsDQVQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso1703725e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572563; x=1735177363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nf5egR9w2J8HMroxA9BaHZV1/8vLmQZyXaZjDDlVusQ=;
        b=BBTsDQVQ4n8xd3QoEr0A4eLSbRsQQftg7V/sCZ3g+RW0IB08urMxNxb1N+GYHsshmg
         TEtYdpNSfJw5wAXOKQgJf2JY2ilw25v3GcUHEhuZg6OUpsOFdjDNyQB7ac3M78LLrmA8
         Ezf+FjdzBlGX7Ea8Y7nMrlZYssDbhj1VdPvUwskHtQOWjxC974il0V5B6wd7h/BfIbaa
         Szct13jXHn4AAQuSfo47HiBmw0juCUDGs/zA9eGJSvj8IOUDiwnlTsAHnJaAZPyJoc5w
         am0VrZldEZcZBiAdCVAJPOwzMyhi33kgzXsvIFLQDzKrhPCRNeOf0fl3i3mA/38MLFnS
         V1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572563; x=1735177363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf5egR9w2J8HMroxA9BaHZV1/8vLmQZyXaZjDDlVusQ=;
        b=NMZH3TjbTD1M1nXZmsUEtm583rFv6B9VPZ34lT+dQOSPfGvYAmI3l1GmhUqBZn7Ffi
         pAD7SJ3HHXzZLDyDwF52HlQ6IhO2RgK9r8NenaCyqX/rcQMntMlXa0hk6qbL5sJrx/Mn
         ne6hsf3b7DUnxptKqfQSUA17aXv9jqN6NrTRPBRwB8DbPrHEOHqWIE14J3nNgnQL3pvd
         j947egojJxlZccDT8zmjESghnG1CzIpeXA9ZIx+8rSaTqSgg8HD60IAnFKIgcpcpCLDU
         M0eHh4mdkifufRTHHOCLe3xfTc6yV+W8Xl+63/+zo9ynSuHdwJgj+pX0ebEGFCpc4A7x
         k+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXxCoW5K0gUksfW4zuR/xehYmu4I48dzG/uAeSl6OM/phTJ/u12ttzXFoe/rtBoR3KSspVCEvS2Blt8RDvZs8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5xVa8cn4PtX6ItS5nklwCPF02PZ9n+vfKoVSFrurw2NnMpdz
	iQsA5sx664fDBW29JzSMHTc8GPoM74qHHgfhcB1/4VcsHz8076uEyQlvVpTzjEE=
X-Gm-Gg: ASbGncu3lyGipAnBHf/bVZ7Tdb+ARXUF8R8uQj4UqYQOI4r92FC9ULeYGJxh92/PEJZ
	JjUPeVtWslHyPmGXEdlbE0TxW8nO4apT6AvlpRsmobVhKleEyLPqbnIgEHXHVQzHOJnkVrb1JDq
	KprdyufOVVQ1e2XDTXiASvfyg9GJWsYehWLKI0s9UFkjSWxCKhz2mhaiSHK5K0fW3CY5mkwhGrh
	xUq3sCDND6Dw1yRRTbjEZmJ0pPaV5ILBHRzSgs5A4iTsCEdQKMSlG9e/V8GauDK9+58
X-Google-Smtp-Source: AGHT+IEk2K8MMCNQqgjz5FtkQsbVeGWWCylpAkF9DBZ9czxOFUHQCxKOrp8L7ZF0/8/jhPuSP/4Rhg==
X-Received: by 2002:a05:600c:46ca:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-43655426bfcmr42403635e9.24.1734572563036;
        Wed, 18 Dec 2024 17:42:43 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:40 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:17 +0100
Subject: [PATCH net-next v16 23/26] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-23-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=QAA2RLNQHUmK7adEJ/c3kAWoITrR9Y54QFq1f+CgvYk=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oXmQyfjo03fg4xx3xIcMPLo3rGHWvzJH52y
 lroMKNX35CJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FwAKCRALcOU6oDjV
 hxeoB/9/93g3xAXGS4NEIj4QaQ/kp3tVV+iOA2tPQXpqCQYAFuYukMRDfnNDw/ODweYdjqsO5T3
 1iGanO5dUG5T2BY4+SVN8uEutKt44XIQNmtOg/14fPWmsGw7en9Xh+TN3CabApu9/OKIMdULq1S
 j3sRJu5oi4R5Qd/wwE1mXGdTcYKgk+8D/b4GzCc+8a1AGjFEufwbxGpfQiLWwrbC/PC9d4tF6iM
 MPmMyWz6Kg7IrOIUbcmUHqqTWxcjFmIY1iNaUsEWlcsSGIiRvG0B/Ma8dafothg8yNqb2pdg6kt
 uIGnbENockSpPms399H1uMIINC7+Rbrozx2yVGmrSFsS4cTJ
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
index 5e9e8a3d8cc043f369ccf01a57b43b4fbc495212..266a54485ea00bc7aa333694c3886a2c3a1a8a19 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1042,6 +1042,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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


