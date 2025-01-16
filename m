Return-Path: <linux-kselftest+bounces-24677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FE0A143C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EF87A17CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322581D61A1;
	Thu, 16 Jan 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIV2QDRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9D19E97C;
	Thu, 16 Jan 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061859; cv=fail; b=o8wPgAR+ehoAPJ+LUscphxCPWTXOFd0Q90XW8Jc8h05SkA7+qj2NS1pck1tOHenCD12y//U61FwEx5yUwwuZkbqlBSa47gBLEwvUbiGUX8mY6qBk+0EZ1SezOyTPmvo86/sRP1jUSI95Pfe+35d9Zj4EixIIiftmZtDbd3YsUn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061859; c=relaxed/simple;
	bh=d/lCstPp7EOJ/jE2ClefAlg/qguR26Uo32vLSHP8m7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcTemO76Vp7csMUuIuT4KjX1j4oheHGOb2mUqfrl+mF8V/7K76o0PJBkLHfJkkCiUHBhntfGda+FJ7/1rQvd1DrS5qHdclSt3l1TvDDIxo2GoqIF492EBHiNAiu8OcA9RisphCxySLIF25AFISjydHji5NaMi6HgeQ23ZWV7xmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIV2QDRI; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bja2NtGRmqmEKLFsECucxH04TW5i0OwOv+S9K0nAU5SPrfRkmjTdvOuqaZalkI22FHUMuYCPi9aY26HBiloGqSAtJJbpNisF1JrOj8ehBcJZgv3hsr/+snSNYoyVwSeyVsaOP54Xh9yhDFtM7OWLjjAagTjX7EfXTgCOXInFYJCTqvFnFI6iG7tGSYdnA/1SlmAUPJ9dChFjm6wPxeEYrLzkbJjaVUTeloWhNNv3q06DCkmkFI7ORb8TwuWh+w1RpoTxR/Dxa2BETl8FTLUckm1KKA7JXY1SS+pz9Q39FuARyvNER0fw7UvXQNd9DnxCSezCXXHtSXTg031AZHp1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajaS7n+WGXRJAvfkeoaZ8Tj/oSeMGu2/SX0yKVpH5HU=;
 b=rUP1TcdOjP+IweaPbjuLGfsFgVzCUlq/1nMKtsdXdVZkEzmEVv0HTsAcrwvnOoZu/VrhFkFfHhp1FEepf1WFSsh4NJcjmlqpoelSPZT1oW2uAVvVH5BvF462HZNynuQlbxToS/qpEs8XoPuG9eolGwDI12ujuHluBco/RO+P63Oo/HpE2aY40uY5pzsCDEeGWatAMdPB+VQjxsU2BjNmqCN85GIkFr/raAnGtjtNfpCIzaj2l5G05kUBM565alJdLst48iFo1eNEZ0ojG3woNGXGXpbkAXUy7SGIW0aHGINSVEaaYqXCYFkjszhAn2mhyTaP3aTRAA9bChgUoUI04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajaS7n+WGXRJAvfkeoaZ8Tj/oSeMGu2/SX0yKVpH5HU=;
 b=kIV2QDRIUb/ArRiobVUMJjqpmEA2LY0lptmasyaF4JhHSi4ZiI6lT8BlS4xjdxmBdnZzF11xOgbOr84ZKdimAS9+Wxzkuo7p7ZeKGF2LRff6DAWQ+kgZM36OB1GofiXhmYMxR1paSJ0O5LQzbRLxsLHH+PUP3L9fFbmMo9CFaK9KT8o2HdeNliGDb7bIx2Pp2OPLH4eMI//OLsCntYDOOZTaLGOc+Y6baCqOrcskV3jZ0m73Oe4ayx2FXb1kuez0DwCPnNm6qYVFjq3TX3gsvYubN2FxTpPr9lnkbBRxgkG33/ZjwvuRlfqKzhnCNRoyeQhcRZ5e0cDtZUsOsMOx9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:10:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:10:53 +0000
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
Subject: [PATCH v5 01/10] selftests/mm: make file-backed THP split work by setting force option
Date: Thu, 16 Jan 2025 16:10:33 -0500
Message-ID: <20250116211042.741543-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:52c::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f4f078-c1c7-41cc-3187-08dd367242a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZLq7XbLqEM5gwUs2GyGEdZTP3/u7/XK2a5IDAMTC6G84U8Qb3yJlLCrgWAdX?=
 =?us-ascii?Q?AWO6RJ/aEDwWP1mz1G4Iyas6ERcTak6eM5RfEVVlQGt/HakdW9ncYnpcTQhU?=
 =?us-ascii?Q?36O5yx1yVBe6Ii/EaqeqNbLZDWbJPg699a9c3Go3J+evUZVLCePihT/Z1zQg?=
 =?us-ascii?Q?ziRfXKVM6Q5lGwlw2zVfM49JWHy9jj7Nri8qU6xhw4W7e/UMD4dMZ6qpth8A?=
 =?us-ascii?Q?LtobVeil7txLMv/B1npZEBWINzPocd6lk8kHHmkolBt2SRJT50lp38seywV3?=
 =?us-ascii?Q?WFwSysUF5zH7ZSxBgpmal/wVuxcYhJjnv8afTPWjcbg3hKrEhUt2R+jefMzC?=
 =?us-ascii?Q?8+CpV7EBB+Ac0i2EwmtE4qrhMlYYzOGQTOl4mUTy9d7MD/Q1ya7xECS/pFtn?=
 =?us-ascii?Q?JyG3ky6OtRbXL0vVxDTnxnJDrFZzM98WSUN40bynbgpjPOqF2zWZi1V0SmD8?=
 =?us-ascii?Q?CEDYUiT2Xu2tXzXcZrAAHdJ/cEVqlmElLqvG/WUyt3CeauwEXzWhzzQRNQwD?=
 =?us-ascii?Q?E9voRPxEDKES1zq+SJc/W02caQALO3D7v8OCnWWygq4hoJrkk0CoFaPPZVOk?=
 =?us-ascii?Q?JzOCoPPEj4B/Q8vH4iJq/xUpUe/9upsx9i075Vj0SqN5iYtZmeGyRy1psALh?=
 =?us-ascii?Q?2mkngApBjy/CAQ6RHmB0c1RIhqydONoTyoIS+8CqHa6RHqtP7QcDT+Zv8Lqx?=
 =?us-ascii?Q?tdmzpjOR6otq41RtLDaUMDwf3iTKCg3+qRuhJJmK0XihxqRtfaSIEm3jMPf2?=
 =?us-ascii?Q?YB1A62KXsvIB/AuUgQWBFTEa4VWyZYwg/J3+DpJ48WCTrhnLweeabOyAq3xl?=
 =?us-ascii?Q?L2RASLVZdoUiqsw+FJlOD40zdcED+E3qzBKLgwEyqY3w1LjVs4eKFdFfwf3P?=
 =?us-ascii?Q?5GqqoJfpif9VjBgE1+K1phPFaW97219dbFk9IFLx76yzAH0kvKaJ4gWNNoBI?=
 =?us-ascii?Q?KOqQUggvLqncfG53DN6piyOFmyyESDWVbGGWUBOeR5kZcD0GucV3jTQER8Sd?=
 =?us-ascii?Q?GMuDSFXxANWzwMreWm38vSEABf8SsQPW2/6vpYNB9/V9m1+1WpKko2s0RCLf?=
 =?us-ascii?Q?GUgUXnC3sHa6MBBtQabJIEa4R/i66jj9W/ZsQzgkfMcH/dcFytxF1hSELsbQ?=
 =?us-ascii?Q?g5+TgGY2BDhEq/slx802jtXwK5pJ0gkB2OSeoSx5kDCOF7pE3F0YkpGE6BjP?=
 =?us-ascii?Q?hQxw+mGq3Ntf2gAcvMfxajxxu0pA0hf4zIAVOxqeERiEQVwNtGZ5yEzEImFQ?=
 =?us-ascii?Q?gJPjsObTkc4NZkqkqJMtZjHBJoTn1m2VHezC0PHIDjQjN8VFmR62e/8yzwXN?=
 =?us-ascii?Q?jVeG9YvrkzsL3InVjFKFOUOm45blTWkUajJOxb5g7jyI+hZ6gOIVUgjKREcy?=
 =?us-ascii?Q?zFKS0klbng0nxGfDlF6svZhG9uUn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GsRxZI65YgwyT5BXyVJO0ePq7zfdchmV+N7P/QnaDaXms3jb4LdPOfbUk67m?=
 =?us-ascii?Q?hdO9YQoqZpKadRHLbxgVNydU3qnrHsIu0fgYIVlW+zoWa5SoxH5oTtGbtwsT?=
 =?us-ascii?Q?cXtU8K915rZR1RrR7VHGsRYTRCYzok87S01KK4ccpfkiBjVyMrvWgRp0dkj2?=
 =?us-ascii?Q?Z8MBr/TLmCEL0MQjQNTYAi7K6Efyj8sri1ANA1IXSY4ED7anlnCeGPCfcNi7?=
 =?us-ascii?Q?Xycb1/X5uC877fJp76/xWcIAfYwCqJaQv4FZwoaRt977hCirnpHoyGAl+/kg?=
 =?us-ascii?Q?N5v/gE6KfkD8rUPV+hLDS7j1fLrTvIyVB+2Xm7lAKH4h6rExpFEIAYYQGBE5?=
 =?us-ascii?Q?6E2DW2eqdz5J1nlunkAgPx+EcbT7Qz8aT/7LeilQFoysCMYb0sXpvHD2xJL/?=
 =?us-ascii?Q?qHucJZ3TY4iAUriDZD8GcSuQ6cx49JqaYCF4/JkzkQ8aHrQpJr9Pv22hPf0i?=
 =?us-ascii?Q?83W/UxXmkrcbPISPTWsuPdSqfZRjgtr/u+B/HFJXQLuQ1nDaeASE8Er6Z37+?=
 =?us-ascii?Q?lsGzk0yDen4DrgK4Wo16Af+rycWDVwkL2pgltT3vT9C9J91EmTO+VjK6w1fu?=
 =?us-ascii?Q?jQJOM5Fp1Cn6wT3m4diTvlhaSpR4GdylI3zsovg92Mbtf5PfSJX1DRDVayNh?=
 =?us-ascii?Q?e2ApsnT9Qrcn4P0Te8DZBgp4GyLQK3ANvl5MYwXIUhC0etFZUvzgJHPHKfQG?=
 =?us-ascii?Q?hW44rDhoBeyYV/vcHN8IPs6q9hTm9fSMV+4W64aqUFhaKuyoXWi6JtyT1g0q?=
 =?us-ascii?Q?4d/iFg1e/Yt+/4+YsgVOT+IlO5LfU8EX93vJSZDK4KrA5Lh39lPnl49maciS?=
 =?us-ascii?Q?g0C3zlZmZDAL00ID2ub0thkmK2Zndiy9aGfzUbFdZN/WLsI1JUBJ8xDXIyIW?=
 =?us-ascii?Q?bjVu2qzTMa/F2a6RgOkaxNADJlHvxBinR1+4cdP27OrVEgo3EdEZHQIbrm7L?=
 =?us-ascii?Q?jz/uF08TYpFeSI3Dhq+P21S47ZwNh8Rfes90VmwigOKlKh1VkTIB9Fi0QRUu?=
 =?us-ascii?Q?nri/poLSfAW4oNlzW2SP7dCHC36mm3NCbHzt7hLAeUhx7cVqCHSLUsd+Z0Xw?=
 =?us-ascii?Q?5ew/Vd/iFIZ6UIzDP+EReJDybJ37fRtiVM7wqqpJcZIKOdZMMt/5wqqtfh4K?=
 =?us-ascii?Q?hQzxCDPMKQYbfsxomvwausiwmqQDUR1taiGlGCKTnVuZ8B1Vx+V6luelqmWL?=
 =?us-ascii?Q?O6SXDL7SES1eluCgjlICUbvNVBfoIrGLLehKdTw5w71UM4R0XihO2k6UL0AM?=
 =?us-ascii?Q?F2NFi8OOCKbYp1Rg9vNAaZs3PSvNhnLkpGYFjx59F/YtqfcKTPllc4M5nKrm?=
 =?us-ascii?Q?ilLTB2KqpoJrFGSySM6nhCy3jSNeA4Uw9yRiRFDbVei0jEdDPB1G3vvcT2vs?=
 =?us-ascii?Q?fpdKV/i+M49c869gpKmNzMCqfI3hejPDZDxwYQXQ6otDzNEpt+/RiwNJSJQ5?=
 =?us-ascii?Q?PckphoGnwhqbU7Sj2K1oad7N2HOz0ex3XB19zWVqmbjSFFNv0JdYWzUP3Rcw?=
 =?us-ascii?Q?cD+n6Znuk5kYd5Ko+CRa6k0++LO52p5q+r4jc/PLpN7qQRB9ZGWsy92DR4rZ?=
 =?us-ascii?Q?r8Gprx80/PZsRn1AwjA6ZRftzDnupuLTY6aY1SRU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f4f078-c1c7-41cc-3187-08dd367242a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:52.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1Rqm+UaP25xAkZiyWD7h5yiGVhfWla55v4hLF4nueoEG7WDe+lWWvjg5puIpoOZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
