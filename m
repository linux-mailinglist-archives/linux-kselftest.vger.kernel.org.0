Return-Path: <linux-kselftest+bounces-35514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA75AE2641
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324311C20F92
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC60253949;
	Fri, 20 Jun 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQTOBhN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76382253924
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461695; cv=none; b=jPrLKiXklbMRpTEstAS/DvVIXn9IFj3Iy3kYo4XOJHWGA6/h9u/CQJzItNhqyzNC1FsRq/NydD/WI2TorM9nRE10RHJDnWQiw7KhR/tHZFjRztiU7XSo5dk71ezwCtsh8GBGGbiBQd6XTN+bzxlDtsGpkDSQxjdpvH1WzyGflfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461695; c=relaxed/simple;
	bh=2CQuhrOm4BivOh+yzUa5rmVEzeCLRjW2nWpfks5i/UI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a6gI4TOs8DQNTy8x0Ob81hyDM3v57tKaUUPS/Y8Nx3p/dUwivMFQXH4nNouV0hhH4/WCT9I9foumexxhd7xrcZSuU5LxG6qh178JCDsvcpCExyddJRl7tcJVCcp+/jdUH49MR+mAQguv1FkIqt78ciLfhwFgx2QFItVcfSGVqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQTOBhN9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31ff607527so369902a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461693; x=1751066493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBQG+dKbWGlS5j0XYYT/MXPGVVjIHTntujvdtmjCnE4=;
        b=AQTOBhN9QO9XoYzeM3fgDu9THtH0i5tbMASU1ivu2AMrJN1bh3GNfeLLTPxek9NdPy
         hVYNdLVtl1d4nDrS2gNBybjuRLTmFdUiQQipCkZ0HAvgdiTSZTBl6UyRD8Uwnzq0v6w0
         rc6hPeh4h6oosPFyhhMJQ5+PZjivxTiRLRFezqCJDjXwiQM3yyVo1MWR01yH2pdc35Li
         erKGhm+zV02coyQifkiHesMx3FQYwlw9bnw2Aik97rzL5+XAsSSRy6v9MOm1osIShGr8
         wsSdbP8+BnHwM5+i+mOGh8/PMgEmEW7V+eNURvSzG7wHrLuCN97pxol1JWFE8iapk4YU
         wV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461693; x=1751066493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBQG+dKbWGlS5j0XYYT/MXPGVVjIHTntujvdtmjCnE4=;
        b=KjZf2hqokVBh8U6DqcOXv4ymLkjijFlDCvxhV+ZcwTLdsLhnaGLwsploHLOxJWBS8Q
         NrsrO5clgoH1tqak22Kl3Tn9BKt27ufJoFSZcZjfEGYJ7B3xZwdMnHH83gtIb1J+iYIR
         Lo7f+DZRYrQ0nvq0L7cS3hkgJHj1cfJ9etozUQIo/AlTmXuOI2gRINCj1oBjyZX42NrA
         kBnIVEmSi4JKkdWB7ikOXTyrlSW8m8O2bXpfjkuxGszNhmgt3ldmUDOoQREa5o+gI+WB
         oRjkG9HnfbqgH9sdFO0AJ7VYmcTORXnsx0cIqRJ3iDJmhf0o4GOGPNMLL1BbTvWoyGXi
         VqvA==
X-Forwarded-Encrypted: i=1; AJvYcCVgu5AJULpxb7Ssqhsv4Vh1GpWp6Qy913hl/XGvnHMTbim9wFgIxo0RxspkBVaYXo88n2flx4pk16sJ9EurQuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyufuid81iJcqbZKpu0YX1tc4X9F73NHzMwEsC59UQW2f20vagw
	Cs9RWhnKZAALVxPVlcAQIkT9pSBaTzirXMlWo6S+TmLWns21CK/CebUC11L0Bi4oP7osY4ukhSA
	br75ZzK66pizDlA==
