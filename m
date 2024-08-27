Return-Path: <linux-kselftest+bounces-16442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84759614FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0878B1C22EEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323F1D47D8;
	Tue, 27 Aug 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bQVswOf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4451D0DC4;
	Tue, 27 Aug 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778137; cv=fail; b=tcLcJbpDiIskHC+0TIS8hUXKG6jF4MBe1nmskr0wXXG60XTkGv3ieog02ZXBrJclgaG1eICO89K0kLo8uvJ1oroBrSVbhMFGxulQiimuR/Sl5YhFF3mCfa085Wt1iU4DK17OL6eycDcWFcQ9NWDsuIzlae06j4sQwBvFLEQ3T30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778137; c=relaxed/simple;
	bh=CED3G04sfM5o6y8e9joEGQhf/0Q3YNCZN8Van4ALw14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLhAflEixi+ZBPgSCPrloRzsmUbMlsjnOTCrDnMyl3LoJj5Gnic0V8Qo49KJHp8WFn01jVEcdpmVv1ISNdobiyXc6pCyf7wM7Zhnil4HQrxu8hRlqNVAEuGSphB7we9u7gthF97Q/LOiA2k02dEC8/ZedA+oGgNsOr2bjrhOl8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bQVswOf+; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itkn3m+gXFid7g0LyLhrkU8rj32LYCfeSi2z13RnjCPUzKzBREWgNYzYQy2MkIzx0n4GIhTRS+Ujv92eWoDc5i97WSE3phNWL5y2oSuSHU66sywRRp2hNuMGT9rXj9H4MQLIDmriHxMoTeDJyfZwMDdMjxNFiFHH7H2mRGMFgrOeiRrMdc5v8pAxuCdanjR0MKSdBpehQ2PjO20OaCSlIQLzGHDyt1woU8vP4Tg+yp7TV7uLDp1G4P6+Uernw1/GhRI7pPJwybn9gLnUbMJDLHMLzV9XUClhu6zi2A9mhFgy0SQJeS2Q2fbolFeKPrIvexQzLybRYCoB/rdGxNSKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LkXVhx7CLy4jkOsRxBVgGp6G0jS0Miqms8A/q0GUFY=;
 b=wF0Oeck0JLfvvVbNyEhXxxZmahGFWI1FCgUoEAlkgt0eokz7VDSiTsE/m3e3oijZrYZHcGMp5YZ/cUEzLOhZuagU98vI4ob+XfxA4RLCeU2n1SHwrAOvFQTscFPZ5mlvyqPPhIUpP7JU3qFQ2l1nY6vCZn/+8dQ4CYHse4ZTqOeyUuHVdC67MLCjbccG2485ZKW7WUdnhjPtoETD2bdyRSAZWGi29c7s8FdAkEl7BBWi1H3KvWV6PY+S4ToM3MSU4UG2OIGmTHXVOsPzGxLzXHl8+h6PIpHwH9hD5XDVdRL3xH2ub2OWxewyUqy9FsD0ftL6NlIQUN0fH7VEeA/2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LkXVhx7CLy4jkOsRxBVgGp6G0jS0Miqms8A/q0GUFY=;
 b=bQVswOf+fWc7Wog0SCeYzSS23tuoL1g3fH0S+zQjm5fitE6klx5ebw1Ds9HLCGf83Nfzt4XZ+3zSlR+hsVKzMRcxjqDviVyXgLHZM6IVfddY2ezE8NBZzxUKTKMZ1FKR0fcXiGhTNpkxNLBCPQoenG2qukUCV8ND02aEYfYWW0GvNIjlRpRXlKP6ec2VCBcIi211GaIA6a3+/SGn51Qt89xm5yEnDsA3Bv2+L0tL1ioFhvpVYL89pAaJ/6fzJ2E0OyPQPFuuoXeM9HT+uT/UAopnUDygyJbhtvZPx/i1jn/3wvZbfU4/NtNBe1ZD8pi7Uc6GeUZLSyMBWelJ5NqoQA==
Received: from CYZPR02CA0011.namprd02.prod.outlook.com (2603:10b6:930:a1::9)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:02:06 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::41) by CYZPR02CA0011.outlook.office365.com
 (2603:10b6:930:a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:02:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 18/19] iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
