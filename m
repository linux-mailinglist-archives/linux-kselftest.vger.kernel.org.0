Return-Path: <linux-kselftest+bounces-19801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B399FDE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB70528710C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8B18C915;
	Wed, 16 Oct 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JqsHnr55"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2C18C034
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040647; cv=none; b=UoIZ92zRL+oEASiNkvMCHKVVoaGU3/sjxxUQ3mo85MGpnEHnbeRucyB787P6CA8JzXDNGZv4hctQPSiqvHQWUY857p8+WLhA7E6+nGXl1ZigiQvMz300AL7PfQw2p1O1Dd0USQBi1bmQ9OWmhD0ABhU/8kI7NxGucVgKaQqzi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040647; c=relaxed/simple;
	bh=R0lPiBiWMxxSF4Kond6z7kwWzsBdieVwTySxOvMQvAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eL6NFs+zUzjQt+7ThBxL8vf2c8UqGADRDZEDrwj+6TC/wfX8NESO3CzLWp4M5StgrGv3zr6luHGXbNXz8rHCJ2kfHm4n3A2o0lwwQOAMLQ2f80vsdzBZ6rPPlwceq6cNhpnIBaJVi0jbG0J1dhkTO/NagbWfTd83j3SoKQzfMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JqsHnr55; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d47b38336so3784948f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040643; x=1729645443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDhD2BKid0LL9GZoUYU43ErgOsQonUdw1fUcPF+4gFE=;
        b=JqsHnr55x7yaWU50Ga9w8ETBxtchXJeOm6C917SVAdnKs6D6iCwHA8wx9ttcwNiToz
         RHjQLMI2t9Xy3tEOVEdww4jXLIgb0AHX87jQCehfB+drzW2XX4Qy8yhztfpfx67zAg3O
         2xTd9FP3wYaDZqmyOZ2rZz2NoRR/1b3XBbuUAT8fKrjZygxtgyDP+P4T98qqbICpOYVZ
         M9cyl9o0ecXUM2JuvIxbnpBnTTOGBixWJPGYZJWhkS0Fh8ynLuaFW69fTla9QM2BFhHe
         wrYnqFgBdG82o+m3hjSoBYbZoUo8fc+IgY9tmagbC8VOAi4peGiSS7Vrn1x9SDL8hUYr
         oHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040643; x=1729645443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDhD2BKid0LL9GZoUYU43ErgOsQonUdw1fUcPF+4gFE=;
        b=dIK4Imsr3sd9Wjmb7Pqdnjph+r9K7rZZvAHImoOS2j6pdJ3+UkSxKjvOanL4GwfzPR
         MEIW0hPNj+iVfPt/Y4tfsL6GoUBBfEUXLNHZEqf6/hgpZwKfPL7u3i5Jq4gHZlAvi1MB
         8khi97UNIoELM11j/d33NQamdqZZ/BijLGId2u9Tfa25jfCUL/0bCuGVUJhM1DwKdJKF
         ezbL8LSBZfaOYS8VeBkoJQqqGprbyHpII10PDcdKg6cKTwRwCPyxWXoa5dHC8BdWX23O
         n5iI+9Duu7U4GaI2hMNS7x++4TQkp5iFEcxyUqX/Uvpvnr1+icBRjX6i9Ghj/TG50P8/
         /KmA==
X-Forwarded-Encrypted: i=1; AJvYcCXlKgzYulKKTjDfVC30jjI3yduleToVBwAMGu39eN/QseRcQFlNw97m84F927CHcFiBuNFZ/GkwA8eaoepQgMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+r3kgF+2Ni7qMdAkwC7rbb6En+8qNKZr+dDt8go75ybaw9eHm
	BNjjDFz2SyQcRVOthx+QKiz9Ih1hBytR9DbwlsmBrEWatMyaH8hQYmBEylz08Is=
X-Google-Smtp-Source: AGHT+IHRh/IpUwdA9QMEBJdcFuV3rJm0e/WkWfK9cZcPkle08ZblgSQJCVNG3Gc/1Uv7jRalZBqMmQ==
X-Received: by 2002:a5d:4e0e:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37d86d59a06mr1395596f8f.48.1729040642734;
        Tue, 15 Oct 2024 18:04:02 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:04:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:11 +0200
