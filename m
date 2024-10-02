Return-Path: <linux-kselftest+bounces-18879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66598CF98
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086A31C225C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA01A256F;
	Wed,  2 Oct 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="E8LQ5tX3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501A19F403
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859817; cv=none; b=NtIqZ1ptO+W8uWJd0MGilUIOzQVYla1SW9qy1KQP2uZJvYp0//aC7zTa+p/IHOxCd3gkSOdtbhEsajtP5L+//I9e6CIzv2pb21a0epsTWNr9rYnF85x71QzX4a5OAf0CugBjXzjDmxyNWnIDlNju8mVMeEUe3UkSb7HlqIoskc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859817; c=relaxed/simple;
	bh=MbfNhiX/VC5KXRAabUqnselsAbcgMGYh8QbiPT72LO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ug+TqmoKk/x56JqpmGEAKnKRw0W0kCFYoXK0VD8yJ8iYsuXTJFvQ0Zh5ly0Xil2oZ3LCYRE8I519CimN83kCCtNWKrGGRo+2JprTqPlAt65grT05JvOPo4a3lS4Nd0j0Cbb81ELAWlqL3SgYIbt2LpnISA2oOqRA92e1QRApoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=E8LQ5tX3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so59133255e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859811; x=1728464611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDdskZURNVON1L2hVJSRcyI2dGmFk6sRhpefpO0czDE=;
        b=E8LQ5tX3G9dDMskLC6QfO1o0ZzAzZgmRHkMSAZLHhYqx/T+MNEVUF/QHmgPS/TrynK
         Kr5ImH8Q8lebv0vUV7t/khm6o0p60BEypymMERnCFB0Ik38+NSemh+HCbG72H2EDUMzr
         ZYyJB4fF83/eMkeXJSpocAqSkcQAOGJGE1hvJDRHJUoDb8Kci13HgtXgWM8YzqTOEbJt
         sz4GaMx8Y/rVdL3cUS1EKsfdjaFgJpaBgmmrZ6f5EUa5GCC4wQuSzMxt8QiMDrrO33Wc
         HQJxagKDomVIWAnIUHPeXyFZn3+ivKqh71i8KQZq/EGMmnWxOtcIsxKfpH2qTq7QSKtv
         v4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859811; x=1728464611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDdskZURNVON1L2hVJSRcyI2dGmFk6sRhpefpO0czDE=;
        b=lOc6m43OPH/c6x6BrG86jTb614JBDuMpVWDarv1gVmI2HSzTuhXLiNqLZtnF4gUXfn
         XvBdTErwLNGijdBkREQZbXRM0J75G3uSYpLZbyS0fvRDY3wpR+hMKbwFRmbUXrYHGKDE
         xlEWD2TxkMR93VEs8qqW55kkFN9svDPyZ9uFS+Zu3V3l4r55nUpZoXWRG7R2IVN87zwr
         APJynnOJ2LUHIs2xNSVulsmlwKJ3vYWZmLM8D73kX5qzVhbooe7IcZqqlC9wAchCFKdN
         NWYJg0NpkFc/E4v+BNYkbM6GGPdvWmq5748YkuQ3XM9sHcZrf6hBwhtXuptX1p1nBQet
         zRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj8RqGuXoPz2kqzEI3PcNYSqVUW1Z2HLInQWbN64KQwKOn7no8UP0VYZjDFJPNK60wkGuui5sC+3mbWyS0ItE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgWBfQSfJ40TF3U4u1RnLNr9QvxZFercOPKEQa4jPEFBsf17n
	4mKEIseATZiOZlGUnrP8YzZfadz0etC3jFX5kMAED/ulNWEKz8xNtME0dnCvjJw=
X-Google-Smtp-Source: AGHT+IFaQk2X/pcKsqICPm06ryDSXl3HPbj+9pjaDzM2ckG1DsCU6n5uxZ6txvEAYBmsoKa19RkMHw==
X-Received: by 2002:adf:f045:0:b0:374:be10:3eb7 with SMTP id ffacd0b85a97d-37cfba0a7a5mr1574186f8f.38.1727859811157;
        Wed, 02 Oct 2024 02:03:31 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:26 +0200
