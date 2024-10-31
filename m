Return-Path: <linux-kselftest+bounces-21231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1052C9B8063
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D481C21C65
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A71BBBF8;
	Thu, 31 Oct 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fP1jp8yR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23114BF92;
	Thu, 31 Oct 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392906; cv=fail; b=XCk8KKhVgUe7A4ovQOlFvhkXsMzNCNTbH811GrGfHUI5UhH09lSPwASKHbU5AM4bK47b/YMMRZjjdSbnm7Jodfb7s5b+Lyf8uaNvp6GblS0TD1sDovPCkQfRpKu6YtcFK7AjlGcyc5mzvm9PIQlPNxL617n0cOaGXQ/+z6LccLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392906; c=relaxed/simple;
	bh=Cfv4nE7GM/H1p8MmdY0vXg1QvzYt9ws6eh/vQlQmIfY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4bKeR/7Q1xBgY5AqmoWp52n/1rkYaLAKZY2/ZJwScUAgbjDL0CiXS8hrmSE5c3aZlNDbw8XRA4o3RdzdNTd5z9QWqZyaBOJA2w1rlb5KpLlEB90ua4S1fN+riiUycRbRXQE8MTT3ON31qwg9aCh+Jxj5h7JsimTJjJxL7iZHdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fP1jp8yR; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtcIF+klrXDnKmX5DXvxQoLTyEAw5H/U7rjIaBJKXMgSCSLo6A5ruoMt47YldvKsjEQZHj4xbJFvVmxurhQHEFxERAY7712Vfi/DMXKnnFriCx5rLPTKmMACPQDtaW6ZXLZjUgaBIj67fJOPqt2uUXylz1m2AY4xGmXnWICgi3hOcKLkqWPObZczdHEMErg2ULS0gMtpoTpPs/6QRC+E9mG0xFDzEyE9VO7Pc5zEnneBMuh4IAGNOfy4NKLqgRsDXANXlN8Cmk2KQ/oCfewlfTc81+iPJB3P0BrwLhlpLqElPl6IncrzZFM7e+yT4fIKFg9aphhZyZ2ReTfepw9o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djE+5HrmFLhwmIskPRnQH4pMUYsFNspUv225LDyOukg=;
 b=hOol5F5uTLUoVxno9qFnBUmkdnBx6Ra5linGPOSd8+9jug/2Xv4+5CNbG0ZOf0gaN7HVd228aqwo+ozE50c65m9XVGv9BrhsWBlvV6sz+MCXdI8P2+tPPKkET3vMU/CjjyHjs06efz8bVXQcwG1+KdpqkeLANARPcDuTJIGXQrA1dTq7jgOQbPI8pBHBrX6IjMEvzYyyml7VOTQYsqlMkdXCawGuzedDEy7cw9yKBHZGqQZjw1B954jEz5JMDFLDdGjGcuos/mUPVx15tVkPxRsRHUOUvFkT1VcmITK9xXuq0A4PcQYGhHwl+zRWyqGT45s4z4c7HC3ARVo/8C3rfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djE+5HrmFLhwmIskPRnQH4pMUYsFNspUv225LDyOukg=;
 b=fP1jp8yRfQMhR+F9Zho3ft2b5N+UZ9ANlwSykIxccsNi85DCNAnwDheqsWmQrITJ1VEbeKMaAXE6b05EV/ZvDeNn54U0Luc4OAVq/cCVYCNy+EYRDPGDqPCvzjump63AOvgPNU9nN37qDs6ahNTygQC0QU8XSfUZIwb+mPnDZgb5O3GYCD32SLrDWchH7+msIT/ZnGKLagvO3ZRM6+NnUYuf+RVr7Ii4IeNbqKrBEjW2myTSVvNxAa8a/ocAz9hl+ENNE1Q0SAIcWfvmJOd6GsGgj+jQjmE5YbjPErLiJj1ZIINQGtDjwjtNBCXiVimZc8yRGoiLPkk9WnkzZinplg==
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:41:40 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::74) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Thu, 31 Oct 2024 16:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 16:41:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 09:41:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 09:41:25 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 09:41:24 -0700
Date: Thu, 31 Oct 2024 09:41:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 00/10] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <ZyOzMyxPmfVSt490@Asurada-Nvidia>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <CABQgh9GYOgBJwRhvsWpPwS4vgDzCvXCAUxc8DQy8ObHAOvpbRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9GYOgBJwRhvsWpPwS4vgDzCvXCAUxc8DQy8ObHAOvpbRQ@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb96250-1bcf-4821-2993-08dcf9cae543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+bR5KJjO2Y9TpS34BvY282X8xHk+7CnhPIZQ7AM0PhkUcE6qoPyz6vAeqOTi?=
 =?us-ascii?Q?E1pxFP4mKB1tsgiAbbaRsC6aRQ9oDhtkbEQAyp9mR1lr2a8QtCTUY6XgnJcj?=
 =?us-ascii?Q?bntX9Xx+NVvbvpfWETMmhScytNHh+/nzlET9DKs3kdd3h6aE5P+2rUB0T7YZ?=
 =?us-ascii?Q?yG6bRAWCs05TZC9nFDJCT9ZSEvBqJxgvhWCQsJJqoBsHLUljWnNW1YxYS9Dv?=
 =?us-ascii?Q?3Qfn4YkoEGozLa4d/UBDG2dCU0p2aC0avgBHzFuSch0/WEZpTHS4X9Uw1tNF?=
 =?us-ascii?Q?7uP/z326qshyH0memYYGVF3/7oH/uKQXSaZjqM/o55AnboxZmjVtdWNDIzJ3?=
 =?us-ascii?Q?0SYaOUgUuwt5mBVgdThf+fuNNsv5kG2B6BaT9PD1JsZfMTDUlMoffU9koLFA?=
 =?us-ascii?Q?IuuJdqkPNCr3STjJAQuAKTuDitiy2eVZAaB+LC77o2IE+QpU4/+MvAIXTB1u?=
 =?us-ascii?Q?9yozEQr+RGU+xFIODZJO984YtuezCqEtY0lgN7hVxmy0lksdMvQjztuOcLw+?=
 =?us-ascii?Q?fVCIFCPB+hy+aQxW9dVBtUMW61r1wI401iHK0XDoxrO6qG7pE/FIbNRW4L2A?=
 =?us-ascii?Q?EKJwDbwczEgaDW6YjldKiqvc5CEcQi/fmw2JxetDwohDzpDrK4E35RaDJAHO?=
 =?us-ascii?Q?sf5tXZbpRqT0GIiXWa94bXqxAQ73zCQMdNvQVIujMtFt3YnHgekbPlXQg+71?=
 =?us-ascii?Q?hRCGIkTMkIi/hQZrajBOHWwvddhUpllB3Q8bdJXKo+pM2vpAAUEsZwDTruce?=
 =?us-ascii?Q?TohVWFTzcnohSAnQx/SPUaBXZP+M+zarBKOsvI1ohLU1iskJKdoCWT9Pb9Tq?=
 =?us-ascii?Q?iRBgYNEn8p9ae1LRT4ruKFGTCKYRM8IShA4wsO4HGPZkatk9aPs/wuB6WAgX?=
 =?us-ascii?Q?rUFTcuR6GOTc0T6a52a7S84PRAmIj/ZSmzlPX1fiR2qC8UdmYQASHdrResnH?=
 =?us-ascii?Q?DY2dOwLzx/xoQ46FE1Q6Nb1gD0JaK0SIDLZ3mCpDSP+7SrjcAa0i3GTWSn0/?=
 =?us-ascii?Q?cdECAqCCHYtLNHenc/0PHxcw/u5b7leqxPchoTSF+/ZztGq8zpuJ9jZwHeHo?=
 =?us-ascii?Q?jHA2SJlZRcZXUlEIL76arPtrGl3OJ0urHSuVLiq/1ILJ6kqJA3m8bFd8+A/z?=
 =?us-ascii?Q?cN6BU2Ll0IoERhAwycFBJBQqur4iyWVUVXeq4ZlMhzvc2oGSE7syNMJcSOuT?=
 =?us-ascii?Q?Dt0HKnaP1l3nAJXyZaTpcjub6FZmE4tPCijg2LOrMO0xGJNSdZYIJ7X1CBZw?=
 =?us-ascii?Q?bN0rfOk/LMNUGos0diSrBBwtmCWl1g46UF32yAmyrkuaodrTy+si5JKGKnIX?=
 =?us-ascii?Q?UXxgdhtYTT8rhHVvp/t5+Xm1V0lamhIR9Q/Rp3mWbRHmjPslSByEgyzSeRzF?=
 =?us-ascii?Q?tSYrMlyU0Mt+0VmNrW9hTVrYPwyzEJOgvggFfKmEY+hIFr7g2E28BthF7aQg?=
 =?us-ascii?Q?WrLcE1HDu7g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:41:40.4705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb96250-1bcf-4821-2993-08dcf9cae543
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