Subject: [PATCH net-next v9 11/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-11-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=R0lPiBiWMxxSF4Kond6z7kwWzsBdieVwTySxOvMQvAI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDvN8uiBfR1h1bryMr+oU+HI5HV1VyvzCGkR
 FoBYbLuELmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7wAKCRALcOU6oDjV
 hzQhB/9aa4I5e9zQGxRltJus7WNInxVjhIjWvhz1ehYU5hGUpetNYIPFxr3pD2RnrxswK1SQGWP
 /lUcDM4oN7tvtHL+HBA/HuPBAK61XAw8b2U+hnu7/iYzW08ZM0k3cRvrKXW63iJSvcIy1GD3OwN
 b13R76ZQ/fUm/2ma4IZV8rUjPmLuxX9OiRTts+EkkozKAXU0pz17lDHXVI/9Dh8ap9HMsS1Ep38
 Sc04qnub3d3pYNcLeyaQQkSpbAYjAfZxvidnXFw4yAd3MIq9pJeIacy7vGsvnDiXbbWwIiRJx0u
 baW6PJviMP9usu7Zay2tjvbbmVpPAq7VGV6ziPKVb53rHctD
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile      |  1 +
 drivers/net/ovpn/crypto_aead.c |  2 ++
 drivers/net/ovpn/io.c          | 12 +++++++++++
 drivers/net/ovpn/peer.c        |  2 ++
 drivers/net/ovpn/peer.h        |  5 +++++
 drivers/net/ovpn/skb.h         |  1 +
 drivers/net/ovpn/stats.c       | 21 +++++++++++++++++++
 drivers/net/ovpn/stats.h       | 47 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 91 insertions(+)

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
index 97134ac679c67a3d44a0bf49c2ddf058fd7c0e99..6599c8550390a60d3b0fb9c144beb8c7871bc320 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -128,6 +128,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
 	aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
 
+	ovpn_skb_cb(skb)->ctx->orig_len = skb->len;
 	ovpn_skb_cb(skb)->ctx->peer = peer;
 	ovpn_skb_cb(skb)->ctx->req = req;
 	ovpn_skb_cb(skb)->ctx->ks = ks;
@@ -216,6 +217,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	aead_request_set_ad(req, NONCE_WIRE_SIZE + OVPN_OP_SIZE_V2);
 
+	ovpn_skb_cb(skb)->ctx->orig_len = skb->len;
 	ovpn_skb_cb(skb)->ctx->payload_offset = payload_offset;
 	ovpn_skb_cb(skb)->ctx->peer = peer;
 	ovpn_skb_cb(skb)->ctx->req = req;
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index e9d49d10cf4e9b755d7253140b1baf55c49e8144..a770ef956792585d9b6bc779db2d3a353b349389 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -21,6 +22,7 @@
 #include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
+#include "socket.h"
 #include "udp.h"
 #include "skb.h"
 #include "socket.h"
@@ -68,6 +70,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	unsigned int payload_offset = 0;
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
+	unsigned int orig_len = 0;
 	__be16 proto;
 	__be32 *pid;
 
@@ -82,6 +85,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		payload_offset = ovpn_skb_cb(skb)->ctx->payload_offset;
 		ks = ovpn_skb_cb(skb)->ctx->ks;
 		peer = ovpn_skb_cb(skb)->ctx->peer;
+		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
 		kfree(ovpn_skb_cb(skb)->ctx);
@@ -135,6 +139,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_rx(&peer->link_stats, orig_len);
+
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
@@ -173,6 +181,7 @@ void ovpn_encrypt_post(void *data, int ret)
 {
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
+	unsigned int orig_len = 0;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -183,6 +192,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	/* crypto is done, cleanup skb CB and its members */
 	if (likely(ovpn_skb_cb(skb)->ctx)) {
 		peer = ovpn_skb_cb(skb)->ctx->peer;
+		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
 		ovpn_crypto_key_slot_put(ovpn_skb_cb(skb)->ctx->ks);
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
@@ -194,6 +204,8 @@ void ovpn_encrypt_post(void *data, int ret)
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
index 3f94efae20fb58772c1a4c47df5bae8bb11ad322..3d9f38b081a6531456a8fba3b15ed3e7cae4240c 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -23,6 +23,7 @@ struct ovpn_cb_ctx {
 	struct ovpn_crypto_key_slot *ks;
 	struct aead_request *req;
 	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+	size_t orig_len;
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


