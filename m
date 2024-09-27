Return-Path: <linux-kselftest+bounces-18450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BF987E7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 08:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31FAB224A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC9173332;
	Fri, 27 Sep 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qkJb8WEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0D17557C;
	Fri, 27 Sep 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418755; cv=fail; b=eNle480HiKAACkioN+VbSS8H7O1IQdpjcz9K2qiidbODW/V32eWkTUqMltWwU0mYO7AuAHw+/v3rB5NBFcOBmBcbW33dgnF9FNO56vlcDcMaWq28tX5idq39hFYjPl7KngQweAru9k9MsHbh25URb2j/9BfDNzUcfat5CuNY1K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418755; c=relaxed/simple;
	bh=vWKSB/kiws/IK4EISfF50EtZnbe0fF0I7dg6ZjHcbCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtAy1CS03/uldej99LmA0H0RI8PTmC3P0mLBB8t2Z0Xw4billbvlF5RmkdmcUQTf9yMX+gUprluBbNccXAPSSorNxRaeJBEtMzpP3rLhjJvlg9KnkF2rmHEkdUAYDBtIj5uTH7Nj+JSQ85FNtY5Xj6Bcd2G8THUqy1CYMX9HptA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qkJb8WEn; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnkzfgIG64gHqkh+9TknUsDnq+TMxBcGA2ekBNDC9U/pZrdKADF6phv6MOAqhBik2Q9dApOYZy2e1dfSXo7WsTlt9lfVB3vbOQjPpmAl5AdNUEepVTz5YQXSN92jdSmSlqXvWc+2wJM6trHJgUr6mG8tGI3oVQlYGlNkYLCO/xcfAqIBFHMG8GmHDA5rQaSPs6RBZfVyEChs/uuRTj/2fIw0bdoe1WcEJAZgujPJ5QtCHGPI2IuAspxhPapAxD5+HK/qpcOgR6oJUChSoJYRKW1QSrw1PMCnqGCACk+91ITMlZuZjLfc8/nY04z4/A7mhpABte0INZejatU0q/Tm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4z4ynnFIkCcKK8awp8U9A13oSt62TfPGsZL+c/NkYA=;
 b=WM1ztTX4JAjwv7SRVxFoMTFnxiequQ025+N0XctNkRClqCmBS7hXgkpGf3wqEiNSB0mmhL/MnN16069T/6HLGixjTTgHjqGmHkVgWWUeoDCj7lnPqPv9LHSY1YHUq5EYxuKrB5p497M7fU6sNGpMt1J/Eya57GnPEWromU1RnnJtHee5wnT4s3CJwD0/k1EQCv6ArBVSVUIV8Z5IRnPKRF4ZVOqBJ2ok2BhpmU7+FxnDDwglFBtDPRmworWNDAy77c+Awpyn+Z0hEBP17jtSrr51sAkaPIKk9NvRvmT5H8H4nEbRaEyOUMgCq+2C5iCuHVUK1hYhGIRmlnw+8e4bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4z4ynnFIkCcKK8awp8U9A13oSt62TfPGsZL+c/NkYA=;
 b=qkJb8WEnHQIKWcRDK75OonDF5VzSBIIgtb5vpaIxMaOMXEF9HMDMLCbkTOrCnlo11wfcwnBZ1cogc4XwmIQsQ8X91ejR/ISyfc0Iu6+/YOZCvVe2oSzqD/Yy5E3XcqqsnSrGu+g5s0sng3ASdKIW8mtQDW7o60VkQ+4XnEW8zA4/C2ybeTOQN3kSuJoPyp9QkXFn7lcmqmrRxjZInzce6WvmRJOxTM22nSM6uC4qIfSZBD+EBd5pJsE1GRUas9GO89UgZNEonUPsAIc6kdS0yonlZrmHdKRFtuq3tpjFPK4e7oBdv6NXWG3A6fgGXBPNFLN3cOnORxhQTf/eV1yiYQ==
