Return-Path: <linux-kselftest+bounces-40408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C14ECB3DCA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8BA164FC9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8802FB96C;
	Mon,  1 Sep 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nJS50nOu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012060.outbound.protection.outlook.com [52.103.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B872FB629;
	Mon,  1 Sep 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715888; cv=fail; b=rovAOMnmXhLUZQQvb2bqWEHuucBRQqrgyQMHxTNFcReUUfqmlNeb7EhLRHC7Ekv67iEJBpBPX/mHgaC+Co0IxYHV34BMklC5PoatuItq2DGk3V0/TUbY58NEKeBZPeGlPGrq3+predEzTu+PafRS8n/+IQjKfj/wP/iDavg/agg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715888; c=relaxed/simple;
	bh=08nf6teDtcNzsHB14eCnXPWo7o/0DJP6GlFvdY7aAtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G5KB4FFk41EUTGYZKD4+WDGgtQD05CHN7sYeT4T2vNbGNzJJYatpzQhxck7xcZ2rlp4kdu6Mpcem/rVizZX1mDgI6079xgkqzFqJeAPIDobeTypxr5tcd823Nkuhv9X9lREdeTb5UMnuYZ+rNeAuAzHHhOtJRqbQXrppxHq6Ic8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nJS50nOu; arc=fail smtp.client-ip=52.103.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/4En5+5Q9CPGG2/1XoVTMTDVFAiKmkAwO7u7VPpyVQRXcGNbCr1yo5T46UNo1ZuNl+sAUzFBTMmzFC+7B8dNCgTaD6/4tEyTklbSm9GqmgBZKiaOeUIVCB3t46ce1JE9uJn8CjaCNC2vyWcho967SCFuquF/2kQyF0AIknca+sOZDKb9Gt1ZsMjmFc6Ijbvx6kdfJqJ0xoygw1Ov50di3OetSPx7tIZ7wVWb9Ek3eIMLpCpGO/evJZ7BrdC5uC3sNxZv+iZVcw8eu+bBfEPrw4sML8/kIaJOwOMRSndQj5TCKdeQFUu1PqAz9qMXglZNbj6wZbZQWnZmwl99jWLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpcsV0vcZhkcq9lUapd5G3TcNZWDu77xqeTvFWgA/tE=;
 b=yBNm3qjyUi8JBS2Mv8ldhjdhKDV+T0Cc08l4Xemu2FieMwpbpOTbDZHAg8BUADnYM3PP86K9RyEB/ULzgJDlGimfyLmCAQVBC9S/6Ve1le6XBDJvQNzAcwKBHqHabLfHcw4Sdk+Ol5UGqp4kEdWOo9RP5c9ghd6M9gdvpiIP9GLFPw5rxLMWMR35z6zRNTFEYucV1rK5cn5VNxKAGSswVsoHz0QD0ysS7ybCW6PKHX5+ZDbXdrvMRSxtUQREyg7QA3Ts2GqBQXmoPw+AyKnv1bRbaA0SXzOcH71TLVltPT0JCiSRDYuNNNZStXWIWxB08CK0D+DCCisgjnEa72bVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpcsV0vcZhkcq9lUapd5G3TcNZWDu77xqeTvFWgA/tE=;
 b=nJS50nOuc7mQWLH01K48fhR3k5q6flBtUXJkOWVwWZqFMhq/skjpCGwZYKUf4DGg4I4S04LckFVzhp61ZZXf7G0jhZDZqC9cZe4uXwL3OHTOzW/TMq47hG4XPYu9gcSWsNIuTzF6oAFO1hRAE4gPJ0KIIWLpmrbdsgUbvPJeuCmem2EivR1HzQoqbCo6JxVg3xMT6NVam3CjWI7oqBr0mm+qEa+8nSxQrY6UKAVtVLlSUNiy3fsNjRkHqyETup63J1U3PCKIMGtW6jU6QuTyuC4eHM+YD013FV7F8h5pS6vmx/Kfh6lDrTsCmCb73p/rgeUaz8rivBmNn4gzfej2Ug==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by SEYPR02MB7346.apcprd02.prod.outlook.com (2603:1096:101:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 08:37:57 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:37:56 +0000
Message-ID:
 <TY1PPFCDFFFA68AAC2271361A8A312B8E17F307A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Mon, 1 Sep 2025 16:37:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] KVM: riscv: selftests: add Zilsd and Zclsd
 extension to get-reg-list test
To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, anup@brainfault.org,
 pbonzini@redhat.com, shuah@kernel.org, cyan.yang@sifive.com,
 cleger@rivosinc.com, charlie@rivosinc.com, cuiyunhui@bytedance.com,
 samuel.holland@sifive.com, namcao@linutronix.de, jesse@rivosinc.com,
 inochiama@gmail.com, yongxuan.wang@sifive.com, ajones@ventanamicro.com,
 parri.andrea@gmail.com, mikisabate@gmail.com, yikming2222@gmail.com,
 thomas.weissschuh@linutronix.de
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20250826162939.1494021-1-pincheng.plct@isrc.iscas.ac.cn>
 <20250826162939.1494021-6-pincheng.plct@isrc.iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250826162939.1494021-6-pincheng.plct@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::19) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <f16242e3-5660-467d-8249-7a6cb1853128@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|SEYPR02MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9101aa-c86f-4ce5-fc6a-08dde932d989
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|36102599003|6090799003|23021999003|15080799012|461199028|5072599009|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU5SREZKNFhtQ3N1bmFaZmtyMFFjVTZ1TnZvT3JsVHgySUMyVEk2ekNyMkhk?=
 =?utf-8?B?dEN0Y2FQMUNtYWdpOEkzcnIyUzVqbndtNCtRVWswYy9XZnlUb0hmKzlzTWtY?=
 =?utf-8?B?bjdudzR5VGRkQXRNVnJIeWFlNDVRRmpFYStpQU5QRkFNL1gvc2Z1eHFGbG9X?=
 =?utf-8?B?VEZaYXJOYVZ0NUNkcHpITUVYRmRQcWJ6ZUNGckdlM05qdWk3anF0eFJtZXJB?=
 =?utf-8?B?eWJvaDFiTzJ2WGNPUUJ5bHZNN2wySVNlRFh1QkhzUUFOZTVJamhXOTA1RlE5?=
 =?utf-8?B?aWNwZnpyd0VOWHMrVXQ3NGozMjJrQ1ZxTmRPcjZvYzVVVnJxNmlobXpkM0Zq?=
 =?utf-8?B?MWp2eGhUSzlIdGo0VG5ORGlIbkJFSEh5dkZuWkM5SkF6UTMrRytzUlY3aE5K?=
 =?utf-8?B?dGFac203SW1IWDQ1di9JSStSUzBoZnQ1cVdleXRxMjFHQmpYRUlLQmsvd3lE?=
 =?utf-8?B?MVdxY050Q2lzUkQwUFB2S1dJK04rbXB2UkR2ODhHNE9ZcHZHVDFWU2w0cEpX?=
 =?utf-8?B?MjMvWFVmVXhTVGU2bjAwTzdKcFlLRnRZUDJXcFlQdmtMZ21UNDBBTnJ4cHI3?=
 =?utf-8?B?VVNrdlpzVDFQK1BqcjlzUUJtdVJkVmpwblZlM29VYS9LS2g1andwbVV1NzAw?=
 =?utf-8?B?QTlHUldpMG1nUE5DaHBMM1JpVUFjVHRHS29BaUFFYndPVmI2NUQrVktFUExS?=
 =?utf-8?B?VVpVekdZWmtxSUZpUTZrRTA3Tkc5T09jYjlmOXAyOXFaUTUzR1lzMkpFSHNV?=
 =?utf-8?B?aG90REdETXE1WEVTNjR3dnFQbTZLOGtTZUYzRzJKYUIvMzBHemtXdE9LM1B3?=
 =?utf-8?B?cURkM0FQR3JLU0ZpZjdWMUtMU09lL1RWQjRqL3d2RWZFWDNwUndXQ2lFS0dw?=
 =?utf-8?B?OCs3dzROcisxd3plY3ZvdXlsMklaR1ZCTVZjNzMyOW9VMkhrVWVCOFV2UmZ4?=
 =?utf-8?B?bFRyOVdXclV4NzNVeUVTYVlBSUs2WndyaEw5UlFRUzQ4MGFvOC81SEhSVHM1?=
 =?utf-8?B?amxhbFU3UXZ0Mi9UQzM5a3RCQzQ3VW9kb1kxK096WW1QbE5HNzVLRzltYmZU?=
 =?utf-8?B?dnFWUlRMQS9WY2gvZlZNRnB3OGlTVmJFdTZXeVo4anBuR1BPU1BNQUdlUzI0?=
 =?utf-8?B?S1dKUE5nanZCazFlcUdwdzEzbi9OYmJwbjAxS0JGajJodTJuYmE0Y01TcXpW?=
 =?utf-8?B?RE1Sb0RJZXdIQUEyb3gwMFpPdlhRUU5JbUpOQ1h4aE05YzRqenpWZUxyc2JO?=
 =?utf-8?B?RUNKUUpmYXR6bnVYZEpTVkdxVGt4aG5iblNNT3ZiWjR0dWczMFpRVTZhOGsy?=
 =?utf-8?B?eWdMQVlyVmpvOUNjOVQyZzRiWXAxS294OXM2SkwwRUdGZTBuWFRtd2Fnd2E4?=
 =?utf-8?B?R3k3MHdxZ2hORXJJZS9samRwNHZUcHgrM0tZbnFpdkRlNnY3L3UvL250R2Ri?=
 =?utf-8?B?bVVWbHY4Q3pyL3BmYm9OQXM5VGxHQ1BqY20rb2RxRlV2cDZPM1haa0hUcDA0?=
 =?utf-8?B?eE1xa1YvWUg4M3NNZVJRNHdiWXRlbzFaM3FBT25LYy85cDBNQ2xHUzZ3UzlX?=
 =?utf-8?B?T1RUbE9XQjhYMmE5VkozS0kvd1JTWWduWGZFQzdpMStJQzRmQUlzbVRhTUNu?=
 =?utf-8?B?U2kxZ1VYSFllRWcrdklGNytuVFpBQ1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTZyeFNuUHRRZ1Vwcmk0UE5ERm1iQThVNGNzUXVHQURPQ1JtTjBGQklIYzF1?=
 =?utf-8?B?TmJoYm84UUdqNVpQR0Vqd2sxNU40L0FXb0FNZWJUaitZT0I5RjFvWitMclpJ?=
 =?utf-8?B?dGxLYy9TTWxvYi9zQ2pDZ1JQaDVtQUVIa1dYTnNob1BUSHF0d2pyMHZzRHpD?=
 =?utf-8?B?U29heXN2OUdPdS9wVXU2bklNU2d6TU9wTUhpZ044RW9Qb1BtM0dSRU1jZ1cy?=
 =?utf-8?B?NHErbUpWekFZS2Ftcy9wUFFteU5nMWllZkY0V290c0o2eVJmRElaNlhxQS9B?=
 =?utf-8?B?Q1BFanlmK1FSL2d4V1JaNEhEZmRpeElXSnBuWThQb08yb08vMGJFc0tidDRl?=
 =?utf-8?B?a2ZQOEZKWnIrNStqanJIVWo0Wmo3a0phYWY3NXp4Z0dtVWJBNWk3eFE1ZGV4?=
 =?utf-8?B?aHhrcWcxUFB1NWs5TmsyQkgzK3doU04yeVpKdEtVSmduUEZIT2N1RVk3Y2pp?=
 =?utf-8?B?WUUrNml4bE1sM056SndOMm12MEVGK3V1Wi9jaVhSbHV2NDcyL25uSW9QS21C?=
 =?utf-8?B?eGhXUURmeHp1NDRRUnBEQzBJMm1jK2ZSR1dlbzYvZHZkK3MwV3lid3JaYnlB?=
 =?utf-8?B?Y0IrMTcvVTFPT3pjNXZUMFBDbVB4NTcwWkVpR1htSXRhdTJ2N0o4WHhBOEtN?=
 =?utf-8?B?b09UN3dTMENaTmExR2cxOEtOY0JyQWlvMElLV3p0REpRZzl5VnI1REJGTlE0?=
 =?utf-8?B?OFZMNWlyempYd2htTCtSSGFGTys3TjdzZGk5enlDazluYnl0TXpnaVZrSUN5?=
 =?utf-8?B?QzZ6NGF1V0FuM01sV21CalU2OXJNZXN0M01COUc2VG1pM3JEaUhkN0RDNkhy?=
 =?utf-8?B?cWFpR1l2VXVyRXhWQTZZMVNKcFl5aTNSS1plSVRxWjd4OWVUTGRwanZPOE1Z?=
 =?utf-8?B?VnZZZjBPMWRjUUFneWlEN1FRWHcvc3ZGQWRLTDRGSTl3amJ2QTA1MjI3YzBw?=
 =?utf-8?B?ZnUzTCtoa05TTW1mRHNqK3B4cFJXTG92T2hHM3JCdkFXbUh1eTRtZGsrNHpp?=
 =?utf-8?B?WndPN0hyNCtYTW9UYlVyODV1TTdGaWxkRGxDaStHUE5Jc2hnK09VU2pkb0V1?=
 =?utf-8?B?RlNwSEt0aXdEengxMEVuQ1YwNXNERXVOU1NYQXc3Zk1SMkxiRUFKYlVSNStP?=
 =?utf-8?B?OVJOaGFUMHFWcUgwK3U3M0xzMnR2bVBPQ1hvWGg4K2hWdXkyWUZ3REZLZGNi?=
 =?utf-8?B?UWlsNGVoM29tRXVFL2s1ZUtjWWNQUXpqWE9YeUs0QURCNXZYVFJLS0JpcmFo?=
 =?utf-8?B?MTF0VXllMGNqQ1dwRnowZk9Ib21jOEZVZ0JWYUZTTmNxMEs1VFZEb3c1K0Zm?=
 =?utf-8?B?ZGJEMmtmcUd0cWNlT3dXaDM1MzdXVldmZURuRGJzR3BCZWdYWHhiZWNuOUpu?=
 =?utf-8?B?amkwQzhpamVaVitvcHo0MGRnOTRkcURaYWJjSm1ZYXQzalZUc3FvWXpmOGFx?=
 =?utf-8?B?WFBCMzRpRHdZMkJtai9YVnp3SXdFdmVaRW5IVEVGMisrTEtTK2xudGNST1do?=
 =?utf-8?B?TE1jVEZuOUtIdWg0T2xOVlNpSkZCbC82OXd6azNMWEtzbmg3R0JmZHhJbGor?=
 =?utf-8?B?VEN5bXlrdmp4NkRJVS9sM0xIcEI4bVNzajJSV2tWZTB4aUhPdkMvamhTVVZC?=
 =?utf-8?Q?JbfwrfGWqaDEZ2eroVyGSO8ql4iFO7WREYibDUnJkPEM=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9101aa-c86f-4ce5-fc6a-08dde932d989
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:37:56.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7346


