Return-Path: <linux-kselftest+bounces-30859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA7A89C18
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F31F3B91E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150492BD585;
	Tue, 15 Apr 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JfDCDolV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189F29E057
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715878; cv=none; b=gpKfcPbGsQcGlneC4h1IHW2SIqNVCOdEKk6DBa2E1bTVGP4Dpdq0+/rtnzrpOFxjwTF0cO5nOoeR/JSTCdmN66pxfyfa0jRYERdoRrR7SpE/SULfQJb39UN1gDpXW0+dLbIFH72njNJoDGc0MSL2qwfLg0OWhIxoHAvbcFbbCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715878; c=relaxed/simple;
	bh=tkMTNHYy1IP8criuCtWawbeRzr/0TEcKezDOnHfMX10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sbRTaLBpjWMrMsfwQmIIV6Diwz44FFSiU/Sr1tiF23yqwlUfBdKYpPscmyYsp872bTUrbJtqHhaygvmlCLJDMS4LDjST5tL4f3chtl70iTBG6C9OQA/LFxIsBoU090T927sLKRS2yS1InDxrL5dX0TzGlb88A17Kn+nx8hY4woQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JfDCDolV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso59023695e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715873; x=1745320673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iip5t9IVRYddkbwxUsheGgszhhgYtHmqVexEl563WV0=;
        b=JfDCDolVlGTjbKvIOxYQdL0C5xvQ+VnChXVNw9Ii4fR8E8CEAV8jOXWD9e1t5TzhNC
         7atD/2ejpfpElRSve6orw213qXvPz2lhbq4bpJkKBAtY4hoHA1B9uhRN3wMOyLSjtxEU
         DWLPS7vHZNS3BWon16cZpbSO2UinRWg7utROOKMAcCVU4z3f83l2d93LvWda/SrGDH1R
         DyBvSEKYhxouUYBBzffkL6VzutE1rCuyvurS812cKpuwQcOnsmfFvs0ek8VWVxQKd5Ka
         X8l7O638bm0XCuG1D/cysekp8O1pN6DuY258CNQZXqc0ZHWhn+kbBWypBwdOmrCpSsVR
         mTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715873; x=1745320673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iip5t9IVRYddkbwxUsheGgszhhgYtHmqVexEl563WV0=;
        b=ITq50wiq7v9IYOlqQDt6dNFDD8pFU+zmw+Jtc8LHbLN8YDlG7HxdpNkAlf0TrCF+Wy
         1YfG1sMjIoyJ2qnaQFq1ZNWv1Zt86Oo8r2lrY2HYgRHgSqDaHHxfUrWmWuM2bRRz8w3I
         sgdCcHjNEbdE4RyXy4uScsE4BLI9FzVD/0OyPawFFo3kcDiot/mFuMI0cnvgUQcakOsW
         H8D31v/sLHf2UbFpAoLMUOUNtXxk63AozXMLvUB1nvP3wIoMmqFP/8UhIx6eam+T/Rz1
         T/Ro/xB/nQR6qZ1LKgpcfijw6gBeICpdo8I00oC0FUkw2QGI8QILev6VXusLuSFYo619
         dsnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCWcixyojS2Mr6pH1Ig2nPzQ0JaNLEorhBM2DDyWwJYibjmx6G0b1L/1/oznVes8MyupwD6A2nI8lxbvweHEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUy2dvayimYomOw/p9hl8fma7rPZO0xm8Y9xb1xuNFZkCURNHg
	QdaWFH50RcyLZtmza3GKnwioqaWRkYA3kvhIVL/C5R8Ug0xNUwOL02CAFNcT5IhcsLHMAdNNGHr
	bUgKmskt6HaObaO5IJqGMljhj8hEXTb0YzUkuJo6HTw5UOP6J76I+lyDdoNg=