Received: from BYAPR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:e0::38)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 06:32:28 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::11) by BYAPR05CA0097.outlook.office365.com
 (2603:10b6:a03:e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 06:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 06:32:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 23:32:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 23:32:13 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Sep 2024 23:32:11 -0700
Date: Thu, 26 Sep 2024 23:32:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZvZRapZlAsEGDIge@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: d71aa1d9-9ac6-453b-9528-08dcdebe2841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O96ifY1zdApHyjT5kYXjrDbN2aE3QIfscyIq9Mq4n3X6a/Hbka03Q/FyuIBq?=
 =?us-ascii?Q?wo/AkXv5dFzrT4ARiO7x9SIzh6W+i9QtBJJp++ELTIA1OK3F+VBFpP3lpsmF?=
 =?us-ascii?Q?cQhdXuqq8AfvV4dxahj4aFUD/zrVSXsc0y7QIJlivMQe/MzHnJV7tGLy88Sb?=
 =?us-ascii?Q?BszKP7Gx3mf/LyM/lqqUTex/Sx2J21G4GS6oqrUWXVS2uDhkDUJIDgELgTi/?=
 =?us-ascii?Q?EHEOsp1Zr5xECHU6OFamL03UB3GOlju0djFMN6Jhu4hnRcCMAxK6K8pjKh0Z?=
 =?us-ascii?Q?BpRsb7xVcdlVjAlHxWAkuGLqwyat5VuX/NR+GRmJaGi8BsmjwrjN4EmRt42U?=
 =?us-ascii?Q?1ICD5c25GQ5BpQ/CRuQa/hHZ1j0z79DWWossK4rzP8mAXgLIDpmDRMhDWInu?=
 =?us-ascii?Q?VqiE0Xugr8nxvmSe94iyi7a48aipfevcDLglniDHts6pxuUbZYfAj93bXsua?=
 =?us-ascii?Q?O8KtUAtyHGVMKIUrrVme7qGoqVyFXCmpA8pYVnWGPNuxHATmFN/mAzswFq1o?=
 =?us-ascii?Q?oSIAw5jjJWCLhU1ZqBiSuVhrf42Q4VWmKudG1M7KCilKK50A3IO2/QV4wxCI?=
 =?us-ascii?Q?ROUQvB/ijgW22runUq2Vg3aTMKjjD2VKa5IhmuedRzxovFiSjX8SUmSsnOIF?=
 =?us-ascii?Q?0RRPt1/XYDkZleuLAZHM/csWpTEr0BYXbBbil80DNIlyTMYOCmY60/UaS04A?=
 =?us-ascii?Q?8GcTs7Zf2hdOzFkPI545NIca9ScIZuYrwvBIUBSsgma4sppGND3hId4FbZ1E?=
 =?us-ascii?Q?W+vu4wcONMPSTm0iyYDsugQaIvGIqNXUxNrM1mwH4LBjxVk2/mz6WCMEgfdx?=
 =?us-ascii?Q?8bO7ESMhCITWuh8sVjQLy9q543c7WgSgAqT5lmmPP09nVFnuVbWm2evkzt15?=
 =?us-ascii?Q?iXINBXLECTVz8k/rYeMvLNMO9Csqp8FQOFtpukRiA5RCBftrDEec/QoimDVK?=
 =?us-ascii?Q?vwAJi9OmN5Pw6SL02X4/hcHktCDzvlwrbnJel1nrcRR7TnJU07FG6FY45twh?=
 =?us-ascii?Q?6QHSI4Xso58ZqB/fnCHMtCwQw9cgRvKwIbY1o1EFbBaYoueJoLhQv2I+DIkV?=
 =?us-ascii?Q?j/Hm6TmQL7096PAIknCxv0x9CESQtowAiTpLKL0cDeZxzRBtSn2ijipied5/?=
 =?us-ascii?Q?CaqV9i3G3zf5LdDKCGBkmd2j/8Pw9fkhfb6MREGK8yNzzBCFnyEzVVQmD5IN?=
 =?us-ascii?Q?PqY1PBQQfifdUUNlo/X8qwUrW3RhqoxosaZ2HC16ArK2eF7q5RHen6+fIPIi?=
 =?us-ascii?Q?jNVyef5votgdveqnwXpft9jkZnGj0f28SMHXpsFmwt8BpT3cj1uwEqAKU0kr?=
 =?us-ascii?Q?CBd4DN8pOzxFWm+/6owgupoVfAOn3bDvw8rYNE/wxSuM4qIGap3FrYeVpEeQ?=
 =?us-ascii?Q?OvFLo2SGmzxUwtFHniJF9IAxu4xi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 06:32:27.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71aa1d9-9ac6-453b-9528-08dcdebe2841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

On Fri, Sep 27, 2024 at 01:54:45PM +0800, Yi Liu wrote:
> > > > Baolu told me that Intel may have the same: different domain IDs
> > > > on different IOMMUs; multiple IOMMU instances on one chip:
> > > > https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
> > > > So, I think we are having the same situation here.
> > > 
> > > yes, it's called iommu unit or dmar. A typical Intel server can have
> > > multiple iommu units. But like Baolu mentioned in that thread, the intel
> > > iommu driver maintains separate domain ID spaces for iommu units, which
> > > means a given iommu domain has different DIDs when associated with
> > > different iommu units. So intel side is not suffering from this so far.
> > 
> > An ARM SMMU has its own VMID pool as well. The suffering comes
> > from associating VMIDs to one shared parent S2 domain.
> 
> Is this because of the VMID is tied with a S2 domain?

On ARM, yes. VMID is a part of S2 domain stuff.

> > Does a DID per S1 nested domain or parent S2? If it is per S2,
> > I think the same suffering applies when we share the S2 across
> > IOMMU instances?
> 
> per S1 I think. The iotlb efficiency is low as S2 caches would be
> tagged with different DIDs even the page table is the same. :)

