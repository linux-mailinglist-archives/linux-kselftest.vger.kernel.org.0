Return-Path: <linux-kselftest+bounces-10945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0998D52BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 22:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF621C23D17
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83B18641;
	Thu, 30 May 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUvvHbiz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71006187568;
	Thu, 30 May 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099287; cv=fail; b=WVdnAJnpedNpSnj6Pde76bo5IwXjWSq7SsADnBDUINHZC6AkHNt23lEq08VA+J3frW/j5D7obyNz8UGy6u98AFhVULMRUr+UB8nHt2i8mkG+yJJ7zMSwh3XlezAUitmRRS/3JVVTBTJCoLeJag6W+SOiIi2+vGlpKC7rF2WT4EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099287; c=relaxed/simple;
	bh=Y7+vOYW4ms6RPFlI9c+JZ7BBYzOjQOsGfbCytqeRigc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i62RTwQ6VcgApQcQBaVX1AIj1KK3L6W2RFXQNvVPdbAcwIRDh/mGdMQH9pV94RUEtpwJg/QPHCtSSpsPRPAW41devkT9WxxVv6AU7rkjY/gORFv4l3ps9zg6sIR+byYP6/OS3VgkK6oEeMrxyA186lBBi4HvYPvQ8QObHGHdhWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUvvHbiz; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOQkJPhxjV+ChyQ7SHsAywkq7f/KOKCRjiE5PfZa2FYqpOSdNUHh9ZPTUe1KrnWcq0KxK5uN09ZR4KbMJwbIxDO03GkOo5ervowMURvJVcDUITfdalrXuhVJABcrMSXK8BaXDYf19NM6g27ep+SEVjPrm2B3URp1zF5k+w4y/WYkwK6HM211FazHPgGwF0qZy/RFDbGqcTS8pDYV5If05Fb70GJ+GCssugVQj5xIIKiVa4AVNZMYQri3e4VbSQSpqFdlrs57Dq79KNOd3pG6/nE2xtdD+omIrBINyGgB85FL92Q+nMKC+SeuQPHTLlPzWv2BFLuY/CHX6C1spTBl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtWPGXp9XnuAS0HH6kPm1UJimL4sdW0f+8ock9KzBbI=;
 b=KqCKxeDP1JkFOPttpoqJ3Ro9+aBrLoFTQQan3WB/mIQqEv09HOdAAFZDapPldKQFV8D6E1B4r84J1qGdFZsMlUs+Sz8YZ0en+pE0GtucYzMKODSeNNhpgfNXqV5Xb5ooxAZuZj+VTYh8Ixt5mN1VAtxWJyHjNWW7EvldEtmIJWK5xuBxEugLq+w3rMFsYM40befn/jymSVEQI1j7JnpVfhHQWZDMETrILwbSCkCRMhSs9DAz0KxuegGFID1mCd7/ZJ1ZO/PSjTkiknZfCpLlaENAAXDRV1M4nnVRAP8YOx8qoGj8SdeoEemx4tNTykYBc9I7hHZ2Rt+xQz+TMpNWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtWPGXp9XnuAS0HH6kPm1UJimL4sdW0f+8ock9KzBbI=;
 b=IUvvHbizrId46X7Dy4YhCwn1aTqSw5SQcgA1fXEfa1WX9sQiZiVE5+QjaJJcBQwVvw/bpbkG0VRlEQ+tEqQFaHPfze1jdPiY3bl6eNMldlyYo5KILMND82nfQR8hxIS1XBgAB9SgEIkJ9etVipE92W2BJHkKhtDwsfM9aJYT3vx7DJYO3xmEBEO8hxeQBj1qsgu5vMmJ4pUMqPuncdVeBktWm9iRJnb6a5FY/wae29Sa3/Goi+B+QKP0gBWB0ExW6uISys/0TzTB09ySyFJy8hIlPNx8au2RNJlyGVO/Ti4amRmKnAr3RnGALyN0A34hILPitxJ2xf1axSupgQIyCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 20:01:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:01:20 +0000
Message-ID: <44428518-4d21-4de7-8587-04eceefb330d@nvidia.com>
Date: Thu, 30 May 2024 13:00:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] selftests/x86: fix build errors and warnings found
 via clang
