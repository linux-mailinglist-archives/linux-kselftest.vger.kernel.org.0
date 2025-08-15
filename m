Return-Path: <linux-kselftest+bounces-39034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA8B2763F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB6D3BAE3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729D129B21D;
	Fri, 15 Aug 2025 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWllmqc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1529ACD1;
	Fri, 15 Aug 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225587; cv=fail; b=YRHdKYRmk/ac+zAqH1KOXLhY1Tx5tDz84RHM4hEibjFxv7CHH6+2a+k6Jb5K3J1rjLYEHnpaGJ79YaNshPByIb1kc82tVaoLFYINjdCh4w4IdSh7OrRR7u1UQhIfh+qBcADLvTIhuv2/mYnDcYgWcvErbnIenAKQzLQsnzawtIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225587; c=relaxed/simple;
	bh=6URjEHrpX75Njw8etNowJHXuJZew1wxM/Bt4aDfwjxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjEg8klAvqrl6x2/7KPNePq5KvOX8XKMZXZsisk2HhTy4y5m8QA+w7Zz1r6FKZWar7GGm9V00oxlDUdOAN3KYtO+Oh4QPLLRnP2hQ5YLzLKg2mBWz+D+HqmSM08XUnMxMHyMOQ6+LlbSDuaXXEwqvQzzXLbFn0ZC4emGv3PLPFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWllmqc7; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWSrmyMExqP78rimjf4P/I5ZNQno7xA0ZcvTQUX5ZDHw3yU/dS0win7uQNu/0jtcJ27T46o9eVF2b1xFu6ASIxikqeCanr3pAP/r9q1MuKrzhB6KcxjLD/6G/uEq87fSTxX6mWSI1dc1TjN8zGPbEIDYuNCzWusZ9nLV6W6jNF9iDolQZTwCQpFmaNLPaybLNbwPQUxO6couU5XWa9otY8hLCdi5929JQtJU44RjI3Oz2b6cBJRY7bp5QH7+qAJTnImdPZbfJl63+/swhnAk2MBs+YeAilyXoKivdh2JSpniLSiTg/GNbgzYxlytcw7g7cdpN4pQgQWiljCV14GDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oLoKALZi5FJ3e7+nSqCSuBGxctELFoiLzRV5Lx5d+s=;
 b=scVSVUkYx3t98XYZewX/hyh8/+/cFfnv4soHifY4r7vTLqsCMmsyKJMIPtmN2N/v+kI+3caFGVG2WdANh5FV6mW0fDIYXq4J/sq7SO1SkwV+UuZOaPHbDe7C49KUweVxqFerJGzd8YmVC76ka3+AejcdzAlId4gbiQmmRfx9qsqtfvYFw0Izs5ioFtD9z56t2CtzaDpthwb1cVPMJp5PQ1IoXS+poU/MsJmb9rtnbi1A6R1yuATxIyYYcNU1pE3K0dlKfFjJXxR1v4EMnBPiv/O5JUv7lfmuF6Jh8YfVEW4zA13sH2+Y5gBm3ngJuHcVdapshHBmFEt75XIexAhf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oLoKALZi5FJ3e7+nSqCSuBGxctELFoiLzRV5Lx5d+s=;
 b=VWllmqc7zCvie38Kn/gZ7pkz+dQAIb7r9wEWKQtMMg7Pj1EjJiH9y/zxBOp1NemMCqEJUx+7WUcg3W6FONku8J/sDuUjjB4iGLuuYc/6EtAd6c/qcLy+XGfh06x6grDeSMRRKuhtbzoG33J5OGRyeZwjzWwkMWI1tuEvWtPoi1j/TG/RhXz7RRibzxy06eZ1VdxFnFHLjfpLCPytJDX8lJXQyEKGRPEjiSHVUwvOUv/J23gUoUqYBMm7vD+gBY9xEez7GAxNxqXxjd/kQDPqbdlIkYc5EHcwV71YSpKD35Yraj9BDnTofwf/d/O/3HB9gFM8oNYOoDkB20nKNRLAgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:39:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:39:38 +0000
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
Subject: [PATCH v4 2/5] selftests/mm: mark all functions static in split_huge_page_test.c
Date: Thu, 14 Aug 2025 22:39:11 -0400
Message-ID: <20250815023915.1394655-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815023915.1394655-1-ziy@nvidia.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: c19b5d4d-ca31-4c1d-9292-08dddba4fadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5Cmg9eUh4hlXTwQTB9r6Bkn5qSz+N5orKlHRQduXoPffJdcfA1Q+rS+bOoz?=
 =?us-ascii?Q?zGFKNHbcUrwh7CZ1EYHSnHD3bcOH3ZAWxFtSDnaZHH7ZZj3nuTiQseftkwl0?=
 =?us-ascii?Q?rl4snZDCj8v6Vu85B/Jv+z7bkVQLv0afXPWCcx34yaj4UkmKSSFrIOAq3Ptv?=
 =?us-ascii?Q?G+vb+6ImZzS3u9p9rovDycat6wwSAAqF8ih1JO9poiUqV4Y/PdWRnR/IY/d9?=
 =?us-ascii?Q?T3mSllRBccszrtCFEjv/k6sDvdTL5z6DBFkvbQrYg84ZRSrvaBKJ8b3/GhfT?=
 =?us-ascii?Q?L+HzTZSahH2ALCX2NyHq7uMScmT2kIFD/G5yWO7gAo2WLq1oqMBAerFWtUty?=
 =?us-ascii?Q?QlDjZqq5epZEdsnRhfq8GfaaXYvIuMb0qH+/tHVvbbjYsbAQiOHh8grXZqdo?=
 =?us-ascii?Q?D6R/KLv5D6jSYQqkRDpix2kkAkzIx/ZVxTl+U8a3TVObrNo05C8mUL4asRMf?=
 =?us-ascii?Q?lHb7ZCWoiWppEcTNXTPlE1bU5ocdEnL2G+uMqRncf09GKKSxKdVfFQp6BRP8?=
 =?us-ascii?Q?EgcGQS1ZprARuAlBVPNky2pxUf6SNyPE7vOMFz68JHQ7/uodcqbnW8/DfhL/?=
 =?us-ascii?Q?0gS0OjLMCZSsqC8Rgf0YSC3MeCGUIJEBvvxWt11gWYZTIUqFecDgxLDR2XfW?=
 =?us-ascii?Q?i3HuBV19PeppwQj1LG3T95+PSpZaLfivXRF9jKLDVWyF06EjlyzWRUfFbqMj?=
 =?us-ascii?Q?qfRK1Yf5ym/rNcTh1i9K74sWAaCINZ0lQPwpFL/eRLnhvMsesY0lR499wtow?=
 =?us-ascii?Q?7Flov/IS8FZ4+cRAkbb9v7mXeOq13LFMuWm0nMbM0VVkZrRyxK3D6rPIX5a/?=
 =?us-ascii?Q?Gp5o7EAm91509fH84evYSx3tizAginMJ9zsfq+dfCfaKjU3vxHPyrPssiC7H?=
 =?us-ascii?Q?CTIgqMJS6wgLeYuu4b0d542lKBpqIDWVtVtnsE0As2GwPQZbqOATzpYy5Epy?=
 =?us-ascii?Q?wtHrD+xc0fvfwKdUKLf2elXy/H/MbKCsTBMMS0MOm8jKzb470hKu4j4s/gYe?=
 =?us-ascii?Q?LPL8NgWN9ybN9oP90ny6PHERO9QBeuB4nFdqa7Wtx50u+3P1z5GdAFRzh1pv?=
 =?us-ascii?Q?BjIa1vVjbrE1xDVyFWRYKIws2VTb+f09DU2fmjrHF3scIt78Yy4mEMUJjqLK?=
 =?us-ascii?Q?y7yZMTcmHTuoo0c4XaUrJ/bmGWNggujfrahP5RnN7QKtAMile8NhKOoFzjRV?=
 =?us-ascii?Q?kGQ8NQpqdZbHGBcYk0l1qUWD83S5FI7hENRHMxrh1I6z9Hf7WEdsUb6jvnqC?=
 =?us-ascii?Q?0zFgCnJEXlGIPJl81fRwHGDWphEhKga6pqQwvs774NFhDjiE9HLvrAp4U2vk?=
 =?us-ascii?Q?V2Dor1XWxPn1PxcyDmhp+KXtLYrPeo4STJkaj3MC9alpc2uzD4BUSSvPeF+y?=
 =?us-ascii?Q?6Lo+/mui6EUQQGf0DCoYW1eW7wdsLcnRjNrnYTo2zbW5ulJjWUop31Yd5A2Z?=
 =?us-ascii?Q?4ROpno600k0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDJDaz/Xa5SAJnWryORMSWbFQrbvH5uCQ+MvXe/e3f5KrNgJPe/G/Vxvl713?=
 =?us-ascii?Q?C3OxJ1u8+WbuUoIIgLA5ZXfTCmWHFjCjruXhkSuAZBokdzOz2+Ae9uLENTLt?=
 =?us-ascii?Q?eHO49ahHOmhMO/rZCUKewmM0DycCEBcIwoc9z0OAinrlu1/NG0ipOiqYDNqm?=
 =?us-ascii?Q?R+57vN6YhqCgbyAORDi/YgCiBc20YRSRkkKuuddDgIGZxTKXTLGhPXYE/rt0?=
 =?us-ascii?Q?rZFCvFqGFj3HV18C0gS1PoVX/ch3FudM+VCBvxxjR1rJy3g47vVU+53ReKNf?=
 =?us-ascii?Q?EX0wNqHmRWTUK4zznJe56Ab4x0jBsUWuwqs6ntQJcHLU0/ZyNqsuayPDIMSj?=
 =?us-ascii?Q?NClLA4UTEZhKHqQwPGN27hmlt8aRAurdYPYakMrDlxwLOa37DM1Jpn+I25jU?=
 =?us-ascii?Q?X6r915pggDaztEWgARP3bL1QfSrlgbu6pNIDqES0hBkA7msWSp2eB7jS4UCP?=
 =?us-ascii?Q?waz5WKM3f2EiEBHw9zYKQ69l9ms7n7aAwPlWDMY85bs1XFo568cSw0eXLT8R?=
 =?us-ascii?Q?7u/waACZPr66hrjg+WqqkAXb6l4vHZ9uMImnj3re4c5f73wCY1W3eG+jSffs?=
 =?us-ascii?Q?M3OsSxY5QiGait5LCHt0i1Usd4h2zm6FG+rccj9byAjefpXb45cWs++jeOUk?=
 =?us-ascii?Q?lICPTUqrVXBATygHlCbDYWCHfqwaagbcSfC8U/ytWrqYdjePYyGp1qpMpE9b?=
 =?us-ascii?Q?rZJczFXFk2uDwHZTQDQbmfPyqJr3susQY4XNyYsB5L1+pZvg7OtSj+qqfhV2?=
 =?us-ascii?Q?68Pu9My5wx8f3wD7dld065+EI26LZoqKtaliR+r1vYqd9HQtNxWzZxZqLegU?=
 =?us-ascii?Q?ysnzjqKLR4g/voHNVpB6KDv4sPlIL4+ikCCZZ6Zzbr+QdggKd2hLh/FuIok0?=
 =?us-ascii?Q?VNXxQJxlzKEeQGsKTawNOXJ05muWikBGAygQ44lqwY0SUA0NPQNZqQ5ZyGeV?=
 =?us-ascii?Q?Y/lKdWknZMt/DAsUHnx1uvtTjwBg6TjFzriStNpnrpYcIlSo2DDG9HjmzgMH?=
 =?us-ascii?Q?3As2FwdF24bchA2qRecdcAi1LocWNneHeXzOSsxdRJU5dY779Bd8NY3tU36b?=
 =?us-ascii?Q?1OFtNZ2lzl/YbrEGhnMcCFgw+5uPaAa96zhTfk8uC2+YX8cec00nFr/vrooZ?=
 =?us-ascii?Q?uUsleGwla8WDk4ZrH/DOiocODhYe/0iapqpRlpG/ofwS7jRy9NLT6y/5fA9b?=
 =?us-ascii?Q?iMkdtBi1/uBSk8d9dXhqAzNOI5u38Aaz7oKmf8gwLhXg5f5F8JJLt3uOC2FN?=
 =?us-ascii?Q?lDzmK4mm7hnIdpUZI/wE5G9NHxmNyl+5XI2LQj/Fu+hMXMBN+u+mCXy+sSdy?=
 =?us-ascii?Q?FrAi78OmpqcMQTVB0ydF32UPNRFo+JEkXZWxYqXtUw3ch6Q9jSo/l/v4VQA5?=
 =?us-ascii?Q?VRFNOJk+a5z7rKFxzPhM0uVy+dWdZLsKZ+CHYqgF75EfAPJuCH5W670LPYyL?=
 =?us-ascii?Q?VgCaoLbS5Wm9RVw0xQRo0HtZcOR6Ik65rMyyhSYImdbvk86LZaHC2XbB+shi?=
 =?us-ascii?Q?NHjqV+N2v/l8QsX+TD4gI2sMozeVUJmyEUVi8bkLQJk7UBKiJT8o9bp/f5v3?=
 =?us-ascii?Q?1ZFcvVVIvaVRSRa+cr8hCgzIzTTe2Ay5iy1tMmp8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19b5d4d-ca31-4c1d-9292-08dddba4fadb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:39:38.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zL1a0IGAN0dGwjuJTlyzxvswAK4keFI2CtbKAmOKdb7OIDEZFb7RmT+skCoD+aja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

