Return-Path: <linux-kselftest+bounces-45325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC0C4EAC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D591A3BDD37
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7EE3246E2;
	Tue, 11 Nov 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="3Z2hhjTl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6728D829;
	Tue, 11 Nov 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872758; cv=none; b=iaxGpY0bgccrz3nIOAz8CdX9/EcX3Dtq90TcObSxOpV/9Phwbmj5BdpMUNiOgygm4kqZvqfuTgk+oLgefKfEkkPcbYn3DYo7HBpGakSeV3sDUUbbvu6ZcxUBVZNtSI0WJHgz7+/Vbma1VgsknfgfDTKlsyYH/lmo90nYYUCnaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872758; c=relaxed/simple;
	bh=VhDxEgPasP8lYcHW4kqVTS8L3eb6Y4YGcg+MMM89DkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aqdzpqV749Q3cw+O72km+xqUFqSISie7kqQN0T0Q3REEmI2LfeHnk7bsKKnJ+TORA8lyFg9okPx/85AKsf+wxdiTcS6fo0E30r4w4IxLMPIf4sE80Xd4wHTmC52F6WY/1MnsnGswQRqG2f0f/xXyEO7T1FysHUZzN7SzqbhFdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=3Z2hhjTl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7SXNJ1282474;
	Tue, 11 Nov 2025 06:52:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4ZaUVck6S6J48bKwbMsq4gVF+BpB0wOt3hBiWKgOrPw=; b=3Z2hhjTl4oIW
	46KZEOTc7kT9U/ZKxSRsFFqAWcauL2nq+ARfDhwq6birPXMz5rEStPfA0hqptcWQ
	Xqezqg16hhvlJ+B2irkRyRbgox0zpq9DxYpl9TDk8HrwfJgY0oM02ptWiED8BLNP
	FGq4/aoetdKgCotuxS2gqAP6mmy2mFRdl1kVsCTO3wUKUHO00H4HypHV4hohIQcx
	UtoQCGThPGmpG6yPorCFxHkp5pylLKGYBPk0RnhpPL+tJXiOkh2EEWwe+3+GtDYM
	tGyeeY70PAwMGX1zM7Mge4HD9zEZLyvl8jmYssC9dfip04iQtvuqf7AXnXaiWIQ5
	UPNrIr87/w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0shadt9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 06:52:30 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 14:52:29 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 06:52:04 -0800
Subject: [PATCH v2 3/4] vfio: selftests: add iova allocator
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v2-3-0fa267ff9b78@fb.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
In-Reply-To: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=Pf/yRyhd c=1 sm=1 tr=0 ts=69134dae cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=FOH2dFAWAAAA:8 a=jdgmLsG8W1E4BNsLh0EA:9
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: YEFXIK-Mia_QKM5caj7scJhaAcB7zsiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExOSBTYWx0ZWRfX5qdHqNwDnwzu
 n6prwavDGeRM0Hvx2U9d1uqmUudd6ykFlI3UUZzMJ/Pu8pImNKctfL4oFBjQUzmeZaQYzUFvGqE
 wHZBJivHJc2M14J6MRuCrBI0BLNAOJL0p/UUX7PzlWlaHlu7l6VLwJ1/L3zsgqfcoQ9CHRpX95O
 PxA9DUB265VbbcPihLEAznX3N4x0e70rAN91o5t1T2GYKj8yep3np1Kh2Q0aeszcEMqC6Lbs6f1
 tk4Jg9ezrYoyXMoI0kay5Ffi6oPmGVH0X32DzY9DDIcLFNrGiwrxj6aIboc3swB0UdJKEuGj/Hm
 k5xdt8c1OqtXwZ0O5xT3tMlUr0opBJbWiUaRsuGZzPXbQH5SuJ4W+H0NYxmvWDth9Qv/XClkg7h
 cldegDLMQBl9T/7g3LGvULmYl4A8og==
X-Proofpoint-ORIG-GUID: YEFXIK-Mia_QKM5caj7scJhaAcB7zsiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

Add struct iova_allocator, which gives tests a convenient way to generate
legally-accessible IOVAs to map. This allocator traverses the sorted
available IOVA ranges linearly, requires power-of-two size allocations,
and does not support freeing iova allocations. The assumption is that
tests are not IOVA space-bounded, and will not need to recycle IOVAs.

This is based on Alex Williamson's patch series for adding an IOVA
allocator [1].

[1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/

Signed-off-by: Alex Mastro <amastro@fb.com>

---
The unfolded code uses David's range_offset suggestion because it makes
assignment of the updated state simpler when crossing a range boundary.

No more ALIGN(). The insight is that the initial check for sufficient
space (pre-alignment) requires computing

last = iova + size - 1

which is already half of what ALIGN() does. Just masking is left.
---
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
index 7a523e3f2dce..ff1edb11747a 100644
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
@@ -196,6 +197,77 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
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


