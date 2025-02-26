Return-Path: <linux-kselftest+bounces-27661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75018A46CE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7CC7A8C0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556925A34C;
	Wed, 26 Feb 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="grwj2K1t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147F258CCD;
	Wed, 26 Feb 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603652; cv=fail; b=P44LuI1+mMdhhTrBUsnEjS+1VfwCk4ji/2sIBxFnkKT7ZjRJxYYHESkzsJD2RUYOGU0jx1GD21tA7wERQCIKHEMR1uowyGAgEglyFOUNx2bKUeIDSe11QSsb2ISwiKi+rEv05opsrkJ1/ZjHAqgn4caweUhZLZWXLt4UJ1wm+0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603652; c=relaxed/simple;
	bh=Nb//P/PK+JvCsf1BQ2nln4ZcN5XcY+Q6fxQSA9As72E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjYl7lLf1IY2pu97Vmn0zaw+Q3fxvcaV3ixJ2+D+LeWC6g+mmk/8cI9tBeXDjJDMxlrPOWl1jKePzs41/PHrYR/thmGTccTj1QRMUZLTjchdZ50kX/cD/MIx791rq/XUt4m03Ay04f3XcW9G1zf7PUlZZWGEFkISHtGZ7bP0a+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grwj2K1t; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmkOpBhI5YSvpmExr+2N5g760vjuwMoiyOmHHwZeI00URTBOoJ5ZV4g6fVPouxP6NX+uRYcLTlP6ePFzaP2MxmQcDzRct7cUqEYqNBq5Ik4DFMbnzU/0Pp1X220av2i91LbiOmCG6zJJPkYbyyByIk6VDIbuMxATEdpBYjxnOwQ5Oj3puYbcWGW/bQqNsRuHnaJQLe73zpum87jDtTDLb7GicZASnMpBephnMqWRQ2y7vYMwJZs2sfpjDUhQ/Gk11kIKJy6DEljUJiLqGs+5mQNqFlEvlzz228mPQoyHBkpaIK30bZcr7vfqo1dfYJs7WfVYgsbgfbPrrizfTO2YBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVbYB2ZtmX6UeyWQ745kTJF30KIp4fCmNbvxhj+B8C0=;
 b=t04a5Xdt9ILXA3B7fGcNNCImqiTZMfbbkF8un0c5V22IEpVFThqjY8mjSfz6ybhbiBsc6RjW/hzooKFWbooSvfaZ6MTs1mdhiWYicLnYtbPpDFGZcX3A3QwfehRAhRU3cWh196ZeKYZ1Gbh8PJFtj2vhfGLE14UbdvyTKYZe01SnJd3ds0jA00oiz6N3Hnh8q0NUT2MtRqMgRrorO9b+S3V7LRy40RLznThan4YfPOF/bGORE24OHZVfA//jXlveUSr6GhvZ+ht/CsoqMb7Lm2COazkbwu1gHGXcl11pXOE+9PcDJUsLW7lMrxImQuRKleyNEMWQNWfCgWKRkhE44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVbYB2ZtmX6UeyWQ745kTJF30KIp4fCmNbvxhj+B8C0=;
 b=grwj2K1tiBjZ8mpiMKk2JF+PM6do7yIa6+/OB7fGXNzxu/wFr9NyiLeVNPCJsLhvdUng1p5/XeDCCtibjHFjbyWg7ZJNa9Z40ToXOwpGS78Bpp/1b0dTQYSaxHddnwDpywLqPvf4axzNi7YSrMOGVkCLoRkgrJLyv/Yno1WC5xKbupYlLZXpBOQwvh/+WcrPVUex/91BTOHJu1tr5O+eW15yVvxAGGsauhamyPgg4QZwtvk7rkcsAK6k3ylMetZ4+NRnO4+Tgw/RobWyOF7RA1/PaXdzl5a88ZO6ERnkr7veRDD/tRnyvB67utozjQu2CaZvQ7ILJCzvvusQosMbDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:42 +0000
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
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Wed, 26 Feb 2025 16:00:25 -0500
Message-ID: <20250226210032.2044041-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d1625b-edda-4f7a-bdb8-08dd56a8a166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G+g9uy1JfKsrEM7BCAtz5LAKZvqOu4/NQc+iLwEgkfl0dS6X8AqDAALalNtI?=
 =?us-ascii?Q?2ghokchNCXiP1tSeU0Z2DKZAAkX+f4wdWbFOvZT6CHiClvRWEfKwK0yPU6Sc?=
 =?us-ascii?Q?o43hspY81A6ROUkihMTt0nfTKd7vwnsrmi8Atxv9mtjSOWjvSCchAYSEryIY?=
 =?us-ascii?Q?YEx4NoDXshKPvA67HCDq5yFMxiZXUN2drd+WUmnUUdSPb0bQfz8tAxPq+Kik?=
 =?us-ascii?Q?x92sEPbPmbxvgzD6IEay2EELP0beKfCn6t3hFPr8tthn2BhJWmKFgfF5g55U?=
 =?us-ascii?Q?OVG0Q/uhXYEgveaEx+z/6S0Q87gi2eIrljILmLpR82F96khZrTPMcjfcJ+hC?=
 =?us-ascii?Q?zUr9XLqHgFoqCFtRXLEZdETSrtY62BDAtqYtk0Og9RFlrM7OTbBf8fxgWR/y?=
 =?us-ascii?Q?z/3A+/vF73Z2tzuF8ADdzj9Sr6jV8WFCj/YnwwPcCOj2x3CgjeAQMWY5+TIx?=
 =?us-ascii?Q?jFzrGS5s3+D82OPOaLiC21a7RF60AS5M+SkwrWSffD/ZZ7Z+6SPWT9lI/8g0?=
 =?us-ascii?Q?CW4c5ZGKhNf/0tVFyok2a8VJus4XLvr8EXGLEv8M3tyM3LDPJR1SsbvVoS9m?=
 =?us-ascii?Q?+jO9Z5/HyEVo0TmsV+fCSjvwEr0S2JYF/uRQZSE2C9NbOVnup0xn7tYZ9FDz?=
 =?us-ascii?Q?1ijw9v1em/r7Z2Y5k3GijiwfaCvRvg16x4VkgktEjZfRgecLrQEDfLL0sRzV?=
 =?us-ascii?Q?32np6bj6DtW4y1MimVdbYRgO1LBlKSvYo5FvhP8X4l5t6dbAbCqg4Vf8bzI3?=
 =?us-ascii?Q?od+lXoimo1Xz3HMdQCOIgBCeaRodxBK0e2LXVRdektxyGYyvjZCbCdkCPpQg?=
 =?us-ascii?Q?+HuPb8jxOQ33nWZzwGBs9xxzIsLJAZgboK7NaNtK06fCG8t85y/X9XPwYBtv?=
 =?us-ascii?Q?1f6jLJLtht0yv3x67SXkHA2X1xLflTpUaJZetDfb9OXQ6Bp1EbclLPlSLCEi?=
 =?us-ascii?Q?OkhLXcOKajyZ//6zFc0blY8tS0hpZJvBzc+e531GXPYmwzcJdja97HoifiSB?=
 =?us-ascii?Q?2q457Yy3+bnhw5LUcJrXtHIRrT0s9uCQ7HLlosouqrRlcGZDAKh6p4vChn8B?=
 =?us-ascii?Q?SlSYi0sq7rMydxUFRgLhjSFkmw6F2oYorMf59ZUwG1bFDqQ3uFSRZ+jZ/d94?=
 =?us-ascii?Q?tMuezA31RxdH1InBqhV34ppT98zUAkJgBLkba6VK4xhGIzYPQy9i72Wd9REr?=
 =?us-ascii?Q?AT4ABZ87ACQdvsZUxn1LzYSPYPL5C8i6QEipRvx92PQodI3U5+Cn1yTi7DlX?=
 =?us-ascii?Q?MG6DTsTCnKJYuDZruJi1/YLltFXLTRP3erXXI7xmwnv5en3e8B6XAInwniw1?=
 =?us-ascii?Q?Do3ypT3gTxQdBkc5dJ3fNWS12WSThq1QRe0qvv4QVNBPWoGKNsk1Yj9ncgo6?=
 =?us-ascii?Q?y/JAGvKzBtry7mIa0uIMrsSyW8Md?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?flx1UU81zDLVos2XDWqsvwVtdyYVsmfSl7pB5A75jV1AGwmPLiFCdTlFJ3Z2?=
 =?us-ascii?Q?MEGNz3ZVkWiu5Kum6On042N7nMXgIZ6MlPKWCWz/OcvYkm1+Q3j6J86F/2j7?=
 =?us-ascii?Q?BtQrqZQsUdw8/jaYh0E4g0ianFXCCwk9umumJ8pOTar9ORCwL3S3f83Rh12I?=
 =?us-ascii?Q?kylXwk4P/vntymAxWC/xrXakVfRE4PxVVe1Nc3PjCzIaA+Zmv00VGwVFWAYd?=
 =?us-ascii?Q?t1uG1NS5IyYN1d99uWHWWLabVn+cdn1CdhIh3USGw8u6jLbWYPbrD1ZydWHl?=
 =?us-ascii?Q?MDGlobxftl3elIOJ+JQAhDpG6mmO7QUV2BunH8uacgF1Jma5nBVdy53DANdu?=
 =?us-ascii?Q?eeclOYe2l+TRm9scMwRp2+Udas9K9w2KALNqQCGJ7gXtR6/KSGh9XUdzBFMu?=
 =?us-ascii?Q?SfsZuKb/PQ5Fbl+clonmmbGIuVZMx4P/107Yuh6we7MiWLk1GJwzdqeAbJWy?=
 =?us-ascii?Q?Wmlskx9R5fTwKeMiXoFgLwDGmriT0iYEA/vEqdkAniZax0tmjA7NSby+j1U7?=
 =?us-ascii?Q?lbXzSwNVj6VdvDYrXkMnqnqIntOLKTQWrso9W8vq3fb/gTV1B9CGcGIAkh0w?=
 =?us-ascii?Q?VhqTdoJ4BdxU6WVtWeTq51LNw5IqBB88jmrrRn4gFMhVk7YDjRakbGEkx325?=
 =?us-ascii?Q?GwDfhQbYKj6THEakc0BAIxxx2Q2+c90u0G48Wb+icFpfz3Shuqi231z4vJ+M?=
 =?us-ascii?Q?gTiR5p2C2BhQI3j093MOZ+kU3UlqyW1tj5915CIXoxNqr/VYy/uW8rm/vSCp?=
 =?us-ascii?Q?f/3rl1PfajJzBdVSFrH2kFsmxFCNMZWvRXBGITJs+OT1RpEhIjn9niUXgFil?=
 =?us-ascii?Q?jZcMwkr7TxHAfLJWWv0DeyHwPrYjHvDYJa9yPgpn99PIAGxeEqBg4ajF9gYt?=
 =?us-ascii?Q?hYiJhiOkzitXC5MHDa3p0bmhMyuzDQsuNlYg0UUhSn62gkUVQDuzOUlrGaAz?=
 =?us-ascii?Q?mB+RqEW9UqTUTOfdbd9cmrOelal5Kl6SaeFsEt9t/mDh2gJm1dvLpu1WjKUr?=
 =?us-ascii?Q?r8NRL/ofPbxg7TZy9Ar/ydJvQdt4FJNlFSXOxD77TgupvFp1vjxUlnRNqcqH?=
 =?us-ascii?Q?uEvbpsJY2BfC6/pfyeUQY9RNgo0FuUlVNQ/weuzfJGOj0DypP4k86eUgtrN9?=
 =?us-ascii?Q?CovR67Fum/UcQFRAezaTxH9ivtClSxw4t3rHeC798eQcQ/3ZmWeZiEJ6eLHA?=
 =?us-ascii?Q?0LPLaYMppEqcMC+Gapqp4s1kLpvQldWSGJ8d+fK2I8wqUHXbR9yktYSywOUJ?=
 =?us-ascii?Q?Ukn7Cjav0WZfV3PObIQNjbuNcP/yeK3d9bnNbDjUbmVNqJdNPxoFmQDIlKX6?=
 =?us-ascii?Q?/sTJBlPtIXvpICgcFXbyF+HiMXMtpskXRO+dnHCDsJahM8D90MqTXEnI/xs5?=
 =?us-ascii?Q?7F5mGfKCU1qqoeHywSR9K2QijpKO7HzPXG9g7dBf9/MYTCa6xYRjFiVfPgXM?=
 =?us-ascii?Q?A4udAVMv6zL5vjXoTF/WczxejoWzRUXLq2R/MhAXUmJ0pq8v7J7B2azDfDgi?=
 =?us-ascii?Q?2D+wyfkvpwLt6VIZle89OhOuOi/Or4rtWQQN4foAhrY3J1zsQoXZHlxUD81n?=
 =?us-ascii?Q?v/ZO8nuB8bkL/vmVrhc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d1625b-edda-4f7a-bdb8-08dd56a8a166
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:41.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ogyQIuJ3Gypvm+TSLBOLQ2C6svLCImCIqvyW3GyzwiaVkhPb2tKvy8qyZjZDU85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

