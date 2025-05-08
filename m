Return-Path: <linux-kselftest+bounces-32636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431ABAAF047
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 02:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBDD50194D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36931217F31;
	Thu,  8 May 2025 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/4RuUKx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53520B7FC
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665329; cv=none; b=TrYAXWHVKzTOpSmW5zViFu9JZYgrwEFKz5YNsyvuUVFY/AtiaVUtLanH9tRxmH5gvjI2Kd12mWF2p4I3l6U/++p9jbMPasfT3linEXoJxEbq9bAmDrOtMx4yqcAIXnLGxVQxPW4c3xWKbKk2aZHus1KBAHaKRIF3JdWxJZrPeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665329; c=relaxed/simple;
	bh=4kwdISEystgWEKePbbRF2THmEECNez1671J+/5yKtH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jke2q6MPLxusCJOe2NrMPoCVzWMJdv0zvURSuDxYLnrSchiQz2jHN58Ik5o6EZjF08q+2CJZyqSnv6tCVDGSluxDxBCFqPMdxVZZn0xQKbIlTF4FccrqoyxWDMYX/rkg9KhkOLI5va02ghHkmSp9dCjWuWwf2ruv0tVWKlVxLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/4RuUKx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e7f041997so6109445ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746665324; x=1747270124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKVG3k7BfSyXp7F9y9MTAXbc4VLGhRFH8VNtONiymIg=;
        b=T/4RuUKxxavIHLoQFuXcF6Hy5PhRjzQfC660kOuCBrEUxIsgjwsHpWlJfdw1DFvXHL
         rOoaROnVQUE+YrVJ4Kf6z+yHtHKJTgnygmkZJqXlHLwkKnH/c2aVqiBJ3BwSwM7RhRag
         MCawIj16lbZBoyMz7nSZ49BrBKWuWBtWAlGjiLhDFhjF4NPVmwD4RUP0zFBPqJ90sZU7
         6OuQgURPpEYGcogz/fMJOk1a1BzHD6EncsI7vJJhBAXnlXFuBLBs3cuWkv/qincL9iPx
         +E1tcvGEeuLiiSqkZ2k/wJmqHPrs98SAWXEvJHkrG4nfUpZvBKIZPEuilWfeEgeUYQTD
         8bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746665324; x=1747270124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKVG3k7BfSyXp7F9y9MTAXbc4VLGhRFH8VNtONiymIg=;
        b=gsPJfAGzMmxBEAr+Qn8lWVh+gJgMXJm6ZL9Dfto8FxWD8EwppxYa0a/kS0ten6wXws
         1Ux1nRYEXBcXrio89P7J9Py0W9MmBA8xS0gE2jc0RKHNOdyVaLHZ2OzATztx7fET2tkp
         Qv7bywKH9ucOWIH37f5oeUJmveeLn5AqD6m3NPTJauyZTmw1JkTnAzfHKQ91OSmwB1JV
         ol37zSnRP3ttIsd8op4yb+dmRXc5wJpVOEiZosDnwez/4yoILpowYcsJobwtmwTxcglq
         tAg6VVc6ypmgZFT3zu2ZdJydvgnHugWFF640GteAfmF0562i/yxpnz6qVakuHoWGCg80
         NqYA==
X-Forwarded-Encrypted: i=1; AJvYcCV26Btozez84tyMLUmKAKZqRcjkc70sgaxTexfEZTxd6EtmKgX7cs/CGd8z89Q3CvMM+PydhCFGPGWDnA3jNWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKHTw8luTfud82/p1mEHopF3vOexJVYyBnMTltKxZpT5q00tG
	A5rSckrIa6a+uv+c5mZCuCttxZhOXlb3vUhckHdqv+F3dJdK7gEM/QJYhB5ixitBeP+VR75efPf
	DwFHYLz+3f3R0MmpJiPcSNw==
X-Google-Smtp-Source: AGHT+IFFw2brHOWPU8H1Vk3K/EfTitU5gdXdRhglmyZlG1uOqexHur9VD1hlW9PlU+j+XdGKdr+P6x47mYNlHtIPMw==
X-Received: from pjbsp16.prod.google.com ([2002:a17:90b:52d0:b0:301:1ea9:63b0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:188:b0:223:65a9:ab86 with SMTP id d9443c01a7336-22e5ea5514cmr87432985ad.12.1746665324471;
 Wed, 07 May 2025 17:48:44 -0700 (PDT)
Date: Thu,  8 May 2025 00:48:27 +0000
In-Reply-To: <20250508004830.4100853-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508004830.4100853-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508004830.4100853-8-almasrymina@google.com>
Subject: [PATCH net-next v14 7/9] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
2.49.0.987.g0cc8ee98dc-goog


