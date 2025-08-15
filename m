Return-Path: <linux-kselftest+bounces-39036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14486B27623
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD14604A61
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBA29B8F8;
	Fri, 15 Aug 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="teH40Boi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F229B776;
	Fri, 15 Aug 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225592; cv=fail; b=hsOqgoc4d84omgmoEK7y9iQIA3+Vbls0mtXZb5pEJ5WA9Ttep2mhVIlOlbr8IHjymtFjrrR4a+jWcu7U062+5ReMqcURpdFUHJxfpgFsILySo7tDdoPZADvtmsWxrERWrBKv5FfPWzQLbeydHV1hi6TVCDpEgur7RcbhWJki+3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225592; c=relaxed/simple;
	bh=7F3A9eXV/RNeYnDM8XE+lMnqmlU261GXJltKW59KixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UECKlA3IDlIIqcv/aECDBaRq8JMgogAEbqMmjAKlbItrQBIMbkirVaIqoFqHGGDom/AFvPJQyEnp0fW06ILhoxtKlBJiWYoxADyz6X0V1TjGj9Pe58z2B+VAZYL/UPq18SjMFFi8lzNLfRdZyq3vilqRErMEyQtBxlt+hFUGtBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=teH40Boi; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcysQ7M9WH+n05Pd2uq4F1bKBPW0jcCb6QLksltW5+hOyCY+x82A954eN0sc+W6AgDSgp5jJqrYtULqYvOIePAL5kXEEMmwkEolASNfZbbF04KK7dkxz9OtGshcsjjtm9nTZn6sRVjV48uQjVhugmmogwSXPjHT+MUr6XhPLl6kQjkIIvs2w6eA1mwiDjZiifQfUL7kQgNVI4fpM6G/n86dRZrOW2xFNEPnJTFvl/Hdit7QeCJUbsK6t6XhQ2OtheuoX1anrtoHQboPesLH9Ft+MLYYXkV+cYXJjeDCXeNfSiNPwfWMw0/CCBwAhPfXdHAxeyAu4hmhy0OuUWSgkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOrMBoqBO0sEo1cRgG3waLlra/epJIeXy4v/9JmSdpI=;
 b=t+4jWoe+jDwqIFM1f6EV6JK6FqatGi2tvS/+zHjw8tZL5h5gMXRxvu4k+PSMsSLmMJeVd9qEOnlVJFTTX35xMIw3JeflZq1Cu+OONxDRyg2QEJrllezSjxzBvyeXM3/Lj/8EelRkU0FibDLDB+xNOIAHQI3Qo9K3fAdJLQunZJPl3vZUU8UXBTPP74NJIPD1ZoKVjjBKMy8u7E5mlttGs3fdTb+jE/kkHTkFEOObWwcCh4Wj0DCeAEmcZglww8H/7/yTgChZdQMmX9if+ETPRgCJ0b20apgT9mvg75VOJw5+ef9LRw1GStAtrkPfVrnuTZ9qPPIjblHlxrIp1u6x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOrMBoqBO0sEo1cRgG3waLlra/epJIeXy4v/9JmSdpI=;
 b=teH40BoiVYV/5dMGdfdiZEGMX5dOHRXXjNitQhYL42jlTKSDp8t6OMvJu/eVBPepHpv2urtOr0kbqKgDMWP4meK2krpBcw/0jM5GnxIi61Lll30X668o8cqpNFU75KnX0lqUupsvkgAoHIr1Pv05krDhurmK5eoCCCO0BCfR+ccontvhyUQEPcMI29stbStQ3e+n5dFKV4qcUBiVgHLxCUjQWWcGhz5g2GNmfMF6ltf8OEqCli7mXm6ngx4X0RS1CzaLLnH6PXoDF2q9z8MjGrA8/uh9Sn8UxPfybGD1NC61J5lMzW27oWrGfJSORZ6AZFs0ucKbTQ6ycKyvRMxZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:39:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:39:42 +0000
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
Subject: [PATCH v4 4/5] selftests/mm: add check_after_split_folio_orders() helper.
Date: Thu, 14 Aug 2025 22:39:13 -0400
Message-ID: <20250815023915.1394655-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815023915.1394655-1-ziy@nvidia.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1412d48e-07ce-453c-bae9-08dddba4fd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAd8M+/SeSlgHUQrKQmPjsV8delMnx9sTOgCQhlLZCZ8sY2gScciM/tOuBe3?=
 =?us-ascii?Q?6QhmCYA+9fxS42eTA9WPxr8MEb5OXla7PMBaVkyqpRvU9Ds7WLQ+qLY9rnJL?=
 =?us-ascii?Q?06uZ++HBKxWymdpnvxEg4krSkt40iQ7XdPUuYrCdZcro/1nGam74+l86UttR?=
 =?us-ascii?Q?9p3PD4vaURLSiq+T47ief00KzbMSxdoMApH1IZtMCGtuD/SzqDa5Ge3nmyG3?=
 =?us-ascii?Q?4fx8QeBr5GIl3DB9rW/16yvxkZxVCFYh9Ae0waALR/rM5Uh6w15gvAvf86pD?=
 =?us-ascii?Q?Zym2Y9YAWAQgxnZIv29q7A4FxxApi/l9YtyIWCFcZs6GAUKr+h3MqAZWHTGv?=
 =?us-ascii?Q?IRKUqLG/EwR84Fk8U+ZY/SdJ680CT6ldy2rdNEOH3YVBdw7M5StUJeVaY2KV?=
 =?us-ascii?Q?oKxxn9RhrsirmnGNJTzIlEY/+anramk4AG/xFY0fXClHEw84O7veK29BS05H?=
 =?us-ascii?Q?+x5Jf5nvc1NH/S50c74Ny7gDxkYW2kRUzQkfytFNigzXR98HH2AUaiUni6dt?=
 =?us-ascii?Q?3o5YmSr6Yp+C3bZNp1EyYVcxmXNlUZrjo7pYWJhcuFUaX6PmH6I60Ohc7CrH?=
 =?us-ascii?Q?7sO9IbiqwaifOMUy9WfbWn8icDo+B+9bFl4XQcbzvtogARUSgnwpFQpaUImR?=
 =?us-ascii?Q?pXpQawzGl+MIljCnGxofqTDuoAHi2GF8NJt4c3PfCXKinDFjYp5vw749dEgF?=
 =?us-ascii?Q?n0q8kPLHQWtAwplSPOy0OWz1Vsa0t70Ze3KjvLr2NzYqDGX6xPNAhWP6hW0w?=
 =?us-ascii?Q?1pepbF6QWT8SUWvaq6jXnRu+rZLIXqeVoOaopHsKPQl9ddoEOguZvehaVAe1?=
 =?us-ascii?Q?WrHbAtUD7jB/vQIGo406VzaFD26Z0h/egNpffxU+z3NvN31Lv/EphmujM3z1?=
 =?us-ascii?Q?3dlokAswAhFS+3tFRFLQRA73WWDbHDddI7q6uIzztZ/Gj6tCsSQCbk3TH6fK?=
 =?us-ascii?Q?cRRVZksdCCDu34jFExgSmF+IWPciDgX0hTApBK7LhqA/nXMtAF3A1royPyDH?=
 =?us-ascii?Q?YDlbceC3NRUDJaAoVicusuvopj5F6upZt+ELssGmEnpHIfc1ojNGj9YQBTaP?=
 =?us-ascii?Q?+HNmeoh94SAw4lUsdheWLpnPPazBM7IPqvyBde5RqC7AkkLwteVxbfakuJpM?=
 =?us-ascii?Q?x2pcqpW+fCEV6QdyxwwEbENSk2iKm6UJYZ9n4eMaB+m6sQhJ9uXP1M3lgIDX?=
 =?us-ascii?Q?6r1zHDUo8DWFlSSuP1uSXp+S56E5Kd8cPwE74ExoaDLpo0n2YCVbzAo92qFg?=
 =?us-ascii?Q?RGMzo7hbDccbW+TLzWWM1DdXtXA3aJYHr7ltVkz5+AQMLkddK2UqOQxgUCEY?=
 =?us-ascii?Q?ka2KnhHBM+fIuUk3nsBrMXO8e298F1UOOgBxE4nXV2ScbAF6WtnKHsPV9h+n?=
 =?us-ascii?Q?dfCznNj7O70Bc/nkLsw/2gI6dFkPzAnHarpDGq/aMq/SIEtHPr/Q+Aj7e/Qs?=
 =?us-ascii?Q?NTOBvkeR2yM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81g0uL8RyB8Kwrh/un8d4WEmFusuHnLjUUbk317hgbY6OSbwK/jKZKsU9RdZ?=
 =?us-ascii?Q?uBOSmSEO5XKYk28Rn0XTWMSXO+S1JS4H+/W3LlSs9sGODkvCGU5AeFg3+zwu?=
 =?us-ascii?Q?CXnMlalIjyIfZvEJx1pgkJ/6TvYB0u5ZCI+vTRnnjRB5TvF3XImC0vr02+cG?=
 =?us-ascii?Q?8WxPMWg/PLPkmX5lR6vjoW3yPQrXNVFB3GYZYjsvRi3mlJdZYnCFq54bLltW?=
 =?us-ascii?Q?JBvt7DFFtMknn4Ea/eTTy0/XXNjiNVE0xMyQ+Hd/A/vBatQWEm0xd/YvR3e9?=
 =?us-ascii?Q?Uc1V/5dVK3oJ4ZLQvitnDBBvrODyXHM3cyzNGbbJxcK0eA1AzW8Lw4FBq195?=
 =?us-ascii?Q?aZsxFOOMF6Ck9Qik5Yl1dsJtt8MDgeiChJc486dSkxxM+zfJAutKnBmlUkm+?=
 =?us-ascii?Q?40c359k41tqFRXtxDcBIgmz5X3xpezm8jlTsvXv02YTLtY8gmb2w/SkbVy5v?=
 =?us-ascii?Q?f2hQRC3PZAbg8gtjx/1YFwLKfuEo0aE4RFCzcI5osfcBrHb8CyN5763HDMUM?=
 =?us-ascii?Q?LHVN6NdD/+pCo83zGF4Cd74WF1C1H6ncdTTs9OZtIioScJTURvlF+X0XhiVL?=
 =?us-ascii?Q?mE+OP8OuFJN73Shq3vzUSQdC8yFQ/4bqBu8rJ6ORpX25YKRJha72GH9Q/hHh?=
 =?us-ascii?Q?kVxgfg+3qbK8qhbv33krSlvQ98ZUaaCu1+qHLyLpr6FLJMXOcXOHqHtM2ugw?=
 =?us-ascii?Q?0rt6i+aJJe6p7pCyRkriZHWz832zPqrJPsH1L56w4WifXH63Ew4LpkDsvBlg?=
 =?us-ascii?Q?NEBami1lfE2ESgXBFutAeQLB02JpEGp0k7FKG1W/K2QLSdbQP2iUITVolPKv?=
 =?us-ascii?Q?kmQoAH5u+O90gg6oViC1H+oYOm8iori6T2Ev6yl3jMzq/NQR+La/IRCXnFuX?=
 =?us-ascii?Q?CNGwXtow4db5A0cTSOi2a69xO8aPwSMDie+qqs+p/m5zQrdxcfz0EZnr0ee3?=
 =?us-ascii?Q?yQIddUibyYkhF/5pR+4QOuKUn268LRXLf/tV2KkLDfr1/AJEtdqpGVgXjbsc?=
 =?us-ascii?Q?VPFdjyaRdOfMkyLxZdXSbFlB65xRLscBiYjVU+fPTxNddWXoPd09+/RIMKVE?=
 =?us-ascii?Q?zvDoKGedecyWguKUjAAE3+pMY1Uh9mtOAFRq6uhvApuq9WvP39a+H6wRqlOW?=
 =?us-ascii?Q?OA80NWE1dYIyU0I52u3olC4Qztl/r3wHAV6Ii4vsv/4DPMmqI64DPEUs1Och?=
 =?us-ascii?Q?fVidh1lvWJPnz82eP9HaEGt/0oY2oSNKj8zaNfxjSq9nQVNK0aoYm7jnqraI?=
 =?us-ascii?Q?3pF5W+rjxMhLqSO0Gy7DN//6Cfx9fQMdeBdX0yWoGfHtIdbuE7oP1Uo6HkwA?=
 =?us-ascii?Q?sE21wzaaStsKiYvz3TjDPj+ujMCd9410P2DuHtfpmWrv+ZtgRVuZZ8+PLJX9?=
 =?us-ascii?Q?0iT2MzN6xc1cHbpnSsugUV+NL7qXsr4jttnHlKtaDMFAF9uZj+IiXm7hxeZd?=
 =?us-ascii?Q?VKPnJUgeJF3GyPcwc523XZFvqrZIws3MODT1TSHV69Dx3kIKwW7OxwIY98qH?=
 =?us-ascii?Q?CbVvWLzcZXHT6Rcx4j5IZCk2WNbUJNjk1jJ+UiRfKsaHR8x9Z8TDwx/HsXET?=
 =?us-ascii?Q?CuseTzUhaKvLxCtSEPQDDRVdedaOKiVFsFqramHL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1412d48e-07ce-453c-bae9-08dddba4fd1b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:39:42.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCL6uWo7sFvC+b6XGKdNwOfhrsuJoWFbwHeElb/zV2Jv6QzMMJcDwQ3icZwYncoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

