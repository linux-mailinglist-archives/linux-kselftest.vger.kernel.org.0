Return-Path: <linux-kselftest+bounces-11914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D439081A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 04:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B044284144
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1D18412A;
	Fri, 14 Jun 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZzJoLkAa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4095184108;
	Fri, 14 Jun 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332227; cv=fail; b=AcH3EkzFv2u8a2l2LS8iCHbniAnrARTMp9X3M+4CCtBoyB/Dwd3TaEN2bpbHN36yAp6BO36VJMCm17izqOBhFCkyu5/luomlroRTnu9D3/aw9m8x2qVAa+Vaqg8ouPfacdALYbPz2D90wzvnNugBDotX8zymKwXK2mpNW1RYyDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332227; c=relaxed/simple;
	bh=cxZteq0dC5JNyuYb/vtfehRaJNlL6iL3gBhYjxWOzDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sn6N7uzP2uWgxD6hSmo8eJ4GJoiFrTbM3w5DzrBosQPkIpntWwHtvNTtZ9zdFn/mYrYvhlE0gYJmQDRVJve6fz+EDcew7ygYffSXoM1f7iNjj/+/btXJG5BhbcH5n+GXDPpm0HyezOiR+UplllNgld1/wOIUTBpNTyFafA7HaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZzJoLkAa; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrlaRwCq9sGJMIRlDAlDL35Rs+Cobfnf9x1DPFxh0ndYuVcEh+HsTteZ9RtlpDKVKdRC0rgHQMV8Rh+FMmbzaHQCJCT7c/ZoxaKrcfjstksA9H/o8U30yyXHgd3foz0DlWz789r5/noBJ/ZLNLhUQPiaaxkfnlQAM/6wAGzTHwy/JHo1JhM+604qLaJ6CsnbevBDJ5/G+S0UgCJloPJmLyfveSqs86kSiLj0Flr11G+s+mzV2/k2IYOT7NcMOHXR5b9FwXsctyh6U+VqtXhLMiVpEiyEouW49Hl083y2+Vl8+TfUmds/hveHckqEpEsyZjBXRplwA9/2UlJkiuPlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhPpRj+9yaeRdjrqVKe2AajeBxh6x9UGdGkPrZPPJ40=;
 b=neuzttqk0Hav87amCCDqonemyxg+dPkVhgxgMgAEcPfwfwGonAaoIlplnAgjvBFTj22l82wfmoI9QHrmh1Yo5ScEdpdrRUtSu1Gy3Kh1F0hMAVggtVjktDtJNnl8gMXAPM+TV8GOhvXBgDsk6yVqwm9btYSBymK0B4J/O5tjhSkseW7KDuK0585eCQA8nI9aehKAQkZELLLXBTo/B+I6iCSYjB1w4fx3fhRVK2sLXeFZ8vxc9RNz1Wi0xwC8t5xxiXxZUxb3k65Iiqa8J4RDUZjB0jSKwJ7e/xuwmIs8WAdsV5E1FmoUbxKwHX01goWPNxqmYI355gVxs2DQc8OEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhPpRj+9yaeRdjrqVKe2AajeBxh6x9UGdGkPrZPPJ40=;
 b=ZzJoLkAatOrCA9jv8XrVLP5e25iqwhPyFljrlByBKPE5PP7mWgoq4rXdFF7ftuM2oCs10PPPmAMO0SrtKJLW3Srnz5eiAqgLuPx/GyqqnFJS/KZKHLdI2S1u1BocOr4uPyJePSHG/whBdG+LTxo3oT0XTMpjGeh62qyGqUoierHryOYT0dG/CIzF/AagaF1Hh6tuvoXxDWcGAjQCNdrvSogZqAfUqY+3MT878bCtt+f8eAcrZWSoSlC4983lIrFc1cxRDcaR+9J82kfwXzodYOtVbssyMBI6JNBZ83MRl3AABl/Mll7IrkWdi2RMrT0oADJtAq3XLXRUebStvg8Atw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 02:30:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:30:15 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 6/6] selftests/mm: remove local __NR_* definitions
