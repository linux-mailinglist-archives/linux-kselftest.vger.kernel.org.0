Return-Path: <linux-kselftest+bounces-41251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC17B53454
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1632163F21
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C973375B4;
	Thu, 11 Sep 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/2VcPHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D93335BC2
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598593; cv=none; b=TXep+IJcgakcRhbuw/pIQ8EOqlLJnA8PFT5pwdjqRi7wX+RnXfI+BCJs0Ps6P2IbevYzGQfsqzH+GYQg/jIkSmOp4uIEX75vqumTWYXy21XgzGNq9NLQrbcV/XjDIJpSaZJDwdCpbYxUGPEa4mPmitKodyl5fBwd3Pb8sZ6a8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598593; c=relaxed/simple;
	bh=2UhKxpWUkIifGUgfHcgz/LXU79xXY7bzYokZjULRNnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLgM/ZwNsr6ELTpiFxfU1KZ271lIP6N84GEoev/Mjpy1BttbAJY5eQSwPsZp57mGQT2U4hDTQ82Kw+A3b5u6xMQj79gxXzMyD7gQhttUyNDdboQQK2IoYMJjRoJKzPDQv3rjnINoVFhjSvM9mXBVzsZBMNGp3Ni8QF6Vzzr179o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/2VcPHK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e7512c8669so598328f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598590; x=1758203390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=d/2VcPHKnnxLoNjb+hbSuzZLQDqY3a3ybFTMDseP23ghYT2LImdZx2IGMgkAvXnV46
         0lZBkD9xh9MYXSodC4k5TTh8TUgo+RwTZgzoSzPjITwuzRPQUjCKhhCMqE857VwMgK53
         VF3IWCKYzD6AKQYSFzyTQZNXBoHFtXuW1d1HY1eS0+NQ7iG5H75RGB9TemtodIq9LhjM
         Z2hrVS9K3mDbVK2/qMxJ9qJ6t1kOmtJLMvTrpCB84lzQmvfzkOHytZfeMExyuUnoucMP
         y9V3MN1SGEmejwkAd8qGLsdiYfdiJrwNkLOQbCrAgq1g1+I+HJns3Lpb2R0+fo8CI7Oa
         fdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598590; x=1758203390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=WBuQ6hVXHeYyHJaah/aoy/OzFjq6GYay0NEYP7va43eScFcd3TkXIn1w8XgtlIb/nY
         nhfH6UHdx1sk5tUHClBOdydcZgcVklYkdCD3GyUa/UFY0quDMdw+Qy+ZzMd8DDruKzRP
         nPLExdA1REO1MkxTAgYceZ4NW7KKZ5F34X59WZpn9rs2lpeR4t1Z1tv1hLXycWFOyocL
         Xih9epy/0ZaT4fDDJhpz7467XZIyQ9ncEotqQ3HWlkNWXHeN2MMTYSVKSrtN9cw750V1
         ItRq6GHdOtmHH2tlHVfx59KHx/nnlzfO+3o171pwakVDm1uEofX4zULr4OxQ83JwsYoQ
         VHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVn24sLyN5vTzcgg4pRqiS1FHqkQ7DA93RhGaU/8HxHmOTgpPrfOl5fWrrGedOHfwF8bn8aHguBUNwioeBXnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTmNr41jd/FazsIcFWRh0ao73LuyC1E/MoFtzdnuxdhEndDGV
	RjOaPSHndORboqG4Y2tMAw1yWRFTlEF+bh9jWonNrnuFy8e7Jo4TY7PT
X-Gm-Gg: ASbGncskhwuTTHzF62+aFzVKZZm47O0saQpGED6KF/UrrXpMwLDjPOIpXvia7ZOTahc
	SPDYVcWiGbhFXJqbo1ac0nBVp4BDX6LKefFP1JfdR8OgOqhfQJHutNxkUxriMnurBWK2Is+vO/r
	asxIEc583f1xffE4ovBmA7C9OaO8CFHj5TmWkhQXOcE5z0Q1R4gZyXXSvXI1b+9ga4bQU5SuayO
	jlB6vp00CE/kQr1RBAtMmenSNAwJW3X1KVmdw+KSciftb0QpjYfTsCPEs7g1SWC9U8driJ5+NQZ
	TrtTJi4Lt3dm7AD8D7NuYOAIca3V7GE2x5loy0kPj46pD4QVb1U2OecuAR+Xg59/KPUj9XCjiKN
	IosMF5y6oEC0n/PgCXCQFsYvEYO1DteoHfbnaIFIr5AgPrQNMP+nE6O3rhrFwuKvHORqCAdPE
X-Google-Smtp-Source: AGHT+IH6i2Rlk1oZZIkubpWUyVstEoqiFYIwX8SUUvSh7jWZ3DNV3Wa4AF6A7KNkrZ7i9r1nUbzyjw==
X-Received: by 2002:a05:6000:4023:b0:3e7:5fca:2177 with SMTP id ffacd0b85a97d-3e75fca25admr2356651f8f.11.1757598589695;
        Thu, 11 Sep 2025 06:49:49 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:49 -0700 (PDT)
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
Subject: [PATCH 4/6] KVM: selftests: Fix unaligned mmap allocations
Date: Thu, 11 Sep 2025 14:46:46 +0100
Message-Id: <20250911134648.58945-5-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
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


