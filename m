Return-Path: <linux-kselftest+bounces-22695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4F9E09CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 18:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB36EB674F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4720B1FD;
	Mon,  2 Dec 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hNv3L6iO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE120A5FA
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152127; cv=none; b=H/ewe7mqzQLtzEfTaBphA5mu1r/ZC/m/ujbgGxvpinAr1dBhqR1dlTKSci+4XTBylqz6bN6Q+I3z7WY7AboWVL65N+rlckFZv+3xv9UNUZrLoKwWOpoiw5LOXKjgo94OuL9WjPawBE1G3s7T3KJSvbF9eQfefqMkvJWdatecdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152127; c=relaxed/simple;
	bh=UpU/HyvnfKZ91xz+XPSLNFIOmICjhg1WnmleyYeQVDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPG+iABPn80MTEk6MJ2wXte01ymjiLdgBxqkq9NSPyLwWkLrSSf5gCxFkWThxnAiDrehP1fM8hILyKrxtetQnt7AzrD1AKtvtSc3fnl3pLmud1hW5TGJ4MRgNwHLkGne9CRSSpnJE9y1M8Xq8rjDMIyAowcPpx2YS5+BCdZ/Q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hNv3L6iO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e5db74d3so1452882f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152122; x=1733756922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ud1YRU8l8O7vVEEaTGlLculWMf57gX6jxPG47a0T9x4=;
        b=hNv3L6iOLHJin5gUvdYk/yPsOz6nw6Jqfz/n9OmmoFElTWSJJDCrl9DSjZ3uCneK/j
         c/KanBKIfm5M4W6LxYWKBDBjOh0uh1PLCfipTgNJJcmqJIhqL06JvDY03giRm2e+mZsj
         e3crlNpA5+qmgDBgisBnx4PbAVx/0cPDx9OKrMnfKiZ2oKItdddyykoBr/SD+tB++a4G
         sQ5sPubYG4kGMqtl0Rbsbk+f8M4xkDXOBVA1vBCYIy70PIlwR6plZK6cljmPcLo0Nb5b
         gA7ZvCMqYVFTH3kD1uG23Px+6L/doiVRa3Ki19yi5hjsaMA/Fy7Xb3cwnoWMQFCaXW2z
         QuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152122; x=1733756922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud1YRU8l8O7vVEEaTGlLculWMf57gX6jxPG47a0T9x4=;
        b=N7bXMdOycQ+tZRYUqxMzFwBfta4+pWNHdGRt/S9MNlCkexEzeKqYzP6Sqoh4w3qSKb
         ZW/J9L3LIZyKQdnWPdycvPS+qaRJF5kLW3qG6FKaQCaAswo22rbTkGRfu6Mf83uIpkJk
         OTiTv1wdLvMxOmINtyopy2tzGzcs87ggXyb+KjLOmfz6k7cAUtizfP+5QGzvtanCG/x5
         iW/J0nl3B1IiFcc9FSz8mdw6UMnf5c3LJD6lZ8opd2QJ2evfL0Tq9Y1kxObt2bE8/0V2
         ub8wNy0ZZBeGN5c8UNL6InokNRMS9vdC5a7vkcIjEyqD39t2gkw3EPOtrtIgfGelKWie
         oh1w==
X-Forwarded-Encrypted: i=1; AJvYcCUc7lg1eZyPpULIMax+LW4h34sv3Jk5F7Jxrl8mNGuWQp1nldCAOLFNzAi8oSuBLLoqmYAfSbfyMX+0A98W/zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxenTrl2rXH1sf7epqf1PYDreiZBLhzzLLXe1uugH13jLYNWMTp
	9nLI6rIWtNHk7ePmAHlwIuGzAp8Lcz9khyH/9TeSMCyVnutMN0XJu2kpu0thWk4=
X-Gm-Gg: ASbGncsWLqaakfMs7Spclz0xWgmEXQyg5bBOoq+6V0E2ozevqTMoSvA1lDMmop6tbIg
	dlkdaEvU331zVkGYHgbXWJBmymGIoamxFV7gg3xYZYttRjlkKFTzTKOMpH+fHu2zSlBjY7CR5Rj
	uRz9Xxdvi7hjtc/o0JkE9trGBAxGcxFKJdyMyVDp/HXHmn9l4ILHPSgKx1jJNpiVF3Qs75EBs5C
	JU/JXUyFlumly8aVhKq1PNFsf9lUgaa9Upe/Pb3yETFz77EeUQadZuAoNWu
