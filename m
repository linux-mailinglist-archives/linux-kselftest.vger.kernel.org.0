Return-Path: <linux-kselftest+bounces-44347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42FC1CF4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2456E5609E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192E3596FE;
	Wed, 29 Oct 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxUjnqt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93073590D3;
	Wed, 29 Oct 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765137; cv=fail; b=Hv1B1EryLCCWmto+bb/aM0e7AodN2DN16ALu6gT7o3Q3jD/4qWabqIYkU5dPsrGA1PgLgU4twHEDyMOUeQ0kvrD4pF3fb//0jpR8KNH473TyzWNs9eUQ45p66Nz+43F1SguYb2ukHoM0AdcuJgzmVBeBt56J4IixVMBbqyiXF4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765137; c=relaxed/simple;
	bh=vZxx2MAXqrlAcABoWC7xv3Rh+X7mUl5kgSX65QZjADs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bC3IBLWOmV+ms/IRpiiWNmj2TXNOzYdRBBca6cVv/DlaEZRSbfQhWto3gDE+P1aHuHJqFm2S7qdYiGYQpWDTCYgTo5pfDnxaX0CFCmTHwSc63Ogkv/5MW7TeszKCHIf4oVyv1TO/Vd3yr435LuozLxuCj4tszqP8EcH/u0NR7IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxUjnqt3; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7yXnFSth61+VLr5sgWcl880bb5CQBZBosmSRB0ip8y3MhYEkfERlaxPAFnHuRBnFYTklhsvHbCvOBZSjWpBUhVHvONBSDPhk/Uahboj94cGd+oEbqRtBBdMNyxvaqYe9gSgXb+LR3hgEHg4+2apf8sEM22EjlFb3C6b3mPOyV1YqYIH34vzobH7BnvttJDZebPRdaC03YMk3fT0GqnwHOY6HRVPsv96l4qiwgx6GPfwOhJLVXqGbyyWSlP7eBfPcUupbxQOVeYaX/zNDrDLFQ0DIIeTb740bg89tfL9R8vuy3xWbLqzMgVvfwwqdRg/L0LRTWlI5y0P9bNzEeXiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4kBzr2OcxnsolARNTQCmgk+3YxllwadXz3/SWTyUMw=;
 b=wXy/v0qM2qxIvLbjmU0ihcq2yFjSnYPSVMz4ZWIl7QqN+RO3I3RqAojl/aDVEmfjTZjwzYNSNCKsh8myXQyKlfzHeBdQnTXmGiukjZ3NBALbTd8mcJuLaYAI6QGWo1Ne2TH/VYfVT/y/t8NTaTeo8mxFyAAbYHglgA6A2qiXeeVlvXh3M4q9h1jKBg9mpYYxiP3RIRNA5tUH1u/7OBKYVITc6gnzV1aNeiImn218jUnTxQ1nrArJwfBNE7YMFboBOPdJw1NbdDmxN1e0RTASCGL0tAfpX+dUGbjlOMLn5oiywZHnNB5YVo60uF2EOdfKKwr9T9NMRCMKi9PLdS8hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4kBzr2OcxnsolARNTQCmgk+3YxllwadXz3/SWTyUMw=;
 b=qxUjnqt31XLXxTKM5AuT4sEkr9SNQv09hQc9clNhYJZFbpkqNzBfjtyQzdAcqgrW/z4lnrdKC+b7mBi3yHsiy5kpFN0z7oAlsaLd3GROGq6ViUeU+DstHAsRaflngcHQ1BT9jFBhcwKYoBMnhGwwm0h73RxQMHJ4AhbCXgjbMGJQWucqtpZOCFYP0tV++e+wkVZjgWzlDdn3TZddqrPW645LRi6bxAa2/spPf3JZ8CN/eq9oQ/ONGXcDwOVsGgzIHOc26zsjkVDqGIAXvxMbRNYoDWvhN63lNbQJcI0yL1rz9/up772U4XrR0Nx8XPbb2P3Ta1XQXP3bTd+ZNca9CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:08 +0000
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
Subject: [PATCH 05/11] sched/deadline: Add a server arg to dl_server_update_idle_time()
Date: Wed, 29 Oct 2025 20:08:42 +0100
Message-ID: <20251029191111.167537-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5a9a89-4f16-4a38-271f-08de171f0e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7iSgh6p4iWMeuM5RAqWMmUZgWWCXr+XQ7LmUFdPQ3aT4WD+CNlG5VOvSZ/R?=
 =?us-ascii?Q?ncNicT71UxeWnxN5pYy0tfzKaf0jP2WZdONXjQSlac8zTaQ3sV5lJQqTm7kk?=
 =?us-ascii?Q?QKf8ry0A5LA7amWGEl4zRxE0uQdqgGANE/0WtC0FraLCM7bSDdVdMXDYAJJR?=
 =?us-ascii?Q?sC/nBhFgGPVktXUukLhQZbYoDgTn8HkGzMUwVeVotWWkkWTpZTsrx96tSxvn?=
 =?us-ascii?Q?m29pDkt640v4YwQ1SeN1ZBVx9HX9fDNLnVqbJXK7SapD1ScqlsmcLd5W00Ul?=
 =?us-ascii?Q?rgucn0lqAHw+TCaVrSRTjkD79b+lclsEOAtOlo7/7YqYV2KvGjhSAHlnPXzb?=
 =?us-ascii?Q?zhHn7JMzejkjiBD/LjSeUrPXW0ezvPZYg9BtqdzzVZHMupRiaxViiyiep7sm?=
 =?us-ascii?Q?LJRf3RI/AE3BlPTJP8e5IZp7SkzaDZv2ViLESg+vYPTsKVPDoeGGbSar+cZn?=
 =?us-ascii?Q?CJHh2AjNOUzuZP0USjkDZiuggfzSj7Xunr1GeCv1BsL09ys44Ezh6Gs2bBba?=
 =?us-ascii?Q?N5Loz5vHRBad/jE43Sx+BkVAgQUiF7Df9lrt5GzeCIgGLVfqWmxv/+lALOw0?=
 =?us-ascii?Q?UvYGeVfyQ6IwGXlj9oXoMQuuWXnagwX3ebKkSZCvt8qnxymYUHoAvZf2gsy4?=
 =?us-ascii?Q?VhkjvDPBKrpdD5t7creW4H6+v8qUqPA89soTdgtZasbhjO4wQ8xuOtzF7IM2?=
 =?us-ascii?Q?XU+ngYsIIfz8lZVOluYVTXVopYSCJaeo8SnBBh5szpN0WUOv0gXtVvwmO3vJ?=
 =?us-ascii?Q?tLsHI7jklxqsHFdkrVjZhR9bTcBD9uHUp6v+Hby4qitilkk6fEO/bvmFFHJe?=
 =?us-ascii?Q?6hFqQRwkurgYqW+HPjkBjzq/pRhG8msSjXhLMm0vO5YhnM66od6HQEhCLwVb?=
 =?us-ascii?Q?tEioJ7gSOiNHJArsVXUEn6njpdAb5eYyY/yeZHN+DPQ5bt7C5Jujrie+69pR?=
 =?us-ascii?Q?7dNKGR7AmFi93H6jab6H4QFSa/XaJRc41bukMMtu+5TbdxrvNdNVw1P2Ifl4?=
 =?us-ascii?Q?Bg0rGMlUF58UoFewthlmFFGXDi7gFuRuqQW4mG+wbD6ux7ik1Jxv3ZnWLY+j?=
 =?us-ascii?Q?HulwEHiOkwmWU5fNJDykObJPjmFePm266rWMD4vEx2vYFn4SHNJsmV/eGkg3?=
 =?us-ascii?Q?XmaZaJ4AYVrIIZdxz/cdxiA9+taYhZucLl3ZrFUjijaL5jTDOXCdceN9Ux3/?=
 =?us-ascii?Q?hTuNkJtodSkA+piv0QWJQqpDkynv7Fnz9Cv7+MGZUjWJvvdqWMudc0acUj9g?=
 =?us-ascii?Q?bNJ0i0bminckAcK6TUaAdB1x+rB8sfr+WHQf2+kpC3urVPSoJ4wMPbQkuO7q?=
 =?us-ascii?Q?bidQNqHU8/Gy25KpSspQBm/WAIxiBPelnietRezxQyesTI5zfP00Es+wyyFW?=
 =?us-ascii?Q?jFePA2w+2NUoQREWfXo3JxhR3luc6i3UHnpMfUF8tSzUHSk1Iln7Zw2GFpD3?=
 =?us-ascii?Q?k3QhoHnLsJX539NewrFJjXFhyDiE9ZqG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uPiEVpcuK/zZ0NKk6OnZz9+2gUGytnWaXRtM6ag+dAK35BrnHFP9zeZV94g?=
 =?us-ascii?Q?TRhkMTtUB0F9/apyhrWsZbi55+9ZMtkU9BVoYZvvnsSd8ZJO2g0tDPHIU7ZU?=
 =?us-ascii?Q?29I/5pS0UE8+hAYc1aI5ELCElyeudiCOaUvnOJfgBEWwDvnx2YrN440hKJtp?=
 =?us-ascii?Q?ZV+KSNkO+jnTMabpGS1K4BK31TT+Rj+SxRuoMt55MzrRReaQeQykLTYcMf3m?=
 =?us-ascii?Q?zpdJQbLPumkm3CrZ9KTgPed7eAaa6XcKfVAV1U+P2AjmE00X0d/YbhZRVF6N?=
 =?us-ascii?Q?elwVIj64xdS5lJKxYn+P8SZwOhHOrt1g4SYH9vq6hzTuvCBiSqfkpUq/9rk8?=
 =?us-ascii?Q?jpodYO/OvDJALW9bDl3aHF7omj+YJKHLZoK2Xs7e1syjOvJzUoPFrbBV956I?=
 =?us-ascii?Q?ackBwF6OvEtGOWtwRYaD8ZbYahKHwpjeNRHIM4TXseqT8dqaESsvy4tZVuv6?=
 =?us-ascii?Q?zqktIBy7JbJwuRg3NQgtRi14tI9bPafAse2qfzE4awuZvYo4Z4CX0GFsrooG?=
 =?us-ascii?Q?nsM/3N0aPILc7EPqCd0z05QpKHIDGEkY7pXhfDtLlu5MswXeoDWmFTd16tj1?=
 =?us-ascii?Q?zMVzk4e3/zOJ63gnwccGBNu4/XyMYr5OSpS+RiMbXVUriygQaJSo2PkMzeN3?=
 =?us-ascii?Q?XU+EIvsfLmuU+4sRLc1ZBm4v+5wxttSecv//QwWcl0tGLEpk0TmfT1gM1NxU?=
 =?us-ascii?Q?muzRoAKqTItmYeqwz0GBA/edaU3bMmeEMOzXXCYQUdi9W0p/R1KRLVLk8T5c?=
 =?us-ascii?Q?395yh11xz8t9l+Vw9TjJrn9by4o0jGXX9lF3yxtc7U3Y7PFJbG3ni+CVz3CR?=
 =?us-ascii?Q?1TU+xDAICFRsGDr8Jfh21+SR+eatk1zOXQ2+69UHJRC9RBF3EAeNQjS48CJc?=
 =?us-ascii?Q?M+xO0jzlITINpjDW6JRZWwb2ydHSpLJG78kbRBzraLWqwctDmIJILcDJyz3k?=
 =?us-ascii?Q?1EbdZ29ef6XL86zS0XGvjI1mZ+8buU/3dTOFSl3GYgZpMV2I3n9tiBc8cKAu?=
 =?us-ascii?Q?HaIGn6KI24f18RY/KNUaDPZQ9GapQlNFKvHTvAEWvfcwERsCOtRBC8UFhfkq?=
 =?us-ascii?Q?BPQh0Tm5PRLPD2S4iQQgrObT9XXHWbZt0MDd0Vpi3nDvPyoWSYkYt/o96OQ+?=
 =?us-ascii?Q?tz35wl6XuV6uC/hrw5HcNAzJvDxSqFipCB7Eto2wDyRo48/Vi/mXIrkR4dHl?=
 =?us-ascii?Q?4l5NOOk9UAezKYzLxTc3niWFiivb2XzF7Dy5gNwwKMj83zlps/gwB5cSj0oE?=
 =?us-ascii?Q?c9ns9zYAe8H9Dy1vtZnWhcu5slyhhpwB1x1LkZ6z69kTWw+CWinznY39KHwK?=
 =?us-ascii?Q?HK2SCytkTbJW4GrqOlNwWd5Ghuv7gEPap6UTYjdtZ3ZUPo2hGSElebmnb1Vb?=
 =?us-ascii?Q?+JDgcDuSgFyL22Ltww/Fou0Q8EVLyfbu52vK+IuJCEkBshjOimuO5BF1hV2t?=
 =?us-ascii?Q?VC5MeSxK/KDc2uf7BAHdcsePD8kWttIZP5OW/cYh1iNvP1c32oYRP/hshJU4?=
 =?us-ascii?Q?EP72GKLOlc0JPyq06dVQHAAPJoIeig24ZnNz5VwoW9mMvPzpc8mRpem00H9I?=
 =?us-ascii?Q?jWeY12AJZKVPvYKFkZxDtBo9B5afiRBnODSlry6K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5a9a89-4f16-4a38-271f-08de171f0e15
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:08.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw7rnv9XUZmiLwtt2f7wJXl3U5Bq90XtzRnmy0syPloEPoBZF7e+cEluFp0Qa1/8TR0tu0tk9xJobwENjs4FCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

