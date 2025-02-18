Return-Path: <linux-kselftest+bounces-26911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8516A3ACC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659F416B2CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42021D86CE;
	Tue, 18 Feb 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6CaUWRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8FA1A8F6D;
	Tue, 18 Feb 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922623; cv=fail; b=q1BBQL+YvQmIx7o2IZbEbQw1EnnVXJ5ERhSvIoxSzxsKtP6l1aPuZLnJ5Sy7QnSlexhtSwkVbuBWqh0mSrXnqUj+ybXWzab31V4hk4SZYeAcU9bF7eLR9O/eqegd+a9yi4MpmydE4geASJ4sxiXbDyMcaixGzl3s2ea5mGgzeg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922623; c=relaxed/simple;
	bh=i3UyFoOzULfKXeP4xm1A8MyLlEonRKF1R1y5h2xeeRU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WmUj+DL/3alenXwx2ZsbYvjR8Gtkfgq88F6BnwHQT457rldGMzwADATJ0BdQ3WeM2L934Pla5jAAKljScABGV1VbqFEmwE8veyWuZjPi6pWembdD416fAnFQFG25K1IiL8vdttiB9vi/rKYIC5vbThWpVp1t2WWGnme1VToFt0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6CaUWRU; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK3P01D5R37Bq66E3i9ersHKGmfvWtFE2EJiN1tLXRgEFQZEf8v2nR0EYexQ06xsu2AFfoaDuUQLE44i2QCiSFOieyrxPs82cg4A6qOyMTh8VIVS787lRSIiPNPo68lspG1S/F/p8rjL6eGgyjIvoi/qcGA2NzNAl/qD7BH7l2LDQvtMIs8w3lyuNgXWpJu4K2DCsbfLAvSvpjl6e2MAavc7OYGBF3a3VCu/253INfdtcgJIX4P9OajJIIR12Y1bn01ANZK70n5SrxHnGWvxGDt+9YQaKvCLSSC/EN3Y+pON/Na0LIzbXOorhjT58OYC1WF17TSKGlylbNAPUeIeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIQCg1CTj3Cy9Ox+HpgbxaMgQYW2Z7nw4/i/ZgUYxcI=;
 b=RxZHYtqrJkNMB84TknW7fmLZ3fhWmmOymr5IMi1GTQ8zn/5ednMqTXXoRV/hzlt9Bs2+LUB5toFlTbAyD1ZbDOp7w/1jas/zKkx/ZJHE8Wb+Ed8O5AViTfL1PHivgW82pIMMIkj05pZDCs9dET0aPKObMHAq2BO+8Lsb0hwNKUIQbteSmVD1o64f8FdQLkv1M2f+UTz+vM0MTUuk0SLocT1XslGaZhlL6YFUsWBHnsOriE0qAPt3TeC9vDv6vhMDLMJCQQLS5v4VwLLCcBHi4E6Xnp7JzTfdjkmYvHWwwAKEsbG91mteZ84EPCGUeLX5oU5MGACjhrvT4l9vG5t5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIQCg1CTj3Cy9Ox+HpgbxaMgQYW2Z7nw4/i/ZgUYxcI=;
 b=X6CaUWRU6a+1qXtJOc2lX7Mt5zUoqhIaP6EkEafLXg+XLlUsAOJOGIop1qC4wxf15Rw81h7nb5y/miSQQIsTiqBqcs5bYqj7cI4lI6Rmen5ee2KLmcqD2e+9JFZ8LMpY4jidcsDboObE3PwDhm5DG7zEP5pP20GQu4z6fy9orGQLQcTykE4aXB/Ers1LiKYduh90qjSsORP3wqD7z8YJv0V0j+iVJNun3L/xq7/v+C6MhVAQMVTAzCft1tY0Bxql8au8M7peMbsCnFnPg4LGoejBtkXQjzTsK/w9rgJp9/ReaPXA5OiiZ6yNU58W1ygQNC7zLiK/xj0eibQxARndmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:17 +0000
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
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v8 0/8] Buddy allocator like (or non-uniform) folio split
Date: Tue, 18 Feb 2025 18:50:04 -0500
Message-ID: <20250218235012.1542225-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 105925ff-c920-4b5c-47df-08dd5076ff20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxV7MOYZFhkTk76GVlbMxqN05e9ReP58rEqyDI4D6KmtvTls1U0WyQsShRdu?=
 =?us-ascii?Q?g1Fh4ENy9ytujcB95k/pMYwjX4D1xN+2Z+Sn6KSxeewliGaCRA122ye2W06c?=
 =?us-ascii?Q?MUENrVtAFQHK1CzRFR6MMKAp7cv7b/3YJr63ZCYGnUzpp8b+Jbhbr9JpA00U?=
 =?us-ascii?Q?4oxJL4PwOeCU/L5zZKZaEieJ0jt5E8/r+39FcToMazdX2Cen1nRU+0fYt/pi?=
 =?us-ascii?Q?Q7Y2xBV2n0IUY/9Y15AW2z3tAzck+p75aB/dL6/3p88y65PLlljvJ73zsa0D?=
 =?us-ascii?Q?bU4JB34VufVkjTP1SMsWCtGgjCY/j8d0Lq+YMmub04Uo1F8lFav+vWEy/IZ2?=
 =?us-ascii?Q?F7PnKULFdtexxY5BLRHpL/cFqB1+YhnKXWxf5krPvNjpm6eZkqjXx8hZdGq5?=
 =?us-ascii?Q?qy2P3m8OvapS1ruNnU4T4F6A3GSRmHjFs3fw78G3Xyu1N9EPYBaG0BI5HKMH?=
 =?us-ascii?Q?AHrBu6Ffldm+ap3qdMMxBoAqnHBSVes1CQbFuQHLx77Q2fXBNOmNI2Tt5X4u?=
 =?us-ascii?Q?dc/q+SXDuf6LbVx51AIU+FTOn6Km0Th57wVnATWh/MFijhCPXQGKdUwGJ9lx?=
 =?us-ascii?Q?w1/bQaELKMvp19hb57HRWLDrlNCU4ve9fts0yobDvbSIEkzl28YcJId/XtNN?=
 =?us-ascii?Q?XnQzJRNVClkp9nLJWTWQT7yr6An+2yNlQkvrz0PUJshp+6spDxLWb0ApOfnK?=
 =?us-ascii?Q?9AUQVDjDlegmQ3X2nVRYvuYyNevvfwYyH5lTJo+QbL2bm/5zxigpEHBBzcAS?=
 =?us-ascii?Q?b8zV/kAoPMk+ZfTOb7r86ggPK/dec3JSpltu4IVemZPoxF52ZtKpnxjHPVK0?=
 =?us-ascii?Q?cKCrJVV6/yoQ5vSsIgvUbIYJFWg9IsI3oN0dKRjhTXWudzMyi5y0yVrD2KOr?=
 =?us-ascii?Q?86b8AwA3tyJnz3gdQ9k99yqSsQgz1h289KMYI+agX9P9EHozfMFhqmO4UjiI?=
 =?us-ascii?Q?fz2Eby/T2+k63rH5dzbTHBi7vU3bbYjn+Az0Z4c4mCwyOmxWDg3JX1F9hfVo?=
 =?us-ascii?Q?HisM7zPL48Q4F/SsZNAz5ae0IAPWllyscZrTppipoVLm1DyP2fLAcT8L3s7/?=
 =?us-ascii?Q?kIY3LsyhJsZGwDx2UYpL/YoecNL0hC4wV4AyM87y4KhTZRhPPC42UQy2yyQe?=
 =?us-ascii?Q?cyieJ7o1+LMj5K5vMZSiUbn2fqobApC26DJ8K/m8MdfOIYobTYuBiFCypn57?=
 =?us-ascii?Q?rWBvnLku8bHRvcAXVa1XvNaj1Gd2NLKAN9jQndBWuGuDekNUuMRwzzFsZELo?=
 =?us-ascii?Q?1MuOPlJGtEAxiVrfhyzrgbrB9nNUi0aZUjpvaNOfJo/ttZcao5mkSuHzmBFp?=
 =?us-ascii?Q?HAiMJtg7VdgMdMVCkC1eIYlbsJs32gRXgyvz2vXJV5zRr49unX0+s5Jnk1Oq?=
 =?us-ascii?Q?/g1rBWcW9sMWeiFP4jLsr+Fy6kjC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlvzTUfjYKxgSscrynelpDDPc4j229G583NlP7Zvm9lrwgXIss6oknuTaYoZ?=
 =?us-ascii?Q?WykWcc92JDOi8awbJnEnqLLIEbz/0U/BbXNOB3MJrSL9NQzV984oYGrH6P1r?=
 =?us-ascii?Q?exEP5wASIjuvt6q86/iUFgXOfxH4srh0I0MCi2ov/9piTdHivbvTjy5N2CMm?=
 =?us-ascii?Q?jIz/SnR9x3tatLvSyhMd/+a9GHvQSYR9ncoNlAuTt58JoDmVFmCZ2B43eIv+?=
 =?us-ascii?Q?BPQMHKwUm+19xliBkpCQe3fl0pbPI7YHmxeMj9B2jtOYmpyba6BIqapYHPx/?=
 =?us-ascii?Q?+AvQdrzCkU2tSahr7LqwkGv8H6nTDrATk8erakqeOJXbjYM6yvPxBNMTcARa?=
 =?us-ascii?Q?apcERr4ZkKbIWY+a/jg2fyk69c/gGCNmPbuNwUECCSXN1WPoLLJTLH8cgAfZ?=
 =?us-ascii?Q?gf83vX5BNszdY0t7JXcCx+6LV+vv3dd7JNTM9Naf1WmFex3XDszEnO+BhUzK?=
 =?us-ascii?Q?BD+H6VoA4doO7NSZVifxEs8RgWbvnkIVXJhVcFyLyWMGR7gLvotOZ72XEmFA?=
 =?us-ascii?Q?nG4wirxp6WzEy28Jmfa2jkELs1obkWhNr7rWuYTgCXe8dqXKVJCioq5TaJxF?=
 =?us-ascii?Q?ZshgTSLvlZpml1fTrKWg8H7eONxJ7a8bb/Mx3cnhtYNueeHGF2bCZyhsu5tc?=
 =?us-ascii?Q?fUtkA0ib3xnKmBYxjR9ZO4lEjdk+PiqevGB2cvBFYYJ0EDLoEIEG2DDUUzZD?=
 =?us-ascii?Q?dFDiYptKPMd7XaCPUFaYpWsgXBEkv4MVx6XOEOiTZWXpH++B4Wi54XA4KAgb?=
 =?us-ascii?Q?yGP9i3yP1qQn6a0XlOdZOcSQMGaiIOmWWUwjhd/iDveOkaMLVMXxYD1ht14R?=
 =?us-ascii?Q?qdJOab3Gkoat18K3dR/U1lGXSGV9ZKanTkncBEnv3ZMNH/RFKeMs42YmaLEB?=
 =?us-ascii?Q?h24Si2xwzqfdqK+ze6WomqWJijcZTEyD4kgjMCtCpKNop3ieNMIlHwkAOg70?=
 =?us-ascii?Q?DhCITsLuX4yNEhgK1hWW0NXf/+DW/j4hKLXp+OLjJqaresLIMWOPeNpn5sI/?=
 =?us-ascii?Q?izqFBfHwVRI93jLzj01hD1lIEjl9YCMKlo7bHr3OCozF7Z2lZl7IHVoGl+wm?=
 =?us-ascii?Q?wnC1J/9vjFUEomDxsLrlumTSWqhN1sMFlXg59N0KzzPgVLE1/UYQfXCS/hjm?=
 =?us-ascii?Q?99Sh9tI56gCL5i2e8cfKIjWeoSiudWezBNGuvfObL8HtDvq7eemFYRVGnFYq?=
 =?us-ascii?Q?+784LEfIW2eyiO5zzZxIS4XtA0ALMIyzA281EFIUWQMyK+BHH5UQ6jVD6P2A?=
 =?us-ascii?Q?d8xaXxt8XLP2BRidbWdu/XK1Ibb7Z8xIwW8mMBMXtVshTM8ZvdCO4HXLzaI9?=
 =?us-ascii?Q?nSXKbY5SZHLgpMXh7HzQ8rY7Iu6CY+25GLs+jbco/zdtvL94CeRlhvKCIq2f?=
 =?us-ascii?Q?FJc65OOkWqU2F9Y63COk4cu8OhkVPFgoSzLyJe0KqtM3EsSX3yp5qj+tf+9c?=
 =?us-ascii?Q?k0wESchQteYG3qAOyGF1JAvCG//JYhzwGdrNiiQ4151rxXarfcRxijSvRgit?=
 =?us-ascii?Q?RwkAxYkavDMs3CgoUG39eKmvbY6U+AkKEJH2FZMYH0I7fj9Ob/PUcrY3E2gA?=
 =?us-ascii?Q?slysJXPLikX2UPLU8I8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105925ff-c920-4b5c-47df-08dd5076ff20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:17.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXMecVqcEgy7Exm6r+m9V4p3lCqDjNakgWOBc5pFsy6dusEwsw5iss1drPtAMhdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

