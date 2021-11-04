Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FDB44542E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKDNqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 09:46:53 -0400
Received: from mail-dm6nam08on2082.outbound.protection.outlook.com ([40.107.102.82]:38944
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhKDNqw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 09:46:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXVUyL8K1VGj/0YmXFQB/SBdyi8ZyhoM2cU3HnK1CFq3LXGqAd+GX61T+iFRhtpBfXam+eH2xqYK69AvyuYA8itnPX37gdde7Jpf+PMFy6HG8AsAuq7QyvpVcgvx3jDAYOkSHgg1os+fVHYyBMYewjFUj/cMz+9vj2uF2q0XVyvuYhw5kCS2tDvDi1+/kWeLXT2BHS93rgEcrSWnlQI7kCuw55hVoYKCB94BISK9vHuq8IK4JhZEVe3CWNvZ0Po6QGe4V16XjjcftEq6x5CoZal2pdmf31TaPhZ6SiKS/442EmJCo8f1iJLtmLotyMpZPCC68Ck6Vx0IhaO6sx8yOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJeuu/4bOS2hwGzNR6GFfXKLE+wcaPTqWmDSEbiHTXo=;
 b=GxZ5t6/tniBcOA63jigQSKWA4VRIKsS16Cl9v5Eaa6WdptUqxc0tTkACsisbLXQTlo0ZPDhMbYxVjYIBL1Z9tSWF4FiJuybeoo7uH27W6rTQCcUerTtZMKzeLLpPXLR3jfV0duV80BTpRcOGuEEKj71xJ83OIRYMG83cJ27KLu3q44DRpbqMq45sILmcHyssiuM1pFi0MPRm8DIALIHQkZrUC8b7QZvuRVVBu174hRCpWPVqRCj0e0xneX7hajy9G3Qt/C84igExu0sbxD4+h+CRFgKHRmdupJ0lTAb9Bx7x2wXGEVVBJ67HRt5K1PEmNquC9c1M9Pwq42Fonhorhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJeuu/4bOS2hwGzNR6GFfXKLE+wcaPTqWmDSEbiHTXo=;
 b=QEUGD9DbwftH2ErxCa05s9UDazTjVz8ccymQZeZtSpfsKqXMqpu/YpUEGDZZJcwm/Uh+i+BhgGMpACOaDpTpBymtbjBoruIlnwGXuPWy3/D9FPW1S22C2j/7kkVitvooypfPsOcYH3zHxc32j4sj2AhmEBu5ADzbbSiI1t85aFg=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 13:44:12 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%8]) with mapi id 15.20.4649.019; Thu, 4 Nov 2021
 13:44:12 +0000
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
To:     Mingwei Zhang <mizhang@google.com>,
        Michael Roth <Michael.Roth@amd.com>
Cc:     Marc Orr <marcorr@google.com>, linux-kselftest@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203710.13326-1-michael.roth@amd.com>
 <CAA03e5EmnbpKOwfNJUV7fog-7UpJJNpu7mQYmCODpk=tYfXxig@mail.gmail.com>
 <20211012011537.q7dwebcistxddyyj@amd.com>
 <CAL715WKBBXNpJFK-3254ox_GU=v04RdYC=uXu4S5kbf=1R9aYA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9c3f6936-77d6-7c32-059c-2e998f0c67b2@amd.com>
