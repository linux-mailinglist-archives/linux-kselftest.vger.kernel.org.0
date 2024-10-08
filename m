Return-Path: <linux-kselftest+bounces-19207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A84994005
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269BE1F25F2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A851E7674;
	Tue,  8 Oct 2024 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vSPiL0hh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFD1E47C2
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370502; cv=none; b=CsTc5f6b+PzxLjquT09zNApfLOQ545Wq9L4E5cFsLJIvBRs02OjPya9K5IiKBjJCNiHyLhtS0p/3LiJjFxxzOg3koYIMf4QLmF/idfb4fqThahqTzy5n0Y1qQq6l1VzKKeBkYDHHdAaLLnvDd+Z/bTv33P0YASr2ScEGxKrXwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370502; c=relaxed/simple;
	bh=1dOAIe36MmwkHa5oWaR7j4Z9yg+Iaxo0VBvk6agmKlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=gn0Kphnfw66dyjwub8dgvrHjuDqOTCbF21w9rmX1UP37GgJ1QhwIe1/KY2TH+p3ymqtYTRmF33cdZlR2CWxXdZoP1ZMJP/sv8rz5nXm2EZAyjc35z6XyynMgsdERUl4w58bGVpruiT9S0ePQk6TDg2WBjorMIDvpvjWnaH9F2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vSPiL0hh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e038f3835so1535262b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370500; x=1728975300; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTju3LvBLdff6+EXieYtg2dw4+S3uLoh0Xf+XZ6en/o=;
        b=vSPiL0hh3sQaejrWUv/VhtZRTw1qck+3My5JFt/s3pTNKCSPdZKOMP7Pj4nPFUVro2
         SuwD3vSmid7rB4AfTD4NykFkXPD/plTD13agkAHXWpRYBJzO6ijYNMm9nlUqXrZKUGb+
         Cp4CmvrKIdScwzyPNRtsS/5PrcwJRBf4xCzLD/UmCjGZ/qkXX2UJ9QM2qqlpqn8SloGa
         vlJ3EY/93EH548RG7tH9kvs83FSA6wgNNn98lZVo67ij+2VdyL6LjeHSvfhl/n7SxESS
         8PfqR0viXsjvvIVDY8Drp/XKaDf1fh+lVRXI7EnGB2N/yA+sDu1YIE5a5OumvLrFBoHC
         tbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370500; x=1728975300;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTju3LvBLdff6+EXieYtg2dw4+S3uLoh0Xf+XZ6en/o=;
        b=nmu7k2w7Ls5s/Wxz4to3OnPDqkUqXcVgd3br/lQ6vfpxONhzsSfLmRhbmJWgge9opN
         BGXQkexKjC0uhRMQNb8e5f7enUJhLkXK/BPP/3SAclCJ/RcdMt6Ua8Uc7C2vhS1Y/lmo
         ixvkVfG8Rkd0qt+cW1G60AUzN5x97jpIgaSxXeu4aTIWM/OKpeTXjB3ZcJhjcVeJ1wok
         dOWHIA9A+ZrG3xCnfVaqsyKk09C0r3S1o5l+CjYWn3hILiewUpMOUfvfUJciQZO+n+xK
         UbSMMeBnUY9T44itDideJrxdnt1npJ3+41BSSF47m8X69nr/RtyBSYZhwsuAfQ3IjwJG
         747w==
X-Forwarded-Encrypted: i=1; AJvYcCXuW2X+n8K18/j8tjlLqIcbVnq/46Tud7WIHqQwjw6+K+Jx9z9Zg0GYEocgCePmZa3NNpMWrXjSiuhVaAmn9xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQm80hQFgDechhYhWcy5BfRMdGalemJf57a0eGqWgLq1e6qft
	x2y5uxVjmqB0oFyY0WbC8FoZiWzdn2d58VNCU8hHfCXPrLgGr1XwgYfL/Sh8u2o=
X-Google-Smtp-Source: AGHT+IFK6q20ASG2OqecviUCMLitEk10h3Mle27Ut7nnDH3NgPavpsZw/Lqn/wY9dZhva/K8mI4sNw==
X-Received: by 2002:a05:6a00:2c5:b0:71d:f215:1d8a with SMTP id d2e1a72fcca58-71df2151f15mr12438717b3a.2.1728370499757;
        Mon, 07 Oct 2024 23:54:59 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d65246sm5462646b3a.169.2024.10.07.23.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:24 +0900
