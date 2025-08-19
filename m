Return-Path: <linux-kselftest+bounces-39301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB87B2BC65
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBA368131E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A531771E;
	Tue, 19 Aug 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="LjS9Xn4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013083.outbound.protection.outlook.com [52.103.43.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03731579F;
	Tue, 19 Aug 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594084; cv=fail; b=Lew+EOKI3VFCB6oj6TtxizxAaRs0Iu1ya0bxljfz031ya1y2dDK9m8s1gkRvIfJV4m189nrx+BfDeOlWe0/EUZz4tfvKAAgivPcTd0hYtakv7ixQdHZbTm9o5GxAqhlHeVMTfnvofTRsxKJrWUzlNmkkBAH5jO3xyeV+efCGYhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594084; c=relaxed/simple;
	bh=rCRHKsMj68297TKI5QF1aVP0giYRyBXBbiahrCkCWnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfsnWItITqQ4Vysx7IN8mol83qByP7CH6OsOkFsT+V+LLiWw60+Sthl2S3ZUMNfgMZOXHJWegb1BbndyWvJcrbeuzfNdGS0MTh4hdeePCnU6rLr7KRfOWhrAcD2vEwpGH9f6MMtPyfgfPSlLk/kQ9V7VEIls+easH2oNikSndu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=LjS9Xn4t; arc=fail smtp.client-ip=52.103.43.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA0N/qSwKiBtGHgUhhAWrzSdyQTxYFQbZJdQrh46I1FCuh2bk9qWb61H2I3A0W7GGtmov1g5y8a3sDeEhm/FOf35de26DaMJRG4LFSNGHrNUm4llH11/9EWqWoAGNefxnxPkFsljDDhTqxrLW/Rx+iMcVPdi+DLTQt7k+wI8CLj2UVXF6KgeBSInQfGSylGKx9bwgJPPK1SFBA5XfbpiqY13GtSYHFcidQkBlfpswVsqtmnjUhMKW67wlZHhcQkCsLJ3X76sITm1t/TczzB781dufj3X6NW6JvjMFoT2n6zyLU5i0a50HLd0MUjhCl/IjBMuPRYv2pnE8xL6v8FNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4igpYFE4lnviPZvkra7+40Lf+oN/JdVoPQFcgHu3gs=;
 b=aHrV9tXhgXjHRAtn+BVu8OJig/osyW7Zn/rmOLZUSgiMJ5mbuFqODmBMFsNl3HHxr7jY3LWNnSYgRs/iRUd+n0AUZimiqEQN+sYjXbA17jVxy+9Nu3P1VIPHVI/xzNQADuIJehQ0GktGWOViOvRMMi2I4Yge/t4sVTbT8EevKLnd6hiynzIfdChPhq+vysDsNShOq8g3EUh/AIkQOZQghWNyZJcwzYQK1WRAdFwaJk9U4M/U2idC7dAJw7woq6GD8GLnSrqVFHPFaMdPXIKAbGuAnx9CE8Ih+rDPv4ds4dKvxqG8spymJj25uOnZBdNQQIiy9ewSTe2s7kAJsbvMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4igpYFE4lnviPZvkra7+40Lf+oN/JdVoPQFcgHu3gs=;
 b=LjS9Xn4tXMKMMLmP9FFEib3jduFHTigIKOrf2lFip+sehT5c3+ggLeUMCAK2HB6e0bZCiL5Ba9d+/mSTY/IxROpZQ18qGL1aL6kZyPTbWmf+vQLUeGoiY4G8dlfMKPZ0QfRpS+hD9xGhuxFdgPChpTylnz9EeAudSna3w6aSE/cizu8ofZAwTlSxYBZvpBgtmgfY8kAhh3ts329XsxFSy8qzzFuh8ev+yhX1rpVlyMf/YA4ZIBOo2EM7e4XPxmUtujpmo4/6+uFxIXRKRo4GwuovG8ZK/+Qy+Px5iDwfdFmta9ce/UHLHSg6x33VJiQpv+19a47l+V8RRnpLe9wjnw==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by PUZPR02MB6114.apcprd02.prod.outlook.com (2603:1096:301:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:01:19 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 09:01:18 +0000
Message-ID:
 <TY1PPFCDFFFA68AB467F051D996437D07C8F330A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Tue, 19 Aug 2025 17:01:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] RISC-V: KVM: Set initial value of hedeleg in
 kvm_arch_vcpu_create()
