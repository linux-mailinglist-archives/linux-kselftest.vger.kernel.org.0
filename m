Return-Path: <linux-kselftest+bounces-19002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFF98FD08
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 07:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B059B21ED5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC634AECE;
	Fri,  4 Oct 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBpC0nil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE7A55;
	Fri,  4 Oct 2024 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020013; cv=fail; b=ky8364ZP+C7kKN5/dECsSXC7Cahu4FOonmyl353PvkZOjc3Xzerp2uB+tS0oDJFxs10UYjXJuHm0gSmBbGM1FORQlU2lzog4GeSRl1IyPOXyyxXRZCVW4ncJfN3TWYwfASVzrgk4c3743heZOvP56zaNUKKrdqCHyFhnUuhlEqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020013; c=relaxed/simple;
	bh=SpO3onBzAK5EHmXMYzuMvBQTFbeuPNCIydcJLZvWnro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj4rVAfttWTgg4QhLYLwbPlmuQq2xXkqPZuRjM9pkCh4g2AanLfVWR5hjwidtX8yeZ8g7g8oqVTBoMwUVlgkI0k+JHaIvW0+WK3fYNgHXcSO1vAaJCXCz8Cg46+BgZqoKWANWRegILbazNsK4C6ZIP6RAyazBRRUqHG/M4BsSVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBpC0nil; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXTDYPOdQtl68kXBPGS+4fzEW69Sga+675VXxwumhO2auSRvrFjBjVa/xybJIfSEyW8z1KISEfXKLUSkHuan077UtupJuasKFkGzKgXQZQdD5IN3O0/REOOQvF8Y0cnZNPlZZQGAF6frjDOyUvHQEmGo5oqdonSckDLV1uKMPlGcBCNfOYUNigW36T2XcDUrXXq9RzYL/8mJIsVit/3wXKh1IlINuM9ShFukF5jAJw1z8rrRVT4cjpffOP9CzzcZ+OGJ/1MzdDcjvI+AxBxBVcSpALAOfMYfLOkk7K0Ey6JYZBoYJYZC6SbA2s78G9AR1to4nRzIuRluyQhPwbh15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcdpJE9jFr2Flrs6gJDDo4yPMIAU+lNdut+ayE3A3NU=;
 b=uiF7QruESjBWwL56lZmwfyv8PMdFIIHHSbNsFizpFSRpTQ4Mz5SbWVAPY4LBKhwxLc/dkN8tLhxS6JZ9mYnZSq38C2i0nR070eO9lCuvgoZHOt7n9E2GWxjWe+JcAIMfa/RMAt6rAncOa92yRD941PH6fjnIu8oLM6As2kmRvgBI6bVneAKn/An7S9si+KZczbnUrWq2nr4Nvgt863xYgfo6yvdYQRltS3gOdalYncdcQwNWY/ispM7nkfMnOW1hr9kn1VG8lBrgWeRMtWzTzI5peQjZgvpHTiG2CPA6UO1fpUsJxoo7sE3BsBZ+dXt+2XLv9ITU8NM8iLY0OWo3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcdpJE9jFr2Flrs6gJDDo4yPMIAU+lNdut+ayE3A3NU=;
 b=nBpC0nileSG9B2/bLNSIFlR4sDE+aqFYwYQt2W9UZRN/BuV+W8r2uwkqjOaLao7Gdr+U7dYhePvJkPGvFL/eDH8G0bZ6Trw8+GK6CrhHEtbu0cyBQL6eP+xjSSXZl7HeMp1Z1O+XZMRhdg0J2ck4h0bCFG9zCj+4Okien5qJ6MbkXO9KTPRCqgsx93HO4nmdq4Byr+JYnUAtpJFsVxAuSyPtg/sh+O4epaTNbBPV0o4ZpVgDVzcY5DUaf4wIUaA+7DBAw6O4+EpbkdrS9ccsuxU/lFYPo39GcF4a0aNQf8+kJFFEL/mowxQ+lnHlIztOSdAUO110gA27bpA0E1P3PA==
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 05:33:23 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::b9) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 05:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 05:33:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Oct 2024
 22:33:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 22:33:15 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 22:33:14 -0700
