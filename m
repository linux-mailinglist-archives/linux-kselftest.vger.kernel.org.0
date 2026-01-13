Return-Path: <linux-kselftest+bounces-48896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD3D1BA8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 00:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1074130517F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A1936B06C;
	Tue, 13 Jan 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="tSPnHRI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E334FF46;
	Tue, 13 Jan 2026 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345767; cv=none; b=ujzrqWB4y5WTusltDCQYwgcE8++ZRc4bpKKIPJvVzbiX+2si4NvtVhMCHZy1psk+d7XaIcnoCq64MRvCZwFRxUZpEznE1NWqWp3bCPEWtCudG//oIdRnHj+1SRV4LIStCz5/jACBCjSml3mSrHaKDM+hptqdDx8EfD2o4DPrbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345767; c=relaxed/simple;
	bh=pQxsBZwch3YoWkqClhpNBi21JRjK1LSqDgOVcnyH6TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oj9UTNnaGvJH3+RJtJmshkqgl3cEGLOcXq2FPim3o+OpSw1XRG6JxkQRoxVH/gxW73BxqB3Mf351C0dJioeEIOLtn+Yx0jzphY/grezj0ZpgXMnrVF1GmCwalktOEaAMwx7L11394gazg1jNxPmRuZQ47MqBQhjW1f/kGnHw07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=tSPnHRI8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DN6m664099591;
	Tue, 13 Jan 2026 15:09:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=vmuACL6Byooatn57EepVgCCX9NM030r1I/ikSyIw7eU=; b=tSPnHRI8qL/0
	6DE4xtWJOa5ZVtonqOmAfOZKonHgE0rJAoCzpdcboZODxPbDfs07fg4/qa5GcIoS
	dt72x9eapSLZTmtS8/z2pAHRgaMDwTo9tt976lOs7WNRzwj903YiP6dDzBn69KQ1
	lWtLXmX0Ci16i0Sg2ynRlH+0D+8cQC0m7yyWz6D5ywJxhh8jEuYZ//glP+wmGsgt
	yMxu42jdXu7SgpbuhfaY/NYccYNKgD9WU33yn3a8xAPD65PzV2TI1sFvxxsaPsy+
	Yv4MUty33cQQ14ne6MMbR9A3cJEEf3a4o5WPRoZHdsRDgWaMxD3ofzkk795rpT0h
	NnZmixFFGw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnyeh80r2-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 15:09:17 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 23:09:04 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 13 Jan 2026 15:08:38 -0800
Subject: [PATCH v2 3/3] vfio: selftests: Add vfio_dma_mapping_mmio_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260113-map-mmio-test-v2-3-e6d34f09c0bb@fb.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
In-Reply-To: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: yreJtxB8CECuRy29vzYPR5kD959Tz3LG
X-Authority-Analysis: v=2.4 cv=brZBxUai c=1 sm=1 tr=0 ts=6966d09e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=FzPllQ_cktK6OXWCqgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE4NyBTYWx0ZWRfX4ImIj+DPrzZ3
 jw9PaL242LE1hLcGQnAVXbIkOr4gph/7YVzoWDzw8uW9lb3IodwHYyqN5ijOuF+DS1I5Q044Mxe
 bDCpsvyp+VmH4K56cWbnNvXi33ZOd1QICs1m8dwXZM0fRWuQFiiot+zoXjVPDNumAncm50l//Mj
 XT23D/lN2rR5mkO3tBaKek9A1N8Ps00iM9R4u1tzaBcbWd51RIlPTda2wkSDrl5befzmkSd8yzB
 vcf4yjSysel2gmQd2uYNTsMKuTXNKttOxkdMPlSizSo0y1MHnavqm545eLCPAdsTWJOwKR26UsD
 nN1N57uuzmIdNhAH7lO8DjdHjwB4IhTqxJcY2snbz/PeORZoqTzcp+cJCqQw8wsYmqgmt1vi+z1
 YtMNbfRFBGDiRmuKi3GNGZ4bQixBtxowyxc86Ctu8ZW3r0WM1urBrNe8+cdR/ULx75/NHcILzI9
 P3ELfqvGAsPbujvQdXA==
X-Proofpoint-GUID: yreJtxB8CECuRy29vzYPR5kD959Tz3LG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

