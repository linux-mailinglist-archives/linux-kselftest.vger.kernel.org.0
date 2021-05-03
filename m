Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A203372041
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhECTTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 15:19:05 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com ([40.107.5.107]:30183
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229590AbhECTTF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 15:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZaZBRA5Z2Dz9XYp+9SIJZld7LE1dRMI5v10D20rXxdOtEJF0zjWZfudpZtwamaGO7RJadCry6f5wmca7o8zR0WJhKqyrfZZgLRntIpoAECVjDeUPteXdMiaSi798JEe5ssEytRETHr6XXS1aFcFY5vU1WcZJc5myQvykFQP7HdKvt5aTVgIpbgvSGd6mHeDrHX7b5e0+MhB8SgRv67tfm2Okx+OD3HOtzLy510xXXpZDUV7kVV/bn6hxC5nqGus7txsM6/oqofUqESEbepf0yJf37muEV5octAuf5LFSD7q/eDBdiiDpIh+h3xTeN/xJLIi2DyIbVgmZIHZH6ZE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Ijbow1BmI+nzq00NCW+Zi6HNFQeeR8N7jHlzCs1SA=;
 b=NzzP5ixouf09OsNwxI9bIE6MMehARzmAWfDe7k156RZJA4KYg2OpejrrVnhu0U289wUCkQ4CHfFpeoMrCR+cwS9FX+55ReZd+35lvyOV5D6VhRja+whR4Lwv5yuR1Krvied1eyBd5jqy1sPVNl2ghxUI7fvYhcSTtWdNCEvPAB8YxrwB0sERKOqyPF1/GPg7z6/dJWR3kVg9u0YR3iETXgrW2QKCoEKNtfEEsYYXk5asJ035KFfa8NdL4KjDqJ1FDbNkDMCrYb5s7rH0zZU6wLEHMfpwz5A2y5atKNiInFQS7Ult0qQJJALZXOSQuKHi8zwnQEguS8W6L4LGpg2wCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Ijbow1BmI+nzq00NCW+Zi6HNFQeeR8N7jHlzCs1SA=;
 b=nFH888H4nov6vQBfoFOba/shD/xXfpnSmvqbqAOO8ckMdGaqRc1eY5E1xLFupS4hQd5VI+02Aw9TwMGkQuoR/ZoCJTv/OVzAiYhFplPArGQnUalLn/iHubrrgdXsmFe/i+iokNZNAHSjbn/zk6S9lEwkb+nkgzH/1vIQ9BUhYF8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 19:18:09 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::fc46:c7a8:e09:8dfb]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::fc46:c7a8:e09:8dfb%2]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 19:18:09 +0000
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
From:   "Denis V. Lunev" <den@openvz.org>
Message-ID: <be7eedf7-03a2-f998-079d-b18101b8b187@openvz.org>
Date:   Mon, 3 May 2021 22:18:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <0d68dbc3-8462-7763-fbad-f3b895fcf6e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [31.148.204.195]
X-ClientProxiedBy: AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::18) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.36] (31.148.204.195) by AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 19:18:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e136411c-b35b-4f46-f722-08d90e682fb5
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB507746CAE9447B92EBC179D5B65B9@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16VNkOrVKkX/xzPzPfxvYfkm2TRvPenZsLH8vo2rWNnxJnbomsEVmLNAOKGvC8VvgfTpH74CVyJuiTNZWbytE9F71qW2+YRpkVoioxKPIkgE4eb1vWAW9MATwvnXGz2r8rd5xdfXqaGGTUWOSuoSiQLjeFFF7YSTfKpCx+ehbtvwcb/OelYtCAGm+P9D3vGDNinz9v4zTvGqVUpqfrJDI16K0799/XTUoT+3di2Z4j4EQBlAmd56nkmEPc1ByFWUFq1TNXWNK1zfrrvtinkoFvUgfEo5q9IPaf3QGJB+LxunpyZlcvZRn6DMr6IPsNCYWT578mOXFBAocpJm0zaBYEGIA1uAHnwmaAeYjA5A3Jd5NBLWuLgtPQgL4qkHquolWbNCbkBU4UAJ0bBl85Fv2Et+urwcf1etN03DlWXGbpuTY/+442/VjmK96mZ7JYnvW10u51mHsfJBdtm24OFmkitp5XNz4LpfTPXthPdfFjQtEyMEUOEJo0XiMj1/kDPM1dLwUZsFocUYEhnTeQYtEjAOBfqFhRKeTm8F8DW7t3IothWwyRkixS4ekzRyeEQikWW2KRzJATGXTh21CZCnxMwTtZPyVCFKjBbK9jRNjCiZSTVx5Fqpl1ZC1L2GL0EnYpqjNwTF03BkSIz5n+9JLhcxYNd1ilBvCmsGin7PqKhCFEnTS+ynxXe+WZWYaLYffliuhaqXkUKf2/XtSSJOQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4214.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(136003)(396003)(366004)(376002)(7416002)(66556008)(2906002)(31696002)(26005)(66476007)(66946007)(186003)(36756003)(6486002)(53546011)(8936002)(316002)(4744005)(16576012)(5660300002)(83170400001)(110136005)(54906003)(8676002)(31686004)(52116002)(956004)(38350700002)(4326008)(16526019)(2616005)(38100700002)(478600001)(42882007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mk92b01ZYWY4SzhiWDE1d2pxNzlwOEkyMnNva202ZHBtTk0renRxb3djV0FD?=
 =?utf-8?B?dTYxekNxenlDTWE5S0xVV1VrOTVNZVZNczB1QXd1VW1yMXN0eVRXdGlNcVhm?=
 =?utf-8?B?c1I0cUJvK1VGRkJJdVlhWVZlVEZXeG41Ti9YMUtMZ2ExSVMvQkdEMFpHVjFN?=
 =?utf-8?B?M3lnR0l6M2hHWWtCc0tNRjhtNUNobU4vbnFWTTA2RWRXS0lYM2dIaHZQM3Mr?=
 =?utf-8?B?WHlsLzNMbmY1YnQyMHJtdGkyY1ptRVQrb1JtbzcxbncrN1Q5UnpWQkpObGRG?=
 =?utf-8?B?clMxbzByNVN5a3pLZ05jNzdJTENkL0RTaVpVZm41ck1nT1NHOTl4dDZQOGtz?=
 =?utf-8?B?UEdyNXIwYVVHUlpSQlZBSEk0aGY0UC9oN0llYjNVTzlERjM2dDk5YzJ0NWdT?=
 =?utf-8?B?WDk5TG1Vd3ArTEJiQjRvMkJiVS9JMTV5c00xZFNXWU9YK0pOSXdVcG03Z0Zt?=
 =?utf-8?B?VHpGR3l0YzRIMy94MFp6REJpeDZ6U0w4QU9WSjBGaFhXdDVYRTA3RGN5U3U2?=
 =?utf-8?B?NjJhZ3JWRlhDZHhyNnljUFExTUZNeEdlemhwR1BPS2tZMTBia2tBeEV6VkR6?=
 =?utf-8?B?ZS9yVUQ1T2FUb1JYdG9iSFF6UHJMSUZkaU5hT2JFNzBrWWhjM0o2N01DQ2VV?=
 =?utf-8?B?RDREdWhpMmdoQ21LZFFrTk1HRzRsbVZ4OC9ac0daS1hLalRHdTk0ekNnRk1S?=
 =?utf-8?B?QmRhK3JUNlVpMFdFT1RXN2RVN3lEd0tBTTdUdEtUT1E2TWpwS3ZkU2tPS1dD?=
 =?utf-8?B?SWZaeVFsRmh1ckw5Q2kzTld5aDl5QXNVL0lSb3FpRmpFZVlsdGVwOFAzQXVv?=
 =?utf-8?B?UkZCU2dpdFBIdTNOd3kyRWRPbTFQNTZRVjZ0Q29ISG1RZGVVSllIbDV4ZUEx?=
 =?utf-8?B?WUEra01tWXhYMzJSRVBoQSs4MDhQZVdFUFlad0t5L2xIZW5SRHg1dTFyVjNJ?=
 =?utf-8?B?L1BQQXp2RE1peDZhN3M2NHdyQXIxT1l3bHdPanEvVm9zZjcwQjFGZ0ptbHZs?=
 =?utf-8?B?Z1pZU2hLYzIxV2FseDBwZWtpTzErQ1ZyOEVVQWFQbERkTzdUZTRtZXo5U2Qv?=
 =?utf-8?B?Qzg0ZHpiSlBNcDZRWmdRWnhhcFFMeTZBYXVKbnNzOFZqMHl5WFhDQVl2b2s5?=
 =?utf-8?B?NU9La0gwTXNwaFhEQ09vWDlKbGRqdXdORU1uL29NZTJSeXFrUEY3QTlzcjd1?=
 =?utf-8?B?ckpzOENaejNGUkFydVR2S3lMYmRTbjJsdnhobHZGcGNWaGcyaXhaQjZDZGEr?=
 =?utf-8?B?ZjNKbVR3TkNyNU9DSFhjbzMrM0xFMS9Va1VWQWdmQVpoZDdVbVZWWUtYZzdk?=
 =?utf-8?B?SWNPZVFoVFhzWFV0TmlSMjJTTkN0aE1JSG1XTWViUVprVkpPNGZDTFhiL3pi?=
 =?utf-8?B?YkJueHBibExncWtIdTRwSW5XM3dpd24vRmdTUHBHcTZtekZuL25CU1dtR3dG?=
 =?utf-8?B?WWV1TDZRaVR5bFNmVnB1OHg4ZFpNTWZVMHQyTHEreW9xTDRMS2V2WUtpdlFQ?=
 =?utf-8?B?aUJ6VmNFUXpEa01Zb0htY0lXbThOaVBaK2s1Y0NKcC93WC9OVVZVWlhWSitl?=
 =?utf-8?B?THRMT3JUS2w4RmNUeTBPcGJMRTdSbVBNUmNoRXFUN2Q4NHlwNDhkRnpVMG9t?=
 =?utf-8?B?bE9UcnVNUzFRc20vc2psRTVwSnJ4OE9nWndQRFRHMGV6OXVSSGZSSUFLWEZB?=
 =?utf-8?B?VzB3M1R2SGNjM0owQmtyMnVTbzYzTkxUTEFqZlBJSGQwVisya2I1MUljRXdi?=
 =?utf-8?Q?CdKk1lHE9Zm+xq493uBx8mYzttDwKvjnp/NutfF?=
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: e136411c-b35b-4f46-f722-08d90e682fb5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 19:18:09.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35OqNoQ3okcC0zx0ww57rW+HozyEMWhqgdl83XiAFdOALvx8+HH+Mi1hftL8jQQpAic6Ke19C/Jtk7I8X6Hapw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/3/21 5:54 PM, Paolo Bonzini wrote:
> On 29/04/21 03:00, Sean Christopherson wrote:
>> On Wed, Apr 28, 2021, Valeriy Vdovin wrote:
>>> It's very explicit by the code that it was designed to receive some
>>> small number of entries to return E2BIG along with the corrected
>>> number.
>>
>> LOL, saying KVM_GET_CPUID2 was "designed" is definitely giving the KVM
>> forefathers the benefit of the doubt.
>
> I was going to make a different joke, i.e. that KVM_GET_CPUID2 was
> indeed designed the way Valeriy described, but that design was
> forgotten soon after.
>
> Really, this ioctl has been such a trainwreck that I think the only
> good solution here is to drop it.
>
> Paolo
>

should we discuss KVM_GET_CPUID3 which will work "normally"?

Den
