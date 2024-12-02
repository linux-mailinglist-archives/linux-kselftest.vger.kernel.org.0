Return-Path: <linux-kselftest+bounces-22691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461439E0669
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E6828B5AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAB20A5E5;
	Mon,  2 Dec 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NviI2CrH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E0209667
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152122; cv=none; b=gK23rHuw9X5Z8L0l+sE+kdPDXAVOVs6YAoeXm9VTRa8kyVd0l4el8SO9bWM1kCBQDFhOymik7WjLG22IvJnBApw51phALUi1rv42qmi7mKYKrHQ1SwkRQ6jDMxzAOpKiEWQ7ZNSZUdeSy1fzmhGJV4GD5BxmRSrqW0X1Bsy3KOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152122; c=relaxed/simple;
	bh=LS3vsQAgFe1yLZFyKyio2RM5gBggs7s5skt7mLt+ZeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXxLSJJye32adKUWULEqmeYjDhr3My8TRrxTrt7KqdHTNL2a6NUcH7Mv8pDvC/GuxJT/tjJXSjWQwS/phNyH5OWYgbQlJRW4OhFzQJ59I5J6lKib74xpqsmOYq0hC6HTaoFPaZSYtaxwbsQzEI5jfydpLexecAOMvq6QvHev+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NviI2CrH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so37206915e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152116; x=1733756916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nBwuZpWYnHOlMtKcjdnP7mpmehkP4pl0JAWhvQ3Sfs=;
        b=NviI2CrH07a9IKPWf5Qhcp8dTvDa5PNXnEYwpx6QHpFl0Wpok3zq6BRX7GoT3TbBDV
         ZrS28PYOWLCx6DMva4Nhnv76ZD5+fF0j1EkKqiijOU+1wJltAJf7Pa5bn6nXvBXXp6N3
         TxENwKIW+NJpdupneSvcAUcKY4i3eil4VvVW95TyanWPu7mOfFOmzBM2bta5udDrFq/S
         YePQ1nNDuUbFFZnqd9/klpcqpPajelnNzLPxaxLmpmD0sKMX6wvpj5JHWeN0J27+Bb8d
         /UurSKSL1KBKD2lpQ/3GI3uCsqb3Qylsulkl67o6OzhoEeU3Nk5cMrgwKMoEvqUXGLMo
         PNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152116; x=1733756916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nBwuZpWYnHOlMtKcjdnP7mpmehkP4pl0JAWhvQ3Sfs=;
        b=AJ0a6ed+IgfEt+pcwn2wjkeNfXozPvlO0mDwupxJk8nrpi77CLg6b8LLOQA81c22mI
         S46fIKlwjrGfZKttQkHUmF2qzRziCPURVVIF3bkxJZriloH4NtEvJ0abCFP2SAC7YRca
         kylNAu6X9k9hXkvcv3Uv9GZTmhX9cdfeuiwm2RA/xW6F2zQ+QslWdcnxi2XJX+2mtyFf
         0W+/LU9ob0a9hLorBMxvLAhtDnVZ12zkKPYPwHl1NRWiEQWeG3rRtDdMtiDmeEMprvWt
         d870QSIOSX2fzawkbIcFk2zMXNTKJI/9LFKDLXXh6e9cQv0NwY70JptA47jnRqUsJX0N
         /gPA==
X-Forwarded-Encrypted: i=1; AJvYcCU0SDH9pN5/b3mWpocJFyEhD9l2cLgGwdlPvg3ope9EUikTWtUdjlyh6mMUoutb9T3DqxVPCY/b4gI+zcAoHQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzymtncfeJbAp2FX5+Wr6Zn3PcLOrOa8rbKFXqKpmyGVgTh2iGP
	KMdnLc0JnDPOVam7UNO13lHMEbQ1wailvLcYIV8gD4K5gmfGH7QgvVd6otK21cU=
X-Gm-Gg: ASbGncu0g7OzOjIeM/s0BVEBj/gfPdP2qof+524YCiW6Q32DlfYYinWlLwuO9y/T6Sz
	weI6+7+izZwJpZ9Q8tW0nIkhzMNXPp2w8zkYhbCTHwjelTkCs8y3spxe08EwBSqnvhdb/ZBxv++
	kG+B5Q2585Y0N73MhGptCOhvX31AU3lUiLmwo3F4siF4g9O+82wMUlzkw+oySGA7iOMpmzMm9i9
	qjUJh+oN0vxuXEeeJUMq0SpPA6i70F0LhUkTXL22Gjy9yJWeLXE39N3PDin
X-Google-Smtp-Source: AGHT+IGx5mBA+TMux1L8lB3MFwstPdqqRq+fqgbiYwEmKN1gh5nhDNAosbfnOTvqVvCaR3wz3ZzhJw==
X-Received: by 2002:a05:6000:1fac:b0:382:4926:98fa with SMTP id ffacd0b85a97d-385c6eddc05mr22391672f8f.40.1733152114504;
        Mon, 02 Dec 2024 07:08:34 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:33 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:27 +0100
Subject: [PATCH net-next v12 09/22] ovpn: implement packet processing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-9-239ff733bf97@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=41464; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=LS3vsQAgFe1yLZFyKyio2RM5gBggs7s5skt7mLt+ZeY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1mtfx2d/cqei1xbcX5ECX+WhbDT/jZfv9e6
 MyRHQMFP6qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZgAKCRALcOU6oDjV
 h3cIB/46zJs9WNjGpPpybAhdGJe5aJqzhPds8LJ/DV+CtyHkHtC1iZIGaHXrZXL9tC3hxwJeK4/
 gNuMV6Bwm0OMG/BW0sx+JjUAtN4ATGZwXeBldW1xMNzhf/7XEUIIOqO2t0wAslSZbKf+BCHV0m6
 VHR0EF0T+qO+hzHXh4QfrgoCBVrBAw0cmu4GoIUJR9yNNXfc3vQtiftX2v6LKwEubHpGl6Yij2L
 Z0A3LsbMNDSHWzPw3vcJY+MzA8AaHRFDJyTYB6t5hTHdUPvHaqjEfwuDHvsZwbl6GpiFD87t2MA
 qaiPJeQpToV3J03cGabEdalAAMy0l6KGzvSeDe6stoCSXBr0
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change implements encryption/decryption and
encapsulation/decapsulation of OpenVPN packets.

