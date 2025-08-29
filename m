Return-Path: <linux-kselftest+bounces-40266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69542B3B857
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894D31CC045D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345183081C2;
	Fri, 29 Aug 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IXAxGL6c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012040.outbound.protection.outlook.com [52.101.126.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DC3081D2;
	Fri, 29 Aug 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462314; cv=fail; b=rACUD1xpt6wLsQZ501L53qpaw1R0J5mgOpig1BirWbQ1zNUZ/+6ZLJnqTqLxS3lM92Ic0sCoeu7BmyLQD/7TFW6dHn3/0eND/KKedw2cND1YmgPlTj31vyZEsSPh0wSBYS6hWrzzwlGPNDPgTQqXJQyCs+rZfcoKKvNzZBG0+X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462314; c=relaxed/simple;
	bh=B/K17Aj+y6xoxQcMTo8t7/EIyAMcTUR6l3usf5GBR3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VY2hEC7N7bhc0K0Sve5zXjebEWSFmuaqRrhdQUIZ6FRqAd9f+UW2ekxdmLK+rFm+dF3vXjL3djb4AMfviTTFD/36BhvthGSrJ7mfKiVLdYtAwtJG2aH/yK9VSj3kSNhdbVOsc2+hC037Ey62uqPqtrcpk2HcrsVn/RF6TrmRqEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IXAxGL6c; arc=fail smtp.client-ip=52.101.126.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op/p3ts4u4ewCqUPRiyS327t+kaMj0CO9XBV76swUlI0ba75hsTURkSnsmIz2bs4UUDICtWwKLoujGzWr46aybHNli3TVeB2ii3sWGmDiQ/zwvhx+RdxsaN039kvfLxoAJLA6fmaxDo/plGscz46qX4TKU43mbu3dGZSqzNdcuasJfbA/P5G2ZF/XBhubndXl8sSb41vZd1FXKSginudkTwkiriOn/Jg1svgOUrPglPaYjzF4WtMyv4u+eafaUB8Ydt3TC18dicr6I0+X4y1b0uYOWI/REmZL2QkxyOU2FX3TcUXy15NESIAMc9Iw++a57w6msc+ehlU9ew/yDbJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSjDmnPS0Bqem96dDd3kF6oN4XBCv19AbAzmr2zFZmE=;
 b=d//MHRvpz9wucVkz+aKU2DDiWC5QpvgMVZ8RwSjr5Q7XzreWoezkcURSLQd8Aaqwwkgl9wdg8cKIbcvu0H+aWoqOQnGlDFxgPFZ7u6M2n515iijsDGn5kQPdJGIaQG8YhUuNVnXt0JGe1C3QD96I9pDE/t9Faaiq7qgGSOJ/mzDJjzRo7+Yh/duvDp8lf146cTZt9myjLYgXztOnuVqwolRYGhJrMZiw8hwA0CyWBxn87KjLdsDPEh34c65Lyevu70Iwnh38V0bln06cgstoNLGx7BWWqF/zXY4MBCC8F2ldSZUw2OjRGjZ6l3B3pBz5XtMpfGmnOFAYnxxv4WbRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSjDmnPS0Bqem96dDd3kF6oN4XBCv19AbAzmr2zFZmE=;
 b=IXAxGL6c6kwVU27+zrZLBOj15kCc3TiNkMo0+sQQcaEpkjK909REU+9vIwFjwQlm5y9X0FWxZhqIPryNfI4uKW+CFuS839bJ/5YGX/8hMguhB9kxaDa8ezj+Ql9TmwGVNkYYdmxJvRCitFZx+LYiBOuWc3wLo6/j/jvlH19hL5n7xiDgSFir+6TQoeH5eQSfYKHhtRDNqVINxBHixDhkDC2DmXZDvUsGtsMCIXCcszsJUrwZiKLy5u9C+qUHRe007wrhv+Tgjs/so3GliiWLEPpcOjCPUSGfStFwtM2vDCwzYlVZfvL9Bfb580AKe2uFX4vROqUuaix+I0lRY/BkXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TYZPR06MB5147.apcprd06.prod.outlook.com (2603:1096:400:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 10:11:48 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 10:11:48 +0000
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
Subject: [PATCHSET V1 0/2] cpuidle, bpf: Introduce BPF-based extensible cpuidle policy via struct_ops
Date: Fri, 29 Aug 2025 18:11:35 +0800
Message-ID: <20250829101137.9507-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|TYZPR06MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9167b2-8e32-4e9e-33af-08dde6e476f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFiQ25RM3Z3Q295ejl5WE85c21sNG8zV2ZodXJXRTBVSzVoWFVBR0ZaNmh6?=
 =?utf-8?B?andHdmlsOEdRMjdMR1lvQUt2NjY1a1ZEUlNVdWJkd1RnZlJpWjZNanhuWDRw?=
 =?utf-8?B?RjN5U3VIUWVjV003MVJFdlNFQ3dmNy8zazloZHBQbXdXdTdnRTNMeFBmL3U0?=
 =?utf-8?B?QTlpRTQyNHVWbmdUKzBGYmV1aE5RTDdhZUNudUZDRjhaMFZ0bUMyb1JzYlZT?=
 =?utf-8?B?MStqSVlnaVZ6dDA5dGNYTHdETC9pcnpUajJNb0JhN2dDbU5nbDV0c292eVdj?=
 =?utf-8?B?Smsxb0xPaDNGZjZGdndzMkViQkgyaThuc0lSVkpOdTN3YkVVdUR1N2RQOFdm?=
 =?utf-8?B?YWx1TDhqSzA0eGI4bW9KbVhjUE5IdVQxaFlsMktGVHd2cVJJMllTTlUxeFJ2?=
 =?utf-8?B?amRwWUJUWXh5UXV2WUp2VFBUVzlFOGJIeXh6dUtSSGp3N1ZDVWlaUko4Qkp4?=
 =?utf-8?B?WkZFdXBoRkJEbzAwMjUzUmlSRTY2cTdGa3A0SUNDSWxoYUYxN2RvY29aWEhU?=
 =?utf-8?B?T2p0NVVPVnFlR1ZlSmJmMDlpOXJNKzUxSERMQk9ZYTlZVjlYdnp2YWYwQ0tD?=
 =?utf-8?B?SXFQMTlzeEhGSnFPY01vaC94OXB1ZlRyL3JKbEt3QVpkckV5MVRYaGoxN3d2?=
 =?utf-8?B?UkV2RmRodGc4aUt6T3FoNEtxaStkRy9xTXRlaDRJZHhpc3c2VGtEbE1rWnAw?=
 =?utf-8?B?TmpmTWpPdjd3cnI3WDZua1RETU4wQWJqeUczUVJpRmxoM0FxaTJDcUNtdTRp?=
 =?utf-8?B?ZmZpcnFrNkdsN2JJRkF2U0xvNmdRRk82dnRpSkxJem1VcFRTcS9JV0svVlNr?=
 =?utf-8?B?aHRNRllnN090akltTVFCbm9OcCtWZG5ZajFjWUZpRWcxSWxpQ1NrYWNUMFA0?=
 =?utf-8?B?R2R6d0VORHJpZG9IdFhQbkcwcEdMN3duNFBhVWNiNWlkY3pKZUpwK0ZabWZk?=
 =?utf-8?B?Z0JPd0VSeE50SEhyb1FmZXVjVmdrQnlyV1BxQW5GSnNEdERmUG5WS2s3RWdV?=
 =?utf-8?B?VUEvTE0rNnlLZVJtaVk1Nm12Yy9zcXNQTFZXMWtydXBybzBrUWVmVGFWVG5O?=
 =?utf-8?B?UVVFejNMSVU3WE91YXFXaERzQURZTUpmZlM1YnNxYTdtU0hLMjd0VDF4Lzg2?=
 =?utf-8?B?WGt4VldYRlZVaVBTMWowa2hJMU5wV0JKY3VIZ0pYeXEwREZ4bklTVTl1NFFy?=
 =?utf-8?B?RXQza2dvU3dqVVZIZ3RxeW04ZjVNMk9mQWtBdnQvbjhmb0lER2QrZ3FVVTZ6?=
 =?utf-8?B?TTYyS0xMSzA0SzhZTnhscEZJM3lhZE5xM0JqQkRtekp2OGx5ajdoVE1hT2RL?=
 =?utf-8?B?UjlOTDFSKzhGK1VTN1gvcmJ2dVZTbWJIY0R6bGZhQis4aUx1Mm1uYmQ4Rm5y?=
 =?utf-8?B?anhvZlVRQ2Z3SjBXeGJRejVPNEtudFRkeUNaZ1l0MXBtMmJPcHhlSXFHUUJT?=
 =?utf-8?B?S1RDSmM3ZHh4QXZZTWloZ0dFdkNDKzJ0TkRWbFdOSTZKV0h6ZlkrMjF3YStG?=
 =?utf-8?B?c0ZRUTd5cjl1SUFMUGJkMjd1eDR1SzJjRFdKVTdFTnV4WHU3Z3pDaW9wQU1n?=
 =?utf-8?B?WUpHRXNUYmRNZkU5SXliTXBqcmwvWWJJSW0rdS82YjBwb3R2Ym5QTlZQYXhW?=
 =?utf-8?B?NllCTW5vQ1ZtK1Fvd2hVNHBLRzdvL1JIRFJVaUN5ZlhldzFUR25JaExUOENC?=
 =?utf-8?B?aVRwUWdVMzdDdkFtdFdHTW03Nm5IcjF0NzAzMDZ4VVl0cjFBTlNTdExWTkVp?=
 =?utf-8?B?clJkSUg2OGRRTnJEMndPZENzZ2NDS20vcVpDdWx5QW1Nb1gvK3h5L3dGUVpO?=
 =?utf-8?B?MHJ1WndTODlqYVdzS1Q5VXNnZHNrQjl5cWVqRWxld3NSYXM5MzVFWXJRa2lR?=
 =?utf-8?B?b25EVWFPaGZ6TXdzK1F6QUJGUllZUVBzemZ0dU4rK3NFSTV5NGJ6M29JRkNh?=
 =?utf-8?B?WS9VbEJ5N2xzZ3QySFoyN2dvZmlFSHdnTStCOEVGeG55MXVrZDNoL3lzMFpm?=
 =?utf-8?Q?RXi4mR8+BkSY2lLnTphlh2CIq3bZm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2VodTI2b05SZzFwckRBTDJxbGVFUjRvb251SFY1VUF1cHFiMllGdjBNUlNz?=
 =?utf-8?B?Z09lREZPZEZ5QkgrbzhrY21KcmRUYjBiVzNvS0JoSnZsRjBCUXVsNU94a0p0?=
 =?utf-8?B?RS9EM1VXTk40MFdnWkdwZWsyMnY5VUtKL2RRbXBaM09jMWxjUG45UXRFdUFw?=
 =?utf-8?B?YjJDb3lSaGliOEt6V0EwWFozcVBKZS9ldkY0SWtGWE9DV2tQSWZndVNTVGRI?=
 =?utf-8?B?ZGM4dkpXVjlJNG5VazEySlg3VE5WRUdEWk05RFlNdzJaNkZXeVNHZGFpMjFI?=
 =?utf-8?B?YzVjUFcyODkzU2ROSTVPMnRWNFlIZG44NjRvV0dyWUFiOGdGWW5KNWtVY3dr?=
 =?utf-8?B?eHpLVEdNSUNiaTEyVHJkMVhROWE4QnQ5SXREeU1QR0NTUTIvbTdLVlAwUXRu?=
 =?utf-8?B?bmNEN21NL0ptVUNSeGtjNE1kRXlteTRPclZ5NVFJMzhidG1uTE5hUE1EbWUr?=
 =?utf-8?B?ZVRSekhmc1psbXhIamJxZytKeVlFaVNwdjJCQW8ybm92Y3BvK2tZVWt2VE12?=
 =?utf-8?B?QzlRbnprS0ErNjdRUG1CdUpFZTJSb1MxcDRvRnF5R1hEN3JpMzZHazViYjNk?=
 =?utf-8?B?Y2pBUDdkZjFmMThpTWFHaTJTbUJYbFRJRmtxLzVVc0I1RE1YWlA0Y2wrZllV?=
 =?utf-8?B?aXB1RU9ZZWpXeFRUV2VWRHI4cVU5VDlwZE1rbXZqYnEzdzRkdWdUeUF5Q0J5?=
 =?utf-8?B?QW0wK2IvMjUyUWRwVGUwQjhacnNwdHRvNXJiSGJiZGdydU93eVlGRE9ZeFNs?=
 =?utf-8?B?a0c1SDR3bnV4UXVZY0JnaFZucTlZbDZwM2xTN29zTHRtUG1vc1hEQ1FLVHQz?=
 =?utf-8?B?R0htVy9CaXgrT3dnK1RZNGZSOXJPR05hdVNFTldvT3lvTVRzUnNodjg1ZFMr?=
 =?utf-8?B?VWwvQXpON0ZZaG1mc3FLc3Jwdm45VU5qNnBlblpEdk55TkNMQVR1Y3lRdktF?=
 =?utf-8?B?WWNaNVFkUDBKSjdENU5rWk9oRWVZRnhTTFdIU1J0VnloN084aWZIODhMemV3?=
 =?utf-8?B?MnMxSEViR0RSR3B6Yjdza2JOSkxteGFUTzd6c3ZWZ0JuQWswN2VSTDBQNTUv?=
 =?utf-8?B?QUw1YXZKSVNRYnZFaExyaWF0aU9YUTN5d1hleitXeFpEeCtqVys1a1NZK2Nz?=
 =?utf-8?B?NWNYU0NuZkpSNC9nMzhxS3ltdzVMaUdZYU1ncDJ0MW01elRnejdDbVp4VUM0?=
 =?utf-8?B?NmJWakc5YTFPQmo1TXJodnFWRWFjZHdMM3JkRzg2M0lWTjhqVnV2SUhPS1l5?=
 =?utf-8?B?R1J2a1JoZDYyYll2eGtvOHQvWjZveFd0NVBhK3BSeHF0a2N6Yzg1SnNmMUVQ?=
 =?utf-8?B?bjVXcHNmR284UU5HbEIwQm8rUGMzWjZueHRnQTZURlIzNWdwZ0FSNjV4TVBw?=
 =?utf-8?B?MEJtYldTVXpGaDJrWVJEcE8yM0JYalU0aC9xYWlUS1VLZnppbDh5TEJvaW9z?=
 =?utf-8?B?UG9qbitGQjJaRlAzMVFwc2lRTVVIYnpCVk9qSmd2ZUNBQmFUcEdQcGNRYWkr?=
 =?utf-8?B?Y1BOTExTdVhBb2F5V2ZjeUU2TnJFZ2ZKVHJNQVIrdmRTWmlpQ2lwYS9YdDZZ?=
 =?utf-8?B?b2xtUjZRT2ptbldEQTE0aU9ZblJCSU5RTHRDM3c0M3dWWXB0OHF5ZHhVeVJF?=
 =?utf-8?B?dFZvYUYrSkgvekxadmVTR0pvZFc4M1o0VnZaS3hrYno5OVlzT3MwN3ZVTngx?=
 =?utf-8?B?V3RpMmtvMGxkaUJxMU9CVUMvd1I5NlhYWGFaV1hKMTdaT3JkT0xXbXp3SkJx?=
 =?utf-8?B?L2pHbWJUYytmQ2Z4cURHMTAxb21Oc3R3cE02MjRhSXE3N1JYZjJYUEJzUHln?=
 =?utf-8?B?eVU4a1hYbzVvaDE0TjZRWDdBQUtPK0hpV29Kb3lsNXFPZFlnRXFDZ1VYY1ha?=
 =?utf-8?B?a1Q4SGZnTnpXYTNhb3FrakdwSjg0bndVeTk0NStUNlE0U2tKRHdmbDI3NmpB?=
 =?utf-8?B?c0JtVXBFL1BGZG9NNmR1Tjh0Y3h6NTdhdTZZWGhvZDlLTnhqSlVOb1VFMi9U?=
 =?utf-8?B?a2kvWWdTeHhhVmRSYWRsZGUvMG5iMGs4d1dDRTN3aS9JSkMyVmhPMUsxblU2?=
 =?utf-8?B?R1ZwY0F1VmZlS0diYkEzMzBUSVFGTjJmYUJoMkhhWWIwZjF0Rzhpa3FUaDB6?=
 =?utf-8?Q?leWS911x5yjUu+IkuxlxA1Q4j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9167b2-8e32-4e9e-33af-08dde6e476f8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:11:48.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0N+J5SsFZyIN7SWUjlXy6aawDpit36scp19n8ArirZd50tPoZf3O/lpd1nzx5dDKnXWbliQb8LwEF636GTW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5147

Summary
----------
Hi, everyone,
This patch set introduces an extensible cpuidle governor framework
using BPF struct_ops, enabling dynamic implementation of idle-state selection policies
via BPF programs.

Motivation
----------
As is well-known, CPUs support multiple idle states (e.g., C0, C1, C2, ...),
where deeper states reduce power consumption, but results in longer wakeup latency,
potentially affecting performance. 
Existing generic cpuidle governors operate effectively in common scenarios
but exhibit suboptimal behavior in specific Android phone's use cases.

Our testing reveals that during low-utilization scenarios
(e.g., screen-off background tasks like music playback with CPU utilization <10%),
the C0 state occupies ~50% of idle time, causing significant energy inefficiency.
Reducing C0 to ≤20% could yield ≥5% power savings on mobile phones.

To address this, we expect:
  1.Dynamic governor switching to power-saved policies for low cpu utilization scenarios (e.g., screen-off mode)
  2.Dynamic switching to alternate governors for high-performance scenarios (e.g., gaming)

OverView
----------
The BPF cpuidle ext governor registers at postcore_initcall()
but remains disabled by default due to its low priority "rating" with value "1".
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

Future work
----------
1. Scenario detection: Identifying low-utilization states (e.g., screen-off + background music)
2. Policy optimization: Optimizing state-selection algorithms for specific scenarios


Lin Yikai (2):
  Subject: [PATCH v1 1/2] cpuidle: Implement BPF extensible cpuidle class
  Subject: [PATCH v1 2/2] selftests/bpf: Add selftests

 drivers/cpuidle/Kconfig                       |  12 +
 drivers/cpuidle/governors/Makefile            |   1 +
 drivers/cpuidle/governors/ext.c               | 537 ++++++++++++++++++
 .../bpf/prog_tests/test_cpuidle_gov_ext.c     |  28 +
 .../selftests/bpf/progs/cpuidle_gov_ext.c     | 208 +++++++
 5 files changed, 786 insertions(+)
 create mode 100644 drivers/cpuidle/governors/ext.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c

-- 
2.43.0


