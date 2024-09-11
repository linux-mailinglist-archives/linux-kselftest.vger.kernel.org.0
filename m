Return-Path: <linux-kselftest+bounces-17767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E3975C10
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D44528165A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E839149003;
	Wed, 11 Sep 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gJJp6SL6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1093D3B8;
	Wed, 11 Sep 2024 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088027; cv=fail; b=TfD8I3c/Er2ZzWIM1QIFZQXropOgoByze9bAFVC41c1HMdLHeF98hqDSEbaR1XJxAVywS/V+oaY+6Q4wv6im4jPclrOiYKMoVY4a+TsFq8o2/Ex5bU6bR8SiHP34OCqYEB0KvSXC7lCq2MJhd2lJq0vCRwuB/P3POdUvtX59zx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088027; c=relaxed/simple;
	bh=+j8E1FEwbJaTQDvzOhxoy/0B0Y0xm24kRcGwlAUSPa8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwNuxPWn4rsi2V1Hn/ZUTJphK+W4KQne7JSs7r83j2u9ToSlK+4kNRe4Ziq5rs4SFqsObkf20opIsyH1wSOEL6bEkglJfg7BhbgfziFqv72B1XuZ11quxJVPM5VdQPHrPkROnQJFSFI+lnSRRCujsScZ1do/FERvZfOIqu/1DQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gJJp6SL6; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJwG/DSb98NRIDAkqRU/IdBvgQermmCtcJMrS2jE+P7hH5DOSXw0qOAHzRrsQQNGm0LKaAt2UjUQMvHs7TwrLhcuGsgSQPsTkOT4foM7k9MlP86N+fKxxWhvBS61FT2LNGh0raHy8RUe95GBhYjP4sLIX4um/h0fzjuNHsKOi0nHVBnsLP9oMQDM40FidnzIgC5t0jQVDPTQWRWuF9toUjxVgr6ws9kj9Yl2RtE6OpprDUAFPOvvVrC0URXnVsnhrkv5Ab/b7I8Vily2Kbc+QV/CDrit9QWiJtqH2eiNW849HDnP/yRnwfJz2F+SD0U+DAsTPi1niC0NcGTB4yZXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaXM7S7gQWj86txDDKWL7MAi/O5PFPORnmDcqUPABfU=;
 b=oWhP62IxkY39y+qT2tan0v+C1mBU+Ag7zXldqfmbI2vuZ6gDHg8PAzdY0BiGryyF/XiMGxI5bGaw/CROjqerSbjD8da3Gdy0oH4kYuIH9NnAXOv7oHJT+1ZdwGzeXNN1oLDEAFOaE7zzJSBW8+HckzVsUwWU2++bcxVJzXfG/SH3XJSwH+Aia0a8ONwqNIhJ7/lnPcW5UOdoO9MadlZPpeseXkJ5zyGrPiRbh0k0xg2NKSczh4BvlfEvUtxZXGN2L7ZhcjNkYM+bQVrFzJIn0nEs7Wjn/7rKa+elDGxyvEXw2nXoVd9B3JEPUXuz9bqJVZ7fuh85NJfEZoXvztZzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaXM7S7gQWj86txDDKWL7MAi/O5PFPORnmDcqUPABfU=;
 b=gJJp6SL6VJOFnNPJ8INnw8q4vho73OKB9YeqvKSzcxiZFYOavC4SHn4fc6YrQo2hTvF7VUisECf8HP+VmUpC4bsGKBsYntc7qEUYxtKNm9fZ1sxA+v5pnMWup3i4ppI6OTTOLRB7u64zxT/jekHy3jQRHy3JUNui0MYvI9+whuHjoY0d6+fLF8Fp7boGtZjjijZhX+nXfDaBvh3cQY/ZWe/iP2moHieFJclFYRwIWLZrj8HbEl+He5m1UNEWs6AN/XQA0qLjXCeGacbPeECgWV3oGdZiMfcwPriwkxEv0FJioSU1vkvuEY4QjBThCnLi1GnzorkzKj3cN5E3RzzgJA==
