Return-Path: <linux-kselftest+bounces-19388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F099721C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051071C23BCD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879E1EABA9;
	Wed,  9 Oct 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="icI4F0st"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624B1A2643;
	Wed,  9 Oct 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491979; cv=fail; b=a4Da5w1jF1cbqUpFzcQPEmLkwEbUkwliKXSrENZgBgy/W9IjCyZKNR6ZOxpfZYEBS10e6sNk2PZM2HTSIdhkprFutomDBJTecPZOcxw9ZGVFqAgljtm1Mes03NbQNn9yOag5LJvBcM2p/KZ+zo5m8YrzoLBTqDz4Wz5ZA7sMhFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491979; c=relaxed/simple;
	bh=VdkMMOo/pX70Udfs1fB+ySm4TkD/v4qdNHcf8rQ6dBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQe1bFEif4uaG3Y4537KFn7hduy9gbj8rLPIkDMPcHEXYPR1iCVOULZPIj1UK4J8RW1STwAeYsvfYQAaTOu/XztkQUHfNZ9uxGzHTvpAJXVP8rYVe0Ve7FeqvVQppEnaoYF+2gRjIJ4w6jtVj43WyFO0P1T1kZzVOYghGHTWLwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=icI4F0st; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWmg2brFGXCt6vN0Ikn+Y4xNhOUhxAgRmsgMCcQZm2sFDaXr9j9elCXxcSEO33iM1iFgjlW0O04ZQk9UwDmGXCMGW721W+rLf0LxWBolMhDZszao6Tj3A8XZbsxvJ7l4s1VZMZ9xwr8d8yOCibF3DQ0tG27oJhI7zPevQPMkKEWyQRA8yyU5xTH7hv6aThPV/RmhmMS/t8C6vhiiDy0YV0R6Q2lBEYsSt0yfPL13EAjG1ijfxy0tnFN9n/8dbAFntum0uc0L26MG16WirBr76FcftxJfE5CP+OPqAkgMZhp9HsdeONBvHNjXIfwdbHiMnjzNAv8HcS92DL6HLBDlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+qA0TvXiEAf71akvo2Q6CNGY6zTvvtj1HugivbJ7RM=;
 b=iBwM3Aw6JCSlZBdPUNX3GhSGuVmcCen5M4affLvK5ysAbzJyyXWy2J2ok5QQc1KkqNqN6bnmCrCF/TD3V9S32FfBqRrAQ1eYs/RLH/ZwYBbzNNSI3Du1rVkPo4ykN2+Aigi0WWrxVmAnh+toUAJBx/9H5skrEQ4TQDf9vd/S5YbiQeynq4b1YAeAApuV7LSvwyVTtZIiwoamIZnHBpZKVNrlWzuTYSa34+lOE4Ka5S02hjClwrfaZ/s/9gR+soDK3rBA0QvhFxezWhNLXLKABB0wFbmhOcy3dhUOowULJ8YwvzezYne15JCTjRFcJSH1MCjw3OSBHCFsmNGLrIHvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+qA0TvXiEAf71akvo2Q6CNGY6zTvvtj1HugivbJ7RM=;
 b=icI4F0stppVz2SeREutZiKSgxEIaUSekgrQvhI6vPLCIlRsndYoupmYfsfcLRNo/ElghTcdlcfgsX4av5QMP5FL11aCi6jYGTD6Vm+aDh5ZDzJqVOTaf1Px/AcP0zcV2sMAZO/Ml4nLQI+EDxU2P57Gdn9Y9txkpKcfVtmo1rtfy9wbZDhtEJ6kMYwL4c+YI8xBpgfO3kCYfYMX66urooIZWuhmI3ciRBj8GqfZEk+XqZL0fSM/NMLGtXP2CBcPmLgG69BmcxE8ZXQAxSEJWQLUS5eohSCqHDsOmu1278/aKLdiDtrZ9rYps3v6rX7xgF/v1rf4hfgoFthxTv+oONA==
