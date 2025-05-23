Return-Path: <linux-kselftest+bounces-33721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B4AC2C5C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83B917E39B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0F225403;
	Fri, 23 May 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GA3iiXrC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4C1A2632
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043067; cv=none; b=R6fHLwMXe/gV1DJGtuUfS8pPJ/vmheFInN5g9QQLrX59jhXflXlQ28ra4YR5/O5HLJdqaBp4qGHlj3/ZCbUVw1EdMXuJkzhzo6F0lHUsSnQ5u4ZB0YaOjDvGqWE7z/41v6nR9J7+PObuu6yDX4SPQb35Ut+/BATog6nzI18Bow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043067; c=relaxed/simple;
	bh=pOIp/DIUKhNY2aIR5tK8HnoIlkcHp9iBzbdr47jp2s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B/fy+niTBcEleqqORnkbeFjQbzFikZdM+LkhDLHUrnyVlMkUFU21dFfHTlZJNbE9WAKF6NeRsfUb2gTVEyMkbHlG98qqKZerXt5Gp3f+PXf4bb14mjNl/UY2s+IdE0w0VzxMDE8zRUDSSwRnmA9Kz47decxzCzL7WWx+LjbjSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GA3iiXrC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31107a2d3a6so422151a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043065; x=1748647865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGY+nOQP9iBBDodVESqUTZq+HuXgnH+CwJ9HUzXR2Fw=;
        b=GA3iiXrC5JZOV95Qj+PcsnHp+X/gnkYWTTm9hcRbdiV9QgjYBnQ516Ui4dzE8cQn97
         O4uj4QD2TmmLmcMqtsoTX86PIXgPqYJiNmhmvfySPQrVf3KqOfoolsN89ecQkeLjthYu
         jHNYJuZb6ABW1zoXd+UvHvCFPy2uiL+lB6dnom6FCYQfntnCjVkyzbtylMIoicqloidC
         moGSSC711pC+Y029hxKgOIojCrl2AbtK7IUTtmF5j/IedhSh4CQzOgHy7rIOHKBgUF3s
         6jlKlTYlneejMGFfrzifcfT2nefyiHCTkjUfzFfg+UjyUt6hDaYdzCU8ptfe9QiCNBR6
         T8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043065; x=1748647865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGY+nOQP9iBBDodVESqUTZq+HuXgnH+CwJ9HUzXR2Fw=;
        b=JgosunXB4RLVSe+F95Nv1rBvmv4KWkXZHV+qDLEBAqA92did9+rli8e92F+v0R4zDX
         ppAyJ2gt9tIjtF/ThDe957MLJxyrH6KGoT2oM4A/XRSOjjBQw8bcgFSAbdMJeP7yg8gc
         oIB/JxCNsKNA4UfdaUhIP/lrpBsHXLbGTnU1Qf83tKZHDluHaMcgjYzMCipYFQq8Fd/u
         fuxA0tSgf327t5FjXkApa+G6etOKB9AoTM9z3PlIUKFAKlQM7qa5bIX9kCVhP+PF1OKm
         d4r4GKaCq7OuGrK7s5N+SR3mxWQEw7WWBE9juLJMuVgBzScF7X6Q3s02ziWhMsQXzZ/2
         K9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV90FrOwrvg6DYJoOvBvQBVW5NQ6EhXmybCb7Rplpuf3vRk+XpHEan5sn6sJRY2vhqRQggf5vjwVb2oGSGXnoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOraIcdb2mfi4k1VUybJYngeYc+JsEdTE9Rkj6JuATCmqCvEGt
	ry1TAGwlhzoesdALH0NJybvoQ8yMwK2ndppsPvUnxikozrlbEJ+vgPqpNzC+9exJH2NACoY0Kyj
	kNGOkM4QJJnUQyw==
X-Google-Smtp-Source: AGHT+IHSU3lNiHuNtBXnUBL1fqAVCDdPxB38cdSnkbBvSb6yFTaJD9TAUss2ftfrHqEU/+T75febH+pLDwrHZQ==
X-Received: from pjbnr11.prod.google.com ([2002:a17:90b:240b:b0:311:ee2:edff])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c0e:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-3110f920c85mr1543436a91.17.1748043065294;
 Fri, 23 May 2025 16:31:05 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:10 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-26-dmatlack@google.com>
Subject: [RFC PATCH 25/33] vfio: selftests: Add [-i iommu_mode] option to all tests
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

