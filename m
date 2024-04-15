Return-Path: <linux-kselftest+bounces-7952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D048A4BEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E301F22E77
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DAF4BA94;
	Mon, 15 Apr 2024 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nf1uQjal"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35245944;
	Mon, 15 Apr 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174560; cv=fail; b=ikR9IOIgXNfa7F9dpma9VSGA22lUmeES7TOQWs4VRFkZr3vicOg+LPg6U5GgFkbCm2qDoozH8Dw5OjN3ubUC0D18RKIDA/1DA+dMUHwNgDM3w9lIGtRMh6ahTr2VA2q2aEqhrA6sJvpl4y8PLcCHYUxXD/TGHJQSuLTiKtnHHSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174560; c=relaxed/simple;
	bh=LnrhS+7JsgDfZlKqqUlsJ0eDM9avIbYwr4ZlMzcw2So=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVOxhzEec7xeSNiY0gVB1F+YKRfKBvrOISybABklrW8miK7tbzUQ1522Uy1nG9ypW0QdqnkNFpMTXf1RCDieuH3dG4WfcsIqR6VQ/TQqSYX6d4XK5AYTet2c2QDgPa0KPbO8vOGk9K5GnqAU9X8yfkYkUOFFOLhwZ1SbSTwILRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nf1uQjal; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3nfBC73uf0W/zFuYQxEbeLIYVQXk+xP9roA3NI0Ksnp5mNd4kxaQHWmsDQBl8c2G6vpux3ynJnWgKsNiUSmcVs6H7zEHcuymw+kfhBjOdyU9/3sYYvJPFhMOYV207Vmo7A49v1mgJAMzT/SxLu75bRbXQWaplXKc47HVxC0L6VGZ86x0vznZJvShdDG4c6beugb22aUzlXQyEouPrM909sk2To0oYkY7d7dh+uyRtbJwCaSJw1dzLe6Ma57lsSRJEY1oys1HNYoNK4SmdD/kzfOCW5ExxZ4JhBgjyu5/TMMqLsdttYeT6MRvm1DMgLxc7INjWz3wfkaX6Hrvqdlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAWxkXcHmItMzbq2T5G949UCkwM6C/NcL9PSf4MhWmg=;
 b=UKDbh0l0dhujGVXVNCsPJh/hAAHoHAj2MIXWXEL2p/Zyd1Xj9qmEIfVNHD4ebABxbaPXRwyJYP1tKODYnsc9yT0LDG9FW7kqh3ToiC4p4Bz93fkyY0BrkR6ljnhJzEmlRJfLzcESIUK2z3wwqFAfO6RyZa15l9aP9YGJRd9xhyAWUySiXk9EgW6wh/Uu6qUsD9Mfp1V6+nIeNHzwfU2QJaw5SMOBNdJixNTcEHK8TF+3s5GW8ZZzCsB/0xImELOiHt28Rx9htGves/JIXNXpoAMrdFJ3QHU4LpIaFZ7Et3N3abJaqh3av93nkwcqOHydTYldJ213doiamsYLIszwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAWxkXcHmItMzbq2T5G949UCkwM6C/NcL9PSf4MhWmg=;
 b=nf1uQjalchrazpm0wrI2137Idy6sERidP768zZGrh1I5UgfeeOPQRiNombosFzel9lcHI+4xAfS9XUl/7KTbPHx0QG2S8bQzVwjeMAqb8vAsHUOtLZw30Aa/wWKViKAY6Hf2XvZH9AsA4qqEGDBR/2Qgwqjz8vKtA7QsAWlAS94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Mon, 15 Apr 2024 09:49:14 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 09:49:14 +0000
