Return-Path: <linux-kselftest+bounces-35517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD9AE264E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214213B717F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B625487D;
	Fri, 20 Jun 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utbFuMkq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE9254841
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461700; cv=none; b=L63iSHeCRKAaYfhsjQfZnUQcTsS63jAqDQ7vM6Q+0joqGvB/yMeZ+wiy51RxuiIOSN1GWtD2eSSpaJzeeopHJyZVHYVsg0KaB3+dpi4GnAk1+WZJ6WLP5qXoIOTRMAkwFG6S6J9Bon+T5LXFkWfUy10sFYg93BHk2HdbSZyCQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461700; c=relaxed/simple;
	bh=x/eS/QhVNCYrdBONaKtaQ57zNV0aubMlXomTVql8joA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JeaMz09lTE8mzEZuJhGSkK9ZuwTC5b1PFyhM9ufaItj0/gAd9iuIGN2NhHlNToIatYfF7UbDksExJ2Y7068uY9TpcXABE4DeMmvYwZUVjN0J3gzrfoYCbJOrkOcl7/5MMcWjkmgOCUbFMZCw4iDxdq8pptNUlA6baW21mWZtGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utbFuMkq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so3150160a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461698; x=1751066498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cbODPDWCI3LtZeuVtw4G7ZI9de73OiXs81guaiWWu8=;
        b=utbFuMkqgVm/cLHNo4HF8BeBSi0BzZIMSKdGxzvu31Xc0q9kxHUuCp0EPrD6c5LVEz
         eEH3aXbOBq/iDB67sZrrR8uQpqG+qJFCtmBgCEFMclze2yNXv9vvemeNYzZ/qtAP7TJh
         aGXVklPOVl13wwlzw2iAiGo293hYLS7NW7WwFuEWpKdpUGsoocOj5k3w0vFUQoLVTynX
         SU1uzdN3Rv/alOeJoJzmChWF3YVl9QNOKB0XLK/lLjh6JTHDwdFKTbHYZ3BODWdoGehy
         RAnGsNXD1hgDnqfnhpD+4f9FqAOjjXaXUTtb4SuINbakU2Otzjdhq/3w34M2EXRCZcMC
         320A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461698; x=1751066498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cbODPDWCI3LtZeuVtw4G7ZI9de73OiXs81guaiWWu8=;
        b=fhlU9rksR9C/wFsBQe2tnut/9pvC6Fc6vkE1oKWRvQ2f2jSCY3WtxGiLWVs0LbCeWa
         ecb3oXR2lfdqCAt0tnMr3ZlZwYzzbxVc6WpJpLdPOwyexx02Fy/Ggy6oM/O7S+JyYa0I
         BdUpfohnSocB9ssjVP+d/godsfnAFpIOl2tvYmDvDNEK2ARY9Ksh3Tjrjdk4jLGafHAq
         8vsid8fIe3Z0kiiOZgrXq57SdBvNmjY7wx1TnazmJHQnX5T8PEc/3NqwSzclCB2PB9JE
         N7AeVLhfKxlVb0QYrSAsADC+uaOmlkACs4/xS3ALtmTO/QMNQndjEVFcSAERM9smeQ8o
         uh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnAm+SeY9M+YAmJv2jC1UF3+UmrgtnWZj7NiuwfLqi/qxP13HqJ51g/z16+1LVwzi+JlutEKZ0T0XVVIDuDw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRU3Qrnnp/FaEwMd7569ctE7+J18CQ8MXXmpDNCsGUeww2YRCj
	/I6ZcX37Bee43NDBioy8KszDEs5EP/QBvi7eV0eCLtQhK3dd2CKMGxNBMeW85hgO0iYOdLNa+Mp
	6UhKd06aayROrMQ==
X-Google-Smtp-Source: AGHT+IGJd6fVnoD5L2Yf+CanHc6DpOshJW7Gz7WX6mHjPRj3M3o9KOpsKdpSEMV76vVYF5l5AG9sJ+il+Wfp8g==
X-Received: from pjff12.prod.google.com ([2002:a17:90b:562c:b0:312:f31a:af55])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b0b:b0:311:e605:f60e with SMTP id 98e67ed59e1d1-3159d8c3f92mr7218684a91.20.1750461698587;
 Fri, 20 Jun 2025 16:21:38 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:22 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-25-dmatlack@google.com>
Subject: [PATCH 24/33] vfio: selftests: Encapsulate IOMMU mode
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

