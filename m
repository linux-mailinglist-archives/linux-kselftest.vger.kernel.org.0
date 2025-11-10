Return-Path: <linux-kselftest+bounces-45256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081BC495E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C73A2DE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA42FB0BD;
	Mon, 10 Nov 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="mpL81Co3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DB2F5A1F;
	Mon, 10 Nov 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809095; cv=none; b=a8w/ncTDd/IvBbPDCg5phhlzM6vPHYZsnrk24v1dTbo1rM3B2SfLIVwEsQn0HEUNMjx5ULKoblktJeYemwWiv2l4QhD4F08aa9hPvAJ4RiVLH5DYvQEk1GetpSz+hds7d/tWBiz5BpaMSn75TnEVPXT4+a537rvWy0qKDW0SmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809095; c=relaxed/simple;
	bh=36NNZlWGkPqCNufWdxA9yUezYpCxoNIBRntN9pC5+hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z0XioFvDOB+HWOw//lWnjKfjElcBwtdnRBoeKF9+Q/dxnE7r/GkiLsk0VKHNbEHQAYb39IaxQnDi0BXZDbeBt5AgeuozBPxV0mwezcUIDctyA8UN/N7ivitR3szmJ7gzmZDVfJekcuzASHLC3gxiZ7v8XWuVVypjlPY6tQ1WrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=mpL81Co3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AAL4UPg3887404;
	Mon, 10 Nov 2025 13:11:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=P2DpALUQ2j1bmgnVxYT9lAMyxIqAk0TLgtPOAA7vWjY=; b=mpL81Co3CD1K
	1EysnhjCRkvXcxgbnbWMWOfp5s6cbAFApbPBhvOSK2Vsl9ur4b/pcY7XKfzEV37e
	X+uFFE4FULytYEWNO+UM/RqAk53H55em/8Vi6OX0G1+NX5mxi65TUrkmPO1mFVwv
	6WWWN/g2aORdlxyM5dV5EkUksCZHEyFNW2MwGEoBSGot8JTCZNy6nKtELtLr+Sbl
	2GgS9rfcfqwYdvQPB705im6HWIYaO4Ih5/0IItacVXDowxi1XUvJQKGw7skn0SLE
	aC3oq2NDPxDvK/1D5xZAAYgqq3OhXgsCVbKEP6tcT/EPqlsvTtsLOc8cjo/t4cJd
	pE5RBKHbrA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4abqn6r1sm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 13:11:28 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 21:11:26 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 10 Nov 2025 13:10:43 -0800
Subject: [PATCH 3/4] vfio: selftests: add iova allocator
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: 4aXobMbUOICBgbezd9ts0KbkJ1TXMpW5
X-Proofpoint-ORIG-GUID: 4aXobMbUOICBgbezd9ts0KbkJ1TXMpW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX7DXWx3a7dXsD
 gjSBWUWTJmozlPqAwjTmZtIWAQUTcRnFDHGV8QSc+o/PxioZVuUNoM9Nqos4k5GbL5W0gcsfwkv
 h5YrXG5mjLeeZvMZ3uPH/gRgnVjIN2Haj185XSMREHEAkPdxHIBNWNTs7VBl650jY0YEt+e0O3M
 jvm5wIA+G07SJQB68dV5YyEEaMB95B5oy1dAjuiOf6a6eIrUqeBbM84TZPwVu1o/KDkIq9WSGYp
 VkSWMrVhLyP2B4xoF6HbRSbC/3ElBnnaTKLFe/2OWj7EJz4tHWb1sZNFUAQFcAYLWojRS1CpAWZ
 +YdER1FOH3iAHZt6ZjC9mbKvUUWbmmZZCLiIT7dq03RbG3r2qnC9R9ZwVB91Q2ZZhWuJGVSuh2q
 DreZfdlGdHrqxeehmkcPXfj+CRhR+Q==
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=69125500 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=FOH2dFAWAAAA:8 a=MOGvrfbzQFtMZxHpfkcA:9
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

Add struct iova_allocator, which gives tests a convenient way to generate
legally-accessible IOVAs to map.

This is based on Alex Williamson's patch series for adding an IOVA
allocator [1].

[1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/lib/include/vfio_util.h | 14 +++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 65 +++++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index fb5efec52316..bb1e7d39dfb9 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -13,6 +13,8 @@
 
 #include "../../../kselftest.h"
 
+#define ALIGN(x, a)	(((x) + (a - 1)) & (~((a) - 1)))
+
 #define VFIO_LOG_AND_EXIT(...) do {		\
 	fprintf(stderr, "  " __VA_ARGS__);	\
 	fprintf(stderr, "\n");			\
@@ -188,6 +190,13 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+struct iova_allocator {
+	struct iommu_iova_range *ranges;
+	size_t nranges;
+	size_t range_idx;
+	iova_t iova_next;
+};
+
 /*
  * Return the BDF string of the device that the test should use.
  *
@@ -212,6 +221,11 @@ void vfio_pci_device_reset(struct vfio_pci_device *device);
 struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
 					      size_t *nranges);
 
+int iova_allocator_init(struct vfio_pci_device *device,
+			    struct iova_allocator *allocator);
+void iova_allocator_deinit(struct iova_allocator *allocator);
+iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
+
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
 		       struct vfio_dma_region *region);
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 6bedbe65f0a1..a634feb1d378 100644
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
@@ -190,6 +191,68 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
 	return ranges;
 }
 
+int iova_allocator_init(struct vfio_pci_device *device,
+			struct iova_allocator *allocator)
+{
+	struct iommu_iova_range *ranges;
+	size_t nranges;
+
+	memset(allocator, 0, sizeof(*allocator));
+
+	ranges = vfio_pci_iova_ranges(device, &nranges);
+	if (!ranges)
+		return -ENOENT;
+
+	*allocator = (struct iova_allocator){
+		.ranges = ranges,
+		.nranges = nranges,
+		.range_idx = 0,
+		.iova_next = 0,
+	};
+
+	return 0;
+}
+
+void iova_allocator_deinit(struct iova_allocator *allocator)
+{
+	free(allocator->ranges);
+}
+
+iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
+{
+	int idx = allocator->range_idx;
+	struct iommu_iova_range *range = &allocator->ranges[idx];
+
+	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
+	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
+	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
+
+	for (;;) {
+		iova_t iova, last;
+
+		iova = ALIGN(allocator->iova_next, size);
+
+		if (iova < allocator->iova_next || iova > range->last ||
+		    check_add_overflow(iova, size - 1, &last) ||
+		    last > range->last) {
+			allocator->range_idx = ++idx;
+			VFIO_ASSERT_LT(idx, allocator->nranges,
+				       "Out of ranges for allocation\n");
+			allocator->iova_next = (++range)->start;
+			continue;
+		}
+
+		if (check_add_overflow(last, (iova_t)1, &allocator->iova_next) ||
+		    allocator->iova_next > range->last) {
+			allocator->range_idx = ++idx;
+			if (idx < allocator->nranges)
+				allocator->iova_next = (++range)->start;
+		}
+
+		return iova;
+	}
+}
+
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
 	struct vfio_dma_region *region;

-- 
2.47.3


