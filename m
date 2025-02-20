Return-Path: <linux-kselftest+bounces-27042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7BA3D0B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 06:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C623B8EFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB82B9AA;
	Thu, 20 Feb 2025 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BPbTqO5a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50EA926;
	Thu, 20 Feb 2025 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028664; cv=fail; b=oYWsrvgFA1zr30ph9giPRAJC98klXAv5plTvRe+9NMjOq7TqqoHYhQ00Bjb/Thu88EwDgRxrnTRtLJ/kaaIfrZ32r4vK491DiHbtFtDWffsX/dQQ/5mZZWrRTHGghqcZqcFJwAEytUHJjT2vsDixurF9GGmUJFIkP4OKdropJBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028664; c=relaxed/simple;
	bh=eWzWF7SscQD/NpjNYmGveN4tCSqoQBJDAd0eYqP15DU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJS+5gkZCkmXLM+yMGPF5x+zO/XdZQuH1zAmNa/hN918bNGDIH5mDnJCV7dq/CCUvYVL9UKOS8nNB4Bi14Qs7dM/w1dArY+DQifWa7ArD8BRCG1N7V5lSjzA0zHRYlAy+EP3R24q7dwAUHs3UlAtCW5cjtRLTA/J9Wu4g47z8cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BPbTqO5a; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRPCaGCFkLb1r4RqyMuHP0IAmPiOgmcjeZsmVJHCDx5Zq23+ztTjt7CKGVeWNgI7XV9Ls4I2dsPrccmM1KI+UVoqUBzAJATNNzAItZR4sg5hhuXQjYog8W071bpD9r+yy1r7+EbEnzak8S8sIxuk/KWnmoZqmNCbOKKgZTo4iugsZvks44gNAgzBILa8S5h37kSGLu3hlgOpdxnWzNqhp+xEgymmk14aP3k2suO/r0/saSr9FNsJAj8i98VlYUCqGb5aQftoIaQNZVXjhet8pXuBUcf0nQidgcRCgVlAi9Ii8l3D2s3qJjS9xK+oHvReMSqOjCpwxZXP/FRC1u4jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XrtN4ek0pzutsbp2inBsEfI7MYyoOgN/8WvmNLs0lU=;
 b=reNZDClBm/kk6/Ea7VK3LXfqJK239gvErINGKOUeI532WULP2lKEL/wDndlxtZmESt4H7ouKyh2u/y7TA3SNkUkOvPac3nCTwX8HTBChqE0c4gceOvL2EImrjGxllbr8LhG+MC+VM25EKcFHCgShLZfDuLQD9EH8uhvor31r1Kg/VOVD/txKndVcldGP7dWqjfN1r6C5o2ui7PgvoITqr74rQnyIl2iJboGS0uWm2lb3QCLQjJOw/qyoFrpxTwDiEjnYU+g4IGNzmpowAdO+u5GYZnFHymrBZoQUO3dhZV/iveyIBfQ2bAWN3hIpym3t41f5uz+kdSYuwS2EApA55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XrtN4ek0pzutsbp2inBsEfI7MYyoOgN/8WvmNLs0lU=;
 b=BPbTqO5ahHdsrX1QNJ3ZMt1Yb2diIj1yNWzU4fYUoG96Cyd/D7inSB2cymoD7D2abqkIJx9J3DRjpPrus7xbl0rRRpMwOCdwvpawoLXn9Xq51/RnXvEpmj6zWt06E79Isdaq68A+uQ86MJrpzYWkx1LmlAEjnTCEm8wYq+zaJvA7hlosqBIoyouxY2ZnE9kwYNwHO3Gl9JsSYgdTbDAylrJd7yN8QVCFcpBz1zt1yAEEamaMaVZFAtNA75QZpuf1y9IXOHFG3nmXBcrsutCvdQCL6i9a142dQKpntKHyoe7vPeYVFzrfNNjMXrey/AbGriOE5Dn7QWl0JmZ9KPMUAA==
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 05:17:39 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::c9) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 05:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 05:17:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 21:17:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 21:17:21 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 21:17:20 -0800
Date: Wed, 19 Feb 2025 21:17:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 06/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <Z7a63pqKaIpCC7MW@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <313a27d92bd63e9571bf0f053eabfc3bfe4bfbae.1737754129.git.nicolinc@nvidia.com>
 <20250218153154.GC4099685@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218153154.GC4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd45115-548b-4434-6ebd-08dd516de4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IhGLYdkrFrj374HfnvWPcqTVukFyxRi/PcaTG5dE7n/Z4f59VJ043o7H7eoI?=
 =?us-ascii?Q?LFqwCvy6aDPJXlFMm89T42hn8LDIAGOP7k7uTaVGazyzWJNDMGn+CGJLMeGo?=
 =?us-ascii?Q?0IUHufVoSU6vXPwy53dT/kM4GU7r60iMS1UypXhybAii5h4raw8jo5oWW1KO?=
 =?us-ascii?Q?YVpT6D6EHWQAclYlnaWOvXeuwOU+BNYadWcwfubX/MH6BzW3afQgeybOEs5O?=
 =?us-ascii?Q?dRTApAQV2DioqcPuGh9DMYSzgfZAX1ayqiRKVu9ss+yjwubTu5J/uxv0wKpy?=
 =?us-ascii?Q?7PIbaXah2UN3kTL4ICQUwm3rQP92DyTynkmSK7vMBy41ZarBF90NMugN80X0?=
 =?us-ascii?Q?VOhcHIN6j6lwFhLqmGluDEpgrLNm6u2RvtWc/Tpz6W/l17xwnX8i6bD0TsiM?=
 =?us-ascii?Q?2WgKm4RGceQHmTKhPRfjX8CI3amcUcQfg1gqyfEWlqLtG1mf24Rgx/pKDizo?=
 =?us-ascii?Q?o5y6vjCOvhCcLTSs4KEQA6n80AHjsbJv8Ws7iw4ej2t216muQbwxN+BmhQHk?=
 =?us-ascii?Q?ukKnaGsG7WAhysSuLkCgN0kDzgH0+JWOvwVjVQC15JLn5unw5nKRPMkdIW0o?=
 =?us-ascii?Q?E9PUdZy2I475zwtJyObQ4B18huZ1r/ypHCpxW6GTw5MgMwOAcMp6AgT9SKR6?=
 =?us-ascii?Q?1dZEdpv8/EzMwuEaYLJ5TroC6UTwDwRP0DcLResSspZy+Ob64VKJbCL5s47a?=
 =?us-ascii?Q?/J6Ri0rtm8JqBd/hKWYt6WZQEuNcNMf/306ftGmDXd/DYX0U9nsj3ck8ChxF?=
 =?us-ascii?Q?iUyTBXhhd+z5XpEMcSfix9x9kMHjFklNhNcVAeGBYbvXQC8Vy5WEeNpdhO7G?=
 =?us-ascii?Q?UcGQDxYqlc46hPpq8BmdgfS0G4FHhseBbNZRGeRKHDDqtoYl7yKsqIh3W6qY?=
 =?us-ascii?Q?88wQ7EQrt+zjLkMJXq7CLM2YLbYjH926rSubXPUy/87vxEGBq7ScENpRPvrI?=
 =?us-ascii?Q?e46foPEOto+E2SCb/yK5kBg+KG5iIFY5xA6uO4acCk0OC9MJdgTa1hvmyFoA?=
 =?us-ascii?Q?W1y2RjyOdmNi/V3KJMwbZXSl1pB4M9XWwkZPYTf5BIntYT4Rager2gS1BQpx?=
 =?us-ascii?Q?R1HlS8u+2kXK0cNXXxRVgcT5fHqYxi2lcGAa4y0IqghGA4uWu2R8rXzB9s/t?=
 =?us-ascii?Q?ZCA2sE6/bxMpL6Ebx5FecEFr048yEJgpZ0CYBdetmX8At/ZunY8hMsjHxbFs?=
 =?us-ascii?Q?8BLnqisp6v9LjfHmP1w5+FrITESbzjW/s+VEeaMdXfEFKLm9LPvBGE1kg5mA?=
 =?us-ascii?Q?rkxf7DrxBojG/YJHXA+noNrTbgv4MoN8OYrKBD3KP2K6gQ1XxpQqhy/5U7Vb?=
 =?us-ascii?Q?bzBEyaDdk3X+jfczOsKdNmpT7e2sMb6lwSxXzOzpxG8+zXYNsJsQ+dJTEo9C?=
 =?us-ascii?Q?J44CXLuura7V0CocWe31TpvGlhA59sAJIbqsSE03G+52+6Y6deOIyCAxjm+W?=
 =?us-ascii?Q?KyAtq8wc1ENBWfdYlSxlwvXl1B7786q6sQUuIzjFr4V7iUD5Swc2qaZNDZou?=
 =?us-ascii?Q?vF/Tn/kW5tvQWPc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:17:38.7882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd45115-548b-4434-6ebd-08dd516de4e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425

On Tue, Feb 18, 2025 at 11:31:54AM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 24, 2025 at 04:30:35PM -0800, Nicolin Chen wrote:
> > This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
> > to convert a struct device pointer (physical) to its virtual device ID for
> > an event injection to the user space VM.
> > 
> > Again, this avoids exposing more core structures to the drivers, than the
> > iommufd_viommu alone.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  include/linux/iommufd.h        |  9 +++++++++
> >  drivers/iommu/iommufd/driver.c | 24 ++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +	xa_lock(&viommu->vdevs);
> > +	xa_for_each(&viommu->vdevs, index, vdev) {
> > +		if (vdev->dev == dev) {
> > +			*vdev_id = (unsigned long)vdev->id;
> 
> I don't think we need this cast

The left side is ulong for xarray index, while the right side is
__aligned_u64 for uAPI. Could there be a gcc warning when somebody
builds the kernel having a BITS_PER_LONG=32?

iommufd_vdevice_alloc_ioctl() does test vdev->id against ULONG_MAX
though..

Thanks
Nicolin

