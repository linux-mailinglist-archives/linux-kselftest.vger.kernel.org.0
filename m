Return-Path: <linux-kselftest+bounces-33112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB796AB8F42
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862E39E6362
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40D28AAEA;
	Thu, 15 May 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9Ftzpkb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5D2690E0;
	Thu, 15 May 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334707; cv=fail; b=TTA4lVdYmWqIVVmVXUVTHoLfhqbnuU2EYQyclEhW7C2Eni8F2XE/geLDDuSwGBF0dxxS73G/+mhacdEaTOtd09iQixwgnyqi1NcU/bIrHA4PV4Xf6DQVX69v7OgYl7dIg4aMjQUXCiwUp6GuAasJqnXb6WjXSacnVysuuQDPhT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334707; c=relaxed/simple;
	bh=XqzlKJnNb4Wy//+6kRb9s2Y4iTD8IrQCNkzt8k/Z/Ak=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us2DEikSIHVIlSPTM3AGs5P5VHuiYi5+hekYbrVCEx0S6a/hf0BhI+/bC8J41wjFtapVIReVZOJ2iZ4DhkEmsut6eTUfkxHHYRkSZ+9OKlrxQIQfom0wqxJApHyu9vScAP3elTgzSR2f09F6nt8mwjpWLRYTqa0lkGETVS5EAFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9Ftzpkb; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD7ETrYZCl7VmcJHmSMhIpE2Sxu/5NA0KREAzp6YY4Ztp9fU//Aw3BsdoJQg2Q+LgNVHhXiTuMdRRt7i+9QSExA1MzuSSmOQhebF4w8wdIpJU/oZ6gSe0pXA0QVNlJSgilo9xKHKim5jSRJ27nYTJS7x5eJuQrs7t27+iKg6v/ua1Ly9Ddvs8/egxuohKyMIbfedJfkgGhedX73M+2r6R5gly+qhVSHO/yrUnVBR8vD9hVmdkXGrmJ5bfJ1oLlI2qxTdNE00S+QoJ931aCRvNL+mKk1gGy5vkVcMGXAmbhW5aB1mw3DctnzHhpDw+nBRXhJrrfkr3Mg/VIpVOun7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhH7BiS+lfX96QwF6NuSEY+c9Of0FKBiFPYWdMZmBEs=;
 b=Doook4S6Hi3SrF8UT0hmh6G5RpRPi0rBzk72Pt9bxMELrgCezeHH+FuRSIMRH+2i+j3JeFYMOp86h49utpRH+9rDMACy5DUJJ7pd0f/IwXWT0jySmOf7tDl7k73ajbKtnYixhF9l4nUq2InAfxcBTq5JQUpGkH8XyVhfaIowqJ3oUmSg29mDitQopfixXg708OPb83BQfICnJf7i+LO9PB2vRxRDUz3yc446LUko1Q+jkINQmKNK+C/5omDQBzI4pL7Q6x+LM1/99OB0ZP9qQZLnKHMugNH2jXZhQqlac4ip8AubufAadWmM8FWvIKgF6OgcBadjcW9Q8mr6aS12Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhH7BiS+lfX96QwF6NuSEY+c9Of0FKBiFPYWdMZmBEs=;
 b=M9FtzpkbS4ptqldlvVCGYO+fATn00CMrg59mN3ptTE308S2ODmfoSL079iscZsSTFJqhXhfeClR8e3WbSQOaamd+s6+GBhstutsGU9IOpgAG9C+LOtU5Ad2qlZv+hfX1G+oM9paMz0Ahp2zT3Y+awlYZkMbo7aV5Ebm0alhLbC5MttX6BP+FwIGLDlY3CnHXzIlsTCoDe/5rquyZqufyg7RG1LaRf5d5ASCRp9LZIJy2ZhLWWFryt5I7Hk+SWkzSPstpf2fIHb3XV1IcybZqEAXR8GGlNnAnX9pz7AKNaKoNFBOlBrqtDf+u+JdlNYoiOfCvv5/lA5bZULDrr4Nd5A==
