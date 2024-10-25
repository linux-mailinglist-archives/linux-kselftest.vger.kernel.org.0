Return-Path: <linux-kselftest+bounces-20644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A719AFDF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB75C1F23E4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C7204090;
	Fri, 25 Oct 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NfxV5m22"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D62003B2
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847720; cv=none; b=RdUIby/8sfMpzuLExY6O/FQ6jSsBAyffqSVHYTIYJwPc/lKwpyPcB607XcKC5wMRTauKQQyfmk2b3THw4p8kOt/75Rd2q75KyyMeF31uM8W8hyg6c3l5jA/oHDe2T1d+KSQeVvAHAm3QOUPvDJVCaVK94hAMy9C4MdP+w+cV06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847720; c=relaxed/simple;
	bh=J8d4iPCACFjh4RPZ73470DF9BW2jmMoUHGooQOibiPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKeG/Xf1Lg5pC2OcP2xF8ZCV+8Ut22qr6Pau65tD8N1tbkjSgqEZ4n0TTx69g2S2RZgcGbhXrzwFdog1npc1QnBKwc92fgbH723+jTmU0J1j5cKIYB31c+utwIe+jsJXJLolmZfhanlWB9sNpKevVcBvQ/o+dDCT/zRk7P0loYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NfxV5m22; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so18417465e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847713; x=1730452513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68t+4emiJOMGD7jO3lAM+Og+n+MVyNlVZH1VmphoocY=;
        b=NfxV5m22QfSwnxOo5pRXbjosA0KtfjY8Pj5JyrffeyA/l9fQ2t73bvwd/xHQ5BLg8L
         gI4cI9kwlORGBmqZt6jSplZdgqkZyJwG88yfn26ucmH5+K5YU5hcFH/qJFE9gBNi0MxL
         ZO8NtLgr7fc3N/8htG0BszHV7mRYC2VXUrwKk3ecm8ePm5PkVeOs9Ce/1l3J238TgYb6
         AZ7pwMgDsvL9eDpHMtyY/OoyZvuhwvCnCWhTe6m4NfEL0RU1SDf6FNpy3Qpx4pItD+3y
         sNs1/A376DOxkZK8QyI5/2SzAATI2J7YJdEYUtOjYfbSNuPu6YOoC3fa4VBoKTSHH8jE
         OEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847713; x=1730452513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68t+4emiJOMGD7jO3lAM+Og+n+MVyNlVZH1VmphoocY=;
        b=Nsl2NEY1lvNpAmLWTFdmxGNF5E/ZoSTB+5DIB1rPBe42iKdlVbdh6rK0LjNhXVaEBE
         OEkOXsTYqL3e7tqJh4rcNxBZCvk1Uat9+i8Ub03YO086XwWvJKS/UXWBEnWX5nFTEX82
         2kBvjBthfTuWp9pOpOyLPvE8D+WbIMgyXiq5LOUnbFoyFNyNVJqk9BjpCNa7maHqZMj7
         sgJy2v4t2wPzLcoaR6np5angblAdTi8dg19LA0hk/YwAck2wpngSu1SdSwxfnNYLH+uk
         B6JMPbqLGc9iJT5c19dxGRgR/p68+IjuKNlFqua4T8PhXv4HicqjLA5CM9rd9efflWb5
         neLg==
X-Forwarded-Encrypted: i=1; AJvYcCU+c4aM03LnRAKbLcRwBeRRrWZO+XPK+1FQdoA0lvqa8A07dADdy11c0vlvZ5P+rn3C3N11uDBxRnazDPPnq9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0kovuvQlAkNN4s/NhVWqnRtXFgiiLaOsoIVrAIjoAQDwKkHH
	tXotde9mtgj4wden7qWjtxclujvomtfXwvUHrF3Z8csHXIo335OIjhkOTSaZI3s=
X-Google-Smtp-Source: AGHT+IHSlNji8y4ikgFbo4g+sJk4zLQ9z0/E8alqzErhmHQld5vCAEJzHk6CG1eMF6rLYnngJJqmUg==
X-Received: by 2002:a05:600c:4fd4:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-431841341ccmr66738935e9.4.1729847712943;
        Fri, 25 Oct 2024 02:15:12 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:12 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:14 +0200
