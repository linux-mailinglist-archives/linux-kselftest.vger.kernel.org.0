Return-Path: <linux-kselftest+bounces-39744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC1B3247A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B605BAC7C04
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931534DCEC;
	Fri, 22 Aug 2025 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSFNsQHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308F343202
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897989; cv=none; b=sApbbZHhk9AJDEzSOjAW4FrToa607mJZcBQb3cNlsr9JRAR7HSf5NqlMUHr9/S3SHTMnLMtAsVm8VmEgAzVv+VIGl5UTQpR3U6xoBcS2ft4tg/jUX4KBTs+2RttPKBD7aL3jd6KX1jsU4b0oFCRslxchuJYGej41dCysxETDyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897989; c=relaxed/simple;
	bh=ZwqIBuxnUbbSXMWKYx+eOkpmuPlrR6N5SaGVa7zhmtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TaXDL+TYE05qD1SgC3QoCsKL7JcQJCsekjDvjSTnZFBTMwpt/O8Qk4N9g7GZu/TnMl5uOl9o5XLK7NKoGRuVD+nnyYivBXMk50+dbRYtGavvOi6Rkdj6jyUjHYq2H66G6FMzXMIN5yy29SdFfaWt+mu6axXpEBZDFiWmVHWxTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSFNsQHO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32515a033a6so1216737a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897988; x=1756502788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7b1IhfbyTmXGk1aJOxUnMN9cinqskpX5rZ09b/0jHAc=;
        b=oSFNsQHOYqjLmb/6bLy4hcCMbuDgsFeuLFUl021MlKySJWEI+c+8fUvyx/6Rd7J3OO
         a8qSO46HG9Lju5NzSBBMQi2Ni6kc9Fjgim739PbY6CNrxjHMx/z73B3rPUxlqgrxna1E
         XtJX365pkmtC6iM/ZaGoNtClaU3fi9XBsHiNzFiUe1CQqormWduz7PLSlZOg33uha2wX
         D9krswVnoehEnR5SER/oyNTNFiHCWZrkFLow+9IXPfDLxcWKhugOsSdMgMCONws3fzci
         2dSTe1jOv1cjyZFCIOAXefbweF3o+wVRNhWK6T7pD/7cYqeErtZEr0WWFuclTgptxLp0
         rn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897988; x=1756502788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7b1IhfbyTmXGk1aJOxUnMN9cinqskpX5rZ09b/0jHAc=;
        b=DyYbkuSfy/ov+LHUrpDehTdjY8BfhQ3p0bSglPufDYTWSxqrqbUG31qwaIbaAfV7o8
         xIZwpi5nCn6HhjJXOBKJsjafyIHGRepOsmK21j6aI6TZ2d5LvRttL12VEryC1VC2dZyM
         NHIRmQIsOi5cq7HW5FA8l5paXU+CNBZor4ak80JBAqRoDnfF7l4wt6eUjLXXBoKU38as
         5hk2vQGOsldUFqNIxOEJDfq2jwh9ZNMTXXS1lOFWX2X0Bn3T5f18RkPsCSgnWf7JFlT2
         0FIM8lu5NjBxUKPaGpZyc7MgxGn9upjTnH/icadfis+zisICW/zmmloleis+ULj2f4bJ
         gkaA==
X-Forwarded-Encrypted: i=1; AJvYcCWf9sAtww7GLHluexzW61EIHmtc9gEhLCH/TxehXobAWP193AqeDM+GspgoHDPLxAjcoVy8dhgMoCoAAlKo55E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfKzqYXH6HLPJQbBPvWhkEx9g9jMqnl45k1bPIuQ9T+tYJToA
	zo8oKhdUwJoHxh1S22A0VIni6tyPPaErDYZ6ZTSJyoi68McDUw0XKpys+D/ugIOfKW55SDB9N8N
	iTMSNklXtjIlihQ==
