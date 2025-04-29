Return-Path: <linux-kselftest+bounces-31939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF4AA1C9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3543D4E0A5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2890269806;
	Tue, 29 Apr 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQE/1Zem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1B13AC1;
	Tue, 29 Apr 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960731; cv=fail; b=alyeWmtlrTcn6tpQ0tY9ryTBym092gJdgExxdwI/0Efvvs1SyHMiwYbWGY8GCigmgkIIxi98zvweRTnP+nbk43exfFlVFPExjdkNeReHCplL24TVU84l0zezS7efRQmoycwBo+AhN7Q6dkuxtIfnNOscNRljgVzplLsqMnjC3Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960731; c=relaxed/simple;
	bh=i5PLJmJKcgUwtW/kuf4Q/GQdE2MB8ySGlTrEQwMC8x4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M80BAEjEZ4Ls9Su4qUL0JqGL/faXijq1F2zYEkk4c5D2/6mxJ1DnCuM3uA8XF48wl6lWJPOGz/akBmQb9pJPy6y3EyO7UF2NIRYnlhcVsGWqAcJ7l+RX2/YftTplRcjPcFDGYEhe1lu/AiOXj952qMplMVDKxiL78cpDNbbxKZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQE/1Zem; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb8IDv0yMKQkSRWT/TQ4BJ6hEjJt050q0w/9MbxOgPE7mvUQ3Jie58MI77HW27B4K32/V5s6UsS5ZrOp6S/T1MVW3qSMBvPPwAo0Zq+EYY6CAK/BU2qpl3PgPlsVGmYiHUQdhCwWhOb+IZFLYKreSLLtK8zp1bV2JYWHTia5jVAXpCu0yzF/npiW38y3wiKVFTS50UumRUJKQfbaIAxRRPSSxWenQUa7rNN1O5M0tvg5dEZiaU5XVxYIrae/Jjs7iQ49Y+WYLI0YKxtMGFHXT2ZXP385VFv1c1Ltan0nsfV9e54j8VBCUSG3VwfxPLvmVHUWz9ngZspwagxAWcFZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUVOvz8hR05dMk0Wa0czinEoziHByHwpuwtod18R0TE=;
 b=YIzy2RUuoSM7g05J8P9hFkSDVbjdvVoUor2kw/77/XjA4CTddsoIYir8J+mw4H5MPAopBuoahR5lXaVPC/r7nx2JL+7oxiZzqeFyp/BG/CBYNF3LRGfD2225yL6Enc5BXIFSmZwvQ1r/qeWldN732wt1ZJJbiRHDQd0OZF6dIdcr33alywE9PGxrDG6e8SSbxwPqYR9RhYkyhA7pQgaK/COu2Dniqhp4HusJvRZ4pOEaiK68bb4LNeNLUKMg4m0Xnwg2uX4Z6+fQzMPGHOrEXzdthzISTtUDH8JwSciYzkyEHK5jEcCNax7Dsx1QLTIAzjnBpsHPjsgN2aTwY1BUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUVOvz8hR05dMk0Wa0czinEoziHByHwpuwtod18R0TE=;
 b=kQE/1Zemn+FZX1WOPqPmd2z0k7tKmlHcCc7yj66MGS/z9LfsgLjLX9C40wLRAaS/TBTDFau+UAmQjU1UCElgcsPiDu6yol/3OWxJoAULwyo7sCV+IRvGYgigeVgtFpvzzF+sHPNWFZ3G9gu3XqGCMpa5BykYS2k4qQT5ItFKjEFhDU08CV6aoeJawKw4L/Zkpw78n/uSQRp1BvmQoROKZ7E+42KIJ0IAWoGfXjyPC2ZY+AVMCRUgy4ZeuUQ9RMWoZOgPMOQzj3fQM4c9XdE3m6kx/ZEb68RdeM9jdlyVMmwXpvNvs8ZCeF/ZGJhbgxYn4vw2oQBFOUd1yan2TO7/6w==
