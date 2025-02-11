Return-Path: <linux-kselftest+bounces-26381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7ADA3103A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75F8188B07B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35757254B17;
	Tue, 11 Feb 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dfk37PcV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45686254AFF;
	Tue, 11 Feb 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289056; cv=fail; b=ouvM8SMyGCLnEFIGntp/BSWOIOVu7uOf4mYJRjfK4lItvXAclm4nkebf8TeNnWDEek1CMZvVvhLMRuKzXM/KIJmE8aKUuV9H7YKvC0loA2JQ501WupICVpk4shptEqECnov4WdbOUartHClkjLkP0TF5t9uSoWhxROhTrRfOvy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289056; c=relaxed/simple;
	bh=+RQccpuYlY19/lLmWyWHzI+CysA/a577KD+IW8ynSUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkhsL6d5BtYEr7kWdHqCbSmwMcLGdztDMplOWsu75+p76b2ez4L8Nm3/uuCgxgcQiqUZnI+Jk8sY7k78tXe8Osa1YH6vIGBfqoAjckWFSQI1ZpxLxcyTWRnbrxOjAel/5VpbHBb0z2r0IBTlgVbYKsGtIJOu0G6bijq8Je5x2VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dfk37PcV; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGJJpxSeg85pnldFExlk9Frs9gpKIZ/9GBGQnySghqVmEfMBkcO1Kf527x5KumPtu7Pwu5zkfInCzirinJ5lCp+Cgd2Z1uM0R7ywggVNdhtF/hQgngA5PSLXsRrkn9ha09OsRfAbPweicoK3jueUwFpxJRsGl7FzztCZbO1g91zEUrXZ0hX6vZyigbU9CT/lBHKSzT35JD3EhjK7CSb5NxbTrgygpe5TEqqkDfCCD7WQyotfrsNliweAXxLRvHEbrqGPcNbPWoJ18ZVU16w3hUxskVKX95oTHgp4nv/EkVQk8L+X8pfiB16tfufUUm+JDWwbElbZBKfwvOGgcuoEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAYnIf8/Gs+3uoCIL3RT60CY7Ue8nFoACFYyR4tk1gM=;
 b=F8YpVmbLN912DJ1u3oFUWJQR5x78uGutggk4yjSo570iypw7jvTg3WDiT+KZV4U1Gh/ICC35tY/uYkr5OrHvt9mvrtd4sywNsu8KVyT55issMMRV3LjYEjUNiGkF2mOq5m/hww779w0UWpNdakf165pnf+4VY4WwrShNYqWt+aqTTQUIHhBxGTlxHCStSfiXiICi899C8cVISIp2wtOGfgPRIvxhu1PbaF5JM0ssW+XwjDH+c0loIiP1ikRuEDcxUm1Gq3ervqUV0IezcbPPQaWz9ZXDxcsHEMns+g04Ps35tlcqfCuwojFRnVtWxqH4MKfGU+Wu4lU1f+nao+YBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAYnIf8/Gs+3uoCIL3RT60CY7Ue8nFoACFYyR4tk1gM=;
 b=Dfk37PcVCt/chtjco3pf1eWFW+rVz2WMJ1d349SA8AJdFBADhx065aJVYv7yrCBlPSl8L21y8VgKRsIu60iYBmU6ZSNKxkJLgrgNWp+Bhdw7nyBwU7fV4miZgz5y4aiJQaoeFc8ehdLNAs9E1hlZ6C7EAks9ZQscDNmK8mWxZgqB+fQN+x04xaO7AdTABcnUedwP+DFR2hAGUPr56PWOwcT/4lUlfaHDqibLyoOPyaAxNykVIHOt61Vb3rTrCDLVZyTpAKc7moWxcfmWiuZxcwNa9Q91qO+KF9CenLwt7P64a41w5jO6ZBZk135dLshD49jSBCbvREyDUCJuZU5bfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:48 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v7 4/8] mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