Support for generic crypto state is added along with
a wrapper for the AEAD crypto kernel API.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig            |   4 +
 drivers/net/ovpn/Makefile      |   3 +
 drivers/net/ovpn/crypto.c      | 152 +++++++++++++++++
 drivers/net/ovpn/crypto.h      | 139 ++++++++++++++++
 drivers/net/ovpn/crypto_aead.c | 366 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/crypto_aead.h |  31 ++++
 drivers/net/ovpn/io.c          | 148 +++++++++++++++--
 drivers/net/ovpn/io.h          |   3 +
 drivers/net/ovpn/peer.c        |  31 ++++
 drivers/net/ovpn/peer.h        |   6 +
 drivers/net/ovpn/pktid.c       | 129 +++++++++++++++
 drivers/net/ovpn/pktid.h       |  87 ++++++++++
 drivers/net/ovpn/proto.h       |  32 ++++
 drivers/net/ovpn/skb.h         |   4 +
 14 files changed, 1124 insertions(+), 11 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f4f985fc003373ddc14dc18f8b3f73295a3ae0a6..7d274ec48983f0ec460094ec81dc177c56f37ffe 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -120,6 +120,10 @@ config OVPN
 	depends on NET && INET
 	select DST_CACHE
 	select NET_UDP_TUNNEL