Received: from CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39)
 by BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 21:05:27 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::89) by CH2PR20CA0029.outlook.office365.com
 (2603:10b6:610:58::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 21:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:05:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 14:05:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 14:05:16 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 14:05:14 -0700
Date: Tue, 29 Apr 2025 14:05:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBE/CD4Ilbydnmud@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBE800DsAOOZ4ybv@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL4PR12MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: c84f94a2-9a5d-4017-b171-08dd87619133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wyfzhim6PCthVgc95Vj2wQmJDGhNJkuPWDzbMJjwFWmQvMOB2m5L9Yt3ZGT0?=
 =?us-ascii?Q?Cl0YWZ6xd+b0Si/UoAAn14dO1J1mb2D2E702y69wHxfM9XH5EGrig5WoypgD?=
 =?us-ascii?Q?5DsbKpJOGJUBGPYvRSPU6YnwN2y3E/zslXEJMwxHiHxPxeGW6sC/z9RYEIId?=
 =?us-ascii?Q?nVAndSxnUW/o48gDus11qsuMayyVkL1i5XVGm9/uKiEy1W51rlAy1ezam5PV?=
 =?us-ascii?Q?R74BcRfPDfqsn9bE3WolRSEmzmUIgoYk/sbHdmF9a3tGZLReVz8FXBuJgwAt?=
 =?us-ascii?Q?mwASRRbBlBQc1t3F0UH+19GWft3WbTVt3oCoqb7Q5tn+Qtpyeyra8e+AAWGf?=
 =?us-ascii?Q?LTOhw3kz/qNVhOBB7Js64GGshmGsOrlWbkgQIaAe2t1gtG191Uxkp9Dfm1BZ?=
 =?us-ascii?Q?bifR6/zR/e86NuQN+fidVfudH8ggvAw29UIeqGbP4mfY3Pxdl549uS/29fuv?=
 =?us-ascii?Q?mIbPy42hQQczZ4HAnKtpZmSoiWh1kerbUK5eg9jMgLAOtAEvHjz1XAATHPKZ?=
 =?us-ascii?Q?oqAdpoxX7PlI7eVOjrZAfHXp91twlN2pxHGI9TBlu4BcXqC5YekzsmHwug9Z?=
 =?us-ascii?Q?n1vkdN1mWS7UZD3X3cmm9TVnz2spL3tmIckkUbqBehREks3HGxnWJXd9S2P5?=
 =?us-ascii?Q?ZxaOhjNY40JdIQv0+N/78jWHMOIR7wfejbNjb215FjCwPe8WwXTp9CPUmhlf?=
 =?us-ascii?Q?ubE+FgqowBVUNCQ3jWKhlg9kXuT03muv7cVWuYjlVVKLNRI1j2xO0ckcKt5c?=
 =?us-ascii?Q?U5GjSfa9hHuzYItwFjiuOWIRg8rJYHEEcyfDEo3WmKHBoCJuyRucXDLwxZir?=
 =?us-ascii?Q?B1Zv+84zWMBP2zvBhR3w5D9BzDMNaG9xKPaqXSOhS6PHazmM5UZV7QNNNNzp?=
 =?us-ascii?Q?d5t2DAw8LEyHa4HtFbShhW2lJEZCjMiXU6lqs5GPlYFBgTJCWnQHEfbDxo5F?=
 =?us-ascii?Q?DGyTZdtS2gHMc9GC5HIT/kpm0rqP2D+T0pRwPNhFlVduuwdGfyojLkITpcAr?=
 =?us-ascii?Q?6FTaPhdSWGI7vbWa37Lasolc95GcHi/1Tvi31mi+Nqs7watfldNWWbiZgYNH?=
 =?us-ascii?Q?kwzXam2kqHBSOPbPVYN6nkyREkWRJZIAu5XS4WR3ldxOs9A+ragfK7am/BBm?=
 =?us-ascii?Q?5vab8N6Fiz/Lf50IMWF7GjOPCjg9jrqxt6CRx2YFIPBchvjwYEWRfE+3RQf6?=
 =?us-ascii?Q?mYc/cXfxRbKki+33zmNKVS8Vp/f0Lns/jHfebeSO8MvRFPraclpYE8ewLfxI?=
 =?us-ascii?Q?Rtzlx1NKnGWWcm1kDb1zUbowGuOeTrfW2LJx7VXVj53uRvvkZC2UtGajRRrI?=
 =?us-ascii?Q?CF50LJCY17LqPEIGPLCud92GUiuHlkPDqGiaZbKzg5h8I2nJc0jz9Jlta0z4?=
 =?us-ascii?Q?BkBv9EStqUf5PNm0PWcf134sMMrXyiW7ZUX99E7heh0AjoCj6SEhAbUJ6HRE?=
 =?us-ascii?Q?hRitqXGOT+l/bN76YiazSoH3bx6h1XHmjBv4tRMGFcpZjUBvFrq0NjM1KA4V?=
 =?us-ascii?Q?PDIq7Bo6r/ESj4Hau7rfkFSs6NtxHzkqE/IF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:05:27.2627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84f94a2-9a5d-4017-b171-08dd87619133
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9477

On Tue, Apr 29, 2025 at 08:55:47PM +0000, Pranjal Shrivastava wrote:
> On Tue, Apr 29, 2025 at 01:39:09PM -0700, Nicolin Chen wrote:
> > On Tue, Apr 29, 2025 at 08:34:56PM +0000, Pranjal Shrivastava wrote:
> > > On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> > > > On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > > > > +	struct iommufd_mmap *immap;
> > > > > +	int rc;
> > > > > +
> > > > > +	if (WARN_ON_ONCE(!immap_id))
> > > > > +		return -EINVAL;
> > > > > +	if (base & ~PAGE_MASK)
> > > > > +		return -EINVAL;
> > > > > +	if (!size || size & ~PAGE_MASK)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > +	if (!immap)
> > > > > +		return -ENOMEM;
> > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > +
> > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > 
> > > > I believe this should be sizeof(*immap) ?
> > > 
> > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > 
> > mtree_load() returns a "struct iommufd_map *" pointer.
> 
> I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> "size" parameter, which is being passed as sizeof(imap) in this patch.
> IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> sufficient for the given "size". 
> 
> Now in this case, "size" would be the no. of pfns which are mmap-able.
> By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> for a 64-bit machine. Whereas we really, just want to reserve a range
> for size >> PAGE_SHIFT pfns.

But we are not storing pfns but the immap pointer..

Nicolin

