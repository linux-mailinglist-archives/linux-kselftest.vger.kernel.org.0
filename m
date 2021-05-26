Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E842D390D2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEZAEx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 20:04:53 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:13763
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229685AbhEZAEx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 20:04:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE/HlRMHtCQOHZ2qQAedoue0hIeKE3t+kmTWp/9/Gkz5HFCXLMJPBYvWDaa/1NLqkmT2u3hIlDNGatWLWcyA1dmU9dQs6WOjpNLnWNPmrKCujEk7Vx5/+CdDeE7fo6pK7qqvSWxEchozFMb8Bfz4CE8jvj5Wqxu05h3VA0sLvult4iUR3eBLkSQ+u+sP2Ql7qlO02VJHtQ/CddffXLJ01y7D3e9T6RlKX10q6D1Pgp5zw9bs7IqUa2JfrbrldjLAAKF0rzM5w36uZtiS+TfrVceX5EZKlKrs1CVJCmeoKKriX60rcw/DGRazWUPkqXq6tR8y0+9KnFqyJJQjabKFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14uRvXT4+9JFurIc11K1fBY3TH0f9NnNKg0Jy6tcJp0=;
 b=PXChUAiWcq7SrYLMnw0RBtxonn21dljoAIBraKy9tV/FRBka/prk3IQhhB7aooLkioGFTAA3yXnSqeP60X6QVQvW9NX+c6PHPQCXjT51pKIWQx/RxijSCKnOT28zsood8lSMC0837tOM5MVzvx3d6j+9lb+3fATlrCTEU2dNZq2yX9BpW80y6kgJkT4TWRDSXrfDWIWdJ042hcASJHbecCPobnh9lKx2A6o4ZnMXbHWDePw2CXERWg2nwAi3sVcpSwO0r+DP/K7xFgQl7EF9NpP5BhMh8Rb7ji7sXN0ZQJCbDFnXvnW/50BDRxl/PM3tGzdMHc1a0sydEweTfqfCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14uRvXT4+9JFurIc11K1fBY3TH0f9NnNKg0Jy6tcJp0=;
 b=HLYaCKwf6PW4PjXR7vcpqExcMyFOdXSvL9PFUloE98A3DK5PTbYeyYuQ50CBNRv1V90hGwXvYVFGk5s2oxaeQFk+XpuD2bQIP9f1u+AxQxVMny0gxkbRoOxkBMZTRGGDbYXzEl2BCbATu5Zhxx64nWnj4wUynDhUOIg0uRvz8gs=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW2PR12MB2346.namprd12.prod.outlook.com (2603:10b6:907:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 00:03:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%8]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 00:03:17 +0000
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, shuah@kernel.org, jroedel@suse.de,
        ubizjak@gmail.com, viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, rppt@kernel.org, Fan_Yang@sjtu.edu.cn,
        anshuman.khandual@arm.com, b.thiel@posteo.de, jgross@suse.com,
        keescook@chromium.org, seanjc@google.com, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        0x7f454c46@gmail.com, jhubbard@nvidia.com, sandipan@linux.ibm.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        suxingxing@loongson.cn, harish@linux.ibm.com,
        rong.a.chen@intel.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        dave.kleikamp@oracle.com
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
 <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <a4f6b80d-8546-09dc-7435-25b3d890aace@amd.com>
