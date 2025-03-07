Return-Path: <linux-kselftest+bounces-28515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5EDA56F61
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2BA3A823A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13524BD14;
	Fri,  7 Mar 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XjyP7AEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0B24A064;
	Fri,  7 Mar 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369232; cv=fail; b=Q8yl8bvcCyvjdSwMk+RhMV0E56X7G40In7NQaGfh4gy25M0sQCIcFendHH4TOn+N1cUF9jVmM/ko+xCXYnnQOk7Sw1uqqeAI7nsdZjPaPKuhzKe5OvWRht4PZ6rnvfF2ZTA7u0Qar9pN7xJ9YmeK8idg4fBsysGMRHYa4ubHyZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369232; c=relaxed/simple;
	bh=rK5FxFUCiqr/kNo1/s35mPNSAvr7gqAFrbgPGyNZrZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8XQASf9lhQFqEsJogBMAO2gg1aq7c9swbOYVXZ1jYPVmtTSvKbLxlhhv4w2SwR0Iy2MZHEO/NJSwt7CT27ONybZQF6nUY/7HOR0tvswvsX+WrZiWSOrjHLWJekpx1DUBGyNTgxvlKzW3Y0cTCfB5AJjoZut0rIp+dZ7slOuaxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XjyP7AEy; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM3o527WkgmJENLMFx/8bAnGAowMQdBRC7EurgepFuGCplQSY75GdQJKoLghPT87UD9GJpFKhmqcjVo/KDFYPhEC/DBO+G0/9XBvb/mZMtYIKyryLY9D7ps8klyFg2B7hAuxcLEfZtprqyw8pTqI1mhbCqI482Lshh4hTRZnDQ56Nu9ZVIFoWsxZK7fjVS689w6PnSFN5tzVWIW1MnsAPifT8FCBDGvvIOqV7fixLkQkR3sgbsur+5QlzpcafYD7YcfI7Zc4ptkUspzYTdS5Xbdd21aUDGr1X7+zZUrChBy+JjL8300QglG1maQFUtFBa+dtaGr+odMgGxc6Veekmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O6gpyeI6VrnpSWocOraOLupk9fA1jVzX24L3jF2o38=;
 b=yEQtsOPmhTYGaVTcLFs9SbJ5GcNWWoeZEWw9kYHty1ydgLmTTAxuEo49+qj3wlw5jalJZFm2jLK8wgDQCWqdrDOTFp036M2cUTJ+VR4X2hAp8WM7T3pqha1ZTH7DLeUKmOsLRv5V15LmUbZD3YSnr14OBUGI3W5q8LgQhBA47Ln3C7syZWGeEEiwxYaYbny2sffKQvBDBD3JGUVR2K3C9a6/1H7vIwiUloCtw9QDVJXRZiVM+aJS4TPKdDbUcocbVWhPock5YGbOin2DCutCV1jCm5a/D+HKrIGHjU31bBLpxTEztnGr+0RfugUQFvEIWpx2sKZStmY95EKzJeZRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O6gpyeI6VrnpSWocOraOLupk9fA1jVzX24L3jF2o38=;
 b=XjyP7AEyq5o27oa/8IzLwphWUr3qwip6e6aLNQVGFXYfEcxXCMfmTr/ts+6qOCPh5lJ8k1c+aiTvqNJvLdAKCYPCm/yLB84pRiMRRkUnH5+7q2Gnt5pWheqFrJ/k1x0WQVdsTDyFEl6XpnS0o+Z4XYxxFIZNnj5V7G6xUDr0BHr9o3ovBWbbfVRchlsNCB87U00vBIf2eYo1QHJtYqaq6zfbOWO+5ICo9Hwq1M2G2LM7gMDnoUr/YVFaYpYxP+A8w6OavVDEAw7l1+l2fTaJT9fyfLusPMmWiwhqz4FVuOYO3cQk/TyYkSjX+P3mJFwuRkxwyyJC+ekSTFrp4K99CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v10 7/8] mm/truncate: use folio_split() in truncate operation
Date: Fri,  7 Mar 2025 12:40:00 -0500
Message-ID: <20250307174001.242794-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:208:32e::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 47863168-e15b-4c6c-8039-08dd5d9f201a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RBKuPU+xsE/xSDuQYo8WPIiANepTIwg1Ot20OAb/3ND5CUgpHnyeyUy8fGYQ?=
 =?us-ascii?Q?Q9quUWGgBkjdSbuD48dyUR5UsExdYuV3800O3QqPllK6mNgYsMlY835U3XTI?=
 =?us-ascii?Q?h632zD9eUUJKP68id7FZsgRW8mFN7I4ZL4ltETuD6TzIDckNovQhL2GVSWSU?=
 =?us-ascii?Q?ruW+Zl/LqF/p7X+/XO5th1YxYDVr2OqLTqnMEvPzWp6GrSt5Sv4i1blxvSC1?=
 =?us-ascii?Q?005kpFJwfSK0J8ofkZJe2tYNX6GZP6jg52I6SXERIchjLxKe7HfGF+KC1A6l?=
 =?us-ascii?Q?NbcdLefyCOEKrwUoDaxsXZIoM2/3cM+OPPg6CHO0xf+mpobweQTsYVdvy5Hz?=
 =?us-ascii?Q?0bUQtC3+oU0syVQyKRFlg1N8mcAMCBM7gTm91bGk58iPZ6O7Drfqh/So5krN?=
 =?us-ascii?Q?wXzUy59HhsGrHQOptCCnTzmHuqrnF7XghkNPkJmNyhIS/Hdq7sC7K5UARLWk?=
 =?us-ascii?Q?wJZSdh4NjH/92s3piscG4/o2iatWqEW0oiGdGGlX78cFYQN7xHdqy3p5ACVW?=
 =?us-ascii?Q?/253g3Qpl7IOMeBZHlSR4lZc1uwXD74zA+isgRegQO7wNptBTJYObw/XcFNQ?=
 =?us-ascii?Q?TTvsJQkxEpeAi2Flile7mEKBmWSB7SUx7FNZklq42JK12xR1CF+ARiVPiK1A?=
 =?us-ascii?Q?i8T3NOJMtRRx1F6tkREHKvWLXNrwwQOC7PRM94InAVskeMCHpnKZL8EG2W0x?=
 =?us-ascii?Q?5W0tnIcE0ZKzi20WTABbtMD8sq9zU9bgQa43fdPNobK6hb16IWf8h9jPU+FC?=
 =?us-ascii?Q?Tc1OmhezNY58AD6ODadNZnQXs+TRh5Ivwa3Usk3fTJJfTy0HrHT69ASrGKEv?=
 =?us-ascii?Q?GEUbLz4k85BdqsQhrnYvr+DxHbHzgCfH8b2EejOhqWjlrmdf1qsSSExw/EGy?=
 =?us-ascii?Q?y9PGXrRLRq48dUt4h7tCoDPqkOlfXCSs50paXC/SyLTU2P1qeX8iuhxOKJty?=
 =?us-ascii?Q?gC8X8KAP1cnM8U0IC5qFJINdukVQxH/mSb4ps18WYoVMV/v9eznz+8Mgfrw/?=
 =?us-ascii?Q?rBfpknL/29LFPZLHN3oQGEDss/vUqniiMnbs6D+ECNAkAEG0+W/IokO95rgY?=
 =?us-ascii?Q?6FVIzkq7z+WNe2P/VCMNxHN2yVoSrk1vIKkyMP2EWxRD1kQoip6hTPpOI3xm?=
 =?us-ascii?Q?e6Q+xfIVK6x1KRpyC92dig4hW0Zgeh/UUm6v5iSi+DSbAGULpjkFHWopLUV7?=
 =?us-ascii?Q?fuh63aI8wx2v7AjGzOSAdpc3oMUUTjM/iC2+VEXl3gpnT0c3C24JSuyZtKzg?=
 =?us-ascii?Q?ekMHUWNM2CjD6Ejz5QNfbSN8zuuYd1NOV6z5DGznRjCz/mkGX1yvPGQNz9gn?=
 =?us-ascii?Q?sjzknubEKmqYKXsNRHwDmHhhGwyJj8cQwcbwf98ruLBouQ244UXs18fnu0dH?=
 =?us-ascii?Q?kPIxCSqHVwPX3XptyG6KSYd+b0VS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDO7nzWu40KlzhuZHLZOfYunBTP2G/xS5S0ussQNqwzmLxJFBCnsnNu+Y5CM?=
 =?us-ascii?Q?MHQ64W1hnmL7hstcrbZJtA2352uUyR6VTpeHbJuCji6iOuU7AnEruUnCm9Yh?=
 =?us-ascii?Q?bGzQwTkZfwyxlJDnhqJ8YXADmfq7ItynsY7KxTW4W7ldVhP/eRaZS2B6oX8Q?=
 =?us-ascii?Q?r0gjYzPwr11BePCuyO71jrErEtWCglvYroSlj5MMpNDjwpUtyn3RqMS9JtWD?=
 =?us-ascii?Q?N1S554hYBYDNJFED2TtdsUjdaMkFkptS25hzftFZ6PTJsGR352GXRT3W5HBH?=
 =?us-ascii?Q?tvATj6/t6jldspIpk/x6D2Nq1i8uDXFHZBOD1tMbJdiob97+J2WDIlPiqFDu?=
 =?us-ascii?Q?9NKhBEZWVs0F00H8uylHu8uFOhRVhvdCFzzUHzhtv39pwIDCK/YlATCxgYs0?=
 =?us-ascii?Q?y4P4hhZW3N5aZ99j1itUsiFAGNwNRYFqv8kUmLO4HpjAaPQovhjVcsdl8pgo?=
 =?us-ascii?Q?Yg3tZBiQbgeAIsTDhY48LMJpVuA0nk26JMDz3y/axSvyF7wvcjiXZmczPYvz?=
 =?us-ascii?Q?4M4+pfv7WMw9CBF3vfGWWZKVvq8iJaHGSqeiaCGO8Bht59wssPRSbx/wevP6?=
 =?us-ascii?Q?OO3FkeWwr0l9cHQQPlwyXLcx15rimInkcieLnOcaoUTE62o97HTgsFrutxrK?=
 =?us-ascii?Q?hOUwdaSOWkAn43PEXMhd3AC07R7zFihtsubRk8ErIcjip93AhiUDtjzY6t2J?=
 =?us-ascii?Q?I+Njlt7Owl3fKNU/UmJ4YX1OdbLF5NytIUPSE1dWef/U+ZUSDqRVWhnqdcz3?=
 =?us-ascii?Q?CGf68evQbujKYctLO0r8CEljHfa14t9vr9rW/H+Sa/yiOty7fPXcnwgyHIG5?=
 =?us-ascii?Q?sGTOzv0HWjxOP6z+bRL3O8QLdRRZMLJDxmli5PwnzxdYFY7f7bpxITlCotxO?=
 =?us-ascii?Q?e0tGEqVShRfS+BZ4thQ3GrBkdXn/K5GHXeolWgjheAbYJmrr08r9bmXcFnY4?=
 =?us-ascii?Q?zIZdLOvokDC92pW3rQaAKGESzuu7wjiMBqrPE5wr12AQKtpdutNzZJg8tHx0?=
 =?us-ascii?Q?mrjWho3tqDVB/i/f/wWVUgj+2pBqJXQldh622EsvU4ZyLyVkwkVrqSinNRLD?=
 =?us-ascii?Q?U8br16bh9X2whlLSryOYU2Y44KL4f8Optp27CQrKYh1dlWVNkZ/ZZ/6gCXuC?=
 =?us-ascii?Q?pEcXQeYm6ApcZnO2wpBMYvGfXmrgYyal9jz7g6tDNihoe5HpAYl9pwIYNwww?=
 =?us-ascii?Q?tSM8wh5sqrZK3hXRxhwSLh3wDZxSRGoSXINrlHnxg9ARG1JcljryFVe69Sbs?=
 =?us-ascii?Q?hPqtpfS2RHmnflkhxBpZiJTdt0NKkdGwEbhzYjq0uXsraPLFmZuCqi4ope7o?=
 =?us-ascii?Q?cbxAGmKxSYlVToOpQAYWuafXJ0oI0xCt5XlhMPWp3rTuz8BisvSxx+BIXMJC?=
 =?us-ascii?Q?qo+c4/ZJtI8hTDgkGpqpbtzB36y7TLJfs5VfxbEpTvlIDguqxJLZARqaj95U?=
 =?us-ascii?Q?9buChE6zqYxEy2HyZKoVs8IlrQQMxqQEaIdMM4K9qcuQpAny/NPoeWEz+KVq?=
 =?us-ascii?Q?XcH5jgUZ6jSfdELXfEGeqapLf0+NyCrf9u1m5Q9G6Wj1exQTVWR5hh8uJuwy?=
 =?us-ascii?Q?EW5vKWJpCGFxBM8OUEMpTXHQL29CklKHmyIB7f2n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47863168-e15b-4c6c-8039-08dd5d9f201a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:17.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSYSPo7n9A/GQdZgPR/0GdmE8DPAQ/ClF+L25PjquYTMEKZBasmMwUAr8QZefZXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Instead of splitting the large folio uniformly during truncation, try to