+	select CRYPTO
+	select CRYPTO_AES
+	select CRYPTO_GCM
+	select CRYPTO_CHACHA20POLY1305
 	help
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 56bddc9bef83e0befde6af3c3565bb91731d7b22..ccdaeced1982c851475657860a005ff2b9dfbd13 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,10 +8,13 @@
 
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += bind.o
+ovpn-y += crypto.o
+ovpn-y += crypto_aead.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
+ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
new file mode 100644
index 0000000000000000000000000000000000000000..fabc19994ba34260753911ac7d3e50b643b9b89f
--- /dev/null
+++ b/drivers/net/ovpn/crypto.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/types.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <uapi/linux/ovpn.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "pktid.h"
+#include "crypto_aead.h"
+#include "crypto.h"
+
+static void ovpn_ks_destroy_rcu(struct rcu_head *head)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
+	ovpn_aead_crypto_key_slot_destroy(ks);
+}
+
+void ovpn_crypto_key_slot_release(struct kref *kref)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
+	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
+}
+
+/* can only be invoked when all peer references have been dropped (i.e. RCU
+ * release routine)
+ */
+void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = rcu_access_pointer(cs->slots[0]);
+	if (ks) {
+		RCU_INIT_POINTER(cs->slots[0], NULL);
+		ovpn_crypto_key_slot_put(ks);
+	}
+
+	ks = rcu_access_pointer(cs->slots[1]);
+	if (ks) {
+		RCU_INIT_POINTER(cs->slots[1], NULL);
+		ovpn_crypto_key_slot_put(ks);
+	}
+}
+
+/* Reset the ovpn_crypto_state object in a way that is atomic
+ * to RCU readers.
+ */
+int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
+			    const struct ovpn_peer_key_reset *pkr)
+{
+	struct ovpn_crypto_key_slot *old = NULL, *new;
+	u8 idx;
+
+	if (pkr->slot != OVPN_KEY_SLOT_PRIMARY &&
+	    pkr->slot != OVPN_KEY_SLOT_SECONDARY)
+		return -EINVAL;
+
+	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	spin_lock_bh(&cs->lock);
+	idx = cs->primary_idx;
+	switch (pkr->slot) {
+	case OVPN_KEY_SLOT_PRIMARY:
+		old = rcu_replace_pointer(cs->slots[idx], new,
+					  lockdep_is_held(&cs->lock));
+		break;
+	case OVPN_KEY_SLOT_SECONDARY:
+		old = rcu_replace_pointer(cs->slots[!idx], new,
+					  lockdep_is_held(&cs->lock));
+		break;
+	}
+	spin_unlock_bh(&cs->lock);
+
+	if (old)
+		ovpn_crypto_key_slot_put(old);
+
+	return 0;
+}
+
+void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
+				 enum ovpn_key_slot slot)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+	u8 idx;
+
+	if (slot != OVPN_KEY_SLOT_PRIMARY &&
+	    slot != OVPN_KEY_SLOT_SECONDARY) {
+		pr_warn("Invalid slot to release: %u\n", slot);
+		return;
+	}
+
+	spin_lock_bh(&cs->lock);
+	idx = cs->primary_idx;
+	switch (slot) {
+	case OVPN_KEY_SLOT_PRIMARY:
+		ks = rcu_replace_pointer(cs->slots[idx], NULL,
+					 lockdep_is_held(&cs->lock));
+		break;
+	case OVPN_KEY_SLOT_SECONDARY:
+		ks = rcu_replace_pointer(cs->slots[!idx], NULL,
+					 lockdep_is_held(&cs->lock));
+		break;
+	}
+	spin_unlock_bh(&cs->lock);
+
+	if (!ks) {
+		pr_debug("Key slot already released: %u\n", slot);
+		return;
+	}
+
+	pr_debug("deleting key slot %u, key_id=%u\n", slot, ks->key_id);
+	ovpn_crypto_key_slot_put(ks);
+}
+
+/* this swap is not atomic, but there will be a very short time frame where the
+ * old_secondary key won't be available. This should not be a big deal as most
+ * likely both peers are already using the new primary at this point.
+ */
+void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
+{
+	const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
+	u8 idx;
+
+	spin_lock_bh(&cs->lock);
+	idx = cs->primary_idx;
+	old_primary = rcu_dereference_protected(cs->slots[idx],
+						lockdep_is_held(&cs->lock));
+	old_secondary = rcu_dereference_protected(cs->slots[!idx],
+						  lockdep_is_held(&cs->lock));
+	/* perform real swap by switching the index of the primary key */
+	cs->primary_idx = !cs->primary_idx;
+
+	pr_debug("key swapped: (old primary) %d <-> (new primary) %d\n",
+		 old_primary ? old_primary->key_id : -1,
+		 old_secondary ? old_secondary->key_id : -1);
+
+	spin_unlock_bh(&cs->lock);
+}
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
new file mode 100644
index 0000000000000000000000000000000000000000..b1b77c38ffe68dc21079e3a5354cc0695caa9cf3
--- /dev/null
+++ b/drivers/net/ovpn/crypto.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNCRYPTO_H_
+#define _NET_OVPN_OVPNCRYPTO_H_
+
+#include "pktid.h"
+#include "proto.h"
+
+/* info needed for both encrypt and decrypt directions */
+struct ovpn_key_direction {
+	const u8 *cipher_key;
+	size_t cipher_key_size;
+	const u8 *nonce_tail; /* only needed for GCM modes */
+	size_t nonce_tail_size; /* only needed for GCM modes */
+};
+
+/* all info for a particular symmetric key (primary or secondary) */
+struct ovpn_key_config {
+	enum ovpn_cipher_alg cipher_alg;
+	u8 key_id;
+	struct ovpn_key_direction encrypt;
+	struct ovpn_key_direction decrypt;
+};
+
+/* used to pass settings from netlink to the crypto engine */
+struct ovpn_peer_key_reset {
+	enum ovpn_key_slot slot;
+	struct ovpn_key_config key;
+};
+
+struct ovpn_crypto_key_slot {
+	u8 key_id;
+
+	struct crypto_aead *encrypt;
+	struct crypto_aead *decrypt;
+	u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
+	u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
+
+	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
+	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
+struct ovpn_crypto_state {
+	struct ovpn_crypto_key_slot __rcu *slots[2];
+	u8 primary_idx;
+
+	/* protects primary and secondary slots */
+	spinlock_t lock;
+};
+
+static inline bool ovpn_crypto_key_slot_hold(struct ovpn_crypto_key_slot *ks)
+{
+	return kref_get_unless_zero(&ks->refcount);
+}
+
+static inline void ovpn_crypto_state_init(struct ovpn_crypto_state *cs)
+{
+	RCU_INIT_POINTER(cs->slots[0], NULL);
+	RCU_INIT_POINTER(cs->slots[1], NULL);
+	cs->primary_idx = 0;
+	spin_lock_init(&cs->lock);
+}
+
+static inline struct ovpn_crypto_key_slot *
+ovpn_crypto_key_id_to_slot(const struct ovpn_crypto_state *cs, u8 key_id)
+{
+	struct ovpn_crypto_key_slot *ks;
+	u8 idx;
+
+	if (unlikely(!cs))
+		return NULL;
+
+	rcu_read_lock();
+	idx = cs->primary_idx;
+	ks = rcu_dereference(cs->slots[idx]);
+	if (ks && ks->key_id == key_id) {
+		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
+			ks = NULL;
+		goto out;
+	}
+
+	ks = rcu_dereference(cs->slots[idx ^ 1]);
+	if (ks && ks->key_id == key_id) {
+		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
+			ks = NULL;
+		goto out;
+	}
+
+	/* when both key slots are occupied but no matching key ID is found, ks
+	 * has to be reset to NULL to avoid carrying a stale pointer
+	 */
+	ks = NULL;
+out:
+	rcu_read_unlock();
+
+	return ks;
+}
+
+static inline struct ovpn_crypto_key_slot *
+ovpn_crypto_key_slot_primary(const struct ovpn_crypto_state *cs)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	rcu_read_lock();
+	ks = rcu_dereference(cs->slots[cs->primary_idx]);
+	if (unlikely(ks && !ovpn_crypto_key_slot_hold(ks)))
+		ks = NULL;
+	rcu_read_unlock();
+
+	return ks;
+}
+
+void ovpn_crypto_key_slot_release(struct kref *kref);
+
+static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
+{
+	kref_put(&ks->refcount, ovpn_crypto_key_slot_release);
+}
+
+int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
+			    const struct ovpn_peer_key_reset *pkr);
+
+void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
+				 enum ovpn_key_slot slot);
+
+void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
+
+void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
+
+#endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
new file mode 100644
index 0000000000000000000000000000000000000000..dade83aad09b2d79ad65152ce867a961aeec01bd
--- /dev/null
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <crypto/aead.h>
+#include <linux/skbuff.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "pktid.h"
+#include "crypto_aead.h"
+#include "crypto.h"
+#include "peer.h"
+#include "proto.h"
+#include "skb.h"
+
+#define AUTH_TAG_SIZE	16
+
+#define ALG_NAME_AES "gcm(aes)"
+#define ALG_NAME_CHACHAPOLY "rfc7539(chacha20,poly1305)"
+
+static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
+{
+	return  OVPN_OPCODE_SIZE +			/* OP header size */
+		sizeof(u32) +				/* Packet ID */
+		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
+}
+
+int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
+		      struct sk_buff *skb)
+{
+	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
+	struct aead_request *req;
+	struct sk_buff *trailer;
+	struct scatterlist *sg;
+	u8 iv[OVPN_NONCE_SIZE];
+	int nfrags, ret;
+	u32 pktid, op;
+
+	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_skb_cb(skb)->ks = ks;
+
+	/* Sample AEAD header format:
+	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
+	 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ... ]
+	 *          [4-byte
+	 *          IV head]
+	 */
+
+	/* check that there's enough headroom in the skb for packet
+	 * encapsulation
+	 */
+	if (unlikely(skb_cow_head(skb, OVPN_HEAD_ROOM)))
+		return -ENOBUFS;
+
+	/* get number of skb frags and ensure that packet data is writable */
+	nfrags = skb_cow_data(skb, 0, &trailer);
+	if (unlikely(nfrags < 0))
+		return nfrags;
+
+	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
+		return -ENOSPC;
+
+	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
+				       (nfrags + 2), GFP_ATOMIC);
+	if (unlikely(!ovpn_skb_cb(skb)->sg))
+		return -ENOMEM;
+
+	sg = ovpn_skb_cb(skb)->sg;
+
+	/* sg table:
+	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
+	 * 1, 2, 3, ..., n: payload,
+	 * n+1: auth_tag (len=tag_size)
+	 */
+	sg_init_table(sg, nfrags + 2);
+
+	/* build scatterlist to encrypt packet payload */
+	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
+	if (unlikely(nfrags != ret)) {
+		ret = -EINVAL;
+		goto free_sg;
+	}
+
+	/* append auth_tag onto scatterlist */
+	__skb_push(skb, tag_size);
+	sg_set_buf(sg + nfrags + 1, skb->data, tag_size);
+
+	/* obtain packet ID, which is used both as a first
+	 * 4 bytes of nonce and last 4 bytes of associated data.
+	 */
+	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
+	if (unlikely(ret < 0))
+		goto free_sg;
+
+	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
+	 * nonce
+	 */
+	ovpn_pktid_aead_write(pktid, ks->nonce_tail_xmit, iv);
+
+	/* make space for packet id and push it to the front */
+	__skb_push(skb, OVPN_NONCE_WIRE_SIZE);
+	memcpy(skb->data, iv, OVPN_NONCE_WIRE_SIZE);
+
+	/* add packet op as head of additional data */
+	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
+	__skb_push(skb, OVPN_OPCODE_SIZE);
+	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
+	*((__force __be32 *)skb->data) = htonl(op);
+
+	/* AEAD Additional data */
+	sg_set_buf(sg, skb->data, OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE);
+
+	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
+	if (unlikely(!req)) {
+		ret = -ENOMEM;
+		goto free_sg;
+	}
+
+	ovpn_skb_cb(skb)->req = req;
+
+	/* setup async crypto operation */
+	aead_request_set_tfm(req, ks->encrypt);
+	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
+	aead_request_set_crypt(req, sg, sg,
+			       skb->len - ovpn_aead_encap_overhead(ks), iv);
+	aead_request_set_ad(req, OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE);
+
+	/* encrypt it */
+	return crypto_aead_encrypt(req);
+free_sg:
+	kfree(ovpn_skb_cb(skb)->sg);
+	ovpn_skb_cb(skb)->sg = NULL;
+	return ret;
+}
+
+int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
+		      struct sk_buff *skb)
+{
+	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
+	int ret, payload_len, nfrags;
+	unsigned int payload_offset;
+	struct aead_request *req;
+	struct sk_buff *trailer;
+	struct scatterlist *sg;
+	u8 iv[OVPN_NONCE_SIZE];
+	unsigned int sg_len;
+
+	payload_offset = OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE + tag_size;
+	payload_len = skb->len - payload_offset;
+
+	ovpn_skb_cb(skb)->payload_offset = payload_offset;
+	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_skb_cb(skb)->ks = ks;
+
+	/* sanity check on packet size, payload size must be >= 0 */
+	if (unlikely(payload_len < 0))
+		return -EINVAL;
+
+	/* Prepare the skb data buffer to be accessed up until the auth tag.
+	 * This is required because this area is directly mapped into the sg
+	 * list.
+	 */
+	if (unlikely(!pskb_may_pull(skb, payload_offset)))
+		return -ENODATA;
+
+	/* get number of skb frags and ensure that packet data is writable */
+	nfrags = skb_cow_data(skb, 0, &trailer);
+	if (unlikely(nfrags < 0))
+		return nfrags;
+
+	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
+		return -ENOSPC;
+
+	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
+				       (nfrags + 2), GFP_ATOMIC);
+	if (unlikely(!ovpn_skb_cb(skb)->sg))
+		return -ENOMEM;
+
+	sg = ovpn_skb_cb(skb)->sg;
+
+	/* sg table:
+	 * 0: op, wire nonce (AD, len=OVPN_OPCODE_SIZE+OVPN_NONCE_WIRE_SIZE),
+	 * 1, 2, 3, ..., n: payload,
+	 * n+1: auth_tag (len=tag_size)
+	 */
+	sg_init_table(sg, nfrags + 2);
+
+	/* packet op is head of additional data */
+	sg_len = OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE;
+	sg_set_buf(sg, skb->data, sg_len);
+
+	/* build scatterlist to decrypt packet payload */
+	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
+	if (unlikely(nfrags != ret)) {
+		ret = -EINVAL;
+		goto free_sg;
+	}
+
+	/* append auth_tag onto scatterlist */
+	sg_set_buf(sg + nfrags + 1, skb->data + sg_len, tag_size);
+
+	/* copy nonce into IV buffer */
+	memcpy(iv, skb->data + OVPN_OPCODE_SIZE, OVPN_NONCE_WIRE_SIZE);
+	memcpy(iv + OVPN_NONCE_WIRE_SIZE, ks->nonce_tail_recv,
+	       OVPN_NONCE_TAIL_SIZE);
+
+	req = aead_request_alloc(ks->decrypt, GFP_ATOMIC);
+	if (unlikely(!req)) {
+		ret = -ENOMEM;
+		goto free_sg;
+	}
+
+	ovpn_skb_cb(skb)->req = req;
+
+	/* setup async crypto operation */
+	aead_request_set_tfm(req, ks->decrypt);
+	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
+	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
+
+	aead_request_set_ad(req, OVPN_NONCE_WIRE_SIZE + OVPN_OPCODE_SIZE);
+
+	/* decrypt it */
+	return crypto_aead_decrypt(req);
+free_sg:
+	kfree(ovpn_skb_cb(skb)->sg);
+	ovpn_skb_cb(skb)->sg = NULL;
+	return ret;
+}
+
+/* Initialize a struct crypto_aead object */
+struct crypto_aead *ovpn_aead_init(const char *title, const char *alg_name,
+				   const unsigned char *key,
+				   unsigned int keylen)
+{
+	struct crypto_aead *aead;
+	int ret;
+
+	aead = crypto_alloc_aead(alg_name, 0, 0);
+	if (IS_ERR(aead)) {
+		ret = PTR_ERR(aead);
+		pr_err("%s crypto_alloc_aead failed, err=%d\n", title, ret);
+		aead = NULL;
+		goto error;
+	}
+
+	ret = crypto_aead_setkey(aead, key, keylen);
+	if (ret) {
+		pr_err("%s crypto_aead_setkey size=%u failed, err=%d\n", title,
+		       keylen, ret);
+		goto error;
+	}
+
+	ret = crypto_aead_setauthsize(aead, AUTH_TAG_SIZE);
+	if (ret) {
+		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title,
+		       ret);
+		goto error;
+	}
+
+	/* basic AEAD assumption */
+	if (crypto_aead_ivsize(aead) != OVPN_NONCE_SIZE) {
+		pr_err("%s IV size must be %d\n", title, OVPN_NONCE_SIZE);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	pr_debug("********* Cipher %s (%s)\n", alg_name, title);
+	pr_debug("*** IV size=%u\n", crypto_aead_ivsize(aead));
+	pr_debug("*** req size=%u\n", crypto_aead_reqsize(aead));
+	pr_debug("*** block size=%u\n", crypto_aead_blocksize(aead));
+	pr_debug("*** auth size=%u\n", crypto_aead_authsize(aead));
+	pr_debug("*** alignmask=0x%x\n", crypto_aead_alignmask(aead));
+
+	return aead;
+
+error:
+	crypto_free_aead(aead);
+	return ERR_PTR(ret);
+}
+
+void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
+{
+	if (!ks)
+		return;
+
+	crypto_free_aead(ks->encrypt);
+	crypto_free_aead(ks->decrypt);
+	kfree(ks);
+}
+
+struct ovpn_crypto_key_slot *
+ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+	const char *alg_name;
+	int ret;
+
+	/* validate crypto alg */
+	switch (kc->cipher_alg) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+		alg_name = ALG_NAME_AES;
+		break;
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		alg_name = ALG_NAME_CHACHAPOLY;
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (kc->encrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE ||
+	    kc->decrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	/* build the key slot */
+	ks = kmalloc(sizeof(*ks), GFP_KERNEL);
+	if (!ks)
+		return ERR_PTR(-ENOMEM);
+
+	ks->encrypt = NULL;
+	ks->decrypt = NULL;
+	kref_init(&ks->refcount);
+	ks->key_id = kc->key_id;
+
+	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
+				     kc->encrypt.cipher_key,
+				     kc->encrypt.cipher_key_size);
+	if (IS_ERR(ks->encrypt)) {
+		ret = PTR_ERR(ks->encrypt);
+		ks->encrypt = NULL;
+		goto destroy_ks;
+	}
+
+	ks->decrypt = ovpn_aead_init("decrypt", alg_name,
+				     kc->decrypt.cipher_key,
+				     kc->decrypt.cipher_key_size);
+	if (IS_ERR(ks->decrypt)) {
+		ret = PTR_ERR(ks->decrypt);
+		ks->decrypt = NULL;
+		goto destroy_ks;
+	}
+
+	memcpy(ks->nonce_tail_xmit, kc->encrypt.nonce_tail,
+	       OVPN_NONCE_TAIL_SIZE);
+	memcpy(ks->nonce_tail_recv, kc->decrypt.nonce_tail,
+	       OVPN_NONCE_TAIL_SIZE);
+
+	/* init packet ID generation/validation */
+	ovpn_pktid_xmit_init(&ks->pid_xmit);
+	ovpn_pktid_recv_init(&ks->pid_recv);
+
+	return ks;
+
+destroy_ks:
+	ovpn_aead_crypto_key_slot_destroy(ks);
+	return ERR_PTR(ret);
+}
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
new file mode 100644
index 0000000000000000000000000000000000000000..77ee8141599bc06b0dc664c5b0a4dae660a89238
--- /dev/null
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNAEAD_H_
+#define _NET_OVPN_OVPNAEAD_H_
+
+#include "crypto.h"
+
+#include <asm/types.h>
+#include <linux/skbuff.h>
+
+struct crypto_aead *ovpn_aead_init(const char *title, const char *alg_name,
+				   const unsigned char *key,
+				   unsigned int keylen);
+
+int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
+		      struct sk_buff *skb);
+int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
+		      struct sk_buff *skb);
+
+struct ovpn_crypto_key_slot *
+ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
+void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
+
+#endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 1bbbaae8639477b67626731c3bd14810a65dfdcd..ffea3f22dd181381d990c7290adb8a1b3e96f46a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -7,6 +7,7 @@
  *		Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include <crypto/aead.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