The helper gathers a folio order statistics of folios within a virtual
address range and checks it against a given order list. It aims to provide
a more precise folio order check instead of just checking the existence of
PMD folios.

The helper will be used the upcoming commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 80f718ca21c7..d2467072e752 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -102,6 +102,156 @@ static int is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 	return -1;
 }
 
+static int get_page_flags(char *vaddr, int pagemap_fd, int kpageflags_fd,
+		uint64_t *flags)
+{
+	unsigned long pfn;
+
+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
+
+	/* non-present PFN */
+	if (pfn == -1UL)
+		return 1;
+
+	if (get_pfn_flags(pfn, kpageflags_fd, flags))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * gather_after_split_folio_orders - scan through [vaddr_start, len) and record
+ * folio orders
+ *
+ * @vaddr_start: start vaddr
+ * @len: range length
+ * @pagemap_fd: file descriptor to /proc/<pid>/pagemap
+ * @kpageflags_fd: file descriptor to /proc/kpageflags
+ * @orders: output folio order array
+ * @nr_orders: folio order array size
+ *
+ * gather_after_split_folio_orders() scan through [vaddr_start, len) and check
+ * all folios within the range and record their orders. All order-0 pages will
+ * be recorded. Non-present vaddr is skipped.
+ *
+ * NOTE: the function is used to check folio orders after a split is performed,
+ * so it assumes [vaddr_start, len) fully maps to folios within that range.
+ *
+ * Return: 0 - no error, -1 - unhandled cases
+ */
+static int gather_after_split_folio_orders(char *vaddr_start, size_t len,
+		int pagemap_fd, int kpageflags_fd, int orders[], int nr_orders)
+{
+	uint64_t page_flags = 0;
+	int cur_order = -1;
+	char *vaddr;
+
+	if (pagemap_fd == -1 || kpageflags_fd == -1)
+		return -1;
+	if (!orders)
+		return -1;
+	if (nr_orders <= 0)
+		return -1;
+
+	for (vaddr = vaddr_start; vaddr < vaddr_start + len;) {
+		char *next_folio_vaddr;
+		int status;
+
+		status = get_page_flags(vaddr, pagemap_fd, kpageflags_fd,
+					&page_flags);
+		if (status < 0)
+			return -1;
+
+		/* skip non present vaddr */
+		if (status == 1) {
+			vaddr += psize();
+			continue;
+		}
+
+		/* all order-0 pages with possible false postive (non folio) */
+		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+			orders[0]++;
+			vaddr += psize();
+			continue;
+		}
+
+		/* skip non thp compound pages */
+		if (!(page_flags & KPF_THP)) {
+			vaddr += psize();
+			continue;
+		}
+
+		/* vpn points to part of a THP at this point */
+		if (page_flags & KPF_COMPOUND_HEAD)
+			cur_order = 1;
+		else {
+			vaddr += psize();
+			continue;
+		}
+
+		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
+
+		if (next_folio_vaddr >= vaddr_start + len)
+			break;
+
+		while ((status = get_page_flags(next_folio_vaddr, pagemap_fd,
+						kpageflags_fd, &page_flags)) >= 0) {
+			/*
+			 * non present vaddr, next compound head page, or
+			 * order-0 page
+			 */
+			if (status == 1 ||
+			    (page_flags & KPF_COMPOUND_HEAD) ||
+			    !(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+				if (cur_order < nr_orders) {
+					orders[cur_order]++;
+					cur_order = -1;
+					vaddr = next_folio_vaddr;
+				}
+				break;
+			}
+
+			cur_order++;
+			next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
+		}
+
+		if (status < 0)
+			return status;
+	}
+	if (cur_order > 0 && cur_order < nr_orders)
+		orders[cur_order]++;
+	return 0;
+}
+
+static int check_after_split_folio_orders(char *vaddr_start, size_t len,
+		int pagemap_fd, int kpageflags_fd, int orders[], int nr_orders)
+{
+	int *vaddr_orders;
+	int status;
+	int i;
+
+	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
+
+	if (!vaddr_orders)
+		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
+
+	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
+	status = gather_after_split_folio_orders(vaddr_start, len, pagemap_fd,
+				     kpageflags_fd, vaddr_orders, nr_orders);
+	if (status)
+		ksft_exit_fail_msg("gather folio info failed\n");
+
+	for (i = 0; i < nr_orders; i++)
+		if (vaddr_orders[i] != orders[i]) {
+			ksft_print_msg("order %d: expected: %d got %d\n", i,
+				       orders[i], vaddr_orders[i]);
+			status = -1;
+		}
+
+	free(vaddr_orders);
+	return status;
+}
+
 static void write_file(const char *path, const char *buf, size_t buflen)
 {
 	int fd;
-- 
2.50.1


