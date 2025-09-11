Return-Path: <linux-kselftest+bounces-41209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66779B52832
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 07:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C010C4683A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8D253B42;
	Thu, 11 Sep 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEa3aIgb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AB24290D;
	Thu, 11 Sep 2025 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569115; cv=fail; b=FTeQXR2qIRrwl6slkDf3wj2XnnGy8Lfb7/I9MhITlMOO/qaMf/QcdZ1mN7bxPVe2i3D55eTlfESJ1xBVTQAzfMr+Og5/zLjpC9HGVxE7UXXZb7Ydo7M7HqD8cvSq24vrqH/kRa7lUaqyiEBzwJzjjHEpxsK6JKcRblzVf1WbPt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569115; c=relaxed/simple;
	bh=Pmji6PbJSQA2S85di80QczaZwvE0axdDRm46QQoAwtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWtSq33HMtxRAZ/jbWZy6RtxCsJwYhR/fTp1eEAtYuewLVMrYQwFkNgluwdr9LJo/Pl0k81Xp/1DQ0l55bC5LT8oQ82Le890BaIEJ4r4m49iUwRBQdhnBg5cm1M0TRtP7Md7Kfbph5/708BKmTIao3AhcHEqOVi/cV1bli5wXqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEa3aIgb; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbySwZcvleOjlnGK2dY0s+7A4jLfq9oSGukpia13sHvRRlfk1bCWtyZXDw0uNgr8oZVkpVKBFnuZ75fOS3HQif6qMxwVYyUBm+mcLBdVMv3jeEIpJQH8kwplTXvHBFbaSixl6PhZvdupXpTkVD+B8qd31laM7k9nYpkZDnsNFU/eGk0rorDxaMYl3QENIAsLDLKbwl/nq/eFeDbRDhOWWVkSHJeSM/FVszyIrL0/hB88ONcaDJsSq4s4B+t+SG/n1zT2T9HpA6xQ3ooqiM5471q5RUAdnC1YiepWn9SJRCAIiL3Bs//nQYQAcUxq3s15Olxa4QnM3CbpKHACwu1TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI0+oJqVn5UcnIDmyCfCsAMdForWsY6pjFSTdMLpPIU=;
 b=qqeSU4b4ZyIpQgRkLu1zQ75Ds1BQxtXVC33pPKZwkJDubsMQajf1OFkyYvo6lzg9L1jzTHSN4WvQAtenwP0wS0kAn/n11qGDKMudTU0qjnl0yQZhY4YYgOq38donM5R779Ny4x/Z5Bg/MOp9WwMV/VWYMp0Qq+MRl6AUx7Hik4VnI6u4eWneOtBkFubtLHbfwvBprQR6t11UFwkWUA18wBqmBGL/Q/CWThEdYbHJS4q2siT/1S2wjr3nHytG0zsE+FKqdyqGgAsKRI0gYojAMNviL2X3sOz6Emp99y26yBk8RzUFYYwro2fN414tgPOZH6jc5sY1cnTjFbdmR1NGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI0+oJqVn5UcnIDmyCfCsAMdForWsY6pjFSTdMLpPIU=;
 b=JEa3aIgbEe4Qrf0PgVD2WI7kLOejRY0UrrMzg+oUJim7PWyozBFWbrEFLTwmqDmPBb0eYVp+gvfpDZa1Zfc3ynLEQN5fowi7ysFKXSozj806JG2EUs9eVsD9G+1LC2JPXpqnLC1qAgb5az5qjiiw2xT6rKEEfksy/P5bPUuR/FKgvPZrJaeB6Ld4SvwXuLVUP1IFLwW9BQMSlHYOSNnhWFudi/vV5V/MWSFW5t0ZiIi+u/U1ToLUg6rPfxWb9nd23B2EqaOBvvcPKySdo9TxRmRkxHg7ZszzGdM0+Q58YB6P7Pq/7piDBBE63ZPm7jgCxwBidP4ovkq/t00OccCiSw==
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 05:38:30 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::7b) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 05:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 05:38:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 22:38:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 10 Sep 2025 22:38:19 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 10 Sep 2025 22:38:14 -0700
Date: Wed, 10 Sep 2025 22:38:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <aMJgRGl+znjXJRyJ@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 35592c8b-dfc3-4ba1-f9bd-08ddf0f570a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XimgNsGRrYi5YagYVf+g2OvmnyfEv5LAk94TqlhFmi32oh5OjtL5k7P6t3LA?=
 =?us-ascii?Q?w39iVJmqpwGTTath5uZnBB9q2YKi7UOvAMFc3YXEPoq95j3jz88GByFSU+z6?=
 =?us-ascii?Q?7CqWLL1osZXq2yC6YUi+SfAeuMJ+7aoIxLoZiajNbuoPQGj4YDgkASjeUjOa?=
 =?us-ascii?Q?3grdgTcHRPpuUvbqFilr39D8lhMbFeBoLBMdD3pEmfNbmyyal3e/ZAVjAJ+c?=
 =?us-ascii?Q?tkDNtNFJgLSANObfzKnmqoCml/77txdZoorC9dy9iVrPvXYk4CVWU5MVagno?=
 =?us-ascii?Q?ihVaoDtIPzj5Cci69fX8mf0g79pRAAB0KAhPDiN0apr+WwPuTRinCDiAKO9P?=
 =?us-ascii?Q?aRYbhjs0F3R5003jtLB16Wcby2thmnNn7cLDDjuujNApGuc24glSkplFQxXa?=
 =?us-ascii?Q?hTjgY5e8lSrhgax6GuoJP8OL4d8555ZHc9ksNfEWhJNaMasWXkuuFBwC3ZhZ?=
 =?us-ascii?Q?jzuuFYwpiR+kJxhrCSjwmXQsesVZ9KvnFZdDWStFE9FTd7JGow87FJgAkmVr?=
 =?us-ascii?Q?NRxcTZA4btydZSG33ATdF5b1bsbuVFtRuOLF30uv0ZdFl3M9Vw5J/JtWYBM1?=
 =?us-ascii?Q?mzMd1252Vp3IDV34toADhIMVo5MGcCQT8KY0ibsNuRPa4a6p33mNvtyU78Qk?=
 =?us-ascii?Q?rW0kwBvR8aCDkB+1TYuc7HHeAAVYXLSOZEYjp7vVg1HqUWcgpIAw7Bvv9pEI?=
 =?us-ascii?Q?ALzPimFUz5jOgkauZyQf7mop4xlKnAaw/iskKgDqd9UmRHn53vDTq/Ziw6a7?=
 =?us-ascii?Q?mx4fYApcep5clTW7S0ILJ6XK9Y7AYCRtfRpeN55JvU9aVqse2NxytEORIQU0?=
 =?us-ascii?Q?3/snpIUrJI8E0azabfqsBDjxx/XenD3XDz172dHFZTIhVtToDpSbu381ztsO?=
 =?us-ascii?Q?zCTxLIkTvFl0JfP5ey0aOLp/wg+mCy/uLcU6ViEz/6WakgcH4PIz4qqYpqix?=
 =?us-ascii?Q?VUyGjUxphITl3CQorQV/HdmUMB3PQFM+FoUtTXGQFwUYf4/5H2U6gfxUIGjb?=
 =?us-ascii?Q?rrVxeUzlVLGITNLA2cDcvOTyApxQNGbCwEOtd187iSBeNpKwPQWzIWdJYtc4?=
 =?us-ascii?Q?bqaX+MMteHiePvAJs0TYwE0JIj54u24GkVkQ1LHOYanXAvDwYiy5JCs/+Q52?=
 =?us-ascii?Q?pl/mYrKdMV2mWTwkhDvcxkMg8wmAW/fnn115G3YPOMgeqi3OCF9q7K3lh2Lr?=
 =?us-ascii?Q?oMCFhMLSgConIs1qID7A5WVg/JItOMaLKjiSnktmpdafFtThVOIjhp2X3n1e?=
 =?us-ascii?Q?ot8WMFdYBhFS2LShlPFcsnZUDYU+C+ZIYhR30jgxXXyXvEPUYUNH+QlK7EZP?=
 =?us-ascii?Q?6J5EQg9LiTFG+NrnCU0K1/aqnSvcpyL0WhnmpQFoceeOXRpFWzxQQbwKhgDy?=
 =?us-ascii?Q?+kDLbKe/nff5YayQACuYP6am7EFIENcY4Ajg4JYIWjn0cfyDgW6IsNXO+dIj?=
 =?us-ascii?Q?nnP6ht2l6Mt3wcFvrMirw5yE7T34Xjb86yvCg4/CoGkyo2/dBqO16JFjlFMv?=
 =?us-ascii?Q?shWKAFRYBE0WuiIb4ULnQlXWocNlcvgjnezK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:38:30.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35592c8b-dfc3-4ba1-f9bd-08ddf0f570a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

