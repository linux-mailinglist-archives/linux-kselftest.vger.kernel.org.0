Return-Path: <linux-kselftest+bounces-48971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BFFD20EFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E504C303E0D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEF33F398;
	Wed, 14 Jan 2026 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="oE40xB4n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20433BBA2;
	Wed, 14 Jan 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417053; cv=none; b=aKdb079W+JcICo6wXTT9wnSiNMiZCuumoFZJkEE2BFwDsZbAm2Ptkoa0ArIRPuJG+PHaRCZApkwAIglg3iSvSQrmLtn89lvhegMiShA9YMrqTasaIeL1ob/83oj291bmVltyNlWMZxgtdfb4qEopioQYFt6I4T9Z9PmQH4qw1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417053; c=relaxed/simple;
	bh=qq3ABdRRAf3UMfh0KNPmif3pDMNMB+3JTB8aQ1mC3Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a0SM0T8PtcOHGmZm83ktoo6AzzqElg2MuolayNwaPWgtpBe1AYElIYnfyvk8sS8OEetNF0alC+ZzxBCSfGWMNbPDPeHryepmZ33CKyJH6S53ixfGbZUTAxrTYgUgbf3PAqJkdHj3jsxUvSlHhLNXO9fNZkFx61cSm+l7T7d3cVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=oE40xB4n; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHQReJ2373504;
	Wed, 14 Jan 2026 10:57:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OoGfnppMNxMZ1o1XcxdaXDrCrbXqUXsRS4QpCZFQ0vs=; b=oE40xB4nAyWa
	9RRsAAIYTmdi7b1Li6Gw2wmtHP/P/jK0Jf2F1MvN9yeGTcRAscISaHC0Y/iULxqV
	lFxyCqqob6EWQ/wqVQtYXzzWphbvdxDeiyADK9W+bW7jsQE20367zUHUPME8Zfzv
	kh6yC9qPuKXbv2ePyv7y2o4l9J1RQqnY9eExvrCNFa3OjD1YLZx8nO1rZoK97E5i
	OQBBVADpR9daJS+DKoUNALEugbgSmi2QukdEy9vXHiHwjpGG4YE0Yc7SG/zERS80
	hV3QSjWrHxpfOjyryw4dJf5LBv9jp9GU0xLdqVD8q9964QTspromQcu++5AoBdIr
	ZL1rgeJ1uw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bpactbmre-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 10:57:24 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:57:22 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 14 Jan 2026 10:57:18 -0800
Subject: [PATCH v3 3/3] vfio: selftests: Add vfio_dma_mapping_mmio_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260114-map-mmio-test-v3-3-44e036d95e64@fb.com>
References: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
In-Reply-To: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: vvasFR4N2RaAG4aoW_dVVaCbAdy_oc19
X-Authority-Analysis: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=6967e714 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=FzPllQ_cktK6OXWCqgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vvasFR4N2RaAG4aoW_dVVaCbAdy_oc19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfX2cETnFHpQd0J
 ISgfZtmz/DNq43fzY6wa2sIQwhI5WqT8qdys3Kq8vieoQr/w3TtPwZ9UmRzgogCuvCfb9ztu+Qr
 msLFPdATpK4Ug4pZvZvMcLrPY60eVUC5DdEUHsxuClf8nqirqx8g3+/RFPMheWLSdwUsYxzoX4g
 pkqMyehaC/uDiGAwZfhRbLOTgt4chXIv9YjlsuiyUK2lw5LrRubE3imptff+X2iJ74+EnYe8RZJ
 2gRY06cf1Z3MTM9RH5Z1lsPfOalp34sEDq8GNH07au+trd52O9QRKinSrA2HrESHEfhi8JALv2M
 8qmw62XbvU/Cf+RHWpPExr9C5blS1v2ltdZqxUeBg2fBxEFkOhkddoan5oYnG+oog7/9uexsexx
 5W/mQpyw4+Skue5FtkXxhEIZAaislfx2xQwxyy1CF9Ysx+/wyHjni53+Rpb+Bk2kbJQ6NSyR26m
 o7aKgxvxyqIRYfdodsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01

Test IOMMU mapping the BAR mmaps created during vfio_pci_device_setup().

All IOMMU modes are tested: vfio_type1 variants are expected to succeed,
while non-type1 modes are expected to fail. iommufd compat mode can be
updated to expect success once kernel support lands. Native iommufd will
not support mapping vaddrs backed by MMIO (it will support dma-buf based
MMIO mapping instead).

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/Makefile              |   1 +
 .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 143 +++++++++++++++++++++
 2 files changed, 144 insertions(+)

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
index 000000000000..957a89ce7b3a
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
@@ -0,0 +1,143 @@
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
+	if (self->bar->info.size < 2 * getpagesize())
+		SKIP(return, "BAR too small (size=0x%llx)", self->bar->info.size);
+
+	do_mmio_map_test(self->iommu, self->iova_allocator,
+			 self->bar->vaddr, getpagesize());
+}
+
+/* Test IOMMU mapping of BAR mmap with intentionally poor vaddr alignment. */
+TEST_F(vfio_dma_mapping_mmio_test, map_bar_misaligned)
+{
+	/* Limit size to bound test time for large BARs */
+	size_t size = min_t(size_t, self->bar->info.size, SZ_1G);
+	void *vaddr;
+
+	vaddr = mmap_reserve(size, SZ_1G, getpagesize());
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


