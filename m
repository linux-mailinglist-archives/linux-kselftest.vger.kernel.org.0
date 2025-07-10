Return-Path: <linux-kselftest+bounces-36904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A460AAFF8B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E733D5643AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EFF2367AA;
	Thu, 10 Jul 2025 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VdAVgvhs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9513B280;
	Thu, 10 Jul 2025 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127207; cv=fail; b=MWQiXQH8B+vVYYu0HSYNQvWveSpN99GU5iwcNqN5EMSPuAvpwDriIWR9C9f1Yu4PJ5Cy4k6M8Qg4+1Bokycs3iWiunUtqsUaGLy/T5fWlR7zRJWKTNu0NbhC1Am2XUEvBDsGfWbtNRFaBk1Xk/2gDKu45gRz85bA1gs4n8zVLwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127207; c=relaxed/simple;
	bh=2J+j32eo3dPCDRvxdB6elZRRB1LgpKPEa7yqvlEGFgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjxVbUdCb3XnS7FIn8gY34LTIoK7cxQhFbGZfXwy1G4VMhA3OxG9pS3aj2R9trP763694Tdu/6uFPjbrN/bRTLrVfQFXkpR9mHuHPSmZ2mr+omRFnpHrbcG0c83CXbOdK6NQBPDGlS6UkP7+cT0uMHjgS9JIwUFcCais58PJsxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VdAVgvhs; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLWgE5dJEQ3wUU10d0+NlyBpSfaRGEBXp0LECXE+1YfmiMEKne43GMPamRe7MZdOqEF9ob5inBHkFBSopRafF+dkVaJNxEYx9EHr90cTv4ODd5tObQ6TMjQpXuKG9Dg9bBzCaF6VmGsCXYjy03gAA7TSL9/9r+IjEE8+d5PkQU74bsajKSHYENPxmbW/J8fk3uAJ3PjeplIuYZJT011ZtqHZfdmy/GnH8N/HUYHYiJlX8f6gwWpQrk/UzeJ4PBjWj/lVOHZEEAAbpH8pwvxpfJr38myS2joQbADSh/8fiU08wGhUByTWlWg4BM+BvjfArI+87dRY8mDyLy23aNgdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BnabqTncymFIsnzldAZgcWH6gkUjxym7aZDsKbUhlY=;
 b=pe9m7chcvyX8PNpiYpV/CZbBP555MSFAV0sjeFIMk9+ZWMk7ZDd1KK6JETl/t41PA8ZUsCBMbLyh43HSbLr0evfrflnSMl/q17xlOKxU9NR4XokV8R7+5E0dfKnkaM7QWbpKZDtCkBpY0TXR6f9om1nmaokYv9DpSPyJU67pyj50IUdk7nGeB9VIEP5xwMblJmhUJrCEzQdtHamgVqEnqeFMfPcKgcT9jU4KXbCih7xC398U8wPNg0o8if3KskqECMi5+NEktjeSSwxkOvLMkf9hjXWcJXUeJWWuNnJ2KSFqiJAAKEI6xiu0UWyvHT5fgexIivAEF/LYr6vF9KQ08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BnabqTncymFIsnzldAZgcWH6gkUjxym7aZDsKbUhlY=;
 b=VdAVgvhsCymbcRXQeyS/MxPKJY2QL8QNV7oH9dSMLr1+zm+gwD5x76jHwSPzQh7TQckOr7pj4WpUbkf17HV2Uri9RKICC6P9zQgn/R9Q8cE66D1LiSJJQLs5h/9vuYUhz1ffN/e5JaxXS/xIqErEX8G1uE4Fl3I48nVMY7jTMWiSK7U/KIIvSzcZQN4O+9xhJ/F6xDAmRj4MZok0GFGwBUTqbj6OLi1M5wsAleT4T5id6QySkOzyAj3wsTvvjge0ED253pio7MVtVo1IJZxyUYrJ9P5F52ePTSg/+zzEoRJzhLxjtXHIl6xSwYmLEds8EItfAJQPXVShA1u8RzNiIg==
Received: from CH0PR03CA0398.namprd03.prod.outlook.com (2603:10b6:610:11b::29)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:00 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::88) by CH0PR03CA0398.outlook.office365.com
 (2603:10b6:610:11b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 01/29] iommufd: Report unmapped bytes in the error path of iopt_unmap_iova_range
