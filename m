Return-Path: <linux-kselftest+bounces-24096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD89A06E79
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20598167027
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 06:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBC214A73;
	Thu,  9 Jan 2025 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="TEATUIR9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4F214A6F
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405949; cv=none; b=Ey86yiDDR9hee+sLPn3uwXVh7zEuoT9aHNclxBsrEtxIvQNBoHLaGjU6LCeZnKg1HjpqkbbFHj2EW1AZq27jVvdaEzMCWbBBaHYYIHlYEehc5pOoNpu7i1UWEIiapZ4tKCfylJYJ7wXWSlNtGUw+wyFOm99Qd/6ep7egEqhKyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405949; c=relaxed/simple;
	bh=xUh8OsO82Lz+N74mTsrU5GQoEJf86sRiocBQFvqOGTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=fvdyQwTgRbe+kGXDVlocARd/oB/XKAkV5LHZvVw/H+iXz36TZ2Pvv96RI31kVJ4T5duL3I3V3Riw0CfvJScrMMHzl/achfD9vGsumoVlrbnOcAPNSpRgWx5ImkQpFOgRqv2Cr9AfTCqcR95BiV4sVqZ9mCbIXIrxWSgVF7indTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=TEATUIR9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-218c8aca5f1so11686685ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 22:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736405947; x=1737010747; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH2ziWEMe8qysnaJoX6kBUE58VGIgBpa5DNj4QNLj2A=;
        b=TEATUIR9FB2Ho5inyaAn39abOjCmmU5REYBTdQxdOIop94TucxSqgezGjlt6xIMjL5
         LneHzhk8j91zF2jVQW5YCcBXP/y0S5XhaZ73d9VFDcR3h1qAHLbVpBapny8Q+YQY9wsC
         100M23HU+fAbn9kIeVJBtoJf/kGcAm9QK4b6FyXcMJZrAjaR32C1jMzadZEyIlzvfCVU
         r/C33yZ/wPbFeIHAxME74RoK5TqKSxFrqTsMb5fAyf8FZeD+oj4c/+tyybGa/iH6xteI
         zjiZHvr7BLl+UB+YF75ziMXlENRiHTw9rhFvCtJouI9xZIyCE73c8X2SjKk/4zLsWV0m
         DVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736405947; x=1737010747;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH2ziWEMe8qysnaJoX6kBUE58VGIgBpa5DNj4QNLj2A=;
        b=mYg9NyNKxiSjDWkiq69yUah0XjEve7xdoqOWtBGsWpQuaAFDd+7aHYWX4RRMHAaCh4
         I1ztxKf/l/H46gVz9UR9raNlWZU8g+TZhAOR4Rgsh8H9Wtnchc4+nULmQWcvGjoNZGT3
         kYvZqQQ3p9uiWcrnMNYPT88AR9tn1EjdgB3yNDxduM5tD8fsZLumhda8bGSOQVF046oH
         Hoe2jNKZ2lNmephhHsVZFnnGso7HYAGMfzfLNNq1HcpqQo3SZgoQ6zLmcLCyqkrjknKm
         sUGqpwFVZh/rm29qum9YtSbJI+ocu6VUj+8o4JGCKl65Qvu9KHkzp37V3SEr9q/MqODj
         amRg==
X-Forwarded-Encrypted: i=1; AJvYcCUND33MWdXzZSwKEjOo+AEesIgD4FAnza6qNsGruj1Cpn0tweQqsWh3s55ZdagurYDFAdJKswtyKf198ho7sAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYUiGlvtp5eAPy3y3wlxwV8LbguqhgWkGyWJExHAdqykfxFVm
	8YXlE+xAaQpPGShCJnom4wjx2QLdVKIm2xIvd1QgxIWv9kv6k1HiYEPzwjpKwH8=
X-Gm-Gg: ASbGncsh3bN44b1th3nxjVx4nqhYBCrB/Z0RPPFGX5ME9Am05ziVdAtFloan+KPkjwq
	fTeejfzpK1kUNOXFnH4HP3tGJ/z8wFcWThY2H2JI2gNcV5ebAbC3ukpmefVfhtoZJt4A6rLVXGS
	uNlxUGoq70Lru5MebCfFV+WlZCZzRFMt1R0sGWwWOdcyq/1kaIA5KH8TGMwsghkFPgqovE0jnJp
	ZnOGJzQa4s9ANWOC1sP+ba2pTJP3AAD+7ysOb4VM+7e9Xy+ZEBoMyvgVrM=
X-Google-Smtp-Source: AGHT+IGtW0ervT9Zb+HtfnwTwQjuMuiejW0TJN5qMd/qKY7fouxK2oNPYeK2WwBy9LO33JkH3d4YtQ==
X-Received: by 2002:a05:6a20:a109:b0:1e1:d22d:bc01 with SMTP id adf61e73a8af0-1e88d361a7dmr10424069637.30.1736405946586;
        Wed, 08 Jan 2025 22:59:06 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad84cfb3sm36367664b3a.89.2025.01.08.22.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 22:59:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:58:43 +0900
Subject: [PATCH v2 1/3] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-tun-v2-1-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
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

