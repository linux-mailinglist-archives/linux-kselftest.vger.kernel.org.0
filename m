Return-Path: <linux-kselftest+bounces-41103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFBB50C60
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 05:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC01B465C8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165B266582;
	Wed, 10 Sep 2025 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9sMBVFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F055263892;
	Wed, 10 Sep 2025 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475679; cv=fail; b=dW90KsUdkqFDez8gc3EKuQLbbc71v/zkLWiBbiXKoXrB7wBEdqG5CCFEwioHPExQwkiDjgwwM8KYSLu+mqFTVlJQQ9ae7/q1WPviza25T51UyiQseMPdvRN0s7br/9ziHpZc5bVAQfFFWlVth6I+5XhHbde25NxYiLbD+at/di0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475679; c=relaxed/simple;
	bh=1uJdHbF/2p6WFaS/WRmXw/z/3nxH22R8M/oHMBKxIGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARCHfLONnwTjnI6YuI4VDLRHa2djrk8Gbs+atx3QkGBBnnkJIlpnG6kss6XmNvsZ+K9zAph6WtfwAFTP/LV+pkNuXzwO2gEP+kujW13olkQw27vAzpNkT2G9EeNvokX3hVOSNebX8qF/V/8xtLcLfdDIqrMVyY3m8Jk2mV5kiVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9sMBVFK; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkOvYG8gYpN9N+Tuw4HNfW7ew9P7M535+48squEttE61VAQCjRcEE1wkCWmYV5MpjnMEmYKIU7l/8kY+DkcvQmHWITEII5wWi5uMar8kQf4rR6+A94ItzZGk2wTD5mY1Mcr1t+OC15LlANZHXPxWl2lAnXRnVwzIuNd7W9yZssZboyuf+M2bq4UjOvKjk5IBnfLIMoQTYu7caTX2raFhnJq5B6VhLFDcriPkRVq7YOep8i9BhgsCnfwpdJhGXaIA0qOAIuyDoxWnyLL+cr5iabIAunM+eUkrHVc3rVaIEn0tMiVF7YOsajZSkdp55wwBE2CmVDRCpGGBl1qYuFJmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e57k7knQGO7/P4zdu53XlbuNfFwJnDaDKDBucIRLWMI=;
 b=gseUrK1PmoaaKki6H4ItZsC0x/f+UQAW+Ml6mmxm/1v0Tka+tVrOoR274/Az0CjGdfpF36f5ECcYud38s+P1edAm/AgJfuJCCagrzd4zagi2uI/HahT7GY6VAdvnJKTxhJ5c9/QHld2qGTEO8t6V5bpUMYqMG1el8YlyOR4ZrQOOBahIAOOBLb28gA9YY/IkAx4V2cbathCULsQqWWutxrXfLdrRbR/seq1x3CG6lV7Kg3y9/q9R0loxZ6MplvUv/1GZrNOmi/IhcKtN+CVF3O5gI3NF2V8gadBwFsKSuM199Jzik8sz22QgVrE9dKfYPuEtrl1DyjpxrxUKrY4QgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e57k7knQGO7/P4zdu53XlbuNfFwJnDaDKDBucIRLWMI=;
 b=i9sMBVFKbSRV1ZQVfOHKo2U5HdGq0g5OkRlLjjOSB4HEh/iixe8pJwceb7Da+0UhJPAsWm/IsbAtyLeHXeihM9FFuXexsAJLg0RP5jr3wlb17z9ov+PbTwWnlfh9cQ101wiQjFdJKzq02f81BZ1+2YgGqx9uV244jwfmdw/hJ8rKj9lRW3fhRD/J4XELN9KMlA0phG2a9wPR7cn2Lmfi7IsAK5dTS/csFpWa+9Ds3/oJLkdzyRCRAln+9rVRdIYlvPi7hRSg9lwt99R0r16VsHjK96Pp4vQEraglVSnkXGuHikKsMK7DFS3VO2qlNvMdqreNr5x/YHIxAraFkxQZZg==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 03:41:11 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c6) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 03:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 03:41:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 20:40:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 20:40:35 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 20:40:31 -0700
