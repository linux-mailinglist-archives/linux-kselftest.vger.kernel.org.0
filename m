Return-Path: <linux-kselftest+bounces-45323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A2C4EA00
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E1918C20EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2516303CAE;
	Tue, 11 Nov 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="EbjVct4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121822F8BEE;
	Tue, 11 Nov 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872757; cv=none; b=WjQYIw+zKt1STEE4jiHi0Rf9himPWNJ2uIwyZoeAuYAH7L5v5gmJAClM8HfGFD5lwOQHVw23WJEuVi0OzpzJVvu2Ug3zJCBscxc5AZGl4gKnHx5vk99MhZzNVE6qvxs0vRaTDTXrHJmMUG66Wi70B1n47pA/eAtIWZ0Igc9GvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872757; c=relaxed/simple;
	bh=cveI6e+XRZtUA4ELFU9FZTPydsO9z748yMb6+miUQ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZxoysltmYnBZifeXpvkMe8Dci5vHtO4x84d/CX2vX+DasuJC0TsFY7oRYbqELCx6IJPczjEpsMrmXHM1q/S7WvKLHgN/+WHrsJLO4U0lhO9YzwoSvtfbVkK/ICW05t2KqFxnx4nqg5DIsK55kM8upZ4/pVumFp9/zHddmkACBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=EbjVct4i; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7SXNH1282474;
	Tue, 11 Nov 2025 06:52:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sEOiaSvVzfpd+hSpNRMwujtxgU5Idw1uQYgrA454INM=; b=EbjVct4iIdCX
	k37YehMnhype00xF14c1i3oC9G5fkj+ITC39M0W8Qwt3wgaCqdrLMTCr5AwcdIE9
	dQPm67HyLRMftrJszGffgMCN2U8hBs/hIriw/A8JrCHdV4H6Gwvo0zJ7q+HnZDQc
	+viHzS2r8csn2BpHZokfaBspZppWROPCMzDve87hhQElq40+d0jfq/Oj2bZrfGD9
	r5Pesxqos9DinavZZc87Wx+ghUiFsDaCz/lmvTr8s+H3s6rsrI2vW5MWTG/MdRD+
	MaPsIECWOGAhCCCZDu4qwkIWRdGRtAcxFRnj8pvN+alTIGmyyRkT84o+ASpT0v0Q
	lSpcHm8C2A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0shadt9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 06:52:30 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 14:52:29 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 06:52:02 -0800
Subject: [PATCH v2 1/4] vfio: selftests: add iova range query helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v2-1-0fa267ff9b78@fb.com>
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
 a=FOH2dFAWAAAA:8 a=GlSvj1RGuABl-Q5FckAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: rCxQo8KyXoD9PzuHyPS0ZRC5NC24Aww6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExOSBTYWx0ZWRfX6q7+DxqGGUNn
 h06a/uEPDL/maGKfhrs/xkKiebUkePj8zaTdxBR3g2V6ScNuFBlJcZz9rBondCddILcxiYBOkNB
 8eWgmPNNyn7ucFc6tf8O9RbenFR1LxWBWyCbf7hvlg2y75sbaUJdd1iwnp2DRIhdtgc/a2ccArD
 Gfg6fIFQFQEaybuelWgKktmx5Q4OSMohQj3HvMkdf5U14njM9PdZsyIwQo1Wu6K7v6kGaG1IIcI
 e0SFD0OmikXnRjNFLkgTrwxIIY6B3hqIW1gWim9IqKae0ME/tY8JsHXcyi+oFxWOWDnHjpKwXEv
 kFw0wsoceTtM/1fb/6JUsnUybHVOa2WpTiQBjbw4Bre7twYnhEk2XT5idDprwLTZTG27IYazjEM
 lnph3lwCLgMaW/kDypxK0nTwaJNz3Q==
X-Proofpoint-ORIG-GUID: rCxQo8KyXoD9PzuHyPS0ZRC5NC24Aww6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

VFIO selftests need to map IOVAs from legally accessible ranges, which
could vary between hardware. Tests in vfio_dma_mapping_test.c are making
excessively strong assumptions about which IOVAs can be mapped.

Add vfio_iommu_iova_ranges(), which queries IOVA ranges from the
IOMMUFD or VFIO container associated with the device. The queried ranges
are normalized to IOMMUFD's iommu_iova_range representation so that
handling of IOVA ranges up the stack can be implementation-agnostic.
iommu_iova_range and vfio_iova_range are equivalent, so bias to using the
new interface's struct.

Query IOMMUFD's ranges with IOMMU_IOAS_IOVA_RANGES.
Query VFIO container's ranges with VFIO_IOMMU_GET_INFO and
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE.

The underlying vfio_iommu_type1_info buffer-related functionality has
been kept generic so the same helpers can be used to query other
capability chain information, if needed.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/lib/include/vfio_util.h |   8 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 167 +++++++++++++++++++++
 2 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 240409bf5f8a..ef8f06ef0c13 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -4,9 +4,12 @@
 
 #include <fcntl.h>
 #include <string.h>
