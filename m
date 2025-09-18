Return-Path: <linux-kselftest+bounces-41834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A385B84984
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D37C1C826A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA525D549;
	Thu, 18 Sep 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hazEX3Px"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013028.outbound.protection.outlook.com [40.107.44.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93F3594E;
	Thu, 18 Sep 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198816; cv=fail; b=HU5ZJh3YP3Ku+pCOeGH9nkX7rjQIQRNlcitxI+Yc92jOjwaJyaCOqCmQEsxOVoTDUzxST5ZQ61xaGpxiE2TTEh+iBGFxKRtkVxQ/ivO+1Q0hw729MVxP6dx6x6ZgpALS0mG2D+ZKsm/4saJ9auyBgpdEnV4EliTQUNwglqPtRKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198816; c=relaxed/simple;
	bh=mZAX4T9olV1uwd4Fr/q8mnGijcXilVjrkUiEhO6+T6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nic4mR1JboorvASoDqCkrcoP9GGXHnUuHDlfg45pL2iCh6+VDiPc37IXXkYRKvYDGbXOvvWBfyp5NesdQr5PdH2QsW1juWsasCM83TKv9iKFG4MpKn+kuLJjVGdVeNcyhZihVurnME+AmaCPU2kfn0UQODJFt8KwauPy3GztA0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hazEX3Px; arc=fail smtp.client-ip=40.107.44.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbbSAV5RLSXJxmiI+TVmT5Bx1+mw3u6F+1CbZPprgul+lGm3C6C4bobjDa1kGTLdGHNbGpqF6YoQXgiLODD4dfNRbFBSK/MY/SIHVTE1A+RQSGHdUMe3fk/PsLwT7X6aQJTjGnJ6+YtdHiQjERn0GXYwE3Dm8LIkIWKJtFi47IfaVipFV70CrBL59XLvypfpy8cuJUTBfYF/GHkQCl9WqV4PJWWeFGnjO9o9CXfCmXlTc8qHEmjakkqLncLgPu9cnN3v18XbuxKrBOv6gSZwM82vq5ihxC8+FR88aBkP1X78fzsYjC3FAve88cfLzZb2maVBubr6J+UhUYCLXlffFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3g3x4mJh7ejRGrDyU1HoUdJUTyJGuJV2/5hNkZHM6A=;
 b=JPciuNSW0E8T80Qu2YMyOl2I/Oilb/3KmTGGad9cNf0ytT85ea2ji8za0XAg296ZRc3Miy3zbCSiLPKXoCPm17XxbHXH6ZsK8R2pAZ+EfOqwFUzEFJ6Nrqg0IqWoLN8ktq/l8Osc/zmD/WUr4/Dbih4wWP9iBITJOZPWGBO+/Oa/9RIP65e7kBe6C8RDe8RIT+62eyggdib4ScH84zGP0HhWyi5iUZG1MH75kmJ0tztBKhT+nxklf8f7YNA7gDxEMe4c64oqJw8Yc/LmJlFxZitgciADnHzpu4wdf2wRsv3ewAAGOhARjkwBC/9ycXT3PhGAVvO5GlbaHvAAnHB59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3g3x4mJh7ejRGrDyU1HoUdJUTyJGuJV2/5hNkZHM6A=;
 b=hazEX3PxRYnrra0C5PVUTrVgp93lqonBn2TfRML3DJv+YTH4VsNFWUJ6z/xY6mrY1OkJNaavmwTPsYN6hgNFdSU3+cHF058g5HXxke+40XjjsqtbBfK1IPafbEMjgSbA4LjZMBeJpgTlo2+PpErNrnIxrBiXK1bLbe/6MnNOcogEF8Je4tBVOGnoSoXMAGDxZmi5aHbImKcRqyX3JH4MQpaehKZRytr/E1T5ulHke3oDDH4kryIzClFbq/szx+xUPktHfZ+gGAZGVYHi2PzLJKm6IZ4FXfd+aP6X5XKgp5nj+ujuNrJJ31S/2lXonPD32gcdQgiW0Hf4sEACR/DE/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB6816.apcprd06.prod.outlook.com (2603:1096:101:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 12:33:29 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:33:29 +0000
Message-ID: <e8e8b5e2-35fe-43cc-ba41-c84ccba189f7@vivo.com>
Date: Thu, 18 Sep 2025 20:33:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <20250917153055.6fee814f@gandalf.local.home>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <20250917153055.6fee814f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 360b106a-70e6-4c08-b0dd-08ddf6af9219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhRVUVmeGJrdk00SXlkYTZDQWpnc1BEcXp5SVAwN0RPUG5zc3l1bzhHcFpr?=
 =?utf-8?B?SVBVS3pnMzNRb1ZVYVhPejVJUWs5WUpuclZoSlB2ZXFaV0V6Q0JEZ2ZDRmp0?=
 =?utf-8?B?bHovUEUyb2lkdzI5bjJabHk1K1RIMy8zQ0F0QlZOS21Xa1dpZy95MS8zNGth?=
 =?utf-8?B?Q2pZaVNVeVV3YkhQM0xxN2tFOVdBSjdBNXBmekpNTDZVWjFHcmgvK1NZMVh0?=
 =?utf-8?B?MUZyak5UUUxSdHlrKzlPN1VaZHN6THdxeHl6RHNlS2taTWJDQTJteHBuSThs?=
 =?utf-8?B?TkZOeUdiRmZXemNBS2gxTkluL0UzYXhpdWtKcUlHNWJDSXNNVVJad00zM2ht?=
 =?utf-8?B?UHNiUnpLb21HNUlTZUZMMG5EeFg4blBFYmdtaHdyQkFMaE9HcVRVc0oycHB2?=
 =?utf-8?B?YWR6TlNhczNYNTBVU1JWNERTUXVzWU5wOXZZNGU3SG5XZEt4M01TazUwUEpY?=
 =?utf-8?B?ZThjSXNNNHJIZG1DVGVLY0V1cm5oSHlScVpuWWtEcThGWUEzN3VKdVIzMjBv?=
 =?utf-8?B?VGxXeURyYVpzb3AvcW9GNDl0OXdMOU1RWDNRQ2hwNDA0QVJrQTk0MDZOb1hz?=
 =?utf-8?B?Z0xzR3daYVJETUVqbXoyQlBxcVpOaTd6M0w0Y0JQQkhWeUlpYzZsYTZXSHcy?=
 =?utf-8?B?Z3pFVFd0VXBJTDFXT2NDaW1CUFplcWJtTFFpZ01aaXltNnRMZCtkQmVwamVv?=
 =?utf-8?B?LzFOaHBsN2RYTWNZOWMvMXlsRGZ6VHYxL2tNT2hCZ1hWQ044a2VmSENMeURq?=
 =?utf-8?B?UzFjZGFOKzdOQVRENk5DZnE1Y21CVG5lOVhQRDhTVE1acjRPSklDSVRiTGxS?=
 =?utf-8?B?VWVaL0dhWC9FY3RTd3NqM1lnekZ0QXVibUs4U0UvclJoMmRxcmNERTBnU0xs?=
 =?utf-8?B?R1VQVVI5NW05RENDWjl0b0t5M2FYSEtiWVRXUHBTZDQyUXFmdGhoZytKN2pF?=
 =?utf-8?B?cWdYdW9UOGI2dnArK1VVT1R0dHBhVHVHRkV3R0NubUQzRTFpVU5pOXliVEFK?=
 =?utf-8?B?c3U5QUNzU09DQVNXWWNRSFM3eDRVRDBkek9tL3ZCY1FOdTZFR0pXMlJPeDhW?=
 =?utf-8?B?R1craG5vbFc0Vm9kYmh5TkdKYm1pUUFLRVB5eW1UKzlNdTBnZ3NJK29nWGVl?=
 =?utf-8?B?L1JudUdwOEdnM01FWFNXbm9ldFpIQXEvT2dhbnVLMkl6cWswS1BkRVFRcGIv?=
 =?utf-8?B?Wm9NblM4YzNpclZNYzZGK1l0VUUreXZ0TmtvSHhxN2ZpNFZVcFR6dmJ2cFR4?=
 =?utf-8?B?ZzFyd1U1c3NYcWJSSEE2azdYQkxkZ2lTTk5aT0J2OVE1eWhYUFNqekdNQkpt?=
 =?utf-8?B?STlyM2tmZHJTM3pmUGZ4SFJ0N1N5bk94K1orOUlSUW0xaTIraUhvaHJpNzY5?=
 =?utf-8?B?dkV5UHZ4OXFNRmtLc3FxNXJUUTBvL1hWNE1VVHI0N1o5UGQzaWVJd2JnVWJD?=
 =?utf-8?B?RU8vT2xyODJrOElGN1hEQkFVbjVpVC9ETHI1UzAwYmloU1hEMTB3d0U3ZmJm?=
 =?utf-8?B?TFhEV1VCdmh0VHdEVkU4SlRnc0lyWWQ5QmNHdy9HVlpKVHIyVFlzL3hlcE9x?=
 =?utf-8?B?b2tGclVLYUw4RXFpckVmZUlmbmJSbDhQc1R5aEtNVExaU2FTb0dkMS9tcXNL?=
 =?utf-8?B?cGIrQ2RlTkh2ZmxMVVliRE5RQUFFL2xPUk9DOWFFZ1ZvL3ZUTndCVUo0U09p?=
 =?utf-8?B?djR5bXNURWY5SCszU1owQ3lEdGhmU2ZJQW1qQ1o2ZUg2NHVZSFZybmMrRGo1?=
 =?utf-8?B?UUxiL2p3WFV5VWkvdzVBeHIybmV5SjhkY0tUQy8yaDRGTmRLcWdKUVBMWkNr?=
 =?utf-8?B?RkRDRmRTbW1DVGwvOEc0K280WkIxWlEwTm9zeW1xVkl5VlJ2emFTakgvQXBM?=
 =?utf-8?B?eGZQOFkrb2R6aUdxTm9hYzVKaDhWWXFKWmNHSnllRFk4U1A1djdzRXpiOFVj?=
 =?utf-8?Q?IpveJR5DgWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRvVGgrVytnRzJsUUhkMUNBNzZxK3drcll1c1NYemdvN3BpQUlmZXNoN0VE?=
 =?utf-8?B?Vnk5S0NLWnRncWkwaWVGL2d2VXNsZ3NMUXNKM3BaYU9zZXoxVU5XNHUrTklw?=
 =?utf-8?B?eTdmdlI4dXR6WkJGLzVGbUlaajFCZGFJRElQdHV5bVNOc1ZBK05IRU5RTWkr?=
 =?utf-8?B?ZlUxc1B1Z0FtU1JCSkg3N282WFNVNVRnQTRCS3plcVRqWW9DVnQ0a1hjWEVD?=
 =?utf-8?B?di9KZVdQTUxxTmlyc3RSdyt0bW1OQTJsS0tFSUsxY2grNS9iaHJsbmg4NjN4?=
 =?utf-8?B?YXRjNWdBTWR6SGRqVHhHcFlGKzNGSU52MUhqWkQ0bFMzM2NOTzhlaVZFMHpP?=
 =?utf-8?B?K3MyNjlpbFlKbjRqQVVBZlZHaFFnKy9seUkwcmtHZWJ5OFNINmYvZWJ3M0hv?=
 =?utf-8?B?WEpUNFUvdktUU3Y2cXkyMGl2MDRDbFU1YXcwQVd3WEg4enpMWHkyRXNHWWVT?=
 =?utf-8?B?STgvTjdkenJmRDFINEhZR3Q0WWlRdnhhN1kyNnRmVmp6OVNXdHpwTHlnQisw?=
 =?utf-8?B?ci9qS0I4T0ltK1ByVDhoak91QUlnU0REWFEyOFVlVnM4TzMxUGl2ckVlRjZi?=
 =?utf-8?B?ZnNQNCtxS1UzTjJZMW90WEZnYXQ1MnhvbXF6akt0SkovYVlnK1RwR3lIeUtX?=
 =?utf-8?B?c3BmMDBVSXpIR3ZyUm81amFYclY3U0V1VkgvL21NWVdQdjludnA4cllTaTIv?=
 =?utf-8?B?TnAxSU1uM0VwRzE3c25yeVNyT1BZSEZlU3VNcDYxL0hJYVdOdno5bHF1VENl?=
 =?utf-8?B?ZDZzV3VwV3k2aDNad3BCU2drMVdwR0w2bklSZDRWcHZZb1dFaWZ6bm0rV3JW?=
 =?utf-8?B?akNDRk5lMUFteG1qNGozUmh3bFZSV1FocHdWWkZrV1czU0tHdENvR2xZZGhi?=
 =?utf-8?B?VE53T1JuOExNYUJhVnp6bU5jWm1aTDFmYTZVRnhRc0ZmeGdQeXVRRWIrYWU0?=
 =?utf-8?B?MCtQM0hGUkY2ZVZ6ZS9WSm1tUG9saEZIMUZyNWRGUWtzeHhBdlJNaTI2eisz?=
 =?utf-8?B?bUdaQkw0SVdnRVJxamJmdE1xU28wZVdBVmdRcndzTVJQT1A3ODk5T0hUWUxl?=
 =?utf-8?B?bGswY3kyTVRwQkpWSmdhT0txQTYvT1E5aHdqNGxSSFhIWm1HL2N3ZWg3Q3VS?=
 =?utf-8?B?dEdhWm5CNEgzRkd3QitpMzF6aFF2Z1FUV3NDR1lSS0MzK2MyOGZ4d3dDYUNY?=
 =?utf-8?B?R21tRCs3K1ZzQ2FYTUZkR3N0WlR2WHFNK2RjRVZjaEZUVDJpdFBwYmpmb2NK?=
 =?utf-8?B?ZS9say9IWnhxRzRVTFVTcElSSE5nK0dYZVRuRzYyak0yeTZmcGhyOWVaeGxE?=
 =?utf-8?B?K2creVVTNDdtSzhrREdsQXZTcWhPMWxnWmpXelBldVI5RlZhQzNVOXVkcEl6?=
 =?utf-8?B?WVdNclZnWWxuaGlLU0xLYUUyTnRhQUloa3JQaDRianlxem5RQ2x2RDNyWVFP?=
 =?utf-8?B?Q0MvaUVkWGZCdG5OcVdmZ0lOWTNYVmhtRU82VVdUUkRZRm1abnRoa1AwWHVM?=
 =?utf-8?B?Y3RkeFNFenBBYlJDN2xldmdsUTU0eG8yQ0JwZHVqY3kzY24zNEhrSUF5Q01k?=
 =?utf-8?B?dE9md2d6M3lkQjkyL0REbU5hZVFoWFVXSjRHWDhkZG1SRDF3V1AyeTZ5ZEZz?=
 =?utf-8?B?TC9BMndudTRIdEt2aU00blhCckNjRVloeTJScy9oeGQwUzI0NFdrWVF4dnBa?=
 =?utf-8?B?M1V2R2lsTVVWaDZtN3VaQ1cyQ2lnZ1ZReTRpbmk1Z1pnT0hYb21iSHREamVp?=
 =?utf-8?B?SW1USm9jMkpKUE5Ja25BMzdmRmJ3OTlnSzUxTnpkME92SUpYOFJjdWFuU1hx?=
 =?utf-8?B?Vk9EYjUwZjZwdS9XME9INkRoVEZtTnFWMzRYdCs3UUlMdE9jQTBrM3Rub3NY?=
 =?utf-8?B?NjZDTXBlaGV1ZzNycDk2OFRPVUZteHkvSkhVcXhIZE9vSzVwM055NElxWmU2?=
 =?utf-8?B?LzlSWW9nSnNNaFEvTHgvMWI1NWJtV2JreERucXZzby9lUlQ2VVRUTGtob2t4?=
 =?utf-8?B?MjdES1JocWJQRXRiY0g2WWpWK1EyR1l2Y1NwTHJBRHpxR284SmU1Y1ZXZlcx?=
 =?utf-8?B?ZUZnUFh2cm95WnFkVVgvWHM1cEZQK0p6bUVYV2ZKaHZRdlQ0OGJXNFhEQUs2?=
 =?utf-8?Q?AkLVK1WpyfU5iREid5vx21nUx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360b106a-70e6-4c08-b0dd-08ddf6af9219
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:33:28.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe8V6QlaKW09KGk/Ir0gvJKPKRRMjINtr862jLhe2WkaxQ4K9Fclz/X7ZEypWsPSaw0Yk8oAdsES6mv5GovdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6816


Sorry, I just realized that I forgot to include the CC list in my first reply.
Resending with CCs. Apologies to Steven for the extra noise.

On 9/18/2025 3:30 AM, Steven Rostedt wrote:
> On Wed, 17 Sep 2025 15:22:39 +0800
> Fuyu Zhao <zhaofuyu@vivo.com> wrote:
> 
>> Hi everyone,
>>
>> This patchset introduces a new BPF program type that allows overriding
>> a tracepoint probe function registered via register_trace_*.
>>
>> Motivation
>> ----------
>> Tracepoint probe functions registered via register_trace_* in the kernel
>> cannot be dynamically modified, changing a probe function requires recompiling
>> the kernel and rebooting. Nor can BPF programs change an existing
>> probe function.
> 
> I'm confused by what you mean by "tracepoint probe function"?
> 
> You mean the function callback that gets called via the "register_trace_*()"?
> 

Yes, that’s correct.
My earlier wording was not very precise — thanks for pointing that out.

>>
>> Overiding tracepoint supports a way to apply patches into kernel quickly
>> (such as applying security ones), through predefined static tracepoints,
>> without waiting for upstream integration.
> 
> This sounds way out of scope for tracepoints. Please provide a solid
> example for this.
> 

I appreciate your comment. The example I gave about security patches probably
wasn’t a good one here — I just meant to show the idea of changing kernel
behavior at runtime. Sorry for the confusion.

At the moment, I don’t have a solid real-world example to provide.
This work is still in an exploratory stage.

One possible use case is CPU core selection under certain scenarios. For example,
developers may want to experiment with alternative strategies for deciding
which CPU a task should run on to improve performance.

If a tracepoint is added as a hook point in this path, then overriding its
function callback could make it possible to dynamically adjust the
cpu-selection logic without rebuilding and rebooting the kernel.

The same mechanism could also be applied in other kernel paths where
developers want to make quick changes from user space.

>>
>> This patchset demonstrates the way to override probe functions by BPF program.
>>
>> Overview
>> --------
>> This patchset adds BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE program type.
>> When this type of BPF program attaches, it overrides the target tracepoint
>> probe function.
>>
>> And it also extends a new struct type "tracepoint_func_snapshot", which extends
>> the tracepoint structure. It is used to record the original probe function
>> registered by kernel after BPF program being attached and restore from it
>> after detachment. 
> 
> The tracepoint structure exists for every tracepoint in the kernel. By
> adding a pointer to it, you just increased the size of the tracepoint. I'm
> already complaining that each tracepoint causes around 5K of memory
> overhead, and I'd like to make it smaller.
> 
> -- Steve
> 

It is true that adding a pointer to the tracepoint structure increases
memory overhead. However, memory for "snapshot" pointer will only be allocated
after a BPF program is attached, and freed once it is dettached.

I am also considering whether it is possible to reuse existing structures
to reduce memory usage.

I'd be very grateful for any suggestions or guidance you might have.

Thanks,
Fuyu