Date: Thu, 3 Oct 2024 22:33:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zv9+GWM/r8+QxEEk@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6ace7a-4352-4f39-95e5-08dce4360fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3o1MTZEdjhRblJ3U2tSNUFFTVFZNmZhQkVYRlkzQlVtcjVNVXF1YWdseGJQ?=
 =?utf-8?B?dXZOTDljZndZSVZGdUpoMkN1SWJZeDV4T2YvK3ZkZGpaRmtNZ0JVelRJOUkr?=
 =?utf-8?B?MlFZTkIxUVhIVWt3ZFpOcUk4TTZvME93Yy8vd2tvMTRFeWhtTkFZbE0vSjc3?=
 =?utf-8?B?d1NDQkhUMnFYT3hBN3lJeG5ZNzJYdEkwcC9VRzdnRHpsQjdZQkV4a0xVNC9C?=
 =?utf-8?B?V21sZllCbDR0bFhyUXF4R0huTTZBUGhPVm4zR25yekErMzNGS1JuUDhlMUlW?=
 =?utf-8?B?TE9ENHBXMER1SFE3QmlUZUd1aU94enNSTGpQWkU4WGFKV0RyRldERHR3TWNC?=
 =?utf-8?B?QXFqNmdscTBKSzNYYnZNRllCV24vbzdFSmh2NmFac05qTThHbFBOUjMxeUlD?=
 =?utf-8?B?SnFJcnROQmZ5ZDZ5TE1xd0pXQUsxZlpDOUVkcTRBNUVXZndQWjhCTEFmZGZB?=
 =?utf-8?B?aVlrek5LeTZBd2lnd013UHlXbkZRZmViNDc3ZXgwVXI2eWZWaFNpWG54T3FD?=
 =?utf-8?B?NktIWFByV2FZVi8vdXB1dzFzNmttR0ViVkJwNlhKOE4vVTUzYVJsQ05hOWR5?=
 =?utf-8?B?OU50aThrVStWNFViZWlObjZ1M1ZUYzhtWERGMk85S3N4RVVKdGpEZVlhT1Fa?=
 =?utf-8?B?TW41L1ZxM2oyUU5COHd1VnNsWURhRUNTbHZ0SnhlVkM5Vjgzd1JsL1R3Mytt?=
 =?utf-8?B?RU1ZYmlaYXpjaDNYb25ldUdQVTkwa1YwL2RUa0JmWWFYdlk4WTBLOCs0TjJp?=
 =?utf-8?B?cHljd2xHVldhQkZaVW83ZVB5V0J1cDRYMEUwYnpGOWF2SkdCblIrR3FkMmVN?=
 =?utf-8?B?TjN4WS93OHNmYTZLc0tlU3Jkem5UdHdtU2ZhaUxlN2UvSDFScmdmbWsybHRK?=
 =?utf-8?B?dWlYbEdMVWVvWWM1L3FteE54UkdhNUR5UGZlaVBaakdOMnZkcTgwU1Q2WDRy?=
 =?utf-8?B?QlNWMGU3WFdZOTZScWZ4aGtJVzlVVzd6QTVGNTlYRlgrY1hKREQ4bDZDaFY4?=
 =?utf-8?B?aVBvMFVLUDIxbG1welRPOFZWYkE0Y1pqZXFQTEZTUStVU2haZklVZzZBTXZ1?=
 =?utf-8?B?dURrZ0VuZUtPOXQzd3BnK2kzcUl0bm1qYThsV3VxYWUycUtoeUpRcWRtWjBH?=
 =?utf-8?B?VzNwSkkvL0Y5RUQ5NTFWTFI4NjJQbVJJYVg2aWRNWkw5bUZDeW5mVU9rNFZZ?=
 =?utf-8?B?ZEREMk5RRjFDeW5pd2sxU3NzK1pVck1KQ0ZKRk9PeUZuZ0lNendnVnN2Z0pC?=
 =?utf-8?B?amtkSnFnb09yRk1TcUxsT2h0ejNNb3ZpYWhVdzJTQmswenhOYXVVOVpBNUxP?=
 =?utf-8?B?dk1Ua1FrQXRHczcxZEF5ekxSalhuOWtvNitQSFVKKzRGN1NIc2FVMFVjSWJ1?=
 =?utf-8?B?RkRsbVQrb3JwdjZkQmxLNzVvRXVNaFJVOUYxc3Q1aHoyYWpJUms2Y0N0N3Nx?=
 =?utf-8?B?ck04OEk5N0hxN0NUSTErV0ttSXFOT01vN3lLanBVcU9zbnlzaWh1KzNpaXUr?=
 =?utf-8?B?ZDkrcnVhWUJxTHhYWjRGZEZSKzdFRkNzeWRHcVUyL1M0N2YwMCsrbmUyTE9k?=
 =?utf-8?B?ZTFxTVdlbHlZYUFYL0U5M1B4VEE2c2FidU44eDczZU5lM2FOSHZ4RjRuNllQ?=
 =?utf-8?B?a3NsYnBwUFVMWWtsQ091OHRyK0E3NjhQVFdvdWNtNkE5OTlxTFJSMEluV1hn?=
 =?utf-8?B?WXdCNFVnT3dubGQyWUp1SExJZkJzODljcWFVWDFQcjZCUVVWcWY1YXQ4dDBO?=
 =?utf-8?B?Ykx4MXFTdU9HOWxmMmRrQ0VoTDhQMnVLQjRLSWkrR251RFlzcFVpL3ZORjNw?=
 =?utf-8?B?T0srOFFDc01EMnk0ZUR1dzM3SDgrUFZPWEJQSGNaUWZ5NGgzbmhVRjF6MmJU?=
 =?utf-8?Q?zCYw7B0eAvwCR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 05:33:22.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ace7a-4352-4f39-95e5-08dce4360fe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593

