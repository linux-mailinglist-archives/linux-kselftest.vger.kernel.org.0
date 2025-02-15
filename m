Return-Path: <linux-kselftest+bounces-26702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5313A36B36
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 02:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AF01893950
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 01:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC37CF16;
	Sat, 15 Feb 2025 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hs3hCEdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C242AE8B;
	Sat, 15 Feb 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739584365; cv=fail; b=GV5NGCR1CqWrWTBP+lPE6j4kNYpKGg2C+nX7Q08U2TmGby7qppAXiCw/UY0//R/OE1vU21tVgCjve6ba6BtdE3XwgTcGdtI0hOKJJhPiTQGHrQCPxsXj3Y+hDmy2+p2O0lnf1pAHhgXXXMt3l9v55HaJLc9PWC0v41Zd08eNjxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739584365; c=relaxed/simple;
	bh=yGwdnpT71/eJ7ZXp6aMWyvqLmul+rD+oI1Bl+SfoK84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izq1+qEBy74jGRR4ecPdZyP0SQ9Geo8HkO0M0XS5e0zXPurwfWUOQk1OMFpIIqOjIblXHxoHowfirmz1WYreMZbr5u1l7NHrIVX3Tif8Necft+yH+9WeuSNiIjBN9EWRyGbnVQ2E0hbk3p5j4HbxPpLYMLk962jRerIVQiNryXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hs3hCEdN; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYleCVsE7ww8Cda4wbEt8KOZ0I7ZZCDN5hQSFQ9Zz0WbzYjH0xJbnxZ6ZJkvoocsgxFh5kGVeXSPS2GV8v5UVyz6O/CgHWhybHGrEYHEijsKfiamUkZjFkCtbnozeOG+QHq3S+fS2HxPKZOh9CRwyT3bim2E55l6BzYM1Z+cGlKTX6BL2jnbTJa043hg8gYuw0XfR2nKA/hpbx7kuwuy66/N7dYOVIQARc+vkelD0ABu4hMGBh7LTbHAyTLK49HeoDr+TVmQEpSnFM7KItLxnpnP91QtQZxkXq6zTWxIpGfD2xhM07ONMeAC9XJT4t+UeYa605VxNFQDqYzxeypLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOIVHY55s6ESUI6k5Sa5QkOSYWwmVOBVHgDnMxW4aFw=;
 b=HNJOpWOsiM+giyMpQ0M4Yicr5NHSdNQK2cG5n0Q3vMSpfuVQr4o1mmL3EPIX/wxV9pgI05kPs8owDKhyebadCmT5EjEJa6VddjAHKm3mDtZfOcZvneM62jpkGIP9mEPCwE7fEzFyAm7U23JX3qo64eRUW4LuqrmghFfZGfbCLAVsn7eKGbXhgaa01SgKAGVmN67CH/ctBHUL4AcRO86kf9jqrZB/9iGBswMH/nGcSR/j/HIyGUvShLojVve6FPaFnhSU9Cs4DcVIiWe8eLobj+stHntkPiLWVXqmsEc4s4P1xwVLXIlWGHjAn0KDQpISLj4D5m8yuAoKlfZ/p8dFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOIVHY55s6ESUI6k5Sa5QkOSYWwmVOBVHgDnMxW4aFw=;
 b=hs3hCEdNvsmNFtMs38wvBqMFRnTx4wDW/fWNvSCdautU8G2uQQEG46V0p6ZADXwFaXlLyYWR9CuAXAgzIAuIzSEJbLU727X+oNXsOdrSqcojze+TBJBRuWeHlDOuabTHnM94yJ8AJGBrXPuOuXea+R4EYoD87q9o9YKC9hVle1hIRuCa+Boq04yAbHPPSlatkY8serkUIXVRQtzi+jouuX5pkSpX4uygbtQQwlXHE+PRnQG37il1f5kDGCqZEi00Ok1d+0TLip6GLQDiOafuHPSKapldEURSE97Rso1IrR9savWOkRaoHixTaZNXLBkAcEWcJTaRyn1WwLILh0KLGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Sat, 15 Feb 2025 01:52:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Sat, 15 Feb 2025
 01:52:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Fri, 14 Feb 2025 20:52:34 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <E2B8D781-01EE-4832-8587-4C5FF57F91B3@nvidia.com>