To: Dave Hansen <dave.hansen@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
 <4d2c93e8-5ab0-4b28-af24-c00d57f359fe@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <4d2c93e8-5ab0-4b28-af24-c00d57f359fe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ea9a66-b5c1-468c-58f3-08dc80e345e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE82WFZNUzFBMGVHWDVTODdpaGpyZnNiNzZ0Zk1ob1Z1djJteXFPeTZYckR6?=
 =?utf-8?B?WGJscTR0RjhQbUp3WXdQSkU4dnRNZDJxOWJ2Ujg0clZ3R3JoSEJtVEs2MGt4?=
 =?utf-8?B?Vnd2VWprS1NMRk5rbWYvc0xnM2RIQVlmbGpDYkZPeUdqTEMzRmxnRUl3VmFJ?=
 =?utf-8?B?emJkdHNYN2tjbHFFTHdUQzdJQVhKK0xJZVdnVXN4a3NjNWt4SmYxcndacjRP?=
 =?utf-8?B?QVYzRUl4RmNzQm9pTG5BbUFiV1RiekJ3NUs3bnBiajliN29MYm41Y2h6cEZM?=
 =?utf-8?B?OGJwYnIyYnIwazNiRGYvSGdzT1pob1d4SHNBOGYxNHU2YWp5M29FMUVNSi91?=
 =?utf-8?B?Z0g4VEhOMFIyR3dKOEVKWTByZERlTHBRaXJXZmZjN0dQSlk5Zk9Cam03SWR6?=
 =?utf-8?B?c3RyS09jQTl0bm5URUMvOWx6N2U4THRaNTF2TDhyWDd1VllvNUZDdG1hUzJk?=
 =?utf-8?B?bEpvTnZxNGhaeWhrUzdnbDFGL1QyRlJGUHBkSlZsaXJHUExjcmV3aWVMaXgw?=
 =?utf-8?B?c2d0T1ZJNi8rZVVCSVY0R25hVk16THZOY0JwSlFPZjZBeVF3NFliQnIwOWhG?=
 =?utf-8?B?MExiU0NuamZ3dElmbDh6ODdveEV0NlFyUFhhVjB2U2FSbnBNRDBmQUFtM3Zv?=
 =?utf-8?B?Q0ZiLzVMZ1VacEFweHl0bUluRG1Hek9RY0VPSmQxTXhvQ0I3bStkaWx6cm5q?=
 =?utf-8?B?dHNyMGZsc0FhSktVSUEvVW05bzAxKzJoWUg4SzgxdjBQbGtJYkh0QjVMOU1v?=
 =?utf-8?B?SXVBYlJiV0NiNkoyRG1UdnFvN1ZvelUrdGtFUENWOFQ5N2YzbSsvYnRwZFJi?=
 =?utf-8?B?SjBUOS9ob2hqSExjNmluR1g4VTh6eklMU1NPcW1YcFZDWkc3UmF0Mi9sS01C?=
 =?utf-8?B?WEhXMGZvbXNPamhvYkpHVEZOSnBKK2hETTQvOE5wZzc5R3laSXhSRldvcHR0?=
 =?utf-8?B?dnVPdzl6RVdIQlFLNmdXeWJGRE91QXdjdVRGd3ZSOU1zalpOTnRUbTZFWEJH?=
 =?utf-8?B?QWYySXpQci9qcDBIdmNJanNsMDdKTnJBNEdpVllyWW1RRHdXcnlzSDNUWENE?=
 =?utf-8?B?aEFvajVURk4reE5pOU9La3VoRENZbnp3WmtuOHRRQVlUTldwdW9CbnphL2R5?=
 =?utf-8?B?NU93cjdEeWJCOG5SWFR6UG4yS0JwVzdMQ2dZNFdLOG83aEdkYU5EdUYwVlRi?=
 =?utf-8?B?U2V2a3RNa3h2VC9YL0VHV0JFeEE0eXhhMlBKbHlyeGlBVjZNeEc1ZFF2VGlq?=
 =?utf-8?B?ZWpzR2pHQ3dvNTM4djFsYjh2d0NLZlNlQm80dHd1bnd3eFpTRGJOVU11d2xn?=
 =?utf-8?B?ZVhpcjdYcXVINkNlL3U5MXNkdGtsWFRTSi9udTd6Tk5VSnp3bTA3blh2b1h0?=
 =?utf-8?B?d3cwSHFpN1dMV0F4MVE2NzBkVFJ5RDNXcWdKbTlaMUNKdlJrZFVQNksyMTFn?=
 =?utf-8?B?ZGZSWW9vOGJQWjByZzZXYXFKaVVrS3RiVjlSOEdZcUIyMTZONHBad0VKQXpj?=
 =?utf-8?B?OERmOGM3SThKWGRBeWlVZWtmRjYxL0dOdHEyNzBpWTRXdWxWTWNDallid1B0?=
 =?utf-8?B?N0doc1BkN1R5MGVodE5FazFvYWdVdXptZzZyajNXM0hxMWVldXljZUtQaGJL?=
 =?utf-8?B?OStXRHB1d3EwSTBXbXNjRkhHQ3YyY3lFOVYrUXcxb2N6OGhTWC93c3BTN25Y?=
 =?utf-8?B?MURwL25mK3hFdFpWdCtGME9oaXlPVmEzYkQ5ak40UnloTHFVOEhRZXlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkhaTFUyMVhyWGhLNTc1bmk3WHJPL2svNHRUUy9OelVzSDZySThOUEF4SHhx?=
 =?utf-8?B?dnYrQTRhbjNkZUpZRlRDZ2lpcGdVOVBxTnhiTVBjYW1CUzJtbXF6OXFzajVH?=
 =?utf-8?B?em51b05nL3lvK1Y3cWZKUk1YUWtYcmFxZk95QVJWTHp4NEZray9qb3lwRXlo?=
 =?utf-8?B?dUpFcUZnelJRL2JoU1JEdEMwMWRobEswYnFXZy9Xd2o1RTZqbDh5VDZNOWtR?=
 =?utf-8?B?NVpzQVlkZUJBT2Q3b2ZVaENuSmhHdld2WCt2aTljWWtDWURjNjdHMVNqNEtI?=
 =?utf-8?B?NDRHUjBmeTdrNW90U1dJV2tKM2RQSG5sSVNBVGdmSjI5V2NkOHUxWG5Sc0l4?=
 =?utf-8?B?NUVhRFozd1hOZit4VVNNRVpPRDZCL0Fna0NVSENrTEpNby8zVXE1a25vMGlL?=
 =?utf-8?B?OVJIaGlMcytmV3ZEVUpXMnF2bzArMzV4NHlZQTRqd0MvZGo3NlNZSzNKNnFJ?=
 =?utf-8?B?MDZzOWlNWVZoMTZubGNhZktMelRGVDhJa0E4YVRMWmgva21xYzVwcmd1aDJX?=
 =?utf-8?B?eVhsSERTZi85VEE4RWFMSmp0QUtIS2gvaEZxajU0S3JyMk9sTHRRejZ6aXVK?=
 =?utf-8?B?QlNpRTVnY1RIZ2lZWG95ZjRvQmNLT256UG03cWI3blhMbGpXUTFMRllBSkxN?=
 =?utf-8?B?a3hvajlwS1pUUWpCcEc5dEJ2TzEySVR5V0RkNkZHMFNTNEpRNXRVbG1RRnMy?=
 =?utf-8?B?TzJib0Zic3FBR05MdVNUYnpjNmVVaUZIa3cyaUE5aFVMNmhvQ0kwd3F5ZGVm?=
 =?utf-8?B?bHJpb21DUkpveEJiOWlIN25IV2s0SWUyMUZtb0JLOHFRanJXSFBkZjl6eURt?=
 =?utf-8?B?bXJGNDlXQm1JcVlmeWh6ZUFLMVRaY2tCVWh0Mmh3cml0Um82dzZyeUFGZUhr?=
 =?utf-8?B?TndYUE8wb1RGNFFFTUNNc09OcHU1ajdGQ3U3U0lNaWhyQjRZOTdGVE1GVzF4?=
 =?utf-8?B?bzFoUno3TXpwelB5Znoya3hNaHp6YTlGSjRzVEYrdmVQWXVNdFNWWGg4aDBD?=
 =?utf-8?B?TjZZWE5SemZjMmM1TGw4SWt5REpCaXNrQkhJM2ZEZmhscEFscTdNOStRNG1E?=
 =?utf-8?B?elNlcWJ0SFdYZU9Ucmh3ZUw0OXZqTStWVUUxRTZ0UHYxNjVZWHRZTE85cDlK?=
 =?utf-8?B?SEpKZ3RDdzNTajYzWEdlYVIrZDZ0cU9LY2hTTThGNlpyamxZS0dqd3F4VDIw?=
 =?utf-8?B?cXVmbEVIZXh1U1BnYldqQVk0Q1Y5ckFuU3djdGk0ZFBEUUVRYTFMZllOcmpF?=
 =?utf-8?B?RVZyR3F0YTMyVWw2ZVQ0eWgzbkZ4N0NKNVVHRkhlSWh4WldWOWplQzdZMlZ0?=
 =?utf-8?B?TTlUUXB3Ly9XUVMxZHJKWFdsQXpJWFNMWGo2Sk1sZTRiK1FyV0tIZEVoQWly?=
 =?utf-8?B?ckhUUUwzMWwwU01TMG1ab3labzV0TlRXeHdxbTdza1dIakFZV240VkxleXFK?=
 =?utf-8?B?empuU3dZeElPaXNTRDZOVEwrZmZTbENJNU8yajFOdTlqWXNBRDl2VGxFdUly?=
 =?utf-8?B?N3g4OXkrUlRPdGc0K25MQ0dIa0k5YTFCTU5iaXpkRlhPTGlHcU5BdFpDcmM0?=
 =?utf-8?B?VWJ6MFQ4OTZSMUZ1R2tncnR5Rm5MYVJBa2Y5RDF3Qk9NVzhUWFVINUJoeE1o?=
 =?utf-8?B?d01NQlIvNmYzMjZRaHc4UVd3dnhROFdrdzkvWEFzdFk1aDNhbmtjTHM4ZE1X?=
 =?utf-8?B?NlYwVGovdjVUSzRrZW5nb2I0THpCRnphWnJVOWhGamRyZ214RzJtN3NFWDF6?=
 =?utf-8?B?Nms1N3hQYm9MdzU1dG53Vk9vcmhXSHlTVWVCWExHMmNBME5qNlFiTzZ6MVZN?=
 =?utf-8?B?ay80M1RObzVDYk5uUlpLeG9obHR2VTdKalUwcDlvRjFKQlAvMVBxRzlJY1dX?=
 =?utf-8?B?aEFDeUFyRGE3TmFuL2JlU2VMRjkzWEZpRjNBeUtua21PcFBSQnJaUjUrelFM?=
 =?utf-8?B?aWwyenlHNWp1TWNOZ0IxVkxoM1BYWmxRRHFpZ1FmV2pzTFBBRCsxS0plYWJW?=
 =?utf-8?B?V3NlUFNQOEhIZzFNcjBQS2xuSkRLOElzWEVodzdoV1NoMnMzSW4vOWdyZXlJ?=
 =?utf-8?B?eHpHVXhQV2U5UVpWZmljMDBuNUkxYVptU2tCd0lONzB6YmlHOUZTaXByK2p6?=
 =?utf-8?B?WlpsaUYwcEN5V1lhS0dkS2NubE9nRjNLU25rdVlXMDdTcmNld2NoU0VWOWlW?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ea9a66-b5c1-468c-58f3-08dc80e345e7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:01:19.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0o1fPCgL9AfL7UHel96oj342jmccKv+1cuDcaNi5EMXlV30tPceIY+koHBdukCx7RoNmGt4RGhRiegYLkpAkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

