Return-Path: <linux-kselftest+bounces-19071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9329910A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C11C227F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26FF231CB1;
	Fri,  4 Oct 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9Gs27kZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51700231CA8;
	Fri,  4 Oct 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074030; cv=fail; b=ki35NdYJLX9HZvT/BmFg2/NBIZQKLdxtgTKfModVSICHWuRLFTlJPgow2if4397+b88VW+uQZ6N3XpOru7dtaoonA4Zoc3oNF3UdUlnJFDRsWeCi+6krCTpaoB5p72k2hOOexDiEb2DZlNcOrbfqg1i5kYHpAbNZfKttrDjsSwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074030; c=relaxed/simple;
	bh=mSG0ujOEnQkaBH2c9pN9f3vR/KKhyCTBA2yG/69l3qQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CawPzE83bS8ELz5bAYr1UY4DeYnOvBd2cMhMAd2KxfnYIAzR2+0px6ZUKTINY23PYnjFPETuPUSA6wl01UKcm/UKsd9SVkktPeuMPASBY/4m1LBjaQvUNcxrtZiRJuQsluJu6h3NltPlGovELvdBJI1shcMULLmywW9wsLumNRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H9Gs27kZ; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sExbRVUUOteh7iabiM06dvkplcOTielIiPT18W4dBQU1uMCEIO4Q3c5sEFDVG1cbV5T8ZV0YgOIeoeciIboXwtlC+zA6CuZuMIwXmrzRTXeyNjUCfGkiAa+nfqeRq7GRlkK01NfhqAcsCZB6h4DRsIIGXzYo5vhFUn3W/2v1LnsCiphtDUMkDtleuqQjzE6U3A36Je2ossFnIUqMn16Hahkzbqb9mxmBmrvH8B0GE/tivjPYAeX7DeiVOpQVp3YfwY2R672Ls7ynzcPvxaOhIdMIt90FLpm1DGJbx59+NQDEnZV+mc2tJ5N/rFfLWRUhVllH0LBd3Qjp3sS0HyPQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlq4m4iIpNwXY8OtnRBOE/3S+QKA0HqChDiYm5ZQjLs=;
 b=Cm7wTk580mttotdTbCK+i3RyEDzDdfW4preamtXBT2iAKjodhhdKNWncxHBa2gYDoLfzlLFni/JuN1dP8tV+JfVjziCUFU4etpXQ09jWcDn8XBBO1PzK4Nz2RFNKvJZeWVHTeBri9rU+57pLHSRF6YEVDVbcBX9EXhva/Rk0NtS1cwld9KABpfZdNjgDNtSRvonKh5YZrzboy/zvCeuedo1h+3S/Abn4YOOQTikaJoI14mGTxnuxbVaDA/lxg3IOh2xRRTeoMQ4ZJFnkuwkY5Ce8+UBT2XV1Grlb7ztXUx2JDR3Zox9WWbUme0urcO2v7ZbefVT/f7F1zA9VtewF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlq4m4iIpNwXY8OtnRBOE/3S+QKA0HqChDiYm5ZQjLs=;
 b=H9Gs27kZ5zrqss01Z7QWpWCR9nprdN+WD0QsxutaPZWo/T9Nf8xw2ih9swxsmpa4ZEwjgAfAM6bh3tnIgOQ6NFJwAMkxXahhTjR1UbIz9gdwjk0dLlr20CtlHGMlWohcEfDAX1XXb/AhqL8lutWKOAkDmJHnKdOoLEppFxK5fYZ7D1bGNRBW4MiNIXFgG9L945To1GdXFc5iJ4gGZGvFf8pY7wAKpqYgIIAAOuGIO4G3+HLBaYiYiwE0jc0aEzHNYP8jQMSnweD/tE2maKBeAmMBUnPUvujJpH3oCl1vO157kCh3mAtOgBJ1Aw9kXLbDWIIYVknRgBZanHZxjjj52Q==
Received: from BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 20:33:42 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::69) by BYAPR05CA0042.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.11 via Frontend
 Transport; Fri, 4 Oct 2024 20:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 20:33:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 13:33:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 4 Oct 2024 13:33:35 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 4 Oct 2024 13:33:35 -0700
