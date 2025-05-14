Return-Path: <linux-kselftest+bounces-32931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F3AB6770
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B083AC691
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A8814AD0D;
	Wed, 14 May 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u2fez/Mn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E3156F45;
	Wed, 14 May 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214654; cv=fail; b=qGAoBqHdjNcGtQybHvoitzju1q9kbr/yWqKPHEFBXgYPncZNwylXVtAUFz4YphoaOrUzDR1uRxBtcZXdu+d8dExzrDwWeQ5SwacVEKiZzpcEuJxKtqfxBsx7sdAxOGjIsu1HAeqOh6YzC2vt4BoPsGlWbg2Ug/k8VAhf9+V/CQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214654; c=relaxed/simple;
	bh=r8qCjqGK7UBWIEVW/ygwW947PP3Gz+pckem7sHnuOqg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2X7CSvMUeM8InO/GnOVU50bvXkE3x+RiRVDB1opzDoX6SX7CQqcwUJLE8Fu8tKPSY7fvfogCG2R4dCcFRt3vjByx/yWgUsQOnwKOxsRY8ydTJHTUnuN581eW2GGjckbRy1dWSXFiQaxak6/fruUeBcEbV79PpV1zqcLpnCoh7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u2fez/Mn; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3D2+DFidbYCgt7igl/u5NxzKRnlEx0LwuEPYw0WmJC56nPh8A3g3oORC/4rDXiZaWIt6QjszYxgK1smLUqjMdSdtiRubXoOM5/XIFZsDNlofZeKLgc5jzQBLAKsXThmx9+4Lhy4tfOW6Wc2q4ZAc5aiWrU3pD6w4lea3tFbHhZ/phD6YdEdqcGMPAVp9WL16v/FZL9AzfBFAFdxIkb9Dpz9IiZsxaKjwJx7E4yaU736AoHzNzJBrcXOd7vpwwtawNEVRjbtB/CZgM3gGnzVPyJB9Qv1EXDxDzrWEAXxreHOrInC964ZaczuCiaHTny7GLXQl6/ZNY0dQcYy2jk5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzqHf4w0uK1VjCpHR4KSwE2yYkhk+dmnpGCjNx8ggTM=;
 b=RfkGKqUWAybazZ/PaSegUcpHikwV92GfMvceYuCqvK0SWABeos5CAllWgza3nQRoilyAc49pF5SI9PlOsJbobtEKhFlyRPKFgJKZ9c+xgvAkBYe2222Zrmi/57dj+wPQwO2mzMwvpLws83g4Nlg0l9fs1bWKL5TgUu5rCPMqTHiyTqYEdpM+ITC1EQ3U9qxChRZjRBqGh69a+7wXR95jhA4lOMVmbQRDK+thlcJviC1BZ68tUbKhNTO3vL23e2hEcn9l7/KUnmo3Ytza7if1F0JBRy70OE9BAlAod3IQ5KQeM1rNDDn5GAzAT3JYFm+2qFjbCAluI3dqnHTzVpYBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzqHf4w0uK1VjCpHR4KSwE2yYkhk+dmnpGCjNx8ggTM=;
 b=u2fez/MnaUa537aQ27aWwKlPi6llSEnjexZPbS4vDXVuhV4U9TYYkRb9JLGXzkWFQIUzZgLDPw9ahdVFCelVV95t8km+oTxiZAXk+G81CsFfFUNQnmcMDOGgP7K1K0Y808miVhXtQvIBYtdOp7vbuUVqv1jzmDgcEHGOCiLV9Fs=
