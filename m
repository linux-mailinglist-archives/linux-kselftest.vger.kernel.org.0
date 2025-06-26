Return-Path: <linux-kselftest+bounces-35887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B1AEA688
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6321C284F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8222EFD96;
	Thu, 26 Jun 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKcY2KS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76314253F3D;
	Thu, 26 Jun 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966523; cv=fail; b=Jftdg2g8WENJRG/TpIZT3+aUIheCJqByBcNQ5XcsltL3YcNKqdfKCxcPV2fROxsnxEWpnYyHJs1S/+jiREUlsDgUOvOc2LGlAApOPjbdvL8DWZBrUDh937sbE5Ktg6I+u91pf++vL2MSSinkUZOyNDQVu9CThOM2i505N+YceTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966523; c=relaxed/simple;
	bh=1JUVYv7VfsC86vWRVTcTxxfBtmg7jBP7WOOO9DXAFf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPq5+IQ5uRq+g4IR3nCbvnSCheqw1zC/zausg8dyUaOKe3Z2NQdNSt5rvLaV/UZkPXpu8kZICpZuJS9U5EJPK8xBGB81SJY8RErFyvBgH53PbYnoKAZ0crVOc+nWgRPaxpOn7lkI6aHfVc2tchh4w/FqjJIww3FF8/90pc6jUIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKcY2KS6; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt0OXnJd7pg7VkLwFgWTcwrzR4HhrTjR6hc1k2TsSYwlGE035WJhjb2t0Xm32bV/BwNgfA8/M20wHHNstMG2qGf1OQMHDelZRMO5yc6nhVuJMbSYwHrjfkSHK1LHUk/QJ1WPBWV5NHpuv2Yy2gsiogcS/gK+YE6j7x1ob6jXbxX0Nb6Q6cP1kwEUH8n3d7R29pgozs/zevvmlG7EemmQ3xWA0DhA9VJWolNLcFEtl1UdDR8h8MI3jGVBFtKmTIbPl2Mht0u8u0YvCT/6RE2QTtfN21DbNmOmV1aXT0qCqGBOiNvV78SYhgaatvDECTCAEiZk1x+gjWbfjBvmFE25bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2f8EYjthoS3VOx1IkRkVlfr42dHKFaCafW+xsZkPL8=;
 b=O162qqt31Ca8+kLERqVro6I++TMOX+cszTwnn7Dp6HPEa7HU+A2NAg6gMXzldmltZe73+cs+J4GF7DD740tId5X1BWCXlAEENr47MrzK/vPh4P4/A5KCddvz90vVShBO+GOZMNO4DZuXCGy52zj0zX7umByFSXVTohCg5VpgH64gkMW5cVmLJqY1cbbuH+eozc8IxQrJHf9YvSYKMW5yl+M0XRFGmGFtqJSqpT7kAF0MCHfOiQleh0Ri0jF/wPQUWg2uJdIy+9t/CZucEr82N4gR0cCfHOoQgPYNpwUZ84pZksMijL47dVapBLcqgOi5jjMkWF5gnQL1MYoyhnFvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2f8EYjthoS3VOx1IkRkVlfr42dHKFaCafW+xsZkPL8=;
 b=UKcY2KS69YOCIWEt38iuG0QvkB3YBrMNA7vGuaQzgwy193x2ts6v1QLg3q6SOGCe2Y0VDqw9sJfpkiXtRMG6MAJz5lXTIzaMktZiUXj08oeia6GGaa+9H9bxxY/h27OwWro1WKKL06XEgNJdOLpSNkZvX65ut76H9O+D6ckHaGdU3nhmE8dQSGalTr40CuINDerRnIuO2yuZUdja9FJ3S+Vrm0tzabOA6Gh3tqKd5uJW6yYeN3ncuPzSSqlUgguLzhRKAMb7hfe8ImAtsYfk/qjIU1N1b1dtzD22ouFNqQ9V6zFnDonu2XErogGjH4fRk3fz7lrtt7gdrEJmywCRQQ==
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 19:35:20 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::51) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 01/28] iommufd: Report unmapped bytes in the error path of iopt_unmap_iova_range
Date: Thu, 26 Jun 2025 12:34:32 -0700
Message-ID: <102e38967b38c28abbe8ebe70b39dcc8e14450ba.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bf07a4-8bef-494b-a07c-08ddb4e895d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TximNwzwD+OjZnBSAIVDW58gCA5iVWI/nHWpKetRYOIE5HTn2e+pxyfcKWpS?=
 =?us-ascii?Q?dx2nwcKFIAyiepS15fHTedAfdO0TDxYr8pawm+9QSVs1UgeWbeG2g8ufJqSq?=
 =?us-ascii?Q?qruXyn5yZe3P+KkHEd5Yxd9LRG/Dwm7veULi405OpC1tANS2UxHcvDGll6hR?=
 =?us-ascii?Q?pWci4ccA2X/T6MZro10eDYAGfSsgGsJN0jyxTUTe10deB2PyyjRKgv5aYCBu?=
 =?us-ascii?Q?f+L0X7HnHA3vpBRe0X4J8qxU1Q7rCZFK7PoiUFPb3SIZXx8RGP3b1bE4GOut?=
 =?us-ascii?Q?0ZE4FUKlL+QdI2BVuEMT5D+EbsaTFjHExAPZI7Jhp+EkwF8w1jDvFgJiEhOR?=
 =?us-ascii?Q?TJ7G6OnlVC0vHbikIxYaapAOmq4ixblIh0lNqiPolzTEdaubStjxjiY8i7Aq?=
 =?us-ascii?Q?pYL4NmKyfIbazhcKa1KWOMQRtVino92DfvA+0Rnmq9D5X4MGzwBUaz48yJBN?=
 =?us-ascii?Q?ljMlRDhyaXmgu0X88IoycwgJ/5/un7vM2FKh85FO4GqIyl/iFIPpR3+B0kUp?=
 =?us-ascii?Q?swpuTgosduml/3fJaqMjXfGrUewJXiBz+Thdxij72VY8mVOiGpJOCdTP4Zn1?=
 =?us-ascii?Q?ub7I0nv9jgFsEuRRl8VtR4iYileKAp1CS9mSx0NqIKwml/SKRJq1qZj0xIQH?=
 =?us-ascii?Q?XUKLSlIIOP/QjTVEV9HPFJqqCCAa0QZxeXcRUaWjLRkZqiDbUHkwWC1eNVfQ?=
 =?us-ascii?Q?j4OXIpE7PZQ+imJvZXla10yjOiQFlpL1K14Zmh3SsHsoitnW2EGp1LiekWbv?=
 =?us-ascii?Q?qYh82WKEbsuVtyo4upYQJZI4u8U0dGVPF3mNjJrPpeo70H4sZK/szjBWYyzD?=
 =?us-ascii?Q?3tIIMCIMm837Jvva2KYTP4YAH1YQfxZwXTJSQJNI1UT7R+aGSJ8bhxWTCDPR?=
 =?us-ascii?Q?K6UxuROHWZvSJIN7ukUCgqSG2rdQU8/bvsGXNn+kpIWwEF+XwWgWhmW+Uam/?=
 =?us-ascii?Q?Q+zrIcyBcslMplF1e7P2NjGNiKhjkQ1WpvK2WwbW0XwBlfj+WGPpMnX7Ri6p?=
 =?us-ascii?Q?ad6UtlZkApT7wquxambQxwskp5BG/I3VKhueyh92b7bkonL+vV/v7YBRY9yP?=
 =?us-ascii?Q?tLI1rYUAbVbrqs+mv1xbChUufbtPf4m6bITSJV4HCNop1hL86NUS/HOuEap/?=
 =?us-ascii?Q?tCDsZFn8xMtpURMMv0aTJdDUrSHERRT/87vk9Y8XclBOCTHs1OsKV49na+TI?=
 =?us-ascii?Q?w6erBdgZEBKZsnDAXrRBLABL9iy0Bdn4n8+JOCTMA5z3qOQTFwFYRNbQlipd?=
 =?us-ascii?Q?d+Psu2zJvQ4Ys6V3wfGTBvR1ED6qyF82iwSpjmS0srikplcu+s+e0Nm3Iok/?=
 =?us-ascii?Q?JtEYDY/MHl7qNjRL7OLuvEcA79oId2275zqBiHEEF40sxqRdERp6WnRlcCJM?=
 =?us-ascii?Q?cX2pogJYDkkdxmUu7QcxFds/zIF+uJ2L4MDOxSJarsWv6EaOe/1YTcApNKtu?=
 =?us-ascii?Q?Eh94ztOuK1d7MiBrOdyq7+coelQjCjxBe2BKTvUDptE51ZvW8VNnfpMiAx0y?=
 =?us-ascii?Q?llRhrXkQz/3o9bY3a/tFE32LJHT/eweBnQZ6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:19.5211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bf07a4-8bef-494b-a07c-08ddb4e895d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139

There are callers that read the unmapped bytes even when rc != 0. Thus, do
not forget to report it in the error path too.

Fixes: 8d40205f6093 ("iommufd: Add kAPI toward external drivers for kernel access")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 13d010f19ed1..22fc3a12109f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -743,8 +743,10 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			iommufd_access_notify_unmap(iopt, area_first, length);
 			/* Something is not responding to unmap requests. */
 			tries++;
-			if (WARN_ON(tries > 100))
-				return -EDEADLOCK;
+			if (WARN_ON(tries > 100)) {
+				rc = -EDEADLOCK;
+				goto out_unmapped;
+			}
 			goto again;
 		}
 
@@ -766,6 +768,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 out_unlock_iova:
 	up_write(&iopt->iova_rwsem);
 	up_read(&iopt->domains_rwsem);
+out_unmapped:
 	if (unmapped)
 		*unmapped = unmapped_bytes;
 	return rc;
-- 
2.43.0


