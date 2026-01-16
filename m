Return-Path: <linux-kselftest+bounces-49088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFED2BB8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 06:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E31E730031B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 05:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18534A794;
	Fri, 16 Jan 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEzDqk8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4A7404E
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539803; cv=none; b=Q6LvtwZcOi20JDGDDCXkkT3f6xC3ACnCKHEE7ZwMx+c9r9EHLS7slgCMQFWh8oUifRbaRDU/xdiflGrbhaFgm2Ptp0eaeS4jX1VxmBlMv7I4ICxoQWETijizCu893LbHLdD3tOrDjw9xvmwY6ZfO88b49G0/viVRjdJh7jk4I3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539803; c=relaxed/simple;
	bh=QnAdtI5+4DFmxFeKdHgtB5jd0gU6PEbg0bZ2tI0AuZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3okf3oe8qcGDlUrymrSa3rW9U8nGJfklI3ho+43YTsYSCe96YjfZuvYZymBMlphTieEumiBGn7weFLiHGfB40tYcPpChmYR5NDXzTsmE317QAL4lf8mA6tKhee4lG6R0xz849KUEpEF+x5rrtnEeaCB5LEIipG7zqvcT+Fl+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEzDqk8S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fc3572431so18135417b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 21:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539798; x=1769144598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpPfAIHBzai3/e/zMri/UCW5j7V8nMCJkbV5OCQGhRA=;
        b=SEzDqk8S9FbFi4okuM3QhTEkgb1CvBaR8TdX18wRjKo3y/8v+5mIWiVLIRsTys8hQ+
         Fxp29xgE5cu9G3CTO1dnoKauUbaJ6Fsxvp1yfjRf8DFi/5+iAa46PLKBxJh51Y9VkGox
         gJ/IqdV/BucrfCk+Lh5nOQGK2Y41f1XyPzodQ6iCoT8i5pbxo9y8lZ0z9y8Ya2V9SPxP
         FsNUTItvBPFo+XRoX8QfbbjxH3INN+I/j29YOREy248d5eTLufj2nHJzPxm+w9OPOSCX
         BGzzp3I6cKfuy0weAzH2e+9xe6ZQ8MmQD+idbQBfpdsS7g0Fy/25U8+unSGMCc49GhoP
         iZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539798; x=1769144598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpPfAIHBzai3/e/zMri/UCW5j7V8nMCJkbV5OCQGhRA=;
        b=EPffV3glb+n7pc7hsnsNes0N3uJZ9aGThUFv0TIQzVrgsPnQ8G256tOg7upQFuCqZM
         l4FWqPFLGD4JQEydVdpoTnUIAQNHLMXfUtuapUbHP0wLnoerNsYOPW1h5+BN1Drb2DtU
         82rxpNlNMZfNC38BqIdI8FSQRmBurG/oTJW3a4BJT1h1WjJNg0fJ3822HRGHaqO7PVP1
         A5mEmgkVW280G3AVOdz2aZi+nlopubLuyvB3Mr1YgX5ZIOikFyGlDdHwAk7NwemLIWpO
         ye9jRHQOpn1KuktKNqWaeibGER+eNqvfT7lXx44tIQ73oHGKSYh+FQPSKRcsVkPfHAba
         WvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1dRP6EjbiNr0i1424Ho0o2FqkkJYcPdlhxcpsFa/h3+vLg5Q/zpyYXBjvBBBz/4UTRwNaClypejJvMRuIcx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfiZ3hSk9/yFP+EMvHiEli/7hh/89Qb1NRLt5dACo+gxdOIxH8
	EOO8k/HCXzUfDEWliv55Tdz2n8X/FdGg/Usk2lIQIdpuD4Z/G09JjoLW
X-Gm-Gg: AY/fxX5XRR2CWWishYUOamW7C4R6Sn2AP0bmayUu7D5mHa2BeT/9QACDswPTNMK93Ne
	lr097tBEg44z+bKCUtIAClXvSOmbugrVm/kf4Ee61RCnFQNQlCDCtqTxRlYqdgLxu+IWaz3V0R9
	A18V1PrsZqUKAVPVwuomZZwke115Jl3O1pMFsM0k6q1+ZyZ03q4/XRObGfku2TeXIMio2JKeeHV
	Dww26wZqRNGFgx2ZMWymvbZx0LCVRMEEhOk1GvPcyAi7rhVle65EH6rvjVP3YJq6vaER/zhQe5d
	CItcbPGhoZLpdsdrHmsh3BUPU2D2zDLQjaMaCriK/o0yqPzP54IHO8OxGXxl/Fofc10r0JtenDz
	vO35q1jl97FYzaexZNgynzg4/IDp3ABxWuwl1HqfAz3Ejr8QuXPwhbauaGQEYsVTFSve3tKNZYv
	NGc3c8eCx2
X-Received: by 2002:a05:690c:6f10:b0:793:afdd:e63e with SMTP id 00721157ae682-793c544d6ddmr17343937b3.33.1768539798065;
        Thu, 15 Jan 2026 21:03:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c72aesm5327037b3.11.2026.01.15.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:17 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:12 -0800
Subject: [PATCH net-next v10 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-1-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
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
index 185ed2a73d1c..9dee697a28ee 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -85,7 +85,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -246,10 +246,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -263,7 +263,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -309,7 +309,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -329,8 +329,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -379,7 +379,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -430,7 +430,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2534c8144212..94874b323520 100644
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


