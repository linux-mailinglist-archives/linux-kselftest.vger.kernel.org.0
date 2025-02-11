Return-Path: <linux-kselftest+bounces-26382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B024A3103F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5CF1889E7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B4256C60;
	Tue, 11 Feb 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmkoWF3l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51119254B14;
	Tue, 11 Feb 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289058; cv=fail; b=XhGW3+3I8RW+6uoXdHxNCzH5Fa8INwzDUmxmOVY5t7STAqsQaDnPmQZv9DLotWkpzA4Td3cmPSEJdfyn0N/2sU9Hh9V7/3u6kop93Gf1GriQDgKCjOBqQI8YpUWM5tt6nHrNc9cPqrZu7nAVBQgLOIrAJAxsqhJkISEWzBBf/cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289058; c=relaxed/simple;
	bh=8amCi19GhjhmtV6qUO4BnAfMY009hPdf7SRSZy4X/ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnP36oCbUqyfxstbV/Gx+r9PvZIFGfkZDlmz7NTeD+NCXEv7UMDlIbgQ4iN/vOxzydDYBNNj6F4TbSJSi3cdVxaaijmCQEfgEzqDpuBlRiB7bmZWiM31va0M/wlHApzxN280D0P9mEMy9nxSRoS6achTBqM7YaB9uLK14BEH2mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmkoWF3l; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1LM9BQ2oXvVtlALPDG/i5ls7gLn6Y35n9JD3mCk5GNeCobokPFFaG6bjEhPAt84MIdXavcklXfj38yog/NnHaoEsrqnIQMKzw/kDk789gNaaJjRRCJnnX38/6ee5P9hyjsFuiuBOFXduSmopeHLh3OG+4l+Rt5DaB1DyH2aNRRuvCuKILq0+nQ4x74ETB6jxzPdmfS6sv0jxa/ZhWy/4TSEReTljXf2LmrFF18hNWdmiiwpFBEVWJGaAEOUm7ROeZqIUESB8F6AUFp3VEiNBhgIfn+kCXv6xWRZlG3etMevCP7tvwO29YMnk4+MPUJP4WJcHHuSc6WJ38OzShatEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do6UgCagHEMv15lPq0eInz4x9hgwdYqOvKQcVnerGbs=;
 b=ewxRpdZYOa2npRk3bDXcov4xppZllFq5mtJcFgKfRjQo7jVdzvwjd2cBi+yqDtMdq5GTRW21qjMk5zlLTaWhHG/AllIr8pwy7JtFkcTlNEv+/A8dW+020rmQ5fv8g26H+B1aRT/S9I+ztqFp8zDwtTzra/puEwmtCIbhinCr0WpcI8fB6GU7Ppk5KW8Rg6LOAeZuHN9EwDong8wa1O/VWwFDntu4fkL0aGAB7Gm9PjHO92MAW9jGuU+XJ/DCkl6EUjYzStfeBmWVSDm/Kz7rspNM2gaZc5S7AeajUaXad0+8wGv+vI6zmOQLC6Zos+mneIc1Ou+5E7cfUWNJn5bpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do6UgCagHEMv15lPq0eInz4x9hgwdYqOvKQcVnerGbs=;
 b=DmkoWF3lM9qWeo90cjqACL4WvmS+SOeWOdqtPXqbPgSR5IXUlAPU1OBiwWLTjOZrOVn7VNL8eAu/5rL09ASCi7cY4NYZ7ODL+70y3pHYhDNPMys2Si+kndHW8G8ilwFI2Bd4+Lz7Ym5WrU7gpd5fAGV9UPGxAJtqjpBG1PvyvBYKh326Sc95mG+rTFSQ1WBiTEc/9L2qehk4jBCtDHxejbab25F913FpZauO25DlsM6XBvzTCsvQXfj+HajLqCxM4WEW4z2hf5zSQo9wKWz+CrO9Y0xLvbtdDQ6MLIJiyzQij/+dekdOpTlCD5K94C+Zs5kqPwGdyk8CvjdZmjJXtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:49 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:49 +0000
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
Subject: [PATCH v7 5/8] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Tue, 11 Feb 2025 10:50:30 -0500
Message-ID: <20250211155034.268962-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca4f026-3ba4-42c7-4568-08dd4ab3db4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9y4nrC8BoxrwKgCb7CPzg7JiwW9aJHh0QEYprJEyZNf8mK7y2mHtS8i6lGCL?=
 =?us-ascii?Q?zczY4fBiLSIOFk+NLOw2UGVZMgF1ZeUTwDwjgQCCKgGqNveRPkxvAsZZPWXh?=
 =?us-ascii?Q?5Hgm77IvcZBbkQQ9LvIrBROUml7zT9QKphz7IRiXViR37T5n8DmJkdBl/TJ/?=
 =?us-ascii?Q?JzuJkQ+wMvZBXWl0qOB54lUSRpsnI/NHQvsAXGNbTZ+wyl3BQxFpC3NvfMMh?=
 =?us-ascii?Q?ZfAWbYMG7shh0AjrNaGZNd9peVkKivAmzZjiUDtMRcGZDKbIqgGxdN8rwzgn?=
 =?us-ascii?Q?AaXErBoz0/MiU2Z4RKj7RveQJd3JsqW6o9ugryJ+3JHlI+W7flXxo8t9gtRA?=
 =?us-ascii?Q?0A7YyYCKhige/FZz6tDqys5MD4mIaMgsmTCQwiZOiD2tOv/Q2Vdckhilyad5?=
 =?us-ascii?Q?FmM+ftT6kflFhuNn/z/6Zfqr5fCIpaT1jqxgjDz9pjkwgKWg2lYn3UlDV+P3?=
 =?us-ascii?Q?gT8vt8S9QMXjFXbt9fSEQVNwtafTPgaTQYxDCT9YLQD0bJtCeM88Ae4HYnp+?=
 =?us-ascii?Q?haJYQemdlvrI78lYBcK6WoRup1eXCWstaZEd66WojBCCHjKxqvGSxza/v9mc?=
 =?us-ascii?Q?iVIsGd0rZh4Oi4U8dEFOpxIScyexDICYq/lyI5o7WggrAeES6MAXkZYZwJnA?=
 =?us-ascii?Q?mwvagmWpQm+GHNA5meAoDQGE/iTHcXOv2pYP78yJJyvVC2G/0LP2yze+IzE/?=
 =?us-ascii?Q?OGKLtYrsD0EhRycXFb3PpnfSV95N185J/jU0izqRXkHSHxl4LcK9TPO92p8S?=
 =?us-ascii?Q?7hnWb82RaXAn9M+BL3HHqIrkRSicJnv9t36bfWaA8ALNLDMMGPVddbP8ueo4?=
 =?us-ascii?Q?oC/DBFvOKtrhotI96VKD5g0bekUAGOIfICxpAo6bWvQ1wOomDX13mbhZnX7U?=
 =?us-ascii?Q?tu5c1hbjfXXlK0UMCMOg4u5i50PzizM18fjVq0nHrFxqWz5C5Uc9y2eHVfEi?=
 =?us-ascii?Q?h7rW3ciio9aHfgLq1T8TRt6wrSrvJXvpPHEQdX2BMKXMcUAdQmfM07nEkwKV?=
 =?us-ascii?Q?q2qaM5FC+qCZm85hDHesL24u51J+IDjwMKRgYOtwHPxn/7kp+uHYUVkqOcKG?=
 =?us-ascii?Q?Te+55zEY9ICgiE+WQn1IJCUdVBo7n5R9vUQLkvTWJ82Bi1Xu/tO+nF2obXAS?=
 =?us-ascii?Q?9vQT0llS19PfQ1+4OBu/oKkVHftYts9joQnynv/z6o7GF6Yd0pKMlXCP3ZJP?=
 =?us-ascii?Q?M79ekXljXxb61BbM4ypEFCIhBJRxk5JDY7RGt03oDdZG9dDNNjvVrSAEvtPw?=
 =?us-ascii?Q?n/gzD5bhzAzp9YkHJP07I6hU9YKyPUX0UTHL5I6EJryxwf8oB7sbvVyJH1ck?=
 =?us-ascii?Q?hrwApC/vx6rphPsSI4/20WNahoHxsj4WDUW5dmJ0bTxDmpokzhSlzV6CBMzc?=
 =?us-ascii?Q?fESNAxDMpmcEZZ3Kj2ZPW/aoxut+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XjL0q70Ffg0y10VQZBnj4ahwg/4t8i9az6oviL3HQCd8Xy7QaW5zcLik0+UX?=
 =?us-ascii?Q?YbRqLHtfrXKYxrw0fXqjcuf+KTz3wPGwSj2dVE5TELvqVwf8aCLY6ErXBEEw?=
 =?us-ascii?Q?joLquiylwJmhO3zqBvQE4By6jbKdU6wxosxIzZ8jrrWdKXmpWKecN4R1aeFG?=
 =?us-ascii?Q?yIhKf6c3jrUPLw0sRrgS+LyfVYPmn1zY0rTaCS5Bd8o0iUg2Ddj0eEMcMmnY?=
 =?us-ascii?Q?7epFTsZUzvzvHOPHUUrdsOr/97/QHH8J6J29IVFPDSrkl5tvtB60rIUeR7cX?=
 =?us-ascii?Q?+lHnhkJXqq35WcwaXnTw+xOrdPxn2voJ+MdL38O+9a0ewZioYIhbWWBKFesA?=
 =?us-ascii?Q?EXgUBAVOHICM1POmfaOHXr89TX9K3ks8LwYilHmtlZ42uOIn98q7giTTPuXI?=
 =?us-ascii?Q?PgKwLdtat7gggBNC2uSXtJI4PDZbJVrnWGVT/QB8ARCwe2pYjFfwV8XFvTRT?=
 =?us-ascii?Q?6detUbo0+Xc8+IZgZJl0IolgKpa940GaUfkETFSYQUhgTkEo5lh/MBXlcFp2?=
 =?us-ascii?Q?kaGjJw2cWbhp5rrodd/Imr971xu4rxfpJML2cAY9YoVovNCWOJwmXfeyuQDi?=
 =?us-ascii?Q?xTagPpqAER39ISn+7bUMxTuVxZLSxxylq2gaR4OHhm50svFMFn4IeiZ0eAlB?=
 =?us-ascii?Q?qNgf6yo1vvOX+gEjjNzkWnVOjENcNphyzjH7XNFtynfOr0ynSek410QQd0Md?=
 =?us-ascii?Q?0WvAxbbPnq6EZSmdVUjq9TExYYTTuXCXrgzYCgaFnlwYBJFTKJvtDvKeVfp7?=
 =?us-ascii?Q?F7vYnxzEyXH4X+Im7kCopS5EK0mkfSkKjKv4siAwOp2XsTddDvi/AmGdxmZY?=
 =?us-ascii?Q?bpK0mOJBWS4ZtzTWQB7dAAEKJ4+PmXfU+CAmLAhw6gN2jopD+WPj8XtV1RFn?=
 =?us-ascii?Q?9NjlbSC4x3ofnE3BxliTDSPqsatULo4zevV9YeiszK3nvHaFL78Gy2iP0LAg?=
 =?us-ascii?Q?M0l8EdBCjTrlhZjQTs4f9oSnsPtDFgYvC1NS0LoV3707AJTmVEi7qyQoU03q?=
 =?us-ascii?Q?4PHJOWsLrPqKnzgqaDJnz7rzvDwLvWnX3qhDnXU/X9zqwGNytwQN8BFPXse0?=
 =?us-ascii?Q?0i1OjBaUYV8mCtIj2bne6nZJUgRUpn6CZkKHFx/pQLSoxvKzu5ek3i1bebX+?=
 =?us-ascii?Q?ZRH3d8URrKWXBDENLHViSG2RtrJSv6zX3wt7ygOnXXgtgeUlOx5GNH0LzA64?=
 =?us-ascii?Q?fwMJ6YMM41McwhydHs85Ia2BBdZ2sHMUD5keLHBhOIIyx/mq+YZWhtWpQWea?=
 =?us-ascii?Q?BrFdKkawbDkNz4N7y3+AP6ih156LYSjhCM6+VrGYJ1gSAbSwXx8SpH+1Z/yS?=
 =?us-ascii?Q?L90WmwGMdiRz89TbltpfvErFJj/XfJfEZrHe5V9WqVePOY06wx68Opf1UwK5?=
 =?us-ascii?Q?Ih/LKpf3m1TmJU2TKW02j96X6U06HGoUznLbuxsKPdHFtUcJaNBy23cPO3GP?=
 =?us-ascii?Q?3cbQUvZpWNyN5z9KdnFRoAvjO9k2hD5YnMe2kL9LIB4U+r5/aG8zT/lPjZTA?=
 =?us-ascii?Q?fZ3xLIATY3YWxN4JUHjebCKNKfb4q7kvyNde6zGvZCZrbOKSw0gnXfohbnwf?=
 =?us-ascii?Q?ToEnhAjkKVLGlV2KexPCAV7I/y9qCxy2BEOhZq1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca4f026-3ba4-42c7-4568-08dd4ab3db4e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:49.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iGTV3gjr7quYXr19QR6sX8bEsh928RTUtI0Y+f9ptywIL/6KKegLZW7l8qG3Aiw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 400dfe8a6e60..437d0cd13663 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3281,213 +3281,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list,
