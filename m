Return-Path: <linux-kselftest+bounces-28510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A182A56F53
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8F37AB33A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6624501B;
	Fri,  7 Mar 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfsY76Wr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACA241690;
	Fri,  7 Mar 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369218; cv=fail; b=po82MPek79cEnMdIJYYt5PPuqciQKNekHr0D6k6zXt1ZiIGRSuQjIgvtQAeZTpVzJP8EEZwZZX3m1/O+YlR8GoyCCb8VQU7s2lSbtjgPth17JnMk5VyruIZN9kXtvp9HNu7EyypJf0TOO65EhVoz05MhBkndVwOZGELuebLjDIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369218; c=relaxed/simple;
	bh=WmkSfSKcdnLeCajmnHB+91ZUs6ORYa874/4jKQohYz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6jxrWGiJZDWTtPfeIolLsIUEVb3IMIqy0dLIk6F5P6VwjXxzIAWBRbpZc6sfLHYd+6K9+RfYTUubQkJyXtlGu5xw4ocOsw8IJkGOX3xlpA+owUPr8713BssSz6QMaJRX2TRcQxfzeAVqUTK45r1AWc4pogeKZL2raE67+lBVO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfsY76Wr; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKCHtgYAwoeMW/EN0whmrqP/95Tq6t8NFpyVOd6kwlugzya1VQcbeZzlszrkufCm+g4bG7BkkZ8mBEM4qZ3663iNRR8X8dMXoLureTmJyYTz4v5P4yWlaYmaanoS2Pb6DXADuPlyIppnPcUY1XuN4rLpYLR57nMTLHC3MLc+lwXbUt0QJt1vIlLxUiJeo52qJp+DHDPgFRjiVZz5vIaylvelDEgsSwB5PVaZ4oyvPk5yZnUrJS1e19GxnKDnhjevjPWMShG7qISMMbscEjznUUvm7TT2nZRYkvHwRLpPOz1W4HjMmUW99QTqgq+8YgCS8bUvDnKOQSvFHNiHCwmAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBuTLWbsJir6CHZpkVKu+RnRUxfxtCLRhi+FYL+5qAE=;
 b=WMfkVzSB0VCUAZjxPYRAa4aUKaBE4B/8fCHRzCgYUXIo9hB6cTUmuyMzd3YAicAXDuHOpKyROOtkYHVubHlSeFzAfP7GEE0fHXQaxovK1IiYII9jMzNpeGSGWpo10E6knNp3sziPFeMb5Z1DjLga4YR3CPtquB6nOBK5N5v+0XGwSzn63aFo3Io5YkcV5dIYY4p4rYF+XqYazhOq3F2x3PvVw3gk8RTbyXIRhlU4/UuIdsw32w4jvXoEYk+dAMgLT/wbRNEH/hVxpTHFY30uTtPNDZC615BGee7XJeQ9+SK8Hi7kxwmcmIt+ItaIrCwMSpXrwQDoHJZbVZSwD6Px+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBuTLWbsJir6CHZpkVKu+RnRUxfxtCLRhi+FYL+5qAE=;
 b=sfsY76WrZZCBNiN7WuPVsPeclhmpyKkHesoRdrTpS8t9x7e904qcjEvuRnvvgJoXOpdyKf5XvdvPn35kwcsc8mfHS0wKs9rq3bHKIADufQLMj0jheP2V/tXKpfXucE/b5pm2awpHDpIWZEuNrXt9d73meR+ZQDP4yD7Q2/9zxuunIznOkssVGNyd/SYUcEEuj1TkhFehQ0fGCS7/bSBNrI7jflUdGxO+i3MfEmIG6ZIY6di8x1FErjoMB3nDuuC12eN98AAuiZWVIIvHuDWQIfcYHB8l4+EVMmfjAiUGjrO7xuz5AfM7S2PRny2VpBWp2ACtxo4arbVGk9WJIBSRDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Fri,  7 Mar 2025 12:39:55 -0500
