Return-Path: <linux-kselftest+bounces-20947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499309B4785
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB591F2210F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA720B1F8;
	Tue, 29 Oct 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ml+73cOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69692209F2D
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198913; cv=none; b=Du7/Bd/XqQWHDp166YF+Bf5BBQTBzT2JSqmC14TxwjSsSSs9dz6X2sQm7/XRivsR5XSX+zdsPgf1dW8U0Zir5PMhXInesIlLt8oaewiiT0wcGuCi3OO/GaUcDhdnNEuakdD+yafT0J2znlnewdSNHVeP9UArSTiBTUajxwGL8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198913; c=relaxed/simple;
	bh=TNdCndX2JUubPrBeGJqTvcGDcf/1aKtTZu6vFRBIIic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIwVYt7C6qet3LFl6dgvbikUmPasNCcdErlVbDJ4O6vHL861H6pFzh4rL2F87pOg0GJ3HMtmJ7NQt2bacGmbW65Powpp+tjdFfaRM1K/xThMDRMPXDUwiBJbKG9ZHUNRzQrEcUGAErFBiisefAbpP8dDY/ZjpUFacj/UeKj1nFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ml+73cOs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e13375d3so5929435e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198904; x=1730803704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVdokSM+dDl/K4vWbVpcM2wInjsbKQVBO11TnSzdj9o=;
        b=Ml+73cOsJd4jWIsYV44HYFaSV6T1xQZrydW9WeOhgFEbKXlj+xnXHkRzUENneqxTf3
         JOaRkiT3NjLlPBjo77WTVzM5/U/6vjQ/7GmPQoRsQf3VmnRWdWBeEcmPKISWz9V84pbi
         kC3lK8sD1owLiWPmvF4v+VawYmBOvXIrsKXfgbPo3gkz8pWRDHX1sfQ9nSlH8h6bzOHu
         TuPfQOVtiCQRpVMRjI+2oYR5AwsHMEVfzHge3rOYw55XLXLldQd0SCzI9JG2JgvzLGQ0
         wfM4KhwHmJzRd3PQ4vZ3h/vgKS83XcIfblH6hAfJ9Xdf1kcRVHv6++x4AIh2vix1KrTU
         +2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198904; x=1730803704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVdokSM+dDl/K4vWbVpcM2wInjsbKQVBO11TnSzdj9o=;
        b=MqloXmuHv92NJXz/YxTyOKR96nVxjkdd5MbNS67hJd3gOwpWhdzsUIn4AO04OyT2Tm
         PTRsmq+ZUIlN3MPwxT1jeN7BCLX3udx8MZCWnkwzX6YnaWcgc5clRw/EQz1I1GeF45dZ
         ANnoHpruuq9wM68bD3Re6WOnuaNpIWwf3zJPjvi/BOjnVmtJXfdGckTIZYcAO9Knme0k
         C027s8aVSEIvC0e3oldABdnnaUksMuvPaxwMgmZa7yEMEVVcgddFMxHEUQrTqPjQhHC6
         UuGU6RVcV55cjpN4Raync6u4ztZ7BJvqCtdyxyFfgKunoJbZu9wsHkVMufuUHaH97rSe
         C6jg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Sw8FaxPSI6T7OLOVpL1oQEfMzlqU/5Stjw2pG/5UQ7XskQ6je6cxBVvoWXfltpl/5Lqk0eirVPI8Gr4pR8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyplzHm7bLF0qr9tVf2RIXZOhkpwKiGiA0JJDLlKiWPKHf4d1xy
	oEeya+8RbR361LZuqjCb7rJDRPWYA5RxEViI4ILkiJUo7teuzKfKOMaGdwWRZ7k=
X-Google-Smtp-Source: AGHT+IExlvdV4EUt0ctKviwOVlzjYy1MdEfDCVTU5Sgi4hvbMN1NMzi9jIFtC4R4b7uD+uLntSYaFw==
X-Received: by 2002:a05:6512:3d8a:b0:539:f1e3:ca5e with SMTP id 2adb3069b0e04-53b34a18f3amr3680767e87.44.1730198904289;
        Tue, 29 Oct 2024 03:48:24 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:23 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:33 +0100
Subject: [PATCH net-next v11 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-20-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5688; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=TNdCndX2JUubPrBeGJqTvcGDcf/1aKtTZu6vFRBIIic=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1sZsjFT4UErceYS+wekvjyv5W8Lol2P3UAp
 6yNEg/JcG6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9bAAKCRALcOU6oDjV
 h3uGCACcCI4w004DFfxSQjv2G4EK8A1BV/eHeDI7iypqyq3ZcWsYofg2z7NSbFCNCJVNCGs/F0e
 St0xiV41Foq/xnzUxb0lzE4LWvDdYi5O9asY5LrHjMQ3ALuD6Xue4ihcqL1DExKFChYu3cR1/ea
 nszolxhBLEidOs4Pa7EP2qcs8omsn72IJcv+OgKsFaeWIW7ePi8DAtfYfsbZfTKo+L32KAVxNgs
 AXcCLFdpV3c/M8Hx8NhwO3Eds2p/8pvP6705lxMeBSNXyCzea0rQmHay69oVsQxcB1oCaY7yp7N
 OH+w/ggshvcKZkTsJ5p5AzjT8vopWUefpYqLS9eZa7nLO8Ab
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
index cfb014c947b968752ba3dab84ec42dc8ec086379..a2346bc630be9b60604282d20a33321c277bc56f 100644
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
index 96fd41f4b81b74f8a3ecfe33ee24ba0122d222fe..b7a7be752d54f1f8bcd548e0a714511efcaf68a8 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261..c04791a508e5c0ae292b7b5d8098096c676b2f99 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -248,6 +248,19 @@ void ovpn_encrypt_post(void *data, int ret)
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
index fe9377b9b8145784917460cd5f222bc7fae4d8db..2b2ba1a810a0e87fb9ffb43b988fa52725a9589b 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -999,6 +999,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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


