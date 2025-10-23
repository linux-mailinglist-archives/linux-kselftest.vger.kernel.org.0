Return-Path: <linux-kselftest+bounces-43941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F3C02E42
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEED64F91AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401227815E;
	Thu, 23 Oct 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOz9gUfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C79277CAF;
	Thu, 23 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243678; cv=fail; b=tO7v4CGD/nVGzeIllNnI1FGCdjOHVxz7m7CSlK9/trrKXFiO5xWn8eZPE9HeUebEInmb7lNQdJ91BppoMt75nP/5Z2IV6KkTvCxJLLDgnGvKRU0lcSXoMLGdW7sQNoksxXqsAHTBTCq9GnpbhhtvT/nc6opUW8+7ViZGA2y/xbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243678; c=relaxed/simple;
	bh=ebhsIpe2bcYSTFi49Q2NUsHhNNak1r6ifDG6HI4oruE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiTtfyg7unarsux289TIRGvJHz8Xs1RX09pgES5PGg/KHfZoUOJf3RKdgpL22x8TAjPKPN5ONS1cZtgQZKSFNP4PeO/POX5zD8PcyXXUQF1AH4I9jDdyFOIYJNdBHGmOQVkRnrdAYGKrxScnm7d2hjjkXjnQ8Vwn/IEwZmNrbKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOz9gUfZ; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJSoWNvz9ItA32MziCgCnZuRHjTTPnCeB7SZFvmoQ5hLStnsQAB5hhYZRcS0NqjW5a3MzrRKhRbml3d6814BwEiQWY9IlMMH6J1CCPMZoaZ2N/Fxp4cZCswdT8lvC71sRkSF9+hebBo2nFZw2oOKTqPtN2u9oI9BTkqpa7HzAbvDPtxJKgzYfAE+czCr3BWP6UJ5JJ8DkMvZ7Q0pWo9vhp968YPQCToHl0kQfs6cWVtWQpiW95j59bVYAouhFKWv9YdJP5dfjKVbkXuFnystEZ3zZMyTQPUHwf55sXaKpegvw5D6YuxYEPMfaTi8ntL2f8/j+E4F2YlJ/s3WCRJh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HGDQZ+7xQyCuLXiLkzhJqAiXOAQaGdzyE4CwjBF7PI=;
 b=lr/5gSi00Z6td7XQHlwJhWy86QQMRtlELUlntFlQwbDxBzHUdCdcRnjueMkxuAemWHI3aqC02wA5ME0RJYBGYIMI4hQeQjdyvlrMOtsWQZ0fRFrcA6Whiy/A/Gag94CUe4qn+Yvojk6oe7/quVIAhowdgTtsZJ76QjSfX0uGbX6oWQAoTs9kDDvWsYcSoptsoP6hlkfJJaHVi5LsU60knp3t6TfetqjHVeHO4J9qIph+Mx2UHBPsmMvNOzftJQ8nkbtm4WGmRgpTmEJM/WMpikRecy9kNA3FdUrVbMFx0G5+c35Yq76awwOptZd2cHf/MxtpvbydybmkEsVEbVTkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HGDQZ+7xQyCuLXiLkzhJqAiXOAQaGdzyE4CwjBF7PI=;
 b=bOz9gUfZWXErklBSEq4mK1sKZhBay5yUWqWS5sGGAi0DmU4EQz27+Azh9e4UylJ93eWVgXPMMs1epYtv6v2PBx902THUu+e24Ra0JogH8d0uwTuU2AuCRaSUqJBrrScgoLrGyVzpH8lLf1b3ZZjoOFNc0kvY1zfk8e/kD1Z2Z2XzCSoaDq107Erw/+MKn3/h5kODUp+ohcQczA5AeycxCkRmh8WBP6pAvL0ewTo2pp93tOvkDlkS587XkOYQohCHtKzQc5M1PuYripWx9NIrJEji09vBvTlvQXZElJL0Zuk8A46M/8kaw1dPJhL6I6Ilv5tHkQv2dF3z/BqfogcKcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 18:21:05 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v7 13/15] iommu/amd: Use the generic iommu page table
