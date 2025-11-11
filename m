Return-Path: <linux-kselftest+bounces-45357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39064C4F7EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3731884EE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784D29C33D;
	Tue, 11 Nov 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="Pbg7jlJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AC3AA19B;
	Tue, 11 Nov 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886934; cv=none; b=TVwxRxF8gK/QaYcNN3aXiRORLnlZxRwhs9TX2qw+/uyqR9lD2em4lAVLUj09k/WDLusq9mO9usE+4nFq/yItf2cppG/U/mFTo7OsRtcH9FByTLeLYo44RrSjjpzajt6MY8BIzi2eeqRWH+MHsS1XDF9IvBJDs7K+1NU8aTRyT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886934; c=relaxed/simple;
	bh=vO+jAwCKnPlIeRSA6S7Mn16AZhbOoIOPxT1PtXPbY0k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=sJE+VXOYUBg/0storeUFxcH7UC9vdqWii6ZTTrGIDOFSaM9K5VNcPZgAXp8BQhKGd2M95DWWeavTCZ81S79XDxfG6yLLDDnafWdoR6nXvhnxVxfNqtgCxhxhCtSWCsD8rhrzL9H0DzY0/UmJLH7k2ZHslT/XsDmDK2eswSz1/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=Pbg7jlJV; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGKpnP2601076;
	Tue, 11 Nov 2025 10:48:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=IiLZtQogc85dx7sMXh
	t1MShWinLM8VCRAb6GHhKw/Mc=; b=Pbg7jlJVbsGPHSopEhSS7/s86qzA+kP11K
	Y1G7pWCPigdgpMvwKN9a2fh8kBh9HKtbFcX6gMI9B7Ij6kU/a8qhgFWR6wRechKK
	A6ZSqatOgYfBzuz0tYqXNNNILpSafit7x6xu7KYmhq8tgq89UgdZcnE5VXfrY68t
	9bpW0S1/FFZJq8NjNWkTWZg9QthUcBdCbOrSYSx1/Wo0SCJMYC03dJfTlDvWz6mj
	d111ShcC/ak6z/M27Ttcvxfy7sbBvsMtF6B+bx/jABsxWkiRA+zI307RgIhxDWiL
	+Eq8h5W1IRXdU1Gx4XiiET0FxwNEXA3jqFTer3AwYRPecFoeKH4A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac8k51cdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 10:48:47 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 18:48:33 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Date: Tue, 11 Nov 2025 10:48:23 -0800
Message-ID: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeEE2kC/32OQQ7CIBAAv9JwLoal0BZP/sN4aIG1HCwGDNE0/
 bvQxF40Hmc3M7sLiTY4G8mxWkiwyUXn5wxNXRE9DfPVUmcyE864BABGnU8DDWUTKWimpFA4Ytu
 QbNyDRffcaudL5snFhw+vLZ6gTH93ElBGhRECNMocMyccD9rfSIkk/kfkRbRGgcxy08NHrPeP4
 VtgOPC2Q1Rj1++X1nV9A8A65cUNAQAA
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: ETSYN2DTAjoXhf6jKUlaLekGOusJP6MM
X-Authority-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=6913850f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8
 a=9jRdOu3wAAAA:8 a=yzAeJPK-mxwKR1Fv_EMA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MiBTYWx0ZWRfXypb5PdYdn7y/
 uTU1StWG+IhbYUcH1kwdEqctfgsUJgvfKeyxvLl0PzYvmQ1jbheYBDuJXMQ0FbsllDPrXhMsPBo
 wG5tZmYTkt9Egmw52Q6hS3ZCiAUOh8T0I86zvXuCYwPl5ds+uGirFRjzE0Qq/KdZr/kD7/uyvea
 h0NRmSZPnL8PEZsV0q8lsR1ya9IR3B5GmkPrvpxjgn3YAQ6cl3uv6gDqDTzReK8NfzJTqGqJB7r
 N0AAW9ClzZlAt5YTspvJJW7Ico8KWg7KIIzpywEh5g0hfByxsy4ZWY9S0bP561YCx4oGloL5CJt
 /QTklBATWXdSjTM51VmaHWhxGgHfBqGu4fmj2tl0mAgU6+x9J2WMxyMiz7jcb5e+fQpfZfRqSJD
 yPgR+U3W/a7AH1CJMyjSkzJ+6iyWYg==
X-Proofpoint-GUID: ETSYN2DTAjoXhf6jKUlaLekGOusJP6MM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01

Not all IOMMUs support the same virtual address width as the processor,
for instance older Intel consumer platforms only support 39-bits of
IOMMU address space. On such platforms, using the virtual address as the
IOVA and mappings at the top of the address space both fail.

VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
respectively. These provide compatible arrays of ranges from which we
can construct a simple allocator.

Use this new allocator in place of reusing the virtual address, and
incorporate the maximum supported IOVA into the limit testing.  This
latter change doesn't test quite the same absolute end-of-address space
behavior but still seems to have some value.

This series is based on Alex Williamson's "Incorporate IOVA range info"
[1] along with feedback from the discussion in David Matlack's "Skip
vfio_dma_map_limit_test if mapping returns -EINVAL" [2].

Given David's plans to split IOMMU concerns from devices as described
in [3], this series' home for `struct iova_allocator` and IOVA
range helpers are likely to be short lived, since they reside in
vfio_pci_device.c. I assume that the rework can move this functionality
to a more appropriate location next to other IOMMU-focused code, once
such a place exists.

[1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/#t
[2] https://lore.kernel.org/all/20251107222058.2009244-1-dmatlack@google.com/
[3] https://lore.kernel.org/all/aRIoKJk0uwLD-yGr@google.com/

To: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
To: Shuah Khan <shuah@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alex Mastro <amastro@fb.com>

Changes in v3:
- Update capability chain cycle detection
- Clarify the iova=vaddr commit message
- Link to v2: https://lore.kernel.org/r/20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com

Changes in v2:
- Fix various nits
- calloc() where appropriate
- Update overflow test to run regardless of iova range constraints
- Change iova_allocator_init() to return an allocated struct
- Unfold iova_allocator_alloc()
- Fix iova allocator initial state bug
- Update vfio_pci_driver_test to use iova allocator
- Link to v1: https://lore.kernel.org/r/20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com

---
Alex Mastro (4):
      vfio: selftests: add iova range query helpers
      vfio: selftests: fix map limit tests to use last available iova
      vfio: selftests: add iova allocator
      vfio: selftests: replace iova=vaddr with allocated iovas

 .../testing/selftests/vfio/lib/include/vfio_util.h |  19 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 246 ++++++++++++++++++++-
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |  20 +-
 .../testing/selftests/vfio/vfio_pci_driver_test.c  |  12 +-
 4 files changed, 288 insertions(+), 9 deletions(-)
---
base-commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316
change-id: 20251110-iova-ranges-1c09549fbf63

Best regards,
-- 
Alex Mastro <amastro@fb.com>


