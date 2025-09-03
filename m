Return-Path: <linux-kselftest+bounces-40696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD531B42832
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E58582428
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5132ED34;
	Wed,  3 Sep 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPEc/IuW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BE321F34;
	Wed,  3 Sep 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921620; cv=fail; b=bask8PDdWNDOrNULSJOKfDK3GE76CBFnsx72EXC8JBSmh68PCdZMojNshRQy8OR70FFdtYAlEuBlaYcUQZmuodJtA6CU9crW/UPIoaHwpN0g8i+boNxfx9fPLJQGS+ahzHB3xBjxcm+g9/Y3Uwip9Ej2Rexn++Oo4c+SLm9fVaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921620; c=relaxed/simple;
	bh=lkPNB5hoTmi0s+xBbP0520ExTSGUJBLObXjCI2psg9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICXk1utf0Nfkt51oJedsazPuF+h7mb9wLvzEFxHAqj7F0QrOSJ48IOJX3yVf38iX+eYg4XTBogGaoNJM7lRfhff3vV2Y772Vk2tAMlW6VyywggeWE52kQ5lTsLqy0XkOJWBPk5nxZ/dcJCzDCS7Ho3Y7FZnNSmlGwEngh68r6WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPEc/IuW; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL3dxMHrOgsbt3bwKrmbKTiXOLiI9neHoi5cwq4DOEhHnbcIF1zQvzpP66UHuf2gapNcnj8gy8iV3pl1KsKUTi8kuR3nfzwXUBEOS6y0BJJA2EMXnrAmffYiISZGgUZyEV5Yp32x+FTLyqhJlHcVuF1Jex6pKhG3iT7fZAf8yD9W/VEsBsJri7FbXtW3rZZ634K72qs0XmLeGnyHk5PMj+6oDXgf52PYmyRVxddOy+h5+KXhIsePZR1Qd+c4LFrx3D6HD1XC06PS/nN2VuQHe+Fko766bdhnfk6lxblHAIUY8HeYXDl9M8ZUybkncSvYei6rkQpio0fxzXcfjp+m8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPPjGeodWWOY023vWQHKQMHumwEDC0rQnMCXrF43eS4=;
 b=nAUIlapQOCWDB2xnCcsJL49yWPdOhVBhoOZLGVA8hHlMChuBFarq5ZAJVXuw0i743osp60tI0ZjVWJjNdgDKVKwYfTj06pNoDz94Mys0GIxEw2Ta1lbABmdC/kYy4WYMFhoXZiII2UmDQzq3vith7k2o+xCv52RtnaMV72jpf+JrjUYmYGCurt4mQrwzahyB/CDMkjiY68KzSvZYyyvXKwgEjYWsApghMuZSQBwNKG2wYzvdDY3EFbcCjIHmG+wjFS30nFuhq2gk9vwsF+NuoYpJfpv9cz9iWVGoCkqHY6AmmAI5bjr8eBpGkwZkGlRKVHinhHSNZNJufGrKnlyIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPPjGeodWWOY023vWQHKQMHumwEDC0rQnMCXrF43eS4=;
 b=EPEc/IuWyugmDqERfvUgRGPSB19yL04DycG2XiryflgeaJgugy3k2UmyBMJFVQQYgw8Kxj4r8jbhhUAmsCLEDJVeiHes794OyeojD7V/A9L1L1FHMUnCNLn6Ily0Upyiqir6BAaLXT8HXiCvpEFxveHWo6IWWHqhPu7e6DIcJm74OJ2i4Dy0zF6t7DfbnSg5EvZLeqEQroAHpWFh0H4bsIfJ8fQL5ZTBMuTk1kQiJV0/IgJtbtUmNvCF3wQuDypmc5zFy8PcgD/QjtkmHvGYDW/0JPTz1tOkX/JUbGeyoYmvSc2QldEaozkUxCQef0q6PW791LXLlRhMmFb2hE9X8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:45 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v5 07/15] iommupt: Add map_pages op
