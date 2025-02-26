Return-Path: <linux-kselftest+bounces-27571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC7A4560A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53EC177C12
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2C267B77;
	Wed, 26 Feb 2025 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5ZFjScT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E251C84BD;
	Wed, 26 Feb 2025 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552672; cv=fail; b=TNePoVrkitH27yiY+20PfZXJlQLGkyT70fLbjCk7ZEmjuxaTi1YkpgZlzf7k46jNnrKXuH2SHAvEpFX2qZzGu6HpkQbKAbEcH/xLNOrw4i3uXiML/2IaCyzw8PTskLWmQNeAHCDCRUcEyUVWLyhYjnmqi45+nMmFYRcsHtES4jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552672; c=relaxed/simple;
	bh=6cbajuNZrVtrRZQCY4DNF6jxrVSscvSNFL3O+sfxueI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=icmHYPj80vXgsFMWku2u49COaRYWp4FrkrOUGmEps888MaIOy7jaeQghaMpZkQxfdpeGYkmREaLRyc9APMsgICOw4zztHkCGlLng5Bt/UsEId4gNakRbDpQFtxrtxVjN6hCDWA34tM5U/T/7BK07gXsIrZGiDAWv/KrmqrBPQ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5ZFjScT; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt9D2OudkzpZaht1wEIwPYNixC5nHugUaCvzaJ1Jv9AiBVairUfKGm/c+c06ajJrQ9b7drSesBKO++q7USoSytzgwyzbkTV5Z3xwQUY6qug59tjrmsqvLVZIgpg6lDAmIqnmEAOyDI18sPSa632QE1Xu8yj6we5Kas5XW/Ho0SPhOy6IxP0w9mtoDttlodnK6C7+orm3rRtcZmWVM2+byyqtb/GeZ05K8Yg3DaFLRRf9wKshRVMgFW2CbAaoI9kHyDtXSr3DtMldRCjpKt8Y6VEnNWMCn4PcNeJ6n78DEMgFHUUQ1+Xdow3HqoubPii1ja/LGRelXIO5b2Hg2v8PkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0EyiEV6erVWzAyhnBt3Vzz3q9AES0b3hFbX80tjq5Y=;
 b=dqXgaoakYwDEef+QSrM1xBDhuWc1ecztNmU+7XcaRpZfgTzM/+2tI33KK/I7Qwbd6rB8gy2shsFVNnIDf3RV8Rz2MapgVKgh6EkQp09KIanDvn7lnDpBGb1i2UfoPStAQ+Y8rS0uq+HpnDaZrWEd7Vkcp2LJm5Q4pVSKtklXaFH6ZymBQQ+IKdY1ASxGv4Ivl8UaUj12Pl+ECf7ajFYeg7uAUYLzWBglZA/U5obR0zv/gCnK6ZE0GlxJ5k/pJmr+fCiZWxyRBmB73VoMERvDH49LIhLTifRMFVPq3XGLQOUhe8CYkJ5qcPhx+EzptcEwGmDkmAIU3FzL84B08W9e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0EyiEV6erVWzAyhnBt3Vzz3q9AES0b3hFbX80tjq5Y=;
 b=B5ZFjScT9bm5DIzk9lOMgtRyEeJpUwzaDNKtWG1hkuZ/y7aQbHa8XnmWdlIGLbu1Bq1c7U9Ms6YYz4OuAwuablFOzGnXBSDwAse3lMqFNHra+YFX3FxUX+YuFouqbXaODVVZ1Yga+MT+DYVF5wCq9Jwt3+ugFIwFUbJWLZBnbOpKyuW9ZU2G+lqNW4anjI2KKp6Bz+ovuq1p4TFyqCR58tPIIKuyUJQqaqI1HzG5iD0swdWF2E8HUrlQs62nHbyx7Za3G2dlip9ui6QWEpbiRoVYoqqr1PBYDHr0zThsmdHm9sbVkfWtzqUbdPwK9I5BrdpecP9rFFvjprc2bzIVXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 06:51:07 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 06:51:07 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] selftests/sched_ext: Add NUMA-aware scheduler test
