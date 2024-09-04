Return-Path: <linux-kselftest+bounces-17146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A593896C38A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295801F2626E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1991C1DFE15;
	Wed,  4 Sep 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hyfT67Dm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB01DA619;
	Wed,  4 Sep 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466250; cv=fail; b=qI8RvMrXrpwliof295h7/CPxPXbL/I01OhNJNqj/1FfZvT1xBX2O+hwBvakYRXS0Tw1s4FYLVFLbIag6MeE2e+uo8S5XpAqaCBtBES7sfwJWQV1hXDLiHnxk23DDwLkwOxuLNfatLQ8C/RU4a9SYkNXna1JLofCjCJftLsyHcJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466250; c=relaxed/simple;
	bh=AQdxFW5TlxrzJWtMbqRaY/aQjTLGYkt/YYoPZcj423A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M0XH6hGtSZNdG0wtHpOmM1aXtP2yrP2hUDK2aIW/19wnbVsrCjCIw3yyl25qpaN3xC05x0vS4gL1MJ4Cni5wMndVbt332p7xaJrrvyDxaGfKuz/m7cYdjYcy8sEAUC3zxNEFXmlN0U+uXnB2/nrc90qFWEMByoSlt4Z2X6zvm4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hyfT67Dm; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ6VLL+Llcq4MziprOqu1BLUF/qGme5I8jCcN6xLT1sL7Wu+WtsJZzc9QrbQqvSO9j+/YCjf33Qi0EGZ0zsOnqMgp6JdQ6bL3IXFHzsMHuOqoUyMe0WgNgjHse0Trbagbf9xqprByQLm/xvG4m5KT7rgVGFy2m7u8L+wL6Nl7jKiocbC0Wj2G3IZsmDb/zcul75O2bTclreGcArf+j+YG3coaqh5Yj/tZmxhONJxl0UfjiBhY3rPispWvE30kCKDgnzhzc65oB4gAL06Gb8F7K7l3eVcH7s7eQvgMBsOfuAOAf2uc9u2sLr5Yw6N+MfnF/+R1Ww2nnWVlgUkCnfw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC5AhbGdkyjUzZjgcYjqmmUIqgHyc6diSEKMgnxxZuw=;
 b=gCYra3iQo8TrNO7AhiNYn1qOau79pi05cxh+QOMnJas4JebPaEouDmhqZNZMAyGSwFlMzrYdQ+FF5goJfIOSpDjPIrFtQwxqK1a8+D8bg6souw8x95FcqXi1lUhq5Y1XkR22ibzPE7Dw8XoiGYR5ydDWMudfAFVYjeIMXAgGpzS68k3PZ7e21Pblzxg/7ZU+mYgZAe3TpL0SCGyPXK7ZlX/TbaIfphqt+RvBvjzRaGPuhVEHRTYo8PZBjqh0VOJB97PcbjIhQ3kKNzeh5+hx+hUfF/h6ONmBEdGpTa6h/G6lSBGsOsjZ3yzRbt0Xn/y7TjNJW/nCE2nZ3hKlMVl6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC5AhbGdkyjUzZjgcYjqmmUIqgHyc6diSEKMgnxxZuw=;
 b=hyfT67Dmyb/OeON6SBgyrzx1O4zbRraiJGLqOxVpyYqQ+XtN8NnnFXczO93mALLVwj2jRq2Kz4q1kvkFgNxaycs+apxUuLW2E75uiejKCWv7nuHtTyRnl47nqAp0L97edXzjljYKDQfkedU/mTcUiL/mrYzOhoXTViA+bw6x5uA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 16:10:44 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:10:44 +0000
