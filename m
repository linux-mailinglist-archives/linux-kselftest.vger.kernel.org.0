Return-Path: <linux-kselftest+bounces-38348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71311B1BEAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C82A18A39E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B11B21BD;
	Wed,  6 Aug 2025 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UdH86ThS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23931A2381;
	Wed,  6 Aug 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446862; cv=fail; b=JtBvkVkjdgFOAVZuDTmCPhr9jTakJ+uqS3DOnc1nqS/EaXqOEfoKt1BbodnGiRWpzoSfM754jRmVFjx2sxLTEHEqePeDO5im0IxdZOod4Nmg8PJrgYCvgFHR9A47KXf3fJsrK8jPyO4X+RUFpEkxXoPp4R58Aezwiql9Uy6WDCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446862; c=relaxed/simple;
	bh=8j1sQ2CJYFTHJ9e4OPYjwCEt1LpTmxfHf7184YKpNJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ApbAzZEk4R36BLm7l2JRrFEJGuY/Dgrrk2hfjkaKS+gp/gRhRyWvxFYucVAhuVB9vag9YsIbIXZp5+KDcpiXFGlabndBgY7GC//Jyz61P4GABQH0+Go/gmb+/JFHAUwo6ssrvdeo6o1fxe6lRODJNcQhIr6RRCcCDJ04CAkmSf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UdH86ThS; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOEsTiYA6Cb04lmJe4moBLpdeLpxITnqfNrlkTIGQaO/6QpdpRjTOAbvhBq5vg7hWHAiv2lpyrmb7Se+v2MsgbRUCZ9eMaSBcX/75X5dRCT4GgbY1L/psXea4NCUHoR8VYxeUvTNm1d9Ytk3B+j77wGRp2M/o9IMXeYTOe0L47IlOLHU+GzGKRZ/4qYxxBRitPxIVgLUUIwdK6fDe0zhZkya40VGdhnkSXFA9C05nDA6oAmeENe/PFilhBPCTBp2oukjSL94L4FafgFxtprCq+G/l4AJ3JqR3YgdU1V4b3KwejDcDbrPkaCggtJI/KR7+EpG3hto0kW4DpY4mw2zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7xz5SSLnypmQfjj/b0pJttY323XqYc3uM3Guax0w+s=;
 b=rZ8zCXPUZdkIzSJJntq/LkodX7MdNwtmjy3Yl0lOS8c9f1YWqR2W9bNNoWkHJbx+3odfcdRSh/+xgxq1BK+i/GXQsVhUIIJhnQa5d3MNBi41MdeE0+VXiZbjgWOE5Dc82r4Qyld+XS4PmjoDXu1NAKWgdYN9wVdfphoRybqw/VJImm3jhFaB84HJxeaaaHDrhHJ/7gbL5Z1EhllUwKCpVQN3XP5BLVrOweRTL2aRIupWm7KJtbymvtc1UDP0LWmCRPK7nj/4l3C1LaJ4ZjIKM0S17tAqKku8qMxOCx0I5b/jaepeazP7s2JBYXpbk4uPBS04VtoeMpd88DusCPD9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7xz5SSLnypmQfjj/b0pJttY323XqYc3uM3Guax0w+s=;
 b=UdH86ThS3PvQIfDaQGC+UE5FXzaY8EgIPK42mq0BVIIKi1m+cRLMX/HInLFquBF/qUvlaS5wIxgdSLkdvLw7YBU0Z55ZqzLffRovI13imitWHqTr3wof3kAzu3XUSLKVtrtI6f1LTJubC2hIcFw2Oz/2cXQgXZKTuke0g8b0ZlUx5RbHP7XYBt3pf7OYGeTDKFMvUR78vaVLz9GTjuvigIo5EgzI4/4z/6qoewlz7V/jO+SCiCG4u50MzA3/4co6hBeTdp6GNEWfN/PyQRzuhOjPcnBIyZvrOhJKMWXf8BShNZPY/KLvOE2fraug35cvbcPVP+DZBK1OqUSmksNkjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:20:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 02:20:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: [PATCH 2/4] mm/huge_memory: move to next folio after folio_split() succeeds.