Date: Thu, 13 Jun 2024 19:30:09 -0700
Message-ID: <20240614023009.221547-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614023009.221547-1-jhubbard@nvidia.com>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e2e3b4-b642-4139-3379-08dc8c19ec7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKWx1pAaLwP82DmO76g6nbLUUTTJ7KGseWUTV+X0IGKwp8v0e0AyMCM/FDt+?=
 =?us-ascii?Q?g6ZEDCaqNwOv5Qq24WpMOSbJaUZcZ3PSz+UQqzs5e7/S3vsloijaQUJBxMMu?=
 =?us-ascii?Q?X8eNgxAbO0xFNbfymoLEuJJvgC/Bm6cFXDDomgRseiAvJEoqQEpRdqZmo7vC?=
 =?us-ascii?Q?e1DpVmPjyrlcPnmL1ij3y721Ihu6fy04Q/JZJiezIcqSaEAt344h2PwxE0/0?=
 =?us-ascii?Q?QuVIGAJpPEP5baVf9YxHAGHcmt80qt+QXpokBW1YDdea2y8+CkVZeiDNnMlP?=
 =?us-ascii?Q?NqAVaQIDCHqe46Avaep6GSFI2ABw/hHC4LH7X64Zeo2G/N6f+b9jvwMRb9Eo?=
 =?us-ascii?Q?ki++tI7u3mRfU+dpEMC/GP0f/zpeLcwWejznzHBzIXoDc2kQ3Dvnab+0O0Jp?=
 =?us-ascii?Q?jEBV97DzR33KeFAPIAloYojcny2DV6NTrQJT6Gsda/4gl+iyXbTWsueculM8?=
 =?us-ascii?Q?L5lIXUAIO+CoYUjEMiHs3Kilfs8zGkc2UsT1Xi82t+IiHejUzw3Kt0nH5pjZ?=
 =?us-ascii?Q?vRAGxpxOM4LZ1z0uwmTWGp1mGQLa8VkrknYY7uQzY9TX2JooqEcDBppFXTbk?=
 =?us-ascii?Q?roVXLgKUd6rwzD3goGibFh0g7Ei/aGQkAHmuSeCqjxbppVAuYUG1ZYt+ZjAh?=
 =?us-ascii?Q?AeKUFaWb7PcD7FdfRgbAVNFMqQBr0huMtf2ddqS/fzIPgjOJtGq2FtduGuBZ?=
 =?us-ascii?Q?d6ITKQrDuLMDa4pYwWOJvcrim4UNnMgdwr0LXYlWCeN0d0FuKqx+3OtqglMj?=
 =?us-ascii?Q?wr96FXezWO3CGQVXjTE7O+CKK3SYJOfLkTdn2jK+KHE92pi75eOHPF7kNwka?=
 =?us-ascii?Q?f6foSjXRDz8yluXBI4s+voXU0quMSMWPg3zyPdQFHk6C3lfTbreUjFvNk8yT?=
 =?us-ascii?Q?vjivS8O8lBeGn+BMWBWjcMkqbeJCqQWM9iWv8XZ1V80ON06N/+rfZafFaQeV?=
 =?us-ascii?Q?K9vMxvtlclJ0gvKUpihpWs3DO5RpZxSEDEja/9UjDEM/90IeCSiMROB7A3xB?=
 =?us-ascii?Q?NIJgRsj4ny7WRO9IJaR2PcVe2w/EpKpWzncJtwnEBuNMNAnlMyaTT9YMRD5g?=
 =?us-ascii?Q?oklXM2s90UHANNp9M0yirHQ3BdiAINBfDQiYyAZfVEcJeFAkjKB164+aZSeK?=
 =?us-ascii?Q?ICkTEaNVH1N3g7MqjVVykwpY1Mcgnd6Rm4C1UTpFRICNEKzRnsTbnLPGnB87?=
 =?us-ascii?Q?MLo7qMejO7sMrU1CTUvHye8w/qZSMrUhJwOKs2l+T4XtKm3BfljSV3SAIPR9?=
 =?us-ascii?Q?UoPSz5E71nxQwV/a9vc6qOiXvW8xqDrh++Tj3yFiFDoVlR1fDGsTRu9t38VM?=
 =?us-ascii?Q?AI5QIrz6wMEWuz++nWp3kMXH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0Q+qVAedrLV9rJkHNTZYKFYbT2NXzZ+OCLdZm9iu+l/TBpmUhqoSuuy2It/?=
 =?us-ascii?Q?B7CA/99pTuAT6lwkXlUDGzXSuX9NFcO5k1qIqji82xlYCQm3r5y326J/yifB?=
 =?us-ascii?Q?3rbN2XnTeLzvrRgPGWp2AmFT4UqeE8i8o8dwLM7oLW9oWuCyWVznVAWdrRxf?=
 =?us-ascii?Q?gn46/TSMlMA/K9I43WgxFXDh3GmFvZrDOG01oj5rY02t6NIeIpUBmifIjYDK?=
 =?us-ascii?Q?Vxn2wBw0Y+KcPI5CG4DV2iU+aBLroiG157d6ORFQa9DDgOttKEvgXCXQaPxS?=
 =?us-ascii?Q?zqjFE8TXyqW3QxAkHkEJhPkbUoSJ9Ky3iEXP4bGLIexwSCuGjTJUH3TxB+bp?=
 =?us-ascii?Q?bpdNLZ/dCqKnE7YoD2LEswhC8THH+eWhMaQ/fmGC0yWjZdQliL9o9OwWqQfq?=
 =?us-ascii?Q?/9MbvaINoxGnNuwSyf46P+e3OadFVZIjmciE4R1iMHVqRcF3o6mMyUfu+M35?=
 =?us-ascii?Q?x7+i5TdIzKVRuO+xum5KsqKDYdoXtjs/DOiUafqAtTV8H+IMFcRTnDkMOsKy?=
 =?us-ascii?Q?VoQcjXyWAzIV0l3RGSlwmLTGYl4QiJ2oNlUDhcikic3wZP7WyJL5ist4CZIA?=
 =?us-ascii?Q?R2vwi0l816/j0eHq97BuctDvcCbacBdvoxSa0HbdSxduzL9+UhsUfj6j9dOQ?=
 =?us-ascii?Q?HEnr9ztSueJ1tks/vfYFZJGQZDnu0uJhD5IuphknzjeSfLILGW79LWCi4Gij?=
 =?us-ascii?Q?q3M1we9O8N+BIcHPFc4FC2QfnzzEI0BX9wUUYX6YtV0DGPhAht/Ox1YickJv?=
 =?us-ascii?Q?KSk6qTPNEmtb/D6S/DvdJLJ+MWtOqjFmW3wB3QWyco62UhJP80aIOs2bo3a1?=
 =?us-ascii?Q?H97O/29qZ7GBxjSrgEQPyY4Q7VAip0UPdCxgdtsmhPxyMhAKYmU0Tn7d6SHv?=
 =?us-ascii?Q?kiLq7WKeZ9apSkK7VtnJCQASTFtkHILVNXva296IuxoYkpFcNB6XK9w99Lbb?=
 =?us-ascii?Q?PFrcdW800c7OOIm7jmez4qikcgjYYeVAYiETVb/3X33v+U1aVBPETo0+f3PL?=
 =?us-ascii?Q?Q9tOgenWdrkGYPspzi+m1FwiT7PO35VfJHI0SC5ztjkXpo3AS5YUwKwG+A22?=
 =?us-ascii?Q?S8LDFjUyf9s0AefAh/Wujifj5E6hzIjNv2VSeYuwyNW4AzjFpBjhOfdj+o+v?=
 =?us-ascii?Q?GsA1tPHIzxPahNihBEvLmPTm4mIgxRjD8cJFL9rUpcHDn8ku8EoYnwTWYmQQ?=
 =?us-ascii?Q?opwahwcnBM1ycb4ginjq+kPhfp4KZE+wpLXnLzgyqme3X1yAt9snq/Ylm3xW?=
 =?us-ascii?Q?/bAxTSRUawmx/iBNSwr/4qmCNpYh5Nj6GpoGtLXsTvam56+3R9RFHti7xIjZ?=
 =?us-ascii?Q?OyxQxtBuP+T3Y/Oy7ojZInnFU2nVjKnEKZE4Wtle+S7+dieIr747WwlgmDND?=
 =?us-ascii?Q?5Rdl+yVkQJhzGdq9cJAsqxW0sTbNdYGxVdpROn3EvU7BcfrYEQn67D1alJG9?=
 =?us-ascii?Q?wq55AIUEpani7t79/ElIFcflByKdYLxpfg8aETVR9acmYxmHl3FTxdq5XdIf?=
 =?us-ascii?Q?rEGSm3FxhRpeJie3i/jvWDUjiUVW6NQ3jezU8uW5qhJ+I/nC5SCAw0g+YdTN?=
 =?us-ascii?Q?1jM0rZOdtrtRYtSY/7VU4/Hf55mkxqp3fUd/zh2S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e2e3b4-b642-4139-3379-08dc8c19ec7c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:30:15.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUu1l8nLqLCh39svDfAWPnpmKac4bEiuUGbYus+CVldCis4Jn0bE//QXtKlrrlzraoZxep428Z+EccwYnsqISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

