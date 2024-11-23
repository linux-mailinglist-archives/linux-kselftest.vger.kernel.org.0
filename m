Return-Path: <linux-kselftest+bounces-22466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C739D67DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 07:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD0161021
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04B15CD74;
	Sat, 23 Nov 2024 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pk3AhrIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D22AD04;
	Sat, 23 Nov 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732344177; cv=fail; b=jgkemwUCJqOdlu60aQEFpmtYal/2ALyw7QNH8HZtfMSnm4fiujOvRfNoepe7++RI1ns7M+ByGnHTJncIzBjq/76OEQpUb/Ujh3kGJBBaCJWU1EmTzaX4p4OU1JEIcm7GYAAwcipbBf5D2Nby/lxD/QgAu1ZaLzEHtrW3MKejW54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732344177; c=relaxed/simple;
	bh=t5tVVdGCLP4qPaewpNyuz9b5hw/ZEQREb6Iz7YOlIJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IAbrNyrmtATMAqfCuWUJKM1rdzBb7IymqeJD2r3P+XWkkR9boFCL4snT1MfPkfvIgVMWT8FE77fmywEzZJaXrqfDI1ojrqfQu1FCgXfteS6GsEwfULFAezfTZvlUWKRbGUDBl1qXlF1keG6hUF+Oul0wmV9d+IqcWACxx5pkMtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pk3AhrIp; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOzW5Q/eiyjMbGMjLzSSN6jVA+PDyiyVKynUYyZ2IGyfMjtvb+7Qr3yeoASS7wyd16rgrzVTSqbkM5vWW42AEez4+ER5guAKvcNe7sbv7sWuka0O49pYUxLqC4qKEB5schzrb545bQM5Zs+6k7hK3iffLSX/zXCQRMa1+m5IiMdYITLvnr8CPkxsMBTfcco/r4+/+ztSEHBxQechOEmy6/RSQwytNqOO7te2a+q+vPJg64BE3O+9qIyUx3oo6suGyXh+TQDGwnSf03dRkUUasTm6jcWQrx6xOHzNOJJYwpP01INJBfKrsr7Qohhoych058/1z7MHFQWg4P42xFrQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PUXYGeAM+mWtDo7yziN1mX1Bx1OuV9UjluQPkUltHw=;
 b=uZNl06is6pM7z+BvH7rUxZcifW4tpwq7MHwJc+WyeFE+0EW1haFYSXUhfsIHuzT4IoG7reihGEWhemtTL01skuqDNfCZjKD9vXc+5auhzHDbQul3QHrJRXEkAarLFoWh1667E0qEENlCVnIKRMgo/975PH9/EogMkbiRtVwaX1siO1KoCHPjRmqoq4Wj+pMDTxOC59F9PtC1wq8K+KvkomXpQCGm2T9gPvWdl7XFK4vHq7nusXEIIlEqk1ownOk4TR4FodK+yf4t60YHNAjME1TVSpTCvE32Il1jq76ecliJctd0o0CYwoIcQtK4XHFQAFNaa2aS2mRdIMKVM1G+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PUXYGeAM+mWtDo7yziN1mX1Bx1OuV9UjluQPkUltHw=;
 b=pk3AhrIpYUo2M6jRYdGpBEMPK+GVTgi8YO5EW2Z0SAPLlDgri1gErWNMt+NN4L/DuknVgbSyChQ3l9valRgzbQZfNuoPbHquu24LTN0EuLHvgELv5Y2NF/p8HvbE1ovwp5nVqjWqh7WO22bVXkClJG0ZIFrGwU5GtgyW1W4Z+mfHsIGo3V4Ox8K4Gtowoffc1MkPX8O7TGjVHAxaAnScoegnokhCN/bHR+Bn9VT7G7Pu0uEEIM9ffs2D8gikerWUJ81pcBef3/JPO17mSZxzuu3wLhxH5YKym4kYnU1Pne7uuBjtvzSRg4zXkGN4kFVEi4fXqFSRxKXmdlxhN3gB4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Sat, 23 Nov
 2024 06:42:51 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8182.018; Sat, 23 Nov 2024
 06:42:51 +0000
