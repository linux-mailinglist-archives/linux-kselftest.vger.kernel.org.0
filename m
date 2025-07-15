Return-Path: <linux-kselftest+bounces-37374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CDB06626
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 20:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E091899085
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13EC2BE647;
	Tue, 15 Jul 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBjS+6wq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC0242D9B;
	Tue, 15 Jul 2025 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604960; cv=fail; b=YhXaWQpzuL1kzU+bciXACTmcMCHHE1Z2u9dz4lgvaWRawhlYGMW0vj6YpfpWmJekzzBpYFQMmXOL37XgSWFqwC9LNPpclhBSjXaaKKn2eBowK8EtPKBSN/DHbRBT2msIjkiK/AVwh1jdMbdBBiuHwsdkrCYzM2Qo4f3Z3KFdcQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604960; c=relaxed/simple;
	bh=ryqFIOcqR6b/1iuGgOI0USOrEdW94x9SXoFupKYcpiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhIqFTnmR1WcmXKRM+9UFOPIDlAXQ73zmCTdyoWTJkKlIqbdxjrb1CxNnWB8xTqMU4fnWViT2MbjNVXCzOSdzPRWZXILntl0iPctklGmfqGWGYVhmYWdK67S1AlgYp6N9ud+5Tr8vqwLJXPDrAuR/ts2sMJdta5uEqrOZmKZLKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rBjS+6wq; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk7IuIg6GPEQXmlJ6EvSSmdLfbC4+Jb88gkAHmKfrp4zwVPkrdODY3J197ct00taRSpWE22G/p4MenBwJpu0nUU2Vw660mz3ThfpYVt9zQlHj6TqLjbAjgR7Oi98WcFXJkwADoapYhwV66/L65CKtllt6XVtyTjKoiSP8hVNhJuN1lgdr8Jt92iH4KrsXr2is7AmEXJUjZO8rsMLQNV4jA7PzL/0FKDbJiFgS298PHfrFBkDhvCtmpM+tlSNTq6wCeX3Gt6yj4nfINpGWSblzbV9jgvbC7nW//0Y2hq7UanKPRt2PAlFkEQmuA/w0xfKekzcsZMJq6S/d8lqndj5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooVBky2w0pyGpmE87gB/Yf/cvpRyLy/tEUaN5aPuJBo=;
 b=P1kNiLkGI1VpwSetJe7z2rcAWLjqOz8b1SQyPpbaMmQxvdpMj8qEhJ/luSSJHSBm1kbXXOzMF3lQkp9eg321oaSi6ciSaX3yy9DZnFYuS4tuEPxoGCr21rCsQ3vLjfsWUADMB4iflaL9SJvH3xG64Avjuz1WXtS1PMHSp2PBG4FYwmDEV99C+ulX+CMasYy6E8fJVD7mPBEcy2QIO0fI+hZecdHzFtxX2o7QG7fjvLvYLkVd0wjVwmzHwDfQ7qIJk8ISaPkOrXJakYzx1iMHLQxwcqIiagOvrxeZklu3esv+sMXoh0qQ0RSvAqRQTzEjyctr8TnuybZPspV2At4YTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooVBky2w0pyGpmE87gB/Yf/cvpRyLy/tEUaN5aPuJBo=;
 b=rBjS+6wqg2Bux/9OBkQriJIp469C88R1JUyvRppYEw7DuyHuukddD9cs/nem7avNZK0TjwY3Z4H1zk4/SoHyvNtCH5v7f71NRq5qzynLYHaAv+vRAF9/QqMDXVhb6wtnidau+uRsb+reNtIjqn97UwLWeA+H0Z16G2xVRt+BG247UVIfwJ79SRS/HybZcEmDXZ/cu5x9aiknN2RQyk2wp/gIrWbGHQy+S0M4tALDmV86D5Eqzq4aRcp/2pX1DdbRjeDkZ8aJBkBq6YSKVKqtqRGaDYYMAssmoY7sALEaV3zBRXDN5uPFARxBynSWgKijDlDPgJFwRnIwqtFtq77UtQ==
Received: from BN0PR04CA0200.namprd04.prod.outlook.com (2603:10b6:408:e9::25)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 18:42:35 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::75) by BN0PR04CA0200.outlook.office365.com
 (2603:10b6:408:e9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 18:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:42:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 11:42:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 11:42:26 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 11:42:25 -0700
Date: Tue, 15 Jul 2025 11:42:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 23/29] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type
 and vsmmu_init impl ops
