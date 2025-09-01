Return-Path: <linux-kselftest+bounces-40412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF80B3DCED
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948D81894F11
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660B2FE593;
	Mon,  1 Sep 2025 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fob8bwE8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013078.outbound.protection.outlook.com [52.103.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07832FE568;
	Mon,  1 Sep 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716421; cv=fail; b=K9ExchmjerIQjXIfVElv/HdZBgDJ3cgNJUTXggqu41Ssuu0QZSdRGMbQ+f6vcjfHyU9kidzR+5U6E/9yMR6+2YEHGTqJF4JinPQ/crT8zL9MfVFe1V1ouhYgxExzsXysmluXyY2jh8e8MAnv3FD+9DRd4YB0tM9xP+DEKF+iivQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716421; c=relaxed/simple;
	bh=wBxo9FQAsr4YmK4cPe4WSlFok6WEYDwCiUL+vTgmOpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kl36ODjZ6Zv8CTi1/aJHu//PvSr4kRnPbpVl8Gd3698D04wrgFicBw2cSb/5HyALDxtK8/g6gXu4M78yXrixvo+VeAGsocyzTenCJK0CsL6YFNpy+amSKPGUAFwCEsi9k9iad9uoZu3Su05POAqJMaumk28B0ub/Vr4RRpZWUaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fob8bwE8; arc=fail smtp.client-ip=52.103.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl/lHf3oj6nSmXGUsDDU5bILXO5h6+Z9q/g+Lc0vEnfvFhIrml3YEF8DZGbykq7Ix6qIjvEDuWeiCl2ZTYBrZHwBL03KNbenhf5H8vkCg3Uztb4ThyD9HCUngYV4gTd0QuvujttRZbNjqnY8utPYkcwQtrGzbpz1MuCQtZAxnG5n50H08MmM1WE6wtxyO/WnslaVYTiwdCfuHGyVlVm7aaiXk6Z3E/xiOfiMCOzJfhjXdq/3J6Zk6qBXOATfAuUfclHmhwjqszOooZS7/pi7qDJ4iTHhfwVBFKqvUNmZZqM2xzNOtyU+9kPO7kjhgVRpv5au6tGXD7kQrJXz8W4AQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT/uLmHHtZaIE90Bmf/rsbmam/lrLb72KVCnBDUu1aY=;
 b=MYKLHJbCV58eJiUlyQmQexQfBnp74hiyXeZ/7TFJeAaAvUx/3RhAxB77a0aZrVwKKQHWQjAshpTBHU9O6/KwI9AiiJlpbC0CG4EpkbKTVk149By/bMQdfY1xoFNDrzMIyk5d60q6SWSSnYG0Ro+zLR8QTPBmYQpI4kSgvXnlpi/8puyQ2P0gVbDbXuAlmCF+cyoeDs1dbBXu93Uw1Z6zUjTxpiTxfd7UspcOvyaFoA3S6HlnOKV0iprHdgI8TyDIEMGrBg2qEYdLmJ2TgEw7ToJ0vhA+PBCkD29Q0McZC7ckukAjRESyq6QgiHIc0Pr/Ak282Z7i6jDzoXyb5bzLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT/uLmHHtZaIE90Bmf/rsbmam/lrLb72KVCnBDUu1aY=;
 b=fob8bwE89QPHAAypPC3nZtAIVe6yp+/vDIKZUrwI85DovTKlRLGhkv9s/6JWQxAhXqgk45s0+B+oDKMC/U88vkhaeqe73oZ8zXazRwXcLHDcGBFEaBU+Be9543Pj5AbuvVtPzw1OW0hewDL9YNuPBQIRyV3qFVnNxQoB0eLLzOsIJFqAh4WnkU/5pun0Y7M7g1q1wor/T7HU7OvBSO8ikN6s6uwptk0dmJHwBk9M5oF4U95pqQsCK/WP+Dv0m4hbcZl5Aliqo4UqPglj4KvoOvwHM8q+0R7xnZinX58xG4/Wq7xjCykyaDD+i9ee08R5sxFuRPS13SeHjzZiOua7aQ==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by KL1PR02MB6682.apcprd02.prod.outlook.com (2603:1096:820:10b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Mon, 1 Sep
 2025 08:46:49 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:46:49 +0000
Message-ID:
 <TY1PPFCDFFFA68A8153B498CB93E0D6B3ADF307A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Mon, 1 Sep 2025 16:46:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: riscv: add Zilsd and Zclsd extension
 descriptions
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
 <20250826162939.1494021-2-pincheng.plct@isrc.iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250826162939.1494021-2-pincheng.plct@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <e7c0e227-b2d5-4585-b7b9-7b8a77cd8bcf@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|KL1PR02MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 39459f96-b5a0-40d8-c08d-08dde9341671
X-MS-Exchange-SLBlob-MailProps:
	ZILSnhm0P3lt+CQaDQ/GFiS22dDR1p20ds3kLBrwSYT9PafwGmoPIVvpv9+94H/vPOkaFMFh42zwYBHdpibLIUdxqtyYFCdN6C6YkY2cvP7M92DHi0jCSZvkCzGhtY/2URQeXeMa75RLX9tCPX7zLjvKmX6TvsFGnVbgewH/FDuVwTBdxRMO54gabYkagfKjNnJPz8+MT9R3saS6/oqGV14679ZxjoUn37iCwnuoymVBREo3F/XuckSRg1GZQm57t9BPLOSStU6QVcHe1QmKW4KIUtUXfBLjBer0tH4aXlB0C+gIpgvx7tep0VY+mWpT8OWqswHWTZD/fWfkPo4HV/ufmzn5+sjXDU0G241TAUT++7v+o/g9qm9cPsUVU+7TXMlutYuDdS4GhK3R+vFaC1KGwXNpajZeMftqw6gS7ubrMnFPoYbHzKDdqBKww8VFFucuI+bClO1TEWalCI1QckMhr5OqOCvNKIG4EuVM94IpxHjuh7Jf6wBip9Bua/x01DtygNMI/SHyogsaogWb+3274sS0yOx7igfEq0FPhAJGVJDudoU3AEVzodR11WGkFnoOiX8ud8xGB//KTT2wlDUkMQ3AaKoShB5jBz6DxGthf1B5JyQMXi/xawPC2eFJ9yDLMnJZgB/5Qw+YPQ7X3GWissNoRQFjGa1U2j4vQQwVjQRwsUfWCa85QowgG+yo86Fx+37EnH1/5IokW1s6ZjDgc2gUxP0AtA09xznloHxlH5y2tw+1amqv3Y53N60QpaLdDJqKxYUKCRiyTWRLH5bNRL0Ij+Kd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|6090799003|461199028|5072599009|8060799015|15080799012|36102599003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3hDYUNKL2hyR3lXSDMzOEdoalBBU2d5d1ZwWnNkL21GT2doY3pmdURyekxT?=
 =?utf-8?B?Zm92SWlwTDVFSDhNYkFIbFpVRXBCYU0zVXp1VlBzSDdxK3A3YmJQTTd0clJv?=
 =?utf-8?B?bEMyMnpRcTRQb1ZCVzlNNTNoUEZmMGpXVkpIdUlWSFl5UW5LaU93S3JxcUJT?=
 =?utf-8?B?QWc0L1pWZE1SQU45b0NpeDdLdHB4UUN0K2tLMFNwdVlHbFFGeENwUnpncXF4?=
 =?utf-8?B?K1JzbkE5MU5tUFEydzJ3VkJzQ0dEbm9SUGc5aHZiSFEwR2NRV0JGWlU5Vk05?=
 =?utf-8?B?L2p2NHM2SkJwY0V1M2VXditrMHJKV282akZPekMzQ0dlNDkwb1ZUTzZMYWo2?=
 =?utf-8?B?aEY5Y0Z2TVNpVjdoOHczSGtwSzhLcVdiZHRJeUw1M1B6V0J3eXVwYVFaN0lx?=
 =?utf-8?B?ejdxTEp1SHF6WElnRktITytjNkpXbjFYYnpOQWhEdkpyaVN0K1ZHQnlvTzJy?=
 =?utf-8?B?UmhwcTVUT05PTmNiU3lHeFZBU1c1WVlkQllJMldLLzdJOFMwR2ovb1NpaEFu?=
 =?utf-8?B?QWpXa09HZlVVT0N3amdWRFRENmQyVDdhZkxmV1djODBnTEFrTVpJWCtnMUpL?=
 =?utf-8?B?WUFhd0ZENVdBRlR0Y0JXR0cvYUZmL3ZNTmc3Mm40cUpNbU44dWtGdWdtMity?=
 =?utf-8?B?dTVnc282cFZlaWRramxKb2x0U2g4bmpWdEs0VGVDNmR4c1ZxN1pqd0VJT3RQ?=
 =?utf-8?B?d0dsWXczT3RMNE4rQU1FMHdZVE91UkRZU1lPRlFycmhNN0xLSi9vNVBwMzB3?=
 =?utf-8?B?cUNIdXlnMjBZc3pBSTdxaERPZFh1b1o1Z01LeCtLNWd0VWc3SUJQeDdCMFNK?=
 =?utf-8?B?aXptY251b245NEVtSFNjTk1RbzdyUks5Mnl6Y24xT0ZraFd1a1JNM3FhbmhR?=
 =?utf-8?B?emkxSUEvVkJUbmNpYUcvdG5jbUo2STdwS2k5bmxWdkVEREtWby9FS0w5RGoz?=
 =?utf-8?B?NDY1R0hJVGFSU0pUK1ZPdkY4NlBMRXhZU1hYM2xNSGRVdjRxcGdCZE0wWlVq?=
 =?utf-8?B?WDhkM29HYkNiMzZYaXhJK3hsbzlqQVBPTXI3OVAxcmJOVVFUZW5aNStYbTZK?=
 =?utf-8?B?Q1dTSTZlYThsSzZHYm1CZndpT2huMll1NWRwdHBramFoMHE5NFVGRVgrL1ds?=
 =?utf-8?B?MGg2d3ZhcUpWUlJwb1JJUSs5WXhzVjU1Ty9aSFI5RFBZVnJ6RzFCbEYxdDZW?=
 =?utf-8?B?QmdaOGltKzFRdExMald1RXBQVy9Qd1crY2FpWnMrREk4cnp5bDBvZkxyR0Ru?=
 =?utf-8?B?anpuUWFUKzdjYnlQTGV5Lzh4U3dMaWdEUEhJbWhNVUdJUkFUN0d6WWQwa1Nh?=
 =?utf-8?B?cmJlSlNtaXJPSXhWaHZidmRJUHMwejVrWkhrSFlpdVVad1hrTkVRRytvTUVW?=
 =?utf-8?B?alQ4aW1taWZiS0loMnBVdFJIM3JWL0ROUXNvOVlBK0dSaVlka0wwdmVHcTRF?=
 =?utf-8?B?RjkxSUhCWmFmTlAyR2Z3a3lGVHJaemNnN3VWdkVOaG0rdTFNb20xQ2d1OEZp?=
 =?utf-8?B?K1ZTenU5UC94ZGpQeFh2bzYvOCtiWnFKMDZmY3lxcFZRRVJxdUdvWUJsMGRi?=
 =?utf-8?B?Vlh3NzZvUlU1Z0tZOEdwWG9CWFhJRk8zamVGSkNoYjZPbTNMWDUwZFdMeFNi?=
 =?utf-8?B?cVRINWxMK0owUmsxUkZNc0dFODhvVVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGNCVTR3aEYwZHRIbGtsd2xObXJkMWh5bmQ0QVZ6YWl2UkhEZU9EYWhSRFJv?=
 =?utf-8?B?M0NoNVhjVWhzL3ZhSzB4Y0k1UUNreDNKTC9VdTFDclpmeUlzWFBNM28wc0NV?=
 =?utf-8?B?dTRqOWRFOGxML2lFcTJTY2dqKzFQMS8wdE95R3R5aVJZMnA0V2d6UFF3SlUr?=
 =?utf-8?B?N250ZThNaHpmTGxQZEJDaHFSb0thK2JMNkh4azd4UzVEYTJLcEZPSFA4S3pS?=
 =?utf-8?B?bUIyZ09kcUNtb3N6bnJwd2M2MEg2bGFBQmN6WjJBd2dWdElGOFA1dGdWai9X?=
 =?utf-8?B?TEtCN2lmV3RDWW14UnNyQ0MxTzZ5QjJ5dmRQMzhUMmxVcEhldGJPa0o4emlP?=
 =?utf-8?B?bkQ4enU1SlQ5SUxrZkp5NEtZV1hVU3pLOG1WbGtrY1JSckpXcm1weXJyRzNt?=
 =?utf-8?B?OXhUVWVDWk5OeEN0blpKMGJaMmhPMkd6akpUQ1hKM2x5RmFzWkFKNUE4S1R0?=
 =?utf-8?B?KzV6WGdFRkFTRUlQZllGODhNa0k3WjlHL1V0TlJIOGhyYm4yQS9sNXZWNUdl?=
 =?utf-8?B?QUNTVTcyOWRqd0ttZlFvU2YrNEhOZ3V5bUdtNGpjNDlVMGxrV3lWVENMWDJZ?=
 =?utf-8?B?Vk91azhmRHZheElwUDRSRFBMRlVyRGtkVHM4VzJVZmNXMEowWVFDYUpka1Ra?=
 =?utf-8?B?czU4YkVwTkZXaG5ha2FhNE1RWEsxSE9sZWZ1bFg0NDlPN2RFSjZudHg4Nm9L?=
 =?utf-8?B?ZU5PbmZ2VzBYRkRHaEpZb1JYa1p6bWtyOHk3TkdYZThrVFV4SGt3TDlZR2Jh?=
 =?utf-8?B?Zy9xYXNTSlYwbnoyM280MHVaT2ptMGhlYW9GYkRtZldxcCt4UU9iTXREbVBi?=
 =?utf-8?B?UDJEQXc0MitMQUcxWHlkVmlSTlJ5K1NaRmhtSmVURlNOY1RuKzJNQndPQlN2?=
 =?utf-8?B?SnM5RVh0clVYT3gvNXZ2L2Nxc3BRK01rZWp1cy9RVTVPZjBaNEQ3UUtGUXhL?=
 =?utf-8?B?RTFmQU85L2VNWGNXdmFLZW9rclZHSkFwQlJiQS9VN2I5SGt2Ny9TQWFLOHZ4?=
 =?utf-8?B?QU1OdkJzN0xaKzdNd3JNb2JLTjlYajJIcDEvK1lWb2t2KzFVR1VLdTVaWXRQ?=
 =?utf-8?B?NEg4MUdFaDdmS0w3TEoxUzlxVDRuWlhYMVdZQmM3Qm5EMFlheWFCMzdTS0Fv?=
 =?utf-8?B?WE8vaGhLVWYzZ01sSk5OM0pGL09HY0hDcFpWcG9tZXpnWlozU29TQ1hNZGFw?=
 =?utf-8?B?L2NibHRqOSt5YXY4Z0Z6VVRGbjN5am13WDNzdmZyd2pLNmtkblRzeHV0Q01x?=
 =?utf-8?B?NWNTbEtEaHlkY0pWbEdjTGlBT1dmTGNIcTFVbk5xNGhERDFqMThXMThSU0ls?=
 =?utf-8?B?dFk3cUpDU3MxRG9NWS9vdVpnYVl6QUFlRFhGRTFqM0ljL1Y1a0xEMjNJTmdq?=
 =?utf-8?B?NDV6eWwzQnVQMWFzT1ZQMndaVnFneW91K1d4T1B4QXRIU3pXZzBHVG16WFNM?=
 =?utf-8?B?b0RSQUNwQXVVcTBiUnBIMXpSKzFtMWVYZXVrYytDODJUMVIwYTVqcVhQUkZw?=
 =?utf-8?B?YUtEdk04cjNmSFNqaDEwZzMzN1hrbVl1Wkd0alcvMkJVSTc3V1RWY2dtWDlT?=
 =?utf-8?B?TWoyNm1CZU9mcU1IT2U5UXlYRTEyM25Kd2Vxai9DaDd3REFibDJycStZejN0?=
 =?utf-8?Q?esbUx7C2/yNRcKr/cd4J1zsTx0wPtYLcLK00gpFc73qE=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 39459f96-b5a0-40d8-c08d-08dde9341671
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:46:48.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6682


On 8/27/2025 12:29 AM, Pincheng Wang wrote:
> Add descriptions for the Zilsd (Load/Store pair instructions) and
> Zclsd (Compressed Load/Store pair instructions) ISA extensions
> which were ratified in commit f88abf1 ("Integrating load/store
> pair for RV32 with the main manual") of the riscv-isa-manual.
>
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> ---
>   .../devicetree/bindings/riscv/extensions.yaml | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks.

