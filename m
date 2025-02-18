Return-Path: <linux-kselftest+bounces-26918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1715AA3ACD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1BF188B831
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D471DF24A;
	Tue, 18 Feb 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ha0PQVyf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A591DED59;
	Tue, 18 Feb 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922638; cv=fail; b=TqMXqExglr5MASb14/FQ9cF0GLLc37foD/p4ViGf0ZqeigvafzB44vKDbckPay040mQ7BLz95S0eo4WIsFgL0j546GG0tVQ+joZw3sfol9tQiM+ruuC8tRfpqSSCMbliMZiutVIQLb1v81LQ+64ts3Lx0eJLGtyRF/ZryC+mJPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922638; c=relaxed/simple;
	bh=vD7QPAsdzZg918nfIVKVdnKgkFzi1UFKGV76SQQBZMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I26BIhSqM1fICjSNtj14Gm3ekT6SCIRwX6zkzpKfr5eTkIX86kEIsLPi3NsGrPhNJaHz44FYydhyLZuSw1vHzPm+WXKOWeVyeJ7UJlQAzoJiP2sv5y8NsDWC9WGwbjs2XWhgxZQ8hbd0Zj6FYBajoieCEEC91FRpOTNrUCXBgcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ha0PQVyf; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgoxzcAhdHtOzXrGDSO0wG7zcc+jtytcdx8ACvfBAG3REmczfwnq1IxHRt6sb238Tg9l/1xoHfIXW2BsxEW+psDZHZQpaV0735XHiGAdA96IVgd548vW5/8RGc1imhXXTchraGpHXaePSrtE7WTCJnULi1lzk5b+Vh5w/ZCqKzH6BjSKD9tMpRzB24+nPFJ7a5YhHV/XECpiIMRRtpyP2RuIQbR2ptVJ9E2o13Fib6sgvq6K4s1vqHV9K1XZ8DQhDJaguimWx8loc8CeP6VQuo0dACW9P65clE8tO1QooqTlWNyYZQSO1nsZphVSbWYetK+ZS0I799DObnOZG9SFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PJ7zBIViLKphcXY2b8VdDiqcqFp+9EBhh42TsYKGoA=;
 b=C2Oihr+M2LqagNjXqrgjOiq+4V3jYYtF2bbtaK+Pw9fJ5LMkP9SBs4qC+EbxH+v/Uw+lpKGfsMLXVcVgeqUwZ4ppcrhgRZqcxxltRU1R00Z7e7NcSER78WPi9pgaHSZtfb9yXo+gFyXcDbkpBGftjenFORycqbCCXg8+7FRpUA//BE+go6qbJKSgJhY1X7aiikPQ5vK0H6L57Z1cD4xwmCEJcwtYH+gYfqaofYILy3tYJwzJNWOsdkgWBYVcg+2UMmt9EhJmUF92mWsq8LIW7nRVx9liZYYGW2R2SyxIjnIjyWpW4fv4y7/ojwFCTlRZmYduVN0DmJMEQUit+vsrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PJ7zBIViLKphcXY2b8VdDiqcqFp+9EBhh42TsYKGoA=;
 b=Ha0PQVyfv69SJcF0U4RIvgdLtJOpcCEpIFtMmTwTNcpTPcrnV1PEzCpjiiwumvxSpX1P3ptYGXm5D0FXv3TNoz6zHO3w1VxWrw3cCWhUg3Ac2UrDFOo+B9pMAo6UA5Ty0W4R/HftVwEAhNuhMRqhOiilqh/9YXQjALIqU0e8gra1qragmbLpWmAbu0XoI5xc4jRTD5jOCWkFLHinzQfcDZN8JA9CHWvzbihpbujnOyu5cOdJi858nxUdjm2V73lRN0+kIXANDpT6gHHypPg0YDvluKacHptDCxJodtCIbLgVZS0yynJ5K7BmG7m7J5RgoDfcB6fW7NWhCWiNK84DeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:26 +0000
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
Subject: [PATCH v8 7/8] mm/truncate: use buddy allocator like folio split for truncate operation
Date: Tue, 18 Feb 2025 18:50:11 -0500
Message-ID: <20250218235012.1542225-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 465ef961-511d-49e5-15ee-08dd507704a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZGqm1WUYQ02z3zTjBS7lTgg04EZYXo3E9eMgjvyn4VpaEuLWS3yYl2zYpUi?=
 =?us-ascii?Q?fmHrLMuaOxxlXuj2ePxziAUssKEROcMx4NDEC8/GT4C2X5ScQZtNYxrjYQeq?=
 =?us-ascii?Q?Gk3r6Ocm9E4buOo9zXcB/qCfAJ3pR5FNo3/L4GQ2cSRSRoDsig01AlXZCWSK?=
 =?us-ascii?Q?2XP1GJy5v2TWjbv/Nt7WUh1ker5SXawqTKHbUQAx+z2YVZw7skFgE9Bm1ryG?=
 =?us-ascii?Q?1SCpRu9rs/SxszOX2T6aI+KZM/rwU3S43boRIxFR6zyjY4VVHiW07sZMMzIg?=
 =?us-ascii?Q?QFKriozJM6a3/JuJJ7UB5crQQA3n4aEWcdD4nAmJFJqdj19bjnoBsLrojGf6?=
 =?us-ascii?Q?FA2MA+Er8A/0zCi+5NMMGGJyx+OPVWNKQB3wnGgwb+7er5fKk7WsH+JIPSwu?=
 =?us-ascii?Q?dbc0E6ZCPiK/pADRNvBBItl/JBaX81IwFmF9APbWRJHQfboYavx0WM0yr0IC?=
 =?us-ascii?Q?d+BxZt09VehaOhX4ynLHnnn4KZfBuXUbi6SskK9F3cTZ8T9mzOy3gript2B5?=
 =?us-ascii?Q?qpWpjuFtwpHfmg+ltLxUe+aAwrW7Yf6XxhiohYLadAaYEYzRblcKoEojS5fB?=
 =?us-ascii?Q?HzsnmahTG1uoHBBAPlTtJv04MImLoZOB5GAjWbG6dKRB/C6z8+G+ak0CnDHX?=
 =?us-ascii?Q?gyWAmaHta2vt9nWS5FFUF5uDwK75KU7qyoiVDlsUnDEVx3jzgl6Xp3qB8W7R?=
 =?us-ascii?Q?CI0iH39bG2eEcUTUMT3fIJWj4SmdwOBLGb3qncGLeaqwcSgoXZAQ4dG5xBt8?=
 =?us-ascii?Q?M3CJuYiKArNbNsms77CiPRH6JMEfTB8crNOJvxXrW3FzQyHU7Tmo+i0LlF5Z?=
 =?us-ascii?Q?pe7sA0T6GkevU9irKI0XxzDs2WYS26q8FZtY71BGZeOiiBZsaGm4WN+CB/Z+?=
 =?us-ascii?Q?UwdZhZ/nBzmw+6oxAj8yIVAnjPUZNYfHWdcr6XyaKejD6EFiVC9J5fhnGqcN?=
 =?us-ascii?Q?WIE4rAbgrCRUTMyxuJzqfz0JcuzLSBfuoMePOgmaFBrYpZzQUF9Ltsk/B1Qx?=
 =?us-ascii?Q?Z25oDhllBaen1DXIJkKE8QVCn4/6inIk37Gr+KwFIr8deKbx0p/YHhiX8BN3?=
 =?us-ascii?Q?OQVOuOcIfxEAqpeCX8Dx8Wo7c4MwWcoiLHE24tMn2v7rHwSNoj6FuvxteE7Q?=
 =?us-ascii?Q?G3VtMVYKipRT/IorXwXKDGCdw5kOCkkRcQoDRYR88aNDlYiQOT6WgoZHqW9F?=
 =?us-ascii?Q?ghb+mWAgaIaKxFTgRGiHe5BvZqrDxS835tFeBzhuMa01UN+P4S35e84UtGO0?=
 =?us-ascii?Q?LUAojuA+1pauC3PH5343lOJ9f5SzhneoW4pIjM58geAbHOS4AYlkopHHohMy?=
 =?us-ascii?Q?hk288lMaeyLJIsbCyszIZMeI63GjE0KjCmv7nHy42IJc1PqbntiW9lZzo4Gt?=
 =?us-ascii?Q?f/xr0hPBZTvnRFM3oRwQP/6H2QuK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZ/X/KKz9HMuuIXuJ+n+Qj1RAvmO55xRM8kh9CEn7SgySC4KzvIkxtdJDS4j?=
 =?us-ascii?Q?5QDy+Rcw+ubhItx9kMzpQs7Qoya7quMdkstv+MKt5MHYd8HUbkBW31nzWjYD?=
 =?us-ascii?Q?6rwm/Ej1h+mYcBrrOCFz5escwZ2CLn0jrB3KmEdMrzEVzRSFYL+kHsyhfQ0y?=
 =?us-ascii?Q?QXdITMZ04AyoHi9MuT09RnDJEO9Qu6oD/nLpVlv33yZ+nTXyWrUE0d29/Nth?=
 =?us-ascii?Q?0oGBxnHJ1u10xQrnud4Up0vwD8OiAKp5M9n88mTtC4lw0KNqXgPyjxUl5LVw?=
 =?us-ascii?Q?FU/lhVx/p4MAedgHFsqDS3yqHY1Q034+jDjm/5s/6mxc8I6za+beGbbTN5YY?=
 =?us-ascii?Q?lTOK9XvWSjFIoll3XsbxuJW7Z321alhaEW3ufDPySQNo3ZKd/9Ib9VHiYbY+?=
 =?us-ascii?Q?b8UnX3b+pZZvfJ6jv3vTGSEETbNyqLFT80N9yXdXZibQEgjzD7U0Bem9mmjY?=
 =?us-ascii?Q?kqYLovtYjk/0vkdb8Oa9ZAH0p2uTrhvL0xus6k9qYdofycbXGs4+1gQ7xF2U?=
 =?us-ascii?Q?ScUl579qZ8vL5xUU3EdEYAz+uyKnRpbWzE4tsyckalhM4lnMyQAx78yK0QB2?=
 =?us-ascii?Q?fWvqA85+bdpA66W19onSUExyGbv1LJXAUygbJG2S4WFKOWa7Dvixn/Z9/Kj+?=
 =?us-ascii?Q?1pLJopzTtw0uTocu87bxN49ejI5N6H0sE54o87OTcDP/idIV54lTdkHqu00y?=
 =?us-ascii?Q?n9FlHNWG8bsylFFrQzyaEaJDl6oixNyGUOuiNfz4XSNpZxJKuWKHX+2QY0bB?=
 =?us-ascii?Q?u4y1DPtZtmBo6w57oeUGn/56h3vy6U/FH2Ii0jCa8NNxPpSxyKUPWmg+Trjc?=
 =?us-ascii?Q?qJt3OkqpAB+e0gHOtWwfp/hsAeKVLPFSxDPUzhIkS5QI2iHOExqQEMeN39Sf?=
 =?us-ascii?Q?eSNrByn4WLxWB4R7Q4x3iAox/4Xn50BCp9kdhlXAGj60QOFNkDutt2+HUyY1?=
 =?us-ascii?Q?DGmRfaNBLfNzKsIU7tfnx0Yed3Q2n6DZbfmkKntOQKmVQ2cRoB+hsixfzsYx?=
 =?us-ascii?Q?AiR40oAl6ZmHDPjVq/Z1muYVd2vs4t0Vk3XUe8ne1tCfKSHEH+WhdA7c7FWl?=
 =?us-ascii?Q?RiY8lzo0RTawYHCtXDjPkvvkZwn0+5ZN41R8ZqThKpnjmSHPQl0V3bHP5ggu?=
 =?us-ascii?Q?o0/kdLHEmqHZg5mdEmZbQayAe1D0ZrMvwTHAUFwCUneus4SXVlRmDkAW11F4?=
 =?us-ascii?Q?S/Yi9TCIipZtQ6hTGXZOg4YowlwA/xhT3MjEvscy8wgVCHyerOU7aMwGHyzg?=
 =?us-ascii?Q?CZLskzxd4KipYevDJklEnnnaa9NVhgsm6bJ64ZbYZhpzSCW6F6lYcDYOw988?=
 =?us-ascii?Q?85Oa6HnhXk7n6cRWW9zqeVy/ShmXlysqkHvXkQkzJOwxq+phmNGE/a/Da+b1?=
 =?us-ascii?Q?Gdc7OkeUTP3KkE8S7Kpc6aNmsjWN2BzS9IgKgWaERxJ6zWXFQvDbAfjuWv07?=
 =?us-ascii?Q?Pg/+vLrr4G3D0cjCd7fs7R5l4MohPwjgXjF+I/at6AVAneVGx0TTVh8vTfHH?=
 =?us-ascii?Q?I3Nyecvc062VhB+GeM2vY/gdi5UfLC/ukO3LumWI5kGMRlsKXADgkfM7OoWd?=
 =?us-ascii?Q?wyIXH8KiOqqt+BsYMQldqxzGpenYZjGgiAOTgTOh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465ef961-511d-49e5-15ee-08dd507704a8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:26.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suRP11NNToaNr1A0gWcA0uRZy5sC4hGgMV4qozEZ74qnglBe5VqjMfHH+Xg8vqTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

