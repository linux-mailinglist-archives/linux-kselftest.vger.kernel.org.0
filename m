Return-Path: <linux-kselftest+bounces-24931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64391A1917D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 13:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0291883C8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850A212F91;
	Wed, 22 Jan 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="caM5M2rO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5073212D7A;
	Wed, 22 Jan 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549659; cv=fail; b=khCHoaY8oeNF8NG2+YRYR1JExvlx+sO/JyS4NwxWD272Yz0onZRa4T4zhHNrlKFJoWqPR1Seb+m7zz0eorL1ITSFW+2WJWyKs4FMeIhhfjhI1MCwAtk0xrmSB4MIRf2U0Sdw4FZPg22TYT57h94aALiA2Q1PlLmG0+6aC/gTZ1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549659; c=relaxed/simple;
	bh=uMqI+2tqCXQabaHOMMNEdO0SRwfWh7bxHJBeeh1700Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+Z0Dkbn6v0z5+KD1W8yH2vWw/XW+iiDLXgBh1WzVy+3bqeQbUMkeN0RJyAIoYta71h9dldlZwLgpLbUiQrMtMnTWcz0+7xt9g2O6gWSrNMbAr7LN0HFuQA2yfWFpHdjHJXDGhH2ARPOi4WPDZXIwOkhB7l4d6w64wuGMChVUWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=caM5M2rO; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywzzy9mW3yp3/nFWmmEHVBlo94fsivfiROuso4Xu7Wu4gHf7DmUtboo/x3AYsNjwSlHbwvT4SD+VoRrmgwt3PzrPJKmtWFl2AlBoEj2TaxGUAt+a/R1SaFsgh2bpLezRmmcT7WvOTNddqdOLGnriaxfTPbRr2qxx1KNVDgUUM09x9mYvahLfhUC20aDWiEfsm1kV8/Eagmyz8m3BMVWvwj5+Ax/VVYPaH/kNHqu8tuN2PvZ4nRkMeaJ5pyedf0YsDA0BDWUOhDmmVgFY2gmeAtwVDUn0RlcCmOo/K27Cxb1pnTkm/tSu6Kh+0gxad8MH1o5vt5a3MZHWVsmJuOiKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmKa+b07ci/+SigIR8tnvRx0W0zt+6m9eZpwmObzkqI=;
 b=vFxpVfR5Qx7GeZmbXyOgbRhQRR+ZWDRqgRZBSjlARCApFkwI/jKDlZGrBvMCB3KOLMq6zOrYhuyfO8oCnr5s24ZWpQWPgk8Dvax/v+RqagZYylOg2jSwnUcCrMax0V3dpF2w4PQhAc6JlrYpziT6aCzWBxFbxq4tHzVH4bmlDBtKr4EUol5lpkhXE1JMDepFTeV95o9prCenbvORC6ICfAa0r9DOuYZL4zjEnt+IvsG40+yM9M6NwWNtRn1UknSkegK0xQlGrBtvh3NRhtKOzGp6M3vXJhnbebjBJqUvJrCw3S4OvbHxohidlsVID8Il204KB63NY71sX9fWRtU9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmKa+b07ci/+SigIR8tnvRx0W0zt+6m9eZpwmObzkqI=;
 b=caM5M2rOSh4vH7qTnba99IagSCqTCc/NgJvPV1zXDfJ8AZ+5kMYY6wowI6zsaKdZWraVFqGoaYTUh2BvhRy6yYYp5PLxtrND9LMlRu5vcKTOLHl1w1PSlSTo+4Tlo7ttQkO5ULD9idcLV88ERTqc3lKLIXf6FRr5QFpFC/XF8bIdENYNemN5OCgh9fThNeJkJMzjR7zTlBxX4IYc0/p/JYvcguo+xGgthP4YHtQCsCMBN5ZFYoS+IWFY0wVzqIyskDh3ZAv2EuaxtTej9gnoSsQsiljFUtasLzm8zEQ9mqrdJdAOF/FTm/0XTVe7J5SMTtmhKq48FuIY7+zf3mdtDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 12:40:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 12:40:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/3] mm/huge_memory: allow split shmem large folio to any lower order
