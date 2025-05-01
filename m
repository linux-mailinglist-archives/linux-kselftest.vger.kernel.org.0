Return-Path: <linux-kselftest+bounces-32135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4EAA6746
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D1B7A4F83
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6022257443;
	Thu,  1 May 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvGeRQTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6138385;
	Thu,  1 May 2025 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140988; cv=fail; b=ocuPCM+nZ1dK944YdRee67ChMd9JNgJI+n/mdAHwqTtlr8Mb0C2CquM/K0H407XK2CRq6geB86kCF/0sfr/OZdVHCeeVj9ji5tdo7S5f2Ob2yPNxMRbUEi7KsPjqJkC7OVugvo079xJp7e8exJTd8xbZ+dHKBjyvlu0iCGiVw+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140988; c=relaxed/simple;
	bh=wDlBKyAXmBEWliQT06A95VG59amj2glkS5L8sh/2BVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqSXo0B+E52bl8cvRtBRn0RpXDEDKJnXOXpWvPPj/MxMrQPePfWtPk+3i8IpJ4c5njDOxRi9rCuWLUHobRZrsT/lM406a8lAypSTaFH9ejTOo+g+CavedQDN/8qbSt6f2wYULnDI0+q+dkXJnkzu11I/2cdwG+ncpoDmZzBaa14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvGeRQTW; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBWx9RMxvu9RcqUufkkNTYz1HqbqWWvnlYan2Zx0FyE5BJOAAN4mLwwe7jeHmZUIk4AdR2J86866RPpN6NLDzG980P8xi/ChPtkDeu/lR9PjI1j+RPAKxCk+hGKqwvQ8KQH0edudGuasrYYZ0AlQoCJHjK9FbuO4JUJAL9LkqvBHv+1u5u4DVbNTnCGWOg5Qr/qRK4Hd1hMEQTOK7wfvLXPbLL/vHmndN4uTmQ2oVQU8xhCxvvZIPWxyuPs3OQmPy5JUfXhbM4xIrnYvO/WeMo6BGy7qIWrb085aKiioDbx6HWSvpB8suY2/a6hTGaHWlVOPalngJzPaPow3qy9AAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tinXA2xoCQcIKMM3d3bTFYrC8mOUhqhQzr6uGnYc1y0=;
 b=DMxmch5eq5kV1uae0WEFtOwBMiKmDOHZZQSv+US2UtlmzASJkcAJydmKhNGa89m6cLWhP+bS5Uq9CHTZRu/ursutVFkmosXhst4VtKzV3juEiP4fj89Zv9UW+m+b2zpWhUm/RttlvaFLd4Mk7DipYijzSdJcf3UPC7zVXR5+wnOG724RanrXAdOmsGNHvsiSNBXF2dd1sEZeWY1a0Xewi3d8SZGgag5Z+zKdSPI9sZjjEwepD5OgvCOPwHxIe1Ms9gSpkgifx6Vq+2k/qsY11NmRh+//gdz43ErIYHDVBHJ1SP14mwa30OA1tbzUGNDQSAG+MjBx4U8G+Extchogbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tinXA2xoCQcIKMM3d3bTFYrC8mOUhqhQzr6uGnYc1y0=;
 b=rvGeRQTWcCPo30CsfuoMQ/gGxDTN7lPdgN7dEfPL6RXASR/BVKhwApnK+3vgG8u4hpaKzy6mH3xmWChNohcp9DbzbCO9d1xwkFwMHg63KHokRzT/V/RqfB3b73Trqz4f2WZ5KXo+KG5gmGCuoJy5gDD6LbYIysooIdPzupqng3A8/2JhRAN/IdZePkaR+p1dD65Bi9gHT+wpkXij7PzOFRx96yZBRBqBPhfyDO8mR4Z78myIxnaXp+FnjEMQfRfoKJGLMz0ODroTc9F86nJcG/oUNsRMOzZyfr4H6+58Y8e+9vc/R1rQug4MdEf/3fcR5O5XlG821jPScBFqr+N7WQ==