Hi all,

This patchset adds a new buddy allocator like (or non-uniform) large folio
split from a order-n folio to order-m with m < n. It reduces
1. the total number of after-split folios from 2^(n-m) to n-m+1;
2. the amount of memory needed for multi-index xarray split from 2^(n/6-m/6) to
   n/6-m/6, assuming XA_CHUNK_SHIFT=6;
3. keep more large folios after a split from all order-m folios to
   order-(n-1) to order-m folios.
For example, to split an order-9 to order-0, folio split generates 10
(or 11 for anonymous memory) folios instead of 512, allocates 1 xa_node
instead of 8, and leaves 1 order-8, 1 order-7, ..., 1 order-1 and 2 order-0
folios (or 4 order-0 for anonymous memory) instead of 512 order-0 folios.

It is on top of mm-everything-2025-02-15-05-49 with V7 reverted. It is ready to
be merged.


Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like (or non-uniform) split.
All existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

xfstests quick group passed for both tmpfs and xfs.


Changelog
===
From V7[9]:
1. Fixed a wrong function name in lib/test_xarray.c.
2. Made __split_folio_to_order() never fail, since the old order check
   is already done in __folio_split(). (per David Hildenbrand)
3. Fixed an issue reported by syzbot[10] by not dropping the original
   folio during truncate.