From: Joel Fernandes <joelagnelf@nvidia.com>

Since we are adding more servers, make dl_server_update_idle_time()
accept a server argument rather than a specific server.

v2: - rename rq_dl_server to dl_server (Peter Zijlstra)

Acked-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 16 ++++++++--------
 kernel/sched/fair.c     |  2 +-
 kernel/sched/idle.c     |  2 +-
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8aff1aba7b8a9..6ecfaaa1f912d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1543,26 +1543,26 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the dl_server, avoiding a penalty for the rt
  * scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p,
+			       struct sched_dl_entity *dl_server)
 {
 	s64 delta_exec;
 
-	if (!rq->fair_server.dl_defer)
+	if (!dl_server->dl_defer)
 		return;
 
 	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
+	if (dl_server->runtime < 0)
 		return;
 
 	delta_exec = rq_clock_task(rq) - p->se.exec_start;
 	if (delta_exec < 0)
 		return;
 
-	rq->fair_server.runtime -= delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
+	dl_server->runtime -= delta_exec;
+	if (dl_server->runtime < 0) {
+		dl_server->dl_defer_running = 0;
+		dl_server->runtime = 0;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2554055c1ba13..562cdd253678a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6999,7 +6999,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+			dl_server_update_idle_time(rq, rq->curr, &rq->fair_server);
 		dl_server_start(&rq->fair_server);
 	}
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7fa0b593bcff7..60a19ea9bdbb7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -454,7 +454,7 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	dl_server_update_idle_time(rq, prev, &rq->fair_server);
 	scx_update_idle(rq, false, true);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a0bf38dc71e9..eaae470841dea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -412,7 +412,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
+		    struct task_struct *p,
+		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.51.2


