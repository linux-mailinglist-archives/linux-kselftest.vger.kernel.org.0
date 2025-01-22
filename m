Return-Path: <linux-kselftest+bounces-24930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9CCA1917B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F873ABF6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98E212D74;
	Wed, 22 Jan 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gbtKqrR/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148C212B0F;
	Wed, 22 Jan 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549657; cv=fail; b=gZnOzHVf+So8oPseoW6UAlakOCt3STBfaPwMbTsN5KCwfFVvQGU7P8xogJd/1gZ99VVdH23JeKIvOpYf8LTBcFQd8cklLDNqDWYkpR7rtnB0xzfBmH51BK1DoB8gu7sJPnKjYl8JjXC5K8h8c2BSo2u3RetTRdv1UN21UkHJRJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549657; c=relaxed/simple;
	bh=wUFnTKG729nZKg8+j3eHppmqfGTj7Ei1k8L01C7vE+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PgXA0uFxzH//vZFc9ujOQZr7vKMAaZMke8glEtRqwwv6qB1OJUiCDeF0lFaE3/PAuxFC99OEHAWD2Xa+WzlwdaDpK8nHgZOQVhu6TCmvlmSP12XXDmICkO4w7Vb/VN1sQV1H1rirVrrNY9nbGt1KF7dks+TY+XxK/Rt6yAgo0Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gbtKqrR/; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+CV+b0bqVKOHjAPFbE6GwE3iudURE7m5lrrDdRDWyyI6GIQ0oJirBTtMirU06dBdLGIsQ+CopzMGlq9l2+0S8P5pzwqndWxAMm1r1DNE/kJXc+Ptwtia7OVnKhfqSOO0GkWynJhsGuhE9LrMyWX7ydirE9Lmv/u9S7qR0aQJis5lPIa532S7SZM7pK1YAjzuJsyN/RUicfcQ0VVEVbMDOouzrQdQTAw+cmwFVkmQXHHQ75vI2O5/BTwgBkzuPwlSWU4UMeFwAXmhb5JUYh8FXvLJg2LBeKND8gmOdfh6rc3L51TEWAZ3v/WVi4EcEpEHhZmRfL0t7geSHihGiJRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyURrOf1NUHmAiMEXV1zetxPd9i+upU8gYqrWH1keF4=;
 b=ucFpYO+lgdbrZt/pNCL4AdkzUAtI0BoycYlKfygWR4kU/pLe4+jTLBAx8jJY4LFrIlSCtZkuyxNHPXN3DjhAnNWUYznLt/PxsRFuTfkr5V0st4PkK6LOAQQWLpDICH0s5tqO9RyDV//ofpjmfM+jNkXAgO85NAqkUVzLNK9BmWjNhGcuGbGAkENcuxcggjpPSLWWaX0ajrsk/RYwrWK16LhwZ9+rwLMZKVv79Vzpjh+r4Y2Qmsdy0qT2FTSK8QFuGtFWS0/Sl0aNm96HT+fKxNXafjmQ2mo+qRdsYYLNuSmNMUCLpT0tGdk3yaRHjSwhzdkl3L4449MU13+yXvcsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyURrOf1NUHmAiMEXV1zetxPd9i+upU8gYqrWH1keF4=;
 b=gbtKqrR/utN1ep2ezFPB8tdml107yDUcDiMrHIFIIhYw05ctSF/3VwpUhC1KBp/mHCYe7PDnQPNN/5wx7+h6Ovz1gQ/6pf7d4YUI+vM+Cw9cOcYD/R2BMsQgcXIk2NpHha2dxjQ4/shdtS4bqLXv0ar3/5hWgsy49BpNmb8UUjRSUJuWXTMSNeHUfSSHv/mnK8/dJ0jyaWN3VPrilb9dEO7CpCUw5q73lm9Ia/vsj9ePPhd/HpetGZQwWaJEdNnG6b/swDVmMwFv1sAYgn6Q59002d+qkMr8LKryULwAxnNhUSOGTbwUjC0OG+e/2c0tlfLEDB3m4JtKk4DrdvE8RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 12:40:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 12:40:52 +0000
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
Subject: [PATCH 1/3] selftests/mm: make file-backed THP split work by setting force option
Date: Wed, 22 Jan 2025 07:40:45 -0500
Message-ID: <20250122124047.1216024-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0490.namprd03.prod.outlook.com
 (2603:10b6:408:130::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a31416-b117-417b-0378-08dd3ae201b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JSE1nfKHrCkvFn/3VBHwSxzgl8YYck/ReP8Z4GmnOsMwxdhw8QDhyZDhlqac?=
 =?us-ascii?Q?DgSYvnb9SNoBJRBfGpBYvydgEdNd6WWdrLBveh5ZTXMvqcW+ErSsOPREXpfG?=
 =?us-ascii?Q?SVLk/FQ5n7D/n2KJDrQ8yIy90d9VM7Yo9zSQwUBtkcXwlMidll0lMO6PsgAs?=
 =?us-ascii?Q?MVMLRvBgqSZ2+JH4Rnoj++1JlfROwQHbL6mgL+JkShkf7nnUo7hfdQER9vMF?=
 =?us-ascii?Q?8HsceKljgzuyo+YMTHvlnxXj/UfErGsc+Ba9PtbM59KHEFtXEIuXNWabLG2T?=
 =?us-ascii?Q?uBno+dTkPCyYONyu3/h1Qwln55ZqOYhJgv/kjOOD6oijRdHPPXegZ0foM6D+?=
 =?us-ascii?Q?J7SGwpYlwVgWf/myY3RnUlajbtPJkWwuQDIaNsMGxHK7ga0HxcaHjDcEsdCA?=
 =?us-ascii?Q?zFnq2R+zNhuUAr3DfR64p3nSEbOQEUA44LMevqIq+JMyRJZMc/8LtfLZyY9y?=
 =?us-ascii?Q?vYmEK2Neiicum21qRiC2ybQ1hy4SWt36d8GVLCPsFjTGpDo8VmYYUFMPX30l?=
 =?us-ascii?Q?wVrKriUm/2YhK9WN4WVbkPrsaNkhpi8cmebETT+0zfW51RfLjemdmzr0vsMF?=
 =?us-ascii?Q?hpwHVHIVcdhchw9D3MZ9XyIRHWUxFytuT7uHy+e+EeZEzYfDh+DIHGorNkoP?=
 =?us-ascii?Q?8xm8OBaVz39i54L0SsNlbpa4E+5RubFID7Dv29qxjOdEdFeW4dqcdIyVBbvK?=
 =?us-ascii?Q?T1XvNxN+qwFoT5BBUW92Xeij7A52M7n8Oao3/mJbxjCYRiHKhEObKLkT9EDD?=
 =?us-ascii?Q?IA60/0uZ8ULTUQRm+zrk5ltR4Qez4CQFpD+95f8UwHAT8QUXCxVu37hb6Nf2?=
 =?us-ascii?Q?CaA/CiEyANiqgi5lW24S5kVoJzczrXsQH7STnhno8Io0G+0chPvwy8/yp8Xe?=
 =?us-ascii?Q?XbYglt/7kAJ0Q00kc89LqwfUB0Wu0+SZJOrLW6sglDCzyDid4FXArKaMuScQ?=
 =?us-ascii?Q?j2kgoKl2V82TilIloqyjF9HMauJPBxUkFDSPr5q/cdDxtOnr6g0+zxsuMzWn?=
 =?us-ascii?Q?HHrLfrnfijXeHfNJW6mn51b2VzRsBoPnULS01PqGzrnrs1Sa/lwYaqxiqzVW?=
 =?us-ascii?Q?2y5RRtlKdnm4f6u0QaF0fyYDdK89IQ2dZ0BPUAQnJOre0Sd9/4nWo1jyhRAB?=
 =?us-ascii?Q?TUvPlmH8vj0gNva3lhyD1wXyZdPQfNl2mvzljsj6S4dbxQd3UjeHGcUR9MT/?=
 =?us-ascii?Q?YNapIGHsLx9iuzpYGsOhrzZnMNcrUkNcxZqQhfG27/1yzYL+b0pzU9LIfkaB?=
 =?us-ascii?Q?BimhxuwKKOPa73ujeUEBsqtdXscCXpKVn1ZFqsVP4AI1jCV0kc40iURWl5do?=
 =?us-ascii?Q?KNlzIIk7f8/BK3tflRPDENkVXDx0NWE7nbnrr6ldxELA+WUyUs6Ox+McxIyi?=
 =?us-ascii?Q?X0dJTwWYzU/Xo6jB1VwpVJ7aroIj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdlTob2Weuc1qnmUq//OcDPUsL4zICq3PQAMSBRGVcZn02JCUwEYNY98U+MH?=
 =?us-ascii?Q?TXnXmfQxa74ejV0JQrFnnaA7d0bVtVkqwikxQeHTDiriBXKxhGzAps4cba4l?=
 =?us-ascii?Q?utS5Otwqd9H+TPvWnDh4V4Ijrmzj28I4q3AkderFA6q148ePHFukOx1om2+Z?=
 =?us-ascii?Q?eA0DfZylQa2j3YukStGNdv9FZWG4jr6/EP6eLxi9GMcyquqcmWtIJtZJuZdp?=
 =?us-ascii?Q?oC6E3FJdTTcBXKq4uARwOUPmWyEFp779r0c6BsdmdX2H59m+t1AbHc7pdOMi?=
 =?us-ascii?Q?0UBq7LAOGPsKe37JV4HvICytr55FsJB2UE2hpEBrhANPU03a5Rnoz8QplXTc?=
 =?us-ascii?Q?GlasK1TOhmzTjMjnb8CRvkD/NIywP+0kd7YBym/RXV23MIs8Ilgj3I4LmO/g?=
 =?us-ascii?Q?PZxQWi0p7cOeop0Epo4XwvbhtuLt9bdaSbqDk/e2RrtrLA4VFDF4SW9e/DU9?=
 =?us-ascii?Q?IGPDQUETgWa0zeIoVN+Udko+eo1d7vh0IsDtl1PX/DOtD2QCOlLNInsBGnMO?=
 =?us-ascii?Q?2oa8Rwss27PkKcnNjtF0B0Tr/8yniQLW8luTzZ0RNC3abTuVN83fLtXTsyvY?=
 =?us-ascii?Q?sR+bbSsdlLsZhIhbab6I+GietZjq2mb79IYfQMGU6D1D0XrPI5woxCTWBvwo?=
 =?us-ascii?Q?WAdFiTyHnvwIR9VcQtXhZ9oIhXk4whnM/5bwNIAlEqiDemisCtcTOJLqwirc?=
 =?us-ascii?Q?pK/Mtceb6AnQxs97+P9AMBrOePjZFgUbfvPnK11X9dNeDeMKPu7LlMy9Ap1J?=
 =?us-ascii?Q?ne027GSJZbybJQYDDlQ4HvdyPS00FceCtCXiLl7XMIqv630salgxNAwPwSfY?=
 =?us-ascii?Q?nH8jY3mLV0XcDwNug+RtcVy8LgVYrStiUJcv6Tjy/rGERMHRmabRJvRk3RIF?=
 =?us-ascii?Q?EW8YLl8M0z10c9x+laPvtCj8CRKWBvYBPMwOd5gSDQ0AHNaozDmlMThLwHvj?=
 =?us-ascii?Q?TchrsTSwTk8llrzD+/9JuB1i79wYKoT2H0a59I8kzZTA6W+kpQ3sWIUIFp0g?=
 =?us-ascii?Q?FBWGwZSuulBZhBZtEDY9aetjbhjl4DgF3RpQAluU++6WbkK2Oe/+iuTmqW1x?=
 =?us-ascii?Q?wFk4qsN1K7uGeg3I2ZFIFtB7fuhFnQ7+I68glVrdRefg2Y8pDhCV17iUSLde?=
 =?us-ascii?Q?tWSGnwYN5PG2TxThfuKrmErL8TJCMMpEEH2KLSPjxp9hkrPQ3+MT7F/rKhdI?=
 =?us-ascii?Q?9TrXLjQ/PdIHn8rym7BMGTHHzVW222NmUkkYpZd2vCfYkyBvSx4cq2hCzVKp?=
 =?us-ascii?Q?WxrYdNRFqaWvoqH4rMQNLBQwqTu/CoONuA8JWwClX1Y+cDhm3J1K1A90xAOi?=
 =?us-ascii?Q?S6tOY7Iuj+fbp41yLmWYb/lEonNIqjKDZkTjAB6zdOzng86b+BSwMMlts2FY?=
 =?us-ascii?Q?RVUEg5Wr8wW/SAvfUYX4fgsh+JM1os2acd/mKTer1ySUAuUu+63EYFPkl6dp?=
 =?us-ascii?Q?eut3W3V3naIWSRkwI665zZFtXrTF3DytmTAQNfyX3+ONPYaDxIUXq+70BzKk?=
 =?us-ascii?Q?+872iq/lI4mK/yjQLELsHxvpVwhSpq9Lx2QbKZ6PWoLKFOpgC9+iUyVy38DK?=
 =?us-ascii?Q?GQcsrcD7WR1aspspHYAr4/32GxoNGxGauIvmBbAl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a31416-b117-417b-0378-08dd3ae201b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:40:52.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sBG6c5Fpq95lOh2O0QnmO0zfbPF+xS1ivhvd/jpJ4cJwcK2Ulc7ppL4UGPHFsRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619

Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
changes huge=always to allocate THP/mTHP based on write size and
split_huge_page_test does not write PMD size data, so file-back THP is not
created during the test.

Set /sys/kernel/mm/transparent_hugepage/shmem_enabled to "force" to force
THP allocation.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../selftests/mm/split_huge_page_test.c       | 48 +++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 3f353f3d070f..8e15fc9dce3a 100644
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
+		goto cleanup_sysctl;
+	}
+
+	opt1 = strchr(sysctl_buf, '[');
+	opt2 = strchr(sysctl_buf, ']');
+	if (!opt1 || !opt2) {
+		ksft_perror("cannot read shmem sysctl config");
+		goto cleanup_sysctl;
+	}
+
+	/* get existing shmem sysctl config into sysctl_buf */
+	strncpy(sysctl_buf, opt1 + 1, opt2 - opt1 - 1);
+	memset(sysctl_buf + (opt2 - opt1 - 1), 0, INPUT_MAX);
+
+	num_written = write(shmem_sysctl_fd, "force", sizeof("force"));
+	if (num_written < 1) {
+		ksft_perror("Fail to write force to shmem sysctl");
+		goto cleanup_sysctl;
+	}
+
 	status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=always,size=4m");
 
 	if (status)
@@ -317,13 +348,24 @@ void split_file_backed_thp(void)
 	if (status)
 		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
 
+	num_written = write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) + 1);
+	if (num_written < 1)
+		ksft_perror("Fail to restore shmem sysctl");
+
+	close(shmem_sysctl_fd);
 	ksft_print_msg("Please check dmesg for more information\n");
 	ksft_test_result_pass("File-backed THP split test done\n");
 	return;
 
 cleanup:
+	num_written = write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) + 1);
+	if (num_written < 1)
+		ksft_perror("Fail to restore shmem sysctl");
 	umount(tmpfs_loc);
 	rmdir(tmpfs_loc);
+cleanup_sysctl:
+	close(shmem_sysctl_fd);
+out:
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
-- 
2.45.2


