Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19599372708
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhEDIQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 May 2021 04:16:37 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com ([40.107.8.107]:56259
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhEDIQh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 May 2021 04:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQcdqptSyRCR2xpD0vMvdlpZpI25H40k0o2PETQgUpGYneU8nsvRQk+U2s8mgNl0DuIVfnAQ67lKTzv4mYEeLiOD5aNkcaF0wPQHg3i4us2cAgTN3uCL5/4jl3CtNIaDvP4ogqrTc8ibnwiV0wt0IjjiwjL0vJoGhfV9p/f+zvEGmDOcKS0m9YQ8fvkcdU5SLfW5GejMVnkCYR0O+FRzsiViEMUSVlQcho/5yRQGI6JkstGLH2dzZ7amJCxQ+cMjejLyXIvpYdPiDD1SjBWKLQM7S6vXZeyVKsW5M3nFAVzu9vUR7JVCWSF1OwIdVWBYg0dJvUXsgBxHxEkJDBxZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EPCyULGBca89daXLvU2x3D+5SJKQmqWm7yhdcd4uME=;
 b=UXiJ+Yrx84flrR8qe5zQq8DdN8gQbSV7oeEetgdikwXxCt1iZ60XNmv0gMvZk0STEgSRvYQfs9+FZ8FCRq2bdAM6X1FAAwhekmeXEdsEOjA2Ywa40CPqrFF1rLw28kW50B/ksIrfRy/EX4yOt5l50fLSfR7M77sotfgc3gl10zFMTMvhs0AmAYn4pj0NZv9Km1t6BC4sfiZD1bvGZH2gXhZ6vIhCLmq0hD9/VqUYTIDUrzERESBt4dw8wz8UjSw3/FKHZ9WAd2UWoqfC5MbpqO2AFMllTQy5qdEpWZKf7IQQUNsTaAreQRAZbIoYbfIiqKhtPc3ssJrtQvSY3D/IWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EPCyULGBca89daXLvU2x3D+5SJKQmqWm7yhdcd4uME=;
 b=fVWboo8vPdsE6w6t8ppVuG4+turFtRSLrBasJjPie3ZCMTqIcAtCgRswrBfPnYfZVrJs/s1fOFGazQgnFNfSws0jWpFGcJO/d+NNwSPbaWcE6+7mTQSp1UoIAdDaARPg7HlWEUFodcnrLbyiap8DlHy+RyKUTkFTZvHVt2tc+C0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM5PR0801MB1716.eurprd08.prod.outlook.com (2603:10a6:203:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 08:15:40 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::fc46:c7a8:e09:8dfb]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::fc46:c7a8:e09:8dfb%2]) with mapi id 15.20.4087.043; Tue, 4 May 2021
 08:15:40 +0000
Subject: Re: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
 <YIoFFl72VSeuhCRt@google.com>
 <0d68dbc3-8462-7763-fbad-f3b895fcf6e6@redhat.com>
 <be7eedf7-03a2-f998-079d-b18101b8b187@openvz.org>
 <63e54361-0018-ad3b-fb2b-e5dba6a0f221@redhat.com>
