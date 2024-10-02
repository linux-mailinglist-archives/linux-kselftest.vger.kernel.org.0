Return-Path: <linux-kselftest+bounces-18887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E498CFB0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8312628B892
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6831CF290;
	Wed,  2 Oct 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ll7WRys0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC91CBE8A
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859826; cv=none; b=Okvb02MsY9pMcKSdVIjCnZJzdvAvqkFlXKKVmHzNrAF8qwR2KeqCl3X80dawmlO2qEKy00nIS2+lVQ6FdttOEAhvdgtYv5aYB75+0VL9yFmkttuLm/bLQ/jchRohDGBJiR4HlnBIaflCPf57A3HLXNkUbyw9DtJyDxST6Hwg/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859826; c=relaxed/simple;
	bh=+vnKa4bqLRhmdCMIYEFOcKCf4rJ55QyAdiXnsOoWeHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aK5s3+rpGVZmbG16YRoVd9NfYa0SHYSwmSERPprW9k5Am5I/O3DSz7VqjTf7UH0c2PhmCI3PndNjbft/RCdPNgtn5HKlbmSKaVVj8GMrAES0XZ3418qle1omTjXfRIn3LmlhETXj/Nt4CHPJTFN+uAEotvvHuOOFaR6lNrljsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ll7WRys0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so50598235e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859822; x=1728464622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOoCYSq8vNFJ3q8xJBh8u/Lj1omn8cC+c9GbsJCACtU=;
        b=Ll7WRys0RNVGOV16n65C30T0VJL12RbNyEG5zr9usxROMk5er6qVr97g2ei6DC6HW3
         dzuqc8ma7nn+nHWYUQZWpTjxppanrA7IeEDjM3UlUXAppMKO5vJGgol3rn8nnDhuEkYe
         rEbgGdN2ceSxgQnoUgxS4m+sEPmIe3v3wK4hpFrdgXXob4xfuzkcMcOK06p6Mmk7fFzc
         j71Sm1hVZdjyecCbwjTGxoipEXtqC/c+eahK+zOFB9r+ZDXfg8t9BGVAdUhDwxgCP6Hg
         ngGSpE6+a4tUMJxy4+GWSMSc481yZGPXLzvxxnx0UPOwTyVBWbBv3DmW+UmdknW+HELN
         zi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859822; x=1728464622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOoCYSq8vNFJ3q8xJBh8u/Lj1omn8cC+c9GbsJCACtU=;
        b=V8BFhJuIgsM5+IvZ3syG42b09XMiJh1svRDraWfkB4VihxCjHDOQOp6f1dPFeNql1T
         UbW5lcM3+9UcgdI1T2MuruNb/eQS/S38y93M0ApFg/e19kxC0aSNJPI83b3yn/m/gbnb
         Eusgm77tqWcvAsF63tkSg8FqqY2WaLWHCPO1vIuyyKvnb45Ztwt+CWqs+WYHv2QkOMBR
         RogVHVXdJUrtfPXBSVRHTbMa96+/r6NMzPhOxK0vyRDzVacg4Kpv3/E7IEZ9Pt5Eswzs
         KXvOAD+ZY3cgyzL+fROJ21MEU1w5adcqz2nsJaQnqpr4YOCvggfiuiq9G8cJrnrmZrtX
         qF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXNVtBGLsyJekyUjhMnU4tz41wb6M/u7lFoBsqh+GLS/+oSLcK5QPJij9caIVLpNt1xho1xKkezyTl8krcp2YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdNyBlaaP3s/cGT0fsFMM8F5/WRjnQQZD4Q1pR1xjqIoBBspu
	DUq8Ouu+x2AEw/jXkZKAxEMPFqlQ9OPOvljRsBk3tGz3YYT2IIMOenWCPeJZq/w=
X-Google-Smtp-Source: AGHT+IE1NoG8qkC0Ty09vxBVTJVqx1VgRU9s1bKr4nqnYsiPPH7RmI8HoThZdr2IkFr8e1nCFbT/sQ==
X-Received: by 2002:a05:600c:1c05:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-42f778f34e9mr16157655e9.31.1727859821644;
        Wed, 02 Oct 2024 02:03:41 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:35 +0200
Subject: [PATCH net-next v8 21/24] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-21-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6543; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+vnKa4bqLRhmdCMIYEFOcKCf4rJ55QyAdiXnsOoWeHo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxTRcfL11iu+0/fx2w7Z4MtzMRWRPlXL6ogh
 AIwRkNfAFGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUwAKCRALcOU6oDjV
 h4UMB/941aAS8jcmPETJHTEcKhq4b7naEU9P6s2hVKEHDu4uicXVpxlHVt85w9B4S9t3JTqKFUF
 KBpWy6XSb5LUjnZ5b+gReQxlK7SFlK2GfS6qS2Ws5Jgt8WsSc2W2it21g2hT9ZfswWEgubMxpSx
 nM2zKtDJp/vwLtpn3wXIMYqR5GK7NoQpYo0CUxcSIDnqbm68S/V3Fzyfutiv45jrMFukzt87kbr
 XMh+ZnuZyMmuKIq8C9HWX6/E1gnldvog8mqcYsLvdbw1jjU8QGWvo/w23qeL/X43LDD2IbczADY
 yr22bC3px+o46UyTIvJR+GswMKohv6/Q5mtwlDuMrpS/tJIF
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
index 61de855d23649598a6e5a34447a35ed9620dfde1..48ea6ae9f52114a2f55d71304243d52467ebeef5 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -133,4 +133,6 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8f2b4a85d20fbdb512de7ec312d391985e96b906..3e82ff882d00b92b67e320f2521269b6bd731083 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -223,6 +223,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 
 void ovpn_encrypt_post(void *data, int ret)
 {
+	struct ovpn_crypto_key_slot *ks = NULL;
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
 	unsigned int orig_len = 0;
@@ -235,15 +236,28 @@ void ovpn_encrypt_post(void *data, int ret)
 
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
 
@@ -273,6 +287,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
 	if (likely(peer))
 		ovpn_peer_put(peer);
+	if (likely(ks))
+		ovpn_crypto_key_slot_put(ks);
 	kfree_skb(skb);
 }
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c9cede9025505d1b69ec8eeeb60420d0a1647c82..e9cf847e99026e78eee4d65b62911671e8c2e407 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -963,6 +963,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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


