Return-Path: <linux-kselftest+bounces-39035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC3B27640
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962BDAC1BA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4429B773;
	Fri, 15 Aug 2025 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXFGH2X6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B279220F30;
	Fri, 15 Aug 2025 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225589; cv=fail; b=bji4DoFYuWf8wqSSOyaIRMAPWxBn0oz78SBukOk6liEkphg3PIDStXEdamowZzXAEPamcqWBGx0eAKyISjuYG/0Ik10XZnbCz851MBkCz9+Z++TviioWR4PFM4DRYmJVHZFnTYv7i/Yw5u1eonUHV/ppplVZGqeppvLOqzh9xe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225589; c=relaxed/simple;
	bh=rKs2EsyIeg6qMWJyJaZPKLjZHLKdceYf48lUdOkvvks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/UaXNFF8rkECqAiMyXJcBmGkwOQr27CZvLtcOq7yr+88e2JzKt24+bCT4Pv9TuG/o7B82cgXZlJx4tfzB5R3KG+tC+IypLkxb/MI8BYFJqxCoAh3gtIdRmHYK767sbmeEXjn29LJpdY7QKhhSWBSQ4lkYED2PKrp4IwlotVB3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jXFGH2X6; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD3w+0ZMaseQHvqH+DrCTdS7gB5mpkP4rKevj/cDbneWksLCCQwTVmg7v9a4ljVeGOzFFCII8t3M09sWypGXgpqPCdtWryxAXRs1NIxo921vJXi4QI/ISo6TkfsIFtp59DMYV76ZhAmhO9cVeFrx+SZcRfO6PQWgsb8NzNyz6IgjFoIxhYRHPXz9Yfe4o4XRuiP7JxhG4Ft0iCWNrBgqs5eBiiMwcIiV+6CCsZk13xQ1a6O+6vnDz93zRFR5iFzoCNxNnuzur95HxZKP5WDCydc1LrGeaIsTAtlzUKO2D0rD5XZckuq7bW/QbD6chUwHGriFQvRHxrJaLGV4+o3OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOFucGLbAtIDgoQmxbAMel8LUFNABmzph7RuE2bUnPI=;
 b=EwV8VsTHC6DnF2q9ztaIa7G5YV+MBaVlMDZmW7q5YUlo2BLOK3DVEZf2M1EaWVBUJ4Pv5s+LRjEDTF5XlU6orK1qa4+0nyrqYjTha2vYZGSuY3qkwryepzskiTXV2ToI10iMo6VWmlHnZZWK80MaNT+GSyF5zxhkwF87mFP4s4yW1ezr4++w+86g4UN6/rDNcZKmx+dFy/tyRCEOe18jgkWxwrzcFQ+X34u87npR7nHatYfKG9bqy/DA3WFwfJwcIe8mO0zSDQQM6loN4Isuri5U7rnO6DlWUdkwvCS5p8z7KROdHQwzx9wBwjoqhm1BemP9UtOB/gmUosyuzEXGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOFucGLbAtIDgoQmxbAMel8LUFNABmzph7RuE2bUnPI=;
 b=jXFGH2X6D43ua7Zwh5r6Ow/FCHBtc2nyCGhza0igY0iA7zy4W0h7cY034g84xxbrMOLH/UVMxHy+FZSYbQm50CzqBCna7Gx3sb4AaVUMefjw7cKRAxWQs3gQeU6OWSu1xK52jIpe7PKBoH5FTBzf2PCQNE34uPzqanZdG6pygzzqBjq9NYqlphUqq39TzI4Uq1Pp7tvQrMxlgyV2ZcoqDmJRrkdDBMDb3wH9KZ6iiWM/q+Vn3eJvh+ESqtAJKv+j/kHN4iX/xYAKnNt5wWFOhI7Q5mr0uVjHHlrWLF719ldjBTU9G0wYFqklXla/2lebY6nMhZ99+7/AqMmd7uvseQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:39:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:39:40 +0000
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
Subject: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp() with more precise check
Date: Thu, 14 Aug 2025 22:39:12 -0400
Message-ID: <20250815023915.1394655-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815023915.1394655-1-ziy@nvidia.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e60f47-aa00-4ead-126d-08dddba4fbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h1fUKQGN9xGe1cZ3vYnML2P9k2NOVFYQGkO12WH3eYxaNyyCzyIARPTpMlaP?=
 =?us-ascii?Q?hPu+5nlME0TPQpauF2Qj58ps7SlzTKg/gcnP6Wj87hdQohVr7tKFTXR8G/qj?=
 =?us-ascii?Q?aHAqf+IDYjAZ9boefD83q8pwuiXnPlG0EgvfTpV6BEXCQzKtyWLSZ9KQ2pWV?=
 =?us-ascii?Q?/iLWYYkmizkPSz7ypcZ78wskw8f72zu2PU5pq7NwROECx+5DVMEXOaoRbcDp?=
 =?us-ascii?Q?30Lh36NrHRRROvMxjFryeQedmKTFVaG9QDIhTmxRO1vzfBiFOL8skO04f/wh?=
 =?us-ascii?Q?H3qQeBOYOL/DvGq2t+GNexmj2N4f5dYmr/rldxKXP2OsjS+MYaPqfcluazt4?=
 =?us-ascii?Q?TYIQL2W67ah/CC9cUFVQsrgz+OehgSWawMs+RTyIlbkY6NIZpVm8rlHdhi64?=
 =?us-ascii?Q?alH2qpoGWf/A7TaaIRu6ngJHt7/x6VF/d1+KqxVhdHSwtUx8I0Km5mWM7jT2?=
 =?us-ascii?Q?PTRH73VTlWrfOKZo4l4H5s6Dv17Vs2ln/n1ODVaDmFzwIdmIuOA2rzQMpHOf?=
 =?us-ascii?Q?RANtk0NLk/QYj9Da01D1i9xwY17PKAQx+tcF2bf3nsd54eB5TWptijmpRZ6v?=
 =?us-ascii?Q?mc++NEGaojFLxdDugHfIhQ1x9bPKh7Yy+/kJldOT+hMx76ueJozajK4F7Aib?=
 =?us-ascii?Q?tcQtGsGnKnbmnXtImGrOlSuGWepfg8WR0BOlnudaaStd1pkyDDiVFcaAZKfo?=
 =?us-ascii?Q?GEcGikqOPtAYRojBxItSq5vAKnr3VEH4tpcXMbu7PzAUYUz9LtzjXKjtiFHw?=
 =?us-ascii?Q?klOJRncADYhtoJBtzRsjdSgmRPITg3LSbXIJJf/8Y4AONJFKu8ljYlg7wCJX?=
 =?us-ascii?Q?EZJ2k009zNzbUNlrcV0eL01wa/t3uakCAj+GRY9iKP26i5lDIVpx1i30Eq97?=
 =?us-ascii?Q?8rgD451P6jmOpP2vwLOaC5ml8zn+FfXrd2HubmmpPMBQ+HHCnOad7QedFmqr?=
 =?us-ascii?Q?1HCHt/hN50uisfWILWF2wTBoyqNK0kXoB0q7mGanoBcgBtvuRvSOr9VUlXG8?=
 =?us-ascii?Q?eg7okPVTgc4lsSLY6+/m4Bym0OABI6OPEs54WpwI4ihmmLNCQvx6NidNO15V?=
 =?us-ascii?Q?ApEhwHif9AwLEeNf+1d4VdipDIyRzKI1m1BjTRhNU/E1x46SCN+O9PE1sOR9?=
 =?us-ascii?Q?NXjxD/Viy9yrDzt/+ESz8o5nvyBzCUT+0n9g9dkKAH26dkzJe2FhavCEQv5F?=
 =?us-ascii?Q?nbfNZlQyFHdw6ShX11/0ps6Rw0qlstWZw811fcrZWhRYCBDOXn6goBlHwLAA?=
 =?us-ascii?Q?CfT9Vik85dZDZ3zT9/0XzcmbPC2Hx+rtUeCvDZrh5ldxUKm7lDHg66Gy88/H?=
 =?us-ascii?Q?fTZcahEcYlySfFC735X8KZ19u+gl6mJfml/8amNaZfLbC55yIH0BjV3Ek7Oq?=
 =?us-ascii?Q?hMaNqsArlMnqDqdpehgw20g6689IV2fo/G67wOFpVhzbyeTzUydR53XcKFLm?=
 =?us-ascii?Q?xgCrlcSZPOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vPKdVt0EF3OAmJDDSZxa8ir969/pLJjox12Ey9Cdx793rIF4q4KO50UEvZMi?=
 =?us-ascii?Q?8JHbN/sPKBcEDwf0aAYlf8kxxskP+cJG9ui/FqpDKBAHe4puG9l6IvJhm13z?=
 =?us-ascii?Q?nse023TRl2VLMC+iE9hnoy/DqD3NIQS3gF9Na0dnvuTaYBWS/rycsAJBuzaw?=
 =?us-ascii?Q?SUpsDoLnqCf+1fPiuHw14yaCscqk6f+4Gk/JmjFK9yl/zZEk4GUP0D1JugP+?=
 =?us-ascii?Q?puIUbgp8l7Jfzjozv3xfjI94840cqJ44g+VuSRTyrd0qF/2IZcfolEeS/WA/?=
 =?us-ascii?Q?W+OOVoEtY4rvzhZgXNCufzddeBNjwfUu2wQqD+whNphyMZFMnDzQxwaWcyM+?=
 =?us-ascii?Q?sRn7dBH3gKisPKdlCZocfg559YvzpWS9huT8uxW7hRWce2Civ9dJrFrzL3my?=
 =?us-ascii?Q?PnVSISSr9UctE4FCsGCXq1ONA7n/4359AQtGg4crVBPGnT/MBXnu/pGImLu5?=
 =?us-ascii?Q?ohg5NI8NvJJ35cYE2bO6AclQ9De8FDHDPVhmrc++jJm/gOuaqRBQ+nXYjfeu?=
 =?us-ascii?Q?BZrflrPINQKEbqK/xbGPA/uU0Ur77DXpv5iX9BK8WQKeE+83pfebVtCB9KNr?=
 =?us-ascii?Q?sJYTUd6z99F1tuup/bYr+vlZFgnz8XRvGE7U2JKm34GBrwsjqfMxa8dLqnzB?=
 =?us-ascii?Q?P1vELcGaiDT2qAAwqVr2UjP3misRB7jezdPXYd3mVlaUpVHrXt01x4ghsqXh?=
 =?us-ascii?Q?l4hRKfrrDqYVS7KSghvxJAG2XrxRYZu6baZ0DgJvoS0gu3Vr/7fAiz24x0Ii?=
 =?us-ascii?Q?RwKLh9LKWprGMKz4tE76DrgsdHgX+P5+Cgva9cjJ4flQwYonjg6Au8YYvg10?=
 =?us-ascii?Q?nLDOfLTJDwlcld4TxHCOCrpNtYYibjkF16MmnbcRHkXjhA968o9JKoWxGDl+?=
 =?us-ascii?Q?Mnb+WhJSDfUMPBOFh9/Z107XabeKC30xbOdp0J3Cr5lu8iQAbJjglIealphB?=
 =?us-ascii?Q?2jKvLpv+RvbPuYWiHhoqdT/EJ2J/yKQhphIO6cllcAqYmuBhKkt+4K9inj8L?=
 =?us-ascii?Q?LBzRlgHMX8QiQyBAvtZWL/2d806Qe1SmJKWZ6HYFWi3pPYtUzmdDyufbExSK?=
 =?us-ascii?Q?mgU82QL0L6DFsq6QJT5UMXmluEQpSB2HLUQe5oAl7aCQENuP6u991Nepgw/m?=
 =?us-ascii?Q?JE7SNC4KgvIu2PwZMmBHo+aEIN77xzyP676hqC3TQEn/OzD+W1OOCqy4CYxH?=
 =?us-ascii?Q?X+3ENW7jq5tV5TJOZ7PhG7rMVHD2nr6ww+f5HRgn1oe4rwf7LUbx1JJOloVL?=
 =?us-ascii?Q?LrUHQt7GYKRvmkpUoqy5eox1ROoryhAvorzxTKcL70nfyXAChUeNnukHB3NL?=
 =?us-ascii?Q?x3ZW6G+9zurwNKiXHvM2Fa81NKrE+5iZw2Nb22nMLOOXCxSZlSl4A1PLyTFh?=
 =?us-ascii?Q?i0HAgfvoz8K9EjM22gl5mlc35cua8sJL1YI5Jhy48kzXcNVXLZRJz0ZRZmMr?=
 =?us-ascii?Q?2tuPszX8qwrjrDsvuOfTkbvbiOa7GcYLqpvyzpiMfYXOPw9Kxl87P4ConChp?=
 =?us-ascii?Q?DrnIjSPM9wuoZhWaIi0Z7hxpN0B7JlNwFfK5uGAgt8Z0KuPK2+Cq/KVwr+Rk?=
 =?us-ascii?Q?OyBLezP20ihKBiYMu766AzM2QF28CYajzWXyR8my?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e60f47-aa00-4ead-126d-08dddba4fbf6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:39:40.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WxREiRA7nB4rmHAqk3+5q/d0/FtIfd7mfL6euXL+ZEdQRNEV6eOCVEsCBFmaY/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

