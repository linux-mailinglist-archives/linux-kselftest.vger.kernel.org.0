Return-Path: <linux-kselftest+bounces-30848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D9BA89BFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539D1441BD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13428F53A;
	Tue, 15 Apr 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F+0eZrv0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A32973BF
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715866; cv=none; b=e1LP4B8a/22UOSUCrEgtzuU7KiK0JUeLrGchWP02mQRMI5NnwfUVraIDOT9d19ApFWZgafisvcU+dAeDKP0ywPRERWT+LIVMU4o/PQ9r2X9LWmHF2+KogTtVwPsZZ8KRhPjUUrPtvh3+Q52HSmUv1WPn0rp+HD+kkCMpofpaaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715866; c=relaxed/simple;
	bh=urcFahA47J1pElkhnEZnA3wXpRcRwV6IPsSmimxSZcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+9dMz/SzIU7RWPzbVn+9rRRpfv9AF2n5uQKaL4qoneOt25S6HW7YjRi67WWGFTcWTNyO59WU5ddwEfA6NszvwZWAHhNTVytK45dCRlHjvG+ewv6wMYli5G0l8gFhSAsmkuHKcKJYZbXKBLyRsVvIDaxIgYqZ78S+ocYDOjzIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F+0eZrv0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so36708075e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715861; x=1745320661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAtgxQ1ZXh1tMUFeov5eFpC8kchOzVrDNoGd7hzQ77s=;
        b=F+0eZrv0JgSv87rBfqQblHZM7cfhUhLOct5gYAxtlOYArKF27r8OfARtbPxokZRTHd
         dXVlBX8ncZpNhY6q7LiV6Uajn/4TPqR0m9zRaR6Rr7cgKv5IHWE2IS2Bl8vg+Ixgjmf8
         sV2fwiqzQDlXs65rDJcpdo5Rv+ONNZdbEmn5ngAAelW2hgoond0Fg1/YZ0kfMcX62YVa
         9pSbmbhAcfjRx3/5zshRlBLu3C3lQh4DWOdiy3MO5HNtPWqe2nG+vO5KA9j3B3dV8evr
         WeoHxUA47zAZVAipj+Ene4gQJJmWEfTJcWqJuvCHksvNmEtBts750nMRN+BZWqKQn/9/
         GNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715861; x=1745320661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAtgxQ1ZXh1tMUFeov5eFpC8kchOzVrDNoGd7hzQ77s=;
        b=rfG+q6xxf4bl6eyUyG4Kw+DLb0CdcgifKSAaDfdk8T1GIVv9aGr7kAnaZlESBsd0mQ
         FgNjvh182IYKoPUsjmKP5MJLTYsnsKSdUO0mRS6moPEF6je1uq1erw26RGkxSCLSbsDS
         CdhRW9iRD+xDbsYh6jkWccg0321OEBRzaxZKfBx31jHpuDNiPRTQGER7jYk20rlMW+V6
         Nx+8hX7xBeu8zClNMPgbkcxWJ35BDSHFXD/m5wT9tA/9PUSzYVBDrPgnNvzHSCMKAqjy
         g/EQUuSDSebqKRJ06J6cT4tj0h8rC890vjcq+oCh+RAfQgKFdWu0C8r7MGY539PrcQjj
         GfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGHpNr124rnPCeW8YJqllInDsIb8g7aA7y25MnctSk7bo5/r5C4s0fu/XQKYX+OEH9oWhqFOoNkftV7z5oYTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl8i3w6JVovN9g4dcWglKNweyCg8ylQn3DtWwNAjQ5FHs/JgtG
	r+FG85oyLiHqQbnpVQP5IgRR+QLxEVou/s0XmIAURxuO35jhDoMiV9wcjP8s9EDYZIxoy9kHAlK
	P1vzP10u8UgHjon/KyxxDpM/jWCXRLX9o7c97zsNjvG04Y3L+d2HhgreK1dc=
