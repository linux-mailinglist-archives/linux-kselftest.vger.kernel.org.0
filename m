Return-Path: <linux-kselftest+bounces-44350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E4C1CF85
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04BB54E8433
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179E359FB9;
	Wed, 29 Oct 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMs0XrDq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A01359FB7;
	Wed, 29 Oct 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765161; cv=fail; b=q+BzYrGPHVWbc2GIAz/wsT3XopR2AilLJpJZSlPVFPIxjF1iB46M3WG2sZm/6ylYmmDoL9Z7Uj3Iy3b3ewN+mKcQB+UFSPdPzNEdHhJ4fFDLr+B/XcxPXU2MJ5rXQedLzEcB+9bdv6B+i4DmOYqz5ri/TJM40yJfcmO75+HuF0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765161; c=relaxed/simple;
	bh=DrXo9wtsDcX7VSY34yllcxO/4SweuazB94UrvBxIz/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXHQvD0Lik7o4sGsd06up9GjtzFdb5UYsP7S/7wyN/Aaxjq5rqGwoK83rNz4w5xsPynUKsw/XcHeCc2/PS3bhmA2ia/dA3EntwaMDPsdGcaN9EXjtreW8ANjF8NzJmic18Bbcjz6gTHB5PRS0SwnDJ1F7GIaFbvDK9xix2BsNp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMs0XrDq; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtCCH4sw5UZv3UFIKQgQoxzD7MyafnZlMtU0g5n6T5sw4mO/TsgF8KtGsgesF+43nA1+x0W4qMSVeLUsntB6lZyO+83cVzKRDKpUvu6X3BKVxsqs27xPyQmuqP9JbOY14eofecWW1h0PYGdxghFGLhEs4Pe0lUX2iwQMMNXhe7LlgYfikhKTBWQ0iqmScMrvVyfy2oReaqWKOmY2aSIteMuQCsVXj+ipDyM4ff1wW55IU34VbokENDRPy1CZqGij2qK7DNgfB8q3qGDfMY1D9acuyVQal0IjRx0JOekEtTd3FfxGbRO69GGCtxcY2GZ05LZBmkNi1D8PNOT7YVM3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkPQI1zXv+OQhoz+oVFQZaxPydMeP/KkaUND3oEqCpo=;
 b=BVwJ96sWdmfw5ymTf3kx0Ptmo91lZ8P9RXz5FW0AsGLOMR7Z6J7ZjUvo/r6bvQwJQZiRm19DSDjPTK69aS62cF/ofMHh85i0e1luoBxu17qw7vrch0tQUQqp9GFrjQ3GZmnRAEia+D/BD8+FpEvm4wd5bNVwllIPjbX5zn220l95tlJ1S+rcFq/c3qVI1PrBkZ4EW1ZwTzHwxzV4DGCMXLM9EE3U/TRtggExHpOmK/DK4t3KENlMpv7rJmRTfBvYyw2QIoWdXYC0IacPk4pzKSBmSohRMaAMdUo94asjt5r6VYpBMpGoTdLXFe/c/ENBHNJFZp+kSWgXXh2N8DnDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkPQI1zXv+OQhoz+oVFQZaxPydMeP/KkaUND3oEqCpo=;
 b=cMs0XrDqiBD4ServCq536x7a9N+4sJFw5gPk/JWwh5/yfznD64pbx+I/x0LYcPK/Yg569ubCgGrsRo0VwDRJzODGiR1pbHIpvXR/uwf3W7utpEsIXHaDnh98fdiL+uA+/IU2wE9bpNPDy4hQyon+eo6MdZfy5Uv4+Qb9nM+IXkeZXIXZQcBLg997oDH9SEDd43W4L866JDIa9iLPrBxX/B2QLmHF2jfZeyUT0qmzg2qVSmB8SLNO6AyqOoi1mcBLEn3uDVGlxpjsOieLc8rcUVCx7jzju+WAGCDcQ0WV9ovITuPVRTu3smEj4G8UQQ1iEYhhHtnPbOVs0hIWTtT4vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:34 +0000
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
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] sched/deadline: Account ext server bandwidth
Date: Wed, 29 Oct 2025 20:08:45 +0100
Message-ID: <20251029191111.167537-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f528e7-0002-45b0-ea05-08de171f1d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qc0YwcFOeSF20PtlxxM9/Ro4TZQ3y42UR3xRKyenLHiZE5X5oB0Za5jSiRJB?=
 =?us-ascii?Q?x+opEOZIpYYnupp8SOhunJWPdajk6gfEc/x23TM1bROgXgrw0mquDIiIUgUg?=
 =?us-ascii?Q?Oupxf/Flk8svtPjDzYGm+KdUwt+0lAlCsuExUuHQGVmWOgT9PevTe19kUWdN?=
 =?us-ascii?Q?wVldauITJAcTdEoo/7ilcL3rqxma0kuoIKnUTuiHhz98//cKpyfxImAV2IjK?=
 =?us-ascii?Q?2piLpHV6qutwpfrjKTbWEHc4eey2Vy87hm4xkr8kxrwqj8JAKR77D3S8turv?=
 =?us-ascii?Q?hQYTr6Z0F4pRX3GFOH1vwDaNIWSWk1TrOs89urbckWl+cnwbZraFFPW1xXIz?=
 =?us-ascii?Q?Afx0xKcxxbD8p4smfEcE4erNlm85+4j7uC3azmQFwZc8IpFydU7ApIdE3LJZ?=
 =?us-ascii?Q?VVm2LlU5kvTMBvFa/Nwo5+dJgV682Qhw9oQir9huWCyPtc+Mti4wWAUQ5ofn?=
 =?us-ascii?Q?8K+SlFMYqr6b3YjOVYx3vksA7uyzQKISFPF1pWKkCSrf4fjJOBbRJqkDvhkT?=
 =?us-ascii?Q?o3LkAbDVx5omb648Pbvuv2SnbLOugpij5ZmMYGlpi9NwUHSsJvQYCGXiDVKU?=
 =?us-ascii?Q?x7/kSJhYgBMCI4iPqo6rs7fnCL7oa5t++nygYgpvHMWGoI4+9lcqFaIlNmxH?=
 =?us-ascii?Q?SP7hJLu3q0E4chHwRFC5wVuJHeIuAJZCbsY1ORHckIg2bG+PaJ3KBBl7MODO?=
 =?us-ascii?Q?WzsbK4duuYWM9os+oarYU5oxCDlB5X86UOGx+T5H5PkzkkmGjc8PPpL+gHKQ?=
 =?us-ascii?Q?wvIjhx2OvFfxU6ron/Hc/SWJU+cOGsAKuxHpGuFK3PrbHxm5ylG1aSQlQaUi?=
 =?us-ascii?Q?9PnNtxNalMO7tOQNlEtzjAEyPgTeR2vX+Ov/HV1O5EJ2ViA4Op30ECcx73Dr?=
 =?us-ascii?Q?jyOhL9o3i0Ztzz5fOt1EiqsZLx2rXEO3iP8GtCjoslkV5UU6uAB4RLKRPN/2?=
 =?us-ascii?Q?L1Oim3NP2j1OT91je/cRHtxbkUp63f4S9bg2Y13FDqx+IgAnlBNW1VEVMJKA?=
 =?us-ascii?Q?gznYyR4DRz00/m6HpHBdj7C1GqznpFzG5cQ3mkNPw4NAErTH3AQvCjLMhbl6?=
 =?us-ascii?Q?csBXtp6+CtTMVoH+Yru9+4vABrQlUAnccmYFlHMYXowbwcy0ZbL28Z3t0sIy?=
 =?us-ascii?Q?aYo3HR6fQkmHRCQFFVVL2XkiBk5t3GN5oSAhzbHGxWIiElgqiGCpDUo+SYIl?=
 =?us-ascii?Q?1O8k9AKJsewRbh+Nawack8TnzEt7nUKMj7n/3biSNDpQfp5QTD3J6zxANuzD?=
 =?us-ascii?Q?SpdPdWhTmLvx+Mv89NjoJX9Q+7LMxAIRVCPLFBIJMP+5gi6joFTObTxv5v2P?=
 =?us-ascii?Q?lPWRWCIcXvZP8ICTtPPJTAw1OiHAUwilmriFC8MvLKe1b0sySlT5fjbJvNGX?=
 =?us-ascii?Q?ah23wsi9hf2VvXV+dR83xPBbDFk5Tgs4cf5S3OgBUpCSP4NDqtwvBOqeniPx?=
 =?us-ascii?Q?WcQmVJwi3PEZ6x1C2I5A2XY5JBKkcT4o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q/Uk4+e8+R3GLGnlYJVSM7UfjI97k8Cs9/zbHa9qJIvb1JsiyJNBO/lt2pAq?=
 =?us-ascii?Q?jwREQidKFiLeyrSVOQue04NLRDl3oG9MjgeW489mezxqhQiAOVs55WfI6ezO?=
 =?us-ascii?Q?at1mlkRADsM8Jou+br7earv4v8RDOJiKgRR14gbqp5jN77XCBFsJBokU6g1j?=
 =?us-ascii?Q?3WedsnMh3f/ALBxAT30i0LwOJD7Z0FeSCiR0K2PHr9u2M0IN3+2pWezaAB7z?=
 =?us-ascii?Q?oy3onVi33BEYSGra69wY2mkAIFawqglLTAXGuB/N2AfxEO6tOqXxI1g0Mhfz?=
 =?us-ascii?Q?J1Fj/rZ1g18vILinTDgYv5gxCtgz3gBBInj60biU9wUc64BnykkrywCKGfL0?=
 =?us-ascii?Q?DBVmNa2gYCuR5Fks3bnG0eDbOYU8Nakgu3Kp9i6IHYhN84U1s56/ZM09RvDt?=
 =?us-ascii?Q?+IZuRwb4vZqq0s1LYFphxOoe2qTnLhdgD3mw3NcrIrvnp4qOUfPg7D2ZcWb3?=
 =?us-ascii?Q?Lbz++kZ+Td3Gt7oJVK7IOgTCp85tpJjoAuXCctO4SnByc1yYGWXUkqTqDgbe?=
 =?us-ascii?Q?Wr3ZKenE9DM7d1JrkwZUPCQNt0OGaaMrvDtny64wyqXMQujnn0UQcmbaxp6u?=
 =?us-ascii?Q?xx01d/izuPjldwhvCr1Y/fAjI2Tnp5dkRloNwGkPKYu+oDUOGp+sR2ekekW+?=
 =?us-ascii?Q?IthSq5ohJL4N0vTb9bc0i8sdt27Xx+zRSk6auvQoHDQ5MoKEyzJwjlH9bija?=
 =?us-ascii?Q?51zDoio0cmJHQjGtd4s5O6DveTzPGoMxBO9JtlvmBMmZuFT7qkb5UyqoWmjU?=
 =?us-ascii?Q?mm0p8Cgy4ekN0duq/aUxcvbRmIgIuBpd3YI5KRPiU0gaPMAQqOnvWTiG3gkW?=
 =?us-ascii?Q?0g3Flf30W1LaUZNs4qwXQjZqNpgBTnSlzjV5WLzKReCoIUwuG8dItezNN9Xm?=
 =?us-ascii?Q?aUzfizeb4tfWIZWML3qAAJolxFszecR59OpSRKzGV13PeDZQFvsFDYkkApUt?=
 =?us-ascii?Q?kCtguX2vfk0Z4KeX94P8ZK1QZA+C485WV5TEQWhg+NkNHeyW8h9zxodYrwnY?=
 =?us-ascii?Q?bkk0kJn11f3VBkzrPLdTbF2DDtfGAl4IENHthDx/NDq4uor17E2qHBZ3PQq0?=
 =?us-ascii?Q?OM0PP+n/8+2AnbVZg5zyzC3dBsH377SVYNa96+BptoWxV4XJgJHPLXzF4+Lo?=
 =?us-ascii?Q?3Sb6ISIIWPlTaDwk3ct6oF/2aKav/RJFKf8yoUQSZuAIUOOKL1VowUYDH8Tg?=
 =?us-ascii?Q?wrjLjVnuAG2qPILEhbdYr4Fe5uU+ZjPzjA6qH/s4mg8wFpr1KTK8aUMQgR5e?=
 =?us-ascii?Q?6q+70DRT0m1gCH4axl2Dck2HYkIpJ1Tw9NLNMKrKHDpswGN4HgabCOvGlk6d?=
 =?us-ascii?Q?5bPTutLYj+GLmgl4OrOl8Vt3VowOp4imvxfUGbR2vjlfc3caiAiMkO07DJKt?=
 =?us-ascii?Q?WdsIEXYDyD+riPO7RE3zMg8UUVKyaFpMbC4Lsp3WTlraCFcEau9/ynJmG7so?=
 =?us-ascii?Q?xAXujgH1QZrVv2XM7BXwWwsrvh+f1Elcm7sGYhVXVr9j78mYNJTa0WJgDfbk?=
 =?us-ascii?Q?3+UFOeefjVNryWSEiiTh1eaZTilUQOJkn7Xah1Nb3RUUtVaAb3ghF5Updeey?=
 =?us-ascii?Q?QuvZJVo3NIG1X1OBEBudTCPRioTsbkIv38A4/0ca?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f528e7-0002-45b0-ea05-08de171f1d94
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:34.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5kQX2Bcnh63ULpoUC9fD+jAIwQfZzBOcPlOhx+USKpFFVwwfJwmqCFlIa9A9PNAVHEGJcFUuwI9eN94jjeebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

Always account for both the ext_server and fair_server bandwidth,
especially during CPU hotplug operations.

Ignoring either can lead to imbalances in total_bw when sched_ext
schedulers are active and CPUs are brought online / offline.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 54 +++++++++++++++++++++++++++++++----------
 kernel/sched/topology.c |  5 ++++
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6ecfaaa1f912d..f786174a126c8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2994,6 +2994,36 @@ void dl_add_task_root_domain(struct task_struct *p)
 	task_rq_unlock(rq, p, &rf);
 }
 
+static void dl_server_add_bw(struct root_domain *rd, int cpu)
+{
+	struct sched_dl_entity *dl_se;
+
+	dl_se = &cpu_rq(cpu)->fair_server;
+	if (dl_server(dl_se))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_se = &cpu_rq(cpu)->ext_server;
+	if (dl_server(dl_se))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+#endif
+}
+
+static u64 dl_server_read_bw(int cpu)
+{
+	u64 dl_bw = 0;
+
+	if (cpu_rq(cpu)->fair_server.dl_server)
+		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (cpu_rq(cpu)->ext_server.dl_server)
+		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
+#endif
+
+	return dl_bw;
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	int i;
@@ -3013,10 +3043,9 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * them, we need to account for them here explicitly.
 	 */
 	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
+		if (!cpu_active(i))
+			continue;
+		dl_server_add_bw(rd, i);
 	}
 }
 
@@ -3513,7 +3542,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
+	u64 dl_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3546,27 +3575,26 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+		dl_server_bw = dl_server_read_bw(cpu);
 
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - dl_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap, dl_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 711076aa49801..1ec8e74b80219 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.51.2


