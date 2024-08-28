Return-Path: <linux-kselftest+bounces-16564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722F962DD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA97328665D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9691A3BBB;
	Wed, 28 Aug 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MvpToPO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3E168486;
	Wed, 28 Aug 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863457; cv=fail; b=RFL1HH05jr3NRAzPI7t6ja3vJni0YsCytxlwe9nnVZPe1gj2bgzqgwE8NS//HoYExF9WzHzg2Vfy+0XIsBlv0F6NHNp8WIIH/kqeJoXC/nvHF8t745GIVipxWsrelrZXVzNlM3NNW4GKDHn4lU0QM0uPctl4qSCAyRcaJ30pzv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863457; c=relaxed/simple;
	bh=bHchQvaTDilFz0/V40L510xcIq2BUZnQCHgaKGAzM0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwHtAkB81FUOUSu9qSIWWvPUXeWEnjEuLONJpGhaujAs0JUzHNd07sfeAbb/XisiDRQto4zO0FiEtrHjTvaL1yhjT0pkD31kFG6ncRrlwKEZmyq2ibM1B52Xn87bHYUxLDiwu7TeWAyJmi0NDlv4aWxCa2BbzeOKn1z5rkmLfDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MvpToPO3; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXn7l6d1JNHmhUgOHk6eKxx8vCVD3cFxkffufR5COKhjS1D6Ws4e2ra3wmAbjCdxuBYspcrA3iQR7CYcF3y8Ff5wbNzuEdpJJSsZ/dlHOBZq5ExCAl15W1lXulHHZpIo3n8i5aZuCeBRtmKhfLheB8158u9CO50T5KeWvoxclAha7/wk29UdDuTxbgnlDiU55cFngaAa2HdeRHWVegEIuz6effySYE9fq/KQwhFynJAtFsV5nD1ffWyY7oLaP9Ff8o9cukTtP21WnQYKEfikcTiV7id2xW6HeHOodmot7/qAQ3UiY6AEHGT71NX6Dhumx7YZadzOiFPkXcePoC3rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7PILRVb/dTT5/QyKZSUgFxUxyb1CWPABpKj0kpiz+0=;
 b=DdO5u/9QR2AaEPGNfrziBPwl+AbmURHZWGCx/+tH87l/Y/eVR5cx1BqlgL6hP0dhTD8FoGLW/NHGiCwj353kAohJcSTaP407pFnex6mwLIdPHGhxXp3oW4fJwt8Qw2PE5kROdtua4Hkp+sO5SpQ9fNZD4dU2csN3Wq9Q/vgli+ZznsxCSPhjpDrRVP9GXCC4QAnKeY12sChWw+OfQgN4jGQwqdwx05ValyeGP9gjVaW/0gnvWGJxmw36l85aqR0vyIC/jfKl2sZpQIxC4kc0U9D4jjpZsK6Lay0sFFgCia/NekM/O+MwsamJDXJCo/vzHKa7AZ6H/cwgLTdypntTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7PILRVb/dTT5/QyKZSUgFxUxyb1CWPABpKj0kpiz+0=;
 b=MvpToPO3azKT4QtyiyAz7BbEbJyF3vGQPTiP3OhIw3/1XsZR7DVOsAyzEqDy4RvUF9wXPPcOdlrUU25h25ODP7S33kB1+awrNoXzfMkQBADwmtABmo99TAJhKIaXWwJE9IG2kP+SY8dqWcRcREq+MHxIEDGUdHApkWZS4JPXlsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 16:44:13 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 16:44:13 +0000
