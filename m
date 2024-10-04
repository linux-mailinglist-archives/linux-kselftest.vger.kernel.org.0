Return-Path: <linux-kselftest+bounces-19050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8BE990ACA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DA8B21B4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7691D9A43;
	Fri,  4 Oct 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eQuJMzU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443B1DACA1;
	Fri,  4 Oct 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065650; cv=fail; b=WjN/nCgRdYLGCGkvQUbNgHJ9XxLHVJ2g9fRa99d+WIwxuno3I8OvCb5tlq0k9mxcL0P7LGcxW10JfmANrzF6cqAeFo3XGd+O5EDfNUbisPhqnLfl0OD5iruIXmmNbA8Li7Q30cnS2C8rAvyfcwn/O7I+xh2wcDPQ8ryDYV3EBB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065650; c=relaxed/simple;
	bh=cb7K67Bal0uIXK47/U2P4r3dGX3H6o7PuJSigxOYHDA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npOV4VTAe87OaMUuu50h1HfSJ/UbYXgPYGyM3uBSfdCqCs7uTWA9xu7Yfez9BMlGBiHaCo3iZAFEMi55vmHgqYyHwA9kAZn5d3lXjfsna1kAf3WrNcQWSER415tvPOUYq8fD/KYlGhfExIpSnL8aTsMQsQJNxr+pG0hlzfrrD28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eQuJMzU7; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf3Ou4FAaX9whGpHreWfDu9uF9gvmGnP3hPdheuD1GaNo/3HPGtmamYoVHNSxVmmAhdOLFrzowakekcmXzTapqjSpS0diz0WXoOCyME9Z8thbqt9p2xmDYocp2pxLqOjNBKyJrGFRh27pvVMxR1/G3uaW8jrkjvae3p9SrsDaTQln1b9zHfHlzXgQY1ESUwE/pT5NBc0kVp0ZJ4Y6cfC5NqS2ppzxB3FCcLbO+W+JQBtwMPsYV6X2eLeCPXGEJFxMAa96Fzn1klqH36abmAbOG6iadSMMQRNicAqFPMiIa3euN0EtHqtWKV1d7HQVRr6YYTs9z5aqhYXZDNn3KVcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4DdmH1/jiSVye/T3NS/6slWEYclgeldlupGZQOxP0w=;
 b=TY1RSocK/HECBNVGxu5p9Xsp3P6RjSyG7YE2Qna+UaPPW95MKHsJ9dSQ6bETbHikPkT1tX8GE18xBi/G4QKAv59dM2G4A2ZArHGQGlDdozpRKArO94RPG32fDEn2Y6JREsNbMu1zMgWaO4hzlLVsKBVdlbeUU98mPc5yaPG7Ap0NU/EQ4i2t3pYKof32MFJCmYlDwRkhd26qjbKxs76OX5txhuteVtUmkFI9mvF3Mc5+mhURQD9yIhYCQ20FGGJTx33PwcLkZSIeREKXBUXuTeRgGL9Fd0HWfZGxJNybFT6r9EX1R2ipjHQxLH65T8J0JjvJ2YMsZkUtFTHB94A2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4DdmH1/jiSVye/T3NS/6slWEYclgeldlupGZQOxP0w=;
 b=eQuJMzU7ITRfC72Q4UMTRIjnn1/nuen4wZDbtV7BfzOFsB7mehvz0psVMlrKv94Vk2PPJFlyqX8/U/1bnivntcLNE1wemfJ1wzIS8nSL7G232jNFJOEnhppyWkEC8jnQvE2shiRFfUiB8AFonNm3us2kzGVIVU8MrpwkBizNmBfqKGoUjMWCfCJqM/6+oGN7jpcAWEly/iQTeRmn3jGzmBJA5HFRte9D0a9UGk5Oaikz9kaN2mSEK2xG3QlDtJAr7GkD/v0BVP6xUJ+ep+7q56UmPVq8G2X9wtFJUwpBOEklQvYJCtme9Upm0YTZ2Jui7W/n9r7UluHnCX5PpyF5Ag==
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:14:03 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::f8) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:14:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 11:13:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 11:13:49 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 4 Oct 2024 11:13:48 -0700
Date: Fri, 4 Oct 2024 11:13:46 -0700
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
Message-ID: <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004114147.GF1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8433cce7-a921-4f7c-ea84-08dce4a05343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/7on8X5shbGA/lRc/f4Zc3qGn5YNGoeE2k9bOlKCTXTPPxQyw5YAEcHyp4k?=
 =?us-ascii?Q?iAvXSqsTV1bTdpt3VBU7E6a/+n8iH8uK+A3sas6zN2InljROcV0zSEbUkR3G?=
 =?us-ascii?Q?pJ29ZvKE+HWj5Vt+y3RwNPzMFjwzB9K4lPQnkwqqGLc7BagocHlGunacdlfx?=
 =?us-ascii?Q?jn/ZJfWjIlkfEZuSneSFQnpw5RjfhUjQwgWbfRcLoUSTPCp9UWtc+craOj+D?=
 =?us-ascii?Q?TBDLEttar1dYptCa2/FcvsaCbK55LSXwfjC3BzdhHAa5DwQ0veKWdA0MWILD?=
 =?us-ascii?Q?hf3zQMOt9WWdzskN2mZzwSJwNwa8RoXigJ9b9aEgl71EsiFFgCbktxwa9jWZ?=
 =?us-ascii?Q?TfWg9ziXqVqz4Ai6/V4KY72J6hax2m2L1Wc9+AO2lLKtiV/4CYS53ka//sYA?=
 =?us-ascii?Q?XzqB/WYnfeZc430eh7LTEoCSu0pIKH1qTeh1V5BZ1SamXHhcWdZuOxbMV4Tf?=
 =?us-ascii?Q?UQFRpxcYTEimQg1opgVEs/+IuSZqa3Q71smHkUrC3o3DzlEtk6cBqwhhFxjT?=
 =?us-ascii?Q?CIwlcPkk+wcQgHM9Y8uq4N0uIS7LrdCaXTvtHA7dR5Hp+51kDB5ntKoziB7B?=
 =?us-ascii?Q?AZJSMhoeN5hwcBm3+fE+98aBMQbNpvlJbPD3Y9ahHKDUbs1Ty188HGaXCE80?=
 =?us-ascii?Q?168ln3mY1GydK7/pfxyrZnU7bR8ieihwCHGplrKelKZQ9C5UngOzaY/F+eiL?=
 =?us-ascii?Q?fWToKFTVy/1xUQ54ryGz3LTcdxyLzD/MlQhB8SOOaKTsIYz8HEx3j59nUr1D?=
 =?us-ascii?Q?H7qPpezsfvqNpPIczU8sqdPRx0NVA2tZEcxcYqTY1EiV5R4adHFp5WisFusE?=
 =?us-ascii?Q?Uo+RwWM4lD7T0ZnHRhP58RAWxm8/vg0Hq91TqcTZwE3ycOnxPz5+hOa97mkj?=
 =?us-ascii?Q?lOEbsTa2KGPOpWCPAYPoWnlkhtdd0f4skJTIpDP9otPsZpm7K2QChHRHwe2x?=
 =?us-ascii?Q?Z3AuMlG0a4MdX2xHk6P3tdxFk98gKy0FAt3QBbM90mwnzuwBuiW6oO77T4dI?=
 =?us-ascii?Q?/LY5l/KvMnUUOwTepFvildMNP0XtqA2xL5jiymPLu6SNRjorcDPV7qcwHkh3?=
 =?us-ascii?Q?baa3GXjbX8CU48I6+hZKyN/o5Gqri962YGHhDyDwo6wgGHNuZQNAkG4vBv9N?=
 =?us-ascii?Q?PIecdx2R8dd9zDRuXPiPyvzj5eIMQVOvz5wgV88TdZ61jzJGj5Jd1X7Amogv?=
 =?us-ascii?Q?dxtaRJhkbUePMyoNDYXw5JXGPF0jrGF5OC699JYAbY/govc6+YGWhEtgJ23V?=
 =?us-ascii?Q?eP9LNdesfJLczzJ2TgXrD/jv5QJThi5zpwRhKkHRue6Nfk2LN27vPbw+l+1y?=
 =?us-ascii?Q?3qrNxNUMfslCts47TNEQNTWqhJbE4+join4dXOAQSGinh9cOvXjMBK+0ATPV?=
 =?us-ascii?Q?qKsfRbw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:14:02.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8433cce7-a921-4f7c-ea84-08dce4a05343
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