Add a new command line option to all tests that allow them to select
which iommu_mode to use. This makes it possible to replicate tests with
different modes and therefore get test coverage of different parts of
the kernel without having to change the tests themselves.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 15 ++++++++
 .../selftests/vfio/vfio_dma_mapping_test.c    | 14 +++++---
 .../selftests/vfio/vfio_pci_device_test.c     | 33 ++++++++++++-----
 .../selftests/vfio/vfio_pci_driver_test.c     | 35 ++++++++++++++-----
 5 files changed, 77 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index bff8f550274b..9989528c21b9 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -173,6 +173,7 @@ struct vfio_pci_device {
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
 extern const char *default_iommu_mode;
+void iommu_mode_help(const char *flag);
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4a95cf0c1b1c..950c83fee3ed 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -370,6 +370,21 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 
 const char *default_iommu_mode = "vfio_type1_iommu";
 
+void iommu_mode_help(const char *flag)
+{
+	int i;
+
+	printf("  %s: The iommu mode to use for the test (default: %s)\n"
+	       "\n"
+	       "      Available modes:\n",
+	       flag, default_iommu_mode);
+
+	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++)
+		printf("        %s\n", iommu_modes[i].name);
+
+	printf("\n");
+}
+
 static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 2ecf2514f30c..e2f636838130 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -18,6 +18,7 @@ static struct {
 	u64 iova;
 	int mmap_flags;
 	const char *bdf;
+	const char *iommu_mode;
 } test_config;
 
 struct iommu_mapping {
@@ -104,7 +105,7 @@ FIXTURE(vfio_dma_mapping_test)
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(test_config.bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(test_config.bdf, test_config.iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
@@ -172,13 +173,15 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-b backing_src] segment:bus:device.function\n"
+	printf("Usage: %s [-b backing_src] [-i iommu_mode] segment:bus:device.function\n"
 	       "  -b: Which backing memory to use (default: anonymous)\n"
 	       "\n"
 	       "      anonymous\n"
 	       "      anonymous_hugetlb_2mb\n"
-	       "      anonymous_hugetlb_1gb\n",
+	       "      anonymous_hugetlb_1gb\n"
+	       "\n",
 	       name);
+	iommu_mode_help("-i");
 	exit(1);
 }
 
@@ -211,11 +214,14 @@ int main(int argc, char *argv[])
 	const char *backing_src = "anonymous";
 	int c;
 
-	while ((c = getopt(argc, argv, "b:")) != -1) {
+	while ((c = getopt(argc, argv, "b:i:")) != -1) {
 		switch (c) {
 		case 'b':
 			backing_src = optarg;
 			break;
+		case 'i':
+			test_config.iommu_mode = optarg;
+			break;
 		default:
 			help(argv[0]);
 		}
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 45707c6d1c09..842f0f2f3523 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -14,7 +14,8 @@
 
 #include "../kselftest_harness.h"
 
-const char *device_bdf;
+static const char *device_bdf;
+static const char *iommu_mode;
 
 /*
  * Limit the number of MSIs enabled/disabled by the test regardless of the
@@ -27,7 +28,7 @@ FIXTURE(vfio_pci_device_test) {
 };
 
 FIXTURE_SETUP(vfio_pci_device_test) {
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_device_test) {
@@ -113,7 +114,7 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 };
 
 FIXTURE_SETUP(vfio_pci_irq_test) {
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_irq_test) {
@@ -165,14 +166,30 @@ TEST_F(vfio_pci_device_test, reset)
 	vfio_pci_device_reset(self->device);
 }
 
+static void help(const char *name)
+{
+	printf("Usage: %s [-i iommu_mode] segment:bus:device.function\n", name);
+	iommu_mode_help("-i");
+	exit(1);
+}
+
 int main(int argc, char *argv[])
 {
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s segment:bus:device.function\n", argv[0]);
-		return KSFT_FAIL;
+	int c;
+
+	while ((c = getopt(argc, argv, "i:")) != -1) {
+		switch (c) {
+		case 'i':
+			iommu_mode = optarg;
+			break;
+		default:
+			help(argv[0]);
+		}
 	}
 
-	device_bdf = argv[1];
+	if (optind >= argc)
+		help(argv[0]);
 
-	return test_harness_run(1, argv);
+	device_bdf = argv[optind];
+	return test_harness_run(0, NULL);
 }
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 0f05cc3774a6..e94b77125e5e 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -11,7 +11,8 @@
 
 #include "../kselftest_harness.h"
 
-const char *device_bdf;
+static const char *device_bdf;
+static const char *iommu_mode;
 
 #define ASSERT_NO_MSI(_eventfd) do {			\
 	u64 __value;					\
@@ -62,7 +63,7 @@ FIXTURE(vfio_pci_driver_test) {
 FIXTURE_SETUP(vfio_pci_driver_test) {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, iommu_mode);
 
 	driver = &self->device->driver;
 
@@ -217,23 +218,39 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	ASSERT_NO_MSI(self->msi_fd);
 }
 
+static void help(const char *name)
+{
+	printf("Usage: %s [-i iommu_mode] segment:bus:device.function\n", name);
+	iommu_mode_help("-i");
+	exit(1);
+}
+
 int main(int argc, char *argv[])
 {
 	struct vfio_pci_device *device;
-
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s segment:bus:device.function\n", argv[0]);
-		return KSFT_FAIL;
+	int c;
+
+	while ((c = getopt(argc, argv, "i:")) != -1) {
+		switch (c) {
+		case 'i':
+			iommu_mode = optarg;
+			break;
+		default:
+			help(argv[0]);
+		}
 	}
 
-	device_bdf = argv[1];
+	if (optind >= argc)
+		help(argv[0]);
+
+	device_bdf = argv[optind];
 
-	device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	device = vfio_pci_device_init(device_bdf, iommu_mode);
 	if (!device->driver.ops) {
 		fprintf(stderr, "No driver found for device %s\n", device_bdf);
 		return KSFT_SKIP;
 	}
 	vfio_pci_device_cleanup(device);
 
-	return test_harness_run(1, argv);
+	return test_harness_run(0, NULL);
 }
-- 
2.49.0.1151.ga128411c76-goog


