Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAA5FF0BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiJNPDq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJNPDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 11:03:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA61CFC71
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 08:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN4+GNFHDwaTMX0ewSvNsXSAm5nQj96NaW2R+fVUkihAMAx25vh6+OMyL4hdSJCkEJvIaCXrOByoS9N8x2ggpo+jW783B9AWeolWccmqoPSquE7/skoTJYqhvgxsp+LXxbL2PibP4fS1OuP4E7AnH5rfGf/MEugkansSplHN4P0SepcyNml2gUAtFh6q9g/60GPmA7TVsTmaT1hHJw0IUQiKdEts1mCbumIAoRLmQFoGKBZSH4fdsx6a9iNKvpkiphOVNn9i/ReTkGaXW6VrA27NIXcOcd2+6jlmeV9CREQRwy3C5r+53y8Xowl2yRB6j358koFqWyQURFhw/zgGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcE0kD7r3fumteFxDNqlZcT+4la4uvQA+XbXPhudgCE=;
 b=cfpX13m/jFvouZv248mBWFNBxwOjxwk785xB78UJ8Tbu52fP0XqfxowQ/Pj2O3Vkb/AYHjhc7JhAspdo25Dfnh+wDsm2V9Wrimumf4Zbi3hldos+CC+66Vlfhxi21Bbl+r028xt7JRB/OxC9+kY3tu9R+JAS1tRAuzCtNVWeTQ6Qqv+TpCUhtwQCKSU+nahpxa2GL0ckto1mnH+1StwOwbKSfRxW4cMhSXsxU8SGYeMyTMe1A+DpXe2J+x8N1FI+/6VO4WKWYug3S6fsMFRbqNOKiwx63xT61sw+MAsU5gjinjRYFqLUZnyZw6k3BlM9LQr4cWtYp0kBIkZ3xt2u2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcE0kD7r3fumteFxDNqlZcT+4la4uvQA+XbXPhudgCE=;
 b=qgQ97eQyZ0rkF2KEj6KVNS2zGuFsyiOdVPsCbsvdqFgmdvuQvSwopmd7d9Y82OCZsrxk4j2H+M4Mx5Yynw9V+V77rK1OdRqOnY2tS8fIeTRGDicrxhtOIxN/vxrUHi4IAuq3nmUL29iCYLMQUVxgI3aGBcN6VBMg8XxJT/f7QGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 15:03:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8%6]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 15:03:41 +0000
