Return-Path: <linux-kselftest+bounces-44346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE422C1CF69
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EAE583532
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEEB3596EB;
	Wed, 29 Oct 2025 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeNM+0Sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358F3596E1;
	Wed, 29 Oct 2025 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765128; cv=fail; b=JvVDqw5Voic/QnucaBjD6iar3HpmHaTjbwCoy+bi7N9WjZoXQ5eNRm+q228uvEM93xTlTQKRHJ1LlKPPDwG6qAENe7eig+GzGJChqEGBhje2dbVouqwvskVebooWjOtN8VbYPXh93Prp3H+33FKXtS1gI9idC7fZnww25vfwzMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765128; c=relaxed/simple;
	bh=Ks6rWjmhHOSl7zkBYnrSmFa+U8VcTE7p3Y8RGSnfj0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7iwMnZavQqO8D56F2UaS3pN1339Y0PmzUThgQQuFwBbgEAZaVWiABrHB8RVTjIasMwSlBWopD3JmZ3FufdB3UwwaVVCNU8l5FSFWGCgVAsaIVTXpMHH3neH6TDi+WghMRdux1G6ZzFlEUziicbfTDe/6PzftpvN9Eh8etJrEhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeNM+0Sx; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCM4pk6b2hak9hJY9UxuLC0hYexOnCjK+FVWXY6TxQ3GY8DyNyOHI1GnQKRn6sNvoJkdXeG8FQfPyEdescpwxSRuJvnITVLWdlP/n42senDpcaIFkXt2cyVFaBDWHX6zQPw1ld+Ljd/jTHVQnxZOgioGBAGf8y3qt9xFVpREUKFJhF/q4psr/q0MAn9J+xvt3E/g1yzFzhn5uk8d2ByzYBTASHnp2hiN04+eC3s6VXxtByGGg+5RHn0QTr/4igsFGBYilemt3HKzfm8EORGpfWzdBPf1ib5T8+vKK1lxleeGjeNS1f29cLNpzu3F6Odk8EIE88za3aIf47UmhwsKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9GoQ/I0CJpE5J0lMYD5FifPgEk0iLwoYsAOfuixDqY=;
 b=dnNjIVsios4BPcqf5oDtyXcEnypTmQBORUgMoGR0gSkhQif4C10EFTRNRM6y7m6f8tWIGDx6JuMdTICKXRipoAIRk+Pv7NOK9H4F4LymwDTkjeUdpqo2FBIKpRe+Aqy4dfsxX6wTvjN3CaeyEP8qq1dvAWweFc5MpWOXx+cQgQhwilYNiGe2yjnkmuOEaks0kUGvP3/yWFAm4n8uNn+MQMJa0p3sVQWlhJtm5yupvf2dX5jPAgT9J06LzT4KBMvUlZdZk+yH0Womy65O4zHkU7f60zbj4WiISwMksNcEQPFeKbj//6xvLKZwGr1+inmnE1fQJ43mE75Y7FLOn3agOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9GoQ/I0CJpE5J0lMYD5FifPgEk0iLwoYsAOfuixDqY=;
 b=BeNM+0Sx1M13xUbLLG3vwp8mI2B0oipK3E9oa9jvtzlhguS+Tj2f+B3+Nyw/dtt8aK67N2RNNDk6SY9Z59dZqD59+qsCt1+0RexjbRZgDKkW5LY/ytu/6HMm5xpJE53MYzB+WWY4ZKRLyiMZAiFI7nO13lDschJAe3Stmaj9z9cy0yPqqAZW3Y50Q6eXg1qN2DvO6YDU1G70Au/JH583ETIlcpiPijAB1uExYOW31EAbUJ78tEQOd9Ta1HlI6BK6CP+VLr6/AtCfTsL0HN+wqN+Q/EciqbjxwOOpa4INCEM13Z5NdWUStp6eX78WyuLsjGmn8tz74KuL7CdfEBs6mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:11:59 +0000
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
Subject: [PATCH 04/11] sched/deadline: Add support to initialize and remove dl_server bandwidth
Date: Wed, 29 Oct 2025 20:08:41 +0100
Message-ID: <20251029191111.167537-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a58d9f4-762e-497c-1f98-08de171f0913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6stj48W76/duEB8sLQdyEBAawIWdp5OwFDuXFn519Woo0WxtBVKg30Ik/9s?=
 =?us-ascii?Q?ZYbqL52QziaOOFdS7Cjl6LrF0wYCUK8DmcL1+BunzAlhbIgiysPTKaMBjRWd?=
 =?us-ascii?Q?ZKAONt2x5VoPe7Sl9cG6EECuG0ziQit69b8ahU7+HNLsyBA8bKR39X6cqIb1?=
 =?us-ascii?Q?m1/emEf0N9EVrTuUOe9Vp72nfCNe+QglqfXofHk5BbJXlhsVwiD9jv5jTAj1?=
 =?us-ascii?Q?YJyalpr0q1mvN8zq42kzyU750S3eltjw0hrSpLX2g++ttx67ajmEVRjb1IR7?=
 =?us-ascii?Q?jH65UZgK0OxJJBTfntmoh0C6vzvn2bvealhaUeTAjxjG0OrCCGK4Rk/MM/wR?=
 =?us-ascii?Q?Pm5YjRW9VSbiF5yOUJz+9KMJKzDFTA4u+AV/1Kjy4gjTEhdj1Veg4XEgilVc?=
 =?us-ascii?Q?EGjtoje8arzZtYsy9rN8CVlxnUf192VnbhZ0pEL2KI92XE31Hq9pIfc65Aqk?=
 =?us-ascii?Q?EILzptGn2VrTX+V3KodByvhIe11NOq6su43O8MvC1cRrWvirYzBbGKRAeSNW?=
 =?us-ascii?Q?xKOfBWJTJn/3ZNPNW1e9HZKfCd4kFKrtztEGspbLuvAqRUSDrUEmvRWoy83x?=
 =?us-ascii?Q?Dq0dNhU7zSxtpvFAY7/yi/BrIGYUZDYvYwM4qMeSha2jHrzBxxbY1s1VB1lw?=
 =?us-ascii?Q?K55+7Y0WxUFLcA907VZUSM7uKItL6p0uP7h5+vRUxfXcnv6FYPO9iuJkquyz?=
 =?us-ascii?Q?rQVWPADXyhh08FOonpZ+jQRpW+aWgbJe9s3jhBC5ewU13HmIG+OV0BVsKHqF?=
 =?us-ascii?Q?LUBsJIAu5qjKxvMK8t/l15VJy3FLcCjt24LwwV2r3CdRilpI8BS5X/PumdZS?=
 =?us-ascii?Q?OR1y0cheLoAvR3njbH6AaH9NLYqEIGBYwNsvijIjO8kJ27OqdYiX7ox9qDPC?=
 =?us-ascii?Q?YyS2SnoSZkw1t/j7JPZHhsHbLNOM7wF8ikM8kMRh2yFnBgCk7Om/NBrNQzPU?=
 =?us-ascii?Q?GeUMYwYMnZ+tfrAj1kv8NM/9ihmyLv5/Zb7b1wOzZblwOXbBqermdfMmhoTB?=
 =?us-ascii?Q?WQzLYunQKUbBPw+qMiTdpdTQherafPWEhJyPv9VH0xMnmJUsjghmA4Hk8Rrr?=
 =?us-ascii?Q?t7FkMc3MRy0eCfD6dvTnL7QmXZeQGLmHNYNac93poT5gfnexKml24qLt5S79?=
 =?us-ascii?Q?1byx9bn6cYqBKBdGt+/3o7GZuKPEs52C2zJTEci7Aik3xi006kHL1NTo4+BT?=
 =?us-ascii?Q?INjoRs+VWqg4zNc2942PPYT0GhNHicEHE36PxFhb4tfaLQilwglCjDxBDCun?=
 =?us-ascii?Q?+gvMoK38rpxupWv1KZYcKUxs5fGnpI1ODZEqN9FjDIRdUW0szp18Ye+Z7L9n?=
 =?us-ascii?Q?ezz+S9Hlq1hrYY12/jrrbymHR0pyQvnDOkDOUARNuP07H8YVkzCTBUSYt08P?=
 =?us-ascii?Q?k/ZzmVK6V60Cx0ruCe3m/ymg0DBzLk9hwXe6evjkxXlJbFuGdfWA44OzRv07?=
 =?us-ascii?Q?xtK+LCKHIONb3dhEobMhSE41XQ16Fn+C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jySp8MqsKSrqS236j/rcvCiBvpatV8voGzvQMJMZPvR0r6dFatspPLAoPvkt?=
 =?us-ascii?Q?bE3wAacfa2P4YRZ2lRSYE97vg61B0N/P68mXvdkuXZUvsU/nq+qu8ay5ktJ5?=
 =?us-ascii?Q?iF+QiNAlEV+NNjZEg4I0PhXFLYoAiouDpI4Cntc15t7Liapg1TjssCT7289M?=
 =?us-ascii?Q?7YptKzUvR2AYgdJGgTeJCYB29EQ80YYpQQPyysXvgmr8mKABCwzfSnNvhODp?=
 =?us-ascii?Q?8g77Hp4sw9jfAuTljYFc10OrV9sZ6fHbWNRt9cjT4Kq7MU6JHMAG4/ytRZ8W?=
 =?us-ascii?Q?lBijTCmmM1XfolLD4crvqk+p3YeAjEQZzdxmc1BjmPL1PI6aXdVF8BFZJMmw?=
 =?us-ascii?Q?4vjM4A2rbzgWjd8JPeanYWUhDYE/JYsLdYB5HmpSl88K22KMofY5KWTY187q?=
 =?us-ascii?Q?lWsHJ4aOQ77xInpVzZOJNXjx+dIVCemj5iCLMQ7F3wyu6ou5LhHbaVsBqSe6?=
 =?us-ascii?Q?RhJ+hyxKUshjfY8jyF5qe3fWkg4NoMAhbBt7Ctr+WGXuOj8ovfgvqZP2jmaq?=
 =?us-ascii?Q?bGdOcJT7J8Cnn7xwtNwufOrsk48bZHwswC4MwPeNN29qnfDLCdTVIGVglkFs?=
 =?us-ascii?Q?jQegK0viee3kG3sGPxYLuCVujcED14JWB3rpDQ1AmJozY86eVMU47CfU4r/T?=
 =?us-ascii?Q?Xfu1nCC8m8ijF64A6IFr9nctOTQ32dX9pPWF0oVnXlm+1BIzN3vw4n6DBWFA?=
 =?us-ascii?Q?7RwXTdd1aE77YitNicjf5Kwlt/UOe2H0DPT1t97A7UGUmpnpDLh+XKT6dZNH?=
 =?us-ascii?Q?vFaBMVxPHyyDNjjpyYkmJCqO7CeSf11IbqOyBJii5LMO3eaeeY8ePPbfNING?=
 =?us-ascii?Q?yA1rLFtZlS35G081x1o4Aeu5NuFOP9nSDHddcS8jPy8VkF71iHqELv56PvEC?=
 =?us-ascii?Q?JM1Hd8EuqhDT0DvWXUeDuNbwTCPyWikfBDU4ZOem+x2WTcgwKblVMy7/Fkhe?=
 =?us-ascii?Q?P1xanZVQahBB+HbY9O+hIfbkr76g3XfWo3/If065ect4nW/G1NLUtXPUouu7?=
 =?us-ascii?Q?+0ZiM18/wSBhiqSCbkvyjltidNjuS+6bO0YodKS9tGuxe0oNa/sgho4QXVoO?=
 =?us-ascii?Q?2uxSX/Pr/4Nr0LgyAnTW10/ewfZZ4M/d/JMXa6h28A43udfJJ/kQoADRw55I?=
 =?us-ascii?Q?twgRK94aWpwYja6HMn1z+7gQIi66DCP8Y1aBE1urGDEP4Wm3GWmbtvEjf9ss?=
 =?us-ascii?Q?EAvcjTUBXld3k+pk53BZlcOJVB7cVdQEGG5lnu+HZpGb7pml6N92ExRr3Reo?=
 =?us-ascii?Q?PmsKIHEwFKntwuUcDfk68fC0VPANZTN6/XSsAjtF4H1EbPhtwrMLKeidv3ku?=
 =?us-ascii?Q?F1k08osKp6ATk3ghjplgKQAV79N348+bd9G/s1NBu0Jafp7v8zTEzKVSH0V0?=
 =?us-ascii?Q?EVuxJQyd3IxLrcF5KXpy7ZrLGQ9jXdwV+3vBtW+k/N7gxcmlrCjzVYsgbqFO?=
 =?us-ascii?Q?trf+YIHiDRiI080zLqtY8TzQ0DcZzIxMek2CgXaKa5X6OLNQDFA1jwqiLHHp?=
 =?us-ascii?Q?a5fOC/FKC05Mj/TjXJW+8sRsyHPLLCN9HPwRfwkVCPpUltj3EtmTu5D8KzAW?=
 =?us-ascii?Q?KoksMHZ/OQc+zWyJE7HuzvkQ+AP4DkSUVP86MySa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a58d9f4-762e-497c-1f98-08de171f0913
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:11:59.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l83Rc7bzlHL+HOO2e8Zph1n4YIHKB6SndyOqtLEF1LeopQgJubVe9nqcDSMSV1h0vNesDexPvfl2eleJ/9IqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

