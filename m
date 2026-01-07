Return-Path: <linux-kselftest+bounces-48439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B215DD0049F
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 23:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A6130111AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 22:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC62D3A77;
	Wed,  7 Jan 2026 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="TbPYEG+B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A83A0B3A;
	Wed,  7 Jan 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824030; cv=none; b=JgFyAlh+nTMcH+9KJ2OR/r858Qgcx5h2oDskgjTn9x7krHfMKWuoX91qfy+BzbbxMGiHQVLIp2+7aBSoZQv+W6RcttgJOWVmMnwJNYzIDkJnz9IaUbquC8S1HKHNJdNDbzL3kU21lmdGuWHqZO/JuzCGyhuNuZZ6JLdPmxdVZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824030; c=relaxed/simple;
	bh=qqfzQjbPaZiqnSvHvcijDuntVKYb0r+WGbmy4TTSRMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=UB3WEh28GfFWnnMhIg//7T6PdmrYFoID7fgLqIGednUisPb88e6f5yhRcGPRH7Ra2BY/2lVgP+Jg0QFuTUaIzNBbtOtdcRaFhgbLR1lDU1u9Ob3FOl+zIx3fm0pwOIkVowra80lW7Ifj1U1BoTCGmo4XCdxKGJj83q41nleh94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=TbPYEG+B; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 607IjicB622802;
	Wed, 7 Jan 2026 14:13:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=DafmNcbFeXO5o/wQ1r
	kxF78GvM+CmIYVSaG9Cwt7cRg=; b=TbPYEG+Bgh1OYJJJ8ZsN1w7I4j/kVz1lzh
	E/eXuGPIrg6gSnIkjH+VMJydB41pOaO1z/452q90nwQ/YxlwRonKBspjwBuaH945
	FGOPI3dmfiEENG01EO3lqdgT/ERJWXHXzqXHrVscErNsYy69/dwTSZE3nPhFV5Ij
	LffbOwVyqBgaSQ7BXPHUEEpafyMaX5dUX2Su7XeqpEBVX3ZpbaKIgFzA9tfNmxTc
	t/L0LiOwGf2p6irsgDR/SkxbPPxSpcfIxCjqyye9FD7+rRv1ccFWGAF1aR0BTGGT
	0WFDAFQi5PhM9hdMOsTX2LImifnKvxh+OPssAsRVfgAEVOMMoXRg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4bhw25su4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 07 Jan 2026 14:13:39 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 7 Jan 2026 22:13:38 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 7 Jan 2026 14:13:28 -0800
Subject: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
X-B4-Tracking: v=1; b=H4sIAIjaXmkC/x2NMQrDMAwAvxI0V+CYtqH9SukgbDnRINtYJgRC/
 l7T8W64O8G4CRu8pxMa72JS8oD5NkHYKK+MEgeDd/7pZreghUY9bEhK1lvBPUnBqIRKtUpeUXW
 IztaROST/iC9a7h5GsDZOcvxnn+91/QCz9PFRfAAAAA==
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE3NSBTYWx0ZWRfX4J8r+sejVO+q
 qa/7y4Ol/d0xZC+jAzHKilH+Y9XboVKM3g/pM1WNVJio+l5C6pc4ddX6kKnYFghFKoY4TwdP23v
 LP6kEoKcBpat60qYYqB+ofp2rt0oAKQ40ro9bH2PdEjezgdgNjhSEpDPu0e49dtdSONDEsRcaqV
 mmDbyuJGh2/zmMlOwp4ejA36wpxR3iMTagoMQOnhntyPltDos/ikQMWhqwSqj1FqXtIpDrbtHCc
 WIcZVMK+DL6tD/5yDp9/NhjA+xVtzfiHGOQRnIiR9ItgYpMgJTIcfOqD+9N55EtXSlEBkikiVaE
 qRcN12Xcrlfq6IJaRd+T1/UVZSISkvw4cUwtihXA4lJJt3YcbrfZT+hAB8KQacutD/6FCiiGbIq
 pIt2RsAcp5DAfMLr2aeYHRQLUd2miEFXyZMqfM/YdUwZi38tuSuLD0iagMva8t9GfW4ut7NMNnH
 iFg3KSF+Vq2gSoqk3UA==
X-Authority-Analysis: v=2.4 cv=e44LiKp/ c=1 sm=1 tr=0 ts=695eda93 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=NLpSljadU2Bl48MHU78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pOZwZdv2nNUWi-kkQHRPnXQ9enEdnIGo
X-Proofpoint-ORIG-GUID: pOZwZdv2nNUWi-kkQHRPnXQ9enEdnIGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-07_03,2025-10-01_01

Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.
Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
page mappings.

Only vfio_type1 variants are tested; iommufd variants can be added
once kernel support lands. The manual mmap alignment can be removed
once mmap(!MAP_FIXED) on vfio device fds improves to automatically
return well-aligned addresses.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
Sanity test run:

$ ./vfio_dma_mapping_mmio_test 0000:05:00.0
TAP version 13
1..4
# Starting 4 tests from 2 test cases.
#  RUN           vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar ...
Mapping BAR4: vaddr=0x7fad40000000 size=0x2000000000 iova=0x2000000000
#            OK  vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar
ok 1 vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar
#  RUN           vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar ...
Mapping BAR4 (partial): vaddr=0x7fad40000000 size=0x1000 iova=0x0
#            OK  vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar
ok 2 vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar
#  RUN           vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar ...
Mapping BAR4: vaddr=0x7fad40000000 size=0x2000000000 iova=0x2000000000
#            OK  vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar
ok 3 vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar
#  RUN           vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar ...
Mapping BAR4 (partial): vaddr=0x7fad40000000 size=0x1000 iova=0x0
#            OK  vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar
ok 4 vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar
# PASSED: 4 / 4 tests passed.
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
---
 tools/testing/selftests/vfio/Makefile              |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  28 ++++-
 .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 132 +++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 3c796ca99a50..ead27892ab65 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,5 +1,6 @@
 CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
+TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 13fdb4b0b10f..6f29543856a5 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -12,10 +12,13 @@
 #include <sys/mman.h>
 
 #include <uapi/linux/types.h>
+#include <linux/align.h>
 #include <linux/iommufd.h>
+#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
 #include <linux/overflow.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/vfio.h>
 
@@ -124,20 +127,43 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
 static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
 {
 	struct vfio_pci_bar *bar = &device->bars[index];
+	size_t align, size;
+	void *map_base, *map_align;
 	int prot = 0;
 
 	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
 	VFIO_ASSERT_NULL(bar->vaddr);
 	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
+	VFIO_ASSERT_GT(bar->info.size, 0);
 
 	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
 		prot |= PROT_READ;
 	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
 		prot |= PROT_WRITE;
 
-	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
+	/*
+	 * Align the mmap for more efficient IOMMU mapping.
+	 * The largest PUD size supporting huge pfnmap is 1GiB.
+	 */
+	size = bar->info.size;
+	align = min_t(u64, 1ULL << __builtin_ctzll(size), SZ_1G);
+
+	map_base = mmap(NULL, size + align, PROT_NONE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	VFIO_ASSERT_NE(map_base, MAP_FAILED);
+
+	map_align = (void *)ALIGN((uintptr_t)map_base, align);
+
+	if (map_align > map_base)
+		munmap(map_base, map_align - map_base);
+	if (align > (size_t)(map_align - map_base))
+		munmap(map_align + size, align - (map_align - map_base));
+
+	bar->vaddr = mmap(map_align, size, prot, MAP_SHARED | MAP_FIXED,
 			  device->fd, bar->info.offset);
 	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+
+	madvise(bar->vaddr, size, MADV_HUGEPAGE);
 }
 
 static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
new file mode 100644
index 000000000000..211fa4203b49
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <uapi/linux/types.h>
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+static int largest_mapped_bar(struct vfio_pci_device *device)
+{
+	int bar_idx = -1;
+	u64 bar_size = 0;
+
+	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct vfio_pci_bar *bar = &device->bars[i];
+
+		if (!bar->vaddr)
+			continue;
+
+		if (!(bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE))
+			continue;
+
+		if (bar->info.size > bar_size) {
+			bar_size = bar->info.size;
+			bar_idx = i;
+		}
+	}
+
+	return bar_idx;
+}
+
+FIXTURE(vfio_dma_mapping_mmio_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+	int bar_idx;
+};
+
+FIXTURE_VARIANT(vfio_dma_mapping_mmio_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			       \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_mmio_test, _iommu_mode) {	       \
+	.iommu_mode = #_iommu_mode,					       \
+}
+
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu);
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu);
+
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->iova_allocator = iova_allocator_init(self->iommu);
+	self->bar_idx = largest_mapped_bar(self->device);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_mmio_test)
+{
+	iova_allocator_cleanup(self->iova_allocator);
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_dma_mapping_mmio_test, map_full_bar)
+{
+	struct vfio_pci_bar *bar;
+	struct dma_region region;
+
+	if (self->bar_idx < 0)
+		SKIP(return, "No mappable BAR found on device %s", device_bdf);
+
+	bar = &self->device->bars[self->bar_idx];
+
+	region = (struct dma_region) {
+		.vaddr = bar->vaddr,
+		.size = bar->info.size,
+		.iova = iova_allocator_alloc(self->iova_allocator, bar->info.size),
+	};
+
+	printf("Mapping BAR%d: vaddr=%p size=0x%lx iova=0x%lx\n",
+	       self->bar_idx, region.vaddr, region.size, region.iova);
+
+	iommu_map(self->iommu, &region);
+	iommu_unmap(self->iommu, &region);
+}
+
+TEST_F(vfio_dma_mapping_mmio_test, map_partial_bar)
+{
+	struct vfio_pci_bar *bar;
+	struct dma_region region;
+	size_t page_size;
+
+	if (self->bar_idx < 0)
+		SKIP(return, "No mappable BAR found on device %s", device_bdf);
+
+	bar = &self->device->bars[self->bar_idx];
+	page_size = getpagesize();
+
+	if (bar->info.size < 2 * page_size)
+		SKIP(return, "BAR%d too small for partial mapping test (size=0x%llx)",
+		     self->bar_idx, bar->info.size);
+
+	region = (struct dma_region) {
+		.vaddr = bar->vaddr,
+		.size = page_size,
+		.iova = iova_allocator_alloc(self->iova_allocator, page_size),
+	};
+
+	printf("Mapping BAR%d (partial): vaddr=%p size=0x%lx iova=0x%lx\n",
+	       self->bar_idx, region.vaddr, region.size, region.iova);
+
+	iommu_map(self->iommu, &region);
+	iommu_unmap(self->iommu, &region);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}

---
base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
change-id: 20260107-scratch-amastro-vfio-dma-mapping-mmio-test-eecf25d9a742

Best regards,
-- 
Alex Mastro <amastro@fb.com>


