Return-Path: <linux-kselftest+bounces-7169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F789852B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8621D2835B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C876F1B;
	Thu,  4 Apr 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N0Tku08m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2096.outbound.protection.outlook.com [40.107.93.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3741C6B8;
	Thu,  4 Apr 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227102; cv=fail; b=ukoa35tfMVbgBNUp1nw9XEyvMamB2G8PhR8rtSq0/rmKd17STpTTNif4WCfEB4arTvJljtNhDywCxSE8zfD4kGwjHDKTwpIcCIGGrEnmYHPq7ByAxzAWWVZX1RJOvyVdYi0eiGZO38Qd4kl6gXde+VRmkQoQiSZg5Q/tPm5XDFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227102; c=relaxed/simple;
	bh=ce2X+W7J5yHTQRJbtwRV5+toBa1yVgjKmgRTkIwLMuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H2CjkNZ7nuAOCeY2PB0SmOWLFVtZqQA658ubXNSGR+B8a3f03doDxHzwByqdwIZcokkTisTnXvAANpTMmeHVlVBElIcWrc+Hpr+8tOpQhepQsnXKcwAdVb3rs1CmySq4WBYafMhMNe7ax5xVfNJ02KSvviRos2dzlzha47RGHOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N0Tku08m; arc=fail smtp.client-ip=40.107.93.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECIyBudrHFP/w/UIRdujn6xJbDjpiBiUvKnX/UT88W2luBrdPRtT3ZHTJ0rDu68DKAuPK2eHhgfR+yEmP+1L5im+JTmO/FBpC5xzVsbFZsDQEbUuGrnFMIOZnjG9ZI2kFrtQkAwbqDZewG6jddkIeO5cOpsmp/cTW1proClSe/0OcDUHEj7j/tKoPovcPC7ILNA7KunVg/yiSF1oclg2InHSVaMhluFhgKM0i/X3y0poqVX7ZPflLgh+9cDsMqM6CEV4pZ2AxDu6hL+Xge9gM7XPq210wf6DQIChdoGjOTrbtrRG2GCksJIk5+ddPgz0oWpiLHYfwCfCt8WFESYO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPBYFj20X8orD0Pb6kHWiV6BH/cDPZZXwJCaj0RzfGw=;
 b=BhpwpKkhg2lLVT3aaJPRnZOQ52jD+32UEbpT5pxtgf80P6Ylki4+N5WovC69Gft51QayDsf+ZssV5t8p2MJEvvkVlI12Aooslrz1KDCDPIq9M7QXBbjiAes/R3y/alRmYPn8/Beanpi7Dy+GUeG57lSjeO32AW9H9eYJ49g4DbS89677QKqk4dhbzyjnRl4c73mNqJlrlutVkPi5A7hP9E5EiURd70qTjL1C2fImRlHOurVJf4vS0Un2t821EeRm81Twk7djLhfvilTxSjkXWwJ2qs8+NwrRZS3LD+vg/pD87Dit9vnmqPNHkbWwpmcssacxgyCrVdDyd/nkyS22LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPBYFj20X8orD0Pb6kHWiV6BH/cDPZZXwJCaj0RzfGw=;
 b=N0Tku08mb/LYj0SNX7X9q+MxC3w5Qp+eFYCaIxnUXYOr0s6tp9Ys5hrAK3AqRVn8iKrXxGcJgmHFob0NEPRgnUQiQ8HFx/zLB9LL9dWrk+dTfhwLRe9xQcx2uRRzo87ebeLfRY9Ls6rv1HdSMs/36Uq5ta6wr0nmhFTCF/ktd/I=
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 10:38:15 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%6]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 10:38:15 +0000
Message-ID: <7cce8ff0-8f56-d9fe-b7c8-83fc30ef184c@amd.com>
Date: Thu, 4 Apr 2024 16:08:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] KVM: selftests: Extend @shape to allow creation of
 VM without in-kernel APIC
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, ajones@ventanamicro.com,
 Manali Shukla <manali.shukla@amd.com>