and rename it to is_backed_by_folio().

is_backed_by_folio() checks if the given vaddr is backed a folio with
a given order. It does so by:
1. getting the pfn of the vaddr;
2. checking kpageflags of the pfn;

if order is greater than 0:
3. checking kpageflags of the head pfn;
4. checking kpageflags of all tail pfns.

pmd_order is added to split_huge_page_test.c and replaces max_order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 90 ++++++++++++++-----
 tools/testing/selftests/mm/vm_util.c          | 13 +++
 tools/testing/selftests/mm/vm_util.h          |  4 +
 3 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 89d3dc08fe4c..80f718ca21c7 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -25,6 +25,7 @@
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
+unsigned int pmd_order;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -34,27 +35,71 @@ uint64_t pmd_pagesize;
 #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
 #define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
-#define PFN_MASK     ((1UL<<55)-1)
-#define KPF_THP      (1UL<<22)
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
-static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
+static int is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
+		int kpageflags_fd)
 {
-	uint64_t paddr;
-	uint64_t page_flags;
+	unsigned long pfn_head;
+	uint64_t pfn_flags;
+	unsigned long pfn;
+	unsigned long i;
 
-	if (pagemap_file) {
-		pread(pagemap_file, &paddr, sizeof(paddr),
-			((long)vaddr >> pageshift) * sizeof(paddr));
+	if (pagemap_fd == -1 || kpageflags_fd == -1)
+		goto fail;
 
-		if (kpageflags_file) {
-			pread(kpageflags_file, &page_flags, sizeof(page_flags),
-				(paddr & PFN_MASK) * sizeof(page_flags));
+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
 
-			return !!(page_flags & KPF_THP);
-		}
+	/* non present page */
+	if (pfn == -1UL)
+		return 0;
+
+	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
+		goto fail;
+
+	/* check for order-0 pages */
+	if (!order) {
+		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
+			return 0;
+		return 1;
 	}
-	return 0;
+
+	/* non THP folio */
+	if (!(pfn_flags & KPF_THP))
+		return 0;
+
+	pfn_head = pfn & ~((1 << order) - 1);
+
+	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
+		goto fail;
+
+	/* head PFN has no compound_head flag set */
+	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
+		return 0;
+
+	/* check all tail PFN flags */
+	for (i = 1; i < 1UL << order; i++) {
+		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
+			goto fail;
+		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
+			return 0;
+	}
+
+	/*
+	 * check the PFN after this folio, but if its flags cannot be obtained,
+	 * assume this folio has the expected order
+	 */
+	if (get_pfn_flags(pfn_head + (1UL << order), kpageflags_fd, &pfn_flags))
+		return 1;
+
+	/* this folio is bigger than the given order */
+	if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL))
+		return 0;
+
+	return 1;
+fail:
+	ksft_exit_fail_msg("Failed to get folio info\n");
+	return -1;
 }
 
 static void write_file(const char *path, const char *buf, size_t buflen)
