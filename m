Return-Path: <linux-kselftest+bounces-6253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B546878E76
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3886283A0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 06:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335A2E3EF;
	Tue, 12 Mar 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QtGhVnJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B602B2D7;
	Tue, 12 Mar 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223830; cv=fail; b=sqCK3HJgvTJ71JY2LnznpKxiQEEAjzOjWvq6TuTGGxuL5xhGehH+87SXwHvS1GLanobUEEiRIOfHdyvC2H0Nat9wNjBzSeunTHjFSTkb6/Ghcy0SP6izQyY2dXDh95nNIe7HUS40f68Ltvpa1YaTEvE1iDU0nObyQyAXFpOAUsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223830; c=relaxed/simple;
	bh=6KK2KMwRCAAo2+6eIQv1NSeYlZbpxK2+ckkeStPD1Nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tP8stDlmMcYnr2Jrkev36w0zO7X97ykIgDDTmCnubqwKmGxnZ433JhaPCpA9zGoR/WTyc7n+fnOqUjTCmu4oK+qbmd1bm25Ph3942lyn2frztvAH9PHsZIS4eHwybLN6Bc5/l6ociVpehHUX/6ZEHGLzvbqZL2kyY5RJ4o0uZNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QtGhVnJi; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWgoUEgwn8yKdFvCpAOAxCeByxWLn/msJooDpYuclzoDm8F2O3U1bHynJ9kb48/4cWiHoU+34yMVqCYjJ+/q/Bn9aywX5OP6y5MZm6XiTXjENFvPTfHMOeJWhnhuelh5LpqBwUEMSfSMACnvwZbPGJSWierge39WFuZagsRbYycY7NVjfqGoltji9WHmJ9FhKpms7rA2OR03J03wiZs/l+1NvGSWUzcKYlBPeiF8mnyuRSQUcgcfBfetJ9W7e9KLbN8TT5J/YlJO9qUoyjzEnQan3naMD/uy0r4d4kySVnOqrUUlrv0PgNyi8MnA/feyfTnSQr2D97DzmeeFBMqv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egfBgn+aEH2uM25GXjfILXKwfKFfHmqEEa1dFMUTvME=;
 b=S8IZk1hhR+xSqThuFvDOw8N1MGK+xaNykeOA1rHM4i7wsEmkP7nKg4A+tcS2TjT/XuOYmZjNoqW+1llFM/kmCvvKaTpIpgivjLpEreTKKwRUufcjy+xyxylSRRh5/SlT6eUHgI74CPZ3tpleecMZn7EPPnh8ndvZIJ8b4m0L8IXseHYfG9pj/FkbF6/H80zFa4GDfEaPZgzHvIVUJFtpspjwhx2hcQuTpzjmiY04wq5SViV8I30DTWjrmcLUnO6WmE2e87xC6yjATFgCmFMVShD/ArUqZg0TMyC7XkEtLSd4oCHnivkU9CZFfQW2MOxr770ku2TxX2EyHg/hODXk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egfBgn+aEH2uM25GXjfILXKwfKFfHmqEEa1dFMUTvME=;
 b=QtGhVnJi4lgXx18KMEwm8iYVVUf+V/nT0ycu2tX1N3EHHtd2kNUP3aZay1UxHx7HDOiVOMXma9yEPJ7YQycRP9dYYiZG4f4nkihyg7AbqoBB0m54xboQaO2JAgHoM3MOKEe2bYlYjRkYvgyl3yfBoSJ/W8v7QFk85a3raAntJwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 06:10:26 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 06:10:25 +0000
