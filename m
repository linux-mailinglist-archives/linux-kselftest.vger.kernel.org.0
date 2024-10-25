Return-Path: <linux-kselftest+bounces-20607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14C9AF934
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 07:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2691C21DBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F018E359;
	Fri, 25 Oct 2024 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fCV9uyDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C718E029;
	Fri, 25 Oct 2024 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729834939; cv=fail; b=bu5HwOiZ8q2r+X5XgchJMOpiJvFtozjLdYaYHZlGMEzJciC5R7Nq3pvtwuFyjdWQEDtwYGSXtrzCDgSyaavZeUgOVmQlJ+O25NwgMLYr9KrFYTONL4zuY2jV4OOcPMlmUc4PweEJWT0KQrJcP80EuO08DY6lAgfXgcSwxp9oVYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729834939; c=relaxed/simple;
	bh=mh83M1N5vfFChzU23F/36Voe5ukTOqzZVO/njaacY/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNLh5wGJUHc4LCOxoNKhSq/lyf5f5n8c5PMijuhCCG6NYaKI4jLGIAXLlkLVQBE5eBEIceefEF8f3u6GAB4+KdAtY6FoLSWGY3VJjebPvWhlgbpGYdmzPbdwX6hBSVfWngHYFtwi738CD4gZLTU6cz0YbW5ppIMbPkktsPh0flY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fCV9uyDh; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuDert5QSWXZYbgh6UP1xrX2wVBIPi8U1Vxw6uu10gDLW1mySVPawwLGZn39u9ozOwgfWJla7m/G8nxr5VDzRXUL+Da1aEcdpffJVXFwWYufNKXFQUlBCwSO9JZTWKmmNLtb8vibmn0WR8T5QXtmSCsQr4SmibL8N5yQsz3M2tC8IvpTcLiRyHjVSC3ZjuR9v4vdy6XjNQnHEZEYL5jPnnLnAp+CH3sIxfSf9esg9tOhI9oJUxKTowloSD8IUBPL1BZPnFWJ0JgTV9xvY3yM8PmOMXk+zZ1jlVXTeu2UXgC5x8uOIkc5t2fvN03rINR98yjlzxHQxdV2fweSAmGLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2izqTeRkGchbWAvkGR3OgORJcg/yfK1vhMFj/4YXqg=;
 b=qesq+Ejw475agoDeBObHllRHwCJF94b8wtdIzRGmpZolYCiJdHqfKanl6FBHsTY7uNiKgW/DXCQ9WM+qlk6U04zILPwjrzEZ30GHsJ6VtudZuE5g/Tq1aUBYYr1gxyJasi2uw4cE9Byj9KaG3J9HumSaIM2J7hFqGP31RE6Vuqc1aArxEQrzMlB0fLfdePHG5luUt2Wlkotbo2AEeQzsJu//ORp+Mmw3hYKQpinT6ibsJuB88uNd+pJt5M1KwkkdafE0163x4QmjUAzXH6x4iVCsJDq4wSqWBrUw4KYhzRqhrVoe+YLDtkDqIJcdpUPhW5hjNyZfuNtNruK3Nh5AQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2izqTeRkGchbWAvkGR3OgORJcg/yfK1vhMFj/4YXqg=;
 b=fCV9uyDhe5nHVtGMGDoohq9G/pPewioLGM/KOhO67GUvYr5i2gskpmmYZwvdqq/OfT47QSyrHu6GD7tIMq1oYAjzGfDEJFYg0yEdMTA5geXvEMUO6U5PsoScKSUcFH7EpMRwV+DvpmqzPn3+iswh3NS1WP96SxeLf1bpQlpdOutIcVzoAdp0EV09VqvkqkQUeefdCdHt96gTZu9swnglwvgeDx3EV4P+dQ+N8jk7KsbiLxep2M2gPpkpjo9eN/CvrrP1v38Jmz1Zmp0u0uxbMK9/RKKiYvcp+IKcyg7VaLrQ9aci02kE+RlWl0R56xd1uft2h9jJPUPGIzkZSk1XJQ==
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 05:42:11 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::87) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.7 via Frontend
 Transport; Fri, 25 Oct 2024 05:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Fri, 25 Oct 2024 05:42:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 22:41:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 22:41:55 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 22:41:54 -0700
