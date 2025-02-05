Return-Path: <linux-kselftest+bounces-25805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC68A2845E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5521882523
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491C22A4E9;
	Wed,  5 Feb 2025 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="hEgExfB9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22122A4E2
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736584; cv=none; b=ATVjFLwNlJQsmMwdmceaEwotau3BXJFEzxEfuk3Yjq1hCGzjx4vUZkCyrJuYAlpuR016yvvQY0Uxs0KFAmkMzEisxIAOiiD+46q5zE/4TG8tq6eQHeO8VGcnEqYlpx+WuKRdP2Diuny9A42DJDGzVPm/iHzy+/xRn0GZFq9kWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736584; c=relaxed/simple;
	bh=1kfwXowcu8r3IMQTXe7PLhRBVMfknEmCsLcWG6R/qn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiMRk9c6roNbzSAcmMBMObw6rtHh+9kTpFk4Ndo2EKaXz5YDUM/kgWkoYyLHZcHl1q3sMTabsmxdB73nlVQp1WB2q1ZhdbW7ea+7P26ZMxdIUfncBb60z+vVJ6Ket4MtTwn/ny3DYhrh4Wgcy+P3fGYIUx8lLmnqt+rhoEojkGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=hEgExfB9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21effc750d2so26347515ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 22:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736582; x=1739341382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdteCPyxaLnTbFrQqSLEpLkKaGkxVoLiFLjqkZyLOko=;
        b=hEgExfB9gMwg6CbDpuv+o1DVYjlX8gS6Lj36vYVR5me5hZVwBf1u7P7K24Bggw6I9S
         YdsD1xSyQ1N9ACfsjx4qn4cL+aR6j9VQQbwht1RxhpJ1Gk/XgTW1GX/vKdYW4+Fn62uE
         fryC66DA7RJsJaSutSconObDWt3gLOHnB02lF0dLv9Gr/UmyX+9Gokr4d9MvFLVQonBs
         IiRu0A3AfEGSfkN5HlxtzNi4KIM1Cqpkidufn1Nuuos3vc1IHdbch2tuahAJ6XT1rOVD
         yoSYg7JFw4bjWFRYYChz6SRxQIpgfBjF61b0SlhdqhLbdw4tt7oMC6PVv/Ni/7cR8JYn
         +eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736582; x=1739341382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdteCPyxaLnTbFrQqSLEpLkKaGkxVoLiFLjqkZyLOko=;
        b=uVS178cYtebc5QsuBlGg6ecjXeqDoQocH8TK+HrI5vo9OIQd0GuzeVh4iePQSfooP9
         k/0Ohu+VvlWMdtA4OhT44PnWctwX3eVLlm7vA+Op2GYNDIWfmsNMo4yDVd2SdxLTarFP
         yaBCfFo2iAjiQkiOksS0PZkjWStGRuVpJOsG8vDlTkA7FBX9JSU+AtDytgJWSMJq45lU
         FCZarRZPCuscI+24gJGKgJPm4bTlxO+G7VtM4YTKtCBwfxW9xwtzKjs6wsr/86+F0VTm
         sZIAY7WIr4Vpe//XGJZ6k0CUdf4OKRrRpcwDLK98N7Ar5I4dXWmj2+d1ZXNSZXc05OaO
         Rxfg==
X-Forwarded-Encrypted: i=1; AJvYcCWTtxd4z6RsTBCERfsLT6v6i3liuyhIkcx6A2RT0Rz99LmxSslFhRVD1HdGqEigTPieSsl8bC+X9+vOPEwfjGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2YXatrzxwPpEYRTpU0kPwlN7WEcC4t4tp9IwVJGpLAkd2XzQl
	7keFkCOY0r+DauxNE7R4K2W3s+ZUNLCKoaMvFshJ+nihT+KgplLizdiTBXyrgf8=
X-Gm-Gg: ASbGncsMzhoDtVVAret2u1Jt5h4FfgFlF/XgJRFDoru/h0Cax20wwNUKykJ9vT9JB5t
	88UxV1gXU+DlHA5ubX6qta42pAQ/QIWgWNpzlIwkhvZ1lah1cmLt+8TRZ+nk98i5kISK8OZIcJ1
	xR3WPH+UjRP+33S5UCcPrwCYDlvECArfIlQweWen3XDzRFZ4ejyjlZ0g7oHuIMh1UZ15pomZtAM
	WGmVADYGjdz9wjYYKVn6TqqLQFd1fzgd3oqwza5f+6R+CCuSw6VfO/rVSrDTzPiAOpEduXkIgCY
	Hh0rUEUZlNaELtYPkCI=
X-Google-Smtp-Source: AGHT+IGS0p/woIeC+Ecmgux0bdZYtHmzuFlzAKlhJ7xY0Zf9qFKBQod0Xje6b5F5RjRzDrSuFL9Qwg==
X-Received: by 2002:a17:903:41cf:b0:215:9d58:6f35 with SMTP id d9443c01a7336-21f17dde0f5mr30415915ad.1.1738736581697;
        Tue, 04 Feb 2025 22:23:01 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de31f7554sm107377935ad.81.2025.02.04.22.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:23:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:26 +0900
Subject: [PATCH net-next v5 4/7] tun: Decouple vnet handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-4-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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
index 8ddd4b352f0307e52cdff75254b5ac1d259d51f8..5bd1c21032ed673ba8e39dd5a488cce11599855b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -351,6 +351,127 @@ static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
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
@@ -1764,25 +1885,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
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
@@ -1856,7 +1964,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun->flags))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2051,18 +2159,15 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
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
@@ -2085,6 +2190,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
+	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2110,33 +2216,14 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
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
@@ -2496,7 +2583,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun->flags))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -3080,8 +3167,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	kgid_t group;
 	int ifindex;
 	int sndbuf;
-	int vnet_hdr_sz;
-	int le;
 	int ret;
 	bool do_notify = false;
 
@@ -3288,50 +3373,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -3387,7 +3428,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
 		break;
 	}
 

-- 
2.48.1


