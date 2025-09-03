Return-Path: <linux-kselftest+bounces-40700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFACB4283C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58391B28602
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898F334373;
	Wed,  3 Sep 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cTmivmJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6732A82A;
	Wed,  3 Sep 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921627; cv=fail; b=RzcZTyLy82QapaYftSlWZLU7TvIfQO9QbFMRO6zps+P0oYnL4hPTFDzJxAdJDHTsBjUR4vo+G5rQgXM9Qe4jBDmG+8OlXVnyAV5Qj0BjvBWVDiUqd/z72EaNiiSJ+CaS8M+e8sLbFOxuUo5nplX34vXmpeWQ9qO2mAsXLk+WnSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921627; c=relaxed/simple;
	bh=1panQG4pfuuLlhOscsqj3VJ4+alGj86TFkoYHYAEsnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vb5Mm7FEgQgM9eweXRqbz+/03wt6TcY3KG06OE0K2gLvmyHcMhsdA2SVIBgCwQsN8SaEo/Hw76T27KpAkGAuzxdGH9+Fw/FA1HJYt7ehmtYFl8hznCNPSLbgq2KlOht+Oc0futPXKtbyVueLLIvlCj8Rb4WVgpG3Qwr6adLo3nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cTmivmJ5; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxQE3XWWiUB40pzuBaoNdUd6PxkIBPp52L8g8mQCu2gL1tBNmKKaENJMqQW8mr57pYDM/DsPAdsnl+ePZl02gjtezZS9ConT3DHFuGdOoXr6pc28ldWaojhsr1pTy/kuWnng6pKSz1tM2VhFJ5RfXV7rbgjOwpvEZWGKQg0IwsdbMOkkhvPvlK4QWyHOVgyJkhAojySc+TBF4wdy26p2gkzrkkjmLkerg99mEufynv0XCjald8Jo8JqRnIZY+vkjbq7NATnXHcA7Xp+b9/AZHjts5GfL/mEwnyZSGRb1G/pedOFbCckI6L0d+gSpLCFjAwUoZ9JhHUni5h5TylDlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2l9yFAJNZwmXMqHAnMgkD6G4VfpniZZoJcSZf5XqfM=;
 b=ka64JD2nNoFwflJnx5DNwG04+FPnwHCsmZSBvgzdXSPGxSvYwSagM5uH59mmXrVTG0n3qHokbdGdMofDOccx7UWyReryC7Nwc/B00AIomnelLzhFjcBRmVT/hXlTaTT3Xy8gXG3mfEbz2wpRjcLBu0YK+EeeBsuczNjpgsRbk/65Q1SLrKlMN0j5YJy5mOExeEpc0Y3QuP8nLMTG9aNQGIAaxUnSPSldNk4VtMDo9zVZSdHu99TPnzcbj5ZFh0qLkOkaly7LwbbLMsJPSKR8Zmp8qYue4PYlhBx6CvDAnxgQF4ZPVEPPQtrqVJ+wY9j3UyMc587oFyD50ySs+zAuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2l9yFAJNZwmXMqHAnMgkD6G4VfpniZZoJcSZf5XqfM=;
 b=cTmivmJ5E6mCx8LRJvOg0MVC1px2XFaCZSSLS65kO8OLm3YS6qvhLxL/xscs4OJB8byDW8jEwLwyNykSkXKZkKo3lysRTYIxj6v7qN375JXnxaiDffbnNHOptZTxRqTRpt+lp8LYdsan84HDp3SSY1LurmCmM1S5/HFJj00YpB8SB/fq3zAE8R6uoeZZL4QN50qU9GjZe5YYzKWd/cToMeK2UDjvEV1AmOfInhdzJXiAIwiN3/Quz6FAsWwHx7W4mO6iwAizWB3/MjePHlnYnnjFRZkKJi6c08Q4RCGibKWUtbLTUGPfd4ayCBoiZ2MvCXEdfacNSeuzRYSCyTnoSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:52 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:52 +0000
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
Subject: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Wed,  3 Sep 2025 14:46:30 -0300
Message-ID: <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::13) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 42944ccb-75cb-47c4-e94d-08ddeb11d9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMXDDlignJ86OphkRzIR36DR4+WlOiBFEECQl5THXRatyX2P3upBLrC4PZUb?=
 =?us-ascii?Q?nEg9pdEukkAmglhIk7Ip8luIj/Y+DUFEumYgP0/7NkCorCJCqh5F0fu4hj9n?=
 =?us-ascii?Q?CGfkp+APezfTvPYna+zcjEMrJcG4hbcW4Hjkwlfj8rZea91oL1umuG9nfe6+?=
 =?us-ascii?Q?29PyuKKLBDNV6RXjvFPhkssqodVrPMjVDN3fXigtmC6QgndNpOhlOG++hPSM?=
 =?us-ascii?Q?mB7lsxPmivtsflBbQZu/TPQdDY5TtNMqHuU4WuT6UYPtM5QtfoxSs569SXFn?=
 =?us-ascii?Q?tWdZkS+BOqEJG+SCFTFnPEFZiEM44scg67wy/GuxWRZaKGjoo096CirxKG/S?=
 =?us-ascii?Q?cOAcJDgFXVRGUYlEf/1BSR6R8PxoLEHwxHa2remsvYV1f/d97tXCq6JftXeX?=
 =?us-ascii?Q?nGkIt4frVXRlbZV+ulkaqem22cNLOevgA5cJZmiFWE5dSzEUr1gsTopDB6K6?=
 =?us-ascii?Q?YPFzLmCU5hX7tHhTHJbm0HBPsvIhB3SqBzvNj207ng87G1FlWGU85wCT/FvF?=
 =?us-ascii?Q?bF2GMbQdGcmpahASA3rTuUq6w+JAuvqNpNAo46Y+GDfGMd/+SnmOLzgx6LZY?=
 =?us-ascii?Q?FK7G0Xh5Ht9RvC8Ci0pr2DIqZUFl66GDljiTqjpElngnje5ykQdlfBvhP0YZ?=
 =?us-ascii?Q?mQyKCbrAygM2ZHOyB6d7xdx/lLNcet5eL3zbw7aWdWYGK7rDu6Jw3l+HWvwZ?=
 =?us-ascii?Q?X3FBMRr+UbVfY29piWF8IjHlvmFlRWCewJg95azcqApsukCitiAri9IqFF/u?=
 =?us-ascii?Q?s9zqrawx+QyjSp7x9A1hV0ZXhyqkHUF2dA1whOY4n6UU1w77AT12j8/6PKHg?=
 =?us-ascii?Q?KuQYCuK0CGIb0RDltvzn7s/2pbY6su/8Gzo60Qvm6bwRky8MerISH5CgVmVB?=
 =?us-ascii?Q?dsPgsHgGAF4HOuIjJnnN356Ws21MtyhMnGZe0r3iBT30W11vfxcBksscc6Ak?=
 =?us-ascii?Q?7xgypW8ZKFisEgqfPCyJhYOJF3kvmQZxOeVRog90OW56hMKhFPU9cLax+/pc?=
 =?us-ascii?Q?KkBVlDEVhmFOIwLrGrjaz3ESDxKSSMvXSHgd+Xx8msfv9xxdxaXaMdO9zA1C?=
 =?us-ascii?Q?5BOdPoMZs6n3Co5AoDcjPrze/e7L1WhhGFPPSbzzioN4DiEUMmUO08OY08a6?=
 =?us-ascii?Q?ADRZ3TTlq6aFRD7GJ6XYLgQ6uQykVvFYilLiSniRvS7LqyRDNb/xYTRKMg+k?=
 =?us-ascii?Q?thYbpLBiXEJb7GnzjpAjtMPKrLyTsbRWtYUnyi4qIPy4qoYSzSu4cKiIW52V?=
 =?us-ascii?Q?xeEeynW4a8MBFZlN3N56l8+wa20gi9ZTzg0QLfPe72DPWRnW6mcOlUQ9kZkY?=
 =?us-ascii?Q?sS0S0wl3r2ZdUs16hFDbAbbnf7f6k3Z4N7qj5eo+DCxLpFmXsP4AU/KimEza?=
 =?us-ascii?Q?tEZ/mRWqIwjMm+YaKiGqiFmv3wIshwT9ZQXN+wNvYJ9fPouRXvghSgtN+BxO?=
 =?us-ascii?Q?JbuvoMJ3LK6WKXo32Fuw8VHuwQP3AQSIsaNmUFwKNmgKgzF4IHGnIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VNVeMVcKzZ4tSxlBj25XEfryR3zdj9fIkkdnFzLxnHhoyw0SaQdIb4b51vM?=
 =?us-ascii?Q?l0P4ptpaKlSUXALelD38L4wxboyQ6kha80TJYwo6TDb9OBlhhPWm6o6/kYCY?=
 =?us-ascii?Q?jwRDB+xP1OZ/tURCxSyeUIWyodrFqjlXvsYAHeH0k13XjKrKPUw7hhP/ZCKP?=
 =?us-ascii?Q?4XOoaYz1c7W4On10SAvki+Aa/ypMiPjLVGgnPE9ZxPehTIeOQW9Z6ObMP5Et?=
 =?us-ascii?Q?0LGzxognBdwh0/G61gspwAdlF/H75Z4CMVvfMieeim86keekGWowF7IMiAEL?=
 =?us-ascii?Q?4vd7yqrudsrCeKV7mgcnU32ZRp6M8G1DZV6yoejMPIV3dwKt1vUsOEAudgMJ?=
 =?us-ascii?Q?Y2fcslHCpwSCyGtTL2F4Hc9nF5UB43UY+zIzBciJ6SVsi6tI8tF7zu1g4plA?=
 =?us-ascii?Q?VupNuPehQqNXYQjunQVvnM41OnvSgX4CaTttJNFb4Sbx6b6eVw2WPrPPzmMN?=
 =?us-ascii?Q?TVOcCKsrnFiXb3Qpp2WYpe1386YDiSGbkovnZskBaTp4b2RKTKKniisu7Vu7?=
 =?us-ascii?Q?MpTVzLa2a8RbcaGU9frl7U7tMfa5qH/OO4Grlvh0nTriBdMDkeBK0r6kEpEp?=
 =?us-ascii?Q?P5OZrgCi9Jkw0yb3LsDRbpzTgU7rDc/IeDqt7EREuFExSd162gKh12ldl6kh?=
 =?us-ascii?Q?EhYSVnErBZns+91wL4cXoen9q9s/zzQfBPAiIJ/brg0ZwgjjIX2YzzGpD8HX?=
 =?us-ascii?Q?ujUwUUUdEk/gDpOoyIqrvTxnzOyd6d5cMFQFNGCpsILlO/ThA/3VIluUymgG?=
 =?us-ascii?Q?F9yz/ANvuhMidRjA3k9w3S4aTlNFHQtYIUcpboaFH/OzfciAWMlcOcxhtJI5?=
 =?us-ascii?Q?YR75d7Ny5hvH/SBKANXNonqPL+RRkUPYUMleWt7nEAGSu598QAVvze3KaeRZ?=
 =?us-ascii?Q?FLhV1a0sow37++lPLCPhuE2KWMlxGbZc7q1tjDaKDJgpxWMxBpNqn5k8F4nT?=
 =?us-ascii?Q?df50YFlW3bZqd+r49wI5S71gDFCXi2MTvroKi/NIf9ZXziW1pVmc4H381M0v?=
 =?us-ascii?Q?g23oBy9eH4BDe3/I4KKc4NqTiEg2FvLqAkE6rK/3ufrqA/mF9vYwMaYHSveC?=
 =?us-ascii?Q?Wk1UwPSfwcptZm2QCN/XVsD/n07nsK/vlEOFVIFE5UIBN9akt71nCV6afDaQ?=
 =?us-ascii?Q?nJ+dcB8P4UwWu8RpjwnA1PZUn8pg2eoeui9DJHAGW4gGnrMOLS3JsRU8Of0b?=
 =?us-ascii?Q?tiMiZxtz/4wGb2OyBetNa415HbcCePXCEYnBPrxCrK3zR9RgoLl5CB/lLzNG?=
 =?us-ascii?Q?nt5+yX/J8DeJdwB8Pi475r6qF4bRvOFKr6kziTptm/Lt6o9MtymnIOaV4K6t?=
 =?us-ascii?Q?cbgskSNz05QzbB2nJI8S+EoE5GHy+pcVSP/aalbS5vOPK+57+5s19fE1kQCu?=
 =?us-ascii?Q?WtaLMnpJXmWZikybemi9qkF0Sb9ZMzwGG+udsIuzS2utwJAC0XTg/kd1A5q0?=
 =?us-ascii?Q?CX3ej5JEcj7q+lYUFJiRlqJgwjZxJRRFF0kNobgI15K7adSMKyDodjftc22A?=
 =?us-ascii?Q?tMedpPIpvIoL/3rwZVy3I95xVOssUZrMKHsnlYXD3nbe5CuTLDCvSPwENHcz?=
 =?us-ascii?Q?B6UDNLsC5Cm7g18leEo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42944ccb-75cb-47c4-e94d-08ddeb11d9d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:46.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdcFs3Kf77zdU/2MKISZVY3XiYBI1nb11cPl2Zvg/w8ZXYVtxR8w+G2GMi6tAfCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

