Return-Path: <linux-kselftest+bounces-38632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C4B1F5EF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837FB18C23A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B82D0C94;
	Sat,  9 Aug 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIem37Fq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9502C327F;
	Sat,  9 Aug 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765340; cv=fail; b=G15ta3LCKvex+gUgf6LIOSxFyYjyMkT0Sb3+XwPgTTMWUGg7a2zLH1AQkjs0FtJorlUSM2IxB0QypQvRm9KlcGnXegi6dojgzjRfz7S9Ny3zOEM1TkwTE5nAevJWV9kF60ClmbSxWYQWtm3dScav9aGfndptdWtdEJzaUP/t+pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765340; c=relaxed/simple;
	bh=+2eFNI2iJf21rAnk/i3arTJz5GL1+1S6ItPj9sRTz1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZTHy9gCZm1fIyTXoYlOuNxLse/tXwZ9IE2rU0CeoFDCAQOqsVSRIPiknVfc4tKBVuQwxGWYu6CryZwV57sLYUjnN34Jd6oI3/61ILK6A4RRgdA0PLMIwYc51ADWvhfBx5hQJ0EFa/BLc1+Wdx5TLhJsB6vmVARDHFKqzk+5tmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIem37Fq; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHVDJliH1hO6UYocfsjNauMa77Yzr1vBFriYOhIFkZPc8KPNrcgdvefl0OC6edLze6s5FB3b4rYKO8swc/S207frUp+zGEcrm4sQQF3EmT7/OCt74Cgnz+dZtBDFwAKfjAPRWrbwkxX2P3Gh9pLx2gPJSI6nnRwEsPIGUbCAaEhFbI3LYSOj1MWxm1n07sHCTcjYt7pZUejCyRndOWRC1XwW6IMcbOsyM8bu6IpyYqLUdvltYNgbt6ot3wKxSFB3Jz4DOh339viW7zaCmabAbkj8gWcxcrmzILFYhkWD7F93Ygw8MOQ1Hoswgwpw5L/n69YhdCAW4pUNBrb9pA+HFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbM8bSOqMvXoKc6HAbs1mzHj0ep+N5+2OlrEkjS2W4o=;
 b=X9LYLL034ctnLfymjOpuwT4kfKhzQl8xfeDj8js4CSQS+2iYkC5AvS3IcsuRNn1mES+YsAAZX8Ha1FbVkO+LIKm7zhgF2WoyFx5sBxcoZp7XYsyWWVF4NCmn6Wz05QIzNnJEFvKyvZcp/IFjIXL2Bdc92JFoZ0rF6HqM/R5Sv9y8vLxLF7kCMGhx+QFIx6lU0luu7N2V0saHnYrL182F/Zw8pacoOGu6rND8AwthY9NgBlpl4/ACdpZEKS0qJJheChkmrjpcAGo647gPtAUsoOEpZXhq3W8ouEjGWzaq3wTeP91pKIz5Kw5agBdBS/96QTrztBURvQDqAw4piL9KDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbM8bSOqMvXoKc6HAbs1mzHj0ep+N5+2OlrEkjS2W4o=;
 b=CIem37Fqmce1CMHylvNcfPFE+CjZfVgAQ6u/R3mvtYF6Xom4CoJkGOIkx3Vt5WRqxDNuF7es6vnmiQoKPa60WE+8FFQ+JGvbCsGdPb8qXzOaxs+CiU4bvKmcWeiJ0Uuj0d4Kx+ombGp8OtAEEiYQySbIsmGerHSNUQMWTcdDHAUutjilrp2eI5AJmkGLtfSzWuMxjCKbIB3MMFWJUqwQ1BJqzIZgsBRwUoJzvFB9QRg2lKbLs5/SCN+o2oSAk+vPb+UHDn3CQbzV7d5LVlDAroTWrV4+wq7BLXrhjMkT14P67AV1yWM7BCPZ8FkEjgMQQoJ3mnNKawhd1gFvrLciQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:54 +0000
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
Subject: [PATCH -rebased 15/15] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Sat,  9 Aug 2025 14:48:00 -0400
Message-Id: <20250809184800.129831-16-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0649.namprd03.prod.outlook.com
 (2603:10b6:408:13b::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 158ebbf1-18f5-4de3-aa57-08ddd7756412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+8Nz2zEFYPhI09JX8FkRM1ZfXLPj5x3AD7an2Ecqrz/mfTcPRjvq5Tfnyby?=
 =?us-ascii?Q?n/9ueuDZSkZZkvDBvd6vhPARUCjfb0eHZ3bGYw5fLuJluOTewjOaMp8Xpiz1?=
 =?us-ascii?Q?DWj51eN1bJ9BEYtRM5QhWtjMxj8qQ0eusSU2F+Ejatn1VoB7rZ9axSC4xN+a?=
 =?us-ascii?Q?OayfaAUkwtutiwUXWQjYmj7Zw0KbQRJn/ueJn8INqvjE2PihXdxbpHS9EQFt?=
 =?us-ascii?Q?MrMCxuHiWOSFCIwZbapxc3tFbBTFrDQ/DWABeVHPFjstdXotOOmORiyGBDfJ?=
 =?us-ascii?Q?xb7nOeK19oxbTZ1T+/QnCnpHZ+u8DONkveFVy6YVhdoy2eC39jpQBxHxS7Pe?=
 =?us-ascii?Q?nDY6slSwpHATKjiN0NLXv5xCvIFgzMRrvQSnNgIvp2AFQqBjtm0EJ+l2IGp5?=
 =?us-ascii?Q?iLFEFvgv6fPoIsFW6DKYEXu9m4I3nRDerq2ahwdsbUwe7PO7Xm8TLgdLb9yg?=
 =?us-ascii?Q?kpmDmpUOfHlbhbndGY1NZKEOtmani58XxhVfYeHgap0B06s0I915Z+Uo+zve?=
 =?us-ascii?Q?3/3bK02pR55YDN3+zW4Wtxgiq0iGuhQCbVJLRh3scLt/vCJXkGG78tz56zGA?=
 =?us-ascii?Q?7qIYoB4DfO62PH0griMAk7MlyJhj779qDfldCVNEDvsC61gGffJuwS3Ora/A?=
 =?us-ascii?Q?WHQTeli8EqNwyYYVudE8Rh1V+zLEyDOC3Y1RhouRzL8wQY6Zs60w0KEshL9U?=
 =?us-ascii?Q?rdUZjoIpgLKSny7TQlltnjCEOuPoSuwDJCHGH0+xkegUg+oJzbrRZ3kiGvmb?=
 =?us-ascii?Q?FO7e31Zs6GVwxhWWO+6WSr2Di5jf12lVSrIaePEEVdCqqyOBBic3ry460w2T?=
 =?us-ascii?Q?KLQF5nTcigwaM/g6GYMjOxrieVidKDvupYgXxo4IjGFtmfwUcl/WXwDD1RzB?=
 =?us-ascii?Q?RENEDvfDc2idHRXJgevuO78MChKzpg6fADZKESoZe9DIFeYGbd5y5HXLv6Rj?=
 =?us-ascii?Q?41dyKx5p7aM3VKCrpoTvEn5NAXZlvrWlezv9yoaHYuowlEYx/CfniQhPGDmE?=
 =?us-ascii?Q?8SGbCbpLsl7HWzP9Hu/61myFmSkh3B08Oa5GxSeZ8whEqJoYqIhhaCE6Te7z?=
 =?us-ascii?Q?5O83/UgiePBI3BW4J3fGJ0Iy8xrjcwAg7Q0YCHHrXx09jONc0KJ2ZMjGesSQ?=
 =?us-ascii?Q?32cV/GlQPxLdWL18WqPyAbKjgrTpcNs9BcUyhfwJ6fFTdBToO82Kk2WW6N+8?=
 =?us-ascii?Q?IAx7qtUB2tglyeMp0dVRp7biDlV+Ze1y29+qSn1pAQDZLzdY8UpPh8T1kW6B?=
 =?us-ascii?Q?qAkH+ap/ynFOjtndazI9ymxzOPNWEIRj35zBkkN3nvnUJ49HuwqcMdxpTXSU?=
 =?us-ascii?Q?bICjhQf6JDyp8rOxV9HAKu4jEw3grHm6B/ZcM+/Q/R2jipoSPzfMH9N2adUE?=
 =?us-ascii?Q?4OETFvslANuwfE/B4WdStGd/SKEilFpctjjyXyyDzm1g3s6DasrOUScKQy2C?=
 =?us-ascii?Q?+tFV+out/GY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XromI8KUjRItY5GyB34c94p/dETPp3JU3eotGvsgVeam5qrCviBE7HtY9xhu?=
 =?us-ascii?Q?mUUzu0pGlWCcXV7Bopet4n/laiBik5cZBpu/OGsEbb5cR2Mb6H5PeD22lvUB?=
 =?us-ascii?Q?ghVTDSLpqCFjEuNZBnaMb0nkau3FQCaImtQZqaLgIMlNK8IAxS4galYqywY/?=
 =?us-ascii?Q?26dvwF9Uvp6UnCRuTwrUmXnwWg1rdVRMJXi7MDNTxDy5EOiX1Zfyk8P7oPay?=
 =?us-ascii?Q?tVNa0UpFskWIi3bi6S3tUEHAy56UpGs73e26M3LowGBznShUeJcpMPzifHOA?=
 =?us-ascii?Q?xWY0YXsmgOyoRSoZso40W63IL6lNsU9sPc+Rw1Zv2chw5gB4AXt45IzGS2Dm?=
 =?us-ascii?Q?n31dtPBExewpxy/fZJBKQgvSS3blsNrIcztKPj9mFTKedzIo2WbUyV8gj8He?=
 =?us-ascii?Q?uKLxvaG/IhIXUGv8kENDw4HxR2GgNy2piBj6wvd3ZC1vX0CmoEPDu6ljtYMS?=
 =?us-ascii?Q?YQ1Q8nlYK2TKqKz18K9j/iZi5MH1dcUHVOHKeZ7P/nWbGKvLx5ZpOUlO3HlT?=
 =?us-ascii?Q?Sb3ddzu6SVbZquzHW7nOHB4wQLSyxcl2dj1e3AmTVcmXG4LTbBWxCCpztE2K?=
 =?us-ascii?Q?Ry7+AtaffxTHW0i35KsfaWCyz/72Kv3JEw/2j11wne0CIXG/B3ibVDExO2p7?=
 =?us-ascii?Q?LUftfGV3q0QSDLeizkeRKNFqypPu5r8K5dvxTXVUIKBveNPgHn85xgGN2CaF?=
 =?us-ascii?Q?cCL4NUYJtpXsUxoWxRBCAGMd4xMiRzOupwscDJz6H9ZswuwC3zqfzrIiCYer?=
 =?us-ascii?Q?VbcIUNyWNGeux3GiHKfsyc8ycKFhwnkoGfaTpsb7SUbEL+6M4WDWmg09w2HX?=
 =?us-ascii?Q?SYFxbYkpgLnixnEq1hTLz37eVeN2SIPIV1MPW7TtDsDSROHGi2EwSmhrTws3?=
 =?us-ascii?Q?jrbRJZ12RXuudrkvwFj+22vRvElstXbUKpUMvvjsxeorA1WV5LAIZUW+Wn9s?=
 =?us-ascii?Q?K3bSkDleaSx5pmr5EDgn1CFW2wnViwqIghYBsla1p2li9g0hfnh3H+dk2h8y?=
 =?us-ascii?Q?R6wTo38sUyzj0bx5p/kIhY0ltc5W3c0oPIYs0miZWj24Yc53WvVp9FPQ4Y0j?=
 =?us-ascii?Q?MmM6BcA9j9eN0PxEkmPQh5B1e4+PZ/KVfZP4QR572fKsccbhqQggf0/QHNC1?=
 =?us-ascii?Q?HnXhU5bDC2BvXfDBFRdvIZ/XGRlXhyADt8iBv/Q4IBXGGyM/2j5zdSb5athS?=
 =?us-ascii?Q?y16uE7qqsMstLnAdZ8DPF0977TpiDdOo8H++UfU0T7wMFxozRZIouATjatdk?=
 =?us-ascii?Q?1ENzR3weL1l+hkPk7UyMMX9APyi7nuY6HuYBguAWZaDVH5ky/yQY+qzV2LNj?=
 =?us-ascii?Q?KjTJ875GOoezP24wnFqropgEONFplwN/3E+ZQzcIGTUdS7AR0cCqQulp1FBQ?=
 =?us-ascii?Q?SrxjXYyfVH0JbWngxhnqkciin/wM9VAvKjdWSInxFx6qCV/juEIopOhuaHWz?=
 =?us-ascii?Q?Vmk0KwzOu0+4UWS902jRcR/lQ8YHeqpIVC9NKdNDLtQb3dUuWBupgb8gHQLP?=
 =?us-ascii?Q?3uDvLEBoZP/vQ2P8UKAyLAKRJbFniSFwQRR5FwUPH1Ep9duigr1CB6hubJs8?=
 =?us-ascii?Q?DEEmEgZ41M4w37I9JSYDJRUdeQ/Y5UJXL3NgwQUw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ebbf1-18f5-4de3-aa57-08ddd7756412
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:54.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3k0hDUhLFSHn1hPl4qb2qh3QXekJl6EQgAl9XKyWw1TLug1tLC7X+8ppxHbIk5/PA0ruOG/at7bn+JQTxwc8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

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

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 282 +++++++++++++++++++
 2 files changed, 283 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f0a8cba3a99f..d48be158b0a1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -184,6 +184,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 000000000000..d70852cee358
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 Nvidia Corporation.
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
+	while (time(NULL) < end_time) {
+		for (i = 0; i < 1000000; i++);
+	}
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
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus) {
+					bw_values[cpu_count] = atol(bw_str + 1);
+				}
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
+	if (test_ctx->nr_cpus > MAX_CPUS) {
+		test_ctx->nr_cpus = MAX_CPUS;
+	}
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
2.34.1


