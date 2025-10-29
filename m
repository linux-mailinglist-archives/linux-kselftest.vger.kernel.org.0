Return-Path: <linux-kselftest+bounces-44345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF1C1CF00
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CD34C58F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C84359717;
	Wed, 29 Oct 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXKupHo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6C3590A5;
	Wed, 29 Oct 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765115; cv=fail; b=OYy7K/C22xIjdVIi2OeBaAs4xqZCTeGDvAGDUtr7smfKX1IvD876+PfGg/fMJygFb0Pl0nOUAu90+qT4ClcELeSr/DKs0aTM+CgLiPVHhyS2VxZgGEyrfxEaM7LUARaNKy4nMku1kg0wrxFwQuv4dhQ8cXW1q0GDEeHrESDT9BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765115; c=relaxed/simple;
	bh=/8JVHFxPrVNGpwTET89nvXZKVXatJyncY7tJLUH9Ceg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2c7AWYSGK/oXanfWT9oEr1eI0325iCYPQKhafGXZL3etghhj0/nrREXpVHDsnMYftG2ADPo9nuO2ZCu3UWj4zVWAg6zgBcaalEBtCk36T/o/q6tECtZdCChA6KqyEUgFb2N9ebdN6tZwKf3xk9m3Dt98GciR6fofFIB2DutO9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXKupHo2; arc=fail smtp.client-ip=52.101.48.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIx30X3S7EfQ3v/t5PCW/kmljFKsT8PbsdvEa1DsjjimBNbCYiEkrHGlEFRR0cVtzP9/8UG9GRwNpLwciI6djak5WUngViJkGAp2pC6cwcIddYZRpe72qO5CwIhKdwDkjK1jI9di5jyDZ67HGiFRin4cT6bj9uFlFx7OQcEIg5HXM7YfqBt7m1pE2jR/z9+u4wcO274QhGotUnFFmffo0hD6finS4J5ZKkm5LavQUHHpFKuSFLvH0j4FJS/mPonazQs30FbXSVwWxgznlNEAMTaO53m5ZvHF16QsRih7wkK3D75+w5JRDmXXG1xlfUAvjI/yT3XxJx5+Lk4at/Flyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lznFlDIYQex98PIAx+NjKIXFbemjK8GIqWx96b/fd4=;
 b=VgPUM3WuDxo5qn0oStnu2wOpMewv1rQFvcoxFNT6KBp/lQ7IKxgN5G9h2FAFInhjPjQMaSQjE6MoHkY6wpcS6S3VPifhskD2Rsyj+ClL15OtsjEjfB1ST5lvGjw+hyZdSk4tLLL2nw4tqI/hpi3DD6cVtNX8J+CddjTsl5jjYkWnn7NrBNPD/F6I/gZAFN0QDH6RqwiIsWNEMd0XQIfL0xq+VRBzTasudTeaDWMfkjRnh/eVEJywo8mg2+uxAZY0RY977Iih20MNfh9CoTTbOOwWGpiLBz/b+MKl64aDJHeKMKR0WASLHtuUuU8ai5Gr6ja4WYAKOqtORnUm0pA6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lznFlDIYQex98PIAx+NjKIXFbemjK8GIqWx96b/fd4=;
 b=XXKupHo22Jksd+AIkgFK/xC0I51lcjkpjSnAnFXIH95rywY6JnvKykesQqg1wvB5MTxenIO0id3b9Wa/WxYooBMp0pg0J0LWY4XTVDyaDBDXRWepWwvELr25COyXl4OLvVYbN6WvzwttWV5wEF3q1n7vwQv68bTWjSP8oq1InRQGW3+MeUggMiK8Z5Esx//XZB04ydXkniWxsK+crik7sWCHAuN+3qekBP3OMcUmkUB3Ba6Zz6tgyP/gLTWNDrUVHIaKHmKpjP31CWYan2Ws0w9cPEf30DPwTnV2FpcNSEXb8ni6rL0t6bFqQbyJmtyk9YaSvF3jfGkFb7goU621qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:11:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:11:51 +0000
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
Subject: [PATCH 03/11] sched/deadline: Clear the defer params
Date: Wed, 29 Oct 2025 20:08:40 +0100
Message-ID: <20251029191111.167537-4-arighi@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3423a994-4497-4aad-72d2-08de171f03ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjlYWHPNhVE//h82H3pFJ0KTV0zhDxZoznXfHTGXl3u9dEsQOef7hLOfPTHA?=
 =?us-ascii?Q?N5tmU5sWeednGp3qmyVqR+DHX13S9H7xgwFFwOkF74Z5/qs2Oea8teia8Hyc?=
 =?us-ascii?Q?3tqSP4svZhZW9XQOTrhRZka+E8mX2piv7M8MV5z4MIQglPIucprdnYuWeyuK?=
 =?us-ascii?Q?f4WfAv4mcpuXZBvHDO7OWhxm014G9sF8JslC/7N62ynr7J7/SY9cZUzVTeDW?=
 =?us-ascii?Q?WcUkcX7E9QUhbaDJslANt9pkPn2e3aQfdxjeqi4/TNofEj7/XRprOlTsGuYv?=
 =?us-ascii?Q?B3cB2F05AGanhnKC6l2VEmoLW6qiYldlOQ3/yJyniIMNUn+vnHeGXEFUiyBQ?=
 =?us-ascii?Q?cKRtPp7K38IYc70P5xqeGcXGsuTSWd/uwSy/J9S1Vw86Mo+5tBkAlvwRITWA?=
 =?us-ascii?Q?W4Mq3krCixUWTmE6kJowQvSUV+tcKmu5xy+FSXwWYXjE3nvaiTRTVO6YUrD1?=
 =?us-ascii?Q?fgO9Q2bV00AW083ylqlW1UfB+8BpqtRvV6M6v9kOtOjFandPCtyiyA3ycxry?=
 =?us-ascii?Q?HbHaOTVAyWOSj5XfLpJRhGdotwEGvc0306oONI5IRUyEFPNM1kBJXBXeu305?=
 =?us-ascii?Q?6TYy9XUDjoqaq+W4sRbdNsaSsreFUKu3pVVHONaSOGL++wJkRuLf9QEPAg3B?=
 =?us-ascii?Q?B4VNdbCRYwcoSf3aD1NnQJSoZybvH5Zy/NirBs3UXJDAJ0/IoH64LrARi3y5?=
 =?us-ascii?Q?m6OURYThsgaFgr3hRTtV/DcbD6036pvoRFYdlhV/yUXkiLYH5CeQT60j5r1G?=
 =?us-ascii?Q?Wehu6/FXrWExgOhjdrcHPWb+eutlq7lOsbzxdgWauLt8/F8dxAMMqs07oM1N?=
 =?us-ascii?Q?DB/ZJ2iz/FcRi1h6pZIF8p/uUz+71X+la+97aH6oqBKiAJ96GgCXg7PsdJl2?=
 =?us-ascii?Q?VC4R6g6jayRoTcJrDIux2QwTHIBuVlVpue/bdY3Ide6RlcQoLUZksvy1dreA?=
 =?us-ascii?Q?44EjqwX1ih3kmgFfoL8u7ukJ6bSkjb6vLLWSHZhq6Bdcx67k2LeiMx1mDvm3?=
 =?us-ascii?Q?TWPNKKP51tt0iAdHVvsMqlKOWTx5H+HWxdWEyT2l5F6ozoqpZXBxdLt9YNaj?=
 =?us-ascii?Q?+VhfrHhAMiJLsqHZ5LrO/nIsZDMRhXWldpcw+DYRdPupQkQlrNztMgpqxKE+?=
 =?us-ascii?Q?7KuIbBRZH7Kv/upnqnM2iK4+K9UrksHqhWbBe9UHgb+//oN5jSDRhF9Mp9fL?=
 =?us-ascii?Q?mJ9QxKyr4RlMRBp/9g+U3vLkAYQ/8Q9Kc/o29C3rgZ91a5wA4Dz5jx08PSiJ?=
 =?us-ascii?Q?XcJzbdW8F7SOnlZGCKDYrTl22xXG53prE8+zDXC/L/Iaik8zZCNcFP42klU1?=
 =?us-ascii?Q?3m8Hfg31vXdZ5bQbQLs78JznIS+7VWFxKixjajhyl9pq7YmaxNLwdVAeFdeT?=
 =?us-ascii?Q?eazF0eP04cXBuhWQuvBXLcBmDktQulMc/XNYf1dvyuGuxPERWSLEouUrMdxb?=
 =?us-ascii?Q?L0Ms75fGDTErGSAvunrXHnKckr6dKCwV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b2DT1bhp7a6lCs2mnhtCs6y8oB7xiHdFyA74GBtIycgahhcKGhMezsFfJcvj?=
 =?us-ascii?Q?FooC/UoWfr0e9yxqGIWAgHVac8s2XeqFbr0EGsW4REy1QnpNUWeEP1MAdA13?=
 =?us-ascii?Q?loxrs8EYFHMzdM1sG9qHHX1/d7Aw0Msuj+MdhbrUT43iNC6Z3e7XY8aHklHH?=
 =?us-ascii?Q?nN5BKWweVDj3ZE7o7+HmWQ6qIlego/3ObnciQehrbg3hrF6jjQj+vjeGSddw?=
 =?us-ascii?Q?YTUhFuDYlH9y52/43zq5N5cannbelEAzWVINi00T5Gt86tTPzPqQEcPDaAMN?=
 =?us-ascii?Q?vVUHvQF3FiEblFiz0KJoUz4mmMIi3ozDsi3FTuEHdTKyEa87fz0NC91Cmluv?=
 =?us-ascii?Q?AW5H0QRtYdybmb4pQ3EUsyk0Hs8wCgmvBTUtxYPVfdcMJOUi/9m0I6VJShI/?=
 =?us-ascii?Q?fP4ZCYzIsuVhd340xVdNVC/OqqgtoHLwQGGp88NSIbnQ8CrOYyEs+eYrifW5?=
 =?us-ascii?Q?8yZVkLmVG8+ZX8oESUgHKRSIt3UZYJGo6GT4QffcuzicNqOBD/NcVjWNduwL?=
 =?us-ascii?Q?Fp869TibelvHwzzQ1M9GnOocTMMBJ1js9kg3uu1yU+Xf+grYgXesOA6S8LOC?=
 =?us-ascii?Q?nUsiqqnP5lrOTka+XHqDK5gORXXNghcjH/9Mky56RjGEYICgYlmnbdsItoxQ?=
 =?us-ascii?Q?czW8omAWPEsMmtfd8ojUnljnTJ51PdpvYyGkj+c1SGEncYT9OoY5p0bFrm2w?=
 =?us-ascii?Q?uyJrvWsa6LEzGhz9WHn6X22b72zqUq9azn8bBxY8DzYvTeSf0rLlZbfj9ylM?=
 =?us-ascii?Q?iPVJEsBJ2Bc5BtOfMhD6JQqlya9idSb45ljooTfilc2RtFzDCGYwG0PGDDc6?=
 =?us-ascii?Q?jV3zwhjcEysz/rEHBHnE3IToWgzYVxtxwPsMDYBbNmLsy3An/nW3Sr8f0a/n?=
 =?us-ascii?Q?ETPpGqh9/lkd316aQ9LfBaR4MRemZajf2khPJVZsC3SV+FRand3r3yDQV3EQ?=
 =?us-ascii?Q?bEgLvKwTVSkMp7xOuoj0ADRavvRZq0AV05LWdnbI9wn4yaHVN+RKMa5vNDbS?=
 =?us-ascii?Q?EwUTtOYMtEqRkrVju/i9y5i7emzDBEnz81dIUWB3EK1a9Fsk8OisYgAAYx66?=
 =?us-ascii?Q?l1YfYuE5CLXjrtBxrSfUcFDEAoLgagKDDuXu6Mu7sJ7WpL8BowOGKTmC1wQr?=
 =?us-ascii?Q?qu++hv60by4mq4yOpL1cvK5SaEIhfiJuioDNO9a7Kgz6G0fI6lOykv1FUn2a?=
 =?us-ascii?Q?hlbNYZXlyLq302PYj6A77uAy8GTzMadZ4El9UmqyjuwjmKcogOL1s7h46w1S?=
 =?us-ascii?Q?NYZUmL+O+GC43zz5pBw9N/Q84lXu6N4Tyg/TGmJGDDHZq7HSE2RKh3+KqbPr?=
 =?us-ascii?Q?pyQySWxR7WpU+sdg2VKVH7kqlkwbZUpf9kdaY19h1CxZYX86Y2ExYNegptLo?=
 =?us-ascii?Q?2FzoMsPhS15MiZr0hAphT9SsjirJdm5FDnyaFJrz4pAKn51PdF+6Qnr5e1XO?=
 =?us-ascii?Q?be7buObOqKXg9hqiV3VIvu/jWX4we9uVBMnkeB5jkGixKduepEpogcKEI+nu?=
 =?us-ascii?Q?wBoJsDHwekHPQu1FTPYKXGItu9vFlYAmNvrcSEl2wS1emzth26GdhkCnSG+o?=
 =?us-ascii?Q?4lE7RJ8+mNWWGzkPBHymFqkEPcnkugqdU1/MC3Eg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3423a994-4497-4aad-72d2-08de171f03ef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:11:51.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg2MXFkYY3q2oIaErqxzlC48V5vWfMzAM68YZnfWjewmCJWtxHMKo+P21sRbfj+KqgMeXNupqK+/ywkgX18Qfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

From: Joel Fernandes <joelagnelf@nvidia.com>

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 48357d4609bf9..4aefb34a1d38b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3387,6 +3387,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.51.2


