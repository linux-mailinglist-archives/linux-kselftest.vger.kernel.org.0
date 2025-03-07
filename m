Return-Path: <linux-kselftest+bounces-28512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D0A56F59
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174643B16CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297A2417D9;
	Fri,  7 Mar 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KnP9aI11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBD2459CA;
	Fri,  7 Mar 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369226; cv=fail; b=tqA2sAa/SttrR4qUDPtO8PF7LW81pxR8x5U2a6vLp3DdaUOR9gvg/qZVQUy4M/oyI+9eE7k7wdFJjdL3eJDL726WsoHAqJ2T++JMqaEH5297FslUQMteNS4j6u2v4x6Trmep98rrvQ1OmWFhpnJEezJTEcsEmmPr5GWt8aqQglg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369226; c=relaxed/simple;
	bh=zjMywJXy/0/7sEraD5nt8R/1Sb++/SLBR+WjyDwn2uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qoNKQ3boP8nFCFFqO8Rs2ThiGI5OBqpNGinKRBXwM6xnFkb2eqFMQqfVgFhDH6+gPEQ+eMqrVjoxEZjfRVFDsy3qsFLgmQ9njObja9ajHlMVKPgpwlfuwJY/A4pW2G862LQnH/hk7Zxe1oYwQP0E0Vn8prapvIzdnvxQW42WYbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KnP9aI11; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmQyDPT3LQm/9KrJAvVOpCgaBllJl7yMn6m+fa77CKotpYh224dQ71TnQJhmDyuDecyIfvMhcqZlY351dI+5uNL2DfFqUvQCdpXQUe9lbQsODneIaqzTm5fB0e8wORoSMeqfV5oOZCKDAkykvqtJfsRiSLQe84H5Cave8U9u6E4G63VcwVUTOcR4Uqolw2bs46fHPBS0QqV0drUx+31dZJDJUqqxe825+ww0s3BE9OfVyxxpHjH3stY6gLuTTYaM8nuJAGi2bT5muqV6fdU0WzDL+H2le1UBb96fq1G4gQXgDF47mTrv0kZKSIyGzUYCfP0awG9k5dfKTZi31RYQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyxwjhNAe16++5qZINdjjuM142tYqzuQZ3aY+eriH5s=;
 b=kK0Rsvg3iMPAZ662JxFofo8mQ7K70uId9k1aTiWCG6w9Wce/XFHDCakmwbjPY5W0GacfuW5BBeOCm4u21yDfGM5boVv5Fj+0dO9jvfNWJgN40oknjNkZJGd27MzZjZItij9uhr0I/GhhNZdPrVA92H+k7BdI9MU3tpBBFLo2jRI0TdZdGfax0J/cFBB20qCgmytsvLHT+ZPOKbgzpyMKhGtVnAk6JpVoaqxGMj5tuzXtA78NvZdyCLRqfwyMD3n27mlsvoeOGlD1ZFTF6IDmMeTJEbbP5+Sh3maRiGd7XdvN8Efm53fVK8dePmwHaQh/PwF+G9lkhnnDGXENILkKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyxwjhNAe16++5qZINdjjuM142tYqzuQZ3aY+eriH5s=;
 b=KnP9aI11ddoBKj3nOIuDI+qeM/89uXcXMXxSmEHPDNzn3E0rtR2LfYJjjxe0DYeDz+SnQ8FEk858OhipXEVymrtOJRycwgXt0wcSlGif5kl2KSyJgJLlhxVkDyXh2CMQD4Ut7BS5ByMeYpyzS/wJw6w6bJIg/kApCdxqd1+hJCeRF2Ara4mzll0c+hgx+Vus+WILJCpZZNUurNpOWoS/HGQTPJQYpZyvLiJHF7E1TksNiuzjIW/iP+AMTdrMYDdzIvlIEQdiTno7deui1dBmmGIqXwMKWFJHee9nkaErXARCxIe7RdyAUDYZwC/axb3muy5bfLjtYaGS5UOA6RVc8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:13 +0000
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
Subject: [PATCH v10 4/8] mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
Date: Fri,  7 Mar 2025 12:39:57 -0500
Message-ID: <20250307174001.242794-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8ae57d-d34e-442c-848c-08dd5d9f1d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQb5mWKJ6O0sAPOcuUZfQ9mxi+u+K8fNTRyNSvf0uZbq/56Bs9hZusIXnCNW?=
 =?us-ascii?Q?wElxyB6R/u7oVgBrOfceFYMo0Hhdo2uq0yyDeFzftWsMYak1BE60fFJd45aE?=
 =?us-ascii?Q?FjyeJsNqcGgnFlj6zeGdaq8ZJmsBVir+QHFHPiljcoIkQ05+iTfH8jiiUF+R?=
 =?us-ascii?Q?LHG0Vz8tq6py2g0lwALeROYAEoEgoFKpm87PaxxbxE5kGhRPqsmgG/9Nog46?=
 =?us-ascii?Q?VS4CZvx/9S2ZQMrPuaD0Q/5HnTjGahnUlxL4F8mVk0pZefJ4nCUA3E5Htix/?=
 =?us-ascii?Q?eZX3yY8SLuGKSfED5HJu9k4cOZj3nCfd4TnjoYas56qxFHj9bF/bkBVU/JW/?=
 =?us-ascii?Q?aO3frfpJF3xWDs9Rdzxub1A/iiS1lQ8AWu7yEPOwxtoyUNe1+jahQHOGLNwo?=
 =?us-ascii?Q?VU2/y3cObhqiGfK6rxD99K3/AQnm4jDilVDCP5m53ykB5Z+kk3KiwGR16TP6?=
 =?us-ascii?Q?O1SJn7tkOjPeI46rZfGN1AK4GooDHkcW72x7Rry1Dsg6VcKvCdQQ9HCPPSzc?=
 =?us-ascii?Q?jRmZpvFUSu9vrfZzbifaDNHAaCeBQZnvpx1qAkAQsKUqN1RfUQXmrlB41VnK?=
 =?us-ascii?Q?8Bif566KshtdLlhTvNzzSoN55Jz3MAitgTFiZRUHNXXSxNyaHjDmsb+sDpIg?=
 =?us-ascii?Q?Dhx+B5W1Nwgo9oUZ0CBgxy86lcPVSgT8B34TtevnaeW4hFFjwSV+CvO1Pq8Z?=
 =?us-ascii?Q?Pqnfz9WEPE3jAl53D+n4MtSbjNdMXL6IsPIwXyJnViUIPuIXEh+HeEcTzxm5?=
 =?us-ascii?Q?FBcFNn7qrEPpjQFiFiMeL5sRaBmnYXhehJGL1kfEEAQRufAM3Ik4dNDZIGsX?=
 =?us-ascii?Q?hIwQrHhUBjvvNA9p8vZDdvpN1TEQMu0f7s0xptFDttS5Tcb6GZ06EN5lHubZ?=
 =?us-ascii?Q?7O+HFpn1BbBfy6lF08eRkxLj12vtQUl9bEi4S3w+41FvSFbB4GsHh9Ql2kE1?=
 =?us-ascii?Q?mCZLgogFHsGRn5SfwpUziUuI0LmxDnuFUb6WNdTqCm79HSFfQHtjXLJIG1GA?=
 =?us-ascii?Q?9KjyizwXEmGBq1RjWDtoDTUdLcQpWwaKrp3WzxbzzWmAfsf9lBRKaMqM8sTt?=
 =?us-ascii?Q?2bpO2kCVGxmvp0mZNo0AFu05E9r3bl1/P+yTexVn7cP4augRsIZUtEEZnqO2?=
 =?us-ascii?Q?pHiAnr224nR3lUmw31oSqKTAKRm0O1VRTMGRiAw+Jr6GmBRE1wctigu32tf4?=
 =?us-ascii?Q?DOUSMjK7BetmHU1hCMXxBm5agwL5Sl95j6STz7Ep/9DQHsm0G0290Q/pZNfp?=
 =?us-ascii?Q?zd0ngr+ZWiKsZgyrjD6YYPSuKtjYq0zYB4qZeFVaHjtcyVHIfSvcudYdVZPT?=
 =?us-ascii?Q?j2JAoin2lQt5djChIKjbrKqVxHah46eRi8r97GHt9kmT0LPmWQzWgWwGj+BP?=
 =?us-ascii?Q?hT5xdQFPOAPhjHMAt33CeN6xgh0s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r4VhafHT6sCbbV8qKWs8O76MEEHcnzWXTI5lZ8v9NNHy0MLk3Chz5fAh5rIr?=
 =?us-ascii?Q?pDEiZ01LRrhf0kNvzXL8Uj4XdOHPVf433ZDxzwQsiuT33WwOZft+H6yOZaca?=
 =?us-ascii?Q?oyv4Iyfxy4pC50HWogU8ZghkmqqobVfchOhLyqDf2miPdEmY7XzYwy5OVskH?=
 =?us-ascii?Q?d7iSaVRenXcQ44Swp6W8BpUUlYSXkOsLEZ04XzeRW47IrBjvWOQ/b3FPPMAx?=
 =?us-ascii?Q?gxV6p+J34NH8+7/G2MwEMEuzbkdETlEwMsxN0DljETwFrKqLsjuRrPVMVjhY?=
 =?us-ascii?Q?kaaveRqgtzZfemvlUygi/m4mqlCzrPYQXHpC+ooMYcEdtUeo2rxa/F1hifGh?=
 =?us-ascii?Q?0bbj7AM3RwTPH7HX8NPUaqzmtPbbDnOslp/3DEjOJxKzymZEE6FutUrjNFC7?=
 =?us-ascii?Q?RokGlxTESL4Zw+OSTQ9yk1M1eJOR4OfVnXU7/Xl1X+6jTLGG3G8tMnaGWh9p?=
 =?us-ascii?Q?XrRAB5rFCeE6hcxIhT5dJE6f4U1IQcFY7NgZ/X1ltb7qXP1QEocw4JVcgzwb?=
 =?us-ascii?Q?EFTx/KmqsEQTibC2RLbfm01q8vCh7Jx+1F39THE7aQ/2T2B+/wLGkCPTot3x?=
 =?us-ascii?Q?733W5dThlMHIhyNGSvlN2fVKBh2yGbK0v3or6tHkC++52VwISnRvXDw1uiNj?=
 =?us-ascii?Q?7SBTp84zkekkzrzqh4p0WZkL27k2f6XO1JHF9zPLjsbSjjKRN/TAtcygU+m9?=
 =?us-ascii?Q?ubT7FyulS38f50QIZb4hcRoX0n/9SG97X06VYVCkvb4sxXq3h8bgN9I9zUhV?=
 =?us-ascii?Q?GL/YHuHuYfNpQGj7pT7xE18NblKxrXKtgpxsnmy7KaJDzPakFxIvpd9tccM8?=
 =?us-ascii?Q?nUqJxycEcwSVwEjYF7PIkoA3YxWFcarKcjSI5N0P0cb1QP5KL3cCjIEG04Jf?=
 =?us-ascii?Q?6eoE5n6lRQO/4wX1LNqVQ0F17tL3FfA+uFcyDtg1rMcY0zLaJWloLS7reDcw?=
 =?us-ascii?Q?ODeLis1k+NcL8kOwWNCx5YQBUrL53RMyWY/aO+n7DA7auoDz8HAXk7ETqZhh?=
 =?us-ascii?Q?bq/pGimaMhvfIvTUnI8PqC9pkKupreq+7d5IbkK18uTzunHzEB7FX9ck6uEJ?=
 =?us-ascii?Q?SwvIHRsIRvfBnFqBCbUbOa75GD7Q+Hv8GcbWLbrmUccoltiqBMVyVLL8+SlQ?=
 =?us-ascii?Q?1L6GnoHGZrhaWXGpEI6DWcQjUcOgPlo3WPDjsaCeSF5B6Q3FvppKfKaLF18H?=
 =?us-ascii?Q?ZdQxOxhK93Lyutzioip6MGm+WNYd+uuRlMs62bT9Q9ju3hkcf3LPfzEHso+V?=
 =?us-ascii?Q?xn4VrxhMevlMidhDDPIV6kroeOtmzBDECzB4oqDHQNTO4nzbc9ZbRL1KGxY6?=
 =?us-ascii?Q?GMm2BEHAc9T+OI9fPQdexxt0bxQmjc3wjwNSNraDnWBbUSTbh47/TDGvko2z?=
 =?us-ascii?Q?DsQns0B/46S+DWrOyuhnqK4Ig9cilV5DgJPGeQ2pIjEOdr177xYGJ6RN7KJB?=
 =?us-ascii?Q?fZjCkqitN9voRYwRT6rdfdMqr/5I9mCTb63WUTlGPiT0cAwdbYQSjsRG1YTX?=
 =?us-ascii?Q?anLywmqoYPL24xQiqOlks2PdDRzw89BJ8oBlPYAcGRs+CJ8t2WsBGFugY49x?=
 =?us-ascii?Q?xV5mOsl7NxbwX9KPeis=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8ae57d-d34e-442c-848c-08dd5d9f1d56
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:13.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSvtka+1DE+TNO2ec5Qa4JtwRQbBr4tQGcvi1XxqrGGur+jtIekMMhvbBDuB745d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:

