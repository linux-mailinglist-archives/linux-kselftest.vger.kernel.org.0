Return-Path: <linux-kselftest+bounces-47673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC696CC98AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAE63038280
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037BA2F7ABB;
	Wed, 17 Dec 2025 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UypBNaXO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E3212552;
	Wed, 17 Dec 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005348; cv=fail; b=GJOMNxrQgjRtAL7ogsNdguOcza30e07USXnaJLjwwPN74ggM1MMsI6dHSqy17wb71Rptbzdt45C1IPFvVVMDA0cBiFUQ9w5MzYpwRw/AtI628yC0NonvOmpXh2Wd3WMwVFnDx9H7mm1NNdWxkLTC3rDm/l8J6lVXyX+/w3L6sx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005348; c=relaxed/simple;
	bh=nDlYkvz4RD6i4v+tpwIvSAEpjrti/SpP4/VAQvfiqLo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eHP0/83rF3LMFBujUmhuMIm+7BKdM5z5ETnJY13E5KI2xDXqGF22H/KZMy/l4yCP5T225DlEVf6bJ6DD5+flIXiUQSEAmdeL0Chc9kmVzCCmTY3pBaCJvSA06BSr4EVWxNDT1mCsOwHJEv0RHvVFUoK9805XKU6zjAde7m4a4Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UypBNaXO; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EymZCNA0ieP8lh1yfp05teVDljH6/2rpmCeLG9lEvgnZ8lvRze6IkquGu6LldFOuI9SA2m9pEpbv2rXTHlbkj5pzeh9dcVzrTXpZirv96rOk7hgpFqkQVRi5ZC0f6Qt9fJvSaU4wLCXfobY6hXnE08nIBNsNWX9K+tyzjRe3y6V7SYJBjvY7nF+tPk3ikdPv/82RjOuqmxMWMtsFthC1mvVazs455WpYBkfYRWw7xLXMCSCsowFnuzGo90Pra2Qa/e0QDU747iuULaZNbx7kU6YJVjmbbc3d/1f/Dwh1qkgq4+paOPJD4Fj3pC356U9sRThZuu5HjPotGOUJ5RCTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1JpjV2egCE63o5jhY5jMFZpq7t1PE3pl66nHr5rfT8=;
 b=yyQDev/W3QstbTkIO1N0UWw7FCgLyYJYKZ6HWvlS/OT7KqWF0kIwnMFgbA7DE9ly7EPmG/OUIVSFp8LDXyZNEe3KC0K3FBUhB7VhYjlpoXQh+m2GbZzf7F12kCZU4RdQEf+yy+SzLYhc4xkQnEnIEBLrX8E2klW0LP6rePjlO9AKBy8buDb79X6m/cwR1fL8z+xiDOF7sZQG9t7QLxW7C9e0FnjaQqEOdSFb90EKTVP1HJrC4eeFAFmIuKt5x0yRLjW3WpNJmb2TnwrSPIp+nnhCMgxQTbfIcTESFz6sOmq/gDFgkE2E1C3FqvYlSdRmJnQjxG4MMawd8ZKtWpCcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1JpjV2egCE63o5jhY5jMFZpq7t1PE3pl66nHr5rfT8=;
 b=UypBNaXOvkwa4QGj+ukGHuA6rlFkw+ifpG+1ZrJdveJ8u6mE9LrbCyuoNkf30ThCYLyZFw5hDHOKpOciSWXUv0OHvgP2fsjmLAqh50JgE8W79KoFZnPuzfwtKbl3MhOc7mZBQiZfmvQzzx//yMHybnWktRLerO39/rcu3Ns0QJ9+HVmTV2bnC3quc1COgl1qghddFDLOOQUEfG0xU0hB0ghRGixk4xHhjoEGpht0b6MEZeT1Ag1GPmCILSHXYjQPZ3o3cvGSVOISw8SMOvyTZcsur9kc/du4J0uWT5VzL8lhv7gaek82dr/5uHV51rf/W2LYUgNyti6zQfD4LFqqvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:39:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:39:45 +0000
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
Subject: [PATCHSET v11 sched_ext/for-6.20] Add a deadline server for sched_ext tasks
Date: Wed, 17 Dec 2025 10:35:38 +0100
Message-ID: <20251217093923.1556187-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
 LV8PR12MB9620:EE_|DS0PR12MB6413:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee2cc93-f222-402b-88b3-08de3d503624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?MkDTa774Jjxq3sYPI6sMXJKamuE+rrf/YIZQUO+CPGxzVP6BQzspq4073dRg?=
 =?us-ascii?Q?Q/txP2ljvXnwC6eGDdQ27KBh5H/dFYZSXjA4jLBF+4eyk4nYbYa57/8g4nFa?=
 =?us-ascii?Q?mlvXmdIwfnPCm8jXgWiwzSKLOJrqqCaYWDnmVkXg+B5LdFWI1252WxH8lZYA?=
 =?us-ascii?Q?Jk+0EF2Y7mDd9Mn22V/Glj8AKWEPIJoILxDplMWL+XfSNAOFzz/+69AdSK4A?=
 =?us-ascii?Q?10zZJ7yTRqpEFVr9gt8xHfqsiNdBIZ9XcbKuqpetgYQNGw6DEx37+QRXxcsc?=
 =?us-ascii?Q?v7/MOQIWuq2LY0OMI2oJoLqOPZjZHvXtFCl43gO8E2xZgAXrh/1lR3dIr7iN?=
 =?us-ascii?Q?+FKYbJAA+m+LDZNL9cMo1wjANaGs0CLG7/vjWLYy7MBrq7GS3dYzoP3Qwmwq?=
 =?us-ascii?Q?H88cjiNRcK+rPGY07JEsqe/pb8u9TuSBPOezef3ygDymVUCz8yIUOtMfv/Rl?=
 =?us-ascii?Q?9ah8GN6gqfTpgx4074/LxoTGTzXJjZGJvcF0Ys57AcexFbXvsWOnf1yyV/87?=
 =?us-ascii?Q?iv+3+aGpw3Bfvk9rBg8Lk4zhzTNDQQceY8FcOmtDUIUytsxgFNjYOs78rKbk?=
 =?us-ascii?Q?ykDVJGYgAC1+gvnJC4DHmjntmrXBZKKwEQ4Mh69SZdCjGslViPBOA8sMK0Su?=
 =?us-ascii?Q?UXD/kLU5fMSgA/+VLWrwUUf0uLhRxRzgFXZqUyfJDSYqnjrvW/mczn1JBpNs?=
 =?us-ascii?Q?D5hX+64RoEHprNoyntzj732GGSA8R+9UiRf6ZTajwnQyXCd4JFY1T7dJqNZU?=
 =?us-ascii?Q?G7DshVvWe52PFQMg8b7m0JX3J/fYLcqnse8rXrGMy4FgVZXmvpEF1JomANFi?=
 =?us-ascii?Q?Dh2YaCNvsLx9Ohah4UEwJxPqS7rMVqFTzXE9NfKr0HFGgUKkTzbdyE1UxVOY?=
 =?us-ascii?Q?MbGSZbJUxgyUUBDzSm51IdEk+dL05RV3rFHoC8dqzlROy4zHKCJWOGmM/4fx?=
 =?us-ascii?Q?C/kRCfJ+cMVkp320VtDrNlbBDOzLKyfcqHZ73rC2jJISUEn4jpA3G7DBzesr?=
 =?us-ascii?Q?2gWraFmbaNJBDobyuc+kKdFU27KgN7ubEmPzvaIWXac3rEG+oKLrb3u7xt1a?=
 =?us-ascii?Q?McClzwdcrh8rBBmpnPT3Q5Do5fzs9cIn8jvHGqulrnJUrwjaxKLzu2pLB1Jk?=
 =?us-ascii?Q?Md+ZlSQ3W2sy+fGwfwNKzfbdbzT6fdMPbzL5UcSD3Pf2LisrQbvVZaW8jn18?=
 =?us-ascii?Q?yYL865ULvoKRGXTRPOMJk98jc7Zg4FBKf2GKjlmnKHoPt3XQ61GJeVAythTY?=
 =?us-ascii?Q?Wlbfo0nIf97Mc8TpIm9mIYgqNKK0cxHxfoN68phTUu+xxqUNbiAsxELttPle?=
 =?us-ascii?Q?mx3nO3bO2sSXy8Hf4Cp8wj7Wa3aRydqhlfgLQDZ1L707q5kq/onrB7P6WP+9?=
 =?us-ascii?Q?0U2oFP4MAnGzc7hiRDrBC+bzABQ6bXgAqp9gamMfvXoAVvDkBKRIIHwiXEOB?=
 =?us-ascii?Q?SryYUbhHJPClkbXYYq4Lum6AtAl3ciVeSLBOAl0X9xPFssJZEvekxw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?PAJ1oaj2Wz6/rL+kpBZ0x9thysN+kBE1e4M2yiPR4eqd0RI0Ucm+iogrrAWi?=
 =?us-ascii?Q?jpyJdnZNKN6HBQKCW7Ec0eG5QZJzsoNo6HCcUaOXgFFuoVz9Q9Qcn3UQH69t?=
 =?us-ascii?Q?a8Hpz619o0TRXvt62d0ioQoJPj9CkXGhN16S7uPrZQI0RGYitNuf9PKcFun5?=
 =?us-ascii?Q?Lt00aTnwz0HP1R6Gwk+ZnJ5vmJJ80PGQ+gGM3/TpTPIpACvCRbjZpeiBo5Zg?=
 =?us-ascii?Q?UOmrrmun5r9sj6WoFUQrRD3nA/Azb+Q4JWuLDa1q6nONXLW6a5EvTgJ9BPfm?=
 =?us-ascii?Q?YGY9VZRmc6Ap//J8Q82x+i/klBEflSok2v0DoHammuWRyFvGl2B9EotdqMhk?=
 =?us-ascii?Q?mPwTmbBvB/hJZffUoklfqrggFWyU9EVfjOO14Bm6WzQBjwedwFpKdwPQYBIL?=
 =?us-ascii?Q?Z5DvFPpUsVzKCJLa4ppMScpgJDpCzRoGCmfKXhaXhJX565w7b0D9yUJPC0eq?=
 =?us-ascii?Q?ICWgAZBCkuPsw0GfWYbTwWjMBuIN+6RRUQFoE3nVGN9Uj5tP8UqLf1TXVs0S?=
 =?us-ascii?Q?94v2uFjHNjv4IhiWCrpOFvZ3/zTyIp2QLzrxzNfsgfucM9hkRWWswnOwniEN?=
 =?us-ascii?Q?vHJSrTjAepsXYPABNt4ajmRR4uYo5b2LvWcZKbrqltlCmx5UW9nOu7BY4ed0?=
 =?us-ascii?Q?zz8j94TvHbVf/gvwj9cyRLVb1oMyTufDGTQMc35gOT7mqUxpttQyio3qQIAe?=
 =?us-ascii?Q?dDuHoLZX8Yck+6BB3K/jX/AIz76TCexlhcfA2VW95o/TWn4fRlUz1Z4uFGxJ?=
 =?us-ascii?Q?sY5x2TIOOmZTrqbcQFhzJRHmJyTQgFabPYw80d53/I453qCbsx+ydNzdezkW?=
 =?us-ascii?Q?MLkyVN5mzfVE88RJGvddWyO9IEQh02f+zMUhJKjkxApFmyB3dAoZJbPL0Dh4?=
 =?us-ascii?Q?D0yx91EdDWXGg+Sl2HPjXod/epqIjyXOxX8ac2XOUr3rco8yXbcFWzfwLmzj?=
 =?us-ascii?Q?YndZaf/noGh9oKh+wQraCpXh8HN3ZWtfWJHdF8VS9ojV9oCpIdGaMUX9kyIp?=
 =?us-ascii?Q?9rZaHONngNNCCz0wlelFbvT4JpMslpGj71z4INdVBf5cswD/fJ9q5pnXa3U8?=
 =?us-ascii?Q?uybUt2sdR1iJkHKCmKxt11MCIXRLHc99nr78YXh2vCR4eI+mgXudxQnyVx9z?=
 =?us-ascii?Q?PHguGiqzvCC7rG+99A2FHl5qnnCg5Mu9litcGYAC5V4lZqUTdfcwidJDivMN?=
 =?us-ascii?Q?Mvwj9UoMy3KOQpmYUJXdpM/P3FNq2sAYyk17+Mxo4WS1ATWKrew1nVtfY1Pa?=
 =?us-ascii?Q?jiRZhiZvN0fBAJRzq25v5Kanq+BW2gOFQCCbB/EqvYR11T5F84EwU34wIUme?=
 =?us-ascii?Q?nU7/xV040Ih0BC89HojjFd+knv8xeOzduiyRhPKSWMm8j7f1oWiH7nQgbLdu?=
 =?us-ascii?Q?vCosWMyBlq1/8Et9A15eujeb71u2DJgcrcuxECVve+h+fv1Apz63WANFE4GR?=
 =?us-ascii?Q?MTRY2YbXw6c0EE3RvIYuGPKX0yL2DHHvSWuEZ3gDjJ/rpjH5uSQntwX6b6gS?=
 =?us-ascii?Q?vLAVqSywaooupcdQBxuLw8sddiS5zW1+ybSp1/JEsfGAQ3ghl30v80IckAN2?=
 =?us-ascii?Q?jb8sr3b4+R7NyVqQg6gFA58RKUzX1KF77elmmpt9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee2cc93-f222-402b-88b3-08de3d503624
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:39:45.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnNjDBKNP/XZjmumfI86/r5LLdl/PwvTcZchjP8rWo0iGToEOLSS4PiyvaCX4x72WdsZB0G9a8wstwhAiYKLGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-OriginatorOrg: Nvidia.com

