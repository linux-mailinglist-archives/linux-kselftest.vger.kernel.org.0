Return-Path: <linux-kselftest+bounces-16202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571895DBF3
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 07:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90531F224D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 05:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DCB13A884;
	Sat, 24 Aug 2024 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJdW0cUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405092F2F;
	Sat, 24 Aug 2024 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724477730; cv=fail; b=EAyI/g4uvSExpGw+sxbITaqLttmq4+xKqEnE/nF9bgq9jccpk92GoYnI5fVweUhFlwehcLb8j+nFXvo2bIQyiGok6725C7Y3UlLrbF8YjOdhP0o4KdCeI4fcug/ZWSbDpA7Hl1hbTuNzx//a7YNugZM4jEeLTZzcVSwIl/ggWoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724477730; c=relaxed/simple;
	bh=vZHIezV7w2JjtMmJB3mOk2tuMYqTiFei3MgMBJiiCD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tz9aBR2wk+uc3Yd27XknxaAyLf5RASE2+6NZQHDD5FAns6NUurvuo8NsVMWaGXFLnRho/Ic3czld1ki9OBTjK0zNprsdIx2leC8B7N8LQEiR0SEsntmJCTB4TUrDE7fYtis7gCApyItuSFtKUpOlSH3NS6sDhU03RnPH81hZ8q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QJdW0cUU; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDhBEXGNVcOVGOevl+K9bL6SKlQOHDZSoOozz6C0nRAEoPLNos7CgpeEmjL5njCnf8WUs0v1Lya6OzaUtBZo7dfJZ0fzKFpURFma/nW9ZGG+nWAvaPHPvQ48UPkdThTG7DbL+3k+hwjGCeBi/9y5nkYJtyW37gi2YagYKLhU6iMwhT3AZWmZ8CWKb4FRrNZWT156B/d39F0BD6YnAK4loA8TSKwgvaB1H0+0Fl8/dSPos1sb+O33d/XoxmI45w4YRJ1XYiIfS5eGWzl2kISYwQ5sVqINjxatsvE1/G5HuVVjfxVg2ALygeYAtTj6nikjVTx2u0IEB/GcqsxDIEktIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJGB9LPpHxVm3tFZdmhSSwduzAsLf/Hgt3urP4LXjj8=;
 b=LvQ20ZexEor8SDpFysT9MW2xMQO1LZ2lTLudgin5fx7DvJ/Dwk2Pm113vRy+Q70sinlQivNmCUar83ipcSwt/wu7TH4aN3kDPVcrfK5YsL39LcTXwavimh8AmzBwAzkVI72xqCcw5Wo/e+IE8buIsLscC2hFwEF8XclOz67cl5M2tpS/5VkOMTPZqc0SoHPyV+znHvFH3iKujSKSwc5XvHds4bKcZ84QtVDnlIZjNpL4iPS/ggtlAUxCOhrNuBpc4a78WtkOtTanQ9T7ndAH62t2m1iKgmQrS9oP02MgvgoQI3DEZMIzmMNXHhFVFZUI7lmPZyy+MfsLn/EeYDTx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJGB9LPpHxVm3tFZdmhSSwduzAsLf/Hgt3urP4LXjj8=;
 b=QJdW0cUUyFLUPAdUwxYnUxeu/PWVVgkjubOQhiRZ+E9vc/MftOOpgo7SYzffx8pts7z1JknfB5Luyr5/OFv7rXpKAjQyYO765/WzcUF+JFwiZjm4ugV4t24xDDeTbc9fJAexh2bRQbhme9Rkp672nGvY2G1MO3C95gCKHtJLfwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Sat, 24 Aug 2024 05:35:25 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.014; Sat, 24 Aug 2024
 05:35:25 +0000
