Return-Path: <linux-kselftest+bounces-33699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABDAC2C2D
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211D9541DB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4E21C165;
	Fri, 23 May 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuZwSA6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BF21931B
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043038; cv=none; b=Usru1qqm/pH00qUu5VglBHydZSXCIMQMZSNQ7/dGYa62w8PCwh+0xNflHNNrluFvsGWzigqj1xdi4vjReWQVzlS8hss1wEmfiCW56yy/AV5Q36lPuKCNpycNi0BJO3jg8cXD+Tz7pwQQX9UddSo9PW2Epa6MksEa04uqRv0Yah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043038; c=relaxed/simple;
	bh=WoLbSFQAC6hJhgTv6NdUeir+/oJP0vNdbDZYEUdv9t4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNq4kxDpEBYRvVF5LP5Vr4cV51vm+jTEBXy0Qrh8Bh9lm7VvMzSVr/Nz44YfmY7/tGX0zTgZAE9vo31/+xAh+ZYlkqJxPioHoc6JaftHnlImyTEtavEGzBijVaB0Y71KoIl9jDW5T+hqLZb3AG0fLk3nqBKNa9pN5/cCodwT6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AuZwSA6U; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2371b50cabso385055a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043036; x=1748647836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANhozhEiqQ7c0YKppCacCy/RuwymTQ2YvO87vgsb0UM=;
        b=AuZwSA6UF449OB478bEgx3PWIKOMvfH/0EG0f7VdY43omokbha353RmGyBzQ2oezhC
         xqklVVhSwOUpBd72GyjAT3zNFp03+HH5GHPJRrc/E39PAqlHWJ5B4EU4rIEm6OXvdD3r
         p6cKiKWUgUYxTbQTj4sO8Y4I9OdWo5TpnrVJAt4r/smoYg0fM9V8hZJXc4bgv/l4LheI
         nyT17n8+MQEpxZdeTVRDGZHxloLZlgB4UbdJWK+fSjzR+pr0d8xUzLqsEHFMw11H2Fk6
         kjKRvCfmfXJhroB8bxoCG+BZN/WFjIshIGhuKQpu2+8+j6DyDMvLQGQ3YXDMNZBn6oIs
         An/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043036; x=1748647836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANhozhEiqQ7c0YKppCacCy/RuwymTQ2YvO87vgsb0UM=;
        b=GJiTVPX7rOQgv4L1m1JiM4XAMSjUkOAH9JLi0dFQcWwedqDfxn8tCYxQRQursBNUBY
         6r7qbztAkjM1fow9lug3EKZ8Fsf0oTz1rmX+AUP+adV2RPELS+htvci7xLx0wKUhPmZc
         Sj7tZqC1bAg5fYbbOwqjo8wZ642695BlerhTWw6PRYmxs7gFq4AsKH4G2i0YZKdgdGSO
         Cl5akRWZCUAYnTeC2+jJ+RnzY3GUEl4L743jOKrIMwniKec9k9xVt+tC9FaxSZaZv6P6
         vjzwewu6ywTHTkfL5NvZp5n+vemq/ZgBV2dNKm9URbvepOUzXXyQ4Ly3aWxNQUMeEnq5
         S/vA==
X-Forwarded-Encrypted: i=1; AJvYcCWuXYHNf62VGTlxzKFfXT7jvDgLiAB6OdCv38ucFdJ/HvAKmD+mYQbTngiLk1qOBVyIChY6k66jD9l+FhcsQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4g65W4OXTpXGs4NxEUNcU5KdeylUAskvIAbXdjRsHUk/apF2
	0VXJJr8JsaU91aN1RbYS2Qp/CMFb4P2FhAOJAAJl7Nh/iGB8ZC6oUnVKCC3jeHDlvADl2n0MGCW
	cRnjyZOROaPD4XA==