sched_ext tasks can be starved by long-running RT tasks, especially since
RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
tasks.

Several users in the community have reported issues with RT stalling
sched_ext tasks. This is fairly common on distributions or environments
where applications like video compositors, audio services, etc. run as RT
tasks by default.

Example trace (showing a per-CPU kthread stalled due to the sway Wayland
compositor running as an RT task):

 runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
 ...
 CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
           curr=sway[994] class=rt_sched_class
   R kworker/0:0[106377] -5043ms
       scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
       sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
       cpus=01

This is often perceived as a bug in the BPF schedulers, but in reality they
can't do much: RT tasks run outside their control and can potentially
consume 100% of the CPU bandwidth.

Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
also boosted and do not suffer starvation.

Two kselftests are also provided to verify the starvation fixes and
bandwidth allocation is correct.

== Design ==

 - The EXT server is initialized at boot time and remains configured
   throughout the system's lifetime
 - It starts automatically when the first sched_ext task is enqueued
   (rq->scx.nr_running == 1)
 - The server's pick function (ext_server_pick_task) always selects
   sched_ext tasks when active
 - Runtime accounting happens in update_curr_scx() during task execution
   and update_curr_idle() when idle
 - Bandwidth accounting includes both fair and ext servers in root domain
   calculations
 - A debugfs interface (/sys/kernel/debug/sched/ext_server/) allows runtime
   tuning of server parameters

== Highlights in this version ==

As discussed at the sched_ext microconference at LPC Tokyo, the plan is to
start with a simpler approach, avoiding automatically creating or tearing
down the EXT server bandwidth reservation when a BPF scheduler is loaded or
unloaded. Instead, the reservation is kept permanently active. This
significantly simplifies the logic while still addressing the starvation
issue.

Any fine-tuning of the bandwidth reservation is delegated to the system
administrator, who can adjust it via the debugfs interface. In the future,
a more suitable interface can be introduced and automatic removal of the
reservation when the BPF scheduler is unloaded can be revisited.

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server

Changes in v11:
 - do not create/remove the bandwidth reservation for the ext server when a
   BPF scheduler is loaded/unloaded, but keep the reservation bandwdith
   always active
 - change rt_stall kselftest to validate both FAIR and EXT DL servers
 - Link to v10: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v10:
 - reordered patches to better isolate sched_ext changes vs sched/deadline
   changes (Andrea Righi)
 - define ext_server only with CONFIG_SCHED_CLASS_EXT=y (Andrea Righi)
 - add WARN_ON_ONCE(!cpus) check in dl_server_apply_params() (Andrea Righi)
 - wait for inactive_task_timer to fire before removing the bandwidth
   reservation (Juri Lelli)
 - remove explicit dl_server_stop() in dequeue_task_scx() to reduce timer
   reprogramming overhead (Juri Lelli)
 - do not restart pick_task() when invoked by the dl_server (Tejun Heo)
 - rename rq_dl_server to dl_server (Peter Zijlstra)
 - fixed a missing dl_server start in dl_server_on() (Christian Loehle)
 - add a comment to the rt_stall selftest to better explain the 4%
   threshold (Emil Tsalapatis)
 - Link to v9: https://lore.kernel.org/all/20251017093214.70029-1-arighi@nvidia.com/