Date: Tue,  5 Aug 2025 22:20:43 -0400
Message-ID: <20250806022045.342824-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806022045.342824-1-ziy@nvidia.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:208:32a::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8621c0-f717-44c5-74bd-08ddd48fe0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+VvHfdUopYW9wOmjjyLBRN9fuKnFNHyANoWC69qhIzCdJ3QSUiPahAOhZM6?=
 =?us-ascii?Q?wIoHKutW8WaF0QDGJVTW5JbaAG7x/qJ1z+UkukaLIt+QcDOvG8O5EjAac1jV?=
 =?us-ascii?Q?fg+uZGRFI2D488Xd0cm/y+SBOZ5dHYcmiOMb4Z3K5brJoowtrDoXj/naCzTK?=
 =?us-ascii?Q?xSFgoobtBgnFLUz+pQvlfdGzA4tEiqMTWcRIx+S+/EPJsQBYrbRa186qcd+w?=
 =?us-ascii?Q?3S4MYWQUdfn/ZArNgkIzni34A2JMXQat8+QkxVyK04ctJ9GKAOpIfJiM7n8f?=
 =?us-ascii?Q?coWWQirns3eAQ6J6M7wJaVuUdHziGAPrYzmR46b8TTMN5y8HIDpD5ty2tqhn?=
 =?us-ascii?Q?RIsvEc43tf9oUCqSxLnixn6QVyMxowDaYOMnQOxGRvLd3chx50dOBkrc6L15?=
 =?us-ascii?Q?fP3DlcUxIRudIhYOnbxTRyJxEVpkvu0nvT5Tdfkyl6WvDw2XzCOVf1MGlAz8?=
 =?us-ascii?Q?CvZxEkuJgCGGrtulNyChx0gFKKLJ+Bxya+p0taOV98EvGqWvk7YausjMWEW1?=
 =?us-ascii?Q?dOgSv+1WZIsLCecv6CVBnlmchUyYpfttVgiJqC3iS2fhommk2RnvqY+hinyl?=
 =?us-ascii?Q?jxxFx5TImvpFmXQOxKIlpG77LILvLt3ROO0z0Hh1e0eHRQ0lHA5GRAH7DDMr?=
 =?us-ascii?Q?jRCPA3u0ftvwrktKZTKT3/VlBLBhGN3ncZMqLx5nrF3Zlb1B+PVrh73Lbh6p?=
 =?us-ascii?Q?2b1oEO+C3yqVX5O/rPi0Dixq0iE3HRp+UW03aDZ63aJwewrf2YaAXUo0ivYa?=
 =?us-ascii?Q?+6rEEOdjNP2saxHVKVxVDeogCWZDlUDUe6kple63d3vTXkJH/43AjBbD/X7n?=
 =?us-ascii?Q?z6WOOHAUccyArHMlBj+d9jLJRXD8w7atTSomMP3pBU8LvHvCkKmJoYOhd/Iq?=
 =?us-ascii?Q?YvyCA0nO5XnsAyhEAsTvTsG4HCYjao4TF5dEVyLc8GePa3l5NuBCX5Tzguzh?=
 =?us-ascii?Q?STPXl8/hhf+jkv/vPYiqgdLIc5Xtt0lcf33g5Y+kI7bZfgi6db2o0QmmofKc?=
 =?us-ascii?Q?74kvh/7SoZOPRgfkZVZlqWkRB3+QHezotuaCCi12wwasz7lO4yqJW1iagHou?=
 =?us-ascii?Q?Lnd0vltEgtUq0OOMjjrdKYoT4foxzpboyst9grPWex9ngO4A7aSQXTddtEHF?=
 =?us-ascii?Q?PL+DUZ1XYiV8f2bRRqGhPx7dh2u582y7mjfxOnWo2xSK5tI04FBfYMUHJWVS?=
 =?us-ascii?Q?cwFZUVtkTkw8WeW8oxf83WMxxAUpomDLUL3e8RxbsHm3ELuj2EsJbmjqbtQW?=
 =?us-ascii?Q?x7jKBpnKSeevQjnSi5WOteJheuTeyDc2bejL557J87h/zmrX5Dbegq0a2Obp?=
 =?us-ascii?Q?4/4g/hmbRJHfFR6IV5qqMzWYv7Kid1K1de2ARpWLz2ihtDopJnPDF3UuNVzl?=
 =?us-ascii?Q?+kqspa//oc0JNgd6tSFCe3BUBvMbhPpp+Y2yA4tSw5M2dxNcvt04lMPsRclZ?=
 =?us-ascii?Q?qvFSVH2FNWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sl5FBOlDjDnVjQucMdT7hEmY988CfWNE+VO3qJfnrYw/SEBw6kupn6ueRflB?=
 =?us-ascii?Q?1oNy5QOnyQq6bK/haP2Bx2nB+TKMcGa5tFNtrdyNasrQ1sS6rAlQEGKGRG3S?=
 =?us-ascii?Q?XyjU0nZHPvmdrhDvjV3Wdx++GwVBzsavzKhJJkQB914JHSGEnyurVyQ1idPp?=
 =?us-ascii?Q?t4ojfTyD5ULwa8EnSuira6j6cCtjozp/F0WjcgT8916qHDADLvlwFVQfKmz6?=
 =?us-ascii?Q?FZZJrxE4LcY0Ddp8kuoTDitGKmuSWr73o7hKdaLaSLoSxgwg5IXtGs61ysVf?=
 =?us-ascii?Q?a8efMGa8GpxknxUH4kTRw9qf5TWWCfLksUqEUipJnyS3l0lQGH0byQq/SIrD?=
 =?us-ascii?Q?A30ck0P7keVdvwMogEKiFq9XIO9tpY3JMedjmij2ylIvaCZ2DySFCDNvQoqt?=
 =?us-ascii?Q?8/Bm9csvlfLyp632m2X17nRy3m7vTFwiWpCouPASnZ6lQFBOrVHDU1o/XiiZ?=
 =?us-ascii?Q?OMVag66tujpDYcaQbBwgC6FNWb5W61gA2Vaj3g8TSbauuAscrQ5vLEAbok2q?=
 =?us-ascii?Q?va71r84aWBaBJW7artif4s5TOVz0mvZKi939l/8Pz+bxwudauiB1E2owIHhw?=
 =?us-ascii?Q?WtqUUJX2gpxSzoAtYXFDuwbg+LENRtCz7Q6ef4+XeTYPPcBAxecZXDHzSSIk?=
 =?us-ascii?Q?TmlW+VDVNTjOZrMK+qp50k+da2LuySxAL1zr87NpU3rfGY+mwOQKza4BZ34Y?=
 =?us-ascii?Q?hh8AxRWwlykKYWioW1bgvPiznFKvsuRrhflKN5Bj3j8GpNSGRv+py+VKf0ZP?=
 =?us-ascii?Q?5JoJjbpD7cbT6nltJdlu9iXm4reHKMPoWzT0JUNFLNw7Wi8nRqCxJ3rNy/Bw?=
 =?us-ascii?Q?e98l2i5XKJv5pA4S5yX22vepGVtk8U/6GyQ/3+vtHgbqqovyLsrXgTVijbsh?=
 =?us-ascii?Q?79EYcANruTRbwNCwGJsWRkPtrTsQsn9rKLsMmkZ0NJfAXerrQ3wWi5ifQ95i?=
 =?us-ascii?Q?uCHmEAzZO/lXbc5r8LnZVqmExG5IydRlXR38KJg0X1WN4mJXpB/EcNejYDqU?=
 =?us-ascii?Q?yTR9mA2wzHhioYahIL/jAhhoZkI6X698rZCtvIeANzMCQuho0XZ2SxsDDCur?=
 =?us-ascii?Q?nDys3uQXtgFsd6+j2yxwpxWEMC7FG6/slsZuvhZo9VsH0jZmdhKOPBQMpyuC?=
 =?us-ascii?Q?csff3A66J8eY0zi5tBjd+Kiy3CP++T3ZEWQlCnDS4iNOSzaHrNajBsN8askl?=
 =?us-ascii?Q?F3ei8pHfQvTpmqAMQR9eFaeSLG4I2yZRk/ye7j+QPfCVHEpeeu9Yz7eX8uUF?=
 =?us-ascii?Q?wAev/uQQQOkE3BxOvjLkQt/jBxUi2npp/OirbaRMczlaoMHwSPfBR7BtsE2P?=
 =?us-ascii?Q?HSilCFdL5RfDIZ8NwBjO017AdUr1uufsizokV0SYCazH05z8YFGKVycjuyyH?=
 =?us-ascii?Q?YFrsmGKhD30K3SEeHB4VgG+QY+xp6Q5mJn24fjQxZ5aXPJtkfknZYfpN2h1X?=
 =?us-ascii?Q?VWnax4W5IYAYmeEbR3r0bl5ZlHehhVccgfOsTFQiOthp5wHuc4VaQWTOhEVn?=
 =?us-ascii?Q?Auk/Q/XTS3ArZY73kbdug3DA7Qfu/EfF53Gdz/JEnWsXfjC+nV5fK4Qf7T+S?=
 =?us-ascii?Q?a1KPYEGaURfy3ZRIiI9Vu3zbOBW70ZAf1diIpOh1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8621c0-f717-44c5-74bd-08ddd48fe0a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:20:57.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkMCPxZzl/gufUr9wG5pq4XURZwvasTRlh/IprXTUDvknYpW6OhQcpHD9WKdcPTz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

