Return-Path: <linux-kselftest+bounces-33719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F670AC2C53
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4840F1BA1268
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B0224890;
	Fri, 23 May 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvmTdgzW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E422128A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043064; cv=none; b=n4FxVqqWZdwt4s8phgJEOKq5tQAo+Y97PXYAJ+3z2GxSpJ4HgVzBRZsPCooZwJc9/JadtR16TrozQPDsYQAVSh7JEEK/GWxnzjpyd9zg72wnGlGBBuABGV8j9I4NNfTh2WV3b3J1XfBT2EJfMmQ0b30rpMKYzAeeHwWB2kYtlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043064; c=relaxed/simple;
	bh=vFs8FhKXThlDl8gl9lqjzAsf+cUgqxZKaMuhdOCMOWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MdRtTc1DaNXh4aJutEoe6B+K6iephbe03uHSdiIkvp98l52sf2pq0TT6/y0vrboBgDnGBBzP7J0RbdKgcZ5SOcm1L2T4YcxWDbKqmbxiO5eluHbmNAY+ueAnv5bSL2dQFGBhLm8X0PjslOCpwrH0wbUcxvJN3gUFsr4MZDBRlzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvmTdgzW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31115ac777eso90081a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043063; x=1748647863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmAtv8Z3we9X68L9eSaacbznKrLtP8kivRA2Uh0Ke1o=;
        b=jvmTdgzWeEZxWdM8JcXDNNIb0RuDiTjZ1kdNB3ounwQeD5sHyMkolDfUUp6Yp1DxRM
         ERMagtsIzHiHth0+MYBiWj0lSuAa2GJtipkn6guKdeSITgCuyMUC6zCiOKLCbtvTikkf
         qU+mXc+UZVkgrVIubCqCFCn+Twf6EqUIGWnWYgHFu910BgaqPz78ZKw9f22mpxqz9wqa
         MwCcMqWxOzSWjmvCn4wuk5usNwrRl2G3pE4CnWqYqy7xlO3OtQbIY3Ag3yHfC4gdNlMn
         ImvvsB3hjSAhosi3t9H7g8kGzDY0qNadS0UEiusZ70h2OSsFTEwFrqXoVw9c6l5UE5ap
         s0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043063; x=1748647863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmAtv8Z3we9X68L9eSaacbznKrLtP8kivRA2Uh0Ke1o=;
        b=ai1hyQ9CjgLqv9aLo1usTKQn1FN9ZuucX0MYgXh0QwvvFT5yWM0NNz8Qc7bn3t98ef
         9Y2RSMLBac5Q125tBAEc+qm++CULX4/ZRPCqT98FNxgetv5hZabcjiHTAsvqHbV6a+N0
         gj24h7zVbPm1WV4TUR+AChq/j9nFJEf1FUcNFupFCFLmuBVlx5KzH59RhVV+izdyvKd6
         DaxRpuD9865UTePUqJ7KpXj4/y66XdSEtdrEUrTxM+o2jOJKFnfturj79gzYgPPBOsbU
         tU9gJl02IRpSWoC0MNNnT2/Bwl2N7ElciNjiIlS3KHFCP/7f4SAlQxM/3GBQdwlB2XGR
         R6iA==
X-Forwarded-Encrypted: i=1; AJvYcCXp9jPh76rw9XmjOYr8o3swIaodz7kRwmatdid8J/oOJJCKdo05dxOMj2FF0p3uwxecYgzlS4+PDCb5k8Z8V8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFdp7a7moyl7mksjs42SSemmOsaldxTeiaMBG3Wl+yvztvkD7
	a0rr3KGo8y2KKMonvamTvlAjRyfPIPfEqllP3p7JyXyp89CTW5Bj4zJpwSSu5Q/6+rpkRJDQjoL
	4CxvWWpHlM4SKRA==
X-Google-Smtp-Source: AGHT+IHbyFl7zJp9gN97I4mlVfhffDH9SL1VjAMbMuw+eHd+0xtX4C9QWNbyCGJvzFm5NoOvfBnqsqTpMY5vAg==
X-Received: from pjbeu5.prod.google.com ([2002:a17:90a:f945:b0:2ef:d136:17fc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-3110f32a9d7mr1555606a91.19.1748043062658;
 Fri, 23 May 2025 16:31:02 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:08 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-24-dmatlack@google.com>
Subject: [RFC PATCH 23/33] vfio: selftests: Move helper to get cdev path to libvfio
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

Move the helper function to get the VFIO cdev path to libvfio so that it
can be used in libvfio in a subsequent commit.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  2 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 31 ++++++++++++++
 .../selftests/vfio/vfio_iommufd_setup_test.c  | 40 +++----------------
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index c824c993d82e..2b2e2a163e92 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -162,6 +162,8 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+const char *vfio_pci_get_cdev_path(const char *bdf);
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 63f033047b4c..e8a9d46701c0 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <dirent.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <stdlib.h>
@@ -328,6 +329,36 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device, const char *bd
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
index 851032f79a31..6965785cc32f 100644
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
@@ -11,39 +7,15 @@
 
 #include <stdint.h>
 #include <stdio.h>
-#include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
 
-static const char iommu_dev_path[] = "/dev/iommu";
-char cdev_path[PATH_MAX] = { '\0' };
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
+#include <vfio_util.h>
 
-	closedir(dir);
-}
+static const char *iommu_dev_path = "/dev/iommu";
+static const char *cdev_path;
 
 static int vfio_device_bind_iommufd_ioctl(int cdev_fd, int iommufd)
 {
@@ -148,15 +120,13 @@ TEST_F(vfio_cdev, attach_invalid_pt_fails)
 
 int main(int argc, char *argv[])
 {
-	char *bdf;
-
 	if (argc != 2) {
 		printf("Usage: %s bus:device:function\n", argv[0]);
 		return 1;
 	}
 
-	bdf = argv[1];
-	set_cdev_path(bdf);
+	cdev_path = vfio_pci_get_cdev_path(argv[1]);
+
 	printf("Using cdev device %s\n", cdev_path);
 
 	return test_harness_run(1, argv);
-- 
2.49.0.1151.ga128411c76-goog


