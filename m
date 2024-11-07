Return-Path: <linux-kselftest+bounces-21622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48899C0BB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 17:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03399B22906
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD320FA88;
	Thu,  7 Nov 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbnQoHl3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6A212D22;
	Thu,  7 Nov 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997117; cv=fail; b=he1q/ah6Ct9uohRkqr8c9GCiuC6ZqU6m+KSLLDcKwfSio1Goeil4brESr3/JnmYikAMNOBS1tCVn2TI7yfdDNz68NPCZK9u6CE89VR2LdokQS9y+D4meptYehBLoPZLEeX9k1hvnoc/ZNg9eZM2RwYvcaXYsrZMElJVWB+quL9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997117; c=relaxed/simple;
	bh=QJH74D+dSGjmPw9BoabV2KMmyK5wqDNhT1j0FHrkJnM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLA6iGj/Yugg9GB0A99uOn/rli2riQOMF7JY6YgNCqHLcKBPaxp7E7TNnYEal8nuYHqNpVG4ohExhIHFFxtHodbYFiYZtT79/dyIC5N+oZRJZyscPlYYHGaNdM49PysMDJakZ+ezqZYaQy2HkLio5ybbXTPAQJLVTyyRenx8QG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbnQoHl3; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYERFexEqOmrpwYIv0+o+T7LIOP5OQpghqTWmz3TKpeiA4Jsv8Gd1OcmKt+EeKLRa1ex9+MDTRsmDWWz80n9Gmfytjjx5HAmFnf0UB3ftZo0guPlkLmQfgbTD6eJq1JEEuBAEopB/xLbR3lysKTS1loIC58rkDA5I0I46/Kx4Gvu6waIzP2qRW7FTIARxVHDdIbEyI/+tWCAn9ax05PM3BfjqVM73bfyvf9U6p5Mqtd5FWBhUMA/sSp39sjNifi0RxJHo2dWvey11aXLOKDsrirlYEbuG6IBPFIf0Zlc1VvPVgs81yQVEDfDqrtNX84OMiBf3IZ8gynu1n9Lcorvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb8NGRycyEvh8tupg+qxax84XEdQg4nCthtUYA/vJfI=;
 b=KWKIjhyr23bZQSm1zFlYU2JZqlQZlCBSaM/M1OpY9jYa4GsXq7h5Dn7+zT3Zxodn7cuLqKyH7hWGDycrBWPwTo2YavrNseiBKpeatLJ7BICh0RO1l/zWgGRMF71jUF6QipG+zMeS4IfAPa/jd5mk8MzDcqBdZD22U4RMFNZ2QAflbNYcukKnq1WiktKiS+4SY1HXIc96Y6W2oLzAYeWckQcKFaMiAvIqHDhWqBmAuHu0f5ufXV8DFdjkBMz0yufE5BQXNsz8/fvjpGxIsfgsrV/YkgYQS1unJH+FsbPghWD7u15tC3dRNYd3oPwz3eufrvTmG7zvmYyqXOVhfFXh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb8NGRycyEvh8tupg+qxax84XEdQg4nCthtUYA/vJfI=;
 b=MbnQoHl33yEtjZbb39+f9idVQoGXKtRx0cNJd2v0snzz3PrYSgu0qqP5SNclgmmu6LNTCaTI4MHjtcPBIVSuh34b39aAWxq1l/19k8p2paTSycOuhByfnU7esooCspoaGlNNuQEaYZQVSnRgEiPou/pIWae8/o8eL0r8qxtHUDwSR8/xM/QNZ6lr4gHsjpy6ceoy2GskrDgcZPeaQsu3LCPnPRTZ11gwCkD9Px6KF79452d7YU83SIzGbK8NztUb70o2FvdAe/Q+dIiM6xyzvDpiHCKHBsOrOEMWq5+UQOegNKPPvXuunKcNUBxUW5JpARZEOMK/TvFhdu8lcmzF+A==