Date: Thu, 24 Oct 2024 22:41:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <ZxsvofcC9xSSEMHi@Asurada-Nvidia>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
 <ZxslrakslZbphayO@Asurada-Nvidia>
 <487ebe2c-718f-405c-8f20-213eab59ca0f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <487ebe2c-718f-405c-8f20-213eab59ca0f@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: fa29d323-c2b1-4787-5198-08dcf4b7c5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzjsoxGDWNTQffdqxJ2TIjt5WRryG14ptOUTYAmzUjiC4lYdGR0GGLuQhTkc?=
 =?us-ascii?Q?TulPW5ktmRgw9h6TqiK0WVbRSPGlMuOAarh/DFWTP7vqDXw6Q2mMDMZb2Yu9?=
 =?us-ascii?Q?x9c+KdI2+OeedysSqrxRkcD+eEkmA+BiAOXaNB+w6uro38yeewkhmziHeB7U?=
 =?us-ascii?Q?ANkpt78jPupQg2zL90qUD+dO9fV0Ja3enKVeBKgfuKf3mhXNy9DrLbDnq5ig?=
 =?us-ascii?Q?7rv1RehVCLeEPOUGMfmu1KBlypzPl4FAbf1kaC7z9Bda/ZGW97/ONk6wk3Hk?=
 =?us-ascii?Q?XnqkSN7J+E2tLTel4k+0vywRQQQZ2cU9FLNFSTQ52F3PdoUZHIqx2fuuReUp?=
 =?us-ascii?Q?A8rh+qINWFlfxREMQE3AkSWHvPZAc1EAD3mQS4brl/IsdwDnB6RILoz7K4ci?=
 =?us-ascii?Q?TK75peP3bH6dQ58aPRaBXPiuuHFKwUna3bOX3vH6VdxWTyojbZUmppSSkJsL?=
 =?us-ascii?Q?TL31pKgeoqv7zSuwLNwq0ce2VVdJV5bgUbf2dk0iC6aYNIAxOJMxAXyfytsl?=
 =?us-ascii?Q?+HhOnM7XETLg9bJtxKZwTL09gRwNcfax3ntEdo+MWcQUSHQwP5TDzaCbrdRB?=
 =?us-ascii?Q?xg/unD3pVfTk2oJMf18g/FdDAhTHUXj04Wpw4/YJGX82dbmLAGSKzxmQqDTG?=
 =?us-ascii?Q?nWP8WRXpTfGZg5O7NELTdHr4A1c2NI3CUFZiMwvfIV2czcVKXU5I2UFw47WR?=
 =?us-ascii?Q?GopoCiWf1Avn1DOffdWvs91Bg0bdjN4Te1E4RSYOP5MYr7uvhO+8zqUDyISr?=
 =?us-ascii?Q?PDzaKCVZdCcBt4lMbqW0ILJePBHFhaNMkRnEgGI77D36ee3aUlrA1ZjYI9Kt?=
 =?us-ascii?Q?pFNot0S6MSOMQmodaUPo4yaP0xZjF5YoiqGuiV6BjaIL2n8QCgl3YPZd4vFI?=
 =?us-ascii?Q?eMPIrsAPHRA3JZ31GWQRjrLfTn1TuCO2t/GzyaXGMsN6syYmYJTAntCw+ki4?=
 =?us-ascii?Q?5u3rGfN4XPFXV6Hv6iJw9OXrNxUFNi7z4leelrKVxYNPP1+F3qH/mVPXcHH3?=
 =?us-ascii?Q?kiOpSOZNRWSLvv3+HOZYgPNM7dd78j9t/aplxc2XWPTVHiEy3taOXgglOCV6?=
 =?us-ascii?Q?NzTTT+v+TupSSISaH2ua/ieKxA5aTPAjYjDH2L56+YE5mJkid0jOHzZKb02V?=
 =?us-ascii?Q?TyCNwhiGrcTjw1qEAv4yuAlX9vVdFw+o1W0/Kw0KQb8E8znQXBnbw02U8eyS?=
 =?us-ascii?Q?34pKZpoIQix0EI8MwHPQ36jt1CKMLyv/CRBHrqzkONujnd9yFDuGy4f0c/Qd?=
 =?us-ascii?Q?v2U/ATwvHsp36ZrIBeeRS9dy19VMu7yShzC0AXMPu50xSK5szyt+GYu94Laz?=
 =?us-ascii?Q?zFZKD97gxjokJSl+4oLFVVgKDaDz39QH3iQV5E2LS3XkTiv0EyEevqrCm2t4?=
 =?us-ascii?Q?Fe85opq4Qgp6q0BbhqsA5B3XtPUhLQwZ33bvxtLvTIfHN1XqxDRNtxrfWIZJ?=
 =?us-ascii?Q?06RBPKi8lSA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 05:42:11.4784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa29d323-c2b1-4787-5198-08dcf4b7c5e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

