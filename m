Return-Path: <linux-kselftest+bounces-33700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA88AC2C2E
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B345541DBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593421C19A;
	Fri, 23 May 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyX8VLEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959C21885D
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043038; cv=none; b=gRQgtctEHfmG5j6dDgc1lvD99srnD38yKOMn9TT5car65gGZrKPeBvAN28gRuYVzvOFEqKlJ/lR7xzC0jC7+39xP2IWeA/yJyJ33EiyrAgWNT9b8zWdye1Ci/fre+Fver3ABvEFq3XIoBa5eEr/d7NAff6nGMSTLZLJfzMGuN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043038; c=relaxed/simple;
	bh=khOouQ7K9HPY9V4q+fKz3JDmI5DVBtGLNNEPubkBK8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3wC2rOQOUI2kf24jwJOXm0SmTfmAJfVIDeKY5SVzMiQq0bSw8ua3Vjjn52UAi5IRJe6tiX6Dj7cAUqEWpv7qskGupI8c6K941bcDQ0Kfp1EqtY9hEqMadZ9kLdoZ/lztBUcxSdRkNfQQ9sdRW09260F2neQo41Lj7BaWfYoOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyX8VLEJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231de0e1ca3so3148105ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043034; x=1748647834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qB1hXH62G4kjHsebxbjU1ZcMGCGD2fFhQzb591JcmdA=;
        b=uyX8VLEJSlTHlEVPVfJaHJl+vegV3NRPf25D+GOI3x2hWcSyTmlgK3pfMLJPe0lukL
         t3IvWVnOdYTDZ5H8bsZwqYvZ5uU/1YPn93yW14xyOy6ALonSieS1XoiYK9fkilS/OjT0
         d5arlB7UE/r6tYhyCkCswaSpFgH+shw5fXzrymzS65rzgreDWKfcNj5npTMEL/BNluSN
         bf4lh/KaB0DxZbGgJd1zIaEK1y7I45vDHj9Ws+PZgBus685gU+Kj8xX+asOECBSz41ck
         /9auajFhm6m2qEMJ/XiUOYpB5mUZBPe7athw22tWmCvt4VP9UNDVbHaCyct+SwGPjrQj
         hosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043034; x=1748647834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB1hXH62G4kjHsebxbjU1ZcMGCGD2fFhQzb591JcmdA=;
        b=AawlILnF+s6TJzW7n6oBG9fYK2Btj6UygWuFDh+35q9tJXIMJ6Cv5hlI08FIVXfJv1
         AHK2Ka3QhDH8SOH3hcdFKOt9W52jEp0gijQntLWt36G0zbComcXNtDoNRaCzdWaYdHVq
         wJigME0UjBH75I/ELcJLATOIaJ+z57GTT71FlPmXMX8rWIsKrEwvdzhsd6zZVnzyg9Di
         1AmQbCH7+GcIg2nGdnuYECPjDiMEMJec/1RA6s9PUOgk+8FyXMR/BE7RaF+B7hu/+eGV
         u6gmEDin+tb9Yx+fdrcYzWoWlW/mudcvHbqRKCVo7aY5xzVIXM2K6Hzx5BY810Nu0CnJ
         rOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCcB90toWFzDL5zx/zs1+HW/Eaz7oEzmzh3CJtgfGzRneY3RPosGRPy7VirNZyyBwM8V5eqmvR6JnQdvZHoTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiW7/wLRN5hN2kCQEDGaS7f0i4Pi1q880wSlj5x5QB+GkDg2nv
	Z4nOi01dAqSZyp0l0DTP3cSAwcinWOyg91qVnN88HbhORCvsdbKDxLptIBiFAS4IJglnsv+OU4M
	SPX3r4M+Bs9fEsw==
