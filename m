Return-Path: <linux-kselftest+bounces-24676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD3A143C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE583A9D86
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2019DF7A;
	Thu, 16 Jan 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXQNZUxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177318B464;
	Thu, 16 Jan 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061857; cv=fail; b=nIwUf1NoWzZxZny4mfgODbkiVNYbnllS8bI6tDacgJpzaznUxrWM5Z3Um8K01WpdWLl19MXZfSF4u+FIoaP/5p/jOke7dRHRENrDVEee/MIXlMWv34g42crnmahdy8MS7DoCMjXzszs0vrd3D+5KYdM5zXealZf3IYqePjiR86c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061857; c=relaxed/simple;
	bh=HLOkAufVD2l0xstaGCY6dXPP0hLlP3SQvAQDDqadXAA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ChACWIuO+9aiAybOpnlJRdzd2OyuoetkIKFbb6j7Zehdiu5p9kRATvO2fQPnLCW59kPADGxjgVGt9YiTpqHJmK5k3PhlCZcSCr+ElUo4kC3/XKJr1shrU/gLvIDXcs/UflQUBO/D6UAQHwMx7SloQEu3IfUgeWNHwhZXYE+fp7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXQNZUxt; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skZOUanV6MdQxn6du4wtz1c0kaYshJUb1vT75dR+cPs5wHqsdBKXBqVgNNcn61Tq9P+RoeMQjWHFeHyHOTCOw9kqms5Q82O3ANOgmuIoQyGHkQPF5yxrirHKo9pVOhylVvCoxIcmdGGQFd3RrK0ZgC7M9h/Sw4xWkvHB/nBshZV6XnZb24OVMdGj+5b4Sw5mTEM4X4KYVR174dks6xRDdCJ6WmaJXNFhQ/IejSFkREfQa07jk1XvCXB8wwrzDoJWGxjHGzgnNJbOXQtGEIVpTqNdr+bksZULT01XSVPi4Dnt1F8Sv1qvinpZHbpddbhjXoEAjPIhATOsAKw6Ohs4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uhzqMghoc5R1XB+0uXCcsl5EyA4N2LjOSfQULX6w9U=;
 b=BVv/Ks4kqtmYPknwThK581p2+nYTU5OtB1sGReZAewklwIHBvUZwQ3r3zHuAfs8wrGJh0gOPTdZaWmhOZsJgvEVi/AwDL36aj5fHbNhfIoD+8p70Qf8SMo5FNaveDI7HK03Ltaf2D+TQjhM3FhFLasNMa1DEw1qN+NEgm2/HwltYZJWOeJy/qA/0pq1piM0QuBF4YyMVPPCCOIYuE+0Q10ixGD44XdeNpfA18DK3ker1VCql3D6Tdp68BrFnHaLbIX+K0Br/pB0+idB1joo5YvV0EMNbRcSavFjCQh64/tyFByVqfGZZt7IGhsBMMv1dOsy7jb4Yiz1QRprQuOqbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uhzqMghoc5R1XB+0uXCcsl5EyA4N2LjOSfQULX6w9U=;
 b=rXQNZUxt2Qwd3hcjgwpdzfX2TagA/pvYv6/AP128fPpMsGwjMZQzGfrr+RMeN3BY+wUj1JTkXNLoyEOyOvdFB0RJL5CauonkY0OeIrxDFi94tpJhSM0Da9grJZJEj62RR7pLVnYne6syVwSPrlwQyEtxfnf5I0rscdaodQnvLdSAdmt3oDpMxcU9N/ubNwvl067KnHWmP6p6Myh+gXpBt857Z03tCZfVpikdt5fv//b1Kn/LF/SI87zhuBqo9ssdvnFlr/NJtWPoXf3MoF7Ju7Kin0iuX4N2LqMPPcfAD8KmOHNJs0SliyhM4s2WDBiZh6vuBg2KpXFOV+6BqagUIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:10:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:10:51 +0000
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
Subject: [PATCH v5 00/10] Buddy allocator like folio split
Date: Thu, 16 Jan 2025 16:10:32 -0500
Message-ID: <20250116211042.741543-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:52c::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: ae60cfa4-c3cd-4a5b-9bbc-08dd367241fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7/vNRBIrGJj4pTkP7HI0TiChuH5DIWB0QyraApWH/KEl0lw1rcXl7Ie/96N?=
 =?us-ascii?Q?1cEGpAUczjDMpZ3LRVkOk1JzmQMDOXOJruD4UWKuVVwLu8likr7UsO3xA6yi?=
 =?us-ascii?Q?a8tsjCMQ2EHsypHJUu38yHEX4P/2qjm/7E9/DVY71n+ZWj9TV1YP36LzqEVe?=
 =?us-ascii?Q?Uks60GfADrmfSMwxX/IkDFKUUdskuwrjZUQqt2MbBcjRtwj6Y7323UexTvfB?=
 =?us-ascii?Q?wZrv0zKA99QyIo+Ihy505uX1dcsIZ2xGBqDj/yhhhE+wqayv/kcmMyqLnymV?=
 =?us-ascii?Q?yH+Et3b30J7NjrJ+TkWoUD7oBTlHBjd/njpRs9z0sJqFs4rlvSYsF5W9OmR3?=
 =?us-ascii?Q?DhhKB8n8ZshkYSifw2LVEwB/JxyuKOXMogGhCaZ/WUvDr/5e6KoSEjWaPwNz?=
 =?us-ascii?Q?wrRrs5yjH4SsE51qme172zxxfnO5U+WnaEfn+6A3Q551ozlXk3Pxn1D/eXQY?=
 =?us-ascii?Q?qf3QL481jYXaHHjsI2p6ORZkwB82RLkpRMXcMnuGjuIyxwgnTzw+1oAhaYDr?=
 =?us-ascii?Q?HZxvsuQILSjBsxk/FmxqANXDtOktgaAXa4jQ8P4KUuubBV+R01qZHEq852mC?=
 =?us-ascii?Q?5cehGsnBTEuFlM2bE93rRJTv2y8slWlpP9yQB31sZunP6e/TejYoRylo92q5?=
 =?us-ascii?Q?ObAnpKBR8prsq3HtE3IyNYFSfZG5iUnvQn09yMcm1UXBp3EZsiDqTX5kIHrK?=
 =?us-ascii?Q?iZVQoBSPxVzai6OENPw/WYnJDBZSl239//o3yHgx/qvP18bRIUSSJjUVCvXk?=
 =?us-ascii?Q?i2xt+G9/w5ksrnjSadiMPS0Dp3Q65CtqwYBpkOzv63xSLrERUZMhTHc6388M?=
 =?us-ascii?Q?4GT3H85a9gwrPFUakMtdgLjvGWFdP34TkrIyySPtjiNVd0Qst3j2qyBE9vz8?=
 =?us-ascii?Q?O4D9BDNMd5fIl04OlN/jKnyPNsQPKwHbJDtvEh4bsVdT2BSvRvm1abC6FmZ5?=
 =?us-ascii?Q?UBGtkEMKPCBD3WmYrlgIDpRBKsscQUK+FCwAHfc/UQGxmXRBE8n/LH6XQdui?=
 =?us-ascii?Q?hvbQyHC07iMgIu1KbZ2KdG7ujo9Mb7/0w7OtJN9CJDOnfIjY4J8BDcxl8hIk?=
 =?us-ascii?Q?Nls/A+DVp6WjZFc4h8wew5LchlNDaicoqboPZVts5yIw0xxZ+TKGkWPuiQkd?=
 =?us-ascii?Q?sPcDJjDs0xlPhF/AX22/R2qS/ATKU5zA1WaE4CpjQkIXNHh+U53TtdGxF71x?=
 =?us-ascii?Q?gINADYqX038Fp9yvi3xxXykX8xYihbqvX5xBWRuX2fdwSIDUICsHizo8I+Rk?=
 =?us-ascii?Q?o0rBBK2U7Pz70b+cXY0TO3S5bk9nQYrquxnPZiRtG0tuStVyOBXguWLEfVMC?=
 =?us-ascii?Q?E6IPVOj4izkvCDw3y7afufFMKEoegwzOZJ+RB5dD4a51QTabfnOZ9A66XAgJ?=
 =?us-ascii?Q?J9RZMo2PaR9lv4O80WAMbSn/zKWQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RQ9d2S5mRxHElH3zm9UafKvVd2ggL4k1o90EQSyyqHoABz1bY1sE75hlUx4?=
 =?us-ascii?Q?i98iSrx2yuKaLxQl0Pgj+jsYsCDSvhcf50c+syQl/KCb00DpDVTGuJwFe59/?=
 =?us-ascii?Q?4a+mWPRkbpbms9P7png7giGdAIOoEpDf5fzNJAa6MYUjLDSMVii0tUV0W6LL?=
 =?us-ascii?Q?DYWUkSg/Wsx4j9jgcdePPdoaiI7iJMLJ5SaR7DnrnCfzcWHVx4za/5GUr4aN?=
 =?us-ascii?Q?C9zUgiDcTyHyNXou6vmUXCGq/WKfFu+k3/zCFV2RXljfkcpG36mGOp2YPeTm?=
 =?us-ascii?Q?yfz1xXk/69Fp4r2Zgwk8GfS3oMVOTGrIEwxP3hY9BMeL6ZkSDHwCXbJ+15Bj?=
 =?us-ascii?Q?s1gCnkQWBn2SlX1PcOfNHjAQQGfGTfmqxfP4E1MP/iKVGRP5Rp5ADEy1BgUV?=
 =?us-ascii?Q?3As+B9ZABkZR+xlDXXco7Qt+/d1aqvLeQ3BnOtSs0LOAq7UVX2oyuCSmJgiX?=
 =?us-ascii?Q?ntxzfq6FwUTjgjt/XkxHtFhSL+LUZBmvSgrHLOkhCd9msx0GYNXbV5bpLGv6?=
 =?us-ascii?Q?8PROlxQEnWd8cZVOK6Y9X03A4Hdh7SVVuGpfyM7mulre2SoCw4GYaonIw6OO?=
 =?us-ascii?Q?KCvftAnJ14Mgo/a7MTK1rnSsv2DkUz6GtjjKIQdCL9nS/fimqE9+R32no+be?=
 =?us-ascii?Q?/L1YpGfKeC2+J4AGttlunqssO+XY1VIzmemo1MyLP/vjsYC1nxPuGOP8RNOg?=
 =?us-ascii?Q?62/NsWrlxvmSs4wx3nsmLyftfT1pAWQDtYbxGdIwVt+NgGrloEpx6NdFRzVR?=
 =?us-ascii?Q?50Ft0v+llmg2Y6W159MQfWdz/Q4gc0qr4N8IHY4dhEzWWIpEapsM55AZ4nPY?=
 =?us-ascii?Q?E1g1tMcH6MHS17Tq+ZxAIPPjVtdoOBTyFl0rMmypVzmWHWgJSMvSrd9QZM03?=
 =?us-ascii?Q?XRdE41E4s2lc4Gkqr/UQmXvDBy5c0RSGaWIxqDaUm/+gOsD1XcgBZRxMX0IV?=
 =?us-ascii?Q?4s9Yg7xuwRrfDPaX7ZQOg53v7R60r8vcuJBjs/R8NcWY1XLNbMXXDE7b3M+R?=
 =?us-ascii?Q?hY1HhY042J64U73LkxdFXxsfcJhQvt15veYbvbbEkRfFv7a4Qh+FIhOq2t6Z?=
 =?us-ascii?Q?iUfbCkZNYSYgSIKxlkYfwVxiKlC/882df3JBpv3YgT8LKJ9QaNqJufCQatg7?=
 =?us-ascii?Q?VvR9I/F/0nXemlZ/KrcXAjHZa9AcDyBe1C7bjxwUvwEbIdVjn7Q1y2S9wfGT?=
 =?us-ascii?Q?75UWT7CBmImhoPaj4bFuF41hyIo4iPRQa4EGFuEHzh3OFERK79//bOcFESoI?=
 =?us-ascii?Q?zUhj1jQKZ4toMl0kWThS3BRi0Z6ae7CJvtLfjElI8VPtxIxawMQgJcPW6NR0?=
 =?us-ascii?Q?r/6lDHK+6oFkfHduZiAxHkkP/YvIoSGn25kubhUra4ryaYFbvWcLtXBlt4Jg?=
 =?us-ascii?Q?NS0KyXFhADMTGN8D8lKagfCDzT8ELDaouzow8xDMg4ejjsoxQZBcg9gcQv92?=
 =?us-ascii?Q?c0uO55C9EFl+ZiqizAgW8F8V8JgOcm2KI6T6fkdfTUFcuOEFJjbK7iYe56h7?=
 =?us-ascii?Q?26edlOn9gkZ/SUYctmkplYWHNOOcfsiA2gkshBJhWMW8QczVKTFZ3DPrQpG3?=
 =?us-ascii?Q?laIg2wbV8KXuOpGiWddFLEos4vcfIZ+hsOsP2uhP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae60cfa4-c3cd-4a5b-9bbc-08dd367241fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:51.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq4um7nsNj4csh4n5jHI8CLQi7ps79wqnFgagYmd3cFq+IDYRNlixnKx/hqf5LEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Hi all

