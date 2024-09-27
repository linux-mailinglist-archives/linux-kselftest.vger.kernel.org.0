Return-Path: <linux-kselftest+bounces-18506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E921988AF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 21:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD844285D41
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A41C244A;
	Fri, 27 Sep 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H5dC/HYs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7F1C2DB2;
	Fri, 27 Sep 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466790; cv=fail; b=UN3d1bMH3qFjPa79ROn6hyhP+puIRWEAhn9PcFTrmeLsH3l9FxdD9YKIqSuRK8K5EHVnajkr94ivN9KHn9nbOLUldMS/dYrpcQICjqZsfjzWSPFNBYle1moiojeBT9MRmSrCWidN6aItGjI9H5pMgNupaHOmX3LmWycSko59JxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466790; c=relaxed/simple;
	bh=q5LBGAZO4ORgj1kc3DvwYoK1LXPQY4/KV9/7C/mlV+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqwgzTB3mwQ9tOoOdb8xMRUW49MD+FbTYLfQBmj0VnDBCzuyokvBF1iKdu/9GpUAhMqG3hwU+dP9cGp1mTPaPxwoXecyg0mllaiY5JDtiLuwiQpxnuZ3/T/ClC7atzW9LPABWszCJ9NUBjj6nUEQJ9aWUaYo+X1rBgpWb2cehj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H5dC/HYs; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR3/Z1kMm2b7Lf1+NE56zhy1NpiO2dQbjQIDpvVHRF7TzEwTtk/oaNboQPYmV1hKuBpKw3WEzWAEVR+OZCqz7bPxtneqQlDmN35yLNdukQZ01cfW+Wxr3dKhFtJfmNUG/6wr2UZNYlYSc3jm8ycVxTBXM1zSIHh658mlaNH5iul1r4ciyT04sDz6d0+f04V1fifPQD96peTUXwJxC+VSvJjXZMya89Mk+Vb1CsAV1TleALkMRdk0sBPvC4TQ29O9d9ZJVJ+DitB7uS5rT7FXTx6Wl0/fUhLl/G7TrhLAlGbtwJJrgPoUwR6s1ygAdnavDFnmfL+eMDE4FFFlFGOpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wLcBOsK2icChrsOWypD9yOQdXg2rCXvRGTX0kaqx3U=;
 b=Q6BWI6UvV4sfU70HjjCcDQ0V9aE/S2B0Qq0pGRwCn7En5vjOlgbPAYYgDjnqDXm2/8XFC3c9b6ALknJzVsnHmGbx7DIlMs4moksrGLsxL3zNCtF/mUmhRNWR4CbXAOdXT/1hpBkvmFGuwKmGB9Ze6L1StGRBInVCIG37xQlwoxtpqEl13n/P7QSWszDnUV7NhCXrUH5XtIYWze+O2BDufoIkcJWIEAQyget457nBwOhplI5jyUJhenXnJ5RJvYp22owGaizLb/pA+/vOAwII51ZytHRWaVxRvb9L0rB/eqX0veip6sZw+5nmulvX8j/cA6tVH27p7IX8UUrNXv3A1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wLcBOsK2icChrsOWypD9yOQdXg2rCXvRGTX0kaqx3U=;
 b=H5dC/HYsIbBgzA/1LITmWP6vs5uKQdldu+lvH8BsTCVzg14kHTfJFtT8kBqMlWAvBnpGY+PEpvQl1OUSWDggqXAgPd6+R1Qt3KS7vRE9PMd6+VEcBTW+ENXRJIskQ3cIFbN0uC3G8dL6ZpH8YxJrKqJtMPPibeqZzp6nHFuyGwPIwdp0BbVvWtyOjvNLhLR7D3mjRMpDp7Xo9L+mXhHzIkr+o4MCwrR+erqYOT7OBkTCUcLopC+Re9eb7qh3nVsN3qdEIj+/z77al6w7lebBAlkQ1KPX5FSXKoWzLXvZAENGG5O1kINg+AOPxKAPAQrSFOvHJ84vHiPOsMf50Im6Fg==
