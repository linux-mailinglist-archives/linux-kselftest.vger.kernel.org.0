Return-Path: <linux-kselftest+bounces-27686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCBA47116
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4240D3B2D16
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105A1D9694;
	Thu, 27 Feb 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HmhZ+eYh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B31B042D
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619380; cv=none; b=G7MY0oNOZSK7ZBTP7ApuT7DNNsFSaJRCJNJ61/aNbI1wiH+4Gp9nuBE9evwE8WHNOq2Rd6yQJO6WIIFDqh5vHdv9arDV9UF60hz47PSFPoEO1HL20MsGfo2fdH5iZWsW/J9ZDki5hYvIFZPBE1+eq2dVydJM5KGVbtlhrKMCWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619380; c=relaxed/simple;
	bh=cRRwFgZEgCiYCF/qq8LwK/eRT9Q1InTHsH4kW6aIehI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auMLMGU7t39AkUpeKmUsCWdZByHAkxYByz/dCI9nORRpqjPobuZ3z5Bo7eugGHxoX2F+1hsRwh5P1T7rMIrHd3bYKeNIWZULhaMiLfyReBPRWRa+21ttCX/FFKxMrh0li5tWdfJJGeUwyinZqyP5O8o3WiDQmuYAApJ3nwyDEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HmhZ+eYh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so213704f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619376; x=1741224176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uolTquqbxcNWD6yUjr9dufePpv17ycPHTqNsLeU+yag=;
        b=HmhZ+eYhXuVLWFdXYbhRVVatKv9zLbUQ269Dcd7/ff5Z37l+sOoDgMLvzyv2j0PGDQ
         vansliQH1kCS4QzL+bnyEW+2q3E2ItescP8ll5E6cuSX2Viqc8QoBbaK3/iMFA+4oa8w
         ZfhXzh/B3vZ3NmjYFXgiCIDY/xYP94Jae7dPfJ3NtMQsg06oCPehAGT/ioQSAu2B5nuv
         PD599ARuky15MGCxXlhccVtf7knxnBbcxhsiERn/WntYruuxlPP5JMyktnyM6wxcfsp9
         FzYsGrMnWXEi0DcrZFgtK3q6r6sGYfSO+EYVxfOaLVo9WrFldSeRD0G9YcsfrdTf2Yzy
         MNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619376; x=1741224176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uolTquqbxcNWD6yUjr9dufePpv17ycPHTqNsLeU+yag=;
        b=DyKA+gc2jQTZIWD1Qv/xVEFzHIOFfc6qmDsGNoYAbp4kowZmWDq5bTKyonAB3lYZxs
         d2cyuVl75F5B7RtlF3ASKrpNv6Sa6lq4AARlG/NYR/nK0+3Rq6MF+kNWS/hnqXtljEDv
         HEY71iivnNu9o1Ly+gPQEF7mJ61qZqlNxVdqPmyQaRfg6fQQA53IC065uNorniUdL866
         r0GtWL24oENVr4lfqeFUQ60zZl92qoKXNn5GRu5Pf/gx5/jcQPLYI6Qb8aJKwALeyLHE
         LKD/g2rwotqFc0klbxX0uMizna24q8djRUzcXQBGsUXECja8yJlrYa9NkniAd+xdtrRv
         axvA==
X-Forwarded-Encrypted: i=1; AJvYcCVE/hE4DzI87FRIcP6CA7q0RTyfz+/vAsSszWwtnJFwqlyLdQD66ExvapEV4bcKKuESUMKzVgOU0+uVRxDHR7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7i1rXD7gdEa+N84J8hJgvM7oxQgT7kxVCk9Iwc/pLxq3TKXg
	DCQakvV9rpZ8YbO1FyjK+Dzjvb3CizeTrJ24AUxX9jKFmDk+LPx4SJPPwpGU4G4=
X-Gm-Gg: ASbGncv+WVR1uGlXJgk4I3Y1E8ShoDTdX0lFi7ZBYZWEl4sz1E8keH0JfzzzjWi09lj
	mCoZeLQU4aeuBz0yna5gTpDwBTYaE8RO5RbMn0DXwPHZOIW54SHexfuOSTP1iYBCzDftI25xxnB
	6tRQAoDlj4nRAnGBEyw/KxTfSoN2NeFXkg+mflYNUQb3Akq9V1+u1PKY4wde33ls7GeWbuL13kS
	wh33JcMf+7ApPio+Z031XS3g1JkpEDZRjoEPmJQTXv+EZzeuYipmofWuyYeUpdU8ZrteBtBTOa3
	sAnzsuQM2ZEI3hOU46eVP8HuoZI4K7iLuyTFfw==
X-Google-Smtp-Source: AGHT+IE/yu/d1zzaPtOIfy9F1A4NevImsfqeBLpVgnfDGmZkjom3kO2BmtCrZXplDHb4C7XhL+sF3g==
X-Received: by 2002:a5d:5988:0:b0:38f:3b41:c944 with SMTP id ffacd0b85a97d-390d4f367d2mr4576343f8f.11.1740619375683;
        Wed, 26 Feb 2025 17:22:55 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:54 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:36 +0100
Subject: [PATCH net-next v20 11/25] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-11-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7109; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=cRRwFgZEgCiYCF/qq8LwK/eRT9Q1InTHsH4kW6aIehI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75gazPtXFkTaPq4ldb2Q6NUJqxtBD6uYxGv7
 BcCu/2i2SeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YAAKCRALcOU6oDjV
 hwIzB/4o5z6wqhdtWEADQNy4MRxIOQ+BKQ/TpVkct2lgO/qoI/Hq0PJEqWf9oWePDXZ6wO15JmM
 KSDldTm7zlcXuXJmmls2yitWEeLm80OXq9bHrs6FmvbWO3XtuDPUaKdKSxN8r57RLLJM5ea8bLk
 wWhIn5CB1xarPdmv93wc55N+RT9u85Sf56DpcMNMdnLHA5dU/nBZTWbKL7UXBj6ex9MYjdPSp5E
 sppJdvhGrlY8JrovvYOp8VBfahVujMMX60Niz8YC7pUdWPR4w/wMFpx0xG46mpTsSQtXG7d/pq1
 wdeyPd7f/P9i/Y+dKivuS2lRXWgB+Jf+JiNe/FQN5c+PCKh3
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
index d0b410535ac340a53f010d0b2f20430b26bb012d..50dc2e4c03f01b02bdf616473b755b6e1e6b57f7 100644
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
 		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
+	}
 }
 
 void ovpn_decrypt_post(void *data, int ret)
@@ -158,6 +161,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -181,6 +186,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -206,6 +212,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -220,6 +227,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err_unlock;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
@@ -341,6 +350,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 69522f063e1882412f662d98af94ea9a058d2e74..1f4148475c8b93aabc72694da5af97ae00a3a59d 100644
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
2.45.3


