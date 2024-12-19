Return-Path: <linux-kselftest+bounces-23550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C59F7205
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B442C1888E4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE519F464;
	Thu, 19 Dec 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dyjEH/cj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731119EEC0
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572542; cv=none; b=hsvHl4XCSmqhnlt43HKLwivmASqfyb4Z0VlKZKMLGUG0aYIlFW3PWV228Ew0vsmi5nSSyj6MR7MOwxoELtMdpOtRX5hnTTjOmwygCzwVFKp4csHKhuUHDgJCCVsapAg9JfuDO6HNGT8UesbcT0jP1EK7x6CZW/whEfyNC3XwcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572542; c=relaxed/simple;
	bh=fCqciLR/W71bzuvpktMHPY5OUdNOI6ifWZAWhZ8MTr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rciYdFqQngf/u2PloQNhTOGGnLH8Ym87nyMHQp8GivLx8wqN8cbNJWLwBH4OaeDlLwQynOpmzKs31jnEIBi9zQ8JvghM3tD2J8dyhVNgdoLZzNF86r3WIOFa1F2rXAayx2Pr04tFjGXxYoJKdE8avraPGdH2uws91WrThK9m0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dyjEH/cj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43624b2d453so2697715e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572538; x=1735177338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKc+EhtfOkrVp7MH+s0tSEl6PA8FkwbztHSwX+cBg78=;
        b=dyjEH/cjAG4jOvNL+qZvamASshgs6fOSTBnWt8N4IlvQQzOsOTjPe6pkXQjNG2Ln4S
         kQVXcj9wVXxkECy1WehveQXHM7jc3sJuZHCoKUg3/jab9foGBZEm4i/ezVxhIIVvC/9+
         /A+oRImq8BCs/5SUgYcDBDL+pq+fp7xXtGHiQG7WHA0iYiu/nm0ClcesBqfUWn1xkZ3T
         ZTYfRKaCRloOwlc4O1E54GIA/K6J/zcu5fnit2U0PPcXIWp7H5venioPw3VCEvTogdgp
         OYjz0rjcJe+NVUePF8ChfM00E0rXZ09kPUkf2kTfRmS1lKo/DY09H5ERSLpDmOp3/vSp
         TbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572538; x=1735177338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKc+EhtfOkrVp7MH+s0tSEl6PA8FkwbztHSwX+cBg78=;
        b=TNhtLNqqeYc9Joxot8Gvt1qnkUeX5nIM29VtDFs65Go7Jnzd2FHqLriM5exMNc9h6L
         7kL5cpQHQJfi8VUAA/iqYpNpHN6iY0pP0X8NsJEeB9AlDv9gyOCHMNuk98tw6iy3gtP3
         fZTWiK0+sPOa2p9er65fRzkjGmwQ3X+Vt88vX9DAhdROXlMycRZTDybqPNRg3bDmmGaf
         JgKAiwX4qzxD1LEL6zS506xDiPVUGGTuHkScAFm8WHFpwrLnCdEoSxfaVtuoW95pzqoS
         J72ScrQgX86I00o++MBbQsiMamaJN4Udsbr37ffXqw0kxB+CaLZi5DrX8A7YqcJjQaHl
         lbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX09rWfLIk+5YJ9Qm/HC0GAVJafHjuJYXfRcDSH57+YR7lFher37mn5vCq6IRIPIRd5Yy3Sg3c0RNPMhrSlHbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/cXEAvBYAc5Nipvno4jiq/AedrjO3nC2UCEd1w0rwCQZc6fb
	kF6DD/YXhKg755H9WTEwes5l986K+XMk+EX0LbPwZmZ2nTBH+bKAAM+t+bcfoaE=
X-Gm-Gg: ASbGncttAWuYPR1nP85r61VkcLQ/kxH80A/IJkR1FCiFEtSSY1ZiXCHIKz78Y5sAIqe
	/IE0GxErKZie1/gzjTZGZG3f3jGSCctTlEFS4G1RFbP4cpCK4+lP6FISUCszWos7f5T+IaNDaZ0
	yYwHFRwWnesMPqEPLrmOFCYkQhnujeaU1hNXr8L7ail27+TEpeBHPrxh855PEFlMS3wjyGON/1u
	8t+z5ZG5OleYk+Aj3SnvBoPm/eQUl/FsWlNTVyWu2QSE+U3t+bdjhLVLc3nIIPylED2
X-Google-Smtp-Source: AGHT+IFmx+Orr9DLnNH1nY7wZdYurET0jag8IsOAcM9+xFIEJmaADXKtP/CShk2MOXtkx/XkvEUoqQ==
X-Received: by 2002:a05:600c:458c:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-4365c7c94c1mr9400635e9.22.1734572538062;
        Wed, 18 Dec 2024 17:42:18 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:17 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:05 +0100
Subject: [PATCH net-next v16 11/26] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-11-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7121; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=fCqciLR/W71bzuvpktMHPY5OUdNOI6ifWZAWhZ8MTr4=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGdjehWiHOb79jlf4UyipIZwGksLBd+fQw3b2ChNsMBJuPKVg
 4kBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJnY3oVAAoJEAtw5TqgONWHhMkH/ieU
 uYpoPuozsCwD6wNkX7jHcx2N6dfBn+Ulzt3WvhdUb7PK5yTZtNksapl+T/7atUtT5GDgeb61qMm
 nsnNbh1iY3VUwXldEa+S16Ju+h9JqYckU4vaJRDR1s/EYi4YuuuhCmd/B4dgPdLM7fSgjGh0Hxs
 UIqTM1rdA5D/wDTJu1ZZFM+Kcnaw6D71AHNjSY0e9UzWodA0RNC0YGbsn0O1i+Ooe/1nrAWnptR
 VwpfrETrEt0sVgOzhw/b6k8k8CKqmSayy/lyX8af/wpG6WS93GhY2qauOIzhZRuIRv/Z6HwhIwM
 JxN8Bf/lbJshM4msYrxC3EYbj10nIb9xT2CVFvM=
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
index 124292a49cd251a3b5021dc8828813941c187e54..286611bd5c63b704a8cc4eb32c0418c524c04304 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -55,9 +56,11 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
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
@@ -155,6 +158,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
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
index 405c6c6a5da6796372140771d7d23dc149cc29cc..d730aba685101b59e126d2f0bd51debd65fbc037 100644
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
index 1b427870df2cf972e0f572e046452378358f245a..1165a2b705b5d9a9570f77ae06367d23cfda2d36 100644
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
+ * @vpn_stats: per-peer in-VPN TX/RX stats
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


