Return-Path: <linux-kselftest+bounces-18427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA999879F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 22:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F87B224B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC92175D53;
	Thu, 26 Sep 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNqnV/Mv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C667156F20;
	Thu, 26 Sep 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381025; cv=fail; b=tmkBASkyiIqfRQo+zxVGt/G5KV1PTIaDsv5aHzDyPFdQkkTj/9ks4bcVgSxOfV8avYsa6RxpHo7iU2OQgUzco9oM2/EKBRL1P9TsFmgdfAeh8+1fjeT4dm7aekPiNkeJ65XGSu2sUI5CNA7dlHd8Yq1veNPHVNkycOg4I4z6W2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381025; c=relaxed/simple;
	bh=oaJcGONoSvAAT12Nce/1gHLIMcPYxGqti+6eoanZBcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6vZiyjgwknyR1gfi0zKbyzM9VT4tdKdg2mbPPDQBU03O5BgOlnCyO4Ay7zNmVTqHny6RWeIZx0HU6l7vaUdwyTGjZpIoRBpn5D+XYt4lupVXqQBV4/4JHSbQ81h/wbpTukUK+Ek5TeL2UsoWwPVW28jtgFYiODoC/MR05O4uxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dNqnV/Mv; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXj9XIFW05UJJETyO92Wh+eyKDF1UxmTibMyi/NgJB4il0MhnSl37qubvrhqv+pYket5knYzz8EzGETAyjmkimpZiumX9Xm+RYuCPflbzprhhcd2wKGnPzKa+kR8CAGSA4N/mx5wbVrYPkHe9aE0HUvvLk7qc9Lb3S3qwoQpqeyZKM21oG1ABvy1kJQjjXjMUS+Ufd31FhcwHczDRuCm+wFzZf7a1IhTNPTpK1Q446RsilRy81QJIqm3TWlg307Bt+hWq+yI06nbZFwbKTd6YBGEY7n6MjxHzHwlMfYSFw7nOMhBrBftUhbzk1H6uJ6Z60LxxZwlbi/V4X/h/2ZFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+xtz7jA7y/0+6btgWpg34v1FqG4ulrjiUL/VI7da+c=;
 b=xrYrYTB/VysIV3t++fy3piII5VmjsBFf2hi3tWBk1NZ5x5E61cPBSDZ+dPfjbhvxYzyjwdXSGTtv0uLcNqlthQsSAdwwpYGyDY/0lK43gUf61WDoz6cS9yVfaiFH0XKm7H2NZMuXWX1xlxH20ecf7dB0WWLos3k5o5lcTd4wBKMZ9JSZXHOPQGTxQffT+ao/mOdFRd3jFTxGzIkoksD4ecMUwd+e81MM1qarkbVfIZfEozV2+lWs0UU2QToN85D/LAp0mX8dGmPIZAmTysf2OHE1PXCqIwtYFn5KE51fcwALGO2NLU3lcbGRB2KAhW0irUWlnfWJDhCIVR7v1k3/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+xtz7jA7y/0+6btgWpg34v1FqG4ulrjiUL/VI7da+c=;
 b=dNqnV/MvZfFMXHx80niVkcPSv4GphFv5NmrFRtWdEw4ZldAqQqciA8sDIdJ81mMMCvZf4Hhp5/of/Rx0raBGzH24pm+rxk2nmdmquWiORI6r9P/ppwVOS4takG9AA1VqTkB9sHohQ2bXb1gsbLn5f3gUEKERBTkoV5E5uhDDkgqBJJ6go03QZH6FPxBhq9LbHGkmHnB8eOqO39w1lWQeZ/3y0A3tcvLKl8OQs3wGFG422ucXwnbtKtZyz3KK1i82JeuCucHTLODLwE6EuKH5d6CkbJ57hDTjSA929pURRCO1FQ+0GpLgBB+vu9WqJFKR6d7MHVkUj43OSOQRL2KaUA==
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 20:03:39 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::55) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Thu, 26 Sep 2024 20:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 20:03:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 13:03:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 13:03:20 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Sep 2024 13:03:19 -0700
Date: Thu, 26 Sep 2024 13:03:18 -0700
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
Message-ID: <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f686bc2-3afd-42c5-c6ea-08dcde66501c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9RkiUUYnvuDGQ555TjTKJS8Q9iTIT5h3+UsEVshECglFwlmXPS2vfyZyTjhg?=
 =?us-ascii?Q?1DwbtfSiqjH7lKBqWb3TwIs/ah2y0Tuj8mWYNwz95eSYZJNymf/KOHa9U8B4?=
 =?us-ascii?Q?472hEMJ9tTOUdUwsx1/NAx81JQmtxR7BZXZjXxeVj1FJgtzl9HHfnEyzp3mP?=
 =?us-ascii?Q?z+RAAYgxMOQhQsZ9q/xRzprhfoir0xGYleQUWjPuyPlXz+fNCozNcvZu8OmY?=
 =?us-ascii?Q?qIhbBpyeLnsY1OGFQ3O5UttY/NAt4suYk5iD5eehz9dIW8uiGX1mUy0FHX+R?=
 =?us-ascii?Q?KdCB7v7YfSXtIEEmkzumZ5U8+G8vWjflcykVpbTCEft/ZhrcCIIRXRIKE15r?=
 =?us-ascii?Q?Dg44MFhZNfLqkuvLbm4NYlwOtLlZ58cZZYYHponZcl5yKCN90PHUAaH/3f3O?=
 =?us-ascii?Q?W6zLtbT2tCMIdS4G7aUmqKYUoPqaA4OuYHOhuLG6oZ3UqBL1IlYyfglygKnn?=
 =?us-ascii?Q?uFTXy5eTpXI3eB8R3/85ICUb5TPsLtA2kJwlqfuqPrry2klT9pwmyBQxxhG4?=
 =?us-ascii?Q?GhWjXCRbEjPR9fmMzLYdLzUQov8JkrFqWfoe4p+BK1TU6/ebSMEionB6oUYF?=
 =?us-ascii?Q?6mVCsBQY3dDmZEjFJs3OI4Ao9sbyNp7g3qe2nHtmYiJXoD1X+RJGJFDGuXUO?=
 =?us-ascii?Q?LEi04wfeASs+T6jXAaASj8R9bKmVnfV9hbcQGj+A5A8EfIY2vzDE13LxCHRc?=
 =?us-ascii?Q?ISMzSS0Il7fjc+kU+ImKn2oFYGR6oDwCQsYrSB15BkHG6ksBxlwvxqQgbuLW?=
 =?us-ascii?Q?+9jApdGfcpctWOb0MStuG5NysIz9ST7wCZQi80DD+Vl2u0+w/epFbOajQ/oJ?=
 =?us-ascii?Q?AdgVFtJ/+hKmnZnYwQPeJQAdyAWt909AroIUHIM/xoX44ttHA3kWC2r/Uc/6?=
 =?us-ascii?Q?+chSr+qB4AVxKbz/fN1+UZhm/P4nxxe3TAHF6KqlcGWhsKapJ4+P65LF9LaY?=
 =?us-ascii?Q?M9Yhiu+NOO3hn6xuF+5dHPGmJkozOPaQTrnwJLbVdG+PypZm6k1Hfxc6oQsv?=
 =?us-ascii?Q?o1qhzflHhiaFJARiK9v1/GZbXxHSEqr7zl6IYlobI33SwC246rMxFgfMeseZ?=
 =?us-ascii?Q?jjymZbpIh76tNbKvzyuyRvQK1Iak09OuT5y2unNVjGtQ3W4/fpB6nELYbl8D?=
 =?us-ascii?Q?/gRTaraCQ2uD0TAHi36VmetzF0bG1B7B7vp7VakZr6Yrs4GNZU779lycPyk5?=
 =?us-ascii?Q?jv60XaqzB/Cpb+7kbrRsgDf5I/DGciXOZdkuYxc0zmjNtOYpB6SHkwpa+4rp?=
 =?us-ascii?Q?NmEJ9eoYe6/HnYjxhPyLFPGU95BWiRMWoZniYjJS65oF9sVOB+0h/frJ7pKJ?=
 =?us-ascii?Q?lTnus1bBQ4ewSaeBrXnrHGT+Weuhny2S0Ep3+KjR9BFDiE5DLbSKJNzH6iY5?=
 =?us-ascii?Q?8LLbPyNgL7cQWALlFfV8x4RW+77k8+063RTuZ9NAV3gF7aTJS3apCHt/Wmd3?=
 =?us-ascii?Q?sgfT426NPWIkLe6fobPQhBRcTPfh/c2a?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 20:03:39.0923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f686bc2-3afd-42c5-c6ea-08dcde66501c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

