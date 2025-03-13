Return-Path: <linux-kselftest+bounces-28885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D71EA5EC50
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 08:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6163C17709A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6082010EE;
	Thu, 13 Mar 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="m2TYYB4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D992010E8
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849312; cv=none; b=KJfcwyaRaBZO5tkAQQlUgihPb5JxQHnxocmUB+haSuGr28CDVJ0PuxuML291jQYWKaxobFERNA3Wa9uyiVZgzwWLVA+SIzzLNZLveA9Dm+CRI8sTcoPvxW9oQtlRVBvrf+JJJ0vijjtsr/kiANivxZ+edtnP5mq6uRVcQdjuVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849312; c=relaxed/simple;
	bh=nFlZruyUGC1SefIAzclzdj2tkbf6BBZOp0YpRTkvlMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=hS0NntM4DB0w1fH/qPOsBS0e8ddILDfYA5HcVBdQzlC93NdemvoGLZyrEHvDKt5VVASXWjP8wqs7ic2wj/tqjJYWVLMihifX+6kbSnO4qZK6Y4nezaDHoGJn0bd/sajmRYGpG8M8MCXW1SU45kwBW8/g99uM6QHPriv4S21qeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=m2TYYB4j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22580c9ee0aso10681305ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849309; x=1742454109; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DF+oAfxAaVuIF8loqeGyU6Uzr2digKuwKsJalo4eV8o=;
        b=m2TYYB4j60667IoEIdzUzKzS9qpNTO2zIPh4CTF+e9/aJK5o28a/7bz1F2aGH45CZV
         8ZDE9il28MXyO2aTb8XbePu+RnRwilihTvZpdUXvYPVewwBi7lWzeUJUmBEQdRV1CnM+
         l9balU9PHK3Ed0eXJXCY6NQkB0/2fAPyIRsaSfVvGt18fhDvheN1fqYGZVLjrYsxGNXr
         Zha7PIVdi02H0zQFJeYndNN09NQ/WAg79qxuDAm8/EP9EtJb5yEvgk72YB/oHgfklafc
         ZlWM4UsL0C5dTzb27zqZbz3ASChI/QdDZw5x9gPHAZd0gZdJG6hp+YDtK5f0fWzel04Y
         SE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849309; x=1742454109;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF+oAfxAaVuIF8loqeGyU6Uzr2digKuwKsJalo4eV8o=;
        b=FDFNNX3PdTg3P+mDqqaocDkEHnvyBmvTFgeTHB2890OUu/F+R4QwveYU7fi8SLxBnH
         9sZDlOOqwZ9/u1sewF/k717LSmFBAmH+HDrvmCklBDSQP7kyk6dT8Kws4fm7iadqRPcZ
         216vfyc+l3o8xbXSNN9X9ltzk/AZcVPm/49UUpUtlYxa0LVbN00AtGksMEnwgwYTdyxP
         SBXPdcqxXphQT7eeu/mwVJF+2TfB2WnGFmPZOkO/LssiEiAfsqtTl1hyZXR2MmNTBKAq
         5QnOrcQMAC8/LJxi9BnA2ffosLZF7bcukx/ETXVoX+DcqeuikyZYpVpNVkvEvYtofM+A
         lUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNIFu2X1+jCNZ5pc1bu0iyh59WRUjjQHLDdtVOovVg9DxZTjzx1GkrMC7Mw4GgHj/ld9lkdJdDc8vj2YJWj40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hjMsNntnOQzxon1+RoRUr5sJ0fjjBPI81DotUCdpYAitOrZW
	l2jPifIJK7J/1hlukPKF4y8cKE+aZ8fV92cZvRpnpXUBnMMP9ReAGeCDz310LP4=
X-Gm-Gg: ASbGncu1hT4hxBFyLXy19dZf2aqQpTNKTx0nOApquriZHCT0bFU/YiUawAio5RYKAFr
	wSgIiZTX1H+R+83frMSbdO/Mjtruh6UitoNSTZRHMTgbrJ9Aqbda2U26ftvxj/zU8GmeTgP8uGY
	kySG3mp9LejH0r5L7zJYTJGA6kDO0kme875nU3QSJ90PNeWSyTwmXlM5CLmSMH4/+5AuCIOYX96
	SVLHjrO4q/OJFHxGnHznDGKyULrhARXP+g25AqRale/Dv/HN9mHCEPnN45GBXOLLFK/hhrq+7Lc
	THWoJdWPHv1Pb/qHQ4ly/Rdd2+Tldt5LVNop8UkcpBCwR//G