X-Google-Smtp-Source: AGHT+IH8y9TCsU9fp6M58fCFtSrxZ9z9ejKgkmnbn2GK01A4ZmiUnvu0aSTY30lFDfY2qAoXOsHGzw==
X-Received: by 2002:a05:6000:4710:b0:385:e01b:7df5 with SMTP id ffacd0b85a97d-385e01b7dfamr10702876f8f.14.1733152121481;
        Mon, 02 Dec 2024 07:08:41 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:40 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:32 +0100
Subject: [PATCH net-next v12 14/22] ovpn: implement keepalive mechanism
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-14-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15255; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=UpU/HyvnfKZ91xz+XPSLNFIOmICjhg1WnmleyYeQVDE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1nUNKTkYULLoN4FU0LSehK0ChQyUUNiDvgl
 6y2es/zTHKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 h9IsB/9l60pqm7rWqvQBmeg39/UyQhR55bVyen7iiZMXlTQ9ulj7lRTnSnC1n5u7dHfU91K9oOA
 Z2UurZqGNu20B3VsE5/Z+9oUoxjtHUOIph42zF8Z8up1qMbQP+7fSn930FwqZANE24lf743Hp4i
 UV/cRAicKc8cAz0JaWTMAW0QsICXpqXccCdQgg3EFMM7D5jKtIfs+XR1w6p9mUGdk38VkmDTDeF
 aE+4ESfd/IfFRuRlm9WngGmMoaYD+TtXp3iq8rnBBNdYzwM8c078D92Uhvzm4AXAngA2Z8JKKWW
 PGrpfdXbdkzPYhi0li2Msp3vzP8FZE1Er434C0TEu3kS5/x5
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
 drivers/net/ovpn/peer.c       | 192 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  19 ++++-
 6 files changed, 296 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3ed323d46b94d4db93ed871d5276023f88ac0757..bad6c0782802a993e6da04ecc1629ffd3ec59f62 100644
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
+	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
@@ -122,6 +152,13 @@ void ovpn_decrypt_post(void *data, int ret)
 			goto drop;
 		}
 
+		if (ovpn_is_keepalive(skb)) {
+			net_dbg_ratelimited("%s: ping received from peer %u\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id);
+			goto drop_nocount;
+		}
+
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
 		goto drop;
@@ -147,6 +184,7 @@ void ovpn_decrypt_post(void *data, int ret)
 drop:
 	if (unlikely(skb))
 		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+drop_nocount:
 	if (likely(peer))
 		ovpn_peer_put(peer);
 	if (likely(ks))
@@ -221,6 +259,8 @@ void ovpn_encrypt_post(void *data, int ret)
 	}
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
+	/* keep track of last sent packet for keepalive */
+	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -350,3 +390,40 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
+	struct ovpn_priv *ovpn;
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
+		netdev_dbg(ovpn->dev,
+			   "cannot hold peer reference for sending special packet\n");
+		kfree_skb(skb);
+		return;
+	}
+
+	ovpn_send(ovpn, skb, peer);
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 5f9c7eba37b132bcf8c0ebad60af9171e46bf3e8..1186bb6a5f1b0411a825a295d0e6e21c32972e84 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -19,9 +19,14 @@
 /* max padding required by encryption */
 #define OVPN_MAX_PADDING 16
 
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
index bd0d791cf9ccad7563f89e96b9c443d52b34e8bf..6b3a59e75e5aa918b28957c073990be9fb1d2124 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -182,6 +182,7 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
+	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
 	err = ovpn_mp_alloc(ovpn);
 	if (err < 0)
@@ -235,6 +236,8 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		netif_carrier_off(dev);
 		ovpn->registered = false;
 
