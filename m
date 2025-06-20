Return-Path: <linux-kselftest+bounces-35497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E5AE2612
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092C05A5733
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387B246796;
	Fri, 20 Jun 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh3VKjTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD4244663
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461671; cv=none; b=PGxg5Sf9CwBDve0UYBPK9YP/Lg2X/yPohzhA94EBnOU6Zy+qxGywarXq0TpRrniomc9y6BJmmn59hlIbdVbe6CJ0PB7POEptu/iaZg/bqiKEh3JV1ngYBn1hgr3Bsw/wP9BQzQQjcXvff1G0j1LmmzHZmwwIG9mQA9kRKG6HN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461671; c=relaxed/simple;
	bh=zneQ0zQDUFxXaXef3JSJp7yA7Hwu65KOv4zuT7UTUTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XsZWrI40vq8B7qoOOYYW6U1ozbByIB4VUI6C7hkPagJ6PIh9TdLGvFwB7sHkDz3+bOLNJG3xefuEvPJEaR+v8EEqoMzULYSp1JXgF56D4I+HWEyzQGcOp66PRKr4Hf32cDlyZpRraQ6N8G0V/KsPR5G7SFGanGjewxRPcY+00mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh3VKjTc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235c897d378so19576455ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461667; x=1751066467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZJ+3VdcFbsMJd/byG0ecUHKPWNoRw2NVxE5pUxQNHs=;
        b=sh3VKjTcs2sE0S9JeuWMs6lDolQQGC/OnXZZF+7TFnVL1hPXWEuSvdfPLOR5CWC6i1
         bIsNl5Ul9Mch1t+retMfo99vAt9tuz1z5+XhzioOZYaQUUWbnt9K94+8GLB5YD+QO25E
         LWIOHFbS8fHbLIc/R/lk/p8hJ7pL6qEuMghxwjoe8kuXX3QSR3IPRxotFpjcAWC4Z+/f
         LTQA9lMmGTZ9ZlUhrHPLM8UFhPYr4DlqUZJvrkaQEI2RXXfK6FHzwgORwW/3sl6ie0cZ
         moBXfZRLk+UJKF2FXF3mBgTVX5AwyETfwo1q5Zqs9oGf+KtZG0tyKqvYl+NLVkQmEFh6
         tokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461667; x=1751066467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZJ+3VdcFbsMJd/byG0ecUHKPWNoRw2NVxE5pUxQNHs=;
        b=gZDvfyto2dkF/DUw4niGu3cqUBo0v3/67wLQioCd9xNDKO+P3Zt31z7QdTM/gqqIWH
         bchrqQ4z80Wn7vIX0PCzHbNAdb3NRXDcKSjeFQtFHJ6uM9Ix0xBQ8l9QDNTZ+2Baoafp
         7DrFICB6EDofycUn1sw2+M9yLWO5jiLsOh5ZwIpr7uHB8NqZxrIsgkgZS3rYNwNev2Ze
         RJVBEZbMftTlgIIQaDHs3ox/Af4bbS6KLQPf8u2tsQkokp33F9jaDhViXNQJavdHv2o0
         PAU5zTYdzEco58ffj1l/dL/sT7VGdT04hQgm7DOYPZCHwXEX1Hspd9rbyfoAvf1Nfqjq
         9TBg==
X-Forwarded-Encrypted: i=1; AJvYcCUERXw6F9B+CLlP24ND0RuLFLoDeT1b/JMhCmmuP+LKu76G84XkdCMtynuuBNT4YvH2w1LzkxDShnmQhJ49ZDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XUOSeaihDnrFukv5qcs08Qn+R2LzaBu0iskM036TCoYdzUh9
	QjOdrhCvWngUaV4cnnNEPbzjdaogoHjROHU/Kqm5vtjKTnCAJ0JJ0Ru87mBi2BMjvuKsT3akm/h
	d1eykVqrSBRIqZw==
X-Google-Smtp-Source: AGHT+IGmOBNnZY7AtB3vLIizA6nU2YNpiNcAOh/aMWMsKS2iFwjf0yyZ7h0PEwosClU1FLBX9s/R5zO5H6Y/wg==
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:311:485b:d057])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e88f:b0:234:bca7:292e with SMTP id d9443c01a7336-237d973b345mr62899955ad.14.1750461667589;
 Fri, 20 Jun 2025 16:21:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:01 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-4-dmatlack@google.com>
Subject: [PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
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
 .../selftests/vfio/vfio_pci_device_test.c     | 178 ++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index db3e4db1a6dd..828419537250 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS += vfio_pci_device_test
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
new file mode 100644
index 000000000000..6d3a33804be3
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -0,0 +1,178 @@
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
+static const char *device_bdf;
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
+FIXTURE_SETUP(vfio_pci_device_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_device_test)
+{
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
+FIXTURE_SETUP(vfio_pci_irq_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_irq_test)
+{
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
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.50.0.rc2.701.gf1e915cc24-goog


