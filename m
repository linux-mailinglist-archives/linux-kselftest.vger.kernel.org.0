Return-Path: <linux-kselftest+bounces-23210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91639ED8B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DCB16932E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EEB1F8661;
	Wed, 11 Dec 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SS60TBBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2F1F0E20
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952784; cv=none; b=e2S7EzI7B/QDOG2n6TPj2lh5emxDxUMs9rjFJad5maa8qGf+F+oU1M6HVl8b3KqiTa+48i8q1FgCsEvxFztcrnps+0A9rZj8PlTpXYEtvEjEq7Q8g0Cb2O8gUNPeyRcbc8OnNp6PElNUpk9+/xHYtUFTzf+h+PTgR2tgrL1+xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952784; c=relaxed/simple;
	bh=XYXnFCi5rzTTlu9j4UhABqPDSWcEQXtonTiPyDc2h2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+XJK+a0hLn5iA40dEq+fq+YPv9h8bBnX47lhURpucYaPxBerR2r+7YDyJebJmUWTBoHmyPhkEOxJiFZC/Ook0G3TpgYXRSu+f2mF0XM69DvQ+v+jnGF6fWJZcOx6cSkyq1PgWTMPyobUGyRSAqLuWH+RuO6swM0lukQNeJxCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SS60TBBm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e87b25f0so720967f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952778; x=1734557578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g9A7muvWs7aRXZSaGqpwgSiS0eoQl6l12v7cdtHlFE=;
        b=SS60TBBmgpq30Vkk8vUFPxMadHSMPGeKFHm4Al1fD+U8ixl5YO0Os2sWsXZpPX5chH
         yixp1BGKJA+dc+g8EwwMsZlsylovi7FmmtQQ1J4KEmqOpumUL9VDRGovGUNoJIAZLJ86
         4JukNy/11wo+Pu1FxnfBiTzXxeV2uGlLXY3SmsX1TfCzoljG+SoY0jMTv2BmblK9quPT
         ZTvrws3eNTy5tp+o8ujvUiUsc+QlMkj+RYfBFU6r6l5wWz+ejD7XAl+MGo01KQcT2OEt
         2TRh1qz5yE4xkBCZ+9jCFrtZnRm1Tp3AffzYY8n+vdfadWOdirnMVnK6C+snPPRkPor1
         iCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952778; x=1734557578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g9A7muvWs7aRXZSaGqpwgSiS0eoQl6l12v7cdtHlFE=;
        b=HM6f+naZ5axmbmEuZZ87+C9n2yftnvk0z++EweHmHxZVmAf3Ub8YAa/Xa54OIEDdpo
         0MApbkLR8kwgbBX4yqhrP2G7ZGvOgDKqErPMxYyuAO/YfBMdXkYSnfZtEYvid6DDptbb
         2rxsq9mIKDMqpOGy7EUi+wUvfSQ7NuGjE0DgDy9H6pEFY5gHOT3mxxdlersFgsYhlpYH
         QCN0XjufC/WDRMlXAXzdqZr5UnaqZJTTk2fdHcDW18W3LMHBvH0qOL/X21cBbjA3fC+V
         M2WO/2pCh18/KYBwqu92ycpG3YiT4H2H6twGL1jjxKHRB4UbHY9vpCFbsGCy+q/ZrBh3
         eAEg==
X-Forwarded-Encrypted: i=1; AJvYcCWSxaEI+8qCDgMEne0CWOPdvZU2rR7DtPBYt3OZ7igrwic36f3YQ2OFABbeyUaEHz2jc3OxAN86zT5xW7XGduU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBQ7nG3f2in59F+4KRHlGuRzgpkXkwlf0LfaknhogffGmNjV4
	+UEJ8KfbsvQFPul5rjHdVc/TpCsPSv7IZds1b5cUrITSLTxF2wHRjm7x4qzF+x4=
X-Gm-Gg: ASbGnctZxxyW3ISikU7UhRIIYQ5coc0dU3fItJ1eltGJN0fuP5gIdKBOGlmQV5gVN1z
	RiCzd+qBNxfp+JCW9j4+Q09F2EUo1sGu0qop+PpuJRr2MISyO2jBtw59fXZl546nIyPURwqR+Yv
	oXu0FVpBHU/3gcHGa3QhD7w3hf/j+IfTinuwkxZ0RCEtVBP4MC90wVPBOIdbPCWHqfJSIQihuyp
	OxeQEKOa2U+Vnundq65tdqjMHXAlvebOlGPljjMK3H6TjQqc6dsQC4BsS7OOSCBrg==
X-Google-Smtp-Source: AGHT+IHIR1ZHf8dWDnWyT5X0Tns5g40oDAr0CAkWrjQ3UMvKuvzTVUkxYSejegoU4YevKyf6hyKljg==
X-Received: by 2002:a5d:47c6:0:b0:385:fa26:f0b5 with SMTP id ffacd0b85a97d-3878880f38amr418367f8f.20.1733952778412;
        Wed, 11 Dec 2024 13:32:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:32:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:14 +0100
Subject: [PATCH net-next v15 10/22] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-10-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
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
 h=from:subject:message-id; bh=XYXnFCi5rzTTlu9j4UhABqPDSWcEQXtonTiPyDc2h2s=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUl3FVGCsp40b8etPI2i9toxxnw6RSRSmaeB
 iwTEadUY+qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJQAKCRALcOU6oDjV
 h1AaB/9gWH2rFiJGic6LctqHXAchzxIHNqbxm4z+8U2WjK/ttRjFluDpT9MXde/eMPQ8H/YO2e7
 gSATzM+DvOjV5xpHJ5HvCrqpvnwOaA1cq/8fvaZ9YSPn4HZXFgaftplGErgkrXMSdFSEser/bwe
 QQcF2kMBcynKoWpyV0UdKq1K7RNqrqmQSlUbigxko0LpXpikLiq1tZ9QewLQEbYqTCscclojbwc
 ogHolj8MwfVMQ8zKoCYOz92CPe5QlJ48V8kQ09Vyj8NX01nrAr4PX/AcT/q+0gMxohxCbwO48HF
 z3g5yE+4lOz5AaaJtJpz8HrCvpFkQBn8j75OHSJ2BzJCGRa+
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
index 456fd70ccd2a7e37f0ad1732ca9f5a07f2f54a97..0d625f065255c4947a18ae475b04c27f0cf6bb32 100644
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


