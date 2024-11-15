Return-Path: <linux-kselftest+bounces-22125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D569CF99B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 23:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9681F20621
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 22:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2371FB726;
	Fri, 15 Nov 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ocEo32kT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B618FC85;
	Fri, 15 Nov 2024 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708471; cv=fail; b=PfB1VkpjS42OpyD/qiU54RZ8xi3xSEMzLwY2Y/JzUjCdPQfOtvI3NM5sEIQSdztNDX6e9a5P/OW8yEKQFqy7+U52nVQgCPto7VyF3SNFUZvYbze1WYQpkcFlX7XCa+kfO6ylWuZd4DANo9lxLmXMh+R7hOgEenb82Q4bZS5CQcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708471; c=relaxed/simple;
	bh=nyODJze3mDc7/HVEB+B0kaPDBpiucJtoIuHo61wYeQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrHtbflseVNfCgesyj8xvKyjxLQH9O3gTfEbIiK1sUeFILSS2auEoKiv911NYt0loFBYCIaD0svGzFanR5uupSeE5crCzFsO0YSC6sE1y7yAcN7lprPTbFXSoEpizh3i2IvvI4T3/OH7C4EZ1SK23jEd6rAh3qJFWX7T0czc1iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ocEo32kT; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9MiPUdDABoKZbTmq2afLvWwiKpDeQcHTZwOT4pgk3QLl/PyLc/0Q4CNepTGvtHizlunZUbtqk/meATNx9iLKpkUKBTz8sTineAFsQQ16xua17shJtalMzpHW/FnDXASoADLeDOEWiOjaR+sipXz3TYuSPE+XKgMdj14GMiYr+e6vJyH7TwmYiqoHYnypet67ZvSRrdPL8nkPZyoje065zkRUueWprJsNByfTCa90JeH3aISVRFS40AQ8YcXVhn23yVEqOwnDvAOPdtAgiRLfqlNtRWNpc8D1K1fIG8UQwKKwjSBX1yxADs52/PqRuQH0l/ToRYgx3WimGqUIr4BHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9YCAIyUXuiy3ZA3JcO80lK2jziJI6MXACvAflD25BQ=;
 b=WQj7qcuSoqal1dKG35NSUdanwS2ltm4Kn7ntZMni6YGfqAhP49xCcjYYXJpljQK2F2mugPqvJuU94t+jJNxbJAp40HXzo1C0CaqCAwyGmv0foiF6I/UIWZhvQv1RYKbxNvSABfJq4qhuN0u837UBvWd4ENjLso7UGNA/ppglPzL0wndXTbCAKeTsm+f9X/7lc36AMgGNjqrv92DCy1HxOA89LsG1BYqN8BBVsIhyYGrBiZqxj/HsZcLiXRHZP3R8vKfmIaAoUi45hyNUX+JBO3VhGnYpbQa8p822Ikazv8+s47H0lCtgOckCJqii0/6D3ND/EqhVXEb33/jsKEzCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9YCAIyUXuiy3ZA3JcO80lK2jziJI6MXACvAflD25BQ=;
 b=ocEo32kTu9Vyd4erMCZ/FVvL8amakx3A1wN+EqBDrctjfBGEVlF1tShR1embtH61hx2bHOu8pDXslh8ADD1MbsdFfAGjV+rAdRYd7P+emt5JWk+ecbprIBrn9m3tfevC7KnZnen78lVPhZFc2uTOmwEv4rC6/mEXzW0G1cFPKWqZ7Kn4i292nkhCqNY6xY6ENxByLAnH9S2nVg5NlL8dnnj3fkvUj6K0EyXvkN02Sl/xwQ0/bEvEX1ZkNcPxrmyz7akTU5XkInRzwRssiW44BsPw6Ai45DPXtUlP+jZHoezE8PV6CSVp3aTGg5kdV8qzKIp9NY72Cn1WbOBoLP+Cqg==
