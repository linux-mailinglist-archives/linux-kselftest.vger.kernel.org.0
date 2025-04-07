Return-Path: <linux-kselftest+bounces-30299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E4A7EDDE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E357A4E68
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08312221DAE;
	Mon,  7 Apr 2025 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UFLBUz99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA952561BC
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055261; cv=none; b=BfGUMy0mNQwLVT+bRzQ4LLSY7s3XdkFZwgByNj9zZ0nIVXO72uJ4m2QOhxI0k4QnBO6COXTUf0wctxCKGPXQ1aUPPpW/BqcYCob3rzhOrlzEYlS0z5symbunF+MLNvhax4wZdQUoRqghu05D0FGcM8zANoDfX1ffqMo2oDrUXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055261; c=relaxed/simple;
	bh=XTid7uVVlV+6fiZEfjACb8yFg8M/YDuDh3HiFrhDM84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hd0097fP+TvquB9v004EEPFcyzRvF6W9EA7sfNuk9nBGUvxB/QmAHVtj7ztbj7v0awYOPdN2JF9+P0jDVXLGTmmg6RtTC1NkTKyjFSNeORQs/qVO5/PYfQHmsInMjjvjfP37vYl8PtpywrzQxEtZsopQvUXvq8Y2Oxr3dNoiNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UFLBUz99; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913958ebf2so4251831f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055257; x=1744660057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B/ccQ1iDOH2fEqZYQ9LnhaZ2uFMp+93lt3DSJMWyUk=;
        b=UFLBUz99AVIW3o1tJqRt0a3r+4bTwSt6cY3sgqcVoyiYxTRSLF2ltMvAcGtVP2MHfo
         19RPXOMt2789DsvHOTDwriAm/IKZEoyJmCz9IlCBE88uH8SiQ7tw5L+m57em7O3BFP4o
         qxNbs0fHRNG/nNqvjYWrVus1chUbafI3Ig4PHWTrj2J1l7dbm6EvKPSjMvOoCi9Oanyv
         Gm23at3JaYdL9r00x5pLMzIMw7VN8LkB6Q3Z53kbPov7U0rZxSnBgoIbW0BY/wMlrspe
         cxcpc67wpyvaIfUYxzzCTpFIn/RwTHWvGdsv09NevIbe2S9kADSL4WYsDyZX6PHC2YDI
         NUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055257; x=1744660057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B/ccQ1iDOH2fEqZYQ9LnhaZ2uFMp+93lt3DSJMWyUk=;
        b=PdiF7sJva4acKxFsVBiJ4IX92vPbSYyC8+gbf/hJibLOz3E/+oNi0Sw2OVcA+BtLJL
         Hbwk4iLE0AtkFTLhOFOXwaPNOiL9BmCMgDtdQwzrvuMssF7/MnCuX1GB4tRSMyl1gfAE
         xGvd47AsWcZmlemOpkZ52rgA8dMKeO9O477Z5ZEoZsN0H2tgq/qUQguLuEkoE4qoFfYb
         +MQjxYxQq5D5i9SUlbRgV8h8wR7roU7t04P/GzBDhePGO8hYFhjWr66s3MLMSWiR7LMD
         HsqEpbRDPwuiPOP3oyhewrxtiObKySEn5CqJUPdn626sqbVp04crz3XkXLxgiz0CSmrP
         x/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWyjhPBEXpP+vTEELxdYAVa6+WJQJQYyBX4Z7IBaz3YR0F+5os/ZbveLsrgANzhtvVGkKL/qec/pUVMf15rzPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXNMECFLrRUNg1qREALp4bOuFzJIuSmLcx3WTNH75dbZDxC0d
	ku4N7Ce8idovijjr2d56o0/fxIyByTYSyeLoeW+dZhAXBTOphBqVf2EMoI7SGQIgvfZOmMgVRa4
	iGrNd8BQolGtDnBjGtUfRodgraK8AWM2p1zApl/g9QpsMpiHJ/Zf5KRgETsU=
X-Gm-Gg: ASbGncuaormiLmDEkqYnrfTsyOnNX8/MQqqaRe/5AcWWz3rE73dQdRLuISAkgsgzvI5
	Vr4DRXUk2VWiGVUujgsqnY5vr39IbVurn4X2u1O/TkvHAwnUu984RjqeAZdXgSauEXSjoobz8h3
	gMjJyQoTk3VoCDytR8tFp5Gw0F9Tnl83lzNQXIu0uksL/gCQEfggxNELeRMxbTvWws57fd7u8Mt
	+33Tffy4uaPX/9idRY95NybI7o/P3dtlZepL5ECfRcE9w4CYooEsy9J34NuL4dgbZWPcRGRAANO
	fbnhGjamaLHuuUXM0+i2g9KH/jN/QEdK76x2hP7qyg==
X-Google-Smtp-Source: AGHT+IEPRsqfimd2/41s54l5OsNXLJusoRtIfQyjibCGaDwun9ry1yP4hNpVgnOwQ9AjYiWnMuLjrA==
X-Received: by 2002:a5d:64ee:0:b0:391:487f:2828 with SMTP id ffacd0b85a97d-39d6fc0c2e6mr8480401f8f.10.1744055256590;
        Mon, 07 Apr 2025 12:47:36 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:36 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:28 +0200
Subject: [PATCH net-next v25 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-20-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
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
 h=from:subject:message-id; bh=XTid7uVVlV+6fiZEfjACb8yFg8M/YDuDh3HiFrhDM84=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu2Qr752tIAGl0p/A2cGjbhW1PGPYn8Xlj1u
 lLBHmsozxeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtgAKCRALcOU6oDjV
 h8fVB/0eXAqvzMAJzcq0a6hDPpVw8O5PNedl87Yic5kZmWZ69pEhwcrYPxyQ3SFlQZsJq7vfhyD
 KOUaPXrrCVq6mBgumC1G+gPFE/RKganrlsLhX/fVQo5fRC+Aj/E9zyr+nsFq+zWYUGYURdfGKXT
 Gd40IIUDakQG//KKcYCPiKxK9z6NG/qKvo048Uh3/bK+PBs25J4vSv2gZjtm0jr+BGHhQWM5UwH
 Xneeg1mbhDgfZXAZD6eS6+c94du9TRGTHwTSpPpBK16HdsEB5uoBrN8a9vOtmoIyjjzfX9SrswS
 cYJ4T9DsaDVxXNqbtGpxNALaT8rIshwI2RsOfgJ7JqBZhZ1g
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
index 07be4edf0dda060de2ce4161e323a2c2ee40591d..d83ead5c2c87a46709fc5458b3ada4553a8f26fc 100644
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


