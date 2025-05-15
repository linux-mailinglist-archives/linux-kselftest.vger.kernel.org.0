Return-Path: <linux-kselftest+bounces-33094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E70FAB8D2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197943ABD86
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A2A2561D1;
	Thu, 15 May 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iy5YgLyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F221A42D;
	Thu, 15 May 2025 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328624; cv=fail; b=jzD8btvKwQ/QntU2s2e6NJxrTAcZBzZam1S0ldZvM6jjGJKlloZqAIXlM0o32r2i1ILpCjPjSULZSE8CgyEVd/AQCb6E1rY6O8nCl26UwXhiENxgbePhZCXVvlwOy3oLuFC0C12biFEr/Re6mofMyD3CLQFHCi0TNadnEfKMx8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328624; c=relaxed/simple;
	bh=u4XHc23Ve9AdJcYkoxPM6+RYtXUpwhuhQUrwHLwaAvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQWf4a9D+ytN/AEA/JLjPV/iV/YvrgtpsHyEcDeN9wp2MUI2iFVbn55AnrTad9WZASwSHISYDV5pp8G4RUl/oJay3PZ1luk/HWgPU67ODUdFf8ISEooh7QjVlUL4xyR9MnRaGSSTXDQK6/ZHZKXqydjQ6z3aa9z+IiFuD8SY3UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iy5YgLyG; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuV45KjSORhw38YKb6VnZhrTUYVi6q+ArMSedaXyHgNEub4uxZWzcNVXFjjW1cKKo07RNDAmBUplIQz0YUAWPSONhgYI4bRSiVHk6Tbw5jrNuBkhh9UYWVFRySpq61rJ2t9VRRxT1eaGpaEXtp55uwwCst6X5bvAZbhi2C++bjZTV8rj95bYpwX/vbFd9kHL2PqhamFXLLJbBWAF8GHVzDZETVOTZqMnRVYSl1tVhO66Eyiuif5a7VHTtmnZsIZJg1H9xjZG9QtytwWogpOMwnl4UVYsoGL+kz+X74AJrjTfhGAmUKayR8wFYYVxmZn174SYnlUrUQFuCqha66QVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIBptZqsCP0uuMZjKPhMOQNhZcvEJOxXi5C+eVfQKWo=;
 b=jOeRdd+1imSNQWYKeLa7kACXWOR6xaF9XSXTKhyuq2mpMuPtE27a63bfpY9mUc/xh/euMDBC709mbzGy9TUMwo0lc1u/wGSPWSb1Wewhf073k1wfRAjvJa3YiEHrZ33oStOHztZQw4YRrUVo1WiKm+J3v9wvmIUic0LrAZMFZCA65ZAFNwZywufUcVVCxAuXvkxCctbGOlMx5c9CueI2bkYfR8Ol693SYL/7yAkS5GdKUi2e3IcGSoWBlfIGPNh1jsVktZT2+eApHzJ0uCrO/rCGIRUi50S/Zsz9MLeJUPmeveMp0/Yn1cp/v7uBzIsAh9CNC/K1hUGPub6/BGL1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIBptZqsCP0uuMZjKPhMOQNhZcvEJOxXi5C+eVfQKWo=;
 b=iy5YgLyGNJoH5C/xqrGQws+0nW87faA1OssEjZHF5v3ShkLyrVIFfrg5qXDDMytQIUD4tKOelqhRxieQjbDWu4RFt9nXvfu01Iea+bPVgA8QUSni5GftIXq7VFhQlc9TZQLr+LiLnQ7EGUNkYBYFS5AL1q81gymK3s2HhRQc6kAZdpVvdxrIthX2A+ysr1rFBiQF08zd0vp1o70RaShQ5D5b9TCS48ReQpHgH7uw8QcQbT9ST2oJjaKtTO1KHIj7SEDEXzGfFHGvInMwDva7928ZnWxgK3gmEzQT1pKN3DSb2qM7UhxIimp5LcQm7pCoJgIZh7q4ZeTiWQWKoOMuQw==
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 17:03:38 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::9e) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 17:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 17:03:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 10:03:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 10:03:22 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 10:03:21 -0700
Date: Thu, 15 May 2025 10:03:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 21/23] iommu/tegra241-cmdqv: Do not statically map
 LVCMDQs
