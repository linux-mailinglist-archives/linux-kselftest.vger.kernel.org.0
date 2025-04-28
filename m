Return-Path: <linux-kselftest+bounces-31795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93728A9F79C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A310B3BA09E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F92918FC;
	Mon, 28 Apr 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDYQPSfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026E1E1C3A;
	Mon, 28 Apr 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862139; cv=fail; b=FZpjtcLWWKARszWpTvuA3qknriWl4WE/xMuVsXGe4d9PxhalWRgbVUquTLO1vxoLGsquo6OgEWabfpI0VwpY8Go/ECa0INAJe0cQRPutydci6jRUEPvpl6LqJwsf7g6ytY+ZsbZfIh7YLvJsu9+BO2Dp5wTviBtqzVVjhDWGSPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862139; c=relaxed/simple;
	bh=/qhtoc3rMJ+Y8k6d4nZnl/nLCVOVhdPolpJ9uKkCF44=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRQ5Fyd6tztBsOjb55qIt+GIdtTEZhfswcbI7tPjx7zEDV+gz7S0Mo4iS0FSPC2/LbTUrOLz7DzwxTWynYJmgN7ZDj7emKYjjut9RXWMG6Ak+xtdjNfHiLq3JaEJ8FYW+Z8F1ZAdkr68+Hl4HBqg8VxY8vMSSdXhemF7kYA60H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDYQPSfZ; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfnYG85NTjUiLJXoA4OndaiJKHE3v2BLWsVxNAcXyN/MwjTmziZlQnNTgjxxAEFo84WmWSUsn4airoukpr01+0G/II9UD6EvvzniWMLe02J/l+UwkHz4Btofqj7zyLfxSOzG+asiCYzvpQq4KN7NDdGrXkAN0t7QmUTxlMTA0FHie6YfyoBOEnFbyO67o/07Az3WqCGS8uqdR9qOxEz+LjAnMJWjVEB4gScstTslRMi2W7NBfbob1hVNgQcbCV3gbbxMqrW2otu7jz2O4oQexPVxA2cPffQl6xTDmNYjTFmII9qdD2/1+auV2YvqoH4IdpoVnAb63Jc6s5pZMfSUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDwEp+ENOKgKIvko9czlqfydjWKBlL2U4wY/D4b8hVs=;
 b=IUuC18Sy9MTk7MdvQNt+/GwOaiYLYvVlPQvmeFTvF8qVPJtiAyzGWZxF3fB6vs+L4oP9WWFERrfWqYKOzhAgISpB1MVZMTLv5r8TqUKUvht7QOX1Z6KUYU/qnsrG4Bw5xhyAvqAtT5gjdp1GT0xFf3c9SugcFn/f/x0tFKNhUlYKwcAtFP0OLhSdxfdLt61ZbPkWZHi/BgQtl/FYcsyWo0W0g4sEFnN9AC+SbPoCv4i5z7wYC4po4gy3Jyrh4RypLyxOOqcvdQtNGD9ZRLEn1goECJXKIQdZ4J3hViGswjPQPT9vLgWULN73sxJAK/eqg08hEACvxdujDEb3JTD+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDwEp+ENOKgKIvko9czlqfydjWKBlL2U4wY/D4b8hVs=;
 b=fDYQPSfZhuxOrDpzMqdbEI+EoJANPlOTlv0RmDO491rUhkhKNjx6AJI3jyhEeQZsuM7z7sh3bVCp700raoTu87QamDzDPrAbZeHC9QCldP5OcgTAd27DqxznhpncjqihAanZdwqNyX9pRHMnQ/NtdUjEYXvhD03l+sxPxJJt1qSFD97H9cPN7OvtznoF0374CVvXhzCN12eA6piO5UU4sXBhBZfAuihZlR0SdJWKW/tPeBkWgMAUb4PwgZJSmlgE+HvQ0R2i9+LYCIvBnpAc10D1/w43i1mkXXUqrimUvEunLI5S5FTJSw48ypBTuThjoUd9IquQmWuWMk4YeXSUeg==
