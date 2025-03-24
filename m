Return-Path: <linux-kselftest+bounces-29691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AD4A6E1CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A76F7A8393
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668C263F49;
	Mon, 24 Mar 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KrtQrW1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18232157A46;
	Mon, 24 Mar 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838845; cv=fail; b=UF07syGAKWaFB1JT2MMDfMsA0nNKpI0nI1PAdBCsN9I9/2v9aUFiXCmeoYWv98aYZIl9F9PRlaZ0y8G5HF/lZa1KCY8LckcROQFZnjk5EjcKixH7fGI+I+LVtHourN/gEcn3U5nLV+Rh/DyTUQHagQo1oYsG99IHjxo+oVkPWjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838845; c=relaxed/simple;
	bh=xPRlwqp3HWj+qghn3OvQ6mHkaMPxn4UvoqvkaCfEjmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdBJEta8WWoGyQQQl8UUIS9S7loQdEevfPnBNOGVdUaoCFswLYzZjSs7qrcdcpTW4yLkGb2jNctE2FLL164Lpt4EpyTOCW+4WdglyIBYK3Jh2cEvPjNWKRaoWzY+9mewT4RQvR6pXnUkUvq34KS1isu7T8/v7eTeN/52IKn4aKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KrtQrW1u; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYAoTXVX7/nthcg0L/bar3hxqJA44DS2gY9x2QaOiQwjLc72ZcBVbUVXw0GSP7sprEV++S0PadK2mAL35MxObWkAlo0dLXr3TZRhkg1hYZDZcfi8IyIYuSuJjILJn/0OTssLDvallIPf9Y5OHKejL0osPkQ2TKvWAYnlrFw5W1X4Sefydcjx0GCtbXKdsbGh4PllXQCQeM0b8eCyK7l5brpknfHxg1O4V9GfEMmlDBlNp4xPsBpQHfRDUOPBDxYoetCmgyVddeBJly7LAAiIMx2IBVi/tIlamX7QngaDj6DqTlrpvbsG74eIaBLjepLrWdBCnNOb/SJg/8p6Y14W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxO5Gtrb2DFpZOqVi6nEW3JnkiOGlc0GqG0rIddEmFc=;
 b=ymt3u//WywkgkzrrGV1qfFXQzxnK1bI/OwmLccfEAOQbi0C8S3Gr5hcvo3MdWKlKWcdvUbBOli4QMGtnjVxJkqClFEuBu8D5I8Uk0JCg0BPq3KAz9MdFE1atnOPUIg0uQLAyThFa9wtu80mGSB7g/MYIgn9PmqRId6wocT6H0lRz9nAIIdKGyp5vNry5N5oLeLXk/BR0pJBivm/KbYbndU5RlQRy/MaAsUu1AhCKEKEyn4Rtf8dGLEPjtziZ53D9RENTcnaVPp9ike72nZLEa+fTKQrc67VecysXtPGZm1Xyhg3A8cAp4FH4jqsmz0JXGu8IJUi6GfefHdKVTYF36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxO5Gtrb2DFpZOqVi6nEW3JnkiOGlc0GqG0rIddEmFc=;
 b=KrtQrW1ujaKKVTvYiMApgmfeSvVKmpN9vKvw1NDAJQoSpvN9FmmKlkCxhxqr7uiz9QN+/i8fxfjI1eCAPTfNG/2HYV2eaDkgS32BtgeKh76ZlZr2dotkwDfmMglLY52TZ9CgU7tCGvNupEbAvePYSNafavvXWiaKwQHVV0y1JGyrY/wH5vMr3AqmKJ9nt3EnPcUzpK2m4dcKw6Iot9S1QL8x/P6USygPm8pthJLdh5KoJOnka+rM5gfZxPGpgbwww6/GdUnu41JrY/X/B3KK567qhVfsaP2nNliGJtzKz2cXMsaW/H1arcWnnqsPE0xbdnlkDqjrhP5H/Ikg5s4lHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:54:00 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:54:00 +0000
