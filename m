Return-Path: <linux-kselftest+bounces-18509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B1988B43
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01120283020
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9E1C2DC0;
	Fri, 27 Sep 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3hMgHEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DC1C2DB9;
	Fri, 27 Sep 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468956; cv=fail; b=KjAyxLe/g89A4fBV3VXpWoRZDjA2bSnVLDus9rhnNQq6w55zlH4mr9snNPOflXUNV7Ljpw+WzJ4JFevCLR4/ByxxwGg4Ws5qtjB/V5bORCbM8GqLpyYV8S3U3QyaqAknhK6wV8ZvwtZX9bUVZLBI0yHTbM65WgptT+ippzSjgY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468956; c=relaxed/simple;
	bh=24akq8Nx97Zn93KSYXIe5gn2Z0JUN+Che7opeBcl7sM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqm2WZKLTZKeYxId30ZpcWTD87XaZy9f0rTsm2hi4RAwZV0egY9koc/fEIfEJrwlzLqJiaPA0aINpH9rCNi5kpbQXGeHe4pwR87JNR+p4AKOJHbeUKXwud8F6jEvqzg6i2UKgcsI5UGi9iHUOM/sLJMOhxX6N0Sw0ss1dgUm9n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3hMgHEC; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/rqCfp1mg/0zj9F1ZwSLuH26WivYSdDZXDwAbEa+JFNgu7zhkVRNwji6OEFYTk1fW48N5DJ5PL0AUz8caJlah8h3dakPgR7x7Fc3+DESQbc9Hck9CMHiQp7y5AfSPMG2WLHkdtN67uEBJsimnnsw3UeC43zKveborqi5UwElR07Dhd4ZWJI2FJGTvCCgxy82B9pcMWN90ETyBHTNTRWYQ2gZOpLkM8LbA6ipsMfxUcliFT5g99DfbIknnUKX7Lq5fjO39zaiYaavshqMBz9K93HUi81RrvuKkigykubeZ4dekWgAIw6Y94t5XalTZisomMyJOYnkp1UH+3SqW+5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFdv35Iw27Y2cwWFnNHztubOl0LdrAI6HFSBOiGdKjU=;
 b=LLDFeAtGMjTtTakB0JYg1HbDu8+Vd8fsrK5YE35wiw9J5fWyyypqnnGyllfbcbpMNq0XvTSY7hzPVZYnjRKLHe6rP4z18J5M09SaKspg4NKvAuz/dOfhKQxulvU6C9MEgFLCaCJSU8ToyD+uuJnPBwtvZViZfEFpVgb61vHzGIdwBV/oc74oHzl/C1U2yKIo0A5hmzNfw6Lm+cbThAWHprvmyi56Ozg8sb7ehz4CJvH3TvNqK31tta7HVILkxXvpsRT/P4oo2msd5Rq8Br+gSGrzCTnQCG1pDkAn8rKzcJmk3KxDni3lFrXkMa1QK/lZHCiTKTzZlYXeHUSh3WO/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFdv35Iw27Y2cwWFnNHztubOl0LdrAI6HFSBOiGdKjU=;
 b=e3hMgHEC4TAbWH5ZogNx8+OzQpEN3qYV0VawZciBqiWUfInzsvlbDtbnmmmibHku0T1fq999PzvrzrshEmScM6/Oe9hqgJVC5uT9O+5VazOpnXg3oFXXfNTtEl695jvz1OF3eNzHcJaIkdmxHrgkdFsIGrf+n9qsOUWuDfhXilAqmuE/6QtCy1tSZtQgyh1iAriLGy4lhH+xPc8JnnuZBDbZV98ST9T9pxf/iqIykds3wliNewTkPZThTy7aFGqoJy5t/G99Bsagfj038+en/0cdR1eQ6IM2NgRRDgs0VsEgq4vJrjoyio8+LSeSr7YFKNfq14MoZ6/p/P6xxqN/4g==
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 20:29:10 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::dd) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23 via Frontend
 Transport; Fri, 27 Sep 2024 20:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 20:29:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Sep
 2024 13:29:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Sep 2024 13:29:02 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Sep 2024 13:29:01 -0700
