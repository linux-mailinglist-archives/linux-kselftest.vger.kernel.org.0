Return-Path: <linux-kselftest+bounces-24932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620FA19180
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 13:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B1D3A0663
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A5212FB7;
	Wed, 22 Jan 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lswE8iwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D8212F94;
	Wed, 22 Jan 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549661; cv=fail; b=aqToA1o2Oovj+YUWqNjXaRJ0cTZlibu8+saM1ZgihcC3Tyr6gARaHQt8JvyOIv2wPr5Zboa3vdEuDf3bcGovc5mHTKFPxX0Sa2Heo5mYJqSu2UWTo5ffeXH9M8ft+N7QJodwi0ue4j1RYJGkFQjJHzXccHja1fcDmZVB/wHuWiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549661; c=relaxed/simple;
	bh=IpXh0wgj+LVp4JNJ3SjMTCCzT+fgSKr+4zSn97xhNb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUhNx5RoG07hvMcu05za/hgU2Og1wX19TC/gnn2ATeetCzfnja/DaBFzkMJ0Kn/vrV9uO22IovkFT7+ERNKTtiiChWO9c+AzJwAXjdsDYIMGzIUnUxsBbo60nngvDM7M8g93Krwt9qH8nNOz7B4vcdiKm9SYbDvOGOP1qIHOPuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lswE8iwR; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+hqmCvgR5tE7bKzosGHceFHXnoHxn5lCDz2+M0pV9z7eLSfS7zy5n8/gB6kpftguGeXblvOtwSFQbfZnRCshhNihR6NPkEsq1GN8YpEHb0HQW7nz2BzkKTp/QfSwmGsWVPgwFcl+o/Qz7G/+/yHPdM6CIv0C/Fftpeanz6575WxqNKnnUdFCf9JgGWoM3tOLJoSeegSVUs4m5tjsOPnnySy1SK02sH264BNuXhGYuylfzXVGIhGp+Z7Yu60DJgf7mYuGQ0DUI6X5vz6sGxOZerbDzT8NdpqAXkX6POL7VEpxX2XYQOUfEW+zk7DAN2+napPC+AoSE/Wg7tMApSsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBvS5FODAuYcEpPhb9iFNyPgC8a+1PAcRcRcKjUpMt4=;
 b=bV1x8gXcdg9FFjBF1eTssvaH/o3aeF5Nj9V6Ub3DvUhf0yfpaekTuZ3WcH+k0WDdxV2d3Q9ORW4FP2Mf+sUmbefkILAuzFANNUzXZjLsNvBGf7l4AC80iZz3xcb7vAqFtRd7BcPRBSLWZzzwCPY5tRwJa3vmp8mWwiFvu9pZ9uo74mXPIWb1JpsWO5Irs00l4lDPGCFUSZUaHZxRVp85aWwMeNxQoSd6rYfbqciKZ96NcTTkqhRpH4l0TiBfOehz+GWwPDp0+oVF5ASBCQ7aGTNGsEWh3D6MaGfQUHYpValr3DAhZU+iEBoTcVYwZ4tGJKl+WwHBBpVAIssQ7KwCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBvS5FODAuYcEpPhb9iFNyPgC8a+1PAcRcRcKjUpMt4=;
 b=lswE8iwROIYguWToUP3+/szCFbzDQNiaYGgXtAtys3hjsqOs2JD2b+QndHW8WU6LA/e5hDwz6fTAYlqsp7lnGSOM90nzJLcoaVtUtPGhIBl7MAt2K11gJpcKCyJckEBEhyDSrUog+CmoB5zh/hFFhKL0EhsvRDaOJKfuxbchEBQreAN2v69zGdjvKGS/8APYjlsWF7BGrPQeIZcuW1WIUfNmJv/GwbT39bIq6aEpUi4jTHFWwbp3C1TA1Xv5lFlzR2giAv18yt2w6NH6GAQ/fzepLcqRR2op7NWTmOMdZOroJE0curE5EOXwvHqN3Ag5kL3R2ktVUYwAChi4wQ91fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 12:40:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 12:40:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 3/3] selftests/mm: test splitting file-backed THP to any lower order.
Date: Wed, 22 Jan 2025 07:40:47 -0500
Message-ID: <20250122124047.1216024-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122124047.1216024-1-ziy@nvidia.com>
References: <20250122124047.1216024-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cfe3d7-7d59-40b0-eda9-08dd3ae2037c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5NaKmEKIzN+STDQGjXFo4zmwYO/2T0Nh5XHaZj9RlUtOxqLRFQ4S+YQNe8K?=
 =?us-ascii?Q?iAsuYIR1YEYG8H8zxPTyzRT24xu+CmgpcxWy2E61cG1mWM2DLYt6jQbZGGKt?=
 =?us-ascii?Q?5udiJvCqZPBiROVT3AL/Klt1UzVWygWdADpSagH9HJM6/jqQZPYeQJHNGSnw?=
 =?us-ascii?Q?5jvr+K5J+Pv8/0cPdeamzac21Tin6RvP0+2cg+cmjefZkzJ0jaggLnXl1s/F?=
 =?us-ascii?Q?d0tnq0mUTnp939JAqV/a8hDAo7MWSKFGJhpAQzocWfw+bCaK/kaA/ZFCj4LP?=
 =?us-ascii?Q?9W+zj2C7qAy6tSeNfT9mtkna2/SjNJaPIL2gwD6/TXB1/sUVu20bTM3jD6Nm?=
 =?us-ascii?Q?1bNjS9/cAff8iAa3hhtW3dNQvh2ILH/7iq5DttxUoZ9NsGXpUhZJpzVDjFMa?=
 =?us-ascii?Q?ZN5KfhKw65rHwRTwWKcX0OJ6yYJrOcrFKuDq0hRDRSZn27L3LinQtV0NenhQ?=
 =?us-ascii?Q?luw2cBW9l04WmY+JkJA7ydz1WvPB1JvYmrAOxMI4SZznBGcvBxHUEBwQc1Xh?=
 =?us-ascii?Q?yammNJ/29qmOswkoAv6+uXEz5SdsNYdibo0LTgFYOC7bCGO8qmpce6pbXIHW?=
 =?us-ascii?Q?L8aDlQMG8hTvrp0PBH6yTWBEDAhcl2l48Vrwwt8Y9oFCTqRzd15l1d2DaKaA?=
 =?us-ascii?Q?fkl5ffIy3GLFMo18DaTT/38AigXD3YhntVOUeXX8IMTa2diaurZYBCmWTIkQ?=
 =?us-ascii?Q?he2v0cREIumuc9xalNczMnlqXkde/EIuB33cfLIIBOYf0f90R6Fh9F3CxOUO?=
 =?us-ascii?Q?Y36MN607h8XhwnszMcSse6yrIDbr1Zp7skEeAHdiKuMnjbBvqe5PU66/39WW?=
 =?us-ascii?Q?0xx0EjURNfAaTjwFwbDRjnrtqQgkEANTo+McgJOYef0cjTmXOFwSgXAD26h0?=
 =?us-ascii?Q?GMzl3KivQhtP1Ze/J6aGITjItfj8LmsQk1gDXFICQcHxibYO2Q2uK3Yx16di?=
 =?us-ascii?Q?kKapfWxkm6vcMWP+L8BGZsgNS1dvGOu9yc0RNcc5l97zkMPtPOW8VhIJtvaW?=
 =?us-ascii?Q?IlA000frN6aA1opFi5alH2w1Qauc4A4EsfZKr/5Gm7OlM0nvM7Dm4beC0qyD?=
 =?us-ascii?Q?LNL7FH/u0jHmMeGC7Vu+eCJNLtMG8/UfAzjriClRwHCAD7kSQeJ9p+dN2aWJ?=
 =?us-ascii?Q?5YNo4Fd9So5QKhAlGAoETVPTBi3TG466BXq4Rlv5m82DqxmWGcZZgfuwKtsQ?=
 =?us-ascii?Q?gAoz3ZZMgEnH9XDz4sKanWO7YnPgcPAF8nIrOSFeLfXQCYRaL/IPZ74a4zYw?=
 =?us-ascii?Q?rqORUfEadZQmDqtF20keNR7BihM9GjLh9kl5S3TFxnQelbdV1fvh9YwdjfWA?=
 =?us-ascii?Q?1Z6LFScQBh4YrbgLoHMBL2DHwYPkGcUZ1/qHBmdK9PrY0SYDDD2guWVDUVs6?=
 =?us-ascii?Q?vd+wiTBxRq4Eryok+5x6DBolCQ8A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aax+uU1jzB3QJODOaIt56kfzmdahY8fhSrYra2sJ7it8ZhgLud1JH8XKvcG?=
 =?us-ascii?Q?k/Wt/2hNuIj0ODQfUjrvjsAA6MBnxc/bWgOnybC5xgDL54Ok6SFUXGdhwKAW?=
 =?us-ascii?Q?T6q+vXfBXWaWgUi8++3REaOCCsBTyk38X5mDpdtd770vfM3thyAcpfPzsxZL?=
 =?us-ascii?Q?cZ8a5dqhmYfO+RKn0BE6pSiHt2JRIeMVIQyEzanT9K20QAgJib0WK3HITRe/?=
 =?us-ascii?Q?HaHglXe6GnHZu8w6MYe81MapQV3xHKwDoshlH+YLp/nV0Y6wEcJmLwI4uRZH?=
 =?us-ascii?Q?cls4a5csl2qMBrQO8BZkS4DptirgH87tCb4+zqWg833DNddujkGBSt7rhbjo?=
 =?us-ascii?Q?j4rC1tT/DIlIk33HyJXxl8TRG5pwv94NNA3JWOkwd2DcPOpzXADSQ/TUda0s?=
 =?us-ascii?Q?B4qoh3Mb+p2GV+p1IShHom8fPmFUZS6vv6yGtJgUbV0pTR6UjIuKnnwnTyRG?=
 =?us-ascii?Q?orGI0qZPUM3Ht/eehboW/HdnI+8N3mWtI9kzb38oKoKLvAUoBk+kN47XlA8n?=
 =?us-ascii?Q?X/NfvsGRCckUxjCgIvQdl758bUUZYIvO5q2WLetN7TpomgP2eJDrdmON+TzZ?=
 =?us-ascii?Q?l6f4pr00dYvnKb9echqps/t8FkeZTUbj1ImxHE2HfrDXChK1TuBUFcAB0buC?=
 =?us-ascii?Q?+sTwOe3G6ynICMZdNqszC/B3nqDpvNaxorQdbM79ig+8FI9Pl1w4YrvcnO/Y?=
 =?us-ascii?Q?MgFMZU/q3SC0F2Amfl1L6biX8TBO1CuSsV0mg88Gx1iB68X37yeE584Ii51v?=
 =?us-ascii?Q?8uYK2zZN1v+/gKk27b82ZIgfzjmst32c9M8VtoIuQf2138CC6QIStdQ2d8bQ?=
 =?us-ascii?Q?2nd10wTfB99x+8oicqC1foXDoNLAAB/liGnwI4Vz9AZPe8b67wxvMj8uBz+Y?=
 =?us-ascii?Q?6mtrn8iEaJBEbVd46/QHc+ci6xyRwOCol4j9+yL59uWZa+QdENZ6I23kKBhZ?=
 =?us-ascii?Q?Yz3IcCVbXiKY+wFdLanrS7u0GXJUNXX/kR7u1uZAoMQRIDieCM70hL6ujFgX?=
 =?us-ascii?Q?8IaMuB647uDRGxcYUhAC+Kzw/dMxREhZJYrfBk16uGp4LqFu68bbYFg4FL8H?=
 =?us-ascii?Q?ulRoYx53vChLK5wgB4t5lYCZ2l04/BT1nytFmTKViHQM8ujhbIwBdTohiJ8t?=
 =?us-ascii?Q?AqRYuZCDUa8C490x9yJsj/Pbcw437iEjWNvnj/tfJGPtoPewhLFGvfCDLpQW?=
 =?us-ascii?Q?vo+l+pa7WWApvAn3cFloSlsdkPiPpfeKFesv1KaGFoGb1PoC5ksr9vM9Li85?=
 =?us-ascii?Q?MOmwXO4+/AEH9cGdEV9brq1B9LxBVlKCBMwd7yX6ZvMusKfDKDW0EtX88kt0?=
 =?us-ascii?Q?MUmaS1l9wxsiI5QhUu6kKoO0ZOLyh/6oy8haudCL3Q2t8cpOiJgnNlnRHpkp?=
 =?us-ascii?Q?VNmaZeOHprrWkeszxL7wd9W4n2O2lyg3a+uZM5DMFDxrwNbFOm7BmGYqIOwX?=
 =?us-ascii?Q?xSAdMJLQdPftahkpDarY0w863HGaPQiGv99nBhvg/wCMWz/8Xld/6DdcVEoz?=
 =?us-ascii?Q?JLReR9tMB4sOSWytzBpgAbK7ipFJYjnfo3VvAAJ3yg6WSeVjxNpZyukpZG7P?=
 =?us-ascii?Q?BfiW7Cqz+WdP4Xw6lttQLg70mAEbLpadk1LzJl3P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cfe3d7-7d59-40b0-eda9-08dd3ae2037c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:40:55.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwaBEjgLeYix6VI0s94ir850c6jcLxCre7cTBDLetEiww6Rjr1W0BL2ratzXqKS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619