Received: from SN1PR12CA0112.namprd12.prod.outlook.com (2603:10b6:802:21::47)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 22:07:45 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::2f) by SN1PR12CA0112.outlook.office365.com
 (2603:10b6:802:21::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 22:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 22:07:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 15 Nov
 2024 14:07:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 15 Nov 2024 14:07:43 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 15 Nov 2024 14:07:42 -0800
Date: Fri, 15 Nov 2024 14:07:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
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
Message-ID: <ZzfGLdgykZ0M3jy5@Asurada-Nvidia>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
 <ZzVB7Fun48rGztuV@Asurada-Nvidia>
 <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
 <ZzVsEmzc1UyDdi//@Asurada-Nvidia>
 <20241114162010.GP35230@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241114162010.GP35230@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 686b2038-7892-492e-4357-08dd05c1ef13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5Tex3tYQ2fhxkQyY/ErxcCo8S/7JqzQCtNvjRHB1sptL7HRHReqk8NKxgMv?=
 =?us-ascii?Q?4XAk6CRL5ri4iCsECVqg1OjL6nCVnCy8cmzWznxaw9b7gx/DQwE5z9UUItrO?=
 =?us-ascii?Q?ieiVXjWnGx0QsINZx4vIlwdRtY4kZ25m5mxFELk5EvMZa4X/WI2GAC1b1Kz/?=
 =?us-ascii?Q?7WnYCTpCapfeiUbeA7jA42Dtmgd5hSaYedlZk66DxFhDL0Gp1xNjA0ikvBQO?=
 =?us-ascii?Q?HeDQ4vBbpglW91jsnJM/Sq9cNJmhxQ4IBoMcwnEGC3vGoUUHVWN+93ZUYkZL?=
 =?us-ascii?Q?tNobHEO2hGMggfi8yMuflE/F5Qh0KNhsgOiaEDztkI04Hs5VWxU5J4sNEtQC?=
 =?us-ascii?Q?a9g+YHt3+LOyYr7jTiahz8r+El7u+oTvGi4l0DSVRLp38u2eL4lEzwNl/YIC?=
 =?us-ascii?Q?QLyQr1PudbWNbEe6c4zLjywBT6hcsWtKF4yr98qcDYxqPk7dLurVmFRFO2ab?=
 =?us-ascii?Q?8a+SwArW0UzCkkRCxMLwpqeUDFsKi6C3kzd5HqTLGzCDZqRgoluLbreQEVcJ?=
 =?us-ascii?Q?vLz22ihATiwwgnNtWvz/FLl8Mhk6M6+7S0O+ovy9nCEdSzyjvy1V6e7mnTu+?=
 =?us-ascii?Q?8FI2dZAS16kjreTllpGO16Ya5XTwI2yll8WphMyg8m1+9Qvfet29tbsSTjn8?=
 =?us-ascii?Q?7QrUWbQwHevGr41wdBm/TdNHU8aGtjvtP23VTO894ykrT/KW7+ODMy4WwOvf?=
 =?us-ascii?Q?hus9tpFPUrVu+RIqzPjL/ZiWPcmCTut1nHyg8XDJpwubCFSuibhuh1JQ34JM?=
 =?us-ascii?Q?a8SqRcJFZyk/Q6wlZRU9+uzHQyGf3z7VMXgCPWDoDlHM/WLWzxFz/1/rHrer?=
 =?us-ascii?Q?TDZdoAdFL/afXkoW1GQTJo23I98wJVIvf3dLaKOvG6YVyi67V27upJ/cAfV3?=
 =?us-ascii?Q?iUFaolnXhVxwKFYYcCHF7ukEz/5GYx6F2Fs88jcB8Ec9XSWBkZHvI+Y7IS1C?=
 =?us-ascii?Q?N14OUYgZEznoxjki6kN908AnkwRY6QRUxfosW7/8/v7qWvFeDhuA14uHAQ/M?=
 =?us-ascii?Q?Wn4U5NbPozgLS/p3nHXQUzQQ73eLbW6s6btUmY+Qq1PbscZ/LouRZV92TPcu?=
 =?us-ascii?Q?utGhxAQZ42vmoBMaJagC1ENjXJ5IKQr5sFDjlG4oIxuFTL8nXA9zPwmxqvCC?=
 =?us-ascii?Q?xZbfGNUwiBJi0HTCwELgFloe8e78ybcImCPCg/N6hTBRdY8d5mWVgv70y1C/?=
 =?us-ascii?Q?SD7G9GOrJv7oi5HiHESdB+oXDeb/0bA7b2sVighnz10m37OhAezinXYpDcYF?=
 =?us-ascii?Q?agoKq9sbHXfz5PbuR97o3ruDNNXc1sTEk7SfDt7b5yfBrnoIZP6qy7Qv5n2o?=
 =?us-ascii?Q?6oozMb2gfFR6lPHPcfWUlot60aZ0T9lj0ScLdhwpJVQz0ia1h4KhUu7xlThy?=
 =?us-ascii?Q?X47KxXT4Khx7leXwUc2OKNSVpOzPk86tqoOHVYK017Hm1Mh8rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 22:07:45.2916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b2038-7892-492e-4357-08dd05c1ef13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601

On Thu, Nov 14, 2024 at 12:20:10PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 13, 2024 at 07:18:42PM -0800, Nicolin Chen wrote:
> > > so the user would try to create vDevices with a given viommu_obj until
> > > failure, then it would allocate another viommu_obj for the failed device.
> > > is it? sounds reasonable.
> > 
> > Yes. It is the same as previously dealing with a nesting parent:
> > test and allocate if fails. The virtual IOMMU driver in VMM can
> > keep a list of the vIOMMU objects for each device to test.
> 
> The viommu object should be tied to the VMM's vIOMMU vHW object that
> it is paravirtualizing toward the VM.
> 
> So we shouldn't be creating viommu objects on demand, it should be
> created when the vIOMMU is created, and the presumably the qemu
> command line will describe how to link vPCI/VFIO functions to vIOMMU
> instances. If they kernel won't allow the user's configuration then it
> should fail, IMHO.

Intel's virtual IOMMU in QEMU has one instance but could create
two vIOMMU objects for devices behind two different pIOMMUs. So,
in this case, it does the on-demand (or try-and-fail) approach?

One corner case that Yi reminded me of was that VMM having two
virtual IOMMUs for two devices that are behind the same pIOMMU,
then these two virtual IOMMUs don't necessarily share the same
vIOMMU object, i.e. VMM is allowed to allocate two vIOMMU objs?

> Some try-and-fail might be interesting to auto-provision vIOMMU's and
> provision vPCI functions. Though I suspect we will be providing
> information in other ioctls so something like libvirt can construct
> the correct configuration directly.

By "auto-provision", you mean libvirt assigning devices to the
correct virtual IOMMUs corresponding to the physical instances?
If so, we can just match the "iommu" sysfs node of devices with
the iommu node(s) under /sys/class/iommu/, right?

Thanks
Nicolin

