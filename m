Return-Path: <linux-kselftest+bounces-20638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3219AFDDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493672838A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28831F8191;
	Fri, 25 Oct 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SJa0VcKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380691E0DA0
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847713; cv=none; b=dU7qsv+O/7VsJyqAuk6LzF3t0XoaRfbs1njl3WG1aQ2I6cY+btKbwj7OHA37yvK7ZSUMRCHPkWl/TuRXlz6NxihC+lSJhk1QOhGL3bgDQWRv7hNm51APegA8VyDcrUnc1d69a+KM5rFIRoeBDSNbRsCdI29MygFyUQ6mTVrJsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847713; c=relaxed/simple;
	bh=d/oZ1l0fWzRgLy+5UEHG9eiWx5K78lUQdfIjXjT6ylg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yy5H4++wdzuaMbTCGMCMGiKkP15daVrKQRwqIBAnqEK49J+xNWCH9T3ho+fkgEQ5a9AW2X/FU1VXM4ZimKbHPHfka2sg9bu8exiicVdrge6jx7Y/9E1WT5h+j60kqh+kxyLKXZcZ3QHfRh5yJSPBSQ6clS3biEi5wlIezbyRB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SJa0VcKm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb599aac99so18306041fa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847707; x=1730452507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4jOFyNMJK97N8vw8msPWeX51yrB+W7Ufi1DwpaY1mY=;
        b=SJa0VcKmiSEupmJVseBN0G98Q45MKnvY2DvhYZpmtPVollpcE0XOH15jVq0qQvDnni
         p3czHlbj+Jlx7yoNYFe6F0HKzJyKw6NwfSHKv52oRy8drYI1NJESv01Zs5pR6nPFzcRO
         PCjJ/F1kBgsVCDXpuv4i4UWvoMDst/GxWL0fAkfZjVnI1KJLYn9PuLQ+qlAY0z8qJ5AW
         kHV/vYzaF87q9bSN+Gv6Ip0jzXSLhf80X2/osYpQOiwsp9aBHR1T38UcGusv9NkNfAJa
         NdDjBhqhgg7zF08k+mmT3IKrJvWF+vxqHTwtloBin0gyNkF6X0K3gF05SvmIWshBZNCa
         JkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847707; x=1730452507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4jOFyNMJK97N8vw8msPWeX51yrB+W7Ufi1DwpaY1mY=;
        b=l6aYxf7TQt9zrjfZCabdASMcYuRoN1dO2OEwpCic+oMcEkXbq9uKQbNDWaIjGnW/Nd
         dgtUvP3fkMM5FdrAlZl939TG4q9+bmVAZy7xv3Ag3N23FxHgMu68JbzYlHuHyU4+U5eG
         EPiOxuMTbP37nL/X70wk/04ImeTva4PqgV/GU0TR89LxtrSmt3OSmdZsy0/xDyerDd98
         nAwMsCH8tm+CDKZj85m0yTQd/M4/J4ddXVrDMkVL0zAcDW4vnbfdemg5Y1xDLYBQdYSU
         Q69/uKwfQm71O2Yr/6mUeabnly7DuvxQGSXRsPDC/1dKneL+GJiVl1N29PKu2AAgKz0E
         dWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW6l0FyqYchFMDAnb4JxRblKSJjZrlo/8xgnQHhEcIMLkDqpYipWgNlwnYF/MGNQofULD6DR1pxiXCR+RxVsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsY8QJsAg5LoLX9AJV/2R+hgPOWTWZf4z8oGGpeqWbSk37CV2
	opbCIZHE8gf4FtHb6lUbfdyB/9ZFQs0XuhM7UUowaNIO6NX0gCqNK8dw08GjQ1M=
X-Google-Smtp-Source: AGHT+IE+qaMiG6hfjcsDbsddlvekQgVsV7Fjke+0i9Ne6rapPvDJjc7O5klzOfcNqkyQkUkGveiNmg==
X-Received: by 2002:a2e:8242:0:b0:2fa:d7bf:6f43 with SMTP id 38308e7fff4ca-2fc9d375eb5mr42573221fa.27.1729847707181;
        Fri, 25 Oct 2024 02:15:07 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:06 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:10 +0200
Subject: [PATCH net-next v10 11/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-11-b87530777be7@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8236; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=d/oZ1l0fWzRgLy+5UEHG9eiWx5K78lUQdfIjXjT6ylg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GZ6DQuW9kIOwFO9NqXRJZf60vGJ4jZMCWB9
 yJGUjz1R2uJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmQAKCRALcOU6oDjV
 h7afB/4pwJKbx9t8hweAaKxtNr3hSo/4Kx5l2BMUF5HnfhjfmEtrXv4sUMPIhnyjGgFusRohHeC
 0nSbSxC+CodiZsz6w09v+kMVcKb1XiO1soZlZG2q2QcRnth+qmWugrKunLZjAyUMB3PlOxD7e6M
 fiylAWhl+MLiobIfDqtxHwVcSHFb7BCMCYjzQii0KVDkVH+Zohkdn8lcajf1qUs9TJ1ZgkU9tE8
 J0GRD/Q/lWVhsW8z8yknKObs5bEdbqWZnAm3+mv7Tq6MYYkSs4iUq0sCIZr9YUvJYpR8DS//5kL
 oD8j9kPfEwqHrUJTPXcOulMTdj0hKLe0Wx1hTPIBvwQHNWQk
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