@@ -15,6 +16,9 @@
 #include "ovpnstruct.h"
 #include "peer.h"
 #include "io.h"
+#include "bind.h"
+#include "crypto.h"
+#include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
 #include "udp.h"
@@ -44,7 +48,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	skb_set_queue_mapping(skb, 0);
 	skb_scrub_packet(skb, true);
 
-	skb_reset_network_header(skb);
+	/* network header reset in ovpn_decrypt_post() */
 	skb_reset_transport_header(skb);
 	skb_probe_transport_header(skb);
 	skb_reset_inner_headers(skb);
@@ -57,33 +61,139 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
 }
 
-static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
+void ovpn_decrypt_post(void *data, int ret)
 {
-	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+	struct ovpn_crypto_key_slot *ks;
+	unsigned int payload_offset = 0;
+	struct sk_buff *skb = data;
+	struct ovpn_peer *peer;
+	__be16 proto;
+	__be32 *pid;
+
+	/* crypto is happening asynchronously. this function will be called
+	 * again later by the crypto callback with a proper return code
+	 */
+	if (unlikely(ret == -EINPROGRESS))
+		return;
+
+	payload_offset = ovpn_skb_cb(skb)->payload_offset;
+	ks = ovpn_skb_cb(skb)->ks;
+	peer = ovpn_skb_cb(skb)->peer;
+
+	/* crypto is done, cleanup skb CB and its members */
+
+	if (likely(ovpn_skb_cb(skb)->sg))
+		kfree(ovpn_skb_cb(skb)->sg);
+
+	if (likely(ovpn_skb_cb(skb)->req))
+		aead_request_free(ovpn_skb_cb(skb)->req);
 
 	if (unlikely(ret < 0))
 		goto drop;
 
+	/* PID sits after the op */
+	pid = (__force __be32 *)(skb->data + OVPN_OPCODE_SIZE);
+	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
+				    netdev_name(peer->ovpn->dev), peer->id,
+				    ret);
+		goto drop;
+	}
+
+	/* point to encapsulated IP packet */
+	__skb_pull(skb, payload_offset);
+
+	/* check if this is a valid datapacket that has to be delivered to the
+	 * ovpn interface
+	 */
+	skb_reset_network_header(skb);
+	proto = ovpn_ip_check_protocol(skb);
+	if (unlikely(!proto)) {
+		/* check if null packet */
+		if (unlikely(!pskb_may_pull(skb, 1))) {
+			net_info_ratelimited("%s: NULL packet received from peer %u\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id);
+			goto drop;
+		}
+
+		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		goto drop;
+	}
+	skb->protocol = proto;
+
+	/* perform Reverse Path Filtering (RPF) */
+	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
+		if (skb->protocol == htons(ETH_P_IPV6))
+			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &ipv6_hdr(skb)->saddr);
+		else
+			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &ip_hdr(skb)->saddr);
+		goto drop;
+	}
+
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
 drop:
 	if (unlikely(skb))
 		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
