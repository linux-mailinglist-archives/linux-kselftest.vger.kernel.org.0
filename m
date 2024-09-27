Return-Path: <linux-kselftest+bounces-18447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA0987E18
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 08:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4CD286952
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A315C126;
	Fri, 27 Sep 2024 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iZ2i9R7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E614A4E0;
	Fri, 27 Sep 2024 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416977; cv=fail; b=jG9eelLy+rZbRPeN0/4mSWTuOdwpRl1gwvxSGltWghtKi3eCPy5ZzfWDPX9XUy4bvHlk2/mc/JJ8o1wEwUnqcixTknYxFQi1F/3Qi14Vrf+WpcalGVEGAvvSZlhVRkZ8xoPG6eNBhOOsJfO1lWv6+vqplsEbJHJXuZq6fnkNg9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416977; c=relaxed/simple;
	bh=eaO+JPD3LgROeEqlIVirH/gBGaKeJV1frVLkLNTAGDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbt7y36MZxEz1V5OOB2x6xb1eYbLlPtUCEE91eMRnRCnDkJJEFNQopxU6kKrNtfTVA/Ssh7meAYjl4anqPnoFUjU7g+eMP8gd9pdcOi9jbGyQ1QqZ3GoIhW5nE3aXtY9dIDsreRfgorlcQNWFghrUP65GnB+3Y4pOgoURuXBCk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iZ2i9R7p; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpfcbiLAkDnBRXCCO3B4u6BywE38sMdEt1fOJA7lHjfSswL9T7zADDZLPsL0oIhzibgjjAtZICjdak5Ev79nI/K1uM6Yy2dgB0+HG+ad5/VyF6RM5/IuDptEh4AZkbIqMYT6ZucY2jeMJpHGoEn2L/u2h+h40NB2MCpzg9IpQ8LkjU+oUWDyOBN2tIYOBcSVTahXPdWYriE5bRBYQzfpELKqL0l5n64+ORrdphdTTXP07rnmvSMIbb977sH8YxYrsk/dsIrtXAaZV8tbWw9TLJACcGZ6vEnaOgQNuMoEHcYvFZzD1NM6GugEAu5/Z4SAYehWUzpuTEFHdvKfBHqAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU+xFOLfZnYiqpCnUnB43gRbGglj94v9a9FEHesPXx4=;
 b=Cl4aI+5pna667mcg7u1dcQAnX8Ss/4aaphSsphH4Zr6zMN0F1FaJNEnMcOHYwBMbz/enmkZiILKdP2v2qVM+jOUSfHLHCxZtcGJ077Pt5WKRhlAHz8kw2HDmiIVQzn0wHg8K2nkbw6Xrw1zV5FnOFVxfuocWoR6Qo0erwtKIMNW7FgdyX/hDBdu++JrVLBshSnbbzBvo5Ey7e6pw9SHfGMxnpqmbQ5M94H6mqliPKvsnX99udNRB7qXZo8cWV4GJYRRL6aEn75AB9qg0nEXXA4fBgkjHS44xpcghuU1CQXgYGGXtwpL7tV5xrsTCcdi6w6esw7zNlocvFO7Cb4K4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU+xFOLfZnYiqpCnUnB43gRbGglj94v9a9FEHesPXx4=;
 b=iZ2i9R7ppSaNQHtUbKdvZLojL4kZ0k4DrngQavZdXL1AVtMIGPJWG2eulMQyt/SU4i4tm+xjHsKQdtsodSHVW//0H7XCRrNQTKwX9hrj4VZ07ceAGufwSAWPJKDAdswTBgIHY16cxWb4pf0sqjR7Bl58puZMPdk+ilHAwXHkZvZfOpyMDMdPOKm4993Ma+aSZB8eV5JRFX1YnYkSe/FK+4q9aegt2Cg5gjz8TgwEgsfhZD87OQgdk1cT6sYvc+WHs/kxzIqO/BCoambEME86FoJ2/T1nfZgWtvE5KX9QeIoXWO9zQUoJo+gnS/9zWJe8Gy6T5Y0azoctNeJSZ21BXA==
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 06:02:50 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::3d) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 06:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 06:02:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 23:02:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 23:02:39 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Sep 2024 23:02:38 -0700
Date: Thu, 26 Sep 2024 23:02:37 -0700
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
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c42109f-fac4-4218-0d6a-08dcdeba04b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFR//xfocYupMilAgcKfJ1p+iXNcD3C4NMcqdNM0016XYJDerjqh1XqqxeUk?=
 =?us-ascii?Q?D1jB7HLFaVO6YFC1p0ZNjnxjc1N4AzE0vVOSj0pQY2eBlz0UrIgSLUU7+bS2?=
 =?us-ascii?Q?6FvfrxLMS+oVevxbSg+pJjUFJq6tCyq3T1/6T+1pBIWmlO9+GRIrp3FstFv3?=
 =?us-ascii?Q?cJrzn6hr2HPzfF0gljMgzftCQfgQwMrcH3eMFZZZZev1m1n5VhCcvgLumL3s?=
 =?us-ascii?Q?73P+oTNP09ZyX3WDP9gh33vo8kQnhFKU8DTZsxo9XHq/nKrLgWgOZEJsiO2y?=
 =?us-ascii?Q?q/Np0Lu8iE/Y77Zkyj47z1ZLoAA2CQFLsmu0ObEozBHo/3XtAbsk6ZVDu3LZ?=
 =?us-ascii?Q?mcN9ZaolNr68rsW2NBuSTRI0dzcqEz6ZZ8faWx+qcK8RzR+bzS3uMar4aXQy?=
 =?us-ascii?Q?gjnMn+2GlzuzK/r1oLGbNi57Nu5+87NAVfJvB3cRe1w5wz7OvC+FN4cWwCJ5?=
 =?us-ascii?Q?1kq1KaPirrTeC7Wf643Vq9ZAhQ5CSjAtig9pgYwRH8zbCIDxRtEvHzFKr3yK?=
 =?us-ascii?Q?Op1HGXMeN/WDAf3DC2zUFJ0QXVhM4eJCJCaMEEFhqEPOlvrCWrehZp73FkVT?=
 =?us-ascii?Q?qhH6/Zya5zsNRCkyGBhS/yHkEeftdxvC5WOotyJ6kJSvu0a+MYu1nidxK8DU?=
 =?us-ascii?Q?kZB3lEYwnLM10V74htO3H6BIgh2/f0vX/dnne3KLAWk/JgspB5vRJ3CikXfD?=
 =?us-ascii?Q?jPyZu72gNBRBs/Eg/+qdmR9Dzt8rmuc/gEjb+ZbuilXCXbUGj7BFCV76UmsX?=
 =?us-ascii?Q?qIcHwbib0/169YeDzyWFzBnRsIgSZD0BIpw+hAhwxv0TpCVGy1HLYSvohrlv?=
 =?us-ascii?Q?UU3rAWgker2Gk3a+VYV+D3GqvIcNAAgb/sSu0prZ27IKjEXq1axLpRqAlt1h?=
 =?us-ascii?Q?3ebiJrYIVCT+pHX4oAVOmQWo6k0mKKuu/2UtFPzVu6gqbsVmKsBtRfk/Mv5Y?=
 =?us-ascii?Q?xrn0s+sacSdaMdRXkaTMuC1a5tjT42axx6m5d6+Hiux1TrC9yC6HdRJjIonj?=
 =?us-ascii?Q?ERgVamBjRcjM4MLcUC/587JgHM4/AzDNRNHsp44SsyN5DPEVaw3e8vkunZWz?=
 =?us-ascii?Q?1v+Avv65Rsr5WZNFdRBGwpydNkxh+2upguxNuYbIFMVVMYWXj+3/0O8sz7D2?=
 =?us-ascii?Q?MIgE3uzLpaIdxSPOsY1NcKDXpzg/HF322G0Y+u8vIA+Vn5eBbqwRX0UU0FtW?=
 =?us-ascii?Q?GMl6tHlLdt2nPvOfSGvlb4EpjRuNjC7gdGK5W8933CmmXC+Z22ex7LwTGdB/?=
 =?us-ascii?Q?rsXwiCWUx3rf9xtrafpddz1uj2pHTevSpF4BNTq36a3+xUIamL3w57lnPT+y?=
 =?us-ascii?Q?Dd1nbTb55cwZNcFFsbKU4Oyc/xd7m+3gwGOsckQRtB6sNx4YTewWJ+tXsyv/?=
 =?us-ascii?Q?SDoBim871LmjlVbwUMgcMEwCAZH7DKy7twE3DbBzEJS6VrmXa003Sg5j73WK?=
 =?us-ascii?Q?L0xKlczd60Et5YC5E9H6yu/GwM1isTpP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 06:02:50.2956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c42109f-fac4-4218-0d6a-08dcdeba04b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

