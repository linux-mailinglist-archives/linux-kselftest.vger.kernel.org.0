Return-Path: <linux-kselftest+bounces-47676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB667CC9AEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 23:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98480303272A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EA2EBBB3;
	Wed, 17 Dec 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZ8Xss+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300529BD8C;
	Wed, 17 Dec 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010026; cv=fail; b=H6AwM9flRB/WD6WonVRFF/PDM19YWQjCalu9DKuCYlV5qQijEPZhmHgMVi9qP7TEnXZ3kKjeA9RFIBe+xkFxXbq1tMOgBCDcf5esRREDjLPJG4RISMuoMP5f8szuVK1DjQqDKsjUB02cmfQji/zJHdindu0upS7kId0hcJo10bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010026; c=relaxed/simple;
	bh=6vEr4bzHlEuAwz+cLeabtpEu6Lzl3CdGEZYrw23GhgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBdFd7D9vG07dEzqEgCSaPG6ze83j2Wx04dWY6E+Hz1HauU19OzgEtJYvPIkeA0n5hTVrtLHmWh9+a3UHNrDR1SJ4VzEXezrLT0c1RhxaXc10bimmoYLsuECPrHEwvEQmnt5DKcEeC4Y4+/W7Q9mHELJDCk/pjFTW8X94geQNvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZ8Xss+w; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvRhqhcz1b+bckX/KCaY2cDwTIs6t9AXtWudIdN3nN0Q0wkmV3zg6Qe/J4KsPBJymtSWd/i0ZbjJtgSv37NMnQAoKKXDNe4CEnqLtNc6k7edlbXgTotOako6JTSn6TGWizakGJj8kIPqDCUmEGLp0osJ3l85zrbwjZBH9WXr1qgUItNmDAPy9bp9YOfcMupv9vBBnx/wjGrthE6CUiq/oNoIfdsixI9VLDCaxwZUGc0M0DlM2DN0KiVdlWNOrNfpiCTun+4zCEVpK0aZCd3IJtG9ynUMdrYsfULqLhyGmF1W3V82xYKkzhhvZHcnYgCODYZL61quKVgpJRnQfOPSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLvZQJrN9sti6NuWnv7l4mZawbEJKPCb+dPs/H22E9c=;
 b=QPLw2utJ+w7Q8Edolh87oMFYfgGui3xJ7i4+fKIz8kf0Ig7FUaaegDYp6AHLJP6Yce65N6fKpoK2oHeeZyKwH7TT1IyOKJXhBp1py9/+F2dWmro97nEB/rnkkEk44D/64yqSaZpi/1g4+dj1v80w9RtBwQ1xFKinZcqPZ1cvS2N25hb5ZWZVFRAFpZ4SqQK7tLwxqWlKlucLlfUpQk9jLLvrIdhVKC133RXvylWkWSfqljpUl2TEBLjm7HD5H/9ThGU0e0ro6zltPJAUW6F56qqZZnyNSEuzp5PerCmM0tekzvmAH7qNW+YiMsV0HYtriO0VEqv7YqZYLSEY3qzIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLvZQJrN9sti6NuWnv7l4mZawbEJKPCb+dPs/H22E9c=;
 b=CZ8Xss+w3X/tOxfRhLCvofy3i9SJlxJu8d2ZcwkHeP4aFl3Mb2Vm7d7IFKBuDldEAhi5SP/VB7vMI1Cj03XADvpGTAcsWM7BZNJdxvKmNvw95j3W+eiDFPwc0eMy4J7XP58MDx55w0su2rHdVPaNKJQtt9UVM/ILag+PMEpMKILToWOElgdqZkz5fAZbSJu6tR939yLxWbeNms/+vmeyhGF6jghnO7uEzV4ksuX20cWDnYxQzigAi9iTd/6IGOnBoRTbraILk6FvHu3cB8skT/wGr3Vw5j3w10JCrF5W4SySmwcl09vzWTgcSHJpBn5pfBiuaLvLMEwVsyDE/ke5iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:39:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:39:51 +0000
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
Subject: [PATCH 2/7] sched/debug: Fix updating of ppos on server write ops
Date: Wed, 17 Dec 2025 10:35:40 +0100
Message-ID: <20251217093923.1556187-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f388b9a5-5d52-46a9-6150-08de3d503a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?iGhpDIcK2BCyvXnScx4GmWGFJnv/pK85umkNTD43xj+TrZOH3uy5CmVa93gB?=
 =?us-ascii?Q?TdlD+533AqPtNQWN+pT2sclDFClBPvJLbRVLkkFEvPdpuxUkznC/1jxc+eJS?=
 =?us-ascii?Q?2Q7QVMhzgAEa7lH4BmfV/eQpAhqTn/PpixQ8Dk++CR0MaImnYCghV7D2XIw9?=
 =?us-ascii?Q?1ii6SJrFKc0Dp7oHmrhUtCntMJYJItGeIwM+/BruKIAxCE1LMCauY8SUi5bU?=
 =?us-ascii?Q?w6I1Aq9kOyQcziTNptEoF0Nw5mNB0AHsSi5aY9MxGvIC9bTSAn/g+edZOfOU?=
 =?us-ascii?Q?b7u8gdwqVaSo66LPGpS/dlwm8cxNpVkrL3Q6iaI5HbXaaL4xyFhF/x30yf9A?=
 =?us-ascii?Q?b1KMumhosA+CHDWch4klB0BLJqP2sq4hDOxcCVIl5P5aQCox/CIjE8/sbwCO?=
 =?us-ascii?Q?z8qeWE9SAhvtuqkJ/50FJ/s410OXwR0N/7nMKYF1XB1IhWqeyj3QQ1a7oV7Y?=
 =?us-ascii?Q?aPqibjaGIxl2K1g0wJ1cGStDqSOYWfGHTlf35ca0Vp79M6jufEfHvGFQO8aG?=
 =?us-ascii?Q?CJxhojk8cT7ZLaKdyHs9ClXNnbRTjh+BfImo1RQUSYirX5ZwObjA2setMDiA?=
 =?us-ascii?Q?zdV53LGD/kg2XTPoqZTrCRSpo8uWzv1lfmWJHPhwu8fhvTPcHGEQprBpQ/ih?=
 =?us-ascii?Q?bCdxjL9OusAoVI/lVQ79QRWXDasG3mspXeD8qyYme3l6ZtRMH+CsJlICmJHO?=
 =?us-ascii?Q?PddnsHulGvErJMDB14ib2n8JBbQ69rLteBdevnQ5z2HL0bf3/h9XTDhNKRaf?=
 =?us-ascii?Q?P8dhEguRQnrg2zKCHWvG3JNzB2ElKTPzE6ZNaMsJeLbKDgzeUQHd3BSzRo4u?=
 =?us-ascii?Q?ZZCqMqmqsiN8I9Q3ArdPqvXG6520Gvr5bp08MRJOfXr9WQuUjWkECHHXrVEI?=
 =?us-ascii?Q?5jnosKfkRdWV11CvbxyGfCcKfVjQNLSQfayAWKxvQlvfO8R7+UOnop6YQwXw?=
 =?us-ascii?Q?CpBLRWF60iTy8nHN3EkLTlRIZxi+0hP8O2KC3bL1SmqVDLztrOQDGUyfdabN?=
 =?us-ascii?Q?RkVr4v7uEdMsj3clW1Bpj7k5R7DQcVhGCGWremHHqSmQGeY0hKb+pDxQxgj/?=
 =?us-ascii?Q?LH0jf5ixeyexPESAUF9ERBTNwEfZFzRkrva9uhgZ8cJc9OqL37Q7JtTjQ86w?=
 =?us-ascii?Q?xxP9fH9VzqfMjfQgW2dIOJtvE0KfjOOhuhWqj6KfXZ+E1gcRuGIkxy3BQlcJ?=
 =?us-ascii?Q?ibb8Z0bo72OHi0HkdrdSBi/7MA1wieH1980i0nY0sIRuVdRYvjQ4hEn8OY68?=
 =?us-ascii?Q?2hcMjYsf2FYfd9stqckxnO+vIt3cofA1DSFLuj/RL9OyewlN/SBJ6eOJDKjj?=
 =?us-ascii?Q?qKxY3AP3lPQ+Mb5kmaNOyGOkn3P7yC2j+3IACfuEmI3+L8oYNeCZ+TXsjhMB?=
 =?us-ascii?Q?WYj4Qozqc78w9c9E54fJayGhbwWdkiuKZu84xvrNOhgnl6V+I2dPi1kJR5j3?=
 =?us-ascii?Q?Lt281cYzyguiNiU0r4WXDJ3FzNv9F9xe?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?7ClGSgpgAAyBZsAO3mJssVK4goXEdGTyp7R6HleAVWQpRDo5+xP8n5K6fuI4?=
 =?us-ascii?Q?iYGCaGsE0lVdFkX8LLAd6LyRt9BQQri/Y5YgkBoAHl4sNxJr6ng0nOyhwhY9?=
 =?us-ascii?Q?MU0q7BAs8JHr/MjK90ErIwzYhAyWcOfaUbMH4KIys73heMPHk+ly4sqDVBiY?=
 =?us-ascii?Q?sj7M5D+qbb39g8F9W/Pfg/RzUlnQ9HEm0UowNu00yg4MkpdF6W1lttdf/Ogl?=
 =?us-ascii?Q?wpCUJ55jDvXW8Q/W1GSE2V59SqjF86AOJ9wLCXSBUZve9RguqpiHbeQrzYww?=
 =?us-ascii?Q?2+pv1mGBROocBAqoFzB5pI7TKllX/oyERd5FLb/7VdzHqqAFouBH8UUBcI+w?=
 =?us-ascii?Q?+eLEYJ62qc1SB+FdAFtBBmF74FoWwZUeWc87yrjMqGVXVyzxthc3p+jNmqaA?=
 =?us-ascii?Q?AhWlahUgRBYotjXdjwtPSeN5UncYcbioUsBm274TR9k91dc7HpPbqniBYrev?=
 =?us-ascii?Q?hCnyBkqfcM84OB1AXnkDkRczWpMLTlPNCeRWBeE/J9nMHNba+agIocPlwS71?=
 =?us-ascii?Q?VYobLl7uVq5Mrp5kr8rOvzFwDNW2oFmbO3fn28DsmsWmHbSSNXP40Apd/TWN?=
 =?us-ascii?Q?4BwRWhyGec27j++xPMWsCD5bwGSdyUcMYa4p2uQQ7fiwvrb8SkjKzr6ZnaSX?=
 =?us-ascii?Q?A5IW28zgSnqMditeNvdoXDC2zdrXM9mRDiuicISjoG//Ls2B4LmepkKbLoWh?=
 =?us-ascii?Q?V1+V085Vu2JCoF1n0etfA827lUmb2ZB8KCGa/4uq4QzvPaRqH+bdRVcOnybQ?=
 =?us-ascii?Q?++PFf5Z6eF911GQndUXqggrg8YosKBcMMCMxjOpYaE1+jhJH+041wp0Ysa35?=
 =?us-ascii?Q?7Bk5G3sZOD47B794CqSkX/yly9MrIcIRdSd7NWHod7wpGkL2owmR6Of7GJ9/?=
 =?us-ascii?Q?4cwq7jH157gDDiISL3mGUkiJj0D4FvlJjiznodtXWOp1HtHkFEl6jWUyIPjb?=
 =?us-ascii?Q?kMjVO+G6BSdh83uv9kXr+xI3L7Q3+j69BmLBB2Qhz3gQrIPrSlC04rZNXAEG?=
 =?us-ascii?Q?ogKG2O1bnX8T+IlGRXgknv3pgMKtKhtVfg8ULR/vCmGO2rtbu4g1Fj5xhk+I?=
 =?us-ascii?Q?VscDJitNNQOeOsZaKQ12UU45Qcgo/XbADSRlYp5R+ONTopZfGdKfkB1AEKEX?=
 =?us-ascii?Q?u+QAHBZfcjEfBRjd8vfyA0OV+wzr8U9NeZ+Vm7k0usXUMCMa8WwiY/dJkM0p?=
 =?us-ascii?Q?iCnLzz34rIRUrITfXsRBn9OvW1Sol9KsGNiCNehiVbBZ02MJI7PfWQ1rcJAd?=
 =?us-ascii?Q?JP72N87Vv/hGFs8lOafUDsU1oKPe85wnFw00X4YTkaJM3gWqNLiDu+SLmLJa?=
 =?us-ascii?Q?1cb62Djryri4lEYxkxoHEuzuga5m3zcXZg4cqny2rmWG+f7VzpeFwJaPMDut?=
 =?us-ascii?Q?+IfgMlaSHhC1bmI9xuFJ4CUwb26lMJm4MyyCa8OF/5PrO02otZC0QoFRp2Wq?=
 =?us-ascii?Q?PqS1xzAjvN/UKbjaUjNm898U8it/MFG+RWJGzSi22tdfUBpOWc1jw998UeFY?=
 =?us-ascii?Q?pRX0FxsUmGFe0jfmaGRq2mkjlKpVPdsn48qBk6GPt4/jX/k1Ye5MQmsNRlkG?=
 =?us-ascii?Q?k0aIFiNHFVHTEqI5EuHDFKuouW5Sh6Ukwp+Wz0Cg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f388b9a5-5d52-46a9-6150-08de3d503a39
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:39:51.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtPhVWE90WMwQJRSbX2eBa6l1S5wHv3TQhiuetj7rc+uYrMNnGnn502M2rj64ZXikNJjyvdN9ulyJjVK0V6EoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-OriginatorOrg: Nvidia.com

From: Joel Fernandes <joelagnelf@nvidia.com>

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 41caa22e0680a..93f009e1076d8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -380,8 +380,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -389,6 +387,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.52.0


