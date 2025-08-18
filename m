Return-Path: <linux-kselftest+bounces-39242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A4AB2B0C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395BE581F8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D62749D7;
	Mon, 18 Aug 2025 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UxduS6vL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E027467B;
	Mon, 18 Aug 2025 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542801; cv=fail; b=XhB7Y6/8sveRP2Z5eIhhHtQ4TrqQViJEwKwEIjJ0R5xjhmWDzAjEEx1i3dh7WOQ8P/Z3+TJYJHfUxu5eT5TljfjZWtKPyAEw2rtFZqfISUDn3LX8sVCwPRtDKcP9oTzAw3YWVVKJG3y5MuFid9/+XBPGyOKi9BwPgdQhjbgiTEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542801; c=relaxed/simple;
	bh=s3fVtnit/PHuB46ZJydlGboOrULDb0y3fILBr9Gi/Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaqQf6Kjm2R12AOKbsfNcA+oxqtxV5c1PBfSFRHWxK07hYZkZnJ+4FJQf+oBYlIs2jTntk/2XqxXMzlZ+S4LBWOQx4MbfuDcaIaTw8FSesxecvLWkrkVoX15aqMnNy03YsuRxvkx+jHMOJBA5nIi57MU3GZf/UWJA3ckIeRavs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UxduS6vL; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILeHEIemmI9aErr7r5vIg9CMUvZKJ8vr4xg8gJcVyMAzryZRGcc+1Tw2L+zW4Ht6Vb8umy3MfQMA3dx7EhEPUSFFEoMWJuMnrzpEC4jtUCEenqB1ONPrvUcxdxbJL46nwdQBBf8EQ9AEoVJGi3nDGYkQ1eqLp71SjrcNpmgPAKoS+ExkZ7ZRbAM/b0n0c9jmnPOtUfo2NDNSmQqLMGmOxSuU+7nIndVsII25rjenxl0824rT9awVbU/d5ktwTAINwOdvs4FtbaBVdHAQtelKSyEq15BmVFWNuEyG7vRdHmmXztFHREDcoi74L17ENdVPp6Zsx3D5ZslHuJXfhtBOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NjBuSihFTTquetMFfnz8BoJJEOlJwPWVZeyM7rhy+g=;
 b=ImS8IDo4LKHoTp3jLxNOXvi2RiupEeQJu+HSRPMTgqYechRcwpiMdIMdOi3rd4p8FkdUqCk63wrduokst+Usfu3SP+JsJklVVFNsKgiQd1wSB0peAuI8EwvZwNgclHmL35oIPNn7UtiYOUWsG5/aKd0XxFB2Ur696dTBg3Nwvu3siJ9kHVZ7IFKPFU8M4A6hE0oD8RUfVvsZId4oUTcG8hEJ5ztbCGitwiAbOZZ70KTJk/z/lLNEMa/P7ov7LbT51KR/VTwgfOBJGa9AR8rAtAkzW0+Tx1/bWWJIzczTGajsaqFh9751q6FyMbfmxnEIYVEdIctBgTkl7VFrItgpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NjBuSihFTTquetMFfnz8BoJJEOlJwPWVZeyM7rhy+g=;
 b=UxduS6vL2NGjk2Cww+Os1lk/+BMM9O79yBx1s/ZNYBK29wdbOlm4txjjVhoMFQSsKLh8UVwGNHLsfUjD+eKfCA9VmUiewxRON7YVzDKYrC9CEAwKuZDPfL7EiX7U4SrH9fNfou8c3umm/mB370jqmjkn6C+rxI0iUg/wZqzWKhAlD7iaqG8v/uTdqGKTvISWKnozQQs5lxrfD0688SXqoNnMieHrLax+Pt/VwWapeelh98j9sn1pG0F8FTRwVOiGJfdnS2uucm3ZZGmhMIDFBtxaokEkBaAGqcxcMqVWJgrG0DePY9sg/B0t/vml37OJYTP1EskRH8flBwGCGJWiNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:46:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 18:46:35 +0000
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
Subject: [PATCH v5 5/5] selftests/mm: check after-split folio orders in split_huge_page_test.
Date: Mon, 18 Aug 2025 14:46:22 -0400
Message-ID: <20250818184622.1521620-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818184622.1521620-1-ziy@nvidia.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:52c::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b94713-e759-4890-bca9-08ddde878eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BPwFIp01voJwZFlgAa+MvRHGycj0c0zIMCBpSBkc8ogJQSbdZIbzIiFXw5NW?=
 =?us-ascii?Q?Z/ONhmEfaLJHnQFvCSzMAHIQXWa49VeOHtINRWZ/xBvv/Fl+NL41K77asohT?=
 =?us-ascii?Q?VUKLkIWXTRXyiIR7nfnmzKoB4Tuih76MHwkUQgTa76R99M70Rw8Qb1GccIGa?=
 =?us-ascii?Q?7txzc4nUkKmGtWFWCGeb5pUWE5NVbcG4LFnn2+BkODtnP892G4BnHTryMk7N?=
 =?us-ascii?Q?99SMf4PNNzQy5CkT9YJul4jhz4wLf8qk0JXXek2QWGiHqw8+leUlBweJJtmN?=
 =?us-ascii?Q?Mek9Jl+jSMLLeDfECzdwFTz2WTK4J/QYk9uxmRIXvei7EithvbitpBpkyQbc?=
 =?us-ascii?Q?J+87bLPCLo0yTmPOWalpYcmk+U9rTv90Zf+83pfIbbwedPz80QVNs7ugsH7U?=
 =?us-ascii?Q?8UGaHkekJ1Qh1EYasgCaI/x8Kd6R2CbKXEJXFZWd5RY2XwnTq+/8j3U516mE?=
 =?us-ascii?Q?pot+JQyBTfMnCXLbLxbgJ6JqeMr8Fd7/ah9gEPw6mJ70LrDi0T1NDyNNYYVY?=
 =?us-ascii?Q?Wau4xVIOWhxfzWUQcaHStkPhq5iZLaW5RHPfwSlele1cunONRhmtz7y49IIH?=
 =?us-ascii?Q?IAE7NTn2HTZUfVpbuHiXRZlYxYWAXhMIKZJd9rzSDhCRzRCXiVUGyuBrJVXQ?=
 =?us-ascii?Q?jqmLUTbyv5IdY+x6r7MT7198xcTYC9NX6hFlkgC98jkF7rJaV6jsS4HmeduX?=
 =?us-ascii?Q?2p6uIoitDPpiuInBxdlxytPUDordwiNy45sQVzW8D66ucxHa/Wcj8QPI+knm?=
 =?us-ascii?Q?kCSxgeKZmeBeznLP42ClmPWRamZBeYBoDqt2ww8xycAwqQcYfpkjOF+rNu0Q?=
 =?us-ascii?Q?FKRa+sHub4S22TC2cmCToK793rndn6uo8dj91w1CFQYb0q9jIC5NUtnAMxiS?=
 =?us-ascii?Q?CYmmQT1yj/Kk41hngl6PHXtIIXVHsw+q2626Ku7S+YNrsufZc4KZDCBCxUTf?=
 =?us-ascii?Q?0YIvuEI6mpmcG+ohjWNW51Y8GB28/xLxTZuZctJYeZbsaNle0+Y30fcEFT5r?=
 =?us-ascii?Q?ms2FSkXHYX6/GXzsxXdm/E9mxFBg9nds4ApL66SLOt2UjpFHbeirSS5YUMx4?=
 =?us-ascii?Q?5n/fBBk4FiR2WcdYts2DyWuW7oEnGjlrsgdJb93s8b7Src43EvrmdFlZzX8t?=
 =?us-ascii?Q?Uw6LAejD7+TiVGbWTH+NMsZdo78uf9HzV53FE4EjyVVQrnLjGWwZhC8w7Ybw?=
 =?us-ascii?Q?sQjnbDXOelHR8/BFATDJmWY2hZEy1i0NbQVoKSDR7GaFkV4I8+pxbDy1qI5i?=
 =?us-ascii?Q?uYR7/8DcGRlwbQPXiTf4QyQhH7qqGGkSe5VCcOpKcD80ckuvv4UVLNjwAP9B?=
 =?us-ascii?Q?uT6GCP3g5EiE1F7RnJpyBimtyWYg9NHkgTYq01SQBAbBxZ1kx8f3YeyMXW2E?=
 =?us-ascii?Q?TX5/3VYhA0lZAtZCaLgOAHkC97tzzZMiGVIRXrQrjxwyVwJhVGmOvF2hCuFj?=
 =?us-ascii?Q?Lfz1/DmuAv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExLiqWDlCNqJYxEcAnLcuF0CIP+qogNTjKhzFyYCCXuIfFcitXHUFKsCq+oJ?=
 =?us-ascii?Q?wpsWJLPU9tdzhxr1Gv2WTutCSW72WKhuV/DDfLOE/xPyeDJBzzKANZk3Uj5v?=
 =?us-ascii?Q?/l3zrwxWdSx4Wg6pQNSFY2mzkurqbldFeoa+eRV/AYMoYHv3ZbCYlR8d+9VZ?=
 =?us-ascii?Q?Rg/RlxAdVZLbj0jhy6rk+31KzSft7lMRdRNwU27/DUP0f12Af7QQQUTQExe9?=
 =?us-ascii?Q?B8QxMdOI7mYk1XgRQAF8dz/1dTneUqNz95EYt2jSbu3wpM4GM4dp4H4ExWaP?=
 =?us-ascii?Q?DnzmY7c/Id//zRVxgT79VIGimd3eJctMajhrfg6Jzld7hYA5RSVu70y0Zm4e?=
 =?us-ascii?Q?BmFG5NCRA8GGqFTjL0dZZYLiOhvGKfHdovZk5EpYm4a6S7nN92SFDJfQEw+D?=
 =?us-ascii?Q?rrYidi6xiGJGpsejjSeuEMI9smt1kzKLWl9MDulgZqqixx3mO9RAQMJlapku?=
 =?us-ascii?Q?JtdBMVrQZLMXMOI6sr+VeSaCD8rzc1Wj1cnq9lZDDOZzDGtJaqVMYbwYlNwx?=
 =?us-ascii?Q?I90Hy89iLOmfuDJjJylYMbpYlq9LSIB/UZqF02TUhphIEamdMEaHs2/jI5Ao?=
 =?us-ascii?Q?ps0LTX+GAbmJKVyYAjM2mOWPHbESql926h8hLorQIH8mSHEKsYq+QuSGZP68?=
 =?us-ascii?Q?EyeyrUuz3bvjJfOO2i2j7ROzHKSyY7YIIxoFQi99FjqaoF0/V+KQfewBPdvS?=
 =?us-ascii?Q?HcqobvK7IV36/sjNLBGp9EjhltbpGcF1KoERJ9bj3jCZ3E5GSRO4N5umeMhv?=
 =?us-ascii?Q?y7stVj1eS3uLobh+TWB7d3nDQP0uK7+mIa0KKmg9t//nyp6DThPEWNH44NHW?=
 =?us-ascii?Q?8yUuAE+vsL3BCWLWqb98C2evp90CVO2YrAR/j8ZQHtDENgV+R6UMX7RoQnIj?=
 =?us-ascii?Q?aTBlbeQkzsBbe0fR893EyS50YDFjNzxQMzaDnWts4q07BnQRDOFTL/yxSd5/?=
 =?us-ascii?Q?7z7PFc/6zCsMSgYE/ndjH28x/7pvsbLjjcMQhq9YaVfLVfVCWnrLXK8fWjmK?=
 =?us-ascii?Q?w5FOwlmd/lLLMhTb9F1rO2sDEZYeSQExaGqsd0SvquWW9Yv4qDS5OCGnm9Lg?=
 =?us-ascii?Q?yPktAyLlTcW2RWSvk7p6nLSE8nUN8O0Gh2Mg0Gtt2eCjuKCRHZ0vF5skJq9m?=
 =?us-ascii?Q?qA5WYETOJXvyWg212Gpa3MvQ5/a4pb1k231dtEw/ZZ2mbYdFcTuV6WHrezvt?=
 =?us-ascii?Q?RNgrHrNBlBDHTxTUO/kNaLIdBN3Y5vx0HvK6177PWaUhzQy+J2P4hvLwCDh1?=
 =?us-ascii?Q?LmZr7TfQ//g0GJB9N+Qr9yrSHuddubGOYxwTeQ7xEhCa1EyI5mnDU6QPqr9A?=
 =?us-ascii?Q?Ht+Hy7OjgZL6ofGJsO2cezquUBGHApADgKyWBYUmlJza58lOaqde0Kn2Nhl0?=
 =?us-ascii?Q?LNfiww3tvM8W+39BUyXvliPMYlHfrKyE5B7UgR9uRIN6vwqnX4NrCzMSdAmz?=
 =?us-ascii?Q?llozRrlzQcx/vuO6Yj3l/dEwkzD6/2qxciJG/EeF0C8Y6Ob/Iz9fNGQ2kewN?=
 =?us-ascii?Q?Zr7nPRTkstpcejuXfIulTEZQp+ZyvUDly0AN3IJg1XTeLNoWATNkV2JigEQc?=
 =?us-ascii?Q?EFzDGM5nDQcaWm4yESENqcLZ4NIjYHWP84Favetk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b94713-e759-4890-bca9-08ddde878eb3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:46:35.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEU7AqS1bGXg5gGSMzIosDGOYg/8lhFZ8MmHZEgJ70rFGhExKByZh300UhXQWHvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

