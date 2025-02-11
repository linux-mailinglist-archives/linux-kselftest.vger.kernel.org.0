Return-Path: <linux-kselftest+bounces-26378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E000A31031
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01F9164240
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C8253B77;
	Tue, 11 Feb 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJS2BKsI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75676253B55;
	Tue, 11 Feb 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289046; cv=fail; b=mUpHbIY+Nc64e8SFqHmM7nQMDc/zNdL+bWEAWG2EQ1lKCxoSy8j9ldX7pfZ21qncL7DkFAwd8uoNNIiUQW6rOTodtUfCYvlzbiz2efl7JwFMLhNvQTSiP6gC0uOO8HZg3qlVuLNeAb6x2+B8bJVEjF4PHy2jwXlqIAyOeiuAtYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289046; c=relaxed/simple;
	bh=YLyBOVe4N6xxcWpAxHdTLmcENzkUy0IJkhDaAd7hBIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXvo8HUwlSKkkRr1hgGQwB0lMbBN7qOgFB2QZcFSEii2peEITijBKbttXHnGJ8/JRig5aIWS2XWZQLr2HuX7qHVy62JxXdHwSZKOclneimhLkm24K4XA1nY43cqTS1FVlHEIJ5ut/hvU7xR7CJ984rhwYyhu4l619cDJeDij52U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJS2BKsI; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e85rXBpQwTuNN1uH/tfIyvImLiq7WJ+Z7Fm9+vQ3BGfq7xPP6TmznVdAk1YAa5d6+muns9khRf/5z56+WZ1qDH70Dbims+MvQe51JQwWvx/OewAJ4OOOth1x3TUDUrwb8nImToKyLnB7Nusl0GZ0xGGVPqTnIe5Xp3efhlChaLjUhB3SkJpI+KioaqXr2Sa7U78BealBCL8/E4HmkX+G5fSe2oKbwt1H7ldZPf0OyOEiuST7ig45Sqe+rvqql+YHaa+vggfHHxGFzJTZljWIR3Arqwr32zqEbzAHdHlroYSOaPzkMRoe/g1VFHFWUB0yRepIxU5t1PJLsU2hHs0CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7hiBgKwRc2VJ6pMqFn9oDn1+auAcnWER8ysmKbSf3A=;
 b=KtqlfQF8ZvJ0ZLouvpS5YzqlqnK24XwScOs8z75IvfxhC+lc0TtFiRvCS1xRrFif6tMJKlvgoUsvFgvi0xZzrDGoqGXwwFR2xa47VNWXJ6/Lg0oe6Fa5QBu4qFx8gWBfH0qDJVLV3RN0ORcNgrOktY9ASD15CPIkjQJP/eqtuBc6+/GjFhBD1VOMFMVmznxvNGeQ6bvPj+J2lTtjUkGbxfTHCX7ILyLONv04Q7De3uAKscwZuZBvrYMlNCAEIEZq1AiPM/7sWRm0FaNguxmbn82tNxEt9rwEmepUmc6xalCTg5KJX5HxDEku+oHsgwk1NHPrwdQsbQr1C6sQ23votQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7hiBgKwRc2VJ6pMqFn9oDn1+auAcnWER8ysmKbSf3A=;
 b=AJS2BKsIA4rLdf4uzRqwizG3imX5egUanjDj4sD+FP9nCChgAprA/lm0PAy/dYofeCoNAk2ETWdd2ROos3WjtRpiqYbcVCJQY3CR8OJHe+DxBIY0VlEGxw0+14RrKduKosPZTQa61ZrgJrExnumV7wSYa4IXMk0Ga/NbIzz5nPBHfjAINOW9q0rrktDec4CWy5VxPUg+5oHmJljNaEQ0UauCsK7A6mP7vWF4S0+vv0vKBp+Ht456TuumypYd6Remj56bIucq+IqLB6WNjn9L/CS/5SvZfL+Vv8DAsd9WL660rcsOu1Nj08PONwuaWv4lRjgvgT4/f3rc9YxAp6p6wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:38 +0000
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
Subject: [PATCH v7 1/8] xarray: add xas_try_split() to split a multi-index entry.
Date: Tue, 11 Feb 2025 10:50:26 -0500
Message-ID: <20250211155034.268962-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:52d::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d34a885-06c1-4a45-c841-08dd4ab3d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u+/9Hj0dOYZmS5IKqqu+OmKrW2ETxVJC0B02vAKCakAY/NxKz4LNsnJjDDB2?=
 =?us-ascii?Q?5GngY06HRk8CY03jCVPFnLB45cRp999Jihh3IIAo+/y1ilcjL/CRNyiAhPvr?=
 =?us-ascii?Q?Ij2tLqj3k4Wdxg9HxtE1xmWMAOuhRXIu+3g2/yJG5qfb34zEuM2LzTTXVNUN?=
 =?us-ascii?Q?N43gSQMBoza5yLQxplpUTPO//Nu/vFuXxTCe9UGJdyiUr7GSRVeois4izAXP?=
 =?us-ascii?Q?tUxXrGRvZ0Z6mkz3f3aAb1kF9kvQDjVAsZa6xluX5cSVkH3Ml4rWo+Z9/yja?=
 =?us-ascii?Q?YYTD3eAxgoE+C0F5AG7AtjV+tPqMnSTASfHYXtLSaRCAyHvrmtch0Jh8eg6R?=
 =?us-ascii?Q?oUdVoi10RyWM0h1caqCYu2KSe18PWZaxNVAJ8MKZOw+T2eblorTKeKyYyD03?=
 =?us-ascii?Q?MkDl1qA6Ig8oIMyHeIq/3hPnMq05kkhOan1E+MhpCcfsXj1daX339L19VW5v?=
 =?us-ascii?Q?0IcByaMqei5lsC+94XFwVvaD0f7PjJf74WZ4F5PS6ySzzS8C0iOl8ohmI13d?=
 =?us-ascii?Q?+3sBD6hIwbCyHc6FxCElTy4yyG5Limqea00/tcvoyBV8diC2O8osiQNohXxL?=
 =?us-ascii?Q?+VXmI7N0gIr9O+EJdeL3t7sijDe6GfqIW94hxueQRmcOBYuP+iAUbHotAnQh?=
 =?us-ascii?Q?Qb0ucL9qhtBmvtEqOEqk60G7MZnWPiCzApgWcoEl9aiUQ1/qkzTfaSg6++lE?=
 =?us-ascii?Q?/1g+C/qpSQNNeawN0AVwFNkQuF1BafrHEfzO+KVCty1jpNE6ac9ih0sY5KEk?=
 =?us-ascii?Q?IXMzq8lK8OrpCStqFjxKQRzaFvNuj4frhggUwh+bUctrefM3R3TzQNs/RmcV?=
 =?us-ascii?Q?MMJZY8MA6ufCeodiBK6AWLZYrbs1t0Wwwa2M09wwsNnOsua0QXsc3ON1YdO+?=
 =?us-ascii?Q?BPEZa7jyOLALDkDoFyAzju416LLoch6f4WCc2CwsS7Ss+l04iJWuIYRQllcm?=
 =?us-ascii?Q?SfSbL1+KmFdl2q1cNgFiI/HIADMU+oOLcLPAEo36cR1wVkDJGBDQ5Zt0qxHg?=
 =?us-ascii?Q?cDAUeD+ZCNLxZQ4xOtSwLl8YPcKAWMAik6x/vrMorh3BQ8PvyYhR/0xruqxL?=
 =?us-ascii?Q?umeA+IjKX2NZA1a0iEmjkH3I1w2OMeQxotk++yO3O8wNHtisWopi9o+Pcrf9?=
 =?us-ascii?Q?HS+x11o6VOAh9rphNqKK21/q1WJxvngD95P8FVDYZGNPkIx8NQi5clxWoAqQ?=
 =?us-ascii?Q?+fIUirH3ln3XbZ62BBbbGMaXcTihLJdQKuQnvuuzgl4Gr03YoU964HvnMdCR?=
 =?us-ascii?Q?mnd4mbdy0GFmCEzHqiFki2r8a+eJu0h5ahimwU0osDh3rI5Ld0xNK+tUbisn?=
 =?us-ascii?Q?RmUI+GKrDs0S7DeufNS6yrFukyTAvJSgXc7prHffBbyitD4T3beBwKgjhFXw?=
 =?us-ascii?Q?EfsL7x7UNfflRv15UhA3Eu9CJPb+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnEKzbXMNAM80nY4nGa6f0/K8Db4eICIt/4Z9K/+D55C/A0HVrYvT9PZv3hC?=
 =?us-ascii?Q?JY9hCTrExo8jPRl3fd2lPYaSUW7JpdhaOkMGfpSN2QmcAAcHvE6EbQoLMWc4?=
 =?us-ascii?Q?mHa3tTWYjXLv/DmsiodM2hC6jsriYD8iqXNuoefvzpbuuqsxT4mMuExWlFvz?=
 =?us-ascii?Q?/mBqOLnrn6UNuyruOX/FsLXn8B1vjTIyA7+/1Ii6VANqPIgeprg54EyUIdpz?=
 =?us-ascii?Q?HeVPapKlohGlhb7bMHcmLlW80kpy1Ylzypm66Q7LonEnAwZnk7StWKSivxpF?=
 =?us-ascii?Q?kkyL4G9WttR+pqvFJsCRE56NtSuZgUe9nizTDCAailrmDUzlS6UOB0DjPwNK?=
 =?us-ascii?Q?J47PT27anj2aiVOcdyXhYB04ZwZnR8ucypbMOEb5a6iuvvXgjxO8r5/JkXJs?=
 =?us-ascii?Q?g8Fva8qSGDwM3aiHntS5M8mUFobuy8H3sE9iV4jgCgKtHAtMRpIoQqJ9BWeb?=
 =?us-ascii?Q?o9fnOEGa9me5Xe7cNbdO9AwxkOaHUgON08BbVlbVkVf4lOC3wclriP1owrRm?=
 =?us-ascii?Q?Vt5yru+rjVF00gkDTNGR6qoTdsW3P8HCm9aQF2UyHIbYLxzmr8P7I7ife7BM?=
 =?us-ascii?Q?C7PHZzG1nWxQr5mNdeXMqZ9zAQ34gc9iOZgrXThGz1cZnG39ln+wbOZQQPvq?=
 =?us-ascii?Q?bGAGEzwIXsOFCYi5xlPrquQe8grbLn9MRe0ufV7jX19CSgQfh3/LGOVHhSy2?=
 =?us-ascii?Q?UM4m1q0llEPXif9IReCsto9EG/pD4Q3lpsBQGXqrBGexR8N0eNCdVVQSZGJw?=
 =?us-ascii?Q?3EJynjgnawBnazfJWw02UfPEmoUWE8vl9yOsV92Ny3Emk2nIFQe4rtcsylhr?=
 =?us-ascii?Q?6BLw0w21JKRS0EnR/P06BQJd53W0WUfxws+1fCneMNcgR+gnWKAEomFXMFFL?=
 =?us-ascii?Q?FQ7aiVF3hDbZbjrOdT6LFP3F9lCY88zLv9D1wnP6KMkVI13ti1BAQR5mUERO?=
 =?us-ascii?Q?FGHYZtnWqwQu4tqtmm4du8st3l2l91ErvxVmkpJxv1Fel7SQj34SPLijFMn8?=
 =?us-ascii?Q?yoTJLRyE5TIIza3n7ojJQZ2V9HJwgHREmh0tgru8AUC1JAQ8XGQZOFYSDDTd?=
 =?us-ascii?Q?nyVSkJVVL9ihEhas+PkN0URQYq0WLy/vfsdexxZnzD1P4PYNJj/J5jDTvGPf?=
 =?us-ascii?Q?OXWuCBFlR1YqNIztZEAnyovl20rHTjeoT5bJDdhbBoA4hx+PPP0JB/sWIo+2?=
 =?us-ascii?Q?3wFkxwpS9jSwHsT+1ragTBGBz53F/8ZblO1bssT0qWwEbBexsxBnPcSgyXkt?=
 =?us-ascii?Q?lcysxNLhqfc+3cR2ZI6DQGUH4OIa6/1601I7SFyWv00sTYGnBkNFWsdmyfBQ?=
 =?us-ascii?Q?5luBuffH2NZ/VGWv9LVKvapqrrnt3AmjvrTY55sNjHXoRpG/zS0hoj/GcWBO?=
 =?us-ascii?Q?otvEipPBl6frVy9xGbUwxMgaJkAzHFUq5/OzEXOSAPntTKPxxbXmISHqP2gX?=
 =?us-ascii?Q?SHwhb5cYOq6lwHag8WKb08p+MDbazWdtPj6s+m3Iwe2cITghJ1xvJ/FaKYth?=
 =?us-ascii?Q?+L3sf5rBUuqogRP7EWpdxbk1SGH9qT5i4tZ0N6hzhNzljoZsciDVhwvVtTTJ?=
 =?us-ascii?Q?gWIWiBVqf7+VimeLWMfRQid8bSHzlACEGpr6dacs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d34a885-06c1-4a45-c841-08dd4ab3d4cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:38.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh8bi5yv3DRpg5ftf48IM7MAKtTnpP8Ff6b1fQBi1wl8NF1r9xiv9bPP6dotYAND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

