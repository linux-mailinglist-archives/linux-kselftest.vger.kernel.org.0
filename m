Return-Path: <linux-kselftest+bounces-39240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9355B2B0BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18525E846C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA4273811;
	Mon, 18 Aug 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jj6NfDKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F8270559;
	Mon, 18 Aug 2025 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542796; cv=fail; b=N9HGGi0O/JSzTIqymEJshZS6tyakfdSdLs0LwNYPIrgjdi/73M6Nojotf+BUheRL1v+kHOnxZxrlEgk6Xz4sSqGfXRbdX1YuVAxZqyUWCUccxaCCsBbp/Yk1ufxYKiMqo1FLS7yZqaU+XqdTkUemRv38TpE0Buu2yUnzKX5tBLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542796; c=relaxed/simple;
	bh=Mn8QMyc/Os1S/1K7+m7SRRZ+M+oJx1F7C4EH/pqSJG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqt/EI+e/52QO66M1lpYn7IFSo1YaIwMHCvqUEWoBCwNuQClYwPKwxRsAFKgGjP/SQCxKI+Jk4aJMCt9JuNY0sjbSnH6hAKBGq3zx3HSVKZU1bvXgrD2lHTDPmKzjTlepus4pacjBaCck13onORObK/d49pVHvQw5b7V43xEwDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jj6NfDKm; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6zuzc+XVYs9LrQCLxpIkIm00OEwYBUly7zaS4nvSn6/A3rnGxECc02y+cu9zn8sj5asubu+EsEPFfo8Zn+FthC2AvZflrbSVofJyaP2DQM25JlgqJbvc9mPhlHFcOPH2XZdHNAD28mzaGJ9h+1qhbtUAp8/5lle8jOSPUREygI1NgMYCkk3Gy15QbejNPs5NiHdGFOUYCMGnHlZhhQ4qnj3lEEeQYYMwmDJ6I03REV6L7Xbwa6uDBXwNVksQeWWLFX9bP6wDU6INVTbK1Lx1o/99kC1Al1lEmbZLiWghyWiBcAjwQcOJIZMHZUNlWH6H6It77MLb1Q1A5cKGUSN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFy8btX1ZlLICpW7kbqM3wbGIHxxU5yal6pqrfuFe5M=;
 b=R++f662SetXti6OjEZgu/yHEscgBh8Ztjs1Px170h8DFuxV5uzVaJXLWotxnGJWAwOKS4VPTdadpxGvRCtwfRAXv7DkT2bunqd9stVIZi4zEjN+YPNnKro1i/I4HnoKFBZFeW8eg1A0XQoly34BvWjmG9DZGCZsbj8HPYoxGpwXr5vsxkGzjQvlgI/7j2GszDF2KDjmJXZZoezg5R2HJ5/+Iiorr3xCrO/Y6AkXLfx3cGq5aKONN66Hwz/hX5DLneWejZp53VuXZPcfvr3R7HNPWMaJT8w4cP5qVNNwkavSI1GZvLGS58/rruTCkS1q10ewekbM09ifYeyl9rDJEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFy8btX1ZlLICpW7kbqM3wbGIHxxU5yal6pqrfuFe5M=;
 b=jj6NfDKm5KopZzrNKcNx5hfORjBXXN8vFvw4uviEsaUeqmQpFL7n+xzoKbixAqWxPPmgloC0as7rVgRsfFUifpHhYSgIy9w1mEYIf+eScCEBSNzBYENZNZ4s3LT6X4HUENVrQ5WGdAhB8wG/G1NCqICK2P+Q2A7lEA/kv2Mh5aSjaXTTuqWLE01CImexXnsYOsmXl9brwT4p7emfWNzykLnnybsLwZymzvzcWaHQ+F0/LoK9lYFJXtRkg9CL4p9UNEsla1aaG9GGDF6Cc7MpFdxAPNG3JGDgrUETPG+7KCYIqsRAx3Sjh6ZVEnQIG5n+4lcTajWYZ5Yo2BVWOA+pqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:46:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 18:46:32 +0000
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
Subject: [PATCH v5 3/5] selftests/mm: reimplement is_backed_by_thp() with more precise check
Date: Mon, 18 Aug 2025 14:46:20 -0400
Message-ID: <20250818184622.1521620-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818184622.1521620-1-ziy@nvidia.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 77856ba1-b85f-4651-935a-08ddde878c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+GHhEYyZ4WU7yQul0jl1C6SSdjzhgioV9d2TYaujULV7HoGQiILwqUFPXvf?=
 =?us-ascii?Q?zquVVGMDNBntdqP+3sKbfwgO4Z5LZ3nDVVBPbk3KmETU2rDe4nohQ1uynwYz?=
 =?us-ascii?Q?3BKipvz+MRowPQBY77aIUm+TM+Se/gyIXhL3A444Mcexn/QJWe3STUUehY8l?=
 =?us-ascii?Q?UBJuGrFPYEDTlz72XGTlzHBsAZ85R4uF40sTK5kVQAQW4S681GV8X5RssLxT?=
 =?us-ascii?Q?DiQR2TgqtBvBs02h99wRZzStM57rXfQdO05P9Q2ygnNH2KSLCw8s/Ve74qqq?=
 =?us-ascii?Q?L04sYCdx5IpHPz1HnYvTkwe1zuLV/ek5rGugNfSivNWnmKvFClDwWRam/PPm?=
 =?us-ascii?Q?8LE1/UEWX97GRWgHtm3KiaJfYb0Wun02U1ZEdffUsQE783MxB/sMdSKC0ykP?=
 =?us-ascii?Q?3F3M6tiDwjpwbFF/xmhQg5j0jFNlgKeiVZdn3fuAwlECF0kCcPVWp7P5t+n1?=
 =?us-ascii?Q?nJy1mfh46ZAKtsk8qD7ON4CQMNxEoPbMZE3ATUFRW+INgB4REz+zg32mfbgW?=
 =?us-ascii?Q?3fo1iJBcyeK/vbmqetzh4T1W793QXkVa7qDiTypoTq3VJeK0sRT6MJfMvwGq?=
 =?us-ascii?Q?T5474UMPfjrJ1UQiBZJ8RCmYCR2n4ciAwOk3Tth/8VcMfL3T6C9pyC0pfZxt?=
 =?us-ascii?Q?QxtpiJfR3bNZEKy4wWyK50A/r2UZ9OjGqm3I5AeY5j68wChoDZd1QHOOfE8H?=
 =?us-ascii?Q?e9pUI1BUWytYICKEhAtoxbEtqS4IoDpi8NgD4T+OlCE3hjtaPp3NVUClCijC?=
 =?us-ascii?Q?atjDGzLk/Ts06a2CBCfQqchr8x+cz8on67IxlorenvvqSSg2bec924cTe2lC?=
 =?us-ascii?Q?BjROVr+qOFd1BnFM+r22B3/7uSYd2bMIQrM9moGd5hSy6LognjH5d96m1KBb?=
 =?us-ascii?Q?HMW6bdnWefrTdxYarVkU868sbZtoQwkJLK+NNnhvTuVsiNBVAaUbYTbxtFvC?=
 =?us-ascii?Q?YUhTPFqvkgWNUg6lnZ6kGClGgjeemCGKZo2Fhf7FB/l4mt1YvMnowGkYayju?=
 =?us-ascii?Q?4VRMfUqp3E3zt9Q0Ch9fPVNQKNYeBfiJ8fIKZAGcQMYc4UAYEaL9BVBELWfc?=
 =?us-ascii?Q?oQbUXy/TMi452sbV8T8vAAICI3Xnsf5zOpmMcmZHLsfZCGNLfbwBwN0OBsqf?=
 =?us-ascii?Q?7ZNWrw3iNikXo+GXqAQhitE55Torb72DCBsaxEcqPrwNfjV3GlhSi3epQ/ju?=
 =?us-ascii?Q?j253KP9sE4dW4RburjLZ/OzI7LWzZpaqpYN/3CAIu/+hC1ANo0DRUbroTUHu?=
 =?us-ascii?Q?VHV12MGBN70XG1DHALX5zJstqSX44QQm4ska15at4MTYUtdUVTqjUgrfEC/U?=
 =?us-ascii?Q?EJ345zDfi9AwFztySzC4Lp0UApsBjOLK8vb3cqaP4KGl8Axk2Z2AfcKZejpM?=
 =?us-ascii?Q?roWyNie0blsAlMgSU75MQ6WZ9a5mHFlekTzlMVU9DHhMHo5cPxcAgt2Qc9rq?=
 =?us-ascii?Q?2PttL3ckfDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYyzUBVEBl1XyDCQxdG0hJp6ydgGCyloGdArJdF0WQV8pTs9AfE8WOap/lk/?=
 =?us-ascii?Q?8YIW0JztVitaSK76RP/9wONnv2tjlEwstCSskjXtP59LxoQZYVCOV1Rimuaf?=
 =?us-ascii?Q?TWzzy39XgRxxh7IKmzATUDWfxXTAsY/IeVQZao3QLV+14A6ztxRxSVcUWftV?=
 =?us-ascii?Q?3UMVo15Khki1xNFf5tH4j9u85TDFFmAcmbTV9tN1Wuhl3+J1DPJE+uiy0zuI?=
 =?us-ascii?Q?2JoKJJtqJ/1GGa1zXXf37ynpy4sB5UQBRGdl116KxdN5e2wetWPJetEqNM1k?=
 =?us-ascii?Q?3miXRZNkebjfzE6TTdjdvx/ZWv/5jfJatOkEmIdNqMreURYgvqtv62Hnq4U6?=
 =?us-ascii?Q?p6DVekWK/kHOKuIfpojwV2cMl2B3sHxwcUA7mA07pqXNgP0PZRBdRyr97i4y?=
 =?us-ascii?Q?w13byFhhnDBE+oAazihnG3DwIHxlDWEjoe8fgOOND2Jil5piEsD1RT//dmDV?=
 =?us-ascii?Q?6i2whT6IrJJCxKCcU5yaFTZNSM9ZEjW/0rVkJFOjkzIea7soYHhD79AwVO//?=
 =?us-ascii?Q?VtOXo9JMaknm7Mq4OUfsQ4OlbmpY87uXRJNpsJdKAnMVMTjymdWeLwMX0S2G?=
 =?us-ascii?Q?8dxZTU7Tt3bslTYs0a8Ja3OpUv39MY7bYmEs3nIYSHHEU5JmtIMFdUVJGQTi?=
 =?us-ascii?Q?Pa017xvWEzy8towJp2vlOcubkr7s5duhY3xCnVHP1nHWWGEUYyiHoJ7CgYA3?=
 =?us-ascii?Q?dYxFiI17f+tcEx2W72j8CNER4WVZHwYMdJGUnGoDreeJ6O4D+GuLXPPhzpmd?=
 =?us-ascii?Q?XpUBd7rtzf3ddq8p5GucAR/up9Uk90lDbjoCYdGVvpBaG8xaqRo4uYonRSrM?=
 =?us-ascii?Q?bWfTbm4P0jris7atbDqeE5kdwdLaqKInDpWITlJwAPrnxA+eC5X/TjFOx4xN?=
 =?us-ascii?Q?ClcnIDdjjkcDUBPYLt+kPWUr3w/6vpxYtPOOTZvOXc/6kkI4lx6zQ3cEw4by?=
 =?us-ascii?Q?etpjxvrtaad+HAkrwr/lQyDTd39V8E+cMv40HSVQj0pFxYU9Dt6p9VLSoOZi?=
 =?us-ascii?Q?fr1fTiuwwS/3a8SMqDJSRAC+TuInXxAr1mLDNxNpMOcOxQ/x4732OLkS88xY?=
 =?us-ascii?Q?uHLvBJXRnjA371gGHtygASy6m/i1r/zXY16vtHEbQ8A6CAUPF4BdmdmfvZg9?=
 =?us-ascii?Q?Txt+HlIrgo1Xf8gFbIGzYqwhvXoknPMEISadkikAr5ZTA4NVXpqnukWUzYXH?=
 =?us-ascii?Q?3Q3m5h7X/odMnXKavYG6MWkmvU8Ls0SBy5YZZaZF1z2ga52CDZv5Km5m+R7m?=
 =?us-ascii?Q?WG7uqdk09TySpV/IHZkLPcw/JgUDpBcu16jtUctz/Ioswx+vFiDheBkWLTLG?=
 =?us-ascii?Q?pkk3rMk2UHNTlpgSVwa8xSMz8IhO0WvsUzcWtqrYMsMX7ZAoVDdo9tl0hAHn?=
 =?us-ascii?Q?LgNjegrKe9xnP4WEt1TPSv8CglwJV7vBvu7AkKJUPi0dK6F7qlIjwWj1xoF0?=
 =?us-ascii?Q?FXHlUP1rH+xZspGb1zqVAmzqZ1/1bH9YM07GmqdvsabQUfxJrSXtmbtoajIx?=
 =?us-ascii?Q?T4lnEYqEoazBe5nVv1u99eeVp4IMtHrw2R9t1AyxNXX6NboKMy2ZmLgZbJVJ?=
 =?us-ascii?Q?G4mSVpTshJI3Up923nhLfMqSrCRARMxnJtXvmZA9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77856ba1-b85f-4651-935a-08ddde878c99
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:46:31.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L66GW4J4VHAzAkw/NIEbyBnCLblXVKZf1XyI34sBG7Vro+9w7xTYhIkaZePSjvUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

