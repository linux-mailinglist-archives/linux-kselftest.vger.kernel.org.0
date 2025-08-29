Return-Path: <linux-kselftest+bounces-40268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FDB3B85E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC12040A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DF30ACFA;
	Fri, 29 Aug 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Qe8PDQiY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013002.outbound.protection.outlook.com [40.107.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF1309DC0;
	Fri, 29 Aug 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462322; cv=fail; b=RhVjT4rCTDFXPqU3kLEuZnVWr1ouumU+xHbzT253ZxZlgc4dPi3YwUDOcCT4qTTR6UaupgmXiwtgJvlzI01AoPIGXSJUubDeNql/GeC/LtvXAGkvZg86gGkhF0g5g8iIX8hVebuD+w88bvToU+b+r7n78WMeIoGxU3i9ASduu4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462322; c=relaxed/simple;
	bh=SYtyr+Qzqc/idkP+yrorvaFG8QioD8WDcn13swIpGqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5G4N9rgJUB4zHhRoIC+ArVwbAIra4/zICJOGDBbltZP8+VsYLfvagL0bgcfQfX5FWBWmbArcY6Np6sjpcvYz+Gja6J6sJf2iyveC0bSyqweuf6ckS2/AaOdB7VQvrfUpDGO0SjqIYF/OPd69nK8Sd3JNl8pj+RbJY8anlKixL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Qe8PDQiY; arc=fail smtp.client-ip=40.107.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3sBvMj/nQyYbILP1wVfPc8B7xZMAsT1eqzXN0QwtvJdKp2529ayjK9T+YSgb4n0yWUbCQnljGLYixTatGUsJnLLbFzXYfDNoPy7VYhWQXmWJxu8t4v/qVe83kDGIwnY7V5AEPUuyFU484pZWFYXOz02nTsplAOnPdTWtA2WvJ/I6lJSYb0vTNYY3QMX92OJlTDlUTKbCjHY/J29oqLmxyPxMAzRYa09iCz8C0CL87/IMFgninoz2CsJV0TmE275kDVUCUxXK6d9jU1R53diWExtmd4bNurvKBJH0GNneGKOQaLpibPxVxYv4uhyOqO8gYfqh/mtzyizf/fYHdTGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ykWLYf24ZDz+qNM32g8wekdn77URpwO6+3W/tti5lY=;
 b=uXv98xYHqQmjPUBSuEYRGGJQbKy1KMIDmbIrWgHevsTE1KBCtGD8dugDDrSACQPaIErG95G9nO1BAQU2v+fNYHoxuunUhOxMoW2oCCh6KI8LSJPpGEw7Tquov0jqS7uLV+fjWPSAWwflMqetsNSV9SSRyBcFxdmIVyRxqu7F112n3rSSvxm70WE5l6OvPjI2MZJkxZ9TPH4wN9QB4Hf/c07oUbXYvLycJDw6Nw5iy331sFXwOkRpWn2Bo+01us6tOq8A9YI5cclhynalznR9absuJluOfPDt+TS8D1B0RJcsoo6JwrxpZCrY/2/YC6YLWb/C45mSTBC3/pAJTe+AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ykWLYf24ZDz+qNM32g8wekdn77URpwO6+3W/tti5lY=;
 b=Qe8PDQiY8Rudwj2AhEuJFPuM8nct2dyVjbfJcba+sN1wA/Ih5nS34HuP9pr7VjJe3lYjBwXIAhdakLgO9EVQZHg5Qm1RhjvX2SivAUDIvbL3/+5rNZRb2dxt2jNx0RgwlqUVj8zWrShDf51nQ/LXzBGU4wZh0E9+ndE8LYX4aiVcoYXYxi+A7xUkTo9PicZRdsmObEx0b/ge4KI/VbQeuCYrMl6hXawdfWdCFyJGEpcnKtVf5eipR/I/f7h2703bXPps4Vp1kJ2bOa/Ou94dxM6fepqb8x/KDsHGyWUgubsAgP7WHoS+q/Be5g4xhjkYlvtcjyKNSGn3iWJRa8k3Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TYZPR06MB6565.apcprd06.prod.outlook.com (2603:1096:400:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 10:11:55 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 10:11:55 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
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
Subject: [PATCH v1 2/2] selftests/bpf: Add selftests
Date: Fri, 29 Aug 2025 18:11:37 +0800
Message-ID: <20250829101137.9507-3-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829101137.9507-1-yikai.lin@vivo.com>
References: <20250829101137.9507-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|TYZPR06MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5a434f-ceab-48d3-5bbe-08dde6e47b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?64CvJhcc5eXpr46Y6Z9SulVQhz0citCRaySMrZkKicM+EFs8qKtOppyIGCrS?=
 =?us-ascii?Q?R9nzQHhqDdthEaqoHVCdYT4935u0l45+ciSxlqBjCZIOsn9ZGMfoog1JX4HQ?=
 =?us-ascii?Q?1sXqcoTXXHx2/Vddr3BgJTapQhQ3Kzz6u9J5axTzw9LQB0EObOJ1nluZKHiq?=
 =?us-ascii?Q?4+Ct6GinKJ4wRjtbGFr7AyqAXfUtL/EynLwqt1KNa/bFCZsooIJlEti9er78?=
 =?us-ascii?Q?YbAOkh53fBEYqq9d0qxjYq1zzvBpNDU8msCDlrp4PKKt8IIwZDtyDStpWbI/?=
 =?us-ascii?Q?b2G7jp3MRCakhtuK8drurCydxw17T9LpzepGilH+MWdNTTqdUFaxYeoSkOsK?=
 =?us-ascii?Q?jiLWf6XhrGbDNQvfssGtoyyEMypDgi7FghUfqAgAYUzVftnxM4Ksi8TtW15u?=
 =?us-ascii?Q?LeQJfNOst/lUbJuN+xBPQ5HZnNHtH2KLzf7YhvgMTWjtFp/FMsGw6REh28BS?=
 =?us-ascii?Q?h8HS/Bp7Ygyipr4GeMyp/MUwXQehJrf2MzheE7udXz+lbYcdHJZ6raKwQsGu?=
 =?us-ascii?Q?Ejoq4rth5Fz5U0+NI1VyCsQnXTF+TlHfb/vrJyDEnRMw53xJHERy8u/+eS1o?=
 =?us-ascii?Q?MrzhPtu9+j5M12rmgIWDiimArdXrb6jaA/wBdGfY3gOhYiJcDtO9l2sp+Ogx?=
 =?us-ascii?Q?KfDaV0EsOllM/evO0iKMUrQAEt3amTNFIP1mZsTy8qjiEDQDMdv9/F3ZCTEo?=
 =?us-ascii?Q?DivxX1A3JmGHKFw/Wjz3yPmpPL81Vw9Ivi/DW9hpYJl7wX+STo+dm3jiG67+?=
 =?us-ascii?Q?IqttlBpk1Zozcg84liY4zY1lbFraa6y69oA8dUHWKHA6bf3MfUVt73jRRCYV?=
 =?us-ascii?Q?a5diiNCJXBYZWbT7L/Y7rohfu4DKJxisGCPS4bBU1TdSFVtq3ugGJ01c3ld6?=
 =?us-ascii?Q?15EdoKhlrKACROoUANgcoBhAMp5P8u0bpjOxe5FuP8/qx07PYtWYr4neu+vB?=
 =?us-ascii?Q?8M+20VPnX+bz9jKxauxxRBJhTLjmu9JvRY3hlEF7iVV2kczo2dgm06JvmndW?=
 =?us-ascii?Q?j0DFTJSbT9IHVxb9puY0lcUx/gAfGVcXOdN3bW7/XURevGqdNREUYWS5K8a2?=
 =?us-ascii?Q?63TUihaf7BAKZMVcok5fUIaZqwVD0ONJJvofGzqOkuHgMD3Bd6cVog5O5WaY?=
 =?us-ascii?Q?7lU+rNBvTBYyWe7uYlmjttEDCNTcvOQw87Gd6piZd9J0cDjqDTBblV2nh8uQ?=
 =?us-ascii?Q?vOXcXNe2lmHlKAazsHdONN4GUgOmIakj+yfH9fKxnW2+BhM6+5e6wNfE5mz5?=
 =?us-ascii?Q?TkdEJb/kvWL2ndMpz9Smt1iCVJxmDr5XOFj0aVMV+rTUMSxes8zzcAAEfgJ7?=
 =?us-ascii?Q?aQ70MKP48GglaSW3uDw86abMUUwezV8cXnMu3pmYZPM5yUPk8CDbRdn6U0gA?=
 =?us-ascii?Q?iGd/bw0u03EYtSIvqLWBKijWI6iM+zkuCPCxLhJqnbBQ2qZTGh6JM4d5qHsx?=
 =?us-ascii?Q?Axan8smdj/kndeI8WgmvZpN+KKm4ijpJDDvH9HRaf8SiPq5JuJr5gyIOa+E9?=
 =?us-ascii?Q?/9dYnCAC3gC3wUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rb/yvVCvt9gpyt7OuIzCu6zRQ8zsJomKuP9butnoOoT/y3lnIzcgdJhxj8px?=
 =?us-ascii?Q?xWIQTUomdBzQD7mcMKpKHho3LZYvq3j1IQpQZnuGJwH1mh7SRovn9aAspiYs?=
 =?us-ascii?Q?LaZIvYlOrWfCYFEhtJBtDEyHJz1SiI3PnrkpP5Cgg+sTlROAfgEa4goAXdaT?=
 =?us-ascii?Q?4AQBGntmJeCY00bsDxo3PfSgkdMm9fNY/Lu+YLqsK82viVyI/2AuhLGN/pAe?=
 =?us-ascii?Q?vYvzB0YSR/qRbopWzKf9Zx/oputDVJBJipwmJpLurCynJCMqZnRrpS+QHX1P?=
 =?us-ascii?Q?FuCdDaaRRwJFhGpvSA5cIVfW6rD4/7q+C5EUAcMJPt2yXfi16fIfurMQ57Dd?=
 =?us-ascii?Q?wIvBwSqeRZio7irjHHrz21v+YSgzUsZX2mtdg7ZHuMgV3yPrpc7WgbqGTrEh?=
 =?us-ascii?Q?OPuXlvYJVuoBjDIa4rNlWP924FeMe/Lgjm1lIh+6+EKz6KFvQ50otFlhDw8V?=
 =?us-ascii?Q?h30SNsXi7NxXiH44t/hLsbkYe2HXXnYcmnLwvRcraNlWjD9vzRgdJcAywK1O?=
 =?us-ascii?Q?xIv6XcQ1SMRKUpGj/D6y8sSIcwAMPnRydMLT/b2vbL33Z+klrIae/K/3eae6?=
 =?us-ascii?Q?kO15782AMydHpDEDNrXOMj3WyEaNNUydKVsE/PwValG9efNXNcF2rC1zIISA?=
 =?us-ascii?Q?GvruRbCecxAqvWLMnTKR+9lagleHC/zpJ+exo7HRgJCpNFOdsza6I9Z2hriV?=
 =?us-ascii?Q?8IHHC7N05KKFvFEPZfmY7LHEz9Nql50dtIwKgmO7/qYFJKQeHkcDh67Eokjr?=
 =?us-ascii?Q?XTBF3Nomc4XD1/TLiHW21cC5pBUTUyks7Z4GYuUrvdEkWupDianlKBlNYN2u?=
 =?us-ascii?Q?QLtRUEJ7rq6BctvEldxafYFuoOXKjtNKR7QiTTnAwc6CrKo6UKYdf4CnoHsK?=
 =?us-ascii?Q?GJk+be2CE+jJ3sgeIic5R/KkD3IlzE6cl2445CP0JPitc91IsiFInGCZ0qPV?=
 =?us-ascii?Q?tHU2XvkdAkatM3/PznhkT9nXDI62qVsi6T8WJ5mH5kf1rdA8sle+Jj7jAcJh?=
 =?us-ascii?Q?opP4RM/l7G2EBS0J2wOFL1eoZvrZz0QUu2CSR2VN/ok08lCDJr1ZX50mPH4S?=
 =?us-ascii?Q?6+5foWRwSNon08mG8B6grzU61Ub+LrbWEFgUTRsITH8yNvaPIa8ZkLD8yonO?=
 =?us-ascii?Q?QpuA3mMFBTi1EpQlgVXGyn/+qInYNV8d2eZA/xh4eOH9a+IvkVawAH6ST5E0?=
 =?us-ascii?Q?4U+ViU9Hp5CP08gY7xZQ5PajIErvWsSjqV5Rywpv1uTORCL2o6tIrSR13Aj8?=
 =?us-ascii?Q?VFBb5j3TkRjJwgQPcKRQ1lFr09mPiNAUBuyiIYBGtNh8tc65lNDVZ5vwonxn?=
 =?us-ascii?Q?mm/LpJ+3OS8KuGdvzdtX8kvcg/2rA0O7V98HQatgI1QtePqUy6u51g90t0hJ?=
 =?us-ascii?Q?UqY5M2RtM13cTL58tCvlnuWKY9im2inoKa/6Ee+8jifGDZDWzxkpqGxOvenR?=
 =?us-ascii?Q?+IKkoXoR6jTsSzokqlKSSHHRf5aCyHLmxyQ0uui4JX3jH797ScDN+cCK6vae?=
 =?us-ascii?Q?+Y/xNTpxx1JodObCM1+zlxudKO1RYEjESevFPazZB9cesoB+L5mLo9Wl2fZn?=
 =?us-ascii?Q?es5F+/Ip32mV+MKNp8Ely8889zrB0E+lJczNtk1s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a434f-ceab-48d3-5bbe-08dde6e47b0f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:11:55.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S34hBMgrcNpA9Ryd3aQEzvnrB6vGTfZoBq024YUhX8UY+pCADHajQQ/4vyd85LfD2i/Mz7KCWaACQ+j38tOhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6565

Add test to verify cpuidle governor ext's load, attach, and kfuncs.

This patch also provides a simple demonstration of `cpuidle_gov_ext_ops` usage:
- In `ops.init()`, we set the "rating" value to 60 - significantly exceeding other governors' ratings - to activate `cpuidle_gov_ext`.
- For specific scenarios (e.g., screen-off music playback on mobile devices), we can enable "expect_deeper" to transition to deeper idle states.

This implementation serves as a foundation, not a final solution.
We can explore further exploration of cpuidle strategies optimized for various usage scenarios.

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 .../bpf/prog_tests/test_cpuidle_gov_ext.c     |  28 +++
 .../selftests/bpf/progs/cpuidle_gov_ext.c     | 208 ++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
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
diff --git a/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c b/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
new file mode 100644
index 000000000000..62d5a9bc8cb3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
@@ -0,0 +1,208 @@
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
+char LICENSE[] SEC("license") = "GPL";
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+#ifndef max
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#endif
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
+#define ALPHA 10
+#define ALPHA_SCALE 100
+#define FIT_FACTOR 90
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
+int bpf_cpuidle_ext_gov_update_rating(unsigned int rating) __ksym __weak;
+s64 bpf_cpuidle_ext_gov_latency_req(unsigned int cpu) __ksym __weak;
+s64 bpf_tick_nohz_get_sleep_length(void) __ksym __weak;
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
+	int i, selected;
+	unsigned long long disable = 0;
+	struct cpuidle_gov_data *data;
+	struct cpuidle_state cs;
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
+
+	for (i = ARRAY_SIZE(drv->states)-1; i > 0; i--) {
+		if (i > drv->state_count-1)
+			continue;
+		bpf_core_read(&cs, sizeof(cs), &drv->states[i]);
+		bpf_core_read(&disable, sizeof(disable), &dev->states_usage[i]);
+
+		if (disable)
+			continue;
+
+		if (latency_req < cs.exit_latency_ns)
+			continue;
+
+		if (delta < cs.target_residency_ns)
+			continue;
+
+		if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < cs.target_residency_ns)
+			continue;
+
+		break;
+	}
+	residency_ns = drv->states[i].target_residency_ns;
+	if (expect_deeper &&
+		i < drv->state_count - 1 &&
+		data->last_pred >= residency_ns &&
+		data->next_pred < residency_ns &&
+		data->next_pred / FIT_FACTOR * ALPHA_SCALE >= residency_ns &&
+		data->next_pred / FIT_FACTOR * ALPHA_SCALE >= data->last_duration &&
+		delta > residency_ns) {
+		i++;
+	}
+
+	selected = i;
+	return selected;
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
+	int ret = bpf_cpuidle_ext_gov_update_rating(60);
+	return ret;
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


