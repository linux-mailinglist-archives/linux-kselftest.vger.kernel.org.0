Return-Path: <linux-kselftest+bounces-24630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2C8A134E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400277A030B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8FD1DE2CF;
	Thu, 16 Jan 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1yYQSzUe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAE1DE2C6
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014961; cv=none; b=LHA9Zzn9nRIQB2oeQSZ4NPB0ecu2LO/E4nQBaZ4VkEScZ26IdawrCH/i2NjSxr1sCiwHQ9oBW5czBokq6MSKFP02Wyjn5hmgJACh9Yr7rV/4CnsE+ofI7myg6D9OA6H3K9L55G9DBrtnPzWYcRP1TKFiq1j7sT82QLUbSw8+5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014961; c=relaxed/simple;
	bh=6i5mOKP9NEm5Jj1SahJJsaXvJcRAMKAZum6TzL+GnIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=QN5y3Ji28hLKgoYt2ogB7F3qNN6hykzalLSaJ6H6tPqUa7iKjI7bjlGT7eHqwEg6MMp+212a3xglmcEdiM0l8xuLt2dQ6heyheaKFJf8/WUlLBl9oipYy4ctT/ndEm3CmCqJJMd1otOmyLx0Til4kNaE8BQW0WxZ4OouS4ZrJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1yYQSzUe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b1f05caso10329345ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014958; x=1737619758; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiInKuLfMqKsNEEbrCxZt89s3ayXkt/ecAhGBDrf+VA=;
        b=1yYQSzUeUNn68La+ji6fLUUBl1HoylfFNy+JlJ1L1Q/3xhn+yr05jEhyclpziuTPRq
         YqiYnatZ4KEHfhFoy3SoI9Qm22i9PU0TVcipAgPJsoWjsloF1ZPgLCAhU7icxkFZc7Qf
         d5FUpXzJjLa3qMeAHBMEpEmebByHFqD86W2LB8Oc7NhJGAQ46mUwGrhqP2ffAry9wTrk
         G2VOI8/osQhaogCCUyJoRIvsqWfOno0OeW4MmoIjLsXH63tHJICrWe25Qaj9FasihyS4
         f2Kzr7atFNm8FfKw65eZ7ow9t1BZPJhyXfFaylTemplXK3rVSq8GvOo8f+ZmimQ+xsec
         pYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014958; x=1737619758;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiInKuLfMqKsNEEbrCxZt89s3ayXkt/ecAhGBDrf+VA=;
        b=bk3TZH668XV239pQglStYF2TseRgFFkUY6zodk6SHNln86WWJJJxiNEVehjR3KJTKy
         yL2SnUIKdvgJ8C3tKtm9vR8lIq2b4hUufSm58ePfatLwbNhA1UlqGs9TxTPEOk9GepUF
         /OLPmCUEsx+vGsKm8U6JbDVbMKTwPp2R6/KRl9+2UKqqww1e/lHcyfU38eYiB3H4IcdL
         EpVPxpY30yI8tRFIngW+MBopNChJwaaR57ozr8BtQqAgq5pDsFmUorNonBR1k9oLbU3C
         lUjydURP84YWCkqGIsymDiLcN550VLvpBpORUnF7Dlxvjfb4nqwLY9sYbnYuqL448y1M
         ti6A==
X-Forwarded-Encrypted: i=1; AJvYcCVu2TjIdDPrrriWa2OdbQR29uZ0VJ+J0jOCXQbqtr+Dcw6RCzLDmW8cxuCC8bVG0P4O+LBo+Y1ZYXoHMm1IYIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXqk4AOk6kL+bw3K5rxf7+CyBGIU5uEn2/EbquJTAdrR8QPMO
	UR5N7FtQwIP2lFtGh6O2x9kFAqHA2HM/wFIPZ2bZ3FKkYiHZYU252Rrt1GKf8L4=
