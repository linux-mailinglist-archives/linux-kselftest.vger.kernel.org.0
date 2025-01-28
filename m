Return-Path: <linux-kselftest+bounces-25298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F2A20952
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20E5169311
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3E19F103;
	Tue, 28 Jan 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eapRqYQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B61192B96;
	Tue, 28 Jan 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062811; cv=fail; b=nL0wQS1gFDaYtEY5lirJQmiyyCFou2a7jy7URbIghYzWU9Jd4eQcCJ0DUyG45aismaoWPgWOpIFnuZzvHvdkSeHxagY4TKFUs1e+xV5X3ROkk14LRhIpkgtkelCdmwD/RtNFxgXQjpztMbxaIMrnpVd5xPZkkENPcP8bhJgr9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062811; c=relaxed/simple;
	bh=nQqMDZAOte4VecLaz5NhUdq3DrbihcQPpDBk9icM6ZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P2bPyHB7dF1pT97n4U4k5jnfYPjeQKnwWLc7GjDergzg/EThOvW+a/TqpktTIv9k/2ZCDENN534Yk67WQFZSdweoosqgUWQhb1XX80w3he/dNaaRuworNgyfhQwdgy/9FPAgafG4qyqgJTXYAIK+MOLxkVvNJm7Wxet7EGg1DTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eapRqYQO; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATe1y3M5p72GJ3d4PeJVIbtDUaiKNmmgLziFfUkNltAND3oILSo6DppAeNZV5hJLsIkoBTnPB2xCWh0M8C24OWOzGHMLFu/dfutefreVu2NhWEZ+35l7G5HvaC1LhAt5Oy8LrV6fHyoZ+oUjFXvBJ95Kxb8s9Up2JeDpyJWwu130r4FXCZHobQMxEyrUWebvNmBly19eA9WuLIYi6ZDsPAApT7TsfNkiUTd8Jm5/s8W3ljid/xXbdlAaqi0eY0tJe6ZZ/m45JwMlMkoDRmycwcGscM8R7kwwWMT0S+D8P5oTkjUiX0/Nhp+TEHnG7lvy8zpoDiRu87NqE9aLxhm4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1zwJsGya26W24ire9ScaXOt34Ycl/p1Rl5OcTgeppQ=;
 b=XWKAoLvbLCPdHweR8tQ82yy9blVfwVBs58cO4t2rB+FW9gw3oec08UyAJVjxtqFoD/CBnPjs6Nx1C+4HoQY51X0M/6nLf18hLNb/m5oZwBXAcovE8F/QGBVUB+bUUWPFjLn/Ed1Tu/UbHtefRt2VXLXry3pYILrJoGAycAXhK1oCV7mCPq0QRTdLQN2C+f5SY+MFdpugdnfV49VG2JicZ5c5trEz3vCrY3sr6oXb6PfpI9hdf68907jdey1VkS0i60/imJWa4jlV65ie3i00jHYOzkMCyTHKuWdiaRB3O2zjLJ7SEelC44O08esph6rMDF21pUC3Qc9O9JJDJexrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1zwJsGya26W24ire9ScaXOt34Ycl/p1Rl5OcTgeppQ=;
 b=eapRqYQOx+7BH9YK5T8gxSij5nnogEDphPi8KxprisPUaBi7v05oeWQChdg4Ff77BObP/uboNaEz2MtkMPqbLCRfS1ry9uSP8Cs0o8zJeAN1k0lQv491Eq8k+fxjB24lQ7WHaiFMjM4290VL75wjGVBi5wmunPLYG8zokj8P8dMo8AwLa22+71tvEr4Ouv+DLHeO3rdJE0qggmEqHA0bSq9GzKzZ8gQErOCH5nSXRo93Cmfxmc+kuzlXGYn4b2WrDT87Nuusqz3FyUBZv7rzyP/PPLOHXk3lbYZCN7nTPQXbSbf7eEP5dzxAwdWgL0gNoW7XDTMm3wG/zwMmGTE+UQ==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 MEYP282MB1608.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bb::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Tue, 28 Jan 2025 11:13:22 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%6]) with mapi id 15.20.8398.014; Tue, 28 Jan 2025
 11:13:22 +0000
