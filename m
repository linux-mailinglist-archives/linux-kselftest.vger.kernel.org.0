Return-Path: <linux-kselftest+bounces-18431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD6987C6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 03:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6961F23AFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0A42AAB;
	Fri, 27 Sep 2024 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnOrxNgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C32A932;
	Fri, 27 Sep 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400371; cv=fail; b=A1xCuGczD2SMmAOLhVCpJ0P0ujVmvkK73Mi1I3sqpaXCufjfSgW8dnwidTBeTRiu+zBW5uHSAKZdwFQFegqhXyohyQ80WWSScpWudB/+NHOULAZlmzP+JXdg8+vkKDxO3IIkccLNKQy6+BdhHhYx1HjZ4U2lCY6k5nTE4B7YqCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400371; c=relaxed/simple;
	bh=dV9FHHoRjz2RitF6VkVJWx8SpAdbEA3QUr7PDPdrjWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/xgXs7mgvGAIyscdAr3bnYUDFSODzA3hKxEOrltIFQuymtmvLcXHIoinB1MlLkQjBthkEUgF8nEqshpnsI9QPRsrCLladSxRMsBxxHvBf6cPoKaM5Qj9FrWBe28t4yhFk2+o8BhHEWYjgelx9XLa+b3kFxkA+c2V9eGuRPIRg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnOrxNgh; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTsxO1MH+WFsOOJtgUIjG7xzkVH2M+9bmc8Bc58+SeNprxeUl2NLK6OSLlsQpyj4HEMPQBsWDWv2WQy7Xm1RIXvYgmVnluaLbt2pr+B8+SB42jXNUdw09dTnhl8xDeeinqrplcQoNpewEHBR8NW7Bt8wmhS1JR7FgDIGchrbHaMWLiRSKxPajHlbjA+YQIh+gUa5gLmJobs94ul/0+4NKNhaP8ZGluqTtDwfYUWkOh2wfEa/L0Zt6yuEDN0ytdleIZL0pqEv4ZoTtUaLnmBAow5Yb6mUGZznAlB8oWTUrmsbuD/R5T6HuYW5hfMDHVUwtEGN15H/j2BwOrUbcqrpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciOmkIqL11RTvY5OPmytMQ8oePrR2r/zLDrkFK3oFSM=;
 b=jeztuydvQFYEYG5lo47WBmDeP77p9VYMdsV50U96mRFLuNF3ulrqPvBF7rDZ6172SxB2Tijbme+aB19HHMcvwg1iW0VONhqXlEUUeyL/0yszNrh8K2tw+kWQMYLvPO8Ds0lw0CDFqjHGnNfO0RJnt6O5+9F7xne+GHsiVakVKURTpdZjvOvzBDF7j74ogNjUhfOBxz46RgCL3Ps450uXfwk28wnf6eAdvI3OQoCCTjYYKckHTYgcLGwrphl62o0d+0+Nb7vhq1160QKpwIIre6T2ZULdh/vHVFs8DEQPxrpqbFecW6nxHkOmAJ8iPxOGJSzel5MXAdlqxL3z6k+8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciOmkIqL11RTvY5OPmytMQ8oePrR2r/zLDrkFK3oFSM=;
 b=nnOrxNghpvXzKpfRgRF49NdmKWepMZh3hWddgoK8CNJt39KMCrQrat/db8C9Tnz2nOfAUWtNbTpFkJfLIfaJhRdNY08ePhxQo4IKl3d3T23k+HI/PYQ2v11u8LN65KyaaI9O5lmFv3zj6iM9Azze36twjx6Ch3LURWWzn+ipl3YI4NgXqVOCxT/3CMepPZ6jSkygc7rLcg+eVZYXQO97yhaj60fZZ5OKYrf9Klyecu/WdDAEMSEHQcfJErrJAmYU16714sZ59KTaaJM7S5YVtkxaqYcjzSNCCHmdpPQNKtBo3yI+CaPqPD9nhX5tkDQD1ROwvLJUxoqzSw/4/c8IOQ==