X-Gm-Gg: ASbGncveTHX2Za8HDhvNm9zs39DvGsojt0m5n82LJSweD9PU/6PWLeZCl1xt670MLzh
	jOjGtt+pdUqjxxxxfkH//tafNDidCnHfV8UCqHDsyDTexulI2rJ5VR4yTzegcM3xj6bRCeOpJAn
	qiIId77InyFI5vYKlYpmijqWzBpOBeUyZcnw9brU2FsrqmMOYSsfFzFAV/v8HMeUwzALLXKE3Bk
	PAGjsme5qVv5o5vFUlqaP7ZHRzgJP9HtLx+NH9VIKAAbdtFHhbhppjPonc=
X-Google-Smtp-Source: AGHT+IGJzSwImNIfquXyLNzCaVVwBlahL6/50pPE614F74j7F/f8Q6sh9sDyyPJxHr17hO0VTanhOA==
X-Received: by 2002:a05:6a00:3287:b0:725:456e:76e with SMTP id d2e1a72fcca58-72d21fb1d3fmr44761330b3a.6.1737014958621;
        Thu, 16 Jan 2025 00:09:18 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d405943f1sm10202787b3a.84.2025.01.16.00.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:09 +0900
Subject: [PATCH net v3 6/9] tun: Extract the vnet handling code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-6-c6b2871e97f7@daynix.com>
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

The vnet handling code will be reused by tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS            |   2 +-
 drivers/net/Makefile   |   3 +-
 drivers/net/tun.c      | 174 +-----------------------------------------------
 drivers/net/tun_vnet.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  25 +++++++
 5 files changed, 205 insertions(+), 174 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a..bc32b7e23c79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23902,7 +23902,7 @@ W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
 F:	arch/um/os-Linux/drivers/
 F:	drivers/net/tap.c
-F:	drivers/net/tun.c
+F:	drivers/net/tun*
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5..bb8eb3053772 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -29,7 +29,8 @@ obj-y += mdio/
 obj-y += pcs/
 obj-$(CONFIG_RIONET) += rionet.o
 obj-$(CONFIG_NET_TEAM) += team/