Message-ID: <7dc51102-8f41-48bb-89d7-5b82d819671a@amd.com>
Date: Wed, 28 Aug 2024 22:14:04 +0530
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
X-ClientProxiedBy: MAXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::27) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 726aefc4-9f02-42a7-b4a3-08dcc780a58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk9VMjFrR1hjMFdIN3oxWEF4QWZwVmR2S0ZSZlBxYTE5dlI0cTJpNEM5VlBQ?=
 =?utf-8?B?dXdFNjl3VmRqVEZhVUFzZlNlY0NtRXYxaXdiNUJNOWdnS2FEaitQRHdNaGxI?=
 =?utf-8?B?M09DK2U2RFJCb0dPRkcxYXZ3WjdiZUxXT3M1V2lzZWpqSEJIOWw2OWJrZkNq?=
 =?utf-8?B?WDVJRjNmTlBsT0xCNTNHSzBETEEvY0l6bHBYY3V1NllBSUxjazMveUY3TE9F?=
 =?utf-8?B?c2tiZU9xZGJ4VWppRkx6N0F0KytITFg3TzZPRTVuZXpPVlVhNEJScGRYRFpV?=
 =?utf-8?B?UzhCTkhzYUJYT3VvejhRZUxkVm1xcHNDZ3VPbllFYWhGSFZvSUN2K1dTYnB6?=
 =?utf-8?B?TS9KQkNRVzdUZVUySDRmeW8xWkJ3NWFIZ29sNEcxR09OMEcva2xiekl0clZV?=
 =?utf-8?B?TTh5bjFrU3hhbEZhdFJDblRaQjNYaFZoVGRqWHpoRlNzUXNwZW9pZWwwU2VB?=
 =?utf-8?B?Z3lSOVFXeXQ3WTRVVWRhQ1RRazQyYTFLVUg1SjcrTi9ETjlsQ3Q2YjI4emF4?=
 =?utf-8?B?V0dtVnZ4T3BxUlUzeCt5ZVlUUDgwcmNSY0Q3WFJYbzJyQVhHQi9xV0hTcU14?=
 =?utf-8?B?MTN5TnF4TUNtSUZnY20yNXB4UnVZcUtiVzZzMTZXV2U1Q2ZwT0JNTmNqYWRZ?=
 =?utf-8?B?bWhQMUt0SWlEazh1UDNZbnFuR3R3SUVTMEI0VDhKVjhKdnErN21JazY2QVUy?=
 =?utf-8?B?M29FTk9WWVl5anBybWZDYk96WGxZclNLOENwUi9nemVqU2R5RW1KYTNOOFJC?=
 =?utf-8?B?RTdOWUs2UlBZcFN1T3M4cEdROGNVZk9jOExXelB5REp5MFBramFnenc3Z0I0?=
 =?utf-8?B?NytXK2JOdnJIWTFhVUI3TklGdG9RMzJXRkJma2tETWRlNzlVWFpESGxzcnJF?=
 =?utf-8?B?RWlUL1drWFB2MGR0dFBNUjQ2RU5TWlpHRVBGQlNMUXhsbEI2RGY2b3B2cVRB?=
 =?utf-8?B?L1hUOG1JWXJ1SWM3TmgySTQ0eWRMcFJmZC9zQkoyU1BGVlp4RHNDejY5R1Nm?=
 =?utf-8?B?UGNudmdqby81bXFsdG5Zd0o4T2tSQTZNVktiOFp5M1htNGVOWWtpdjh0Wmx3?=
 =?utf-8?B?NVkyenc1SWd6TzNraFZUNmtRMWRKbE8vWitkWHdYMldFVW1kVXovQTFuNW9M?=
 =?utf-8?B?SE5XT2NuQWVOOXpRU0xxaVpIcnZmSGtaUHR5MVVXaUtzdDVTQXNxMm5qUGJJ?=
 =?utf-8?B?ZVFYVi9RN2h2cWN5Z2lwMnQ2OHpOUmplRGRqR0s4TERUUWE5YUdqcVE5VG12?=
 =?utf-8?B?ZDJSQ3BLM1gySjZNQzlJV2crdEVVR1hSSHlLdEV6WWoyc2dJd1dYU3JrOFdU?=
 =?utf-8?B?NWo4T2lNNm10YTlYcTBYVEFSUFJzTWFCV0Y1NmMyMVpPQ3BjWW8rVTFKQ3Np?=
 =?utf-8?B?ZmdEajFpSU9MdWQ3bGI3dFhxaGZBS2Q0QktkQkQ3RDZ3U1Vad2ZEY2NTa000?=
 =?utf-8?B?VWhLWXpjeTBwTXpVVy9CUkJLMkplNFMvNlIydSswb0g2MTFXOXBJL3N6T3oy?=
 =?utf-8?B?SVpCcGptSjdsaUlxVTRpbmJqU1NtWC9ZYmF6b3JwQmM0SS8ySlF2bUpUTXFy?=
 =?utf-8?B?ZlpNVGxhcU5kc3RLNUxtSTZsSG9YeVRnc01KaWVXWXZ5Q256SlhMMUl0cXZN?=
 =?utf-8?B?M1pnVEFLRkdMRjRXUS9rOGlJRmdzN0Z6all2aW11cFVJUllpQm1kaGV6MjVj?=
 =?utf-8?B?dlNzYk4xb050anBZOWtOYmlxU0NFRy9FVGk5VHNkWllXYWFSMTd6dWlKV09q?=
 =?utf-8?B?emc2WU9tRmNUVnZrOHVjQ3llaWRNbkNYaU01U2pYSkQvckJNSnZWaFNGODY4?=
 =?utf-8?B?MDROc2J6empoa0h4WUNBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXBOc002VFVKTzIzTnl0ZmVmM0toeTk3S3hYSlN2UEtxeC9CRnE4ZmF3Z3NE?=
 =?utf-8?B?ajYxVURuTnhkZ3hicDNEb1NEQTRWQkVFRk14MnZPNHBpd1hKdUdycFJmV1d1?=
 =?utf-8?B?MmVzVFkrUWR6NWxidTIyUUhiRUh0akF2QjF1em9kNDd4T2pEcWh6SFJMOGp4?=
 =?utf-8?B?cGFOb1pSYnkweVhPSk5PU29nOE5zaFVuUENhZzBScUM5WS9tcGtGQWl5Uzlo?=
 =?utf-8?B?QkxiRFkxUmZKaDRYMTJLalRIY3Nub2FpNU9xb2JrV25xSTlycGlBSlRHR3Ru?=
 =?utf-8?B?UUtkSTVrWXV4RHM2aThjbHN0aXcxdHVJT2l5SGhJNEJvMHQrTldIenVQeDBZ?=
 =?utf-8?B?aFBxcFU3RkUybzZTQ2tzRm5QeTVkVHlvWGkrUlB0am5tZ0JYNnRDcE9YTzVq?=
 =?utf-8?B?QTMwcGFhOFNUYldPd0wvVDJFdXZCWWNvYnJiM0FFZzVYS3Q4d3BVNDRpbmty?=
 =?utf-8?B?SncxVjFqQ2Z3T1p5WjdtdHFsV2g4VzZHNUwvT0hBSXpqZkFPK05QKzB0ajJR?=
 =?utf-8?B?QXp0cEY1eW9XMnFEZDV4MC9uSDNNbHN2SUNDQVdOcVd1ZkVQeE05SXFXdy9l?=
 =?utf-8?B?MllrNzB1Z2c0cC9nN0U4VmFXcDIvU0RrRGRnMHI0NnRuYlljY1JrUnVWRy92?=
 =?utf-8?B?L2gvYXV3T0ozSmthNEhxdUsrZERuZVVDQnVnL1E3dWxybzZhSGVNT3VmbWtD?=
 =?utf-8?B?Q3RlSEpkekRTRU1zcndOeDE3NXNQVURVYkpLKzRsc0FDSUlMa0g2dE5WMHk5?=
 =?utf-8?B?SmJCUDBCWTVhamR4Sk9zSUQ1OW9XcTVKWXhDUCtVb2R4ZDMrc1JDd2Q5bmE2?=
 =?utf-8?B?WWlPN0hWbDJiZGc5U0p2Y3k4SXJadzE2SlAvNDRkSW4xQkx5QXUxRzZ6OXJH?=
 =?utf-8?B?Uk95L2QwMkgzaXNhMTk4ZWxIblVoeFFKRlBlZkZwSm1qNUdoNW9PbTJLYlpN?=
 =?utf-8?B?ZzdwbGRybDhVbUdUdTZFVW95MnFCRk50NlhiZ0hGbWk0YlBMTWVVdktIT2N3?=
 =?utf-8?B?RTZ2cVA5Rk5WQld4QVpFdlRDUlpQclJDS2p0a0Q5MHUvcTh0YUs1aXd0cFpm?=
 =?utf-8?B?a3FyTVlmcmlzWE5vTFZ4TEtXcU1McFF4cU5YV1d2MFNFMXJ6WS9GVEY4eDRh?=
 =?utf-8?B?VUNrTlVRcUw4SnJrcGQ1SlhFdkxNTTJERE5RWVBhOFZzRlAxRy9wSDJHTFpz?=
 =?utf-8?B?SnczakZHTXhTSG1kOXh3V1VVZVg5bXA5UmE2MVdsNEUya1NXWHJmVFNwRlpo?=
 =?utf-8?B?aU1LS2xJbkNJYzZRLytuUU1UMDJsbWhpbkU5T05xcFg3bkhTQ1V6NkIwMEUy?=
 =?utf-8?B?T0FTejFaY3RmanMrd1JlZ0FtVnExSllHb1F1R2U1ZnZIWUh2OVU3ajkvaUEw?=
 =?utf-8?B?ak1oMk5XNS9kUkVxU0NaV0JRTWRvUTVNbHFDVVFsbmN6WFdMYWwyTkpWTWFB?=
 =?utf-8?B?UDF1R2RSZVR4QmM4VHM5cDlvNi84Qy8vT042cVB6SFpIa1ZsOCs4d0RFSkxC?=
 =?utf-8?B?Nk0xMEtlUW0zQXZkaTFoUVZaRkhCVkdQQzBQMlY2MFBicnJQZTVhMnpKaVBv?=
 =?utf-8?B?aXl4Z0d4YTBLYi9FNUNjL0FxczZYblhyd2l6MVlPYzZOdmxMRGtOVEkxQ1Zz?=
 =?utf-8?B?T05CY1ZXYjJxYzkxaDJHYnlhbVNFS1MxeHlMQTg0R3lTMG9qbVBnQXJYa3hM?=
 =?utf-8?B?SUxxY0dMd2dvOVB1SWdEOGEzZ0ZiZVFudENsbHZyZkx0ZEQyZEhnZmpEZThL?=
 =?utf-8?B?ZWJzT3B3M2I0WCtEVHVvTXNzOFBBZ1M5eVBnTnlEREdTZTFUTVB1Qnd0YUZK?=
 =?utf-8?B?RU1zT3FPZzJUZWFWKzY4REdZdERyaXZveEMzYXhkMjBDOFVVN2VURlVVdnlK?=
 =?utf-8?B?U25ZcFptUmhPTVdjQ3JTOWRuM2JJRGpBWFdFcW81b29CTEd4SHdwbm9WbjBI?=
 =?utf-8?B?d3F6OE5VUENWSTFDMjN0Q3hWaFN3RG9jTVNPMmpTWnU0Q2UzdC9Wc1F1VHhQ?=
 =?utf-8?B?SFRSRjZxWmlTSExzaXJic3A1ejMrS3FMdGx0Nk9tMDNoYUFNS3p5bjJLYVQy?=
 =?utf-8?B?V2JhdGEyTkF3SzhXYzZSa1ZWaGN1TmZpeWEvL1k3cmlVaW9MWEFYM2ExNFc0?=
 =?utf-8?Q?qZ5ECs6W4ZzBRUmF/zFZEDsuX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726aefc4-9f02-42a7-b4a3-08dcc780a58b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 16:44:13.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQOthe8jae7e2waf5GG0kLh2YQR733umcs/y8DTpgfsIxTedFPYPhuv6B/OfyxxOd5zyGyXlYIkelXNUZHXXfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757