Current behavior is to move to next PAGE_SIZE and split, but that makes it
hard to check after-split folio orders. This is a preparation patch to
allow more precise split_huge_page_test check in an upcoming commit.

split_folio_to_order() part is not changed, since split_pte_mapped_thp test
relies on its current behavior.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a11c2d402d4..b2ce8ac0c5a9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4341,6 +4341,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		struct folio *folio;
 		struct address_space *mapping;
 		unsigned int target_order = new_order;
+		long nr_pages;
 
 		if (!vma)
 			break;
@@ -4358,6 +4359,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!is_transparent_hugepage(folio))
 			goto next;
 
+		nr_pages = folio_nr_pages(folio);
+
 		if (!folio_test_anon(folio)) {
 			mapping = folio->mapping;
 			target_order = max(new_order,
@@ -4385,15 +4388,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (in_folio_offset < 0 ||
-		    in_folio_offset >= folio_nr_pages(folio)) {
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
 			if (!split_folio_to_order(folio, target_order))
 				split++;
 		} else {
-			struct page *split_at = folio_page(folio,
-							   in_folio_offset);
-			if (!folio_split(folio, target_order, split_at, NULL))
+			struct page *split_at =
+				folio_page(folio, in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL)) {
 				split++;
+				addr += PAGE_SIZE * nr_pages;
+			}
 		}
 
 unlock:
@@ -4438,8 +4442,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	if (IS_ERR(candidate))
 		goto out;
 
-	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
-		 file_path, off_start, off_end);
+	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx], new_order %u in_folio_offset %ld\n",
+		 file_path, off_start, off_end, new_order, in_folio_offset);
 
 	mapping = candidate->f_mapping;
 	min_order = mapping_min_folio_order(mapping);
-- 
2.47.2