Message-ID: <54aacb25-d7c8-40b7-a926-03716c0010c8@nvidia.com>
Date: Fri, 22 Nov 2024 22:42:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/mm: Add a few missing gitignore
 files
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Donet Tom <donettom@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20241122074612.1582161-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241122074612.1582161-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3380399f-d559-4325-87cb-08dd0b8a0d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEk3YXVGMG5GK2dtLzYzNW9LMy90YmpZNGFhZitwTE04M2dkeDE3aHh2TE1E?=
 =?utf-8?B?blAyK1ZmSkdhVXdIMVRNdGdTSFpLOXduOFdZVXhRMHVHRWkyZTVzTXFROVhi?=
 =?utf-8?B?ZXM4eWExRE4rRXhGMlRBdU9KWmJyRGw1NU8yRFpGUmN1ZWhqcGFuZnVZeGUr?=
 =?utf-8?B?U0J2akRqeVNzOER5NUVDK2UxVk9VS0o3ektkZGZsVG5JcDZSc3FVS0QwZWxW?=
 =?utf-8?B?QUJSV2pUd3NmaXJjeVNpUUdMZVh1R3YyL0pwZUcvYW81ODBHNTFhUVRTL29J?=
 =?utf-8?B?b245ZFBSblQzYjIwZERaVUo2TStkMmI5ZTJSSmZ5RWdta0o1Ry9iVS9WZE5G?=
 =?utf-8?B?NG5IeW4vRzhHR1FFSWJ2cGV2WjJsTW5ibk1TSmNkcDg0L3M5MzVYS1JpclVo?=
 =?utf-8?B?TTlUWG1uUi94ZjBhMm9XLzNvSGEyRkk1akY1eG5MTEpyRlVCdWxMdnpVSkwz?=
 =?utf-8?B?UEs2dTQ1dGRQclc4a2QyTTNtMi8xeHQzTm9RZVh6WDBIYjdXaGFhY01Hekx6?=
 =?utf-8?B?d09NU2QyL0VQRXEyUmgxYWJqajdINnhjVlZKVmZncWtnZEtOcE45aUFncmJJ?=
 =?utf-8?B?YVVQSk4vaDdRUDY4M2dDTiszY2hVaDBrNWJlVENFbC9GSFZKbFUyNTEvTCtC?=
 =?utf-8?B?cEtyTzcrbGJHa1JQc2wwMFpEY05hTUc4Q1I5QWFqV0JYOUorTjdKSVNqZkJi?=
 =?utf-8?B?VzBHNnBFc1ROU2lBNXplTEk1OEo0Z3hId3ZkUEtkOVYvRDEwUUw4MDdWUENF?=
 =?utf-8?B?SUsvOVlEM0EvNitHRUJGamVPY2JWa08yeTJKNFRVRWZVS0VQVWhSV09MQlpN?=
 =?utf-8?B?YXI2WENoMXMrV1RSTXhBSzJGWVJla09wbERwcVRwa0labXF4Y3B2MTliTURj?=
 =?utf-8?B?VUZEbENtV01RVmRtOGFtdXk0R1NWRWZONUdKNVQvV2U5OTQxaHVIVTY3VTlU?=
 =?utf-8?B?QWZyRklRNDdFZjFEdW56cXJUaEpDbDZvVmpab083N0U1dHdxSUV3ZVFrYlZW?=
 =?utf-8?B?Q1l4VnVMenBjV1czZjBGc3JjOEJ1M21BRzlrZEo4U1kwTXN2L3FaanMwZHBj?=
 =?utf-8?B?ZlE5eXV0NXNQZVZHaXQ4ZkJyUWJGNzNBUnlHWENZWEJZQ0x0Z2k1TWxROVZR?=
 =?utf-8?B?aDZVa3Z1RUV1aTlMUWVGck9mMHJzRFJGdk43OVkxbTF4eEl6cDZuR2E3V01V?=
 =?utf-8?B?WXpSWHZITHgzbUZkT1B4SVRPOEhGR2RPSkRVL05iRHhJT2pvU2UxdDg1cWVC?=
 =?utf-8?B?bDNCTE4rcjkzRmtiK3B0K0tFWEVWTGt5V2wrbWUvdDJ2aTBJd0pzNFNTWkl4?=
 =?utf-8?B?ZXRtTitLSGYrM0hUcFlnUGdpcm1QSXNOekZqYXJnTG5EdFg3bGhUOXlJd2Zx?=
 =?utf-8?B?Snd2bGZQbVZJdC9wUFl0Q2w5ZUIwS2xJTTducEt5OG1TaUNtdGRKdUs3QTdq?=
 =?utf-8?B?QXBqTTlMaTNsR01sTkZUU1Q1UmIrSDF1cDYwY05YbndYQ3N2R3JLUm9vcWZG?=
 =?utf-8?B?TTJ3Z1ZUekhhSG82MjE5Q2huTVBEZWI1K3VZa3lqVE9UR3JuNExXL1JWU2h1?=
 =?utf-8?B?MXdueXZTeEFVcUt4NHU3WEhmTHR0ZFFzdjhhZnRKNnk2Qmd3MTBzSGswd2pX?=
 =?utf-8?B?MUJlTDU1R2k1d0crUGRTdW03S1pUa1ZGVE8zU3lvWldjRUNXQ2t0V0hqTElQ?=
 =?utf-8?B?TmxEKy9pZ3FmaVQ5bjVEMCtwa2Z1RlJNRnBjNWI2Zmh2S0tCQkMrZ2RQTmpz?=
 =?utf-8?B?ZVJlY1hKbTlsZFAwSDVqTVdrYVhBVlFVbHJ3QVNvQlpRanNGcXBEVmNjVFhO?=
 =?utf-8?Q?Zy36KYkieo59iaQUPM4gM1pZaAWqY4PeVtJ/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHJCTE52cWR6NUU5U0tzMEdxcGk5bURiYnI5eXVzalVVempqejRJNHR0cUhl?=
 =?utf-8?B?YWVoSXJWNGw1Q2J3UVdHWmo0SWZMU0xOUFpJODV4bG5VMmtKUG45MnBjdHZU?=
 =?utf-8?B?YVc0NE5lMEhPb3I4bnNCajlZc1U5c1Vnb3NFLzZSQWZHU1BaUW9tcU9ReTFK?=
 =?utf-8?B?Q01IVDcyWmtiZkFFdnh4ZWtGYUxTMS9PS1drNDJ1dXRnSUNRejJyeFRtSjYy?=
 =?utf-8?B?bHdkOTdHQmlzZnlMOUdldEp3QitrdzBzc3E3eEtSUERsTHd5cTluQkRBaWZ3?=
 =?utf-8?B?ZTQ2QlJ1aUdqdzhNZGVOZGgrUGVKbDNuY3lRbzZoV05mUjFPTllkOXRhdXMx?=
 =?utf-8?B?YU44R29NeUdSbE9RcFYyd1pKZ0g3N1RQMThqeS85aDNuMklLbVRIaitWQy9Q?=
 =?utf-8?B?eXdOOERqQ2JVTC9xQnhYZ1V6cjFCU2ZGVldwQTI0eHpERTh6NXRRZ0lscE5v?=
 =?utf-8?B?dU40OHUzckwwV0VTaUFGblhBRTl4L3ZqNC9GUTdablF5eXlSOUM3U0JEbG5P?=
 =?utf-8?B?ZWxQS1VvWlBuV1dsNjFJc2tTWlRFNCtDNm5mamtXVGZXMzhzb1UxVWN6bFNr?=
 =?utf-8?B?K2FLZUUxWGcrUFAxQVkxZEtMYUU1bjZvVVhRckxxN0xTbzk1WGx6MnhsbDdp?=
 =?utf-8?B?Qi9saGc0eWtQVWZwNGZGcG9sOFFUNmZBanc1M21oMURuRURKa3F5eWFlb2lB?=
 =?utf-8?B?d1UxR3gyZSt4Z0FJRGwyNktFVGN0TnFHaU1SWlVPSzF4bUVuK3BFY1c3anpz?=
 =?utf-8?B?YXJrb3pDdmZLTTgyb2pqWkJNOEtoZGsxRXZETTE0bmwrNnc1ak93ZlAxWXFS?=
 =?utf-8?B?UDJlRW1HRGludlI3MjYwU1JqZDdmcHFMZjZVdUhDcllpSVEramx3d01xMW8r?=
 =?utf-8?B?NThDMWJSdnhudmozRjlIOUNwUnFhcW9hMVJHbGdUOEt2aWx3amV1dUxkUnpJ?=
 =?utf-8?B?ekl4M2d3M2cxMTBKdnQrak5XUHZNaDhHczNoMGlUVzNJM283dE8zUXV5T3Jp?=
 =?utf-8?B?VFYxb3A4Sm5HeVpBMFdhTGxXUHo2N1VGZUVxbXExTGJNK01sMlRWZ1RGYlJ5?=
 =?utf-8?B?SFg1N1loenlWT21jWlhKc1ZCdHc5aW5PMk9rNFV0TkxINU1jLzkxUis2aVBV?=
 =?utf-8?B?SVhJaFZ4SnVZcjRLQmxVWjh6SjlHdm1ZQTBQUjM4Yi9kdDFyVUV1c0p6bFRh?=
 =?utf-8?B?bVZTYUE3cFM4eGs1RU1vSnp4YWtJUmN3SjlIcFJCVmRKMWx5cXQ1T3FFY2dr?=
 =?utf-8?B?VlRZcVp1b0J1NTVybk43bUlmQ1RvTmJ3NHB2MmRwRHg2NjJxYzJYK0dZeE9j?=
 =?utf-8?B?S0dWcTRZTUd3aTZOSzhUNXg3NWVvZ2JNeFJYdk9KWlRrQ3o1YVp0b2UyODcx?=
 =?utf-8?B?NWVkMW5yQnJLclpUVUJDdzlkRGhuTnVCZ3M2SjFEQUgxVk40TkdxcyswUHp6?=
 =?utf-8?B?MEQ1SXpjNU5naHhLK1VMd3A1bGREcGt1dTRQVzVadm1ORW1pMXhheTVUTGVL?=
 =?utf-8?B?b3VBT2plTmUxdndHMzdteTRTeEFmb3ZUTU9qU1lWYllmTmtZV2JrZFFtZC8w?=
 =?utf-8?B?R2xWT3ZSTWRxN0pQSUNnbFlYU2NNSG5nbUswNXF0UDBVdzNkSHdFYjhkMXZh?=
 =?utf-8?B?SzhMVHpZMmxzemE3aDZ0Zm5lS1RYWlUzdTlyUDNrZ3NRMkk2U1gzNUNKQ25k?=
 =?utf-8?B?TmRBb2ZoNFRyMWJwOFk4VWJiUFQzc0RZVVMzVHhlQmgxMVVlR3hRR3FkWlA0?=
 =?utf-8?B?bzY2Q28wWERrZFhZZ0dLb2hCL2tqM2kwTFJleXhSOEZJRFZHbngwTUQvbEZF?=
 =?utf-8?B?MHFFSE1wVGR3YURJMWZyb2pPRENNMDZlZkdadzdaVFk0L3pEQmk1RmZQMy9Z?=
 =?utf-8?B?OUZiQ2RUNk5aK2JKSXMrbGY4eWI1dU52TG1hWEZTQ1ZiK2tyendlOU9iYWsv?=
 =?utf-8?B?S2JkVEFRSDZ3bXROQWEzWkdMUUVlOFlML2E1WWNXaE5UOXpUN0FnU0E0cm9q?=
 =?utf-8?B?WjRIMCt5SEdlK2dBSVljU09pRHA0QmxFb1VkcnA0SFdtRjJYRDRVT3FaR2t5?=
 =?utf-8?B?Y2c2TTUrT2NiY05Bcm5ZQkw1T04zV0tyc2syU09UQitRa0t3WEhqVnZJQU93?=
 =?utf-8?B?WWVRdUNtNUhDS3pJd1FPZ29LRkJ4VDlxQUNyNlQyMW5Ga2FMbkVkUU9EcEg2?=
 =?utf-8?Q?uIJAnebHZZZtL3LFyNZup8o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3380399f-d559-4325-87cb-08dd0b8a0d39
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 06:42:51.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54ze8P4HJXu2QJV+rRft+6d7dXjGzV9zUmLzeSuakSt0wZGaO+D0CwhVupCS3EN0KkJs/NqTYSdO7b4yykgoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

On 11/21/24 11:46 PM, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 'git status' complains:
>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>           mm/hugetlb_dio
>           mm/pkey_sighandler_tests_32
>           mm/pkey_sighandler_tests_64
> 
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Cc: linux-mm@kvack.org
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>     nothing change, just resend it
>     (This .gitignore have not sorted, so I appended new files to the end)
> V2:
>    split as seperate patch from a small one [0]
>    [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> ---
>   tools/testing/selftests/mm/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index da030b43e43b..2ac11b7fcb26 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -51,3 +51,5 @@ hugetlb_madv_vs_map
>   mseal_test
>   seal_elf
>   droppable
> +hugetlb_dio
> +pkey_sighandler_tests*


Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard


