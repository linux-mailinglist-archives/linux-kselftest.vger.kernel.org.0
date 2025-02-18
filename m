Return-Path: <linux-kselftest+bounces-26916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D263A3ACD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0888D3A7522
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E941DED4C;
	Tue, 18 Feb 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kXd13dd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CED1DE8A2;
	Tue, 18 Feb 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922634; cv=fail; b=OLPVHkRg5NyNwcMnXnuTGs5T3gKuTI/avcrlLeYtZ04txAIRyreIpkGYijydiqUpqARdxVRf3uqk0suJ103Cu4ML5zkOgDo0UxtfWXT/fLGaRZf46Aph+u+NxM7b537AZ0875SBw+7FlZoi/VjhKFU4eisd39G1gQ5aa69y/foU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922634; c=relaxed/simple;
	bh=aXQg98Yg7uCl7MwqDC6yhbMrj0DaXag6QSmnECCARB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNcn7BtQwaJIAMAZUop7Xg571H+DSpLn8KxkjaPcr5XwZq1NKQYW7pcBxWy4VAsV4o+cMQZXSKFT72wRRKLqBMflHw1T3OcZLr0vSysO4Bi7fSoBF8dGrMA5iAgXOfjoLP/VK/quY0VmVgcHcRO8GBEOPXFiyQC5WDGc1u1LiB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kXd13dd8; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmln+RSMiJ97Qzi0JP+VlFeBLdhivcRK1LbhtCdOSkyp4qmH0YfK0kqdMshQLpXB81Mqo4SbsL4jQ7jI/+/kRt/INsiGVPbECmEYKc76N+tU+ZIQU/HnnYS50XlDqFfHlMYN15TP3bosD4eJQLV2wHZRjZceA9FIwQm2lT66NS3/KpjRpoz2mRKRTAOykdq/Gs/5eBtPBP5lq4SIg1HSBIZhc9CTZbhtQsCh+kbE9N1vBl/ASHLO5FKypHuKyTMHhr6Fy2kOh9+4mKLesSvwjboXDKnB/Wk7h6wl+8hKPWuL1zL6njLYbJMnEyTppmT/rI/rVGcXitTs6GqDM00wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LodQMgwtSalEnTvSN1UxhYrt3Qo5c8mY43vKRMlOiT8=;
 b=LxDtnwzpqd+0WgWR50DKzujRAIa7JFUndhTd0z1Aaq36ZBFSmDeuWjCzWkDYS6XJtcXe2pnj1+8IV/bBqc2c85YNEB4SnRdm1HNvlNEiqOsIuxo7Px55GnFFCWMLRGcV47Is9f2zhoPu67qowUHNvNw/7qu8eXo4PYNZ4jsvpnxS/9OSvZxttFy47IjPvsliL3SB5APKaKPMm17qfPobwtSV24Qporq4CrUplYynRU/B1kxh1bIgsxGhNlpd+4i3485kAAvhKRA4ywgKwPTtc41vojbvONIgDxO1db1mvAXSJCyOC8fXaE0XMrGeTCKivkN+Tfq3MjXUHoJNXhSvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LodQMgwtSalEnTvSN1UxhYrt3Qo5c8mY43vKRMlOiT8=;
 b=kXd13dd8PASUxxS861j2Znsg0WDfyX78547DAKythzLbrDg7SfzKI+eFkxMCbWigeej3oGX6X/A3up4iBHXjO8FTnYD71Tk/OSxhkyCrrZHS+a+Ap/mWxE035e670iwusnKuaZp525U545kHaQKyTVRwPXfOTrlWKjgMrrMIkW+MyWWqRCw+9kQVdxKoZGVC27AazdT+PyKDZRmt3t1cte2qbqnjeYpgPxc117gSWVIaYZ0b1yzrkVH6xpRqmAoWkZ4dNQ9XFJRT5Ie/NftcB01wpGXj/t2NORf6NSEF14erQqZQKYrpjkUWRRNeDnit7eRwZiFl+HJ0Plnged9OCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:23 +0000
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
Subject: [PATCH v8 5/8] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Tue, 18 Feb 2025 18:50:09 -0500
Message-ID: <20250218235012.1542225-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: ac130c2c-49b5-421f-c33c-08dd507702da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9AtyS0jtKXF+hivYgE2uAIrY6XGSIdBDhrJoG9mvQg0XOxp1jFkkpCoOqYY?=
 =?us-ascii?Q?5Stu+EdVPesvGy8FR+I0H+AppwBWdZlAG5WP2fr5j52+7B0PBMNiI/4cSh9J?=
 =?us-ascii?Q?ys5SwezGPQkJ06fPrMT4kSJVnLOY15+Cbf0uNQVzXY0Nyg+fEK0ASx8MvzUs?=
 =?us-ascii?Q?RMZdTAB2dm7up53ETcSrdQOP5+eSLkvTliT2yBBtX13ANt1B2MXeebNyIjl4?=
 =?us-ascii?Q?MuoeCr8M8U6ZHwwmG9sVUemtHNYSgsCfwptEc378A9BNatbE0LbR4/5YPrjg?=
 =?us-ascii?Q?1Nl82Z0BwED2vubMUAQrcyZQIwbAnXtDYtfSpFzHYFnbQZdNZC1iJHxkAlQE?=
 =?us-ascii?Q?ilzWbwD59KVGwTaSjCkgMBcOeSdA7OdtCPVlNZgpd+Os+ALqx9Tu3j22rbwf?=
 =?us-ascii?Q?pSNjrY673cfWIIfkAAZa1nGW8KU8vurySFkwTiAbyc4U5/Jn0Fv2E4nNSDjv?=
 =?us-ascii?Q?S88NP3dzCTzEHbBnKBZdOMRqY7TuXZH5BSR6GNSea+5KjHXqbudPL5s/Ldt8?=
 =?us-ascii?Q?+ghZVYL9pqvl6xI+yBEOsXskeHslzac7bKBhAZ9wuiAjBzsuKt/DsxAGakfd?=
 =?us-ascii?Q?DyvL/UvRbo6ZO4HFFRU59DlsZygWmGmcTKdVsRy81v+PR4zMixPbppC1PelS?=
 =?us-ascii?Q?RCI8m9oyF80MqExv1EZ7EzcHob6GxUx2VxkwTvi5CuB7PonW7wJFFYBJjeUl?=
 =?us-ascii?Q?r4onADL8LKz0b0y1XQVyYY65wXp19gmfIpX3UJihUsvCUdzSsVXXKCVYpLvw?=
 =?us-ascii?Q?ZUSp1EasAIO6EnO2BF847/Z6X9Ms0+ix44SrvH50vh5gg3IHBNqWLM46zjBu?=
 =?us-ascii?Q?901/WqNhMcdWanY3QM3MQdbs4g6lv0HxbMompHhjPt2ddSw/6SNBE41ksf5K?=
 =?us-ascii?Q?hpM3BDWeecYnnTg0RLNKTexd/NOFwXehMSh9UHhCVyP0lbDPZ13L33qFwNrO?=
 =?us-ascii?Q?7bYV0ud7lIF6HpFKiMQoHOFZUTLNzITb9mvizCrV512TsOsUpiL8NvmaSSZA?=
 =?us-ascii?Q?3NGccyrK8eVed5ujZiUrRZVwtNryW7rVeGF9RThFgzNw9/6KTDe/gVaf31d1?=
 =?us-ascii?Q?NFiojwNm3cK5iarj39EDkbt7gL8TJWJ284+Lzi9x9/2evJtxT9vbFaZznv8s?=
 =?us-ascii?Q?Wf5aKnEDb65go+aoV9PuDVZAqYn6kNdUZ/ewGr3QfijzZxShFC8oYt41myYn?=
 =?us-ascii?Q?XdQDrou8brg0uSX9yYX9Pd2QMFEyOU7CTGGnzTuXT0uPnls/k2CLLrNteMoK?=
 =?us-ascii?Q?iofozCRZxl6M0+eBGdWVDo2sGhl4SAGc77mSgpgeSKJgB/o52b+flCQ8Q2Ma?=
 =?us-ascii?Q?qKE8Q4f4ZfR8aZaOeG/T+IfvHeIExwe/xLp5Rt/ACLFHKdmtnPsksOciju/k?=
 =?us-ascii?Q?CK4ddmT2K1f/DaCtTbKAKOZ7tnRA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HEquv/rUQDLpwbGocHAmkrpHMbcc11qeWvaGP/tH2tL3CX/PekKBA1APEKQ7?=
 =?us-ascii?Q?7qARLcZafPXzKKjZcLh9dVvvyw+STqCpbroL1Ks7JSIDm+UEFvguvD4TBS+C?=
 =?us-ascii?Q?nr6lrNV9EsUobBWLYX9p6Y/bbnla82Ext7Q2r3CgV+49QW9cXUiWlixwmGSH?=
 =?us-ascii?Q?UZaN9WkCx9cPIoiiwG7UgzuXlnmUO9SvUw2dVBVRfImzMsJWFfo8bSkVw3b8?=
 =?us-ascii?Q?n1ooV58+5GWj5yJdEyHCKSEY7BXkVurIYc92oXPx5YSl/nqyfvSAsj8i4LXt?=
 =?us-ascii?Q?Le6zVBGIUuO6msNiwyi6CeuitYjyAZ02KOqQpB9pXSlRp6btpHFeU4KLai+b?=
 =?us-ascii?Q?NvJfa4sKqo5ozTuukr77vjXn6Gzw62oUrd5O4WOJl0Pgk3VeUSU7VXZjzIZ5?=
 =?us-ascii?Q?OxmFKFWJnIAHltJ4HXn7mCbl1VAeXI9zXNYqQac4vMantJsAMBWqEPKs5+TG?=
 =?us-ascii?Q?h+0PkHVxzX3YYCgQoX5Z0VaqihEJSsobInodTldoMQtW8IhMFAbTYLPkwI6D?=
 =?us-ascii?Q?d+hpLOv/ZdsEG4pfLLfdMPAGGLNj3oh+qfJf3UsiUnWghT2gHcD+QpWBRDdX?=
 =?us-ascii?Q?xeNrxenqUpYVubhi1+yzvdDgHtjFvsIP85wSBwzXdz+XwuNo4qRLzKqlpMHZ?=
 =?us-ascii?Q?GJQUyVDMwuPRjBem8HxogkLARgmhb1/hq5FD+Dsn1sV6Lr542jwEKVm+3q1P?=
 =?us-ascii?Q?yp+EDq/+4xQee3c2XK/JgfnIJfhy1iO0gjW1pNN3OtUOI1dqA4spTNcbRs4a?=
 =?us-ascii?Q?zUIEfT/g/mUXYoEL1BUaKro4/bEgEzXqGV/7KpVkkVixdYX92+ADpR1gErtU?=
 =?us-ascii?Q?2sczt1TCq7ULlI/JmTZBpZghX2y9/Mg9B+RWU/0tAt40/QSY5pHlrhHalzXl?=
 =?us-ascii?Q?dx6ukoC8+3EE9aWY2dMoGAAG2szqbbMdL+7RKFkoWXLoXkk37xHmezZIq6qn?=
 =?us-ascii?Q?gBF5UyuEPfT0N8I4FGSK3F4ZIpFyG9XZ6UO9K4Zs9gQG692m0SrFz35sfZ8K?=
 =?us-ascii?Q?c1Vl/Te0iUkYjm/A5cE8FyqIjKIQjk9PeHzpRw1tC2WhoWZo1RVsZiwsBUXI?=
 =?us-ascii?Q?Ihcrda6D8l4tZHVCVmV+H0wQmQm0JS/4aYNIGTL1/Kb6sGpAVKd0Rbjw1EOh?=
 =?us-ascii?Q?lzybEDj7lEiTLEpLE5GHgMLnfJsP/oSQRECzLEmX3Ng6k2lzOK6uirnnVkw8?=
 =?us-ascii?Q?HefY4CJC1Mb+K28uwbBQ/PLko048jXOOKb8PZlKhz4ErGt8c4QtANF/HTeqa?=
 =?us-ascii?Q?lDVXasDzLAzUGKDbmqivvJ15B0iKrrXN454I8WW6TcCXbqQ1k9xEm9rV66FE?=
 =?us-ascii?Q?7KeHSM0n2LBikeMH5NpKr+Jq74oRraxUpuYQs5p86stsyKsB+QYuR+ofd+Dj?=
 =?us-ascii?Q?XRouISKtsiCqhVKsKOseS9SNb2g0GvKMstLJcAdAKRYk4+kVvC6Caf10nHbF?=
 =?us-ascii?Q?22tZnzN1i5beLAI/FBAMHv200QrJ1/esfVdIKNyzrMbPT21xZdusfN2iTv7x?=
 =?us-ascii?Q?g3ia7v50kJUnyWiAxzEeAffKtiIHTF1r+CRQmJHpaa2KoS2RcvlwvRfO79FE?=
 =?us-ascii?Q?a/oUWz2vh0VwIablfVFjtVMb2c1B3XaXEZWi8OXx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac130c2c-49b5-421f-c33c-08dd507702da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:23.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNrnACCPBjFZJXYSKfBQiITUWmNAtRt4RZwPRdJDkSZfDMPnhyr+YIh8H5PUhR5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

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
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2880dd010bff..ab9fef680a9d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3168,213 +3168,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
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


