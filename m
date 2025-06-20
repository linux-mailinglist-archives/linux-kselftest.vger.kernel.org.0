Return-Path: <linux-kselftest+bounces-35501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC9AE261B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AC03AE43C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15252472A6;
	Fri, 20 Jun 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGt6uD0Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB0247297
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461675; cv=none; b=tC49ZZMYUMoJ8vwpJqNJ+STOvz3McrCmyzHhs5su1WCSXICw3ijn+fPXLylDBqPhaxMB6qOy2DwWFNlnG+hzUs/ynoFl4oBnh0H8MnSjwsSNEwAGFk5JlaQuXBxKseCrKdJJ/OY/qiSrilR1lODfw+HQw3g6wwbkiL5uNvI3Jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461675; c=relaxed/simple;
	bh=G2zJQAfQ8Cl2tcrjPYcs0T5Qo4pJj9wgXbCdbRxTSgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U4L9yeu8Twgjua535frCBeR5PtLZUoeJAX0JztcUOyUUj9SUn11D76l3POP5IKhAxCeBxT3PY9sz+EeC9yVjS8PmuCzysx17LJ+B5s9w0QlapzWqEXOsSuYdARwM2mZ80XQPnFu3UBG09Efr63bpmgmAjvEyChblbLhqXAEr1FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGt6uD0Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31c487e1cbso1586662a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461674; x=1751066474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gjRVS+C40f7uUYjGFQhMhd9BqO8VFa1zWPiefLUoHQ=;
        b=jGt6uD0Zmx0iRqVs1CPeyjdzO47S1o3oEe/hyHm+Jjn4rSHfw+/QjnxCBBA0ZCWRRO
         pn6UGqbISfVKi5fQyNHeHF2SivrBSjBSTgz2ABvjOn92OpE1BgAEJv3mE5hUuRoEGqBZ
         tAV+bRdNpgUy9fKFCsEy8dJ9h+QC7vZ8ppcV0N43PLp6PmxqewB4aYOz3In2Qm7NO+dx
         igpjcetlL6puUX2Xjyw5DvJTjolQQm/SFNwVyGuZYaQLn0cHTPxGK++M9pdCmFGm9joG
         +ByYwVAaPqIMT8m3ozo6CJ0KWfsnZm2q9uZsCzYONI5agdl7E/22GQAa4ZqGLKOmMHsA
         yWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461674; x=1751066474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gjRVS+C40f7uUYjGFQhMhd9BqO8VFa1zWPiefLUoHQ=;
        b=DWoqUTpnMc5G58RCvwfpD49A3YN9HQSwsTRUy+IP8JhOn6dKvndQKPM2HnYOeG+Wtf
         ZRr14Hs3WYom+uYCw04hkVnJzJs6hrvQST+tmY42thT8N9+lAERe9fNb32A/p0kGNjxD
         D+RasFpyhIFAVBXqLpqAq7fSdCSD8UYjXEvrF8A3WUaHiN/g9tRMea807feX5GN4Gio2
         l6ZeBKabO44myCe1d0d0huPamDLy5PGJfU17WDvwRsiWPhVQ3i7MO0zdMSbjN94ROjbz
         yvv157U+rAPjnsnPyEhobDpcnzuhNW1qiqqj/eAAC3WNQm1Los8B09LH7SuB3wwQFtY2
         LgAA==
X-Forwarded-Encrypted: i=1; AJvYcCUlm2rThW4kw1JvUoTeP5JEANddNHNmjrfrvSI2nQiDAoC8YQhjljXJuvs2W0Tu9E3WY/t19eRAyzZvJA++yiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf5CXujVXEtqtmXD2IDAJCl42WSgK5Ga4bHjXLbTNYzJW2QSL
	3Mvb2RXCYPhgPdkvdqzp3JcyY2hp4R406mPlROiUqD3IJ5US+Ug8QweEIgJOEw49ubs9jz3gX+k
	BPDc2hHDByfEoPA==
X-Google-Smtp-Source: AGHT+IGsgZ16/n20Hac5AcRuFPEdudK5TV0yY0i9zrSnDPtE6cWt8fIRyPcYWR5La9Dkd5XjIw3gOjhcqrhd6w==
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:312:e914:4548])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4cc2:b0:311:abba:53c0 with SMTP id 98e67ed59e1d1-3159d64288cmr7266703a91.9.1750461673836;
 Fri, 20 Jun 2025 16:21:13 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:05 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-8-dmatlack@google.com>
Subject: [PATCH 07/33] vfio: selftests: Add DMA mapping tests for 2M and 1G HugeTLB
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Add test coverage of mapping 2M and 1G HugeTLB to vfio_dma_mapping_test
using a fixture variant. If there isn't enough HugeTLB memory available
for the test, just skip them.

Signed-off-by: Josh Hilke <jrhilke@google.com>
[switch from command line option to fixture variant]
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 40 ++++++++++++++++---
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 39a6d71b0f75..97bbe031b10d 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <fcntl.h>
-
+#include <stdio.h>
 #include <sys/mman.h>
+#include <unistd.h>
 
+#include <linux/limits.h>
+#include <linux/mman.h>
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
@@ -16,6 +18,25 @@ FIXTURE(vfio_dma_mapping_test) {
 	struct vfio_pci_device *device;
 };
 
+FIXTURE_VARIANT(vfio_dma_mapping_test) {
+	u64 size;
+	int mmap_flags;
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous) {
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_2mb) {
+	.size = SZ_2M,
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_2MB,
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_1gb) {
+	.size = SZ_1G,
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_1GB,
+};
+
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
 	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
@@ -28,15 +49,22 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 
 TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
-	const u64 size = SZ_2M;
-	const u64 iova = SZ_4G;
+	const u64 size = variant->size ?: getpagesize();
+	const int flags = variant->mmap_flags;
+	const u64 iova = 0;
 	void *mem;
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+
+	/* Skip the test if there aren't enough HugeTLB pages available. */
+	if (flags & MAP_HUGETLB && mem == MAP_FAILED)
+		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
+	else
+		ASSERT_NE(mem, MAP_FAILED);
 
 	vfio_pci_dma_map(self->device, iova, size, mem);
 	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+
 	vfio_pci_dma_unmap(self->device, iova, size);
 
 	ASSERT_TRUE(!munmap(mem, size));
-- 
2.50.0.rc2.701.gf1e915cc24-goog


