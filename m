Return-Path: <linux-kselftest+bounces-18548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769898963C
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDA41F22669
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C43717C217;
	Sun, 29 Sep 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sDEWTrSG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2024.outbound.protection.outlook.com [40.92.21.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397816B391;
	Sun, 29 Sep 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727626065; cv=fail; b=EMHesFlyUUgid+Ar+nmQhEkypIAII6EfM4fdAzZNU0nGT4X2PfvszXLwjpr53BL9T13tDe/Wc1czpyf/aqkmIvAYbgT3OFfbepfWhqWNhwcuFo2XBM2NVCs3JI25Ko5Chm72FUOV40B4FoM9sMn+xLX5pagOKv2C2AomExRQCwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727626065; c=relaxed/simple;
	bh=ySgPWLjHaHkprvLr2m2jnNL5peYRc+YeHM7tG0Lz8Yk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0/VS5mCSFY1cP8554uB8k1o+eKwWJ6uGN1apewL0+B2sVDgROpldju6tbc45wcQAopYMRbhCiTeFRV/G8p6D66B1ulLaQ25Lx5EcAB6HVgrrgPp2hwheuM/FJkQGyMKZ4mDZtMNMTElM2a2LihOFKV3mavnPPNz6W7WbJMkr5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sDEWTrSG; arc=fail smtp.client-ip=40.92.21.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTuKEtksFMEhG+/Bu+Anv4PSMWM6DHYdkVhYDHzkDrrvadjTjmsTRgDBywWdRoasV+uLICfDiO8Pkl0IBIBOYa5SKNcsgPwGfAQg5hsfyYPSRb7y0YQ2UOntpMneHkoPzX0caxMfLp5pMrTEEVzEVNo98n6RYSgnv50/o9CZ+4PyLJaqIxSbQxEnIh2/UmDH8O+hMvmZ7Pcuo747hc0tZTmC1zkJuohBW8U/glsBqtqW2VVytTsMk7NNvPBZp5rL5txa7U7Y9UFYnJBEfN52z606RVHV6T1LMM0CRpD9rPp3Ixia/yA0DkOsulXaF923MdZPV1IUh0h2fHGn82hLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oNe3bkxJaJGJtkwYFeOl/y3rA+/jU+YE/3Ws3zpixk=;
 b=Yw1nDwPkSoIbkNvA7yti2dzdOPJCZTsWwgk7RoBLEH+XZW06Z8z5xkBiEGDD4g+Po3H/WZbK2LpqgtMjBz0oqds+f6eSznanu3LFNhNuMRUO5So6ZlSqRYUqtInhjHXneiWadFbtiGpEm4S58jYyRvmE5vYJH94xwq513dBUQ4kR4uyBrLoxiPe6TN10cwxamNxVVPT238kPmUvn4bWEAEY7hQXZxeHJHmo5k/5OtvhwaaTvVRu5LFuzwdtEoUTGNsen0CL6mynmARwyFuKGzVz+zQD1AU9UtbkyYm9jMMwdAZNhNe+q5e+jUefxamc2y/S1Roq7Sap8b46pNfOnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oNe3bkxJaJGJtkwYFeOl/y3rA+/jU+YE/3Ws3zpixk=;
 b=sDEWTrSGKG//5GNd7eOoV3VglH0WJSA95Sei+A8ubXuUlInCfz+2OOw0nCHSb2hQrJOI9+ffOFuu70kzj7F2G//6KOymripHtaZqDsDH0SvSi9iIqhBpf5i2uZapEA99L2262XegngNNJp21+ywtrCnGpSLwsYyuTeimFTUWPFLtscELqJe48ig72xQT7D1x7bi1jZJF/6PByXNJJ6qUtnONh5mHwshESchpxgxwvpb1ufqnAF2oMSV1jtKLzHbmWJxYK+q6aRYoRFP2xiUpNkMWUqHyqlo7FvGCGirewP8I4eTdPm6AKVkciuE70E1OJICATZNg2DRVs519CbNkiw==
Received: from CH0PR20MB3932.namprd20.prod.outlook.com (2603:10b6:610:d8::9)
 by PH7PR20MB5092.namprd20.prod.outlook.com (2603:10b6:510:1aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Sun, 29 Sep
 2024 16:07:39 +0000
Received: from CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13]) by CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 16:07:39 +0000
Message-ID:
 <CH0PR20MB393254369E401BF068005C7FCE752@CH0PR20MB3932.namprd20.prod.outlook.com>
