Return-Path: <linux-kselftest+bounces-25179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B1A1C602
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 02:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27133A8561
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35761386B4;
	Sun, 26 Jan 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oQQeTCt2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289B198E63;
	Sun, 26 Jan 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737853555; cv=fail; b=d2rpOWPdFb47OSB76A4J83KX3s4Wp+cLvAkVKHvMQOTWSlyL/QQlg5srjTsk9k7BTCSLB5gAaUNDucWxOLNwevhsFpydzEcRUdK1oleA7ehNCV4PwZ5Y2ANj1s7tSnN+tvvmBlBPK3qEsmQcDSLGzTXoAdM1MWDLH6oBs+rh3FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737853555; c=relaxed/simple;
	bh=Q81ay4jub4AiJ7C5pqs6MRa0m7Qrhn00Owev0Fh06UY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gte8JO70FdYCYmEggVFZKjAtBY1vQ9Ckx0yKRR1eBOKSOXl6tcvAjh2asKDnpElobwW3ZOmOA+1YQaKSM+kiLZWghRXrapUzrmTsgwV5XcJGhMsmNBK9nxjU/H/dfCreywWfOfOfyBHuHH9/kj+vjCsada3DKyEgDfFT3dNhBfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oQQeTCt2; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAHL4PhUZFsSoOCPwCEDyMmv/nT1Evz4HC5OZmJ227hY7/kMD4bgg5TXutSMLMUosoBhumJAXMneKTZ7EIf6deYoU4efS8BLrzb77RqZMuvm543th7YzQHgsBYsSqxLyRQxozkV7DNOqaqv30yAJwR3MT/NkzJCBgX458y+mg6YK1eb5N0u4vIXtIsSfdg2s3xA0R9+wY/XwKjUxuv50XX/04WdN572NEudVdKBCGlt6+D21stNXCqLtQMQM1L15idF5d6MubcUVTSwAG78GfgiyyC3qxB4PQatSFq7k5Pn4BDwmT11vrwbXzH8xUAlVVJQfhHM7QKbI7Jg1YVMH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVCyTPN8V61tBHE8OhAnG5E0MWAOfozNMF2JUsxPf9c=;
 b=Oj+NKmO2Ghdbq0k08vwp98cPtftWYYzSAYz9KD+QQ7Omtq8GCDse6HlHHQD1sL3iQepYlIZZ+pvtROTQet8X2kBlg1EFjoSYZoaDaa4yR8D9MudTp0TM+62Fr+w1H3e33WLc0aCE0LbbxZkQOfgrUO9hQ6H4M7kO/l4hMsQ6D91g1J9RB5wc4A+7Y3chsEvYV1JgtqiCxX/IceJ7glpJWsA4IEWxbk98DL2mvEHa+hSarkX+A4GK/5tBqdbLafrNU1SbUu8OFS8QlFSj4v5PZ9smXJZlh7AC2NtZWVJ2bkHwFasRJdqvx/F96Dy/rXntPziJZb5zWdus4hMkW4g7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVCyTPN8V61tBHE8OhAnG5E0MWAOfozNMF2JUsxPf9c=;
 b=oQQeTCt2WmzmIBKER8/KYj5QX4AeJpWadlIaSR5uxrG4h7DPxKhaO0THC+hPOFhASSgD+BBvA32AdEPHOKYL266wVMgmcWHYBc2t7tyT0XdD+82qiyiwYGBjaZrXuZ8S7QQQS8VqF+B/PmsET48aXqr8z1wRVcPLkltTW4AaYILpX+3OSAziNxomm9f95OLpR9WKHnvLkYsB6o5F/Ho6f5/ZAkWqWIM8DRlp3R3b3z7ACmeZ9dIrh6CnUFObjgPw/UJElj+r+asQx3fTzqhjBiv6FffZLu3qcPB1NqzvuvVu6jJsYT2yCdQ8y+Mw0lUb7fOMT/+6npZ0PVRQbrCkOw==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SYBP282MB3558.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:179::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.13; Sun, 26 Jan 2025 01:05:42 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%6]) with mapi id 15.20.8398.013; Sun, 26 Jan 2025
 01:05:42 +0000