It is a preparation patch for non-uniform folio split, which always split
a folio into half iteratively, and minimal xarray entry split.

Currently, xas_split_alloc() and xas_split() always split all slots from a
multi-index entry. They cost the same number of xa_node as the to-be-split
slots. For example, to split an order-9 entry, which takes 2^(9-6)=8
slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8 xa_node are
needed. Instead xas_try_split() is intended to be used iteratively to split
the order-9 entry into 2 order-8 entries, then split one order-8 entry,
based on the given index, to 2 order-7 entries, ..., and split one order-1
entry to 2 order-0 entries. When splitting the order-6 entry and a new
xa_node is needed, xas_try_split() will try to allocate one if possible.
As a result, xas_try_split() would only need one xa_node instead of 8.

When a new xa_node is needed during the split, xas_try_split() can try to
allocate one but no more. -ENOMEM will be return if a node cannot be
allocated. -EINVAL will be return if a sibling node is split or
cascade split happens, where two or more new nodes are needed, and these
are not supported by xas_try_split().

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 Documentation/core-api/xarray.rst |  14 ++-
 include/linux/xarray.h            |   7 ++
 lib/test_xarray.c                 |  47 +++++++++++
 lib/xarray.c                      | 136 ++++++++++++++++++++++++++----
 tools/testing/radix-tree/Makefile |   1 +
 5 files changed, 188 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index f6a3eef4fe7f..c6c91cbd0c3c 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index entry will set the
 entry at every index to ``NULL`` and dissolve the tie.  A multi-index
 entry can be split into entries occupying smaller ranges by calling
 xas_split_alloc() without the xa_lock held, followed by taking the lock
