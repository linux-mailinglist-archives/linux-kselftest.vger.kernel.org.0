Return-Path: <linux-kselftest+bounces-24949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5541A1964E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 17:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9C716C237
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC704213E7A;
	Wed, 22 Jan 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xde/uf2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9574C14;
	Wed, 22 Jan 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562776; cv=fail; b=jQ+kv3o/JSCT6s+P3VVYqFELk0jBSLqlCieBodVfi/e0ieMxgYmrBVK9gitBG3hTGRPg/+5q0pcEEOWBJpdSKqRwZLEOq52ursFqJkg3qRmCRHeKZIjJste2h73mjZa3/FpkS3Ogt+yIfLNZaW20GwSvQ7A3DV1qPEt5BXLHEfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562776; c=relaxed/simple;
	bh=KdZB5twdMUv6NGCtgNZdLRQ/dolcfJF0yITHRD4K+t4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hOlGGJqZ9W9fyGBRC34aAbba55wWpJv4i9WtFbXdXmv92VEAzpUfj3yfD7fWH/QQYO2QOyx29s3HkSkvnGCkMnCoB8c0S9sSEmcD8T+DHDfWVU5cPmR969fQDcM5ohq1Kzbsya0HuNj87pyy/f+eDkYApovhketM1fEv37cdIgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xde/uf2i; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBKJqcL/BQ03p8hJSjqNXZM8rRiqY4muy2s/Y59MpHMTawZYOPUXN+nGmIvPmVYYRZ2X5QCZzdbe/2ij82aJdwmIyqZjmjcKTTAD3wcoBKXivRY7jAjNyp6k/4T8nMECvOu1VqpXQBkymRrCaBVxFMdR1TLuNNLTYZFIL4lBo5V0TuQk9wDLOuM05RBTp7XtUgmYDyRnpeGgT6hysk4AA41LHOaPtHQlM6kGMrlZ78Xpgqxg2Lkuuy56l2M7PX+RWD4HCcfmz0WPNii0uYyEbiQ4S69dSp9XZnfZeWvsrHuR4o7TbIYe6JMeit5beq79bC0bTmTab/gbRMuxVXNxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g74+/hNiUySD6GLWFvbwSqao91HU4zXGsKDaR/w06aE=;
 b=XYQFB4g6STVDO3VdScdEEFpJLFXvk8nm0J+GRlR0VWP3fRij/+zSoIDZNsTH9LrJYKt4biLU6+XetpKuEpC5UzEen258UVZGbdz2WpcLB3Z/g5/DBhUJGh+j9PyBxbtcdInqgB3ELQggmn6eAMIaCFK4r6rph8T5OfGJIbJqFZXASl0K93N5kJoaz5tL3ok1koleBiIzhCVcuCg12OphevyaTRS58P/iikhhC10hD8sVoeFsxxDlmYo5tn7hwvaICMQwauthYC7KTzoACr8bn7mRFFWvbMlk7Y9zuF4DMkRvKTLy21RRay8cbJ9dMqVI8lzBV3vnO0Ewlvi5v2h+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g74+/hNiUySD6GLWFvbwSqao91HU4zXGsKDaR/w06aE=;
 b=Xde/uf2iOPRef4cz1SKOMGGBt5P/UrMi1yDhrMA+sVpW/waE/hAQkvCeB45Sj5Fcwd1wvJWchnVQKhfsTbcuKXB9boonVz2hFrP4yxB5fEUs3xeN7zob4qwfqbhCgKzZZNOGPDYmNTGk+XgvL570bLd4769KaAdT2o9VVfDyKIoVUgkftoLv4YVSmZH/EoIS16kaS3STIpoJcbj3ZyOm+PYgPPJrbE41VCaxahXkA7cXZu7W0e7aNYt192aR2aUWDFY+8k5bPgJjv0SnwVONBO8ziXWmj8l9xMZU0N9PoqbN0ewEekQ5fsWW1fhTPtWP2NhGlc2G2lep2lPQNMtJJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 16:19:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 16:19:31 +0000
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
Subject: [PATCH v2 1/3] selftests/mm: make file-backed THP split work by writing PMD size data
Date: Wed, 22 Jan 2025 11:19:26 -0500
Message-ID: <20250122161928.1240637-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:408:f4::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d7fcb5-f860-4d72-8b44-08dd3b008d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PCu1cQsnlYcLsLVSesxoDKvLAVlZ//UIj13QSar0ry2cyO1nj2pWcALj9xUa?=
 =?us-ascii?Q?6Ci2ra7/IW/aSN2I2zk8fgPTNO8F7iU/qX2nuT/YJV6lChdenTnMrpOPXqlu?=
 =?us-ascii?Q?i1qbQDysLD19qNyRT/UOB4z8ZFSly8NNEIcBRGwWwtV6eBQIsvOFHWuvzVw0?=
 =?us-ascii?Q?8w7Tm7Wc+5tD2uTWfFf+iCW7zo/jpe7IgurRBtYnkg/Sp0a5QPPktudC7LyI?=
 =?us-ascii?Q?+GAoHBYkKt0KS9oIl98XCqqtksSLO1dT3dBg/kGk5IYZ8lupsqcbZGN/HKc0?=
 =?us-ascii?Q?1lsDSQmPV72zhMrYdaG5CR+x8NkYhRgARwkOk/dE7dw28duWq0RHAgcqabLQ?=
 =?us-ascii?Q?TEjnF5IRrxa+VrUDnIfPJb423RkrxsC9OVoPBC3+ssEka1CW8g4YUbBwJKfw?=
 =?us-ascii?Q?Ly3PuHmB7kU9TvHYMLdCg1EGhAcTPB/4ks30qs0R7GACIAFUH2FPbPkh2wzb?=
 =?us-ascii?Q?Y2C4UOeTzKPHa88MwuM4CVyWrVQKaEUu6h1QD0tEdDZGv2BQz3hRJj7Ni/G/?=
 =?us-ascii?Q?3eAF0+2L8ZLjUwiGn4aW3TVh+c+xvjaVOWjQPiikySR2KSVHsEH/sJ4xm9i3?=
 =?us-ascii?Q?9QFfowtg7ZtjWFqk/2g0GmeVcm7vMMbOsq5FjlQAyuqWtV/z3JiaDVNx6XGX?=
 =?us-ascii?Q?Uc1KoiCtKmISY/jUKTt5LOtKMKIa9LNk0LuBidHCQIz9J2JIDU5yUxti4Yze?=
 =?us-ascii?Q?AQEKPf+7M+c1JXakjWr5wUUETEVndKALGsZT2ZP76yHXnKNVyEFi/afjgZHb?=
 =?us-ascii?Q?mYNu0atarUCdwi78mQvMYHuJjOxtcL5rvaSFqOkY6pMMIaCvdHN4sTvHceqL?=
 =?us-ascii?Q?4PjZNSlyp46Ti09B1fXga0yupMJaryOHCmks9dwWQDtQkIF2HrUMzxWq6oTK?=
 =?us-ascii?Q?0abkfuJN83TceM13d7d7840M49ZVQ1AD25TZync8/AY4eWvLzqe1ZKg3CL2z?=
 =?us-ascii?Q?DxV81mbfmHwqiHzB4L64Tglsi1TV7ilL4SlWvrIPlm2bokfWgo5tZ3QVe/Lq?=
 =?us-ascii?Q?BGgi4DaW+E8zlUJ6P+PrsUqQQrvb/+ADVGQk8o6Yy784GT0vXlvacOKvuRvD?=
 =?us-ascii?Q?KllTSQnfo3zyBw/cST4g6/psTPgFubK6kI2CgysbdfZHCzqZgit/XTYouLX4?=
 =?us-ascii?Q?hZ7PUifB5FMDSlM7yK/XyVjzXLir8PQRQW0w3Zpk2d+JeQoJBdlDqfYRnjXM?=
 =?us-ascii?Q?Cisj6YFyWlp4Rf3DuCBzZBAFiSm1GJB7Ek2jXBWFGWOMo07ICZb9xIGegQyc?=
 =?us-ascii?Q?lmHVTSVm6s6lvbJQOePl7kBv/jow1rT7ESDunByzESfM7XT9WMPBPU8ilgR+?=
 =?us-ascii?Q?81XBQmrZmL2uqBRLMqwr+e85ktSuqgZCx4pAUeGvWm/UmGqBsmum3WGmcGcH?=
 =?us-ascii?Q?GznjFr5vFvUZFCKXyoEbl7DBASNb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDln2aM6/pGYa31og/uWn0+jXKDv+wdxE+mmAu5AyXsGxmf4sJYV9GvrFjWN?=
 =?us-ascii?Q?c7n63SaaC42LRk3uOdglajbsTSKkDtwp94v6PqZcgm0I7HdpJea5NNyyMvX1?=
 =?us-ascii?Q?u+rllEY1bGt37eRkmiyje+6/lf5ZpJyqjkAXXEpACvrqWyNlfgdQWxsK+h8Q?=
 =?us-ascii?Q?VRHJQ/gKM97gmp3sixCx68K++R8352XGL8UhMNJWW53KnyuDtIlw7Z8dfFPO?=
 =?us-ascii?Q?Z+njLu9125FqKJR5b8S1CAZqoSAs7PoYR0FiznRvCYnhuVwfg2asKjrPEChe?=
 =?us-ascii?Q?2b0tuo7f1ukGrlGolCOgLPTc/mtO+HB0oKCeE7CEa0+sAGg9/kT6tNgmYhZj?=
 =?us-ascii?Q?nYEeg2qeHnAF70ElLsRRBA8wXd6rM9pYJHW+S4nSH88/ZfYjWxa/U5ho8EML?=
 =?us-ascii?Q?Bzlmvvi2VPjXl+TbyBlaYuZgV4JeVTtKQArLe/dQhBjR5pb9LNNk60BuZs9q?=
 =?us-ascii?Q?DRgAHcxoD0KUDUxK57YB+wenfPfQ5IUeAVq7PjPRI8YYabyP6Onz6F8CsBTZ?=
 =?us-ascii?Q?Hx7t6+nAnZrXjosHPGzXW/bcEYm9KvQcOLE8gtbQGzhAi72h4FUeZnlxHwKi?=
 =?us-ascii?Q?AOexk6LynzzG9CkFqwjZu4N1/zHNQuoTe5AZeGBMZlDl1D+5bQo7tG+bCvkO?=
 =?us-ascii?Q?8t4qVrV6MJbxyR6mMMva5XYTKExR9fyX33uYVqvGwYQOzCZDEcaaS4eGCz90?=
 =?us-ascii?Q?gbqWb3fL3CZT0V+Mxm608egBOLAfPKfhZcwMdhVomK/IbWUkZKfplsHWmbQQ?=
 =?us-ascii?Q?60dThRWOUDU70hRcKYZd0btE3ISR8d9HLofpSVHvdxQR8w+cUpsFZKf/nKce?=
 =?us-ascii?Q?fG4gVtwtpP+8/IDsDY1aD8VNQRh3Bi8zhu1aupgyba0Ee/hHaeSWlTcIh9rr?=
 =?us-ascii?Q?AnY4mWE5DE85giHBYBtJXpPvTv2M7B+n64Qf0q2iVdcvKkp0dgwgyG/NuqnU?=
 =?us-ascii?Q?jKagnNr0/B+0Jtcv2X3eu+UDoWdovhLAZtBedLsDXvFXnK7+v62RcWdRzREo?=
 =?us-ascii?Q?Jc3iTLqZUIq5ComG3j8P65c2ImpQ07RFRPnm8QG1Z7dNaRYpbuvlU3K+CXXd?=
 =?us-ascii?Q?Xmm+oqWFdCaufWvQRd0Utv64M1Ad5o1d5SDCsU1+ssimQr6rkzq5ydz4nf88?=
 =?us-ascii?Q?x5M689yNjzH3rgrrt/BKVm1D+xOhmgtFBq6nR0MGi0o+zIxAO59Yf9ifGi6u?=
 =?us-ascii?Q?jI2Ignp/RszEeoZ/ya9INZVEa9ycyrLUpfYmX+DG/E/5Yp1yF69WG8BQKCDO?=
 =?us-ascii?Q?TO7MsMm6twUCYjx/XkFOtoplDcdp2LNmzOqSPrekoK5pVy1IboeUYV65ABVP?=
 =?us-ascii?Q?YOqwmE+RfzoEGDEhDnc/cbE4XVnTfrGrnARU8LksXanaBGnRvrp+vrh1wzq8?=
 =?us-ascii?Q?GGdKRqqtyAAVsyGcyau1cvBeU26mhjH4GuanYpVLPAFPqHXoiYy8gPreUYhF?=
 =?us-ascii?Q?QXyNZe2ut/2A3sJOg7/rDUKnVFvH15bbe40zW2wJy3/lYtuJafOy+GdLNYRe?=
 =?us-ascii?Q?Obki7XjHeAygSKqVbPbHj2x3r9UCna1nfI1v7H3zePvmalTRfiy0upZwZvVD?=
 =?us-ascii?Q?p1fC2zFZqRTGXUJRkOFAvu7MAQ2BliU06EN97Gkl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d7fcb5-f860-4d72-8b44-08dd3b008d78
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:19:31.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m16wKQjCXxfjWusU6NlhPIhhWoK4Aw3OuDE0SzNWGmrzPk4O49iv/AwBU+Y8LAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326

Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
changes huge=always to allocate THP/mTHP based on write size and
split_huge_page_test does not write PMD size data, so file-back THP is not
created during the test. Fix it by writing PMD size data.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
V1 -> V2: write PMD size data instead of setting
          /sys/kernel/mm/transparent_hugepage/shmem_enabled to "force".

 .../selftests/mm/split_huge_page_test.c       | 52 ++++++++++++++++---
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 3f353f3d070f..ba498aaaf857 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -265,14 +265,28 @@ void split_file_backed_thp(void)
 {
 	int status;
 	int fd;
-	ssize_t num_written;
 	char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
 	const char *tmpfs_loc = mkdtemp(tmpfs_template);
 	char testfile[INPUT_MAX];
+	ssize_t num_written, num_read;
+	char *file_buf1, *file_buf2;
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
+	int i;
 
 	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
 
+	file_buf1 = (char *)malloc(pmd_pagesize);
+	file_buf2 = (char *)malloc(pmd_pagesize);
+
+	if (!file_buf1 || !file_buf2) {
+		ksft_print_msg("cannot allocate file buffers\n");
+		goto out;
+	}
+
+	for (i = 0; i < pmd_pagesize; i++)
+		file_buf1[i] = (char)i;
+	memset(file_buf2, 0, pmd_pagesize);
+
 	status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=always,size=4m");
 
 	if (status)
@@ -281,26 +295,45 @@ void split_file_backed_thp(void)
 	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
 	if (status >= INPUT_MAX) {
 		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
+		goto cleanup;
 	}
 
-	fd = open(testfile, O_CREAT|O_WRONLY, 0664);
+	fd = open(testfile, O_CREAT|O_RDWR, 0664);
 	if (fd == -1) {
 		ksft_perror("Cannot open testing file");
 		goto cleanup;
 	}
 
-	/* write something to the file, so a file-backed THP can be allocated */
-	num_written = write(fd, tmpfs_loc, strlen(tmpfs_loc) + 1);
-	close(fd);
+	/* write pmd size data to the file, so a file-backed THP can be allocated */
+	num_written = write(fd, file_buf1, pmd_pagesize);
 
-	if (num_written < 1) {
-		ksft_perror("Fail to write data to testing file");
-		goto cleanup;
+	if (num_written == -1 || num_written != pmd_pagesize) {
+		ksft_perror("Failed to write data to testing file");
+		goto close_file;
 	}
 
 	/* split the file-backed THP */
 	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
 
+	/* check file content after split */
+	status = lseek(fd, 0, SEEK_SET);
+	if (status == -1) {
+		ksft_perror("Cannot lseek file");
+		goto close_file;
+	}
+
+	num_read = read(fd, file_buf2, num_written);
+	if (num_read == -1 || num_read != num_written) {
+		ksft_perror("Cannot read file content back");
+		goto close_file;
+	}
+
+	if (strncmp(file_buf1, file_buf2, pmd_pagesize) != 0) {
+		ksft_print_msg("File content changed\n");
+		goto close_file;
+	}
+
+	close(fd);
 	status = unlink(testfile);
 	if (status) {
 		ksft_perror("Cannot remove testing file");
@@ -321,9 +354,12 @@ void split_file_backed_thp(void)
 	ksft_test_result_pass("File-backed THP split test done\n");
 	return;
 
+close_file:
+	close(fd);
 cleanup:
 	umount(tmpfs_loc);
 	rmdir(tmpfs_loc);
+out:
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
-- 
2.45.2