Received: from SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::22)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 16:39:28 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5) by SA1P222CA0110.outlook.office365.com
 (2603:10b6:806:3c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:16 -0700
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
Subject: [PATCH v3 16/16] iommu/arm-smmu-v3: Update comments about ATS and bypass
Date: Wed, 9 Oct 2024 09:38:28 -0700
Message-ID: <a1a1b0116653fba579d1014aeb5a5fb56fb37313.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d9fedd-59e9-4d15-ea16-08dce880f1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lcOCo9ImSp4HoRXegM+zQ769ZLy8cJEoQ6uZONhprDKXJlTop9mz1h9VNQfM?=
 =?us-ascii?Q?oy2VWShcS//GUs7S4RoHPaYl+rXmJb2yEFUf7W6zgfJ2dA4WngDMYwOEuN5g?=
 =?us-ascii?Q?vUVz8Ugmi/vxnkx6g70l+JIThEx831dK/f41v962HccPHlmSpyVE3Bpcd3cX?=
 =?us-ascii?Q?/3cShS8LRC54RC1syEnfuZlK06RdHVtTWkEk7sTUe3/2+ip+JndEN493V65J?=
 =?us-ascii?Q?C0WKZSCyd2x1oXL3AeIQtPK4iwPXjCfI6qUQvR6HUvPKD7gc3lPcsyBxAW7t?=
 =?us-ascii?Q?DznzQa4oP1zEU1YDTTvo2VcRyMi2Xfco7QjdC4BSlooDbHVybQGwGc2Hvztv?=
 =?us-ascii?Q?hxHmeuCoPb9ldcuSo5Zkjg0r2H/QK9JflFFNSzDYTiGHx/uw4liofEX6meO2?=
 =?us-ascii?Q?vGLNmKT7sp487BNUtI6N3TbI1kB9J8SrM7tecmgNpZyyZfVTfS7geqQOfSeY?=
 =?us-ascii?Q?mMNQT0SYjqxqGHoJB7/W5ZEo0x+K2ivG2TynD5eXp4pV0gv3tc3wlgSkkXI0?=
 =?us-ascii?Q?Uq/+cVRQ1R5iqb1BpsVOz7a51w2PIgZVmWB6u2q2t9OJ1pFL4uGIPu4sghcR?=
 =?us-ascii?Q?lk3VDLLRGJ1tnCyT/HoNzrBWnoHUE6o5DjfQHu1lAfVyy+oyBquS9rppWVeh?=
 =?us-ascii?Q?2WHmAxOjW82ApaEXEcPjHjWh7c/SsU21erLB5OLwk/HsKsDmxVMPEUYV5SAc?=
 =?us-ascii?Q?UJmXk9BV328IOyBBUnpuXjrTE5qCmLVCkekSvuDEARe6P8GAtOnk9XHU+KHB?=
 =?us-ascii?Q?U1kAzzGB5Dw1DW9HNccH8K9yzejQM2vU7ekWQjPwrgxpZblVDgWUDOz+NJlL?=
 =?us-ascii?Q?OHhQ5bL4kvW5c5rwmKR1fpcp9C2xUQ2UzSXkg+t71gmSRyo9g/b+35ILIinT?=
 =?us-ascii?Q?GtBCMZVUoaNDBC7715nYiCGKC7NKfmhDz1VHwDYB75GU94kD22h2akBy6MNm?=
 =?us-ascii?Q?jnb7VwX7wNl/qfUtmitnQq1Le2Oweg/9da8TkD3IX484jnCL1rxNqbfOLBKG?=
 =?us-ascii?Q?UIIcpmc8CwwuZ/iIEG8XIsKsxEWzt3R4gm5QGIPo0MCrEgKn2GaHpvx0R6dv?=
 =?us-ascii?Q?aCKTMQbIHp+GtZJqLbb0jqZqnEEh6Wz5TXoVrXrwY/Iq+5fjsnMORCyJg/RK?=
 =?us-ascii?Q?zgOd8aft0f2WNl66yqABU6tuSfcEsRL6MpIxWh8boOyvomUusS6AEkyGk2tl?=
 =?us-ascii?Q?AzYrs6l9xZC4l7e2RGyaMTPtGWFs1QEfdUbW5kU+uRtqIb90eb4zMLsyFigF?=
 =?us-ascii?Q?DcaLiHf2pcuSTWmsSgtIHXPYb1Le5DJmwtwk3cCkH/tskWHeHtQ8TI3/yMHV?=
 =?us-ascii?Q?6OWE37EgAge00SaJJqViAUbR5LeaSS0vIZv6vO97qAPZmY/vQfJNCqZF+K/s?=
 =?us-ascii?Q?t45seTYAMyk7z8FmexQ1Vb+gaeo2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:28.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d9fedd-59e9-4d15-ea16-08dce880f1b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

From: Jason Gunthorpe <jgg@nvidia.com>

The SMMUv3 spec has a note that BYPASS and ATS don't work together under
the STE EATS field definition. However there is another section "13.6.4
Full ATS skipping stage 1" that explains under certain conditions BYPASS
and ATS do work together if the STE is using S1DSS to select BYPASS and
the CD table has the possibility for a substream.

When these comments were written the understanding was that all forms of
BYPASS just didn't work and this was to be a future problem to solve.

It turns out that ATS and IDENTITY will always work just fine:

 - If STE.Config = BYPASS then the PCI ATS is disabled

 - If a PASID domain is attached then S1DSS = BYPASS and ATS will be
   enabled. This meets the requirements of 13.6.4 to automatically
   generate 1:1 ATS replies on the RID.

Update the comments to reflect this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1cb4afe7a90a..236f930f9a97 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2745,9 +2745,14 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		 * Translation Requests and Translated transactions are denied
 		 * as though ATS is disabled for the stream (STE.EATS == 0b00),
 		 * causing F_BAD_ATS_TREQ and F_TRANSL_FORBIDDEN events
-		 * (IHI0070Ea 5.2 Stream Table Entry). Thus ATS can only be
-		 * enabled if we have arm_smmu_domain, those always have page
-		 * tables.
+		 * (IHI0070Ea 5.2 Stream Table Entry).
+		 *
+		 * However, if we have installed a CD table and are using S1DSS
+		 * then ATS will work in S1DSS bypass. See "13.6.4 Full ATS
+		 * skipping stage 1".
+		 *
+		 * Disable ATS if we are going to create a normal 0b100 bypass
+		 * STE.
 		 */
 		state->ats_enabled = !state->disable_ats &&
 				     arm_smmu_ats_supported(master);
@@ -3072,8 +3077,10 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	if (arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
-		 * on even though the RID will fail ATS queries with UR. This is
-		 * because we have no idea what the PASID's need.
+		 * on because we have to assume a PASID is using ATS. For
+		 * IDENTITY this will setup things so that S1DSS=bypass which
+		 * follows the explanation in "13.6.4 Full ATS skipping stage 1"
+		 * and allows for ATS on the RID to work.
 		 */
 		state.cd_needs_ats = true;
 		arm_smmu_attach_prepare(&state, domain);
-- 
2.43.0


