Return-Path: <linux-kselftest+bounces-25972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D1A2BB2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03807A19B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F02376E3;
	Fri,  7 Feb 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Z0GEn7oy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5D23716E
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908709; cv=none; b=mpZSdfwJ53RYqOPgPRKcDV3830AxGL1MZk/T2+6fznyUhh580H69u9A4aZKhASK+SSYdgNjtT5Hv2qqpq3JOEtqmgsz5cmrzQ+iHfZ6vrPFBelXjYR/Mx7VzKOLtR/UQ8KFZQeOYqFxCbotg8u3/EwAvC47imsAgk54kE/6jl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908709; c=relaxed/simple;
	bh=nZIPHAA5zCJF7swo3jDQ5RjM5zm8qMnIWTvWpC5hGqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=STFyALnQS3jtumWf9jX+iBE8RX3gs0PuXcQ+Ut8rIoNphhw5JwTd0LPWnLREkN1rogVwCCjSH8eAFT4RG19rnQisrFt6DryP98GAGZwIW3xFAFkaeAyznOf1nSe9977ra5WFuY0cUfa+bi2fevvJslweMKQJI9o9npv54XeRGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Z0GEn7oy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f2cfd821eso30932645ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 22:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908706; x=1739513506; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4saBNfFGUdtw4heVChkMZd5FykA/GmW9Q/kNvdZqu3c=;
        b=Z0GEn7oy7nAcn8Yimse7BALKQCW7fwCtEHPpVzB75/3hagaW8sbuotM6pf9VTPzKxm
         8YOh1fsHuReQ7Hg1hbHHZdmmxeBYSabo8pZIybqalOsotkukqeA+HdwBfLvsxHBdVDmE
         HyyNUrEXj9S23lDnsLWSVGx8ZiNlizamy2aimhQpG6N7KEV6823+Lv7a0CjdBU1qHGLz
         w5RuidjRpVdKKgUMSAFsqKdYK9d/rJ2Vip217r7XBVy/itv12JYi2fCbDAPM79/ca+oq
         gLRoHaB197upoPkuygc+o+3JjH7iiRT4nIk6BUatpgXEPg1nA93NfyW+gtONycwPfYTq
         LG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908706; x=1739513506;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4saBNfFGUdtw4heVChkMZd5FykA/GmW9Q/kNvdZqu3c=;
        b=L6LqO3fu8Cxw+lcufq1z+BSqNsl8j+pTgqTZa0KJFpbP2mRgiBu0PLnVJS9/a5pBzn
         5sovFsHLEATaOCFzd3Ht/snAPpMeoUK/H9SIBli+fd7xpNw27eR7ZwcoRbpUODZxPI6L
         om5mdOiRI+zSXmpec/2Smv1iQfqiIg28zNY/KloUnSgGoXB0pMy0yKiWyOGvKzDeN5ZD
         8EofkyXicjUGV/qgc2iLqSXGR8feI95uwwefUGTyDH6Yr3Q2gsATcQ41KOTRkTQndFVP
         E3yxHUlkfpFU4Bm2vHVkSKUJrKQh3KpnVlLv6lh78ShyAzcm6rxnrAazg1O+Z9zaWW/0
         2nvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWgilVT6FWk3ASpjpxi6NgUfYWvrvV1njLjkRfXDwvb6Yt9G2Pn1ENkJuUULQExzqHRyApGXYO5rYWimOl6aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAStXXH0Zs6gCyEgRuvT+7p8gt15zj0HStBafQL6o7rf36kEA
	36lQrBAPTl/TWsPPKA6NxOks7q97RIZTQ5aiZGNjQ3v2FeYfDLG8PbwmF+LMVlc=
X-Gm-Gg: ASbGncvAoS5OGV2BulfCr1+zEdYN93JhxgO5FUNzLz3tXqNWoa78UpYzKzzkfLN6EO/
	hzP9dlIJUTiaLRO4TWp6kZj1lLIUt62Ig2SKx5heU5pvy1ESm0fJBk43KWrjs+RiAIeq2K/cVow
	TkqvEdoy0GAnEKuV0cbexzLSfo373Qpax07Lj7M61DuCn3/sGO+8WELNque2FiGgn+SF2hiypsR
	3fBeMtpAX05pFANHep44cCBCzhbJRBBo2YtUZN8OrQdIckPDEyGSdZIq7aIoArrIUUGqI1fOSIr
	zzeAoQqRE2amqLagIm0=
X-Google-Smtp-Source: AGHT+IES1fBH9Xm1hn7eMcWgU4qwNM0YJ/XgnSVms60Xt5aaLNJShgX4JEQoDPxBZLAVM7x/w27pJw==
X-Received: by 2002:a17:902:d502:b0:21c:15b3:e3a8 with SMTP id d9443c01a7336-21f4e7636d6mr31492145ad.37.1738908706650;
        Thu, 06 Feb 2025 22:11:46 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3650cd10sm22742625ad.31.2025.02.06.22.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:56 +0900
Subject: [PATCH net-next v6 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
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
X-Mailer: b4 0.14.2

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..8cb002616a6143b54258b65b483fed0c3af2c7a0 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
+	int hdr_len = 0;
 	int copylen = 0;
 	int depth;
 	bool zerocopy = false;
@@ -663,13 +664,13 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
 			goto err;
 		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
-		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		     tap16_to_cpu(q, vnet_hdr.csum_start) +
-		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
-			     tap16_to_cpu(q, vnet_hdr.hdr_len))
-			vnet_hdr.hdr_len = cpu_to_tap16(q,
-				 tap16_to_cpu(q, vnet_hdr.csum_start) +
-				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
+		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
+		if (vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tap16_to_cpu(q, vnet_hdr.csum_start) +
+				      tap16_to_cpu(q, vnet_hdr.csum_offset) + 2,
+				      hdr_len);
+			vnet_hdr.hdr_len = cpu_to_tap16(q, hdr_len);
+		}
 		err = -EINVAL;
 		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
 			goto err;
@@ -682,12 +683,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
-			copylen = ETH_HLEN;
+		copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);
 		linear = copylen;
 		i = *from;
 		iov_iter_advance(&i, copylen);
@@ -697,11 +693,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = clamp(hdr_len, ETH_HLEN, good_linear);
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.48.1