Date: Thu, 23 Oct 2025 15:20:43 -0300
Message-ID: <13-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d874ed-c6d0-46d1-855e-08de1260e8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tntJhCSBLzMu7obZHb1Qs3NQMmc95NhP0f8VJ8feO3kGvoHc8mUxj1E/P5cd?=
 =?us-ascii?Q?OEquA/LhRpD0qSly9RVo0wLXyPjm+yqc40KcJu8r4+oWF+oeCTiQh5nMV7OF?=
 =?us-ascii?Q?roqX7gLPJ8OTV+bnfsHs/IekiQJVnvnimnpxtvFpGO24nxyNOz+2GBBFEfrW?=
 =?us-ascii?Q?HLGBOpWfRh804sJY7NCCIJzOVN4qm48tfhDlLLbtxC63IcayorlTpb3IUy1V?=
 =?us-ascii?Q?WwL2OF64NqJAN65AC+JJ+KkK5s48wmXYcpUD05jMBq9+sUnD+uZVHa6gWQCE?=
 =?us-ascii?Q?WB1NdaJdFe2zA79/79Ow/66iNIHfh6TxHA4pJZcZ8Y54xLvWvfoGtuhscdld?=
 =?us-ascii?Q?TdrKoBbEklJRkmdOO3Ucn4GJke3YWY+eOqV3qkDHgPFaxHW73yw6cd23OZWB?=
 =?us-ascii?Q?oD5K7uLm7LmfgSJd4XcY19Ix1XDoTmW052JDDBXbCPhJihUgbFZdMcTPUvLy?=
 =?us-ascii?Q?+xEONO5U8i4X9Gl5SE1OWziwja72PXpFYsm8c+9Mih8vRbHBbDR6c3wciMgT?=
 =?us-ascii?Q?pcFEzyib7nq/ozuJai4uCL6FcjfEVjALS5UghMZbmwmc4zC3DR0gWnDLW9e1?=
 =?us-ascii?Q?Jv7W9Enf/iZWB2T8auXs3OAnGF6/Tj8OvjtK4izlVE3rMkNyriy8zEZPeQLm?=
 =?us-ascii?Q?SJO1gXVl/XBYPq6UaPgNa44BsPcA/wYiAa6HVHuobLf9Q2swaMVxwI7H2XL2?=
 =?us-ascii?Q?U9yALS47GanFumar1cs2sSmyyIOOKEgyLsy+ShG61hRkvFstRvtdXq3VFKa/?=
 =?us-ascii?Q?QMQ9Lolp95bLiI0qNwBsZJjXTY8475A5GkS9NUxSGNx3SnR7Z56Aut5NCURE?=
 =?us-ascii?Q?dnh3nwh3tyXdArkVvMtlnrlJm+bEAChqLomZmHvgeIoWYqgwD/P4kpI0UFvD?=
 =?us-ascii?Q?iQ2O7KuT0UPDjEXZ8MwR7YYyFwRksvHm2lSydsHObOkiHqFFUXCmHiiMpndF?=
 =?us-ascii?Q?SPeSQ37X5lCMk6RdHN46ek2ZTlSpi+Zzqcm5HIjuheyE7YE0uthCl479C8c8?=
 =?us-ascii?Q?3GfGJKVNW9+YRKjr/XubVEHLr0igTsSAzF2s6BXI3x8YxmXyaIbrLohkkIR2?=
 =?us-ascii?Q?WOHdCrcjMZUL6TsZHFOq8k5vGso5wB+USKMLQYGNRqoC//WHMA+eHplC9eZZ?=
 =?us-ascii?Q?aLSZBBjBsA0SOt5tWiBo+/jRjvS5GXWO6wSN3p6AwWwJVJCxO1hrtTuogcET?=
 =?us-ascii?Q?/b3IB3NMCBVW76hsfn5wJM8i6TgXfW8fByqZqjl3OMrOUNIT4OBL/FlqdcPR?=
 =?us-ascii?Q?fkrCdJI1QxTyK8mq5cZZjxTuGXfkHxwmgCYpayX81me2l604GWQp8vuW8nnx?=
 =?us-ascii?Q?pdfjueTle24HihgKuuLZtndp2ugeSrwr5nV1ukFZbUSgzMzNIDWlgb1waRQL?=
 =?us-ascii?Q?bdUZEA04u23jNwCrhCfCNmeF4vj3Qvn9zUibkQGKveWl1oOgTSQO2v/OwOR4?=
 =?us-ascii?Q?kQAtOPTzSEMz/90hlNia92oRLoMmxFnzY4VtJFw/u0JX80/XthwlCWSe9q3i?=
 =?us-ascii?Q?5s5c4x/JrshtSTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zf96ceKA6C0XPyzvsRTN07OsTY4y2Nz4ICB5xu19J12iAleFGY/G7OQwYxjF?=
 =?us-ascii?Q?eqjFXK0iG/Wh4R+jfGWE5PQuMglBORt9kuwKudb3v8/aevQ8luujsmNMcJ3K?=
 =?us-ascii?Q?2fXaFfjtbn7q+WK+9ztaIhp5ZhV+Zcs+3iiUljb5mqN7T6O1mHHZw9/4hMwr?=
 =?us-ascii?Q?ehNOOol82yL0wJN8cDn4xZAQaFbLlP/WVrB96Aa6zmxypdFnWqX57l/audxB?=
 =?us-ascii?Q?LQ75Ub1pHsyyvwmy6LFzu5//FgLqAiDVjJpefmwnphQ5dxkVcWNJwB6BlwWY?=
 =?us-ascii?Q?yMjadCxlT1calHxyJ0WybsJk394n+psIK3fY3D//ssUJ0wG8GmHs+IFt/rJI?=
 =?us-ascii?Q?5lEv7iIjkKqn7TEkqDELj3ZZvrfpGerQFdPmgDKzzOOZouydvVQdjKp3orTQ?=
 =?us-ascii?Q?8S/mvbAprpMWfGEIVVdebDPXuqo9Nfl9sJ+IkuZ6SkIAnPT/KSxmWclXeqEc?=
 =?us-ascii?Q?qsU6jeXI4RLWSH1k8K3s+dWzF2cbJFAjApc5uU/X2W3GOtQXHFVRiEXqc0gE?=
 =?us-ascii?Q?cPuWitUHh+4gA/S+raj5JYtc4KWCCchsIGZGVoePU+zllgb0RDNqI265S4m5?=
 =?us-ascii?Q?xp9cP8PfZea+sZfGpgik+lUBPwDmGwlYbENAuspcQC7alxUE8w/5hKcvEfhc?=
 =?us-ascii?Q?pfLAMLmkdiMrMkX7rSy/mcKIj6HSghyRIFH+lRl3MzTWBwRT15GQpTamiD36?=
 =?us-ascii?Q?Ri9jXVT7WYgLrmySE7xDGmyHmWaX5GxUojRLQghWFo47pBvgBg/mDgJ4ebsW?=
 =?us-ascii?Q?/sA4qG2phXTon2VN5tp7GeKNuvc/F9Kw5Wk+fm8k4hDeTywCqQGVYop+sUp1?=
 =?us-ascii?Q?qc5HDZRt+DMvL9utLqgvcYkIEg2Ke8nT6NzAxX434F1B2oV7cpjzzGtt/hef?=
 =?us-ascii?Q?eGleyv4zhBHVPM0Qi2slGlf0I4kJnMaIfW+bjvY14hsgCCFJrIf/d1GIQU8F?=
 =?us-ascii?Q?WaxMadVS4xHwWxGdFuQmB6W/S3qvq0O8hdAYJ9hiuQ6LiGhB43ZJfQb7i6Ax?=
 =?us-ascii?Q?KdJuwTlfqaAsqiG9RzuGHlOiv3JpTh7SWbOe1W4p2oGtuf4JTjPxRrItXkCS?=
 =?us-ascii?Q?21pHrD3PAzBSSeSUPfdlbxjMSU4AuX48byFxHn2o4NXGAtakKuA4fpcd2Tsz?=
 =?us-ascii?Q?E1Rngi0JeOyNm/6CCv3uspwbBkc2aEv50ZZqLHsCqw2ziJV9JPlTpO+utsTP?=
 =?us-ascii?Q?Uf+PQ9jt2pZDCyFU/e0n+K4ozEaqmNfrCiJx+2ieJrqfKos2YG8E9VINHssY?=
 =?us-ascii?Q?IBHD3vdCAqED9bL9jyp8enBK8Ojxi9Uc5+aJgcsl4cGKZGNjXAlxiiHFmowX?=
 =?us-ascii?Q?hv2qAFYB1Jdp1AKMdVQuwQ3Ux6hGF8Uokw2V/fSQCwAmK75TLbB+0vkybbYE?=
 =?us-ascii?Q?7s2eeV2h83kfp85/L64PJwR16XSz99JCZyqzzy3OL0O+rVN0BJwnc9RJImiB?=
 =?us-ascii?Q?h1f8ZkU/7vtMTdzvoFyo5MzFW1+V20haoZRmqmSDT3Op9/JTet0aZXRhIdKY?=
 =?us-ascii?Q?JaXKCTArcOG43XwtWyamv0G3YP8HxKWMyQAZh+c5bCYVz9iw/2Fmzjxx6lhz?=
 =?us-ascii?Q?wZPFt0IYkgSfbwIQg9Kpf1Q66q4trCo8I/jSU+qy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d874ed-c6d0-46d1-855e-08de1260e8ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:56.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiSiUG9HzK3uZVSOve4qL0W2YNXexpgLAFnECG8kUS1oI3tn31//VUUCK47xt3UJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Replace the io_pgtable versions with pt_iommu versions. The v2 page table
