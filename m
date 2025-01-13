Return-Path: <linux-kselftest+bounces-24398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB645A0C124
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989523A856B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE681C5F0B;
	Mon, 13 Jan 2025 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ROSjsiXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5F1BD9F8;
	Mon, 13 Jan 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795747; cv=fail; b=AWuJ+VzXPKIDVYRZoZgECu5zUJ04c2mLGE39u+d8BAB3gZbsIljD3wGOlMU2fAFCVzfNgCFOY+W0dlGnp3gz2NQ6lfT7hgzNSDjseTJ0nLs8iaMFYnTD5m4ezlMLCAtDBT9YgW+mcJE5FHVbk7tuCKZ1Y1glk7WTtSfQ2d5ouyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795747; c=relaxed/simple;
	bh=XH7/CSq5AXiuij6wkGurhsnuoQ33n1GUN5rxgqiTOt4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ31ZSyL+w0IPolX+PyprxoYr73a40j3sZzbEBgS+QYQ52zNOeZ+1CQWz0geHgNJUBIkWkzaBKHCKzAj4WxNmp38VWx2AbdD9YHAb+X07MSmPvqT/XNkQZ9bwFnkmg6mZQaiEjmqfbBpcTUN1CoQR+5NIbsNYhu3oSRIjkarb3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROSjsiXi; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqbQbltcJqduCcTZ4354OGQ2L++Tmck4MxbrjfY3r/6dhXEtZI7jj2SQJ0i3e2Cjxo0SWxsT1zoMRo0S4Ub5qh4tjUNjerZTed94DomZ/Bz/VEp2gzSmPLPQNO8LP5/DV7M7OgPeeNc5ryej3hEj/PFYo3xyVRRqHql8qU8A5eqPZopFaKFI2C8yZs8g24ItAFwJoyliYtXAAh+32yLTt/W6GZULxjA9PXM/jtUVYbQ++j0HXMRGGuHjm8ran0MOnWPgJuqWsota3QSCj8wMu0J0qmxGyJntdO5XzqPJ2+LYtKFZiIewxJFmkkHy3LlHyeLdsYwZX2XlfIJW54gqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgH/bYoXOlU+D6BFKNzLvH0Vgy+IJ7NgGRWzYusKxTA=;
 b=e9JPd23ANOeLcpr8SJFvwl/85/gRrmprLB2tlyvoBsJqY87NL0wxirkagKjg/0/m9ZSqOPFzkcrpX27i+IxxTVs9Ka1ImmEUoWEdYshlI2RNzNfwdj678AlwBAvpbRdoJAwwrdn3YXe0bVN2Rg0LekJ5moPzJbi1H7lX4jCE6qMACWn2URAIjkFXkcud8xySLyggE9XawVYfthE6mVNssdrBPgjw1IhIBK3wf23iTGhPSqitRcLMVkz/lnuHhTxJ7J+kd+WIxMsN4eYqwU40qx2WaRm5gitAc9juG5C6ag3xKmryFx7ASEaMBDq6sruxtSlphn8smjpFXYotGIP7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgH/bYoXOlU+D6BFKNzLvH0Vgy+IJ7NgGRWzYusKxTA=;
 b=ROSjsiXi7gyKdLF6WDc8QpthxHlsGTxcLPZQgClauZwNIsjwAu81tgyOb7CwyM2z+f1TPhkppVb2Prz7ySUNL76hL1pYgn/xwvG6H9VSMMio3Z6AGgPqADM3Qqkcj2ydV5TQEZEk7fET30OX2nTghPDNq4mXD4/F2ARWL2zAxzqluWeqJBTZFYNz21vNIwWB8JsN+lbyUygeVD7OueDLiD7RpyrIsdQuRwrkH4hd7KjVFgqUsHXcnLS+zkLYgzv/PEngYSQQlOWZj0k6I4S1W53fqHLlhTGjU7ZnE9yJJmP8wuQQxmVTKQ3D898MmxOGYZisramozo//JCySV8PG/Q==
