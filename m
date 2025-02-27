Return-Path: <linux-kselftest+bounces-27697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8AA47148
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149B4188FA24
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635BE21B9C4;
	Thu, 27 Feb 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DJiACbML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5B1EFFAA
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619399; cv=none; b=lguTkj7zVpkV9VAiWNvUwa4hPPH+c3BOSQiAjapGkP1jc72/T8IwiDNSt1TQMX1JU686h2xU4x6cQZlEUyPPJ66JbSMJ3gIJVtrSYCnzNOOxtvK3IV1ycj2jVA8B4FlZgGeARqlE0VrMBI6i2Ks0ZEH5ISDb5p80Q2eEX8+zbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619399; c=relaxed/simple;
	bh=tRnylzfdkenSqNwjS1vw5/NOE2ssxOWboXdpid/ZUmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZsYjIYlADUqbQYBQZ/Ss7muv4rYWujgo3gLVMA3yYgr4f5Td/3mwHxIEdXyJVn9CaSR8a7i/YrzVOJ/nsklIDfZ11M44TKxrlBJuORhwdWLR/83/6okXq4+tW2J/My+wVtGuVmP03LWPvZMShu1Uuez0mPZRBYj2Zw3/eQ4H88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DJiACbML; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so5187735e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619394; x=1741224194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laM18gAlAB8CYwyRAdC23x3rXfRJGg3uHdsl8lpg4BU=;
        b=DJiACbMLg4FR7v8eOM6xN+ZqJ+KbYdnO9vCXGDF5DjVNINVDRWw9/Zp8L79BEfvguo
         D9ihn1ds06yjE+VXc3gbqCUn6532qdCzS1ZopEI8iNhDpmfpdksh+Ssx+NvPkgFCi7/O
         K1mmHO/KsNpoGXX2bcbNkQl6P8iA3PtJMYoTPfMv5Fh6m9J7ml9qTMZBR9aKbHFCzEdF
         VBJ+GgZyh0u2ZyzwXaCb3PAjf8MwYagYSbw5z/XRXCW8Yp057KXT8Ky+fFo6WUP9ROMr
         rcrvAOOBFt/nC3FKBGINXqJUOYN9D8MjlJ351cQMGOUDqxZa0kD+x7n4JINIPUFnsyAl
         wPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619394; x=1741224194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laM18gAlAB8CYwyRAdC23x3rXfRJGg3uHdsl8lpg4BU=;
        b=WVJK1VtrDk89qN0WlsGPwRnm/mJzzM7Q6yiQaw4wUkNAvOe4cP+sI5eDYl5mTk+IW0
         y59KYqbhQFx7p94v9f/qmo2z8yQD7SGC5IuXZ8BDPMS6qUt5fLoCA73vsye1I6NQFuu2
         kGdbPlSlmcO0vbI++7T5s60ccbpmMYMGnfR1X6W0yirQ2cNQLdZFsGhYlMdRrUC+2/Lx
         F+RrWzJSX5r/fl4uhXvGO/Fv2i8x1l6uBhR6bRNJmJ7TvH4qeegnR205NX4VTN5Ku7RT
         BIJJ1RziDjlSrgiaqSg88B1IMiivPlzPWKkrYjHVtLTRfv1AF0rJupU7DhHyhAgLLCTV
         Ugug==
X-Forwarded-Encrypted: i=1; AJvYcCVLSTkkK+WrzkTWGHYRFIpmFmV9r5ItfaNRDVWKBPZbHd7I2e0Gzb2QhSxb5ua5EmzTLPQtfuqcGbPbj2HCNNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrb5f831HklyPA5P9ZIGV0fXFHd+RzQswNtHrRZNufQR6BYpDU
	iXI8n3h+mHZ7VvXEFWX6duuPBjAPuBHrnHpEtrhwKUJOUMkINkhpMqsLqfLmkxI=
X-Gm-Gg: ASbGnctp5Qz/Y16tFqLxKRD73qycjU1CTvWWqfcBf4p8XLKWFJdK76ZJC2JdWzGXx99
	5YazZx/fW38NxaUSRzQeA2jhzWoAbOAdvg2QifVvnlpT96EN4rCDkyUa1FfQZcBP2vfrRTk6CZf
	2QdtWN/CEl5v8HOJY5lcF4/7ASIQtfXKVpl+wrLAQI6iA0xmlicE9lunwHfYroU51KoSMSNT7m/
	Ntas5J5IGEwW3Je9h2eNZR8lpoRHJoVtOuRk70U6V0x2esadSuraTNbyxC2nEF/5FGU7TpFfpsL
	Y2hPvuYCYOkuA/ky9Wdh46tZ4QAlxC80hSiTyQ==
X-Google-Smtp-Source: AGHT+IEP/u4R++Wj1ThezbnQb020YxQpCfCbJKSOrqM8alTKKR4Xa2DtytjqK6xb47UlMtvnD48iYQ==
X-Received: by 2002:a05:600c:a01:b0:439:9106:c09 with SMTP id 5b1f17b1804b1-43ab0f6fba7mr94492905e9.26.1740619393898;
        Wed, 26 Feb 2025 17:23:13 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:13 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:47 +0100
Subject: [PATCH net-next v20 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-22-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
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
 h=from:subject:message-id; bh=tRnylzfdkenSqNwjS1vw5/NOE2ssxOWboXdpid/ZUmo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75hVpuQLXKFRKzOO+AJaeJXlBZ2Gm6Z08dgm
 tN68eg3M9CJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YQAKCRALcOU6oDjV
 h+VyCAC1pbZPd3Xji+zQa/SibxuMl1w03QRgnVI2vJEqZQ+sAtcHgbSAKjFNT/kO67aVzAv8pqc
 PxlETwwOHIj3/iIAXNNqpv/Hcm3UK7qq4I2yz/XGyV/4+6GbWpBEqGnNmmykXjeYJv2S5W+V6AF
 DgNWmkXtPP66veT56Ar9UmbDX7vawmICgQ4vv77irbJozKBpKi6GhhaDV+tAoILXJD3HZcZWtbC
 xPLaXwpl9DTFJwPleMQzC7dsfPmZOwJzilqRdN+xVZpIaED9/bdaehKz1adeePxpRkinFiCIDfx
 rJ/6izOAMuHXXJBPoY1KSxvxNVz/tcqbBLyO5Djnbmwd00rQ
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
index f30c59c1193a167d7f420d89b665e2e61c57d81c..b86340e51e0cafe2931221ce91a0f7a977e5a047 100644
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
index d6e888381c82d208c7ff619381858302ea6fbbc7..7c88927830020482ca4d357ac44d3b4916db0891 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 5b673eae255033b9d7d6e7890a46686403d7c222..d81c1a2a958c73e22e548d8e63fc78821b5eb881 100644
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
index 79816fc5a01b09bbb2f07db6b0fa6a8f9060e30c..0838b65212aa4b077a8ecb0b21807f886a397193 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1094,6 +1094,70 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 0d6c34e17082cc7c52dd9c5d5ed1e964925b3f4b..5dc84c8e5e803014053faa0d892fc3a7259d40e5 100644
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


