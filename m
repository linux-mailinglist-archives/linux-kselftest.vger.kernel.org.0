Return-Path: <linux-kselftest+bounces-36609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861BAF9D17
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FF91C27188
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2C74BE1;
	Sat,  5 Jul 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAaD/mzp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386579CF;
	Sat,  5 Jul 2025 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678043; cv=fail; b=FBFiUiIBUgskn0DlrjLG9bpTrmRGfDdSn1iN/oOIAR42fJCPyhq3Q1Yuo5MGznqlVfKS7b7qsYbwICM3fyuLY7ESo9xxu+QHsn53msOIcxTIMhME3jDVoqGD6v1RRCDB+uOt0xr1I6uc0ulmDUj1ExtZSH3yVwF98WrEfJfE1Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678043; c=relaxed/simple;
	bh=2J+j32eo3dPCDRvxdB6elZRRB1LgpKPEa7yqvlEGFgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX5cMMf5J/UDDlt+Efqo1ZJ1WfuU0eMvczNPDWAP9LrqI9CBOpDeLEWbIlpj3WwS4PVjd8DdwhClE3mhh+QmadCX05K3SPVbakG40s/lcQlWJWacy07tkIjnty+f/DswEgWJqvnbFnbDJhSxRia8RF06QyWjGy/Q1ttyW85aUMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAaD/mzp; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7QwOUu8EhgxhNddcxyPyLcxSFuQ+adOLrH9voLcUbW3Ghn/pdC21pN32Q+ZAe61l2FSjUjcjtzVWC9NB5TjPxaCQKnT8zvSI0MQ2AAur6iNEbv6Kzfxpbc62Hg7Bj+SGU1F/OvkMFIR4YL1F3UAbZod4140RkS24n5I/MgbmqY8cU30dulI377zN/WMspRRVsiRXoCcuUTomedLW4SIhVw5+K6/VKVqWZfkayNQE/6cHblECuMhjmjm9q+upk1xdbwg4eljrkuvcne4q+p/CxejFSuWFhRPxrhQs4YgRcUIM6iASCI2AAnXrcBzBNY7byu7PLGzI15hl7MGhbTS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BnabqTncymFIsnzldAZgcWH6gkUjxym7aZDsKbUhlY=;
 b=TvORtskk0m7vrOf4KGLczormLdYavN5ihGTC7eusWJmaGLppH5q8QJ3ewgZC0aVsUpotITedWoR0Zxi//jUwLxsyI9aGzG29ZHheQbwNcuuqHnFh0DVObZpy2OKZgNiD4etY7WtgaaRDrTrM4c1LtdSH3KBnqOghSuGTHKyBJbxDdLwicZsFkbc5vRzuCJeRjZrbonZGMLEmX0ffUHDHhMWwM2bh44RHIuBuDjuo9+opRjgsTZ4PtsXzFwOit3kLmo/9x+kn8vN0SYCdOsAqcUkHDd+O49PgFzW/tqUBOTwLI1e2V1hwXvyeRTEOL3E74iAhlgI+SSTqEEYQsIZKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BnabqTncymFIsnzldAZgcWH6gkUjxym7aZDsKbUhlY=;
 b=RAaD/mzpQg5aNujGqka8uVzLA/IVnafWfxaIQNBjcOJ3NYBdf2BIz9mdA7Cv8ygbAFpXPuf7JVmaEcA0Tm2/W9did4y7tyJwt84b55WJevnswosDn9cVAOcl5jofZa+Ii+nPbN0xa7dEBX4CB8XxdpsDao9Zvv0/RRV6n9ung9caWO+mJhHbbcn/+EpGa2D57Iq+KlQpy6l/NJPZP+9KbawjcNEy/xMMgQYi0TNcendoBkrAxqLMQxhJ2PuFyAS3j1lLTEldiHz4OGN6bUezg7y/JjF5S/VgpxCZWiVQTC27VOXug470jZP3IsN8cwhDjiWjdMj0h7CgTC2ZEr1olQ==
