Return-Path: <linux-kselftest+bounces-39753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6D6B3246D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D22B621A7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5E338F57;
	Fri, 22 Aug 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzYgXpIv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5134F46F
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898003; cv=none; b=Agv/5O0mWqhi/othG7buphyoJFUT/4X3qPv9ObmvUhRoNb0T4DeUBhsDgfIjdk3dBw4hDMHYHGC9KTQ4jYLMBer3oxIkhPsN2fMzZ47YwlkNQmoQD20xlZLscXtUgitboZzmkvdzjDWT9A4LiR4kD7rUVAHJSqZCisCsUp7ZpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898003; c=relaxed/simple;
	bh=Dmy3fFYK2KTgdif1mKQucoV9w3k9hkVwlZFbZ9sk3qE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdHEi7CBu0EVHkTXPDB1pole6DTT0qljlEw5JiLGdosctlEIi9ooYLYjVLlemQtuyk5Y3f7jKEj3tBlAuuJaVqQO9NfZShhH+sM+wzfn9jlWeSACZ0eXX9anBe6K2aKY+5t2sHceBUH2AL5aVwYKmXsXNp1XLTtVc/lKXB1FXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzYgXpIv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso4779485a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898001; x=1756502801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zR3tvuCrl/rJfx/vritfY/erRpiO1O/2mfuAwmbrD2M=;
        b=LzYgXpIvfAWk+iHldwTdKtMSZJx8lzu1cAGXdGw4b5G/G/RzWDXsRnR9MA3KdesQm+
         2lyJJ7T9OxGDbMSWiIdc2KtbovZ317OyrUu+dEXg0kaCu2KKlrYNr4voVbzTHmFG5X14
         W7qqn39T92s8bID8KWKbeasJ+YP9gQewaA4ML/rDiRjK5UDsz2v9NzKP6RtntAC3Afbh
         1V6Q2GJ0jsQrSsWsrUN8uwvmybHMDG/hxF1W+V4p2UVD2T9RhqYZ/BHpuHYXFIKnCVjp
         fcdAkTBxo+77CSeZr73o/4bwaTIC46Zx3RY8eDlvVsTS/UvxOxArHBGB7KdYGD8uecln
         YW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898001; x=1756502801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zR3tvuCrl/rJfx/vritfY/erRpiO1O/2mfuAwmbrD2M=;
        b=ItMwe2gwRkSRzROBYiHUa9trhQ92GRte6W8TDIS8/C2pRKt4hzr6ylQF3kmw0e+mAR
         Q+WURWjMJI4i1J1IzZZGdvZAU/g/OhZqovnjtVOUp4RjsZIfcAWd946s/I7ubFwHIBri
         +PutPgf0LvX9NG4/cPWMOLLVig+q5UzhFfxt74GCUslMg35yP6cQn1w8rc55FdDAMG6P
         I4N4nsQ09k0bdwv2dxbsam+0XN+UHjunqpxi1Pi3xk8Ryjyx9w3cqNs0YnRW4b69HEGy
         5Cc79JWfiLGQZIc9FGzZJCp15AnvsX0svDkECIdocxoNUgHn+fKUptEyUhCQS7EjfGNn
         VE7w==
X-Forwarded-Encrypted: i=1; AJvYcCUy+j3hO6mprTflNTKgs3QMnyc/q8GXTJAWFG2kQ57Bwgk3/U4DVszymhfUIqCt0sQaa+FhxgOdd5pTU6R5jHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXPwvpr3U/2H7JIfXofXcvorDjcSwVyJv9etbO38nwrkbnT/c
	4yUl4T4IdPvtFSjlSjTABHuSK/qk0BaTcqv+lwv4Viqaz+HGEt0nQuxE+KZAN6oPt7qProJOD2O
	5kkLUX+m1aqahGA==