X-Google-Smtp-Source: AGHT+IFd3EY9dZRO53rLPnjiCT79iMcz/a6Fw1kBGeR7CA4vrZULJpLBOvDx0Rak6gfiG4egPpnJjHwQyQV7ig==
X-Received: from pjbnr10.prod.google.com ([2002:a17:90b:240a:b0:311:7cc:2d4c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b30:b0:226:38ff:1d6a with SMTP id d9443c01a7336-23414f55b34mr15993465ad.7.1748043034529;
 Fri, 23 May 2025 16:30:34 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:48 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-4-dmatlack@google.com>
Subject: [RFC PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
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

Introduce a basic VFIO selftest called vfio_pci_device_test to
demonstrate the functionality of the VFIO selftest library and provide
some test coverage of basic VFIO operations, including:

 - Mapping and unmapping DMA
 - Mapping and unmapping BARs
 - Enabling, triggering, and disabling MSI and MSI-x
 - Reading and writing to PCI config space

This test should work with most PCI devices, as long as they are bound
to vfio-pci.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_device_test.c     | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index f8933dcdc8e1..89313d63414f 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS_EXTENDED += vfio_pci_device_test
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
new file mode 100644
index 000000000000..7906b2684dd3
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+#include <stdlib.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/limits.h>
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+const char *device_bdf;
+
+/*
+ * Limit the number of MSIs enabled/disabled by the test regardless of the
+ * number of MSIs the device itself supports, e.g. to avoid hitting IRTE limits.
+ */
+#define MAX_TEST_MSI 16U
+
+FIXTURE(vfio_pci_device_test) {
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_pci_device_test) {
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_device_test) {
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_pci_device_test, dma_map_unmap)
+{
+	const u64 size = SZ_2M;
+	const u64 iova = SZ_4G;
+	void *mem;
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(mem, MAP_FAILED);
+
+	vfio_pci_dma_map(self->device, iova, size, mem);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_unmap(self->device, iova, size);
+
+	ASSERT_TRUE(!munmap(mem, SZ_2M));
+}
+
+#define read_pci_id_from_sysfs(_file) ({							\
+	char __sysfs_path[PATH_MAX];								\
+	char __buf[32];										\
+	int __fd;										\
+												\
+	snprintf(__sysfs_path, PATH_MAX, "/sys/bus/pci/devices/%s/%s", device_bdf, _file);	\
+	ASSERT_GT((__fd = open(__sysfs_path, O_RDONLY)), 0);					\
+	ASSERT_GT(read(__fd, __buf, ARRAY_SIZE(__buf)), 0);					\
+	ASSERT_EQ(0, close(__fd));								\
+	(u16)strtoul(__buf, NULL, 0);								\
+})
+
+TEST_F(vfio_pci_device_test, config_space_read_write)
+{
+	u16 vendor, device;
+	u16 command;
+
+	/* Check that Vendor and Device match what the kernel reports. */
+	vendor = read_pci_id_from_sysfs("vendor");
+	device = read_pci_id_from_sysfs("device");
+
+	ASSERT_EQ(vendor, vfio_pci_config_readw(self->device, PCI_VENDOR_ID));
+	ASSERT_EQ(device, vfio_pci_config_readw(self->device, PCI_DEVICE_ID));
+
+	printf("Vendor: %04x, Device: %04x\n", vendor, device);
+
+	command = vfio_pci_config_readw(self->device, PCI_COMMAND);
+	ASSERT_FALSE(command & PCI_COMMAND_MASTER);
+
+	vfio_pci_config_writew(self->device, PCI_COMMAND, command | PCI_COMMAND_MASTER);
+	command = vfio_pci_config_readw(self->device, PCI_COMMAND);
+	ASSERT_TRUE(command & PCI_COMMAND_MASTER);
+	printf("Enabled Bus Mastering (command: %04x)\n", command);
+
+	vfio_pci_config_writew(self->device, PCI_COMMAND, command & ~PCI_COMMAND_MASTER);
+	command = vfio_pci_config_readw(self->device, PCI_COMMAND);
+	ASSERT_FALSE(command & PCI_COMMAND_MASTER);
+	printf("Disabled Bus Mastering (command: %04x)\n", command);
+}
+
+TEST_F(vfio_pci_device_test, validate_bars)
+{
+	struct vfio_pci_bar *bar;
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		bar = &self->device->bars[i];
+
+		if (!(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP)) {
+			printf("BAR %d does not support mmap()\n", i);
+			ASSERT_EQ(NULL, bar->vaddr);
+			continue;
+		}
+
+		/*
+		 * BARs that support mmap() should be automatically mapped by
+		 * vfio_pci_device_init().
+		 */
+		ASSERT_NE(NULL, bar->vaddr);
+		ASSERT_NE(0, bar->info.size);
+		printf("BAR %d mapped at %p (size 0x%llx)\n", i, bar->vaddr, bar->info.size);
+	}
+}
+
+FIXTURE(vfio_pci_irq_test) {
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_pci_irq_test) {
+	int irq_index;
+};
+
+FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msi) {
+	.irq_index = VFIO_PCI_MSI_IRQ_INDEX,
+};
+
+FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
+	.irq_index = VFIO_PCI_MSIX_IRQ_INDEX,
+};
+
+FIXTURE_SETUP(vfio_pci_irq_test) {
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_irq_test) {
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_pci_irq_test, enable_trigger_disable)
+{
+	bool msix = variant->irq_index == VFIO_PCI_MSIX_IRQ_INDEX;
+	u32 count;
+	u64 value;
+	int i;
+
+	if (msix)
+		count = self->device->msix_info.count;
+	else
+		count = self->device->msi_info.count;
+
+	count = min(count, MAX_TEST_MSI);
+
+	if (!count)
+		SKIP(return, "MSI%s: not supported\n", msix ? "-x" : "");
+
+	vfio_pci_irq_enable(self->device, variant->irq_index, 0, count);
+	printf("MSI%s: enabled %d interrupts\n", msix ? "-x" : "", count);
+
+	for (i = 0; i < count; i++) {
+		vfio_pci_irq_trigger(self->device, variant->irq_index, i);
+		ASSERT_EQ(8, read(self->device->msi_eventfds[i], &value, 8));
+		ASSERT_EQ(1, value);
+	}
+
+	vfio_pci_irq_disable(self->device, variant->irq_index);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s segment:bus:device.function\n", argv[0]);
+		return KSFT_FAIL;
+	}
+
+	device_bdf = argv[1];
+
+	return test_harness_run(1, argv);
+}
-- 
2.49.0.1151.ga128411c76-goog


