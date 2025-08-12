Return-Path: <linux-kselftest+bounces-38789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B1B22CC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8411D188C921
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE22F746B;
	Tue, 12 Aug 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p7vt6KpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B82F7457;
	Tue, 12 Aug 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014145; cv=fail; b=es+A70YR/R3yeDBxcx591vn3we1mAJMMBimBNeQZc9UWtihvKopz7AnNo+vXnbFWyqfKRDOtKbIr4VRrY8HPdkSwEJNyzqOHacgDLzbdnMoEeqcjfwEDYK9mno8aBqWlHH4SYxYfp8BYF0H3bt3w+I8lqonWzH/y6iVtFXskp08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014145; c=relaxed/simple;
	bh=ct4bo06R7vGo0uxb+/b3CJ/9P3EYREcm/15Zcnm8flM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZSJJ5qCxcjfUTesMJUzYPT/l4s4lT7Zl3Qa4d+pDZ3uoYbrjHyZoDBebArqLJqbkeY9AWYdo8wsML+0HfTRAcUA5bdR2ogsu7TlEXpiFjmzjo736vDLr3abG+pBf/herPPprQAGhlVy+GbdpuNPH7kDtThtzkObpLMGjBmGyLO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p7vt6KpV; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqx1Ra0V0RogACDLEhNpGTqi6gY7ebW/j0FtzIgWePnHnMRExc1ZcQDQQJbhaNnWxe7OmyxNPsjHmm0OGQPKjNJHj/ef/u71i9w74ggwIxF18bpCB7djqOyIgNbroWtnqCOVn6mQVGqRSPrS+UyXfnDKnMnJtzyTm6r/1e4TOUGFO5BxpjKPSvSheIcemj4TfrrRSOtZ2W2+GHuqaebjeOpIbiS5jkZMX+JtStM9NR32NiOYAl2koOBkgj3zeEShV3s1g+hj2F8W4YHP9h7RgJ0044qKK/zxZb74w/doC+heW4c9AYT068WefDuu3P/uO9RLly7Ut2ZhHZYcFQtzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hdFH4a1PWpMGAUKGFm9BZbELCgo0toT31U/ahUTeeQ=;
 b=Oojbup6u2eX8STN9WG5R/Owrc4Pru+2evmf155DW7xM160OoTuEsFhbIkfF03+9eJfX42XrSpz0uXKlDL/whCBxOxUhudfcNkti0bkd5eaBldvcisOZIpenkUTACT5hos5Fr3bFOiWNm3hcfMHF6ag5X3tFarHTLCav2F+Lb+TE+99tyiSE7bGD8LnjsfQidNxhlnMPkREaNZI1EsH6nQeAGN4H8ldicaNwJhz/67N7+cHOI5VJn4guCt1AgcS/oI72g3hcQKbQ8wERC+wYY4msMkTyXAx+4FDRD8pRKfjJABgYjfEzB6CPSJhhcr6L07GMp3uX7SVUsb9heufvxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hdFH4a1PWpMGAUKGFm9BZbELCgo0toT31U/ahUTeeQ=;
 b=p7vt6KpVZv1+AsvtgEw2iYlTr95CrWQgutDc4wBjg1MRHOor6WcY93DhrPwWfznVtV6Y8x1AfHVCOg0cqUxgj00xPZocKQAzRiT3fNDBGOHH6OxpvAMaDiCD28oOgrLHr/em5IDQ6jXbQ/bkZVJrO6Q563MNKezvIDiNZdekmxIdAHOJKnTvJMpHJwYMGeh+gmi3xP1o22MKzCm29fTtOpjdU9X3uedF+dXMahlGnGtJV5D5j3w8cwIcJmMmzk2L+y9sglV5IcTb/U7a05FGzqThfecapqMQoXBUr2srp6n3Bhxn7Iwo9XBs0wzOUoIKiCUgUMgYZPd3ZjLJQZcOEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 15:55:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 15:55:35 +0000
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
Subject: [PATCH v3 4/4] selftests/mm: check after-split folio orders in split_huge_page_test.
Date: Tue, 12 Aug 2025 11:55:12 -0400
Message-ID: <20250812155512.926011-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812155512.926011-1-ziy@nvidia.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:408:fc::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: d38c344f-0227-41f4-e518-08ddd9b8ac89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZzryUON6ABWxVRCAmPWZKKFoiAEVUZZm9gJW/s597Q05rNNLyST08EdfDxH+?=
 =?us-ascii?Q?LmHlekZX2xtI4NpG4DzG65K2fFEBSsdhT4QXwUkHp4zuw1Zh2kTK1+d92iG/?=
 =?us-ascii?Q?KErXq8u2N614EB2SDPUmT5wOVuwFeECqxbqTS1k2n8EcYY2ExZqkn0vYMUWW?=
 =?us-ascii?Q?yzCz4DmW2WJd49vdB2Op1x7HGEC1XnhkidhX+LfX7rgfpDPetQuC78KnrFfx?=
 =?us-ascii?Q?u0ozIMQjqIZtvqangwa+v8UwQdN0nG0ogCfg0rEldwQwIy/kEqjAxR1zl5b/?=
 =?us-ascii?Q?BrLbj0pWjVqMBPsPhsbZPzSfP3638DCqL412HYpEnohQwpmQ3txCYfLC8v9W?=
 =?us-ascii?Q?x7iZzEqVCi1EJRS1Ch/DyJ2B4gtmO6guVXlMRwTrcPWBRZyqhXwevWpuEU5o?=
 =?us-ascii?Q?EFjCOpRcHL/Fih1OCxTQxgBd3iQdwK0o7MrscwkLl2BM0GKn8odQS9azt7TT?=
 =?us-ascii?Q?z9RFE63IqDP8j/ifnELxysZEzGAzEKtQ9QqdSc8W+FD6P5H/tD38WYuwhB52?=
 =?us-ascii?Q?oMVpJNTcTIE+maAu3voAd8m6SABAaL2DxNn1ZId0u7lPlIuV5CDAv2Jamn8r?=
 =?us-ascii?Q?lrya46p3E5B8gRuI9akTpubjZDRrsriNYGu5avIbDCwTHQ2n7DB1s8xyq5VE?=
 =?us-ascii?Q?M33iGKJ7jT80onrHhJUa6nMprXMp2tydMUz3YwZeiBI/o26xXtDN8nWaCPFS?=
 =?us-ascii?Q?ouECowtDkdEwbr7iVa/Y0s8h38ehNsVezw7mzCZHlb2mECHYlUq44aBQvgeS?=
 =?us-ascii?Q?57zWqnAN8cQnnZxNhmklru35+WiyNXFD6GtujLcnDLCCvZL9uvEJJD6KK8QI?=
 =?us-ascii?Q?tbjc/n3nqqqs2snTgGFXwuskQG0gEC82qvz4Azov7bHLM0Bh9/DYjcrCRUGy?=
 =?us-ascii?Q?h/dkt2PCGHGt0ODOtdNYUtAPWJsBzbAPMCdZgba753023MntWW4hb8YZgtHv?=
 =?us-ascii?Q?b08an3WhZ96IoyHw3ll/L+RlX5YufUL2+X8d4Bq/WehM4Vtkr4xgiTfIVGwY?=
 =?us-ascii?Q?lpzi/SgAIW5cEV1JazD77zqSxfkxXJH8ED95466VPaKbf/AAknYdOKWBDnBK?=
 =?us-ascii?Q?VbOsNDS7B37vcgza4S2LiOX34+Im9L9pUSfLN18zlsrWqVEDa4+D2PJyjDaQ?=
 =?us-ascii?Q?Dkr9sl2mtTHcjvqq1aWkYUxYAecWyX3MhmZoJtG8b6VSddFg51ge0hJmHZvx?=
 =?us-ascii?Q?myiFy5s+beiYPhole+jStQ+B1gSawhFgFp4nBLWgx9MzEfuaQSE3MLyYbjiZ?=
 =?us-ascii?Q?VmtJPp1FS/2qfDDrP73nf9YxLmTU1hWjSX+xRNlP15dLj5IC5AWeJ4luRt4V?=
 =?us-ascii?Q?MEBmRtaPfe4IGhNzrv5FlKWHjXvaqdSdbHac7DlyoHScTCRfg9k1KjKDB4le?=
 =?us-ascii?Q?Gj8lDZ6QTWsTdhTCU0+4GQgJlxDPw1EMragMfzDQm9upFxKVmIYIy85UFK0C?=
 =?us-ascii?Q?bzpUNAkwI/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+TSSdyhu6vJNHYXexWggtcU4mqE8ozSF3RDs3OlfSkHobwb5JFLCtMhPNaV?=
 =?us-ascii?Q?oV+FG2qGVFMQROyEJptwZJ4WeqhJ/Mnq03Na7GMntiPJR3JcJBy93q5TErn0?=
 =?us-ascii?Q?w7hsYXHAJVoGxdWBWrupnDMh1PvcWna59DMMZSgZ6bzs6JBGdSj1WLuJfDw6?=
 =?us-ascii?Q?p+c34UdOHKODT39iAnoBA7lfW72swEqWlmgSkOfQiayyxHUb8GfHVrbbd2rV?=
 =?us-ascii?Q?xLN121UKnEW3Zdn+ZpEz2KkAAlpMNrKa3fb/8Rv/NAXh7zv0weKiOYwznMSw?=
 =?us-ascii?Q?kBd2DE+AW3otAhuB3RIo2I5G1CGzb4EPdJbUCeVaS8Y83KRW11TNXdAC/rHw?=
 =?us-ascii?Q?e03ia2iYYnm5kEqsE6sY+9Cx/rGdZ/GPwSJFfRq66U4bljY8MJDYXoS1r/5X?=
 =?us-ascii?Q?buVuxMjymowSufhHJYK3xtPYO2qcTvG+UtNf2jSl7nV6MU2kJe3AH2wJOFb1?=
 =?us-ascii?Q?hy5Q+4A2NjR3JVqJ6aMEYL4Jsh//oaRdha6bRjDMLWL/lVBcNnoI5Rs91exi?=
 =?us-ascii?Q?0sNlDb9RViN67LJMYnyAszBDWhW35MC9YHeKhzNicb2XwEPAptB8NCjmIne9?=
 =?us-ascii?Q?tS50LibhUCtv6V7dYDTSRywpL0AzgOLQsFGussi3n4iMOfsQcxpF7NYtMLvM?=
 =?us-ascii?Q?JIoNRQuMbL/8wP0B3vckaEqjdUGaCoa0KP3ABWf4zd1eqHH6PijNQ9U7jjuI?=
 =?us-ascii?Q?dfMda3WZZ7oBhs4DZP7mFrpzrJdBIhb7avUtDv0GUZ9UgEW6RmLjkNpgRFfT?=
 =?us-ascii?Q?nt3SKB3QcTCp9+GsMItPHBh/RL7DOaaChlMXFGUW1c+5O1bkCC9qz1RZjAPs?=
 =?us-ascii?Q?596yUSB74C8l/uqDIVyx4DQlAYMLaPgfKHw1ZrnRFUQ8P2U48EQz3F9f3uw5?=
 =?us-ascii?Q?bRT30HFweQF5QJRhz5/vrDGmfFV9x7ySpy1APpAEwjS4JMfWv7W9vp8eQX16?=
 =?us-ascii?Q?qsW/c17FXmw8ioV05MbTEaS3Ljx/psWqfavRR24ZM78Cae2M0UcCdDPx8nCU?=
 =?us-ascii?Q?6eQZi8vaTBnPD7fT/6NLoq3U/jLnxYljs7f6d7RcUaPIoXj9OU/TqIfKWXXp?=
 =?us-ascii?Q?H6WxfWaee/H/5bYa7mEWHpG8OF9SFGCq/rk5HvVcmIXSlxBYjqPG7Ycjb6S1?=
 =?us-ascii?Q?1EWPPqqnE9RX20XgDqiulc/+9Ycn09KqNVIc1xA3IdN2FwgNkEtQ1UVTWX93?=
 =?us-ascii?Q?7lMT6pJUCpfDFOGtVOr1S3yFzL6kHiT319hVP7XXHrc5QkhBeObNN+qPUZM7?=
 =?us-ascii?Q?seXIhUzMZVwng6D6IjWu2P8kFZaFkrFhnAXUyBDd45CZSReNXdPV8HLVJ5PO?=
 =?us-ascii?Q?7y1fagpIBb5s8ifXM23F3RzsmT3SyMbOISduHailP6BlyiTlAmhflR1i2Vxt?=
 =?us-ascii?Q?9lp16wDlpbqbKcFSe7N1/mer5y/ateuzfOxefoUPiA3qtfBadFjYfzzQBXI9?=
 =?us-ascii?Q?xdjO7A1Gl6gRW0qulLtoVmbWKJV6Ko17iuPhGcHpr3EIKzuchVsMkoIU8juW?=
 =?us-ascii?Q?13mzywOP23phlPeTapF6ZUxxE7E0xhTxJDDXBkyKn8F+cATyxWQulk1DUyzw?=
 =?us-ascii?Q?ot1nc9B/fTEAxTF84nG0cW9PxLIo/2iQAmfFxjot?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38c344f-0227-41f4-e518-08ddd9b8ac89
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:55:34.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOl2vhyCo73j5socPEFC4F6B62aqfrsTVyvr9D0tfU278ipARf/e3lyByDZE970w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