On Fri, Oct 04, 2024 at 08:41:47AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 02:32:28PM +1000, Alexey Kardashevskiy wrote:
> > For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel interface
> > to pass the guest's BDFs for a specific host device (which is passed
> > through) and nothing in the kernel has any knowledge of it atm, is this the
> > right place, or another ioctl() is needed here?
> 
> We probably need to add the vRID as well to this struct for that
> reason.

"vRID"/"vBDF" doesn't sound very generic to me to put in this
structure, though PCI devices are and very likely will be the
only users of this Virtual Device for a while. Any good idea?

Also, I am wondering if the uAPI structure of Virtual Device
should have a driver-specific data structure. And the vdev_id
should be in the driver-specific struct. So, it could stay in
corresponding naming, "Stream ID", "Device ID" or "Context ID"
v.s. a generic "Virtual ID" in the top-level structure? Then,
other info like CCA can be put in the driver-level structure
of SMMU's.

> The vdev_id is the iommu handle, and there is a platform specific
> transformation between Bus/Device/Function and the iommu handle. In
> some cases this is math, in some cases it is ACPI/DT tables or
> something.

> So I think the kernel should not make an assumption about the
> relationship.

Agreed. That also implies that a vRID is quite independent to
the IOMMU right? So, I think that the reason of adding a vRID
to the virtual deivce uAPI/structure should be IOMMU requiring
it?

Thanks
Nicolin

