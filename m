Return-Path: <linux-kselftest+bounces-28861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0AAA5E5E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477793B976C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582BD203703;
	Wed, 12 Mar 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fq4/6D3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383A20C032
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812896; cv=none; b=KNjrl2wVIde5rwAYgtLZ3kYxpaPISCxCCf7f8RjwMKxfw83cDqKdnlk10RpcvIpny/g9fCqqbAXHW5gwId+EZstaFrV+Gskq6/UQv6pPrQ69QZ3Qt9ZxB7oaTjHxqNBBPiOrymtviSNOyMWUOYok62sYKMsg/HTjpnRfg/VsGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812896; c=relaxed/simple;
	bh=713g+yJ0g6AOQeSG8hgjY1V7Dkeft1yz/AuoWsjjQ+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcNEYJ1xsckmzkh4ntZk6w+vT+vawinyg9EjlSjPDAztYzFfkHatXXcw/RHQn4+5iLHz5KdNXyBbjELtvDASGvinlJXwZ3senTH5xv9wVQFZsgjeK/Pett6YG4hNMkq+F0t16zmrjoaSG8ortoCSHQhXOyAz8QyhiCKTHV6cHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fq4/6D3H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso1397935e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812891; x=1742417691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6gUk+2hKXkgBC8KMjj3S7nE1zCYTLZQuwKjk/vQ5h0=;
        b=fq4/6D3HOnHobLyLktXvjioccjGaPy72O8yYhWUU7hZncOv9j5JeM3QaAHhHHJW0Zb
         XsfIl9pSoE8LC2oX/jEngQzMIHSvzMrlcSr2Q6ZBygO8W1cHe0HBA7aemftgDDFk3/U6
         QSrQ1JpE9IqRbY5SITf+MJixK2tMr4viu/KFwKQLA0/+3mNNs4/O3dN2TJkADvLMVTzF
         X8c7Rq8Hoj8+NSBYzEu9kWrxyhCklPFGS1V4b3LgwFt5cKlrtpsTE/zXa98F69xFyXCB
         CN0u/Z4P0f0wukp8CLY+UFaRMPmhUUW79Df6G/fpx6ccVUvAflkl+A13syPR9k0Pf1M/
         eL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812891; x=1742417691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6gUk+2hKXkgBC8KMjj3S7nE1zCYTLZQuwKjk/vQ5h0=;
        b=KxlBXRIy2Sfurm1JP9bWHASunUv94o5A6C+88owTs12GZrI66/QJLpKTdYvAplHctX
         Y3U+oa14TuCI5b8H+7E3emAVlcF0Vf7+QrqL8hi5/yGcv2a7sx97VX5dqisGM1kQURxi
         HnYGiUci4j7/ltBp0vQBCGfWTcX+PU0KazSmvgU72gPbIAUFP0QHNnKhGeMTKOI+UG9P
         7UB5765Wy6oXwk2qWREPg7e20rnj+f8IX69rjcdtH1BcJm5w6ioYMatGAG3sn7TGtuJM
         IlTuxK9dyM9TnQXveogrLrxyR+/d0QmAI/Gr9uNrbtsP9f3vsSwPgRUHWNmJsgA197Ct
         QYJw==
X-Forwarded-Encrypted: i=1; AJvYcCUNha9Q1e44oVrwU0dyO7vgvIzxxfKW0fBto/N0LzL5eHQUg4hurYDjIvNEpR19bUnmxGYq+NI8JvotxPVQf/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95K8KJRJojJXrby0bR/mmQwedEqfqAyr6Hh6q5r3arahgL4z5
	dtQKA7ki0n+C3OgVbjsqwxH3/GNKreBIP+2UX76zjaiF4Q9zen2bN4PWEU2+Ryg=
X-Gm-Gg: ASbGnct25zFUKl9gM8KZ3WSe7Wx7mDyPZvGt7m/EKSx4CW2NWqPxe1t6eCjAmwrrC84
	Pbwd7EZdBdwxQxt79yesNoSXVKK9sqOb+B//OA3yvG7yv/N4qBSDC+lyKjloJgLyHdoxBODabxg
	G83XQ7G0JkpC2z5QWLiofPDGHvSRixBVhRb4qx5AjMWzfSKfGWILwIgEauCUE5YL6e6jLD8ZIwF
	24cAbL0nAE75nTCE/zOE6pnA2PkCPa//SScBHnNZeT7AZ1DlplEwe1GxXnppXQc+Q9GWhe5VBJp
	rxAs6Wl1hlOzq+N3M+WoYmxGqtkslmFupEvPJ5Sjow==