Message-ID: <cf8c67de-4c23-416c-a268-56a12801a305@amd.com>
Date: Sat, 24 Aug 2024 11:05:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] KVM: SVM: Enable Bus lock threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-3-manali.shukla@amd.com> <Zr-ubK_e4lAxyt_7@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zr-ubK_e4lAxyt_7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::15) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c86d0c8-545f-46b3-79f7-08dcc3fe8df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0d5Z1RRZzdKRXZ4T0loVENiOVlrTDh6MmR5OUdZd09Za0ZKclNEaElRQXli?=
 =?utf-8?B?ZDRtamk4clRyc3NzbmxjY3hvZlJmUTRjWkMzUktidkJ5c0plWlAwQ3N2TUFS?=
 =?utf-8?B?SzV3RGRVZUNWRG50OGZiTDRnZ0dQTnp0Qmx5UDUrRUdibWd6dnlQV1JTbXNT?=
 =?utf-8?B?ak0vTHNCaEQ0M05ycXBEMk1jemlVT2RjdFY3MEJmN0ZlRFRyT3pSaHUwSitY?=
 =?utf-8?B?RDZRZndqb3FpbHY3UlJLTXpTY0dpcFJqZHJleDRxRW9XQklZc1dIVkp0SUZG?=
 =?utf-8?B?Y016dlo4cG44NG1zMG90Mm1RSllOQzZaWkIrMzdUK3Jab3FzWjA5L2w4bVlm?=
 =?utf-8?B?WUNtQm5aQ1RXWjR0d2hoVGI3aHgvYWxmMTNnMGRPZXJJdGVlOGxpNUU4TUdn?=
 =?utf-8?B?RE1Yc1ZTYjZhZ3ZjTEhpN2dWeXRCQnZzNVBFWXJDemhsRUhYTEhwc0tnc3Nl?=
 =?utf-8?B?eURZeHZ6ZWZLVUdLL3JuWitHelFEOWtHVkpYTkw2dlJ1ZERHaWt4bXcyV0xj?=
 =?utf-8?B?cnFEckpUdGhHK1kvU0hueGp0SHpCbk9PQTIzSkVqdytQQW9IVVdWN0ptVGhX?=
 =?utf-8?B?ejBxeG1OQ0ZGZlpSREJlKzBCSndBaHZXSmcyVXJlQlEyRXdYVGhGU3RqZnFT?=
 =?utf-8?B?THF5Z0FFYmdxKy9HblJ3UndNNGlBM0oranZRcUx2L0pwNWc3TVdTNlE5MFU2?=
 =?utf-8?B?Z2QzQWpSeWUwUld4M1greEhFb2lTM1hpUGRMTlFHOUpHa0FtSkpjN2VIQzBQ?=
 =?utf-8?B?U2YrSXJMY3haYk15cWV6MDJvZzh3RDl2OGg3MzI1QjZ4dmVrRlJQOU1adnlu?=
 =?utf-8?B?S0hvN2FHVUozem1RcW15aG1MTzFPc3VtOTRpZml2aEtHMTFYRi9VTVJ0bytj?=
 =?utf-8?B?TTRWM05mMzQ5S2hvUzhBeUpiVDI1TlIwZW03L09TZ3EyZGM5N05pYXJIT3lp?=
 =?utf-8?B?bXlpbUdiR0o0YVFua3JjUG9SenBLNVZucDBrNDZqQjVFM1ZmckZjTmhVRGg1?=
 =?utf-8?B?UlNYRVVvVHlBVnpXdk1WNGFucWoxT2x2ZjRSTFBqUWMrMGo3YUEvZ0dWY1h3?=
 =?utf-8?B?a2lZMnhYOTdiUWI0WGxrYlcrY1dpU09Nb3luUkgyOGFqYW04NUhXOHFVY3hz?=
 =?utf-8?B?TFFvSnB4RTRIMHFTOXdTYStOWUgxYkFZYythb0VwYW1BMm9pVlFQYXRCUG11?=
 =?utf-8?B?VlovNDZFS0dyOVRSTVNDc1dQN2crUkhkWnBxZ0M1bGZZTUdGNzgzQ2VSaGty?=
 =?utf-8?B?YTB1ZzFRWVVBMndXanBXRnIzR0dYaWxKT3BINmtwZUxycEJac29Kd1hlSVlo?=
 =?utf-8?B?QnFQY0tjQW9tZHhmaXlYWmszQUhKUmJ1VmRQZ1p1S2lZRVhudFh1bTA1SXdJ?=
 =?utf-8?B?cjN3Q3Y5MXM4NFQzamVnUWo1V1dXZXJnWnMrRStCU3VWbzNjdUtQVnJUYk9m?=
 =?utf-8?B?MlduVzJwa3RoejRSUTZUL3hKU1N2K1ozQmw5VmFXYUlJSHVRckwrcjJMMWM5?=
 =?utf-8?B?Nm4yb2RHalBYUW9ZRk9WRTFYemZDMk1VaXdKaFF5M2V1dDRBZ0g5L2V5bVV5?=
 =?utf-8?B?U2NPeDhtNnI3QkdGeGt1eFMyeVFKT3VGczE3UW0xVTNLWlN4TEN4elRubW9M?=
 =?utf-8?B?MGUrSWFRYUUzM3YxaWMwa01sR3krSlYyWVRIRVc4TS9QQXlEOERuZ0tyVUJG?=
 =?utf-8?B?VXJvMVluNEFXOHVnTnFjRUd6VCs3a0FDTElyd0dQdTZGNCs2Z3RNeXVQVFZs?=
 =?utf-8?Q?JgOWEhrlkQuFuyNy08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NVN25TTGVySjZFSEtkeHo1NFc1cEhtaEhZajRVNlhWQkdiZ2NDVFFVdmxM?=
 =?utf-8?B?V0FYb1dtejhHQ25wM2pUbWVuZWZDU1Z5bFozbHNBTG9sZDJDc01ONEE4V0hF?=
 =?utf-8?B?U3hKWTNrOXBQS015UDRwMDJGSHNEa3B5Vk5DK2k1eTQ1MnFtdjZiZzJ6S3cv?=
 =?utf-8?B?cmp2ZVcrWnBGbWFyT1NtRmUxQ3kza0taRkdyWWZkOWFRSm1ET1dNTE10SXJm?=
 =?utf-8?B?aFJqcHZjYmw5UE5GTTU4M3Nsd1ppLzFrRFVBK3V6alVOZ1E2ZFpNNG9Jbm0z?=
 =?utf-8?B?bmtUaFo1K0YyM3k1S243WTFQMkduWlVKb0h1SzdKNWcvUWxybTI2UWo5Rndm?=
 =?utf-8?B?Y2hXdFVBOUt6UVBlUThnaVBmUUZsQ3Q4QkhoTFBhWVZDaXppSGVlY3p0dkdS?=
 =?utf-8?B?b2RBci96cmxBRE1KeGJJVzQ2Ukl6UXNaN2tycnIxRXdRL3grTGdmbE9BaHZq?=
 =?utf-8?B?M3Y4MlVKMGd2bUE4SlY4ZkorMUVHOXFUMWQxbDd2SDM3TGdSR0hUZk9ScjNr?=
 =?utf-8?B?VlVWWC9vRkI1V2dZRlNYcXFUM3hSVHU2N0ZxZDZZWW0vSVUyUzh0ZjB2VTRG?=
 =?utf-8?B?K2dsQWw5WHdVZ3hncStTdmd6SHV2czdxN0dzcllzK05jUkV6MTBQYWI4bWRs?=
 =?utf-8?B?aUtJRURhaS9LZWdEQ0swWkNvN3dycnhMUWlpWFFiMzNQZGV4UHplS0tySzQv?=
 =?utf-8?B?a1pmbGl2UC9vYkwxbEg0L3Z2dTErcUFmR20xaDZ5aEVWK2xqY1phS0swdzRO?=
 =?utf-8?B?d1QxSEFyYnVLMFFsd2FFRHkxUjBSaGRIaTYrU0Joa0k5SmNEbFgyR2lJYURI?=
 =?utf-8?B?Q2U1VjFuYlBqVzBBQS9yY2lkUVoyVnJ1NGRKVEkxbDBTS1ViUXlKVDVvWmtF?=
 =?utf-8?B?K1IrbE9oYThLUDRGYW54dm51dGV4ZmRnaGNINVpyRXFJSjJOQzBEUlJYb2lp?=
 =?utf-8?B?Q1M3T1l1WXZkQTlGdEZIckk1TkhEbzd3c2RQMkZPOUNlWWFJN2diNUR1WGth?=
 =?utf-8?B?RnlTR09TTEJobkRpUzV1aHZ0MVR2MlIrTWtnMG4rb2I5akh5VXFzVHEwSE0v?=
 =?utf-8?B?TmpWVnNtT3drTEZWekhrV2hzQlhaUklDc2R2Q2MzYkY2U2xwNVZmcWhiZ2Nh?=
 =?utf-8?B?YWtoTEdXZkI2WjdFSG1VR3FJdlFLbGtPbW5pbXlscFpoR1h1ZVF3SHcybVZl?=
 =?utf-8?B?YTRsbU1PTnJaeTBveE8zTmtkbFhYc3pTMDd6MW1OTmpxSGRCNlpQV0ptT1VV?=
 =?utf-8?B?UzdQVzFmcWVQQXZTNzNOY1R5WitoQ0xueklZaXYxdUkxT1BFYkJQNitwdmdh?=
 =?utf-8?B?VWtPcjh4TC94bUpUa3BDem5acXFIYkVMN1FZdHlLS1hNZkpZcE05YXBxTzMr?=
 =?utf-8?B?dXVkVGNTZC9TSmRSMFMvZkYwNlBnNjJBRHVJT3pxbjY4ejdIc1cybGZKQTdN?=
 =?utf-8?B?Q09Vb2k3Ym1LQlpxMlFlS2VwMmtGeXI5NzA2L0l3N2dPRXI0M1RsUEtXT0wz?=
 =?utf-8?B?SWE3M1c2c0NXSGV3b0d5TXBQZlU4Zld5VzJNMmJnWFlYMUFjbnRDQ3gyaWs2?=
 =?utf-8?B?bHJWUE9MWW1ldTJmWllBZktmbGNUcW9iWUorK3NNWXhiQmVzZUNJdndIb1ho?=
 =?utf-8?B?YnUzWWRVYTBOVmJSMTY1L2hkOFBxQXQ1cFdoQzBtbWNHZ2VLTVJ5dkJiYzRm?=
 =?utf-8?B?bVhULzRJc2NaNlYwZnViUkhvaWlxRzNTSFV5ZXUvM2hIMDFHQjUrQW5oMS9r?=
 =?utf-8?B?eFZHY0YwZkw5bVpRVGx6cGxTU0N3VXViRlVzYXUrMWUrSGJid1FOQ1FTTVBZ?=
 =?utf-8?B?eUJGTGlnVHovL0pFM1g3d0kxZ1J3MHJlUzFMaVRYRUtRUUZTWWhOS2RESlN4?=
 =?utf-8?B?c2cvbktra2NVTUVsU0NMcmtMN1d3RkxPL29lSW9aYnhVcHJha1YxTUQyR0Nz?=
 =?utf-8?B?UExuL0JwMzY3NlRUVDJNenVhK1dOdWxNTko2cnZCaUxNNzFoN3BYWStPeTdP?=
 =?utf-8?B?Qkw3Z2kyQ1dtcDM2aHVLRjhDWUN2eVlzT1hwQ0JRRDNKRENRSTYzVG5QUXVV?=
 =?utf-8?B?TDI3NzFhMGVUMFR4b1RkblROdGhzNnZvZHJNcTBhMi9LR2lJZ0tWVzB0TCsv?=
 =?utf-8?Q?c1MZfz3khwjfMFeCFqV5s5hZd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c86d0c8-545f-46b3-79f7-08dcc3fe8df4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 05:35:25.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPjpSzZwBqArgZRP79uPE3N+ajS1E1bZe6spYmDW0DZJ/vq6a41BdQmDBzC8M6VfMLjc5LUAfUD8sItbfZpWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919

