Return-Path: <linux-kselftest+bounces-22692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E69E06BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C80416B130
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601B20A5DC;
	Mon,  2 Dec 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GMzbM0DJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51343209F55
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152123; cv=none; b=sJkJsRLryc8XzbFu2TqHjOBFb3wCzndIYW6EhAyUpn/VEag45jLEscg4CW5UPKsbWeCJOwl6UQfCbbaMOx0bE17zfJKYpSIwKvNbCaBmYl6hY+EDDQU1opa8n40moOOSBmBKRmsfuY3ofmy1la7PW8ilpyw3KjY/xf0c19T6ET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152123; c=relaxed/simple;
	bh=G/sKpvC+pN1QVKvoA9NeKKOS52U/ihJTetuEhBzEgZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lB6L//NOHrC+XRGaHRCyOo7VH9M/pVdGT0WMPJGxAnX5rsm/sQNrMzdHJqqv4vmPUj94bLU9oWo3JfMV0qS4d/XPXLYzKZ4xmf5DiwRw0w9qNP1V93Q9kKAmVLTaUZy9DNUOlf+6bLjHZa76B9A+XcN2WRmLUkr0dRM+pBTvpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GMzbM0DJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434aa222d96so55372125e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152119; x=1733756919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed3qdhTNlfpTcT1xlNMz6yOLAqv5NM8S+TY4RkHBFJc=;
        b=GMzbM0DJ5wQoxGV6W75BGLyWG/Ad3NG+J//gVuyOZhWUPK9fFl2HO52qZhjmEb9Fqh
         SpGvtYXqaAfzo8K8jqLY2X2ZQ+EP9aJllgmLKOdjvad8r7+SQM5LrAmuGOMMZVfBBzlW
         /mC+ytcnE2vkzJFCDpDA2pvAKpcj2apjciVPjTMzWUT7n2hAQZ1A5QA39AGlMOtVwHIN
         2ytGjI0xTaudgWe4m4A9WSBW0P2oTHG8EivMaToOZwVLolQZTcZyTCoqQUWDFPdVs3+0
         s6tYy/XUrKvwz7P0DW9yC4JrjgiHv8j4Lvl6gCxzvV3/Dv+QoH47skWKxWGxacgpKsJW
         XAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152119; x=1733756919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed3qdhTNlfpTcT1xlNMz6yOLAqv5NM8S+TY4RkHBFJc=;
        b=ugDH8rRDMVhdlRkzOaoO9znWh4EbhiVRrdZ5SxaiYZ2kABXJ0nSZqTas5krHQVC4ci
         JvDSDpyNdRQ8+RY4W/cVv29p+X/H18iaelaZJZ9YPGdpQg5N6tI79B2edDomEim8tFF6
         Kk/ROsd+SBn0Uix21QzKFatvq8GOU97vP6Bd7fIRgcmd/6qwUkTRP2z6Kha+IZuB11tH
         R3ifjeUFI+evaVYNk5cddaz23/HSOZlCjXrfIx/NFGHVh+37uoEyeZbq1YCMgG+GH0nx
         6BYblzdOnyWgp9/FnAC4vUYsrfQahzPYCBYptFsx+Ae0zRCNvDbFrCjRTTH6SvVhqJrw
         2tHg==
X-Forwarded-Encrypted: i=1; AJvYcCXOiX2yAABEeACHCu86H+tXdUqUOxcRpbyUHArpDgGHk3U1sWuqdvjgTXXsYCI7Dj0w8a3yZ8xbUsXAMys+rOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XZzXiV0+LRAnGkLnej+jLUZTLGRgh8FYaas3vbM5oXpeX/1l
	outYanE+T+tIrHFS9nJUg0NJBn+IaDuL91Ln/aMSoq9vtKpCpUFp9n+r6y3YwCg=
X-Gm-Gg: ASbGncsf+D23okY2q0HOoJIGuSl6IiL02Z2BmiKFmfHQx8lpALy3VPug0ro0kAI3LrA
	8v6CfXlKEap8ehWBVaPb697H73ks7vOGcIPShpVTiJIkbyuQHdXDcg9p3aJpKVkwN/g3V2PcnCi
	YqN9j8KklHX7lTom2gGgF9/VXaPSN9u3yF8UuAr/GeyyLXyxmJNTbiLmDkKGLjARZ+7wL+mvqx6
	4yJVg8MFZjRMFQKJTu+HE/lEuIm4hZT0YifL/TPjsF4SAfKLZJK37qDf6uP
X-Google-Smtp-Source: AGHT+IE6y11ldctK7/Urobc+4DON3iIksiLWQ51GAnhQg6usSwWXijxzNS4g+1HbYedBlDz9gWjk0w==
X-Received: by 2002:a05:600c:3585:b0:434:a04d:1670 with SMTP id 5b1f17b1804b1-434a9d4f86dmr270066625e9.0.1733152116258;
        Mon, 02 Dec 2024 07:08:36 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:35 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:28 +0100
Subject: [PATCH net-next v12 10/22] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-10-239ff733bf97@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7121; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=G/sKpvC+pN1QVKvoA9NeKKOS52U/ihJTetuEhBzEgZo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1m5t4p9Slw5VSLLQlkcf/JniIEPD1UNEBqH
 gQGNfc6f4WJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZgAKCRALcOU6oDjV
 hzMBB/9ldD43q1W7gg43YUzqsrVpvxLyaX1aqma8EBP9w1hm3GY92vG8YA6u7oGd869AGgsMP+q
 XR807zsEKks6IiDWw3+T8qcvnVzw3nUPuQBEvlR334OSZUXf/kdjwwObcHuUXOgq0fuVLzxkbPr
 WaR8nqTRlrRm/AFWCfjc2XFIosADs90BNZGym3w2CYOVNob62YoB4yKzMcKbucxGF7ACj7Y3rIj
 w7lJb5OC4GbOfbSHWLxw93RdRP1VKaygOyaTn1xkTPNRG1bNBVOM4zTP0CwsSX7dhJTS0pXQWBa
 /Uqnw6lrUyVTtj4YifWAmzNTdpt1T+7gJHMG4vxLkhl87nFU
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  1 +
 drivers/net/ovpn/io.c     | 12 +++++++++++-
 drivers/net/ovpn/peer.c   |  2 ++
 drivers/net/ovpn/peer.h   |  5 +++++
 drivers/net/ovpn/stats.c  | 21 +++++++++++++++++++++
 drivers/net/ovpn/stats.h  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 1 deletion(-)

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
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ffea3f22dd181381d990c7290adb8a1b3e96f46a..daea55e8f6b459a299941a3368c836542c543c32 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -56,9 +57,11 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* cause packet to be "received" by the interface */
 	pkt_len = skb->len;
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
-	if (likely(ret == NET_RX_SUCCESS))
+	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
+		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
 		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
+	}
 }
 
 void ovpn_decrypt_post(void *data, int ret)
@@ -156,6 +159,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -177,6 +182,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb = data;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -199,6 +205,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
@@ -208,6 +215,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -326,6 +335,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 235850e2129c1aea0e6fb3a14519edb675590349..bc796c4e9f891a032f0766070c3200f4f3915c31 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -47,6 +47,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1b427870df2cf972e0f572e046452378358f245a..61c54fb864d990ff3d746f18c9a06d4c950bd1ac 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -13,6 +13,7 @@
 #include <net/dst_cache.h>
 
 #include "crypto.h"
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -25,6 +26,8 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -42,6 +45,8 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
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