Date: Fri, 4 Oct 2024 13:33:33 -0700
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
Message-ID: <ZwBRHfwrRJCKXrn7@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
 <20241004185019.GJ1365916@nvidia.com>
 <ZwBBH+9hwuGKOstl@Asurada-Nvidia>
 <20241004201746.GK1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004201746.GK1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 405f1341-503d-4ea4-ea6d-08dce4b3d57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HMv9EnKi0yAMt3BO2SsD4bD6kBks4WZPBu6jOmC9riOhjJ3RsqCI6fQ9ytoK?=
 =?us-ascii?Q?gQhsHC/uzkbZ1din7tANwnOE07OvPU0k++COQL2eQ1ZE8jknxen1Q8Ze89n/?=
 =?us-ascii?Q?3r8VaudfyMRHJjcUUu7vHqFxO2NduklsBbw0qmltLPLoXX8HVncEZfjYtLxE?=
 =?us-ascii?Q?VELDew4l+wdn5+s+HCDL1bNiqw81oToMmWiv1KOF+TwWfp02KDuWdFH29eQ8?=
 =?us-ascii?Q?O0rgghs4RJVfaROFgHsAtTF4zdjtxEsB/p5HC5lqREauaPk6rkiIN0NJ7NLX?=
 =?us-ascii?Q?CMu5aGQ1eXl9CuQJHYYSdaTiMFiX3D5Wmt5qzkDbgRQk4sgzPN64QqW5ysfs?=
 =?us-ascii?Q?vpEIqzYW9ZoOyB9KM+9onriRlzPFFcvPCwCPNyxlCXrENPgIi86X0eX1hsZp?=
 =?us-ascii?Q?d85XCulhTilze+4SV8SuPY8ALtjvePZC+hirG3rv+tuKc9SGr+//7jvi+5SN?=
 =?us-ascii?Q?IddvRAQ8DNXm1SHCCbp9LiVYzIFdOBT6NgTfq/zcF6ABWn3XiMn2e25wx1eT?=
 =?us-ascii?Q?aLiVlWlmkJTG1I50Y4h6ryqFK0ApEbULmefrrdnj3Xc85jgwWP0trLPN6DTD?=
 =?us-ascii?Q?3dB+nOcpwsJJRwqYFpw7FW/rxU4+DAokCx0faE/RFFtB344/efUNbRVImgOF?=
 =?us-ascii?Q?oipdtS3FMt+A8y5qAVHKGYdNv2shxMccVgUnGB3JVmzes5goec2XLygewlDp?=
 =?us-ascii?Q?hShdTzozQ4wGIRP/R3H4K9B+Xzz89+cZzVzrnZebMssXccFtF5YXzoM6KRBj?=
 =?us-ascii?Q?hiSCCWgKipQ568av4EsI0c8aXnjOCbgfvUvHpGJfi+4GyQmt0dVZZudJW7nr?=
 =?us-ascii?Q?FXzofKpvYhiTJm5OZv7viEeQ+IZlboQdbdsOGoOYKyc/A+A7bDGb+pDVNLna?=
 =?us-ascii?Q?SVfgpBMEp6rsAmMwATNfV1DgeRnbxRhFHOLy8aDv3JArNbjTMvUiq2Dzob3K?=
 =?us-ascii?Q?f4X8XF783aIBB0f1v6vmvXvweuguxO+hEz43+NzWNj+q6G/Q8Klxx3VDURC0?=
 =?us-ascii?Q?yQHE8eYTARlTmiyUfsuOECBmirwtF0GXNRUOy/ylIVDzD7S01Lj6E0FqueJ8?=
 =?us-ascii?Q?3PO930D8on6LraZghqe8dqFKfC28Ht9MOHJ9pb2iNp85ELz6MLWvmKNHsRc5?=
 =?us-ascii?Q?X4OAbOAoe7u3reNAKD4QqX1C+MhN18TLm8K0mf+VwrnMoq5XCJe5BrtYQwu3?=
 =?us-ascii?Q?MK2gOL/w6SZ+uN2WacLAzX3HDclClaGnZCx6ILAHxbcX/Xtqh0t6l/X2KHHC?=
 =?us-ascii?Q?CXgg5eoZm9A8gLqicAoL0cyu5K3k0GbZycR72HvqaXmq5mD5mWs3gzXANtey?=
 =?us-ascii?Q?OQBKZuDyTQzyQ7pn7k3DFkMNQCpwPzYZDeeHo9ObVS0MkDjHuKTNgQ5MINwD?=
 =?us-ascii?Q?3xjvGis=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:33:41.0933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405f1341-503d-4ea4-ea6d-08dce4b3d57b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052

On Fri, Oct 04, 2024 at 05:17:46PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 12:25:19PM -0700, Nicolin Chen wrote:
> 
> > With that, I wonder what is better for the initial version of
> > this structure, a generic virtual ID or a driver-named ID like
> > "Stream ID"? The latter might be more understandable/flexible, 
> > so we won't need to justify a generic virtual ID along the way
> > if something changes in the nature?
> 
> I think the name could be a bit more specific "viommu_device_id"
> maybe? And elaborate in the kdoc that this is about the identifier
> that the iommu HW itself uses.

A "vIOMMU Device ID" might sound a bit confusing with an ID of a
vIOMMU itself :-/

At this moment, I named it "virt_id" in uAPI with a description:
" * @virt_id: Virtual device ID per vIOMMU"

I could add to that (or just in the documentation):
"e.g. ARM's Stream ID, AMD's DeviceID, Intel's Context Table ID"
to clarify it further.

> > That sounds wider than what I defined it for in my patch:
> >  * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
> >  * ...
> >  * Allocate a virtual device instance (for a physical device) against a vIOMMU.
> >  * This instance holds the device's information in a VM, related to its vIOMMU.
> > 
> > Would you please help rephrase it? It'd be also helpful for me
> > to update the doc.
> 
> I think that is still OK for the moment.
> 
> > Though I feel slightly odd if we define it wider than "vIOMMU"
> > since this is an iommufd header...
> 
> The notion I have is that vIOMMU would expand to encompass not just
> the physical hypervisor controled vIOMMU but also the vIOMMU
> controlled by the trusted "lowervisor" in a pkvm/cc/whatever world.
> 
> Alexey is working on vIOMMU support in CC which has the trusted world
> do some of the trusted vIOMMU components. I'm hoping the other people
> in this area will look at his design and make it fit nicely to
> everyone.

Oh, I didn't connect the dots that lowervisor must rely on the
vIOMMU too -- I'd need to check the CC stuff in detail. In that
case, having it in vIOMMU uAPI totally makes sense.

Thanks
Nicolin