To: Anup Patel <apatel@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-2-apatel@ventanamicro.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250814155548.457172-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <0d78e0e4-c39d-4619-886a-47b844ba085f@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|PUZPR02MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0f52a9-6069-41a6-23e8-08dddefef5ad
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|461199028|15080799012|19110799012|8060799015|6090799003|36102599003|440099028|3412199025|51005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXlMTlNJUEFDemFpaW5JQmhaQnZyYm95cHlXVHo4dDFOY25nTTI2d2c0RnI5?=
 =?utf-8?B?Q3p4L2FMSDF2TmU1dFU3eEpaaXpmU1ZiUlM1anBMWlN2MU12ZjFvVzZmOG1o?=
 =?utf-8?B?ZjBCQkNCV3MyK0daUnFiRzI1ZWZWLzJUN2J2WGRUcWFvV0ZIM3hTaUlmc2Zn?=
 =?utf-8?B?UE5vMEhoaGgyL0ppZ29ZMHkxVWo0ZTRNWG90TXFVZG0xOFV5RDhucWpMT1U3?=
 =?utf-8?B?VEIxSGZHeFg4eDkvckR2N3YvOGtGMndycEJLZVp3b2ZiK0V5NHVkQm9ZMk1r?=
 =?utf-8?B?MHdrdVRrME5vcWdJL1RXK1dmY1V0Q2xrQjQxU0ZFa1d6cDYySzNrZDkvbC93?=
 =?utf-8?B?WWRuU3kzcWlPdnQ0WXRBVFkwOUg1bzVCTitxZW40eGRwemhVM3o5L3YxcFFR?=
 =?utf-8?B?VzJSaEhHV0J2MEsrVU9jNnptdzhab3VNSVZNUWhUMythSk13L0tJRU9GUnFI?=
 =?utf-8?B?ckNid1hVbFVJd3NvUGhoanZTYURsSU1abVZaNlNVa1E4RXMwdzVnQWg5NXFs?=
 =?utf-8?B?SGZ5M0gwT2hnS0VLQUEzVkZ3bDdwVmFGUC9zUHNmaTd1VERBOWhONVhFMVRa?=
 =?utf-8?B?SjM0V0thcVI4enJJU3FDcUxUR0hWb25OQlprL2thUVFoVEZKamFMeiszamNH?=
 =?utf-8?B?aVEwYkthZU1CRnJCZE9pQnhMME14RmdHdHNVZnQyWFV3WWI5b2tXdDA2TDQy?=
 =?utf-8?B?US9IZUowQVFlbFNXaWZyVkZaSS9vdHM0VEJuNGJObWhXb296NEtTMFd1d1Yz?=
 =?utf-8?B?bEtBdzEwaWN0c0Y3cUh1c3FjL1pmUVVvTW9ENjBDU3p3ekN4bERlTTBaZmxq?=
 =?utf-8?B?K0RNOHdyYlpETlBQYUNQOUhOMnE5bkFJa3dpS21INDRDYS9qSy8vLzhpditn?=
 =?utf-8?B?Rm1hSmRlbzFUdFp1TGZZcFZnRXNicW1GM1BCeVcreGh2cklYYjl5c2VkWmZB?=
 =?utf-8?B?bENqcjBrUnh1SUZwYmcya2dqbkVFeDJFcWF5N0NFOVZrcXYwOVhuRjdtNm9w?=
 =?utf-8?B?K1JBalBZazhNNXg1YjlZaUNZbzRYbVJvaUdWRVNjbzUzaGptSytaMVgvSXpY?=
 =?utf-8?B?SEFOS3dvM0RmN1VhVDRmblo1Vm1rUXVQY3NXdForNnVEYkZKUUFkZ01VTUhN?=
 =?utf-8?B?US9ZTEdldjVuVXQxdFl6ZDhzdDRzUzRaL2FRWE5MZ0ZPTXVOR0RMMFlIZHJI?=
 =?utf-8?B?RFBmRStGL1BXTHdiYSt6NE8wY1lYNjM2ZmVhTnVzVFBxQVRwdjI5ODNOZFdl?=
 =?utf-8?B?eGg2TE9la0wyWTA0blhBYkNKWTJFSkZKLzIrYS9iUjFKa0hNa0RnMDVDVUdt?=
 =?utf-8?B?Y0Q3cjIzSm9keURZNVpscWk5dW1pUWo2MkV4R1JZZ3VMaEpxYlh2OVFCaVA4?=
 =?utf-8?B?NHRhbzIyOUlkYTg1ak9RZXZQYVoxbmdXVE5IZ2NJNCtseEVJMmlrVHNjTHk2?=
 =?utf-8?B?VEdwT0V6L1piTEFDN1NqZ24xbFNEdlVmSkVIT1lqNWhJVHM5Y0YwTnppc0xv?=
 =?utf-8?B?S1JwT0RtNmNjNWEyYnNoc3lCUHlwb0hTc2g1bzlQY3pjQjhnSjEzSTBwUkI3?=
 =?utf-8?B?TmdwaG9PRTZ3S0J1Z09FQVRKcWNEOXVOeW5vZmRnWTU2aURIZGh2SDd4blla?=
 =?utf-8?Q?g08V62ui1rth38Lssea2C3h9kIslHm8Jt/13oV5VbxFA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUxKeFRmSGpYNHZGRm80S1BnRm9zTS9CNzVLUFVVVUpZeWtuNVpCRjlldi92?=
 =?utf-8?B?UElQV1NTdTNZSmc1cUpZRUs2R3FxeUttMmxSeVAydWVGbm1uRmtlU2tFRys1?=
 =?utf-8?B?dlhDSVhEb1NycG12MzBxUHJUeDF0UkhhMk90NUV6OGtYNDhzLzhMcnVaR2h3?=
 =?utf-8?B?QStPNW9ZQUpvcjE5YnEvUVM5bnNwSU9sTXBvMUFEK1c4a2s3U0Jsb3BEUldT?=
 =?utf-8?B?dVhRRXhCMVh5N1Qzc1NIVElmWGJTdEl6MnVCUmNwV1p6SExDNEJQSjZLSUlQ?=
 =?utf-8?B?YjRRWXpEcmZSOFRmZjQvbFMybTB0SGlZM2YzL2xYbUtHdnJnMjJMam1Pc0tY?=
 =?utf-8?B?c0drenpKRDlIYXRZVmkzSzZJWnQ4NmFaK3RrNkhETmViUW1pT0xjcW1sTTZq?=
 =?utf-8?B?ZWxsb05nTW9SSmFnZWdFdHNSQ1RPellsT2U2b3ZLZnUzczd3SlJ6TGswYTRQ?=
 =?utf-8?B?K2JjTGkvM3JWWUtkVEx0Ym9kb0FZbjUyWFh0d2ZSNmduM2h1RmNnazFTL3lY?=
 =?utf-8?B?d250dXJFSStyejdsSzFtNHBCakd0T1BpeGRsVnhTVjlvS2RLZUtlL0doZis2?=
 =?utf-8?B?TEpmQjZJeGdoelFtZDFWajVrdk1mUktCUGVwcVFsa3hyRi9xS0JITk9SUlJv?=
 =?utf-8?B?a0hEVHZJQTdqUktLdSt0bXd6bjk3bWx5NkFQYVZ3UUhNWjFITGVuYTRETlRN?=
 =?utf-8?B?aDRmTENSYzdENjVaNFo0OUo0TEg1cVhyZVNsRHZ2RmM5dm85N0J6VnVKTEYx?=
 =?utf-8?B?VERjS0JSQk44M3ZjaUJnMkZadDRvSDlxNHc5ZUt2Q1drY3N6ZlBoc21yeHFZ?=
 =?utf-8?B?WndyTTRjeUc1c2cwK0dlUUhrcys0WW1MRVpKVi93Q0xpbmVBZk9oRTVkSkhi?=
 =?utf-8?B?N3h2NHYrUTllL01mbkJtWk9xVnp5VE41MUZpdExoVUJBTFRZWGNtOGhEM0Ev?=
 =?utf-8?B?ZHBiZy9qNXZRUkM4Z2I4bE1ETXI0WjkwZkxFUFpRNTRqRnVtaGtLdDVPbUpk?=
 =?utf-8?B?S0o4VGlBNjN6Q293N1RaN05uOGlyWk8rY2RSZmVkWHF0am1tNkhSZVRkenll?=
 =?utf-8?B?K2JNUzU2UWJWZUYwSXE0SDhKR0NPb1JzNnNoTURkeEhHTS9tbVpOd1ZYSUVr?=
 =?utf-8?B?eHpvQjYrRkxLS2lqVlpESHNHTUVIbXNEcld6ZEZUL0RuYVBKWlBsTUxFMjkx?=
 =?utf-8?B?ZjQwdDUwY1lscEVJbTZaam8vNlZZN2ZvRlNOZzFrQlBsUGRkckkrYW9OS2xp?=
 =?utf-8?B?V3EvUDA1SkV4VVk0cEdWQTJWL0RMblRPdEw2WEIybS9ReDc4ajVjc1RzMlY0?=
 =?utf-8?B?eXRjK20rNStJV3ozT2d4Z3NrbTRQTGxrdU1rdGlBamdSemxiRTFqbkt2N1Np?=
 =?utf-8?B?VXFIeitURGxuS3h6Q2RFNnVOak9mQVNZbC9ac0VWV2tKelcraDZ3aVNxRWpZ?=
 =?utf-8?B?VWlRV1gwK0ZteG13UHRoRm9KNG84K0tmYUN1eGhWYm55eHN3WU9aZytZU2E3?=
 =?utf-8?B?Y1NHZXhxbzAyUUd6aFIzUTZPZnA3aEc1V3NjRGlLcDdCUWpaNkhYbHNza3NG?=
 =?utf-8?B?dElMQmowOXZDL0w1V3dEZzlIMklJQldSRFhFZmVNTm1ybEhnd3lOTUpnclR1?=
 =?utf-8?B?ZTNFeGI5MkZlRWYwZ0NwdmhmalJwZU51Y0Q5NUQ2Y2ZTTnFUamg5WnF3OXVF?=
 =?utf-8?Q?iibRt4ue3fFWDopti7LO?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0f52a9-6069-41a6-23e8-08dddefef5ad
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:01:18.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6114


On 8/14/2025 11:55 PM, Anup Patel wrote:
> The hedeleg may be updated by ONE_REG interface before the VCPU
> is run at least once hence set the initial value of hedeleg in
> kvm_arch_vcpu_create() instead of kvm_riscv_vcpu_setup_config().
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/kvm/vcpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty

