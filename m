Return-Path: <linux-kselftest+bounces-32055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A45AA5800
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 00:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007791B64D4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EDD225A22;
	Wed, 30 Apr 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dyx3/WX9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A51DE3D6;
	Wed, 30 Apr 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746052781; cv=fail; b=DhVnxS1gQnOnYLpHolnEafPHpOPwhSqjHzU+FmXYvybSOyVKJ7RMfzOsrtF4y/1vBRfCtUZDjuGFwiwiO+8pa9vHIUfgGVlht8a6+gTEpu1i9cQht8pH3VCew7w860H5FaswXphazmww38nHIFIC5FlTxCbDMbas0c73i0cqG9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746052781; c=relaxed/simple;
	bh=xtnOocQNfzyIs7726n2AxBkQmQLpeNzP4bTg2rVBF2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO6lMV3bGVlbcWkdCTW0hrlEgoei8C9yokg7T9RT57N1Zj/dT3koBsEHHbAcocYw4/qHQoMYwz7b+gMF/OSYp1W47rJH0txYf7zSfmY9h+MVODks+ER5YS+wvSvNtRSBNTNK3+GNcE1R4+n8PLRuHabKpMUISt27MYS664IlslE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dyx3/WX9; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNRug9VWBdQ0mlR8V8G1nlAuEDrIOyhngwyFLi64E8PObWA1GQX1t8h3ev2pcUarUkunEsW3pmuIR+1xNqjz0PSOgv235eiAJywKjwosdMqtE3NpmEWHqeiuTyEwTJeo68AqdigP9Hd8O89XGugtNT7jZnvtmzDJRw/+IosJWgqdcdL83hMfPdNCscAXORFEydTDYqiUtN2yGUXdldUGyXuRI90x1CeKdpKYiA/FIZfjk5I0zXXiLzQMpITkaNqtPjYjg/EI5Jv41qwtXEMAR8PJJK9FF9cxtREn9VnpHWe0Jc9d2d8jV3AoW9kQpa5w42CtNoaFLH6N7DUOa6cAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg721qSBt0OcdG25gW1xtPszXA5oXbM6A4K01+iJLEo=;
 b=XBSQeML6tOFdsxU/r6aoSRnTe66vkynipa3clR0ZJhRVombkkhPD6JMUtTr0ckJhOD4utNaSd2S+gVyJ+SOAFswvbR9Chug4VsrH8KmyI1VFTNiuJhWcWFJRNhrvRGhmJ1RA5zRWk0pArSlAfnkvrC4EZ8uC+9IIKSCXWgAAPWHzFS9NkbI84z4OLVMcKiTHxmGR0w/VyNdUrM0Y/W/DW2GyDCYc64Mt0wsHnbvy51IITUVQMOa65ZXce7//TYheBCP+do3v4TdHICmzTizs8I+do46dAvVbf4STqs3cjre7l5sTNdeaMq693d31AmCdNhR5qzn8k7R/yXM528q4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg721qSBt0OcdG25gW1xtPszXA5oXbM6A4K01+iJLEo=;
 b=Dyx3/WX9+DgsWCp0EKtpLCL8dmu6B4jtBV9lUB69YQV+j7vIhArUEc+ljw39N/TnIpCHNdaIGuugP84wUhN5VwsUIoAjVBGDy8AcYs/7qKuswlc9+LRx1GSXByktJUmoM/wx1dfVwfMsgzHqds2fZxok7LkprI1m4ahc0znoPRl9pDbZ5PEJsG4Dpi1LEQKcBhLKSlR0VxYaZQTaZekVE4WyOTn+VMpb4IW+7YBCMQATC6P+XoTTD8umZhj9hRzFZe3uAHmiCl7f4FqDA4TR/DJpGq/cjH7gRCow0hQL0/V4cfMuLtySHLnO/MoNMgKXhBvvOrYZ3GimayYgbVJLlQ==
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 22:39:34 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::59) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 22:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 22:39:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Apr
 2025 15:39:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Apr
 2025 15:39:19 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 30 Apr 2025 15:39:16 -0700
