Return-Path: <linux-kselftest+bounces-40676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A7B412C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 05:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA00487160
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BD2C17A1;
	Wed,  3 Sep 2025 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="X9Uz/Wwv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012015.outbound.protection.outlook.com [52.101.126.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAB258CE9;
	Wed,  3 Sep 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868795; cv=fail; b=TfhLc5CLTyUEvC5gbi6pSU0IoeTq0flY+sWyiyn+HxtrnfcWUaeGp5etZXL4CExe+C2JQWPnFWiu6Mbk2XzVWgvpZDDxURkQj0zQAmaj5njhsrbRsk12uDhGrK104j1noWB1dvddapz5K6/u9l/O+WARW+qiBP+x16DqrdHsY/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868795; c=relaxed/simple;
	bh=jt61xHParKhqd6SdyRGjBJhL1cOOwVEAYarFniKheps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V+FidBpc+epzs9kYMcppnW2UIPSxHMHTOcXjxDQ/uZmMz/CQhl5d5QKzdhE6gLr4a8fxrbH/s1qMkRwhwkyptyYbtCi2S6y9nhHASM4+5joutLHmK2W8qU3RxBPPr+cq1UyDdYyvQHuZetFwRnJZ4+TKNFEkcoudE84QZMV/MpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=X9Uz/Wwv; arc=fail smtp.client-ip=52.101.126.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryLLwiGzwTJAfpt14tQ7PVR2dP9L+dIEZgbki0byFaRCpzIcb+yCV0WA9xea69Sx6WF8jB6tvT6bpNaAyP9a+eP0FkmJgUizcogydmybuZwMSq9EdVo889vRso6ddZxGdZF3h6OYY8g3MHAAQvc66RM2f0Q2FAHdc/vHb1TJBRID66eUbbF8oJyS4Z13diJ1l7vaAViZQyP16Htv/j9/4Mjfvp1QWhqVfDe5R8TANd9OT22hUfyEBoRyjPykAEC1KEmLDeWYGWvxPzb6CEVDi9nHMEteKgihR8jqvZE1UerIq0wAr5JvZMztBOz75bBxa6VhAFAaYkjAInH6VhtD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM7IfD/Q5OEc4OT8fEvqqvEMhejfGMmuMRdSZG6u4jM=;
 b=sAut/1zm99KUYGOwx/FdtEFpPfp7dEwWTP7cZpK+nxK7byntGf8AzJxWd+bFHmx5wENAxD4QBsL29JfqlhXGoKk+5nPSuWz22i/isqGvlAF8cZMurGN6WJA4fQ06xTIrRluImyp//gQk8YNvbHOlg2xyQiU6UUbrmjSnufPrp+lo7wst1PEkl7rq0P7ERBNo8doN8FBfOPEgmgAOBWDzy5oqIPY4oH8C+C1sSyjrnzZlRRWilyJfsd12qfbL15NVsvwtiEtT474xf96DKa3o+yRn4o+hHzCEtI8hAAXxxV7gA4V1o7fx1NuXw79zVySbmsVeRDkYcp4FZwI78lbXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM7IfD/Q5OEc4OT8fEvqqvEMhejfGMmuMRdSZG6u4jM=;
 b=X9Uz/WwvjbL1GUJIK1+6pT2TI8QDhksymuO5nq9kdsP3MngWx/Q/x2BdBla90IrLd3yzoOV/6HIquO/h/tFBFBQX0T0iKw6wXyuDcz5gbkEuboPljGtbYOZ6DcvVni+8JuGibfLTimoxQW8HTUfWTKq1iNsb1lcZMAhVhv728DqjrgTMnAVwnxhKCIshM85fKSHv8mZM+OTMJ9o1nah6xOadEzNR2P9wTXX4bN0w5pHbrtQOuYUg8EwxPYAgWQ5Gu00DyK/SE4V+InQT2FTQ6oIoxIzTx4yrPkx64kWviMKb5y3QVuQDhO1W2hKt5TZz+IlNklEuiV1l4CqUTUYVgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by SEZPR06MB6057.apcprd06.prod.outlook.com (2603:1096:101:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 03:06:27 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::6273:8ab0:465a:4a69]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::6273:8ab0:465a:4a69%4]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 03:06:27 +0000
