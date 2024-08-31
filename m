Return-Path: <linux-kselftest+bounces-16884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D39966F1A
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 05:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A511F2323C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 03:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A1B39FC6;
	Sat, 31 Aug 2024 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="K0Qf2D9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2033.outbound.protection.outlook.com [40.92.63.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0B2F2E;
	Sat, 31 Aug 2024 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725075256; cv=fail; b=h8uipnetIjLr/ioxJlooK8nfGyiAlx0SpNc82R6/Ioa91SQnpOsoJTIxSioiPdDpjN+WyvGrnD6Z+FL4ZfPnJ2X/sbAdfSXqpwmN+OZTQMFuI4vBU7NKI6Jy3xFQmrZZL82T54S2fUF4pcmblfWuHleIN2YVmq+n7THsE+lxEos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725075256; c=relaxed/simple;
	bh=wgPNELWRCndsoodG2PiGy0NgvSIBKn3fHJIEYu8V63w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oX8YuwLnpEhECPSB4FPjK7mMeawdRzd48GhBwQbnmefVgeTzfqFbDeeNY46hnvS47KDvQHe9VqGnIBp6ptwcTY5sWimnKMe8PaG0n5y9aIKV+PNBtcZS9sFRTPTxSBiPITUMGxLV9SMQD6QIHtgyOEYw9EilMc2ca+89lv8tpW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=K0Qf2D9Q; arc=fail smtp.client-ip=40.92.63.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g91CXYnHH9cIqsglugrNCd6Bj1cX+I8XBxCph7Y76TGPHLHrIe6eiZCqQ5YXTV6K+JDzQgo3CHoxjSlkb3Q0jUol8eWuDzJwHbIwJQ25XNdaFSuC9ZJiI6cY0Xf9+FAimVNH3V54iOxk63E9QQlvX2Bhh1j9SU9PAXMOjNIrX5OZMUeMZ97zhwDg1suC0KatALAVktFT3Gm4XJkQHBgXm0nNcitshLS0gsM9h2arUxPzJrqo8mUA27HgaI3Q9ikQf6z0F1u6gn0OS24VmyPQ0ubowl9s8Pwvx/qsISH8LM0v7HJ0o58ehqdCK25uqGxwx5oL3wQT5yQW1GgWitGTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHauG8AlPUeAzUasa+fgao591JMNiBnKP7Vd6tpC/bo=;
 b=ub5lnVdDpOWJ1Kcaw2/hbuwWF41hoGtUDb+mfB5d1EDkGeP8LuDzhkJLQHW5piLsbEF7fOvYEAjAin2S9vhlpfJ4wWnnC5HFarl4siYDUAbRxoR4uGCeOSil53CuFYtygYHBBvcuZnwzPay2vEAMeeeZ+iSBY33v7f5Fa7wPZEGGxoPU7yWqhASxlZiB6KUrGOZ/aiwxCuX8o8TtPWLBbK6na8C8lew8l6QKI4UitrkRgF1NJfrSJZazIDJr3H6muAinakx6PxUzabN6jFfoQNlGkAFVPFjw0ERnLEUKwBZm3ud3cdJtLkLTLUA2u4n3Zm7r1q/6o9sO8fnwd0IASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHauG8AlPUeAzUasa+fgao591JMNiBnKP7Vd6tpC/bo=;
 b=K0Qf2D9QrlP1XmvVFLwN5gV9cMK8RZFKZWkdGDapgEHzEgJ2VCiJQaUSsEveuP6vJyC3IV/93DntrIK+YbIIak2G+e+ONCpoxLtk7ehIKGcHhA6FCib4wkSDPhSHPnOB9DIRKGDj5yKWkXIDHO5Onkykoj1Lq9r3kSODEnHYQxbp0GFT18vFy8Upueaiu5kcV5iRx6VNdFYiVaHXnqrWcnIYzPGvghmbaIXOvCpJkVq3HmKUXVx2JZsy+Xpzx9kKIUofdqgxL3lXanceStk6P00vaqyTLBIhihLYD2yel/YOmIN25+9DPDq44qCvP2MtsnBbuJWNgelq8h+6C8doVQ==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 ME3P282MB1844.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Sat, 31 Aug 2024 03:34:07 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%3]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 03:34:07 +0000
Message-ID:
 <MEYP282MB2312DF315C4FC264E96AF8B2C6902@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Sat, 31 Aug 2024 11:33:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: mm: Do not restrict mmap address based on hint