uses the x86 implementation that will be eventually shared with VT-d.

This supports the same special features as the original code:
 - increase_top for the v1 format to allow scaling from 3 to 6 levels
 - non-present flushing
 - Dirty tracking for v1 only
 - __sme_set() to adjust the PTEs for CC
 - Optimization for flushing with virtualization to minimize the range
 - amd_iommu_pgsize_bitmap override of the native page sizes
 - page tables allocate from the device's NUMA node

Rework the domain ops so that v1/v2 get their own ops. Make dedicated
allocation functions for v1 and v2. Hook up invalidation for a top change
to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
that becomes unused in this patch. The next patch will delete the rest of
it.

This fixes a race bug in AMD's increase_address_space() implementation. It
stores the top level and top pointer in different memory, which prevents
other threads from reading a coherent version:

   increase_address_space()   alloc_pte()
                                level = pgtable->mode - 1;
	pgtable->root  = pte;
	pgtable->mode += 1;
                                pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];

The iommupt version is careful to put mode and root under a single
READ_ONCE and then is careful to only READ_ONCE a single time per
walk.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig           |   5 +-
 drivers/iommu/amd/amd_iommu.h       |   1 -
 drivers/iommu/amd/amd_iommu_types.h |  12 +-
 drivers/iommu/amd/io_pgtable.c      |   2 -
 drivers/iommu/amd/iommu.c           | 538 ++++++++++++++--------------
 5 files changed, 282 insertions(+), 276 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index ecef69c11144db..f2acf471cb5d9f 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -11,10 +11,13 @@ config AMD_IOMMU
 	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
