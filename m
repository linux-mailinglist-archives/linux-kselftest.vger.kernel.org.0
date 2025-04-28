Return-Path: <linux-kselftest+bounces-31809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDDA9F8E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA501A85909
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BC29617E;
	Mon, 28 Apr 2025 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uwtjf7qN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910EB26F478;
	Mon, 28 Apr 2025 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866498; cv=fail; b=EDvx8paNpegi2NUKiyf5Jm1lLuDthh3E1kLS76WpuB7XbRfJLWRdQQa1RuBBCOYdSqVuawGZ9ZnZC6DLiUkjhTJmBMyNJXvsqCgT1CxMehfF285TQA+HhgnVkeg8MTxBB1VMzw8pgPyqvxtT5BsO8Zif7Mp/CzqjrTELiVDKf8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866498; c=relaxed/simple;
	bh=py9x27MhaHqL6eUorNTHPc3cR4A8ZslT3k6JzCl6QU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt8+9cnljpWVt4Pszq6JKlKZTETu/cwXPROU2As7oi5gLYbTd/P4YSo4t56LNkcBXz3c6nyV8A/ly8Rg8vBBTc2SlhUPsxDtfWfRwTz/lWhlJk4HP5hoxAM0VVKuDvv60vLxkthTEAxTqLxf5GImh3DhZHWmhq1opHWfiop0Jzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uwtjf7qN; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjvxiRsuLeBHXHbdfy4gq+5/Yp+SA2k07Q6zdxXL6bmmh6R056Z8QkgFmsTFtyjjAcYwtRMb15SlYLzdWf2Vfso6FoT2M5wp4GrcrDaE+l89rbGJKnQeZVv/+kwotJgq2im6InanHaFBXz5QSPRYBEGSQE2q5L7NsKoc9mqrvlj1J7U9jIK2JVur9ec2cj98s19XPhMIzhV/WwHk0NONVk3WaOcpuwFsTpO73YEgtUGrXLajcoKpFryCzyxyT4kS7qVKgK3nv4Yoh+sKgdmOurJ1jLCiPycQG9lWbORnv1IjubCMMh/Zu1H0QkGSvTAhFkd3dw6NKY9Yoms2Yghsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XofZIRi+6sx4PvT/SsmA1lRh7pOwIOqG8DJIB4g9lY=;
 b=LpV+yBzuyUjeiIB1DPuQo68xAB3KQApGUKrf/MN3MmZJ3X3xXPt6sHbA6LrwrfTSdRNU7FhgL4xvfxL/IvVk16AAKwiyceEftBpG/0xXL8JUIJmHDLqQRp5QZgNkV0gq04D5HJsFMwuwGnK1cYXkvwtlbWF1ppTEZ2tup0hnpht6Y5MaCCaUObk58/NnOdNQ6EsuPqSWOmTl17gaSgRYA5wFtbSAAnaGadB8ih2bxb7/HtKcM5ZPXylYR1EhsHCEcttanVnsUe25X/3osNf/ub6xubI8jHiSkq6wD39fHVZ/wcUA3/CRNH2w54MHR2XETknKLAzupdcfuQ0So3//Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XofZIRi+6sx4PvT/SsmA1lRh7pOwIOqG8DJIB4g9lY=;
 b=Uwtjf7qNTgVMkR+cwy4zgtmtp+gl8d4SbywTm2GTaNt9kQZEjO+WHUsO+ADTJ0HkJ2BRnxhc2UreZ9B0vYVbYFsstert6HluYdPXE8LZYj1PqZvw9R/FUaeOrrz9YcJap/1RHcuaaZ9W18iLwO+OpDBopeHhfQth5brDYLuDbgb1Uwj639w4uaoimkjMS8cHRBBXEvDL8IurNR5LV1XlZmB/JfFw/T2xNokq1oy8Qwl8uNNUlr8I6u0hCT2s9IJ27KT4JxS5VUQdT8e/2lhejCZOZKXZM5lfMLNLduUddO5a/wkgsf+qDfinSX1Nzr8oLQ/p+V3VR4He5sKTBTdTuQ==
