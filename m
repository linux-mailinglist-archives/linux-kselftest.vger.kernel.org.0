Return-Path: <linux-kselftest+bounces-48969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADFD20ED8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61AEC3008F72
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328B33B6E7;
	Wed, 14 Jan 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="NnakV8MY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9732D0EE;
	Wed, 14 Jan 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417052; cv=none; b=iBExyumpdVLjbuNry/Ih1i8qGcSn+IS0nyLQc4S6e0fh6lJBnlre0nemFaYEGTgUCrTJ3rycX3uRNVjZzdjKnzpv/y58nW08x2/P8icztZDETNrCScd2cygeMUscijCI6fgF1G3fpQ41qVvKyFrU3Uz7JkTpTOMsjBe5X6Qp0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417052; c=relaxed/simple;
	bh=3I0YdTMNjrj4mGHAqLtGVK61XBILu1ck+tAUnA/KNH8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nx2orvxKMkcyGVLrSgOdlS5vPSjgnYlWD8NdneUr9m3iwrUDcJmQWsJ2LVxX3Y3CmUFAm17RY5pGh6CG5eL0LaRFeCj7gGfBt7HR2XGOs8LEkxXKH0qkS4s19tIIqW32lBdTeJ4r2eM7Ii+QwWhKeSmwq0nVSh1q8h7fFG8DsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=NnakV8MY; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHQReG2373504;
	Wed, 14 Jan 2026 10:57:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=l0QAPWBh8G5X5KYvv/
	T3Ns48OAAl66QLHxnXzPrzOCo=; b=NnakV8MYIhb24rN/kqKEvEF9044How57VQ
	2Y5DbKzAUrnqJJW4M+Wo1EQWe7j4v0303PbmgQyASFtHFx86vesNkA3wgm9o/FYl
	hIJHcVJRR09WKIc0ije3o4S5ATEhRkRpzLZoUckr6CeWQ/Ef4R8dN4IiRO31pqXD
	1X5nM8lzfYyItRg0auRLKc15PJkJ03YtLv7vSNQl5eQWCcOtJAbjvOsrmc/YFQig
	zhTd+RsYXINxf/s0AMaQggJZKhuYoT913cF2dTfBOBBCvFi7Mjcd8M/9zbq0+FNh
	UVru2S4JqsJyfsAtRhuu6wmizbFxlja9g9hEDhfU6f8U80MhA37g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bpactbmre-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 10:57:22 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:57:21 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v3 0/3] vfio: selftests: Add MMIO DMA mapping test
Date: Wed, 14 Jan 2026 10:57:15 -0800
Message-ID: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAznZ2kC/12OwQ7CIBAFf8Vwdg3QWsWT/2F6gO1iOVAaIERj+
 u9SE03jcQ5v5r1YougoscvuxSIVl1yYKjT7HcNRT3cCN1RmksuOCyHB6xm8dwEypQympRbloMR
 JK1Y3cyTrHh/fra9sY/CQx0h6Y+EnSBh1xhG01ynHAMVW4+D1qp/ddN8kigABHAmPpAjPylytO
 WDwa250KYf4/Lwvco1+jzZ/R4sEDtQNTWu5Qm5+ln5Zlje9CORZBgEAAA==
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: xOCsMx3UwAJdHQswxFN6vG4SZeASM_Br
X-Authority-Analysis: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=6967e712 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=fzhw-T1NQbm0UE1rqVgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xOCsMx3UwAJdHQswxFN6vG4SZeASM_Br
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfX+3E4Cw0h13iI
 iV0RxMoftm9/o3aKPsiXRVtjw/AgYrD7ysoX2YObWEopYB7F3mqz47F6UDwBqDtDHU+jtnFHqtA
 eFtf/cVy/ITQHPAbOLA1j58S6o+px1Oxoh696r6zY/wc/aHWPzuAc3+bAv3LLTyH9c+ESQbSrR9
 4CnScei49q66XJpJ9SxdW/FJD8OEhHO9yAPT4NFsGdSQhIpIVZMhSidq3FX4z5g886DpCz9DQSh
 7UD9Brm+SHCZ+Jib5w8KeRwhiJ/SEVOnvyNSMc1qfoaYPhunK9sDxIadMxHa9Zy+DRH3pOIgBQm
 RfLa+HVq1SZuNcKfKXlzdn4bdZQhHj/Ba5pNiYjN3u79ZjgFj3a4LZE2HGRMV5P87T4bNrbfk3V
 yciCzUrWfWvfnJCEpYIWByDpgGjb+/G3JH/n3tWgfZqGYPuCpy8S3XT4khRQ8Q2AP9xUK/I2Htm
 a6kDghi3+9CjGCSLW7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01

Test IOMMU mapping the BAR mmaps created during vfio_pci_device_setup().

All IOMMU modes are tested: vfio_type1 variants are expected to succeed,
while non-type1 modes are expected to fail. iommufd compat mode can be
updated to expect success once kernel support lands. Native iommufd will
not support mapping vaddrs backed by MMIO (it will support dma-buf based
MMIO mapping instead).

Changes in v3:
- Rename mmap_aligned() to mmap_reserve()
- Reorder variable declarations for reverse-fir-tree style
- Update patch 2 commit message to mention MADV_HUGEPAGE and MAP_FILE
- Move BAR size check into map_partial_bar test only
- Link to v2: https://lore.kernel.org/r/20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com

Changes in v2:
- Split into patch series
- Factor out mmap_reserve() for vaddr alignment
- Align BAR mmaps to improve hugepage IOMMU mapping efficiency
- Centralize MODE_* string definitions
- Add is_power_of_2() assertion for BAR size
- Simplify align calculation to min(size, 1G)
- Add map_bar_misaligned test case
- Link to v1: https://lore.kernel.org/all/20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com

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
 .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 143 +++++++++++++++++++++
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |   2 +-
 8 files changed, 214 insertions(+), 8 deletions(-)
---
base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
change-id: 20260112-map-mmio-test-b4e4c2d917a9

Best regards,
-- 
Alex Mastro <amastro@fb.com>