Now split_huge_page*() supports shmem THP split to any lower order.
Test it.

The test now reads file content out after split to check if the split
corrupts the file data.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../selftests/mm/split_huge_page_test.c       | 32 ++++++++++++++-----
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 8e15fc9dce3a..13ad5ac7d178 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -261,14 +261,16 @@ void split_pte_mapped_thp(void)
 	close(kpageflags_fd);
 }
 
-void split_file_backed_thp(void)
+void split_file_backed_thp(int order)
 {
 	int status;
 	int fd, shmem_sysctl_fd;
 	ssize_t num_written, num_read;
 	char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
 	const char *tmpfs_loc = mkdtemp(tmpfs_template);
-	char testfile[INPUT_MAX], sysctl_buf[INPUT_MAX] = {0};
+	char testfile[INPUT_MAX];
+	char sysctl_buf[INPUT_MAX] = {0};
+	char file_buf[INPUT_MAX] = {0};
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
 	const char *shmem_sysctl = "/sys/kernel/mm/transparent_hugepage/shmem_enabled";
 	char *opt1, *opt2;
@@ -314,7 +316,7 @@ void split_file_backed_thp(void)
 		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
 	}
 
-	fd = open(testfile, O_CREAT|O_WRONLY, 0664);
+	fd = open(testfile, O_CREAT|O_RDWR, 0664);
 	if (fd == -1) {
 		ksft_perror("Cannot open testing file");
 		goto cleanup;
@@ -322,7 +324,6 @@ void split_file_backed_thp(void)
 
 	/* write something to the file, so a file-backed THP can be allocated */
 	num_written = write(fd, tmpfs_loc, strlen(tmpfs_loc) + 1);
-	close(fd);
 
 	if (num_written < 1) {
 		ksft_perror("Fail to write data to testing file");
@@ -330,8 +331,22 @@ void split_file_backed_thp(void)
 	}
 
 	/* split the file-backed THP */
-	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
+	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, order);
+
+	/* check file content after split */
+	num_read = lseek(fd, 0, SEEK_SET);
+	if (num_read == -1) {
+		ksft_perror("Cannot lseek file");
+		goto cleanup;
+	}
 
+	num_read = read(fd, file_buf, num_written);
+	if (num_read < 1 || strncmp(file_buf, tmpfs_loc, num_read)) {
+		ksft_print_msg("File content changed, origin: %s, now: %s\n", tmpfs_loc, file_buf);
+		goto cleanup;
+	}
+
+	close(fd);
 	status = unlink(testfile);
 	if (status) {
 		ksft_perror("Cannot remove testing file");
@@ -354,7 +369,7 @@ void split_file_backed_thp(void)
 
 	close(shmem_sysctl_fd);
 	ksft_print_msg("Please check dmesg for more information\n");
-	ksft_test_result_pass("File-backed THP split test done\n");
+	ksft_test_result_pass("File-backed THP split to order %d test done\n", order);
 	return;
 
 cleanup:
@@ -523,7 +538,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+2+9);
+	ksft_set_plan(1+8+1+9+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -540,7 +555,8 @@ int main(int argc, char **argv)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	split_file_backed_thp();
+	for (i = 0; i < 9; i++)
+		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-- 
2.45.2


