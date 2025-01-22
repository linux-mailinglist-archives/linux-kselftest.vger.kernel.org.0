Return-Path: <linux-kselftest+bounces-24950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5376A19650
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAED188CE45
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89468214A9C;
	Wed, 22 Jan 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="guwStwzC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A221422E;
	Wed, 22 Jan 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562778; cv=fail; b=hZlFn8+Lck5AbykEU0CAH/WMDAokDrpwZe4VPeAG4nHM1NFPfL6eZ1iFYOnhL8kLa+wCSTRJ4iE0NebmdvJKQ9yomCAThXpcA5ukpBa9mgYm1+8vzTEUQd6CujYWBy50PckVjAuAPWujKBNplsuXQ6DAOdgpX/MbjGo4sTnRD/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562778; c=relaxed/simple;
	bh=uMqI+2tqCXQabaHOMMNEdO0SRwfWh7bxHJBeeh1700Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ogw3wBnGya6qRId1N/lZLH7onVScWjVoQBFRu8UKP3QvGMV52fyZxkDJIu70R8jh5wVV/gdT72T57sY2Y4x0JS5SVl34rhbFfEK5SGms3tAQP9WlCZVrcq2wmGBgmdf8EvJOAWxOsYVVXGoQjol1+gQYZoXarFiT7ahhaQ6CQ9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=guwStwzC; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onJKG0xX9DvCLeM8697EEecPq9TfdPmh+TzvPRVHVu/tsqj9MnXxhd1gogPmNfab1U2qPmQD3iB+qjeockMdvEgx61vrm/I/XHsEJtXWz/dixcChdsStlQyAjFMMAe2AUqNJ223/WoJB71iWIZqJd+X/pIleE+ZozSELh6G7ZLrJ50a/sr0noza6CQQl4zhNDAoluZhiSO/AUV2jHz6TwVJB2Bu/kerqGHXcY3eM95DCBdlUe8tP7t+33lSpIhEAJWkrb3BUa/JfrunwsNBb1MmOZgpmCSD68ImUGJSuuFxErrXIvOkUOZdvk0bfloyI/y7+hDuXy9qFG7azJnoIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmKa+b07ci/+SigIR8tnvRx0W0zt+6m9eZpwmObzkqI=;
 b=mgD3pCKtQTscV4wVLJdop/TvjB2ZsraTuZd0uEsnXhqkrRO90GXx2T9c7xhwbtJiMZ9swQ7fdseNf/TiyrpDlLaGSIUPkfn5NJDohRVxkQIQuOAGLQCTyT0DrymNFai5E35F3G6iN0nlHSrhAqrL95OUxlJrow6V32wHoI8TPDYuvJ/ux1cn8XEzoaCW7EVo52Jua0GRHljgjbdAMK2NCL/EaboCV9nNqVzArsBuaomhRhaoONDvjridCqcxSR1kTglFfjGjv9ThmKLiePqPgqIWYWCGNtM8LEFH4KCENbF59j+jl8dC6sEiuWnX9aqksKbMWbyAJ+X4A6gYeLQXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmKa+b07ci/+SigIR8tnvRx0W0zt+6m9eZpwmObzkqI=;
 b=guwStwzC9q95C/j+/KgS7aCntgmCd/xDvaWI2PlYRdL2hbsxmIaPpGGJuSFIXH6jjCnk9YZUCSe67bw3RPe6Scb8qbpzPF0gFs6hWT+p2w+tBNwBwtcIm8aL4NnvQY4cOBPpzDQ6zUENdCLbd3QU5mpczFF8dp18slcY4w5j6rlrlBthKKqYVREzmBj0uU9YX7vyPYKD92DdK0JVis88d52pyKMCeXyVK6zVioHq4syWsuieuteWTKeMZ42MSpTonDfneQluKLxmXRasWhAwtj/PCS5GFL8SuvTeS0N49d29dZhN1P2ObjgRYdBTFqmrNuuOCwAAmzgkX8bDTkg5Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 16:19:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 16:19:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 2/3] mm/huge_memory: allow split shmem large folio to any lower order
