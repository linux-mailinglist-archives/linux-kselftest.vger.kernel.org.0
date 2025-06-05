Return-Path: <linux-kselftest+bounces-34355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5069ACE8EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 06:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD63A88E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDD1F866B;
	Thu,  5 Jun 2025 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0qno6MH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFC136E;
	Thu,  5 Jun 2025 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749096688; cv=fail; b=lY/sr5rrf/QUCIpFPleUF1yRlcvUxmyZgsAc8x0pkYQxH0KWwN/aw6Wpo8oRKpZxFrRtguQJLKdIHm2Rg2S9FipiCNPwukWmTVxqEqyxldnsNeQb4jzp7rYJRXkRxLbTBO0VTbCtKDz3ph0u6QfzAJ+8lOI+WQKj19wzRntbvc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749096688; c=relaxed/simple;
	bh=8pdUMsBCWnnyjs5MCXuwnM9GSzmUaG5aecYBoeH0PP0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQLYqDJ9FywYqhB/WNkprjigiW35IvQV3gOAl0mwvtajPRRyIDvwf6X7iKjFS35G8WnLJjK1SnYBjbHRV1LMRSGxPNi6J3ARhcum2hOTtaCA99BlPM07W5w/S85di1ar5AEqn/kJQU5VRJqSj50xdnYbdRLSKskiPwpbFFc5muI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0qno6MH; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exGpfh44XYQ5cBey9w9dqEK0EWq0MFwtdq5engeYMgwBBXLc0rVRByLX8IkUtkpCB57WGaKhQU4/UfHZJQyFr8pbYPS06NqiuqpSVRwQ+Aj2GIlmu5dJ+pxuVi3/dN197NixTy0cR93q6Ky4PvuQ6j91ULlhbM0xKGVVCCGX14VmjWgY+ZyjHuyIpWqts+90hK/t4ut53H/YdJ6iWSpT9zwvyEshyu5XZ8NL/9mC0+m2khASpqZg+Dq1f9J+v1TCIuhQMIMdC1Ny1mg3T5uic20HdPf6N5I8iBSMl6H2fzpKYjtHx6S623U2ygaBcuuSf1Hljf/z3ceuaYbRom/JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgKKsFVdF58UbaFrttGZ6a/FWA/Vjp3HBVmzbQEExTI=;
 b=qd9G76iNfsqnYi+h2lnH1svpbA7yQFOutMb35FhkVpBqTct3OL+BlIiGd7p3nMNv4JJmkZSBDnWOOB2u9rjyxv2GSdtEwmBVQrfaEagV4RQeJEs8y466Mz+eysdOoif/Ue7G1Bp4VGDVMk3wIAoCVeHynmsDoAqRdu8B+jYR0ECXN0xw00tANYU6ax40K9ZMFGXYckm+7NKdbosczPnsP0KUJfp0taURDKihCBGek5imTTgmsmJQfhYjHuGqevECKqHrFpgPXlbq33p/HnPE6bCGx1Qok8Ynqiv33v7F1Cv+mjVa7Q9cVBVrDtrVd1u0XkwyjNH7OxWQuEn1LFn3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgKKsFVdF58UbaFrttGZ6a/FWA/Vjp3HBVmzbQEExTI=;
 b=E0qno6MHbvE0jUQpwdX+QomEIWSj0XeVkQxDAzvRLvTa//HwYBFulzKKpzpIlWTEXZsD0MGSlc33ALc9TuEQvW63IHh0eIDaj+92i3IatloD0P/NhN9zjfi0VIm1qsUytYNIsnUXer62n1qmS7Yhmt7/+MzWiCZq7yIqnexm3XDUaGvfopfsxzNIeQq1Hm1Ri5GSvUUZIu8w5B20s9EJ3HX+40IWJopF8u2BYwGrMBn5bcZ1YNV6qjEVXAswhK2xmglgMBuJJEMGmnhMJAqsMHT3Kb95KA2zv9OxmoQX6vco4TKA5SYhoFKiKTbNJqZE2ne223I1Mq3kwKZYMEhXRw==
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 5 Jun
 2025 04:11:22 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::cf) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 04:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 04:11:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 21:11:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 21:11:10 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 4 Jun 2025 21:11:08 -0700
