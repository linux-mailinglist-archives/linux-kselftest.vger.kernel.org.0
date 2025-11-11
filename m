Return-Path: <linux-kselftest+bounces-45359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8233C4F7E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9893F4E431A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B62C21CF;
	Tue, 11 Nov 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="qAeKtTh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22F27CB35;
	Tue, 11 Nov 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886935; cv=none; b=TSz8BobnP7l4EHGQ8O+xaIJXL1zZeTqaOKvqHNvW03DzKJM8bMcMqxc32CmrRl1Vmo9YlkjNVeA1pWFAZ3zSP4I3YKW+8A5IYIKSHsHvCTMEB9EI0lnjjRYA+feuXh6vzWUud0gG5iIPORPGNkEnz4/MtcezBoSK6BdaTrEyudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886935; c=relaxed/simple;
	bh=nc+DGgEqQfqQz5WzZ4XaxStY2EfWbuj1ZktOUW2kh9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tYg3UgortVy5pGZ9K6/fNMqZOVm6LRozJq3eXAfD8TA8HOdng/3UQ8qqxpf/rUcoeOx177mbEPwdFmP1X0Rlj9M7zDCmWpxyzfgF90GiPlWoFRpBrGqFcwY7KmcVeJondJrkscGdrYeAiP8GJGkCmPZWyAiI13/0WWHymbUEy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=qAeKtTh1; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGKpnS2601076;
	Tue, 11 Nov 2025 10:48:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wT30skF+U4U+/Fon2QsJc9vYCx3RS/iEPGBkESiFPUI=; b=qAeKtTh1NEvI
	VwnjEsDB+lJfKepY8VJAr6TRkdp7C8gb0BMLQ1cwkSHICsHc2ouBoxY+QLp2vLZ/
	C6BT5dfZsTsAhTqrfOS/aM6FGAmuLCSrheJAxjBmHBFx0uQaSMbUBjZe6kgfv5jS
	fyOfHtD1630szrc663JZ9Z1rHdGd/GH2Lcd19+oaq/6Jd1C2Whb74QP0FIGoxyjf
	ovYGeMc7k3SV0tbcv8UrGbdcHWWe8pXFM32fHwFMScr00f6eD0iPHuaQ21I6O2KP
	vgIrWQhonCj7+tTuMlcEObUfd6vabBWWW7Mmxdqj+sbqkzE/7tOsCTxnhR1JFc/d
	DrWXMkprrw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac8k51cdm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 10:48:48 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 18:48:35 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 10:48:26 -0800
Subject: [PATCH v3 3/4] vfio: selftests: add iova allocator
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v3-3-7960244642c5@fb.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
In-Reply-To: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: 2PAs8tZLOXpDvgQvUYHO6SzQf2xuh9XW
X-Authority-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=69138510 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8
 a=9tNaKRM82XbWTj2lM3MA:9 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MiBTYWx0ZWRfX9ceOUy2+PZmE
 EzN23uOAgKeRjnIgItWl5oHNXF3eZ45ohX7sDBId7tGkWf4t9hpmoW7qj2rHc9ER9V/fFptdlZy
 Jc3gk75jbSmf2sBiLs1pY49YY1i/qAY+uXpg+e5sEYFDG+yZbONoAVQvWP5xTAjsH3KXJX2HCke
 AFUcv5NiDXLYwagmHx+MFWWmWdnK19NSyLVQG5T2sPDT4i3EhLNHno0xjFwTNBRP8AmhbSd4oeo
 srT2cQdBZzqNDWpI5dAVQ34pitoMK2cAisQKepp+rUiTmpEaK9uf1RnF5GEF7xt0jJTSbOV5ubQ
 MFMt2HGqMTUl+INOVfMHZ4fjPMC2LQXFvrv/R6M82BTcr5drD4auOxLufJKmG4UFq0shvnblSxz
 xzpTdX2I1wvcO9p0v8jJvUwsKvHQiA==
X-Proofpoint-GUID: 2PAs8tZLOXpDvgQvUYHO6SzQf2xuh9XW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01

Add struct iova_allocator, which gives tests a convenient way to generate
legally-accessible IOVAs to map. This allocator traverses the sorted
available IOVA ranges linearly, requires power-of-two size allocations,
and does not support freeing iova allocations. The assumption is that
tests are not IOVA space-bounded, and will not need to recycle IOVAs.

This is based on Alex Williamson's patch series for adding an IOVA
allocator [1].

[1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/

Reviewed-by: David Matlack <dmatlack@google.com>
Tested-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/lib/include/vfio_util.h | 11 ++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 74 +++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index ef8f06ef0c13..69ec0c856481 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -188,6 +188,13 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+struct iova_allocator {
+	struct iommu_iova_range *ranges;
+	u32 nranges;
+	u32 range_idx;
+	u64 range_offset;
+};
+
 /*
  * Return the BDF string of the device that the test should use.
  *
@@ -212,6 +219,10 @@ void vfio_pci_device_reset(struct vfio_pci_device *device);
 struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
 					      u32 *nranges);
 
+struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device);
+void iova_allocator_cleanup(struct iova_allocator *allocator);
+iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
+
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
 		       struct vfio_dma_region *region);
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 11749348f53f..b479a359da12 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -12,11 +12,12 @@
 #include <sys/mman.h>
 
 #include <uapi/linux/types.h>
+#include <linux/iommufd.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
+#include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/vfio.h>
-#include <linux/iommufd.h>
 
 #include "../../../kselftest.h"
 #include <vfio_util.h>
@@ -201,6 +202,77 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
 	return ranges;
 }
 
+struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device)
+{
+	struct iova_allocator *allocator;
+	struct iommu_iova_range *ranges;
+	u32 nranges;
+
+	ranges = vfio_pci_iova_ranges(device, &nranges);
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	allocator = malloc(sizeof(*allocator));
+	VFIO_ASSERT_NOT_NULL(allocator);
+
+	*allocator = (struct iova_allocator){
+		.ranges = ranges,
+		.nranges = nranges,
+		.range_idx = 0,
+		.range_offset = 0,
+	};
+
+	return allocator;
+}
+
+void iova_allocator_cleanup(struct iova_allocator *allocator)
+{
+	free(allocator->ranges);
+	free(allocator);
+}
+
+iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
+{
+	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
+	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
+
+	for (;;) {
+		struct iommu_iova_range *range;
+		iova_t iova, last;
+
+		VFIO_ASSERT_LT(allocator->range_idx, allocator->nranges,
+			       "IOVA allocator out of space\n");
+
+		range = &allocator->ranges[allocator->range_idx];
+		iova = range->start + allocator->range_offset;
+
+		/* Check for sufficient space at the current offset */
+		if (check_add_overflow(iova, size - 1, &last) ||
+		    last > range->last)
+			goto next_range;
+
+		/* Align iova to size */
+		iova = last & ~(size - 1);
+
+		/* Check for sufficient space at the aligned iova */
+		if (check_add_overflow(iova, size - 1, &last) ||
+		    last > range->last)
+			goto next_range;
+
+		if (last == range->last) {
+			allocator->range_idx++;
+			allocator->range_offset = 0;
+		} else {
+			allocator->range_offset = last - range->start + 1;
+		}
+
+		return iova;
+
+next_range:
+		allocator->range_idx++;
+		allocator->range_offset = 0;
+	}
+}
+
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
 	struct vfio_dma_region *region;

-- 
2.47.3