Received: from PH7PR17CA0031.namprd17.prod.outlook.com (2603:10b6:510:323::14)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 01:26:04 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::71) by PH7PR17CA0031.outlook.office365.com
 (2603:10b6:510:323::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21 via Frontend
 Transport; Fri, 27 Sep 2024 01:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 01:26:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 18:25:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 18:25:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Sep 2024 18:25:45 -0700
Date: Thu, 26 Sep 2024 18:25:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZvYJl1AQWXWX0BQL@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <BN9PR11MB52763F8856FE20ACACDDCCE68C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763F8856FE20ACACDDCCE68C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0025fde7-1343-4fbc-4789-08dcde935a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P5k0uEBaUqRMT7mIQ8MDY3PNmJMIayEvJJCuhPwuATfh+rvW1e2e4eo21TkD?=
 =?us-ascii?Q?IvwOWPPIQGND447d56a9aZYhaj1TJmAgsrTtNhAesEb0aO6rTD2IhG8pXo1d?=
 =?us-ascii?Q?8L3cgTXbEUvi9GlzQMWIWfs8S9+sXCTxvD7ck1W8o/jDB0XaujQGfsxNHKhC?=
 =?us-ascii?Q?AcNukRkn9q+eFs4YBdCfku/Hbo8zyt2rj7xdawF6DF9AXIaN9jezoOZDjuD9?=
 =?us-ascii?Q?1lyuA+M0ph9WKw4Ma+HeD/FeFp8UlbCTKlYlLe1/xvtMdxyCCBA95X2v66Tf?=
 =?us-ascii?Q?Mahzeh9jXCTKvD/VDlnBnbFcjhsyKMq6j9OpFl0Pq/pQq2eGcA9c/BHgF9Ox?=
 =?us-ascii?Q?uYJBVZ9d51wtYdcj6hQJKs/hfqaynKGF4knpsv0sqjseboAY8k/ljaQy+FB0?=
 =?us-ascii?Q?xwpgTtM7YeyBGyjHTK8/Y+bGbR9L3px83R2fUyaj0Ev9q7xKSB3bi58ZduvU?=
 =?us-ascii?Q?Ozzm77BF94AzqXTlyUzdPnJaXo3sGfP6JpQqFSwdoc/UDkbMtOyG3gyvUrW0?=
 =?us-ascii?Q?fr5ClajYksOyazSHllh1eqzl376k/eZXF5x8hyBE7JwdIxcgB7mwNXQ44C9g?=
 =?us-ascii?Q?n2OMdaPSr6Q+OxjEW0iuc5ZAXLcraFSLcbPO4BlRA7CQJBBvzfMV2awNAZti?=
 =?us-ascii?Q?6TGZdkkwcSFFDoB9QD10VjN8Oyy9oGNNuMCQ+8mBI0PhwaIgOQETylNuTME0?=
 =?us-ascii?Q?JsjubeKK5Q4f6ncdUkjlAdL7mPN9vOTj85wqLETD7rqa1h3jK9fyk8JYG4lS?=
 =?us-ascii?Q?Dblsn7QGvj2GU+2dpKZqD0fIZLFFgdTwWMBfFen3XMSHsyOfl/b7uQO6nuY2?=
 =?us-ascii?Q?3uJzPdL5us2EFJ1tqynJ8J8fNM7D9yItWIO7Tnnh11wQRRVHxhWHqZK58FFF?=
 =?us-ascii?Q?eCxhgYQYKhGkH/e1WzMpbKRso4a8AQR8DWjREMZ/qRHLFZOB9Wjq1S5IGBrj?=
 =?us-ascii?Q?+7NZH5YNnqbCXngWjJ0ECJHHiJkptnTHuzjPsTwZQ1NmF+lNKAcbj5rQtJ5q?=
 =?us-ascii?Q?IcZ6Q1zfhUXGe8Wjg/jFL3m5SI6PZM5akeFFdjZG6JzX0hZQPqKxqYr1gaRv?=
 =?us-ascii?Q?Bf/HCmaVvTHxkvtUUg46gQPM+fDD1KYXWJrJCSD/L4NJUmESuaUcwP687Esd?=
 =?us-ascii?Q?gyud6aNY60DWtQpEJ5ACma49lzOkEmwozgfWGvivq4p9CS9Uf3ifbv+W33aD?=
 =?us-ascii?Q?bZIapgpVGpp7DzCYa5GAU9pnriSmHuONCzhCc0zwn//cdcx2pCLTeRpAk/DZ?=
 =?us-ascii?Q?bmpkMMCpwpqyUJSSCDNoyrTeajsqNAZFMpXVz1zF9C5gZY6HOFnD0716CFhN?=
 =?us-ascii?Q?jwUQ0o3157Xw6ucUO6zvF/9pwd+bY//SzGNxbP+JVYZX6RBF2VbD9N75b9yx?=
 =?us-ascii?Q?2y4S3yQVs+T1919ZGC4VfGLEGDJ7vIAY64xy6kd8OMCLUdWKmIK3GeG8zBCP?=
 =?us-ascii?Q?Llt5DlNR9fyOAEfFT2/dQ+ojCO6Ho4xR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 01:26:03.7278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0025fde7-1343-4fbc-4789-08dcde935a6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

On Fri, Sep 27, 2024 at 12:43:16AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, September 27, 2024 4:11 AM
> >
> > On Thu, Sep 26, 2024 at 04:50:46PM +0800, Yi Liu wrote:
> > > On 2024/8/28 00:59, Nicolin Chen wrote:
> > > > Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act
> > like
> > > > a nested parent HWPT to allocate a nested HWPT.
> > > >
> > > > Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its
> > kdoc.
> > > >
> > > > Also, associate a viommu to an allocating nested HWPT.
> > >
> > > it still not quite clear to me what vIOMMU obj stands for. Here, it is a
> > > wrapper of s2 hpwt IIUC. But in the cover letter, vIOMMU obj can instanced
> > > per the vIOMMU units in VM.
> >
> > Yea, the implementation in this version is merely a wrapper. I
> > had a general introduction of vIOMMU in the other reply. And I
> > will put something similar in the next version of the series,
> > so the idea would be bigger than a wrapper.
> >
> > > Does it mean each vIOMMU of VM can only have
> > > one s2 HWPT?
> >
> > Giving some examples here:
> >  - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
> >    kernel holding one S2 HWPT.
> >  - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
> >    kernel that can hold two different S2 HWPTs, or share one S2
> >    HWPT (saving memory).
> >
> 
> this is not consistent with previous discussion.
> 
> even for 1 vIOMMU per VM there could be multiple vIOMMU objects
> created in the kernel in case the devices connected to the VM-visible
> vIOMMU locate behind different physical SMMUs.
> 
> we don't expect one vIOMMU object to span multiple physical ones.

I think it's consistent, yet we had different perspectives for a
virtual IOMMU instance in the VM: Jason's suggested design for a
VM is to have 1-to-1 mapping between virtual IOMMU instances and
physical IOMMU instances. So, one vIOMMU is backed by one pIOMMU
only, i.e. one vIOMMU object in the kernel.

Your case seems to be the model where a VM has one giant virtual
IOMMU instance backed by multiple physical IOMMUs, in which case
all the passthrough devices, regardless their associated pIOMMUs,
are connected to this shared virtual IOMMU. And yes, this shared
virtual IOMMU can have multiple vIOMMU objects.

Regarding these two models, I had listed their pros/cons at (2):
https://lore.kernel.org/qemu-devel/cover.1719361174.git.nicolinc@nvidia.com/

(Not 100% sure) VT-d might not have something like vCMDQ, so it
can stay in the shared model to simplify certain things, though
I feel it may face some similar situation like mapping multiple
physical MMIO regions to a single virtual region (undoable!) if
some day intel has some similar HW-accelerated feature?

Thanks
Nic

