Return-Path: <linux-kselftest+bounces-18285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C8984190
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3491C23B1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81A185944;
	Tue, 24 Sep 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="16/egj4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF1183CDB
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168499; cv=none; b=iIeWCFhquhM7kADgnOctVnUJOfyvDP9ENwstGU/40qgTtBvNTVguSC3kRRYLGJyPm1NZg3iTDEFlQmIclyP9tVgmgYtUbMHrBxpwFN97OGFK6utykMMDTcC5iaW5bGH0eW0DbCwQboIha4Nm8o8rb0aX63G1qvioIxoEoXs3Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168499; c=relaxed/simple;
	bh=2fqPz17MRcLXtYYBT9jcWjUzidfYf/z7eYbmCSZjWTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=iufWKBP52RkoXBCrpfWyaVrS44fR7rWvRWpiBOyQHles0hj5ldIAZnTMWRZNl20YrPny9VosK7m7DwmSVNGhZLRFpXb+PgkhJPljC+gmN8S3wAtlvKgQntEvFILeZLfBKY7S9WS93zt2XpT03GOG6TG2FU+WUHmlDHCpPri5Mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=16/egj4t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso6999785a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168495; x=1727773295; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldxygdAUBk4mdAzGg1OPlp5HlR7yVW+p2ali8303Ccc=;
        b=16/egj4tbMuwzY5iQ1q8y5LydOMDyUtDR1qtTkcOMcOvhFkUK4c7Wfye91lOkRhLeK
         6rgTh66Kjbpo98e7EO/xZPAzIxatcSzw+Ig2mVim56GgKpqIlE2X+r0TR1GyRFuJQ2WJ
         ygUwuZrFWC+YgY6Ys7levb7vLVekDj/YOlqZeIkdKN0nY6HqyQxXcMFGiKkrmwvz6be8
         ELipaU6ZnRQuT2njyVKvmpBgdCesU6UkYtqTrj3JsKgSBvhTVQ6xqDtH/MVjQPWfzTje
         Ur81jUfYo1qVWf6sepOgHAaP1wiCTyafq9nviCBiXiKUxINyxIyhAcdSo7Aksnn36DfH
         HsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168495; x=1727773295;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldxygdAUBk4mdAzGg1OPlp5HlR7yVW+p2ali8303Ccc=;
        b=uPCGgo0hdcdWz+5KCYZq0SBzH2AuurTUYhozAbjSHWab5k4Kf4SUwKPTMtevdAgcXr
         h9o+hhP8A1VyvdhK0P/l9+AsUxK7LrbPHgcyGG9dJX2uGPPiSeJmgJQPWZrgXH9jbjc9
         Qoc0l0TGsx8b0aKJFsrCmvbSjhnnYODy3mhe6gGnnLWDilgYOsJP7wE1SjAPkfde/K2R
         EHFsT9+3ShokLL3t/vwtsN3RWl8Lm7gLDBZeKMmuQgN+1Xbxyu6IgRE4jlhwhUcDdtLR
         sWP4LEq8/G2DnI41a8Km/OFAv1/mNDpEhadDqD9M/BzZQPwsnkco9qz8dq1ez4OZ/Zm/
         YqLA==
X-Forwarded-Encrypted: i=1; AJvYcCUmMW2TIKAOMMjQUwHlXlDf+b5arvpEn8b7qIDts7Yr61t7Jy/eWnDhyskowE/6QHLzBMcy+oWyJzj5pp3DVrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2BOb2+hEO02V0/B0I9NGuvSD6KuRQmX4Nbffe3AsDpBP3frow
	1/rQE1tKTGPfY77Nbc3b9OYZpg8AMSOWAlOXiQbR2NG2q1CWU8fPAsa08Y49CAlD6wiVgNK/K0N
	s0waw793Y
X-Google-Smtp-Source: AGHT+IFFGNZvMoEmnxV4kikQ2H333bCCtXL26WeV3JaDRS2Q6nCPUSS8kmDRZE0LD3ZUPP5h6fZgnQ==
X-Received: by 2002:a05:6402:354a:b0:5c6:34c5:e5d7 with SMTP id 4fb4d7f45d1cf-5c634c5e97fmr874444a12.7.1727168495205;
        Tue, 24 Sep 2024 02:01:35 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c5cf48c04esm527645a12.14.2024.09.24.02.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:14 +0200
Subject: [PATCH RFC v4 9/9] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-9-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
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
index f16279351db5..ec1167a782ec 100644
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
2.46.0