-	ovpn_peer_put(peer);
+	if (likely(peer))
+		ovpn_peer_put(peer);
+	if (likely(ks))
+		ovpn_crypto_key_slot_put(ks);
 	kfree_skb(skb);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	ovpn_skb_cb(skb)->peer = peer;
-	ovpn_decrypt_post(skb, 0);
+	struct ovpn_crypto_key_slot *ks;
+	u8 key_id;
+
+	/* get the key slot matching the key ID in the received packet */
+	key_id = ovpn_key_id_from_skb(skb);
+	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
+	if (unlikely(!ks)) {
+		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id,
+				     key_id);
+		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
+	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
+	ovpn_decrypt_post(skb, ovpn_aead_decrypt(peer, ks, skb));
 }
 
-static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
+void ovpn_encrypt_post(void *data, int ret)
 {
-	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+	struct ovpn_crypto_key_slot *ks;
+	struct sk_buff *skb = data;
+	struct ovpn_peer *peer;
+
+	/* encryption is happening asynchronously. This function will be
+	 * called later by the crypto callback with a proper return value
+	 */
+	if (unlikely(ret == -EINPROGRESS))
+		return;
+
+	ks = ovpn_skb_cb(skb)->ks;
+	peer = ovpn_skb_cb(skb)->peer;
+
+	/* crypto is done, cleanup skb CB and its members */
+
+	if (likely(ovpn_skb_cb(skb)->sg))
+		kfree(ovpn_skb_cb(skb)->sg);
+
+	if (likely(ovpn_skb_cb(skb)->req))
+		aead_request_free(ovpn_skb_cb(skb)->req);
 
 	if (unlikely(ret < 0))
 		goto err;
@@ -103,13 +213,28 @@ static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 err:
 	if (unlikely(skb))
 		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
-	ovpn_peer_put(peer);
+	if (likely(peer))
+		ovpn_peer_put(peer);
+	if (likely(ks))
+		ovpn_crypto_key_slot_put(ks);
 	kfree_skb(skb);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	ovpn_skb_cb(skb)->peer = peer;
+	struct ovpn_crypto_key_slot *ks;
+
+	if (unlikely(skb->ip_summed == CHECKSUM_PARTIAL &&
+		     skb_checksum_help(skb))) {
+		net_warn_ratelimited("%s: cannot compute checksum for outgoing packet for peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		return false;
+	}
+
+	/* get primary key to be used for encrypting data */
+	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
+	if (unlikely(!ks))
+		return false;
 
 	/* take a reference to the peer because the crypto code may run async.
 	 * ovpn_encrypt_post() will release it upon completion
@@ -119,7 +244,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		return false;
 	}
 
-	ovpn_encrypt_post(skb, 0);
+	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
+	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
 	return true;
 }
 
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index b3830b787e16f3bdcaaff94e5bbe89be3e1006fe..5f9c7eba37b132bcf8c0ebad60af9171e46bf3e8 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -23,4 +23,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
 
+void ovpn_encrypt_post(void *data, int ret);
+void ovpn_decrypt_post(void *data, int ret);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 5bc6854ce701c084982c5b3b6a0c536e828a77bd..235850e2129c1aea0e6fb3a14519edb675590349 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -12,6 +12,8 @@
 
 #include "ovpnstruct.h"
 #include "bind.h"
+#include "pktid.h"
+#include "crypto.h"
 #include "io.h"
 #include "main.h"
 #include "netlink.h"
@@ -42,6 +44,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	peer->vpn_addrs.ipv6 = in6addr_any;
 
 	RCU_INIT_POINTER(peer->bind, NULL);
+	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
 
@@ -80,7 +83,10 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
  */
 static void ovpn_peer_release(struct ovpn_peer *peer)
 {
+	ovpn_crypto_state_release(&peer->crypto);
+	spin_lock_bh(&peer->lock);
 	ovpn_bind_reset(peer, NULL);
+	spin_unlock_bh(&peer->lock);
 	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
@@ -286,6 +292,31 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 	return peer;
 }
 
+/**
+ * ovpn_peer_check_by_src - check that skb source is routed via peer
+ * @ovpn: the openvpn instance to search
+ * @skb: the packet to extract source address from
+ * @peer: the peer to check against the source address
+ *
+ * Return: true if the peer is matching or false otherwise
+ */
+bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
+			    struct ovpn_peer *peer)
+{
+	bool match = false;
+
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		/* in P2P mode, no matter the destination, packets are always
+		 * sent to the single peer listening on the other side
+		 */
+		rcu_read_lock();
+		match = (peer == rcu_dereference(ovpn->peer));
+		rcu_read_unlock();
+	}
+
+	return match;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 24de7a69e371a521bed48a8ef3116350ea3e9560..1b427870df2cf972e0f572e046452378358f245a 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -12,6 +12,8 @@
 
 #include <net/dst_cache.h>
 
+#include "crypto.h"
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
@@ -20,6 +22,7 @@
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
  * @sock: the socket being used to talk to this peer
+ * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
@@ -36,6 +39,7 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 	struct ovpn_socket *sock;
+	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	enum ovpn_del_peer_reason delete_reason;
@@ -78,5 +82,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
+bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
+			    struct ovpn_peer *peer);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
new file mode 100644
index 0000000000000000000000000000000000000000..0707a0489863d710fee05915007e4747f5bb4fa5
--- /dev/null
+++ b/drivers/net/ovpn/pktid.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#include <linux/atomic.h>
+#include <linux/jiffies.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "pktid.h"
+
+void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid)
+{
+	atomic64_set(&pid->seq_num, 1);
+}
+
+void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr)
+{
+	memset(pr, 0, sizeof(*pr));
+	spin_lock_init(&pr->lock);
+}
+
+/* Packet replay detection.
+ * Allows ID backtrack of up to REPLAY_WINDOW_SIZE - 1.
+ */
+int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
+{
+	const unsigned long now = jiffies;
+	int ret;
+
+	/* ID must not be zero */
+	if (unlikely(pkt_id == 0))
+		return -EINVAL;
+
+	spin_lock_bh(&pr->lock);
+
+	/* expire backtracks at or below pr->id after PKTID_RECV_EXPIRE time */
+	if (unlikely(time_after_eq(now, pr->expire)))
+		pr->id_floor = pr->id;
+
+	/* time changed? */
+	if (unlikely(pkt_time != pr->time)) {
+		if (pkt_time > pr->time) {
+			/* time moved forward, accept */
+			pr->base = 0;
+			pr->extent = 0;
+			pr->id = 0;
+			pr->time = pkt_time;
+			pr->id_floor = 0;
+		} else {
+			/* time moved backward, reject */
+			ret = -ETIME;
+			goto out;
+		}
+	}
+
+	if (likely(pkt_id == pr->id + 1)) {
+		/* well-formed ID sequence (incremented by 1) */
+		pr->base = REPLAY_INDEX(pr->base, -1);
+		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+		if (pr->extent < REPLAY_WINDOW_SIZE)
+			++pr->extent;
+		pr->id = pkt_id;
+	} else if (pkt_id > pr->id) {
+		/* ID jumped forward by more than one */
+		const unsigned int delta = pkt_id - pr->id;
+
+		if (delta < REPLAY_WINDOW_SIZE) {
+			unsigned int i;
+
+			pr->base = REPLAY_INDEX(pr->base, -delta);
+			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+			pr->extent += delta;
+			if (pr->extent > REPLAY_WINDOW_SIZE)
+				pr->extent = REPLAY_WINDOW_SIZE;
+			for (i = 1; i < delta; ++i) {
+				unsigned int newb = REPLAY_INDEX(pr->base, i);
+
+				pr->history[newb / 8] &= ~BIT(newb % 8);
+			}
+		} else {
+			pr->base = 0;
+			pr->extent = REPLAY_WINDOW_SIZE;
+			memset(pr->history, 0, sizeof(pr->history));
+			pr->history[0] = 1;
+		}
+		pr->id = pkt_id;
+	} else {
+		/* ID backtrack */
+		const unsigned int delta = pr->id - pkt_id;
+
+		if (delta > pr->max_backtrack)
+			pr->max_backtrack = delta;
+		if (delta < pr->extent) {
+			if (pkt_id > pr->id_floor) {
+				const unsigned int ri = REPLAY_INDEX(pr->base,
+								     delta);
+				u8 *p = &pr->history[ri / 8];
+				const u8 mask = (1 << (ri % 8));
+
+				if (*p & mask) {
+					ret = -EINVAL;
+					goto out;
+				}
+				*p |= mask;
+			} else {
+				ret = -EINVAL;
+				goto out;
+			}
+		} else {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	pr->expire = now + PKTID_RECV_EXPIRE;
+	ret = 0;
+out:
+	spin_unlock_bh(&pr->lock);
+	return ret;
+}
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
new file mode 100644
index 0000000000000000000000000000000000000000..ab38c59b6174074b8deb23e3e9ce47e96016ba94
--- /dev/null
+++ b/drivers/net/ovpn/pktid.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNPKTID_H_
+#define _NET_OVPN_OVPNPKTID_H_
+
+#include "proto.h"
+
+/* If no packets received for this length of time, set a backtrack floor
+ * at highest received packet ID thus far.
+ */
+#define PKTID_RECV_EXPIRE (30 * HZ)
+
+/* Packet-ID state for transmitter */
+struct ovpn_pktid_xmit {
+	atomic64_t seq_num;
+};
+
+/* replay window sizing in bytes = 2^REPLAY_WINDOW_ORDER */
+#define REPLAY_WINDOW_ORDER 8
+
+#define REPLAY_WINDOW_BYTES BIT(REPLAY_WINDOW_ORDER)
+#define REPLAY_WINDOW_SIZE  (REPLAY_WINDOW_BYTES * 8)
+#define REPLAY_INDEX(base, i) (((base) + (i)) & (REPLAY_WINDOW_SIZE - 1))
+
+/* Packet-ID state for receiver.
+ * Other than lock member, can be zeroed to initialize.
+ */
+struct ovpn_pktid_recv {
+	/* "sliding window" bitmask of recent packet IDs received */
+	u8 history[REPLAY_WINDOW_BYTES];
+	/* bit position of deque base in history */
+	unsigned int base;
+	/* extent (in bits) of deque in history */
+	unsigned int extent;
+	/* expiration of history in jiffies */
+	unsigned long expire;
+	/* highest sequence number received */
+	u32 id;
+	/* highest time stamp received */
+	u32 time;
+	/* we will only accept backtrack IDs > id_floor */
+	u32 id_floor;
+	unsigned int max_backtrack;
+	/* protects entire pktd ID state */
+	spinlock_t lock;
+};
+
+/* Get the next packet ID for xmit */
+static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
+{
+	const s64 seq_num = atomic64_fetch_add_unless(&pid->seq_num, 1,
+						      0x100000000LL);
+	/* when the 32bit space is over, we return an error because the packet
+	 * ID is used to create the cipher IV and we do not want to reuse the
+	 * same value more than once
+	 */
+	if (unlikely(seq_num == 0x100000000LL))
+		return -ERANGE;
+
+	*pktid = (u32)seq_num;
+
+	return 0;
+}
+
+/* Write 12-byte AEAD IV to dest */
+static inline void ovpn_pktid_aead_write(const u32 pktid,
+					 const u8 nt[],
+					 unsigned char *dest)
+{
+	*(__force __be32 *)(dest) = htonl(pktid);
+	BUILD_BUG_ON(4 + OVPN_NONCE_TAIL_SIZE != OVPN_NONCE_SIZE);
+	memcpy(dest + 4, nt, OVPN_NONCE_TAIL_SIZE);
+}
+
+void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid);
+void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr);
+
+int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time);
+
+#endif /* _NET_OVPN_OVPNPKTID_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index 34a812869b2e92e8bab0ebb87d46b67c3bbccf9f..9809e6cf752db4722659d201d58f221d83def2b8 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -83,4 +83,36 @@ static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
 	return FIELD_GET(OVPN_OPCODE_PEERID_MASK, opcode);
 }
 
