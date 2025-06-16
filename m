Return-Path: <linux-kselftest+bounces-35088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B115BADB5B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5750416857C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6A264609;
	Mon, 16 Jun 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TXLUCNxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E611C2324;
	Mon, 16 Jun 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088659; cv=fail; b=NtPNEjqLvs/Mcpo5gK1KPBkY4ssrTOoTGWHWnoDGoLgTmXPz2/hfFGAIJJNTPzu7d9eMxfb+QfWp4kREAdJvm3SZI9JaulRKTsi/V0zhqaUIQxTPDFFqi8KqFgacgIHUU9+gQ/zxGkhoqzynjdNQrx8Oogx4kjBNHpEhT82Ealg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088659; c=relaxed/simple;
	bh=U0bY4cZoAmKnXD6T291NDM3dLuBYDAL8exVi7oDWd48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSI04qQfaKcRzmQbxVzj0C0GdVf/PxXOGPMtTc8N8njk0vsGTYJujPRpQ5HWxhdhHztEqU09lBs5+1ALumbxho4OoX3lm6JcSJ7ujOnnsrhMD10fGdUR3eNYFGVxpk9fKKeADLGJdjrGEvVi/E9S/nwwvXKTGfLyl65nDlf49kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TXLUCNxv; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3XShSbbT4WK9TeXLU+8KGsXVQa35jKJ4O+ziN7G+lbsRyUzjPgo6v7d4EjdfwJiG2mbONTJo57oDKgosZ3qq9KG6mJuhaMP6yXiCLfhvDUv80PZYCsykczJUhxOgx1CnnfFhgVJGshyZCHoGGvSQo5QCFdoyRfnGaRc4WGTAnpVj1R0J6V23LtcdL5/bHfPJ1WfABhXcvpK2zmBUnYJUAkJRM677Zbi1sZnhTyZRdEKQrHVJ4g17vd8DM9dlfVnTDSh2ZrQbIkWy2ssqQGc9ftDjh9T9pWiRPRckD5jKRa1MKi1HhDG0nJPXMTqXACV7bPlR03mU3da3Ba4cU32Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsA25X13WonFVcloDh3qjBXVCkIuWG2U8KU7irxepaw=;
 b=qHfSf6ZGFRZxuRQCE7RiDZLEWIhJLZ1HddMk6PZR1wE4Q7S0t9ArzIDnpqKCJdbtw+oyzRuORfYlPytIm0BXre4un0JVqkYOMx50FjzMb32R2CQwxxp+QK0NXGAJyHz2/a+rsinFt+1aN82NZ+25mG+wVEMNchVZ2P9Js7HUtVGif2AGBSmd7eXOJJIlMph2+f5989561zoquEFPZaTlhyyynLfdo1AlMwCn6C+YMzgOTXGGSG2WYmL1eMRSGwL3jyxFieY/k+sm0a1gI/iBGdTJavSYMQb1EFjWLI0knWSUkY32m+sTVqsh5eyNHZA5JZD3kBHB8KulWzPjQ/O1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsA25X13WonFVcloDh3qjBXVCkIuWG2U8KU7irxepaw=;
 b=TXLUCNxvktyKc735X8BzMVO/TCAtGD3DW4LjeS8lnn/nEgmlPS3MKW79wfP5QQ25t0As779BX1AwJLdpxTX+CuI4fqtGvT7t2ueXZqWQ9HpjohP1V7HUpK6wDVgvCI+X6nDusJMakqILmNir8nM3/B8BQa6t3ADRk3hqDEcOzvwTr3mW8lnm3fXW2Om1Y2kh07hkkxbB0mG/KDYtzbWpu+XC6JH1+HCcaJQ+ZCaqiYC40AN8GkGl5hNwubdBzheVDozSiSCDplIGAaYZo/qheP7t+T4IGmNRGfbj8Vn47C05jeldnFjjcTxkt5G/xyNQ2yQkgFBPCVPk5voW+eVnew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:44:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 15:44:15 +0000
Date: Mon, 16 Jun 2025 12:44:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 23/25] iommu/tegra241-cmdqv: Do not statically map
 LVCMDQs
