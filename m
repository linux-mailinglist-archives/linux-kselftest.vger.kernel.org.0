Return-Path: <linux-kselftest+bounces-19379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29199720A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D611F24DFB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF41E5701;
	Wed,  9 Oct 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OAKO/UTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208B1E47D2;
	Wed,  9 Oct 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491963; cv=fail; b=PLyyuO8xdnEkV5mu3uAMDp6rBaMjNZI6zNMW0DT4Q5LYm1cgTBrHn32KrBrx64NbiF2kxXqR8gYqFog9HWhNtGVDJqhC39KRSYovybyUDDuBfvXVT2DKzkW9fyRu6/psVke1h22uhRxg+xBmkq/a60HhFrcicSBoUv8/O5P6nZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491963; c=relaxed/simple;
	bh=imjXzmbYbjXAfzvEE+8COuwuRvN2EhaOykn8665+4zQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMO8RUEA0J5SI9omql5veCZOdxQGsXdI9utORTYesYEXO7mtE2JTiJ7urDHvGHoNR6rdGXxkp3VfEXZoRt//8PKzxWcOYlVP9cVqRsnWUmdBAs2hPfwIxAdS5k50kv2A6YugD3/7r6jNnnWxDXAwUOdORTb8OQBto4kg82b1sDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OAKO/UTc; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUNdnzkj5OsLb7eOVmTkmw5h+HqCsekGpE4ambZLJIWqLQEHrwfKUm7G+9c2fl99mlaHNPUDkcEo2rTRz4VluKWYy9txIPBk8z0vTRPXB7tdpn2y37EiWxScho6VitMofO88h5QVijheAuWMTeQLhsDu/UabdFw457pkAO8gWf0zEW2ynty4R4jNl5N6HohDgbr98qluvevJp5AZoIkGI7ixcyvWEkdBbdA2JPPszkLCKK34Ghsa2mFy78TqXAmezPLiNv+VAxDddq0tRHwq62RTO86Z73Sfp44Wzep5nliv9Y2zQ8m9pfazKanLx/o9gseH+oobhPXy9SOydbl/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYYC3COHkotNUNMY31Vzls0Pl9/pAN8f8XFYHFTkDqs=;
 b=lvRhwXwGiPfVcFI7/IbR/4ULzWYv2fQnG3N9L4BUvCTu8fV3zhnUsgOABmGRATXpd08cTE4tSGC5i0uhhkIgK7E2jg53mBkpASyRNoagyewcAE1m/H+Szj1/oYClYa6hRY+qQiiBLL2S0v0gH1zmv661JbmGW2uXoTAp0CshFHiWKL3MxOEnFDwaCOdBnYqQTRSiRdBww34a93Zr56Nl5rZEom3BsQHWwp2apG9S13dWVVXsmH88vry7o/6yqN9AI9pnmnmLhvoGyNIXD1WyNkt/mzJt4xS5l0YX3FJ07oiKLfPbCjtd2oWabE0pPOk0G4v6TdblhJlwCtN1Iqz4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYYC3COHkotNUNMY31Vzls0Pl9/pAN8f8XFYHFTkDqs=;
 b=OAKO/UTcHWBkS4/29mqPjweGNGPRiu6BcGE4kGUW5d+r0k1zGk9nAaNgSHtyuL98/I8YHOg5ejsCiCMM7RXh4nmY3Y2qZ4mb3fNRMf+eZOI+DiMh+ND5tBk/pwhCO7mRlW0clgqDgHAdbRCwYZhavkjg7nf+HfSMxBW0zvSYZP33SLYiAQLY+xxQnKj0f8s0mqLYuqk9HzKq3TM8UL52pXyBEokTMntOlFXuYL/4CvkLEeM1I+4ysjFGXXNJdFruiIsa3OqBwhQ21jYlEd3bZqG7jGJwlOpL/otwe9BdTXkjzJLUdaXI10efSpR15h9PGePFGIXyGwZSKWd5L4fLxw==
Received: from CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::15)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25; Wed, 9 Oct
 2024 16:39:11 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::27) by CH0P223CA0003.outlook.office365.com
 (2603:10b6:610:116::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 06/16] iommufd/hw_pagetable: Allow viommu->ops->cache_invalidate for hwpt_nested