On Fri, Oct 25, 2024 at 04:32:10PM +1100, Alexey Kardashevskiy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 25/10/24 15:59, Nicolin Chen wrote:
> > On Fri, Oct 25, 2024 at 03:54:44PM +1100, Alexey Kardashevskiy wrote:
> > > On 22/10/24 11:20, Nicolin Chen wrote:
> > > > Following the previous vIOMMU series, this adds another vDEVICE structure,
> > > > representing the association from an iommufd_device to an iommufd_viommu.
> > > > This gives the whole architecture a new "v" layer:
> > > >     _______________________________________________________________________
> > > >    |                      iommufd (with vIOMMU/vDEVICE)                    |
> > > >    |                        _____________      _____________               |
> > > >    |                       |             |    |             |              |
> > > >    |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
> > > >    |      |                |             |    |_____________|       |      |
> > > >    |      |     ______     |             |     _____________     ___|____  |
> > > >    |      |    |      |    |             |    |             |   |        | |
> > > >    |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
> > > >    |      |    |______|    |_____________|    |_____________|   |________| |
> > > >    |______|________|______________|__________________|_______________|_____|
> > > >           |        |              |                  |               |
> > > >     ______v_____   |        ______v_____       ______v_____       ___v__
> > > >    |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
> > > >    |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
> > > >    |____________|   storage|____________|     |____________|     |______|
> > > > 
> > > > This vDEVICE object is used to collect and store all vIOMMU-related device
> > > > information/attributes in a VM. As an initial series for vDEVICE, add only
> > > > the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
> > > > e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to
> > > > a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
> > > > of the device against the physical IOMMU instance. This is essential for a
> > > > vIOMMU-based invalidation, where the request contains a device's vID for a
> > > > device cache flush, e.g. ATC invalidation.
> > > > 
> > > > Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
> > > > by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
> > > > with a given driver data.
> > > > 
> > > > As for the implementation of the series, add driver support in ARM SMMUv3
> > > > for a real world use case.
> > > > 
> > > > This series is on Github:
> > > > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4
> > > > 
> > > > For testing, try this "with-rmr" branch:
> > > > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4-with-rmr
> > > 
> > > Is there any real example of a .vdevice_alloc hook, besides the
> > > selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the
> > > question. I am trying to sketch something with this new machinery and
> > > less guessing would be nice. Thanks,
> > 
> > No, I am actually dropping that one, and moving the vdevice struct
> > to the private header, as there seems to be no use case:
> 
> Why keep it then?

We need that structure to store per-vIOMMU virtual ID. Hiding it
in the core only means we need to provide another vIOMMU APIs for
drivers to look up the ID, v.s. exposing it for drivers to access
directly.

Thanks
Nicolin

