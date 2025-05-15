Return-Path: <linux-kselftest+bounces-33105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942CEAB8EAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95561A00781
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E721ADBA;
	Thu, 15 May 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1y3Hevt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9181547E7;
	Thu, 15 May 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333022; cv=fail; b=PBVwDvi5p4ZFYeIB8+ORm6KhGBPQ1YYw4nXI43NqmzppiUWXXmzeoFq2EYrrVJXiNTHTQCJJZaKlyE0NzWNNQ3wMJVBeMUp9I3EWfNx14iaSwO8PrGFh1Jnvm1O1IX8d+zaMcp60GEy85nnTWtmCp/WthVD4wBl7pmz3TzvjsB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333022; c=relaxed/simple;
	bh=60f9YXdMg7rA6NAmTEiJLve7goXVg9LytZrxZW1e0dA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRv7WIehwkCe/6QejK8xfDSzo40Y1ik8ib8zGr/hWqHpsY1n8SU0VGY+rcqDElC7j+UTHTaoT9PIc6fhGdX6gtWdEh8tiXS4hh4zwV1gVb8Trgv9IdHyV8tGqAiBh7Jw9Sk9tQ1rabDI/47/SPbLA4lvr4Zo9NzLmlMULVFNcxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1y3Hevt; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1xHIhSZL2sKhoIEkV+DV8dSTdrbu1cFqd+sc2H35J3bheE5ReGzLMesPrI+r9D+WnAjWoSRw93j6JiHsNPZPqykw5uTqbH8rDnemCPIJwrLBIrA/ermyCh9c2v0g1f/xfSxpnHtQbGyPnUY1g20aeVO+Eajgl9twYXKYNkZSxxOi7jvEcarYbuv4yyt18kAS4cQHpYzC8l0jPodb5Gm72fmL22RUhS2+Ad2h9MX2hPTPkYIAbjQj0O25MlPLdTXg36Ttua4VMO9IQgFQzGrJCWue6YETAuR9THAfkHcc7LAo1TiSFpzzAXJck6R1W3IySocr5D1DB2tTuL5Oa1+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL0rwh7n7hqXXSKJfoOjCdUPj3va22sJvRsC149yYGw=;
 b=E6vbgB+QiEyFDln0/m7mumLDz5chT6d5qbfgjFrwph88pIF9aaY990wnmgbAmBrHuHi75RRwQQo9lPpb66MfRqnjggA5qhVLu4VCV0/EbREAUeDb3cFAuFEWuogRghSBNUP/ZFkGq3e8jQrvVqiLDNMS8q7RJNgabkpzGJNThTDjGDwh+fyEtCGX2OWo+Cg6/u9SKkKpnQS/7sfZwMoSk2otuW386u1wDn6ShNYNh+JU/PDO0tUiXbYQPH+wSpo9cXjN/p026YT9DjMuO+o2ZLYjXL8PNxPDTEATx2FYiaNPyPH4RZa/ZM4LsWHShoqUyunJ9Q6hfXOBMsyJZiFbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL0rwh7n7hqXXSKJfoOjCdUPj3va22sJvRsC149yYGw=;
 b=S1y3HevtjGA7s9hetnCwmy78EN0mIXmHUxNFjcCytYf5f69EMcKwGcUJpNqR+VYueSAEG9a4rAiLJZr28CiF4Rlla4JS0tUCf9eOcTR5VIpIFJetpDHUyQ16jYxl6pK7bYiBfDkgN7eyWmeE8Yp8aFcaaNqH9TffHvAmadfETqn8XIljKN3VqbPeqVDUE+kzG6Zo1VikU7rION001jlKsGrkGPsMgp6rXndRmGZt1ESDnKku8TvjQqeq6O15hTuIFOsMzbEQ4TwMm1FRknf5VXfuObtnygUYt3XCKOFtxu/oM3xbhYQvXZNFTymlf0RMWDTMv/TDdclgvM12cCCHgA==
