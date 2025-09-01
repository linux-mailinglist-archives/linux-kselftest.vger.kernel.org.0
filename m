Return-Path: <linux-kselftest+bounces-40410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4925B3DCCA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706BC1765AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDFC2FB62E;
	Mon,  1 Sep 2025 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Cn+gQR2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013084.outbound.protection.outlook.com [52.103.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BC1DF252;
	Mon,  1 Sep 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716098; cv=fail; b=oGesGsMtRy/6XRosbkPEIqQNadktcGqpv4YzbquqaSAKUOIVXnmxz1BRXmy7p06gXcKWxortGgyfy4U3HXL8nT/OwjNWlcOgbHo6EV59IuPTeVzBwT62tbTQrfSflh/IYGJkM7XW5c6BW00eg+H1jAEI+x7vqVxUe8DxJedQEoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716098; c=relaxed/simple;
	bh=t29j3NmA0rWUWjjE5nLa+RXxft2te+1ZxPSOPZkrRwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bZHECtrZI6IauXugii4hgE7mFOyLZvaLGU1AbMaJF9Uper/t2RbY5pfTErZ/ruJuTTXWLoOqNGKs9TvJ5b4Mk/ql1G7J6m+PYbNiKzPIuxHFZn5eAYc8NBthiscH3W2yijtbbZVyQz2vv+o6TVrBOlVR2U/70D00U23wgbIsWSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Cn+gQR2E; arc=fail smtp.client-ip=52.103.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdhQFm0s/Nt5KwYj1uspgZpXQ08MagYcF/y3HkABuH0SL0mrCjg728glCc4gOUttoZYv5U9iLZO03EITtRdcbaSQU8l/w5qcqOH3ACdgFAEiu/bxMLO9dw/M3uMRJoCPi/UMlUskh03HUAxhvqedsU1Jubo+Quj72z5KiaJkv1E0tlGjMz6IohpzkO4ABqR7A2TFfNw/0IXS6JPy+NNZe0xfWRY0D7/HeetzzDRbhGBC2ft1GPCHYU/uUjzrNwfrhCzCkxU+9m5gpXh2zt3F7DXTTCf2vBoDLemhbxgtVT3JkSC/Y/okvc9vI/wGBe+iRXl+TFd8ettRokCbdBWAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU3t9qxw7DBJdbnN0C85FYQCrcvFBErAwZcIGOP2rfc=;
 b=DUZL7oZlH1tAIC9lYe5L9EubxRqwsOS3iaX2SI1oJ7fgddnPGdnkU+s+DocUlGDBp2aOaPsVqJ+Pjzz37le+OLYMCdHHV2gzCFtMMZVCb4PFbKTovKUZRDyvr1aMF2682cXiH6OO4g7fOvlgatrE35W/7hUBWuKsADQnJx28HCpMn3Q5eicbaIO2c5fLyK/zgPOFlMCreTuSym8ic0/A0PvLMWZNUDeYSwnjB2REJkCGn/GE7FS/yiyJLzpN+HyBA9xnFW8Aa/Sp9w/qo6tWRPuIstJtPK51XIX7WD9qTBgIPAjAKLFZvd/K1+ieNykfJmMOm4d4EjaHw+j6Uvsfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU3t9qxw7DBJdbnN0C85FYQCrcvFBErAwZcIGOP2rfc=;
 b=Cn+gQR2EvWqkb0XiPRrG69OEEFhlzgeqDSsrvM3WFWhxrFP0PEB8ILc7AMk3tP+T31QtKX001gDUW7utIYilOB9e9A7DphBujerqz+7K50YahsjKBchu1v/E6BU1WGDECfUyulBXrb83cpw0IDlFyDFQ3OW2dXybp97V6MmL/Iz9Ufsr+FULH7VBlqKjlFdWZWgPTUnHwhH3qjaQdSKRYAieCiZWqibt3x027cDW63hMIEWHA9NilLOPFXmhTKoV0qbPFG9v3+d6bmRPPvtNSJtUOzqp6/s9IMBzqGN5j/RG4VIqrx27Z/uGGkZJc5H/i8UJDVGiO/22U10I1RYKaQ==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by KUXPR02MB8767.apcprd02.prod.outlook.com (2603:1096:d10:3f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 08:41:26 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:41:25 +0000
Message-ID:
 <TY1PPFCDFFFA68A00ECA8C7E8C06AF8A93BF307A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Mon, 1 Sep 2025 16:41:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] riscv: add ISA extension parsing for Zilsd and
 Zclsd
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
 <20250826162939.1494021-3-pincheng.plct@isrc.iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250826162939.1494021-3-pincheng.plct@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0302.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::14) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <01b09004-8088-4e66-8e91-3cf498a027ed@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|KUXPR02MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 375e0a10-4e36-456b-92f9-08dde93355f7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|6090799003|23021999003|36102599003|461199028|19110799012|8060799015|5072599009|440099028|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjA0QnhLNnJ5aXR0V3dlN3JEL1hYVk4rcmhNREdLS2xuWS9heDVEbXB2bS92?=
 =?utf-8?B?c3ZObVdqNFlRVEkxeXZCczBxSmNOUHM3cE9XSWFjdXU3cEVzcXgzdnBpZjNU?=
 =?utf-8?B?eFJGbVl5aWFqSjYvbXI4Wks4V3JpMkFHSWxCZXlZcDM5cERCTWhOZXBFT0Zi?=
 =?utf-8?B?eG5OUFRXbFZSYXczR28rbTJwd2c1cU5WaWVXajFCcjY5VHdTbnVxYitIRnl5?=
 =?utf-8?B?U2xHSTBzSWJWNmV2UDlJazE2cjB0WG5YVm5JNk9sQTBWUnoxeG14NjY4d2tk?=
 =?utf-8?B?a0RFMUF6MHNnUGNqWWJZT3A1NlJGTlhacjRiaUhKWVlid2VzMU5LMFk2SUpS?=
 =?utf-8?B?a1ZuZjloQzdHZ3F2SXBtRmhlaWVwL1ZvazZvY05hdEJGTzRBWnoxVUVrWWxK?=
 =?utf-8?B?Qm9xc0tkWnIxN3JvZXczcVlDL1hIMDRFbHl5aTdHczgrdUo3S0pRVUlnYVJG?=
 =?utf-8?B?STlRSzJOZHUwblRJbWx5K296SXF5RGpHclEzSGV4Z3lubGg0QVlxaHFzaWVx?=
 =?utf-8?B?NEQwWkVKdlpCTldUMXRXTXpFSktqOE1TYzNqVDcvSnRGOUFPbnNDVC9OVXB5?=
 =?utf-8?B?L0VURmVFZk10SERSblFNZW1ySG9PV3paNndvajRiVXBIM0lNR1pXS1FkSk01?=
 =?utf-8?B?VlYzMzArU2pROFNtUG13bGgrRlhiYy9KS0xVZWY1MlVqRmNVTmdKQmFsSXBB?=
 =?utf-8?B?eUdTMXMvTkNsNmQ1YTBCYmpmYzZBQ0hxVEZrQi9neUJ1bmpKRytYUElXZmxT?=
 =?utf-8?B?WUJxWGJuYkk1Z2g4MFh3QkFCeExTb2doZzVlMmtyZGdkTHo3MXE1bmhPZGJP?=
 =?utf-8?B?RERXa1NxdHdTSVdsUnl2Vmpjc0tDbzNqSjNMN016V1A5R3NPZ0t0Yk1nWUlZ?=
 =?utf-8?B?ZUZUbERyTVhnMDNIT2pmeEsxeVlYcXpubXNaeEhnWFJnajg5eElPV08xUjJG?=
 =?utf-8?B?L09ZNFJNZElSNUdaL1M2a0tqS3hpT2lSZnJvRnZndXdlNUFkRXl6MlN1dmpL?=
 =?utf-8?B?RUJDS29PRW9Td0NyT1BUbmRJTFN3Q0I1cEl5K3FXeTF4dDBIcVFGSldaTUNZ?=
 =?utf-8?B?OTlYamZGdkZlTUR4dWxIV2laa0tJU1U3Vm5HMlk5RHVBN2s0eENyWVF3OVZl?=
 =?utf-8?B?aG81VmlmTzd0WHNtRElYL2xVRDJFZ1l2dDhpd1ZWWGY1ZTZnZHpDaVFESGNI?=
 =?utf-8?B?V0ZESGczMVRjY1YzNlpuTndJMHBnQTh2aWxrQTlLMnpFa1RpTVlodDBrV0N2?=
 =?utf-8?B?T0JBR3J6N1dXWFZWaHJQUVZ3OXV0anlJSnFhOTdac0xoZURGaHNRQ2N0Vm5G?=
 =?utf-8?B?a1R5OTdFWkl5L0xjRWhoOEJpVmdDU05FR2srWU9DM1ZibWhBZkw1Z0NWOGRp?=
 =?utf-8?B?YUhCQlFlRzZ0SUVOSDJBMDRwa3N5blNjSitBTjlsWjNaUm9kYSt4R1haQU9P?=
 =?utf-8?B?OGF5ZGFxQ3hYdFIxUy9DM0gvSEhDWTNkblFoMFZiYXk4ano0WUZzYTVWNmRs?=
 =?utf-8?B?VWFPTkR5Q0tmai9mSUUyMFFuemgzZzYvaTNVVnZJbFUrZU5XK0g3c0ZaVkVE?=
 =?utf-8?B?dFplbDBZeitWSSt4T3l4OWYzK1hSNTQzMGV6TUp5UVpMUW9zRGdKWWY2WlBU?=
 =?utf-8?B?bTl6UXBScHc0TzFSSHdhZWVqdGM1N1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldDUUVCdzBacFp4bGh1WG03SDllWFRuRGJ5MDBzeFdyYnZTZ0l6VGVja1BW?=
 =?utf-8?B?RDA2VDVWNmpvelltWms5MFpoY3k5NmJVaGNhK3UyaERxNXNRRktHemV5dXB6?=
 =?utf-8?B?VVRjZFR5YWczOUkxcllScVkvbXNJSVJZQXRKbmMxWnF0UXplV052VjRFbU9L?=
 =?utf-8?B?eldWYlI0aUtCT1Y2MXJGQmVEYUY2UVpMZ2FSak5LcTFub2RUTHVRTExUeFVk?=
 =?utf-8?B?OVZPZHRDTUdBQnZqbzNVOWlkZFkzOVVvNmw4eEZIa1JWNmR1QmhBYnIxRDhr?=
 =?utf-8?B?aWo0bzlUTDV1QU5CaGVxVVR2N3N1ai9NY0NJVytTQ00xUkJoOXBud1d0U25s?=
 =?utf-8?B?WVlPc0FIbG93dCs4eS9CVW8xU20yeUl4bCtHa0N4ZWZ1T2NoeDc3YnljT0k4?=
 =?utf-8?B?V1hQZFp6NGdYUW9RL2VMME0zMFVYMU1RWllRYmRoMEExV0lCdHlOb1dBNk5s?=
 =?utf-8?B?SW1zNzJvR1JBWEZlRDh2TzZtc2ttVkhFZDZ5K2pHTm1IVWkvbi82T0gxUGRF?=
 =?utf-8?B?SUlvdG0xbFovV0NleWRURWRkWmVmeHRkbm1YRzRqVXVWNUpZQ2NTbVhGVENv?=
 =?utf-8?B?aTBwcXRXd0xMV3IwNWZhdjVRN3ViOXJBSWVvZGJQUDVMWkpsVG9ZK2pGNWFo?=
 =?utf-8?B?K09NV2llYisrODV3Tnh3NSsvdTlGN1VFakVzS2NzUGt5STF4Ky9BRmVTVVBH?=
 =?utf-8?B?VG9JUFdoQURodDFMNy85cTdPQWNqejloMnk4bVA0Y3FQUlRzWTZ1SXo1NUJ0?=
 =?utf-8?B?SHE0Z20wNnRjUnZRTWNKK3lrMHl2Uitna3puazFaZVB2MnMxWWxDcmhPbVp0?=
 =?utf-8?B?UVFkLytDNSt4QWFTZUxPWjh4Q0NuZ2ZPS2VxTTRiMWNNenB1V25Cam9lSE9z?=
 =?utf-8?B?dEZHOWNNNUVuM2Nsc2ZuNGhka1o3cEFzVlhWQllMZ0U2U1NMTnI0ZldwQkRY?=
 =?utf-8?B?M0J2MHNxSE5qNmdNRDB3NlNxNzdObFBVWTZ6RGxSMU5NblF0azVOdXlwb2po?=
 =?utf-8?B?M1YySWZmOGl0dU5tVVJ1OUN3OTFNVGZQejFLZkFZY3JvYU9IUUFKYklZZXRY?=
 =?utf-8?B?RVdtdWJNTG1vWHByczAxaUUvYzZZNklTRDh5L0N3TUZCbUFBZzRVM2hMZFpz?=
 =?utf-8?B?VUFxbTRaUVVGdVJmUU1aOW9FY1RLaW90dWNqR2dZdnVWMnhrTlZ1UENzUFo1?=
 =?utf-8?B?QmprRzlnbVhWL3JJNXc4SDlidngyWHJsYUdlQ3ZpdlE3NEt6bHpoV1JnZFlu?=
 =?utf-8?B?aUtvK0h3SUNZRnV0Z2RFN3FVNm1pZnhFa3FxeDBnUzBrTTFsaElNanB3bUwz?=
 =?utf-8?B?U2JWbTVTWk9lNW1WU08zTW56b0N0L2dyanlPRkY5ei90VWpiL3FJMFRlOUxs?=
 =?utf-8?B?eUdSdWxCSjBUTXZFM0sxVDRPWnB3by91cVlpYmpNUzUrWU40MUZsWXdQRG40?=
 =?utf-8?B?RFlIRW1tUVRwdXRCSVVieU82V3djV3NCWFV5aWQzYXJiZVVveWlDb1NZN01K?=
 =?utf-8?B?VllFZ1BOS0tRSnJXSjRWYlYyV0pMOTBWM1hjUU5QUWlWcUVLd3A4UkYxN0lB?=
 =?utf-8?B?ellXVTY0MmwwRGpmNmxNOHhwdERTM1dsaWlYaUlaKzlHV1NzeWVYbFpRamRL?=
 =?utf-8?Q?NqMJA7YipAJB0VFt98ddOoGtS6ly2WAdk1QYVurXhcBw=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e0a10-4e36-456b-92f9-08dde93355f7
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:41:25.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8767


On 8/27/2025 12:29 AM, Pincheng Wang wrote:
> Add parsing for Zilsd and Zclsd ISA extensions which were ratified in
> commit f88abf1 ("Integrating load/store pair for RV32 with the
> main manual") of the riscv-isa-manual.
>
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> ---
>   arch/riscv/include/asm/hwcap.h |  2 ++
>   arch/riscv/kernel/cpufeature.c | 24 ++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks.