>  
>>  /*
>>   * Use nested page tables by default.  Note, NPT may get forced off by
>>   * svm_hardware_setup() if it's unsupported by hardware or the host kernel.
>> @@ -3231,6 +3234,19 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
>>  	return kvm_handle_invpcid(vcpu, type, gva);
>>  }
>>  
>> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +
>> +	/* Reload the counter again */
>> +	svm->vmcb->control.bus_lock_counter = bus_lock_counter;
>> +
>> +	return 0;
>> +}
>> +
>>  static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_READ_CR0]			= cr_interception,
>>  	[SVM_EXIT_READ_CR3]			= cr_interception,
>> @@ -3298,6 +3314,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_INVPCID]                      = invpcid_interception,
>> +	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
>>  	[SVM_EXIT_NPF]				= npf_interception,
>>  	[SVM_EXIT_RSM]                          = rsm_interception,
>>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
>> @@ -4356,6 +4373,27 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> 
> Why on earth is this in svm_vcpu_after_set_cpuid()?  This has nothing to do with
> guest CPUID.> 

Sorry, my bad. I will move it to init_vmcb().

>>  		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_FLUSH_CMD, 0,
>>  				     !!guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D));
>>  
>> +	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD) &&
> 
> This should be a slow path, there's zero reason to check for host support as
> bus_lock_detection_enabled should be allowed if and only if it's supported.> 