Instead of just checking the existence of PMD folios before and after folio
split tests, use check_folio_orders() to check after-split folio orders.

The split ranges in split_thp_in_pagecache_to_order_at() are changed to
[addr, addr + pagesize) for every pmd_pagesize. It prevents folios within
the range being split multiple times due to debugfs split function always
perform splits with a pagesize step for a given range.

The following tests are not changed:
1. split_pte_mapped_thp: the test already uses kpageflags to check;
2. split_file_backed_thp: no vaddr available.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 88 ++++++++++++++-----
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index e24df02420ad..a66ecbdfe7c6 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -26,6 +26,7 @@ uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
 unsigned int pmd_order;
+int *expected_orders;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -35,6 +36,11 @@ unsigned int pmd_order;
 #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
 #define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
+const char *pagemap_proc = "/proc/self/pagemap";
+const char *kpageflags_proc = "/proc/kpageflags";
+int pagemap_fd;
+int kpageflags_fd;
+
 static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		int kpageflags_fd)
 {
@@ -366,6 +372,13 @@ static void split_pmd_thp_to_order(int order)
 		if (one_page[i] != (char)i)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	expected_orders[order] = 4 << (pmd_order - order);
+
+	if (check_after_split_folio_orders(one_page, len, pagemap_fd,
+					   kpageflags_fd, expected_orders,
+					   (pmd_order + 1)))
+		ksft_exit_fail_msg("Unexpected THP split\n");
 
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
@@ -380,22 +393,6 @@ static void split_pte_mapped_thp(void)
 	size_t len = 4 * pmd_pagesize;
 	uint64_t thp_size;
 	size_t i;
-	const char *pagemap_template = "/proc/%d/pagemap";
-	const char *kpageflags_proc = "/proc/kpageflags";
-	char pagemap_proc[255];
-	int pagemap_fd;
-	int kpageflags_fd;
-
-	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
-		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
-
-	pagemap_fd = open(pagemap_proc, O_RDONLY);
-	if (pagemap_fd == -1)
-		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
-
-	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
-	if (kpageflags_fd == -1)
-		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
 
 	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -453,8 +450,6 @@ static void split_pte_mapped_thp(void)
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 	munmap(one_page, len);
-	close(pagemap_fd);
-	close(kpageflags_fd);
 }
 
 static void split_file_backed_thp(int order)