This is a preparation patch, both added functions are not used yet.

The added __split_unmapped_folio() is able to split a folio with its
mapping removed in two manners: 1) uniform split (the existing way), and
2) buddy allocator like split.

The added __split_folio_to_order() can split a folio into any lower order.
For uniform split, __split_unmapped_folio() calls it once to split the
given folio to the new order.  For buddy allocator split,
__split_unmapped_folio() calls it (folio_order - new_order) times and each
time splits the folio containing the given page to one lower order.

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
---
 mm/huge_memory.c | 338 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 468e8ea76bc9..b0105ba6db94 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3267,7 +3267,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3511,6 +3510,343 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+/*
+ * It splits @folio into @new_order folios and copies the @folio metadata to
+ * all the resulting folios.
+ */
+static void __split_folio_to_order(struct folio *folio, int new_order)
+{
+	long nr_pages = folio_nr_pages(folio);
+	long new_nr_pages = 1 << new_order;
+	long index;
+
+	/*
+	 * Skip the first new_nr_pages, since the new folio from them have all
+	 * the flags from the original folio.
+	 */
+	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
+		struct page *head = &folio->page;
+		struct page *new_head = head + index;
+
+		/*
+		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
+		 * Don't pass it around before clear_compound_head().
+		 */
+		struct folio *new_folio = (struct folio *)new_head;
+
+		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) != -1, new_head);
+
+		/*
+		 * Clone page flags before unfreezing refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow flags change,
+		 * for example lock_page() which set PG_waiters.
+		 *
+		 * Note that for mapped sub-pages of an anonymous THP,
+		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
+		 * the migration entry instead from where remap_page() will restore it.
+		 * We can still have PG_anon_exclusive set on effectively unmapped and
+		 * unreferenced sub-pages of an anonymous THP: we can simply drop
+		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
+		 */
+		new_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		new_head->flags |= (head->flags &
+				((1L << PG_referenced) |
+				 (1L << PG_swapbacked) |
+				 (1L << PG_swapcache) |
+				 (1L << PG_mlocked) |
+				 (1L << PG_uptodate) |
+				 (1L << PG_active) |
+				 (1L << PG_workingset) |
+				 (1L << PG_locked) |
+				 (1L << PG_unevictable) |
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
+				 (1L << PG_arch_2) |
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
+				 (1L << PG_arch_3) |
+#endif
+				 (1L << PG_dirty) |
+				 LRU_GEN_MASK | LRU_REFS_MASK));
+
+		/* ->mapping in first and second tail page is replaced by other uses */
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
+			       new_head);
+		new_head->mapping = head->mapping;
+		new_head->index = head->index + index;
+
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set.
+		 */
+		if (unlikely(new_head->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, new_head);
+			new_head->private = 0;
+		}
+
+		if (folio_test_swapcache(folio))
+			new_folio->swap.val = folio->swap.val + index;
+
+		/* Page flags must be visible before we make the page non-compound. */
+		smp_wmb();
+
+		/*
+		 * Clear PageTail before unfreezing page refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow put_page()
+		 * which needs correct compound_head().
+		 */
+		clear_compound_head(new_head);
+		if (new_order) {
+			prep_compound_page(new_head, new_order);
+			folio_set_large_rmappable(new_folio);
+
+			folio_set_order(folio, new_order);
+		}
+
+		if (folio_test_young(folio))
+			folio_set_young(new_folio);
+		if (folio_test_idle(folio))
+			folio_set_idle(new_folio);
+
+		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
+	}
+
+	if (!new_order)
+		ClearPageCompound(&folio->page);
+}
+
+/*
+ * It splits an unmapped @folio to lower order smaller folios in two ways.
+ * @folio: the to-be-split folio
+ * @new_order: the smallest order of the after split folios (since buddy
+ *             allocator like split generates folios with orders from @folio's
+ *             order - 1 to new_order).
+ * @split_at: in buddy allocator like split, the folio containing @split_at
+ *            will be split until its order becomes @new_order.
+ * @lock_at: the folio containing @lock_at is left locked for caller.
+ * @list: the after split folios will be added to @list if it is not NULL,
+ *        otherwise to LRU lists.
+ * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
+ * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
+ * @mapping: @folio->mapping
+ * @uniform_split: if the split is uniform or not (buddy allocator like split)
+ *
+ *
+ * 1. uniform split: the given @folio into multiple @new_order small folios,
+ *    where all small folios have the same order. This is done when
+ *    uniform_split is true.
+ * 2. buddy allocator like (non-uniform) split: the given @folio is split into
+ *    half and one of the half (containing the given page) is split into half
+ *    until the given @page's order becomes @new_order. This is done when
+ *    uniform_split is false.
+ *
+ * The high level flow for these two methods are:
+ * 1. uniform split: a single __split_folio_to_order() is called to split the
+ *    @folio into @new_order, then we traverse all the resulting folios one by
+ *    one in PFN ascending order and perform stats, unfreeze, adding to list,
+ *    and file mapping index operations.
+ * 2. non-uniform split: in general, folio_order - @new_order calls to
+ *    __split_folio_to_order() are made in a for loop to split the @folio
+ *    to one lower order at a time. The resulting small folios are processed
+ *    like what is done during the traversal in 1, except the one containing
+ *    @page, which is split in next for loop.
+ *
+ * After splitting, the caller's folio reference will be transferred to the
+ * folio containing @page. The other folios may be freed if they are not mapped.
+ *
+ * In terms of locking, after splitting,
+ * 1. uniform split leaves @page (or the folio contains it) locked;
+ * 2. buddy allocator like (non-uniform) split leaves @folio locked.
+ *
+ *
+ * For !uniform_split, when -ENOMEM is returned, the original folio might be
+ * split. The caller needs to check the input folio.
+ */
+static int __split_unmapped_folio(struct folio *folio, int new_order,
+		struct page *split_at, struct page *lock_at,
+		struct list_head *list, pgoff_t end,
+		struct xa_state *xas, struct address_space *mapping,
+		bool uniform_split)
+{
+	struct lruvec *lruvec;
+	struct address_space *swap_cache = NULL;
+	struct folio *origin_folio = folio;
+	struct folio *next_folio = folio_next(folio);
+	struct folio *new_folio;
+	struct folio *next;
+	int order = folio_order(folio);
+	int split_order;
+	int start_order = uniform_split ? new_order : order - 1;
+	int nr_dropped = 0;
+	int ret = 0;
+	bool stop_split = false;
+
+	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
+		/* a swapcache folio can only be uniformly split to order-0 */
+		if (!uniform_split || new_order != 0)
+			return -EINVAL;
+
+		swap_cache = swap_address_space(folio->swap);
+		xa_lock(&swap_cache->i_pages);
+	}
+
+	if (folio_test_anon(folio))
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+
+	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+	lruvec = folio_lruvec_lock(folio);
+
+	folio_clear_has_hwpoisoned(folio);
+
+	/*
+	 * split to new_order one order at a time. For uniform split,
+	 * folio is split to new_order directly.
+	 */
+	for (split_order = start_order;
+	     split_order >= new_order && !stop_split;
+	     split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+
+		/* order-1 anonymous folio is not supported */
+		if (folio_test_anon(folio) && split_order == 1)
+			continue;
+		if (uniform_split && split_order != new_order)
+			continue;
+
+		if (mapping) {
+			/*
+			 * uniform split has xas_split_alloc() called before
+			 * irq is disabled to allocate enough memory, whereas
+			 * non-uniform split can handle ENOMEM.
+			 */
+			if (uniform_split)
+				xas_split(xas, folio, old_order);
+			else {
+				xas_set_order(xas, folio->index, split_order);
+				xas_try_split(xas, folio, old_order);
+				if (xas_error(xas)) {
+					ret = xas_error(xas);
+					stop_split = true;
+					goto after_split;
+				}
+			}
+		}
+
+		/* complete memcg works before add pages to LRU */
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
+
+		__split_folio_to_order(folio, split_order);
+
+after_split:
+		/*
+		 * Iterate through after-split folios and perform related
+		 * operations. But in buddy allocator like split, the folio
+		 * containing the specified page is skipped until its order
+		 * is new_order, since the folio will be worked on in next
+		 * iteration.
+		 */
+		for (release = folio, next = folio_next(folio);
+		     release != end_folio;
+		     release = next, next = folio_next(next)) {
+			/*
+			 * for buddy allocator like split, the folio containing
+			 * page will be split next and should not be released,
+			 * until the folio's order is new_order or stop_split
+			 * is set to true by the above xas_split() failure.
+			 */
+			if (release == page_folio(split_at)) {
+				folio = release;
+				if (split_order != new_order && !stop_split)
+					continue;
+			}
+			if (folio_test_anon(release)) {
+				mod_mthp_stat(folio_order(release),
+						MTHP_STAT_NR_ANON, 1);
+			}
+
+			/*
+			 * Unfreeze refcount first. Additional reference from
+			 * page cache.
+			 */
+			folio_ref_unfreeze(release,
+				1 + ((!folio_test_anon(origin_folio) ||
+				     folio_test_swapcache(origin_folio)) ?
+					     folio_nr_pages(release) : 0));
+
+			if (release == origin_folio)
+				continue;
+
+			lru_add_page_tail(origin_folio, &release->page,
+						lruvec, list);
+
+			/* Some pages can be beyond EOF: drop them from page cache */
+			if (release->index >= end) {
+				if (shmem_mapping(origin_folio->mapping))
+					nr_dropped += folio_nr_pages(release);
+				else if (folio_test_clear_dirty(release))
+					folio_account_cleaned(release,
+						inode_to_wb(origin_folio->mapping->host));
+				__filemap_remove_folio(release, NULL);
+				folio_put(release);
+			} else if (!folio_test_anon(release)) {
+				__xa_store(&origin_folio->mapping->i_pages,
+						release->index, &release->page, 0);
+			} else if (swap_cache) {
+				__xa_store(&swap_cache->i_pages,
+						swap_cache_index(release->swap),
+						&release->page, 0);
+			}
+		}
+	}
+
+	unlock_page_lruvec(lruvec);
+
+	if (folio_test_anon(origin_folio)) {
+		if (folio_test_swapcache(origin_folio))
+			xa_unlock(&swap_cache->i_pages);
+	} else
+		xa_unlock(&mapping->i_pages);
+
+	/* Caller disabled irqs, so they are still disabled here */
+	local_irq_enable();
+
+	if (nr_dropped)
+		shmem_uncharge(mapping->host, nr_dropped);
+
+	remap_page(origin_folio, 1 << order,
+			folio_test_anon(origin_folio) ?
+				RMP_USE_SHARED_ZEROPAGE : 0);
+
+	/*
+	 * At this point, folio should contain the specified page.
+	 * For uniform split, it is left for caller to unlock.
+	 * For buddy allocator like split, the first after-split folio is left
+	 * for caller to unlock.
+	 */
+	for (new_folio = origin_folio, next = folio_next(origin_folio);
+	     new_folio != next_folio;
+	     new_folio = next, next = folio_next(next)) {
+		if (new_folio == page_folio(lock_at))
+			continue;
+
+		folio_unlock(new_folio);
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		free_page_and_swap_cache(&new_folio->page);
+	}
+	return ret;
+}
+
 /*
  * This function splits a large folio into smaller folios of order @new_order.
  * @page can point to any page of the large folio to split. The split operation
-- 
2.47.2


