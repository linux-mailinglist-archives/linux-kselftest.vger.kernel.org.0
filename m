Return-Path: <linux-kselftest+bounces-32349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E42AA9560
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56B516C688
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362CC25C706;
	Mon,  5 May 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="co8Kgy+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E225B675;
	Mon,  5 May 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454738; cv=fail; b=tg5zV36xUKFIz3UPzkgJEu4Sf45emVwnnbHjVvqwGGLbRU5zgOctnvWHlthQ1FzttIpwjVWyYZJ8FGfee6i2IDRM5v1tp+7HTg0NtvnXg9SDaiM06VDVi3oNk1B6HGsTSHYx46gFavhvjVJ4e7Se2mEkkVHCkj8zSkveEm9nvG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454738; c=relaxed/simple;
	bh=SKjpTQSvb/eYGTPy8XYF6nmsJfK8m5N300Nfmb1qMz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6Rl8ze8t40j5mGJfAK0CnPDlcJtdb4OjO9j3mZ6S9jW0Wmy7bvB50eV75Ghpqn5adWJc5p0xbNSNFsDrIvuTbD+Te7kFbe0kuMRr2SYcKjxf64q3Sd061iw96z9+ZLuQij7+nyIGFueOQIDLY1IZtjdBjf2AVbF8iRq5Onu6ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=co8Kgy+y; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyQQba2ED5bHCitJgCfcqf/e+1XCkZYYsZ/LSOn9FHY+gsEE7MzDiJgR12drpcU51Oy/E0Kk/nB3h9ia/7eRo2ighfXJICcRriEOxJRJM/Qd9BefnscYaEnCenPNNpNT67DtBuT5rVAQN3S16/w0vUJcREY+BYfjP1Uf972uW2oTUwxMk1jePElnMZAtv2mpr2FEoFufOi2ilX+SoXPDatwSi80kBhPZqN8YqW+N87fOMGdk9qnb9u1MlPyzRtXiiNCaKFq0d8TnqscwM9l/LOhMz39IhUM6s9U9YwDltinti9klhQui51QF9g5cF3Deb9eMP7qzETS7sO/Hw1losA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAkhmEeMeh07ZE2s6gvsYnEh0DnUXE+VTqIn8wy1HuA=;
 b=bT5BQ/UjOiGPoAHlctVnoCyySqi/26yUJ6016+O/r+OD0VHb7ovD0giiMlLr4VrfbLgMLBITvqPuCANdpMoZRME8hkKl8gfJlcy7rkvC0KJzuNuW9qNewuASNI7CirdST5WBINvS4rIOJG7M6wtajHZ59lj1jxlh17zkjTCEGHzJZ5KuoI4JSG5r7GrmXTz7SZjTS8LUshZa8bPzRCseH5kDDGWsFe8pb2+TRjGw+skl4NcLmZ5RMjn1YwXfCol33m85a8dgDOD5GH8gUdUcYS89fIkfXaHbPiYSIppmfoUpxa1EJQopRZzlQ3raqeYn2c83Li1g4z8hFxBdn10SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAkhmEeMeh07ZE2s6gvsYnEh0DnUXE+VTqIn8wy1HuA=;
 b=co8Kgy+yD5lbOS50my7UgHkG1WYsoYN2N/X+vFsbk+68L/x18BjO7ui3xdZ0GT2XRNVUnhO34N7akukak2RHqkYLSpevebz6aNf4x9B3oGrW54HBSac4N+Fhu3rF1c5ExITYzz93qwjCKV8qisq0sTu157sr6JlGAKQ2+W+AbP0ECa94bPfX/k276KkiwSliR7uX/F1u1sSfNJEnO/RtJfVzj3zJ/ODCSLsi3H8jlAuQ4IXsbs2pI5LoZTo0heih4ycx/d3OByLp5Xn/15vm0k/gRfkasxn9QuluU+ZFHs1LG3zA0W8BCi3mh0n3C9ikwd2VHIUBss2t/oMz1hYVDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:48 +0000
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
Subject: [PATCH v2 08/15] iommupt: Add read_and_clear_dirty op
Date: Mon,  5 May 2025 11:18:38 -0300
Message-ID: <8-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:408:141::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 042765e6-ebf3-44a7-a2d5-08dd8bdfbfc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8MgBWLAc5kV5WGEO992WKScjwp7jrYlne+bbg28pdFWyqdaJ6MlPRvrVMYTF?=
 =?us-ascii?Q?tWTrtAjR5OfOWqKCBJwNYnZvrejamTV577kMDzjwZW1ldvaHqgS+SzNN4ovO?=
 =?us-ascii?Q?x8zBVRD3v1frXii1zgWnghmuSoXTf40Ec04875it6FtY1BKtXs8bdVynTeNM?=
 =?us-ascii?Q?Pk1WtlIcCRtWn8XmzJSIBc56S5tLZ9jFDXKuLywdDWoHp2C7ZTd+D4g5BOE1?=
 =?us-ascii?Q?QHzPuSzEdbDgHNh3iJrutAKYWAl57f8xoTjJr/qJgXYy08SSnXADJb/xrQqb?=
 =?us-ascii?Q?kNTlT8sU8dBIUpfp3nYDFB/MBmbp22owjVLcu1OTuAF9Ey9N+GwupDRSgZY6?=
 =?us-ascii?Q?LIsMEK/Nb23qRUKf6CpiiBDj0ggAuxTUr50cr4MTsLew60xD4n+ubPfV/DeL?=
 =?us-ascii?Q?kGws/Unjbq2CdUXyltoShKobGwBvp39DmEDsHUyU7Dx81mQH7mGWK8jrH/zB?=
 =?us-ascii?Q?LJHpPuacBKVayrLFhEenoDsiCr8EkkeBAPSBZy/idFB2EUfyH+2zNyOltBXE?=
 =?us-ascii?Q?yMVHR55EJLlz04B1ole5nuToD8NAUykMofEL/FFwMALRA9JU2mdeuLdaLcCr?=
 =?us-ascii?Q?/vK/qLTbIiboHUS2qKn7+1IfjWtcrFIN7VhBsNC9OoHeZyQh00cJ0No9d+3z?=
 =?us-ascii?Q?a/Uk5RWaxpi1eZMVGpqWo/ucRTJLwx+/uGi8R5Xg5Ao9horu0W7IS+PoRUvo?=
 =?us-ascii?Q?PYgV266KFfFNbGJgr8gVaFGPG7RuVnTe4YdbrB6mFxdiPuWTBI2/JnmqD9fO?=
 =?us-ascii?Q?x130gY9aFg+xDcjGVLaMd2SxcmPi0Rrp2lfybvPMGjjWBDIW1iHj52C2GxEd?=
 =?us-ascii?Q?xw+e4RaA1oTWleXUN5mCXpLFd55bKVMcIITAIRgaq9ONYDbHFpZVbY2WlXql?=
 =?us-ascii?Q?2y+V/kiqzAsH7MyWtuRp2swhHh6Q1luhX7ki9zdyWY9bLkX67uDacj82Hiil?=
 =?us-ascii?Q?X0ICs31CTDbOT0uCOg3DZqSfgviVu9jKVFjmRvxrZnSi4o+fzR4sTor6hq00?=
 =?us-ascii?Q?VTWCb1W3a3qQV8LxiXENg43Sf5uKJlFNShPHimIq86wqoKMCF7P7LzIEIrOr?=
 =?us-ascii?Q?VLo9FYzq86F2huaD/eP9utjeSz4gGNSi2XCOI0hTacL0AX9tRBMBHInfg13a?=
 =?us-ascii?Q?kscq0JJJhoSwW7DgOwMOITRQPFHEoI5xltpXpkgf1G5QUjPKi/Rvd3ByqzVH?=
 =?us-ascii?Q?y+Qnao2K4/rL+PiGbvWBSub4PKlGIe1e/dNMwZKUzihwCWCRGyVgM55evdCr?=
 =?us-ascii?Q?HeG8E5K1bryvT9eDsoPD5x+F2OtYGu5n0hfvEsOorJpjsWLWsIq3fy/DvbmX?=
 =?us-ascii?Q?oabyY3KZlThi6/9cCuI861gqTU+HBA6Oj5ezQFNV+9FTxWGwfW5/vMoUwp8j?=
 =?us-ascii?Q?7W3lCL68uDp6MvHKmlQckFmy3VZQBpYLRqk8Zb9E/qrsC8BljiTb4aQNOapZ?=
 =?us-ascii?Q?9Gggt6oZza1iuo3kxzjalsgYrcI3RdpQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1KOaUoy7N9ibmyyFpj/oTMRsOwrDIRt7TwkZlQ8t1L0NeFXjyet97l/lxHX?=
 =?us-ascii?Q?24xyU0uEc7GbvhB5pYR7CVnMths4PeOmz77Ct0QZr+XOLULjL3STds/95CEp?=
 =?us-ascii?Q?gAbAu9R4BpP6U5wn5Xrxr6QfjHyK2CLc84EqOnKazSLIxhfDqLVGWwsjkY0j?=
 =?us-ascii?Q?N5abx0KeGeiHTXS/Te9uZoLgH1ZXVTK5M3E1aYt48KkYiaPnWECuIwfiWkNC?=
 =?us-ascii?Q?UbyYXUR+vJo/PQCGpm873QgB/7ci4xJEMaXC+vry1Q/jV/K7+jdPJCnGK5rZ?=
 =?us-ascii?Q?QmsCW88CufWpzEzHWN6oWKqYiuWIQxKICo+EdEqHslBVuqUgMqKBI3qJchcl?=
 =?us-ascii?Q?rdDLbUGJIEpYzXaSUwAu1pETidPSqCeNhM9M78KKOUQ1Uc8bL7k+UqquQ0/N?=
 =?us-ascii?Q?ORn/Xst3GBZtdMXRoieJcTYG6Ol7fWr7mvLEWA7nBQqiQ736uzhXy5IgBhIN?=
 =?us-ascii?Q?06zIhBNdxcfnbJhU+VmNtNwKjMR4AkKLpls9SVE3+YGTrTpk0jv3Mb+6wPMv?=
 =?us-ascii?Q?0tfKWeodq9gn9h2EYNqet2/4OjCDkxXRMAUpXAcDu2Pje1ok9HLjJoSUG94S?=
 =?us-ascii?Q?3Iqs0xPL4FjnVtOnEAHgLGxWh51f+tM304/BfwTODUpj3h1KgbDLx0kX9l+W?=
 =?us-ascii?Q?5RTd9VBMZANnSzPqKVlQA7Y5DRIvvEss6i/k2CqCPLQMwLSdYfsrN4wOBnJQ?=
 =?us-ascii?Q?dNU2wtT6fGaTDonH37ZzPBMfYkT+PjkDznjTAusCp6RGdNOSW24SzM6XKR0/?=
 =?us-ascii?Q?NHyUlKcAIxlz+Oj7S6dX/sRFABZeJfOy6O73RLwpXnEYfD+5fdB/DQuaYrlY?=
 =?us-ascii?Q?+KTWPzbhqB9D1GRhrI1/OzOhxX4Klb8JxTebAEEDQFUReP/ZebU4KRqjR3mh?=
 =?us-ascii?Q?kemZof+qe1zYD/Os2LUdAT9sscfU//qPfOoDxyoUTjIbpVeOktJxfm6umJJ4?=
 =?us-ascii?Q?OxALbuu1LZ535TUHS2L5I/DvLM5NuGZZ3IYlq1kpQbnOhfbmOYieqrFin0ia?=
 =?us-ascii?Q?oi7HhK91OVETxVbThHLagmIxA1jElVK7XxL8cTM/h5kfD13O/H6M4J2OaAye?=
 =?us-ascii?Q?d686rDMOF3TK4neQYS9Tw2GPJi4AUMdduiD+OYOJJWWG7rqIkGfAlZos/Zd9?=
 =?us-ascii?Q?/9rI1gUqhpGN/+9ubx4c9EKGtK2wwzGqa2xHmvLxq25Duq66vsj1DqHPPr0n?=
 =?us-ascii?Q?pBvMordLDh5V1j/SVXEuwAkanIiZfPXYQxYwJOgb0ThD+Dp3N+3DjllJERfC?=
 =?us-ascii?Q?SvM7sHjWZ8pxJE8k9BocmxfvcrasDe9qJTThi4RlbsugQxabfDgHZFiQYDNU?=
 =?us-ascii?Q?hV1kV3LtaXPU2Asxy0J7fBz4ujZ+FHftf0JLtI1pHNVgc5zmdu8PY3W4+OEP?=
 =?us-ascii?Q?U5oGySn2joaxz/eGhTCdj2jU6SM0Eix8czWZ/UQ8SwfW/kaX1fDBZ6h/j9ei?=
 =?us-ascii?Q?42nN5WJxgB4YLKJB5VS8p6VsqSG+Q0mpvDMbW+f4VIoHuf/iY1HN2I9yVLVD?=
 =?us-ascii?Q?8d09njrHsVtdp+DHfWmjIPxnzjqNPUiEVzu2Ez7u/Y5d4V/42yQRbIJnllGo?=
 =?us-ascii?Q?AxG1FTLmUOBfjuITicSFcbedw0XM1JW5zZaTHIaT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042765e6-ebf3-44a7-a2d5-08dd8bdfbfc7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:47.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSTFpr6i1F3hbreP1wkEDy4EgqGDnMajlEY7evokhQ1N8WRMGV9oVTsHZJJbU0RN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 103 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 109 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 7a680017f35bff..c3ea0f7de0d190 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -161,6 +161,107 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
