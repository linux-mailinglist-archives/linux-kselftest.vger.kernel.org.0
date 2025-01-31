Return-Path: <linux-kselftest+bounces-25460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421FA23976
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569911889DA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039F14A639;
	Fri, 31 Jan 2025 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qp3TB8/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010004.outbound.protection.outlook.com [52.103.73.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7A143888;
	Fri, 31 Jan 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738304108; cv=fail; b=S9SwyiIyjvPh4fWzGwdZfHn/o89whTBRdYg87ifb6TPg+5G7klz4k6qdx+tga57rApmJLXAJ4E9QnlOpxkLf+3PeIcOlWbaKr4oKPudIBmsP6MpxpvIhJ3iN6eDV0niAvMVnKt8iDxVjL9Ge2OjlzTGp8X4OQoh+JQvzr379UAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738304108; c=relaxed/simple;
	bh=Y9wVccSes4I6bRCV6jRLaBv/3+nptF8iBwH5v2zbHcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGOux6dI8GnqaDJES/bTFNcw8CtYSvBbV/UasQ0GTJtxH0wO5PEBmsukstXcaUs6Eh1vrxoTho3OpPnKBDl0tjMlLb2x+sMLMHQvX+zCciQwEnGJUgDaIjxo54bFQyiQubx3kwM94kwuE8Imo7Ttj4swwzVM6P4Nlznu2rxzsXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qp3TB8/w; arc=fail smtp.client-ip=52.103.73.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzxC69ZLI0a+LG35W2MfrfKO4F/PA+XExa+87nQwVnqvo7CrRrEvY5U5thojdVGBjEEq4rFNKycw3ByZmvw/kLIzViuyWGLpQUpSyRUGD61/QcbP1FOAdNTWb5g6vihtU+enBWY7VFSjnubQ0u/TgO2TqjKJ/TeYwaqP7ui6WbmP2fi3hUK81ZvS5z984e1GaiLHR49vA8OA3AfcWLLXIgBz3N/ixPH6QFdlcQ1ff5JvsDkzwqH2g19Z/b2muuBz5HPjheC1fyjBLHG8tZeD6L0D0bn63BsFl1SKlekUVMw7plrX5qQi38gYdJaD5KTJ8zaaxqyucZgir/0gG/0j7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPbInCABu3mSIbDaBTTrH6NCCqKa8gn4kfUmDvEZTbM=;
 b=X4+Mn83ss85gqFvWLV5NMFzTvvNxb8YVrucK/5SPvs5dB3M1QIBezcKzlUta+oPQp6r/8sVPGy0WuweJ6ofCy+V5Vq505jb41jk5UfGqNKTOdTC/NjREcnYcxzp9nm9cbqEA9kTV6R8x9gEAZDKXzKkmotIweLR0/LgYBG8j4OSRkrXBy1pyAUfq+cEGtUf1H/mz1GC9j50bnInn5BOJgTyq/iQt4bXIqbfiSD+Od8xAALwAWupCjA24GRIj2e0EMPgr5vUESJr1se8bq6DR7sGPVB6S+XzjWacc0f0BOKuuKYSuGtbT1Gpad1ELKsYMxeq9fQmwsWFx78kuN3CTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPbInCABu3mSIbDaBTTrH6NCCqKa8gn4kfUmDvEZTbM=;
 b=qp3TB8/wW0lGYw4jHX9ARxv9APS2wfW4usg2KaKshsR15iKurSa0cGMWQdRnghGHhf/Nk5fCEGekDskFKHxrcZSfxF14pihio5HbBIISmU9h3LLIeLXJleNpEs4HBGzzp4RSZ14EVIRl/+RXlcyTrR26avKZbcXb+QcoTfT/7A2n1iRmP7Lz5cxHWRwUO+xoewl5pd4KIJXecgtMkil0KkZYXe89GwUOuaDes9qNDF4u6m0BspfDo0QOgxKISrPevhqNBy6AnbKTO1anLJKhkXiRwxGmHXbRXVFHoF9YSSpBE/L8TxSbHB1wis5RXebZSsG8HYp/BsAS4updvo09cQ==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 ME0P282MB5191.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:23f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.6; Fri, 31 Jan 2025 06:14:58 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%6]) with mapi id 15.20.8422.005; Fri, 31 Jan 2025
 06:14:58 +0000
