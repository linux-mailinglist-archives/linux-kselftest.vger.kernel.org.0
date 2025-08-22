Return-Path: <linux-kselftest+bounces-39755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685EDB32489
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C60B1CC313B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE327350D6A;
	Fri, 22 Aug 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdnKRpcA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB51350D5C
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898006; cv=none; b=SucO92twPeRHXxW8tOdiaXA3Tce/JFwOZ9sem/TzYMpytk+o0NUctw/dprZk9uGNQEaDs4xU+v9cYu+tCrtiT9Akuib/FveqOi3ZdqCdcF/e1urxvXs/7kr7jOcX6aGK9JWkd358bDe6u86JPZi5trB0ifcQXRQ2t3jrxVkMtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898006; c=relaxed/simple;
	bh=cSkYcuaX3oU/criDJ+K/z4WH849qNnbDVm7OFKlSy68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QvBO0E2aW75Kmz0c9BGHOFhWG+ZT0wXrly+SeqyQqVeCJQvJ1CtpOqtqkmnKZzv2DeuIV18Uo8N/Zwiq4oYqDo0j61XKBNy49Zyge/2Qm/EPGOTy16yX0on8GF6V6lClPD1KTgL18sP9epUFVoJS/07ToEOMAKmXKT5bp7N7M/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdnKRpcA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32515a033a6so1216847a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898004; x=1756502804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0bkK4mSXm10ZkluTqHQ3Z0bMD02jdINVTddhxda+LM=;
        b=AdnKRpcAmLEY11A6SDu5E7qFTmzbq+YL0qwaMe55/dMpnbs4/ZS9qD0EQy3GOo6Rz6
         fKHY0cbnpRW9GprEnXS+8VVoLFqlNvN/nFFNLP41eyxW59dsus5KfRf7TfSa6u2SWpYN
         B/Ei9XvGoNVmgUEKWWktFjDhYeQ4gtigQ2P47149HpPZSDPJwbhlSfH5puf7UTrNmwtg
         lbLoDNikSFrJMIzOoN6NAdFrzIkSGa07w1nLtmI++Cjdezxd9wO+wR7UTzCLMtWTfx9r
         B1Duj9PDczWDGFVWojR8t8vWcNKVLIAqs+BNoSHNsqhBSDzxxGubTAD90R/QW9OvPnY8
         MsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898004; x=1756502804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0bkK4mSXm10ZkluTqHQ3Z0bMD02jdINVTddhxda+LM=;
        b=ItbmXRaccaVOV5RnUpClZlrM417xzF4YUDSRFoNO1xtHcGh64e+87Jrlxctn7+IB3s
         ptqx2UOE33oAE+rUf4TPUgEXEoZDxc1bcZTUp5YksQRV+F1UV1Cw2pHnFR+vBtVKu6if
         /aJMvMAb5ZLJnF6gN+a/b5/vMfUxenSb36uDKJp/+T17wurqKP+RzKbkXb7zvLqVdTmh
         OiNXe387fYknkuUPfDZfngQjiZ+SxUC+K/nOUWNJKpdwBSAA/GmTRovnKdU+L6VnVamt
         SHFSrY6IIC+WUNBwm7Cim1IQJhJv0k3L5tc/YVdfNTrmrtF4mVfcVT5m8LGmPd58r1om
         UGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWZji3ic4epBwua6l+bUt9dGiQglq5ybZhpRK7U67fbQHyFUFmy3PTc0yYh0CqguQWQ4NV+su7CtMoAZLPe2Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pIiRrQJIbJdjAFtlkwRT1ZJWYIntP2CMzo2KKHvggta3lnhk
	Rb0NnURHWcpu2x9M/ARJfC8Ob8beG2c0gl/FkVn/gcXAx+bbY9Z6D/g/oyfWWv+JtzEyNF7BOA2
	sjpdDDZ/pnddOOw==
X-Google-Smtp-Source: AGHT+IFmn6TTSL5cfXgfXq+ycgMJtyW8LLCUeS4yL/8Td/V+/kKjL+Rhoxxbo4FPMSlNzj2lTQF1peQ8bWiKqg==
X-Received: from pjf15.prod.google.com ([2002:a17:90b:3f0f:b0:31e:fac4:4723])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3952:b0:321:3715:993 with SMTP id 98e67ed59e1d1-32515e48ec5mr6713487a91.14.1755898004350;
 Fri, 22 Aug 2025 14:26:44 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:11 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-25-dmatlack@google.com>
Subject: [PATCH v2 24/30] vfio: selftests: Encapsulate IOMMU mode
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

Encapsulate the "IOMMU mode" a test should use behind a new struct.
In the future this will be used to support other types of IOMMUs besides
VFIO_TYPE1_IOMMU, and allow users to select the mode on the command
line.

No functional change intended.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
index 4578ee6df0e1..f07bdb602422 100644
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
index 97ed0ff4636d..14ec862c0b11 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -60,7 +60,7 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 
 	driver = &self->device->driver;
 
@@ -222,7 +222,7 @@ int main(int argc, char *argv[])
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 	if (!device->driver.ops) {
 		fprintf(stderr, "No driver found for device %s\n", device_bdf);
 		return KSFT_SKIP;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