Received: from MN2PR16CA0047.namprd16.prod.outlook.com (2603:10b6:208:234::16)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Thu, 15 May
 2025 18:45:02 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::a0) by MN2PR16CA0047.outlook.office365.com
 (2603:10b6:208:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Thu,
 15 May 2025 18:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 18:45:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 11:44:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 11:44:42 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 11:44:41 -0700
Date: Thu, 15 May 2025 11:44:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aCY2GKfMh6f+vXHj@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52761EF8360BEF5C19C2382F8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761EF8360BEF5C19C2382F8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ed0d25-ed8e-4e04-fc68-08dd93e099f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9B/X4gmh+abTOHfvR+Fh/3vD6IK0QuSjik7dh3a9IqrDoE5NmXKGxBXfut2?=
 =?us-ascii?Q?1Ph3LhZ0yOVo2s41sGpOFiEcMGYDgcELEEYc7ULLDmtGpB89ASpTizEktGqA?=
 =?us-ascii?Q?9yHZPi+jKiGF2owDWXqOipNBsrXDHULMYMt8VbAPMt393HBTQapvUTsEZmzG?=
 =?us-ascii?Q?CRMVXU59+aFSxJKD1Z9TkKtXXXyaMJLDkz5edSSNKnmn5pcuT688M3f287l9?=
 =?us-ascii?Q?10v++eGP4FdlrcAQNPNZU6xaLFGfJTH5ScjakZWONxlbaIZZx5IgaKhZaqWG?=
 =?us-ascii?Q?D9PCSDwXsN9GfHQdXyzqb4lkxC2KE4X2qRTD0BOXLwUwX9AHg2T1KNwdJYRL?=
 =?us-ascii?Q?5Zt7aZX5QkFXoYbpovreitLj5TnYOX856KuODe+QIpgtyoQS6VlcXHLI69Hv?=
 =?us-ascii?Q?ULcHlEdMpMwjxkItNQrZKjXiay6tmyK1ZAvQfOKDEopzggQUVDmLxOJvCbZZ?=
 =?us-ascii?Q?JtuWa8/JU4+77op7h60lVG4Fmm9s3ijiX6sjwpHMliyY80/5bICzyxtrF6+D?=
 =?us-ascii?Q?TttWUMq5OfJ7pkm+5rxgRcqngtZwdQ8cmsKaCR0k3Az8oCudUQdsKkp7uoSW?=
 =?us-ascii?Q?/Og8yH/yWHxfk8VGPOm9i9efS5A4N1+1LSZ7ez08nsChHODnBMxCuwGOPrTF?=
 =?us-ascii?Q?6vyS6Gyo+nBuAxGetnRSGuAbRDuGn6KDJsJ8QoTr97I6ExUdktdRUecSzH+2?=
 =?us-ascii?Q?Drb9eKXL5zSMsD/CNOPw1JQDkIeG342gtxwQ0GQMZev96mvaoCV2rqWPVTbm?=
 =?us-ascii?Q?84bksYT9ZykCF9YTtI/B/Z7Kwmi+LE9xOq4NCIxxBiUIgKDo0hVp3u+wJRy9?=
 =?us-ascii?Q?xX0oSBqGcKkXD8EEuED+4LTcct4OZRzuyK171NRWzQubSOXwi3pV16vtET1y?=
 =?us-ascii?Q?FoWmZ984xQ+2X3kOn949nsDm4rXZP9rZWgd3QBVYJiZQFKVhcCHbTs9wzMLf?=
 =?us-ascii?Q?2DR/eyoSB1BxItefi+511BxqV9KN6Hg6djgV0oIGOySRC01Lz5m6WyJzkPTK?=
 =?us-ascii?Q?jN8A+NNdx53CbHPCaAtpdWyxVVhv5h/1HviJ73y/DSdD0H9gVlgBAWT2dfWz?=
 =?us-ascii?Q?2M08p0mcp7GyKOau75WHjuBCozDYm8bwMc6fjG7oLModPCInFrBUw/qbjQYK?=
 =?us-ascii?Q?LSIMpepGn+6K7q4Q/zB8Mop2A6Zh9OPIsIoe/cc2tmGciFkt6HaNJTA9H8Dc?=
 =?us-ascii?Q?X0zmG8z3mAvhaW8/Ygc76soXGk/V0tJxbn1VbrQQF0IzU8ljhU73D+NyuDNF?=
 =?us-ascii?Q?YscndRGiTKfJJ28IIIUsmrkC59ZFKg51TRS0Im3hl6J7s4WwuEWwQRBS6BdJ?=
 =?us-ascii?Q?+teQV5EGhGEbpUkLdY8SeRNb5vdJJ8lPBvx+9moAZAfXccRua/yzPCK9sFjx?=
 =?us-ascii?Q?pC8SdKEVHFGwLXqZW5GfoxAOqoWHJBzC+8LHzhaN5v+AIe8pECteowJhJl/+?=
 =?us-ascii?Q?fY6yLHF20oSwP3ODpWqgp15yKUjtUO8drcYgGtVpIf4Xdt2ekw6o3b6Hd+r1?=
 =?us-ascii?Q?odWL0BCyqYFkRROS8IAOZm/+2+V1tGwvjZL6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:45:01.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ed0d25-ed8e-4e04-fc68-08dd93e099f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On Thu, May 15, 2025 at 06:30:27AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:03 AM
> > 
> > +
> > +/**
> > + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> > + * @size: sizeof(struct iommu_hw_queue_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> > + * @type: One of enum iommu_hw_queue_type
> > + * @index: The logical index to the HW queue per virtual IOMMU for a
> > multi-queue
> > + *         model
> 
> I'm thinking of an alternative way w/o having the user to assign index
> and allowing the driver to poke object dependency (next patch).
> 
> Let's say the index is internally assigned by the driver. so this cmd is
> just for allowing a hw queue and it's the driver to decide the allocation
> policy, e.g. in ascending order.
> 
> Introduce a new flag in viommu_ops to indicate to core that the
> new hw queue should hold a reference to the previous hw queue.
> 
> core maintains a last_queue field in viommu. Upon success return
> from @hw_queue_alloc() the core increments the users refcnt of
> last_queue, records the dependency in iommufd_hw_queue struct,
> and update viommu->last_queue.
> 
> Then the destroy order is naturally guaranteed.

I have thought about that too. It's nice that the core can easily
maintain the dependency for the driver. 

But there would still need an out_index to mark each dynamically
allocated queue. So VMM would know where it should map the queue.

For example, if VMM wants to allocate a queue at its own index=1
without allocating index=0 first, kernel cannot fail that as VMM
doesn't provide the index. The only way left for kernel would be
to output the allocated queue with index=0 and then wish VMM can
validate it, which doesn't sound safe..

> > + * @out_hw_queue_id: The ID of the new HW queue
> > + * @base_addr: Base address of the queue memory in guest physical
> > address space
> > + * @length: Length of the queue memory in the guest physical address
> > space
> 
> length is agnostic to address space.

Ack.

* @length: Length of the queue memory

> > +int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_hw_queue *hw_queue;
> > +	struct iommufd_hwpt_paging *hwpt;
> > +	struct iommufd_viommu *viommu;
> > +	struct page **pages;
> > +	int max_npages, i;
> > +	u64 end;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
> > +		return -EOPNOTSUPP;
> > +	if (!cmd->base_addr || !cmd->length)
> > +		return -EINVAL;
> > +	if (check_add_overflow(cmd->base_addr, cmd->length - 1, &end))
> > +		return -EOVERFLOW;
> > +
> > +	max_npages = DIV_ROUND_UP(cmd->length, PAGE_SIZE);
> 
> what about [base_addr, base_addr+length) spanning two pages but
> 'length' is smaller than the size of one page? 

Ah, right! Probably should be something like:

	offset = cmd->base_addr - PAGE_ALIGN(cmd->base_addr);
	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);

> > +	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
> > +	if (!pages)
> > +		return -ENOMEM;
> 
> this could be moved to right before iopt_pin_pages().

Ack.

> > +
> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +	if (IS_ERR(viommu)) {
> > +		rc = PTR_ERR(viommu);
> > +		goto out_free;
> > +	}
> > +	hwpt = viommu->hwpt;
> > +
> > +	if (!viommu->ops || !viommu->ops->hw_queue_alloc) {
> > +		rc = -EOPNOTSUPP;
> > +		goto out_put_viommu;
> > +	}
> > +
> > +	/* Quick test on the base address */
> > +	if (!iommu_iova_to_phys(hwpt->common.domain, cmd->base_addr))
> > {
> > +		rc = -ENXIO;
> > +		goto out_put_viommu;
> > +	}
> 
> this check is redundant. Actually it's not future proof, assuming that
> S2 must be pinned before the user attempts to call this cmd. But what
> if one day iommufd supports unpinned S2 (if a device is 100% PRI faultable)
> then this path will be broken.
 
OK. Let's drop it.

> > +	hw_queue = viommu->ops->hw_queue_alloc(viommu, cmd->type,
> > cmd->index,
> > +					       cmd->base_addr, cmd->length);
> > +	if (IS_ERR(hw_queue)) {
> > +		rc = PTR_ERR(hw_queue);
> > +		goto out_unpin;
> > +	}
> > +
> > +	hw_queue->viommu = viommu;
> > +	refcount_inc(&viommu->obj.users);
> > +	hw_queue->ictx = ucmd->ictx;
> 
> viommu/ictx are already set by iommufd_hw_queue_alloc().

OK. We'd need to be careful if someday there is a core-allocated
hw_queue that doesn't call iommufd_hw_queue_alloc(). Maybe I can
put a note here.

Thanks
Nicolin

