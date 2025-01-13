Return-Path: <linux-kselftest+bounces-24352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DFA0B318
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63821652F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB520459F;
	Mon, 13 Jan 2025 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GSw8QqNY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1E21ADB3
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760698; cv=none; b=gsGkbXE2ggYeqrx/s61glRcosTKKkOHKVW/zb7kw8c9x2z7lzsr8rITYnyZhHuW/6/PkEWzBFt1lOudRZv7aTd4gSyng3aR63Y5oKTSOwOMkPKbw6FRCaxQwagVVBoLZapQyQkdBfO3CH7dmX8JeDVaEZ5OXzZo778qp6JrjOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760698; c=relaxed/simple;
	bh=weV+y+am/pYBeSCBRMalpliK1HckqskFjBcAPsLTL14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBOt+KfKkz75gviMcNteWeVkJLyBU9hVM3pU+/eVV9oNKR/GRvdNrhMdDayeSdd/qhGtINaFg4p3Ol3pempJ7EVA+zi7dXN6u+jub76mNCJuvRZdj8Y5wEt8MHGlwWbgJTSTeE/345uzlFa+2yglnfhQhWbkDKr8u7ijcmkW00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GSw8QqNY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2374805f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760693; x=1737365493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHkamOnR/lodaUAHjtzIhzcN3YUOeRgGlv4rjwN+Dlg=;
        b=GSw8QqNYkhXzBGCb/g5DtiSfgPG+bpxWdDnizQsNM+68BBlC6m742bv7ZQs9YnM2tw
         3ExM6vmDlOj7MFjnyWjdIg6DPzoXZTUZ2a6eFjuxRp1fSWlp1gLroLYD4HzS/PfIFQaW
         9RqqixGdXqp/N9I5MESt/kQsNY4jVoPbGb/2F+UXWwNRSR9KozTarc8UbblGhFg+I3eJ
         W+UpUX+SkmBcsSigBV4Jq/uVLdR0N21lnWYsj82VR/kwT9XXC/EFWerh2vrHZc6Lgfb1
         wQxDF7memJCbqPLc/kxTDPc7FC2PTnyAZzN28ptU1daFe/qRdZzvHppDcWyq3JNIwQBn
         KAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760693; x=1737365493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHkamOnR/lodaUAHjtzIhzcN3YUOeRgGlv4rjwN+Dlg=;
        b=GRAa5DfuLvVaQWIn2q5mwPLXyR0e3WSOcReO/cFfgordHzRVmJanj9oe0xhORs7UKs
         ystgO5LtRCR5OsBlDM9bs7nne5S76EyCcSAOCPO0UOauvDGsk16DQsVrj8WLimBYwBSm
         fq0J2wkYQtVyFgHWpk/gX4uYVCDf9zr18dHklXWzlGT7rP2BrZCUigt2ZR5rMK70IkhO
         jf/sJJoQaGLWMPrDf75TWnC88me8TeNVEh8rSWM8FvRdx/y9gzFntUgT5Y7jsL/elJt/
         Al8lUVp8xihIAA1Pj8/Xw+TWZuxsI5fZvDnOb/oXb1lw4JjbaiBbMWCQhj7aPQ9VfbRf
         NvUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWtStTxS7ZLTIhZXmad7IaSyaefpKUL8zWxAdW790iuk0tcEBy+zphYSmffckpi3FjSGwPOLWrVjF7uvpVOuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LWWtoo9+H7VTA7nOwxUQtf3Ksn5y0ucbJNLp8uPEkILp7Z/u
	nvEQqzAgEpMH6tabMiJ4ec89nP6DeUCuIElCNn3mNOTryZejCRIFpdJaaZ4CwnM=
X-Gm-Gg: ASbGncuCYwUBew4YDHxXGwbPqTf45SsOtSiOgiyIJR5cuqJf1APWTv01xMi8eEjNoVD
	Wjhda+7KWinb3qzPVtI02gwLrqR0y6ByLoRzCyb4CMQ+2fv/JVQIcnOplMHnQAqCqEi4j/J07T5
	Q+4IZ3CdvKGKN46PI9vsqbCX06dwRfZJldgGx61SREcKJG5udRUU+V6bXTv0wLZoRxZASpSr8/4
	fsVBTNJcdyh3KbGTlxp9uBaAflmWxJOJp+q2d5WEvbUa+PFi3o3p1x5bMY9UeetYkqr
X-Google-Smtp-Source: AGHT+IGjwW87JvWwORNFrOPPSk7l5eanpOwiBcZXvKqVAMrAzo8ESQkTF0Fw/6Xj3lYMIdfz9sBvPA==
X-Received: by 2002:a5d:47c1:0:b0:385:fa30:4f87 with SMTP id ffacd0b85a97d-38a8b08c0cemr15009729f8f.0.1736760692987;
        Mon, 13 Jan 2025 01:31:32 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:32 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:41 +0100
Subject: [PATCH net-next v18 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-22-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
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
 h=from:subject:message-id; bh=weV+y+am/pYBeSCBRMalpliK1HckqskFjBcAPsLTL14=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2IOCrWSuv2t6x28L58fuVOKUoM5SdlAN2Kh
 0pDfnWlqc6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdiAAKCRALcOU6oDjV
 hwywB/9rg3usqPG2A1f/q85MPbfj0/SuRiizdDreFR9nZUnNTxFFe6VfU9TH4bis72jB4k5MNHl
 bJA7OsfRKfNOuE2irxgif6TCHkZ5VRjtGIQzzteqrKZb6VKWuVD/fcFrTyXb1FLrNz3ww5UKeyP
 fxRmciRKXR+LQaAJylukYnRanDCHx8BKoSwLJIBREsSkHk0O2RTz9Qm5Oky/1/CW9PZFgpgkPFu
 seytttAcY0W6Kkf8RR9nAEOKwSL1JvtX2tEh7Qybrho8CQ1mzzJR7WNZGTmlj2+CBuzTQoN9zZk
 hi3QePIUVqzCS0EGdq4MhogfHONYyChvtm236ChbDb+9D0Dd
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
index 4d46eb6d6f14bba8c3a8335d08922bb8f6d3149f..6f82fa0b42077ae87b72b3ffe2ed99a1e72dbb3c 100644
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