This patchset adds a new buddy allocator like large folio split to the total
number of resulting folios, the amount of memory needed for multi-index xarray
split, and keep more large folios after a split. It is on top of
mm-everything-2025-01-16-06-37. It is ready to be merged.

Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like split. All
existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

xfstests quick group passed for both tmpfs and xfs.


Changelog
===
From V4[6]:
1. Enabled shmem support in both uniform and buddy allocator like split
   and added selftests for it.
2. Added functions to check if uniform split and buddy allocator like
   split are supported for the given folio and order.
3. Made truncate fall back to uniform split if buddy allocator split is
   not supported (CONFIG_READ_ONLY_THP_FOR_FS and FS without large folio).
4. Added the missing folio_clear_has_hwpoisoned() to
   __split_unmapped_folio().


From V3[5]:
1. Used xas_split_alloc(GFP_NOWAIT) instead of xas_nomem(), since extra
   operations inside xas_split_alloc() are needed for correctness.
2. Enabled folio_split() for shmem and no issue was found with xfstests
   quick test group.
3. Split both ends of a truncate range in truncate_inode_partial_folio()
   to avoid wasting memory in shmem truncate (per David Hildenbrand).
4. Removed page_in_folio_offset() since page_folio() does the same
   thing.
5. Finished truncate related tests from xfstests quick test group on XFS and
   tmpfs without issues.