use buddy allocator like folio_split() at the start and the end of a
truncation range to minimize the number of resulting folios if it is
supported. try_folio_split() is introduced to use folio_split() if
supported and it falls back to uniform split otherwise.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio at 3 to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10], then another folio_split() is
done at 10, so [8..10] can be dropped.

One possible optimization is to make folio_split() to split a folio based
on a given range, like [3..10] above.  But that complicates folio_split(),
so it will be investigated when necessary.

Link: https://lkml.kernel.org/r/20250226210032.2044041-8-ziy@nvidia.com
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/huge_mm.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        |  6 +++---
 mm/truncate.c           | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e57e811cfd3c..e893d546a49f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -345,6 +345,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+/*
+ * try_folio_split - try to split a @folio at @page using non uniform split.
+ * @folio: folio to be split
+ * @page: split to order-0 at the given page
+ * @list: store the after-split folios
+ *
+ * Try to split a @folio at @page using non uniform split to order-0, if
+ * non uniform split is not supported, fall back to uniform split.
+ *
+ * Return: 0: split is successful, otherwise split failed.
+ */
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	if (!non_uniform_split_supported(folio, 0, false))
+		return split_huge_page_to_list_to_order(&folio->page, list,
+				ret);
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -537,6 +567,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d44b6d4b7f32..8a42150298de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3648,7 +3648,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio)) {
@@ -3680,7 +3680,7 @@ static bool non_uniform_split_supported(struct folio *folio, unsigned int new_or
 }
 
 /* See comments in non_uniform_split_supported() */
-static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio)) {
@@ -3999,7 +3999,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
  *
  * After split, folio is left locked for caller.
  */
-static int folio_split(struct folio *folio, unsigned int new_order,
+int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
 {
 	return __folio_split(folio, new_order, split_at, &folio->page, list,
diff --git a/mm/truncate.c b/mm/truncate.c
index 0395e578d946..0790b6227512 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -192,6 +192,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	struct page *split_at, *split_at2;
 
 	if (pos < start)
 		offset = start - pos;
@@ -221,8 +222,42 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
+	split_at2 = folio_page(folio,
+			PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
+
+	if (!try_folio_split(folio, split_at, NULL)) {
+		/*
+		 * try to split at offset + length to make sure folios within
+		 * the range can be dropped, especially to avoid memory waste
+		 * for shmem truncate
+		 */
+		struct folio *folio2 = page_folio(split_at2);
+
+		if (!folio_try_get(folio2))
+			goto no_split;
+
+		if (!folio_test_large(folio2))
+			goto out;
+
+		if (!folio_trylock(folio2))
+			goto out;
+
+		/*
+		 * make sure folio2 is large and does not change its mapping.
+		 * Its split result does not matter here.
+		 */
+		if (folio_test_large(folio2) &&
+		    folio2->mapping == folio->mapping)
+			try_folio_split(folio2, split_at2, NULL);
+
+		folio_unlock(folio2);
+out:
+		folio_put(folio2);
+no_split:
 		return true;
+	}
 	if (folio_test_dirty(folio))
 		return false;
 	truncate_inode_folio(folio->mapping, folio);
-- 
2.47.2


