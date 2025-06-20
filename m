Return-Path: <linux-kselftest+bounces-35461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92760AE239D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6DF188EDF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F02EF669;
	Fri, 20 Jun 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjIPjXx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC352EAB81;
	Fri, 20 Jun 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451592; cv=fail; b=f5nYhRi6FtTMnizbA/TwD/jXRjrmeYXMPJ0/lCWhXz0dPR5cI/GdoXEmt1Yrud195kHAZgobC9T/YPzlrX7tBtBebAptjgfc9ycsRLun9GbdL5zLP+olHLLOqkdK0InLEWwiYB0ibLu7bj0m9WhFaeBGMV5IhfAgoN8ZAr3aM/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451592; c=relaxed/simple;
	bh=XUaf8US8yp8yC16i8lwOhH493GDbhEg3+8gSn20+SF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejWjtxmOkR/tF+SFU6xVFsZzUAi4F1QvEQ3BdIB4j6KCWZxMRQjoTLMoSIbMPysq/xgHZdReI24FFPafHU+OXQN6npCbYb/8WwyLeZ74loedA3I1+hH5gyKDIiXdk2udmv5r0e6ZuH85i8Eb0FyN/sk254VnmNuZZN0lUv2lTi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjIPjXx8; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K82kzEyRYCjov6WT9QpPUmex0Mb3erRcBEnnhjmf04AaHD+YXAG1abbJqzOYDCrNRnQhD53ts/vOc0vzxvUl9OPp+s1dx49IVCMn54Xy8NlNlq6at10Wc/bAyRb2J6iXGEu0HBKEw9BkITiSv9LS+yWzu7ULimNAEeR5IQSXYT0viGr6z6vtPORt/X/Kg9lU2yp2jRkJsEkA/gbG7zPNOeuT5xbryEw3RZ0gTEB7G1g0quiBl78ll7ysn4g2hkJ9mMsQ4d8caDpvxe7Cyya/z5B18JTnjoV61Isdi7PM62/6vS3hPpTDZPyioD2xqwLPRStRfvWj1fdeUSBJwh1lSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eg2tUUcznvOF9ook20X/S8BCOmvAG8PrcpYtqjLMvk=;
 b=Gzwh5kni/xw9YXy6QUgqgn/rK1DWEbmT9VbZrvm2ACwBHLDzLI7yqFCvCHBasgA9me/GucVpAh4HMm8D5+17wNRihQfom2xq/wsuSo72INViXddi7ea6SnKIQENjy1EAeWiMvym1CWLA7GvXAs8DzkKGUwReJE2LCzaXsbZKpsFzWry4EPXLreEgK8vufmOrdCbaQH7/mKUkZmp/fyzdujO5Di8k1VS3xMjm9MWm44VXldLGBN2Te8eE2o9KnXN3SYeUhKJu6hrG7StEbLeT6v5l/LKRX7joeuVe6V9Cf3GWciDJQLfHIugPflHqf5QEhTZppDHPtMDEyBTcqg9A2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eg2tUUcznvOF9ook20X/S8BCOmvAG8PrcpYtqjLMvk=;
 b=hjIPjXx8uY9cLy1rYAUPOnMJLSEhCCWwFa+QkTNo/oF6qpgxrfiVFxeGO9c2HldNmVc9h6V2Ji4WDD7YcC77jGwkhMR8DegJR+NZyuilm3XlgMezceXWYSlTstNZhn5B3WjoEogOvg5F52/wztG63BkMEdrsY2Pi0pwQUljYJH4DClJ/Lt1lSa/QVhEoo+H4CMiD3scQ6K9m7HfoCu+qtl2+yWX2+tk2EmTtu9rJyzjEBYR/R/GabfW7UwwLiOoOjzrQ8QOs5xwH2ciEX0CSK74vUFlcRADMJSAdqUoBFGneb1iB0qkYEvKImM3VU3sFjmQ/H8bOW4bIZ6tdSAWlww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 20:33:05 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:33:05 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 12/14] selftests/sched_ext: Add test for sched_ext dl_server