Message-ID: <f2e6f293-9f93-4d07-9ba8-9f1891c68162@nvidia.com>
Date: Mon, 24 Mar 2025 19:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: rss_input_xfrm: Check test
 prerequisites before running
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Nimrod Oren <noren@nvidia.com>
References: <20250317123149.364565-1-gal@nvidia.com>
 <20250324101903.05e5ceeb@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250324101903.05e5ceeb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 905c9d2b-6435-4777-2d4b-08dd6afcdb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWkzMnluZEt0dUVFazY0aWpsK0tiTWlLMC9vZVcvdkp5bHdiRWt4RTliRFpS?=
 =?utf-8?B?cDlXMlB4Mlltb1h4aHJnOVVOekpUWWZkem5KMW9TTUg1NlMvNDd6V2FKNUt6?=
 =?utf-8?B?MXA3Mk8xck5wK1pLYjc3WENuMzRQSC9LYU9uNkptdzJ2VmR6UzNWRjdub25U?=
 =?utf-8?B?VFFReEJkSnA5ZGt5NFJnRXZNRlZWdGdteENUSTNDclhpM1ZSNUVvUDM5djh4?=
 =?utf-8?B?WFFOdzVGcTAyUEk4OS9ERmJKN2dJN0tsVEVBNFlGSmlUaEhoVTZjc0NadjFi?=
 =?utf-8?B?dUxDL2gva1g1TGlGVXVPRXFCb0RIbnB3TlBZTkcvdEk2QTVOUEJvaVlOdXNj?=
 =?utf-8?B?ZWI0NWUrOEswd0plbldIKzN6K3lOWUdLdWVaOTZkVkQzSk5BQmZTRUN0TkZ3?=
 =?utf-8?B?OHNtUzNnVFNRQW9jWUFJeE5SVStMMFVCT0RyVVozTTNOdnZ1bGdHWDhoNmdJ?=
 =?utf-8?B?SlNKSlNaVFRhd2hUc3M4dTBsU2ZhbXA4aFoxeEZONlN1eTZqdlFxK3pXUHl6?=
 =?utf-8?B?M1pWNU9BSURSdkhNb01xMHRFR1VLN2hXdVpBbGNTWWNVMlBLVHR4emRCM3hO?=
 =?utf-8?B?VS81d1R4N05CMk5EWjFRSGgvYTZEOFFKd0FuRk9sT3UyRzhad1dodW9yMGNW?=
 =?utf-8?B?bW9zcHViNmdGdVBhaTFLZzk5REl1RDBqYzNDR09OOWxVUDVVRnpXSGlIT0Vh?=
 =?utf-8?B?T0t4VU1NM3RwendxODZqUHM2M3RQS2gwR2tFYkNiLzI1S1ZDLy9zWnRjb0dZ?=
 =?utf-8?B?VGZZdHhTS0k2ZUxMSmdHTGk4d00zRnhnMGpPa1FnRGF1eWNKZ2lMNkNRcUtj?=
 =?utf-8?B?Y3BIWU4zWGkvRndpL3duZTgzeG9iY25qTFpRdDZxS0pva0lFTGtxZi9ETm0v?=
 =?utf-8?B?ZHV5RzRaUVRVYStESmNxUHJLSm9IZzNqNVhHL3lSSE5vWTZpaFplVnZKaXlZ?=
 =?utf-8?B?VU5wRlBZYjR1RkFjSFhrSEJSc2FiQkVnV0JCaGQ5SGY5WGIveHRra2oxeFhV?=
 =?utf-8?B?cTA4SEFhTXQ1S1p6NGk2OVVIdmlkRC9KL2xpMzJNZWo5cFFZbTA5ZU91dWdY?=
 =?utf-8?B?NDYwNExDRThpM0UyY1NSYXFMWk15cXZPcWJzQTUxMUsycEpYK3FMMzFuN1FE?=
 =?utf-8?B?ZkswMFhraGNZOHRCZjNMdW0yYUx3aDBlR2cyWGRnZ2JPaU1aWkFXbmljMWhk?=
 =?utf-8?B?dVpvOFh3c1pnZ3hINjYvU2hXSm1uYnhKbDZuVE9nWW9GeTM0NzloU0p1elQ3?=
 =?utf-8?B?YU5yMG5FU2xZaEZOY0JTVTl2NUZiZUdYTHUzWDVpV3FnQnNxUER2dEUyVmpv?=
 =?utf-8?B?dWFVOEFzYkVEZW1qMHptMzg3RmIzYmc0cWJKYkxUWVM5MXZlUW4vczc5UGdr?=
 =?utf-8?B?WEdCMk5HaVoxNlNxaTJyd2RHbmdYU0tjZ0wwenlhaVpyMnJFNGNpT2FSU21s?=
 =?utf-8?B?Z1ZXNzBmTml6UytNYkhkOHRKSDZmaXFjWnc3TVBqQ2xoNjJlSWs2aE0vUjht?=
 =?utf-8?B?R0JqSlAwNGxQdVUrWEFMVkgvWGdUVm5HVU03OWZrUjM4T2VPbmhXZ1VOTEVl?=
 =?utf-8?B?dUJvT1VzZnVhb3UzOVdySnJ2U2IwMlRtcTVqdDJ1bFQ1VmViVXNCUlBxckZk?=
 =?utf-8?B?YXB1YWFZYWNkVy8wZVdTREhkZ0hEU21CVnlXRzdCMnhDOC9pRHJkUGw3MkpI?=
 =?utf-8?B?MEVEbjdrM0RaS0hCOWs0QzBHVGVJUlh2RTlXNXZLNnQvVUdxRWxEdnpMa0l3?=
 =?utf-8?B?VEZydFlFYWlWMmlVMkZDNytiRkRHK1RNU3lnYXErTTZlYjVMR242K1BtS1RL?=
 =?utf-8?B?WGJiK2JoRGpKM0R1RjFsZ1FaQTg4OGo4eHA3K01Va1d3cCsxV3Z0Z1Uwd1hi?=
 =?utf-8?Q?p9GEMHaSuh7TM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnV1bVp5R3RDa0ZTTGYvTEk0S3VLblNVRHkwekZBZW5PZGRQcGdOZmR1aStH?=
 =?utf-8?B?ZFFxbzdQMXVLWVVURkhDczFBQkZuZkRnQVpBdUpUK1Z0OHA2NndUQXd1N0Rr?=
 =?utf-8?B?My9wZDFPcGd3RWR5MzNQaUxHbVp5dlo4c3JQdEpjbW9IMWpFU1dyZ1RBa1FO?=
 =?utf-8?B?TzFlV2NSWVpHbUFKcVVkZkEwQ3FheExlKzRpUkZtejgzcHBuMEN0a0xoTWFO?=
 =?utf-8?B?b2VQVXYzTUZnQUcyamZNeDF3Q29JNkpNeUlSbWlvWVVwZEZHczQxUWFxWEVl?=
 =?utf-8?B?dXJ2STVkMFArakdhVVRtaEFEOGJCMDlFTlo5Y1RRZjFsS0ZlVjl2Y0pLM1lw?=
 =?utf-8?B?TEtKOWIyL1crNmEvcThTOERFSlg5QzhvQnlCOTVqTVJqSjFGYnJtUDBOMVFX?=
 =?utf-8?B?dEtDOFRjYmROeTVOTjhDVVgvYWt3M0xYQVkwdVpnam9PaUVTNmt3bENRbGVh?=
 =?utf-8?B?T3dXZlZ3TDAxMFBva2VuQVUxN0JhNnVQdFlpaGdNSVljNXA1YUZuM1RiWnpU?=
 =?utf-8?B?RWI1VWR3enhNVGxRcVpxZEhSMmYrb2V3WlBQbGYvOGpwVXhMbG9XVS9paTNx?=
 =?utf-8?B?cW9wSzd3SmZlenhqTnIrWFAxeEFidnN5V3E4N1JpMnZXRUlFenJkazZwaWM2?=
 =?utf-8?B?M09xSlU4QjMzdDRNK3JOQWZ0a3NSaEgreVFSOXNGZmxRalJHQ2ZUN29IekVs?=
 =?utf-8?B?bHUzNE1RZ3F4dU9BKzl6eWk0OTlFbkZBM0JBM2JKdEYvVVVLRjA0cEdwRWZD?=
 =?utf-8?B?WndqbHk4cko5NXY2Qkp0UmF1QkRsNWhKSGFBTzkxRG5NTTIvdkNsOU1xNFdZ?=
 =?utf-8?B?MjJ3cmdoUVhFM2dGdXQ2RXZFZnlsaXdFNVRINTRyQ0VkbXhhM055VnpuR29S?=
 =?utf-8?B?d2xNbFV6MmMwN2FlQ2VFQm5CMHFONlQ3VzVxV0s2Nm4waGphTk8rY2pScXFx?=
 =?utf-8?B?Uy9nL3JKMkN0Tkk4V3JYa1E1NzY3VGQ1Vm53NzF0cGtDWjNzVG9TSU1jMzF3?=
 =?utf-8?B?U01UUmpQeXYzV3NML2phcHZiRDgrUjlzU3k2SC9nR296aE9zdlRiM2FHVy9l?=
 =?utf-8?B?OWtxOVN1ZFBkY21EWUpXUjV1UWJjd292ajNHMGtWekd5dDJxNlI2WExIcXlY?=
 =?utf-8?B?TDl3NVM5RnVpU3RBWkVOQjVCTFBabE1HYVZRekdEMW9LTitHZTBmVVhxajht?=
 =?utf-8?B?ZkUraVArUHkva0ZrR29YSXptYTNZVkQrQmZpbHZ3MisrLzFnRHM2cmZXUENZ?=
 =?utf-8?B?d2txNXNKVTRPdkVMVTVCZ2x1NmZaZ2hBTEN3MFZha2FaMEJPbWZkem8veHNl?=
 =?utf-8?B?VVIveGgwQUFhRzFNeUk2S2lQNklBaksxckRWeFYrcmRKRit1NG1jREkxTzFw?=
 =?utf-8?B?bk9oZVp6VzROaVQwTHBrTW1SUGtzSGd5TW1ocHpFc2UrU1p5bWp1cTcvRy91?=
 =?utf-8?B?WFYwRzFORDBpb1hobFVSMTY5RzVaUVVwOTRGbHgwbEEyNDEzUkhjQVNJZUxT?=
 =?utf-8?B?UVpJRXd6RFRVMXVsQ043NStxdWtPZTNpZDdDczYwMVZzQjJQZG1malZFTG9F?=
 =?utf-8?B?V2p1K3AxUUE3QnVISndpMU5TRStrQkxjQ0o5dVgrV0ljTWpoZWNENmM1cHQv?=
 =?utf-8?B?STVQUjVqZE5zUDNSKy9kS3VqMlBoa3dqL25oT2NEOFBkNG5HaThzR1lPMUdX?=
 =?utf-8?B?V2ZlRGk1S1pZWlE1K3VvUktiVU5jVXR2SjZXZzltc01mUnpRSEt0SU1NalEr?=
 =?utf-8?B?S2t6MDFFdEdEZDlsM3pEUGJrWlg2eU1ROTlZTlhlblJ4elk0dWdsRVVrMjFK?=
 =?utf-8?B?NEFYRThlRWJ3TFNKSGZaTnErQld3TWJSM01VOFYzcmJhTFdRc1NnRWJ2Qk4w?=
 =?utf-8?B?MEVTT0lZbTV0NTh2em9ndXREajM4YWxKQy84eHZCYjdVRGpITU9WUjFWRzNa?=
 =?utf-8?B?TFVsTkloMWJGMlQ5b1hWbnp4RDJMSUpUT1pIdDBUdS9nalpvM2NOcjViOFI1?=
 =?utf-8?B?WVhoRUo5VTBLakRVK0JXc0hYNndtaVNLbm5OaFF1MjNzT1Rhem8yaHF6RU1O?=
 =?utf-8?B?SmRmV0FtT1lHV040ODY0Ymowdmpxc3VwTitGQ1FTNWZuaDdSbXo2a1lXelRV?=
 =?utf-8?Q?VI8WZ1DOOlwLniG+UbeSJx2o0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905c9d2b-6435-4777-2d4b-08dd6afcdb28
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:54:00.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RwXx1l0F9nwZmrlOpmek+I4Coc4uzCBWV4B1UDIWuBh+Zsp1MIoP9JrvGMcrwFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

On 24/03/2025 19:19, Jakub Kicinski wrote:
> On Mon, 17 Mar 2025 14:31:49 +0200 Gal Pressman wrote:
>> +    try:
>> +        cmd("hash socat", host=cfg.remote)
>> +    except CmdExitFailure:
>> +        raise KsftSkipEx("socat not installed on remote")
> 
> I'm not familiar with "hash", would using
> 
> 	cfg.require_cmd("socat", remote=True)
> 
> work? IOW we do have a helper for this sort of checking.

Nice, I should've seen this helper, will change, thanks.