Message-ID: <8cdfe5bf-96a5-4aec-ad38-8136bf0f811d@vivo.com>
Date: Wed, 3 Sep 2025 11:06:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for
 cpuidle_gov_ext
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Song Liu <song@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Linux Power Management <linux-pm@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, zhaofuyu@vivo.com
References: <20250901135609.76590-1-yikai.lin@vivo.com>
 <20250901135609.76590-3-yikai.lin@vivo.com>
 <CAADnVQ+iazLpRWtt219MqGD0LHVoccahG=Cf1w+Ow5xOjRd_Lg@mail.gmail.com>
From: "yikai.lin" <yikai.lin@vivo.com>
In-Reply-To: <CAADnVQ+iazLpRWtt219MqGD0LHVoccahG=Cf1w+Ow5xOjRd_Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0142.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::18) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|SEZPR06MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eea229-9e42-4f68-7f5a-08ddea96deed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amRtRzFzQW1wK2xnUTlWdlR1UVQ5QVBjS2pUQUdoNlZOQXJqRXF6dEhyc20v?=
 =?utf-8?B?QVNTNHEveWhPeFVySjVUcWlDZldZTURLTFN1eVpCUm1RSkJqUEdpR3p1UzBu?=
 =?utf-8?B?UlhPNG1BQ1dyRElvOUpNQ0lCSzJ6Vk5tQzhEZVVXdW5jek1iQmZvbVd5bGFD?=
 =?utf-8?B?eXNpWUFaSUdaOWRBQlNzOEJtcGFqMTBabkJ5UDlranRmOEhISTJHV1BCUzlD?=
 =?utf-8?B?bFhwWUIvdEFsZ3Y3eTJnWnZrNjlLcVpkdno0QTRrbkhHUkt2UFg2ZGtkVlFI?=
 =?utf-8?B?aHNuTVFaSWUxS3dYT0pHVHcyZHRTV0Z5OFRobGdxTlJ1eGtkdy9pS210bTF1?=
 =?utf-8?B?SjR3eGIwTEt6YnRXQ1c4WENiQ1NRZ2hzRU1FTTFDdGxXRC9NbVNCZFRzaS9H?=
 =?utf-8?B?ZGRCRjU1Z0RqTXY1OVdKcEtEdlVFNzRqdnFHbXZMekdhZHpRZ2RJZmtlK1Fn?=
 =?utf-8?B?WGpaRUNsUXNFOHYvYlR3OGUrelRkVy9TaFYwb09KYnV0KyszS3VvY3hPMTBp?=
 =?utf-8?B?WEtVZnJlaHczbzEwZEczb3VQamR4ZEc5OTJ4QTA4K0J5Z2lod0NCenJLNnBQ?=
 =?utf-8?B?eFAxUUNSbHZaS2k5UWgrY1NzOG5jQVV6MkxsYjArKy9KcmNHWGFFb1NjYnBn?=
 =?utf-8?B?bi9qWTd2THRranYyd0dvbVE2RlEyY0ovVW5YbUpRTkRtZjEwamRCc2tiTWhj?=
 =?utf-8?B?M0hpUlArZm55ZFNIL2s0aEpJcHloTnBXSTcxeGVXWit4dHRaN0t2WVVZUzM3?=
 =?utf-8?B?S2JqR2JFbzBHR2dydUprNnp5RlRldzRnL3pQT04veWk4bjk0RU5nTklrblZN?=
 =?utf-8?B?dk56UkxmakdCa1V4WFlNaVkwUWsyN2JUNmtmcGRtUVJsUDRsaThVQi9RTW90?=
 =?utf-8?B?OUtMd216RUVLblpQOXV5VjM1R3hHVGFUSHV1bTJOMGMyQlhkdlZSbDRvSDZE?=
 =?utf-8?B?d1kvT205TU5QZE5PcjU3VkYwNnhYeng2MmhHRG5ZeWVCWWQrNERnSFFOV1hv?=
 =?utf-8?B?WW03N0R2b05aZnlWUndPUnROclI1R3kzNG1YWkovT0o4NnhoZmw4azRFOGVh?=
 =?utf-8?B?WXdKdzhWNWhrSStGdVE4YmszOUVmREN4am5kSCsrTmxiNk5XeG9CYWNUNHBp?=
 =?utf-8?B?MHZ0L29nNXVyQ1lEQUFsdXQzRHhiTTM0MDFwWWtEV25aMnFpNUgvQVpIUmEz?=
 =?utf-8?B?Yko0N3VWU3pyQjY2WEoySkc5b2d2a1JrNmVQSXAveVJ6VUJEdHJTd0hMbHJ6?=
 =?utf-8?B?Y1RWQXFzNFhXaFA0eTQwT2RJQVF3M2ZTQW93ZjhRYTM2SzNvSzBPSU9ibGdh?=
 =?utf-8?B?WFdYR1k0bDZPZlpndmt1V0JtNFU4eURxbEIrRG02L2greUZCbTRUYWtmK0dI?=
 =?utf-8?B?VThXSUprVm5VeFRXWkhTRWowV0RUM2d5RTV3YTVpR1Jna1pGenlTdnJiZ0tG?=
 =?utf-8?B?R1JVM2ZpK0xGSWliUHBlenlKQjkwUDY1THBvVDJ5R3JkS1VNWkliVFlkSnlG?=
 =?utf-8?B?ejFmTFFmV2hLQTY1VjlBMzRGWWFOSG5qZkF1dkR5UEMxZjcvUk05czlPSVFJ?=
 =?utf-8?B?aE9aSXZLMGZoQW8zakFwMTdzNXFubXF3NmsxYURYckFUMVVKcW4zYnV4QURP?=
 =?utf-8?B?Yk12ZWE0U3FlWFgyV1ptQlRJT0ZmUFNpMVFISUZlYSt5ekttZ2V6dHVKd0JF?=
 =?utf-8?B?YlVCV0hBL0VnOUoxei83RHM2Zkl0VlpWSExJWHBiMkRKeFVGMWRCSitleVRB?=
 =?utf-8?B?TFJtK21lcGU3QnZ4WlhIWHJKemJ0NTFXcGNDSHVscWZlcTM5N2phN3JvT2dh?=
 =?utf-8?B?YUNDUi9Gb3p3SDgvWVQreTMrUjBSR01WUlNUVnE0OGt6N3FEcnNKQ1kvQVFF?=
 =?utf-8?B?bmJCa0FHTGtnR1JmeHp2bFBKVWs4elhJdVRmblBjYmlWOTlQcW9DMHRoUUpM?=
 =?utf-8?Q?IYgN3XL2OM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1dIZDE4aWErR1BuWllpTmIwWWVTZXk3Q1pNWkFxMnNOZjlMbVI5TVZuNkRR?=
 =?utf-8?B?bXoyRGxvQjlXQW05UGhKd2txMHIyQVNCVXF5MWRIM0ZzRU9xbnJDRDcrbEhE?=
 =?utf-8?B?ODFDYXE4OXg5aTZhWFgvZ0QyaU9uM0lPMGxSRThGTnVuSk5UcXc5M1RpQ3hi?=
 =?utf-8?B?SnN3MDk2SFFGQ2Y2bU1HcitPNVRUNUhIWnd6T3huREwySHovY2dldjBkV3Br?=
 =?utf-8?B?aERIM1pBMnlUZzFCckY0YjRPYU9Odkp1MEFiWVphMkhCZEtWR1pEWnR0L01O?=
 =?utf-8?B?a2MxclFHdFcvKzJHNTZyU1V2MjhGc2RyR0R3dHNVbUZ0OFlzMVhPU3FWZ2Jz?=
 =?utf-8?B?U1BiejRjRjk2dEtzWndZenFaTUFaV054UzVqMjNaTUo2VHIyV1U3NE9EajJI?=
 =?utf-8?B?akdFRHV0Tkx1Q2xLaGNKRDNkQ0ZGUEdBbVN6S1lPNjBLS2V6a1FKRVgwNmlH?=
 =?utf-8?B?cWVjWmUzM2tYeENRbVVqa2YwTTJ0elVXYjVpeS9uZHAvYjhmR1h5b2x0REE5?=
 =?utf-8?B?OFIvRUQ3cFJOWExiZEx0ZW5aUnc1Y0o2WHc1WjZWaHMxZzZDd3hsTnNFdVpu?=
 =?utf-8?B?a2xFWFpvTVZpbzdWRkxNa0dwMEpUdTlQRlNPR1dHcUpQZzVjdCtxejJXU1NS?=
 =?utf-8?B?bFVtZGhjaTVyQlRpT3RWbkdkUWpUL2ZwL1ZXOUtnTUg5MXdTUWMxa1UybnMx?=
 =?utf-8?B?UjVPR2F1U3RBRC9OSU5hTzMrV1RvZ1pWMVhxOGhFUG9yUkJzQ0F2WGlydkJu?=
 =?utf-8?B?VmFIdjdkSHM5V1E4UFp0R1ZiMFlqWS9IRHlBbkVEcVBuTXdzZDNPem8vSkJW?=
 =?utf-8?B?QURzaEZzK0FHRGorKzBjSHpZK2JVYXFxZ2gxN3lQUFJCQWRkY0JtQjk1ZEVo?=
 =?utf-8?B?NEFyOHltZEN4a2Z5QWZLbDZ4VXJMTkp4WFM3clZ6a0pWQUsxRHkrVTdOSE5W?=
 =?utf-8?B?WWVIUkFPRkJYNUg4ZjNLS1NtaVhsQWxEVllpRk1EVmx2SDhNaWR6OWlYZHR5?=
 =?utf-8?B?eExxRFlsNE8vYVhYNmFCMkJTZWQxb0NFcER1ckNRZ0JqQUR1bHMrVGo5V3RX?=
 =?utf-8?B?U0VLeDFlRzRwSGxTUTBNSkJkYkRKY3FjdUxHZUdWcnZSVVo3NEhBdjNUUjZV?=
 =?utf-8?B?RHhDUlMwbkh6d1JLc0hFQUdjcjdUZWEyN3BuWVEvSVBmNzdDNldKUzdMRFVL?=
 =?utf-8?B?MlVBbmdWajkxallWWlE5UXhoQUxLL25IbzkwT3l5clZxa2FQZzZiYjlkc0Vk?=
 =?utf-8?B?VWE1ZVBmVUMzMVQvT3Zsb25YZURxTHhsTmpwRjkraFFHemx2eDlDUGFsbXFJ?=
 =?utf-8?B?Y2lNTFBaUmJuN0ZUK2kxQy9sNDMzWTBhTm9IWVYybk9ia0RoSk80LzhSV1hm?=
 =?utf-8?B?c2Vqd3ZXUjJ2dzRNL2VWSytCVC8yVi9kTk5LRGJxLzZqb2dSTkpxaFVKaUt3?=
 =?utf-8?B?bkJyV1hMZ0YzUUs0QkFveFViYW9CUWhMc1N6dGh5eExZVHB5S2ZMRGpaTjNV?=
 =?utf-8?B?d0ZrVUl4dGdLZEFMRzEwZDhPMWp0MUFkMDc5dVhvVk9Gdm03NE0rRU5aMXdo?=
 =?utf-8?B?bENvQURWTmhEbWlvdzc0TEsxOW1xcHFpemo3RjZoQ0ZITWVwbWJFSmgrNGFv?=
 =?utf-8?B?MkF0V1Y2dzVFK3RvY3NFQ0RHL1VqbWl0bllmVGdVS25uSVlkb1VlU0pBc2Yy?=
 =?utf-8?B?Z2sySmdlUWpZRHR5MlVzME9CTGhtaUF1SWRpaWM4WEJWSll3N2dxYlhNWFkz?=
 =?utf-8?B?a3NlelNYbG9qOVRWM2hsQVF0aElWYm84L3BoUHpQdTFxVFRVMS9aM1ZMcThy?=
 =?utf-8?B?NlBETGYyZ3BMYXNnM2hSeUFyQnZ6QWxST015a1JhdGVTa0JQWXY1dFUrSmow?=
 =?utf-8?B?VWhHUU9wMCtOaE1xMzNCWHpabFB4THdib3hJMlBIbTM0UGxkV2JaV0xKdmZP?=
 =?utf-8?B?QUFKekdvYVFEWDl3U3BUMi9NTk1SK1EzWHlZWW15UXJuS1ZCTlJKaEdIWjhR?=
 =?utf-8?B?MlFzdkFQSXkwVFgxUmRBUTlNRExmTG9CZWE4cmdzNE9uU0VTcjE4OWxpeUMy?=
 =?utf-8?B?LzhKTlAxNzlTemIxZ0ZTbXYvb2N4ZnlFUG0rZGlZZ1ZvUkxNb3JiR1RJcHU0?=
 =?utf-8?Q?BgPxuWS8iwDxcsc9V2jYHXu6W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eea229-9e42-4f68-7f5a-08ddea96deed
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 03:06:26.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXC2sZC+FPHclTRVeO2uvsQyqHnqtKyfQJ0G9eUIOfxykKKhUAD0LeGHYcZcM8FYZYSpr/W3E0Vmw+Q4wYDtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6057