Agreed. I will remove this check.

>> +	    vcpu->kvm->arch.bus_lock_detection_enabled) {
>> +		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
>> +
>> +		/*
>> +		 * The CPU decrements the bus lock counter every time a bus lock
>> +		 * is detected. Once the counter reaches zero a VMEXIT_BUSLOCK
>> +		 * is generated. A value of zero for bus lock counter means a
>> +		 * VMEXIT_BUSLOCK at every bus lock detection.
>> +		 *
>> +		 * Currently, default value for bus_lock_counter is set to 10.
> 
> Please don't document the default _here_.  Because inevitably this will become
> stale when the default changes.
> 

Ack.

>> +		 * So, the VMEXIT_BUSLOCK is generated after every 10 bus locks
>> +		 * detected.
>> +		 */
>> +		svm->vmcb->control.bus_lock_counter = bus_lock_counter;
>> +		pr_debug("Setting buslock counter to %u\n", bus_lock_counter);
>> +	} else {
>> +		svm_clr_intercept(svm, INTERCEPT_BUSLOCK);
>> +		svm->vmcb->control.bus_lock_counter = 0;
>> +	}
>> +
>>  	if (sev_guest(vcpu->kvm))
>>  		sev_vcpu_after_set_cpuid(svm);
>>  
>> @@ -5149,6 +5187,11 @@ static __init void svm_set_cpu_caps(void)
>>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>  	}
>>  
>> +	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
>> +		pr_info("Bus Lock Threashold supported\n");
>> +		kvm_caps.has_bus_lock_exit = true;
>> +	}
>> +
>>  	/* CPUID 0x80000008 */
>>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
>> index d80a4c6b5a38..2a77232105da 100644
>> --- a/arch/x86/kvm/x86.h
>> +++ b/arch/x86/kvm/x86.h
>> @@ -58,6 +58,7 @@ void kvm_spurious_fault(void);
>>  #define KVM_VMX_DEFAULT_PLE_WINDOW_MAX	UINT_MAX
>>  #define KVM_SVM_DEFAULT_PLE_WINDOW_MAX	USHRT_MAX
>>  #define KVM_SVM_DEFAULT_PLE_WINDOW	3000
>> +#define KVM_SVM_DEFAULT_BUS_LOCK_COUNTER	10
> 
> There's zero reason this needs to be in x86.h.  I don't even see a reason to
> have a #define, there's literally one user.

Yeah. I agree. I remove it from V2.

- Manali