Message-ID:
 <MEYP282MB23123214D4F50F0F622C4697C6EF2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 28 Jan 2025 19:13:12 +0800
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
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::21) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <aa602797-b908-427a-9944-a0fd90c50fb8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|MEYP282MB1608:EE_
X-MS-Office365-Filtering-Correlation-Id: 458fd8c9-b6f6-415e-36d5-08dd3f8cc680
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|6090799003|461199028|7092599003|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVVQM2pRT1NOTXJIOGt4ZU5lQk9uZURQTVA4Sm53Q2ErRTNiV2ppY2RPYTAw?=
 =?utf-8?B?L014eC8wTGl4N1JxSTlwSmtxejAxWFUvNFMyUUNXWTB0aE8zRG00S1dpSmpn?=
 =?utf-8?B?TERGZmhIS2NqTVJweTVKQVlGa2kyRTNwUFVpQWdqK1l1dlo0eFIyVDU4M01O?=
 =?utf-8?B?ZmJDeUM4N08yVERvbmhxMFpwblJndnc2THBENS9DWmNsaHNwdEJtdnE4WXZ0?=
 =?utf-8?B?K3E5TnBjR2VYZFNrWGxRWGUxVlpaSlptRENUN2szUm9LMTdubDZ6VnpVMnFH?=
 =?utf-8?B?SllMdmxkaFRqaHBuWW9OTTJiVnJTcGhxNFFDd3JvNjZlMXFnQkdieEthNXBo?=
 =?utf-8?B?Q1hoUlZhaTdzSTVvczJmakQvTm9ob3Bva2RwTEdKSWxRdTI5MUtvZUhlU3o1?=
 =?utf-8?B?dVRKeVlHaWk1R0V4MWN0RFFJSXVvdG1WR2ZxRkNXQ1N4QWYzVU4wT0lQQ0RW?=
 =?utf-8?B?cFF4c01PbnVtZzBZc1FyQVE3MEFYejkwNlpReWRDMzdLdUZRQzU2eW1KemZj?=
 =?utf-8?B?K0wxdGRjMVU2Qm9oRTZCcTJGaHBYc2t4NVZ1VlFJZ2J5cEZWM1EyMHZnV1lQ?=
 =?utf-8?B?UENqU1NiZ0hJUXlYZG1vZHQ4b0dFS0FtMnZhV2pwS1FJank3QThlWXlyUkJV?=
 =?utf-8?B?QkxnZ1pUeEl3YXRsYnk4ckVteUNkUXZQcEVOVlQ0dHlRUTB1RTZsQzI3cENH?=
 =?utf-8?B?eWQ5UldUTnJBTGZtandQY3FrcmFRRmxrRFFVMnF3eTZWU1FNMG5uWGJJblk2?=
 =?utf-8?B?b09tNjQxVnNEVHlmNE5wSHM4ZkdUcTdDVVBLRzhrblh5Y0ZXeWlURCt0QWNk?=
 =?utf-8?B?ZnZvRTd2THJzY0tsUURJejNBTEFBV1F1MmltbnhQWDY5RURrZ1ZCUW8wY09J?=
 =?utf-8?B?d3FDdWpudVZpQS9MWStYejBReTNwdjd2NHBLdTN2UDlCWFNKMEViTmNxcnBr?=
 =?utf-8?B?cmFYMlJvcmdaZ29sK0NTTnNnWURWN04wUS9pMWMxaWEyRHZrMFZueUJxWER2?=
 =?utf-8?B?SHg4R2lOZVoxMlhRalJUYTEvOGtuRWdPY3owTjMyQkxldERyVDdCclhhdFV2?=
 =?utf-8?B?eEJRRER3SXdtSmdHcTlUZDVuWlNrM2w2RWFHckhQazhaWDBEUkVnUnlYQm4z?=
 =?utf-8?B?aVEyb1hLbFdwTVRrUWNEYXBjNzhkSHJEZnRtcWx1ckJ2QXZUMmVlZUVIZjdw?=
 =?utf-8?B?NE1aWlRLcWNmRnFQcDc2R0RQNDZ2cEtmSmZFdFlTTzlpRFVNS1pDUHpYdWdx?=
 =?utf-8?B?RlVBaTFhSGZGdEpJRGNyak5NbnNKbDFrUFdSd2dQd2FZME1GbHdrSkxGSklV?=
 =?utf-8?B?eVlRUllzYW1ZeG53U3FwTzFLVllOTURDTldMQk1PMVdFWFhwbng0OTVUZFFG?=
 =?utf-8?B?cHY2ODdFU1NBRnBRWXA0V0FIbUtGV01VbEQ3NnJJaHprbHo4cGg4dDJRek1t?=
 =?utf-8?B?ZlBrcEE5YU84Mjg0RUxLbkNWL2ZtTFdNVzd1OVhmOUNaQVR2aTRBMmdUUm5n?=
 =?utf-8?Q?bWvFsU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBuRVBuSFlINXpQSGNnOGRxUkFLMS9FMHdVaEZaemFKN0xlK3cvYlNaMUZw?=
 =?utf-8?B?Y2pveGc2UHNScWdLYkhiMzlrY00zNi9FQ2FtcVl4ck1qdGVoN0ErRS9XNjVH?=
 =?utf-8?B?VGdmTllqaGlvWjNhTXRJUFVPM1dwTkRXS1c3UVZ5WTZLTW1Ha2puRk8xanBs?=
 =?utf-8?B?YWthMGJsdHVpS09EbmpScGJCUlJiYnBLa1A0Unh2TXd6MklNQkVvSjBseGRB?=
 =?utf-8?B?Mkt3emRvY2ZMMnBRVUsxUnhZRTR4SXJzeW9HeWhNS3daOFMrQStic3RuV1ha?=
 =?utf-8?B?TW1lREFGT0lJNFRWOUZRdllFV2MrbmJ0TFp1QXlLK1p2YW54NTNIb3NBOUtn?=
 =?utf-8?B?RmRsQkszaXFPMGZHZ2ZUK3B2ZEt5WWIvalZ0c0pTdFlCZjFRNnlzOUo5RzBy?=
 =?utf-8?B?VVVXdmNESnpaS21KbzRzbS9KVWw5NkRuWlpzNTNwcWtBMUxwMzVtQStFV1hT?=
 =?utf-8?B?SmhETHJ2Z0E5UUdtUDMyenFYQm9jR0JScWlITnN3cks4U0xzdm9HcG4vc0FP?=
 =?utf-8?B?ZmMwYkIxbVN1STlPV3QvVjIvZ2hNL3YxamNYclF6YW1hRi9EalpCc29tS3hH?=
 =?utf-8?B?cmxYYzJoek56K0kzUVMyWkk3R0RVcTBaVnRpZDNtWUdCcm5ncUhJNFhvQ0lq?=
 =?utf-8?B?V2YwNHErOTNDQXhDMXJUendZU3lHRzR6TkhjZFpsZU9FdVVLRUx5VlRkK1FL?=
 =?utf-8?B?WUlmZWZQL216bndKSTAvQVR2NGl3cEJUQ1NySE1aWEdZdWNudzNCdkRVSFVs?=
 =?utf-8?B?N0QzdFZIdmVKdk9DQ1o1ckQ4V1gwbTZFWEg0KzZPMHhHd0FOWTZlb3Z4a3U4?=
 =?utf-8?B?bHVBYUM2Y2ZUUStCZ3FEVkZ4R1FUOWNQRHRpZW9PM2lza1JoNFdnVWxnUTlt?=
 =?utf-8?B?VnhyanJubWwycW5NTGdKVUJmUkl6R0JSeElGbUtRWGV3RE1waXJTcEtFdWhj?=
 =?utf-8?B?SjJNRTZkRUpRN1pTY0syVWtVdHVBcFoydEJTcmhDOER2RlNHaXJSOTh5Z2Nk?=
 =?utf-8?B?aVFBUkRJNytUTEFHUm1aUzkyWWNPZDlNeDF6TytWMTdCT3lTb1FaU3hIU3M4?=
 =?utf-8?B?elFCNjlrY2dMeWxBOE9SWnFMeGdVd2JMbzlBVE9wWG1MVHE3RGlOb281YTlt?=
 =?utf-8?B?bUVzSVFpbGYrNkR4c0RROXJUSmpqSmFqK29yYzJUbExrdXBPQ2d0bDZSS1Ux?=
 =?utf-8?B?V1pMK3FMR1hKR0RIWEhydnJZLzE5WDZ5cXR6ODF3LzBSSS82bldndjVOREZJ?=
 =?utf-8?B?WkI5OWZvNldwTXc3c2NKSXdJUmVDa2xIbFY1NnFhOUkwMk54alU5cUR0SnpV?=
 =?utf-8?B?SkdjVzN3U2t6dFBzSTd6dkJiMlhmcTU1UFdwc1gzTHFPaGhOTngzeFdtWGwx?=
 =?utf-8?B?UGl1VnVPZUR4bkVETjF6ekNoUW9yTUNZakVSSjZ6UEJzOUgxYStlNVlaWXRU?=
 =?utf-8?B?dERGbU12cWx4UUZEUXN5RUFLMldBRDNndWtGUHFNWEdNWG5jT0J2aHkwKzlI?=
 =?utf-8?B?ZmI1QVlsckt5aDVNNnRpYm5KZm9PZi9PTWNZUnh3LzdsN0IrdmNFVGRKRHhD?=
 =?utf-8?B?VlZUNVYvaGZVM3ExUjhsQUlXSGtDS210bFBQdUNDVW4xT25IRGtPQnlFazUw?=
 =?utf-8?Q?kUX166YoRjsun8AkkDnSlo3sy7hsRdMdQ2LZmG7qH8fo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458fd8c9-b6f6-415e-36d5-08dd3f8cc680
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 11:13:21.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1608