Date: Fri, 27 Sep 2024 13:29:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZvcVjNHykF1BJLUt@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
 <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
 <899c781b-c2bc-4012-b0a1-794fc64eb478@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <899c781b-c2bc-4012-b0a1-794fc64eb478@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b05c6f-4d3d-4b96-3bfb-08dcdf330b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RovvhA1nwZYXC/xulc4Eyf1xpZRt0SFsdRfdmdT2EL4OUd/0alfQweNP0CQi?=
 =?us-ascii?Q?sbnv+/mp6CiNUdWHhgC04LqE/gRfoUmi5eYb0rXM4rGRMirt7E5n1y9f2e10?=
 =?us-ascii?Q?vNS0j9ekfp6x0x5Itn/mTroe1aCzOYdJ0WBZMu9v36YaCAPIBidF0fDrqxVM?=
 =?us-ascii?Q?EBk7FhsuOeQZUXeenzy6CjyJfAK0MMhGFw6/MozBnDZiz4LeKNqseWO6lq8E?=
 =?us-ascii?Q?uviTLhFQlAPaRO4Qch4fsvRkoROcU60nvOrzvLL1woBNgPPNrkh+Gcope0qu?=
 =?us-ascii?Q?7cPfoasTM7x+gsh3Jeqfu/n7qaLsZP2k/0EEQQMqgVLaK7T1Fs/RS30OlJZM?=
 =?us-ascii?Q?QeZEXhxVilL/wHB0Xjxh6JnfrczOKH3tiLFjH19KWMJREIcfoWr5EN2W/kEk?=
 =?us-ascii?Q?rWEWGs5NG0/w8Z8hfODAFNi+UGF8u6gzjauMVJloAvL6gtpmcRXnOZSOn+LC?=
 =?us-ascii?Q?BZ9jiFs3+mEcK4BSY9LJNrnQ5nur0VvCKVt5468TlFzcgW872q3WDlMDOroI?=
 =?us-ascii?Q?rH1mu3apkYuN3gXF26vDWk79vBOB1p+WtIQ0d/ztxo83RRPSf244oLXxPzmA?=
 =?us-ascii?Q?TNP9jXVo1sRr6UTcbS43rcC45R2G1v7+/O5q61M0jebYSJVkwWKzFHOPiw8t?=
 =?us-ascii?Q?+RcnI+Qry1iejEqhNZcoRcXgb6jekmf1zt1yO66gp3OlR1rFNCtQKLNTZ8RT?=
 =?us-ascii?Q?u9zq2feaH2fuKW1SQ2hyqBYuRhEup7c/Zivaf5QXFe6ZUBFwjrici1xwkKKG?=
 =?us-ascii?Q?+yA1ITAleJl2x/LWisbhjSnnK3IcmJ6vBS4QBFC9l1u7Il8qmRPmY2T69EVc?=
 =?us-ascii?Q?05gFJqmpCEj52rDwkUBPi3rridpt8CUX6gLJETY1wFFUc19r4odR7PFjNVa5?=
 =?us-ascii?Q?dkkk8zHPUB/+Y0AOe2SNJV8Z6C7uLbDnS9hqOt173yVnrjy83S+rtmukHbGe?=
 =?us-ascii?Q?uBp3elR4AfLNQiGU68UGuAqHGbFkEVX6VIYlG1wju1W+kf3AdjYQhA5z4267?=
 =?us-ascii?Q?SGeZ8/S8zXzWeHjG0JVbO5nkkvyO8aKyiLhUrEi4gyXLr1q3wuEts1oBMhic?=
 =?us-ascii?Q?UZ99piCreGcBR/B0vP7GhpZ1A815WuyxsDbLfv7KRL+GyS6kcOjw/4ElQ0ag?=
 =?us-ascii?Q?7OdRVnEiVXLBhbu+eS4WV3Iw4kHtzfaH3AmTrF1nnv2lby9y7z2Agm+epOeO?=
 =?us-ascii?Q?Zv7CVEtswegZ8YbYuQMXvNCEBVPYI//IDWJCI6aKv1l7qwtDT+bbVjfWYnJl?=
 =?us-ascii?Q?LHLnC1WV/eAXt92abr5wNNGCJZfLK3jd4TVnXmqyxt4uh6VMkg6eBTPKJIuv?=
 =?us-ascii?Q?YRmTjqUOBGE8izmHOzpafR0Hp2INwuZWWRha8nsrrMyeUrk/lUxFNMcddcV1?=
 =?us-ascii?Q?KRPqpwyNuk1XJdlad4tm2pRMl9DqHUSy5Q1sqixbGZIs4vDeCRAdHE25Pwje?=
 =?us-ascii?Q?cWmgznBLdEd7ap8jhdOJUJMwvabX1uY2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 20:29:10.1546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b05c6f-4d3d-4b96-3bfb-08dcdf330b23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

