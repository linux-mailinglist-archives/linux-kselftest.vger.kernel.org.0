Return-Path: <linux-kselftest+bounces-38612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E433FB1EEAC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81861C2709D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA72882A5;
	Fri,  8 Aug 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iWib87L2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA62877CB;
	Fri,  8 Aug 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679730; cv=fail; b=rdpOsKlXVzFv4A0/allPpmKUuae9Xq+K5eUsHx8QA/EVA4Ax9j/8RJCBH8zEY/YWM5t5hnnUMi/flmY2L7HZ0KpHwykQLKf9n3uMDfkwM8skC8ntUri2618EU+MhWoMxW6NSKFXDXDIW3VnlYlxjgh1dyjUeVq6AyWRtwNui8n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679730; c=relaxed/simple;
	bh=463Z+Uor0yEQSdpxl0tGgB+syGwrUi8RfpoczEkSfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlB/tMebqkT/EW7TqgHbm2da1NxbSu8VmUsBHw+zt+VxNjnaBEWQ28zyhk6LSWxLjA/COzN9cqptYk+z4h3KAhuRErGUrIOLMfibViv3kXhFvWu+E7z4jO9BiHL2DzWO6ZOkGzca8Jnmp4e30MginmPiSbWDu+YpmXcQfJsi2w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iWib87L2; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtTo9olEp+TcnNzvGwtGzpPSgHHVMALVvaXry498I9TzD+WURXr8Aha9ZtZAKm7qGzHLvMUbVOXJ0QkVWSEpjrKaABaDUhnGZVVzSjy9av6oqyctjn71nHJ7z6ERGtvzCorYfsoxbOtVIPiMV7rhq10IswVM2yDzU7yd2V38Z+BehkzFogigD8I+ViCEl3jl5MQ2/DBCDD+KFSQnEn2DSNds8+FZWVph+5fcXN9RLhJdacTATtsf4rKdjQvCXMYci1bGyVIvEfLZcYxHr3wUj6JQdia6lJC84nn3Ylh4AHc4yorXo7EQRTd6hlW82JlCZEPT0e5VFJej4Lzib1ZgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPdO0dxxYvwCpYtyV2mV5VGxISs7kO5p5HxHYZeFmlU=;
 b=cXAW+ZYiLlQaGkcWLYmw2gtJMsEFQuu5we8P9b7wHZ4TwhJC2bips6fvHVJnKCA7HUGqTbcKz28eQkaN/um9K2W53sSZ/ub1KtdxzLYJuKzw6nzpfP31WlnuIIVWifzPeR7PzJgKFOZoY1R4RONzVxbAc7/w7CYeu1uUzDR91bVj+2XFQNagkQFOriTIHt0v2gKlTfQbUsWTUyo23xSoUOqPB2JyErp3myLfTSXu878NDqkv2tjd5RNRr0ycwVZnhNbXay1fsim7Who5udLmOFyGzzTmj27ma1cEBlpeNHiFB7RScNq9psXI8Zcy/OSLY90Te58pp6Bs2FwDbhDqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdO0dxxYvwCpYtyV2mV5VGxISs7kO5p5HxHYZeFmlU=;
 b=iWib87L2GWzEDbQr4pq4YHYvzg4unjXw25dkm5I5HIbe5/+Sxy7LGPY0ZcJaNWgbQiZ7lx4MsP7e6+zEhy8v1K0j3h2+eBJso8wQls4g5MWvj2aQpdqnc2jNfERMyxke6qY4urbB2T1py3cOAqPnD/HYp5XPgXqEYJb9KDVO1IxJwolbR6n/u0UAKu1N9m6EJXrtJE1oATiKh+Wa22FUYbubCVnp/KsJqIsMVPXwyqrGzehoQeE9MeiHEnMtYbLf6nUj3tQkj/eIZM4p4MiD9xfqE9y6Q4DMcP/Zf7HPjzePuv+3PdPEL/hE05hAF0pMALumcm4V+XdDsu0uXRUPgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 19:02:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 19:02:01 +0000
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
Subject: [PATCH v2 3/3] selftests/mm: check after-split folio orders in split_huge_page_test.
Date: Fri,  8 Aug 2025 15:01:44 -0400
Message-ID: <20250808190144.797076-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808190144.797076-1-ziy@nvidia.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:36e::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7f8f2f-ef4f-4348-11d1-08ddd6ae0e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/asqPEkCyzH53Iwa7tlOhfYIwyAskeESWbRoiVodJu0cCcIc6zdF9+1/p+EI?=
 =?us-ascii?Q?J9y1+3tn4hDnQqDSwbhPN2Wee+6FccxdcP3KwlTALRXshKRjRn96jc58DiBA?=
 =?us-ascii?Q?Uwjrthh21xSp4P0hSrG2UAgE8Pwm4pKt4uUcW46UGM1Q4HMiTPiSel0vonbD?=
 =?us-ascii?Q?dY9l8p5Oom3PLsxAjIi6zOGRWqen7fZNM3/+IToRfRVXmbXAlYZwmunqur2A?=
 =?us-ascii?Q?npcGn6bdRix0vFg5+mynriLwgf+ABXn/ILlJ4/7/2CrFoWynROvHPdn2M01f?=
 =?us-ascii?Q?cPBw7NbsjIrcz9g+MDJYG1ZmXNJAZdXKmYTE2DLFS5uLbxmVQg1O3oOn/h6W?=
 =?us-ascii?Q?WOBoEoVDSpQO14MiA0XYmty4kGtspeOF8h1jWfPMYe4G7C1SVnxdDPBgWAyu?=
 =?us-ascii?Q?yCkRzC1eTzH62Cr4+fVbBO7u+pzpc5l72pCSPXflZMU6MKyWISHJ20A33Mll?=
 =?us-ascii?Q?78ecCWITXMJZtTm8ZaJFfrDvAGVOYRsXtYoPa+GMIwbTJnjCKHU+r57G+PGN?=
 =?us-ascii?Q?MFeVK295/qhn937E2SVVMAH23D0Pia9jQDGbLohOqeNmJEYUH9menWwS4jXC?=
 =?us-ascii?Q?jHfNhSAhPVhYiD/PRrCoruMeQD2n2vZya/Z4EzI/gyCy3Y8ltm7DqDo44lcC?=
 =?us-ascii?Q?+uEN+b0uiSQs44ur5MdRscM4kAeU5qrIa0qPztQaphUGoUot8LyqNvuHbzpE?=
 =?us-ascii?Q?000y/maXP06OeNSywbEVpCO2m2tHbvtZqNbB6gdJm1rwV67/aN3TiO8AAcSC?=
 =?us-ascii?Q?3JAg14ZmI1P2YsILNF7Ql511ulfVQTthhjxc96yMIOGh3jTDCN00rPbyeF00?=
 =?us-ascii?Q?xQ21O1eWRjd2pE9d3nYwKQNTLlGa7IDVmHxEP1VmKJxYa+bSmiPPnJ0a6p4m?=
 =?us-ascii?Q?Q7HBnFMdY/agWe7rd4DsriSYgdGfhFGivao98wbFgBrBd98dvsvH9S/qoAuo?=
 =?us-ascii?Q?pSeo0D66zCZHH06bTRuvFLnVCj70SP6A27yxJxiFmXAJMvNOO+MOPuzQPuFa?=
 =?us-ascii?Q?rNfrEG/thLLWZF2SFu/z0U7Twys7iGhK8zqUewuQYo+Sq71xUHr9uytzN6lC?=
 =?us-ascii?Q?y6msclgxlvDTzzOjnlKXVrJCrbfceitUYkxkDsNnqP7pzEs/bw6BRk3woWgu?=
 =?us-ascii?Q?oGg/Y1whs/6bC/yzn4ai+2yb9Yldrkcd7hPhV79a1tGQjTlKWrrJK7H9oz3j?=
 =?us-ascii?Q?uvDTbihgTijHiqJqdkdaGq5CnGqyNcbERzdABdKLF8FrQnwMDq066B0B7nO0?=
 =?us-ascii?Q?DDB5wDsSigRRC1UPnS2lB8cpj0TJXvhIf/qkKkxP0Mxvw2+yYLIxxxawks2e?=
 =?us-ascii?Q?cATuc/HtY41qAa2DJhDVPJzTcCMUDnXZV/63Pbo5oB7hlHashMktNh0qz89l?=
 =?us-ascii?Q?Vgomy4W2yVlUNnuWMN/QtRpFohiRSE9LSScmnSrJ1noibmrhOp1Ffnn08VEb?=
 =?us-ascii?Q?lHiPqW2wXH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VrE+ua1ga2hvnsYJoi99TlXUuCBCoELGEjYtnMn6LEqhwLz5OTrJHXcKjtrb?=
 =?us-ascii?Q?L1doqxhoj1Dny2km6nQJUtxlnLNYLHuTJJz+gPzVsA37B4eiEsbSLLeMjGYI?=
 =?us-ascii?Q?5fQKjPCKXNaj+8W7TMOQOuAJgg6xr2G3y01l2zZFL8+QXDuofZRAVSoiA+Dx?=
 =?us-ascii?Q?9YHSzz9oEJ8/ih9uC2WTi9DWl+aWwijAl+GwOjBj5W2o02zBvvvf4jfHmNgH?=
 =?us-ascii?Q?Fx+VQDtAm+P72WPQT0esvBH8lFt2o5mLNVToJnCCASv3bQ8IqSQBOUH3SJBo?=
 =?us-ascii?Q?6C51yS7gRyDivgtDPE+8oSEb1jelNZuRhDhQ+qTXSxTr1fUbpODw9h3u27AM?=
 =?us-ascii?Q?I9AH/6hMc9sOm/4Cu0NrgiO9PNCQ1LjCERAeACVLGngi1LVJLWMstY0uI5W6?=
 =?us-ascii?Q?3iDZf2Nq9Ir4Ii1HeY7S1xceTD0Hh59TsuC9nm02LngnHIWQX+gJeU71KtjG?=
 =?us-ascii?Q?Sjxe0DWQfIw9urbKnZ8VNjjKOV5ek2zaDpPqVhIjCnqPCwwsRNLiB88wpazp?=
 =?us-ascii?Q?2JHUdpfIJ3F+S+g7cpaTnj0lGogriAZc5D8fsCrDokVdBKCnC23ZPOI3gwY0?=
 =?us-ascii?Q?3qoaJdo8kKFxagBUqfPCNv3tbgeFcQiH8hJLy9hHgAUbQnBltCksRo/S/L1K?=
 =?us-ascii?Q?vub5FejzG5W5DAu3M6zFvwspIW4BoFlrGt1jUlaZBhmDsNiSIq5kzRzG2jVM?=
 =?us-ascii?Q?7VG87x//M/XJcmXnMd+0krZA99cobd/nQipQdWILux+3pnkg0NzK7rt8ptq3?=
 =?us-ascii?Q?Sh6q5hInqYLHITdA+qfkOV73yFlA4p6Rd/QS+ztobtUJPHecz0skKg7exaDw?=
 =?us-ascii?Q?m132csDG1wQowKy+mgsBQuMjtPT9i0TMaHkd6+/CdsHvwH0UnlTbLRUG6aB0?=
 =?us-ascii?Q?f8D2XvT2KG52REAioXDqEFQZDl9p3AYyY7FSvaS3N+x4jkcN2ZOENsixmuTE?=
 =?us-ascii?Q?YuurxFK5UBJP6m33X7JU5ScQIGwFAo1u34Hw5mxXy338G5lxsi7kXUiUaiNx?=
 =?us-ascii?Q?BHJeZCcA+FcCbnB2O6q1w221UCtlMPb1/DLpz8Ejv7Lcrj7vq+H1XOLCcn/l?=
 =?us-ascii?Q?s0BNaDn1lV4lQh+z6Cq8b5ZPfx3yogB9jv98ubRDkqbjLMo4LQJXy88qSys0?=
 =?us-ascii?Q?JpWIDxmc65obxKZBWBV7RllPUZqp1ErhA7yhMUg5zL8OOJ8jeVaGVeY5Cerk?=
 =?us-ascii?Q?pdKILAklQzomFYELfvmmdr6aGRDqE/ieoF1C36ojTrHIn81f1TIIo4q/FYBC?=
 =?us-ascii?Q?mSudqckUrChd7I8rErDLAAcBtg5nOLzXmW5l+W3nbExkJ9ZEIAI3hYtC57ms?=
 =?us-ascii?Q?uYyZ7LXdv0AVglXqG8C2Z1jyYRcZJKwWvFgQGXNjH55Ijpmn6AL5dz9VGfld?=
 =?us-ascii?Q?jEhGlQ6ltMOd0k7g1EhLAMZ5GtNaaRXQT/jxtv7JvJ8kKxv76+sFeWuVIjLB?=
 =?us-ascii?Q?16ndF6QhV/2gTby04FVusGQIrEdHMeKeE8//Wx7mQ/EsLtd2he/xP1bvgbgA?=
 =?us-ascii?Q?jph1jolKH5hHIIg4mZLBddL4/uh3WgCSYGoOQAIKr0ivVCQ5ix5nD0GuBJaS?=
 =?us-ascii?Q?sZsKWNo1cTLPhOGkIxrlwmHKQk3vss1YS1Ps6IC8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7f8f2f-ef4f-4348-11d1-08ddd6ae0e8e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 19:02:01.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37K3MsQyh/EiMqs+Uhc4FCjlSdkugkvA1+KZxs2cl+k2LF5oBXi9N/uTxNaxFfqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