On 2025/1/28 06:04, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 5:05 PM Levi Zim <rsworktech@outlook.com> wrote:
>> On 2025/1/26 00:58, Alexei Starovoitov wrote:
>>   > On Sat, Jan 25, 2025 at 12:30 AM Levi Zim via B4 Relay
>>   > <devnull+rsworktech.outlook.com@kernel.org> wrote:
>>   >> From: Levi Zim <rsworktech@outlook.com>
>>   >>
>>   >> This patch add a helper function bpf_probe_read_kernel_dynptr:
>>   >>
>>   >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>>   >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
>>   > We stopped adding helpers years ago.
>>   > Only new kfuncs are allowed.
>>
>> Sorry, I didn't know that. Just asking, is there any
>> documentation/discussion
>> about stopping adding helpers?
>>
>> I will switch the implementation to kfuncs in v3.
>>
>>   > This particular one doesn't look useful as-is.
>>   > The same logic can be expressed with
>>   > - create dynptr
>>   > - dynptr_slice
>>   > - copy_from_kernel
>>
>> By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
>> with dynptr_slice_rdwr and probe_read_kernel is that they only support a
>> compile-time constant size [1].
>>
>> But in order to best utilize the space on a BPF ringbuf, it is possible
>> to reserve a
>> variable length of space as dynptr on a ringbuf with
>> bpf_ringbuf_reserve_dynptr.
> That makes sense. The commit log didn't call it out.
> Please spell out the motivation clearly.
Thanks for the advice! I will include it in v3.
> Also why bpf_probe_read_kernel_common ?
> Do we need to memset() it on failure?
Since the current patch is basically a thin wrapper around 
bpf_probe_read_kernel,
I think we'd better not deviate from the wrapped function.


