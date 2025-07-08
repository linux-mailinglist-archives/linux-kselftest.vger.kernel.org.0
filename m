Return-Path: <linux-kselftest+bounces-36744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129BAFC2D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 08:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E1F1AA75D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 06:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666922370C;
	Tue,  8 Jul 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xESwL0x/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622D2222AC;
	Tue,  8 Jul 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956615; cv=fail; b=uMcB6T/F5uSPvUtzryZGe7sTRVllkfNRH/5kRzCH8HDEJ0/40K6+Jf/8hpnbOyxSikXC5J+xZElfYpOYw63uWX2WKTZcnBffsupIdMpAHTwPKrQXukQff2C91O7zEU3e13ec3q20F/QGN7Q0FyoRgQ4ZZlOUi6Z3fxr2JQ/GHew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956615; c=relaxed/simple;
	bh=DvsJixA1p8vYcsvK/Qt1sEfwXrYpc00C4PDnc9am++k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoBcmOVE/ySltSnTmkL7HPhXMz4MulD3Ve87jc+U/dI/JV1YM1jdPANVWmv8jpl9TdRww1IYoDSGeaZBVJsJou45AyYrBfDYqngYkVJacQOleWLHA/gd9ijv6tPFj8fOhd9ciEZ3IrNJJxpKDlFmZW/TIFG8vABDVqzlFk0WYmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xESwL0x/; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOYTnTaCx3ZPnH0K3nZfgoP3sEOB+HuumBockQwOzBy48S2e2k8bk30X2sFBTt9NFpyaAW3KVbkfALFrQ8OlyPTK8AFnvlPD1+tq1cXNm8ciiEa8+q26NXqFXlMq6em5dCuGie4VDgsma44tpjFEvHQXqrdVnAcUl3LdwuT4KNTD9exmZ1/Bf8fedRKNkXeBWyNjoi0izOoEZJ0S/xtasXx8AorYHlmBTqkPKy2I7tdc0giHo8Iz9ulJIiJHjf4iUWMemrO0GkQpB/7Puma35mwcrXJl/Q1lNdM2YwKjgKZdOsY9RIQyXKHG40Er2pA3SACbeJDqIEhtaqPM+Ye/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuqdQnfFsayJwbQMpSujw9yDVuSWtnJJefovVqVShKA=;
 b=wO9KrZZH6PqxJlg+z1Qo5sApxbbVmqc3D28eBv2vdbi1FyY7fZqy1EuKj1zbHsDBHEca+kilaayB+M7+Dsz/9OAkrT286EiMlDFEsyr2f4sqImh5IEHP3OYmV9jU7PwIyRovyJhQs199yI3jDMgxPgL8+/wyAqCccFPJMs/4Fs6iONHDOqMV/CTK3N/RKfyMouXohvnLlVeRkQYQ7GNhIknBD66VRlhB9kCWUtGxUuaS2lSpK3sgsuV839fkRBuG/n2P3ceH5CEVpsCfBmT2CBOaEgY5XhK/LbVMh9MKve0DsL1tHFRpNo4On6mjFhc+D1E3JmiXjxQf7WLY+cwEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuqdQnfFsayJwbQMpSujw9yDVuSWtnJJefovVqVShKA=;
 b=xESwL0x/3NLpWOK4QL/KjNzL02DGuTzGk2FilGDhNztqMAtfvjVD9bZc/UGfF0AHLvTveVs9SHJG5A78K9FwARgVgZ4CeYQMrY6gsVgmg/FylOC6be1HFzF2pAgmk55bwtmbzp7IUJHa3UUTqFGJerN9gyZceaHo3mksDhorPK8=
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 06:36:48 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::28) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 06:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 06:36:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 01:36:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 01:36:47 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 01:36:41 -0500
Date: Tue, 8 Jul 2025 06:36:35 +0000
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
Subject: Re: [PATCH v3 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <i7qlz7ojhs2ja5qnj6gnf6wgsyhcqznprfudlk3tphw6qyhguk@ak4wo7b6rujt>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <3-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Received-SPF: None (SATLEXMB05.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e43f32-01b8-4144-d730-08ddbde9d0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?io6hX+/VRzc/r+/IMD9KTfftdhZgSynKMpKf/tj+gMntoTqHaqseB11J2HPn?=
 =?us-ascii?Q?PDYPIQosIorL1BCj31+6rISSgSSTXa9Vk+qS7t43t8mZ/2aDLpWCsK/e8oHq?=
 =?us-ascii?Q?9WGwuAFJoOr2PNjfsTtltHmokRnKRIjV+sfvBuVoDRar8Ed5dPnmLMFnwDA7?=
 =?us-ascii?Q?EoiOZBu4kfUdXEbnAqdbBEjiHntAt0suDetlaZ0ccrRfrZclGiwb1Ads4kGD?=
 =?us-ascii?Q?E02+iQfFJdP/oUXA+VOSpu8krk6XJJn+ZK1oUPEuLQotIHkBUARgWc+y1og9?=
 =?us-ascii?Q?5l4LPo3nJ0b2piWgefnQqV4Eu0xmUMUXgjUr7L3RNliTMVrRnwhE/JSdVHQV?=
 =?us-ascii?Q?B8tDPZh9u9iE2TVc+NRAvfLvTRz4UfA5oiH099gSWsWyH+x10Eoh89ewc2Fh?=
 =?us-ascii?Q?WN6t9avfyVA5OLKs7vSgLownKNEODoVqzn7fdg9odU10mmkzzd5A878a0krl?=
 =?us-ascii?Q?4D/sv4pshAOtKUjnPMuKf2g4RzAQLXf5BpLKvxJi/6XfX3kJP6EPk2XzwMPx?=
 =?us-ascii?Q?lv4WQy6nxaZpM7v30TjGCgt61lFluVwBXh2GgzYumdRPezuNBROWoFT3p56f?=
 =?us-ascii?Q?yoZEaV5bBnxEKAP5iMV4JZBLWIUh8By2fxf8MKFWHJtE/Wk5IvqGSo1JvYnp?=
 =?us-ascii?Q?1+Im43hVOMuMS8WidOuWRJNtZ1/Xm2PxdFjum43OJGXWOpcvC8822s02Zjpk?=
 =?us-ascii?Q?qLsuWNWsCH2szpqd7ESnN+esFnW/YmEP9GH8mC8JhUX4WHvx3wxH0Q5Iauhu?=
 =?us-ascii?Q?dpTjt402H4DWol1Ezc23AkxcwNiVrbrcSZ/Q2WAEDB9VUPEH/K+bE6uUxob/?=
 =?us-ascii?Q?IUBQt01OX1HRuRwa6HVD1axf+KyzgutdwhC5Saq/uJdmsPFDuAkon/27uWxN?=
 =?us-ascii?Q?3tXLuD40tveb3PRwc6hCDKZBzahjZ4aQwCo/FstUz5nfOhVDI5SFivDnTWZB?=
 =?us-ascii?Q?j9jWV6SjT+gYWcULchcd3g4EYDJDnnmjIHTuogCnF+tQQQKF2+QiMnsizqV9?=
 =?us-ascii?Q?m3XcKHImseEg/HvnXO/19M04b89u9F4PPqdNbW8LuAwbyK6fk66LsL9rZjwr?=
 =?us-ascii?Q?xSEd8wwpdTApfdLQCF8IqnMukQvyvskQ4ehq5lhzc/Rt/VPo2R8ql9XX2Bhm?=
 =?us-ascii?Q?ZMvu+zs2sTxraINKhBzAbNFNZrNXvAIRDmho3McZ45faN3mAcnfiYiu41Eph?=
 =?us-ascii?Q?y8Ho+olFWkIW26slG6VTY1n1fgyUpKW2/BA+Fg1Y70seZWepR3p3PYl/IowH?=
 =?us-ascii?Q?Sc0NV1myINUNdIbH880TSarn+zowH5BAKBQzTN7eaP0j5zAKfVsQxhBbJusu?=
 =?us-ascii?Q?13Jx6ngSvqc+fFpM3nXvqhxZLBP49xLtqBx1wLv2Ecuk2XF3IjYihmrZDocH?=
 =?us-ascii?Q?baHYfi9VhQNc3vjq3JuCJfVIOXTnONeCIdqErXQOyZZAuapTTNT649VFHuVF?=
 =?us-ascii?Q?VTYnIrJPRdzamRc8RW1kVjRLmlhOZS7nz8fnV3LxUp7HM0ghy96Z7zF0I0XT?=
 =?us-ascii?Q?I1ixbkpbLxqC0JUR7eV2RcdMkOkezsdt8/Pk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 06:36:48.3304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e43f32-01b8-4144-d730-08ddbde9d0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531

On Mon, Jun 16, 2025 at 03:06:06PM -0300, Jason Gunthorpe wrote:
> The existing IOMMU page table implementations duplicate all of the working
> algorithms for each format. By using the generic page table API a single C
> version of the IOMMU algorithms can be created and re-used for all of the
> different formats used in the drivers. The implementation will provide a
> single C version of the iommu domain operations: iova_to_phys, map, unmap,
> and read_and_clear_dirty.
> 
> Further, adding new algorithms and techniques becomes easy to do across
> the entire fleet of drivers and formats.
> 
> The C functions are drop in compatible with the existing iommu_domain_ops
> using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
> compilation unit will produce exported symbols following the pattern
> pt_iommu_FMT_map_pages() which the macro directly maps to the
> iommu_domain_ops members. This avoids the additional function pointer
> indirection like io-pgtable has.
> 
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
>        } amdpt;
>    };
> 
> The driver is expected to union the pt_iommu_table_FMT with it's own
> existing domain struct:
> 
>    struct driver_domain {
>        union {
> 	       struct iommu_domain domain;
> 	       struct pt_iommu_table_amdv1 amdv1;
>        };
>    };
>    PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);
> 
> To create an alias to avoid renaming 'domain' in a lot of driver code.
> 
> This allows all the layers to access all the necessary functions to
> implement their different roles with no change to any of the existing
> iommu core code.
> 
> Implement the basic starting point: pt_iommu_init(), get_info() and
> deinit().
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Tested patch series with multiple command line configurations for amd
iommu on zen5 machine with 12 NVMe devices.