Message-ID: <387b3e48-71a4-819d-4ca4-4e83501d9791@amd.com>
Date:   Fri, 14 Oct 2022 11:03:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <Y0lPsbLKZakAGZeZ@nvidia.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <Y0lPsbLKZakAGZeZ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 56536dd8-7e65-4d04-eab6-08daadf54842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDQqgCXvs/fF8ylQWuxALaMNXjSPHnPiKkTy6egrW6+nQ5/CkWxwv62cbRSMj0LfEP/c6/fSmfsCMhjcxSzKoQeznu0PLwBl/yceJ5S1hGNT+PPbCkTHsIAvO8lyOcVqYvQQqyUrxPzo4d1SQGjYmb8S4sW9dGyN8Z/WNh2UQfSqdEzLQ5YGFgwh6pFbqUsbgoNlEWH0uzgnvTJ4lwMEk1WB84O2MsuUPlwBfHuiSVgFAxmiOYXWIe4mf5vifsQxl9Irw3qmEWsvlXEx5n2PkHHeYMUxzFHtQEG/rBeTG5LvMFED03yumX608NN4m/UjAMxGT2eZfqsuEjx+KNjMkCbCofUNK1sW7OzddxO5YHdRkXlHI2L3dM2ApxF6cOfatAiJjFsCScyR6YOQCjOW2A/vFDfeDyzl+dsxAgX47hvA9jN33I2G8fWIWHuBnfrosFemE2qn23Mut+WO4f7kvDh4oKtkVUXKKzIZo3HHugWOX9XeQQpnJhEPHqlbPvSRQyXLdL0iloiaP0iPBC+xl8mIOekM8BbzWJlDbUha3tEJvlnNfz5/reIZbRXPkzVn1d4JOv6QdIMi0zmEuTzMvnwhSVGa42Xc8C0aSiYwqrxPVyDVBDpm365QXDVTgsBFDPulJ40JeqiaxEtVlej9I4d9QuQl1LHn545Lt9pCkuEMIN+TIxGnaFKsEyoVQO8v+J0z4Pt4A4vxYGeO7/Qaxzeiiv/OuNGziYy2hZimvjoRJXM1WgvrMheJjB1BPJET/x55QffSdcElFaSc+qWlGMTRq+ki20IckoGL80Y0FcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(31696002)(86362001)(8676002)(36756003)(26005)(6506007)(4326008)(41300700001)(5660300002)(7416002)(8936002)(66476007)(66556008)(6512007)(478600001)(110136005)(6486002)(66946007)(44832011)(316002)(54906003)(38100700002)(2616005)(4001150100001)(2906002)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE96K21VeW0zaXlYTGpyb0tEbTV4TnphWHBJc1g4UDdJdUgwT2QvMmRDb0d2?=
 =?utf-8?B?Um05YWljN0s1MzBJZTRzMGxnYnBjZFVORmFwTVIyWTFNL2Mzd3d0WTJBMEtJ?=
 =?utf-8?B?S1A4dkJYWlJFYUcwdUJyTWhjMXRPRnpKbzl3b3lGd1pwbmVEVFl5Q2JxOVpi?=
 =?utf-8?B?bEhmL1hBNUpwcmk2R2JVQlpuQ2w3VlUvVGtIQ1hGa2VFYXdWN0NDZjRxelgy?=
 =?utf-8?B?UE1OOTVmOTVURW5PSlBmNEZEcEhsWURqNGZHS1BydFVQNVlyTTEyeExPU05W?=
 =?utf-8?B?WnRzZ0FOQ0VoSFc5eTZFRDRIYkw5TnZHU0VCU0ZYQ2dMcWU0ZWJVUkM5OWI1?=
 =?utf-8?B?dTI5T3hXNXFrRGJ2QklNZC8vUlo2L2o3ejlqb0oydW4zOEowWDRzMWd4Yml0?=
 =?utf-8?B?blFsWUp5WkdlY0lpeHBsVG8vUG9INUhHUmhRMFRhbFg5SmFzU3p0ZCtONVZY?=
 =?utf-8?B?b2xoL1NUekM5bE5YdENmL1JIdmFFOUJiV3N2SFJ2SGJDU24wbWpON0xIK0Fa?=
 =?utf-8?B?Qy9HVlB2RlgxcU8zVlEzMW1wS084c0VkaU1udmpIb2xEaW5UL20ybjRZUkVO?=
 =?utf-8?B?OUxHTW1WZ2l2RmFuRWVqVGJLeXZpMFNRVEpqdllBSGxaMzA4L3FPL3lQWGsz?=
 =?utf-8?B?UmNqbHpKUmd0bFlrY2NqQWQ0SjlXelk5cUNLdXhLTG1oZ3dOUTlHemxWZmFO?=
 =?utf-8?B?TCtBK3J3dGJISlBrWERNK1dQMUVOSzFNVUdBSk5jZCs0TWFFQzg4dEdkSklE?=
 =?utf-8?B?ZVl2RVJKd0tuNUJKTXI2UWJuMVMwZXYwTWFsZTNyS0NBeEpUZS8zeWg0NVlN?=
 =?utf-8?B?c3UzdjdidmlFaTJ1NEVtaHdsbDlBblV5YW8zWVhCVmpnNGN3Q1MwQ0RlUW1L?=
 =?utf-8?B?NzY4RjhNOUliK1IzSUZvWjFYb1g1NnMzS1B5bGkvdEY5NExrLzVmbjRrYXNJ?=
 =?utf-8?B?cFZTakl1RXRwNGxNVlhLM2pzaUtaa3lZZnF2YldMdTNRbUcySXhWcTdBeVJo?=
 =?utf-8?B?QmlleGZMcWM4aVczODgzcksxcmgrNGhwN3dYZENBVVJrdXE4bnNrUENKZE8v?=
 =?utf-8?B?aVJSMnJrR3JEZVlNRkhpVUdNMDZaRmlPNVBENkN1MkpIcHluVFNFWkUvOE5D?=
 =?utf-8?B?QUo0UTBPRld3cnRlNkFEaWhDSWora1RRWm5PWGN1MldxNDEvYXdXdXdlTjJR?=
 =?utf-8?B?bHpSUGllYllKRXVSakRqNzhpd01rVjQyMTl2azExd3ZkMzNybzVDVG0wTHRj?=
 =?utf-8?B?dDBDYmdMbEg1S1RSRDE1ZE1vcEx2Z3JRTzlHT2hKclMrQk9IVXhCcEpEdUdF?=
 =?utf-8?B?bUJLQTNqWmF3ckp6UWZMUDl2Z243TDBidjZyQVpqcGFlZkk4VUxKbDcxdFlF?=
 =?utf-8?B?RC9rNlhLRThPNUxQakZ3aC9IZUxTaHBFbUczOXNKaEdSclBtZjR5ODZGa0Rh?=
 =?utf-8?B?QVUvdkVLTDhFN016TG13bXM2VkxLSDJRQUIxQW0zVlV1RkFDbjFqRmtuYSsz?=
 =?utf-8?B?Zm9MK2RmZVUrOUpNQkxOaVBQbnJ3dkQ3VGp0bjk4OGhZaWRtVjQ2dmg4SDEy?=
 =?utf-8?B?YThJRWpvK2JFcm5nMHF3Zmo4ZUY1STVCQTNyOEJhU0ZVWkVkQzdQck10Qi81?=
 =?utf-8?B?SHFhaUFFa2NWRUdVaVh2Wkh5ZHBxbzdJdnltd2ZEVWEycXRGN2szb21CbGxQ?=
 =?utf-8?B?Y3lJdUU4RVJYUUthWkZTRld5V2xxaERUTHV5Q2NjaW5yVFk3bUgyVk9iYWlT?=
 =?utf-8?B?emlFaUhpVysvWVJVYXFxaUFQM29jelJMT2RPclFKVExYcHB2d2hJVTRkWHd2?=
 =?utf-8?B?WmRpZzV4aGd5Q3RtSzNOYjhvMEpmeTA1TDl1dE1LRnZOV2wydzVUTVU5di9w?=
 =?utf-8?B?S1hOQTJsbittcXVEazJ0bXpZWEFBTGZ2OGxWZ1BUTW01WTRzbUp1ZEhMQkF1?=
 =?utf-8?B?eHV1ZEJTTTZSQUNtRlJYaFVRZXU4WGYvSnpDaUtxNk9wU3pjU2FsRUczb1Nv?=
 =?utf-8?B?K2RkemlYWGxKcjlSdHR3c0IwMkprRWxRa0RhR2x1SHZ0WTdWTk5TZ05wTEcz?=
 =?utf-8?B?QTN3OVhmdzQyc1JmcEt2elJwQmc0VG05MjFFRWJlQk9oVVNkdXVMTmJCUnVV?=
 =?utf-8?Q?UwGTQpSmyyj89xIlIRPtHArC6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56536dd8-7e65-4d04-eab6-08daadf54842
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 15:03:41.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGSI/ZE7z+iEkIFJl+ncbf51U5oHq3PHxFL+66HOenmYaxmNQl27HE1kA44mcDtV0wyOgB1aFyPxcC+JaEMxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 2022-10-14 um 08:01 schrieb Jason Gunthorpe:
> On Thu, Oct 13, 2022 at 06:54:24PM +0200, Vlastimil Babka wrote:
>> Hi,
>>
>> I've been trying the hmm_tests as of today's commit:
>>
>> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
>>
>> and run into several issues that seemed worth reporting.
>>
>> First, it seems the FIXTURE_TEARDOWN(hmm) in
>> tools/testing/selftests/vm/hmm-tests.c
>> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
>> assertion failure. Dunno if it's a kselftests issue or it's a bug to
>> use asserts in teardown. I hacked it up like this locally to proceed:
> I've seen this too in other tests, it is a kselftests bug/limitation,
> AFAIK. You can't use assert macros in those functions.

I vaguely remember looking at this when I reviewed Alex's patches that 
added device-coherent support. We wanted to have these checks in the 
fixture setup so that we wouldn't have to duplicate them in all the tests.

I'm not sure if I missed it in review, and Alex missed it in testing, or 
if this is a regression that happened more recently. Sorry for the 
trouble. It looks like Alistair already figured out a fix.

Regards,
   Felix


>
> Jason
