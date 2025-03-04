Return-Path: <linux-kselftest+bounces-28131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579CDA4D031
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FC31895973
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A71F8AE2;
	Tue,  4 Mar 2025 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M9ey2ymH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E01F63D5
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048498; cv=none; b=VhhkbVa2WOCWPVXihcY3Ayoni5md0CsJbzvDM3919wgNNQdDBLy4qpmoPdp7blCYkzKvF2O/A75++zv20ZMLXRRMvsjCJPF9W+lPOntvXwecG+/wSES8gM/L6eyikGypg7s4t38SfzbhHo6+uINq3S5q0ejx9h5iVfg2rqg9duc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048498; c=relaxed/simple;
	bh=YswJ1Kjx/vaF0n79gC/rQNtodL+11LsJAWbXrYZ/jxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gATOv/lZycgltQ//4eyyc5WEWZMT8vw2Dv56t/YAEOtBjCDsVYkRc6huCFIxUFDm4SrMvDNDag6xe+MVqRk9gayFyyy8s0NFwNlIe/tAE8w4ZvTbpC2OfIVETWT/TZwGcYXBHraftihDZwBt+XpH6vKgbx6KAO88obB2Kr3p0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M9ey2ymH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390fb1b987fso2918279f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048494; x=1741653294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXkpJTVZ1HPf+TwFQiVq5gD89vEi+lEEO/pH6zTQhAc=;
        b=M9ey2ymHR1f1RvTsDr66D0tmk/eY6MC4ZZt5Jr9THn3SbnqB/Z+G5jRLrt4Ks1P4tB
         rWjAxPvErhrBUSJfsmit7UhmRf6TpsSo5jF5c4N+GjmLeEJdYvbw4AAO0RMI/+e4wpWs
         7ShPgxm6nWw1CpWQl4RQ7Lw6/Qke7dUxwa1U5NZrsjPbs8iWdQg1UTncFecu9SqyNi5F
         IPhOw6g/+4PfUPg0vgohKeAPHTB197O9ip8Ex/GZbICg8uJ68Qpn8PXls1uNKrLluHMM
         /fwA6rKzp3X4U3Ngivt6KFHDoMQb25ME4G2nH387Ecswytv6ii9blfXduOSPAGYE6+jt
         XFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048494; x=1741653294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXkpJTVZ1HPf+TwFQiVq5gD89vEi+lEEO/pH6zTQhAc=;
        b=GbJ/tYodV7IFHHN+c4YPpNiCtE/1vP99xofVbaKFAxXJEh8IdPB7KnUvlm9+F3k23q
         ZsmWTxlDK4ciNmDZG+MgWjJ/p+qORYxxoeMihec9nulhGFEfuwhPVmJ3nN9VT46+E31D
         Ujz47l0C+BBo866XnpeT5yqlC0g2RVKhO9WNBagXNuZ2cyAN+RqKRYAxvHfiBUZshI4g
         Dzpb9mEjVbut1gqxwx/3xD5UeCGFdW1sb7SGqnjapFhhz1LOqL737GyBjVkf3Z9PQrrf
         J3B+npaNLg1mrXIuGl4z/OPxdWKJXAmNoN3+Ik8YholpmclVbw1vmGS3YEo2ZCAfdnVZ
         yn0w==
X-Forwarded-Encrypted: i=1; AJvYcCUaANekPUs8NeuJBGR4yUNfWZUZKtObcGksi47aEDemLZHyzZ/UUuD/PBYK/0ff/0Qj3EUWINnA1Fqwn6x1w28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+fmWb88JKSlT0yRFhDxcqEwOSCD1PlKagTTUnyD3o295TayD
	TktwdC3x+or4eb4HiBZ+iSzXDFA4hAXuKQcEMTqzR09RHF7HZt346MydWvHqrVQ=
X-Gm-Gg: ASbGnctpdg7+Rgyt9frJZTyTX0/axqX2Yg7l/dHAPxv/VaopLiSLWFS/Jnwqve6Ro9U
	jdE5hOZcRzIPGbAwLMcTbRlc3AC8BLbcTEjntAK/7KM8bMsDqJUt0jB8q8roTYD9DHBWuZkRFcw
	FcXL3SMJs/hKEeTFxeBkPjBEy+v+n4WiaLdqDRdaA+1fNPeKAR2qr6uz+wIWBxKfdXH1KeKHmzh
	tV/APx8hjDyH/bimVObJq3BkroiciHr3UjG5gkCqjLLnVnynFdKvwKmjap8KMC+Xse/78bGmxEm
	BSdeiSRIc48/FpdOcEJVKMcz8MdtWCOP2FnoilLYkQ==
X-Google-Smtp-Source: AGHT+IGvdG7D6tKilvnLfRsZ2lW3gg9axGOoggj7sSxJsOP+cFlU4Vn13V6FtBxOKVerpdYy9+q3EQ==
X-Received: by 2002:a5d:64e2:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-390eca5b1abmr12017611f8f.34.1741048493904;
        Mon, 03 Mar 2025 16:34:53 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:50 +0100
Subject: [PATCH v21 20/24] ovpn: implement key add/get/del/swap via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=YswJ1Kjx/vaF0n79gC/rQNtodL+11LsJAWbXrYZ/jxg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqQxXV/hEipVlfrxNc4VnKbkOFQG9a5tjtcz
 NGm7YYh2sWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKkAAKCRALcOU6oDjV
 hzfNCACtl8NZq06dw+oUu/623MHC8e3u8bNUTmHq7zcwb2AxR43qiZ66m+NGSNomVKyvq5WWOzm
 U/duZaTaC+puhfn4F6l8F0iSaeZW3D97EERew9fx9VoN4fXQHev9/yQagrDUGPRlvv3pP6IlwvR
 b15J/vLRHEuA1LnEK9OJDa7jfRR2rZC5et7ECcfPBGhRe4/YDDckKNPfgnzAuJMvmX/v922sk0R
 3Afw/O7kcgwyW9SUrtK9bixQT79TTJyWfr23SndIjmy9m/WKWJIU02tIgPdlfzpR3piw1o3I0rS
 wNMoCWBT3cld0Un/On9YdN8mQ1ThH1Xy+wYobhTveZEG3zWN
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
index ac15aaa9844083328020fcc5ea6866e08ecbc184..f30c59c1193a167d7f420d89b665e2e61c57d81c 100644
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
index f3b3be9866df910e3d68762377505f65c767a4fe..d6e888381c82d208c7ff619381858302ea6fbbc7 100644
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
index ac678f087451da66bc39148902db21045a94eb19..fe410b615d8442fb7e17364e2fa6c95b50162577 100644
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
index 8a9d01f5eed700d2f7dfbbecbddbb370966682b9..d43aafa622315e3fd705e5da0f175356618a456d 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -28,4 +28,6 @@ struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
 void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
+enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
+
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 9824ce4437e63e602d37d31105fb9ac06f99d421..3d8b5e02e103e4177f3abacecfc4b52eb7226b87 100644
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


