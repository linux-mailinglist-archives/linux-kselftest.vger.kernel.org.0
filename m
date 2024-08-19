Return-Path: <linux-kselftest+bounces-15618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D339956360
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 07:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C228194B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 05:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1014BF8F;
	Mon, 19 Aug 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VBJCKBAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2026.outbound.protection.outlook.com [40.92.63.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365F171CD;
	Mon, 19 Aug 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724046981; cv=fail; b=XaqA3zhfyoNtz6RHuHXCIYOa8/4m9gWIaYokeWPtVg4gvm5HDD0kH5siCGwftkbPcW8Ow117L8sfN+Xtq2/qJ0Am/FoJhmyWRMIDBY+/l9iviqLHco+HsuuITjUKrJhkRyHqw6JmqSX+9MF3O0TcW2nvwl2xEkgpTL8BqCVhQxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724046981; c=relaxed/simple;
	bh=4OGVmbbz+hZA9iGhroL9wbXF8K/C4Ol69E3Vp1kUXb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFbGu7s0DbUbJLBWBlNP0kA0DbJGz4MGe8qvUh+TYap3Zo6WHHuZ3AzYTQmEgY3J7DpJXrbsl7l/1GivFlX7l5LZl79QRf4RlCpQudlHWRKfzMi5x9cOd2Pvzpt+ZuvSbLbHOFLJkQEX2rYXPXS4wRWHGzI7PuQeNfwwVgy7MuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VBJCKBAg; arc=fail smtp.client-ip=40.92.63.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEiMRqT7MLTbj078A55940sRny8kxDBsh6/vUWpImDGVqFwaEOxvWFqOMwm8kjcKLxPgiw/SMZICPkR2zHL3Wn417QANuKRk1CrH1M5b35rruB0WkFMUgvq56T6rwGGYj6t8j1OqQ/nPQcc0OxrI6HXjn2xDISzmfYoEWUrtjAGxC8O2aRONj+PTY4LNTcfHwU/ybgkXHChFKJLcqqL89Vu7+cDkxo6VGWFLhJPbs6j/6Y9OvJlMTLH5aW2jb2ObE/g/GrayUs4DmkPpF1bl8fP+UzKJlHgEgG6UehyjqOYA52QU3x5rAyy4sSzeKqvfx9zyHWufnWRFDKX1aFQXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PtexpzEd/3bcFRDLT5Hm8ZbeEY2R42umcTdiP4gRVI=;
 b=ipCamXvkr9G9SQVUfI2B27l8LOOOP9/FbZdxBmbmslaT034QevEGzCepaF+9rJQpAZ9LolZMHf5Z71f08EA+VZNTomvQgPZITCRX4e7RkjIlrGFyNMVLCRSnyXhq5zyyYI3sKuiT7GJrR1rmN4Dt03WOJWw6JxFxB1pprjFpOHrzPeRZBUXD4f51PIBMrg99+DlzruiDqwn2UIDUCyVOwj1gBO0BzPDer0q4/vydQjHleX7TNtsCwa+vVrSHnAC1jQvOR+axPDJxhAgtk7BNC7YHCU+yvuIM++xMgLCs+jqHyHCst/ir8TBOfp0XvSOUD03LXruQBzwy7cm1rLWu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PtexpzEd/3bcFRDLT5Hm8ZbeEY2R42umcTdiP4gRVI=;
 b=VBJCKBAgBGfLEfxWexLoQnUdCdJEvVTlbWoyGCEw9NBLyyML4tluuDUWOIoCcx0owYwcMbpKcoCYbzxrGi3lII9rRgUzGC2b1imTsnkaEnySm40f3HTji6Rl5JjKJxZ+8/TugH6pZsvT0Ngkzb3RPQIofsYcAaXpT+8S3qmb0x7W9M83P7Id2gmvrMdtbaZ1PvqbkWU1jH5NxfGscSXBVtm5SFyzNiSrvSZkR3aV56V7/tHm7/U407+rZ/aYZAWWJ+6GrewKHcPXVEcTSw9H5NV2hwIVtp10rKZPIHcQlBR0V5qBGCx0YVjb1JL6jTu/9jOFXqmbMyLcYoJDMJ5X0A==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 ME0P282MB4328.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:227::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 05:56:13 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:56:13 +0000
Message-ID:
 <MEYP282MB2312106710775098261AB348C68C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Mon, 19 Aug 2024 13:55:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: cyy@cyyself.name, alexghiti@rivosinc.com,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 shuah@kernel.org, corbet@lwn.net, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org
References: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [WNCVloEgJucfNPQxOPeQ0VhQ7jSUWkrTAwD+5WvngAIc2m6zSc0X3bIIWdBrmC+j]
X-ClientProxiedBy: TY2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:404:e2::19) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <cb1a98ed-6fd5-40f7-bee0-357110c7131f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|ME0P282MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcd4fbe-fb54-49d3-4e42-08dcc013a1a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799003|461199028|5072599009|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	0+QX/LL6DxwQAkfCzWryQaNvK0iDSOxAMDoCqO9vjKz26vjk71IQrHh2xUKHKKIMtuRUkHdeBWP/zzPC2umq+P8xIG14b/XvVVpDbtkk7Rj880M/42nAEsuLMUdV3hyulzfFUlqDTKt6QCtMihJ+Z0FB224LSp7X5UjP/fQ046JU4mXmKiRbgnJIoYfzEETJP9TpjDbtNnOTWryeSgC8PbFOVL1uc0tBx022HAGqbzkCKn7b6aGvYGddNg2EkCy+ziTCVfG1zf1Cu28hmqLRutwO3+/RIBbmWwdiKVrOaYVVSq4E1PSInnt1PYpmB0zUvYtkJi4/sMLeH4pv4S3at9IYGHlxJkRSscHcwJsmnWTyx1QOQFc4obTWmORu+duO0yhzovE4HCMxm0PudUaUNQZwYIWkP5k6eQFVutFe7gxz15nHe/rDla+OcEVq3j9ouxVav1kvlmEQBLFELH24dm5+JkGnIE/M8lhMjUphCdOaF6fdePM0AZY0fFK3JmAJA0s1Cz8CZ93S3wYS7vCAYPaWSukzwXfb0BJFIjHQPkkV1wnhLAz7bikFPoNOo24JEfqxi2lOyNLvdKJSpvQSwJOfws9Bo4YfzYzxBLHI8QXCFVTuuXS/Mqn8Z9/lNTMBczcnhHj4PJH7+2/fY9jQh1Bp144MbRzkycBTncBuOfI1WQxefmuzr1Thkspp54johXQhkCh8mA/dPgUlArYMZFvQAWkdBgFb2i5bXAJ7Z+h2grExt1tPlvXzSwqX4SM75VoQuvLGy0p5onRiUiVkGwCOVwB7SvAV+R3dsJLDoYTNdI3IsCJaJnCT/Pbb+ltf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVCZG12M2tRV2VvMEtWM3UzODlBTDVZZk1xWDlRZnd4djBRaEZ1UGtIOXJ4?=
 =?utf-8?B?c0h5WCtZTzJKazZySDNYdVdNeGJzVG9mNklpM21vczVPTnVyYVVEUDFRU1Bi?=
 =?utf-8?B?M2szQ3ltb2EyeUNxZW1VdWJkR2Q2RWtzemxndEc1OXlidGpJa1FieWczVFhx?=
 =?utf-8?B?aFNuLzg2TGhmRkdwUWZpazU5NlBDTVVNUnpCRWxCWU9FcDBpU2VOdllkR2VJ?=
 =?utf-8?B?VVgzUXo2ZEI0dGwrMHlKNWRmbnpFS3g4cGhzd0tzdTlpU2kwdXVJOStPMkth?=
 =?utf-8?B?UEtlNUNiZzBkWnkvdGVXaEI1V0oyS2JrZFRQTzI4WlZyR1JkOWZnWmlZUSs5?=
 =?utf-8?B?b0RQZ1Zkblo5a1B6Tmk0SjBhcnpCWVRjV1FIUUIrWUh4bCtsU3RhVjRTZmNm?=
 =?utf-8?B?UkF3Yk9Od3NPL1lwS3R5dHZOSi9mdnVHVVUyeERnZUdaczNxMnRaUkIya2RP?=
 =?utf-8?B?THN3VXFrWXBETHJ0TldwRjRwYmRmSUdwOWt3WXlmV21wY3czd1lhVE5DYVlL?=
 =?utf-8?B?ZG1ka0hYMmtiUTZxMlMxaEY5U1A5VFZjOVBRYzErMnJDRzV3VTJRdlJWVjdC?=
 =?utf-8?B?bHVxZ2s0WU5ZOWFDL1FxVVcvenFMdHcxbEtxckJrdFAvSHFveTVMelREbDNq?=
 =?utf-8?B?Nm0xekxQdVo1c0dTV0x3MEJsNXNJNytDcFpxa1pPQk9ZUEc5QVVXbWJqYURH?=
 =?utf-8?B?eW1XdjNGWTEzYVIrZ2E3Z1Vib2orMStkMkVSQUJMQmp6RWlrVjRSRzljd0kx?=
 =?utf-8?B?QmlPWG9TUlZnSGFJNlZiR1BYR1ZHVEMvVk8yV3Y5NHNDUTNMMjBsVVR3dW9y?=
 =?utf-8?B?aVp2YjJNZEZlVG5UemFwNFhIeXk5VG13QWl1cGE4L29GeFEyUEV1OEpFdnRU?=
 =?utf-8?B?aUZ0cC9pY095alY1K1kxVHRSeldKaFdpNnRWeUJSdnArQnZUVWgwekQrbC80?=
 =?utf-8?B?bkN3TVBTdHpjV0lsL2laTVREM0dGZXZab2JpNThKelI5MENOU2tsRTYwY0NC?=
 =?utf-8?B?UTYxcCsrTDUrcjNPbTdvdGJLMmY4MEhCSFRyRkJYNlRuY1pXUHVSeVRuUVpP?=
 =?utf-8?B?ak1zOGdEd2NxK3JsMTRRTEZXNy9HQTBTOEZadnRTNGI0RFFtbDZaOTI1VEps?=
 =?utf-8?B?S09QUkJuN0ppMldwUHBTU0FYL1Z1bjRpcVQ0b01tSXZ6R1lSRzVHUk4wdzY3?=
 =?utf-8?B?YzhQbzJuZlR5VXJrOEllOWQvSHRTeU5CeWgwdlFTNjQ4MmNMR1VLY041NUNS?=
 =?utf-8?B?c1ZEYTZpSnkxY3VZengxL0MxM3AxYTd1dW82ZGF3OTlJQnQ2SXdiTnRwRHhv?=
 =?utf-8?B?RVhSWHRVblc0bVBITWZ6MjFieVJac2ZRRVhIaTVhc01hU2w5bTVpTWVpallj?=
 =?utf-8?B?c2JPYjl1cWxRV3JXYjJ3VjZwRkdsc3IxeG1IRVU2YlF3YTBkUTllT3BqSkdH?=
 =?utf-8?B?ZUhhK2wvM2VlZDhsRDY0WnJpRUtlU05MMGFrUDQ5U1EzUnZ3VVdoSXBZTGRW?=
 =?utf-8?B?amo1Tk02NlZGRlh5aW54bXhRS0s1Tk0vMFhsQ0pCUy8yVGpGOGQrVnd3R0pD?=
 =?utf-8?B?SzhMR2NhTGV2Vlp3cWZEL0cydU5jWVhFMjJrVXdIWWVuNVpEeW9QQWFXalFN?=
 =?utf-8?B?alVYWVJyZWg3M0FIMDdLbEZOY1JIY2szZFEzUG5sMGhZaUszQzZ2SVZyaC9H?=
 =?utf-8?B?MWx3cVFveWxmZXJtZDBuU1A1TGVLYWs4RFU1WVB3dUhmRjBacVJ0b1RVRnNI?=
 =?utf-8?Q?nh3uC/DzBZrirSu0jVY2wWAWbZgwms6hBJrJV/t?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcd4fbe-fb54-49d3-4e42-08dcc013a1a8
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 05:56:13.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB4328

