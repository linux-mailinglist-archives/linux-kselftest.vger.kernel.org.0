Return-Path: <linux-kselftest+bounces-47671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BFDCC942E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 19:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04DD93065863
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD1288C08;
	Wed, 17 Dec 2025 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CsWS9fmh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766C285C8E;
	Wed, 17 Dec 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995326; cv=fail; b=nUXV4WeYhE5lq1tlRlP95XOTzWl91GPG8uX8imHIbQ6XkH5AIwMK+Hkpnz3cTRw2kD87UXDgYLuRmrM6ZXkMw/SYhGb3PNs2GpzxU2C9k8wWCHfj/vZI8YnSb2n95Gl43BvVSaFcbyrSWRU4cQgyYdoW74EzLXMAtMrBCg6EE98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995326; c=relaxed/simple;
	bh=xghJRTY6N9M0NP96scSJQVKWYwgDsZPL9aLpvTMn0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwAb/hcf3sy0k/qYBa8hetCFFY03gzBiVu4zrZYZPVaaWU2Ml4/SpHth2T9jUl5oFZvgQ0V8vRD/38utRbI49kUZcqD0YaO9kgh2GyaAF0vkP60zNwD3ybldVwYMaQLlE2EbJXyWJbpCYXp6bhUjZrnula+E0g3nDh2qWldurMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CsWS9fmh; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWlD/lws3HkoFd768sWio0/IbFLhjxWbhOcN9Z1FMTFQQSzvV/b6CzkujBQRjzI6QEhkfARSCGNr9ACuBFwe1evNWfMZX2ptYP2D2BlB5oRAT4IHsWc0x3+SZyodg3Ds6aIeMJMMeSxEbNcPQxNUqhffj0ceJ1I9Z0EfYIPAtk7IqTY9bA2hEC6LAyQXNb1lFnaGKZU96SGuuVjtI6aiMUrM9eDkSUeydNxVCGqMbJxvWP+QKCLGWCUcQOa+4z1k6JV1v/Azu0gCBH7LJL7lyfgirZ+jlFTqQQbgBpYL1eJSBw7DMh0saOqSN7LsN9EZo5GkwhQTcqUMDw5Zs/Rw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSNXr/HVo/pp+6cjj5xjBXjlijjA6Ujvc6rc/qweAfY=;
 b=UpyWyrjkxrRli07Qfa/GP1sJawPULpKM9UIVRJOHtt18YQtQggwRpukIc3atbxtB3lfoVvh0n9GmXkf5oEQYAc+uL4yZt73+4YQqvjK89RTe5Ct3FypyG/A/vPRohJEXxtb5KPdOAReKztwmHK6f2NBhZ9yFstsXCq7rcRycWclsuChQsAxBDi5IyZ3IH4+WDyYgTdGcXjlUcA072aFdPvCPp400tFOc0+UYrCP5J5K1taZOo5UaX+7yS2Lze/Jn+VngSwGo9uL4PBamWgRDKVVcGgMeJw4800wC0qukfHbs4urAdnNmgMrjQYCLGb+72kbDOcHFONz08WfCo8Qh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSNXr/HVo/pp+6cjj5xjBXjlijjA6Ujvc6rc/qweAfY=;
 b=CsWS9fmhLXcjBVLo4EUIaNSYVY2ZuBsnNDjtXSiumXkjAmCG/+D8r3WVlX8mDO66SgjNNEhjUGTN60oygmC8v2gO9zNxD173uq6Y2MAzCHiY2FwBeVhwajOvEcC8w4S+b7tFqXVRU09+cM2MHilTgcCgfLTVY0z0atGv1cfUPVQ6JRaI3oAJv7YiEuYvox5D0GhFF3jGFwt1nQe1kfoMT7Lc/8ulH+vR9yFtAhHUzO0LMS5dDv/Bv8Sr1oHXgvAH5n0qLmfAbm87tNhfhgrzPNqx5NlG3BGvm/8Rrc06OmBBe+oyX0kGO2Ddny74aMe/Y8FkxzLDknzS3XmjWqzQgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:39:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:39:48 +0000
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
Subject: [PATCH 1/7] sched/deadline: Clear the defer params
Date: Wed, 17 Dec 2025 10:35:39 +0100
Message-ID: <20251217093923.1556187-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: f22ccc23-f1ea-4556-c903-08de3d503842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfF8zxdAI7sjhwRaTSEvj8ZwfuDZQmxHtb3xk82yc6msVw/wixm8Zwp1lLrX?=
 =?us-ascii?Q?ziCI58w84I1UwunAF/qIECynxr0VjiPMkQSyIwB1UlexnqY72dVZw6Y4z4ZA?=
 =?us-ascii?Q?ZB5N4jXqFxNA5IqaDSx6wdIYFp4XjGQKlr9IEjbIVjwUwzdw9Dt8/G2cAegh?=
 =?us-ascii?Q?AvI1gojLM2kWGbjt6L5WAIskR2SdwoDeVs9H/E/p9+F2GsRenx0fScYhHlfc?=
 =?us-ascii?Q?T/ZYKumVFObf+/ZDkPnW3i96776chnGMdrqiUoGlm5Tzn9Bib+tfsMHPFYJf?=
 =?us-ascii?Q?tgQ3a59XiOf3q4MFODCn8uE3OZHkcKyX8l++ve4EjsdpBH5LrRFTDDzwMg7N?=
 =?us-ascii?Q?ltfeCjH1OEq0cp/cr85KsbhLBIKZU6yXGZBDrCa2NBQyECjPPqCQrWDMXHSa?=
 =?us-ascii?Q?MLoSZGS5ReSiweUxeu5bPmuYxi1hpsDEpz0thr/KZZQFruATv99AhqVtoWRD?=
 =?us-ascii?Q?LKuYXJA1aLEG4cuOZnBgv1DmQrRFVF9iWiHk5r6zlSWP1jXYDII8M6GcnZre?=
 =?us-ascii?Q?5Mu+VoxCq69eVF/40fFRdB38HqYO1zoJXYBo2JEmUvjmmdjKgBioKCTlYtLs?=
 =?us-ascii?Q?UlBa1cuf8LUCHN3qHo+LAXijow5zqFUHX8wAwkfvNJlZUNam6g0veaOuh12w?=
 =?us-ascii?Q?qJdUI+gp+jBe+B9FpXY/GFN+zDVVwJEFA8VAU6BpRcDYyF/9WJtJdLR9rDsY?=
 =?us-ascii?Q?soIlQuT50aYKzKkjyROytxrLfNZ2iVycEVsBJmSUskXxOvzHJFaj6Mlv9NWF?=
 =?us-ascii?Q?WTVy7wdwGBwWSzuakuxyxWoIzwjlz+6/8uB7GAjgvmAIFd7yeMv0xN7tyDeA?=
 =?us-ascii?Q?TX/w/QN0rFodK87VffFczvt4Dd/VMxqlr9Ih9YLNftzxo9fqZNU9SWKpE2DG?=
 =?us-ascii?Q?Oci5j56NyqvsLIc8ecA6ec7dZdWKgLDkjVB83JpEto9+0u68Qh9x9ARM/Jw8?=
 =?us-ascii?Q?HfyRtaHHtHzW1YVJ70ezK760yz6YNZUwbWabuAOcIEHxuwtEjSdAL63gET44?=
 =?us-ascii?Q?IytZDbxGdGjEG4caEWldx2447SRTNuzJNjlZiDgEtwxnc6YESQUTkX9yTEGE?=
 =?us-ascii?Q?csqruIqKdmLkWtbq9NnQIbPs9AUbxwOMTws+uh+Z//48EjHwtPbfqzxhDw9V?=
 =?us-ascii?Q?8pVdsKWoO5q6Uu6QIgtdI3ld94AuuDtefQBJixtX+rjTlAbowWK17NI4nuPQ?=
 =?us-ascii?Q?DwroFYEw9Wzb6VXpo10ucJnZtX46lsjTe0Y7PvQHXt8i3NG/odxi82SZmIfE?=
 =?us-ascii?Q?8Wijp3C5f49ht1VX24Qogc7Ug0JFZGCyikWhVbEXsOlrGrEhIpB9esbX0WLZ?=
 =?us-ascii?Q?SFxLFwN6LZ4Tkh5D1OFLhe6Yce78Fzlz0Y+w+GywE08PLs1j5E36iKPVOwZf?=
 =?us-ascii?Q?asdEmrbV0vvpm4xW1DdV+0VQ89KGIjlYJmRvDR3LQN1Fg2NkiDPIi3R/q5Yd?=
 =?us-ascii?Q?l1CdhR97yv2G8lffm3R09l9gosiB/S+F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?It0voB1PyRdhmJXvHr3OjXPNUcNGSOkMZspbYk+IEKgUEvpu1CA4jl52bAQ5?=
 =?us-ascii?Q?d5JIKQEiRN4mTRJSB3fBg2Z0DC64BoTzR/lXj/OuReYTh3ocHnnX1ZyoBzWg?=
 =?us-ascii?Q?M2nzekkPqeonvalDLJZvg1u1Z/UhLg4nqI741Ckeektwh5cl4u0kJRg8A9Q4?=
 =?us-ascii?Q?JtHqIqiD8g1yD8/v0DNK9nN0M/vgIiPefLgB1z6VAZTxu8rv6sT/VUVv+zMz?=
 =?us-ascii?Q?kLEqU6pk72KMSbf3lFqN68tQDk7YDPlg5L/FKUU7JJasn745/Ufz2KvD6UO7?=
 =?us-ascii?Q?9LehFDt713ZPmHnZXY716teYGszJ2NZ8bzwjVmttNbHwYHhPOYNUP0mah2/H?=
 =?us-ascii?Q?jL5lKdAgDUY6auGocQJQ6hnk3uT1dEGIBgMkTHN2K9nURqMI3OrXOkyVy+yt?=
 =?us-ascii?Q?T3kZiXsi7r3K1v25TTQ9xxulaQfDzagjyET609WiH3cm/h8CmOg/hAQA3+7e?=
 =?us-ascii?Q?MLpSuypD9wwKB+Er2iBXmySGkxAnH62vIWaoWQByJYqtLV2BO/bAcIon6dvK?=
 =?us-ascii?Q?t/0w28yxMFMPkSAIWINH+Y6Y5tf1qWSU/Ir0PARVti+afFXpaJoDx5qBnhAN?=
 =?us-ascii?Q?I0gY3L2K2j3MuSliBQXrfxE5JVH6MjjUR9h0ix8Kng9ALd6CtX449CBNYTUJ?=
 =?us-ascii?Q?CgawntHNtvMl+S9rMy6sQICkppKlMxfw/ohiYbeaMvGXxaWxHx+nr0R3kHAo?=
 =?us-ascii?Q?afzyYPnhLH+ONHdCa5PeBRqRqBNQ7KhH4WsDl1p014zVJMzOnzCVRjWYCHm6?=
 =?us-ascii?Q?Tvgrv/2Nmk9PityEBjQBhd0gc0V3nocKE70PVEwFiFsrWoN0bcXyitvfRm2E?=
 =?us-ascii?Q?0IS9g5Jr2IuwBjU5Ak4iFm3TT5QP5JLszgtc1p7uLLp0RjcpoJqAntTwilSa?=
 =?us-ascii?Q?ud1noj3inLEbALhZU9gaLnxFa3C5Xs3m1GxvvJne2RB8380poKaaYHV27zp1?=
 =?us-ascii?Q?5t0Zra23+/9C9TN8JUsg7Kjjxc4owrORpNDZGpqECSDTFn+D1CaA0LFqOmWk?=
 =?us-ascii?Q?TFYOgNudM12doYFCq+cHTkqF/sfn+ihGqrPhfG2AiAy3+CV85RBAeew1lqB0?=
 =?us-ascii?Q?rxDb/88CAHTCjqszOnnR9G4lFuJoq80o2nIu545AUTgl9M+m8FUrMltYO6ZQ?=
 =?us-ascii?Q?+aGoFkBvJ+w5foF2UaDILFO30ljlBsW+OdM1mt7M+bEic3HpaeiCSDmB6BRK?=
 =?us-ascii?Q?4lwomEi3H70VPiKM/NqHykSrqN++dPHGN8cnbutBtK4dkZWJKZRIgZy2ty+N?=
 =?us-ascii?Q?5tRS4X0qWMRmE6fk2rT3hDbwqA/tl1p0bAB1Bt69UErETHGpZag3EaJVYDYN?=
 =?us-ascii?Q?zuXfu5zi2F/pIfFleDqniqp2AgGBPoF3IXSSdUzXXYq/jr3kgs5tAJd2a613?=
 =?us-ascii?Q?1S/tf8c9jyiI4iV0C5qksQVJJR+7YYLYyUsnrHlLIJuRaELWCWboJhGMNXK/?=
 =?us-ascii?Q?nM1thXGfkSbRbQe+3dkaTxCBgb/p1e2q7ObuLAwTld3xiLXfVB/VGXPq2Vjq?=
 =?us-ascii?Q?YASKPSX9WqkEBa+BfIEg4ofUlmiLe+qSdsoZvrHw1nTyQuLghXu2UZByOrx9?=
 =?us-ascii?Q?1yAs2oRIkgetZNQiwvSaGA/rY1OOOUhTclS1K9h8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22ccc23-f1ea-4556-c903-08de3d503842
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:39:48.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRGL3uoEYWLioc08ZwYcLTS2yGQ+CUIrlky6tBO5T6kt5CppSNfF+SLoIVlUiuwXIOnPJ6LXigS6Z55xg5XlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

From: Joel Fernandes <joelagnelf@nvidia.com>

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 319439fe18702..2789db5217cd4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3642,6 +3642,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.52.0


