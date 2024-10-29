Return-Path: <linux-kselftest+bounces-20935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926E9B475E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F328B23199
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B0207A30;
	Tue, 29 Oct 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cSuV+wcb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31396207214
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198900; cv=none; b=TKJeY70asYcvBl9qifVWIbyBe2PPb8LcvNZoI4JIWF34oZ01bm90RBi3ooHxTL86CS+y6POcCsiWatAwM9hmwuuJM9xsAww6wSwJ6FJyNEN8d2BLE2ErNSjuKGw9QANe/CvFzxQ+N7kG3w5bwocNX719aVPkRKasGQQJ/Ono/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198900; c=relaxed/simple;
	bh=d/oZ1l0fWzRgLy+5UEHG9eiWx5K78lUQdfIjXjT6ylg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILmFVDJ6FZDdhjw7hR1GJK+c74W5ErP2rTss7nTK4LPWJVyTq4ER+AD2Kxv1VD8kzwez39p+wOR0BW56C16G4nbUkKEgAlQAzM/z6XmwMwi+RldDMi5KJg6ZEdcp0I75harrsggEATZ7YqC+Dui/TuzRM2jGKgJA0sLyli3TWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cSuV+wcb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f84907caso5633580e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198893; x=1730803693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4jOFyNMJK97N8vw8msPWeX51yrB+W7Ufi1DwpaY1mY=;
        b=cSuV+wcbQm6Ig/yBLIPSvKiP7dS5GX6YjiFPskUWQDRfY+KcesLcGOjcrF+BHATJCY
         If18mL53jYl8jNn9RzLfb1+zn8k+ZM6NM1LXKdja7CxA4Ed6UC2e3Tt3G4XnIM1gpCKC
         dTyuGZIDHi+dmCc3b23huS/jIqUxzEXDHDE6jAdSp7CHLNvHDdelFBm7Z+Y7k/mvCNY+
         1pOUWbVTAUzTCjwhlzyEST7urAV7yK24LKbAiEjVOCEv+HMbjQ0kralUprRpLhxzuiDY
         A40qi6+7wriEP3jJdCA7ofBySWuiE5cj7ncSBYT1Nc7q6TwEX/iDY3smlJqZUjle8OuG
         yCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198893; x=1730803693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4jOFyNMJK97N8vw8msPWeX51yrB+W7Ufi1DwpaY1mY=;
        b=dAJeBlaN4yDv/wCSpYz3ZF0OCTTz+UfHXaCka+aFxjygk5++zZa3ofjBotDsVexFzs
         6ClPtqAqRT1lp34UR7OAw+yWP3cxiOTtwz3Yk9WM9kntzm8aF2pUqJn+0ekIaOTM0ZpL
         FHfghz1o/A7p2GVOvDudToDOKGXc4CxWD6EqOCaqEXBnPoLp1Oa8pHQcimQEu3AR8glx
         1gu4nhIwTzNAmF5IAsCllawaR9e07TND8d7Sow+zVCR37JRiC+St4U3L0iYwPX9rnDzE
         H7BPhN8UmwwuERJiWQCr254pSjaKq7k9Ftk1BXMgqRQScDOBWuVdJhF3uWvslFFLfi2W
         50eg==
X-Forwarded-Encrypted: i=1; AJvYcCUvrOPfiWhg0sW7IGS/7Cbxt9+Kxnk4ebL1YAOmePqXMNVmWTWTX9H3zzwgppXdbFNcBJZ6llbVOiUdX8AN+Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJSaUzxJbF4ZOjJ1zvukALm0HNBef/NgaOo+seig9OLAoPrf+U
	XpCMCYkJO+W5lQBQm1D5aD7vnDbRwje/ryAf8ZzFAEvVh1mqW5o3euSxZyNESi4=
X-Google-Smtp-Source: AGHT+IHA2mWOI1sbisY/tThUXFxFC4A+r/7qmGMwPPhd0bJnxmfdrEe7DjhbbejTPYhFcLOPEHJx2w==
X-Received: by 2002:a05:6512:31c1:b0:530:c239:6fad with SMTP id 2adb3069b0e04-53b347234femr5724531e87.0.1730198893124;
        Tue, 29 Oct 2024 03:48:13 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:12 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:24 +0100
