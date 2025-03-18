Return-Path: <linux-kselftest+bounces-29326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B305A66592
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599493BABEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610511F4C8D;
	Tue, 18 Mar 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GbeqpiN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0D1E5200
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262092; cv=none; b=Ym8gUpn1KaFiLrL33DzGUDLM+aKvBWs9x/jiISH8WR8nwtK3DTkKThkQkKhB/ABSafX1sXF8wgbdk72eVaAk8FefXt8b8f0RM5RXHCPFZpHwH1ynb8G7EoL28zkn5GCcul+6G8pXO0sjZ4a3OT0sdY8CS0quaRotY5d4zmYmtLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262092; c=relaxed/simple;
	bh=GD8Rl6f+S3vTbseY94MaV9fGZR5rWoBgeUQmIJN+/CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VkGjQf0kgPXcPgU3yPJhn7a9awDsAfUAwAwg3q+Kk/is6TDLFeyl2s2dw6LJmiVYHQwG5ozz3QtxvShdf+LnFmNf0rbAw6npnHwNLVOo6c2LCPBDqi6yIInDfzXUgHk1hG6K2c4mpWcVlHKTrWgDrp7uXhE+xnNjKK/RzWO9bIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GbeqpiN+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1326334f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262087; x=1742866887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+QaWcsm/bYmbbie8Pttkb9H+MwD+6/dUPKjHa5/Jks=;
        b=GbeqpiN+92ChJewe4+RWJecTmwd5JusLLP87icHVYET5OO6oZQfgsbR9ipYFe4AdgP
         wRmc176BKSQNGekWRZGjePDsfIXlEwM2SgVl+X2B6p7fppgjPV6jKOPTywN1HDHBW2ht
         qLGr+nHHy4bVPkG284lWwPyj5yM5sdqMaP1UZ/miBxeY1b9WgLbdABaHNUGV+abPEizg
         C384rFcu3rgdH7bsm+blITHACOfZpzT/6j/q8dKKVe3+KqyvWYWt0cL0pL4c+zjsf3cg
         Cj+phP9pXJhgEyRZDYXfG1uoouvPItPjxudBXCrak+m6GAvQkleso+78wgIPDNq6WIFj
         wokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262087; x=1742866887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+QaWcsm/bYmbbie8Pttkb9H+MwD+6/dUPKjHa5/Jks=;
        b=n6BPHH1YYjtMBn6unZd6+9JKCnhS2ONrWP4Wh0gX6U3Em/Io1QayFgs4t9akn5B06x
         l7845C5M8xc1g4pFvVYvzOwEEz+2MTWNuB91hGh2Vj5A3IBZficB9JH4hu9X9Cc6y5V8
         G6mc268U/U2eVS+zgcQE1UD9Aum6/dzYqDTdng0uuRR+ZktkyfhIdq4Z3mBPha2THzFJ
         ac0KwcSqYzv7qLlu1V5mCUcjDnGJ8luYmnBT7yd/IPb8UYqgoxnotZ8J7XOVld5XzPAn
         U2rqANRhEwU85DTLT3ZU+6ut+XbiH8MV3OEIWaqjoBGd4uQZcr3ESHuZEK1cxLPSQ2Tq
         q6AA==
X-Forwarded-Encrypted: i=1; AJvYcCU/jUt0nFEH2RTf+hzvEC65zQzkKm0gYNFKy8LOrWkcn0FTC36zd5D+pOJbhgwN0m+NqoRvl7z9IO4//ydWU5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGk7ukLgODtPFPZlc/2tIxkBznOlQkzyumudg81N1yJd6morH
	gDdUc9nLlxsArenLvT5HdMYjHdnXqOo7rYy/Ys/LbdxwlZsBRZe03KoTNeUNGtHB/yk4mC5REqG
	y7Qypnih8ol5zXUPpi4ODB4BtVG2303zs/bGw3Fk4NFW3leoE2gbyd2kCRdA=
X-Gm-Gg: ASbGncsfsOGrBuXC1Q3lKrM8SZVkrchYE33YEtMXtbtcAk3EHbjd7KYh+KvK1Z3AdVq
	B49dZHooD10W9uRxW83HSTe08z7MMnI2bE1nrndKQrH+6T6m2nj/3TSz+/cDbnSZ0UpVxLH/qNb
	6bX+1lxu8MO6+RMQE/vplY4PddrLArZzTiFR4dvFxLTXUGeC8+1w6PfkWRnO2Z+yLMGQQh3MakP
	glqxJ34VcQHjmqF0Z/YaCxQGu5z9h/qyNKng9sNbx2/gABe2msUc+q3EhzxRH7k1R0sAU8wAqPV
	wxULjJWLcdR3zm+uMupnFuAD8NcchOVXE1IfNiLJBw==
X-Google-Smtp-Source: AGHT+IF+s6qt9A/xjjy3I9KcWmJiQqWMHdDVlgaD7NKSR0g0eM/LLfpwaDjMzfa0KVPASFlqZ0FYnA==
X-Received: by 2002:a05:6000:18ab:b0:391:47a7:299c with SMTP id ffacd0b85a97d-39720962980mr18611116f8f.40.1742262086823;
        Mon, 17 Mar 2025 18:41:26 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:55 +0100
Subject: [PATCH net-next v24 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-20-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=GD8Rl6f+S3vTbseY94MaV9fGZR5rWoBgeUQmIJN+/CU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8r0r1a/HV+I8gz53rdhTzlQlYXS/EFqDgSj
 CNuw5uG+KGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKwAKCRALcOU6oDjV
 h4qXB/99Yu8FqnVusVUDUGBcu+eyzJL4ROYLxnZ7Ts9NCSYoKewi6F1cuNS8JMEPjBTuzQds4Rd
 eh3B0chvkvltA1E1wr/oUn7soo6kBTX4vmXIqkCjvjX1+NrP9JX4soZyBavmYbXmoh6D6RkVcm1
 b8nKjvxpT150GeghWu1keOnQY0R0YcXNDdxDXdc4862PWF3sUem+i3IGYmM3xCqk/a8TgttrJO8
 bCsBVbyCLXsS2HdZdUofThRf7GXSMsrmXtFzkls1va9K5czMgFHKOE2NXox2KwUeYS6AcJ775BM
 X42VxVdwuFUerL+lquvsERn3F+fkqgla3yNq7RFl1kvUNnAV
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
index 3c15d6d78f0f5ceeeb5ee39bfaaa7005d01a87fc..f6cb14c9ec4a8f12a99fe449f011bd0d633bf904 100644
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
index 487d24a7d26635c9ca0fd66c75717502f60e7a0c..4397253893ff2638b86b9d55bd21e11d0aeacf80 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 49bb58868053e2d1542a8a5849c4bbc256083efc..c11ed75c62a2599bf68150be897693cc4806e4f6 100644
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
index 21784b44a897a5590bd8dc02754ca66cef841520..93152734098948b58ec1ba8a2ed05f8bb40c91eb 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1095,6 +1095,70 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
2.48.1


