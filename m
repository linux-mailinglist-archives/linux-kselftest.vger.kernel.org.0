Return-Path: <linux-kselftest+bounces-31661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803EA9D376
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62D79C57CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71125E813;
	Fri, 25 Apr 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFB78j7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8C23D297
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614081; cv=none; b=c0CRNrWdjSF57Kx7uRJdadkXxX2RBEyAQu/CsQEs23Ft1/eht6Kow3YFUILbOtDLrboOLd6NbazZf+/kR2EE5y3i0kpuKCtxourwxr547nwlBFnywgLtwwkBI5Ye+o24m5VDAbiu3+tDLnzjdZi8Mr0jLo5ofbS71xbJ684WFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614081; c=relaxed/simple;
	bh=ybXhKATj7CrisJsV3ztXUW5orezPZDhbn3Vyd8hzv9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5UhGAGcmzAEzRxEHKN22qSixhLTPQejo3MNnGuvEThR7PCc7brtkpSUVnrcIwdBohR0BTdq+rOUB8sBC4xZU7blogcG2ZYiHNz4sglFle4I33bA5r/Aht0TEx/JdyjkeuZ1mDy0UmulkhFHX5Y3XMeyxh84CfTvtSnZFji+7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFB78j7V; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736d30d2570so2320042b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745614078; x=1746218878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYHTZhe8vYe+8ShSl7Hzn29qooJtmnsSGB2cu4sslo=;
        b=EFB78j7VgwT37IdQo8iBIMZc/ZfiEpmmb3Q09W8bDSIfQlNfhqOTCeszfwEeuI7ZFI
         GY1ba1sGBd1axC59qXu4VDEojxQ632qNdUQ/eKH2GfXSNkMZfWISBL+jCovUyVbojQIh
         AqsQ2yf04waMGAjSE5iNJDKvBqvCG7BtcpOSPgM6SVfBohWdMlvw5poBOz6t1ZK3cwMs
         UzMjKGHF4iUyIRhXSGhfsmm1msPoIE8StO41jkrCERwP+CP5jMsWbru4c+8qgwCytmRY
         /4gMhZXiB+gVOX250bicSttAckcwsfSYCRzAIKhON8uW0ut6SjAxED53yQrV0RzgYu+V
         UBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614078; x=1746218878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYHTZhe8vYe+8ShSl7Hzn29qooJtmnsSGB2cu4sslo=;
        b=RYjO844xgjIh3zyJ7AO84/dFapNoPF0/6sGYbj7rMzk6ISUGOmOOQbmrz0oeQXJm2S
         myMuRUeGfeUiP6tNgmpnurGWGqi2AlP7kaxd2qBFoV+oGNkndi7+Phx4S4NTk0Y4zi/2
         4pLoxu7uAKELEE3oh8Ef1Epdj8MNx1zE6a2DXHg+d0AV7mWsPcBN/3q9n5QyJ0JfqmMm
         KeYd4OFv5/P2a1pSXmxRG/0AlwoJ7031Fj3c7F4VuIsZzX7r81tQ3L4K6NuyiFH0/KHD
         xEUgPyD0oPTmNpDo2kkQYa7FYTgi3N6btudxBEyYfXZ6oXyLEVcqVYdOzjNHB6b6flUf
         zNLw==
X-Forwarded-Encrypted: i=1; AJvYcCUR9wuStZEQghJZF5bgwVnlJPHGUeqHGy/YuA+OwZSYw355wJeMzYT3i5w9QAEDXWsl3kBjEBR7FREHtqn9SiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/CvwH8QiIitqcZukDQ4dDetNMyEDrYy2jDIXZYHcEg4BDnuo
	nPwF7tPUe+/GWOAdneoO0Pjq2n/pzisJyQieDmQ3iObkohTpkY+87ZEtTzrAaI8MfxNXcKBjg4O
	9mRt67FFbDTrq9s5B/zqywg==
X-Google-Smtp-Source: AGHT+IGaTQdBBpN1/zbebbMNIQYAb2oZBmPyA2BS0cZfk4sArdWNYXWT5WQfcjBFVnhVm0ZK4ipk7Cf1QSUSz74FMQ==
X-Received: from pfbci6.prod.google.com ([2002:a05:6a00:28c6:b0:736:3d80:7076])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8c4:b0:739:4a93:a5df with SMTP id d2e1a72fcca58-73fd75c4d62mr4859252b3a.12.1745614078118;
 Fri, 25 Apr 2025 13:47:58 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:47:41 +0000
In-Reply-To: <20250425204743.617260-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425204743.617260-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425204743.617260-8-almasrymina@google.com>
Subject: [PATCH net-next v12 7/9] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
enable netmem TX support in that mode.

Declare support for netmem TX in GVE DQO-RDA mode.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>

---

v11:
- Fix whitespace (Harshitha)

v10:
- Move setting dev->netmem_tx to right after priv is initialized
  (Harshitha)

v4:
- New patch
---
 drivers/net/ethernet/google/gve/gve_main.c   | 3 +++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 446e4b6fd3f17..e1ffbd561fac6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2659,6 +2659,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto abort_with_wq;
 
+	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
+		dev->netmem_tx = true;
+
 	err = register_netdev(dev);
 	if (err)
 		goto abort_with_gve_init;
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 2eba868d80370..a27f1574a7337 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -660,7 +660,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 			goto err;
 
 		dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
-		dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), pkt,
+					  dma[pkt->num_bufs], addr);
 		++pkt->num_bufs;
 
 		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
@@ -1038,8 +1039,9 @@ static void gve_unmap_packet(struct device *dev,
 	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
 			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
 	for (i = 1; i < pkt->num_bufs; i++) {
-		dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
-			       dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE);
+		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
+					    dma_unmap_len(pkt, len[i]),
+					    DMA_TO_DEVICE, 0);
 	}
 	pkt->num_bufs = 0;
 }
-- 
2.49.0.850.g28803427d3-goog


