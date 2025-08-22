Return-Path: <linux-kselftest+bounces-39754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E0B32482
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28148A26CF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7546350D59;
	Fri, 22 Aug 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FF3uuk2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF7350D4E
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898004; cv=none; b=BbuxUlfINoJ4litrVJXb5xYMNijlnJeLx2yM17P4L75l/aDvs8ixZqSpnBSyukIiguGmFmGFSfVIVHf5bnJL9Q1gpCIKQIRB1o3yxFt0DMH8TlURd0Kh2TB0mkUcFuwnSLDD4ZpMdg5kkukYBUbVqWKwq7ZA9FyU+Y2FVqMjg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898004; c=relaxed/simple;
	bh=xpUdCi7MM+oEJaPVmyrSiljhyUvX5dGHGcIrJNHF51w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qu/bEONF/zXVFvNHiV4AVXXSeVp0JfJCuvxm5z/7ezUpK0N4yq8nmjAXNHfUPPzLZtenJLaWvT1JWYgkXp47hrgHSBlh3BxyMnUxh1xKAgwRnghJCxxdypD0YZpcJeb0DGyx4T3jAEorCoftRHgfBV4z/JghInYrPQANue1RnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FF3uuk2u; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32515a033a6so1216833a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898003; x=1756502803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPuXs/LFwyr0ZLkhRmgchtPyIs+iLM2WgAKlw/glFdk=;
        b=FF3uuk2ukQgZ0yadOhiZLx6e8Sa/G/8nibmcXgHsj1Sat41UHJ396JiRVRPMMx5cSF
         v7t/Dokj6nUhcn40KNwZvF7BErXx8tL6HhakvhCBobENxVBLins0u8U3wFHr2OUOTpET
         xS/9/MuW7bDTRevOOmqmJnYCsTfrZg/usVYjFrYCq09Ehjxz/dSgEe3/JTDLAmrnWGFN
         grFz97OIUGapHWnlOQcR7z/VnFx8iwRb5gPDVD6UAIavqU40OJPiWCwrV7s3omBqwcMi
         d+DNMt0/AlM3MlekmKixR/dj0QRvSKRgnK9gzZEpXQRHmavgVK9t4gzJ7/Z21w8YrweX
         aflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898003; x=1756502803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPuXs/LFwyr0ZLkhRmgchtPyIs+iLM2WgAKlw/glFdk=;
        b=dSzLdrOvSFakMY34U1ViIX3ZGXD9OpBwahjsCaXp21ca948zVMX/4dvKPjjGx9W3zY
         xys7ApWmTkhpd76m7qZdT81JewM1YsXNSDrJgvegT/OLTyIz4+EPKXcb+qiguQbUXRkh
         IiqA0dmfMIBnXvS6mukXgsBlwWBixg2A/TsZtvsyqQOegSTbMuMsBcL9jN9Cdk+ee/+G
         ojfsG5GOD/1w8m3hwTYUikYTNBDCIBqo/ch+4wCvRnJShYHSJOf1yp6MteSOmfemdyYc
         eU7YSC1Kd+peD5VIh2tx+wgfE3n9giF6u4KeSmMPO6JQiqsOPF4XYnnJzsdwl276bax7
         dgjw==
X-Forwarded-Encrypted: i=1; AJvYcCV/81tCeWX2PF4Y59jpu4TetLbes08XGDMOpeRTmT0SyXBIvEIxgBvmCnn8CaDAAIBUONQ6GXVtZ1awVc4HJTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9zX8Sd+Y3zLlJ6ex/R4MK4A1pVdbg8UqhJ7Rem9kdUXp8E8J
	9P2ZvB745JAUL1Vf8S9Gnu1asKbtHJzvwq7+QuWqPNSNkohATBV5ZIc5Hb3ILjbIXWh6GUab/BP
	Z4DCNPtt2UL4ALA==
