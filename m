Return-Path: <linux-kselftest+bounces-11912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D439081A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 04:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD10284095
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FE184103;
	Fri, 14 Jun 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XjtCL5M9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4A1836D4;
	Fri, 14 Jun 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332225; cv=fail; b=X8NaluDtJZ/IytFFo7KlLxMuThFAOfOcVjk2ZpnhN7AEoUNj/gUpsPI/qOQR6C+AJv8KufQL7nnJ5vUjXv49y6oqEVx8nK5wQTVQ6/Bg05DDnnBJjAQFQohSBXE3jkBnYGHUo7hmov2eGB6BPNmeFrNpT07Ud6qmxel0XKf5POA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332225; c=relaxed/simple;
	bh=uuJELeuSegd5T7IZ4PbDBzKeC3iAaUnxpJilz/0MSoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DE/H1RZ48SESGPf7riFJuxd7lfQxirxvzgm1iTtEDl3JwlG7ArljBkYdOKLHzBf2PeW+jPjNxmAT5jE6rVvpsHAbsUuvQ908G9DhBr+mtpvcrSbWMXN70FPMLchV5MYr+SwFzXhUT2d9DZblE4Ss90K+f8OiA7MpH9vEs4pjaik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XjtCL5M9; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz5fNajO1Ht8QsTCJjpjqR2r2S/oevvFiYWbI8mithve+lVijMlnzrpClH4Ame7kD6YSAcqVB3+uQ5kbAzCsPDJsb7HuvsK2Hqwsd7z+/RZJrmGeYbJptuMB7CTB4dt1lBpZdauGbzIX0SLghYHwaR+TUbQ7Gz1lApmmL+TtK90GqmdATN8eC51VQLeaxOWXbfk8P1GHpsziE510XIxg8zZAjA8nmHdikrbGOLmiexsNlP+iKK0AFREAj9He/fNtE57fmWSmLqZdgUdlBcQCr4vHubehleGFXsVLs5TcF0iWwu+Xs1GyZEBnXO80SfatxOPB41gbwuKvJdAZ57cJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9+g6+820LN46VxxBOfmNDi/NM5Xoh65XECL3YB/2Cw=;
 b=E1T6r8fvkoAo/tJej/IhbwyhkJtpUmfJZnfG+MdaI4V+a25SK6fUFNkinzDrlmSDu2oNcDqWlv2JKVLpX6KDEZMsgFWSqV1pFdjJ2LON2OrW+wF0DjynkNnNKbG73rViN0OGlNsWZWKhB3gVg20daAqCxhZfkk69HJgkRpepbVYH//Ibt+POPA8ekAgHbKN3dpYBkdIYZEblXUdqmWPo4F1FdsA1MKskxsi8dZyBGtgaSVdq89H8NTs2rrM9nRAnRczCUlTObDXV9vrINOt9XGkgKQSYRHR3KwhRjkWQj7noejiZrm7xnccawrq7/U5glPBcxR56T1PXBTDrCEY+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9+g6+820LN46VxxBOfmNDi/NM5Xoh65XECL3YB/2Cw=;
 b=XjtCL5M9PGDDLLTjCkGUk6gMSVnzOTy9dLREMdLZAzdMjZRKGYnontHK2tNx2K0o7wpdCF/Lu4h8lwdvbTJyYRsfXdP/NPrwld7UhRwI7uOtJNDYA5+YDJp2ylX4Q9xCFwfJZdUXwBxfEms5d5JFvwCKHagWihBU1mYHXQhaef+iMm4u1ir3XVFtroNvjLrI9dqYUHq8Nuo9WkcNDC4mcjtS4cwkQxoRlmqCIT1GKapKhrDw+Xn0VrEdlhNMcyDD8TEp4seBmXNJFA4yUC8xIUC56j3hrQ1HVi6yDtS5UIEXdb+OAI8Vb7CPtKt+IfsIgVjonxGg9U0t3+C0ol7iNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 02:30:14 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:30:14 +0000
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
Subject: [PATCH v2 5/6] selftests/mm: kvm, mdwe fixes to avoid requiring "make headers"
Date: Thu, 13 Jun 2024 19:30:08 -0700
Message-ID: <20240614023009.221547-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614023009.221547-1-jhubbard@nvidia.com>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecdf677-0c85-4db7-3263-08dc8c19ec3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghs2kGaJxkA1ZxlsF9rnC6cFQMJ9UowF+2MhDOou8AjfYVxfqs9QP7DWXAPh?=
 =?us-ascii?Q?XPT+1jed+QRwKrYkPYIghnU5vFgw1KLIZ9K3UTgXSO5SMtNyrAFkKOZ7lyh+?=
 =?us-ascii?Q?b0+JkVL1a/ezAYit/5/XlNnaqFA/chC+bOVuKCmEy9I2ELP3Vk3/A4TId2Ps?=
 =?us-ascii?Q?YblpufUoyN6TDwVjviduhByXDJcSNFdIlxICIuWZakay//HOcXqUmLORuipO?=
 =?us-ascii?Q?Scpq17pOWpjULKcacQIr5nq49R4KxyCXDs/D3Gb8KmEODFsFNkdte0pgKyli?=
 =?us-ascii?Q?3lgUtCMDQ/vvubyxDSx1YJ/EfqqrsI2HePcDEAX2+/52DKD3oBd3ltubC2tj?=
 =?us-ascii?Q?n+wRW2DSJ+v2EfRO1/4EutK7w/6yeeVuaTAw2AoU2YF12/N2N8bONI3zXYI2?=
 =?us-ascii?Q?AXQ6x+0O+iUtgk8kb7xZKmtivn3iPe2nIbpenRQrSHs1ML1aX7Skg6VyHuut?=
 =?us-ascii?Q?en1flByYivYRJ18v4xkYDechquEs6u0owtUXndeboCCS/8TBaLFPBePmn6A/?=
 =?us-ascii?Q?izx/pi0B28yXy2jV3cmkWTXfWFGnj7yDDDY7Yua6tN0y/bXjEf5gyTqTb9C3?=
 =?us-ascii?Q?IZ83Adv7+K2cA/6UlW7T9vHp6QuiD4JW/vfDSeAn6adFRCOsuKkkmRDXK3Fc?=
 =?us-ascii?Q?Z03OaHa3ZwHqKSXKzzJPUdBpVJADoCOXFEIMVpP017SrprYXmTviUZnM7lBp?=
 =?us-ascii?Q?PmN2fSRb4d2f7bsRU4EDgDsQ4veTDsOkFX6MqFjRtYchploeOBurnNChURmK?=
 =?us-ascii?Q?ZWRyS3Ci3PXdj2m9PQ5XAQLPQohTk4/WDujazEtB6lGxBcVlllPwFwKs54nw?=
 =?us-ascii?Q?/lCoVz58OWQ1eTjDvhpsBoUExfMjiVv2ErE+UWjL3Scp4kv6luzLfSABlQWI?=
 =?us-ascii?Q?vk3l/DLlemRSF3BuaTh/Z+sIquF1l1Bvuqn9ETdvcLGx0+uL3Nwh4Qf1C6Ou?=
 =?us-ascii?Q?Np9ZqHE25b8XhXpkvUZ/PG+OeIlRWhHRo9NKQIo06m1XJXSnrfnsOfP5Lzes?=
 =?us-ascii?Q?kZkoJIKQbakbh0MvpH7ubQ+bc5MS/yFr1ZBYvta1UL826jUXCUMELkrpz/30?=
 =?us-ascii?Q?ND5AGuSiNRzqfDmUw0PhBLgHRYrEJ3yErZOqv2wQ3cqCDGavM6q6MPd+MW+y?=
 =?us-ascii?Q?irxg5spGSEujsJbTF1vhNmUZrLCYc7OS8ZU9Wak3SvrCLlcggkAd4V8n/UBH?=
 =?us-ascii?Q?qPhB21i5ra0eFwfKOcUtDmh23OmjzdQurtH/iXvjUwN69Ap20DaUIyt03Xxv?=
 =?us-ascii?Q?fAhQgsEuPMcJGmuVCtjbFcgIy3BtrxQ8PCw9moaj8N8yi8t/wpK6odYZTRUY?=
 =?us-ascii?Q?b2jIuvlzzOdJdAbqFquiGDwv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AiLhD4X+TfP3MafMziNMjYJrldP6s5127O4a8h0Kv43u8gT8RL6o4WYlf+eQ?=
 =?us-ascii?Q?2di9uOwhEHfiCcjRiP4ZAG+izyueiygbcmrP9w57ZxQ4tQZuProuudHEe6v5?=
 =?us-ascii?Q?6rx9wLuCFzdr26lMX8c3k++EsWBkWk30DDrb5BIaiFL6kkTLfZgyTFUNaDDA?=
 =?us-ascii?Q?hf6HoJArb62mXLMGrF9uAYmz31TNO+6TcQSA1Mw2tFQvhmWJCCgN2l070Sdn?=
 =?us-ascii?Q?WC0VbQ2/VhWrQ84jh6ocMAQqV56c0Ji3S3Aj9NNvAhWdEyO4NHRm6m8BAD1L?=
 =?us-ascii?Q?fw0NJ+s2O0MNOlCGIml9/tYIGFWBnnecChudQLQ+Xcx0FwRVqJZeY8Lh8MaV?=
 =?us-ascii?Q?4XQ2+p02ypRJ7Fn/cefPS8WJ6HxK6QaRgsvFnzntf50hK2mPFP8aTCDC4NFp?=
 =?us-ascii?Q?1ylIsR9yzlS7NuDLrAYzVwpWmMiUd6oWXSWVjinb8GQuBT2qhU7pqWxjP/23?=
 =?us-ascii?Q?g6u2kVF9du4s/B+fnU9H9bDZNEbwcOIxnfVdmhzbcTDuxCfhgm8isk1QiVhf?=
 =?us-ascii?Q?MKLQYnGWqYWOX+srnqhaqRsXhpPmT7oBnlSCy5DJrsVhUObaBdb9YBsQlewk?=
 =?us-ascii?Q?fHnheRCDTdmuEw9ny2iE2F4vfPRFR6RW5HpU4a1zqUl8D3aAKcqM/uZAgFT4?=
 =?us-ascii?Q?9aCS+tm11zYWsoDZaG0/k9KESWnWncjaSuQISCHwpzP39kihEeQvKg+24Yas?=
 =?us-ascii?Q?c9KSlOxma4Ql90iYfoSlblAGeoeOjJX7/oBdrZ5V2KY0pHzFyxYPuXNNob4u?=
 =?us-ascii?Q?Bd30v0+1xEwxTuen++qdoZDLiNVn8/6Ft1fknliq/DLrTDClDldT4VHn9xWk?=
 =?us-ascii?Q?UYGzHd/kgY6ivGOeaxInTih/a/SUCKMqpnt7G7mUc19BxVKz9o7kpMaakpOD?=
 =?us-ascii?Q?X3RvLEZ+dBA3zXzjiLYLyn6IYHlkjUE7Ne4mYSCC7hG3hRHS4q1YE+M+wGBf?=
 =?us-ascii?Q?nsMM6Kro0t72Csr4dicCbbZUhbcl3yxLnl1H3eLPJT4Qc4D72eX0Wd1OZ0Nq?=
 =?us-ascii?Q?mr0eKdwg0iO8dzH0fNnCxM1yaaSMr8XEHKhQIKV5fetXI+XVh4G6Vj2CcQk4?=
 =?us-ascii?Q?3GRG7uIn9lXs4kqCsFdXKoVR7yMU5kRHXMYdYVNeu99gnxABaiUGaVHMAk/A?=
 =?us-ascii?Q?6FpADLCNSg7KlHJrVp1xf9/W8eE/+ghezvZpVq4LpfBsdXT1xKNP3uzran7D?=
 =?us-ascii?Q?5G3E8Ily7XBAVsaamsKOQPq8HFn31MynrdP59gMM/V4AHj8rq0Y7j4kVCsMo?=
 =?us-ascii?Q?pzrcmeqtxR/MP6n3G4VtH9PUXg/MZce4p84+4CB0mWwBBHRbqvcGQkh8+KiQ?=
 =?us-ascii?Q?/jpSAHPou6K2X8X8lW8+CmN5odGlovjXWqCuNWCXyj+6FDvL8hZ0vXVUrxvN?=
 =?us-ascii?Q?0iJOsqaOnAlQvvvngTFLGbXB9b6KaUtwPr02fJmghAoW8/TcYa6iSrJKS6il?=
 =?us-ascii?Q?mUJorS/IyQHt5+vE/xkvYGwc7G70ZkKYdMlHYSwrmjRMQxPuA1zKt+hpl2Xm?=
 =?us-ascii?Q?lAqWiEvj06/HiUqW3wlGdN7B9kH+qSJbK9ttdi/o1hKGCKotsNunCa4sLITV?=
 =?us-ascii?Q?fO429vINKZlBRxPh7ToavMLWTtXjC5+mC3OuH2Vl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecdf677-0c85-4db7-3263-08dc8c19ec3c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:30:14.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPjY3FTrQ8Icnkgh7VoMj+BYMoOtR+p7sif1CvGLKvKpGYzFZebgj9tgPieW/0qg4TKPUYlCgrX7K+SqNgVGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

