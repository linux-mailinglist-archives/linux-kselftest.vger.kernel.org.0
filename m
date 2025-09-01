Return-Path: <linux-kselftest+bounces-40407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9963B3DC9F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E2A3A5181
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8BD2FAC1C;
	Mon,  1 Sep 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bf6QovfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012060.outbound.protection.outlook.com [52.103.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4D258CCC;
	Mon,  1 Sep 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715857; cv=fail; b=fTKXQl2bKX99+aqVxjIlDemiQHNzrQknfEPnMxiwtGbsL2WiV9dUmUNgSEq+RlKtjntpKuMblRt+xRTlKFx+pi+3njC2JPBt5yHX5uY2P/Hl+8f9r5TOiE+K58haKnsBz8hQYBdDadIH44dIkQkN/TNYFaZ7NOMwrT8e5gz39Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715857; c=relaxed/simple;
	bh=OyvLH2qQ9wfT3gQaVOv5WkAcyvLGLMMbW/yKEx/YqQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jkkiYVrM9YVjTJR641E1217e5kVCLl+xiSZtsST/gUHDv1YqK3HIxK7lWxTkXsqtlcfeg4h4DKT7RZthcVwRlALkL6nHh7QUvvTwKahqAluFqEaJeRmwO9btnI9igMRHTk5ebRc3pStLx/kYb3w/6co8lsnB/DIAaRA8fR47r+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bf6QovfG; arc=fail smtp.client-ip=52.103.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0OM5rS4YtxiaJ6Rggn9BnhiDVyyum9FkSDQ4W7QxbMFi40rEQggdeHaInE3LPdj8LAgF7umEiymIc0i1/VJhYABuJWA/VPBN/UJnfCdkMbcgLP8MsvfntowYcj+OftkmgSpzyqMfO2rE8Oap8sIZwMlFKdBQFw4o8RDVzqjHJkM2sSC7q2LX6UudZyks53GGYpYdN4r7yLf22bh5cTSpJpHMVkkeuSvvv7psSBhO7GC/oG+C1zVUSRsxHhM6vNhg1hCtUgn1YgOvk6eeG/KAvAWE3edz4ufuaHVefWUwXzp9uVJ7hC1BqE6ZSdzR2MuxZq/bDXE+lKTxAW1a/J57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAyi+ijNsYiPUHR6fSBL+bKN/qyj3KO6zaUVaG0cW4E=;
 b=E38sP22gBJwvbFPIsV7BHix/e1pBi4diHOpNqQDeHqEpRo4AXDps52FcejBvIPKy+vyGRjLCcX+a/zf6MsTljPc3BRfDuXUAq38Lh94fiU51vHoRWkFXghFFCNdxJuMK9EZQe6/qRuikGihD+saNGHv4S+W8biH6ioAD01v4bT+zrE1MNJUXTFxu8jtpueXOf11sraV843twTa9V169BtH2cDFhA2FnV9HgdiqGDtWz5FJ1+Q3MStvRpvuVaSpcJCvgjMe2Eftv9M4xhJr5wCdMXpOfwllxlTFDKqM1PQdh0qdW8ClWvMDxRiLLvu8ceQSCd+QNDKExZfqJK7rsBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAyi+ijNsYiPUHR6fSBL+bKN/qyj3KO6zaUVaG0cW4E=;
 b=bf6QovfGY8n0JRmMnk4xcQT+M+a91KSq4zNCWDRhFHyfZI56+AB/TOlkIM9rymgo2yxUGEnAh++kPWnzKnjjCphAvtvG7e3r+WKNwiUNGkl5iX74G0Q6/VtAqnVvS2+U7e5Ea6+/s12SMaGKqSmca78ubPu8r8BW7CRY+YCH8scTvYLgCIo3wWgm5Xu2nJ3r/CXqn9N7uJg9EfAO53yg1cb8bYRttQj8uofTPqw3hj0hA7OYSB+cEuI5qoVAyWzZAEFDTBcCfl5blFd4EaUP6gh3XzJGo1XqDwl/9+8YX7AiIDLWg9Hyb8ihP9UcQGybgN6VrdvGLv1wpozpureyhA==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by SEYPR02MB7346.apcprd02.prod.outlook.com (2603:1096:101:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 08:37:26 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:37:25 +0000
Message-ID:
 <TY1PPFCDFFFA68A76C7AFB2E450E914B484F307A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Mon, 1 Sep 2025 16:37:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] riscv: KVM: allow Zilsd and Zclsd extensions for
 Guest/VM
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
 <20250826162939.1494021-5-pincheng.plct@isrc.iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250826162939.1494021-5-pincheng.plct@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::22) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <071402e4-b30a-405f-9778-41727a615948@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|SEYPR02MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 451dec77-4b4e-4105-df3c-08dde932c67a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|36102599003|6090799003|23021999003|15080799012|461199028|5072599009|3412199025|41105399003|40105399003|440099028|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtRNTZkK3FsRTU2OHJHYUdpUVRnVzBPUnFOUzFkTnplNkRtcmgvblRPeFk3?=
 =?utf-8?B?Q2JHa3JTcjlxMXJXTkFPaFQzejRQU0dDSC9YTUFFc2RKbFkxVzEzMitzcUVE?=
 =?utf-8?B?VTlzOEdLRGFZYnl6Z2Y5MlMyTjdqcGJ6cEFFNGVRVlFBVTkyUlZsZGlvOGkz?=
 =?utf-8?B?bUkvRThZZ25iNEhyWFJJZUZTMjJNazA4NnkvVC9rZ3FzQkhVdWlCVzIzd3JR?=
 =?utf-8?B?dnEyWHZFU2I5eURySzdITkZDeVJIZmFzYmN6aUU4M3drK0VLck1JZG1nRDRB?=
 =?utf-8?B?SVBUM0NuLzhmTUtXTGh4Z2R4MnVtTktiaFlNMUJ3aWVlNHRhRVYvUGJSYUNV?=
 =?utf-8?B?akUvRGlCcDdoTk1QOG1nZ01WT1RxY1hLNTRUL0QvcE9xS0ErcDhlNTBLR3ZZ?=
 =?utf-8?B?Nzk3T3pWV0RURXNWTXlwU1NNMzVUNXZMMzN6VkxTdDBkYi9GKzdMYWNLVmZi?=
 =?utf-8?B?bE4xU0ZMSHY2SDN2VFIvU041eWNpNk95Uklsb1F4bVNXcGVFMm5JNXpmTmto?=
 =?utf-8?B?MVM5YXNhd1NuZ1YzSEVlTXhwRk9lOE1GY0JxUjczQm1jQnI1MEE2N0ttem9V?=
 =?utf-8?B?TVFuVnUyS2JlVXMrVmZtd1B1U1lWS3hyYldyUlVZZVV5eTZoT0JTSzRwcGJE?=
 =?utf-8?B?dGhGV01PT1p2VHBaVC9LMnJYVHhBcGMyTVFDdUNZcnQ5MXk1VmVXemZGMGd5?=
 =?utf-8?B?Sjl5R3BZUE16UFZ3V3Q0RU1iSlh6dW55ZE91TnY5bmVkbTUzYWZHUWl3STB3?=
 =?utf-8?B?SEdDZk16NndlZW9TZ1hrZDEwZklQcVNIVE12Szg5ODZuSUE3NnFrMmJaME1R?=
 =?utf-8?B?MVp5ZjhhUkE2WCswV1Nhc2dLR1RBdmdVbi9VTEFMTmExdkVJa0tSK3ZqakU4?=
 =?utf-8?B?Sk5qOE52Tk8zVk0wUVMzN1lZL0UyV0xQdjRPRVFLYmI1MlltQVJKcHR6VXJV?=
 =?utf-8?B?S1pleHpKdXNkY0k4TFZmRW52WUppek8yNlFpNVdCSUVab2NMb3hvYTNCYnds?=
 =?utf-8?B?Q3FDaGw1TEVCSTBRU3FrMVVUM0xxOXBncjFmY01YZkZIN0hIdjVGbjJoZU5G?=
 =?utf-8?B?SXZuSVNGSElTUythS2tzOG1JVklWeFozYnZvdi93Ky9Sc1paUVlaS1MrRVVz?=
 =?utf-8?B?VWhjMGVBRDNMbm9VYWxObThhSE1wc2lZTzROZ0FtYmJTdGdMbzZJcXM2bzZQ?=
 =?utf-8?B?Qkw2SE1MWGRseFdvQ0JRVEdOWXQvOGNVRmE1UTdBRk0zQytXTTZkOEtJMVBj?=
 =?utf-8?B?SFBLS1V4VmhuQVlDV2w0bXBjRmlZV3Y2aHVKengvaWljejAycFlJbS9PZXk5?=
 =?utf-8?B?TDBiWEVzQVBJYTh3dEpMTCtjQnhOZEl4VnJ4dmtySjhqbElIdFJjN21CR1Iy?=
 =?utf-8?B?RExKeFVKWmx2K21uY2RwY0p6bVV5Tjh1aHVxMU1tcmVaSzA5L3JSWWtNSmJB?=
 =?utf-8?B?ZUN6QmtSYUNtZGFscFpmWFRZc1N5ejNDc014dWdJdkJScTBwNzgrenovVVlz?=
 =?utf-8?B?ZCsyWDlWdjNvNnRDazlwSWRwVTFrcFFFaU1BNkVUbUMrMGdIYmJYWVIrdHBx?=
 =?utf-8?B?SEpIVW1qbWI0ZUZEWW90ai9wSm5nUy8ySUpsUlBFKzlQMUltQmI4Zm1kY1Y2?=
 =?utf-8?B?cnoySy90VGRPZHZ6L3ZxOXJYWU9WZHVhQUhXM0FJdCtmcEtlZVlldlVuaEQx?=
 =?utf-8?B?YVN4ekpicTZlRFNaQk50a1lOenlPZlFZcVlyb1R6Rjh6OVBhY2lpblZ3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2FPemVlWSt5cDNxbnNHbUhjN1FtOFRTZFRML1hreHVxQWNuR2RENDNmQmM3?=
 =?utf-8?B?VHgrT2g2VkZOT3pQaDhROGpqNFRsd0did1hScmJlUjM4RkFINkVhd3V1T01Z?=
 =?utf-8?B?TXMyZVJFSHVaVDM1dUtIOWpkZTFXYVQxaWY0RGN3KzkycFBXOW02U1AwN0RW?=
 =?utf-8?B?UGFOeWszMzhiNS9KbkFxVlYxUkVjSHFjVEh1QXdNdmFWS3ZSeHFaNzR5aWx5?=
 =?utf-8?B?TkowVktWQ0JXZ1RJcERjREk2bjA4MUJQeGpNNm9yNEtnWHZJM0lYakF5SGIv?=
 =?utf-8?B?MWh3MDhyY0VQMWg3ZjQza1hKbTZIeGpYUE12L3VmN0pGNkRYeThuM2RjUmJ5?=
 =?utf-8?B?TFJxQS9nYkpFWXBvK0tYY291Z2lrdzAzSURac1hnQlNFM0pyd0M3ZDBaa2Qr?=
 =?utf-8?B?eEljMTNmZE1ZYVVFdWxLM1RLdzFGdlVRL0NUakFhQzlERVpTOHpobVBiNGxV?=
 =?utf-8?B?aDVmRm9nS3BrYXFqUlpxWWZLU1h4Q01lV05yYXRBRFBuWWlHODFQMWtmL0kx?=
 =?utf-8?B?RW1GTVIwMzg1UVVrTUl6V0tJeXNLcVBicVhHeE9rRDlLNWxXenliU2tQdXZs?=
 =?utf-8?B?SXdHTW96ODR4ZnppSnRPMVFMRENFeGo4ckt2UlhQK29qUXBjU1V3dkJONlZP?=
 =?utf-8?B?RHNxb3FwaFVFQmo4bUorZWJ3c1J6ek13SHg4RHRSWTdLbXd4dHAzNWZ3QW5C?=
 =?utf-8?B?UTBWUkVHM21sSXQ0bHl3NWRJUllBa05LNlZQVzIrNkg1WjE3SU1QRlducVR4?=
 =?utf-8?B?bzJQY2FiU043b2RZRFhPZ3Y5UjBBSGNGcVJQRHZ1UTNMN1ZKTVAvd3NUZ2Zj?=
 =?utf-8?B?SXVxd3JVUDV4TnBkdXVTNFE4YnIxRWRoS3FFaDY0NFBNTkRKeHY2MkdZY29M?=
 =?utf-8?B?SEtxU05KcUtQeUtFb3VzZ2IrUzFYWmpJdXREL1hGUC80MHZxWnBzdnVlRlVn?=
 =?utf-8?B?UEpRYS85ZVFjc04ycGlFZ0J5TVNXNS9VR2Q3UlZiTnNlWEtRYm1xTy9ablU4?=
 =?utf-8?B?VnBXNVFlSE9IM3VaUGhoZFY1VGd0K2daL0lCTTVsQ3FBTlpTb0dOUzUyaDdM?=
 =?utf-8?B?ZkVWc3RWWUZOMFFzalRCZkh5R0hMdlAybE94cEdIdkxwTUVBMHZYdVg1Q05W?=
 =?utf-8?B?NVBXMUpWTEs2UTVNZXFxVnhTRDFPako4OWRSZkFvR2Z1cmZZVjVNKzQwNlg1?=
 =?utf-8?B?alNiYWxDY3g3ampoWkZ0K21IKysydUtBSGR0TDBFY3c0V3dKWXNnajFqdEVx?=
 =?utf-8?B?aFFFeEVEcHJKTlFzYmVFNE9GNlVVK3Y0Z0FxV20wNU11TU1UY3JNRXlHSng5?=
 =?utf-8?B?T1hrYmw1TEM2SmNUSDhHNXRidS9EWnRKaEtIT0NUN2lqbU5aQmZjTHNyYVkv?=
 =?utf-8?B?akMxbkU3M1pDNmdNTVp3ZGR3dEd6ZmdDV0xRQVZRTGJJL1pLRFVGY3oveTg1?=
 =?utf-8?B?MFZFSEpTb3JDYXhtT0VIaUV6eTl6VGxTdmFvbDVURzY0Q0c1WGNTRnV3NTRG?=
 =?utf-8?B?WkI0R21mUGN4eWZONXZSa1VhTHcrY1F5ZW42bnJ2YVhhdFBVaWlDTUpnVDhB?=
 =?utf-8?B?eURpV01IclVLNml6NkllTEJnYUg5THhNMFRJTDVCamh0elBNaS83WjhHMmNu?=
 =?utf-8?Q?1UIclRxfPOsZXtgoDvLAJJrflBG+2WfyhXJ3YOEld+FE=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 451dec77-4b4e-4105-df3c-08dde932c67a
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:37:25.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7346