Message-ID: <20250616154414.GL1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c10eec6d48fd25579755973d28ba4a79a21bf721.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10eec6d48fd25579755973d28ba4a79a21bf721.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT1P288CA0028.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: dc609bf9-5c8a-47f8-541f-08ddaceca5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQdWM2grO/nNtZ407RumjeF/zpVpCUXcgOKpXbcA8rPl6zHA/+RDDckfW6th?=
 =?us-ascii?Q?f4MemPzTXn4vFCANQEOc+fsjvnThM2fgJ4SFeypmmSKylNVu70A+UJSX5u6z?=
 =?us-ascii?Q?VchYD/UWd2aHuebgZBgqE3Yr3vXREtVH24rVeeBuV03aR1aU+hdZ7qYNW3Ub?=
 =?us-ascii?Q?Fw/G3uhZ/iuOJVJLUOTAhZERtplyyfKxgfh0M9ZOYi0y2nSYRGnHzbMd4NLv?=
 =?us-ascii?Q?PbdHBPaC4vGPyk88zB6a0z4k4k6PTfO7hRJVM9+Sht7+Ze7oclTfx0xx1vp7?=
 =?us-ascii?Q?XTWSdtl0tM1sJwGrHcn2+lhxqHgGcgV2p3sSY/XfwjdpxdNgMIB1Ulm9GtDm?=
 =?us-ascii?Q?MgU6GpCwepCH0j0880PEwIM5nZFa10PvBHJFNxTVTYwAyE4UfEu8tBqE/xLe?=
 =?us-ascii?Q?8emzDYP7k0F2tlDsy/F9tTqwNczTwMv3c4WJX121CuKvjW3A1oYpZvUN9Pks?=
 =?us-ascii?Q?5SfUFTVu5Lf/cjELWHJ6OIs1GaGOx3tKry1+VBs+eSVfqVpiQGqbfma7+XDf?=
 =?us-ascii?Q?OjRAn92akSv9NlJnj/dTn71NdPFeF8v4rNJzUZczJNkyNtjMF7TGSJDiFkH+?=
 =?us-ascii?Q?T1jjmn+H1iLCtLwxd5J4Uas0mQjK2f33QgT3se381o4pB4Lnw6Aihvd63uUg?=
 =?us-ascii?Q?sgUuYDKX11bell2au1U3i+LzB9AIESL3SZOxVQ5RQBHD9qo4tGnRETCCOR+t?=
 =?us-ascii?Q?A9AF8mDVvWhbwft3FVKLYp5fsuzs0SrYEyimCq1t5QJws5orUgeqS0c81y6J?=
 =?us-ascii?Q?mvnOp4g81EJpQB043R6NDyzPpuLYbGPe4Eed47ydeLWGOEQF4FJVlOtLvoCj?=
 =?us-ascii?Q?hw1llMwFRVr3onx+SBiKlvAgz47bm6vh3LuzcVihh0Ob4uJL3oACR3iSJ2Lv?=
 =?us-ascii?Q?Oo0nGtj6FXi3gTRlU5DRPojzvCEa/qMo8iGWe+tVenGEzOXPK7w6zRG1yxqy?=
 =?us-ascii?Q?pnSSU49X9fHrli2iAto/OKy6B2Ph8drD4PiH35jNzhKq1nJkyLHmxywRGkqa?=
 =?us-ascii?Q?ci6ZU8ETZpZ8rUM9l5MMFrT8DuvESRSwioh9tI2bj5sXRUBNjWnuWnrBQFp0?=
 =?us-ascii?Q?k6njaopHaIbDBtLrHmDw/SwdHw9aMUbTP4RtLxr/LSxb5WDvDzfOW2zZy6Me?=
 =?us-ascii?Q?y7DWX+PrnC64i5o08SeUtazCCWdmL6br/jWQ0v15hx/E6l+H4PWfedO1W4cm?=
 =?us-ascii?Q?SR/XZ15dRPryYyB1YKdUMK+8XaqBcRvz2calOV8LDMeALYU7PagvsL3iHLrL?=
 =?us-ascii?Q?BiLuBw75RYZHb/aKk/qrKpMTPezlMEeStTJ8vPocSJq4aPwsymcMR6fJ984l?=
 =?us-ascii?Q?yvqVEccEZqRIexOsGfJv/hXXxTa2Jd8RM17dmcIlz2L6uTq/wHX/I5BeR4iH?=
 =?us-ascii?Q?QA63QfAjmByIHKhB0zMC7g0rsOwfk6m7grFwTrambTQ1QNMmnAntay8hNvM6?=
 =?us-ascii?Q?WCSOpT9ZK3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8FeeCXINH+x+ktoMjjNsTTouA5244aapWCjhZbX58LI5IRTGTtbnSCRrQM3f?=
 =?us-ascii?Q?XsIfxnA1LPUFwhecl2qxV4ySigJXrEppL/9X58usYMhnKKCcz0VsWk/JMM1e?=
 =?us-ascii?Q?XdfASmi8Ub7a1BGj+oYD71uzFtaOHp9woUArgcV5j6ly0fduoka7Ec4XzeLW?=
 =?us-ascii?Q?Fg8hlMzYRoDARZ/opN16C+k4Aj+MqnfM4V4BjNolUg4Pa8iU/de4w4DlhBBv?=
 =?us-ascii?Q?VlXD6vwdGxEh6QoHTLYunYFu02t0J1QbVXDnBb9lBNYtCex+ujcxjbEMtbCu?=
 =?us-ascii?Q?T58kGt1GfhxDj9p44uGXvB87ConG+/JMb+KUO8ydoSXlzIvlC4sa4mH4f9/C?=
 =?us-ascii?Q?3riEQQXvuuYiGkNFIyZxtRtLbDu2o2FIBNrEQ9nJ3Ta32ba0Etcm/qfhNwe6?=
 =?us-ascii?Q?pfFHH9iuYMklC7YWr3UxbbvEuOnCdMeWx7LRRVyblrGbj94+eoFE0on9uMlx?=
 =?us-ascii?Q?1KgYTwYRz42wy8G12yAAThf2wrbZ7gHaTY2FBbp4pMDAFZtY6n4g3sM3Q9YM?=
 =?us-ascii?Q?O2+m5xucQEt1f1FbOLfPOI0j4UQ8lcZ7Aisp+SZNfB2I8fmqlDwuAPeS/DOu?=
 =?us-ascii?Q?8yuzzzpcNxZrIxQvWX9OjCHj98T3jllzsNTYgTVsH+4/oGZkid6daFBGAyQt?=
 =?us-ascii?Q?gKOPf78iq18vgYOf1OZWVSXBWUVeQb6RZItlyqOAvhSu1gEn6Lm0SV2A7g6w?=
 =?us-ascii?Q?OLu762PK5bZ6mAVReMcjxsb2mY8PREfTghmX/u0KAX+WX0Z0z+kfRywC/m6h?=
 =?us-ascii?Q?e8QNoLIAJ8i6nhxYdI6+NRsmXqziN6BlC9jXdg8FcW8Jo9C7MX46XVXn0azh?=
 =?us-ascii?Q?1Qyh5d2A/McWqhQj04HJRc93xKWEsBEB6l+d6zO+Jpzc7quJuzqDbJJY+ykk?=
 =?us-ascii?Q?sftVhMGh6/ueejBmdjc7PezpUolCSCK7Be1WtKKjPTnNjANhUE4t0fmzbnfw?=
 =?us-ascii?Q?t0WoAqGVORqZd2ajPyjpQbLQIxLRJQZrqC1Rh4lsBpyloaI2k+AJM/SrG2Px?=
 =?us-ascii?Q?sK8MfKfrDdmuYqHFM+OO8tUNQP9+dhpYzwrd3GpuX7ODPkqDEFSYr80JJkiJ?=
 =?us-ascii?Q?IaB45g4ZA5PkZw7qaZV0K3yeygIZjEAzfiUd+cvwW65eCph4q2taXtm0Q+sZ?=
 =?us-ascii?Q?7QtQKDIcDGKWhTicW0+5mYbswfyWpCb9r1QotHHmhxR4Z++QgWjBXi3FsjlN?=
 =?us-ascii?Q?VCqIjcWf2yBtty/9oWlu7jI9t2xefGYfTu/IHQwEWpxlkK6ILuaGF74jV0bT?=
 =?us-ascii?Q?YY8xfPxdok49UsmGcWFCXB/H6qInzf8b6fyikIRKUWarRk+UjGr56nIO7b1r?=
 =?us-ascii?Q?HCdsk72haXhQ11inOjR9dTtFfyPz3hd24F/kCuikRjV5w696BUBNGbHY64OV?=
 =?us-ascii?Q?K4DK4RhB3jaY+190fQlJ9FMNgi//sutXX0gmMFPrEZpY9sj+8wmul37NXdL2?=
 =?us-ascii?Q?o7v5w7tkAEmc0FmJVCo97I6RNkQTsLAHfUVc5W+4+PLL5rWIOltgqb9KzX9Y?=
 =?us-ascii?Q?r3n/Uq4Sfg6C97herWqyvCK6DkMLw4BIfbPjH3hLJ23DzPUBXi6m+SPsGHD6?=
 =?us-ascii?Q?ZElU8gRBeanODCtuIm4l53pccdbVizaFdrt0vEjg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc609bf9-5c8a-47f8-541f-08ddaceca5ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:44:15.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUXNeK+qf6czD05ig1Wkc+MCl6WJkdOQfl1X5k2ezsSSC/wv/zvRu76HJklboZdl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698