-and calling xas_split().
+and calling xas_split() or calling xas_try_split() with xa_lock. The
+difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
+that xas_split_alloc() + xas_split() split the entry from the original
+order to the new order in one shot uniformly, whereas xas_try_split()
+iteratively splits the entry containing the index non-uniformly.
+For example, to split an order-9 entry, which takes 2^(9-6)=8 slots,
+assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() need
+8 xa_node. xas_try_split() splits the order-9 entry into
+2 order-8 entries, then split one order-8 entry, based on the given index,
+to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 entries.
+When splitting the order-6 entry and a new xa_node is needed, xas_try_split()
+will try to allocate one if possible. As a result, xas_try_split() would only
+need 1 xa_node instead of 8.
 
 Functions and structures
 ========================
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..9eb8c7425090 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned long index);
 int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
+		gfp_t gfp);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_state *xas, void *entry,
 		unsigned int order, gfp_t gfp)
 {
 }
+
+static inline void xas_try_split(struct xa_state *xas, void *entry,
+		unsigned int order, gfp_t gfp)
+{
+}
 #endif
 
 /**
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 6932a26f4927..598ca38a2f5b 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1857,6 +1857,49 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xa_destroy(xa);
 }
 
+static void check_split_2(struct xarray *xa, unsigned long index,
+				unsigned int order, unsigned int new_order)
+{
+	XA_STATE_ORDER(xas, xa, index, new_order);
+	unsigned int i, found;
+	void *entry;
+
+	xa_store_order(xa, index, order, xa, GFP_KERNEL);
+	xa_set_mark(xa, index, XA_MARK_1);
+
+	xas_lock(&xas);
+	xas_try_halve(&xas, xa, order, GFP_KERNEL);
+	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
+	    new_order < order - 1) {
+		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) != -EINVAL);
+		xas_unlock(&xas);
+		goto out;
+	}
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	xas_unlock(&xas);
+
+	for (i = 0; i < (1 << order); i++) {
+		unsigned int val = index + (i & ~((1 << new_order) - 1));
+		XA_BUG_ON(xa, xa_load(xa, index + i) != xa_mk_index(val));
+	}
+
+	xa_set_mark(xa, index, XA_MARK_0);
+	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
+
+	xas_set_order(&xas, index, 0);
+	found = 0;
+	rcu_read_lock();
+	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
+		found++;
+		XA_BUG_ON(xa, xa_is_internal(entry));
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, found != 1 << (order - new_order));
+out:
+	xa_destroy(xa);
+}
+
 static noinline void check_split(struct xarray *xa)
 {
 	unsigned int order, new_order;
@@ -1868,6 +1911,10 @@ static noinline void check_split(struct xarray *xa)
 			check_split_1(xa, 0, order, new_order);
 			check_split_1(xa, 1UL << order, order, new_order);
 			check_split_1(xa, 3UL << order, order, new_order);
+
+			check_split_2(xa, 0, order, new_order);
+			check_split_2(xa, 1UL << order, order, new_order);
+			check_split_2(xa, 3UL << order, order, new_order);
 		}
 	}
 }
diff --git a/lib/xarray.c b/lib/xarray.c
index 116e9286c64e..c38beca77830 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
 	}
 }
 
+static struct xa_node *__xas_alloc_node_for_split(struct xa_state *xas,
+		void *entry, gfp_t gfp)
+{
+	unsigned int i;
+	void *sibling = NULL;
+	struct xa_node *node;
+	unsigned int mask = xas->xa_sibs;
+
+	node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+	if (!node)
+		return NULL;
+	node->array = xas->xa;
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		if ((i & mask) == 0) {
+			RCU_INIT_POINTER(node->slots[i], entry);
+			sibling = xa_mk_sibling(i);
+		} else {
+			RCU_INIT_POINTER(node->slots[i], sibling);
+		}
+	}
+	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
+
+	return node;
+}
+
 /**
  * xas_split_alloc() - Allocate memory for splitting an entry.
  * @xas: XArray operation state.
@@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
-	unsigned int mask = xas->xa_sibs;
 
 	/* XXX: no support for splitting really large entries yet */
 	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
