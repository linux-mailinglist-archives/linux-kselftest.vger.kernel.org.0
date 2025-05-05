Return-Path: <linux-kselftest+bounces-32337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C726AA918E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448253AF008
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F93E201032;
	Mon,  5 May 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c1N+M7j0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731E1B4139;
	Mon,  5 May 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443302; cv=fail; b=AhpR98BAHCXeXOMAYCF2ukgQUYLcxdE2EVxPEaq85W/k9CCQDrkdt7446ubhrbtz12t7Z4ILFDRLO5VA6tFI/j9kVpBMKPvdtLn+ZWmWQiXubhlwyJalCv7VsPZgBrY+GuFjbIv2nRi6n6uh6zyiOSM1HD9g6oqcfkFXtoFZI7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443302; c=relaxed/simple;
	bh=07xYT7KPADKYedh6uBAJF37NE8oaz7QIo73WQ/6lxv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LHg08lZsjX6v1f95j9qpeZrqRYS0o/80tbA2wsqT/PhVvSqhDIioVGuTjaz2LBqSPhxPcr6uE7EA3bYyT6BdLVlBDJaF2X35qwzjpX397lQoq5z20/tmZpLNAIZzugkJVi5SNj+TxxG/tFaI0O5h/9V7ow1cJwAPslNzR3WM6Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c1N+M7j0; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPyylmjwRU6e9p8JxDJgbKGdY6iJUWaoAVx1JlzqsG9zSVLwvR70vJtKHxuWSUCUR8CaoRRpfrxhIg6KCcIsj8NmTf8Dqok3IQ2a9KFAhYOgTuxSt84pAd98owgGgTVd7SpQDevwXPPsgvn/+opsjXhAjAJCy/xOV3AQjDF6K2ca1Y0s4+gGBFs38GSvDiVUQET6n7Kz6c+qy133KRAovjLpc7ZXoRQuO2Xz4Bc6B0VmHPV3XIvYmWVLW6tdIcCXmGcmrPz9SC0yQ6vfT41i6X9l0dfg69jI6bbl1zylilrpE3nxHtPwf/HP2zGUKx+ZBHcCrvDSTLKIfYW6ngyM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBk8W6PoKBOqdptd8eUmw/fuF6/cXXSYZtLnoa69mWI=;
 b=aPRZLuSQ2u8xUS2eacZZraFonDRN+Z0H2HmGYl6SsmZQvJuK7UAcqhSNNJ4Lp42snxckvSYSd1vJ9/UE/KBzqTuEfgkg/b6xFSBeSnS/ono2HexMfKJ66a5dkrUcBERtZdV6763QuiwGhbIDU3QAKo0Yz13S1H6gNi01KacFlvOYORRs0yOws09WAg59EnVUSNTcdEPbnDc90Lwawq7RJ4GF4xJ/30MfodmRyIYv0yMO7A/dd9BuQV/YuTHscWypLhCCWoEb32PNYVefFWMiSOXi5QfVqMJBKezxdJ0MlWbqiyeUqVmb85AYW5TSXVmuWdkAFOdrA5z2FnUB4ifoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBk8W6PoKBOqdptd8eUmw/fuF6/cXXSYZtLnoa69mWI=;
 b=c1N+M7j0FDTnhhfLKhLFBm2J9dKXaw2R8TnPvIZuY4pnAhseB0owjPCsXcsTBcj7Kqk0Z2EXvKsL8h0gUPJIp4qYIsRLH6YIMmUMjaC6f47HoNfDJqZe9Qq1+eNrl44CsXaodU88FYBxCEZAmBPtC1HsoQ1LPLxzUwD+Osq7QrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 5 May
 2025 11:08:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 11:08:15 +0000
Message-ID: <4ecda12a-aa29-43e5-8f3a-2d8b9bd2e852@amd.com>
Date: Mon, 5 May 2025 13:08:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dma-buf: Rename and expose debugfs symbols
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, skhan@linuxfoundation.org, song@kernel.org,
 alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch,
 corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-2-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250504224149.1033867-2-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f73f23-ed6c-435b-ab7b-08dd8bc521b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnFaMEw0R0tPcWtHV0ZINlZiejZzUklxRFR1Nm1PbmgvVzJZZ3hLekZEbEZj?=
 =?utf-8?B?WTJOQWZoT1lPNHZDcDZYNFBFTlpid01pR09velB5UWhFV2ZMNDFkYmZ5QS9V?=
 =?utf-8?B?UWJ3Q0loNEFyNk9kdmZVdm1ZOVk0SitNRXdlL2NpYjhOUXFxSGpHZ0s5OGR2?=
 =?utf-8?B?MUhFL2NzcVpiRHNmSzNhZGFSajYxb1pDSUF3UGp3Q2MxWkRMOWdERDRmQjdt?=
 =?utf-8?B?aVI4bXNoSUtNZUNLSnZzcXNJMWZxOU40SHcvTUZwL25PQk5pUm5sUCtWVkJM?=
 =?utf-8?B?TmY0b3lyekZsUU92WWV6bEpSZnRXZTBWd2E1MWNpQjlQazZrUmNId05ERERT?=
 =?utf-8?B?WC9OWXNsSGt1eTNvZTlDeDJXZElINVhnVUxwQzJuSVErcllLcUMxN2ROT1Ir?=
 =?utf-8?B?bVVSS0c0bUhXK2hrK0I3RExtYnowUi9GWWtJOWdOZFFJb1l3d0dJY1EvZzRt?=
 =?utf-8?B?WTNDcXJhQWlodlZiVzBCSzlrYS9EQVdKLzlScklUV1MxaEVMYU9LNEd4UHRB?=
 =?utf-8?B?T1VkeGNRTmdQaW5iUFBneW5MQ3dUdG52dmE5aHQyZ0puZzhBNi9ubk9YbmJO?=
 =?utf-8?B?STdYbHM2aWU0MkZxRUhKMnBIV3FCMXF6cWEycEk2eE1QTDhuYUFaNEJRVU5B?=
 =?utf-8?B?dVJJYVVXMkVCcFRvMTcvN0M0cGliejBOSXZrK3NTdmVQWUh3YU1RdWNDb2tn?=
 =?utf-8?B?T0FIUlZjRTFJdkhLTkVLM0NkUERvdjQxbWd0MmRpRXVkMEtqTlA3OUJTRVpz?=
 =?utf-8?B?cGZhVnd5Mmw3L01CMWs1NCtmbExnTC9HVjJiK0NFVy92UVZoU3J3V1dlVVAz?=
 =?utf-8?B?U0pWUE8xa2xVRkc2QUphV2ludXRKVDAxYTVaSEh1dm9KVFBhekdnSExDWnNs?=
 =?utf-8?B?UHVSOWpyRHorQ1RNQk1IZzJ0alcweFoxTmpqMzhGZlBIcTB1T0h0azVLb2k5?=
 =?utf-8?B?Qy9xa25kMXozdDhOSVB0bmZLRlF4eUtvcHhJei9RNitNUTZpeU9YYzEyVXhF?=
 =?utf-8?B?QTM0bDVXOE5hOEdFVDlyRVVpQ3RiQis5MGRrbkhVZzVnZ1BtRkxwVzNvSXpx?=
 =?utf-8?B?eVRDT3J4ajJuK2p1OUQ2Y2VuWDNUYWFVbVVRK21MOFdPeHZiTE1YQkFBMmh0?=
 =?utf-8?B?Tk1lckZZL0VaNEUvTnFpTzVoaFJrZHR3b2VLNkUvMmxkOEVLSERvMGREVTA5?=
 =?utf-8?B?ZllYRmk4Y09VNk1DYzI1ZkVoZStzLzFQMHZ4VHAzMnpaaVYrQkdnUkVVN2d2?=
 =?utf-8?B?RW5yRUNSNjFlUERPNU93cGZEcThsUFk1TjdaZllyczViMVRsS3hHVWEwRmRL?=
 =?utf-8?B?aGN3eDJmZ3RpWUFtWXc5d2J4RkhzK1M5ZVdEa1dqUE5DZTY5RVNURVROWmtz?=
 =?utf-8?B?K0xTKzZrZzZkVXZFaUZPSkxzNjYzN0g2UDAxUDkycVl3NU9MZVVUTFExbEh5?=
 =?utf-8?B?bXoxblU0R3hwWHR4QUtWS21WclNiVXcvOCt6bEdPMnpMZkxWZzMvU0RzY281?=
 =?utf-8?B?SU45Q2hOOUVoMWV3U0ZydWRpUCtLemNhUWcwSzRjamFqaEh6N2FneTRFMGND?=
 =?utf-8?B?YXN2NDhlMUFXKy9rL3pWU3hNaEFFWEprSFlyVG15N3dEVnVuVk9MNG1WbmJw?=
 =?utf-8?B?WXJOdUdBcWlwaXJ3YUI0OGVUSHBLOVBCMW5HRUs0L0tTMUFlK3h6UG1NSWsy?=
 =?utf-8?B?MlowdzFWZmVWeEtqblBDbktjRmVnbGpXZ0VuNXdiNW8yYmZlcjcvM09iNUtn?=
 =?utf-8?B?TGRnb0ZSbERNYWt6Zm8xVW9tUy9NVEIwVzZsSEZIckN0V3pNcG02c0prdUt2?=
 =?utf-8?B?RTZPZmkzd2FVSTVaTWFyV0ZWN1ZKMGFEdzBqU3BxYWtGWVFvMVZnTnVwMFM4?=
 =?utf-8?B?NjhSZUszMWRsRFNiWnpmb1J4WHV3SkkwWVIxUUZMczBFT2p6TTdaWVRHZEpK?=
 =?utf-8?Q?REpNtp4ta54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXdYRkZEU3krUzNJcFBIaExIVkpHS0NHeXlqczhkcEhVSVJsS1Q3OTJXWm9y?=
 =?utf-8?B?d3FMVjZuNFl3OE5FVXh4bE1GV0JDbEJmUVNjT2FZcTNIcEd5Z1lPQ2gwcFFi?=
 =?utf-8?B?WG82ZFkxNWtCOGhjQnNGaW5tRU9keU9KS2JhNkpWZlB2RVdOenU1MzBTTU9P?=
 =?utf-8?B?ZzBqMVV4b3BjODlmTzVBQk9ES2JEVkR1eFg5dWpiamhMNzBtQ3BCamdoMkdu?=
 =?utf-8?B?dDJPRFgxWVJGSHNGazZaVGpsNFlQR2wzYmhzWEZoQUJUcmxYSXcyRnJyMUVn?=
 =?utf-8?B?bFJOWHdOVG5JNUdyMUNSZW5jZlFqYktOTjk0Uk5FNDJCOEJQZ0daSXlWTENL?=
 =?utf-8?B?Q284azBBbDhZbWhjM1RrTFZqMG5WamJiVWU4WGtZY1ZlWVR5Uy83WXZSZXd3?=
 =?utf-8?B?dm8wVW5iQlNmakpRTFRzcnRVN3lKUENCNGlXZmQ4cFJVTkl5L1NhN1NWaTdm?=
 =?utf-8?B?aHQ3S1kyUWE5Mm9PeS9ySG9PS2Q0ejllOWIwRzB5RlI5Wm11b0swRHprdkhr?=
 =?utf-8?B?UXRDZ0FORkNVU1E5YjJBdm9NbTV2TWtXeFZJeFN3YmZiRWhjMS96U2VxRHU3?=
 =?utf-8?B?eXRGbFlvT0FqaTF2WUozZXc0M1o4a0hkYVFjd1QwYnN5Tm1JM1NMbHVrNk5W?=
 =?utf-8?B?UDh3ajFrZWJwU3Jnd3JLTFpUVzhGZXEvUnJ6enhuaHB3RmIvUVFHc1FicG9B?=
 =?utf-8?B?V21oRTZUY0NSRTdmbDI2WEZITE9PU05GU0xib05YclpITUxHM1l4QTd5aXcy?=
 =?utf-8?B?QWMwQVRhU3NBaWR5YVNmb0xhdExKbkczcTFDd2N6SjZsWG9iZ3FYci9kdktF?=
 =?utf-8?B?UHpQbWNhZkZHOFFKQkF2Q3NDOGR1cEo5M05yaDhBOEduWjd0cmpwVnU5b21i?=
 =?utf-8?B?c3BleElqZXhzbTR0eDZ1TkpydzIvckZGTFVGb0xlV0VZTzloaFhyUHJ5YnFh?=
 =?utf-8?B?LzMza3dlNDhYa200ZFhCM3NGb1N6Nkhsd1FFUjFmTkhzMTRva280cEdNajBZ?=
 =?utf-8?B?T1RabDBKbDFZVzV1M2h3L2tiVUZON2dNbk1UaGNTMVd6a3pJZWJNNFBMTC84?=
 =?utf-8?B?R2ZpSHgxN1FSMHM3WWN6UFpCMUpHS09tYTRKWU5UcXN1cXN6eXZlUk1wMVMz?=
 =?utf-8?B?NzRQb1Mvbzc1aHdqaDk3MSt1QmRsMkZEdGNodS9Jdmx4VnlLNkhnemVQcUM2?=
 =?utf-8?B?Z0JDUEJJRkdiaS9GOFEvaFhVTS9FVkl2aG9wR2ZkUjM4bXZDdjdKZGMrL3JZ?=
 =?utf-8?B?cnhQY0UzUlBFV0VPMkdxcDFPVWZCTFlWbkxkVlhpVGtpancwNUY4VXRkZVpT?=
 =?utf-8?B?bGJuMGdBYUZTeVBjempjZ3d4c2FoSE5HK1ZZdDNwZkVNZkdLREZsb05OQUxu?=
 =?utf-8?B?MHdRbXlKWkJDMHVqTDR0RHZpQmh6VkpUSk0vNmlFREVjUHZ1RXZoSnpidjc3?=
 =?utf-8?B?SGlZMDdVOExrbkpBS3ZTQUNKMEJWSlpTT0xnMmdDNTVtQ1hlbHlQaGU3R0I4?=
 =?utf-8?B?ZURJcUFRNG43Um1GZFR3bEdzS2Qvd1BFWEJ0a3RxOVFYZUVwbENmSVJ3TjdU?=
 =?utf-8?B?Um1jYTNMU0R3NE1ZYmt6VTkrSVpqcllLUzYzZisyVlNXMlpUWUJEVUdkNi80?=
 =?utf-8?B?K0ZBWmNpS3cxZWFjb3UydDVOQzFXS1lITnNTNzFHNDh2Yk5idWdIeVlIK2lT?=
 =?utf-8?B?RlhveGJZd2JGd0xsYk10UjVPcTh6cDVEdC9Rb054MjFQNE04R2paL2VQaGR4?=
 =?utf-8?B?MUVnN0dRMFg3bUY3aDMzTnJsTjdsa1p4RUQza1VwU0V1emJMRkd1VGdwZWpX?=
 =?utf-8?B?bEN3dXVxdnlRZTVzbkpwVk1pMDZtcTFZVTc0Wm9IbW9vNnVRWHRjd2ZXWFRz?=
 =?utf-8?B?Tm9HSzFSUUh2dHMvNVRwOHR2Q2lLOGJndnpNN3loaDZqSVBocHA1YzJUb2JW?=
 =?utf-8?B?cmw0NGpQdE80MDA5SmUrV2Uwa0JzVzhmZkFVMHM0a1lEZ05JZ2ZETzNvVUx3?=
 =?utf-8?B?WHU1MnJPMjkzN0JhMCtxV0JOUzZCKy9WWWJUTFBBK0JJMFFiTkdSZlJVUTV4?=
 =?utf-8?B?aTc5aWF2SEpSN2VsOExZQm81ZVo5L1FOZnVjQ1ErTGpDWk92cWgvNk5lZDdm?=
 =?utf-8?Q?wxLlwKr8r5sg3bo3yBKWSb8ea?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f73f23-ed6c-435b-ab7b-08dd8bc521b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 11:08:14.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy/FXkiDud55Z64ZXAyD/s37S6E+fTUxbI9XS7I4ii2nEVvWpCcqEacpMEvGa99o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

