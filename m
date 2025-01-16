Return-Path: <linux-kselftest+bounces-24633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBE1A134FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C7E3A406E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E71DE8AE;
	Thu, 16 Jan 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="nn8iK0Gl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ABF1D63EB
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014984; cv=none; b=A4ZMooLglHl7uuBD5rBp/gQ02w/p3oAFxqy1fO355TN1yuAs0ff6+I3xFc6WOj7nK9BJpFAxGldh/kyWuEmbsghEwMvAxbrooBmjbL1cnhbqB9OLL7Nb97Pv8S8rgOhEWGamhQ7y7n4izxC+GGtab8smNg58wVQHimaldKfrQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014984; c=relaxed/simple;
	bh=6Wr52ljDSK+aBTylI+KGQ0tUL4zR+wFOHt7DCtuiU4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=tU5ZgIXKNQ5g7FldRbPH8I6jzJ9vfSKnSxozwHc8ua4EkJoczz9+oHsd//83C/nKHZiRWEGqe1KT1m7m0rgt9FOn9dEDNn1NGv/PF8wXlw8mxm6WTtdzsixtQJS6GkvU2y8UIqjMCzTKz0BHaByOYFKXI2kr6mwvo6/2tWKtUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=nn8iK0Gl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2874207a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014981; x=1737619781; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ihEjoAUKBeuLlSZwwwgZEpokxJoyJJceF/H232NOa0=;
        b=nn8iK0GlMjp78+GXSs3iKk5aV+GAjV0gnh2ckGOtl59DT7RORFZDGqczu3XB7Uf3Dr
         dj9roNkaBlK8F0NuYIMX9ZT48sdso9DLY6fGGSypfjwUTJwzt1qhJCRiUjxLjhtiSpwj
         LbNrL1T2LJ1GB8GwLe6+jY3WetKKgyI3mAoBM0YIt+YzP99sH53xQIBimsmZ1rSTGYBW
         zQ1c1nvI+b1i4MxRNnrT8H8UGWEiSt/utRwbSVMTJDMRiFzHFO1h2iWMe38875C7424s
         Yt821cpa1x2K4pxW07aHnzxY+VdKf8as2L9vXcfe50rOUmNwgEyvyepDDXtEljmaqeNr
         R0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014981; x=1737619781;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ihEjoAUKBeuLlSZwwwgZEpokxJoyJJceF/H232NOa0=;
        b=Xf8aMvAdNYj2oxvTNSjGHD4XImaIBG5T8fOdoW67pZbIwK2G8VxjY5/gUtGUnM3ZfV
         4TOtEXFIfoNfUhTZmSR2KsCWuMwKoAlaPwPRFUNuAo0bLpgk8hPnz2EVf2bFWVexs3Uq
         FuTUVM8nSbdYPfBGQgssk4iClYyJC4+szyPnBXmBThCySUrSaFygIoRixkB3NzBmF7hY
         5yeHJlMsNcA0y+ReiyJhh3BOdQhk0OYuNsn79+N0zQ40hKn51xlR2doG7j/P6U2ISHEr
         7rI6zdInSxovI7i11zEpTBSzJ1zFAR2apFMU+x4BGoWtUm4krCWL+Aag6a0Hgb2U2BW9
         zqzw==
X-Forwarded-Encrypted: i=1; AJvYcCVSeP+ZdsxF0gP2vJcdHyssqlV2ZIZdMSX5tjZNQbsxe4y0J0l2NzTqDRviEumFscrqlYfsyve4irhnVRNzi+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YygY+dh7E9plJJUG9ewZuWsntgQzhJh8A+lq4UoH9gwW8bIRXFG
	2wanvubehdpqByilXNsAThivmvIyPsmh7FHDalBgc3Ny+qw+iKKBn51kODowZZE=
X-Gm-Gg: ASbGncvdfS6J8To4nX0//2abn1VqslOj708yVB2Z/ghmvifQ4nTnAmGP5U+ictudCgX
	hi6/Vx/TF4MenS1/tKoAUdHRlxKd/XzJIXeqPDuABDlSSy+NYJOq/L2TZIG+HACQ5n8eyApbdv7
	oYI2bC+6oVcY7gqv2UYtg9t2imYdsRLCYBx3cTqvvAHEujNhL+FtGG+3YNRhiBT3aR0qDW6yiLP
	8qpqqO1w8z8jCilR+EV2QOOJwBf9K6SkvUzX7ALAC3j515NoNaLn3egKzw=
X-Google-Smtp-Source: AGHT+IGBd3wFyaxz28Bg190hwNC79Eeep+dLLbG4FFSW/Blv0bNRKR2iKwdIv4qJU0FrPxu3LDQuhQ==
X-Received: by 2002:a17:90a:fc4f:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2f728e1d11amr9622335a91.15.1737014980551;
        Thu, 16 Jan 2025 00:09:40 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f72c1e383esm2693388a91.30.2025.01.16.00.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:12 +0900
Subject: [PATCH net v3 9/9] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3

tun and tap implements the same vnet-related features so reuse the code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/Kconfig    |   1 +
 drivers/net/Makefile   |   6 +-
 drivers/net/tap.c      | 152 +++++--------------------------------------------
 drivers/net/tun_vnet.c |   5 ++
 4 files changed, 24 insertions(+), 140 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6..c420418473fc 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -395,6 +395,7 @@ config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on INET
 	select CRC32
+	select TAP
 	help
 	  TUN/TAP provides packet reception and transmission for user space
 	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index bb8eb3053772..2275309a97ee 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -29,9 +29,9 @@ obj-y += mdio/
 obj-y += pcs/
 obj-$(CONFIG_RIONET) += rionet.o
 obj-$(CONFIG_NET_TEAM) += team/
-obj-$(CONFIG_TUN) += tun-drv.o
-tun-drv-y := tun.o tun_vnet.o
-obj-$(CONFIG_TAP) += tap.o
+obj-$(CONFIG_TUN) += tun.o
+obj-$(CONFIG_TAP) += tap-drv.o
+tap-drv-y := tap.o tun_vnet.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VXLAN) += vxlan/
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 7ee2e9ee2a89..4f3cc3b2e3c6 100644
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
diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
index 5a6cbfb6eed0..960a5fa5a332 100644
--- a/drivers/net/tun_vnet.c
+++ b/drivers/net/tun_vnet.c
@@ -104,6 +104,7 @@ long tun_vnet_ioctl(int *sz, unsigned int *flags,
 		return -EINVAL;
 	}
 }
+EXPORT_SYMBOL_GPL(tun_vnet_ioctl);
 
 int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 		     struct virtio_net_hdr *hdr)
@@ -125,6 +126,7 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 
 	return tun16_to_cpu(flags, hdr->hdr_len);
 }
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 		     const struct virtio_net_hdr *hdr)
@@ -139,12 +141,14 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_put);
 
 int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 			const struct virtio_net_hdr *hdr)
 {
 	return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flags));
 }
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
 
 int tun_vnet_hdr_from_skb(unsigned int flags,
 			  const struct net_device *dev,
@@ -173,3 +177,4 @@ int tun_vnet_hdr_from_skb(unsigned int flags,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);

-- 
2.47.1