Date: Wed, 22 Jan 2025 07:40:46 -0500
Message-ID: <20250122124047.1216024-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122124047.1216024-1-ziy@nvidia.com>
References: <20250122124047.1216024-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0501.namprd03.prod.outlook.com
 (2603:10b6:408:130::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb2722f-ff9e-40b7-e83c-08dd3ae202bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmM8jSgGpBY9dqfpfWB0alb1EP48V17wok85A72z5NvKakx+xXcU9a2uluMr?=
 =?us-ascii?Q?838izS20mUjxU+DnDVNkt3KdjkQwRAJMla1kBKJhWM0SzAO5Z73LClv2xsVj?=
 =?us-ascii?Q?GAhw4IfRfoLVVSnmK+tpWabS6nuMB3xUsOKMO8a9OI+08RYolkfllDH/doZA?=
 =?us-ascii?Q?EAgErUw5UIn8XBdeGcS6IzIbeuMSdae6aK26rHiGp8JlveRO4HIC+XCD0kRl?=
 =?us-ascii?Q?4djWaCGbHMqFrvFB7RnuxSxB006NnMBYlbWswoy7TJiPbvotd+iGhMl18V7Y?=
 =?us-ascii?Q?5h1WWiiBgefw2BJAA401zXGqdMIy4vUkwKxocNeH8fMAVgk+nsrEItUTe1Ry?=
 =?us-ascii?Q?YJo5SeU972nR4nSqRgCxeV4I413Dmf1jP0+2b3kOHs7MxyZqxfzMwsxOZWFU?=
 =?us-ascii?Q?TY7aF4+6yrJe9rtwTzP5Cx/oicvyQ5p8l4yWFvKo9vS8a0YTDyHegEpI5ZfV?=
 =?us-ascii?Q?GNbokb7U/SiUajH0iX3sBpm8pCSl1xa8alEszmx5oHeOgtgc6havjMMS6MRU?=
 =?us-ascii?Q?o1fAAjD1zBilnXNzGLWnOb/LH7EWW3CX5jHnhyLl+zTzRGBQL2GcKnDwKJy/?=
 =?us-ascii?Q?Cn7TObBjf+UzCJnX7qHN/+MFpXIekbLCPoFsLatS/5h5UwW3frkDrDmbRxkl?=
 =?us-ascii?Q?TaP2fCCR99DAfzkQ9CDI6eC0ewKCwP6bljRNZTsWDJhMzn3xEDXxw7bomfAa?=
 =?us-ascii?Q?dHnYMcf8j4HXZCVAfZjky5dx43ZfiXyDvORnY0u2D/KMskTM/HhJY/CMc/K3?=
 =?us-ascii?Q?FSicbDtghu1v4L9rcXDHMTpy3RdopxUoHhF6UglqjHxyKvMeRcu1VScv0w9p?=
 =?us-ascii?Q?uplao5r/dEi5AhmwZvBHtKoyO5C7HYdylwyyfT7D882d+RQBG+NxXNIUxMx+?=
 =?us-ascii?Q?UR+/IIzsdcCg8tI/cOKCkgxpJusY+7rj+XtLgDRDK5YcIUge29OsVx0QCkfD?=
 =?us-ascii?Q?0bepOO2ct6sYHJPPEDJpGn3oRruI8OWXB3D0jHCs6vySsEKn3dgebqXL/Tk1?=
 =?us-ascii?Q?w2rNSWL9pGeiX3Jr7u4FcegKph7fp4d+2OgRcOauIoSZIWEPMEi4KscTlkLq?=
 =?us-ascii?Q?5EXrWZy7Cu4ci/gBbJvsje2V5DDyhMY8EcSOElSqGzaLG/DZ5Vfeg+IuFJDy?=
 =?us-ascii?Q?Q4E0HzvvtTPyWNB8epEnKjIMZg75Yv8HfDPITk84qEc+nUXwnnFmUFNR1DRt?=
 =?us-ascii?Q?3wzklRj1IgmP6csX5zFTlxqOvFvJHun1YkV0PHM9e1bAdvZkhOzbA/r4bX6Y?=
 =?us-ascii?Q?15J72HgVen8vDmOxYv+VcI680wZZoss41pjglj7Y5WRhUKHNUQDOGbiWKxwF?=
 =?us-ascii?Q?rQXVxMTIzXIqINs68HSdpgDnIMlRSnyGpGJ27QVuobjM5lO51VWZjb1U3b+v?=
 =?us-ascii?Q?OaBSLXgVumrizBKdY6XN7wynwK+Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxVih0iVeFDRdlBSB1m/STBAbIkiovNt22WHhQzU+9bkWdb8cscYji/M8A7+?=
 =?us-ascii?Q?smdChSXAFhma3Lmt1YmWqbdwnzdsscDwY3BZhH6vwj/shNYpUkFkL/kmar0g?=
 =?us-ascii?Q?2OyBB3DpumcrqIDbZSW3NHNRIa5a2f0DDrMC3Oa7UM86hW0DtxsZOhox7iGn?=
 =?us-ascii?Q?jR4Ig5jmyDwFfiOO5hzk3KR+0tLQmD+DJog/CGVas68Glc9mNDHw8PcPkjqt?=
 =?us-ascii?Q?xYTROUBuir6ZrXJKtQK5xnnkcOvlstF1gcn649mGHSBHfHj1PLXJ1ve9WfnL?=
 =?us-ascii?Q?oSRvpqbvQAQv2eErmPWqoNeRfZjQeRZR4vkkhFQP0lg1nBG8VOsgtf8r9f+a?=
 =?us-ascii?Q?LR4TeWnCRGlcyLDBxE44iQFe7A9ms0MWJJAIYQFyxVGypnSA2Q0yNV8FEt7P?=
 =?us-ascii?Q?RLoxwWy1Y6NtC30DqYIAARNtwxrAkjoyabu9QPlc+rY7eEqiCcnufkO+0vUh?=
 =?us-ascii?Q?PfqxXX978iH7Ja4KVdTh9/TiKQ6qSPgPWxQIKoHKP2kk5r4wOVzPlFjQn5zV?=
 =?us-ascii?Q?i5bIz8uvsdvguv/Np4HG0oMlJNQipgYrGbh3hh7tWfPHi2l0FOX8DErfAu4a?=
 =?us-ascii?Q?dEwO+s/w6AdEkd+IBxozP9KeI8dajcAmrT2cAcEW5JHNuC7Md2tlaUDE1fQZ?=
 =?us-ascii?Q?qPt49kqUhKNHmI5j+MQMcjVz7HluCgdTAen/Tr7ATJIuYVCOblKxbb6+8IIQ?=
 =?us-ascii?Q?gdXohFvPLFPSKOE5e5nGolUjCj5tS2Rq38k53koAuRemP67ot0pVpZIBdHRU?=
 =?us-ascii?Q?cqTeuJi2BBOeE0YaNQQFbqZ7Xgr/rr/zvGq8hx1jibMY0fdToRVpbYutjofx?=
 =?us-ascii?Q?pVyB09gRof8cEqsK8MeV8AY3j4ePzKW2tYrPawpBQObLxkca1hZBD5o6rEkI?=
 =?us-ascii?Q?SM/TdYQuXtJLb7urfJ0kydaWEJIGN4x8p1vjcrHhs01dNBZaughD4vy/mJSe?=
 =?us-ascii?Q?hoFLWryRyAeY8iLCFg8f13bIJwi5/T06c9aUTjQ5O6Bq59w0T+YUR1ylndWt?=
 =?us-ascii?Q?8ogQDt7onotNWYAXcGYtZPQL321HZrr0V2+hotVX5KCDxVfsm3XU/WLoo2gh?=
 =?us-ascii?Q?iwh+kBlQuntQIuMfsYOsHJPMId9e/yzx6LUjh2MzW5ntBBUfR6BjnjMDsRvK?=
 =?us-ascii?Q?bu11hJcXSIJE3tGdxudCxt27vtCDsbhugHiMTricnlNyyhxaxbHKzkLwv92N?=
 =?us-ascii?Q?HdC8ibDjOio9FziqGACzXz0McmVtCq4B9hkQQ6nmS5kQ+nUr8oaeVPbNb/U0?=
 =?us-ascii?Q?p7HfYeNIRz0vgcmvxdV9L84iss1daILeC3aEJlwPhgbmBEMV16HI7VEgZSSj?=
 =?us-ascii?Q?KP8fNtbWzgmYKu1nR8MUB8B/8NV5+dUG8JseLlmjds2nkhi8AyrdOZjCUdb+?=
 =?us-ascii?Q?HYhB4+A5ykXsuX5WgO8o70c6t2XrbKFtxDMuRkp9K6F7vTIdwjTYiW9rKnij?=
 =?us-ascii?Q?GWAIthMgLQeLmH21NFs7oGl+Q9uX5VCbTnp3qK34Ao3hu53xJ7jGqbHIWER1?=
 =?us-ascii?Q?azsUPMbEDdo/GnBfeykMBM6Ehp1AQWqyXIrLpFVSg/NTSZJ7gUibhHloSyCV?=
 =?us-ascii?Q?ZysUdPeVQ/RXlMnffo2a9/jtrOX7yCOujLz8y4W5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb2722f-ff9e-40b7-e83c-08dd3ae202bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:40:54.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSZoVvTDqyOm/1lXJ7VDPGG5xzuVE1n5C/grwYft5An4NqsSx85MbUqmZt16L1sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619

Commit 4d684b5f92ba ("mm: shmem: add large folio support for tmpfs") has
added large folio support to shmem. Remove the restriction in
split_huge_page*().

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..deb4e72daeb9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3299,7 +3299,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (tail->index >= end) {
 			if (shmem_mapping(folio->mapping))
-				nr_dropped++;
+				nr_dropped += new_nr;
 			else if (folio_test_clear_dirty(tail))
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
@@ -3465,12 +3465,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			return -EINVAL;
 		}
 	} else if (new_order) {
-		/* Split shmem folio to non-zero order not supported */
-		if (shmem_mapping(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split shmem folio to non-0 order");
-			return -EINVAL;
-		}
 		/*
 		 * No split if the file system does not support large folio.
 		 * Note that we might still have THPs in such mappings due to
-- 
2.45.2


