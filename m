Return-Path: <linux-kselftest+bounces-13596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F892EC0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2007D1F24C64
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7186116C877;
	Thu, 11 Jul 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFKqT0Y0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786B16C684;
	Thu, 11 Jul 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713380; cv=fail; b=GWaE96Zo8oPOx7YIqv41CLEwCEfgkqjaf5ddVlrazBwaxap62i6nIldkcVaPtAhC7In6dmvXWmf4f15f7R6JKO0m81V0Kb93O2Df+zf4xNWdC19M/wu5f1GH0aj4qoFbrDvfRSsS66zAluaUMO5olDNK6Z7a3ItFhaFwjCuHJyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713380; c=relaxed/simple;
	bh=1Q9IaYm5hfNSKQYYXFd9rZZevS8wicKEeZWy49aUKNk=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=WI5OheygsXYkwzzuZF8QrsD22gs2GLx54q6qtHmnkwtae1H8Qlv6Wfhco/MTYmnzlqtLVjv8EA9ntBBB+BkkwQjKnNteSFpEeDYh/XuuMzeyKx2rqh6jphNdxaxDaenguOlDTb2J8rwUeVwIgXe3BNhcVtN4SPRfr6hNYkPp+Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFKqT0Y0; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYgryylG7SBmXUtGG2PxUP1DoBpkBUaA5vUYCBh5iyzKsrJQ82Eo8/Toojrraq1RZgY0DqJM9xWjUvqylh45EWe+ybIwG4MJQv7yL/zRfisYbQ1wSuFcM1z8DuKWMVd6EOOWc8Jz9r6diPR638Iq7jg9J6Cn15bYchCtung5WOBy28hL+2mcqlU2VyQz8Xx4f9bFLdRh7ekIIOnfuCbg746pGDTaJgu9Qvtn7HtXPa7ECLM68BStGcZKWnH0Asn/PmOfzSld+xqNTT7WPd8aLsSDbuWds37TQ63ZFYGtu8uoP7Jwvk0ZgEYmrviPtQAKNdZgJjdwl9NegpkVqljkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGcPYQWIIzbnA0+CiiY9lrQfDt1+VilgCp4oHaOWQq4=;
 b=LXALi5X6w2yr3z0ci6dSw3+R2vdRhHtd2mJBm9Z30BGBpZwI0SNMyfbyvBkKICgozyyCIaaSr4murxn5XPCTYzkI7MrNyQMHlBhNMeU+4JCkKEqK2fCj9cxkPTf6nbk4dEoCCSP6xaVMj7snf2jMi9T2Q3te0D0/imlygiTouCdIugbYK1HildczQTjhxacEwZHMQxTzRZ/VHuaCrBzBlQ4KaiBsW+VE2Vjs891/+G0unuQM42cV8tnsu7+5HUPDoA07kPo4ZyvKDhDrEOMDXuFHyPXO8Inqg/0SFMUvKgAVKkIDlEBgu0upJ0ded6zX/722TIqaOqAFiv1n/JwzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGcPYQWIIzbnA0+CiiY9lrQfDt1+VilgCp4oHaOWQq4=;
 b=JFKqT0Y0JDJLkQ4rUemn4UtJR4qLqjG0QeYOEavbvC8KMOD/kFCM25JnbOj29hCD17KFnX9/Zhi8wAQXJpvTo9aup6dEJYvQCtTUmoFVC5orD5fWq+YDuOdRfpU1YZGa8Ud9zBhe6BeaBJODwvUQBEiohnztGD3flxKMY3d3WNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 15:56:16 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 15:56:15 +0000
Message-ID: <b7c4316a-1b00-521c-991a-57e1d105952f@amd.com>
Date: Thu, 11 Jul 2024 10:56:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: shuah@kernel.org, michael.roth@amd.com, seanjc@google.com,
 pbonzini@redhat.com, pgonda@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC 1/5] selftests: KVM: Add a basic SNP smoke test