X-Google-Smtp-Source: AGHT+IFTINPMtO0k+Z6Mm4KdfeVJHuteYRyUW9I++hu77cL9BUuWe7hGxgRX4EeA7rlSUsd0b7+u4THL4IocRQ==
X-Received: from pjes9.prod.google.com ([2002:a17:90a:749:b0:325:25fe:50bc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:390c:b0:320:f10c:8c21 with SMTP id 98e67ed59e1d1-32515eda48amr5701454a91.30.1755898001246;
 Fri, 22 Aug 2025 14:26:41 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:09 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-23-dmatlack@google.com>
Subject: [PATCH v2 22/30] vfio: selftests: Add driver for Intel DSA
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

Add a driver to VFIO selftests for Intel DSA devices.

For now the driver only supports up to 32 batches and 1024 copies per
batch, which were the limits of the hardware this commit was tested
with. This is sufficient to generate 9+ minutes of DMA memcpys at a rate
of over 30 GB/s. This should be plenty to stress test VFIO and the IOMMU.

The driver does not yet support requesting interrupt handles, as this
commit was not tested against hardware that requires it.

Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/drivers/dsa/dsa.c      | 416 ++++++++++++++++++
 .../vfio/lib/drivers/dsa/registers.h          |   1 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
 4 files changed, 420 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/dsa/registers.h

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
new file mode 100644
index 000000000000..0ca2cbc2a316
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdint.h>
+#include <unistd.h>
+
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/idxd.h>
+#include <linux/io.h>
+#include <linux/pci_ids.h>
+#include <linux/sizes.h>
+
+#include <vfio_util.h>
+
+#include "registers.h"
+
+/* Vectors 1+ are available for work queue completion interrupts. */
+#define MSIX_VECTOR 1
+
+struct dsa_state {
+	/* Descriptors for copy and batch operations. */
+	struct dsa_hw_desc batch[32];
+	struct dsa_hw_desc copy[1024];
+
+	/* Completion records for copy and batch operations. */
+	struct dsa_completion_record copy_completion;
+	struct dsa_completion_record batch_completion;
+
+	/* Cached device registers (and derived data) for easy access */
+	union gen_cap_reg gen_cap;
+	union wq_cap_reg wq_cap;
+	union group_cap_reg group_cap;
+	union engine_cap_reg engine_cap;
+	union offsets_reg table_offsets;
+	void *wqcfg_table;
+	void *grpcfg_table;
+	u64 max_batches;
+	u64 max_copies_per_batch;
+
+	/* The number of ongoing memcpy operations. */
+	u64 memcpy_count;
+
+	/* Buffers used by dsa_send_msi() to generate an interrupt */
+	u64 send_msi_src;
+	u64 send_msi_dst;
+};
+
+static inline struct dsa_state *to_dsa_state(struct vfio_pci_device *device)
+{
+	return device->driver.region.vaddr;
+}
+
+static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
+{
+	void *bar0 = device->bars[0].vaddr;
+	union gen_cap_reg gen_cap;
+	u32 cmd_cap;
+
+	gen_cap.bits = readq(bar0 + IDXD_GENCAP_OFFSET);
+	if (!gen_cap.cmd_cap)
+		return false;
+
+	cmd_cap = readl(bar0 + IDXD_CMDCAP_OFFSET);
+	return (cmd_cap >> IDXD_CMD_REQUEST_INT_HANDLE) & 1;
+}
+
+static int dsa_probe(struct vfio_pci_device *device)
+{
+	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
+				   PCI_DEVICE_ID_INTEL_DSA_SPR0))
+		return -EINVAL;
+
+	if (dsa_int_handle_request_required(device)) {
+		printf("Device requires requesting interrupt handles\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void dsa_check_sw_err(struct vfio_pci_device *device)
+{
+	void *reg = device->bars[0].vaddr + IDXD_SWERR_OFFSET;
+	union sw_err_reg err = {};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(err.bits); i++) {
+		err.bits[i] = readq(reg + offsetof(union sw_err_reg, bits[i]));
+
+		/* No errors */
+		if (i == 0 && !err.valid)
+			return;
+	}
+
+	fprintf(stderr, "SWERR: 0x%016lx 0x%016lx 0x%016lx 0x%016lx\n",
+		err.bits[0], err.bits[1], err.bits[2], err.bits[3]);
+
+	fprintf(stderr, "  valid: 0x%x\n", err.valid);
+	fprintf(stderr, "  overflow: 0x%x\n", err.overflow);
+	fprintf(stderr, "  desc_valid: 0x%x\n", err.desc_valid);
+	fprintf(stderr, "  wq_idx_valid: 0x%x\n", err.wq_idx_valid);
+	fprintf(stderr, "  batch: 0x%x\n", err.batch);
+	fprintf(stderr, "  fault_rw: 0x%x\n", err.fault_rw);
+	fprintf(stderr, "  priv: 0x%x\n", err.priv);
+	fprintf(stderr, "  error: 0x%x\n", err.error);
+	fprintf(stderr, "  wq_idx: 0x%x\n", err.wq_idx);
+	fprintf(stderr, "  operation: 0x%x\n", err.operation);
+	fprintf(stderr, "  pasid: 0x%x\n", err.pasid);
+	fprintf(stderr, "  batch_idx: 0x%x\n", err.batch_idx);
+	fprintf(stderr, "  invalid_flags: 0x%x\n", err.invalid_flags);
+	fprintf(stderr, "  fault_addr: 0x%lx\n", err.fault_addr);
+
+	VFIO_FAIL("Software Error Detected!\n");
+}
+
+static void dsa_command(struct vfio_pci_device *device, u32 cmd)
+{
+	union idxd_command_reg cmd_reg = { .cmd = cmd };
+	u32 sleep_ms = 1, attempts = 5000 / sleep_ms;
+	void *bar0 = device->bars[0].vaddr;
+	u32 status;
+	u8 err;
+
+	writel(cmd_reg.bits, bar0 + IDXD_CMD_OFFSET);
+
+	for (;;) {
+		dsa_check_sw_err(device);
+
+		status = readl(bar0 + IDXD_CMDSTS_OFFSET);
+		if (!(status & IDXD_CMDSTS_ACTIVE))
+			break;
+
+		VFIO_ASSERT_GT(--attempts, 0);
+		usleep(sleep_ms * 1000);
+	}
+
+	err = status & IDXD_CMDSTS_ERR_MASK;
+	VFIO_ASSERT_EQ(err, 0, "Error issuing command 0x%x: 0x%x\n", cmd, err);
+}
+
+static void dsa_wq_init(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	union wq_cap_reg wq_cap = dsa->wq_cap;
+	union wqcfg wqcfg;
+	u64 wqcfg_size;
+	int i;
+
+	VFIO_ASSERT_GT((u32)wq_cap.num_wqs, 0);
+
+	wqcfg = (union wqcfg) {
+		.wq_size = wq_cap.total_wq_size,
+		.mode = 1,
+		.priority = 1,
+		/*
+		 * Disable Address Translation Service (if enabled) so that VFIO
+		 * selftests using this driver can generate I/O page faults.
+		 */
+		.wq_ats_disable = wq_cap.wq_ats_support,
+		.max_xfer_shift = dsa->gen_cap.max_xfer_shift,
+		.max_batch_shift = dsa->gen_cap.max_batch_shift,
+		.op_config[0] = BIT(DSA_OPCODE_MEMMOVE) | BIT(DSA_OPCODE_BATCH),
+	};
+
+	wqcfg_size = 1UL << (wq_cap.wqcfg_size + IDXD_WQCFG_MIN);
+
+	for (i = 0; i < wqcfg_size / sizeof(wqcfg.bits[0]); i++)
+		writel(wqcfg.bits[i], dsa->wqcfg_table + offsetof(union wqcfg, bits[i]));
+}
+
+static void dsa_group_init(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	union group_cap_reg group_cap = dsa->group_cap;
+	union engine_cap_reg engine_cap = dsa->engine_cap;
+
+	VFIO_ASSERT_GT((u32)group_cap.num_groups, 0);
+	VFIO_ASSERT_GT((u32)engine_cap.num_engines, 0);
+
+	/* Assign work queue 0 and engine 0 to group 0 */
+	writeq(1, dsa->grpcfg_table + offsetof(struct grpcfg, wqs[0]));
+	writeq(1, dsa->grpcfg_table + offsetof(struct grpcfg, engines));
+}
+
+static void dsa_register_cache_init(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	void *bar0 = device->bars[0].vaddr;
+
+	dsa->gen_cap.bits = readq(bar0 + IDXD_GENCAP_OFFSET);
+	dsa->wq_cap.bits = readq(bar0 + IDXD_WQCAP_OFFSET);
+	dsa->group_cap.bits = readq(bar0 + IDXD_GRPCAP_OFFSET);
+	dsa->engine_cap.bits = readq(bar0 + IDXD_ENGCAP_OFFSET);
+
+	dsa->table_offsets.bits[0] = readq(bar0 + IDXD_TABLE_OFFSET);
+	dsa->table_offsets.bits[1] = readq(bar0 + IDXD_TABLE_OFFSET + 8);
+
+	dsa->wqcfg_table = bar0 + dsa->table_offsets.wqcfg * IDXD_TABLE_MULT;
+	dsa->grpcfg_table = bar0 + dsa->table_offsets.grpcfg * IDXD_TABLE_MULT;
+
+	dsa->max_batches = 1U << (dsa->wq_cap.total_wq_size + IDXD_WQCFG_MIN);
+	dsa->max_batches = min(dsa->max_batches, ARRAY_SIZE(dsa->batch));
+
+	dsa->max_copies_per_batch = 1UL << dsa->gen_cap.max_batch_shift;
+	dsa->max_copies_per_batch = min(dsa->max_copies_per_batch, ARRAY_SIZE(dsa->copy));
+}
+
+static void dsa_init(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*dsa));
+
+	vfio_pci_config_writew(device, PCI_COMMAND,
+			       PCI_COMMAND_MEMORY |
+			       PCI_COMMAND_MASTER |
+			       PCI_COMMAND_INTX_DISABLE);
+
+	dsa_command(device, IDXD_CMD_RESET_DEVICE);
+
+	dsa_register_cache_init(device);
+	dsa_wq_init(device);
+	dsa_group_init(device);
+
+	dsa_command(device, IDXD_CMD_ENABLE_DEVICE);
+	dsa_command(device, IDXD_CMD_ENABLE_WQ);
+
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+
+	device->driver.max_memcpy_count =
+		dsa->max_batches * dsa->max_copies_per_batch;
+	device->driver.max_memcpy_size = 1UL << dsa->gen_cap.max_xfer_shift;
+	device->driver.msi = MSIX_VECTOR;
+}
+
+static void dsa_remove(struct vfio_pci_device *device)
+{
+	dsa_command(device, IDXD_CMD_RESET_DEVICE);
+	vfio_pci_msix_disable(device);
+}
+
+static int dsa_completion_wait(struct vfio_pci_device *device,
+			       struct dsa_completion_record *completion)
+{
+	u8 status;
+
+	for (;;) {
+		dsa_check_sw_err(device);
+
+		status = READ_ONCE(completion->status);
+		if (status)
+			break;
+
+		usleep(1000);
+	}
+
+	if (status == DSA_COMP_SUCCESS)
+		return 0;
+
+	printf("Error detected during memcpy operation: 0x%x\n", status);
+	return -1;
+}
+
+static void dsa_copy_desc_init(struct vfio_pci_device *device,
+			       struct dsa_hw_desc *desc,
+			       iova_t src, iova_t dst, u64 size,
+			       bool interrupt)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	u16 flags;
+
+	flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR;
+
+	if (interrupt)
+		flags |= IDXD_OP_FLAG_RCI;
+
+	*desc = (struct dsa_hw_desc) {
+		.opcode = DSA_OPCODE_MEMMOVE,
+		.flags = flags,
+		.priv = 1,
+		.src_addr = src,
+		.dst_addr = dst,
+		.xfer_size = size,
+		.completion_addr = to_iova(device, &dsa->copy_completion),
+		.int_handle = interrupt ? MSIX_VECTOR : 0,
+	};
+}
+
+static void dsa_batch_desc_init(struct vfio_pci_device *device,
+				struct dsa_hw_desc *desc,
+				u64 count)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+
+	*desc = (struct dsa_hw_desc) {
+		.opcode = DSA_OPCODE_BATCH,
+		.flags = IDXD_OP_FLAG_CRAV,
+		.priv = 1,
+		.completion_addr = to_iova(device, &dsa->batch_completion),
+		.desc_list_addr = to_iova(device, &dsa->copy[0]),
+		.desc_count = count,
+	};
+}
+
+static void dsa_desc_write(struct vfio_pci_device *device, struct dsa_hw_desc *desc)
+{
+	/* Write the contents (not address) of the 64-byte descriptor to the device. */
+	iosubmit_cmds512(device->bars[2].vaddr, desc, 1);
+}
+
+static void dsa_memcpy_one(struct vfio_pci_device *device,
+			   iova_t src, iova_t dst, u64 size, bool interrupt)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+
+	memset(&dsa->copy_completion, 0, sizeof(dsa->copy_completion));
+
+	dsa_copy_desc_init(device, &dsa->copy[0], src, dst, size, interrupt);
+	dsa_desc_write(device, &dsa->copy[0]);
+}
+
+static void dsa_memcpy_batch(struct vfio_pci_device *device,
+			     iova_t src, iova_t dst, u64 size, u64 count)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	int i;
+
+	memset(&dsa->batch_completion, 0, sizeof(dsa->batch_completion));
+
+	for (i = 0; i < ARRAY_SIZE(dsa->copy); i++) {
+		struct dsa_hw_desc *copy_desc = &dsa->copy[i];
+
+		dsa_copy_desc_init(device, copy_desc, src, dst, size, false);
+
+		/* Don't request completions for individual copies. */
+		copy_desc->flags &= ~IDXD_OP_FLAG_RCR;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dsa->batch) && count; i++) {
+		struct dsa_hw_desc *batch_desc = &dsa->batch[i];
+		int nr_copies;
+
+		nr_copies = min(count, dsa->max_copies_per_batch);
+		count -= nr_copies;
+
+		/*
+		 * Batches must have at least 2 copies, so handle the case where
+		 * there is exactly 1 copy left by doing one less copy in this
+		 * batch and then 2 in the next.
+		 */
+		if (count == 1) {
+			nr_copies--;
+			count++;
+		}
+
+		dsa_batch_desc_init(device, batch_desc, nr_copies);
+
+		/* Request a completion for the last batch. */
+		if (!count)
+			batch_desc->flags |= IDXD_OP_FLAG_RCR;
+
+		dsa_desc_write(device, batch_desc);
+	}
+
+	VFIO_ASSERT_EQ(count, 0, "Failed to start %lu copies.\n", count);
+}
+
+static void dsa_memcpy_start(struct vfio_pci_device *device,
+			     iova_t src, iova_t dst, u64 size, u64 count)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+
+	/* DSA devices require at least 2 copies per batch. */
+	if (count == 1)
+		dsa_memcpy_one(device, src, dst, size, false);
+	else
+		dsa_memcpy_batch(device, src, dst, size, count);
+
+	dsa->memcpy_count = count;
+}
+
+static int dsa_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	int r;
+
+	if (dsa->memcpy_count == 1)
+		r = dsa_completion_wait(device, &dsa->copy_completion);
+	else
+		r = dsa_completion_wait(device, &dsa->batch_completion);
+
+	dsa->memcpy_count = 0;
+
+	return r;
+}
+
+static void dsa_send_msi(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+
+	dsa_memcpy_one(device,
+		       to_iova(device, &dsa->send_msi_src),
+		       to_iova(device, &dsa->send_msi_dst),
+		       sizeof(dsa->send_msi_src), true);
+
+	VFIO_ASSERT_EQ(dsa_completion_wait(device, &dsa->copy_completion), 0);
+}
+
+const struct vfio_pci_driver_ops dsa_ops = {
+	.name = "dsa",
+	.probe = dsa_probe,
+	.init = dsa_init,
+	.remove = dsa_remove,
+	.memcpy_start = dsa_memcpy_start,
+	.memcpy_wait = dsa_memcpy_wait,
+	.send_msi = dsa_send_msi,
+};
diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/registers.h b/tools/testing/selftests/vfio/lib/drivers/dsa/registers.h
new file mode 120000
index 000000000000..bde657c3c2af
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/registers.h
@@ -0,0 +1 @@
+../../../../../../../drivers/dma/idxd/registers.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 624dc267a879..5d11c3a89a28 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -8,6 +8,7 @@ LIBVFIO_C += lib/vfio_pci_driver.c
 
 ifeq ($(ARCH:x86_64=x86),x86)
 LIBVFIO_C += lib/drivers/ioat/ioat.c
+LIBVFIO_C += lib/drivers/dsa/dsa.c
 endif
 
 LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index aa47360e47a9..e5e8723ecb41 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -5,11 +5,13 @@
 #include <vfio_util.h>
 
 #ifdef __x86_64__
+extern struct vfio_pci_driver_ops dsa_ops;
 extern struct vfio_pci_driver_ops ioat_ops;
 #endif
 
 static struct vfio_pci_driver_ops *driver_ops[] = {
 #ifdef __x86_64__
+	&dsa_ops,
 	&ioat_ops,
 #endif
 };
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


