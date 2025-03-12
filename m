Return-Path: <linux-kselftest+bounces-28795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A8A5D588
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 06:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39FC16301E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F1C1DE4D5;
	Wed, 12 Mar 2025 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIdWoaiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB31D7E37;
	Wed, 12 Mar 2025 05:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757289; cv=fail; b=scw3EoattuhGQi0sBRC3TTsNiR1erXUbwHznB7PPd3Z5VH8uqh//J00wBucePyY+10cM7XwckqOwVxNknupc3KwljIfwQ8uG8aIK6RlS7VQ4juIeCoYF7A2Ug4bj+JpEj3lDUbX13dTUd9gPQqA5rCdmLJ7hJ/FtJ4AoyYrJd8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757289; c=relaxed/simple;
	bh=EvDWIK16J2AyyMbRwYduk3AcHKu4ChMEeGjVXfZ5aKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k2E0Ewg0fA0zegTEJhLOXYNP/77b8TDCrtspi7+H0Y5Ibk1TuS3pTa8BK+BwAFtMTeMjCMWahkOxc5379oEV30BkcyH0THyo/FpQmfzKoRIBayDxF0LInuZxyjlgX/bxdhUpdsTB28BWuPQMWbMGLvKGSdbNCg1tPnApvRWqLrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CIdWoaiw; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyP6U7D0Hyb1VghqMl6YRvHDDInb9wBypd9xrlMw7dIkkIG3GYsZMDcL5usO3B73Wx6+ftWGSyqYckvrqFNU0NVm/FDrMEUYUBwSk6S70hP++0O9tmruSwqfvVsaailltNKAFlppnn9HSNm1JAmpPGDIIeDmA57nSgqY9Zc/uumeoy1iWU6OjM+F2UxXQ0rQ45O9YEtBU+y8rcEr1a0E4tezlvIjnAWso3YbOw0lGIOQp2nDlYR0flxCI/CxuwkO7wN0J+Zs4rMlqy09Q3BrWL/qwy2ge4ocL8PyGaFsO1xL2r5AIUji62w9rtNHmhkelXYFNeIlXXyPo4BCbamutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZI1myXRw48vcWK0A2DoZp3YzDI3bN2pvR9zU/o6ubc=;
 b=W/kLJT4wfT1zE728z2YB5nA3rMRpzAdgiNx+R5lJqR2i3dYAbLu1TD0Ow1F44/0XiuCqoWWyLkvQWNr6PGtXvz3TWegcRET5OXKefVfEadsn/5i52XXzG6UTWGsUywbGVCbHigeJmnV5G9TuK9Eo35Y0puHlNCWr1Bwl+J1/9KhWjIqTL4hauljvLs6sZ4tzoH9ZE/mBCVP8e52+ajP22uyrTzZqINosD4jlS2F0bS2uv9wMsFG9nN6evvy2u/2Ih1edVPY+eyB7VlwLe32l8sTzKeLLbn4rz2UEhFGToH8sOlWhGOZUygYpuXA38BX7DW1SirkSqFGKixccJitKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZI1myXRw48vcWK0A2DoZp3YzDI3bN2pvR9zU/o6ubc=;
 b=CIdWoaiw4MOHIUAUXqzSePzkqV/y/fnb7ps+qwW3HqxcZ7ERJeQuu4b1+r7E7vRbWrU0ivDGLEFpXD4z0FAekg3keohnCemtbvixN8WgGMWIoK9EjAGrmizxWicWBGToKPlXH5Hods1je16vIPBUyPG5809de6fIWdy+GXEAwgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 12 Mar
 2025 05:28:05 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:28:05 +0000