Message-ID:
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Sun, 26 Jan 2025 09:05:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement
 bpf_probe_read_kernel_dynptr helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
 <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <92a57353-5b13-4222-b040-57ae70609e22@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SYBP282MB3558:EE_
X-MS-Office365-Filtering-Correlation-Id: dc259cad-6627-4a03-1435-08dd3da58e64
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|5072599009|8060799006|461199028|15080799006|7092599003|440099028|10035399004|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFuNUFJQ0hZV3ZxUnY3UXRQOEhhOHRlWlJ1ZUI2a29ZY3ZQeVlHWHV0V0M0?=
 =?utf-8?B?RUE1cFJ3SnJQaTR1N1dZVVFycVVIWmxtWnNqUFlBQ080azNDbVkxcWdBNnAw?=
 =?utf-8?B?d05YVlkyRFZuSDA0b1crV2Y0Rk5IMEJiVUNXRGpkOVNqQmdBSEdNQ3UvS0hy?=
 =?utf-8?B?NmhWRy9PaWVHaDBhR1VKN2k1L1g5SklubVNzRE43by8ybTM4MDM5aEk3YlQ0?=
 =?utf-8?B?dUpWMVc5d1VGeW9YeVVuVkZUbURGOWh5dzg3UEpIeFRISlRzQnNYK0pDL0pL?=
 =?utf-8?B?elRzQUtCdVJ3alNrTmo2WEM3bnMvRUxiZHNXMmhTWVVKcHppOFNIZDVkOHdN?=
 =?utf-8?B?RXFJRmFPNkFQajc4N0wxVFFtOTU1TTl6bklLNU9Pc3hsVXFPdUtoVWd2U0xm?=
 =?utf-8?B?bmUzY2pUZ1lKMVlmNTF3OTJQOW9taXF0NWRBVzBpWFRQd25VMjhXY01zNDAr?=
 =?utf-8?B?MTRCQ2tKZkc0QloxbmU0TEdJblp0REhMcndLYm1LV2FPT3RjTHZJTXVjcGdV?=
 =?utf-8?B?NmxhSlV3ais5NEtwY3A0T3RQM0t6UUZEWkk1enlIZE40LzJsV05XdDZPZi9D?=
 =?utf-8?B?Q2NrcVpoVFpmMTk1MURGdWhXNU82WDNYdDY3bjN3NElVdEo5TC8zZjluQjlN?=
 =?utf-8?B?TTlyUHlRbTd2Z0FQSVJPRjBVMDJ0VzBCVGtTUlNqeFl0R1p6a3hsSjk2REpz?=
 =?utf-8?B?VVFrR2h3YmRjU1N0bkM3YWt2UE5BdG0wRVYxbEJicTlRNUY0NWRabGdSc2Nw?=
 =?utf-8?B?aE00c1M4SGJvajhPWUJsL3pDdkl1c3ZBTzVhdEJRSG9UejZVbGpvdXkxWE9P?=
 =?utf-8?B?NG04MXk1VllDWHlBdnVTNnJXTzhaVXd5VkJFek1nNlRycnAxdzNWOEhXOHhF?=
 =?utf-8?B?U1pSSFNoMXRmR0RKZzBwSThtNWpGMEFWaUxVNXhZM0JYZGN5VWZ4R0FIS1ZG?=
 =?utf-8?B?d3IyQWhBU3RpOVpEUzc0UFRXcXNjUzNkLzEwOGRnUDZYdHRma3NrWS81RzN5?=
 =?utf-8?B?bXdYR2d5VW9hYmwxZ2ljVWphdnRQZUhsVGZCbWZsRWMzYXBKTnQ2NjVsVXJW?=
 =?utf-8?B?UDA1YTlCd1cycEZTZW1FalZnVXIrcUgrQ0ozczJPMDJTc25hQ25jQXFlUXp1?=
 =?utf-8?B?bG9abDkrTGRPb0JBclQvTE9nd1NOWkhoSzZTT0RadThXVVNiZFp4azFXOTlN?=
 =?utf-8?B?VStEVDhuOGNydDZpN1VTVVVSczFLMDR3MHhack4yZkdnQU42NzJTSDV2VUJv?=
 =?utf-8?B?cUhFakRLdnp4TFNPTWhmOW5GN3NicXJUcmFvRmNYeFNwbzZHU0l3SjFrOFNF?=
 =?utf-8?B?RzErMVdZbml5cjNlQVAwUG5MYkkrdmVsNjRyV0RHUGp5SzJid3pITHVTN28r?=
 =?utf-8?B?ci9mTVlVdWpJaTF0ZGpCK3hUQlk3N2MvbHh3T3k4TjV4ZStRQ3MrS0ZFbVRm?=
 =?utf-8?B?bWVOeTJmdU93Z3kxRzJxTHQyS3ZQZ0d0QW0rTktuM0J1L2FjWE4wL21zYzRi?=
 =?utf-8?B?Z2J4UGRlSGhnSkVuSnkvKzZxTFJqTGZVNkhFQ0NicGRYQlRPNFZWdUhmbDc3?=
 =?utf-8?B?M1FiZ1g5Slovb3RIM1J1a3N1emxHLzNXYzFtdzJoSHFqOW5wY1FhdmxrNnpr?=
 =?utf-8?Q?TjisOVoWmR9cpdgQLhYOg6kMbY63WhaJFpZbY5vGwXvI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmloWWY5VVBYY3h0dUhHWVphS2ZjMGd4ZThyQUFxbVdRK1RpanR1WHdJOTJ4?=
 =?utf-8?B?NW5sNVZ1YzZYSnVBUEx6RCtncWVOVVZrVVlXNDBIQ3ZlNFpWeHdIenNKQVY1?=
 =?utf-8?B?RTZLNkJXbk1KYTk4K1hTZ2NPNEozOXZwUjdMRW9yZTcrWnlSYUM5Q1lFbzQy?=
 =?utf-8?B?UERhbVAwMmRCSWEwOS9QZ0RiS1hGN21rNmdBb0tyWUh3V0thVFV4TGJDcUNk?=
 =?utf-8?B?c2FOQTZjb0o0VW51OGVlU1F1OUVWYW5WYjdMeU4vYUVjUTZOY1NjSkFUT3Zq?=
 =?utf-8?B?MTkyR0hybzN3RUxUZ1VVRUd1MHlpQmlVNUFBUTFVMElYeTFUUjJxNGlQcVJz?=
 =?utf-8?B?bDcwcnVoTklCdTl0VmRKRFI2bWQzU1Q2VGJ4Q09UQnZGMW5ZZFdPZDZsMXJ3?=
 =?utf-8?B?eXUzbGlRbFI0M2JWM0VzZi9NYzEwVVB1MUxyYzRSdWN1U3hJdFVsSDQ5WUJi?=
 =?utf-8?B?ZXZEbEJNNHo1bzlCMHc3Tkovd1F4UjA5TVh4MTBNVXVoNmFrK1d3bmgxb0xN?=
 =?utf-8?B?N2sxSXJPUkJpVWg3bndGQmhXb1Awb2Q3QlcyaWs2STE1SCtUZFVKZmtOMVk4?=
 =?utf-8?B?WGhCV2ZsRW9RVE82N3ppaGRMRUNvY3diUi9ibURuTU45VTVTbSs3ZHlhK3JW?=
 =?utf-8?B?dkF3RzN2bGtTVWNQbUNEUmlGWXUvVVY1Y1hSVnVaUElOVVQ3WGJrN1VBS0x6?=
 =?utf-8?B?U3d3TjI2eEQ4bmlHWDdIemFqbGpUWTd0Ym5XejJMZ2ZxRzhuVExMUUtwbkR5?=
 =?utf-8?B?bFVpREdkd2hKRXppVXFvdHdRdTlVN0NvaHNlRHZSZytWbEZmZmw3MWszSXJL?=
 =?utf-8?B?TDhxaDArRC9jUGo0dCtYZjJzNjZUVVA3QWp4RnJRZ09rUG5PV0xEYVpPNWpZ?=
 =?utf-8?B?VWNSZHFGMURvYzdqWTJLbS9na0d6bWIya2lHZGdJckhiZ3oxbThyU0Vpd1c4?=
 =?utf-8?B?TlQvVzF0ZEN4TUVpZU5IV05hb0poV2dCWXl4OS8vRE1GemFCRHZqYjk3VW5T?=
 =?utf-8?B?UTBNVXErZDA3anduRVhrYUovOGZMYm9HczRTSUxHMFBoL3lTd3JUS2d4dG50?=
 =?utf-8?B?WXN0VWRnNElPUGJPL0RybDcrVWphbXEwZFNUcWlKV1RiNXVDUjlXa1BoZzRs?=
 =?utf-8?B?Y0MyOFpaWTNMNHZkbGtHeVFVa1Y1WXhXNmdMcXdoOGNLcDJMTURRbFp6WVJV?=
 =?utf-8?B?eDkrU2lpQ0ZCTnRWV2tUbk02dlFjTTdPYzd0dStrRVVHdWdCVGtxNWJFanZj?=
 =?utf-8?B?QU9zNUNvc2NjUmk0V2NJNVBGVzdTUUdxcllsajBpUUtlS05hMWsyRVZCNzFG?=
 =?utf-8?B?VjlKM01ZMjZpNnJLLy9lK2pxRXJIeW9UemtWNHozajJYQzExVFVBTjlCSjMr?=
 =?utf-8?B?b0tlakxnMDVUY1l6dUx6cndFbFVJREtodHFMN1I3bjBmbithMFRkTmhPNU04?=
 =?utf-8?B?NlpxVWVrMUNxT3A0NFhOK3hJMUFYNkxXV1hjRXV2Z3RNbUp1c2YwQ1o0Nmox?=
 =?utf-8?B?Qm1PTzJCQ0dNelhPamc0UURGWllSbUs2aFhrdHZ2dE5GVGJqdDJ1NmFraXRV?=
 =?utf-8?B?VVhxYldJMTl3OTBQcFQxa0p0allIVWJidHQ3L3FPdVU2eU4xd2J6Wkg4WkVM?=
 =?utf-8?B?Q25XSWhWQk5UbUFuMlRuN00vRzFHRExycm5BazY3L3dQSlVudzI2djFNcFlI?=
 =?utf-8?B?amdLb21LRGIxdmNWKytES0cxQjhwQmluTnFySnVKODd4MnBRNVN3RnpRME1s?=
 =?utf-8?Q?N+qBzmaEOPfUx5BTjXnO4UafpncK+fXL0tGSMo0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc259cad-6627-4a03-1435-08dd3da58e64
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 01:05:42.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB3558

