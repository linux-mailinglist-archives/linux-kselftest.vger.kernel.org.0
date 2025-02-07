Return-Path: <linux-kselftest+bounces-25970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA21A2BB23
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E03A7EE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98B235C1F;
	Fri,  7 Feb 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ws4kaxpv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE00235BEA
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908694; cv=none; b=kksrKhGoNFP0BQjnrd4cUELq3AlZE0ll6GZ/l5tDJyFJrlyiSbG8UcJsUbfOLYZdM+4nppM3RNLPEGwmxvb8TR0GjDnQcMjS4Vb1s4tdXcb0GNDyJpfWmUorl/41Z4MmMGR7nusC4WnG5RWjr2pQAR+d+eYHlWJ+tOeF6aHh8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908694; c=relaxed/simple;
	bh=14P4miNDa9H6HIf6vY14ANPJygZ9JM6cwyTT54tjwx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pl4GYIbRs+zbLVrshgLkY0SBzRyaSealsWkWmX6EKZqceXcP9x94zrPkavT5jsYnkoRM4hid5DfvjkJ6BLxFxVA+UuvkwCSASMpnXGJtoI4fuRTKsLV3wA/hYxK/BB/3svfTPPYMhd8kyIDo2HWksxZbPHitVh1xu44AXgjrhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ws4kaxpv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f0bc811dbso41501505ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 22:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908691; x=1739513491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryfdrY9lKc9aI6OIx44cHyHYp5a4chMvNjG7SkF+UUY=;
        b=ws4kaxpv6WNRak4Ix9gljrD/OWm3v1I977bmuP0JZasA08UmhY0Iwu0tQI47Ob2bP+
         bh+pKmIKUev6s4eJyNTxADDh0wwsXe3Vu59ASOkJAycDLFsEqdg3XBy76pwQQFHRAiv6
         XAXFa092g/n5rGp++D9grQfRomo2YCoWIqCOw6nqP8dqOyo9z/YR6GnqG7BYWNK8uU8E
         Fy0wvV6d6iHPUB4bTbQYRVTJ8N4E8kYS9k+GabmG2TmlwDdcWFR+Z0qvGjq1rjBYSCRc
         pHJE5g/xbW7zg8lm2fqMZcAevBVeF7tZy+VTBdiIVwt8anXwfAVtxR4xXAHjACRGTKkj
         CQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908691; x=1739513491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryfdrY9lKc9aI6OIx44cHyHYp5a4chMvNjG7SkF+UUY=;
        b=CXVey1p2rKq88CSm2+FEr9uGxMvHCRmvZhl2iFIH3m0E3PQuXzlEq6tJg1NJdhjkni
         onpxgLnzqWWychfJvlDbO4uCFCbzlyjB5TlDSYVqNO2Wq06OTrecMu3jSgNrHoRFNMKo
         MR37HD/ACP68jZHadCFH6Sic4OL4p1GxKu/wKhf9O2O4jpdhja2eIdlhpXKE9BU8tp/A
         m/jg12JQ1yn6N1RP78P0bX+t1xpwA6lKGFoLF9j02t1gkD2fhhfE0uKnc52BJca6vkq+
         YSyCdK1yFybg0WsfHY6V0CWJUzHTJlQB1Ss38GHNN4+N0FaRm1orjVhPLP3C9hgjbJyL
         n+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNpYo4Pkc56NRos5fPY8F40D1CJHFrq1Bokg16rfwUNU5MA5Oh97mQ7mR2dhl6+X8tYv+2ABgKSBCucegZEe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRn3kSfs/5wU4iVMfM2oPWaPn4Iaxp89uHBLh4v2Zm1BtMV2L
	DpI74lK89yI9jJCnsY8ClJPBQEIVakNVgCFw/3V+Pk7bvzHl7Fg/6EvNuXpZEqk=
X-Gm-Gg: ASbGncuJI9lwfZYgxmwfIdDVlWsTv5x9NBNE6shMoDx59F7AuR9Hvfm3/oev4crkUKY
	cq/KKx8QKRczy2a/0rGVc9/QLYkywYWDzK585LFkrzPHeJX3zbsEEr7rDNHAqpLw5cynGUXyaSD
	8Yi99RoxQacup1HYKMlgoC5RYtKEHnv5hTQFUeC033Xgrz28Zb7L6cUQJ00JwuElCrJfEQ5sGi4
	QNi0xOQSkOIQ/H3VQ6LTm1VgowZMEGT30VYy6TE6qTzthALb8RgfI9sKmD+LGJD34EcL4fIzuv1
	9rCbvIRplVmlH77xCuA=
