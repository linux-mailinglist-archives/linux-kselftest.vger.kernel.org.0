Return-Path: <linux-kselftest+bounces-48893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FED1BA82
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 00:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF134300B937
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D3352C41;
	Tue, 13 Jan 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="g6gP1emt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1C284883;
	Tue, 13 Jan 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345766; cv=none; b=GC3okzQaZ2aRXSvvkcyBxoVvYRoVVJaeQhZUXVi+s+vjusmKs6X5osX2O7MoCIuYkTz/8xjmHbx9LTsOWMzuMlLi/Edgno2zjbr+emo12F4BpeiWvfUPvhvadN4UpHxJIIEghETwCghwMmSNRiGA+gLHG/uPO0VcR5LqHhgbAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345766; c=relaxed/simple;
	bh=REHwvtrmLyZuAaxApX3wcixqfcyBfRteHzbYHon1TIo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=i5O+7ShVxZc+C5x7446CXIUv4OO8JZm2zDVPeucgEK7XO9jWdbkBQtaiB/F4RQPyflzEhiCQmd7a7HFIry89URGwLcOeWkQ4o5sSjwUt6R6Pw4uUCOzYthVpKqVgHK33RanpPh8/tLw6AEaMvR/kJoEbU1RtFDZalvAYVo6RSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=g6gP1emt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DN6m624099591;
	Tue, 13 Jan 2026 15:09:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=7G3zwVcKtjRGGwwLj5
	p1Gbl98yDMOgEESiN4hDwPoYU=; b=g6gP1emt9isAad7wGKAVS0kMRm/RMB7csL
	X1BDsFvTL1AMyB/vEeMt3rYcbzbH2wPPo2V4kEeugVwPo2ZTpsE85kIRR73xbQyT
	iGpRPsKwwXSP4vW51ti1hizzAHseODoVItWGIlVZUwXU8jZiJWk08/qhMAm4PI8T
	Xwio+8FowYfviBEUnecLYVFWm1QjTrNKFIaMOCF5ZVdQHlD8v3S8ZhjTzgKZnRWV
	581BZn0VXNS0CUuLtB/olsZqTRwc2LgppsdsGEQXAYNDgXyWBjcxgm7gfTJ+y8E9
	7dNKSOXuoiU7ThfiiEGnEA2xLJzBrWAb8JXjoZ2r1HoXYTNN32uQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnyeh80r2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 15:09:16 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 23:09:03 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v2 0/3] vfio: selftests: Add MMIO DMA mapping test
Date: Tue, 13 Jan 2026 15:08:35 -0800
Message-ID: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHTQZmkC/03NMQ6DMAyF4augzHWVRLQ0nbhH1cEYBzKEICdCl
 RB3b9qJ8R/e93aVWQJn9Wx2JbyFHNJSw14aRTMuE0MYayur7V0bYyHiCjGGBIVzgaHlluzoTId
 O1c0q7MPn773etb2kCGUWxpOiO8gkWGgGjJiLJNh8FceIP34Ny3S62AwY0MR0Y8f0cEPvhyulq
 I7jC6/b9rq+AAAA
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: aZoN6HpOVsMyfxUeN-0viIITJY5Tzkyw
X-Authority-Analysis: v=2.4 cv=brZBxUai c=1 sm=1 tr=0 ts=6966d09c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=3j4BkbkPAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=9jRdOu3wAAAA:8 a=FOH2dFAWAAAA:8 a=fzhw-T1NQbm0UE1rqVgA:9
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE4NyBTYWx0ZWRfX8+UqDTtpQre2
 MGlbQBZLSK/wnY6bSmer9N9Ikrp4EjHORcQ5557dtcDmGQp8ecgkluD+u+16js69MnKJnajr7bu
 eCFX4mpHXue4N9XtevdgJsR2SrUyZsxlz+KwwnFbU51zkdxb6Zo1Zmd0SQC7jaJW5zHYVEkw2K0
 0yWBoPxgW/XI4rTw8n1U/C3dMiH7PkQ9uprqBCQ8KVYPj2uxljPZPWLH6PEJCzQ06zSlnmZit4X
 he1Xp+8RHbWXsD+o2DIxT0cwVNRC8hXdHoxk2BONgc10/fp6kvr2GsgKLC29VPqzQcMVu72uC+4
 D6spem6eBlYDEDq340t57jJekqQtYWDGNgkbPJ/+BS9FwVz5vxF9SskuDQ5Ls/HIlKP5mJ3Rvar
 ob0AEizWwtz1iXmCxgDAtjSGZbpx1uRd+jrc9U4PQdaMVwHIsKkOAXRuof8b4B+h04zl00DBFKA
 lb8f54BzkxPDuwvMD3Q==
X-Proofpoint-GUID: aZoN6HpOVsMyfxUeN-0viIITJY5Tzkyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

Test IOMMU mapping the BAR mmaps created during vfio_pci_device_setup().

All IOMMU modes are tested: vfio_type1 variants are expected to succeed,
while non-type1 modes are expected to fail. iommufd compat mode can be
updated to expect success once kernel support lands; native iommufd will
not support mapping vaddrs backed by MMIO (it will support dma-buf based
MMIO mapping instead).

To: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>

Changes in v2:
- Split into patch series
- Factor out mmap_aligned() for vaddr alignment
- Align BAR mmaps to improve hugepage IOMMU mapping efficiency
- Centralize MODE_* string definitions
- Add is_power_of_2() assertion for BAR size
- Simplify align calculation to min(size, 1G)
- Add map_bar_misaligned test case
- Link to v1: https://lore.kernel.org/all/aWA4GKp5ld92sY6e@devgpu015.cco6.facebook.com

Signed-off-by: Alex Mastro <amastro@fb.com>
---
Alex Mastro (3):
      vfio: selftests: Centralize IOMMU mode name definitions
      vfio: selftests: Align BAR mmaps for efficient IOMMU mapping
      vfio: selftests: Add vfio_dma_mapping_mmio_test

 tools/testing/selftests/vfio/Makefile              |   1 +
 tools/testing/selftests/vfio/lib/include/libvfio.h |   9 ++
 .../selftests/vfio/lib/include/libvfio/iommu.h     |   6 +
 tools/testing/selftests/vfio/lib/iommu.c           |  12 +-
 tools/testing/selftests/vfio/lib/libvfio.c         |  25 ++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  24 +++-
 .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 144 +++++++++++++++++++++
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |   2 +-
 8 files changed, 215 insertions(+), 8 deletions(-)
---
base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
change-id: 20260112-map-mmio-test-b4e4c2d917a9

Best regards,
-- 
Alex Mastro <amastro@fb.com>


