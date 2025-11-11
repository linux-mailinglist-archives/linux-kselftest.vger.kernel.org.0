Return-Path: <linux-kselftest+bounces-45327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D5C4EA3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 691084F3DAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0B334691;
	Tue, 11 Nov 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="iJtLqPsv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4A3054D7;
	Tue, 11 Nov 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872760; cv=none; b=ld1tu+O64KUuqKsgSv9vek9GwzdbjNcs0UwTZcMcipWWkCORi2cw792fIO4io2gRILE/sVYeh812sjMOUSKyscUiJiwaAH7ai0bNEk0f+4etZE2mj5mzlq8ENQT4SdGLbedoFZcUyvgppeMXGkjUdgYqvU5WGLNtEZXctG6oJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872760; c=relaxed/simple;
	bh=IgaI2VllyJmFtyZAxQUSXs0BSulng0Rn09jr4Zjxryo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DDErdvxz0Vukqg4BVSP+wrVr8rFheJuYT/xQAso6F9MfDr54qkuAbOJR2unCXGXKOg2W0DrKXe1sU90rrDFw1cxTJpVxlAR8wuSxvBMD+hGIOKcKpzTvo5JY+3UsFRH1WZf+wB2a0plaaI8Pu2FWO4SzXwxqJtni19ruT1xjOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=iJtLqPsv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7SXNK1282474;
	Tue, 11 Nov 2025 06:52:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=n/YAbbC01iMLaoR4MVMLequGIlh29d4NC8TUXJnvea8=; b=iJtLqPsvM7we
	hCmm9C8NC7asUW22Wm3LP6ZTwXV49aBCBF6tFy+3nLTo9uWgBlXNgp5lBR3gddeQ
	SDubhk0vmh8TDMkrDc73OSouYCy6MoQoo2n6Mkowaximu4xNV6Z2P2NPcWs+jqla
	No2t9ZqN7b1oyf19rSkYCWH16xHKQaaqgQOEtImB7FxdBUeh60FHi9zH8K5yJD6q
	z0JnXosDmLG6zlPRzRG35+HqoibHk9DjHHNTR4zlE1rf/jTiF5to2vl5tunSbgox
	u+nSOEujKxCAxkr5v2vn0ZexghgZN3GUBlYTEKCBR6DJVxx+MeBvDvCAIzQ6JUCc
	GkcF7SM+1Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0shadt9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 06:52:31 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 14:52:30 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 06:52:05 -0800
Subject: [PATCH v2 4/4] vfio: selftests: replace iova=vaddr with allocated
 iovas
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v2-4-0fa267ff9b78@fb.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
In-Reply-To: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=Pf/yRyhd c=1 sm=1 tr=0 ts=69134daf cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=JmSn-CL03WZ9larzvTIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 36w6tK_ieGWNvpPkS5b1RVrFa4IObO8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExOSBTYWx0ZWRfXwi2Ly+j3ekBJ
 GEmBFHkoZUHfqtiXLqPqJ+GeReZWXkizy331Mevu57bIcuqMhWYSjYB8CWpk3PMeN5CMOiahOQR
 m61tbWIFqE3N9BsRZeGp4xzcF4w2LC804vpkXet/GMTAj2z86MtYcQcGbja1uy2LyFQvV+Ia/xS
 SQ8jagBAOk4CNFXIgNREbt9yNdEP8DsAokqha9Wa25aUfCex+rLJLLfSj+/ae1pKwdKx6b5d33R
 VBe0YJ1BRPswQqhSa32G8CGSRYoq8MVgzbh0VFKEfzRqNyEk6hYKsJNigCsjk7CDiKZANQTvm3A
 Uc/nDJMGaJrPCdaiEFCJ1HL5pF3hcvMN7CHx/EXw7pWieaNJ/vT4AGtBKyNsuX3wDRA+AI7583z
 126l8miA9Kn+CISSD0M8ETM8wMwkOQ==
X-Proofpoint-ORIG-GUID: 36w6tK_ieGWNvpPkS5b1RVrFa4IObO8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

vfio_dma_mapping_test and vfio_pci_driver_test currently use iova=vaddr
as part of DMA mapping operations. The assumption that these IOVAs
are legal has held up on all the hardware we've tested so far, but is
not guaranteed. Make the tests more robust by using iova_allocator to
vend IOVAs, which queries legally accessible IOVAs from the underlying
IOMMUFD or VFIO container.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c |  5 ++++-
 tools/testing/selftests/vfio/vfio_pci_driver_test.c  | 12 ++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index e1374aab96bd..102603d4407d 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -95,6 +95,7 @@ static int iommu_mapping_get(const char *bdf, u64 iova,
 
 FIXTURE(vfio_dma_mapping_test) {
 	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
 };
 
 FIXTURE_VARIANT(vfio_dma_mapping_test) {
@@ -119,10 +120,12 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
 	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	self->iova_allocator = iova_allocator_init(self->device);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 {
+	iova_allocator_cleanup(self->iova_allocator);
 	vfio_pci_device_cleanup(self->device);
 }
 
@@ -144,7 +147,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	else
 		ASSERT_NE(region.vaddr, MAP_FAILED);
 
-	region.iova = (u64)region.vaddr;
+	region.iova = iova_allocator_alloc(self->iova_allocator, size);
 	region.size = size;
 
 	vfio_pci_dma_map(self->device, &region);
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 2dbd70b7db62..f69eec8b928d 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -19,6 +19,7 @@ static const char *device_bdf;
 } while (0)
 
 static void region_setup(struct vfio_pci_device *device,
+			 struct iova_allocator *iova_allocator,
 			 struct vfio_dma_region *region, u64 size)
 {
 	const int flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -29,7 +30,7 @@ static void region_setup(struct vfio_pci_device *device,
 	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
 
 	region->vaddr = vaddr;
-	region->iova = (u64)vaddr;
+	region->iova = iova_allocator_alloc(iova_allocator, size);
 	region->size = size;
 
 	vfio_pci_dma_map(device, region);
@@ -44,6 +45,7 @@ static void region_teardown(struct vfio_pci_device *device,
 
 FIXTURE(vfio_pci_driver_test) {
 	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
 	struct vfio_dma_region memcpy_region;
 	void *vaddr;
 	int msi_fd;
@@ -72,14 +74,15 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 	struct vfio_pci_driver *driver;
 
 	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	self->iova_allocator = iova_allocator_init(self->device);
 
 	driver = &self->device->driver;
 
-	region_setup(self->device, &self->memcpy_region, SZ_1G);
-	region_setup(self->device, &driver->region, SZ_2M);
+	region_setup(self->device, self->iova_allocator, &self->memcpy_region, SZ_1G);
+	region_setup(self->device, self->iova_allocator, &driver->region, SZ_2M);
 
 	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
-	self->unmapped_iova = 8UL * SZ_1G;
+	self->unmapped_iova = iova_allocator_alloc(self->iova_allocator, SZ_1G);
 
 	vfio_pci_driver_init(self->device);
 	self->msi_fd = self->device->msi_eventfds[driver->msi];
@@ -108,6 +111,7 @@ FIXTURE_TEARDOWN(vfio_pci_driver_test)
 	region_teardown(self->device, &self->memcpy_region);
 	region_teardown(self->device, &driver->region);
 
+	iova_allocator_cleanup(self->iova_allocator);
 	vfio_pci_device_cleanup(self->device);
 }
 

-- 
2.47.3


