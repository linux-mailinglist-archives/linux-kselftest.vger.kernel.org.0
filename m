Return-Path: <linux-kselftest+bounces-43001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5979BD4A28
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC454050BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA330E0E7;
	Mon, 13 Oct 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK90y1O3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8E30E0E9
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368542; cv=none; b=iHKsGIe6PW464Gzqc1b+l4zu4hMyxIQ74Z5sKveAwNm/vBcTr7YqnhRymza7Q2andNuB3NUEVY1CYxQgXWlP3/SMcBdiVFugVSJZtgT9oxeXgjtE6GbbJJf2+dWg1OzOW8OFynSb2jLfj6ReIE8vaeSQZOxrtVbN5CrTpoJywkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368542; c=relaxed/simple;
	bh=2UhKxpWUkIifGUgfHcgz/LXU79xXY7bzYokZjULRNnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwLMm7LFH8/A4rrm3A9HHrNTNEf6X1hfjGoNJWqRiXtHD8EsjEhr7MY4uZbsT0Ib4CQhn2PNsumSacvROHLZJMoDkeyeF7W2uUQqkUgTxwImgYlkmegUp7Zc+OO9UwrdUi1zdtoq1pxY6LdXFYEaxzDJWt2k/oBIcVFcsMdDE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK90y1O3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e52279279so30694765e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368539; x=1760973339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=bK90y1O35TGA1PtbYgnjynZom88ttaHqOKQzkYqP+sU+Q6LOSOKUIQCA44d6Cy9Lkr
         dHuZXhtLOFiQz3g/BrVWT9cKaTQIhtEGH7uf7oz4hlEPqf8wO76N0AMdab1pa5LelKKE
         heMdkK/b+QxI4/auVhOBd+UvnBGNv2iEVSrNLFaUj2Io+EDANFJYHBLgT98EPVt7Rvkc
         AMMsLaO88ltcm3m0jQs0x58I3bEig6w+LnWHGc5QdYwa82Xl1Vc8CAcwzkBk6YROfu19
         rS/W3lhDEviaKW48gfGQpwmd8iMgP53lwjwl0KaIMzvurgv/2/CshxWwzvNwSbmbE+B4
         APVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368539; x=1760973339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=K0vnX190Id4j2Wt/mYmQxOLkF8ORVvb/V+FjSLFPfr4M1yxBeSQ227rGBW/pQkToLM
         jRklD4l3Zi2kRIm3sO3HB9p8a/7ySf2mPb8MR3ipVd7rbDtynHB/XlJZirFyUrbCPwPs
         0L2FIczHvV9iSKQanCvb8/ZZ1IvUlji/I2cjOPazA/CHc8s0A8pyBtHexdvDewshQnIh
         cwpgOsxN2o6WIsHHOs5xmHizAAYFCHUj9sSHuu1AG1pPp72A9lTmg/ryfvw3t7RbXS1l
         X5txP+yulPV/Pg81oZC5CoG32aZtwEvZW+drv+B9FT/7bPtHhIS3Qqz0tmq1MfZaG+eu
         Erng==
X-Forwarded-Encrypted: i=1; AJvYcCWLnxRuaTCLUHB4tBhP4ZCORvZhVCrl+EQKUsXliB7HPgllULTn5rF0K/a/4dHW9ZWW+euyJdQrpnhgMwXKMSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx887VP0Cxx9zs9W4R+tXUgB6RlFMDYxz+HCybDxP4/aF+V+Vl1
	r7dX9adZsIHsiSZtmoZOwQ1S7PqNWgseeK+Z58dPiebQuVa6aCC57ZW2
X-Gm-Gg: ASbGncuHorFKJ3QB6rlB1/Mnc5krBuELEraowgiPhAw8hFsjPxjzBfGzovyVPH1JdY3
	bWm2XCEdt8lbY7t1Bf+ck5TY03VnbCI7n1T5X7HGFHEFXXUdIL9J7oyvFW/2lq62gmI/RKHcxhh
	0G3gQ1C2xGLwgMRWxTQvZGsX7tMGpuVVqxE9RQy7xh5VEwpW/kXgQeUMdiDdyb0Xdiw1KlYrHUt
	4VC7eCC0UzMhbcZZp+NIH8Jcusj6rvMatg4AzbGakUf4gGq7l87uK83owRKT5PMQShCGU5o1/BI
	8HGImVCP1TyVMZub43muvPC+CYYus1HAY2RWGmCkOzStHOKT9zGozEx3PtOjSUlpXTNLWI7Gr4L
	gKf64xQwBQL8H/pcj+yzAqtLUUN7Yxgu0yUTr7K5MZBUPY1MeqVviqja7IVQAMJkB/z8cJupcY9
	15LbMk
X-Google-Smtp-Source: AGHT+IGwJqj5PmL4e2MI1le7nNOJW+jd0SIfBCswYBmaCJKr1jrFAghd2jBuPptFtHUN4Hmx6R2roQ==
X-Received: by 2002:a05:600c:4752:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-46fa9a9f05emr138719385e9.11.1760368538589;
        Mon, 13 Oct 2025 08:15:38 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm135545825e9.0.2025.10.13.08.15.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 08:15:38 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
Date: Mon, 13 Oct 2025 16:14:59 +0100
Message-ID: <20251013151502.6679-3-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013151502.6679-1-jackabt.amazon@gmail.com>
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

When creating a VM using mmap with huge pages, and the memory amount does
not align with the underlying page size. The stored mmap_size value does
not account for the fact that mmap will automatically align the length
to a multiple of the underlying page size. During the teardown of the
test, munmap is used. However, munmap requires the length to be a
multiple of the underlying page size.

Update the vm_mem_add method to ensure the mmap_size is aligned to the
underlying page size.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0a54..b106fbed999c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1051,7 +1051,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	/* Allocate and initialize new mem region structure. */
 	region = calloc(1, sizeof(*region));
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = mem_size;
 
 #ifdef __s390x__
 	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
@@ -1060,6 +1059,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	alignment = 1;
 #endif
 
+	alignment = max(backing_src_pagesz, alignment);
+	region->mmap_size = align_up(mem_size, alignment);
+
+	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
+
 	/*
 	 * When using THP mmap is not guaranteed to returned a hugepage aligned
 	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
@@ -1067,12 +1071,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	 * page size.
 	 */
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		alignment = max(backing_src_pagesz, alignment);
-
-	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
-
-	/* Add enough memory to align up if necessary */
-	if (alignment > 1)
 		region->mmap_size += alignment;
 
 	region->fd = -1;
-- 
2.43.0


