Return-Path: <linux-kselftest+bounces-45255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19966C495EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87C71887C3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000B2FABE0;
	Mon, 10 Nov 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="BW5fBngo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520D2F5A02;
	Mon, 10 Nov 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809095; cv=none; b=BNsvrNgQN1axG+AYZvebVVsz/nvAxTSvlzHQ/g5r75pVElYoB8Wdttx+p70ge38T5to42mTIsbh2NRDa7PbrDn4FARIbuj2eSs5wQu+rNkU+jwyi3oD2qiDyQXljg5Ha9BGi8uIT+TcHovH3IlBQ+jODmUHUVHOPu21G8OBTNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809095; c=relaxed/simple;
	bh=NaPTNEHpV6A0u993PlaIXhUmsY18jZ4WOH4BpYu3Zp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MHINKHBAEnY4VjptV7Kg7RpdADWsmu9Z1IiKBzXpdlq+YHONzsAtDoRJdQ6vSJTEB0He2E/6rwYeux01sBSX7MUUQP/5WqEM1IQlmQkq2Sin10+edFnQanUGJMxFnyPDLf86Vlu98q0lPmmu2peNLrW6lkgBESwIUY1VfxT/NA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=BW5fBngo; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AAL4UPf3887404;
	Mon, 10 Nov 2025 13:11:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=kXIomevZxcHatDoppWvHoctejlEdcrJSBgRRuUN+8rA=; b=BW5fBngo0q9t
	j4EryAe+KtqLn5BfwMKimUn/Khy9Kg+taT3JOq0pvVXzFLG59IIq9ow5ctCCa2u8
	eVDznCuKbtRJD5pAd8vSWz9zqornQishkmLFgZYHvVbzY2KfSR8TdjqQGVqla0jK
	gB7BbHnGsaQyqljtumI6UGpIVsFZI+i+mdB7gdPttV1UZJS4GVG9ihVWLKJJ31Xe
	TKarByoUza+FShcjrp/MzXqwopknHhEYYCGOB61i6hAhaPwT4xeCwJZvhRUyfg6J
	enJMnplrh7soCxI5JgjdcVZDP2+PRxU7YUme8Gif2jfQh3Akc6ubRo1z3hj0VC2/
	INPsVbWhxg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4abqn6r1sm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 13:11:27 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 21:11:25 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 10 Nov 2025 13:10:42 -0800
Subject: [PATCH 2/4] vfio: selftests: fix map limit tests to use last
 available iova
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: 38qHkLTYQuudBznWeH22BTDbfBxzTEsr
X-Proofpoint-ORIG-GUID: 38qHkLTYQuudBznWeH22BTDbfBxzTEsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfXxBsPC1t0w+G8
 OymGgB+QoaIOCDK0Mp134dqYtMhKoDpEllgK9jWLG7f7dJRtlXhz5GL9RJCuTBXHUag/iaqqSgf
 X+UASP64SLncGpwYc8VkUpbnTjB8GM7Z+W/5ESt8pKxzKdfrhZJhNec2Yd7Aq4+7sz49xEj6VOS
 1wGlnVcniI1UxTuLu/kIglSV/LWyu+i0Al8vFmST1FY23F3DIbP60yKw1Ty+c2sGAq08A8TMkw1
 0YRYEI1IRsRwh0GAtGZ6oi/l29Y9f66IRolycldHT5ghYLCBpds1MvUOO42uRq+q1tqinhRPYTM
 P9+8GoiCdBCSehuS1SbkU76VqjgRKOD4UOoaGjK+axWUMoYPExwbVwHXH2tDA8xl9YbNzOi5Uyg
 2d5CHpO8/DB6CX9C48MlL50/fodWvA==
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=691254ff cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=2r72hCCS2uxvEu3KRW0A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

Use the newly available vfio_pci_iova_ranges() to determine the last
legal IOVA, and use this as the basis for vfio_dma_map_limit_test tests.

Fixes: de8d1f2fd5a5 ("vfio: selftests: add end of address space DMA map/unmap tests")
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4f1ea79a200c..37c2a342df8d 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -3,6 +3,8 @@
 #include <sys/mman.h>
 #include <unistd.h>
 
+#include <uapi/linux/types.h>
+#include <linux/iommufd.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
 #include <linux/sizes.h>
@@ -219,7 +221,10 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
 FIXTURE_SETUP(vfio_dma_map_limit_test)
 {
 	struct vfio_dma_region *region = &self->region;
+	struct iommu_iova_range *ranges;
 	u64 region_size = getpagesize();
+	iova_t last_iova;
+	size_t nranges;
 
 	/*
 	 * Over-allocate mmap by double the size to provide enough backing vaddr
@@ -232,8 +237,13 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(region->vaddr, MAP_FAILED);
 
-	/* One page prior to the end of address space */
-	region->iova = ~(iova_t)0 & ~(region_size - 1);
+	ranges = vfio_pci_iova_ranges(self->device, &nranges);
+	VFIO_ASSERT_NOT_NULL(ranges);
+	last_iova = ranges[nranges - 1].last;
+	free(ranges);
+
+	/* One page prior to the last iova */
+	region->iova = last_iova & ~(region_size - 1);
 	region->size = region_size;
 }
 
@@ -276,6 +286,9 @@ TEST_F(vfio_dma_map_limit_test, overflow)
 	struct vfio_dma_region *region = &self->region;
 	int rc;
 
+	if (region->iova != (~(iova_t)0 & ~(region->size - 1)))
+		SKIP(return, "IOMMU address space insufficient for overflow test");
+
 	region->size = self->mmap_size;
 
 	rc = __vfio_pci_dma_map(self->device, region);

-- 
2.47.3


