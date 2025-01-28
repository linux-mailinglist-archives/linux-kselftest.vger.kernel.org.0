Return-Path: <linux-kselftest+bounces-25268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB87A20295
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 01:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783EF164B14
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B8F4E2;
	Tue, 28 Jan 2025 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aPZtQTU+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010002.outbound.protection.outlook.com [52.103.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED21BE49;
	Tue, 28 Jan 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024313; cv=fail; b=Hr2gp21LfDmc+OhmF88ay0ix6qe/KdHkN/uztk6tTCJ8ipQSpCEQsqA0bkp3tQUwFif3OZm0bvciMkxYZYZ4aXBN/1xHmf6EZu7BLO5zILwIZm9o6KGL0NZB4vUEo7KZYsj4h81TtasTLGi65/Q34Vjtg+em1Qe5sfy68PnRWes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024313; c=relaxed/simple;
	bh=IXj8lxNWWvrO7V3J2Ylbhc5wT5kmD0aKcK9Yij/zWak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZK31YqT3hT1z8YfgKeXnsUP4EeeoSMuavxhZdSwgufjFExrVlnYBJ4j1CUaqVfPwDcajd0OCfB1dk8zXO2nD/MYBP7cjLiQvf+GVso6Vcf/xDLtS0F626hkpnFgSqlqduFrp64NDzDnQ4aH6tfN1bxla/NurRXe0Hx/BkOOUJWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aPZtQTU+; arc=fail smtp.client-ip=52.103.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKhjf60QESKkZaIfN0+2JyZ9g04qFyKWKhvhEApFBp6Nuk3z9CJonDjb9IHXShfuhfzq4Vd/Dj2LEQfEMYm7Bc/+qUue6Kyayd4pIckVrjq1uBMAKbaV8R86BqyROnyAHFi+aPwf15DlAZtdVXkxTyublJaq2jgO1U8Wv+hvrrwRwN6+hCgm8QYQqCxOT8/yMGIIEZR6B6H2BzS4Su9yBfK6Y4/mEN4zCM7H7Oe+HILtyVKmSK2fS+uOnL+hMKe1MyEVWMeM50VKEMn7t/gdf2S+Z/oDdAEx38OT6PGVg8lDi/ClzV4ILzXtFkIPJ/mIcMxap/abJNyNcWiiI1wJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkh6daBnDBvzQ1UrhRECVB1bUXuoLOa3I/P9/9h5JrI=;
 b=pZqTF0RxQ5DHW0ywVTd7UxSImsf7e2+R5SiVN6wKVzrQkzdYv0ntWHBxiJs2OlNcF1oJiQ0VF4hmEN2d84ujJC7Llfqr0z4mnHdIrLfnwqONkBJfBxXvjcV+Oor1itbfaAVgv3Rg/8MxwuoAPd5hgxMzrbNlAZQFxsQd+Kzp+u3NDg8CQvjbuT4O0wiT7k/CxWW+y012QtLM/2T162H+65ut/qqAsEWpxo6CmrPDexHohd+qML2cTcOrJWT0YfTGhusn/ug6dsvDEpNzdZxi5EJerQYvrOcyVTc1zJ4rcebM/d6901ikFWjJ+r9qfuq02qXr+S5Nd2JJ98n0vcipow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkh6daBnDBvzQ1UrhRECVB1bUXuoLOa3I/P9/9h5JrI=;
 b=aPZtQTU++oZsXWGkzkaSWtB8YJmWJuiJU3zYShTAfiPaujLoWeINXCw+abO8u+H/D0qW47OKfBGNqf+mPPcYK14fngMLheenuNuMS1gAVVLjJZWk6njRqSIR9vsDaHcEp5ZBB1aznorfqe+jnbTjMRcFy3miXIYFgjbVUPUlKFK7TF1lyWVqLQpyTkn3tDweAl9+cHyBeeqcFarpUFEj6tBcZ+fi6pdcVLLRupqfX0W3rwJvvxrGqx47esm7Xz5G6X90PyZ07JOR6Zpb4GboRKHT1rF/Im1eazgWz1UBsiM+GKI8H37sjWyKIROFlaGXpq1JBp89FsP4GY1cm8C31g==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SYYP282MB1502.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:7b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.15; Tue, 28 Jan 2025 00:31:43 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%6]) with mapi id 15.20.8398.014; Tue, 28 Jan 2025
 00:31:42 +0000
Message-ID:
 <MEYP282MB23123AF9749F72F14FEEFCD7C6EF2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 28 Jan 2025 08:31:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement
 bpf_probe_read_kernel_dynptr helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrei Matei <andreimatei1@gmail.com>, Jordan Rome <linux@jordanrome.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
 <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
 <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com>
 <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <c3fd51c2-5392-4fc4-ab54-efef5ae062d1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SYYP282MB1502:EE_