Encapsulate the "IOMMU mode" a test should use behind a new struct.
In the future this will be used to support other types of IOMMUs besides
VFIO_TYPE1_IOMMU, and allow users to select the mode on the command
line.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 12 +++++-
 .../selftests/vfio/lib/vfio_pci_device.c      | 42 ++++++++++++++++---
 .../selftests/vfio/vfio_dma_mapping_test.c    |  2 +-
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  4 +-
 5 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 05a10417e0d7..d50debd84813 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -47,6 +47,12 @@
 	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
 } while (0)
 
+struct vfio_iommu_mode {
+	const char *name;
+	const char *container_path;
+	unsigned long iommu_type;
+};
+
 struct vfio_pci_bar {
 	struct vfio_region_info info;
 	void *vaddr;
@@ -144,6 +150,8 @@ struct vfio_pci_driver {
 
 struct vfio_pci_device {
 	int fd;
+
+	const struct vfio_iommu_mode *iommu_mode;
 	int group_fd;
 	int container_fd;
 
@@ -177,7 +185,9 @@ struct vfio_pci_device {
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
+extern const char *default_iommu_mode;
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d53e2d682c7e..15e5adb770c3 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -18,7 +18,6 @@
 #include "../../../kselftest.h"
 #include <vfio_util.h>
 
-#define VFIO_DEV_PATH	"/dev/vfio/vfio"
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
 
 #define ioctl_assert(_fd, _op, _arg) do {						       \
@@ -261,10 +260,11 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 
 static void vfio_pci_container_setup(struct vfio_pci_device *device)
 {
+	const char *path = device->iommu_mode->container_path;
 	int version;
 
-	device->container_fd = open(VFIO_DEV_PATH, O_RDWR);
-	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", VFIO_DEV_PATH);
+	device->container_fd = open(path, O_RDWR);
+	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", path);
 
 	version = ioctl(device->container_fd, VFIO_GET_API_VERSION);
 	VFIO_ASSERT_EQ(version, VFIO_API_VERSION);
@@ -290,8 +290,9 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
 }
 
-static void vfio_pci_iommu_setup(struct vfio_pci_device *device, unsigned long iommu_type)
+static void vfio_pci_iommu_setup(struct vfio_pci_device *device)
 {
+	unsigned long iommu_type = device->iommu_mode->iommu_type;
 	int ret;
 
 	INIT_LIST_HEAD(&device->dma_regions);
@@ -363,16 +364,45 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
+static const struct vfio_iommu_mode iommu_modes[] = {
+	{
+		.name = "vfio_type1_iommu",
+		.container_path = "/dev/vfio/vfio",
+		.iommu_type = VFIO_TYPE1_IOMMU,
+	},
+};
+
+const char *default_iommu_mode = "vfio_type1_iommu";
+
+static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
+{
+	int i;
+
+	if (!iommu_mode)
+		iommu_mode = default_iommu_mode;
+
+	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
+		if (strcmp(iommu_mode, iommu_modes[i].name))
+			continue;
+
+		return &iommu_modes[i];
+	}
+
+	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
+}
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode)
 {
 	struct vfio_pci_device *device;
 
 	device = calloc(1, sizeof(*device));
 	VFIO_ASSERT_NOT_NULL(device);
 
+	device->iommu_mode = lookup_iommu_mode(iommu_mode);
+
 	vfio_pci_container_setup(device);
 	vfio_pci_group_setup(device, bdf);
-	vfio_pci_iommu_setup(device, iommu_type);
+	vfio_pci_iommu_setup(device);
 	vfio_pci_device_setup(device, bdf);
 
 	vfio_pci_driver_probe(device);
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 8cec09ba8ec3..dfc14c40bcf6 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -116,7 +116,7 @@ FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_1gb) {
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 8856205d52a6..7a270698e4d2 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -28,7 +28,7 @@ FIXTURE(vfio_pci_device_test) {
 
 FIXTURE_SETUP(vfio_pci_device_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_device_test)
@@ -116,7 +116,7 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 
 FIXTURE_SETUP(vfio_pci_irq_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_irq_test)
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index ab22b7e357fd..30cbfbb9225f 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -63,7 +63,7 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 
 	driver = &self->device->driver;
 
@@ -225,7 +225,7 @@ int main(int argc, char *argv[])
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 	if (!device->driver.ops) {
 		fprintf(stderr, "No driver found for device %s\n", device_bdf);
 		return KSFT_SKIP;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


