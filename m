Return-Path: <linux-kselftest+bounces-18812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E429798C86D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 00:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9855B285F21
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 22:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214921CF2B2;
	Tue,  1 Oct 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="t+DNRTY0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022084.outbound.protection.outlook.com [52.101.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7261CF2B3;
	Tue,  1 Oct 2024 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823162; cv=fail; b=S1vBU31yy3rcBw938PR2gByJSScn9kO/lffRdSsNMbuHOxVM3r161mSXNdfIuQMzadOtyayiNjXGBxRz00veLTra/IQ4ocRnsldBg6irGxE8BY1pXsxhYqAQfDLrlsg0dHcre4o9w7HTessOaoMftvzJHE+8oAnAmfHRO0lMzrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823162; c=relaxed/simple;
	bh=AcEpVcQlmLQYh/j9R+IILgIi5zY91FyQWntOUDYlZX4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p/mihzWQVTRxsub8Tqnnen9aFtbKzpAbWxtInh9Z0VAbgJmSZ2+1IYLBSopu1Lx05XfX88yPXT4jfWzHKX4iPkx2prpaA1DffquuFmVLLVY94gOmrPvMEbwEv4sfsHnDhgHTIEhn87AMBvEBlxTjPyeVOg402OPKC2f8Y7Nbc08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=t+DNRTY0; arc=fail smtp.client-ip=52.101.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO0+U51Mozk+bRqldTggeK8edGNN7/WrX8K+74KQ2axCDjJ52TacQolSB90f7bIr8PJo4bYsHTLaK5D+pgE6liXLyaiA3qe85e8twu3TrHrqqLpaLx7CHoM4hks/T5mHdsodcV1Sn/zbrbvnnEz0GufpuT5rnkYwfA97Tz9MPaSBp5I3qWsQ70+Yzx61oUUYhDo0nnBjetxP82kTG0pozOt3Jt1XprYMcwIejpTnpHv7I8y/T6UuYFtMdgL24ofK+HTerjMkcV5azlWDsXvNpDerOSSNyU5ZPlZHPusK297JzpeQxAe44oYJjcLubf39opcfsNvUaWnd9+2lJKNzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91Y4a8uHClU48nQ82l2w0d0MIr7yP0j6WBM6QG1+YLM=;
 b=oZh8wQUslEGlWsGK6pXYfTfDfqPXNQwA2/loj/vc0mLODV4ZqTig3DZGSBg1sMxvdzj0RWGwiL7mXzO3BXQfgaHjSLqtxXD9zUaLSMTfLRE3Acia0eIX6spJ/6MUQP9URJtw6aZi1dQr/B5c5jksbxJRsnQZc0IYaZUm30SWPHuLKHCPs0WUX7QeaoQUGsDw5VJTZQtYhRrZGc6+LsT5D1IKQ1Znvnd3s3BaA2JjIKEvGGGen17NE1wrC4q3DUsHdqLzAl7dRul2gDPzHudmoZ/5XQoLXQ5EIoJ4jkoNsk2SDFHTfiZ4idATiBGdwKiyW3sF2Lwjdz28yUmCoRPADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Y4a8uHClU48nQ82l2w0d0MIr7yP0j6WBM6QG1+YLM=;
 b=t+DNRTY0j1aUWnnXLMr1Y1WJ14WbQfmbl7BpNu1X0x2QftkOlz1D8JlrTkpd2XxzQ3i5UIW5FqFWZnASv0s0jzQWiiM8TkLbKg4OUu3nwuysVii5GK80ldER7PeX0KK7SkZafgsirT/2uSNmIhtMuMToftCfz11riZOTe1zdrtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB6678.prod.exchangelabs.com (2603:10b6:303:d9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Tue, 1 Oct 2024 22:52:35 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 22:52:34 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	muchun.song@linux.dev,
	david@redhat.com,
	akpm@linux-foundation.org,
	shuah@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v6 PATCH 1/2] hugetlb: arm64: add mte support
