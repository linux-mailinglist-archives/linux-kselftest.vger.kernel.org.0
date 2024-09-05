Return-Path: <linux-kselftest+bounces-17307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3296E148
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D107B2673C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768191A38D8;
	Thu,  5 Sep 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="muBfJzej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821B19C579;
	Thu,  5 Sep 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557916; cv=fail; b=daDXAyuJ+oXjJzqJrWUGxgCw6QmACBPzbw6ixrYIKuxTbDM9n+hqfql+m3ZoOUn/x89qc4Ky2f0RyvlDcCRkV9Z0ETXcTeV2ZprZuiMCJ5XE8feALXtsA+qS0rDMF0xOC9GQ0WFZSFHoSCZJslHY5ANYesdGuUcn1+2OMpKEyTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557916; c=relaxed/simple;
	bh=zpJH2KZjpZxKv+GdrVVblIFgs/kB/E4/T30Qu/r65pQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1a+Q1Z3vAmxwcxa+ZrG500tt5vfSGuAv0bK+aXTSW0fXx12G+mz6bNP6iMXsXHQlMqaMymAKzdEBiWZP/VNgWHYNV9qftR2ufhxGB8o57gHsVSFw0hSvoFO3raMCbUIMkdEmAXBe4O4+dnTHuLIOK0MXeGB3uQiKCMCrU7O8mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=muBfJzej; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjTHKpYDZ3BlzSVYKJUo6pdSxmZeIseL7Zzzkwoux4EMvPj7zBG72ZwNJiNDzX5Nw6BPcGkoGjLLvcYDxgGaBbaoVPEX+MGGexTZl225QjKWadRdrT0sVh/PWeJpxIIpy/PNFUDKSrx3ROB5KwsLq1DtxDG5W0uIo1XQUEIwpG6OKw3ZbMlbOJdg8xQnDHBcS0lZi857z8M1hXAHs+EgUxVWCxHYraDzolC6LLevt04lbTtnt5ksjjVOJzM10gNpgXce4WpNIH3FWuFPoMTTM5kfCdCHi9I1yTkigts3oxiIAYF0lht9d/os+TqaIvvTGYkJe+oR+Osyk9Ciqg5WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQISXovZnY9NhLkEuyY/1Q0K6h+jOW+oBvoTYSzNySI=;
 b=AluWoa2oFF6oevOcUwihqpFYseRnoU5uCHCbYWlM+k7Zzep4pztwCSBEEr9T3fJaRXjwrkMgsuDfPsT7MLUtDlbp+RYmi2qb7YdrykIFPkhKgtelF98McBAQJ4OVIZC+x7yP99Vj6+l2lgIBMVQU3AObytiTD0Tl12IVlvh9yfZ23gRFio/FJg3heTDgRrGIauX2H3NVokUBO5zkkxBtYEowZkBeOKtyJN3ITcwrK/5B8iHGgZGfEZ/x3ggISHwfjLyCm/d9Z+hzGOa5lSrsrYl6OKmDyAR+up0R/tZZCiLQgjt0uzC5m54nusAcK5l8V55WYHzhfvBbDMUzoICv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQISXovZnY9NhLkEuyY/1Q0K6h+jOW+oBvoTYSzNySI=;
 b=muBfJzejTHnQpbN2h526hJG+TMJ8mqnT+gjznsqlQGf25KJb6Klc6FlbnHYJGiVza94hZgKRyjhotXOyyn7xzCbxBQC/RiNT036ybwujm6FoKoCquUx6PLqAKcAJ1c6MmhuMXjRgfRnCXQPEW+t6a9quYoC9Wl7So+wHOVUbWyq9fctQdLA579vO6/ag1TvgPWfMFWv7ROBCBuTfXwdsCiKygXgw3hlUzAIxSrKVhlUU6BOw8l9wqMmrTasAA0kGs2cQ01aizuZF97pF08wNdeD/DeLH7YsEN8GW6QUUOqpdLRuKqOMcKwsJIhjV4bmMoxeNiWrQeX/SuX4aKZYqtA==