On Fri, Oct 04, 2024 at 02:32:28PM +1000, Alexey Kardashevskiy wrote:
> > +/**
> > + * struct iommu_viommu_set_vdev_id - ioctl(IOMMU_VIOMMU_SET_VDEV_ID)
> > + * @size: sizeof(struct iommu_viommu_set_vdev_id)
> > + * @viommu_id: viommu ID to associate with the device to store its virtual ID
> > + * @dev_id: device ID to set its virtual ID
> > + * @__reserved: Must be 0
> > + * @vdev_id: Virtual device ID
> > + *
> > + * Set a viommu-specific virtual ID of a device
> > + */
> > +struct iommu_viommu_set_vdev_id {
> > +     __u32 size;
> > +     __u32 viommu_id;
> > +     __u32 dev_id;
> 
> Is this ID from vfio_device_bind_iommufd.out_devid?

Yes.

> > +     __u32 __reserved;
> > +     __aligned_u64 vdev_id;
> 
> What is the nature of this id? It is not the guest's BDFn, is it? The

Not exactly but certainly can be related. Explaining below..

> code suggests it is ARM's "SID" == "stream ID" and "

Yes. That's the first use case of that.

> a device might be
> able to generate multiple StreamIDs" (how, why?) 🤯 And these streams
> seem to have nothing to do with PCIe IDE streams, right?

PCI device only has one stream ID per its SMMU.

So the Stream ID is more like a channel ID or client ID from the
SMMU (IOMMU) view. A PCI device's Stream ID can be calculated from
the BDF numbers + the Stream-ID base of that PCI bus.

That said, this is all about IOMMU. So, it is likely more natural
to forward an IOMMU-specific ID (vStream ID for a vSMMU) v.s. BDF.

> For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel
> interface to pass the guest's BDFs for a specific host device (which is
> passed through) and nothing in the kernel has any knowledge of it atm,
> is this the right place, or another ioctl() is needed here?
> 
> Sorry, I am too ignorant about ARM :)

We are reworking this ioctl to an IOMMU_VDEVICE_ALLOC cmd, meaning
a virtual device allocation. A virtual device is another bond when
an iommufd_device connects to an iommufd_viommu in the VM. The name
"vDEVICE" and "virtual device" still need to go through discussion,
so they aren't finalized. But the idea here is to have a structure
to gather all virtualization information of the intersection of the
device and the vIOMMU in the VM.

On the other hand, BDF is very PCI specific yet IOMMU independent.
E.g. it could exist for a PCI device even without a vIOMMU in the
VM, i.e. there is no vDEVICE in such case. Right?

So, if your use case relies on IOMMU and it is even a part of the
IOMMU virtualization features, I think you are looking at the right
place. And we should discuss how to incorporate that. Otherwise, I
feel the struct vfio_pci might be the one to extend?

> > +};
> > +#define IOMMU_VIOMMU_SET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_VDEV_ID)
> > +
> > +/**
> > + * struct iommu_viommu_unset_vdev_id - ioctl(IOMMU_VIOMMU_UNSET_VDEV_ID)
> > + * @size: sizeof(struct iommu_viommu_unset_vdev_id)
> > + * @viommu_id: viommu ID associated with the device to delete its virtual ID
> > + * @dev_id: device ID to unset its virtual ID
> > + * @__reserved: Must be 0
> > + * @vdev_id: Virtual device ID (for verification)
> > + *
> > + * Unset a viommu-specific virtual ID of a device
> > + */
> > +struct iommu_viommu_unset_vdev_id {
> > +     __u32 size;
> > +     __u32 viommu_id;
> > +     __u32 dev_id;
> > +     __u32 __reserved;
> > +     __aligned_u64 vdev_id;
> > +};
> > +#define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> >   #endif
> 
> Nit: "git format-patch -O orderfile" makes patches nicer by putting the
> documentation first (.h before .c, in this case) with the "ordefile"
> looking like this:
> 
> ===
> *.txt
> configure
> *Makefile*
> *.json
> *.h
> *.c
> ===

Interesting :)

Will try it!

Thanks
Nicolin

