Return-Path: <linux-kselftest+bounces-38028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB3B139D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2842B18901C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB225BF14;
	Mon, 28 Jul 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tb6GVmJE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD725C6EC;
	Mon, 28 Jul 2025 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701842; cv=fail; b=qYksNOJKPmFc1BqdO6HmM1AVyYKFRavRAUAb5jeZlX+TIKXX06U3F0bJbwLIs6vpF/F5ncmc1U42lszenUtC4MR4MwxouVrlhZXefjr9AX5P6XJMjin3ujURGtM5jDBhkB+ftcX1NY2AInm+/x7uFz7p5Jd1rr2soaZtA9fCCnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701842; c=relaxed/simple;
	bh=2VOlVgWoZ4s78HchVCXBLnU14qBJOvX8ceTAyFNlxnY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIFxuepHVbrnTlsFnIfcf1Qh6nuVAJQsiVan9z9/GttMiYkxlOk0KDiBfSXVg5p63FQmvy2qvnzibTsRW4HlZB7Eeu13ZUEerAOGeIqNaK8psE93DAmjZrCO/CAtHN1kHrq8DVbboz1Ci8zIfLGsNf7SCmpuEP3Tlkq0enlBlZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tb6GVmJE; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtbbMfQsgGa0rzpjRrGKpjJLylfCVxafiHjW5gXImgJIonJBbbF2+wep2S21pS5KwwTR27ZnbZF5gOd4Qtt0Cvr3tqzU0x3l3T3HZQcpIyBnvlRvgGxcya4zQey3hMssWFR+JGQtd8Pz4yJ/1v8iqpiiATn5N01VItWU5q8smfBHnCxR4Q0i901wemWGHVG+4oll9ftiLWBzfT2oPPiSF7tLel2Gp48anrWc2Elf3yor2a3+gA0Jfdm/UEDfF4vF6zcO94prH86YQ7PG8EkbDeOTKEuYFcmXjNHK4o7QFPFQI6+pTYMaGiHXYjYg95Whcm9rfoAittYntdLVaaYNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTM++gTGTD6sEX4VnokP1y6arFYnyaxxRNidgwXJazI=;
 b=mtG8L7ZArkKj3M7Odri15AOW8rNFXxfJxhbVqqpoztFpDP4ML7rXvLa4w6MpTD52QQUjZjUgUYxX5Z/dHGhQ0wF8Ikr4UrMOpvXeRmOcpFIPS+0Z2EwrBNkn/5kDXy71QMiGjIQAeMAv5Hzp68wCldohs6qPQ/4zuNLXUZ2NN6+gww6iiza8Q6lew1WBP6xWxEPHH7rTROKzWnsSpf48KhAN0Zqs0kG957s9652qqH8St8NV1zlT05hpvTZ+COq1ZE8dHlfK1VOgNt8R4boWTyN7eBde8ffUoa6Fxq8Kvr6TIGBc31u7rOiAzSPjr1vBTdIJ4qtJMWeSVqodDROUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTM++gTGTD6sEX4VnokP1y6arFYnyaxxRNidgwXJazI=;
 b=tb6GVmJEqC0iZdkRyClOSwFntvTaB+4YepHetbkcgw3hXLYTb7wW/ryhiGoFp2/dZyWG9fOVTAHKcQ4RDT6ETS0gPbM58J5P1CEAYcoBx6yNgQlnVaVUJWVccQijZrs9Rej33vF95YXHR+rBWyaAx94gDQjlXurjuPLnXc5D/bM=
