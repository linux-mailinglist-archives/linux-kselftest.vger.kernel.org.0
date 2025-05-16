Return-Path: <linux-kselftest+bounces-33165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AAAB955A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 06:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6627D1BC2269
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84919CC3D;
	Fri, 16 May 2025 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umMAqJa6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64877F9;
	Fri, 16 May 2025 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371130; cv=fail; b=Fd2pEtrRVW5Gq3NiiUhBXEh7KI9c3W815PWLm2Wrb0rmEze4xdA4qP4UAIxxlyrairTjC24iSb+wMCBLXU539TYP/r+reDjuNWzLzYNG9BtJrDlYQ2X+SR8Bmqt6kEhq6TBsBFgpqvi1I/3+4UBqFHbIBWzdAEaAxKZiWSonuLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371130; c=relaxed/simple;
	bh=zlgD/3Yo8MpkR4+R1EsGgZu+TqDBagh/2lMEK5mbiO4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lelIUOqJts+0AQtSTl20gThaOf3a49OP4Nxekxy2R0FuwX206BNv/s3ob//p7HjbK1GqjqYH5ZNHpFxk898oLIyFEKpkFX2gk2Dnc4x+hJCkiNjsfuH1Y6OepObVVagXvX+BKDXmVBPixG+BzuwneSV0ozZ8W+qIDccj/Os9eEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umMAqJa6; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDZSifnmbSQib6Nge6pFNUOb1AVZEWBmMGE0UuQAoU/3R9R4q0v1jh6OVDeRZKo7KjXqCdxCVaRPMGTiJ1s+MvMhMixdgm5PaFd0kZuaxBRtjxiKJNg0xxfJnGN4Yn2M1jIY0gRVAeI4QMvf2QK4EOaAXkxlsxufUYb75KngTUa86ynaLghCv/2S4712r7+VQ3k93DxYvDxACUDuYEZRJMTfuFczz8OJgA80+z+GNEi239jXzr6mS6uQG2UtJvEMM5fnIN2YihjLnb/uue0aBbHZuqd0QutSEahh37s3oqZslhvRVrCF2Wu4N008gbTo8BeGKjDcmLSBcCQraX134g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weXXrjBwJzFCh+IyTZSGZA/izzWFQ2OCenTtyAmeMy0=;
 b=bsicX2p66SqtSB4Epkp6ZbYanDI2dVKYTsRMHpQS34VuBGhHNbuHQUC+D5xxXDI9NFcX4GLI6DXCQBeJzrplXWzpZ3/9RXOCK6goLgH7RTR0iaY3jaeXgw3nc4jamTdI4tl1GuqBWr9rmPeBCGEH0WlSJ974cXHTo5aPsjWDKhhiO1+Cpx5jnRBj1yL23srUTQq8cY7sO1j7dEXQ0E+DFiYiQeIber4Ts24UzMhxPx0gCR2xA5E/GZYJENN7W8Jpml9BKc5JDyEYni52Qgaa76qRBDQ+VBN6XLLIgKSz2Hs+sy0HiOIvaX3HAEXGM4sCxe7yWuIoErDPddvE2CTe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weXXrjBwJzFCh+IyTZSGZA/izzWFQ2OCenTtyAmeMy0=;
 b=umMAqJa6WsLEVC7zyu8+Krv1HbuAM+FaisMiL9oqqezI4ZZoEGtQLcBbG+QJtmQ6QiqjFDLjcBLj9JCbtqgATrLwggcSrO6+zDjoWQm4Qrl4pbnO/QSMjstb35Oz1rLOALDvxCdH8X7w2qQWRq5E+oX1AlkhS5wXvrzFCJePVrT0v0+9a4APDCyd5BqozUihGVCLc0GgQoCjFZOZakwgdNGuYRi0kj/nYPyNpFLq4ASz5GPje1mXQA1vSrli0A7bJPwSDkm818WNyNDy43Q2isMzsANn+HaxPLGENIz80q+rmQccLXnY8TWC6JyQZ/r6UWsnHVFvdVrg0iiCtiqgRg==
