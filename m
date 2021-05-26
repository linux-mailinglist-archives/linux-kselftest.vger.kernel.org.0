Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEBF391D81
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhEZRFc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 13:05:32 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:41697
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233929AbhEZRFc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 13:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDu5OkxW/th65reUeywl6swCR7TY4SgirlNu5uSstYiGKPUvaSCtgxi7LIV59U2vF/HWh9XGcv/EG5mT0RKasGHPOzb12iffallDqVuB8U1dUUVB7kzznHp4qfoUq2TTmPl1FYg7oZw8OLpRFI6ZWsAApXr2d3DYUTJTj9vbCSsq0XsVj5h32mQVREkfu4wa4UqE9ZcPOOTl/hrvuygXitam3L2gCEuw/NaNE+HPy/fNkwnZTcVnAeU71DDXC9L5Af5u6J4k59FaazaTT/8dOq9PQ5va0p8r96gk5Hg7YHfYuWDeeziptbIlkZvDqKWBm3SEbTj67vW9itszrHPf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi7p7J4LN2/x/pnPKnWIcfGyQTlSt27tTsSVnGF41/Y=;
 b=KdD763dRa01ntVd5K4rByGdpzYxXEeBnIPJkyro93DkmbitsLmuVQzzR84R8Wl15lZzVGmTDnNfNe8xegn3vdZf4wu9jWeG5BSwKEP+L5hSqDGRgDRjrJzU1uHWMW5ffFqWyXLN9z2ARYWmGQcMvLM2+Ekju0JUBCD6huLrVB5iq2iC1aYJHIGGNvxv7UfPdS6pVBtmox/ujudwG0xgAW49e+BuJKqNws5Im4mnl8iOg2nK9vuTXZVv6w7wJg0xOvLxqTV81ordLT0iEXfB65yK1unsdEKfC9aX/EPa6UnQToE6GowiBlXRQoLwL7HpgN053gJqPJ/YYbkb0f69lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi7p7J4LN2/x/pnPKnWIcfGyQTlSt27tTsSVnGF41/Y=;
 b=Tgxy/FmWX+/HxR40Ymv6x2J/NdbjpfFuq5SCJ+jeJSpO+Z1mVD3Kvi3eiiFbQmQIGb8J3TTar7gaT5YiUs+Hl4DdF/Hd05DXiWtsOBGkP36TmBMb124lawjbfebP/tS6+x+85HFG+InXQWnoLDwRzmrd5mzPiz2zeDG456N4uGc=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW2PR12MB2538.namprd12.prod.outlook.com (2603:10b6:907:5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Wed, 26 May
 2021 17:03:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%7]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 17:03:58 +0000
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
 <a4f6b80d-8546-09dc-7435-25b3d890aace@amd.com>
 <e0dbd490-0209-9f74-36b7-c55992060b44@intel.com>
 <ab564da6-1029-1dab-d54e-a266a623974f@amd.com>
 <f4205ac9-5988-3b03-6b6a-b877335d19c9@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <56bcbef0-dca3-7306-d7b4-b0f6d7c382a8@amd.com>
