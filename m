Return-Path: <linux-kselftest+bounces-28394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E5A5471B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE756168BA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CAB20E31B;
	Thu,  6 Mar 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="liTDfdTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6C20B1EF
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255058; cv=none; b=dPMoUc0XcNI75pQAUP/vxWbwFUG0m3G6hb5gmLtHiHfMaSiTJv3MylhXDDYCuX2CpOSYtVyenZJOd4nmTNpjEVZk0rGNwtBw0PzTOhZNXfS8S6JV7XTasm+MIQzeHh26DuRFVmrzgQZ0urkDco97CkyZHt+xDlgPoeLFKfwcV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255058; c=relaxed/simple;
	bh=efUQp3xn6WYS8yAIVpG+8nNESAbDYNoZwtefI4rJo8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=N0YHYbIaTIFuNRY3kcwZbCkDdCI+L8y628usVO3HYJihH53scX1f5SxhLspvWgbwzQ02BPNwcDYei7CwDt25jGH1IPeNyEpYp3xFfI+fzLKS8xkZFNUDZMHjGIujUwQwP1z2P7yrqoCPhZ96mDULUFhOzcL7pWHf+hUf0+NpoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=liTDfdTi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22185cddbffso31092595ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741255057; x=1741859857; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnuaMjhFxZ/6ziAA9dAFSZFZKEXkUeKJopwW9aMJd8c=;
        b=liTDfdTiAJZ/79okWEDZNcbgi7+Hp66nqq9EZCfTbn2l7x4IhDeyq5Hn/bi1lpczj0
         ORpVll2qWNQ+89fV7LDV/Eh1lR8HK015UvQZu/eitRX4VLlosUTS6em93Awo6Ofqz0d8
         m37RFcDHHI+c0Gbm2ZKVUwbAm54vMtsM6Mut8pwWAMDDORC48Sqm0wmsnYHKnxh+pX5o
         iZNrWzyJaESgGSI6LdUqfhVKnrb2k1Tbyf1jkCBYqCp8LenuvXvtzJZv50Fg+V9NLtLg
         dBtaf+U2HIV//gwDRQQHm3wvNZTA/sIFJf6JhUen7QfpiCZnwHEXSA3G4OcHc3/Pdwfp
         zBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255057; x=1741859857;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnuaMjhFxZ/6ziAA9dAFSZFZKEXkUeKJopwW9aMJd8c=;
        b=RWigQRoTTxUk98MVDHqwXZe6bs/HgscFK93irLAwrxKrJPA/y/lEkYMeQWU51yygLu
         L2hN88Cmo95FBFZ2aqjkfPqN0DtGq0tzaoBNlmZlii3f3kH/QJtjlsLvRH2leQVTXuxV
         vVsGK1ODUNa8/CTOIEV4SelVJXpdDPMX9q/pNksCjkTNg/iIjFM6yuaDxbjbU0fWu3q1
         zporcHROcQ6B6H5OvMlLkvBJiKW61i4G/QEAzHXVXDao+/OpN0DXkdEXITRTTK2ETsle
         AyjQbwXlNNDmoaC/bGbb0aXv+Bk26P8forUhCAJj0ErBuZrzSGNLNu/PwBHWBSJW9hmF
         pyrA==
X-Forwarded-Encrypted: i=1; AJvYcCXxsPCuQShqXo8vnS1M8EJlSzozsiwjp+r5yyH/WKbhNHZvJzBYxV77ikcmSouMrkwEUdoo3qTIhXY/6DbesMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjO5t+6b0L4lmojuAI0x0w26fy9cHzmBHrvwtyDAWqu+JEWSs
	t1JfKkmzm4TluodY8zGzZIhEL/ziKETakUo4nt9QSJOBYXEC7xJShb/QfxWdrX5U0U3AVlGOYh/
	5DKI=
X-Gm-Gg: ASbGnctoPAlxC0H+S0d3IYR1CI2EVZ+/TRl9Ul2ryNzhefifQxzLYfgrVxBRjM1IsCl
	8QKSuzegNZtNMdxnvL9Dd/Hx5ZmEniYTOgABHRshUsVNHdG17nks7X/1ymGXfew/YB9e73r7OML
	2bOtY4kQtK3mCZNO1DV893xhkvbUlcXx3aI/ZPpFP6XkbzeVhm0S+sTSa8DdeOQPMc9QtwbUFVc
	9Ci85ux6IE4dgyeyLLW3janeem8iMdGLROcXRGuk2m/BYVBrBYVK+M7EtheqyGjkmcSinbuclv9
	OGXlCA6CZTV6HWAoEBRLeoJAPEd4Q1gV7BtxSgRAwiWjoSyU
X-Google-Smtp-Source: AGHT+IHJGksHinhnEKP7Vul6y/8p6O/KEECmCOaw6lnVXA484Y6gp9ZfN9uJUdcGYFrU6DtyYorN0g==
X-Received: by 2002:a05:6a00:3397:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-73693e85ddcmr5480443b3a.5.1741255056584;
        Thu, 06 Mar 2025 01:57:36 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698514f58sm948820b3a.133.2025.03.06.01.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:57:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 18:56:36 +0900
Subject: [PATCH net-next v8 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-rss-v8-6-7ab4f56ff423@daynix.com>
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
In-Reply-To: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
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
X-Mailer: b4 0.14.2

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
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
@@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
+	struct virtio_net_hdr_v1_hash hdr = {
+		.hdr = {
+			.flags = 0,
+			.gso_type = VIRTIO_NET_HDR_GSO_NONE
+		}
 	};
 	size_t total_len = 0;
 	int err, mergeable;
@@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
 	bool set_num_buffers;
 	struct socket *sock;
 	struct iov_iter fixup;
-	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
@@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			continue;
 		}
+		hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
 		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
+			if (copy_to_iter(&hdr, vhost_hlen,
+					 &fixup) != vhost_hlen) {
 				vq_err(vq, "Unable to write vnet_hdr "
 				       "at addr %p\n", vq->iov->iov_base);
 				goto out;
 			}
-		} else {
+		} else if (likely(set_num_buffers)) {
 			/* Header came from socket; we'll need to patch
 			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
 			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
+			iov_iter_advance(&fixup, offsetof(struct virtio_net_hdr_v1, num_buffers));
+
+			if (copy_to_iter(&hdr.hdr.num_buffers, sizeof(hdr.hdr.num_buffers),
+					 &fixup) != sizeof(hdr.hdr.num_buffers)) {
+				vq_err(vq, "Failed num_buffers write");
+				vhost_discard_vq_desc(vq, headcount);
+				goto out;
+			}
 		}
 		/* TODO: Should check and handle checksum. */
 
-		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(set_num_buffers) &&
-		    copy_to_iter(&num_buffers, sizeof num_buffers,
-				 &fixup) != sizeof num_buffers) {
-			vq_err(vq, "Failed num_buffers write");
-			vhost_discard_vq_desc(vq, headcount);
-			goto out;
-		}
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
@@ -1607,10 +1609,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
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
@@ -1691,6 +1696,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
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


