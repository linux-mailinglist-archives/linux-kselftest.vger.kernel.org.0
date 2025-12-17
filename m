Return-Path: <linux-kselftest+bounces-47670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08924CC923E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D8E30141C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85534DB4C;
	Wed, 17 Dec 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JQXCHfIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0334D92C;
	Wed, 17 Dec 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991753; cv=fail; b=ga8yhNhjNLsGYjkVexJ//jagMefPYPi5bO1wWBxJfc3MaVFXqFBvwtar2xFpGWvn3+uYXWymwqCPXwWN2QS4knB/fMkCVFZngHkTW2DzmmjS/f+fiK9soiwzQpmJn40xpKMPYU7nGfNb/Xdf2tuAbyFIPbTE3IZZln6q6cnXp0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991753; c=relaxed/simple;
	bh=pxtIph5ywH5bmCOcHDGLs1LRJ6U7WyMykoX9z7nJWnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3VkBZjEwQLQFuQq0Ep+Xo8CKNi+hxV+3dIFXTxbeJAM7P5kJ/uMmcBxs2+IMTaQwammN0Ie57hxkALyKGwWNnK8QqCnqYfbp8Zw9OjF4P+2dnuCfWTgjwmlNrChRbu1jifNw1FBiyUjg/F1TSy/YjDKiic2PFLIrIsoX0OWRAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JQXCHfIz; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFhjDCY7ObJxZVVUEnTpO0JwOym7id30OLB8c2QWojmDr/x0gxWZC/3vvLMNqshiicrfo1cLPiytJViuN/EZOUVivMwpr7tVJZnwIc1xIIfj1YmRBKwRujTL2oUiECj2PYnudB3O4bEoLR6w4cTEUjkJNQ+Oust6TeHt1uIjaJIO+3WZXoKPXnxdbakzPX6RXOrYQOjNYZkMuh/IuDFFDSP+xb36bkdqfTC/KykTLCoulLjVS4GkLInuONwIEz3gkwoPYRwydET2Qsh2ELj6BQB0/fi5PGOu0ovTimYCE5Bz2FOCHBLOIG+77i/lmoNbUygFoTQFVKIGfMRcEmGwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LxFezwLGhXEzaV1EksqyJT18XWufpOXpI7WL6qS2wo=;
 b=IrrGCZYc/9JupoxyxCiLwqoK4Q8IF/7A29jZ0meMgjszpxOuO44wFHHTNsvDynN7oO6noseZ4apCGSdjUi+IVZc8UtkyIdZV3Tasfy+LOqmggyA4XVEL0mu4G4xwoGl5UvyFFl4YLNE0UJ8nJr3ZSW1nqgD3+4EICMHRwwf3B0WzzS1mO5b/0Qj7Zlllpi0PgGJZJZLUAwA5b8Cz2iH8AqX3FQRZpottXGveuqVcaxKR3Ug4Kffd+ptVTUd+rXUiN8MbkuOo6dpUyIPyXCRsh0ny54j8bhgTU5WOTHiqRwrLsntGk++dmBpaVfRdtpswfem5sjrjTWZ12oQdlMsqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LxFezwLGhXEzaV1EksqyJT18XWufpOXpI7WL6qS2wo=;
 b=JQXCHfIzaEk7SWLo21CbJkVgDOq3S1glGnRWWfaVxeW5hIDVVmRtX1YSv4gHfVKBoEB1cHYVEugIGIHTZUjvEJCEBokpusncRUTrSf1M1KraIFOvD9rA+gUW6SAnLoaGATxA6ITlO3NdH2iXFmQNotw1QTw+6yWrxlrB3KvrlQkpEsuTeUkb1j7KxjbXg9q9UpT4HxZ0wA0Z8fCqbt6ydHHC1VtOh5Q1mtG0eO0zrtbTvElPA97gaEmJS7eM3zqj94KFQFlPfLGgtecUMAkZ6lwlBHE33cjVxpz6LGRWEt1JfAp/uAsdxai4NZmVl8quSOanvonqjJj04+myfMqEfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:40:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:40:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Wed, 17 Dec 2025 10:35:45 +0100