On 2024-03-22 22:06, Palmer Dabbelt wrote:
> On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
>> On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
>>> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
>>> > On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
>>> > > On riscv it is guaranteed that the address returned by mmap is less
>>> > > than
>>> > > the hint address. Allow mmap to return an address all the way up to
>>> > > addr, if provided, rather than just up to the lower address space.
>>> > > > > This provides a performance benefit as well, allowing mmap 
>>> to exit
>>> > > after
>>> > > checking that the address is in range rather than searching for a
>>> > > valid
>>> > > address.
>>> > > > > It is possible to provide an address that uses at most the same
>>> > > number
>>> > > of bits, however it is significantly more computationally expensive
>>> > > to
>>> > > provide that number rather than setting the max to be the hint
>>> > > address.
>>> > > There is the instruction clz/clzw in Zbb that returns the highest
>>> > > set
>>> > > bit
>>> > > which could be used to performantly implement this, but it would
>>> > > still
>>> > > be slower than the current implementation. At worst case, half of
>>> > > the
>>> > > address would not be able to be allocated when a hint address is
>>> > > provided.
>>> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>> > > ---
>>> > >  arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
>>> > > -
>>> > >  1 file changed, 11 insertions(+), 16 deletions(-)
>>> > > > > diff --git a/arch/riscv/include/asm/processor.h
>>> > > b/arch/riscv/include/asm/processor.h
>>> > > index f19f861cda54..8ece7a8f0e18 100644
>>> > > --- a/arch/riscv/include/asm/processor.h
>>> > > +++ b/arch/riscv/include/asm/processor.h
>>> > > @@ -14,22 +14,16 @@
>>> > >
>>> > >  #include <asm/ptrace.h>
>>> > >
>>> > > -#ifdef CONFIG_64BIT
>>> > > -#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>> > > -#define STACK_TOP_MAX        TASK_SIZE_64
>>> > > -
>>> > >  #define arch_get_mmap_end(addr, len, flags)            \
>>> > >  ({                                \
>>> > >      unsigned long
>>> > > mmap_end;                    \
>>> > >      typeof(addr) _addr = (addr);                \
>>> > > -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>> > > is_compat_task())) \
>>> > > +    if ((_addr) == 0 ||                    \
>>> > > +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
>>> > > +        ((_addr + len) > BIT(VA_BITS -
>>> > > 1)))            \
>>> > >          mmap_end = STACK_TOP_MAX;            \
>>> > > -    else if ((_addr) >= VA_USER_SV57) \
>>> > > -        mmap_end = STACK_TOP_MAX;            \
>>> > > -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>>> > > VA_BITS_SV48)) \
>>> > > -        mmap_end = VA_USER_SV48;            \
>>> > >      else                            \
>>> > > -        mmap_end = VA_USER_SV39;            \
>>> > > +        mmap_end = (_addr + len);            \
>>> > >      mmap_end;                        \
>>> > >  })
>>> > >
>>> > > @@ -39,17 +33,18 @@
>>> > >      typeof(addr) _addr = (addr);                \
>>> > >      typeof(base) _base = (base);                \
>>> > >      unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);    \
>>> > > -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>> > > is_compat_task())) \
>>> > > +    if ((_addr) == 0 ||                    \
>>> > > +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
>>> > > +        ((_addr + len) > BIT(VA_BITS -
>>> > > 1)))            \
>>> > >          mmap_base = (_base);                \
>>> > > -    else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
>>> > > VA_BITS_SV57)) \
>>> > > -        mmap_base = VA_USER_SV57 - rnd_gap; \
>>> > > -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>>> > > VA_BITS_SV48)) \
>>> > > -        mmap_base = VA_USER_SV48 - rnd_gap; \
>>> > >      else                            \
>>> > > -        mmap_base = VA_USER_SV39 - rnd_gap; \
>>> > > +        mmap_base = (_addr + len) - rnd_gap; \
>>> > >      mmap_base;                        \
>>> > >  })
>>> > >
>>> > > +#ifdef CONFIG_64BIT
>>> > > +#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>> > > +#define STACK_TOP_MAX        TASK_SIZE_64
>>> > >  #else
>>> > >  #define DEFAULT_MAP_WINDOW    TASK_SIZE
>>> > >  #define STACK_TOP_MAX        TASK_SIZE
>>> > > > > I have carefully tested your patch on qemu with sv57. A bug 
>>> that
>>> > needs
>>> > to be solved is that mmap with the same hint address without
>>> > MAP_FIXED
>>> > set will fail the second time.
>>> > > Userspace code to reproduce the bug:
>>> > > #include <sys/mman.h>
>>> > #include <stdio.h>
>>> > #include <stdint.h>
>>> > > void test(char *addr) {
>>> >     char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
>>> > MAP_ANONYMOUS
>>> > > MAP_PRIVATE, -1, 0);
>>> >     printf("hint %p got %p.\n", addr, res);
>>> > }
>>> > > int main (void) {
>>> >     test(1<<30);
>>> >     test(1<<30);
>>> >     test(1<<30);
>>> >     return 0;
>>> > }
>>> > > output:
>>> > > hint 0x40000000 got 0x40000000.
>>> > hint 0x40000000 got 0xffffffffffffffff.
>>> > hint 0x40000000 got 0xffffffffffffffff.
>>> > > output on x86:
>>> > > hint 0x40000000 got 0x40000000.
>>> > hint 0x40000000 got 0x7f9171363000.
>>> > hint 0x40000000 got 0x7f9171362000.
>>> > > It may need to implement a special arch_get_unmapped_area and
>>> > arch_get_unmapped_area_topdown function.
>>> >
>>> This is because hint address < rnd_gap. I have tried to let mmap_base =
>>> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
>>> does not work for bottom-up while ulimit -s is unlimited. You said this
>>> behavior is expected from patch v2 review. However it brings a new
>>> regression even on sv39 systems.
>>>
>>> I still don't know the reason why use addr+len as the upper-bound. I
>>> think solution like x86/arm64/powerpc provide two address space switch
>>> based on whether hint address above the default map window is enough.
>>>
>>
>> Yep this is expected. It is up to the maintainers to decide.
>
> Sorry I forgot to reply to this, I had a buffer sitting around 
> somewhere but I must have lost it.
>
> I think Charlie's approach is the right way to go.  Putting my 
> userspace hat on, I'd much rather have my allocations fail rather than 
> silently ignore the hint when there's memory pressure.
>
> If there's some real use case that needs these low hints to be 
> silently ignored under VA pressure then we can try and figure 
> something out that makes those applications work.

I could confirm that this patch has broken chromium's partition 
allocator on riscv64. The minimal reproduction I use is chromium-mmap.c:

#include <stdio.h>
#include <sys/mman.h>

int main() {
     void* expected = (void*)0x400000000;
     void* addr = mmap(expected, 17179869184, PROT_NONE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
     if (addr != expected) {
         printf("Not expected address: %p != %p\n", addr, expected);
     }
     expected = (void*)0x3fffff000;
     addr = mmap(expected, 17179873280, PROT_NONE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
     if (addr != expected) {
         printf("Not expected address: %p != %p\n", addr, expected);
     }
     return 0;
}

The second mmap fails with ENOMEM. Manually reverting this commit fixes 
the issue for me. So I think it's clearly a regression and breaks 
userspace.

See also https://github.com/riscv-forks/electron/issues/4

>>
>> - Charlie

Sincerely,
Levi


