Return-Path: <linux-kselftest+bounces-24408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC6DA0C2B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45817A32B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A41D14E2;
	Mon, 13 Jan 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5wd9O6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20E1C07C9;
	Mon, 13 Jan 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801102; cv=fail; b=Agu93egdSifzecaas95YYkVla0iBaHnK76zt+4oNZLefljiVql+CHX8QFR2Em8CdRM3W4rrlHo58rjw4wCwW3wBrvYb3tt43JJ7R528xYyCIZSJmFXuEcVGI+6zNF6rNbDW12RgdGwPeFgR6iE6SqCSZnLxVYtrqXziBzCGHoTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801102; c=relaxed/simple;
	bh=ngVUEHjiHqtdqBwX40inYHjDgK2vCC6Dof9qfnTXLow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUaPV9aJ7Sh+O1g0l5ml/isC/3doA7Z6U8YjoKiHFVpSXc41qnH7fCHqRGlz8JT0c+N+QCFAVq+TTcoPxibCuj26D2KdRjpmq1Diqya9PfKOJ9YGBjireq0yR3zmFXKrMtwCRTOxX8cLx+bTWzdyvir+acUjVvTQtC4oKCFhHxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5wd9O6F; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj1nBoqmV3yYCaY2Fk6GhmNj9zphe+mquNzTHYCxhvJJOkFYLLc1eM3MOn4U4t30AWDXNw5Xp34hXjPGT8wN678VY8CIWqPtQZu0euyNYlY3utbn/dWeN1u3CnDWuNhjLFf5cQpbzW3ZNWDCNbwokCemrlLySoCdH6GGVrlUiOwk5/AxG2U+xAmAOKpMxvissWm+rYD4/ti4JQpPpWmeRGdDDBJF8szi+48HeykoBdv4LNfGkgh4DJ7tu13kxfF9GizYLdZUvv8IKFKQl3yTYhldMlh/fjmWxvuqyCYCd09v8aMsSrhJo8w73sx91za6760WRlIaH//bvx+dSilCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neC8swkEuw03PDXTtFTGziwBfO46T9kvPiTjQuZg9eE=;
 b=B9WzOISv9cL09jELXu+wMRcAQWSlYQfeR3zUY2z3a+B0uZnHtKaBr+QHvtI1WJphsNtUjDJCjB1iU2y0iMDT5HNbpe0qooV3XT8UitFLdRUCVLzHaLI3cCQkX9MGrUNtzXJ9viA8HNp5aVSJogYZHj59eL+S3eeOm4+5Qs9700vlFjvbHY7MaqxzRvKBATcoaFRONnUsCGTxj0lCTxzHQgzRKeTxbVqTUPaghz/TASyBhQhe+DyjcFoYTbCuREqjgPdHDNTJNFzyq8tFtzvjV41pJbPQByfUrAbUr3blYf7TtqF/sD4IzGAccbtIdWj6II2m4XQ1VaL0yEIdqCA4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neC8swkEuw03PDXTtFTGziwBfO46T9kvPiTjQuZg9eE=;
 b=Y5wd9O6F2z4NevbM4v6OvyTMxTOHg7RzTBVrK8c63B5YXcO0ry6ciTnB5VbzBrXRhcoaN2TQcKmwRdr2+4hT5ArTUWC8F5mPgYI+xLZAy3uoOsYwBRjB+aLhbHaSrxWd7sDzSYwOvTQaiE6suxsYM5Jd5b0+lqMvMOLtvafZiyHGH+NCR8vRj2JdxKhzFQs4u/5D7B9t0z3xHeM6Zt0cz7pIDlIeQbVI+DNA2vqAZxkBTyuh/pU8h8djsuhW1vhn3qMaTzfy2mWt7oOlBQoESR0icSQjBCbzgsrc7t9S7W6mcYrI2Ijz6ZKKFi9NGyfD9jcVHMXgVBlnPJ7PhYAHLg==
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:44:57 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::f8) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 20:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 20:44:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 12:44:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 12:44:40 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 12:44:39 -0800
Date: Mon, 13 Jan 2025 12:44:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113195433.GV5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: ac85281a-37a4-4838-6c83-08dd3413242d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FlPLho091fwMX08/BwjJzhAoWn+KQD8ej7xopkQzmoKrcyX4ZLOFn1N1/VYc?=
 =?us-ascii?Q?dE1Hin/bJPjpZmOfcTWcpsGUrGg8tybn1rqB9+OCq+nKwpSyRs8BIGuF855J?=
 =?us-ascii?Q?nNMmqbZxgGprighbhed8HSqijhg7xQdBp4lSjppoOnjG+3/brBPm+bU1gAFv?=
 =?us-ascii?Q?yhx0ZCz8J+6c+F/m2AlHYEmUp9I/UOGeFfTbnwfl4blNOnptl+N4p+8oexdm?=
 =?us-ascii?Q?PO1vqOJT/ot+cQb9PJVIGi8Ffsq7YlC4Sh0CQiVsXQYa0oasJLyGUbfmt36c?=
 =?us-ascii?Q?T77EJeJ4UvrzxN4ssmveBBznhTflyJiEb++WB38rdDt5eaHDi+CUh5KfYRS1?=
 =?us-ascii?Q?AgoiUWvc0vD39evqAi6WeebVbQMp+5hM/ZbuZp2Se7jr/T6ist2Ps+AKGPPn?=
 =?us-ascii?Q?OdOUkr5HyStG7Waf05x6z9ti3AHdm6ozVSa0N2aw2wh7zpreNWNJO3gsOJAn?=
 =?us-ascii?Q?FaX45mfakCYSWCaEdhCYsC53LxcesQFrprxRBSvcpy2bWa+I68EkM+TjFLYq?=
 =?us-ascii?Q?nYCSFxeCk54EZlG3J5v9DJhVqdZCIQRk3/3jPuKKMa+Vn2kLkN2xAtJUYTV7?=
 =?us-ascii?Q?JBFsY8iIiEYVW3dPIuo5QXGq1T5e6VG9nYnNT3+FLWqenaOuDmkBQvmvozld?=
 =?us-ascii?Q?FaAUAbEyEdvDVDd1jpvtu3pYoNYpGojVKdIVl/8g//zGWbW6FmnMILuNPT8c?=
 =?us-ascii?Q?Z0UC3X21x6a7k+qATZqpKGjH+lIhM5IbRN1OKoedzcVsYz/dgJwYcbu00kdp?=
 =?us-ascii?Q?UqGHUDxYC2xA4Hi2kQ2ch5U+8ZmcenWwM7oM/U/j6gh1d7A+prq+0kVXLusQ?=
 =?us-ascii?Q?D97TP8QxHyZKRCeucZZaW+LyTkTkgVZFTXcxc1okChn1FzqfbL0/xaRJ9v6O?=
 =?us-ascii?Q?RWSVds9Z07Zrek3BMgkdeKJRIKP8XbPEYoiNmuizbRz6N29qQUsBMMWtnL8Q?=
 =?us-ascii?Q?S+kN7LYvlzzuOD5J6V4RBA8/8vDo/WoyemGkIrA6GIpEpHZqxmki2ppC+4sp?=
 =?us-ascii?Q?8g9sXSoe6rtkkqB0IszyuXIBCL5KFgTztbNt6Djy83ecHcLR23oaN+VOAvLs?=
 =?us-ascii?Q?FK1I7JOQlR+gbxL2Xgk8T7BoPgJHEIcf8yiKjrAwY7/7w6XLbyOOZDpNBHMF?=
 =?us-ascii?Q?qmDA1RWAO8KK/EhVLITOnw1UbTtrzvMrXl17Gk8mruDkBf5DdV/fLyD+hfE0?=
 =?us-ascii?Q?WAUouEnUfz0N3nhfaPsA+XY8F48ph1Htms/143Err1rivgQknaaFkmQPbXi6?=
 =?us-ascii?Q?YLfyoe4XKLQNNCRGESQqeH4qBlJYgODWTxdMel7N/hjDpBxmC5Svi+2yqq1/?=
 =?us-ascii?Q?8R/7sUtalDzjW85uvOlvRGiNwC5P4kP6TKQNacPGAPVwwJFYTcvb3SHFXJsr?=
 =?us-ascii?Q?JLdgg0VyOVtsa16kQQObAJFsBIJ79Tqnu+TCuRVY1vTFA8ZnMjajnGVAhB0v?=
 =?us-ascii?Q?3b1Ks3w0Od4So9emlB+F+X1Zu5FUxzkaMqsliGex30P/xyIE5X/1CqOXAy2u?=
 =?us-ascii?Q?87x35+1htXktY2g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:44:57.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac85281a-37a4-4838-6c83-08dd3413242d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283

