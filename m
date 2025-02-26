Return-Path: <linux-kselftest+bounces-27662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A2A46CDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B0B1887853
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FF225B669;
	Wed, 26 Feb 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epLTx7zv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70225A34F;
	Wed, 26 Feb 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603654; cv=fail; b=LL9IzwWesrFNkgkDAiBYQDmv6lDRLZdhvQOfcT88R/jKvnbU159tday61sNO9FL5yN3C4zkLB8Mo1StHF8wFqqurTNjnFcRhtdg1NY3xPWNRun2r+cDRWgoTW1pHatoPL9EKzfNgeq3wilw9zq3NMwutOeCE9KFVW3B6D/FZCIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603654; c=relaxed/simple;
	bh=BXCYXygDQIKOWW9w5C6FYUYGVWw/MkXK8gchbYck3zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kj7/HseW1XFAsU46gEhUSKKGOMIjISigkEvGnPskAwF3Bwm8wGf0jKvN/D9XDpWRra0XWn/rYNtkdo+VAjRqwDQvn3AgcjcuW3Zbup9vcho4wZjqoM2Czadw2yp3EySkxTMwnKUFs7q5/Wh9cKQmzMn0Anx3wiAhFmlp74/7tTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epLTx7zv; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7pw7OJVzPCZi3UZoHJa6Nnr+QXkGXtXTQngnd2XwA7qfk73LbJ+SSWdlrY0SjZw8hOHU9n6XgL60+jvKu6cqOV5mOkbJE4GN8QJ30WiOLWIinOfYYz9V8sEvrhNySU4hTNo4y2fwasvaOqEN1zHzHGNd+vdHATEmCnlYbhIum2CDlGkB010jwitxeC3yW28GIkpOTsFKHDmr2HwSJ6FDAQ2Q1bZZ9SYmW3uU+7lMr1fP6rX/6w2S1d68/HbCJScE5WorLvQfRHLYIuQcBFPIasXmQVezxsrETcNSAs/tBfGvynfYgkDLChxKIXacRizonv8pgLQLqItFQM0Wl/dDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ApHuPDcKFEGsmaUJTQ/8XKSydEfD60ZBVJX0K9tO/g=;
 b=l5H2syaEsXBJa2JT5wEaKbRQJRu8RoZS/YupctNjQYE6ShXNf396h6hsX4MCgxOGmYajAVwn58UrW/dK3Tlv3Yf3Y0E1Clp9nxU4PtNqQb26wYxrAgj/CBA76R+tvN7XLnd1Bc/L98UTb9F/WA1GGuiYrot/0XI6xTsgsyMBfW9kYbmnyp7ZS1uD3Rn7M5B1fR9253rfC08BjjGrNZoggck+J4JXNNF3SMdAjtwWgLBZRGfZCXQ1FfpsIYCLEITIqxmgyqeVTrt51pvmY3EmPSYlpNLs0MLndxfu9uFfy+ELgXAwujmltu+/4KxZtdpqlMAuvifb7e9G5iDDmhxxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ApHuPDcKFEGsmaUJTQ/8XKSydEfD60ZBVJX0K9tO/g=;
 b=epLTx7zv/vJKQkO+WOVnSh8DRrO5tF2b59U1Md0KhBA1dXsoQzFCfmXgO9DDQ9YbnlA/mew2dJjgjYsoxdzH8oHZ0v+seHzQM9R1gArlhXo+ddKPtGJZLM32A6Yq86rJj/HkDiM5zKnQhWDpECHlIQ6oSiTbzYh6xgvwOlohds8CrEFbmBJPkdSa+seMu6KY+ga2cZJqzBSj0SG9AYyyXAtmkgBj+tkAJrtUmwsvVaFLTuioxgFBl06qkWO3VCF3OpEE/tcQMufxI2qofimAjcEJ1/eXvpAlrqGJZCKP71rH2rjGdHnKBI8ZqlHrKObGlivM1qdDm3zMo2W1FZW1sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:43 +0000
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
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v9 3/8] mm/huge_memory: move folio split common code to __folio_split()
Date: Wed, 26 Feb 2025 16:00:26 -0500
Message-ID: <20250226210032.2044041-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:207:3c::37) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a7e18e-786b-4733-4d1e-08dd56a8a22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iClvwbDDfof29q/cyT4/TswGTlhLGC1aBz7hwiwzVtX8G4xayJGXs3dC7vi?=
 =?us-ascii?Q?h0OaEGQqmUMCSpMYw8XvFCu3NkDOecG/iZx4Awnee4D+uwCiDBRkCeKYxwGs?=
 =?us-ascii?Q?Mbw9VDY2sKoGxqVybOTCahhppIjskcNr85XY8fE6HGDI8/eDkndOx3pYL6qs?=
 =?us-ascii?Q?ff+GMGJhn/DTV1gFflIWz+hAz2JiijuuIuyljy4BJ+sJfIzUOhrBXvYmHzVc?=
 =?us-ascii?Q?SWLyUr37ewet+PChmTrbNY+1/d8On2e9xkAKc8QTAS4+ERBQwyVtLuGox+YV?=
 =?us-ascii?Q?XXbm4Kji8ayvFkaFgVrw43M7ArgOQ17GUrReyzNjcIqsNnhh205SH8cJGcc1?=
 =?us-ascii?Q?KfyfdTulOP6A+o49TK+Mc9C3rJaLt/mrZ1YDY10nZHPU2oJ4/cAzWMKt6I+t?=
 =?us-ascii?Q?Z9CfUxHjXqEXHCRt90DpEZfD4tEoWuCwZp64wkunnAtRjmRGaiBG3H6YnIfx?=
 =?us-ascii?Q?7B0HS91rrOzO4OKYIH6WX76M1zy8CKEfF/MX1Du12UYh9y+m1wDkzYYJIL8v?=
 =?us-ascii?Q?+nMFY6ixAR/IxKkiggZAGijEnff45aIIIa/FwtbVWbhtARtzRSfj4EX2LAW+?=
 =?us-ascii?Q?aHUwtSMpuxSUVir1KVPnSmXxOsR8r9HRaipPJSttRm7FNNgwvRXBPKoPUl9E?=
 =?us-ascii?Q?GG3L1A+NAvkVoC+0JpD/A15uQE3hWs3IuI6a6deS3X7nssOhfV1iZJ17I7cq?=
 =?us-ascii?Q?rKtMi31VCmsRJY0+VfZawAMIozlEf/HHHx0m0reWwLZ9DXsjVlanWxGpLO0D?=
 =?us-ascii?Q?fKFQLlktQzExMNTQ1kTghAnReyEVixzOzMIvUKagK+QnS8PupiYnL7mEejWk?=
 =?us-ascii?Q?7uWXYRGy14OHh3kTJQSmfAwlPXJMAx6I5WsKV4xsOehjVj98vXzU22Bn9Jil?=
 =?us-ascii?Q?uZxOt7OgcbOwlX4VADWx+VarY7cKrQCzLC/lyNBKMWE4m7u/yVoExM45/LQh?=
 =?us-ascii?Q?0ck5OeO8SOjdm7/pkzN4NpbFcXBvUA1XExmFVSjPPErbvOfWsroB2VszVfFh?=
 =?us-ascii?Q?XyN5lYEI45YD3mUKlCLLmDzUTZAK7+iwlWZdo0E+mzX/fdlueZRrZI4vebqi?=
 =?us-ascii?Q?SxfpoPOnyiGb0X0ilwi8qtb6ONnAhxsj07H8+hA24CG8rarBnZVono3UbBMp?=
 =?us-ascii?Q?m3rFqpe3VRERpCe7MvXpLp8mB5oz1nK1u4VJygL0ablL5IfqCKWHF7VRf9xl?=
 =?us-ascii?Q?twYtObUBNwkNvgMwr3PpzLIX2x6QjXfUB9dcLcQ2xGWjZTGX+8VW1lo8tva7?=
 =?us-ascii?Q?QVUFxMdWERIfZlZH5SXInnkU/p0ulkdWRZKz/lF1o/j6GwDNVgDPr+G1IDqL?=
 =?us-ascii?Q?zQEeVRgB2dWezHoD/MbN7eh8ep31mXfFodk9qSHzoIX4gmIs80EjxwkXKUNG?=
 =?us-ascii?Q?wN/a+lAUDiCO8gXTnEfzvCAN6+rR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0TZ8e44he/za6EkZxte3kZDewz7uTHCLe24OetO6DbXiEOb6nlRho8no9Txh?=
 =?us-ascii?Q?Ln8Ktf6FkIxDZEqsFlyBFHgexbY+HmjDb8z9qQREA5l7hbpVYw8cmfoCAgud?=
 =?us-ascii?Q?K3BzRFeem00FyNSDdqi4PnyK7kJ3g0jW8DljmFXswECEhCYN40EB2bZ0QljO?=
 =?us-ascii?Q?kMG44DxsYcU89e1187M3v5Qdsiz9BctVB1FytOmizrntsaIrZJAeGhzjeLD6?=
 =?us-ascii?Q?5UmRajgK66h1Lx0iRV0NE2CKW1CTfOq3QH/ZGz7SX9XEsYTWYG6PqV5ygmcQ?=
 =?us-ascii?Q?C5vf1XZKQhBd03xpBcMXZSs2sMLPXZuBADmVUwEWXW4DFheMFiMwLZMemOjJ?=
 =?us-ascii?Q?WJJBHQYx0iTQvKK92cyej8CnOhiCbc33jKASmbj9ucDe3bHYJwyFEVaUfps3?=
 =?us-ascii?Q?XDA7rrIYd3SX9V+qwMLfCL3NV4VSDLrNlITxqTHsL72/bf+wJS5SMOXlppd/?=
 =?us-ascii?Q?PzsqXyPxN5xzL7M9RFbL4x967hcSKIMgX/R+hUYewr2EAqGnYb/tBopnM0z9?=
 =?us-ascii?Q?eseOyoh80Y2aPTvhIl7Zf3i0E5BWGGemMO77pOpHl0OZ7ZYUp4TvrAsm+Htc?=
 =?us-ascii?Q?IDplAwZ0yzLl3M9QR0C2YKA7lIRRQ+5my0DDFHS4MnJzv/hTfsbqL3o4g056?=
 =?us-ascii?Q?FFEzetqaYV0jfgaqDY7y3pDHr++1sCTTYoYv0zOIENJb2MT3nIFVS8mZiOOa?=
 =?us-ascii?Q?puCROVOV2MGrgu3CIluG6I6cb9rCHkTUHJ/lBPLfHYYsSKxxSdjlUtRjjgVl?=
 =?us-ascii?Q?kD15gzoq4P2CTRCGyR8+2dokYWrUtYmMjmJ69mBG6hepkYR4K7LT7VlV2myt?=
 =?us-ascii?Q?j1fhD0gDK0idzCtWd3GLQ2Yav0742iE73V/O9l4rsmjGnklptJns44NZsxcO?=
 =?us-ascii?Q?ozeD4p0eWyBRX0tlvcuaa9jBBc6hZnD8/yQxKsWt1eJ09cDgKz1xOCBZgdeO?=
 =?us-ascii?Q?lhOvxMbTCAQT7zDIRUoRetbaw8pVHqqcxmyPIew8G0pU/CJaSttfWOhAOqgx?=
 =?us-ascii?Q?7nh4zdwXfhDTbdnIl8m9Z9rT43YXlGdFU8KgbHgXj1pTOQA/oMbTJRsEvq2n?=
 =?us-ascii?Q?t8vrUs1Nub1OE4rfj10Rqlz8cOmOhjvLvTXvEnPzBAWPAWRDU4pSTfQwD2zD?=
 =?us-ascii?Q?B/MDvNuygHAsbC9HVCTnoOMrAE/O/omMC50VbZgr0Dgr9P2cO4qvs0w2hFsn?=
 =?us-ascii?Q?TRUwRKH2jyzhTNTwc663n84zSScty31zzDapXOshIVffRnHiXY8X8VNxHZ2m?=
 =?us-ascii?Q?ATUVglyhRe7pR2GoLzkOFLFXFm88z+/2xiD3oxJOgz8mW0QcE793wPe5TFDb?=
 =?us-ascii?Q?+IOpdk170NeQK1rWK3iQbZad5qCqgji25jFhENo6y4fDG9UK8IDXl5y6kx8T?=
 =?us-ascii?Q?L4Jfli46IU6nbpF7SSo4seIyg6zppSM5H2FNT+tx97ncsrSPNG6tM9gWiU2E?=
 =?us-ascii?Q?40xvPV4Ewem85ipTptLqmLS1cPcFTgEr3YtGqYxOFK5H80q91etLSgUxrb0C?=
 =?us-ascii?Q?/yV14TgUOFSSW8pJVO6442n8r+xduswaaRTY7sGYTg9DfDqggQ7zTIw8vUwy?=
 =?us-ascii?Q?MLD6KCbLEDgfVdDAjOhEGOW/Dbyj29GH+NWA7+ZH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a7e18e-786b-4733-4d1e-08dd56a8a22b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:43.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPs4Bdj0Ac56WTQHMOvVB2MSi5QdCiZvkr8vW5MvbcHkj15IHP1ySyNr8+23S1vR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

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
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b0105ba6db94..4c79f54566d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3847,57 +3847,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
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
@@ -4107,6 +4059,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
2.47.2