To: Charlie Jenkins <charlie@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 linux-kselftest@vger.kernel.org
References: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
 <20240826-riscv_mmap-v1-3-cd8962afe47f@rivosinc.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <20240826-riscv_mmap-v1-3-cd8962afe47f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [95OAXNkcMNv5EUZfKhpGVTQw601WQjTY]
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <a4bf3140-3130-483f-b4f7-809c3ce091de@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|ME3P282MB1844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7b1966-a399-45d7-b50d-08dcc96dc4cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|5072599009|19110799003|6090799003|8060799006|1602099012|3412199025|440099028|4302099013;
X-Microsoft-Antispam-Message-Info:
	87iH7s/oFLWfAHp6rJheEv0FX5azOFfv0w5n6iDuKupC3CD1Bugnr2u2wYfH47Xhf0qqdopdH7FT82vH1oqf2eNj1BU0t5tKHIMEPoeDv54OxXKuu8YXZWqKC4z/lymR0Mikm8Yr97xOH/ubX6X+SAB3Igxt4t7jxVNEapddqT3H48qSydSrNo2joVcmFNiUsJlRiHjZywfcUxKTEjeUsjLO0H7ffVC38rgSDKoikJaT77llORlphlkHt9QPbc3gyhRdyjoj1y620jTfYVhqs52wDw+glq2G5BRge1MePqyKZYCr9yK+06569bhBtZFvxwiuJWpmGumdcncjAnCQFQf32bUyNLRl1I/ZaEmdL6rLqh2uM5prc7HAHcqF4FRkO8prRQ6JRYhrgto2smgAxHTTU/reNnpS3zDx3RA/izXqC5myN9PxPs95BcjwE4I5wnrY8ipHQ8nfsVwDR+UAwP+uybq8K1Lea57QegSdovy3j9ykCV9flGTl2mXd1L/XmTx09ZuB7eCQEzxZmTv9Kcr0vLdiHZYDwcOT9th7a6PcnS4uMM1CZkBffb6vLLoKEmt1JKShYM6eAUJ1Yzq8gWyDwoZzzjnASVBAw5Geyh9tgc/sPlyBP5EoFMhlIto8YO4SW0uQxfnOJobieDlvBOiap8bxiqpSjC911kzPoGp4nY3VcvagWGYr5NEnFC0+VhnzwFbgGxf/xl64Zx4Sm9G29HZTgBLGUNnPz0ZvQuUcCZM+n0U+KTfJlRRGswaoD0Oitp0o3YRlI3aYOr3tcUiTAXJe+cVjWVqiRaVjK4rk94q6NUTBr1DfR06QdlRU7mSnrGW1Bxk9OL1NVfx3Mg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBvd0xQM2x0ZEwyRDVFZTUvcjFpbjlJQjFkUTB6UjcwMVJkZGdlMEgzdEJI?=
 =?utf-8?B?UmsvanB1UHJXZGJUZUo5bURlQW55NmNOSnFCMlA4OGl2WHQrNXFKS3JNWTY4?=
 =?utf-8?B?OXdlbzBGTjZjUVNmaThObnNWNytOWmM1c0d1QzVWZFlpc2tVRDBRUDR5dTZH?=
 =?utf-8?B?YUc4RGdiVUs4S05UMkthY2tOSmxzOGlUckdMaTJGcHVlV0dwNC9OVG1CNHV4?=
 =?utf-8?B?L0JIZ1d5ekZsS0pNUzQ1SHBOWWRoVi9uLzNpTlIvaW1KZGJ5aWpQaEs2RUU3?=
 =?utf-8?B?ZWlUU1lkdnM1RGFKWGd1SWlUZ0V4YkcyRnZHUE1PWWh3emxaNjhrUDJVZTV2?=
 =?utf-8?B?TStPNk1LQWxCdTBOejVKN0hUSHFLUjZkY29GUjZEUGphNVd3cGJjMXpiVjFE?=
 =?utf-8?B?TUFIUUxicUtZUXp3Z3hHUGJ1MEFjNk9DR1p4M0EyOTQwV0FSbENPclV1QWhS?=
 =?utf-8?B?VXlnclUxSzV4QmxyMDZvdmlQY1paRWdvcU1wVEZ6WnZ5N3ExQkVGZTl0RCtp?=
 =?utf-8?B?cXY3UFFEN3Nzak1IS0xrK3czVG1NbjVOSUZ0bnhQQjRyTEFEWG5xcktZbmQx?=
 =?utf-8?B?ZWhFK0ZxNXZFUVhaU2hqYXJrTHZVTi9CMmsyRkRxSlRpUEx2cnkreGxtY1Uz?=
 =?utf-8?B?YzlqMDNKa2FuQXZISVI2aVA1L01jK3kvWndQR1M5TzltWFVVOWE4REpoamVT?=
 =?utf-8?B?SUFNL0RrU2YvNFdIZXd5Ui9HZ09VZUJXTjYxVlRRSHdpNVVUWkswc05ndFVo?=
 =?utf-8?B?N216UTdlN2FzR29CYTIvSmsySWRKVk5VcVl5MytPYm1rQ0RPdld4VEdwcE43?=
 =?utf-8?B?bFE1NFA4cXFHQUduUHZPUUNoQWVZTlVxWG50U1JrZWhjczBjT1V4UXlUVkI5?=
 =?utf-8?B?ZlBnQmFkSzNxdTdSeEUzN3dCdmhBRWpjS3lvcllIbzVKeUVHUi9DOGNZU3d5?=
 =?utf-8?B?d1RMWHdrcXZwUG9ZWFhMRnFuYWtyT2RPa3pIKzdRUmliMVcwSm1nVW1CTEhZ?=
 =?utf-8?B?QVdaOXpSRGZJamdNemROMXNpT05venhjRXJveTN5VWo1TVhWdVd2OThXMi9a?=
 =?utf-8?B?emxrSnJ2OFQrK2R4NzNESHVZTndZcWtaa3JnOTRkdXQ0ZHUrRi9GRlRhcHl1?=
 =?utf-8?B?SG1IREVHUVM2OHQrTk5vRHBBZEFnVUJ6NlFLL1VQVG12QmthK1FTMG5LUS82?=
 =?utf-8?B?eDlXTklETlNZQlBtTlpMcnJZMXBXSHpWUkk2eFY0VTlyaXkyS2diSFgwN29k?=
 =?utf-8?B?N281UGdpYm9CSkc0ME9rd01YUUpqaHp0VUJHS3FGL1N1NlpaWGpmWllCZVFi?=
 =?utf-8?B?ZmdpbVFGdXY5eThvbEVIVzNIMEgrek5Sd1VNdm5GQVpHUzFWNGY3bmVsNXlH?=
 =?utf-8?B?SlcyQk5YbWR5V3FOM2FCT0xwNW5VZnBPUE5EOXRHeGZKcDdPbzlNWFB0VjRX?=
 =?utf-8?B?TG94UTVJaHpmTUZTcDhKZ0gxYVRrcDI3d2cvbkE1RzhtaGZtdkp3Z0k0b1pE?=
 =?utf-8?B?emU3TDBQSmVEdTNJVytkUy9YSGpjL1dnbFpGZzNZRlJmL2FVcjg4TzdUS1Jw?=
 =?utf-8?B?QkNEc2Y5K1dYem5VakNnV2ZWd3ZWVHVNeERhMTR2eEYvUkpmTUl3ZEtMdnRk?=
 =?utf-8?Q?BPmV1Wmrz3DxX110SeGo7mPj8Mz2MG7ee7be3MYZ8CtE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7b1966-a399-45d7-b50d-08dcc96dc4cd
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 03:34:07.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1844

