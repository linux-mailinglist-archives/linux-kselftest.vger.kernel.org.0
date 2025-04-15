Return-Path: <linux-kselftest+bounces-30856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F9BA89C19
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0235C19003A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514629E076;
	Tue, 15 Apr 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AVWmVu8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DD297A77
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715875; cv=none; b=C8WR7bX5LB1QhT7L2JdJp3vdqjv3JGrT5F+HFw3RrIOQWDkWN80fVAe3GvMS9KW4r2PI1A+a0YIHL1MUrb5CrtprEyAhCzyV2pTpuq/kPxghaaHxJnOd2s0XIIiiClWll3iVRKKJrwtz8jkES5oQABZHeiUyHeI5d0u0ussyu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715875; c=relaxed/simple;
	bh=uzyYWPpTZHE5FL3YlqpdiE+FXNdsTgwuDNppQQvcMjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dioCC8n0Q+nG7dQN3qZygfqNV6KdUQU2jTcMUFDjQWe/JanBgr1tBm01AVvPKOZ2CyJ6U21XqNSxdVoIA66rxXjYOA3sW7noPVlpjoUZmZPX5CoXQmkD7WrHbamrkx9Lz1h3cwDtnF+Xp/JZ4cWNM27BqzcG/P/sJUsWm8gDZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AVWmVu8w; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391342fc1f6so4578867f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715868; x=1745320668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYO/uR/uD3BECo6VPbRNZtFHuf/aMCen8FhNH0TDmGY=;
        b=AVWmVu8wJhqG90Hx7/Mvr/ONWfNllFWkYtWemwXZtGQnGLG/8hO1x/GJzNfOmw0Vgu
         s03dCUS7TerYok1zFKbW6QRVzrA/FhxeVpWmrOeZPNDcOmnc0M/HlmBZ17nrNBhq6Ajd
         nt8V8v1mFPELlYNMFfv77YDZi0ud+9d5T9EiFrdzHMnuKb79VPnanfJuvu5VdoBQG56Z
         ZSFo3BObuT09sk4cGdt0pPwR+cI11SPOm+o0GJcyLFEKbIHBgqF8nxdgccHdTu+y0Iw2
         EZNm5ljUL+J3Nyh5PKMP02WBTlS8aO4NyDcDo2IPHaw7hoiKcg22eG42pvkCLWTkjcGy
         NgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715868; x=1745320668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYO/uR/uD3BECo6VPbRNZtFHuf/aMCen8FhNH0TDmGY=;
        b=G2wG/OdZ0FTXTQww30FLWbWy2ZXR2rwb0iaMSW7k1fgXuwHkn/pyCC3pVGHtlOK/Ex
         CnN8UxOqbDpX5RUxBcZ3d+319lcdLWw/FbI7KPftQ/gpDZTQaxFodgq//YVqLM239EpI
         OKtOMb3ftusy+6ENvIY16lHSqj6XPIFXcZlPcrjP6FBLdzFrb4pT/LXKSIagmJzs5AUO
         A1i96i+KyqLXmCTN9ZxgWIsG4X4kPx+tScDvnIhGM4/vSq17uTrrnWpi8/qymedNA+Mg
         lcM0W6Z4AznvftmTLMYqu+n/n0og93UAQ9kYXBHllawkfxoiYsTIDTzcj8ZzJbOM8Jhy
         Ys/g==
X-Forwarded-Encrypted: i=1; AJvYcCWFw70AMNeEwr55j0UsoFICSR22F6nEa8AO356T81Npod/tpSnvwFIygJ/1uYGyKyvkNjn3Tj+08sqYXskg3cY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyytfb6QXTHSsxSzMRiR2rp+SO/TMZXmpa0SpHIxEEhAoFcX6DT
	mMfUwpzeQyftCdryBZBhOSorcD0l4wXG6C5fnkPGcUujB8anU4xa/UOzhBLld6R/XExplHSjVl6
	jRQ84lyIqmUE7YKmsHBeTqzuUCR1ESmHPThu1XggIiEbE/13W7O5VX1mO8gI=
X-Gm-Gg: ASbGncsc7zRqXcO5QLW3ocLemenwZ1IPNV+ZwSPmS9Tmlvzz/vJqoBfsZW23R/QPb6y
	3C/UYXpPjj/5u45WmdP1O7UoTHLqYs1ZL21I+2/rJKij7Sj5sObO4BuHqIYqS1BsxSRzanjhlvO
	by+C63Xoe3PDmYUJEL/8q+O9wVvVhSY5yUGFgbPB9z+Y1MOtJJ0yPKgLrKNOTqpuOEYiNgJD285
	2eTA7DJ7YRB03GBf5rizhysMLE6hqly1UAMzLQx3YUkZg2kYkEvj7MciOoeBAIcHSPOuK70BP17
	Ok8RaDi3p9POBYgfuptdZdNqPS4ospiiVQs2FN9947kzrzZP