-		unsigned int new_order)
-{
-	struct page *head = &folio->page;
-	struct page *page_tail = head + tail;
-	/*
-	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
-	 * Don't pass it around before clear_compound_head().
-	 */
-	struct folio *new_folio = (struct folio *)page_tail;
-
-	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
-
-	/*
-	 * Clone page flags before unfreezing refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow flags change,
-	 * for example lock_page() which set PG_waiters.
-	 *
-	 * Note that for mapped sub-pages of an anonymous THP,
-	 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
-	 * the migration entry instead from where remap_page() will restore it.
-	 * We can still have PG_anon_exclusive set on effectively unmapped and
-	 * unreferenced sub-pages of an anonymous THP: we can simply drop
-	 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
-	 */
-	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
-	page_tail->flags |= (head->flags &
-			((1L << PG_referenced) |
-			 (1L << PG_swapbacked) |
-			 (1L << PG_swapcache) |
-			 (1L << PG_mlocked) |
-			 (1L << PG_uptodate) |
-			 (1L << PG_active) |
-			 (1L << PG_workingset) |
-			 (1L << PG_locked) |
-			 (1L << PG_unevictable) |
-#ifdef CONFIG_ARCH_USES_PG_ARCH_2
-			 (1L << PG_arch_2) |
-#endif
-#ifdef CONFIG_ARCH_USES_PG_ARCH_3
-			 (1L << PG_arch_3) |
-#endif
-			 (1L << PG_dirty) |
-			 LRU_GEN_MASK | LRU_REFS_MASK));
-
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
-	new_folio->mapping = folio->mapping;
-	new_folio->index = folio->index + tail;
-
-	/*
-	 * page->private should not be set in tail pages. Fix up and warn once
-	 * if private is unexpectedly set.
-	 */
-	if (unlikely(page_tail->private)) {
-		VM_WARN_ON_ONCE_PAGE(true, page_tail);
-		page_tail->private = 0;
-	}
-	if (folio_test_swapcache(folio))
-		new_folio->swap.val = folio->swap.val + tail;
-
-	/* Page flags must be visible before we make the page non-compound. */
-	smp_wmb();
-
-	/*
-	 * Clear PageTail before unfreezing page refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow put_page()
-	 * which needs correct compound_head().
-	 */
-	clear_compound_head(page_tail);
-	if (new_order) {
-		prep_compound_page(page_tail, new_order);
-		folio_set_large_rmappable(new_folio);
-	}
-
-	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail,
-		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
-			     folio_nr_pages(new_folio) : 0));
-
-	if (folio_test_young(folio))
-		folio_set_young(new_folio);
-	if (folio_test_idle(folio))
-		folio_set_idle(new_folio);
-
-	folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
-
-	/*
-	 * always add to the tail because some iterators expect new
-	 * pages to show after the currently processed elements - e.g.
-	 * migrate_pages
-	 */
-	lru_add_page_tail(folio, page_tail, lruvec, list);
-}
-
-static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned int new_order)
-{
-	struct folio *folio = page_folio(page);
-	struct page *head = &folio->page;
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	unsigned long offset = 0;
-	int i, nr_dropped = 0;
-	unsigned int new_nr = 1 << new_order;
-	int order = folio_order(folio);
-	unsigned int nr = 1 << order;
-
-	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, new_order);
-
-	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swap_cache_index(folio->swap);
-		swap_cache = swap_address_space(folio->swap);
-		xa_lock(&swap_cache->i_pages);
-	}
-
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
-
-	folio_clear_has_hwpoisoned(folio);
-
-	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
-		struct folio *tail;
-		__split_huge_page_tail(folio, i, lruvec, list, new_order);
-		tail = page_folio(head + i);
-		/* Some pages can be beyond EOF: drop them from page cache */
-		if (tail->index >= end) {
-			if (shmem_mapping(folio->mapping))
-				nr_dropped += new_nr;
-			else if (folio_test_clear_dirty(tail))
-				folio_account_cleaned(tail,
-					inode_to_wb(folio->mapping->host));
-			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
-		} else if (!folio_test_anon(folio)) {
-			__xa_store(&folio->mapping->i_pages, tail->index,
-					tail, 0);
-		} else if (swap_cache) {
-			__xa_store(&swap_cache->i_pages, offset + i,
-					tail, 0);
-		}
-	}
-
-	if (!new_order)
-		ClearPageCompound(head);
-	else {
-		struct folio *new_folio = (struct folio *)head;
-
-		folio_set_order(new_folio, new_order);
-	}
-	unlock_page_lruvec(lruvec);
-	/* Caller disabled irqs, so they are still disabled here */
-
-	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(folio, order, new_order);
-
-	/* See comment in __split_huge_page_tail() */
-	if (folio_test_anon(folio)) {
-		/* Additional pin to swap cache */
-		if (folio_test_swapcache(folio)) {
-			folio_ref_add(folio, 1 + new_nr);
-			xa_unlock(&swap_cache->i_pages);
-		} else {
-			folio_ref_inc(folio);
-		}
-	} else {
-		/* Additional pin to page cache */
-		folio_ref_add(folio, 1 + new_nr);
-		xa_unlock(&folio->mapping->i_pages);
-	}
-	local_irq_enable();
-
-	if (nr_dropped)
-		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
-
-	/*
-	 * set page to its compound_head when split to non order-0 pages, so
-	 * we can skip unlocking it below, since PG_locked is transferred to
-	 * the compound_head of the page and the caller will unlock it.
-	 */
-	if (new_order)
-		page = compound_head(page);
-
-	for (i = 0; i < nr; i += new_nr) {
-		struct page *subpage = head + i;
-		struct folio *new_folio = page_folio(subpage);
-		if (subpage == page)
-			continue;
-		folio_unlock(new_folio);
-
-		/*
-		 * Subpages may be freed if there wasn't any mapping
-		 * like if add_to_swap() is running on a lru page that
-		 * had its mapping zapped. And freeing these pages
-		 * requires taking the lru_lock so we do the put_page
-		 * of the tail pages after the split is complete.
-		 */
-		free_page_and_swap_cache(subpage);
-	}
-}
-
 /* Racy check whether the huge page can be split */
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
-- 
2.47.2