+struct pt_iommu_dirty_args {
+	struct iommu_dirty_bitmap *dirty;
+	unsigned int flags;
+};
+
+static void record_dirty(struct pt_state *pts,
+			 struct pt_iommu_dirty_args *dirty,
+			 unsigned int num_contig_lg2)
+{
+	pt_vaddr_t dirty_len;
+
+	if (num_contig_lg2 != ilog2(1)) {
+		unsigned int index = pts->index;
+		unsigned int end_index = log2_set_mod_max_t(
+			unsigned int, pts->index, num_contig_lg2);
+
+		/* Adjust for being contained inside a contiguous page */
+		end_index = min(end_index, pts->end_index);
+		dirty_len = (end_index - index) *
+				log2_to_int(pt_table_item_lg2sz(pts));
+	} else {
+		dirty_len = log2_to_int(pt_table_item_lg2sz(pts));
+	}
+
+	if (dirty->dirty->bitmap)
+		iova_bitmap_set(dirty->dirty->bitmap, pts->range->va,
+				dirty_len);
+
+	if (!(dirty->flags & IOMMU_DIRTY_NO_CLEAR)) {
+		pt_entry_set_write_clean(pts);
+		iommu_iotlb_gather_add_range(dirty->dirty->gather,
+					     pts->range->va, dirty_len);
+	}
+}
+
+static inline int __read_and_clear_dirty(struct pt_range *range, void *arg,
+					 unsigned int level,
+					 struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_dirty_args *dirty = arg;
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			ret = pt_descend(&pts, arg, __read_and_clear_dirty);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && pt_entry_write_is_dirty(&pts))
+			record_dirty(&pts, dirty,
+				     pt_entry_num_contig_lg2(&pts));
+	}
+	return 0;
+}
+
+/**
+ * read_and_clear_dirty() - Manipulate the HW set write dirty state
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the IOVA
+ * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
+ *
+ * Iterate over all the entries in the mapped range and record their write dirty
+ * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
+ * the entries will be left dirty, otherwise they are returned to being not
+ * write dirty.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Returns: -ERRNO on failure, 0 on success.
+ */
+int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
+				    unsigned long iova, size_t size,
+				    unsigned long flags,
+				    struct iommu_dirty_bitmap *dirty)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_iommu_dirty_args dirty_args = {
+		.dirty = dirty,
+		.flags = flags,
+	};
+	struct pt_range range;
+	int ret;
+
+#if !IS_ENABLED(CONFIG_IOMMUFD_DRIVER) || !defined(pt_entry_write_is_dirty)
+	return -EOPNOTSUPP;
+#endif
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, size);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __read_and_clear_dirty, &dirty_args);
+	PT_WARN_ON(ret);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
@@ -1000,5 +1101,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index fd0c598526ce57..aac565611cbffa 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -12,6 +12,7 @@
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_flush_ops;
+struct iommu_dirty_bitmap;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -175,6 +176,9 @@ struct pt_iommu_cfg {
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
 		struct iommu_iotlb_gather *iotlb_gather);                      \
+	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
+		struct iommu_domain *domain, unsigned long iova, size_t size,  \
+		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -195,6 +199,8 @@ struct pt_iommu_cfg {
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
 	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
+#define IOMMU_PT_DIRTY_OPS(fmt) \
+	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