On Thu, Sep 26, 2024 at 04:47:02PM +0800, Yi Liu wrote:
> On 2024/9/26 02:55, Nicolin Chen wrote:
> > On Wed, Sep 25, 2024 at 06:30:20PM +0800, Yi Liu wrote:
> > > Hi Nic,
> > > 
> > > On 2024/8/28 00:59, Nicolin Chen wrote:
> > > > This series introduces a new VIOMMU infrastructure and related ioctls.
> > > > 
> > > > IOMMUFD has been using the HWPT infrastructure for all cases, including a
> > > > nested IO page table support. Yet, there're limitations for an HWPT-based
> > > > structure to support some advanced HW-accelerated features, such as CMDQV
> > > > on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
> > > > environment, it is not straightforward for nested HWPTs to share the same
> > > > parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.
> > > 
> > > could you elaborate a bit for the last sentence in the above paragraph?
> > 
> > Stage-2 HWPT/domain on ARM holds a VMID. If we share the parent
> > domain across IOMMU instances, we'd have to make sure that VMID
> > is available on all IOMMU instances. There comes the limitation
> > and potential resource starving, so not ideal.
> 
> got it.
> 
> > Baolu told me that Intel may have the same: different domain IDs
> > on different IOMMUs; multiple IOMMU instances on one chip:
> > https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
> > So, I think we are having the same situation here.
> 
> yes, it's called iommu unit or dmar. A typical Intel server can have
> multiple iommu units. But like Baolu mentioned in that thread, the intel
> iommu driver maintains separate domain ID spaces for iommu units, which
> means a given iommu domain has different DIDs when associated with
> different iommu units. So intel side is not suffering from this so far.

An ARM SMMU has its own VMID pool as well. The suffering comes
from associating VMIDs to one shared parent S2 domain.

Does a DID per S1 nested domain or parent S2? If it is per S2,
I think the same suffering applies when we share the S2 across
IOMMU instances?

> > Adding another vIOMMU wrapper on the other hand can allow us to
> > allocate different VMIDs/DIDs for different IOMMUs.
> 
> that looks like to generalize the association of the iommu domain and the
> iommu units?

A vIOMMU is a presentation/object of a physical IOMMU instance
in a VM. This presentation gives a VMM some capability to take
advantage of some of HW resource of the physical IOMMU:
- a VMID is a small HW reousrce to tag the cache;
- a vIOMMU invalidation allows to access device cache that's
  not straightforwardly done via an S1 HWPT invalidation;
- a virtual device presentation of a physical device in a VM,
  related to the vIOMMU in the VM, which contains some VM-level
  info: virtual device ID, security level (ARM CCA), and etc;
- Non-PRI IRQ forwarding to the guest VM;
- HW-accelerated virtualization resource: vCMDQ, AMD VIOMMU;

Thanks
Nicolin

