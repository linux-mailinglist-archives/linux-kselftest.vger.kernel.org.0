Return-Path: <linux-kselftest+bounces-31803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0EA9F863
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A087A28D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B0294A06;
	Mon, 28 Apr 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkeCY8yw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D81A072A;
	Mon, 28 Apr 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864527; cv=fail; b=pamDDSesc4xbaNtWvaF9S8LN15eKkMzySrQ5GCOl23eeSFcKgMHuABAeM5ZLKGboFaxpN6rR+xGU9k36v2aPwmlXbqW+fwB63UlTqgueDNCJouzBairXpigWEn7kvE01trN30QCvUTmYrprK+txdxQY58kg9EEVJCqX3I81Xaiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864527; c=relaxed/simple;
	bh=khbdf5gmdlVuYQnF7f89nzPuTyaRDvdk76dvmmD5vvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a117LGRdOY4SMVJh4cnmqVlxgwdC+RKf7OtUE8/1HLz4xxtusydoLs7bsUO67mlgQOB95pXXpGWdRDrJD1NNV062uT5jVauDmhfi95LkNpuAz48rdFJmyY1+cpSg8JuU6hjqcPjkC0SoSl30Fl82yCObjvtmqFQGyNUrxWxqbvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkeCY8yw; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/0Zgklb7texH9BPnQiRPFudxC9KlhY+bXZcZ7XicM5+G0dyl+IBGmYzEgG3PbOysn5mTPDG/FVPvPnGzw3bbEIE7ukjQrWQ9EwfIFnadJAGlV+fmrhQYnWeTZ4KHaM+XB332hM+/fpdsmHLqTezHvC8YHcVHJvNqnSchqqZayKd7Ea54J2putlH6+TgZo6DlOVe6Q6poCbxlKXX+694UKZc6wVp8hvS+tPeoFnWIvqCxpbOUpnyMyBUnF+jOYndLhHZRxwUE1Wnvtqijq8TJiR+tDJqC7k2wyVK0HIypkr/H6K4tuwNlJt2b7iQUEe8+ugfqeAes2iWIDDp3ceybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ow2JS5qmdHMtaRW1X7L+gY862oQC41/ZISthtO4Se4=;
 b=qSHR01Xt7jJVgO27ZM62Nd15BDomBTTcOycjKBOCt40JdQ7Qr0V2+vfy/VxtF+GjSvofwYMDTYA1r3ibV07BNNCSxGM9SDWlxklJjcYWQF3x9on4Mc6sXXJVrxpUZ0qQ1GXZtP43roVJcp/ND6dURDrms+EzMb64scBj2VRgpE/188UsbcQNb21cSc2XhnHQUX04R9l0t+xtyH+9q45wmccD9Omx60ZtcSjLxtTP3QRNGetJo/RWu+ZYEg+bS3D2z7B6b3B6/Gqaud+q8CbpBvc6DuMlzgIuuimp3dR7J3vsWgIlJPBLKUulTUxhb+2tIQ0xa9/bY6DaVAJhua9nsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ow2JS5qmdHMtaRW1X7L+gY862oQC41/ZISthtO4Se4=;
 b=SkeCY8ywbMm2h1SSyUhaEVNTlC3UfveZ8m2xQGRrI7av+kacL+x58q2rFOsmwgMaOs7Kcq3VN/oELWXZ9KzrrsPewF6QKXXhGq9rXxjrYWD26BCuSYRBPOwEEVF8Ap3yM2/ZZq/KDanL9PllrGTX+pVcV5mSJF5ZJainLbHgdfao+kND76kO7cEXen9kvLNdO6l3Zy1DntucUPlDfPrBvrgDLxhv3w9EZknvYL1LOn9tKTedczWDZinWerXw8RXBp1OIUxuZZ0vnvvHd3PrQ5NM+5DfG+bOF8noyr/jLujYrKaItnopdgadaczXUsrAyCj4d+pTLNx1qsG39Qzk7+Q==