All functions are only used within the file.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 5d07b0b89226..89d3dc08fe4c 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -38,7 +38,7 @@ uint64_t pmd_pagesize;
 #define KPF_THP      (1UL<<22)
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
-int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
+static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 {
 	uint64_t paddr;
 	uint64_t page_flags;
@@ -136,7 +136,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
 		       rss_anon_before, rss_anon_after);
 }
 
-void split_pmd_zero_pages(void)
+static void split_pmd_zero_pages(void)
 {
 	char *one_page;
 	int nr_hpages = 4;
@@ -148,7 +148,7 @@ void split_pmd_zero_pages(void)
 	free(one_page);
 }
 
-void split_pmd_thp_to_order(int order)
+static void split_pmd_thp_to_order(int order)
 {
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
@@ -182,7 +182,7 @@ void split_pmd_thp_to_order(int order)
 	free(one_page);
 }
 
-void split_pte_mapped_thp(void)
+static void split_pte_mapped_thp(void)
 {
 	char *one_page, *pte_mapped, *pte_mapped2;
 	size_t len = 4 * pmd_pagesize;
@@ -265,7 +265,7 @@ void split_pte_mapped_thp(void)
 	close(kpageflags_fd);
 }
 
-void split_file_backed_thp(int order)
+static void split_file_backed_thp(int order)
 {
 	int status;
 	int fd;
@@ -365,7 +365,7 @@ void split_file_backed_thp(int order)
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
-bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
+static bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
 		const char **thp_fs_loc)
 {
 	if (xfs_path) {
@@ -381,7 +381,7 @@ bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
 	return true;
 }
 
-void cleanup_thp_fs(const char *thp_fs_loc, bool created_tmp)
+static void cleanup_thp_fs(const char *thp_fs_loc, bool created_tmp)
 {
 	int status;
 
@@ -394,8 +394,8 @@ void cleanup_thp_fs(const char *thp_fs_loc, bool created_tmp)
 				   strerror(errno));
 }
 
-int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
-		char **addr)
+static int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size,
+		int *fd, char **addr)
 {
 	size_t i;
 	unsigned char buf[1024];
@@ -461,8 +461,8 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	return -1;
 }
 
-void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
-		int order, int offset)
+static void split_thp_in_pagecache_to_order_at(size_t fd_size,
+		const char *fs_loc, int order, int offset)
 {
 	int fd;
 	char *addr;
-- 
2.50.1


