Return-Path: <linux-kselftest+bounces-35168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F7ADC0B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1998D188A7D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653C25228E;
	Tue, 17 Jun 2025 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWdTDq3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EC24E4C6;
	Tue, 17 Jun 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134782; cv=none; b=jbO6mIO9zPJq166ST/Dk/r527AMx9MpKnSAGSQyMCovDhbgbXei9vRO/gJIrvrKy1XGjCGScqxosYsKMdnIIIMjhRSzBYnrvNd1Dgg+g0f8LzPpTLlcywRrUJGcMOg4rcGUpgMPbyBnhBarp5RqLAgsLlB7lf7H8SufmU+s6GtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134782; c=relaxed/simple;
	bh=qoJJ4i/W50edlHBToQPG13aPO77yuBEPT9SZ9aqVWJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8b6K3C16gkugYTVjJ6J41LOrW83hF/EmpVr1L/0jgLuSkQggFLXOK5tEBrLZhyo+l/pq3Cc/uNpx3a9Le6JwC7Wy/gxxEfGkA/if1eJU5pQIoca4ALEsTZ40yaVpIjXMMV6BaU4z7Hu5do4VkX2PP0aaSp2Bcl+ySO1+/pKb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWdTDq3w; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c40a7ca6eso5531382a12.1;
        Mon, 16 Jun 2025 21:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134778; x=1750739578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdPQ5Aka/ET/K6+EX7H2iku6AwIaWmDdsZFMu+a0Iz8=;
        b=KWdTDq3wASGAlMjV0MFFOmDuJxaEKUV0Gg4giDRfWIwl90s0NWSRjCQZDsWrkkIDUt
         HHt5MSBtjM7VnYkn/gYaPJ04P08CFTYus2jM2p+cAOwP4pk8BXP1qhOT+lbnrD2Ae49X
         5TAV8wJ3ggC5hqaXOvRE1+cLGZDH5TF0rttZFyb4gQCsn2cj86Veu6rlQvlU5F556E6n
         Tzc5zW2WB8F6zvHAAn1eHQezUiy4kq1TBqCSIgADDf61F8I/2n8OKh1ZNVcF9ed8bb+a
         ZaSQZGae+921iQhCt/ioCS5AbilGumFi5aUu1GR/wSadPa/kzCQfuSTRiDXqhwwFF51W
         NMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134778; x=1750739578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdPQ5Aka/ET/K6+EX7H2iku6AwIaWmDdsZFMu+a0Iz8=;
        b=wH46YSE3whOBjK/i9IkglyMTe0G9AufHCb+Bgdp+Oh0svkIeNU5bNnFKFbYwM153py
         ss8JzJgvAXKilawfkDJk9ZYsVCNR086AgCICLUYZO8kQ/LUyu/c1cUhtF+L7mckdFJ7K
         pwQgQxdhYwYa1kmN/WBA62rBj4lZvWi9pwDjYtEx9LT09GwTCCKYIM9TNsOyLlsqSdeV
         XyEWS6y2R4l/zMQnL0hWEWHbgsCIN3UIXUPt+6XiTjmAG4OiIlEu65V0tBLcUnaCsUPY
         kP02viEvRnDd/SKORvSlb+tqtr9obdi28F09bGxRh0qY8U8H9iqmSzo5j74ErhbSx6sn
         jhmw==
X-Forwarded-Encrypted: i=1; AJvYcCWkptIL7t5WMyrOD5CWzNV6JCDzu0K+yrYp27QlzBSyb9HV2UojFzG/ZK+sAJyDd+kFW4Sfw675tRdjnts=@vger.kernel.org, AJvYcCWt8X4OjytRO7ZZm+tlTTTVI5QqqxIz8SYXuECDTF9q2ZyzSM66ZcGZrzr+Hy93cHlb0c8tqMAI@vger.kernel.org, AJvYcCXUVWcCaBO76xiLjZhWQVTAPUxl7mKeOWwar1PrdfBMnsF1zX7s+/D0EnvejRqnlaSofPbWOManNArrFbEPqkGi@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKMBJ46WJuWPay62JhLxq+Iw4YiXP9uw+z/SljXr1LPL6Vshl
	dAGxUjP9eViFvCW2vvMKOGBlm8IxPerHASodVuePYUx2MMCn9XYD66amY6Rnzwly
X-Gm-Gg: ASbGncvUxT9O8tSlp3IG8FGHN/2LJOAVUQpuNtAMxts3wVDYRHJyaVg1lFTe22HIHEV
	ljo1dQ2lN0yJST142A14DQEkQR+Unw98oVZZyuIXJDTrM75biDA9gN2d/4y6/yfxLS7RNT2LcbT
	GqcxP5wJbwwXrGQzjNkmhpFY073lkXjjkdAJb1E/dCl45gr3VIkImqUK39s+MOXTuBm5We8sTYf
	qJsYG+2hLTwf5vxxobjLGIjXSz/Cgr1d3xSLz2szMDpADhB/FTSbfb/B293zqG76l/TWHeY5Gu1
	8JN3dtJysCIVz/Exl3Yyo3Ex7SDQ4SVimaFJxeez26E+aNJTLXrz7o7ZjejV
X-Google-Smtp-Source: AGHT+IH265eeeimXvBdGeNS8fFQQO32TNNnphVtyrQ1wwHVb3dE1zI1bmUAeXXk6oS7lTC1LBMOMGw==
X-Received: by 2002:a05:6a00:4f82:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-7489cffbc7fmr14615749b3a.15.1750134778566;
        Mon, 16 Jun 2025 21:32:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d257asm7746822b3a.165.2025.06.16.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:57 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:53 -0700
Subject: [PATCH RFC net-next v4 04/11] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-4-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer to the vsock skb and helpers for getting/setting it.
This is in preparation for adding vsock NS support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36fb3edfa403..93edc1e798a5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,7 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -111,6 +112,16 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
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
 #define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)

-- 
2.47.1


