Return-Path: <linux-kselftest+bounces-48895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81751D1BA88
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD6B3038F71
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362736AB6D;
	Tue, 13 Jan 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="CxSA5f8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899734DCD7;
	Tue, 13 Jan 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345766; cv=none; b=ArVKqLmcYyIHSgU8wIwO6oqcczci2r0l985MB+h9Izo6QukAfcwaiS8/ACnANqvtGg/OpArggMdvm470tQwnl7umHODk4QybJlQNwKc68bDaApoVy3BKACdFAdVUXeUOOqjw8NPnNPRBbeEC1ggeN+VVx8jVRcgEg1JG5NL56ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345766; c=relaxed/simple;
	bh=fkrdBctk1aST+sSHe3JoGU8KujzMzEzuEICfMKThj7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Kkx1cYnZ+PRIgyo8Hr5FSixLVCxDeZvNFf6IvrH7rjN1JLqbyauqoIFliazyFlDFWGPfouipr2r6GKIIc6dRQqEfh8tyVyI2m9OCnSiMXEQEw8fZBqP2loEz9I14S2LeHsVxQtsXqqf6K62kyK2WrCj+6G8PoY6YddfX4OMMdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=CxSA5f8W; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DN6m634099591;
	Tue, 13 Jan 2026 15:09:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OyC5pNyK4lUwaTgpChdW1KmmFya8dvnjMMlIoImdkRQ=; b=CxSA5f8WMZ1K
	Z43+3GqxFizJK+BxQHDChSPUUyqCwkg53xTLIl7B3Tp6nRBsd9Q5vlbc1LGsVenY
	Wj/SlEeA4TYD1iUDSgww2cJB72T9Qek8h9vsIa7ZQWSPcgbEU5PQAruhZETuqZ7/
	s5Ax7yPsOc3AkKTXMC9QVTDkah6nEOXKwLC7WCw8WbLicRtDd9GeedmJSycObvrS
	O/jEyjS37sHddcxrChUpkcJjV1uT19qAbYbfsYYUlLqpiOF9ClsiCVPnnkdjHzi8
	ECJbrmBaKoODUKUq2L0qGq9u0zB90C2ZCVrxWc6gLV8Yry37l4p2a7jYLWMAOGHp
	80FXUH2u1Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnyeh80r2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 15:09:16 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 23:09:03 +0000
From: Alex Mastro <amastro@fb.com>
Date: Tue, 13 Jan 2026 15:08:36 -0800
Subject: [PATCH v2 1/3] vfio: selftests: Centralize IOMMU mode name
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260113-map-mmio-test-v2-1-e6d34f09c0bb@fb.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
In-Reply-To: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: RLB5IoYT0I5VELiTct--AiNOqQpEjALK
X-Authority-Analysis: v=2.4 cv=brZBxUai c=1 sm=1 tr=0 ts=6966d09c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=ZEimqIeFnaV32_7obd8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE4NyBTYWx0ZWRfXw9RNTItLCHMs
 1FwQgw7R0XfOq6GsmPxcSCP/83JHXmCFKvncsA3Ks5XnjMfC3SwO36WR18bKs3KMydjdpmP+FkO
 oIxkVWD3rheSnpPEsgirrV83jbcGQG+dKswooTekSJO6gYrwNweRvyF6hYaTc1QCyO61wMZe4ek
 zkPNZOtcthF1hZPEWNbfF0VUbZEuLpGNBxVgvoyKihJtGtSwF+N8AERqnc70u+lb1lYPK925o00
 VDYbDJ8lqn2s5XYZvjYcg3nJ17VT1eQ7V4JEF05uo8i3RF6urBgCIwqsMygz0WSaVuzYPsl/ggY
 WySJ47+afbcMgE6Be49kYGPrkW6j0KiT+ldFp83FSgyZKA/fWNqckUm7HDEm/VsyxTF8HzCTWZ4
 JnIeDIvlZCg43ZoIEfDonyUjs2xK3fQInaPEQewfq8wD3y1OTleAN/Ilt/djPBWAwrV4t8fvIic
 m2ld4WBLIOIUGs98c4A==
X-Proofpoint-GUID: RLB5IoYT0I5VELiTct--AiNOqQpEjALK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

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