Message-ID: <dab3019d-b5e6-6141-6efa-43dd113cbbf8@amd.com>
Date: Tue, 12 Mar 2024 11:40:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/5] tools: Add KVM exit reason for the Idle HLT
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 Manali Shukla <manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
 <20240307054623.13632-4-manali.shukla@amd.com> <ZenPdRGYkf-Y-MgD@google.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZenPdRGYkf-Y-MgD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: cfaaee4b-9804-4308-4c76-08dc425b1bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w0OXoZcrxyDmiPr+p03vE2Dno69DBBJHUwn20/5uAP9hGePq4ek//emRjrpYGlT4n/orzHBYVWMMmzXOFKEk2kbN94bF8G9aZHSy7KO/eo5jHW1cPAlIMSkZiErno6wY99xwmgmJvpxlj1bCreAmI+WSzpuKSKdJrK9TCa/WeDojIEFpR9gCIrahgshEO5ObM1Bg1YW0E1A5JLCV8lRefx3bfFXX/PE3uJ8wfjpzvyCru4zi/oX+TCACr1Eid4A/0NlopcwUGHnB4xxSGhF+BS88qn5BkNLlR0YQyCrKM1iq8+4vPCqrNjoHO9YBzJbxcGm0pE+Gxz7M0a/9KY8zgI/5FCyKTxtfwkE8Arz9nVNhftjkAPrq+9L4m07jI0seacc8Afeben2Jo7rLrJCO8FLgSZbPKKzPqymS/aOuThsnWdgu5MpHiBVAqUkbRtrWzK0nJsHs3T3msYI/57SShIIBHlXdN7DiwOKzXWZn4rhrdAYGMudXtLjykhRJBIMgLIYWI9Xj2UdrhB3XabFPi713O5+bPEnCOOz2wpxi8gCJN5eV9tIYHDMMWC/6zdNdMylGcxEbPDUsEFPNDi7b7SpYEl9cMp4HbvSFHi4mWvE61F6eJvltARTQOpQ1k2vRGNaI+4q2mVo4ioJjpB13pKmv4AHRB32B2qDc9rgRVp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdrZ2FLc2tYYjZweVFRVTk4QXN3M3RSazhIVmhhR05sd1FWT2RqbkdCNTJF?=
 =?utf-8?B?aS9oc2dqbHVEZHJHWkdKeldEYk4wREw3T2drVlFVOEpod0pyM0dEUFV4andB?=
 =?utf-8?B?SXp3cVFtMkl0SmlxY2JGSFRTTlY5aE5ja3ZqcUFseDdwaFVtb3VkWnY4b1o4?=
 =?utf-8?B?VjZHMVBEbGlGaEIvd1laZzJpQ25wMlRxL1dGQ2NmZGlaWnpTQy9WNXBPNkxE?=
 =?utf-8?B?TXN5eHJkYjNqNXV2UzV2eUJPWkFjbnRqREg5RVF4eDBrcGlaTVlQT0hJdVpO?=
 =?utf-8?B?V1NSZUo4eHdEd2szZnZ2KzBSMjNXekI5WW1GaWNBYXplejlyRi9RNWFQUUl4?=
 =?utf-8?B?c0s3ZUpzb0VZRXI4Y2xRcWREUkhIZ2lFeWVYNEVpK2hOOFVIcVZKbUNWRGJR?=
 =?utf-8?B?b0xVelpMSXRYYjQ0dDNOMFF1c1JpYzdVMERTMHQzK21Bb3FFQjVhV29XZUEx?=
 =?utf-8?B?Z1hvd2lkQ1hLa1diVU5XV1orS2pwVS81a3FCbXUxZkFibVpVZ0ZPc25RTnhn?=
 =?utf-8?B?Q3Q4Nkk3bFJCejhOWTdXeUZVcG11aWQ4KzVjRUdhOWkvWHJpMVB6bDNBVzg0?=
 =?utf-8?B?M0lSYksxNlpxRStNbEVoNlk5RjgyUnRBUUw4N1ArbHRkS05Jc25zNDRkUlR3?=
 =?utf-8?B?OVNpcG02WU8yRGRBU3ZzNVRPbGxDdUkxSmdJWFBvb0IrU3dVd29TSkZNL2Qy?=
 =?utf-8?B?REJ6ZkZHNVpnQS9JZmgvZmJoUGZOaTBPTU5RK2x3YUR2R1lFYzgwbk16WXor?=
 =?utf-8?B?aWozdVBjSWJjUWhDOXdJNy94K0h3dHY2V3ZmM3U4SjlJVmkwNUloQUR2QnFC?=
 =?utf-8?B?RTdhYllmU3FRTExnU21GTDVNVWJxczIrc1RKNDVVZlBDMnordXU3ZzJnTmJN?=
 =?utf-8?B?UTNEWEVTNE9KZTMvcHFrSy9PRlY3RmZqV3lSMXNzZlA3S0h3U05uK0FSNzlj?=
 =?utf-8?B?OWNsRFc4WmY1Nm1BVVNPRkljWk1mVUhYRW5US0EzM016cHZjV1hxQ1NmOEtD?=
 =?utf-8?B?ZWZjQ2VESUhJMGdVUEQrZXBkQWo1SndicDNHSmhLeEZwY011cE05U3V2UU4r?=
 =?utf-8?B?TndhbHZYM3Y2WUdyZXVJVmQ3KzYyVGh5RVdXVEdsZlc3Uk8xZ2hqMExiQXl5?=
 =?utf-8?B?UXV2VWdsdzdzeVR2UjZrU2gwR255OFlEajkrK1FQaG03QUlPaE9UMnpxN2x2?=
 =?utf-8?B?ZGs3K0ZPQnBrRm1waHh6TS9YcEFRTnVuZWVKTUU0a1RsakNYdFZmL3Jyam9G?=
 =?utf-8?B?V2wwOE82NGFKcE9saHRCZ0hLYnN6MHJIM3JQVUdKQzdZN21mUTZaU1J6UDRV?=
 =?utf-8?B?OSsxZ1JUclJMZXNPSXNpZkx0QU1adEgrc2srYXFOYUxCd3M0TU80OG5RRDVx?=
 =?utf-8?B?WU5sekxYdmhTbDIxcXAzbUhWckdlSm1UOHpHNXJvMVd5UTZ4YUtzR0VrNm45?=
 =?utf-8?B?ZGk2a1I3ZjNneXNQU2xmYlNmZVRlWkg3MkVYQUhJcUJtSXJOTGtuY3ZRZnEw?=
 =?utf-8?B?UTVTc3Y3VG4zcHJTenY1QmpiK1dZSVdCdGozL1RJaE13Q1l2SjFUaXFuMkF3?=
 =?utf-8?B?TE5wNm1SQkw5SmQ4clBtN1BlTWMyS1pCUnhjMEpTTmJNMTVobjRRVXpnaUQy?=
 =?utf-8?B?SFJqZFMxRkt5ZXpqMlJIc1BrY0ZRc2R2VVJVT1Zwd0RUK21ZZXNsTENuVjEy?=
 =?utf-8?B?azlCSFI1M1QxNG41ZFowbFlGOUwveGZoQTJFRGlsbjQ1VzJSd295WGJiYUR5?=
 =?utf-8?B?b2FsUHVxd0FqUGxGVUszcG9uR041ZXFXRkoraVY3d1ZjS2lWMWFOK2k2TTM4?=
 =?utf-8?B?RWsxbXFRakRmdzVOMno5ekcrbGtxSERkbGxlTHZsYXdEUmVSSkZnZS83VXJy?=
 =?utf-8?B?bG9NY1Y1LzM1ZEV0aEhOSWRhSkgxL2h2bmZua1FTbFAvdVBNdG1KWm5CaWJu?=
 =?utf-8?B?dVBLcTNXMXlPWWlhcVVyUTNHSzhBbmV6L2psWSs4R1NlRkFsckloUzVnMGNW?=
 =?utf-8?B?TE00bm1zSk1iZDhaSWh1cG16UlpXVDVUbmJLMkFnWkpZd1JqQmVKdWdQeHVD?=
 =?utf-8?B?TzZXSURqYTh0UmxWT0RlaExtTkg5YzNXajRYOU1xY2RUVVlMM3FZR0Q1U2gv?=
 =?utf-8?Q?kKVuPFAhpIDXG1DiLvhAtaxLm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaaee4b-9804-4308-4c76-08dc425b1bb9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:10:25.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc2PUlcZLnbBHk8BMBNqeJ9swjJAe05zXSqyo4iOhx2mmx1R+5FEokKpLpA1mo+YAX084CpXq5uZKt6LwKWrBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

