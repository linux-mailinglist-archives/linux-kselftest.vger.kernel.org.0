Return-Path: <linux-kselftest+bounces-33720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34813AC2C5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2AA17BF25
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611A21C9E0;
	Fri, 23 May 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNCNauDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977B22423A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043066; cv=none; b=hFO6LDqHj0RdckRukeaMdAm0RqfXMrVwLLW8CnXjdxPreoSrjaX371UytP0XmxxSX6L6Wf0B9PbKswIwEJ13GLnkumKfvy1vgtMPD3wCinJ79lw3vrQDTAR6LQlw1dUBl0OPlQ2vPtmuOWxDSkgYa5BOE7JpLYUIpJLE/MKwl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043066; c=relaxed/simple;
	bh=FM+Q0tKqNPjMqropgoPOA/bsnz1zZ+dzuBWeIU/d2Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HRsjsocOIg2gwu0DsIY4tkBGWPOK0hBaULTKYfzGXwwxik5Q82WHx3cXxo/nk55QgDgYu84rRrFlTigMvBGLsHwi3cDeUPuiyMSzrzlDR8QxKjZERanGXCwqm49l5CYksLP7DyzVkkPUmJZMfymzPZcKoHJ9VHknCed8OdRI2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNCNauDo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3110b78e12fso590235a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043064; x=1748647864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkrx8Kkk49ObTzad3Ru3cIfSJh+Fo829dJe5oWTSPnA=;
        b=qNCNauDobH/LkhxhGE0Vb7tIdEOs/nNNtukeYMX98FOAxiq83UGsJ/xzYvzG5D9yHc
         HMGNpnkdF1FlmYPBLCLFrj7VcQWcGkH0R+QWmRIFaYmwr0Af78MmuDvLYb/l+TOowgnV
         sz0mvY2NUVaGru/KQwyu/zKU7I1dQpzRFOeJL6B4clRPFMLy0j6FhbazOGxbvc/CZv+e
         n3cHgyVdRs3pFwA+JMJTkn18/PZeTVY7ICYK+aMS3fz9AbkUBPOnzwCTsnkALOvf8zi8
         3OldCLInEE09pJAGhIzPw6f8R2FAUdQXwJvsHFynBcZ3umUp8bYXnjWxhwTqSYcRFpty
         Yf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043064; x=1748647864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkrx8Kkk49ObTzad3Ru3cIfSJh+Fo829dJe5oWTSPnA=;
        b=Zp7tjGGUJoDcG8GYN90Z9gwfn/03HcbYKQGjbo5WNID+KNd5iHjUGo43VqqKU9p5wQ
         jbaDOup5yHL2AipVH+LkMqy0kTvN7am+lrEQKhLyGZ4TWmrQ/w+DRXwhHXNXv+5V7w5a
         Hg3jN/iUAZoTMih61JiKHN8YRdmckZutp4AJEY0syyLDMk0I97OwV+vyh54YG+KQbdyj
         NA8YN+IyJ8T6vT2W/+MXzu2bCQhz9hkh2efP7eDbH2F+qtqBHDUubiT5CUOGDTbzOFkc
         PH6EbDECe1pljjLpx/VlaNJ4W612Ev4ZINeajrrF1hbzuaNw3Zygbt+KbYhGFY/NOhA9
         EUJg==
X-Forwarded-Encrypted: i=1; AJvYcCUC3mKEhn+GV8AGNyBSaDnzWq717JxBuELvhL6w1Mci0KKcPN7+cBFcec2UBitsT+T1pB5jqvl8i0DkKl46r/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3678xuOCk35uxX9iFAeaF8Y6k73pEVKqdjNZ0Uh04JThvFXt
	05SFo4IcCqC75a+j8Zyl9XkJfcGZaKQOb1FLxDL7r/4K9vicn45/NmNpYLGAB4hdHLxeviFNsl2
	Kj//RhCD3JHB7Pw==
X-Google-Smtp-Source: AGHT+IFKAl5G/e0aWFtyeKtZPPS0i6Ute1Jo05vyM+uv31HFHACr2p+FLR6exCywz1epLdDwwaf83r7gH6NB4A==
X-Received: from pjl13.prod.google.com ([2002:a17:90b:2f8d:b0:2ff:5344:b54])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380f:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-311104b8eeemr1352205a91.27.1748043064085;
 Fri, 23 May 2025 16:31:04 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:09 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-25-dmatlack@google.com>
Subject: [RFC PATCH 24/33] vfio: selftests: Encapsulate IOMMU mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
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
index 2b2e2a163e92..bff8f550274b 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -47,6 +47,12 @@
 	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
 } while (0)
 
+struct vfio_iommu_mode {
+	const char *name;
+	const char *container_path;
+	unsigned long group_iommu_type;
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
 
@@ -164,7 +172,9 @@ struct vfio_pci_device {
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
+extern const char *default_iommu_mode;
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index e8a9d46701c0..4a95cf0c1b1c 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -18,7 +18,6 @@
 #include "../../../kselftest.h"
 #include <vfio_util.h>
 
-#define VFIO_DEV_PATH	"/dev/vfio/vfio"
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
 
 #define ioctl_assert(_fd, _op, _arg) do {					  \
@@ -257,10 +256,11 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 
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
@@ -286,8 +286,9 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
 }
 
-static void vfio_pci_iommu_setup(struct vfio_pci_device *device, unsigned long iommu_type)
+static void vfio_pci_iommu_setup(struct vfio_pci_device *device)
 {
+	unsigned long iommu_type = device->iommu_mode->group_iommu_type;
 	int ret;
 
 	INIT_LIST_HEAD(&device->dma_regions);
@@ -359,16 +360,45 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
+static const struct vfio_iommu_mode iommu_modes[] = {
+	{
+		.name = "vfio_type1_iommu",
+		.container_path = "/dev/vfio/vfio",
+		.group_iommu_type = VFIO_TYPE1_IOMMU,
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
index d85621d165d9..2ecf2514f30c 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -104,7 +104,7 @@ FIXTURE(vfio_dma_mapping_test)
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(test_config.bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(test_config.bdf, default_iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 1a26df0f2280..45707c6d1c09 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -27,7 +27,7 @@ FIXTURE(vfio_pci_device_test) {
 };
 
 FIXTURE_SETUP(vfio_pci_device_test) {
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_device_test) {
@@ -113,7 +113,7 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 };
 
 FIXTURE_SETUP(vfio_pci_irq_test) {
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_irq_test) {
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 5d14d892b796..0f05cc3774a6 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -62,7 +62,7 @@ FIXTURE(vfio_pci_driver_test) {
 FIXTURE_SETUP(vfio_pci_driver_test) {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 
 	driver = &self->device->driver;
 
@@ -228,7 +228,7 @@ int main(int argc, char *argv[])
 
 	device_bdf = argv[1];
 
-	device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	device = vfio_pci_device_init(device_bdf, default_iommu_mode);
 	if (!device->driver.ops) {
 		fprintf(stderr, "No driver found for device %s\n", device_bdf);
 		return KSFT_SKIP;
-- 
2.49.0.1151.ga128411c76-goog


