Return-Path: <linux-kselftest+bounces-32527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0EAACE0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 21:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327DD522A0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB37262D;
	Tue,  6 May 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYsbhnx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0E4B1E5C;
	Tue,  6 May 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559885; cv=fail; b=Y5BB8MweO8B40dwuNOjYrsnpZ3j5vHtMzyPmSvmBVnFO8iEL4r2NWDKmAwTjcm6vmtrexFc15z+v9o0NZi8jmdyxll/ClF5HuU1zJ67RM8P5sMnsws49EuIO7Fw1Sh/rUVInOPWGUvddWTC3QkqAl+tKIpkjWaVoELhm+e/zE+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559885; c=relaxed/simple;
	bh=hYsL0uGBhonImICQXz7HbPx5BZ0F+rTulT5LKTcU7Qs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6D3hiN0gXQRW/iValxn8dxwmrBggjv9tbTa1ph6/pIqZfTgtPoqyX1bfSWq99Zi7aZXNvkrTTCt9K7MUS+DonDyRqOQrHkD+0WP+BpD/0UKvVShzNjf7qwCnA9PVgtUcBlVx7Ms7NYfb4etfwvSzSeR+eV0SJ3w6yiWuMIS460=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YYsbhnx6; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQYqCVvXfFdigsArQEzPjpKGBgQQhHZVAoSZm4T8a0yJawZK8gZVcLcIZvI57Iq2H2maNMh6cF+ztwRs2qYaSQomqERgkI03pmf6OAUenmojbRR8YzXNU1RejvzFwJqOHcRWyqWKM9cIWt8o12fNL/yINNGlPL4oO2SxMyTTEL1h+hFmwk2vzVZ9E7hf4FiGrCAsC4+gmumtv1uwzoEe1eguHukv3YeCULh24XKgvRZFgfakQKhA13knxy2CiFRADAmTFvl+VXfrVE82zX5FXksLQCwjD1BnEONA/NM8uNqdOOEPgOF71T1YoR2IqpwPAYw3BaE4QBxRUQEw+oWKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TqV+rltozNaPL/+E2J2ZBD7Fua7jbzPS2GDjLvoQsU=;
 b=lzsDKZU+5V8ARe/kzHOxgmI1DWp7aE/jA93nWUWrgyQMv9gr2rKg1S9CLose8VFx6i+4GJlr0VyB389//p6tlnISilvR+2beKgWeO3gAq+djFX4Ic7SiBHNWikNTn5EY6JsO4LLFez/61pF3m1yKLH0JycMCHZgIrrrl+3hiKtfHx+yeDUplE4fdR9W2gy5BqctNcn4I9yZVTMljtY7s9LcOgOxP8U3bV83BAECbYD7BlTs7NVth8Tc0rkT78Mskc9zWngqgnaax0iz/+UBpz28ndxtH9cev/sE8M/IBYog8uaLac3NjQwtqq3G7NcnnQ0uYRNPmptCiJhwpDb855w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TqV+rltozNaPL/+E2J2ZBD7Fua7jbzPS2GDjLvoQsU=;
 b=YYsbhnx6619AyAoc/FYfCEuu+8Tp3J/6Inn2iwkQYQCk2muZY/xN3eD4RQKAJGmwlLjuQTXGUUwGgv9aifZBQIIv0ZSVfOIk21Fo+R2NlDwleJ67IcGjQz/VXRy21SJkpr1n1j4Aaj3O3hajhdqdpLche/kNSc+hVV9qZBuVO4HMk7iYSW5D8hNET9IYiKp0KyWWKfhnCNuWlMlhjGrl7sp6t27SO9nFWkeGbZtAcbfjdLUDgv31ZCHQ+xOBHcPJx2S25EYCeeXl2AyfKdJ6a0yDcpChaLWKZNN7hWbcAjmf6HfvvPSyNm1Cn9zaKARkOXW50anAJTBLwM4QMBHUjg==
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 19:31:20 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::29) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 6 May 2025 19:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 19:31:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 12:31:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 12:31:02 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 12:30:57 -0700
Date: Tue, 6 May 2025 12:30:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBpjbtRgR1nK/LIm@nvidia.com>
References: <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250506125222.GW2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cc0c1d-1a16-4319-ef44-08dd8cd493b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdGe2a9jRaRdf4pnZRFStLwYNTj2WF7bBFDHzIJLvCWN4fov9wOxbqu/74J8?=
 =?us-ascii?Q?eDer8vFh4t0BBYlExI0cVnTxv48Ha97Q99WctLIzsBCwSTIpQGD1cvLIdeGQ?=
 =?us-ascii?Q?vz2i7HSR4rqZ3i6Q3PS0KtWQmhF/ZsZ6VpaB9XB+NiR/DbyTdCw/ltzWNrtG?=
 =?us-ascii?Q?yTAXJyGpCNX7Ghit0wwM7cfeAyl3mm8LQs8IBKbrtTuxz8lzdMpcYW27UBk1?=
 =?us-ascii?Q?DAAQ3Epu+eF/SonOR6vhQ40zgESRvQqoWR2ucfgMbTjZfXrSQ4FYho8ZqIvX?=
 =?us-ascii?Q?6XAadtbOv+3stLqnfsTTQ3pjgWIknHP512XReiDz2Q6Cj08V7kAC88pHQDSw?=
 =?us-ascii?Q?PoyLWHEvv2JdAJdQSfA4rsIbDPCCdDJAH81U+FJ3tbADCnlSxO1O3zVmei3W?=
 =?us-ascii?Q?W6cIS//amMTP0ljo41+qcklnVLnnR3DuTzjKFE8RoMHR1Y2EGVtkkhMiE312?=
 =?us-ascii?Q?HKYMXKnwGTqOUN1j7HHsZ7kqg5uMvwIrT1KzkStboYbC+00bAp58cD6io7Wl?=
 =?us-ascii?Q?oHucVs1P38o02bkder66BhqI/flUqr4l0zvZpQU1OVC1BhzHVN2mesOdy93r?=
 =?us-ascii?Q?KM7y2IFWf6fPqux28ojGtdUNI7xyVsW5YI4iLbmupdxIZzk1lnwoP1l+TF83?=
 =?us-ascii?Q?zeIJJguI6Rem1alaeTXmOUL1nkPyHS8BlK2nvKVeoMXOBA/U/BtV/2NId9OV?=
 =?us-ascii?Q?saMgzOdhxFCRNUHmMSA1mmhfGfYjZnT934/Er7RLGccstq5vqhElEVeV50BM?=
 =?us-ascii?Q?XLLjFTTt7Ol22SapixlGJYh7lPYNqww08GW8aJ74obxVnnAsnvaVzicyR5ON?=
 =?us-ascii?Q?RgHPyA0sgRQUONUnhs2H6Y8m/SkWr6xugV6dFz2XUtgH/e/yrk7rWzRHuRgX?=
 =?us-ascii?Q?HzxjXgizMvSaGV6GR6h11Wqobq0TPqBj7yMse0bVNVBBzFlckBPwaR8Ylav+?=
 =?us-ascii?Q?UNzPA9CaveMJtovURZbHtgLn6ayez39rvhfemNJP1KmZ4pyCIUZgWMiIXHNo?=
 =?us-ascii?Q?TUUw/NdcTOwOk2DxdmEYcjrg3rVj+kVpbCjgmZCUIeIuOe1h1tABXJ6Ky9qK?=
 =?us-ascii?Q?7kRyvNynUUP6HE1meDVGadxe2VRsvAIyh8hduk8oVnEnu7S5Jbu/2t/S4343?=
 =?us-ascii?Q?gMilVpPnihU0kI+7GfPUOE3805KdIItdD//PRsabvN7AglxbuVI27exDE4iW?=
 =?us-ascii?Q?z1yjCtXuvhPkPOYXVFsE6Xy+rGWOONr8d1ofmMIez57pHOfysUMwtbybdJEB?=
 =?us-ascii?Q?+ZJ0+VdfjZ2gB4pXubNDKgoKu/Lelchn66NHBcsi8N3+6pTO997BRNOwAJ9Z?=
 =?us-ascii?Q?0nTqW3NhzHH0d13fTrIgwHgxvIkfFJVn/KWNK5BNys2BCSWNgkwq3UYSRnpO?=
 =?us-ascii?Q?1vprGT5FyVTOkZUDe9kp0KQZnKRMBZGnabwiDjF81AxFjryiW7n9fs2x+2QI?=
 =?us-ascii?Q?q0xKzNsxBZcZsbiS8InQApCtCbx9ZduYCV+dfbo4twCmwVtJrxFD8J9P8fYm?=
 =?us-ascii?Q?ziVYCeJ4pr5NxGVrPY1AT4xrUX1bS8p07wUINq1mEao97GyDY1BLca54Lw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 19:31:19.3510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc0c1d-1a16-4319-ef44-08dd8cd493b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

