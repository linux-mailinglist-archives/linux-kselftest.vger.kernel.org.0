Return-Path: <linux-kselftest+bounces-47669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BADEDCC8BB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 17:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF5730A0987
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380A328B6C;
	Wed, 17 Dec 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eRtOx6UN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEE337113;
	Wed, 17 Dec 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987956; cv=fail; b=AJEM45psgtJXS2xbNj2VrOVIfF2n9v66Jmihg40GAyylHXBPa4XkSgnyGeAjYPnJH+v9fyswt5x1rCW+WKCSd3MD45GW5IOtktm3lFG+FUqYZEHya0fPnL5/gWGz8eZYSm4q/m1F32kGRYGcGP9XdlUZMxitL6fb2bZKgn+mecs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987956; c=relaxed/simple;
	bh=n86omlfVDr5NGOdqIU3p9hgCCgSUlN2AdCvKQDnA1EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDEtyK0DBZ5qK8Gk3fLaOv9C3scXTi8fYej6FGgE/oIN6mTbOlR3vbtl8Xs1+o5dM/AEIJ6cr9y4H1XLav6pgQAwQ0z666scHwNkHyWjsQf0tT35VkUilarJqlEKrAXWj0e4GqXJqpQfs44KG1VEmcbzAdyMvuw0gtrotlQ+Emw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eRtOx6UN; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5WxAstIFDQ5BWqdqIaIBmjt/x8Rh4t31e4ERnz4pSDzXg+uclu8MTw2swCnZEHSLF7sfIK3i8MzTPEf50bxVEY5sGJvUjLh3zXXFRhluy3MhSZWb9VU/m0GVwRo/9InFZX5mXevd2+SkH0LJk8/rE2VlP1eDPpfYvxxuVDO7B3xw1ItYnBh74AzB0PM6WvANYVQJ0l8exASt3FUy/Fq+KhYC+1wHd5u/rz1xbfWY41wKbXddHsC4b7szTXun5yg426TMSjRoaHgLHgubmZGv5VoC0e0HUwOGF2zPJhUx9lGNTPpcGuusXLw9EmrXwjzAaPXXyToyQ5UotsZO/TKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvHn0OqsDct1kPu3YlxzC2IxvwnaS8m9PLjrfPLC2+0=;
 b=FaSYavOHxRMHvKyxORtwIu6xl5ExS4LYu+wWOfKjyfr0bik/qj2mVJL3bZj7BgrafbcVq89L4WVA6po+IMV59yFptVNWXJu2mePkHrKiAm94XFhQL9dqTn810b/l0F43qYSpv7jekAddJbYhIyvZBquEF0bKJiWcayEBZ6+e+1K6+DEHzC0Ga7tMYdtwIYNNeXPzAzE9lF5/vczWVzD0t/ArlcYbQBSU2HOrHTCbQzg7z6Wh/zP4hk0HXiag+0U8rmQjRFUvk7VOhR0A+pYGEiWZzvHb8HCiNkn2MrMGLOujwt5weP6Xdk18gkE/vHgbPQzu518aFG1NXGRvLyv1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvHn0OqsDct1kPu3YlxzC2IxvwnaS8m9PLjrfPLC2+0=;
 b=eRtOx6UN0n9JQfxcNotBDncf/5ZEONad1aLFSv5N0iFvf3Vyf+zYwOuclQPhSffwER+aWBM1oZxhm7cdd+RWNiaD7P3td+zkpvWWq0SocgcotAakipwn4DXArm/q8KRYh0lNgXddI54PDjy7Ks0ev3Y/uY3FxxjjZ3cDMKwhAFGFFNSeNQOzAsjDbdFmT4oDgnM6M2VM9sU2qcL0Fy2NTME82Rs1xL+EOYQPabdPSHMQyVRJS/oeMHApQTLjdJaqRW7Dou1JanfVSuuNKs+A0gSgtCNG+aJmbP1/hQYD2obLOgo6n/DKFeX9it+7WzUinz/Hx9UTtwieZO2x8Ee5cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:39:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:39:55 +0000
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
Subject: [PATCH 3/7] sched/debug: Stop and start server based on if it was active
Date: Wed, 17 Dec 2025 10:35:41 +0100
Message-ID: <20251217093923.1556187-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 50219048-901b-4bb3-ccfe-08de3d503c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jOIqU942Myb4XQ7md8HsOd6aKNUdFT3Xb0RZbtq/GbSIK/SH6Qj+Hrfhxhxe?=
 =?us-ascii?Q?QVaUO7SvKy4gU5h5k3llHBUOblH2GySSVIWlT/QkT6Npi33NrhWr68kvkiK7?=
 =?us-ascii?Q?3hMPI2lWup0xYidYWCEkN4Pv0+mQw4J5jpSZk6Puf79M11o3m3+y7FI+HMc8?=
 =?us-ascii?Q?n8vR6MULK90bcrx7CCoR81trWozXaRP/ayuovL5ntSvTsTdOQCtO9opdq9N/?=
 =?us-ascii?Q?87b3ci5/7Y/XbiPSoEEyrbGTJgEXZ/DdluMp2cEYiD/BlnG4/5BbiyY0Jd7v?=
 =?us-ascii?Q?9MeKVjUwQ4P55gVdjyuPiOiDObB4P6eisl4YajdA2GDni2YV785QNhhyiOKq?=
 =?us-ascii?Q?5RiaXp2UgNtFhv5Bfq4mK91m9qC5CcIv1r10DawOSrQgbl4pObBMfhYpbQud?=
 =?us-ascii?Q?l9qVbf08niddXsDOtQmQaH+c4ybYCGnLUsdhbVjEOf4f591vn64Liq4sfQFO?=
 =?us-ascii?Q?L5c7E5FYSS7qb9beE6Cedv5eDdiH+VRehqXa7t7YIC7aCsAufajYIWDiuFyM?=
 =?us-ascii?Q?aIzxKDQEWeD9X746d/eFRLQwtbEPPLzrgXqp+3trAo11K0Rb8nOcGL4JfNqH?=
 =?us-ascii?Q?dQMrLuXNfKgvXoMoEuUazMGCUJd8hq5V/P3kBKf48YnSgXK7gFm8+DgDk+nL?=
 =?us-ascii?Q?qwmy4WuNlyaGXSw2A3rm6iGQwjfKETuboPkFu6CZqba593cfq8c8OpGQ1gRL?=
 =?us-ascii?Q?UOvtNyBJZf0l2/MFZMt2VzXh7ZL8PY1zglNrMM4mqqpD1EUPyHvgO8eG/YCd?=
 =?us-ascii?Q?w64zsHo8OnRwiMGPVu3Wk0WucwLKQpFPBd+kRFNOOfg1uvFt69s46iYA5kam?=
 =?us-ascii?Q?XhwvTdazUebiSErf81Ue4TjndXmaHeMyadcYkykzsO+Sht8dUL96xvOYE58l?=
 =?us-ascii?Q?zLjybiUcbMRd5FtvmflVRE0MEijjM0yMHj4DCrxhWUq4inmyv0UuOY5U0l5p?=
 =?us-ascii?Q?QnlQhJOuUZT5S4Y6jt2TMSdk3PNiBgb9boUy+Nsscfs8uZA57WVHya8s7GDf?=
 =?us-ascii?Q?hJvyax/iRTwl14cjH4xpg3ttKdgBgATTluMWzHqoJuGlMaRQX3ohfeFuImpp?=
 =?us-ascii?Q?vZfxotvSWFH5Zjch6KlnqR2xY0BLoU7nntZIJCGU8/8u5LJI5y+fmQx1aZRx?=
 =?us-ascii?Q?haVCEw4aOiqCKlaT9Tr8C7s18gk/+ShFzMNNc1YQ3Of8Q2VTCf8QL7Zz/rcT?=
 =?us-ascii?Q?t+bBWA82eYegR6edX11ApLePQaXEi3c5LSY/GHMauBO7kBZxqW7sOOTPJoHk?=
 =?us-ascii?Q?L8QzKozVN5Ico9PYabTWUoGBqvqtP3Zj7zwFv/fRP2QTq9Y5GR+BZFfuJ6PV?=
 =?us-ascii?Q?UU9OzCrXXNkPjLEn8Rsjf4G8A6jsW9ZHPQSzI8pYVDuCOYJWHIaSrj8a/2X4?=
 =?us-ascii?Q?uPZ5Zwl5cn/iE1LuQ2xlQCmzZ5jj03jyuDhWd4LFNRXU5jgxWK2Cf2la3p7q?=
 =?us-ascii?Q?LIxR0+EONLxKX+P/eBMzeXR1GhswqGvD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0h8k55ELLjPpSr9X9VMlWqqBcJdkJ+W852NqzKbyduLsUqDbd+XsJXh+H1pW?=
 =?us-ascii?Q?9NHYbdVx1vYrw2Pg2XAGg0dAVecVRKw/Lcd5Iv5ustGT2s5zsK1gRJLMU1Z7?=
 =?us-ascii?Q?7OE21a9djq/nHM6pbR+GHTRJCFXdL3Js1wp537r51ARGyk01E+HRPSW6puDy?=
 =?us-ascii?Q?Lr//1EdKAoCB39iU0OhKpgJdXtYN8w6F2npNCXQfdY1Sm/PDTTDfZZ203XLF?=
 =?us-ascii?Q?IJhfKFIjUWtg/a5EDJDkFDxlxBpM7ub6eJFb27sck5i0zcWQAS9IWfJewI5F?=
 =?us-ascii?Q?IS5u9Wm76QCpKiJJF+olssLlKpk1R+xdkFtTU+KcT89C+GUMPw+NCHNwkueP?=
 =?us-ascii?Q?iccF/+9aiPr2Hr8U0w+zc/85B0ocUrRsX15NcBTMCVROLQ4N2pyvRUeRv9pI?=
 =?us-ascii?Q?UAlDIvHGkQYtTp8RPJsFlcVwWuquCH/hy28PkIMBBqVLgIxOdgEYl4idHzw1?=
 =?us-ascii?Q?BIiB5kIORk6oDaQTGmOSNbUFBFbXi/ACtYvNKYJRo9rkLEPg8He1v3nPAlSG?=
 =?us-ascii?Q?BD2M4DD7+MXzUZ0ynqfNMNaEfGlBjXdomuP7ZReDcT/uiCwDCaLO1hE8N6Bt?=
 =?us-ascii?Q?DOB0imx9TK9Fhvc9BLSEf9KG6ppSbrVOyM/QuN+mbefOpMEDzABQ7oPtEZuG?=
 =?us-ascii?Q?5F0AGr6noDKZw3jp8H57+1lFMEhmDYcPn5ZmiuhsKjRvHji2v1hDK4Zx9Ive?=
 =?us-ascii?Q?hQs1AsFfJOQAiUbbQbSI9IV4RolzTb2pw3Z+vQzdkBaO5TY9aIWk4OKuXVz/?=
 =?us-ascii?Q?8VFIjAsEnKiuODWPxM6opmdHvIN1Aa6Puts9xLDF0tLkGMqaH6Trz5//d66f?=
 =?us-ascii?Q?wa/b8HGUfEbTy3wtYhewVH+hdc1RztAABP0cv513St5oKltjDH9e9SXIbUbP?=
 =?us-ascii?Q?05g7PSz6sH6GLGeaj90PhIDVZdeVyrRFUMu1HQp5bawlCU74pFqXY6d1fwzJ?=
 =?us-ascii?Q?rnKdBvf6ywBg3UWDS2HFLXEiANZBE6FdrdtS7qSxd/4pdPT88zz+2S50ZynS?=
 =?us-ascii?Q?ljckYhUR62RfWYaI+2o8vF8jvzI13OdfriJSMfKh9KIP+6UvTORB8Ydcys8a?=
 =?us-ascii?Q?UaCrKs4C+3gjtPfqOko9x8ocG8iNQfu3c+2DiRi/GAJ+TpNrgvdtE9QiqBco?=
 =?us-ascii?Q?CC2EPUf8XPGZ4Q6qsAkvH6uWpWELkx34byjYm7d7ceLbCkY1bxIhCxciiy9q?=
 =?us-ascii?Q?GlspgL4UNLVQ9CxSRCQNMQJlCjR0sA7AMQw9ruT/5jLSVb3asSfuGg9O9FHp?=
 =?us-ascii?Q?JqKgjxh7kpvMC5i/HwXzeRZfXY7yy8mI1PnVqQCv1dMYyS6Hp8hThXbtB7AW?=
 =?us-ascii?Q?zcnw16Q582G13JLYu8mrsXNho2pKF9ycDcN17WTjpeM6W0rYWOv1nmKa175w?=
 =?us-ascii?Q?F/CxzIAKPKCSj7Z4SIIMo41wTz25CClQLaeAlJ/tuvyW5zlyKyjCxU2EfrEE?=
 =?us-ascii?Q?pi9oGwoWKuKEVLLBV+S8D0qmqzaVE9ytLyyGdWh0cl0ALqaZ1CgAIpZy8dOm?=
 =?us-ascii?Q?rcHKUDe5BWsKuOAmOIbJVWUXNNACwPkzajIDaZ4nVwHWaPNCP7VL/ms8hyZ+?=
 =?us-ascii?Q?zweOpozH6fkMj4h1cT0to090LOUOyJW2+C4H0CKX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50219048-901b-4bb3-ccfe-08de3d503c64
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:39:55.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJOUMwXYLHCdUJ+jo98m3zWNf5gdSqJVb30J9g12CDtecqDkjXN7sysZjFn0U9MLZ7J0BPYSdoOak8ZCZFiMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

v2: do not start the server if runtime is zero (Juri Lelli)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 93f009e1076d8..dd793f8f3858a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		update_rq_clock(rq);
-		dl_server_stop(&rq->fair_server);
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 
@@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active && runtime)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.52.0