Received: from BN9PR03CA0584.namprd03.prod.outlook.com (2603:10b6:408:10d::19)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:15:42 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::b4) by BN9PR03CA0584.outlook.office365.com
 (2603:10b6:408:10d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 19:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 19:15:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:15:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:15:24 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 11:15:22 -0800
Date: Mon, 13 Jan 2025 11:15:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<oe-kbuild-all@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z4VmST8xyAluL858@Asurada-Nvidia>
References: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>
 <202501091822.4ocbIobQ-lkp@intel.com>
 <Z4Vi9raM/lOot/SQ@Asurada-Nvidia>
 <20250113190641.GQ5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113190641.GQ5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c262e1-3ec6-4f29-4d3d-08dd3406abf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uh4NGjlgt9bQddpOjwgETXjuPjIWxFMcrqUOSnGilL8xYHDcg36tu4g/STyc?=
 =?us-ascii?Q?aw5GMICwBrlXlLeafMB2WZZi9pWyI6pt/ICWTkXb+H7+kV6pUjJ7EIeIf1Gr?=
 =?us-ascii?Q?n+YP4h+WrOmynf4TlWCtGRVfU/nBzcrBJoxVfFHNsBFF8jgmPTB/JAik4SQ6?=
 =?us-ascii?Q?4wVCxdQCifCozWPZxuuZasv2FtFjn8bsbrBVamOJn6/7qBudpf46N5D47YOE?=
 =?us-ascii?Q?frsXQG37E9b3YwXejz44/zMTRS4OMYCa2pSzmFrR5VM9rr7JmtGMQiI1EuKH?=
 =?us-ascii?Q?lQfv8g6Yo1gea7ffJ7icOek/uVymePp7/gho8TKCsr54WQC/2oS3tg+o8Q5a?=
 =?us-ascii?Q?HJB0K2FCvUZhXc+FBMNzWUFqpJzaC7dLe4wC2z4TvPR+IgemgTNzYXExpE7Z?=
 =?us-ascii?Q?knREcb1HEiS+5nMoDtIwEeqj/POLi7Duq6NnmY7ddfKvDHNPOIJws7nQKB2h?=
 =?us-ascii?Q?DX8Hl9NlLi6JiLw5DE8hEdwpWyhyl6W84UYP0GYQR3K38Kf49KXC2no5thio?=
 =?us-ascii?Q?YntdpPlU2Vc34hsfkAJ3Z13cNM+gMm6dP5O1wYGaVh5HI6n5L7umOHnuPVbp?=
 =?us-ascii?Q?GbQbkbGdAfBMmXDI/Up+nLHKaZE/IV4ZSqQv+hS4IpFslSOT5O96pPxz0Erb?=
 =?us-ascii?Q?K2XXuaNuHn6Y5ZcpejsVQQObSTtY2jLNwswtdCrOb257MYu91oNfR17Q4JJT?=
 =?us-ascii?Q?+DrLRUaVFCcUaewTVq7HVBRmHg0d2KEVIXeh1RHXtW88f2ydfN5SqTBT24KB?=
 =?us-ascii?Q?+A+h1qngRUP3H/lKIm2Ag6KVJu/m2NKs8HTcF9H6LMIvOnm/7pSY0OGduIUD?=
 =?us-ascii?Q?ojaEQGT6e2c80cXWq6YNUyGn5ZGIhAURjTbwP36MwPK4lfHI2Uow9q2XM+mt?=
 =?us-ascii?Q?lCSdusru76pzHPtGIvB6XMGlF1+QPPSG7mk8GdqSjCDYt7MvmMoQo9ZkCTFy?=
 =?us-ascii?Q?EaI/HYKDFpPItiMdwfqCWECoU+rWHe3Zc9VmBoPpDGxJCe8iFpSee3Rm2/Vj?=
 =?us-ascii?Q?mlhPQR9TQS1MeNcwwjn0OdV/TTHYcJwmLAkfSJPAEjTE1m+clVVg/7QLp7t9?=
 =?us-ascii?Q?Z0nVBqlfaxqn6dO18TXmAZGjEJ4j8WzVyOj85kKe4VsYRgnD4RZLt+Urk2CM?=
 =?us-ascii?Q?pv3D9gqyfrkYb1bDyN6s7fkwCyL+EySWDX0DVRYGney95Zb/ZFPtWoKZWDLo?=
 =?us-ascii?Q?gMg9YXreN5tjwNo1HlTcr5whgUuKlUJy2+WLWaDvf147nJG+nEBuvckRe6vT?=
 =?us-ascii?Q?7uBlW1ombeU40U7e33iEvhnAnuCHws0y2WRNYscgYd9SEx+1R7QcdaaRK0ME?=
 =?us-ascii?Q?s3Nal6CvvIexqpivzPgTzaSLr7y9oDtX5IL0tEue2kzpbMGBKkxalxNrS38k?=
 =?us-ascii?Q?2/qdED86ykpOeKRBjJQrAEnv2zYlCQor+/ExnaCDN7CujqtQ4ppXwBkBefSF?=
 =?us-ascii?Q?IEbac7Swu7vfmcPuI/XnkRbFgVbBywXDnZciZfT4I1n4X801XeAm9hFiDQFv?=
 =?us-ascii?Q?LRoq2Xy8lpKY12I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:15:41.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c262e1-3ec6-4f29-4d3d-08dd3406abf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502

On Mon, Jan 13, 2025 at 03:06:41PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2025 at 11:01:10AM -0800, Nicolin Chen wrote:
> 
> > +/* This is basically iommu_vevent_arm_smmuv3 in u64 for conversion */
> > +struct arm_vsmmu_evt {
> > +	union {
> > +		u64 evt[EVTQ_ENT_DWORDS];
> > +		struct iommu_vevent_arm_smmuv3 uevt;
> > +	};
> > +};
> 
> This doesn't seem right, don't make unions like this

This is copied from the invalidate union though... Any reason why
this is no longer good for evt v.s. cmd?

> >  int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
> >  {
> > -	struct iommu_vevent_arm_smmuv3 vevt =
> > -		*(struct iommu_vevent_arm_smmuv3 *)evt;
> 
> evt is clearly not a iommu_vevent_arm_smmuv3 since it has the wrong
> endianess? It should stay in its own type.
> 
> struct struct iommu_vevent_arm_smmuv3 uevt;
> 
> uet.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) | FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
> for (i = 1; i != EVTQ_ENT_DWORDS; i++)
>     uet.evt[i] = cpu_to_le64(evt[i]);

I will use this.

Thanks!
Nicolin