In-Reply-To: <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: ec70eb10-d830-4cf6-26ff-08dca1c1feec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1MveTBsQUh0ckpWdFpaVUVNOUYvUTk0Y3hpR2htTGZwbVpsa2JWdGc5dE5T?=
 =?utf-8?B?K09pUU1CTHlhR0VUU3Rnb09mL3ZxUzQ1cC9kcTdnU3B5cFU0bUwvMXdJakFE?=
 =?utf-8?B?UE1zNHAxYmVhbGhibVRXdno3OEl5YXE5eE1UZUNZRS9kTDA2MmYrNjlaQXV0?=
 =?utf-8?B?Zm8vTDNJU1ZwM1Rlb0QvTk92b0tQZ0lzMU10Wlg0L1FiWmduTFExelA3OXdu?=
 =?utf-8?B?MHptWjhyMHBBWGNpd0tGZ2JDbWhiQllna3QxSkNGclRtOTd4b05zWEFwZk95?=
 =?utf-8?B?S2EwWWVXQS9TSllOcW9sVDRwcWJFZnRmR2lwV2FxRVRkMlZRQjUzNGFUMVYr?=
 =?utf-8?B?WVNwYitKeTRSd1ZRVCtKMWNiTXROa1N1eUN0cDlVMnQ5OGhPUk03a1VYYVpJ?=
 =?utf-8?B?V0IyNHFkWU5scGxNRElVVnBRaFFGdkRyVXdJRlRhR1Rpa1NmRW9lNHArakpn?=
 =?utf-8?B?cGZIc252RzU0THNWT2t4SnNWdGNoa1J4Nk1KVm83OW1KWjFIM3hSdDhiakJW?=
 =?utf-8?B?NE1FZ2JhTnRCc1lybEVQMUNIUnNobWFpZ3Z0S29WeC96cGJINGk4clovNlNv?=
 =?utf-8?B?VzY4bWtDeGtUU0lxWi9uRHZpT2lSSmlLTW1YM09TdFNXTFIrM2JMTXdRTllt?=
 =?utf-8?B?Mm5oZVJuN0UvNWhaZnN6R0ZycHZBRUFvN08wOGJVMVZyOUx3aTRsWlBUZkVR?=
 =?utf-8?B?WGNmYUFuUGhvdEhvSDljOU5jNzRKeWY4S0JwZVZ2ZDFxSWJpWXNpT1ZCSFNv?=
 =?utf-8?B?a3ZhNjBrM2R5ODNHaTlCRk1iWWprb1BQbzJrSkd2U1dwUkYzbGpOVnpyTEJL?=
 =?utf-8?B?a1ZtVkFWM1JuM2krSlIzaXZONWxXRzJSaENCbGVsS05saDd4Nmd4dU9ja2x4?=
 =?utf-8?B?T1NweWtmcDNuZ2phTkZPL3c2cVJ4UklscEo4dHpDNmVzVW84eTU4NkpCWjMz?=
 =?utf-8?B?Q2JBRm1iaWwvNVZQQU5lTjFwRmNHaUlvdGc0OC84cHVIYldTcVFYWUtPbVBu?=
 =?utf-8?B?VTd5Q2NuTG9zdlBBQjdVNFRQTFpnTzQ3MkdEbFpLTXZUSEw4V21yTGovMVRY?=
 =?utf-8?B?MHN1czZ0c0MyMVFZT1FJaVg1SmVsS2ljWWZ6YjNZVUVBNzdaUXgyRE1EYk1G?=
 =?utf-8?B?a04xYUFkbWZCeGcxMDRyaXgwREcwSU9qMi9rdFdjNEpabHpTNjFGMzRscS9P?=
 =?utf-8?B?aEF0dTBKc1hTWE1QK2MxeU9UdzFkNjFMejZqdEVtWlVKanFkNFUvTE1oQ0w4?=
 =?utf-8?B?cVlyaWpDOElzUG9FZytRSkhTeXdzTVpGc01OdkFhRTZwRS9XVyswci9DQnlT?=
 =?utf-8?B?K1hBeWV4MkJ6eStIZFMyTTBMVWRjRFJnNnhvNFVXcjlRR0diWTM5N1l1VHRs?=
 =?utf-8?B?TWdXbWVydzdremI4NWtJRGZTVlcxTmtaeUJYa1dzWVgzbGdJczJrZ01kNjY2?=
 =?utf-8?B?emNWaTBjanlUdzlnTFM0V1pVSVdua2w1b0MwUUNWWHZvS1ZjS2xDN1ZydHRo?=
 =?utf-8?B?dWY3YUduOUh3RFFTc1E3WXQvWFFYak1adjFWcHJPSnVhYklvZWExSlpuVWl4?=
 =?utf-8?B?QjhhUExiUnU2VktQRzM3NmNWUHFpVFJFSnJpWVUzaWwxVGZHcUhzOXFXVFYv?=
 =?utf-8?B?bGJudmxsbEc4dWJPbUFFOVkzbkNvQkJVWWpOU0krcnlwSXJ5Mm8rVW9FbXFX?=
 =?utf-8?B?eExtOE9YZ0VHblp2b3dndng4ejJWZitaRldHekZuUDU2V2FuU3ZqMmQzZmZP?=
 =?utf-8?B?d1hrcFFVMXdDcjZUSDVQZ3BxUm8wa3ZsMWxIN092enMxejlmUlJZVWVnVUx5?=
 =?utf-8?B?a1U1bUpObmwrcnRuUXd6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTk0OEJyeWhvSUxyUzBKZ2UrRkZOZ2ZsVmtwcjBlTU9BS3d6Q1AxanlHaEZL?=
 =?utf-8?B?REFzV3BNcWM0MW5TRHgrN1A1YUI3K29kQUk5M3UyVkhHbDNwZjRkZ2JJZmdI?=
 =?utf-8?B?Y3I1NnFDSGFIVmZON082bmRITXFJVFZ1a3Y4QTVtS3pLZ3NSTGhyRFU3THNh?=
 =?utf-8?B?dmRHT1JXQ29Iays1a3lWQXFBRXppc0k3VlVJYmNWNllJd1NmbWVEU2IxNlpz?=
 =?utf-8?B?dG5uMk5ZbzRsVlEyWTc0MDZkcUUxOFNSblNaUXNaQzRXMjFRRERjbFVwS25J?=
 =?utf-8?B?b1FEOWtuSHIyTjNsdTgzTmNOb05PeHEzYTBaUjhLTmovOXJLOGsrTVh3dFhM?=
 =?utf-8?B?RUVwVERyRzduYzh5QS91bXNWdDJXV3dFTzMxRFF0b21vcXhzMStKbndscFFw?=
 =?utf-8?B?akxzVlEyQi8rOFpRRFpRM21oSnRtbWhWTjljREtDZkVlVitVdS9pMHd0S09r?=
 =?utf-8?B?RG1jNlN2M3NWbGZtVjJWaXBnWm1mdys2bVBoSEZ0U04yZ1crVkdnOHB6YmNj?=
 =?utf-8?B?ak9GV3RPWWF3ODdZSUVFMEN2UVdFdDlzRFpCZjhCODYrT1NWU1lQZ3JaQ1p4?=
 =?utf-8?B?S2x2T3FSbFZ6dHB3TGhGNXNGTkV6bXBUek9Xa2hPdXY2L3lvMEFIOWplS081?=
 =?utf-8?B?cENSQU1vR0FDUytGSlpEOVUxU0xkZGJuZFNxektLREYyOFJVd3Bod3pFbisy?=
 =?utf-8?B?RUg3N25HRUM3S3IvOGRtdjZOczFzUERIK2VPK2N2cHR3VlZuaW9TcllrdmMr?=
 =?utf-8?B?eThQeTF0TVpER09LVXZtUGs5VUlqRVBnOHB4emQxYWFobUJHaHprWGIybmt0?=
 =?utf-8?B?NXc1Wk9uejB3YnR0c2h2YzhYY0FIQVhMbTJxZzZnWEExYzlRUjRjWHVkNUNT?=
 =?utf-8?B?RDdJaHUwNElhUUNQSmxPeld0MndxbXZwUmZHZms5SG5peTV2SWcvU01Yd3Bu?=
 =?utf-8?B?V1BmZXJJTlluSFNnWUdwWjBiTTQ0aTZiSU45MjRCeDZGMFI3dCtBWTk1OEg0?=
 =?utf-8?B?T3Z3bEc0TEd5bTM4RXRxZ09BTkJNd0JhdTJwMU4rbFltZ0ovcS9GUmw0OUhI?=
 =?utf-8?B?MEZMbTgzZ0pMaUZUWENzeStFdnRKM2VFSllwMVJXaDBTSUJWeTkzcWhzWThU?=
 =?utf-8?B?UUFiVmRraWRnUnhqSFdQUEpWL1VTdExqdzBPME93M2xWekkvT3ltVW5QL0Jm?=
 =?utf-8?B?c2lNbnRjMDdtTXBDV1crSlJxbUZ2S0gzTmNndjlmbGFQL3ZhSjJ6MUZlNG5u?=
 =?utf-8?B?RWlieVI5Q1ZqTE5IeitJVU41NmlrUmVNdzJaYWdRU1NTY1U3WmpUREtvSkZZ?=
 =?utf-8?B?MHI5bWdzc3VMRlhaWWFSbWRaRk9zRCtMQm9hZ0ZGYlF6SURUY2psZko3THI1?=
 =?utf-8?B?bURlOWlzcnptNHR4WTlzR3NrYjJkM25mMHEwZlIrTTVubTZKL0FPVTRITWMx?=
 =?utf-8?B?dDZFTzIzRklleXZoYzZqUm9nSTJkSXFob2xBVkRJWnJRWTBrNTRIRytncWRH?=
 =?utf-8?B?QzIzVTIwbk1VR205TFhtbkI4V1hnbTBBS2paUis4N3ZYWEFjb1h6NVBGdUtz?=
 =?utf-8?B?Rm5QMmh4TkRrU1FIM2xTZUJBNlp3cmdsNWJKYmRQVnNBY0drUkV6RUdwbno1?=
 =?utf-8?B?cDkxL3JRak9zMS81dURleGF6aGVlWnNYZno1RFA4WG1qdDdtT1AyeVVtY0FF?=
 =?utf-8?B?SlZsYXNNYUlEVDduYzlUWnZxOHVHeXZqd0MyemRwVDVyaTVlVnFDWDdPa1h0?=
 =?utf-8?B?S3N3czVJSEZVdzdLQ2JacWNtRFNpMVlIemhUZXlXekpYZGl1enVsUWdEQ255?=
 =?utf-8?B?U3BWRnkzbWhNL05DbFZ1T2M0ZHFRYjJjUUFyYkpLV0NjcUplYnhJWGhJbFFT?=
 =?utf-8?B?UmhtdXJYaEtZaEtDRFNyekJpdC9xcXVvaDhyMng3aHVWRllKY29Cc2FxalBn?=
 =?utf-8?B?QW9tdmFOaDZteHVqRlJhN3lPUXRWdmpITktjTXRwQjBNemxKd2V0cFBNSlVn?=
 =?utf-8?B?WmhEQ1hSc2FuNEVhYjl1U3AyZVBBTXpnMm1IazZWTWRLc0RwdElKYVFNODlM?=
 =?utf-8?B?ZmlvNnE3aGpFTUk4ekVQbVMwWGcwSFRSUnhSRXFTcDJWSlBXOXMzMTZtbHB6?=
 =?utf-8?Q?NkCHP2dwq6p9+uKa9mAxv5IPO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec70eb10-d830-4cf6-26ff-08dca1c1feec
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:56:15.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRMkiGQRqZe5XH1+WXcb89Y3ZFCOuHXa5xf5SpEeY5drsuBB9psNxplifcVWh8VgZoHYgRiCpfikal6TKVKMBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240

