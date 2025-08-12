Return-Path: <linux-kselftest+bounces-38787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00425B22CD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0843B25F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14272F6581;
	Tue, 12 Aug 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TgY0Bwag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822062F6580;
	Tue, 12 Aug 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014141; cv=fail; b=LkgQPsHOvu5VuF0gw4Nx6bbM+su+t0zZYC0p4wqv8QKQB7Vi1FL4CCYUxMpS2EanEaTwMf8czul3A5a2XpqivIwHrKHz9nfleJrA6e/0TZQne44DMCHuSIQLSWWzaihJT4BtIIgLUVzagov+SVZ5ufnXRhTsQ7qLtKo9Z/baax0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014141; c=relaxed/simple;
	bh=r+Ip1rfBAaAaeuBKinqkSPzMmao2dUMUraoBshRvIwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RI9cLTrZp0aSn285CEKZMu2N4krF5cw5TwW6Mz71NeCjrsRFZ+/FiQDE56MQQbqVAlCh1yNpi/HLF/SQZrHGb3fSMl1HJOLFYwk2pHE9qD9dPDNLy8B3JurLskOu5UtLDY99iR2JDVVySw1imwLdTUW8SFvHaFOx/ai6WCE70g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TgY0Bwag; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6QdhfjzIQyTKWg17ieN3EI2LO2iNS8nI+nxD8x8hDyfOF0tvEBw3PlWdB5g2dnKedF1li3E3TLcd1zX4ACpJk81unvWHjAAzzKpf2+1xRptn7tkMkSBMLlZAblMtqOEhfyE6bhokeUtN2YAh2ft6OBN/k5uVfNEbwed1gCQI/I4+0KkZCj6xRfgJrLAys5Kf+ckKvF/ooe+/2UNDsQxBAkE5jwYfgl0OTBMqMdXl6Rd2lUlL/7c1z5Ox2qSuTA4B8za3ay5a6zgLvwefqZ/OS50G9ULhXQIzYxzIaFMV2l66CiLJp7yiJ6Jqds6HlMLCes1MxnQjmHzNVH7Q5jCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDnWZaN5lDYiCS8c4E3BShOduiflG41zPWvj5Ydk31M=;
 b=rvVl/n4iLcQea5HrLmjk2FetxaiER5R6Bo59Z940p70svx823sEBlzOGw/pCYO6r9WjrPvG959KprIRW84neS3rGTX2vg5HDPQJGTa7IelSe1Hf4WLzsqVlosGb+sZiX6sOVVxnHaZHOT+W6i6FUg7/E+3wkFqPEdD3Y9AY0dxxXk31UPGpjMwSBBb2N8iukJlrkB6CUh8bxoNzpj0bOrLEDLu8FI6HwenUWsAq1u6DPM1ODHtHbeXv5IBcbvYirTx+vsCwgwQPwQremCWei6ON/qLl/HYU4gx6502COttEySaE4Sk5P4FjkYiAoX5CUACtdD7pt2vVeBv9iiEvZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDnWZaN5lDYiCS8c4E3BShOduiflG41zPWvj5Ydk31M=;
 b=TgY0Bwagy8exqinlsoJlqLK8N4RLSiwOFrZ3RyPtaMaSPVkc41jmkLp/6DnJTUY4xUiRSRGiUvnR9J1zZHjxmGdga0eFSfRYO5K2AcR7O4Gwur4T2WxuQ1/Vqasvqfu0zNszHucya9Wmp2ltlSwX9TnBNUy6S2Ww1dIebo8oJ/iC3u38grPYmRrBKE4AHBRXgUXmFHP+CtiY92C6rIhARCe7OO4SX2hd87XDrTzt1knxA/dWA4KeQcPEhkXY9ojFMPNzUYHbxluVDWZQH5D4dmxnIcltRsnqhYvug9ZuMg4hEq/v/QokvBH3/8adDKoJlCTnUUC11cmMdBzsQsVNNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 15:55:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 15:55:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>,
	wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/4] selftests/mm: add check_folio_orders() helper.