Date: Wed,  3 Sep 2025 14:46:34 -0300
Message-ID: <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0372.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::21) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: f68f95b6-c3c1-4d19-1170-08ddeb11d8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?763eWmufqonJtGNp7GYfd1fNso4pj5QyO8w9TQIitUCcmIm9odSnuC5uRsF8?=
 =?us-ascii?Q?ZR/KFt06djhmdDsEWuCJNuSdWXVcn4r+EjDrj2cfbKhYajud6S1qKUcsRf9b?=
 =?us-ascii?Q?46eCGhdKINQ7DSuz4okIoZ9JLaniI9KG3oW4TdiyZiKVeuXN9f3mn+Bjr9Ec?=
 =?us-ascii?Q?LiYG9WKrmqtOpX0KOEtxWdoMw+LFNbkQxNehdmeGBILUwNJN2iFiXpifX5bu?=
 =?us-ascii?Q?Vry/5R/Unr5ydBwp5rL2km1LmPxHQWt70qSIw4+KwXnkyvfMFiAhb/aesuRu?=
 =?us-ascii?Q?fdckvglxyBT1HQ6WFZ94kH/XTYwNPVcoMSYJlbW+8EpyT+QgTaj9rGlsTPU9?=
 =?us-ascii?Q?xmTpaVuCRseypWuCwn8AA+NScngQrJbZyscTGPozmVdgzlhxluLHGGrGdazm?=
 =?us-ascii?Q?qzkdQ1jKKOc0INuaVosCAg7oagDUWaHwJUvFLT92uUYsQYS8H8QBGATmNNDM?=
 =?us-ascii?Q?0zj1r1MP9jI6uJ0h3wud5Vnn0vrVnxjLPldSNjGKu9SVppih/xG6SsziuLrA?=
 =?us-ascii?Q?/lohpDWjYFHXkgqTJZ+M2wOBwC3FCD2Gt1FJ92b3TOG0WJkyEeINc6qlts5u?=
 =?us-ascii?Q?XbXAhsLJ3rUDclZ6tyxKTDg17Imurngg8XRFlbAfWBdYGSpJtr0TbpVmW768?=
 =?us-ascii?Q?Woep7usI2tdCsrTq8V1ows7ZkXKZuBQ9h8PcBRV70ZM1+lc0xtf4PZ2KQ3z0?=
 =?us-ascii?Q?Mw9fgozyoRUZfcgKo6LQFbkkawhNmWJL3e5lDIQtoHHeuaGAaiP9VkO8eazm?=
 =?us-ascii?Q?RQZuqk7H2jzMf3quMYQSaDpKNiJTYDppVGw5N5QEWZ6lcw0vF/YZccc4vCPc?=
 =?us-ascii?Q?GmoKQcyh89VZc3ax4EYv+Th6fmmda8JxiULiim7Aj5rZVXElhSQD7WPOZBz3?=
 =?us-ascii?Q?jUzzxKugBIf9Miwr/BlszA31K19VGAZRLMMJIbDSMrawkg3rgRd/05gWxafH?=
 =?us-ascii?Q?VD3cAJgZdkO4i0yl8+U8gEwvR1VCx6SC1qO6W/rugesiYPECdtn9a2UE0Uv+?=
 =?us-ascii?Q?R/AAggkg4jxUalS/NefdO/fCszeGcycAVLR2UbiBmKusC+RiSf1dyszH0KHo?=
 =?us-ascii?Q?t+EYzzWW1WSqitK1JMyuPveMh2maMuhejQvQR4CD3JSq8KzqSbG+H/OZn441?=
 =?us-ascii?Q?8i/f3ZnsBME0yrf7lXJjjgSfp/F2hf8k0k9xk8mQsHpsquG6AFdN6RXuZbNf?=
 =?us-ascii?Q?Z6acQRVUjSIriCp6gNeLuNajQoWd8j/sWdkDMTFAvtupvIu8nqtFEWbONrye?=
 =?us-ascii?Q?C6WZVkheKr/xlP8TKSiJXZxz2i+s8zAedT1D83601yPUJARsayV2+u5a4UxL?=
 =?us-ascii?Q?DGctgeREQiwhSNkRQrz4WUY3BljwyclCY3s3zJ5EFjO4GI21+0YQZHeGZWer?=
 =?us-ascii?Q?G1q+08ld6ZAhm/TQz9GShg/fi0SLrUetp446kHcDm9Z+fD8Ue7DpdQOK8Cal?=
 =?us-ascii?Q?Jhwt/A+bVZlP9DRcyjkvCZbl7ojxLpNd7F+70l8j0bhJgVwDXpLs6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QB8qKZgpIWX5lFw0YmB+xogH4UDp0LN+eaiK1xqyS+N920Dx3yi9bsbuvmai?=
 =?us-ascii?Q?QWIcjBDRZuZv7+7mMffBki+nj2SXdLpFXkz4wDH1DXYi72WeAnUfRlifQvhP?=
 =?us-ascii?Q?midXASDc7bTgPU7MBcQh7nmzls/BbCc1gBWsjE0bHUh7L0DfkdGapouBP5Ru?=
 =?us-ascii?Q?s92mTIOn+utivZ1bvB/4ZzkMlXXD5/cD7VplPoYTOMpCmAyy1Qpp020yAms7?=
 =?us-ascii?Q?iP6G4isumJek0Fa19UTEF6TOmB1cLTQp549CTzgu9PJBfSQOiCrzJ9iNECTB?=
 =?us-ascii?Q?NTJ8hHwHGCEAYmoWtJUZuZPSs8gmsoRLvM102SbnV2CB+sI6YQtr0TOclBJr?=
 =?us-ascii?Q?cYYZF6twZWVZ0X4WZOa4GYxv3Xl4HVktH6DIQPdbsjj9N52Ep+fSy4CrltS7?=
 =?us-ascii?Q?bIXdyh5KwLe6HKA/4A2kvF2Hh6xFPMjoISnDf4NS1R7eqVs9MBJwJk1DLfaG?=
 =?us-ascii?Q?3XuyiDuhIMBAAcFkukl54PazRJ1siWGpZmLFeaMcOZYb2IfmGGc4mEf/P2r3?=
 =?us-ascii?Q?FNuja1asjGKPSOjkOGtXNr9pOoJnq7xN+oHFrTQEPGKNyG6xr4ZK/I4/0hbH?=
 =?us-ascii?Q?4zf246nEfvwW5EDFBgeNWuTDQzl4+GeufIldNoSnZJVHuYr1B5AE3i1UVy5T?=
 =?us-ascii?Q?VkbzuaW/fjag7Ug/77uuI8rBKg8NznOV5i1BYYzk73aeKlEATkJqO4YOLHdo?=
 =?us-ascii?Q?kMbrFxJ7ArOaVnLDVEgwsmDmQ34hN3H/bEUrrSkQjFe++OeBx8AAXb2B101y?=
 =?us-ascii?Q?Ods6G/UlajDCnEz8NKylBB4nswEauQTh+RilMM97JwPKK02ti30cpg1tQX9r?=
 =?us-ascii?Q?a0jsoQL+g4N1N+8j/9W/jiHIgclXHempyqaAluwktmIjaI1OTsa7rR8NQPiS?=
 =?us-ascii?Q?f57IywaaW6ekNm7pLyNSDaK4m/pTHrzv39Bz9QFRM9ZvN6p8pbHB3zR5SVc9?=
 =?us-ascii?Q?VnWIwUirtn1ZbHQq1QXU59OJmRojw786ZG+CA3Lxq4NqtO1Qic0mSn/oJ8P0?=
 =?us-ascii?Q?7j3h/ShqBrvH4iO47BfO4xXT6eUOqNi6mPA6V0rRLZYmfKMWTyY0+fPYyIZI?=
 =?us-ascii?Q?f4uR1dxhaRdfXlGE1N9giWyh080qZBo3hUwF0HM0mOaOf5uCxgA21z2cvYOE?=
 =?us-ascii?Q?qVp6iOpfGazfjGLSum9gwCGFCmwbSW7LvU6CQxcmPdiCwRkIY/BwdTWUBIWm?=
 =?us-ascii?Q?HP1JaEITnZRGGcgWT5G76PQw7wdxPlceUrIzgkFz2d2wnApOvsShMHPFt9VE?=
 =?us-ascii?Q?xiAJS1ZCgpCH1T23BPUWL2tBwoIzRW3Tz1shrFYfOc89OOmtHRckr0X+7tGr?=
 =?us-ascii?Q?6M4e+WYXSCeH+2OYyagACpcgBCnuUhGF+7u1S60psnDHBabrx1cnIpgQ7aHb?=
 =?us-ascii?Q?+v9sIkmeVOWR+EyiU4waAC6YlPuEeMqhGCbrZ4PX4dbgcv6vKPw3Qx79PVLQ?=
 =?us-ascii?Q?+JoayBdCpPAfgdWWhm2GC09yC6zjXAHGSSMyoZJbrjuMEt7eoDE87daqKZ41?=
 =?us-ascii?Q?+oepm40O9CWBM6G24pBtEYe+mOcbUUI8M9lD7gwrETUP0atkS76qrh/qfbdP?=
 =?us-ascii?Q?N/ciQAi1xBSwyaoX0T8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68f95b6-c3c1-4d19-1170-08ddeb11d8c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Prb6TByMqI5IJMk6qdQLgsicIOY21VesHD+lOU9ZAyjiY470prqiKWZ386uH5Uv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