Date: Wed, 26 Feb 2025 07:50:57 +0100
Message-ID: <20250226065057.151976-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0243.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 89123e99-49e2-4888-8caa-08dd5631f1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwUBd97bymtPjgASgZBEI6t+n1Mqbq7TYF92DdDkVlpEXxvpqEPdYQwV7Dwz?=
 =?us-ascii?Q?VFUK/PwgdVtB0zayrfqkyOlYT8zAkn6WaPRu9zGsLbbd9JIynYrmE5Hu/2XT?=
 =?us-ascii?Q?WfPRYVK2N6+fHm2em9KNCwzdOcL5pAl8Gy8WFzoBtKKJ4JxJayH6bPOKNcFk?=
 =?us-ascii?Q?DMS+7hPF8YpYxX4UVaYCKjCbDP53sEBUhSWphV0VP6E+yVrEri3Un/yz7LdF?=
 =?us-ascii?Q?aiBmNL94zSBosT3D4aB6DAL+yuOF5Qap1PO8TUXaSUp2wUmCAXkaVMa3lhON?=
 =?us-ascii?Q?AJplQNjr1ThimGeVlKmtH6SEA5HeunAqR96jED4Fp2UC7KMtB/vWpEobs0+P?=
 =?us-ascii?Q?tusbb8q4QrSuSwelEdF/42yntVhOF+ekCACd88vhN19vYxZRuk7w6QC/BaPc?=
 =?us-ascii?Q?RbyEla6987kyenhJA2Gn6ulG7Zxmi1CJM6V5Y0lCpE8H0mZjJOGZqgIde0W7?=
 =?us-ascii?Q?IXJE8LooDtpxo08x15X0d2HBSowczNKATTPqQPYhXW35VTzdUVYLZvCy+2yj?=
 =?us-ascii?Q?WPykhCRa3hAG2w1xQpGQHrCG/o0eqaPskHfsRydYabPXTyS3AMtxS6Ue8C3C?=
 =?us-ascii?Q?dGV9FfgjuYl7bIUX5zPMUFCqMynA9A6vglFqkbCOhKKdPHx8Z9XD0b1K164l?=
 =?us-ascii?Q?8J+PvJquwIok3egL+AKAMpCLhu8rKDGqR9BtMpgmhq3L8aAHq+PpE3DuzHCB?=
 =?us-ascii?Q?emSS+8h40jNU9O+BTOK6viBsgwV6k/6/aSsqJ/NGu/JoSwL+c7VD0DeWLbDr?=
 =?us-ascii?Q?gp5+5CU3u1QChrb+wcHjMCOHNTd2O/NsKPSg+QSx+s6SsCLNgtP2LZBfevdl?=
 =?us-ascii?Q?SFsBrNxKkI1G8sq3j3xvuj33cq5HyEwRiVAZhkNJqlzwWl4c7zzsdZu2ScL5?=
 =?us-ascii?Q?Cbll7Vi2XFQi8c6lD8vjHGxe4I6Hsd2dW3aYLi1cFpaGCU9V+XI3jFHNYfNI?=
 =?us-ascii?Q?AU4E6ub5bh5tm70Ro4gmtoaqAmLizc/J3mgm/OPRRSbDcl3G2O9fLiTWFAx5?=
 =?us-ascii?Q?tF25Yb8ocgNysZNTj8jb0qqZGhkCX79F0rjClLo5/n9M9BM2VSRhJ+bXJ4IG?=
 =?us-ascii?Q?eRLDCngvrOhjLt3WzfTN/OByEIbwKomdsYTDyPOSBD8zm54ExzYaReR0S6LQ?=
 =?us-ascii?Q?nCezyWoDawhkl+QsOzfYD9MEP7W3sbqn9Ww/coJAGBK8ajtkAuOjvx3tRjvb?=
 =?us-ascii?Q?DrVz63Xrktv04Dvah4oZHU7wV+7vGXn4e1IYbha879j/VT+bvegUIi2xUVaC?=
 =?us-ascii?Q?rwS8qVRHKmIwu555mXkAC3o1VVt1dAlPe2xwU6kXKz1cd5upUm/uRb0f6oPe?=
 =?us-ascii?Q?drtDpFqv5SNqr1vtdXzDgTdcaQB5kMsOF/kEHuv3YDGQV64/OykdqwmNWEHI?=
 =?us-ascii?Q?qWEWfdUrEQfkenXYgFnyNf0+HN+m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wlHRA5StFb1sDO9JrEnLKck+79gUEGgjdySaqpqj5Q/Fn/mJQKjiqNFvmHpq?=
 =?us-ascii?Q?FDLbk8+e7LCpmAGA8QXFpelbBwRgp6sBpJoQcvRd7zLX1Hoat5FPN7vXPXU6?=
 =?us-ascii?Q?8f13zjZpyAc/7vVEi7JZCyhs27p++NxhJkApIi3mEgIGoqmQUUuKUVAVr/ed?=
 =?us-ascii?Q?zF5OQswM0FbGYqF8c1LZ+Su+eX9rD2Gt/YMclnQGbQJhMJwOnGOvw/JcFaGb?=
 =?us-ascii?Q?wSCjidadPzRkO3gB9oCmrOsHr4fAuUd/kkgPJxkY45m3ZzvWYjVS3RQqnaS7?=
 =?us-ascii?Q?TSD2118LfXVgN7XcZV7Rqf6Mq7SA1yzFqv5F+hONumn1cbFOrYL7Vehgjrrg?=
 =?us-ascii?Q?4WrNYp7jS8iP04VHjEkAwzWLCRFWXCUfD7sjoD1GT9ykQTFmk8DBBkoAdS/5?=
 =?us-ascii?Q?UpQ7rBmd/nztIRu/BBQAv2CXphMQpfTMt3wTB083GiK1PZyhf9AjvjxlIApK?=
 =?us-ascii?Q?ZNsB8bc0kloH+z2eIy7izMEbj2U6J3D00Pn+Mgm2VJL/BrBCmiXUJTpbTdI8?=
 =?us-ascii?Q?axFRBxFbJVQvs3oYigC7hBIqacXgP7zS2xSQRon6iGhNUhqbHGVyZcwU6T0v?=
 =?us-ascii?Q?rGr3VqcO7iw2/ikaq2tpjInJi9GwRhZ5g0VejDuS+8OzbpQx+pnHW6dNODiA?=
 =?us-ascii?Q?tarRBNHxjk3Hw5JaNg8m6AG82XDwYiNmRqXHDpIGp2akAobx82lYqxZYlnEY?=
 =?us-ascii?Q?l6HAwMptURm7TJAncHoyfmTdZTGCXuYbRsW8ekTUyKqoYKtCcrHfEzzqFyxw?=
 =?us-ascii?Q?Tor7MXvLAO72aDO6lGX127KVkQd9nkZb6vn5Wm8RsiKQYvOoGacGIi3hGfyd?=
 =?us-ascii?Q?bw1WZXCTO31Qsy6LbUiIPM1LZH4FMCdaG9KplPAjosFDLJW+UcJNR+yie8uS?=
 =?us-ascii?Q?SGbbWDXpbEiutJLlEzVyKlFQCo3DAr1icg4w4r32dpes0jlsyxZV5Kvl/iBj?=
 =?us-ascii?Q?bizhWSm+glHyWKG7EPBLIRfl1XhJ4hXZYxEHgX71Iwd09+KrW/BeFG30ZeXM?=
 =?us-ascii?Q?EkuLXx+nRSG8qv0SMokmo53vB+4cfl3T7NIiD3mFbsP3lRvhlIfPlTXfkG5R?=
 =?us-ascii?Q?waUh5BGyOz0XqDslDMkGKVqC1MWAyIzBCjad0y4BeF7H6G+OSx7DQcIsw9xJ?=
 =?us-ascii?Q?Aa3XO6r5kbSXVnLZ4UeE1vRo1dgoVwD1kKytvImDdNlp6tgI6ntEVfisTS2b?=
 =?us-ascii?Q?hhtAwMI0lswfE7Ysx7WZWkwGZlACWDD4PsI/UvYTszJhKohxra9/6u3bJIMj?=
 =?us-ascii?Q?MH2hsW2JIeW0C9Zp0hqaZmDTxogP829GAnisKR0/7v9OacqiDu59kEB1MixO?=
 =?us-ascii?Q?Mz04eVb1uFYKut4PUOI49oTajuv7v+GOLkuxojyIChSOtr8bdv29I1/NFZnU?=
 =?us-ascii?Q?1S8sqUD2KMWjME1KeRnQi5l0E04lWNeF83MTs5yRNSlEZZLyRO1GiV5Q7iEF?=
 =?us-ascii?Q?TMmO1pboW8ZvWADzfPqSMkmiL0x/ND3cluXVZIGcQm3c9MVWEX8LQf/+KhcU?=
 =?us-ascii?Q?OHgjB9ofQBK80YEPLvIGAdIYDLHU4uVIdjhC9/afST/ufRvT5GssPaf8Lfp7?=
 =?us-ascii?Q?4Gf4CCNgm23EUTCvhMbdSb4wamAhVNz72/FLBHmh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89123e99-49e2-4888-8caa-08dd5631f1f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:51:07.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5VT3rROunmHBfKn2QXwajkQ07w5+pr2N4UuQZAy3NYjBUGiQj+fZFFQRVvSUOVbkKNoreDOIrYf+falN//soQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923

