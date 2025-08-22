Return-Path: <linux-kselftest+bounces-39750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E7B32475
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBAF1883949
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23900350837;
	Fri, 22 Aug 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wReic2z0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE73375A7
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897999; cv=none; b=ZvpC2V9jSfz4iYO+X9kNen5lz5sfIe+Xm6incN+jl5mnM7zGtMZDIwNfv3r23uLTQxah34Ba3HO6rQiPqb6EFoO4iovOHRFrF6SrQdsmuV0ymFl2aTFc5NOiUPGT8hILMlszGCuQl+b08MevpRqtadX0NpB8XlVRXFM1ObXFQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897999; c=relaxed/simple;
	bh=PT/ujjZi2DiY7wXt9w56WAdWJYkjQe24oc/aTDU+S9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCOAJHEpVgnOv1qjE4BNEE7nKM4o/6xeilc3FJVNW7p1TnMdRg2n6pUzPCWaAFHz6kbdx4vODp0KMihFyj0jMolkDK7zhramZh9CPegTGqx7lmsGDd91IISrryVTYXW54oo0jtT6gx1Oa0mKWqfuU88gyBCW3FPTWKbem8Zg/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wReic2z0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32515e8e4b3so1343267a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897997; x=1756502797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bZYXzRdX3HV+G64ckOS5xBZ+kEbxofKP6zI48K3RLQ=;
        b=wReic2z0wniTojQ2AHX1Ku1xSA4bIHzq1HRMRhVEuvvSutqpf2S06dhYrlDe/8yDEp
         NcU+bjt5hSmf6SAauc2Rshutjyn/0BUTHT0rOkZnme+TWeNaLFENZFF0kGKROzSwglIa
         hQqX4Hl5clCOMqLUl5y5WfoDhMObt1/qD4b4y1mQ+Mhisil38UJaQd5xQ6PsXhbPU3Ij
         WszdAI36UxVRZlBSgSZ9xbbuVu92LikFuLaIQ8wUm2TcXeCiDX54wv/Va9ncoMgqqzZd
         jl94+/ZqoxBpC6xFB/gebcJ9ch10DoGvqUWEA/2fRExfe76HlJ/vQegYa7xCOXcAeCWE
         gXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897997; x=1756502797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bZYXzRdX3HV+G64ckOS5xBZ+kEbxofKP6zI48K3RLQ=;
        b=fjgTeCtiAiPumcCzyz2O9Lfn/8qXeycBo2SbiT+XN4ulud8OyKS630yyfnPzQK1w4Q
         vBMRkYnPQDKpoY8T+mRrgfs9CaHH8q2wYeSkMtsS9AUB0FVHBy8MOin4+cVJZdPZ2/Aj
         U8sjtwRXS3CfAkVmSYq+hMLe38vONQLRMY/hoLtt6nltPvVuDlITDcnFmGkQ/dO9e3/8
         8QEAm5cmBhTVDXDNLHGz8vywu5gExpPteYhTZZhYKO0bprcfHpt5IL0JJZ4+W0p+et1N
         K+B+TGNfMsTEmyBDANVYsk/Tf6bfyoNuzYM0J8w4g4gL/lvineoZtXRUM2YnQrCYzgL2
         DNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcKWDeRgcRBFPWKNefgRU52DoLWLkIuzmbv3fA9gdIVsT9vex0CFTmQCl/O2UyMl6JasFrHkGqgu6C18lCDJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkc7Zu802F8m5PuzdYtbRoquNFidFdRipgZxOuT8g+ZU8uF+f
	15Pit29+EFty+F20uPM2iJolt8GGjVQP064al4Boj4e4C42Y6YBz1JifOqXLJhugq5sYbEAsczo
	yfR9l+IMgWJvK0g==
X-Google-Smtp-Source: AGHT+IHK5eJtajpSDeY2cuuNhmrEl/roxASMs2PwaMjc6ap4cv9cnqCrUh8V3OCPx8JLhIQ/qrbJ8kx+qcqbvw==
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:321:c475:716e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc2:b0:31f:6d6b:b453 with SMTP id 98e67ed59e1d1-32517c23e05mr5721729a91.30.1755897996708;
 Fri, 22 Aug 2025 14:26:36 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:06 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-20-dmatlack@google.com>
Subject: [PATCH v2 19/30] vfio: selftests: Add driver for Intel CBDMA
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
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