X-Gm-Gg: ASbGnctcB73oczXj72TOGtP0/lUpx855iXr0LRvBywODjCw+Cn7ZVWE6TEtQAYxsVS8
	YD4WXM/w4dpGRO8GigV3nMdsxxnIa2YzKofM/djmkavIaeTDuORrJKPPxGnMDtU+fW1TBOKK0kc
	32prLy+0ZFMWEM4tQwGrNlXKv/wl/TEqsiZwHF4208Pd27F7465TFXs7t5Zv4eXZ3Vj9ogFNTI9
	rsVNnz4JQV+ghjk/SJKlOz6pH1FRIeO3tFlRFXITROMZFvs2jYNM2lX+3ewwsoyhBb/3kuSVmay
	9GpblvyxskvuRd4tbmfjKVSGhhqrNFlqWOzG0w==
X-Google-Smtp-Source: AGHT+IEsKIOzgcEHTHD4ixmstMrBe2jywdP4jH+InbBGGKb852aGFnH9pIv1g8STLsl08D0n73bjjg==
X-Received: by 2002:a5d:584f:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-39eaaecaa9dmr13803707f8f.48.1744715860840;
        Tue, 15 Apr 2025 04:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:27 +0200
Subject: [PATCH net-next v26 10/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-10-577f6097b964@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7104; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=urcFahA47J1pElkhnEZnA3wXpRcRwV6IPsSmimxSZcQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBBh0COy9QEw8A3e6QLItiOMImqupeOuPfdM
 eSnuOHNddqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQQAKCRALcOU6oDjV
 h16SB/wJUA7VdYNWzCbSdlXlx/vR9DHz8hbH2k0+J5Zgp0HYzjyRbGI0/wJ+B6A382CmeF0Q2/V
 BTvBQOKfXPbfpANZrpp04snhjvV17Kbb34yKXfuyGqP0gSUYWjF+7fUAhXppEoDE8Hlb+QUxafx
 SJwUoI+3J+uXvUfnWl8eprR0flkY7ehY4x1/1JqOWV/t0KfZYryY6Ku/1iBM3Ak9hejIP5fc5lm
 huldhRcrg+Jhmqq445mDwzBQbbFbAu1LOckb2zuDStSe+x6/MIuAjDuj+giPBtD7QIhk8/aCuC8
 p5Ksfg2mc4shLkyPeTDy78Zi1UPUEIctfgNSh1WMgiiPe0bL
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
index 38c9fdca0e2e8e4af3c369ceb3971b58ab52d77b..04c3345807c5d759daf65cc80a290f784dbf5588 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 846b6d7d4ec698d0418fa5dd7f70bf84bc62fc99..bf4d471e6d149c4c031d989833f654404e4f0458 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnpriv.h"
 #include "peer.h"
@@ -55,9 +56,11 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* cause packet to be "received" by the interface */
 	pkt_len = skb->len;
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
-	if (likely(ret == NET_RX_SUCCESS))
+	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
+		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
 		dev_dstats_rx_add(peer->ovpn->dev, pkt_len);
+	}
 }
 
 void ovpn_decrypt_post(void *data, int ret)
@@ -152,6 +155,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -175,6 +180,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -194,6 +200,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -208,6 +215,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err_unlock;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
@@ -322,6 +331,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 23eaab1b465b8b88a84cf9f1039621923b640b47..0fe5333c6b8104913526dacc4d7d2260b97f62aa 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -61,6 +61,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index a9113a969f94d66fa17208d563d0bbd255c23fa9..2453d39ce327c6d174cfb35fe5430865b32c2efe 100644
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
index 0000000000000000000000000000000000000000..d637143473bb913647c79832fd9eb3ebfd9efb59
--- /dev/null
+++ b/drivers/net/ovpn/stats.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
index 0000000000000000000000000000000000000000..53433d8b6c33160845de2ae1ca38e85cf31950b7
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
2.49.0