On Wed, Sep 03, 2025 at 02:46:30PM -0300, Jason Gunthorpe wrote:
> The top level struct used by the drivers is pt_iommu_table_FMT. It
> contains the other structs to allow container_of() to move between the
> driver, iommu page table, generic page table, and generic format layers.
> 
>    struct pt_iommu_table_amdv1 {
>        struct pt_iommu {
> 	      struct iommu_domain domain;
>        } iommu;
>        struct pt_amdv1 {
> 	      struct pt_common {
> 	      } common;

According to include/linux/generic_pt/common.h, it should be just:
		struct pt_common common;
?

> +static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
> +				struct iommu_domain *domain)
> +{
...
> +	/*
> +	 * A 64-bit high address space table on a 32-bit system cannot work.
> +	 */

Nit: this fits to a single line.

> +#ifdef pt_iommu_fmt_hw_info
> +#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
> +#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
> +void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
> +		      struct pt_iommu_table_hw_info *info)
> +{
> +	struct pt_iommu *iommu_table = &fmt_table->iommu;
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range top_range = pt_top_range(common);
> +
> +	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
> +}
> +EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
> +#endif
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
> +MODULE_IMPORT_NS("GENERIC_PT");
> +
> +#endif

Nit: maybe
#endif /* __GENERIC_PT_IOMMU_PT_H */
?

> +struct pt_iommu_cfg {
> +	/**
> +	 * @features: Features required. Only these features will be turned on.
> +	 * The feature list should reflect what the IOMMU HW is capable of.
> +	 */
> +	unsigned int features;
> +	/**
> +	 * @hw_max_vasz_lg2: Maximum VA the IOMMU HW can support. This will
> +	 * imply the top level of the table.
> +	 */
> +	u8 hw_max_vasz_lg2;
> +	/**
> +	 * @hw_max_oasz_lg2: Maximum OA the IOMMU HW can support. The format
> +	 * might select a lower maximum OA.
> +	 */
> +	u8 hw_max_oasz_lg2;
> +};
> +
> +#endif

#endif /*  __GENERIC_PT_IOMMU_H */

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