The existing IOMMU page table implementations duplicate all of the working
algorithms for each format. By using the generic page table API a single C
version of the IOMMU algorithms can be created and re-used for all of the
different formats used in the drivers. The implementation will provide a
single C version of the iommu domain operations: iova_to_phys, map, unmap,
and read_and_clear_dirty.

Further, adding new algorithms and techniques becomes easy to do across
the entire fleet of drivers and formats.

The C functions are drop in compatible with the existing iommu_domain_ops
using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
compilation unit will produce exported symbols following the pattern
pt_iommu_FMT_map_pages() which the macro directly maps to the
iommu_domain_ops members. This avoids the additional function pointer
indirection like io-pgtable has.

The top level struct used by the drivers is pt_iommu_table_FMT. It
contains the other structs to allow container_of() to move between the
driver, iommu page table, generic page table, and generic format layers.

   struct pt_iommu_table_amdv1 {
       struct pt_iommu {
	      struct iommu_domain domain;
       } iommu;
       struct pt_amdv1 {
	      struct pt_common {
	      } common;
       } amdpt;
   };

The driver is expected to union the pt_iommu_table_FMT with its own
existing domain struct:

   struct driver_domain {
       union {
	       struct iommu_domain domain;
	       struct pt_iommu_table_amdv1 amdv1;
       };
   };
   PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);