@@ -235,7 +280,7 @@ static void split_pte_mapped_thp(void)
 	thp_size = 0;
 	for (i = 0; i < pagesize * 4; i++)
 		if (i % pagesize == 0 &&
-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd) == 1)
 			thp_size++;
 
 	if (thp_size != 4)
@@ -252,7 +297,7 @@ static void split_pte_mapped_thp(void)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
 		if (i % pagesize == 0 &&
-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+		    is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd) == 0)
 			thp_size++;
 	}
 
@@ -524,7 +569,6 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
-	unsigned int max_order;
 	unsigned int nr_pages;
 	unsigned int tests;
 
@@ -545,28 +589,28 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
 	nr_pages = pmd_pagesize / pagesize;
-	max_order = GET_ORDER(nr_pages);
-	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
+	pmd_order = GET_ORDER(nr_pages);
+	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
 
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		if (i != 1)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-	for (i = max_order - 1; i >= 0; i--)
+	for (i = pmd_order - 1; i >= 0; i--)
 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
 
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		for (offset = 0;
 		     offset < nr_pages;
 		     offset += MAX(nr_pages / 4, 1 << i))
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 6a239aa413e2..18b7cb51fc56 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -338,6 +338,19 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
 	return count;
 }
 
+int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
+{
+	size_t count;
+
+	count = pread(kpageflags_fd, flags, sizeof(*flags),
+		      pfn * sizeof(*flags));
+
+	if (count != sizeof(*flags))
+		return -1;
+
+	return 0;
+}
+
 /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 1843ad48d32b..03481ca0a1b4 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -18,6 +18,9 @@
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
 
+#define KPF_COMPOUND_HEAD             BIT_ULL(15)
+#define KPF_COMPOUND_TAIL             BIT_ULL(16)
+#define KPF_THP                       BIT_ULL(22)
 /*
  * Ignore the checkpatch warning, we must read from x but don't want to do
  * anything with it in order to trigger a read page fault. We therefore must use
@@ -85,6 +88,7 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 int detect_hugetlb_page_sizes(size_t sizes[], int max);
+int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags);
 
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
-- 
2.50.1


