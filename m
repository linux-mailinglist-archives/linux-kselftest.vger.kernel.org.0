Return-Path: <linux-kselftest+bounces-28862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104D1A5E5E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2643BD234
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB691FF1D8;
	Wed, 12 Mar 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hG3v9/xd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884520CCED
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812897; cv=none; b=gf7OHVjQLF8HF/KhJIVoHqcRaIFX5r39lqhACSOxcg4tcH03+Vy1hnFoGvHEMpxkzcyOgDW0Twjtt/3Paf1yshA/JLR6Inwbv+SfGYHChZOBAKqUAor8qE+4iBmT8vN9vgKgAPOKqHmH1Lc/C9T+ewRnls+RHp/PVVvmg9wzF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812897; c=relaxed/simple;
	bh=JSwqVjxBeHU4RACyPp9B4KuNViAULCMe3no65khXe0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXVsxpLGPiN8q1H+WyehDI1rbG7xKJuhzrTTFkZYIu9wWUQfdoh9pgQEGqqVhReM4Xs7QMZ8gp1W5ru57OJWsUzGEGDTircIusdRmWwV1q5y7MTFRfh/6u8HNKUCl7+euNKq2CYdPl8gCFnw42LIplpLK777nor3Of9J+qPbiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hG3v9/xd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913fdd003bso172633f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812892; x=1742417692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVuW3EWeVsK9JR3HnkSCXUo7RY6n+BdBr5woCe0mSnk=;
        b=hG3v9/xdOp57qUaWryJVAkFgHJ8s97t5YZs+1JQ2zTS20+23MuDvCWAofuTm8RiY3K
         rNsqM7DRIeLw9ODOP0Ywy3P/rjzeWj3BDnTXf9GTOcBnckZsidoRInG7Avxqn7ki9xH9
         GOf0iObZ91U52Lm3oAHfDOl8A3NTEMDnfmfcu8rrm9vQyAW9+Omg+xtp8LDSjzf5aYLj
         yQeM9WQ2ugpbau0iPoVL8H2fVyzhnzRBhlxbyaYgal4x4/kBsxEDV7MnzRYTP8CsZmxm
         TnqSBEPlMbCwpEyy1F9bSqkKMmHUjAnIA9B60m26s+flk+fw4Bo9v1aqCROc71cejLYm
         6D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812892; x=1742417692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVuW3EWeVsK9JR3HnkSCXUo7RY6n+BdBr5woCe0mSnk=;
        b=pA6P/2D5yVzjUm+pEgH/dntyvfxlgtlneBlPaNdq2ztGTymCTIE1M4c0ZYt9EuGrFB
         U69TYyjW4/w5I+gEzBbrzq03+ma6SRB/fH8rM0HFMhs6E7k1xrkXVoyzLvc+azNRP2RT
         DrjOP1VkZleK2QhEz9oFoqkkdU4LvGUUdCNoF+ik9kfWsRY9GlvQ8VYJLVEpZAMsa3YD
         6i8wd7CZ+0EPNOqXLUPMi7jakiAAdGC47ZTjqvKN+N4fz2sBEBoki9WLqK8pDaI/J+bg
         9BSCkXbgeMDES6kPWs7R78LJsK2fpsaDMnOYBRkGrqHs2hy9Y3+0lBkrx6+AvbWYXyqp
         fasg==
X-Forwarded-Encrypted: i=1; AJvYcCWfxuha1hdjeX3rjGa9HmfDSgHliAbhCiNCZBMj2IKrwmM6+wwyzrhgt1tIFLmaeSqJSQM3Qzrchup5pvkn1Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4ioPbL3RA1nqRNbaR3L5eEM3Ff5vhjn3Lq7pwK9NdMvCt/vh
	a7lzj/aDRu0dnxZMCYRDIKqhjvxSqpLk3ch7rWT2NsdAH7zMfU9fLWTGP6Q9v7w=
X-Gm-Gg: ASbGncsSAAD8JAbeArv4jdP9JQPOTnZMjpP7UOok0/mkkUjxMk3jSahTRKCEhM6AyQL
	mKdHfp9sZekOvDiS1C4A8SLf4VG36jO3ZEztI/tDva5vw/l4ESdvTKTPLTYaKKeWq0Pch2Ty9EZ
	GSqne0Ap94rbz+E8AcT9LFQM5oeHpHipAblu9BW9tpvU7ZGYZ4w+Y1oGJucXPKC3Rd3ND6XMDAe
	pPuKm8u1MzxlK0fUBxh0LcExfivKQq45bXkUik4EkcP+54WiTm+VyotIt8kHU3ZbE/PthhpnHsq
	Up/s8ruDRLO8wuFC7EgNunWL6nSlhszCTcpq+lAS6w==
X-Google-Smtp-Source: AGHT+IGvzQi+likdI6Oaqk/TH/1q033q2DE+QddC1Idh9bv5bAEiMau09ALgvQR7B2FVM31RJVYykw==
X-Received: by 2002:a5d:64a8:0:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-395b70b6cabmr11195f8f.1.1741812892433;
        Wed, 12 Mar 2025 13:54:52 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:29 +0100
Subject: [PATCH net-next v23 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-20-76066bc0a30c@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=JSwqVjxBeHU4RACyPp9B4KuNViAULCMe3no65khXe0Y=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR8T9mQm5JueJ9e/TTQta6UwXcJoW/NVN6Ok
 MNTB9nIqyqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 h3xcCACbfTuDbkpuFYmbpeJvqdXRKpgjUACKAj5IXzr14457VYMckNKtz0cpxDXs/VcDNUrSahE
 yO8odEK4HK2cPgSlHqRaw0ede5qpfZSFwJUoESEgfTQ0d/TSgYO77bkm6mnED676creVqkSbhCB
 yOA1p0CIjT7wb6tA2+DCrzzyYE4mAW98hdj6hUdGhY+LWhDWBTSC8KV7EXtZckhApGSDfYmXbSD
 eX1EzA8ZLyPiuznz27lol6t4nQWgjQZGujovYSeGQ+NMKBe9gl2LGkFl5931pdBQpr0yVv6tbAg
 Wlun6seLD/FrJ0Lbl1KDj2q3CB/zxQMeeqJQs8MeS7E33ANi
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
index 0dedafea01858bddd457af0c95614e61c113682e..46500e4223d7619a342f803c67aa760166fa6f2b 100644
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
2.48.1


