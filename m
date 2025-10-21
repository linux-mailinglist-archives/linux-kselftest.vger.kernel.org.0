Return-Path: <linux-kselftest+bounces-43639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C6BF41BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 02:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED1694E69D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CD17C211;
	Tue, 21 Oct 2025 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ehty/tAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746781AA8
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005342; cv=none; b=L7XmVxPUJd2jxDcP/PUO0xinnB6svx+Ot9vKRXX9B/hb4h0DIr55c6t1i6Cje01Q44hiUTuaPJOLN1qx2PlK4Af9LpwbBsS/i32/UfDWE7F+UMUIhS4s7/+7z3+xdxTrWbxmM0i+ZqYC2AScLm2jmRd/OzMaAZLakcR286iPPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005342; c=relaxed/simple;
	bh=xIuMw8XMRWLgufCuYNoWPBcLu0nLGH0NZhBNT+EtTIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fokdpQVennGZPbhZ9ikX29ofIJAFe6TpCWnmbvV/c0DtWijcGHrSZaAVGJ/iWCbJoUdjJbECDfvTTaBSsh1momrIUclhf5HSTYPjNFhSheBT72fhEm+M8D8ce3fr7ML619kCRaRfd7pGlK0eBPWxgWwx2EQ0Di5Fwr7l2QOudGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ehty/tAK; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54aa0792200so3758433e0c.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005340; x=1761610140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+GEFK7rnEt3wQnfXqm/bMcNjTmF7K5naCxuLWf6Icw=;
        b=ehty/tAKFGHks2sbLBfXKyRy3Ea3aFc0DeyOIhbFbeFW5DkZJTUQHhdxdloUiOTExU
         Zo4O7cmT2FAwnt40WXhUDIxI7E+iaEY+sMTJlDvcbZQr3IoQv9MgDzFdhvI5mMp2posu
         T6RR1CPDy+M/1DrYCioPXB82XTFlrdxlQSfCk8lRgluKMgTYx8qSlnWiDy9YEYWIjdNC
         2T/T7ZZJbDgg476jM2X6VistbNA6MCW2xztM5G00yIIND9If/O4ep8HTRq1cHho7quVm
         hN3KT/glYqPgbrcN4v08Ng4moIt0D68j8Qt9o1RS8MiSIb6B4mauFuQO4VdDGBJFM2nT
         dwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005340; x=1761610140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+GEFK7rnEt3wQnfXqm/bMcNjTmF7K5naCxuLWf6Icw=;
        b=MXfrZ3E5px2DBvU+ETPQNTTXMCFqZkeZOL9HIeeZ7KreKu2fZ3vhPgSPTH95a74rIE
         3gxwvn8Tzw7EIbeG5bqnn98BjJwwUFCC0CDDS3QYqWYe/ZkBaGkAtva0yTDb7/I9T6qS
         D07umv1lOfgte5AHRHqokBzf7aop1RlE7k7pTTbWhvVbbLc+az1AXDS7j8oQ0QKgzq6W
         Kj7qrDIv6uInH9F7etFak+hLGG97XqmAXvSSZgXXbAcriVDtD5q5RX2oygf/3gJl1JbD
         MrbTEc3XuUMMMdq/6qd+nobQfRdaIZo2pS1uIZ64MX0zTkCgncer6RkhFZ+e8HJ6Spf5
         VJug==
X-Forwarded-Encrypted: i=1; AJvYcCUYUdVVKwv+LbZx2DVyNgZRkt5ijXcCPbOtBbW0gsD39M8GU7KboMbrARf3m0hyQWSRsW4YVAV0LunsROyNxR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzEdQRQSoG/+qmMqkaCPISeyd9hBc1nMBGVtvax4h2Ty9Kpr+
	fa43cb8OUbqZTCI4DUubBePMBOOuINqRfroRHRFXoS1Ok2InO2hcLWwPYraIwMlh6h4=
