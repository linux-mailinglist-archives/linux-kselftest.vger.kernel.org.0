Return-Path: <linux-kselftest+bounces-33158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91422AB9490
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 05:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A03A7A71CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724E1581F9;
	Fri, 16 May 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SToKF+gB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307CF18E25;
	Fri, 16 May 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747365408; cv=fail; b=TaeNeDasgot510PWGhAlA5mNZw1iKK60sIiPCb0BX8q4u3YYEi/adNziY5iR3oR10c18ZaCf2SEFO+S+lYWE6TPssS8vD6LERrXnZUYp4KlbWBuJl8xZN4Acs5oiF/nMqWglG6WkCiHO4GE+toxw8IQY1aOFzVq2zz6NKPQze8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747365408; c=relaxed/simple;
	bh=+lWbs9NjIuY3Ra2cxfNzNU0yv3EJL02yPyJ/q7WbzQ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9hweLb2qtgB8WAxzpgwwFufSfYTW/RrCpKrMWWyyJAdcdHwBYQtHcblnbf9n2Cdz2GXMMov/4dNm4wP3ITpcdhkSgi50dKb6VzFcQAEGYLt5YDb2j+T4UyeOodzK735n0sg+NlBES/h1Km+9KbUph8rhxREWnak79sY4eb3ySA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SToKF+gB; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeRyPvU6lZ2UpLP+1WGol21gCPSCgVRIOJhqU504zk9QMydo2X3Fa+t0TjuWiTWGeGwcp+9dqnx55Oq/BiEeIi/R/1CjLRzeq1oD9gq0Sp84TDUGidve65tEjMF5uBOHyjzIIaVX2nuhKoynLQypJsdxEwsmXCgxPF5QilLEyJPR8Vr9Zcq/olP/OE1o1sLGieXXuHivcE1675WLW8lm7BAMmYXipxhBM+N1U0P1SdvZRCMabHNX578c2fq7x7jAG6vehBuoqBS3IUu44OmXysLIQXgjVs2aWEVhVaTwUVM/LOl08bqtvMZutWzcaubvBEYTJN6E81o0iom88QAU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc+ys5hQq70wlTK4LFKqPAbfROUqThSoEmXFUH9LdK0=;
 b=boGivLxI/YBzRG/UUj0vlhibvd58zbZGJLB/b5Ehk4wxsBc4Si9c/zDBVnqfGJ7rJFtvyVH0S94kWL9qTq23R3o79bPa478OBkqnHxvs9eRCjKmx/bNxMosMr1qaz/ckXH60dmoZxHU1+bv1/HqFsc5qNVOeU6Wv92uTdH5W4wMk5SAOpeUVo8J/KKbdqwKshDZs2R9LE8jN+BBLsseTWLrY5pyhz4ba7DL7cNG5hQbz80gaZ7GeBROxWR9TRZw7SyNdJVSgveegLynj8I5dxMwx5OakNQ82sgzZTETNc/v7ppdgepspM8c3wXEOPzrn9OrvOkLUzcyIWcreSZ/EhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc+ys5hQq70wlTK4LFKqPAbfROUqThSoEmXFUH9LdK0=;
 b=SToKF+gBLkejo2PpjlgNDRTNFyhUVxm5zMMbG2txaJSrC5MrFs2TgsqZkZqOnrV8w+LuiIrPRF8+SJLK0HjOf7+uCq4/KS6/AzGqHkizBJTFKXt61KPLArV/DbkE+MBW+K9313OVJLheJLnYN9DPTIPbIDvbuuJ06n1MCKdzWS2v2C22ZFza6D+JrMa4pcmw8VLDxWfwzyeSynZWlFAdOkYzZDGZl8dIivg3ezBE9uhS3PtVsgSl74FDX9wm6GMNqLiwW5+VTejMOpORFUKqCOgziWk/SCB57u9GC9P1fs7OD9ZIrHdF3JlBHcbC99ZQqNp9jcF5Doo9Ejy1ruYwUg==