X-Google-Smtp-Source: AGHT+IEEJYrdib72m4Zd54o8C2PQElqhgx3VdUfzIWfw+vKrrFWoYYZWeaayg47XMVtdM3/Pr5uX8Q==
X-Received: by 2002:a05:6a21:3a4a:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1ee0539ced6mr2495946637.16.1738908691404;
        Thu, 06 Feb 2025 22:11:31 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048bf1504sm2332362b3a.108.2025.02.06.22.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:54 +0900
Subject: [PATCH net-next v6 4/7] tun: Decouple vnet handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-4-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

Decouple the vnet handling code so that we can reuse it for tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 237 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 139 insertions(+), 98 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 28a1af1de9d704ed5cc51aac3d99bc095cb28ba5..a52c5d00e75c28bb1574f07f59be9f96702a6f0a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -352,6 +352,127 @@ static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
 	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
 }
 
+static long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
+			   unsigned int cmd, int __user *sp)
+{
+	int s;
+
+	switch (cmd) {
+	case TUNGETVNETHDRSZ:
+		s = *vnet_hdr_sz;
+		if (put_user(s, sp))
+			return -EFAULT;
+		return 0;
+
+	case TUNSETVNETHDRSZ:
+		if (get_user(s, sp))
+			return -EFAULT;
+		if (s < (int)sizeof(struct virtio_net_hdr))
+			return -EINVAL;
+
+		*vnet_hdr_sz = s;
+		return 0;
+
+	case TUNGETVNETLE:
+		s = !!(*flags & TUN_VNET_LE);
+		if (put_user(s, sp))
+			return -EFAULT;
+		return 0;
+
+	case TUNSETVNETLE:
+		if (get_user(s, sp))
+			return -EFAULT;
+		if (s)
+			*flags |= TUN_VNET_LE;
+		else
+			*flags &= ~TUN_VNET_LE;
+		return 0;
+
+	case TUNGETVNETBE:
+		return tun_get_vnet_be(*flags, sp);
+
+	case TUNSETVNETBE:
+		return tun_set_vnet_be(flags, sp);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
+			    struct virtio_net_hdr *hdr)
+{
+	u16 hdr_len;
+
+	if (iov_iter_count(from) < sz)
+		return -EINVAL;
+
+	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
+		return -EFAULT;
+
+	hdr_len = tun16_to_cpu(flags, hdr->hdr_len);
+
+	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		hdr_len = max(tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2, hdr_len);
+		hdr->hdr_len = cpu_to_tun16(flags, hdr_len);
+	}
+
+	if (hdr_len > iov_iter_count(from))
+		return -EINVAL;
+
+	iov_iter_advance(from, sz - sizeof(*hdr));
+
+	return hdr_len;
+}
+
+static int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+			    const struct virtio_net_hdr *hdr)
+{
+	if (unlikely(iov_iter_count(iter) < sz))
+		return -EINVAL;
+
+	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
+		return -EFAULT;
+
+	iov_iter_advance(iter, sz - sizeof(*hdr));
+
+	return 0;
+}
+
+static int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
+			       const struct virtio_net_hdr *hdr)
+{
+	return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flags));
+}
+
+static int tun_vnet_hdr_from_skb(unsigned int flags,
+				 const struct net_device *dev,
+				 const struct sk_buff *skb,
+				 struct virtio_net_hdr *hdr)
+{
+	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+
+	if (virtio_net_hdr_from_skb(skb, hdr,
+				    tun_is_little_endian(flags), true,
+				    vlan_hlen)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		if (net_ratelimit()) {
+			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				   sinfo->gso_type, tun16_to_cpu(flags, hdr->gso_size),
+				   tun16_to_cpu(flags, hdr->hdr_len));
+			print_hex_dump(KERN_ERR, "tun: ",
+				       DUMP_PREFIX_NONE,
+				       16, 1, skb->head,
+				       min(tun16_to_cpu(flags, hdr->hdr_len), 64), true);
+		}
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static inline u32 tun_hashfn(u32 rxhash)
 {
 	return rxhash & TUN_MASK_FLOW_ENTRIES;
@@ -1765,25 +1886,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (tun->flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
-		int flags = tun->flags;
-
-		if (len < vnet_hdr_sz)
-			return -EINVAL;
-		len -= vnet_hdr_sz;
-
-		if (!copy_from_iter_full(&gso, sizeof(gso), from))
-			return -EFAULT;
-
-		hdr_len = tun16_to_cpu(flags, gso.hdr_len);
 
-		if (gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-			hdr_len = max(tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2, hdr_len);
-			gso.hdr_len = cpu_to_tun16(flags, hdr_len);
-		}
+		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
+		if (hdr_len < 0)
+			return hdr_len;
 
-		if (hdr_len > len)
-			return -EINVAL;
-		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
+		len -= vnet_hdr_sz;
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
@@ -1857,7 +1965,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun->flags))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2052,18 +2160,15 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 {
 	int vnet_hdr_sz = 0;
 	size_t size = xdp_frame->len;
-	size_t ret;
+	ssize_t ret;
 
 	if (tun->flags & IFF_VNET_HDR) {
 		struct virtio_net_hdr gso = { 0 };
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
-		if (unlikely(iov_iter_count(iter) < vnet_hdr_sz))
-			return -EINVAL;
-		if (unlikely(copy_to_iter(&gso, sizeof(gso), iter) !=
-			     sizeof(gso)))
-			return -EFAULT;
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		if (ret)
+			return ret;
 	}
 
 	ret = copy_to_iter(xdp_frame->data, size, iter) + vnet_hdr_sz;
@@ -2086,6 +2191,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
+	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2111,33 +2217,14 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
-		int flags = tun->flags;
-
-		if (iov_iter_count(iter) < vnet_hdr_sz)
-			return -EINVAL;
-
-		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(flags), true,
-					    vlan_hlen)) {
-			struct skb_shared_info *sinfo = skb_shinfo(skb);
-
-			if (net_ratelimit()) {
-				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-					   sinfo->gso_type, tun16_to_cpu(flags, gso.gso_size),
-					   tun16_to_cpu(flags, gso.hdr_len));
-				print_hex_dump(KERN_ERR, "tun: ",
-					       DUMP_PREFIX_NONE,
-					       16, 1, skb->head,
-					       min((int)tun16_to_cpu(flags, gso.hdr_len), 64), true);
-			}
-			WARN_ON_ONCE(1);
-			return -EINVAL;
-		}
 
