Return-Path: <linux-kselftest+bounces-43640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A03BF41C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 02:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5423A18C46D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 00:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7021C861D;
	Tue, 21 Oct 2025 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KYH69awI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13021A01C6
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005346; cv=none; b=bkNiWAGZxRLNSH00GI29u9LDirZAh9gsJCdL5gQ4KD0eCVt+MhpBiZ7Yn7IcYaCX3k0YPExWQ+0aBOt4VrkwQC9RPQgpT4GCHErKgngzLCVDnHYIiK8iSGhoYUxBrP1N0GCSvG2pZXRkNxqXAatjeHpB5jszGLjF1srdGfSP6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005346; c=relaxed/simple;
	bh=LDHuftkfJUzPNUuh9kXo6Q3FBGbP3xrGn0Wol3ZW4js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekCjbGWMqZeMItqu4tYaEwT+XfgnByLOz6N8lJqRkE3LNLeinRPmXYfgZvwFvEjRXI8aSOyW6x+7tTfURm6ErooieW2UF/Tj0KTtIbsf3+zLuciJjVMjCSFp+S0uLqm8vUkMIljxBgiCSn0dvYd+B7F9uUpMxv2ypyc3YXTHeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KYH69awI; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-580144a31b0so2495942137.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005342; x=1761610142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wh0gNpXNnj8TcdXtVkip0MO+OiSr/N3ozqVkyEmZbiA=;
        b=KYH69awIcsEGRYA+OBfTsfkJ0DRI4p5B88h1ngPGp8Mxa0Uv7Mc3mD6L4F/lB3r/VN
         O2mPfkv+bPHAGxZ1Hjkid/CkZXR7U9jBX6h2th1NoPaUfu9HQkOJRChzSCCUcvnGQbH0
         Cc6XOOF0BKisxg5NGsIhhPuZPdAWmte3RmteuLddcUjtUZbP7RkNlJ+EhbwoL7eupS43
         gmM2nn2TWOY5HpmFE8OMQ8tsNY6bUXdByGPQ8Hq2hn6AneprAPN46iWktku9NG0IMSaz
         lpCVp7g4eojxuft+xiQbmtB5+v/PgqMCWYlZh/txZrzY+1YYUMSWY/DWlROlnlNLkobj
         xY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005342; x=1761610142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh0gNpXNnj8TcdXtVkip0MO+OiSr/N3ozqVkyEmZbiA=;
        b=Py4+DFnHfuhKkdocok4Qyh3AeZsd9Yhka986jJc6xAHgOXYWQrJuJ27dVvadHHGBWR
         Y5FmqQ5v8eRebXGwnacsVtyTrmgoZWpAtkYy8UTCDtE+xV0IoxEgGKhIxWRhpPF/pA53
         xKLmXJjXuw+KdK6ZDwXOyUZqLsgmpcFaxyrMgNm25iEqKRBY+IymyXkIM0noZYHGM8rz
         x+lODnsKZzI/JoTDcY7VeApQo8zafRzL5BA1JX51dZqAPSSEQEKjoWtWjb92X2JEFjih
         /aPzDvITZx0Gn9+Xygi7ejutY+QimClsiAKWJfwhVUqsaDmfBhxITo0eNDW+6EUTWhlL
         rugA==
X-Forwarded-Encrypted: i=1; AJvYcCXzgwx5uYN0CsqLi984PQAp2JUEN/zbwjNHFugOpRf+tvC4RFSeIoHD2ckmFmv4Otp6U72/Itjgmg/vDLaDBgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6Ro6EEJPNMmEejZqg2mqRb2lo4+dFqJhOo9mOdGO3Vo5GJaw
	rgC8tQ1yi4bb5qAkheZftl3wKoDrpw/oRGm+HqC9LcTWB/mp7wAFHt0ib95TEWPH9dz4UfRXsBt
	bxEOA
X-Gm-Gg: ASbGncvZ7CwJkrMOTwbJVjdUmeVJHBsqAKadhRf5XiKHPB8yy6sZFMEYOuImjMLJyBs
	IoGmt9N5SArRpDZAD07kuEqIWHxaHLqOon011hFL3I/y40c2FlbTGTqMqByZPzUdm6nbTcvTl/E
	dNGUQ0HrC5O70ebEvRRhaARyUlI+05vZTNFVzkBXzfsJ3UvA5LACs3PyChPQJByugLGBCcFqSJi
	O1bxk6aKll84yZYdZYS40HgtbFuCkP7VdIUetyKXPH8JiMsBbBaEqbkB9qG9NzIhNFJJN7FlUmD
	rbpVYNJeoRaytG2lC/6TIaD4go90pW1QnBx8N1wyJElCSdKwDbTBWcXFOpxp9ltJ1Z/B1sPY3vy
	wXeNX/fLUfOgLi4HTh5CcMVJDcF8jHCb0L48/qpYwl22x6sG5FyW79bOA3xAMNLqQiKxtobhXNt
	OG40hsWu0lvWjdDDDB1CN8A3zCibjHE0+FUgXFZlFWRF+WHxyxYgp6eAW46N/euQ/NY650K8xj2
	bzxSNiQdGYov6GL9Y9WEA==
X-Google-Smtp-Source: AGHT+IG0ndYvX9zTAvm2KWn2q1XKGRimjxxOoCLwpUa9MT4euTBOB019JcZ829K5pfY69/fTaACVlg==
X-Received: by 2002:a05:6102:3e85:b0:59c:5e29:dd8d with SMTP id ada2fe7eead31-5d7dd6a3fe6mr5404303137.28.1761005342511;
        Mon, 20 Oct 2025 17:09:02 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:09:01 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v3 3/3] liveupdate: kho: allocate metadata directly from the buddy allocator
Date: Mon, 20 Oct 2025 20:08:52 -0400
Message-ID: <20251021000852.2924827-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
In-Reply-To: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO allocates metadata for its preserved memory map using the slab
allocator via kzalloc(). This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled. kzalloc() calls can be
randomly intercepted by kfence_alloc(), which services the allocation
from a dedicated KFENCE memory pool. This pool is allocated early in
boot via memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it. This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec. If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is
loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of slab.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/gfp.h     | 3 +++
 kernel/kexec_handover.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0ceb4e09306c..623bee335383 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/topology.h>
 #include <linux/alloc_tag.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 
 struct vm_area_struct;
@@ -463,4 +464,6 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
 /* This should be paired with folio_put() rather than free_contig_range(). */
 #define folio_alloc_gigantic(...) alloc_hooks(folio_alloc_gigantic_noprof(__VA_ARGS__))
 
+DEFINE_FREE(free_page, void *, free_page((unsigned long)_T))
+
 #endif /* __LINUX_GFP_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e5b91761fbfe..de4466b47455 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -142,7 +142,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	void *elm __free(free_page) = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
@@ -348,9 +348,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
+	struct khoser_mem_chunk *chunk __free(free_page) = NULL;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0.869.ge66316f041-goog