Date:   Tue, 25 May 2021 19:03:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SA9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 00:03:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311ddf38-5e31-4337-f7f4-08d91fd9a9e0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2346:
X-Microsoft-Antispam-PRVS: <MW2PR12MB23465FC946EE0B3D0A3E99EB95249@MW2PR12MB2346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AuisTXCEwI61BjZFHLcu6f10rcZN9URk+/QxwOoEsA1058Tew2XPLXUl9tVxYoq4mhEZldWFQMRLUTtUCYmDEbhlmNLAxhGEcNbXMS4MII1kFW/8b4zceoPvX4B7qKp7QukYAv+W1j5lmfJm1t/F/WGu2BvHjg65gpScfKLkHvUEeQxA7IILEbJK7tB/BVk5q/mXoz6MnKUbVi5phvhrNaWcW6CWDIl2GKr9DaTk/Gk3EZOSEqJpZbNP7I2SXEewMT9WRwzdwk0by8lhS8RncT1Y5nyGlyakf+y+FKnhxC+M/LssKF0txemV1rwPqBpZUTP3sIlCPf46dcH3hmqdhCNPTTKh5mwb+LDzYNGaThlHmWCGT+M+PVEA3S/nTkJxu+pht4q9GupYtd9HCXEIwlmfJ/XPkkLsb1h90y9W/KiflCbt6BZruV0XNZniLjFTk+Ud+KrQckK/L/oGGSRhUnsy5+jv7QYuXLD/ZNgHtjVFVau/5hZ20BxpTjq6cCisr74XlJH01qq/WIvELAJjnC9MLGQiBAMc1diJZLxzWv74IbDS72tA1yEFjuVerXn3scDnj08F158DCVBYhobLpi0C4WHaE4uU8VwJPjvifGB5QMEkNdtaoR+G/dnIn3Hl7rAwhR3wnpf3dqYdlpp2B0dZF5yH04Eb6wVW4KbDvShKEVDPlw5mOwcDSi+A3SxKFBgbpdu3U3JK9RKft3kf8MU6qThyaociLAqe0m9l6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39850400004)(376002)(366004)(5660300002)(38100700002)(8936002)(7406005)(956004)(2616005)(31696002)(38350700002)(16576012)(2906002)(316002)(7416002)(478600001)(6486002)(86362001)(8676002)(44832011)(31686004)(36756003)(83380400001)(53546011)(66476007)(16526019)(186003)(66556008)(66946007)(52116002)(26005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?2Mu9sllR4PMu+hiMSZyUyvFkryKNwWk51PzlaBz/XZUAW9+mbaKyy9WQ?=
 =?Windows-1252?Q?jSnSkT9jrDT5igynHIZ6QQxbqlDQw2b2pqEW+QSJQy1U1MqJIQ/Ik6gV?=
 =?Windows-1252?Q?ilVJo2ECiWswsNqaCDZgcTsT8Z6IWZYlYymA2u7/7KjnkOdarMnG8kCA?=
 =?Windows-1252?Q?Q8BeeGZtY1Ve0wQQwQnRuuyb8+NItJ06jgrTQUldzFXfkPmw4xWORRkO?=
 =?Windows-1252?Q?0iDu45AB/0IdV9ge8una9T7jo9U+Ku0ZdnO3y+Az31uL5qVJ9d47wJvz?=
 =?Windows-1252?Q?YMfdi1AHGPTWZmJQ81q9I/1b2ooDAInntgbHPW82M2NLtfD+VQnm3cdU?=
 =?Windows-1252?Q?4CiiL0qXgeINgpZv2Tyw55QoGW8DLi6m9JSRrQUzClEgVYPoXTGkJWTQ?=
 =?Windows-1252?Q?AaMi5jH9RB4Ym3pT0o59xOaVjVEWS3nUOEu7nwcao6tDGmD0S8KdFwKg?=
 =?Windows-1252?Q?VecxHUOWzeEXDAGqdY2pNC0xRsVX2KnGc/zRahTEoDAphy6NG5i61rIY?=
 =?Windows-1252?Q?ZN5C/eXK1uCii4mJW6KrRJd0zttNl8l/Dn4LDWuJsiLdDK1IUDzQ59De?=
 =?Windows-1252?Q?3HpeDgTe9sqHyUc8b2sHQA+1K+DOwmLMB8Z2Gn81B7+4+I6Ht31M+eRM?=
 =?Windows-1252?Q?Qm4QDkl2HKGZ/n4lw66aBAKRJZYPsS10bcLYvcbDw2aSh2eTKs2XRSYb?=
 =?Windows-1252?Q?ymoIhtwrnu5Q6ebIuZVXBFfvIYZ1oxMeIt9rDCCJfVc5K8Chdu5oEmax?=
 =?Windows-1252?Q?jLxrpEZmXmhLoMFLFFA91BMFlFDIhznOnbzSojxWs/afMATjAGkfCR7/?=
 =?Windows-1252?Q?wc81++Y66uIU0ra/G42aRFaishz3f1wyIRXgpgdmXQ0wtoAJCUEePxjC?=
 =?Windows-1252?Q?opWxk6G7y/rUxHw4eDJbA45qT5eTc1jzLOKnd4dc16dRstZsT4WqLv7L?=
 =?Windows-1252?Q?RAUHs2u1vB5y/RyEp0UN6D0HZx2vZsX6guvxl31iP3MmOzWTBPRawMZI?=
 =?Windows-1252?Q?4a7F7U/6E1y9t9uVHfswmFo8+xDxcw4u9J88kDhdh72f0/MFChWz/BaE?=
 =?Windows-1252?Q?g2k/caZw9LaBLeR/ubjwPHvWd0P2TOD5ixLqskBOwtTCOftrt/w7gk1f?=
 =?Windows-1252?Q?qFrnZRiMuy7I/Dq17ey0bwBeJ+lhg9DIMlOUdH8iY6h0b/YeVhyW3f4v?=
 =?Windows-1252?Q?Y2zT6H4Akdxd4+PZ5j1uFuTV3+7ZtgeDYvBQ/piNvoqigvcAyjJljSR4?=
 =?Windows-1252?Q?UVtpWCpejGcNICoT4jy7vzBs11pVmNkZb9ICllk8PCjaRaKKJ46TLTIU?=
 =?Windows-1252?Q?F0wEhKGz7KfAbKLG9E7GZ75vnLy1JTJ38MF59v55VhTk8dn4Dm3FaCYC?=
 =?Windows-1252?Q?gNNMJEtrn15X7aDteQtJolsRtw7xaCez/r/1gzlGZylrpulA3ADlK56+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311ddf38-5e31-4337-f7f4-08d91fd9a9e0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 00:03:17.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04ig+zqg3STq2bxTKxjkwsZO5zVlbnz6uvwOruPIli4YOHj/Lvj1lRFMKZ5Si6uW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2346
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/25/21 5:18 PM, Dave Hansen wrote:
> On 5/25/21 2:37 PM, Babu Moger wrote:
>> My suspicion at this point is towards the selftest tool protection_keys.c.
>> I will keep looking. Any feedback would be much appreciated to debug further.
> 
> The pkey selftest code that pokes at the signal stack is rather hackish.
>  If I had to guess, I'd suspect that PKRU ends up in there in a slightly
> different place than on Intel CPUs.

You mean the offsets can be different? Not sure how to figure that out.
Let me take a look.

> 
> One oddity is that xfeatures seems to lose its pkey bit somewhere:

Yes. I noticed that. I did not see that happening on Intel box where test
runs successfully.
> 
>>  protection_keys-17350 [035] 59275.834197: x86_fpu_copy_src:     	x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
>>  protection_keys-17350 [035] 59275.834197: x86_fpu_copy_dst:     	x86/fpu: 0xffff93d722877800 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207 
> 
> The only legitimate way that can happen (on Intel at least) is an XRSTOR
> that brings PKRU back to the init state.  That would destroy all
> meaningful PKRU state, unless PKRU=0, which it almost never does on Linux.
> 
> What values do PKRU and the shadow have when the test fails?  Is PKRU 0?

It goes back to default value 0x55555554. The test is expecting it to be
0. Printed them below.

test_ptrace_of_child()::1346, pkey_reg: 0x0000000055555554 shadow:
0000000000000000
protection_keys_64: pkey-helpers.h:127: _read_pkey_reg: Assertion
`pkey_reg == shadow_pkey_reg' failed.


>  Any idea how xfeatures&0x200 got clear?

Printed all the flags while in __switch_to, the header flags and CR4 flags
appears to be intact. Dont know how the feature 0x200 got cleared. Let me
check if XRSTOR is coming into play here.