Date: Wed, 30 Apr 2025 15:39:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBKmk6PNFreeyfLh@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
 <aBKdMaFLPFJYegIS@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBKdMaFLPFJYegIS@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: f8929ea3-7066-4528-46fe-08dd8837e0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qmE329Im17JaOPTKJmU/rYr1/weMyLjHD0Mg0EH4/3onzZdf4VQaDYkn869T?=
 =?us-ascii?Q?mQuShQsCucNrgOcUZQE0ATk4GnBCSc8+a9baky2b0dlAUZtkIAh1WQGYFAdh?=
 =?us-ascii?Q?L4MC9QclkknDVpg0UhLdy5DmM5mjUIMbQe64XSOUWKflj7CyHAkpzQKQiyNk?=
 =?us-ascii?Q?ePz/Ezh3Fx7079QyYYfbmqwY0moaq/gnscx1bmNaO0CCss28gj1itHptIbsr?=
 =?us-ascii?Q?7Humx97BKJ1HMuaVLAZYVHRsy2oPtktIVCCJm/OO4xwL1LI9xJTUg7TA20df?=
 =?us-ascii?Q?rLpPNMo3VKeHcuKYcGNbQQMAjFl3xu3CMmj7QKhzhs84R5uPIFaKr4KjLmeG?=
 =?us-ascii?Q?+E9qi4UknvYgi31176Fi2p5Ed1M8X33aexbzOyDkQQ6NhXqWgYmDaU1J00ou?=
 =?us-ascii?Q?0dlEJehXyMo+VQEbqny0hWe6jFrrETapVfoD0iA6tRc5M+dsTohRmBy0zBPD?=
 =?us-ascii?Q?8WgYulZ5KehuzrZV9fYVMitwvp22uWddAZF+dietJTMJuTsWIE0E8L/uKLrS?=
 =?us-ascii?Q?bo/W7zjZBRAilInY+TIz01vwnMLas5DwKgxpRm+RDr3TO5sf77m49F3XVjlf?=
 =?us-ascii?Q?Zj11n/pCOUdpFV/QdKPVAhMeP6JkKO11csXWqqePDGhoYiR02xTLHjJ5nAA4?=
 =?us-ascii?Q?Da0YBVII0ftyB5VMllDvi5DCEhNCEXz4I84jHgrMyp/y+mkBeR3M+cx9Eow/?=
 =?us-ascii?Q?wOyN2BuJGmZQxE61uytMhJ7dN+aGxBfsZDpJz4dPyfWqC3hulqSInYWeRcW5?=
 =?us-ascii?Q?ABL3ITTWUxMxAsq15jlTQUeT2MQOjW1XADx3EPJGLNPy3BE/yJvnS9k+z4du?=
 =?us-ascii?Q?20YAt2h8RSgJVLMHU4GRZjvvOyxsBO/LEhtHysIl+Nh09Od/JZo4svQ5s9G4?=
 =?us-ascii?Q?6dtRVerVjDWL1F3He89Qvzar4JUUJ575I0WGWwXT/Lp8cMYbmW8yZJTGPn7g?=
 =?us-ascii?Q?6sz2kBwNpTBlmgn7W2FyQgKux6esEboCsyNAKv5UMctna9UjOMhBQ1c6nv9R?=
 =?us-ascii?Q?4W8KGQj5bhLtIRaCUIPUW+tluSL5WCURmmtHKbjW8OdkNwrbOQjJ/koqoO3s?=
 =?us-ascii?Q?2wdy05vdE8MSD06hDOCvwbNxf+AToB5NHVhp0VL4wpP19OoWNFutb8Lb572I?=
 =?us-ascii?Q?SceuMKuy/Pp5754cs6+zTpKXQIqXZrTgQT9JR0uynnDW0OJHAC5oETW3Wo3G?=
 =?us-ascii?Q?lXCZbwC6lxlhNJ0/+r7PeyEnz69/LS2h19yVnnJyOwHI6PJ8esixK1J/Vz8e?=
 =?us-ascii?Q?1I32LE0U9m4FdOl9f0SlWiD4FYDB1ZFDMlco+sO1kjATDvUFC7Ag5uPWVIEc?=
 =?us-ascii?Q?akHddh75nkrB4w3cGKtos5dwRWjnu2LeHetxrs7VzmQDMrqgLeWImzj31b9I?=
 =?us-ascii?Q?81IyjVOdN2iHUaMzcNzPK1jjZAnnuVt3MuXYOgAEGWcR0IqbZ7UtjJ/jp9xa?=
 =?us-ascii?Q?yBOOf8TTi/EPqlFyV18wPn6zANjH2f1cVw5qKP+KoTlyR3l1HjNeFRuLPuSz?=
 =?us-ascii?Q?IpjfV71957sr1O6QdEgvxr4acJEjMsCssmcf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 22:39:33.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8929ea3-7066-4528-46fe-08dd8837e0f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666