On Thu, Oct 31, 2024 at 02:28:12PM +0800, Zhangfei Gao wrote:
> On Thu, 31 Oct 2024 at 05:36, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > Following the previous vIOMMU series, this adds another vDEVICE structure,
> > representing the association from an iommufd_device to an iommufd_viommu.
> > This gives the whole architecture a new "v" layer:
> >   _______________________________________________________________________
> >  |                      iommufd (with vIOMMU/vDEVICE)                    |
> >  |                        _____________      _____________               |
> >  |                       |             |    |             |              |
> >  |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
> >  |      |                |             |    |_____________|       |      |
> >  |      |     ______     |             |     _____________     ___|____  |
> >  |      |    |      |    |             |    |             |   |        | |
> >  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
> >  |      |    |______|    |_____________|    |_____________|   |________| |
> >  |______|________|______________|__________________|_______________|_____|
> >         |        |              |                  |               |
> >   ______v_____   |        ______v_____       ______v_____       ___v__
> >  |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
> >  |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
> >  |____________|   storage|____________|     |____________|     |______|
> >
> > This vDEVICE object is used to collect and store all vIOMMU-related device
> > information/attributes in a VM. As an initial series for vDEVICE, add only
> > the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
> > e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vRID of Intel VT-d to
> > a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
> > of the device against the physical IOMMU instance. This is essential for a
> > vIOMMU-based invalidation, where the request contains a device's vID for a
> > device cache flush, e.g. ATC invalidation.
> >
> > Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
> > by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
> > with a given driver data.
> >
> > As for the implementation of the series, add driver support in ARM SMMUv3
> > for a real world use case.
> >
> > This series is on Github:
> > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v6
> > (QEMU branch for testing will be provided in Jason's nesting series)
> 
> Thanks Nico
> 
> I tested on aarch64, functions are OK.
> 
> But with some hacks
> https://github.com/Linaro/linux-kernel-uadk/commit/22f47d6f3a34a0867a187473bd5ba0e0ee3395d4

Though we will have some small changes to this two series (and
possibly a small change to SMMUv3 driver too for that flags in
the hacks), would you mind giving this two series a Tested-by?

Thanks!
Nicolin