To create an alias to avoid renaming 'domain' in a lot of driver code.

This allows all the layers to access all the necessary functions to
implement their different roles with no change to any of the existing
iommu core code.

Implement the basic starting point: pt_iommu_init(), get_info() and
deinit().

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  12 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 265 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 118 ++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index fb0f431ddba0a8..c35ddc7c827e92 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -17,4 +17,16 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
+	help
+	  Generic library for building IOMMU page tables
+
+	  IOMMU_PT provides an implementation of the page table operations
+	  related struct iommu_domain using GENERIC_PT to abstract the page
+	  table format.
 endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
new file mode 100644
index 00000000000000..5b631bc07cbc16
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Template to build the iommu module and kunit from the format and
+ * implementation headers.
+ *
+ * The format should have:
+ *  #define PT_FMT <name>
+ *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
+ * And optionally:
+ *  #define PT_FORCE_ENABLED_FEATURES ..
+ *  #define PT_FMT_VARIANT <suffix>
+ */
+#include <linux/args.h>
+#include <linux/stringify.h>
+
+#ifdef PT_FMT_VARIANT
+#define PTPFX_RAW \
+	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
+#else
+#define PTPFX_RAW PT_FMT
+#endif
+
+#define PTPFX CONCATENATE(PTPFX_RAW, _)
+
+#define _PT_FMT_H PT_FMT.h
+#define PT_FMT_H __stringify(_PT_FMT_H)
+
+#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
+#define PT_DEFS_H __stringify(_PT_DEFS_H)
+
+#include <linux/generic_pt/common.h>
+#include PT_DEFS_H
+#include "../pt_defs.h"
+#include PT_FMT_H
+#include "../pt_common.h"
+
+#include "../iommu_pt.h"
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
new file mode 100644
index 00000000000000..da711dafc2c160
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * "Templated C code" for implementing the iommu operations for page tables.
+ * This is compiled multiple times, over all the page table formats to pick up
+ * the per-format definitions.
+ */
+#ifndef __GENERIC_PT_IOMMU_PT_H
+#define __GENERIC_PT_IOMMU_PT_H
+
+#include "pt_iter.h"
+
+#include <linux/export.h>
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+
+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
+
+struct pt_iommu_collect_args {
+	struct iommu_pages_list free_list;
+	u8 ignore_mapped : 1;
+};
+
+static int __collect_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_collect_args *collect = arg;
+	int ret;
+
+	if (collect->ignore_mapped && !pt_can_have_table(&pts))
+		return 0;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_pages_list_add(&collect->free_list, pts.table_lower);
+			ret = pt_descend(&pts, arg, __collect_tables);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && !collect->ignore_mapped)
+			return -EADDRINUSE;
+	}
+	return 0;
+}
+
+static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
+						 uintptr_t top_of_table,
+						 gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(common);
+
+	/*
+	 * Top doesn't need the free list or otherwise, so it technically
+	 * doesn't need to use iommu pages. Use the API anyhow as the top is
+	 * usually not smaller than PAGE_SIZE to keep things simple.
+	 */
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
+}
+
+static void NS(get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_top_range(common);
+	struct pt_state pts = pt_init_top(&range);
+	pt_vaddr_t pgsize_bitmap = 0;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
+		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
+		     pts.level++) {
+			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
+				break;
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+		}
+	} else {
+		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+	}
+
+	/* Hide page sizes larger than the maximum OA */
+	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+		.ignore_mapped = true,
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	/*
+	 * The driver has to already have fenced the HW access to the page table
+	 * and invalidated any caching referring to this memory.
+	 */
+	iommu_put_pages_list(&collect.free_list);
+}
+
+static const struct pt_iommu_ops NS(ops) = {
+	.get_info = NS(get_info),
+	.deinit = NS(deinit),
+};
+
+static int pt_init_common(struct pt_common *common)
+{
+	struct pt_range top_range = pt_top_range(common);
+
+	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
+		return -EINVAL;
+
+	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
+	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
+		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
+
+	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
+		common->features |= BIT(PT_FEAT_FULL_VA);
+
+	/* Requested features must match features compiled into this format */
+	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
+	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
+	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
+		     PT_FORCE_ENABLED_FEATURES))
+		return -EOPNOTSUPP;
+
+	if (common->max_oasz_lg2 == 0)
+		common->max_oasz_lg2 = pt_max_output_address_lg2(common);
+	else
+		common->max_oasz_lg2 = min(common->max_oasz_lg2,
+					   pt_max_output_address_lg2(common));
+	return 0;
+}
+
+static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
+				struct iommu_domain *domain)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_iommu_info info;
+	struct pt_range range;
+
+	NS(get_info)(iommu_table, &info);
+
+	domain->type = __IOMMU_DOMAIN_PAGING;
+	domain->pgsize_bitmap = info.pgsize_bitmap;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		range = _pt_top_range(common,
+				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
+	else
+		range = pt_top_range(common);
+
+	/*
+	 * A 64-bit high address space table on a 32-bit system cannot work.
+	 */
+	domain->geometry.aperture_start = (unsigned long)range.va;
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va)
+		return -EOVERFLOW;
+
+	/*
+	 * The aperture is limited to what the API can do after considering all
+	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
+	 * to store a VA. Set the aperture to something that is valid for all
+	 * cases. Saturate instead of truncate the end if the types are smaller
+	 * than the top range. aperture_end should be called aperture_last.
+	 */
+	domain->geometry.aperture_end = (unsigned long)range.last_va;
+	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
+		domain->geometry.aperture_end = ULONG_MAX;
+		domain->pgsize_bitmap &= ULONG_MAX;
+	}
+	domain->geometry.force_aperture = true;
+
+	return 0;
+}
+
+static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_iommu cfg = *iommu_table;
+
+	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
+	memset_after(fmt_table, 0, iommu.domain);
+
+	/* The caller can initialize some of these values */
+	iommu_table->nid = cfg.nid;
+}
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_table_p *table_mem;
+	int ret;
+
+	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
+	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
+		return -EINVAL;
+
+	pt_iommu_zero(fmt_table);
+	common->features = cfg->common.features;
+	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
+	ret = pt_iommu_fmt_init(fmt_table, cfg);
+	if (ret)
+		return ret;
+
+	if (cfg->common.hw_max_oasz_lg2 > pt_max_output_address_lg2(common))
+		return -EINVAL;
+
+	ret = pt_init_common(common);
+	if (ret)
+		return ret;
+
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
+	    (pt_feature(common, PT_FEAT_FULL_VA) ||
+	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
+		return -EINVAL;
+
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+
+	/* Must be last, see pt_iommu_deinit() */
+	iommu_table->ops = &NS(ops);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
+
+#ifdef pt_iommu_fmt_hw_info
+#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
+#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
+void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
+		      struct pt_iommu_table_hw_info *info)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range top_range = pt_top_range(common);
+
+	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
+MODULE_IMPORT_NS("GENERIC_PT");
+
+#endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
new file mode 100644
index 00000000000000..182d5db2530a3a
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_IOMMU_H
+#define __GENERIC_PT_IOMMU_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+struct pt_iommu_ops;
+
+/**
+ * DOC: IOMMU Radix Page Table
+ *
+ * The IOMMU implementation of the Generic Page Table provides an ops struct
+ * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
+ * the generic map/unmap interface.
+ *
+ * This interface uses a caller provided locking approach. The caller must have
+ * a VA range lock concept that prevents concurrent threads from calling ops on
+ * the same VA. Generally the range lock must be at least as large as a single
+ * map call.
+ */
+
+/**
+ * struct pt_iommu - Base structure for IOMMU page tables
+ *
+ * The format-specific struct will include this as the first member.
+ */
+struct pt_iommu {
+	/**
+	 * @domain: The core IOMMU domain. The driver should use a union to
+	 * overlay this memory with its previously existing domain struct to
+	 * create an alias.
+	 */
+	struct iommu_domain domain;
+
+	/**
+	 * @ops: Function pointers to access the API
+	 */
+	const struct pt_iommu_ops *ops;
+
+	/**
+	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
+	 * may want to set the NID to the device's NID, if there are multiple
+	 * table walkers.
+	 */
+	int nid;
+};
+
+/**
+ * struct pt_iommu_info - Details about the IOMMU page table
+ *
+ * Returned from pt_iommu_ops->get_info()
+ */
+struct pt_iommu_info {
+	/**
+	 * @pgsize_bitmap: A bitmask where each set bit indicates
+	 * a page size that can be natively stored in the page table.
+	 */
+	u64 pgsize_bitmap;
+};
+
+struct pt_iommu_ops {
+	/**
+	 * @get_info: Return the pt_iommu_info structure
+	 * @iommu_table: Table to query
+	 *
+	 * Return some basic static information about the page table.
+	 */
+	void (*get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info);
+
+	/**
+	 * @deinit: Undo a format specific init operation
+	 * @iommu_table: Table to destroy
+	 *
+	 * Release all of the memory. The caller must have already removed the
+	 * table from all HW access and all caches.
+	 */
+	void (*deinit)(struct pt_iommu *iommu_table);
+};
+
+static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
+{
+	/*
+	 * It is safe to call pt_iommu_deinit() before an init, or if init
+	 * fails. The ops pointer will only become non-NULL if deinit needs to be
+	 * run.
+	 */
+	if (iommu_table->ops)
+		iommu_table->ops->deinit(iommu_table);
+}
+
+/**
+ * struct pt_iommu_cfg - Common configuration values for all formats
+ */
+struct pt_iommu_cfg {
+	/**
+	 * @features: Features required. Only these features will be turned on.
+	 * The feature list should reflect what the IOMMU HW is capable of.
+	 */
+	unsigned int features;
+	/**
+	 * @hw_max_vasz_lg2: Maximum VA the IOMMU HW can support. This will
+	 * imply the top level of the table.
+	 */
+	u8 hw_max_vasz_lg2;
+	/**
+	 * @hw_max_oasz_lg2: Maximum OA the IOMMU HW can support. The format
+	 * might select a lower maximum OA.
+	 */
+	u8 hw_max_oasz_lg2;
+};
+
+#endif
-- 
2.43.0