Received: from SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:16:42 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::79) by SJ0PR13CA0154.outlook.office365.com
 (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Fri,
 16 May 2025 03:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 03:16:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 20:16:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 20:16:35 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 20:16:33 -0700
Date: Thu, 15 May 2025 20:16:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aCauEGCqk5lVikwR@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52761EF8360BEF5C19C2382F8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCY2GKfMh6f+vXHj@Asurada-Nvidia>
 <BN9PR11MB52761839AABD5AA55DF3FE118C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761839AABD5AA55DF3FE118C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd0dd86-cf8a-4ab3-bef4-08dd9428149c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YuRq16RXXPrxNhmbenVFqQ1UQuUZ1jyi2d9Vdv3DedzsB6U7SsI2r3sx0+Oz?=
 =?us-ascii?Q?BbDPKJiM1ouO8irZSWgWagaszzkyypu7B1vYrfxIO3j72uXbhR3fCl5fZyiD?=
 =?us-ascii?Q?K3RW2xCl9NjjHXYPGJnOCGqk4VduvxBJ4O9LIx8euCihhjIWdLQJ9vqcZSXf?=
 =?us-ascii?Q?lm0EmWDCT21UfarNJKA2Hikwkvbyu2LlsJwT+ipU3t+g4lTr9+iZVXoR+AiM?=
 =?us-ascii?Q?C0nGjXBSW6c2alw61UaL2jzuZx0hKm5S5Z8ZXVBX4oXm67TEWOUBd2KhP+I0?=
 =?us-ascii?Q?ZCxqSY4MaQb+gWhI0PoMHhgZMOeXcgYXnUHyEXjC5E2Bd9dYnVS5CG1nCVG4?=
 =?us-ascii?Q?bYxtUk5H8qeQumP3Iv1VubvPF8nk1oG4YSJrag55yrpc895va01+mpYxOMKl?=
 =?us-ascii?Q?W8iI4opBe7pZnYEpWwqTdHLC431Kh4lsT8J+La2dZTzqbHWfpPJ61mLeFytj?=
 =?us-ascii?Q?TvaSAgcPbt84ErLVgFYg0w5gOA85hJ9Acn7FNmBQbqNy/nZXmm7h5FH2SA4I?=
 =?us-ascii?Q?pCqL278oUwLrvzMyKCsDhl4NIm3o1ogRFnP2hyZwdAnmrIYLivlso6r5TB2+?=
 =?us-ascii?Q?9O7bETvzsRIUblcQPscEJyMBDME34C5In4mN7/CT98LC6IV5QpHKuEM868c6?=
 =?us-ascii?Q?BT1dDnRGcw1EE3LBK4u+7vAsM7caHDI0RJa34G4rxGxFLMv+mD+pSdD8l5As?=
 =?us-ascii?Q?RojVk0O11ziWFovtexFPrloKHLF9dcjnXiiziXPyYsxeHnXmeyUI9tC5zpct?=
 =?us-ascii?Q?yggt6bWNQN7Zzb6FMyF7Qw3JruATEvnYgOu2hdGMRynPgsFbChOcc/fnlClk?=
 =?us-ascii?Q?lgiJ24Zk+jhNYqgvt05jOgS8khoaTY+jUGkEQelkJJagdPS6yBTEuG/sDi1f?=
 =?us-ascii?Q?+bZbrdgCH0XmG2Lj7RIEKA3o9vGVQL6NFskU3sKuYtFBdBb5pWapS00wdS0U?=
 =?us-ascii?Q?t3AMQkJjA5mvJ4jrQu9XFqAKBeW9yOVXVpqjpPo43E9M0ctZsW2+SE8ssdXo?=
 =?us-ascii?Q?U/AW3Aafm/TaK9vv4aT+QJO08nAG71VnHB4YC0VkTb/EGLm/sIYJMMBYZvR0?=
 =?us-ascii?Q?Mg/6NLAkshDV1TKxQm8933J/JGUUsPDMtq6lgUPTdI4W9XiP75A/Cyg4GcUe?=
 =?us-ascii?Q?9lNJm2bdF7+Kuod0IArheesqDdfDZSuX/JD420J1CiJ+Nt3m7N8HuvikWpb9?=
 =?us-ascii?Q?HuzW+ebSTUwmgi0iRnTbds/QsYE5YARh+nO02tfI6kMjXxCsIQG6Yr3QJ0T8?=
 =?us-ascii?Q?h17Tj8XsAWkjmpwRXCgT2VnSGN8oL9bbOfe0EKV3Ql01CmSxQurc/s+3y6bR?=
 =?us-ascii?Q?d3s7mdW/uXkAg/foSd0bze9rTVfDZeHQKGMk9F4+dhr+ytz7xRpjSn7dbHUr?=
 =?us-ascii?Q?IvtmL+g9smZMsDnAXhwz0T719P5rixeyZRimyNDz/YwJXQeWBkrs4H9kfsET?=
 =?us-ascii?Q?X8bFoCerVG2nqvLljU4bQ8ZURJ7LcnM0+bWRe9JLnqkol4qh3RWXCY5LwCJ0?=
 =?us-ascii?Q?j/VWnuduyV/WGGLzCJglX7n103tX3Mnacad8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:16:42.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd0dd86-cf8a-4ab3-bef4-08dd9428149c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541

On Fri, May 16, 2025 at 02:49:44AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 16, 2025 2:45 AM
> > 
> > On Thu, May 15, 2025 at 06:30:27AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, May 9, 2025 11:03 AM
> > > >
> > > > +
> > > > +/**
> > > > + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> > > > + * @size: sizeof(struct iommu_hw_queue_alloc)
> > > > + * @flags: Must be 0
> > > > + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> > > > + * @type: One of enum iommu_hw_queue_type
> > > > + * @index: The logical index to the HW queue per virtual IOMMU for a
> > > > multi-queue
> > > > + *         model
> > >
> > > I'm thinking of an alternative way w/o having the user to assign index
> > > and allowing the driver to poke object dependency (next patch).
> > >
> > > Let's say the index is internally assigned by the driver. so this cmd is
> > > just for allowing a hw queue and it's the driver to decide the allocation
> > > policy, e.g. in ascending order.
> > >
> > > Introduce a new flag in viommu_ops to indicate to core that the
> > > new hw queue should hold a reference to the previous hw queue.
> > >
> > > core maintains a last_queue field in viommu. Upon success return
> > > from @hw_queue_alloc() the core increments the users refcnt of
> > > last_queue, records the dependency in iommufd_hw_queue struct,
> > > and update viommu->last_queue.
> > >
> > > Then the destroy order is naturally guaranteed.
> > 
> > I have thought about that too. It's nice that the core can easily
> > maintain the dependency for the driver.
> > 
> > But there would still need an out_index to mark each dynamically
> > allocated queue. So VMM would know where it should map the queue.
> > 
> > For example, if VMM wants to allocate a queue at its own index=1
> > without allocating index=0 first, kernel cannot fail that as VMM
> > doesn't provide the index. The only way left for kernel would be
> > to output the allocated queue with index=0 and then wish VMM can
> > validate it, which doesn't sound safe..
> > 
> 
> VMM's index is virtual which could be mapped to whatever queue
> object created at its own disposal.
> 
> the uAPI just requires VMM to remember a sequential list of  allocated
> queue objects and destroy them in reverse order of allocation, instead
> of in the reverse order of virtual indexes.

But that's not going to work for VCMDQ.

VINTF mmaps only a single page that controls multiple queues. And
all queues have to be mapped correctly between HW and VM indexes.
Otherwise, it won't work if VMM maps:

HW-level VINTF1 LVCMDQ0 <==> VM-level VINTF0 LVCMDQ1
HW-level VINTF1 LVCMDQ1 <==> VM-level VINTF0 LVCMDQ0

So, one way or another, kernel has to ensure the static mappings
of the indexes. And I think it's safer in the way that VMM tells
what index to allocate..

Thanks
Nicolin