changes huge=always to allocate THP/mTHP based on write size and
split_huge_page_test does not write PMD size data, so file-back THP is not
created during the test.

Set /sys/kernel/mm/transparent_hugepage/shmem_enabled to "force" to force
THP allocation.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 47 +++++++++++++++++--
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 3f353f3d070f..eccaa347140b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -264,15 +264,46 @@ void split_pte_mapped_thp(void)
 void split_file_backed_thp(void)
 {
 	int status;
-	int fd;
-	ssize_t num_written;
+	int fd, shmem_sysctl_fd;
+	ssize_t num_written, num_read;
 	char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
 	const char *tmpfs_loc = mkdtemp(tmpfs_template);
-	char testfile[INPUT_MAX];
+	char testfile[INPUT_MAX], sysctl_buf[INPUT_MAX] = {0};
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
+	const char *shmem_sysctl = "/sys/kernel/mm/transparent_hugepage/shmem_enabled";
+	char *opt1, *opt2;
 
 	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
 
+	shmem_sysctl_fd = open(shmem_sysctl, O_RDWR);
+	if (shmem_sysctl_fd == -1) {
+		ksft_perror("cannot open shmem sysctl");
+		goto out;
+	}
+
+	num_read = read(shmem_sysctl_fd, sysctl_buf, INPUT_MAX);
+	if (num_read < 1) {
+		ksft_perror("Failed to read shmem sysctl");
+		goto out;
+	}
+
+	opt1 = strchr(sysctl_buf, '[');
+	opt2 = strchr(sysctl_buf, ']');
+	if (!opt1 || !opt2) {
+		ksft_perror("cannot read shmem sysctl config");
+		goto out;
+	}
+
+	/* get existing shmem sysctl config into sysctl_buf */
+	strncpy(sysctl_buf, opt1 + 1, opt2 - opt1 - 1);
+	memset(sysctl_buf + (opt2 - opt1 - 1), 0, INPUT_MAX);
+
+	num_written = write(shmem_sysctl_fd, "force", sizeof("force"));
+	if (num_written < 1) {
+		ksft_perror("Fail to write force to shmem sysctl");
+		goto out;
+	}
+
 	status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=always,size=4m");
 
 	if (status)
@@ -317,13 +348,21 @@ void split_file_backed_thp(void)
 	if (status)
 		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
 
+	num_written = write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) + 1);
+	if (num_written < 1)
+		ksft_perror("Fail to restore shmem sysctl");
+
 	ksft_print_msg("Please check dmesg for more information\n");
-	ksft_test_result_pass("File-backed THP split test done\n");
+	ksft_test_result_pass("File-backed THP split to order %d test done\n", order);
 	return;
 
 cleanup:
+	num_written = write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) + 1);
+	if (num_written < 1)
+		ksft_perror("Fail to restore shmem sysctl");
 	umount(tmpfs_loc);
 	rmdir(tmpfs_loc);
+out:
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
-- 
2.45.2