Date: Fri, 20 Jun 2025 16:32:27 -0400
Message-ID: <20250620203234.3349930-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0928.namprd03.prod.outlook.com
 (2603:10b6:408:107::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 0857f834-14fe-4e07-83d5-08ddb039a94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njXber8QzHlZcF5pH02LOJ9eZeGeJx1RH7a9oPG/6ONfOeZ0Bo8qJM5aG4ca?=
 =?us-ascii?Q?BnYblUzHPSCM3CUJ+TWgziAf4XCt7ZZkkqe6+jS4M+ps/1+gSFN6+snTnycu?=
 =?us-ascii?Q?/40UwSk6bzK4b+dfHQxSQ4i3riHyJo7MT+XJCIo3AKKnASDnbitqsNmRh89u?=
 =?us-ascii?Q?PUwClQxl8f+U+Nw78z330M86XgMBpEgdMooInaMvlDT6K3f2AAI5U+fxbFHn?=
 =?us-ascii?Q?oXWUKnKAywhT/wh8zkNXpaSOx6wpLkncKFQOH30SD26r3dBaGCZTnOAXQ23j?=
 =?us-ascii?Q?0qDcje8mYerH7pK8eNIN9bSVwcJFSPMm+BEmibGgPbusUGYlHmZyVSUMDwMy?=
 =?us-ascii?Q?5rzG3hFrdra2tSH4kvPwVQpS+MwOVAsJUI+P+7kbnkAw0V4J8xCPWLxOKnGt?=
 =?us-ascii?Q?kaYQ/GWoWZDC3EvXV8ENY5uu9i4tTmMoW+fBYWrz6tvyuSLFECiGgmN/Ee/W?=
 =?us-ascii?Q?vnsKwAvljfIFSUuFs7PDKUK8M3Rh+zAA5fYMMM1WmXgk5ivmotztb4U0ivkR?=
 =?us-ascii?Q?p9XIewGh9svHBDS3H75h31vdBrCjtjdz+iD0KkDPwcLsqiDOodqk6IVCbDDg?=
 =?us-ascii?Q?azPx84HlGyBt3B1/0QMVV80dbygMfl8PEBizDVmeOfgtOooOhVbnXv+hAMco?=
 =?us-ascii?Q?vPS9bEntRxVszMPdZIiNxWgvunJmVYKgkxqW8k4VXv5oSykmgR04T2M2UINa?=
 =?us-ascii?Q?RFxre9F9LUrMwgVdofQgr+zAnFhhJX9ad4qgld03xMNf8kZ4rfUyXYlfjB4O?=
 =?us-ascii?Q?YJFNhKF0f+CNtHFsIs+K7pBOOYZeao4V027xUDyd/LO7eF/SV+oS+t8ymfLn?=
 =?us-ascii?Q?6wuTWxt7yoCCa3QN0do+ssrQD3Brvd8zjnauUDT50l72XpRPIiR+Hx0wZZuK?=
 =?us-ascii?Q?n608Y4iHTB3LINyM5uzhW4OTcKr0U4DmehNoXPX6kFAZTmop6LHNib6Xo0YI?=
 =?us-ascii?Q?+pQcG/VQrHngapo8o2NkzY/VMutQ5rK3qk9LD3xpRX2zhg4yFT7YvS70ZLj5?=
 =?us-ascii?Q?i5yrVAc814XxVJvqL1Czk6/glQ8+As5YAzkWqx8j1NiU/Di/EBcfV3VzQ3FT?=
 =?us-ascii?Q?ENfsWW8UqKm28yNNt12NozqMlHJZA8xaiNTIade1RYtzfBN5mnUNNkWHNf8I?=
 =?us-ascii?Q?InDqUXMPdUWxt1L3H1M9H7WVCHNBID1wEBr22orDvqngIulvIXUkmLN02+Z/?=
 =?us-ascii?Q?3YDAstGt2DOYCDpXApgm8k/cD2hEk5nah9oejwd1kWkQbOpYpsUWeGCn9YaN?=
 =?us-ascii?Q?NLoFdPSxOyrsliEJHUm5w6RYeWI74njanYtBDFJxc5oKBiE6rnzCtZrjLNje?=
 =?us-ascii?Q?y2xcur/2c2HD4C87c3MaGDkaJL7lleW2Hu7Y4K6J3poHi6UiMVw09yclKbf3?=
 =?us-ascii?Q?ILYdg56BD92PV18mrtS0S3Cw/Xzw0M+qxvgTYsuxEVjt4TvQCpOtCOM/mPzX?=
 =?us-ascii?Q?+2pw/oE27rE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tys6hPQaEWbvZlqd3wb+Wktsnn3FNoOfm20MVO18mvNwkfaEdOgmzleO1RMq?=
 =?us-ascii?Q?GpcGedyjTXOJkx4A+l9dYTkDzEiDpLjDZ2mtjmdkRcA4D28K1TDr5sLCV9Sl?=
 =?us-ascii?Q?OHTq7x9QFz5F4dxenI6nRHC+MNWkFvC1bZWG+VWJLRDhwwcsT2pXuoNBY95y?=
 =?us-ascii?Q?f/Xl8SdlHoLj/ZHoYT55gOf0o3k+owQVaLOV0Vft/DNVJU6UMbwgXNWZ5/Zp?=
 =?us-ascii?Q?hg089w6xDaJKVDXUPNJPSNzS58o/297nA+nFx5yLtikZSE5Ch84ulhLa3s5d?=
 =?us-ascii?Q?P/ftGDS1YrbMrwsnofwHkgXoGZBZCn0WPpHXzxLv2twRo1GlHSd5k6wame0F?=
 =?us-ascii?Q?ATuRgjxGnhuVtOTT4XM1C/HaVuQtSh2jQ9xq+huTBHgEkdOnULxOjPvU0mID?=
 =?us-ascii?Q?hoE1Yfs9cjeIo275BqI0/YH/bsJrT5W5QzHbr3mYkIY6OEtn9RqqU0pQ8SD5?=
 =?us-ascii?Q?RuJM/q28tZehFk1vZ8dGkXB3aieXamPSCwkl4V/1quvt+PF7MNaR7FfjT3jj?=
 =?us-ascii?Q?1OzrbhmiQpR/jFX1z9ZDQqj0llXDZyGc0ULRZz/TKRvtEUn0WT576CQDRnoc?=
 =?us-ascii?Q?wM96j4KbeS2Kk4xRulH9WdFxAveVSBN6TYnJ5/KfafMXoztfAMb6QNR/Rs91?=
 =?us-ascii?Q?u/wVL+C1681hFQ95E9I+K4uCQdp7Cl4DMwthCqc8qh5zDyxwyBpiZTCsM0WN?=
 =?us-ascii?Q?5JyEZVFNFRfCOXxDzj1CyUs+WY8W9IfSKVGuE0sGiMX6Ku2jzu8HMeontOvq?=
 =?us-ascii?Q?Kj5PTEm5oNXhc6eOXm8sLl1/seEs7XIkFJHPrJ+24ZE9LVIE/1vihv84istn?=
 =?us-ascii?Q?TDtQ0zziHkIAPpTrvCNrgv8ON6WKOU/+aPR8i7ty96GJpXXYBb+RcROJ+Q9o?=
 =?us-ascii?Q?LyWQBjKn0ZvLgXUgFIgFZUxJf1xbzngDo9soT6I1JxL7S65B7P9FfIbo+F14?=
 =?us-ascii?Q?KHF5Bb38O/5s0q9MLsglNM7klYaDEP/rcgmrZadPL0UgpSr0RBnGwWjDb7AT?=
 =?us-ascii?Q?ikHWymAwWfo9IrZEwXoG+pgtBgAWpp87SujHKsfg4AlAKwp5r8imaPvYh+bt?=
 =?us-ascii?Q?u9Iipw0eVpJAlCBP8C6UchaSjXhhDZPo/mdUQ4S+8fuRkzcftmE8WX0ZK3V7?=
 =?us-ascii?Q?bnTnt4pP+RDwPavSRDnn+DUb1a+Pg72QLpEJgbSXMNl4u5C8FBRTIrhSSzqW?=
 =?us-ascii?Q?Ij2QkChDlaubf42rdEpw1DSWS06XDMrm2NQYy1K+rtVud7eD5u3aZAK5yckZ?=
 =?us-ascii?Q?y6xj5727tK/f24qOiwXgxv/kID5L9b+NZa49mhpKtGoxROHS2ronF10EOSaf?=
 =?us-ascii?Q?L/fSmNlIu/4dGeWOaMFatciJ1JCQx1h6tMyQWOPZupMXxYhCcZhUyK90UK73?=
 =?us-ascii?Q?XndLF8OO1gd9t7Ha2nIRhs2CcSnCOBEOXe54Rt4Wd2kXRmD2GVHYrRcqNBGX?=
 =?us-ascii?Q?dmmeiFR22YAMFGRC8eIyBMDx8aBa2QbdSGC0k8o010XUF4fkPXM7XILjNG9J?=
 =?us-ascii?Q?feUI3L8iS2kVh3W/0NpespfG6bljr9z1y0uQM204/77+ivEN3lOuttjht7Lo?=
 =?us-ascii?Q?CFx8s2uMZC61wJ2xnQT6E3eyfzhGiciGOXWWAMOk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0857f834-14fe-4e07-83d5-08ddb039a94b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:33:05.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EraR+P1LzlZ0/CvaKJZQDvJQ+JeM0RLsaJtvk5K419bZOQM58dYDPqsEZoKhaxv+u6zgk1YOpLoFePEY7rPW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

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
index 9d9d6b4c38b0..f0a8cba3a99f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -182,6 +182,7 @@ auto-test-targets :=			\
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