X-Google-Smtp-Source: AGHT+IEmyVTamFKQu7pd234SU+CUwekT4Rx1T0TWQn8Ts+dN84RRHKlDF9nTN7ebh42IbeOMNV+rxQ==
X-Received: by 2002:a5d:584a:0:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-39ea521505emr13698551f8f.24.1744715868204;
        Tue, 15 Apr 2025 04:17:48 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:47 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:33 +0200
Subject: [PATCH net-next v26 16/23] ovpn: implement keepalive mechanism
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-16-577f6097b964@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16146; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=uzyYWPpTZHE5FL3YlqpdiE+FXNdsTgwuDNppQQvcMjA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBCig6U/6AGtVX2Hx9gKRX0KtdCHCZ6kEZwl
 O5DVCEjf4+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h8s1CACNEKv8TJQq3WUvbna4tOZcYmJG/Z8ov2TVNUxRA+6Tt5IOJg5lrUMNgBEh9YojLBB1O/p
 Nc7qLce+KZa9RKX/2JH2y+4+BZOg3xAqW96KU86teOYp5nKTaUSTDiCOcGW0ALZN1xH7zT0pRoY
 Rn6Iln7J33I9wB4P3I7tQ7UZorBdUlq1096A8oeWKRYyKomBHRT/1qUHkyVPKRYtJyvlqgi+naj
 lAkEftsonJD2Yy0cRpY66WoKsw0YGODqf0RoInqqm2dGTrE2OLZc+Iuic2J7Ner2vVqK5kc+ba8
 H7fmoYQY4LMqyZWAAFGXbOW2rOWXwB21GALsqjmpcZVxh7jF
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

OpenVPN supports configuring a periodic keepalive packet.
message to allow the remote endpoint detect link failures.

This change implements the keepalive sending and timer expiring logic.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c       |  78 ++++++++++++++++-
 drivers/net/ovpn/io.h       |   5 ++
 drivers/net/ovpn/main.c     |   2 +
 drivers/net/ovpn/ovpnpriv.h |   2 +
 drivers/net/ovpn/peer.c     | 206 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h     |  21 ++++-
 6 files changed, 311 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 5479b40f84a4d7207a7fdd4f6a8ea72e6b6a73a0..a1816f72634bb32f5146ba0f5dcc5d1440b83792 100644
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
@@ -101,6 +128,9 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* keep track of last received authenticated packet for keepalive */
+	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
@@ -118,6 +148,15 @@ void ovpn_decrypt_post(void *data, int ret)
 			goto drop;
 		}
 
+		if (ovpn_is_keepalive(skb)) {
+			net_dbg_ratelimited("%s: ping received from peer %u\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id);
+			/* we drop the packet, but this is not a failure */
+			consume_skb(skb);
+			goto drop_nocount;
+		}
+
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
 		goto drop;
@@ -143,11 +182,12 @@ void ovpn_decrypt_post(void *data, int ret)
 drop:
 	if (unlikely(skb))
 		dev_dstats_rx_dropped(peer->ovpn->dev);
+	kfree_skb(skb);
+drop_nocount:
 	if (likely(peer))
 		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	kfree_skb(skb);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -221,6 +261,8 @@ void ovpn_encrypt_post(void *data, int ret)
 	}
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
+	/* keep track of last sent packet for keepalive */
+	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
@@ -346,3 +388,37 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
+ * Assumes that caller holds a reference to peer, which will be
+ * passed to ovpn_send()
+ */
+void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
+		       const unsigned int len)
+{
+	struct ovpn_priv *ovpn;
+	struct sk_buff *skb;
+
+	ovpn = peer->ovpn;
+	if (unlikely(!ovpn)) {
+		ovpn_peer_put(peer);
+		return;
+	}
+
+	skb = alloc_skb(256 + len, GFP_ATOMIC);
+	if (unlikely(!skb)) {
+		ovpn_peer_put(peer);
+		return;
+	}
+
+	skb_reserve(skb, 128);
+	skb->priority = TC_PRIO_BESTEFFORT;
+	__skb_put_data(skb, data, len);
+
+	ovpn_send(ovpn, skb, peer);
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 5143104b2c4b896a030ec4a8c8aea7015f40ef02..db9e10f9077c4738ee79e5723e2a4bf5ef72f633 100644
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
index 889c4585f06bc8cbf0a22872a5f82512bc717c5e..232eeb08e929230afca909bca539ef97892837f5 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -170,6 +170,7 @@ static int ovpn_newlink(struct net_device *dev,
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
+	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
 	/* Set carrier explicitly after registration, this way state is
 	 * clearly defined.
@@ -191,6 +192,7 @@ static void ovpn_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&ovpn->keepalive_work);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	unregister_netdevice_queue(dev, head);
 }
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5ba3c3e446e4d067675541435bcc6aa282aee75c..5898f6adada7f57abcbfa4f37ca653f4f1e506a9 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -40,6 +40,7 @@ struct ovpn_peer_collection {
  * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
+ * @keepalive_work: struct used to schedule keepalive periodic job
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -48,6 +49,7 @@ struct ovpn_priv {
 	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
+	struct delayed_work keepalive_work;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2d6cecc28c5d1f7d5516f7f89bc0ba274c72d5e1..50514736a4327c96d381805f0870d89fe1193ab1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -36,6 +36,52 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 	}
 }
 
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
+/**
+ * ovpn_peer_keepalive_send - periodic worker sending keepalive packets
+ * @work: pointer to the work member of the related peer object
+ *
+ * NOTE: the reference to peer is not dropped because it gets inherited
+ * by ovpn_xmit_special()
+ */
+static void ovpn_peer_keepalive_send(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      keepalive_work);
+
+	local_bh_disable();
+	ovpn_xmit_special(peer, ovpn_keepalive_message,
+			  sizeof(ovpn_keepalive_message));
+	local_bh_enable();
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -65,6 +111,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
+	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
@@ -948,3 +995,162 @@ void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sk,
 		break;
 	}
 }