On 9/3/2025 8:38 AM, Alexei Starovoitov wrote:
> [Some people who received this message don't often get email from alexei.starovoitov@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, Sep 1, 2025 at 6:56 AM Lin Yikai <yikai.lin@vivo.com> wrote:
>>
>> +
>> +/*
>> + * For some low-power scenarios,
>> + * such as the screen off scenario of mobile devices
>> + * (which will be determined by the user-space BPF program),
>> + * we aim to choose a deeper state
>> + * At this point, we will somewhat disregard the impact on CPU performance.
>> + */
>> +int expect_deeper = 0;
> 
> ...
> 
>> +/* Select the next idle state */
>> +SEC("struct_ops.s/select")
>> +int BPF_PROG(bpf_cpuidle_select, struct cpuidle_driver *drv, struct cpuidle_device *dev)
>> +{
>> +       u32 key = 0;
>> +       s64 delta, latency_req, residency_ns;
>> +       int i;
>> +       unsigned long long disable;
>> +       struct cpuidle_gov_data *data;
>> +       struct cpuidle_state *cs;
>> +
>> +       data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
>> +       if (!data) {
>> +               bpf_printk("cpuidle_gov_ext: [%s] cpuidle_gov_data_map is NULL\n", __func__);
>> +               return 0;
>> +       }
>> +       latency_req = bpf_cpuidle_ext_gov_latency_req(dev->cpu);
>> +       delta = bpf_tick_nohz_get_sleep_length();
>> +
>> +       update_predict_duration(data, drv, dev);
>> +       for (i = ARRAY_SIZE(drv->states)-1; i > 0; i--) {
>> +               if (i >= drv->state_count)
>> +                       continue;
>> +               cs = &drv->states[i];
>> +               disable = dev->states_usage[i].disable;
>> +               if (disable)
>> +                       continue;
>> +               if (latency_req < cs->exit_latency_ns)
>> +                       continue;
>> +
>> +               if (delta < cs->target_residency_ns)
>> +                       continue;
>> +
>> +               if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < cs->target_residency_ns)
>> +                       continue;
>> +
>> +               break;
>> +       }
>> +       residency_ns = drv->states[i].target_residency_ns;
>> +       if (expect_deeper &&
>> +               i <= drv->state_count-2 &&
>> +               !dev->states_usage[i+1].disable &&
>> +               data->last_pred >= residency_ns &&
>> +               data->next_pred < residency_ns &&
>> +               data->next_pred / FIT_FACTOR * ALPHA_SCALE >= residency_ns &&
>> +               data->next_pred / FIT_FACTOR * ALPHA_SCALE >= data->last_duration &&
>> +               delta > residency_ns) {
>> +               i++;
>> +       }
>> +
>> +       return i;
>> +}
> 
> This function is the main programmability benefit that
> you're claiming, right?
> 
> And user space knob 'expect_deeper' is the key difference
> vs all existing governors ?
> 
> If so, I have to agree with Rafael. This doesn't look too compelling
> to bolt bpf struct-ops onto cpuidle.
> 
> There must be a way to introduce user togglable knobs in the current
> set of governors, no?
> 
> Other than that the patch set seems to be doing all the right things
> from bpf perspective. KF_SLEEPABLE is missing in kfuncs and
> the safety aspect needs to be thoroughly analyzed,
> but before doing in-depth review the examples need to have more substance.
> With real world benchmarks and results.
> The commit log is saying:
> "This implementation serves as a foundation, not a final solution"
> It's understood that it's work-in-progress, but we need to see
> more real usage before committing.

Thanks, Alexei, Song, and Rafael, for your valuable feedback.
﻿
So, I understand that the key requirement here is to demonstrate a real-world scenario example
that can be effectively used in production environments
and to provide benchmark results.
﻿
Next up, I'll focus on developing a real-world use case for mobile devices
and providing test results.
Thanks again for the helpful insights.