X-Google-Smtp-Source: AGHT+IH5QsZweiomgoa/OhpQwcjK3b5H1Gh/Rd8XP29KHLtEBaqYadv3hlLrbFNVf4iCPy/aNayE1Q==
X-Received: by 2002:a17:902:d509:b0:224:1e7a:43fe with SMTP id d9443c01a7336-22428bf168amr399052815ad.46.1741849309429;
        Thu, 13 Mar 2025 00:01:49 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6ba6efesm6479755ad.137.2025.03.13.00.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:07 +0900
Subject: [PATCH net-next v10 04/10] tun: Add common virtio-net hash feature
 code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-4-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Add common code required for the features being added to TUN and TAP.
They will be enabled for each of them in following patches.

Added Features
==============

Hash reporting
--------------

Allow the guest to reuse the hash value to make receive steering
consistent between the host and guest, and to save hash computation.

Receive Side Scaling (RSS)
--------------------------

RSS is a receive steering algorithm that can be negotiated to use with
virtio_net. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF steering program.

Introduce the code to perform RSS to the kernel in order to overcome
thse challenges. An alternative solution is to extend the eBPF steering
program so that it will be able to report to the userspace, but I didn't
opt for it because extending the current mechanism of eBPF steering
program as is because it relies on legacy context rewriting, and
introducing kfunc-based eBPF will result in non-UAPI dependency while
the other relevant virtualization APIs such as KVM and vhost_net are
UAPIs.

Added ioctls
============

They are designed to make extensibility and VM migration compatible.
This change only adds the implementation and does not expose them to
the userspace.

TUNGETVNETHASHCAP
-----------------

This ioctl tells supported features and hash types. It is useful to
check if a VM can be migrated to the current host.

TUNSETVNETHASH
--------------

This ioctl allows setting features and hash types to be enabled. It
limits the features exposed to the guest to ensure proper migration. It
also sets RSS parameters, depending on the enabled features and hash
types.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/tap.c           |  10 ++-
 drivers/net/tun.c           |  12 +++-
 drivers/net/tun_vnet.h      | 155 +++++++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/if_tun.h |  73 +++++++++++++++++++++
 4 files changed, 236 insertions(+), 14 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d4ece538f1b2..25c60ff2d3f2 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -179,6 +179,11 @@ static void tap_put_queue(struct tap_queue *q)
 	sock_put(&q->sk);
 }
 