Message-ID: <aHahEP0+LKmeA/Tf@Asurada-Nvidia>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <375ac2b056764534bb7c10ecc4f34a0bae82b108.1752126748.git.nicolinc@nvidia.com>
 <aHE4Y-fbucm-j-yi@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aHE4Y-fbucm-j-yi@willie-the-truck>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: c89f945d-def0-4d37-bef7-08ddc3cf5dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8R9Tqw6ekqTYPSYAkBQtPedhg4Ynjdb+KtJABAjzduJvzuq3MAWyXjckWyu?=
 =?us-ascii?Q?tB36liIhM8KqXfCwEP6R0BOLu7ZEXP3WsZhl+X88H3ycK1zTytbkqTVAj0yJ?=
 =?us-ascii?Q?hwiEVKzOv/Aqwy+BurtQpliE8/0X+hONhKL4rTz2HgWRb0Pm2g+5oqCybXLM?=
 =?us-ascii?Q?zDjfDHLnKe6eECRrH8HxrcVbL3oe4sZAxrRf9Arela/S3mk06RMfPcAJclFT?=
 =?us-ascii?Q?z6USTd+A3jYntTMqLR9hdcGCdpTAM+NVlDdSeJaJjgtTQgR68Isx1VHCgT44?=
 =?us-ascii?Q?7i2jyQSUivIgo4HkXtMs+GHR8qdQId1uanOVx92fHTbIUjlzOOZzMO2SZ++v?=
 =?us-ascii?Q?iAJzPynd4rPePVOmeWnW25lrkNLqloX4npX27xvmGmBxxRXpCFhCaDC4N+di?=
 =?us-ascii?Q?u0vlFwnCnD8j/4TjAH6jiVV040TRm/Dfvkt0H7LVlgY8mhl1Qaok+fSNxaB8?=
 =?us-ascii?Q?vLMQwp3ZJjwsI6NPbFinjiKb0WP0iUu7E0exfNhCfBAeu2k5WMmEXsvVKI61?=
 =?us-ascii?Q?nA+c8TAkzOJIIZcmCz1uf350LLEO8ibu0p1OtlAKmqmOpucgAw8l25tJgWyt?=
 =?us-ascii?Q?bYpnYkWDo1/PnHWO2TvVerMUkp/L6YPylni9P82gjdJLtcWfCoo2CwMaTnGB?=
 =?us-ascii?Q?xHU/z8a66efp28OmYb2zj5evuU4EceaMJkiyZcJ3OoSiiBLSpzCJjWi8CW7/?=
 =?us-ascii?Q?mpibta0klNLEzHBfgwUFl7RoruMUNPAOJP3abWZchjJobW2Ua6wG1U2vomYs?=
 =?us-ascii?Q?FrwyiPxMiGxJW39A0sn9liZWITCPzMFuyc8Do168UoYCsxuGKkopZG/33HWX?=
 =?us-ascii?Q?ZBRi07swFDmtsJdLep6smNJFoCMukstzH6f1Ypjfwltr3FOYQ3XR6U6pfdpC?=
 =?us-ascii?Q?VU/h+QTU2ej/zeDW/RvmPagdzTpmojLJd+PtEPVGikhgpasE7pr+UJqU7Kr+?=
 =?us-ascii?Q?uGKuG8XZD4Pm2q8ybQwK1EPlCv5hIsKiPx2Nu9VBRN+BHa+E6TGtrtwzJ52g?=
 =?us-ascii?Q?dNWSq0dF2n4q9RpKwiu69EcKkB+zwY21mUYHQLqlV79gTgkffsAiLn75NprI?=
 =?us-ascii?Q?bBOvdhbXTuBSmq52wlahhZ2Emuf+OM0vXyxuv1MewXHwMmvPhsSMMSrLDgGI?=
 =?us-ascii?Q?atmNFUdp/vxu77su45pEaDV56DEJtlLY3PBaHtZ4X4qGVWfLiGkTHGdZPyO1?=
 =?us-ascii?Q?wZB6nsgiKLNulGL7MDibVZWWLshuQxJ6m4dZolH7fTpBZmz1vQSJiiC0W4pL?=
 =?us-ascii?Q?F4QuC89qs6tYbVMoLck6OO8aZecIMZdTsIClVv3JfFl1wyT/TTROkEBjEmhd?=
 =?us-ascii?Q?s53JT4wMnNoLKKzxAKILSiLFSoPy2iKc+baTuJPn/iZD6Ha3F6eGqDjavy4f?=
 =?us-ascii?Q?/wm/t35Qy+cla0R1Z2TKC27yYcJ/45zmkLR/sf0IkPNpuuDnIzCCs6TD+SyH?=
 =?us-ascii?Q?/LWyPn8B6ExypZ5NsIyGeQhiRUWkAwQhEP9mvDPEs/jky1fHZPTXws3/RsuL?=
 =?us-ascii?Q?Jh27t/MgNkFmXM6rE/JeFZBvVP8iyQOVh1Nj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:42:35.4910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89f945d-def0-4d37-bef7-08ddc3cf5dda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

Hi Will,

Sorry for the late response.

On Fri, Jul 11, 2025 at 05:14:27PM +0100, Will Deacon wrote:
> >  /* MMIO registers */
> >  #define ARM_SMMU_IDR0			0x0
> > @@ -720,6 +721,10 @@ struct arm_smmu_impl_ops {
> >  	int (*init_structures)(struct arm_smmu_device *smmu);
> >  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
> >  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> > +	const size_t vsmmu_size;
> > +	const enum iommu_viommu_type vsmmu_type;
> > +	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> > +			  const struct iommu_user_data *user_data);
> 
> It would be nice to avoid adding data members to the ops structure, if

You mean the "vsmmu_size" and "vsmmu_type" right?

So you want them to be removed, by having two impl_ops:
	size_t get_vsmmu_size(enum iommu_viommu_type vsmmu_type);
	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
			  const struct iommu_user_data *user_data);

right?

> at all possible. The easiest thing would probably be to add a function
> for getting the vsmmu size and then pushing the two checks against
> 'vsmmu_type' down into the impl_ops callbacks so that:
> 
>   1. If the type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we don't bother with
>      the impl_ops at all in arm_vsmmu_init() and arm_smmu_get_viommu_size()

Hmm, I was hoping for an implementation could support the default
IOMMU_VIOMMU_TYPE_ARM_SMMUV3 while having its own viommu_ops or so.
But I think your suggestion is fine since there is no such a use
case at this moment :)

>   2. Otherwise, we pass the type into the impl_ops and they can check it
> 
> Of course, that can be a patch on top of the series as there's no point
> respinning the whole just for this.

Thanks for that! I can draft a patch to send later this week once
the requirements are confirmed.

Nicolin