Test IOMMU mapping the BAR mmaps created during vfio_pci_device_setup().

All IOMMU modes are tested: vfio_type1 variants are expected to succeed,
while non-type1 modes are expected to fail. iommufd compat mode can be
updated to expect success once kernel support lands; native iommufd will
not support mapping vaddrs backed by MMIO (it will support dma-buf based
MMIO mapping instead).

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/Makefile              |   1 +
 .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 144 +++++++++++++++++++++
 2 files changed, 145 insertions(+)

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
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
new file mode 100644
index 000000000000..5a86b34329ad
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
@@ -0,0 +1,144 @@
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
+static struct vfio_pci_bar *largest_mapped_bar(struct vfio_pci_device *device)
+{
+	u32 flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE;
+	struct vfio_pci_bar *largest = NULL;
+	u64 bar_size = 0;
+
+	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct vfio_pci_bar *bar = &device->bars[i];
+
+		if (!bar->vaddr)
+			continue;
+
+		/*
+		 * iommu_map() maps with READ|WRITE, so require the same
+		 * abilities for the underlying VFIO region.
+		 */
+		if ((bar->info.flags & flags) != flags)
+			continue;
+
+		if (bar->info.size > bar_size) {
+			bar_size = bar->info.size;
+			largest = bar;
+		}
+	}
+
+	return largest;
+}
+
+FIXTURE(vfio_dma_mapping_mmio_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+	struct vfio_pci_bar *bar;
+};
+
+FIXTURE_VARIANT(vfio_dma_mapping_mmio_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			       \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_mmio_test, _iommu_mode) {		       \
+	.iommu_mode = #_iommu_mode,					       \
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->iova_allocator = iova_allocator_init(self->iommu);
+	self->bar = largest_mapped_bar(self->device);
+
+	if (!self->bar)
+		SKIP(return, "No mappable BAR found on device %s", device_bdf);
+
+	if (self->bar->info.size < 2 * getpagesize())
+		SKIP(return, "BAR too small (size=0x%llx)", self->bar->info.size);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_mmio_test)
+{
+	iova_allocator_cleanup(self->iova_allocator);
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+static void do_mmio_map_test(struct iommu *iommu,
+			     struct iova_allocator *iova_allocator,
+			     void *vaddr, size_t size)
+{
+	struct dma_region region = {
+		.vaddr = vaddr,
+		.size = size,
+		.iova = iova_allocator_alloc(iova_allocator, size),
+	};
+
+	/*
+	 * NOTE: Check for iommufd compat success once it lands. Native iommufd
+	 * will never support this.
+	 */
+	if (!strcmp(iommu->mode->name, MODE_VFIO_TYPE1V2_IOMMU) ||
+	    !strcmp(iommu->mode->name, MODE_VFIO_TYPE1_IOMMU)) {
+		iommu_map(iommu, &region);
+		iommu_unmap(iommu, &region);
+	} else {
+		VFIO_ASSERT_NE(__iommu_map(iommu, &region), 0);
+		VFIO_ASSERT_NE(__iommu_unmap(iommu, &region, NULL), 0);
+	}
+}
+
+TEST_F(vfio_dma_mapping_mmio_test, map_full_bar)
+{
+	do_mmio_map_test(self->iommu, self->iova_allocator,
+			 self->bar->vaddr, self->bar->info.size);
+}
+
+TEST_F(vfio_dma_mapping_mmio_test, map_partial_bar)
+{
+	do_mmio_map_test(self->iommu, self->iova_allocator,
+			 self->bar->vaddr, getpagesize());
+}
+
+/* Test IOMMU mapping of BAR mmap with intentionally poor vaddr alignment. */
+TEST_F(vfio_dma_mapping_mmio_test, map_bar_misaligned)
+{
+	/* Limit size to bound test time for large BARs */
+	size_t size = min_t(size_t, self->bar->info.size, SZ_1G);
+	size_t page_size = getpagesize();
+	void *vaddr;
+
+	vaddr = mmap_aligned(size, SZ_1G, page_size);
+	vaddr = mmap(vaddr, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
+		     self->device->fd, self->bar->info.offset);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	do_mmio_map_test(self->iommu, self->iova_allocator, vaddr, size);
+
+	VFIO_ASSERT_EQ(munmap(vaddr, size), 0);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}

-- 
2.47.3