Received: from PH8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:510:2d2::17)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 19:53:04 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::e0) by PH8PR15CA0014.outlook.office365.com
 (2603:10b6:510:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 19:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 19:53:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Sep
 2024 12:52:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Sep 2024 12:52:56 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Sep 2024 12:52:55 -0700
Date: Fri, 27 Sep 2024 12:52:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZvcNFsECe0gV696e@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
 <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
 <20240927115925.GX9417@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240927115925.GX9417@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: acd42fac-6c26-4a66-4abe-08dcdf2dffce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55y7N6/iJe4OuGR7944iQn33Q3rWMno64wKhA+zYBSFKnKQTFXq1ACuoRYMM?=
 =?us-ascii?Q?v6TV1NJJSzKsrIRvQ23FZmvThh+nmG4q45oQRN9lfUoDXVXjS94qHNAygtmc?=
 =?us-ascii?Q?U+kdJkXVHyx5sm1MtJf7tfuYrIvQI75jCNDDFP1mCQYT/VireltkvRzg8C/R?=
 =?us-ascii?Q?U7p5kQ593peS3Oai3YwlMzjDuF/e6hNcIDdRgGx8DMq14VSEMlSnoNPT2mVD?=
 =?us-ascii?Q?KfzXJ0oNtCaSzYIAIqYsvJ41ShdU4koI9oyZeSgindxnqaP0mPNsudM40q1G?=
 =?us-ascii?Q?7ICHFtbvCkvRHLUfl7AaL2DeS4mEzzUnlBKFbXBsSxNjm46qXtxB95T59pru?=
 =?us-ascii?Q?9/SyPHThZRUljjOIEFROE+kEbaYdTvkQEy2It/Fq60DmfL1+8Xz3C27VCw9E?=
 =?us-ascii?Q?QlGRebpeo6igq7v+3dF9+6M8YKFCaLQFpodD9fKml0VdY0YHeZmoVcQouCeD?=
 =?us-ascii?Q?AZbGU32OkX+s+o/5m8K4INKGXReKk//jZa6fKsKdP4fuME/c5u5q97lpQxrc?=
 =?us-ascii?Q?cWfkhe626ObkBnDSyioQvJImjJ0qa+x7F2UP3LUMLL179j4XeGcIPkUKqT4v?=
 =?us-ascii?Q?XTo7lOXY/Yvmn5m3nJOozKS6O7FlTfus+2DMDm7maWbmyIzPNx2Wbp9pEJ+r?=
 =?us-ascii?Q?MHZNdYZ2fF1e/GH2cTPAiBSXE/fsddKYlwxLFNyqw71n3AKAJmOSbLSahW8J?=
 =?us-ascii?Q?RhRkKrDQPEK/GLs1+E7zUd+oAVVtzWoaOTtBG95Tb8ecRSvrJJj/vR5Kl/xL?=
 =?us-ascii?Q?ZkIQOaShLcyKEPtN0fhzqyd5qNRzk9tK9xx4vH3vGtx1PmXijBFI5ooUcdZA?=
 =?us-ascii?Q?D+ZQFak5EFb7CKELtWVa1GT6v+aT0u9yYMhBSdvRKCWOb+kD56gnasbZolMn?=
 =?us-ascii?Q?Jf8LFeiQZq82+F+86pLslSW3uGntMy2E3uKCn6zRlMlK2iADArE+Z9UsJ5B0?=
 =?us-ascii?Q?eUnxetoFCmg6JSlQ1RK2TYu0b9bFWTszEWujRS7RMP0FT247UhglBmlz6wwl?=
 =?us-ascii?Q?LhEDDllJKibHm6H2FqTVMr0AwLu3RFv62Tn3Py/h07rTtv66HkOxfewYQjM8?=
 =?us-ascii?Q?H43yoQEA90BwONPzpz1FMiFWSHSw59euJAQ7cNSFgfnyUUwdxxk0KeTzWJpQ?=
 =?us-ascii?Q?shpBTBn7oKkvFW8penUcxYHz06vwibRfN31T4Bt0WFRcZPsqIZqOCvpMDDUd?=
 =?us-ascii?Q?cOlCSxJ8SDHhrunzXW56MvoEMu6gydC8HqO3SYRDFXCPpHVezNR4z9uG2NGW?=
 =?us-ascii?Q?WOelpJv+xUwkgqPWRYQEY36vqUYREuSGpwIxFpPjkJXdMSvAAjjY5ZneSbWU?=
 =?us-ascii?Q?2ZNJU9xO7Jn0fVaSq/cPve+ERqPGs5eih+yirRmtmTZ8c2odn6z/QSwWyLqm?=
 =?us-ascii?Q?1tWdGOuaKtHSOQrMHsZZP5naNcQg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 19:53:03.7218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd42fac-6c26-4a66-4abe-08dcdf2dffce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

On Fri, Sep 27, 2024 at 08:59:25AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 26, 2024 at 11:02:37PM -0700, Nicolin Chen wrote:
> > On Fri, Sep 27, 2024 at 01:38:08PM +0800, Yi Liu wrote:
> > > > > Does it mean each vIOMMU of VM can only have
> > > > > one s2 HWPT?
> > > > 
> > > > Giving some examples here:
> > > >   - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
> > > >     kernel holding one S2 HWPT.
> > > >   - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
> > > >     kernel that can hold two different S2 HWPTs, or share one S2
> > > >     HWPT (saving memory).
> > > 
> > > So if you have two devices assigned to a VM, then you may have two
> > > vIOMMUs or one vIOMMU exposed to guest. This depends on whether the two
> > > devices are behind the same physical IOMMU. If it's two vIOMMUs, the two
> > > can share the s2 hwpt if their physical IOMMU is compatible. is it?
> > 
> > Yes.
> > 
> > > To achieve the above, you need to know if the physical IOMMUs of the
> > > assigned devices, hence be able to tell if physical IOMMUs are the
> > > same and if they are compatible. How would userspace know such infos?
> > 
> > My draft implementation with QEMU does something like this:
> >  - List all viommu-matched iommu nodes under /sys/class/iommu: LINKs
> >  - Get PCI device's /sys/bus/pci/devices/0000:00:00.0/iommu: LINK0
> >  - Compare the LINK0 against the LINKs
> > 
> > We so far don't have an ID for physical IOMMU instance, which can
> > be an alternative to return via the hw_info call, otherwise.
> 
> We could return the sys/class/iommu string from some get_info or
> something

I had a patch doing an ida alloc for each iommu_dev and returning
the ID via hw_info. It wasn't useful at that time, as we went for
fail-n-retry for S2 HWPT allocations on multi-pIOMMU platforms.

Perhaps that could be cleaner than returning a string?

> > For compatibility to share a stage-2 HWPT, basically we would do
> > a device attach to one of the stage-2 HWPT from the list that VMM
> > should keep. This attach has all the compatibility test, down to
> > the IOMMU driver. If it fails, just allocate a new stage-2 HWPT.
> 
> Ideally just creating the viommu should validate the passed in hwpt is
> compatible without attaching.

I think I should add a validation between hwpt->domain->owner and
dev_iommu_ops(idev->dev) then!

Thanks
Nicolin

