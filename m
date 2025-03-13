Return-Path: <linux-kselftest+bounces-28891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065ABA5EC75
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 08:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861C9171F45
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD961FE462;
	Thu, 13 Mar 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GmEyoS97"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7221FC0F5
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849349; cv=none; b=jfnSpPFcBoCeApg6QD9evc8qOi6psHJdcVNFRmVus9TthY1GUixiFmoi+updWnvm/49s6BVVt6EU+plXo33EO7r27WKUD2yLb5r6Z3DUokxfuFJ8OYf4yXiGj+GbBTSqUFmIjCRfg7Hk4P4YCroHxB35O4sH060LfOfMLIRHC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849349; c=relaxed/simple;
	bh=QysKwJMoIqaKFtrng8JoZjRW/Qn7QIvbuXMh0UY/638=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=DQHsyb7VN6FBoYSYFHDHw6jsbUwvBZyqcwi2GkJJVGvm/UcpWTLLDW+w70TnnQ0foyNF1BZbLQcdUkDu8h/HIudDRhV7UOW0QjRxKeogUntZYMdG2NTQhpTSjQRk7odrD0i/Q2pe+By6oSGM5fTT2zRzrOUhIBt8nlHVKnllmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=GmEyoS97; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-300f92661fcso1103105a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849347; x=1742454147; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXhv781+liPB0AwwevhkbIFrQwob4kiywxMETbO/hoM=;
        b=GmEyoS97Nt/5JMl1iIhPkE/V0ILB5YyZLkYleokMg6O/uguC1HD//6dcex3s8HXiev
         OEBu5bzZzypBs1bTA7JS3+wfIzkLoPA1aUeEgp0mJ7IeOSQ8cyTly8NMchROZfY3jDT4
         gPDfaNK/UKKGUp8FduHud/EX5Jxp2LePwoIA1OpiQdnYvzwR1ZDV/OTOdT6HFeJO4zat
         mSkjqihMUXrH3nSF6HiCotlqz8ttd/+I8si9fziCOU5dZYcS8Onh++7hM0++JDvIDHZb
         X7UeRT+eqxZCsAyNjgJrrDKqiIP2fFB68dYz1k2uKuB+J+juUWh5AF+zfJCZmss47Tvm
         JUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849347; x=1742454147;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXhv781+liPB0AwwevhkbIFrQwob4kiywxMETbO/hoM=;
        b=V+tsYy2/SRAQ30NI37JXf3pKnop1A4moFc3m0Vk5P+mnxjxrByw9a0EgKObf9kXSxx
         L5Y/9Yt5i3CvCR8wIn94qx87ay46aZ6/cWTA2Ec1lJFpnJs4N9k+JUWeDb3eYOGD7j+e
         KxIsh8qX8KZYymDM9iOqKMsg/wAATKMLEJBxd7mipSVKCuYh8d4/fD92xIVRGqcPnECc
         4jii663S8RXHwnezrtXdP9VDVjxBDtxbD/kyFrBwoiu+r2D4mzaV1E9xAddnFwLHwXeF
         nDj5RSrfUHr0iCyLT/XjMk15ghiBFNvcnMOz+4TCOFouLT/doSDLFd0FhllFkkRUBc6R
         NIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs4grcoGWNuBf4HLTg3Lt2O15v7vJ6923KZM6pNZPEr7TtNH9gkUv1bi6+5pXKaaA4Ug/oj2Q+JW4fvWY5jxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANsopKJwRPhiBo6Sk+nFiHhKpidzvwTXtJZS7zfCkIHrmpq+i
	J7PJm15TUqDV58m0rx8Yx3G2Lh0B/9+3ZMR5UCC9+MtfsHtnF0MmnkoOxZb0Zgs=