X-Gm-Gg: ASbGncsLLH33KPpK/oZN3jjJplscBILvE9+1H230Rb64XE5g/xih2XA0viMPMaeblYM
	LQLvojUIs8ZQx+DPS0r5TlpKoLB8wWjQ28HA3qWXu6HxdQyHPZ/tZB8sSRp3s2qWkUkXZnewgyO
	SsmgTM/nokAK02O0pIjm1gYxjOOZvDnqX5UgqlsYEtc5XZm5jsA5BP+jUzSCOly7VG69EpxpxfR
	/jTJNouA9kO9LKyh+Ne0TuV1ocSeora0wIEbfmW1xiIE/os3ys3msS3+jr85dQJ8YY6SZziNOBl
	I8Ylmu5kjeSSjuDZvnrp/2z0GqRF4XpkmyGktFjcJcKQzezeifF7dCuR4ZFdQsC58ltF1Slw/Ih
	84SooKbdOidn1RCWyCIcwyOF/wa1lWWAHdbVzPCUWMiiwxPvJWbDIwtrlaEhbBbGPh4OZSYGep1
	tXaivKUIbQcuLt1kbv6KtgP2qIcv5N5LWeVsJpsUAukvvBFnHmX2DCmM1mcsaoQKul3eEJCsDmO
	XCN4aJOmkSDkczH94VamPiZwGLnVG69ntNPkVHhGeU=
X-Google-Smtp-Source: AGHT+IEiKbkHyTIPqxuiQK/s9jE4arlePP4EQ1uFjj4rccnMC3Ytmd/xdu5/e3ZeVXOoj3cegKmXtQ==
X-Received: by 2002:a05:6122:2222:b0:54a:9cff:6fe7 with SMTP id 71dfb90a1353d-5564ee53244mr5078357e0c.4.1761005340123;
        Mon, 20 Oct 2025 17:09:00 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:08:58 -0700 (PDT)
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
Subject: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
Date: Mon, 20 Oct 2025 20:08:51 -0400
Message-ID: <20251021000852.2924827-3-pasha.tatashin@soleen.com>
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

KHO memory preservation metadata is preserved in 512 byte chunks which
requires their allocation from slab allocator. Slabs are not safe to be
used with KHO because of kfence, and because partial slabs may lead
leaks to the next kernel. Change the size to be PAGE_SIZE.

The kfence specifically may cause memory corruption, where it randomly
provides slab objects that can be within the scratch area. The reason
for that is that kfence allocates its objects prior to KHO scratch is
marked as CMA region.

While this change could potentially increase metadata overhead on
systems with sparsely preserved memory, this is being mitigated by
ongoing work to reduce sparseness during preservation via 1G guest
pages. Furthermore, this change aligns with future work on a stateless
KHO, which will also use page-sized bitmaps for its radix tree metadata.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 7b460806ef4f..e5b91761fbfe 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -69,10 +69,10 @@ early_param("kho", kho_parse_enable);
  * Keep track of memory that is to be preserved across KHO.
  *
  * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order
+ * of a 8TB system would fit inside a single 4096 byte bitmap. For order 0
+ * allocations each bitmap will cover 128M of address space. Thus, for 16G of
+ * memory at most 512K of bitmap memory will be needed for order 0.
  *
  * This approach is fully incremental, as the serialization progresses folios
  * can continue be aggregated to the tracker. The final step, immediately prior
@@ -80,12 +80,14 @@ early_param("kho", kho_parse_enable);
  * successor kernel to parse.
  */
 
-#define PRESERVE_BITS (512 * 8)
+#define PRESERVE_BITS (PAGE_SIZE * 8)
 
 struct kho_mem_phys_bits {
 	DECLARE_BITMAP(preserve, PRESERVE_BITS);
 };
 
+static_assert(sizeof(struct kho_mem_phys_bits) == PAGE_SIZE);
+
 struct kho_mem_phys {
 	/*
 	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
@@ -133,19 +135,19 @@ static struct kho_out kho_out = {
 	.finalized = false,
 };
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 {
 	void *res = xa_load(xa, index);
 
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
+	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
 		return ERR_PTR(-EINVAL);
 
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
@@ -218,8 +220,7 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 
-- 
2.51.0.869.ge66316f041-goog


