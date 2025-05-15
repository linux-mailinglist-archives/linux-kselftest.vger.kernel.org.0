Return-Path: <linux-kselftest+bounces-33098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25047AB8D83
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D887189CCC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4525D1EA;
	Thu, 15 May 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rg321tiW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31B259CBE;
	Thu, 15 May 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329449; cv=fail; b=GPSL1PNStK3Chq6R82HFY0Ap3rIAYQSnItsOMTLrfv2gAMhPIWCKuhj0RB8eXg3+gjHkRIdGLhj+MvSpSkHe3l8SxOpgurtCY0RSJGBIvXY33vfXW2IcdQC4XaCbcxjSeWSP8SzBClgZhOxDAbPTYRXJgWHnh5sjtuTrtQ3FB5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329449; c=relaxed/simple;
	bh=eV9EsYTev1Zum796dh5gsCuB0gowAojCCLaSJU8xcVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg9Dl8NieCOgXVs53RzziquQxeOqfvTS/uTEn1JGVRLsu/MVyda4k2vgI1+Yzq7Vfce77XuuwY2ppJ9fPhmaPsbgoZN73m5LnFzlSlsgwzR5/97phMRlgbfHaeyPnIvVyT8Lme6I/l/bb54ZNzAKklas+AR75Zq+9SN5tcli0IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rg321tiW; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x47t6z+N88iY2pW/khYRSoTTfnU4hKNXlAKEiru9J8SAJuCCVmM+lImk4MHCU5Z5npQzF1NYIblgr2mj6TxM9RDRh8OiMRNB9eSMnBzZFKxIrjY0H2Xx/oacMLxcVXvXps6T2EbwLG/oUjxCkngIW2z7fZ9efcvC/mGL7rzAy8VF0dwXj1DXVEIIZ7dfD4G8Y8PDdOSFDSHBTD3rx/TNZtmW1DSv6U+2G2nBFW43s+upv8UViommoadtcb6rg5eHHTGKMZ8BOjkHfhConD+y6DUX05I7R9C8+qqeA/s+17n2AHPUZohySHRHAeF5SdorS7Djdl4LzQh1r2m6cL6m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld21duK/bsBrO04yS1GVyrYEhLYWTDvjWnjE2xsk2C0=;
 b=hh9GSIAa2sxp5xK8IO9atMLq7nMT0m82GSc6nMrj+O9rrkRQRNRNCMu3RJQMI/v05+wT5XWmOuc4OVY2lt2kQwK9g0m9TjAq0mxT/SsXx/g2hnYX4DBavsMIpqjDn2pgvUapsNA9oNcukbEKSzvTrIAu2wvmifGHEmI+vJyUQOgXb/tNg3dilw6vpfGgtacfJIr0NHFom1SOWgcZ4ZkOHg9hYG9Bd4H8bmOlC5/kF334/KNqJZrkpcXHXgG1BKlWmNZRAXTbcIUVl+GBq3Im1tZauflkUnku3tKya7qgzGEy35Mk6anpnEOx96zmSnRraEK2ZXqzHnIXZDZ9kVqljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld21duK/bsBrO04yS1GVyrYEhLYWTDvjWnjE2xsk2C0=;
 b=Rg321tiW/jLAnbRaC/+DKYAYx/AvB59vHkzZxSk+fXIy06XyyYKyYTbmYzR/6vGIOesun/xFV1Dg6TNap/NJq+JNO3zsGGCE7C8RgbYoeRBb8mNaWF6UsHZsuqokpWP/0ezysl3xZh9nF6vGu/ydnTNN0k/Lgr8b9v2VRU+PzphyH1Lmcz8t66YsgGhKgDYH/DAeOvd6wHRHqQzVOy3quBrFb7A59SnvbyM7jbah+4A1cTMTub4wxpj758FKHXyJIDA5HLP4mmaWIXxVtdsnILDOKu59Sx7Zimw2BYLVsOJEPTehaoLIQgsn12BsLMUyHZbOa90zf4V0VlYsNLUlsw==
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 15 May
 2025 17:17:25 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::8b) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 15 May 2025 17:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 17:17:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 10:17:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 10:17:08 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 10:17:07 -0700