This continues the work on getting the selftests to build without
requiring people to first run "make headers" [1].

Now that the system call numbers are in the correct, checked-in
locations in the kernel tree (./tools/include/uapi/asm/unistd*.h),
make sure that the mm selftests include that file (indirectly).

Doing so provides guaranteed definitions at build time, so remove all of
the checks for "ifdef __NR_xxx" in the mm selftests, because they will
always be true (defined).

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Cc: David Hildenbrand <david@redhat.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c     |  2 +-
 .../testing/selftests/mm/ksm_functional_tests.c  |  8 +-------
 tools/testing/selftests/mm/memfd_secret.c        | 14 +-------------
 tools/testing/selftests/mm/mkdirty.c             |  8 +-------
 tools/testing/selftests/mm/mlock2.h              |  1 +
 tools/testing/selftests/mm/mrelease_test.c       |  2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c       |  2 +-
 tools/testing/selftests/mm/protection_keys.c     |  2 +-
 tools/testing/selftests/mm/uffd-common.c         |  4 ----
 tools/testing/selftests/mm/uffd-stress.c         | 16 +---------------
 tools/testing/selftests/mm/uffd-unit-tests.c     | 14 +-------------
 11 files changed, 10 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index c463d1c09c9b..2893bc002639 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 37de82da9be7..1d584a415bde 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
