Return-Path: <linux-kselftest+bounces-39237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0295B2B0B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 20:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544565E6FA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E323183F;
	Mon, 18 Aug 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mOwGvHhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4983314A5;
	Mon, 18 Aug 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542790; cv=fail; b=mbjQUdMZ0tmOE8+qKWMzhqnpBC4huTbFoqJLi3dJl+XCwVpKGcHL/8Z/A8GvxwS8Hdt2r53VQWWAvMKsg8Tjw/iUfkJ/rLRSUUdvlZ8xWuWaOHSSWawd0G2FP5n9yHFiqc+45Kkx0CrsAseGXTYTJIL72Xu5BYaEPwYV7LppgfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542790; c=relaxed/simple;
	bh=X7C+Xmz6/21oPSB4NljJZjD86tPkafvoLvaESHF8sbw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E6DoK2spaflfQBBPe5ceYkj/Pn4k0i4KRSwbe1dHWzNJzK8UvDp8ALP4A5ExmXbgPlBo2Tzvvprp0QLA2PDv/8lmt8wmhnrsOzavQaxuvwBFqHCAmchM94Iq5s4cVtrkRSHwsvieymof/25H3v/IlYDTp8cCbxYX3ey+u0I4ktQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mOwGvHhv; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUHT4uoykYuy6yTKVEwRGuv8HD/jWsjoitxTtW/J88hyQWJwPgeDMGN7LM9DNYqclH7r3nJ4SH8gxbtj8KGDg4AZdYqwcR3OT9jUsQ6soQCYx7Nqi8ASpF3a1Imz9zm534YcKjKF/VP9Mv7fbLpa4sJSqu8UIsx9Deanlv8nJxztoTXVV3EUXTguyCYJMxw4ERdHimzux5rpuAjTdi1cQFlTIDEa2D1dtRhg2H2XlyipocWpETFeuDI+IdOsKX8kx5BCEU1v3t5hqL9L0GC3rW11q418VBRpH6TCskaZbmokwyUOIdeKhMuX5m2tB7FunBoiTv2t0/94d8Sd80N0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMaZfwMg7kscBTvFuK8+PJMgAOzvY7usQCPgFp7luHQ=;
 b=V84ZXfWrlGq7E8+RpbQ4ZJJSY7xDLLCdBguhKRudXQL2WJKmQ70aT2z9GgLMSkvWrjUGAKfVeWHaS0vOa+sJhOHz7dAZlTTwcr/GA47s5dboWbTfLX1ZaUpVxAtTNkljg6I3Lo6HimYrBeP2UXg5BhSfzJshp80NgBAcuayIKkcZ0860MrgMiMYAc4ctXngYeHx85LJsT34nfCxFVuunEgcOJUM+yWGw1+MRFneejptjoHaHV+3d/gTfgERNcphf6HvgGqBDp4FXYCIa5Nvuizcm3FG0BIu3NLj4NRgFiMmQoR/ScTTCwmvHZC6ebmgGfbpd6X9vPFnp0U08oCUsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMaZfwMg7kscBTvFuK8+PJMgAOzvY7usQCPgFp7luHQ=;
 b=mOwGvHhvtugcFPnxqy3diEVKXPL7T40g4zr1CT3bOftuTW0ubrrOx0uHFkOOv4LCliaIitayPIdL2xwoaU2JiVGFR4OydQ0XFpr8RkAgd5Lh+7j/IwNNkBMqq6iH0stCZn1gShl93EFxNEXkB8cmgZIZ2EMSAs4K28n0K0vCrIIugSDqxjj/xh68+rEHz0iyhKcPHxra8FIJ04YjV37o7ujNhPrkdEZU1xFymf0NZ9UL4B63lq9KMU88fYPJ93G5xqEwby9fngGKbyQHQOKqkdAe30hjDfDNUAd5vNvEgy24yCk8bklObt8QtFh5D/pukJEB/U1Psh7z0mhcOy9sEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:46:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 18:46:26 +0000
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
Subject: [PATCH v5 0/5] Better split_huge_page_test result check
Date: Mon, 18 Aug 2025 14:46:17 -0400
Message-ID: <20250818184622.1521620-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:408:e8::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: f8483a6b-da6a-46cc-99c2-08ddde878947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hgbZp32hyKVCwwa7ppy+TQzh2crWZbzV39vb+Rc6sYXKT0Kjk1c6V42NwiGF?=
 =?us-ascii?Q?l1loP3Z8h55m86i1iHpbq1a3OF2tPp2bth0JW7x9PpqftYuLHQFT84XouLi9?=
 =?us-ascii?Q?iFMA7YRL59/+fn9QEq+BDOceOIozD7yuvAu7aPD02ACr9zUPWvYxPIq1LBiW?=
 =?us-ascii?Q?biXSBBnKvHZYaYMw5dGheHUMYWi1uyjFK+xq40gTTAtCJim0yUUjom+w0TeZ?=
 =?us-ascii?Q?aM7XN0daLFRrXLCJjf0uQ2+qNf1/mMGGui/4gkX1XRkpWkQNLsHs/nM7LBlJ?=
 =?us-ascii?Q?WNM+rRB2eEt6mIAL6I/kvGcuxqqzlLcbdaqRyeAizHOhZXdjTlFizmQwOYem?=
 =?us-ascii?Q?rKaJKFtpDJGjU84604up8JKyzyOARidRlSpGDHLZ3yCAlDKExgURYsXYz8uF?=
 =?us-ascii?Q?RuzCYCh6+G568vpAc//lsxFo/xdBnUpfyxPKIsJYO4GlEnXbQX9SxqKHyMXQ?=
 =?us-ascii?Q?v45ZMvpMZWxLKp3rvy6wUkE8iYsJAYiW9awtdk5T3/lKSD59ZCpcf+n1h7QX?=
 =?us-ascii?Q?X+RYfg9UfjeZjjb/OsTdHTZI7iccLjKb1HVY5eGUNBgbMYxrKsNEUp5EO9RP?=
 =?us-ascii?Q?5yQ9OsUF2y5qU9uyS0AOwvY7d/8pa6JUer3zhFkPYMNQs6Vvk/OlYrezNAa0?=
 =?us-ascii?Q?Zx2hx4FLpL6G6M2XULWDgaB8PtTknpMdyHNQZflD2n8v7NF7dKJgA3zOU6pO?=
 =?us-ascii?Q?V5RLKyebrjiVxU6QInZFPV6UGktMeQRu5wnnIHJdjcvmaVQoAbqASgwTcF+n?=
 =?us-ascii?Q?vehXeG96FFZfGAkzPM4TopV4JEPBPy5X8N9br+6MvSgcBIL1iW9uY3jy/onh?=
 =?us-ascii?Q?VfP/TQkB5Q7zKS9mlYEw7OHN7z+HEeHG9C/t6sWiCA0Jb/li5zLygQ53Ht0j?=
 =?us-ascii?Q?ChDwV40xUMc/lMHv0YFidSVZMVqOqDcYTj1lWUtqPcv+vGBzQcI3GLhpZRq6?=
 =?us-ascii?Q?OLSrl3nWTIypjY0j2LPpWDs7tUeTJa9b5IAfKiHJV/+wsIXmP2HlEY5W9IHp?=
 =?us-ascii?Q?RSNj4fL/QS6VYOBMkEkPaYVN7Z4sgdG6kVxZ9iTTkbbEarAlxFPmC29KAQ7D?=
 =?us-ascii?Q?O/hCVVXuxTaXUKVofHV55lgEx8AMQxRBRQd7HMY+aFInY6F1zXAVj5fIKhuh?=
 =?us-ascii?Q?ELUcrM/ymDqxLJwAvPlGJH6UThoHrH/q5KC/A19R5xk09G7hn42cJOhk53Rc?=
 =?us-ascii?Q?ozR8xi1puIrwUNGAaZ5q2hmD+WKp1BeAqfe3/kC4O6lYSrzK4jZLZpyYztvT?=
 =?us-ascii?Q?TtJ0bZbXujg5nSfaOXFZnsAwRAhCAd0296cD7FAe4pY6Q3gFXJjFktS0kWVp?=
 =?us-ascii?Q?2GWNgjw22Rh8BSys4I9HLd3fb/v+veqr/hexx090Mvx4LvZTBH5TURcgsYzT?=
 =?us-ascii?Q?F+qhXbzkX01sAPt5Yo0hU+Vn+C0P2fBXI8GZsPmhGDfGiqkwryUfJWFKroSr?=
 =?us-ascii?Q?3eSqtwhcwZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VhQLuusqjTZOcQjPgop+5IuTaqp32rGU/p6cvEz7MZbDmp/8ENNVlEhg0o/z?=
 =?us-ascii?Q?qFPqQZQuIQc0j6mO4pyv4ToKHJg9STLO3C3VOY5kL8il0RTQsFWtHCd7ENLt?=
 =?us-ascii?Q?QtUaM+kOgn4xjMKtaJePhe3wWBWM+4BlGwP4mumw/I9dHgv81Y2Q4uHCehsQ?=
 =?us-ascii?Q?2F5actstKi8TxgTD/TeHKLF0LOBF3fXFdjD2eUb9v1zCY18IPyXd0ZbwEyRF?=
 =?us-ascii?Q?d9BuH1UbwS0wdTVMuPHLwZi9q1UDmzybuF41B1JZFZOZG3bZlz+Oj//8AOrL?=
 =?us-ascii?Q?MCoEGvBvAqv58ms2voN3R4EEYymmlFw/DnVGXwPHi90HxsD/jqD1RllF/aW9?=
 =?us-ascii?Q?N84a3xXf8HzxvRiM+yNOBxcxeuKk4EXBZoDMtyepV6clKwafSywi34ivexb3?=
 =?us-ascii?Q?XuLVMFem/fPqQIoO5PnBzuO5s2sZPLaWoamnvVsfecOVJ2fAoCx07tSu32Aw?=
 =?us-ascii?Q?QKR3uGGd0KyfTYIxQsgfMnrslMHdMsSdzbQ2CdISSEn+Ekr5EWP97LkOMjQ9?=
 =?us-ascii?Q?2Xiy0pzyTUnOA+m4dS3gQFsLquM+aMGh2WwQ4bzqmLjPWdw2SVEYMfMMVTUg?=
 =?us-ascii?Q?kCPajli8U/sXXCZAKZY+qF3HWu6TV91M8AFB40ObuLA/LUCwCncH5QXRTW3t?=
 =?us-ascii?Q?+Jh5F02c40dGyzeF41KBu5lEzygM13peUKbgtJuQbhOUkFEHOWeQljpKhR7G?=
 =?us-ascii?Q?OKgvmCk9kqJINRTdxCp0if5YJLvCzjuEiQn1tBK4+eBSn9zdoxYf33X/KyE7?=
 =?us-ascii?Q?wRpT6cRKUSowfLSyf6P0IPLTKf/wQr1WpDTUOMPUv0z0vQ1aalWF4pm0tvwf?=
 =?us-ascii?Q?sQXBh92IRvukSWQ/6CH5iKvXWNrdvqSriDhYrsCYlxpWE7j82EHPuiNHj98O?=
 =?us-ascii?Q?uzllMN7MMGJHZjI0RdZe0tjXD/ocSS/fg9pOLyljKGNw9RsJ5vCWCasTjT4x?=
 =?us-ascii?Q?wFpzL7hdtJuDlVVte1SWbRsfOGcp8KkUjfe0Uu1Lq8GanFBjJb0xgDIdbJdq?=
 =?us-ascii?Q?RSY8CTiozGNyUrMt9UoXEQX5I571i+o+Z8E3ftIb3VLVHZenwrUgbkPGnaeC?=
 =?us-ascii?Q?sve5Pq/T2eWrdcBkRxlm6d0iNXuvxSGm22zLeQRQkF9CIzx8wVtLPkhnb5qp?=
 =?us-ascii?Q?iE1nA2tXC3luCJMZdHnqys9t2GFopiDn6OhNfZl7alh2T1wqY1DkzDABwdo2?=
 =?us-ascii?Q?M+PWcW1ZY3aKPgmeEZScTuHssvYKaSdfEaX/PejT/Ac1Avayg6cQ6MUspjew?=
 =?us-ascii?Q?A3YKGPprcID/gALei4aufyTSLJ0/flc4ANUKUzTdC43+RV0q27WutAyvPrYv?=
 =?us-ascii?Q?DRg+F1QLJlpm8sn12ou13YsEZkIOtAuKAon3lk2LE84oO2ixFH49BI0nMlPg?=
 =?us-ascii?Q?frSw51KXXLqB7yJPWC/nV9ZGQW5QjvXficC/6KlWMY7LtYIF7CXKTHh1hmLs?=
 =?us-ascii?Q?F00P82o/qV6H9oy4j1L9/CtdWkmTeeTw7vgB67Uq3TQk4bGPePw1HVRUBbN9?=
 =?us-ascii?Q?qziaY6fvGtcUvrV+Aa1tXnp9+p61WrX1I6yiNu6gHi0JuArMFWBJ6vBV7xx3?=
 =?us-ascii?Q?RUR9Dv9f6BS2+iWfu7JsrNcrV2CN09NrLWkAkc1c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8483a6b-da6a-46cc-99c2-08ddde878947
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:46:26.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOoIGbi044uOm7w9hS65QLHEFn3w9C9DHwZVYkT8SkB4bkkO+UU2YOkbFU3jcZ3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

