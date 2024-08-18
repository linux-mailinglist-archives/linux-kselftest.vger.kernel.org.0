Return-Path: <linux-kselftest+bounces-15598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8778E955D32
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BDFB20BBC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AF71B3A;
	Sun, 18 Aug 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ucYObtys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2084.outbound.protection.outlook.com [40.92.63.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF81F9FE;
	Sun, 18 Aug 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995313; cv=fail; b=BrrGR/my18S5W/LuBjwOwQDI90ZMaPinSzkXJGWKyyRgjRa318nni4iB+kFQd1CH7t+iTgGAzBeN0klEMNFpBd+zwlN97BvHU9bJOoTIUSpErrP8nJ1S4cXjjzPeKvjCmPRfzbsnM8ulwCE3MiRNS/hc6tEFeGZXanPJqetU1Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995313; c=relaxed/simple;
	bh=V35n7ST2Zo7kzY16Zswc7YBC7HjfxHadSXB+LoDPGwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUdQpTB8sVsx0kR0O9EsHjDTWeVRfr7JAs3bY+/bnYdom0at1Z66uLxcjBK5+9bRTMRWeUIEeaiK7rySTHUrClg+4k/+J3K9VtZH1zoOn+olmEV/NrZOFMhR3lURMKdLP8EtO+t63SRMusVB06lNc2kNp97snMfB5Hm5PKFH9is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ucYObtys; arc=fail smtp.client-ip=40.92.63.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PszuBYObxJWwH81LjVn79UeZ5VahCapx7vV6qyggX3kVTjTCHBLf/2f7LxTZVPvSUENlpPdof3DMW06z9qY/B1yJapT4Xi4pIdbsAoStcgNrTqpC4JWTVB7mAPpZAM9Q3/uj36sre8Oc0Tz+UVcckTeEpUzt3mAnvao/ncQzED106NPckqTVUHd9qavVwmkMfSTBoHqXnrIXCSQKkFYZ97BaQvdxVG+PFlxbuEMl3qpOjTJJ72PYGTh+cj21x0zM7McVV8hD2K3jTzn6dCwxp4zcUa5dwreVDfVMt7Uu1QOD7BJAoxVkCslmNnTdbf4KUkn7aEPDSO4tx+tDkpep5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr0T1k7pe1Or73vw+EI52hMvc3Tzj4xzrHCDKJ9LI9k=;
 b=oooJlL/KSdKx/5jp8H4aKJHA6WxlgJ0Oq59Hoe2mCVTXMlqsllzmD7Va0H/Y52W+d6C+uJwNEHzzO9oQlAjHLp73Oh/jgSAkSZgtI/XRUdlC6GbUVolM6GVQjPSKet05WM47CpJ3rBfdiVAKmqst7EbFPBN+xkMLVHN0xcHCVY5K/keZFvJzrztf2khRJ3L5Onb+w4CjdjEVnFsKP4zDjK8yU8uNJXy2FbM4eLqk81+xnR3MvTKje0JwezHHsuQzxrOftrHsX+6Ol6UKtkl7MJWtPqyqYNS0l0Qk5/Yy+rE1Ag8I20kgI/y7dYQLgpLdyOSSU4i3Haos4BaAdshUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr0T1k7pe1Or73vw+EI52hMvc3Tzj4xzrHCDKJ9LI9k=;
 b=ucYObtysLD4ZUbMQNpbfjwm7CrM1Exwv8fPSDuaTPG6sEF4wgoQ/C661RJxwkd69THjNUZQEU2J8FbTEekcja8b2kUbZm74wXdd4SlZ4GGDqp/Sqe4G/O6bH5ch6US4zmfJobYlAaJimNnYSir84KGxdbW0KRb/bk0/bz1DmLIhe9L/NaUT9xzFGDLed0Ph9QoTUDZ2mYTCIntk5hQmz0C8tG0S4P2yQm2iChOA2RXoPjlRJggLDjQq+z9JnYna70N2RJSEGQjxGh6OnqR1LDNQO/F3s/jPpWMo47WE9QIe3f9o0ULg3X00ajVWPlHg1guftxpBz65+4QoXBV+blXg==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY4P282MB4129.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:19e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Sun, 18 Aug 2024 15:35:03 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 15:35:03 +0000
Message-ID:
 <MEYP282MB2312DEC63DE874040DA00BA6C6832@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Sun, 18 Aug 2024 23:34:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: cyy@cyyself.name, alexghiti@rivosinc.com,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 shuah@kernel.org, corbet@lwn.net, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [ALOsiaqmspGlpO5UIuHDu69kgB3Vkv0voscW+Ezar/LWIc8+6CV6QZTsJ+oK6ely]
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <197be721-6959-4a3b-b0a5-f37a24849d1b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY4P282MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 154e4763-20ba-4681-075c-08dcbf9b542e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|5072599009|19110799003|8060799006|461199028|1602099012|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	dT+2HfgwF4tWHXxB/TXsMk0zA263wXlwIMiOGBQda76j3tFgEwwusInvORTtZaJRoXMwFm8L7WBtaF+p9VFwe+VUA06u+sHah+wICPn1T3A0SkGTGtNvS1Cl2TeeMUaj7539lfWe76PiodCp2CckNRP1YC0PohqwcRfXWjPJj8kCcUhoQeMbvnY5aVBf+msaJb9GtZwdEQg9O2hUrlHm60rgoBmPQzLmdaulvQcg1VSxcONw4K0aQ36bg7pK9ZA42CuYF99XwflssQsbabH6jzcGxSJRqEW/CJlIufOvSk0yE8PsXgK+gHKy8REpwOjxKtKzuJxGzMIDv0POWOcSu69u0pTBqAl6sIDtCWwOI1VQ2xqgO0epBzz6jFUVS+UkmVoa4WDCbAxzR4tiSUciyAXZBdOOw9tuvb7Mzf7S4Yi2+93hCloQB8Z7A+dy1BWBkBg6xLqt3aASJnMN2pILJeRlEKtDSbdw+fM+qZ1AssjzD9EzE8XkNiuqkuD6Cuo0SxX7MRXCLTVwPQ+nPXofs2sZHPqZ1jPIfD7LLN4YsHkV0qmLmCCCajGUX7Tf4/fj2C9j/WqUAD6va5XWrjQf9GJdRmLI4+6+0OwHuaZg82+T5TJn1TeRjwrw7TFybjQm2698/VMUY2auwQ6AkZ0A9CB/iPsFF+5Tb+UyJVTFCaNrgVTFlIjjVynnkVtgly/oCVX8oMnIsEpJPaGu0AWsNZ8qr010iacRKfMzry5XbiaDzt7HpSFtdtd/qJVmmgYOFTb+ieLzMGVGhJ5X9SdJavoWlQ4dieB+efR6qIOMjMy6HiGvE8PtAHWS9XB9/o+LKkjClUpllVA98VW3AjIHlg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBRNXhZU3d2enhHdmZsR1JaeSs5VG93MW5yQllUWi9KaEVtcGs4c013dEJo?=
 =?utf-8?B?L2cyak10a2VvMm1UUWo3cm0reGhTL2FxZ3FOTExEa3ZvTUZwVmhpT05kRnIz?=
 =?utf-8?B?eVRPMEQzV0h2L3JJL0F5Rmo2Q0NwTmxXTFliVWtTREpjR3NlSG5IRzRtdXVN?=
 =?utf-8?B?dURKeFVBbi9JMG5CYjBlTEhXU2dlU2E0WlViT290YmhhdnJmYXJZNnVLYjRx?=
 =?utf-8?B?ZzNUU1VBWGRQNVdiNHkyYXprRVdXTlo1c2c1Ylh3WmE0Tnc0Y2tsMzZISm81?=
 =?utf-8?B?dkI5QVp5Z05JVnNHSE83eXgvR3V5THo0aTNSUXFuRjRIYUNXL2lYYkJPWVgz?=
 =?utf-8?B?WVRMTkhlZ1lyb2orb01ZcUk1cTRCSXhQajdvU2N2enJxbG1MNXdKSUhwTU1P?=
 =?utf-8?B?NWhlOTBCNFZhWGpTbHZscnNWNEdwSG40R3Y0aFUrZmhITjhnbDBoaHloa2o4?=
 =?utf-8?B?ZW5NNVNkekFkRzljaE1mbWNPOEpuMW5SSlZaT0M3R0tCOWNsTk9HaTlCQ05W?=
 =?utf-8?B?Y3duZmw4andCM0xyWjRraXJ1UUhlcmxRdUk2UE9zSG5vUmpBV2NrelVkZmQy?=
 =?utf-8?B?U2lLTjEvOEFES2Z0OXBJV0FvejlndkIraUdFOW56ZUM0c0orVGRVNDd4TUFl?=
 =?utf-8?B?QjRERHZqNHhMaFV1MWdEanltaGdPTjJ6aXdPTEpHR2orVWg1Y3NOVGF5N1FX?=
 =?utf-8?B?cXRCZjh4UFJoR0ZPdm8rdVRERXFyZG1xV3NUMmp4clJGY3FvK3Qxd2dURDlN?=
 =?utf-8?B?N0RoSEVLb29ZMkxFSjcwR0hFYnJ6RUNpNUFRdktLUVFNZ3VYWkp0VEdoM0dV?=
 =?utf-8?B?MHpuVGZ5TkxCcDZ0Qi9hVXpmK1hDMi85ZTBNeDZndGZ3N0w5Vko3VlFGcEdp?=
 =?utf-8?B?RzgvN1NVSFAxQ2pwWUQrUnc2TmFnYnY0YndkOUxUb3RPeTIrdE9zZ0FvZVM3?=
 =?utf-8?B?TUlXbmJnRTRnaWpBWWxybVZrQndiSlhHL0xhTnBWcG53UkUySTNobWFDZVpP?=
 =?utf-8?B?dk9NbUlLUWxCOG5ReTNHdUp6U0Erd09hU0Y5RHdIYldFeUNwY1V5TCtkZ00w?=
 =?utf-8?B?SW5IZ201NUV4WjYzUzFRaC9SNFZOZEVOM3FYM1FyRDhLUEZtRlVSWHVLRW9D?=
 =?utf-8?B?SlpOSVUySFZ2SXV1Q0liNkp2RnhtMVVZZzN4SGlHMDg2b1dJaHdGOWdYc2lk?=
 =?utf-8?B?bUtuMmd3bUlmSzRBSWczYU5tUTJvT01DK0dTSm5rVDM3N25CdG9wMTFNYWYx?=
 =?utf-8?B?eGI3aExjV2NvRDAvSFlNb29OS3k0ZklwQUNpR0dWV3pGd0ZOQlZKZHgvQmFT?=
 =?utf-8?B?UU52K2dKU2tHSjFQemZUcWgxcThzeXhoOStnbDhhR3NxS01KWXBDVU1TZlhP?=
 =?utf-8?B?NXpjUms2am1NSXFXVlVDV0FpSXA1MkNKLzNLem1LQkNobzREOEVnU1YySXU1?=
 =?utf-8?B?c0xqZ3dyTldHTE5DRExFeE54ZVFhcXV6Y3U5bTlXS2ZUT2YycFk3WTZLcVJz?=
 =?utf-8?B?bUlueExyeFNJWDJPVzZOZDRDZmhpMVA5a1Vhb3FUUC83YTZKVlh4SzdkK3VZ?=
 =?utf-8?B?bHc2Z01vT2NtbStnMnNpNlVjYklMdzlTQ1hyY0l3SW1VQUNmS3hMNGxiWWd2?=
 =?utf-8?B?S0NKV3FVRkpqdGYwRG85RllDZ1dOMEhzb0dlbWlGckx5YTI1WWdLZkZibG9G?=
 =?utf-8?B?YnZUQWQrMFF5ZHlzSmhEMnhMdmdoUzBIVDU1NWlIOUptbkdBSEN1MmxseTJn?=
 =?utf-8?Q?t3f7G8jvb+bLHebm4n090NXJqu2OeHTLdqRnbSE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154e4763-20ba-4681-075c-08dcbf9b542e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 15:35:03.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4129

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

I suspect this has broke chromium and all other software that depends on 
chromium on riscv64. See also 
https://github.com/riscv-forks/electron/issues/4

>
>>
>> - Charlie
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