Message-ID: <20250307174001.242794-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0119.namprd02.prod.outlook.com
 (2603:10b6:208:35::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f84b7bd-8d07-4afa-73de-08dd5d9f1bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mn/zLZeJNII7c95ZGyaIxnP1fjYJqN6w7WT1t2jv2gwqvZuprUKioOx6zVhq?=
 =?us-ascii?Q?/ujAAfQww8pqdyYDAoHdecfd1/mOgEjuzSVtpsHZVwqVRo6pD9yG1JqKUfiz?=
 =?us-ascii?Q?jKkdSsOguDFTSWZ5PkCfP5wgfxGElTgVuJH0cfYB8oSJzIZLqZeWK5WYKJge?=
 =?us-ascii?Q?gcfqKQV+fMhRXKvUWYhxr0w5f5U0+iowOkatPbUV923ZoD4KFTQOARUbztnY?=
 =?us-ascii?Q?Et0RSVBbFZyox9DwEfAyCZd94ddxYgj6e/OPBBdnhZTdztV/g544CgStqp9b?=
 =?us-ascii?Q?v6w3Hj/TCYuZD/9LnUtPdDfDC6stJG05itcuMLI32UK/8vtSIzYk1sNIDow+?=
 =?us-ascii?Q?RZfhw+sp//ixCzMnMRJjlaOuscqEl1GQxhJp7JWrGLom8l0j7Lpx0Yu8fb+V?=
 =?us-ascii?Q?nX0fY+mgj0HsRXDnk5z63jFXCzXVOH7nZ+0X8iPwVWaZ8kEaeBUFwLKt7Tg8?=
 =?us-ascii?Q?WErsjPE1TKv1WDh5PcT2S2jWTzxl3erI/Tvk0w8BgnaI26IjDcgeBVD8feo+?=
 =?us-ascii?Q?Ii1hB4Xn6XMqsTWjPIpUgzs+dYZtc5/o/UHfBM9J2TOYFAHvxdmGcbAuY6kh?=
 =?us-ascii?Q?nmvaGhSpTNUAEoOY1xEuqaTYD9o3p6X0uezA75M977gJPWvhAc8p8ac1N4Rb?=
 =?us-ascii?Q?6/Hjcr8voDMbXZkgBSppsq2XfknZZoAjKdm0AvKBwDYfi/yCYlISyc/JbusH?=
 =?us-ascii?Q?bOCLUQ/BWsJeKK/dKojYAqOJULJxo0+OCVPrBIMziNmhyR1z8Bm0G/hopsny?=
 =?us-ascii?Q?DUoKGzwSa+dM9oBcLlu+7DfsrHci6m3XaC/ZwbEOh13GcEldu2qBTDv81slZ?=
 =?us-ascii?Q?shuXMRtkxvJH06wmlCUnZOAeABxMxXjzWSwk35uRgTyW7TAOMUC6pP/mFEvJ?=
 =?us-ascii?Q?ql5133h5bwaXA6lM5c5xa+QWRLFI/KlWzyoF9Fh8C+Bevtr9tC49fa8oDcrR?=
 =?us-ascii?Q?1cZQBybG7ILKrOVW3Xq5CmcEoLvZ4RRJzi6EARK8NEiMo1gv1SYAvTwhboah?=
 =?us-ascii?Q?Yrk+GOARnceKL9fAJKW3IoolPn9DUXfxYUTGs3J7B2g5VR4wVdtfdgKBsfOv?=
 =?us-ascii?Q?h91EXQLfw47jQIbXsewxzUhxpT4D/RbDNS/cY8onveszBY9WRiAJbHiGin6U?=
 =?us-ascii?Q?+YQmQJ7K9+WfiyUixB22K08fud6dxMIPdKNBEh+YgVYJu6OtIw5bTCvIt/Do?=
 =?us-ascii?Q?sYffmbaGJ5KWmdJF7NjKT+i/EThx6/uAHKzMC1KR+AcKlReKnR9qXZp6xKVy?=
 =?us-ascii?Q?T0MJr0RahGpU9ly/QmE7OUIa95yCfY/year02J12s5MjJTIF+3LWy65Dc5Hj?=
 =?us-ascii?Q?FCTEGg3ZufCtG+oMXSAAvA6X4/EUb7wXXa1pm9RljM0113HMqHmr0yHIc6yn?=
 =?us-ascii?Q?Vd4dfB+X2rwt8DBj3xzSd2Y0Mr5P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSydk9Av3+mKBmtPWJGJj8U0pEMN8Oey2ddozv4Ny/CN40SmTvMfuWuZg2UY?=
 =?us-ascii?Q?6/SgX9m3jRzapmKV8bZlxM8ZilUzGRigCgX6B4TWkbtiPTERAypQ8mi6gS/v?=
 =?us-ascii?Q?p5BA6gDynIpxXPvTB8GY3J9PKdQerrUO5l4xxKkfAIYFru5OyG8BGi3E/gHk?=
 =?us-ascii?Q?fh72T7wio7vwUEzfgv1azVlgqEaHZ8Uz+PW33ttoYOm4WwlG1590sNERqIVk?=
 =?us-ascii?Q?IUyQB2gi5/6muwWz1w2epga8jYl7FXYvF1zxRV4LHNF6zIYuKk86dEXbbON4?=
 =?us-ascii?Q?FVUuGv50GaFB0hJfx/FfnsYolsSGMS5eIxg12nAAfMnOMFg6AXsnyjewdxAa?=
 =?us-ascii?Q?uZuwxSWr2ZaYDDhxSPGOlZa4sOrMGien72XEHZ1WDQxzLn7WVMvCZ4VZeaWk?=
 =?us-ascii?Q?Mo43O4p469GhqbMF6SxJ52gRZzL78dtrCiLXmHk4nkurT1ARZTLb2XBhuLI9?=
 =?us-ascii?Q?DuEfTWOZAxNpsiNFsRMekcxclginc2uKqyVWhoEPlq8jtd03i3K9Id4lAUPJ?=
 =?us-ascii?Q?pFI7D+6BC3po4pBasLyB1exgG7Jb0pXQQDjUZVPxZgbfD56h71bhc24KyuLQ?=
 =?us-ascii?Q?96lgECoQPqbFhdViYi1dOulFB4dcgrsWYYBH7rWcIsLSTnLQtvdJS7b2NJos?=
 =?us-ascii?Q?Car8RddJUy9R9baKt+FLkf8PkxRzhnrPxRpsnjjT+1sbSXAFmgmNoSIuW1Ah?=
 =?us-ascii?Q?eaD4sczOt94J0+3LNMWoQEOBNRGkdjvMT0ZEz3UJwdXnszSu18haHpOpLmgM?=
 =?us-ascii?Q?m9ij7NbgxdJZLEz38Lo1jWVpMKeHB/JMlZFb5dMwJBks79Op1b48XTa5IuZz?=
 =?us-ascii?Q?PhMZ5tyCz8Yk+O6a/v3xNnNu0BVs4n4VsVWMlmFUyTrqIe4kw6xDV+lj6Ute?=
 =?us-ascii?Q?to9lwOsTiwZZiFNfeHPUZ85ySo2aBgFouAggdlEoP0woiQ+2gK0c3hX8MRZh?=
 =?us-ascii?Q?GjmhmO1LmExhAtK0J4NCJu51sOXlUOb3oZvMBw4rniOT/bPIDUvw/0n9Aa+U?=
 =?us-ascii?Q?8wgNHlKpAYI7xPoGKIKZvvDuEUmvJ9EvkVFmFu40lAUSuJOtAqGKTkcQuJ+f?=
 =?us-ascii?Q?pOhFiuvxwf31IrEFoxOr8wpBEcIkQdci633lKkkTEx4KP1tOIKnraC8nau2H?=
 =?us-ascii?Q?2vRdoPGF1WTGub71onsRNhuXHAOLd9waKcmjS0+X4Lh8Ujvx9K6v3Ps/VfJk?=
 =?us-ascii?Q?YhwSEfW0uQmu1lfHHkHiiWlXGIvZ82kPglyzmUH2SYSWtq73/Mi1CeKLca7/?=
 =?us-ascii?Q?yyQIC/y5L4sSr5ROkTVvvCFNqCmNgWe2IVhikrbBujWQVffB4smverzMLkL4?=
 =?us-ascii?Q?VjQBU+SGsl15Pemewe3byCnfCFcngloLtPVhR5y4bvIwUMKKaTx/sUbVPgxl?=
 =?us-ascii?Q?0gjb/QZfIq8d9snbZS3abtIqUO8qkzsAuaVoWWpYNXIUef6S3EzAuyzDehRL?=
 =?us-ascii?Q?nE1P9oUzXBigwYD7pTMkfxRqqZdqpdF5F9HLDkmqxzLVie38VZyzvh2v0Qld?=
 =?us-ascii?Q?cca+1BH/XZQIygiOFvvjrxy9yROC1Ozwvj0UY+pIaKdw76X5Qt6aOnUwzyy7?=
 =?us-ascii?Q?m1IBHG7FMiO7F4+H4uc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f84b7bd-8d07-4afa-73de-08dd5d9f1bb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:10.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9uiLgBFnEqLI9CMm6MIntMXMmJLqa+uhsef7rC1ip5b/nC/HlVW+apOJgmS7fEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

This is a preparation patch, both added functions are not used yet.

The added __split_unmapped_folio() is able to split a folio with its
mapping removed in two manners: 1) uniform split (the existing way), and
2) buddy allocator like (or non-uniform) split.

