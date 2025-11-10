Return-Path: <linux-kselftest+bounces-45253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78816C495DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DC7188A064
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509B2F6582;
	Mon, 10 Nov 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="ijnlb97W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DE2F49E9;
	Mon, 10 Nov 2025 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809095; cv=none; b=LYSQFf6Ek/9QTh14Z7zJm1ugV84ejd+ABOtuRPcW4a7/huXIPB5quFl1leAaVstAO2ze7l+m8+VeFER97Gd2Os0bGgvTFYIToPqEYFPdGZPLnLx4SIs5xuST1o0288L1CvXZfl6E2jVQ0jbH7tWlbZrbas0wO6nbCXL5350NmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809095; c=relaxed/simple;
	bh=XtLh4aBeJsCUgYlUlpw6LH11tppsgh7k6FPs7nJZqIA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=h0/Dj1RIKRE4I8IzdDK/8vXrG/zfuQqPDwGlYH3E8qW1loLOdHVrGdlChhS5ro0y54UR8OQI3FFmEAvgqlOdrTHyx1FInMCqVFcV+SbpWBpN2uyCmRon640XB69ngUeU4q8VJxR9RH/VfVWx8ju+wzCO3N1dKKOMW4QmY0dOVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=ijnlb97W; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AAL4UPd3887404;
	Mon, 10 Nov 2025 13:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=usoWcYooOm9SxHALBG
	nUyhOdaDMkMi93J1Id1nTpVxY=; b=ijnlb97WQbwSw9VyqYSJ85CLXbeN6GU+kH
	dsd092V9JRbPZXC20o/8PWa+UoRy9Rx2sAa4jq0XFjkkKy8/Eg0TOaYZj5cNzxJt
	q5u38W0NkBGVURfa4aeyFUGLtBMo3N3GBwV/qovxtfqj3iWjOrpFHGmFClnwJANg
	jL3QMvttKOaWDdzH/UxuVzGPMwYL5gtF73k6wD/RuNgzFTpydARPkYqD4MUuGUgb
	R/75B2eJRj5WiOcPKk/+90Qo+SdHWj7wjVtqNMBDSS+hq3dcQvnKqz1CSmIYoV0z
	D6IzYMINxr+Vb8T5Gu4kOeKRMl3cmcigoUleXf39O2wEHxJ6+x1g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4abqn6r1sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 13:11:26 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 21:11:25 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Date: Mon, 10 Nov 2025 13:10:40 -0800
Message-ID: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANBUEmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0MD3cz8skTdIpBMsa5hsoGlqYllWlKambESUEdBUWpaZgXYtOjY2lo
 A55hn5V0AAAA=
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: 3EUnko2paFqERd4OIog84LK-XmwoQIXw
X-Proofpoint-ORIG-GUID: 3EUnko2paFqERd4OIog84LK-XmwoQIXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX8zEXcju1Dkn1
 +ixjMQT5VhR5/HxSr1Wx4OWcMhTPaGTX9QHHqPsH7AgYSVKStoheXKqrQDJponfKp/cCto7d+Eb
 cTnuXR1yJYip3+qSBVS/kFTbrRMRPgOQVY466ESDXYtqhrI8t3tOxol/mGED0a5N/bssAtV1V8N
 hV2qJG0dsWJoQv4jCP+mLm8fYf5PElI2AvK0e+jf0hl7h9bkTnA8fx5zZKn334sryuT9F8ViXtX
 ISflcaVDyGAbTgH76YC2ZjFPoqrRLOMqFLJvib+FeUC6Q/o1emCM6FWjTt9teObcNZXbt/uLYYk
 aDSPHxKi1vDiu+K/r2HbqPRZKYQeMG1buMuvtZSfjCYmx+zpZU4Nxpnd8yvIrnQCQua/gVY6iWp
 hp5ZYpPFPAzlBV+vTwu78s6dTn8rzg==
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=691254fe cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8
 a=oiGFUyDcMpD7GGGUmHQA:9 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

Not all IOMMUs support the same virtual address width as the processor,
for instance older Intel consumer platforms only support 39-bits of
IOMMU address space.  On such platforms, using the virtual address as
the IOVA and mappings at the top of the address space both fail.

VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
respectively.  These provide compatible arrays of ranges from which
we can construct a simple allocator and record the maximum supported
IOVA address.

Use this new allocator in place of reusing the virtual address, and
incorporate the maximum supported IOVA into the limit testing.  This
latter change doesn't test quite the same absolute end-of-address space
behavior but still seems to have some value.  Testing for overflow is
skipped when a reduced address space is supported as the desired errno
is not generated.

This series is based on Alex Williamson's "Incorporate IOVA range info"
[1] along with feedback from the discussion in David Matlack's "Skip
vfio_dma_map_limit_test if mapping returns -EINVAL" [2].

Given David's plans to split IOMMU concerns from devices as described in
[3], this series' home for `struct iova_allocator` is likely to be short
lived, since it resides in vfio_pci_device.c. I assume that the rework
can move this functionality to a more appropriate location next to other
IOMMU-focused code, once such a place exists.

[1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/#t
[2] https://lore.kernel.org/all/20251107222058.2009244-1-dmatlack@google.com/
[3] https://lore.kernel.org/all/aRIoKJk0uwLD-yGr@google.com/

Signed-off-by: Alex Mastro <amastro@fb.com>
---
Alex Mastro (4):
      vfio: selftests: add iova range query helpers
      vfio: selftests: fix map limit tests to use last available iova
      vfio: selftests: add iova allocator
      vfio: selftests: update vfio_dma_mapping_test to allocate iovas

 .../testing/selftests/vfio/lib/include/vfio_util.h |  22 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 226 ++++++++++++++++++++-
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |  25 ++-
 3 files changed, 268 insertions(+), 5 deletions(-)
---
base-commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316
change-id: 20251110-iova-ranges-1c09549fbf63

Best regards,
-- 
Alex Mastro <amastro@fb.com>