and rename it to is_backed_by_folio().

is_backed_by_folio() checks if the given vaddr is backed a folio with
a given order. It does so by:
1. getting the pfn of the vaddr;
2. checking kpageflags of the pfn;

if order is greater than 0:
3. checking kpageflags of the head pfn;
4. checking kpageflags of all tail pfns.

pmd_order is added to split_huge_page_test.c and replaces max_order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: wang lian <lianux.mm@gmail.com>
---
 .../selftests/mm/split_huge_page_test.c       | 88 ++++++++++++++-----
 tools/testing/selftests/mm/vm_util.c          | 13 +++
 tools/testing/selftests/mm/vm_util.h          |  4 +
 3 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 089e146efeab..56d1eaf9a860 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -25,6 +25,7 @@
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
+unsigned int pmd_order;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -34,26 +35,66 @@ uint64_t pmd_pagesize;
 #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
 #define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
-#define PFN_MASK     ((1UL<<55)-1)
-#define KPF_THP      (1UL<<22)
-
-static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
+static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
+		int kpageflags_fd)
 {
-	uint64_t paddr;
-	uint64_t page_flags;
+	unsigned long pfn_head;
+	uint64_t pfn_flags;
+	unsigned long pfn;
+	unsigned long i;
 
-	if (pagemap_file) {
-		pread(pagemap_file, &paddr, sizeof(paddr),
-			((long)vaddr >> pageshift) * sizeof(paddr));
+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
 
-		if (kpageflags_file) {
-			pread(kpageflags_file, &page_flags, sizeof(page_flags),
-				(paddr & PFN_MASK) * sizeof(page_flags));
+	/* non present page */
+	if (pfn == -1UL)
+		return false;
 
-			return !!(page_flags & KPF_THP);
-		}
+	if (pageflags_get(pfn, kpageflags_fd, &pfn_flags))
+		goto fail;
+
+	/* check for order-0 pages */
+	if (!order) {
+		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
+			return false;
+		return true;
 	}
-	return 0;
+
+	/* non THP folio */
+	if (!(pfn_flags & KPF_THP))
+		return false;
+
+	pfn_head = pfn & ~((1 << order) - 1);
+
+	if (pageflags_get(pfn_head, kpageflags_fd, &pfn_flags))
+		goto fail;
+
+	/* head PFN has no compound_head flag set */
+	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
+		return false;
+
+	/* check all tail PFN flags */
+	for (i = 1; i < 1UL << order; i++) {
+		if (pageflags_get(pfn_head + i, kpageflags_fd, &pfn_flags))
+			goto fail;
+		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
+			return false;
+	}
+
+	/*
+	 * check the PFN after this folio, but if its flags cannot be obtained,
+	 * assume this folio has the expected order
+	 */
+	if (pageflags_get(pfn_head + (1UL << order), kpageflags_fd, &pfn_flags))
+		return true;
+
+	/* this folio is bigger than the given order */
+	if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL))
+		return false;
+
+	return true;
+fail:
+	ksft_exit_fail_msg("Failed to get folio info\n");
+	return false;
 }
 
 static void write_file(const char *path, const char *buf, size_t buflen)
