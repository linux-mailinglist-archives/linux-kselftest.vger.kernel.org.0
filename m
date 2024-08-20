Return-Path: <linux-kselftest+bounces-15737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC03957B45
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 03:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861FD28374D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 01:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4571BC4E;
	Tue, 20 Aug 2024 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="myAHVWct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2055.outbound.protection.outlook.com [40.92.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E57381A4;
	Tue, 20 Aug 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119122; cv=fail; b=ZQ23nFaLdcGnJH+8ie6FFOslPfuM0J8dqF20Lw6fjB5kI0T38EmMAUgvBsqWk2hZicS2+NOSyEPdTtezzx3H8o7zxHIlpXdjKP1HZQd3IOq9iSqE7ZwzppConOqVvtmKvjhdu6yp2UycwbobKwFWHaFVcB5+LImaGTIhfrdI1jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119122; c=relaxed/simple;
	bh=DWXf+iDZfsNj4k2VjlIBiFvQ4H5vpy6FIWfwhcoyHsg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxBlTMyXd29KXrOVuRUuMFFHdePTc10zSQ6UOWROrQ8Xx1JjGOgFgoSvRmuWrG6Nud1MqAxhMWCREwe9Q15zpboiIK8zWwNlXU9sKSxaf6R17myZ/Wd8KE0cKdoAEi5QS+FekOOks35wf9MRoAm9ItVzUFocYkyzBBYwWFVx07U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=myAHVWct; arc=fail smtp.client-ip=40.92.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaTqWmVB1ezE8q/i66E8IKOdnCuaAIBhbq+waPyVdr/g4UJUYNew4XNFLH6cQ4OBr3jFx3SuJt30R1xOPii0pBgWkAMgLvOfJAhPeiXwE0Sxj6Uw+IP+7rF/cxWESAp9hwtXH4R8Xm/8wgT6MfBJ+nnsE7rFWPGFEev8Y0tvEYQI8DoW5XFmp1a+zbDokE6f4nv8Ae8wPaS9KtOFFfsbiiDSjrIHgHhjCuChQzn9c6FJ+zlmOuJc13s/Pcc/dHXg2eECAcXrIpIvGi//hq6atr/zbGXogkCi6PJkoj+Jk81mrmff547aVxlGl4eZ+gq7csQ12JupNdmXjY2oosPv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUV+EYFJRsVUy/7zbMDT0rixDZayXVUSonf0p+QiePY=;
 b=o3h84EDmd+zqFLX5MBMS88DEGTADIp+50Odi8+3XZ/xCAWKXInntPIgIxiSlqBOZPmHFZpSBiX5WDuC9vyNXx5cvP84ts8yhY+6bNDIujKQirNRpsfPa/yVFIWBUAzIt/JA7SD0H573gzumFiVCknMUNFCvQ3q6pW6zatmWi/JjGQmFScwstRBOk2KXkaG4z/mvwGcXSQuDm16ZWj11obIPJe9FvSf7Vyma97EGqfCZiWUf2hxliXtX4g0Ap2lXOJVadvifNX60w/4IfvBlsWoAJBIV3t+BEYnsKyn8IhnKF/hmk1mY7cnXDTPAzpm55x9oaHPntNdAOz72F1eDG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUV+EYFJRsVUy/7zbMDT0rixDZayXVUSonf0p+QiePY=;
 b=myAHVWctO8L7F/lIdOr7eyIwuVtZhFgHKv1HGSsMbRM4njlv/1M0e91ViFYxNcCktfXJoguXmqtAJXRRCJ1UzRaMv+ls6s7tlZ/zrHrn7hyqDvTrlapEh+ZCOADNAfX6XNQgvkkfTevfTzxr4NHfPT/7ZuP8iG9ZbJnjplS82SI/eiQvf+0fSj0+QIy2gij6KvDmdI2DNhtorg4YvWVZNy1wNl48Awk4IQlDLilJXAI/iD7Cb8k+W53RFy11zn52VfEKjeM+25fIsO04RjoP5zPzdue2LZX2nHGLKhqKLkEBdOeORoqScogyoApPPdgoGP6BqsCW2PEb6djl1/3IrQ==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SYYP282MB1869.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:dc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 01:58:33 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 01:58:33 +0000
