Return-Path: <linux-kselftest+bounces-47199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54814CA907A
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D738D30AF554
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5812397199;
	Fri,  5 Dec 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLn4RIkY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01539719B;
	Fri,  5 Dec 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960791; cv=fail; b=S8Ju4Hqd9SkmKPXhyMOBNkGNeIa5BSIdRmwsaqbtjvBNfB2ap2J24QXyOEAztfJR+ppfFHFfHkckvG+ZvfoPrhAban6HVwRABHxVvV6FHe5o5PoTQWAUmIGpaHo5S3Udz3KbjXoB44BocFfVLcjXr4Ya3n3uh6rIcY4ijwraXxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960791; c=relaxed/simple;
	bh=RhNFmK6FlW8PNKH65EwND83T6G68lGh4+NUuMMWeDuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=adM0ZI43KcPvTo6KkTS7Scooy3b0YCDR5jIrBiCNnfhSxEYV0Bmck3XKWWfqQ6zK/1YvY5vjzWO4VpkHEjyLIlXgd7P/FrSObFx9YKSeIrCpey9DocQueFNvmaCZ2f7rIGo8tlf7NJeX7AiKnq2I8+dkekGnJQFy7OYhmu3Upto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uLn4RIkY; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwxUAWoZwCzr6Yjrnxo1xj7/GblhjGvgvSphpVkJO0ijqaT1E9Ny8QagTDLK5F9FtKJle2Kc67jZTdGSiEgu/s8YykHQRt08VF+umlbhahbzx+1rrZAvMn5sPcWrksCEv5GfQo/rVXpn4gqdwasPmiccO7ij/XLS6REnP9ol2GcBejGeX7W7N0r7OcjI5NEE5qhvHlLqhV9qpiUAuuyDf84GXOZIKYHaXb9aVbUB468sn9TlB4b5pLN6fL5cGThnjGv9JKPpvbOTMQqza4dVL63Wzq9w0/jKC/K/ZfK1E3JF+ZuFEyvmY59+YNf3BEe9R8tYEr5F08jt0KJqVOuuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HokNEAi9PkZpPmsahnF67Lf5GRkw/V9sFOBAMwud+I=;
 b=jw8ynDedQj3G04OJ9RSt03YvumK6IWQK1C4va11RpzQfdsN34p9wcEvu6QhIz+D+E00bol4weE7J2gEwJX/ZRz5USh5lwmsPoK4SWcVVKArZBKY0ufqnKKSDEGpvwgR4Lgn1Lhq8EwpbY+7WJVYjiz9tvUS8h/OnryH3z69oXWdav82cNJiUtCE63OWPJuUxLWhtUgVTU7haQbCg0YCBtWWs4x77PEp9YRxe+RvppOTEkSTfKQxgfAppaHTpHl64Sys6pa9HEsDek0ohQKzKDkKLqdzFrUVc0KHf+3i60vFkJU7rf/Gq6Yl1UkrX/kiFuL0guOSBXeplhSH0QxBc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HokNEAi9PkZpPmsahnF67Lf5GRkw/V9sFOBAMwud+I=;
 b=uLn4RIkYRoj06k9SxXh1uNOZrtbM2nLoTi6JA+1BpI4DhCrm681OrlKUiCrAsEebo6DHMu8a04DMmJSA17s3CUhTaElzcPtEauhBiBI6Wj1qyNBruJVd5jF1/5+SnKD4rvo5LO/Glg3wjTfg2SD7E4oZR+nkR+4O1HjNzGcsQiFXr7bGT9saO6GodU5r4a1//K7AbRencfbZ8AYIRsBQJ4mfNzkMOUZpAWn4TqyvpIM4SsWXCjfmyDYE9wzdla1gYWD3oPk8G9k4kSjvQcHwbUg6J8UfwIWYPa7h2t3bICRXtuDMl7WYjkIlwH8jWuyTMrI/cNAs4TaY6AZh4kGYZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Fri, 5 Dec 2025 18:53:02 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 18:53:02 +0000
