Return-Path: <linux-kselftest+bounces-33153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74007AB9412
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA8916A1E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F617A2F2;
	Fri, 16 May 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aWX6XFQg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022F3211;
	Fri, 16 May 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362652; cv=fail; b=B1ke9ZRUa4458JfgbFGD66Y326tWVxwxOPYJDvW3PxPi2HWxv+Kc8d7HMEb7WYrjaapFXacj46EX65GLncJLkeFZRjU8z7NFyML4DMZGlQInxKrlfreIve30IPCIAtVT7QDp3KmrOsy2w6bKCBK3YzE0WAZBXYY321iu9x7wlcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362652; c=relaxed/simple;
	bh=T6w+hLMIms5L10CGb1HsP92IIh9H31sM6Mbz1YaZqiI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEDTC5Pw6QZP3dfd7Nan1GRiiRyXfs6ejz6txz+g/WYBvCRSNy65SN9cZg9dvvA6/s6fH9AXEK9IWkQdxetxPUdQDtbYnw01FnnsNtzIAULjL+1/BD5FSz4JWI7LRkhJQ4VJmVB6uM6ULHhT6lER/DCPvsyTnHlCU/PqjdMQqww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aWX6XFQg; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVEG4msEoioSY+3qwo+01ILb4ZArPXUDrTB9hX9jld1NBX2zzuqiFEQm1FA9lPSLxTo3o1WiZT/FNYTfgj9bZZF+Ejy8smBNuONxFXWGvz7c/WsHjzjnpkyH+05PhSC0cCDVhgISjmjCg5cMFfDYTp7Gqp/1t0hO+iHs8UyW9iyC9vBTOtTItWMM1hXAdQP67coKot6uDafakczr+GN66Xw6JxOpprdO5Y4cLvW8jbcAt55wI13lyQse5zqIlyCFNkprsQJfHkqDtG2COWogSy9LXS1qnMYUE0ruuco94lrV/0dKwUDEDSPEHKelc0hYcGjFBZR+wRN8oowLa8yjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIbPJVkzAr9i1y8u5OkFuRzurirdRvNQlqhB05X5awg=;
 b=oPtszWby8Gzuz0Nu0T3FN3bqS3VEBv8vQiXtAw7ojwfogPc3NRn7XDu+UhXb5enwPdZKyebWAQXj0yV4oH+CAvA6XRq7rkQzHrGSsXM6v2H3XbgoMXTqIOyaa661LJ/VhX73T5KzghWSEwNa7wV5RzCLmOl+cDgvf4FWIfZOX+lxbsB5LZNfbZcbxLjvyzJxkhbT8UlVuGAt3KfEHP/JNoeimYI9Q9yOaAQ93jB08lcdClRxp+NCF1hNwRGixzz1rPPDJ7Ou7Jh+uDnh1oeKyryg9hlQVeffxyXkWA2ZkoWkBgWVF1zPrek/HuzLgO/ElLZ4chiBbmQzwxLnG82MUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIbPJVkzAr9i1y8u5OkFuRzurirdRvNQlqhB05X5awg=;
 b=aWX6XFQg+KxVkj3iB4AL6+PB+dafafmMOs86u9NmEfAOovNd9LMUKIo33EO0UgRMHEe3nGfP4heNu8c75Ag8BHwI1Rhkn8wXDMVdreGkeuMC3DSaRlOhSTjhOT4ktfX2D2dRA8JJ9/hHjKAsb31XXnka3+uLb6BDkQpJ5ht2HwHV+pH1BMRh6b5UokL2nOUkxxwtJ2YCR65nkbO2wBdgBRwEomPstu9mYdNiCmIn+6l6YIwXCXtkmAn9P5c3MbwAj+xAFPRfdssTXsrmyjszOO7h6pdIxcX6CPNSDRttJ2eJz9oXDVMkCslPY5VuzaO3iXCFGJk093xK87B6hCzrPQ==
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 02:30:47 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::f4) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Fri,
 16 May 2025 02:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 02:30:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 19:30:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 19:30:31 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 19:30:30 -0700