Message-ID:
 <MEYP282MB2312A08FF95D44014AB78411C68D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 20 Aug 2024 09:58:18 +0800
User-Agent: Mozilla Thunderbird
From: Levi Zim <rsworktech@outlook.com>
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cyy@cyyself.name,
 alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, shuah@kernel.org, corbet@lwn.net, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org
References: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
 <MEYP282MB2312106710775098261AB348C68C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <ZsN6R8IliKzAKKMb@ghost>
Content-Language: en-US
In-Reply-To: <ZsN6R8IliKzAKKMb@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [N6qS+7aQL31vo1/xr1Uk1Mne6nYrbJFy5ia7AFChg0U=]
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <83c76388-b63b-41c7-ab00-3ae031482b08@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SYYP282MB1869:EE_
X-MS-Office365-Filtering-Correlation-Id: f8353247-143b-4e99-803d-08dcc0bb98ed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|15080799003|19110799003|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	eTMEpUOHkt4nJgeyVU72/PWZVVdf4xFVE1Z1F78GIiyih0rPojjQrIK47blcjFWC3UdpB1YW1Sb5Ijw+B7kZNClscycRMccq/4drhYL6OShFM0HrjEiBt+NFXBmVxAoQ7ZhLyemS/h1sKsWoXBYVWVB60VP34UntQwEI5mjB/UX1fxyTf2x+v+oUIFxqWyrd2hItIyXg0ajkzuKZlhXrpZsEgt4T34rvPB9XNlwWn40l5eps5a2EBfE4qo3JxI4JIlS+lfBRIYxRp3u58Oyd8b1rTPQV+uj75XC3CgtevgbNzyxAb2/dM+sJYhdBfTTuuzp/rhH9ousCAqF4ZWOJw4DPaUUtryUSnObpR7M4ZgcD3TAa5sOFeuKWM7eId7G5ePBn6j3rNtikO322+KU9VFULLxwMrOoJ/grrOw2T4k4fZBsY99b5zdbKAX0OQSsdUgAJOadAkwtrXpSMCMZ3MjHao8YbvdEER/DVqJy/G44tmG4tRg1m2tAuqejMf/PovxSto5wm+S+7esK4tD/xS8f+9tnt0/S+XImiSMAruGxUaurEJM8ylWjIBV0aclMUunvZ6zVwrYws41ac7suhcYJYLzkYHyYzbsHDoiMnZeEf8YNbJOvgP8XqFjxQxcdkRsB6Yn89NPRJ1vU3PLPlGSvQn8f3qi0MUMRq3Ngm7Hm/tl6BA0jje2pLRPlYPR+OWdvxbA+M1XONGC2zcbgtlYXnwpfKM8GkF+iYGiCux59iOt1Iln8BvMF0vL38OvJKcB7X6MmhU7tTbyaw299rwyzd45Mv00aOQUtFYmlzy/V+CRY11TWzKQkwSaPFA6ZO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXBxQnpuRkFSb1BZTWdRZllMRW85Q1RQMkgzTHk5QzA5OThlUGRmcFoyRnZU?=
 =?utf-8?B?UTREZ0lidGlhOGM1VkJ1ZUIvQzk4NFRJbkZNOGRONlZUZkhnWDdyNE81NkQ1?=
 =?utf-8?B?RDMyY0RXc2Ura1V5bnhyelFicXJ3WXhRbWJMcWVBZmZLUkF6NGhhWHc0S0Y5?=
 =?utf-8?B?dS95bWtMMTROVUhWUWNpYktQM3dyZTRPcjV0WTZnR0R3R2YzWitKVEFscElP?=
 =?utf-8?B?ZWQwSXRyTVpyeGZwcERPRWxJZXQxUVhQbm1nMmVFeTQrUWt6Rmp5YWgvQ1Zk?=
 =?utf-8?B?MzM2UmdVTlRzQUxJOVVKckFRS1lab3kxWmtKUHpXWnZDY3hnZzhuTlFyM2lq?=
 =?utf-8?B?UVFGUjN3WWc0aThvZmVxaGVwRHRjZEVjaXUrY3lNL0lXQTlFUEpTdXdJOUpB?=
 =?utf-8?B?NlA5cUlRTkRrV3pIUXVDNVRDc0dWZVBZRVBtVXdQNjdpbFRCMFpzT1dVSm5V?=
 =?utf-8?B?aDQ3OUNXZ1hrNlZ4bDBwUlcvTFBlWmEwcWlWbFRGUkxNSEFsNWdIVjUwcmdG?=
 =?utf-8?B?dDgxZ2k3Mkd2SE14c2hNZU1FMXpTTms4dE9MV0Ztd01VZVB4SFBhdDBSQlRo?=
 =?utf-8?B?QUV3aW9hRFh3T2duNTlidkJqWEJxa0lZMWFNTCtpRE5GSFFDam9DMDI2ODZM?=
 =?utf-8?B?U3oxejQvellVVHRZVE93T1RTMTYvS1Y4Sk51aWVWRnFvVUNvOGF4NUppWERO?=
 =?utf-8?B?Uk9VaWxFMWp2cURudlpIam50Ujd2ckJjQkIwUW1iaGJhb04wTUUzY3JXQWwv?=
 =?utf-8?B?V28wSDZaMVNoMkw4dDc5aklReExDVTRPU05FUlNwZVBOeWdhWExuaGkydjM3?=
 =?utf-8?B?UksyZXhlWnNyQ2diZnlBQkxZbVFiMGtsS3h6bU05NXFMek1yU3lhRDB4UnVK?=
 =?utf-8?B?dy9DYWlyL3J5RTRJOXI0V2RIY0tETDVueXpVdnkxVmgxc29PWm12WXFvRVlV?=
 =?utf-8?B?V08xcDJMcUZHbW41eXUydTlPY1U4SWxLcUVtVEVzMlFWV1hwdGhXaVVXalFY?=
 =?utf-8?B?aS96S0lOZGRGSjBGaHlQV2ZjM2dNbUNWVWlSb2xMdTFrQ0plcVlkV0NxK3Jo?=
 =?utf-8?B?RlJROFdGTFhOMERlQzZSTnI4VmFxMWRsb2tyRWxLVVUzOXdFcDM3bWtyRG8z?=
 =?utf-8?B?N1JQMFBCcUFOUXJyL2hVbm1GMDg2NHFLSGczcHlITFkvaWpuSXpBTHEzdDdI?=
 =?utf-8?B?aEVSOTlXWkVtT2hOd2ZzR1lTNk03NFZYWU80eGtuaWZVZWh4WCs4OXhMQ0lu?=
 =?utf-8?B?SnppS2I4T2tjRm9yL3U3d1hnRXJvOWE5TjFJK1VDaVFuZlJyTllHWFkvcDd1?=
 =?utf-8?B?cmtOalBiOWZVVkxkSGp3YVlSQzlsVkw3c2VQNVd0cnFYYnF2bmhuaXRSMUps?=
 =?utf-8?B?ZDlPYnMvWWxSejJKY1ZyckxNSUtoS1JtZnhaaVlKOWVrZ1YzUWRidmNmZ1p4?=
 =?utf-8?B?ZVpEYnF5SXJNTXZNZjg4MzZlQ01NMlNhQWptdVRsa0tMR05CZU15Y2FxNTc5?=
 =?utf-8?B?dlhIdmRUQVlpenZmbThQdXNTRnJNK3I3WngwOHlhNmxFK2JXQVlqdk1LcjBT?=
 =?utf-8?B?dmlUVFM0M3VIN2VFYmtmYWhReFlpQkJDNmg2M1NxbTAxRjZ0QzIwM3UxeGV5?=
 =?utf-8?B?cjN1dWJnMFNvb0tsUVMyU3g1VitreTAyRFFZMUkzd2Mvc25oWnVRMlRvTjEx?=
 =?utf-8?Q?EpM/ryn2xSAIbPqoCOxc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8353247-143b-4e99-803d-08dcc0bb98ed
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 01:58:33.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1869