+
+static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
+						time64_t now,
+						struct llist_head *release_list)
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
+		ovpn_peer_remove(peer, OVPN_DEL_PEER_REASON_EXPIRED,
+				 release_list);
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
+		if (schedule_work(&peer->keepalive_work))
+			ovpn_peer_hold(peer);
+	}
+
+	if (next_run1 < next_run2)
+		return next_run1;
+
+	return next_run2;
+}
+
+static time64_t ovpn_peer_keepalive_work_mp(struct ovpn_priv *ovpn,
+					    time64_t now,
+					    struct llist_head *release_list)
+{
+	time64_t tmp_next_run, next_run = 0;
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
+		tmp_next_run = ovpn_peer_keepalive_work_single(peer, now,
+							       release_list);
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
+					     time64_t now,
+					     struct llist_head *release_list)
+{
+	struct ovpn_peer *peer;
+	time64_t next_run = 0;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	peer = rcu_dereference_protected(ovpn->peer,
+					 lockdep_is_held(&ovpn->lock));
+	if (peer)
+		next_run = ovpn_peer_keepalive_work_single(peer, now,
+							   release_list);
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
+	LLIST_HEAD(release_list);
+
+	spin_lock_bh(&ovpn->lock);
+	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		next_run = ovpn_peer_keepalive_work_mp(ovpn, now,
+						       &release_list);
+		break;
+	case OVPN_MODE_P2P:
+		next_run = ovpn_peer_keepalive_work_p2p(ovpn, now,
+							&release_list);
+		break;
+	}
+
+	/* prevent rearming if the interface is being destroyed */
+	if (next_run > 0 &&
+	    READ_ONCE(ovpn->dev->reg_state) == NETREG_REGISTERED) {
+		netdev_dbg(ovpn->dev,
+			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
+			   next_run, now, next_run - now);
+		schedule_delayed_work(&ovpn->keepalive_work,
+				      (next_run - now) * HZ);
+	}
+	unlock_ovpn(ovpn, &release_list);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 2a3b1031f58dd73925a9ed74aed7ac4cb7b8c4c5..e747c4b210642db990222986a80bb37c9a0413fe 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -45,13 +45,20 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @keepalive_interval: seconds after which a new keepalive should be sent
+ * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
+ * @last_sent: timestamp of the last successfully sent packet
+ * @keepalive_timeout: seconds after which an inactive peer is considered dead
+ * @keepalive_recv_exp: future timestamp when the peer should expire
+ * @last_recv: timestamp of the last authenticated received packet
  * @vpn_stats: per-peer in-VPN TX/RX stats
  * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
- * @lock: protects binding to peer (bind)
+ * @lock: protects binding to peer (bind) and keepalive* fields
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
+ * @keepalive_work: used to schedule keepalive sending
  */
 struct ovpn_peer {
 	struct ovpn_priv *ovpn;
@@ -91,13 +98,20 @@ struct ovpn_peer {
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
 	struct llist_node release_entry;
+	struct work_struct keepalive_work;
 };
 
 /**
@@ -136,4 +150,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+void ovpn_peer_keepalive_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.49.0


