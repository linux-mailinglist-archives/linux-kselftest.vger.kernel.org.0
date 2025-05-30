Return-Path: <linux-kselftest+bounces-34035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE9AC877D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 06:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1593A3F8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 04:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4B215766;
	Fri, 30 May 2025 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mij+rkFN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D3213E78
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580646; cv=none; b=N8Do6JR+k76PMHRk17TEHWqQtsGcsc4+JfOrGlhXmsaVJcUBj98SVq1u0BlXRUUK5N1waOkQjIcuUux/FE0KgMMGFxKEEOHSyaPPGIpkBxvJkkJ4eDEYBIb/rLztHjlF2nZplKWOA5E7G+d40JJ2kr+4J8m/qKYOFV/JgOPCwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580646; c=relaxed/simple;
	bh=pLf6jUwMzbKvS7onpumYZPr9TV4M8Ko3oz3le5/fTkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=T07CsLfMhCb4//JMrMEaPaUdkVrW133FmrLwPQZyjP6IVxIh8f3GlLQ3kLYpbDETpM9zpqrMAgBg2e7R9SzYOqYIbsKTIDI1Ni07I2UHw/LB17v2KfKehaawAAzLXNG3f6s7XLUU1vCmxoFn9Wthgy5g+PZpSptYF/FZoae0t5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=mij+rkFN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c5f3456fso1272144b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580644; x=1749185444; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bliiQKeeAnovPvWkPG7+CPn/Ly6UtOvnXFU0X7rvR8=;
        b=mij+rkFNp0HJj3XM9Xj5sLEydn4ir+dv+2vztZ+qhlMRREfJJC16mOzpNcWkepd9LA
         HQ5b2J1FDfjsIMtibapWIk25orvloZ76gxe89+p2lLDsDLxY3+lpNpDrQRpfhQONoGof
         XWuDZoycTSW+UceX3Te5bvJ9cT1rXFNvM7erZ592t/UpDlM0XTv07VqCZNKewdzLbQbp
         Re9Ed33I83ule+U/QRulNVdmXM3u4rvxqOqlPbsNS42P3z+N1jpqsQl8XbsYkmMmEFsR
         8Fhru9y+qInJsVZxPAL+K0Iyp+qpwg71ivQQxMYy00V1/LM3BmvUeZ6lI3iTO+MEpOQ4
         U2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580644; x=1749185444;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bliiQKeeAnovPvWkPG7+CPn/Ly6UtOvnXFU0X7rvR8=;
        b=rr0UpvQAO5kjMPDKlKF3Apv2CMzYhB/tQn64y5N+i4GaGU1dYhiGGetj+kniL9+MdJ
         /OXcIao/vJtGRV9fttUwkrNPJX7qDtJf993hl3hCBqa8bEefsSEC11S1lSz/loGn8baP
         ZQGnqnStK5IrKpASlLNXpY3GohrWh7K+UZq/5GqfIHdcTJMFZm6cGJ27hEnoWQod0uQn
         Cuzi60uB+i22CkZgS/JSyncYsXEbE8KmWIy48IhxBr0+OJgS2oB3kStc9a29jyZ+DgAD
         1ob6KTI3z8aEMBBwZVrYyNbVmtnRm16uB9ky6V40sc+SinEfzDXq98NeB18KiOjekgE3
         MoJA==
X-Forwarded-Encrypted: i=1; AJvYcCV6TSGpROygZBhjkqakAhqHRECusfKH2jTbWbv69IhAvQWKA06foWslgUIOulH8z1Qjv0lP07X878RKKewtAuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJK6k1TpzFBoqiqzqGIb81jiCgo4mdHUiIG3ZjBcQRtpAtaT2
	CaJYPl+m1nX8JWNnz6RugnoKF88Usx2zsNLuhyGUZ8XHTUavP8xmp2ir/TD07kT8cew=
