Return-Path: <linux-kselftest+bounces-29118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE79A6248F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 03:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49981171E02
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 02:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707ED1917C2;
	Sat, 15 Mar 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GujQswQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BD192D6B;
	Sat, 15 Mar 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005359; cv=fail; b=OQOowQKH/D2bSZfwtEYDCKFatJ4P++Zst4TeR+DkVm6uarcafqTvnLniIuxFwl+qAl8DpOCVI5cAQXO+lnM8QE1o55nWOS8d9pQSNnxzSSeDOLJezrGK/KjFO22eOTY6zFti8FY5c+F5UvRsQj6aUQBD5szpYwjnwR8FjJHHSWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005359; c=relaxed/simple;
	bh=SUCgDuWpq95usQF3Q6ew7c14zkaK27vi0F4WnOQCWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGIRXte79Eh64SXdw4AYD4p8JkmcmgasMCnixZwOfMVQfHTcYv1TRXJUNBQkmWoKjbNelpN2+aYuS33+likWZ3tSoPohOy+uTQU8k6owcck0FBWmLvB+2nxwKri0C/c8zcY3Amk4TDBBKVcuIjxyyRvf752i209aTKrpjneUIkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GujQswQY; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4i7LnZjLcAep9Wjnam0Efu0fanWeM6PXnF4NlxuM/xR9MboQusFtg9/09ByZSSpKxkLW/JzGaJY8Tdj14sgU9XoP/sFO31iUI2F2jUYb6VyjJ0DIV84QQP4fO8omFUbapr8Pg8u3m/go0rlY3ky9gYFuwz9J20+hSG17YwsfTN5gYkwXS6051kndpI4sM/JCoE6B/Jep6YT/WcNTXC6noRbcqIoD6NU7y8HC4F4a5+1UHqm7zUzw62Z1D00GlDn8YapKDpN5pe/Ye/lkBSFislmHhjutpFLxjNqK5IBPz6FTaWpFqHa6pMqZfxTpN1xXeQXQ/6e/mEHRIAFq54cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggr76cZVP4BWjXYUKwN+tIoGEGAAD6wecE9I538391s=;
 b=x/ZVFAkG75f2UFiwl6zwNvg5CFiweFARWlq1f/yUuu/AdYihZ5Qq+beUYeg9iLPfNtvR4TMmOqNYF2IRZbQtnCLhw1RP4czQVdu1KIXHWRQDjq4XuHV8jn0Up+QfAEqozS0yDcEZvC8Dizh9vyWe/EIjiI0ynYcSqSC5VV/eS/tHpaRYf69oHizMCTH+e4Ik+8vPwjgChunp0nKWr3aVyuKWFQpynLRen6jwqb38bB2AKNHXZpVTCaRY5VUjkUzLbC/+cte3ttsShKWrsOqtVtVEubq/QG4mCEda2fly0aLn27ZGpMapmdPy2A/4wo58Je5ngOdfkaU2l4uMJOqodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggr76cZVP4BWjXYUKwN+tIoGEGAAD6wecE9I538391s=;
 b=GujQswQYC0LYBnTxN/UeMgAhihvFpfU6yKHhBq+5tEP8DD4YrJ7Ct0hwYKC2kJtdaX6fsXZPIQtex1oYPO378nk2RxK8fV49Gc//9u4Wr2wf3v1Ya8bh8bqDM0OSPPp31Ka7Z1sGKhjvJ6BWjLamrtkFBrcTYgXey3PGAQElf/JzzsL6DAoBu2xmU0bFgc54B7YohE4MeRpewIqjtIW1tIyfNXNKEY6YUIdqV47zRewRp1XQHgcaEei6dE5QWEOlCcPldnGgyu9XCzF8HPiR05m2uRJB8Emnw2IwehjBmCwbozP5pft4k3WKE8WoVPYMbaxelZIVqjE2j68orGdk6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:28 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:27 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC 8/8] selftests/sched_ext: Add test for sched_ext dl_server