Subject: [PATCH net-next v8 12/24] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-12-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9036; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=MbfNhiX/VC5KXRAabUqnselsAbcgMGYh8QbiPT72LO0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxSmFiehZfMVtsZa9b/4zO8X45neXujJirJu
 x21l4bckJCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUgAKCRALcOU6oDjV
 h6f/B/9IGSZ/T/muJKO+acZyYgSeVaJcB1wGsYujsfR4mqUmTFkdbgjd8AK7bZ3IgMJ+GThlsXJ
 r69oFJg7Fm0EvHaMGxYpYM+eeUspsQncUOgaSwVycT4i94Da9EjsXVN/3tK2e8L4AimwD6s2X/v
 iOG43DglaaHfuXsjnbEHM5L9AJt9txs3mMliRwkZFpkkHcBCo9A3tKvrORnronjVRZ6rCibXDGZ
 t7/pmMl3/4qYCnAwJ5g0W47+ogKNSMbRaFZtX91sai64nBFEyMcmyMzshzyZhOr12KazG9EXVfw
 DU3k09bw8EskW3aQCfK8N7iJK95f0/mQgdQ8/jPvGB9RvZwU
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
 drivers/net/ovpn/peer.c        |  3 +++
 drivers/net/ovpn/peer.h        |  8 +++++++
 drivers/net/ovpn/skb.h         |  1 +
 drivers/net/ovpn/stats.c       | 21 +++++++++++++++++++
 drivers/net/ovpn/stats.h       | 47 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 95 insertions(+)

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
index a75aa301b99e6abff04d5cb289b26b5979906ae5..d54af1a0f03a33b03001a041e62554b35a7f5ebc 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -20,6 +21,7 @@
 #include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
+#include "socket.h"
 #include "udp.h"
 #include "skb.h"
 
@@ -66,6 +68,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	unsigned int payload_offset = 0;
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
+	unsigned int orig_len = 0;
 	__be16 proto;
 	__be32 *pid;
 
@@ -80,6 +83,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		payload_offset = ovpn_skb_cb(skb)->ctx->payload_offset;
 		ks = ovpn_skb_cb(skb)->ctx->ks;
 		peer = ovpn_skb_cb(skb)->ctx->peer;
+		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
 		kfree(ovpn_skb_cb(skb)->ctx);
@@ -133,6 +137,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_rx(&peer->link_stats, orig_len);
+
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
@@ -171,6 +179,7 @@ void ovpn_encrypt_post(void *data, int ret)
 {
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
+	unsigned int orig_len = 0;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -181,6 +190,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	/* crypto is done, cleanup skb CB and its members */
 	if (likely(ovpn_skb_cb(skb)->ctx)) {
 		peer = ovpn_skb_cb(skb)->ctx->peer;
+		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
 		ovpn_crypto_key_slot_put(ovpn_skb_cb(skb)->ctx->ks);
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
@@ -192,6 +202,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, orig_len);
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 212d1210bc564ae804899d7c3bf8c2231e732cf1..6d34c56a4a51ce407b20b6175e6140aafc4b4e33 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -18,6 +18,7 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
@@ -47,6 +48,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 70d92cd5bd6348dd91956593d7d87224061b85d0..89f6face71871e09f8efd533a949f0d9358a1342 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,10 +10,14 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <net/dst_cache.h>
+#include <uapi/linux/ovpn.h>
+
 #include "bind.h"
 #include "pktid.h"
 #include "crypto.h"
 #include "socket.h"
+#include "stats.h"
 
 #include <net/dst_cache.h>
 #include <uapi/linux/ovpn.h>
@@ -30,6 +34,8 @@
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -48,6 +54,8 @@ struct ovpn_peer {
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