X-Gm-Gg: ASbGncvgAUZ+2v6g0TNJmJntDtM8mMMt4KXKtUkHP4g44pU4NMDry68PD3lOMrizXl4
	gR1Y4tEUBMCY47tzUOqyWWO1n9o5qrC4RyWGbgmtMGUFTdPuYhRW6QF8AlBsKSjhJcjEmdiCcRJ
	e4Axwcmp5bv8++1xKTRWpVGLK4MGjJMDjKrtegnk1RKrY+xd20tRWeKleJycQOIygYQbmr7TSVv
	nB0gG4YalfGiiZRPsLxBJ88349Dm7A2wQOajJ70dm5QsSdBf66RxCm5UCmhpLdhu6clGNsuZ4Xi
	vd6PawQuPtBAIhCQXWLX4ecNFrJ8Y6/cXoQf1wPSyQYx+U9tUZhj
X-Google-Smtp-Source: AGHT+IH6w6wgJ+lEr9cseVqB9SEtKbAXzFrBj+vCbQrpLi9MlTf7rPogj7hu0BIsDE96/NgNWbZVcg==
X-Received: by 2002:a05:6a00:2d08:b0:742:9fea:a2d1 with SMTP id d2e1a72fcca58-747bda1ad23mr2619324b3a.23.1748580643683;
        Thu, 29 May 2025 21:50:43 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afeab6bdsm2180078b3a.37.2025.05.29.21.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:08 +0900
Subject: [PATCH net-next v12 04/10] tun: Add common virtio-net hash feature
 code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-4-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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

TUNGETVNETHASHTYPES
-------------------

This ioctl tells supported hash types. It is useful to check if a VM can
be migrated to the current host.

TUNSETVNETREPORTINGAUTOMQ, TUNSETVNETREPORTINGRSS, and TUNSETVNETRSS
--------------------------------------------------------------------

These ioctls configures a steering algorithm and, if needed, hash
reporting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/tap.c           |  10 ++-
 drivers/net/tun.c           |  12 +++-
 drivers/net/tun_vnet.h      | 165 +++++++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/if_tun.h |  71 +++++++++++++++++++
 4 files changed, 244 insertions(+), 14 deletions(-)

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
index 58b9ac7a5fc4..45d0533efc8d 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -6,6 +6,17 @@
 #define TUN_VNET_LE     0x80000000
 #define TUN_VNET_BE     0x40000000
 
+typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
+typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
+
+struct tun_vnet_hash {
+	bool report;
+	bool rss;
+	struct tun_vnet_rss common;
+	u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	u16 rss_indirection_table[];
+};
+
 static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
 {
 	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
@@ -107,6 +118,128 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
 	}
 }
 
+static inline long tun_vnet_ioctl_gethashtypes(u32 __user *argp)
+{
+	return put_user(VIRTIO_NET_SUPPORTED_HASH_TYPES, argp) ? -EFAULT : 0;
+}
+
+static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash __rcu **hashp,
+					  unsigned int cmd,
+					  void __user *argp)
+{
+	struct tun_vnet_rss common;
+	struct tun_vnet_hash *hash;
+	size_t indirection_table_size;
+	size_t key_size;
+	size_t size;
+
+	switch (cmd) {
+	case TUNSETVNETREPORTINGAUTOMQ:
+		if (get_user(common.hash_types, (u32 __user *)argp))
+			return -EFAULT;
+
+		if (common.hash_types) {
+			hash = kzalloc(sizeof(*hash), GFP_KERNEL);
+			if (!hash)
+				return -ENOMEM;
+
+			hash->report = true;
+			hash->common.hash_types = common.hash_types;
+		} else {
+			hash = NULL;
+		}
+		break;
+
+	case TUNSETVNETREPORTINGRSS:
+	case TUNSETVNETRSS:
+		if (copy_from_user(&common, argp, sizeof(common)))
+			return -EFAULT;
+		argp = (struct tun_vnet_rss __user *)argp + 1;
+
+		indirection_table_size = ((size_t)common.indirection_table_mask + 1) * 2;
+		key_size = virtio_net_hash_key_length(common.hash_types);
+		size = struct_size(hash, rss_indirection_table,
+				   (size_t)common.indirection_table_mask + 1);
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
+		argp = (u16 __user *)argp + common.indirection_table_mask + 1;
+
+		if (copy_from_user(hash->rss_key, argp, key_size)) {
+			kfree(hash);
+			return -EFAULT;
+		}
+
+		virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
+		hash->report = cmd == TUNSETVNETREPORTINGRSS;
+		hash->rss = true;
+		hash->common = common;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
+	return 0;
+}
+
+static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
+					struct sk_buff *skb,
+					const struct flow_keys_basic *keys,
+					u32 value,
+					tun_vnet_hash_add vnet_hash_add)
+{
+	struct virtio_net_hash *report;
+
+	if (!hash || !hash->report)
+		return;
+
+	report = vnet_hash_add(skb);
+	if (!report)
+		return;
+
+	*report = (struct virtio_net_hash) {
+		.report = virtio_net_hash_report(hash->common.hash_types, keys),
+		.value = value
+	};
+}
+
+static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
+					    const struct tun_vnet_hash *hash,
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
+	virtio_net_hash_rss(skb, hash->common.hash_types, hash->rss_key, &ret);
+
+	if (!ret.report)
+		return hash->common.unclassified_queue % numqueues;
+
+	if (hash->report) {
+		report = vnet_hash_add(skb);
+		if (report)
+			*report = ret;
+	}
+
+	index = ret.value & hash->common.indirection_table_mask;
+
+	return hash->rss_indirection_table[index] % numqueues;
+}
+
 static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 				   struct iov_iter *from,
 				   struct virtio_net_hdr *hdr)