Date: Tue, 12 Aug 2025 11:55:10 -0400
Message-ID: <20250812155512.926011-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812155512.926011-1-ziy@nvidia.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:208:2be::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c21c1ce-bf95-4f79-1ac3-08ddd9b8aa6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VgcjAu8Ci0EreHtgbFrXoJNUOSAWcM1iIVs0CEgK6Z2i6732V7yW49tHuJ5W?=
 =?us-ascii?Q?2ZwDf1sAlzaGHYyU3G0xuNnSunAPozyqZO2LKmgVmnRs034vh6gA6u67i+NI?=
 =?us-ascii?Q?F2D3CF1uQUQ18s8Ov8psCCZ5bdeLsYPpDyfz9WPYsavMp65qaBa3r35KDKdQ?=
 =?us-ascii?Q?a2dEUmB7eYrNaGJbUBE8159C+zotUgNf8neancj/W1h78mbzhvXSx58kmozk?=
 =?us-ascii?Q?s8o54rW/a0zoSYeMYHQ8OiyRMOIY5i9I+28gcsDirgTb8JpQjYhBBP7K/XK3?=
 =?us-ascii?Q?CE4rxYSlSmuoqRGludr4+8dOGTUVXaYDfTKw/w2MMtgQJmfA69csKJUchEl7?=
 =?us-ascii?Q?GY30ZNWGx9O90jV7BZfgoLYqK31gxn818Eg/B6GxEYAQ9X7gkKsGCpdDqmHT?=
 =?us-ascii?Q?7ZE4L55cU9bFh/YMvt1WQ1ROTgWdWXgAwmg7idsHFNpeYN0vBhR0M0xKHO0S?=
 =?us-ascii?Q?TieeGdHBAgK2cSUTy+E5qJ/bip0amr0nd+QVHmjXAXC2XXEfJT0szB+vlUq6?=
 =?us-ascii?Q?BwTrfQwmtNZQyFxWDb9TutmCFoEyRf7DdNBJvlEWgkdknIk2ZBXsg+BZI58b?=
 =?us-ascii?Q?KNOFkXjXSAAbVWb8BT4IZLJ10TUcMPNmKvB/frM1SuchAvW0IWHYbC6sajLD?=
 =?us-ascii?Q?0VB+ppZR/kGYulXwdK2cvyJQTHik5kIEG3MTWPa2CaNEhnPM5zdi4Mj+8bCt?=
 =?us-ascii?Q?6h/95Zlv8kR0M+cqKr8oCQRBTPmH3wTXDaK1lXoKRMqgnfxnf3IM24qbdWgC?=
 =?us-ascii?Q?PbF6uIWKZvLn2IeZS1QH1nDkUr6otMjs7gjc4bt215Pghi87JwNjZZ98+TdQ?=
 =?us-ascii?Q?4tWFQwI9WnK9sF0DhiakWhTmG+J0VEn70m8fWcsKsqAQai/Af9NiDxOWUiIA?=
 =?us-ascii?Q?6G7EZDUMgLmfiPBb+xf2/A225n/CXXxpu6r9Vu3PkB3SjMdKdi2Wkffv22MK?=
 =?us-ascii?Q?ttQKQFg8AzFvOHFIXrXkc7gUgaACl4ZJkfHVIms9jaWaaVXKxKKo7yvC5jyE?=
 =?us-ascii?Q?zPTAinWlNCvGQMstSxrH8+cLLqf4kO4N22RxrIRvwM1u6eQl4nu33hOp+zeE?=
 =?us-ascii?Q?1hOahBBMH1x2c4x+59pPmh86Wzp9+UTaZrru18CGT4UGdH4a6aw8yhVoKPS1?=
 =?us-ascii?Q?2aNqOM0DHr7FWjvX19b0yBWjqB/SOXXNn32PCoeAKfZXQ3DhQD6hbLG1v0qM?=
 =?us-ascii?Q?/swgAZ+H7lAZ9zaWeczRkVwPrnj6xKW44ZLxeRHi372JQ1GY6HGspZV2XQID?=
 =?us-ascii?Q?arwzzaLU8XuxHXHjOmYJ5C1rnEzulFm7hsRk8E0ZS7m0wtKc3WDxycrKa6Hj?=
 =?us-ascii?Q?B1rW31N9joXkX79HZk0H+eYKa/ctSPzm0XVGo11wVJszpKpF3FHqzkTMgePy?=
 =?us-ascii?Q?CSF82jRv3aBxt5EJdAWwRNRwGBez7+vROJsmLYN2fprMF6/O4D2aLQai1VMv?=
 =?us-ascii?Q?5y7yryMnA+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdcDEgTzAe9AHKUMKrAFEi+fV8eehHp8Cz9rc/kLTAFQhR9UM18wWXuz2bBk?=
 =?us-ascii?Q?P6gKKAYe+UyLKHMUzIxEDf822+FlHhLDnGF5BCaXZ5GpYTyPDjmy5O01s8XJ?=
 =?us-ascii?Q?wNnSnxry+4WnoXerAo63V2UZA8gpHzhxcOCQQludLE4590aSfhFhLVGmOq0J?=
 =?us-ascii?Q?dVZXL/LW3546xq6EFSn/GRYdOJ961vNKVOKdmHWVRxZFDqkfRsrEDNdn9gLL?=
 =?us-ascii?Q?JjTdforu7k9lhGVuT0nDlx64XWpFvi0D65tgMY0+9RK13pdxNyrradhlJ9u+?=
 =?us-ascii?Q?pMJSbR/YM06VVcXahEU6pO/GvkBLprOTNigzORLRcnfFp24EQJKleroF713w?=
 =?us-ascii?Q?92O8tSVtQlmTPs69pVErzydU6RDRYPbTfn1eGvqUmqaRnuQvNc7QuKu/JRFz?=
 =?us-ascii?Q?tWxIAeGyRvkkvRavBSjZ0j7pb3kDvMq/78M5a1rb5EnP5bY1ZPrlNa7SaTVe?=
 =?us-ascii?Q?TGte8tNU8wXandfyZf7UM3s+CNYFCEZcVNs5ojF8ZdYoz5FNhlY38hUj37dp?=
 =?us-ascii?Q?hZSXFdJ3S0/o4Dv/ls7c4peohWHV4EbJBajBEt12bMR8/ZUHz3BdooZrYePn?=
 =?us-ascii?Q?HTjSmXPKvzNH8u3txd/uBvmGjyZ2pwf/HjWv5uiUculaikxnU16XgI5uYJ6B?=
 =?us-ascii?Q?0335RKhaArH7n/SHz8VK1NtK59iZMgXFsqUtODm5G5ecpfznwbPIeIaL9uTA?=
 =?us-ascii?Q?jhaHRUitzmoMvTlPebLbzzmMhPr2gjFcYaXMnR7hZ5AKOMIXZpVHeYGoz5X6?=
 =?us-ascii?Q?l4oRTzOKxdgZ1hihehn6HXKLnS+AOcTe6D6s34FhYzdfHqNL+M9tQbVuiWVV?=
 =?us-ascii?Q?FoTs+n8adUAXuuy3BLjFUovoB5pbdd9bZHktxRkGd72dQV6+to0tT1u4GOY4?=
 =?us-ascii?Q?FTCpe4Xgrj85q6TP4yas4pyt93P+Nm+U6lfF3rxXYrpmkH1UKgI4hp1sxZNA?=
 =?us-ascii?Q?xfpJNb+UcyCPn3Ja8vkJ/3iFvMcOY3xNvQEs6sZ14wu+Ss/rSaZT+TBCv5vB?=
 =?us-ascii?Q?3UXnpS/+KxBJsYXm2xueupNWvbFgTWOK4HccKFctLGEdmwDvN5Qh2HhAS9RA?=
 =?us-ascii?Q?7H7Q3VrO20Nvlyg1N906dWRxl1UJOJp5daaYvrCo6v2xApB9+UwyXnPotjTG?=
 =?us-ascii?Q?4TZYbxrFozp8NLt3Hzxuh1clvwu4HBK6mv5tvZEJ2N6FYyxNoTurqOirlma3?=
 =?us-ascii?Q?CRrEOLibxfrj4nYfrSRoF/QNKGRvRwhmKE6fe8BlOOH4ZJyM13nnXLYB6x3y?=
 =?us-ascii?Q?nibGLF3EFcRLyTTJFiRJK3aa7Mne+z6WhIb4yyQBe6R6AKI/mPBbB0k6pW6m?=
 =?us-ascii?Q?44xFX3K38/1ywtvJ7kFpfUp/Fxs4YCQdlBr3KA5p+Ti3PYZ90JJLKqn7hrOt?=
 =?us-ascii?Q?l50+vKbU/C+JumY7bz6JFF5/IeJ0CFfy4k1tL45KJ8SUenlfc352m3bJz8jX?=
 =?us-ascii?Q?XWN0SMDmMIFEqpGERqseI0CftKuwB2u63+8oYBa3Vd7ZOb2IsAQLQp2FRkh1?=
 =?us-ascii?Q?GDrY3K7u0z2ltBTOJQfTH8TzYpAeCoyY4avmx2+Tf0BY1V+XQYqvr9e+4VA6?=
 =?us-ascii?Q?1XNklTvj/5o2akuU48pVcw8iOoVXWKpa7n4ZIPsA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c21c1ce-bf95-4f79-1ac3-08ddd9b8aa6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:55:31.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdVOW4q6PCRNVnTXiPoBM03bgfOMUcdS/5gGglM9gcIC6WFXr+O5KQ1cT9PA4r5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