X-Google-Smtp-Source: AGHT+IGPBuABDiHFqVWxrfuTPMkWY5pTEt2G9Y9G/CPzhUOUFQB9mr+Z+Vew2nUMsMo94EjrV5xFgqGYdk/k+w==
X-Received: from pjbsm17.prod.google.com ([2002:a17:90b:2e51:b0:325:238b:5dc6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2c87:b0:31f:2101:849c with SMTP id 98e67ed59e1d1-32515e48b22mr7124067a91.12.1755898002811;
 Fri, 22 Aug 2025 14:26:42 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:10 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-24-dmatlack@google.com>
Subject: [PATCH v2 23/30] vfio: selftests: Move helper to get cdev path to libvfio
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

Move the helper function to get the VFIO cdev path to libvfio so that it
can be used in libvfio in a subsequent commit.

No functional change intended.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 31 +++++++++++++++++
 .../selftests/vfio/vfio_iommufd_setup_test.c  | 34 ++-----------------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index a7d05a4299a1..05a10417e0d7 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -175,6 +175,7 @@ struct vfio_pci_device {
  * If BDF cannot be determined then the test will exit with KSFT_SKIP.
  */
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
+const char *vfio_pci_get_cdev_path(const char *bdf);
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d8bb227e869d..d53e2d682c7e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <dirent.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <stdlib.h>
@@ -332,6 +333,36 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device, const char *bd
 		device->msi_eventfds[i] = -1;
 }
 
+const char *vfio_pci_get_cdev_path(const char *bdf)
+{
+	char dir_path[PATH_MAX];
+	struct dirent *entry;
+	char *cdev_path;
+	DIR *dir;
+
+	cdev_path = calloc(PATH_MAX, 1);
+	VFIO_ASSERT_NOT_NULL(cdev_path);
+
+	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
+
+	dir = opendir(dir_path);
+	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
+
+	while ((entry = readdir(dir)) != NULL) {
+		/* Find the file that starts with "vfio" */
+		if (strncmp("vfio", entry->d_name, 4))
+			continue;
+
+		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
+		break;
+	}
+
+	VFIO_ASSERT_NE(cdev_path[0], 0, "Failed to find vfio cdev file.\n");
+	VFIO_ASSERT_EQ(closedir(dir), 0);
+
+	return cdev_path;
+}
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
 {
 	struct vfio_pci_device *device;
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
index f45335d9260f..3655106b912d 100644
--- a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <assert.h>
-#include <dirent.h>
-#include <fcntl.h>
-
 #include <uapi/linux/types.h>
 #include <linux/limits.h>
 #include <linux/sizes.h>
@@ -11,7 +7,6 @@
 
 #include <stdint.h>
 #include <stdio.h>
-#include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
 
@@ -19,32 +14,7 @@
 #include "../kselftest_harness.h"
 
 static const char iommu_dev_path[] = "/dev/iommu";
-static char cdev_path[PATH_MAX] = { '\0' };
-
-static void set_cdev_path(const char *bdf)
-{
-	char dir_path[PATH_MAX];
-	DIR *dir;
-	struct dirent *entry;
-
-	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
-
-	dir = opendir(dir_path);
-	assert(dir);
-
-	/* Find the file named "vfio<number>" */
-	while ((entry = readdir(dir)) != NULL) {
-		if (!strncmp("vfio", entry->d_name, 4)) {
-			snprintf(cdev_path, sizeof(cdev_path), "/dev/vfio/devices/%s",
-				 entry->d_name);
-			break;
-		}
-	}
-
-	assert(strlen(cdev_path) > 0);
-
-	closedir(dir);
-}
+static const char *cdev_path;
 
 static int vfio_device_bind_iommufd_ioctl(int cdev_fd, int iommufd)
 {
@@ -150,7 +120,7 @@ int main(int argc, char *argv[])
 {
 	const char *device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	set_cdev_path(device_bdf);
+	cdev_path = vfio_pci_get_cdev_path(device_bdf);
 	printf("Using cdev device %s\n", cdev_path);
 
 	return test_harness_run(argc, argv);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