4. Fixed a WARNING when READ_ONLY_THP_FOR_FS is enabled. (Thank David
   Hildenbrand for reporting the issue)
5. Used two separate struct page* parameters, split_at and lock_at, to
   specify at which subpage the non-uniform split happens and which subpage
   to keep locked after the split, respectively. It improves code
   readability.

From V6[8]:
1. Added an xarray function xas_try_split() to support iterative folio split,
   removing the need of using xas_split_alloc() and xas_split(). The
   function guarantees that at most one xa_node is allocated for each
   call.
2. Added concrete numbers of after-split folios and xa_node savings to
   cover letter, commit log. (per Andrew)

From V5[7]:
1. Split shmem to any lower order patches are in mm tree, so dropped
   from this series.
2. Rename split_folio_at() to try_folio_split() to clarify that
   non-uniform split will not be used if it is not supported.

From V4[6]:
1. Enabled shmem support in both uniform and buddy allocator like split
   and added selftests for it.
2. Added functions to check if uniform split and buddy allocator like
   split are supported for the given folio and order.
3. Made truncate fall back to uniform split if buddy allocator split is
   not supported (CONFIG_READ_ONLY_THP_FOR_FS and FS without large folio).
4. Added the missing folio_clear_has_hwpoisoned() to
   __split_unmapped_folio().