6. Disabled buddy allocator like split on CONFIG_READ_ONLY_THP_FOR_FS
   and FS without large folio. This check was missed in the prior
   versions.

From V2[3]:
1. Incorporated all the feedback from Kirill[4].
2. Used GFP_NOWAIT for xas_nomem().
3. Tested the code path when xas_nomem() fails.
4. Added selftests for folio_split().
5. Fixed no THP config build error.

From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__split_unmapped_folio() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__split_unmapped_folio() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like split: old_order - new_order calls to
   __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given via folio_split() parameters.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


Patch Overview
===
1. Patch 1 made file-backed THP split work in split_huge_page_test,
   patch 2 enabled shmem large folio split to any lower order, and
   patch 3 added tests for splitting file-backed THP to any lower order.
   They can be picked independent of this patchset.

2. Patch 4 added __split_unmapped_folio() and __split_folio_to_order() to
   prepare for moving to new backend split code.

3. Patch 5 moved common code in split_huge_page_to_list_to_order() to
   __folio_split().

4. Patch 6 added new folio_split() and made
   split_huge_page_to_list_to_order() share the new
   __split_unmapped_folio() with folio_split().

5. Patch 7 removed no longer used __split_huge_page() and
   __split_huge_page_tail().

6. Patch 8 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

7. Patch 9 used folio_split() for truncate operation.

8. Patch 10 added folio_split() tests.


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20241101150357.1752726-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2/
[5] https://lore.kernel.org/linux-mm/20241205001839.2582020-1-ziy@nvidia.com/
[6] https://lore.kernel.org/linux-mm/20250106165513.104899-1-ziy@nvidia.com/


Zi Yan (10):
  selftests/mm: make file-backed THP split work by setting force option
  mm/huge_memory: allow split shmem large folio to any lower order
  selftests/mm: test splitting file-backed THP to any lower order.
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use folio_split() for truncate operation.
  selftests/mm: add tests for folio_split(), buddy allocator like split.

 include/linux/huge_mm.h                       |  24 +
 mm/huge_memory.c                              | 755 ++++++++++++------
 mm/truncate.c                                 |  31 +-
 .../selftests/mm/split_huge_page_test.c       | 105 ++-
 4 files changed, 633 insertions(+), 282 deletions(-)

-- 
2.45.2