-#include <linux/vfio.h>
+
+#include <uapi/linux/types.h>
+#include <linux/iommufd.h>
 #include <linux/list.h>
 #include <linux/pci_regs.h>
+#include <linux/vfio.h>
 
 #include "../../../kselftest.h"
 
@@ -206,6 +209,9 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
+struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
+					      u32 *nranges);
+
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
 		       struct vfio_dma_region *region);
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index a381fd253aa7..7a523e3f2dce 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -29,6 +29,173 @@
 	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)
 
+static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
+						 size_t *cap_offset)
+{
+	struct vfio_info_cap_header *hdr;
+
+	if (!*cap_offset)
+		return NULL;
+
+	VFIO_ASSERT_LT(*cap_offset, bufsz);
+	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
+
+	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
+
+	if (hdr->next)
+		VFIO_ASSERT_GT(hdr->next, *cap_offset);
+
+	*cap_offset = hdr->next;
+
+	return hdr;
+}
+
+static struct vfio_info_cap_header *vfio_iommu_info_cap_hdr(struct vfio_iommu_type1_info *info,
+							    u16 cap_id)
+{
+	struct vfio_info_cap_header *hdr;
+	size_t cap_offset = info->cap_offset;
+
+	if (!(info->flags & VFIO_IOMMU_INFO_CAPS))
+		return NULL;
+
+	if (cap_offset)
+		VFIO_ASSERT_GE(cap_offset, sizeof(struct vfio_iommu_type1_info));
+
+	while ((hdr = next_cap_hdr(info, info->argsz, &cap_offset))) {
+		if (hdr->id == cap_id)
+			return hdr;
+	}
+
+	return NULL;
+}
+
+/* Return buffer including capability chain, if present. Free with free() */
+static struct vfio_iommu_type1_info *vfio_iommu_get_info(struct vfio_pci_device *device)
+{
+	struct vfio_iommu_type1_info *info;
+
+	info = malloc(sizeof(*info));
+	VFIO_ASSERT_NOT_NULL(info);
+
+	*info = (struct vfio_iommu_type1_info) {
+		.argsz = sizeof(*info),
+	};
+
+	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, info);
+
+	info = realloc(info, info->argsz);
+	VFIO_ASSERT_NOT_NULL(info);
+
+	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, info);
+
+	return info;
+}
+
+/*
+ * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
+ * report iommufd's iommu_iova_range. Free with free().
+ */
+static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
+						       u32 *nranges)
+{
+	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
+	struct vfio_iommu_type1_info *info;
+	struct vfio_info_cap_header *hdr;
+	struct iommu_iova_range *ranges = NULL;
+
+	info = vfio_iommu_get_info(device);
+	hdr = vfio_iommu_info_cap_hdr(info, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
+	VFIO_ASSERT_NOT_NULL(hdr);
+
+	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
+	VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
+
+	ranges = calloc(cap_range->nr_iovas, sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
+		ranges[i] = (struct iommu_iova_range){
+			.start = cap_range->iova_ranges[i].start,
+			.last = cap_range->iova_ranges[i].end,
+		};
+	}
+
+	*nranges = cap_range->nr_iovas;
+
+	free(info);
+	return ranges;
+}
+
+/* Return iova ranges of the device's IOAS. Free with free() */
+static struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
+						    u32 *nranges)
+{
+	struct iommu_iova_range *ranges;
+	int ret;
+
+	struct iommu_ioas_iova_ranges query = {
+		.size = sizeof(query),
+		.ioas_id = device->ioas_id,
+	};
+
+	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EMSGSIZE);
+	VFIO_ASSERT_GT(query.num_iovas, 0);
+
+	ranges = calloc(query.num_iovas, sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	query.allowed_iovas = (uintptr_t)ranges;
+
+	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	*nranges = query.num_iovas;
+
+	return ranges;
+}
+
+static int iova_range_comp(const void *a, const void *b)
+{
+	const struct iommu_iova_range *ra = a, *rb = b;
+
+	if (ra->start < rb->start)
+		return -1;
+
+	if (ra->start > rb->start)
+		return 1;
+
+	return 0;
+}
+
+/* Return sorted IOVA ranges of the device. Free with free(). */
+struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
+					      u32 *nranges)
+{
+	struct iommu_iova_range *ranges;
+
+	if (device->iommufd)
+		ranges = iommufd_iova_ranges(device, nranges);
+	else
+		ranges = vfio_iommu_iova_ranges(device, nranges);
+
+	if (!ranges)
+		return NULL;
+
+	VFIO_ASSERT_GT(*nranges, 0);
+
+	/* Sort and check that ranges are sane and non-overlapping */
+	qsort(ranges, *nranges, sizeof(*ranges), iova_range_comp);
+	VFIO_ASSERT_LT(ranges[0].start, ranges[0].last);
+
+	for (u32 i = 1; i < *nranges; i++) {
+		VFIO_ASSERT_LT(ranges[i].start, ranges[i].last);
+		VFIO_ASSERT_LT(ranges[i - 1].last, ranges[i].start);
+	}
+
+	return ranges;
+}
+
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
 	struct vfio_dma_region *region;

-- 
2.47.3