@@ -234,7 +275,7 @@ static void split_pte_mapped_thp(void)
 	thp_size = 0;
 	for (i = 0; i < pagesize * 4; i++)
 		if (i % pagesize == 0 &&
-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
 			thp_size++;
 
 	if (thp_size != 4)
@@ -251,7 +292,7 @@ static void split_pte_mapped_thp(void)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
 		if (i % pagesize == 0 &&
-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
 			thp_size++;
 	}
 
@@ -523,7 +564,6 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
-	unsigned int max_order;
 	unsigned int nr_pages;
 	unsigned int tests;
 
@@ -544,28 +584,28 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
 	nr_pages = pmd_pagesize / pagesize;
-	max_order =  sz2ord(pmd_pagesize, pagesize);
-	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
+	pmd_order = sz2ord(pmd_pagesize, pagesize);
+	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
 
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		if (i != 1)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-	for (i = max_order - 1; i >= 0; i--)
+	for (i = pmd_order - 1; i >= 0; i--)
 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
 
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		for (offset = 0;
 		     offset < nr_pages;
 		     offset += MAX(nr_pages / 4, 1 << i))
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 6a239aa413e2..741fc129313d 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -338,6 +338,19 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
 	return count;
 }
 
+int pageflags_get(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
+{
+	size_t count;
+
+	count = pread(kpageflags_fd, flags, sizeof(*flags),
+		      pfn * sizeof(*flags));
+
+	if (count != sizeof(*flags))
+		return -1;
+
+	return 0;
+}
+
 /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 3da56feeb944..ab8722f482ae 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -18,6 +18,9 @@
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
 
+#define KPF_COMPOUND_HEAD             BIT_ULL(15)
+#define KPF_COMPOUND_TAIL             BIT_ULL(16)
+#define KPF_THP                       BIT_ULL(22)
 /*
  * Ignore the checkpatch warning, we must read from x but don't want to do
  * anything with it in order to trigger a read page fault. We therefore must use
@@ -85,6 +88,7 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 int detect_hugetlb_page_sizes(size_t sizes[], int max);
+int pageflags_get(unsigned long pfn, int kpageflags_fd, uint64_t *flags);
 
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
-- 
2.50.1