The helper gathers an folio order statistics of folios within a virtual
address range and checks it against a given order list. It aims to provide
a more precise folio order check instead of just checking the existence of
PMD folios.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       |   4 +-
 tools/testing/selftests/mm/vm_util.c          | 173 ++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h          |   7 +
 3 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 5d07b0b89226..63ac82f0b9e0 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -34,8 +34,6 @@ uint64_t pmd_pagesize;
 #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
 #define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
-#define PFN_MASK     ((1UL<<55)-1)
-#define KPF_THP      (1UL<<22)
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
 int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
@@ -49,7 +47,7 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 
 		if (kpageflags_file) {
 			pread(kpageflags_file, &page_flags, sizeof(page_flags),
-				(paddr & PFN_MASK) * sizeof(page_flags));
+				PAGEMAP_PFN(paddr) * sizeof(page_flags));
 
 			return !!(page_flags & KPF_THP);
 		}
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 6a239aa413e2..4d952d1bc96d 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -338,6 +338,179 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
 	return count;
 }
 
+static int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
+{
+	size_t count;
+
+	count = pread(kpageflags_fd, flags, sizeof(*flags),
+		      pfn * sizeof(*flags));
+
+	if (count != sizeof(*flags))
+		return -1;
+
+	return 0;
+}
+
+static int get_page_flags(char *vaddr, int pagemap_fd, int kpageflags_fd,
+			  uint64_t *flags)
+{
+	unsigned long pfn;
+
+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
+	/*
+	 * Treat non-present page as a page without any flag, so that
+	 * gather_folio_orders() just record the current folio order.
+	 */
+	if (pfn == -1UL) {
+		*flags = 0;
+		return 1;
+	}
+
+	if (get_pfn_flags(pfn, kpageflags_fd, flags))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * gather_folio_orders - scan through [vaddr_start, len) and record folio orders
+ * @vaddr_start: start vaddr
+ * @len: range length
+ * @pagemap_fd: file descriptor to /proc/<pid>/pagemap
+ * @kpageflags_fd: file descriptor to /proc/kpageflags
+ * @orders: output folio order array
+ * @nr_orders: folio order array size
+ *
+ * gather_folio_orders() scan through [vaddr_start, len) and check all folios
+ * within the range and record their orders. All order-0 pages will be recorded.
+ * Non-present vaddr is skipped.
+ *
+ *
+ * Return: 0 - no error, -1 - unhandled cases
+ */
+static int gather_folio_orders(char *vaddr_start, size_t len,
+			       int pagemap_fd, int kpageflags_fd,
+			       int orders[], int nr_orders)
+{
+	uint64_t page_flags = 0;
+	int cur_order = -1;
+	char *vaddr;
+
+	if (!pagemap_fd || !kpageflags_fd)
+		return -1;
+	if (nr_orders <= 0)
+		return -1;
+
+	for (vaddr = vaddr_start; vaddr < vaddr_start + len;) {
+		char *next_folio_vaddr;
+		int status;
+
+		status = get_page_flags(vaddr, pagemap_fd, kpageflags_fd,
+					&page_flags);
+		if (status < 0)
+			return -1;
+
+		/* skip non present vaddr */
+		if (status == 1) {
+			vaddr += psize();
+			continue;
+		}
+
+		/* all order-0 pages with possible false postive (non folio) */
+		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+			orders[0]++;
+			vaddr += psize();
+			continue;
+		}
+
+		/* skip non thp compound pages */
+		if (!(page_flags & KPF_THP)) {
+			vaddr += psize();
+			continue;
+		}
+
+		/* vpn points to part of a THP at this point */
+		if (page_flags & KPF_COMPOUND_HEAD)
+			cur_order = 1;
+		else {
+			/* not a head nor a tail in a THP? */
+			if (!(page_flags & KPF_COMPOUND_TAIL))
+				return -1;
+
+			vaddr += psize();
+			continue;
+		}
+
+		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
+
+		if (next_folio_vaddr >= vaddr_start + len)
+			break;
+
+		while ((status = get_page_flags(next_folio_vaddr, pagemap_fd,
+						 kpageflags_fd,
+						 &page_flags)) >= 0) {
+			/*
+			 * non present vaddr, next compound head page, or
+			 * order-0 page
+			 */
+			if (status == 1 ||
+			    (page_flags & KPF_COMPOUND_HEAD) ||
+			    !(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+				if (cur_order < nr_orders) {
+					orders[cur_order]++;
+					cur_order = -1;
+					vaddr = next_folio_vaddr;
+				}
+				break;
+			}
+
+			/* not a head nor a tail in a THP? */
+			if (!(page_flags & KPF_COMPOUND_TAIL))
+				return -1;
+
+			cur_order++;
+			next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
+		}
+
+		if (status < 0)
+			return status;
+	}
+	if (cur_order > 0 && cur_order < nr_orders)
+		orders[cur_order]++;
+	return 0;
+}
+
+int check_folio_orders(char *vaddr_start, size_t len, int pagemap_fd,
+			int kpageflags_fd, int orders[], int nr_orders)
+{
+	int *vaddr_orders;
+	int status;
+	int i;
+
+	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
+
+	if (!vaddr_orders)
+		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
+
+	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
+	status = gather_folio_orders(vaddr_start, len, pagemap_fd,
+				     kpageflags_fd, vaddr_orders, nr_orders);
+	if (status)
+		goto out;
+
+	status = 0;
+	for (i = 0; i < nr_orders; i++)
+		if (vaddr_orders[i] != orders[i]) {
+			ksft_print_msg("order %d: expected: %d got %d\n", i,
+				       orders[i], vaddr_orders[i]);
+			status = -1;
+		}
+
+out:
+	free(vaddr_orders);
+	return status;
+}
+
 /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 1843ad48d32b..02e3f1e7065b 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -18,6 +18,11 @@
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
 
+#define KPF_COMPOUND_HEAD             BIT_ULL(15)
+#define KPF_COMPOUND_TAIL             BIT_ULL(16)
+#define KPF_THP                       BIT_ULL(22)
+
+
 /*
  * Ignore the checkpatch warning, we must read from x but don't want to do
  * anything with it in order to trigger a read page fault. We therefore must use
@@ -85,6 +90,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 int detect_hugetlb_page_sizes(size_t sizes[], int max);
+int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
+			int kpageflags_file, int orders[], int nr_orders);
 
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
-- 
2.47.2