Received: from BY5PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:180::15)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 11:23:56 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::5b) by BY5PR13CA0002.outlook.office365.com
 (2603:10b6:a03:180::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Mon,
 28 Jul 2025 11:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 11:23:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 06:23:52 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Jul 2025 06:23:47 -0500
Date: Mon, 28 Jul 2025 11:23:42 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
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
Subject: Re: [PATCH v3 01/15] genpt: Generic Page Table base API
Message-ID: <vbbvejcofng2jpgozzgbh5ifnmdqrtfjs6ix2jvuw4rfwdek5n@3cldml5ry57t>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <1-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aea3811-e4c0-4681-ca5d-08ddcdc93d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?61yrw7nnyYbFNZK8oSq/5rntpDfQD6t+aStY/JCegz9thWuzfgV8DOhH0h02?=
 =?us-ascii?Q?f4cG27JfgDX+50ysn8//Rrli5hzdCrObTW/mroF8JjrClBzisIJQShNqCfAL?=
 =?us-ascii?Q?FdCudRM9BU5qb9PEoitvVUBQLEh8Q5wgTxB6OOQpZFrkyI1B6rxrOtUHEUKF?=
 =?us-ascii?Q?bcb1yqQfD+QJW2rXtcHneu216bBlDFJMHNaKMALw013ioPNTBAk0TJBMrVGR?=
 =?us-ascii?Q?baCI2kaCW4G8n3nFtj9p2JjCpdG8I4OCWeQdaZeKMIgKr+sGKQU3yz7QHlDb?=
 =?us-ascii?Q?nevL2xzOahoJcMJRpzgxA35iIRaebP//OZUhoVhTRbDwsuUupUv4TW8yIDsS?=
 =?us-ascii?Q?iEQ7TFeblYjoxPS28pAGWWJBdPlUim4Br9L/lr4XqjcyOYrWPQPG6wYG2x6x?=
 =?us-ascii?Q?/cDZ6gnAVQNqx1BzZBd8ZZ/UscFJ56eatmxlXLgfXr25wxqt70w6qoedfBuK?=
 =?us-ascii?Q?HrnXzTh8P/JUE5UbQu01VdZsR36eEmVY9hsbQDvu9wL6syEOZ2ptqI8bw60Z?=
 =?us-ascii?Q?8RlUdzDCc9pJoFo4M13hJbv1R6IybalUJkYm09HWjRhGLI3hF1lQcu7NfB3O?=
 =?us-ascii?Q?EcI8s3fC4JJ2vwOeXz5zpHv9V4z9kOEMzrcrQBvrswyI3tIg2EBK2jEbLn+I?=
 =?us-ascii?Q?6D03fcTa/4qrHV7KW/TYFvKc2ETOxD4llzD7yZqqsMG/a4Gdqg28Uyx9XLrN?=
 =?us-ascii?Q?Apht3bxPyb2Ul11SVlDPdnWLlAnUyHCH6FfTW2yLS/Dp9uFcusPWeP06+nWa?=
 =?us-ascii?Q?g/uE92gkgQ6MLXPczjfKyVi2/XdbjbhAxdSjQ0cHqhF6q59ZCqpHtqAOgma7?=
 =?us-ascii?Q?GP+kLEQbKjzipLuTaAEY5V+KwKlDSgeinvqxljXD0D14lDq/SKMLm6qvGum/?=
 =?us-ascii?Q?p2gCKsn5loecMdALG880oX9kQTzD/v1/eVkn2wzwuLvoX0GEcJgtYhx6LCTA?=
 =?us-ascii?Q?kO7Eubu3pynOEr5IhxEr0YoGzaQIcRVUq7pH7Uq9d1wsNnCuJVz/dA0qv7YV?=
 =?us-ascii?Q?EqGEsiIFqjbZwohs6nt+WSPmC0UKAqalMXw8PgrBeMK8fRnGRinErqr7hmLN?=
 =?us-ascii?Q?hfgIy+wOiejhJzeLO6m7Ax7jTgmdVhug1uYHc5ZsY2ugbNUGOAtcjAqDLUZj?=
 =?us-ascii?Q?5muQz9SfF0pbEk0YD30bBvcWONghlxJwMyr3wzF10TXKC90R/qovc9jXVnKk?=
 =?us-ascii?Q?iSHVrtzKUg5dSchN4BcN/4f48DDSnrIthY1h2m7c7WbAiDdmZUk72u3JZlhW?=
 =?us-ascii?Q?XlytuTG/DMPEMysPmKwMEHIJIDbS06cJjSkFJd+Y+euEs+RTcEgw+bWEAycs?=
 =?us-ascii?Q?h3FJoRImqWiPVPWo2oydCdykppfRcZuMotkynAzTmQCeIYWNJ+HSdkg4t8Zn?=
 =?us-ascii?Q?vROlnsa3hFEcw+M2ATiijrSgrHrlj5NxrI01aVcUAy1gGLMNtKEt2D2A01sX?=
 =?us-ascii?Q?EzY4C1xpUOB7SDhbfdODuB4ZjXQcqzKhdknqIUG4vrV2tv7pmKxWFDz3VkVs?=
 =?us-ascii?Q?Wd5BsT3FXVMheffCp3/2MpsjdLv9h48AaIDi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 11:23:55.7591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aea3811-e4c0-4681-ca5d-08ddcdc93d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

Hi Jason,

On Mon, Jun 16, 2025 at 03:06:04PM -0300, Jason Gunthorpe wrote:
> The generic API is intended to be separated from the implementation of
> page table algorithms. It contains only accessors for walking and
> manipulating the table and helpers that are useful for building an
> implementation. Memory management is not in the generic API, but part of
> the implementation.
> 
> Using a multi-compilation approach the implementation module would include
> headers in this order:
> 
>   common.h
>   defs_FMT.h
>   pt_defs.h
>   FMT.h
>   pt_common.h
>   IMPLEMENTATION.h
> 
> Where each compilation unit would have a combination of FMT and
> IMPLEMENTATION to produce a per-format per-implementation module.
> 
> The API is designed so that the format headers have minimal logic, and
> default implementations are provided if the format doesn't include one.
> 
> Generally formats provide their code via an inline function using the
> pattern:
> 
>   static inline FMTpt_XX(..) {}
>   #define pt_XX FMTpt_XX
> 
> The common code then enforces a function signature so that there is no
> drift in function arguments, or accidental polymorphic functions (as has
> been slightly troublesome in mm). Use of function-like #defines are
> avoided in the format even though many of the functions are small enough.
> 
> Provide kdocs for the API surface.
> 
> This is enough to implement the 8 initial format variations with all of
> their features:
>  * Entries comprised of contiguous blocks of IO PTEs for larger page
>    sizes (AMDv1, ARMv8)
>  * Multi-level tables, up to 6 levels. Runtime selected top level
>  * Runtime variable table level size (ARM's concatenated tables)
>  * Expandable top level (AMDv1)
>  * Optional leaf entries at any level
>  * 32 bit/64 bit virtual and output addresses, using every bit
>  * Sign extended addressing (x86)
>  * Dirty tracking
> 
> A basic simple format takes about 200 lines to declare the require inline
> functions.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

../..

> +static __always_inline struct pt_range _pt_top_range(struct pt_common *common,
> +						     uintptr_t top_of_table)
> +{
> +	struct pt_range range = {
> +		.common = common,
> +		.top_table =
> +			(struct pt_table_p *)(top_of_table &
> +					      ~(uintptr_t)PT_TOP_LEVEL_MASK),
> +#ifdef PT_FIXED_TOP_LEVEL

I am not able to find definition for above macro.
Was it intentional to leave the macro 'PT_FIXED_TOP_LEVEL' undefined?

Thanks,
Ankit

> +		.top_level = PT_FIXED_TOP_LEVEL,
> +#else
> +		.top_level = top_of_table % (1 << PT_TOP_LEVEL_BITS),
> +#endif
> +	};
> +	struct pt_state pts = { .range = &range, .level = range.top_level };
> +	unsigned int max_vasz_lg2;
> +
> +	max_vasz_lg2 = common->max_vasz_lg2;
> +	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
> +	    pts.level != PT_MAX_TOP_LEVEL)
> +		max_vasz_lg2 = min_t(unsigned int, common->max_vasz_lg2,
> +				     pt_num_items_lg2(&pts) +
> +					     pt_table_item_lg2sz(&pts));
> +
> +	/*
> +	 * The top range will default to the lower region only with sign extend.
> +	 */
> +	range.max_vasz_lg2 = max_vasz_lg2;
> +	if (pt_feature(common, PT_FEAT_SIGN_EXTEND))
> +		max_vasz_lg2--;
> +
> +	range.va = fvalog2_set_mod(pt_full_va_prefix(common), 0, max_vasz_lg2);
> +	range.last_va =
> +		fvalog2_set_mod_max(pt_full_va_prefix(common), max_vasz_lg2);
> +	return range;
> +}
> -- 
> 2.43.0
> 