Instead of just checking the existence of PMD folios before and after folio
split tests, use check_folio_orders() to check after-split folio orders.

The following tests are not changed:
1. split_pte_mapped_thp: the test already uses kpageflags to check;
2. split_file_backed_thp: no vaddr available.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 85 +++++++++++++------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 3aaf783f339f..1ea2c7f22962 100644
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
 int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd)
 {
 	unsigned long pfn_head;
@@ -49,18 +55,21 @@ int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd
 
 	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
 
+	/* non present page */
 	if (pfn == -1UL)
 		return 0;
 
 	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
 		return 0;
 
+	/* check for order-0 pages */
 	if (!order) {
 		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
 			return 0;
 		return 1;
 	}
 
+	/* non THP folio */
 	if (!(pfn_flags & KPF_THP))
 		return 0;
 
@@ -69,9 +78,11 @@ int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd
 	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
 		return 0;
 
+	/* head PFN has no compound_head flag set */
 	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
 		return 0;
 
+	/* check all tail PFN flags */
 	for (i = 1; i < (1UL << order) - 1; i++) {
 		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
 			return 0;
@@ -198,6 +209,12 @@ void split_pmd_thp_to_order(int order)
 		if (one_page[i] != (char)i)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	expected_orders[order] = 4 << (pmd_order - order);
+
+	if (check_folio_orders(one_page, len, pagemap_fd, kpageflags_fd,
+			       expected_orders, (pmd_order + 1)))
+		ksft_exit_fail_msg("Unexpected THP split\n");
 
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
@@ -212,22 +229,6 @@ void split_pte_mapped_thp(void)
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
@@ -285,8 +286,6 @@ void split_pte_mapped_thp(void)
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 	munmap(one_page, len);
-	close(pagemap_fd);
-	close(kpageflags_fd);
 }
 
 void split_file_backed_thp(int order)
@@ -489,6 +488,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 		int order, int offset)
 {
 	int fd;
+	char *split_addr;
 	char *addr;
 	size_t i;
 	char testfile[INPUT_MAX];
@@ -502,14 +502,27 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
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
@@ -518,6 +531,13 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 			goto out;
 		}
 
+	if (check_folio_orders(addr, fd_size, pagemap_fd, kpageflags_fd,
+			       expected_orders, (pmd_order + 1))) {
+		ksft_print_msg("Unexpected THP split\n");
+		err = 1;
+		goto out;
+	}
+
 	if (!check_huge_file(addr, 0, pmd_pagesize)) {
 		ksft_print_msg("Still FilePmdMapped not split\n");
 		err = EXIT_FAILURE;
@@ -569,9 +589,22 @@ int main(int argc, char **argv)
 
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
@@ -596,6 +629,10 @@ int main(int argc, char **argv)
 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
+	close(pagemap_fd);
+	close(kpageflags_fd);
+	free(expected_orders);
+
 	ksft_finished();
 
 	return 0;
-- 
2.47.2


