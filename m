Return-Path: <linux-kselftest+bounces-26380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ACAA31037
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75DD3A6ADB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339B254AF8;
	Tue, 11 Feb 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RsjMpRJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51A254AE0;
	Tue, 11 Feb 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289053; cv=fail; b=p6WQscL+KTEtbZk0ttt1x6tb3sMHIrg4pXV01XmsFInIIfsayK7LVRA+yn7wKHyl5XX6cIAEC+MYU+7imunFZEPUx4gQjzDHMoNT/yTQLv2a9BA/Z/ADLol2ZwllOOcVMACQKUHUUKTRwedbHIyOGGGQ/GGrafrntf8ecLUrvZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289053; c=relaxed/simple;
	bh=DgxIY6seS79SSMT4XyQwnkg1IbBC+RWMJ3mWU/dTl8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cW6dd0VGs4X/1mqA4bFJZui3ENGat7KNwzJ8GLgEN5Zkpu6lyZ6CgIJqT2vSWxwGiwLPZL7zBLvFpZ0/Yrl0DUeNDbRdVL2NX0/xrcskPynTwAjaB03XY8HRple2QTSlO7nqLI4GzO0oIq24qkUcrpaInQcx6CPanRALE6/c6+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RsjMpRJG; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPPks8wZSXGy5lyf63En28CUuwb/ezkqCtjWrKZAhiUvjdLhEMIhR/hYmD3epDgxIiHIzQqS2ieE024wamw+N6jloktaa8QkeENHrE3kK+J5RW01oWR2WTFVVtGdoIm1TbsbgjHzBpQME5gxOOZYlWWk5qKN/zXEdtEZHaAAoaQvsNzvw5uhFTrIjMJvkUc3Yz9gajIIHHrEyFvDqZBZq8PnFCyR1907nln1HFlL3RNbKN08SkExD7EE1iusn+uFV9RwHZx5HQRz8wCWlTWlxISsb4Zidjnzow0KIXbVwmqH2Bh6XAD0/jTzu/5geMJ+X6N7z0cNJbmeLv2wst/6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuOu3UvZiN76u19j7iEAZ8tEqhdU5MyeEFsCLje7ZZU=;
 b=xxOgz1YBMlXYPX2mG3qZiUwKwPL8ZcLgJRzc2XtcVYgZejl/lE9HpaJzzMLyxKFqKtK/Q7LxlEDPtNzdvSPvanXZy5jn6G7NWwF2c250K4RX8GPdMiSCmJzkQwy0mXSNxkys1Qfr6/miAifvkfDx9r9drL+TIUtEpDqgqAR7Bv4B0BR3RyesjEDWt0uudTe5FHq6Ns6GWrWji37C9DxuSY5fHN0S4TNDOAsmjlrvtu42LQv24mEuJKJBfsCpnSqRK8LfFvpt6bKTt7FohGVR2kNpSM727YabCfbXCFePqLljBg2kLD1gfG60kdTMzW4vaYgUdBzdY6GEHufJczGYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuOu3UvZiN76u19j7iEAZ8tEqhdU5MyeEFsCLje7ZZU=;
 b=RsjMpRJGQbUhmSuYhIiInUGttWqifejW1dbs1/3lCtHTs/8eeUjpGChkChn1Vqo5vg7ildMkqPNvCGNGkAw9zv45fx8mU4Pb/zO7iqWiCy6scOGJ7HOmfgREwA+ewUwqTi1MVwEAFC+Yb9ouJtFBz98fPoCpqQIQFF4Z9fbPO6H71Ki4SkgQIdUOO3cRbi8PSCutOeKaFMCdS/bfM+v8f0h9rlDdWhDUK4P6qtkK3Dq6jgXOSN5P+6c5/Ey9f6+pyS3yX4LkxGaJ/K2x6QRp/YJQ7YM4Wt/YmG0XP4jl+asOXSNbWNKH3MT0kptVm4im/uesf07In3jbcLOaZrkhYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:46 +0000
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
Subject: [PATCH v7 3/8] mm/huge_memory: move folio split common code to __folio_split()
Date: Tue, 11 Feb 2025 10:50:28 -0500
Message-ID: <20250211155034.268962-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:52d::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c7c332-863b-4e5e-3d74-08dd4ab3d92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ix8WiW0Ar+tDPTwzGDWmXL/KFKI0czkKM1l1zDxBvfLhzcFDqTI9L4acXqji?=
 =?us-ascii?Q?nai2qYtrLULWM3gfd8CDpT01npFJIyIZ5a9yZsSpP1d7GJCLOnS4IxQtx9jO?=
 =?us-ascii?Q?mkUSSPyXrAYUEAckv8xLiLRFJGbEuElFy6y02XCTIYXlDXFM3CfDVltA01UQ?=
 =?us-ascii?Q?RxFzTWyWxYDmWUPfxNZwY9IEe8n8qYej1AP28o6snJtYkitNT54ZeeUjUMFy?=
 =?us-ascii?Q?49d7MWzT4Z2Auvt4XLTFzzAqzt7YjTcCeIVMnwh5FlMYvTBXMOJvhXJpwvTi?=
 =?us-ascii?Q?BBQvUIOZGFvI9w3R0+RJa1UK2Tdhg87lVq6rM66qevOZibKOYMHIlQsKtmpa?=
 =?us-ascii?Q?SMhQZpsojvAql3KLsySSrOo/Nn/ASPpEm9pgCkf9SY7GBo+r52gswJ7eSbC8?=
 =?us-ascii?Q?RSpqhPIijOpJuRvF70zxv4Tf3lreNadVsXBYZeeFIeqPD566XUV/TR4rRNcj?=
 =?us-ascii?Q?J+96x+2wsxoREyyze6o5xIbAWbMX7MncSD0GVeKzzTPnTZHQcoim9fJckeJ9?=
 =?us-ascii?Q?rUu386vEv2Wf/3U6yzZLv5DAphECUvcvspGVKnmtlD0LH4iwSARUf5nHjO67?=
 =?us-ascii?Q?+nQ00D1n8jyk0e1K4Z5tH+bkJedy7O40SrbXm/Y/+FCGR5zkp7uIrLoIkUkh?=
 =?us-ascii?Q?hOijMy+4cYeXwzaCfFr8TKgK5FeD3Ax5rotYYgvX3g6y/7WhiMWKuqupUKrl?=
 =?us-ascii?Q?ZRy/kiyTO34OvgYly6vKMgYoLP3jyBkkIfEWvF6O3FchIFaZWCr4hQYgtA4j?=
 =?us-ascii?Q?WC/kdxCtgi8h1EXPAEPa/fvcOOXdtRO4mC7i3Gl+pWA5wPPCBBEPmK8v6+Of?=
 =?us-ascii?Q?EqbGQ8pSa5Bcevhf1Jk7Bc3nClI9qpsEnqUXhuwDTFtqAh1QjGq0plmxQN24?=
 =?us-ascii?Q?Ru4kc61SxBX+rsTdEN7Gorv1n5BN9zrFe/P6SX2mEWYvPuH776FjWEoZpOOh?=
 =?us-ascii?Q?t+/wtuOUj54UDKkNcQNXLFoyIzPbqbFOQ0bIaPfEraD7t0vxv2MuulI8s0nL?=
 =?us-ascii?Q?ixD7QAv+rtpAw6s+RTe7jCRBHJJdLToy1pTandMwuoUestLYj7yxl3YH+Hvp?=
 =?us-ascii?Q?x/P+VPGvDp3yrXjbsvxY1sUuF8QU8EoVwqnSLjRNtlS+QwzXMNmHk0Ahjncm?=
 =?us-ascii?Q?iIlN1q6AKkJQRbIPn6/9X4xniGkfrqvmnZxo5RqtjxqysUtpGjb1mav9gnWj?=
 =?us-ascii?Q?TUbwyPEs9N5v8fI38bHa3cwyR4mH1Vd8qfrnLpYwtBBoR+ViXdUp9wf06sHD?=
 =?us-ascii?Q?TSJ6rk8SZmZhy/dCJ67qo5ibCvzyUPQ/kTsWzIcek1p77O0S+XPQq2P6ci5Y?=
 =?us-ascii?Q?6ddKKq4vhOK6CQRUBJLNyHP7WM8GHA/8PIDUZcb+x5hY/W/0PNqj/ov5YZsK?=
 =?us-ascii?Q?wLOmPP3ko4lzKfEv65PhJHiMAVUh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rR+dqhMOTw1PlFJ0dL70/uf9Rm1Okj0BZcB4W4u0d3cSFvgdGUfbbhHd8/SL?=
 =?us-ascii?Q?zDjVdfRozIW2vV6dbB7eTFcaR8ckk8vz5b5InaMUjPTVULKfjIMwIuD7tCU0?=
 =?us-ascii?Q?XANLUPYxQilsva5awQuae8qgbChlit6OOwoBNWHUAJg/UTpB97cP7Egrc7+3?=
 =?us-ascii?Q?TJCzgjChfuRTYXaAvxy+Y58kQMpLfK8AfTV+yMCdTIv9jcNuiXrtQBVTG3Vn?=
 =?us-ascii?Q?/6+kmC/NneB1Do33969hrUYCOFL3xdtDCFtyxGkmv1v0d4Za3b7ewdJqXkcq?=
 =?us-ascii?Q?WIC1XPe5+GNG9m64KQj+L5+JtS5F4dtOblDrvguBQ8IEzNcyz7ucTO6EP7C9?=
 =?us-ascii?Q?dZNzyUMirQCINxUb14dlp0XPSVgpLleP8ezHiqVnVyQHsEv6UjVjPuqa2/hU?=
 =?us-ascii?Q?w/JFr8n0mXK1ebKKNJVoTdKmr4pttG1HHO0WSkvQCV8Tg04cmgp4297aiaS0?=
 =?us-ascii?Q?37SOyEAQp7OYMw65LDgzDP2GonUzRPxbBX6HEBaUysLgQZ2f96fv0dzzgWNZ?=
 =?us-ascii?Q?6OekKZt8UmrN7vHV/aoG70npIFxVlHs+/X0hUOCJU9O3l05ToL4T4WXrU+r+?=
 =?us-ascii?Q?QYT4RBeqb1cg3Drp5+Auz/E04GuWDri6JE3iCogzcRWwqvtSB6Q1yE/JHYHp?=
 =?us-ascii?Q?3NGmO1ll6KM+BzNVUrAqPD5lPixB4iVoBBZvsQc6oGQwtLbfl26z5HW7vm0I?=
 =?us-ascii?Q?w3wOry5FqsolpMoVUZcmBZ9/Cr5KLUdfSoLciSXiQtjv1BBXL/1CxaM500Fn?=
 =?us-ascii?Q?1BT4A1OX5kWtJ1fsvexqjZvS28pCsjJIPhkMqCyJNd4p4W0PVjWYh53w3a8t?=
 =?us-ascii?Q?kLBr4i/LxiMEIZ+o4bPfBqX7yKxbSbqDik4Yq5iL38pBGW37zy+0zZu26CpN?=
 =?us-ascii?Q?Xv3vq/WXk9Z22myZnRnzCrOuhZ+TqlZBRb05gu+rVCqUrdcM/dsQG0dt+HHe?=
 =?us-ascii?Q?cdi4SQKM/0SxzqYRHJPpWtY3SrBYWoyKZ92EP48M++oBj8X+lDELERvPoLYf?=
 =?us-ascii?Q?K0Tfzn2w/COtljGNac5q5aEmD02T6XM+Xn10zZJLEAO1tNRZMpJCztfzDaKV?=
 =?us-ascii?Q?j2GA2tLudtq/e+xD1IMt1a7wWifQnHanvXFLqufews78vXNG5oOrj/YywD/e?=
 =?us-ascii?Q?PkDhEDS+NeqTnMsji2rci3ZZbbd6o3ZaJdRMu72ZA2Gy9RdCel/3jN+ShGxf?=
 =?us-ascii?Q?u9desfKdFUQBmZYoxWItLx0h9PR1acqsrbJ6Nx6i++/FI61Q8i5IFt5XAdCp?=
 =?us-ascii?Q?NMrcdFw5uV5YLJiezeOtQC5nIlvZoClCM8kE0uoC4JifFHMBHx97j6ga5iQ8?=
 =?us-ascii?Q?6WVMVWFWdXZYpq2I0Clp9RJnAO/EPcyHVst1crVtyH4xC9JKE/YKbmCeDm43?=
 =?us-ascii?Q?VIuUK/gz0TdGoq6M2veKfMSsxTWhQMfd38szQcl3MTjOE/b+i+LzURofFHJW?=
 =?us-ascii?Q?tgJDYiNXyuO7ovzMWbzEV0XoOYDWXe8y/9YgMxMoe1LOeKnd152RX4ceIq7K?=
 =?us-ascii?Q?OL6q6ASc8a9KYqy9JSEGEr4lThHGKZ4/FC9WSm88hR1WI5f7QSojjXh9Sld7?=
 =?us-ascii?Q?E5FsO6g9vE9BYtSBum5mlRLmGmkLPZ/Rp/0NO9gF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7c332-863b-4e5e-3d74-08dd4ab3d92a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:46.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0O6OAl+vks9tdzyZeulQeyfu6JwpCAN5gVxYlGeA6ss4L5FVTq3YgTgJFxNz60Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 12d3f515c408..21ebe2dec5a4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3853,57 +3853,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
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
@@ -4113,6 +4065,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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


