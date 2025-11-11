Return-Path: <linux-kselftest+bounces-45326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDDC4EA6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA96A4FDDCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE52332911;
	Tue, 11 Nov 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="VvzRDd9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A24E305E24;
	Tue, 11 Nov 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872759; cv=none; b=BGDLpfkZ01SN+LErib9ufhKtZeBkrdyZ43GfVrftKH/SiFB3cRuHLJbWvySdcTas6on3tCRGr96KAqhJkJo1C9il7glKcbqRFlB43GKpTJ8zx4EPrGqe2ILNGlh59H5NPR0WPrnU2El1P7BnXfsieD0U1C7ckD27Zd3JRVQ5SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872759; c=relaxed/simple;
	bh=i+sH/g3Q/zxRDXJUWVAcLjIlE78QLJOOmzP1YnJWwKo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IBIy4OtLaMvtUlCcl0Fp+LBgQ+P3qn5CsaBtnufQ6L0kTLjyRnamgv/uT+5Ke+OBMHKY8KgfDTH4LXhDtb4dbULc0uoURbEaSl9ytdZxWed1EhZMhLfP9FS8V009lVzoUzxb9agH4Xqf6OBfAxKcfU30VjvcySiJ7cdeWt70eE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=VvzRDd9D; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7SXNG1282474;
	Tue, 11 Nov 2025 06:52:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=+sYjHIgeGgtgEtM/ZY
	/rnb14rK5E2/vuUb3zVUYyCSo=; b=VvzRDd9D2evyyQXrKiJnGaWNsRk3B17oQ1
	lRx25HrBeyol7c5ekZuBB8j1I+se2wDXRs6eot+TuvuBiLYm3SGMLavkECcI05Uw
	T9GqDBOT3Ugc6Z/FL2QhZnpdOtIRoSy5U30+18ft8Up8WRIVLr43Yx4AHKJwuPR/
	jukMNLyW4GkLRlZlk/AL3q5lDZFPu576v4hK5HXyDTpQdMdhshB4y6r0LNEeA5ry
	vhzVZVOf0iPjyoM2kfevRIgOKiLYEXn+aRDVrXr5oVobG+o8KdtaEmGhiSI9/gr4
	bbLhytpDcpMBuqzk7SRwxT53kWaQCpcYpYLFbF4KpjEDp5X+H+dQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0shadt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 06:52:29 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 14:52:28 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v2 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Date: Tue, 11 Nov 2025 06:52:01 -0800
Message-ID: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFNE2kC/32MOw7CMBAFrxJtjZHXsRGh4h6IIvGHbEGMbGSBI
 t+ddQoqRDnvaWaF7BP5DKduheQLZYoLg9p1YOdxuXlBjhmUVAYRpaBYRpHakwVaORg9hCkcemD
 jkXyg11a7XJlnys+Y3lu8YFt/dwoKKbTTGm0wHHPnMO1tvEOLFPVHVE30bkDDcn/Er1hr/QDJ3
 1IH3AAAAA==
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=Pf/yRyhd c=1 sm=1 tr=0 ts=69134dad cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8
 a=9jRdOu3wAAAA:8 a=yzAeJPK-mxwKR1Fv_EMA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: mpVuFlv2TWYADdiwxTnQRgit2ebAZJba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExOSBTYWx0ZWRfX1jOLyskkoLOt
 gnYTg7IFAL055BvfGzME6Eagiq6SDkCsJJqIquLgLzVDuShdKFYEiYsB3ILZs2VItWauseXadXg
 wyNirE/6mqcd7F9DCJqpLSuKObABlw/PfejkqS+q6LULLP1PGgFWz+QtsEdaEhLkb45ZGK+003N
 v8YzO09ivG7+Yk3z9azEqfxlZVSR21NvQ+MoAkdQ3qsM53LqY279BSlZto+NMXAcL4lu7S1Hwx4
 DZbV8aRn2i9zw/8NJ08r9LnsB0EVFb3QaYGMRRkeXfLBoii9wCWyOEUCFSllaAVkMfPsUlGjFpN
 8mBy/SaFtQwP4roRHxReoaLAvKygsZ1d2ZvqzrWnKYAkbdu4d7LLgGkG73JlE7K+W1LyVIZjZ1r
 Oczz1FmXBknz2Ev1JZNcOt7xYqbonw==
X-Proofpoint-ORIG-GUID: mpVuFlv2TWYADdiwxTnQRgit2ebAZJba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

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
[3], this series' home for `struct iova_allocator` and IOVA
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
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 241 ++++++++++++++++++++-
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |  20 +-
 .../testing/selftests/vfio/vfio_pci_driver_test.c  |  12 +-
 4 files changed, 283 insertions(+), 9 deletions(-)
---
base-commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316
change-id: 20251110-iova-ranges-1c09549fbf63

Best regards,
-- 
Alex Mastro <amastro@fb.com>