On 8/27/2025 12:29 AM, Pincheng Wang wrote:
> Extend the KVM ISA extension ONE_REG interface to allow KVM user space
> to detect and enable Zilsd and Zclsd extensions for Guest/VM.
>
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> ---
>   arch/riscv/include/uapi/asm/kvm.h | 2 ++
>   arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>   2 files changed, 4 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks.
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 5f59fd226cc5..beb7ce06dce8 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -174,6 +174,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>   	KVM_RISCV_ISA_EXT_ZCD,
>   	KVM_RISCV_ISA_EXT_ZCF,
>   	KVM_RISCV_ISA_EXT_ZCMOP,
> +	KVM_RISCV_ISA_EXT_ZCLSD,
> +	KVM_RISCV_ISA_EXT_ZILSD,
>   	KVM_RISCV_ISA_EXT_ZAWRS,
>   	KVM_RISCV_ISA_EXT_SMNPM,
>   	KVM_RISCV_ISA_EXT_SSNPM,
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 2e1b646f0d61..8219769fc4a1 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -64,6 +64,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>   	KVM_ISA_EXT_ARR(ZCD),
>   	KVM_ISA_EXT_ARR(ZCF),
>   	KVM_ISA_EXT_ARR(ZCMOP),
> +	KVM_ISA_EXT_ARR(ZCLSD),
>   	KVM_ISA_EXT_ARR(ZFA),
>   	KVM_ISA_EXT_ARR(ZFH),
>   	KVM_ISA_EXT_ARR(ZFHMIN),
> @@ -78,6 +79,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>   	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
>   	KVM_ISA_EXT_ARR(ZIHPM),
>   	KVM_ISA_EXT_ARR(ZIMOP),
> +	KVM_ISA_EXT_ARR(ZILSD),
>   	KVM_ISA_EXT_ARR(ZKND),
>   	KVM_ISA_EXT_ARR(ZKNE),
>   	KVM_ISA_EXT_ARR(ZKNH),

