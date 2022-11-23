Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC9636935
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 19:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiKWSrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 13:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiKWSrj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 13:47:39 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160302671;
        Wed, 23 Nov 2022 10:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBzg9IZp2N8HMLFjbk7euwlzN1AhNRmw+DNqmD5NqC2DCiijVK/5CAn98Iq91EF0WL6VvONmrNTBsu/vW05r8el4OjrbtrDiiU+mhClrj5I8PXJiY2Thnsr9s5YJE2TcoT5hzVBhtylWivjPB3Tx0OkRPF2iFbWTdmWnMDgmsPMXTlXqEabPjIvrp0DVy+UB2kXGN1Ui8jFnSOo9X6s1erwF0Lr5q8TAFJ04o7/h+2UHNK6DFAzJF/IfOzFz/DPU15i3t8S0VQKhdV36NFTW2s7OchUFUkCOfPA26DSvvk+xMlBzYtUOx7ItlV3cp9M7vAgRhkCsMGX2fc8qQNqfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMDXEtRqrX0c3kofuWVh9j+odrBDTAyhTMSuHZK8cAk=;
 b=ItsjB3nnJLm20qD5yRsXRhzkNQDTW7MGkCtmzAzozZ/LitZPfwZ0Xx91hlECmJ0DnSbKksTwnw2lzMx+INfjWkqu5ndD+AIRlkkXqSsmlDN9f9tJaC2OLFb2bL4l6DHDSJo8YOX7votDL+JppPhdHfycPlkxyVZX/Gu1J3W6BmUGFwvUF3VJYC9R6+dDh4RE5XzRSzwOvMFdIZMxolsjtsLbOdxR97Eekd6crOcw68Dp1to55lZXsOQ0FIaUc4nYD8ex9n+QSmmGvfI4AbiRUf9Ir6F2xB2yC+atlztsbbPaz8y5Zdi8difbHDrisJt53TzXYUmCoBJH3nFV4F9JZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMDXEtRqrX0c3kofuWVh9j+odrBDTAyhTMSuHZK8cAk=;
 b=ADnJ/n0NqqCOan60BcGM/ZXhuKc9b55wPjJfgEmsBIIOWl8YLk3YgxUA/ktYWkKXaQxS29rq4sQ7VZNaOSxZGXvJvbGAZu1eyKSTj6HHXyaA4zGzptfVwnHkK5CsdBQw6HNkIKirWrIHcBf1r04sC8JbsHPsj2pnfy0rIw49NY1nJEGSBxfYgZBGbacrc2k5ST6E6J96Ob3fqws/NgW+w+zV86X8xK+bxiTpbvFkJcos1+QGFPBQ5EiWNw95BJ4BkVmZz/5NWBd8A5gk9Cea+49gC6/jrRCNYIQg9iN12nPlUB9P4ua6Fi7ChClCdcoeG0JPaWJejyW9NIlCZ/B14A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18; Wed, 23 Nov 2022 18:47:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 18:47:33 +0000