Date: Thu, 15 May 2025 10:17:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aCYhksN8Zlp1QMP8@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <bedd9de4e24bb89f18f4b13b52c5fdb6db6bd889.1746757630.git.nicolinc@nvidia.com>
 <20250515153903.GI382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515153903.GI382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fef7d5-e850-4eb5-87a6-08dd93d45c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JobERncr8Ke0ylaGhIgNAzhag6WFAutnTlM25yBoKan1g6yKy3pN65opUvtx?=
 =?us-ascii?Q?4oQjo/wmeWQE7HUhpAfBE8wbuS+3ZN28YipRUhvvRshv3wIEl941ZiJrUaz7?=
 =?us-ascii?Q?SDm5hVlgsXbH2g6IUQjHLJEg6Nex0DIR54Md1L3zuzXEY/sxg9c6Xjtyj7FY?=
 =?us-ascii?Q?9K/QbKdw3MOGZK535vbuvdWnuHm3YkgAQc/zrRpC9cF72+DgkF0QqBvx2rM9?=
 =?us-ascii?Q?Vit3J4+1ToP8G+I+qky1chKpsrAUrgZfXr7kywZ6Ehkxq+CevekZwVY2SDiK?=
 =?us-ascii?Q?NR0QoonfPxoP+ZkD653JZbAvCkyU8NMzj4z/tZHTSqfRfZaxulFkiHXFssTq?=
 =?us-ascii?Q?LxIvr7HJ8l9ZpJ6xDPz6neNOxWyzmU1DrbcygaheRSgkLN5mOTigJtwsZ+/S?=
 =?us-ascii?Q?UzB2IiwB1gwFfdWdLvSEuBrTqV4ivpvccxtwBar3Ih1zz5WQaeZERALCeN+O?=
 =?us-ascii?Q?utYcSqD/SBN+9j8lOPQjIdQ9BhZkAWkH9x0fuNECk8km5JLIjfkjAtNnLHWQ?=
 =?us-ascii?Q?xvWncDrckOJ5Zd+iz3WBh95somm2HTpBy30MN+NTUbyiyeCEagMJd+bpKD4p?=
 =?us-ascii?Q?bWe1pDvwE+HxPMj/eY5Lc36iKnZpGoCYnJD5vdnOcw9+ffqlOqhWRrqCM/xy?=
 =?us-ascii?Q?DM5OqurdvbNvevJOK9Jxb3J4qtiJIbExLTFk1Vo3Bpxo5axwivFZL7KQKMGF?=
 =?us-ascii?Q?NwOTlfmdp47/LtSZKIAgYAeikVt5CW4A6iMEk2P2CvzXlZzdqqUAoB4mDnVI?=
 =?us-ascii?Q?6EhkaFSenVndCI7jKVrh2Cih9K8rblta3Xl9RFZHo+W5WxUi6fTQd6ofNRZr?=
 =?us-ascii?Q?UVnjDHfJGXLM9QkriamAZr1QhQjBth1ids3LYzxBCr7E+uUB8HktLyqwZL4V?=
 =?us-ascii?Q?/fQEDYhypLKbwH1srE1Nrp7102ILtHPLQGzv8RZ6wNlzo0pAzfCMPLitzApS?=
 =?us-ascii?Q?S7tIiqhUg9woH6aJSla4xWROL1y/3Cssz4zg5jvC6+a3/ijJlDpKrBd+QjoO?=
 =?us-ascii?Q?QeK6QsgQbSZiOGBwrBJnB/EtKZb37keyOc4cfJ5NjKpfLIeqTjvdhs13E2cv?=
 =?us-ascii?Q?OgJZJbyFjEIYHjQlWrzHbqrU78lKTHfARAmmyefROo+2ZI51v2W+tbvN92q6?=
 =?us-ascii?Q?x/Q+x94dRHXnTE/aL9NgGM9mJlUOUUl56sGnm+4zefhRV7o3Grdj7O599/g5?=
 =?us-ascii?Q?u2uWUFUGX/XKqofFLtEFENSQFVZsKVXum6ngqsfVdZLq90Jnl6HxBYGIYcZt?=
 =?us-ascii?Q?tBeJSwrzhg38yovhmXwPDy5fyIjY1IiJEefPuIk/IsmCx7lMb/0l89YRo3Ox?=
 =?us-ascii?Q?nZBysVsPTX5OJ5OCKIn3JZwdrn42tCpzUuwEr280S/EPNdksxe3jWSEY9D/b?=
 =?us-ascii?Q?9XogQEqDvTNXY6mxvRsTLhYwro69CvGGrMzsAYKTujGrLXOotl4HTzVtQr/S?=
 =?us-ascii?Q?3ERtXFUBFmuivOIdaltk+RaiLSznzYAr0rn9t+sZgBDyto3oeSWAdhYgTAKH?=
 =?us-ascii?Q?t1McvIVSZL528OPOLgReG9Ja6cbP82nyIXWn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:17:25.1157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fef7d5-e850-4eb5-87a6-08dd93d45c9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

On Thu, May 15, 2025 at 12:39:03PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:31PM -0700, Nicolin Chen wrote:
> > +#define iommufd_hw_queue_alloc(viommu, drv_struct, member)                     \
> > +	({                                                                     \
> > +		drv_struct *ret;                                               \
> > +									       \
> > +		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
> > +		static_assert(__same_type(struct iommufd_hw_queue,             \
> > +					  ((drv_struct *)NULL)->member));      \
> > +		static_assert(offsetof(drv_struct, member.obj) == 0);          \
> > +		ret = (drv_struct *)_iommufd_object_alloc(                     \
> > +			viommu->ictx, sizeof(drv_struct),                      \
> > +			IOMMUFD_OBJ_HW_QUEUE);                                 \
> > +		if (!IS_ERR(ret)) {                                            \
> > +			ret->member.viommu = viommu;                           \
> > +			ret->member.ictx = viommu->ictx;                       \
> > +		}                                                              \
> > +		ret;                                                           \
> > +	})
> 
> This should just call 
> 
> __iommufd_object_alloc(viommu->ictx, ret, IOMMUFD_OBJ_HW_QUEUE member.obj)
> 
> And all the casting and asserts should be in that macro, move it to
> this header

Ack.

> >  /* Helper for IOMMU driver to destroy structures created by allocators above */
> >  #define iommufd_struct_destroy(drv_struct, member)                             \
> >  	({                                                                     \
> 
> This is abort not destroy, the names should be consistent. But looking
> more at the series I think it will be better to do the little rework I
> suggested and not give this function to the driver in the first place.

Yea, it will be replaced in v5.

Thanks
Nicolin

