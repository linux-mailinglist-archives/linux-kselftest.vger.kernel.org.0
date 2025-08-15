Return-Path: <linux-kselftest+bounces-39037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBBB27644
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622443AD244
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4B29C33E;
	Fri, 15 Aug 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MDMb6KtI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359C29BD86;
	Fri, 15 Aug 2025 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225595; cv=fail; b=PWcBr7ExeSBqhLFl46e03tRqdJ5fJL8LW9ioCIoD/htE21UwYkq/M6V8vjW9zLEJuUPEB1hGMyX6S+FOFWf9lhzK34VRs6iKdynNyB4f6T0GZdEu5LMOQgcqW0Mkh8tL4jPT5HnqYx6e2l+/9+8nyrl5lirNt6e3ujEQ8n/fwpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225595; c=relaxed/simple;
	bh=0Sm+na+81B2SZW2hgX9H8syVpey9eq0SjoSmrKAr+t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvJrjMUZHEjnayvu88uujFWGwOi98YetBigWHYT1+K56MoCTs4zZaVOs/GozMByg8goV7Lur3/ngA+B7q/DOJHp2WomuyPxHciR9a8yGP7fSZn6/vmdNUVibC25VY9vhCo1fQnP6zmcuNRPjA4+1R2kjHxOcCTcEn2nD1Ogayks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MDMb6KtI; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBtdxzw1keLHvynXhyGR72Ug5t+g7wPHjyGJtrqng/RkvE+mqsm1gh0wGiXD8KVa7w2G6PLuLhSqysp3pEs/xUTxAb1krBVC9XqiISEoiu0dZZeX3VQfI8C24lH0iIe3Hf+U8tNA4LJhzbkUvKElwS/Km3H/fPaqzO+v4CLUIBdPiTvClJM0wIikaMfDLor600s/gPt8LLdtOgUpi6UxAlC8+zb9Qf6ARyjw5W2YqTRJLc7c2iXk/kGU3xIROOQ9MtutKlHNwqNVr6xC/FeFSVFf4AWUcsxTwICqyt8CknGwdw1UatyBCFjiJToewBCdL0rf1lmAUczClMRnMkYb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am7ynLVrEdt31KTPTjLqB+fGbDrLrgXycJa3axcLh/Y=;
 b=Qh8u02fz7Sh8BqHT7qF1ecC/ErPTPSRLzVYCRWBKi3koK4xqODMFswESMV4O1i70WwD0VuLW2vfYKA+N4A6bMxYJR0yOmYtx6ROofsYLPYcpNoeqr6j66KePXC7QGHRBZ+8v24Vv7B6V8itAh/vYiTv0JRhhbbPvvRT+E8Eg70Z2rYKQzYGvG29MITipInICWk6Y2VEYLYgzsCtXtad+cN3/mRMNGXWvPzcmV1fQY0e3/F8mXg8FB3tl/gAcSBgjiSiWnREubDQ13DRK63eckots5no/or2miHgPJvjMf7f6Weka+nMu7IEmM3LHvwqvxQ7p1BwgvAoYBWWv0z2sEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am7ynLVrEdt31KTPTjLqB+fGbDrLrgXycJa3axcLh/Y=;
 b=MDMb6KtIf+61fHc5cnCHVnicOIs/h+q2NQBCyi815JCj6sO6SkMyZoRAsnw7TL46PBJknlhSDCPqDv8IUVDXy66j6KATWsKFwkO9Cs8Qrnyyk7gVYnOSa35axZm+QB4pG1XaTv/GIP7AEe2mHvMppsWZxJSwjUI8MnshqO8Ysyd/Rq8+jxQ53crDeAmpljwfjs7Zp/RvHwKErHu1iidhsluq61d/unAVgIdiD46eaiTc9cZuoSxUHOH57gtQgef7f/4rXufzh1TrdffHRqp3EUFLofDV6OsST/XXh7SrxOeOMnmF4og147RAqJR8CrGicdOAYcJPHQU+nP47jaCF0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:39:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:39:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>,
	wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 5/5] selftests/mm: check after-split folio orders in split_huge_page_test.