Instead of just checking the existence of PMD folios before and after folio
split tests, use check_folio_orders() to check after-split folio orders.

The following tests are not changed:
1. split_pte_mapped_thp: the test already uses kpageflags to check;
2. split_file_backed_thp: no vaddr available.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 98 ++++++++++++++-----
 1 file changed, 72 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 5ab488fab1cd..161108717f1c 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -25,6 +25,10 @@
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
+unsigned int pmd_order;
+unsigned int max_order;
+
+#define NR_ORDERS (max_order + 1)
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -36,6 +40,11 @@ uint64_t pmd_pagesize;
 
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
+const char *pagemap_proc = "/proc/self/pagemap";
+const char *kpageflags_proc = "/proc/kpageflags";
+int pagemap_fd;
+int kpageflags_fd;
+
 int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 {
 	uint64_t paddr;
@@ -151,6 +160,11 @@ void split_pmd_thp_to_order(int order)
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
 	size_t i;
+	int *orders;
+
+	orders = (int *)malloc(sizeof(int) * NR_ORDERS);
+	if (!orders)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
 
 	one_page = memalign(pmd_pagesize, len);
 	if (!one_page)
@@ -172,12 +186,20 @@ void split_pmd_thp_to_order(int order)
 		if (one_page[i] != (char)i)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
+	memset(orders, 0, sizeof(int) * NR_ORDERS);
+	/* set expected orders */
+	orders[order] = 4 << (pmd_order - order);
+
+	if (check_folio_orders(one_page, len, pagemap_fd, kpageflags_fd,
+			       orders, NR_ORDERS))
+		ksft_exit_fail_msg("Unexpected THP split\n");
 
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
 	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
 	free(one_page);
+	free(orders);
 }
 
 void split_pte_mapped_thp(void)