-	select IOMMU_IO_PGTABLE
 	select IOMMU_SVA
 	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_AMDV1
+	select IOMMU_PT_X86_64
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9b4b589a54b57e..25044d28f28a8d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -88,7 +88,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * the IOMMU used by this driver.
  */
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a6e..d90a285b44eb3a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
+#include <linux/generic_pt/iommu.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -589,9 +590,13 @@ struct pdom_iommu_info {
  * independent of their use.
  */
 struct protection_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+		struct pt_iommu_x86_64 amdv2;
+	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct iommu_domain domain; /* generic domain handle used by
-				       iommu core code */
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
@@ -602,6 +607,9 @@ struct protection_domain {
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
 /*
  * This structure contains information about one PCI segment in the system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 70c2f5b1631b05..f64244938c9af7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -136,8 +136,6 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 	pgtable->mode += 1;
 	write_seqcount_end(&pgtable->seqcount);
 
-	amd_iommu_update_and_flush_device_table(domain);
-
 	pte = NULL;
 	ret = true;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1cee8..0dc4d9682000bf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -30,7 +30,6 @@
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
-#include <linux/io-pgtable.h>
 #include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
@@ -41,9 +40,9 @@
 #include <asm/gart.h>
 #include <asm/dma.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
-#include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -60,7 +59,6 @@ LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
-static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
@@ -74,11 +72,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data);
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level);
+
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level);
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
 static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
+static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
+					bool enable);
 
 /****************************************************************************
  *
@@ -1756,42 +1761,6 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 					CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
-/* Flush the not present cache if it exists */
-static void domain_flush_np_cache(struct protection_domain *domain,
-		dma_addr_t iova, size_t size)
-{
-	if (unlikely(amd_iommu_np_cache)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&domain->lock, flags);
-		amd_iommu_domain_flush_pages(domain, iova, size);
-		spin_unlock_irqrestore(&domain->lock, flags);
-	}
-}
-
-
-/*
- * This function flushes the DTEs for all devices in domain
- */
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	lockdep_assert_held(&domain->lock);
-
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
-
-		set_dte_entry(iommu, dev_data);
-		clone_aliases(iommu, dev_data->dev);
-	}
-
-	list_for_each_entry(dev_data, &domain->dev_list, list)
-		device_flush_dte(dev_data);
-
-	domain_flush_complete(domain);
-}
-
 int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
