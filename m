Return-Path: <linux-kselftest+bounces-24681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F3A143CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC97167EAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ABB242274;
	Thu, 16 Jan 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxpHvIUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0E24225A;
	Thu, 16 Jan 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061866; cv=fail; b=JxEAbdDv8+Z429rY6fGwffPxPQ57QPb3+OpDkmt2nL/1Ite5zYSLxg5REVVnks+V0A6B31ljQ4akjftrpBThhXCw5KXuLj7rtrpBcmgZrghFdbxu5EYoNJ0zkIdN09o5oW5qofvCtDGa1juUnPRKpHIfRDr3W/KrppxHlJrbjA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061866; c=relaxed/simple;
	bh=c6nSlzVzli4DPdceVwuuMMiI86KWcDFiYsCFn44hdkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umtfxU7GpOjUlHcSf2U5MYFfKP763+L735PksT3qDdhpEvoxeG/C2YqpOkkxsaqL5g2trW6y+etZug5E69X5S+EsYJHLym1qLx23Z8LDg4EiJj4ClfY8zkw6OXr4r2JXg5AWk6YDOI6Eg3afM8cdPbq2nn5okW3nnhCKc32jJMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxpHvIUu; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD8kVHZ4htzMejmWUL9H9ybI3yveJSBtYqx+Q03CKv2TLr83nqGds89exMQ4pTN37K3OjRQqXe6sNpaKABfMBAq43QskKCa8daFMeiJfcTslTp4TzHKQrkSO5GbP7qTa7SXdjHGy2cmQd1hXcFHvEWemnzT1gtV4XcobUHROx8M082HnvelPf1gUOyiGlLvLX/+zfWRJER3gzkTuIRxFTfpf27v6tQwKRKgzVnntYL6lNHrIxN+T1En9Ovpb3NZq3NQC8BtcE5bmoabteb/xMO2yIDT3TTX7LrdbIo22/dxvewyKGFzALq5UalVw6TjNYa2RtSYqUBHnztqjpbOkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pPFUg6rNWV6UdEno3cFBDu9+zQhqBh8bUtDTehyLM8=;
 b=TZZTQ/4ROV6giNL2SpIlZFOpocWJEogIMiLZ1TDLjJZSL7FR52ebWxZWXTYZTjSZ0OTnTLuMxKb1NobXhEORpw3CjdCpoqx6FQOh/3I3ZdFHohTZf3Si+FLY0BdyQI0a1sk0JwMwkUbnuEFh5L5994Qzv3qR5Q7JtcEiuSiG+QZHYZZsJwF5RaJERXH9vQWsKy3HSo+WmLK1VddxHHwepNsP0LtKvNhSf0lPgjM5eU33AGS92xtXNMvm+kPj9NbqPEz/hdmoYq3ybt7+mRgysWQJHjRvpjrSyxW3sKHQRI/JnDXW+HOf5RINkbXsQehffYD7o++eGTuD8+xPzH+3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pPFUg6rNWV6UdEno3cFBDu9+zQhqBh8bUtDTehyLM8=;
 b=GxpHvIUukfz31nxX7Q8XuBC1yvAqDueKZOqbZqKoVCJ5vREWclxiwmV47Rg609q/i5Lqn4TFJPo6aEOJSChQJ832MKAbX9qEtFWcbabaKJ5msnOSwPBcP2+0fBVEsNxyuLMeVKVIOp2Rik339rKksg5CH+ebVUmaL35QiFr+7oFy1vrupjCMY7YZaD3Y2umZ7GHBeCUlLO/XqhQuj6z/Cdpr5Pk8OYzWBHotQhyRk05Ahr+1/gOcXHV3v77Ef/NeGuxgego6iWvMbWO6kj9hfViQbHgzCT7JZnR4N9TsFLwcw2ocFRLidj1fbuwtJQ3QaNHRAJ57axowGe383er2YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:10:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:10:58 +0000
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
Subject: [PATCH v5 05/10] mm/huge_memory: move folio split common code to __folio_split()
Date: Thu, 16 Jan 2025 16:10:37 -0500
Message-ID: <20250116211042.741543-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:408:ee::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a53e528-d0e3-4056-e7a5-08dd36724607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9z4k0xAT+YKR52S7SYg4w5vW0C53hnj5KNtpitxNIF5wfqQvOhqbNtahpmlT?=
 =?us-ascii?Q?xo9PWyvNuXWN/bl28OEmy23Ej0uKjM08j0d8ZEwgixEc8O8dMVOg8qTYBlPT?=
 =?us-ascii?Q?nV9CUltc7xDD0ZxCLjGEhP3vZMN5iPljBMZ/vf6FbQPWm/wcUQKx0PqMsaAP?=
 =?us-ascii?Q?M/NQVdYDyP+8sd7zTVOel0L1NoW7P5LNQZIpvgpn6lkMVk/HR5Pwov8hXT/v?=
 =?us-ascii?Q?1eanq2xHF8/7sZaKfLSSWO4LMYnPolz+SDbR+nLZgyP1vXr+uEJUgEFbvr49?=
 =?us-ascii?Q?kFvJyupvM5tIhKejZehDtQ55BolI/QLnwmALnD4VjyqG1syJ66EmES++nAE5?=
 =?us-ascii?Q?XmTxuQr7tZ0Fli+YxMLNNhU7tCPI8jekOTh3clmeqXY9dWTrrZA9tkCr3Igj?=
 =?us-ascii?Q?EXRZtcwfPZXdRmcQ48ljewDbwJlRfjmXKjr08LZnf1fLKL+VaIY6Gg/dAZ5B?=
 =?us-ascii?Q?9zw3hYh5I2bHQ6PsyvHTJgxNGAIERVbkPYLFJmeWoFJWal7vrHMJVT2n3t4u?=
 =?us-ascii?Q?oYVaJmOPWwpCUGTNI41AFemQ88HLDv8WcBjqe5On9eUfUeiZQXuu9tyWZ5Ou?=
 =?us-ascii?Q?zJ0XFufMag9JPGXXDWkQdvprJ/9Ct6rO11FT4iD40RBhqLtxQ6fzyoa0fHNn?=
 =?us-ascii?Q?iRVPmDIPEUy709ZpG/dOaBBd9t4uKOjJklIEmwEhdAg/B68duW+kO2bMuVfi?=
 =?us-ascii?Q?LWUJEGh4zlCRhVrpzLaWhYp4Z89Pxu2qPPQsjsUd9HURVirbEKxh23Bmgjtu?=
 =?us-ascii?Q?D8Q8OTMJZpuwqJrAg3evFR8f1gO7iBFVzxX/dueY4sg1gg2wMY3/2r07Sm8H?=
 =?us-ascii?Q?R3B/UqFLbqUqLFnICxJElKfT9kPUS0nVwXtOHdFWD2/VngtjCiYJzi7c+4QH?=
 =?us-ascii?Q?MqzrBOXuVhHCo5ndyDmPG3YI7U0tanv6cjdXAGMdgVyDfrW2nZzQ/cTw7Y+E?=
 =?us-ascii?Q?88bzOroluKz9ELw60M+ueqIeBVfSkFwDNKiGd3T8dyU365deAYp+cVYaUbz/?=
 =?us-ascii?Q?rrB2pIoktmFXDAwxP+UtJu/kQFJmJIPaq8M166LnyUPkUQKz7al+ZJxSXYiE?=
 =?us-ascii?Q?rBqHUEE9SiRx6EKl10ML7j4BD6nwH0s453u+9AlhzVEUIWf6WylASKVy5hHM?=
 =?us-ascii?Q?kzvc10SUyNhRxYvQA2PYIqYLCxkBSuqNVdELJMvfc4YAQmrxNWv9dhSJVxuG?=
 =?us-ascii?Q?gqDj3DvjH9OTHR0E2of9+RecmnDUmE0IdjeqapIEi9zUktLsDnku+pu5UeZm?=
 =?us-ascii?Q?AX06Zhb7VyGH8M0JdjN8o1CGbrby/XJFTklN2YFVKkz0jvHXRq0AItR5A8yR?=
 =?us-ascii?Q?eQp/uFbbLZ/BQvze+YfC2DVtm/4rDbexpSWy6Qkp77kpoOaEBtKl2dB8M68i?=
 =?us-ascii?Q?LSfUqgUo9bRLOHKGeWL6fFd3J3wT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ME+dIDvH7UfmRFe0GjEVjq7FHSTha1DiKrqjV8Eu5ATZbrveLtHbETV1waaM?=
 =?us-ascii?Q?EE8OrJ/NxzQYvzCH3CYmfvIxrx1j2bwvjpoBZ/8zGqLa2K/W7KjGZz+OxJCU?=
 =?us-ascii?Q?1CaQKzYkS6afpTK176Q7Hq5PpSq4ZLc0deSbCD675Fv75aheBdIjhv8I21fR?=
 =?us-ascii?Q?4QcfvviWh50FMrKz3V8X7EjWvDLrSjYzu8YHBuaTyYz5HdMH1HzFRL+92+aY?=
 =?us-ascii?Q?VIGBLxqiiF54ZfG5u2qcdyC0U2VxnBSZX1YU5b9kar4rBqgj18f3VBhwBmzG?=
 =?us-ascii?Q?DseHUG9uwdkJRRToMuuVbI/cineUu6joS+LkvUnM/j0XT6yT10SqVSfT2m28?=
 =?us-ascii?Q?SvDnY/3tm6dPvd42PheT7gmjMSfXRYlpYGeWgUXJv6ccaQn3BmEEZxk+tF3f?=
 =?us-ascii?Q?WtN+Q5itJ2/W/lST9rbZE3xRAvy1LoMuCYj0GXVihICbTpkaITT5dZTQ1E4C?=
 =?us-ascii?Q?UdJd/29cF4qLllg7O2Ln8XG8LZGJz3F/u2LCqRr79lR2OjuNg2/oLrfKah3w?=
 =?us-ascii?Q?rZ4QK4kAvoGKeLTJ5bE2HhddexVc/NS78gkNOdV78wnR/7F5e2m3xukq4YP4?=
 =?us-ascii?Q?UIKWOI8w3FJZXfc9GyLzWFbrzvzT2JTnqj+POVo8IcBFyscSGnSNxinFshSu?=
 =?us-ascii?Q?cBQh0QzTeWTkeOjV08/+wEInvyqW9Nh9Ur4CODCKGZGnRlJ0U67H97wkvThA?=
 =?us-ascii?Q?a+jYL6ZGeFK0Y5qgMJJbwuGDo4jpcsYVMilF3lFwF3wYGvrCqVuDtqy6reZE?=
 =?us-ascii?Q?2I4QV+sEVA7JyBOt5cqhOQKs2gM6K8YDZAwd/BJtoPAcfuJX0RfH6tBmZ43H?=
 =?us-ascii?Q?wUl6jz/uPrQFkqItJ1Mk1ioL1OkXrAQzRsL9LV//evSU3j8bCuxT8KKcEHsq?=
 =?us-ascii?Q?5NYcp5IdtjDV0SUXh/cyrozLL/amT2WJx4Zmsdo+w3YVKHeLmlgmb4lgb4Ar?=
 =?us-ascii?Q?VONJEmn9i2kSej1VrYir2NmIUNMwcZBw7GRgs+Qv8gvEpUsVRreo27FpPGm9?=
 =?us-ascii?Q?dPyGZK1mByaTNyU7SzPjAGQaLZu9BHDamRsmLb+o8gM5Vxi7mEhZ1v+XS8QE?=
 =?us-ascii?Q?ZuB/8T5mpffqXtDuK13i29m/tJIuwNCIqmeKofh/M7V+981CMmrLrTbnKeQ8?=
 =?us-ascii?Q?paLgK4jqn3F0pMyxgvgjjYs6HEyL6drX6qfH7euZqUzOr/9U4v8MFsghfxZy?=
 =?us-ascii?Q?5vG6PMl6wM9gwIJ1SwxuGhWTsAw39/TgOaTgjA66vbZjAj227JQzN5M0YqfK?=
 =?us-ascii?Q?+pAP3IyAZXe/+3zlMAKuC6fNMwwFszMc1o/IMDU0NKtCKIAV3FQbocC52Ai0?=
 =?us-ascii?Q?Ed1sjwwZ0aADHcwFlURRrE9MdKoALidLnjBlzeSjBOv7uZLpzhwSxuHeUa7c?=
 =?us-ascii?Q?ZwoDHa7A2r3gQ8FxAx97s4ZRDiMU87nDjCXgNvVMRnmocd0bF1WfyLRJBI+q?=
 =?us-ascii?Q?kcACqfHaOHZQS2hIcCFM7JdnJS7cvLBkq6ddOn372XebXkrmIAp3J/v+WB0R?=
 =?us-ascii?Q?OeZ2ErjoEl9BghHsTT1X5aJcKX5Xc2Mfzb8f4c5kFsRJpVVnCMqO2roPV0FH?=
 =?us-ascii?Q?AE32kdy078HG8nQ8hwhLjmmxURD0xN5qhCoWHyig?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a53e528-d0e3-4056-e7a5-08dd36724607
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:58.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A8AGZIE9xTmQyq7q14YpO3i9WPQ8B5Oe5Fvy04vKOixePE+FrkgDRvF2WTE08hn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c98a373babbb..6c0089a0bcdb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3738,57 +3738,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-/*
- * This function splits a large folio into smaller folios of order @new_order.
- * @page can point to any page of the large folio to split. The split operation
- * does not change the position of @page.
- *
- * Prerequisites:
- *
- * 1) The caller must hold a reference on the @page's owning folio, also known
- *    as the large folio.
- *
- * 2) The large folio must be locked.
- *
- * 3) The folio must not be pinned. Any unexpected folio references, including
- *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EAGAIN.
- *
- * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
- *    supported for non-file-backed folios, because folio->_deferred_list, which
- *    is used by partially mapped folios, is stored in subpage 2, but an order-1
- *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
- *    since they do not use _deferred_list.
- *
- * After splitting, the caller's folio reference will be transferred to @page,
- * resulting in a raised refcount of @page after this call. The other pages may
- * be freed if they are not mapped.
- *
- * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
- *
- * Pages in @new_order will inherit the mapping, flags, and so on from the
- * huge page.
- *
- * Returns 0 if the huge page was split successfully.
- *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
- * the folio was concurrently removed from the page cache.
- *
- * Returns -EBUSY when trying to split the huge zeropage, if the folio is
- * under writeback, if fs-specific folio metadata cannot currently be
- * released, or if some unexpected race happened (e.g., anon VMA disappeared,
- * truncation).
- *
- * Callers should ensure that the order respects the address space mapping
- * min-order if one is set for non-anonymous folios.
- *
- * Returns -EINVAL when trying to split to an order that is incompatible
- * with the folio. Splitting to order 0 is compatible with all folios.
- */
-int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order)
+static int __folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
@@ -3998,6 +3950,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+/*
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
+ *
+ * Prerequisites:
+ *
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EAGAIN.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
+ *
+ * Returns 0 if the huge page was split successfully.
+ *
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
+ */
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+
+	return __folio_split(folio, new_order, page, list);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
-- 
2.45.2