Add a selftest to validate the behavior of the NUMA-aware scheduler
functionalities, including idle CPU selection within nodes, per-node
DSQs and CPU to node mapping.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/numa.bpf.c | 100 +++++++++++++++++++
 tools/testing/selftests/sched_ext/numa.c     |  59 +++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/numa.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/numa.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 0117622246007..f4531327b8e76 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -172,6 +172,7 @@ auto-test-targets :=			\
 	maximal				\
 	maybe_null			\
 	minimal				\
+	numa				\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
new file mode 100644
index 0000000000000..a79d86ed54a1b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates the behavior of the NUMA-aware
+ * functionalities.
+ *
+ * The scheduler creates a separate DSQ for each NUMA node, ensuring tasks
+ * are exclusively processed by CPUs within their respective nodes. Idle
+ * CPUs are selected only within the same node, so task migration can only
+ * occurs between CPUs belonging to the same node.
+ *
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+const volatile unsigned int __COMPAT_SCX_PICK_IDLE_IN_NODE;
+
+static bool is_cpu_idle(s32 cpu, int node)
+{
+	const struct cpumask *idle_cpumask;
+	bool idle;
+
+	idle_cpumask = __COMPAT_scx_bpf_get_idle_cpumask_node(node);
+	idle = bpf_cpumask_test_cpu(cpu, idle_cpumask);
+	scx_bpf_put_cpumask(idle_cpumask);
+
+	return idle;
+}
+
+s32 BPF_STRUCT_OPS(numa_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	int node = __COMPAT_scx_bpf_cpu_node(scx_bpf_task_cpu(p));
+	s32 cpu;
+
+	/*
+	 * We could just use __COMPAT_scx_bpf_pick_any_cpu_node() here,
+	 * since it already tries to pick an idle CPU within the node
+	 * first, but let's use both functions for better testing coverage.
+	 */
+	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
+					__COMPAT_SCX_PICK_IDLE_IN_NODE);
+	if (cpu < 0)
+		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
+						__COMPAT_SCX_PICK_IDLE_IN_NODE);
+
+	if (is_cpu_idle(cpu, node))
+		scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
+		scx_bpf_error("CPU %d should be in node %d", cpu, node);
+
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(numa_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	int node = __COMPAT_scx_bpf_cpu_node(scx_bpf_task_cpu(p));
+
+	scx_bpf_dsq_insert(p, node, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(numa_dispatch, s32 cpu, struct task_struct *prev)
+{
+	int node = __COMPAT_scx_bpf_cpu_node(cpu);
+
+	scx_bpf_dsq_move_to_local(node);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(numa_init)
+{
+	int node, err;
+
+	bpf_for(node, 0, __COMPAT_scx_bpf_nr_node_ids()) {
+		err = scx_bpf_create_dsq(node, node);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(numa_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops numa_ops = {
+	.select_cpu		= (void *)numa_select_cpu,
+	.enqueue		= (void *)numa_enqueue,
+	.dispatch		= (void *)numa_dispatch,
+	.init			= (void *)numa_init,
+	.exit			= (void *)numa_exit,
+	.name			= "numa",
+};
diff --git a/tools/testing/selftests/sched_ext/numa.c b/tools/testing/selftests/sched_ext/numa.c
new file mode 100644
index 0000000000000..b060c3b65c82b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/numa.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "numa.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct numa *skel;
+
+	skel = numa__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	skel->rodata->__COMPAT_SCX_PICK_IDLE_IN_NODE = SCX_PICK_IDLE_IN_NODE;
+	skel->struct_ops.numa_ops->flags = SCX_OPS_BUILTIN_IDLE_PER_NODE;
+	SCX_FAIL_IF(numa__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct numa *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.numa_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct numa *skel = ctx;
+
+	numa__destroy(skel);
+}
+
+struct scx_test numa = {
+	.name = "numa",
+	.description = "Verify NUMA-aware functionalities",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&numa)
-- 
2.48.1


