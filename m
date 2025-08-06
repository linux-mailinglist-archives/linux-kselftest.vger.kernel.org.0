Return-Path: <linux-kselftest+bounces-38349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C67B1BEAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 04:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666F816E637
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 02:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAB1C862C;
	Wed,  6 Aug 2025 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WMotqssn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0D1B4153;
	Wed,  6 Aug 2025 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446863; cv=fail; b=MPD/qqWMwQg1feYoLeaxneuoJvjdHApIUGtAddPJ2iYTWrls/6TYF5czCib2dOKvG0+LFTYYIVOb3xrRUW3Q17PTaPldogVAk8MMFzJsqGQRN6/v1DGDDn4cNJcWQpGt9Qz/UlD/xmbOD4aBuTJgAu5/rmqaBFmTCwIfXnw4J0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446863; c=relaxed/simple;
	bh=LusOZ8FSmYVlzJ3dzPGxlqmy2OcerqYqZwlT3YqfjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pyzYi3ObBUBF63cZm6R5w1oPSjuXFmr4KQ0IKFdK8FQBa7o1B7pnRXhh6no7ru7UIhpsCAbQ7Z0UwUpMV1gJ6WPWQEuPoJfGnnxBW8uwqq1GBn3gi6xUfUQEphuNCqTaIT9aWS7luicH1+rwmB2AFfvuZmOHdebAOBw994t4sRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WMotqssn; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvQUTQRGeG8z0LpMy5ZueV6JQ6uCrFEHulPFLXoSluT/fh6AlVIgIj3QBXnSjhjPl2LFfrQzsLi61uqZkLCH8PCQVxmJ6/LcJ0Wnw0hb9BG8KvTWWLN8rsi2NmSUusTW5q4Ma/7qU/QWsehD5F7w5NpezlRSH6ddNiAZNX1EFXKkPG+2n36AxSDnH3qK4Dmk0NyxAQk4/j4/UoEjVb5NN6hYXlCzVlJBQ6yJp+CVbfj6VfcwkjPv+3meIYuozW0TpTJSvHpiyB36BgKi4kwDWWTm4VhIp2R7svUcGTVtUXtX5lja/fd6qao7bNsWjHPGP7afqe2qosax8HYFtqTuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPTuyfRqAgZZTE07VaVlD3ntF1e+mEGxEgEf6gaHaWI=;
 b=uusNPq0KAf3O7B0oZiyai2m5tDvbHmnoykmQNW5/MA4ziwtjyafN0r8cqWGyJXqzUZRrMbgVQ5yBxPdnrYCR21h1bsPI2jqRh7izxRWrA5DnXE0SlmJdhsOQptCGW1KbgZYCBFamq/M94ZEbjfwlpWPHRpSUy/glwU3xI2vrcO6z/D/j2oekHhLeNiUXV+6wRRITOxxnVm2G18aec1VcrhCwEcNgG+Eg6tV9DvH9vHDE78+XDBpahVlzicF3H+27NxOijEqc7pHWG29ISnMVILM4nE17YZ/3wLJJLD8Y7G9HjSDMlRJlJTDbG/1lWfx0yiCWTLHDEBzTWBIbvCFfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPTuyfRqAgZZTE07VaVlD3ntF1e+mEGxEgEf6gaHaWI=;
 b=WMotqssnMwNUsTMIsuCUTcesTTVSYM/0JDJGf2ig7dqRKWgOZgJxoVF5SZbw595K2VFTHWEiVK/jJykTzSkU+/gf0fspkLtv1TmMeA+zopaNQIln5I9jm0KgTDZr9WlpfxgbfAGXyu4AeYrH4aJ8ikaLA5ORt8SGncEK3BxfkxxPHzmAeyp8eFccl2TbM20mFOdddHLldCuJCn3vg8TIwMEChUBsN4DdSsprchIlaP8KS+62l9tXxMXSzCqgNK+Q0QXAihu/I0EmkE7cSh2i93HYx9bkEN/FOk2rUjAhWMySuye6dzu3QRmybZNZNbng2ZiQ/PQNN+4vkBI75RAYpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:20:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 02:20:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: [PATCH 3/4] selftests/mm: add check_folio_orders() helper.