Message-ID:
 <MEYP282MB2312E528BA2190C3293199D1C6E82@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Fri, 31 Jan 2025 14:14:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement
 bpf_probe_read_kernel_dynptr helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, Jordan Rome
 <linux@jordanrome.com>, Alexei Starovoitov <ast@kernel.org>,
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
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
 <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
 <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com>
 <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
 <CAADnVQKLrCf=wSrJQWEHgGLRnmwqTO98n2waU78KvUZgPXJsjg@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAADnVQKLrCf=wSrJQWEHgGLRnmwqTO98n2waU78KvUZgPXJsjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <87fb41b7-22fe-4058-ae5a-d64b42fdab51@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|ME0P282MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b8ee41-b578-4257-fa39-08dd41be9655
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|461199028|19110799003|6090799003|8060799006|15080799006|12121999004|5072599009|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHU2NlN0Ykxyb0Fnb2xaQmNoYUFWMFBXRzRVUW1qbkNCT2NBUlNiRXNFVHhL?=
 =?utf-8?B?andkbUI4ZWs3ajFBOEM4STR1cUVjQmhGeXZQTk9aYnFSTGJMYmxta3lMUEYw?=
 =?utf-8?B?WnR3a01vTlJhdjFGWnc4Wk9DNXk5TkhjdlFudGIwbGFZUjlwZ1VNazNXZVVy?=
 =?utf-8?B?ZWZCdFpvdDNqcDNBcWtYVUxESytWR2FmNGdkK1hmSk5uZEJrQm1GK0NTREt0?=
 =?utf-8?B?MnBCSVdFc2M0Z3pmZ0wzU0lnRzZmaEZZZUZ5emE3OEw3ZHdlN1N5WU9GS0h5?=
 =?utf-8?B?RkNLalZjaytaWnhGNlRYWlpML2FSSllvNzNrWHhlemorZktzODFNNjNkdmw3?=
 =?utf-8?B?b2RRT1pDRWlSYkllY3JLeDVTemZGVnFkcEFSL3VRMFRKam55NGVxMjhGZXpK?=
 =?utf-8?B?ZXJMMkphSDJhRkxnMFhtREc0Uk9nbFowdlppZVJFMVp5WHFEQjZqMWhTV0Rz?=
 =?utf-8?B?akhVbDg2VGpOelVTUGRGTlJRNThTOEFWQjhQSkJWdGFGTXNoSFBOQjBNanIr?=
 =?utf-8?B?T1BNOUZLSTNBcGV0K3NDQkpXSjA2d1BDMFRsZGM1cTArQzRTL3orY1lVbGxa?=
 =?utf-8?B?QVdrbFVZL1VHanZ4bkdLWlNVeDBuOERnbEZzL0hESVdkc0dCZ1RnVDFQWERK?=
 =?utf-8?B?V1RyWW0wOGxUblF2cDg1ZDYvTzhlMU16blVTTGhlcmhQR1JVdjBaWHZuOUVM?=
 =?utf-8?B?LzBtMmcyMG02cXM3OWRiWE1ITmRwdy9OS0M0a1YwOWMrNkI4OU5UQUxkcjRp?=
 =?utf-8?B?MWJEZVhCdFc1YXVWSS82U2dZalBrRzRuNXZ2M1FSN1FRNGxWTy9KNkcxYzA3?=
 =?utf-8?B?SC9mWGc5TnVFajB4R3pUM0JHYmlNQVgyMGQ1OGRQRFh4dFdkQnNFL1lJbk5q?=
 =?utf-8?B?d0NDY2VqM3VxTU9JMHVUaVI2RllZc3phb2x2Rms5K0MxSk9rV1Q0bkYvL0Jx?=
 =?utf-8?B?ZkVHYkd0SDZqTFBFdURsTkE5Tm1wVmNYQ0hoY1AwdDhvUE9BaEVjR2x1Umwy?=
 =?utf-8?B?Qy9OOS83RDN0QjZzd283aGs3eGxNNGxYanMySnl3Yzd4aWdjQURVZlYzeVR3?=
 =?utf-8?B?RE1zTkx6akF4cXFQbmxLL3l3TitqOXBoVkQ1TmFlakhsckhHZkZkTDlTUDA1?=
 =?utf-8?B?Z2dTalVjNk45ZmVVWXh6YUE0dEQvQ3BYUVhwTi9PR2tSYWhxM3d0T1ZCKzN2?=
 =?utf-8?B?K0t0Q0VzR1JDTUM5d2hYdG9MeEdpbk1KNUlvL1k0cHp5UDIzYkp2eWxvWFZY?=
 =?utf-8?B?dUtIZ0FHSHJPelN6S0lqMDExTEc0eU1oNmNvbW1MOEp1ckFHNXp1RXdDZnIr?=
 =?utf-8?B?VUZaSGlGUUltSC82aXUrQUQzY1lBM1FpcXJ5QkdSWVFieEo3QmtIQW4yUXVY?=
 =?utf-8?B?RFhFd2dXeE5QT0s4Y0FhWlE0cTBSdWUyVmR0MmF5K2J3cWFrTnljVGJNYUxX?=
 =?utf-8?B?b2dkdFB4ZXpyalFUbEFJVlZEWnRNN0grRUplZlJPQi9qRnRGMEFVUUVUVk0y?=
 =?utf-8?B?eGttN1F5RDk5Sm0vb2ZyRkxHV2FUOW9MWGZqeklFaFgydlZaVkljWXZpOEpm?=
 =?utf-8?Q?DvGpxeHrTOD1L53qdRq6gq9CA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzAvM0czV1dtOGxkREZZM0xBVE9BWDJBcHJpNm9GdXY2eTZwZVVCS3RhK01z?=
 =?utf-8?B?ajUxTkt0Y3hocGVRdFI5U0svcmJOQ1NKY2tOU0h0UHhZVklidkExclpIT0Fi?=
 =?utf-8?B?WUJCSGFyaUVaS2UvQm5jR3F0Q0t5eWx5MUZPOElxd0hsNkJxbEthTVpjMTZI?=
 =?utf-8?B?TVl1WExiSlZqam5CQWd4L2ZWeXgzQVN3ZStUejBpeTI1SkQrZmIvVGJzbVIz?=
 =?utf-8?B?bFVzcUtPTjA2RWRQRHpUYmgrRC9RK3ZnNnloVUJBdjZTdUVIQXJmcG5LRmlh?=
 =?utf-8?B?Qjg3TFkwYVlHUG5jcHUzcmhWM3MraDFyNDZCY3BacUFCQ3ZoT25VMzc4KzJr?=
 =?utf-8?B?cHhLZTVFOXdwMGFTUEUwM2dFNk0yeG5ZOGZrQ0RHNGJ0ODdNcEQwQmQweUhm?=
 =?utf-8?B?MGptcGcxNmk5eCtlMlphTXNuQnhVbE5jdWg2b0R1b3Joc21ncHZiK3Q3cFpW?=
 =?utf-8?B?QU1vOEt2NHh3NG5HV3ZVL01aaGFDbVE5dkJyb0pQS0tSRXpqYWEwbGRJblJ4?=
 =?utf-8?B?ZGt2amhWaXJwQ0ZYcXNwTUEyMEkwR0NqZ2FKWE9VOXQzSTJKV2RvWEVSY3VE?=
 =?utf-8?B?VnVtKzVwSGc0Q2FIRHA4d0NZRzRoWU12ZnBJZGYvU3JidlJLT2Z2MjdQVUw2?=
 =?utf-8?B?U2hKcEwvbjA1bVNFWUZ4Sjkza3dCbnBFRG9oUktBM1pZMGNxQU5hUjN2V2w5?=
 =?utf-8?B?ZGc2U2liVXFqRU9FMjljazlDM09LUFZZeDBTQ2RrWXlhbC9tS2ZFUlhQZFg4?=
 =?utf-8?B?bzVrdkh0b000azkzNzhEQ3E4a0RGb1dvZStXOXhIMHJGVkY1MjI3SlYxRU1S?=
 =?utf-8?B?VHdoalVRQ1VTT3ZQVGorcmZQTDVRdlhxaTUzNlgvK1NvS2NvT2VFMDNtdnVC?=
 =?utf-8?B?V081SnZKMHo4RkpOWUkyTnZkWTJPWnN2cnBRNmpJMWtSYVV4L2orQWJaN29a?=
 =?utf-8?B?OWdTSUpoaGgrdnFuQ1p1b3dEOXNUdzcrS0RKbXBZNVBxaGlyRTQrejR4Q3po?=
 =?utf-8?B?ZWlOeUxidTlaVWtmaTRueUt2RmtiSHlmck56UGExd3dIUmllQ3ZRbmN4dHNI?=
 =?utf-8?B?VEU5cS9aK1BKbzVFWFBkSkNGSmNPY1hrM3pXd3hUZSs5enhxRkpPaHltRXhr?=
 =?utf-8?B?SXNmanNpZG9JK2JXdUpoOEljall3bExRTnFlOFRtQ2p4K1JVVlRUZ2NhMGcv?=
 =?utf-8?B?TWdrY2dZT25rWGFlNDlLRm4zTUpNQlJjUVB1aHNpd094bkpENkNyaVBGWFht?=
 =?utf-8?B?dTdEZ2pRbk8vcmpqSDRnN1FvUzVXeTdrVTlzNzF0VmI4K1Z3QTV3OGpoMXk1?=
 =?utf-8?B?VDNEK2hFaDBXYUMvazhhRVNDbk5CbGdhWkJYajBqUmRkSVoyNkxNZkxtZTg1?=
 =?utf-8?B?SWdjZjlyUDNGU0J1clFCbDZjV3VHT2VNYWp5RS9qejNRMEg3dDhwZ2J2TWRW?=
 =?utf-8?B?U1cydzVjNE5JMUpBQ0VWZDRHTi93TVpuTzB5MVpjbWpSZEdvak9QYk1KKytZ?=
 =?utf-8?B?bk9GMmpsZ0ZnZVpoZlVUVG1yUkEyZmZzOE0rK1dOYlVORjFxeW1kY0RkTG1p?=
 =?utf-8?B?OUllR2hqNzRVdFNvRkZPQnRzSzBhbEtQcWhIZHV4a0hwOXljZERLQVVXQWRG?=
 =?utf-8?B?OE1tM1djbUZxenE3VitTWU1QTlVXSFM3SVNnRHpSVmFVWjhCZFlNN1lzOW9H?=
 =?utf-8?Q?b1DORN/1Ca2MsIdyY3A5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b8ee41-b578-4257-fa39-08dd41be9655
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 06:14:58.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB5191

