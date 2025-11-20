Return-Path: <linux-kselftest+bounces-46054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6BC72012
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 04:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D923434CF13
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91A2F7449;
	Thu, 20 Nov 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNp71wbV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57552E7F05
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609834; cv=none; b=hvYmVybcDn6duUoWjMUsv+pxwb8yhwVQmBJo78dMSOkH7jUR34j6wAagiIbWNH/+KOGq9eyKey2l8ywv1yRcymIt0alOuX8MuJR0Sr1+I4cvvDyLwyl/XazLZC5a9cFrkJc89sFVs4GO6a5SEHExCVFPtqun1HJTNk1hRPSzMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609834; c=relaxed/simple;
	bh=wuDktkvkmPPQMkrr7ULLpZaYVUd01D6PWmVFjXlkyqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lj4gz7u64XByls9pNQYFsBJgwGHG/Hgg5CEn5XOLQo0VrqNfubjpfaCsOuCnScwyo+3DACwKtQjbyI3KK35rH+cFSxMlz208NowCjrHoqpcuvSaDfxOSr6DvvBBtmzAt+Ewbzh1IKK9kJXlXLrcplAaYbsIKhx8QVwXf5u7YZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNp71wbV; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640d0895d7cso519248d50.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 19:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609832; x=1764214632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZTyU8CT4iARbspCBMuLPPZbuWjZ7S1vt4fEqVtqV7I=;
        b=GNp71wbVJAfsI+xGI91OOvFT+BMpzV50+PagzJ7PVfotIJwvNsTlI+ir7yesWSWeJI
         SdTqXFDTSrud/6naeEBiQxx2uZDg68awdbq0YVNrInrOioeIyTrxcnFNIMikB/3kCyO8
         Y5cxwP2tG9YBAdlnCu8lm4M1LRGa+K9eiLbPJmu+MLcVLmsHbYMh3KbpuIiPaiyBuuGK
         BRCv2VlN5kipm5P7lb4cEIRr0tlh85FVLTzVlC80vlEAZ8EtXqg7hkS7n34+V+rxlaMw
         m+VOzp/7xYHt90eJA/+DnyKTby1fnyEjCVrccPgch3w0XyZq+p4sC3Xu7ywN3a2qzGsE
         voBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609832; x=1764214632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZTyU8CT4iARbspCBMuLPPZbuWjZ7S1vt4fEqVtqV7I=;
        b=Ai8Ha16y3KYkjWO8biL8/6zEePTOYAnywDr/2/zwWUkZN73cBnq3XGnrhfTHfBKo+z
         df79BngWVoCxOcUaF3rjdni5SoCsozsqQXpJijaJ7vXg4ZO+h/BZErkRCR3iBRn6CwGB
         YrcREsOFQg6ihzbN7PB39wYJTzqCziN9U9HLMgx7+bj+CPOhL4dFwmta2cf2u4YNwaVw
         xNM7QIpqFq7mN46YvN/+5zIqvLe1N58jolO58BDL126ASMpveimmm0Ql/TabWGHzv1L/
         hX2POY4Zqk2fusaAZQ3InTq4uwSGddkD87AfSUdSzv29ddVaUUiHUTCNm6BzWiHsahnE
         lrHg==
X-Forwarded-Encrypted: i=1; AJvYcCUk3/pkgSFqaJIlQcMTlE7vJwJCFGIwdG7nNceAg9EZn/Yjm+otcWoP8X2lIaKxKxN5UR0yWQQId+GK6XScrmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAg8ExH/YRj2uYBXqa9X3XevjQA924z2iem6T46J8Q4FQyENpb
	m5QrWe6TXM/UTww7/LtYgrr9Zt2rOqW2VLRyH9dVICr5Jd8mFYmP/jg2
X-Gm-Gg: ASbGncudCwX9PuoRSCXx0RDAUFRhhaGrej41zFAJAzjBUUZ5CZixdk92Zc2Nx4dqwxR
	glQICID8ciAMPHw6EmNwft8scCEVsdDstVX1mLdQf5jt3FGCddYPADHcm+2YZyEJFLzhaAjkCT6
	MOwRZfyX+Px0sE23QP0yMMVn6j3CpSXVxXqtVZgVbUso6I5dj2TfwtcuGaG+OZL3f35AJQF932L
	nr8ZHyFFazKo42PQeGpQn/50JK1dsGKXjr7xx3qe4wSEvrYmORZtpz64+G+UT7dIVkiBdx/hdAY
	YOAIxI7ltStu2Pcp7Y//y92jM1Uuyfx3yyuYSBOeaOACThQF92lH18GSZRM/2G9hxot+bGTpps0
	1oj/3o2dxaPKHKa05FZSUB5y7RHqrtF3JuP60twusbA1X+pYOwHAT145DmKL6c8ONxa1TE3ZZhn
	CCEjvZcxB8p0OZnuNwRyOl
X-Google-Smtp-Source: AGHT+IF6XnzoA3Fp2yvsn96tIgCF3KkDZHwgr96TFqQEESgZBGU4z3LvWvX/N+AZH+r8JfoIVeqOHw==
X-Received: by 2002:a05:690e:168a:b0:63f:b605:b7f2 with SMTP id 956f58d0204a3-642f8df31e4mr616438d50.10.1763609831701;
        Wed, 19 Nov 2025 19:37:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f71ae739sm452236d50.25.2025.11.19.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 19 Nov 2025 19:37:08 -0800
Subject: [PATCH net-next v7 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-1-1abc8467354c@meta.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
This field holds pointers to net_iov structures. The rename prepares for
reusing 'vec' for both TX and RX directions.

No functional change intended.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 22 +++++++++++-----------
 net/core/devmem.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1d04754bc756..4dee2666dd07 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -75,7 +75,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -232,10 +232,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
-		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
-						 sizeof(struct net_iov *),
-						 GFP_KERNEL);
-		if (!binding->tx_vec) {
+		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+					      sizeof(struct net_iov *),
+					      GFP_KERNEL);
+		if (!binding->vec) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
@@ -249,7 +249,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -295,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -315,8 +315,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 	gen_pool_destroy(binding->chunk_pool);
-err_tx_vec:
-	kvfree(binding->tx_vec);
+err_vec:
+	kvfree(binding->vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  direction);
@@ -363,7 +363,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -414,7 +414,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 0b43a648cd2e..1ea6228e4f40 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -63,7 +63,7 @@ struct net_devmem_dmabuf_binding {
 	 * address. This array is convenient to map the virtual addresses to
 	 * net_iovs in the TX path.
 	 */
-	struct net_iov **tx_vec;
+	struct net_iov **vec;
 
 	struct work_struct unbind_w;
 };

-- 
2.47.3


