Return-Path: <linux-kselftest+bounces-40123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17CB38FDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D557980334
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47AA1D88B4;
	Thu, 28 Aug 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOLKOfvm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795A146585;
	Thu, 28 Aug 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341097; cv=none; b=tdK2tDWDV+K7lc9HdpLcIR3VyI4DuN/k1Bi5BlIx3iBXNvy6MWPISSsGtx/f1LYYHRpjAkV9TVHaK8fiMRjcSH7iucc7NMUdeY8BA8eDjYY6YOkwqcjp1cmYptjGHA5CwZ1TtiAS/Slv0eG6uVHTQgE9lG1FBnXYhhlmuMk5M6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341097; c=relaxed/simple;
	bh=TYmMByH+5sTf+Nmv/lFpsDIcxlWf1v6PPyxvRt0BSCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAYLaE1A+XsFGert7ijrdEMz5j/MffZm+yHeHeuonmi0UaZUYECOeSA4PspgCiDhEk31LTjM/DO0YhrJvv/q52C2Nr32JWMMoRj1J136B19UgrkZQwVW9ig2l6hHtlIwnQo2SFgggQh1bhClUUKm1+abGeBKBiSwu56t0Ffzgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOLKOfvm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246151aefaaso12488985ad.1;
        Wed, 27 Aug 2025 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341095; x=1756945895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPvtzAfXM02gxsFwP0R3/4GEgD8KwF6jICYx2UBFbv4=;
        b=fOLKOfvmMYUZiIFVUjt7dJSvo4Qm46L7tXdzUvL0066dhc2XsjI3qh+lSe3P3tJ7ZN
         FeAY3ivHQZT6WChNqPqvG7M58M3tgRt245pT+8kaGGL32L/9wK/F4MKf+YP8s92GqDIY
         YSC3IXhaUF5oDCeNrXiobhetE/8eGdtDc7tJNJm007ci4kR5EVWrLYKSRfT8Sosg6mTj
         dRkkaAHN9bJ5AjiKj7GuJMbmcOmhyCoDzj80jWw7c6k/J8krWvXh726p+QHNX29yjow5
         Y2Zq0zV+FB4GXGPNKm/GplWYsvSS+9TbdQQaBHQspVs/QD3JMyClcJsWVRw+eHhoMTas
         KqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341095; x=1756945895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPvtzAfXM02gxsFwP0R3/4GEgD8KwF6jICYx2UBFbv4=;
        b=sf9b531Vyf4Lvpc0rOsZ4R7xll6fok8BN5kUYppitzLvZawzd+luJg+XWzdosAOd0m
         EJQaxhhNlbXQx8XBQuWtcbM2QK8ZFxXEpJBDOMWpez2QzSDYyT4MggAZEqiAD+nv3pVD
         /nuTCTFGcwuVicrlccUL21jAIWhyuGK1Ov89UP0VmrPn5XsB3SnErrEcbnWIoEatw1+c
         kweBHsz6BLOZ/7IVf8tYUXWot9HqGlyifY90csWfoj7T7FJpO7H4bhV+caGpSXQacmy4
         n/gWG9lTvTYX2DN3sJHudB41wpA/9wRxBdkK23YderLz09NneO+Tipb33MZpVAUf+Xmj
         XnWg==
X-Forwarded-Encrypted: i=1; AJvYcCWMcIOFG8QiT/zlpy7abRZLGYxzqRRy9cdPSRqh3ShtfloeQHF0HEQFhnSlHY7UKefB2Fdf3U/5rNpOBPYhHRIT@vger.kernel.org, AJvYcCWZrlhggB/kKOj/QJnqgrpsf2ZElbHWz2w6gUux49aL/ewgSjmxy9RCxuXDfncqgbvOJQ1UC6zmUs8EVQ1D@vger.kernel.org, AJvYcCWoFNDKpXHQbtW0cTAGVFkaK4YcD8eFKQF+CoHJgQFgE0qBvi+NwmBBnWxKYekUCklh3ElrGPbX@vger.kernel.org, AJvYcCXQwjDWUYJKdK6N3N1iyoXKgI3aI+1gMiPUGDalEBN4SMBM3eo8tm+ixI05GHSnh9dMrWw=@vger.kernel.org, AJvYcCXnN34hsbrhv8hPkvEpt3zGTkjj2rc85TjmRVaaLFRvIX3crOisWGZs2AVa/TQJ4o0eNskuVBpO1MyscyH4@vger.kernel.org
X-Gm-Message-State: AOJu0YzhuWfOorBkl82WpTxkF7Yixgbc8FOV2AY/8j1J5xzEEL1fMUMx
	iaDjG/MoU+XjRwustFpd4Tl8edmclXtaYiVYqRK6l68kKrpeDl3ddn6L
X-Gm-Gg: ASbGncs7RMMsNsE0hpcSeriQOe1ryqjWdc113qAQ7732e7R8Ls02u6ISZ4j2VeWrABq
	SLXBfhjbot98kuKcG34Ty7M8JSeo7WQo3GSRF/UxW8jEtykThveN6l2bm8EWiqC7pGPhqJyxARh
	Gn0tghFVqflDBhOFUGsq1Epsm4WPpGJqlerjx9+NNBUZdD6unjjZjrlARe97rxkAb5PQ+bf0Li3
	HYCcxh/NgxyALW+B1/3ybQZytIZ/GjQpBXuImAvcLInMr8LdprwXm5BRXdNQj7EuJ2emRxYWwgD
	CGisquRgXkbXCaKJSepFgCwYBBTlpLDz4SfvWrDCM9/d2fxTYkVx/N4sZsVdsSspQUQzr7dsqXr
	xeMt7Th8Myo9N8rIA5A05Wham+XPglI6u4mgWgxd3AA==
X-Google-Smtp-Source: AGHT+IE2PGfR2lyF9Hr8hV5HbfYYYn2UwMgBVIhXdHI1pQtLPnrjVODZOdxlZ2k7OY2teQU7xaDFDA==
X-Received: by 2002:a17:902:e88e:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-248753a2359mr86214995ad.1.1756341095375;
        Wed, 27 Aug 2025 17:31:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24893618880sm32735435ad.99.2025.08.27.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:30 -0700
Subject: [PATCH net-next v5 2/9] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-2-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer to the vsock skb and helpers for getting/setting it.
This is in preparation for adding vsock NS support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..c547cda7196b 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,7 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -130,6 +131,16 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3