Date: Mon, 30 Sep 2024 00:07:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/14] riscv: Add support for xtheadvector
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>,
 Evan Green <evan@rivosinc.com>, Guo Ren <guoren@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jessica Clarke <jrtc27@jrtc27.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jisheng Zhang
 <jszhang@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Samuel Holland <samuel@sholland.org>, Shuah Khan <shuah@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
Content-Language: en-US
From: Aoba K <nexp_0x17@outlook.com>
In-Reply-To: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To CH0PR20MB3932.namprd20.prod.outlook.com
 (2603:10b6:610:d8::9)
X-Microsoft-Original-Message-ID:
 <8287fba5-66e3-4774-9ebd-293ac2b3f85c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR20MB3932:EE_|PH7PR20MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf3e9bc-4978-43b9-74de-08dce0a0d72f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|19110799003|15080799006|8060799006|7092599003|440099028|4302099013|3412199025|10035399004|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	U9uWCWu4MTMmiL+kfwa/f2xR3HQw32LHMOMw+fmRbZxZzAFBr/Ua2B8nNjB+K8K6Rpy+bxLVT5TQLRUJ6z8YQuTNZ/2cX8YlF227xg3FZiVe12Yxe45l07H7kxAp4c3sD7O57Ucrayx+c8AbI0iuYXtmQRYUjuMKVD3zvsgSJ59DKSBHluryb9JLrrMZtrhxcpiaA6Vtn1apIzqKzseBEWKZ1bK6j7PoUeCbNJ6kmh6RP1r25VeXOZlrYy58aTYd5OBkLMIQVkUzUtWQaeCPzFWJs+oRcOz2hMMAkppT/0fZ4FR+K8SjRAqTk7vTiFpYhNPS0EpgtBN/tgal0Yytn4Ug8YMV/5JG5BRVrysB/Y34vwbAWqP7UJNwGALQGte+O63E5TkjFH5uQYIEY0YVqAf+sXpw1iCqgTDHyR9pWVC8+6dpElHWF3aTOBxqpTxuSIIyJfWUIp/1f081J3u9WkcNchSCQdq+HCSlcwZtCB6eFcrHRnTcwaKSSDtC2HQ/DBx0P1+dKDfMvXBckptuPax0VAx/u+xu8uE2gHajgWX/R9iSvb48tEBMs0NYdg45bIr2CRhi6gzJvB0Y5yQ7vLm/5IH4eqvMMjK9qfpnaMx2l7UKfYN2Dd1HAXLORXM833TtG7kHNcBQKCHpQEIZKtiT2gUSW11e3ACZ3CnJ06jNmV1cWJsnF6ocMDj9EtNkXHEl3+SnLTYbQUkoEnXQCYW6jvgro3+OQs8WzWcKjrtx9Im4XtThTugt4pAerzw3BbQFUd3GBMcOxwgBDO2al3OqhtHm8yCLowV+G689v4W30cnVtW/9rI4zai4PCBI1AAi7s76SgXzHwrsLzqkuJCJW7SERTdAMwsdkT2lqeH058reOjAzsppS2ITjIbr5WcBEg4hRSVwyDwgNgRLolNhT8/EHwvQnxqkdOwvC7P6E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC9wUXNvTGFHZFdWWXBQOEZsTDh0eVRGNnl1UzY3bnJ5Z0ZnVndCdVYrMTBr?=
 =?utf-8?B?VlJKZjg0blluOUp1VDI2TnJibnhZNHZQL2gxeXpEN1FVVkZLa2RIWk5LWmNR?=
 =?utf-8?B?SXRzWTNkaHZranl6cDVNNm1yV01RRUhHTnplTWVsREFqOVI3YkdYRVVTa0VD?=
 =?utf-8?B?K1FPN1o5SGZOVmw3a25ncytqc1RjY2hnVGsybzNlU2dNK2s5Zmw3OG41VHI3?=
 =?utf-8?B?bnl2SXpZNS9wNlZSWTZGNitVL2VFV3lTNWkxam1sZDlTZDNTMlBORWYrcldo?=
 =?utf-8?B?dVFOYkJZNlJiRTdtVEdSUE9rdGErVmhnVzVJbDhQVFBJN1BJMTBQbXlGdGZi?=
 =?utf-8?B?Y2l1Uk9GcTV2YVRSU2hZREFScGJsL0taSmpwemNTUnQ1ckpHYi9EbXRGYkhU?=
 =?utf-8?B?NkVvZ0dFN2tBUjNORzBTdlVIak9vQ2ozZ2dFRFc5REhMalY3OXVvTENBQUJv?=
 =?utf-8?B?Nk1RKzNRWmMwSGdMKzBja3hLZTJBa0hkSWJ1aWtVWHdtQkxLd0o5Y0NTYzFh?=
 =?utf-8?B?QnZhRXVBczFZRTg0U2tHb2RuMkdaektlMnF1a0lJWEEwaXhsWVd4UHFzUGQ0?=
 =?utf-8?B?MElaOWRRbUNLS2NJOGp3LzcraGlTV0s4aHJ6N0ZYT2JEc0xLNk1KTzR6aHgw?=
 =?utf-8?B?Vmtod2JaeDVrenA3cHB5YXc2dTNnTHIzNnFPaHgwSEljRHd2dFB1QlhXSTMw?=
 =?utf-8?B?SkhGd1FrUitvN2dFZDFBVWZZRDFyMlFuSG9LQ3IxQlR2V1MwWEFiUXNqWC9C?=
 =?utf-8?B?S0tBTHNNQU9pcSswTk5ld3ZwQ1pyeGJpdjRGcDd1N0FpRmFoVEpUSkU0Y0sr?=
 =?utf-8?B?ZW8xVWJaYmpEd3hEeEhkbWRMZGxoUVY3cnRJVmRRRU94ajZEM1U5NUxTZVp1?=
 =?utf-8?B?bUZTVzNJc3NMKzhzeDRHb3E4a21QK2g1QzhUVzNCZ1RjRWx5QjhCbXBXbkVM?=
 =?utf-8?B?WnhZK1lic0RMaGowSlhyTEUyUm8zSFdxN0tmejAxeVhWV09JclJ3YkxHbEt5?=
 =?utf-8?B?RStxOGNJY0QxZkhGVUhERUFhMk1vajZxRVBNV1UyQ1hseXBkMHdyTGV2cktv?=
 =?utf-8?B?NEg1bHdrUnUrYjNadytKQ29SM09yOXVXemZlNXNKaG11dllnYnFwNzhIeURW?=
 =?utf-8?B?SGpYSGpJeE1MQ1B4MFhsL29MSUtCUVk2TVJhamhVVDR2UWF2Y29BcFF2dUlR?=
 =?utf-8?B?am85M3hjaDltemVBdGZWNDZwSTJpVGJNR0VXcTJEUEpjL082dnNSOURNNkZ5?=
 =?utf-8?B?RGtTVDN6V0F0S2c0MFpwUkM2ZUE1RC9Qd1pVRGFWTmdrMElUZ0NSZW1EN2ly?=
 =?utf-8?B?UE1jeWNLalRKS3VENzJGekdOZzQ3N2tjWUh4V3Jmb2pXNXVCb09uT1BTZzRI?=
 =?utf-8?B?eStIZzBOWVBZSXRhR21iNFNoSXBQeENkWWhLbGpPTUtDS0xWTG9lMDloRDI5?=
 =?utf-8?B?NjRXU3NyRmlVZ1hEVDZZQVZVa3E4ZGZOL05OV1ZuRGNLbHU4aFVNeEE3Ylda?=
 =?utf-8?B?dmNoNVdTQjc0OGF1dHlXZ2lYaXVWT1FRRFFZaXh1ZzJZMDV3L20wMDhCU3l6?=
 =?utf-8?B?NE1hZVRxTEw3eVF1Z3dHYS9LVmhRalNXWGgwbzNuRS84dGp6Ri82aWNnR2ZL?=
 =?utf-8?Q?+OiBatGrMnYoTgOfqqrpgYJ1W7ZhGBmQ0r5gMYrim+z0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf3e9bc-4978-43b9-74de-08dce0a0d72f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3932.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 16:07:39.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5092