From:   "Denis V. Lunev" <den@openvz.org>
Message-ID: <048b3f3a-379d-cff3-20b6-fc74dd12a98f@openvz.org>
Date:   Tue, 4 May 2021 11:15:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <63e54361-0018-ad3b-fb2b-e5dba6a0f221@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [31.148.204.195]
X-ClientProxiedBy: HE1PR05CA0176.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::24) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.36] (31.148.204.195) by HE1PR05CA0176.eurprd05.prod.outlook.com (2603:10a6:3:f8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 08:15:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edfa0430-87b8-46b3-b756-08d90ed4cdc4
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB171651299E88D711026A4F87B65A9@AM5PR0801MB1716.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isFUL8AD44pfPG8bK9DDUGodWtu61Nne1px5J0tPVPHxNWscDN/Htn8JERNJIcqniWumzED4s/2to3lZyvbpX6HHk8l1kDUxguyTzlhpweTcJAziMSfwjvQPCg5zPlus3XtSKrxGPQXGU+heXHShWlkg5Bz8HmDz8ep/oDha10gJaQjLg1Ibfnn+2tM2RX/1x5vg5KdZymhCmaLTp1RIz3SWnrY7EOPcDsa+PjlaAOB3iJoie2GnqM5ZGy/EAO47kWiBKOorZTOnffzNmD2/5otctnebbe/hdeGet/Y2qb5BSgbkYNgKAW3R3MFesT66XunPYMqc35jucbX2EkGOtZJhrnW4MY0g2tDAw8noNExI9vnFqsEadGgh2TU28liAnmZY4PxO36JN7PlAHBSmoPfp9FhKIqTU3HBmNYQWd8r8Nz07WpzGJ1qxGtl2hTvT3uvVfXldLQWMoutucruLDDai+R27DnNmU0M9d2Mf1+NWzM3D+p/WDaOCJrAn+5VGEgtUS9tPqEX3OgD4LIYpKPieyZuwHXJg/T/C4E5PlltwMzF4Y6LogLNp46JLrkNmCpeaqeQZ3kps736Tm1e/FQA4k7RsWVaSq9GpGGuIFmCAcDaL0xiFW6Ur0Sul5KbtlCWyZ5awWAG5VAKiZJtZXQu9NRva+XCgEIDQIuP0ANgDssFMXq+03tU2C55BlXgZ2LglMDqYLROrADfgoeB0Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4214.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39830400003)(376002)(366004)(346002)(186003)(16526019)(7416002)(16576012)(66556008)(66476007)(956004)(110136005)(5660300002)(26005)(2906002)(36756003)(52116002)(66946007)(54906003)(38100700002)(316002)(42882007)(83170400001)(2616005)(8676002)(478600001)(53546011)(8936002)(31686004)(4326008)(31696002)(6486002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?LzNsVEUzaFQ3UytXWmt4Wnc2YmZyNVBYb3pnMCszZjVwNENSYVdSMEZKQWYz?=
 =?utf-8?B?dDY2WlZ6QTJaZkwxNHYzVTU4WVM0RzMrWTNOeUI0WmNXV0NyZ3hUbGNVSWNH?=
 =?utf-8?B?aHpHckVUamFNeHFTSmlmSjYxZnhmTGwwN0hIQ0VxZHRxQVIzb0QxTzF3cHU4?=
 =?utf-8?B?L05SWlp6aVNsQ3RYanhrenp0bGMwOHJDQzJUaWRvTHRjOEpEcVVwTDlrMnlp?=
 =?utf-8?B?d2gxZTY5Vnh1aWl5eHNFenV5SnZSVElwUjRLV2pGMnNTNi9YNXFaenVzemFQ?=
 =?utf-8?B?am1JVUtsY3FIZkFyMGd2Z1dMamlYQXlWdnBJYTJMbXVWc0xiRzVEZzRXdlZS?=
 =?utf-8?B?STFIU1dZcnFwRlY0WUVaZ1hQenBLYmhmNGJKTVMvemFZRHBudWxobkdBUVZx?=
 =?utf-8?B?ZUptUUtid3FYVFpRaXM5U2N4Wm83Y0k0RzEvaUVuc2VML2grRDg1a0pXV0I0?=
 =?utf-8?B?Z3RaaStuVWMvMmVjK3Y3UitBaUFmM3kyZi9LS0FOUDBhNnRHNzRGM2tBMjVV?=
 =?utf-8?B?UmdEYUJreUJWQkhFc2NMY0EremQxYndvc1RjUVZRVWVYdXE5cWIxT0sxYUdv?=
 =?utf-8?B?ZWlQcE9nYi9WK0pUcjNjNU1pNWxDRTc5bkJ2SllIdHIyRHpjQ2lDYmtvK1FZ?=
 =?utf-8?B?MkxXV3krcHJzbDBSZ001Y3NZQmlYdXlHRllTaDk2OCswNW03YVFyNFdZc1Z4?=
 =?utf-8?B?dURPUEdlRW5vaG1RUnRZaHUwblZsWCtjbVRDTnowdk1YVHJwUDZmZ1ZZOWwr?=
 =?utf-8?B?eEpxbENWZkRaMDAzbGJNQW02dndzWGEzN2dIN2NBYjdGUFhEa3lPYVJ3L0pT?=
 =?utf-8?B?bERtSmoyK0VJS0F1RUFsRVpKZ1haRXZoVytPdUw3R3JJdGZ6K2lFMmxrL2pY?=
 =?utf-8?B?VlRQeEs5K3ZsQnhWNEx3dnkxWkxjWk51Yko4cVVQVVlxeE9DUzN5R3ltQ1U1?=
 =?utf-8?B?bUxUZkJYVmhpcWZFdkNadHAybUZUb0hEbjNuMFVPN21FSmpKUUgvTy9LWGdG?=
 =?utf-8?B?dmFqMmRXTjBpcHBYRmt6eW93bW51R3dqY1VPTlozUXdGNWpvU1lkOWMxcVlT?=
 =?utf-8?B?UWUyMjlYOXpPZmtxa2ZqZVlRR1pwZW9zblhOcFhMUTI5YmtLemMrOUVvUFJs?=
 =?utf-8?B?L3l4Wkd2U1BubVlqQ3JiRUJVZncwMlBXMGQ3ZEplZUJ4Nk5GelRzQWhZcjMz?=
 =?utf-8?B?WWJRTFk5bVQyK0JVL21HV3lwanVTOERHZG12TSt4MDg0dzJKYVhBeWV1MlRP?=
 =?utf-8?B?SDBvOE1WOHlQVlNJR25COXQzbStiMHVDanM5dGtBOVJ3MEVNZzRoR1lUWEhT?=
 =?utf-8?B?YU00SWdWRjhieXZVQTBTVy8zWElHZlc2VGhLOG5wSWVUZWZzS1NIVHRCN1pR?=
 =?utf-8?B?Z01zcVNzb0R0Tk1wRndBa3ZSczYwdk45REFnbmxoTWluZkwyaXB3dzJuWGsv?=
 =?utf-8?B?ZFlHMjY5aHl6bWg5NEhxSmY0dkcydkhJczJKbTR2emVHME9wZVJVU1hhbTE1?=
 =?utf-8?B?dFZScURRWGNEL1dxR1hHUFpFbUJCSjRVZ1poZStuT1gyYnVmNEFoRzRIUUMr?=
 =?utf-8?B?N3VzY2pUTmVJY1Q4L290L0JXcFJTRlRWT2VRSnVJSWR1d3JMbUhYNVJvM0Q1?=
 =?utf-8?B?TlRxdTR6VERpR0pXcDFDc0RWSnM5bXB2VGhZWGR3N3htM3A5dTRFVExiWmd0?=
 =?utf-8?B?TldIbTVMeng0ajBhZUlmNHVpRFJCS2hUbjN4bUtSUm1GWFRSVTFHeFo4b2Ex?=
 =?utf-8?Q?C75B/hUe1ZYaMybqktP2eWUUL2BPdhuSs1qISfm?=
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: edfa0430-87b8-46b3-b756-08d90ed4cdc4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 08:15:40.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNsCrOkWWLxmKKHb2YgeMl0DckiOy38OJhuWSWIeaBrEHAtWr0+JDvKec29Jt7b7kqOP4NCJOR6mEUavZZxsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1716
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/21 10:23 AM, Paolo Bonzini wrote:
> On 03/05/21 21:18, Denis V. Lunev wrote:
>> On 5/3/21 5:54 PM, Paolo Bonzini wrote:
>>> On 29/04/21 03:00, Sean Christopherson wrote:
>>>> On Wed, Apr 28, 2021, Valeriy Vdovin wrote:
>>>>> It's very explicit by the code that it was designed to receive some
>>>>> small number of entries to return E2BIG along with the corrected
>>>>> number.
>>>>
>>>> LOL, saying KVM_GET_CPUID2 was "designed" is definitely giving the KVM
>>>> forefathers the benefit of the doubt.
>>>
>>> I was going to make a different joke, i.e. that KVM_GET_CPUID2 was
>>> indeed designed the way Valeriy described, but that design was
>>> forgotten soon after.
>>>
>>> Really, this ioctl has been such a trainwreck that I think the only
>>> good solution here is to drop it.
>>>
>>> Paolo
>>>
>>
>> should we discuss KVM_GET_CPUID3 which will work "normally"?
>
> Is anybody using KVM_GET_CPUID2 at all?
>
> Paolo
>
As far as I understand only some testing within kernel now.
Though we have plans to expose it for QAPI as the series
in QEMU
  [PATCH 1/2] qapi: fix error handling for x-vz-query-cpu-model-cpuid
  [PATCH 2/2] qapi: blacklisted x-vz-query-cpu-model-cpuid in tests
is not coming in a good way.
The idea was to avoid manual code rework in QEMU and
expose collected model at least for debug.

All it all, some control over things set to the kernel as CPU modes
is needed. Without that I am feeling uncomfortable.

Den