Date: Tue,  1 Oct 2024 15:52:19 -0700
Message-ID: <20241001225220.271178-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0036.namprd19.prod.outlook.com
 (2603:10b6:930:6::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: a64e8e08-3094-4e4f-e987-08dce26bbd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Jyc5QHe4drhBfp/1sMVkal1FPHVqqJJ83wimuG7e/+X0AgKpkc4iMZKOwY6?=
 =?us-ascii?Q?J9e633E6W6Utsq4n1FS+FS58U1uy87DYn3OsyvfayYyzpG96RP+x+aQf3cN7?=
 =?us-ascii?Q?Xs1kUfveVR/xyt/mhlTtE1UEhm4gFn97ixravCyYhdLxmr1AP9Lwj3JXD+oX?=
 =?us-ascii?Q?a376zhR49JqnrQknZBiFBAaQkpGvBeWcOSs3e/hiJCu1Od01975B8gqRypkR?=
 =?us-ascii?Q?QgP3HoDsH2vorCMJxDrIqI8SuPfmZ5dM9PX0mZ7usA9qtlYgP/nrG02Orv3M?=
 =?us-ascii?Q?HSR0E7JtBp6wgpA1y3Z5xAslxR0qOas7Tz58KC9702bZgUxzODtW5GVrbGEW?=
 =?us-ascii?Q?fFQOZueL0H8FG8PNkNOPPOMAwsQqyb/xiUCjMhRqaD4cU5ty3xBN6g7QkRtt?=
 =?us-ascii?Q?pAfa/yhzGgl8ucb8X1XZstusqs3/aCLoHPN29PACO3SGfJwwZZ/8Xtx1wISc?=
 =?us-ascii?Q?0TR1zASTiOTzjhZLf6zakI7Ix2h1pGVoc6u0uAXYzDj+2Q6HwJGKTIYJb1RY?=
 =?us-ascii?Q?cTyuv7vePhMpj07h8m7w9FK8hwBHQbu2uKlCCYh2ykUlJJmAxGF4IJ5ALSnC?=
 =?us-ascii?Q?7OTgDYSH/N4q3+v1dufA2fTb9IfA8Hp+HKSy6wdb3L5cwxC7vSaFCMAr1sXj?=
 =?us-ascii?Q?OWDydmPhIdE8qcBakkUxxN/s/9X5omFRX8DaDSaa8Z323o2m67cMG0toxrV2?=
 =?us-ascii?Q?gSFKTRb1TXXLcalPirx52+yTGf9UdRO8CnXQc6y/n5Ociu+XaMW7j7yFTAyi?=
 =?us-ascii?Q?our6p6EKH2A/hloze2WXBvU88IIocvTSgFVnFnUODkXxdk2dsAYj7ffpoT1g?=
 =?us-ascii?Q?x4rK8lpQzTac+Yb+/9E1FukL5p+0n/CZtzW5k4LmA8Td1xHkJyRRU7CcOHAc?=
 =?us-ascii?Q?2P1OO3O2pG81MXB62HksgNMBaVe1vUpxGw/TXCv7e0Foc8o9lno6Qe5Un3NJ?=
 =?us-ascii?Q?ApbEsmENPZ+ionYrrF3dA/D3mBtdOAUUgQseQFLeGUZ8A2CYBAOs0JR3anOf?=
 =?us-ascii?Q?crLljbUz3FooZ5Okh9Ho2ceBstqwe9ehBW/pNPoBNm8K4uHIXqLSWGEvxtAZ?=
 =?us-ascii?Q?AmD5XTPawcjz/2pt9/r8X8GbMMkTbwygEaS+QuN1Tdu8UVM5trgIBamzZHCd?=
 =?us-ascii?Q?HZUBZhyyQVN+lR9OeoKXs6AqRopknCONV4h9MgBibGJoKAq6XOhdsVoMmaHN?=
 =?us-ascii?Q?UdVb2q8lgdMgIim7yOwzlZd0hPCaA0LsrClSIBMIsdVB10fVNdotvKORgcC7?=
 =?us-ascii?Q?LjBs9gb1ZSbxwlMq5qoSOCflm9mHmVr8NGmr35ZhcBlNA+lT8JAm703QgYUZ?=
 =?us-ascii?Q?R0UZpQCU1QMNMPM6+4XoNJO0xJkW+4znWybOLQqTIAyDHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0peh2zsuqvxdELlle3ddQs08k83wIGh4c5Zw7p1DkHxfA2Yc6vX/D6DyEIR?=
 =?us-ascii?Q?pE+WZfESrUE/qjJ0GJLVoKWY6U5ly7vG9EIKHAS70r53CdXVFdEgYm53GPSA?=
 =?us-ascii?Q?WwGWUivHhdbu9ABWugTqJ7+9Cve/2RHIzCmC0l8tKec01DTmr3vek5GZBbC+?=
 =?us-ascii?Q?pH5t4WdirZJgXwhWfvvEIoUqFIdX44dycK40imSYAbmPiqfHciMOwatfkbTH?=
 =?us-ascii?Q?SPhG+ZSPPu/JmMOtTn7N7Vx4E/75tUJ+s3BPFJjzLAsF5Yt0TpHqiUUy9r6A?=
 =?us-ascii?Q?e8G7QzAQR86BuugjJznhFnft81PmCQQ/wfjQeCto64x1gM759QcqYm3iA84+?=
 =?us-ascii?Q?mkb3y6M6oXHVoyrnYSuTxyUdKQTlKp5KRRnjLyG5mrtImvQGlVBIZxy43Uyk?=
 =?us-ascii?Q?2Qkd3DYmnz4U8kfM+/Z26WyJzpaMcRlxOvQE/AuIsIekEqb8QdivkOHKdq7N?=
 =?us-ascii?Q?3S1HH1bCHiEQTbnKhPcurzzgttpIyVJ3EdPHH52Cx5c8hLvFIoQ+fkJ3uqsy?=
 =?us-ascii?Q?ttIAhIrMbO92Nk6jkHSLPzAH6zPqx9f+twqVpO+CafmM3RrDI1PvHRVT/Fdw?=
 =?us-ascii?Q?NTLTb6JB+BaM0X4G7eN1rOJ0RAtQKIWSyDltA14gmAf0OLcIiztFR9YiLjwT?=
 =?us-ascii?Q?h/WLunD3CNE8G2ZqLEFARwf0wGYNAJT9k9zUdyrkDg/93Phmp6c6JZtHF0DN?=
 =?us-ascii?Q?4NHztG9Cnr2QXldkQawCOn6EmduLgSmaLca04O5hZEnDsTfGmQetuCPQ/Txf?=
 =?us-ascii?Q?79HadQAGSTP2MKpLAvP4a3Rid8qodDXwtRvdPMTjN4MSbLYFdQW7wzg41Fx/?=
 =?us-ascii?Q?LM3qgQBp4s3MUPUxiHxjlixJXSiAoZRHPxb/yvYDGtN81FCOdNUPlJYgcxv2?=
 =?us-ascii?Q?MYGuUTV6yiPzq0frRpGBNYHi3PydIi+F+FrKGn1Hka8p9bIhw+7TV0pWYLxF?=
 =?us-ascii?Q?peH8DOYQg5AHvgNcSj7Zzw0noena9Gh6vqPFD7jY6ih5HPvUb3kSyuufzGM7?=
 =?us-ascii?Q?xfXv09xZGGD64b14t8l5Gd1E6YCIbCR/T37/ZZIur4kqydLpMuOOe6JZfSM2?=
 =?us-ascii?Q?sD4fv9oxuGlqj/hIzB+srzFA/L7Vkp3iNpN/1lfFNez+2BCaRQtEnnEXyDbj?=
 =?us-ascii?Q?Qp0eMhzyoOygZJsazZtOc+CRIb6TEcLc25l9ZRHUEPL1I/B2b0zirUIwJ+dI?=
 =?us-ascii?Q?3b08VZZUC4t61xAd5a2SPpBMZWIwQFS5W5XZ6QW47mT28sigow2GUQgAGW/9?=
 =?us-ascii?Q?iQ/mWz90xvhgtH8m525pOjCNRvuODI+zFJR9v4ZwfbLN3vESegi/yJzA1tac?=
 =?us-ascii?Q?rsGNqdVvmK55HqXqSuDv3lw9zdVC2o2fsB+WHCm7wmCmJtPpxSleFIJ5ACWS?=
 =?us-ascii?Q?oyVRkjR3OmkFLLy0NelGts1TUZOqQWsUzxUqcCMbqUGOwT5vQi6E1TTeMkAB?=
 =?us-ascii?Q?2VShUdgx1BcnE5zrfy5LKsQpqJPGEgjl0UiWPsDZ50oPIUA7glh5wT5AlPHq?=
 =?us-ascii?Q?/hNBsyeK94ieZ+bZDOD0ywC2FgQiKl6JGbW60SQW0gPg057CJeez55A/FPsU?=
 =?us-ascii?Q?6Hlmm3nyVOUySanaj5vC1lATv8TaSgfzQBHek/emujxJioamgxTER70PWwGj?=
 =?us-ascii?Q?hsZfStMpwyVSeQBNVsLCZ5E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64e8e08-3094-4e4f-e987-08dce26bbd00
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 22:52:34.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgJT56AZHrsNDIAFB/lPhftovu4930b2ko6h2iPvfZJ9w70IJSKhJY+8kqETdiutA4eyqpI3dPux9NVuVTbO8yvnlQ+9BTDaC3mGzvwu3JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6678

Enable MTE support for hugetlb.

The MTE page flags will be set on the folio only.  When copying
hugetlb folio (for example, CoW), the tags for all subpages will be copied
when copying the first subpage.

When freeing hugetlb folio, the MTE flags will be cleared.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/hugetlb.h |  8 ++++
 arch/arm64/include/asm/mman.h    |  3 +-
 arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c    |  6 +++
 arch/arm64/kernel/mte.c          | 27 ++++++++++++-
 arch/arm64/kvm/guest.c           | 16 ++++++--
 arch/arm64/kvm/mmu.c             | 11 ++++++
 arch/arm64/mm/copypage.c         | 27 ++++++++++++-
 fs/hugetlbfs/inode.c             |  2 +-
 9 files changed, 159 insertions(+), 8 deletions(-)

v6: * Rebased onto v6.12-rc1.
    * Fixed the trivial comments from David.
    * Collected the review tags from Catalin and David.
v5: * Indentation fix and renaming per Catalin.
v4: * Fixed the comment from David.
v3: * Fixed the build error when !CONFIG_ARM64_MTE.
    * Incorporated the comment from David to have hugetlb folio
      specific APIs for manipulating the page flags.
    * Don't assume the first page is the head page since huge page copy
      can start from any subpage.
v2: * Reimplemented the patch to fix the comments from Catalin.
    * Added test cases (patch #2) per Catalin.

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 293f880865e8..c6dff3e69539 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -11,6 +11,7 @@
 #define __ASM_HUGETLB_H
 
 #include <asm/cacheflush.h>
+#include <asm/mte.h>
 #include <asm/page.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
@@ -21,6 +22,13 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
 	clear_bit(PG_dcache_clean, &folio->flags);
+
+#ifdef CONFIG_ARM64_MTE
+	if (system_supports_mte()) {
+		clear_bit(PG_mte_tagged, &folio->flags);
+		clear_bit(PG_mte_lock, &folio->flags);
+	}
+#endif
 }
 #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
 
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 9e39217b4afb..65bc2b07f666 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -38,7 +38,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 0f84518632b4..6567df8ec8ca 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -41,6 +41,8 @@ void mte_free_tag_storage(char *storage);
 
 static inline void set_page_mte_tagged(struct page *page)
 {
+	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
+
 	/*
 	 * Ensure that the tags written prior to this function are visible
 	 * before the page flags update.
@@ -53,6 +55,8 @@ static inline bool page_mte_tagged(struct page *page)
 {
 	bool ret = test_bit(PG_mte_tagged, &page->flags);
 
+	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
+
 	/*
 	 * If the page is tagged, ensure ordering with a likely subsequent
 	 * read of the tags.
@@ -76,6 +80,8 @@ static inline bool page_mte_tagged(struct page *page)
  */
 static inline bool try_page_mte_tagging(struct page *page)
 {
+	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
+
 	if (!test_and_set_bit(PG_mte_lock, &page->flags))
 		return true;
 
@@ -157,6 +163,67 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 
 #endif /* CONFIG_ARM64_MTE */
 
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_ARM64_MTE)
+static inline void folio_set_hugetlb_mte_tagged(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
+
+	/*
+	 * Ensure that the tags written prior to this function are visible
+	 * before the folio flags update.
+	 */
+	smp_wmb();
+	set_bit(PG_mte_tagged, &folio->flags);
+
+}
+
+static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
+{
+	bool ret = test_bit(PG_mte_tagged, &folio->flags);
+
+	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
+
+	/*
+	 * If the folio is tagged, ensure ordering with a likely subsequent
+	 * read of the tags.
+	 */
+	if (ret)
+		smp_rmb();
+	return ret;
+}
+
+static inline bool folio_try_hugetlb_mte_tagging(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
+
+	if (!test_and_set_bit(PG_mte_lock, &folio->flags))
+		return true;
+
+	/*
+	 * The tags are either being initialised or may have been initialised
+	 * already. Check if the PG_mte_tagged flag has been set or wait
+	 * otherwise.
+	 */
+	smp_cond_load_acquire(&folio->flags, VAL & (1UL << PG_mte_tagged));
+
+	return false;
+}
+#else
+static inline void folio_set_hugetlb_mte_tagged(struct folio *folio)
+{
+}
+
+static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
+{
+	return false;
+}
+
+static inline bool folio_try_hugetlb_mte_tagging(struct folio *folio)
+{
+	return false;
+}
+#endif
+
 static inline void mte_disable_tco_entry(struct task_struct *task)
 {
 	if (!system_supports_mte())
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 7b11d84f533c..18749e9a6c2d 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -266,9 +266,15 @@ static int swsusp_mte_save_tags(void)
 		max_zone_pfn = zone_end_pfn(zone);
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
 			struct page *page = pfn_to_online_page(pfn);
+			struct folio *folio;
 
 			if (!page)
 				continue;
+			folio = page_folio(page);
+
+			if (folio_test_hugetlb(folio) &&
+			    !folio_test_hugetlb_mte_tagged(folio))
+				continue;
 
 			if (!page_mte_tagged(page))
 				continue;
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6174671be7c1..2fbfd27ff5f2 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -38,7 +38,24 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 void mte_sync_tags(pte_t pte, unsigned int nr_pages)
 {
 	struct page *page = pte_page(pte);
-	unsigned int i;
+	struct folio *folio = page_folio(page);
+	unsigned long i;
+
+	if (folio_test_hugetlb(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+
+		/* Hugetlb MTE flags are set for head page only */
+		if (folio_try_hugetlb_mte_tagging(folio)) {
+			for (i = 0; i < nr; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			folio_set_hugetlb_mte_tagged(folio);
+		}
+
+		/* ensure the tags are visible before the PTE is set */
+		smp_wmb();
+
+		return;
+	}
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
@@ -410,6 +427,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		void *maddr;
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
+		struct folio *folio;
 
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
@@ -428,7 +446,12 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!page_mte_tagged(page));
+
+		folio = page_folio(page);
+		if (folio_test_hugetlb(folio))
+			WARN_ON_ONCE(!folio_test_hugetlb_mte_tagged(folio));
+		else
+			WARN_ON_ONCE(!page_mte_tagged(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 962f985977c2..e738a353b20e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1055,6 +1055,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 		void *maddr;
 		unsigned long num_tags;
 		struct page *page;
+		struct folio *folio;
 
 		if (is_error_noslot_pfn(pfn)) {
 			ret = -EFAULT;
@@ -1068,10 +1069,13 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			ret = -EFAULT;
 			goto out;
 		}
+		folio = page_folio(page);
 		maddr = page_address(page);
 
 		if (!write) {
-			if (page_mte_tagged(page))
+			if ((folio_test_hugetlb(folio) &&
+			     folio_test_hugetlb_mte_tagged(folio)) ||
+			     page_mte_tagged(page))
 				num_tags = mte_copy_tags_to_user(tags, maddr,
 							MTE_GRANULES_PER_PAGE);
 			else
@@ -1085,14 +1089,20 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			 * __set_ptes() in the VMM but still overriding the
 			 * tags, hence ignoring the return value.
 			 */
-			try_page_mte_tagging(page);
+			if (folio_test_hugetlb(folio))
+				folio_try_hugetlb_mte_tagging(folio);
+			else
+				try_page_mte_tagging(page);
 			num_tags = mte_copy_tags_from_user(maddr, tags,
 							MTE_GRANULES_PER_PAGE);
 
 			/* uaccess failed, don't leave stale tags */
 			if (num_tags != MTE_GRANULES_PER_PAGE)
 				mte_clear_page_tags(maddr);
-			set_page_mte_tagged(page);
+			if (folio_test_hugetlb(folio))
+				folio_set_hugetlb_mte_tagged(folio);
+			else
+				set_page_mte_tagged(page);
 
 			kvm_release_pfn_dirty(pfn);
 		}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a509b63bd4dd..962449f9ac2f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1401,10 +1401,21 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 {
 	unsigned long i, nr_pages = size >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(pfn);
+	struct folio *folio = page_folio(page);
 
 	if (!kvm_has_mte(kvm))
 		return;
 
+	if (folio_test_hugetlb(folio)) {
+		/* Hugetlb has MTE flags set on head page only */
+		if (folio_try_hugetlb_mte_tagging(folio)) {
+			for (i = 0; i < nr_pages; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			folio_set_hugetlb_mte_tagged(folio);
+		}
+		return;
+	}
+
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..87b3f1a25535 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -18,15 +18,40 @@ void copy_highpage(struct page *to, struct page *from)
 {
 	void *kto = page_address(to);
 	void *kfrom = page_address(from);
+	struct folio *src = page_folio(from);
+	struct folio *dst = page_folio(to);
+	unsigned int i, nr_pages;
 
 	copy_page(kto, kfrom);
 
 	if (kasan_hw_tags_enabled())
 		page_kasan_tag_reset(to);
 
-	if (system_supports_mte() && page_mte_tagged(from)) {
+	if (!system_supports_mte())
+		return;
+
+	if (folio_test_hugetlb(src) &&
+	    folio_test_hugetlb_mte_tagged(src)) {
+		if (!folio_try_hugetlb_mte_tagging(dst))
+			return;
+
+		/*
+		 * Populate tags for all subpages.
+		 *
+		 * Don't assume the first page is head page since
+		 * huge page copy may start from any subpage.
+		 */
+		nr_pages = folio_nr_pages(src);
+		for (i = 0; i < nr_pages; i++) {
+			kfrom = page_address(folio_page(src, i));
+			kto = page_address(folio_page(dst, i));
+			mte_copy_page_tags(kto, kfrom);
+		}
+		folio_set_hugetlb_mte_tagged(dst);
+	} else if (page_mte_tagged(from)) {
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
+
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5cf327337e22..f26b3b53d7de 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
+	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	ret = seal_check_write(info->seals, vma);
-- 
2.41.0


