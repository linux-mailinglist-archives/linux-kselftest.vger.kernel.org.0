Return-Path: <linux-kselftest+bounces-38330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1A0B1BBEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611A33B3BF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E43293C45;
	Tue,  5 Aug 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZavytIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB89275B02;
	Tue,  5 Aug 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430559; cv=none; b=Xcx5LZwA+8hX/YlvdsMSICJXUkRFQ8zUsW3JLN59X2uo690pt3IsPOhrYBqr+hZUMEqNZ8MVvMYpsB2Clml87p6Do9NiQMxrKxkuXnPAQso69h+1Cs5Uxn/rFmcA4rb8ONR69yczkv9mHfWU8woJRd0cCcSyIMQQR9mAQ4rYs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430559; c=relaxed/simple;
	bh=CDv1Bq9IATltc0TiHl4mQECx9R2KqlZC2n1J6SSVOj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOkzAgcwyX6/qQe099rdIpY1Z+QlGeM/9yZcyEWvwvWIaiNiV9Ax77Cwus+WnvN67M1uDG41WqgzNzrQJ3o9+oz7t61MWpmvf23nkjEU0bKTn5cYGGD9R7kjsVxShXlF/RKvzpRAOQGIdbUsBK4P+HkLj6NIFgWvJjCHMe+of9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZavytIH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3214762071bso2366922a91.3;
        Tue, 05 Aug 2025 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430556; x=1755035356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0FnPyhHm3WVprItOStvPF/G0ADOLLcY9YeC2HhcpJo=;
        b=nZavytIHeTAhbRzUAjFnUk/duVHt2lgLUjCkTBx6lgbxRh54iS63PtNx7Y1/z5iS8v
         ZX8itx/1JqylYYQJulAaRc5hFy2BrBKYJ1bV/ilAd1G8w5IkIHi9S89fmKIUIKpVvIBc
         R+Y75AJNY4WIyNpd+rB/bEz+t5Ew13x0N5qUJ9hyBqXJGJV1MGYN/+sq35u81shodStY
         8lUg4Eu2PslvZvl44ZGLN+DG45LczWuCKvx2e0Jh7ehRo+zUVgIDkaoTuEYH37y37xKM
         qP07MCjd1mvYTELj1ydvnpJGdu2kYqdzvgo5kusSZ1AylKVl48HBXTjwZOA4tbFBjR2p
         G66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430556; x=1755035356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0FnPyhHm3WVprItOStvPF/G0ADOLLcY9YeC2HhcpJo=;
        b=R+peH7jTegj8pCI6PSveShjw16pkOe5/FC07aSGSdpMNCEWVJJrh+F/gjEMMyc5rPb
         FR3W942/tJx12dYv1PtpWS+ZCkNbFU7yoeDUtXipfSFmMGaEd67bOsJJQxOiX1AnhL1T
         CRKxFAuxVFaq52Hi6tHyJnISGjTdlx9erd+gmyk25KEesN57xjURjMK2vIGhFVDO/Lda
         MRFrQKuIi9dWUWZX1MW5kxT1CAuqeXZyphcVN/DjEKnoTbiDum2ELz5oqDzwL/r+PN59
         xgN1NtHCKiYzHXivig6bC63DpuqN+0JHOcKsgNtKsxjo1S8WZdFsHZ+y1uh1sbgZ6+uS
         hoLA==
X-Forwarded-Encrypted: i=1; AJvYcCVP2tnPNxIzf2AGPs18j2DU84X4MpQiwoELXM2dqwrNMcvs4msmYJ6OgHrqd0l8DnMOJfI=@vger.kernel.org, AJvYcCWi+/ecnml5craNx/33jedVCHlSKSM7+owKGveQXVgVmdbf0AQiXEWiAidGa6TkqgMJ7d9o8LKn@vger.kernel.org, AJvYcCXEKIZUKv89+WIaf+ijrhUfXcBB/Au5GGBZR+Y+Wkym8JhqWE8mkB/CfvOXd2rCbh2VPAwABALgzl/OD3WTGmjx@vger.kernel.org, AJvYcCXUq1iYPmm2FFRQ5HqfwGoAG47qRfD6lrfd0njEbsOCsjPvv5+GJ5xlvyyHXicuNsuXg48j6BNLBAHlCjZT@vger.kernel.org, AJvYcCXebBn0pej3o9rAnrt/lSMhGrLtKB4TH87chw3LWayHwC67uMQtGO7jfC+eFEtvn7o5y9ez22T6YX0Y1RcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXaD9WVm9ernaGxvsVp81F/BMmmr2HNiREbgPJues+kU3K6xY
	ekl/frOycv/OyhpQi7twR/DTKR3FX/OKqykA58e7blZzKRBr3XxwBXi9
X-Gm-Gg: ASbGncs5Y7/GIOX426kFBFMfAEiEMQ7qqB9cJhOw2jlm0bSdp/ePmBUD+vwx/1HYWhN
	3PAfvl4Q0XyEH5dOF/bTECpQLGBadhp437zg8Z1sMsb+sa544yfRvcMO2MgKG6rqB4WlXAVSJ0d
	shUn1tff6RKpvrhOn/HhNYzVG85UPLXklRtfa5ZVlFrbm4jwc2mj0Mq7CRvVZoCQ4V75Fxy1u0s
	i4LoheJ8elwLWtrvMsGle9ZdgfX3yLp4HD5xc66NXXbBsnnLqwCau8nCpQ6RTyc3S+aZ/1VJe6j
	vcmIIbCnAcb8dqO83ROzUN1vvZPN87eWbaUONPS/+aA2kRg2Imv7gQWqshq5b3einbcEaPp/M/q
	GdQgeo7KM4H4qvB5pCwqY
X-Google-Smtp-Source: AGHT+IHhgArUDVEklDhUo3FAHUEOH2pq0YKOQiSFglKsHXA8X5kgylXUPHewA95TMT6Ar3nMPtRlMQ==
X-Received: by 2002:a17:90b:568d:b0:321:1a89:f692 with SMTP id 98e67ed59e1d1-32166c2918bmr458783a91.8.1754430555834;
        Tue, 05 Aug 2025 14:49:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f33e58sm17823090a91.33.2025.08.05.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:10 -0700
Subject: [PATCH RFC net-next v4 02/12] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-2-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
2.47.3