@@ -2051,7 +2020,8 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;
 	u32 old_domid;
@@ -2060,19 +2030,36 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
-
-	if (gcr3_info && gcr3_info->gcr3_tbl)
-		domid = dev_data->gcr3_info.domid;
-	else
-		domid = domain->id;
+	struct pt_iommu_amdv1_hw_info pt_info;
 
 	make_clear_dte(dev_data, dte, &new);
 
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		domid = dev_data->gcr3_info.domid;
+	else {
+		domid = domain->id;
 
-	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
-		    << DEV_ENTRY_MODE_SHIFT;
+		if (domain->domain.type & __IOMMU_DOMAIN_PAGING) {
+			/*
+			 * When updating the IO pagetable, the new top and level
+			 * are provided as parameters. For other operations i.e.
+			 * device attach, retrieve the current pagetable info
+			 * via the IOMMU PT API.
+			 */
+			if (top_paddr) {
+				pt_info.host_pt_root = top_paddr;
+				pt_info.mode = top_level + 1;
+			} else {
+				WARN_ON(top_paddr || top_level);
+				pt_iommu_amdv1_hw_info(&domain->amdv1,
+						       &pt_info);
+			}
+
+			new.data[0] |= __sme_set(pt_info.host_pt_root) |
+				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
+					       << DEV_ENTRY_MODE_SHIFT;
+		}
+	}
 
 	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
 
@@ -2138,7 +2125,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (set)
-		set_dte_entry(iommu, dev_data);
+		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
 