Message-ID: <20251217093923.1556187-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 235bceb2-3c21-4473-ded9-08de3d5044ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSOhZI3/rww8ouOsY8eKCnjsgbSsfX2rHDkjW+QYN7CVFfCnD/qAA2q706/E?=
 =?us-ascii?Q?seHY2oM2IhFR+L8v3bsCYtd+PjfdIV5I8ZJzzrXie83tvQ7CuYj+suWyfl/R?=
 =?us-ascii?Q?4xpCPhoZGv3naFU4pA5z5ah7MARi1FbjCL/KA9fER5ZHKt9kch62AQi+aoyk?=
 =?us-ascii?Q?GhfE3P2fyMsP9M1trprbdAovYGXfgCQVN1096c6a3+EdZwroofncJD7XK9Pt?=
 =?us-ascii?Q?IdfFH5ckUUmQ8WuOhD2gqw3lW3w28mQ32PCqanwOk8AGA4Qp5WjB3xK3TQ0L?=
 =?us-ascii?Q?g8Gxt8PaecsJvH+g7l7P4SWM0tv1tYDlk1pYjz30/dKPJUWi1fNv9BOsrsUS?=
 =?us-ascii?Q?Hit61tgas+X3PNJIpivfxZXcm/ynD1Rh2vCHZqZ6XtI1NV0QYC4kivkYNShD?=
 =?us-ascii?Q?6chOmtH0r/tD12Uh9OcjD9d7oTr8Z5Rs9bSNx4xwa4+5yBLEnq50hjA9dkF1?=
 =?us-ascii?Q?Y5AlNRlBtBte5v9zcifoOqkDY4Ou3E+LbUnNTEmjEfCtillzgVIW6nrnWH1u?=
 =?us-ascii?Q?7lwqE0775I/Du1kQghH2J+w07qa0Nksd4EBG0+ThZzBvzPwZm6uFfOUY2ZiV?=
 =?us-ascii?Q?wkWWA+NmLhmycB3blPV2crDC2YimrNYlaj9SGhJ/GsFsPT38I7D/JNeuud1Z?=
 =?us-ascii?Q?zRO1nPLI8NawEelbfea0vm/kNqZM9hN9OjdevLQ9E1KtKAz9AMdAv6I81UXF?=
 =?us-ascii?Q?BCq7DKdoo9aTyneXFdqdqob7q0KEXUqymmBCmAEHLYLlzFMOU25bgqDrSB0h?=
 =?us-ascii?Q?IPpQQxPtRn0vruZaLaT9o6bpMxuuV+6q5fj+twvid9V0beVhdu8VpJIjSLux?=
 =?us-ascii?Q?efWxtIXoisXM/4ezvoPt8xMccbhtTWPxhj3X7bT5bYvmpsBWTNB+8scRrzft?=
 =?us-ascii?Q?otM2gEZjuR9YxUYxrj7o24BYa2oG+SR3+qmGyQY3j0EChqsdC5qp43B48krz?=
 =?us-ascii?Q?hzkGPBz0SW/z+Gkdgxabh7pYWVfUgJvyUOuPz8GOt1xkOmIZGqtz2nvm2gAT?=
 =?us-ascii?Q?bgpXhKmEs2L/kzJI6oynV82Nx7G5aFzkqXzhA63VaY3VO8o+JaoANNJN+uJ0?=
 =?us-ascii?Q?zxlJTrCGFueJMdch29ozX65Ba1G6uFGYQPgNovTGllhwJKgzeQ3fIbIlVn1s?=
 =?us-ascii?Q?aj2SjZtacnKwdDFUEXIhdGnWDDRjfxsa3yuvD68n2qob5cq/jsOMCSfL4oww?=
 =?us-ascii?Q?gmkgU7VPrfnuCC+FmFkN3JFg9fEYHlWM3Sy4g53gXfe1FPnW2PKmGVKzX2PB?=
 =?us-ascii?Q?QLZlOaISG5h1zmtFiEyakQD6VGAws5u0wCDezpfY4mTcqJYZGitqK2/k1mTp?=
 =?us-ascii?Q?Z5PskYkv6X0tRZFYBH6JVaXcGSFcLlrF/JckzqE4OnKuf1Ljytm4H0TfgaMX?=
 =?us-ascii?Q?AsDagYXmDYs9ppQXPYZ7hC0zhlKVhcGeFy94ZKzeReTk63rjy2Yf9vB6OZiQ?=
 =?us-ascii?Q?g1tghBu54kU8ZGW0OFATKRZE6ayCHDDD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oE7kKLnjMaZCLopvfwHLcqZKt7+2Sye/v8vr91TSz6XzrEA8IzDqQGfiVfz?=
 =?us-ascii?Q?Hk8pQCPtc3tDOJa7tifBzW66Y6uUmfAdaouaSAVzBtT68Lt34UhotTJnLLzc?=
 =?us-ascii?Q?Rw+EubnRv3ch6LdTMhcmkU0fQv3oqua67++znJGEP+ac+ZoRpmJOWgqQZwFJ?=
 =?us-ascii?Q?6JIJ4a2W+fW/MxOrICfqIdV3TJmqgo+kcB4BkT7gdA3hsVq8fOr5qwEVQdwI?=
 =?us-ascii?Q?s/XIxVht5ado42eeqPLe31dxUGivSrSlS9e54svJPUWQqZXSq4GSrhBLoDj/?=
 =?us-ascii?Q?NYG+aHriJ1I5BCba4NtlABYNXsx1fOAej+8F3vUP/X1lPqmptLwonkvNRx1U?=
 =?us-ascii?Q?A1NzT0cvId7I3eD87f75ld3yEag/cbTdoBOQKApAjkGRWJKSp2Dn10htPMEw?=
 =?us-ascii?Q?Iz/d0fYsQWXdNmbg8P7619nPPyhRTSCJUXTUG4/qSGa5KpI8gFvrOTmcuySR?=
 =?us-ascii?Q?tv5k2PDwR1sD+yRblf8lr6nqlLgSkVQiuX+nusPuPT2Xp3yeZFEmEP+1MSn9?=
 =?us-ascii?Q?HyY1qlZ/zr/cA26j4BOOo6rZkN4PZyMcQD97F8a6Az3cW3v6ckzqhiV4TwQR?=
 =?us-ascii?Q?+yHHgedUM48tear2URmy/bM2ua5ToYhMkjwNYxwF96i4PQPJazgftRnE62lW?=
 =?us-ascii?Q?QHkO7j08B+VRtvhdROYhfMB9wvlp9BxKsCeNxwHHN6yms5aOZOXEYeL2o478?=
 =?us-ascii?Q?ipQqcu98bslBeMvgxMOBaNfpypKgUPanK3NIO9mYUHhpILiJ1DHgtHcdhTzM?=
 =?us-ascii?Q?fYuKqHyPd6H4lfFfvAvARVwqrw/95lcfbC0oZZGb8bg3f7tvmfGgN4VUv6fL?=
 =?us-ascii?Q?TU+N7jgk0//USNN3b91J751FU+JXzyl9T5HRf+4dX4Rgno17rHhMzuQ5Ob5v?=
 =?us-ascii?Q?2x6C3c/JWSL82EUGmNby73xDUXnlGtlBq5CID8DWMVldboI2In9SXQx6CDqH?=
 =?us-ascii?Q?PegPgI/Mr4UlnrHVWHhG3dHnELNybdyv+vBsVJwAeE2jNB8CYpSBye6xpdzk?=
 =?us-ascii?Q?fLn8i7pdlLRrRnYPxcor0h++vXJKOobfsUXSeS8KxkQhpY9wJJvMZEjJKACq?=
 =?us-ascii?Q?U1XB393abuTZPCHFtbyFFGbcrTlMIzLXwv9PHGwYq3BISBRBkv5+oahvLn7U?=
 =?us-ascii?Q?tlfPkAsxnLw+zEff4N5XiNQQElczLkhpiY7wQWoPn3jsxIX68m/lNsBruRRO?=
 =?us-ascii?Q?q2eaj1ds7MvlJFZhJ6jipIrlcY4skMv0iLsv/9Wl+FuXwPVhuJOJTZRkWfj1?=
 =?us-ascii?Q?92giBw6S8Q+KjE5KVmRWtoCy5m6XJNW8JVvBQIndzPZfws6koMqNxHIHoGxF?=
 =?us-ascii?Q?cGVlRdH+/1to3i8tCVfs2C1XKjeMuhaDBuWEtsysfMUbnoWleaKP90rKheZu?=
 =?us-ascii?Q?0TGMX4to0MHDuiE8XtAbhO7DxWZKOtb4wCh32Ug4MDRzu0dIhDBlilE2FQcY?=
 =?us-ascii?Q?VvxXmYUmC/A2rQ8rd5WHzKCBGjiWXiIID52KtUejIaWIVCllYArSUZPO1zAl?=
 =?us-ascii?Q?bjEmmMW8+1CJvBZFDD+/93oE0vWvgOTigRSCx1cYKP5BqDAxFTqLSZJ+O115?=
 =?us-ascii?Q?XrNfw8XtILN7jKDt5WBFjjvhDV1HGZWX4ikV/Fn6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235bceb2-3c21-4473-ded9-08de3d5044ca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:40:09.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCTLjdr7S+8paBnwFDamWLbtuw0J6JhuF68GX55UNDvmkjJktA+W4zAFQxGoUsaUfUA8iclJ3plg9bHNHiRJCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