@@ -657,6 +652,7 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 		const char *fs_loc, int order, int offset)
 {
 	int fd;
+	char *split_addr;
 	char *addr;
 	size_t i;
 	char testfile[INPUT_MAX];
@@ -670,14 +666,33 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 	err = create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
 	if (err)
 		return;
+
 	err = 0;
 
-	if (offset == -1)
-		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
-			      (uint64_t)addr + fd_size, order);
-	else
-		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
-			      (uint64_t)addr + fd_size, order, offset);
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	/*
+	 * use [split_addr, split_addr + pagesize) range to split THPs, since
+	 * the debugfs function always split a range with pagesize step and
+	 * providing a full [addr, addr + fd_size) range can trigger multiple
+	 * splits, complicating after-split result checking.
+	 */
+	if (offset == -1) {
+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
+			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
+				      (uint64_t)split_addr + pagesize, order);
+
+		expected_orders[order] = fd_size / (pagesize << order);
+	} else {
+		int times = fd_size / pmd_pagesize;
+
+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
+			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
+				      (uint64_t)split_addr + pagesize, order, offset);
+
+		for (i = order + 1; i < pmd_order; i++)
+			expected_orders[i] = times;
+		expected_orders[order] = 2 * times;
+	}
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -686,6 +701,14 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 			goto out;
 		}
 
+	if (check_after_split_folio_orders(addr, fd_size, pagemap_fd,
+					   kpageflags_fd, expected_orders,
+					   (pmd_order + 1))) {
+		ksft_print_msg("Unexpected THP split\n");
+		err = 1;
+		goto out;
+	}
+
 	if (!check_huge_file(addr, 0, pmd_pagesize)) {
 		ksft_print_msg("Still FilePmdMapped not split\n");
 		err = EXIT_FAILURE;
@@ -737,9 +760,22 @@ int main(int argc, char **argv)
 
 	nr_pages = pmd_pagesize / pagesize;
 	pmd_order = sz2ord(pmd_pagesize, pagesize);
+
+	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
+	if (!expected_orders)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+
 	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
+	pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (pagemap_fd == -1)
+		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
+
+	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
+	if (kpageflags_fd == -1)
+		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
+
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
@@ -764,6 +800,10 @@ int main(int argc, char **argv)
 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
+	close(pagemap_fd);
+	close(kpageflags_fd);
+	free(expected_orders);
+
 	ksft_finished();
 
 	return 0;
-- 
2.50.1