-		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
-			return -EFAULT;
+		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		if (ret)
+			return ret;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		if (ret)
+			return ret;
 	}
 
 	if (vlan_hlen) {
@@ -2497,7 +2584,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun->flags))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -3081,8 +3168,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	kgid_t group;
 	int ifindex;
 	int sndbuf;
-	int vnet_hdr_sz;
-	int le;
 	int ret;
 	bool do_notify = false;
 
@@ -3289,50 +3374,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		tun_set_sndbuf(tun);
 		break;
 
-	case TUNGETVNETHDRSZ:
-		vnet_hdr_sz = tun->vnet_hdr_sz;
-		if (copy_to_user(argp, &vnet_hdr_sz, sizeof(vnet_hdr_sz)))
-			ret = -EFAULT;
-		break;
-
-	case TUNSETVNETHDRSZ:
-		if (copy_from_user(&vnet_hdr_sz, argp, sizeof(vnet_hdr_sz))) {
-			ret = -EFAULT;
-			break;
-		}
-		if (vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		tun->vnet_hdr_sz = vnet_hdr_sz;
-		break;
-
-	case TUNGETVNETLE:
-		le = !!(tun->flags & TUN_VNET_LE);
-		if (put_user(le, (int __user *)argp))
-			ret = -EFAULT;
-		break;
-
-	case TUNSETVNETLE:
-		if (get_user(le, (int __user *)argp)) {
-			ret = -EFAULT;
-			break;
-		}
-		if (le)
-			tun->flags |= TUN_VNET_LE;
-		else
-			tun->flags &= ~TUN_VNET_LE;
-		break;
-
-	case TUNGETVNETBE:
-		ret = tun_get_vnet_be(tun->flags, argp);
-		break;
-
-	case TUNSETVNETBE:
-		ret = tun_set_vnet_be(&tun->flags, argp);
-		break;
-
 	case TUNATTACHFILTER:
 		/* Can be set only for TAPs */
 		ret = -EINVAL;
@@ -3388,7 +3429,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
 		break;
 	}
 

-- 
2.48.1