The added __split_folio_to_order() can split a folio into any lower order.
For uniform split, __split_unmapped_folio() calls it once to split the
given folio to the new order. For buddy allocator like (non-uniform)
split, __split_unmapped_folio() calls it (folio_order - new_order) times
and each time splits the folio containing the given page to one lower
order.

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
Cc: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 348 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 347 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3c5d01aecac8..c10ee77189bd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3265,7 +3265,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3517,6 +3516,353 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+/*
+ * It splits @folio into @new_order folios and copies the @folio metadata to
+ * all the resulting folios.
+ */
+static void __split_folio_to_order(struct folio *folio, int old_order,
+		int new_order)
+{
+	long new_nr_pages = 1 << new_order;
+	long nr_pages = 1 << old_order;
+	long index;
+
+	/*
+	 * Skip the first new_nr_pages, since the new folio from them have all
+	 * the flags from the original folio.
+	 */
+	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
+		struct page *head = &folio->page;
+		struct page *new_head = head + index;
+
+		/*
+		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
+		 * Don't pass it around before clear_compound_head().
+		 */
+		struct folio *new_folio = (struct folio *)new_head;
+
+		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) != -1, new_head);
+
+		/*
+		 * Clone page flags before unfreezing refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow flags change,
+		 * for example lock_page() which set PG_waiters.
+		 *
+		 * Note that for mapped sub-pages of an anonymous THP,
+		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
+		 * the migration entry instead from where remap_page() will restore it.
+		 * We can still have PG_anon_exclusive set on effectively unmapped and
+		 * unreferenced sub-pages of an anonymous THP: we can simply drop
+		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
+		 */
+		new_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		new_head->flags |= (head->flags &
+				((1L << PG_referenced) |
+				 (1L << PG_swapbacked) |
+				 (1L << PG_swapcache) |
+				 (1L << PG_mlocked) |
+				 (1L << PG_uptodate) |
+				 (1L << PG_active) |
+				 (1L << PG_workingset) |
+				 (1L << PG_locked) |
+				 (1L << PG_unevictable) |
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
+				 (1L << PG_arch_2) |
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
+				 (1L << PG_arch_3) |
+#endif
+				 (1L << PG_dirty) |
+				 LRU_GEN_MASK | LRU_REFS_MASK));
+
+		/* ->mapping in first and second tail page is replaced by other uses */
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
+			       new_head);
+		new_head->mapping = head->mapping;
+		new_head->index = head->index + index;
+
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set.
+		 */
+		if (unlikely(new_head->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, new_head);
+			new_head->private = 0;
+		}
+
+		if (folio_test_swapcache(folio))
+			new_folio->swap.val = folio->swap.val + index;
+
+		/* Page flags must be visible before we make the page non-compound. */
+		smp_wmb();
+
+		/*
+		 * Clear PageTail before unfreezing page refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow put_page()
+		 * which needs correct compound_head().
+		 */
+		clear_compound_head(new_head);
+		if (new_order) {
+			prep_compound_page(new_head, new_order);
+			folio_set_large_rmappable(new_folio);
+		}
+
+		if (folio_test_young(folio))
+			folio_set_young(new_folio);
+		if (folio_test_idle(folio))
+			folio_set_idle(new_folio);
+
+		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
+	}
+
+	if (new_order)
+		folio_set_order(folio, new_order);
+	else
+		ClearPageCompound(&folio->page);
+}
+
+/*
+ * It splits an unmapped @folio to lower order smaller folios in two ways.
+ * @folio: the to-be-split folio
+ * @new_order: the smallest order of the after split folios (since buddy
+ *             allocator like split generates folios with orders from @folio's
+ *             order - 1 to new_order).
+ * @split_at: in buddy allocator like split, the folio containing @split_at
+ *            will be split until its order becomes @new_order.
+ * @lock_at: the folio containing @lock_at is left locked for caller.
+ * @list: the after split folios will be added to @list if it is not NULL,
+ *        otherwise to LRU lists.
+ * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
+ * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
+ * @mapping: @folio->mapping
+ * @uniform_split: if the split is uniform or not (buddy allocator like split)
+ *
+ *
+ * 1. uniform split: the given @folio into multiple @new_order small folios,
+ *    where all small folios have the same order. This is done when
+ *    uniform_split is true.
+ * 2. buddy allocator like (non-uniform) split: the given @folio is split into
+ *    half and one of the half (containing the given page) is split into half
+ *    until the given @page's order becomes @new_order. This is done when
+ *    uniform_split is false.
+ *
+ * The high level flow for these two methods are:
+ * 1. uniform split: a single __split_folio_to_order() is called to split the
+ *    @folio into @new_order, then we traverse all the resulting folios one by
+ *    one in PFN ascending order and perform stats, unfreeze, adding to list,
+ *    and file mapping index operations.
+ * 2. non-uniform split: in general, folio_order - @new_order calls to
+ *    __split_folio_to_order() are made in a for loop to split the @folio
+ *    to one lower order at a time. The resulting small folios are processed
+ *    like what is done during the traversal in 1, except the one containing
+ *    @page, which is split in next for loop.
+ *
+ * After splitting, the caller's folio reference will be transferred to the
+ * folio containing @page. The other folios may be freed if they are not mapped.
+ *
+ * In terms of locking, after splitting,
+ * 1. uniform split leaves @page (or the folio contains it) locked;
+ * 2. buddy allocator like (non-uniform) split leaves @folio locked.
+ *
+ *
+ * For !uniform_split, when -ENOMEM is returned, the original folio might be
+ * split. The caller needs to check the input folio.
+ */
+static int __split_unmapped_folio(struct folio *folio, int new_order,
+		struct page *split_at, struct page *lock_at,
+		struct list_head *list, pgoff_t end,
+		struct xa_state *xas, struct address_space *mapping,
+		bool uniform_split)
+{
+	struct lruvec *lruvec;
+	struct address_space *swap_cache = NULL;
+	struct folio *origin_folio = folio;
+	struct folio *next_folio = folio_next(folio);
+	struct folio *new_folio;
+	struct folio *next;
+	int order = folio_order(folio);
+	int split_order;
+	int start_order = uniform_split ? new_order : order - 1;
+	int nr_dropped = 0;
+	int ret = 0;
+	bool stop_split = false;
+
+	if (folio_test_swapcache(folio)) {
+		VM_BUG_ON(mapping);
+
+		/* a swapcache folio can only be uniformly split to order-0 */
+		if (!uniform_split || new_order != 0)
+			return -EINVAL;
+
+		swap_cache = swap_address_space(folio->swap);
+		xa_lock(&swap_cache->i_pages);
+	}
+
+	if (folio_test_anon(folio))
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+
+	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+	lruvec = folio_lruvec_lock(folio);
+
+	folio_clear_has_hwpoisoned(folio);
+
+	/*
+	 * split to new_order one order at a time. For uniform split,
+	 * folio is split to new_order directly.
+	 */
+	for (split_order = start_order;
+	     split_order >= new_order && !stop_split;
+	     split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+
+		/* order-1 anonymous folio is not supported */
+		if (folio_test_anon(folio) && split_order == 1)
+			continue;
+		if (uniform_split && split_order != new_order)
+			continue;
+
+		if (mapping) {
+			/*
+			 * uniform split has xas_split_alloc() called before
+			 * irq is disabled to allocate enough memory, whereas
+			 * non-uniform split can handle ENOMEM.
+			 */
+			if (uniform_split)
+				xas_split(xas, folio, old_order);
+			else {
+				xas_set_order(xas, folio->index, split_order);
+				xas_try_split(xas, folio, old_order);
+				if (xas_error(xas)) {
+					ret = xas_error(xas);
+					stop_split = true;
+					goto after_split;
+				}
+			}
+		}
+
+		/*
+		 * Reset any memcg data overlay in the tail pages.
+		 * folio_nr_pages() is unreliable until prep_compound_page()
+		 * was called again.
+		 */
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		folio->_nr_pages = 0;
+#endif
+
+
+		/* complete memcg works before add pages to LRU */
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
+
+		__split_folio_to_order(folio, old_order, split_order);
+
+after_split:
+		/*
+		 * Iterate through after-split folios and perform related
+		 * operations. But in buddy allocator like split, the folio
+		 * containing the specified page is skipped until its order
+		 * is new_order, since the folio will be worked on in next
+		 * iteration.
+		 */
+		for (release = folio; release != end_folio; release = next) {
+			next = folio_next(release);
+			/*
+			 * for buddy allocator like split, the folio containing
+			 * page will be split next and should not be released,
+			 * until the folio's order is new_order or stop_split
+			 * is set to true by the above xas_split() failure.
+			 */
+			if (release == page_folio(split_at)) {
+				folio = release;
+				if (split_order != new_order && !stop_split)
+					continue;
+			}
+			if (folio_test_anon(release)) {
+				mod_mthp_stat(folio_order(release),
+						MTHP_STAT_NR_ANON, 1);
+			}
+
+			/*
+			 * Unfreeze refcount first. Additional reference from
+			 * page cache.
+			 */
+			folio_ref_unfreeze(release,
+				1 + ((!folio_test_anon(origin_folio) ||
+				     folio_test_swapcache(origin_folio)) ?
+					     folio_nr_pages(release) : 0));
+
+			if (release == origin_folio)
+				continue;
+
+			lru_add_page_tail(origin_folio, &release->page,
+						lruvec, list);
+
+			/* Some pages can be beyond EOF: drop them from cache */
+			if (release->index >= end) {
+				if (shmem_mapping(mapping))
+					nr_dropped += folio_nr_pages(release);
+				else if (folio_test_clear_dirty(release))
+					folio_account_cleaned(release,
+						inode_to_wb(mapping->host));
+				__filemap_remove_folio(release, NULL);
+				folio_put(release);
+			} else if (mapping) {
+				__xa_store(&mapping->i_pages,
+						release->index, release, 0);
+			} else if (swap_cache) {
+				__xa_store(&swap_cache->i_pages,
+						swap_cache_index(release->swap),
+						release, 0);
+			}
+		}
+	}
+
+	unlock_page_lruvec(lruvec);
+
+	if (swap_cache)
+		xa_unlock(&swap_cache->i_pages);
+	if (mapping)
+		xa_unlock(&mapping->i_pages);
+
+	/* Caller disabled irqs, so they are still disabled here */
+	local_irq_enable();
+
+	if (nr_dropped)
+		shmem_uncharge(mapping->host, nr_dropped);
+
+	remap_page(origin_folio, 1 << order,
+			folio_test_anon(origin_folio) ?
+				RMP_USE_SHARED_ZEROPAGE : 0);
+
+	/*
+	 * At this point, folio should contain the specified page.
+	 * For uniform split, it is left for caller to unlock.
+	 * For buddy allocator like split, the first after-split folio is left
+	 * for caller to unlock.
+	 */
+	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
+		next = folio_next(new_folio);
+		if (new_folio == page_folio(lock_at))
+			continue;
+
+		folio_unlock(new_folio);
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		free_page_and_swap_cache(&new_folio->page);
+	}
+	return ret;
+}
+
 /*
  * This function splits a large folio into smaller folios of order @new_order.
  * @page can point to any page of the large folio to split. The split operation
-- 
2.47.2