On Sat, Jun 14, 2025 at 12:14:48AM -0700, Nicolin Chen wrote:
> To simplify the mappings from global VCMDQs to VINTFs' LVCMDQs, the design
> chose to do static allocations and mappings in the global reset function.
> 
> However, with the user-owned VINTF support, it exposes a security concern:
> if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
> or more LVCMDQs creates a hidden VCMDQ that user space could DoS attack by
> writing random stuff to overwhelm the kernel with unhandleable IRQs.
> 
> Thus, to support the user-owned VINTF feature, a LVCMDQ mapping has to be
> done dynamically.
> 
> HW allows pre-assigning global VCMDQs in the CMDQ_ALLOC registers, without
> finalizing the mappings by keeping CMDQV_CMDQ_ALLOCATED=0. So, add a pair
> of map/unmap helper that simply sets/clears that bit.
> 
> For kernel-owned VINTF0, move LVCMDQ mappings to tegra241_vintf_hw_init(),
> and the unmappings to tegra241_vintf_hw_deinit().
> 
> For user-owned VINTFs that will be added, the mappings/unmappings will be
> on demand upon an LVCMDQ allocation from the user space.
> 
> However, the dynamic LVCMDQ mapping/unmapping can complicate the timing of
> calling tegra241_vcmdq_hw_init/deinit(), which write LVCMDQ address space,
> i.e. requiring LVCMDQ to be mapped. Highlight that with a note to the top
> of either of them.
> 
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