-obj-$(CONFIG_TUN) += tun.o
+obj-$(CONFIG_TUN) += tun-drv.o
+tun-drv-y := tun.o tun_vnet.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1f4a066ad2f0..21abd3613cac 100644
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
@@ -298,175 +297,6 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-static inline bool tun_legacy_is_little_endian(unsigned int flags)
-{
-	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
-		 (flags & TUN_VNET_BE)) &&
-		virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(unsigned int flags, int __user *argp)
-{
-	int be = !!(flags & TUN_VNET_BE);
-
-	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
-		return -EINVAL;
-
-	if (put_user(be, argp))
-		return -EFAULT;
-
-	return 0;
-}
-
-static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
-{
-	int be;
-
-	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
-		return -EINVAL;
-
-	if (get_user(be, argp))
-		return -EFAULT;
-
-	if (be)
-		*flags |= TUN_VNET_BE;
-	else
-		*flags &= ~TUN_VNET_BE;
-
-	return 0;
-}
-
-static inline bool tun_is_little_endian(unsigned int flags)
-{
-	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
-}
-
-static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
-{
-	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
-}
-
-static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
-{
-	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
-}
-
-static long tun_vnet_ioctl(int *sz, unsigned int *flags,
-			   unsigned int cmd, int __user *sp)
-{
-	int s;
-
-	switch (cmd) {
-	case TUNGETVNETHDRSZ:
-		s = *sz;
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
-		*sz = s;
-		return 0;
-
-	case TUNGETVNETLE:
-		s = !!(*flags & TUN_VNET_LE);
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETLE:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s)
-			*flags |= TUN_VNET_LE;
-		else
-			*flags &= ~TUN_VNET_LE;
-		return 0;
-
-	case TUNGETVNETBE:
-		return tun_get_vnet_be(*flags, sp);
-
-	case TUNSETVNETBE:
-		return tun_set_vnet_be(flags, sp);
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
-			    struct virtio_net_hdr *hdr)
-{
-	if (iov_iter_count(from) < sz)
-		return -EINVAL;
-
-	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
-		return -EFAULT;
-
-	if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-	    tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2 > tun16_to_cpu(flags, hdr->hdr_len))
-		hdr->hdr_len = cpu_to_tun16(flags, tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2);
-
-	if (tun16_to_cpu(flags, hdr->hdr_len) > iov_iter_count(from))
-		return -EINVAL;
-
-	iov_iter_advance(from, sz - sizeof(*hdr));
-
-	return tun16_to_cpu(flags, hdr->hdr_len);
-}
-
-static int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-			    const struct virtio_net_hdr *hdr)
-{
-	if (unlikely(iov_iter_count(iter) < sz))
-		return -EINVAL;
-
-	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
-		return -EFAULT;
-
-	iov_iter_advance(iter, sz - sizeof(*hdr));
-
-	return 0;
-}
-
-static int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
-			       const struct virtio_net_hdr *hdr)
-{
-	return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flags));
-}
-
-static int tun_vnet_hdr_from_skb(unsigned int flags,
-				 const struct net_device *dev,
-				 const struct sk_buff *skb,
-				 struct virtio_net_hdr *hdr)
-{
-	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
-
-	if (virtio_net_hdr_from_skb(skb, hdr,
-				    tun_is_little_endian(flags), true,
-				    vlan_hlen)) {
-		struct skb_shared_info *sinfo = skb_shinfo(skb);
-
-		if (net_ratelimit()) {
-			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-				   sinfo->gso_type, tun16_to_cpu(flags, hdr->gso_size),
-				   tun16_to_cpu(flags, hdr->hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min(tun16_to_cpu(flags, hdr->hdr_len), 64), true);
-		}
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static inline u32 tun_hashfn(u32 rxhash)
 {
 	return rxhash & TUN_MASK_FLOW_ENTRIES;
diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
new file mode 100644
index 000000000000..5a6cbfb6eed0
--- /dev/null
+++ b/drivers/net/tun_vnet.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "tun_vnet.h"
+
+/* High bits in flags field are unused. */
+#define TUN_VNET_LE     0x80000000
+#define TUN_VNET_BE     0x40000000
+
+static inline bool tun_legacy_is_little_endian(unsigned int flags)
+{
+	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		 (flags & TUN_VNET_BE)) &&
+		virtio_legacy_is_little_endian();
+}
+
+static long tun_get_vnet_be(unsigned int flags, int __user *argp)
+{
+	int be = !!(flags & TUN_VNET_BE);
+
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
+	if (put_user(be, argp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
+{
+	int be;
+
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
+	if (get_user(be, argp))
+		return -EFAULT;
+
+	if (be)
+		*flags |= TUN_VNET_BE;
+	else
+		*flags &= ~TUN_VNET_BE;
+
+	return 0;
+}
+
+static inline bool tun_is_little_endian(unsigned int flags)
+{
+	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
+}
+
+static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
+{
+	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
+}
+
+static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
+{
+	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
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
+int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
+		     struct virtio_net_hdr *hdr)
+{
+	if (iov_iter_count(from) < sz)
+		return -EINVAL;
+
+	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
+		return -EFAULT;
+
+	if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
+	    tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2 > tun16_to_cpu(flags, hdr->hdr_len))
+		hdr->hdr_len = cpu_to_tun16(flags, tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2);
+
+	if (tun16_to_cpu(flags, hdr->hdr_len) > iov_iter_count(from))
+		return -EINVAL;
+
+	iov_iter_advance(from, sz - sizeof(*hdr));
+
+	return tun16_to_cpu(flags, hdr->hdr_len);
+}
+
+int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+		     const struct virtio_net_hdr *hdr)
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
+int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
+			const struct virtio_net_hdr *hdr)
+{
+	return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flags));
+}
+
+int tun_vnet_hdr_from_skb(unsigned int flags,
+			  const struct net_device *dev,
+			  const struct sk_buff *skb,
+			  struct virtio_net_hdr *hdr)
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
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
new file mode 100644
index 000000000000..a8d6e4749333
--- /dev/null
+++ b/drivers/net/tun_vnet.h
@@ -0,0 +1,25 @@
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
+int tun_vnet_hdr_from_skb(unsigned int flags,
+			  const struct net_device *dev,
+			  const struct sk_buff *skb,
+			  struct virtio_net_hdr *hdr);
+
+#endif /* TUN_VNET_H */

-- 
2.47.1