X-MS-Office365-Filtering-Correlation-Id: 475a7314-ddba-41b2-3be1-08dd3f332327
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|12121999004|8060799006|19110799003|5072599009|461199028|15080799006|7092599003|440099028|10035399004|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjVCa1Uwc2s4Z0RJVkdNVTFydjk2Ym52amxadEFLUVA5RmtSdDFtbWZqYUpR?=
 =?utf-8?B?eFFpd25aMTF3dm9Gai9Oak1DVFdGSTl6U3VWUjcwYjdXWEpnWDhKNEllOG1n?=
 =?utf-8?B?aGJSS2h3MjF6L3VEUXBvWW15aHh1SktzMXdObWJlWjBDVDVINGZJYVpGUHFS?=
 =?utf-8?B?NGphU0JIR2pYbTIzd3oxR1B6ZzJBdnhBK0lBOG1KUGZPKzFtUWlrN20xNE5u?=
 =?utf-8?B?aFdQVXp4TjU5NUlvVldndlM3UUtYMVVia3lOVmF5eGNRSlpkMGp3YUliU1E0?=
 =?utf-8?B?QTErbUwvbW4rd2FzWWhYMmdyK09wV3RZVjFwU25PbWlnTUxwUjM5ckdEQ0wz?=
 =?utf-8?B?ckpBSko2Y2UxeTdvMi8yYTZKaGxQWU0wV1B5UzBlRWlqbzI0SFRlZDRWNTRX?=
 =?utf-8?B?TG9LSkVweDFGS1NBaVc1ZXQ3eDA4OFphRFNqajUwc3R1THhXb1dRQ3ZyS1FZ?=
 =?utf-8?B?Y0g5YzE1MnIzdWN3ckg3KzJRQ2RoQ2dWMEVwYjhhc3JyTklzYmVCMys4Z25F?=
 =?utf-8?B?UzE4b0VQbXozRXpRU2p0b1RaY1AwaTgycjYwa1FPbW44SmtPSDBtZnFqc0p0?=
 =?utf-8?B?Y3AxNTlFQnVScDNUYkVqVFRWSEtaajRLbHVEV1FVMzI5VGUwNkRXK0FIYy9m?=
 =?utf-8?B?b010Q1A5bUxjSmlMNzN4S1phVDZXQjJJVXEvUjdoeXp5YWl2VGpvNi9YTGds?=
 =?utf-8?B?RjNBMmYyMThlUUYwSWNVSmRPRWNTK1JkWk1xa21ZUkR3dlp2bUI4bmpjaXp1?=
 =?utf-8?B?ZEJ2cnRVVmhsY0FGOHFJd2NxVDR3ZitlZ1A1V3VhSlFFeUYvalkrR2IwRkdW?=
 =?utf-8?B?ckdyQnR4a0JwS29UR21HRHJrb2hNUWxPWEdNazlmZXRHZStmRjFFSXFrZkw0?=
 =?utf-8?B?dittMjdyd1BRcFV5YjU5bUhuWmdnWVp2dkFoZk9vWmM1VHBZNDNlbTZhYVh1?=
 =?utf-8?B?UFBLZnc4VGpjR0R2Rmo5OFljUUtsMmZjc2Z0cTBtUElKNXExOVFRQlIwQUlJ?=
 =?utf-8?B?SEdMbkxXY3duMkZOODVMZFNuSVNuNU10ZmtpUk1xbGhhTTNDNE1GejAxaHNx?=
 =?utf-8?B?N0M0OGdNU2NGNkhtbnNqVXlSZVp3dGNZdGlGc3g4VEpZd1h1UVdSNk90VjRW?=
 =?utf-8?B?ODVDdktTU05ISnJqTWpsNlNTeWpIb2dqTEVFZXlsOTVIMW1YRzVpSitMMlFl?=
 =?utf-8?B?bDY4d2tqWmE4N0FxZUNTck1NYmc1TUpINWdXOHlwbit0dTU1N0VZcSswZXI4?=
 =?utf-8?B?U1I4K0pYODVCUjMxckIrT2ZXTk5VUVVMZFEvMFgrSXJNVlVYVjRxWHduQ2Fp?=
 =?utf-8?B?eURXekdON3pCc1ZNdzhOcFd0VjhCbkhibit0c2tiT0lNb2pvbVlkZ0YrSHFV?=
 =?utf-8?B?YUJIR25NQWt2QmlIMnoyTk1KUVVaQ3l6Zno2Z0dqZmVDNFdXMENzWXcyOHo1?=
 =?utf-8?B?ZlkrR2piaHJjWURJRDFUUVVFWUxnMVFxcll5N1VZWnl4NGZmSFozNXNSS0Nu?=
 =?utf-8?B?em5LN3c4MWFvMHFEYnhaVGJqL3Q0TDdIL0tFc1pFbHdtSVRMN3ZNbnFWRzBD?=
 =?utf-8?Q?LEHUPAJsUaSKgMUSD1U6UYVJ4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEgwc1NucXVoK2VISHNoYTFseTRlczl4b042a080ZXF2VXI0MEUzbXlBZkVj?=
 =?utf-8?B?Uk0vUVVnNER6TTlTMVdKSjBaV081K09md290QUJ0bE0yemZnZUJNQ1kyZStI?=
 =?utf-8?B?UEIyeGFseGkwczN4Ly9hbFZHR1BDU3BROVJsTDFOQjI4VjB3bjNYVlk3d0F0?=
 =?utf-8?B?ZEZpMmJld1hnUDBHWTlKdnZjdjU4RzZIQW4vUTZCZ2lHRlJkcnNXUUFXK2NU?=
 =?utf-8?B?RnBVOXRnQ2dkaG1vc0NSekI2eURDRTJMa0pUaWFkaTNmYkltRHZ0a3RJclY0?=
 =?utf-8?B?SHVJMU5Scm5kWUVJakdTeU5LbjdtNEo2b0VCWk9yQlAvS3dnRzYyWE5reWMv?=
 =?utf-8?B?cXRQQlF3UTdOMUp3L0J1SzNNWXB2OWVlS2VzOUVEc0NsR2lQM01GMUloVUZz?=
 =?utf-8?B?dWZKM20zODF1SXZXcTNsVVZVRy9HK0FlcU1vZTVoU0xHWklzeDVmcXhVS0NI?=
 =?utf-8?B?UXBaNUpJL2xUcUduV05zK1N4eFVDaXU1M3J3Q2srUDMyRzBLNzY3WTNndFdE?=
 =?utf-8?B?THRLYlBUSExkVkE2RFhaY2ZvdERQVlBhU0NlUmh6SU8yUWMxVTUvUmV3ZEtn?=
 =?utf-8?B?dXludVU2MXhEL0R2TkZuR3hRQVZLRVNJeUR4SkR3YUluVTFnY3NrbEd4OGFM?=
 =?utf-8?B?VmxVY00rT1I4Y2lQd2d5UXVrc2prWmkyWmUvRlh3R0lId0lNQ1ZNeTBUQWl0?=
 =?utf-8?B?VjdjczNLTjl6Z1d3K3hrWDVFWU5VdmhCdEtoMXZkaTVGdzJiNE1zUDlVUDIy?=
 =?utf-8?B?a2YxOUxGNVhRVzVuSUZydWNlQWp5Q211NTZTUzVLNW04M0tTQ2VzVVg5R2gz?=
 =?utf-8?B?MDcvUXRKb0dXdHRsUGlIL3loY0x5K2F1SnRWUXliZEhnZlc4bHZaQ1hFdVo1?=
 =?utf-8?B?dXRML2s4OGtjc2wyeDBqQjRoOWY1R0V2Ung5aGxabUN4QUZTV0g4b1U0YXpw?=
 =?utf-8?B?S004NWVwUkZISXZZbWNsRWtReUw0bjU1bU0wZUFnTEVnbGJTUjVpeEhnNXpK?=
 =?utf-8?B?YXFVUWtsaTZpM1F1TS9PWGoySm1id3Z3NnIvMWt5UDVLQURFOUNXaGFRY3lo?=
 =?utf-8?B?VEVaaVZXVU5SUmN5eGNjNFRrVThHNS9WWFVYN2pBWWNLWmRLc0RVaC8vblhS?=
 =?utf-8?B?UFZoZ3hNMldBMzd5MUhFQm9DWFpMbXJSVWVhZXVLQ09mcnNieE5XRnpXR1k4?=
 =?utf-8?B?UDQ5bElWTmpFeFA5ZjVyUmdZNWkxdXZqdWN2VloxV3Y5NTArUU9TU3BNaCt0?=
 =?utf-8?B?NVJEYjJKaDNOVFlQcGhuU3N3aHoyTWluREFtR25tSnRhT2ZiNEtxTFdhOHFq?=
 =?utf-8?B?NHI3UjE4azl6dkdvZGtTN0h6dVdYc3oySzVNUURVaUhTdkNsU01SbjZlVWcy?=
 =?utf-8?B?Ry90cllDeFJzSUs5T1pwcC9kTC91OGJMZ1d2eE1kUzMxTExXN1VCZ1I1RTNL?=
 =?utf-8?B?OXN4bVo3NHNFS3NIY0d3Q3F6VU9uTzRTYmRNZmpkR0ZKQVR0Q3UreUNpT2Ev?=
 =?utf-8?B?cDgzUjdBMVVRQ3pHR05lekIvQXBkcXpKMWRmSVdaU2NMRENNcFNRNkJ0UHVi?=
 =?utf-8?B?Ti81N0duN2JrRVAvaE9pdG1XS2lIUDFrSm53WVdYSisrY3loMEpYOG44djN1?=
 =?utf-8?Q?zir3nQN++ZlxQCJkiqfBhhRttutx7s8yrl5lh/SMxTb0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a7314-ddba-41b2-3be1-08dd3f332327
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 00:31:42.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1502