On 2024-08-27 00:36, Charlie Jenkins wrote:
> The hint address should not forcefully restrict the addresses returned
> by mmap as this causes mmap to report ENOMEM when there is memory still
> available.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: b5b4287accd7 ("riscv: mm: Use hint address in mmap if available")
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Closes: https://lore.kernel.org/linux-kernel/ZbxTNjQPFKBatMq+@ghost/T/#mccb1890466bf5a488c9ce7441e57e42271895765
> ---
>   arch/riscv/include/asm/processor.h | 26 ++------------------------
>   1 file changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 8702b8721a27..efa1b3519b23 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,36 +14,14 @@
>   
>   #include <asm/ptrace.h>
>   
> -/*
> - * addr is a hint to the maximum userspace address that mmap should provide, so
> - * this macro needs to return the largest address space available so that
> - * mmap_end < addr, being mmap_end the top of that address space.
> - * See Documentation/arch/riscv/vm-layout.rst for more details.
> - */
>   #define arch_get_mmap_end(addr, len, flags)			\
>   ({								\
> -	unsigned long mmap_end;					\
> -	typeof(addr) _addr = (addr);				\
> -	if ((_addr) == 0 || is_compat_task() ||			\
> -	    ((_addr + len) > BIT(VA_BITS - 1)))			\
> -		mmap_end = STACK_TOP_MAX;			\
> -	else							\
> -		mmap_end = (_addr + len);			\
> -	mmap_end;						\
> +	STACK_TOP_MAX;						\
>   })
>   
>   #define arch_get_mmap_base(addr, base)				\
>   ({								\
> -	unsigned long mmap_base;				\
> -	typeof(addr) _addr = (addr);				\
> -	typeof(base) _base = (base);				\
> -	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
> -	if ((_addr) == 0 || is_compat_task() || 		\
> -	    ((_addr + len) > BIT(VA_BITS - 1)))			\
> -		mmap_base = (_base);				\
> -	else							\
> -		mmap_base = (_addr + len) - rnd_gap;		\
> -	mmap_base;						\
> +	base;							\
>   })
>   
>   #ifdef CONFIG_64BIT
>
I tested this patch on 6.10.2 kernel and could confirm that it fixes the 
crash of chromium. But I think I prefer Yangyu Chen's approach because 
that would avoid breaking some applications on sv57.

Tested-by: Levi Zim <rsworktech@outlook.com> # Chromium, sv39


