Return-Path: <linux-kselftest+bounces-22985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F499E8E0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08602813DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88237219E87;
	Mon,  9 Dec 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="a/pFbeEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C042165EF
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734401; cv=none; b=nRrogXPZoCZ9e+OEDavItw5fi3thWMaDFnVEIrAR0XoRUGJCosnI27/1qN1VteoShUxGTm2D3OhlNCNbr0sxF2hKqO62BQJ53e5oSVw3G7FzOe+qG4JpgaokZ9TXx+m1pteqwaFlXP5UFMnCAcxkVPLJZTaFRfzQP72v7LxwqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734401; c=relaxed/simple;
	bh=KHO1Hfh8w6WNc4rea0KV8ckQe+/ZV/mHSPXW7GZC65E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcY58tVDyRave9jiie6cqAn4DOVPTn92U6O6oG4s3uhn8On+PC3FLw72QejbfPPulkGdFRHlcwDmwOkqdvQsy7v/dlM15oRVwYsfaAKgNxCXSOo0QM9S/RlJmK2EJIFzSDWsBNhs+NAkp2AirnCBFddIUns916B9eEi1XktoQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=a/pFbeEP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434f3d934fcso5612865e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734396; x=1734339196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6Tdidx7JFO8Csz1IN6z5P8D7vFjXaBpQXy4mm39RYg=;
        b=a/pFbeEPSnObmQts/sQ1LFIYtiAqqUfhqNE0BvHJ2lnEdsfx4JERiajNRqVz2f4XV4
         AV/bf+ojhFLfstdXRr/ByZwZvtan+EonsZZHlTaX3hLIdLzBP/Xc9LsNNsTb189unEER
         +8n8FivMifd1RjpwUzDWTuLDSTOmNJsaYAk6efNn64NxkL1AXBprOd0Gw9nvF3Wd+XWG
         YMlih44p/RTF8dbfL/FoIMApYJ3mi0lGb/dbPoqqYpRBvvLF8o3Rmy4CPLWKthpuEpZc
         Vup3aj/WsG7LgzPehux2fNgC7F+otOfXFG0rYXNX0t+fnEMF7kEIXszNthaatnZT62RS
         pc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734396; x=1734339196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6Tdidx7JFO8Csz1IN6z5P8D7vFjXaBpQXy4mm39RYg=;
        b=wgQvO+o3aNJmnQop4HAlRD84XojsooZgvn8qggi9PoOOr6UekgO5cs02Dimp6En40Y
         Yb5cf0rMnG+mZ4LM5s3XfffVnc0oS69knIdH1dt5H7V1NX8ZcBWhqTwkJCkg0vK4TkND
         T1YQsRvfz5ag8ThINTYojs1HEJyiTqeb9jjs6ldYtjPsbPr6WuYvUw4lRYxn+aiCSCjx
         GzUxNd3MxmzLQdYKuu01oT5yzA07/dPk36zKhk6tWSsuyKKj4e6xxFIsVkFu3WvbLqHk
         Apxu7z9W1UbLY1QbFls2Yk+XVA4wvXlEGSGjLKy1TQmxeEaWSid3UpaZDuPjVk4huoSQ
         2brg==
X-Forwarded-Encrypted: i=1; AJvYcCXi9wBohUk+ePSwVT4DP0Al4SUzBvWyig61NhqG1AX0Yvz+9SdcLz5A4y5C8NFDOOrJRAillzUZo3J9XzwhclU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx671nDJshqELsBNfSfafx0tsj8diAxEGNjR+8+SLZGPLdLYrrT
	CqeMM0Vj88Z4iL8cnB5DTju9l+X1UPYMIYfxPv+Rv+NJrLfQ2TrZ/XqZ2UdTxYhdJuduJvtVe03
	U
X-Gm-Gg: ASbGncspVjRJdVIsJmRzbUctZq/0/ag2BRCxRNrwcgO2+dcklN8OneN5RHnC1V52ZBw
	yBMt90a88Po02Fjoj4nT3FM70c3aPxqG5AeRilHH+HipbiPf3gNLyspIAv9HTC+O6KxjIappuA5
	uM4m5m2cKrv9oTV80tmp29a0sKa64h49alygh8vFQGaS2vgoEPkfIDZGW+yny6vsRKMqfFN8u+5
	fQBV0XBCL7bQ9TSpq8unIHdFzv9ATgJ26Du4+fakTU0Ty0cPAiOeXCQcH4P
