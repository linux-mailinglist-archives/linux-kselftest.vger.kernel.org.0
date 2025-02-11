Return-Path: <linux-kselftest+bounces-26301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4C6A2FF83
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A27A1683CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07D1EF0B7;
	Tue, 11 Feb 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KJSBrX/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B61EE7BB
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234494; cv=none; b=Hq44XcqA3n0rNKfNBj0Wq8JvCo1rrc8dDXMFtWRjWTSvzVhfgbZ2Ixq1GwVEROwe6lr9WC8sCzUvFYOZhbGSbZQR5Hf3PasqJc6TwPxsajacKEfeMDkti/JwaSpYdvcV9cwwzYSe1FICTCdKlVoLlq0FTRPzgXaQeL3eUoVgPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234494; c=relaxed/simple;
	bh=+96bNGHI/f67Crs4XfuzhFWcjLQGFG+MO3GSkAjQB/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfAMGpACUfCrvOcHlJpr8Gg5BlYcoyZengLpJ3DJY5DPVT8PUUq+XXOGuS5pmm0OGZfMEYsG2xPg2ecfcJSV/599MlTsbyo7jYybD913F6qtyo6N51GO94bkr8pdYZaek8+MCO261o4nF9IQjACrbcJ4M3jiQ4UCvSt7QmxUIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KJSBrX/w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so9402645e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234489; x=1739839289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT89z86ncmothqxeiqhoOipd37knY17LTArJ/CB4jO8=;
        b=KJSBrX/wXLBdUHYipHmFz4XH+6ABznWtr1Upme7//ZlP8s4sk9SV0jfZ2TKBXigbV9
         CWxd2HrdrlmIPeZbDzzMlXGW3I06Eau74rNdQn43OM5regZcUAC+x8EwO9MR3nuUivZk
         kW1NnFBct3DcePc8jYfb06FZhYIrrIo1svqnXluwV0OBw0hsScZFtSIB174mqrfVqWzX
         Cp2ZVZfRg9+u6kgNdcXySxnsk8WcBW0S6aN04gOk/j8H4O8utE6EG7ewXV6KXXkBiK5+
         pZ3w29bdZ/hlEoLUDZNjolftZgv5P33n68y9jaIlQeIKwQlWCnjFepMcLKamWrDUiyXt
         5P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234489; x=1739839289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT89z86ncmothqxeiqhoOipd37knY17LTArJ/CB4jO8=;
        b=uQ7LxwgzwUE+9dD9DEK7hLoprg8EGDet2rbqJaTZbLwpvbYqNq4N5NSAHgXumljzYW
         St9oXW5QNulYWLjQBPZMR3NZCLiIRft6F5X6Fqvw5DftQ/n7Fc/yvpDAj+oQHeOQR6pg
         miqyFHR5O40PHQkOLqiFrc4AdetyGoQ/4zddlnwYybcditMXeEhXgEr3DAX3TBHgKE8p
         ubcsmtBkT/dW7royC1dOKvjK/Q6U4ZybCG7h7Xj9e+wwe594Rtjb+oViKbYsIjeYEUJG
         mkPSstbR85jQ5MOQLHK7v3nVmL7AssZ8GAnl+Hy4+/TncnB7PSRnBphEpgfOw1Bqpwv4
         gQqA==
X-Forwarded-Encrypted: i=1; AJvYcCUvXH9WoeFxLKGWwKmL2p0VtIkE3jMqG5+IYV+hoy5rsdLj6PqxCiqDZO1WH8SUUeBkUVvXO/p48RmDQrF4bQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzR5Id1TNtZvNKX/TVRQDdNlLp0SPY6HasTQwNUMz1lPc62gm
	Qnid96pj7PFxs9ppFITui3WS0fQCCHrzO6siWr+HKIKIyWjiui/sXaxChA2pUYI+kAFWfa3CJa4
	n
X-Gm-Gg: ASbGncto+OBskDNJpuUipZ937gUCoB+NG8CUSoPIXaqdIjfm2rQWIt+gjzCsWOmr88e
	LB/PVvPTDgg3EwYq/xs35SxVgjoo0c0veYbeTcQpEfWTzp2UBn36pYr91deEo+DbHgWF5+dPFm3
	xu+qdotUjZ7doMp1tM2YSYCWH+zTFzIPMlt1n0LoejqDQhUSdv0Yg4O2kWUDaHuAnPNEok2Qm8L
	dsigaw5Z6DGYH52Yh3ECWHJI34BXZGV1uuKm6Jpd0fGAMskbVB4t88JNsMZlq0cXfx7DYMPv1e8
	yReHXdi+9BKv38UcQgj0Hxzce+g=
X-Google-Smtp-Source: AGHT+IERn/FwMcyTAIup4C1Pyk0phGyJtR5oatHvXCa5JRaCW9OovxQICn0URGV8aYQs6mOcUzc82Q==
X-Received: by 2002:a05:600c:3c9b:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-439249c6e17mr142138395e9.29.1739234489068;
        Mon, 10 Feb 2025 16:41:29 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:27 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:14 +0100
Subject: [PATCH net-next v19 21/26] ovpn: implement key add/get/del/swap
 via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-21-86d5daf2a47a@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13971; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+96bNGHI/f67Crs4XfuzhFWcjLQGFG+MO3GSkAjQB/8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyOt2QmvFej6fUFAZHjjfRPFXjU7mxAB/A0i
 FUgqI1HWcKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjgAKCRALcOU6oDjV
 h9PEB/0Ytu+EseTpOZFklA4lFYLurIDz61k6LQQQuCoKXHxYHTl71chUpejrLLj9hTakZvXR4Mj
 srUaS/QVgDpzM+m2HLr/TR4ZtQza/d2tsvXWNpcU4xuuq1Ho/ttqK25LaiwcDVyXWjM8+v1hwV1
 b5uwby05RNN0okAem6ZHfcY+ccsA9C9rCNmJXvcufkHqonL4DBLzA2MMkMjxHerynxmqrfEmEcQ
 mML7nxv/XY4fAeCsDZRKiReaey2P6dv3x4BK9C6i0AVMQGFMbHm8Wb/wKOMXk/z+5MI+BCIrDLN
 y5aVOpZAHIb18Rn3rfSCL+lUI5u8iLaA/pLdlM1iYWB7TBNW
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
index 9116358619338db90e63d4e189b0cbaec57c9da3..5f382d8a46f21af3e9cbbdf5651659c10292e857 100644
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
index 33eb5bea59dc68110abfc5e940ffd841ac706388..87addc7bf07c02c3c23da7e6d1f86249d1d867c6 100644
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
index 3c48eb0652ea7be1b2d95426d0a8d7e1e8d6107c..27a00be5a12853475ed93e9b35d93156c4aeca01 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -389,3 +389,20 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
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
index 77ee8141599bc06b0dc664c5b0a4dae660a89238..fb65be82436edd7ff89b171f7a89c9103b617d1f 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -28,4 +28,6 @@ struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
 void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
+enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
+
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 7dfdae054ae35def032975e81381dc1527606031..c62ac542d6dbd79229d3c6457b5c910b77ab533a 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -17,6 +17,7 @@
 #include "netlink.h"
 #include "netlink-gen.h"
 #include "bind.h"
+#include "crypto.h"
 #include "peer.h"
 #include "socket.h"
 
@@ -780,24 +781,316 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
+	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
+	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
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
+	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
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
2.45.3