@@ -369,7 +369,6 @@ static void test_unmerge_discarded(void)
 	munmap(map, size);
 }
 
-#ifdef __NR_userfaultfd
 static void test_unmerge_uffd_wp(void)
 {
 	struct uffdio_writeprotect uffd_writeprotect;
@@ -430,7 +429,6 @@ static void test_unmerge_uffd_wp(void)
 unmap:
 	munmap(map, size);
 }
-#endif
 
 /* Verify that KSM can be enabled / queried with prctl. */
 static void test_prctl(void)
@@ -665,9 +663,7 @@ int main(int argc, char **argv)
 		exit(test_child_ksm());
 	}
 
-#ifdef __NR_userfaultfd
 	tests++;
-#endif
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -694,9 +690,7 @@ int main(int argc, char **argv)
 	test_unmerge();
 	test_unmerge_zero_pages();
 	test_unmerge_discarded();
-#ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
-#endif
 
 	test_prot_none();
 
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9a0597310a76..1fcf65c08c87 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -17,7 +17,7 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -28,8 +28,6 @@
 #define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
 #define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
 
-#ifdef __NR_memfd_secret
-
 #define PATTERN	0x55
 
 static const int prot = PROT_READ | PROT_WRITE;
@@ -334,13 +332,3 @@ int main(int argc, char *argv[])
 
 	ksft_finished();
 }
