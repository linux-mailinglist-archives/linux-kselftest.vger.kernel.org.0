Return-Path: <linux-kselftest+bounces-29730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F17A6E840
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 03:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A71173570
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 02:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759415C140;
	Tue, 25 Mar 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvl9VMiJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D357DA73;
	Tue, 25 Mar 2025 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868492; cv=none; b=pbz2FR1/fVtPSqTVu0iIt6A8eZJRCja9H2TXU/g92NLVQllWN6U9/aRmhuskZJzOw18i9XsnieU9U2yGvU8bPiDMGmhJgiG72nLFnUAgOAgxkcCtPPYNnVpYQTROp+n/Jn1Zl6JFW4JVnD5/LWMnzOjsFt1eYLz5IJp36o6VFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868492; c=relaxed/simple;
	bh=OnblN3QABPTZaJ1YhN9YSCVzSVNpwxCF+uORyPU+Nds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwOGw1zV7xS6W3qqTOd88jSn7DyHfVEQXW84ApYERfx8fQTqDAhoRoZVsjeazjeayWB5D4pvidvTLqTifbWKG8uBHBwyjQOfsl5vaEou9it333IX7DmUSECNkYLGukkc6/apdn9bAA3C/HxiQJwq4YQO/vfGBjTICgNEmoWU5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvl9VMiJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22398e09e39so101977495ad.3;
        Mon, 24 Mar 2025 19:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742868489; x=1743473289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ex1tfv4m3FqL4LAb4Y//wasgWoEqszry1gvIWtr9M0=;
        b=fvl9VMiJThay9U6NYkAhf9n9Zbr05AiMKPAUQAH2mY6A5YWsqgMjd8/LWwcppOrTbh
         R5vhBOJ0WTzZSSA6vAj+hpZD1WizqPLPqAtn1rTsnTdedwWoNBzUnR/F5YuVdbj7tcKp
         YSsOCRFmZx0MK0zWg0i5N2moMDl88/LWgcNhVbR276S5fmp67m4FPMb2l8ydl9HeVbKe
         3XR8TOsAtL0NLHjdINhcOZ6cELxaVt0IyZOMvhukNQHRj9S8AVPrbIr9NR2dbxJT3dZ9
         93HzpX1RZp3HRTN5wd9q5MWwUKssHk+6JMypeCyBLepS7T8gNllDrbV+btb2LBHQHImb
         kFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742868489; x=1743473289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ex1tfv4m3FqL4LAb4Y//wasgWoEqszry1gvIWtr9M0=;
        b=h/Bg4Kpvu8wqEUvBI6GZlZm8VJab0ML64tGdxGNwg3rmeExSpR8ov8TyFlQOeIW/91
         wmWmx/23jQunxB7HC+CWk2YKjaCGfkffYL6AGuYwl22KNcbhvEOPj7pRE0hIkpo2osuU
         Z65/TePiYDa7l8cm/9L1O0zMrD2ku0Sq/LgTXkmcvCnG4XxXf76FNP0Y/5E7JNfsn5r8
         bllZHLhW52KA1Sa4vkb/NokF8A9EzerqYTPEJV0W/SxtMUQcwibgzQ4KNW+Rk319hVOc
         T5MY0vtfxsjmMp8DpJz3CL/3m/a3UL7pWbUW0He/2AEgzf50bjSd7uy8mWFmyoLeK00g
         NKig==
X-Forwarded-Encrypted: i=1; AJvYcCUALexE6B516C/vQqYw5vwuxLG5EPqXpgIYAVuV/pTgbdzxBI3NgUiW2JkdnCZ6Gvsar+BKCdPbCovdu1A=@vger.kernel.org, AJvYcCV94rUJVPLLLVygGt7K3ijcPUpRhA8VgBZUMyu6QDSMVB6bv1vom2feMhRwO993LBEqfAGbRxU7sz1/uc5l4PWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cAWNJ0q2X8NsxAXoQ6/2lANCrZGbJDdbGe5L50+u8RoTs9iF
	Pjt2NmCGEVIfC+fVKsbwoay+9a8oTav3A02VS3k6iTPDXgjQ+KZ/xyMKFM8+WF0=
X-Gm-Gg: ASbGncuasV8R19cTcj7fxkL5QF4t+xFs5PUfFou8VeEFtBe0AiFHKbuM51le4wWoZHm
	M9z74roARPBBBwAtT6AX2GBRXt2j9/I2iWgW88MKdyYSV9Nn5tm1LH938WqAcCSseB6axMMFBHV
	xhvg8exS9tRT/39xNRcRDZuqWOhnoysSFjtx2yYMdbxTS9UD8LrdKgy9tnwF+8E9W70Sj9iLVlX
	UaGtOx3zBCEwMSEtCeNAlSrCCyp0TSopU717YZMhuTz5FJsDZpXV0N9m+FwAjnTMBUi5gDjrZEY
	kWW7W9+HMg8+n4bzIU1COrI6oJqEo4Rs3XOqAg==
X-Google-Smtp-Source: AGHT+IHEGKhUYBnPYRKGPVH7gxu5Naj6+KVAlEwFABcJwJRLn3ooKXu8GQhIPOBcB41I8HOUj9W4Uw==
X-Received: by 2002:a05:6a20:e196:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-1fe430100e3mr26634562637.29.1742868488711;
        Mon, 24 Mar 2025 19:08:08 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d1f1sm9107987b3a.98.2025.03.24.19.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 19:08:08 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Shuah Khan <shuah@kernel.org>,
	sd@queasysnail.net,
	ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
Date: Tue, 25 Mar 2025 10:07:54 +0800
Message-ID: <20250325020802.7632-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Antonio,