Message-ID: <418692ff-0b66-fe43-7236-a6657bb33ec2@amd.com>
Date: Mon, 15 Apr 2024 15:19:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] KVM: selftests: Add a test case for
 KVM_X86_DISABLE_EXITS_HLT
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, ajones@ventanamicro.com, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240401152032.4284-1-manali.shukla@amd.com>
 <20240401152032.4284-4-manali.shukla@amd.com>
 <59714cae-4b69-9a3f-87c9-b934f8b7cc3e@oracle.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <59714cae-4b69-9a3f-87c9-b934f8b7cc3e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: c69f122b-b5e1-4bbf-4949-08dc5d314eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sTZxKnSpUqqVd0qD4dvj0RFUrrbg1mAIJ8eZx8aZsx1pAYy+jq3WBETSRdIouk6Zaq4sdE95ArRXHAEyJn+Nj0HWmlBxaFBaBu/oYgfvIp4njiWpkuitWKiYe/brpZm9SfimZtAAvg6+KXe2+zg4uIxKwu5uBbV3rmGasypnYRE1Uhc//BOWFiNnE6J8wSLQyMu0rSewh96US748HZFUPxAjKuXHlXu7fkMHa1742LqjktmfZUTLTWQcS0CTaRWlr4NqNN1N2X+Az0dSxzrdNBGxsfvyfGRq3niHZV7AIzb0mhnw1KRtkKUd9ohPwqvQFwETwsrGGsqAz1YOuUNkk/4AnA9FLMH//WuTHApLRTZ2HfYoW6cOVEvj6uwmgqEymoP5CWg5HSDcDcdaIUBc9YR6eAzHTWHf5pawMskpzkDv7EK0Z9Th0+t0m1PlUAKKibL4PJIWximlZcfmWWFaEPzbDiDb5PMseG4vCpTbAG1m85By2E9SF+bftZfR6VuiO6ds5iD1skmfqQLkx0QSmUmqrI2dLU5XnFRTkzBgYCUmYcR4HZJa1lqvyWBOmq7vZJdAWr/rsUVVjq9GXkwcRcFlcD/fc8PRQaHqwqQS9HSIwZoV+2m+ZIToWk1sePnhH5K8SPLJ3P/jjcgLRlkmETVpqPuewvkeEPBzsy7YI6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmdqWHllWEtvUWNjUHhETks3WG1jMVhZWmJ0dTdFUS96MnZnS0phcG9NTjdo?=
 =?utf-8?B?M2U2cEc3TDlVNmhEbThyNlF5TzZGZ24zMURLSEplTVByUlRIbEhqcUNRU1lQ?=
 =?utf-8?B?bDBkQUVlV0ZjOXhmR09ENFNqTFBzWFRjVTFXQjVJeWs0dzhwcndMZjFLdFBp?=
 =?utf-8?B?N2cvOGlWYWpKS3oyYjZuYjR6TU54c2xJZGtnN1BIbWdKMFdzMlk3VExtYm12?=
 =?utf-8?B?QkRoM09kZndMYWtGRFBTZXkyUWJzMU0zbm54bm5IS1gvaDJSUzJHYytMTWJD?=
 =?utf-8?B?Y0xsNnZmZHR4cEN2VlFsOUVvSWFEUW5iaXB5TmtoVXFSc0ZZNzlGYjR0VDZk?=
 =?utf-8?B?MWZ1alpzZzh6T0hRZ2RVcXBYeWxyQ2F1NXhjSzNCelkwTjBFMFdnYXhZWC8z?=
 =?utf-8?B?SG9zRms4VmZDczlFRHdObkJaMEE5YUZzRXZKYzA2cmhOaG5QVzdpQUJ0ZGpB?=
 =?utf-8?B?d2VTb0syaDFzcUxqNi9Eanh6VTl0REZiTlFjTWg4SW15NkJnc3pjVUhpVHB5?=
 =?utf-8?B?d0dZUWs4KzJpbmhNUy9Mek1ITktNQ2sxT0M2bTIrc2QrT3B0anFNLzVIV2ox?=
 =?utf-8?B?c2h2dmVFQ1lzcHZhdTlGWi84VHZmMEVwR2t2ZGRmbWo5T2IxSGs2NUNINTlu?=
 =?utf-8?B?cHFWeHdNRGNmYjZ6UHRiOXVqbE1RWUxMWWl0UTFrV2ZESSs5d1J1Umx2eWpo?=
 =?utf-8?B?bWp2YzNJa0NhL3VtbGRscU5kQVRsaUZjRXU0T09vK01NVy9NQTEwN0JJK010?=
 =?utf-8?B?TDZOeG9Kb0pCTkVNNTFabTluTzg4UGdSVXh0NHZWb1d6L3ZxOHpjaGVtZktp?=
 =?utf-8?B?RHRrczlRbC9rQTdjRTdJQzlBM0hqdmx4eGM4VlhzdWRCWmN2d0NXbDBtSWtl?=
 =?utf-8?B?OGtuNFVpZHdTNGZvZ1QrTG5uY2ZwSGxHOEowZTNVMTRaOUw5a2lrc2h1aFpq?=
 =?utf-8?B?UXFOWnd4S3FyTThWUEJTR1l5NlREeDF5WXhhRElzVHVNVUdxaTVtZVFFRTQw?=
 =?utf-8?B?OEhOTkdJM0pwY3lqc2RMMmY0VlNleHRkWW9LZ0tjUzlTbXRwTEhEQS8vK0lw?=
 =?utf-8?B?SUl5ZUlYdnFvTG5jN1dVVWpHL1NmMTlPdWRhbHpUNkh3K2tKYSsvd01DVVFG?=
 =?utf-8?B?Z0h3R3JXazlhU2g4cy9YSnhja1p4N3VOcEFpcFZhaVVIME56T2Y4SmFvSFNi?=
 =?utf-8?B?RktiSVdIQ0J4Q3ZtTXYvYVVPRndOampYeElDVWJTa3h3T3podWxHMEJzL3dD?=
 =?utf-8?B?OXlxcDkyQUx3eVNkbWk3Q0hQZmFHRXgvMmVPZ3o4SU5XVWJEWmtESFI2bXNa?=
 =?utf-8?B?MnBiSEhteFBLSEZrV0NPNWorNnBTMzNtQUNvU2R0RHJ4a1doaWg3MDlhZDF1?=
 =?utf-8?B?MG1GbnR3TTBVM0VuNE1aWkd2S09POE5FK3YrRVF2anFOUGhYbzBlMW1nUGZE?=
 =?utf-8?B?Tk50OWJ0RVQ4OVZBakQxaVlMbXpCZFdYR1B6dUdpNksyeTY4NjB3ZDBVbFFk?=
 =?utf-8?B?azV4NEdRNVIwd0NHcHRCRWgrUExjTVd0c1UzY2gycVFRMkhzaGg0bTNwOXk1?=
 =?utf-8?B?c204NWRBRFdMbGlIc2xQamhBTHRlRXNhMm9vdXVOZVFESmd0Z28zaDBEVzBB?=
 =?utf-8?B?bEQzQmJjTU5FRGJZTFpDcHhDdERjcGx3a2djWFlwQ1lvQmgwaklnSVZZVDZY?=
 =?utf-8?B?S3JNeFdlRzRZRFhOSnVaR1FXSTBsYkwrQkdJVFoyYU1tWTF3TEgvTklPbkNT?=
 =?utf-8?B?SitxTXRUcldQZFhiNmdRN2RsUWNqekJ2clBuL3JMR3BJMzZQbFlRKzVzY0k4?=
 =?utf-8?B?by9XYTJOODlvb2h4SlNLQm9NckFIWmY3U0VxeWJOSVkxeG96ZFVsTDNycC9N?=
 =?utf-8?B?clo1VExsaEdvUDZhb2xWVzZ2T3lKa1dFMnRlbFNra0RIOHJFUHVNU2Q2VjVZ?=
 =?utf-8?B?KzZOOWdVT09nSmdGK3pLN241cUFHN0FkT1NuNk9VOU1VM3VOMDBhSjQrU1JK?=
 =?utf-8?B?SXNGZm1FMzIvOFVYMTBsNCtkb205cHFMTkN0eVQ5UGlweE1hYXY0TTliVmp1?=
 =?utf-8?B?Zk9NcklzU1JBQkN6bWI5cmhKa1VSZUcwNW40d1p0QWpKUnFPS2JpVUJ1T3pi?=
 =?utf-8?Q?XqYwmlimAVByePYf2m9RETYF4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69f122b-b5e1-4bbf-4949-08dc5d314eea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 09:49:14.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QA0JaItvZ63c6vLDuCPrGxtsfn1+ahRsNXTM41lpgOt9MosoSfr5zsFBl0wb8V57Y3KK5DFzRoZzDOfvQOpBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763

On 4/1/2024 10:29 PM, Dongli Zhang wrote:
> 
> 
> On 4/1/24 08:20, Manali Shukla wrote:
>> By default, HLT instruction executed by guest is intercepted by hypervisor.
>> However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
>> HLT by setting KVM_X86_DISABLE_EXITS_HLT.
>>
>> Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../kvm/x86_64/halt_disable_exit_test.c       | 119 ++++++++++++++++++
>>  2 files changed, 120 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index c75251d5c97c..9f72abb95d2e 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>> new file mode 100644
>> index 000000000000..4cc6a09906a2
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * KVM disable halt exit test
>> + *
>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + */
>> +#include <pthread.h>
>> +#include <signal.h>
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "test_util.h"
>> +
>> +#define SIG_IPI SIGUSR1
>> +static pthread_t task_thread, vcpu_thread;
>> +
>> +static void guest_code(uint64_t *is_hlt_exec)
>> +{
>> +	while (!READ_ONCE(*is_hlt_exec))
>> +		;
>> +
>> +	safe_halt();
> 
> May I confirm if this selftest works on nested L1 VM as a hypervisor?

Yes, this selftest works on nested L1 VM.

> 
> Thank you very much!
> 
> Dongli Zhang