X-Gm-Gg: ASbGncslRsbFq1hhGseIn2pvUzspxubAXCL4AbDGCZ6S7Epiu4jYN+e1p0nQ2gSeKeY
	LYUCYR2YwXn3Ly6Rb+K62YVDoCkDsdFs4CRKOK1sm2Nvtt2XZ4q71Hgd6ziGNOYCeE8VFGmAmP0
	kigiL2CcNKLLkgmTf4Sd03HQpMaRx2FMWsf3g23mT84mpc2V+7e44P6xDDtmhzMZIyWndIGfWQz
	RXLNJuZtZLXQ/OzNP62/puGngFOj8DGy8sDgwSbpgGg/LmI4T/BcT3dZ0HSz5g1m2XSx5vytjoY
	EC0dIRHlQyHK7hERMrCOFQ1OCNXoRAfrwDN1Qz8cZLrtPbm3
X-Google-Smtp-Source: AGHT+IGccZgOJLORtXOMA8FoHHhk3Vs+fThzqAecT9XzOzLOKltyG5QMhk3cYTHxosFWc0Sd5b9x1g==
X-Received: by 2002:a17:90b:3e4f:b0:2ff:7b15:813b with SMTP id 98e67ed59e1d1-2ff7ce93a00mr40091027a91.17.1741849346958;
        Thu, 13 Mar 2025 00:02:26 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68a4095sm6633235ad.66.2025.03.13.00.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:13 +0900
Subject: [PATCH net-next v10 10/10] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-10-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/vhost/net.c | 68 +++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9b9e9d40951..fc5b43e43a06 100644
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
@@ -1097,10 +1098,6 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
-	};
 	size_t total_len = 0;
 	int err, mergeable;
 	s16 headcount;
@@ -1174,11 +1171,15 @@ static void handle_rx(struct vhost_net *net)
 		/* We don't need to be notified again. */
 		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
-		if (unlikely((vhost_hlen))) {
-			/* We will supply the header ourselves
-			 * TODO: support TSO.
-			 */
-			iov_iter_advance(&msg.msg_iter, vhost_hlen);
+		/*
+		 * Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR
+		 * TODO: support TSO.
+		 */
+		if (unlikely(vhost_hlen) &&
+		    iov_iter_zero(vhost_hlen, &msg.msg_iter) != vhost_hlen) {
+			vq_err(vq, "Unable to write vnet_hdr at addr %p\n",
+			       vq->iov->iov_base);
+			goto out;
 		}
 		err = sock->ops->recvmsg(sock, &msg,
 					 sock_len, MSG_DONTWAIT | MSG_TRUNC);
@@ -1191,30 +1192,24 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			continue;
 		}
-		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
-		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
-				vq_err(vq, "Unable to write vnet_hdr "
-				       "at addr %p\n", vq->iov->iov_base);
-				goto out;
-			}
-		} else {
-			/* Header came from socket; we'll need to patch
-			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
-			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
-		}
 		/* TODO: Should check and handle checksum. */
 
+		/*
+		 * We'll need to patch ->num_buffers over if
+		 * VIRTIO_NET_F_MRG_RXBUF or VIRTIO_F_VERSION_1
+		 */
 		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(set_num_buffers) &&
-		    copy_to_iter(&num_buffers, sizeof num_buffers,
-				 &fixup) != sizeof num_buffers) {
-			vq_err(vq, "Failed num_buffers write");
-			vhost_discard_vq_desc(vq, headcount);
-			goto out;
+		if (likely(set_num_buffers)) {
+			iov_iter_advance(&fixup, offsetof(struct virtio_net_hdr_v1, num_buffers));
+
+			if (copy_to_iter(&num_buffers, sizeof(num_buffers),
+					 &fixup) != sizeof(num_buffers)) {
+				vq_err(vq, "Failed num_buffers write");
+				vhost_discard_vq_desc(vq, headcount);
+				goto out;
+			}
 		}
+
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
@@ -1607,10 +1602,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
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
@@ -1691,6 +1689,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
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
2.48.1