Date: Thu, 14 Aug 2025 22:39:14 -0400
Message-ID: <20250815023915.1394655-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815023915.1394655-1-ziy@nvidia.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:208:237::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: d126d399-9a89-4b1e-32fc-08dddba4fe34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxuuwqoG7uSKJNrh11hdBe00mwbecPlNQVmnab2ArPmlP/4/cLIeLOTRzKTx?=
 =?us-ascii?Q?oiXOlzSpGIYxzFwxImkyXK+WqYGnQjzE+QVz6BLHvtYM/L3kUHRKug7zb6AA?=
 =?us-ascii?Q?AloA1kM7UuPkmCuU5fyW88J2poLO5mzNEpo1eaGBeA1mWWXCoR5FbB/JuRf5?=
 =?us-ascii?Q?XS+M6gKZkk30Y3W8oIFBEkvYwPOMEXgl+QptFDfNWlag6EGvkO08W3tP9dZ2?=
 =?us-ascii?Q?upVpvTVlW6XbXldkdV+qfLvTNuZqu82zJE6e43yXwLHIiGxquf1Xx5VE67zK?=
 =?us-ascii?Q?U6pjgRoua9j5O8j5QA7ZxLAno4qDv0Ty2XC1zElpFROXhPTAUuwcqwmhS5su?=
 =?us-ascii?Q?xdQM0eBahik7Mwc6+uX76MPdtDV1EcuHhLZIJfSbuaVOsvC2AxgAWziIhmsm?=
 =?us-ascii?Q?ltu8WlI8RvlkCb3PmM4h3GLgDwmRsoG4PX2UaCCcWDsRVMjy92YV6liNPsdF?=
 =?us-ascii?Q?zcqc+D2s2cwxRn2IxohIPN86gKn77RJcXVHf5vuI4IUXDwpVJRwExagDk2z5?=
 =?us-ascii?Q?O9K9EKccOnbO819skrf1SXQ3Gsv2HtDrI6mN67fh8w/7dPKZm1VoOIIspBCu?=
 =?us-ascii?Q?YxC0+/74kGhX5TubgQGJC9JlFXUESI2+FPnN0xJH1Av2Oarr0dkBZzZagu2M?=
 =?us-ascii?Q?qbKfgLw3MC+/iZr27z6GJcOADkCP09GCNdZaJH+EQOsUXyXlXw9J6IXnXNTl?=
 =?us-ascii?Q?VQG+0EOVWcUctR/DSVbP/mU4SLnI+81LoOJlj8UCOa33ct9IdyW2cGpwclqH?=
 =?us-ascii?Q?2+rBi3dSCJdYljqv4sZTqRHaQL1jEf1w8u8nW78ocGrZMSLdOUYvyNmkREm+?=
 =?us-ascii?Q?QfhjJSUUIpu4sSLJ4fLLHxnJaIddK3LGlq7I9Ed74Wwr42CTtMXz1X92t66f?=
 =?us-ascii?Q?7cteIYyTNkYImnOK/TFFXMqK7YbObXH9QX0wv/+YfDHlNY1dVg6ar/xKShzZ?=
 =?us-ascii?Q?SCuxpmxc0asF+xm8RJfKT9BRLo/fDvEn8lCONsubUc0HABkkep0duphCD5+m?=
 =?us-ascii?Q?YOTGsaJ8FgDApXcDYe58CKBmnMzl7yfOCsag37sTQQi3nBy5X3T/QQ9enEwf?=
 =?us-ascii?Q?K+5411aho1dihBVwEZzoZcpT/0btMZVDXoD9VVk5bcQMd0GMJcA/5Ebnu0AH?=
 =?us-ascii?Q?iCqhWgfnPB/jXAn1Q0cWD82toYOgLm1X1Cba6s7lfEfUf7/Z6NL8N/5VnyNP?=
 =?us-ascii?Q?mLMtUh2Lilk7dlPP7fEcg11e6l0sa1bMkoUnhhsntjzabRo38T5PuqaM8pVT?=
 =?us-ascii?Q?bMz5Se9uPJyZW9prLoz/f0xXsaUFpFpLkzEjmy4P+jnaP7+S2BCNHSm+PUH7?=
 =?us-ascii?Q?T+tyTQL5mEAb8i2idpAm7z3tzOG/vHeZeGhPeExsjHwS33K/EfBxSSDB+zCw?=
 =?us-ascii?Q?VH2aV48sfQ/KaHCOj6gVqm3G7L3SX+PJmq+UyZzZFYqHOdDkpkBwKNFi/iCn?=
 =?us-ascii?Q?kkjpu9x9wE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwjB5N85P19GBQI6QfswVBkP77rdwKF7XohDJZ3Uo8Myrpfa8HIsgeLhrvgn?=
 =?us-ascii?Q?ERVTJE6TY5bNZL3YUwgKUECRF8QqiG/Ow9Jo+ucBj310xq8wPqcd2VgQAWnD?=
 =?us-ascii?Q?geGmJa/+AHny2OWSj7AVcZ9H/qQKVXX4QtA/+firJuEHmw7PewpoFLWoV/lK?=
 =?us-ascii?Q?aIsrYeLhM3SjU1o6bQgp+B30wT5eEfnWHq+Rd2xIEWBVKbBk/q/1D6uFD2cs?=
 =?us-ascii?Q?8oMXBVf10+muYYzb/mR4jCQs8MOkGma1JkQe10ccIlut6nsDGhurv49lkbC3?=
 =?us-ascii?Q?9vbC0W85r8Sa/3tn5DQm21NBFYcZFdEyLDWa3WddmVPTXGOUUo85xU11e/zk?=
 =?us-ascii?Q?TC3XvNX0yABgHSZjmortYV2TkIt720UMT8op50wwZU7YF/vL50A2UIp5VP2b?=
 =?us-ascii?Q?YGZjIWlVHF4XwAMMQk8l/8p4CdLeEc5jIm2LcrXGjlJCkPKaI1DTjwrjEbYS?=
 =?us-ascii?Q?IgOnzXZWng60iVXGff7QHR6p9YMYK7whzxoDkUMGlIkUPrkKJwQuiypjFW0u?=
 =?us-ascii?Q?hmvawJotoAHwxwgYi/rOUXCgurSqrTr1LwasJnDTEVxTx+8Vj9K6m9LpCoM+?=
 =?us-ascii?Q?PqbuOO6ViKpMqODYP9vp2tY2DaP3jgSuyuLbptEJIpFR1Uosp+ApHlhDgMLw?=
 =?us-ascii?Q?JL6KKRIuUjyGWfoffGB1nnqDJQsX0LzRfJDshJqaKT9PiyjWU735F2lHZLDy?=
 =?us-ascii?Q?lThpBXbZlBM45Bx3ku1Kjjc4znx/Wz9sziRFRTNwIzVR3Vxe2I5G5XK4K4Ay?=
 =?us-ascii?Q?n7CMboNtgfbU1f6Q3qRdaU/ec7vE9pg4BJ3jnoM55GWIeWX0HSDGOhats50F?=
 =?us-ascii?Q?apn5wSJWJte4cW9qDKQFkKw4OWXZQOOP+qd1fAeUkDqgWsgDBj6aKTDF9wn2?=
 =?us-ascii?Q?ygMS+G3gke20h/Lfo91SDtNbOrrvNZFnyW3sHAahkDhIyaRtNRT4R/EPMRxO?=
 =?us-ascii?Q?cXeXgogbEsq5BK++fIa6lTOmj4WhgtAIB8F7VZ4wLqWrhwFBrxHVTC1J/V5U?=
 =?us-ascii?Q?R55JHToPzLV8865+21npAujeZWQEPfd0XnmRhCu1rQNkjZ/V7O9VFvXPc0by?=
 =?us-ascii?Q?Ih/cBH6Piz3voFujC5jXFBQLeCuw+brKE2V0zOmesuUx42flOiJvvr0fgm05?=
 =?us-ascii?Q?fm91Q5fhSUD6AwOLfDxLrGCVmRSfoeCg0Us6l8ts7HXyRF73PpjeQIIh7jsg?=
 =?us-ascii?Q?5oIFVYuGjNNPIcLwJ1duTaiqSozV8xfpKKLAQ8vRVU47g/NLa40m33Ne9Yuz?=
 =?us-ascii?Q?P/sCJ18D8krqy1SgdfZfGvXx98QoPrXOx9DtajPqvaBoBo83C5P4h5uG6/tI?=
 =?us-ascii?Q?i207tMPHkFEblV6rWDrHp7qmNiiQiNbHigMwyDMJKHenvYNFexvRHBsLxoAB?=
 =?us-ascii?Q?PEYYKELkmIy6oPcyKucFhdl4KBFd0GdonXxKgoI6f5OTlLZp8jGi2FKDLFGB?=
 =?us-ascii?Q?UVYrr5BTI3XJPmbiF2kwUCHldjdoyNzNd87Ey5JMje5LkE0t4OGwRl+oRBtr?=
 =?us-ascii?Q?UVRgagTqu3Kun/d6speF8IXTi2xI/xs61/0IKBCZlG7T4dpicD3Jl5GtNxkD?=
 =?us-ascii?Q?5a3MveURLAeX45vY9C5QmeHuWUafSJJGEBhaAbt9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d126d399-9a89-4b1e-32fc-08dddba4fe34
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:39:44.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTeDb91uYlwh7y8Pu1OnphOAwyuPK4zfjY156m0VWn6VrZjtPvv+a3tnWn+B3IWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

