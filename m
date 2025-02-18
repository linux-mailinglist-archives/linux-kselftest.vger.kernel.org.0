Return-Path: <linux-kselftest+bounces-26887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92AA3A4AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A207A150F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF3270EAD;
	Tue, 18 Feb 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLsweDJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD626AAB6;
	Tue, 18 Feb 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901219; cv=fail; b=p/m5NqUwqzieA4G1ubKkwC3/0nYKPmtgp6vyWI+kv46L02yj+yiswwfftAqVkLTERtD0IW0Nd66aP7ns6Xfw8pk0IV+hKThE/sFfLMU9uiwHt7l1fAE9svqIxx+7YGOuovl6d0lXca6JweZLuaexiVq+o+cByoQkYmIwRrZsfBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901219; c=relaxed/simple;
	bh=jguEL4JwcOGbu5bV0nVr3wo3AKAWPqYiWZuDCt/qYkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuCWdIoWvlC+0a+8A7WDlzUwYnqjP+gN7QtXIPJpRQv0okIbRTM2t/tMNlp/xDz+W0X76rQ8O7SF1FJTuqKxXUGdpqdfiDRuF1mCNCes982/wE7z4vOR89uO6gVLDpiwGEbRY+h6kSkF+78Vk6Dyo0VRRYLfWK8YxeND47SmjLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLsweDJC; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMbkSio/kpcocyKSgibZ9+AOHaoeRsYFQ2nT+tLDeDxedkPJTjOlEaY6Bm1UbkCsoh9S8LVK0NnOvwIB0mcQQl+x8OWZCaCoy22KjOGBQ8cNqXFtyVCfgfbpzxVa6Q9yw6Pms3iQ8CUjx3yCyv/De/9lssi24fX5Am7mxAVQCRnxwmWQqY7HYJknzGNUWpYcA4PLXckxZWbhep175mSdEZgAbogEMQ7LbU9X6KWL26NcokzY59Q+ZegApSksCAKl21pmtkdaQSPpXK9Gnp+fk310GfE1MNtOBJxBFwEknQq2cOGuioudZvclMOApHhi7scTtydh7fgr8bKw+pGsejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZCW+S7G2JMThDj+eO4XgY1UgjhwsskO3ZzuQiIcqQA=;
 b=ndiuYcEJaHCW5iXPjsSk6wcRVc+Bb37u+BNaU3xy3+huombIYwX4ucYDn8L4amzAYx98OfaJXklAf9AX/1XMySyLBG3GlUuuBa+/Ojmzx5mPY/abD+t3SfEcl+ZUzH5VYFmLWCyZsLQv3bK2gFP8nbgVYvQyjVOtXS8a48wLw+9vgR7iodMw9RjXCP3iBg97Pw9Zctf/Vse+HcNNaIrFofGsSzv0ayMktgn7PB3/F3LqWfGeyn1gEVapcwRElLxFZjW4wVnSP66q9EJekeyiboZWn0GP8Mc8I0mb0U+rGA6GnoXLGNP08+ygQgahQ8YqqnGF12lg2JHKP+fAZAOPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZCW+S7G2JMThDj+eO4XgY1UgjhwsskO3ZzuQiIcqQA=;
 b=dLsweDJCrbjPPWejoY2BdHfYQquOKPGZhL8s9YS2ZcShES36qjIfwzy2YvICb17WYJJSNcAZnyfdyBNK90pCVfCvo31173E/izIdF0Fk8LDS/aN01IpsNBx5Ce4qsak3wbcVMQ/0JtowxLxtHtZTVqWOfWenu7xynz1N2KxGU9531017bFQQA4Nr/LT5oINap70fC3VXtaZoNQm0+gCr1MOERC1lnjOK/hoVRJ6/EIYJ7o3JbgX/CbcO0EFIfhuXNshkFw8VFnhk7Seu5qEo56UUj6pAG86Htv3PA5TdPa6v7IynB9Bmj3H9OptmI57wJwEu+QfEpDZ1m6s8OGOqbA==
