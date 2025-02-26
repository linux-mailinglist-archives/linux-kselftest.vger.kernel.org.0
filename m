Return-Path: <linux-kselftest+bounces-27665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1FA46CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602253AFC2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4A25A2A4;
	Wed, 26 Feb 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAov4FFv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68525A34F;
	Wed, 26 Feb 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603663; cv=fail; b=WHuHzJs78CwPR2NhKta/VCFQcg75mrOZpY6p4NjHmWTHFd8zOjWlEufSAIB0LxiDVugPldNdbKBNP113qmtd/ODty8IkskG8T9pXGhiBHQn2GPqE1NSUahrghHW7zdiiIuxegaozFvPRlcezh9XiyIeEvjyFy+y/GKmLLPATO+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603663; c=relaxed/simple;
	bh=dDPGzX7cDE7SklxxccbXh4pwUCUefCIONgCH33Y8jQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9ErXgjkfuzCaBvsPe+B8lS5/N2m/jnFXNRE3Habv6FCFyCpoKoVZWK1FFVrJonlfhMQw7ygiogV3GeTk5Hx4IIaHDp/8UstoBmgiM117Fz9p8WIGF2tU5/IJI9kShwsqFgmiD45TCWOytQvEfvPIpW4zxzp/6PrJJYQlyGnmnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lAov4FFv; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejCXVwy1YfzrGC+DbuwPNR9oBqRwV7KZ7+imsXAdaooRBjvRrQQP9OeQvtvVl4/Oq8uCQDm242gczDHFM37sAfEV5BwbnP0/X72iIZehgmk/buQofDKZn6uDR5vm+728AogS8MbXZ5axC1jG3jsxdCf9gEoa87PBxYPDsNp0e6aRftSTzLeFMX775hH1wm8UdO7JxkJWl2GLr/0ZSTpf2vWXWubuz9jqQmL0ewO0NYVGirsSVoL6weeoV6p5akTp06NfdN0Sy1aPz9RYMi8nxGR4t936IGWY5oLNS2HXtItopPWBnCFzuqfMEVFOJ4RvtYd+fhudn8Qy4T7leksecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5vsCuPCJeyfDdEP5f7KM9iw2fB39gGo++lVyXDN988=;
 b=bQvQtASHm8NBSbxW8mKJGDI6JI5AZ5mWA1Z+NAykDjGdDkfyIqa9my4qUWNy/x0ot+1JmG3tuH+dUufIacVhuThIKY5FsRxTAqjlTi3kGJWUsoNU5edqN4txPbjnHzFzuuo+VaeZW7WTpJ14sbDC/2gciQgS0NfVxl8q/eUZhGsrOSHCP1oMedJSdVf+ncag6E1P3gdr/JwG2AGNECtQugQRZP9TjBhY3NQezg4SmqNnUWxrdclGIxXU737fouYj7JC8FpdrdLF9U7nsedNQRcUmqan45Bk43Dhl9pnGXbx2Yiav+dV7uS7JADi6cBBXCO0/t/xcwRJdA3SFtpmw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5vsCuPCJeyfDdEP5f7KM9iw2fB39gGo++lVyXDN988=;
 b=lAov4FFvs0lRvQGM9D+C/S7QyU/IGGyToLnsT5p3sP74e8NSI3NBZy0m50y8w7Jta4Rm+SJj5/kabqYnOQjyZfWYncwO6q+LnvwJbL88m8avFseXLVDpP+SvkHZJc640FRm7DwTcjsE/PKC8gGTEOEl67kpodoUuiPvnhnqDLRrSSgwOF45s2fFP7eqxhKwddmCZLVB8YykuguKnBzmX9869FK9HLR4qkvn+nmX2Metmvaqx3tUPvmgShtN30QnFAsgDuQi6+iUXO+lsPQKNqZDV2eImFzSx7HfUJoC8BnHST/sam9fF4JQ2WaN4DRbS4q8L6+FTxE64RIWpfr1JZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:48 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:48 +0000
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
Subject: [PATCH v9 6/8] mm/huge_memory: add folio_split() to debugfs testing interface
Date: Wed, 26 Feb 2025 16:00:29 -0500
Message-ID: <20250226210032.2044041-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:207:3c::49) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6ab34a-1c87-4daf-6884-08dd56a8a51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1IzbUm/+XzhEgX0NnQ/Hgriy34vDQ+707fHUET7r2ojl+Zyv7ySPZODFyht?=
 =?us-ascii?Q?poOZpBkd8yB07OJ+HiXMGoH5Dqn1t7NEDWj0OWwLAxepENTnWeaSrLo0f3Ps?=
 =?us-ascii?Q?Ilk4WNhkKrahC9VSaIF6ieUmnij2hbGqzQo2baGZTgi2AKfh0vxF+otwpr3p?=
 =?us-ascii?Q?BA4bA9Pei4qY6pUhYJY84vdYgx3eaphlpUgwckpwWgAOe4W4NW4lUFUc1oKy?=
 =?us-ascii?Q?OzgNo8sQ/KqsRY67tHNfs+IjLw5t44lTI/CFncWpVezu6NtyXXppRphFIIuN?=
 =?us-ascii?Q?0oiCtcq1hHKEJQddSIe0lE+Hl58Q6wnMdngjao3lgk/nUTZT/h0gMbieu/T3?=
 =?us-ascii?Q?Bu/GQphswnoh8l2QBKcTp16qS2Z1FkCaDxsxt/Vl6aao+W8FJSPqy69/jlkD?=
 =?us-ascii?Q?tU7Je8IH4c/bjStoWkC9f5fx5E5XJ/g4Dz3QMTGCBDPF3vvZloG+dqFQ0WZG?=
 =?us-ascii?Q?owsWX5c/LZnownAjXKUN8sDmtVeXNQxEIxe1S8cj0m9LWOJM2xEvHFNg0pcr?=
 =?us-ascii?Q?7oLyNmyB7Ze1DKb5GFDWx5yhAbYvju8oLLAwscnGBK7PIZSvne5ZG1P333Hq?=
 =?us-ascii?Q?X6SIbLxJI2WqNPHn1wKKAT+CjFd2T9c1kvB93TW/l1HgQ/udvJzO6YMjx4l7?=
 =?us-ascii?Q?zO4y19d4saIXvpozDkLjCKMxrU7c3LG/9zZVlMPLX5SqlYe2X+diYffvENs+?=
 =?us-ascii?Q?X63BlLfUTUPytOhbej2rbnpr6ws9moDovY5Grkwu6gketdqob6gq8B9dH7c1?=
 =?us-ascii?Q?K40kfgNc6HPN5mkkyzE/nsOn6fTPAqDowdHMuHEK8J5/9ZN1PZiHW7faJIDV?=
 =?us-ascii?Q?kL7/RDQ2PE7I+r1XI9mm44QXYGSQZsoONCYlQzy5Fa3896IL+DAJJb8W6QOA?=
 =?us-ascii?Q?HbkfOO4zck+o7Uu8iw9gZjyHupMfplD6v3uMkkuNcHjaoPGw0jLRiEdphfhM?=
 =?us-ascii?Q?LJucBGxfKuBOK1GsrMBqGr9Fp45LtklXRsXwnmT/OGYfOPCJuwPB6PPQ/kPh?=
 =?us-ascii?Q?zvzPgimYYFH6QP8ffbwTTDz0js5lhrnAhnvwDGIKW0wRJ7uOURgStNYn3WX3?=
 =?us-ascii?Q?fiCU86cT4ddsqxNnfrzg7Vyere8EmACcDPPDI3Oaa2J1b++EVP7LC7ktqtx1?=
 =?us-ascii?Q?cBjZjWtV0DgQ6Wabb6I3Ln3XHzHa2pGg8aU8zQOfUGSafcrH4q9S6UW1KyOW?=
 =?us-ascii?Q?h2X5L3wHpuZxXdEQCIBGRUZqZaOWDf4EL4nTLIsSER9qTBJLwP3RpwOV1uVJ?=
 =?us-ascii?Q?/2rANKl/URqqMCu5JxUxHNALb69578d/vYFcml8BfBoS7TDxU53HmSMvjC2Z?=
 =?us-ascii?Q?AAHxO8IP69Bctz9dsCFkUbZ4wy3LKybBDVaYS+BKce9bQIMqeo2b1KMnu8Rl?=
 =?us-ascii?Q?5UbxHr4E8i3+FuMA/buwyoFm5OQ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiPZYVtyWAdg+JOxQ4+JDja0R7s0QDP8ltatUT92DbQdIsLoe/ZeZitpQgfR?=
 =?us-ascii?Q?GHtx6qxsz573PnzNyFeqc5ooaK9l5xMxCtNtvhCTOkp+gLxXf/BnWmKhrStA?=
 =?us-ascii?Q?HX7k3h6v38JCSvkIBCOABzdQjFgIEKs8wWlY+ncmgGv+/zNGqRj5gCt/mB8y?=
 =?us-ascii?Q?KSSyBzrXA2mwlb9ASgEghpOE+/x0OPJ26tJ4rV+t+yjHQ85If3wcc+ZT5a+9?=
 =?us-ascii?Q?B4O7i6+D9Pf4697owltsoKa1OsvPfY7Ol3O4eaUjYu2rhdazLjBr69JlgQQr?=
 =?us-ascii?Q?cOybre4EXKAKmPyp3ybb/UdtvNqCM9IBOjBWSobGEb4AvRIigFS2pNs82UEq?=
 =?us-ascii?Q?oEDx4yq92OJNXi/rWZztvIPd/rGPyy5q5wkzK1mIxrZLGQA4aFWPlItJRBBk?=
 =?us-ascii?Q?QbUve/L9gOaKAcpubXvOWNIvCBCqgcJeYndIHk5VyDcXb4M3pFJRYWlfOeVj?=
 =?us-ascii?Q?7ZlQKEb4kKnl4CdtD6YO9OBRSe4eQINIjEJlt83q4B/4Bp4vNTQK0oCCR5ZT?=
 =?us-ascii?Q?7UY9ChpGphxvWJiRrssmq53l5ovw5w71nQY7AQYv+WiTkRGk96wfTG24ta1W?=
 =?us-ascii?Q?RGEJs2A2ljpePx3lFXpURN0Sa/MqcOWbKrdrm8e9xu4PdCsPNptiro3vYMft?=
 =?us-ascii?Q?bN7UUiGHhkImNc4gfDXj7u5qlQGd+NVUf8p0KyMq9MK8LTKdstKdlA23f9IV?=
 =?us-ascii?Q?i5UT2RFUlp2uZVltjBq5JFw6EaQaKfcyfyhJJuP9BagWhQgTbekIk7UvHThn?=
 =?us-ascii?Q?ZM788NS/zlWZu77WjA5n0Ogfdhs1wT2F/hC8hqvBJl42eyNShIwORaOnGlgz?=
 =?us-ascii?Q?T/1xtBllAtjShRWC/o6o61TXZh4MCjrl6Mk3TpkrKc6BA9V1xWQ6sNs3fWob?=
 =?us-ascii?Q?AM3+OWrp38A/y4iQomtyxj6xDFa/RvjwOB7TEzyP8aXPz8lsB3LNkP87LcoZ?=
 =?us-ascii?Q?y0ldQaxBWzrfD3OR34jHPoqlUoZE4lUPuVtrDR92CZmOMy53bdciUWraKsKt?=
 =?us-ascii?Q?brKRgLx1c3i9C16a69/nZX3bX9niGGq7HL1SO+S0EqQamTgjWn5x/CJeANu5?=
 =?us-ascii?Q?z8xcM61csNQDs8PH97PAuijCMNW6YknJEeAuC7ZZNK/MVdkLW17bkPLTLNFu?=
 =?us-ascii?Q?6J05LGGRb5d2RuWlOCzbd79yPDN/vKAwfT4zwA7RefqY9G972AErKXE8Mf68?=
 =?us-ascii?Q?C/jPrllcRDAQ+CMQkr5btj1O5G9bKK4G76cMO/W6sQC4igxpYsjsazhwk/F9?=
 =?us-ascii?Q?vYc5Baj1/KlJIDDhcX6aywavoyW9SeTO8a5grgK3VSmRIZg68u6Z/9efxBdw?=
 =?us-ascii?Q?C/DGUoCKhTjS6UleN0tzkQNROQSOTOSO/bbCLB+tQ6WLdBXXEdwBP2dTfKYj?=
 =?us-ascii?Q?vzHFFeqBIiIXjTZPqvMY67tWfGScPGg2E1Wswsatd0fd4CiOnCF77VmYC6th?=
 =?us-ascii?Q?d+dAGjVO5SsATjBVtmqt9pUFzZQDi+yO+NwmczCcaOc+4IXKpJ+U53GA8GOM?=
 =?us-ascii?Q?tJBTHaPwKUqTwG2JBxSdHBM7tp5ZSYr7UlVzq9WKw9zVQ6n37YtB5GwPXhk/?=
 =?us-ascii?Q?vsnz/5jB8ZKcdKTlle51SyILCIaQGD4zlB8Rl74+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6ab34a-1c87-4daf-6884-08dd56a8a51d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:48.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVuC1uB+bofoXMYdF1f1p9wlGV3DHU7w/v5/1eZOKbkON1FwFPpDe/OgKuGREQyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

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
 mm/huge_memory.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e7e50b2b23f6..6298be12e843 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4312,7 +4312,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4396,8 +4397,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
 
@@ -4420,7 +4429,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4469,8 +4479,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
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
@@ -4503,6 +4520,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4531,30 +4549,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
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