In-Reply-To: <20250211155034.268962-3-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-3-ziy@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f70573-35ff-4d50-0624-08dd4d636e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4z669r/mpdbNFA0jLqiZaiqUcOhPOvVr/Q6vc2xHNmN09xyHEd4vYssvseHY?=
 =?us-ascii?Q?lUyw98oay/hfuecC9X3/qURJTQPYuNCKHaiW4ULb211n39qjkuYBsmfmE7Y4?=
 =?us-ascii?Q?L6yd5xd5gTX/MNq9JJzcGFubCXKbH0FqZFSql/CDQ0vcp4s7tcHmLF5R/ozS?=
 =?us-ascii?Q?0c6/TaFjvLbrSCylz1nVxtRKJ4dpt3Uqj8sX70zx0HhtbUI3IzDivCAskK9u?=
 =?us-ascii?Q?f/AzTalpusClsl4sHfTj4dTHEwaSAMIatLaXGRHBM6k9XvyOTda6Y4g9Y2R3?=
 =?us-ascii?Q?6h0KHpT7JB+snAkA8ODeXhnEOQxa2v3N4EDZnb0Hn/O+9eIDQF3DV2OkfGo/?=
 =?us-ascii?Q?w6U0DSZdwbgp02sBRrYTlQJL+eD2nmhuk3YJ8ELexDPV4jBs1Y4sxObKzMQ1?=
 =?us-ascii?Q?vnFcs6wDe4YdjXBZ3+dnAgw9HcdwMl+b6cN8u88g1lGFePFg9GnWOstXaoq3?=
 =?us-ascii?Q?hGKLWA01lV+0mH7czKpwHYz2dhG/adCNnHrPKzFlVFvyOWKoHbseBbbEukDB?=
 =?us-ascii?Q?IGrfA9rxV+9WUA/ZW49WqDq4qe9cpT/01QGUyhR3OCIAHa/1n14XstwU4ECW?=
 =?us-ascii?Q?bC1uNLJ4qFnHC7wQWTjQOMrEJ6GZvuerHI3v32pTYebbr8683XSFiBr1eLvp?=
 =?us-ascii?Q?ydIw0lEiuPuqWYCT5VJnUlPidlxF15fQNfo4OozYEdoKaVTzD/qir2SPVMmy?=
 =?us-ascii?Q?VVRlU/SPiPkW1HegCpr6xg+71gQIqbEFpxlmx9hvrN0PJ8WBFXxqc9W7UB1b?=
 =?us-ascii?Q?eAz/B7YS+Ylp11G/C6RaYDieinZWA6QXuJ3Oi26m8BqmxByjzs7nsViT6nb4?=
 =?us-ascii?Q?/9oDBpLyjqYz9gup28972GThjLPfgQkrJgaQa+WlX0+Ef2TDoiYLidcZZaUv?=
 =?us-ascii?Q?/3LwUoUB7+HDo4o6fmLskrAQo6iUZlQYvjw72vq5J2ojzC1/JVbezSCUrw8j?=
 =?us-ascii?Q?bD0WrOSGZCWLbWCN6p7a1w5UB2ilgqh5ZpmlQfD7LpLk0InG7VNOmPdrhIO+?=
 =?us-ascii?Q?Bz1VMAJzTcW6++m2RtO/eJM3p6wuC56nG1oPF3a5qfub0bG9hyPuhaPe42pr?=
 =?us-ascii?Q?5cfQVR2eqyVliQe8z6ixIc46A75uzi1cdvBhjXRa4N9YgCc79HfVFvUn1fl6?=
 =?us-ascii?Q?j4GGx+/FEHycxrC2x8fkul0ldvb+TiRNgtg1mEfFTgPfVlnpy/V1upYFrFZ0?=
 =?us-ascii?Q?QNuOJAtY6qdKTkqRPV0DIsIqDDoZGhgqg1row+Jb3gNARCrPMqVpJ51cJHt6?=
 =?us-ascii?Q?DUhBDivqi1n/LDdEaG65Eaxe35MBknVBUAdlVVoufhZQ70XaYt/JGJ+ipadz?=
 =?us-ascii?Q?yCcoOgxmXVg/vnBi3hUNLnBrEB+l5AG6oFuR8a2brHE0hmFrcL9IRNbuBiHS?=
 =?us-ascii?Q?pOc7gtY5sUMzIOfrYIleiBg277VD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imXXdltD2D3HY8j75AASBWDSzCQbdgyC+hxcGDHpA/Hj7OPaqIhmJqV+PlaE?=
 =?us-ascii?Q?tzWE11NGaH77QOQ2c5aH+uTn5MoMQSoycRYhwn4acEN8FfnCCJB6Cj1g2o4n?=
 =?us-ascii?Q?Lh3A8Mg6idcsGGOk+g6JIcvvK6jwmY8INJRrABN+Z83UjL6rURQ2Npwabrkx?=
 =?us-ascii?Q?1oDf3OsXQFuTHQ0nI1PpfOFXs2RkdKCPi9QlJ3zL3ezC2lvo2heptqwFvQ7I?=
 =?us-ascii?Q?xhp6xM8/mleO5Vw74InAXPler2R+tp+OgtiDgy8x3O0Q0Veo830loytII0xX?=
 =?us-ascii?Q?4T7/TmgIvxOa0wv0ixIkWb1B7r84iNvWYT9x9l4pPVYpEbC6kRjGUFj2Dmp1?=
 =?us-ascii?Q?UiPvvf5aXdWIf+w0S+vaCAHkAEeqTlmtBLGW3X5XYp6Cn8KRF7h2rqn1WI3L?=
 =?us-ascii?Q?MsJlDTkMmlmhQX0+HN6/wtZTJ12iyPfg/kCQas5ngsu5YbxVJ19TiDxXHR52?=
 =?us-ascii?Q?HPARE7u3NHmmpFibtldcoPzywbx4EI1HO38If+KCUYtMvBMzyRQ//3RUBlEY?=
 =?us-ascii?Q?lX0v/V1vQvx5jlmgn9H9J4PqGpwdZRGRI7rlpH3zKk/k0f1SgUP+nrFr8/QN?=
 =?us-ascii?Q?iByCWfHz44b09zkoJ1aVLRAQhubeUxS+kbjKZ5TJ502n9K8W2NPRXjpEwMoT?=
 =?us-ascii?Q?UQjJWSoMoi9XJuxgBEwQ1o5cRpB+Lg81uA8p94FfxMyJoSWBOv6hBohFsMSI?=
 =?us-ascii?Q?yUMF3Tct2rVQu5UxBPr4iDMn1pF73DtnMZ/k/R323+bsWyibf9lrmW4t/GyS?=
 =?us-ascii?Q?8Tv7QzOGfWG3NP1MK+USc+ruX2ymwLU3sueZ4y6x47fMTG/muwVFvh2K/9Qm?=
 =?us-ascii?Q?y8ubM440qHA6eYPlencVdmwTlq1eq2NemgJhdhQxUgbdpEjF7/i0vnpTXdns?=
 =?us-ascii?Q?Uif86znROoEm0BI6BB+W94MseMcEk/jK1Tl5uBrzekevxqfHM353Eghu0v1U?=
 =?us-ascii?Q?vurstilAiuQ3iOdpUPogPWxxOvpG6tSbrf/FYENupJgq8DvEMDYq0ltECQl7?=
 =?us-ascii?Q?W4pNoLmNLha9tChAkeog3aQapNzgU4CtLQgRjYriLmdMyOlBUulGiBUAiqG/?=
 =?us-ascii?Q?tC1Hf2OdtXRcKY2M7x53QuOZVfGempXAj03HknZZD6ttjrEYxcFTQVVH6DUa?=
 =?us-ascii?Q?ncHNjTnn/w4di8lpRMWpG7kP8JK9naPYoFqQ0CNCCiFFpXmhKHRn3bYNxHGu?=
 =?us-ascii?Q?ZsNywbEX2iar7qBrVYMRAQI1WPia8HMe1iAtiaq9B64c5uaFKFiuAL1ikKsA?=
 =?us-ascii?Q?56i0033eK6O8DAyPhMutlDIzj8n3iH5QFRzvXq14OTVcQy7L+eRSMYGahdot?=
 =?us-ascii?Q?IDU2WL6n7gZ+I+Zw7fIiR4rtYn4ja9IgC9OhjjYNHutfsuF19OWXzSXjVy6m?=
 =?us-ascii?Q?bKqLf570V2VYr45MVY1DEiPgk84+qSsOY/UUG52OD/lgRB7C5P+ejG7ESIjV?=
 =?us-ascii?Q?zn4NNCsXsDTUT29xZQbo+3yuNrYrHZyI5UWa6A5FSK9YR7hWOsf6EsdO9O+Y?=
 =?us-ascii?Q?HTC1zU6pRwwqq912USoWHTo9FVzX+cLAoVnK47JX7rBrGVR4tiNjKasvq/Ro?=
 =?us-ascii?Q?osHHc3Jrv+muQN1RbxO8k69hmzfSedoLljpSdrFB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f70573-35ff-4d50-0624-08dd4d636e64
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 01:52:40.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKKd1gQ+53QfPcOnvatX82q6pJkHWj+TCFXL4CzEP7JO7IWzKH5j1JgTGOfUxywm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

