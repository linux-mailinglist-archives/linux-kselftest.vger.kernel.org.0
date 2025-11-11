Return-Path: <linux-kselftest+bounces-45324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14744C4EA50
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 994124FD54D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639C30FF3A;
	Tue, 11 Nov 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="QpPymCyv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A32DCC04;
	Tue, 11 Nov 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872758; cv=none; b=azkFqdpGl3WAW1VqDj1KpbOnY1gN8QNRuDlYAuozLb/QPg3c1mnjRYGCSPsT68M/5Gghi4Fvkr19Tt7r402ZxpGj+DntBTi75c+qkFYQGUVYHF/dRjg7zbZyTz69xoO6aBSKNQYGmjL5rZFE2WwUXwmW1NeU48R2UEpeRN7Zn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872758; c=relaxed/simple;
	bh=2gk6Lgwb9ciOn6mgd/GeO4X6ZmYktuz1kT1SX9M7haM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ltt84lWfJEXqUWZICpdjG6B2dnPvJPMJzmGtAaXy1J0MLaBdbX0zfNjAyy+DoJi+3ePE1QsZZtPX//RB3urgr/psVe0lo3+RXjPE064XXO+OLK9POeni1pM61BifcF9wYWZYSk8Fq5cI9KGIE5PLZb+QAT9aPlsBlldhKcsRCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=QpPymCyv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7SXNI1282474;
	Tue, 11 Nov 2025 06:52:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=V+eeGZWAGviVYfF/KZNUFNM+nih9w63Wwi9agXNGmio=; b=QpPymCyvwXn3
	7wEWBSt78czivy+ETfIkfoB/et+UCkNo+FUEtUU3G6PNB241ChPzd2c3WqVZwaAp
	XXCbT+8ndTpYGBSFHI5OAb6LKO51wdPp/CYxj2a4geHFHZR1qm5+oi5xQ9xUcRGL
	NQyIa1WJMBeVYmC1/2zcQA9d/fKm7t8W692/1g9xGQzm4A1XpzKzBBetqdtKHRcc
	YFg/Tj3jwQb1DtqDB744uw50X1Sww6a/Cx3O3LgUdYuvgP2odLpliR7WcnCeeyUN
	G3hl3sg60WyF9q2oR2J45wlOJ1PBQL7wkpQbUdRyLR7GRKA/kYeVLg7cioBvTkJr
	9yiH38rXzw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0shadt9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 06:52:30 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 14:52:29 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 06:52:03 -0800
Subject: [PATCH v2 2/4] vfio: selftests: fix map limit tests to use last
 available iova
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v2-2-0fa267ff9b78@fb.com>
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
 a=FOH2dFAWAAAA:8 a=VoiLvOrikwrOPNCf7twA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ybIUioFS8mDL99FNbWxCBBn06QskcB0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExOSBTYWx0ZWRfX51J8btF0AG84
 1qTOOQkX43d+h0YA8Ar/FHcELzJ4xCOrqMJbZ5SjgW6dWMun9tWZuvWIExHprhjmyi8ibXbErHR
 SHXb/xq0FIPHK+mOzqUGF3g/jy3sALKqFIZq/x0eRQQkcL+922CZOGTmj7o7eZc5uFtrzsmEvvT
 pOStYji7AoMYOiP5dZ0YzPGUJg2BYHqiAzIyNxZjKedfsbp/jx9imNjXxZ36o6VOFy+rtu6bsxW
 q+E+khvDOFbdlfP7K16M+Sbw/9rtcUPg1vNxGNlGBhFiVNvjLqtSUUQIVyQfw1QXptbk2dw8TJi
 eHKgi81mu5oKgwssW7gAk84yjVqvHnpRbMnlp+fc2Zks5QgfUxs+HA9ERblpT8wWOyAtGxIZOvm
 AQMO9L9apk2SoLkokG0uZ4d0gXQaQg==
X-Proofpoint-ORIG-GUID: ybIUioFS8mDL99FNbWxCBBn06QskcB0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

Use the newly available vfio_pci_iova_ranges() to determine the last
legal IOVA, and use this as the basis for vfio_dma_map_limit_test tests.

Fixes: de8d1f2fd5a5 ("vfio: selftests: add end of address space DMA map/unmap tests")
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4f1ea79a200c..e1374aab96bd 100644
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
+	u32 nranges;
 
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
 
@@ -276,6 +286,7 @@ TEST_F(vfio_dma_map_limit_test, overflow)
 	struct vfio_dma_region *region = &self->region;
 	int rc;
 
+	region->iova = ~(iova_t)0 & ~(region->size - 1);
 	region->size = self->mmap_size;
 
 	rc = __vfio_pci_dma_map(self->device, region);

-- 
2.47.3