On 2025-01-28 10:57, Alexei Starovoitov wrote:
> On Mon, Jan 27, 2025 at 3:09 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Mon, Jan 27, 2025 at 2:54 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>>> On Mon, Jan 27, 2025 at 5:04 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> On Sat, Jan 25, 2025 at 5:05 PM Levi Zim <rsworktech@outlook.com> wrote:
>>>>> On 2025/1/26 00:58, Alexei Starovoitov wrote:
>>>>>   > On Sat, Jan 25, 2025 at 12:30 AM Levi Zim via B4 Relay
>>>>>   > <devnull+rsworktech.outlook.com@kernel.org> wrote:
>>>>>   >> From: Levi Zim <rsworktech@outlook.com>
>>>>>   >>
>>>>>   >> This patch add a helper function bpf_probe_read_kernel_dynptr:
>>>>>   >>
>>>>>   >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>>>>>   >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
>>>>>   > We stopped adding helpers years ago.
>>>>>   > Only new kfuncs are allowed.
>>>>>
>>>>> Sorry, I didn't know that. Just asking, is there any
>>>>> documentation/discussion
>>>>> about stopping adding helpers?
>>>>>
>>>>> I will switch the implementation to kfuncs in v3.
>>>>>
>>>>>   > This particular one doesn't look useful as-is.
>>>>>   > The same logic can be expressed with
>>>>>   > - create dynptr
>>>>>   > - dynptr_slice
>>>>>   > - copy_from_kernel
>>>>>
>>>>> By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
>>>>> with dynptr_slice_rdwr and probe_read_kernel is that they only support a
>>>>> compile-time constant size [1].
>>>>>
>>>>> But in order to best utilize the space on a BPF ringbuf, it is possible
>>>>> to reserve a
>>>>> variable length of space as dynptr on a ringbuf with
>>>>> bpf_ringbuf_reserve_dynptr.
>>> For our uprobes, we've run into similar issues around doing variable-sized
>>> bpf_probe_read_user() into ring buffers for our debugger [1]. Our use case
>>> is that we generate uprobes that recursively read data structures until we
>>> fill up a buffer. The verifier's insistence on knowing statically that a read
>>> fits into the buffer makes for awkward code, and makes it hard to pack the
>>> buffer fully; we have to split our reads into a couple of static size classes.
>>>
>>> Any chance there'd be interest in taking the opportunity to support
>>> dynamically-sized reads from userspace too? :)
>> That's bpf_probe_read_user_dynptr() from patch #2, no?
>>
>> But generally speaking, here's a list of new APIs that we'd need to
>> cover all existing fixed buffer versions:
>>
>> - non-sleepable probe reads:
>>
>>    bpf_probe_read_kernel_dynptr()
>>    bpf_probe_read_user_dynptr()
>>    bpf_probe_read_kernel_str_dynptr()
>>    bpf_probe_read_user_str_dynptr()
>>
>> - sleepable probe reads (copy_from_user):
>>
>> bpf_copy_from_user_dynptr()
>> bpf_copy_from_user_str_dynptr()
>>
>> - and then we have complementary task-based APIs for non-current process:
>>
>> bpf_probe_read_user_task_dynptr()
>> bpf_probe_read_user_str_task_dynptr()
>> bpf_copy_from_user_task_dynptr()
>> bpf_copy_from_user_str_task_dynptr()
>>
>> Jordan is working on non-dynptr version of
>> bpf_copy_from_user_str_task(), once he's done with that, we'll add
>> dynptr version, probably.
> This is quite a bunch of kfuncs.
> It doesn't look like adding _dynptr suffix and duplicating
> kfuncs approach scales.
>
> Let's make the existing helpers/kfuncs more flexible ?
>
> We can introduce a kfunc bpf_dynptr_buf() that checks that
> dynptr is not readonly and type == local or ringbuf and
> return dynptr->data as PTR_TO_MEM | dynptr_flag | VERIFIER_ADDS_SIZE_CHECK.
>
> Then allow bpf_probe_read_user/kernel/... all of them to accept
> this register type where PTR_TO_MEM is required
> while relaxing ARG_CONST_SIZE 2nd argument to ARG_ANYTHING.
> Then the verifier will insert an extra check
> if (arg1->size < arg2)
> before the call.
The verifier does static analysis of the program and I can't find any 
existing
example that modifies the program in the verifier. I don't think I am 
familiar
enough with the verifier to change it to modify the program to insert a 
bound
check. And I think inserting extra instructions into the program while 
verifying
it would add a lot of complexity.

But I think the verifier could instead verify that the user program contains
such a bound check before calling helpers like bpf_probe_read_user on the
buf and otherwise reject the program. That being said, I don't know how
the verifier could verify if there is a bound check in the user program.

Still, there lacks a mechanism to add another prototype for a helper.
I think we need such a mechanism for adding multiple prototypes for a helper
and the verifier will try them one by one.

So that we can have two prototypes for bpf_probe_read_user:

The old one and the new one where size is ARG_ANYTHING and dst is
PTR_TO_MANUAL_BOUND_CHECKED_MEM.
>
> Not only the bpf_probe_read_kernel/user, _str variants will work
> but things like bpf_strtol, bpf_strncmp, bpf_snprintf, bpf_get_stack
> will auto-magically work as well.
>
> I think those are quite valuable to make available with non-constant size.
> bpf_get_stack_*() directly into the ring buffer sounds very useful.

