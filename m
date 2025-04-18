Return-Path: <linux-kselftest+bounces-31147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA3A93A74
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2731B67885
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A709224B12;
	Fri, 18 Apr 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TfpuvV+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF48217670;
	Fri, 18 Apr 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992666; cv=fail; b=Rr3/IG0NaIlAILW5L2xkAhQ77tnkgjMKjPEJwlnyE+XHLP8ouzEFvavMpPdT0uTjEfIIwBBUoWaM49K951Bhj/q7knxYn5ZUVZ4dHBiQdvMWCXbG1jJBmM3N2YVABOimkZjXmUDcA+wien0RL52h3vb8OFoMSdXJJRMJPj3W0q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992666; c=relaxed/simple;
	bh=tN0yXp/74IQLMZ5KD4ZSQ93Qy+VXoayWZUatNkARH7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUEQJc/9jhT+QwWA94DD7Hur2P6Mavl3sFsBtm7XL3m6v5MC5RhYEjWsdJb5k3ReW5NoPMWTEXAYAAt17GykDf+JfBYBQwX2Ux/SU9A+iPm8vN+hEn3TD3X0dGRUlfG8ju8GJggoW140VPExz73AMaRY0Q4CjDY5yxdiB4P+N3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TfpuvV+1; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2afPzCGh8dvWen9+ZGLloPIWjSwS670Io0GlYsgm+b6FXBKo8x8eEiM36CKtiG/R+J4Rz/pJ+MPNha7K/f2QjO0nLDJ0LcAzRMvxYt+bohOX6LVCwkQlpLYdJT8D9XcDo7RMv/Kburog+1HQnN84Iw6Wd9WHFBNux6rEFv11pyp22qf7fVjuNnf3H82hptUbPbXBWd2ZqGgcplNLDdb+UoQarO6384gAdqqIlwSQQwJsT3wEVkwn7VqqpK1o4MrE3QJ+V3OQUrJDKksEshhiOe9yPx4soSq9S0djZqrcrAJNwDHN0AHPanMlkBHoOaMHKcGHPXsq8UOLfCW7XeSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy6cGgNJv05JiZ0CKfmr4xNPJ1uZr2IGyejShc2/Dg4=;
 b=ccQfnCEgJBOuHD9DyCxEukPQrVHWup4aUQsBpSRbWUFfjrEJfzDQF9IS78eHKXbkM5ojekU0ErCC/NrO3JI3uKX9OL2R+zCbyFjM9oq60VkJbH0hAove4NZcS38ByvJ4LU2GGRG91Q3QGugmbm8PfnM0NdDt0NcmxzPds1aUbMqup6bU4BnIDVTl6KoMyW9cGumZ/HXOKgFoas5IM4b3eE+HUql8Z1z87wxfQrqNyTDc+sboyUmpHDlngtG5Lnpes3fgfHJVTHFCuRVhZWa4mY0L5SJp0KPoIE4NWsRT1iOt2irmABYYE6Oihn3or+OBl628d8MFst1+amybiOKejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy6cGgNJv05JiZ0CKfmr4xNPJ1uZr2IGyejShc2/Dg4=;
 b=TfpuvV+1G6Hm/05qLgzUy5ziRovFO1uoJEmGyfhvTa8AZDOG0zEDNgFhJ9gkKxF236laF4wUcJcm3Je4x+B6SnBqzylt+83iyoovrhP1iMueGxHMAXid3uIQmo0QOZJeZIf9tZ+YuTrM49D5yCa5dFatQH6SL/yS1GRO6/Y7yqNBc1B+k19EAbaOZAaD/BqGBwriEHkm72jawvbW/obwykrAw+0DxheNjA4KSH6lLJ115M+g+m6buKc3rKZs/OVA2huhzXgJzZVAt4I7szEL5DkUH8vl5ligk3BxIo73ngvYpmmvibuiWf39V1kAEmuNyz9jwuPdKxOSij/+nowwHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:00 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 04/12] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