From V3[5]:
1. Used xas_split_alloc(GFP_NOWAIT) instead of xas_nomem(), since extra
   operations inside xas_split_alloc() are needed for correctness.
2. Enabled folio_split() for shmem and no issue was found with xfstests
   quick test group.
3. Split both ends of a truncate range in truncate_inode_partial_folio()
   to avoid wasting memory in shmem truncate (per David Hildenbrand).
4. Removed page_in_folio_offset() since page_folio() does the same
   thing.
5. Finished truncate related tests from xfstests quick test group on XFS and
   tmpfs without issues.
6. Disabled buddy allocator like split on CONFIG_READ_ONLY_THP_FOR_FS
   and FS without large folio. This check was missed in the prior
   versions.

From V2[3]:
1. Incorporated all the feedback from Kirill[4].
2. Used GFP_NOWAIT for xas_nomem().
3. Tested the code path when xas_nomem() fails.
4. Added selftests for folio_split().
5. Fixed no THP config build error.

From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__split_unmapped_folio() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__split_unmapped_folio() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like (or non-uniform) split: (old_order - new_order) calls
   to __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given as a folio_split() parameter.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


Patch Overview
===
1. Patch 1 added a new xarray function xas_try_split() to perform
   iterative xarray split.
2. Patch 2 added __split_unmapped_folio() and __split_folio_to_order() to
   prepare for moving to new backend split code.