Received: from BYAPR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:e0::18)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 17:38:30 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::81) by BYAPR05CA0077.outlook.office365.com
 (2603:10b6:a03:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 17:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 17:38:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:38:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:38:08 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 10:37:51 -0700
Date: Thu, 5 Sep 2024 10:37:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZtnsaWgeuuy7+cJG@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905160353.GP1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 30202cfe-9e44-40c3-fa74-08dccdd18c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0HALQQHigSE0Lrum6CwiDDnzEyyXn4/6WQdTKPJS0leMxpv7vsnPfMijXDOV?=
 =?us-ascii?Q?LQubzYQLE4Vs08Iee6nqBMjHmPd3Iag0eYQj0WWFqqWUcqZjyKHJJT1BXuzn?=
 =?us-ascii?Q?ZQbDTxiFjh+nxLnFn0lk++0bjRPVj4vrW+Wte8h9BvHuroJh84Sh/A9mrRP3?=
 =?us-ascii?Q?vNEb6hzeCtfQxJr0Qn/JuSANrl486riT+EQVbMsHs5wlDxyjI98U3rF5rwgl?=
 =?us-ascii?Q?epGhxuCnK0VNxxlEP2Mc0gtPjm91UNpq2zXUn9bO2VELR1Ajj7GQGMmL34Va?=
 =?us-ascii?Q?luBD3hpnSVLYOb5dZlXQLxu2B0SW92DLogAioECwNYq5gJ04jY11vXf2Kt+E?=
 =?us-ascii?Q?P9fdrZM5iKvHPgOHr8vTJ/TDfa0HR68gKBvn61jJ9pfEFoELYANLdYOBEsv7?=
 =?us-ascii?Q?hLcGfLhBkybfqcHT/mIW8wqvk2XSJdaNJY5qwvE4rcJmInErz4rBwWOdKjrZ?=
 =?us-ascii?Q?X8Spq0cpPB8kskyZ4Ez0PHecjBOA4e5kgAZnDQV4/4PzkU9xevNtCa0K3Kdi?=
 =?us-ascii?Q?sFnRby1amkwdzfh/XsUSkQGVLauca7mMVpHlZ6m8OLHgWpBZNeO1PY0XmbdJ?=
 =?us-ascii?Q?YUMrVNQ/z9rIyqyI/XkENDBS3Ji6WO/6qVulZwJu1Ki+MpVMe4JCFE27fei0?=
 =?us-ascii?Q?opa7P1MsI27HnoLah+JsPXOuxWtsRrTypqFMp/Fa1pCJnbG/Nuglr0LJaYWZ?=
 =?us-ascii?Q?Dvho3Y4RJWMUcGou3x05laWrfNzAlAceDYH6TVX/hcdIl6dz7N0hYU2wRZq7?=
 =?us-ascii?Q?kZHv8jttkoV3zvz+Pl0mLMWkKNE4Z7Cr+CR6EehorhiXPUZpvqvWNaZQZOj4?=
 =?us-ascii?Q?ugchj76reY3p2r+qgQw98NjgKDk91V1JSCC2Aq2s2OE1QBOA0EJXHG/OPeZa?=
 =?us-ascii?Q?oS9IsMpEAId3z2h7N6tlUXXIa7J6yx7UHAHnzzS9817CJLYcxj1Nuqs3Onwh?=
 =?us-ascii?Q?sS+Z1o1d8ONbGdpCeBOy+QCE+IkZsZIMGaqrk0yn0P9es6QCx17XlbbD0CkE?=
 =?us-ascii?Q?NdPYZtwH8P7UDnsJilBSLTr7sgdVEPegoAoI08zanHqlgZqamJ1rsKpjY21E?=
 =?us-ascii?Q?LwiUGP2TmVF5mizToBBtoR3AQgtUUzCPZ9b1LCG2Hqe5iWK8k33T29Qyf3Fa?=
 =?us-ascii?Q?Xk/v0Dq+9XdrLgX9cTdyNDk71BTK4I+Y0bsUTnEkq/Hr8EOyr+yEz4NauCKi?=
 =?us-ascii?Q?O3wR70yQlsudymMivxsqT/pCB6UbSWbMwQUzwSWHhpR/socsZ676Le65aAdO?=
 =?us-ascii?Q?v0usaDWzODhX4sJRzljwqoEgvX1xjpguW3OfqxT/3+AQxjKTIgmNFcl7b2TE?=
 =?us-ascii?Q?kVgl1+M5tN5jQLrSTMXWMWBx9Vce5axGBtZ6EWxf6btPR2C5q7+RVHmhDSQT?=
 =?us-ascii?Q?OY+R7PEDnXPGbq9RfaQJUb5w10Uz2YakpS7RJ+xM9JJbw4FBxeh8snvl9C4B?=
 =?us-ascii?Q?tqLdkqs8qSAnpywx7XNlT7nA6LlwzdP3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:38:26.4781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30202cfe-9e44-40c3-fa74-08dccdd18c71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395

On Thu, Sep 05, 2024 at 01:03:53PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 09:59:43AM -0700, Nicolin Chen wrote:
> > Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> > that should be linked to a physical device id via an idev pointer.
> 
> Given some of the other discussions around CC I suspect we should
> rename these to 'create/destroy virtual device' with an eye that
> eventually they would be extended like other ops with per-CC platform
> data.
> 
> ie this would be the interface to tell the CC trusted world that a
> secure device is being added to a VM with some additional flags..
> 
> Right now it only conveys the vRID parameter of the virtual device
> being created.
>
> A following question is if these objects should have their own IDs in
> the iommufd space too, and then unset is not unset but just a normal
> destroy object. If so then the thing you put in the ids xarray would
> also just be a normal object struct.
> 
> This is probably worth doing if this is going to grow more CC stuff
> later.

Having to admit that I have been struggling to find a better name
than set_vdev_id, I also thought about something similar to that
"create/destroy virtual device', yet was not that confident since
we only have virtual device ID in its data structure. Also, the
virtual device sounds a bit confusing, given we already have idev.

That being said, if we have a clear picture that in the long term
we would extend it to hold more information, I think it could be
a smart move.

Perhaps virtual device can have its own "attach" to vIOMMU? Or
would you still prefer attaching via proxy hwpt_nested?

Thanks
Nicolin

