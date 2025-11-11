Return-Path: <linux-kselftest+bounces-45358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E7C4F7DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E6674E4BAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2E2BEFF1;
	Tue, 11 Nov 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="QBCrnVQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AD27587D;
	Tue, 11 Nov 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886935; cv=none; b=QDNYr9oePShlnNHZ8GEyGxVD4i7IW5iGpzA3QuyUMZSvZhilgIAK8nw5MJrE8D9yXVk5r4LHBep8oKzsftbQZ3mphl6bdTFUcSfCthFHS41GWn0Wks1yxwFOCdjelmD5aNRpU6/BCMWOHErViVW9AuPZYGTOUda+MgMPwduc7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886935; c=relaxed/simple;
	bh=0XtmbB2SY36i1Pp1D5v4+9obrUNbM8EOQuG7J4fBRoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L476wqj4hdU+L0eGGWKmmpg8dqh43+YYZsjCeNUHvDQQ8WHRqSuZDmBYplisHBRQ2BMVploLhmBsFj2UqBZz+Vw2aOTBwVQGvi7V2crepu3elUW8nzvwHG5su9T6ntZX72zTQz7nOhb6YU42uI95/dziS1/0bT+qU4E8d/gtcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=QBCrnVQE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGKpnR2601076;
	Tue, 11 Nov 2025 10:48:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Utst7KVIWa/F56Scqc+4oMwpIO/MEqYbjt6MntaxnOM=; b=QBCrnVQEtYu7
	yZ/7V2o5x9H61X1g2EhMF81jaPEjYjPY+IOsFosS3DAHPvZklpthpokB23HpSROp
	IagofIYnoEUu7FYYljjXAF4NvvTUHSmLqFrfy2enpK13+qCNudIAS6JQZFa05x2D
	KZsKQ71W4o98eOpSx90fcIqwqezDIrj/AwkAa9F6ZAJobufQ8ZZS7CRmEi6stDri
	jBzin7uI7JhHA5ax/bd7z9oF9oc7NV9MG791+GM/Q17tLhcHlUkfFD1EAodFGz8z
	qyRIIR3a7fZ1aNcg4GP9YoUl9P2QqHxyPFbqI08tBT8zj631Hvuo1uICEMtXw8mH
	Dtsw+JfR9w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac8k51cdm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 10:48:48 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 18:48:35 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 10:48:25 -0800
Subject: [PATCH v3 2/4] vfio: selftests: fix map limit tests to use last
 available iova
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v3-2-7960244642c5@fb.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
In-Reply-To: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: U95uMc45q4D_icKTbdh7aqIt5GWq24e6
X-Authority-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=69138510 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8 a=6z5LghiaB1OvJCA-hK8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MiBTYWx0ZWRfX4GS92S66yklG
 q+5TxHPbxse1w/ISBp81OSII5fVqjreYThq7OZmSvh3dPp/mxnzF/76ujDylkl6uykgvHNQYd+y
 y7XNScq4/l+onPSiLwjrvpHnF4Jb9eH2N6/qHDWq6dxBvKB2mbNxwqOzLbaZzexqyEwSicYWPuK
 M5IWgIomzsBLvGP+ognSp3bXvcbt+SSkiMUIPDQ3eBD3Xx6DOMSX0F5IUsdb1/CeGv1lu9BQR17
 Tn3U+NPH6SU2u6zegIQkdoqxjJNYxvVPlVU5pCgOhhj+xnEbUsE9Xx+4hc9DNAuMLpj/WHVoHtF
 uwhCpn5t5LV1FUVZRr/deYQHlCQCJ2AUD0UBTVSKYcyQn81oIlAoiwLlJ0VwdW6quzl85RdVHAW
 eBpFiglx1Nroe+w5TJA1XuTdEUJ7ig==
X-Proofpoint-GUID: U95uMc45q4D_icKTbdh7aqIt5GWq24e6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01

Use the newly available vfio_pci_iova_ranges() to determine the last
legal IOVA, and use this as the basis for vfio_dma_map_limit_test tests.

Fixes: de8d1f2fd5a5 ("vfio: selftests: add end of address space DMA map/unmap tests")
Reviewed-by: David Matlack <dmatlack@google.com>
Tested-by: David Matlack <dmatlack@google.com>
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