Date: Tue,  5 Aug 2025 22:20:44 -0400
Message-ID: <20250806022045.342824-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806022045.342824-1-ziy@nvidia.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: eedff53a-c903-4b6b-d4bf-08ddd48fe154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mjMLw3PdDrSbBREeb4IgnPHR7dEOHtUtISbOYhGy203xW7geSuuED7urZFhE?=
 =?us-ascii?Q?ugXbuLi3HBDPrdOfyc4ym6wWyNGNk4AUqtgA4dhCnUXyfCDDLylYj4JO2T/A?=
 =?us-ascii?Q?bSCyrnIXND4OFA/o9MGPcSvCkxcdsF7w/3IGM2xmezvVJ5VghyecfsD6Xu80?=
 =?us-ascii?Q?LhS8jadm/XwtOZdgmUndJLtxBpidWBXnI4drQAKYY7M0qKfAjSoynmS/CEEv?=
 =?us-ascii?Q?1dTWGQyhXS7rS82/3LvWe2oheomp/X4vhV/6vwuu5hFYx1TbNV/X3WWYkrF7?=
 =?us-ascii?Q?0J0Bk/nFxB6JX42AloQz7wjEyaFZklRZYpapCEX/TaAL/MTgEznmMPLNYx6q?=
 =?us-ascii?Q?+Y10ceAX5bnwb/ActN40Ydo9hZmzIbcZVRinCfDXC2grwl5AYWtuC8MPK5QD?=
 =?us-ascii?Q?Lu8GvMqK5R+ey1O4SDya/tPyMZyaGDz3IEyjBjt3jxU8XSd9Xmc6hGV41Ofz?=
 =?us-ascii?Q?auRvy8hQPejbzWHaTR+k92dce18U5QBkQD7QQfqwV0tMebQPEjeXM6QRkcQW?=
 =?us-ascii?Q?cgvdKax3hwVnvl59PIU6o11YBYLw1Dso91pc2c5l3N4wrisF4gWa2PzNb58n?=
 =?us-ascii?Q?/PHdprl64jb6a6HOZjN/WVmJUHM7MbHnIhtGh7W8wu4+iOLDFqaXXlSGUDU9?=
 =?us-ascii?Q?wbG0RYwy1n27dO5IBHwBDcBEjbfNjVW49cUvKymxa/a83slKYOYiaf2rwDvc?=
 =?us-ascii?Q?TzYUBpUkP6Zv66L8S80sM0HiyICBahOm1piLKetHsFs+PI7bCLf1qdQXUHvv?=
 =?us-ascii?Q?vZLdTB7hxWwFNZz2KC9YJIISKDWBKNRHGCb3InO6UZX4jQ3/qzYN1y9gik1E?=
 =?us-ascii?Q?YSN9F3WUkZPxiblfn5Ch7MG4beYUzKZj76BMAld9xKJk0gIKhDKS04AMgGC8?=
 =?us-ascii?Q?ZT4GkIpzUQZ0evepgPkSW8GgjM3HaKLQXub/QkU1pbfXUu0z0XHl6TIfFrLC?=
 =?us-ascii?Q?Gu2Tp+QFrydcK46MzZm8+UZ8ScoNtaZY6EDtsb3DCibfvi+pOcfTBO4sCHe6?=
 =?us-ascii?Q?VAMyN+85Q/p0DTKCQ8i/koGvRKnpoDc2e85Z6/EdQqse9qeCo0xnGbHKHeAP?=
 =?us-ascii?Q?Ms8jgq5gO+a7GPh6uvXyR4zjvj9mixAksXJyMBe+RMHaxxz0N53aR1Sbk3r/?=
 =?us-ascii?Q?6WK33nUbipuHdRRhdJMXOd3uMRKNSLEI+/TntIi/HGAAqquChdc+LyFdKGJk?=
 =?us-ascii?Q?g+bW/eOf/DAfkWTSnUhBtQm052zcg9e6IVuDo2RmlwXTBbLbC0y0Sij5S0LU?=
 =?us-ascii?Q?EmKwwGCAN19/LVMvljcVVQ+1wxaHRLnPSxf3AFoo/TDjOsxi7hZv6MxPgUZi?=
 =?us-ascii?Q?6CMJ8npImoayoa0l2BZceFMqN4g0UqsN7xunRlFIls3yhBXfv2R1N2IuyyK8?=
 =?us-ascii?Q?Z3IKraNhS8QcynPC2EVZ+M1d3KpV94i/aylbmqO+3aoQLNbNp3vEyCA018k8?=
 =?us-ascii?Q?dlr3a57Oeew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1dDcKMuttdb4i7knac5UteecUJXgXUuta9oCamxai2IlNJ/GkQSKt/W9a/a?=
 =?us-ascii?Q?JT+8g/fpH+wBvNAacaIpZivSzG3KV19yslS0UhKTbx6tbSHArFI67TaM61V4?=
 =?us-ascii?Q?WYTUSNU165P+ERoOHz7MpHDAA/XezNdSXnFTwn2XfNM67kCfoZkLNyv89hvH?=
 =?us-ascii?Q?k6wYMGCANVmOMuTWcr+U3eFD+baSWlAYmTXolRlkQxUkKwXjLR6ObD0c80us?=
 =?us-ascii?Q?qkhCPZPom4hWJ2+9i1yskWgfITocD54FV8JursFitekoM7tSmeETUNBQBJ30?=
 =?us-ascii?Q?pPGQcy1jWwM23ia9h99XuFO0lrwcUGzN43QQPYZ4dtAHw9F3k+f8XkB7hU1+?=
 =?us-ascii?Q?2hYwqpR+QfrYji4FVp7WnmpE5iSiN3LDNUaPxWtda21KiAWfB4FJSXHmhna8?=
 =?us-ascii?Q?U5gssGq6voePMtyjSOH1yYPhrJnC/8SUwYHroHN9m5kXBU7VXkPzcYCu9Jfo?=
 =?us-ascii?Q?1VpNaJtIaTtJThSD9C6k3x01Q7QvM0QFOKQ1QrIEFjarhQvVYCAuDmhzD8FC?=
 =?us-ascii?Q?jdQ/fArLzconXxHEhgyKug+MbmMXDrUKmopQltoueqXSkvkgZHzpxYNaDmY9?=
 =?us-ascii?Q?SttdJkfsqHBfCwG76edr69vpeMBH9viexoVtx8ifzogoWnjVF8If1rxwlsO4?=
 =?us-ascii?Q?uu2kPmUNxbag48Xdaue1RfGM7utUWIN5iyvsYnGoSTipBsTPON4QC82vFNO0?=
 =?us-ascii?Q?bJ6qD7BE1cZY1cpn1C3nqJ1MJ7zvdd0qYB0rvtshMH/o8gsSuK8oyTG5idg2?=
 =?us-ascii?Q?KNEH1BMzITheqYmeNNvkqDJ/YBi6lChRfS9R2bWLkVTeW8faunmzhIcuAlhM?=
 =?us-ascii?Q?XyjBghxnCZwp8kdHqZ2tnwO6XuiRdJd9PSPPbN820hNHsBkNPKxRGTMFVk6J?=
 =?us-ascii?Q?NPFUhlDOsH5a3ikGwr9hLaA65HnFuaLdtlATCvYjO7mAzuascgN10ozXmSvq?=
 =?us-ascii?Q?M4Zq0vXukkbqczQns1rQiwGP1EipNbPUo8+QVXHLQX6bHl8xeQoLvHWSF2h+?=
 =?us-ascii?Q?0HbBlGVmHIQGIeYf5LrYEXUSPeYBAqv3/vKtunKXVv+xGwD9hszdaoEIMXvH?=
 =?us-ascii?Q?kAHKSZaigcKSGSfQJMVEa+mAJR0JPVaypM0ID0UZfR8GwzCOPRApPSCjH+wp?=
 =?us-ascii?Q?9fOIIWxfFk+7roz26HSIIes20iB8JZMnJd4qmejDs/GJggySMUOsNV2eX3iP?=
 =?us-ascii?Q?Xyd5/FDkjBdUCh50w5YMNiP7Ldl+lhFmZX/vKY73ti0wplICK6hEQGjHT88R?=
 =?us-ascii?Q?F05EFplIutZgR8SmIhfKtc2VJ1tKVl6ygpU5YjIpduXpw/b7oZxBs4clvyuh?=
 =?us-ascii?Q?F/1BR5oCI+cQUPk7ph7v/N1eA1lzmnkEvu5Hi57dZoxIf/dSTcUt93ikYmMi?=
 =?us-ascii?Q?D9CeTfkJXAJYP6/KCp29i5bRIdmIi69UfDSBslEI1uv3isj0vzWdpi7yV9Nz?=
 =?us-ascii?Q?wgdnxMeqLO53LKII1N0HZuutsoKXD0Ng11aixJDplwbF6WEQllMgqCganCRS?=
 =?us-ascii?Q?ciXQZl14AwxFzGa1zblhjuzdq6urPxYRG2cMICwvkxSYzVSASKEG4qm4FcHm?=
 =?us-ascii?Q?6XW/bW379v0simWISOom12g6GHnpNZykgu4panjX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedff53a-c903-4b6b-d4bf-08ddd48fe154
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:20:58.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AdU9m5km2iBGS+7wx4KPck89SaUxGP3UuEuq3yF9YHkqg3Tw+beA99/V0V+yVo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

