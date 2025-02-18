Return-Path: <linux-kselftest+bounces-26917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135EA3ACD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E464A188C916
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA21DED7D;
	Tue, 18 Feb 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAfMxFOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D21DED55;
	Tue, 18 Feb 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922636; cv=fail; b=PdGkE/HZwJvmBtSHHKk8mCheXiuRckgzUya7gXZlqbhnB2LYVvDK8uvtqpS2hIA1PvPu3JNwIUZJAaajgNxRTXVlOCI1plEFPcSsPdanoj7oS3yVQUjxBKi9TotgGAg3efMsOiIBr8fIBLLqGZKD240Yw1fwGA+h2E8mjiVpZvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922636; c=relaxed/simple;
	bh=tCCUvjFOphCgbkzlWhbRZMBbY88DhPVHyfA76difAO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlcWsWLeshygp6gBF8KfWbivKudsbkF6SRX9ZeCZB9snpN6CuY75BW5dj+bHaWv78bch0OTNvcr0d7lwbgbUolHpfvgGPuqPMqq/A1mErxVuSwRYEE1ri0qDajShsHVHcwbp520kqEsjjz0Qzb5LdMNzPwVWmTa9yuJc4bLWVEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sAfMxFOv; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JemjTtK8+ecaEKhHtg5Ga9rD+lJxRkZaODmxq91+6LNnDSVb66SPF9Po//tfy8HUJBjlWYLuwJpvP+HQPvsGAHXi8r+wWlHgX2oPitpRl9MZwjdb5/HCChmjH7nCVyGQ6SEoGK5ya344D6iQ89gGnTm7GTzcH0Sgig5UZdGZ5KDKTmMfcj8R+H6YUc5tMOtLKsT4Ukvhj1icshzygCQ2whDA2FAFSeQ6SuH48Tv6Pqefj8zEc/nI0hiOQyXEiNzHJ3/CgEwnqNEEaUjSVxPsTZ2BWh9tkPoDrgEwnc6BOMMgbL/563wIV6wkCjKHpz+lubYfmJiTOoZsr6LMCFTWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxOY1Bq1sDkRJtGmo7nmA6wB/fQXbKL1h6SHGfjliHA=;
 b=Gwe2k5sf4hzn2vCbLrci5wZlXNuFge7F5Vati68f3+7F+n6l6YEX6ZkYWkiSMR72aMO2I54QqDUeceK4/E/Jf1iAfcNZY70cPjUtmV7s+6OLy0lqLmeekel3BDxlZ1fw70a8ERin3xjL8FPMyLcrw9NyIF2WKMhEIkp9kSC2LdOqYU77CSnkE8VDcC9uCDzIj2UQcLPk32TqTGtykaE4FxtnWWJIXjrE4jbSMVJBMpdMRKaJr+ZeYq6onyreAm1bpMyS1I+8iESGxcIWckumoN6GvJlbknzNIgdiSddi27I5ON4Ul6KoDdeJj7ZWrZ3aOGVcgWgTwtgR/3+zOKIHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxOY1Bq1sDkRJtGmo7nmA6wB/fQXbKL1h6SHGfjliHA=;
 b=sAfMxFOvdO18u2B6ivg5oyASb0NaeBsn3Q2jC+UyBE40mOXghHuquRpD38ZwT8Cz1wiIheWRl8xL+4VFnq+jLlUzOIppBElO6Fl4I79xX5oPvoxhFPCw3c3ROg9LhctsnH924adWUL9rvw5KJeOHF14tdT8XUhyB4hqnJ8FYZ35sIYudUHWmyUBWuhe3KAojrTLvOA2TRSx/lGxOJqMlpUKJ3+Q8FpwVQjgykjGfPa7uO/YPZBAk9kCol2xRw7pTzYftLPc6mfiENR8nUAESL3mCZQyi22DoRFE2UUKU6dTTW15SJVKE3sNc+GY25Lz4ZOFmbiUgdhrxa5OJItwcrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:25 +0000
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
Subject: [PATCH v8 6/8] mm/huge_memory: add folio_split() to debugfs testing interface
Date: Tue, 18 Feb 2025 18:50:10 -0500
Message-ID: <20250218235012.1542225-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: efbc0d20-75b3-4ad8-fa69-08dd507703d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EbxpDgnqm4p46lF4c57E5vvG+LRogsg+0Tcl4REJ6VvhR08/cF82S3cVpYf+?=
 =?us-ascii?Q?gZfBbZ9RPdbw/flYVQlqow2TgHEJOOjJiLJci/RrAYozQy5FkpY6uRm2b8QE?=
 =?us-ascii?Q?Tm+MZjV79SvpR2p0D/tQ+sOeuFtOVBAZUPJMZhug5G/pNSyXs6bkLbBggbMk?=
 =?us-ascii?Q?gh6kMRvc8tHyIo2nMTsvpERRnUmicMqqDpA7i9GZs5zt93RAj7VwzMzf16yw?=
 =?us-ascii?Q?qOgNj4f4nh9dRTX8WQ+QsVj2b34R1GZYadQWfBnqCXOsD1UyeDPs/kA9Xv0M?=
 =?us-ascii?Q?5g/RvHis8RQ6BDtHJK4OzgWgRJgE04+t1N8M5DmIfv/lRo0KVEbi1R5Z8g43?=
 =?us-ascii?Q?3mMzJa1DMK3rp7Q/Gc0+pChJbVAfUizvah1gV4HbgR0WLBveGeBXXo32emJJ?=
 =?us-ascii?Q?x+hwGeYDleuPC49zW8kNcC1iDbJvMTUPEYHetoiw5K0VX+4+qGaw4AX4fG8/?=
 =?us-ascii?Q?VJXJ0oUzaxLvVuqYF7PgC6S0y1lr0A/YmyGF71RgoDop0NbfmNJbJpK3KbWG?=
 =?us-ascii?Q?S9Suna8jN8nTnLaEtMihHK0uWHAkmJX4KUCihiVdSI7/89G8LQCJYPUpb+PH?=
 =?us-ascii?Q?NLXEb9Bt2NK0GNoeVFiVkOg9dwRf3zFygWLn7N8mnkzV1eUpgpoy2jGZTxO8?=
 =?us-ascii?Q?HobiTPoBtIC2WBEoeiIblHB6xsZZKHdzDwfOSLFgmYkfgc+6PFgMX9zay/Os?=
 =?us-ascii?Q?sdYu2hjcULM65d+5sd3e1rIiPWSkOIlQhKWu1XeST5FpCqWKS3JmlmCDyUlX?=
 =?us-ascii?Q?Z5M239kI8bnci9l4HKANfRKJASSdsFkjUzd1KTk/ZyUfSJn1LtylXQ+vO87X?=
 =?us-ascii?Q?YemxMzGPtz2eHLcLP3USOiWb4HHyS/NtelmOQayCPS2Z0ZXCFFPY/0VfXe4M?=
 =?us-ascii?Q?P3jc4u5E+ajnr/rZKCW/bnCvrzb/LvD8nHntTplzc3vWGwGnBBY8YYU8VTuU?=
 =?us-ascii?Q?HL8WAqruCNJZqFlIkgpxrCBp7eGPmR7GQhixOXBpp4G/98+wksa/txDW8Dk4?=
 =?us-ascii?Q?BqRZZPbHPfbiXEV8jagRteuWE3rcX5VZtTzObkR7OYV84VZNTy0xglvbefck?=
 =?us-ascii?Q?WdfazAO6aMyK9LOBIap9jt+CEM8OEi1AcrdFjMjCpHcR3HyOiIZRXhl8w9Qo?=
 =?us-ascii?Q?rp8KZhxT7u6unCPhp1/+Vag8zSCBOwig+qQqngiAaLh5SPlTGhRX4YWZgJdx?=
 =?us-ascii?Q?jb8qLhqnsUVeopa8ydPg1M9KFZ1aWvUf5YSpz0PuavHO7LJVO2cIsJNyIRkd?=
 =?us-ascii?Q?pHJ9JTvNkNv6ZlbdnElUTQGQipyKulKaaVe1HwjQOzQGuOb8MOSkQI/2ika3?=
 =?us-ascii?Q?AJbJ0xY5IXusPOY1eoOaZy3pyjViX8AUemI2uNRd+B1fJI/fWAT5PiNbUU/7?=
 =?us-ascii?Q?3MTg9DT6DdRkI7dmFKXPHHtGmjwh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWCDhCAlKk0UhhQqUXFkAHF75S/MCtA/xcJGRJqvmX0dWClSJD4r1REdoUNX?=
 =?us-ascii?Q?w3jweYmMRn813dKdO71NFZRo9Rn+IAXvQMqXcz/7kIALFIzvBb8JngXRua4w?=
 =?us-ascii?Q?S9c2L+JZnWa8udL19np4FQRno988T3FseDihlZ3d0guKekFd2wTK4l5dV7uP?=
 =?us-ascii?Q?VwTmCswdJYUlxhmkQfsuDDRFs62n6AcMUVqUZx9zvq4tyydCeFcc8xRRZgEV?=
 =?us-ascii?Q?rhZId10/nyqpgo7eRU9TObw78PgzQ1syEm5aHia8GKPG9MBlZ/yheSWO5v6a?=
 =?us-ascii?Q?T/Xx2Ta5b8+P3dy9/3sX6EraPh3/nE2VwnSaSfUOW53fJs6uooDOTKolMM4+?=
 =?us-ascii?Q?U6A8pVagTHdtPsqFjhrh3sR2cMBAHqZH2XENTGTAc9CTHaoxMSqVUEH1Dbad?=
 =?us-ascii?Q?qDpCPEP8Mz8d4Q9sU5cU9aACTqg1ClatjmxCHHFdsNEvrB/1BrOw4nfwQqkM?=
 =?us-ascii?Q?axSCq7Jy7OuzMnCXuLujOfCOoyk4QBndaOV0XnoE5HvDncF3qE1+D1m7B84S?=
 =?us-ascii?Q?q8aTpP1gVmfOzf8NG2k+WpYbyWZjICRF1++2VCQ0Yo7WIP9Rn/zCiLN0pDU4?=
 =?us-ascii?Q?FmDmb4S1VovFud5nF/zZeKVsZiSaAV8Urz4CVDvI9UzPTaKvdf6ShI19ufmz?=
 =?us-ascii?Q?WI2UJ3PJ22PLXfw9knfNqsY0zS6HdXuuhU5mZmMeIOM7JxePnK8Ad0AMQ5oe?=
 =?us-ascii?Q?lXqgWEx43fFDVDmp4XjFTAF/sgFSYwvPHN190uFtoX22KDIa+lW9hRnuwj0n?=
 =?us-ascii?Q?CIeWKOC4lrLJx4CbsG2UzKaHZCOHOlv5IGtgyIx33SdSw/w+HQz/eh4Awjf/?=
 =?us-ascii?Q?zVXakqBvftON+dsCTlMdG++wJXiZq4UFiCIqUAFFIhjKmTAswEDYw+NdMHRJ?=
 =?us-ascii?Q?/24dFQCxYnHy0H13i+FN4/szlHQhf5z41F/9kUn7bgnSmSpynmBwvH2pfmT8?=
 =?us-ascii?Q?gQHKnxtMNDky9+1wJE1QxkyiuZDgH0EBgfGtKk6cqZb3akZpzv7+ey0y2XZH?=
 =?us-ascii?Q?jdE035QXkUg5dL1qh+XOB3Gpoq0UEhpBBf+uIi5t4QRtuKEwIqHXcw6KJkHy?=
 =?us-ascii?Q?rsNTkdzRKSQQQ6dBWmAhJYFs4bWKmuLvgQA1AL513LkqJx6BGXdE1aM7ju0U?=
 =?us-ascii?Q?sxdxa2zuH+meJ/dwi7ZGrxpAYEvNvTr3XSq/G3lIl9aDzSTd+pNLS4vDR++A?=
 =?us-ascii?Q?AsqBsGb/idNgdz/WL3S0fhBzm0J5oDDJ2t/akFgyCv5bkoim0Q5td2gZS5/Z?=
 =?us-ascii?Q?kLXzC9EAI9LyxuCj4saiLw7/BgeGwcVbkWMusCA7684O49qOiuUwYvZTCb0a?=
 =?us-ascii?Q?cK+1UpJanTc4vNWLFH5NDFuujbbY8yjnbgTESvux/JbnbQX6VOLH/s3ZqPZO?=
 =?us-ascii?Q?hkrXtO2aV7LyzbfHMZ1c2hsjDST4dpu9/tEetZlHMBx7RjuQR4AAnL2Rp2I+?=
 =?us-ascii?Q?ccKeR5o8wChpsMf3z/dzsHBY5MtDU3oG6+o09EZrAWdt+n3xYsNoIFC2X0fe?=
 =?us-ascii?Q?b6RK2v+PmyiHje2HJNPNaAzg+ePIXkCV00uhG/Im64PPJkbbeakbTqKqtyFK?=
 =?us-ascii?Q?Ge7r4neLv+c+xUOU1elnQsExa3CdwJCfT3YWLH5d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc0d20-75b3-4ad8-fa69-08dd507703d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:25.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XkjC/4VOgbo+C2qsXpDDzbEATgVjoG0RteJxzQn5yuWlE2J5h2sVT20zQXTFvq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

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
---
 mm/huge_memory.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ab9fef680a9d..9c257c4006f5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4195,7 +4195,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4279,8 +4280,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
 
@@ -4303,7 +4312,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4352,8 +4362,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
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
@@ -4386,6 +4403,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4414,30 +4432,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
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