Message-ID: <da17905b-f877-477f-bbca-9f9ba3483c05@amd.com>
Date: Wed, 12 Mar 2025 16:27:55 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 00/10] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, baolu.lu@linux.intel.com,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, zhangfei.gao@linaro.org,
 patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
 <20241112174507.GA35230@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241112174507.GA35230@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0164.ausprd01.prod.outlook.com
 (2603:10c6:220:1d9::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 342ce260-6cf2-49d9-e631-08dd6126aa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXNHNWNLNEc4N0hIS3ZSeURES1VHeEdjK2lMRmVoNXRRNTRGSHBxSXpaRTlk?=
 =?utf-8?B?ODZkMzFhZXoxOFBsa1JqOTl4eGJwWUExRVVlWWNDVzhxZzUvN1BQVUk4TVpu?=
 =?utf-8?B?NjNUZ1d3cHU3cThWZjVPazZHZjZMMTV6d2J6c0graXF5ZVJlREY2WWgxQkFS?=
 =?utf-8?B?bmVXeUFLTVNUUXJ4ZFJoUWsveFcvTTJIWnJ2L3dYMWtIcE9HVkxxMW5kTjFo?=
 =?utf-8?B?NEQrYkxNa1RldE1PRkVib0NQdmtKaUVSN2Nody9hbU56Vloza3lvdnVKKzk3?=
 =?utf-8?B?N2FyUzFUb1dVSm5YVEdZT2c0NkQweElyZ0NMNldFSTBDZHF4amladHRSWWFM?=
 =?utf-8?B?dWM2aCtSaTV3c3lsRmRtUHcwRmFQOTAxYnRiSHArYTJNTUZQV3VwQXAvbFZo?=
 =?utf-8?B?bDRCb1lzcjZqeHpYemcxUUJ5T3o1OGZmN2RNNllmLzdtUXJEblhaQWFDczd4?=
 =?utf-8?B?dk1Nbk0rZmllVDNndDRiVFBtUDllSmp1S0dEQkdKcUw0cTI3MUZVeG1KVW05?=
 =?utf-8?B?TkplSWI2L0ZwclBaZlIyeEEwUldkamQxeHZJRFk3ekg3RUx4b3loYTJUNFBv?=
 =?utf-8?B?MkxXNWlKeERvZnBMYU03RExXYWZoSHR1M2dSazNDOXg2Vjd0ay94K3U4QVRr?=
 =?utf-8?B?Y0tVL0NVVjhzalpqSFlyM0NvL2dwa04vUlFGdFRPejBWMVV2T0JMSFVoSVQ3?=
 =?utf-8?B?K1ZnVjQzSy9EdVdDYnBzUm9zVDYva2VzYTNPL3JBMTV5QkZGSkNuQzBqWm1K?=
 =?utf-8?B?T2daYVdYVWR5WStUc2thaDVrVXM4aW1QL3VXdkNsSURTdTI4cmJNZCs3bUFE?=
 =?utf-8?B?ZzdqRzgvWEp1MkhUekhqRmpyMXBQNUY0dlkzZXJQOGhvZmVWaVBQZTN0Um1R?=
 =?utf-8?B?SWJ0LzFDeStCSTdZM2hGRStZY3Y5QThrUDJQTmxOeWRodFVJeVJJTXRmY1N5?=
 =?utf-8?B?VzdUNURMMzUxVEJnUUlvU01ML3ovWmkxNUp4RDlFaXJDUVZZNGt3VDYwZWZj?=
 =?utf-8?B?R0JtTUt4bHE1a24xZTFiVzRVWWNzZktoK1pFVzZWYTBCM3FTY1NxYTdJQjh1?=
 =?utf-8?B?NzVVNXZPaU1vTFZ4MElyai9hK0RRSjh5RkJkZEFhc3M4RHFPbU1zd0Z1anBx?=
 =?utf-8?B?SmVVWDZCVGZ2RkhGZUNMT1pBVTdyNitkNmpzWGhpWDZlREpxM2x4Q21YanBX?=
 =?utf-8?B?L05mellwTW9TcXQyL2p2WG5iZHpBRHBVNDVuL1hJUXNDN3ZUMEpScTQwUDJu?=
 =?utf-8?B?WUYvRm8wNUJUZmhTRTBTZ25DVk9ScFZYQ0oyRUJUY3dGWGFWeG5KaVFpU0Nw?=
 =?utf-8?B?YktmZ2QzeVFiVE9OMitzOWNVMlpUNXVkNUNjbFVWaGxJcEgzbTNwMEZUdnM5?=
 =?utf-8?B?bXpXakhFcWNLUFh4ZUhxZWdDNHYzaGUyK3lnNDZ5NkFSK21MeEVvazJpMUI3?=
 =?utf-8?B?cU50bWVuK0Z5bVpOVmZjMThzM0Q0RzdPQjFjeFNWUmtSb1VBTHAyYWlJeWxO?=
 =?utf-8?B?SnNSLzE5eUlQU2UwV09CbzErT1ViRnBadUlYSVk3eDMwWmFWRHFWblBBT1BP?=
 =?utf-8?B?RlBRZTJ2OUVkYjBQK2VWZVNBa0RxbDRGTDAvUmY1blBCelpyQnkxMVdERGxZ?=
 =?utf-8?B?OW1XVHRGWUszbHRxcHFyRzdhRGFmbXpDb1RoL1NXTitmYUNVTEZ2K0FINUlV?=
 =?utf-8?B?Wm1RTmwzclFSNzIwai9sRE1kSlJMUzc1YXdCWTB0VUZDbEdtT0pmUXpleCtT?=
 =?utf-8?B?d1B2Q3d3Q0czbHAybFNnWFl1eXBGdHZJdmROVTNyQ0cxckZLT0V3akRYTTF6?=
 =?utf-8?B?aGZnRGROTTI4ZUNPY2JMLy9hQkJkR0wrSkN1UVJqZndLY2xCT0k5Q1VJbU10?=
 =?utf-8?Q?tJ81akpHsKoPq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmpNSDdsRWNpTkg2NWg1VXEzMjFwYkdUQnZaZm5FenliditsMU1HQ2wzTmdx?=
 =?utf-8?B?dWJZRy9RanNha2pIRmc2RzNyV2JGNG1XdXV3eVBHbjBTYzVGUkNPdHpjNm1w?=
 =?utf-8?B?NW8zR1JYbXpYRm92dGQxWHFRdUhYTURWRXdOeUZLaG1qcVM0ZTZMbUR0V1NG?=
 =?utf-8?B?ZEwzbXV6K1lYK0xtcG1OQWJxSWUwN2h0MHZPRE9VWVFTNzVXc1BXYU9NRXpt?=
 =?utf-8?B?SW00a0JQNDhtOEt1bzN6QkxtUVp1YmtLRVIrU2svaUFuNTNmd1BFNUZvVkN6?=
 =?utf-8?B?bVduK0lESGpNRTNVWWJ6YXJJV2tNR3lrQkYza2JNcElRdkNzSEh2M0g5SGgw?=
 =?utf-8?B?YytxVHNrLzlKMXlaTzBWcFBIUTJjRndJVVYxR3ZUZDhtSkRyWmR3bFN4VEMx?=
 =?utf-8?B?WUpaS04vUWNGcGg5eWlEUS9MbUx4elMxOU9ORjRndGZ2TmhqNzhiYW5CVXlR?=
 =?utf-8?B?V0o1ZkJPL1k4OVoyakVLd1diS244WUhrQWN6T3V3VGs1NlB0aGdweGE0U044?=
 =?utf-8?B?RDllVHV4UmV6Z1lUZjVQc0YrS2RnSUpSdDJCaUkxR3ZHcTFVMDY5NncxWGpG?=
 =?utf-8?B?emsvRmttNkJuVmYvMXROSFQ4a2RlVFFyekpDT25wakRkZFJGK3lFKzJNQVp5?=
 =?utf-8?B?ajRRT0QyREZXMGZIYmhXQkc3dkdhcWxwQWxwaDJRQkpGWEpQelQvbWxEU2p3?=
 =?utf-8?B?cVVNL3hEQkl1MmZaaTFIZ0daVVpMT1dzSWtZaTNRcVUrdXBnLzFUbUY1Wkc4?=
 =?utf-8?B?SGE3enFOaU1XVnI0RXg1QmhwQ2RpV1FDMVRHcExJRkpTaGttbllvQVhUeWdO?=
 =?utf-8?B?TExKcVp6dDJXdkZETW1qM3dOZ2JJYS80eUhLWmlQZUZxSW9vaTIvVGsyQUky?=
 =?utf-8?B?NldRdzVHa0ZDb3NKMlZOejIxdmJyN2E5a2lQWFJBWGF4K1JKdHE4dkd0RWZK?=
 =?utf-8?B?T2dabVJqVTRaMm1jOE93OUkyL1JqYncrRDczZXVSRUVsK2VjQ3RvcUlvUmkv?=
 =?utf-8?B?ZUxSdjN6dEdnUUtaR0FRMFk4MVJvelkzMlErNjYyRlFOd2hTckxwbE1zRHNG?=
 =?utf-8?B?KzJqeGw5aElTWXFQS3VIeUVpd1FSYWQ5dFp5dzhKcWwreXRVaUhHYWoxV1dn?=
 =?utf-8?B?ZWdWYUJhKzQ4ZGZQMExIQ1EyYjNqeVIyMUhJK2tZOCtGckV4L3ErOU5Qazgv?=
 =?utf-8?B?VlRaOUFCOEdBUklpYUpPTXdOTW9FOUwwMGdjemRjM0plRTJ3UGlwYTNqNGtR?=
 =?utf-8?B?T3VGTFo3aWlVNmcyUy92dGhpSWlPK0dVZ0hSNi8xSGlPZDVyeG03TFhpZ2s5?=
 =?utf-8?B?aWY3UFAvbWxhSnhkeE5uZUMyN3djZnF1Tnp4cGdNYTNZeC9WMjA5VmlmUXc0?=
 =?utf-8?B?bGUvSDVDcm55clh5WExxWFM4VGl0Z3o3UWJkOGRtSk5xT3NrcjRqbWJWWVBQ?=
 =?utf-8?B?ZU5yd0lydWhubDhBMThnMUZidHF4QUdWbnZvam0rK2FORUNYWXhOWDQyNEJT?=
 =?utf-8?B?aGJSUmFTODEvZm9DTkxTODV1RXdZRDFDUkRCakF1WitKL3RONFR0R2RMcTcy?=
 =?utf-8?B?bVZFT1NEM1pWd0lnRjRVOUVrYk8vNjI3WWM3NG9IanBQMGY2NEhWaC80L2Fp?=
 =?utf-8?B?bHV6Y01aVit3VGZvMjFzYlV0WlFWTGs1bHE4MlB6bmN3M3ZUSU5zcWlrNEF2?=
 =?utf-8?B?eGUwblI2UDd2SjRKMjZlMjFCRUlJWm50d0pLWm1YWloxN2FEY3o4TjVZZ1Az?=
 =?utf-8?B?WEVkblBPZHFFVlZRL214ODhvdnJ1RWNLNXFDVVBLMk15dWRlTmpUamQ2UFBa?=
 =?utf-8?B?RDBSUUdMbHIzSnJaaXJkT1JyemNwWjl1SmJHRFNwWXpIeExvbGFSWVdmVlRo?=
 =?utf-8?B?S3lpM09GZWdQdDRVU1JuS3dHU2xKVVpaTlFUTllPWDlRTVFMcEVxRExLc2Zh?=
 =?utf-8?B?QnBnNXFKTFJuU2FrbURML1RJdGRqb1V6c290bzdpZ2ZQRGpGS1pIbnJSc1RC?=
 =?utf-8?B?eUdkRzlXVzJJczFaTEhlM0lUUFk1VGJ4ZzczTkxWU0hNUHpMalJEdVYwQUFM?=
 =?utf-8?B?dW9WYi80QTRNc0F3anA5YndnSGNadWNQM1hQRTJDcEdxOWt3YmlGRE8wVG9j?=
 =?utf-8?Q?rGT0O3K3YbC2CRH60Hr616GgM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342ce260-6cf2-49d9-e631-08dd6126aa46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:28:05.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqNkkp2rrdKs8cByCue16bxKO+RkAxmVF7qD2sVy2h3aVUR7bWo9TBEc3JKABJQBMGWg7dV0KHZqTPNBrxzlWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B

On 13/11/24 04:45, Jason Gunthorpe wrote:
> On Tue, Nov 05, 2024 at 12:05:08PM -0800, Nicolin Chen wrote:
>> Jason Gunthorpe (1):
>>    iommu: Add iommu_copy_struct_from_full_user_array helper
>>
>> Nicolin Chen (9):
>>    iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
>>    iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
>>    iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
>>    iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
>>    iommufd/viommu: Add iommufd_viommu_find_dev helper
>>    iommufd/selftest: Add mock_viommu_cache_invalidate
>>    iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
>>    iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
>>    Documentation: userspace-api: iommufd: Update vDEVICE
> 
> Applied to iommufd for-next

Is QEMU support coming soon, or any WIP patches to try? I am trying 
d0375b6e85be5c71 from Nicolin's wip/for_iommufd_veventq-v9 for now. Thanks,


> 
> Thanks,
> Jason

-- 
Alexey