@@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		return;
 
 	do {
-		unsigned int i;
-		void *sibling = NULL;
-		struct xa_node *node;
-
-		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		struct xa_node *node = __xas_alloc_node_for_split(xas, entry, gfp);
 		if (!node)
 			goto nomem;
-		node->array = xas->xa;
-		for (i = 0; i < XA_CHUNK_SIZE; i++) {
-			if ((i & mask) == 0) {
-				RCU_INIT_POINTER(node->slots[i], entry);
-				sibling = xa_mk_sibling(i);
-			} else {
-				RCU_INIT_POINTER(node->slots[i], sibling);
-			}
-		}
-		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
 		xas->xa_alloc = node;
 	} while (sibs-- > 0);
 
@@ -1122,6 +1132,100 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 	xas_update(xas, node);
 }
 EXPORT_SYMBOL_GPL(xas_split);
+
+/**
+ * xas_try_split() - Try to split a multi-index entry.
+ * @xas: XArray operation state.
+ * @entry: New entry to store in the array.
+ * @order: Current entry order.
+ * @gfp: Memory allocation flags.
+ *
+ * The size of the new entries is set in @xas.  The value in @entry is
+ * copied to all the replacement entries. If and only if one xa_node needs to
+ * be allocated, the function will use @gfp to get one. If more xa_node are
+ * needed, the function gives EINVAL error.
+ *
+ * Context: Any context.  The caller should hold the xa_lock.
+ */
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
+		gfp_t gfp)
+{
+	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	unsigned int offset, marks;
+	struct xa_node *node;
+	void *curr = xas_load(xas);
+	int values = 0;
+
+	node = xas->xa_node;
+	if (xas_top(node))
+		return;
+
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+
+	marks = node_get_marks(node, xas->xa_offset);
+
+	offset = xas->xa_offset + sibs;
+	do {
+		if (xas->xa_shift < node->shift) {
+			struct xa_node *child = xas->xa_alloc;
+			unsigned int expected_sibs =
+				(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
+
+			/*
+			 * No support for splitting sibling entries
+			 * (horizontally) or cascade split (vertically), which
+			 * requires two or more new xa_nodes.
+			 * Since if one xa_node allocation fails,
+			 * it is hard to free the prior allocations.
+			 */
+			if (sibs || xas->xa_sibs != expected_sibs) {
+				xas_destroy(xas);
+				xas_set_err(xas, -EINVAL);
+				return;
+			}
+
+			if (!child) {
+				child = __xas_alloc_node_for_split(xas, entry,
+						gfp);
+				if (!child) {
+					xas_destroy(xas);
+					xas_set_err(xas, -ENOMEM);
+					return;
+				}
+			}
+
+			xas->xa_alloc = rcu_dereference_raw(child->parent);
+			child->shift = node->shift - XA_CHUNK_SHIFT;
+			child->offset = offset;
+			child->count = XA_CHUNK_SIZE;
+			child->nr_values = xa_is_value(entry) ?
+					XA_CHUNK_SIZE : 0;
+			RCU_INIT_POINTER(child->parent, node);
+			node_set_marks(node, offset, child, xas->xa_sibs,
+					marks);
+			rcu_assign_pointer(node->slots[offset],
+					xa_mk_node(child));
+			if (xa_is_value(curr))
+				values--;
+			xas_update(xas, child);
+		} else {
+			unsigned int canon = offset - xas->xa_sibs;
+
+			node_set_marks(node, canon, NULL, 0, marks);
+			rcu_assign_pointer(node->slots[canon], entry);
+			while (offset > canon)
+				rcu_assign_pointer(node->slots[offset--],
+						xa_mk_sibling(canon));
+			values += (xa_is_value(entry) - xa_is_value(curr)) *
+					(xas->xa_sibs + 1);
+		}
+	} while (offset-- > xas->xa_offset);
+
+	node->nr_values += values;
+	xas_update(xas, node);
+}
+EXPORT_SYMBOL_GPL(xas_try_split);
 #endif
 
 /**
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 8b3591a51e1f..b2a6660bbd92 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -14,6 +14,7 @@ include ../shared/shared.mk
 
 main:	$(OFILES)
 
+xarray.o: ../../../lib/test_xarray.c
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-- 
2.47.2