Received: from CH0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:610:b1::31)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 18:16:58 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::1d) by CH0PR13CA0026.outlook.office365.com
 (2603:10b6:610:b1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.16 via Frontend Transport; Thu,
 15 May 2025 18:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 18:16:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 11:16:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 11:16:47 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 11:16:46 -0700
Date: Thu, 15 May 2025 11:16:45 -0700
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
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aCYvjeZW+7NmUtoE@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515160620.GJ382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f85620d-de7f-45cf-3c11-08dd93dcae0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGqNJCdH4poLlfXBy2rW02ppaGf1c2ma5An0SX1mW9IQGXnUvxsn/6BF1Abj?=
 =?us-ascii?Q?b9rDLKCkDvZjwVKcp1EbycKyCpjOyuZ2BWd0l023LG38b+9NSmFS45GmeDM2?=
 =?us-ascii?Q?b3bpAeqOrfctotxSgpoOb36t0/eDTBRBJKdW/yOS/vgQnTNLk6j1h2Yi5Uav?=
 =?us-ascii?Q?BA37k4yg+uYZ20jDXI+1ITs2PPaeoM6Y84+4HOWwjHZ/Wb/EmZ2AsJKnaE4X?=
 =?us-ascii?Q?pnIj7oOoIcFcf8rrW9MNxn+oKl7zglaB/xHA0N0O5Da0kkXkqNoe5Pzz7LjG?=
 =?us-ascii?Q?ECsM4rn5EWEz7TFEWBcu7irMYuz6tuhyrRba3CS+e39txTCAVWC7Ox73RObY?=
 =?us-ascii?Q?knRskQsUwfmyESujvGrVfkhAoh+fM9HY8srGZyp03CURswp6BJ5L2rQpfM5v?=
 =?us-ascii?Q?GLZv3me9Up+D4otWIRiOLHDwv2WY/yULsURgtGIZjoZlSSMBbTLuO2tNPY3B?=
 =?us-ascii?Q?7t+t4TIJWlyErWrMdxiK9n2Et2sHH3PIcnE5fGpAJ5Coy5GIGAAElJI7GOqb?=
 =?us-ascii?Q?eux/FvhuYVRUN7pQC92lUGI3f1A9tmht2666ltA7NgW5rMil9Qr6FxegpmX1?=
 =?us-ascii?Q?+xB8CApo38JdFNW3Hjq7ds/rR9reH/e5tXegR7nxXqGY/e+BvZeZ56tWp96c?=
 =?us-ascii?Q?XA9B8K8zw8dTOWDWyvi4uiQP5f6yETIWd/MA2p3eS9uHLNT1AW+IO4XA1Q+q?=
 =?us-ascii?Q?Hs/P/WlnujN6acjOlDxmJG6tjUhjKjgr2cJ7T+5OznMj817N9zI65CacQVpb?=
 =?us-ascii?Q?TE0mGMUkL4pMEMJHi5o9frScshpOZpNPInqj/Pb1cingWz3L7I4PSDpK/0jd?=
 =?us-ascii?Q?yWgzc+zDS9U79Ju3XPeKNvUXOWTPd1volmEP/+LYLY2Jbm0X1mKJQnXo5Xzp?=
 =?us-ascii?Q?P7sUiVY+jC2WRqI0/6Ph60kNX6Nd60VehPizwVRX8096LfYJ1rBvIVt/acf1?=
 =?us-ascii?Q?TZXmHLvjQXr4vwHzjrreqQvs1yerqVnq8b2hek6uYGgWckKIYHIDj/NS5lUk?=
 =?us-ascii?Q?yZAsQBKEg26iszPR1e9CLS0dbSCLvESeNT/v88zYQ2mg/MTeMi7DkkwqG5Fk?=
 =?us-ascii?Q?YOMYbWVs12WILM6iQVkjXgVPD42eaYhZ3nsEbmvhPrJWzpsev1dHOQ0iD3Pk?=
 =?us-ascii?Q?b88LBiOk3UsvyhPsQR2UReME04P25DU2vcIePVHvZIZZjAjDXRu4f7tGPp8D?=
 =?us-ascii?Q?oadg/r1HI8YN5GHtZwvMpWgQkLCNtquG0oAp9fbcdWnQ2agvkgtiZo4Mjtgf?=
 =?us-ascii?Q?EFENw1kMnPLg+RZ+uv7Q0a1xtKCJLc+9PMYUcCLmmuNufXBl/wF1QDqCXO/B?=
 =?us-ascii?Q?GGVVd3X7LA5yhYxfPEmzbFIh+sWCUJXLOpRoqd/83hbBqPNQIz3xoXxBZVHW?=
 =?us-ascii?Q?BsUZzT9Vj8/ZiQDNqcRety3rstJ9coFZp5etXzH7aLeGooPIbKId5CdNt6ka?=
 =?us-ascii?Q?zILDHg6EQ4WF7f1qRIx5pqZSFL9pFgFmt/W54RHwEa/Q6Wu8f8JUnmi1yah/?=
 =?us-ascii?Q?cuwJnC0Nia5qeeOGPH7VytowYJF2a944CUp1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:16:57.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f85620d-de7f-45cf-3c11-08dd93dcae0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828

On Thu, May 15, 2025 at 01:06:20PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:32PM -0700, Nicolin Chen wrote:
> > +/**
> > + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> > + * @size: sizeof(struct iommu_hw_queue_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> > + * @type: One of enum iommu_hw_queue_type
> > + * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
> > + *         model
> > + * @out_hw_queue_id: The ID of the new HW queue
> > + * @base_addr: Base address of the queue memory in guest physical address space
> > + * @length: Length of the queue memory in the guest physical address space
> > + *
> > + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
> > + * allows HW to access a guest queue memory described by @base_addr and @length.
> > + * Upon success, the underlying physical pages of the guest queue memory will be
> > + * pinned to prevent VMM from unmapping them in the IOAS until the HW queue gets
> > + * destroyed.
> 
> Do we have way to make the pinning optional?
> 
> As I understand AMD's system the iommu HW itself translates the
> base_addr through the S2 page table automatically, so it doesn't need
> pinned memory and physical addresses but just the IOVA.

Right. That's why we invented a flag, and it should be probably
extended to cover the pin step as well.

> Perhaps for this reason the pinning should be done with a function
> call from the driver?

But the whole point of doing in the core was to avoid the entire
iopt related structure/function from being exposed to the driver,
which would otherwise hugely increase the size of the driver.o?

> > +struct iommu_hw_queue_alloc {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 viommu_id;
> > +	__u32 type;
> > +	__u32 index;
> > +	__u32 out_hw_queue_id;
> > +	__aligned_u64 base_addr;
> 
> base addr should probably be called nesting_parent_iova  to match how
> we described the viommu hwpt:
> 
>  * @hwpt_id: ID of a nesting parent HWPT to associate to

Ack.

> > +	/*
> > +	 * The underlying physical pages must be pinned to prevent them from
> > +	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the life cycle
> > +	 * of the HW QUEUE object.
> > +	 */
> > +	rc = iopt_pin_pages(&hwpt->ioas->iopt, cmd->base_addr, cmd->length,
> > +			    pages, 0);
> 
> I don't think this actually works like this without an unmap
> callback. unmap will break:
> 
> 			iommufd_access_notify_unmap(iopt, area_first, length);
> 			/* Something is not responding to unmap requests. */
> 			tries++;
> 			if (WARN_ON(tries > 100))
> 				return -EDEADLOCK;
> 
> If it can't shoot down the pinning.

Hmm, I thought we want the unmap to fail until VMM releases the HW
QUEUE first? In what case, does VMM wants to unmap while holding
the queue pages?

> Why did this need to change away from just a normal access? That ops
> and unmap callback are not optional things.
> 
> What vcmdq would do in the unmap callback is question I'm not sure
> of..
> 
> This is more reason to put the pin/access in the driver so it can
> provide an unmap callback that can fix it up.

As there are two types of "access" here.. you mean iommufd_access,
i.e. vcmdq driver should hold an iommufd_access like an emulated
vfio device driver?

> I think this should have
> been done just by using the normal access mechanism, maybe with a
> simplifying wrapper for in-driver use. ie no need for patch #9

Still, the driver.o file will be very large, unlike VFIO that just
depends on CONFIG_IOMMUFD?

Thanks
Nicolin