Date:   Wed, 26 May 2021 12:03:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f4205ac9-5988-3b03-6b6a-b877335d19c9@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0058.namprd02.prod.outlook.com
 (2603:10b6:803:20::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN4PR0201CA0058.namprd02.prod.outlook.com (2603:10b6:803:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 17:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c984584-4ef4-4327-1a81-08d92068406d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2538:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25382F3514309ADC0F990D3B95249@MW2PR12MB2538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYerANoN8l8wv2lU/z3sDbu0uDhZKNkKwX1JOAcEdZLxzGjqR24pZ4yZZai4uwa3KwPoAjR9uWd5h/sSaKw8mxVlLXwZbfQI3HEaLAl3p/uFUPcT3uKFaSIW0xen2MucraZkYEWQrXqHkIvL4tAp87F54j7JsXMIVXeZUxKcnRorUAuPRLdATXTTEtchPBUnXZ3R92GHK1QlT03oJjbWNAANHqzSGcelmiqBYg7wt4Jjjop0+wSKgc1demgfD8vgPCwEzaT50H6QWp0EOtG/Yv5a/FGZxE2SBudZ3BLksyEE0uuqwQlw3X32ViYPxZ3jxMzh6wcNDFX/E42sJ8p1KaVFr81twHZ13QofCC/6X/3cgMsElIoniypJk0t8V+qs6OFfER8Rl7eaP/SX7lemumgwz+GJ/OwEgZg93f9zv3Nw1jMCoPNgwQQMCXThmSB9VvMtZ4GvRvtlRP42lZbA6AIi6d6Ku3uYPMZ5Py4tomx7IK9DuRnrDjogooyCThpDUblSL54bP2EfCZaTKXV345xuVmEZoKOPKD+MPaiefPwKwh0IP1zVMKl8mJjNxmSlEtB7EsA8070051M85BCjbESH7raK7cNrk9iZ0J5DTEe6Zv+Ep34jHy4QSJ3hmU4AWGUYYlgSKT3FZJy0SSFeG+GTTzRV8/fml/u38ZprT/ngwYriYxQsjoHLYay0jNKcMd6DElbzpjqQNi1RdF58divSAzM+5wcro1rH9WAePiQlAjLhyRQGRC1k9zD7TV4H9HAWuIKI9Q65vJB5V69Ga48eh4vgjrztQy9JX8ljBBvngFac54/PzH7tX4WPgAic
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(2616005)(7416002)(956004)(7406005)(44832011)(38350700002)(36756003)(26005)(52116002)(16576012)(86362001)(6486002)(45080400002)(2906002)(83380400001)(186003)(38100700002)(53546011)(4326008)(8936002)(5660300002)(966005)(16526019)(8676002)(31696002)(66946007)(66476007)(31686004)(66556008)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?4clp9HYCfVEAinfrBg2Fj/eAT+WIToUb+Ofu2dWWEGVmzNtmpeUckF/k?=
 =?Windows-1252?Q?/UNkxwbZlRGoitaxG51e00HlB8VW8VSrugPeYguaHF1PoYMR89u7HQjl?=
 =?Windows-1252?Q?ndfit8QHILP7d9OYp3c0V2qnGUFz+ersto52dZZl8zpOUnyOYCMd7miO?=
 =?Windows-1252?Q?mRzemT+2mlI5Iv9CCbtgyqTsErJYqe2BXGOHz1KEjseop1/9pfXJVMK7?=
 =?Windows-1252?Q?ggvuSeyPfS9npeXLIrhyV8eu4sdRA0s2OPGlrr/EEOlR/n1R0/My54FO?=
 =?Windows-1252?Q?FcuttQp51Ui5vUNuwuGhpqMXzBjxsa8ZJbadmk5Hs+KL9NMN4qLRWPjF?=
 =?Windows-1252?Q?+Dp7S6PvmMDJtj5+25qc57gKq2w3qXCbO+LPsR6yKs8WijcE1YFLleD2?=
 =?Windows-1252?Q?4yq/FSappqfiERt6Djv4GSEI18qj0Y0r+RSbPV9/vxuxbzlISG90F++V?=
 =?Windows-1252?Q?hdvKl1u+Mk7wknXMLEwVP/UIjA+mYXEj1pnK+HqTXRdwoBRQ61osSeq+?=
 =?Windows-1252?Q?5IvmTuL79g7Tp8R0iXRlSdGXiHOs5SUX5TTYcu6UQY4VD2vaNb06kD15?=
 =?Windows-1252?Q?VwjZWQzzFDA14/HANyPpJFh7sgnN56RzG7oxEjhkGhoMPOp7pWCEuOGI?=
 =?Windows-1252?Q?wjY+zOF+NAJ+uYaJMz8+qNSweR8GalLNmrI3tF62QXyFiFVnvaKAC8L/?=
 =?Windows-1252?Q?O6yD4diLp6PwIB8DF6444X5tucET5nKKQjISlNP3sO1sZ5NG3Nq2hVAI?=
 =?Windows-1252?Q?JoZ17dyAzPlfW4v91DqZVv3QXfkCIzT6RNysXSmI1XGOQw4FHuPFDlrm?=
 =?Windows-1252?Q?Mi8lU/TqA8qgn2TWFDPRFBSTP/cno3RRtSwSgyz6OCaMt+8iB99AXh/F?=
 =?Windows-1252?Q?jFjy1KUEkNIJaiBbw9fCJs3cns65JhINvVzRMmJ9VKFtldiq5Bhj17eM?=
 =?Windows-1252?Q?Jr2tBJ+ZN06GAeiiz9rwMaWvQyQQKcF1kfHrdljlXbNfkpFZDZAlLesC?=
 =?Windows-1252?Q?QPkhHHAlqfF80IqIN9DOZhcx91tDBF3HITVVqcmFSEg01OQXZk4Ooclg?=
 =?Windows-1252?Q?xCiAXo7ggGvqvJ04rnljOYkHB5cXsd4LZaSx6djuUEHZPkna1DYnu6JP?=
 =?Windows-1252?Q?bzmnZ5HJGHqviqLMVJDifMGXtyeySqBybxKnFZ7Y4NU3qXGx6dnbUDtM?=
 =?Windows-1252?Q?NmSE9xE47PQTNPrpWIozMU1+XDDiLzcTXPAgNz4fEgqOdW6kkHb9vNDF?=
 =?Windows-1252?Q?Yc3/qrUE5I3pA7WCMcSScpPtgmbZgBH78Jp9ddorvYrnrWdyDHSYCp7c?=
 =?Windows-1252?Q?iSvk+9ZHUiVFYQTaYlXgEFUgIOUxzDsKF1xSHX/gB+FewYe9o7XD+ePX?=
 =?Windows-1252?Q?r07WwERLsWOY0YyoKaZm19uQIxoVysWWZAEY61V3jpanN4pbvTLpuBFR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c984584-4ef4-4327-1a81-08d92068406d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 17:03:58.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URSebT8mPyN69SMnP3oL6M92WYo8UuPB/pdxqHcHtpEZy5Xr7OWFCuemYn6kV3sl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2538
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/26/21 11:06 AM, Dave Hansen wrote:
> On 5/26/21 8:25 AM, Babu Moger wrote:
>> On 5/25/21 7:20 PM, Dave Hansen wrote:
>>> On 5/25/21 5:03 PM, Babu Moger wrote:
>>>>> What values do PKRU and the shadow have when the test fails?  Is PKRU 0?
>>>> It goes back to default value 0x55555554. The test is expecting it to be
>>>> 0. Printed them below.
>>>>
>>>> test_ptrace_of_child()::1346, pkey_reg: 0x0000000055555554 shadow:
>>>> 0000000000000000
>>>> protection_keys_64: pkey-helpers.h:127: _read_pkey_reg: Assertion
>>>> `pkey_reg == shadow_pkey_reg' failed.
>>> That's backwards (shadow vs pkru) from what I was expecting.
>>>
>>> Can you turn on all the debuging?
>>>
>>> Just compile with -DDEBUG_LEVEL=5
>>
>> Copied the logs at https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FgtQiHg8Q&amp;data=04%7C01%7Cbabu.moger%40amd.com%7Cf35e0082b0f44650045408d920602c08%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576419688153335%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lkJrEo9EJFhfQcOvS%2Be8gLf0GuqZSWGQw2omPZ2Ehb0%3D&amp;reserved=0
> 
> Well, it's a bit backwards from what I'm expecting.  The PKRU=0 value
> *WAS* legitimate because all of the pkeys got allocated and their
> disable bits cleared.
> 
> I think Andy was close when he was blaming:
> 
>> static inline void write_pkru(u32 pkru)
>> {
> ...
>>         pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
> ...
>>         if (pk)
>>                 pk->pkru = pkru;
>>         __write_pkru(pkru);
>> }
> 
> But that can't be it because PKRU ended up with 0x55555554.  Something
> must have been writing 'init_pkru_value'.
> 
> switch_fpu_finish() does that:

Yes, I have noticed switch_fpu_finish writing init_pkru_value sometimes.
But, I was not sure why that was happening..
> 
>> static inline void switch_fpu_finish(struct fpu *new_fpu)
>> {
>>         u32 pkru_val = init_pkru_value;
> ...
>>         if (current->mm) {
>>                 pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>>                 if (pk)
>>                         pkru_val = pk->pkru;
>>         }
>>         __write_pkru(pkru_val);
> ...
>> }
> 
> If 'new_fpu' had XSTATE_BV[PKRU]=0 then we'd have pk=NULL and 'pkru_val'
> would still have 'init_pkru_value'.  *Then*, we'd have a shadow=0x0 and
> pkru=0x55555554.  It would also only trigger if the hardware has an init
> tracker that fires when wrpkru(0).  Intel doesn't do that.  AMD must.

Ok. I will check with hardware guys here about this behavior.
> 
> Anyway, I need to think about this a bit more.  But, an entirely
> guaranteed to be 100% untested patch is attached.  I'm *NOT* confident
> this is the right fix.
> 
> I don't have much AMD hardware laying around, so testing would be
> appreciated.
> 

Yes. Patch fixes problem on AMD. Also tested on Intel box to make sure it
does not cause any regression there. It does work fine there as well.
Thanks for the patch.
