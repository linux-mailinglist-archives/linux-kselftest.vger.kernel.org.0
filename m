Return-Path: <linux-kselftest+bounces-22000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93519C8166
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A303A2837CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B41E7C35;
	Thu, 14 Nov 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gEwqBZQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C071CCEEC;
	Thu, 14 Nov 2024 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554342; cv=fail; b=L09NWSz9PNJ7OJG26tjfO2ftvrV1nmTqbyMYKGjR71PgdTgwT4Wzp2gFa3/kT9ZRk32iJ8Z64E168PRcwluCBeviNBqIesTvis1uXWMsGhGKt9vkU+CYFNt62ORJDqLUzppt91/23i8Jf9WhyxAbwB/Cn6dP7ptR/utJrSCrQnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554342; c=relaxed/simple;
	bh=UBFtVb8iVvCcyDZOvF0T6qv4uBfbvSSmK3tE+xPPdvY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqqod87rQwV4+A/uXEppL7fFmH8cttgduUhnrbEhwvXO23w/6f5CdQWtToFBKf1quMy0yyDwRxcodP9vzit0+FhSolU5TUtWVIxOxI3tXW2CIzYFMXWwoZK2269EI1aSRtWrK1wpBQo0W2kXuJmHEaG/+EIdYvYNH9k2Qk1Fxas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gEwqBZQE; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymi+dSeU/XfKEY2yljxNpxlmC/H+TkGMCUR53PS+LAtKt4JntZSX9Os2fyXMJMehsEsLGPAb3rEzFXVegGC64EtSF/5D3y3UlTr8P6KivdkZCfF+937jXI/jXIYyaV+sS+5VTx8jYM3JX7KYRpjwWeE/SdpbJjJRY2lFfap2ZvoYMZUF2K67MoUstKi4ekTT3aTx0qyzTkXRI0Md1Pl7GGI97RQTi2qh5HNMkgYdgCBpDs6j1+WfrdMrw2NEDt7cl+QdroT2UaHSqnro4jXAOWhxJC3bOutioBqnKo+MKepsr9gbmXFZ13dsTckL4F7EGVGt3EWV9PBPbifUflZTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehT6rAB0If9vEJHeCDBiFy7b1R0jLpcIezct6z/0lLs=;
 b=LsJ/W0LA+KSG9V5WCIjfySSmVFgUOULX94H0xQvczXncXFkF2WrvODHQnego9fa7+yaTcaweoHY3qOmyuRGXL5JFbMNOV+0phB9oR54FiLismyL5IlwI3Pqb1l4FlPHcHMX16h4Moxwz+uKuuIgjwr48/yf9bxZ3ONkE0fSlzCkSi36aI4HWMuVqRN/lQW7U2smMZzJHXffrNPpEVqY6M6mguismhAWd6L2JKkTacEYM/NU4XdW7/m3Fc7oDSKMrUB4vXJD3pW+WaDdd16nGqZ1lYW8UyjU3Gnmb3y+nJ4rKcg3SNSQFxeE6day8tufVDE4rGNldlpUiZHDSDJLxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehT6rAB0If9vEJHeCDBiFy7b1R0jLpcIezct6z/0lLs=;
 b=gEwqBZQED9TMJtKz9q0gSQ0XGrQyR4xF8tTMkdV8h1CUEfGC/SkvrnFA9clXgdM0RMyhwBNJhLemahmPDQg2VdWlg4Jm5FjVmCB4PfX0RKX1Dv2qaJneCOJGK3DgJgAW1KhCDr64zge83ib9u2CYwzb5EWtJrWwxO4RWqXC98pzJ02gk5wUhjJuDZ3IhLp+3sBkMYBx8vBau6vZTPpcOP5vJqI754xQq/FmlN0pa/rGM1+Sw+UmrwxNCTsjTrw+Q2C4pAOt5afWRtCk6nyUz9romZXVKUmhaJUCyE2nWj1cF8mpAv4UbssiV+y95Y5DOyVy5OVrdeCmdN+DurrosCg==
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 03:18:52 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::81) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 03:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 03:18:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 19:18:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 19:18:44 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 19:18:43 -0800
Date: Wed, 13 Nov 2024 19:18:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <ZzVsEmzc1UyDdi//@Asurada-Nvidia>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
 <ZzVB7Fun48rGztuV@Asurada-Nvidia>
 <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0942ad90-4497-47ca-60e3-08dd045b1096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+szqSGwdxFPA12BS/USgKpYT8WReEeLrHb6taCyGRR+ig657fdtncZGw+oBe?=
 =?us-ascii?Q?xX18tLtpbiPI9Py74ghvyjf2T/RnN4KpiPthEYJ1Sed4BqHpluqxnybAHbc4?=
 =?us-ascii?Q?lZN/IJ9wWvaRPInfQlwkwmJcQDR70D4wkIhO+Aj3/ej4PGyjbCD63Oc7I9mN?=
 =?us-ascii?Q?LdxRqjL1luab17SvW7Nn5szIfDm0cbg09/b1YZOJDm1a3z+2+O21xG48qzJA?=
 =?us-ascii?Q?BS3gc6UKNXlHHpAB3p1QoMnRpI/rOTIAu+klRwjIp+mEWnKSVuB27fIF+z9F?=
 =?us-ascii?Q?lhamT5J7xj4stLievHLrvj/0k0jLaUm37fOQJBKIr6P/lOFKTnBTRt74EjfZ?=
 =?us-ascii?Q?AkNvGPCrvlKSSbe4+RiNhcwv/LD/vxlEJHFPCwwzaNhqO5+CISM7bjPSXikC?=
 =?us-ascii?Q?c2B8108X7heMubo4FhmfIuTSxLNGB+iXIwH0qC6HkR3T/K4w++AEd5IHKsXs?=
 =?us-ascii?Q?I9cogB9u5Ci9kS9EwXHoLy1baw9ds9MAWLQyJBduak3VlPASVZm73gByyCs+?=
 =?us-ascii?Q?7PKcmaIDDo5Z68c9OYQ5TGTC8JBQWcn5R20dopPBdQFndnbdjIDKUC2CeySq?=
 =?us-ascii?Q?X0FCGrXbCsUfgne8LDCd2+L8uLfWZLWxY3bDU60heGn3y+tpeCRwI5/W4nm8?=
 =?us-ascii?Q?dcRstyQzlpSh7zSvvKlkbSB1nX459kgW+SRlurUxM3WYVyageGxEfKXDpIhK?=
 =?us-ascii?Q?JdkZfyFXsbEbIp/CQk16gXPfTJTabnE63HSWJbqLdMEg7ftqePZHyg59BPVs?=
 =?us-ascii?Q?6IqDRD4zAUVhvDPL2uD5Ux6ImNNr8uVovVcFRfbE3zKhjnWIkk+3b/pPPJ9o?=
 =?us-ascii?Q?zr0Yb+NBtOwJlpyYgbmoG6CgG3qHIyJAdNu6vhzZdFT3utNNKPQ1kXCbZQZY?=
 =?us-ascii?Q?Ug8r/HY3B/TWK8qJCZQhcEI5Wjhc11uSFBIip72tCp0qbaxP99hZRrDtSTrn?=
 =?us-ascii?Q?2/szipR2RTsjyUnu3ym/aJIlfP/zEXzCy2fCZvc3BvNFAwG3lloo89SEhswq?=
 =?us-ascii?Q?vo6hdA0vzp6TBuXX/DHod7fesRp53ZJJl8Fo4wa9BaE8rkZFzowugeX5Dxm8?=
 =?us-ascii?Q?2+ojssQLHn7MTO70xkMlJAnU/e3vrp3i2h4n6DmURHLkzedyWstSVVD98Sky?=
 =?us-ascii?Q?Hkg47bDBVa2vzBRO4XAQ4ZjFpFKUuUVrTiIib6D3CiCB2/GtQjVZrtnDRU8b?=
 =?us-ascii?Q?MR/oxZWlsT0wrGW9dUJdwoeq8kmLLqaa/cTj8MU/wCNU3/Ait8YXYSAqjALJ?=
 =?us-ascii?Q?ta0auA7S12eNMRPP2BzThnNYJsgmjKYMVllq+1J2NCkwK3CDjcb1LtPv59ss?=
 =?us-ascii?Q?rX95CeDEiQW2DuDXuZ4uUtwh6QSvHqOxfY0s207cxd4YnjsAJvuLl0hiJ+uc?=
 =?us-ascii?Q?E041mGFdvFi8zLewWECAoLp1oQW+PoNuyP8Z0lsl8BMedAv62w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:18:52.2991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0942ad90-4497-47ca-60e3-08dd045b1096
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