On ARM, the stage-1 is tagged with an ASID (Address Space ID)
while the stage-2 is tagged with a VMID. Then an invalidation
for a nested S1 domain must require the VMID from the S2. The
ASID may be also required if the invalidation is specific to
that address space (otherwise, broadcast per VMID.)

I feel these two might act somehow similarly to the two DIDs
during nested translations?

> > > > Adding another vIOMMU wrapper on the other hand can allow us to
> > > > allocate different VMIDs/DIDs for different IOMMUs.
> > > 
> > > that looks like to generalize the association of the iommu domain and the
> > > iommu units?
> > 
> > A vIOMMU is a presentation/object of a physical IOMMU instance
> > in a VM.
> 
> a slice of a physical IOMMU. is it?

Yes. When multiple nested translations happen at the same time,
IOMMU (just like a CPU) is shared by these slices. And so is an
invalidation queue executing multiple requests.

Perhaps calling it a slice sounds more accurate, as I guess all
the confusion comes from the name "vIOMMU" that might be thought
to be a user space object/instance that likely holds all virtual
stuff like stage-1 HWPT or so?

> and you treat S2 hwpt as a resource of the physical IOMMU as well.

Yes. A parent HWPT (in the old day, we called it "kernel-manged"
HWPT) is not a user space thing. This belongs to a kernel owned
object.

> > This presentation gives a VMM some capability to take
> > advantage of some of HW resource of the physical IOMMU:
> > - a VMID is a small HW reousrce to tag the cache;
> > - a vIOMMU invalidation allows to access device cache that's
> >    not straightforwardly done via an S1 HWPT invalidation;
> > - a virtual device presentation of a physical device in a VM,
> >    related to the vIOMMU in the VM, which contains some VM-level
> >    info: virtual device ID, security level (ARM CCA), and etc;
> > - Non-PRI IRQ forwarding to the guest VM;
> > - HW-accelerated virtualization resource: vCMDQ, AMD VIOMMU;
> 
> might be helpful to draw a diagram to show what the vIOMMU obj contains.:)

That's what I plan to. Basically looks like:
  device---->stage1--->[ viommu [s2_hwpt, vmid, virq, HW-acc, etc.] ]

Thanks
Nic