On 8/27/2025 12:29 AM, Pincheng Wang wrote:
> The KVM RISC-V allows Zilsd and Zclsd extensions for Guest/VM so add
> this extension to get-reg-list test.
>
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> ---
>   tools/testing/selftests/kvm/riscv/get-reg-list.c | 6 ++++++
>   1 file changed, 6 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks.
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index a0b7dabb5040..477bd386265f 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -78,7 +78,9 @@ bool filter_reg(__u64 reg)
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCB:
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCD:
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCF:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCLSD:
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCMOP:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZILSD:
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFA:
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFH:
>   	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFHMIN:
> @@ -530,7 +532,9 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>   		KVM_ISA_EXT_ARR(ZCB),
>   		KVM_ISA_EXT_ARR(ZCD),
>   		KVM_ISA_EXT_ARR(ZCF),
> +		KVM_ISA_EXT_ARR(ZCLSD),
>   		KVM_ISA_EXT_ARR(ZCMOP),
> +		KVM_ISA_EXT_ARR(ZILSD),
>   		KVM_ISA_EXT_ARR(ZFA),
>   		KVM_ISA_EXT_ARR(ZFH),
>   		KVM_ISA_EXT_ARR(ZFHMIN),
> @@ -1199,7 +1203,9 @@ struct vcpu_reg_list *vcpu_configs[] = {
>   	&config_zcb,
>   	&config_zcd,
>   	&config_zcf,
> +	&config_zclsd,
>   	&config_zcmop,
> +	&config_zilsd,
>   	&config_zfa,
>   	&config_zfh,
>   	&config_zfhmin,