Hi Sean,
Thank you for reviewing my patches.

On 8/17/2024 1:24 AM, Sean Christopherson wrote:
> On Tue, Jul 09, 2024, Manali Shukla wrote:
>> From: Nikunj A Dadhania <nikunj@amd.com>
>>
>> Malicious guests can cause bus locks to degrade the performance of
>> system. Non-WB(write-back) and misaligned locked RMW(read-modify-write)
>> instructions are referred to as "bus locks" and require system wide
>> synchronization among all processors to guarantee atomicity.  Bus locks
>> may incur significant performance penalties for all processors in the
>> system.
> 
> Copy+pasting the background into every changelog isn't helpful.  Instead, focus
> on what the feature actually does, and simply mention what bus locks are in
> passing.  If someone really doesn't know, it shouldn't be had for them to find
> the previous changelog.
> 

Sure. I will rewrite the commit messages based on the suggestions.

>> The Bus Lock Threshold feature proves beneficial for hypervisors seeking
>> to restrict guests' ability to initiate numerous bus locks, thereby
>> preventing system slowdowns that affect all tenants.
>>
>> Support for the buslock threshold is indicated via CPUID function
>> 0x8000000A_EDX[29].
>>
>> VMCB intercept bit
>> VMCB Offset	Bits	Function
>> 14h	        5	Intercept bus lock operations
>>                         (occurs after guest instruction finishes)
>>
>> Bus lock threshold
>> VMCB Offset	Bits	Function
>> 120h	        15:0	Bus lock counter
> 
> I can make a pretty educated guess as to how this works, but this is a pretty
> simple feature, i.e. there's no reason not to document how it works in the
> changelog.
>  

