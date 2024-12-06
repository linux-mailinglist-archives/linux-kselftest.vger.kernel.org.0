Return-Path: <linux-kselftest+bounces-22953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C99E7AC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F494283327
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A084227594;
	Fri,  6 Dec 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UJFXYKHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C7215062
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519950; cv=none; b=nRvtZJhP496ioqLRwfdsfwFccwOHQ6VFd+7w4/zRme0gtaOvPAS4IEkwVx2obEqAFfamATYgtSLZYSdTM1/31mdz5nvLqbmIduQFaonkOh8SIjfbjpucw41pMBuf0ophwPnVGSMdqE+As1KnRIOpDKj7cZrPRzxxoT180TBTFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519950; c=relaxed/simple;
	bh=BmSG4nFIoJPZgNxaXPPXP4Eer5fmr9CpUdYsd+yrONM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsDQGK7Kz4mD5BEjksOgxVjf2xbIA6TJznTiQ/RYN3xODsiBjtEMsNe2UxKJYU5rYbmVNg542riJH/AmoIQtnFA7Fgyyr0WNqAv7LXSsirNzwHuAHvGu0Jbc//3xvd6kDS6IkCCdUCwe8l7HCScfCoLyuqHr/Yew/cpeGjL1xKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UJFXYKHK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434e3953b65so3266695e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519946; x=1734124746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3R+GOh0/iF3PCRFibdLtPFpfofOS1kQjR2DAtfS4tU=;
        b=UJFXYKHKvgs8ctgpl/7o+Sl0aj35MkWFk/fXqhrpSkqfgxJo/3FrXR002o8zKR1dRu
         7sDB7FadPuIiV18wQZPlOwlFdb1rwCbFIsgMlEnKevo7s3lLSSSv790SgUs34SUl/bbG
         /941qSpck+p45a6uo1/GLriIzkO3a7xBaIPcMesZjHlCyMqjF7OS7/ykCZcXMZFkfWIw
         gBkSfpPG9727p6HHthr0Dn6WWHFn3ezredyo6iXkDFt5TkJwvEZijL8CYyPAwPw0AgP3
         i2eDnP0HSu7g7Jsvxb7z62dvfh+r4Icmd51nElqbm4a0WLr2sCvG62+oLnWO6k7CF8Y7
         4keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519946; x=1734124746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3R+GOh0/iF3PCRFibdLtPFpfofOS1kQjR2DAtfS4tU=;
        b=PD45zbM0Vr68FJmHYQw7bQvduwveiD2gbGKCcdTQucUNj1R6+4rWt/dS5ounSSfDqm
         Sk3BeAZMXcFGDYZ1GsbCXQ6pnIv10mrlWBjbgxJObCjAxorkj+UDVn6AmdOs/i7NqkQf
         tpY2LOjkhMB1gFXJBUMBpxpB1XIp9b1SVPDLOOluTm+9bZFwM/JdzNvINzTzNIXwP2lb
         axoiryYqkDJKf/OQowvCYEkwrKWbWASgDKxSVHkYyB/cs/dCZ292qMSIeIDgA0PgJi9u
         kJ6zgKyyimIuwozEtpTAuz4/YIIEtycC2uEl9Kn2IOwtVQ3qnxTyNFDsQEugt94QjlXS
         n4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWyJuClBrA3lahUWq/t1qDEVUyIIQo80hVsYa2vermDLtMFU9k3AnVh5y8xl9wSM9vcG66TvtE9LKNFryps8D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgCRv77Ts6OVk7fc24lhNHJAyKUf3A84XRYUWcHVSCBC0l7ot
	RJg7Wk3BzTe7dksbdLIbqNywzZA7aoRvbaf3nJ8npDaM/Hr3TLv553+yjiHiI9M=
X-Gm-Gg: ASbGncvyGRWK4OVlTYCHL7xUH4gsEhQkhV3VKNb1h1O3Ph0ffRQvA3nK4HCl1UDTmMH
	af0vqRQvSOl461wEB3lB6PHz3LCQC/FbG4kkoFgwezs+u+8AHIJidgm2tYm4KuZVn7LuN8FTIrb
	7tJoTzeOxuYqwNfybRWr9MofbKvKGfZKixyw2+MCe5lNmgjoam9KEfPhGnKc2W5Db7nNOjcYtpa
	Olv3OnqrTL7uaWze0b4RslUkCgsLKOZ+cuGit7N68o6LWtTdllqf7ENGVzUjQ==
X-Google-Smtp-Source: AGHT+IGarPC029fKXP0hNQJa3O1vCLYNNcYRB99P6JQ4VjT+fmR2w9wyRKuCvt+txHIJzdWotf+piw==
X-Received: by 2002:a05:600c:3c9c:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-434ddeb49bcmr42377845e9.9.1733519945769;
        Fri, 06 Dec 2024 13:19:05 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:19:05 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:44 +0100
Subject: [PATCH net-next v13 19/22] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-19-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=BmSG4nFIoJPZgNxaXPPXP4Eer5fmr9CpUdYsd+yrONM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYczM/3wcBBdc0TsbtPLXzTa7vHA0lVmOEp
 jmZlmuuYnCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 h4pWCACAo9XvxVLUXHLuPoD4P6l5dAII1FgYj2xdCSOvP3e5pswxJ3pZ/UG63eJweOhVLe6SELG
 xN8FzGRmpYT6pvrzb+r9ZACAVc7gw3RoQqD4Yj/cilQSZ+3UvZM6dQC1T8PmPxKk0KC7Xy4Laqt
 CKjOHX2/AUQDpbbaEJWP9OapSuVbF/LWXa3NYOJC2owlnKTdzJ78CiXwVn/jsGGtqBYQqHpdzmn
 3/9H8Djs9lulEk0gaZ3dKxk0WUr9RhMQFryvKkPDRYIWp4obII+0QOn6tQNNRgypRT6+Q6/qC/b
 G7NIWfj79ufJ2zDVrr5DVaBx9jKzAbBd3bz2rvQLwBz102VO
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
index 05ca312765a4551b3493dc6a27228e8ad48e99f6..2e338ea3b9542a067c1c53cb18bd12648d832cd9 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index b1e2f976b4cfdf1a6f8a644eb5406f21830026e6..04a57685a546f0eeac4e9a68910adeff246f5284 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -243,6 +243,19 @@ void ovpn_encrypt_post(void *data, int ret)
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
index f4dfcaafdb9501999d25464a4ec9f096a16826c2..355cd3aa4849b518bc794152e6d9d0bce7ed0f6b 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1044,6 +1044,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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