Received: from CH2PR07CA0042.namprd07.prod.outlook.com (2603:10b6:610:5b::16)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 23:09:44 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::8d) by CH2PR07CA0042.outlook.office365.com
 (2603:10b6:610:5b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:09:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:09:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 1 May
 2025 16:09:28 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:09:25 -0700
Date: Thu, 1 May 2025 16:09:24 -0700
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
Subject: Re: [PATCH v3 22/23] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBP/JKyZlskIdS/0@Asurada-Nvidia>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <5a67688a9675e7787660a51774b3213094875028.1746139811.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a67688a9675e7787660a51774b3213094875028.1746139811.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 418e9754-6edd-4a42-774d-08dd8905427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HvAMC/2GdcHF10JRjzPjFnXXKdzcZAyl8P1PiLs+s2183ag8RENcazcpPNE5?=
 =?us-ascii?Q?YLNOsZrCGce0Jf/XqtE8gBXxC31f8ufKA/581XVKMhHK/+Vfu8v6Yt4vecyl?=
 =?us-ascii?Q?6eZWO/WUc/KZUZLPfxN9edxjkXtkHH8IiP4wjculDPGBrcQaJ1tnQcregQof?=
 =?us-ascii?Q?vnaR9grqqGEOe3JSzsS3ikJf2Thr7q9sjE50Y0t1QNarfOgJBX9WR+HPUJ7Z?=
 =?us-ascii?Q?dGfMyBvT+wGCgPUr3bFLBFkt28gbBAQY/kXWytGecdyGeyv3c9QQUB2djJtA?=
 =?us-ascii?Q?T6n27niGK0BUWW++4J+PxzIVy5Fs0BNkyMhmIlO5zemM4wLrE1waa1Q6fU14?=
 =?us-ascii?Q?orNAtbCfY4VCG9jDcxMbf7SiljkG5DfjuRsq0zXt/fKjoNcsR7UfPgmW1FW5?=
 =?us-ascii?Q?S4DWEeCmVZDvyJ5E63V3jTJTPhRUkoDmb5qG1tJpau+y0V7QEqPSveVB9yMR?=
 =?us-ascii?Q?98ZA6jnghzKsauoEXgoXy1yC2TIpLLWTsC6oBFLqbXwNQwNtkozGdcj1gvGu?=
 =?us-ascii?Q?MXWJ8oQ247r/+2xK+MD10cwHTZIpZh6BFJXdIxO6ljL944eXSpMWHQuqBgWq?=
 =?us-ascii?Q?1Afr6j3AGE1OMg0FrFgD5xslzyFKn44fzBPU8avysNqf6J8vyjKQ4DAok51E?=
 =?us-ascii?Q?CxlMl3AmpfefVFmoymlCOVwBadX9pnQQEkQ+kJ6XYKdcQuUfr3CjUBXIKd3K?=
 =?us-ascii?Q?NJxdTT/ECRe1m9+2Ev7HSsfZVNp4bXeEuvDmzG7PC3fcd+SUInCf/fSTxvrM?=
 =?us-ascii?Q?y3j5m/qHj7mTBm85UvJcObCYkoax82lpujWPhll/4/ueuorN2sF1d1xLdsSC?=
 =?us-ascii?Q?GsQi9O3Wjs1mg0RhC/6l1aw7dPOfT5+Vmpe5VEPAtwyT06i5PKMBPjTqEw3a?=
 =?us-ascii?Q?+nfEXmieBArEJkylWgyQwsCxRTsVEe4w4X6Ap7Qm60O0yBUGT0/zYGsZ1HET?=
 =?us-ascii?Q?L66oYiZOjRmalb4Ei5lIocLnkJZTBH2rvAfGCuyPPSA2rQeTbjyCaR3/EoLj?=
 =?us-ascii?Q?9GeYhK0ttKddanvfgIsdGmmVMgAngauQfvwd0Lxb15x3S1RJweHoI+gzB2sN?=
 =?us-ascii?Q?Vkq0OtZCudy8w0pprLTmRU/eRQzAR7xjn3A4ZXN8mpfc2yzCsQrxQXxqv12Q?=
 =?us-ascii?Q?/eANig3A7f00B3Aac6mIaAx33EF5y6mDPMmAPJ5Njth5c260nX3/uiS/Agk4?=
 =?us-ascii?Q?TsPBKpBHVxwCiiqhRPx2esZTV3IsiLOWSxuDyABrMasxVxshFQs8S2ZEePv2?=
 =?us-ascii?Q?cIyI7RvSZpAG1LtvqxW5KOKHDDeiqttJA8kqL5c15hsuuxWdmAPZb4BXdETO?=
 =?us-ascii?Q?vRbyA8dLjuP5sDJ9sezOC2quWpIrUJU8890Nfa8jt06yPxksPhXHiPDPYDmC?=
 =?us-ascii?Q?/w+6W8MTrVkvKaklRZAAtLcwHrDlOJ+naczdL2qN1KyhxygKRJWdI6nRhFrP?=
 =?us-ascii?Q?EvIoUl2hz9eJtPz7+P5ChcjrE8wuUCC/Hgy8SHI7oEI+MDGPCLM9S0p7LrUZ?=
 =?us-ascii?Q?17WGKTTVUY3cKbj9SSHQ9bsfoY/e590JMvAy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:09:43.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e9754-6edd-4a42-774d-08dd8905427d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308

On Thu, May 01, 2025 at 04:01:28PM -0700, Nicolin Chen wrote:
> +static void tegra241_vcmdq_hw_flush_timeout(struct tegra241_vcmdq *vcmdq)
> +{
> +	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
> +	u64 cmd_sync[CMDQ_ENT_DWORDS] = {};
> +
> +	cmd_sync[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
> +		      FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> +
> +	/*
> +	 * It does not hurt to insert another CMD_SYNC, taking adavantage of the

Oh, ignore the "adavantage". Will fix in the next version.

Nicolin