Hi Sean,
Thank you for reviewing my patches

On 3/7/2024 8:00 PM, Sean Christopherson wrote:
> On Thu, Mar 07, 2024, Manali Shukla wrote:
>> From: Manali Shukla <Manali.Shukla@amd.com>
>>
>> The Idle HLT intercept feature allows for the HLT instruction execution
>> by a vCPU to be intercepted by hypervisor only if there are no pending
>> V_INR and V_NMI events for the vCPU. The Idle HLT intercept will not be
>> triggerred when vCPU is expected to service pending events (V_INTR and
>> V_NMI).
>>
>> The new SVM_EXIT_IDLE_HLT is introduced as part of the Idle HLT
>> intercept feature. Add it to SVM_EXIT_REASONS, so that the
>> SVM_EXIT_IDLE_HLT type of VMEXIT is recognized by tools like perf etc.
>>
>> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
>> ---
>>  tools/arch/x86/include/uapi/asm/svm.h | 2 ++
> 
> Please drop the tools/ uapi headers update.  Nothing KVM-related in tools/
> actually relies on the headers being copied into tools/, e.g. KVM selftests
> pulls KVM's headers from the .../usr/include/ directory that's populated by
> `make headers_install`.
> 
> Perf's tooling is what actually "needs" the headers to be copied into tools/;
> let the tools/perf maintainers deal with the headache of keeping everything up-to-date.

Sure I will drop this patch in V2.

-Manali