Date: Wed, 9 Oct 2024 09:38:18 -0700
Message-ID: <cba810b86d0597715738b4fb87084eacc734d8fd.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 357eeda9-f4cf-45c8-31c5-08dce880e700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5VgQk4MTgtzZ0YMznNjW6zzTYYQ+nYetJuYuJUjwvyO1GKF6SHGsHlcQDFgw?=
 =?us-ascii?Q?umdz+tbcOLWISAykmmPwsoTORgdzx7+RjL/9RioMoekfCbeU0npW/KdGw0ZY?=
 =?us-ascii?Q?muNoOWDMmhP5NIySkt5u3cH8kVdTcb4jxyDKPK5V2FRt3jeb3AZYFiYQfsNu?=
 =?us-ascii?Q?oiwimH0EVecrBFqZtnOYHfQlTDw4X2XSW40wO5zAiSp/A444Kkd2MAF9u/JH?=
 =?us-ascii?Q?ROC8VfUuA+uFwj3NaGWqFtNz+Pq9Yse/fiUKqYfNl9HjosQT8RfmeTZ8sNs1?=
 =?us-ascii?Q?ObL6qS+kV4ZZyaR0bASMxNu2rEOySKK9rJWvcJ6NWEp2QDPUkfwrusm5axr0?=
 =?us-ascii?Q?AVkUMSI3IuqJ1xoM0NW8d6Hzuf1EN++Af0I93ClLWlm7VTQUYE1N3k7sHJVu?=
 =?us-ascii?Q?9s2hZtSFURsdqgjc6FKe/Mo2IaWsUC73mMPyPQbjRuTi8IpyhmmClR3g0Nns?=
 =?us-ascii?Q?583W4wWzwAL7lHC7Lr0CsmkErpJ+zyK/AJZQ0xSbVJM6LvkCjTDAkpDxhB12?=
 =?us-ascii?Q?HTXKLRpIyHyaaOcmA/MLb1VV7maPYkhuLIMYMGeYGYtYyJfY86JB2VQE7oYF?=
 =?us-ascii?Q?fdbttOK4nlTiUKjEqsCAlULWFPdQNJc7Vce9u0ABCQ5TNTi53f2ef30w1O4k?=
 =?us-ascii?Q?SXSCWgyG/ydHGhIlR7hm+VumWZybi4NwJTOglGZ1wYha0orDGVCJD6EQPNmW?=
 =?us-ascii?Q?p7XRTy5WFklimq0AsDRhFAPvcQBfhjUz9xrB8oIWJ7Cf0QiPwz2A8cyksWad?=
 =?us-ascii?Q?qUO5wudJoGhZvjayJZUlBn7gmesauJDEtiZWj0OaCgqYg8as8GVDanKj40CE?=
 =?us-ascii?Q?6AVo08D2PhgMqcvprVEbuhn+FSdh0eP2zqkw7ioPryHWckQ7/rd6wiSgVBXR?=
 =?us-ascii?Q?8dw28eeZZoYVBJXKwthLibqXVsoAYAx61BsSKTJjuatrVi8oYH1tq+75cZL1?=
 =?us-ascii?Q?npmA3R73Mh26wYGWPrkX9+UlGMgomjU2tFtLBzDgzWimGvf1I4StwAp+2J4G?=
 =?us-ascii?Q?yHG+oA+yBXtUbq/TISf/Q+5RiWrP1s8orTgOXWJghBgZiKDrMyg7xJPN8wo/?=
 =?us-ascii?Q?g6gYZ5Y1Q3jNq9vK+qPEhL/udS9wOXzmSzQntp5PyCvlb0eKVQNHMM0RpMcA?=
 =?us-ascii?Q?H4zRFFiPX3UUdN6upuYTESNnMxUQBKCB/SRMv37uWDg6jPI34u3VuEHpcsh1?=
 =?us-ascii?Q?8eq3vmxpyNm/Q1CMMvLd2h6r9tD7MampUgbX982TS37LiDG7YWluw/GVTklH?=
 =?us-ascii?Q?j0vvRd+quOPjEFlBoHDhsRpYpnHjlV+awunvRnADDIiYY9BeY49Gpej5zHFu?=
 =?us-ascii?Q?A1KYodGL9aIurq+BYAZuhkP6JclX0ba5Rjin981RBgAwbK5G3xwwwCEiSxiy?=
 =?us-ascii?Q?AHYtW+JchGbi26VdMkIzjE3QqWic?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:10.7681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357eeda9-f4cf-45c8-31c5-08dce880e700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

Now cache entries for hwpt_nested can be invalidated via the vIOMMU's
cache_invalidate op alternatively. Allow iommufd_hwpt_nested_alloc to
support such a case.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index b88a638d07da..ccaaf801955c 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -202,6 +202,17 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	return ERR_PTR(rc);
 }
 
+static inline bool
+iommufd_hwpt_nested_has_invalidate_op(struct iommufd_hwpt_nested *hwpt_nested)
+{
+	struct iommufd_viommu *viommu = hwpt_nested->viommu;
+
+	if (viommu)
+		return viommu->ops && viommu->ops->cache_invalidate;
+	else
+		return hwpt_nested->common.domain->ops->cache_invalidate_user;
+}
+
 /**
  * iommufd_hwpt_nested_alloc() - Get a NESTED iommu_domain for a device
  * @ictx: iommufd context
@@ -257,7 +268,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	hwpt->domain->owner = ops;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
-			 !hwpt->domain->ops->cache_invalidate_user)) {
+			 !iommufd_hwpt_nested_has_invalidate_op(hwpt_nested))) {
 		rc = -EINVAL;
 		goto out_abort;
 	}
-- 
2.43.0