On 2024-08-20 01:00, Charlie Jenkins wrote:
> On Mon, Aug 19, 2024 at 01:55:57PM +0800, Levi Zim wrote:
>> On 2024-03-22 22:06, Palmer Dabbelt wrote:
>>> On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
>>>> On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
>>>>> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
>>>>>> On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
>>>>>>> On riscv it is guaranteed that the address returned by mmap is less
>>>>>>> than
>>>>>>> the hint address. Allow mmap to return an address all the way up to
>>>>>>> addr, if provided, rather than just up to the lower address space.
>>>>>>>>> This provides a performance benefit as well, allowing
>>>>> mmap to exit
>>>>>>> after
>>>>>>> checking that the address is in range rather than searching for a
>>>>>>> valid
>>>>>>> address.
>>>>>>>>> It is possible to provide an address that uses at most the same
>>>>>>> number
>>>>>>> of bits, however it is significantly more computationally expensive
>>>>>>> to
>>>>>>> provide that number rather than setting the max to be the hint
>>>>>>> address.
>>>>>>> There is the instruction clz/clzw in Zbb that returns the highest
>>>>>>> set
>>>>>>> bit
>>>>>>> which could be used to performantly implement this, but it would
>>>>>>> still
>>>>>>> be slower than the current implementation. At worst case, half of
>>>>>>> the
>>>>>>> address would not be able to be allocated when a hint address is
>>>>>>> provided.
>>>>>>>>> Signed-off-by: Charlie Jenkins<charlie@rivosinc.com>
>>>>>>> ---
>>>>>>>   arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
>>>>>>> -
>>>>>>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>>>>>>>> diff --git a/arch/riscv/include/asm/processor.h
>>>>>>> b/arch/riscv/include/asm/processor.h
>>>>>>> index f19f861cda54..8ece7a8f0e18 100644
>>>>>>> --- a/arch/riscv/include/asm/processor.h
>>>>>>> +++ b/arch/riscv/include/asm/processor.h
>>>>>>> @@ -14,22 +14,16 @@
>>>>>>>
>>>>>>>   #include <asm/ptrace.h>
>>>>>>>
>>>>>>> -#ifdef CONFIG_64BIT
>>>>>>> -#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>>>>>> -#define STACK_TOP_MAX        TASK_SIZE_64
>>>>>>> -
>>>>>>>   #define arch_get_mmap_end(addr, len, flags)            \
>>>>>>>   ({                                \
>>>>>>>       unsigned long
>>>>>>> mmap_end;                    \
>>>>>>>       typeof(addr) _addr = (addr);                \
>>>>>>> -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>>>>>> is_compat_task())) \
>>>>>>> +    if ((_addr) == 0 ||                    \
>>>>>>> +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
>>>>>>> +        ((_addr + len) > BIT(VA_BITS -
>>>>>>> 1)))            \
>>>>>>>           mmap_end = STACK_TOP_MAX;            \
>>>>>>> -    else if ((_addr) >= VA_USER_SV57) \
>>>>>>> -        mmap_end = STACK_TOP_MAX;            \
>>>>>>> -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>>>>>>> VA_BITS_SV48)) \
>>>>>>> -        mmap_end = VA_USER_SV48;            \
>>>>>>>       else                            \
>>>>>>> -        mmap_end = VA_USER_SV39;            \
>>>>>>> +        mmap_end = (_addr + len);            \
>>>>>>>       mmap_end;                        \
>>>>>>>   })
>>>>>>>
>>>>>>> @@ -39,17 +33,18 @@
>>>>>>>       typeof(addr) _addr = (addr);                \
>>>>>>>       typeof(base) _base = (base);                \
>>>>>>>       unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);    \
>>>>>>> -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>>>>>> is_compat_task())) \
>>>>>>> +    if ((_addr) == 0 ||                    \
>>>>>>> +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
>>>>>>> +        ((_addr + len) > BIT(VA_BITS -
>>>>>>> 1)))            \
>>>>>>>           mmap_base = (_base);                \
>>>>>>> -    else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
>>>>>>> VA_BITS_SV57)) \
>>>>>>> -        mmap_base = VA_USER_SV57 - rnd_gap; \
>>>>>>> -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>>>>>>> VA_BITS_SV48)) \
>>>>>>> -        mmap_base = VA_USER_SV48 - rnd_gap; \
>>>>>>>       else                            \
>>>>>>> -        mmap_base = VA_USER_SV39 - rnd_gap; \
>>>>>>> +        mmap_base = (_addr + len) - rnd_gap; \
>>>>>>>       mmap_base;                        \
>>>>>>>   })
>>>>>>>
>>>>>>> +#ifdef CONFIG_64BIT
>>>>>>> +#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>>>>>> +#define STACK_TOP_MAX        TASK_SIZE_64
>>>>>>>   #else
>>>>>>>   #define DEFAULT_MAP_WINDOW    TASK_SIZE
>>>>>>>   #define STACK_TOP_MAX        TASK_SIZE
>>>>>>>>> I have carefully tested your patch on qemu with sv57. A
>>>>> bug that
>>>>>> needs
>>>>>> to be solved is that mmap with the same hint address without
>>>>>> MAP_FIXED
>>>>>> set will fail the second time.
>>>>>>> Userspace code to reproduce the bug:
>>>>>>> #include <sys/mman.h>
>>>>>> #include <stdio.h>
>>>>>> #include <stdint.h>
>>>>>>> void test(char *addr) {
>>>>>>      char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
>>>>>> MAP_ANONYMOUS
>>>>>>> MAP_PRIVATE, -1, 0);
>>>>>>      printf("hint %p got %p.\n", addr, res);
>>>>>> }
>>>>>>> int main (void) {
>>>>>>      test(1<<30);
>>>>>>      test(1<<30);
>>>>>>      test(1<<30);
>>>>>>      return 0;
>>>>>> }
>>>>>>> output:
>>>>>>> hint 0x40000000 got 0x40000000.
>>>>>> hint 0x40000000 got 0xffffffffffffffff.
>>>>>> hint 0x40000000 got 0xffffffffffffffff.
>>>>>>> output on x86:
>>>>>>> hint 0x40000000 got 0x40000000.
>>>>>> hint 0x40000000 got 0x7f9171363000.
>>>>>> hint 0x40000000 got 0x7f9171362000.
>>>>>>> It may need to implement a special arch_get_unmapped_area and
>>>>>> arch_get_unmapped_area_topdown function.
>>>>>>
>>>>> This is because hint address < rnd_gap. I have tried to let mmap_base =
>>>>> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
>>>>> does not work for bottom-up while ulimit -s is unlimited. You said this
>>>>> behavior is expected from patch v2 review. However it brings a new
>>>>> regression even on sv39 systems.
>>>>>
>>>>> I still don't know the reason why use addr+len as the upper-bound. I
>>>>> think solution like x86/arm64/powerpc provide two address space switch
>>>>> based on whether hint address above the default map window is enough.
>>>>>
>>>> Yep this is expected. It is up to the maintainers to decide.
>>> Sorry I forgot to reply to this, I had a buffer sitting around somewhere
>>> but I must have lost it.
>>>
>>> I think Charlie's approach is the right way to go.  Putting my userspace
>>> hat on, I'd much rather have my allocations fail rather than silently
>>> ignore the hint when there's memory pressure.
>>>
>>> If there's some real use case that needs these low hints to be silently
>>> ignored under VA pressure then we can try and figure something out that
>>> makes those applications work.
>> I could confirm that this patch has broken chromium's partition allocator on
>> riscv64. The minimal reproduction I use is chromium-mmap.c:
>>
>> #include <stdio.h>
>> #include <sys/mman.h>
>>
>> int main() {
>>      void* expected = (void*)0x400000000;
>>      void* addr = mmap(expected, 17179869184, PROT_NONE,
>> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>>      if (addr != expected) {
> It is not valid to assume that the address returned by mmap will be the
> hint address. If the hint address is not available, mmap will return a
> different address.

Oh, sorry I didn't make it clear what is the expected behavior.
The printf here is solely for debugging purpose and I don't mean that
chromium expect it will get the hint address. The expected behavior is 
that both the two mmap calls will succeed.

>>          printf("Not expected address: %p != %p\n", addr, expected);
>>      }
>>      expected = (void*)0x3fffff000;
>>      addr = mmap(expected, 17179873280, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS,
>> -1, 0);
>>      if (addr != expected) {
>>          printf("Not expected address: %p != %p\n", addr, expected);
>>      }
>>      return 0;
>> }
>>
>> The second mmap fails with ENOMEM. Manually reverting this commit fixes the
>> issue for me. So I think it's clearly a regression and breaks userspace.
>>
> The issue here is that overlapping memory is being requested. This
> second mmap will never be able to provide an address at 0x3fffff000 with
> a size of 0x400001000 since mmap just provided an address at 0x400000000
> with a size of 0x400000000.
>
> Before this patch, this request causes mmap to return a completely
> arbitrary value. There is no reason to use a hint address in this manner
> because the hint can never be respected. Since an arbitrary address is
> desired, a hint of zero should be used.
>
> This patch causes the behavior to be more deterministic. Instead of
> providing an arbitrary address, it causes the address to be less than or
> equal to the hint address. This allows for applications to make
> assumptions about the returned address.

About the overlap, of course the partition allocator's request for 
overlapped vma seems unreasonable.

But I still don't quite understand why mmap cannot use an address higher 
than the hint address.
The hint address, after all, is a hint, not a requirement.

Quoting the man page:

>    If another mapping already exists there, the kernel picks
>         a new address that may or may not depend on the hint.  The
>         address of the new mapping is returned as the result of the call.

So for casual programmers that only reads man page but not architecture 
specific kernel documentation, the current behavior of mmap on riscv64 
failing on overlapped address ranges are quite surprising IMO.

And quoting the man page again about the errno:

>       ENOMEM No memory is available.
>
>       ENOMEM The process's maximum number of mappings would have been
>              exceeded.  This error can also occur for munmap(), when
>              unmapping a region in the middle of an existing mapping,
>              since this results in two smaller mappings on either side
>              of the region being unmapped.
>
>       ENOMEM (since Linux 4.7) The process's RLIMIT_DATA limit,
>              described in getrlimit(2), would have been exceeded.
>
>       ENOMEM We don't like addr, because it exceeds the virtual address
>              space of the CPU.
>

There's no matching description for the ENOMEM returned here.
I would suggest removing "because it exceeds the virtual address
space of the CPU." from the last item if the ENOMEM behavior here
is expected.

> This code is unfortunately relying on the previously mostly undefined
> behavior of the hint address in mmap.

Although I haven't read the code of chromium's partition allocator to 
judge whether it should
be improved or fixed for riscv64, I do know that the kernel "don't break 
userspace" and "never EVER blame the user programs".

> The goal of this patch is to help
> developers have more consistent mmap behavior, but maybe it is necessary
> to hide this behavior behind an mmap flag.

Thank you for helping to shape a more consistent mmap behavior.
I think this should be fixed ASAP either by allowing the hint address to 
be ignored
(as suggested by the Linux man page), or hide this behavior behind an 
mmap flag as you said.

> - Charlie
>
>> See alsohttps://github.com/riscv-forks/electron/issues/4
>>
>>>> - Charlie
>> Sincerely,
>> Levi
>>

I accidentally introduced some HTML into this reply so this reply is 
resent as plain text.

Sincerely,
Levi