On 5/5/25 00:41, T.J. Mercier wrote:
> Expose the debugfs list and mutex so they are usable for the creation of
> a BPF iterator for dmabufs without the need for CONFIG_DEBUG_FS. Rename
> the symbols so it's clear debugfs is not required, and that the list
> contains dmabufs and not some other type.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2: Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian König
>  drivers/dma-buf/dma-buf.c | 40 +++++++++++++++------------------------
>  include/linux/dma-buf.h   |  6 ++++--
>  2 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 5baa83b85515..7260bdd77c75 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -35,35 +35,25 @@
>  
>  static inline int is_dma_buf_file(struct file *);
>  
> -#if IS_ENABLED(CONFIG_DEBUG_FS)
> -static DEFINE_MUTEX(debugfs_list_mutex);
> -static LIST_HEAD(debugfs_list);
> +DEFINE_MUTEX(dmabuf_list_mutex);
> +LIST_HEAD(dmabuf_list);
>  
> -static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
> +static void __dma_buf_list_add(struct dma_buf *dmabuf)
>  {
> -	mutex_lock(&debugfs_list_mutex);
> -	list_add(&dmabuf->list_node, &debugfs_list);
> -	mutex_unlock(&debugfs_list_mutex);
> +	mutex_lock(&dmabuf_list_mutex);
> +	list_add(&dmabuf->list_node, &dmabuf_list);
> +	mutex_unlock(&dmabuf_list_mutex);
>  }
>  
> -static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
> +static void __dma_buf_list_del(struct dma_buf *dmabuf)
>  {
>  	if (!dmabuf)
>  		return;
>  
> -	mutex_lock(&debugfs_list_mutex);
> +	mutex_lock(&dmabuf_list_mutex);
>  	list_del(&dmabuf->list_node);
> -	mutex_unlock(&debugfs_list_mutex);
> +	mutex_unlock(&dmabuf_list_mutex);
>  }
> -#else
> -static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
> -{
> -}
> -
> -static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
> -{
> -}
> -#endif
>  
>  static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> @@ -115,7 +105,7 @@ static int dma_buf_file_release(struct inode *inode, struct file *file)
>  	if (!is_dma_buf_file(file))
>  		return -EINVAL;
>  
> -	__dma_buf_debugfs_list_del(file->private_data);
> +	__dma_buf_list_del(file->private_data);
>  
>  	return 0;
>  }
> @@ -689,7 +679,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  	file->f_path.dentry->d_fsdata = dmabuf;
>  	dmabuf->file = file;
>  
> -	__dma_buf_debugfs_list_add(dmabuf);
> +	__dma_buf_list_add(dmabuf);
>  
>  	return dmabuf;
>  
> @@ -1630,7 +1620,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  	size_t size = 0;
>  	int ret;
>  
> -	ret = mutex_lock_interruptible(&debugfs_list_mutex);
> +	ret = mutex_lock_interruptible(&dmabuf_list_mutex);
>  
>  	if (ret)
>  		return ret;
> @@ -1639,7 +1629,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  	seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\t%-8s\tname\n",
>  		   "size", "flags", "mode", "count", "ino");
>  
> -	list_for_each_entry(buf_obj, &debugfs_list, list_node) {
> +	list_for_each_entry(buf_obj, &dmabuf_list, list_node) {
>  
>  		ret = dma_resv_lock_interruptible(buf_obj->resv, NULL);
>  		if (ret)
> @@ -1676,11 +1666,11 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  
>  	seq_printf(s, "\nTotal %d objects, %zu bytes\n", count, size);
>  
> -	mutex_unlock(&debugfs_list_mutex);
> +	mutex_unlock(&dmabuf_list_mutex);
>  	return 0;
>  
>  error_unlock:
> -	mutex_unlock(&debugfs_list_mutex);
> +	mutex_unlock(&dmabuf_list_mutex);
>  	return ret;
>  }
>  
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 36216d28d8bd..ebcd208272bf 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/scatterlist.h>
>  #include <linux/list.h>
> +#include <linux/mutex.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/fs.h>
>  #include <linux/dma-fence.h>
> @@ -370,10 +371,8 @@ struct dma_buf {
>  	 */
>  	struct module *owner;
>  
> -#if IS_ENABLED(CONFIG_DEBUG_FS)
>  	/** @list_node: node for dma_buf accounting and debugging. */
>  	struct list_head list_node;
> -#endif
>  
>  	/** @priv: exporter specific private data for this buffer object. */
>  	void *priv;
> @@ -556,6 +555,9 @@ struct dma_buf_export_info {
>  	struct dma_buf_export_info name = { .exp_name = KBUILD_MODNAME, \
>  					 .owner = THIS_MODULE }
>  
> +extern struct list_head dmabuf_list;
> +extern struct mutex dmabuf_list_mutex;
> +
>  /**
>   * get_dma_buf - convenience wrapper for get_file.
>   * @dmabuf:	[in]	pointer to dma_buf