Message-ID: <02af4fa0-cf90-4d26-b74b-dc436dc8c9b2@amd.com>
Date: Wed, 4 Sep 2024 09:10:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] selftests: lan743x: Add testfile for lan743x
 network driver
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org
Cc: shuah@kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <20240903221549.1215842-2-mohan.prasad@microchip.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240903221549.1215842-2-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0118.namprd07.prod.outlook.com
 (2603:10b6:5:330::31) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3ef3c6-c3ed-487f-b831-08dcccfc213e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkhzL1FSU2JTQmkxS0VBdWpCL2xvc0NlS1FiWksvY2dkSFZwU3NxL3lOQUNR?=
 =?utf-8?B?VXhPQW51UWRSUzhDMXVPNTl3amp6UUp1bU9nVVFkR2kxRlhCcTRycHRSQ2ky?=
 =?utf-8?B?Z2FKLy84WFBkN1hHaWFqUEtlR0s0bGdnQS9Ob2VHTDFkdWdZek1tUGdlcTBM?=
 =?utf-8?B?RDlTNFBvTDExa1E0WUc5dnllZDc5TDk4dXRJMkVEaWUwQ1dxUXJVV1pmTEto?=
 =?utf-8?B?YUM0NVhpb0hqQjZFVU9HV2xBcUtXM0ZDL2VrKzd4L1Q3U0xlUTkvbEFOa0Ru?=
 =?utf-8?B?elh5elc4SytxWDdmaDNsSWRKbzRhMGNKSmZ2MmllVHdOOFZxZnFWcXZ5SEtU?=
 =?utf-8?B?ZTZZNFR1K2tNTEE5MEltR2tkcWNGNWtRaExZelYvaEtua1BmeDVZVHVFYlpS?=
 =?utf-8?B?Wm5CSjhCWXUvcTNrRUdXNENtLzlXM3NIYXpDbmpmbE0yNWNDZ1IzbVVsSEE0?=
 =?utf-8?B?RzBXYVBQOUo5ems5ZHY1MjR5OVNxZUtubWo4c1RKVHBxMVVQSkk2d2NDTThI?=
 =?utf-8?B?UWJZd09aZTh2L1FwQ2tvejJBcVlSN2czd29iTER3Uy9aNFRNSmVnNVgvSnhE?=
 =?utf-8?B?YmVqZFJtQzQ5dnlvaE5TeTRTMlo2cmdKQkp1SFBmTVB1UlM2cXlHbjN3UUND?=
 =?utf-8?B?ZFVZWTFZRko5dEJYYTlkMytpZUNFSExScS93NGorYUc5dUZESEYzQmc4R0Zw?=
 =?utf-8?B?dFd3MG5ER1JVUmhwbC9IN2Y1bGZubi9nZkNRMzRHaUxMbDRLd2JGK1JNQVZS?=
 =?utf-8?B?QTJWS3lmTnZ3SXlXN0lkVjZ0MjQzTFRGbDU1ZWVpci9QclZJeTRXRlcyZkxO?=
 =?utf-8?B?ZXZZNWxkRERsamV1UG1DK1ppTmpRR0JDbVl0NXMyMnp5Mk9RU3lIYTBHR1VZ?=
 =?utf-8?B?WXlzdm1zajR0Z1NwMldnRk1WTkMwVjlwZkdNNFZtbEExQTl1MUlSbjlaVWRi?=
 =?utf-8?B?NWxScHVvb3Z1RE5NZ3ZvdjgyNzFyak1Oakp0U25vNS9kdWVzdXVrcUxMTFpD?=
 =?utf-8?B?NHVxUWs5NzFsS3FBUFZSZnNQTElieFBTVzZuSHE0SW9hb1JsRy9JQzJDcGxs?=
 =?utf-8?B?MjVPNkoxOG1oVGxvRDl1LzVqamwxWTZBd1kzZzZTZU50Q0tJaEx2d0RUNDEx?=
 =?utf-8?B?c3V3V3lQcktzOVgrV1lRZGZPOUxVZ01kMVU5MXFoSTk1MWFjdFh6Ty83UjJX?=
 =?utf-8?B?a3dZQytvaEJIcStsUUxhNEU5SDFPREd5a2daQU1pejl1SFJ4S3Rxdy95QTBt?=
 =?utf-8?B?SDVzdk5CV1NrWEZEWVVlSXRNcmJ1alJabCsrTVRGYXJzRWpQR09oaDZjQmdS?=
 =?utf-8?B?ZFhCQ0NNT25sY0hmMDZ0UUU4TTRFR21lRnhQVk9WY1NMMDM1eGxFc3BKL2Yx?=
 =?utf-8?B?MFFZNlQzd0t0YzA2bGQ3QjVtT2wyb3hIWCswWjFvRU5rM0RqbTVhYTVFRWhP?=
 =?utf-8?B?SXFKRmR4bUVNcmUvMTc3YllaTytKNTUwclZRRFJDR0V1alVORFFON3RQdWxB?=
 =?utf-8?B?aFkrck96ZTdpVTBJSnAwL3E2S29KYWt6SC9xckxVK2pDRUljcmR6aTZXZmhz?=
 =?utf-8?B?eml3ci9ybk40TklEMHhuU0lhN1F2VnRvUjBuSkhPZExaa1UzblZqRFVEQ3VH?=
 =?utf-8?B?STlCQVRHOU5kbld6VWxDaWhYcUJyQVh0SUNoUWozMTRGdEErTk5Lblo5c0pw?=
 =?utf-8?B?UlV2dmhIdnZWcVo3T3I1L0J0MjBUTWgwNVg2ZjMvYlExRmhlL2RvZ1MreFhQ?=
 =?utf-8?B?OVNmMVlTWXJHaTlWLytYTnB0dFliVjhiazV4YXdtZytXTzRGaHRHek9obE91?=
 =?utf-8?B?RjZlamttdGZCc2V6d0pCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXdXSTk0bGVxdkVCcENreFo5RDFueWxrQmpRR2E3L2U1UHkwNERHcWkrdm1h?=
 =?utf-8?B?cjhFeUhYNlAyaEh0NWFtQmpMbFN6R09tbkhvcW45SmNEOHdLY1E5YVNOdnNu?=
 =?utf-8?B?UmMxSzJtbTZnS0NFN3R3ZnNkZXE1STJ5TUE5VXI5TVRaTEFHajZMd2xCVDNX?=
 =?utf-8?B?cjNzNFVKRytwN3JXNVRZTUhJYVQzbXl3UWxGaVFwVnlObWc4YUd2VVNtNWhv?=
 =?utf-8?B?YTYycFRKdkJnbFNCWXE0QkJFQlVzNTd2RkhyQ3VKanRwbk5kU0ovN3NKR29R?=
 =?utf-8?B?OTRNNENoUTF6KzEwUkNOSUhuVWUyY3czRmd5MVZ4d1h3VjJKOFVFM0FsZjRF?=
 =?utf-8?B?TDcwZnl2VkppVjFjQVNibUhkaDM3YXhkRE9jNUVmK1ZDREx1cnQ1NDVZcEZL?=
 =?utf-8?B?aENPU2l3cC84ckoxUkVCR085M2VVMk5mTkZuTHA3T29LMUdCT0NBK1FsbDEy?=
 =?utf-8?B?MWJXd1d5S0tncFRFZW9Oa3dWMnZIZkczR2NhTVE4ZG5LSytqcm5sazVaNXhv?=
 =?utf-8?B?YkRpNlUvVmc1MTZwcW5FdGgyMm14aVo4SDJub21PRWNMKzhZcUhOckwwVjdl?=
 =?utf-8?B?TGJNV200U2l6WVZhSE15YUs0T1hRb3BaTEVVeVFHWm0yYXd6cnRnSjROSG14?=
 =?utf-8?B?UU9mRFRqWndxemIxQXh0S0I2dWVqamE1ZmZ1MW4yWm5QbFNrbmVtUlRIZExR?=
 =?utf-8?B?aENCM0pOWHR0MG1oWGxyLys4NkNDOEVGM3JCL04xRUxZcUtsZkhxdGVCRGJ1?=
 =?utf-8?B?NmZLdmsvQjJBUURLSHVpc2FLVThLbURmVWJWVGMvd3EvTXRzZVFHYXdKQ0xK?=
 =?utf-8?B?bUt6bGRZK3ZUUDlzYW0yczhQcjhGd2h6eDJGSmZYUVFaSWR0VDNFRjNEYUpH?=
 =?utf-8?B?amJ6NGs1S1E4WlZuM2ZSUWFGRVUyNEJSbFRXZk9NcW1DdlVybHpjYnZsejJy?=
 =?utf-8?B?YUJPQ0JDcGd3U1k2a0pLandFYzJYeFlVNS9zZk04U0JXd0I4VDdCV2hKQjZw?=
 =?utf-8?B?cmpJZ1gxMEhlazBDREh6T3F0aTdQTm8vNGc2MThQSXQrd1hJZlBjU08vUng0?=
 =?utf-8?B?a2VEdTVWMFBab2xCMHB0Q1MvTVlaVDlyV1JyRk9pN3lMZ1o0N01rTWRVeS9G?=
 =?utf-8?B?TXNqTlpNT1hDdm1IMm9uOWoyOVJObDZ3SHdBVmdVOUh3MVR6SHp6VlFEOGwy?=
 =?utf-8?B?WUV3aHFLS0ZuTXk5TjA5YVNsNTlmZllSQ2piSENSSXJhcXFhSHc0T0JoekdB?=
 =?utf-8?B?OVBYQzZyNVMzTVhHbGhScWJXcTVMOTVGaGszemF1N0o5amUremhvSFJVQWg2?=
 =?utf-8?B?VjhuT1orRHIrQlFKd3dNUDF0a1hWVkp3d2JndGxVQVROYlJaQnUrSTZVVFVx?=
 =?utf-8?B?RmpoTE5RVHU5R1J6Q05Ha293TWcxM3FNQnF0NHRYRHZNQk1LY2hudU1LRmtL?=
 =?utf-8?B?WHZiTVFINWk2d3VYQ1A0WUd5bjByeVNydWZrM3FXTm1IMWFlVFpOTVlNbGsx?=
 =?utf-8?B?SU1XZGdvMFE4bzBraE5HNTBtZXhNZGZ4VWlVUTRUcThZcW5ndWN0VHpBRVJH?=
 =?utf-8?B?SW5zTkNMbnNBTzFkRENWbTRMdlpzNnU4TVlQWGtaQmdqdlJGY2JkZDQrRTdi?=
 =?utf-8?B?ZCtJSTdFelRrV3VRWVdMRm5qM05qMCsrMkllT0dCbEh6K0ZnNHFtZmNmdkhp?=
 =?utf-8?B?TWZ6RDNTbk43RURSZ3VycXcxb2xWaWZ1dmNrdkJhSzNHNjkwak9Dd1RwVEVT?=
 =?utf-8?B?VnVTNFAyZTRHbThtQkRKTVRXQ05NZ2hWUUNEWGtwUEdISWI0QjVRVkZSVERK?=
 =?utf-8?B?SnRML1hyNUcvYmhmOTJVN2R0U2RrN0UwWU1RZjZEdm92MEdZOU9ySk15Q2RR?=
 =?utf-8?B?Umw0QytZeXhpQjZOZk41WVQ3aFJBdUR6cmhJaWNpbjRRSTk5UkNBMmN5RDZE?=
 =?utf-8?B?cEpiS0tZUTZrOTdORnFJQk1Ha3hNanRvdmppZEtyK29Od3pLM2dma3Q2UnNi?=
 =?utf-8?B?SlVBMDlLR0ZOczF0VlljUUlTUGhtSkRYRi9KcDYyTnNBYmM0dTllZ3VrSURk?=
 =?utf-8?B?OTQ3empLWVV2cGVZekYwRlJ1dCtPSEFSa3p5QUFLNjNhdEUxb1RFQlEwTWsx?=
 =?utf-8?Q?jaCQM/w0AMnvSsBZ9wkMh9Szn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3ef3c6-c3ed-487f-b831-08dcccfc213e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:10:44.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Z+CN/D14Ct1OM9ihmggEme80Yu9Q6fJadswogj+y0En/U5LGuGhKzheBKugU1W8KlYqLvTKlMKXB0FmSvSsEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940