Subject: [PATCH net-next v10 15/23] ovpn: implement keepalive mechanism
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-15-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14945; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=J8d4iPCACFjh4RPZ73470DF9BW2jmMoUHGooQOibiPM=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOnSibOa5787sGVHyKaFd0PL35wvWqIVs3/7GnWrHbtnJ
 Z4xevPtQCejMQsDIweDrJgiy8zVd3J+XBF6ci/+wB+YQaxMIFMYuDgFYCLT9rP/0/6gveru6V17
 da33sbPvOO5wnKWiX8ZZlu2Ur3pPlef6uC2cOU2pcUnPJ5jliKmmCU1Z8i5fR47Hv0WGgaHARt+
 7w2DlCuZdV5jiRN9Yca7iv/n+ymEz9x7vmVZtYrzNJ1i5noe6JVo8DHnn1Rv9nfnqFvs7egILy8
 yP1gkxuV/q9i3jnbPemymiubvG1MDSSOGxyYT5P3VTJna8cYw1X3/smffCCtZkof5knTmXZN02N
 nVk2jDa/GI0dHlQE3wpXm5z9D7+iqi09q45Ryp+pU5z/5wqUhWTyJg1z8B434fTqTXei7ZkGtmu
 q6w4sM/ZTIPhc8QarndyLy7ZBjkK6DWlHY0w42c2SpYFAA==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

OpenVPN supports configuring a periodic keepalive packet.
message to allow the remote endpoint detect link failures.

This change implements the keepalive sending and timer expiring logic.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  77 +++++++++++++++++
 drivers/net/ovpn/io.h         |   5 ++
 drivers/net/ovpn/main.c       |   3 +
 drivers/net/ovpn/ovpnstruct.h |   2 +
 drivers/net/ovpn/peer.c       | 188 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  15 ++++
 drivers/net/ovpn/proto.h      |   2 -
 7 files changed, 290 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index deda19ab87391f86964ba43088b7847d22420eee..63c140138bf98e5d1df79a2565b666d86513323d 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -27,6 +27,33 @@
 #include "skb.h"
 #include "socket.h"
 
+const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE] = {
+	0x2a, 0x18, 0x7b, 0xf3, 0x64, 0x1e, 0xb4, 0xcb,
+	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
+};
+
+/**
+ * ovpn_is_keepalive - check if skb contains a keepalive message
+ * @skb: packet to check
+ *
+ * Assumes that the first byte of skb->data is defined.
+ *
+ * Return: true if skb contains a keepalive or false otherwise
+ */
+static bool ovpn_is_keepalive(struct sk_buff *skb)
+{
+	if (*skb->data != ovpn_keepalive_message[0])
+		return false;
+
+	if (skb->len != OVPN_KEEPALIVE_SIZE)
+		return false;
+
+	if (!pskb_may_pull(skb, OVPN_KEEPALIVE_SIZE))
+		return false;
+
+	return !memcmp(skb->data, ovpn_keepalive_message, OVPN_KEEPALIVE_SIZE);
+}
+
 /* Called after decrypt to write the IP packet to the device.
  * This method is expected to manage/free the skb.
  */
@@ -105,6 +132,9 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* keep track of last received authenticated packet for keepalive */
+	peer->last_recv = ktime_get_real_seconds();
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
@@ -121,6 +151,12 @@ void ovpn_decrypt_post(void *data, int ret)
 			goto drop;
 		}
 
+		if (ovpn_is_keepalive(skb)) {
+			net_dbg_ratelimited("%s: ping received from peer %u\n",
+					    peer->ovpn->dev->name, peer->id);
+			goto drop;
+		}
+
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     peer->ovpn->dev->name, peer->id);
 		goto drop;
@@ -221,6 +257,10 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err;
 	}
+
+	/* keep track of last sent packet for keepalive */
+	peer->last_sent = ktime_get_real_seconds();
+
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -361,3 +401,40 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
+
+/**
+ * ovpn_xmit_special - encrypt and transmit an out-of-band message to peer
+ * @peer: peer to send the message to
+ * @data: message content
+ * @len: message length
+ *
+ * Assumes that caller holds a reference to peer
+ */
+void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
+		       const unsigned int len)
+{
+	struct ovpn_struct *ovpn;
+	struct sk_buff *skb;
+
+	ovpn = peer->ovpn;
+	if (unlikely(!ovpn))
+		return;
+
+	skb = alloc_skb(256 + len, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return;
+
+	skb_reserve(skb, 128);
+	skb->priority = TC_PRIO_BESTEFFORT;
+	__skb_put_data(skb, data, len);
+
+	/* increase reference counter when passing peer to sending queue */
+	if (!ovpn_peer_hold(peer)) {
+		netdev_dbg(ovpn->dev, "%s: cannot hold peer reference for sending special packet\n",
+			   __func__);
+		kfree_skb(skb);
+		return;
+	}
+
+	ovpn_send(ovpn, skb, peer);
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index ad81dd86924689309b3299573575a1705eddaf99..eb224114152c29f42aadf026212e8d278006b490 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -10,9 +10,14 @@
 #ifndef _NET_OVPN_OVPN_H_
 #define _NET_OVPN_OVPN_H_
 
+#define OVPN_KEEPALIVE_SIZE 16
+extern const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE];
+
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
+		       const unsigned int len);
 
 void ovpn_encrypt_post(void *data, int ret);
 void ovpn_decrypt_post(void *data, int ret);
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index c7453127ab640d7268c1ce919a87cc5419fac9ee..1bd563e3f16f49dd01c897fbe79cbd90f4b8e9aa 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -191,6 +191,7 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
+	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
 	err = ovpn_mp_alloc(ovpn);
 	if (err < 0)