This patchset uses kpageflags to get after-split folio orders for a better
split_huge_page_test result check[1]. The added
gather_after_split_folio_orders() scans through a VPN range and collects
the numbers of folios at different orders. check_after_split_folio_orders()
compares the result of gather_after_split_folio_orders() to a given list of
numbers of different orders.

This patchset also added new order and in folio offset to the split huge
page debugfs's pr_debug()s;

Changelog
===
From V4[5]:
1. Rebased on mm-new.
2. Changed is_backed_by_folio() type to bool.
3. Renamed get_pfn_flags() to pageflags_get().
4. Removed file descriptor checked in is_backed_by_folio().
5. Renamed get_page_flags() to vaddr_pageflags_get() to clarify its use.

From V3[4]:
1. Renamed {gather,check}_folio_orders() to
   {gather,check}_after_split_folio_orders() and moved them to
   split_huge_page_test.c, since both functions are not general enough for
   arbitrary folio order checks in any virtual address range. Comments
   are added to clarify the purpose of these functions.
2. Fixed file descriptor error check.
3. Removed unnecessary statements.
4. Fixed is_backed_by_folio() tail PFN off-by-one check issue.
5. Added a check in is_backed_by_folio() to detect if the order of the
   backing large folio is larger than the given order.
6. Moved misplaced comments in is_backed_by_folio().
7. Added a comment and a commit message to clarify why the split range
   of folio_split() tests is changed.

From V2[3]:
1. Added two missing free()s in check_folio_orders().
2. Reimplemented is_backed_by_thp() to use kpageflags to get precise
   folio order information and renamed it to is_backed_by_folio() in new
   Patch 3.
3. Renamed *_file to *_fd in Patch 2.
4. Indentation fixes.
5. Fixed vaddr stepping issue in gather_folio_orders() when a compound
   tail page is encountered.
6. Used pmd_order in place of max_order in split_huge_page_test.c.
7. Documented gather_folio_orders().

From V1[2]:
1. Dropped split_huge_pages_pid() for loop step change to avoid messing
   up with PTE-mapped THP handling. split_huge_page_test.c is changed to
   perform split at [addr, addr + pagesize) range to limit one
   folio_split() per folio.
2. Moved pr_debug changes in Patch 2 to Patch 1.
3. Moved KPF_* to vm_util.h and used PAGEMAP_PFN instead of local PFN_MASK.
4. Used pagemap_get_pfn() helper.
5. Used char *vaddr and size_t len as inputs to gather_folio_orders() and
   check_folio_orders() instead of vpn and nr_pages.
6. Removed variable length variables and used malloc instead.

Link: https://lore.kernel.org/linux-mm/e2f32bdb-e4a4-447c-867c-31405cbba151@redhat.com/ [1]
Link: https://lore.kernel.org/linux-mm/20250806022045.342824-1-ziy@nvidia.com/          [2]
Link: https://lore.kernel.org/linux-mm/20250808190144.797076-1-ziy@nvidia.com/          [3]
Link: https://lore.kernel.org/linux-mm/20250812155512.926011-1-ziy@nvidia.com/          [4]
Link: https://lore.kernel.org/linux-mm/20250815023915.1394655-1-ziy@nvidia.com/         [5]

Zi Yan (5):
  mm/huge_memory: add new_order and offset to split_huge_pages*()
    pr_debug.
  selftests/mm: mark all functions static in split_huge_page_test.c
  selftests/mm: reimplement is_backed_by_thp() with more precise check
  selftests/mm: add check_after_split_folio_orders() helper.
  selftests/mm: check after-split folio orders in split_huge_page_test.

 mm/huge_memory.c                              |   8 +-
 .../selftests/mm/split_huge_page_test.c       | 342 +++++++++++++++---
 tools/testing/selftests/mm/vm_util.c          |  13 +
 tools/testing/selftests/mm/vm_util.h          |   4 +
 4 files changed, 308 insertions(+), 59 deletions(-)

-- 
2.50.1


