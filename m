Return-Path: <linux-kselftest+bounces-40267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE718B3B859
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1C27C0CCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B9308F1C;
	Fri, 29 Aug 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j/ONoSfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013002.outbound.protection.outlook.com [40.107.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EB3090C1;
	Fri, 29 Aug 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462319; cv=fail; b=sp9EvVEgfZ4ou+HMDQPWjDG9/enVjdKdlpio7nWkfRhVA0T3nSWQoBVkyPeDb8JT50/MXFlq4axtVssHkVR3p1c9JJSgwQDc+6+Uhv6VFnYJ8sfpXd2/H6twvo5mnxr5Y5oV8UGzeJHE5wFNaDP3esPkaIw7JFX5ipC3She+CAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462319; c=relaxed/simple;
	bh=jYZRO99VFgWsOVZuly1VJeYbejE08kgAz2UpX2BpViE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIDjW1foyN4U6TwrkS6FwbJdz52AVqOLqBAJioxIdFPRckzCkHPBAUxSmbUci6qaDCG3YdBpmkeJytm27ezIvFYnrh8I/pMcH8yWN+ZY018reZnRYKOv/XocbNQKv/54KCJCDv6beH2gHaKKLsblhF+WkEN0buBRtqxY/S0C+y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j/ONoSfd; arc=fail smtp.client-ip=40.107.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVYuVm3NS6MGTAiCRqh/kQhEM7Ord/t9ByLj1ubnqU7ZQwfpvIssIcPfnNu7A7dwYa78dz/HVUa/oqFrqhvfThA0XEC6Ca+fKfObDW0wfaDtPgW09FnbQowjcE857kyonENgeLruC8gHDsb9DZ0QkwEsCyClpTs2EtsWeB+EYgzB8xKBwYH8yKgm2uVg/L08ng/uPMcO7sxX8wnqWYRRrem1k56ZGZD6Cbr7CGy0+Rh4IJ4lVyP460LLihUubfhsYqFDg2x9uE4hRwU51UAHA59EN0B5vyEaBlgtBpPIfT8kvgFcRpvoOCj8qVSR/5somLvW74ZW7+YYUnUxjZIYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5etZ76d1BUzlxvyG1wog71EezMBHH4fxYGOvl0nOgsI=;
 b=A1H8yReyVOZC27Pkw1oc5wSSOEHqwUE68FoegHtfCqH1mQX3g1BL5TcpGmo4G2NTNuw1Tw0pzZcCi16mlpUNLS/6eMdZoi1nyWAOBGD9g6Qtnz94g6DTgdfsKkspTIeGyQWDepnUt1rh1+I7VSS3E/Aydvx2UPugEXe5ohfsfmniXCWO347vBhDcpSk+/jWZJ1B8O6M5h2j2xzebdQUCe2Pb5U+6XroQyviv1yOq3dMntQtRYfhotTrhW/vWlbAgdxc2mtKlOgk5nn1KhTOJO8WOTuHeLeFtHhuqUkrCXjaWeFdbVywTFOjhAkIPyEe06+cp2dHrKVqz08vZ2XQLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5etZ76d1BUzlxvyG1wog71EezMBHH4fxYGOvl0nOgsI=;
 b=j/ONoSfdV9Yb506DSgRRbNxEimmV2Q+G727VnDrk98yvOqZl0AGqsT5iyijVvp8NrTx5azGwlbpwws6rsI+3trAAUWtSRluT5hgpZ7JK4DgqEYsqM/7KsoStOzqJrHHNDdj3SzsNjNhqGOm4BkM+dUzzMTRyNIGaUVXIxOZzQQv/ju3jPGmX9l2E5eeNxt7g/SWmbFas91I52T1uUO8zsW3YNFCYozj6DSzr+bO7nKujxlalteDGtiDKQct0GiE7+KIHY4hkxN0IHVSN+TJQ5GTPjv9akFp7tomQ/ZLngnG+4ZqIE7WslDQC/QsO+VJltRdU6kC9MVkO4jzvY2ed6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TYZPR06MB6565.apcprd06.prod.outlook.com (2603:1096:400:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 10:11:52 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 10:11:51 +0000
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
Subject: [PATCH v1 1/2] cpuidle: Implement BPF extensible cpuidle class
Date: Fri, 29 Aug 2025 18:11:36 +0800
Message-ID: <20250829101137.9507-2-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829101137.9507-1-yikai.lin@vivo.com>
References: <20250829101137.9507-1-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: 442e711b-fcd2-43f3-cfa4-08dde6e4792b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTloK2pGRFh6eFZCWUgwcm1CS3dyUzEzZGdYM0JaVGJvbzJWUTZubXpaeEts?=
 =?utf-8?B?SGp6MThJb0szc3o5U0E5WmFJOXBHdlJNVGRxMy9vYUZxWnN2QnJJZG8zNy9Z?=
 =?utf-8?B?dXd0SGE5ak4zSTJkNjZlaS9veUFNT2VVTXg1LytraTZqeFRIZ3MzekFFNCtN?=
 =?utf-8?B?MmVXUWp6UlNCdE1oN1VKM1B5c3kvc3p5ekNKb3FvN2xCQ0ZJRW50TWtjdzFT?=
 =?utf-8?B?d0RXSWxQNzhubTdLNHZYQkxqUnhTbXovN2ZheUpPdTIrOWRFOFJPQ1p2cU43?=
 =?utf-8?B?QWFBRGZhSjI5b05lMHMwSGRqU0FDSzRYdkFPZEhES0h3VmJRMEVZZFVldUpx?=
 =?utf-8?B?bDJiaGF6ZDFqTDZCb0FrK2VHb2k0azNXQlFnUGt6WlQ2S05EeGt1Ri9WYnEy?=
 =?utf-8?B?M3Boc296Si9wZ3VIU1dTdFdlZFMvV2FPYkJ1TkZCUTkyMmhvOTRKK2x6USsy?=
 =?utf-8?B?dDd1NU5aS0JjVEhpOE9TeGRXK1UvNXVSWUNiUzQyZlhTUHBoeHZ5TmZZZGIw?=
 =?utf-8?B?bWM5YytPU3RUaU5hVXNsbXBtZ0lnU3FxSFZJa2lpVjlqc1Y0ZTR4SnE4dk9w?=
 =?utf-8?B?TXQzSFVJOWlsYW4raUwxRzZuQmh6VWVtamRPNjUzd0ZOREJheEY0aU9KSGE2?=
 =?utf-8?B?T2QveTFTZm1CdGgxdTNkTmlwa3dyMzRFQW5SblNZU3k2bHZWVVdsYjV3TVpQ?=
 =?utf-8?B?eWlBZE1HRVFCZkxQeXRUTGhjaktzMU9Cb1E3eHl5cXpaUmpZVGs0UUtEVXEv?=
 =?utf-8?B?Vm4ydFN5dG9EWUR4NTh6b3lkTktzcHd0algvdEwvelZ2T28yMGlRaTVON0Y0?=
 =?utf-8?B?SnBqZmtjcHY5Yjk0RUtzTzgwNFFOeUFEb1BEa293WTBZN0FmZHNRNGlBZy9K?=
 =?utf-8?B?TVJxSWVkYnZNTmxjOGJmRUVlRlphckZpZXd2TEJkY1QrL0NqZTdKcUJ6R2NW?=
 =?utf-8?B?eXF4MnhIc0xmamRMdkJTNTNXUmk1MDVtRHhZSGY4RVFmOHJzVVp6cWNEMU9L?=
 =?utf-8?B?Y3Q3eXo0QlRkeDZ0NXJnNnpLb2c5ZTZ2VExKeGUwM0xTaTRsVldkcUJXNnRY?=
 =?utf-8?B?MEZNR0ZxN1ZLNVlQM1lHSFVBWGZBODdPZWRhcU5xMXFvQUZYY05GYytlb0RB?=
 =?utf-8?B?RkpkN2RhWWNpVFhpTDI0bDdNWXF0VTFRUU5OQlNrTmZQNjhFdGNYRkFpWUxv?=
 =?utf-8?B?RjhEWnVtSEwwdDNrYUZadGI3Z0ZzVjlRaFJsa1hIdGZsRXVyOGlPeXlrdkY2?=
 =?utf-8?B?MXVZMmxjcjlqVXRhelVvMmlYS09XOUxIR0FQaXRYaHBTRkIzMzdVMWw4NTVq?=
 =?utf-8?B?NjJzemYrV2RwZ3E4c3h0bG84WVBtRUEyL2FscCtzQWpvZmM4L0dvVENpWUlj?=
 =?utf-8?B?SDZ4TTczdTNTZEx6cXJGM0RzZVBaSHo1am1NT1hVSDFBbldNZHRxZ2lKOTEr?=
 =?utf-8?B?cUJJcDZ1S1cra3lPTytsOGc5WWZVQUxENDAyUGFuSWxJZ1VrUTFSdWlpNnRu?=
 =?utf-8?B?blBXd2plQWRCT21zQkx3YjJrTXhZZ01ydkVuU2NPMWdaMXh3L3poRjZaUmpp?=
 =?utf-8?B?R2tnbnJKSnM0TVhrQ1hVN2ZFaWRhN0FwTFFqVloxY25DSHRIVXdlMDVySlQw?=
 =?utf-8?B?aDR4SWZJTi8rb2VQU0Uzb3hXVXExeFdtVVc4YkdIVS90ZGRaaHhDdXZIV3JE?=
 =?utf-8?B?STBVc2RXTGk5MmtzQzhncEd6NHlSVVBpUDRJSGdGWUFncFJmcVExTzBjdVpQ?=
 =?utf-8?B?VVloVzVlQklodU9semcrczk4ZmdMdlpUTmJmWitxOXJINkFpckRoTThOUmFR?=
 =?utf-8?B?V1JBV0xVVjJxUjhnZHVHa2l6TzdJZ3JiTVFybE5ndEhGVGM1cXNQQ3ZQNWNU?=
 =?utf-8?B?QlFoUkNxZ3g2ZUt5b2xLV3kwNlRGVW1ZUEdETktQb0RIeTNoSUp2ZURoK2dI?=
 =?utf-8?B?V1VMR3h1SHZadlZwVGoxYWRkVm1ZYjViaUVIb09LUmRneVBHVG9nMUFyOFhT?=
 =?utf-8?Q?xnZG7aEnT9WUkfwVVAghib2IW+ReZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW9hbitsQXZ1bnJ2K2phQjFkelI4UXIrT2YzUFF6OFk0a0tPMWtndTdVRENH?=
 =?utf-8?B?K1NjSDcxWXhSd0o1bWxDY1ZDVVl4ZW5Rb21PVGFXaTdDMlRHbmFsaGZON1RX?=
 =?utf-8?B?YTVqM3dUUEV4cWcrVDh6d1V4cmMvczc4VFdtdEgzVjhKZVZ4YVNickcva0lR?=
 =?utf-8?B?SlJtUmN5R01Cc2JVNHk1c3lDek83MGNLK2J2Z3d5NW1GeTllVzhmZXVkU3VZ?=
 =?utf-8?B?SWNDVk9VZmFYU09HaXd0Y1hjWDdlWGZXMS84dHBhUFJFcUFteXMyKzVycTU1?=
 =?utf-8?B?c1ZZLzVUeVgxdDdBTW5wUW5SMURTREM3OHdMSzVneEJZNzFwcjdBTGY5ckJ6?=
 =?utf-8?B?anZrb3g3VTFxc2VCZWkzZkJNeS9TMFpMcy80RWxuMVJTWWNhOTdGNUpGNEhL?=
 =?utf-8?B?eDlCaVNDSmRxNGhSQmRwQys2Qy91VW1MdkRSem84cnFXVGJtbEtpSllrellW?=
 =?utf-8?B?NFMyeVhxOHRhV0dkbFNERmF2MmhNMndQOGRSTHBoTDM1MVNIOGpUcHpCUUJq?=
 =?utf-8?B?OFlEUXJsdURMKzVLdHpnNC8zV3FCdjhnc2l1b1loTld2K2t4RUZWd0g0T3d5?=
 =?utf-8?B?SWFwZ2hraGJGeDMxYjFzSGwrT2dKVDRGUE82cmNRRXczRW5DQVhFTGhtbEth?=
 =?utf-8?B?UUZKT3ZUUEpHMUN4N1pJaTY1YkdNQnlxNkRuYml0RG81UXVFanlueDhNRXAx?=
 =?utf-8?B?MG1wTnI3MUdHRFcxbEdqRWU3eWYrV0V0eldCSkMvQ0NreTVUcEs1RFltNWMx?=
 =?utf-8?B?MGR5aFkyMjF2amtEMWF5RHd6MUFZRHZ6VUpXVTJJWW5zUGNCUUEwaGpLRHhN?=
 =?utf-8?B?a2JMODhLWEw2T0dpYlJaNGoyU3NhdkhFMThzWE44ZUU0bnhLOTNNZnVOcUZk?=
 =?utf-8?B?WS8wSVRwRWE4VEZMU3lra2tJdzdUUFVpVmVRYjRWT0ZRVTY3dERvRk5vTGhq?=
 =?utf-8?B?V3dBSWZZWmdUc04xTHQyWm1VMWpNdEtkVVdqc0JHajF4VjdjU0VuTlE5ejgy?=
 =?utf-8?B?TjgyVjYzNDNDeVR5NG45c1FIWDVSVmNjZGlyTlpqSTZycUxBYWdobXh1bDZI?=
 =?utf-8?B?L0M0enpRSXRUL1k1Qk1kdHRqL1ZOTDhrcEZQalZmRklaMEpYdUI1eHQxRFRx?=
 =?utf-8?B?aFNDNm56aVBDOTN0bFJHTUtjckx6SnhvclYwUkFQSWlZc3ovcG8xZVRMOFUy?=
 =?utf-8?B?M2pqZUdqYzRqOWlkOFNGSkRBY1JxdWx4dklDdjgzU1VwMWQ0WEZ2YkJTVHZj?=
 =?utf-8?B?dGxBZlRoTC8zZFozeEFYcmQ0WTRHbURBUjBZMDFFQ3ZNVUJwTDJleSsyNmta?=
 =?utf-8?B?djhzQXNLaGdVOERHRlhUaFVxV3NmbXlWeTJ6OGNKUDBjY2pPKzIwdkQ1TFFT?=
 =?utf-8?B?WmY4Ri9sQ3V0Um1wcEZuZ2pSUnlmNERhTnFXdjhoTEVubVF2MXJGMUpYdVcr?=
 =?utf-8?B?RktFa1pUTkJGQnhuMFQ5dGhDU2NXd3VVTGlGZ0VvbjhYcHNBbVJmazI3cDVY?=
 =?utf-8?B?alRIMzJYek9JRlBFaEFrTlZrU1BxZFB0UzFpNWVMWHNycFptenVTYXdYMGFO?=
 =?utf-8?B?bGFlZHRvNDlMMm1saURYNUpNTW1LUzRxUVdzbUtPMjl2NWtmT2pmbGs4djBi?=
 =?utf-8?B?OGgxeVUzNWJNWlRPcVZvU2pHY3VyUDNramYreTl6Y011aU5LR0Y4L1hJQWZi?=
 =?utf-8?B?TUZQNFIzUzNjZEJDLzVUYjBGMXkwYzIwK1BiUUovOEVzaG1JOHVUUlhLRlh1?=
 =?utf-8?B?SGprTXhFMkhJcW9sYkYzSE44eDd6OW9mWERCclhJLzNQdFlteFEwdEVLeXk2?=
 =?utf-8?B?akwya3lIVHdqZTNwUUV2NjN1VTNFSTZLd0xZay9pL2diNnZqVE9oTXFOclRT?=
 =?utf-8?B?ZVhkajhlOXZoWjBXYzg5dUZ6RGh4L1A2ZVlWM21VVWQ5N25yL0U1TVNjN29O?=
 =?utf-8?B?MTNLV1ZMY0JraUNyV0hvVVk2K253aFJkL0NNT3duUHB2cnQxZXY2cmlRYXNZ?=
 =?utf-8?B?OTNUcEVWbkFqUmc2MW1yd1NPUUNCeTIrK3RGdzRIdkFuUFd4WUtkU1UwWENw?=
 =?utf-8?B?WjZReVJDeHloODFzanZxL3NycG9vdThvQ2Z4MElYRG9vcUxabE5SVTR5UW1y?=
 =?utf-8?Q?nmBesDBE+GLAOiB4h3kkibcYe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442e711b-fcd2-43f3-cfa4-08dde6e4792b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:11:51.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRACTeg3sSHzVnjQMBU6eorChHuGZglN4Z1uqfhgX1u0pMMR5vZbJYQ8/+3DTjfsAG+h6II5eGPD1VGYyiO8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6565

The BPF cpuidle ext governor registers at postcore_initcall()
but remains disabled by default due to its low priority "rating" (1).
Activation requires adjust higer "rating" than other governors within BPF.

Core Components:
1.**struct cpuidle_gov_ext_ops** – BPF-overridable operations:
- ops.enable()/ops.disable(): enable or disable callback
- ops.select(): cpu Idle-state selection logic
- ops.set_stop_tick(): Scheduler tick management after state selection
- ops.reflect(): feedback info about previous idle state.
- ops.init()/ops.deinit(): Initialization or cleanup.

2.**Critical kfuncs for kernel state access**:
- bpf_cpuidle_ext_gov_update_rating():
  Activate ext governor by raising rating must be called from "ops.init()"
- bpf_cpuidle_ext_gov_latency_req(): get idle-state latency constraints
- bpf_tick_nohz_get_sleep_length(): get CPU sleep duration in tickless mode

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 drivers/cpuidle/Kconfig            |  12 +
 drivers/cpuidle/governors/Makefile |   1 +
 drivers/cpuidle/governors/ext.c    | 537 +++++++++++++++++++++++++++++
 3 files changed, 550 insertions(+)
 create mode 100644 drivers/cpuidle/governors/ext.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index cac5997dca50..4f2eac531b0b 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -44,6 +44,18 @@ config CPU_IDLE_GOV_HALTPOLL
 
 	  Some virtualized workloads benefit from using it.
 
+config CPU_IDLE_GOV_EXT
+    bool "bpf cpuidle ext governor"
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	default y
+	help
+	  This governor implements a simple cpuidle ext governor,
+	  which can be customized by a BPF program without modifying
+	  kernel code.
+
+	  Some scenarios benefit where CPUidle policy needs
+	  to be customized based on user-space requirements.
+
 config DT_IDLE_STATES
 	bool
 
diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
index 63abb5393a4d..cd5eaf9f275f 100644
--- a/drivers/cpuidle/governors/Makefile
+++ b/drivers/cpuidle/governors/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
 obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
 obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
 obj-$(CONFIG_CPU_IDLE_GOV_HALTPOLL) += haltpoll.o
+obj-$(CONFIG_CPU_IDLE_GOV_EXT) += ext.o
diff --git a/drivers/cpuidle/governors/ext.c b/drivers/cpuidle/governors/ext.c
new file mode 100644
index 000000000000..9968ae482899
--- /dev/null
+++ b/drivers/cpuidle/governors/ext.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ext.c - the cpuidle ext governor used by BPF
+ *
+ * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/percpu.h>
+#include <linux/ktime.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/tick.h>
+
+#define EXT_GOV_NAME	"ext"
+
+/********************************************************************************
+ * Helpers that can be called from the BPF cpuidle gov.
+ */
+#include <linux/btf_ids.h>
+#include <linux/btf.h>
+
+#include "../cpuidle.h"
+
+static struct cpuidle_governor *cpuidle_last_governor;
+
+/**
+ * restore_cpuidle_last_governor - restore last governor after bpf ext gov exiting.
+ */
+static void restore_cpuidle_last_governor(void)
+{
+	bool enabled = false;
+
+	if (cpuidle_curr_governor)
+		enabled = !strncasecmp(cpuidle_curr_governor->name, EXT_GOV_NAME, CPUIDLE_NAME_LEN);
+
+	mutex_lock(&cpuidle_lock);
+	if (enabled && cpuidle_last_governor)
+		if (cpuidle_switch_governor(cpuidle_last_governor))
+			cpuidle_last_governor = NULL;
+	mutex_unlock(&cpuidle_lock);
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_cpuidle_ext_gov_update_rating - update rating of bpf cpuidle ext governor.
+ * @rating: target rating
+ *
+ * The BPF cpuidle ext governor is registered by default
+ * but remains inactive due to its default @rating being set to 1
+ * which is significantly lower than that of other governors.
+ *
+ * To activate it, adjust @rating to a higher value within the BPF program.
+ *
+ * This function should be called from ops.init().
+ */
+__bpf_kfunc int bpf_cpuidle_ext_gov_update_rating(unsigned int rating)
+{
+	int ret = -EINVAL;
+	struct cpuidle_governor *ext_gov;
+
+	ext_gov = cpuidle_find_governor(EXT_GOV_NAME);
+	if (!ext_gov) {
+		ret = -EEXIST;
+		goto clean_up;
+	}
+	mutex_lock(&cpuidle_lock);
+	if (!cpuidle_curr_governor || cpuidle_curr_governor->rating < rating) {
+		cpuidle_last_governor = cpuidle_curr_governor;
+		ret = cpuidle_switch_governor(ext_gov);
+	}
+	mutex_unlock(&cpuidle_lock);
+
+clean_up:
+	return ret;
+}
+
+/**
+ * bpf_cpuidle_ext_gov_latency_req - get target cpu's latency constraint
+ * @cpu: Target CPU
+ *
+ * The BPF program may require this info.
+ */
+__bpf_kfunc s64 bpf_cpuidle_ext_gov_latency_req(unsigned int cpu)
+{
+	return cpuidle_governor_latency_req(cpu);
+}
+
+/**
+ * bpf_tick_nohz_get_sleep_length - return the expected length of the current sleep
+ *
+ * The BPF program may require this info.
+ */
+__bpf_kfunc s64 bpf_tick_nohz_get_sleep_length(void)
+{
+	ktime_t delta_tick;
+
+	return (s64)tick_nohz_get_sleep_length(&delta_tick);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(cpuidle_ext_gov_kfuncs)
+BTF_ID_FLAGS(func, bpf_cpuidle_ext_gov_update_rating)
+BTF_ID_FLAGS(func, bpf_cpuidle_ext_gov_latency_req)
+BTF_ID_FLAGS(func, bpf_tick_nohz_get_sleep_length)
+BTF_KFUNCS_END(cpuidle_ext_gov_kfuncs)
+
+static const struct btf_kfunc_id_set cpuidle_ext_gov_kfuncs_set = {
+	.owner  = THIS_MODULE,
+	.set	= &cpuidle_ext_gov_kfuncs,
+};
+
+static int cpuidle_gov_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpuidle_ext_gov_kfuncs_set);
+}
+
+/********************************************************************************
+ * bpf_struct_ops plumbing.
+ */
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+
+#define CPUIDLE_GOV_EXT_NAME_LEN 128
+enum ops_enable_state {
+	OPS_ENABLED,
+	OPS_DISABLED,
+};
+
+static const struct btf_type *cpuidle_device_type;
+static u32 cpuidle_device_type_id;
+static struct cpuidle_gov_ext_ops *ops;
+
+static DEFINE_MUTEX(ops_mutex);
+DEFINE_STATIC_KEY_FALSE(ops_enabled_key);
+static atomic_t ops_enable_state_var = ATOMIC_INIT(OPS_DISABLED);
+
+struct cpuidle_gov_ext_ops {
+	/**
+	 * enable - cpuidle ext governor enable
+	 * @drv: cpuidle driver containing state data.
+	 * @dev: target cpu
+	 */
+	int (*enable)(struct cpuidle_driver *drv, struct cpuidle_device *dev);
+
+	/**
+	 * disable - cpuidle ext governor disable
+	 * @drv: cpuidle driver containing state data.
+	 * @dev: target cpu
+	 */
+	void (*disable)(struct cpuidle_driver *drv, struct cpuidle_device *dev);
+
+	/*
+	 * select - select the next cpu idle state to enter
+	 * @drv: cpuidle driver containing state data.
+	 * @dev: target cpu
+	 */
+	int (*select)(struct cpuidle_driver *drv, struct cpuidle_device *dev);
+
+	/*
+	 * set_stop_tick - whether or not to stop the scheduler tick
+	 * automatically called after selecting cpuidle state
+	 */
+	bool (*set_stop_tick)(void);
+
+	/*
+	 * reflect - Give the governor an opportunity to reflect on the outcome
+	 * @dev: target cpu
+	 * @index: last idle state which target cpu has entered
+	 */
+	void (*reflect)(struct cpuidle_device *dev, int index);
+
+	/**
+	 * init - Initialize the BPF cpuidle governor
+	 */
+	int (*init)(void);
+
+	/**
+	 * exit - Clean up after the BPF cpuidle governor
+	 */
+	void (*exit)(void);
+
+	/**
+	 * name - BPF cpuidle governor name
+	 */
+	char name[CPUIDLE_GOV_EXT_NAME_LEN];
+};
+
+static enum ops_enable_state get_ops_enable_state(void)
+{
+	return atomic_read(&ops_enable_state_var);
+}
+
+static enum ops_enable_state
+set_ops_enable_state(enum ops_enable_state to)
+{
+	return atomic_xchg(&ops_enable_state_var, to);
+}
+
+static int enable_stub(struct cpuidle_driver *drv, struct cpuidle_device *dev) { return 0; }
+static void disable_stub(struct cpuidle_driver *drv, struct cpuidle_device *dev) {}
+static int select_stub(struct cpuidle_driver *drv, struct cpuidle_device *dev) { return 0; }
+static bool set_stop_tick_stub(void) {return false; }
+static void reflect_stub(struct cpuidle_device *dev, int index) {}
+static int init_stub(void) { return 0; }
+static void exit_stub(void) {}
+
+static struct cpuidle_gov_ext_ops __bpf_ops_cpuidle_gov_ext_ops = {
+	.enable = enable_stub,
+	.disable = disable_stub,
+	.select = select_stub,
+	.set_stop_tick = set_stop_tick_stub,
+	.reflect = reflect_stub,
+	.init = init_stub,
+	.exit = exit_stub,
+};
+
+static int ext_btf_struct_access(struct bpf_verifier_log *log,
+					 const struct bpf_reg_state *reg, int off,
+					 int size)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t == cpuidle_device_type) {
+		for (int i = 0; i < CPUIDLE_STATE_MAX; i++) {
+			size_t base_offset = offsetof(struct cpuidle_device, states_usage[i]);
+
+			if (off >= base_offset + offsetof(struct cpuidle_state_usage, disable) &&
+				off + size <= base_offset + offsetofend(struct cpuidle_state_usage, disable)) {
+				return SCALAR_VALUE;
+			}
+		}
+	}
+
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops ops_verifier = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = btf_ctx_access,
+	.btf_struct_access = ext_btf_struct_access,
+};
+
+static void ops_disable(void)
+{
+	restore_cpuidle_last_governor();
+	WARN_ON_ONCE(set_ops_enable_state(OPS_DISABLED) != OPS_ENABLED);
+	static_branch_disable(&ops_enabled_key);
+	if (ops->exit)
+		ops->exit();
+	memset(&ops, 0, sizeof(ops));
+}
+
+static void ops_unreg(void *kdata, struct bpf_link *link)
+{
+	mutex_lock(&ops_mutex);
+	ops_disable();
+	mutex_unlock(&ops_mutex);
+}
+
+static int ops_reg(void *kdata, struct bpf_link *link)
+{
+	mutex_lock(&ops_mutex);
+	if (get_ops_enable_state() != OPS_DISABLED) {
+		mutex_unlock(&ops_mutex);
+		return -EEXIST;
+	}
+	/*
+	 * Set ops, call ops.init(), and set enable state flag
+	 */
+	ops = (struct cpuidle_gov_ext_ops *)kdata;
+	if (ops->init && ops->init()) {
+		ops_disable();
+		mutex_unlock(&ops_mutex);
+		return -EINVAL;
+	}
+	WARN_ON_ONCE(set_ops_enable_state(OPS_ENABLED) != OPS_DISABLED);
+	static_branch_enable(&ops_enabled_key);
+
+	mutex_unlock(&ops_mutex);
+	return 0;
+}
+
+static int ops_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct cpuidle_gov_ext_ops, enable):
+	case offsetof(struct cpuidle_gov_ext_ops, disable):
+	case offsetof(struct cpuidle_gov_ext_ops, select):
+	case offsetof(struct cpuidle_gov_ext_ops, set_stop_tick):
+	case offsetof(struct cpuidle_gov_ext_ops, reflect):
+	case offsetof(struct cpuidle_gov_ext_ops, init):
+	case offsetof(struct cpuidle_gov_ext_ops, exit):
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int ops_init_member(const struct btf_type *t,
+				const struct btf_member *member,
+				void *kdata, const void *udata)
+{
+	const struct cpuidle_gov_ext_ops *uops = udata;
+	struct cpuidle_gov_ext_ops *ops = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	int ret;
+
+	switch (moff) {
+	case offsetof(struct cpuidle_gov_ext_ops, name):
+		ret = bpf_obj_name_cpy(ops->name, uops->name,
+				sizeof(ops->name));
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	}
+	return 0;
+}
+
+static int ops_init(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "cpuidle_device", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	cpuidle_device_type = btf_type_by_id(btf, type_id);
+	cpuidle_device_type_id = type_id;
+
+	return 0;
+}
+
+static int ops_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	/*
+	 * Not support updating the actively-loaded BPF cpuidle governor
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int ops_validate(void *kdata)
+{
+	return 0;
+}
+
+static struct bpf_struct_ops bpf_cpuidle_gov_ext_ops = {
+	.verifier_ops = &ops_verifier,
+	.reg = ops_reg,
+	.unreg = ops_unreg,
+	.check_member = ops_check_member,
+	.init_member = ops_init_member,
+	.init = ops_init,
+	.update = ops_update,
+	.validate = ops_validate,
+	.name = "cpuidle_gov_ext_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_ops_cpuidle_gov_ext_ops
+};
+
+/********************************************************************************
+ * default cpuidle ext governor implementations
+ */
+#define ALPHA_SCALE 100
+#define FIT_FACTOR 90
+
+struct cpuidle_gov_ext {
+	int cpu;
+	int last_idx;
+	u64 last_duration;
+	u64 next_pred;
+};
+
+DEFINE_PER_CPU(struct cpuidle_gov_ext, cpuidle_gov_ext_data);
+
+static void update_predict_duration(struct cpuidle_gov_ext *data,
+			struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	int idx;
+	struct cpuidle_state *target;
+
+	if (!data || !drv || !dev)
+		return;
+	idx = data->last_idx;
+	data->last_duration = dev->last_residency_ns;
+	if (idx > 0) {
+		target = &drv->states[idx];
+		if (data->last_duration > target->exit_latency)
+			data->last_duration -= target->exit_latency;
+	}
+	data->next_pred = data->last_duration;
+}
+
+static void ext_reflect_dfl(struct cpuidle_device *dev, int index)
+{
+	struct cpuidle_gov_ext *data = this_cpu_ptr(&cpuidle_gov_ext_data);
+
+	if (!data)
+		return;
+	data->last_idx = index;
+}
+
+static int ext_select_dfl(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+				bool *stop_tick)
+{
+	int i, selected;
+	struct cpuidle_gov_ext *data;
+	ktime_t delta_tick;
+	s64 delta = tick_nohz_get_sleep_length(&delta_tick);
+	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
+
+	data = this_cpu_ptr(&cpuidle_gov_ext_data);
+	if (!data)
+		return 0;
+
+	/*
+	 * We aim to achieve function redefinition through BPF ops.select(),
+	 * so we do not use complex algorithm here.
+	 */
+	update_predict_duration(data, drv, dev);
+	for (i = drv->state_count - 1; i > 0; i--) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (su->disable)
+			continue;
+
+		if (latency_req < s->exit_latency_ns)
+			continue;
+
+		if (delta < s->target_residency_ns)
+			continue;
+
+		if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < s->target_residency_ns)
+			continue;
+		break;
+	}
+	selected = i;
+	return selected;
+}
+
+static int ext_enable_dfl(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	struct cpuidle_gov_ext *data = &per_cpu(cpuidle_gov_ext_data, dev->cpu);
+
+	memset(data, 0, sizeof(struct cpuidle_gov_ext));
+	data->cpu = dev->cpu;
+	return 0;
+}
+
+static void ext_disable_dfl(struct cpuidle_driver *drv, struct cpuidle_device *dev) { }
+
+/********************************************************************************
+ * Register and init cpuidle governor
+ */
+static int ext_enable(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	if (static_branch_likely(&ops_enabled_key))
+		return ops->enable(drv, dev);
+	return ext_enable_dfl(drv, dev);
+}
+
+static void ext_disable(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	if (static_branch_likely(&ops_enabled_key))
+		return ops->disable(drv, dev);
+	return ext_disable_dfl(drv, dev);
+}
+
+static int ext_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+			   bool *stop_tick)
+{
+	int state = 0;
+
+	if (static_branch_likely(&ops_enabled_key)) {
+		state = ops->select(drv, dev);
+		*stop_tick = ops->set_stop_tick();
+	} else {
+		state = ext_select_dfl(drv, dev, stop_tick);
+	}
+	return state;
+}
+
+static void ext_reflect(struct cpuidle_device *dev, int index)
+{
+	if (static_branch_likely(&ops_enabled_key))
+		ops->reflect(dev, index);
+	ext_reflect_dfl(dev, index);
+}
+
+static struct cpuidle_governor ext_governor = {
+	.name = EXT_GOV_NAME,
+	.rating =	1,
+	.enable =	ext_enable,
+	.disable = ext_disable,
+	.select =	ext_select,
+	.reflect =	ext_reflect,
+};
+
+static int __init init_ext(void)
+{
+	int ret;
+
+	ret = cpuidle_register_governor(&ext_governor);
+	if (ret)
+		return ret;
+
+	ret = register_bpf_struct_ops(&bpf_cpuidle_gov_ext_ops, cpuidle_gov_ext_ops);
+	if (ret) {
+		pr_err("bpf_cpuidle_gov_ext_ops register fail: %d\n", ret);
+		return ret;
+	}
+
+	ret = cpuidle_gov_kfuncs_init();
+	if (ret) {
+		pr_err("bpf cpuidle_gov_kfuncs_init register fail: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+postcore_initcall(init_ext);
+MODULE_LICENSE("GPL");
-- 
2.43.0


