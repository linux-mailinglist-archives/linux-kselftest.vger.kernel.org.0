Return-Path: <linux-kselftest+bounces-34637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F761AD4A40
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99321179940
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 05:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63717176FB0;
	Wed, 11 Jun 2025 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fj2p0n7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8E8F5B;
	Wed, 11 Jun 2025 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618441; cv=fail; b=c4fdX+NtGQ3qeY0VaK+jGEjHPHfA0m28BfOju5zWByTESPm5l8TuM3NfQjw+F3sbiE56KRZrml7SGpEzpDr+dCKJwuzALwca/6gwExD2Pe86A28pUehZvvTBNsWWFXIZd7ZofabTvk1Px5jIc50cNp3xV6Qk9ANAD/wQDDc8MSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618441; c=relaxed/simple;
	bh=9T3M7+CK7ZHObrcnCO7USgDWuOj6ytwRIE8nLp28ZoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWF0KxeiuE27zt7FqbL4lky0fvJUu+Xkd1hTOzCtmtHZdP5WHnrKtiEywxfFEwsCkfng6d2dRx5dYu1dIg5hd7tbl1knPyhRd3cobo8N0M2TPZRyRiqDtVc5FwL1CPxvg4FxjXrfLVNWpj7lGjX2PF8arHe0hePAKpLUdABln/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fj2p0n7e; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9L53lG9LE6boi8TYxkcNJ0tHms89GzPy46OelSjXT0rxs0JaDG3hOXcoJppZ5+u2/qD4k2Am0r1QDxotiDzdkUn8xB6SJqqHYCO5YfsF/0XACeBloksko4EAx1pY4lOigF/0LPI39k/I/imYTwgVR2Gd93MjYbVzxYeyGXOKsRbHpxFDmHoa4RxsWIBKpI3jH3HRBVqV2h9UgJcoAkOdxKzbEKwZnhVD8fm3uzoQGRe1gqumqsC7GpzAV2rKabfY+3W7SvStS7BYpgM65U96K2AovJ7IYrdq9Y4u9eF2qgZdDFjvv8uWH8TLTgVW8GZihhc/VLqPAaQC0UWMY/Nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=984plneWAClDuUd9oDu5UvHu6p6fhjs4wCjZ9qfYb+E=;
 b=MZrzKImR3DLPEMRBQnfn0Ird5cgT+3fLaGAibWuAjf+z0RvonNGdp24l7zhl2wswBCq777yB5Eg300A8+29a6yyl7Zly1+gWvFkSnuK1/fIfq2fsxTBwrNhDmChoGs7IKYlGPe9NiPo9KSaGI/2rWpnOA/KLWNNcJh400Sk7XjjB6k8Vev7BSvy7MT9hwA0Suxhx9rBCDGWiVHslTGEbF6o7f2aCxFwGWOtQEDftrDGjt91TDhc4eDoGbNCBgH0AYR/YVAFvPi7oYR2WGWhxVHPlKfyiCOEjJvOQ5qgMyHaxX5dexhGB7lodaC9lhN/rqB+i9jGIkXyhbHH4mAGjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=984plneWAClDuUd9oDu5UvHu6p6fhjs4wCjZ9qfYb+E=;
 b=Fj2p0n7eRUDUtCx9dAABWBx37ECj1+mjYsSncEZb3EZkgsw8jWRIxlV4F4PRpdbHnjpdopgQXBDhPcFlBb/s1j8K9KoHJNz41BM5PwIuTTkwE1zzcmfbtXs1IlEJwBJWrpYqXjr0+GQ5HHEGhf3j2GgGjIwFtj+tMABs5cwjz3AizNtuVEAP8X5yY2+EQH9GzJcwolGKF153jpkYPW32N3zn14nXOQhzp4wWxD2AXrjlkAmGCXW9u9BRTkU9vDlMwIT8Z1nJMb9w4FOIwt68gdzLe9TOUss7BPbyLIbAmUyLDLi7QJhcp97lVZ3IMCSP8tUgER/KBVvPy1dSEz9iSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 11 Jun
 2025 05:06:45 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 05:06:44 +0000
Message-ID: <1f1ecf24-9be1-4822-83f2-104420d39933@nvidia.com>
Date: Wed, 11 Jun 2025 08:06:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for
 ntuple rules targeting default RSS context
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
 linux-kselftest@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20250609120250.1630125-1-gal@nvidia.com>
 <20250609120250.1630125-3-gal@nvidia.com>
 <20250610143225.7dde37a9@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250610143225.7dde37a9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 909cdbb2-cbe5-4af8-93fb-08dda8a5c24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm13bllwdUhvRjJ1OWErY3d3cVNrZTBhakZmY0JHeCtoNklZMEtNc2ZOVlgv?=
 =?utf-8?B?VWMwTDAycWppaGs5T2tlWm9yTFpudFBXbVhNL0pMekV2Z2ZQRVBIVUxUSjZ3?=
 =?utf-8?B?dFljOFp2bW1RSGlYOWYxbEZRMUVpTWIvVXFHUWE4bWlBNWxjME5hRVJZenRm?=
 =?utf-8?B?TGJVL2xwZU9ZUjg3SDJYTXJScVhucjRkRHpHNmdrVkI3YzJQR1FnekJrWDNr?=
 =?utf-8?B?amZoNVZDYm1SbDdWa0tjNHBmVURHK1hRV1JGTXFVVFNxL3hUejN0Tm9DOWYv?=
 =?utf-8?B?YmRYYkxnRE1qcXJQdkhwR21iZ1dzdjA4eDY2RnI5aDA5ak9SUFA3Z2t1Tmx5?=
 =?utf-8?B?aUJwUmRZdm05UXZWclRGb01GTS9qTXgvWTQvZXMvVzBQOHI5a1FkaGJ4NFVO?=
 =?utf-8?B?VGFuem50R090Z1JXNmNoczJIS0pzYTBqcmZyK0Q0elJMMkROVk9XVGs0NUlP?=
 =?utf-8?B?a1BFTjZlMjBieEtMdVRNWUtOOHVnQ1hXU3FzUDRnQ1BUN1pIYVhkTy9iSXdJ?=
 =?utf-8?B?ZjRWdE5JUmFQUW9Xa3lVSjhXeEVJZ1NRWmNUekJrVC9tcUFWUDFoZXJpUEJr?=
 =?utf-8?B?VUZqYklva0cxR2hnVEZXUFc2eFljamgzOVMwcTRJOTh5ektEQkpHeldFREVF?=
 =?utf-8?B?WENPaUs0a0p1bi9teWN4MDdEYlllT3crb3dWSXlzb3d3RUQxb0MwMGNZUGwz?=
 =?utf-8?B?WEdkQ3g3VmM3QXB1VUlxd29EdnJkaWdhSVptOU1JVU1zTXRZVEpqcm56SjVv?=
 =?utf-8?B?V1JlRXZqaTFBT1g5TXc4YmJJWWN3VXFuNDI0VFFwcHA2WUp0bWhObk1FZVBZ?=
 =?utf-8?B?MGcwNDJGZU42eGN0S3U1b1ZlM3VtZXpvNmVOaktXWUNQRnRHeVhKcTRXdXFn?=
 =?utf-8?B?ZnUrQ05uRm14ZWxpRnRjVStzdS81NmRIYnpYN1dTZUMzNlVFTENXUXNCOEhn?=
 =?utf-8?B?WWM2Zko4SEZ0dldoME8xdlFsWEkzRHMvck01M1o1TjJ5MkN6VUQyUVpObmdo?=
 =?utf-8?B?OG4yNXZkbEk0WGdQdjRaUlJIWXFndUpzZzBtT1RGNTBDYjF2RitCOWM4QldX?=
 =?utf-8?B?WFVVQlJVbFVaSUdsMVYvZ0QxajRydGFMbmhtZnFEaWRNaXhRSlE1c3Iya1JK?=
 =?utf-8?B?b3E3YldIVEZucjlpa3dFdzU2V094dUNjRkIvVllvWkpTRTZrVkJhTXYvNEFu?=
 =?utf-8?B?UGZFNFBiVWZCa0N6NFZ5YkFyejNnZ2o2MTFjWkVlenBjYm96ejIySlZZT25D?=
 =?utf-8?B?dm9nUE41cVNnaEplYzBZK0tqcUFNVGhURGtqcXc5Z2l1K3UvbEhNWDNoNGNF?=
 =?utf-8?B?YTNBaWF0UU0wUmtRSUl2Njc5ZUlac3dGVjJLcURZNCt1REN5eG1NZkl5dzJv?=
 =?utf-8?B?MU5OQjg3YnVicVp6d1ZscTJib1dxWWh0eUkwRytPRFB4aFdick43NlFUdjdT?=
 =?utf-8?B?WTVFa0MwS2RZVHBLNWRRSlN4UVppVlRNY1VYL3NrYy9FTlFEamJ0bmRKVlpu?=
 =?utf-8?B?UGg3RGlSekZLWnlreDlkRTF3N0FaM0pENzY2QWJNYkdLZkxQOCtQZGZSU0RR?=
 =?utf-8?B?QWZ6M2hIN3VsYTZJMDdrK0tNMWJmQ2hhellwVGp0VUxRSS9VNmxFdiszbEJO?=
 =?utf-8?B?SnR5emhtU0g1RGF2TWlId2Y5R3lZd1F1RTZDdUhqMFUyYS9FRWlIZkw4amhB?=
 =?utf-8?B?K3ZsRTFXUGl6RExQU21PaklzeXZ6Z2pLNzlqekYxNnJLajBENEwzNld5aDNp?=
 =?utf-8?B?UUpOSkRpTE1XSW5PV3dla2NFNVZudmtJdFBtZWo0TVNQMHI4NlhRbVlydmlK?=
 =?utf-8?B?RmpjS1NoWDlEV1NWVDA2anZodUxzTDZkdGdGdjVFbTdrUlQ0cFNrNWtzcVlV?=
 =?utf-8?B?NzlmOVArUmZvbjZpR2xRZlZ1cnJLTHpwK3A1UDRzNDJ2SGNRRlZLRUxpa2Y3?=
 =?utf-8?Q?+cF8A6J/pBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJEblpEMmk5SnkvOUpneExaNmhQaFNCZG9JeXRvZU9PdjVRSUk0SDRnWFVX?=
 =?utf-8?B?aXo1UDlZQXZJaDFWbWYzNk9TWit0UGxYSEU0UDFTQ2lvellTY3N2U2haZjRt?=
 =?utf-8?B?RzUrREMxd1hQeDJZazdjMlRTdW42d0FlTFQ0eG42ekJRZ2MzWi9WMGZzSW1u?=
 =?utf-8?B?N1B3a0xtNGVxVjFVLzhOdUZRUHdUQ29VS3lveUdDVDh1Q0QrNmRwUnNPcGJq?=
 =?utf-8?B?S2p2SUJwdVpPWkk2WlRHbU16WnIyM29hdEMyOGdXNjlkUmtLMnJXWWNZaFNQ?=
 =?utf-8?B?QjY2QWNvTENXNnR3R2s4ZWdpYm8zTmJ5V3F5ZlNMWmEyOG5QYTlVdEJKMUpO?=
 =?utf-8?B?dlM3QmJWMlpwbGNidEdCNHBiUWVmcDVoQVFjVHBSOXdSQVU3a0ZlZWEwWm5w?=
 =?utf-8?B?NGlwRnFOOGtaUEJFQ0ljZmdtd2pBcWt4Sjc2aTZXR2V3Q0RwcjlZbGU5WnB5?=
 =?utf-8?B?cjhmOEd1T05vT0czZ1dZSG1YSW4zOTJKWldHTUhmKzFaQzBydEVpeHpIK1Er?=
 =?utf-8?B?R1hwWEt1c0VKWlRCS2V5dzdyU0N0ZExKSGdHU0d4ZFpxOVE2ckV4M0t4UUNH?=
 =?utf-8?B?VlBzVzVwK0NLTXRJcUs3MEJsN2ppa0lGcVFyK0NZT0NJZ0lQcGwvcGRBbWk4?=
 =?utf-8?B?a2tRTHB1MTVtNis4a2I3R3RwUll2RFlCQ2Y2ZnAzNlNqTmt0cFVrV3dFUzkx?=
 =?utf-8?B?dUU1MU1rdWcrQ0grZTc4Y2l5Q1BMMmVQakhUeVljazlqaWdPTEtML2pOZ0Zi?=
 =?utf-8?B?cGZQZzFNcU1UZTJtRExjdTJBdVFCSTJERkh2RGM2YndNdFhzK1J2c3FlaklD?=
 =?utf-8?B?SENoMWZSbHM0NmhPK3VTQjF6S3ZpU3UzZDhkZUNuUWdsb0llbHlGcWp1UlVS?=
 =?utf-8?B?Skp1eTN2TmNFYjNpSTNwM2hSSWJMS3ZIbmNSRWNicFdzSVpWYW1iOTlEdjgx?=
 =?utf-8?B?a2RnZDdsa0o2TXZJT1cxM1hYbEJONVB4cjNFdVBLVnpJcnl2RngwVUFpYzA0?=
 =?utf-8?B?d0pWOE0xaTJnVWFCei9pTjhKc3FOWng2VE1tUjNjbFZUUG9jT2lXbExzNkc5?=
 =?utf-8?B?anZVZjNiUzhnSG5vY1RMNytGVkVWdXRWemFBbkZnc2Z5dXcxRDZwcFAxb0Rv?=
 =?utf-8?B?U2VEblljZ004RU1BR2xySDI5bzB6K1lBTXlJNDI2SzVPdEp1QzIxV3FNREJW?=
 =?utf-8?B?QjBZNU9ZQW5VSENMZy9ob0pMUEtiVjBCZ1hmYUpjeEdYb1N4cXoyenY1L0No?=
 =?utf-8?B?aEc1NVRCblVTUFRPWmFlSHBiMEZ1T3NEUzdZZG9XVzdQaXJJUGt5eU9lV20v?=
 =?utf-8?B?MENDVkRGZEo3K1kvR0JXWGwvNXBTcmYxRElPMXFYczlKZnQzNEZoSHVsVTVo?=
 =?utf-8?B?NE1BRDAxcXJiZHNOVXhyZExISUVpc3IvbzJNWXJzOEhDaHdhZ3R4MnNuZmIx?=
 =?utf-8?B?T3AvSDRHcHZrSnFNYUhaS0RxTmowZWptM3puR2hZdURaZjNQYkN2MTNUbHNP?=
 =?utf-8?B?Nk50ZHFTaDhoWjVmN2REaUg0Y2JtRW1UK0J6bk9HQW1Jb1NiWTVRUWVoRGVJ?=
 =?utf-8?B?dklGTnhQeklrYnBzdSt1Q3p2VnZzd1hyZGl4azFsQWtjWkZ3MlFWWm5JanhW?=
 =?utf-8?B?aW9yWmlGaG45cjZXbDN6WFgrQ0l0MmtnNE9HbThpTVo5ZkN5U1JxanRuQjF0?=
 =?utf-8?B?a2FIdE93bjFHL3RaajByaC9NbDJRWDNLVWpKQy9rOUpITncvVThwSnJvbkQv?=
 =?utf-8?B?bGFDcTROSWhVZklDNTdlRGwxZjNtN3c5aEo1Tk5Qb3lGOHFrWFBaNTJTa0FZ?=
 =?utf-8?B?MExjYUJCUnhtSko3bWNnTytHMGw1dXNQZkZKdjNzM0tlK3drc3lNMTg2TnQ3?=
 =?utf-8?B?cDM3eW5OUGJTaGhVZlVFRnpNZGJmSXA2MjZJMFp3YWxiVUNaMExVQU1Kb3lB?=
 =?utf-8?B?N0xnMlM3R2RRUzE5Zjl2NWlLSUhFQXBDWGNXQ0haME9RdDdEd2c3M25WQk5D?=
 =?utf-8?B?Y0JubzRjcVJqVGtNZjA5OW1acHRLT1RPMTh6cmJPZEgxY1ZlSWxKMk4wMmNl?=
 =?utf-8?B?ek5ETFdEYjNRQ3NIWXZNSGZJM1RLUG5od0puUUN2VVBYMGJsZmRSb2hMekF5?=
 =?utf-8?Q?kHiIhCvhFAqbd60mssPHJdYIw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909cdbb2-cbe5-4af8-93fb-08dda8a5c24d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 05:06:44.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcpKt/V3RazPix6tnKyXaE5g9Isib3yE5Zo4BE5rpPBqxQf09FETMaQ+ISiINHRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

On 11/06/2025 0:32, Jakub Kicinski wrote:
> On Mon, 9 Jun 2025 15:02:50 +0300 Gal Pressman wrote:
>> The test was written by AI, and reviewed by humans.
> 
> Please use pylint and avoid adding new warnings:

Ack.

> 
> tools/testing/selftests/drivers/net/hw/rss_ctx.py:788:0: C0301: Line too long (103/100) (line-too-long)

Are you sure you want to blindly break this line?
It's a single string.

> tools/testing/selftests/drivers/net/hw/rss_ctx.py:769:12: W0707: Consider explicitly re-raising using 'except Exception as exc' and 'raise KsftSkipEx('Not enough queues for the test') from exc' (raise-missing-from)

Cool, didn't know python can do that.