Date: Wed, 9 Jul 2025 22:58:53 -0700
Message-ID: <e2b61303bbc008ba1a4e2d7c2a2894749b59fdac.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a82a150-62f5-4a02-cbc5-08ddbf770181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b/zM/HywbG360pl8CfeIVuCC5S8BoftrdTi12KwWGUeNvORr4mInB4uItsQq?=
 =?us-ascii?Q?3HuDCm7g+//U7F3nn4NU/1lc96GA60L1qkwUx1ZyIFFDASexB0vf+Gb3T+xt?=
 =?us-ascii?Q?WO1WWT8PCH3zJLocixv+XEWsFAMbBTpB0vc6j14MIiHiFRZrqfimhQllwJZl?=
 =?us-ascii?Q?RVktmlgJ9k47heBvzeZfK3XZpTqBtg+aXPdyszLCqv+wj8Y3mvVaD8J/0ZiJ?=
 =?us-ascii?Q?x5M4/jR12XjBPCPlKWMEih0mmqi5daQhXP/+etAybcsV1n0q4Vc3Zc1t2eCy?=
 =?us-ascii?Q?ZZHdYcd/o44pGVrOyvKIg6suxaHg2jDqLPTfMqHtNAqpdVO/9mz065MzRHg9?=
 =?us-ascii?Q?UJ7hUsAD2RvNcT0j+j9aUbANY/rWx6u+gALKmRdNc2aKGdo4+b8kZ1UNr4fi?=
 =?us-ascii?Q?E/syfYo4/1t9SrHdSxSs1pOHDHprM0t4NnVJDMWL+M+gHE6xBFbg1gov3amL?=
 =?us-ascii?Q?PDMz5QeD3l+xvry1fkFkTKj1qyuN8JD2SgboDmXahYnK3qYUyFEVcpad87JX?=
 =?us-ascii?Q?Fhr7Nrta+mG//AbieMJt2rIrNEZM4Rix8sQMWBJxensCtmii1HAYrRgaqsWE?=
 =?us-ascii?Q?rRuGfjUlRoTVbdJE01hrlysOKQckaa/SyyT5VHckQxxiPRx0Fa7ajuLXtSx2?=
 =?us-ascii?Q?PKHwgYITwi8o0MdF2jOVzdWsuZEvV5c0p38IVuznjvgWyEKd6wNGgPrl5IJD?=
 =?us-ascii?Q?+CIck0ofCU7n35oNMakn0D9s3fXmGeG8iEd1CA+GeLn7vfsw5jDtu0g3po+I?=
 =?us-ascii?Q?Jk9xxAVXkK7hR+DsgFmEcZ49uoLXEx2QNDZjeq07taZTOVAjfVnW1ZYsMNGt?=
 =?us-ascii?Q?dojTkpUwUmpFzKnX8M16Sk5JPFQ/qFDaxfvIhrKkJNDtD/z3Ujp4Sh3BEkQ/?=
 =?us-ascii?Q?5pr5N4kP6JGS0lnv9crr37FiB99W9QXK8Wv8k3EMJ58cNcc5HdJLkT0MbafT?=
 =?us-ascii?Q?w+0UYZ3ptKMqTHk+r9olo/K9OQge812gHNwwiNSU9XUkA+HeTs+6riq1qvqd?=
 =?us-ascii?Q?fUOEvHuksUx1WymbnXkcy8Ou+fpJSHBc3lHcPIqR4BMlWyDPE37DWLBSwquV?=
 =?us-ascii?Q?uQyqbEYfgLwhAqGVIaclSTMmLCzYU/ynCmF+y8RjtG2Pru6GWS1gnWWPkHwc?=
 =?us-ascii?Q?d41IToQVoXFMyYAm4kbVeqaq/ZDFiUvVe3p7tU1gRT0vogRuQBSg54kf+HsC?=
 =?us-ascii?Q?YNl45QADhlzeQD9frS+6P2TVEd00cn2HSUzE6KZE2qjlKoNmHkiXzKScWikR?=
 =?us-ascii?Q?/ZJdV4BmSdVfHDzsGbfif8ryLFvx95VBWI7z78mYdkNpl8COxYZuU7GM1/lX?=
 =?us-ascii?Q?ROrzalvcaX0VjXPckpYxYkQ5sdCz4n+Zd8BqHd3BAmTMQbs4cba2iZVnQvFm?=
 =?us-ascii?Q?Pv8drjJ/tRSdkSn4iWzWl7o0/P9haxvVd8znB81IIhS2BKbH4fnv3O1FWulc?=
 =?us-ascii?Q?s/xuFuiGce00GOEbee1xmdXeqcGRhpilVGs00/tjkZCW/b8AEuyQz+aJrwqY?=
 =?us-ascii?Q?6pEf/bdyjFNWurgjHPG8Hu+FAaAk3nIRUE3u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:00.2254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a82a150-62f5-4a02-cbc5-08ddbf770181
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

There are callers that read the unmapped bytes even when rc != 0. Thus, do
not forget to report it in the error path too.

Fixes: 8d40205f6093 ("iommufd: Add kAPI toward external drivers for kernel access")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


