Return-Path: <linux-kselftest+bounces-32529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D057AACE72
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 21:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B45B4A09E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BEA20E306;
	Tue,  6 May 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oF4Nauc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B720E007;
	Tue,  6 May 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561334; cv=fail; b=c8mqsiEJztQdIx1h1PjGfozXzEeBpXzduieDbsIAWBh4Dt4hM33wlznhCzWjwcHzhiMXwHjee0kakq8WbuDy696CJZViycX0A1zLcaG9d9ImbQaeyGjo4BeouySRvcbCc6R+tSkKPKGuT8L6PuNlJFSAFMjMFXnD1prhVxwHl74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561334; c=relaxed/simple;
	bh=+9YL53EeeUluENQsBc0On+jaB3ZV92AxnlNMeiPyBqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1WkqBDx3+FG/sZ35ClmpRFPzk+01rsiLiRZhJOEuM7uvw67sxfqx/3RudWk+mwdFC+K67AAkjE5yuUrcEY16U5aOXMcyMsPB6ab4rT/J9pfeDaXZJy3ibEl7LOa1innnY7woIJNLoeA5ZH+X/p+KApep1Q/dnXn4sq4IEG57Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oF4Nauc1; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYRPm2focz7LNC3oUHp1Ti806Rtu8X5B0zErqmz+dC1Lw2k9CZGx45VEtaPeBEi2nwCIGgn4EDLCroLrzGiq3tZG8T4Aj2is46vpGS+jq5s39MrMTJ9b6gECuEukWlL0A296388NAipVEXqveAGCBu7fKsghlKsqymaUAPstgjxlR4QFCTAxSD4nOtP81Y+Qa5lgs24QXzVDfd2mxN4CPARyTQPey/OnP4paRdB1CHV2c43qim42hEod79ej6ljM0LMbAuuCy7kBf1DHjsbrGIQagCn644lW/xOGPik3vUUmos2MsTiw46zmtft5qX6JoBf2kn//aUuTtWOlvWRNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUATeyaFCWFUopb4n5zW3zLd+Y3fITC5gTACDpMQ2N0=;
 b=qRlRFab7KdS5sMu7hf7Xm3t0Yh5zGXVLrXOg4pCpP1wuVMAkUvsldm1rfFO1SGjoGtG1jRH/+eDvlS+AP2NhinyCvOxjX1Nbqztdkl0gFS0oTj/ILSJ1MyAtYpN6PmF3UiEgKQoajxV8SLoUMadJiwSa95o5bkWoxR0sYd5VXqLjcSuw9hcBQcE6rLf42cufirg/N+G9UhPNC44Pu9URubtVl/+Icl84rC0nIXeiDWi0fdCX1xe4OBoyZdUViUxPeUvMBw/hYkdYkjPnoIyYbixfRX7S14kbj3pQ+Tc6N2VaJDYlIOyE7ol59uPdG4+trbYbiKqj3mcT8X5mpcBTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUATeyaFCWFUopb4n5zW3zLd+Y3fITC5gTACDpMQ2N0=;
 b=oF4Nauc1o0D4xGayY1G89L9hh2RO9O0O/4zdAYLsNlrfd9Dg+lycfwfjSSXja30z/KDgJF8euQZz9d/Pva841+k7b4YZZWcjFN0MdIJp+Iyf7V/jSrWvPyp1z4OtdxDe3JfDK0hoC8qaYD61ffdPngKxPO58AHVsrf99/r1BKj38l6SjABVUZCsj7DKZYU8Xl9U3us2XcBE702COGjE1zsJYDz0z5hMMMDKkmkIY3hKUMR5cdhve5vrJ7viBQbWy6e+Plr5qEO7phUL5YIPJKHPpizOGuahsE/PubvbyD3Dn57FQegHnYu81+WKKEmRt0jMOmGhtSIah4rrnBNJmjA==
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 19:55:28 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::b4) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 19:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 19:55:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 12:55:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 12:55:08 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 12:55:05 -0700
Date: Tue, 6 May 2025 12:55:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alexey Kardashevskiy <aik@amd.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <aBppFi7eKngFipps@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
 <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com>
 <20250506125847.GA2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250506125847.GA2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: fb43138a-a590-47e3-49c8-08dd8cd7f27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hMP+V7PxnIlYAytle0gPB1mbkVAYDGOTEkwM8k2LKr7mg7p7+M+34mLWZya?=
 =?us-ascii?Q?b63LtQJYPrlBzZU5uFlAzpd/JsCnNV1qHeDfxJzjKBvURgBucesmw7SPiEun?=
 =?us-ascii?Q?qrutaFcKjXUlxfGlFeX+KcTRYYD1+znH5MNOjmZFF9ABdOmR56wRQ5mCXCSG?=
 =?us-ascii?Q?Q4WlPtDdxd0jwX+DtWyFkZn748YYtXwc0vGOc7mE3KB46Pxe1MziXbr0PBpJ?=
 =?us-ascii?Q?/0tZ4rSPOnCXELBP4aqTGt5PvqXCODxNqOE0JlV1Z3HzpPKS/vb8HkDlEoAq?=
 =?us-ascii?Q?6CGa2F4uwcO9g3A3xe412853d7akpQ6faPjlfvCRDNRrtlE0/4NLsHkEOzxe?=
 =?us-ascii?Q?8IZ2o6m5Gik06Ib0hXuW2EoEQlPP7oVsinDMITxzp6uQ1CZFFvysk56zRzXK?=
 =?us-ascii?Q?O8vwu/uVsBnVxtXlViq7eXyhXoGhZMWG7xV/kPXRVwh63m7KMAiR9oZo82Kx?=
 =?us-ascii?Q?4sRIzlDxvp14WJoywWDufZGRRmF8W0/kV4ziQZXJTGTc9skM5KYRWkCx6EeK?=
 =?us-ascii?Q?AapBja9lLKYK3q2c3A//n50QWWOzLOM7gsm02a5rWn1Qxb4rJBmRRap/bfrZ?=
 =?us-ascii?Q?8juBGvPitfwxvTGWamlOZs3AfGICPmUIverujdFAKhNLkahQ2PV+ya1mQZ34?=
 =?us-ascii?Q?P3p65tXO7beEOiWexb00KbxhmyBk916st502ORejkpoDDBpSDFLsA+Jkvz6P?=
 =?us-ascii?Q?79OMOMXCmU0LTeX2hck/IGcEqjhEc7tB4USDiQWEiIAEsYnLF9ItXhC1lOik?=
 =?us-ascii?Q?9Ctax9ivQrT3nBSIt6z9b2URS0pxa2DEJ1mePHu+gKLobc+xrOq2LltdT4eo?=
 =?us-ascii?Q?7QDVIjyAEaOVPjkosubFjE60FZjYarX0UUzgAg/ERXKyg9XjdssurSow+zV5?=
 =?us-ascii?Q?DDZ2SxaAJYk/NWpKvQ0yCq7An3bd6b3iHJVL1og1xE7mKrQtAq8bnqpd3Dxi?=
 =?us-ascii?Q?1rtPNywd9CrIk3wPtURJs/0bcM5Nh6hKsUIECMEIoLqQYY83m3QdxgzKvIuV?=
 =?us-ascii?Q?YLSGyOpvQM3cWN8rdZw+pIFnMGnQUGpPL9bRqdBACN4p/oEA0r2026uk6pfI?=
 =?us-ascii?Q?eAZLrrCZcyJc5zheH6i/cBk5gcm6TFYb/Zu2GWUFGmhuHIUYPHpsAlkv1wB7?=
 =?us-ascii?Q?ikf/ks5IBzkC9/gJvuDylOfeDMhg160d5T4uNMnXm8ktRvl9CxgDg9rHTibG?=
 =?us-ascii?Q?FQxCZz1Bx4cq5A7dsR2d+9spywXeJZkz4KNdasPTh3BCw6bI3a42BZaDeIgx?=
 =?us-ascii?Q?DG/jHwZNI+cl96Rd6eyDqkZ1wdtXS45508+yiMvI5FMaqoksVOSeZsV3g7FC?=
 =?us-ascii?Q?b+nVCvwCw5F+TMI9J4z4fZQry0kKWR44gVmTz4T3gsIYsF8ltVNli6KQWPhW?=
 =?us-ascii?Q?CV+mHbh5LIWCumucQlmVFwiBHaGxQXGptWPN2z4mOsX/08DZd012c+8pGBCo?=
 =?us-ascii?Q?ihEekMz/cNu1W57d2jyoiNXW01ASYwQqgFavlqqY6nwEm3JSkPW5kGtkBc0o?=
 =?us-ascii?Q?lASYmzj2V3en/N1OYCtT/GGcQ2S3B2UUdkEb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 19:55:26.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb43138a-a590-47e3-49c8-08dd8cd7f27f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

On Tue, May 06, 2025 at 09:58:47AM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 07:53:44PM -0700, Nicolin Chen wrote:
> > On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
> > > The bus numbers can be reassigned at any time on the fly by the guest
> > > by reprogramming the PCI hierarchy.
> > 
> > Yes. If we take some aggressive use case into account, where its
> > BDF number could change multiple times, I think it's natural for
> > VMM to simply destroy the previous vDEVICE and allocate a new one
> > with a new BDF number, right?
> 
> We should not destroy the vdevice for something like that. In a CC
> case that would unplug it from the VM which is not right.

CC needs BDF to allocate a VDEV in the CC world. So, it cannot
allocate a VDEV with BDF=0 firstly, which is what Alex reported.

And even for a normal case that the device is migrating between
PCI buses, CC might not be able to update the BDF (which can be
a part of CC_VDEV_ALLOC instruction), even if iommufd supports
an update ioctl. So, the underlying handler for an update ioctl
is still to first destroy the VDEV and re-allocate a new one?

Thanks
Nicolin

