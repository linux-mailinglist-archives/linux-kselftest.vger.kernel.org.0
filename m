Return-Path: <linux-kselftest+bounces-48449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878AD00848
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 01:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 873D93024110
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDA205E25;
	Thu,  8 Jan 2026 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK0zWCxG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F561F3FEC
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833923; cv=none; b=khOnJoD8i8RVk2MGUuIl0HRMX9nWt7BScKYWic3uFONHzYf9ors0bx1tXT/q2t+rqjcCxm45A8dBOGTzzJ39nSGQSl0PhGygSHNLlp2XDPSz+Nl+PzvfODQwJz8wWqRkXEkzyKn4ejsNRBWQNh7Q0OLdYRAl4yhZZ1Hf8bfVJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833923; c=relaxed/simple;
	bh=xiO09bVBGC8/K7L0bw2p16Wp9QD28tXsWfMmjzD/Ua4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ko7kvvMSwIMUfXHiTWBttddMrNJ28NKZBFPF3EFTZnRw19EK9O9u+SA5LWFhE2gPyUMyotLFYDq/4AyBgoFPIoxaL1KZYZqZVDnwM35pn01uJZqliZ0wvbwpHnhnVmBS9xDQCZa7T0OPfqCUWyhknxOHxDNYrSAWq2C/UBpKZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK0zWCxG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-790948758c1so29515837b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 16:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833920; x=1768438720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07Oq7s3cDlA8pW6W82CkM0efPRUiBJHxCtezHHHyhNs=;
        b=nK0zWCxG+7ICfWOQws3yIjm43ZkGhGo4uuZ4ZqbH8ilbkjQ9rREnikv5JtGbcMOun5
         zwc6hf1kHfJkLoadUAoB9Lka0n1JXGBwSXEbRdJS582scMYHM5t3IYF3rNnPXxo0wcPd
         qCo7m2Y7IbkLIemmbBBxPswVAiBk488Sco8JFSlcKgQljCdJ+2z0F2isc58DU9Q4ulIK
         xtoWY9D4Yb8LrDQ0p4B9llc/5sX8n3Sh2GvBeVQ9Q4nivxk4DOGNxf628OK41qgnWDc3
         NG+LIptZK6vuUmYofm5m7UPKO5tPhTrrNTMRm9bxCcaN4afmY2b4gBVo2hIeIK7SFUXh
         5MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833920; x=1768438720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07Oq7s3cDlA8pW6W82CkM0efPRUiBJHxCtezHHHyhNs=;
        b=DshmyhSsW/hCHsRKtik/Fgv8192BYZB+8HoapFH8nygUhzz3aTH3I8ek/ud+XbLPS0
         fEdEpm7BX09XAus/dBgcwsZ/0KCtDnjTowfNmKIC06Z9I97Gqn0e9pGIiycJpZxNt2gn
         +r9hdPQQItq2/3lY2pwz8ah1Lf1hxlvx5hemrOBBb/JPqOeVoocb+I7dJygZ1lR67eFo
         fjQ1+xQiKYdu6Mheq/hGQ0bn27i1QDxO0p3Do+lNIm8Yrpb7qHNEYsPcRjDVx6/rJBgK
         ++l3PyYfLtmVaLGwz/HVoNWw7Tt+ECQxhSj79/Oz4ZGMbvNiH973xNIYu5YaAKOVCSqc
         7//g==
X-Forwarded-Encrypted: i=1; AJvYcCW3UbJ6XzxY65LBcL+OWrQu2HRkUwHsbHhS1Z57lbuiyE8oW4wZX1VgvVFX4zNIvM6N+d2AnXTxHbUSB6UEfws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wyoUIrOwEJYC+YFy7EHGn9kmFM57E4KJqQtIHHNCfeo5bTKM
	m9KDPVqEvaQGqcACH2Hi2p8lBWS7+/D/APTf85JRsWAU3OLuY/XdtgvF
X-Gm-Gg: AY/fxX7doyyHWYt9H5GVBiAmiJgU+zE9uicArWDVW+uVi4Pgy8Ph0Krp/hZBIUmlWgI
	UJAof/BL53GCm9qF+8XGiMUuBVR/igHldt+jkZ225pjwJuu7YuHFsnLXX9WwRwSJ+krqufuu+QZ
	ibu0Kf2RSNsXswhSh1eZ+ROF/X4X31HofCrMkMbEc0FAbqVt2sbZXZL2NKTb/gPoHvTxIRGVKyT
	wi64se2YpJm9MBsQGKPo0iKMDDi95Vw9uH22L5CH62W3KjwM5aXVHQUQXryk2i9o7nDduqmjzhj
	ZPvZ/AzDTnhzpe7axkCXHypvAfkFJFktr4WY6I45Se1Ai5LCZiAXjgVR+moGcl532Zm0wdZ+WnZ
	h7dspJK+Ul3+MJeCyABEOXax+WGaeyXq3jzeKYnBDbKJwUP/i3FElkrl+Xlj6r1q6o13mFjFBvW
	PEvQ/nau95TAxfWM6ARx5w
X-Google-Smtp-Source: AGHT+IGQTy89arTbFGwfJfLq1EIuhj9ChaqppYiVw6O7/CqtpiLLwNSu2qqwSquoJsQ/2MZMGVqI+A==
X-Received: by 2002:a05:690e:13c4:b0:644:db91:eec4 with SMTP id 956f58d0204a3-64716b5f636mr4848198d50.20.1767833920101;
        Wed, 07 Jan 2026 16:58:40 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c500esm2695494d50.23.2026.01.07.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:58:39 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 07 Jan 2026 16:57:35 -0800
Subject: [PATCH net-next v8 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-1-92c968631496@meta.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
In-Reply-To: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
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
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
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
index ec4217d6c0b4..05a9a9e7abb9 100644
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