Date: Fri, 14 Mar 2025 22:21:55 -0400
Message-ID: <20250315022158.2354454-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:207:3d::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6996d2-cb62-4d0a-b50e-08dd63683b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sus0TqgEfz6xOc+DsUBlYUZ/CFewOrtNlbTSDlOPW0rJFbVU4H6P5wGiNNX?=
 =?us-ascii?Q?hNfYwBXkLB6EtrpDjbOoUlf/WaWuCo3AiRyoXGBlvKToIt/LQMdFsaDlFKk0?=
 =?us-ascii?Q?req/WbYx8lJuccrYH14ahITrD52cFxueTVcgeBGtNkF3K6K/F+LMXiBswkRb?=
 =?us-ascii?Q?dmT3cnN5gTdf3PKCnmojV7wds5IKTazhbMt4SAMMQOzCpvRDSsu7VuWrOhFR?=
 =?us-ascii?Q?NOx5mlFfuZr3O82gwNQYw2ToQVkx3tluT70IRdtWlOvBhciyIA6o1mbZAw5R?=
 =?us-ascii?Q?m68JtDk6z7LH/WKsQahdSzU4foQZWAYwDpjQPt7v2Y8Z3cvqodGXX60zEx9N?=
 =?us-ascii?Q?zmeJHQ2aJZpYH4x1FTU5VcQH0VInDJ/YIjI4Uqt5ZiIe1SykRx84d9TbhOoM?=
 =?us-ascii?Q?TZSc8pxC494PJ77Kn3JTNYcFKyfvPG6kj9cpmqfQNL51iY2d5w8nPqVnL3os?=
 =?us-ascii?Q?Hd/XHlTgFMutINH87BAqUyae4herIDnnFML/jpaFUW+05q+deEmAfHWllLTi?=
 =?us-ascii?Q?xAPzkYqeBLXwQJ1R5bSpe1U8s/sC7h8DkqUnzw8O/kR+xOBCz2CvfKg1/jG9?=
 =?us-ascii?Q?CLCLLtAwio3jFE9zQF1iuiOaVdvDOKdzRSzmh5PMXF6MDrpTKGqhHWZJYAA9?=
 =?us-ascii?Q?0xRcOQj80TYFxQfPBkGpA/Z3iqCDKCkyF8rhjD40rzt6PLA9RmTpgnaQCV6J?=
 =?us-ascii?Q?CDcC57cDbYl4OhUvByLU+JC37tePrJ8DVe6XB2dTRi+cHPfH1av9G9dP6VTL?=
 =?us-ascii?Q?FGPjyvyVUURwVTcgB9Ulv82RQiYVXQkHFY/AlcMiEB2LDC46xnsP84Z5Tedr?=
 =?us-ascii?Q?/DdmOLDXFcSJrsuDkuUiQ1w/lTiXGTom/ltnpwVeQvnww6radSu/SqYehXua?=
 =?us-ascii?Q?ZH6AAS53jKBQnlpwaaLR31hc3fHLA2YJsm66oS5xZs09sLUjtTJz36kQoo5F?=
 =?us-ascii?Q?TA4Y6a6xiuQiV0AzyVmj2scpXhH2NwPIXntT8HLHTV3yDaVC7nVhwAsOD5RD?=
 =?us-ascii?Q?TaLstpRMWR0FVTxfaPvDXXtzBy9NgNPPlquX3DJF7OrbUDQabq70Tleu/drb?=
 =?us-ascii?Q?haP7ZC1lqbnk8s0elfWaFjNbg25CEpzyv49Fl+wCh4eYb+lv7Xtq3yz3zDkb?=
 =?us-ascii?Q?zNmTmgXenB+AOwYi/alsrmyNCLoY+QFMYhUHO6TusszfGaR6typyjDnvHzkX?=
 =?us-ascii?Q?NgwY6jBs8W0dR/CiW8eHFjsCtCTYBhWPuyt4UHQvS3Psw0VJoadocqFPPDk7?=
 =?us-ascii?Q?FqxiriausaxY5yf7+K2C5hv4ox3VlfxbGY9WtC2NjgusgQ/bAJ148djkcfDs?=
 =?us-ascii?Q?Wh5ARF/gAf9/Fzk8ayFv31KhRIol+cV3WZ5lw/B8rI+/GifoDpAa0rm/6r8V?=
 =?us-ascii?Q?wJM5uwAtfIbneW1MmbcPO9cBKppz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PUXU1RLTGxf4ALtLkvIMctMZ28sCWIPUsO279uDlQl6hTMcnQqXZKz9edhcc?=
 =?us-ascii?Q?P6tIBHUuixYO0vSaECXZIpX4a5N8r1LDYVznbr6KnLLxXy/qCLsKDYfo6a1B?=
 =?us-ascii?Q?dogIXds/f+NzKKurykZB9VN3LcLLWSPr4RW6/BKgAK6IYgJC4Lo3XBEjcITP?=
 =?us-ascii?Q?5NYVJ3zSTm4vCVmZomOSDrMgsXgFks6OGXxwHjGEcydo0C7/s0xm4cLFz0ds?=
 =?us-ascii?Q?UQCnSLlxyNHvXiPWl2mpiFaRaCVHGvuBarfJELP+vONzVc4X09h/6g5PS5uU?=
 =?us-ascii?Q?pPfFWM5BxTh6npV2TMhXJ+QFcdHtC6nbQZryNVhOpccvJms/oYfmbmrGjHEE?=
 =?us-ascii?Q?CTGeMndnAiVWrsy97XVS2NgXTjPVnAG10z6aV+e5HQ30A3wgQ/wggR0yO8iW?=
 =?us-ascii?Q?5qDFAJbf5xPdrDaeeiYFpW+Cm5nuBETqsmInM8UCP5rbc0YwHI2Q5opLRq/0?=
 =?us-ascii?Q?2EnZIFWPlcZ41+gblPjrXMQEqkkfrGmhxJL3upd16pt76GmSWz3f/z3X3q1y?=
 =?us-ascii?Q?h0tu8cPNxrb30WHAItO/fxRXZi5uSxh6iAgLYmcRkD0gl4+qcrDf0Xilmx0H?=
 =?us-ascii?Q?kbBmsZVrqXg741peF1ur+UEehJ95zAgDLw5iONAvkr6MQteA63GsqigJXs+B?=
 =?us-ascii?Q?msR6FpFNxQ1jA1PQ9fqE5lP3jPW5UweScssqNMm4VVrsl5rCM8l53YHqRJEN?=
 =?us-ascii?Q?nuP0sMW0tkkGMuuLA+CiqbncLrnpGJ0SuvrI5qkYl1PyQuiHB1gq4+l4wGSL?=
 =?us-ascii?Q?8N/xSx8pxOM3BA/1p1M8VdhGQuIEIBSO27mdvjUYjB8tLZaj/PGpQ+HOPkxG?=
 =?us-ascii?Q?tzfaLlMSyKEe6z4np1Ood1YMhO6xJCV88yZy+3+gl0+qd3BVba5LKJqWqIrD?=
 =?us-ascii?Q?tnrUa5y+tL6tSc+J9I2J3Hiu5sss06yLasJxA077Q6WxD9CdtTgoXgnztCDI?=
 =?us-ascii?Q?i+dOeqsgpE1KReNCI4l3hkTxcwe+/c/yF/TWUb0RtIig69c8pX+NAHmuPLGU?=
 =?us-ascii?Q?j8lb8EPWeKTuMtIyDb67oPzeanLWmvhviT7WJBcQ5UiHKLzcJ12JW4VhAL38?=
 =?us-ascii?Q?y5yfJdN9N0KBPZaYaEmspeA6e86gc9IRzZlqJbyrE2Q6Wv2N3rXAik0wHLng?=
 =?us-ascii?Q?RaKlvzvEUtgB8sbjt/+oGvo/km0+cIyBZhAiAA756IUWaCh9qlez8j+LkarW?=
 =?us-ascii?Q?Zoju7vThTMbQxByFCH1IWmyjQtqHbECRt6+9cKbikY8C0MGCWUB3utAhPDul?=
 =?us-ascii?Q?DWV/8XUO914+PIKZeY8nUfjPRv52ua6XhfF0oUKg03GpixYMQ6x2VwacdaYf?=
 =?us-ascii?Q?fhAlimgd8UxbwPlkTvNOXWg6tb74poQv11COd3c5/n6T6HB9hFX89h3603NH?=
 =?us-ascii?Q?ezuJH6gfdWUVPJtsQTed3g30lGZjfagISwwVml5ENlBH97K+KE2+9/Fw/Jrc?=
 =?us-ascii?Q?R8qhzLDrEHKzn3jYoet+mgqO7A75PwyiSMdJTno1YXUyDgKyej9UmeHLDrE7?=
 =?us-ascii?Q?h7YRixNbntgFxEvD1G5gvDsqKPTtIlW5p582du1DJlGRuwoyKHBRk3HXUdrY?=
 =?us-ascii?Q?5EIFXkhCzNJIoVkCPIKAbHMPsu07l4n2HnxgpipZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6996d2-cb62-4d0a-b50e-08dd63683b28
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:27.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wy7EX07vLZwR9MQLXBowRCJOpaL/gBJBaqBqdk7Pykajm6bi6pOL9+kZ7nJJrCCSBldq6XqZMJ2okrBX2HscQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

From: Andrea Righi <arighi@nvidia.com>

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

[ Joel: Replaced occurences of CFS in the test with EXT. ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 011762224600..802e3d8d038f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -180,6 +180,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 000000000000..80086779dd1e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 000000000000..d4cb545ebfd8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++);
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(void)
+{
+	float cfs_runtime, rt_runtime;
+	int cfs_pid, rt_pid;
+	float expected_min_ratio = 0.04; /* 4% */
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	cfs_pid = fork();
+	if (cfs_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (cfs_pid < 0) {
+		perror("fork for EXT task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	cfs_runtime = get_process_runtime(cfs_pid);
+	if (cfs_runtime != -1)
+		ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n", cfs_pid, cfs_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime != -1)
+		ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+
+	/* Kill the processes */
+	kill(cfs_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(cfs_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	float actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
+	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return true;
+	} else {
+		ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return false;
+	}
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link;
+	bool res;
+
+	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	res = sched_stress_test();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	if (!res)
+		ksft_exit_fail();
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.43.0