Date: Wed, 4 Jun 2025 21:11:07 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 10/29] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aEEY28ZXH+NqiE+T@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <49f7143c1b513049fd8158278a11d9f8b6c837d3.1747537752.git.nicolinc@nvidia.com>
 <20250528171754.GY61950@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528171754.GY61950@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd7a941-2d26-4da0-c002-08dda3e707f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irwrUwdBnW4V5O2E12GDeBHxc5T0JHYiYBZPwnSO9S7xWc1jaSL0zy5hSjVK?=
 =?us-ascii?Q?ywARBocnaTF7QX8VMEtZG7rSmDjFoWY1QymUmRRa4RIMkCJPFRCO1YEF2idm?=
 =?us-ascii?Q?2HLxJoi8j9u9wtBKq4/ndembkoZ0ZZcyu0sWGvOgyNDc6tlr32PHuH0ie7Dh?=
 =?us-ascii?Q?wQjvzxRJMwc4IT9b3hV7aYd7jJpnHeGvxI/mAQCWWGhN5J9n9riitfQUOMf7?=
 =?us-ascii?Q?zORTQzoNtXBh335xQ32erYf+Lw79WzcJCIP7Br1EOMI+2ON9e/nzFLnUW6rN?=
 =?us-ascii?Q?MfwnXX9hIafGdLfPqSCxX3jsNOzwoL6Gkjw0vUdgxAhbkIBBq6IcKnqwal6Q?=
 =?us-ascii?Q?MNB2OWCxBUXG39Ol7SgNv8MV1rINoubQ5ob4X/mq8cERqN1xE3xDnIDs4wgn?=
 =?us-ascii?Q?M9AQ4KSfMi7mr3zcvTx731o0SZNmvYSLeyIflhrfjjRsD0+lifJNNVIcEALp?=
 =?us-ascii?Q?o+ofljEfJ8fjdoylaybUIEOFLxFGSO2I/52Bqqq1gGq0PxypN9NDmUfeehv7?=
 =?us-ascii?Q?4wiyTsSsre3SOhnvrA9ue3yGjBefKpsTgSloX4gLSiKkGJEFvBFfXGOII2hv?=
 =?us-ascii?Q?GFRpzOPqa9RW95TmvIuhzKuxWZLUewJLiNHJzXB0MQo9uBU5hlD3c7d3EHzv?=
 =?us-ascii?Q?6XvgtLF2Qu6eS1KRCGQUkMgKnOzH7/iakR88+0UtyE3wXEhViFyJm1kwS/Dc?=
 =?us-ascii?Q?v/26qsmQOtmKL3c2cG+P3Ru9uJeGSq0z3BG+I3Jdvu+zR5BJpQYCS8Qbs/n6?=
 =?us-ascii?Q?pMKFN15lnX/qBaSHv0nsgzYr6+K+LO7x5nkA8iiIPNbYGyxRxKLJbjhU3WiG?=
 =?us-ascii?Q?jpG/9WLeqBpt6D94BsIlTVi+VdhxdQarKyOnjNZZRnPhAcXcieAVvSMHJTmu?=
 =?us-ascii?Q?iVGh87IQTSe0VTlQsc7KwpM8TZPTb6QgPeITzJ1XLYf3QCF2WrfVcqFxHnMT?=
 =?us-ascii?Q?DnAtTopWuQj0oSFQvRP6VrixNbY7MI2WwAmQxc+eveBFoyzXT3lI7P/dZs+9?=
 =?us-ascii?Q?mRsOeb2Gdga8H3RM8cd5On6OvRQOK4S0KiXsuvZJNXBbTn6KL0Qmo1DkI6Sw?=
 =?us-ascii?Q?vi5l3rySQk/MclkRSo/xxumF1dEkXpLmhBvdA7Ikqp6CtDa87wKyZl2QoFj8?=
 =?us-ascii?Q?lGewcnp5TOBSYtO9Y3Q2pIiRe1DxvqsPPv1EKwSneFlju3aaiwAwy4TgAis8?=
 =?us-ascii?Q?YGeiNPrGxVsaVtIq/3EDkw/JWxiB9peAYF10MkrFDMWoQh7epZux4Nkl+QEd?=
 =?us-ascii?Q?tNJNzrTJp5eIxEYv/ogokHTFS60r0y89KUugwpq+rMj1xyAY6+8FfKs4cSRr?=
 =?us-ascii?Q?ZgMrNJ7sx1P34nyC6GK4353Helake0YZFh8a8v5yo+VStNroew3KkilDqt/e?=
 =?us-ascii?Q?Rn8IHESusZz7hh6mjVWbFUjqx6bKyaY3hpzVA/FP35bLt7Hdi1f0cblvY8Kn?=
 =?us-ascii?Q?tWtejYFduUrUid2QNSkPEHZg8t2Ou/TUpBbMBhdBX49t4ftLN0eTnuXFYXZJ?=
 =?us-ascii?Q?MGm61owc91+PJ135QKta6/fcL6QRdmA9ySUF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 04:11:22.1828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd7a941-2d26-4da0-c002-08dda3e707f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

