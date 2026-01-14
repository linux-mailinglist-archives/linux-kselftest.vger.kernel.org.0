Return-Path: <linux-kselftest+bounces-48968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FAD20ED5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C5C13002B8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80E333733;
	Wed, 14 Jan 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="I2YO4yOU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC23331223;
	Wed, 14 Jan 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417052; cv=none; b=TXgDu4QrmQSRPcNxVgQc+F8WnIrgLIWT4/ieBDE0z/B0P217LfIrNKQzZu6RiMADsTpFm4Gai5A9ksbe+2cRM8AfSii54kEOzAEjcdauKBZpXD+Pu+T9HNZyRN+TZoe9wkIlEwui2y/xOGu3ZEvb/8iG3+PWI390+XZ/oc4cUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417052; c=relaxed/simple;
	bh=fkrdBctk1aST+sSHe3JoGU8KujzMzEzuEICfMKThj7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i8sfw27ZgFZzwMeIlM1QhWOEObOvu2+FnEP/bDKGbWmNCgAECE3yZETt7GFsTwgTy4+DOjEEo9zat4zGCtcLatfX2F2mOFD6TS9mvV/75t6objanhm3+mhJzmfiWWAmEtOeLrVsiBe/FoZBRB6Kc5fI5rXFdQLWCZyzg7bcp8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=I2YO4yOU; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHQReH2373504;
	Wed, 14 Jan 2026 10:57:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OyC5pNyK4lUwaTgpChdW1KmmFya8dvnjMMlIoImdkRQ=; b=I2YO4yOUfCR8
	9Dm6LVot3h3tXIReBUpphdLOtrK1k4RqcXBGJ6U4F0p8WolNfVvzi9O4U0958B+w
	gCVMCUG/nMhWI7f7KH/ynZVteDm0enwnAl/gD2ihoc/Z1xHvpFP9PjIMIT2zhwQG
	ZGImeRpOgmsDD9poCXqtm22S87mfwXm3j1ULgYj9sSpgfKpjEDPz1zakMBDovna6
	3EGJaUbpihMCWEtSi066tbDPRFnk4DLku6DmaR8wTnbyfQNyyMCak1kEG7R0WyR8
	g/4JGSrnr2lYiZaIypezfGfcr6+ffru4vq8ZO+L2B3+BJcTr6ITU+VwFVkL8J5vi
	KRmVB5RLTw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bpactbmre-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 10:57:23 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:57:22 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 14 Jan 2026 10:57:16 -0800
Subject: [PATCH v3 1/3] vfio: selftests: Centralize IOMMU mode name
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260114-map-mmio-test-v3-1-44e036d95e64@fb.com>
References: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
In-Reply-To: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: _vmoxHnfhHZHBnnyiYvn8mu-woVfge1C
X-Authority-Analysis: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=6967e713 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=ZEimqIeFnaV32_7obd8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _vmoxHnfhHZHBnnyiYvn8mu-woVfge1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfX7mDnEzNWGAgR
 S0W67gfBVbYe+Xhp5wOC2xyuvIPBTVzH1tJklMo6IdJuDMgUhiPk8z7VqYxg07oSHqKwUDBhBhp
 tQYOpRHY6JIDoNXJbxLPA6kftXpo6QDtuYPjz4MeapEZljZjsLYeW6yvIs0F/Eu8ynvJAud9Ltm
 VwEwnF3XEI4W2ZZBkzj/0jBVpRxEWf+TsrMnL5iIDmT2+kbn/w8WiRzmWi9qVbv2LhTP6zyFocf
 2Lr1wSvxmqs9kigITeoCDr3eqV39q2CsNVrpPTlfKPO1r3Lj+A4V3jzzCpKCXiYK4CZWlsw1bde
 nTN5v8/q81r35iDKDmUIzOXhrzO6eMojF32jrEyVYChegg8qnSbIvUFXJno8E1oweIrgITZIv3q
 ot+gN1/orUMV8LvKkGWIDXSPFwq1MLuRfBj5RpcPxZIyPTHnMtgJGb0Tfh6mRBhdGzyVChDSgh/
 bxsczuZSJ339sq1KyCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01

Replace scattered string literals with MODE_* macros in iommu.h. This
provides a single source of truth for IOMMU mode name strings.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h |  6 ++++++
 tools/testing/selftests/vfio/lib/iommu.c                 | 12 ++++++------
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c     |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index 5c9b9dc6d993..e9a3386a4719 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -61,6 +61,12 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
 
 struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
 
+#define MODE_VFIO_TYPE1_IOMMU "vfio_type1_iommu"
+#define MODE_VFIO_TYPE1V2_IOMMU "vfio_type1v2_iommu"
+#define MODE_IOMMUFD_COMPAT_TYPE1 "iommufd_compat_type1"
+#define MODE_IOMMUFD_COMPAT_TYPE1V2 "iommufd_compat_type1v2"
+#define MODE_IOMMUFD "iommufd"
+
 /*
  * Generator for VFIO selftests fixture variants that replicate across all
  * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 8079d43523f3..27d1d13abfeb 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -21,32 +21,32 @@
 #include "../../../kselftest.h"
 #include <libvfio.h>
 
-const char *default_iommu_mode = "iommufd";
+const char *default_iommu_mode = MODE_IOMMUFD;
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
 static const struct iommu_mode iommu_modes[] = {
 	{
-		.name = "vfio_type1_iommu",
+		.name = MODE_VFIO_TYPE1_IOMMU,
 		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1_IOMMU,
 	},
 	{
-		.name = "vfio_type1v2_iommu",
+		.name = MODE_VFIO_TYPE1V2_IOMMU,
 		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
 	{
-		.name = "iommufd_compat_type1",
+		.name = MODE_IOMMUFD_COMPAT_TYPE1,
 		.container_path = "/dev/iommu",
 		.iommu_type = VFIO_TYPE1_IOMMU,
 	},
 	{
-		.name = "iommufd_compat_type1v2",
+		.name = MODE_IOMMUFD_COMPAT_TYPE1V2,
 		.container_path = "/dev/iommu",
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
 	{
-		.name = "iommufd",
+		.name = MODE_IOMMUFD,
 	},
 };
 
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 5397822c3dd4..7cd396aa205c 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -166,7 +166,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	 * IOMMUFD compatibility-mode does not support huge mappings when
 	 * using VFIO_TYPE1_IOMMU.
 	 */
-	if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
+	if (!strcmp(variant->iommu_mode, MODE_IOMMUFD_COMPAT_TYPE1))
 		mapping_size = SZ_4K;
 
 	ASSERT_EQ(0, rc);

-- 
2.47.3