Date:   Thu, 4 Nov 2021 08:44:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAL715WKBBXNpJFK-3254ox_GU=v04RdYC=uXu4S5kbf=1R9aYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN6PR16CA0071.namprd16.prod.outlook.com (2603:10b6:805:ca::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 13:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ba8ea0-a60e-439a-f2de-08d99f992f0c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5327752D3B8C0AD906C18142EC8D9@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jO20OHqxBRrJz15qLG27RmL2VloXu/sLUubuNtvOQXTc0dhyirrwc5bCKJgeg/WRkOgt7z2q5MNehITHBGo1+xdIuUh+EHQ6+nZ9AGU5D2k3995Pm/8dgfRKAOaO+CVP+oBVR8Pm1rBpnvvn2MrQQRdBulWsuAlHoaCFUfsG4sssK6w1NK1rKhTzwaQAthUM1HoSuFr1n+4ruiY7NFxh25q1/NFomsxzM+2L4wr1NiXpn16d6HMVlyrymLQBCCCQDsgKYabLGv0qUL1TMRZVAKOpFrUoHWaI/WyaSRfCwAbHuERC1QYxB7tXYCCvzGQJCrdhEjgGIAV2yP4vAmZYEGK7T17Lq2Dixe77kf4N8pJhGKn9ZYArIYsoVULPahj33Ec3ARmN+pNcQSTqkwURQ4+xfj4fluIU10KAV6Cpm1AzVeEFa3fKum2DWQ8TMwqAg0Drkihdvs9fI8t8/fCE3q7zztJ/mKISHfkkNs2Kz19JZX1MBJJQqrve+U8yZgzBdQj/sVywIIcOR2geTM8jHxVKL/eGJ76kT8F/7I+qug2w/n+3woRu5mToPXx1Ef1IBj5U24KIlGGJhtJWltKcd7wdN37r8coJHJAWxRtu3k3GjsEUzVotX4wQ9Prhee4pjK+A+y5wcMsP3zjkOAct5QzkRXYt14S3GwxK3S8Qx+UYfUG8+lv1SIcoBRDykJ/Cmueaqx6pF+exuL4BiRSEqzxiz8gswyT9PC1ePZGPoOti7PK2qvxJviAfr5oMMiH4ktoN+JNibM6gJ00h8w5MlsFteT/HPT+pFDr7cC7aBcnnRcMZjh6UdHnDnMOjm3XR7hA83rZ5KOl99bd17LyquZc2vm50tVbFPIk0NV/giI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(54906003)(26005)(36756003)(956004)(110136005)(6636002)(83380400001)(6486002)(31686004)(2616005)(5660300002)(6512007)(8676002)(53546011)(6506007)(66476007)(4326008)(31696002)(7416002)(186003)(966005)(86362001)(2906002)(8936002)(38100700002)(66556008)(508600001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRXeUlMVDgybXQrUDZEb2Y0SzR6TXpHTHhVUUpBM0s3UU1wSGF4MThVUG8y?=
 =?utf-8?B?Q2dCejFxZjltQlNJazdYODZ5TGVVWWlxMThocXp1dS9iZnl2eXM4MEVjZmNp?=
 =?utf-8?B?Y3pTN292U3ZPaks2QjVLSDdSRkhncHIrY1dNR0IvL2t3Tkt4alJNczBadW5P?=
 =?utf-8?B?bG53Mm9EYXBaZ2VGSjc3SWF6dGlFWEUzS21lb1p2ZDRwdFlVNzgwYmFkVDQ4?=
 =?utf-8?B?YnNFZ2l3N1lmUHlMaGljVEtPbXF4bkVGeGRVM0pLL2V6dTZsdzI5UzJacU1s?=
 =?utf-8?B?clJLVTUwR3dtT3U5d1E2dEg2Zi9MNmNGQ0t1UUx5VTFJY2d5ZjBoT2Y1bkxI?=
 =?utf-8?B?RG81U3ZzeVpMKzZUYzM1WWV3MThrMUR6aHpYL0lSOG5oUGhNZmM5M1BISW9L?=
 =?utf-8?B?ZWhmV2ZZRDRPWHlaeThXYWVIQkpneGhndDlHK1V4aXgwLzcvT0RiNW1paVFK?=
 =?utf-8?B?aHdoVWVkQ2tFb3M4a2lQUHYrN0hyTFRyclVkSnJWU1dnVld6S0o0ek9VN2Vw?=
 =?utf-8?B?c3NNMWV4dHBXZmVQOXRLbkl2N1h6T092ZkRkQy9FREFrcmVmSmtyRDhPaXBJ?=
 =?utf-8?B?bE5xek9sZjRUd0VnREFFOXV3dHh4emhwSmVyNGdpaWg3YmwyTmd4YVBoVVJu?=
 =?utf-8?B?bWF2Q2xoWk5teUtjNHh1eEJDWlA0ZHNkblNXdHR2dVA4V1c2Yy9IeE1HSzVr?=
 =?utf-8?B?eDJDQ29Cb2huaFd5WjVMUVk5ZTJvT1NBT0xFRFNBQlphR2ZDc1BqdUc0dGJ6?=
 =?utf-8?B?aDAzYVhlL295aHc5bkQ0eG8zQXA5eWZrT2RTNnozRXA0Y2tselZ5UmNodkls?=
 =?utf-8?B?SmlYbFQ0SVhsR1hkZUE2VHkxY3FVckZMOWl5dUFQSEhwb2hsNmNnYlhXc050?=
 =?utf-8?B?SUs1MnFxY3Noc3duSDRxUlpsY1lZZ3BPbWlPWEp3cy9oZ1kvbExTZUZWVHhI?=
 =?utf-8?B?TC8vR2xTYlovekZOemJnL3BpK3l0ajQvSVRUSEk2SkpzcEFyS1UvaFprSUtu?=
 =?utf-8?B?ZGJrcDh4R1YxVitUaHhYSXlRVkZGNm5OZkRyalJYSFFPUGNKTS9abDA2cUQ5?=
 =?utf-8?B?Rml3YkVKSm5HWHFVcU9jTnFFRWZXTklSYUorM0IySE9kOTNhVk9nMndtbEhO?=
 =?utf-8?B?UU1GSzJiWWhpVFc1bW40TGErTUMvaGNlV3JBRmtIWEdka1J6dEx3N2I0WFlt?=
 =?utf-8?B?aUQ2MDdRbFhmS3FvbDRWRzh6STFHQlpoVXpwbmw2SDhmWkYwamRkMVVGTVFz?=
 =?utf-8?B?a0FCZmtkT2graWc3U1FnSDZtb2h6RFZTZnFmaFhWdStraEtoL3IvU1AzeFBr?=
 =?utf-8?B?azhYUFNCOXc3aVloRk9RT0c1bkN6dFF5NnFwUWNLODVZNzVlcFRxY1FNOE1z?=
 =?utf-8?B?ZUpJdE5PMktJSm9ZdWZTYXZyUEJnc1NaNnVaK1NDWCtiMDJTSGF4eThaVUZs?=
 =?utf-8?B?WURQMjJsM0Z5cGhqejU1ekEreEc4WmhlRzR3Q29GNU95cVlybTlqRzhTdnNL?=
 =?utf-8?B?TEVpM0ZVcStELy9NWmpiUDZ5cEY3VkFlSUdDNXFUWWQ5RVpyZ3Q1SWNFMisz?=
 =?utf-8?B?cGtSSHQ4S1ljc29pcS83M2JiNVhDZjZhb0xaOVMvbXdQN3NWV2g0WE1qU21Z?=
 =?utf-8?B?eXdXUEdMendrU3dBQ0Nvb2hIYkN6eDdPYW1NRE9LOEtSMzZOeVB1enVSM0hM?=
 =?utf-8?B?OFdxWkFMSWJDMiswTEdxaWZleXkyYzVyNGdxejRNYUx0SDRmekEyM3BUeGlh?=
 =?utf-8?B?ZHpUbncwVGpwK3VMTFVCOC94U2xXNDJGaStudWpWS0g3dkVEclRtK0tvTk11?=
 =?utf-8?B?UlJHWkhPakU1bTdXcnhEZnBlS2t5YnpFOGhlV0pjcWpXdUsrc1N4bm45QVk2?=
 =?utf-8?B?M1ArKzVVZGcwSlo4c2hXRHQzZld5MUNJUHlvY3FDOGFjYlpnQWpSNXV4OFQy?=
 =?utf-8?B?Q2ZGZnpjZnNSTDlaQlA4bG1iMHhZektUSld2dFRwRFU1aWx5YTY2YnA1YUNW?=
 =?utf-8?B?Nmw2L0NqMENkQUhFaXdORTlsNk9QNXBwelprWGFIUktVN3ZvYkRTcXRPZVE2?=
 =?utf-8?B?Z2w1VHdsZ1dKUTVSUUQ2K3l1ellVYnA0cFJRb2o3TjhVRTdRREVCbDhuYXpv?=
 =?utf-8?B?U0xBUWdJU0FLaGx3MzU1QVNVdU14cWFUcmljVTExTVMyaWZRYWdoK29Gcjl4?=
 =?utf-8?Q?Dyn1fd2pN9e8kzEKCH5SN6E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ba8ea0-a60e-439a-f2de-08d99f992f0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 13:44:12.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPMJ7ORVegHCUgnR8HmT/6glBXOLzba6fRfaDO0uFu+8Punnu21ruWfxbCyCPaf8BN0U7hlxpJtSQmwaIF/2Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/4/21 12:25 AM, Mingwei Zhang wrote:
>>
>>>
>>>> +#define SEV_FW_REQ_VER_MAJOR   1
>>>> +#define SEV_FW_REQ_VER_MINOR   30
>>>
>>> Where does the requirement for this minimum version come from? Maybe
>>> add a comment?
>>>
>>> Edit: Is this for patches later on in the series that exercise SNP? If
>>> so, I think it would be better to add a check like this in the test
>>> itself, rather than globally. I happened to test this on a machine
>>> with a very old PSP FW, 0.22, and the SEV test added in patch #7 seems
>>> to work fine with this ancient PSP FW.
>>
>> Ah, yes, this was mostly for SNP support. I'll implement a separate minimum
>> version for SEV/SEV-ES.
>>
> 
> I want to ask the same thing, I tried to run the sev selftest today
> and I was blocked by this minimum version number... BTW: I suspect if
> I want to update the SEV firmware I have to update the BIOS myself?

The SEV firmware is updatable at module load time through the
DOWNLOAD_FIRMWARE command.

> So, it would be good to know what is the actual minimum for SEV.
> 
> In addition, maybe that's side effect, I see a warning when building the kernel:
> 
> "module ccp.ko requires firmware amd/amd_sev_fam19h_model0xh.sbin"

The firmware images reside (typically) in /lib/firmware/amd/. There is a
new version for fam19h that you can copy into that directory at:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/amd

or

https://developer.amd.com/sev/ under the Links & Downloads section (Note,
if retrieved from here you will/may need to rename the .sbin file to match
the name mentioned above).

> 
> Maybe I need some hints from you? Or maybe it is just harmless. I did
> double checked and it looks like I was using either
> amd_sev_fam17h_model3xh.sbin or amd_sev_fam17h_model0xh.sbin

If you're on a fam19h machine, the fam17h builds won't be used.

Thanks,
Tom

> 
> Thanks.
> -Mingwei
> 