Date: Wed, 22 Jan 2025 11:19:27 -0500
Message-ID: <20250122161928.1240637-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122161928.1240637-1-ziy@nvidia.com>
References: <20250122161928.1240637-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:408:f4::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 124543df-84af-4eb7-6a58-08dd3b008e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRfyAof0fFKmukAnGp3jS7Wlt1n5pQ4Dk1ssQA7wDKLw6bV/hOedUT+Md2p3?=
 =?us-ascii?Q?FfR4a3AbQHG0vsoHuGmRG+uREn8YKN2CVtiRdHfuskVhXHucoxnI0EDIe2jY?=
 =?us-ascii?Q?Lm3zQ+kO3NHluzKRfbtnkH8GErOqKJcI9MfnR9Opg17Vc60dKjsL/eMuGxR1?=
 =?us-ascii?Q?vrsa/oxQuxhgahh8wYyllhzY65+Zbg1pqyRDvcOhNt+lZEM66DVnl3pbxk7n?=
 =?us-ascii?Q?vrWYsQMgvcKBRkCKCr/9uVWk1CouowzPRI7Xms4iE8oFXka7lI4H0AzBjoRn?=
 =?us-ascii?Q?JPDVij3PcpWdr6+q5n6XjTF7nzvQKyPY71uHyvgbyvZJwHJAXisFXVh0vA9B?=
 =?us-ascii?Q?x0Pr/47KLU/80tlGBxN62b9vUmVfh9vReeN8i+299AXdjjNWNlfp/Sn479ol?=
 =?us-ascii?Q?+szm5AjbTjIRXcdCYIzGSl/R4elNyCp/40ZE9PinemZlB0QbHdUz64JsAiO6?=
 =?us-ascii?Q?GL/tgdQ/urR+gYl/GtgvKrglKQtDzrrdXSBwL7AYCfyNeQSVFJP73dhifqTL?=
 =?us-ascii?Q?rqBsuZJHFkSojZMoh/5hXR192a3V89EQ68djOmUEpcKHjrKlv1hcSfNek4aa?=
 =?us-ascii?Q?3PACZg2Q99cq6rJkOwUKBchTRGEAe418JtLc1Pd/6n9enIKVPZl06CJcfr9x?=
 =?us-ascii?Q?Fqj6NjGw4Zuh1C/1bzrbamhufnOju0ycXgpruC95ctl3HfbWGRrxvNrFZLot?=
 =?us-ascii?Q?2e99W99VN4UzAAKecL2Mwbb9hs1qJdKsYiFqMfsIaQ96cmuLH4inC5zB5b+z?=
 =?us-ascii?Q?X5Vl1FguthHNaP2ckNYxZ0y9zuHuJD3WxT2ZoF97ph683UTbOjmFSptJE37I?=
 =?us-ascii?Q?DU0yWPM82TDWJmM7kCSlkGbG+m174yPSkr6qQulSTK+3+SJI02axqRz/QfK+?=
 =?us-ascii?Q?T8ylGNXZKF9twGsuflaQMFXws4c7MNv8CEhGkaOluf+cLBD6Me1Ul9imZhYA?=
 =?us-ascii?Q?28ZSdfDtW579AW+HIo/WUxBcizpv1uiS1jcO52loppH7sVC5iI3vtIY8H9X8?=
 =?us-ascii?Q?Y3DyZvDXUMm9Zv2TKMOnYWbRgtHD2CPJCUE0ycl8OnYOZdBHbDWfVNVNT4ik?=
 =?us-ascii?Q?kp1s9XGNk9RNRCDPr44EjZxD11f8WAlu7LeZ3i/w+2FNAUSSpdTg2LnADFLv?=
 =?us-ascii?Q?zQH/cIwMlpjCCot8cK+kZccQtA2DsWQsvktXAUTk3CmCJIkzkRcgOiF+clgp?=
 =?us-ascii?Q?qzNbr4A5+8HgQywqhZmv06/W0+SUf3bMpQwqp7tqKLeqX4fryIThhfwlzyB9?=
 =?us-ascii?Q?yfrznGkxich9DaXY9y6PWVIR39qyqGAxN+YmZnDHg8SCMxTJMuly6u37GdAB?=
 =?us-ascii?Q?8dYmQK5kxtK/9Up2pigiPT4TZXEQ9jsG0plMk5esnQUz4nPlFVTs5YfywP2C?=
 =?us-ascii?Q?YHqbXFJE+OoLJn9Iwt6XiIUaI8+9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yGwt8P3SPagBa+X9Yn8jlRqnMs3fh0MY2YTRvF6eymJwHpplhWdu4wmbdNaW?=
 =?us-ascii?Q?CO6gILsP6tc5lxzWFFOkasu8om3CQHad+dBBmh1Jeo5IU4dLqk/s1RTOD1nG?=
 =?us-ascii?Q?Z0A2w4Bm+4rEFdDbUA5q3MfwMp0ADag9kW7pGEEMhKffZYI/XNhAQl8PQzz8?=
 =?us-ascii?Q?cvOqYEa+3s2U69nrGLctlpBHYkBZU5YxD9bkqMFkjqgCnhZ6q3UEaplw1Yg/?=
 =?us-ascii?Q?EesHQIZeI37+5YKmIlmDv2hZUaPMxCoX77UpXuQKz3Dw7SVWlNtBr6P2vj+Z?=
 =?us-ascii?Q?EwXkY0y3mTbr4nV7V3HJzCpbw2hhWZSP+Upa7UXoMZwe+88mtzGbaj7KACQ0?=
 =?us-ascii?Q?FG0b09F4YzqFGsiCg2WXEkRzD9n9b63eZ2nY+R1oZz8GStNFqAnEql+WxG/o?=
 =?us-ascii?Q?TAl/b2K9snK2mA6bi9QE+zeDOsXvloQDseiE9EGJvEFobwdd4sHI4qF+zI6I?=
 =?us-ascii?Q?+zWzJC29hNMcbJ9SzwgP/lcGcGvbWl+VvM3NZWTi0b1k1Xqiy8OWtkHr9QBN?=
 =?us-ascii?Q?RNEHpRryIKoL1QdfyglhcZxXVJtF0AvpyShX84ckRWe/qTRj+D1gi77EVrJT?=
 =?us-ascii?Q?c3uYoY+uYFUu+AAGiETRNjdnK89Xz90Gye2+ukpoXbrcNFZIk0+54o652qxv?=
 =?us-ascii?Q?RNvIJqxP32zUVWyyPPfncwcxk6fq71k+p8UJXIVjq76nkvGXQVvnNsAMZo8b?=
 =?us-ascii?Q?i29b+3sZJBqaxTgfFEER8Bnm47JqtNSf4gW7mFG8i54nLvnKLMrNUGKSNTHp?=
 =?us-ascii?Q?RKfNIpeYee/glJzHmR+vrbyCkxOrAiKu5w6FcdFTpcFqRPwvnAblCepB2JhA?=
 =?us-ascii?Q?WnVjzdMhk3VAKeYQ0CDD5EoUClayz6Y17Yl9423GGPF86J37lsU/JdUVQpUs?=
 =?us-ascii?Q?i2G4X2FwdnNyj7R53z/POYt/dY7j3V8qvIPGS730Y9QKwbQHjrp1H5kvj83t?=
 =?us-ascii?Q?/UMDu3C1wxs/RV7Egb+GvSbEVC9lMLNZi3PyLGg9J3qSC+rvlw3AclxVbe2M?=
 =?us-ascii?Q?GgZU2YutbI0E2R3vOerJTb+eDPHJURLlOc26+Pu5MHg4t11ekZV1wltS4WpY?=
 =?us-ascii?Q?o5DRdLGm7OKUxKnfk0VNGMirS1bKwL2T2KDNHw769OnUV1UQSlEJzPARMe7R?=
 =?us-ascii?Q?neaj7zp2optsnSmPp0dWcHyjpM2dzU2p0G7/VJn7R4zDMtTZdLebKJ+Gh2Lj?=
 =?us-ascii?Q?lZzgoK0FPWHi/ih2ZqMJUwW2yzUoZAgdlbFnAH4dQeSjciW2SfFkZqL9Htc2?=
 =?us-ascii?Q?mWu49IAvK7cqXWi5C0KW8TUNdSrr4sdpHv013iha6FCgP4f9kjdxrLp8AXVj?=
 =?us-ascii?Q?kRS1Giekurnw29/PQ6BPIuDeuFCGvTvVO5RJmOvgg2zeP1du0K4nYctMkP5v?=
 =?us-ascii?Q?hmwy+c8RzZ7cEOtXkoYXlJGe7SMfyZgH3K4PY+S8tj+eci2pSbvHKFglKfPh?=
 =?us-ascii?Q?3Aw2NsB9FFFWMM0q7Ts/pA0HBMV6b/cHuKSC5eC2LRR/CVLKOCi6Sf9LBvNd?=
 =?us-ascii?Q?VrfoB+3mB7p4ZjMJ25eZXoR8wfZH8V29uZCNVWO779UOA3LtCrq46BobVscL?=
 =?us-ascii?Q?S5tjkUCmNgoMnoIpnShbarEXvLlBkILauqrYJ4kh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124543df-84af-4eb7-6a58-08dd3b008e55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:19:33.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo+2RBiz3nKOSHV35t1E8NP6hbbkHBi8+7pp+vbt9Eazc+b5fWupkg8P+EcoQ2Xh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326

Commit 4d684b5f92ba ("mm: shmem: add large folio support for tmpfs") has
added large folio support to shmem. Remove the restriction in
split_huge_page*().

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..deb4e72daeb9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3299,7 +3299,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (tail->index >= end) {
 			if (shmem_mapping(folio->mapping))
-				nr_dropped++;
+				nr_dropped += new_nr;
 			else if (folio_test_clear_dirty(tail))
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
@@ -3465,12 +3465,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			return -EINVAL;
 		}
 	} else if (new_order) {
-		/* Split shmem folio to non-zero order not supported */
-		if (shmem_mapping(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split shmem folio to non-0 order");
-			return -EINVAL;
-		}
 		/*
 		 * No split if the file system does not support large folio.
 		 * Note that we might still have THPs in such mappings due to
-- 
2.45.2