map is slightly complicated because it has to handle a number of special
edge cases:
 - Overmapping a previously shared table with an OA - requries validating
   and freeing the possibly empty tables
 - Doing the above across an entire to-be-created contiguous entry
 - Installing a new shared table level concurrently with another thread
 - Expanding the table by adding more top levels

Table expansion is a unique feature of AMDv1, this version is quite
similar except we handle racing concurrent lockless map. The table top
pointer and starting level are encoded in a single uintptr_t which ensures
we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
that fixed point as its starting point. Concurrent expansion is handled
with a table global spinlock.

When inserting a new table entry map checks that the entire portion of the
table is empty. This includes freeing any empty lower tables that will be
overwritten by an OA. A separate free list is used while checking and
collecting all the empty lower tables so that writing the new entry is
uninterrupted, either the new entry fully writes or nothing changes.

A special fast path for PAGE_SIZE is implemented that does a direct walk
to the leaf level and installs a single entry. This gives ~15% improvement
for iommu_map() when mapping lists of single pages.

This version sits under the iommu_domain_ops as map_pages() but does not
require the external page size calculation. The implementation is actually
map_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize iommu_map() to take advantage of this.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 481 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  58 ++++
 2 files changed, 539 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 614af5d1e17e50..f15c4ca937c222 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -91,6 +91,23 @@ static __maybe_unused int make_range_u64(struct pt_common *common,
 		ret;                                                     \
 	})
 