From: Joel Fernandes <joelagnelf@nvidia.com>

Add a new kselftest to verify that the total_bw value in
/sys/kernel/debug/sched/debug remains consistent across all CPUs
under different sched_ext BPF program states:

1. Before a BPF scheduler is loaded
2. While a BPF scheduler is loaded and active
3. After a BPF scheduler is unloaded

The test runs CPU stress threads to ensure DL server bandwidth
values stabilize before checking consistency. This helps catch
potential issues with DL server bandwidth accounting during
sched_ext transitions.

v2: - small coding style fixes (Andrea Righi)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 281 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c9255d1499b6e..2c601a7eaff5f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -185,6 +185,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 0000000000000..5b0a619bab86e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 NVIDIA Corporation.
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_CPUS 512
+#define STRESS_DURATION_SEC 5
+
+struct total_bw_ctx {
+	struct minimal *skel;
+	long baseline_bw[MAX_CPUS];
+	int nr_cpus;
+};
+
+static void *cpu_stress_thread(void *arg)
+{
+	volatile int i;
+	time_t end_time = time(NULL) + STRESS_DURATION_SEC;
+
+	while (time(NULL) < end_time)
+		for (i = 0; i < 1000000; i++)
+			;
+
+	return NULL;
+}
+
+/*
+ * The first enqueue on a CPU causes the DL server to start, for that
+ * reason run stressor threads in the hopes it schedules on all CPUs.
+ */
+static int run_cpu_stress(int nr_cpus)
+{
+	pthread_t *threads;
+	int i, ret = 0;
+
+	threads = calloc(nr_cpus, sizeof(pthread_t));
+	if (!threads)
+		return -ENOMEM;
+
+	/* Create threads to run on each CPU */
+	for (i = 0; i < nr_cpus; i++) {
+		if (pthread_create(&threads[i], NULL, cpu_stress_thread, NULL)) {
+			ret = -errno;
+			fprintf(stderr, "Failed to create thread %d: %s\n", i, strerror(-ret));
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+	for (i = 0; i < nr_cpus; i++) {
+		if (threads[i])
+			pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	return ret;
+}
+
+static int read_total_bw_values(long *bw_values, int max_cpus)
+{
+	FILE *fp;
+	char line[256];
+	int cpu_count = 0;
+
+	fp = fopen("/sys/kernel/debug/sched/debug", "r");
+	if (!fp) {
+		SCX_ERR("Failed to open debug file");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *bw_str = strstr(line, "total_bw");
+
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus)
+					bw_values[cpu_count] = atol(bw_str + 1);
+				cpu_count++;
+			}
+		}
+	}
+
+	fclose(fp);
+	return cpu_count;
+}
+
+static bool verify_total_bw_consistency(long *bw_values, int count)
+{
+	int i;
+	long first_value;
+
+	if (count <= 0)
+		return false;
+
+	first_value = bw_values[0];
+
+	for (i = 1; i < count; i++) {
+		if (bw_values[i] != first_value) {
+			SCX_ERR("Inconsistent total_bw: CPU0=%ld, CPU%d=%ld",
+				first_value, i, bw_values[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int fetch_verify_total_bw(long *bw_values, int nr_cpus)
+{
+	int attempts = 0;
+	int max_attempts = 10;
+	int count;
+
+	/*
+	 * The first enqueue on a CPU causes the DL server to start, for that
+	 * reason run stressor threads in the hopes it schedules on all CPUs.
+	 */
+	if (run_cpu_stress(nr_cpus) < 0) {
+		SCX_ERR("Failed to run CPU stress");
+		return -1;
+	}
+
+	/* Try multiple times to get stable values */
+	while (attempts < max_attempts) {
+		count = read_total_bw_values(bw_values, nr_cpus);
+		fprintf(stderr, "Read %d total_bw values (testing %d CPUs)\n", count, nr_cpus);
+		/* If system has more CPUs than we're testing, that's OK */
+		if (count < nr_cpus) {
+			SCX_ERR("Expected at least %d CPUs, got %d", nr_cpus, count);
+			attempts++;
+			sleep(1);
+			continue;
+		}
+
+		/* Only verify the CPUs we're testing */
+		if (verify_total_bw_consistency(bw_values, nr_cpus)) {
+			fprintf(stderr, "Values are consistent: %ld\n", bw_values[0]);
+			return 0;
+		}
+
+		attempts++;
+		sleep(1);
+	}
+
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct total_bw_ctx *test_ctx;
+
+	if (access("/sys/kernel/debug/sched/debug", R_OK) != 0) {
+		fprintf(stderr, "Skipping test: debugfs sched/debug not accessible\n");
+		return SCX_TEST_SKIP;
+	}
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	test_ctx->nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (test_ctx->nr_cpus <= 0) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* If system has more CPUs than MAX_CPUS, just test the first MAX_CPUS */
+	if (test_ctx->nr_cpus > MAX_CPUS)
+		test_ctx->nr_cpus = MAX_CPUS;
+
+	/* Test scenario 1: BPF program not loaded */
+	/* Read and verify baseline total_bw before loading BPF program */
+	fprintf(stderr, "BPF prog initially not loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(test_ctx->baseline_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable baseline values");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load the BPF skeleton */
+	test_ctx->skel = minimal__open();
+	if (!test_ctx->skel) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->skel);
+	if (minimal__load(test_ctx->skel)) {
+		minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+	struct bpf_link *link;
+	long loaded_bw[MAX_CPUS];
+	long unloaded_bw[MAX_CPUS];
+	int i;
+
+	/* Test scenario 2: BPF program loaded */
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "BPF program loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	bpf_link__destroy(link);
+
+	/* Test scenario 3: BPF program unloaded */
+	fprintf(stderr, "BPF program unloaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Verify all three scenarios have the same total_bw values */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (test_ctx->baseline_bw[i] != loaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != loaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+
+		if (test_ctx->baseline_bw[i] != unloaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != unloaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], unloaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+
+	if (test_ctx) {
+		if (test_ctx->skel)
+			minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+	}
+}
+
+struct scx_test total_bw = {
+	.name = "total_bw",
+	.description = "Verify total_bw consistency across BPF program states",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&total_bw)
-- 
2.52.0