On Tue, 18 Mar 2025 02:40:44 +0100, Antonio Quartulli wrote:
> 
> This change implements encryption/decryption and
> encapsulation/decapsulation of OpenVPN packets.
> 
> Support for generic crypto state is added along with
> a wrapper for the AEAD crypto kernel API.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/Kconfig            |   4 +
>  drivers/net/ovpn/Makefile      |   3 +
>  drivers/net/ovpn/bind.c        |   9 +-
>  drivers/net/ovpn/crypto.c      | 152 ++++++++++++++++
>  drivers/net/ovpn/crypto.h      | 139 +++++++++++++++
>  drivers/net/ovpn/crypto_aead.c | 392 +++++++++++++++++++++++++++++++++++++++++
>  drivers/net/ovpn/crypto_aead.h |  27 +++
>  drivers/net/ovpn/io.c          | 149 ++++++++++++++--
>  drivers/net/ovpn/io.h          |   3 +
>  drivers/net/ovpn/peer.c        |  29 +++
>  drivers/net/ovpn/peer.h        |   5 +
>  drivers/net/ovpn/pktid.c       | 129 ++++++++++++++
>  drivers/net/ovpn/pktid.h       |  87 +++++++++
>  drivers/net/ovpn/proto.h       |  32 ++++
>  drivers/net/ovpn/skb.h         |   5 +
>  15 files changed, 1148 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index b18ff941944e2e92aa769d1ebbc3d1782611fc06..51d77f3c0848c3c9425b586c6a90cff99a744390 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -121,6 +121,10 @@ config OVPN
>  	depends on IPV6 || !IPV6
>  	select DST_CACHE
>  	select NET_UDP_TUNNEL
> +	select CRYPTO
> +	select CRYPTO_AES
> +	select CRYPTO_GCM
> +	select CRYPTO_CHACHA20POLY1305
>  	help
>  	  This module enhances the performance of the OpenVPN userspace software
>  	  by offloading the data channel processing to kernelspace.
> diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
> index 164f2058ea8e6dc5b9287afb59758a268b2f8b56..38c9fdca0e2e8e4af3c369ceb3971b58ab52d77b 100644
> --- a/drivers/net/ovpn/Makefile
> +++ b/drivers/net/ovpn/Makefile
> @@ -8,10 +8,13 @@
>  
>  obj-$(CONFIG_OVPN) := ovpn.o
>  ovpn-y += bind.o
> +ovpn-y += crypto.o
> +ovpn-y += crypto_aead.o
>  ovpn-y += main.o
>  ovpn-y += io.o
>  ovpn-y += netlink.o
>  ovpn-y += netlink-gen.o
>  ovpn-y += peer.o
> +ovpn-y += pktid.o
>  ovpn-y += socket.o
>  ovpn-y += udp.o
> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
> index d4a1aeed12c99c71eaf5e8e9fc9c0fe61af6aaac..24d2788a277e674bde80b5aac9407c6528b108e5 100644
> --- a/drivers/net/ovpn/bind.c
> +++ b/drivers/net/ovpn/bind.c
> @@ -48,11 +48,8 @@ struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
>   */
>  void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
>  {
> -	struct ovpn_bind *old;
> +	lockdep_assert_held(&peer->lock);
>  
> -	spin_lock_bh(&peer->lock);
> -	old = rcu_replace_pointer(peer->bind, new, true);
> -	spin_unlock_bh(&peer->lock);
> -
> -	kfree_rcu(old, rcu);
> +	kfree_rcu(rcu_replace_pointer(peer->bind, new,
> +				      lockdep_is_held(&peer->lock)), rcu);
>  }
> diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..db243cb48142f4a20aaf7a29eadda1b19ea344a7
> --- /dev/null
> +++ b/drivers/net/ovpn/crypto.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
> +#include <uapi/linux/ovpn.h>
> +
> +#include "ovpnpriv.h"
> +#include "main.h"
> +#include "pktid.h"
> +#include "crypto_aead.h"
> +#include "crypto.h"
> +
> +static void ovpn_ks_destroy_rcu(struct rcu_head *head)
> +{
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
> +	ovpn_aead_crypto_key_slot_destroy(ks);
> +}
> +
> +void ovpn_crypto_key_slot_release(struct kref *kref)
> +{
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
> +	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
> +}
> +
> +/* can only be invoked when all peer references have been dropped (i.e. RCU
> + * release routine)
> + */
> +void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
> +{
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	ks = rcu_access_pointer(cs->slots[0]);
> +	if (ks) {
> +		RCU_INIT_POINTER(cs->slots[0], NULL);
> +		ovpn_crypto_key_slot_put(ks);
> +	}
> +
> +	ks = rcu_access_pointer(cs->slots[1]);
> +	if (ks) {
> +		RCU_INIT_POINTER(cs->slots[1], NULL);
> +		ovpn_crypto_key_slot_put(ks);
> +	}
> +}
> +
> +/* Reset the ovpn_crypto_state object in a way that is atomic
> + * to RCU readers.
> + */
> +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
> +			    const struct ovpn_peer_key_reset *pkr)
> +{
> +	struct ovpn_crypto_key_slot *old = NULL, *new;
> +	u8 idx;
> +
> +	if (pkr->slot != OVPN_KEY_SLOT_PRIMARY &&
> +	    pkr->slot != OVPN_KEY_SLOT_SECONDARY)
> +		return -EINVAL;
> +
> +	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +
> +	spin_lock_bh(&cs->lock);
> +	idx = cs->primary_idx;
> +	switch (pkr->slot) {
> +	case OVPN_KEY_SLOT_PRIMARY:
> +		old = rcu_replace_pointer(cs->slots[idx], new,
> +					  lockdep_is_held(&cs->lock));
> +		break;
> +	case OVPN_KEY_SLOT_SECONDARY:
> +		old = rcu_replace_pointer(cs->slots[!idx], new,
> +					  lockdep_is_held(&cs->lock));
> +		break;
> +	}
> +	spin_unlock_bh(&cs->lock);
> +
> +	if (old)
> +		ovpn_crypto_key_slot_put(old);
> +
> +	return 0;
> +}
> +
> +void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
> +				 enum ovpn_key_slot slot)
> +{
> +	struct ovpn_crypto_key_slot *ks = NULL;
> +	u8 idx;
> +
> +	if (slot != OVPN_KEY_SLOT_PRIMARY &&
> +	    slot != OVPN_KEY_SLOT_SECONDARY) {
> +		pr_warn("Invalid slot to release: %u\n", slot);
> +		return;
> +	}
> +
> +	spin_lock_bh(&cs->lock);
> +	idx = cs->primary_idx;
> +	switch (slot) {
> +	case OVPN_KEY_SLOT_PRIMARY:
> +		ks = rcu_replace_pointer(cs->slots[idx], NULL,
> +					 lockdep_is_held(&cs->lock));
> +		break;
> +	case OVPN_KEY_SLOT_SECONDARY:
> +		ks = rcu_replace_pointer(cs->slots[!idx], NULL,
> +					 lockdep_is_held(&cs->lock));
> +		break;
> +	}
> +	spin_unlock_bh(&cs->lock);
> +
> +	if (!ks) {
> +		pr_debug("Key slot already released: %u\n", slot);
> +		return;
> +	}
> +
> +	pr_debug("deleting key slot %u, key_id=%u\n", slot, ks->key_id);
> +	ovpn_crypto_key_slot_put(ks);
> +}
> +
> +/* this swap is not atomic, but there will be a very short time frame where the
> + * old_secondary key won't be available. This should not be a big deal as most
> + * likely both peers are already using the new primary at this point.
> + */
> +void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
> +{
> +	const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
> +	u8 idx;
> +
> +	spin_lock_bh(&cs->lock);
> +	idx = cs->primary_idx;
> +	old_primary = rcu_dereference_protected(cs->slots[idx],
> +						lockdep_is_held(&cs->lock));
> +	old_secondary = rcu_dereference_protected(cs->slots[!idx],
> +						  lockdep_is_held(&cs->lock));
> +	/* perform real swap by switching the index of the primary key */
> +	WRITE_ONCE(cs->primary_idx, !cs->primary_idx);
> +
> +	pr_debug("key swapped: (old primary) %d <-> (new primary) %d\n",
> +		 old_primary ? old_primary->key_id : -1,
> +		 old_secondary ? old_secondary->key_id : -1);
> +
> +	spin_unlock_bh(&cs->lock);
> +}
> diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5155791b87df7cccc76a011fa751686180074982
> --- /dev/null
> +++ b/drivers/net/ovpn/crypto.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNCRYPTO_H_
> +#define _NET_OVPN_OVPNCRYPTO_H_
> +
> +#include "pktid.h"
> +#include "proto.h"
> +
> +/* info needed for both encrypt and decrypt directions */
> +struct ovpn_key_direction {
> +	const u8 *cipher_key;
> +	size_t cipher_key_size;
> +	const u8 *nonce_tail; /* only needed for GCM modes */
> +	size_t nonce_tail_size; /* only needed for GCM modes */
> +};
> +
> +/* all info for a particular symmetric key (primary or secondary) */
> +struct ovpn_key_config {
> +	enum ovpn_cipher_alg cipher_alg;
> +	u8 key_id;
> +	struct ovpn_key_direction encrypt;
> +	struct ovpn_key_direction decrypt;
> +};
> +
> +/* used to pass settings from netlink to the crypto engine */
> +struct ovpn_peer_key_reset {
> +	enum ovpn_key_slot slot;
> +	struct ovpn_key_config key;
> +};
> +
> +struct ovpn_crypto_key_slot {
> +	u8 key_id;
> +
> +	struct crypto_aead *encrypt;
> +	struct crypto_aead *decrypt;
> +	u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
> +	u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
> +
> +	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
> +	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
> +	struct kref refcount;
> +	struct rcu_head rcu;
> +};
> +
> +struct ovpn_crypto_state {
> +	struct ovpn_crypto_key_slot __rcu *slots[2];
> +	u8 primary_idx;
> +
> +	/* protects primary and secondary slots */
> +	spinlock_t lock;
> +};
> +
> +static inline bool ovpn_crypto_key_slot_hold(struct ovpn_crypto_key_slot *ks)
> +{
> +	return kref_get_unless_zero(&ks->refcount);
> +}
> +
> +static inline void ovpn_crypto_state_init(struct ovpn_crypto_state *cs)
> +{
> +	RCU_INIT_POINTER(cs->slots[0], NULL);
> +	RCU_INIT_POINTER(cs->slots[1], NULL);
> +	cs->primary_idx = 0;
> +	spin_lock_init(&cs->lock);
> +}
> +
> +static inline struct ovpn_crypto_key_slot *
> +ovpn_crypto_key_id_to_slot(const struct ovpn_crypto_state *cs, u8 key_id)
> +{
> +	struct ovpn_crypto_key_slot *ks;
> +	u8 idx;
> +
> +	if (unlikely(!cs))
> +		return NULL;
> +
> +	rcu_read_lock();
> +	idx = READ_ONCE(cs->primary_idx);
> +	ks = rcu_dereference(cs->slots[idx]);
> +	if (ks && ks->key_id == key_id) {
> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
> +			ks = NULL;
> +		goto out;
> +	}
> +
> +	ks = rcu_dereference(cs->slots[!idx]);
> +	if (ks && ks->key_id == key_id) {
> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
> +			ks = NULL;
> +		goto out;
> +	}
> +
> +	/* when both key slots are occupied but no matching key ID is found, ks
> +	 * has to be reset to NULL to avoid carrying a stale pointer
> +	 */
> +	ks = NULL;
> +out:
> +	rcu_read_unlock();
> +
> +	return ks;
> +}
> +
> +static inline struct ovpn_crypto_key_slot *
> +ovpn_crypto_key_slot_primary(const struct ovpn_crypto_state *cs)
> +{
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	rcu_read_lock();
> +	ks = rcu_dereference(cs->slots[cs->primary_idx]);
> +	if (unlikely(ks && !ovpn_crypto_key_slot_hold(ks)))
> +		ks = NULL;
> +	rcu_read_unlock();
> +
> +	return ks;
> +}
> +
> +void ovpn_crypto_key_slot_release(struct kref *kref);
> +
> +static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
> +{
> +	kref_put(&ks->refcount, ovpn_crypto_key_slot_release);
> +}
> +
> +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
> +			    const struct ovpn_peer_key_reset *pkr);
> +
> +void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
> +				 enum ovpn_key_slot slot);
> +
> +void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
> +
> +void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
> +
> +#endif /* _NET_OVPN_OVPNCRYPTO_H_ */
> diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e87e33f49c3088a21f7032e9fd9b2bb0aa50ef83
> --- /dev/null
> +++ b/drivers/net/ovpn/crypto_aead.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <crypto/aead.h>
> +#include <linux/skbuff.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
> +#include <net/udp.h>
> +
> +#include "ovpnpriv.h"
> +#include "main.h"
> +#include "io.h"
> +#include "pktid.h"
> +#include "crypto_aead.h"
> +#include "crypto.h"
> +#include "peer.h"
> +#include "proto.h"
> +#include "skb.h"
> +
> +#define OVPN_AUTH_TAG_SIZE	16
> +#define OVPN_AAD_SIZE		(OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE)
> +
> +#define ALG_NAME_AES		"gcm(aes)"
> +#define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
> +
> +static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
> +{
> +	return  OVPN_OPCODE_SIZE +			/* OP header size */
> +		sizeof(u32) +				/* Packet ID */
> +		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
> +}
> +
> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb)
> +{
> +	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
> +	struct aead_request *req;
> +	struct sk_buff *trailer;
> +	struct scatterlist *sg;
> +	int nfrags, ret;
> +	u32 pktid, op;
> +	u8 *iv;
> +
> +	ovpn_skb_cb(skb)->peer = peer;
> +	ovpn_skb_cb(skb)->ks = ks;
> +
> +	/* Sample AEAD header format:
> +	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
> +	 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ... ]
> +	 *          [4-byte
> +	 *          IV head]
> +	 */
> +
> +	/* check that there's enough headroom in the skb for packet
> +	 * encapsulation
> +	 */
> +	if (unlikely(skb_cow_head(skb, OVPN_HEAD_ROOM)))
> +		return -ENOBUFS;
> +
> +	/* get number of skb frags and ensure that packet data is writable */
> +	nfrags = skb_cow_data(skb, 0, &trailer);
> +	if (unlikely(nfrags < 0))
> +		return nfrags;
> +
> +	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
> +		return -ENOSPC;
> +
> +	/* sg may be required by async crypto */
> +	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> +				       (nfrags + 2), GFP_ATOMIC);
> +	if (unlikely(!ovpn_skb_cb(skb)->sg))
> +		return -ENOMEM;
> +
> +	sg = ovpn_skb_cb(skb)->sg;
> +
> +	/* sg table:
> +	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
> +	 * 1, 2, 3, ..., n: payload,
> +	 * n+1: auth_tag (len=tag_size)
> +	 */
> +	sg_init_table(sg, nfrags + 2);
> +
> +	/* build scatterlist to encrypt packet payload */
> +	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
> +	if (unlikely(nfrags != ret)) {
> +		ret = -EINVAL;
> +		goto free_sg;
> +	}
> +
> +	/* append auth_tag onto scatterlist */
> +	__skb_push(skb, tag_size);
> +	sg_set_buf(sg + nfrags + 1, skb->data, tag_size);
> +
> +	/* obtain packet ID, which is used both as a first
> +	 * 4 bytes of nonce and last 4 bytes of associated data.
> +	 */
> +	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
> +	if (unlikely(ret < 0))
> +		goto free_sg;
> +
> +	/* iv may be required by async crypto */
> +	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
> +	if (unlikely(!ovpn_skb_cb(skb)->iv)) {
> +		ret = -ENOMEM;
> +		goto free_sg;
> +	}
> +
> +	iv = ovpn_skb_cb(skb)->iv;
> +
> +	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
> +	 * nonce
> +	 */
> +	ovpn_pktid_aead_write(pktid, ks->nonce_tail_xmit, iv);
> +
> +	/* make space for packet id and push it to the front */
> +	__skb_push(skb, OVPN_NONCE_WIRE_SIZE);
> +	memcpy(skb->data, iv, OVPN_NONCE_WIRE_SIZE);
> +
> +	/* add packet op as head of additional data */
> +	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
> +	__skb_push(skb, OVPN_OPCODE_SIZE);
> +	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
> +	*((__force __be32 *)skb->data) = htonl(op);
> +
> +	/* AEAD Additional data */
> +	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
> +
> +	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
> +	if (unlikely(!req)) {
> +		ret = -ENOMEM;
> +		goto free_iv;
> +	}
> +
> +	ovpn_skb_cb(skb)->req = req;
> +
> +	/* setup async crypto operation */
> +	aead_request_set_tfm(req, ks->encrypt);
> +	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
> +	aead_request_set_crypt(req, sg, sg,
> +			       skb->len - ovpn_aead_encap_overhead(ks), iv);
> +	aead_request_set_ad(req, OVPN_AAD_SIZE);
> +
> +	/* encrypt it */
> +	return crypto_aead_encrypt(req);
> +free_iv:
> +	kfree(ovpn_skb_cb(skb)->iv);
> +	ovpn_skb_cb(skb)->iv = NULL;
> +free_sg:
> +	kfree(ovpn_skb_cb(skb)->sg);
> +	ovpn_skb_cb(skb)->sg = NULL;
> +	return ret;
> +}
> +
> +int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb)
> +{
> +	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
> +	int ret, payload_len, nfrags;
> +	unsigned int payload_offset;
> +	struct aead_request *req;
> +	struct sk_buff *trailer;
> +	struct scatterlist *sg;
> +	u8 *iv;
> +
> +	payload_offset = OVPN_AAD_SIZE + tag_size;
> +	payload_len = skb->len - payload_offset;
> +
> +	ovpn_skb_cb(skb)->payload_offset = payload_offset;
> +	ovpn_skb_cb(skb)->peer = peer;
> +	ovpn_skb_cb(skb)->ks = ks;
> +
> +	/* sanity check on packet size, payload size must be >= 0 */
> +	if (unlikely(payload_len < 0))
> +		return -EINVAL;
> +
> +	/* Prepare the skb data buffer to be accessed up until the auth tag.
> +	 * This is required because this area is directly mapped into the sg
> +	 * list.
> +	 */
> +	if (unlikely(!pskb_may_pull(skb, payload_offset)))
> +		return -ENODATA;
> +
> +	/* get number of skb frags and ensure that packet data is writable */
> +	nfrags = skb_cow_data(skb, 0, &trailer);
> +	if (unlikely(nfrags < 0))
> +		return nfrags;
> +
> +	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
> +		return -ENOSPC;
> +
> +	/* sg may be required by async crypto */
> +	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> +				       (nfrags + 2), GFP_ATOMIC);
> +	if (unlikely(!ovpn_skb_cb(skb)->sg))
> +		return -ENOMEM;
> +
> +	sg = ovpn_skb_cb(skb)->sg;
> +
> +	/* sg table:
> +	 * 0: op, wire nonce (AD, len=OVPN_OPCODE_SIZE+OVPN_NONCE_WIRE_SIZE),
> +	 * 1, 2, 3, ..., n: payload,
> +	 * n+1: auth_tag (len=tag_size)
> +	 */
> +	sg_init_table(sg, nfrags + 2);
> +
> +	/* packet op is head of additional data */
> +	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
> +
> +	/* build scatterlist to decrypt packet payload */
> +	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
> +	if (unlikely(nfrags != ret)) {
> +		ret = -EINVAL;
> +		goto free_sg;
> +	}
> +
> +	/* append auth_tag onto scatterlist */
> +	sg_set_buf(sg + nfrags + 1, skb->data + OVPN_AAD_SIZE, tag_size);
> +
> +	/* iv may be required by async crypto */
> +	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
> +	if (unlikely(!ovpn_skb_cb(skb)->iv)) {
> +		ret = -ENOMEM;
> +		goto free_sg;
> +	}
> +
> +	iv = ovpn_skb_cb(skb)->iv;
> +
> +	/* copy nonce into IV buffer */
> +	memcpy(iv, skb->data + OVPN_OPCODE_SIZE, OVPN_NONCE_WIRE_SIZE);
> +	memcpy(iv + OVPN_NONCE_WIRE_SIZE, ks->nonce_tail_recv,
> +	       OVPN_NONCE_TAIL_SIZE);
> +
> +	req = aead_request_alloc(ks->decrypt, GFP_ATOMIC);
> +	if (unlikely(!req)) {
> +		ret = -ENOMEM;
> +		goto free_iv;
> +	}
> +
> +	ovpn_skb_cb(skb)->req = req;
> +
> +	/* setup async crypto operation */
> +	aead_request_set_tfm(req, ks->decrypt);
> +	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
> +	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
> +
> +	aead_request_set_ad(req, OVPN_AAD_SIZE);
> +
> +	/* decrypt it */
> +	return crypto_aead_decrypt(req);
> +free_iv:
> +	kfree(ovpn_skb_cb(skb)->iv);
> +	ovpn_skb_cb(skb)->iv = NULL;
> +free_sg:
> +	kfree(ovpn_skb_cb(skb)->sg);
> +	ovpn_skb_cb(skb)->sg = NULL;
> +	return ret;
> +}
> +
> +/* Initialize a struct crypto_aead object */
> +static struct crypto_aead *ovpn_aead_init(const char *title,
> +					  const char *alg_name,
> +					  const unsigned char *key,
> +					  unsigned int keylen)
> +{
> +	struct crypto_aead *aead;
> +	int ret;
> +
> +	aead = crypto_alloc_aead(alg_name, 0, 0);
> +	if (IS_ERR(aead)) {
> +		ret = PTR_ERR(aead);
> +		pr_err("%s crypto_alloc_aead failed, err=%d\n", title, ret);
> +		aead = NULL;
> +		goto error;
> +	}
> +
> +	ret = crypto_aead_setkey(aead, key, keylen);
> +	if (ret) {
> +		pr_err("%s crypto_aead_setkey size=%u failed, err=%d\n", title,
> +		       keylen, ret);
> +		goto error;
> +	}
> +
> +	ret = crypto_aead_setauthsize(aead, OVPN_AUTH_TAG_SIZE);
> +	if (ret) {
> +		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title,
> +		       ret);
> +		goto error;
> +	}
> +
> +	/* basic AEAD assumption */
> +	if (crypto_aead_ivsize(aead) != OVPN_NONCE_SIZE) {
> +		pr_err("%s IV size must be %d\n", title, OVPN_NONCE_SIZE);
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	pr_debug("********* Cipher %s (%s)\n", alg_name, title);
> +	pr_debug("*** IV size=%u\n", crypto_aead_ivsize(aead));
> +	pr_debug("*** req size=%u\n", crypto_aead_reqsize(aead));
> +	pr_debug("*** block size=%u\n", crypto_aead_blocksize(aead));
> +	pr_debug("*** auth size=%u\n", crypto_aead_authsize(aead));
> +	pr_debug("*** alignmask=0x%x\n", crypto_aead_alignmask(aead));
> +
> +	return aead;
> +
> +error:
> +	crypto_free_aead(aead);
> +	return ERR_PTR(ret);
> +}
> +
> +void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
> +{
> +	if (!ks)
> +		return;
> +
> +	crypto_free_aead(ks->encrypt);
> +	crypto_free_aead(ks->decrypt);
> +	kfree(ks);
> +}
> +
> +struct ovpn_crypto_key_slot *
> +ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
> +{
> +	struct ovpn_crypto_key_slot *ks = NULL;
> +	const char *alg_name;
> +	int ret;
> +
> +	/* validate crypto alg */
> +	switch (kc->cipher_alg) {
> +	case OVPN_CIPHER_ALG_AES_GCM:
> +		alg_name = ALG_NAME_AES;
> +		break;
> +	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
> +		alg_name = ALG_NAME_CHACHAPOLY;
> +		break;
> +	default:
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if (kc->encrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE ||
> +	    kc->decrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* build the key slot */
> +	ks = kmalloc(sizeof(*ks), GFP_KERNEL);
> +	if (!ks)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ks->encrypt = NULL;
> +	ks->decrypt = NULL;
> +	kref_init(&ks->refcount);
> +	ks->key_id = kc->key_id;
> +
> +	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
> +				     kc->encrypt.cipher_key,
> +				     kc->encrypt.cipher_key_size);
> +	if (IS_ERR(ks->encrypt)) {
> +		ret = PTR_ERR(ks->encrypt);
> +		ks->encrypt = NULL;
> +		goto destroy_ks;
> +	}
> +
> +	ks->decrypt = ovpn_aead_init("decrypt", alg_name,
> +				     kc->decrypt.cipher_key,
> +				     kc->decrypt.cipher_key_size);
> +	if (IS_ERR(ks->decrypt)) {
> +		ret = PTR_ERR(ks->decrypt);
> +		ks->decrypt = NULL;
> +		goto destroy_ks;
> +	}
> +
> +	memcpy(ks->nonce_tail_xmit, kc->encrypt.nonce_tail,
> +	       OVPN_NONCE_TAIL_SIZE);
> +	memcpy(ks->nonce_tail_recv, kc->decrypt.nonce_tail,
> +	       OVPN_NONCE_TAIL_SIZE);
> +
> +	/* init packet ID generation/validation */
> +	ovpn_pktid_xmit_init(&ks->pid_xmit);
> +	ovpn_pktid_recv_init(&ks->pid_recv);
> +
> +	return ks;
> +
> +destroy_ks:
> +	ovpn_aead_crypto_key_slot_destroy(ks);
> +	return ERR_PTR(ret);
> +}
> diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..40c056558add3b9d17fda5c43eb858cb44c95945
> --- /dev/null
> +++ b/drivers/net/ovpn/crypto_aead.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNAEAD_H_
> +#define _NET_OVPN_OVPNAEAD_H_
> +
> +#include "crypto.h"
> +
> +#include <asm/types.h>
> +#include <linux/skbuff.h>
> +
> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb);
> +int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb);
> +
> +struct ovpn_crypto_key_slot *
> +ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
> +void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
> +
> +#endif /* _NET_OVPN_OVPNAEAD_H_ */
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 46ad27e8eb8425f810c7d2b6c63984ea008d90fa..f8113f160148c5953c40f69a87a3ed7ce62abacb 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -7,6 +7,7 @@
>   *		Antonio Quartulli <antonio@openvpn.net>
>   */
>  
> +#include <crypto/aead.h>
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <net/gro_cells.h>
> @@ -15,6 +16,9 @@
>  #include "ovpnpriv.h"
>  #include "peer.h"
>  #include "io.h"
> +#include "bind.h"
> +#include "crypto.h"
> +#include "crypto_aead.h"
>  #include "netlink.h"
>  #include "proto.h"
>  #include "udp.h"
> @@ -44,7 +48,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>  	skb_set_queue_mapping(skb, 0);
>  	skb_scrub_packet(skb, true);
>  
> -	skb_reset_network_header(skb);
> +	/* network header reset in ovpn_decrypt_post() */
>  	skb_reset_transport_header(skb);
>  	skb_reset_inner_headers(skb);
>  
> @@ -56,34 +60,147 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>  		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
>  }
>  
> -static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
> +void ovpn_decrypt_post(void *data, int ret)
>  {
> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +	struct ovpn_crypto_key_slot *ks;
> +	unsigned int payload_offset = 0;
> +	struct sk_buff *skb = data;
> +	struct ovpn_peer *peer;
> +	__be16 proto;
> +	__be32 *pid;
> +
> +	/* crypto is happening asynchronously. this function will be called
> +	 * again later by the crypto callback with a proper return code
> +	 */
> +	if (unlikely(ret == -EINPROGRESS))
> +		return;
> +
> +	payload_offset = ovpn_skb_cb(skb)->payload_offset;
> +	ks = ovpn_skb_cb(skb)->ks;
> +	peer = ovpn_skb_cb(skb)->peer;
> +
> +	/* crypto is done, cleanup skb CB and its members */
> +
> +	if (likely(ovpn_skb_cb(skb)->iv))
> +		kfree(ovpn_skb_cb(skb)->iv);

NULL check before kfree is unnecessary, as kfree(NULL) is a noop.

> +
> +	if (likely(ovpn_skb_cb(skb)->sg))
> +		kfree(ovpn_skb_cb(skb)->sg);
> +
> +	if (likely(ovpn_skb_cb(skb)->req))
> +		aead_request_free(ovpn_skb_cb(skb)->req);

Likewise.

>  
>  	if (unlikely(ret < 0))
>  		goto drop;
>  
> +	/* PID sits after the op */
> +	pid = (__force __be32 *)(skb->data + OVPN_OPCODE_SIZE);
> +	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
> +	if (unlikely(ret < 0)) {
> +		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
> +				    netdev_name(peer->ovpn->dev), peer->id,
> +				    ret);
> +		goto drop;
> +	}
> +
> +	/* point to encapsulated IP packet */
> +	__skb_pull(skb, payload_offset);
> +
> +	/* check if this is a valid datapacket that has to be delivered to the
> +	 * ovpn interface
> +	 */
> +	skb_reset_network_header(skb);
> +	proto = ovpn_ip_check_protocol(skb);
> +	if (unlikely(!proto)) {
> +		/* check if null packet */
> +		if (unlikely(!pskb_may_pull(skb, 1))) {
> +			net_info_ratelimited("%s: NULL packet received from peer %u\n",
> +					     netdev_name(peer->ovpn->dev),
> +					     peer->id);
> +			goto drop;
> +		}
> +
> +		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		goto drop;
> +	}
> +	skb->protocol = proto;
> +
> +	/* perform Reverse Path Filtering (RPF) */
> +	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
> +		if (skb->protocol == htons(ETH_P_IPV6))
> +			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
> +					    netdev_name(peer->ovpn->dev),
> +					    peer->id, &ipv6_hdr(skb)->saddr);
> +		else
> +			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
> +					    netdev_name(peer->ovpn->dev),
> +					    peer->id, &ip_hdr(skb)->saddr);
> +		goto drop;
> +	}
> +
>  	ovpn_netdev_write(peer, skb);
>  	/* skb is passed to upper layer - don't free it */
>  	skb = NULL;
>  drop:
>  	if (unlikely(skb))
>  		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> -	ovpn_peer_put(peer);
> +	if (likely(peer))
> +		ovpn_peer_put(peer);
> +	if (likely(ks))
> +		ovpn_crypto_key_slot_put(ks);
>  	kfree_skb(skb);
>  }
>  
>  /* RX path entry point: decrypt packet and forward it to the device */
>  void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> -	ovpn_skb_cb(skb)->peer = peer;
> -	ovpn_decrypt_post(skb, 0);
> +	struct ovpn_crypto_key_slot *ks;
> +	u8 key_id;
> +
> +	/* get the key slot matching the key ID in the received packet */
> +	key_id = ovpn_key_id_from_skb(skb);
> +	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
> +	if (unlikely(!ks)) {
> +		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id,
> +				     key_id);
> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +		kfree_skb(skb);
> +		ovpn_peer_put(peer);
> +		return;
> +	}
> +
> +	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
> +	ovpn_decrypt_post(skb, ovpn_aead_decrypt(peer, ks, skb));
>  }
>  
> -static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> +void ovpn_encrypt_post(void *data, int ret)
>  {
> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +	struct ovpn_crypto_key_slot *ks;
> +	struct sk_buff *skb = data;
>  	struct ovpn_socket *sock;
> +	struct ovpn_peer *peer;
> +
> +	/* encryption is happening asynchronously. This function will be
> +	 * called later by the crypto callback with a proper return value
> +	 */
> +	if (unlikely(ret == -EINPROGRESS))
> +		return;
> +
> +	ks = ovpn_skb_cb(skb)->ks;
> +	peer = ovpn_skb_cb(skb)->peer;
> +
> +	/* crypto is done, cleanup skb CB and its members */
> +
> +	if (likely(ovpn_skb_cb(skb)->iv))
> +		kfree(ovpn_skb_cb(skb)->iv);
> +
> +	if (likely(ovpn_skb_cb(skb)->sg))
> +		kfree(ovpn_skb_cb(skb)->sg);
> +
> +	if (likely(ovpn_skb_cb(skb)->req))
> +		aead_request_free(ovpn_skb_cb(skb)->req);
>  
>  	if (unlikely(ret < 0))
>  		goto err;
> @@ -110,23 +227,33 @@ static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
>  err:
>  	if (unlikely(skb))
>  		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
> -	ovpn_peer_put(peer);
> +	if (likely(peer))
> +		ovpn_peer_put(peer);
> +	if (likely(ks))
> +		ovpn_crypto_key_slot_put(ks);
>  	kfree_skb(skb);
>  }
>  
>  static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> -	ovpn_skb_cb(skb)->peer = peer;
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	/* get primary key to be used for encrypting data */
> +	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
> +	if (unlikely(!ks))
> +		return false;
>  
>  	/* take a reference to the peer because the crypto code may run async.
>  	 * ovpn_encrypt_post() will release it upon completion
>  	 */
>  	if (unlikely(!ovpn_peer_hold(peer))) {
>  		DEBUG_NET_WARN_ON_ONCE(1);
> +		ovpn_crypto_key_slot_put(ks);
>  		return false;
>  	}
>  
> -	ovpn_encrypt_post(skb, 0);
> +	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
> +	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
>  	return true;
>  }
>  
> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> index 1cfa66873a2d4840ce57e337f8b4e8143e8b8e79..5143104b2c4b896a030ec4a8c8aea7015f40ef02 100644
> --- a/drivers/net/ovpn/io.h
> +++ b/drivers/net/ovpn/io.h
> @@ -23,4 +23,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
>  
>  void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
>  
> +void ovpn_encrypt_post(void *data, int ret);
> +void ovpn_decrypt_post(void *data, int ret);
> +
>  #endif /* _NET_OVPN_OVPN_H_ */
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 10eabd62ae7237162a36a333b41c748901a7d888..23eaab1b465b8b88a84cf9f1039621923b640b47 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -12,6 +12,8 @@
>  
>  #include "ovpnpriv.h"
>  #include "bind.h"
> +#include "pktid.h"
> +#include "crypto.h"
>  #include "io.h"
>  #include "main.h"
>  #include "netlink.h"
> @@ -56,6 +58,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
>  	peer->vpn_addrs.ipv6 = in6addr_any;
>  
>  	RCU_INIT_POINTER(peer->bind, NULL);
> +	ovpn_crypto_state_init(&peer->crypto);
>  	spin_lock_init(&peer->lock);
>  	kref_init(&peer->refcount);
>  
> @@ -94,7 +97,10 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
>   */
>  static void ovpn_peer_release(struct ovpn_peer *peer)
>  {
> +	ovpn_crypto_state_release(&peer->crypto);
> +	spin_lock_bh(&peer->lock);
>  	ovpn_bind_reset(peer, NULL);
> +	spin_unlock_bh(&peer->lock);
>  	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>  	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
>  }
> @@ -326,6 +332,29 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
>  	return peer;
>  }
>  
> +/**
> + * ovpn_peer_check_by_src - check that skb source is routed via peer
> + * @ovpn: the openvpn instance to search
> + * @skb: the packet to extract source address from
> + * @peer: the peer to check against the source address
> + *
> + * Return: true if the peer is matching or false otherwise
> + */
> +bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
> +			    struct ovpn_peer *peer)
> +{
> +	bool match = false;
> +
> +	if (ovpn->mode == OVPN_MODE_P2P) {
> +		/* in P2P mode, no matter the destination, packets are always
> +		 * sent to the single peer listening on the other side
> +		 */
> +		match = (peer == rcu_access_pointer(ovpn->peer));
> +	}
> +
> +	return match;
> +}
> +
>  /**
>   * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
>   * @ovpn: the instance to add the peer to
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index fef04311c1593db4ccfa3c417487b3d4faaae9d7..a9113a969f94d66fa17208d563d0bbd255c23fa9 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -12,6 +12,7 @@
>  
>  #include <net/dst_cache.h>
>  
> +#include "crypto.h"
>  #include "socket.h"
>  
>  /**
> @@ -23,6 +24,7 @@
>   * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>   * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
>   * @sock: the socket being used to talk to this peer
> + * @crypto: the crypto configuration (ciphers, keys, etc..)
>   * @dst_cache: cache for dst_entry used to send to peer
>   * @bind: remote peer binding
>   * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
> @@ -40,6 +42,7 @@ struct ovpn_peer {
>  		struct in6_addr ipv6;
>  	} vpn_addrs;
>  	struct ovpn_socket __rcu *sock;
> +	struct ovpn_crypto_state crypto;
>  	struct dst_cache dst_cache;
>  	struct ovpn_bind __rcu *bind;
>  	enum ovpn_del_peer_reason delete_reason;
> @@ -82,5 +85,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
>  struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
>  struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
>  				       struct sk_buff *skb);
> +bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
> +			    struct ovpn_peer *peer);
>  
>  #endif /* _NET_OVPN_OVPNPEER_H_ */
> diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2e73d1c1ec8b6c4fe2fc10ebc1a4f3008362df21
> --- /dev/null
> +++ b/drivers/net/ovpn/pktid.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/jiffies.h>
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
> +#include <linux/types.h>
> +
> +#include "ovpnpriv.h"
> +#include "main.h"
> +#include "pktid.h"
> +
> +void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid)
> +{
> +	atomic64_set(&pid->seq_num, 1);
> +}
> +
> +void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr)
> +{
> +	memset(pr, 0, sizeof(*pr));
> +	spin_lock_init(&pr->lock);
> +}
> +
> +/* Packet replay detection.
> + * Allows ID backtrack of up to REPLAY_WINDOW_SIZE - 1.
> + */
> +int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
> +{
> +	const unsigned long now = jiffies;
> +	int ret;
> +
> +	/* ID must not be zero */
> +	if (unlikely(pkt_id == 0))
> +		return -EINVAL;
> +
> +	spin_lock_bh(&pr->lock);
> +
> +	/* expire backtracks at or below pr->id after PKTID_RECV_EXPIRE time */
> +	if (unlikely(time_after_eq(now, pr->expire)))
> +		pr->id_floor = pr->id;
> +
> +	/* time changed? */
> +	if (unlikely(pkt_time != pr->time)) {
> +		if (pkt_time > pr->time) {
> +			/* time moved forward, accept */
> +			pr->base = 0;
> +			pr->extent = 0;
> +			pr->id = 0;
> +			pr->time = pkt_time;
> +			pr->id_floor = 0;
> +		} else {
> +			/* time moved backward, reject */
> +			ret = -ETIME;
> +			goto out;
> +		}
> +	}
> +
> +	if (likely(pkt_id == pr->id + 1)) {
> +		/* well-formed ID sequence (incremented by 1) */
> +		pr->base = REPLAY_INDEX(pr->base, -1);
> +		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
> +		if (pr->extent < REPLAY_WINDOW_SIZE)
> +			++pr->extent;
> +		pr->id = pkt_id;
> +	} else if (pkt_id > pr->id) {
> +		/* ID jumped forward by more than one */
> +		const unsigned int delta = pkt_id - pr->id;
> +
> +		if (delta < REPLAY_WINDOW_SIZE) {
> +			unsigned int i;
> +
> +			pr->base = REPLAY_INDEX(pr->base, -delta);
> +			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
> +			pr->extent += delta;
> +			if (pr->extent > REPLAY_WINDOW_SIZE)
> +				pr->extent = REPLAY_WINDOW_SIZE;
> +			for (i = 1; i < delta; ++i) {
> +				unsigned int newb = REPLAY_INDEX(pr->base, i);
> +
> +				pr->history[newb / 8] &= ~BIT(newb % 8);
> +			}
> +		} else {
> +			pr->base = 0;
> +			pr->extent = REPLAY_WINDOW_SIZE;
> +			memset(pr->history, 0, sizeof(pr->history));
> +			pr->history[0] = 1;
> +		}
> +		pr->id = pkt_id;
> +	} else {
> +		/* ID backtrack */
> +		const unsigned int delta = pr->id - pkt_id;
> +
> +		if (delta > pr->max_backtrack)
> +			pr->max_backtrack = delta;
> +		if (delta < pr->extent) {
> +			if (pkt_id > pr->id_floor) {
> +				const unsigned int ri = REPLAY_INDEX(pr->base,
> +								     delta);
> +				u8 *p = &pr->history[ri / 8];
> +				const u8 mask = (1 << (ri % 8));
> +
> +				if (*p & mask) {
> +					ret = -EINVAL;
> +					goto out;
> +				}
> +				*p |= mask;
> +			} else {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		} else {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	pr->expire = now + PKTID_RECV_EXPIRE;
> +	ret = 0;
> +out:
> +	spin_unlock_bh(&pr->lock);
> +	return ret;
> +}
> diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0e5fd91d488359f675f500a7368027f7a148f5c6
> --- /dev/null
> +++ b/drivers/net/ovpn/pktid.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNPKTID_H_
> +#define _NET_OVPN_OVPNPKTID_H_
> +
> +#include "proto.h"
> +
> +/* If no packets received for this length of time, set a backtrack floor
> + * at highest received packet ID thus far.
> + */
> +#define PKTID_RECV_EXPIRE (30 * HZ)
> +
> +/* Packet-ID state for transmitter */
> +struct ovpn_pktid_xmit {
> +	atomic64_t seq_num;

pktid is 32-bit so atomic_t should be enough (see below).

> +};
> +
> +/* replay window sizing in bytes = 2^REPLAY_WINDOW_ORDER */
> +#define REPLAY_WINDOW_ORDER 8
> +
> +#define REPLAY_WINDOW_BYTES BIT(REPLAY_WINDOW_ORDER)
> +#define REPLAY_WINDOW_SIZE  (REPLAY_WINDOW_BYTES * 8)
> +#define REPLAY_INDEX(base, i) (((base) + (i)) & (REPLAY_WINDOW_SIZE - 1))
> +
> +/* Packet-ID state for receiver.
> + * Other than lock member, can be zeroed to initialize.
> + */
> +struct ovpn_pktid_recv {
> +	/* "sliding window" bitmask of recent packet IDs received */
> +	u8 history[REPLAY_WINDOW_BYTES];
> +	/* bit position of deque base in history */
> +	unsigned int base;
> +	/* extent (in bits) of deque in history */
> +	unsigned int extent;
> +	/* expiration of history in jiffies */
> +	unsigned long expire;
> +	/* highest sequence number received */
> +	u32 id;
> +	/* highest time stamp received */
> +	u32 time;
> +	/* we will only accept backtrack IDs > id_floor */
> +	u32 id_floor;
> +	unsigned int max_backtrack;
> +	/* protects entire pktd ID state */
> +	spinlock_t lock;
> +};
> +
> +/* Get the next packet ID for xmit */
> +static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
> +{
> +	const s64 seq_num = atomic64_fetch_add_unless(&pid->seq_num, 1,
> +						      0x100000000LL);
> +	/* when the 32bit space is over, we return an error because the packet
> +	 * ID is used to create the cipher IV and we do not want to reuse the
> +	 * same value more than once
> +	 */
> +	if (unlikely(seq_num == 0x100000000LL))
> +		return -ERANGE;

You may use a 32-bit atomic_t, instead of checking if it equals
0x1_00000000, check if it wraparounds to zero.
Additionally, you don't need full memory ordering as you just want an
incrementing value:

int seq_num = atomic_fetch_inc_relaxed(&pid->seq_num);

if (unlikely(!seq_num))
	...

> +
> +	*pktid = (u32)seq_num;
> +
> +	return 0;
> +}
> +
> +/* Write 12-byte AEAD IV to dest */
> +static inline void ovpn_pktid_aead_write(const u32 pktid,
> +					 const u8 nt[],
> +					 unsigned char *dest)
> +{
> +	*(__force __be32 *)(dest) = htonl(pktid);
> +	BUILD_BUG_ON(4 + OVPN_NONCE_TAIL_SIZE != OVPN_NONCE_SIZE);
> +	memcpy(dest + 4, nt, OVPN_NONCE_TAIL_SIZE);
> +}
> +
> +void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid);
> +void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr);
> +
> +int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time);
> +
> +#endif /* _NET_OVPN_OVPNPKTID_H_ */
> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
> index 591b97a9925fd9b91f996d6d591fac41b1aa6148..b7322c7c515e5c0744719e11ca81fece3ca28569 100644
> --- a/drivers/net/ovpn/proto.h
> +++ b/drivers/net/ovpn/proto.h
> @@ -83,4 +83,36 @@ static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
>  	return FIELD_GET(OVPN_OPCODE_PEERID_MASK, opcode);
>  }
>  
> +/**
> + * ovpn_key_id_from_skb - extract key ID from the skb head
> + * @skb: the packet to extract the key ID code from
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.
> + *
> + * Return: the key ID
> + */
> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
> +{
> +	u32 opcode = be32_to_cpu(*(__be32 *)skb->data);
> +
> +	return FIELD_GET(OVPN_OPCODE_KEYID_MASK, opcode);
> +}
> +
> +/**
> + * ovpn_opcode_compose - combine OP code, key ID and peer ID to wire format
> + * @opcode: the OP code
> + * @key_id: the key ID
> + * @peer_id: the peer ID
> + *
> + * Return: a 4 bytes integer obtained combining all input values following the
> + * OpenVPN wire format. This integer can then be written to the packet header.
> + */
> +static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
> +{
> +	return FIELD_PREP(OVPN_OPCODE_PKTTYPE_MASK, opcode) |
> +	       FIELD_PREP(OVPN_OPCODE_KEYID_MASK, key_id) |
> +	       FIELD_PREP(OVPN_OPCODE_PEERID_MASK, peer_id);
> +}
> +
>  #endif /* _NET_OVPN_OVPNPROTO_H_ */
> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
> index 9db7a9adebdb4cc493f162f89fb2e9c6301fa213..bd3cbcfc770d2c28d234fcdd081b4d02e6496ea0 100644
> --- a/drivers/net/ovpn/skb.h
> +++ b/drivers/net/ovpn/skb.h
> @@ -20,6 +20,11 @@
>  
>  struct ovpn_cb {
>  	struct ovpn_peer *peer;
> +	struct ovpn_crypto_key_slot *ks;
> +	struct aead_request *req;
> +	struct scatterlist *sg;
> +	u8 *iv;
> +	unsigned int payload_offset;
>  };
>  
>  static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
> 
> -- 
> 2.48.1

-- Qingfang