On Wed, Apr 30, 2025 at 09:59:13PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:58:16PM -0700, Nicolin Chen wrote:
> > The CMDQV HW supports a user-space use for virtualization cases. It allows
> > the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
> > and executes them without a VMEXIT, as HW will replace the VMID field in a
> > TLBI command and the SID field in an ATC_INV command with the preset VMID
> > and SID.
> > 
> > This is built upon the vIOMMU infrastructure by allowing VMM to allocate a
> > VINTF (as a vIOMMU object) and assign VCMDQs (vCMDQ objects) to the VINTF.
> > 
> > So firstly, replace the standard vSMMU model with the VINTF implementation
> > but reuse the standard cache_invalidate op (for unsupported commands) and
> > the standard alloc_domain_nested op (for standard nested STE).
> > 
> > Each VINTF has two 64KB MMIO pages (128B per logical vCMDQ):
> >  - Page0 (directly accessed by guest) has all the control and status bits.
> >  - Page1 (trapped by VMM) has guest-owned queue memory location/size info.
> > 
> > VMM should trap the emulated VINTF0's page1 of the guest VM for the guest-
> > level VCMDQ location/size info and forward that to the kernel to translate
> > to a physical memory location to program the VCMDQ HW during an allocation
> > call. Then, it should mmap the assigned VINTF's page0 to the VINTF0 page0
> > of the guest VM. This allows the guest OS to read and write the guest-own
> > VINTF's page0 for direct control of the VCMDQ HW.
> > 
> > For ATC invalidation commands that hold an SID, it requires all devices to
> > register their virtual SIDs to the SID_MATCH registers and their physical
> > SIDs to the pairing SID_REPLACE registers, so that HW can use those as a
> > lookup table to replace those virtual SIDs with the correct physical SIDs.
> > Thus, implement the driver-allocated vDEVICE op with a tegra241_vintf_sid
> > structure to allocate SID_REPLACE and to program the SIDs accordingly.
> > 
> > This enables the HW accelerated feature for NVIDIA Grace CPU. Compared to
> > the standard SMMUv3 operating in the nested translation mode trapping CMDQ
> > for TLBI and ATC_INV commands, this gives a huge performance improvement:
> > 70% to 90% reductions of invalidation time were measured by various DMA
> > unmap tests running in a guest OS.
> > 
> 
> The write-up is super helpful to understand how the HW works from a high
> level. Thanks for explaining this well! :) 
> 
> I'm curious to know the DMA unmap tests that were run for perf?

tools/testing/selftests/dma/dma_map_benchmark.c

> >  /**
> >   * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
> >   *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> >   *
> > - * @flags: Must be set to 0
> > - * @impl: Must be 0
> > + * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
> > + * @impl: Implementation-defined bits when the following flags are set:
> > + *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
> > + *          Bits[15:12] - Log2 of the total number of SID replacements
> > + *          Bits[07:04] - Log2 of the total number of vCMDQs per vIOMMU
> > + *          Bits[03:00] - Version number for the CMDQ-V HW
> 
> Nit: It seems that we deliberately chose not to reveal `NUM_VINTF_LOG2`
> to the user-space. If so, maybe we shall mark those bitfields as unused
> or reserved for clarity? Bits[11:08] - Reserved / Unused (even 31:16).

I think it should have been there, but kernel should just report 0.
                 Bits[11:08] - Log2 of the total number of virtual interface

> >   * @idr: Implemented features for ARM SMMU Non-secure programming interface
> >   * @iidr: Information about the implementation and implementer of ARM SMMU,
> >   *        and architecture version supported
> > @@ -952,10 +965,28 @@ struct iommu_fault_alloc {
> >   * enum iommu_viommu_type - Virtual IOMMU Type
> >   * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
> >   * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
> > + * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
> >   */
> >  enum iommu_viommu_type {
> >  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> >  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
> > +};
> 
> This is a little confusing.. I understand that we need a new viommu type
> to copy the new struct iommu_viommu_tegra241_cmdqv b/w the user & kernel
> 
> But, in a previous patch (Add vsmmu_alloc impl op), we add a check to
> fallback to the standard type SMMUv3, if the impl_ops->vsmmu_alloc 
> returns -EOPNOTSUPP:
> 
> 	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> 		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> 			master->smmu, s2_parent, ictx, viommu_type, user_data);
> 	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> 		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> 			return ERR_PTR(-EOPNOTSUPP);
> 		/* Fallback to standard SMMUv3 type if viommu_type matches */
> 		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> 					     &arm_vsmmu_ops);
> 
> Now, if we'll ALWAYS try to allocate an impl-specified vsmmu first, even
> when the viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we are anyways
> going to return back from the impl_ops->vsmmu_alloc with -EOPNOTSUPP.