@@ -186,22 +208,6 @@ void split_pte_mapped_thp(void)
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
@@ -259,8 +265,6 @@ void split_pte_mapped_thp(void)
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 	munmap(one_page, len);
-	close(pagemap_fd);
-	close(kpageflags_fd);
 }
 
 void split_file_backed_thp(int order)
@@ -463,10 +467,16 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 		int order, int offset)
 {
 	int fd;
+	char *split_addr;
 	char *addr;
 	size_t i;
 	char testfile[INPUT_MAX];
 	int err = 0;
+	int *orders;
+
+	orders = (int *)malloc(sizeof(int) * NR_ORDERS);
+	if (!orders)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
 
 	err = snprintf(testfile, INPUT_MAX, "%s/test", fs_loc);
 
@@ -474,16 +484,32 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 		ksft_exit_fail_msg("cannot generate right test file name\n");
 
 	err = create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
-	if (err)
+	if (err) {
+		free(orders);
 		return;
+	}
 	err = 0;
 
-	if (offset == -1)
-		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
-			      (uint64_t)addr + fd_size, order);
-	else
-		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
-			      (uint64_t)addr + fd_size, order, offset);
+	memset(orders, 0, sizeof(int) * NR_ORDERS);
+	if (offset == -1) {
+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
+			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
+				      (uint64_t)split_addr + pagesize, order);
+
+		/* set expected orders */
+		orders[order] = fd_size / (pagesize << order);
+	} else {
+		int times = fd_size / pmd_pagesize;
+
+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
+			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
+				      (uint64_t)split_addr + pagesize, order, offset);
+
+		/* set expected orders */
+		for (i = order + 1; i < pmd_order; i++)
+			orders[i] = times;
+		orders[order] = 2 * times;
+	}
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -492,6 +518,14 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 			goto out;
 		}
 
+	if (check_folio_orders(addr, fd_size, pagemap_fd, kpageflags_fd, orders,
+			       NR_ORDERS)) {
+		ksft_print_msg("Unexpected THP split\n");
+		err = 1;
+		goto out;
+	}
+
+
 	if (!check_huge_file(addr, 0, pmd_pagesize)) {
 		ksft_print_msg("Still FilePmdMapped not split\n");
 		err = EXIT_FAILURE;
@@ -499,6 +533,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 	}
 
 out:
+	free(orders);
 	munmap(addr, fd_size);
 	close(fd);
 	unlink(testfile);
@@ -522,7 +557,6 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
-	unsigned int max_order;
 	unsigned int nr_pages;
 	unsigned int tests;
 
@@ -539,6 +573,7 @@ int main(int argc, char **argv)
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
+	pmd_order = GET_ORDER(pmd_pagesize / pagesize);
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
@@ -547,6 +582,14 @@ int main(int argc, char **argv)
 	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
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
@@ -571,6 +614,9 @@ int main(int argc, char **argv)
 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
+	close(pagemap_fd);
+	close(kpageflags_fd);
+
 	ksft_finished();
 
 	return 0;
-- 
2.47.2