+		cancel_delayed_work_sync(&ovpn->keepalive_work);
+
 		switch (ovpn->mode) {
 		case OVPN_MODE_P2P:
 			ovpn_peer_release_p2p(ovpn,
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index bca13e8e4439c2f217ae17896f114347e8aefd06..95469ff96da9fb939d064af9ebb97220ccb4566c 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -40,6 +40,7 @@ struct ovpn_peer_collection {
  * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
+ * @keepalive_work: struct used to schedule keepalive periodic job
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -50,6 +51,7 @@ struct ovpn_priv {
 	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
+	struct delayed_work keepalive_work;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 976338c53913d513fd316d5ec51e6f35c21ecbfc..606a5c538d7918148dbb647d5e111d94f5759506 100644
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
+		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
+		   peer->id, interval, timeout);
+
+	peer->keepalive_interval = interval;
+	WRITE_ONCE(peer->last_sent, now);
+	peer->keepalive_xmit_exp = now + interval;
+
+	peer->keepalive_timeout = timeout;
+	WRITE_ONCE(peer->last_recv, now);
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
@@ -875,6 +903,21 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 	return ret;
 }
 
+static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
+				enum ovpn_del_peer_reason reason)
+{
+	lockdep_assert_held(&peer->ovpn->lock);
+
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
@@ -892,3 +935,152 @@ void ovpn_peers_free(struct ovpn_priv *ovpn,
 		ovpn_peer_remove(peer, reason);
 	spin_unlock_bh(&ovpn->lock);
 }
+
+static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
+						time64_t now)
+{
+	time64_t last_recv, last_sent, next_run1, next_run2;
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
+	last_recv = READ_ONCE(peer->last_recv);
+	if (now < last_recv + timeout) {
+		peer->keepalive_recv_exp = last_recv + timeout;
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
+	last_sent = READ_ONCE(peer->last_sent);
+	if (now < last_sent + interval) {
+		peer->keepalive_xmit_exp = last_sent + interval;
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
+static time64_t ovpn_peer_keepalive_work_mp(struct ovpn_priv *ovpn,
+					    time64_t now)
+{
+	time64_t tmp_next_run, next_run = 0;
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	lockdep_assert_held(&ovpn->lock);
+
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
+
+	return next_run;
+}
+
+static time64_t ovpn_peer_keepalive_work_p2p(struct ovpn_priv *ovpn,
+					     time64_t now)
+{
+	struct ovpn_peer *peer;
+	time64_t next_run = 0;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	peer = rcu_dereference_protected(ovpn->peer,
+					 lockdep_is_held(&ovpn->lock));
+	if (peer)
+		next_run = ovpn_peer_keepalive_work_single(peer, now);
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
+	struct ovpn_priv *ovpn = container_of(work, struct ovpn_priv,
+					      keepalive_work.work);
+	time64_t next_run = 0, now = ktime_get_real_seconds();
+
+	spin_lock_bh(&ovpn->lock);
+	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		next_run = ovpn_peer_keepalive_work_mp(ovpn, now);
+		break;
+	case OVPN_MODE_P2P:
+		next_run = ovpn_peer_keepalive_work_p2p(ovpn, now);
+		break;
+	}
+	spin_unlock_bh(&ovpn->lock);
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
index 636245521f9502ce9139affd7b90d3ba918d1ea6..bbaabc73218948e3597dbc567a19b0a5823e32ff 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -44,10 +44,16 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @keepalive_interval: seconds after which a new keepalive should be sent
+ * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
+ * @last_sent: timestamp of the last successfully sent packet
+ * @keepalive_timeout: seconds after which an inactive peer is considered dead
+ * @keepalive_recv_exp: future timestamp when the peer should expire
+ * @last_recv: timestamp of the last authenticated received packet
  * @vpn_stats: per-peer in-VPN TX/RX stays
  * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
- * @lock: protects binding to peer (bind)
+ * @lock: protects binding to peer (bind) and keepalive* fields
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @delete_work: deferred cleanup work, used to notify userspace
@@ -92,10 +98,16 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	unsigned long keepalive_interval;
+	unsigned long keepalive_xmit_exp;
+	time64_t last_sent;
+	unsigned long keepalive_timeout;
+	unsigned long keepalive_recv_exp;
+	time64_t last_recv;
 	struct ovpn_peer_stats vpn_stats;
 	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
-	spinlock_t lock; /* protects bind */
+	spinlock_t lock; /* protects bind  and keepalive* */
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct work_struct delete_work;
@@ -138,4 +150,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+void ovpn_peer_keepalive_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