Sure.

>> Use the KVM capability KVM_CAP_X86_BUS_LOCK_EXIT to enable the feature.
>>
>> When the bus lock threshold counter reaches to zero, KVM will exit to
>> user space by setting KVM_RUN_BUS_LOCK in vcpu->run->flags in
>> bus_lock_exit handler, indicating that a bus lock has been detected in
>> the guest.
>>
>> More details about the Bus Lock Threshold feature can be found in AMD
>> APM [1].
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.14.5 Bus Lock Threshold.
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> [Manali:
>>   - Added exit reason string for SVM_EXIT_BUS_LOCK.
>>   - Moved enablement and disablement of bus lock intercept support.
>>     to svm_vcpu_after_set_cpuid().
>>   - Massage commit message.
>>   - misc cleanups.
>> ]
> 
> No need for this since you are listed as co-author.
> 

Ack.

>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 7d396f5fa010..9f1d51384eac 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -191,6 +191,9 @@ module_param(pause_filter_count_shrink, ushort, 0444);
>>  static unsigned short pause_filter_count_max = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
>>  module_param(pause_filter_count_max, ushort, 0444);
>>  
>> +static unsigned short bus_lock_counter = KVM_SVM_DEFAULT_BUS_LOCK_COUNTER;
>> +module_param(bus_lock_counter, ushort, 0644);
> 
> This should be read-only, otherwise the behavior is non-deterministic, e.g. as
> proposed, awon't take effect until a vCPU happens to trigger a bus lock exit.
> 
> If we really want it to be writable, then a per-VM capability is likely a better
> solution.
> 
> Actually, we already have a capability, which means there's zero reason for this
> module param to exist.  Userspace already has to opt-in to turning on bus lock
> detection, i.e. userspace already has the opportunity to provide a different
> threshold.
> 
> That said, unless someone specifically needs a threshold other than '0', I vote
> to keep the uAPI as-is and simply exit on every bus lock.
>  

According to APM [1],
"The VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
Bus Lock Threshold count. On VMRUN, this value is loaded into an internal count register. Before
the processor executes a bus lock in the guest, it checks the value of this register. If the value is greater
than 0, the processor executes the bus lock successfully and decrements the count. If the value is 0, the
bus lock is not executed and a #VMEXIT to the VMM is taken."

So, the bus_lock_counter value "0" always results in VMEXIT_BUSLOCK, so the default value of
the bus_lock_counter should be greater or equal to "1".

I can remove the module parameter and initialize the value of bus_lock_counter as "1" ?

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
        Vol 2, 15.14.5 Bus Lock Threshold.
        https://bugzilla.kernel.org/attachment.cgi?id=306250

-Manali