Date: Fri, 18 Apr 2025 12:09:50 -0400
Message-ID: <20250418161005.2425391-19-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:408:fe::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5236ec27-6fe6-4581-eeb1-08dd7e939c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HIWRXOkX5oMEVEP68DM+jTJ7K9Ay0+FALMCpYXxS1V1uLH37x/A6IWvtMYkv?=
 =?us-ascii?Q?1O67yn29XCZ80uXNZbEyFUR1vDAbf9q8MCU9fjYX+IkpqBEVfOK3LAfCMFH9?=
 =?us-ascii?Q?q7NXDTvc5cnXBOuUOQKIXZDA1bBAuGGdkgu5ZFlNARmTzpMUDMAFlzVMlJ+H?=
 =?us-ascii?Q?4G5YE+RQ7BUaPfUi/nRt1pwuFeG287pPWAECC4hZnJJCIrdgEoyOnJBQ1l2O?=
 =?us-ascii?Q?CT05NLLke5uUgxrocy0eKsVkJTyW2y8RmlErhSz5/OTIsO0Y2CYbGhq+UBXj?=
 =?us-ascii?Q?iYNG5Pp07yHQ3hX6UxKPT5poamQf5dc/UCPVSR5QOYLPOqw/DuK8vtrzcl5Z?=
 =?us-ascii?Q?5H/EcDgFtYY34DfiuK4M6Jmv//s4bjfnp84FNUTLJLCtz37oA7x7T63h7U0U?=
 =?us-ascii?Q?acTtPFxgozjrSprAlKnljYK/GBatNV3NDapxpsF+0fGOCZhFyBYJql9U6jq9?=
 =?us-ascii?Q?/sF5e/XC4qMEEhPRT76LX9T9EFTk5M/dL5sw/9ta54L7Pq//lqcSQ42PlmOP?=
 =?us-ascii?Q?zN9lf8A8CCPj6v2qtm/wsPHMrfRqAZ68iZjxeKaI9mXKDxthuSFffUcXXtBM?=
 =?us-ascii?Q?aoyuzrbawhEQlb2Z90cgKsZBTklQMDLNaI1rJ0bqLcRZ+z7bGv9nxRlLzPAH?=
 =?us-ascii?Q?WLC6EM+X5htGmzPWRqjUvMc55/nBAfmuk2j0bGwct84gGqrB44GnRzorV+M7?=
 =?us-ascii?Q?clX6b5gh5ThDeA4xFJsyVYaI6yB6lFzKuXfV8/ThYIu3TJtLR5OMk1V8adkM?=
 =?us-ascii?Q?NXCDEFm6UXFlk+Dea9poXnw5y5Wk1JXGSoHO8I68lcFS2L3LMA5dNusGHh3v?=
 =?us-ascii?Q?AHPyfM9HCxP609TQiXjecSlWjYcRByVjKENBYzOBepGyCDuyuzeB9eTd35nW?=
 =?us-ascii?Q?5hW2L2JUxDkaz/Hmp1KSQHHxTv2xo56YVOzOX/kL5QXxhRZuaDOiRzbIoxJ/?=
 =?us-ascii?Q?9W7Q5wI1UGOZBVeO6LRceIPDXXxLq///RWzDu+lkWObkEOiuJwpsYUn20PcN?=
 =?us-ascii?Q?qIT05GiciJM/7SR3C8FvNur24ODjqNSpP8TP7jozQJOSNShkr/z8w/ssXRSl?=
 =?us-ascii?Q?zbuZwL5zXoWClF7KEM6/u/JeFMRfrh7keTN7cD0CST0y7sDLJJBWcBT8C0tb?=
 =?us-ascii?Q?9AFZ5MoyDJQUiVYyiCAzSA96ijNIVn2xOur8ag0qVXGLokBY55GqGD01/Cra?=
 =?us-ascii?Q?lZHaRk9DV7Kx8z5C0+6w+3U4Fn4wCJbnOe1B4Q0C8j87LUuH0a/l+EHxCSCI?=
 =?us-ascii?Q?H249EGnpRp9aooiep26gN5RNqNx+Xw250hr4PbSgMNmgy1d+F9PrVd59qyVK?=
 =?us-ascii?Q?UU3n/uSV+br3xwG2MRTmml4EezO+FL8GprQe819p/Em0fxo2kKgt9n2U2m1W?=
 =?us-ascii?Q?3jv3yQyT2KbxLrfQbBcXz6Gx4yA1L6xKxjEUUTVn6XXs4q5NA62HINkYb2ow?=
 =?us-ascii?Q?hg2rSyEnMNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UuiQxMrba7CItG0e2R/FgbAxPzidzBORNY/XyxqLHBM7+bc7/Br06hhbqbOI?=
 =?us-ascii?Q?HeXixB42ltOh21YO7ajnR0eZNtyqOz7GI+73DhriC37Mj+2b/GWuvV8r2cUz?=
 =?us-ascii?Q?N116Uw/TWwuVT2V3JhrBpSyKanOng62aVq4rCxmLjhv//1I1ngG81/Z5I9gm?=
 =?us-ascii?Q?XqPUgFmdd8ie3JujZQZBDzNO9LDRjnSIQUqiLZKefaGHxW9XGfIbCYGSCC2h?=
 =?us-ascii?Q?MtsJtvs0/9jy7A/WPBhkt7PpLU1SayHC1vUgxbU9zc/DdiWH3NylwaIdKzYA?=
 =?us-ascii?Q?232960wAmZZEl+t3B67xgAhXN1HmYy+vUcEPXusmTgKKczY1M1dOSZd+qvlX?=
 =?us-ascii?Q?Ctz/nN4s5BkQ62BH27srW+18o/SmZVvpVK+MMog6KZCQQTbWkNDYG27k0afu?=
 =?us-ascii?Q?knlI6oByg2U1Q0RmgGzcdORLnBvQFKR6YoWoZ6G3yOSrvX7KDFkVvrNYqpEZ?=
 =?us-ascii?Q?DmFuDQg5OvUjs4Ajd572RHf6GBIF5BuG7wCRVZieOGfw6slL+DUb/Q+mGSzu?=
 =?us-ascii?Q?rxPurzRcyCbr4EYrvCyyb9NptKJZ1E4zJpKvCCyzuoJtjF8CsClhPaoUYEx6?=
 =?us-ascii?Q?gU5NXAjmui0DwJcavedxAXvyKEueiJH6ZiqSWBsOSn3qKhWJv6gexgJeEPHP?=
 =?us-ascii?Q?PUaaSmXjMNC2WGI6BXBktiIBD8XWIjvoBvQmuI5ht5X9Uui03KB7vuJUNMqj?=
 =?us-ascii?Q?08zs809ug/x9k4Ld17kUxwaoLPH1MGj+iXPXWUpETYG5ZNs7CqY/vSOqhUH5?=
 =?us-ascii?Q?XyOXE0RIBvjtq9sWgNWJDJbyu8vy3bpYCpeiDKcCbAuLccFvO5XfhJ4OcWYZ?=
 =?us-ascii?Q?cSL++JffJRerKh4aexUt9EeQYchdqbfBFbKkqdXPQ15fw6SLL+A8bHjGX+eX?=
 =?us-ascii?Q?hi8D1abhP7aHEzDP611SaJhtdrwCJDkHDmzJVpYok3/cxP0HeNBhDjqyIJWy?=
 =?us-ascii?Q?xaqB36byYhxne9UT0Pc/0IKG+3/UIHLCfroOjXJT//pp3xZtwav0r3+TsS7b?=
 =?us-ascii?Q?IJTV28Pb/P3xuDrvhSyVzEjP1wD0cXmo8d1E1/xAzx2kANj+z1BV9gfxcA18?=
 =?us-ascii?Q?2unrsVACWkIL6muPXBDw025DO2ztBDuTMNmQKKVJ49LGvDiHdRd0nbYbYxDI?=
 =?us-ascii?Q?j5/8tIySWqokzWgN5BzmmZ+EY8XzUd+kTsB999rqXm7J6i1J6Ffrjwb0xpAu?=
 =?us-ascii?Q?NiNULM4agvqiyyBb1E06YiqqdK0x5ygaWfXZN8r8UlK7xyu2WkfRzusKjh+c?=
 =?us-ascii?Q?GenqHp9kBuGPicfyMkQFiblRc6FJ8NvdJHNWK0M0oDhUv6cUA1BdlICXMBgq?=
 =?us-ascii?Q?1k1u8eIslQSs0AxEd78mtFEjI/msTvLuq3nV9y2D6QNGAZ1kl/1uFUqmxZej?=
 =?us-ascii?Q?EoLNzJQ2oYFBl+FfEuioqL9Rq+PfkI80jx3sLvaG91bJrZyT8KpYvyLP7kRh?=
 =?us-ascii?Q?epxX1hOprrK8w6NwT++PIz6lTgW06n3WK3p3PO1RmljORjMf5W37LNx/mmxO?=
 =?us-ascii?Q?+KcGqRabkTBKPh167xKvE2laoXZGfW2njyn1HtgQL2VjsX8V9LYRjy4RiwAs?=
 =?us-ascii?Q?VkBNcef8my2oUGRmSpoO2fcR87Km7lBTX2v6yBJn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5236ec27-6fe6-4581-eeb1-08dd7e939c06
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:00.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFfF7TzW7xZ2etGiILt14oMCXZKHTMUs3b8O0CrRYbaeMZjeDszxTzHxNCBrQ5gJlXquk+abjSBquYuqtPPVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

The torture.sh --do-rt command-line parameter is intended to mimic -rt
kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
mimicking more precise.

Note that testing of RCU priority boosting is disabled in favor
of forward-progress testing of RCU callbacks.  If it turns out to be
possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
testing of both, both will be enabled.

[ paulmck: Apply Sebastian Siewior feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0447c4a00cc4..d53ee1e0ffc7 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -448,13 +448,17 @@ fi
 
 if test "$do_rt" = "yes"
 then
-	# With all post-boot grace periods forced to normal.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_normal=1"
-	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	# In both runs, disable testing of RCU priority boosting because
+	# -rt doesn't like its interaction with testing of callback
+	# flooding.
+
+	# With all post-boot grace periods forced to normal (default for PREEMPT_RT).
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_IDLE=y" --trust-make
 
 	# With all post-boot grace periods forced to expedited.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_expedited=1"
-	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal_after_boot=0 rcupdate.rcu_expedited=1 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_FULL=y" --trust-make
 fi
 
 if test "$do_srcu_lockdep" = "yes"
-- 
2.43.0