Received: from BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::14)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 16 May
 2025 04:52:02 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::60) by BL1P222CA0009.outlook.office365.com
 (2603:10b6:208:2c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Fri,
 16 May 2025 04:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 04:52:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 21:51:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 21:51:45 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 21:51:44 -0700
Date: Thu, 15 May 2025 21:51:42 -0700
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
Subject: Re: [PATCH v4 12/23] iommufd/driver: Add
 iommufd_hw_queue_depend/undepend() helpers
Message-ID: <aCbEXj2gHJ41+aXq@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <3ee7d54d5368ac59822da214000fb25273de0508.1746757630.git.nicolinc@nvidia.com>
 <20250515161254.GK382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515161254.GK382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e86518e-698d-4973-42c0-08dd94356616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4wIBXN4RCT3XMgbdIE1qw8RtIElKtE68yS9Ic/9lKXfKbHCHeFHSPDB/Yz1U?=
 =?us-ascii?Q?clwRBlUxSjmEng+0w81h+dYiZGfVRe3Jm0bsUYjQ0SoMr6CQR8Q35843CiAz?=
 =?us-ascii?Q?32pO05R8QtRcWFZeTr+mTAdePKZnjJABVcJcUV+h7qIv66G7uo6fneZi0iaf?=
 =?us-ascii?Q?c/AxJQKAaqMj6eF+X+nBfwMO4KZd3FVKV2uEfOqkm/UdDuYZX0aGTEw9klh1?=
 =?us-ascii?Q?VKyX0YwEEAfudjVvl86naz9bsreKlFkUhNnWwpaJppNw3ahSeHzKrbgsfqEu?=
 =?us-ascii?Q?yS0GNlq/wUIGj4tqVEGKS+ND3ydwkShIx5FNECXt8R2HMNO3d9AjymzOoHTw?=
 =?us-ascii?Q?/NOizyUNanLqArpOLSZ1DbjY2mRaHkq5IIytXm9roqH2AUotrJsGiheNbodh?=
 =?us-ascii?Q?fMM3RFE2nZCLxh62rPL3uJfANaynrD7mEdzfon60Vk6M4lgU+aNx+aNpsmj0?=
 =?us-ascii?Q?tV8hSTr3Lzn4nekuMy0uSFPYOWr/BbcxWo8vevMUL/n12x1fKclP18ZGsmmU?=
 =?us-ascii?Q?A6P0QirnTK2Sq2TLQCJqUQ8uqoWxGhtFTe82GRxa1kCYE2dCZhQ7mpIENhsn?=
 =?us-ascii?Q?zF24yY/PJ7vUr440B+7tIYNdiF+vE+eMIYB0J9vMLHy/6QifkxMlQYU74ues?=
 =?us-ascii?Q?+ElkpLwwpeAJy6fdQdN8zbD9uWV6ivhwaZfJhsVVAJcXMzzJpIat90gCGLny?=
 =?us-ascii?Q?+YmNnUrltQlFH7Uc6VMYy8KvsmY/SAARYzESVTMxQV2/XNHM+Kx2RhahUWSz?=
 =?us-ascii?Q?H/WpGjL0JTMh8raBMe7dl5EgVk7CQV3sVbCZWKppyTQT09z07UmPky2RW/KU?=
 =?us-ascii?Q?XlO3o7AS/WWFGtOOA195fJdfJSQLVGHcsoVM/OaiYIiAg3y92I4ODQZYu+I+?=
 =?us-ascii?Q?wv/pzD65WCOCsEu3A+q7HRAAuhoZ8j2uTZFXQZC2xbfFRDXia9yGTxJo69hv?=
 =?us-ascii?Q?7hE3Rru3sgImegrSsWCtU66UOf+zFiRd3Y/4Wv4ZqkYMdfSw1SfcdkZHIXDe?=
 =?us-ascii?Q?ysmtT1jxU7cQ57W1SRHT1SNkbFGpOnmhyDW6CEj7Fy9XH9fUyyDJqqhS4Dwt?=
 =?us-ascii?Q?j+KvcXM3slRC+9CtRKOAXOo5y7byBglbJMgBsC4Gy0749pGTiG29kFtmh1ut?=
 =?us-ascii?Q?DJxITB96Bi5aHXeb/W2VCiLNVJRLocbmPwi6t7uQdJlB3DxhlCvKdxgv1E65?=
 =?us-ascii?Q?mxlLoU2YoQF2ud3b/2SbTGL/NW8eVv7ibhWs9A3ZRa0i73mqq2R+koZr37os?=
 =?us-ascii?Q?nbaaWVxWL3mNJAh/YZnFJzhNWLBNXnaVcYo2NweiUG3agzBZPeTEwr2FRDYY?=
 =?us-ascii?Q?m4D+p73ndZY04kJdd1Td/LLLyHPj+PR3EBVFXxQ01adNTk+JxQyqwkmbmd7O?=
 =?us-ascii?Q?lPwvM32mr/8qJFxxYS7jS75dr9lXJux241tBllIOg0NqKn1tiH8LeMSDgNKj?=
 =?us-ascii?Q?Ia0jMcIrV8TiBA9b0Ga1hT9geUkJSwKF+DVq/8Uf2ilvqooh+yIz4fITGj0p?=
 =?us-ascii?Q?9AOA5s7a0LW+Nd1HmbTbClx8kbOJv8JMAMm8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:52:02.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e86518e-698d-4973-42c0-08dd94356616
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48

On Thu, May 15, 2025 at 01:12:54PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:33PM -0700, Nicolin Chen wrote:
> 
> > +/*
> > + * Helpers for IOMMU driver to build/destroy a dependency between two sibling
> > + * structures created by one of the allocators above
> > + */
> > +#define iommufd_hw_queue_depend(dependent, depended, member)                   \
> > +	({                                                                     \
> > +		static_assert(__same_type(struct iommufd_hw_queue,             \
> > +					  dependent->member));                 \
> > +		static_assert(offsetof(typeof(*dependent), member.obj) == 0);  \
> > +		static_assert(__same_type(struct iommufd_hw_queue,             \
> > +					  depended->member));                  \
> > +		static_assert(offsetof(typeof(*depended), member.obj) == 0);   \
> > +		_iommufd_object_depend(&dependent->member.obj,                 \
> > +				       &depended->member.obj);                 \
> > +	})
> 
> This doesn't need the offsetof == 0 checks, it isn't an allocator. And
> you want to check that the two structs have the same type:
> 
> static_assert(__same_type(struct iommufd_hw_queue, dependent->member));
> static_assert(__same_type(typeof(*dependent), *dependend));

Ack. I also added ictx comparison:

+#define iommufd_hw_queue_depend(dependent, depended, member)                   \
+       ({                                                                     \
+               int ret = -EINVAL;                                             \
+                                                                              \
+               static_assert(__same_type(struct iommufd_hw_queue,             \
+                                         dependent->member));                 \
+               static_assert(__same_type(typeof(*dependent), *depended));     \
+               if (!WARN_ON_ONCE(dependent->member.ictx !=                    \
+                                 depended->member.ictx))                      \
+                       ret = _iommufd_object_depend(&dependent->member.obj,   \
+                                                    &depended->member.obj);   \
+               ret;                                                           \
+       })
+
+#define iommufd_hw_queue_undepend(dependent, depended, member)                 \
+       ({                                                                     \
+               static_assert(__same_type(struct iommufd_hw_queue,             \
+                                         dependent->member));                 \
+               static_assert(__same_type(typeof(*dependent), *depended));     \
+               WARN_ON_ONCE(dependent->member.ictx != depended->member.ictx); \
+               _iommufd_object_undepend(&dependent->member.obj,               \
+                                        &depended->member.obj);               \
+       })

Thanks
Nicolin

