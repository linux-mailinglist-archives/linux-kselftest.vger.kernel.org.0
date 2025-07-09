Return-Path: <linux-kselftest+bounces-36854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA7AFF14D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE471C83E88
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98323E325;
	Wed,  9 Jul 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TByd99i7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD221FF4A;
	Wed,  9 Jul 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087743; cv=fail; b=tiSG5pDozFL2kxNYv0PW8Do9WTo44fCUZ7EWvolYmEkPiN/WcT1ysz2Jda3dgjmLaAo+ox278R/2Evn1aLXwHWSFCsA9Ll4ftlXuRppPc0Wmfy65fYXRHx/pocmqgH/cLRAgJlKwq2rSQdp8CoTuVQGSbaFFeQ3fyuQDTh4LDPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087743; c=relaxed/simple;
	bh=RwHCsPHv66+y2Wrqu0ohonNGmOuevajKPniILM1rDTE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnjZA8vnIEF1R53EA6F1Ux6r75RTDez/KLNCPni40C0D8NwSn3Ryqtt52BpyhNdH78t6NohNxjToQTKVHJveoGziWp85Cq46COSrsRNo5I0Xjowmn3JyfQfNvqe4mAU2D3gAvCxF7ceC24A7c9PclB6ViSJlEYsiAwhgidi2hHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TByd99i7; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpqfKnhpwJOmDn8CwnGC0zMaaStmpCXIvjZofq0QOO3QqOba8ER2ClRP1zo9k8vE/+vMcMc6/sQcjRHIci4IFF9FI/kI6TulLLLyF8VBgxSqLeVJJ6G8YR2Lk1ZVujIO6hNufCPzjefdUzxdFqMFXjl0sxr0EaTCDLYS+hfj+S6odUDdY8HZUEguHcuye6fhMx1rrSRwJcY64QZvZm0t3SbNcvhl6RuuLa+pWeGoyDP8whWX6Un6MZq5pfoYtciWbptsGg+tYlIoGyCbGabHFkgVjqPusI5M3eeG+m1wFsqyFtKwjk8chZIpXl6M43BxJhZPjVxI43HkZsDXwySktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LtzE1fB0PojPrl5ZBm3OK3/9ti96j0eq+tuRMGdzqE=;
 b=X9rIoHVST7FG5h+yQXvSTZ5KaisDrjuDW6XOAyAOy7URjqIRDQmD2NZYt8L6RR9iSmqSNPzZjL0e+fjKxmCXJTPKvFL6kK+NYAqzjpPqWtTSLzALNwVXfakjxgiUwx/k+AQdhkJjlZfsJJHf8//s97xazWW2i5CCuf+N6lG7UBnh4kC5TMUQyiVRDUmfeTPheeKA/bfqZ4OF8x86KDX5a/sLjq8Qi6MP6vTz8CUkzgv+Rl1Y2WDM+Eac4tNz5LaXi2m9i0t8siiGWcuypYuFQdAWabxHmmbuk/osjq9ucqGMV/yMDXL4Z1ivMS24SRdAPSACNtjG/nup44VYxLmKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LtzE1fB0PojPrl5ZBm3OK3/9ti96j0eq+tuRMGdzqE=;
 b=TByd99i7MIIrxTIcexpG3MXK5tca95xrWExIlDxFKUS+rwVtOIeDMxfWLyd3i0ciIRvAJuup3QcQYO+lZK93MQtV4h75kEf0ZI+gjW3z4Np2ikD55AzqjY9wgcg4nnU6TSOOB4UKQf7F2Y9Oku7NAuGe1UXQD2jf1FbYT2gLDP4jioFkgECBB2l0RywQ3aWRALUj681nOJHzH1EU8x1YXtuHA2Nv65lcaoPCSV59QE1izeJgA3jKIhMKxyT7TWjvMd9cNQfQ4l3ryE/5rmsE3+J+ZczZD0KS+1QecgAKvQuk4ewBdygoh+DgjZFz1Di9u/OFa9hPCbKlU5Qgp9qNcA==
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 19:02:19 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::5e) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 19:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 19:02:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 12:02:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 12:02:05 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 12:02:04 -0700
Date: Wed, 9 Jul 2025 12:02:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aG68q0Uv+AuIgbvX@Asurada-Nvidia>
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
 <1f18d7a3-b515-4096-aff5-1aea31ce4f7e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1f18d7a3-b515-4096-aff5-1aea31ce4f7e@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: eedfd18b-933d-45a0-eec1-08ddbf1b20d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gbWBMfTS+q6e08U+3zsnwEbM0QlV/THggHdBPaBGqRPvGZDI3VJjJ1m8VH2?=
 =?us-ascii?Q?Pb+nArhrS2jLfHI2Ws9PI6M+7wUQYau9T24Grtdf7OCA8CLC22Yg8RqJ0LLH?=
 =?us-ascii?Q?4iMtSJUuu1M++xQkW8RXMrHbmN36J+F7+oCJhTdNRkZluqXw4XTcYpa4OKYw?=
 =?us-ascii?Q?3yFqLv+m7VonaF+b3UScrJnO+XDFn3ob284AT2fk4bCMUQo3y0SS1/XmYx6l?=
 =?us-ascii?Q?94Nd7tfdC9/D/YgBfmFcU+hcQwo1/XaJIIHSiwYwTOfmBbDtRsYo7g3jVScB?=
 =?us-ascii?Q?hebeHfSVvA8Jv2wxS1tmBxX2X1xAVBiqyqcjC6ewHV6FGceUW7vxriEhbrda?=
 =?us-ascii?Q?W00PNmnucWdA9mwznOJ8/NBIg7ww95f9pHaztL7q65eDAn8MX90wFbWTAy6c?=
 =?us-ascii?Q?Nlgv+DrHnuMTxubeI9U0AsHplVODJjDPrUMvwgYndLzDJ7lgl1pEh68Nz9fu?=
 =?us-ascii?Q?dXynjHqQbk1UZkSwFGrvPq2gvOiVFYzaRsSFcc/tYLJKbudUthioUYhU5QKg?=
 =?us-ascii?Q?ibHtNipan6Wu1Pge+kZmG0CNP1zcysF9uxmBViiPhii48EXKWKrrsoDL41ll?=
 =?us-ascii?Q?BioREjyiBOSweJmP+B9sw2pO08GoA2SVVzDeAAoc5TuKYUalpou3lOL4XjaA?=
 =?us-ascii?Q?Y4BPqAtvW9XbogiFS0AlEnF5HRU8Cfxzj0WoyV0Zrc7e0pn+UhIfZoU9q2r+?=
 =?us-ascii?Q?UsHXSRf3vS+M4fVW17G9bIL3sI7fY47ZjdL2vvHi8VLULSbcaF6eODHhdwCm?=
 =?us-ascii?Q?YSzbRQR624rQ2Jo0t7Il9/Gsx5a7QpGSzqla94qWmCJiIoXhVjhdX6IyEN4g?=
 =?us-ascii?Q?EMDguZT8GIetsoU6LYD8mlR68TswHdThpIIlH1kzqNG5iRFFfLPhnC0UGwk+?=
 =?us-ascii?Q?aoOkPuF0703NfecGhTIf1zTGY5NWjsVk7AjgHEay2jnM9ytKk4VFn7UuAD1G?=
 =?us-ascii?Q?p4ff7N/+S+hDWucghDKUzm5i5ZEnRvBWBwKBlh+qdU36pF9hdQld2TatGetc?=
 =?us-ascii?Q?9quDZQFAqt5p90rgTumIa9Qpk2R1KAk/eSOh70eL7fKRjtvyhpvn6md5VLwJ?=
 =?us-ascii?Q?Ywj3DCuMt+NQxL2QzfuWWZVoJ6EAApGujNnBG+ZdYwUZQpKv2V7HnU778lbJ?=
 =?us-ascii?Q?SWgCxydHDXnp4pBsfmC99nQsBwHArAUWqqtK+3mg8LZt+jM7R00mIYodYIIP?=
 =?us-ascii?Q?hg4bN8kJsKhuDgidMiE2ku36AauCQCtQt5SVtXCkQ9qNwdAv1EGQMwV0z+Wc?=
 =?us-ascii?Q?JXesh82hOgyiGLZq1o+vG1Id9sIfNtUmxW29QCqFqGkbIyrESPT8o67gUf4r?=
 =?us-ascii?Q?fEpF8FcS7hxvHb5ojxqEWV9l5+Fcmet7uKeoQR2aCvy1ZXlWwgAFtmKv8X4+?=
 =?us-ascii?Q?2YSYzGOi4xAz/Y2mGFKcoMHNecihm62WZHQvRCQy9wtd2s5z1rE5hMEUi+U3?=
 =?us-ascii?Q?4D5a13DyctLqPlJmwpx1WLVejKmW96dSbveKP930lfNCRaGYXCK4SBBG81pv?=
 =?us-ascii?Q?Q69NWQMnvztBbwXq1r7sF3kXSKBBErHQoCsc?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:02:19.0990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedfd18b-933d-45a0-eec1-08ddbf1b20d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

On Mon, Jul 07, 2025 at 01:11:00PM +0530, Vasant Hegde wrote:
> Hi ,
> 
> 
> On 7/5/2025 6:43 AM, Nicolin Chen wrote:
> > Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
> > a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
> >  - NVIDIA's Virtual Command Queue
> >  - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers
> > 
> > Since this is introduced with NVIDIA's VCMDQs that access the guest memory
> > in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
> > that will create an access object to the queue memory in the IOAS, to avoid
> > the mappings of the guest memory from being unmapped, during the life cycle
> > of the HW queue object.
> > 
> > AMD's HW will need an hw_queue_init op that is mutually exclusive with the
> > hw_queue_init_phys op, and their case will bypass the access part, i.e. no
> > iommufd_hw_queue_alloc_phys() call.
> 
> Thanks. We will implement hw_queue_init[_iova] to support AMD driver and fixup
> iommufd_hw_queue_alloc_ioctl(). Is that the correct understanding?

Yes. I think just a simple "hw_queue_init" will be good as the
object structure stores "iova" already:

struct iommufd_hw_queue {
	...
	u64 base_addr; /* in guest physical address space */
	...
};

Thanks
Nicolin

