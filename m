Return-Path: <linux-kselftest+bounces-45360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F76EC4F7EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1A9E4E7E83
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FC2C324F;
	Tue, 11 Nov 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="pcbcaOt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2729BDAC;
	Tue, 11 Nov 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886935; cv=none; b=l61XYINeBDg/pm5BvYJExtdFbNa0o+GNawPLVDEPrfUXorUZdbX0ziM6GYA/lRHinqBinqtMGE7eSkbIYZI43Cuo4WFzLRG2wFucxqaN6DS7SmfVRRl+GdU8nFJftEc+BQhqNfpF1nOOWWZ4IPYm3cJXhjFcNkXAjM6cogrpfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886935; c=relaxed/simple;
	bh=XaAbEe2qedf2XRV3s2dfM+FiD4+y5ooxNwFcuE3dzCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IomRihghuML92zk+H7LJJjjhRS/4LZmcEiJ0xIU48wPhBTRrXxNiww/DLFLJMDMEcuN69Z8Eze49vTEb7VtFcfZ8tRf4sDBz8Aljq+9whjktNGrKy4WU1Sn9kxSbkWa/CzxclyYzbYb5SDVVb2yHxXD1NG4K3i9VQx1P82NWOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=pcbcaOt+; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGKpnT2601076;
	Tue, 11 Nov 2025 10:48:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=C6Syl/saA4CzZdd/MCSZCKwchjl4BKuY26Fv5OT+iOU=; b=pcbcaOt++GnR
	QrpAxzpq2gmQuEnjiyw22dBr806LzxTXSbV2FdHg+8+FNZoPhcjd5tm7e/OgXsUx
	JwQPAAgwtSw1BjQPuTnZMTYEelwwPwmC5WsYZLMpCDj+TtIxa5tN4oecRZ2FK2mV
	sY/4PNUvBOoC2vKPYUHgMaa2JxzQ5+CmANRIk95mpAv4MTWK0VPYNHc+7YVgoQMW
	VtUud9WHkorjWQuJVM0vGqxYx7yy/RsW+97if0nybCCqXAeWhL7RRJ8+afkDsOPW
	hFKYiBAtJp8iyXFo9O8NaiiLZLwK/bCBef2wQpxifHHVSWDkwsajiGUs/J5F+LyT
	UaL/fWMMPw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac8k51cdm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 10:48:48 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 18:48:36 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 11 Nov 2025 10:48:27 -0800
Subject: [PATCH v3 4/4] vfio: selftests: replace iova=vaddr with allocated
 iovas
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-iova-ranges-v3-4-7960244642c5@fb.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
In-Reply-To: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: ODaj3tp_75R0wsR46t6-F38Tyq2Ennq7
X-Authority-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=69138510 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8 a=nYNqVF6_RSbOQ5eVvY4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MiBTYWx0ZWRfX6ScbTR1FAQw5
 kMFbnDL65BMrwHKHJsk0qO1xS/3caUxDO7IvSdq67XabZpE7Vmwgh+MjpOGbkBfUl9Zo/pq0neB
 QrSS4/6dVT0wsBE8sCFC/+uIdYM8R7aA93gj+VtfQCX8q1gww0+YWXdQ4hCGaG9WTmVjYrW4+WO
 w7ppSS8d+Dd/RH/J2TpIqJ7d461qdxTWyWQe63MyOfpA1ELTyaHm+1h6/ctoJKpD64dLe3O3SBt
 vXYSnpYFBm7eUiIKb0Aa+iZlDj1BUJR9tQTKLPZJ/sTSezuMpnunAYgEAKXcF/IWeazse+dY81n
 dEMOeQr7Yjkh1UmwXE65uro4+PH6JjXDqdZBGDoyCunpqHFXHy90077P0JUuxUOVcVx1rOE5jvP
 N/uq2hG30b0YCw5GKLaaN2w6VX8yQA==
X-Proofpoint-GUID: ODaj3tp_75R0wsR46t6-F38Tyq2Ennq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01

vfio_dma_mapping_test and vfio_pci_driver_test currently use iova=vaddr
as part of DMA mapping operations. However, not all IOMMUs support the
same virtual address width as the processor. For instance, older Intel
consumer platforms only support 39-bits of IOMMU address space. On such
platforms, using the virtual address as the IOVA fails.

Make the tests more robust by using iova_allocator to vend IOVAs, which
queries legally accessible IOVAs from the underlying IOMMUFD or VFIO
container.

Reviewed-by: David Matlack <dmatlack@google.com>
Tested-by: David Matlack <dmatlack@google.com>
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