Date: Tue, 27 Aug 2024 09:59:55 -0700
Message-ID: <3962bef2ca6ab9bd06a52910f114345ecfe48ba6.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4568eba1-e99d-4799-17b0-08dcc6b9fb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/QVep0xOH2U9v6nvWntIZH/Dt1uDOPFBHeysdcipOyLTrWc1jIIpQJ6WZXi9?=
 =?us-ascii?Q?n+NBE4bbYxMUIiQsZwZjcZvy8t7HQwcjEhoP9gqK2Od2QzkK0RmZ1evu2Tps?=
 =?us-ascii?Q?Bqxgw/Z45JHCf3M4OZfEUfGNF81WccNh36tedB6HGs6MXiLlSof+kHLO7HNG?=
 =?us-ascii?Q?LV0Qdlztp85hcafwfXZBNwl7K4EPNCpPZd5vgkLw6uc4r+FfRgjqAurhxFy1?=
 =?us-ascii?Q?dmrpcDLLlL1qHoNVOiJmTHpZT3bfWPOL4JAolUTrScN/ocyqueBDkYuvWnpx?=
 =?us-ascii?Q?CbaP+xDB2klXYby6/1HAlYYbGI9VxwkZAc3JWdyR0IEkoSTBk5Gyay2POwDf?=
 =?us-ascii?Q?TbZaNFxnnqZ/bnkZnsIgzR0fMaIPApaweuN/57IDjU69iMzyQ+NImPOQn0so?=
 =?us-ascii?Q?mtCTWGy+bmXSHaGTqISiWywuxAo97cuOwcg01fPIZMhXfq2Kb8tWPaThIqcd?=
 =?us-ascii?Q?3B7B8jEJdMHd0eCyo7oFDY8h5YMkVoYRB2d6sC3wqpJeBlJgF0L9UwRehMqW?=
 =?us-ascii?Q?tUVBcObiDhHaHwZNGS1lyy7rhTRb+G6kpsCutwFDmAYP6ioitZTrZ/xPDQNE?=
 =?us-ascii?Q?8FBVTBgHCh0WRmL/GrN97zky7f6ZOfbGKc5br32JSme37KCkwZ5LXF27/xJC?=
 =?us-ascii?Q?4orHY8f1yVijrz6X9MLc/EuM+OlXTiikOHC5suBieWG3xPorzVTRX6lTj7qx?=
 =?us-ascii?Q?Gvlt6WU9E+L982bkS3JxdlrEJ9Ss1aAup0nO4Kmm8D/DGXLxUoWnCQqGiU4w?=
 =?us-ascii?Q?F/2LkCgPU2MmZadbYqwfkw21fNpB6xwQepgZCFJcrqoHopF9oL1eY7z36kkl?=
 =?us-ascii?Q?hwtEXrxO0a838DG7kB6m/4MTqw9rYI7G2rD/ZlVPq91eqe+0zvpvJNCmNIGd?=
 =?us-ascii?Q?4EsBNve1x4w+YB32MKt/ZendHdmVosZ31mC+OMjSZRnsdAItl8Y4oemy83Hd?=
 =?us-ascii?Q?WIRFV6Yl7eF+FRARLhnelxWNuBGijZ1Kbrw7rptc7if8kWb23FgBRgvMr3jK?=
 =?us-ascii?Q?ujlgK2u4oqI1OtLy1TX1H3IJ4Jjg66uMOoIZ0k+2YhFe8xy1V1bU42Mq4Ib+?=
 =?us-ascii?Q?hBRimA0F4+W1grkxc7I2I9prySpbM5FujbtARLZloBRkVWRfQky+6ypbAUIJ?=
 =?us-ascii?Q?tP3fJx2HMjstQNEQFJaLDIU0Uxj/68lazJH3QJu9xZykjgbfZcgAua4Kt51W?=
 =?us-ascii?Q?WcLTUqs7xD61yelsUqDrz0LqPNXwiOAv165wByMObQat2Yd8HVmLLzc+97tw?=
 =?us-ascii?Q?KCk0JgmWxgDomD60/WIprSxv/eS+2qpMOwpJIEnGtAzkPiIvpPbirzQJaucF?=
 =?us-ascii?Q?ohk+XC37spJgmPY+uWQRs/5YK5+4ZFAMDJV5dbNQgiTsAO5LSGbRAFzPf+ab?=
 =?us-ascii?Q?K3zoN2RYF9boP/74q3tqWxPZJoRfEpTmSp7zM7ZEpqSohCBFKO7BVyudWcvL?=
 =?us-ascii?Q?iJhy+D4lBHJCODtJMZNEPYZECKjKb1HZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:06.3264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4568eba1-e99d-4799-17b0-08dcc6b9fb20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

From: Jason Gunthorpe <jgg@nvidia.com>

Now, ATC invalidation can be done with the VIOMMU invalidation op. A guest
owned IOMMU_DOMAIN_NESTED can do an ATS too. Allow it to pass in the EATS
field via the vSTE words.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bddbb98da414..6627ab87a697 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3237,8 +3237,6 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		.master = master,
 		.old_domain = iommu_get_domain_for_dev(dev),
 		.ssid = IOMMU_NO_PASID,
-		/* Currently invalidation of ATC is not supported */
-		.disable_ats = true,
 	};
 	struct arm_smmu_ste ste;
 	int ret;
@@ -3248,6 +3246,15 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		return -EINVAL;
 
 	mutex_lock(&arm_smmu_asid_lock);
+	/*
+	 * The VM has to control the actual ATS state at the PCI device because
+	 * we forward the invalidations directly from the VM. If the VM doesn't
+	 * think ATS is on it will not generate ATC flushes and the ATC will
+	 * become incoherent. Since we can't access the actual virtual PCI ATS
+	 * config bit here base this off the EATS value in the STE. If the EATS
+	 * is set then the VM must generate ATC flushes.
+	 */
+	state.disable_ats = !nested_domain->enable_ats;
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -3497,8 +3504,9 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
 		return ERR_PTR(-EIO);
 
+	/* Only Full ATS or ATS UR is supported */
 	eats = FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(arg.ste[1]));
-	if (eats != STRTAB_STE_1_EATS_ABT)
+	if (eats != STRTAB_STE_1_EATS_ABT && eats != STRTAB_STE_1_EATS_TRANS)
 		return ERR_PTR(-EIO);
 
 	if (cfg != STRTAB_STE_0_CFG_S1_TRANS)
@@ -3511,6 +3519,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
 	nested_domain->s2_parent = smmu_parent;
+	nested_domain->enable_ats = eats == STRTAB_STE_1_EATS_TRANS;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e7f6e9194a9e..6930810b85cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -832,6 +832,7 @@ struct arm_smmu_domain {
 struct arm_smmu_nested_domain {
 	struct iommu_domain domain;
 	struct arm_smmu_domain *s2_parent;
+	u8 enable_ats : 1;
 
 	__le64 ste[2];
 };
-- 
2.43.0


