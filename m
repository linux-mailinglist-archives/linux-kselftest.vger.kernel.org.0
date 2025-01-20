Return-Path: <linux-kselftest+bounces-24778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A391A168D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314F03AB3D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F81E0DD9;
	Mon, 20 Jan 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fBNlMWtX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DA1E0DAF
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363711; cv=none; b=nTc5jl5M+oWegkd+OljZfPHsrCF6wm+e3s773HzfMURSriMw0oiW/mjh32lePWWpKbcF1ejcOW6/j6pEsdgvPs6Nzte/xkRlXXFQU5V6nMUj3ohC1K5FM9lfBTdGzP3chB6tgJ7SPW9J2O0lgM2P0qTfsAKLGM85cosw/FrSQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363711; c=relaxed/simple;
	bh=4RYDeWZfgoS8TmhgeuK6a+3aCbA0s+NHcJ7l9i6jOAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=mEkUxDZbNKWEIw0K1zAy/4XeiA76k1r7MkqZsoYMU3RtViuVE4OAvKWsD9D6C9B+mdgcaiwXx4zHuyrFDqom7uETdfAGNnoC8WtEkr3Cv7lO3zWZyLS1u5/3k4gxbtqU/DkimqRx9PDVhB8FPJFQpU0961dh4z71yvEQpYs1MKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fBNlMWtX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so7295069a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363709; x=1737968509; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYG55sKWzGPW6NKcxch300rRfr6veN46k3Y03F9gCrE=;
        b=fBNlMWtX+PBHHjKe2S/zKws5uV9I3GAaa+3poyr8O/tUFSf+3FTflYD+Ztyc2mghPp
         syhxv0RLuwHuXG4+kk9FdB8dXClKHjrPiJ9UD75X2T9KbqMrp6IfEc8Y6ia7wVX0eMnC
         HPQKubKE4J8giNBEM0F97KHdvdx6cYXSzmu360qwzfMsc/dblhlem1paLbNiIVoLy+lz
         L5Dj6WunCF6fsQUBEt8S94IiZlNcSebenoXz2Jk9IJ4KkXROwzWPollX8UxMfUq9rFXe
         ud189hSH3sBlQnAep43USyU8B8YO8QmnHw/n2eOJPtUuHomJBDqKoAsnHxvZnCZtuvOY
         seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363709; x=1737968509;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYG55sKWzGPW6NKcxch300rRfr6veN46k3Y03F9gCrE=;
        b=HviLbtLdjzrWue02OO6ehFwKVnuzAxUVi7gvfnjkwkuUZPurUhFlPFlrflam8tdlpx
         3jvjleiZu2a0fUp1dZsWwpMFXYiKaKfb6wGmWfi9zYZ/YJ7tbgXy0R4axDxq1WoOkr3X
         Z4gc692NZzcIHqGCxvd+p6sEHxbd4b0gqbuarbjM4QlP7Pd5zYPsxJt3qrX4xAvUjp/P
         4i8eF+Y1AxV5HD0hmxDMNhaJiZzI/0wlggMRj+kqdslKSCt3gcoRfshucbCLIS3OcQ7e
         w5ccC5LfioZ48nGqTbMN9AwG7fodhEStNdVxl0SoCATYtU+pADYQH162+noHZcYjN9DJ
         NkHw==
X-Forwarded-Encrypted: i=1; AJvYcCUn8wY1uJkELu3rg3fSip9AL2PsmAY+JW/hr9EMmeqhQab5m7+fdYHCOkHVx4K01uRsxcq3audqF4c5w695zKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+tiHLSafbMsUMYJm2tE8NRwCxxd5DXF8tj9JcvsCoK5ftC/e
	gDAsUPQ9tFvloFd3Q0BiKGtwDgLgLmLHfKNHwGXx6tGdRoIeA9Rhjmxvg87i0f0yY8LGNBnRDPP
	kcn8=
X-Gm-Gg: ASbGnctmOY2ljMbViV38+RluO1lKgEKVaLLdzPRpki36k3/hD6oakXaA+w+FDC+fs8k
	QbXxDxWYDWCCMott7//oCC08vW63Kuc+P2Ate4WISEePWNnoCXlvo9cHT42obx3m0EFjMS4m8t9
	CBXo9fKqRffWXTvJRqAkn7XaF3QUn7AEX/54aH//NIzHEtrQOfmebFXHZjEid+AQXbWwmqybtFH
	xVpDT0Pe15Ce31Ew9nahQJwxDB2LUhcum7l23i4AyObzu0f8oWKpPhv3suN4Hcff/E+vQZ6
X-Google-Smtp-Source: AGHT+IH7uaHJ3ZKJFT5wyFQIBOmBXF2rLZqZWTmgA1OioMPJBHsnSIzsBmwU8qLRFmmzM8vdbtQ0pg==
X-Received: by 2002:a17:90b:274a:b0:2ee:5edc:489 with SMTP id 98e67ed59e1d1-2f782d4ed92mr15866201a91.26.1737363709235;
        Mon, 20 Jan 2025 01:01:49 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f77611d5d1sm7830173a91.4.2025.01.20.01.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:18 +0900
Subject: [PATCH net-next v4 9/9] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-9-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
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
X-Mailer: b4 0.14.2