@@ -2156,6 +2143,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int max_pasids = dev_data->max_pasids;
+	struct pt_iommu_x86_64_hw_info pt_info;
 	int ret = 0;
 
 	 /*
@@ -2178,7 +2166,8 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 	if (!pdom_is_v2_pgtbl_mode(pdom))
 		return ret;
 
-	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
+	ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
@@ -2500,54 +2489,6 @@ struct protection_domain *protection_domain_alloc(void)
 	return domain;
 }
 
-static int pdom_setup_pgtable(struct protection_domain *domain,
-			      struct device *dev)
-{
-	struct io_pgtable_ops *pgtbl_ops;
-	enum io_pgtable_fmt fmt;
-
-	switch (domain->pd_mode) {
-	case PD_MODE_V1:
-		fmt = AMD_IOMMU_V1;
-		break;
-	case PD_MODE_V2:
-		fmt = AMD_IOMMU_V2;
-		break;
-	case PD_MODE_NONE:
-		WARN_ON_ONCE(1);
-		return -EPERM;
-	}
-
-	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &domain->iop.pgtbl.cfg, domain);
-	if (!pgtbl_ops)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static inline u64 dma_max_address(enum protection_domain_mode pgtable)
-{
-	if (pgtable == PD_MODE_V1)
-		return PM_LEVEL_SIZE(amd_iommu_hpt_level);
-
-	/*
-	 * V2 with 4/5 level page table. Note that "2.2.6.5 AMD64 4-Kbyte Page
-	 * Translation" shows that the V2 table sign extends the top of the
-	 * address space creating a reserved region in the middle of the
-	 * translation, just like the CPU does. Further Vasant says the docs are
-	 * incomplete and this only applies to non-zero PASIDs. If the AMDv2
-	 * page table is assigned to the 0 PASID then there is no sign extension
-	 * check.
-	 *
-	 * Since the IOMMU must have a fixed geometry, and the core code does
-	 * not understand sign extended addressing, we have to chop off the high
-	 * bit to get consistent behavior with attachments of the domain to any
-	 * PASID.
-	 */
-	return ((1ULL << (PM_LEVEL_SHIFT(amd_iommu_gpt_level) - 1)) - 1);
-}
-
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 {
 	if (amd_iommu_hatdis)
@@ -2556,38 +2497,229 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-static struct iommu_domain *
-do_iommu_domain_alloc(struct device *dev, u32 flags,
-		      enum protection_domain_mode pgtable)
+static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
 {
-	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct protection_domain *pdom =
+		container_of(iommupt, struct protection_domain, iommu);
+
+	return &pdom->lock;
+}
+
+/*
+ * Update all HW references to the domain with a new pgtable configuration.
+ */
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level)
+{
+	struct protection_domain *pdom =
+		container_of(iommu_table, struct protection_domain, iommu);
+	struct iommu_dev_data *dev_data;
+
+	lockdep_assert_held(&pdom->lock);
+
+	/* Update the DTE for all devices attached to this domain */
+	list_for_each_entry(dev_data, &pdom->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		/* Update the HW references with the new level and top ptr */
+		set_dte_entry(iommu, dev_data, top_paddr, top_level);
+		clone_aliases(iommu, dev_data->dev);
+	}
+
+	list_for_each_entry(dev_data, &pdom->dev_list, list)
+		device_flush_dte(dev_data);
+
+	domain_flush_complete(pdom);
+}
+
+/*
+ * amd_iommu_iotlb_sync_map() is used to generate flushes for non-present to
+ * present (ie mapping) operations. It is a NOP if the IOMMU doesn't have non
+ * present caching (like hypervisor shadowing).
+ */
+static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				    unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
+
+	if (likely(!amd_iommu_np_cache))
+		return 0;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	amd_iommu_domain_flush_pages(domain, iova, size);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	return 0;
+}
+
+static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_all(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
+}
+
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_pages(dom, gather->start,
+				     gather->end - gather->start + 1);
+	spin_unlock_irqrestore(&dom->lock, flags);
+	iommu_put_pages_list(&gather->freelist);
+}
+
+static const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
+	.get_top_lock = amd_iommu_get_top_lock,
+	.change_top = amd_iommu_change_top,
+};
+
+static const struct iommu_domain_ops amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
+
+static const struct iommu_dirty_ops amdv1_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1),
+	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
+};
+
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
 	int ret;
 