Subject: [PATCH RFC v5 04/10] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-4-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Both tun and tap exposes the same set of virtio-net-related features.
Unify their implementations to ease future changes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS            |   1 +
 drivers/net/tap.c      | 172 ++++++----------------------------------
 drivers/net/tun.c      | 208 ++++++++-----------------------------------------
 drivers/net/tun_vnet.h | 181 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+), 324 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc40a9d9b8cd..209b4e1cccb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23338,6 +23338,7 @@ F:	Documentation/networking/tuntap.rst
 F:	arch/um/os-Linux/drivers/
 F:	drivers/net/tap.c
 F:	drivers/net/tun.c
+F:	drivers/net/tun_vnet.h
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 77574f7a3bd4..9a34ceed0c2c 100644
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
+#include "tun_vnet.h"
 
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
-
-static inline __virtio16 cpu_to_tap16(struct tap_queue *q, u16 val)
-{
-	return __cpu_to_virtio16(tap_is_little_endian(q), val);
-}
+#define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
 
 static struct proto tap_proto = {
 	.name = "tap",
@@ -641,10 +576,10 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	struct sk_buff *skb;
 	struct tap_dev *tap;
 	unsigned long total_len = iov_iter_count(from);
-	unsigned long len = total_len;
+	unsigned long len;
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
-	int vnet_hdr_len = 0;
+	int hdr_len;
 	int copylen = 0;
 	int depth;
 	bool zerocopy = false;
@@ -652,38 +587,20 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	enum skb_drop_reason drop_reason;
 
 	if (q->flags & IFF_VNET_HDR) {
-		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
-
-		err = -EINVAL;
-		if (len < vnet_hdr_len)
-			goto err;
-		len -= vnet_hdr_len;
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
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
+		hdr_len = tun_vnet_hdr_get(READ_ONCE(q->vnet_hdr_sz), q->flags, from, &vnet_hdr);
+		if (hdr_len < 0) {
+			err = hdr_len;
 			goto err;
+		}
+	} else {
+		hdr_len = 0;
 	}
 
-	err = -EINVAL;
-	if (unlikely(len < ETH_HLEN))
-		goto err;
-
+	len = iov_iter_count(from);
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
+		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
 		if (copylen > good_linear)
 			copylen = good_linear;
 		else if (copylen < ETH_HLEN)
@@ -697,7 +614,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
+		linear = hdr_len;
 		if (linear > good_linear)
 			linear = good_linear;
 		else if (linear < ETH_HLEN)
@@ -732,9 +649,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	}
 	skb->dev = tap->dev;
 
-	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q));
+	if (q->flags & IFF_VNET_HDR) {
+		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
 		if (err) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
@@ -797,23 +713,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 		struct virtio_net_hdr vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
-		if (iov_iter_count(iter) < vnet_hdr_len)
-			return -EINVAL;
-
-		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q), true,
-					    vlan_hlen))
-			BUG();
 
-		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
-		    sizeof(vnet_hdr))
-			return -EFAULT;
+		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
+		if (ret < 0)
+			goto done;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
+		if (ret < 0)
+			goto done;
 	}
 	total = vnet_hdr_len;
 	total += skb->len;
@@ -1072,42 +982,6 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
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
@@ -1151,7 +1025,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	default:
-		return -EINVAL;
+		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
 	}
 }
 
@@ -1199,7 +1073,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb->protocol = eth_hdr(skb)->h_proto;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
 		if (err)
 			goto err_kfree;
 	}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..dd8799d19518 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -83,6 +83,8 @@
 #include <linux/uaccess.h>
 #include <linux/proc_fs.h>
 
+#include "tun_vnet.h"
+
 static void tun_default_link_ksettings(struct net_device *dev,
 				       struct ethtool_link_ksettings *cmd);
 