tun and tap implements the same vnet-related features so reuse the code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/Kconfig |   1 +
 drivers/net/tap.c   | 152 ++++++----------------------------------------------
 2 files changed, 16 insertions(+), 137 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 924bf61f12a49566b26a78f42cea5ca1c48537c5..f8aa35bf8a93ac1c7f76b85919ac110cb06f21fb 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -421,6 +421,7 @@ config TUN
 
 config TAP
 	tristate
+	select TUN_VNET
 	help
 	  This option is selected by any driver implementing tap user space
 	  interface for a virtual interface to re-use core tap functionality.
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 7ee2e9ee2a89fd539b087496b92d2f6198266f44..4f3cc3b2e3c6fb387ee2aaeef54c3faf39d90f10 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -26,74 +26,9 @@
 #include <linux/virtio_net.h>
 #include <linux/skb_array.h>
 
-#define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
-
-#define TAP_VNET_LE 0x80000000
-#define TAP_VNET_BE 0x40000000
-
-#ifdef CONFIG_TUN_VNET_CROSS_LE
-static inline bool tap_legacy_is_little_endian(struct tap_queue *q)
-{
-	return q->flags & TAP_VNET_BE ? false :
-		virtio_legacy_is_little_endian();
-}
-
-static long tap_get_vnet_be(struct tap_queue *q, int __user *sp)
-{
-	int s = !!(q->flags & TAP_VNET_BE);
-
-	if (put_user(s, sp))
-		return -EFAULT;
-
-	return 0;
-}
-
-static long tap_set_vnet_be(struct tap_queue *q, int __user *sp)
-{
-	int s;
-
-	if (get_user(s, sp))
-		return -EFAULT;
-
-	if (s)
-		q->flags |= TAP_VNET_BE;
-	else
-		q->flags &= ~TAP_VNET_BE;
-
-	return 0;
-}
-#else
-static inline bool tap_legacy_is_little_endian(struct tap_queue *q)
-{
-	return virtio_legacy_is_little_endian();
-}
-
-static long tap_get_vnet_be(struct tap_queue *q, int __user *argp)
-{
-	return -EINVAL;
-}
-
-static long tap_set_vnet_be(struct tap_queue *q, int __user *argp)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_TUN_VNET_CROSS_LE */
-
-static inline bool tap_is_little_endian(struct tap_queue *q)
-{
-	return q->flags & TAP_VNET_LE ||
-		tap_legacy_is_little_endian(q);
-}
-
-static inline u16 tap16_to_cpu(struct tap_queue *q, __virtio16 val)
-{
-	return __virtio16_to_cpu(tap_is_little_endian(q), val);
-}
+#include "tun_vnet.h"
 
-static inline __virtio16 cpu_to_tap16(struct tap_queue *q, u16 val)
-{
-	return __cpu_to_virtio16(tap_is_little_endian(q), val);
-}
+#define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
 
 static struct proto tap_proto = {
 	.name = "tap",
@@ -655,25 +590,11 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (q->flags & IFF_VNET_HDR) {
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		err = -EINVAL;
-		if (iov_iter_count(from) < vnet_hdr_len)
-			goto err;
-
-		err = -EFAULT;
-		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
-			goto err;
-		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
-		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		     tap16_to_cpu(q, vnet_hdr.csum_start) +
-		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
-			     tap16_to_cpu(q, vnet_hdr.hdr_len))
-			vnet_hdr.hdr_len = cpu_to_tap16(q,
-				 tap16_to_cpu(q, vnet_hdr.csum_start) +
-				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
-		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
+		hdr_len = tun_vnet_hdr_get(vnet_hdr_len, q->flags, from, &vnet_hdr);
+		if (hdr_len < 0) {
+			err = hdr_len;
 			goto err;
-		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
+		}
 	}
 
 	len = iov_iter_count(from);
@@ -731,8 +652,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	skb->dev = tap->dev;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
 		if (err) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
@@ -795,23 +715,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 		struct virtio_net_hdr vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
-		if (iov_iter_count(iter) < vnet_hdr_len)
-			return -EINVAL;
 
-		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q), true,
-					    vlan_hlen))
-			BUG();
-
-		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
-		    sizeof(vnet_hdr))
-			return -EFAULT;
+		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
+		if (ret)
+			return ret;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
+		if (ret)
+			return ret;
 	}
 	total = vnet_hdr_len;
 	total += skb->len;
@@ -1070,42 +984,6 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		q->sk.sk_sndbuf = s;
 		return 0;
 
-	case TUNGETVNETHDRSZ:
-		s = q->vnet_hdr_sz;
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETHDRSZ:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s < (int)sizeof(struct virtio_net_hdr))
-			return -EINVAL;
-
-		q->vnet_hdr_sz = s;
-		return 0;
-
-	case TUNGETVNETLE:
-		s = !!(q->flags & TAP_VNET_LE);
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETLE:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s)
-			q->flags |= TAP_VNET_LE;
-		else
-			q->flags &= ~TAP_VNET_LE;
-		return 0;
-
-	case TUNGETVNETBE:
-		return tap_get_vnet_be(q, sp);
-
-	case TUNSETVNETBE:
-		return tap_set_vnet_be(q, sp);
-
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
@@ -1149,7 +1027,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	default:
-		return -EINVAL;
+		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
 	}
 }
 
@@ -1196,7 +1074,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb->protocol = eth_hdr(skb)->h_proto;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
 		if (err)
 			goto err_kfree;
 	}

-- 
2.47.1


