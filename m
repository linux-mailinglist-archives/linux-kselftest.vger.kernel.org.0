Return-Path: <linux-kselftest+bounces-32130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB42AA672C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E233A5D57
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA3727E7D4;
	Thu,  1 May 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FINfwVO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6C235076;
	Thu,  1 May 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140563; cv=fail; b=WU43G3xB0lI2n7T0Db8Ft+/ksrwR35G4PGuacR4gjPIW+oEUeAeHbyR9/XzJ9pQ1m8OmHVf9ItI4Aq0JoYUNsyFaoopJ650+9QwX8oCGyHuBE2QFv6NZAexmmKAYZf2bF7pWQcnUI8GNfphiJWJyzUlMe4kX8xh8c4odu72qf98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140563; c=relaxed/simple;
	bh=3rkEmrBg1e2KDrtu7aysQH6rDOdfRUkpZX9Ryvb51Qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez2l8o4Y9K0Dk34ATowD2lOIgBuPwHIEwPzACnb4frYusGi3RAK/YEUL8pU7TU4FgbAAEVYuXXDrQ8UaAjcPFgsdQHBOcaA6MPuVEyz+fQt9voKfyk1RUF5/Xl4+hzdtdd4G2Ie/V6OPdL/86eAqiO7DSue44CkZDZYXuQub3i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FINfwVO8; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUrBqRk86RKjrdWQjCovSScAPqvlBilv8MGroydTB5bwovvGCUTD3Ndu644Xc1qjS4/yXjUmnOQyLuo3ZqWjznl2yt1X1Oo+NV3qwzh0VM7exKOaItLJHOMMZ7xIGtfl4v/HcGIvWP9tBfms0rimKgZeY1pqwNVwZMobD7GnONLPOpnpeUgEX1SqW81w9vJIZSZ0TREXKKtxrRzcZkVAhYgUBlUsWXc3R5DeEU6N26ZeeX6SAIoibJ6dyrBZ2f1vDyikxGKK8aObnvaK8pads3rC64Zc1AIiL/k4ahtSnzXnUdi/AxKcbt56z0DcabETWZJ3AJSVCVMAEyGzhYsGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn6044iiGT0BmuYHa+YrkuqRYn+AFrLF0MWGm0vklJM=;
 b=kcKi4ECg3wXUe+dvvBnJ96dxd/4YNHrW0aCEWTuOGYSKruhXgcdCiG0rVnVKT7ondh8esQfbFr81IieC92g3wPn6JliY4VtaMdTnBMxbTmlMlzHxOPd0oHj+yLcoYHBY8RI/+x+0EfRxbGjBSUdn1tUM4it/UlmwuMlQb59vulGGaoeLheRj4QCCczHk+D8w3HwnTxDCWrC0ffLbyhNkAoQxgUNSN1JjpxDjf5112f903TaD79gVGUsXhMyHFjTUUS/dquKRQ9PVkrV/WfKpCFUZKdD0nkiHcLWxKpZv/VWJf4vY9+kNMxDl59XtJVunGxa7BMWIC0+JCUI49c8XAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn6044iiGT0BmuYHa+YrkuqRYn+AFrLF0MWGm0vklJM=;
 b=FINfwVO8Q/yxunKv6EOeXZBg0Q0Hn0S57AIvTEmSXDgS3cahYbwNffNCDfSQz1jcDUJHUJyVhyxsA234wtH3pOAzPedmFtvFqUlo8EtF3LDBMa1p7XinCE+mRlPoBE4M8pLOd8YEYTybj+1FFJTc4ciOxlxjBx02cqKc6bWfYjAFKo3wTruCO2iapUEM2NQx3Hxo2uK5ebKrprC2BDd/afW6nsczrG931THkgfjey69bjAdlTbWuX21N43x5Ym5xQGdxZMIYg61zxvP/oB/3md5f21T06YRjws0AFCM6lpvNxsPSF2kaELC+G2WnJzyBuEx25skDMUycFyOttheHpA==
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 23:02:37 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::58) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:18 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 19/23] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Thu, 1 May 2025 16:01:25 -0700
Message-ID: <a0079db492d0f578356b43badea4d4417346af6c.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd8d162-c062-4eda-ec42-08dd890443f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIvIuPM8CKQK3v4qCfT2SeDRWxGV1cuYeVJ3UbX/3eeOSq3WgnDnHsIQi8em?=
 =?us-ascii?Q?r69xKyWarO0IJ6aKOX041/aLJmsf7kbi1u5VFuSeZYLN4mJhVTkQHwA+QBcY?=
 =?us-ascii?Q?kORuU/nqXPWPLv/MOfVFtft9a37EXE2GlLfQUKpBmJG+bEf5w/yLzYwAcK/r?=
 =?us-ascii?Q?krHa90weMBHYjLMp4jKWIlSIE1Hx+L+aTS8Mx1jsTascYemXW5u/FNK2QN9M?=
 =?us-ascii?Q?HSxpudRwLORGAnlzFZosgO1xYEuIz3qp4P2wn1+Jqmiq8l4Vq43C15HkSpk2?=
 =?us-ascii?Q?tT12Eg3j3/v49g/pk8ScmWCuIzpc7b82PmUU285GfPQEzjP+uUa7CJ2pMiuw?=
 =?us-ascii?Q?WjlBxRo7K+tjFo56GyaEnOUX0z/DjEf95sgv+UPGYbsX8cAsIRA6+Y4YQ/sm?=
 =?us-ascii?Q?8aV9RD7ethsLA3tc1PQa6rHxu8v5NxErlQBClkcI5K5iBJRhvBS6Nyj09Yzq?=
 =?us-ascii?Q?W4c9BmWhX4V9UFcba9yNkKHlPgQ17rUKcppQ33E4qg53ol2wRJDi2P8gldeh?=
 =?us-ascii?Q?RcIirkHZ3E3faF5VFkbJE/RvP1cQ6XloOf/e6hEF3NAemF5iobWMqeX89UDA?=
 =?us-ascii?Q?ADUPChTfLxfD4twX3edYrn+0WFyghppY6DcA7fdJ7uFg6Ke/KoAYX7Yfd+K2?=
 =?us-ascii?Q?gpDA51RxP4d4hP7sK02vMH/BMcPYO47BwYS/+MsTANtbJ0vDR++qoxyfXg63?=
 =?us-ascii?Q?Z8IMe7I6O/3mibrAlgA8NwfcwNgdCfd4e0P/ZaTKPePlqBr6Hl3WxWwGCX/G?=
 =?us-ascii?Q?5BhD8tIzwZLI+QahjUSMUHipr6kouTfhmzMUoMFf0CdkMbbtt/Yti98sv7jG?=
 =?us-ascii?Q?znNu+yXDXxtlVn1n+JHsy5mW+ywE/zJEhrXv+LlnETxT9U+Gmn0u0Y3NV3md?=
 =?us-ascii?Q?nMOlmXH86C4wYqFiBvinfvDm2z8xO0Rmli6Ey45arHCr9GeBTpYRkdjMBQTc?=
 =?us-ascii?Q?bvkspMKg3Oi/wllJYRjrN3J8yutawdxa2pYERm9QgVOAVDvagLMOjXlBPzha?=
 =?us-ascii?Q?iPamVjv+XRRcDwSmspFeJVPu//kkgRrnJTK/DRyNTQvR4cDyeYY35SHyP9z7?=
 =?us-ascii?Q?+gwdV+dSN1iTyu4K3NhOYUJaDrOjNwufx6/mFDinIgM+AcuQ8TCXOJIeBJvt?=
 =?us-ascii?Q?y3F1dR6ADPBEtsIF+WNOfKOZ4Nn3dFplohI8A/29wOwRhUCMGrahclH6PFGs?=
 =?us-ascii?Q?Et/IGxcibd/90uxp61DIjWKT5hB25Pdqqx+dr1/jZBr95X4z/DgOQcc7QSM2?=
 =?us-ascii?Q?LhTUZI/WVYN+cbT7sATkUG4+zWDvvpfC6Jlx9tUQKI8DYaoQGpAOzEIya0u7?=
 =?us-ascii?Q?kxo5+4GoX+6gBEzoLhc/xqjArRba9ZLRlpo+oONmAKTj9fiRWww04mhvPumD?=
 =?us-ascii?Q?gNSOqKdoGHvP8H0wO7CPGaIj7AA2Uk4NwqU5spkJbwv71obyFayk5FnQPwlb?=
 =?us-ascii?Q?n7Bi8vPEVKt3ZGDBngn1mPv1vxjS5Zoz/xPMIIVZxfJ0uuRrQCPmWxQfaIZL?=
 =?us-ascii?Q?wJdCnrgikRrv2oI4DvVTtEhHBNYnejq050ki?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:36.7817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd8d162-c062-4eda-ec42-08dd890443f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

A vEVENT can be reported only from a threaded IRQ context. Change to using
request_threaded_irq to support that.

Acked-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index dd7d030d2e89..ba029f7d24ce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -824,8 +824,9 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->dev = smmu->impl_dev;
 
 	if (cmdqv->irq > 0) {
-		ret = request_irq(irq, tegra241_cmdqv_isr, 0, "tegra241-cmdqv",
-				  cmdqv);
+		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
+					   IRQF_ONESHOT, "tegra241-cmdqv",
+					   cmdqv);
 		if (ret) {
 			dev_err(cmdqv->dev, "failed to request irq (%d): %d\n",
 				cmdqv->irq, ret);
-- 
2.43.0