X-Gm-Gg: ASbGncvIWPnakSqoLLNUa59rlQPs6e4ommF3XmBG3Hzh/6i5ZjyCJHJYIfXJ7QaQqXH
	BAu7cCm69v3ig1hy2I7h6XFvaD8sJCJwuQfFUequUgmsNf5FkRF+EV5doL+9vuegRpNf3YD5+M6
	f/9pqOE2BeobxVxnHXmN7YNbuz68kLybrGmt5H1TAYBcYlLstzTQiyB7gaSgghrYv63QXOzifrL
	B8unDgyF3D1zB8hk7o5UwDk4atlT04yHX43Mel9JfBTZweo8vQmk/Xm7jzD+yNGLH2feY7c3J7M
	2Rf87qmflVt73RFuWpqQl8lXUg0ClDHJAN4ipQ==
X-Google-Smtp-Source: AGHT+IEyNCYbaCGeX6svbgDCPw199qHQY6Kdr9kL5mqdxQjun3z+89Goflp3fK31rR59d20VxlQMlQ==
X-Received: by 2002:a05:600c:4fc8:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-43f3a959ed2mr140655835e9.19.1744715873164;
        Tue, 15 Apr 2025 04:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:52 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:37 +0200
Subject: [PATCH net-next v26 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-20-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5986; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=tkMTNHYy1IP8criuCtWawbeRzr/0TEcKezDOnHfMX10=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGf+QEKjHEM4Xs2/C/31hukq4mjln7Yur8hHDKB5gUvSJuZSI
 IkBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJn/kBCAAoJEAtw5TqgONWHySEH/jHJ
 93PWaWVa1Zbu8Rah6u+lckNfJLR4HGhDBwQ11aCExWF7RV1Amu3FVQihhX+dfVdTppaJp+uU4fH
 pyHjtHG2uzd3AphAEoywHRwNwzWU2oCuUVxDpHFA90MHp6FrXWrUNRbGjDPgiEZeYsNRF2FeQRI
 L2xIQSWLhoY3ZBKJNyoum8CZE//N5VzlBMLDb7XOWSRaSRCv+iR3zdPh0Fu8XsiOuBV/Jx8n45i
 5Rbm/cnXuR09dp7GYadJzQVpgRakXQ3IL9VrS/JgD3E/mEm9YKgmwS8hmr3M4H5weI2J/IbMcQB
 oqzzW2Wa7i6YOhvJrEKAJiJhA9t0fE0wn5qt9RU=
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
 drivers/net/ovpn/crypto.c  | 22 ++++++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 14 ++++++++++
 drivers/net/ovpn/netlink.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 104 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index deeefffc098162b17ea53eb7a5de6b0f19a38022..90580e32052fb56c646a6df7816872366133bc75 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -54,6 +54,28 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 	}
 }
 
+/* removes the key matching the specified id from the crypto context */
+bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
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
+
+	/* let the caller know if a key was actually killed */
+	return ks;
+}
+
 /* Reset the ovpn_crypto_state object in a way that is atomic
  * to RCU readers.
  */
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 487d24a7d26635c9ca0fd66c75717502f60e7a0c..0e284fec3a75a0a5933978ea9d136f87a2e5c57a 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index fd8820c7d133707b7ba52462218c428fdeca24d5..dd8a8055d9676e4b57cf9b5dc0ff1d082d231850 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -245,6 +245,20 @@ void ovpn_encrypt_post(void *data, int ret)
 	kfree(ovpn_skb_cb(skb)->sg);
 	aead_request_free(ovpn_skb_cb(skb)->req);
 
+	if (unlikely(ret == -ERANGE)) {
+		/* we ran out of IVs and we must kill the key as it can't be
+		 * use anymore
+		 */
+		netdev_warn(peer->ovpn->dev,
+			    "killing key %u for peer %u\n", ks->key_id,
+			    peer->id);
+		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
+			/* let userspace know so that a new key must be negotiated */
+			ovpn_nl_key_swap_notify(peer, ks->key_id);
+
+		goto err;
+	}
+
 	if (unlikely(ret < 0))
 		goto err;
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 1f4220021df3a6e74d6e8946a58882bf5d66e444..f0b5716059364a1deee1c7d4da1d5341b53dffca 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1103,6 +1103,70 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
2.49.0