Instead of splitting the large folio uniformly during truncation, try to
use buddy allocator like split at the start of truncation range to
minimize the number of resulting folios if it is supported.
try_folio_split() is introduced to use folio_split() if supported and fall
back to uniform split otherwise.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10], then another folio_split() is
done at 10, so [8..10] can be dropped.

One possible optimization is to make folio_split() to split a folio based
on a given range, like [3..10] above.  But that complicates folio_split(),
so it will be investigated when necessary.

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
---
 include/linux/huge_mm.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        |  6 +++---
 mm/truncate.c           | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e1bea54820ff..2bd181142b96 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -341,6 +341,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+/*
+ * try_folio_split - try to split a @folio at @page using non uniform split.
+ * @folio: folio to be split
+ * @page: split to order-0 at the given page
+ * @list: store the after-split folios
+ *
+ * Try to split a @folio at @page using non uniform split to order-0, if
+ * non uniform split is not supported, fall back to uniform split.
+ *
+ * Return: 0: split is successful, otherwise split failed.
+ */
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	if (!non_uniform_split_supported(folio, 0, false))
+		return split_huge_page_to_list_to_order(&folio->page, list,
+				ret);
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -533,6 +563,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c257c4006f5..e98d322c3ac9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3523,7 +3523,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio)) {
@@ -3555,7 +3555,7 @@ static bool non_uniform_split_supported(struct folio *folio, unsigned int new_or
 }
 
 /* See comments in non_uniform_split_supported() */
-static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio)) {
@@ -3869,7 +3869,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
  *
  * After split, folio is left locked for caller.
  */
-static int folio_split(struct folio *folio, unsigned int new_order,
+int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
 {
 	return __folio_split(folio, new_order, split_at, &folio->page, list,
diff --git a/mm/truncate.c b/mm/truncate.c
index e2e115adfbc5..09948178f2f4 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -178,6 +178,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	struct page *split_at, *split_at2;
 
 	if (pos < start)
 		offset = start - pos;
@@ -207,8 +208,36 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
+	split_at2 = folio_page(folio,
+			PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
+
+	if (!try_folio_split(folio, split_at, NULL)) {
+		/*
+		 * try to split at offset + length to make sure folios within
+		 * the range can be dropped, especially to avoid memory waste
+		 * for shmem truncate
+		 */
+		struct folio *folio2 = page_folio(split_at2);
+
+		if (!folio_try_get(folio2))
+			goto no_split;
+
+		if (!folio_test_large(folio2))
+			goto out;
+
+		if (!folio_trylock(folio2))
+			goto out;
+
+		/* split result does not matter here */
+		try_folio_split(folio2, split_at2, NULL);
+		folio_unlock(folio2);
+out:
+		folio_put(folio2);
+no_split:
 		return true;
+	}
 	if (folio_test_dirty(folio))
 		return false;
 	truncate_inode_folio(folio->mapping, folio);
-- 
2.47.2