Date: Tue, 11 Feb 2025 10:50:29 -0500
Message-ID: <20250211155034.268962-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:408:f8::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4c2bd4-0e1f-47ca-6dea-08dd4ab3da60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cikV0ESg1thxwwBM2PuG/LJabMXQK4uaE+xKC7Rj1Hf3lC1bvNaIWacu1mg?=
 =?us-ascii?Q?96OfBdj+bpvmt7IXSpGfcTPQqynipMvpyvoBE55MWdyhNGGYFLrJFVI2pYzD?=
 =?us-ascii?Q?STMkGNtDIN8G8vRDtTA1uCmIUrgcPo/tV/YqDWdcS7ff/lJSfzYOodhDN3tl?=
 =?us-ascii?Q?96BXNul1pMGHzs+8SUYK+zY9jgf2CS6CK509v3JKlKSCHWgoeYpkNEF0wdLD?=
 =?us-ascii?Q?lvbMRGWfibc8GzlnX+kiKyT50pXvQi67iuCAp4SJMBrxhIeIDC1MYhc13zRJ?=
 =?us-ascii?Q?QPRGSFwVZQLpFXg3aCgL36vl+QSaTcLVbBG6aYw06cqTIpdpdZ1mvXBchdEU?=
 =?us-ascii?Q?8VTjqvqLpsud9dmxNJqzz3jyzS7QCS2AXyk7JK9nxfRABY9xYZZL3SCLvEmF?=
 =?us-ascii?Q?2qGqC9KYTNZSsagd+qE6YRo9tkRjtU+OfjHCEta2QU6CnqGqz0DOSBGcdKCg?=
 =?us-ascii?Q?JEEX10gTh5xr4wONN2oet0w4zFyo1km8iFxx+/aKZeSCJnufU/MpC3F04K/8?=
 =?us-ascii?Q?tl/vTTB+UUwFr4e+xN4f2h4hcM4GhnpCgY8cOTEhL5BREYYno2hjYEr2/EEP?=
 =?us-ascii?Q?hexZonyNodCMu22F6uviB1ZKNEWENMbfU6hRDIqhO6Iyh4JjN6xrHxO16t9m?=
 =?us-ascii?Q?a6B0I4Q1lXBJCSjUnLSw1pxBJ7uk62Q/JjSaYt1K8CITAijm8GVMdFsbtgcz?=
 =?us-ascii?Q?nIhyMJV+wSNCoGDlUTjk8+oXPNG3v1Hatifd0yWdasGc4Nxrgqgv2+i89qTN?=
 =?us-ascii?Q?cEzAHzv34vxURkzrmgND/f8i1I5/YqjuBxayiffLD1DZJDoivwDvAYLVArRH?=
 =?us-ascii?Q?2olRMWYyHTb4GrUxhN/LKR9berMoTkntsNwc2Vgjn76PRGfKqiJ6Vt3X+fsQ?=
 =?us-ascii?Q?NNHYgzzWNJDKkeH4KHR8G3STNSqjDcYqGPwIb9nNMvLzLwfxm/9TzQRbnKnI?=
 =?us-ascii?Q?9DJsLLnNYlPYcAeReWOaIBadoZCWt+OhQNsYEs5W6WspSldfCZI0bugeK2GL?=
 =?us-ascii?Q?Lk5gk7tN1VSWNwRmfDLCHy6MhyJyLTZ9pseDlcfMDfXdTPazs1xkQw2OVl+M?=
 =?us-ascii?Q?aVAbfEKvIV4rtJWLbn86UAVMHsvwg1nWNi4wOjmKV1fXcAqAG7OGYklGCRc2?=
 =?us-ascii?Q?mepfgD8CLmEHXJPHSaS8OXJkjKSJOrEJttccI9tKF6DQpJwrmQQcHfKItLQ4?=
 =?us-ascii?Q?x64zoPljJFnBw/JwZOv7pA02W5BbaqnECpvVEfu6UIb4OhWh95HiO3Uj9sDr?=
 =?us-ascii?Q?KC91PAtkzIZWioeGrrcM3SoH9e+rL4IBcSAGdIGnenhuzXo7ySQiATRfh27W?=
 =?us-ascii?Q?zSAp/AwF/+Zsos1kFiPq1mMr0VVQjUolkueuQRsxbn1RUhM2gcePTShqXKpX?=
 =?us-ascii?Q?wZ1q3608dZdinLuuHp0/ctLQ9SEw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/u11h3MFfO6SEkn+ymER1L46KwkGuYSs8u2FPSsG+kS+7COhAg0qnsyfw/E?=
 =?us-ascii?Q?7PXlpGEoF7BSRgviM1kUbiz6+f2kh1oCZ9iSE/S+OySV8a1m4G+zFc1VefoC?=
 =?us-ascii?Q?KBKWIxGVJIgrEQWxwKu8+OmKLlwsCDu+vmXIrQQIuXGyXzxmUZAYHH1MRhjE?=
 =?us-ascii?Q?1Dv9lNPBMIopvrs/P66F2vXneE7RbyVwxyAjvrsIxfC+vIkr6ybXnchdk8eU?=
 =?us-ascii?Q?ZtXCQe9zzjuL+BNolyof2EfaXrTZYeYqYWBn2cDqbDTzuMp/hKZVZExImh5o?=
 =?us-ascii?Q?6vbM3RMYBZCpANrLmeEDjnthjSyrVBcd8KDZbFSLnc+J/hVF7NjJ188aYCfX?=
 =?us-ascii?Q?7pioAWPMjnNwglscQ/QBX0wG8I5oG2EJFwdA45hmuCLC+g2qlOxjZN/cxO8c?=
 =?us-ascii?Q?oLYlo58XvZ/UTAYW3tgrzRbtZwgfMU0N7ERfKuVaGVSbT3rWUznXL81jhw0q?=
 =?us-ascii?Q?KTTP6ZrdBdn2pCb4YxDEZzPJ7uYVh72s1+r31Wwa188pE7E9UCiaB6LSSWao?=
 =?us-ascii?Q?vDfGzCWP/UDgWuQBiWmbW7lynBi2kIH5rN4B4DCLERtAcUtkgZSYz+Ch8UMd?=
 =?us-ascii?Q?aVJ9Cphjr6yyTgfBt8Pv4TUF8o4esY1vMXYi4j7/85D12ylUfhY7Bs1lBvQP?=
 =?us-ascii?Q?NkZS1A960TqYieB3AM9lfJ+pavZOsxzbZT6/OyCTPqKgiADAtPp/UKYVDh0Z?=
 =?us-ascii?Q?wWkI0JIteKnHCnBWXG4YfERIfxO+lcYBwkIRfNWX2w51h6v0TMsz4pGTf52v?=
 =?us-ascii?Q?zZwKYiaexiBj42/3z6rIrdZaSH6W1t3XaoXxj0l0S9fwuKZBmmGvJjdH45vK?=
 =?us-ascii?Q?u80WyEExOdmgBwt5cDn6knl4jpq1Tku2H2OdYgthw1ASryyCLh9JXAxDc+Ry?=
 =?us-ascii?Q?/UaPqde4jzANaUyAV6C7ZImi+0NKqhTCm3Hw8VwihPYQwF57Rg0640a/jmrp?=
 =?us-ascii?Q?DZWwO+AE6YDcMcBhTd3x8u1+mS2xf9FmlhA+jN0QVDjrblY3P31Uy5l+p745?=
 =?us-ascii?Q?isuysX+LWONBihZHY7PLGGI2g9Z/PtnFLa4hnYk5bGu2filf07YxDCvG11gs?=
 =?us-ascii?Q?clF3DV5sx3l2Mqx9Glt+HgkfnsgEFttH8e0G4SVfQ2mgDAFzQh5oH/6wEz6V?=
 =?us-ascii?Q?UHlSA/wCD25eQMvAF6wRlUSf57i25SpncXMDY/zvnUaBTD4WU8sUwybdRCrW?=
 =?us-ascii?Q?aLYcNstx4Ub4Mw2iqgWXFdN0l48wqqBQ+aDmUcCPHwxoDn4RVql/QJXoEyXT?=
 =?us-ascii?Q?xU2KuFUpewBhqRCw9mgz7YrsvwiBkr/RVWVd/QjZzi7Hm04Upy3+KWsiPVHi?=
 =?us-ascii?Q?ii/Twj0ix0mqNQ1VVfyjxWd1BTdVN7/3aD/0VN5XGgXUugQXUoEpKVVnrWtD?=
 =?us-ascii?Q?phg+enjZ/HpkEFreHotCHgN04ZLAjo5AkElyg98UvtZwagXUgl/ZKolvnNxU?=
 =?us-ascii?Q?yZ9UHJnMbjs3PEMDS0EbkPpgo29QqCAq5PlEzF7F+qRPj6BPFA4QYajF2NYV?=
 =?us-ascii?Q?nFYMegOgb9JEsgvYnDCgH+XzQe3P419aKZ2dMLRbL6LzbpMlyzVAI5l+LkKo?=
 =?us-ascii?Q?02EH0AS0FijHPkn+SjPTjfHXUsX03qUeGLdxolx9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4c2bd4-0e1f-47ca-6dea-08dd4ab3da60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:48.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gokYCZ4P1erZg5GlzxQnN9tRQXiuUgZd+HRMIr3wDtNq34BYJ/7euOu5ja8Q8g5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