Received: from SN6PR04CA0090.namprd04.prod.outlook.com (2603:10b6:805:f2::31)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:31:51 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::46) by SN6PR04CA0090.outlook.office365.com
 (2603:10b6:805:f2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 16:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 16:31:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 08:31:42 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:31:41 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:31:40 -0800
Date: Thu, 7 Nov 2024 08:31:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <Zyzra/E3ARtE/Yyx@Asurada-Nvidia>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
 <aeb88b6b-9989-4e1a-824c-757ffdbfbca7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeb88b6b-9989-4e1a-824c-757ffdbfbca7@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: c7183d1d-b2a0-40ff-da74-08dcff49aed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3gzNnVMVmZML1NoMDFIdm9tU3lYQWFKYnI1K2UrampsNm12VER2KytKTTBo?=
 =?utf-8?B?aWFuS3lvV25DQWR1V3FqcnpNckVjcEVNQnllVXZiTGFnNVVzZVhuMjVMV09N?=
 =?utf-8?B?Y0VYMFYyMmtkWEZVTlhoTklHazE2RzVUSU9ValY3K245SlJZWUovRzBjbW5X?=
 =?utf-8?B?YkVzL1ViY3lYVjREVUQyWTB0VUdaSWhoY3BUOHFyNWZ4N1lKdWlpc3B0NkFX?=
 =?utf-8?B?YTRrdTFtZi9nYVF4VFBtdTk3NGF6ZkRJSWpnNTFibkpNRUplank3bzFudUpL?=
 =?utf-8?B?bnh3WXExSG1KaE9kRzBUWGdSa3ZwNDdtTHdZZytnbVlFNFZoMEgzQmhza1lU?=
 =?utf-8?B?VSt2N3JMeUVUd2VaNUF5SGxVM0h5czI5SWNQUGxaNjYzWTlaWnlpVCthTHEw?=
 =?utf-8?B?NjZTSklBWXlHa3VaaWdxU2JBOHFuaGVpRUpSSHVlUmJkN1o0WmZBM1k0aGIv?=
 =?utf-8?B?VGU3R2l1OUh5Z000c0s3cXBPam4yaW9oTU1RaGxxOFlNSkVNbkxMSWpCOVlX?=
 =?utf-8?B?VndSNFk3b0lhb25hWFllb3RKK1VYWU1HN2YzbWdSNXJEa1hUMzVyN1gvQmNY?=
 =?utf-8?B?YmlMTTZuRU51ZXlURmd0akZicUtmN3MwMmllMW0xcnBsaE8xZ1NVem9lTXh2?=
 =?utf-8?B?cWpxVlgyTXNkVU8yM3V0VGthaDhGeTNQRVVwZTJ0VVF6V0F2QWlzbllVSS9G?=
 =?utf-8?B?YytQUUo0aUREMnBieTNjdzZxVlRLOGpja2xKVEZRQysyeWJtQi81L3dVQkdv?=
 =?utf-8?B?VGZlTk9saitaSE5yQUlZRWxWQU1VcmtCYm1uMmt3NHJwQlYwaWJzRS9OZ3dX?=
 =?utf-8?B?cXh4YWQxWmZwOW5VOGNkWXNQNUlqbzk4eURRZzBwQXFERGRNRnRYaXROZ0Fz?=
 =?utf-8?B?d2hvbUdvMGpla1dMU2d3eGk4S09DeVhBeFRsdksvQklkR1czQmNFWHp3Wlpy?=
 =?utf-8?B?UUlJNHBBSENTYWVvMVZKQjBsbUtOQzV1cTErOCsyT0xJcFd1Ny9TbWlxbzNO?=
 =?utf-8?B?TUtvS0g4TXpMMTk2YitjOHh6bzhWZHBjYUVBQms4eldZaHhSeFdHb01yV2VB?=
 =?utf-8?B?SFN1VVNsbHZlOTdZaUVtK00vVDY5bEM5N0xVRmp6dlI0STJSdWliV3NibmVu?=
 =?utf-8?B?S2tGdlNubnMwRWtxUEMwOTEwaVAzbE1BUkJmZUowOUk2eG5qeW5pQ3BPTi9Z?=
 =?utf-8?B?cHJCanh2aHVOaEdBWUZyZWpaZEJLZDM2TnpZQ0QxMWNVSXIrdUQ3aE90UVFB?=
 =?utf-8?B?MHNuMlo1dEpBbUV1aGhDTGhVamROWnNxSDJxZ3gyU3R1K2VYTVZwa0t0RHBI?=
 =?utf-8?B?MmdhMnBaVjE2MTdCYk5WMVQxTHVrNFNKaVFDWHU1ZlFDbHBHVUZnWEVyMGdu?=
 =?utf-8?B?YXZRZmxQcDNqSmw5V3l4WEltQXJ6MVlHV0E4YVhwVU5PMXArRCtWbzhzbDhq?=
 =?utf-8?B?ZGMzczR2TkNySW4rWkdvS2g3ZWkwcWkwazlVdHVSSkd5NG1XTzVhalRkQ2xC?=
 =?utf-8?B?RFFtTVNhWlJmb1lIK2lxdzdVdlk2Zi9NNG1ZZ1lVU09wbDJDNjJmZ3N0OU4z?=
 =?utf-8?B?STE3QjNYZlQvMUtPTEdkeGZ3SGhjbEVUWEl2VmpScjE4b0J5ZDFXTHhzVFBQ?=
 =?utf-8?B?NVdBUmZoOHNRdFhScjNZeUYrTGRSdERhY2t3WUVPaTlVMnlycnZPVThNVTZs?=
 =?utf-8?B?d0tZblRDRURDYTFIRE8vUXJ3dllRZHFKUU8vWUpqbnE3WEJsZytVSlo0ZFRS?=
 =?utf-8?B?NVhLSjcwM2hpWktsWU9BelBVMytEcWhMT3VvM1dFbERXUE1lWU4rWmNaekFq?=
 =?utf-8?B?UUV2aE9BeU42eHRQdVZzSW5mUU8wQXBGT3d4K25wajhEbFRlOExlcGJULzVJ?=
 =?utf-8?B?RVpwOWUwZFJ4U2h4Ujh1ekF2QkFENTdhelloRU9WamFraHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:31:50.9569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7183d1d-b2a0-40ff-da74-08dcff49aed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

On Thu, Nov 07, 2024 at 09:11:27PM +1100, Alexey Kardashevskiy wrote:
> On 31/10/24 08:35, Nicolin Chen wrote:
> > Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device (struct
> > device) against a vIOMMU (struct iommufd_viommu) object in a VM.
> > 
> > This vDEVICE object (and its structure) holds all the infos and attributes
> > in the VM, regarding the device related to the vIOMMU.
> > 
> > As an initial patch, add a per-vIOMMU virtual ID. This can be:
> >   - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
> >   - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
> >   - Virtual RID on a nested Intel VT-D IOMMU, an index to a Context Table
> > Potentially, this vDEVICE structure would hold some vData for Confidential
> > Compute Architecture (CCA). Use this virtual ID to index an "vdevs" xarray
> > that belongs to a vIOMMU object.
> > 
> > Add a new ioctl for vDEVICE allocations. Since a vDEVICE is a connection
> > of a device object and an iommufd_viommu object, take two refcounts in the
> > ioctl handler.

> > +/**
> > + * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
> > + * @size: sizeof(struct iommu_vdevice_alloc)
> > + * @viommu_id: vIOMMU ID to associate with the virtual device
> > + * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
> > + * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
> > + * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
> > + *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
> 
> 
> So it is one vdevice per a passed through device (say, a network
> adapter), right?

Yes. It's per iommufd_device per iommufd_viommu.

> I am asking as there are passed through devices and
> IOMMU devices, and (at least on AMD) IOMMUs look like PCI devices, both
> in hosts and guests. For example, from the above: "@dev_id: The physical
> device ..." - both a network card and IOMMU are physical, so dev_id is a
> NIC or IOMMU? I assume that шы a NIC (but it is a source of constant
> confusion).

In that case, dev_id is NIC. viommu_id is IOMMU.

First VMM should allocate a vIOMMU using the dev_id (NIC) to get
a viommu_id, and then use this viommu_id and dev_id to allocate
a vDEVICE.

It might sound duplicated in this case because this AMD IOMMU is
exclusive for the NIC. But ARM/Intel can be shared among devices
so they can allocate a vIOMMU with device1 and allocate vDEVICEs
for device1, device2, device3, and so on.

> Is there any plan to add guest device BDFn as well, or I can add one
> here for my TEE-IO exercise, if it is the right place? It is the same as
> vDeviceID for AMD but I am not sure about the others, hence the
> question. Thanks,

Generally speaking, adding vRID isn't a problem so long as there
is a legit reason/usecase. That being said, if it is the same as
the @virt_id for AMD, why not just pass via @virt_id v.s. adding
a new vRID/vBDF field?

Thanks
Nicolin