References: <20240401152032.4284-1-manali.shukla@amd.com>
 <20240401152032.4284-3-manali.shukla@amd.com> <ZgrrtnZCllrt-3TD@google.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZgrrtnZCllrt-3TD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB5617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cMvqAcJi7hI8vwwjcdUzRuUrwBcOabh3U/p7/mnoMCT40uEt2OcP0k5TZzL8sl5tYxH9ba8uWqgX8oDdB+4JmlsF3Pqkq5OCzFvKcg3KaqLUYdpBvVvj2mxGohGtwGpc45546jAolAN05onVd1sHBbZ0Mr9TuAx0+Pq/bM66gb9j4nUdma85yCynYC6Dc5dhPoZ1OQWQpMwkZp+LKycxAh94SkTD47VOgVgLTkvgyxKCueUm/cKriuliolhifl/JOkRoVb8v9bUxZ0drYkUtsTrYlbZS5d3qgKNBV1GNG/Zi1ZFipFOnhUx9/VG9bM5bDbRLOiLG6ys2mfSmTwjiR1150HMizziND822OsW8QG5Hpqdx/iRUQm5+Rr63vTyvQQFsyPRhG6b/fErF+apd1z05DzXzjvKLxu7xV/fXleTZriZ/mGv6pLbCWeB6LabpqPW9cLaXwQj+E+jnbS4QuU1EZCM1F0sCKhSbgVFjgrxJ9JPIzSszq6Jj99hue1hemF8KdbMC3AF+IV0D0T5HPIVcZ6tOby+SLxwHV7LA/qpEy5/CJIDT282FqF2EKCr7ZpWSw086nA6hxChYkedg8YKmpoVgxywNxbhABolYOgVW7fBSzL8nx2d8ii7yy7MUHHIRkXl0reR/5WmHKAoks2e3q3JfEat0RCNqxhufbWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVUcGxoQ2NxV1hPNzNUUG03VmZSY2l4N1dpNGN4Smh5eEdUM1V4MS9uZ3Bn?=
 =?utf-8?B?K3RncmRzRjBncUlnQUFsNndsWEdJOW1hbEtBQUVKWitRQ1ZEaWVHSy92cCtn?=
 =?utf-8?B?OTg3ZWFxK2pBOFhuQkFQRnNwWFJJeWdwaHpkQjZaNk9vVkxRb1pHamIyNWw3?=
 =?utf-8?B?YkgrQ1JlOVFWYjYyUmRBSjJTcWo3UlhjZERpYzhwb0pJZWhWVTJQM1ZXTU9w?=
 =?utf-8?B?ODBaTWwyRGYrQ0hrRUhyM2x3TEE2eDE3UnIvSDFvdG5WNi96MTQ5cDkwWjVH?=
 =?utf-8?B?cklmTlZRUHkxZW02d1FaR1c5YUg5aXRqcnY2VHVmTmZvRFJCaE8zeHVkVGg4?=
 =?utf-8?B?WG1Nclo5MTZlU0Z6QjBtU1BuY3NRUlVvWC9MTDNmemtOd1A3UzBNNUZPNzhZ?=
 =?utf-8?B?a0JMN1VLN0VEdElEZVE4OHNOcDNTdXRyWUNTUSsrM2loUHVqU2ZocUt6RmZD?=
 =?utf-8?B?TVc1b1dnUDV0TDg5UzMwVXloQS9UZGNoVjVGSDRMZG15UU8yck84SW9uTTBN?=
 =?utf-8?B?SWR2Z2UyQVdQam9Vakw4dUNkV3haU3UxQWh6dUd3RGZyUEllZmppcUppQlRz?=
 =?utf-8?B?TXBKMy93ZEc5ald1ZXlLMy9ZcEZWRVlaVHo0aTkrdXVUU1YvcmJETGZjVVhQ?=
 =?utf-8?B?dXRLMFVFYUFQQnZJZEJLMGVXSWtkblJ4bzlaODVPVFNydUlMUHVtWXFnU2Np?=
 =?utf-8?B?UGRQOGN4eERkR1dZRkJBdlN3K2hVa3QzUkY2Q05LMjVuaVJVY0pWOHdYamZC?=
 =?utf-8?B?WjQrN1V2YlJQNnB3R0RzOSt0bGhyMUIyYzV4VnBvUDhGRWpJczJjd1laNlpw?=
 =?utf-8?B?a2lNUHB0d0hXYmxCQ0ZzWWdrQWRrMTJOOGtqL1NVTEhzcUlpeFJpb3ZPVEs5?=
 =?utf-8?B?V0tEYjBZV2lNRFlqRkhoWDFZOEphZzFnNGRHMCtWemdoOEhLMVYzUFlNVVZU?=
 =?utf-8?B?Sk9VTUQ4TU9RSDcyT2p2SllxaXIzcDVubUpsYlN3T2xBczNYOHV1ZDdYMExS?=
 =?utf-8?B?YUkyb25mNUF5VzJyZTJHbHV0aDk0bUFBOWxQNGthY0xGQWErZGF0UG1kRVI3?=
 =?utf-8?B?emhnQUdqdjAwdHBRLzRtVkx0RTFXZE1YMTgwS3BYdUVubWpEMHo2Nnc0QUxx?=
 =?utf-8?B?N1F0Si9rSXRWckkxWWY3QWtqbHdSdmZKa08vVkJ4d2tTemNTeWNCNWdVU3dN?=
 =?utf-8?B?QS9GVzFCZkFITG1MVnkvbmFyL2lPR0JTa085RjhJOTB6SDVUMVJIWFpuWjJh?=
 =?utf-8?B?QTBwMWR4Q0RPcXNkZlJFMzJjQlZVWDVnZFVrOEJRclJFVUs1WGUxcmNxT2hn?=
 =?utf-8?B?dDNoTUkrY3AzSWJMMFYzMU9XbWd1ZzZrc2E4SXd2NjZDd09TL05pbzZ2ZnpZ?=
 =?utf-8?B?YlpBdUNBWWFkbHVFVCtsbEphVnRhTFRRNFZYWVFuOUIzZzB0RytNUVhmaEQ4?=
 =?utf-8?B?eWNvRmFtSVVDZXNkb0hIWkE5R0NTcklwM0NIUjdhT1FibURaMm5DV1hVd2hJ?=
 =?utf-8?B?Vy9kaUZaOFp3eDlEWUMybE1NKzNkUnl4TTd1N1cyRmNvZmhMT3pDajg3a2JH?=
 =?utf-8?B?ZStaZ0daQ1dUK3hsSFk1ajdqU0FMYmhIS0FJcmYyOW1ISlFyeTFzQ3oweDl2?=
 =?utf-8?B?bW91S09ucTIva0pxM0FPakR1Sml0OFBLMkw3Tm43NFp2U3BrblUreXp0Z0pJ?=
 =?utf-8?B?M1ZxNzdrc1RlQm1wZm9DVTIvSTJ2ZU9ERkxXZEFXbE5HVnc1U0MweUtsSGRI?=
 =?utf-8?B?aU45alhwUUl6am1PUDVwQjF1aGpiYVk0aDl3MjI3ajVNMXlyby9zMjg5V1pi?=
 =?utf-8?B?clg3aHpXeHNiaVJUK1BaWTBEVE5hRUUwQjVtUnNyQ0RXanRJNGhNQ295STdG?=
 =?utf-8?B?cGo5ODlSelRWMXY1ZWFwL2RobHp6TVAvQTNDUGlLTVpSTWRRNnl0dEx4dlpw?=
 =?utf-8?B?ZzNLV3JpbmYxckMzVGh4aVhDRDZtNi9oRHBWYmtXb3BNY2pML0xldWdFU05V?=
 =?utf-8?B?VnhnTUZXUFJ0NDUyZ1JBT29KclJjWFlQbE5QWllhZnlxWk04KzJ2bXJDUFk0?=
 =?utf-8?B?RU56b3E0a05kV3loTGZrMzdSbUtyb0QwZjZKS2t4eFdsbEppdHFVUjUwUjhB?=
 =?utf-8?Q?Wvnkts+XU3RiJ+LxBBuUSYgoO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55065792-4829-4916-daba-08dc5493553b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:38:15.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXuYf4kT9A+u4YwjJ5jqRztSpEX0CQRXNAyefNgAeGJp7Y2XDzoTbD4v1o70ngJOP+SlFyxUKTJmAsVVgCPVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