Message-ID: <aCYeWL7BlTjx5TxB@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <80d41b740635b40dd0f9ed4279dc1cdeb3c8942c.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB5276FF1D733E5F086C6A26968C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FF1D733E5F086C6A26968C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f31fd9-6b27-47a2-23a0-08dd93d26fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBCLcPnxNbYFTN8bdRr4eI4sw3qA9OiH+bLeKpdskyV91Fwy1ViiCcHVFsb2?=
 =?us-ascii?Q?RQzDV3Lv8kLYBXem8GWjuSPTI1U9OxfJVAC2KO2y6mu6AK+S/sGP8A21Z4iC?=
 =?us-ascii?Q?rFo/79ADRtIH9Ql5YZecpje9r2cw+devc9eNR6p7pmDrO3/2899AmX2Sj0Qv?=
 =?us-ascii?Q?iM4MmdAlNvxmo8wssYcyIxDUKtqt93b2NUDy1ult2TVNot05XUY3olHObyHI?=
 =?us-ascii?Q?QbB+335lpjxvcZanP3yfr7DwNDIoq4Q1jvvo+A8sJWqyXkqEJJjGCPkDMm+O?=
 =?us-ascii?Q?bvDB/TGu05V1R+HYWxm+jOaSiqGTdkn7iKnwUN/ekNq++VoESgibpXiLaTOF?=
 =?us-ascii?Q?wFCwlYhVLDbPEe1x7pZ0gxwhcu3rHGCy6Xji/lcaWS29HGC+O4HFIMQNIK+b?=
 =?us-ascii?Q?Xoo2FxPO8ynHWzTpOtowqPQOVcKwpu+ZeQcUVcjivknFfLNXbFLjiwuDX1kN?=
 =?us-ascii?Q?nrFAA1+pTw858OLf0+LnbuN1HfL9hwElxsexnYO88ZMSQ8sEgOsZ3xdgJxW7?=
 =?us-ascii?Q?Vg0XGH0utQTBnfhxKlHbNc+hk1L2t1qi8RRC9TOuNZ+Zmfqe5ycf92HpFC/p?=
 =?us-ascii?Q?WJiINnh1rWya7AzJN+VGccIX3wJpP1pJOPu2a3DwbuE9EHWAWsYFJXni9X9p?=
 =?us-ascii?Q?UpcKG3ddxp3B7aW8ygheTkM8hqtQn37iV3ZCdo+IL+J98cJjl8nOWA2CcJ2d?=
 =?us-ascii?Q?zwn2giIkQ0aC+VEl+ZzLqkhAVD7DvS700IEdOUmIqSnEsvCbB8aHGJEcqjjR?=
 =?us-ascii?Q?RFLA5sRBnitYUvViBawyJnn+lFjBdw+yGYmE1m4QR4bxLwmHklIBufbcdsEx?=
 =?us-ascii?Q?6jvf6rPhKMwlj8QES5HG9bw8Wo3m8m8W3OLjcmekwB2QHT3jw1kLYH/eGTV1?=
 =?us-ascii?Q?CG56dBt3Lta4NtdsoLtjbKRHV1VfDepxPW++nz1TUIhAydj2iCeQ+XxI3u2/?=
 =?us-ascii?Q?SVBU0Vxier+YUmd1gun5PwZCI1fyP9B/e2A40pC1mBWfaOeZups8lShuluP+?=
 =?us-ascii?Q?m2QkpSFHZMHdQQOdeb5Jwy15yGI1B4BmIGMZsW+dTh07GDQ+7/rQNUOUTxPs?=
 =?us-ascii?Q?oGxZ754laD1bW6mDII6O57pHwhSagQKxVuC2ShPdxR1E9vofur52awO/hq4x?=
 =?us-ascii?Q?B2zaa49IAR164goyYn0jA1MWNUZXJ+37HeQi16Iut6Uw+ODGgTI6h9ZNPjgW?=
 =?us-ascii?Q?EyvYWAW3gG3eRuL3tvCHn+u/ZWQ7LnARTeFDViRvgWeaIuiWUf+9je+pPJn8?=
 =?us-ascii?Q?CYe4cb+xAbF0ZWQZpF+tnsjPsvI/bsFOrAex/PDldGXwWHwo0HtPne824C0r?=
 =?us-ascii?Q?pUE5P7Mb93SKNgd5CAryVvSgTcJvk4IBIs0kR9mbhCY2S5OzNVXFMaeB3O+C?=
 =?us-ascii?Q?SHe0qrUA8wcL7aXUeYXbRT6GYBcnRs8h0s89NZT5DTgBsH7v4DwLBhnNoXiE?=
 =?us-ascii?Q?lD1MyYEua9mUhNn4U2AI8/VPBihKQbZhRRN51D9OAPtYl5WSFokPCN9Pn/1k?=
 =?us-ascii?Q?V9k8FYF+25D2t6TTLstL3vmCoLPIcvvYVu03?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:03:38.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f31fd9-6b27-47a2-23a0-08dd93d26fb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

On Thu, May 15, 2025 at 08:20:44AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:03 AM
> > 
> > To simplify the mappings from global VCMDQs to VINTFs' LVCMDQs, the
> > design
> > chose to do static allocations and mappings in the global reset function.
> > 
> > However, with the user-owned VINTF support, it exposes a security concern:
> > if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
> > or more LVCMDQs creates a hidden VCMDQ that user space could DoS attack
> > by
> > writing random stuff to overwhelm the kernel with unhandleable IRQs.
> > 
> > Thus, to support the user-owned VINTF feature, a LVCMDQ mapping has to
> > be
> > done dynamically.
> > 
> > HW allows pre-assigning global VCMDQs in the CMDQ_ALLOC registers,
> > without
> > finalizing the mappings by keeping CMDQV_CMDQ_ALLOCATED=0. So, add a
> > pair
> > of map/unmap helper that simply sets/clears that bit.
> > 
> > Delay the LVCMDQ mappings to tegra241_vintf_hw_init(), and the
> > unmappings
> > to tegra241_vintf_hw_deinit().
> 
> I don't know the specifics of tegra241-cmdqv. But the current description
> is a bit misleading. for native tegra241_vintf_hw_init() is called from reset
> so the mapping is still enabled in that path. for user-owned then 
> tegra241_vcmdq_map_lvcmdq() is called from tegra241_vintf_alloc_lvcmdq_user()
> instead of tegra241_vintf_hw_init().
> 
> so nothing is actually delayed in this patch.

It is delayed from tegra241_cmdqv_hw_reset() to later functions.

The in-kernel VINTF0 is not literally delayed fundamentally as
you mentioned because it needs to be allocated/mapped in probe().

The user-space VINTFs was previously allocated/mapped in probe(),
now it's moved to user space handler, i.e. no mapping until user
space asks for one.

Perhaps I can make this "delay" statement more narrative for a
clarification.

Thanks
Nicolin