+static inline unsigned int compute_best_pgsize(struct pt_state *pts,
+					       pt_oaddr_t oa)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(pts->range->common);
+
+	if (!pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * The page size is limited by the domain's bitmap. This allows the core
+	 * code to reduce the supported page sizes by changing the bitmap.
+	 */
+	return pt_compute_best_pgsize(pt_possible_sizes(pts) &
+					      iommu_table->domain.pgsize_bitmap,
+				      pts->range->va, pts->range->last_va, oa);
+}
+
 static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 					     unsigned int level,
 					     struct pt_table_p *table,
@@ -190,6 +207,463 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+/* Allocate an interior table */
+static inline struct pt_table_p *table_alloc(const struct pt_state *parent_pts,
+					     gfp_t gfp)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(parent_pts->range->common);
+	struct pt_state child_pts =
+		pt_init(parent_pts->range, parent_pts->level - 1, NULL);
+
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_num_items_lg2(&child_pts) +
+			    ilog2(PT_ITEM_WORD_SIZE)));
+}
+
+static inline int pt_iommu_new_table(struct pt_state *pts,
+				     struct pt_write_attrs *attrs)
+{
+	struct pt_table_p *table_mem;
+	phys_addr_t phys;
+
+	/* Given PA/VA/length can't be represented */
+	if (unlikely(!pt_can_have_table(pts)))
+		return -ENXIO;
+
+	table_mem = table_alloc(pts, attrs->gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+
+	phys = virt_to_phys(table_mem);
+	if (!pt_install_table(pts, phys, attrs)) {
+		iommu_free_pages(table_mem);
+		return -EAGAIN;
+	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+		/*
+		 * The underlying table can't store the physical table address.
+		 * This happens when kunit testing tables outside their normal
+		 * environment where a CPU might be limited.
+		 */
+		pt_load_single_entry(pts);
+		if (PT_WARN_ON(pt_table_pa(pts) != phys)) {
+			pt_clear_entry(pts, ilog2(1));
+			iommu_free_pages(table_mem);
+			return -EINVAL;
+		}
+	}
+
+	pts->table_lower = table_mem;
+	return 0;
+}
+
+struct pt_iommu_map_args {
+	struct iommu_iotlb_gather *iotlb_gather;
+	struct pt_write_attrs attrs;
+	pt_oaddr_t oa;
+	unsigned int leaf_pgsize_lg2;
+	unsigned int leaf_level;
+};
+
+/*
+ * Check that the items in a contiguous block are all empty. This will
+ * recursively check any tables in the block to validate they are empty and then
+ * free them through the gather.
+ */
+static int clear_contig(const struct pt_state *start_pts,
+			struct iommu_iotlb_gather *iotlb_gather,
+			unsigned int step, unsigned int pgsize_lg2)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(start_pts->range->common);
+	struct pt_range range = *start_pts->range;
+	struct pt_state pts =
+		pt_init(&range, start_pts->level, start_pts->table);
+	struct pt_iommu_collect_args collect = {};
+	int ret;
+
+	pts.index = start_pts->index;
+	pts.end_index = start_pts->index + step;
+	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			collect.free_list =
+				IOMMU_PAGES_LIST_INIT(collect.free_list);
+			ret = pt_walk_descend_all(&pts, __collect_tables,
+						  &collect);
+			if (ret)
+				return ret;
+
+			/*
+			 * The table item must be cleared before we can update
+			 * the gather
+			 */
+			pt_clear_entry(&pts, ilog2(1));
+
+			iommu_pages_list_add(&collect.free_list,
+					     pt_table_ptr(&pts));
+			gather_range_pages(
+				iotlb_gather, iommu_table, range.va,
+				log2_to_int(pt_table_item_lg2sz(&pts)),
+				&collect.free_list);
+		} else if (pts.type != PT_ENTRY_EMPTY) {
+			return -EADDRINUSE;
+		}
+	}
+	return 0;
+}
+
+static int __map_range_leaf(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
+	unsigned int start_index;
+	pt_oaddr_t oa = map->oa;
+	unsigned int step;
+	bool need_contig;
+	int ret = 0;
+
+	PT_WARN_ON(map->leaf_level != level);
+	PT_WARN_ON(!pt_can_have_leaf(&pts));
+
+	step = log2_to_int_t(unsigned int,
+			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
+	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			ret = clear_contig(&pts, map->iotlb_gather, step,
+					   leaf_pgsize_lg2);
+			if (ret)
+				break;
+		}
+
+		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);
+
+		pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->attrs);
+
+		oa += log2_to_int(leaf_pgsize_lg2);
+		pts.index += step;
+	} while (pts.index < pts.end_index);
+
+	map->oa = oa;
+	return ret;
+}
+
+static int __map_range(struct pt_range *range, void *arg, unsigned int level,
+		       struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	int ret;
+
+	PT_WARN_ON(map->leaf_level == level);
+	PT_WARN_ON(!pt_can_have_table(&pts));
+
+	_pt_iter_first(&pts);
+
+	/* Descend to a child table */
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+
+		if (pts.type != PT_ENTRY_TABLE) {
+			if (pts.type != PT_ENTRY_EMPTY)
+				return -EADDRINUSE;
+			ret = pt_iommu_new_table(&pts, &map->attrs);
+			if (ret) {
+				/*
+				 * Racing with another thread installing a table
+				 */
+				if (ret == -EAGAIN)
+					continue;
+				return ret;
+			}
+		} else {
+			pts.table_lower = pt_table_ptr(&pts);
+		}
+
+		/*
+		 * The already present table can possibly be shared with another
+		 * concurrent map.
+		 */
+		if (map->leaf_level == level - 1)
+			ret = pt_descend(&pts, arg, __map_range_leaf);
+		else
+			ret = pt_descend(&pts, arg, __map_range);
+		if (ret)
+			return ret;
+
+		pts.index++;
+		pt_index_to_va(&pts);
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+	return 0;
+}
+
+static __always_inline int __do_map_single_page(struct pt_range *range,
+						void *arg, unsigned int level,
+						struct pt_table_p *table,
+						pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+
+	pts.type = pt_load_single_entry(&pts);
+	if (level == 0) {
+		if (pts.type != PT_ENTRY_EMPTY)
+			return -EADDRINUSE;
+		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
+				      &map->attrs);
+		map->oa += PAGE_SIZE;
+		return 0;
+	}
+	if (pts.type != PT_ENTRY_TABLE)
+		return -EAGAIN;
+	return pt_descend(&pts, arg, descend_fn);
+}
+PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
+
+/*
+ * Add a table to the top, increasing the top level as much as necessary to
+ * encompass range.
+ */
+static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
+			struct pt_iommu_map_args *map)
+{
+	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
+	uintptr_t new_top_of_table = top_of_table;
+	struct pt_table_p *table_mem;
+	unsigned int new_level;
+	spinlock_t *domain_lock;
+	unsigned long flags;
+	int ret;
+
+	while (true) {
+		struct pt_range top_range =
+			_pt_top_range(common, new_top_of_table);
+		struct pt_state pts = pt_init_top(&top_range);
+
+		top_range.va = range->va;
+		top_range.last_va = range->last_va;
+
+		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
+			break;
+
+		pts.level++;
+		if (pts.level > PT_MAX_TOP_LEVEL ||
+		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
+			ret = -ERANGE;
+			goto err_free;
+		}
+
+		new_level = pts.level;
+		table_mem = table_alloc_top(
+			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
+		if (IS_ERR(table_mem))
+			return PTR_ERR(table_mem);
+		iommu_pages_list_add(&free_list, table_mem);
+
+		/* The new table links to the lower table always at index 0 */
+		top_range.va = 0;
+		top_range.top_level = new_level;
+		pts.table_lower = pts.table;
+		pts.table = table_mem;
+		pt_load_single_entry(&pts);
+		PT_WARN_ON(pts.index != 0);
+		pt_install_table(&pts, virt_to_phys(pts.table_lower),
+				 &map->attrs);
+		new_top_of_table = _pt_top_set(pts.table, pts.level);
+	}
+
+	/*
+	 * top_of_table is write locked by the spinlock, but readers can use
+	 * READ_ONCE() to get the value. Since we encode both the level and the
+	 * pointer in one quanta the lockless reader will always see something
+	 * valid. The HW must be updated to the new level under the spinlock
+	 * before top_of_table is updated so that concurrent readers don't map
+	 * into the new level until it is fully functional. If another thread
+	 * already updated it while we were working then throw everything away
+	 * and try again.
+	 */
+	domain_lock = iommu_table->hw_flush_ops->get_top_lock(iommu_table);
+	spin_lock_irqsave(domain_lock, flags);
+	if (common->top_of_table != top_of_table) {
+		spin_unlock_irqrestore(domain_lock, flags);
+		ret = -EAGAIN;
+		goto err_free;
+	}
+
+	/*
+	 * We do not issue any flushes for change_top on the expectation that
+	 * any walk cache will not become a problem by adding another layer to
+	 * the tree. Misses will rewalk from the updated top pointer, hits
+	 * continue to be correct. Negative caching is fine too since all the
+	 * new IOVA added by the new top is non-present.
+	 */
+	iommu_table->hw_flush_ops->change_top(
+		iommu_table, virt_to_phys(table_mem), new_level);
+	WRITE_ONCE(common->top_of_table, new_top_of_table);
+	spin_unlock_irqrestore(domain_lock, flags);
+	return 0;
+
+err_free:
+	iommu_put_pages_list(&free_list);
+	return ret;
+}
+
+static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
+			   struct pt_iommu_map_args *map)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	int ret;
+
+	do {
+		ret = pt_check_range(range);
+		if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+			return ret;
+
+		if (!ret && map->leaf_level <= range->top_level)
+			break;
+
+		ret = increase_top(iommu_table, range, map);
+		if (ret && ret != -EAGAIN)
+			return ret;
+
+		/* Reload the new top */
+		*range = pt_make_range(common, range->va, range->last_va);
+	} while (ret);
+	PT_WARN_ON(pt_check_range(range));
+	return 0;
+}
+
+/**
+ * map_pages() - Install translation for an IOVA range
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @paddr: Physical/Output address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
+ * @gfp: GFP flags for any memory allocations
+ * @mapped: Total bytes successfully mapped
+ *
+ * The range starting at IOVA will have paddr installed into it. The caller
+ * must specify a valid pgsize and pgcount to segment the range into compatible
+ * blocks.
+ *
+ * On error the caller will probably want to invoke unmap on the range from iova
+ * up to the amount indicated by @mapped to return the table back to an
+ * unchanged state.
+ *
+ * Context: The caller must hold a write range lock that includes the whole
+ * range.
+ *
+ * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
+ * mapped are added to @mapped, @mapped is not zerod first.
+ */
+int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	pt_vaddr_t pgsize_bitmap = iommu_table->domain.pgsize_bitmap;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct iommu_iotlb_gather iotlb_gather;
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_iommu_map_args map = {
+		.iotlb_gather = &iotlb_gather,
+		.oa = paddr,
+		.leaf_pgsize_lg2 = log2_ffs(pgsize),
+	};
+	bool single_page = false;
+	struct pt_range range;
+	int ret;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+
+	if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
+		return -EINVAL;
+
+	/* Check the paddr doesn't exceed what the table can store */
+	if ((sizeof(pt_oaddr_t) < sizeof(paddr) &&
+	     (pt_vaddr_t)paddr > PT_VADDR_MAX) ||
+	    (common->max_oasz_lg2 != PT_VADDR_MAX_LG2 &&
+	     oalog2_div(paddr, common->max_oasz_lg2)))
+		return -ERANGE;
+
+	ret = pt_iommu_set_prot(common, &map.attrs, prot);
+	if (ret)
+		return ret;
+	map.attrs.gfp = gfp;
+
+	ret = make_range_no_check(common, &range, iova, len);
+	if (ret)
+		return ret;
+
+	/* Calculate target page size and level for the leaves */
+	if (pt_has_system_page(common) && pgsize == PAGE_SIZE && pgcount == 1) {
+		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
+		if (log2_mod(iova | paddr, PAGE_SHIFT))
+			return -ENXIO;
+		map.leaf_pgsize_lg2 = PAGE_SHIFT;
+		map.leaf_level = 0;
+		single_page = true;
+	} else {
+		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
+			pgsize_bitmap, range.va, range.last_va, paddr);
+		if (!map.leaf_pgsize_lg2)
+			return -ENXIO;
+		map.leaf_level =
+			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
+	}
+
+	ret = check_map_range(iommu_table, &range, &map);
+	if (ret)
+		return ret;
+
+	PT_WARN_ON(map.leaf_level > range.top_level);
+
+	do {
+		if (single_page) {
+			ret = pt_walk_range(&range, __map_single_page, &map);
+			if (ret != -EAGAIN)
+				break;
+		}
+
+		if (map.leaf_level == range.top_level)
+			ret = pt_walk_range(&range, __map_range_leaf, &map);
+		else
+			ret = pt_walk_range(&range, __map_range, &map);
+	} while (false);
+
+	/*
+	 * Table levels were freed and replaced with large items, flush any walk
+	 * cache that may refer to the freed levels.
+	 */
+	if (!iommu_pages_list_empty(&iotlb_gather.freelist))
+		iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
+
+	/* Bytes successfully mapped */
+	PT_WARN_ON(!ret && map.oa - paddr != len);
+	*mapped += map.oa - paddr;
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -450,6 +924,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
 	memset_after(fmt_table, 0, iommu.domain);
 
 	/* The caller can initialize some of these values */