Instead of just checking the existence of PMD folios before and after folio
split tests, use check_folio_orders() to check after-split folio orders.

The split ranges in split_thp_in_pagecache_to_order_at() are changed to
[addr, addr + pagesize) for every pmd_pagesize. It prevents folios within
the range being split multiple times due to debugfs split function always
perform splits with a pagesize step for a given range.

The following tests are not changed:
1. split_pte_mapped_thp: the test already uses kpageflags to check;
2. split_file_backed_thp: no vaddr available.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 91 ++++++++++++++-----
 1 file changed, 66 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index d2467072e752..7d898c380236 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -26,6 +26,7 @@ uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
 unsigned int pmd_order;
+int *expected_orders;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -37,6 +38,11 @@ unsigned int pmd_order;
 
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
+const char *pagemap_proc = "/proc/self/pagemap";
+const char *kpageflags_proc = "/proc/kpageflags";
+int pagemap_fd;
+int kpageflags_fd;
+
 static int is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		int kpageflags_fd)
 {
@@ -135,7 +141,8 @@ static int get_page_flags(char *vaddr, int pagemap_fd, int kpageflags_fd,
  * be recorded. Non-present vaddr is skipped.
  *
  * NOTE: the function is used to check folio orders after a split is performed,
- * so it assumes [vaddr_start, len) fully maps to folios within that range.
+ * so it assumes [vaddr_start, len) fully maps to after-split folios within that
+ * range.
  *
  * Return: 0 - no error, -1 - unhandled cases
  */
@@ -369,6 +376,13 @@ static void split_pmd_thp_to_order(int order)
 		if (one_page[i] != (char)i)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	expected_orders[order] = 4 << (pmd_order - order);
+
+	if (check_after_split_folio_orders(one_page, len, pagemap_fd,
+					   kpageflags_fd, expected_orders,
+					   (pmd_order + 1)))
+		ksft_exit_fail_msg("Unexpected THP split\n");
 
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
@@ -383,22 +397,6 @@ static void split_pte_mapped_thp(void)
 	size_t len = 4 * pmd_pagesize;
 	uint64_t thp_size;
 	size_t i;
-	const char *pagemap_template = "/proc/%d/pagemap";
-	const char *kpageflags_proc = "/proc/kpageflags";
-	char pagemap_proc[255];
-	int pagemap_fd;
-	int kpageflags_fd;
-
-	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
-		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
-
-	pagemap_fd = open(pagemap_proc, O_RDONLY);
-	if (pagemap_fd == -1)
-		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
-
-	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
-	if (kpageflags_fd == -1)
-		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
 
 	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -456,8 +454,6 @@ static void split_pte_mapped_thp(void)
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 	munmap(one_page, len);
-	close(pagemap_fd);
-	close(kpageflags_fd);
 }
 
 static void split_file_backed_thp(int order)
@@ -660,6 +656,7 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 		const char *fs_loc, int order, int offset)
 {
 	int fd;
+	char *split_addr;
 	char *addr;
 	size_t i;
 	char testfile[INPUT_MAX];
@@ -673,14 +670,33 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 	err = create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
 	if (err)
 		return;
+
 	err = 0;
 
-	if (offset == -1)
-		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
-			      (uint64_t)addr + fd_size, order);
-	else
-		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
-			      (uint64_t)addr + fd_size, order, offset);
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	/*
+	 * use [split_addr, split_addr + pagesize) range to split THPs, since
+	 * the debugfs function always split a range with pagesize step and
+	 * providing a full [addr, addr + fd_size) range can trigger multiple
+	 * splits, complicating after-split result checking.
+	 */
+	if (offset == -1) {
+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
+			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
+				      (uint64_t)split_addr + pagesize, order);
+
+		expected_orders[order] = fd_size / (pagesize << order);
+	} else {
+		int times = fd_size / pmd_pagesize;
+
+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
+			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
+				      (uint64_t)split_addr + pagesize, order, offset);
+
+		for (i = order + 1; i < pmd_order; i++)
+			expected_orders[i] = times;
+		expected_orders[order] = 2 * times;
+	}
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -689,6 +705,14 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 			goto out;
 		}
 
+	if (check_after_split_folio_orders(addr, fd_size, pagemap_fd,
+					   kpageflags_fd, expected_orders,
+					   (pmd_order + 1))) {
+		ksft_print_msg("Unexpected THP split\n");
+		err = 1;
+		goto out;
+	}
+
 	if (!check_huge_file(addr, 0, pmd_pagesize)) {
 		ksft_print_msg("Still FilePmdMapped not split\n");
 		err = EXIT_FAILURE;
@@ -740,9 +764,22 @@ int main(int argc, char **argv)
 
 	nr_pages = pmd_pagesize / pagesize;
 	pmd_order = GET_ORDER(nr_pages);
+
+	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
+	if (!expected_orders)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+
 	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
+	pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (pagemap_fd == -1)
+		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
+
+	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
+	if (kpageflags_fd == -1)
+		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
+
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
@@ -767,6 +804,10 @@ int main(int argc, char **argv)
 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
+	close(pagemap_fd);
+	close(kpageflags_fd);
+	free(expected_orders);
+
 	ksft_finished();
 
 	return 0;
-- 
2.50.1


