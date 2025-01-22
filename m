Return-Path: <linux-kselftest+bounces-24951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE2A19652
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519C5188CE2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B0215066;
	Wed, 22 Jan 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k9n63MOT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AB21504A;
	Wed, 22 Jan 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562780; cv=fail; b=jyRaosC3O4OSm11iixxVA5waZ4CAVo4xQYMcpa6caQGGu+xtn9kJG5Pd5yxkjTTL34+OdeLdIhx6eBiGc2QhStyQ6NfrnFdb/1Qa9o1kn8WrC63NQ8eVnS98HPdkWZByM7yV+uYJ2fxHEGaKhYR1CXrGlvnnZ9qWQ5mv4AvfCzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562780; c=relaxed/simple;
	bh=V/jOFLcEpvPUT7OuvMDEFTRwBXNlyxYgCExfO3nPrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQ+h+xJ+cF6yKLmI7j39ltQi4nZZiUi9974B0Rv3blQJHt0BynXqXXJq8E3g5gQbbSYNjfI29N7LVqaoV7yw2JNoz8JLF1l1nSXv0ehB7y9AeqLXflKSUAdtu/F7foch4OfmiWxB4KK2se1aBqWHgk9iPYohV1Z/HqMvZonME9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k9n63MOT; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxfoSmQJImtiuhY04JKlLjxX7agv6fE7oc9UTsWTMcG5P6aSExSap0R2+w2xHt/VHnoi1VBHATKyS43OWSaSJaae75FCiQGKMG9HSGp2mPY7G2J8Tbg8nFMME5HnFbnRQTyJPTP9K4yJ8o+OcMGZ/gtwX5D14kggBE2vVjxc5Pia1g9s+N0UW4IphF8yHKHZmMlvBrwGG0evPBAlCcpyam/vkj1wXMQzbE8UQ+DLdH59gs9N+cABv+S3uQ7mJH2NY/VsMXJgWleds/ByLePFvOFhVqFYUCqiuxegQHy9UbWQt7qLXR6wigkI/CByJrd8zNHbFXRFW4w0jI1H0RHwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF8d9XLiN6WC96xqKlYZ44y8IA4KQjYYKivV5ZwOitA=;
 b=Onr8qd8KH0Fy8jcDJoYJdYV5Al+iCKOpu+eEOupnYryTUQF66rNLzX+bT7QU6L6mS2Dl3qcQWS/x7geKhP/j3b5YfC56UabHma6TBGR9iWh2+zoP1c0VDS9FZlWiGOR2pujMhvxTeSDKDdVrAuo3KLvN9bwhGlaSC8KPsKEMO1rB1P1ffBxN6bh9+qFFJOOzIKb/n7CnP82XcHv/cPazC76NJ7FDnNJjqw8QEp4A/5AZjV1GpelyfCvyVRNzsNLEXC2DuEtCK5fK1JYFgoc27ENYl/XGKPqYlpFjhj0ssu2e41jMuO2IsY4dYITsG9lfWh5zLLyyfUDkkTo/NJYUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF8d9XLiN6WC96xqKlYZ44y8IA4KQjYYKivV5ZwOitA=;
 b=k9n63MOTCgayl7UTdo5quUHKNxeeagrx5QFwUQVXziV/F+qgNzJMJrAgxHLybxTYVt6TvPUT/9x27XLoJk66LCT0nWEVcZYOXh2w1A9sR++Nsh7qJn6uFhy/k7Jnf1nRuH3GR3sYWWl7ZTAuR3EAfMJJ8cd6O09Fn5l/0zqtzuVs+C4DXBJmOz8Ba+97XmDieqC2dYF1x+f5RpaTkkIIwhtiUgi2wkNyOCROs8Nvl7J5h+poUJM/TB7yEV3XSY7jCGLs72StVSfoi896xe9ud+M0oSOVcxQsu0tYZmZq3C1ky/tDS/HjIgwMprSf6SIlpFu2IpGxcXa0sLgfqgAP5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 16:19:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 16:19:34 +0000
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
Subject: [PATCH v2 3/3] selftests/mm: test splitting file-backed THP to any lower order.
Date: Wed, 22 Jan 2025 11:19:28 -0500
Message-ID: <20250122161928.1240637-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122161928.1240637-1-ziy@nvidia.com>
References: <20250122161928.1240637-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:408:f4::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a72387c-28cb-473b-defc-08dd3b008f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txK133kwY0fYSmg7aw9b2gLrMzPVEbBBB2L34zMxpNyJdSmK+Ahf5DJWGLIG?=
 =?us-ascii?Q?UIdp6pwVYlLFZy1Q73i9hJySl6miBFwW7T4e19UxtbZCRNFlfi2jvEUqRlnP?=
 =?us-ascii?Q?pts8MjdxpTU2sUCcXDyw9t/L6TOVFQ1V4PTsll9araJZcp/H95hFET1MX7xb?=
 =?us-ascii?Q?j/yOT4NBjEVz2H9CJhxChg4vFhAiQ5mV9AlXCcOe5dAQmuh1Gy+2jsNrchoc?=
 =?us-ascii?Q?Cq9P/Id50RpvLQvfPAOyDmpLU7LyPD2+lkfEnEO8EeXsNgOGn7JtUuyYLyr2?=
 =?us-ascii?Q?PsRDtrFm9phXCHiyMdSH1tAv2GAbJ5kx9zQ7481lxeQb2zrKDMEIW/RK7rOr?=
 =?us-ascii?Q?r0VOTqm0/ebYWCoiGXO5aEVj71/UGQeJQfYCeYXhfEhnY4wtcKM5XTfSI5/k?=
 =?us-ascii?Q?Z6wTgo2le7TL8b0pZ2SUmSOc+YK8UGiXjHPW0QtZjkU54E2bC79XBOYdw9UQ?=
 =?us-ascii?Q?axQnMB0oua7xmb7HUz6gACHDj3w9cabXlU1ZKR7gXG5aDXIGGIjVB3enpNbF?=
 =?us-ascii?Q?04cRbE7UMxA/cgBeYhbNVHFqhWszMYifflSb95mSlf2V8doW4bQCuZuqUmk5?=
 =?us-ascii?Q?VMEOSlmZ5pAOUanhauZOkNprsVyQGgBWWo3cTJxQTz2FZcQKZxYkeXGu8DVW?=
 =?us-ascii?Q?Dwae6qYxsXAtl+uNct3WwN4nDDA+iZ9k23XJegH9iIJ3FagCAoNChObJf8FC?=
 =?us-ascii?Q?EQxaEQGp0ArHImiY1dA+Pb5DoT6XpFWw6om5ZcgPKH2Zqt7IY5ynzkMK7As9?=
 =?us-ascii?Q?ZEeD4O1TrZFIsd86bsZ6WQEa0JkzVzL8EvsfQQuIGCkAASoxm5HJdV6D6JXE?=
 =?us-ascii?Q?lqqRo3jy2knuIrCyk0dc4xcYSOqzi87vISXnCf8IeafuWinJO80FfACCBEmq?=
 =?us-ascii?Q?OK7m60s6ikhWzaYkY2Dal1HHFHDPeaDq0NZXrzb91M6GntCpYtW4rqlNIh15?=
 =?us-ascii?Q?Pk+Qsf4czGCSbNq0E18p/LsjJ0jx2u13ZzLKzimlgXEDl7dYBjqivt1xIVXn?=
 =?us-ascii?Q?pTqYdppRYGCvbvMd3ZlZ/dfw4ZaUNmT9UZ4iBgo3j7/uDsAA3M3J7cpR4aEs?=
 =?us-ascii?Q?IwV/dcuDdnNbEQjm6UAFImQ4lI6gD4H1F0YnfKkQPhBvTXEXZTOZR9uxn9NW?=
 =?us-ascii?Q?xh/JaaRX4PWBVgPufyo3DTUQE/xk2ThJHmLpkdxth6tXQkLwcDSweoyBNCH6?=
 =?us-ascii?Q?+5STWyojEl9FBW2tl6JRKn4mvTaYdvP3pMq3ZgF+SoYZIhFTL5M7c7Z5dlsY?=
 =?us-ascii?Q?ITx3yGPNt0Jb+wv23aXv8BPENplnO8Dt6AKlYg3TtScQf/+Ms8rBGS+IFBmF?=
 =?us-ascii?Q?oyrimhy83hUIBSX325Sq2gFCv/31wg6KMQT9nh8HGa3Zp7PdLrxDtrFAC9ly?=
 =?us-ascii?Q?nLKyg7Te25JzmKIXzantjk0W5x2v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CBEIpvsELwpic1eHLl/9DMe41nIrE/oYd5EVV5hFDQgmfDUnrufzmty9Jueo?=
 =?us-ascii?Q?LgHhjlDNSiahRlQfyPgzzhqDQvAh92bwJ/Y4mc+52U1ZKphgC+s0zvNnpgow?=
 =?us-ascii?Q?DhJ388PHfl/67ZIHubXhkdaLryv7RQ6SipdzfyMIX8c0JOGQDIid8om0S0yc?=
 =?us-ascii?Q?5ujMPoPxdhPstFfrgncrhOblu6H/JveNdHaQk2j2o33RUHcwCFSRLq1T+RP6?=
 =?us-ascii?Q?FS+R2XXpy+LSEgdae9wWoR4hzthdjiOYyUztox0DEzn2n5zeiOJQoQeRFt45?=
 =?us-ascii?Q?LaURz1+PkifuywI7uGep+35NfK/lFJOIpdwt+ZvIgN/wwc8e3b6q2+E9UrWP?=
 =?us-ascii?Q?9VxlbpKD37+mAlzxTElXsGeIDJvQFaFOhR70aVhJwHPmv8WYDY4+2Nm7T5E/?=
 =?us-ascii?Q?iDslTahuBFd5EgF6grlTIZwqEmughVP1lrtHFSAHD5gd5FUaDVItfNDRVTmU?=
 =?us-ascii?Q?zsWe+g3JmUp1NxLwtIOAVok+5XxNz1aJGjA85LqFU/hOxvKQduefFsTECCl1?=
 =?us-ascii?Q?Nt/iGUbLgDjNf4kGKfzftf1z0+l+HVEgarIcK/PbjrBDtoObD3W8V1apqPFX?=
 =?us-ascii?Q?JoSOOG98eV8seXjMXBnrEd1yBxiPngExtrMp5ZIv2ScjZNpzglsSKJ+oBlwR?=
 =?us-ascii?Q?xONF/DHYhAF60XXOiEMjT/3EHEFSBoznGh8Aa/erp7HJc1y24EA4vGcyzFfG?=
 =?us-ascii?Q?g2hKMYDvUu478Xk8WEsIeZ9fxFq44c1YzSjk6od7IeaRIyf0RYDSgnBMTEWl?=
 =?us-ascii?Q?WOYV00eMRAal25VJFPp5hsVzYOppeEs8WnMAj9EmKnBPRQAk/+tcHkyihoG3?=
 =?us-ascii?Q?Gk+QZP9k88/OcnoBz3s66wVASpsRMD5TyT2ELdok4HxZsNQ68F8lhhkt3f2/?=
 =?us-ascii?Q?n5QrQI0V6iAXim8H5BXOeNqCyi6TXW0OPvGeXSFtagMwQjzIPaNFqC4i+YoR?=
 =?us-ascii?Q?8DYZRYl4holH6JOmE3QjRQ89vqSaXAJ8mzcDEJ9bXYfN0vtStxsODc93Ye89?=
 =?us-ascii?Q?mDK/Huz4drNgv98ApFPDoJxQjj2crgHA9aVpX2CEWOTq7ccjtz9QpwybDSJW?=
 =?us-ascii?Q?PT4kB3wk9wlq31JAcNId4i0eTDVqYjWh5m3uNbovkCPJMWYthZWP2UMprU0a?=
 =?us-ascii?Q?RANlIyUXFj++kOwWX6WKQC4rjpVloKATDoNa0CCjhtKr6l0nSekno0eu0jGe?=
 =?us-ascii?Q?BmoIGqBj7VGbjwE8+IARWYS9nLeOiOj6tOgbuNB7f7bI0XRG68Nb9wd7Iz2S?=
 =?us-ascii?Q?/Oy3Rim3OT4B/k4NvpxPR02LlbrLroY0iCMYYESJzlEPJjN/B9dxsiEolI3d?=
 =?us-ascii?Q?Ina3rv9QWW+L5XV5scfisBxzLghuJ4gsWnRuSapRhkgkf0Et8wAKfBzplkxL?=
 =?us-ascii?Q?zVmA7ATLaBMk3RDqxKygYdQq5HHXQJFoZoSCgB4TOjUZZpmudHkTPVSydJh6?=
 =?us-ascii?Q?JZjeAu22RDdEtRY7LLpI8vpTnEK/lhoG6nCKe81JP+qLMmTu0t2IBZE0/Arm?=
 =?us-ascii?Q?S2gq6wiXA7IjoEoxvPscc+Q3JxCisZBVJjCjzZyvoiL48Kl2RdWfmRblOxUo?=
 =?us-ascii?Q?j/+XKLKfNJFfwbEwx5+0g+jSTbxdP57R4O3Diqzk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a72387c-28cb-473b-defc-08dd3b008f50
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:19:34.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXmrILx0BnkzQS/8I7Dzan155r1bPIdDfbXERq+6cOwXgjUoGM1m79B168z13kZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326

Now split_huge_page*() supports shmem THP split to any lower order.
Test it.

The test now reads file content out after split to check if the split
corrupts the file data.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index ba498aaaf857..e0304046b1a0 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -261,7 +261,7 @@ void split_pte_mapped_thp(void)
 	close(kpageflags_fd);
 }
 
-void split_file_backed_thp(void)
+void split_file_backed_thp(int order)
 {
 	int status;
 	int fd;
@@ -313,7 +313,7 @@ void split_file_backed_thp(void)
 	}
 
 	/* split the file-backed THP */
-	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
+	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, order);
 
 	/* check file content after split */
 	status = lseek(fd, 0, SEEK_SET);
@@ -351,7 +351,7 @@ void split_file_backed_thp(void)
 		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
 
 	ksft_print_msg("Please check dmesg for more information\n");
-	ksft_test_result_pass("File-backed THP split test done\n");
+	ksft_test_result_pass("File-backed THP split to order %d test done\n", order);
 	return;
 
 close_file:
@@ -517,7 +517,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+2+9);
+	ksft_set_plan(1+8+1+9+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -534,7 +534,8 @@ int main(int argc, char **argv)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	split_file_backed_thp();
+	for (i = 0; i < 9; i++)
+		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-- 
2.45.2