Date: Thu, 15 May 2025 19:30:29 -0700
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
Subject: Re: [PATCH v4 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aCajRTEU3vPQAzpD@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <bedd9de4e24bb89f18f4b13b52c5fdb6db6bd889.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52765915FACBF590E09EC46E8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765915FACBF590E09EC46E8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 85501780-4a43-412f-93f5-08dd9421aae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qeTDjau3q23NlfjielUrENgkbAhhpmO6yHiQr8ZfaMIc4n+7IQF41gt+rc+i?=
 =?us-ascii?Q?YkvDX8Cl6fQcq2d6FRRz/PmOeFhKiTSzJKOVe9BzDqhLYDcl/+qG91p7MZs+?=
 =?us-ascii?Q?O3IzRrevKZ4Cv3UQoF7hq9pnbzLvEN6OeeYlS8ShKGumYnv4/jKG0wWfFgku?=
 =?us-ascii?Q?/Ss16i+ehyBb7k5fPIC9QyyZhYA9/fJtdkBAQqiCaLWjAnqBRr6LPHDCTA+v?=
 =?us-ascii?Q?MokHU2aHC2kL/ICUTf4JQ4/5H27v0KuXJMwC3CG5naPem6c5EplpvaHNDxPi?=
 =?us-ascii?Q?ysVxF67dzRtnV57MaySCOww0A8xKYyh4FcgykDPE2mNLcEoEDeqjc/DMmZGs?=
 =?us-ascii?Q?HUTWt7v9Iws5Aj3ckD5WcGe0VrXpZnikrN9qGSnfk4KIJuYnFWhfNS0FdORU?=
 =?us-ascii?Q?MXBF1mdenRfIfu38XkGVGr/zFUjTOAgWpiOT720BO2XhScu4DqP3bmhIMMQI?=
 =?us-ascii?Q?qNmjSiCkBTqFGjFTAAYW44Dlj/QbUbKXSguRgiXTDoET1LL3jjhV05+hPr6/?=
 =?us-ascii?Q?AQAHW24XDJJ0cIM9oqeL2lyFioAuUTobO0GkxJHygad0Z7842NybI2Jc7tY1?=
 =?us-ascii?Q?cXUxvBxgcU6OmSj8oJBBKvEiVEm9bxBzSAd1M2c2xC7y4bA1zSrmGKRoFadk?=
 =?us-ascii?Q?giHpNmDePmNbMH2bk9vQ2cE1QbQYCK1tNFS0F1bOm/3TG7RduQHu/eYEWALP?=
 =?us-ascii?Q?Yp7nkVE6gRIJUGCNVZkE16s/gGszGcvXhgsKrzMkO5xhTgvCEqvaLKHXD7Na?=
 =?us-ascii?Q?I6IOjTs7/K014nkUnaydUvtTVD4XDpK22sQJTw4yVZSuI/8P6YOSl2qnkXqW?=
 =?us-ascii?Q?lJjMoSdRbrgQWBFzdXfzigCFifaL6bwnvwbyne/Axz8p5mS1v6hOjhvYy+ct?=
 =?us-ascii?Q?s/YY3xmRC0G+XLU+LJLHt9XNkxC0ih1srfNlJUIaAg2kMaTJQ1wWyqRloAWh?=
 =?us-ascii?Q?gBBVPx/DMpiKANqpL9Flw5hupzzEQ59leGGgEpn3/cHA1wu+63h85n/ZqAtL?=
 =?us-ascii?Q?S6PgWszTQGSjmgUgDIOAr8OAh8/anixZb5Nwvg1/c3PTi+7D5leFwBmk+afu?=
 =?us-ascii?Q?wXtWOq2/5zAUmEAqV4lWb1r+KDVrkgH4Fu281st1T3Eur6sPp85HPZehLlrD?=
 =?us-ascii?Q?n1e7nejXUabO8oAOmG+uYjyvoyEduLXTEwZjwmvUsu58rikooLE3RDE752Ik?=
 =?us-ascii?Q?+irzF9AatBdPi0ugkQNioap13yqN93MpZkqD0TWkS5GO558kLXl1Vbfvsdje?=
 =?us-ascii?Q?8ImFxRp3sdEtdval2ne80uZBK7/Dr+mcsw+B3jeviSE4BNhpcwiGHzoAdDB5?=
 =?us-ascii?Q?MLVvzqz8fhvabLb4nXVynvhaapKj6sjPbzQYmE/Mn6FHlZEPjSO+0hLZEt7O?=
 =?us-ascii?Q?2agMrN/LQcjxY70k+L9OQHBDr71ufOb4uJELvBQzKga38XKNMGszRNQ4mPLu?=
 =?us-ascii?Q?/YtO9P40oQpU2sqzek3Uf68NFKP6+fMxvp1303oED8+UryxDnje9JhopJ11U?=
 =?us-ascii?Q?lkG6HDfjh0keqXQe+Tz7k68oQlueJOvrSTB3bLGGZRtFc04+RICaP99Whg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 02:30:47.7012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85501780-4a43-412f-93f5-08dd9421aae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

On Thu, May 15, 2025 at 05:58:41AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:03 AM
> > 
> > Add IOMMUFD_OBJ_HW_QUEUE with an iommufd_hw_queue structure,
> > representing
> > a HW-accelerated queue type of IOMMU's physical queue that can be passed
> > through to a user space VM for direct hardware control, such as:
> >  - NVIDIA's Virtual Command Queue
> >  - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
> > 
> > Introduce an allocator iommufd_hw_queue_alloc(). And add a pair of
> > viommu
> > ops for iommufd to forward user space ioctls to IOMMU drivers.
> > 
> > Given that the first user of this HW QUEUE (tegra241-cmdqv) will need to
> > ensure the queue memory to be physically contiguous, add a flag property
> > in iommufd_viommu_ops and
> > IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA to allow
> > driver to flag it so that the core will validate the physical pages of a
> > given guest queue.
> 
> 'READS' is confusing here. What about xxx_CONTIG_PAS?

Combining Jason's first comments here:
https://lore.kernel.org/linux-iommu/20250515160620.GJ382960@nvidia.com/

So, pinning should be optional too. And I think there would be
unlikely a case where HW needs contiguous physical pages while
not requiring to pin the pages, right?

So, we need an flag that could indicate to do both tests. Yet,
"xxx_CONTIG_PAS" doesn't sound very fitting, compared to this
"IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA".

Perhaps, we should just add some comments to clarify a bit. Or
do you have some better naming?

Thanks
Nicolin

