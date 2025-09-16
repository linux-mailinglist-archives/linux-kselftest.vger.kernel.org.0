Return-Path: <linux-kselftest+bounces-41633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F336B7E1DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B403263E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F12F291D;
	Tue, 16 Sep 2025 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFDCioro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AD2D3A80
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066236; cv=none; b=HmBbQqHD+aHulgUeQjyLnXbW/FlyqfcDEe/8UFoTnMdoJ3tDbtjiRgNnOY2TmddJ980H1iCHhUgHAp49o0vV0fZK/n3R5bsjKpERzp3O8vqNeghGp1ll8R5LwMHOt3kmEev5rfSUUl69bW5RF2IVfKnQ1Dlw2zXx2NEsfOCxkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066236; c=relaxed/simple;
	bh=W8gd6XhWQ6pvri0xbAF1EAgDb4RZn2xcu5cNNgZFNfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsgSKt/2mNuwakJjZcjxR/yPG4zY2ViA7BvtHN4ZV81V3sdtrNvOTI7W3eGvDLdLhGgDqD8HZj/r2Nf5j8BU7XTExP0B0RfBoOfVFxvITI/xLz48iZUKNPVoMZB7L9pUahilrsgC0lG6xoPBdt/KMTIRbSkwFcQHq/BOm8SI0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFDCioro; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so4845271b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066234; x=1758671034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=CFDCiorouBgrTtHADayhVGin8siFjn9RXQTl6LQ5IEBv65PSBsrOMVLddUYCO2gv6S
         SpSK+2+/J4Ndv8/onlVkAJtF++c+FmUGVplPAi6XwrqHTI0UpTSPuHXSkhKvmErilHUe
         GNTBDFCdyzSC2LR2YZojmo/DiLSAf6Q6JzIZcCqb4GZ1cOIWY1QiNPZkgFtmrm30QOCq
         WZlJdpiSXeX/rtB3XwG98VVVXp8NvmMtssvV5In/KCOq+lYwbPnj4WLRpt/3b2hWKjyi
         elDtaa4Yfh4WeSAI4grmazua+vRUqDHdJPrvbsqT4JOauddLfwkTi1cN4uqQt/fvWbPE
         deWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066234; x=1758671034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=Trx7y7UIEm5rwS6qZtOiLvmnj6IWlv0p5MABwG5Qx4/Ouck3rmt7ku1XyXHwExe1LL
         0hT5Ad9k4v6aFobzrYNnSj+qqKPrKhPypQXAyeZoBTU1Wc6BNiIg0/gwf/9YeUL1oN9D
         UsxwLTJ24IlKUve3FidOFZWTZ7ynEhsFb/KW2rzZbPa+bwVbBdBkUqBpshfB+nw+bZn6
         Lus/W5rfXiM+efNDcgFWSgas2LgDxfZBtEtvkz8eI0n7AU/wJWGFWdm3z1wmnYrjrG2p
         Ou4j27ftSYmlU5Nv7pcC82QCOb4X2CFHeLGrP8RrD8ccsVTHb5Yo1731doWhAiPwMIZP
         PaoA==
X-Forwarded-Encrypted: i=1; AJvYcCX347wyQOMs7n43FEbqelJILhN5srNsRly7OHAOhmt1AduW3MlFT5VFCA30PS6+r1wMndrqtHlfmyxWbMH+EVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wZectkCC/iTkuRswKKX7gUiWw2FCFROTelKqaPVSEGLALRuu
	rK0aZT8MDU0wy7spSAckqr2hpaKBA/V8OMunKuUaky70ucUDmlaU+b0w
X-Gm-Gg: ASbGncuVLLlx/gWFq9HJR7pTpEDoP3bwIp++r8OvIqP0bxnOaA2hsjEtzs5a+RUUS5v
	LCaIybAr/1BfrtsEylGmiQOrzFnWV3/ckB5Rk6SDcaNlC50Ak0IV5nq6em9jR7FBJRjbNizJMlv
	DeVN9B6DbM5XmwG59bwRT5AxZKLnDoAToF34797/THYTJUmir4PL0FZXvpWYrHltFh9HmqJKmCF
	v1Z3KrcOTl0erYq5Mk0RpE4m20Bq65g9tRY+WMwwkwWGeam6b426YTpd2eqQAGPm2OCT14fJkbT
	xLC1UWm7Gn0/mRCf8IqY84lqJy/sUZOQmGU0YN6GZu5ucJXDvnqKyf0D1S9SHvjEObrUWe8YdpH
	yy5R/4ASvXL23o1rrJJnM
X-Google-Smtp-Source: AGHT+IF/xw2akPqfiTx346iDoeH7Z1/kqJEVjbR3GnSIaOpGaqTCjMLhCHfObu3TSyZ9Zry5A1RkkQ==
X-Received: by 2002:a17:902:ec91:b0:267:b357:9450 with SMTP id d9443c01a7336-26812179838mr1096375ad.17.1758066234099;
        Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2679423db7fsm59353765ad.70.2025.09.16.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:46 -0700
Subject: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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

Add a net pointer and orig_net_mode to the vsock skb and helpers for
getting/setting them.  This is in preparation for adding vsock NS
support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..ea955892488a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
+	enum vsock_net_mode orig_net_mode;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
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
+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
+}
+
+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode orig_net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3