Message-ID: <00ec47f1-194b-4d85-8c8b-3200b918e1d3@nvidia.com>
Date: Fri, 5 Dec 2025 10:53:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/resctrl: Fix a division by zero error on
 Hygon
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-3-shenxiaochen@open-hieco.net>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251205092544.2685728-3-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9330cc59-cd02-455f-7a2a-08de342f8477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXlIaXhDRGt6VmVZYkdVTWlDeDVhMFdmNnQyM2FLbGtxSXJod1JBdWVKalJ2?=
 =?utf-8?B?dkF1TG95N3hMSDN3ZmQ2ZDcvcFFBMWhVbnB6U2hickwxaFFQUVV0cnlSaDBm?=
 =?utf-8?B?TWVGTXBYdlZVSXg2ZCtkbmRVeXBpZjN0RjVLOHBQVVQwaHhYTzMyTFpBL3hQ?=
 =?utf-8?B?YlI3WlFBaHZkYmh2U3dCSkpBc1IrT3YwR01RenRqdjVXYTFaNEgvSjRBOVYz?=
 =?utf-8?B?KzFTRTFoWXUzSkxrRUJRR3ZNcVdnR3FaYWJad1dhSnUrNmpEUDdjay9sZTM4?=
 =?utf-8?B?Y0EwMlo1L2hUTDUzenhtZWRqZ1hMSEhpcWllMC92NWRTWElmTm9jTWkyRTR6?=
 =?utf-8?B?WDNzdGlFNkV1MnpjdktoSldiRHFDeGJqMU9IVElBQlEwdnA2VDB0Tm9GVjZN?=
 =?utf-8?B?RDhjOVJqek1iSzY0S0dCVFAxcWMvZUJFZldnVU1yQ3dLTUo5TmJQTzc3anAz?=
 =?utf-8?B?blI2R1VDTWNrU3RLaitEVWFLZFBETlJSK3FFQktzdndqOWlsTWxNZzk3d2FD?=
 =?utf-8?B?NWpBWnZBLzNVRGp6a2VoYXMzUEJHdTBpdlpDT3RkVTNaNEVQUHBhUms5Tk5K?=
 =?utf-8?B?ZkxvcTRLVmtZdlhJUWdQODNpMnFIKzFpTjIrMkJkQ08zZVR3cUxBUHZmTTFs?=
 =?utf-8?B?U1J0TlQ3MWJCeHZLSWdQOEtpWUpUWmpUL2VLWWVvSWgxYUhQQm1nZnlidGVj?=
 =?utf-8?B?RG5BMDE2MjRmc2JPMmtVbVpSemZMYlRNSTRJZ0ZQZWw4bWdpM3luRmtwRVJk?=
 =?utf-8?B?OFdndmNNMmppWFNFQjRnTlRlWkZwb2poTUgvMGJCaVZUTUMwOEw3Nkg4NGw3?=
 =?utf-8?B?bE92S2U1TzFyN01VTEdJbUFENTFhZFZFalRnVFIwMHlYQXQ2SkdKWW9lUk9n?=
 =?utf-8?B?QzExUmtjUVhPZnRxUGVyR3dwc2dqS3Y4VHErTW8zYmJ5ODVLVWlLSEFLTWpH?=
 =?utf-8?B?alQrSnk5dE9Xc0xEc1FGQmtUM1ZQRWdpTmxNZlgzQTFCcDlZc01KaVlBS25C?=
 =?utf-8?B?Mkg2bG1Jbzl5MGVHVHVxUHBFWmNlNlZveFg3a1J1UmtHZytaQTQySWhyUTl2?=
 =?utf-8?B?cWpudHN4K3A2UThtdExsNXdQVWUxK2JTcXFDQlhBM0FQcFpTdlNjeHduYWt1?=
 =?utf-8?B?Y3JpTTJOazBsR1hrTWlzSDIzRmFIQlllSGVzNGFuR3hmMUFtOWpCVE9xdjNv?=
 =?utf-8?B?MVZ2aHJJOUxaTFRRVUNlaUs2QkZQOGxCclArbHNNM3YwclB4bk9CR0dWcDMr?=
 =?utf-8?B?cmdBby9CRTdvbnJ4Rk1nQmxQaWpWZEFUWWNrYmRCWWFwU01nQ05xNDVIT1ky?=
 =?utf-8?B?cFZTVURPNHprT251aXRUckRhZFFoTHlsdm04Q2F5QS9YRXI5Sks1R0lXUk9l?=
 =?utf-8?B?dWhZRFpRck5QN3FFQUFYWnJSQW0vM2J2SGxDT3B1RWlPNWdUb2x5SEhxVGd1?=
 =?utf-8?B?R09hTE1WdUcyWVNxYloxMnAyd09pYmRPUExsNEQ3eVEwVzV6OG5YT285dUZS?=
 =?utf-8?B?RUpWTFJ4T0FHRGNQQlFEelJvREVKbTBiV2J3QVVNOTBqcjhpczMvYTlma3N1?=
 =?utf-8?B?ODV3QUFubFVBUDkwUUtPckovNTdhNzVaeDJCamRWTG9ZQmtpUmhjMU1UVi9I?=
 =?utf-8?B?TG0ySEsvbTZzRy9vUk05K014aGUrVmovYzNuQ3RUaTdQMFpDVllvL2h3anNO?=
 =?utf-8?B?Z0kwYThiVjBucTFnUlNVdTBTanoybmE1d0FDVTl1b3pja0FQRnBWSnMrMjNM?=
 =?utf-8?B?NTJ1ejcrNmJLbWZybW1VbitiUjJ3Vjg4djVnWXhIT0tCR3BPSlNPL2ZlbTYz?=
 =?utf-8?B?L3lJbUxxSlcxdklXdGJHQm9oWnBTUFV4V0dWSHVXamdZRG1RR2ljOWV6TDFF?=
 =?utf-8?B?Qmw3dlk0VHVUeUVjd3JXNnUvRXJVR2Jud01pSnhmeVBDdk81QlVQQkFiVXFs?=
 =?utf-8?Q?EO4fHylklyOhPKrVOe9Meg6Ysh+HQiX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFBuYlNBeXpCdVVSNmN6Vi9JU0djbm5zRW5YbzNubFF6SEdRWFUraGI1Ymg1?=
 =?utf-8?B?RmgyVWN0WW1LS1hBcFVuSUFKWFBpSDUxZU4xc3JWUTNtVEd1OVl4eEdvQmx0?=
 =?utf-8?B?RXMwa1NqR0hCSUxCR1h0VWU3N3dMcWd4RkltejZDYTR3NzRocnBsbWlVR2do?=
 =?utf-8?B?OE1FRm9oTjFtMlppQ3JSWGxybU1uWG9IWmtRSGd2OThFTkVFOUlIZWtCZEVC?=
 =?utf-8?B?bDRrQ2ZyZlNJQnV6Rm4vUGU0OW4wNzRuRzM5K3c0ZktOOC9SZkw4ZU96ZUY2?=
 =?utf-8?B?R1JtRk1LQ2lHMWJyc0RwUXVSN09LUmNpZnNaanBlK1RnL2x3RHRiYjBNY1M5?=
 =?utf-8?B?ODBuT0JhVCswY2hTT3VGSEZPNm5GcndJTmxiTXZvZUorK3lIK1Q0M1B0dlhk?=
 =?utf-8?B?QS9jRWlRMUNDYkVuQWM4N3JQYkhoZ1JqU3FjRTJweDRWUisvanNtd0VKZExM?=
 =?utf-8?B?ajdZbFI3Z3pEVjRHRkxRNXZPWHQva2pHSDRlTEZLOVd5YWNGKzBiS05EN0Zu?=
 =?utf-8?B?V05YY21iU2JuTTJmVGYyTElqNXBwczRxWm9iK0lpakVmNk82amlCTFdRazA1?=
 =?utf-8?B?SkxtY1VSMXhWanJ1WExlOW5EcExTR0lIYW9HOFpvSEQ2bSt0N3lNNEN0bG1W?=
 =?utf-8?B?aHVTcTNxRVovNjMrek14alJCL05JY0RMQjRXblM5RUVnVmNTcEtjYTRQbjFH?=
 =?utf-8?B?S1V5L3JudC9CZVdSNGpUWEZyYURFaTh0d2RmMEVIVHhIeDNNS0JLLzhjRFZ1?=
 =?utf-8?B?c1dqMEltL2VIU2FaQkxGZmxiREJzbkY5Q3ZSVVRNaFZIU0szcHpkTHdlbXZt?=
 =?utf-8?B?R0xNWHRzQ0pYdUpiSnB1R2tVbFJFU0Rpd3NxWWRWLy9FV1M1V0hGeDU0Rll4?=
 =?utf-8?B?RFNKZ1VMcEZyakZadjBzYVJUTXNRQUZvcldSMnB1RUY5ZW5TR2VqdGd6WXZh?=
 =?utf-8?B?TUo4Tjd3VEhtNzhQbjZmZkNLNzRNVmsyMWRzU1ZRaUdwVG9nNzJxWnREL0R4?=
 =?utf-8?B?ZnpEcCtGY2FYMEIyQmJnbFVmQ1pmNE1nYXdFZzVFUTQzaUp6Q3p1aDA0Rzd2?=
 =?utf-8?B?NC8wa05TcVUzUFlPbFB3TGluL3BDOE1tVk0zL2dtVVVaY1JWRE8rVkJxZis1?=
 =?utf-8?B?MG5iRTdPT3lIbVJpNGVvSExxNTlzZUZSUmRJYXZPVWRteGF2eG1KU1VPR2pG?=
 =?utf-8?B?S3I2R0FjVmNzekRHWkp6VWlhZnJyMzBCVUlPNzZtMkJQZlRIRXZVbnRyUk8w?=
 =?utf-8?B?bHFIZHR5MjIwQ21NanlwYjFnLy9wOVVrdHlaRGYxY0Erbzc3YkhkUjhGZ2RU?=
 =?utf-8?B?Z1JkdmRzN2VMU2x3cmhETTdYYlh6VUNJa3N2Rm1CMlJydU5MOXZZTHJFY1pB?=
 =?utf-8?B?MmcyeGZZbGppQmFpeTBYQXdZZGZOUmlsd2I3NGNIWTI3Rm0rT0Nxa1RFRGYz?=
 =?utf-8?B?QXpXOHFpcmN4U3hqN21CeEFISVBlV2MwdFE1ZkIyRDdCNWVjUFdrVmx3UVFv?=
 =?utf-8?B?YzRjdWFYRTlJck1GU0tjei95cG51eW1aOHR6V0ZydU5oS2J1NWYxN0MrQTZk?=
 =?utf-8?B?ODhRdmhYZ3F6SFc5Q2xOQ1lvcXBSSnhJWVdJK3B3OHFZdVI3RDNyRHJXdm1D?=
 =?utf-8?B?bjNndnZ0aGFNVlFzUnZJU2lOYk5neDB3U2NZc1d2dUsrVkVtR1ZpdVpGWThZ?=
 =?utf-8?B?TVF4cUk0SnY2bHlmT3JYaEppWXBScWRnZXJrRndBK2pWT0h2cndSOVFmK25U?=
 =?utf-8?B?VXZObE5VWkFERkFCb1NHOWI2d3kyb0wwTTNQcGJNQ3MyL0Ntem9nanpiNWlZ?=
 =?utf-8?B?K0pVakxFalFuWDFxZEREbEVYTWJoZUlXZXpRS1lpVlZyUHZ1blBmaVBhTlIw?=
 =?utf-8?B?N3AxbFNtU1o1anZTK2pza2krTDJORER0OVJRclZMT2FZK2lGV2FNdkNpVFFq?=
 =?utf-8?B?UzV3SC9tTUcrQ0dEWmhlOXRBTFFWWk9CNGVYZk9OUzZFSFJhWE5KMzduVHBT?=
 =?utf-8?B?bXg4WDRaYWdOQkxJU3JJTHM0VUUwenc2WmYyQ0ZFMmdWSkVoTjB0Ry9jeXdQ?=
 =?utf-8?B?QXMxYU43V2Robis4dUFWalhBYnpIZXB4Y2xicVpSM1ZINmhEdkRKdDlYcHd0?=
 =?utf-8?Q?8dys2tl48kf9HDGIywstcni/5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9330cc59-cd02-455f-7a2a-08de342f8477
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:53:02.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvSnzL3mBVaauJW6cqL3xQDRRfshdZaiCRIwIRO5yNEewtcK3avljDPDVZJqZJGpLMSlJMV9+OColgFtLhWNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