X-Google-Smtp-Source: AGHT+IGbsYg66I/uZ8JkjJf8/BFPCJAdE4nKM2aSlSYyjwOF5OOM5fcOqshtqgoHG3rEYvYPjI7SqTlCB4eALw==
X-Received: from pjka22.prod.google.com ([2002:a17:90a:6d96:b0:325:3ada:baa0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c85:b0:323:28ac:4594 with SMTP id 98e67ed59e1d1-32515e2e438mr5165004a91.5.1755897987553;
 Fri, 22 Aug 2025 14:26:27 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:00 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-14-dmatlack@google.com>
Subject: [PATCH v2 13/30] vfio: sefltests: Add vfio_pci_driver_test
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

Add a new selftest that tests all driver operations. This test serves
both as a demonstration of the driver framework, and also as a
correctness test for future drivers.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_driver_test.c     | 233 ++++++++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 05c5a585cca6..ee09c027ade5 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -2,6 +2,7 @@ CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
+TEST_GEN_PROGS += vfio_pci_driver_test
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
new file mode 100644
index 000000000000..97ed0ff4636d
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+#define ASSERT_NO_MSI(_eventfd) do {			\
+	u64 __value;					\
+							\
+	ASSERT_EQ(-1, read(_eventfd, &__value, 8));	\
+	ASSERT_EQ(EAGAIN, errno);			\
+} while (0)
+
+static void region_setup(struct vfio_pci_device *device,
+			 struct vfio_dma_region *region, u64 size)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	void *vaddr;
+
+	vaddr = mmap(NULL, size, prot, flags, -1, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	region->vaddr = vaddr;
+	region->iova = (u64)vaddr;
+	region->size = size;
+
+	vfio_pci_dma_map(device, region);
+}
+
+static void region_teardown(struct vfio_pci_device *device,
+			    struct vfio_dma_region *region)
+{
+	vfio_pci_dma_unmap(device, region);
+	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
+}
+
+FIXTURE(vfio_pci_driver_test) {
+	struct vfio_pci_device *device;
+	struct vfio_dma_region memcpy_region;
+	void *vaddr;
+	int msi_fd;
+
+	u64 size;
+	void *src;
+	void *dst;
+	iova_t src_iova;
+	iova_t dst_iova;
+	iova_t unmapped_iova;
+};
+
+FIXTURE_SETUP(vfio_pci_driver_test)
+{
+	struct vfio_pci_driver *driver;
+
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+
+	driver = &self->device->driver;
+
+	region_setup(self->device, &self->memcpy_region, SZ_1G);
+	region_setup(self->device, &driver->region, SZ_2M);
+
+	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
+	self->unmapped_iova = 8UL * SZ_1G;
+
+	vfio_pci_driver_init(self->device);
+	self->msi_fd = self->device->msi_eventfds[driver->msi];
+
+	/*
+	 * Use the maximum size supported by the device for memcpy operations,
+	 * slimmed down to fit into the memcpy region (divided by 2 so src and
+	 * dst regions do not overlap).
+	 */
+	self->size = self->device->driver.max_memcpy_size;
+	self->size = min(self->size, self->memcpy_region.size / 2);
+
+	self->src = self->memcpy_region.vaddr;
+	self->dst = self->src + self->size;
+
+	self->src_iova = to_iova(self->device, self->src);
+	self->dst_iova = to_iova(self->device, self->dst);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_driver_test)
+{
+	struct vfio_pci_driver *driver = &self->device->driver;
+
+	vfio_pci_driver_remove(self->device);
+
+	region_teardown(self->device, &self->memcpy_region);
+	region_teardown(self->device, &driver->region);
+
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_pci_driver_test, init_remove)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		vfio_pci_driver_remove(self->device);
+		vfio_pci_driver_init(self->device);
+	}
+}
+
+TEST_F(vfio_pci_driver_test, memcpy_success)
+{
+	fcntl_set_nonblock(self->msi_fd);
+
+	memset(self->src, 'x', self->size);
+	memset(self->dst, 'y', self->size);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->device,
+					    self->src_iova,
+					    self->dst_iova,
+					    self->size));
+
+	ASSERT_EQ(0, memcmp(self->src, self->dst, self->size));
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+TEST_F(vfio_pci_driver_test, memcpy_from_unmapped_iova)
+{
+	fcntl_set_nonblock(self->msi_fd);
+
+	/*
+	 * Ignore the return value since not all devices will detect and report
+	 * accesses to unmapped IOVAs as errors.
+	 */
+	vfio_pci_driver_memcpy(self->device, self->unmapped_iova,
+			       self->dst_iova, self->size);
+
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
+{
+	fcntl_set_nonblock(self->msi_fd);
+
+	/*
+	 * Ignore the return value since not all devices will detect and report
+	 * accesses to unmapped IOVAs as errors.
+	 */
+	vfio_pci_driver_memcpy(self->device, self->src_iova,
+			       self->unmapped_iova, self->size);
+
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+TEST_F(vfio_pci_driver_test, send_msi)
+{
+	u64 value;
+
+	vfio_pci_driver_send_msi(self->device);
+	ASSERT_EQ(8, read(self->msi_fd, &value, 8));
+	ASSERT_EQ(1, value);
+}
+
+TEST_F(vfio_pci_driver_test, mix_and_match)
+{
+	u64 value;
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		memset(self->src, 'x', self->size);
+		memset(self->dst, 'y', self->size);
+
+		ASSERT_EQ(0, vfio_pci_driver_memcpy(self->device,
+						    self->src_iova,
+						    self->dst_iova,
+						    self->size));
+
+		ASSERT_EQ(0, memcmp(self->src, self->dst, self->size));
+
+		vfio_pci_driver_memcpy(self->device,
+				       self->unmapped_iova,
+				       self->dst_iova,
+				       self->size);
+
+		vfio_pci_driver_send_msi(self->device);
+		ASSERT_EQ(8, read(self->msi_fd, &value, 8));
+		ASSERT_EQ(1, value);
+	}
+}
+
+TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
+{
+	struct vfio_pci_driver *driver = &self->device->driver;
+	u64 total_size;
+	u64 count;
+
+	fcntl_set_nonblock(self->msi_fd);
+
+	/*
+	 * Perform up to 250GiB worth of DMA reads and writes across several
+	 * memcpy operations. Some devices can support even more but the test
+	 * will take too long.
+	 */
+	total_size = 250UL * SZ_1G;
+	count = min(total_size / self->size, driver->max_memcpy_count);
+
+	printf("Kicking off %lu memcpys of size 0x%lx\n", count, self->size);
+	vfio_pci_driver_memcpy_start(self->device,
+				     self->src_iova,
+				     self->dst_iova,
+				     self->size, count);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	struct vfio_pci_device *device;
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	if (!device->driver.ops) {
+		fprintf(stderr, "No driver found for device %s\n", device_bdf);
+		return KSFT_SKIP;
+	}
+	vfio_pci_device_cleanup(device);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


