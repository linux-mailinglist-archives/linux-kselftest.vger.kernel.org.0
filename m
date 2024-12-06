Return-Path: <linux-kselftest+bounces-22943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBAA9E7AB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D34C16DC0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72A21480C;
	Fri,  6 Dec 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Oeq1Gn7f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9E21E098
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519938; cv=none; b=g8fJxcZR0F97pT1g+8znL+g7GHjESbHsRYADpNff1vNneQVtcwnDNrC6Uvq73ChndtwYqX7I2MtKUhdvzIFmr9j7rkNgLlm1WizJeGFf03mjmK0ye6l15pZmFdj3POJvaBZTwPDIpeYQRGk+DBfP6JBvqrfIvEMIuV/ykIlMY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519938; c=relaxed/simple;
	bh=Tcmis1yXyG1Git2X+8o1kprRdEHNd8dKBzBagujoje0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQ1LAIXA6CEVhHNndCRcoabaGiKJCLQXAnqGBoPXyiFB3o68/2sMPLc3AqorRQn+THnVGvLx6JeOpfYbVnC/XuEDlbhTzhjt9wBZ6M/+hyL3ALn+yyCQoT8MffkzUKrY2v5G6nsOm0AH/lC7WwJSGC+WwWcz84ni8ZgiuvTpIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Oeq1Gn7f; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38632b8ae71so293201f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519933; x=1734124733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClGXX4576d+FS4AfSrsTJoO8ACeKpgP1Aq3SHCHN4ug=;
        b=Oeq1Gn7fDEoBWFXWFd+tG4/iYbDydG7sYsuGbVWdJ5/fAUUW9ydT9xD3drTOCTPTES
         1rp2KeVNuI/ClyayiHk1RVZYbyvniJtGSebXNvhu/9FMIUck0bejAfx9NC9PC2FXkyll
         5046Mf0A6wpVI2c1j1tGLGhxTX2mfzcBoJ7+k4fGrDH3lgQ9qvOQuxD8B68943WQZfkv
         ELR/j6RAmGFEu4gq4EISJDf7ZeJKQ2LmzD1r25LlhhD/D1NreHKlwLm6HWoSfmXRH/gB
         +8qelN5900Vs37OBz2gizt8RXb0Vf7WskME+SGOdON10JFv2HCagIFcLyUMRJEm+4Mov
         TQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519933; x=1734124733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClGXX4576d+FS4AfSrsTJoO8ACeKpgP1Aq3SHCHN4ug=;
        b=nkgvOw2BzWqeDbiLbzJU7wGn+hbq3TvRhder2CrUwvOcyvkQ7Xsaa+m3h4QeAZwrnW
         UGYfK8ucxL1zu9btANGxlBYYq4nPTweVChmoEVA5kPk0w2WyywkJLwvz/3TCgqSt3eD3
         oo1MFuLwn35uKUzK1vHXxBjhJNmppmj/rjxuGt9Ge0QOw4OGEjSijJLmYj+hCu7qhmi7
         eDT0+DyS//6INel5KiFyFi2WHa3gfnATc/HNh0mqQZB7h2VrlneM1191o0EkrazVXWhZ
         2QqRsZj9maHsDwyXNptbNB/ffOfWO8iLcqbzvTv+zpdDUUxH0IAoaLF9l/UdwA7nODQI
         IKJw==
X-Forwarded-Encrypted: i=1; AJvYcCWMJGaK8+ZS4csvq6A0k8tMcCAa0DsqYNzQqsKA9e+2A4fSAdB5WrInHQuBbulviJSfxj0IOicSq+BH8jgCzXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkhX2/MnlGA5IP7ewZDoUg3QjAewEAtnGv5ANgtC9I6/3dibI
	XIYpD7tOZVDVynwkt1+guWkd4UOZjnnFHeysHqJtQvtr4TADceemVy0Bc6d4EB4=
X-Gm-Gg: ASbGncs/7c5B9NcPMP3p6I1ZIt7HXNEqduuQY85UOOKvVTyzw+6ADHDAfpTZ6RR+EO0
	ProeucjldA8GZzQvxvPVl+L24pxFDGMSu5Gbs/359ojUyKwYdhDK6/fPoCTMdZzCc2tPh+rmp2K
	4jQRc88NnuTR9T/XCKndivkMGJiw7O1jfM2gTvGPkUKv+ZNSzS3x0OuSebaJXT/TABYn0wM/3Bx
	7/0jHh9d7YUMLlKkRvMpuKh/5tGZ7+a02Mz+iMghjeu6HjxYR7BgPYyYspzYQ==
X-Google-Smtp-Source: AGHT+IHtVw3KjxeCH9wir8jOx+KOef7V7Mp1iwfpR6Dzrz1WvJS67DDafbbs5mQbOjjTXm7dTPyaPw==
X-Received: by 2002:a5d:6dab:0:b0:386:3262:28c6 with SMTP id ffacd0b85a97d-38632622926mr1100016f8f.5.1733519933466;
        Fri, 06 Dec 2024 13:18:53 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:35 +0100
Subject: [PATCH net-next v13 10/22] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-10-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7121; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Tcmis1yXyG1Git2X+8o1kprRdEHNd8dKBzBagujoje0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pX+9u6++dwh7A49gOS1MllhYsQVQ3MUIwiJ
 pQ0pcjtb0GJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqVwAKCRALcOU6oDjV
 h7gLB/9NKT4hT1NATXan4/6K98i0mPdMdryB4MFbaoeQGWsg08g79yHp6ZB3i19cdwshPWW2Ehp
 w/LM4YLlKPj/6aEGv1+a7t2buHNY7QuZZnlhEKXOUc5YVnIT8gZi8pDaCl+K+BHN/MFJJZVtBkW
 ye2zBAQA39KCIb/XVWXy4eb+ut8Ubi0vdvfm9du9VXd2MunncMy2vHNF6An1Ja2XyyPBIdLXakS
 utkW++rXmicUQEEQVTKcOxxAQ5i3lYVhGIqpzAmHwqykYFDJnPA2YxQTtOAhaaiDfEzKb0OGJ9R
 jKrMBTDWdZiAYY+gVvQe1yf5XSRe1l5XAvmj5HPjJPEgOcZh
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
index a6db02f712203430942e3908480026f4dbac673a..8414dbd24467d77a5122daa9c3c745aa5e258c98 100644
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
@@ -176,6 +181,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb = data;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -198,6 +204,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
@@ -207,6 +214,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -325,6 +334,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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