-
-#else /* __NR_memfd_secret */
-
-int main(int argc, char *argv[])
-{
-	printf("skip: skipping memfd_secret test (missing __NR_memfd_secret)\n");
-	return KSFT_SKIP;
-}
-
-#endif /* __NR_memfd_secret */
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index b8a7efe9204e..7dde5b9a9ef5 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -9,7 +9,7 @@
  */
 #include <fcntl.h>
 #include <signal.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -265,7 +265,6 @@ static void test_pte_mapped_thp(void)
 	munmap(mmap_mem, mmap_size);
 }
 
-#ifdef __NR_userfaultfd
 static void test_uffdio_copy(void)
 {
 	struct uffdio_register uffdio_register;
@@ -322,7 +321,6 @@ static void test_uffdio_copy(void)
 	munmap(dst, pagesize);
 	free(src);
 }
-#endif /* __NR_userfaultfd */
 
 int main(void)
 {
@@ -335,9 +333,7 @@ int main(void)
 			       thpsize / 1024);
 		tests += 3;
 	}
-#ifdef __NR_userfaultfd
 	tests += 1;
-#endif /* __NR_userfaultfd */
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -367,9 +363,7 @@ int main(void)
 	if (thpsize)
 		test_pte_mapped_thp();
 	/* Placing a fresh page via userfaultfd may set the PTE dirty. */
-#ifdef __NR_userfaultfd
 	test_uffdio_copy();
-#endif /* __NR_userfaultfd */
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 4417eaa5cfb7..b74ddf0a2c39 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -3,6 +3,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <linux/unistd.h>
 
 static int mlock2_(void *start, size_t len, int flags)
 {
diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index 100370a7111d..a1b761940058 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -10,7 +10,7 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>
-#include <asm-generic/unistd.h>
+#include <linux/unistd.h>
 #include "vm_util.h"
 #include "../kselftest.h"
 
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 2d785aca72a5..5652e5930854 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <math.h>
-#include <asm/unistd.h>
+#include <linux/unistd.h>
 #include <pthread.h>
 #include <sys/resource.h>
 #include <assert.h>
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca..ec968db9e6c7 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -42,7 +42,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <sys/ptrace.h>
 #include <setjmp.h>
 
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 7ad6ba660c7d..717539eddf98 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -673,11 +673,7 @@ int uffd_open_dev(unsigned int flags)
 
 int uffd_open_sys(unsigned int flags)
 {
-#ifdef __NR_userfaultfd
 	return syscall(__NR_userfaultfd, flags);
-#else
-	return -1;
-#endif
 }
 
 int uffd_open(unsigned int flags)
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f78bab0f3d45..6aff0e8cd961 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -33,11 +33,9 @@
  * pthread_mutex_lock will also verify the atomicity of the memory
  * transfer (UFFDIO_COPY).
  */
-
+#include <linux/unistd.h>
 #include "uffd-common.h"
 
-#ifdef __NR_userfaultfd
-
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
 #define BOUNCE_VERIFY		(1<<2)
@@ -466,15 +464,3 @@ int main(int argc, char **argv)
 	       nr_pages, nr_pages_per_cpu);
 	return userfaultfd_stress();
 }
-
-#else /* __NR_userfaultfd */
-
-#warning "missing __NR_userfaultfd definition"
-
-int main(void)
-{
-	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
-	return KSFT_SKIP;
-}
-
-#endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 21ec23206ab4..6298a2045095 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -5,12 +5,11 @@
  *  Copyright (C) 2015-2023  Red Hat, Inc.
  */
 
+#include <linux/unistd.h>
 #include "uffd-common.h"
 
 #include "../../../../mm/gup_test.h"
 
-#ifdef __NR_userfaultfd
-
 /* The unit test doesn't need a large or random size, make it 32MB for now */
 #define  UFFD_TEST_MEM_SIZE               (32UL << 20)
 
@@ -1554,14 +1553,3 @@ int main(int argc, char *argv[])
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
 
-#else /* __NR_userfaultfd */
-
-#warning "missing __NR_userfaultfd definition"
-
-int main(void)
-{
-	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
-	return KSFT_SKIP;
-}
-
-#endif /* __NR_userfaultfd */
-- 
2.45.2