Received: from SJ0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:a03:333::34)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 20:53:42 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::8d) by SJ0PR03CA0119.outlook.office365.com
 (2603:10b6:a03:333::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 20:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 20:53:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 13:53:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 13:53:20 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 13:53:16 -0700
Date: Wed, 11 Sep 2024 13:53:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <ZuIDPGue40n02kFE@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 250959df-9181-47a2-bd65-08dcd2a3d1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWt/AvqR5xt4FBRNtFd1wD+Zo9gBy3ZvQwAgfK4U1SmgkpMfx5RCJlEvU826?=
 =?us-ascii?Q?ovmqGJY15HSUhVGg700NyAEOJ6dwB1mvLXLbpON/YneF/6U2sFFOPreIPb8o?=
 =?us-ascii?Q?090dFDFfmf6kVv95tZzz9WaRrGzWmHCAUwK+tWViZRNIc19ZCXlF6ix/xj5p?=
 =?us-ascii?Q?xAYGxMjYjP0TBddiqYB7fadGtZ9DHLbKiDrBWs2SY4TiIcvHtJG2qgN70tCE?=
 =?us-ascii?Q?H2f5NV9JOKT6haiUePYwiVnmvGl/hdNsHgcEcpHH2u6I5vSrlQfFClzf20d1?=
 =?us-ascii?Q?YnK78TH4XCpjoUde67BdsP4EP0rDMo1gOrJ7PnAVQJqc+/3pttJfbFlTWEVY?=
 =?us-ascii?Q?I7b/YPyY2CLBi6Vh0rBuY0CQwWhIf2Cs+0Ybv875PlRKS/PTs3rLunxBIgIa?=
 =?us-ascii?Q?Q4TiUgRtxOQ/GI9S9iAVMmjoTQDPjDH4GwlUG67Web9jHRLnx1+0emfAKPk6?=
 =?us-ascii?Q?oeKHUVZs2retUOuHHnTxF4pn7CGgGGci+rDbrNIDW4PZXvEV5i7hpdrvisA3?=
 =?us-ascii?Q?lTw3406ti1gtc/3lNT2nlk+uySiPEUyfr02o+R+JMZmcTMUtVG2c6whZ4230?=
 =?us-ascii?Q?imF2xDxJHup707TdXCigjqdWnSDWBFngN3jj+Eo3/Q6X+8iIWXe+AI64sHZq?=
 =?us-ascii?Q?rjt25t9TW+nf5PjWQRJY+ntlp15x7c9PQ5z1rEFtF54wVGmdYg70MIEHNJ0C?=
 =?us-ascii?Q?NJGAivNpzNCVOGRO1RhLam7ppmPtnR4w1ruLmOEPDkp0aq38m4gEJv8VkdkB?=
 =?us-ascii?Q?54W7Dp8Ai9YfLG2EnMAPU3WCmkq3mnZy/vvS9bZUXJ7MoDvDpf/XL8pSDVIA?=
 =?us-ascii?Q?SB4xQZYZp9DcBkcWhhsvgB1cjNqT+IJ5LFZjZArYEYfrt6bMdQZs/mCeMno3?=
 =?us-ascii?Q?0seEpITtBFlN+ZllIqXs+TJcbcYegavaXp7vd3ynquubnNSyAiSSD+8KQine?=
 =?us-ascii?Q?mxLkE9qSMzjGSYHbE4ClF4FdlQ5ZOQ8fxaASKAes9dv2FD+HEg55Qy+j1gNS?=
 =?us-ascii?Q?zokW8XTN1Wey/kOZo4cjNWWz/HbAAHUfgZq22MgNNoPiA/IuIMY8zwCUuA+F?=
 =?us-ascii?Q?zEpW/uFrdKYP0iXdK3aB9Jk/tToAdPbS/33QuCD7JZCs2940D02eczZMtmKo?=
 =?us-ascii?Q?zMwayWIrisdNXC+OG4YiFzOcldV+hdPKtQ2Mdbjm+5FWAOzNX1rqa0L/uyLK?=
 =?us-ascii?Q?4WCtLB2aJ5y79ZRWvlDZXyLlP1YNlhr270IG4MsrFLyZ1McvBNMDdRw2Wxm+?=
 =?us-ascii?Q?XLyiNSrwdvoPrQwCgJDL+VEbv7sUhQk+Bpt1d6M9qariausScUejjENkhrPb?=
 =?us-ascii?Q?eovULywuXdTIrzbeZy1BamRChs0SFZ4m1qo34qv3mt9Omd95K58SDKBX6uFC?=
 =?us-ascii?Q?Qw5EEWWg8nL87m/EbIrt5zQ8OIM91yZ5V5ie1ZZ9Q1LFGMzOPaxCX541TZ4w?=
 =?us-ascii?Q?mqc96ZVOd9Oob1o/mz4h5VfpRnX90OVE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 20:53:42.2582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250959df-9181-47a2-bd65-08dcd2a3d1e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

On Wed, Sep 11, 2024 at 08:13:01AM +0000, Tian, Kevin wrote:
> > > > Yes, many more patches, and don't try to do it now.. But we can copy
> > > > the vmid from the s2 and place it in the viommu struct during
> > > > allocation time.
> > > >
> > >
> > > does it assume that a viommu object cannot span multiple physical
> > > IOMMUs so there is only one vmid per viommu?
> >
> > I think so. One the reasons of introducing vIOMMU is to maintain
> > the shareability across physical IOMMUs at the s2 HWPT_PAGING.
> >
> 
> I don't quite get it. e.g. for intel-iommu the S2 domain itself can
> be shared across physical IOMMUs

SMMU does the same, but needs a VMID per pSMMU to tag that S2
domain:

vIOMMU0 (VMIDx of pSMMU0) -> shared S2
vIOMMU1 (VMIDy of pSMMU1) -> shared S2

Note: x and y might be different.

> then what is the problem
> preventing a vIOMMU object using that S2 to span multiple IOMMUs?

Jason previously suggested the way of implementing multi-vIOMMU
in a VMM to be one vIOMMU object representing a vIOMMU instance
(of a physical IOMMU) in the VM. So, it'd be only one VMID per
one vIOMMU object.

Sharing one vIOMMU object on the other hand needs the vIOMMU to
hold a list of VMIDs for all (or attached?) physical IOMMUs. This
would change what a vIOMMU object represents.

> Probably there is a good reason e.g. for simplification or better
> aligned with hw accel stuff. But it's not explained clearly so far.

I will try emphasizing that in the next version, likely in the
rst file that I am patching for HWPT_PAGING/NESTED at this point.

Thanks
Nicolin