On Fri, Sep 27, 2024 at 01:38:08PM +0800, Yi Liu wrote:
> > > Does it mean each vIOMMU of VM can only have
> > > one s2 HWPT?
> > 
> > Giving some examples here:
> >   - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
> >     kernel holding one S2 HWPT.
> >   - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
> >     kernel that can hold two different S2 HWPTs, or share one S2
> >     HWPT (saving memory).
> 
> So if you have two devices assigned to a VM, then you may have two
> vIOMMUs or one vIOMMU exposed to guest. This depends on whether the two
> devices are behind the same physical IOMMU. If it's two vIOMMUs, the two
> can share the s2 hwpt if their physical IOMMU is compatible. is it?

Yes.

> To achieve the above, you need to know if the physical IOMMUs of the
> assigned devices, hence be able to tell if physical IOMMUs are the
> same and if they are compatible. How would userspace know such infos?

My draft implementation with QEMU does something like this:
 - List all viommu-matched iommu nodes under /sys/class/iommu: LINKs
 - Get PCI device's /sys/bus/pci/devices/0000:00:00.0/iommu: LINK0
 - Compare the LINK0 against the LINKs

We so far don't have an ID for physical IOMMU instance, which can
be an alternative to return via the hw_info call, otherwise.

QEMU then does the routing to assign PCI buses and IORT (or DT).
This part is suggested now to move to libvirt though. So, I think
at the end of the day, libvirt would run the sys check and assign
a device to the corresponding pci bus backed by the correct IOMMU.

This gives an example showing two devices behind iommu0 and third
device behind iommu1 are assigned to a VM:
  -device pxb-pcie.id=pcie.viommu0,bus=pcie.0.... \   # bus for viommu0
  -device pxb-pcie.id=pcie.viommu1,bus=pcie.0.... \   # bus for viommu1
  -device pcie-root-port,id=pcie.viommu0p0,bus=pcie.viommu0... \
  -device pcie-root-port,id=pcie.viommu0p1,bus=pcie.viommu0... \
  -device pcie-root-port,id=pcie.viommu1p0,bus=pcie.viommu1... \
  -device vfio-pci,bus=pcie.viommu0p0... \  # connect to bus for viommu0
  -device vfio-pci,bus=pcie.viommu0p1... \  # connect to bus for viommu0
  -device vfio-pci,bus=pcie.viommu1p0...    # connect to bus for viommu1

For compatibility to share a stage-2 HWPT, basically we would do
a device attach to one of the stage-2 HWPT from the list that VMM
should keep. This attach has all the compatibility test, down to
the IOMMU driver. If it fails, just allocate a new stage-2 HWPT.

Thanks
Nic