On 7/10/24 17:05, Pratik R. Sampat wrote:
> Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
> initializes and sets up private memory regions required to run a simple
> SEV-SNP guest.
> 
> Similar to it's SEV-ES smoke test counterpart, this also does not support
> GHCB and ucall yet and uses the GHCB MSR protocol to trigger an exit of
> the type KVM_EXIT_SYSTEM_EVENT.
> 
> Also, decouple policy and type and require functions to provide both
> such that there is no assumption regarding the type using policy.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>  .../selftests/kvm/include/x86_64/sev.h        | 29 ++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
>  .../selftests/kvm/lib/x86_64/processor.c      |  6 +-
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 70 ++++++++++++++++++-
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 51 ++++++++++----
>  6 files changed, 146 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 8eb57de0b587..5683fc9794e4 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h

> +
> +	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
> +		test_sev(guest_snp_code, KVM_X86_SNP_VM, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO);
> +		/* Test minimum firmware level */
> +		test_sev(guest_snp_code, KVM_X86_SNP_VM,
> +			 SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO |
> +			 (SNP_FW_REQ_VER_MAJOR * SNP_POLICY_ABI_MAJOR) |
> +			 (SNP_FW_REQ_VER_MINOR * SNP_POLICY_ABI_MINOR));

This seems an odd way of setting these fields. Maybe, instead, use a
couple of macros that take the values and shift appropriately and ensure
that they don't exceed the 8-bits each field occupies.

Thanks,
Tom

>  