X-Google-Smtp-Source: AGHT+IEl4LyhQe/s6sODRKZEnrgQy4beINhuKEiojbasdi609xn/ZrOgSQYJxOcyAFvufBevBUX5f1bGPjyfew==
X-Received: from pjvf13.prod.google.com ([2002:a17:90a:da8d:b0:311:3fe:710a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35d2:b0:2ff:53a4:74f0 with SMTP id 98e67ed59e1d1-311108a11d1mr1464836a91.29.1748043035749;
 Fri, 23 May 2025 16:30:35 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:49 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-5-dmatlack@google.com>
Subject: [RFC PATCH 04/33] vfio: selftests: Test basic VFIO and IOMMUFD integration
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

From: Josh Hilke <jrhilke@google.com>

Add a vfio test suite which verifies that userspace can bind and unbind
devices, allocate I/O address space, and attach a device to an IOMMU
domain using the cdev + IOMMUfd VFIO interface.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_iommufd_setup_test.c  | 163 ++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 89313d63414f..175d6ed9ba6e 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS_EXTENDED += vfio_iommufd_setup_test
 TEST_GEN_PROGS_EXTENDED += vfio_pci_device_test
 include ../lib.mk
 include lib/libvfio.mk
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
new file mode 100644
index 000000000000..851032f79a31
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include <dirent.h>
+#include <fcntl.h>
+
+#include <uapi/linux/types.h>
+#include <linux/limits.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+#include <linux/iommufd.h>
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+static const char iommu_dev_path[] = "/dev/iommu";
+char cdev_path[PATH_MAX] = { '\0' };
+
+static void set_cdev_path(const char *bdf)
+{
+	char dir_path[PATH_MAX];
+	DIR *dir;
+	struct dirent *entry;
+
+	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
+
+	dir = opendir(dir_path);
+	assert(dir);
+
+	/* Find the file named "vfio<number>" */
+	while ((entry = readdir(dir)) != NULL) {
+		if (!strncmp("vfio", entry->d_name, 4)) {
+			snprintf(cdev_path, sizeof(cdev_path), "/dev/vfio/devices/%s",
+				 entry->d_name);
+			break;
+		}
+	}
+
+	assert(strlen(cdev_path) > 0);
+
+	closedir(dir);
+}
+
+static int vfio_device_bind_iommufd_ioctl(int cdev_fd, int iommufd)
+{
+	struct vfio_device_bind_iommufd bind_args = {
+		.argsz = sizeof(bind_args),
+		.iommufd = iommufd,
+	};
+
+	return ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind_args);
+}
+
+static int vfio_device_get_info_ioctl(int cdev_fd)
+{
+	struct vfio_device_info info_args = { .argsz = sizeof(info_args) };
+
+	return ioctl(cdev_fd, VFIO_DEVICE_GET_INFO, &info_args);
+}
+
+static int vfio_device_ioas_alloc_ioctl(int iommufd, struct iommu_ioas_alloc *alloc_args)
+{
+	*alloc_args = (struct iommu_ioas_alloc){
+		.size = sizeof(struct iommu_ioas_alloc),
+	};
+
+	return ioctl(iommufd, IOMMU_IOAS_ALLOC, alloc_args);
+}
+
+static int vfio_device_attach_iommufd_pt_ioctl(int cdev_fd, u32 pt_id)
+{
+	struct vfio_device_attach_iommufd_pt attach_args = {
+		.argsz = sizeof(attach_args),
+		.pt_id = pt_id,
+	};
+
+	return ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_args);
+}
+
+static int vfio_device_detach_iommufd_pt_ioctl(int cdev_fd)
+{
+	struct vfio_device_detach_iommufd_pt detach_args = {
+		.argsz = sizeof(detach_args),
+	};
+
+	return ioctl(cdev_fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_args);
+}
+
+FIXTURE(vfio_cdev)
+{
+	int cdev_fd;
+	int iommufd;
+};
+
+FIXTURE_SETUP(vfio_cdev)
+{
+	ASSERT_LE(0, (self->cdev_fd = open(cdev_path, O_RDWR, 0)));
+	ASSERT_LE(0, (self->iommufd = open(iommu_dev_path, O_RDWR, 0)));
+}
+
+FIXTURE_TEARDOWN(vfio_cdev)
+{
+	ASSERT_EQ(0, close(self->cdev_fd));
+	ASSERT_EQ(0, close(self->iommufd));
+}
+
+TEST_F(vfio_cdev, bind)
+{
+	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, self->iommufd));
+	ASSERT_EQ(0, vfio_device_get_info_ioctl(self->cdev_fd));
+}
+
+TEST_F(vfio_cdev, get_info_without_bind_fails)
+{
+	ASSERT_NE(0, vfio_device_get_info_ioctl(self->cdev_fd));
+}
+
+TEST_F(vfio_cdev, bind_bad_iommufd_fails)
+{
+	ASSERT_NE(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, -2));
+}
+
+TEST_F(vfio_cdev, repeated_bind_fails)
+{
+	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, self->iommufd));
+	ASSERT_NE(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, self->iommufd));
+}
+
+TEST_F(vfio_cdev, attach_detatch_pt)
+{
+	struct iommu_ioas_alloc alloc_args;
+
+	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, self->iommufd));
+	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd, &alloc_args));
+	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd, alloc_args.out_ioas_id));
+	ASSERT_EQ(0, vfio_device_detach_iommufd_pt_ioctl(self->cdev_fd));
+}
+
+TEST_F(vfio_cdev, attach_invalid_pt_fails)
+{
+	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, self->iommufd));
+	ASSERT_NE(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd, UINT32_MAX));
+}
+
+int main(int argc, char *argv[])
+{
+	char *bdf;
+
+	if (argc != 2) {
+		printf("Usage: %s bus:device:function\n", argv[0]);
+		return 1;
+	}
+
+	bdf = argv[1];
+	set_cdev_path(bdf);
+	printf("Using cdev device %s\n", cdev_path);
+
+	return test_harness_run(1, argv);
+}
-- 
2.49.0.1151.ga128411c76-goog