The helper gathers an folio order statistics of folios within a virtual
address range and checks it against a given order list. It aims to provide
a more precise folio order check instead of just checking the existence of
PMD folios.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 tools/testing/selftests/mm/vm_util.c | 139 +++++++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h |   2 +
 2 files changed, 141 insertions(+)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 9dafa7669ef9..373621145b2a 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -17,6 +17,12 @@
 #define STATUS_FILE_PATH "/proc/self/status"
 #define MAX_LINE_LENGTH 500
 
+#define PGMAP_PRESENT		(1UL << 63)
+#define KPF_COMPOUND_HEAD	(1UL << 15)
+#define KPF_COMPOUND_TAIL	(1UL << 16)
+#define KPF_THP			(1UL << 22)
+#define PFN_MASK     ((1UL<<55)-1)
+
 unsigned int __page_size;
 unsigned int __page_shift;
 
@@ -338,6 +344,139 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
 	return count;
 }
 
+static int get_page_flags(uint64_t vpn, int pagemap_file, int kpageflags_file,
+			  uint64_t *flags)
+{
+	uint64_t pfn;
+	size_t count;
+
+	count = pread(pagemap_file, &pfn, sizeof(pfn),
+		      vpn * sizeof(pfn));
+
+	if (count != sizeof(pfn))
+		return -1;
+
+	/*
+	 * Treat non-present page as a page without any flag, so that
+	 * gather_folio_orders() just record the current folio order.
+	 */
+	if (!(pfn & PGMAP_PRESENT)) {
+		*flags = 0;
+		return 0;
+	}
+
+	count = pread(kpageflags_file, flags, sizeof(*flags),
+		      (pfn & PFN_MASK) * sizeof(*flags));
+
+	if (count != sizeof(*flags))
+		return -1;
+
+	return 0;
+}
+
+static int gather_folio_orders(uint64_t vpn_start, size_t nr_pages,
+			       int pagemap_file, int kpageflags_file,
+			       int orders[], int nr_orders)
+{
+	uint64_t page_flags = 0;
+	int cur_order = -1;
+	uint64_t vpn;
+
+	if (!pagemap_file || !kpageflags_file)
+		return -1;
+	if (nr_orders <= 0)
+		return -1;
+
+	for (vpn = vpn_start; vpn < vpn_start + nr_pages; ) {
+		uint64_t next_folio_vpn;
+		int status;
+
+		if (get_page_flags(vpn, pagemap_file, kpageflags_file, &page_flags))
+			return -1;
+
+		/* all order-0 pages with possible false postive (non folio) */
+		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+			orders[0]++;
+			vpn++;
+			continue;
+		}
+
+		/* skip non thp compound pages */
+		if (!(page_flags & KPF_THP)) {
+			vpn++;
+			continue;
+		}
+
+		/* vpn points to part of a THP at this point */
+		if (page_flags & KPF_COMPOUND_HEAD)
+			cur_order = 1;
+		else {
+			/* not a head nor a tail in a THP? */
+			if (!(page_flags & KPF_COMPOUND_TAIL))
+				return -1;
+			continue;
+		}
+
+		next_folio_vpn = vpn + (1 << cur_order);
+
+		if (next_folio_vpn >= vpn_start + nr_pages)
+			break;
+
+		while (!(status = get_page_flags(next_folio_vpn, pagemap_file,
+						 kpageflags_file,
+						 &page_flags))) {
+			/* next compound head page or order-0 page */
+			if ((page_flags & KPF_COMPOUND_HEAD) ||
+			    !(page_flags & (KPF_COMPOUND_HEAD |
+			      KPF_COMPOUND_TAIL))) {
+				if (cur_order < nr_orders) {
+					orders[cur_order]++;
+					cur_order = -1;
+					vpn = next_folio_vpn;
+				}
+				break;
+			}
+
+			/* not a head nor a tail in a THP? */
+			if (!(page_flags & KPF_COMPOUND_TAIL))
+				return -1;
+
+			cur_order++;
+			next_folio_vpn = vpn + (1 << cur_order);
+		}
+
+		if (status)
+			return status;
+	}
+	if (cur_order > 0 && cur_order < nr_orders)
+		orders[cur_order]++;
+	return 0;
+}
+
+int check_folio_orders(uint64_t vpn_start, size_t nr_pages, int pagemap_file,
+			int kpageflags_file, int orders[], int nr_orders)
+{
+	int vpn_orders[nr_orders];
+	int status;
+	int i;
+
+	memset(vpn_orders, 0, sizeof(int) * nr_orders);
+	status = gather_folio_orders(vpn_start, nr_pages, pagemap_file,
+				     kpageflags_file, vpn_orders, nr_orders);
+	if (status)
+		return status;
+
+	status = 0;
+	for (i = 0; i < nr_orders; i++)
+		if (vpn_orders[i] != orders[i]) {
+			ksft_print_msg("order %d: expected: %d got %d\n", i,
+				       orders[i], vpn_orders[i]);
+			status = -1;
+		}
+
+	return status;
+}
+
 /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b55d1809debc..dee9504a6129 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -85,6 +85,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 int detect_hugetlb_page_sizes(size_t sizes[], int max);
+int check_folio_orders(uint64_t vpn_start, size_t nr_pages, int pagemap_file,
+			int kpageflags_file, int orders[], int nr_orders);
 
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
-- 
2.47.2


