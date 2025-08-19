Return-Path: <linux-kselftest+bounces-39302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B494B2BC7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529931BA57C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA226C39B;
	Tue, 19 Aug 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SQAfFuaB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1639223E34C;
	Tue, 19 Aug 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594181; cv=fail; b=aTV04eUuJJt0FMSe9Owd8Mjt3SN5WCVDyBUfCzNPagP1LOWVuCaA4J6XRDN12AG8t0r3ajBpYSKjwBeLD3nWfVzs/7WsBKoE4o9Xl/BA+5eGno7sehXxC7dr0ybATzx2b5VOrAUfO/6RWM/auEhWPtM79oCO5JWaBkpg3v3KdYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594181; c=relaxed/simple;
	bh=Wchgum7g80anLS4SS+MnMPUof9ujXFJ+CCJZ3YBw9dI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOB1toufzIC8B4fKE9Iv+TkGY4MIO5NYizKnpPFOyCZzx5+iEulXsgoXuKyViDp8u4r7pKwS2lFDkI6GK7ZoR+IPeoAv9dP4X4J3NnVp2hib9y7JSwMpowiZF55lyD00ZzLgNgarV7+7DgJaNoS+j1VFAxP6S2gujWlZM5AoWbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=SQAfFuaB; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJNpTo34hCQcCbuLSFktO9Y763ieB2D14ZfTDpEus5GZsWXSWuZb2VUKv7u4mQVGsTYHZA2jALITQHbP26HezzjJLggXQsTkGz4qbZqCwuMZAKKi7OTCCErPNq9m/Txa+eCZJABD/0AkBaM72XPhcUgm1A3jZQ6CkEFxFRuYkm/mgw7/uA8p+3SuPsR6NhDdbVbP7I5apGkA4QOuxOoI38mMcdCNM0t4926ZncX1pncz2k5aSD1D717a7JPErUFvEiLNbzT5mWznJdNdsZXUWoIu2PVDjUuVyrU94whSx5hXKLnbkid3AcLoSlrnvbD+wA2dHWiISfmE6XBO731jBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DtaTR3PXzI4QaHLG5H03mmBovIuZaySImF8NF8kkRk=;
 b=BR5/IDXWNcPfKA8BKj4heSsyR5HyYZbrpIhn+QLlJVj3isqCAYQu8mZ3lLTNHWIOo+ieN63ajdcALkVEdKdxtAfBsTLSVso0gxAv3unDZYTDsVtZyay+H1v/gyP2F7BpDnr2nJi31owm+OQjjXvotarjy6hPfLnzfNrzD2JTauY5Japkzf0exiAxomcqXBwVqmSzPghArnN+UynFnQIPgtXydhCkz7KzvGXiTJx5EnjgvLU+lickhVr4QuuRfhoNkkAQQAWm+dqhoAz5QlDT9gtuz7hnm8qwIJUWo0ga8m7jfqSg9KMqQZN2Ie+kwbJUp0C9NUf/IElo+u5nTmP5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DtaTR3PXzI4QaHLG5H03mmBovIuZaySImF8NF8kkRk=;
 b=SQAfFuaBaNPALJ0X9v1GM9wC3WcavDxauKeiAod2iwRAylyn28QWgwgsfMuw+ypplpydy4TIr//KdiOHu45hZ0XIl69cqAeBqISpfcaUM+0FPsBbwEMXUzKQGEHI6HbFO3cqgbQGuyUT6wnSAx7AZ/NjDILK6t3ra5UOCJQqUeI5CnokJxWo+Zyv8XAqUvk80KF4PL+Lqwai26YvG+qg+Fa1QLlfM0+cAozEXZTw77WtwoeHboe9kE5FUH2ivTdn8iPP17li1vWfNxXmcl2Xy/q1kuVIAa70us9goBtRJvTrwZyN6cKRczh35IVTdqFxkaWQ89bc6SzTzT+jFy/EWQ==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by PUZPR02MB6114.apcprd02.prod.outlook.com (2603:1096:301:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:02:55 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 09:02:55 +0000
Message-ID:
 <TY1PPFCDFFFA68A928BF5EB4A5B552D5A95F330A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Tue, 19 Aug 2025 17:02:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] RISC-V: KVM: Introduce feature specific reset for SBI
 FWFT