During switching from sched_ext to fair tasks and vice-versa, we need
support for intializing and removing the bandwidth contribution of
either DL server.

Add support for handling these transitions.

Moreover, remove references specific to the fair server, in preparation
for adding the ext server.

v2: - wait for inactive_task_timer to fire before removing the bandwidth
      reservation (Juri Lelli)
    - add WARN_ON_ONCE(!cpus) sanity check in dl_server_apply_params()
      (Andrea Righi)

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 96 ++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  3 ++
 2 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4aefb34a1d38b..8aff1aba7b8a9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1441,8 +1441,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	dl_se->runtime -= scaled_delta_exec;
 
 	/*
-	 * The fair server can consume its runtime while throttled (not queued/
-	 * running as regular CFS).
+	 * The dl_server can consume its runtime while throttled (not
+	 * queued / running as regular fair task).
 	 *
 	 * If the server consumes its entire runtime in this state. The server
 	 * is not required for the current period. Thus, reset the server by
@@ -1501,10 +1501,10 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 
 	/*
-	 * The fair server (sole dl_server) does not account for real-time
-	 * workload because it is running fair work.
+	 * The dl_server does not account real-time workload because it
+	 * runs non-RT tasks.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -1540,8 +1540,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * server provides a guarantee.
  *
  * If the dl_server is in defer mode, the idle time is also considered
- * as time available for the fair server, avoiding a penalty for the
- * rt scheduler that did not consumed that time.
+ * as time available for the dl_server, avoiding a penalty for the rt
+ * scheduler that did not consumed that time.
  */
 void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 {
@@ -1570,11 +1570,37 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	/* 0 runtime = fair server disabled */
+	/* 0 runtime = dl_server disabled */
 	if (dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
+/**
+ * dl_server_init_params - Initialize bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function initializes the bandwidth reservation for a DL server
+ * entity, its bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_init_params(struct sched_dl_entity *dl_se)
+{
+	u64 runtime =  50 * NSEC_PER_MSEC;
+	u64 period = 1000 * NSEC_PER_MSEC;
+	int err;
+
+	err = dl_server_apply_params(dl_se, runtime, period, 1);
+	if (err)
+		return err;
+
+	dl_se->dl_server = 1;
+	dl_se->dl_defer = 1;
+	setup_new_dl_entity(dl_se);
+
+	return err;
+}
+
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
@@ -1614,8 +1640,7 @@ void sched_init_dl_servers(void)
 	struct sched_dl_entity *dl_se;
 
 	for_each_online_cpu(cpu) {
-		u64 runtime =  50 * NSEC_PER_MSEC;
-		u64 period = 1000 * NSEC_PER_MSEC;
+		int err;
 
 		rq = cpu_rq(cpu);
 
@@ -1625,11 +1650,8 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		err = dl_server_init_params(dl_se);
+		WARN_ON_ONCE(err);
 	}
 }
 
@@ -1663,6 +1685,9 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	guard(raw_spinlock)(&dl_b->lock);
 
 	cpus = dl_bw_cpus(cpu);
+	if (WARN_ON_ONCE(!cpus))
+		return -ENODEV;
+
 	cap = dl_bw_capacity(cpu);
 
 	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
@@ -1678,6 +1703,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
 
+	/* Clear these so that the dl_server is reinitialized */
+	if (new_bw == 0) {
+		dl_se->dl_defer = 0;
+		dl_se->dl_server = 0;
+	}
+
 	dl_se->dl_runtime = runtime;
 	dl_se->dl_deadline = period;
 	dl_se->dl_period = period;
@@ -1691,6 +1722,41 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return retval;
 }
 
+/**
+ * dl_server_remove_params - Remove bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function removes the bandwidth reservation for a DL server entity,
+ * cleaning up all bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_remove_params(struct sched_dl_entity *dl_se,
+			    struct rq *rq, struct rq_flags *rf)
+{
+	if (!dl_se->dl_server)
+		return 0; /* Already disabled */
+
+	/*
+	 * First dequeue if still queued. It should not be queued since
+	 * we call this only after the last dl_server_stop().
+	 */
+	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
+		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+
+	if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == -1) {
+		rq_unlock_irqrestore(rq, rf);
+
+		hrtimer_cancel(&dl_se->inactive_timer);
+
+		rq_lock_irqsave(rq, rf);
+		update_rq_clock(rq);
+	}
+
+	/* Remove bandwidth reservation */
+	return dl_server_apply_params(dl_se, 0, dl_se->dl_period, false);
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 27aae2a298f8b..4a0bf38dc71e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -417,6 +417,9 @@ extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_init_params(struct sched_dl_entity *dl_se);
+extern int dl_server_remove_params(struct sched_dl_entity *dl_se,
+				   struct rq *rq, struct rq_flags *rf);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 {
-- 
2.51.2