Received: from PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::10)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 18:22:01 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::41) by PH8P220CA0019.outlook.office365.com
 (2603:10b6:510:345::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 18:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 18:22:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 11:21:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 11:21:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 11:21:44 -0700
Date: Mon, 28 Apr 2025 11:21:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 04/22] iommu: Add iommu_copy_struct_to_user helper
Message-ID: <aA/HN2CV+0UQ4S9j@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <ca032e90c0241fe0653023fcb655185dba763f5f.1745646960.git.nicolinc@nvidia.com>
 <aA-_5FQK0uZPdGVA@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aA-_5FQK0uZPdGVA@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca85158-954f-454c-5ed7-08dd868191b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zGckPn894esKrllVYbQRoph5A4lKgSPPT4rJUq8LjWYKIiCfAeVFWCLhytL4?=
 =?us-ascii?Q?hLhbbyTbhZ/cZ25qBkt+en14ZVkdb3g0M1nUTcy3+WpLAaBNDcQw8DXKK5Y1?=
 =?us-ascii?Q?s38jCe6/+wq0SokOOGxBiVIEZkL4XcgGAAy2QskX2ZbTukZyxqv7sysFl1yV?=
 =?us-ascii?Q?BkrTKmEFdV2CIUYjgL5YiPPbxoAdUC4olzJNG212wYqO8dXojQ0Mg0e8jL0k?=
 =?us-ascii?Q?D+JJm0vX/49qDV8deX5FvpaPXD35PKccyQfIpMiyluwF23evFDGL0j75uCAC?=
 =?us-ascii?Q?69z4i9DrtFmM9av3O4aGyCBmFbh9qqpY3W9dhLc6WN+oAoPnzP9LcR9VKNPx?=
 =?us-ascii?Q?QIM+XtAyoPnyJDxYMcdlRFrcSD191rIM01l08sxu6UNya8nXsWcXLB4+4+8B?=
 =?us-ascii?Q?6xzIL5p9bxoUEEMJe6Osj1nyBqvIvOzX82JCFTK74ZAEVw/yXGWULX2JDTHU?=
 =?us-ascii?Q?4AFjd48VlatZiJ7+pUfAmXPaCSUhW70kGfKWZNUxCPg2vp9zakpNlkonK1rM?=
 =?us-ascii?Q?YINhYGJ+PXSB5apk2lMlFhupK7+fBvF3gafTaKqseFzMuMoBHI4JLnUTyppN?=
 =?us-ascii?Q?6fBCW0INqPrKk5AH5OuTZR0epM8G/HlwhM22Np1gN6lCTI4ZaQs30TQYQdS3?=
 =?us-ascii?Q?gT6V8/YQ60dxPTnZli899VmnNqz5fdw/j+gxirbFeqmrxSjwnG/bm/Jnh1lR?=
 =?us-ascii?Q?d481A793l4RVicoLq6RIXGJvEZExw0N0/pokJaOjm54W4ucGYe6fOCbqn4cZ?=
 =?us-ascii?Q?b0XkQ/n9NUNu1mxPwDPvVxSp0rWc3qLd5rguRVzSGCVf6cckejla0ajrNpxT?=
 =?us-ascii?Q?jmYVVvssBtVFHP5RD7wE8RVTyX5LWENN8zTo94HIRA+b3Rv0EL5oTTjArvIs?=
 =?us-ascii?Q?OqTEos6HANCICNG4NXHYE300Us7YL8C0xleB7xxkZOFOyOmVOYpbos/WOcj2?=
 =?us-ascii?Q?Vs8hFVdQcp/B/sKJ4Gy117hRmlcnBG/dVkGo+a9hkH7nY0uwcwPlz3yS1vZv?=
 =?us-ascii?Q?caWGSz4PAKpIgsoEZ+p9EZig0iLWFnkMDSkZorrOk06XRXXgOgTzWTm2Ku7s?=
 =?us-ascii?Q?U/Tr4SWNzJ1Zdz5aHouOHkqNjH25hMMVEi6MBE+QuhsRvFsciKpQZa6v81l/?=
 =?us-ascii?Q?5GIfC12TDybiIjK7e+NG0qRbJ7Vi37r2VnvwPCTANncd3VRI+JJPYlR9cF6h?=
 =?us-ascii?Q?9mHNuMBK0lAXsWJb9S54DmfCcTYZfpeeweJGNAHaT+kzK7LfLnP7XqQndrSf?=
 =?us-ascii?Q?375zpSrHQGNXWIY3uL6I6h5LgnguKqc097ZXKF5U2aOk96OZY2jWzQmTUpZG?=
 =?us-ascii?Q?oKen2zxquWEB944yd1tARvICjBrqRaLlEbxv8i3Qic+Y8TO368o7IPmZ2rZl?=
 =?us-ascii?Q?A5nBvTTdwn0/CkDE0+KTJnCfJsFretZsNoQqvgj92c1KG3oNNk8f+oQlRhx4?=
 =?us-ascii?Q?eFV3hBAKr10lyPLyD5YAuoNicGcrE9BivvCUdBhrLLJDbqY2nFg5Wn2EvzON?=
 =?us-ascii?Q?LSNahICeFJzaMkH0mQFzQLmMShDA29CP7Bsi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:22:00.9172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca85158-954f-454c-5ed7-08dd868191b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

On Mon, Apr 28, 2025 at 05:50:28PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:57:59PM -0700, Nicolin Chen wrote:
> > Similar to the iommu_copy_struct_from_user helper receiving data from the
> > user space, add an iommu_copy_struct_to_user helper to report output data
> > back to the user space data pointer.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index ba7add27e9a0..634ff647888d 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -562,6 +562,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * __iommu_copy_struct_to_user - Report iommu driver specific user space data
> > + * @dst_data: Pointer to a struct iommu_user_data for user space data location
> > + * @src_data: Pointer to an iommu driver specific user data that is defined in
> > + *            include/uapi/linux/iommufd.h
> > + * @data_type: The data type of the @dst_data. Must match with @src_data.type
> 								   ^
> Nit: Must match with @dst_data type.

Oh, that's a copy-n-paste mistake. It should be:
  * @data_type: The data type of the @src_data. Must match with @dst_data.type

Thanks!
Nicolin