On Mon, Jan 13, 2025 at 03:54:33PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2025 at 11:47:52AM -0800, Nicolin Chen wrote:
> > > The other approach would be to add a sequence number to each event and
> > > let userspace detect the non-montonicity. It would require adding a
> > > header to the native ARM evt.
> > 
> > Yea, I thought about that. The tricky thing is that the header will
> > be a core-level header pairing with a driver-level vEVENTQ type and
> > can never change its length, though we can define a 64-bit flag that
> > can reserve the other 63 bits for future use?
> 
> The header format could be revised by changing the driver specific
> format tag.

Yea, we need a header format (or "header type") when the vEVENTQ
is allocated.

> You'd want to push a special event when the first overflow happens and
> probably also report a counter so userspace can know how many events
> got lost.

How about this:

enum iommufd_veventq_header_type {
	IOMMU_VEVENTQ_HEADER_TYPE_V1,
};

enum iommu_hwpt_pgfault_flags {
	IOMMU_VEVENT_HEADER_FLAGS_OVERFLOW = (1 << 0),
};

struct iommufd_vevent_header_v1 {
	__u64 flags;
	__u32 num_events;
	__u32 num_overflows; // valid if flag_overflow is set
};

> This seems most robust and simplest to implement..
> 
> I think I'd implement it by having a static overflow list entry so no
> memory allocation is needed and just keep moving that entry to the
> back of the list every time an event is lost. This way it will cover
> lost events due to memory outages too

Could double-adding the same static node to the list happen and
corrupt the list?

I think the vevent_header doesn't need to be exactly match with
the driver event. So, maybe a vEVENTQ object could hold a header
structure during iommu_veventq_alloc?

struct iommufd_veventq {
	...
	atomic_t num_events;
	atomic_t num_overflows;
	DECLARE_BITMAP(errors, 32);
	struct iommufd_vevent_header_v1 *header;
};

The header is a bit redundant to its upper three members though.

> For old formats like the fault queue you could return EOVERFLOW
> whenever the sequence number becomes discontiguous or it sees the
> overflow event..

So, IOMMU_OBJ_FAULT is safe to return EOVERFLOW via read(), as
you mentioned that it is self-limited right?

Thanks
Nicolin

