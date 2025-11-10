Return-Path: <linux-kselftest+bounces-45257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F81C49602
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9253C4EE51C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B52FB624;
	Mon, 10 Nov 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="BJYhiOwb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769A2F5A28;
	Mon, 10 Nov 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809095; cv=none; b=in4ec17bcDM+hxkswQE1nn9tn5DaLvkaS2qHh/y/UfR94bCd/sPSEThE2+2TuKki/v096PKUv/Hkeu3kSAUfcVo/i5sbD0B5FJI2rk8Rfd0K5i4NUn54oX2zsKWWx3oJycdYWiSG3AzV8SrwGkCqlDlkL6BXc40VSj7SYbHa2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809095; c=relaxed/simple;
	bh=kr7TNcA6znn4hBDQw09hIZoDi92UBEe1+B+3Ft72+sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oWiNbw1TeiWy+hn6Qce3OYaZaQMLyES+Qwrsgk8LCcecQJ++/RiDhKCO6b86D9rhKhUSMQcjCDwJiJzVYVvs8Z/HzXrq4lZosYQSMXPUux+CmNT+d8z8bn5h8qs0mbHBPHoMsNY8ZLlGn36Cq3Pyait1IsOXoX5dw6dBNT7sp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=BJYhiOwb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AAL4UPh3887404;
	Mon, 10 Nov 2025 13:11:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Gs0ephI9j2wqu8FIW7DJqlGCeZ/KcGtqWuvPSKl7wyw=; b=BJYhiOwbisGq
	EcprymVaYGXx88vaJvSuXQBNVtF/75l5Wj8tB6HYqTXmVr88vVYlBcEb9v3LTHpa
	3fmhO6lYHmUCQ8ltjoIhSUysIqHFjpPV/H9VXEg2EVkjDxiDwQjXQUZNoWjnpNwo
	PJkiJOF+JPfDJTy0AcubXBRQA7xwBeyAkhVIf3jHwr/ybFd+z4cjxMsB3zYEZ9DD
	YXfC84TP4cjMPN/H9u3Y9qqmuhN9JGPSZgvOrjgLG3rbEQh1oHFDnvkzvslrm9zV
	gGR9AACBd0rT9zIjGQKY9MktBYfL2zlzRbayQYO9+VE4wYc+0StKsyVvDnnM8K6Z
	KRmrGfBpoA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4abqn6r1sm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 13:11:28 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 21:11:26 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 10 Nov 2025 13:10:44 -0800
Subject: [PATCH 4/4] vfio: selftests: update vfio_dma_mapping_test to
 allocate iovas
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251110-iova-ranges-v1-4-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: lvdlIAQToOLsUDI4LVfhZfEaKiyuBaFI
X-Proofpoint-ORIG-GUID: lvdlIAQToOLsUDI4LVfhZfEaKiyuBaFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX3XmhX0h2FzJI
 KwEmpcu9VCHb64N4RZsZW486KzxhXPieNsDukT/A+ZN/pnTJGMVqyO4YnTg1ivP0iW8ZmCCJAw9
 JbVJ4bvTA4TAOrMlxCjEwvmHFGxkeH/e7aCkQqrxzv8D1g42qlCO5K2gq7GPQI223DpWR45A049
 /Y+GJK5OcrmjMB2+aBAPizixpNPOhKkO45EAGgRP99Gq5M4n1dfFvKSlzRypjBxf53wwV9HA825
 nFtmqKfHEII1LAblY/SaxVXIG7E5PqKEJeOZk8KHW0Fi6yZFNTOnp/IEOzaj77gms1FRN8RtbZM
 Tj0koy95wC5S+R66k/glX/vZwws+x/0+QivsagFw61gcXT79uIMYY6BQXu924u8DXHQEltKZeAs
 H4h5nW+Razf6d7qG4sq59L88sD11hQ==
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=69125500 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=GKGmy9NU5bqHy5LlMbcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

vfio_dma_mapping_test currently uses iova=vaddr as part of DMA mapping
validation. The assumption that these IOVAs are legal has held up on all
the hardware we've tested so far, but but is not guaranteed. Make the
test more robust by using iova_allocator to vend IOVAs, which queries
legally accessible IOVAs from the underlying IOMMUFD or VFIO container.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 37c2a342df8d..c1a015385b0f 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -95,6 +95,7 @@ static int iommu_mapping_get(const char *bdf, u64 iova,
 
 FIXTURE(vfio_dma_mapping_test) {
 	struct vfio_pci_device *device;
+	struct iova_allocator iova_allocator;
 };
 
 FIXTURE_VARIANT(vfio_dma_mapping_test) {
@@ -118,11 +119,16 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
+	int ret;
+
 	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	ret = iova_allocator_init(self->device, &self->iova_allocator);
+	VFIO_ASSERT_EQ(ret, 0);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 {
+	iova_allocator_deinit(&self->iova_allocator);
 	vfio_pci_device_cleanup(self->device);
 }
 
@@ -144,7 +150,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	else
 		ASSERT_NE(region.vaddr, MAP_FAILED);
 
-	region.iova = (u64)region.vaddr;
+	region.iova = iova_allocator_alloc(&self->iova_allocator, size);
 	region.size = size;
 
 	vfio_pci_dma_map(self->device, &region);

-- 
2.47.3