On Ubuntu 23.04, the kvm and mdwe selftests/mm build fails due to
missing a few items that are found in prctl.h. Here is an excerpt of the
build failures:

ksm_tests.c:252:13: error: use of undeclared identifier 'PR_SET_MEMORY_MERGE'
...
mdwe_test.c:26:18: error: use of undeclared identifier 'PR_SET_MDWE'
mdwe_test.c:38:18: error: use of undeclared identifier 'PR_GET_MDWE'

Fix these errors by adding the missing items to vm_util.h, and include
vm_util.h from mdwe_test.c.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mdwe_test.c |  1 +
 tools/testing/selftests/mm/vm_util.h   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 200bedcdc32e..cfe0b64d1567 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "vm_util.h"
 
 #ifndef __aarch64__
 # define PROT_BTI	0
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 9007c420d52c..99cbb7c0ea9d 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -61,3 +61,18 @@ unsigned long get_free_hugepages(void);
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
+#ifndef PR_SET_MEMORY_MERGE
+#define PR_SET_MEMORY_MERGE		67
+#endif
+
+#ifndef PR_GET_MEMORY_MERGE
+#define PR_GET_MEMORY_MERGE		68
+#endif
+
+#ifndef PR_SET_MDWE
+#define PR_SET_MDWE			65
+#define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+#define PR_MDWE_NO_INHERIT		(1UL << 1)
+#define PR_GET_MDWE			66
+#endif
-- 
2.45.2