That's not necessarily true. An impl_ops->vsmmu_alloc can support
IOMMU_VIOMMU_TYPE_ARM_SMMUV3 potentially, e.g. an impl could just
toggle a few special bits in a register and return a valid vsmmu
pointer.

It doesn't work like this with VCMDQ as it supports its own type,
but for the long run I think we should pass in the standard type
to impl_ops->vsmmu_alloc too.

> Then we'll again check if the retval was -EOPNOTSUPP and re-check the
> viommu_type requested.. which seems a little counter intuitive.

It's just prioritizing the impl_ops->vsmmu_alloc. Similar to the
probe, if VCMDQ is missing or encountering some initialization
problem, give it a chance to fallback to the standard SMMU.

> > +	/*
> > +	 * @length must be a power of 2, in range of
> > +	 *   [ 32, 1 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]
> > +	 */
> 
> Nit: 2 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) to match the comment in uapi

Alok pointed it out too. Fixed.

> > +	vcmdq = iommufd_vcmdq_alloc(viommu, struct tegra241_vcmdq, core);
> > +	if (!vcmdq)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	/*
> > +	 * HW requires to unmap LVCMDQs in descending order, so destroy() must
> > +	 * follow this rule. Set a dependency on its previous LVCMDQ so iommufd
> > +	 * core will help enforce it.
> > +	 */
> > +	if (prev) {
> > +		ret = iommufd_vcmdq_depend(vcmdq, prev, core);
> > +		if (ret)
> > +			goto free_vcmdq;
> > +	}
> > +	vcmdq->prev = prev;
> > +
> > +	ret = tegra241_vintf_init_lvcmdq(vintf, index, vcmdq);
> > +	if (ret)
> > +		goto free_vcmdq;
> > +
> > +	dev_dbg(cmdqv->dev, "%sallocated\n",
> > +		lvcmdq_error_header(vcmdq, header, 64));
> > +
> > +	tegra241_vcmdq_map_lvcmdq(vcmdq);
> > +
> > +	vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
> > +	vcmdq->cmdq.q.q_base |= log2size;
> > +
> > +	ret = tegra241_vcmdq_hw_init_user(vcmdq);
> > +	if (ret)
> > +		goto free_vcmdq;
> > +	vintf->lvcmdqs[index] = vcmdq;
> > +
> > +	return &vcmdq->core;
> > +free_vcmdq:
> > +	iommufd_struct_destroy(viommu->ictx, vcmdq, core);
> > +	return ERR_PTR(ret);
> 
> Are we missing an undepend here?

Right. The iommufd_struct_destroy doesn't invoke obj->ops.abort().

The whole revert flow is wonky, missing all the unmap/deinit steps.

> > +static void tegra241_vintf_destroy_vdevice(struct iommufd_vdevice *vdev)
> > +{
> > +	struct tegra241_vintf_sid *vsid =
> > +		container_of(vdev, struct tegra241_vintf_sid, core);
> > +	struct tegra241_vintf *vintf = vsid->vintf;
> > +
> > +	writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(vsid->idx)));
> > +	writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(vsid->idx)));
> 
> Just a thought: Should these be writel to avoid races?
> Although I believe all user-queues would be free-d by this point?

Yea. They should be. I will change them.

Thanks
Nicolin