On Fri, Sep 27, 2024 at 08:12:40PM +0800, Yi Liu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2024/9/27 14:02, Nicolin Chen wrote:
> > On Fri, Sep 27, 2024 at 01:38:08PM +0800, Yi Liu wrote:
> > > > > Does it mean each vIOMMU of VM can only have
> > > > > one s2 HWPT?
> > > > 
> > > > Giving some examples here:
> > > >    - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
> > > >      kernel holding one S2 HWPT.
> > > >    - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
> > > >      kernel that can hold two different S2 HWPTs, or share one S2
> > > >      HWPT (saving memory).
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
> >   - List all viommu-matched iommu nodes under /sys/class/iommu: LINKs
> >   - Get PCI device's /sys/bus/pci/devices/0000:00:00.0/iommu: LINK0
> >   - Compare the LINK0 against the LINKs
> > 
> > We so far don't have an ID for physical IOMMU instance, which can
> > be an alternative to return via the hw_info call, otherwise.
> 
> intel platform has a kind of ID for the physical IOMMUs.
> 
> ls /sys/class/iommu/
> dmar0  dmar1  dmar10  dmar11  dmar12  dmar13  dmar14  dmar15  dmar16
> dmar17  dmar18  dmar19  dmar2  dmar3  dmar4  dmar5  dmar6  dmar7  dmar8
> dmar9  iommufd_selftest_iommu.0

Wow, that's a lot of IOMMU devices. I somehow had an impression
that Intel uses one physical IOMMU..

Yea, we need something in the core. I had one patch previously:
https://github.com/nicolinc/iommufd/commit/b7520901184fd9fa127abb88c1f0be16b9967cff

> > QEMU then does the routing to assign PCI buses and IORT (or DT).
> > This part is suggested now to move to libvirt though. So, I think
> > at the end of the day, libvirt would run the sys check and assign
> > a device to the corresponding pci bus backed by the correct IOMMU.
> 
> and also give the correct viommu for the device.

In this design, a pxb bus is exclusively created for a viommu
instance, meaning so long as device is assigned to the correct
bus number, it'll be linked to the correct viommu.

> > This gives an example showing two devices behind iommu0 and third
> > device behind iommu1 are assigned to a VM:
> >    -device pxb-pcie.id=pcie.viommu0,bus=pcie.0.... \   # bus for viommu0
> >    -device pxb-pcie.id=pcie.viommu1,bus=pcie.0.... \   # bus for viommu1
> >    -device pcie-root-port,id=pcie.viommu0p0,bus=pcie.viommu0... \
> >    -device pcie-root-port,id=pcie.viommu0p1,bus=pcie.viommu0... \
> >    -device pcie-root-port,id=pcie.viommu1p0,bus=pcie.viommu1... \
> >    -device vfio-pci,bus=pcie.viommu0p0... \  # connect to bus for viommu0
> >    -device vfio-pci,bus=pcie.viommu0p1... \  # connect to bus for viommu0
> >    -device vfio-pci,bus=pcie.viommu1p0...    # connect to bus for viommu1
> 
> is the viommu# an "-object" or just hints to describe the relationship
> between device and viommu and build the IORT?

Yes. Eric actually suggested something better for the relationship
between pxb-pcie with viommu:

-device
pxb-pcie,bus_nr=100,id=pci.12,numa_node=0,bus=pcie.0,addr=0x3,iommu=<id>
from:
https://lore.kernel.org/qemu-devel/9c3e95c2-1035-4a55-89a3-97165ef32f18@redhat.com/

This would likely help the IORT or Device Tree building.

Currently, ARM VIRT machine doesn't create a vSMMU via a "-device"
string, i.e. not a plugable module yet. I recall Intel does. So,
you guys are one step ahead.

> I'm considering how it would look like if the QEMU Intel vIOMMU is going
> to use the viommu obj. Currently, we only support one virtual VT-d due to
> some considerations like hot-plug. Per your conversation with Kevin, it
> seems to be supported. So there is no strict connection between vIOMMU
> and vIOMMU obj. But the vIOMMU obj can only be connected with one pIOMMU.
> right?

Yes. Most of my earlier vSMMU versions did something similar, e.g.
one shared vSMMU instance in the QEMU holding a list of S2 hwpts.
With this new iommufd viommu object, it would be a list of viommu
objs. Eric suggested that HostIOMMUDevice could store any pIOMMU
info. So, compatibility check can be done with that (or the old
fashioned way of trying an device attach).

The invalidation on the other hand needs to identify each trapped
invalidation request to distribute it to the correct viommu. This
is also one of the cons of this shared viommu model: invalidation
inefficiency -- there can be some cases where we fail to identify
which viommu to distribute so we have to broadcast to all viommus.
With a multi-viommu-instance model, invalidations are distributed
naturally by the guest kernel.

Thanks
Nicolin