Hi, Xiaochen,

On 12/5/25 01:25, Xiaochen Shen wrote:
> Commit
> 
>    a1cd99e700ec ("selftests/resctrl: Adjust effective L3 cache size with SNC enabled")
> 
> introduced the snc_nodes_per_l3_cache() function to detect the Intel
> Sub-NUMA Clustering (SNC) feature by comparing #CPUs in node0 with #CPUs
> sharing LLC with CPU0. The function was designed to return:
>    (1) >1: SNC mode is enabled.
>    (2)  1: SNC mode is not enabled or not supported.
> 
> However, on certain Hygon CPUs, #CPUs sharing LLC with CPU0 is actually
> less than #CPUs in node0. This results in snc_nodes_per_l3_cache()
> returning 0 (calculated as cache_cpus / node_cpus).
> 
> This leads to a division by zero error in get_cache_size():
>    *cache_size /= snc_nodes_per_l3_cache();
> 
> Causing the resctrl selftest to fail with:
>    "Floating point exception (core dumped)"
> 
> Fix the issue by ensuring snc_nodes_per_l3_cache() returns 1 when SNC
> mode is not supported on the platform.
> 
> Fixes: a1cd99e700ec ("selftests/resctrl: Adjust effective L3 cache size with SNC enabled")
> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrlfs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 195f04c4d158..2b075e7334bf 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -243,6 +243,16 @@ int snc_nodes_per_l3_cache(void)
>   		}
>   		snc_mode = cache_cpus / node_cpus;
>   
> +		/*
> +		 * On certain Hygon platforms:

nit. This situation could happen on other platforms than Hygon. Maybe 
it's better to have a more generic comment here?
		 * On some platforms (e.g. Hygon),

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

> +		 * cache_cpus < node_cpus, the calculated snc_mode is 0.
> +		 *
> +		 * Set snc_mode = 1 to indicate that SNC mode is not
> +		 * supported on the platform.
> +		 */
> +		if (!snc_mode)
> +			snc_mode = 1;
> +
>   		if (snc_mode > 1)
>   			ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
>   	}
Thanks.
-Fenghua

