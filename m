Return-Path: <linux-kselftest+bounces-48715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB3D10C23
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 07:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BEFF3010050
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36815313E33;
	Mon, 12 Jan 2026 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsVnMukc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54030E0F9;
	Mon, 12 Jan 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200692; cv=fail; b=hDYaVHv1JzSzKfTZyngu5mnNHt3XZMiHqbHhuMqZJHcYrwbyqCMuSr97RVHjWv5O30/32PUEUvWDj6qohH3tqVsDzV1E6rjsBULpRxtkDkBBFXVgHutbL0wXDBJ8+z7qudWFKVt+YQxD9as50adJkCcL2FDT01QGkGSkhRTEPcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200692; c=relaxed/simple;
	bh=KqkeAhYiLy9NhoskufWUHMq4e8w779KmfIi5x5fyWts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r/TBXbxn6KZ47mJjJz5WVuOZWZHCd3WcUhJydU8VGSucC4rCqJN028Np9BsyIkEMhtnPITjNXI1SGYj6GKlAF1WRATX/Dc1wFYlU1OaiTSrGk7K3M8ny4qVMeJfvy09ejlHnKzjwDsRbEw/sTT611NOJgfpiUroZGPLFePwiggU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsVnMukc; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIrcVjt1bd4QkoFw9NObsf8QQ0C+Ai7Gaob6qAm7A3YfAIKTWtClMMo/2lgM6D5OOnA4xhmjrUqrcqCvfMDnIk3lmqMgP09a5qJw5lw728NZskXaP6NHl4cFx9HR+bf+67bJR5xcSK59UUWB+Ki0I+3baxXXWGgtGHL0OyVu0BaeY4EdGB8E50JqJMf7ggGYS4CrosDBXLVtQqejW80NNjCw2sstQA/ibi8Xf9o6hruKjM8edjg3NjelPFOspSOgXhElM/zznABgNJDSLo3X3eHr1LY/8ZSxyEVyI4/wQcndBCRKFBAtCFhLpDuCdu+SdCc1CCx634SjcQXZQCj1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HdvBnIWmxLG/6D2lz2v5GHLYscOsSUFdgOmyA5P2f0=;
 b=ep0y2rHwaJy2w4FdFju5bEo0syt8sSMsWe8B0p+sJ1WatP+Mx1xlwh9EanZn1zTm7dC9qxnNhW3hn0kQ3LfvQJB18c1/bB9yB1+y5n0llBlAciFZ6R7lxoTZedWOLQHWhS2x9Ve9iL6az5EJu3hQLwe4c17ERM3+hLYokGvL5QqpBQQ4yEkVWIWeNQtpwgyIbbKgQ8cOnqYe80/NeAGq1gSDSwng3UtnAgYzv2nktrt+siaFwkoNDrv3MdvtkRKzJCapkqJlf3MoCSc1KLn+P3iv4k2PmpImVs6vCmxFMlEl9UHZeOGaCWxzNL//kYwTYyIHpwqTnxjrjBbfKf7Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HdvBnIWmxLG/6D2lz2v5GHLYscOsSUFdgOmyA5P2f0=;
 b=qsVnMukcIXBL8AzGDefdz9K8FPqHP2pAlWWLv31MEQbv4b/s0jz0cvVz6gixIfagYHUYH3X2vO4WgjHAGJqI2dircaIW6z/YaU+0tbDBnqZWRkDFRgoTu6SVuAjab1IBA99lOaQtQJnhMM0sehYD8FySl2uFbDpGf0xdCKselicOrXfRhHQi5r9pt3hTMP0I5mVFWPpHJuJTsrrBHeHN+F1J8jnVhX7TkGw/44ZpGWy+lYlryYcO4BLohhKS9xV1lBfr+FgsrVDnAarhmfXhGGsEQKXglqYk20hCmctOAVsPKVB/6qEeOiazw2OyildsnxCi0m5oYJIOFv2SQ4x1ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 06:51:28 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 06:51:28 +0000
Message-ID: <a95dca83-b996-49e7-86d5-f07e8f178767@nvidia.com>
Date: Mon, 12 Jan 2026 08:51:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: fix RPS mask handling
 for high CPU numbers
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Petr Machata <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
 linux-kselftest@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-3-gal@nvidia.com>
 <willemdebruijn.kernel.e28b1e33bbf@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <willemdebruijn.kernel.e28b1e33bbf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e14f27d-ec6a-457a-24bf-08de51a70290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmdZdEp2eElCTmdRY250M09zS2hwM09EWEU3ZnNLOFZNbXFwd3ZRenlNOWZN?=
 =?utf-8?B?akJVSnd1L2tQbmx1K0cxeHdNV2h6a0toeUZueThnYUVSZzhjMVptU05XdjNq?=
 =?utf-8?B?ZnFMQ3U4WEQ4dmFhdzgxTkVXNTQyVjFCRVhmOXRZOVUzRHhjWXQwcDdPN0Nr?=
 =?utf-8?B?WjJZSURiTWFQQm15d0xRbEdIZHd0SWxYMlJBR0ppMEdFMUEyMTcrM0NzZkVp?=
 =?utf-8?B?eVpjUzF0RG5yOWV5NlpZZVVLditIRjFEbEtBN3BCamJCeUVmMkoySzUzZCtl?=
 =?utf-8?B?MU9PY0ZEVTQ2UHZZVVpXT0dsMnpCRllVOTlOYitEdG9JZDFZbmk4SUF2SWFa?=
 =?utf-8?B?eGkrUzErZm1yTkkwcCtFV3hZZk50enE2RzI0eXZMMkFqaVhPOUxpZVJrUVll?=
 =?utf-8?B?akw4RGZDNkhSM2t6T2dYZDBqTTVQUVpPMHA1aHhWbllQenBHS0ZCckJtRDVv?=
 =?utf-8?B?YlJBeHM0bG9SY0xDc3YvMHZuOHRORlFLTnZmMVNBMVlQampISmtsS2RmVk85?=
 =?utf-8?B?Y2lqRmVTeGh3STEzMHkvUGFaK2dTcjhMb21xbzZKMzdkMzh1MjQwOUVlUVAw?=
 =?utf-8?B?M2dlL0ZuckNHc2E1T2FrTUFyaGtEZ0lQU1hpTi94ZjJ5UHJEajc4dEl3ZDNR?=
 =?utf-8?B?Q3JaSVVmMmVXVmErcHdGQjE1VUVWS283QlZLdk1GWk9rOVdwOFpzWTY1bFF3?=
 =?utf-8?B?L015NXNhTlRDRVR2ZUdnODhuNnUzcHFpb21ndm4vbEt1Z2ErZXRrRllvcWZz?=
 =?utf-8?B?M1BaUzRQaS9TeUFFNS9Hanc4K3ZmL3EwWjgycGtqcFF4NXhQVzkwRXMweWhJ?=
 =?utf-8?B?cUhKNlprU2gva0sxMFZ2V1k5OEQyYU9GU0Z4K3h2NnhnS3FLRWd3YlBjQ0RK?=
 =?utf-8?B?aFU3NkVKSitHdlVRUnB0cjlDcEJDMVNZL3FZb0MyaTN1dGdrWHdPcGtjWEh0?=
 =?utf-8?B?VmhSY0tqL1R1eXRQY1RDL3ovcnB1OEdaOEErcm1QSXBTQmZ2bjdaMHJ1YW91?=
 =?utf-8?B?SmxnOUZxb05TaVhacnplNHVDbTBYeUZoZmlESmphMS9oWmozZitwT0hnSmFS?=
 =?utf-8?B?YkNJaExlbXhKRVVXU2FRV3RvMzI0THVWZ3gvZThCckk1bFVvMmF1QWdIbm54?=
 =?utf-8?B?NFV2SHFrYUQ4TWhneEJOVTNEeHgzamFvaExoQ1FqRU5kNFA4ZmlIRDl5bWZi?=
 =?utf-8?B?VXR2Y2NzZVJ2YjVudktFREdZaXRSQ0RFK3VJSU52REhFU0FCRWhxUGowanRI?=
 =?utf-8?B?M1ZQUi9NeGszNDRCMzgxMFRtemNIc3BtNG55dXBvc3RhUXBhTjNodDNOYllB?=
 =?utf-8?B?bUU4aE5Ka0ZJOU5xbkZnWHE3b2I5NTN5dVdpQjFuVk9Ka2p1WkJMTWl5NE53?=
 =?utf-8?B?alBuWjZQYmJxVFhneUJCUXdIQUdkTElqRGZnZERnbFRmVVFtNGhLaytOcGlt?=
 =?utf-8?B?anpyNC9sVTM0RE5ydlJUeUh6ZXN1MlA0QVNWaFNXT2tIdTR1d01ZT2kwOW1l?=
 =?utf-8?B?Uy9OQnRQZitmMmxTYytwZEh6eWJUeXB0UE54Q1lUdTZhK3crVVN0VWFIaHV2?=
 =?utf-8?B?cndsZmljSWR1aTE5TTJJUUR6Ui9OQ3QxTnE0S3Y0ckRNSGFNY1ZjcFgvRU9h?=
 =?utf-8?B?a1F0VWcyRHFOMElwK25aMEdTQ00vazZ3Nit2cmlncElFZThLRVBVR0FRZGJw?=
 =?utf-8?B?VzJJUjBOQ3hIbHdZV0dNeERzNENzSjB6MU41Mm9LYjhLNFVIb1dlSkJZeDcy?=
 =?utf-8?B?SjhqQS90bk9JaGUzaFpyNGNreHV6ejltcXRXUjdOMXZQVENWbStZNFhLTVpO?=
 =?utf-8?B?QlFvZWdSMnQ5OWxNOWJsK1JrR05xSWt2aUI4ZzhrVnVjZW1OZU1LZTZSK2NP?=
 =?utf-8?B?amNIRURqOXl4azl3Unp4Ly9qNkNQQ3kweHhLcEdLckI2WHNtOGJlYXBrb1lN?=
 =?utf-8?Q?oB6m5+5EAI1/CLijmeDKQQQkeyv3bQXy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVdYSGx3R0hrYjJwWlhqczVQNE5qOXkrNHd3VVhXNzNiNHFuMUFIYlBjdllX?=
 =?utf-8?B?MU5EbFlNS0lOQmFWM2xETWF4R05tVlRNV0p4RXdzNG1OSUhkbmJoeTE1WEFl?=
 =?utf-8?B?OWhYS3dQbjQ0cEZSaGJjQnlKRVlUSGpQOFI2bFh1ci81UEhQelFsbm15Sis0?=
 =?utf-8?B?ampJbU14RTgzVkpwdHN6MlM3U1p0MkFTZ0w3dXRmeHlCazYxa2dsOWdmUVhp?=
 =?utf-8?B?TSs2OHp6dWl3MC9BNU1mQ3JjUHA3VTh4WXlFT1RtUDc4a3YzNkwreCt0M2VL?=
 =?utf-8?B?dkh6VlNuUk9WYzEvTDk5ZW1lS1JNc3Vwdms0d0dSV3pFVWtkeE53MmJNMjU4?=
 =?utf-8?B?eFVYaElDVXh5Ymh5RDdmSFBvRURGdTlqbTBBMUF4ZUZ4bzVMUlVldzRseEU0?=
 =?utf-8?B?c2svNGxlTDUxYlViVDBjb1kweDNRMkFIZWtpdm8rbWg5MktLaWNCcUl5N1hi?=
 =?utf-8?B?b0daWE4xOGM1QWVlYkg0Njh4SXJHSEFxYkxQVmNKYmxVVkNLcFNIc3Qrc1lJ?=
 =?utf-8?B?MG1YSE1HdUE2SVlyR2pQcnFIdjdRZE9FdUpoRHVZaXdLZ0dKYkdGRllieHZT?=
 =?utf-8?B?a1pZbnhwbnNpN2ErYTFXV1VRR1ZoVWtVb3VYbEwwcWhESW5keUlOcU1INDNP?=
 =?utf-8?B?eXlPdEhZWWI4ZDBtWWdGUVhWWGRTaTVEcWp4aWpoeFAwMDBjUTB4QWNoNUpK?=
 =?utf-8?B?L3NTMC9Edkl1dnY3Zlp5ZnJmY3dyMnBMK21wODJTS24vTDduUGorREtwTWdS?=
 =?utf-8?B?clNVdDhQWHJDQnY1V1haTWVJRmRUKzlJbjR1NDNaUHdaUHFIdVlHaHoxQVdi?=
 =?utf-8?B?VyszRTFxaGJadnlLQ08va1dlOURoSFIwMWFZelcrcWZkbXJVTXV2L3JNSW5U?=
 =?utf-8?B?NGsyTDBYYlAxdzI4WVhvWERlV2VPRmpvNE1NM2ZyMlBjTjdIc0NwWHBET3Rm?=
 =?utf-8?B?M1pzcW5HYjdqUVFjajYvSzBubFplU3VTY3UvV01tVUxMa2wweUJsYnBZR25N?=
 =?utf-8?B?L2UzQU8vSm1HeGgxWWhwT29FOFpGT3RpajlyRWNJdkZsYXkwZHN4Qi9pWm5a?=
 =?utf-8?B?QWRUaE9QYy8vWTJJaUcwSUtnZEZMalVnR0pTSVBGdngyWjY0dGtud2NSQXIr?=
 =?utf-8?B?eFdGSDN4K3NTTitKVDVJL1pxdjZDeEt1U25VNVY5c1Z4SGplaWxERDFBcFpi?=
 =?utf-8?B?UTJFRWhPdkQrWTA3K1VOS0RaaVVQaEI3S1VVM0JXOWZENExaVXd4dGkzYlY4?=
 =?utf-8?B?MVZJdUNneU83aUhuaFlTQUhDd3BsbmFzYXB4cXhvV2FQVFY5emd2ckJyZWlx?=
 =?utf-8?B?eXd6Z2J6Mm5uMWFuSlRyQUlObTkwajZnZDRVWFB1eWdpYlJ1YnNKbi9oMEVL?=
 =?utf-8?B?V3ZXTWlxS0FiS0l1cCt5WUVKUzZEV05JWTJpWkNTUmtkV2pwQkkzRFRTL3pN?=
 =?utf-8?B?UzRwUUo4dkFOaURCeU9RR2FlWGpraWZyVW5VSE5lRUlRMnJZL0FIOGdqR0k5?=
 =?utf-8?B?empLRkFDMnhpT3RwK1dnNUNPdmNRcjFtQU43UHFIOGVWT0FJd0RpdXpBekYw?=
 =?utf-8?B?S0pYdmpkbEMyVWZwNGFoQUpDSFFZRloraU5tcnRQaStwcmlKejVoanZoSzY3?=
 =?utf-8?B?bCtweEV1VnptOVRRQnFjdXJHNERTT1duM1daU3dGUFZOMmNzVlJPbWlNMGZK?=
 =?utf-8?B?R2VONDMwYjU1cXdoYk1lUkNGenAxWVI2SzRjV24vUW1TbHk5YTBFL3ZoRU5F?=
 =?utf-8?B?QVcyOE1zSmVBU3B3NDdOeERlSVJzNE1yZmJieTUreDVjdHhCZkxYQUNSd0E2?=
 =?utf-8?B?ZEJtMTZXS3VPbDAybmtLSVBVdkljSnoyOXg3UGtHdUswSHROWWxVc2FLbEFC?=
 =?utf-8?B?Y2dyNGtNTlJVSk9OMEdTMmdUU285ZGM0NUY5enNNMDU3K2JEVmlwR0Q5cjh0?=
 =?utf-8?B?d1ZvV2x5bEhEVTdudVYxTXhzZGRWdFlYbnROaVo2aUFOd1UveVAyaG90NUpO?=
 =?utf-8?B?MlJ2OEdTWWdGKzRNQ2F1Ky9ZcVdGbytnRDBMUHplemR1RjdhZjJWVTNCMzYr?=
 =?utf-8?B?VUJ6N01kZVQwb0gyUEhuSldMRFBTYk85L1J0UEhzN2Y1allzYUlxb3p5dG1Z?=
 =?utf-8?B?Zno3Vzl5ZjVQTXloMTAxYlZtaWpGOTRaUTUxNVZrZ1l4aDZEZll0dmltanAw?=
 =?utf-8?B?TE0rNWJleFZqYzIxdVhGTERpS1VScmNlUGg4THBQSTNERkdLelBacXhtOTI2?=
 =?utf-8?B?azZld0d4L1VNVFZvV1Fha1RpcmdNVlRhN1ltYmpkWFZpTDM2UDdLY1NBQXNu?=
 =?utf-8?Q?k1PKZ5UcYnXj+rxW6F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e14f27d-ec6a-457a-24bf-08de51a70290
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 06:51:27.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9VFN7GcemwVzanBUk+i/iFiRKhY9jV+Y6IT/vvr/MXMb16BilcDahkgbQ3xhTge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887

On 12/01/2026 5:29, Willem de Bruijn wrote:
> Gal Pressman wrote:
>> The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
>> 0xfff0, only allowing CPUs 0-3.
>>
>> Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
>> 0-15.
>>
>> Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
>> Reviewed-by: Nimrod Oren <noren@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> Should go to net instead of net-next?
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com> 

I usually send tests bug fixes to net-next, since it doesn't fix a bug
in the kernel.

Should I send those to net instead?