+static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
+{
+	return NULL;
+}
+
 /*
  * Select a queue based on the rxq of the device on which this packet
  * arrived. If the incoming device is not mq, calculate a flow hash
@@ -711,11 +716,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr vnet_hdr;
+		struct virtio_net_hdr_v1_hash vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
+		ret = tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NULL, skb,
+					    tap_find_hash, &vnet_hdr);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9133ab9ed3f5..03d47799e9bd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -451,6 +451,11 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
 		e->rps_rxhash = hash;
 }
 
+static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
+{
+	return NULL;
+}
+
 /* We try to identify a flow through its rxhash. The reason that
  * we do not check rxq no. is because some cards(e.g 82599), chooses
  * the rxq based on the txq where the last packet of the flow comes. As
@@ -1993,7 +1998,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	ssize_t ret;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
+		struct virtio_net_hdr_v1_hash gso = { 0 };
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
@@ -2046,9 +2051,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct virtio_net_hdr_v1_hash gso;
 
-		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev,
+					    skb, tun_find_hash, &gso);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 58b9ac7a5fc4..578adaac0671 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -6,6 +6,16 @@
 #define TUN_VNET_LE     0x80000000
 #define TUN_VNET_BE     0x40000000
 
+typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
+typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
+
+struct tun_vnet_hash_container {
+	struct tun_vnet_hash common;
+	struct tun_vnet_hash_rss rss;
+	u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	u16 rss_indirection_table[];
+};
+
 static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
 {
 	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
@@ -107,6 +117,119 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
 	}
 }
 
+static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
+{
+	static const struct tun_vnet_hash cap = {
+		.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+		.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
+	};
+
+	return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
+}
+
+static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_container __rcu **hashp,
+					  void __user *argp)
+{
+	struct tun_vnet_hash hash_buf;
+	struct tun_vnet_hash_container *hash;
+
+	if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
+		return -EFAULT;
+	argp = (struct tun_vnet_hash __user *)argp + 1;
+
+	if (hash_buf.flags & TUN_VNET_HASH_RSS) {
+		struct tun_vnet_hash_rss rss;
+		size_t indirection_table_size;
+		size_t key_size;
+		size_t size;
+
+		if (copy_from_user(&rss, argp, sizeof(rss)))
+			return -EFAULT;
+		argp = (struct tun_vnet_hash_rss __user *)argp + 1;
+
+		indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
+		key_size = virtio_net_hash_key_length(hash_buf.types);
+		size = struct_size(hash, rss_indirection_table,
+				   (size_t)rss.indirection_table_mask + 1);
+
+		hash = kmalloc(size, GFP_KERNEL);
+		if (!hash)
+			return -ENOMEM;
+
+		if (copy_from_user(hash->rss_indirection_table,
+				   argp, indirection_table_size)) {
+			kfree(hash);
+			return -EFAULT;
+		}
+		argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
+
+		if (copy_from_user(hash->rss_key, argp, key_size)) {
+			kfree(hash);
+			return -EFAULT;
+		}
+
+		virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
+		hash->rss = rss;
+	} else {
+		hash = kmalloc(sizeof(hash->common), GFP_KERNEL);
+		if (!hash)
+			return -ENOMEM;
+	}
+
+	hash->common = hash_buf;
+	kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
+	return 0;
+}
+
+static inline void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
+					struct sk_buff *skb,
+					const struct flow_keys_basic *keys,
+					u32 value,
+					tun_vnet_hash_add vnet_hash_add)
+{
+	struct virtio_net_hash *report;
+
+	if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
+		return;
+
+	report = vnet_hash_add(skb);
+	if (!report)
+		return;
+
+	*report = (struct virtio_net_hash) {
+		.report = virtio_net_hash_report(hash->common.types, keys),
+		.value = value
+	};
+}
+
+static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
+					    const struct tun_vnet_hash_container *hash,
+					    struct sk_buff *skb,
+					    tun_vnet_hash_add vnet_hash_add)
+{
+	struct virtio_net_hash *report;
+	struct virtio_net_hash ret;
+	u16 index;
+
+	if (!numqueues)
+		return 0;
+
+	virtio_net_hash_rss(skb, hash->common.types, hash->rss_key, &ret);
+
+	if (!ret.report)
+		return hash->rss.unclassified_queue % numqueues;
+
+	if (hash->common.flags & TUN_VNET_HASH_REPORT) {
+		report = vnet_hash_add(skb);
+		if (report)
+			*report = ret;
+	}
+
+	index = ret.value & hash->rss.indirection_table_mask;
+
+	return hash->rss_indirection_table[index] % numqueues;
+}
+
 static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 				   struct iov_iter *from,
 				   struct virtio_net_hdr *hdr)
@@ -135,15 +258,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 }
 
 static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-				   const struct virtio_net_hdr *hdr)
+				   const struct virtio_net_hdr_v1_hash *hdr)
 {
+	int content_sz = MIN(sizeof(*hdr), sz);
+
 	if (unlikely(iov_iter_count(iter) < sz))
 		return -EINVAL;
 
-	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
+	if (unlikely(copy_to_iter(hdr, content_sz, iter) != content_sz))
 		return -EFAULT;
 
-	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
 		return -EFAULT;
 
 	return 0;
@@ -155,26 +280,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
 }
 
-static inline int tun_vnet_hdr_from_skb(unsigned int flags,
+static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
 					const struct net_device *dev,
 					const struct sk_buff *skb,
-					struct virtio_net_hdr *hdr)
+					tun_vnet_hash_find vnet_hash_find,
+					struct virtio_net_hdr_v1_hash *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+	const struct virtio_net_hash *report = sz < sizeof(struct virtio_net_hdr_v1_hash) ?
+					       NULL : vnet_hash_find(skb);
+
+	*hdr = (struct virtio_net_hdr_v1_hash) {
+		.hash_report = VIRTIO_NET_HASH_REPORT_NONE
+	};
+
+	if (report) {
+		hdr->hash_value = cpu_to_le32(report->value);
+		hdr->hash_report = cpu_to_le16(report->report);
+	}
 
-	if (virtio_net_hdr_from_skb(skb, hdr,
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
 				    tun_vnet_is_little_endian(flags), true,
 				    vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
 		if (net_ratelimit()) {
 			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->gso_size),
-				   tun_vnet16_to_cpu(flags, hdr->hdr_len));
+				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->hdr.gso_size),
+				   tun_vnet16_to_cpu(flags, hdr->hdr.hdr_len));
 			print_hex_dump(KERN_ERR, "tun: ",
 				       DUMP_PREFIX_NONE,
 				       16, 1, skb->head,
-				       min(tun_vnet16_to_cpu(flags, hdr->hdr_len), 64), true);
+				       min(tun_vnet16_to_cpu(flags, hdr->hdr.hdr_len), 64), true);
 		}
 		WARN_ON_ONCE(1);
 		return -EINVAL;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 980de74724fc..b7b0fe69a652 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -62,6 +62,42 @@
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
 
+/**
+ * define TUNGETVNETHASHCAP - ioctl to get virtio_net hashing capability
+ *
+ * The argument is a pointer to &struct tun_vnet_hash which will store the
+ * maximal virtio_net hashing configuration.
+ */
+#define TUNGETVNETHASHCAP _IOR('T', 228, struct tun_vnet_hash)
+
+/**
+ * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
+ *
+ * The argument is a pointer to &struct tun_vnet_hash.
+ *
+ * The argument is a pointer to the compound of the following in order if
+ * %TUN_VNET_HASH_RSS is set:
+ *
+ * 1. &struct tun_vnet_hash
+ * 2. &struct tun_vnet_hash_rss
+ * 3. Indirection table
+ * 4. Key
+ *
+ * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
+ * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
+ * to the size of &struct virtio_net_hdr_v1_hash.
+ *
+ * The members added to the legacy header by %TUN_VNET_HASH_REPORT flag will
+ * always be little-endian.
+ *
+ * This ioctl results in %EBADFD if the underlying device is deleted. It affects
+ * all queues attached to the same device.
+ *
+ * This ioctl currently has no effect on XDP packets and packets with
+ * queue_mapping set by TC.
+ */
+#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
+
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
 #define IFF_TAP		0x0002
@@ -124,4 +160,41 @@ struct tun_filter {
  */
 #define TUN_STEERINGEBPF_FALLBACK -1
 
+/**
+ * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
+ */
+#define TUN_VNET_HASH_REPORT	0x0001
+
+/**
+ * define TUN_VNET_HASH_RSS - Request virtio_net RSS
+ */
+#define TUN_VNET_HASH_RSS	0x0002
+
+/**
+ * struct tun_vnet_hash - virtio_net hashing configuration
+ * @flags:
+ *		Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNET_HASH_RSS
+ * @pad:
+ *		Should be filled with zero before passing to %TUNSETVNETHASH
+ * @types:
+ *		Bitmask of allowed hash types
+ */
+struct tun_vnet_hash {
+	__u16 flags;
+	__u8 pad[2];
+	__u32 types;
+};
+
+/**
+ * struct tun_vnet_hash_rss - virtio_net RSS configuration
+ * @indirection_table_mask:
+ *		Bitmask to be applied to the indirection table index
+ * @unclassified_queue:
+ *		The index of the queue to place unclassified packets in
+ */
+struct tun_vnet_hash_rss {
+	__u16 indirection_table_mask;
+	__u16 unclassified_queue;
+};
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.48.1