Both tun and tap exposes the same set of virtio-net-related features.
Unify their implementations to ease future changes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS            |   1 +
 drivers/net/Kconfig    |   5 ++
 drivers/net/Makefile   |   1 +
 drivers/net/tap.c      | 172 ++++++----------------------------------
 drivers/net/tun.c      | 208 ++++++++-----------------------------------------
 drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  24 ++++++
 7 files changed, 273 insertions(+), 324 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a..1be8a452d11f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23903,6 +23903,7 @@ F:	Documentation/networking/tuntap.rst
 F:	arch/um/os-Linux/drivers/
 F:	drivers/net/tap.c
 F:	drivers/net/tun.c
+F:	drivers/net/tun_vnet.h
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6..255c8f9f1d7c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -395,6 +395,7 @@ config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on INET
 	select CRC32
+	select TUN_VNET
 	help
 	  TUN/TAP provides packet reception and transmission for user space
 	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
@@ -417,10 +418,14 @@ config TUN
 
 config TAP
 	tristate
+	select TUN_VNET
 	help
 	  This option is selected by any driver implementing tap user space
 	  interface for a virtual interface to re-use core tap functionality.
 
+config TUN_VNET
+	tristate
+
 config TUN_VNET_CROSS_LE
 	bool "Support for cross-endian vnet headers on little-endian kernels"
 	default n
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5..bc1f193eccb1 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -30,6 +30,7 @@ obj-y += pcs/
 obj-$(CONFIG_RIONET) += rionet.o
 obj-$(CONFIG_NET_TEAM) += team/
 obj-$(CONFIG_TUN) += tun.o
+obj-$(CONFIG_TUN_VNET) += tun_vnet.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765..60804855510b 100644
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
 
@@ -1198,7 +1072,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb->protocol = eth_hdr(skb)->h_proto;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
 		if (err)
 			goto err_kfree;
 	}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f..dbf0dee92e93 100644
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
@@ -1752,8 +1687,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
@@ -1764,37 +1700,25 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
 
@@ -1807,7 +1731,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
+		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
 		if (copylen > good_linear)
 			copylen = good_linear;
 		linear = copylen;
@@ -1830,10 +1754,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
@@ -1868,7 +1792,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2061,29 +1985,27 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
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
@@ -2097,6 +2019,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
+	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2123,31 +2046,13 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
@@ -2507,7 +2412,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -3091,8 +2996,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	kgid_t group;
 	int ifindex;
 	int sndbuf;
-	int vnet_hdr_sz;
-	int le;
 	int ret;
 	bool do_notify = false;
 
@@ -3299,50 +3202,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -3398,8 +3257,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = -EINVAL;
-		break;
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
 	}
 
 	if (do_notify)
diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
new file mode 100644
index 000000000000..fe842df9e9ef
--- /dev/null
+++ b/drivers/net/tun_vnet.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "tun_vnet.h"
+
+/* High bits in flags field are unused. */
+#define TUN_VNET_LE 0x80000000
+#define TUN_VNET_BE 0x40000000
+
+static bool tun_vnet_legacy_is_little_endian(unsigned int flags)
+{
+	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
+	       virtio_legacy_is_little_endian();
+}
+
+static long tun_vnet_get_be(int flags, int __user *sp)
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
+static long tun_vnet_set_be(int *flags, int __user *sp)
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
+static bool tun_vnet_is_little_endian(unsigned int flags)
+{
+	return flags & TUN_VNET_LE || tun_vnet_legacy_is_little_endian(flags);
+}
+
+static u16 tun_vnet16_to_cpu(unsigned int flags, __virtio16 val)
+{
+	return __virtio16_to_cpu(tun_vnet_is_little_endian(flags), val);
+}
+
+static __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
+{
+	return __cpu_to_virtio16(tun_vnet_is_little_endian(flags), val);
+}
+
+long tun_vnet_ioctl(int *sz, unsigned int *flags,
+		    unsigned int cmd, int __user *sp)
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
+EXPORT_SYMBOL_GPL(tun_vnet_ioctl);
+
+int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
+		     struct virtio_net_hdr *hdr)
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
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
+
+int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+		     const struct virtio_net_hdr *hdr)
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
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_put);
+
+int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
+			const struct virtio_net_hdr *hdr)
+{
+	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
+}
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
+
+int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
+			  const struct sk_buff *skb,
+			  struct virtio_net_hdr *hdr)
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
+EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
+
+MODULE_DESCRIPTION("Common library for drivers implementing TUN/TAP's virtio-related features");
+MODULE_AUTHOR("Max Krasnyansky <maxk@qualcomm.com>");
+MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
+MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
new file mode 100644
index 000000000000..2dfdbe92bb24
--- /dev/null
+++ b/drivers/net/tun_vnet.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef TUN_VNET_H
+#define TUN_VNET_H
+
+#include <linux/if_tun.h>
+#include <linux/virtio_net.h>
+
+long tun_vnet_ioctl(int *sz, unsigned int *flags,
+		    unsigned int cmd, int __user *sp);
+
+int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
+		     struct virtio_net_hdr *hdr);
+
+int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+		     const struct virtio_net_hdr *hdr);
+
+int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
+			const struct virtio_net_hdr *hdr);
+
+int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
+			  const struct sk_buff *skb,
+			  struct virtio_net_hdr *hdr);
+
+#endif /* TUN_VNET_H */

-- 
2.47.1


