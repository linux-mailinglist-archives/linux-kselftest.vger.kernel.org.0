Return-Path: <linux-kselftest+bounces-18883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6B98CFA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9177B1C22846
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC31B1C7B6D;
	Wed,  2 Oct 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eSSGRqp9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A51B372C
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859821; cv=none; b=jrs/3E09ZxKjsSu2djenzzBTWB7vj6zU0in94gWqSo6ggPIXkjFe4mvOnbNny4+HsiIYk8Ej6fJ5Pcr/HgRCievZHV9zCezjWfLA1wjU0K+CVyi8Y+w2k3dr6dccdHoo6EyuF4XkM1ix4AD1/6YCuF21bOgtBevYpz7iDEZbYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859821; c=relaxed/simple;
	bh=ZD9CYkIE5FSFq5DYQUPg3++Ny0I/XG+G1W/i4+vARdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoJw9MN2bRQ6e1qgHmVyBOVgmBS2iXLEDLK9JuT0XHdeHyDJMRvTt1F11nmdiYGNu75i76rXCYbIVxyC7AU4IjSSLnTH9cXpYWtLPZ58DqN+M9sdbAcFib/8Nn+Qj5X+2fwoph2kdheNOLnCNpsEar9vKgUTgXMZbdDL0dijlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eSSGRqp9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so48290185e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859817; x=1728464617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oEWmzaH16ZJlE/sOepu8X/tC//galY/p3gsmCJfQNo=;
        b=eSSGRqp9pjpGdJ4ovRfgood5fssaOHCoSXeTto1+VAZTQlTwyiwwxPzLFhfEdPnNmr
         /PtIce16sLoRBmSG1fxhdLrXcmJdoyKAA5e1NbklttgpNrmez8nVYOqlIPp/58Rb5VfT
         A8bBfSE8unsqHYn2ZTCb/ApQcVRxb52bcIHfsrkAyQXh5Ufc80eMSEfgWoM3SE6udBgd
         58X76qpc9CWK55fayIpv37AX6VQBnvpL+pZmbaF30cLUwLB4a50U8w5lpDoTsMBVp3Qp
         RB5WX42y5sOhd0Y4nApEl+rcsMloo2F9A3EWU2JxzTOxttilFVkB4+nYXSSviwhm1Wrj
         R8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859817; x=1728464617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oEWmzaH16ZJlE/sOepu8X/tC//galY/p3gsmCJfQNo=;
        b=cV88SYgWkluPvItGGCsZpLAVXIweU2CVyLddRKMkirbEExo0wHBv1VjzKqErHkoggh
         SM4V/UprqWIyl9Vyg3VkAq6QQsoow2SRnu/zlDRXFaRQQoXqRc2IMPhYy6pc1s0qtn5r
         hmbYjVsyJc/SIvzhj7T2BqXEIMKWNlcxvmjz/s6JgVxdgYywV/QunqRzkqPxAv4s+70W
         jIdDTSBUg260J1xJnI2w03bQl3MfXIDCTeKc0PLAgxV5SjAIu8QBhXqxsnVc/4xd/xNf
         F0eglMjUwHtt2p4UWGpOFd+DNgbY9+TSvLttQCV15Y1zXV+FFXymFLcB/RSzYi+RrK0B
         cG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVupBvusteRVBEPzD/TQC5eWAIFqxDC3cexr4CiuE40M/IMYNhK4uVi9GB0wQYSlmJ+tEUBcV108piH5Tnj5Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsEaNVAIVgwMm5obO6WLo/Gym9K0nBlEwnaPAlCGBOVsgNj6z
	Fdy4qVx+OH84zN0d1z0jej57sfINii2EzDdtmdsKqqwLmbpMp9zsVHZ39uDA2L4=
X-Google-Smtp-Source: AGHT+IF2gQxIzWXOLeJ8H4TU5mP2xuwi12Pf5Wwm7GiGC1CJO23K29iXzrv3zLtW5XdjwhKv8WGUqw==
X-Received: by 2002:a05:600c:a02:b0:42c:a8f8:1d58 with SMTP id 5b1f17b1804b1-42f777b5c6amr15395095e9.7.1727859816451;
        Wed, 02 Oct 2024 02:03:36 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:35 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:30 +0200