@@ -135,15 +268,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
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
@@ -155,26 +290,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
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
index 980de74724fc..fe4b984d3bbb 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -62,6 +62,62 @@
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
 
+/**
+ * define TUNGETVNETHASHTYPES - ioctl to get supported virtio_net hashing types
+ *
+ * The argument is a pointer to __u32 which will store the supported virtio_net
+ * hashing types.
+ */
+#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
+
+/**
+ * define TUNSETVNETREPORTINGAUTOMQ - ioctl to enable automq with hash reporting
+ *
+ * Disable RSS and enable automatic receive steering with hash reporting.
+ *
+ * The argument is a pointer to __u32 that contains a bitmask of hash types
+ * allowed to be reported.
+ *
+ * This ioctl results in %EBADFD if the underlying device is deleted. It affects
+ * all queues attached to the same device.
+ *
+ * This ioctl currently has no effect on XDP packets and packets with
+ * queue_mapping set by TC.
+ */
+#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
+
+/**
+ * define TUNSETVNETREPORTINGRSS - ioctl to enable RSS with hash reporting
+ *
+ * Disable automatic receive steering and enable RSS with hash reporting.
+ *
+ * This ioctl results in %EBADFD if the underlying device is deleted. It affects
+ * all queues attached to the same device.
+ *
+ * This ioctl currently has no effect on XDP packets and packets with
+ * queue_mapping set by TC.
+ */
+#define TUNSETVNETREPORTINGRSS _IOR('T', 230, struct tun_vnet_rss)
+
+/**
+ * define TUNSETVNETRSS - ioctl to enable RSS without hash reporting
+ *
+ * Disable automatic receive steering and enable RSS without hash reporting.
+ *
+ * The argument is a pointer to the compound of the following in order:
+ *
+ * 1. &struct tun_vnet_rss
+ * 3. Indirection table
+ * 4. Key
+ *
+ * This ioctl results in %EBADFD if the underlying device is deleted. It affects
+ * all queues attached to the same device.
+ *
+ * This ioctl currently has no effect on XDP packets and packets with
+ * queue_mapping set by TC.
+ */
+#define TUNSETVNETRSS _IOR('T', 231, struct tun_vnet_rss)
+
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
 #define IFF_TAP		0x0002
@@ -124,4 +180,19 @@ struct tun_filter {
  */
 #define TUN_STEERINGEBPF_FALLBACK -1
 
+/**
+ * struct tun_vnet_rss - virtio_net RSS configuration
+ * @hash_types:
+ *		Bitmask of allowed hash types
+ * @indirection_table_mask:
+ *		Bitmask to be applied to the indirection table index
+ * @unclassified_queue:
+ *		The index of the queue to place unclassified packets in
+ */
+struct tun_vnet_rss {
+	__u32 hash_types;
+	__u16 indirection_table_mask;
+	__u16 unclassified_queue;
+};
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.49.0


