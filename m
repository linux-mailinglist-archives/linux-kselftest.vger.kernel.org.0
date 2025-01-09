Return-Path: <linux-kselftest+bounces-24107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3997A06EDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DA11888B53
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C1D214A89;
	Thu,  9 Jan 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="01P2Pd2G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25E214A86
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406893; cv=none; b=ixvLLDjFtW4aoCz4JWn/IjKzkNRP+mhz1x2DPKpPVYHFYvxkzxTy5KaDPqJihQj91PkyDWljoiSgederDMWDoA9no3gxjBoE7xa4SzcgdU652sUdBILduIn98NAtrdVMj8jmafLKjwwdfVJPJ8BAoawMDJKB2AXsp0x63iQZFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406893; c=relaxed/simple;
	bh=V4rTr48gCTTCBFSUklYTYzH1BMfrr/4hphLyr2CFHBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Gq+SGq+G6IEeOUdPq4pvDTJTwheOEwbFMZFlq8jpYIH6jHKbO0HMAQcTer8zVI+sAmUiUxqusTXePhHBZSr3dGTShqwSKAihwOKFgroXPhSn8Xjk2V+FRB/X4TI7am/6rNRc3HLwHnuugFHN3zF3P5L5uq5i9cmdMKvQEVU2QUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=01P2Pd2G; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so827211a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 23:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406891; x=1737011691; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g1VKQa2xOP+8VFeFm3JNqgr+uiGplo0eLcy0YMBCzc=;
        b=01P2Pd2G9mFDTgMLRM3sPOFxbOrA4hwqfe9b2YwR2qRWq4xnSUFkf/Eazsx4Dn4ji7
         SbowVzlKn33wYdigYN6eMvz/OTkmfQWxEEzDUJmSh10Yvb0MuKrzIMzalvKOww/QU049
         lttv8RnVuTEMYX9TEBlLXnnZmN3awe5aKJVN5jD2rTRd7I4cn4SpY42VOA9I+aebYsQT
         ZDPCeWk0RhPOr0a7DE/AAEqp405UMl4aYJG5NDN2V61qa8Cjg/Egws1B/NLQ15BhQ9Se
         lGeiu1hcQn9oUpxWFPvN1GPwNtA/v4WBtvcSUngvOund+D3tyooff8NVtXqsx+sVDsXQ
         1MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406891; x=1737011691;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g1VKQa2xOP+8VFeFm3JNqgr+uiGplo0eLcy0YMBCzc=;
        b=N9kvtqahfxTfgLGubEhm9YIHg3Q0OvXllEB9aBAHaaGV9nmDQVKCvm6eIFINKQE8x/
         kIY91M5eR/X0CgYeLtrQpIF0yD/+Y6lw1FdvnIsOBbygWsMEf6zdHpPrMVZOjiv1pEvF
         U9YTa+FwyzQZY/857apA7aUM7J19g9JNTWE+YcjLL1DWZ72Ar4a3v6aeHFcQJsCWDuSC
         KCcyKWmSudNeelmmBBMpVlYuSC6EFy8NGZ8mM4glXR5A6GqPF2OL2odlIt9r+qjmnwFT
         cq2vAAypuXXrGQomfunep7VxQxe0SVKyCaKO36ZfgjzZcWdyysHaswV8Kn8oVBeFbC2a
         jKaw==
X-Forwarded-Encrypted: i=1; AJvYcCXZPwp9QG6yvb2HdwezwzatY3AJazM2C0iBQtBk0sfGDgmlB9I48qE9rtrGCLn8XbWvXr8V4U5qSJF2JgIF1BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4slvoBR4eZ6aJTqx9CI+CfVyrY5YzuOXGPqdd6IPfP57JSYby
	1pM7VNUfJURyhVATwBZLzJNrIRsmoVuqFdqt1VdWKyNWGbPGwjrRznbFwdUPm8c=
X-Gm-Gg: ASbGncvMNLoC9hNkksDsGirLyC/heasyUueLO2DF1hgb46DyUOjI//hNHJiYdjPigwm
	N5qzrZjUrzpZgMGpJDniERmhEIBvWe0UcqUUwxCwgc6Jqca03+tN/i9uo+utt1Kxv5oj+O0d/N8
	GlA8Iu852WVzqNR3pXwpYoLr1843KrZrwEqDdjX034sEyNCBjwjCF2UvjH35yeSVRUlHe+W8HbN
	j3MeIfFqTLzZALko0Hhpj3kv6xlay9wMTxbNGuR+IuBH0nm0pZ34y+SUvw=
X-Google-Smtp-Source: AGHT+IGd9lpv9zb1K0tz5iHHV3Jqm/5MPg+oC5ZDuZy/BjPg77kTbQjj8ZNOzcyz3pMcdff2Q/gChg==
X-Received: by 2002:a05:6a00:1d81:b0:728:e906:e45a with SMTP id d2e1a72fcca58-72d220599a3mr9260391b3a.24.1736406891083;
        Wed, 08 Jan 2025 23:14:51 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad816464sm36435407b3a.40.2025.01.08.23.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 16:13:44 +0900
Subject: [PATCH v6 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rss-v6-6-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
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

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 9ad37c012189..ed1bf01a7fcf 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,7 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT) |
 			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
@@ -1604,10 +1605,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			     (1ULL << VIRTIO_F_VERSION_1)))
+		hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	else
+		hdr_len = sizeof(struct virtio_net_hdr);
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
@@ -1688,6 +1692,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
+		if ((features & ((1ULL << VIRTIO_F_VERSION_1) |
+				 (1ULL << VIRTIO_NET_F_HASH_REPORT))) ==
+		    (1ULL << VIRTIO_NET_F_HASH_REPORT))
+			return -EINVAL;
 		return vhost_net_set_features(n, features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;

-- 
2.47.1


