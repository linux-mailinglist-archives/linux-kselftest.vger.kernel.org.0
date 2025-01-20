Return-Path: <linux-kselftest+bounces-24772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86CA168A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F53A5768
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E21B4226;
	Mon, 20 Jan 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="erS+JdCq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4901B4121
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363664; cv=none; b=BPdRZrfcsLsK2vXyYajnAdz1Mhsa+2xtKt2OaE9q8TmX5wPGYvGBn2h8l5FlHBPJfNJipdiWrI78l4r7O4kjE5+uWJ9nXE3Kl/ps7g5virvArdbA1+xDg9CHz2b0JHXcfwEin2BhpOhPSVmKKM6G/Elany1Ni6d6/V5rK9r8RPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363664; c=relaxed/simple;
	bh=D/KbHpktOZmWZkuzza0bk8f9eJQf34LwugBKMP/xt28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJ0on/LFSLoZDBFW5w+6W1+k2gYYnwDPxidBsGTfi+3CkncRQvnKlJ5nRu6KyAh15CHWu8XQDa5czg/FctJTiZqx41+kwlpOxmh46lLLaug1tVZm2Q/Z+mkh2vcohQQFP3chzOP1UJs6l1HGsUKbfIVy4RsocXvLU6StXT7zs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=erS+JdCq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21654fdd5daso71155275ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363662; x=1737968462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vp+Td7/mzSbTV1DDL8auTuqvLhIjXvEzrkpgi0EGeVI=;
        b=erS+JdCqfnuExX8uZXModadJ1FqWrBeReeWKS7FZkm13Bxt5k7bj01bYGaspvaDrFU
         4MqUiTfYESAZ7SggT6fCxFVHKDh5vJ5wqQHnlI4a9PEtOTKCDk531A2QBXeDsY5leKbX
         DZaNt/FcU4nha/kjLhdDcrcfgbRD5WXOkdZ2YvW2IY/AgYCflbJVsAKlAHauHHtA66uE
         MXDLWqcFKc3MY4qZOzKHl5qh6lU6wGf5srEy4N9JRWJKFkehV5OZO3kt8VugGPYCTyfs
         21Jdoi+5bzBoPEPEGmg9/uBbh/4qHwJ4R+gkU8gKyYLrSGtcvru1sMFjmjUWTrJbnJbs
         pNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363662; x=1737968462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp+Td7/mzSbTV1DDL8auTuqvLhIjXvEzrkpgi0EGeVI=;
        b=FxTBH0hWhfWmgv/TYDQN1uJAtG2S5JbBiMCSZfDwYsMiWOK0dwAOmcWjy+QLSc/8iM
         lC4exGi56UEu1lVmpdqraAmwyaOPHB107dv2Qp/Iin83k6JpVYhdt/pvWM1L5I8kZRNk
         YbQ+IwtuLjm43DEFM6EYpsyWoozYCswaY0AoYCyD/OKcsGwz/Ggcd3/TxAhgzQHxQDIx
         +qw30P+KXkGrHFK8sybqt9N5ThiDbV8dyXicw/lZxXYPnzWQDRBh0OMxT8/ABzqhLmd2
         +CdyOOAaRNOXU8FqKXPnhaxeKJDRDGhmqZ3s8J/ooj2kOSc2iMmopfSykFHwlkZuSLHl
         SiJA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/skTnxExcyCoHWOcUhedhHXZVKYeXz1QBFee7tLXRoWf1Xns+GP2dIv9rcXx/A6lB12YdStntEv0uVBI5ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgeGwgkzKX60brl2N8t9yAY07GMM8ZCornT0jl231X78Yjvp8
	WAiwpBnKRplGbAKxFjWwnTA3i9uQzx2gzRgcI+9Vnp6W2MAHVIMRqe/AxcuXhvLwyqyg5+q5x2A
	j/K4=
X-Gm-Gg: ASbGncsA+geRoTFmzfXvxlB9vMuKy2So7H3eij2nah+SKpSUEgYuYTpg+/PebdSn6t6
	c/tFly5M/PawfZWam+lFRsdp+FnpAkgf5RJJn1LaQL4hM0W7xPZspsG1FVvhV9xduL2Y13CSxn8
	deG445Bu/5ulgoPOj2a+h71I3v4+zOXhdVGUsXssUNPw3a313l3shB4ebQ3Gn5GFAmPH5bU6an9
	uJhSSG52y/SQLCdpBIWVwMkYs6AFAbWiHAbUqorHkHk7BTjy2oPv5wGqbeT60IF9pzGod0V
X-Google-Smtp-Source: AGHT+IFW7W3w/ZoXT2erNaTWxN+NcvV4dQQ8KrLwwzVKL+Zt7YL2px/phEUI7pHUKYl7ycKYIP1eFw==
X-Received: by 2002:a17:902:d542:b0:215:9642:4d6d with SMTP id d9443c01a7336-21c3540c875mr170754915ad.17.1737363662228;
        Mon, 20 Jan 2025 01:01:02 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21c2cea0942sm55819465ad.10.2025.01.20.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:12 +0900
Subject: [PATCH net-next v4 3/9] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-3-ee81dda03d7f@daynix.com>
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
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bd272b4736fb7e9004f7d91dc83c69af5239bfe0..ec56ac86584813f990fabf4633e4d96ca81176ae 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1776,6 +1777,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
@@ -1783,8 +1785,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1798,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.47.1