@@ -244,6 +245,8 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		netif_carrier_off(dev);
 		ovpn->registered = false;
 
+		cancel_delayed_work_sync(&ovpn->keepalive_work);
+
 		switch (ovpn->mode) {
 		case OVPN_MODE_P2P:
 			ovpn_peer_release_p2p(ovpn);
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 12ed5e22c2108c9f143d1984048eb40c887cac63..4ac00d550ecb9f84c6c132dd2bdc0a3fc0ab342c 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -43,6 +43,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
+ * @keepalive_work: struct used to schedule keepalive periodic job
  */
 struct ovpn_struct {
 	struct net_device *dev;
@@ -54,6 +55,7 @@ struct ovpn_struct {
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
+	struct delayed_work keepalive_work;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c7dc9032c2b55fd42befc1f3e7a0eca893a96576..e8a42212af391916b5321e729f7e8a864d0a541f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -22,6 +22,34 @@
 #include "peer.h"
 #include "socket.h"
 
+/**
+ * ovpn_peer_keepalive_set - configure keepalive values for peer
+ * @peer: the peer to configure
+ * @interval: outgoing keepalive interval
+ * @timeout: incoming keepalive timeout
+ */
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
+{
+	time64_t now = ktime_get_real_seconds();
+
+	netdev_dbg(peer->ovpn->dev,
+		   "%s: scheduling keepalive for peer %u: interval=%u timeout=%u\n",
+		   __func__, peer->id, interval, timeout);
+
+	peer->keepalive_interval = interval;
+	peer->last_sent = now;
+	peer->keepalive_xmit_exp = now + interval;
+
+	peer->keepalive_timeout = timeout;
+	peer->last_recv = now;
+	peer->keepalive_recv_exp = now + timeout;
+
+	/* now that interval and timeout have been changed, kick
+	 * off the worker so that the next delay can be recomputed
+	 */
+	mod_delayed_work(system_wq, &peer->ovpn->keepalive_work, 0);
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -815,6 +843,19 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 	}
 }
 
+static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
+				enum ovpn_del_peer_reason reason)
+{
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_del_mp(peer, reason);
+	case OVPN_MODE_P2P:
+		return ovpn_peer_del_p2p(peer, reason);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /**
  * ovpn_peers_free - free all peers in the instance
  * @ovpn: the instance whose peers should be released
@@ -830,3 +871,150 @@ void ovpn_peers_free(struct ovpn_struct *ovpn)
 		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
 	spin_unlock_bh(&ovpn->peers->lock);
 }
+
+static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
+						time64_t now)
+{
+	time64_t next_run1, next_run2, delta;
+	unsigned long timeout, interval;
+	bool expired;
+
+	spin_lock_bh(&peer->lock);
+	/* we expect both timers to be configured at the same time,
+	 * therefore bail out if either is not set
+	 */
+	if (!peer->keepalive_timeout || !peer->keepalive_interval) {
+		spin_unlock_bh(&peer->lock);
+		return 0;
+	}
+
+	/* check for peer timeout */
+	expired = false;
+	timeout = peer->keepalive_timeout;
+	delta = now - peer->last_recv;
+	if (delta < timeout) {
+		peer->keepalive_recv_exp = now + timeout - delta;
+		next_run1 = peer->keepalive_recv_exp;
+	} else if (peer->keepalive_recv_exp > now) {
+		next_run1 = peer->keepalive_recv_exp;
+	} else {
+		expired = true;
+	}
+
+	if (expired) {
+		/* peer is dead -> kill it and move on */
+		spin_unlock_bh(&peer->lock);
+		netdev_dbg(peer->ovpn->dev, "peer %u expired\n",
+			   peer->id);
+		ovpn_peer_del_nolock(peer, OVPN_DEL_PEER_REASON_EXPIRED);
+		return 0;
+	}
+
+	/* check for peer keepalive */
+	expired = false;
+	interval = peer->keepalive_interval;
+	delta = now - peer->last_sent;
+	if (delta < interval) {
+		peer->keepalive_xmit_exp = now + interval - delta;
+		next_run2 = peer->keepalive_xmit_exp;
+	} else if (peer->keepalive_xmit_exp > now) {
+		next_run2 = peer->keepalive_xmit_exp;
+	} else {
+		expired = true;
+		next_run2 = now + interval;
+	}
+	spin_unlock_bh(&peer->lock);
+
+	if (expired) {
+		/* a keepalive packet is required */
+		netdev_dbg(peer->ovpn->dev,
+			   "sending keepalive to peer %u\n",
+			   peer->id);
+		ovpn_xmit_special(peer, ovpn_keepalive_message,
+				  sizeof(ovpn_keepalive_message));
+	}
+
+	if (next_run1 < next_run2)
+		return next_run1;
+
+	return next_run2;
+}
+
+static time64_t ovpn_peer_keepalive_work_mp(struct ovpn_struct *ovpn,
+					    time64_t now)
+{
+	time64_t tmp_next_run, next_run = 0;
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
+		tmp_next_run = ovpn_peer_keepalive_work_single(peer, now);
+		if (!tmp_next_run)
+			continue;
+
+		/* the next worker run will be scheduled based on the shortest
+		 * required interval across all peers
+		 */
+		if (!next_run || tmp_next_run < next_run)
+			next_run = tmp_next_run;
+	}
+	spin_unlock_bh(&ovpn->peers->lock);
+
+	return next_run;
+}
+
+static time64_t ovpn_peer_keepalive_work_p2p(struct ovpn_struct *ovpn,
+					     time64_t now)
+{
+	struct ovpn_peer *peer;
+	time64_t next_run = 0;
+
+	spin_lock_bh(&ovpn->lock);
+	peer = rcu_dereference_protected(ovpn->peer,
+					 lockdep_is_held(&ovpn->lock));
+	if (peer)
+		next_run = ovpn_peer_keepalive_work_single(peer, now);
+	spin_unlock_bh(&ovpn->lock);
+
+	return next_run;
+}
+
+/**
+ * ovpn_peer_keepalive_work - run keepalive logic on each known peer
+ * @work: pointer to the work member of the related ovpn object
+ *
+ * Each peer has two timers (if configured):
+ * 1. peer timeout: when no data is received for a certain interval,
+ *    the peer is considered dead and it gets killed.
+ * 2. peer keepalive: when no data is sent to a certain peer for a
+ *    certain interval, a special 'keepalive' packet is explicitly sent.
+ *
+ * This function iterates across the whole peer collection while
+ * checking the timers described above.
+ */
+void ovpn_peer_keepalive_work(struct work_struct *work)
+{
+	struct ovpn_struct *ovpn = container_of(work, struct ovpn_struct,
+						keepalive_work.work);
+	time64_t next_run = 0, now = ktime_get_real_seconds();
+
+	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		next_run = ovpn_peer_keepalive_work_mp(ovpn, now);
+		break;
+	case OVPN_MODE_P2P:
+		next_run = ovpn_peer_keepalive_work_p2p(ovpn, now);
+		break;
+	}
+
+	/* prevent rearming if the interface is being destroyed */
+	if (next_run > 0 && ovpn->registered) {
+		netdev_dbg(ovpn->dev,
+			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
+			   next_run, now, next_run - now);
+		schedule_delayed_work(&ovpn->keepalive_work,
+				      (next_run - now) * HZ);
+	}
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 942b90c84a0fb9e6fbb96f6df7f7842a9f738caf..952927ae78a3ab753aaf2c6cc6f77121bdac34be 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -43,6 +43,12 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @keepalive_interval: seconds after which a new keepalive should be sent
+ * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
+ * @last_sent: timestamp of the last successfully sent packet
+ * @keepalive_timeout: seconds after which an inactive peer is considered dead
+ * @keepalive_recv_exp: future timestamp when the peer should expire
+ * @last_recv: timestamp of the last authenticated received packet
  * @halt: true if ovpn_peer_mark_delete was called
  * @vpn_stats: per-peer in-VPN TX/RX stays
  * @link_stats: per-peer link/transport TX/RX stats
@@ -91,6 +97,12 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	unsigned long keepalive_interval;
+	unsigned long keepalive_xmit_exp;
+	time64_t last_sent;
+	unsigned long keepalive_timeout;
+	unsigned long keepalive_recv_exp;
+	time64_t last_recv;
 	bool halt;
 	struct ovpn_peer_stats vpn_stats;
 	struct ovpn_peer_stats link_stats;
@@ -137,4 +149,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+void ovpn_peer_keepalive_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index 32af6b8e574381fb719a1b3b9de3ae1071cc4846..0de8bafadc89ebb85ce40de95ef394588738a4ad 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -35,8 +35,6 @@
 #define OVPN_OP_SIZE_V2	4
 #define OVPN_PEER_ID_MASK 0x00FFFFFF
 #define OVPN_PEER_ID_UNDEF 0x00FFFFFF
-/* first byte of keepalive message */
-#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
 /* first byte of exit message */
 #define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28
 

-- 
2.45.2