Changes in v9:
 - Drop the ->balance() logic as its functionality is now integrated into
   ->pick_task(), allowing dl_server to call pick_task_scx() directly
 - Link to v8: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v8:
 - Add tj's patch to de-couple balance and pick_task and avoid changing
   sched/core callbacks to propagate @rf
 - Simplify dl_se->dl_server check (suggested by PeterZ)
 - Small coding style fixes in the kselftests
 - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/

Changes in v7:
 - Rebased to Linus master
 - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Changes in v6:
 - Added Acks to few patches
 - Fixes to few nits suggested by Tejun
 - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Changes in v5:
 - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs
 - Address comment from Andrea about redundant rq clock invalidation
 - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Changes in v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX
 - Fixed other issues
 - Rebased on Linus master
 - All sched_ext kselftests reliably pass now, also verified that the
   total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
 - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/

Changes in v3:
 - Removed code duplication in debugfs. Made ext interface separate
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
 - Fixed running bw accounting issue in dl_server_remove_params
 - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
 - Added support to remove BW of DL servers when they are switched to/from EXT
 - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Andrea Righi (2):
      sched_ext: Add a DL server for sched_ext tasks
      selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (5):
      sched/deadline: Clear the defer params
      sched/debug: Fix updating of ppos on server write ops
      sched/debug: Stop and start server based on if it was active
      sched/debug: Add support to change sched_ext server params
      selftests/sched_ext: Add test for DL server total_bw consistency

 kernel/sched/core.c                              |   6 +
 kernel/sched/deadline.c                          |  87 +++++--
 kernel/sched/debug.c                             | 171 +++++++++++---
 kernel/sched/ext.c                               |  42 ++++
 kernel/sched/idle.c                              |   3 +
 kernel/sched/sched.h                             |   2 +
 kernel/sched/topology.c                          |   5 +
 tools/testing/selftests/sched_ext/Makefile       |   2 +
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c     | 240 +++++++++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
 11 files changed, 811 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

