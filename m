Return-Path: <linux-kselftest+bounces-40441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF2B3E650
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8571A85666
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AE2F0690;
	Mon,  1 Sep 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EUxjjY9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012014.outbound.protection.outlook.com [52.101.126.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9233CEB4;
	Mon,  1 Sep 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734996; cv=fail; b=nXY/R+hV7T4Ob068wUl7OQnpBSzf0+G+tTuYnG5J8zpARmBtwdVogHyk6ZNaYq3/ank3E8S/CFwgLDeC2uvhryCnHwUFn/uuXXVBESTQalibv/D2FfWlD6dW726+4Bqm0Z9RflClx9Jvs8h6V4dRl3IB1Q0Yfg0lKvCcu+tNdEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734996; c=relaxed/simple;
	bh=C8yROGxDQfHgBrnplT7Y0YtfGyb26G17Ien1qNFEFpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IY7gR2WTriJ1lyvANHIB53EbrWhk83Jo0QdVVSVqAnnNaTqvk0CBiSI+zN2X/iclt5zbHlYq2/72uLRQ/WnaAVOqV4atmeDvT1h3wbtfU3ZGH3XNsTQbybG/ZnkcjpmHvcZ313JOyyuoV1TAIF6SHIpM5hU2qvqQLcEQo4UgjsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EUxjjY9Q; arc=fail smtp.client-ip=52.101.126.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+r+3tETn3LZf1NVDSAX+RYw9aWKu06XLZ3XWwGOwcCXb3WG4M2zt8Ken3Gy5YuGa9O/Um0wNToDNj5cG/s76sMgMlHrtloRNHV04Q5PmF0zfa8DhOHu9FmQteAjVqvLFMouTGXgHbbdU2rcMG+BeNvh7Y7VPk22YxPzn5TeR0KpGWqhqCr9yt64Hzr2sU6PG2ymuk3ojvtiWTWVMdkDKkhDM5PAe3uhPxW6IyTS4eX3+fknNvc3Ebq4KIz480sOc+svvAEVfcWzsIltpaMy3aUhqc7OhpDku1lcY7J4bbfWlpcf4185gFIIdpXSfYjrVZXPRQRxS+NCDbY5gvZQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlNKsb78EJJhA2PlaFYieGHxgFKgfz1Fv/n9CUYr9o4=;
 b=Ij3HGOd4CyNY/N+fMOfsQ6jxpAslZx5NEv+qu9XSDGUGFsnyaDmQv29/urWB4rqrIHhm9wAEqoyRFQKaCF6SufNXleoBQ7hUbAOq6imPGIMu0nLMdddTIuo7e8Qjma30H9Q5RgMCrp7vnsAUWVOaZDGfvK/mLA5PlfTeqFr0uLQ8sPW6xYmyWjD6STzwOi9blAGerMqbwmg4E/C6tYL2S03ThkSBNzTPqWdgcpVeRDMUoSLW8JUPetSEa7jX6BbRxutJBPKvOnbTygZct/3Izd8E4CnfjaTWNJTmJRhVS/qZkJDU5TJlNAo7nlZyzbSOt+NCLrfdw+63R+yF0Rhy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlNKsb78EJJhA2PlaFYieGHxgFKgfz1Fv/n9CUYr9o4=;
 b=EUxjjY9QWeW9ui62ORUYAfeTLgoh58qJBw67IEBJHHuTc48KX8DJzhMyTaOw1P4EZmdPwDUFBs+Vg28qSGbp3yw03xjxt45C/Vza8V81q4HuFnam2KGpaAEPDkvjoGdoEcheKSmPNVHUUycIkRjNdN7z8IkRTYuibPgb6Eqek/Dygs1WQmHLgCn1gc4RUCAlf/KwDrwKNP7p36AlfFQN4gm66st9Bq+Rsg7sUmZcdxwh6vMptBC0oAG81kUJL50yu+IQsVN1WloNw7eEfFxwSuj9zexn8iRTfOvXTgCCHcVjcS5/pu6N1MWOj6IDCRhInEVS+XRuqqwL1DOt5tGCYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TY0PR06MB5732.apcprd06.prod.outlook.com (2603:1096:400:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 13:56:31 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:56:31 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: Christian Loehle <christian.loehle@arm.com>,
	Song Liu <song@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lin Yikai <yikai.lin@vivo.com>
Cc: zhaofuyu@vivo.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpuidle_gov_ext
Date: Mon,  1 Sep 2025 21:56:09 +0800
Message-ID: <20250901135609.76590-3-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901135609.76590-1-yikai.lin@vivo.com>
References: <20250901135609.76590-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|TY0PR06MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4973c966-84f1-4688-abbb-08dde95f5adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Qfu+ueh03BjuD5EvXnzyupVjrDFvQI9Sdt3mjVe1q5zFRE4+hDTIU+h6gsJ?=
 =?us-ascii?Q?JY2LBGlFYOrinv2CxEyt+xzRXHSrxQc0z9OuatvoN63gIY1vUVYwjOeE4mV9?=
 =?us-ascii?Q?Lp/eQW7T9X2LunaJdJY6IxQsvbS+1YAox7+xp6of4kYnB7OEKOfQNSLjRIYW?=
 =?us-ascii?Q?W/F6tFoARYMu2ZKPEolfHBEVJEOubTQyQP065doTtpsQ2BvW3RnwLSXeYLvG?=
 =?us-ascii?Q?oRtF2LqR3d9Q9RCnvXvkbcil+D6TilHTYl3uYXrgQMpB3GaGZndrWIdRhFZy?=
 =?us-ascii?Q?JIU4BI0GIKPBKVze3Gw6+KD1vgCd39yy92GfaW1iBUeYsCYxphxjtsLsermh?=
 =?us-ascii?Q?geWfhzRg29lfnPyTSsPmTisTBGzPCM115FM+VopEgfx+VmGKS0E87VVQTjJQ?=
 =?us-ascii?Q?16Jogldfwv60mS9BYhlcbBBejxG64S1dKOnE9dkmfG7u81ObqLOk5WiIxRds?=
 =?us-ascii?Q?jDjtt6Il6xcZtDeRjAqlAJ/xg09l8uFh25wKCaLA+ECwdShpTt2QxA7nHSAR?=
 =?us-ascii?Q?u0nRuda00PztXyHSY4/rFrWT1N4f3WE2faDnFeaALhsU7s8U8sm7dbCi4Ry2?=
 =?us-ascii?Q?k+EKotmL9I5YHS0QpW9RekDBjxCU4U6TGzNhs2qJ5UiqnyuDNpUIJv7nvOh0?=
 =?us-ascii?Q?CENcoedFpuAVSovy2Xpqdu93jMPCYeAc+Md8XsnFdpBvToLS7zawOCD0ZhI6?=
 =?us-ascii?Q?U+b2X61DLeFRJBKtjka70ryyLsMiMRpGo9sXbB2eBhKOswmVZFAk/fKsYyZM?=
 =?us-ascii?Q?XNjK0TfaHNfZW89dK8bQ54fxaXkA0TuficS4i69iv4gEu/HYKopwJFE+OI7U?=
 =?us-ascii?Q?wvP+y2bZw4DxVm1ClmXr84uszvvyXftnsnYAJjpZdvjBsgg6VUDaMzVe+4VD?=
 =?us-ascii?Q?GP7tBDmQ5dYVYfsjH7EAAkGqyw6tA5X6Ak7KLIvUtqctsFv03Ttz8Cw+YBaW?=
 =?us-ascii?Q?VO/o8LJ5WmBiDF7PUKZAi6jG8I07uC0d67+gaGxmgGN579tH+2G7QQGSOI+b?=
 =?us-ascii?Q?1HMh+Zyl74EF9zyR1mvtsSWY7IMby0fiPG5YTZhHgxHBy3lLjAT2lZYKpZJm?=
 =?us-ascii?Q?CTVWQsiNLw2AnTd3pBp5uRPSFyPjnqyF+e1kED3WaG5nNUueHlPm5lal4kEm?=
 =?us-ascii?Q?JRmUfYROOzgyjosWg8ebQtjxAZHi8QslyLwKoJaxqCDK6ILzYUSy+GimxM+r?=
 =?us-ascii?Q?S58MI8lbQAd8nL0jFHOJ8oFvUKYpKWT1kyNNMqU41c55r3UxiMJDBxlufwty?=
 =?us-ascii?Q?j2myZ2faEhMxq1bVvnOY75wi+tu1xilPiaE0j2vllN1PsYAP84Kkrkcr0oDK?=
 =?us-ascii?Q?RlypbjGLIsIwqCK5Q8z9xyaw0VCx85oiBmVl5yiFRMtIYuYRtaAa+jWO5Hue?=
 =?us-ascii?Q?PzSvkKU3VzX7IUSQKdaMxWq5s6O6OTgZr7NtHVjftK83lWAqmUonXX16BG2J?=
 =?us-ascii?Q?kpYiRc/0xQvi8SM1EV0l2dk45iSbbxhvP4fGt2YDorY9XzxbDmWVgJ4LIKc1?=
 =?us-ascii?Q?z9i6UsQoX7NR12k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nR05uqoDqy1oFhoKq9EDHw05GFpt1nbQAYlXf6Ryp7iQGhf28m6v1TPIFznv?=
 =?us-ascii?Q?9f9zrESCRAX4IqJKWE0ejE8sQDXCheLBqHqvCyC8ckcLO4blxNKLt5eWljzR?=
 =?us-ascii?Q?NYQlqB14qiWOaoIEsXImmkGjqVJFKmUCKbcdRJvcBLuWq3/HtnLGIBHyFZCK?=
 =?us-ascii?Q?S0dUA1+VfLbasU+sPnTLJpH+qTNeiJObE4+qrOgl1xtlHE3yjWRvVwzr57kB?=
 =?us-ascii?Q?avuYte1Cb4dzQRGAOgR/J6Tykj74m7l9yWcH4f5lu9+slGOAgW3aLodiqs7S?=
 =?us-ascii?Q?jxG0Mccv5+eqnuZibTw7fvYapJwM0TuG/9CRkjrvmqYxZd6gs+hex/3rlCjC?=
 =?us-ascii?Q?TZwLjpVsdJtBhsligDx56OmhrLOKxPfmP7SVLNR+WilUKbkqQ7kHd0GGTHcq?=
 =?us-ascii?Q?CtPj9xFPP2B6aFRIB2BjoUPntEdvU1OIL710Orz/NSES7cwLbu2NBH5gnADx?=
 =?us-ascii?Q?drtGdPSZD8Zq1XWHB4Ta2amRIv+3/dDS/wx2SPxkHltywcfTTe8b5pp5kmoA?=
 =?us-ascii?Q?ZFEEaiivf+Xqt0OcA9SgQdV19tDoZ1BZUzBNpWWh9Gz1sF0zNA3myqL6SPnV?=
 =?us-ascii?Q?viaUB3hi3t45ZGtXZIc4o8cHm/Q2efaG0lRL4lLh0LedufbgDX9C2md10MCV?=
 =?us-ascii?Q?uRxKWSDLVCdEJ+vWUR73M7wTVGjLZ9tid+MvC/vgbQI8XjG+bJ24rIdZDal3?=
 =?us-ascii?Q?pE6BpNMaL8uPbG5L7SYrWITGjprqH4ZGszz4dzPZaLxYeANYpRWOpwOo79PL?=
 =?us-ascii?Q?NYoJQkY43+1LdZPfigwcskKJgi+TUABbib6khsPEnV9VjDJEfHWTMlY4W8/Q?=
 =?us-ascii?Q?9b5FuAjR7sGwpmdeAFtFwtxz8MlarmtNEffR+xqmcosW3neiwbWCJmBtToVI?=
 =?us-ascii?Q?xwPLzKP4PcEZ+nsXkemLcgdScEw+neO1xHSPUIoR5k7//ozPN3HRWjGrzSZb?=
 =?us-ascii?Q?fnyGfjedIQKDHHRRLZM+1Lc814zB2DQP1M7Y04yVqm+LXlB+5RE1eoC5M2Xj?=
 =?us-ascii?Q?PPAdYY2I423fHZlqMUu2FdiWptG9Eey+rLVrvuuvyvBlzr+JLlgDWY9lsLlu?=
 =?us-ascii?Q?QWP7roPdIZlQX9lF5hPRjCRsXp86jZfLsO0DwgMnlNkz0quXgdoQmpwbdF72?=
 =?us-ascii?Q?REcS9xpkCOb/n37nQIGK8uUpnpwEfaedXGf07ns+fZJb1orFqJVyMnDYsXf8?=
 =?us-ascii?Q?lDI6Es6SKWcTIoVMSVXkkuAeyHOcgI1KvLemICu4MgzldwBVPFiDhly0BUh8?=
 =?us-ascii?Q?+NBQK5KiVpiv+yklQQfH/4iDY1jzd3FpHwsVrhq+hk0nawq00VwhpOuD8qdL?=
 =?us-ascii?Q?G5s59J31KsbYj4wTr65v2CJd6qTQEWT9GSGrjLDDpOqEZ8/RwPGc2kBRyYJG?=
 =?us-ascii?Q?Gq6lNpILm+3HJxax1gSvnJis4Z9+R/Lp5IWWXSRFktd9wtMjFHRQNgPd9if+?=
 =?us-ascii?Q?0BWPjld8TaI+CsYn1knsh32cXB8K8nkVf+EPjf+MWEMNRKLY1NJuv9G8Oz79?=
 =?us-ascii?Q?3ku/2MHt67uiawdDG8WT253bG8shH2rFK8eMSvWOSnHJ7CHZy8wDhWmSftm6?=
 =?us-ascii?Q?fD26Q+jNrtK+AOcw61Mh97GEhIkUGq/oJvWGU5Dl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973c966-84f1-4688-abbb-08dde95f5adf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:56:31.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHuRTO08ivstcOVlbvrB+kd0FhocGIBq+nnAEE2sglwiCtd7H+MNUn5ZdSZ7UtDEtEaZCDmmvbvE6hEZQqLGRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5732

Add test to verify cpuidle governor ext's load, attach, and kfuncs.

This patch also provides a simple demonstration of `cpuidle_gov_ext_ops` usage:
- In `ops.init()`, we set the "rating" value to 60 - significantly exceeding other governors' ratings - to activate `cpuidle_gov_ext`.
- For specific scenarios (e.g., screen-off music playback on mobile devices), we can enable "expect_deeper" to transition to deeper idle states.

This implementation serves as a foundation, not a final solution.
We can explore further exploration of cpuidle strategies optimized for various usage scenarios.

Test Results
-----------
:~/workplace/bpf/x86/submit/bpf_next/tools/testing/selftests/bpf$ make -j4

:$ sudo ./test_progs -t test_cpuidle_gov_ext      
#449     test_cpuidle_gov_ext: OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Additionally, the kernel log shows:
$sudo cat /dev/kmsg
6,911,10997439785,-; cpuidle: using governor ext
6,913,11010384887,-; cpuidle: using governor menu
After `cpuidle_gov_ext` exits, the system will restore the previous governor.

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 .../bpf/prog_tests/test_cpuidle_gov_ext.c     |  28 +++
 .../selftests/bpf/progs/cpuidle_common.h      |  13 ++
 .../selftests/bpf/progs/cpuidle_gov_ext.c     | 200 ++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpuidle_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c b/tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
new file mode 100644
index 000000000000..8b35771ada44
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * test_cpuidle_gov_ext.c - test cpuidle governor ext's load, attach and kfuncs
+ *
+ * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
+ */
+
+#include <test_progs.h>
+#include "cpuidle_gov_ext.skel.h"
+
+void test_test_cpuidle_gov_ext(void)
+{
+	struct cpuidle_gov_ext *skel;
+	int err;
+
+	skel = cpuidle_gov_ext__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cpuidle_gov_ext__open_and_load"))
+		return;
+
+	skel->bss->expect_deeper = 1;
+	err = cpuidle_gov_ext__attach(skel);
+	if (!ASSERT_OK(err, "cpuidle_gov_ext__attach"))
+		goto cleanup;
+
+cleanup:
+	cpuidle_gov_ext__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/cpuidle_common.h b/tools/testing/selftests/bpf/progs/cpuidle_common.h
new file mode 100644
index 000000000000..95402974c53e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpuidle_common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
+ */
+
+#ifndef _CPUIDLE_COMMON_H
+#define _CPUIDLE_COMMON_H
+
+int bpf_cpuidle_ext_gov_update_rating(unsigned int rating) __ksym __weak;
+s64 bpf_cpuidle_ext_gov_latency_req(unsigned int cpu) __ksym __weak;
+s64 bpf_tick_nohz_get_sleep_length(void) __ksym __weak;
+
+#endif /* _CPUIDLE_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c b/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
new file mode 100644
index 000000000000..66c437243270
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cpuidle_gov_ext.c - test to use cpuidle governor ext by bpf
+ *
+ * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
+ */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_misc.h"
+#include "cpuidle_common.h"
+
+char LICENSE[] SEC("license") = "GPL";
+
+#define ALPHA 10
+#define ALPHA_SCALE 100
+#define FIT_FACTOR 90
+
+#ifndef max
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#endif
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
+/*
+ * For some low-power scenarios,
+ * such as the screen off scenario of mobile devices
+ * (which will be determined by the user-space BPF program),
+ * we aim to choose a deeper state
+ * At this point, we will somewhat disregard the impact on CPU performance.
+ */
+int expect_deeper = 0;
+
+struct cpuidle_gov_data {
+	int cpu;
+	int last_idx;
+	u64 last_pred;
+	u64 last_duration;
+	u64 next_pred;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct cpuidle_gov_data);
+} cpuidle_gov_data_map SEC(".maps");
+
+static u64 calculate_ewma(u64 last, u64 new, u32 alpha, u32 alpha_scale)
+{
+	return (alpha * new + (alpha_scale - alpha) * last) / alpha_scale;
+}
+
+static void update_predict_duration(struct cpuidle_gov_data *data,
+			struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	int idx;
+	struct cpuidle_state target;
+
+	if (!data || !drv || !dev)
+		return;
+	idx = data->last_idx;
+	data->last_duration = dev->last_residency_ns;
+	if (idx > 0) {
+		bpf_core_read(&target, sizeof(target), &drv->states[idx]);
+		if (data->last_duration > target.exit_latency)
+			data->last_duration -= target.exit_latency;
+	}
+	data->last_pred = data->next_pred;
+	data->next_pred = calculate_ewma(data->next_pred,
+		data->last_duration, ALPHA, ALPHA_SCALE);
+}
+
+/* Enable the cpuidle governor */
+SEC("struct_ops.s/enable")
+int BPF_PROG(bpf_cpuidle_enable, struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	u32 key = 0;
+	struct cpuidle_gov_data *data;
+
+	bpf_printk("cpuidle_gov_ext: enabled");
+	data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
+	if (!data)
+		return 0;
+
+	__builtin_memset(data, 0, sizeof(struct cpuidle_gov_data));
+	data->cpu = dev->cpu;
+	return 0;
+}
+
+/* Disable the cpuidle governor */
+SEC("struct_ops.s/disable")
+void BPF_PROG(bpf_cpuidle_disable, struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	bpf_printk("cpuidle_gov_ext: disabled");
+}
+
+/* Select the next idle state */
+SEC("struct_ops.s/select")
+int BPF_PROG(bpf_cpuidle_select, struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	u32 key = 0;
+	s64 delta, latency_req, residency_ns;
+	int i;
+	unsigned long long disable;
+	struct cpuidle_gov_data *data;
+	struct cpuidle_state *cs;
+
+	data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
+	if (!data) {
+		bpf_printk("cpuidle_gov_ext: [%s] cpuidle_gov_data_map is NULL\n", __func__);
+		return 0;
+	}
+	latency_req = bpf_cpuidle_ext_gov_latency_req(dev->cpu);
+	delta = bpf_tick_nohz_get_sleep_length();
+
+	update_predict_duration(data, drv, dev);
+	for (i = ARRAY_SIZE(drv->states)-1; i > 0; i--) {
+		if (i >= drv->state_count)
+			continue;
+		cs = &drv->states[i];
+		disable = dev->states_usage[i].disable;
+		if (disable)
+			continue;
+		if (latency_req < cs->exit_latency_ns)
+			continue;
+
+		if (delta < cs->target_residency_ns)
+			continue;
+
+		if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < cs->target_residency_ns)
+			continue;
+
+		break;
+	}
+	residency_ns = drv->states[i].target_residency_ns;
+	if (expect_deeper &&
+		i <= drv->state_count-2 &&
+		!dev->states_usage[i+1].disable &&
+		data->last_pred >= residency_ns &&
+		data->next_pred < residency_ns &&
+		data->next_pred / FIT_FACTOR * ALPHA_SCALE >= residency_ns &&
+		data->next_pred / FIT_FACTOR * ALPHA_SCALE >= data->last_duration &&
+		delta > residency_ns) {
+		i++;
+	}
+
+	return i;
+}
+
+//enable or disable scheduling tick after selecting cpuidle state
+SEC("struct_ops.s/set_stop_tick")
+bool BPF_PROG(bpf_cpuidle_set_stop_tick)
+{
+	return false;
+}
+
+/* Reflect function called after entering an idle state */
+SEC("struct_ops.s/reflect")
+void BPF_PROG(bpf_cpuidle_reflect, struct cpuidle_device *dev, int index)
+{
+	u32 key = 0;
+	struct cpuidle_gov_data *data;
+
+	data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
+	if (!data) {
+		bpf_printk("cpuidle_gov_ext: [%s] cpuidle_gov_data_map is NULL\n", __func__);
+		return;
+	}
+	data->last_idx = index;
+}
+
+/* Initialize the BPF cpuidle governor */
+SEC("struct_ops.s/init")
+int BPF_PROG(bpf_cpuidle_init)
+{
+	return bpf_cpuidle_ext_gov_update_rating(60);
+}
+
+/* Cleanup after the BPF cpuidle governor */
+SEC("struct_ops.s/exit")
+void BPF_PROG(bpf_cpuidle_exit) { }
+
+/* Struct_ops linkage for cpuidle governor */
+SEC(".struct_ops.link")
+struct cpuidle_gov_ext_ops ops = {
+	.enable  = (void *)bpf_cpuidle_enable,
+	.disable = (void *)bpf_cpuidle_disable,
+	.select  = (void *)bpf_cpuidle_select,
+	.set_stop_tick = (void *)bpf_cpuidle_set_stop_tick,
+	.reflect = (void *)bpf_cpuidle_reflect,
+	.init	= (void *)bpf_cpuidle_init,
+	.exit	= (void *)bpf_cpuidle_exit,
+	.name	= "BPF_cpuidle_gov"
+};
-- 
2.43.0


