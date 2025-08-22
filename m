Return-Path: <linux-kselftest+bounces-39758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9736EB32485
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF2A3A681B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A6D352071;
	Fri, 22 Aug 2025 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaLYFhnD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63528335BAA
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898010; cv=none; b=FzRYeJGStKh6uJvDtJe4AeX71Gaxada4wu9Vzf7xbyzBKtFYrVDYJY+Ky92ZMkh7HeoQcyCymGRf4HlCx1ov4jIoXqQL6kdfzvY6cfPVrDkXTV4Vb1s5337NPcDon+a3mX05FGRiSeNqwPIcKgzSGbY0/UYDfjLrI5kd1+NJGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898010; c=relaxed/simple;
	bh=idsPwuv3gxkymkBDYfZ7dB6GJ7no6ioopM4seTEW8bA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DKLu3sSzgPrL2JStN/0ulsS8LkTj7yxQQT72ENfWiXoIJuhSP7zRGOSsoRsmJTWz5MWCXgVawPx3kuPTtIoQFiK/m8qKpSGy0tqnymHe5mkpM6ccEpPStkABxPdYA2+Z+SMXgoClXWmxyOVplB/Q/IboxiMthg7JE6uztRNhrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaLYFhnD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266ce853so4573584a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898009; x=1756502809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=meYNYZDrxAwvZCUx3Eq1WTnhW21ojHNNc5Nvzk5v3Ps=;
        b=iaLYFhnDAMfQ3gEnPY44x5r1N2VOZ/CX4mIp1RUN015WfWvW9tpng9Y3It/uGUCG1K
         kULWbkKoZssf/y4t7DZ5CQI/fCWNcH9Qv75OY03G6JNzIRnZf2kT0UiK6S8VgWZA4NH3
         VVYmpUy1OWe3/AFWazOPLNVB54O2C8xNxsyrzwDKOal/lz4DRGIXrQg/uW03MxjNkbST
         jDSuk7tLK79n6+L99khzrX5UJCuoyWzv2BICHDd+emqmKuUsgXskgLI5iERWUriMK8Xf
         BdGAvqcobhLoUmOsh/BsSSgRzqEs7Ezu7mfmThmMcGidMBX2K+iX3Vy269k2wes3U7dd
         CX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898009; x=1756502809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meYNYZDrxAwvZCUx3Eq1WTnhW21ojHNNc5Nvzk5v3Ps=;
        b=xVUqq+4bep5BYU84u23I/tt1iLr9Df8TD6lix0CTDrh2oKMtTm4TbvE5vj0y/7tDrz
         KeGtKfTfPVL57Vn1zwrYf/nhu0Pkv/DhPMsH5+LzVZ/z9C1KvEOr2g5vKOGNtimz3bxn
         IzsUCf08oXXX5tLeQiZgoI/s0035p1ji0kHApDyZpHBs5VzKn108wHSLqrdg3X36PXVD
         hLAQw8gBkw1BabhWu9xpOIDJaqoni0xwCWUjvUXA5j1X+/m9hB0EpqcV4n+M6AfV6UZU
         nO0HwOfLVnbRwmD5CUEo6+63jQCd48xl/hP/oBo3U1V3uQ595cujw3y8gLZ7SQ49mVw6
         h3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3V5u8kKytJPXGyXnAqN9kGcEgwqBDj4T14flZ/+8TVF444392cb9vpyXXB83TpYgTvv04TL4NV+YMacpAgeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGB/eZfL57nlMKggzap1NNfACtNU6RLWx6+7C4NNXgqeqsDIR
	AX2rii3CR0jcR5PkAbSo+9qNbQK8OSgdh2bh5Bzl/mLVqHeOkX3KlBVVJBXZgpweDGjHuebQrg2
	ZusKjFH3oUJRk8Q==
X-Google-Smtp-Source: AGHT+IFhSvSQjaTIjptq0dKLsnhDZ42ZJg52v0gJUde487aejGtyUgduTV5jJC0Uf42xVl5ilKyGpEYO2EiuKg==
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:321:c567:44cf])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f91:b0:325:83:e1d6 with SMTP id 98e67ed59e1d1-32515ee21bbmr5264182a91.2.1755898008824;
 Fri, 22 Aug 2025 14:26:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:14 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-28-dmatlack@google.com>
Subject: [PATCH v2 27/30] vfio: selftests: Add iommufd_compat_type1{,v2} modes
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Add new IOMMU modes for using iommufd in compatibility mode with
VFIO_TYPE1_IOMMU and VFIO_TYPE1v2_IOMMU.

In these modes, VFIO selftests will open /dev/iommu and treats it as a
container FD (as if it had opened /dev/vfio/vfio) and the kernel
translates the container ioctls to iommufd calls transparently.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h |  4 +++-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 10 ++++++++++
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 12 ++++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 981ddc9a52a9..035ef5b9d678 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -60,7 +60,9 @@ struct vfio_iommu_mode {
  */
 #define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__)
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__)
 
 struct vfio_pci_bar {
 	struct vfio_region_info info;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index cc1b732dd8ba..b6fefe2b3ec8 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -376,6 +376,16 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
+	{
+		.name = "iommufd_compat_type1",
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1_IOMMU,
+	},
+	{
+		.name = "iommufd_compat_type1v2",
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index b65949c6b846..ab19c54a774d 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -128,6 +128,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	const int flags = variant->mmap_flags;
 	struct vfio_dma_region region;
 	struct iommu_mapping mapping;
+	u64 mapping_size = size;
 	int rc;
 
 	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
@@ -150,6 +151,13 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	if (rc == -EOPNOTSUPP)
 		goto unmap;
 
+	/*
+	 * IOMMUFD compatibility-mode does not support huge mappings when
+	 * using VFIO_TYPE1_IOMMU.
+	 */
+	if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
+		mapping_size = SZ_4K;
+
 	ASSERT_EQ(0, rc);
 	printf("Found IOMMU mappings for IOVA 0x%lx:\n", region.iova);
 	printf("PGD: 0x%016lx\n", mapping.pgd);
@@ -158,7 +166,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	printf("PMD: 0x%016lx\n", mapping.pmd);
 	printf("PTE: 0x%016lx\n", mapping.pte);
 
-	switch (size) {
+	switch (mapping_size) {
 	case SZ_4K:
 		ASSERT_NE(0, mapping.pte);
 		break;
@@ -172,7 +180,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 		ASSERT_NE(0, mapping.pud);
 		break;
 	default:
-		VFIO_FAIL("Unrecognized size: 0x%lx\n", size);
+		VFIO_FAIL("Unrecognized size: 0x%lx\n", mapping_size);
 	}
 
 unmap:
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