On 5/30/24 12:46 PM, Dave Hansen wrote:
> On 5/27/24 14:00, John Hubbard wrote:
>> John Hubbard (6):
>>    selftests/x86: build test_FISTTP.c with clang
>>    selftests/x86: build fsgsbase_restore.c with clang
>>    selftests/x86: build sysret_rip.c with clang
>>    selftests/x86: avoid -no-pie warnings from clang during compilation
>>    selftests/x86: remove (or use) unused variables and functions
>>    selftests/x86: fix printk warnings reported by clang
> 
> John, could you and Muhammad have a chat and perhaps settle on a series
> series that gets acks from both of you?
> 
>> https://lore.kernel.org/all/20240501122918.3831734-1-usama.anjum@collabora.com/
> 
> I had Muhammad's in my queue and didn't realize we had two overlapping
> series' bouncing around until now.

Aha OK. Muhummad, after looking through this, I see that our
test_FISTTP.c fix is identical, and that's about it. My series goes
a bit deeper IMHO and completely fixes all the errors; the tradeoff
is that it is more intrusive. Which I think is appropriate.

Would you be OK with my posting v3 that uses your patch for
test_FISTTP.c [1], and the rest of my patches for the rest?


[1] 
https://lore.kernel.org/all/20240501122918.3831734-7-usama.anjum@collabora.com/

thanks,
-- 
John Hubbard
NVIDIA


