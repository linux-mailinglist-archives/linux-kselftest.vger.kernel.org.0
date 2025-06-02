Return-Path: <linux-kselftest+bounces-34147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19417ACBAAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DF43BD949
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0CE22FDEA;
	Mon,  2 Jun 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWBf4eAU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08222F755;
	Mon,  2 Jun 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887314; cv=fail; b=U1KoNJRu+VwXEljRMdPZtEIW5ebqSxm+533274QnRXF4WFU3CQqX7rO3AIvUEQwkzt0YeqkKWbGapAbqXL8yjDmntjtZNnqiIVZjVsAfwUHD2WjNi24N3/XwwjD02ADZ54J1vxZp2lx1BFkNNwY7s9cpDgU2LaLfjifI/EeUcZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887314; c=relaxed/simple;
	bh=h/dYtAzGMpJpI2fkQB5FfaOBvdODCcvUrhYwOO8B91I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAlYn4HwBlJwMVrKnAHzgoAv8vk+PsXS05mK2PAJWqxikd2fi6Iil+BC4kDo+qVgQnERNHLJ8b25ql/kQNBzTvJn+tv356nWzOzAiOaPOYDzmAbfRQR/tPZGTpYN7j0au+0dP8QIPNwESOR7wBqS7JkMFoXGcV1jWWTLiqMbehU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWBf4eAU; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB3tmw2meeCN9voQYhbWVr4wJUseYY4yKdtIUYDIzIiTDn1Ane3VVMvuHRf4OinCMRO+zLLrtwJci1NeEy1LyXozoqPKKJzRaWfVzmIaaOnRo2yxNO3fp9ZBTzDXblhjwzOJ7Tu+e8PJzyr6XrQinefujO1jPltySdczFoep0RCe1yBSarT0X3fQymF3QuFq44+7zGE2NH62Bu3NwTs/jLfMU6k6PtbRrJnU0DhKWad2ja2HkYaA0V1k/9+M4f9402Z4PihcsnNlgh95l5vKVzzDkwyeGcCoX3qwIXm/MxPQCRiVY0UwZIiIbA41HcdWBgBXbusMyPsDlVUO/7NiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+/dm9w8kwUVVC4cO6zZcS5QI5MhHptWL6AVLdlYUBk=;
 b=RU2+MHHpLWL/v+FbxMFlhySLMOa48UQjA8br51qzNcBrNEKe6WuSGJCcxDuP6D5/UWlGYE1qStbtaajk2QSNQMfA2AMDaAkl3gy4p/k8Ay8T4GCkaFAzjVVch2pxbA0lRv1CZnkHnAcTdsbwZLI5XdAq+MJg4hWCobg88CWDMitrotfORzmqDSsQlTgCh9z+HzaO+EdSfB8TwvmUZq20BEkK/+PQkUVG5atH6IMwfJ1DbL0MJfV83ZyyRf6PXEB2XRvyswmMQYjFmqLUwpo6egLvxSBBI+lvztC57E+Hf9E43+fMOKNxjzUFe3g6VL0LrQc/YUhSCjnNk3LLQDc0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+/dm9w8kwUVVC4cO6zZcS5QI5MhHptWL6AVLdlYUBk=;
 b=qWBf4eAU4orHOky2zx7U/pRYnIZ0W8boVAVRZHwGbRbHrQjaATYaI4HoEaKLdasOIeN5edUA0yTXT40foixU45pNgli26cDsAQcYiHhh80eKo+STjhQZ2ErFEItnSvjAQOuELR+7MRe+z5095AgRrCErJ4ES9Ip7LTRAEWZdDH8l+jDhIZVWXySZ3Fh2UBY58f48jh8+iX9DwcNu4eFOZHFijZGOudQi70qHooKE9HtcuoCEoforlHOxp9/8p0UcxN+ouV6iWwpINdsvs0y8ZkNqaZFnsKGKMb7g/KgBANluTQfkpgPsRGpG73LV7lJRmR8TM1NMaMXKOJcfaZKenA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 18:01:46 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 18:01:46 +0000
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
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 10/10] selftests/sched_ext: Add test for sched_ext dl_server
Date: Mon,  2 Jun 2025 14:01:06 -0400
Message-ID: <20250602180110.816225-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602180110.816225-1-joelagnelf@nvidia.com>
References: <20250602180110.816225-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbd63aa-95d3-4d35-f0a1-08dda1ff8a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27y+hsLgd5kHJN/Wjsvii1LKE2DI9DzuZxOTSp8YaHIweZhBn74DMoBvNE8D?=
 =?us-ascii?Q?CMhbQu1im6u8NUw/vRrd3f6Y0ZUuakWK+8Wkxi23EOJCh3hG9+7YgO1T9rP6?=
 =?us-ascii?Q?YV1YNf4vp+jXvJORvjYXx8IzxFi1Z5mE3OfZFPIu7fonfuOuzNcmqZP3LZuF?=
 =?us-ascii?Q?ydVI/KC+LRCS5U3tM6NXaj1J7mByX73j8fiXFg/hPpTvdn905+S+REklAH9b?=
 =?us-ascii?Q?9vM/h3IGuLIG9X6bPYdjB1AN91hBcM1rKnJjXbcCmrUaKTckZjk3fJ2SiSUL?=
 =?us-ascii?Q?Q5vK1vvH8BwvYjPZ8CywHJUPee2S845jkmGUY7MjxoS+5toteTfhQBrPNabT?=
 =?us-ascii?Q?EdeOeDrURHG0XDGs0zktfX81ew3JwkPq2+nT8IAWCouXz0eePKBO7ir++wX0?=
 =?us-ascii?Q?ETyguw4Qt2KojGmIkIXwP5eW/PQlp6e+8eo6Cb+glypUecrTbS3ZA2fw0bx+?=
 =?us-ascii?Q?YzSkpb6rk7bEQ8RKu5PvTNi7bw6pwjzFI+o7rSyWN/RjFmIT0yVWygPGxCAJ?=
 =?us-ascii?Q?AO74q+wwP6EshfjaAebqrafU3SXSHjwQF7n2ohO6ePdY5VtWYPafiWiOj/Ym?=
 =?us-ascii?Q?DwqaifdAmFJAyTUw2755Koe8j5U1SpJFR1BgGH2uMnGoU/suD+rWksr6KA/A?=
 =?us-ascii?Q?hRZbh8opLTcI3x4qKpmFWXpUxucxr/PhIwdf5SA7U+ketTVLQw0ZCbgV9fZV?=
 =?us-ascii?Q?DDsdfnwPzHMZzeAJ+gXmRnuDeTWEEoax/tEP8CTo8Rq+mYkEk6RkZEZD8TkX?=
 =?us-ascii?Q?Jq+HcnXrp24qAHH5ahMgi11aKzAqyhLtdXk6YIgIQ1lfGbNKNIArqVy9IwSG?=
 =?us-ascii?Q?3w+hvj0nMQYSiNxKSPyG3q0khZxMoDX3ScMO8ukzdKMBnYts3nkJOWYmgXUq?=
 =?us-ascii?Q?pJDSQaxgtUWyKFf0juQSa2NzWdDUghza5Ku6AYU9C9kmeMIm2PAy7w1VoDgB?=
 =?us-ascii?Q?FVvljsmTRG/fl6BGwyzGb1JYbkAEiinIMqvbC6l/h3fyFGrSSO8EnL6u9Gjl?=
 =?us-ascii?Q?ITE0ybrKg6CKE0T7i/+0xxPS/HtAiekAgKWN/Vtjo3XtLo8ifl02VIBg+uyU?=
 =?us-ascii?Q?1KyApx1+thtFy1zJTEkOAJBcBTUhC5V7+D4HFkTVtckcgNhO9lmiQf2/SNaV?=
 =?us-ascii?Q?2PIqyFfnJZwMzW9bVtj7zXixJDgYDf/YVWz7CtD8nZhBZrjnzF5PdPeF11/Z?=
 =?us-ascii?Q?QvE26aOFKKNcsW7SjBxSJbT8nvnmq25Kdu0P0/pC1QM07Ru2qORWhHOFbNzy?=
 =?us-ascii?Q?39k+leZn9Ob3irRyV0SDUPB8S3IkHSX7mKA4bmuoUJzNaSNPkBNk29R5GxPO?=
 =?us-ascii?Q?9p1hwAcNbKAUzZ1GJrSWvp1HyGmDjn0H1pjpNOvpQ2FjI/ulRpT25glLhdRH?=
 =?us-ascii?Q?X4OUAxwbatXAzBFnzk/18mRDNMdFwjlJ58e6dhm8PzcwjgKD9zQ5MImaxSa/?=
 =?us-ascii?Q?exiYNPF/0io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d10pfpaMsH8MUrUUA5m8F2o3km22h/oa1IVcLJtdH2JjfTBDaMAP32A+EmU0?=
 =?us-ascii?Q?0SjzalzHPYaALWWSeFWuI+9FgO2twgyPf1fmltgrMMvYJUog7VzuqUMJrBZ9?=
 =?us-ascii?Q?j2ztRiMEGM0yUSZtiIUbsXjFbQuJl6AlJ8tFurBLAIxhr2jJzuyAw4m105QI?=
 =?us-ascii?Q?2RpLO66jeR36Gvp1mxBidgt0PlCkt1sUzCvpaZRVN2cAN3yCvZSLPKFY4eqL?=
 =?us-ascii?Q?TtrbPk5HnOAll0Nt1LAuVw52ELWh9fCos6T34xF2MDkOF1yfn9Ff5vcm4FyW?=
 =?us-ascii?Q?E5rQczu9SAOSQBBijN8rHcf1g/KuHyIbZJORHeAE9UQj18LrS/ZU+YwJeyRR?=
 =?us-ascii?Q?GhJRnzaivv/mQzwpk7qRIrRI5XqSOa0AupvYs24XElxXtiJaULRSeeXu+Zki?=
 =?us-ascii?Q?Ppg0T6MNyIOrFVmElpqH4ggheXpafZdzvrdwOyk+kXHA9rt0QhvWA8tjLN0H?=
 =?us-ascii?Q?3lnCuKMOUn1UFI61LNHniZIfXcX7R322SWBCyPxHtT6LDTeYqlPDu7WP6EFI?=
 =?us-ascii?Q?HeKb02Sx1cUf4Y13uNOe57SrDiat6Ipx0sG2XBtY8CkHymkD6ZmJN44I22Hh?=
 =?us-ascii?Q?Ui3+cuP6DRDtTPRcRTStHIfS0gslLPO0rdvqHy5WXId+ErdewCv42zIVZlGq?=
 =?us-ascii?Q?XHM8tYm6vbxQtt/lefMsUAEnz2qnDq1V5R2ByNc3/ayb1Ux/tIoak8aFYlMm?=
 =?us-ascii?Q?FcXDXBV0/jIMs86PdUea+ClnjfkDW8xXG5lz+4xgJPj3OIDLXfH7slWzrRti?=
 =?us-ascii?Q?uDtYTjuqDW0VeFVQnZi8VlwvtMsmpmrtRGklPH7H1Yv3cnoYtlN3gYtyOca/?=
 =?us-ascii?Q?7hfzQD/kdqj5a5LKL575MwyIiceKEl8cDrvYdHXOzKSeAcHyykcYJQa1JeDH?=
 =?us-ascii?Q?6CRyIjkZKEVRZzG+VSifJZO8LQzBlmpAttXQZnhezbCSg6r15dY1kSvaPzNe?=
 =?us-ascii?Q?ToTpICsn3GAouyvvYE3SlF64FD5DkCGxT/PFkakVtLbc84I4AEKHwXSUe1oi?=
 =?us-ascii?Q?Vn+Ubnjom7D1eHLUW5xhExXFHowT4UI/iBTs7Ll5DF1B65rV1Jc3S17WTNED?=
 =?us-ascii?Q?8uoo7DBt0+3AlUS29S2r+Ol7Bg28SPRtAZS+xCeSCzw/NQ6sGaQDobDNI0xC?=
 =?us-ascii?Q?78nTaV8iQU14Z++KLyKZ6QZiWoj+fIp1INe7Hd1Rn58yh9nf4PNFEJay8Z2+?=
 =?us-ascii?Q?bvMXeHaHy7Uq729UVL0J4rtGlrJxJE+QjGX75vAIv7u32ejqAwumM8jH9bjl?=
 =?us-ascii?Q?Kx/vhI8ZBJSFPbdlZHLQ3t1C6y1JFNW4rJsM89doTZpXj6jaZwGYkax8z9KB?=
 =?us-ascii?Q?Ztu5/T1TcJUgUC247/V5XfrmlFFatYP1pT3KprOUtp0GkJ6Bj4s8LyR/4xH6?=
 =?us-ascii?Q?H2jYP4Qz6D582diVp9FYzHm3cHxcnJugfDJnGzVwsmz9EvpP9KSq2fPqrqiP?=
 =?us-ascii?Q?1+zX4fyJHB2gzucnL02+un3U6EFsOhXh3oT4CqXEGBlhs8sv6FoXJ3n8kkyW?=
 =?us-ascii?Q?x0g8p2QQ6CPYCE+NpJsESLMSndIpecQ8Csbjx2ISRmV8Eyx6SAlMY6W5jrwK?=
 =?us-ascii?Q?5O7Xbk6MEVJTiwKXwxCxiImp2HaO4FipeTwQJRNF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbd63aa-95d3-4d35-f0a1-08dda1ff8a3e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 18:01:46.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MapGpryAMD1QORDdx35Yk3J60UFrho0thP+wMuBBhdTGKkMe41n2yzfJQQVblCME+vWe4dXVKFy7eqosFozrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

From: Andrea Righi <arighi@nvidia.com>

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

[ Joel: Replaced occurences of CFS in the test with EXT. ]

Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f4531327b8e7..dcc803eeab39 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -181,6 +181,7 @@ auto-test-targets :=			\
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