since anon folio does not support order-1 yet.
-----------------------------------------------------------------
|   |   |   |   |     |   |       |                             |
|O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
|   |   |   |   |     |   |       |                             |
-----------------------------------------------------------------

O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
---------------------------------------------------------------
|     |   |   |     |   |       |                             |
| O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
|     |   |   |     |   |       |                             |
---------------------------------------------------------------

It generates fewer folios (i.e., 11 or 10) than existing page split
approach, which splits the order-9 to 512 order-0 folios. It also reduces
the number of new xa_node needed during a pagecache folio split from
8 to 1, potentially decreasing the folio split failure rate due to memory
constraints.

folio_split() and existing split_huge_page_to_list_to_order() share
the folio unmapping and remapping code in __folio_split() and the common
backend split code in __split_unmapped_folio() using
uniform_split variable to distinguish their operations.

uniform_split_supported() and non_uniform_split_supported() are added
to factor out check code and will be used outside __folio_split() in the
following commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 137 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 37 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 21ebe2dec5a4..400dfe8a6e60 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3853,12 +3853,68 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	/* order-1 is not supported for anonymous THP. */
+	if (folio_test_anon(folio) && new_order == 1) {
+		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
+		return false;
+	}
+
+	/*
+	 * No split if the file system does not support large folio.
+	 * Note that we might still have THPs in such mappings due to
+	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+	 * does not actually support large folios properly.
+	 */
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    !mapping_large_folio_support(folio->mapping)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split file folio to non-0 order");
+		return false;
+	}
+
+	/* Only swapping a whole PMD-mapped folio is supported */
+	if (folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/* See comments in non_uniform_split_supported() */
+static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio) && new_order == 1) {
+		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
+		return false;
+	}
+
+	if (new_order) {
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to non-0 order");
+			return false;
+		}
+		if (folio_test_swapcache(folio)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split swapcache folio to non-0 order");
+			return false;
+		}
+	}
+	return true;
+}
+
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *page, struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3873,29 +3929,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (is_anon) {
-		/* order-1 is not supported for anonymous THP. */
-		if (new_order == 1) {
-			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-			return -EINVAL;
-		}
-	} else if (new_order) {
-		/*
-		 * No split if the file system does not support large folio.
-		 * Note that we might still have THPs in such mappings due to
-		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
-		 * does not actually support large folios properly.
-		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split file folio to non-0 order");
-			return -EINVAL;
-		}
-	}
+	if (uniform_split && !uniform_split_supported(folio, new_order, true))
+		return -EINVAL;
 
-	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (!uniform_split &&
+	    !non_uniform_split_supported(folio, new_order, true))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3952,10 +3990,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			goto out;
 		}
 
-		xas_split_alloc(&xas, folio, folio_order(folio), gfp);
-		if (xas_error(&xas)) {
-			ret = xas_error(&xas);
-			goto out;
+		if (uniform_split) {
+			xas_set_order(&xas, folio->index, new_order);
+			xas_split_alloc(&xas, folio, folio_order(folio), gfp);
+			if (xas_error(&xas)) {
+				ret = xas_error(&xas);
+				goto out;
+			}
 		}
 
 		anon_vma = NULL;
@@ -4020,7 +4061,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -4034,12 +4074,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		if (is_anon) {
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
-		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(page_folio(page), new_order,
+				page, list, end, &xas, mapping, uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -4117,7 +4153,34 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at @page to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @page: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ *
+ * It has the same prerequisites and returns as
+ * split_huge_page_to_list_to_order().
+ *
+ * Split a folio at offset_in_new_order to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * split an order-9 folio at its third order-3 subpages to an order-3 folio.
+ * There are 2^6=64 order-3 subpages in an order-9 folio and the result will be
+ * a set of folios with different order and the new folio is in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
+{
+	return __folio_split(folio, new_order, page, list, false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.47.2


