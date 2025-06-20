Return-Path: <linux-kselftest+bounces-35519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42365AE2653
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EF5189AEE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AB2550CC;
	Fri, 20 Jun 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xC9RJOxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB48254876
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461702; cv=none; b=GFCETPdQBFLp8JHqn9l/quvdm5dTzXcoTGfns2K3dSTeO8AjN68iFOY0zgGGI3voKO92bC9k8gbfHiv8BhQ9VsljTNhSmsDfUhBEe+sja/CJkyidFHVF4mv3GGhyZsG7+diQ2Xq64Uym0GQpMBPvD2AJrstKiGGBxNhWVkc1brQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461702; c=relaxed/simple;
	bh=EJEoicR7ZRTfhc2FzkLsgUasN/F0+D9IbQGE+fpMjiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D41/1Pdg2Qosmxb+wIwzk12YmAQuuJpE0GSmkdm+7JeB2xXTua4Sp96ER3xY3asj2HSxtRg6IZu5agh5O99mQ9ace3d0H6227jV7/q1DPCwN3/CXDjNyDwwfCV52syAAzsCtZ5+kDQmlBohkqFOjmLLZ+Te8J0PL12oF2BhP9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xC9RJOxd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso2393630a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461700; x=1751066500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8spHqWWjJrvVXtdk2p7ir7JoyaVn+ZgWX4oYiM6SqEk=;
        b=xC9RJOxdXjwVSbrPI1zNBz7JgAZZqhjMpkZ8OCHDTgQ/Tncdfr7vZxVhJEHMsAkWqb
         RvmhIOx7YZqwSDnt362N82HOK/92HKZG4FT1BVCa01ivC2Ay7qS+HarNbHqr4aRH0RFB
         EYGw5JMCYxnoNNXo72T5WANGRf+QsFk1Oz8xZLpTuh1ESUXsYZar6DIL5QI9rYCVByU/
         HuuxFz552NKtgAB2tYfo9cdGgnSixCBpsc5pr7dT0oHjQrWVum4CkuiyUFOlApjQ+8Cq
         bDK3WTW/A5X3ejNLGNFuHVNIlPvLtvT1Ao3s9q/OcfWMWyb7rcwZtE/YjwCIYt48KMQ+
         SyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461700; x=1751066500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8spHqWWjJrvVXtdk2p7ir7JoyaVn+ZgWX4oYiM6SqEk=;
        b=DNNepJz4pBSC/6o52xyGp1IbZejMvIZ9BrIXFaHYlhS+C2X/2rcGYgvIuzYhOdi0ar
         xGW23gijvDDiZCws7P2lWVwO94WXTm3lUQio/O33GDNLcB41Hgn93iZXWNtYUA7HR6Dk
         fbG7x9WP/Xq/LG4ac1s2IBHWJaXEKPXCciZXZ75uDrvh1qebfKopSZRWP6IWtBYggM/i
         Mgk9206o0yxIWalF1dfilqaMFGIediYKTUfk+jhm6beLN0wdP+otBVjOn/wVKtzF8L35
         IT1/pAHPHCDs3Vt1KJgpNBT4WAMzmitGQ1kfyYMTIVYwHx78hJGBUdQsl+y0KFGRDy5b
         TamQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv5KtzKq1+z8MTjfLDMbrHLoo6g7xW892BR+zIiEK8i2x9nRLUh0x7vuAYdFP8tsoh6/FsvEiv1hPqI/Y73kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhBEVifzws6leFEaP6vRQXsdkQYbzvAzP1DcFLX2MiB0V49nI
	jzE7mv3sNC9z1nqXRQfSyF8u6Iz80A+AiH6xgBWcvwQ1Jv7I6J7LM+j6Jo35p0l1m15t0f08/2R
	kFPk3rQu3ZyRrhA==
X-Google-Smtp-Source: AGHT+IF427Dl9OA6t8/lF9pLvYo+LFpSunJ+d/1PfRXmHiTVeWDHd4qzfn7BvfvIkdYlSYuPoYCiVytu3aibXQ==
X-Received: from pjee7.prod.google.com ([2002:a17:90b:5787:b0:311:b3fb:9f74])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:dfcd:b0:313:fab4:1df6 with SMTP id 98e67ed59e1d1-3159d8f8fedmr6524988a91.32.1750461700091;
 Fri, 20 Jun 2025 16:21:40 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:23 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-26-dmatlack@google.com>
Subject: [PATCH 25/33] vfio: selftests: Replicate tests across all iommu_modes
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

Automatically replicate vfio_dma_mapping_test and vfio_pci_driver_test
across all supported IOMMU modes using fixture variants. Both of these
tests exercise DMA mapping to some degree so having automatic coverage
across all IOMMU modes will help catch bugs.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  8 +++++++
 .../selftests/vfio/lib/vfio_pci_device.c      |  1 +
 .../selftests/vfio/vfio_dma_mapping_test.c    | 24 +++++++++----------
 .../selftests/vfio/vfio_pci_driver_test.c     | 13 +++++++++-
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index d50debd84813..bf0b636a9c0c 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -53,6 +53,14 @@ struct vfio_iommu_mode {
 	unsigned long iommu_type;
 };
 
+/*
+ * Generator for VFIO selftests fixture variants that replicate across all
+ * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
+ * which should then use FIXTURE_VARIANT_ADD() to create the variant.
+ */
+#define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__)
+
 struct vfio_pci_bar {
 	struct vfio_region_info info;
 	void *vaddr;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 15e5adb770c3..5c4d008f2a25 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -364,6 +364,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
+/* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
 static const struct vfio_iommu_mode iommu_modes[] = {
 	{
 		.name = "vfio_type1_iommu",
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index dfc14c40bcf6..ffaf941ede39 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -96,27 +96,25 @@ FIXTURE(vfio_dma_mapping_test) {
 };
 
 FIXTURE_VARIANT(vfio_dma_mapping_test) {
+	const char *iommu_mode;
 	u64 size;
 	int mmap_flags;
 };
 
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous) {
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
-};
-
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_2mb) {
-	.size = SZ_2M,
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_2MB,
-};
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _size, _mmap_flags) \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, _iommu_mode ## _ ## _name) {	       \
+	.iommu_mode = #_iommu_mode,					       \
+	.size = (_size),						       \
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),	       \
+}
 
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_1gb) {
-	.size = SZ_1G,
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_1GB,
-};
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0, 0);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 30cbfbb9225f..cfe3b9608cc7 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -59,11 +59,22 @@ FIXTURE(vfio_pci_driver_test) {
 	iova_t unmapped_iova;
 };
 
+FIXTURE_VARIANT(vfio_pci_driver_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)		\
+FIXTURE_VARIANT_ADD(vfio_pci_driver_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,				\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
 FIXTURE_SETUP(vfio_pci_driver_test)
 {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
 
 	driver = &self->device->driver;
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