X-Google-Smtp-Source: AGHT+IE32xTRQHplAkKEBQWduQd87L2tR+5bpz25V1r+s1timt2C9VU3AMGFxgcCeOIbw8HDk+36jg==
X-Received: by 2002:a05:6000:188f:b0:385:db39:2cf with SMTP id ffacd0b85a97d-3862b334cbcmr7677983f8f.12.1733734395816;
        Mon, 09 Dec 2024 00:53:15 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:15 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:23 +0100
Subject: [PATCH net-next v14 14/22] ovpn: implement keepalive mechanism
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-14-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15473; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=KHO1Hfh8w6WNc4rea0KV8ckQe+/ZV/mHSPXW7GZC65E=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAT1NZXyvNjpmynRKIh+7UroQB3DnnSPLchE
 8+5dEBXkfmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEwAKCRALcOU6oDjV
 h4R+CAC3T42PF0mP03ILMnSP10oEZw6UtsGxdgtcWAP7KEnQQ3VY3fL0TMk3BExK0AdCW61GzBb
 1Howzb3E08QMfPqVqjWYEPmdZetL04vbHE6barIRne2oFUFboANiCvYkV7Au1UsHU5RD/SxzU1w
 3U+x/GWiD0DVRfmpHKbWYI9wrk+/TArKrqASoNciCoukvZjB3qb0K2ljmzVakzGanAunjQicp6W
 Am9d2+/6IoVLVwY4TVfXQY2P/obA6Y3eCTMRsbSF4rwzB4Tfg9Lt4rUaN0RL0SazzK4jl5FhKQA
 3JM+XmDzJpVVP2CYQXEEPsCdENshlxJozqGjWPukk0etJYD/
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
 drivers/net/ovpn/peer.c       | 190 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  23 ++++-
 6 files changed, 296 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ecc1d35b04248f7d5da99501777bee971c98b91f..19c4e4750c493cdf134f550c779d8b9dac0009ad 100644
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
@@ -104,6 +131,9 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* keep track of last received authenticated packet for keepalive */
+	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
@@ -121,6 +151,13 @@ void ovpn_decrypt_post(void *data, int ret)
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
@@ -146,6 +183,7 @@ void ovpn_decrypt_post(void *data, int ret)
 drop:
 	if (unlikely(skb))
 		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+drop_nocount:
 	if (likely(peer))
 		ovpn_peer_put(peer);
 	if (likely(ks))
@@ -220,6 +258,8 @@ void ovpn_encrypt_post(void *data, int ret)
 	}
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
+	/* keep track of last sent packet for keepalive */
+	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -349,3 +389,40 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 5e78c984ef302ae17ef8481bb10ac382e5d11e31..168cec1cbcead962e921d29822fc0d9dec1f28a4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -22,6 +22,46 @@
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
+static void ovpn_peer_keepalive_send(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      keepalive_work);
+
+	local_bh_disable();
+	ovpn_xmit_special(peer, ovpn_keepalive_message,
+			  sizeof(ovpn_keepalive_message));
+	local_bh_enable();
+	ovpn_peer_put(peer);
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -51,6 +91,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
+	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
@@ -882,3 +923,152 @@ void ovpn_peers_free(struct ovpn_priv *ovpn,
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
+		ovpn_peer_remove(peer, OVPN_DEL_PEER_REASON_EXPIRED);
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
index 636245521f9502ce9139affd7b90d3ba918d1ea6..4316051a12f0b8ada5110dd7aa71afedf29a0c2d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -44,13 +44,19 @@
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
- * @delete_work: deferred cleanup work, used to notify userspace
+ * @keepalive_work: used to schedule keepalive sending
  */
 struct ovpn_peer {
 	struct ovpn_priv *ovpn;
@@ -92,13 +98,19 @@ struct ovpn_peer {
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
-	struct work_struct delete_work;
+	struct work_struct keepalive_work;
 };
 
 /**
@@ -138,4 +150,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+void ovpn_peer_keepalive_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


