Return-Path: <linux-kselftest+bounces-26383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F0A3103D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAF3168AB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C85256C7D;
	Tue, 11 Feb 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TOGG22zX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B41253B73;
	Tue, 11 Feb 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289060; cv=fail; b=SfM/PgJ5iPMYLgvpuUKyud1aXdjcDwZ7viC0/H5BtSikP15rFOShQogEbKC9QWkhSWIXpML/lhlBbP7X4hF2w33xmQ9ZfBDFravbr7ziKX14hwPk2aM/nUorToeTJSAyzYctNOuEPP4QBIbJYv81AwYeAld31eShJsDCZvUFSu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289060; c=relaxed/simple;
	bh=s37hja60uFWjgwL27ebpMB3HnWuiUbSz89CNYWS1vTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dp5Xa07LBgqCwj0bZVmTtldtQVEPQxJJCE/ob/s3vA6hICjtz03VLKtvMJlTe9VtYwQ5G7yyPwsv1scdDnHyJrzKxk36C8HEqeY0Wk4+sszvO7A4uwjC5OexUOHBPs47NcvJadcpF+W+SYtfz7S9NP8nnZWyp4hUYbNZzjhXhlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TOGG22zX; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZB5Xfy+GLQw2k48omtzo/P7r/UDK4hEc6z3x27u7ZFzhGfsR0tuaEaASv/QpRDtv9mzXgtd+sM/gChpPvEs/4Ntfxyeqs8yKYv71Ci+DAEfQ3lBDyG3sHOmKuu0svWT2cmmFQzKUA5ms7Rivubo9Ogm+YsK8uXfX//882uf0Z7oAoIfPYg49o87Xv/4cpOcCf1i0KOJVHxnjsIyyF0TrB19MN9T2ZZUWOE1gCVDajV8h6X4I96prSYgpxIrDSfXWPuOmPp5/Wv1AzCmjyC+LnWOhz/vmAIbkwoGYGvlblcG/n4CN+6zUb1k8pgE1Ssv8apEnXsdJLoMa5nIwdIURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClSYVUWbTTC8Cb82lVfmu47Qu9TQA30MyMEQBjM2sHI=;
 b=GPqkLiBu5OlqW0EP579c4+K+uH3J922Xs9CVdmhMRHAS0Sl122nv9l4NFJLPgScnn6JmNOQ1Cz6IWInatUZyJ2vymaE9AoI0btSZZyvQuxu8HP8OwJ3l4z9o0QfFyI7wB8/siLd84WgfbKM3vBFKRB6hpzuhN4T8uP9i8UlG1BUChAj5M5wL+7VgOj4M6Zt+t9JPgIkL6a4Sb0AOqMF5AIi+Je52+jIP4WATPAjZRCwZO+uaR7x+yA+Yq8vwB4RnVP8gKPlPmeY57qvp/9ibB9kPBrThXxuUUfiZ5dI5aYnB00hsQN07zK1HiFM8W8CH+QMGH/EdIocvr8BDTZl/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClSYVUWbTTC8Cb82lVfmu47Qu9TQA30MyMEQBjM2sHI=;
 b=TOGG22zXB5JvGaTIHIXTDbucvpu2Olu/uFHb003ao0sdxLL49KreI8tz0/FgmcVz8AnvMbYVVPND3BmwRFrEMD2OZIj/P8Jv5ZKBUjT+sca5R4FX6ofDsRKPDc3C8MJLqk1ZwOeruQOnsDe3UrVBXLiAk2Xn6nKVycSJCi/gdQpVIU1sgDr2j2UE9Vz6NHVsCFQJtTN1cykWDtzARLSCT//sWnf45ywi7VcNIIyLPDgP+x9pGuASSkESyyi9UevKK0lT9+adcJtwZ1LXdNcYevdlO24/NOs4SSPxD4YRPbuGw8dZI5POKchPfFNqykYKiAbwc0G8kkDfI7rodUGbTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:51 +0000
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
Subject: [PATCH v7 6/8] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Tue, 11 Feb 2025 10:50:31 -0500
Message-ID: <20250211155034.268962-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3725b3b2-7cd0-4a7e-0fa1-08dd4ab3dc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRcVFCbGGH6G0aq3jdHrIS+1p174g4xM4DBw0HsqUy3dGKLD+tXnnO6PXIKp?=
 =?us-ascii?Q?Lmw3tsj/Sj27wL4fWfFiBGX5E9hcDCuFATApQ1q45+Ld6IUlPF92Mqwy3ZX+?=
 =?us-ascii?Q?xVPwVR4YDVKOz8NKk3mUE5bQsdps3LgtpQDtybqKHD0zl0eg4CXNGM7XxiYd?=
 =?us-ascii?Q?50nA/JLqUmZwOgVHwIltwiLDdf9itBh6VVjyrnVg4rV0JgaWt/eyE1b+wpsJ?=
 =?us-ascii?Q?sRhnmXZehK1if+cX4KT1FGeNNOib/EZTpWi+I/p9g6HOKwcPXlySTeVVl7Dk?=
 =?us-ascii?Q?FnNqR0K+VyEHoFrMii2DUVqHkKnUu7My39r1QmDw7NnFNiIW54kmnG743yyV?=
 =?us-ascii?Q?caYsWvj64f9H1Oo7c90HcYKVipIN95AW7wcZRsSGa4qdbpfsOwhUo2Fm8h8u?=
 =?us-ascii?Q?HVyrHXjzQP1ICZGTN+SCEgyMHxhLvaBVsKfQS8dZBuC4Hnfgu2HbrIEtM3Wb?=
 =?us-ascii?Q?b0Uz9H8IQp4CRgO3qtRrOFPTzV5z6wzLbeOtrlL8Gn8/zDr/yupnnXydPgnn?=
 =?us-ascii?Q?ew21wVVfxRISqk66c4zPB5iGYd/pUFt5JWTHgXd8vs4RWWhGtSiPrQZpbvPL?=
 =?us-ascii?Q?gB7aDpXDYnQXKGA1ewSH9RVohBYtZuxchMDOFo+UhXW9IMT8keIrgoTj4UxT?=
 =?us-ascii?Q?RDtidj5AjxxxSTQ5fLvkAlzChPMo/abuDQeXvv2eM5xFCTu3pMTwyyxrFglP?=
 =?us-ascii?Q?LYwq+KzB3f5Q2eGXyb9/2B3h8iUzdWa/hx5CZhsmJJ7DCSE5O5VTklLZk1li?=
 =?us-ascii?Q?9Fu3b5w7NbLU3fCCdWCGc7mn2hIPmpUR668amrIpOd6AWu0xVGPL1sFu7uWa?=
 =?us-ascii?Q?HBIOKoW/xr5HuosYUM2HH6R++yCIZoJpz3m7NK6TVmw9j/R5zYoB3zVeiKD5?=
 =?us-ascii?Q?lAfsltx9SY3RX5ploklgw60rb3S/PFLA3A4sVaasL2GPxq1sOyXJSFaRa1+k?=
 =?us-ascii?Q?1qeuFztwByjPuF6Y0UyiuurpFJdYLWJVVq4NFrpf+CAo0KxV/nmvd5UwZZ9r?=
 =?us-ascii?Q?9yxQznsDDAuBiAiwv+ws2OvWnXEXT2famyjU68SYKFjbGotL2W2Lp/Z0qe0F?=
 =?us-ascii?Q?/pBI8S5ovfdF7rvOYUC8lllBnVRgEQNkaz1NL65419aNEByMPbvFZQW4Jdpw?=
 =?us-ascii?Q?rkugFHauLsxCGCfJ+JQ6meXNF3ZalYKTjkJn4ZBmpdOymbN9jIqVCWERdiiO?=
 =?us-ascii?Q?HCSlvzHj4aOKctkFlHyyqjLLYRIxbAugkJwMndrhohbwy/j5zgCRJPn8+18P?=
 =?us-ascii?Q?t9I2Ud0N/X1YGZ0ykdqDARb5ly49XadUUSUc0xJaDRyi1PO7k6AKkFVyVyWd?=
 =?us-ascii?Q?FsDgY/ejbUCdh88rcQWddLPwLcEGQVNuLh6p4w5joFktoxE1iUIDDNwqOeZj?=
 =?us-ascii?Q?Fsi7sRqJYVvsi5s2TkcGtH5pqUDx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0qXcs6rUwK6CN6bLu3rKlnbgB/8j1BF5shXiGwUpbsdY4ZNY+MxP8dc2iqjK?=
 =?us-ascii?Q?7HzFop5mXee/lSaSIEYumR+QrtRkdlnaNWdTYgmIGDfO57swWEpYEZAdsL8t?=
 =?us-ascii?Q?Uw0LMQVHjow4qDyFbviilexVxTp2EjB0l8X/K4spuAtoUCqHA9Uv/5Uz+yzA?=
 =?us-ascii?Q?9EOJNttD+mWkJpoTgqfeGAvkrnuPx5UA98NAzN6kLH9/Huhbtm4od59I7hSp?=
 =?us-ascii?Q?RqTYEs6Ga5i5bQYhY/tgXNjrM9zGdangbMunl5hNsQILUZMBz+3GnsAYt9RO?=
 =?us-ascii?Q?HwDOgbGQQip+8WEbGs2b94dLCuSGmVeL17Lz9INZbdFnCNjPNtM20ONxcrMW?=
 =?us-ascii?Q?yccvKpElFgpzDN1IQ71UbScCrZ3sE0UxFvFVTOredrzdnxv0CyLKZks+9+MV?=
 =?us-ascii?Q?DRBnsYrCbDItxobWXAaYMEGRbfvjvc1/66n0TtHAaONiUY+hQlOUA9KuP+L3?=
 =?us-ascii?Q?6KDDDlX6+Q+sSlV+Ly4NOIOU3TaWAV+LQvzq9MZcicHNtWoltvGWK5IMXjyX?=
 =?us-ascii?Q?mgmsiGpPFuv4EC/B15jP8kQQq7zz7Z32qFf+jMNZq3oyE3fe8EHxPekl73WD?=
 =?us-ascii?Q?B632MFX5rdOXk/OJ4mfk7trOZuOH6bIceZVzaLzY4PE6/euRszG9bGeiwBn5?=
 =?us-ascii?Q?2yecT03HqFbDFhxqGJJLv8ENp7tW3MRC9WYLNj+uoX9D+zFlAX4bgx+hLsHI?=
 =?us-ascii?Q?OwizHcX3uXIK8yE/nm6sAezFXCFfkVULc8WreBbNhhCQ3L/EcHpFvEIGppAl?=
 =?us-ascii?Q?JcufGi8aBEz8c3DDlNQmU5TGoswtDfBgTC4JFa/mm2tuUWNb/rRkkhD+pHGv?=
 =?us-ascii?Q?aZmhd+Y7M3OJxwOgi0laVaDpMSnLQBBFHx8Ke/SWgWm0GPNOjUHnpuiNjIKd?=
 =?us-ascii?Q?FegLimInBFXc9eTZMb1pXckBjW3Ndlfr/7Iz6ItKfJOeHVKQuTzSrrYC6vMb?=
 =?us-ascii?Q?41yBHDJv59igZAprObfV3mDqNH+IFADM0dTNX4i8Ib4aDZx8DXU75YhxXS0o?=
 =?us-ascii?Q?lX2KJFcPH3DhW/Ug9095T5HPRmu2CYBUqWiBBDXKugFe1vq24sjX91rWvC6z?=
 =?us-ascii?Q?knv5x7eGAvoST1AZnCUSH6qjcMjlk+UtrUkwAQAZCR9lrXish9dtWtxSs/hi?=
 =?us-ascii?Q?McY7xCykZKiOrbbCCdSUtR0h3hxf8n7Bu7LqiV8AYtJTOp3BRC4OJwoskm5R?=
 =?us-ascii?Q?oDvsYcV31uPTZdoEYCkGRVp8zDh182O1RcSHSddP7v5bb4S5EHTPcC0FLWy/?=
 =?us-ascii?Q?iIjuugxZ9vFV84/d/+rZ1CeUpY/ft/A/80ywApe2szJWjHSB/TyPM7dP1tve?=
 =?us-ascii?Q?d99DdoH0XHi5DPniCt7PvLDQAvOb4cOYo5v7VBUInIIUxPEbCYyfiHG/0Kbt?=
 =?us-ascii?Q?clIaDIhF3NtcRdqYDE/5WY223VjwuFh3g94YZ5SFNJDO0SW6mb2PMwfzV20+?=
 =?us-ascii?Q?C5gx5JEVKIN/tAtyk0u4qiTvgHpmhoGicwTuBDEBH2UK4BFztp2N5jLSvEln?=
 =?us-ascii?Q?idxGH4xC03qyS0ETsXK4C+9mPK30N09ezFlW5KdG7jJRyzLhJ7FC1UZhSPco?=
 =?us-ascii?Q?6XqI2FxfqHRoedl3TaYCWjalKBG+hTIBnRyg3VuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3725b3b2-7cd0-4a7e-0fa1-08dd4ab3dc1c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:51.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5q+6AvML3XjQjHy4HY9c4zZWYsbXtB1noVRO3gIL87yYMQxbj5tIqhJ9lK3feu6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 437d0cd13663..05c09b791676 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4295,7 +4295,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4379,8 +4380,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 ||
+		    in_folio_offset >= folio_nr_pages(folio)) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 
@@ -4403,7 +4412,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4452,8 +4462,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 		folio_unlock(folio);
@@ -4486,6 +4503,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4514,30 +4532,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d", &off_start,
-			    &off_end, &new_order);
-		if (ret != 2 && ret != 3) {
+		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d,%ld", &off_start, &off_end,
+				&new_order, &in_folio_offset);
+		if (ret != 2 && ret != 3 && ret != 4) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end,
+				new_order, in_folio_offset);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d,%ld", &pid, &vaddr_start,
+			&vaddr_end, &new_order, &in_folio_offset);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3 && ret != 4) {
+	} else if (ret != 3 && ret != 4 && ret != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order,
+			in_folio_offset);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
-- 
2.47.2