X-Google-Smtp-Source: AGHT+IHjgRdKLa6L51oghofk1FbAJ5gjG5NFUzyHGlqm34dgGyGr42lKhfCsr+NLJBxJcsclp4dcXg==
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d05ecc145mr71000445e9.10.1741812891208;
        Wed, 12 Mar 2025 13:54:51 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:49 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:28 +0100
Subject: [PATCH net-next v23 19/23] ovpn: implement key add/get/del/swap
 via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-19-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13973; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=713g+yJ0g6AOQeSG8hgjY1V7Dkeft1yz/AuoWsjjQ+U=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR8LmyYXqjnqCNnB4b7K1zHAajEnyYTcWcok
 Rmb9X4h5c6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 h9KlB/9kGgGvU95OcsZ56CLsPG4uwhzLRyOqny8rxjCZrK6ezLDD7qUrVweDDGxwa50DlQGP0+z
 bmS6S5W6cwKt6EvFEkO2SxD45diPcn5ytpwBW0l4hKi7EAzVKcTbF70v8am1NG4gm3s+iCTjsaS
 j+YRZP8pjuPvrAgR7AkmqLZkzPvZPIGb4uqNciPuY39Imym4/O0O1i+lEilOFN9u2NCXSFMZCr3
 YhB+JM/SCTVFDLjZQNi9ckmSAKD6MOuyPFS4G9DGNv1XtZWP6aq97Qmcta56H6yqpfWe7AcgFqK
 fq9ZYpF1L+W6V3b5Cbn+lHlFW/udxEYODssytG3AmEijzNQB
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink commands needed to add, get, delete
and swap keys for a specific peer.

Userspace is expected to use these commands to create, inspect (non
sensitive data only), destroy and rotate session keys for a specific
peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c      |  40 ++++++
 drivers/net/ovpn/crypto.h      |   4 +
 drivers/net/ovpn/crypto_aead.c |  17 +++
 drivers/net/ovpn/crypto_aead.h |   2 +
 drivers/net/ovpn/netlink.c     | 301 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 360 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index db243cb48142f4a20aaf7a29eadda1b19ea344a7..3c15d6d78f0f5ceeeb5ee39bfaaa7005d01a87fc 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -150,3 +150,43 @@ void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
 
 	spin_unlock_bh(&cs->lock);
 }