Subject: [PATCH net-next v11 11/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-11-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8236; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=d/oZ1l0fWzRgLy+5UEHG9eiWx5K78lUQdfIjXjT6ylg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1rTP0pqy8pY/UxLaFPMBElt6aItWf/Qwp+S
 ei036yV0t+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9awAKCRALcOU6oDjV
 h5tQB/94Dq+kupVbk3KPOgSHWtsi+z2CZpEHCTTN7Gs7D59SKU7aKSsAxTgtDnXXISbaJ45kMY9
 VkO/eKYBPk7ZQB0SZlm0lzF20U7WC8VTIhnBacudFEbbALCrmqEwaA6B9kQn9nPfESUTlbM0BFE
 nO8ynDHX7LhoteEBhoNHB2qdER2/BeY3cvvpLpWdqeazWax/5AM+DEK5MsDCSqECvUjlLQ1wvUp
 m3fai1Xy0103oqRhZngtum8Yx2nXAeiDJ3/ls2ccOh3NoCqerhzKjKROkIH4nxEQ+eUDFru6A5J
 kiEq9koo/LqTRfa9BHKMXBRPUpqVfH1ZKnIL0Ey0UB/zZ810
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile      |  1 +
 drivers/net/ovpn/crypto_aead.c |  2 ++
 drivers/net/ovpn/io.c          | 11 ++++++++++
 drivers/net/ovpn/peer.c        |  2 ++
 drivers/net/ovpn/peer.h        |  5 +++++
 drivers/net/ovpn/skb.h         |  1 +
 drivers/net/ovpn/stats.c       | 21 +++++++++++++++++++
 drivers/net/ovpn/stats.h       | 47 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 90 insertions(+)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ccdaeced1982c851475657860a005ff2b9dfbd13..d43fda72646bdc7644d9a878b56da0a0e5680c98 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index f9e3feb297b19868b1084048933796fcc7a47d6e..072bb0881764752520e8e26e18337c1274ce1aa4 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -48,6 +48,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	int nfrags, ret;
 	u32 pktid, op;
 
+	ovpn_skb_cb(skb)->orig_len = skb->len;
 	ovpn_skb_cb(skb)->peer = peer;
 	ovpn_skb_cb(skb)->ks = ks;
 
@@ -159,6 +160,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	payload_offset = OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE + tag_size;
 	payload_len = skb->len - payload_offset;
 
+	ovpn_skb_cb(skb)->orig_len = skb->len;
 	ovpn_skb_cb(skb)->payload_offset = payload_offset;
 	ovpn_skb_cb(skb)->peer = peer;
 	ovpn_skb_cb(skb)->ks = ks;
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 4c81c4547d35d2a73f680ef1f5d8853ffbd952e0..d56e74660c7be9020b5bdf7971322d41afd436d6 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -68,6 +69,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	unsigned int payload_offset = 0;
 	struct sk_buff *skb = data;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 	__be16 proto;
 	__be32 *pid;
 
@@ -80,6 +82,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	payload_offset = ovpn_skb_cb(skb)->payload_offset;
 	ks = ovpn_skb_cb(skb)->ks;
 	peer = ovpn_skb_cb(skb)->peer;
+	orig_len = ovpn_skb_cb(skb)->orig_len;
 
 	/* crypto is done, cleanup skb CB and its members */
 
@@ -136,6 +139,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_rx(&peer->link_stats, orig_len);
+
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
@@ -175,6 +182,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb = data;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -184,6 +192,7 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	ks = ovpn_skb_cb(skb)->ks;
 	peer = ovpn_skb_cb(skb)->peer;
+	orig_len = ovpn_skb_cb(skb)->orig_len;
 
 	/* crypto is done, cleanup skb CB and its members */
 
@@ -197,6 +206,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, orig_len);
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 98ae7662f1e76811e625dc5f4b4c5c884856fbd6..5025bfb759d6a5f31e3f2ec094fe561fbdb9f451 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -48,6 +48,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 754fea470d1b4787f64a931d6c6adc24182fc16f..eb1e31e854fbfff25d07fba8026789e41a76c113 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -13,6 +13,7 @@
 #include <net/dst_cache.h>
 
 #include "crypto.h"
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -26,6 +27,8 @@
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -44,6 +47,8 @@ struct ovpn_peer {
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 2a75cef403845e2262f033a78b3fa1369b8c3b5e..96afa01466ab1a3456d1f3ca0ffd397302460d53 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -22,6 +22,7 @@ struct ovpn_cb {
 	struct ovpn_crypto_key_slot *ks;
 	struct aead_request *req;
 	struct scatterlist *sg;
+	unsigned int orig_len;
 	unsigned int payload_offset;
 };
 
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
new file mode 100644
index 0000000000000000000000000000000000000000..a383842c3449b73694c318837b0b92eb9afaec22
--- /dev/null
+++ b/drivers/net/ovpn/stats.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/atomic.h>
+
+#include "stats.h"
+
+void ovpn_peer_stats_init(struct ovpn_peer_stats *ps)
+{
+	atomic64_set(&ps->rx.bytes, 0);
+	atomic64_set(&ps->rx.packets, 0);
+
+	atomic64_set(&ps->tx.bytes, 0);
+	atomic64_set(&ps->tx.packets, 0);
+}
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
new file mode 100644
index 0000000000000000000000000000000000000000..868f49d25eaa8fef04a02a61c363d95f9c9ef80a
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ *		Lev Stipakov <lev@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTATS_H_
+#define _NET_OVPN_OVPNSTATS_H_
+
+/* one stat */
+struct ovpn_peer_stat {
+	atomic64_t bytes;
+	atomic64_t packets;
+};
+
+/* rx and tx stats combined */
+struct ovpn_peer_stats {
+	struct ovpn_peer_stat rx;
+	struct ovpn_peer_stat tx;
+};
+
+void ovpn_peer_stats_init(struct ovpn_peer_stats *ps);
+
+static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat,
+					     const unsigned int n)
+{
+	atomic64_add(n, &stat->bytes);
+	atomic64_inc(&stat->packets);
+}
+
+static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats,
+						const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->rx, n);
+}
+
+static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
+						const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->tx, n);
+}
+
+#endif /* _NET_OVPN_OVPNSTATS_H_ */

-- 
2.45.2