Subject: [PATCH net-next v8 16/24] ovpn: implement keepalive mechanism
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-16-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15105; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ZD9CYkIE5FSFq5DYQUPg3++Ny0I/XG+G1W/i4+vARdU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxSvZyCHcVl29IvPsV/wOlPH+ZJzQdL02OQ1
 sVAHkEr5zyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUgAKCRALcOU6oDjV
 hwtfB/9BQSSxQv5t71fvXjYJVeIzKIvfmeRiDOZUngNXvT54AZrXlLFDdQF3Tk2gtgKJLjgyYaV
 XVtLg1zjWMZXtvWCCceHr3rg3waLNzw+J1ZFedPiCG0a0QAgKls9N9JV8lHnS/xuStwiEGatf1H
 TJ9/U38/Vt4J/bfO5NS+N9vqlMkCpUkBtKD+F3q7vlySygyprjQcdc+ATSN1mQosqCE1yhcNnNW
 HrwWn7AEI44uOe+Ge/nW28V0JqAxnQhxfxnAGa4Gje24xkzL+y5VOk4WOCH5+wmR8jSUXuJD7k/
 8bRWWkCjC2d8b79LP+NoEKnpSUECNN5XLZcT6PoGqQ+IjM9f
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
index 985f8bba6f1355b9f164e53f11575fa104133d43..4e69f31382d2cb9ce4bc40f06cfbae47add5b5ba 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -26,6 +26,33 @@
 #include "udp.h"
 #include "skb.h"
 
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
@@ -103,6 +130,9 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* keep track of last received authenticated packet for keepalive */
+	peer->last_recv = ktime_get_real_seconds();
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
@@ -119,6 +149,12 @@ void ovpn_decrypt_post(void *data, int ret)
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
@@ -217,6 +253,10 @@ void ovpn_encrypt_post(void *data, int ret)
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
@@ -355,3 +395,40 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 7604f0970d3c283f8680f6800a125427999bb174..6048df5890c8fa46f3d91498903b4277a33f06db 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -43,6 +43,7 @@ static void ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
+	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 }
 
 static void ovpn_struct_free(struct net_device *net)
@@ -241,6 +242,8 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
 	ovpn->registered = false;
 
+	cancel_delayed_work_sync(&ovpn->keepalive_work);
+
 	switch (ovpn->mode) {
 	case OVPN_MODE_P2P:
 		ovpn_peer_release_p2p(ovpn);
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 4373d1bbc4874dc2f1d1f1697e7b847ec2f486c9..11c6c568246aafe64af32e1a1faf24583afe7ca6 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -42,6 +42,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
+ * @keepalive_work: struct used to schedule keepalive periodic job
  */
 struct ovpn_struct {
 	struct net_device *dev;
@@ -53,6 +54,7 @@ struct ovpn_struct {
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
+	struct delayed_work keepalive_work;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 54d0a416f6f91513f42d5ecc1f1f65d688f3e908..dfaa4c7c012215b3dcd451b9bd1d7ffce9b1291c 100644
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
@@ -76,6 +104,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 
 	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_bind_reset(peer, NULL);
+
 	dst_cache_destroy(&peer->dst_cache);
 }
 
@@ -816,6 +845,19 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
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
@@ -831,3 +873,149 @@ void ovpn_peers_free(struct ovpn_struct *ovpn)
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
+	time64_t next_run;
+
+	spin_lock_bh(&ovpn->lock);
+	peer = rcu_dereference_protected(ovpn->peer,
+					 lockdep_is_held(&ovpn->lock));
+	next_run = ovpn_peer_keepalive_work_single(peer, now);
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
index 9481eb41742ca2a6c88ee0262dd448fd947614fd..e0d8d1255b837b7ddfdcedc5a56e7e747f13e2c5 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -50,6 +50,12 @@
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
@@ -98,6 +104,12 @@ struct ovpn_peer {
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
@@ -144,4 +156,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
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