On 2024/9/12 13:55, Charlie Jenkins wrote:
> xtheadvector is a custom extension that is based upon riscv vector
> version 0.7.1 [1]. All of the vector routines have been modified to
> support this alternative vector version based upon whether xtheadvector
> was determined to be supported at boot.
>
> vlenb is not supported on the existing xtheadvector hardware, so a
> devicetree property thead,vlenb is added to provide the vlenb to Linux.
>
> There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
> used to request which thead vendor extensions are supported on the
> current platform. This allows future vendors to allocate hwprobe keys
> for their vendor.
>
> Support for xtheadvector is also added to the vector kselftests.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> [1] https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc
>
> ---
> This series is a continuation of a different series that was fragmented
> into two other series in an attempt to get part of it merged in the 6.10
> merge window. The split-off series did not get merged due to a NAK on
> the series that added the generic riscv,vlenb devicetree entry. This
> series has converted riscv,vlenb to thead,vlenb to remedy this issue.
>
> The original series is titled "riscv: Support vendor extensions and
> xtheadvector" [3].
>
> The series titled "riscv: Extend cpufeature.c to detect vendor
> extensions" is still under development and this series is based on that
> series! [4]
>
> I have tested this with an Allwinner Nezha board. I used SkiffOS [1] to
> manage building the image, but upgraded the U-Boot version to Samuel
> Holland's more up-to-date version [2] and changed out the device tree
> used by U-Boot with the device trees that are present in upstream linux
> and this series. Thank you Samuel for all of the work you did to make
> this task possible.
>
> [1] https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezha
> [2] https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f1429e9a0b48
> [3] https://lore.kernel.org/all/20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com/
> [4] https://lore.kernel.org/lkml/20240719-support_vendor_extensions-v3-4-0af7587bbec0@rivosinc.com/T/
>
> ---
> Changes in v10:
> - In DT probing disable vector with new function to clear vendor
>    extension bits for xtheadvector
> - Add ghostwrite mitigations for c9xx CPUs. This disables xtheadvector
>    unless mitigations=off is set as a kernel boot arg
> - Link to v9: https://lore.kernel.org/r/20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com
>
> Changes in v9:
> - Rebase onto palmer's for-next
> - Fix sparse error in arch/riscv/kernel/vendor_extensions/thead.c
> - Fix maybe-uninitialized warning in arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> - Wrap some long lines
> - Link to v8: https://lore.kernel.org/r/20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com
>
> Changes in v8:
> - Rebase onto palmer's for-next
> - Link to v7: https://lore.kernel.org/r/20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com
>
> Changes in v7:
> - Add defs for has_xtheadvector_no_alternatives() and has_xtheadvector()
>    when vector disabled. (Palmer)
> - Link to v6: https://lore.kernel.org/r/20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com
>
> Changes in v6:
> - Fix return type of is_vector_supported()/is_xthead_supported() to be bool
> - Link to v5: https://lore.kernel.org/r/20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com
>
> Changes in v5:
> - Rebase on for-next
> - Link to v4: https://lore.kernel.org/r/20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com
>
> Changes in v4:
> - Replace inline asm with C (Samuel)
> - Rename VCSRs to CSRs (Samuel)
> - Replace .insn directives with .4byte directives
> - Link to v3: https://lore.kernel.org/r/20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com
>
> Changes in v3:
> - Add back Heiko's signed-off-by (Conor)
> - Mark RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 as a bitmask
> - Link to v2: https://lore.kernel.org/r/20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com
>
> Changes in v2:
> - Removed extraneous references to "riscv,vlenb" (Jess)
> - Moved declaration of "thead,vlenb" into cpus.yaml and added
>    restriction that it's only applicable to thead cores (Conor)
> - Check CONFIG_RISCV_ISA_XTHEADVECTOR instead of CONFIG_RISCV_ISA_V for
>    thead,vlenb (Jess)
> - Fix naming of hwprobe variables (Evan)
> - Link to v1: https://lore.kernel.org/r/20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com
>
> ---
> Charlie Jenkins (13):
>        dt-bindings: riscv: Add xtheadvector ISA extension description
>        dt-bindings: cpus: add a thead vlen register length property
>        riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
>        riscv: Add thead and xtheadvector as a vendor extension
>        riscv: vector: Use vlenb from DT for thead
>        riscv: csr: Add CSR encodings for CSR_VXRM/CSR_VXSAT
>        riscv: Add xtheadvector instruction definitions
>        riscv: vector: Support xtheadvector save/restore
>        riscv: hwprobe: Add thead vendor extension probing
>        riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
>        selftests: riscv: Fix vector tests
>        selftests: riscv: Support xtheadvector in vector tests
>        riscv: Add ghostwrite vulnerability
>
> Heiko Stuebner (1):
>        RISC-V: define the elements of the VCSR vector CSR
>
>   Documentation/arch/riscv/hwprobe.rst               |  10 +
>   Documentation/devicetree/bindings/riscv/cpus.yaml  |  19 ++
>   .../devicetree/bindings/riscv/extensions.yaml      |  10 +
>   arch/riscv/Kconfig.errata                          |  11 +
>   arch/riscv/Kconfig.vendor                          |  26 ++
>   arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
>   arch/riscv/errata/thead/errata.c                   |  28 ++
>   arch/riscv/include/asm/bugs.h                      |  22 ++
>   arch/riscv/include/asm/cpufeature.h                |   2 +
>   arch/riscv/include/asm/csr.h                       |  15 +
>   arch/riscv/include/asm/errata_list.h               |   3 +-
>   arch/riscv/include/asm/hwprobe.h                   |   3 +-
>   arch/riscv/include/asm/switch_to.h                 |   2 +-
>   arch/riscv/include/asm/vector.h                    | 225 +++++++++++----
>   arch/riscv/include/asm/vendor_extensions/thead.h   |  48 ++++
>   .../include/asm/vendor_extensions/thead_hwprobe.h  |  19 ++
>   .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
>   arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
>   arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
>   arch/riscv/kernel/Makefile                         |   2 +
>   arch/riscv/kernel/bugs.c                           |  55 ++++
>   arch/riscv/kernel/cpufeature.c                     |  58 +++-
>   arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
>   arch/riscv/kernel/process.c                        |   4 +-
>   arch/riscv/kernel/signal.c                         |   6 +-
>   arch/riscv/kernel/sys_hwprobe.c                    |   5 +
>   arch/riscv/kernel/vector.c                         |  24 +-
>   arch/riscv/kernel/vendor_extensions.c              |  10 +
>   arch/riscv/kernel/vendor_extensions/Makefile       |   2 +
>   arch/riscv/kernel/vendor_extensions/thead.c        |  29 ++
>   .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  19 ++
>   drivers/base/cpu.c                                 |   3 +
>   include/linux/cpu.h                                |   1 +
>   tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
>   tools/testing/selftests/riscv/vector/Makefile      |  17 +-
>   .../selftests/riscv/vector/v_exec_initval_nolibc.c |  94 +++++++
>   tools/testing/selftests/riscv/vector/v_helpers.c   |  68 +++++
>   tools/testing/selftests/riscv/vector/v_helpers.h   |   8 +
>   tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
>   .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
>   .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
>   .../testing/selftests/riscv/vector/vstate_prctl.c  | 305 +++++++++++++--------
>   42 files changed, 1048 insertions(+), 272 deletions(-)
> ---
> base-commit: 0e3f3649d44bf1b388a7613ade14c29cbdedf075
> change-id: 20240530-xtheadvector-833d3d17b423


Hello Charlie,


Apologize for the last email, when dealing with pastebin it deleted the 
last version...

tl,dr for the last email: Patches not boot on Sipeed Lichee RV Dock 
(with same D1 SoC).

Logs here:

https://fars.ee/XFzR

(the board resets without kernel panic)


Cheers,

Aoba K