To: Anup Patel <apatel@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-3-apatel@ventanamicro.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250814155548.457172-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <0c6a8180-09a2-4b2d-b729-00c67c57818e@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|PUZPR02MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: df45458c-7c93-4ea4-1d11-08dddeff2f1e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|461199028|21061999006|15080799012|19110799012|8060799015|6090799003|36102599003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlBBZWtyZk01QWVCWXFNbmg1M1hoRE4rZnVlcU5UaXMvK0ZxZ25abmg4azFP?=
 =?utf-8?B?NVV2ZTgrMFZMbWFEZWYrUmFLQjlvdHFXUWZkWkV6NzBpeWxHWlRRaFFmMFRD?=
 =?utf-8?B?Qk9nS3A1UEtFaTdrbXJHWW5IK0Z4VXF0cDZtRlFKQ3Yvem5WanhZOGV6RU52?=
 =?utf-8?B?ZGRuLzd3TnZva2tndlRNZG4xRVVJMWxFRS84TWovMjU4Q2wwSU83Y3F1cXFq?=
 =?utf-8?B?aW1oVXVjVnRiWDFmc3VLbjZ1QVRaVkJIdXRFM3pJdHpVVHRQM0s1UDV0V2xU?=
 =?utf-8?B?WE1aSmRRbFhVM1F6dTdMUHZCZlJzR3U0OExYQ282YmxzSXR1VTl5QUdmUS9T?=
 =?utf-8?B?djZYU1BHMXQ4bHJkNktmR3U2dzBPZUYySDNqeE4rVG0xSFhrRG9KaVU1cnQ0?=
 =?utf-8?B?RTEyWndyM0FoUUhyMjk1OHc1dU5mS3FyUWo2M0VWWkxGZVlLeWUrL2FrMHFH?=
 =?utf-8?B?aXgvbms3YnIrZ0tjSW56aEVpeWpTcFEvZ3dNclZZWURMODcyZ0JYbXU0aHhT?=
 =?utf-8?B?amY5L1RqcVRqS21SdjkyNENqMkZLTEpSRWJxUUIwT2FIdjI1ZDVyVzhycWM1?=
 =?utf-8?B?RmRxT1RERGRDWnRSNTduekRBZzN6Yys1akJKdFhubTdkQ3Y5dG5CcXNzOUMx?=
 =?utf-8?B?VUVNVUZJd3Vka2lqek5rcm1KeGo1cUVmZjJYTkV3VUJwL1ZyTGRUUnRWTDVN?=
 =?utf-8?B?SnNoUUthckE1dWprT29ZVVh2amJ5TTU3RmV1enA3a3lHRXc4cnFKMUxieFBq?=
 =?utf-8?B?QkZScUtjdW5razBQcnFobDd3ZDlYckxrRnJZdUFIblFJQXRKQUV6MUdGc002?=
 =?utf-8?B?SnV2TlhYalFQNnI1SVg2RFRPbWxROHRzU1V5NDVTRDB1NUloNmpESzM0TmFm?=
 =?utf-8?B?Y0owZFFOVG5scElGamo0RFdZbjVRazM5eWRaaENmTVoyKzdyUHhJQXRpVVJZ?=
 =?utf-8?B?Rm90OGtPSWNEVi9OQ3gvUExCRUc1SVZON1hiV3ZrRFNWcE5OSDhIb1JXSmFy?=
 =?utf-8?B?cC9pcXFZV1V4cGRRK1EzTFpJSThtSmZva0xucnljYlFVREt2WlgvRVkrR2ZG?=
 =?utf-8?B?bHI4ZXhwVWREbytaSStrTUhLcVBzN0tRbTlvK1g1Z0o5M3ZveGFsREhvNGtI?=
 =?utf-8?B?MTZScW1VdEhVL0FOOHJFdEhyZkcxTXkxcXhvUHp4c1Y1eU9OSHVEZmZKdGdU?=
 =?utf-8?B?UlRDMWNGTnp1bVVNc1NHaEYycC9aMlIyMVhhQWN3OTJxdTlMaEg4OUkzUEx6?=
 =?utf-8?B?VC9lU2hPcE9iQXB2ajBpVkpab3NkOGVrTldRVUo3VUFjajl1T3drMEc0cUhZ?=
 =?utf-8?B?ODR2eFh3WTJpekhDTGc3ZGNLdmI1MlJKQnhVczFXZnY1Nk12RWx5ejZBd242?=
 =?utf-8?B?VnR0WHFsWGNoY2R2RXcySW5CbE1kR0cySjFHU1B5cGRqSTdEbGxiYUg4azE2?=
 =?utf-8?B?RlRpZVRWSUpLUEFhWGtuakJJeXArTUp5YWJSaWtFbi9JcjRvczltaHFhQzl6?=
 =?utf-8?B?ZGhrVFo1V2FYazJWdlBnbit1S3gwWTFaQm9CSDlEcVFOVFB2VjNZd0NlTlQ4?=
 =?utf-8?B?U25udlNLZUw3QTBZYjhaNHU1OTNBSmQvQmM3L2tyemtpU2FRSlMwMGU5a0Y5?=
 =?utf-8?Q?cIltnSEVOPaoS/iAg6ayHNoUjaqaql4OrYAeJ3DKzSa4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE44bjQ1Y0g2cmZva3Z2NStmMEFiamozODJTWkdpNHd2TU01RjVubVAzS2gy?=
 =?utf-8?B?em8yTGdFS2Vud3BScytLOFErL3p2eVptRys3Y01pSWFkWjhoSUhJOXd5YjNU?=
 =?utf-8?B?aEl1M3BvaW9PZ3dWR1lKVTl1ZEFGMXBLRjJlWTVmR3dNa1BkNllIeWdQdzE2?=
 =?utf-8?B?STdOdzNqRXpYeFZ1eElycUMydmROK2FrOEJnaXlRaVh2bW9EQnNodnZxME9t?=
 =?utf-8?B?MXRidkU3bzFrLzFuSlRHSzVqdWRJOFJ5QUU3TE0wQmowWWR1ZDAxOE5Faytl?=
 =?utf-8?B?L2FRY2hBQ3h5bHpOVVRKVjJ3S1BWQ1gzTzhsd1RLa0xibGtEV0JTTWk4U2NO?=
 =?utf-8?B?bHo5c2ptcUpFck9hMlRlZjVXM1lBRkhpc05KRTNzUmw3NEtJU0dTWU1lTDN5?=
 =?utf-8?B?K0tORnUyb0JxaU95RlpLU0djYktmZ2x5N2lHZ1dFMmhSK2hBNG42MENJZHV5?=
 =?utf-8?B?U2FpSGFuTTRSVlYxU3NVMjdxV1M3M25lcVJtSjVETUI1TFB4emZkUnlNTC92?=
 =?utf-8?B?Y0lTUGRoNmlCakpabTFGL3JTVU9xczBSVWhkNjdtTDRkYS9BbktwYW5iemlP?=
 =?utf-8?B?Wmw3OWQ3cy8rL3BQaHJucHFFeG5DVlAwTW5DZWRtcHlYemlKZjJEcHdvemI1?=
 =?utf-8?B?M2JGcTBiOEdKaUdoMVhSUHB4cHgzSm9mZW1HcUVnenBRaUROOGZZelRuUy85?=
 =?utf-8?B?M05aNFNKaVBzOFYxWnVNYWN6RjlTM1dWM2c2dnZTekIwaFFNRkcrQ3doTlN0?=
 =?utf-8?B?YVF3TythY3lFNzN2MExlQ0JVcVQ2QjgzczYwaENIQkY5TnQzVEZDcDJWZkg5?=
 =?utf-8?B?OGxZWW13ZmlMSDMrbUI0clM0US9VeTVlMytoeVloZWZhQlJsbFl5RU5Ec3d4?=
 =?utf-8?B?b1VmQXFrcDVUV2R6R0ZuSkVNdzBJdnVTM3JhakxRbU5BSUtMeDNpNXl1d1RR?=
 =?utf-8?B?NGdEMWFYWnU2Z0syVWxFZlFwZm1Dbk14UHJxeVhZNFEzelA5aTJCc3krQm1y?=
 =?utf-8?B?K1BoeGdQWUNZTmVlcHVVUXVtZVI4bWRYSzFMZmlxMTNTRUdjUjcyVW52L291?=
 =?utf-8?B?N2VZbU00ZDVHVkkwL2x4YlQxV1Y3MTB1TFB0UjJscVRVbUc5ampHaG1OMmhZ?=
 =?utf-8?B?QzdNT2xrR1dVYmlxajdvaGxrd0Z6U2ZaZlZIcStqdUQrNWg4bEVKMWI4aUJO?=
 =?utf-8?B?S2NUVWpnNndKdVVTZ0phVUw2YVg4Y0dncFNnT0FabWgxTUVLL2FOYTNieTlD?=
 =?utf-8?B?aGxxQkt5S1E0YjlkSzBoYVJIVGNVNkkrblBCeG1JNUFCMzFlNVlpNzZFeG9M?=
 =?utf-8?B?Yk9HWHVDb1BIaGM0cjhBZjgrWjVxMUFtVklwazY5SFNJWlBLUERqb1BXUDBM?=
 =?utf-8?B?OE1SRzFxMEdjUDdGRTVlaXJvWUtBL2t0VUxOOVl0QkxrOG9qZkdscmRxYXJT?=
 =?utf-8?B?Zlo1aHRUZC8zTEhCRTB0eGc2U2NVWTJUc1lnUjhHVGpyWis5OFBQRjdyVzd5?=
 =?utf-8?B?bDZHbElrWElRcjAwd1QxVERtT3ZqUWxhSzhqNUdvWXZpNUx2Q0F0UXg4dHMz?=
 =?utf-8?B?amVXcEY3WVVDRXI4YXRUdUVUVktOWURxZ2pCUTdhWkw3K1YvaDhBWGowNnpq?=
 =?utf-8?B?TnpGenJxSWZ6QVlrR3pIZXl1NXJaRURNVm1Sa1QvS2F4azBZYkVGMmVlRmlW?=
 =?utf-8?Q?a85HVWRuZOmOFLHoznEb?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: df45458c-7c93-4ea4-1d11-08dddeff2f1e
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:02:55.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6114


On 8/14/2025 11:55 PM, Anup Patel wrote:
> The SBI FWFT feature values must be reset upon VCPU reset so
> introduce feature specific reset callback for this purpose.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/kvm/vcpu_sbi_fwft.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty

