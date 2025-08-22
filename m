Return-Path: <linux-kselftest+bounces-39756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F233B32473
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28439622EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60E350D77;
	Fri, 22 Aug 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLxiLW92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917C33A037
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898008; cv=none; b=hFRYb2j9hDh2zWDvfI6Lno/K67vgcnvhD2lER5dYlr5rEJq7cTkEz6ztY7onJnV7k4lczptqhG6mpx4wfUTgxyLa9VfkV3fnPVOonAf03kh889B4sIXaOEmFFPn9SK+qtGktfy5kO0p3qJQUjFUYEzFE018NjmY5wXuT9CUHRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898008; c=relaxed/simple;
	bh=9hnBbxgoyyyfgGwjq+xSkSPvVZ68AmuFFHElBIq5wTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhh5+bqgW2tiTsoGNqw4idudzMfWfmc4uY5CUIIRz/7YjAmbjL1C67s4U7RvwHD2RwT2SZshfNp8uuyjmv4gAAVPaP69843qgQNZy6eWyXkns/EP4NDAkuj2ZDFIAXLwUyiV2/8ozwU59WzNzLSrAHx8F5RBmMSYuEyhERyc4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLxiLW92; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60c3e7so4577403b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898006; x=1756502806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yaIzU2QpXvAWW2OjGw4oY6biAviRGUbHbcV8PB4r6M=;
        b=wLxiLW92zL7FKDLF2XB7NCjmGOpGyFhEYs1nvEtNmQIoFPCCqkwJT2tFtHS9dQ0OEO
         t+Ihv2At0CJMYxgEwjfib5Q7GUu77xBbnUurKaM3aYqiujQb2CKBb6wGSZyD5bL5KPen
         svlJGpVf96i/Kp4BJGy92LHZcaUEK2BjWqn5jLFm7k3DaOG1tvgbnRuloC8Bac/U+p72
         uNBFaGF0AaBN6MslA8NbS1jEjwNGHgj7taGn8XaWVtkVL0RxaBnB8dQGYYtnPsfovoo4
         N7qB373hykMetoFdOV7nPoVOzCJgwTQUplUyXgpgHEENm6hkKN4ewpDe6/+UY+AoO7DL
         +n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898006; x=1756502806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yaIzU2QpXvAWW2OjGw4oY6biAviRGUbHbcV8PB4r6M=;
        b=eJ59qavXULWfFwYmLkiL4okFLNZfVjk/MBB9H0riYEs6qJE10RfDq7gRBfHPRFPoJn
         Q/nLkiVB1/thQlr6tmSq1GU+nXNOiGl9J7NHREVh+wIwovzBOZzPNvAfkduIpAaGdqg3
         sZ3C7xr7todVB6Mugr1bVGPqJUd5HnS/uwCo2M207ZVc0iJi+YUHn2G/UTXkaLSiwtTo
         lEGXlonXKf0qlwkYqsPxVIhFe2EA+JXq4k+4dzUOPQ/UPloAjbHBeL/PunlbZYKBo0vT
         93hJjtYEZSHwuz+tJnT/QNQaG2hoFghbYX6JpJjJr3hQdvnEkJ1zr2QTrDOFTiFaNtDS
         Wglg==
X-Forwarded-Encrypted: i=1; AJvYcCU6zHt3bRcObL2Y7YyvNucwMS3kpkCmfcQw+0XH3Up285r2hQtZKz1PabOmsi7W0zVSj1sIgMQMj05ZdauqAqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6G+TZ2Mi/nA8LjCRKIC+QIyabi77QWDJ/+XEl4gOw5A0qIJs
	+qAEKXBGpbikYzzB08jTzwzQpLrPlG+FHOpDSEFbs0NCwb+Wfb7oQBo3958us380BqGavxDDsNY
	dQvGD0IEx8TBhxw==
X-Google-Smtp-Source: AGHT+IEwm9+1p5obadsZK9Bi8St2rkEpqxnOex2o11eFyVZOkrjzOVolMFofvvH8d8AAQiz7oyA1jLphggD/bQ==
X-Received: from pjjz30.prod.google.com ([2002:a17:90a:6d21:b0:325:4ab8:8fb8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:339e:b0:238:e4d8:2bba with SMTP id adf61e73a8af0-24340d15c6amr6562944637.35.1755898005896;
 Fri, 22 Aug 2025 14:26:45 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:12 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-26-dmatlack@google.com>
Subject: [PATCH v2 25/30] vfio: selftests: Replicate tests across all iommu_modes
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

Automatically replicate vfio_dma_mapping_test and vfio_pci_driver_test
across all supported IOMMU modes using fixture variants. Both of these
tests exercise DMA mapping to some degree so having automatic coverage
across all IOMMU modes will help catch bugs.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
index f07bdb602422..b65949c6b846 100644
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
index 14ec862c0b11..2dbd70b7db62 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -56,11 +56,22 @@ FIXTURE(vfio_pci_driver_test) {
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
2.51.0.rc2.233.g662b1ed5c5-goog