On Tue, May 06, 2025 at 09:52:22AM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 12:50:56PM -0700, Nicolin Chen wrote:
> 
> > I wanted to ask: what should we pass in to the "entry"? An mmap
> > structure that hold the pfn range? Or just pfn_start?
> 
> Some kind of struct telling you what is behind that pfn range so you
> can invoke the right driver callback and retun the right pfns..

I see.

> > With that being said, it seems that I have been misusing the
> > mtree data structure, treating it as an xarray. In your very
> > first email suggesting the mmap design, where you mentioned
> > "xarray" first and "maple tree" following. So, I thought they
> > can be used in the similar way, especially after reading this:
> > https://lwn.net/Articles/846175/
> 
> This job requires a range based datastructure. Meaning you insert PFNs
> A->B and then a lookup would search for any intersection with A->B.
> 
> In maple tree you can do this rather directly since it is inherently
> range based.
> 
> In xarray you can do it with the multi-order feature or you can do it
> by replicating the entry across the whole range.

So, if I understand it correctly, what we want to achieve is to
have maple tree to manage all PFN ranges. And each range holds
the same entry, a structure that we can use to verify the sanity
of an mmap? Let's say for PFNs A->B, the tree should store the
structure between index A and index B (inclusive)?

If this is correct, mtree_alloc_range() that is given a range of
[0, ULONG_MAX] would allocate the PFN range from the lowest index
(i.e. 0) instead of PFN A?

Thanks
Nicolin