Received: from PH7P220CA0149.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::19)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 09:24:08 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::95) by PH7P220CA0149.outlook.office365.com
 (2603:10b6:510:327::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Wed,
 14 May 2025 09:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 09:24:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 04:24:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 04:24:07 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 14 May 2025 04:24:00 -0500
Date: Wed, 14 May 2025 09:23:49 +0000
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
Subject: Re: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <pntkuh63y26rygrkxegbzncvc3shtplucrnzkkz2dimpkfyn75@uekvyuz5kred>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 81913992-9910-4663-53f1-08dd92c9144f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owSStQRqWZN8xQvaYi7qtIWEptXJ2BDOKowZgLnFz8w5WmlTx47B027GAgWd?=
 =?us-ascii?Q?H2jHyyCurS7T1SNH7QEi7LJ4np2ZzCek1/UMDnoCaepMSwe97v7PjnZk+l3I?=
 =?us-ascii?Q?ArieQh+oGaOsiaSQeZ1Vpfga35mqpCO58mDRwhmRxGEmTS+z1boczly3ztN2?=
 =?us-ascii?Q?LlJNZBdaTbJ0atChtrdGEWGIr4gzRNikxYREMLMq3B6AOjPvMsyjIzOXGU25?=
 =?us-ascii?Q?wsQyZnodKVzUzCQOZRyW1CpsA5Ky1mboyMGXCuhRJikpvXY37KQSgAXtrCTH?=
 =?us-ascii?Q?VSeS1IoBGuP+BUFLf+Urk1flwBdh/qkymiUXKIlj41k8r4/UTu+EY8iZ3XTJ?=
 =?us-ascii?Q?iAr7jsLz9A9h1l32G47cV5LvATmAGewP0sumykwogJ8n7XruNpbptIc5lWiW?=
 =?us-ascii?Q?2uYmqVuy+azUihcFHzdPXKs0ckhxIjn/lzAXbTTUeJ+Z6KO6LWbkr7kf9wh4?=
 =?us-ascii?Q?9o9pmU35AxRm9ffFfkmuUiRd2D5JicLfOE8iISj0XE21hO4cQhfcbJSkk7PM?=
 =?us-ascii?Q?ogKJ7B/WS984sBGiVmiZK89BnEewUoB9WhLPyjoWsNAjyuTytOh+uyWieRyB?=
 =?us-ascii?Q?1FCByieIEs2nJg1awoowSSBGXK+YvKQxfrbwetuydp2qFh+ry1iQeDIzRISJ?=
 =?us-ascii?Q?H1ZCPa8FV194fnexmWHPG21Zfdtekvq0xOFyeaFb9ETngGVmEgvKG7enQO+I?=
 =?us-ascii?Q?KGpLqu1YDcDGC1IUIqP10hYzEGRLuNhLRalEvwrEQtNl6s0Hnal0U4gSrCQD?=
 =?us-ascii?Q?xmK08HScCrZJqyWyLCa2yDKSK4p0KnTw4/zXlwsyt0qCiNg+ChfTOSTRi73M?=
 =?us-ascii?Q?ZicuTXVciqbDsfqnJjskcK8g9jvpqkcyA4B9LfEBBXNFy1HUZTxpaxf7fdda?=
 =?us-ascii?Q?qo3e9oclO+GY80YUl+yeOMySPdQJUmf/HWZwT6qbSZtguAPVUmC0k2VYJCWc?=
 =?us-ascii?Q?YoUHnudIUAidCJPumr1iILZQRexQ+GEvM5sNP08lauYXpvcNrywOew+H/475?=
 =?us-ascii?Q?lkCE9d4QXHVlI0FVUd5QxcklCa8T9MhDI5hJGtfsUCgrtKAB2lgRJ6loZsRU?=
 =?us-ascii?Q?Bu8i/6xCX578lnaiVdh/1OT0ceXTs72+lz/Uko6C9EOKB5aleO/0L1E+Twka?=
 =?us-ascii?Q?5I4OR/f6mlJ2bzNRSFtDLWiaHFFWJ/H0MMwKbWC3Gttz7gkUX58kIsVRIAK6?=
 =?us-ascii?Q?delzTO02INb5PfikwBuqwHT4UnUQm1NcgbjQEAOq3bpumpdl5hqbF6NPRCPv?=
 =?us-ascii?Q?flN3NTehN33TcsCLjW2EXcNdpnLJa05JS9U8wHy7ypvhp4IF3oqX9N/DCBSS?=
 =?us-ascii?Q?/9pRcQAWE4p8aKQ45VwAwvgg3EwsgQEmkVEgUHB34Dil2lcxRKa+t03O1Xql?=
 =?us-ascii?Q?dCR/LaqxHPIZ9sd/HnSAsTyITpx0zDUvPBQybEzb5Rpt5TRMzpQxezWqZ8qJ?=
 =?us-ascii?Q?6hmog6uxQCyAvNXhFOLg6TCc2rDsdVZVH0qW09XIiqjfYA6/S+FshgNhaKBU?=
 =?us-ascii?Q?DDXBWxB/P+E1eOIBvdvxyE34AyI7NW4tpRhX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:24:08.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81913992-9910-4663-53f1-08dd92c9144f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

Hi Jason,

On Mon, May 05, 2025 at 11:18:33AM -0300, Jason Gunthorpe wrote:
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

I am experiencing a system hang with a 5-level v2 page table mode, on boot.
The NVMe boot drive is not initializing.
Below are the relevant dmesg logs with some prints i had added:

[    6.386439] AMD-Vi v2 domain init
[    6.390132] AMD-Vi v2 pt init
[    6.390133] AMD-Vi aperture end last va ffffffffffffff
...
[   10.315372] AMD-Vi gen pt MAP PAGES iova ffffffffffffe000 paddr 19351b000
...
[   72.171930] nvme nvme0: I/O tag 0 (0000) QID 0 timeout, disable controller
[   72.179618] nvme nvme1: I/O tag 24 (0018) QID 0 timeout, disable controller
[   72.197176] nvme nvme0: Identify Controller failed (-4)
[   72.203063] nvme nvme1: Identify Controller failed (-4)
[   72.209237] nvme 0000:05:00.0: probe with driver nvme failed with error -5
[   72.209336] nvme 0000:44:00.0: probe with driver nvme failed with error -5
...
Timed out waiting for the udev queue to be empty.

According to the dmesg logs above, the IOVA for the v2 page table appears 
incorrect and is not aligned with domain->geometry.aperture_end. Which
requires domain->geometry.force_aperture = true; to be added at the
appropriate location. Proabably here!

- Ankit

> +	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
> +		domain->geometry.aperture_end = ULONG_MAX;
> +		domain->pgsize_bitmap &= ULONG_MAX;
> +	}
> +
> +	return 0;
> +}
> +