Received: from CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::14)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 18:54:53 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::4e) by CH0P221CA0036.outlook.office365.com
 (2603:10b6:610:11d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 18:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.2 via Frontend Transport; Mon, 28 Apr 2025 18:54:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 11:54:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 11:54:18 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 11:54:15 -0700
Date: Mon, 28 Apr 2025 11:54:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
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
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aA/O1eeEJx6ZHdfS@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: be08db45-80ff-410d-0ccd-08dd868628d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cL+/9uNRQ1+IqI41E4s4xsfbaiKNov+D12S25LpLXDTQqci+4w4RqkvWPDxX?=
 =?us-ascii?Q?8oL0OYWa4muh5zmvzJRB18x4lxaZi1hOhZKnG2MDXwjLkdkFhtK9Ie+q01Xx?=
 =?us-ascii?Q?4q7iGorR1kml7kKbbajGOeH823UyMTmDUAiQk37PW5WEsKo9elJAwb6cvU7K?=
 =?us-ascii?Q?Li86+RmEjtvB2qdwzsYUQzQp8Z8LAyW/uhYyXM5oC5LGzBE79SLLECrLhmu2?=
 =?us-ascii?Q?zOiKRUXvPlajcsmG31xlNZdV9ocl1Md7DJgtbxMWtZmBz3bsXANGQgD9X+0f?=
 =?us-ascii?Q?dXwecUFSX99enBUjUK1MFBTj5DtlcP/4YrfYwSpHW3ak+w+r6dlizxWdpeF/?=
 =?us-ascii?Q?ZWE5zaCM8eZOAET92XZonAvwu+uOMSFgcFX+e7DI0BghG18t1lW6ZC40wGui?=
 =?us-ascii?Q?d3MVXzkcCUmdF7MlAhS8SdgGzz9W+fs1dU9IA5C5djTz6DGeD4AtRo87GUrH?=
 =?us-ascii?Q?3SWkGJICwIu3g68RZNx/ougZVn8N2KfgZBiRibuJtGb7CWpYtn+VRa9IHzjT?=
 =?us-ascii?Q?/Tanli/9Y+Vq5A34hMAN9FKTBtWvMJVHGBB1KnquGMn1befsNzBygR78XK6Q?=
 =?us-ascii?Q?tCNuMAASZJ2mMucQOEzvcCzDw/MYuJTUiQEQUw8aM4a0NrsLg/WAUFL/YvgQ?=
 =?us-ascii?Q?ZiiR5J483wxDh7GnmLwVagerrXFE1l7jkQbNS5V21JW24ChywyxLTm4tKI5M?=
 =?us-ascii?Q?coQrDE4Zu5lLw+dT3x+J3U774ZMemxJGxcH4oNrnlmJvNsbZ2ACkCiYB/ujp?=
 =?us-ascii?Q?A0IKc7k9yzFfiojTsJtrg9HN2SHOCDiA/Ghl7xOJv+7TSQOt+Awon9SVKGut?=
 =?us-ascii?Q?wSAu//Ew7y83UPZk1V6ad3yUftLXqjKCZx8m+uIB7pCut/TZ85KGhoxR91Ay?=
 =?us-ascii?Q?m3d5UFRahYcKOAm6OYOqtzapZkxR6k1m6q1Z/lG1pYNK2fK3k+rVigLQ2g5/?=
 =?us-ascii?Q?wjEZm1gacMgYZTMBr5+zhYQkseL5aKCgl87NiGktcmkAk9O+oRUdeS5E4b7T?=
 =?us-ascii?Q?Op7BhnjezNYaIFj9QovwSjSk3MT+UI3VLaZ+2QNsqTd4+X6Px7YsBEj7YYuI?=
 =?us-ascii?Q?9DuHtRALg1A6lkZtU+ZPDz4u/ou9ys2GFYbBqEQ2ML/LFPllzidB0AV0w1jf?=
 =?us-ascii?Q?sHZMCsgAmV+wFDme7rr13BUhk87GkLDkCC7tLBMkxfmuWsCRnG33kvED7u7v?=
 =?us-ascii?Q?8KmbqxoN9INSKeHCx6qkgafXF6ZSSeA3QVD5VlP47OwaaiXtrhwcDg0Y9C8y?=
 =?us-ascii?Q?meVfV0kNQhYeYg5kizGxa4rOaxKWPRvxicbITkrP1MYmfZJUny5r6Kf5qofi?=
 =?us-ascii?Q?nxvaOj5Ivr/ojsC/JVvSibXEuj0A+rbGSxacBcAnAdjep0ZwS5tHGzQeV70F?=
 =?us-ascii?Q?/TMm7mKmTT9TqwnHppEgRJ01i3jGIMS54wjKzeaF0nx/agE7tMoG3e7NQPjM?=
 =?us-ascii?Q?zI+MmZ+jmTMRcw5cjzoZX2Tsf1aI7RC6CULL/qTDsNJWUkp+WZvoKvrukHav?=
 =?us-ascii?Q?tNrvUtWN+inoNwks99JVE/BpcDfWbVCkx1p2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:54:52.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be08db45-80ff-410d-0ccd-08dd868628d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On Mon, Apr 28, 2025 at 10:50:32AM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > For vIOMMU passing through HW resources to user space (VMs), add an mmap
> > infrastructure to map a region of hardware MMIO pages.
> > 
> > Maintain an mt_mmap per ictx for validations. To allow IOMMU drivers to
> > add and delete mmappable regions to/from the mt_mmap, add a pair of new
> > helpers: iommufd_ctx_alloc_mmap() and iommufd_ctx_free_mmap().
> 
> I am wondering why the dma_buf mechanism isn't used here, considering
> that this also involves an export and import pattern.

The use case here is to expose one small MMIO page for user space
to directly HW control, so mmap seems to be a good fit. What would
it benefit from using dma_buf here?

> > @@ -55,6 +57,12 @@ struct iommufd_ctx {
> >   	struct iommufd_ioas *vfio_ioas;
> >   };
> > +/* Entry for iommufd_ctx::mt_mmap */
> > +struct iommufd_mmap {
> > +	unsigned long pfn_start;
> > +	unsigned long pfn_end;
> > +};
> 
> This structure is introduced to represent a mappable/mapped region,
> right? It would be better to add comments specifying whether the start
> and end are inclusive or exclusive.

Yes. Sure I can add that pfn_start/pfn_end are inclusive.

> > diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> > index fb7f8fe40f95..c55336c580dc 100644
> > --- a/drivers/iommu/iommufd/driver.c
> > +++ b/drivers/iommu/iommufd/driver.c
> > @@ -78,6 +78,45 @@ void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> >   }
> >   EXPORT_SYMBOL_NS_GPL(iommufd_object_undepend, "IOMMUFD");
> > +/* Driver should report the output @immap_id to user space for mmap() syscall */
> > +int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
> > +			   size_t size, unsigned long *immap_id)
> > +{
> > +	struct iommufd_mmap *immap;
> > +	int rc;
> > +
> > +	if (WARN_ON_ONCE(!immap_id))
> > +		return -EINVAL;
> > +	if (base & ~PAGE_MASK)
> > +		return -EINVAL;
> 
> Is it equal to PAGE_ALIGNED()?

Yes. Will change.

> > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > +{
> > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> 
> MMIO lifecycle question: what happens if a region is removed from the
> maple tree (and is therefore no longer mappable), but is still mapped
> and in use by userspace?

That's a good point!

Yea, mmap() should refcount an object to prevent its destroy call
where this iommufd_ctx_free_mmap gets called. So, these two could
probably be iommufd_object_alloc_mmap/unmmap().

And I need to find some callback in the munmap path to release the
reference..

Thanks
Nicolin