+/**
+ * ovpn_key_id_from_skb - extract key ID from the skb head
+ * @skb: the packet to extract the key ID code from
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first byte.
+ *
+ * Return: the key ID
+ */
+static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
+{
+	u32 opcode = be32_to_cpu(*(__be32 *)skb->data);
+
+	return FIELD_GET(OVPN_OPCODE_KEYID_MASK, opcode);
+}
+
+/**
+ * ovpn_opcode_compose - combine OP code, key ID and peer ID to wire format
+ * @opcode: the OP code
+ * @key_id: the key ID
+ * @peer_id: the peer ID
+ *
+ * Return: a 4 bytes integer obtained combining all input values following the
+ * OpenVPN wire format. This integer can then be written to the packet header.
+ */
+static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
+{
+	return FIELD_PREP(OVPN_OPCODE_PKTTYPE_MASK, opcode) |
+	       FIELD_PREP(OVPN_OPCODE_KEYID_MASK, key_id) |
+	       FIELD_PREP(OVPN_OPCODE_PEERID_MASK, peer_id);
+}
+
 #endif /* _NET_OVPN_OVPNPROTO_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 392bb3f77262efa580231d2eada2aa2f399a71f8..e7c9c5afd083ad33780ea2e4a41dacd6ffe9d3e4 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -19,6 +19,10 @@
 
 struct ovpn_cb {
 	struct ovpn_peer *peer;
+	struct ovpn_crypto_key_slot *ks;
+	struct aead_request *req;
+	struct scatterlist *sg;
+	unsigned int payload_offset;
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)

-- 
2.45.2