+	if (amd_iommu_hatdis)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	domain = protection_domain_alloc();
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->pd_mode = pgtable;
-	ret = pdom_setup_pgtable(domain, dev);
+	domain->pd_mode = PD_MODE_V1;
+	domain->iommu.driver_ops = &amd_hw_driver_ops_v1;
+	domain->iommu.nid = dev_to_node(dev);
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		domain->domain.dirty_ops = &amdv1_dirty_ops;
+
+	/*
+	 * Someday FORCE_COHERENCE should be set by
+	 * amd_iommu_enforce_cache_coherency() like VT-d does.
+	 */
+	cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+			      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+			      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+
+	/*
+	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
+	 * Unless we run in a virtual machine, which can be inferred according
+	 * to whether "non-present cache" is on, it is probably best to prefer
+	 * (potentially) too extensive TLB flushing (i.e., more misses) over
+	 * multiple TLB flushes (i.e., more flushes). For virtual machines the
+	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
+	 * the guest, and the trade-off is different: unnecessary TLB flushes
+	 * should be avoided.
+	 */
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	cfg.common.hw_max_vasz_lg2 =
+		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.starting_level = 2;
+	domain->domain.ops = &amdv1_ops;
+
+	ret = pt_iommu_amdv1_init(&domain->amdv1, &cfg, GFP_KERNEL);
 	if (ret) {
-		pdom_id_free(domain->id);
-		kfree(domain);
+		amd_iommu_domain_free(&domain->domain);
 		return ERR_PTR(ret);
 	}
 
-	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
-	domain->domain.geometry.force_aperture = true;
-	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
+	/*
+	 * Narrow the supported page sizes to those selected by the kernel
+	 * command line.
+	 */
+	domain->domain.pgsize_bitmap &= amd_iommu_pgsize_bitmap;
+	return &domain->domain;
+}
 
-	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	domain->domain.ops = iommu->iommu.ops->default_domain_ops;
+static const struct iommu_domain_ops amdv2_ops = {
+	IOMMU_PT_DOMAIN_OPS(x86_64),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	/*
+	 * Note the AMDv2 page table format does not support a Force Coherency
+	 * bit, so enforce_cache_coherency should not be set. However VFIO is
+	 * not prepared to handle a case where some domains will support
+	 * enforcement and others do not. VFIO and iommufd will have to be fixed
+	 * before it can fully use the V2 page table. See the comment in
+	 * iommufd_hwpt_paging_alloc(). For now leave things as they have
+	 * historically been and lie about enforce_cache_coherencey.
+	 */
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
 
-	if (dirty_tracking)
-		domain->domain.dirty_ops = &amd_dirty_ops;
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_x86_64_cfg cfg = {};
+	struct protection_domain *domain;
+	int ret;
 
+	if (!amd_iommu_v2_pgtbl_supported())
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = protection_domain_alloc();
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	domain->pd_mode = PD_MODE_V2;
+	domain->iommu.nid = dev_to_node(dev);
+
+	cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	/*
+	 * The v2 table behaves differently if it is attached to PASID 0 vs a
+	 * non-zero PASID. On PASID 0 it has no sign extension and the full
+	 * 57/48 bits decode the lower addresses. Otherwise it behaves like a
+	 * normal sign extended x86 page table. Since we want the domain to work
+	 * in both modes the top bit is removed and PT_FEAT_SIGN_EXTEND is not
+	 * set which creates a table that is compatible in both modes.
+	 */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		cfg.common.hw_max_vasz_lg2 = 56;
+	else
+		cfg.common.hw_max_vasz_lg2 = 47;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	domain->domain.ops = &amdv2_ops;
+
+	ret = pt_iommu_x86_64_init(&domain->amdv2, &cfg, GFP_KERNEL);
+	if (ret) {
+		amd_iommu_domain_free(&domain->domain);
+		return ERR_PTR(ret);
+	}
 	return &domain->domain;
 }
 
@@ -2608,15 +2740,27 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		/* Allocate domain with v1 page table for dirty tracking */
 		if (!amd_iommu_hd_support(iommu))
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
 		if (!amd_iommu_pasid_supported())
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
-	case 0:
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
+	case 0: {
+		struct iommu_domain *ret;
+
 		/* If nothing specific is required use the kernel commandline default */
-		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		if (amd_iommu_pgtable == PD_MODE_V1) {
+			ret = amd_iommu_domain_alloc_paging_v1(dev, flags);
+			if (ret != ERR_PTR(-EOPNOTSUPP))
+				return ret;
+			return amd_iommu_domain_alloc_paging_v2(dev, flags);
+		}
+		ret = amd_iommu_domain_alloc_paging_v2(dev, flags);
+		if (ret != ERR_PTR(-EOPNOTSUPP))
+			return ret;
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
+	}
 	default:
 		break;
 	}