+
+/**
+ * ovpn_crypto_config_get - populate keyconf object with non-sensible key data
+ * @cs: the crypto state to extract the key data from
+ * @slot: the specific slot to inspect
+ * @keyconf: the output object to populate
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
+			   enum ovpn_key_slot slot,
+			   struct ovpn_key_config *keyconf)
+{
+	struct ovpn_crypto_key_slot *ks;
+	int idx;
+
+	switch (slot) {
+	case OVPN_KEY_SLOT_PRIMARY:
+		idx = cs->primary_idx;
+		break;
+	case OVPN_KEY_SLOT_SECONDARY:
+		idx = !cs->primary_idx;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	ks = rcu_dereference(cs->slots[idx]);
+	if (!ks) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	keyconf->cipher_alg = ovpn_aead_crypto_alg(ks);
+	keyconf->key_id = ks->key_id;
+	rcu_read_unlock();
+
+	return 0;
+}
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 5155791b87df7cccc76a011fa751686180074982..487d24a7d26635c9ca0fd66c75717502f60e7a0c 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -136,4 +136,8 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
+			   enum ovpn_key_slot slot,
+			   struct ovpn_key_config *keyconf);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index e87e33f49c3088a21f7032e9fd9b2bb0aa50ef83..26efe72987f3c3858f9398a757b6a70128c498bd 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -390,3 +390,20 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ovpn_aead_crypto_key_slot_destroy(ks);
 	return ERR_PTR(ret);
 }
+
+enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks)
+{
+	const char *alg_name;
+
+	if (!ks->encrypt)
+		return OVPN_CIPHER_ALG_NONE;
+
+	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt));
+
+	if (!strcmp(alg_name, ALG_NAME_AES))
+		return OVPN_CIPHER_ALG_AES_GCM;
+	else if (!strcmp(alg_name, ALG_NAME_CHACHAPOLY))
+		return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
+	else
+		return OVPN_CIPHER_ALG_NONE;
+}
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 40c056558add3b9d17fda5c43eb858cb44c95945..65a2ff30789862bf52bbda389a995f8edff48e7e 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -24,4 +24,6 @@ struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
 void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
+enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
+
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 407b5b908be431625a3c258e7887211ef0f4b197..0dedafea01858bddd457af0c95614e61c113682e 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -17,6 +17,7 @@
 #include "netlink.h"
 #include "netlink-gen.h"
 #include "bind.h"
+#include "crypto.h"
 #include "peer.h"
 #include "socket.h"
 
@@ -781,24 +782,316 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
+			       enum ovpn_cipher_alg cipher,
+			       struct ovpn_key_direction *dir)
+{
+	struct nlattr *attrs[OVPN_A_KEYDIR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYDIR_MAX, key,
+			       ovpn_keydir_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	switch (cipher) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		if (NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_KEYDIR_CIPHER_KEY) ||
+		    NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_KEYDIR_NONCE_TAIL))
+			return -EINVAL;
+
+		dir->cipher_key = nla_data(attrs[OVPN_A_KEYDIR_CIPHER_KEY]);
+		dir->cipher_key_size = nla_len(attrs[OVPN_A_KEYDIR_CIPHER_KEY]);
+
+		/* These algorithms require a 96bit nonce,
+		 * Construct it by combining 4-bytes packet id and
+		 * 8-bytes nonce-tail from userspace
+		 */
+		dir->nonce_tail = nla_data(attrs[OVPN_A_KEYDIR_NONCE_TAIL]);
+		dir->nonce_tail_size = nla_len(attrs[OVPN_A_KEYDIR_NONCE_TAIL]);
+		break;
+	default:
+		NL_SET_ERR_MSG_MOD(info->extack, "unsupported cipher");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * ovpn_nl_key_new_doit - configure a new key for the specified peer
+ * @skb: incoming netlink message
+ * @info: genetlink metadata
+ *
+ * This function allows the user to install a new key in the peer crypto
+ * state.
+ * Each peer has two 'slots', namely 'primary' and 'secondary', where
+ * keys can be installed. The key in the 'primary' slot is used for
+ * encryption, while both keys can be used for decryption by matching the
+ * key ID carried in the incoming packet.
+ *
+ * The user is responsible for rotating keys when necessary. The user
+ * may fetch peer traffic statistics via netlink in order to better
+ * identify the right time to rotate keys.
+ * The renegotiation follows these steps:
+ * 1. a new key is computed by the user and is installed in the 'secondary'
+ *    slot
+ * 2. at user discretion (usually after a predetermined time) 'primary' and
+ *    'secondary' contents are swapped and the new key starts being used for
+ *    encryption, while the old key is kept around for decryption of late
+ *    packets.
+ *
+ * Return: 0 on success or a negative error code otherwise.
+ */
 int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct ovpn_peer_key_reset pkr;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_KEY_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_CIPHER_ALG) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_ENCRYPT_DIR) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_DECRYPT_DIR))
+		return -EINVAL;
+
+	pkr.slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
+	pkr.key.key_id = nla_get_u32(attrs[OVPN_A_KEYCONF_KEY_ID]);
+	pkr.key.cipher_alg = nla_get_u32(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.encrypt);
+	if (ret < 0)
+		return ret;
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.decrypt);
+	if (ret < 0)
+		return ret;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to set key for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ret = ovpn_crypto_state_reset(&peer->crypto, &pkr);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot install new key for peer %u",
+				       peer_id);
+		goto out;
+	}
+
+	netdev_dbg(ovpn->dev, "new key installed (id=%u) for peer %u\n",
+		   pkr.key.key_id, peer_id);
+out:
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
+			    u32 peer_id, enum ovpn_key_slot slot,
+			    const struct ovpn_key_config *keyconf)
+{
+	struct nlattr *attr;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq, &ovpn_nl_family,
+			  0, OVPN_CMD_KEY_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	attr = nla_nest_start(skb, OVPN_A_KEYCONF);
+	if (!attr)
+		goto err;
+
+	if (nla_put_u32(skb, OVPN_A_KEYCONF_PEER_ID, peer_id))
+		goto err;
+
+	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
+	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
+	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
+		goto err;
+
+	nla_nest_end(skb, attr);
+	genlmsg_end(skb, hdr);
+
+	return 0;
+err:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
 }
 
 int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct ovpn_key_config keyconf = { 0 };
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	struct sk_buff *msg;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot find peer with id %u", peer_id);
+		return -ENOENT;
+	}
+
+	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	ret = ovpn_crypto_config_get(&peer->crypto, slot, &keyconf);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot extract key from slot %u for peer %u",
+				       slot, peer_id);
+		goto err;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = ovpn_nl_send_key(msg, info, peer->id, slot, &keyconf);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err;
+	}
+
+	ret = genlmsg_reply(msg, info);
+err:
+	ovpn_peer_put(peer);
+	return ret;
 }
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to swap keys for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ovpn_crypto_key_slots_swap(&peer->crypto);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to delete key for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ovpn_crypto_key_slot_delete(&peer->crypto, slot);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 /**

-- 
2.48.1