On 2025-01-28 07:09, Andrii Nakryiko wrote:
> On Mon, Jan 27, 2025 at 2:54 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>> On Mon, Jan 27, 2025 at 5:04 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Sat, Jan 25, 2025 at 5:05 PM Levi Zim <rsworktech@outlook.com> wrote:
>>>> On 2025/1/26 00:58, Alexei Starovoitov wrote:
>>>>   > On Sat, Jan 25, 2025 at 12:30 AM Levi Zim via B4 Relay
>>>>   > <devnull+rsworktech.outlook.com@kernel.org> wrote:
>>>>   >> From: Levi Zim <rsworktech@outlook.com>
>>>>   >>
>>>>   >> This patch add a helper function bpf_probe_read_kernel_dynptr:
>>>>   >>
>>>>   >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>>>>   >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
>>>>   > We stopped adding helpers years ago.
>>>>   > Only new kfuncs are allowed.
>>>>
>>>> Sorry, I didn't know that. Just asking, is there any
>>>> documentation/discussion
>>>> about stopping adding helpers?
>>>>
>>>> I will switch the implementation to kfuncs in v3.
>>>>
>>>>   > This particular one doesn't look useful as-is.
>>>>   > The same logic can be expressed with
>>>>   > - create dynptr
>>>>   > - dynptr_slice
>>>>   > - copy_from_kernel
>>>>
>>>> By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
>>>> with dynptr_slice_rdwr and probe_read_kernel is that they only support a
>>>> compile-time constant size [1].
>>>>
>>>> But in order to best utilize the space on a BPF ringbuf, it is possible
>>>> to reserve a
>>>> variable length of space as dynptr on a ringbuf with
>>>> bpf_ringbuf_reserve_dynptr.
>> For our uprobes, we've run into similar issues around doing variable-sized
>> bpf_probe_read_user() into ring buffers for our debugger [1]. Our use case
>> is that we generate uprobes that recursively read data structures until we
>> fill up a buffer. The verifier's insistence on knowing statically that a read
>> fits into the buffer makes for awkward code, and makes it hard to pack the
>> buffer fully; we have to split our reads into a couple of static size classes.
>>
>> Any chance there'd be interest in taking the opportunity to support
>> dynamically-sized reads from userspace too? :)
> That's bpf_probe_read_user_dynptr() from patch #2, no?
>
> But generally speaking, here's a list of new APIs that we'd need to
> cover all existing fixed buffer versions:
>
> - non-sleepable probe reads:
>
>    bpf_probe_read_kernel_dynptr()
>    bpf_probe_read_user_dynptr()
>    bpf_probe_read_kernel_str_dynptr()
I think the _str_dynptr versions are probably not worth adding.
For example, when we use probe_read_kernel_str, the length of the str is 
usually
not known and we usually allocate a fixed size buffer for it. If we do 
know the
length of the str beforehand, we can just use probe_read_kernel_dynptr.
>    bpf_probe_read_user_str_dynptr()
>
> - sleepable probe reads (copy_from_user):
>
> bpf_copy_from_user_dynptr()
> bpf_copy_from_user_str_dynptr()
>
> - and then we have complementary task-based APIs for non-current process:
>
> bpf_probe_read_user_task_dynptr()
> bpf_probe_read_user_str_task_dynptr()
> bpf_copy_from_user_task_dynptr()
> bpf_copy_from_user_str_task_dynptr()
>
> Jordan is working on non-dynptr version of
> bpf_copy_from_user_str_task(), once he's done with that, we'll add
> dynptr version, probably.
>
>> [1] https://side-eye.io
>>
>>> That makes sense. The commit log didn't call it out.
>>> Please spell out the motivation clearly.
>>> Also why bpf_probe_read_kernel_common ?
>>> Do we need to memset() it on failure?
>>>