@@ -2628,8 +2772,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	struct protection_domain *domain = to_pdomain(dom);
 
 	WARN_ON(!list_empty(&domain->dev_list));
-	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
-		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+	pt_iommu_deinit(&domain->iommu);
 	pdom_id_free(domain->id);
 	kfree(domain);
 }
@@ -2734,93 +2877,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
-				    unsigned long iova, size_t size)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	if (ops->map_pages)
-		domain_flush_np_cache(domain, iova, size);
-	return 0;
-}
-
-static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
-			       phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			       int iommu_prot, gfp_t gfp, size_t *mapped)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	int prot = 0;
-	int ret = -EINVAL;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return -EINVAL;
-
-	if (iommu_prot & IOMMU_READ)
-		prot |= IOMMU_PROT_IR;
-	if (iommu_prot & IOMMU_WRITE)
-		prot |= IOMMU_PROT_IW;
-
-	if (ops->map_pages) {
-		ret = ops->map_pages(ops, iova, paddr, pgsize,
-				     pgcount, prot, gfp, mapped);
-	}
-
-	return ret;
-}
-
-static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
-					    struct iommu_iotlb_gather *gather,
-					    unsigned long iova, size_t size)
-{
-	/*
-	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
-	 * Unless we run in a virtual machine, which can be inferred according
-	 * to whether "non-present cache" is on, it is probably best to prefer
-	 * (potentially) too extensive TLB flushing (i.e., more misses) over
-	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
-	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
-	 * the guest, and the trade-off is different: unnecessary TLB flushes
-	 * should be avoided.
-	 */
-	if (amd_iommu_np_cache &&
-	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
-		iommu_iotlb_sync(domain, gather);
-
-	iommu_iotlb_gather_add_range(gather, iova, size);
-}
-
-static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova,
-				    size_t pgsize, size_t pgcount,
-				    struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	size_t r;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return 0;
-
-	r = (ops->unmap_pages) ? ops->unmap_pages(ops, iova, pgsize, pgcount, NULL) : 0;
-
-	if (r)
-		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
-
-	return r;
-}
-
-static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-					  dma_addr_t iova)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	return ops->iova_to_phys(ops, iova);
-}
-
 static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
@@ -2887,28 +2943,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
-					  unsigned long iova, size_t size,
-					  unsigned long flags,
-					  struct iommu_dirty_bitmap *dirty)
-{
-	struct protection_domain *pdomain = to_pdomain(domain);
-	struct io_pgtable_ops *ops = &pdomain->iop.pgtbl.ops;
-	unsigned long lflags;
-
-	if (!ops || !ops->read_and_clear_dirty)
-		return -EOPNOTSUPP;
-
-	spin_lock_irqsave(&pdomain->lock, lflags);
-	if (!pdomain->dirty_tracking && dirty->bitmap) {
-		spin_unlock_irqrestore(&pdomain->lock, lflags);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&pdomain->lock, lflags);
-
-	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
-}
-
 static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
@@ -2978,28 +3012,6 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 	return dev_data->defer_attach;
 }
 
-static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_all(dom);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
-static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
-				 struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_pages(dom, gather->start,
-				     gather->end - gather->start + 1);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
 static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -3034,11 +3046,6 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
-static const struct iommu_dirty_ops amd_dirty_ops = {
-	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
-	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
-};
-
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
@@ -3053,17 +3060,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.page_response = amd_iommu_page_response,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= amd_iommu_attach_device,
-		.map_pages	= amd_iommu_map_pages,
-		.unmap_pages	= amd_iommu_unmap_pages,
-		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-		.iova_to_phys	= amd_iommu_iova_to_phys,
-		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-		.iotlb_sync	= amd_iommu_iotlb_sync,
-		.free		= amd_iommu_domain_free,
-		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
-	}
 };
 
 #ifdef CONFIG_IRQ_REMAP
@@ -4072,3 +4068,5 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	return 0;
 }
 #endif
+
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