On Wed, May 28, 2025 at 02:17:54PM -0300, Jason Gunthorpe wrote:
> On Sat, May 17, 2025 at 08:21:27PM -0700, Nicolin Chen wrote:
> > The new HW QUEUE object will be added for HW to access the guest queue for
> > HW-accelerated virtualization feature. Some of HW QUEUEs are designed in a
> > way of accessing the guest queue via a host physical address without doing
> > a translation using the nesting parent IO page table, while others can use
> > the guest physical address. For the former case, kernel working with a VMM
> > needs to pin the physical pages backing the guest memory to lock them when
> > HW QUEUE is accessing, and to ensure those physical pages to be contiguous
> > in the physical address space.
> > 
> > This is very like the existing iommufd_access_pin_pages() that outputs the
> > pinned page list for the caller to test its contiguity.
> > 
> > Move those code from iommufd_access_pin/unpin_pages() and related function
> > for a pair of iopt helpers that can be shared with the HW QUEUE allocator.
> > 
> > Rename check_area_prot() to align with the existing iopt_area helpers, and
> > inline it to the header since iommufd_access_rw() still uses it.
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/io_pagetable.h    |   8 ++
> >  drivers/iommu/iommufd/iommufd_private.h |   6 ++
> >  drivers/iommu/iommufd/device.c          | 119 ++----------------------
> >  drivers/iommu/iommufd/io_pagetable.c    |  97 +++++++++++++++++++
> >  4 files changed, 119 insertions(+), 111 deletions(-)
> 
> And if you do what was suggested do we need this patch at all? Just
> use the normal access sequence:
> 
>  iommufd_access_create(ops=NULL)
>  iommufd_access_attach(viommu->hwpt->ioas)
>  iommufd_access_pin_pages()
> 
> And store a viommu->access pointer to undo it all.

I found the entire ictx would be locked by iommufd_access_create(),
then the release fop couldn't even get invoked to destroy objects.

I added a new flag to address this:
-----------------------------------------------------------------
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f25e272ae378c..a3e0ace583a66 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1085,7 +1085,8 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
        if (access->ioas)
                WARN_ON(iommufd_access_change_ioas(access, NULL));
        mutex_unlock(&access->ioas_lock);
-       iommufd_ctx_put(access->ictx);
+       if (!access->ops->internal_use)
+               iommufd_ctx_put(access->ictx);
 }
 
 /**
@@ -1126,7 +1127,8 @@ iommufd_access_create(struct iommufd_ctx *ictx,
        /* The calling driver is a user until iommufd_access_destroy() */
        refcount_inc(&access->obj.users);
        access->ictx = ictx;
-       iommufd_ctx_get(ictx);
+       if (!ops->internal_use)
+               iommufd_ctx_get(ictx);
        iommufd_object_finalize(ictx, &access->obj);
        *id = access->obj.id;
        mutex_init(&access->ioas_lock);
-----------------------------------------------------------------

Btw, I think we can have an ops but only set unmap to NULL:
 static const struct iommufd_access_ops hw_queue_access_ops = {
        .needs_pin_pages = 1,
+       .internal_use = 1,
        /* NULL unmap to reject IOMMUFD_CMD_IOAS_UNMAP */
 };

Having two flags makes the code slightly more readable. After all,
HW queue does need to pin pages.

Thanks
Nicolin

