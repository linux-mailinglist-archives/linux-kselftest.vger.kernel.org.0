Return-Path: <linux-kselftest+bounces-24055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E006A05A32
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A36F3A294D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055D1FA8F0;
	Wed,  8 Jan 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QEvNFzbk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B771F8EE3
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336484; cv=none; b=ktcNIR+Vaofj0jqmnXkxdhuIdpiuAPkTmd8NEOvG12K7YnWkTfoLjQXmS8p9/nEiSYd3Y5FTnQe96wiL9BeFg2V3H5xHzuKiJvBxCridTHPYsTqCiVMEalTokhxKIeuuKnlmhFar4AlzGsLiV42BD0S4uAjjqNfddY/MBAETh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336484; c=relaxed/simple;
	bh=tHg7EPO4d3vZqqXSE/ljdfB56DasxRR2R5V/3PeBYA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ejAxqssRzXiqdbOFmqB+FrUBPmdiOqpU9p35wu8vsMO9xKURjOikIuWdIF/Ps+pt191Jn53TWS0veWt5N/uYdskuCh+QVESSm+ap9sU/qGFXOR6Pm7BiTvbfmWkW5BpDwWNAFCJRxO/p7kvipQjdgtS6dEiiZFnLe7+JBjkj3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QEvNFzbk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21669fd5c7cso250295515ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736336482; x=1736941282; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJZDjcdc8pRQt88Qkq7qezR/3EGVIB2MIrkBFIywvoM=;
        b=QEvNFzbkxUh6GXNYjhp4RBCXkxuPwTZO894Fo4dyv/JkBvASDufuL9PhudcluGxKly
         ooN7uZVpOrhEuzP+aqd5vEg7PtA3X6sDRQDTC5JHnzcbMdpqiyl9mgfFmEAqome5rsQS
         Fxub58XCwfjzBVe9hZC9tmyNUruwjEN5de+Dn5utLmx9fP3ClzAhBmE9dCGS6vNSgbis
         B4vxArO7kd6NwnJ8m6u4Rn38KzC0hn5cDqkxQ9OKDwwMRnswwNQSddPwU4Q6YH4ahVG7
         b44cp2qZ4QVepcXvt8gyT5vkkVVuljK/w3BXhWUt1d/n7BEveLVA3GZst+ZzpWgjYPdO
         o6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336482; x=1736941282;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJZDjcdc8pRQt88Qkq7qezR/3EGVIB2MIrkBFIywvoM=;
        b=nnFzjckEFpX0awPUA0WQA5vkUTuksET+Az9yldW0B6seplSuDcnLgYyzZlrWwK6VdY
         +JRuthupr5und2rHvmMAgD56o1D8k9WeZqNmEY8VqjznWaK2zZuL9Chh3bi++WAueTr+
         yMMN9TOtseHk1CVBr17HbT0FY7PV6xVA7lPVkM2cUB6KBftNiCR0/hiGVvaexlWdOgfL
         tW8JgggAN+svn63ZGIOZbTs4QTLC0pjw0xKhJsPerdLnlbX3kJzfTv6vFYZUX45EbMKR
         JBHKh9tDg/wDSLkSC24KAIHykHsxhncVLe+QGfppo4+sudMHNUzN4A2ZOlKl7P7oob9R
         dflQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8fiz+9E24BjF0Iqq1pFoz6sLUwab3y7+QANSMs+8DDRp0sFNyy0//a/A3RQ27IzYntU63sXQT6zGkwjn2zVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbd+aVN7p9rdEScHh5bQKtp551c04gB5vhzlYDKhNpNBtP158
	tChFgk6GxYZeaAc1GlGyVvyG72C2vzyV7k0ntiK+4bdcH1qJ6coxu4snUqe9yZ4=
X-Gm-Gg: ASbGncs7IQNJcSdAF0u3JyGY8E1vNVwbU+SLWCuRnB3Rnm6gWrVkfWveffxYzB0JaWF
	huzWWhTsKXKSb6gTG8M08SWGcFIQEfI6+uJH+wMHoQS6KkwjiHHx5ePBNKL2guWLXyuBRTI/cIp
	S93iaWyQr2QHFjloQBSUqeHIO3DBKVfN6qSjLTNQz5M/a58dJTJqg1NAPnn08bMuWGl89rQvTwE
	lcdoYq2777ItnCHeXgKJKnEjuu5unzZRRt3AQlXEXDYeVLXj+bIu2mFwjM=
X-Google-Smtp-Source: AGHT+IGZASTQqlbIXu/5lZbeo0etu1KHnAZzoaUJLTqYhE6bCTImvJlbR5ZtQox21lD/Cy5M8tQ6Cw==
X-Received: by 2002:a17:903:2308:b0:216:779a:d5f3 with SMTP id d9443c01a7336-21a83f546c3mr40688775ad.14.1736336482042;
        Wed, 08 Jan 2025 03:41:22 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc970c8fsm326235045ad.60.2025.01.08.03.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:41:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 20:40:13 +0900
Subject: [PATCH 3/3] tun: Set num_buffers for virtio 1.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-tun-v1-3-67d784b34374@daynix.com>
References: <20250108-tun-v1-0-67d784b34374@daynix.com>
In-Reply-To: <20250108-tun-v1-0-67d784b34374@daynix.com>
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

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c      |  2 +-
 drivers/net/tun.c      |  4 ++--
 drivers/net/tun_vnet.c | 14 +++++++++-----
 drivers/net/tun_vnet.h |  4 ++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 60804855510b..fe9554ee5b8b 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr vnet_hdr;
+		struct virtio_net_hdr_v1 vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dbf0dee92e93..ec6f4ae655fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1991,7 +1991,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	size_t total;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
+		struct virtio_net_hdr_v1 gso = { .num_buffers = 1 };
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
@@ -2044,7 +2044,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct virtio_net_hdr_v1 gso;
 
 		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
 		if (ret < 0)
diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
index ffb2186facd3..a7a7989fae56 100644
--- a/drivers/net/tun_vnet.c
+++ b/drivers/net/tun_vnet.c
@@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-		     const struct virtio_net_hdr *hdr)
+		     const struct virtio_net_hdr_v1 *hdr)
 {
+	int content_sz = MIN(sizeof(*hdr), sz);
+
 	if (iov_iter_count(iter) < sz)
 		return -EINVAL;
 
-	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
+	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
 		return -EFAULT;
 
-	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
 		return -EFAULT;
 
 	return 0;
@@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
 
 int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 			  const struct sk_buff *skb,
-			  struct virtio_net_hdr *hdr)
+			  struct virtio_net_hdr_v1 *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 
-	if (virtio_net_hdr_from_skb(skb, hdr,
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
 				    tun_vnet_is_little_endian(flags), true,
 				    vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
@@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 		return -EINVAL;
 	}
 
+	hdr->num_buffers = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 2dfdbe92bb24..d8fd94094227 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 		     struct virtio_net_hdr *hdr);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-		     const struct virtio_net_hdr *hdr);
+		     const struct virtio_net_hdr_v1 *hdr);
 
 int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 			const struct virtio_net_hdr *hdr);
 
 int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 			  const struct sk_buff *skb,
-			  struct virtio_net_hdr *hdr);
+			  struct virtio_net_hdr_v1 *hdr);
 
 #endif /* TUN_VNET_H */

-- 
2.47.1