Hi Sean,

On 4/1/2024 10:45 PM, Sean Christopherson wrote:
> On Mon, Apr 01, 2024, Manali Shukla wrote:
>> Currently, all the VMs are created with in-kernel APIC support in KVM
>> selftests because KVM_CREATE_IRQCHIP ioctl is called by default from
>> kvm_arch_vm_post_create().
>>
>> Carve out space in the @shape passed to the various VM creation helpers to
>> allow using the shape to control creation of a VM without in-kernel APIC
>> support or with in-kernel APIC support.
>>
>> This is a preparatory patch to create a vm without in-kernel APIC support for
>> the KVM_X86_DISABLE_EXITS_HLT test.
> 
> Ugh, when I suggested creating a VM without an in-kernel APIC as away to easily
> test that HLT doesn't exit, I wasn't thinking about the side effects of creating
> a runnable VM without an in-kernel APIC.  The other downside is that practically
> no one uses a userspace local APIC these days, i.e. the selftest isn't a great
> representation of real world setups.
> 
> Given that KVM already provides vcpu->stat.halt_exits, using a stats FD for
> verifying exiting behavior is probably a better option.  The other check that
> could be added would be to verify that mp_state is always RUNNABLE (which is a
> bug/gap in KVM as migrating a vCPU that was halted in the guest won't resume in
> a halted state on the target).
 
Sure. I will work on it.

- Manali

