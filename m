Return-Path: <linux-kselftest+bounces-33716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1260AC2C4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D76541EB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6B223324;
	Fri, 23 May 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DimUTrk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F021C19A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043060; cv=none; b=N7UDWj2DX9rfUGOIIQwQ3AIcrKJmVs6pdb/oIDFFmtpjlykqzhpW4KT4svif53PbIei80hWm8YKckdiBvVBB9YgAvU3F3Z/KaWWPev2SSeQeHC3IZjZdrijOyuxNZ1XWtzmmzm6nvRDeUJlrGtGuJFX1zaxpD1DWfT/gJop6MiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043060; c=relaxed/simple;
	bh=g+E8JXWKncGSLKydmpWC/uNckMj76ox67ykM4jULD04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WVJZo26as3DRQHsbDNy8/M0tBZo7PgwIlRwz8RpMEaTYBr9OeciM3dFdcEeXYQsUiW/l8HWE4nTAbAVaAH7eQm16Uy23gXbVLjTo0gzgD1o3WhSoMJUlcrP82KkGukKKnI0sO0V3//XVzGYHzNIIXZZV+1+Mq8C5VGhwvCW8Csc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DimUTrk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e896e116fso392666a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043058; x=1748647858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M56wBrhTere3v95HCeXBYP3UY5DColz6PlhgTZ75vTg=;
        b=4DimUTrkhJmlb3eb4H3DiBwrMTmQnZ88F1Q/eqL+TDdabvh7hkAI199JX8HpSswgUL
         jrHVjvXHYhusjrOXb4r7Bk1B8bWVBrPs9tYp8VkcG1hMET4yLzvzJxa4bmpcsGqJm8RL
         SNgryQULra6BWXnsDYnWfTtp/PsvcJsD0zKXMmafh6K/mT8o2moTvYofGBbfr7AYukcq
         qVQBdIRxKV4NY74RSWE8BU8ZZ2NbaOxoDsNy3XULXPLD32LALftcbMkLaRYkVu1J5WdS
         vIsJaAFHC3gfuMdFKFYetilP+5vJqf/92RA76Mqg6ru6CB9iHeROvZPt5cfeiikvt3o5
         soUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043058; x=1748647858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M56wBrhTere3v95HCeXBYP3UY5DColz6PlhgTZ75vTg=;
        b=PLmar0K4B1f5teTgvER6HaR4jdtotB4b/KtF0rjFKogMuv5sSTLSWsBGPsTUhYfCJZ
         9OkAw5Cu/DcZ2asi18PiaFv6ZELV54MJGyupnDx0MR4lqq4oOzXOhIRVCh7gQTDBmzG9
         3M8+PlLXddKyXD5eK9VS/gnT21+KvBL/nIATld1qJOuAAsX07ph2YoCm9tPv6b3dlDcL
         PVtzl4Q0OE8HJ13/U7A4QsiMlAXRDKkwTDLKWAQ+bHHMEkTfaZi/GxZrckSqX+vD9FUO
         rd9e6lrQZcheoSeVGONl0HeUpq5tmr256Ef1vBrY3O0IPDAITKO065JKegvIPAh4mbKX
         bNBA==
X-Forwarded-Encrypted: i=1; AJvYcCXfAzsE2D7EHr5/agfyb8ngy3wtqG0CdYzQe4BpexqvIclskKrLJueXS2vKe6USi+mJmPYVui4zcF4MCReJOFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1Nnvj60JOm8PDhSGk+PjCr1P9bP4qUVCzjw9dPeKtg5smdZJ
	+XhXi2jBoIqhQBB33HOncZmdj0aYAmIC9Txm2pqEEf9BPxEof9tSh5lt5FzWGBb8fh0yCwZ0pvI
	3pCX/EpPYp/W2Fg==
X-Google-Smtp-Source: AGHT+IEv8h8XeAJL1DmmIRW0ElKkUDYQycR8zF4ioQ5lpDDrsb/RHwypOkptwRczYrb10lureb4Y0tVgvEmdqA==
X-Received: from pji12.prod.google.com ([2002:a17:90b:3fcc:b0:2f5:63a:4513])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3bd0:b0:30e:823f:ef21 with SMTP id 98e67ed59e1d1-31110d933e0mr1170568a91.32.1748043058586;
 Fri, 23 May 2025 16:30:58 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:05 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-21-dmatlack@google.com>
Subject: [RFC PATCH 20/33] vfio: sefltests: Add vfio_pci_driver_test
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

Add a new selftest that tests all driver operations. This test serves
both as a demonstration of the driver framework, and also as a
correctness test for future drivers.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_driver_test.c     | 239 ++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2cc97176c6be..21fb1809035e 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -2,6 +2,7 @@ CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS_EXTENDED += vfio_dma_mapping_test
 TEST_GEN_PROGS_EXTENDED += vfio_iommufd_setup_test
 TEST_GEN_PROGS_EXTENDED += vfio_pci_device_test
+TEST_GEN_PROGS_EXTENDED += vfio_pci_driver_test
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
new file mode 100644
index 000000000000..5d14d892b796
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+#include <linux/io.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+const char *device_bdf;
+
+#define ASSERT_NO_MSI(_eventfd) do {			\
+	u64 __value;					\
+							\
+	ASSERT_EQ(-1, read(_eventfd, &__value, 8));	\
+	ASSERT_EQ(EAGAIN, errno);			\
+} while (0)
+
+static void region_setup(struct vfio_pci_device *device,
+			 struct vfio_dma_region *region,
+			 iova_t iova, u64 size)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	void *vaddr;
+
+	vaddr = mmap(NULL, size, prot, flags, -1, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	region->vaddr = vaddr;
+	region->iova = iova;
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
+FIXTURE_SETUP(vfio_pci_driver_test) {
+	struct vfio_pci_driver *driver;
+
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+
+	driver = &self->device->driver;
+
+	region_setup(self->device, &self->memcpy_region, SZ_1G, SZ_1G);
+	region_setup(self->device, &driver->region, SZ_4G, SZ_2M);
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
+FIXTURE_TEARDOWN(vfio_pci_driver_test) {
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
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s segment:bus:device.function\n", argv[0]);
+		return KSFT_FAIL;
+	}
+
+	device_bdf = argv[1];
+
+	device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	if (!device->driver.ops) {
+		fprintf(stderr, "No driver found for device %s\n", device_bdf);
+		return KSFT_SKIP;
+	}
+	vfio_pci_device_cleanup(device);
+
+	return test_harness_run(1, argv);
+}
-- 
2.49.0.1151.ga128411c76-goog