3. Patch 3 moved common code in split_huge_page_to_list_to_order() to
   __folio_split().

4. Patch 4 added new folio_split() and made
   split_huge_page_to_list_to_order() share the new
   __split_unmapped_folio() with folio_split().

5. Patch 5 removed no longer used __split_huge_page() and
   __split_huge_page_tail().

6. Patch 6 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

7. Patch 7 used try_folio_split() for truncate operation.

8. Patch 8 added folio_split() tests.


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20241101150357.1752726-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2/
[5] https://lore.kernel.org/linux-mm/20241205001839.2582020-1-ziy@nvidia.com/
[6] https://lore.kernel.org/linux-mm/20250106165513.104899-1-ziy@nvidia.com/
[7] https://lore.kernel.org/linux-mm/20250116211042.741543-1-ziy@nvidia.com/
[8] https://lore.kernel.org/linux-mm/20250205031417.1771278-1-ziy@nvidia.com/
[9] https://lore.kernel.org/linux-mm/20250211155034.268962-1-ziy@nvidia.com/
[10] https://lore.kernel.org/all/67af65cb.050a0220.21dd3.004a.GAE@google.com/

Zi Yan (8):
  xarray: add xas_try_split() to split a multi-index entry
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface
  mm/truncate: use buddy allocator like folio split for truncate
    operation
  selftests/mm: add tests for folio_split(), buddy allocator like split

 Documentation/core-api/xarray.rst             |  14 +-
 include/linux/huge_mm.h                       |  36 +
 include/linux/xarray.h                        |   7 +
 lib/test_xarray.c                             |  47 ++
 lib/xarray.c                                  | 138 +++-
 mm/huge_memory.c                              | 756 ++++++++++++------
 mm/truncate.c                                 |  31 +-
 tools/testing/radix-tree/Makefile             |   1 +
 .../selftests/mm/split_huge_page_test.c       |  34 +-
 9 files changed, 783 insertions(+), 281 deletions(-)

-- 
2.47.2