On 9/3/2024 3:15 PM, Mohan Prasad J wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Add testfile for lan743x network driver.
> Testfile includes the verification of status of autonegotiation.
> Ksft modules and ethtool are used for the testing.
> net/lib libraries are included for testing.
> Add the __init__.py file.
> Include /microchip/lan743x as a target in Makefile.
> Updated MAINTAINERS list.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>   MAINTAINERS                                   |  2 +
>   tools/testing/selftests/Makefile              |  2 +-
>   .../drivers/net/hw/microchip/lan743x/Makefile |  7 +++
>   .../net/hw/microchip/lan743x/lan743x.py       | 51 +++++++++++++++++++
>   .../hw/microchip/lan743x/lib/py/__init__.py   | 16 ++++++
>   5 files changed, 77 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
>   create mode 100755 tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
>   create mode 100644 tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index baf88e74c..461f94ae0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14960,10 +14960,12 @@ F:    net/dsa/tag_ksz.c
> 
>   MICROCHIP LAN743X ETHERNET DRIVER
>   M:     Bryan Whitehead <bryan.whitehead@microchip.com>
> +M:     Mohan Prasad J <mohan.prasad@microchip.com>

It seems like updating the maintainers list should be a separate patch.

Thanks,

Brett

>   M:     UNGLinuxDriver@microchip.com
>   L:     netdev@vger.kernel.org
>   S:     Maintained
>   F:     drivers/net/ethernet/microchip/lan743x_*
> +F:     tools/testing/selftests/drivers/net/hw/microchip/lan743x/
> 
>   MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
>   M:     Arun Ramadoss <arun.ramadoss@microchip.com>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index a5f1c0c27..8059529c9 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -122,7 +122,7 @@ TARGETS_HOTPLUG = cpu-hotplug
>   TARGETS_HOTPLUG += memory-hotplug
> 
>   # Networking tests want the net/lib target, include it automatically
> -ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> +ifneq ($(filter net drivers/net drivers/net/hw drivers/net/hw/microchip/lan743x,$(TARGETS)),)
>   ifeq ($(filter net/lib,$(TARGETS)),)
>          INSTALL_DEP_TARGETS := net/lib
>   endif
> diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
> new file mode 100644
> index 000000000..542128678
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_INCLUDES := $(wildcard lib/py/*.py ../../../lib/py/*.py)
> +
> +TEST_PROGS := lan743x.py
> +
> +include ../../../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> new file mode 100755
> index 000000000..f1ad97dc2
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> @@ -0,0 +1,51 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import time
> +import re
> +from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
> +from lib.py import KsftFailEx, KsftSkipEx
> +from lib.py import NetDrvEpEnv
> +from lib.py import cmd
> +from lib.py import ethtool
> +
> +def verify_link_up(ifname: str) -> None:
> +    """Verify whether the link is up initially"""
> +    with open(f"/sys/class/net/{ifname}/operstate", "r") as fp:
> +        link_state = fp.read().strip()
> +
> +    if link_state == "down":
> +        raise KsftSkipEx(f"Link state of interface {ifname} is DOWN")
> +
> +def set_autonegotiation_state(ifname: str, state: str) -> None:
> +    """Set the autonegotiation state for the interface"""
> +    process = ethtool(f"-s {ifname} speed 10 duplex half autoneg {state}")
> +    if process.ret != 0:
> +        raise KsftFailEx(f"Not able to set autoneg parameter for {ifname}")
> +    ksft_pr(f"Autoneg set as {state} for {ifname}")
> +
> +def verify_autonegotiation(ifname: str, expected_state: str) -> None:
> +    verify_link_up(ifname)
> +    """Verifying the autonegotiation state"""
> +    output = ethtool(f"{ifname}")
> +    autoneg_match = re.search(r'Auto-negotiation:\s+(\w+)', output.stdout)
> +
> +    if not autoneg_match:
> +        raise KsftFailEx("Failed to find autonegotiation information in ethtool output.")
> +
> +    actual_state = autoneg_match.group(1)
> +    ksft_eq(actual_state, expected_state)
> +
> +def test_autonegotiation(cfg) -> None:
> +    for state in ["off", "on"]:
> +        set_autonegotiation_state(cfg.ifname, state)
> +        time.sleep(5)
> +        verify_autonegotiation(cfg.ifname, state)
> +
> +def main() -> None:
> +    with NetDrvEpEnv(__file__) as cfg:
> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
> +    ksft_exit()
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py
> new file mode 100644
> index 000000000..e571631af
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import sys
> +from pathlib import Path
> +
> +KSFT_DIR = (Path(__file__).parent / "../../../../../../..").resolve()
> +
> +try:
> +    sys.path.append(KSFT_DIR.as_posix())
> +    from net.lib.py import *
> +    from drivers.net.lib.py import *
> +except ModuleNotFoundError as e:
> +    ksft_pr("Failed importing `net` library from kernel sources")
> +    ksft_pr(str(e))
> +    ktap_result(True, comment="SKIP")
> +    sys.exit(4)
> --
> 2.43.0
> 