On 11 Feb 2025, at 10:50, Zi Yan wrote:

> This is a preparation patch, both added functions are not used yet.
>
> The added __split_unmapped_folio() is able to split a folio with
> its mapping removed in two manners: 1) uniform split (the existing way)=
,
> and 2) buddy allocator like split.
>
> The added __split_folio_to_order() can split a folio into any lower ord=
er.
> For uniform split, __split_unmapped_folio() calls it once to split
> the given folio to the new order. For buddy allocator split,
> __split_unmapped_folio() calls it (folio_order - new_order) times
> and each time splits the folio containing the given page to one lower
> order.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++-=

>  1 file changed, 348 insertions(+), 1 deletion(-)
>

Hi Andrew,

Can you fold the patch below into this one? It addresses the error
reported by syzbot at: https://lore.kernel.org/all/67af65cb.050a0220.21dd=
3.004a.GAE@google.com/ and the concern raised
by David Hildenbrand at: https://lore.kernel.org/linux-mm/db77d017-4a1e-4=
a47-9064-e335cb0313af@redhat.com/.

Let me know if you prefer a new version of the whole series.

Thanks.



=46rom a6bd83dfbb1143f1614ede4817cccb1e8cc6290d Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 14 Feb 2025 16:18:24 -0500
Subject: [PATCH] mm/huge_memory: do not drop the original folio during
 truncate.

