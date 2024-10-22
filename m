Return-Path: <linux-kselftest+bounces-20352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2B9A94C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAE71C231C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855C15CD4A;
	Tue, 22 Oct 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzP6ryzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445A1547C4;
	Tue, 22 Oct 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556457; cv=fail; b=XoinsGvVYJ2Gm1mhlIYWhF3C/GBAPJvXhzwdRAYSb5LpGPY9/K9jhlCoPue/UBIl02FIxvVnSPv2L9tFIDU0XykWO1mBz4ZhUO0xFxOLzEMpTdN/x90jR6jYpzhmHzt9Jy4f+fAJ9fnf2U/xeEwwSZ6t0rFyQz2NVI2QHWzO42Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556457; c=relaxed/simple;
	bh=hfUC2C1uTBqViNb8yA0mCkV7o0UiixGTn0YcTR+3DAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFQvbil5qa15NtFFc+n2mbCHh3MEApmW/BbdKd0Vcfzt19omieZrDyl0P8pgL+Jg6su64aq2krtJVNr03oitCRIyJ09bDcLthDHlbJV97oChjrNAi8Ip4As1xBP9tkFeR0YHeoB83FbohKa9V0VYVUuSS6aSNztMpiKX/Xu6JaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzP6ryzf; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/khjHRKoEy3vLYM0V99D6hpDxBoe6b8PLXunzNe+We2sL2RkJAeZKnR4AE+IbTt2muKjwQ5NUAzj/cegMMp3Mo92RDbbfRAcQ1/BUzBvWKDuih3xjQ4XwdJf8wpGFcbtUFzREEpnFG0rzBIh8EMMWrk+StltL5G/gPcRnZYlWe7uiMvrvmTjUTmzE9mOKU6GpBaZuZiw5jlN/HPfeJh5DP23HYVg94qp9gnB7+4bcG/Hhc6OZgGUYKZi+A+Op1OpnC6pCBP52pip/oAL5/MRAiOqDSoXsGnVsCWUyTG/XVbe8DEmrOrqt1K4s+YYg0E8yJF2SBZmKc1jXooI4NhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSbWpjlywMOQL7nsKHhi2eFpjFX7SWJuA+kw/e8LUbY=;
 b=hHH5pW1CvvDTgg4UNq+2+mxhHftA8qWhaXZtKd+IMlE8/oJNh6MBY7lCRQj0SaMl+UtU3F94ZhDvWndtIEsmewvg9nP4oXZ+h0nMDdEBjEiCh+ndXYVCEZItadPoocsU8qvhgi8QcaorYjOmhgwz4OyKHNzwnsLjBEMyPxJwrHyejpV+KNR/5hsz9qzFQmtQV8DI5keHPMhGMXd+MUpRI95/d2GJOQbr+mRZCMVVy3IRGSRvo8tx569ZcLiv3iBYfuYVqHN/Qk7bjwRVRAnLnEx4rINN6fN98/6RVCGCxP0uwE9yEfJtUvWrRiwkvu4dWc5XsXzExeefAYu96adzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSbWpjlywMOQL7nsKHhi2eFpjFX7SWJuA+kw/e8LUbY=;
 b=YzP6ryzfSRt11VCZOdigzEETMTzvFwGT0DSFQ6/MYMF7eyNP4sJYiFPY4zsajSD5XfJfFt49k4l7Q/3lJpdsCcnZOgjLye57lrJupFe4Eql/JeJKjzBn+UYfCOmrqGvkSc0EkQSkPbXF5lATFpFeiK0aq7BnBDXUVGSdG+W/ZfHiz0ciHQCm/+5QY3ubBms4v4nWCQixARhqQt0UITgTEY171muL0WPJFZIXoM+4Wfp5zHks/mws8VWgp8FGk9tAcoRkikGv9X46ADs90w7hgVOavW2uuVGH+DA4rDlyH11IC0rPi97n5NsytIADHOMZIKLF1Pdb0a74RDBSUzb8mw==
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:51 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::82) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:33 -0700
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
Subject: [PATCH v4 05/14] iommufd/hw_pagetable: Enforce cache invalidation op on vIOMMU-based hwpt_nested
Date: Mon, 21 Oct 2024 17:20:14 -0700
Message-ID: <a59b99a85c1294775b6ea2850cb34111eacab8d9.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1b31bb-5586-43ba-979a-08dcf22f62a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XtleWZAdQbBFx8GbESclpaYFe0LPxtvVQv2J3ULamReC74jeH5vF8H9fPxDb?=
 =?us-ascii?Q?uA88JCGbTlxTawGu93ymMMrPz53dVN3YyUZMmgp7asHxDVAKu3K9j36jvcQX?=
 =?us-ascii?Q?XYcfCkN71rH3Ouf04vfphwEXY5cJOqK+j1IV2EzKVL0Hbgnqna/p3e7iXQor?=
 =?us-ascii?Q?C04u9CmiHoD83Ee6WaDW099fWjQc7U+/yWvA4EU/uANK+iRY6CcUnNBgTPCJ?=
 =?us-ascii?Q?lRG8a9E4MoD2j4ttgFpW2xA/wYrd2R5CfhV2hKTqE7BKIFkwyAv43s1SUYNY?=
 =?us-ascii?Q?lGprdtkuu5y3adWwEsCnSOH6bn9lNvQ5Cg2oflR/oFO/GyL8ovROC33PMQV3?=
 =?us-ascii?Q?zmWU46zKfzgh3RrBKgoSpJ1IyH90mtoCzGR70U/62h4xse1+PRmUYGTlLrxW?=
 =?us-ascii?Q?wYcmFlQwvT+Xj4IXErplpMLPdM7RfH3kIYIBkqFiHeFkot0uvC6LNUPUIhFl?=
 =?us-ascii?Q?Scm44vpVNBwU5v8Ow43bBL3u0g51uq6Z7yF0jKM03tgRRcjLHHiMcEJHRkcL?=
 =?us-ascii?Q?JzsuklOK+dLrCF3XVQonWPlvWPfSjG7CwZkLj5hNhup6qZThg2q+6RE4nKNX?=
 =?us-ascii?Q?7haStd/lGpFaXXogzWcfBxsa+qokFAxvF/z8qQrMv0VJuPQWXZQdMiX9nM8u?=
 =?us-ascii?Q?Zk4KAH1aZcLSVdHrRZsiAfLGRajQ3TKZmjGs7DNSojrNdaV8t6+r8IBorqmi?=
 =?us-ascii?Q?tbxfvw1AeBDyPjCjofLoVd+cnj64+LFpoecPEHOb77kHz2MEUa+IP5PGP7po?=
 =?us-ascii?Q?QR/XoWSUYcc/VKOSqa3SOIFFQJpYlb0nMX3e/HzeeJ90uvwDAiAYtAgQDRzL?=
 =?us-ascii?Q?NdgXOJ/4Qu6M8k1hAz3mb7bzu0hOk7pCccW9GJx8hDNRfqqXfO+eejoeglFc?=
 =?us-ascii?Q?D/oPQfu4kGItXk+TSFqRLKRa25Vi5Vgo1/z2HnY6wWabW+oYb11sQ+wewyzC?=
 =?us-ascii?Q?Qwj/kkbVS3BYUJEvrTDgmWjeB2pSrsppOHjQlE9azsXJnFZfswouuwakVKVg?=
 =?us-ascii?Q?jZfizScCzoNPAUeTzF7hJ1iIpCijmge9Mj+iyAdhORykaJMzPW4dKdPsxlOl?=
 =?us-ascii?Q?O4tq6YT0Vjuq1Hk/DfJys+jWyk3x1PmnRxr9nGQYq6FwFUQPy4j45CZlwjJn?=
 =?us-ascii?Q?Dsd18/1nbjTzklYDp344E98Fex5gqFCrzB85IypfX2kfrwNuD+WXY3dHpkpz?=
 =?us-ascii?Q?HGrmOD0kwTsCAbcBJGrsZUpbSG3XoxMDOHah/GLGPUJBouaz0GAgeyHSYarb?=
 =?us-ascii?Q?00Vmk/x2O+ZIZTl5F29JBLdp573e2CjsMpgH5e6N6xBAJ+EZBJSfyuTr4nlB?=
 =?us-ascii?Q?ck0qM+V/ozuCGIw0bl091ek4WLP0NxAX3ox+mCQRUkunLOtMy1nE9Eg2FmZ+?=
 =?us-ascii?Q?ymU2pGDE6WSoOxmfG1416G57Dhcz1SDgUh9U0g7DZFECfTKasA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:50.9878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1b31bb-5586-43ba-979a-08dcf22f62a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

A vIOMMU-based hwpt_nested requires a cache invalidation op too, either
using the one in iommu_domain_ops or the one in viommu_ops. Enforce that
upon the allocated hwpt_nested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 5314cd486ddb..7af6cbe6dbf2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -300,7 +300,9 @@ iommufd_hwpt_nested_alloc_for_viommu(struct iommufd_viommu *viommu,
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