Suggested-by: Ankit Soni <Ankit.Soni@amd.com>
Tested-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/generic_pt/Kconfig              |  13 +
>  drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
>  drivers/iommu/generic_pt/iommu_pt.h           | 268 ++++++++++++++++++
>  include/linux/generic_pt/iommu.h              | 118 ++++++++
>  4 files changed, 438 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
>  create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
>  create mode 100644 include/linux/generic_pt/iommu.h
> 
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> index 775a3afb563f72..73b7a54375f9bd 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -19,4 +19,17 @@ config DEBUG_GENERIC_PT
>  	  kernels.
>  
>  	  The kunit tests require this to be enabled to get full coverage.
> +
> +config IOMMU_PT
> +	tristate "IOMMU Page Tables"
> +	select IOMMU_API
> +	depends on IOMMU_SUPPORT
> +	depends on GENERIC_PT
> +	default n
> +	help
> +	  Generic library for building IOMMU page tables
> +
> +	  IOMMU_PT provides an implementation of the page table operations
> +	  related struct iommu_domain using GENERIC_PT to abstract the page
> +	  table format.
>  endif
> diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
> new file mode 100644
> index 00000000000000..5b631bc07cbc16
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * Template to build the iommu module and kunit from the format and
> + * implementation headers.
> + *
> + * The format should have:
> + *  #define PT_FMT <name>
> + *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
> + * And optionally:
> + *  #define PT_FORCE_ENABLED_FEATURES ..
> + *  #define PT_FMT_VARIANT <suffix>
> + */
> +#include <linux/args.h>
> +#include <linux/stringify.h>
> +
> +#ifdef PT_FMT_VARIANT
> +#define PTPFX_RAW \
> +	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
> +#else
> +#define PTPFX_RAW PT_FMT
> +#endif
> +
> +#define PTPFX CONCATENATE(PTPFX_RAW, _)
> +
> +#define _PT_FMT_H PT_FMT.h
> +#define PT_FMT_H __stringify(_PT_FMT_H)
> +
> +#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
> +#define PT_DEFS_H __stringify(_PT_DEFS_H)
> +
> +#include <linux/generic_pt/common.h>
> +#include PT_DEFS_H
> +#include "../pt_defs.h"
> +#include PT_FMT_H
> +#include "../pt_common.h"
> +
> +#include "../iommu_pt.h"
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> new file mode 100644
> index 00000000000000..205c232bda68b5
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -0,0 +1,268 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * "Templated C code" for implementing the iommu operations for page tables.
> + * This is compiled multiple times, over all the page table formats to pick up
> + * the per-format definitions.
> + */
> +#ifndef __GENERIC_PT_IOMMU_PT_H
> +#define __GENERIC_PT_IOMMU_PT_H
> +
> +#include "pt_iter.h"
> +
> +#include <linux/iommu.h>
> +#include "../iommu-pages.h"
> +#include <linux/export.h>
> +
> +#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
> +
> +struct pt_iommu_collect_args {
> +	struct iommu_pages_list free_list;
> +	u8 ignore_mapped : 1;
> +};
> +
> +static int __collect_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	struct pt_iommu_collect_args *collect = arg;
> +	int ret;
> +
> +	if (collect->ignore_mapped && !pt_can_have_table(&pts))
> +		return 0;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			iommu_pages_list_add(&collect->free_list, pts.table_lower);
> +			ret = pt_descend(&pts, arg, __collect_tables);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +		if (pts.type == PT_ENTRY_OA && !collect->ignore_mapped)
> +			return -EADDRINUSE;
> +	}
> +	return 0;
> +}
> +
> +static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
> +						 uintptr_t top_of_table,
> +						 gfp_t gfp)
> +{
> +	struct pt_iommu *iommu_table = iommu_from_common(common);
> +
> +	/*
> +	 * Top doesn't need the free list or otherwise, so it technically
> +	 * doesn't need to use iommu pages. Use the API anyhow as the top is
> +	 * usually not smaller than PAGE_SIZE to keep things simple.
> +	 */
> +	return iommu_alloc_pages_node_sz(
> +		iommu_table->nid, gfp,
> +		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
> +}
> +
> +static void NS(get_info)(struct pt_iommu *iommu_table,
> +			 struct pt_iommu_info *info)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_top_range(common);
> +	struct pt_state pts = pt_init_top(&range);
> +	pt_vaddr_t pgsize_bitmap = 0;
> +
> +	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
> +		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
> +		     pts.level++) {
> +			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
> +				break;
> +			pgsize_bitmap |= pt_possible_sizes(&pts);
> +		}
> +	} else {
> +		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
> +			pgsize_bitmap |= pt_possible_sizes(&pts);
> +	}
> +
> +	/* Hide page sizes larger than the maximum OA */
> +	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
> +}
> +
> +static void NS(deinit)(struct pt_iommu *iommu_table)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +		.ignore_mapped = true,
> +	};
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	/*
> +	 * The driver has to already have fenced the HW access to the page table
> +	 * and invalidated any caching referring to this memory.
> +	 */
> +	iommu_put_pages_list(&collect.free_list);
> +}
> +
> +static const struct pt_iommu_ops NS(ops) = {
> +	.get_info = NS(get_info),
> +	.deinit = NS(deinit),
> +};
> +
> +static int pt_init_common(struct pt_common *common)
> +{
> +	struct pt_range top_range = pt_top_range(common);
> +
> +	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
> +		return -EINVAL;
> +
> +	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
> +	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
> +		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
> +
> +	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
> +		common->features |= BIT(PT_FEAT_FULL_VA);
> +
> +	/* Requested features must match features compiled into this format */
> +	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
> +	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
> +	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
> +		     PT_FORCE_ENABLED_FEATURES))
> +		return -EOPNOTSUPP;
> +
> +	if (common->max_oasz_lg2 == 0)
> +		common->max_oasz_lg2 = pt_max_output_address_lg2(common);
> +	else
> +		common->max_oasz_lg2 = min(common->max_oasz_lg2,
> +					   pt_max_output_address_lg2(common));
> +	return 0;
> +}
> +
> +static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
> +				struct iommu_domain *domain)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_iommu_info info;
> +	struct pt_range range;
> +
> +	NS(get_info)(iommu_table, &info);
> +
> +	domain->type = __IOMMU_DOMAIN_PAGING;
> +	domain->pgsize_bitmap = info.pgsize_bitmap;
> +
> +	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
> +		range = _pt_top_range(common,
> +				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
> +	else
> +		range = pt_top_range(common);
> +
> +	/*
> +	 * A 64 bit high address space table on a 32 bit system cannot work.
> +	 */
> +	domain->geometry.aperture_start = (unsigned long)range.va;
> +	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va ||
> +	    range.va > ULONG_MAX)
> +		return -EOVERFLOW;
> +
> +	/*
> +	 * The aperture is limited to what the API can do after considering all
> +	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
> +	 * to store a VA. Set the aperture to something that is valid for all
> +	 * cases. Saturate instead of truncate the end if the types are smaller
> +	 * than the top range. aperture_end is a last.
> +	 */
> +	domain->geometry.aperture_end = (unsigned long)range.last_va;
> +	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
> +		domain->geometry.aperture_end = ULONG_MAX;
> +		domain->pgsize_bitmap &= ULONG_MAX;
> +	}
> +	domain->geometry.force_aperture = true;
> +
> +	return 0;
> +}
> +
> +static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
> +{
> +	struct pt_iommu *iommu_table = &fmt_table->iommu;
> +	struct pt_iommu cfg = *iommu_table;
> +
> +	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
> +	memset_after(fmt_table, 0, iommu.domain);
> +
> +	/* The caller can initialize some of these values */
> +	iommu_table->nid = cfg.nid;
> +}
> +
> +#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
> +#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
> +int pt_iommu_init(struct pt_iommu_table *fmt_table,
> +		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
> +{
> +	struct pt_iommu *iommu_table = &fmt_table->iommu;
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_table_p *table_mem;
> +	int ret;
> +
> +	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
> +	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
> +		return -EINVAL;
> +
> +	pt_iommu_zero(fmt_table);
> +	common->features = cfg->common.features;
> +	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
> +	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
> +#ifdef PT_FIXED_TOP_LEVEL
> +	pt_top_set_level(common, PT_FIXED_TOP_LEVEL);
> +#endif
> +	ret = pt_iommu_fmt_init(fmt_table, cfg);
> +	if (ret)
> +		return ret;
> +
> +	if (cfg->common.hw_max_oasz_lg2 > pt_max_output_address_lg2(common))
> +		return -EINVAL;
> +
> +	ret = pt_init_common(common);
> +	if (ret)
> +		return ret;
> +
> +	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
> +	    (pt_feature(common, PT_FEAT_FULL_VA) ||
> +	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
> +		return -EINVAL;
> +
> +	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
> +	if (ret)
> +		return ret;
> +
> +	table_mem = table_alloc_top(common, common->top_of_table, gfp);
> +	if (IS_ERR(table_mem))
> +		return PTR_ERR(table_mem);
> +	pt_top_set(common, table_mem, pt_top_get_level(common));
> +
> +	/* Must be last, see pt_iommu_deinit() */
> +	iommu_table->ops = &NS(ops);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
> +
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
> +MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));
> +MODULE_IMPORT_NS("GENERIC_PT");
> +
> +#endif
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> new file mode 100644
> index 00000000000000..9d2152bc64c0d6
> --- /dev/null
> +++ b/include/linux/generic_pt/iommu.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __GENERIC_PT_IOMMU_H
> +#define __GENERIC_PT_IOMMU_H
> +
> +#include <linux/generic_pt/common.h>
> +#include <linux/iommu.h>
> +#include <linux/mm_types.h>
> +
> +struct pt_iommu_ops;
> +
> +/**
> + * DOC: IOMMU Radix Page Table
> + *
> + * The iommu implementation of the Generic Page Table provides an ops struct
> + * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
> + * the generic map/unmap interface.
> + *
> + * This interface uses a caller provided locking approach. The caller must have
> + * a VA range lock concept that prevents concurrent threads from calling ops on
> + * the same VA. Generally the range lock must be at least as large as a single
> + * map call.
> + */
> +
> +/**
> + * struct pt_iommu - Base structure for iommu page tables
> + *
> + * The format specific struct will include this as the first member.
> + */
> +struct pt_iommu {
> +	/**
> +	 * @domain - The core iommu domain. The driver should use a union to
> +	 * overlay this memory with its previously existing domain struct to
> +	 * create an alias.
> +	 */
> +	struct iommu_domain domain;
> +
> +	/**
> +	 * @ops - Function pointers to access the API
> +	 */
> +	const struct pt_iommu_ops *ops;
> +
> +	/**
> +	 * @nid - Node ID to use for table memory allocations. The iommu driver
> +	 * may want to set the NID to the device's NID, if there are multiple
> +	 * table walkers.
> +	 */
> +	int nid;
> +};
> +
> +/**
> + * struct pt_iommu_info - Details about the iommu page table
> + *
> + * Returned from pt_iommu_ops->get_info()
> + */
> +struct pt_iommu_info {
> +	/**
> +	 * @pgsize_bitmap - A bitmask where each set bit indicates
> +	 * a page size that can be natively stored in the page table.
> +	 */
> +	u64 pgsize_bitmap;
> +};
> +
> +struct pt_iommu_ops {
> +	/**
> +	 * get_info() - Return the pt_iommu_info structure
> +	 * @iommu_table: Table to query
> +	 *
> +	 * Return some basic static information about the page table.
> +	 */
> +	void (*get_info)(struct pt_iommu *iommu_table,
> +			 struct pt_iommu_info *info);
> +
> +	/**
> +	 * deinit() - Undo a format specific init operation
> +	 * @iommu_table: Table to destroy
> +	 *
> +	 * Release all of the memory. The caller must have already removed the
> +	 * table from all HW access and all caches.
> +	 */
> +	void (*deinit)(struct pt_iommu *iommu_table);
> +};
> +
> +static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
> +{
> +	/*
> +	 * It is safe to call pt_iommu_deinit() before an init, or if init
> +	 * fails. The ops pointer will only become non-NUL if deinit needs to be
> +	 * run.
> +	 */
> +	if (iommu_table->ops)
> +		iommu_table->ops->deinit(iommu_table);
> +}
> +
> +/**
> + * struct pt_iommu_cfg - Common configuration values for all formats
> + */
> +struct pt_iommu_cfg {
> +	/**
> +	 * @features - Features required. Only these features will be turned on.
> +	 * The feature list should reflect what the IOMMU HW is capable of.
> +	 */
> +	unsigned int features;
> +	/**
> +	 * @hw_max_vasz_lg2 - Maximum VA the IOMMU HW can support. This will
> +	 * imply the top level of the table.
> +	 */
> +	u8 hw_max_vasz_lg2;
> +	/**
> +	 * @hw_max_oasz_lg2 - Maximum OA the IOMMU HW can support. The format
> +	 * might select a lower maximum OA.
> +	 */
> +	u8 hw_max_oasz_lg2;
> +};
> +
> +#endif
> -- 
> 2.43.0
> 

