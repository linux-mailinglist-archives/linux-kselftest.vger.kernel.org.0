Return-Path: <linux-kselftest+bounces-25808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5ECA28474
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 07:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F621887FAA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B122B8AC;
	Wed,  5 Feb 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="bixQjHby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEB22B5B6
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736607; cv=none; b=o5r/s/qgrAma/FEWRY5Mxe8CTELZmAbYuLpXpFcBm3Z284JdpunBlNvfPp8QWK/HcrGZqBVFv22mBw9C3mGga7yilUk3qVbPlS2fUIIymaMhkAXezZmfudxb1eIS5tpAcRL+poeWFtp7qFrrq9g0YdbGXgT6lSyfOKqUJ8NJzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736607; c=relaxed/simple;
	bh=j0g58kzxP4/vEuyCfLiH4Cm8UrUU1sRmr41Z0gm9CHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=EYDOSVZNmrZ/cmPzWJv1KI0MwlV2Dfb3ZhqvtnHs7PdlyyOYVFjnLnt+suUJIK57UF5BnMMWUHDHRbIfCG3va4sm9Jc5SX0zqnPsPTelJMD0ZhcPTtPwvWhDDcX5tOcpyGQWKeTnC70ReQJTe2BfGvdYOPf8TGQvI0Xh8EBBVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=bixQjHby; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644aca3a0so149463995ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 22:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736604; x=1739341404; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKHFkihW1aXGiNptzm3Sa+/HPN1Hv4LNNLF+gqhLrP8=;
        b=bixQjHbymQM+QC0x/bX3pnR0UTTs8dByyu0UsPKEdxUisLs9b3BfqTFDqxYnUfHAZi
         AznDjO5yFfB0fPSqOF4JYAASt71bj4WVw0HLcAD8Mqi7Z4OZ0UBBCzexh5kyqPw+XCXe
         hIyyTMWMHrdJNK+BcI0biu0D9dpV61Iry+rubRwI9LOGSY7BaOOYXTpqciDSk6cMNGaT
         mgVSoGb9YcBMz5M8AuqYvZ6aSTpbkGAMpjrMcRBV+DGLszBLdkC9CwcBRjuly5rJE1bL
         HTifde/ZBTwyj7eDbguWPeXysZLPxZuRupx9XcFP6gce23iCU299w+bjME6Gm5tH024j
         vB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736604; x=1739341404;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKHFkihW1aXGiNptzm3Sa+/HPN1Hv4LNNLF+gqhLrP8=;
        b=GnoSbNs1q/FDAOCVFPlgQIUCK63hqcevvqH6AaWSvd8bFx8gkHL/GyfpMtUOAJs/Wm
         bIe75L4s9+r0wQEJ8+mtWEE7lPL55F8tISPwUhMEEf/FJ9fO8RYffU+ghGy1At3jykrs
         TaGdcttnY8nwVnowHYB7V0SqyxsMmLQ/RdbLK7ozTSoBothwLPRZMgXT1dtMHkeEhji3
         my/A1NnZgPQuKuQdxLDeeagZxjNjmlSpRCBoi4K/7BKjnt7DAlQa2qv6VEv8aBtYBE0n
         tM/NiEJo0Dscv5PmQ1YKTHiWtPHIUkotxGebb0ZSTXVnSsbGieL0tVMox93z7QempoSY
         Fbiw==
X-Forwarded-Encrypted: i=1; AJvYcCUNlEgVUsQpBzVoQ5XbuGg/zTVP995QLA1uy3ThBYPQ51TzOlm4++sHLRBZU6CuuVD7lCbbbG/g7NY9P/Lkmho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kLqtk7IzAdHaMoVhd1SheYQ/Po+XKZfzZdjvis52HiiprA44
	kUvnUGLz2fEtr3VDJlgZr7hppWCglKUQkd/zs3o3NbIJSh/Zclm1l58QeVuQhWY=
X-Gm-Gg: ASbGncvT3hSMcOLT6DEmRIwyhvMEZizHaMbm0yfcM3ETmwK3NlCR+KOiMkOzqlBuuX6
	vvjNJycc3WnHVhbVDdnBHp3BgJVkXfvZO+RWWuMO9tvAze1eOJo0wnVms+UaiP32/t/hWBwoy1o
	EjT2jmJ27c8sVF+QrBSABrDwjPnKQn6rrkhSKIg/KDkfxp2SaqrLXhog0EJYGrdSVwiZo6MoS+b
	TLS0mL9CuJQQ/eyAvW6764+4g3nnJhldc5z7mdg7yDqqLH8WiwOa9PMZlo0R5O/BdVnjdD2r8NO
	aUPlNIpJI7TIT/pIP/0=
X-Google-Smtp-Source: AGHT+IFZKvlrRVLjtwvw+VdsovlMCszHkLbdku1z+OZ4qORt0cXqSHDLFnqL7kzfZxkVlY66TbVvjw==
X-Received: by 2002:a05:6a00:400b:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-7303510391fmr3462095b3a.3.1738736604537;
        Tue, 04 Feb 2025 22:23:24 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe64275c4sm12127023b3a.61.2025.02.04.22.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:23:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:29 +0900
Subject: [PATCH net-next v5 7/7] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-7-15d0b32e87fa@daynix.com>
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
X-Mailer: b4 0.14.2

tun and tap implements the same vnet-related features so reuse the code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 152 ++++++------------------------------------------------
 1 file changed, 16 insertions(+), 136 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index c55c432bac48d395aebc9ceeaa74f7d07e25af4c..40b077aa639be03cf5a6e9a85734833b289f6b86 100644
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
@@ -655,25 +590,13 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (q->flags & IFF_VNET_HDR) {
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		err = -EINVAL;
-		if (len < vnet_hdr_len)
+		hdr_len = tun_vnet_hdr_get(vnet_hdr_len, q->flags, from, &vnet_hdr);
+		if (hdr_len < 0) {
+			err = hdr_len;
 			goto err;
-		len -= vnet_hdr_len;
-
-		err = -EFAULT;
-		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
-			goto err;
-		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
-		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-			hdr_len = max(tap16_to_cpu(q, vnet_hdr.csum_start) +
-				      tap16_to_cpu(q, vnet_hdr.csum_offset) + 2,
-				      hdr_len);
-			vnet_hdr.hdr_len = cpu_to_tap16(q, hdr_len);
 		}
-		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
-			goto err;
+
+		len -= vnet_hdr_len;
 	}
 
 	err = -EINVAL;
@@ -729,8 +652,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	skb->dev = tap->dev;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
 		if (err) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
@@ -793,23 +715,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
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
+		if (ret)
+			return ret;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
+		if (ret)
+			return ret;
 	}
 	total = vnet_hdr_len;
 	total += skb->len;
@@ -1068,42 +984,6 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
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
@@ -1147,7 +1027,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	default:
-		return -EINVAL;
+		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
 	}
 }
 
@@ -1194,7 +1074,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb->protocol = eth_hdr(skb)->h_proto;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
 		if (err)
 			goto err_kfree;
 	}

-- 
2.48.1