@@ -94,9 +96,6 @@ static void tun_default_link_ksettings(struct net_device *dev,
  * overload it to mean fasync when stored there.
  */
 #define TUN_FASYNC	IFF_ATTACH_QUEUE
-/* High bits in flags field are unused. */
-#define TUN_VNET_LE     0x80000000
-#define TUN_VNET_BE     0x40000000
 
 #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
 		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
@@ -298,70 +297,6 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
-static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
-{
-	return tun->flags & TUN_VNET_BE ? false :
-		virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	int be = !!(tun->flags & TUN_VNET_BE);
-
-	if (put_user(be, argp))
-		return -EFAULT;
-
-	return 0;
-}
-
-static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	int be;
-
-	if (get_user(be, argp))
-		return -EFAULT;
-
-	if (be)
-		tun->flags |= TUN_VNET_BE;
-	else
-		tun->flags &= ~TUN_VNET_BE;
-
-	return 0;
-}
-#else
-static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
-{
-	return virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-
-static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_TUN_VNET_CROSS_LE */
-
-static inline bool tun_is_little_endian(struct tun_struct *tun)
-{
-	return tun->flags & TUN_VNET_LE ||
-		tun_legacy_is_little_endian(tun);
-}
-
-static inline u16 tun16_to_cpu(struct tun_struct *tun, __virtio16 val)
-{
-	return __virtio16_to_cpu(tun_is_little_endian(tun), val);
-}
-
-static inline __virtio16 cpu_to_tun16(struct tun_struct *tun, u16 val)
-{
-	return __cpu_to_virtio16(tun_is_little_endian(tun), val);
-}
-
 static inline u32 tun_hashfn(u32 rxhash)
 {
 	return rxhash & TUN_MASK_FLOW_ENTRIES;
@@ -1751,8 +1686,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct tun_pi pi = { 0, cpu_to_be16(ETH_P_IP) };
 	struct sk_buff *skb;
 	size_t total_len = iov_iter_count(from);
-	size_t len = total_len, align = tun->align, linear;
+	size_t len, align = tun->align, linear;
 	struct virtio_net_hdr gso = { 0 };
+	int hdr_len;
 	int good_linear;
 	int copylen;
 	bool zerocopy = false;
@@ -1763,37 +1699,25 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (!(tun->flags & IFF_NO_PI)) {
-		if (len < sizeof(pi))
+		if (iov_iter_count(from) < sizeof(pi))
 			return -EINVAL;
-		len -= sizeof(pi);
 
 		if (!copy_from_iter_full(&pi, sizeof(pi), from))
 			return -EFAULT;
 	}
 
 	if (tun->flags & IFF_VNET_HDR) {
-		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
-
-		if (len < vnet_hdr_sz)
-			return -EINVAL;
-		len -= vnet_hdr_sz;
-
-		if (!copy_from_iter_full(&gso, sizeof(gso), from))
-			return -EFAULT;
-
-		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
-			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
-
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
-			return -EINVAL;
-		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
+		hdr_len = tun_vnet_hdr_get(READ_ONCE(tun->vnet_hdr_sz), tun->flags, from, &gso);
+		if (hdr_len < 0)
+			return hdr_len;
+	} else {
+		hdr_len = 0;
 	}
 
+	len = iov_iter_count(from);
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1806,7 +1730,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
+		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
 		if (copylen > good_linear)
 			copylen = good_linear;
 		linear = copylen;
@@ -1829,10 +1753,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
+			if (hdr_len > good_linear)
 				linear = good_linear;
 			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+				linear = hdr_len;
 		}
 
 		if (frags) {
@@ -1867,7 +1791,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2060,29 +1984,27 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 				struct xdp_frame *xdp_frame,
 				struct iov_iter *iter)
 {
+	int ret;
 	int vnet_hdr_sz = 0;
 	size_t size = xdp_frame->len;
-	size_t ret;
+	size_t total;
 
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
+		if (ret < 0)
+			return ret;
 	}
 
-	ret = copy_to_iter(xdp_frame->data, size, iter) + vnet_hdr_sz;
+	total = copy_to_iter(xdp_frame->data, size, iter) + vnet_hdr_sz;
 
 	preempt_disable();
-	dev_sw_netstats_tx_add(tun->dev, 1, ret);
+	dev_sw_netstats_tx_add(tun->dev, 1, total);
 	preempt_enable();
 
-	return ret;
+	return total;
 }
 
 /* Put packet to the user space buffer */
@@ -2096,6 +2018,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
+	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2122,31 +2045,13 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
 