Message-ID: <3434a2fc-e936-d8c1-8bf9-8d822610f35c@nvidia.com>
Date:   Wed, 23 Nov 2022 18:47:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com>
 <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
 <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bcb5de-bb79-42be-f1d1-08dacd832ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9IDaBIpfst1tGGLWxs9HqrDUd60N6K7ZK5YfULzf4JuXRxanOmJGSI8ixSBseqjn3+AKng90tHDEXApujvEcGX3d7vyYGcin88u115xlPfULmvWpz1miIZRVcEm0k+hwChE2lvtWL06NeTkWXNsEV4JuZoLdv+ONTX+GWBuoabWxcJ+P0nqFlqXAYH9BRruaxH28R3FMFM/9ILuDW5lktI8Dgc17AxyNiQZDhzt/iGfL8GMEQcGbEhKDeCTrvXVoxcXSM2d3/hfPCs7ImLP6sHGw3hNUb6MIZl+vrm1adfftY0CVKueDBve5cXAHoRi1A3LQN/EID/FVPKwXpXkb+0poVGf18Q7sf7KtNdadv3B8qiLg8rXMeH4fbGunISNyCjPyFINUb4N5ftir53qUdhqOlWm0gzV3yXmKW8tpBqqMFXCZFV6ac3ZX5Y87N3SNMKd113GXy9iFrYBBxiKskz70wm/ewBTSqe3Flg2QNjmjz782NyOJOtpSFuwM22AQj3AnofGa8P+B9P1DF6ojyNDg5Q2GTqExpY06eA8z+uT0+PU+28Vv8TfBkyR/K1fqRK6aVd9nh27VZnkYdyLuCOtAWxSmek6xitr/hoKBSU3SLm4NqhiVYpVye5g2GGErlK2wfQx7rmH/Iw/1LYFaIQy4F4dvIXXidmdwqvbOV+UMDj8pzvlRX4pzKOVRrRJ23p2pUIe7dOvv6yGAsPlYeB774PO+A+r5bSfBXi9e1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(31686004)(6486002)(6666004)(478600001)(55236004)(53546011)(6506007)(31696002)(26005)(8676002)(54906003)(6916009)(2906002)(316002)(6512007)(66476007)(66946007)(66556008)(4326008)(86362001)(38100700002)(41300700001)(186003)(36756003)(2616005)(7416002)(5660300002)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JscmNMY2FlZjVNR0V1TEg1emNydzhlekl6cG95WkY4U3lIc1dzRTQrRnBr?=
 =?utf-8?B?Y1dPRjlYWFo3MkRORGFsMHJXNGVTWWY0bFMwM0VHTzdUYnduczBINDA1cWs4?=
 =?utf-8?B?ZkYwNXJrQmt3YmJoQUNVS0hGZHhOMTducE1BSlRqNVVFS2VBUUdxMThOd0p3?=
 =?utf-8?B?Rnl2SklLaXNhNFBCUDMyYWlqUmY5c3luR0d0ZmhwU0FTT2M3ZGtsWFo0WWhn?=
 =?utf-8?B?QStnYWZvamdwY1ZCT2pWWE9hbjczM0c0QjdWQVpuWUZaUGUxRTV0UHBGZE9L?=
 =?utf-8?B?MzBtK2lNOTY2azUyS2xPc2RJQ2lpbFdXR3A5WmsrL0IwaFhVbFFxVkovWEVD?=
 =?utf-8?B?VlRnTE1iL0VlQ2xDRXNmZjlHR3ZnaEZWTE41VVdsUExNRm1FbnJMYlRGV1Bx?=
 =?utf-8?B?YVlVZE9ML0VkK3pzdXp3YmlNL0gzZXMxRitJK2ZiTzQ3SXpjSk0zbWRDdU9Y?=
 =?utf-8?B?QmFnYTk5YlNKb0RrT2F1S1UvTEZsSVpiUzR4eWZoaUx0OVRWNmk3c2FTQ09Q?=
 =?utf-8?B?MEJaYlNGQWt5blBxTXhVK08yTUdPaGtoZ1A3V0l5ZExCcGsyU2ZKNDJNMHBw?=
 =?utf-8?B?VHI3VktLODlac0VzUktSVGdrWVRVZDhwMG9xL3pTMFBUTlVNZGtnazlWY09t?=
 =?utf-8?B?WmgycGxrcG00TVcxdU93bjRib0lCaGxzdnlpcVluN0lEY2UrcldTZ3RyVEQ4?=
 =?utf-8?B?Ky9SZzhVLzRYL0NKbjZwZzgralVCeDdybTBGUXpxRENqQ2JvdTZ1OG8rQTFx?=
 =?utf-8?B?cHBmd3M0VWZJbGo1Qjhac1laMXVYTWNFWWo1M0RwbEs1Y1ptR0pkdzJES3V5?=
 =?utf-8?B?blk0cURrZGlkZE9TNWpkZXlYRXBURi9ibEYwenFXTWVZWUhhanZ2UmluNW9N?=
 =?utf-8?B?VFJhbXowcVBlckNNN0MvSmdMaWxPRlF5TTY2VHExTXBEZE5ud3FsektrQ3Iy?=
 =?utf-8?B?em9uRW5IeDN5ZzUrQTF5WDVRUnBYNjE4QkM2UVozU3BhM1lPckt1RXU4N0tY?=
 =?utf-8?B?TkVDSmk3UXZwZ2E1dDdZckpvNlYwWk9wZCtiTEUrc0F2eHJNTGg0NEFPQm1t?=
 =?utf-8?B?SGtjWUhESHhKSDkxRDEzRTFzYkQzemtLTHYvUFQ4KzBMRUVYRThUL01PaGJo?=
 =?utf-8?B?UDBuTlpqKy9KNnlNYzc1QkR1ZmtIc002TS9XR3ZqNmQra3ZHMEt4L0FEL0Jo?=
 =?utf-8?B?UTdNZEl5U1JCVTNWcWNmWVIwNmw5enB6Mng2cnBmRHg1VUVReGNkZVB5blc4?=
 =?utf-8?B?RktPRkNpRDM3RmpHZ1ZPTCtCWU5tV3JnZlFqK1JQb0tHVU85bTJxa1Zya0F5?=
 =?utf-8?B?RndDT0xtbFdUYjQ0WDdlZlQ2Z1Vpa2xud0Q3d3krcjNqR1YyZ1liY1B4b1Yv?=
 =?utf-8?B?RDR6eWRWZU5waGQvSjJOd2M4VUl4dUJWNXdFR3pBUzUvQ3krM2VhTlRqa01j?=
 =?utf-8?B?V0ZFNmFrNlAyaHFOanA2YzNhNGVOSFMrWTRXcW9ocERCUGt3MkREYkJ5eXA4?=
 =?utf-8?B?QkNsT3ZRV1F0YVNrQzUwZjMxVUlsZlM2c1Jtb2RZSEhxV3g1RGFmbVE4M25B?=
 =?utf-8?B?N1Urbmp1ZlJyekZlSkQ4L0lMMDc2eDFBVTk0bExqV212YmF2WkZ4WGx5ZjRr?=
 =?utf-8?B?Y1Q4ZFlET1BvemxsV2NzaXdiVzNzQWVLSGo1QVFzQnA5ZmhPUmlWZGtYYUQz?=
 =?utf-8?B?c01XVHVnZ09aeHN3NjVWYWQrSElKeUlJMmI4QVJNblM2d1dPalZNdDJqcitS?=
 =?utf-8?B?aHlYU3lWQWtkTGJJb1h3NW0vQmpDVVhwNzlwcitvQ1FNcXpnSERwREVySkZl?=
 =?utf-8?B?d0JURnVuSmF3bXFGV3ZBbDRXbXJsV2Jqcmh0ZUZuN2tYUjZaV04wNkRtN2Jo?=
 =?utf-8?B?L2JPM0w3SzdjS2p2aXhEK0FVRE9vLzlSa0JaS3pVRXRoSXhNUkN2aTFZK0N1?=
 =?utf-8?B?NmhpYTFUdk5ENmJhaEhFMFVpZzdiT0d6YlZlRjl0allXSXRDUi81MjdGMm9T?=
 =?utf-8?B?RC9VOXZnZGJGWm5WWWpldWdwRldrdVRnWlgwSjgxQXhsMGJRM2dTbUV5b3pU?=
 =?utf-8?B?V1NOYkNTZ0ZBU3NzdHY3ZUFzKzh0Nnpxa1I3WjgxcXVKc0MrYXlwMldmSytx?=
 =?utf-8?Q?ARZFnOa7zpsI6W4vybHLx4F3v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bcb5de-bb79-42be-f1d1-08dacd832ea3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 18:47:33.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2uIt2yuMMA/RPwktKvUp7OU4xe76ZjmUjCWciO0oINzpt+ODEdjMJjGjHwk4giedFFk33oh7CKpNz+xrMaW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Benjamin,

On 23/11/2022 14:48, Benjamin Tissoires wrote:

...

>> We have a kernel test that checks for new warning and error messages on
>> boot and with this change I am now seeing the following error message on
>> our Tegra platforms ...
>>
>>    WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
>>
>> I have a quick look at the code, but I can't say I am familiar with
>> this. So I wanted to ask if a way to fix this or avoid this? I see the
>> code returns 0, so one option would be to make this an informational or
>> debug print.
> 
> I am not in favor of debug in that case, because I suspect it'll hide
> too much when getting a bug report. Informational could do, yes.
> 
> However, before that, I'd like to dig a little bit more on why it is
> failing. I thought arm64 now has support of tracing bpf programs, so I
> would not expect this to fail.

Yes it would be great if we could figure out why this is failing.

> Would you mind sending me your .config so I can check in it if you are
> missing anything? I am thinking that maybe I need to also depend on
> BPF_JIT.

It is basically the stock upstream arm64 defconfig, but I will forward 
offline.

Cheers
Jon

-- 
nvpublic