The caller expects to handle the original folio itself.

also make __split_unmapped_folio() never fail, per discussion with David
Hildenbrand.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2eda2a9ec8fc..87cb62c81bf3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3292,16 +3292,12 @@ bool can_split_folio(struct folio *folio, int cal=
ler_pins, int *pextra_pins)
  * It splits @folio into @new_order folios and copies the @folio metadat=
a to
  * all the resulting folios.
  */
-static int __split_folio_to_order(struct folio *folio, int new_order)
+static void __split_folio_to_order(struct folio *folio, int new_order)
 {
-	int curr_order =3D folio_order(folio);
 	long nr_pages =3D folio_nr_pages(folio);
 	long new_nr_pages =3D 1 << new_order;
 	long index;

-	if (curr_order <=3D new_order)
-		return -EINVAL;
-
 	/*
 	 * Skip the first new_nr_pages, since the new folio from them have all
 	 * the flags from the original folio.
@@ -3396,8 +3392,6 @@ static int __split_folio_to_order(struct folio *fol=
io, int new_order)

 	if (!new_order)
 		ClearPageCompound(&folio->page);
-
-	return 0;
 }

 /*
@@ -3491,7 +3485,6 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
 		int old_order =3D folio_order(folio);
 		struct folio *release;
 		struct folio *end_folio =3D folio_next(folio);
-		int status;

 		/* order-1 anonymous folio is not supported */
 		if (folio_test_anon(folio) && split_order =3D=3D 1)
@@ -3524,12 +3517,7 @@ static int __split_unmapped_folio(struct folio *fo=
lio, int new_order,
 		split_page_owner(&folio->page, old_order, split_order);
 		pgalloc_tag_split(folio, old_order, split_order);

-		status =3D __split_folio_to_order(folio, split_order);
-
-		if (status < 0) {
-			stop_split =3D true;
-			ret =3D -EINVAL;
-		}
+		__split_folio_to_order(folio, split_order);

 after_split:
 		/*
@@ -3567,8 +3555,10 @@ static int __split_unmapped_folio(struct folio *fo=
lio, int new_order,
 				     folio_test_swapcache(origin_folio)) ?
 					     folio_nr_pages(release) : 0));

-			if (release !=3D origin_folio)
-				lru_add_page_tail(origin_folio, &release->page,
+			if (release =3D=3D origin_folio)
+				continue;
+			=

+			lru_add_page_tail(origin_folio, &release->page,
 						lruvec, list);

 			/* Some pages can be beyond EOF: drop them from page cache */
-- =

2.47.2



Best Regards,
Yan, Zi