On Thu, Nov 14, 2024 at 11:13:00AM +0800, Yi Liu wrote:
> On 2024/11/14 08:18, Nicolin Chen wrote:
> > On Tue, Nov 12, 2024 at 09:15:02PM +0800, Yi Liu wrote:
> > > On 2024/11/6 04:04, Nicolin Chen wrote:
> > > > +5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
> > > > +   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
> > > > +   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
> > > > +   iommufd core will link the vIOMMU object to the struct iommu_device that the
> > > > +   struct device is behind.
> > > 
> > > It looks to be reasonable to share the viommu_obj between devices behind
> > > the same physical IOMMU. This design seems no enforcement for it. So it's
> > > all up to userspace from what I got. :)
> > 
> > It enforces at the vDEVICE allocation:
> > 	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
> > 		return -EINVAL;
> 
> this matches the device and the viommu.

And viommu has a hard relationship with physical instance.

> > 
> > Yet, assuming you are referring to creating two vIOMMUs per VM for
> > two devices behind the same IOMMU (?), there is no enforcement..
> 
> right, but not limited to two vIOMMUs as the viommu_obj is not instanced
> per vIOMMUs.

It doesn't make a lot of sense to create two. But it doesn't seem
to be something that we can limit here. VMM can create the first
vIOMMU using the first device and create the second vIOMMU using
the second device, though both devices are behind the same IOMMU
and passed to the same VM. Thing is that kernel doesn't know if
they are passed to the same VM.

> > The suggested way for VMM, just like two devices sharing the same
> > s2 parent hwpt, is to share the vIOMMU object.
> 
> so the user would try to create vDevices with a given viommu_obj until
> failure, then it would allocate another viommu_obj for the failed device.
> is it? sounds reasonable.

Yes. It is the same as previously dealing with a nesting parent:
test and allocate if fails. The virtual IOMMU driver in VMM can
keep a list of the vIOMMU objects for each device to test.

Thanks
Nic

