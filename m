Return-Path: <linux-kselftest+bounces-20737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305709B1388
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543011C21E6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31521C2DE;
	Fri, 25 Oct 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyIUIYoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC921B87F;
	Fri, 25 Oct 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900269; cv=fail; b=cqSdUa8hXuuOAjwAPxlItlZVkFWtZ42WmnEUuK0bFJDEVUYSCnGH0Srz3Un7VTsTmcFRcgxoEp59uxvd2WiR7Qpik5qhRbf6oRSg8cv+dz452GjWFv79FnU8QQDjqJwmbnRUnhGgL7UpBnBDObtU9/tJM6NzdDyHeKysD9RdfyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900269; c=relaxed/simple;
	bh=m6NtazFjDOoXVE0z95akjspYa6tLq34tcpq+ACpra6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plxtq5g81DQWchVQuNDD66vQvb10G3iy8gQDRAuAb3xmvLgCa0gDwmRtqulE/LOlC4PByqKxWbC/ENkjcX6u2RC59cIYEHroPVUnua42lKWx5RPXrxt74d3QOUxGk6sIl5uRLxaJQ02qnF2VN4/5wFNt5UFPaTKvcDFoyY1PuLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyIUIYoX; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlswzoNOLPR/fEoljbJiwrWqUHHgqwqLrj1YOy6TMomV+lXapeBTGYg14X/sTRCzW/lsdQ3k7ZoJjGwM5Ce5+pnftU5v8jgLcbWjQxoY2UahvlDm7Z5ShYZ601eRkW9HJJi1TaaznhCtpEw8vui+J+6eOvmW9ZAAWqTQXTQO6KpCODLKcCFNqdjXsMbk6bQ9z9QQ2r0u3YggEHDYUqX5C69xUrsQ8i0nNT81k3ZXzKtVn2ugSpZb7PCjuTYI8HdfbB3Tzdya3d+1qVKU5Bf1JvVbXOzTbZygv1zksLZVtM10KgqyRfk0669acx89tyZtvsb8oYKn83rZdUwGagvvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv9bI/lX4Seevvti8f+iWh8jttgs/bT+cLQvhyiew1I=;
 b=Yl5Omdm/69X0RwpEdOoTOTut/hdgttw/rjWmLc0GSa7pucY57oo9IZO4w4FZrF8oeT2xzjrqdAdgD9gpyhq7MeWbiyLvNrxFMzZTkviacX7Ti1oWbzYaIiplSJYpj9k+frE/fkJozhqJq/Av2riGo6xa7afHIqNQvrDBteSf24mppUe/iiB2VthD2+ToDBemdl+/jvRHKTpkVJfp5PaCijyuHnleFHRkeVvjJ6vey4ShFe7Qd/wGsuj6f4DDXp7L0ZgaeBmVsBXe3hORL8PEeR7aHufApmwtu9zzLaMmzKxf8jRyHXmVLsuTVJ4x85VotSv8kn/jW5Q+quIioJs/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv9bI/lX4Seevvti8f+iWh8jttgs/bT+cLQvhyiew1I=;
 b=eyIUIYoXsz+bPhuZchNQUoQS07rThApbMoX+ewk4uR0tZV3iCJIJg8H3hZoCrgsj0/0vMgFY3CumBIV0IhBNl2lrTCzZvpZc0RWoC6OaseHIVIb7bC3LuvxDUTCoMAL0gxGMf7FR3tUePZaHi+0FJfdnbfkaENAAs4zqieJRGvInTMWm1D4SqVLG1hNWczi/dzuE1tIRd7mEqFH+g3ActHhxVhTED1GztdMDF2veRkboNrLgQzMchAAy8FhPfOw6TB5/a1ppGuvO+CwQNRd2EA5b37TTJCuC8ucYV27rg0oYeygips0w8rf/JrZ3qtuufGctPkbet/ljyiRqhESfLQ==
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:51:03 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::ba) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op on vIOMMU-based hwpt_nested
Date: Fri, 25 Oct 2024 16:50:33 -0700
Message-ID: <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ce9c59-22c8-43f8-26b5-08dcf54fe287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p6/rKJaEZDv8AT/9ZxYAC14rpxf17jpIPGw9/j0r5AKrI7RxUtWpoVCNAjo2?=
 =?us-ascii?Q?+SvPytIM9okePm0LGYzvCoZD5qBYZIRNRFfhxDCRmnMws+VLknDLsEhaZYhB?=
 =?us-ascii?Q?+Yc6ZYBc9m9bLtbM6vT9ygAB8yX6XEWAMUcRTTDcoChRQJWBYi4cXATUqUX7?=
 =?us-ascii?Q?SwZJWZiBAiwDNcg+arjB4q9giSM0hf21/9cpzTLnvyeYanIja6Qk4x+cQLWa?=
 =?us-ascii?Q?dXE/F84reOTyebYbtOv5V491JiJZOQd/og5ldO/5QVM9vnHFP8NQkNLtZEmA?=
 =?us-ascii?Q?bECx47oPdrBllW2bD1oy7IokTl1GgRbw6Q5dsYEC6oKZ/0e1iKqye/brTriu?=
 =?us-ascii?Q?aVZKfgpo1Buoilf35iCc+EsfSaDhUkQy4GUBGo++9X1cRMO1tCz1Dwm//Zqc?=
 =?us-ascii?Q?eZolZvypEnkNMYXDEGUBv7Fbtl3MoLIwhOsoCpkduPMhBgBecjxkMJNpPPWU?=
 =?us-ascii?Q?xF470LcWpOKH/f3SGFCL/7yvNewpM6so7v3ET5K6bJP0ef+jlAEFqyICgBBn?=
 =?us-ascii?Q?qHt7PlRzRFLi6XFtwmq0QX0476kps0Pyc9QoUo/yxZzHwp56G9AS2vrcOnvb?=
 =?us-ascii?Q?sNpxZXPd4A8umdvfI1uudeiChxr2SX2mvM+g07CjmoA8ysLGr6Kt9VrRxHZg?=
 =?us-ascii?Q?eEKg4EIVXpdRrb1FkVOKh9ijnb+GbqJqK1430NPH9gRno9zsoCj84lHc3aTO?=
 =?us-ascii?Q?jvIDZXpYLsF140BD8ba5zCJ5uN9PlkxWTEi1m5QKrPEmCb6lWBElz6FM6ed/?=
 =?us-ascii?Q?2HWKYK1HHe4ddDebj2vjr+CQ8Wm+UeOjDV4fVYBr1b3iCip+iM2MTvBRLJ7f?=
 =?us-ascii?Q?bIIdzjuGxEDyRXlOpXJwM878O5qu5YzpJqxGWte0BWPl/0HrEOM46Ps7/90g?=
 =?us-ascii?Q?jHdlfPtbtLMzDae/q4GEQ29n5kO2fXNiqebUZ9aguorJs7FJxCr+d6ZrhSgo?=
 =?us-ascii?Q?JinMoy1lrOH0MWmHT65Z9JewiH0GIIwGdu2K0BMez1CYT/P0IWFXpjEV+8Nj?=
 =?us-ascii?Q?lWoe41r3iv/JjOzAcjn9UPiWITPaDj23KAGd0gageGfd2YcKw/V7BkJ9GZUS?=
 =?us-ascii?Q?KlBh6XBlxVPvX3v7GcJWV33D+GdSyUbO1kbcH5vZ7oBOfdJ76CDdiJx8b9jC?=
 =?us-ascii?Q?3Ea4Ib8hQp8SQx5QJI05RZilOxysRtSR8M4wQqVMpdzhGkMb2KvSoZypyFNJ?=
 =?us-ascii?Q?cLDrJylMeKZSgwC9hNG1D5TBdImzD44jVG7EfJK+FSxDGm5rkTQ0bppxoJ7y?=
 =?us-ascii?Q?ovzPSHzA/JsPtsC8sdHc04ty81Dq5oAU9+0BwcZZIjVK/iRbTGNTSVlUrrXx?=
 =?us-ascii?Q?zLZxyUaN3MQLBC0gqAhFd+GSmy27BbWBV49eZE4vuFyEYVSN8sfP5YkC6f20?=
 =?us-ascii?Q?rqy594OkJIjXKa0BNVaEkQIwWFDRUsrJ22XUrT+ps9JNSg2RlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:03.1341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ce9c59-22c8-43f8-26b5-08dcf54fe287
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

A vIOMMU-based hwpt_nested requires a cache invalidation op too, either
using the one in iommu_domain_ops or the one in viommu_ops. Enforce that
upon the allocated hwpt_nested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 1df5d40c93df..fd260a67b82c 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -302,7 +302,9 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
 
-	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
+			 (!viommu->ops->cache_invalidate &&
+			  !hwpt->domain->ops->cache_invalidate_user))) {
 		rc = -EINVAL;
 		goto out_abort;
 	}
-- 
2.43.0