-		if (iov_iter_count(iter) < vnet_hdr_sz)
-			return -EINVAL;
-
-		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(tun), true,
-					    vlan_hlen)) {
-			struct skb_shared_info *sinfo = skb_shinfo(skb);
-
-			if (net_ratelimit()) {
-				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-					   tun16_to_cpu(tun, gso.hdr_len));
-				print_hex_dump(KERN_ERR, "tun: ",
-					       DUMP_PREFIX_NONE,
-					       16, 1, skb->head,
-					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
-			}
-			WARN_ON_ONCE(1);
-			return -EINVAL;
-		}
-
-		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
-			return -EFAULT;
+		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		if (ret < 0)
+			goto done;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		if (ret < 0)
+			goto done;
 	}
 
 	if (vlan_hlen) {
@@ -2506,7 +2411,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -3090,8 +2995,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	kgid_t group;
 	int ifindex;
 	int sndbuf;
-	int vnet_hdr_sz;
-	int le;
 	int ret;
 	bool do_notify = false;
 
@@ -3298,50 +3201,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
-		ret = tun_get_vnet_be(tun, argp);
-		break;
-
-	case TUNSETVNETBE:
-		ret = tun_set_vnet_be(tun, argp);
-		break;
-
 	case TUNATTACHFILTER:
 		/* Can be set only for TAPs */
 		ret = -EINVAL;
@@ -3397,8 +3256,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = -EINVAL;
-		break;
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
 	}
 
 	if (do_notify)
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
new file mode 100644
index 000000000000..7c7f3f6d85e9
--- /dev/null
+++ b/drivers/net/tun_vnet.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef TUN_VNET_H
+#define TUN_VNET_H
+
+/* High bits in flags field are unused. */
+#define TUN_VNET_LE 0x80000000
+#define TUN_VNET_BE 0x40000000
+
+static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
+{
+	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
+	       virtio_legacy_is_little_endian();
+}
+
+static inline long tun_vnet_get_be(int flags, int __user *sp)
+{
+	int s = !!(flags & TUN_VNET_BE);
+
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
+	if (put_user(s, sp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline long tun_vnet_set_be(int *flags, int __user *sp)
+{
+	int s;
+
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
+	if (get_user(s, sp))
+		return -EFAULT;
+
+	if (s)
+		*flags |= TUN_VNET_BE;
+	else
+		*flags &= ~TUN_VNET_BE;
+
+	return 0;
+}
+
+static inline bool tun_vnet_is_little_endian(unsigned int flags)
+{
+	return flags & TUN_VNET_LE || tun_vnet_legacy_is_little_endian(flags);
+}
+
+static inline u16 tun_vnet16_to_cpu(unsigned int flags, __virtio16 val)
+{
+	return __virtio16_to_cpu(tun_vnet_is_little_endian(flags), val);
+}
+
+static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
+{
+	return __cpu_to_virtio16(tun_vnet_is_little_endian(flags), val);
+}
+
+static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
+				  unsigned int cmd, int __user *sp)
+{
+	int s;
+
+	switch (cmd) {
+	case TUNGETVNETHDRSZ:
+		s = *sz;
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
+		*sz = s;
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
+		return tun_vnet_get_be(*flags, sp);
+
+	case TUNSETVNETBE:
+		return tun_vnet_set_be(flags, sp);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
+				   struct iov_iter *from,
+				   struct virtio_net_hdr *hdr)
+{
+	if (iov_iter_count(from) < sz)
+		return -EINVAL;
+
+	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
+		return -EFAULT;
+
+	iov_iter_advance(from, sz - sizeof(*hdr));
+	if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
+	    tun_vnet16_to_cpu(flags, hdr->csum_start) +
+	    tun_vnet16_to_cpu(flags, hdr->csum_offset) + 2 >
+		     tun_vnet16_to_cpu(flags, hdr->hdr_len))
+		hdr->hdr_len = cpu_to_tun_vnet16(flags,
+						 tun_vnet16_to_cpu(flags, hdr->csum_start) +
+						 tun_vnet16_to_cpu(flags, hdr->csum_offset) + 2);
+	if (tun_vnet16_to_cpu(flags, hdr->hdr_len) > iov_iter_count(from))
+		return -EINVAL;
+
+	return tun_vnet16_to_cpu(flags, hdr->hdr_len);
+}
+
+static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+				   const struct virtio_net_hdr *hdr)
+{
+	if (iov_iter_count(iter) < sz)
+		return -EINVAL;
+
+	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
+		return -EFAULT;
+
+	iov_iter_advance(iter, sz - sizeof(*hdr));
+
+	return 0;
+}
+
+static inline int tun_vnet_hdr_to_skb(unsigned int flags,
+				      struct sk_buff *skb,
+				      const struct virtio_net_hdr *hdr)
+{
+	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
+}
+
+static inline int tun_vnet_hdr_from_skb(unsigned int flags,
+					const struct net_device *dev,
+					const struct sk_buff *skb,
+					struct virtio_net_hdr *hdr)
+{
+	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+
+	if (virtio_net_hdr_from_skb(skb, hdr,
+				    tun_vnet_is_little_endian(flags), true,
+				    vlan_hlen)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		if (net_ratelimit()) {
+			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->gso_size),
+				   tun_vnet16_to_cpu(flags, hdr->hdr_len));
+			print_hex_dump(KERN_ERR, "tun: ",
+				       DUMP_PREFIX_NONE,
+				       16, 1, skb->head,
+				       min(tun_vnet16_to_cpu(flags, hdr->hdr_len), 64), true);
+		}
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#endif /* TUN_VNET_H */

-- 
2.46.2


