Return-Path: <linux-kselftest+bounces-19810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECE99FE00
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A48628755A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69A1D26E3;
	Wed, 16 Oct 2024 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VOuZ7Mzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E21D1F4F
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040667; cv=none; b=QvUPYX4QBogVHG8Y3ySkYFMTLbqndwo/bESyHVAAfjVPc/fhJGtqra/XHs/z1gg+58B0qLMO/Sh5BALU2XJPNrwi3+kwq7p+i3HzMa657ASMHGeF2OCXUvCvcKUfsf3X2deDNeMcTXWt8E9kS/HcfuKNWOzp5E1sHbNzV0DIQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040667; c=relaxed/simple;
	bh=D9XOuq5NLdXjEhB+gziaUN9VEXaSfc+cmeGM+FY4CmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTCIqNnGbqJC6WRaP/VDl/5jR21L9DypTMfNJ5OE+1LB1SMCkWLac6Py5mnYjTHAjZSQHcemk4/M+huWy1Vq6sqYOQrvDA0FExkOXYADXWwiLsb8kfAdDPpjctVuhBkMN1sRRTustD55jwmRLwSyqM4O+PiE/3bGPQKeujOTdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VOuZ7Mzd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314735bca2so9250795e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040663; x=1729645463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMD7l+FSF3xKMSQaJEdYL4+0Pf5IdciRVFCya7TYwek=;
        b=VOuZ7MzdF8uODgIL+Y1UYc+lrykA72PARhGSHYjihkH62+sMdPLUdIEK6IGB0Q6Suf
         9l4wnTLm08Q2X0F2L8r1q4iUXaNscZR5POFauBd3Klba4l1Dg3WfkSimmgKLO864avVN
         GCj14gDWYyutpVElR1mh5GhJe7HXUCCIcmaLZc0EHz5dMFgF1hThK19V7mZlIEMk7oFA
         Qn4PQ+Z/CjYz7MDOOmRhW4NZPeoG1eb2hi1fN3h5rk1D6y7PCSEYnvzJtlsFMUB1zmh5
         dlyEsyFQW7ELZyEwUwbGtVVMcHPOCHMqiUIIIJRiTcXkWkSEChuDA0xtdsgCtqOkU/yH
         VmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040663; x=1729645463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMD7l+FSF3xKMSQaJEdYL4+0Pf5IdciRVFCya7TYwek=;
        b=lDLeBScXaHQuhJXGOBviRRCgb1W7uIsjsx+cuLrT7sTdWMqcMGEDz8T0Dbx/IApSrj
         YeRISRY/LwUB7aBSohBhBGzNA+BwVc7KP2Yhh9Dj3BYTmhdt52YcQbJ6naXaqr38dtp/
         PgJBHKFYZ6VTcySCRY+qBztuxWDVB4YDxgrpS+i18r/tYD94aP2ccjRAFGj678vJb/ub
         /SJ5gYjA/DWZ/CB+NVI+8b25aQ+S+PTKfxMJG6C4YWmI1ksoLTud1B0kVW+PIZUHhYld
         U4NGRbO5PTAU1ma14CGGWHDFwrqYG3xVFUNNv0ZM2d79ffbdZC9YdBNaj1Szy3oVN36O
         9F2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtspgeQsWQtxjPZsOjEYR0EFXGWYzlpw4eB+w6VfN60F/Iq/vdEwNELc+EYbaBw8QzuEQDK+GSFGTNQnVWaJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjC7WqarnQwcCs2rGQsObFMWzyEhpRTWNXFzXLFN6rW8qyf6uB
	W6+7fdjzThSN9/uOTPbQqdbYLWCAxGp1s7AGIsBN54DT/ph1eHzcjE2hc7vsj08=
X-Google-Smtp-Source: AGHT+IEsXHjvZSLYefO3htqwaxwzORWf8B0OT6ATZfvFpi1yhCfCetRyT7L5kxe4wZAe75IokFMrDg==
X-Received: by 2002:a05:600c:1906:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4314a37bb99mr19466285e9.25.1729040663627;
        Tue, 15 Oct 2024 18:04:23 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:04:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:20 +0200
Subject: [PATCH net-next v9 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-20-aabe9d225ad5@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6543; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=D9XOuq5NLdXjEhB+gziaUN9VEXaSfc+cmeGM+FY4CmY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDxD98nCNTe5ud76sPiUO1YuG5F/Zi1VEblA
 D3GUuO3E42JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q8QAKCRALcOU6oDjV
 h6TZB/9EiC73lma2rR+/IWSXjb+n3h1zfkbNg8sSZZeolW3efmCuf69tdyBmvrVZioFJ2spZXCT
 YHg46IGSCJvSqne+Lb4IbfO/oao/EjvpOPrFyr6JoyAtdxVnSWkhlyebNuYq/Jq5j9RaSEjBwTU
 HpsNa/6/9GyaXntUF3ki4Jo9cQ/t8TWbHyMlosrJsCOwzHgmcbkSNJ2Q82HZWxmpN7YWq0c+uuu
 BxSjOCb8qTiMkwwegrDWnXx2v2Wr/es9Nj9uDzTd9Jo8n/vxnCQgsLOb/qVoqiZqI0ysGUa+913
 OP8urs2N/JO9y6BVRTYavxNq4aapB944jH9ju+pL2s0T38Ts
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
 drivers/net/ovpn/io.c      | 18 ++++++++++++++-
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index f1f7510e2f735e367f96eb4982ba82c9af3c8bfc..56ae2f5e5c33e13933f26acd91c7786f7c02011a 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -55,6 +55,25 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
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
index 3b437d26b531c3034cca5343c755ef9c7ef57276..53a965ec0fad3402317c1ac580aa6faad579a09b 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -136,4 +136,6 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index c857ac9015b75530cf3ae40f8db0d4db4c08e2fa..dc6479d5f3008c4e851bee8d4061e4e85bed40f2 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -225,6 +225,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 
 void ovpn_encrypt_post(void *data, int ret)
 {
+	struct ovpn_crypto_key_slot *ks = NULL;
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
 	unsigned int orig_len = 0;
@@ -237,15 +238,28 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	/* crypto is done, cleanup skb CB and its members */
 	if (likely(ovpn_skb_cb(skb)->ctx)) {
+		ks = ovpn_skb_cb(skb)->ctx->ks;
 		peer = ovpn_skb_cb(skb)->ctx->peer;
 		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
-		ovpn_crypto_key_slot_put(ovpn_skb_cb(skb)->ctx->ks);
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
 		kfree(ovpn_skb_cb(skb)->ctx);
 		ovpn_skb_cb(skb)->ctx = NULL;
 	}
 
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
 
@@ -275,6 +289,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
 	if (likely(peer))
 		ovpn_peer_put(peer);
+	if (likely(ks))
+		ovpn_crypto_key_slot_put(ks);
 	kfree_skb(skb);
 }
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index bb96645205b6704f7066b7de9a003e01e63c10f7..09c7df2b1c76c812a3bece6e63c9fac13c96c327 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -903,6 +903,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	msg = nlmsg_new(100, GFP_ATOMIC);
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
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
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