Received: from BY5PR16CA0020.namprd16.prod.outlook.com (2603:10b6:a03:1a0::33)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sat, 5 Jul
 2025 01:13:59 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::6a) by BY5PR16CA0020.outlook.office365.com
 (2603:10b6:a03:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:13:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:13:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:13:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:13:55 -0700
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
Subject: [PATCH v8 01/29] iommufd: Report unmapped bytes in the error path of iopt_unmap_iova_range
Date: Fri, 4 Jul 2025 18:13:17 -0700
Message-ID: <7da10d5887b88ef9d1231dba152bbd83f5403aac.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b44dbb3-6294-49a0-26d6-08ddbb613847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ijd5M+CU7KgGra9vu1JIc0RugEPa4V/U3PDBN2bmZKyJqQI0d2ny5Tq3AXd7?=
 =?us-ascii?Q?ADSXbUTZGS8JCxsT2Vcrz8c4A6LpcGTvjVWeDW82q2+IpGUU8wG/GWw4rTTP?=
 =?us-ascii?Q?O4aCrMGIZOGIPULuHZshgWuLc4VKdDgtF6uTcJL9bc5VSXCoZ3moJDNrpOGn?=
 =?us-ascii?Q?QPvgtg1z92FZ7TXTFHYkq4V/l71mgyAi8NlHfYOoMDYfZKl8ikdlQOGtrtcw?=
 =?us-ascii?Q?BzDJvpjOOpEXG4qWVkU+mYNtNii3ubLvDhnfRXuH3iRMbP8WMn1m9J+G9N7t?=
 =?us-ascii?Q?+e3KpsdHAncGSAYwbJZpIn1OmBDWIxo7mO6ZCQU5MxIVELHc07ExuXKujVd9?=
 =?us-ascii?Q?9CnzDRnwrJ9xQ6w2zGNBgpvbDf4EcFgIz4q0oEJ69XqMRkL3ckW6IkuJ/g/l?=
 =?us-ascii?Q?nyhXzOrR2i5BJ8xCnJ4XwqSjBAqu4+wBQHUFhULJwSc284noW8/XmSZK0awQ?=
 =?us-ascii?Q?Xcbtu3+M0rRB1jaS7GG12/PEBO6UhHs1i3nH7kuBERx1oEnpDs3ZTKVarIFN?=
 =?us-ascii?Q?xDy0h7JSB+X5NXrwhN0JuEjToPGsSitboQ/1NPUM09+E0W0lhG1t+PcyoNX8?=
 =?us-ascii?Q?YWC7vn6qgF/mUwi+2A5e0KbI0fjZ0pJcU8JZzbAxW5nARfKaEswMMEZKB4IT?=
 =?us-ascii?Q?bv0AQPMD3vbE5shxJRVShPTvMr8xXov9H0byrL6SCPcIZKp27/Qcts0RXAG5?=
 =?us-ascii?Q?/p9iivN1yBarklG0ixuIwxQlbjN7+Xv4NJNf5/yJLINKfdTRR8f8MneNjjat?=
 =?us-ascii?Q?lzYSBI6dcYeVR4ERgFa4iKw41Gax0IcMFguf19YX+Rio39dRT16h8bCK8hO3?=
 =?us-ascii?Q?J6MuZTgHL5x9z908S8rTaC6xUgM81QqPxxyTw+7UXs1LPwyNOeNdk5VeqWPe?=
 =?us-ascii?Q?SfokATxSYe64Pobh6GXIVi0OhzIzCgnLAUJ1c8sqwy2HwvgCFCvgTHluZaDk?=
 =?us-ascii?Q?hTeA5riHUQEkDpc0S6oAnDPl2RHYoTMQiL/moqMenyjI184lXDjVHNkYPMIL?=
 =?us-ascii?Q?rdiF+RJNwHflqHLwIG0Yly5q28t59GikX0o/93lxUandyOyZjregw7zt9KLS?=
 =?us-ascii?Q?5hidQuCLJ/HU+mNl2Ec4F5aguK5ZYm/kS5FXrFh2crRyh93jFOGmJVvbmpM+?=
 =?us-ascii?Q?IeD8PXOGlNlu79C9q49j9h2fEOyyQse+KPhsQjYd3f+OxBMYD1Y8l5SWLODg?=
 =?us-ascii?Q?99BvHUy8rLPyoZs7YefmGBhi47Dt+J6h21A/kR3lBvIl3pLHJuUjffbJx3TB?=
 =?us-ascii?Q?njVZkQ9qCASlGBQt445BA9Qvfp0j2UOmJ9kuHJXdP16+9omKVbu3vwd2fFsr?=
 =?us-ascii?Q?2gUonS277X/qdSZCkLSBx+Ip5xyUG/pWnP+RO51+DvIZa8Zp9zRwSsQDGWW8?=
 =?us-ascii?Q?yb8MnjATjepVo7OoW5wuU4BIla6aIbdAWlbdIYLnmLjPQLkp1INAyESrmQ1A?=
 =?us-ascii?Q?VuaxLgWDEyOJeiYIuutq3ZDM9/qpDp5tJwiMaNdoSedxc9e9cw8pB5k4DKG5?=
 =?us-ascii?Q?WRg8Iig1pcXyLTTJcM+esGRhgwvIQQWQyEm1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:13:58.5918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b44dbb3-6294-49a0-26d6-08ddbb613847
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570

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