Date: Tue, 9 Sep 2025 20:40:28 -0700
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
Subject: Re: [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <aMDzLC9nV47Xvud9@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 3202ec10-8b0a-4bc0-d157-08ddf01be248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fh1lpHf7wTivpkTSMN5CWpCL2iivEBTtLYQOYWD2cw0IVz9aOjrLSAJsDDHC?=
 =?us-ascii?Q?HE7whtKHBThXnW3yXP1rONOuy9eHg5meZeGY0xwaFiXPlUVTax9BGR3ksHva?=
 =?us-ascii?Q?nuDJ1P2hDl0RRMZNwfnISGd3A5OEsQu8hJUG+axW+bwz/dRazFfx1FW9QNVh?=
 =?us-ascii?Q?KRl+47kC5lAi8eBc6U6tk6ykyd/U1EkjkxykssPTioC/qCuuLzLU7g9Prae+?=
 =?us-ascii?Q?37MtEJrKIBA3XdtW7TPnO8Qj1IOQc1xYBFuKYSXiYz4DQJC4ehzjE+ltYmYm?=
 =?us-ascii?Q?vtCR6HGSREMlPzNR1arMOC860jCEfZ4QIQSPed6D1eqI5YGaeu3Hq17BtjGw?=
 =?us-ascii?Q?nyUh9mhwWJNfi2xwBwteAftwSFz49GYWSeY4W98tKNYS/JSCJaiu3vKPAzqA?=
 =?us-ascii?Q?sVmYa5FRXuBcdi/GPP6iOTzXteqbRsTMry2eRUcFdw1Y7H8bRp66ul2iYdo5?=
 =?us-ascii?Q?aymZyLbSX7LlmGoEx8sTRnIFWCowg8PVBtxguVmYU1eQwsZdXTXo0A4pGdu7?=
 =?us-ascii?Q?2eb6J5PjJB0FQrasmRhWjcKRIvI6JwN7U1QPZOIdhbfjsySft5UXvnFveqYK?=
 =?us-ascii?Q?whobzAOdGdjw6WdZpF8eKtP8ZAiCihsGxoWSBoqdf/zGcMUvWTNFvgGfVKaH?=
 =?us-ascii?Q?m9N0Zt5BeShkZGG9q67zrPpoffUqO1mfDKnECK2tIgecQrFeR8hoZ2YLwz8r?=
 =?us-ascii?Q?IMa3MOT0+QemE9Zzy2D3kUxXGF+k8O0E3NqD2oDM+T509mcLF220Cstiy4AC?=
 =?us-ascii?Q?lHY4ECjZpukfF/khPs5gP2AwzDPw+y2BGBUcFkgZworoNELpAeoIRJ+bSlms?=
 =?us-ascii?Q?+D7fBN+KkNmchPHfi4Omassbqdm/DWjPYELykFIRPQwj9fMeLgClHTA3IxQ6?=
 =?us-ascii?Q?ngVqSfiEjq3CK2prbeFYgw5HfLjq9qPGWpOPpVPw1GiJAdxx2HYKtah8Qidw?=
 =?us-ascii?Q?mOC4Bf+nSComi+zUR7EGzsR/Qq/iMvjTnOc2HprilGwI1ZzcVS1SvJqxvUvu?=
 =?us-ascii?Q?t9SELNtfzT4S8U4YQUgXxI+oDzfGqGEasg4qJqoUjZGL3k7Xyt3pTrDZubUM?=
 =?us-ascii?Q?LIWJDJR/DetMOJXXrZPFrsC0fDpOzg8PJVjheHUXZNen/Ki3bjt1T2fq/fJl?=
 =?us-ascii?Q?8qnCAWZUUt94nDTs/lLgWmwDCVQsY6TMgTKUItWfspH8AWIPb4P1oL2izhGr?=
 =?us-ascii?Q?c+Gcarvw7EsPpbXR/f96SOoDQ5xxk0mklpteq2WLXeVOCZH3KwMrJmXbyTYQ?=
 =?us-ascii?Q?hx8MnUVxsrGO4XzMXdVdnV8Yd5dVZM8QhDLx0zA6K7+dChUaoD6Bikvfbi6r?=
 =?us-ascii?Q?ERZkI+VMFvs3yTvh1jFjAGq8KFQgmpQz5vjHCEtxUEZS9ZHdG5ePUTSkj6LS?=
 =?us-ascii?Q?31PwxeL8xZHrF3fmJeLI11IQuiyWAi+HnNV1JpmFVr2VjfW/eIV5uPP1G0nc?=
 =?us-ascii?Q?gDF+OTy1xbVi3Al6KNMtD3tFmMo/+3gT4ZGYnLi1uNqka3l6raosY6dutZHD?=
 =?us-ascii?Q?RrLqBClntOyT+iP9MIqwOMLlrntG27DmfH+Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 03:41:10.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3202ec10-8b0a-4bc0-d157-08ddf01be248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792

On Wed, Sep 03, 2025 at 02:46:28PM -0300, Jason Gunthorpe wrote:
> +/**
> + * pt_entry_oa_lg2sz() - Return the size of a OA entry

an OA

> + * @pts: Entry to query
> + *
> + * If the entry is not contiguous this returns pt_table_item_lg2sz(), otherwise
> + * it returns the total VA/OA size of the entire contiguous entry.
> + */
> +static inline unsigned int pt_entry_oa_lg2sz(const struct pt_state *pts)
> +{
> +	return pt_entry_num_contig_lg2(pts) + pt_table_item_lg2sz(pts);
> +}
------

> + *  level
> + *     The number of table hops from the lowest leaf. Level 0
> + *     is always a table of only leaves of the least significant VA bits. The

Hmm, I am a bit confused here. I thought "leaf" was meant to be a
"leaf" table? But here "a table of only leaves" makes it feel like
a "leaf" table entry?

Also, isn't "the least significant VA bits" the page offset?

> + *  table
> + *     A linear array of entries representing the translation items for that
> + *     level.
> + *  index
> + *     The position in a table of an element: item = table[index]
> + *  item
> + *     A single position in a table
> + *  entry
> + *     A single logical element in a table. If contiguous pages are not
> + *     supported then item and entry are the same thing, otherwise entry refers
> + *     to the all the items that comprise a single contiguous translation.

So, an "entry" is a group of "items" if contiguous pages (huge
page?) are supported. Then, the "entry" sounds like a physical
(v.s. "logical") table entry, e.g. a PTE that we usually say?

> +#if !IS_ENABLED(CONFIG_GENERIC_ATOMIC64)
> +static inline bool pt_table_install64(struct pt_state *pts, u64 table_entry)
> +{
> +	u64 *entryp = pt_cur_table(pts, u64) + pts->index;
> +	u64 old_entry = pts->entry;
> +	bool ret;
> +
> +	/*
> +	 * Ensure the zero'd table content itself is visible before its PTE can
> +	 * be. release is a NOP on !SMP, but the HW is still doing an acquire.
> +	 */
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		dma_wmb();

Mind elaborating why SMP doesn't need this?

> +/*
> + * PT_WARN_ON is used for invariants that the kunit should be checking can't
> + * happen.
> + */
> +#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
> +#define PT_WARN_ON WARN_ON
> +#else
> +static inline bool PT_WARN_ON(bool condition)
> +{
> +	return false;

Should it "return condition"?

Otherwise, these validations wouldn't be effective?

drivers/iommu/generic_pt/pt_iter.h:388: if (PT_WARN_ON(!pts->table_lower))
drivers/iommu/generic_pt/pt_iter.h-389-         return -EINVAL;
--
drivers/iommu/generic_pt/pt_iter.h-429-
drivers/iommu/generic_pt/pt_iter.h:430: if (PT_WARN_ON(!pt_can_have_table(pts)) ||
drivers/iommu/generic_pt/pt_iter.h:431:     PT_WARN_ON(!pts->table_lower))
drivers/iommu/generic_pt/pt_iter.h-432-         return -EINVAL;

> +/**
> + * pt_load_entry() - Read from the location pts points at into the pts
> + * @pts: Table index to load
> + *
> + * Set the type of entry that was loaded. pts->entry and pts->table_lower
> + * will be filled in with the entry's content.
> + */
> +static inline void pt_load_entry(struct pt_state *pts)
> +{
> +	pts->type = pt_load_entry_raw(pts);
> +	if (pts->type == PT_ENTRY_TABLE)
> +		pts->table_lower = pt_table_ptr(pts);
> +}

I see a couple of callers check pts->type. Maybe it could return
pts->type, matching with pt_load_entry_raw()?

> diff --git a/drivers/iommu/generic_pt/pt_fmt_defaults.h b/drivers/iommu/generic_pt/pt_fmt_defaults.h
> new file mode 100644
> index 00000000000000..19e8f820c1dccf
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_fmt_defaults.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * Default definitions for formats that don't define these functions.
> + */
> +#ifndef __GENERIC_PT_PT_FMT_DEFAULTS_H
> +#define __GENERIC_PT_PT_FMT_DEFAULTS_H
> +
> +#include "pt_defs.h"
> +#include <linux/log2.h>

<> precedes ""

> +#ifndef pt_pgsz_lg2_to_level
> +static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common,
> +						unsigned int pgsize_lg2)
> +{
> +	return (pgsize_lg2 - PT_GRANULE_LG2SZ) /
> +	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE));
> +	return 0;

"return 0" should likely be dropped.

> +/*
> + * Format supplies either:
> + *   pt_entry_oa - OA is at the start of a contiguous entry
> + * or
> + *   pt_item_oa  - OA is correct for every item in a contiguous entry

What does the "correct" mean here?

> +/**
> + * pt_range_to_end_index() - Ending index iteration
> + * @pts: Iteration State
> + *
> + * Return: the last index for the iteration in pts.
> + */
> +static inline unsigned int pt_range_to_end_index(const struct pt_state *pts)
> +{
> +	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
> +	struct pt_range *range = pts->range;
> +	unsigned int num_entries_lg2;
> +
> +	if (range->va == range->last_va)
> +		return pts->index + 1;
> +
> +	if (pts->range->top_level == pts->level)
> +		return log2_div(fvalog2_mod(pts->range->last_va,
> +					    pts->range->max_vasz_lg2),
> +				isz_lg2) +
> +		       1;

How about:
		return 1 + log2_div(...);
?

> +static __always_inline struct pt_range _pt_top_range(struct pt_common *common,
> +						     uintptr_t top_of_table)
> +{
> +	struct pt_range range = {
> +		.common = common,
> +		.top_table =
> +			(struct pt_table_p *)(top_of_table &
> +					      ~(uintptr_t)PT_TOP_LEVEL_MASK),
> +		.top_level = top_of_table % (1 << PT_TOP_LEVEL_BITS),

Since top_level is unsigned, would it be faster to do bitwise:
		.top_level = top_of_table & PT_TOP_LEVEL_MASK,
?

> +/*

/**

> + * pt_walk_descend_all() - Recursively invoke the walker for a table item
> + * @parent_pts: Iteration State
> + * @fn: Walker function to call
> + * @arg: Value to pass to the function
> + *
> + * With pts pointing at a table item this will descend and over the entire lower
> + * table. This creates a new walk and does not alter pts or pts->range.
> + */
> +static __always_inline int
> +pt_walk_descend_all(const struct pt_state *parent_pts, pt_level_fn_t fn,
> +		    void *arg)
-------

> +/**
> + * pt_compute_best_pgsize() - Determine the best page size for leaf entries
> + * @pgsz_bitmap: Permitted page sizes
> + * @va: Starting virtual address for the leaf entry
> + * @last_va: Last virtual address for the leaf entry, sets the max page size
> + * @oa: Starting output address for the leaf entry
> + *
> + * Compute the largest page size for va, last_va, and oa together and return it
> + * in lg2. The largest page size depends on the format's supported page sizes at
> + * this level, and the relative alignment of the VA and OA addresses. 0 means
> + * the OA cannot be stored with the provided pgsz_bitmap.
> + */
> +static inline unsigned int pt_compute_best_pgsize(pt_vaddr_t pgsz_bitmap,
> +						  pt_vaddr_t va,
> +						  pt_vaddr_t last_va,
> +						  pt_oaddr_t oa)
> +{
> +	unsigned int best_pgsz_lg2;
> +	unsigned int pgsz_lg2;
> +	pt_vaddr_t len = last_va - va + 1;
> +	pt_vaddr_t mask;
> +
> +	if (PT_WARN_ON(va >= last_va))
> +		return 0;
> +
> +	/*
> +	 * Given a VA/OA pair the best page size is the largest page side
> +	 * where:
> +	 *
> +	 * 1) VA and OA start at the page. Bitwise this is the count of least
> +	 *    significant 0 bits.
> +	 *    This also implies that last_va/oa has the same prefix as va/oa.
> +	 */
> +	mask = va | oa;
> +
> +	/*
> +	 * 2) The page size is not larger than the last_va (length). Since page
> +	 *    sizes are always power of two this can't be larger than the
> +	 *    largest power of two factor of the length.
> +	 */
> +	mask |= log2_to_int(log2_fls(len) - 1);
> +
> +	best_pgsz_lg2 = log2_ffs(mask);
> +
> +	/* Choose the higest bit <= best_pgsz_lg2 */

highest

> +/* Compute a */
> +#define log2_to_int_t(type, a_lg2) ((type)(((type)1) << (a_lg2)))
> +static_assert(log2_to_int_t(unsigned int, 0) == 1);
> +
> +/* Compute a - 1 (aka all low bits set) */
> +#define log2_to_max_int_t(type, a_lg2) ((type)(log2_to_int_t(type, a_lg2) - 1))
> +
> +/* Compute a / b */
> +#define log2_div_t(type, a, b_lg2) ((type)(((type)a) >> (b_lg2)))
> +static_assert(log2_div_t(unsigned int, 4, 2) == 1);

I skimmed through these macros and its callers. They are mostly
dealing with VA, OA, and mask, which feels like straightforward
bit-masking/shifting operations.

E.g.
log2_to_int_t = 64bit ? BIT_ULL(lg2) : BIT(lg2);
log2_to_max_int_t = 64bit ? GENMASK_ULL(lg2 - 1, 0) : GENMASK(lg2 - 1, 0);

What's the benefit from making them as arithmetic ones?

> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
> new file mode 100644
> index 00000000000000..a29bdd7b244de6
> --- /dev/null
> +++ b/include/linux/generic_pt/common.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __GENERIC_PT_COMMON_H
> +#define __GENERIC_PT_COMMON_H
> +
> +#include <linux/types.h>
> +#include <linux/build_bug.h>
> +#include <linux/bits.h>

In alphabetical order.

Thanks
Nicolin

