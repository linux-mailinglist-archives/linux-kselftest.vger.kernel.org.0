Return-Path: <linux-kselftest+bounces-39735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11925B3242D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750C9B66235
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3A341669;
	Fri, 22 Aug 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgQ/q5KY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9133EB19
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897976; cv=none; b=qCjjuhaJ2vP8hDMPRf2o+OBnLJLSCreuPpNHmpMeWIMQyrWEKuingw7yayjcaQMwLASQTIUbUSgxsq8W9iboDuH1qMCDJznlGq0X32wfSc3VzaU2iD6eZTaKg7Gz1IfJ/jSjLSyarIMQQqJsT6JrLlaQlgaZfh+tKN8lPntFCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897976; c=relaxed/simple;
	bh=/icx0Lzvu4c63npzQWbVLS2UL+SrQAsPbcWYzbXgzeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OncRL2Ae/W+UFl4R0Jd2a/0rUHtECM2Fgk0Pon7rGyHBdaCDDvg6yMTZOGcOuaByijmlCnyQ4eOMnWtZgvALai7bvwc/NwN15XULjvPAkPunKwu+i7y4wCaGgYy2lCHJiCxw3unUTxArgNoUad840iGYyqZe3vNyNQTjNfZWK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgQ/q5KY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32515a033b6so1615240a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897974; x=1756502774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc6JMNbYo71jsaFP9ZHhUFTwChIXe2ln9UQpwNGcyE4=;
        b=zgQ/q5KYOSto9GcOJt1cYptMzfSPkGbDGEIohn+t7ufepLVOZyEVr/DFRfAkWsy3l+
         mpFJR8scN9D5DF/yyjENx1l8k6A+UAT3LKufxd1Cqf7Qn0BSjguaugrvmDFqmTjE6g6J
         9J6tW8eA87mQQAzwLoot0/PGP7EDiWvU4wdHwjA1EIlXlaZR281rfZoLy9sUNYd/A3by
         LiObv1toDSKao038XVZ3hyMMAh/BjhmvAoKl9Us6IGijHMY8KnImYHZSXUusTC1shT/j
         /pz+RiT28w3wmDIIwXjhXEuIwiGzi1y1bGOX5nRLjm2iRYkwK2nWIlJ2ybCSiYjP6aDe
         irQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897974; x=1756502774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc6JMNbYo71jsaFP9ZHhUFTwChIXe2ln9UQpwNGcyE4=;
        b=DEo9tW4306qK9WVzWmlcpWNzK5qZAVuCjq8TWrQWa9InCeUafqJgTyH9pO3MGzUtV0
         lSkKhuQyFzpSzXfIGH6Qlao0fU1Qm0z87awDtQrwxlpOb8fUPDwWkg6nhjGOZdzfXnS6
         +3Otd8e3PdrHX0wCG7sQP7IcHA4O9oEQWdSat/MoDFP/koCywLAPLx8zKxPvy6+Lku8G
         d5FzxBMnt3KF1bKGHkH+UvEeSqEeAGzGQz7R2GeMxGc8G6IiaJf2MEjiUmGXdda/IfET
         NQuDLNICaOXKJ9Gbo1h2RBzGfZOOuptKAHICyOU43N6eNfN/y4qHUJA6EbRW/VPMfxAR
         scAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUmAGk5bCx5mctEX1gOkH4YM9iD0WV+1iyPFpxYurUWjpAmMvozb4igP32yMC9w1Q/jvN+MGnkH4sNWYGANa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pRnId+rd8gfm6bpmBMNu+YBD56+fI3LzmU4EO2bnc7OBvSrz
	Gj6dG3ro2xNfOBRsqhY0MFhwSeI9v12NqYvf4y48YzDhgYSwcOhkBcuEYtcNM7krciNHdjYd0mh
	8W2DuBWZLKqx6yw==
X-Google-Smtp-Source: AGHT+IGNcp3Tx+TypNa2B9vyvzN9T5DfQMbRJSC9jxZluE+p+/4K83Zo6W2QteLvhQ/2HROiQpgG6hG3c49eow==
X-Received: from pjad16.prod.google.com ([2002:a17:90a:1110:b0:325:4747:a99b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2ccd:b0:321:4760:c65a with SMTP id 98e67ed59e1d1-32517d1e054mr5817271a91.27.1755897974315;
 Fri, 22 Aug 2025 14:26:14 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:51 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-5-dmatlack@google.com>
Subject: [PATCH v2 04/30] vfio: selftests: Test basic VFIO and IOMMUFD integration
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

From: Josh Hilke <jrhilke@google.com>

Add a vfio test suite which verifies that userspace can bind and unbind
devices, allocate I/O address space, and attach a device to an IOMMU
domain using the cdev + IOMMUfd VFIO interface.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_iommufd_setup_test.c  | 157 ++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 828419537250..e4a5d6eadff3 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 include ../lib.mk
 include lib/libvfio.mk
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
new file mode 100644
index 000000000000..f45335d9260f
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -0,0 +1,157 @@
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
+#include <vfio_util.h>
+#include "../kselftest_harness.h"
+
+static const char iommu_dev_path[] = "/dev/iommu";
+static char cdev_path[PATH_MAX] = { '\0' };
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
+FIXTURE(vfio_cdev) {
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
+	const char *device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	set_cdev_path(device_bdf);
+	printf("Using cdev device %s\n", cdev_path);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