On 2025/1/26 00:58, Alexei Starovoitov wrote:
 > On Sat, Jan 25, 2025 at 12:30 AM Levi Zim via B4 Relay
 > <devnull+rsworktech.outlook.com@kernel.org> wrote:
 >> From: Levi Zim <rsworktech@outlook.com>
 >>
 >> This patch add a helper function bpf_probe_read_kernel_dynptr:
 >>
 >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
 >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
 > We stopped adding helpers years ago.
 > Only new kfuncs are allowed.

Sorry, I didn't know that. Just asking, is there any 
documentation/discussion
about stopping adding helpers?

I will switch the implementation to kfuncs in v3.

 > This particular one doesn't look useful as-is.
 > The same logic can be expressed with
 > - create dynptr
 > - dynptr_slice
 > - copy_from_kernel

By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
with dynptr_slice_rdwr and probe_read_kernel is that they only support a
compile-time constant size [1].

But in order to best utilize the space on a BPF ringbuf, it is possible 
to reserve a
variable length of space as dynptr on a ringbuf with 
bpf_ringbuf_reserve_dynptr.

Then currently we have no way to read a variable length of kernel memory
into this dynptr, except doing it chunk by chunk[2], which is kinda awkward.
That's the problem the new helpers trying to solve.
And I am not the only one needing this kind of feature [3].

Andrii said it would be a straightforward addition as it is a super thin 
wrapper
around existing functionality (we are just avoiding fixed buffer size 
restrictions of
existing probe/copy_from APIs)

[1]: 
https://elixir.bootlin.com/linux/v6.12.6/source/kernel/bpf/helpers.c#L2600-L2601
[2]: 
https://github.com/libbpf/libbpf-bootstrap/commit/046fad60df3e39540937b5ec6ee86054f33d3f28
[3]: https://github.com/libbpf/libbpf-rs/issues/1041
[4]: 
https://lore.kernel.org/bpf/CAEf4BzZctXJsR+TwMhmXNWnR0_BV802-3KJw226ZZt8St4xNkw@mail.gmail.com/

 > pw-bot: cr