O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
since anon folio does not support order-1 yet.
-----------------------------------------------------------------
|   |   |   |   |     |   |       |                             |
|O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
|   |   |   |   |     |   |       |                             |
-----------------------------------------------------------------

O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
---------------------------------------------------------------
|     |   |   |     |   |       |                             |
| O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
|     |   |   |     |   |       |                             |
---------------------------------------------------------------

It generates fewer folios (i.e., 11 or 10) than existing page split
approach, which splits the order-9 to 512 order-0 folios.  It also reduces
the number of new xa_node needed during a pagecache folio split from 8 to
1, potentially decreasing the folio split failure rate due to memory
constraints.

folio_split() and existing split_huge_page_to_list_to_order() share the
folio unmapping and remapping code in __folio_split() and the common
backend split code in __split_unmapped_folio() using uniform_split
variable to distinguish their operations.

uniform_split_supported() and non_uniform_split_supported() are added to
factor out check code and will be used outside __folio_split() in the
following commit.

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
 mm/huge_memory.c | 170 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 128 insertions(+), 42 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 871c260163f1..3e05e62fdccb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3863,12 +3863,85 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio)) {
+		/* order-1 is not supported for anonymous THP. */
+		VM_WARN_ONCE(warns && new_order == 1,
+				"Cannot split to order-1 folio");
+		return new_order != 1;
+	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    !mapping_large_folio_support(folio->mapping)) {
+		/*
+		 * No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
+		VM_WARN_ONCE(warns,
+			"Cannot split file folio to non-0 order");
+		return false;
+	}
+
+	/* Only swapping a whole PMD-mapped folio is supported */
+	if (folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/* See comments in non_uniform_split_supported() */
+static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio)) {
+		VM_WARN_ONCE(warns && new_order == 1,
+				"Cannot split to order-1 folio");
+		return new_order != 1;
+	} else  if (new_order) {
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to non-0 order");
+			return false;
+		}
+	}
+
+	if (new_order && folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __folio_split: split a folio at @split_at to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @split_at: a page within the new folio
+ * @lock_at: a page within @folio to be left locked to caller
+ * @list: after-split folios will be put on it if non NULL
+ * @uniform_split: perform uniform split or not (non-uniform split)
+ *
+ * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
+ * It is in charge of checking whether the split is supported or not and
+ * preparing @folio for __split_unmapped_folio().
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ */
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *split_at, struct page *lock_at,
+		struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3880,32 +3953,17 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
+		return -EINVAL;
+
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (is_anon) {
-		/* order-1 is not supported for anonymous THP. */
-		if (new_order == 1) {
-			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-			return -EINVAL;
-		}
-	} else if (new_order) {
-		/*
-		 * No split if the file system does not support large folio.
-		 * Note that we might still have THPs in such mappings due to
-		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
-		 * does not actually support large folios properly.
-		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split file folio to non-0 order");
-			return -EINVAL;
-		}
-	}
+	if (uniform_split && !uniform_split_supported(folio, new_order, true))
+		return -EINVAL;
 
-	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (!uniform_split &&
+	    !non_uniform_split_supported(folio, new_order, true))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3967,21 +4025,24 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			goto out;
 		}
 
-		xas_split_alloc(&xas, folio, folio_order(folio), gfp);
-		if (xas_error(&xas)) {
-			ret = xas_error(&xas);
-			goto out;
+		if (uniform_split) {
+			xas_set_order(&xas, folio->index, new_order);
+			xas_split_alloc(&xas, folio, folio_order(folio), gfp);
+			if (xas_error(&xas)) {
+				ret = xas_error(&xas);
+				goto out;
+			}
 		}
 
 		anon_vma = NULL;
 		i_mmap_lock_read(mapping);
 
 		/*
-		 *__split_huge_page() may need to trim off pages beyond EOF:
-		 * but on 32-bit, i_size_read() takes an irq-unsafe seqlock,
-		 * which cannot be nested inside the page tree lock. So note
-		 * end now: i_size itself may be changed at any moment, but
-		 * folio lock is good enough to serialize the trimming.
+		 *__split_unmapped_folio() may need to trim off pages beyond
+		 * EOF: but on 32-bit, i_size_read() takes an irq-unsafe
+		 * seqlock, which cannot be nested inside the page tree lock.
+		 * So note end now: i_size itself may be changed at any moment,
+		 * but folio lock is good enough to serialize the trimming.
 		 */
 		end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (shmem_mapping(mapping))
@@ -4035,7 +4096,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -4049,12 +4109,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		if (is_anon) {
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
-		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(folio, new_order,
+				split_at, lock_at, list, end, &xas, mapping,
+				uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -4132,7 +4189,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, &folio->page, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at @split_at to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @split_at: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ *
+ * It has the same prerequisites and returns as
+ * split_huge_page_to_list_to_order().
+ *
+ * Split a folio at @split_at to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * in the case of splitting an order-9 folio at its third order-3 subpages to
+ * an order-3 folio, there are 2^(9-3)=64 order-3 subpages in the order-9 folio.
+ * After the split, there will be a group of folios with different orders and
+ * the new folio containing @split_at is marked in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+static int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *split_at, struct list_head *list)
+{
+	return __folio_split(folio, new_order, split_at, &folio->page, list,
+			false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.47.2