Received: from PH7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::19)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 17:42:10 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::8f) by PH7P222CA0025.outlook.office365.com
 (2603:10b6:510:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Mon,
 28 Apr 2025 17:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.2 via Frontend Transport; Mon, 28 Apr 2025 17:42:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 10:41:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 10:41:50 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 10:41:47 -0700
Date: Mon, 28 Apr 2025 10:41:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aA+92fNNbDI3Qowk@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: f6baf04d-40d2-40b1-7958-08dd867c0060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ayzFFx1RvndeLeN5zBNomAIjkcAc7t0sfwLqedwCTp2/O3B13Vnp9eXKoyi6?=
 =?us-ascii?Q?y6xYdB4N2zC08m4Q1+U/EVm1E76PJWRSwMc6DuEMATz5/odLL4Kf1s77Nxiv?=
 =?us-ascii?Q?H8aSsUG2sGRqb+kmAC0ZLuRgbfYZXkBYy6a+KZKwhz+mNoqS5icbBJ+NLlSb?=
 =?us-ascii?Q?jqWxu/nagHWq12wtYGW/lIzh++dfcD1xwo601lp2pR28Os57Q70rrQI1SbqM?=
 =?us-ascii?Q?aJzdpyJsEQK6v/LUAc48GDS7KqxRN+8ETSHYnqqAhn/lgSaKka6QfRRFHRGz?=
 =?us-ascii?Q?T0GNmG4frAh/+jjZ5FpUMqnuhi82J049xf5EZYfRA9lPt7MMBbO4aqosx0o3?=
 =?us-ascii?Q?E2w18P+NIBSN63PnyUaUkbwOPmJ/3JPTk3xGQP0ZiTewqCSpCcQ0XTyqNxeU?=
 =?us-ascii?Q?1RCyZrqW4OdIkCvqZ/0tqzL6iCHLbo0cQ1ahmiGrzojNNyGMqTeR2ULv0AYM?=
 =?us-ascii?Q?UfO78gdjP0ZZnd5RjjICset2OHqJKYkeK1j3zWeqcxsSn4/ewg6kKDWdZAJB?=
 =?us-ascii?Q?Gv8PvJdUN72a4Is59hDkAmi6B1pmErsRK4U8GPoE2VpZ6t7xXpHmHawT4ewA?=
 =?us-ascii?Q?X5ZzxmbDPszUmBk6ioI5heJjr1AnhNZDbQ8pdxpCFAeZ13GoHWQYS8PgGQqR?=
 =?us-ascii?Q?kJnHbtcu/vLVoIFKKIdbGSU3x5f8SAgsGVz6psf8hZ1QH8BzhGqmNMlDvNJR?=
 =?us-ascii?Q?hZSW7RBdX1Aobw1lAO3RGMi1MGlsWN7tE5eIA8WXdfXDI4g06UlohwwNtmxO?=
 =?us-ascii?Q?qfw3XmySCAsqC7S86JSaIsq2UoMSV8sWyLu8B4Toz1/uR2HUDVtRNMifQYdN?=
 =?us-ascii?Q?luZXLbL0Rx63kI+WD2peNxDBhb7/g2/kdVZUau7V5d09FUVVu3mBclzGtapw?=
 =?us-ascii?Q?eoPM8UHq78LNVjCrXk7IDuyZ/VYffynn4z34nikCCuDXiW08WCE+Z9zhSHWf?=
 =?us-ascii?Q?D8y1fs4WuRScnYByCQQNobnmo5NqMKj2NoFQ7aDl1bBqar9ZkiTEK3Kq8Goh?=
 =?us-ascii?Q?49VpII4wWYsschttkMnlQtiOi4R64aFbo4Fd0znvZSSZ06RUVY5fdPDgqFui?=
 =?us-ascii?Q?s/LMnnBx6cZ37gLNBQIyLq95DZOZ9FVOrX4kktsGTybBwhAYiZrd94vXVc0T?=
 =?us-ascii?Q?G3MfonaHXtxoMbcSYsyZ2lV/gXiOw4gn3m4momMAxk38RcI5uCuZ5BP2bEX7?=
 =?us-ascii?Q?nvapuaQ5sj6EdYiqiJXWiNV5y2ZmLjDsORp+ZjrP8ijVZGSub+ZNDluwYhsw?=
 =?us-ascii?Q?xksJey4tDCzD61tmSlGrFdHbNFxe7C28+1LbtUIuSATzMXajgWjram5+zLSn?=
 =?us-ascii?Q?p2fVBgg/8Nj8vaOf5ydZiEVEfEXHs/KBlT9CenurJO8+TdSjkEJuyh2YjoBn?=
 =?us-ascii?Q?4CbHV1fzUiOeH1GcJ5hg5JOUQSWUIGFedIqH9wSnP+u/zKQWBM1kMY7R6jRT?=
 =?us-ascii?Q?cEYqdTaB/4ae2jp2q+SDYlSI3e+2kEFOF9RIrSHtfoE4otIdkitHh0tB8/VB?=
 =?us-ascii?Q?NshTLxN73gr4T1BzKE2tbPC19P13rq2TPCsp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:42:09.5265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6baf04d-40d2-40b1-7958-08dd867c0060
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

On Sun, Apr 27, 2025 at 03:22:13PM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > The new vCMDQ object will be added for HW to access the guest memory for a
> > HW-accelerated virtualization feature. It needs to ensure the guest memory
> > pages are pinned when HW accesses them and they are contiguous in physical
> > address space.
> > 
> > This is very like the existing iommufd_access_pin_pages() that outputs the
> > pinned page list for the caller to test its contiguity.
> > 
> > Move those code from iommufd_access_pin/unpin_pages() and related function
> > for a pair of iopt helpers that can be shared with the vCMDQ allocator. As
> > the vCMDQ allocator will be a user-space triggered ioctl function, WARN_ON
> > would not be a good fit in the new iopt_unpin_pages(), thus change them to
> > use WARN_ON_ONCE instead.
> 
> I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
> alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
> with kernel call traces in the kernel messages, which might lead users
> to believe that something serious has happened in the kernel.

We already have similar practice, e.g. iommufd_hwpt_nested_alloc.

In my review, a WARN_ON/WARN_ON_ONCE means there is a kernel bug,
which shouldn't occur in the first place and isn't something that
user space should concern. In case that it is hit, a WARN_ON_ONCE
only spits one piece of traces that is enough for kernel folks to
identify what's wrong, while pr_warn_ratelimited would likely end
up with periodical warnings (more lines) that are neither related
to user space nor useful for kernel.

Thanks
Nicolin