Received: from MN2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:fc::40)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:53:34 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::a5) by MN2PR02CA0027.outlook.office365.com
 (2603:10b6:208:fc::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Tue,
 18 Feb 2025 17:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 17:53:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 09:53:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 09:53:16 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 09:53:15 -0800
Date: Tue, 18 Feb 2025 09:53:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <Z7TJCcH9iFvcEDuO@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB527614EB9CBA3BAB951B0DDD8CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527614EB9CBA3BAB951B0DDD8CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: a3157010-4a63-4aba-537a-08dd5045296f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYNFHut0zxAigKZKWPnVONghERivqmPI9KaaMcoO2BbcqQwNKC8Ytp8jy39u?=
 =?us-ascii?Q?HnBUr4RAku/pf0PlgUB2j8Xzy6Zf1FHO4elAYwBCJ8IBTQ9zdzTCf1gFxnxj?=
 =?us-ascii?Q?1DsWgaJ2u7MFM7lKkCDL88j5L+H38I6PiF6Ovy0WKb/PAviN8I6E3QWn462s?=
 =?us-ascii?Q?gZbQzK5Fh6ggBZgpLjq5FiVUiDHoLeXbdgMhMkCKxkZntaSnVHxAxqBBxDWL?=
 =?us-ascii?Q?bZQGbjPCuLPXg4Ohs/2aouZEyNd97/Ugq9g+xSznbiDmx+Xls31OUlBKPjCd?=
 =?us-ascii?Q?SrqZH1HUHL2ygJ1guIYNg3XT4YHrq5QoozZx+mMtIFg+Fsuu014YCGt1uewA?=
 =?us-ascii?Q?lY+nhxjH5XDAqC9skyi+dpsABIrKjp8sFrEHRoRvM35oKt55C81JtnCBW0bc?=
 =?us-ascii?Q?8i51hG5RSNiJeBsbwR4s1UBrxL4F2TCER0nEznmDO1NHmFdO1smIMelB3plV?=
 =?us-ascii?Q?WFLxW/HdUNNL3FzTa6ZZWiX1sq+KXcJnzp4s0odbGYB48448La5qrhxdmGtQ?=
 =?us-ascii?Q?Yl5E8YRufkgJMzLV6gORTuA+ViDvGJG7/nz8IBnD6M6fOYZnqJJnhorPWceH?=
 =?us-ascii?Q?gmTFLxoiSAKiWyo9Q9O9KifToJPU3a3AKzUMd40fO15gVT7FZS2acVdJr4cP?=
 =?us-ascii?Q?gJQOSDa980XyzoU16gVdmvaILQa5kXdO7FNouOHkWGUAu0y1KconqomKJKdc?=
 =?us-ascii?Q?QMdoUAlhFyOTV/ti8fHrAESffA7ou56NpZpUWqOvuHBIFBrJj/5dDqmjZucC?=
 =?us-ascii?Q?w4F7I7j5USm2h1ewSw55Utt88uyZkgkPDWrmx6nM/JZwJItsTNQSII5yKuXu?=
 =?us-ascii?Q?E3c2I5DBmHunhoFcwE2TNhTTTuz0aNZs//CU3td7TLWVryCneTMjBulJ5otz?=
 =?us-ascii?Q?6dBaODkX3YqpcJA4Xc42Dmf8za/Aw8cFIM/WnT8qBzEQUoQcPPcsmiTU5whL?=
 =?us-ascii?Q?1Ee6ORqwphWjmIuqiR9bzbsRx/zDOrPjeZF2acir7vrtmG0hhrXt0z0/HPNT?=
 =?us-ascii?Q?NozTDWYEKsPjqdc8buGITR0i/LWNag3pomwhkRZGLJ7/ngR2Dfx/ZFC58gge?=
 =?us-ascii?Q?LNWuM8B5UGGH/IjeEnLyLFPIUJohJ/WAFc0WOA8uoSx9pmITGiZBD66uB3cl?=
 =?us-ascii?Q?X4oYizzS3ApjO2gNKNG51pQLzMAd6qlQJ4maX/WcPG8EmspW6yFXi1/Prdx5?=
 =?us-ascii?Q?GqTnsGW4Jqae4kl0g0v8KLzoCHTVA/oCkGcfI5Xv5Vszvof7W4f06d+J5H2o?=
 =?us-ascii?Q?mW/D0NkA+St/57KsF/1aj25sO/ZYlgWsgVgB6mtLSVMOjrJ+4ZQmroOFLNu1?=
 =?us-ascii?Q?fB9tJOx6Up8twqISAoTo1SDMkxi3Uw1DTV222E3FUUwbTA5zOaYBon2ROJ+n?=
 =?us-ascii?Q?DrOWEiDT0N4ZWqHPENkdc+4DG/bWZbZ8irKqzuPKD4kyKx0iahAXqZZl0XsX?=
 =?us-ascii?Q?mwqzOC1TNpyDVcdh2vhDi6XxVudxGH1LL7aAkLutSDAl8402SoClvGTLxrXU?=
 =?us-ascii?Q?jS//ENRwu0RrCgE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:53:33.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3157010-4a63-4aba-537a-08dd5045296f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

On Tue, Feb 18, 2025 at 05:13:47AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 25, 2025 8:31 AM
> > +
> > +/*
> > + * An iommufd_veventq object represents an interface to deliver vIOMMU
> > events to
> > + * the user space. It is created/destroyed by the user space and associated
> > with
> > + * vIOMMU object(s) during the allocations.
> 
> s/object(s)/object/, given the eventq cannot be shared between vIOMMUs.

Done. Adding an "a" too.

> > +static inline void iommufd_vevent_handler(struct iommufd_veventq
> > *veventq,
> > +					  struct iommufd_vevent *vevent)
> > +{
> > +	struct iommufd_eventq *eventq = &veventq->common;
> > +
> > +	/*
> > +	 * Remove the overflow node and add the new node at the same
> > time. Note
> > +	 * it is possible that vevent == &veventq->overflow for sequence
> > update
> > +	 */
> > +	spin_lock(&eventq->lock);
> > +	if (veventq->overflow.on_list) {
> > +		list_del(&veventq->overflow.node);
> > +		veventq->overflow.on_list = false;
> > +	}
> 
> We can save one field 'on_list' in every entry by:
> 
> 	if (list_is_last(&veventq->overflow.node, &eventq->deliver))
> 		list_del(&veventq->overflow.node);

Hmm. Given that the overflow node, if being on the list, should be
always the last one... yes!

> > +struct iommufd_vevent_header {
> > +	__aligned_u64 flags;
> > +	__u32 sequence;
> > +	__u32 __reserved;
> > +};
> 
> Is there a reason that flags must be u64? At a glance all flags fields
> (except the one in iommu_hwpt_vtd_s1) in iommufd uAPIs are u32
> which can cut the size of the header by half...

Not having a particular reason yet. Just thought that a 64-bit
could make the uAPI more expandable. It's true that u32 would
be cleaner. I will make a change.

> 
> > +void iommufd_veventq_abort(struct iommufd_object *obj)
> > +{
> > +	struct iommufd_eventq *eventq =
> > +		container_of(obj, struct iommufd_eventq, obj);
> > +	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
> > +	struct iommufd_viommu *viommu = veventq->viommu;
> > +	struct iommufd_vevent *cur, *next;
> > +
> > +	lockdep_assert_held_write(&viommu->veventqs_rwsem);
> > +
> > +	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
> > +		list_del(&cur->node);
> > +		kfree(cur);
> 
> kfree() doesn't apply to the overflow node.

Oh right, that's missed.

> otherwise it looks good to me:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks!
Nicolin

