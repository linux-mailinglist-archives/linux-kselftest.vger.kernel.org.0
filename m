Return-Path: <linux-kselftest+bounces-24254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16BA09DDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32487188DF27
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80271224B0E;
	Fri, 10 Jan 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NI5zFkFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CC2165F4
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547989; cv=none; b=f11CrGCYFffcKA0pM7hZOc1nJ0w8JU+MgEF/r0ThJnDrkXtkjUDH3LBqYfU3oPw7DB7DhfUHLlQTKhz+LBq1aQMzgjgB1lg9JTLqYovgl+zSJJGTJJHMtA2d6riUbHprr+/MV3W3GqatBZOImw6qAaPlO/0OK9PaH03jZ9jB9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547989; c=relaxed/simple;
	bh=YEwXpITnfmmfjDri37yjkWpilIezNwjZloD+dOmmn2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghWJrs4tyEHt9rvDezcEw4o2J5A+Xf0Oda39eZ9Dvd7BuKY70L1I5UutaZAV7AwxpbgKjdV+G1DNJqo9GBpvowXWZXuotyriV/y5xoYm6XC+740Gr4XOUE5m2kxKabK27YknY9rGokNZU6ckJv2SsBEA3R6AA+LzkARyeQh4XwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NI5zFkFp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362f61757fso24739775e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547985; x=1737152785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A24zsR0E5ojEM3kKF/g6g3hOO1N8R2v/wM9q1YZrt7E=;
        b=NI5zFkFpV21JIbAsCmdYnpLTDX+y4p22nXfrIDZBmsGRMmedpqxZPpl298/oIRubld
         7UWum+p1gRYcydPkN6CgvuNftL9y8H4Y/X3H0QF2R4GC8wa4QncggCxkyqrfULWeeiAd
         gvIcp56cLb5XesyoBKleSBoij0HWNM9nIxML5Ka0ccIVLSBrEF0vXGF4dLum4z4BMcWc
         gv7DXJI9U5XD2zxkBM6pcunTDcR7zEq7XbQjPULdPVi3rISGwNZEkFNKqxHNnj1tiwi4
         7U6kTaj5LKccPYjEcsiyvVEDB95nBWufpXJ6QiosmGEueAaevBoBc1tohyB3OAW8UAE6
         J6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547985; x=1737152785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A24zsR0E5ojEM3kKF/g6g3hOO1N8R2v/wM9q1YZrt7E=;
        b=DtUhGetTA6lXFzHhoJdfJCOc0Mi7GKhDLg1O9s/Ql2oRCtxManjDXFKnrHVQdjOujR
         ExYy4WlZFWPq+8DzhGJQLpljy0WUJgpBL77S5Lwz36RpDmEYpznHRYLXwiGzDidMaxmQ
         D8x+MI4AsLAOXHKf8BLOmiAtWamfMY6qMP30z8OmVz9dbwzwLGBGG3b4o5rxqHtY2V7E
         aueoa/jcYnjD7DbtDdnXddWec3WEW82iFIQM83htYlDJpnQaN27jJIOpWWq3bB+y4UBN
         qjCozI+Bw8jgX8O9Bz8teJmRpEf+V/4a3lc9mbLibgurnyj37u5i1sHA2ffL3/Pd28o6
         gluQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2CusAlFs835sRuBwtomxfKJTlV0pA0CyFWJCAzYfsy9V1AAOon3sF+UrzgnM+mE550jCbi+PjjTO8jEjiqnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFL6QTlC0XEQia2XsGT1xwA4zDa8eNTABHeHRCJUTwwZi8oElf
	3rcqfJVUvTWMBYhj/kNDiM2O4jagwPYyTc5+eqw8Wix6lSEzt57cDD2eLjbT3fU=
X-Gm-Gg: ASbGnctu1EMtLSeXdCi3XhvWyoD7N26tiTf5LU8HrGHT7Arvzn7RTZhT+Pp20mJa4S3
	wQdGl1nnqJPMZmUO1nstzqRNcQRfnTIJBt29XvBmTU9mBiFotUSUZxTwxJ/cLeOktfvv8QaAERK
	YhlM52au4AxYh6csHyA+kXioMdu5sLEcUqhlpMP4eg2TWaes1tb8ImZ15frWJH2AjtqaIjPRSv0
	RhWgkKZoEL5liBcOrTUoKBhN+L0EqSl77sinKdpW52jU9xLccWo5l7iQKWcpE0RKYQe
X-Google-Smtp-Source: AGHT+IFcRPHooOoMt5r/SbkjDaiOb3JxLmUlcBTwVaJKuGCcm89r1XeA3efXO6dM6ylqj8GZk7KaOg==
X-Received: by 2002:a05:600c:1d1f:b0:434:f99e:a5b5 with SMTP id 5b1f17b1804b1-436e271cf4amr91939545e9.28.1736547984775;
        Fri, 10 Jan 2025 14:26:24 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:24 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:26 +0100
Subject: [PATCH net-next v17 10/25] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-10-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7114; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=YEwXpITnfmmfjDri37yjkWpilIezNwjZloD+dOmmn2E=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xTVci5SoMPTgXU+gtnqTqtEiEH2GmcLy+L
 B5EuiiuGDCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h/KKB/9VfqC/WNIx/B2yxd7o66dbU4yoPs4N7XZMW+4aNyW6ihdLQTvpWjQU1K1/Mr/HyU9IDW5
 n7cDQlFWxHbPHyqEy0Lsfr1EyDkrq011f2Gd73gdDMb9M7TjDb8utwSPHE/uoGnwd6EYBXSzUik
 /WXDU0w7C8eFT7/eFPFnMpG7xBhfrj6X1fuAwupwu7DYAYXz+shPFoyVq/fL6CdNYns5FRTNQ4Y
 FBHm3+R9eAN7cTtbaHikJWYaa3m8ikN8bD7M/IWGGk91+6XVf0LhBnFBj1Yq3K6L2aZqVuq3GJT
 JwVIxAEtZq6JExja4HPZoxGyo1PIKkklTUhCqjpVSnPMiTYE
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
index b2a8a816e8b1d455f5917035b6ef34f771132158..85505fd9fd72cf10aea792bab92eaa8228075cf5 100644
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
index 275ec57a384f537cc5fbb675a8b5b3d6bc895caf..52d6974c6afe5e3c9d272bc2ac076b3843f7559b 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -14,6 +14,7 @@
 
 #include "crypto.h"
 #include "socket.h"
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -27,6 +28,8 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @vpn_stats: per-peer in-VPN TX/RX stats
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -45,6 +48,8 @@ struct ovpn_peer {
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