X-Google-Smtp-Source: AGHT+IGnQUDhu/YUzB8Qtw8QMMJyXxJ2fh9G5agJPAEvZIgK8qWtBdqOv59++3kFAtcdDXnpxeDiv+WabUm3Aw==
X-Received: from pgbcm4.prod.google.com ([2002:a05:6a02:a04:b0:b31:b299:36a5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:72a7:b0:215:ead1:b867 with SMTP id adf61e73a8af0-22026d8c81bmr7887830637.14.1750461692906;
 Fri, 20 Jun 2025 16:21:32 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:18 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-21-dmatlack@google.com>
Subject: [PATCH 20/33] vfio: selftests: Add driver for Intel CBDMA
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

Add a driver for the Intel CBDMA device. This driver is based on and
named after the Linux driver for this device (drivers/dma/ioat/) and
also based on previous work from Peter Shier <pshier@google.com>.

The driver aims to be as simple as possible. It uses a single descriptor
to issue DMA operations, and only supports the copy operation. For "DMA
storms", the driver kicks off the maximum number of maximum-sized DMA
operations. On Skylake server parts, this was 2^16-1 copies of size 2M
and lasts about 15 seconds.

Create symlinks to drivers/dma/ioat/{hw.h,registers.h} to get access to
various macros (e.g. IOAT_CHANCMD_RESET) and struct ioat_dma_descriptor.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/drivers/ioat/hw.h      |   1 +
 .../selftests/vfio/lib/drivers/ioat/ioat.c    | 235 ++++++++++++++++++
 .../vfio/lib/drivers/ioat/registers.h         |   1 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   7 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |  10 +-
 5 files changed, 253 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/ioat/registers.h

diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/hw.h b/tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
new file mode 120000
index 000000000000..8ab52ddd4458
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
@@ -0,0 +1 @@
+../../../../../../../drivers/dma/ioat/hw.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
new file mode 100644
index 000000000000..c3b91d9b1f59
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdint.h>
+#include <unistd.h>
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/pci_ids.h>
+#include <linux/sizes.h>
+
+#include <vfio_util.h>
+
+#include "hw.h"
+#include "registers.h"
+
+#define IOAT_DMACOUNT_MAX UINT16_MAX
+
+struct ioat_state {
+	/* Single descriptor used to issue DMA memcpy operations */
+	struct ioat_dma_descriptor desc;
+
+	/* Copy buffers used by ioat_send_msi() to generate an interrupt. */
+	u64 send_msi_src;
+	u64 send_msi_dst;
+};
+
+static inline struct ioat_state *to_ioat_state(struct vfio_pci_device *device)
+{
+	return device->driver.region.vaddr;
+}
+
+static inline void *ioat_channel_registers(struct vfio_pci_device *device)
+{
+	return device->bars[0].vaddr + IOAT_CHANNEL_MMIO_SIZE;
+}
+
+static int ioat_probe(struct vfio_pci_device *device)
+{
+	u8 version;
+	int r;
+
+	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
+				   PCI_DEVICE_ID_INTEL_IOAT_SKX))
+		return -EINVAL;
+
+	VFIO_ASSERT_NOT_NULL(device->bars[0].vaddr);
+
+	version = readb(device->bars[0].vaddr + IOAT_VER_OFFSET);
+	switch (version) {
+	case IOAT_VER_3_2:
+	case IOAT_VER_3_3:
+		r = 0;
+		break;
+	default:
+		printf("ioat: Unsupported version: 0x%x\n", version);
+		r = -EINVAL;
+	}
+	return r;
+}
+
+static u64 ioat_channel_status(void *bar)
+{
+	return readq(bar + IOAT_CHANSTS_OFFSET) & IOAT_CHANSTS_STATUS;
+}
+
+static void ioat_clear_errors(struct vfio_pci_device *device)
+{
+	void *registers = ioat_channel_registers(device);
+	u32 errors;
+
+	errors = vfio_pci_config_readl(device, IOAT_PCI_CHANERR_INT_OFFSET);
+	vfio_pci_config_writel(device, IOAT_PCI_CHANERR_INT_OFFSET, errors);
+
+	errors = vfio_pci_config_readl(device, IOAT_PCI_DMAUNCERRSTS_OFFSET);
+	vfio_pci_config_writel(device, IOAT_PCI_CHANERR_INT_OFFSET, errors);
+
+	errors = readl(registers + IOAT_CHANERR_OFFSET);
+	writel(errors, registers + IOAT_CHANERR_OFFSET);
+}
+
+static void ioat_reset(struct vfio_pci_device *device)
+{
+	void *registers = ioat_channel_registers(device);
+	u32 sleep_ms = 1, attempts = 5000 / sleep_ms;
+	u8 chancmd;
+
+	ioat_clear_errors(device);
+
+	writeb(IOAT_CHANCMD_RESET, registers + IOAT2_CHANCMD_OFFSET);
+
+	for (;;) {
+		chancmd = readb(registers + IOAT2_CHANCMD_OFFSET);
+		if (!(chancmd & IOAT_CHANCMD_RESET))
+			break;
+
+		VFIO_ASSERT_GT(--attempts, 0);
+		usleep(sleep_ms * 1000);
+	}
+
+	VFIO_ASSERT_EQ(ioat_channel_status(registers), IOAT_CHANSTS_HALTED);
+}
+
+static void ioat_init(struct vfio_pci_device *device)
+{
+	struct ioat_state *ioat = to_ioat_state(device);
+	u8 intrctrl;
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*ioat));
+
+	vfio_pci_config_writew(device, PCI_COMMAND,
+			       PCI_COMMAND_MEMORY |
+			       PCI_COMMAND_MASTER |
+			       PCI_COMMAND_INTX_DISABLE);
+
+	ioat_reset(device);
+
+	/* Enable the use of MXI-x interrupts for channel interrupts. */
+	intrctrl = IOAT_INTRCTRL_MSIX_VECTOR_CONTROL;
+	writeb(intrctrl, device->bars[0].vaddr + IOAT_INTRCTRL_OFFSET);
+
+	vfio_pci_msix_enable(device, 0, device->msix_info.count);
+
+	device->driver.msi = 0;
+	device->driver.max_memcpy_size =
+		1UL << readb(device->bars[0].vaddr + IOAT_XFERCAP_OFFSET);
+	device->driver.max_memcpy_count = IOAT_DMACOUNT_MAX;
+}
+
+static void ioat_remove(struct vfio_pci_device *device)
+{
+	ioat_reset(device);
+	vfio_pci_msix_disable(device);
+}
+
+static void ioat_handle_error(struct vfio_pci_device *device)
+{
+	void *registers = ioat_channel_registers(device);
+
+	printf("Error detected during memcpy operation!\n"
+	       "  CHANERR: 0x%x\n"
+	       "  CHANERR_INT: 0x%x\n"
+	       "  DMAUNCERRSTS: 0x%x\n",
+	       readl(registers + IOAT_CHANERR_OFFSET),
+	       vfio_pci_config_readl(device, IOAT_PCI_CHANERR_INT_OFFSET),
+	       vfio_pci_config_readl(device, IOAT_PCI_DMAUNCERRSTS_OFFSET));
+
+	ioat_reset(device);
+}
+
+static int ioat_memcpy_wait(struct vfio_pci_device *device)
+{
+	void *registers = ioat_channel_registers(device);
+	u64 status;
+	int r = 0;
+
+	/* Wait until all operations complete. */
+	for (;;) {
+		status = ioat_channel_status(registers);
+		if (status == IOAT_CHANSTS_DONE)
+			break;
+
+		if (status == IOAT_CHANSTS_HALTED) {
+			ioat_handle_error(device);
+			return -1;
+		}
+	}
+
+	/* Put the channel into the SUSPENDED state. */
+	writeb(IOAT_CHANCMD_SUSPEND, registers + IOAT2_CHANCMD_OFFSET);
+	for (;;) {
+		status = ioat_channel_status(registers);
+		if (status == IOAT_CHANSTS_SUSPENDED)
+			break;
+	}
+
+	return r;
+}
+
+static void __ioat_memcpy_start(struct vfio_pci_device *device,
+				iova_t src, iova_t dst, u64 size,
+				u16 count, bool interrupt)
+{
+	void *registers = ioat_channel_registers(device);
+	struct ioat_state *ioat = to_ioat_state(device);
+	u64 desc_iova;
+	u16 chanctrl;
+
+	desc_iova = to_iova(device, &ioat->desc);
+	ioat->desc = (struct ioat_dma_descriptor) {
+		.ctl_f.op = IOAT_OP_COPY,
+		.ctl_f.int_en = interrupt,
+		.src_addr = src,
+		.dst_addr = dst,
+		.size = size,
+		.next = desc_iova,
+	};
+
+	/* Tell the device the address of the descriptor. */
+	writeq(desc_iova, registers + IOAT2_CHAINADDR_OFFSET);
+
+	/* (Re)Enable the channel interrupt and abort on any errors */
+	chanctrl = IOAT_CHANCTRL_INT_REARM | IOAT_CHANCTRL_ANY_ERR_ABORT_EN;
+	writew(chanctrl, registers + IOAT_CHANCTRL_OFFSET);
+
+	/* Kick off @count DMA copy operation(s). */
+	writew(count, registers + IOAT_CHAN_DMACOUNT_OFFSET);
+}
+
+static void ioat_memcpy_start(struct vfio_pci_device *device,
+			      iova_t src, iova_t dst, u64 size,
+			      u64 count)
+{
+	__ioat_memcpy_start(device, src, dst, size, count, false);
+}
+
+static void ioat_send_msi(struct vfio_pci_device *device)
+{
+	struct ioat_state *ioat = to_ioat_state(device);
+
+	__ioat_memcpy_start(device,
+			    to_iova(device, &ioat->send_msi_src),
+			    to_iova(device, &ioat->send_msi_dst),
+			    sizeof(ioat->send_msi_src), 1, true);
+
+	VFIO_ASSERT_EQ(ioat_memcpy_wait(device), 0);
+}
+
+const struct vfio_pci_driver_ops ioat_ops = {
+	.name = "ioat",
+	.probe = ioat_probe,
+	.init = ioat_init,
+	.remove = ioat_remove,
+	.memcpy_start = ioat_memcpy_start,
+	.memcpy_wait = ioat_memcpy_wait,
+	.send_msi = ioat_send_msi,
+};
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/registers.h b/tools/testing/selftests/vfio/lib/drivers/ioat/registers.h
new file mode 120000
index 000000000000..0b809cfd8fe6
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/registers.h
@@ -0,0 +1 @@
+../../../../../../../drivers/dma/ioat/registers.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index a3c3bc9a7c00..624dc267a879 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -1,8 +1,15 @@
+include $(top_srcdir)/scripts/subarch.include
+ARCH ?= $(SUBARCH)
+
 VFIO_DIR := $(selfdir)/vfio
 
 LIBVFIO_C := lib/vfio_pci_device.c
 LIBVFIO_C += lib/vfio_pci_driver.c
 
+ifeq ($(ARCH:x86_64=x86),x86)
+LIBVFIO_C += lib/drivers/ioat/ioat.c
+endif
+
 LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
 
 LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index c98bd2d31d8a..aa47360e47a9 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -4,7 +4,15 @@
 #include "../../../kselftest.h"
 #include <vfio_util.h>
 
-static struct vfio_pci_driver_ops *driver_ops[] = {};
+#ifdef __x86_64__
+extern struct vfio_pci_driver_ops ioat_ops;
+#endif
+
+static struct vfio_pci_driver_ops *driver_ops[] = {
+#ifdef __x86_64__
+	&ioat_ops,
+#endif
+};
 
 void vfio_pci_driver_probe(struct vfio_pci_device *device)
 {
-- 
2.50.0.rc2.701.gf1e915cc24-goog