+	iommu_table->hw_flush_ops = cfg.hw_flush_ops;
 	iommu_table->nid = cfg.nid;
 }
 
@@ -483,6 +958,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
 	if (ret)
 		return ret;
 
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
+	    WARN_ON(!iommu_table->hw_flush_ops ||
+		    !iommu_table->hw_flush_ops->change_top ||
+		    !iommu_table->hw_flush_ops->get_top_lock))
+		return -EINVAL;
+
 	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
 	    (pt_feature(common, PT_FEAT_FULL_VA) ||
 	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index ceb6bc9cea37cd..2769689379c26d 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -11,6 +11,7 @@
 
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
+struct pt_iommu_flush_ops;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -43,6 +44,12 @@ struct pt_iommu {
 	 */
 	const struct pt_iommu_ops *ops;
 
+	/**
+	 * @hw_flush_ops: Function pointers provided by the HW driver to flush
+	 * HW caches after changes to the page table.
+	 */
+	const struct pt_iommu_flush_ops *hw_flush_ops;
+
 	/**
 	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
 	 * may want to set the NID to the device's NID, if there are multiple
@@ -84,6 +91,52 @@ struct pt_iommu_ops {
 	void (*deinit)(struct pt_iommu *iommu_table);
 };
 
+/**
+ * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
+ *
+ * The IOMMU driver should implement these using container_of(iommu_table) to
+ * get to it's iommu_domain dervied structure. All ops can be called in atomic
+ * contexts as they are buried under DMA API calls.
+ */
+struct pt_iommu_flush_ops {
+	/**
+	 * @change_top: Update the top of table pointer
+	 * @iommu_table: Table to operate on
+	 * @top_paddr: New CPU physical address of the top pointer
+	 * @top_level: IOMMU PT level of the new top
+	 *
+	 * Called under the get_top_lock() spinlock. The driver must update all
+	 * HW references to this domain with a new top address and
+	 * configuration. On return mappings placed in the new top must be
+	 * reachable by the HW.
+	 *
+	 * top_level encodes the level in IOMMU PT format, level 0 is the
+	 * smallest page size increasing from there. This has to be translated
+	 * to any HW specific format. During this call the new top will not be
+	 * visible to any other API.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
+			   unsigned int top_level);
+
+	/**
+	 * @get_top_lock: Return a lock to hold when changing the table top
+	 * @iommu_table: Table to operate on
+	 *
+	 * page table from being stored in HW. The lock will be held prior
+	 * to calling change_top() and released once the top is fully visible.
+	 *
+	 * Typically this would be a lock that protects the iommu_domain's
+	 * attachment list.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
+};
+
 static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
 {
 	/*
@@ -120,6 +173,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,            \
+				       unsigned long iova, phys_addr_t paddr,  \
+				       size_t pgsize, size_t pgcount,          \
+				       int prot, gfp_t gfp, size_t *mapped);   \
 	size_t pt_iommu_##fmt##_unmap_pages(                                   \
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
@@ -142,6 +199,7 @@ struct pt_iommu_cfg {
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
-- 
2.43.0


