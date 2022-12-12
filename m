Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872BA64A756
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 19:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiLLSnx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 13:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiLLSnO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 13:43:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058E193E3;
        Mon, 12 Dec 2022 10:39:51 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BCHZ8Tm016782;
        Mon, 12 Dec 2022 10:39:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Fh53JQEotwtK+of5rYpbc6JbinAczzB1mmufMEect6A=;
 b=ahkNBpMICisU0Z1gVgDGNVhtSNrIpHXlNWraEJaOmsvNEPjcgf6t8isvezB/G401pUxG
 eCmp7CumikEkifF0P4ll9HL3ViSqMPLb+bpgyrDkIFg5JuAlNVeauZuFcIGfcjdbH2pR
 RIvwRo8HOx8yXtArxTEkYVw4kKWPrwTf2SGlHLmPPXWF3fG4Iop757bNbuWbRUXB6sAF
 VzN5P2vsSWhOMh7JaenKBpDaCp1i6S68a3uZvI5L8EYLTXxgMfGpkRX+6cmG4bOH9STi
 +OyVJBBi2otThs5baEHMwa//VjFRVY7gi63Ekp8RhPOXzIsX1Y3+rXzwMqhl+Fkism/g ug== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3me5fqtcp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 10:39:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgxtRh06C2Ua3E0wuu8Ny6hMQGSuWIElZ04HlGK9X0kGUNgR3sbsl4Mh5/I6MKKxXWraNEVcZAMrZJGJzt+dTSIaOnX+WKPPTuXImBwpSn0m2SdfZwkiTUgwQFAV2wtQ453sMXzlI1vJteWhvEyBsXYMJ2pZAYAt05j/e0rA30H7rMc9ZeA2cqjr22kkok4aHeweB99yGpZ1ldleVnZIT7ry6839EWXdb6tA6hKXBHZ0Yk9sS4ND/jtUD4EefeEBD+qX0aP55Et7iMl4SBvPfaOcLXl6Wijt7B1cO57NIU8I7hBSkwbqlSfJGNmZaoiccg0/wSuIq4Ke457q1Qk9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh53JQEotwtK+of5rYpbc6JbinAczzB1mmufMEect6A=;
 b=h4j7QYGosPU8POUFdANGebnWqnfwizp6LBk7ZdCKaqeH54x+p0wiwMiRu7ZfNPajyxkpWHor/3qcb9ccCgAhw23GL187br9w3hzQbYJwVCwfmP42tadhyz/JCyqgSZk72t/sADVouW+Ld0uiS5Sv/O60GGf9rMbyFAvpnNs+XvoaKtl3VJlxgMfYe/Qwrna4PPOu2HUF1gFINf1QXYM+Hr85BY/tbK7iziXc7y3rLEy9lYLB3WN2LA0YHJmPalLi+xW5EOxdizBCh3/pjLiW2Uyzu8QrMjDF5rAe+ns08SKJPLbMHtCV2TXl9WBznFQtmANOPdw4MMsMF//8cdPklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BN8PR15MB3345.namprd15.prod.outlook.com (2603:10b6:408:73::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:39:30 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:39:30 +0000
Message-ID: <43e6e9ec-3a0c-7238-30b2-daa7e71b169b@meta.com>
Date:   Mon, 12 Dec 2022 10:39:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-6-benjamin.tissoires@redhat.com>
 <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
 <53f21d98-4ee6-c0e9-1c0a-5fae23c1b9a8@meta.com> <Y5dxAz3QTQnaB71Q@kroah.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y5dxAz3QTQnaB71Q@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|BN8PR15MB3345:EE_
X-MS-Office365-Filtering-Correlation-Id: e3af75dc-6d63-418a-11e6-08dadc703483
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdrgmiKkDj+hA3j6agua0d358FOxzuxSJ86vQEffJFzoQdMrlbIDkHQ5zD28efr002DrHCDL0Vmp/tCAfd5LQt4fT3jR36+Oh9KZ2gE7ohPqCCZCeB0jCc48MZiWDQeCLytYMWnUZ9YfMKwqcm2hytaD4vkls+pTb1rFVRGumPL/hgDp93wBLIxf0dr8lsU0bAqRwJnu4wvDrlQxDWGgP9oJK0fbzZuBCJDsXxR/oap6zpy/xQbyCVvyLJyFKfcCn+vJ2gpphYm8gHvZbY7tpU4zI8aiC4ENzSftxQNqsZwaIrKaKw0qo9RGqhN8BYURn5O+X49225nSuNhU+iF0vkYDBTxCL21/wH8mBh/VLp9ntW0yaGX2v0jgOC+YdkZfa5gc5qugSn7CMEpF1z6e0B3Z1FLwiC7bxFCe64xeE+JyBzWhy15h8VcLUPmXbesPsPy4XQelfarfWcsjY51QUZbLl8F0OtMBTG0s4NfOdpv5C6LjZKphuc+Jn0ZXTnLjTrr2GGyCBTt+g/jRDxkdIgbkF4lGU+KkFF9/gyGt4u7kH8LpbUfZ3Dp07iJYhN978FEpueGABBF+LzrD9orDorglXbO8ZHcY1NrE5FluuWfbzxB53TTfqjevbUmsZRaMc4PxNrtGLcZc54+GmqPKphEGtOEDaNTlk+CajsEewD/nSTFoZdoqoeWYT9SebjoA+kzAT60Napb5kW1CVVHdyaUW+fGwryId7RW73afMjOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(31696002)(36756003)(41300700001)(8936002)(86362001)(5660300002)(7416002)(6512007)(6916009)(6486002)(478600001)(66946007)(66556008)(4326008)(6506007)(8676002)(66476007)(53546011)(6666004)(316002)(54906003)(31686004)(83380400001)(38100700002)(186003)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTd4RjlRQkdZUS9RaEYyOWYzZmtERmljdHFsOXNLdkFaY3J3Q3hJcHpPWURM?=
 =?utf-8?B?NGs2d3ZsZUNscmUySDB1MEFVUFBoWWR2NnpGTmh6RFAxdlYzdkFvckEzYUlH?=
 =?utf-8?B?MlI2TllVVVRhc3BCNVhkdExieVMzcEswaFpES1h3OThVRDVOamlSZ1RqbjFY?=
 =?utf-8?B?VjZHajY4U2tsVFR3VlE5RFhTTTRtMXNiZXA1YUZFRi9tVmg4QkVJN0R5TEZB?=
 =?utf-8?B?TVpVQlpycFRlSW9tN1AwUnFTQmZ0WmN5aEFSOFB1U1BtTnp6d0ZhZTR6U282?=
 =?utf-8?B?dXYvUWJzRlI1aU11VkdFWUNJTzFZaXB3KzYvekRXVTJ5ZmVXRTNHdEtkOXow?=
 =?utf-8?B?WGdNWER3U0I0czZtblIwMkkzWjFlT1VPTGw3UVNZZXlDN0VZOWVkQ1A1dll6?=
 =?utf-8?B?cDFTV2NpR0Z4YU8xd1h4Y2dzQW1iQTh1MXRHMGhrbm1rR0Z6Nk5vbm56YW41?=
 =?utf-8?B?WU1reFJoK08rMWR0UklFRHhnZ3F0QzA5L1hTYS9yR2lwL3ZDVlYrdFBCaTV6?=
 =?utf-8?B?ckdJMm1kWHIxRjBoZ2xLd0oxYTNpbUNCTVdlbGdhSktBUnpOa1NCM0FCMFJn?=
 =?utf-8?B?amNmekgyWUJReVd1OGFIa2ZDSm1RVUF2dlR1Mng0aTFlYzVMeDdhcGtEcG9a?=
 =?utf-8?B?KzZXOXZQeXlBcm56MVYrQnAxNTVtSFJyL0MzT0s2eGZ1bm5lUmFCdjFtMGlq?=
 =?utf-8?B?a3IvMnNjQXgwTTFlNWYwVkVON3ZEMGRkQjdWSUFIeWtJWndCTlRvbW84SnZx?=
 =?utf-8?B?MHlkSTQ1RDF2WXVDaUtlQ09NaE9sblYzcXZqeHc1R0FpWHcwbDZjaGd4bjB4?=
 =?utf-8?B?QVZwYUxFdHcxajlZSXZSOXdBSWJacFd1SFVvNG9TbjdyVGl4SHBJb0dmdEFL?=
 =?utf-8?B?WXNEalJFaU5EaDl6ZlFRTXhScG5xZjhUSjdFVHlkVUNxeFg1QndaYVoyM0w3?=
 =?utf-8?B?aGhRVm0zaUg5VkxudWJobHEwdk9JSHRlRldiRklIMmZORkFiVDVtSnVUaXQw?=
 =?utf-8?B?L3k1TmsvZTFHK2lpMHRJNE5jVmI4MGp0ZkJkMmxaOWxrbjU3Z3FPZ1VaY2t3?=
 =?utf-8?B?dTROcDB4S3VZOE10ODZ3VlBkMDZZelhtdFBMa1U1Tk5YMTJpVDBDNitnVzVO?=
 =?utf-8?B?OGZpaDErS0RQK0dseVJudTFhRHBGcXFORlNlS2lTb1NnekVqZlpHQWdxTWNJ?=
 =?utf-8?B?WnF5Mzg3WWswWFRJK1JoaWQreGZDR1FMK2NCdm9CcTFFL0lVRGtrUERBanNQ?=
 =?utf-8?B?TElpOVpuWEEwV3hzdG4zbmxabU40dTFlNXRaZERvZFluQTBuZGsrT2ZCdXFl?=
 =?utf-8?B?eTZ6SnhDNTg0NTJQb2duaExLbTVETlJnNnU0ZkQ2Q3VsM2xGVGNFQUlabGF6?=
 =?utf-8?B?TENtNlFqcTdUZlgyZG1USXczSW5wdU1BWnhSMURwTG1TWDFuS3c3UlZHTDdS?=
 =?utf-8?B?VU1nMkNodTVkUGtCYTBsN3RyQUxIT2RKZ2V3c0s1UWpmYzg0YUtNaUpVQVVx?=
 =?utf-8?B?NzlSaDAxNnlqSHRNMXRpMEVraFRrTzNFZU45QUJxSGFnOWJXdXFZdXhMdXZi?=
 =?utf-8?B?NGF6UUNqck1rSHdsMEcxSXJQNlkwZmg2aHU4Y2VyK0Rlc0IvWVdxbTB1ZENI?=
 =?utf-8?B?NXpweTZWd0lTY2JoazJEWFNCK0JWYmgyb0Iza2JlZ0w5Y3dDZ3dRVW5wbWIy?=
 =?utf-8?B?d3IyMng4d3ZyYi9zdTJPK25mSUkrY3lub2dQUGRlRFViS2JXSE4wdFlMelVQ?=
 =?utf-8?B?cDVxa0lES1doZ0xjTzl1d3NBNVVrWVZpNmYvMGJUQWRwOGdRWGQ5LzN4SXk1?=
 =?utf-8?B?cEpIMzZkY1NxR1QrcE5LY245ekNKcFhPRVlkeEp5eDlIQ05renMvMVBmcW95?=
 =?utf-8?B?SHpxdWxjWWRWWDBMYlpLRGdXay83Y1VMOW1VTm9DYm5NYUJUVENKb0V4bE5C?=
 =?utf-8?B?MmpPdnJHbkFwL0dSZzJyaHExVS8vZU9aMUo2ZFNMNEpBRzJKUkdLcUgweFYw?=
 =?utf-8?B?VjFvbEJVVVM5NEpHWG1nVWZSdVAyTllkODF4ZjdVbFpENVVnbGpWUlpwLzNR?=
 =?utf-8?B?eUNpRDlsMmlaY0J0N2FLV3h4ZVNrSWFpRjBnQUc2MWgwSjVTZmtKb3Q3VXQ3?=
 =?utf-8?B?OHVQWS9yRjJZdXdudC9LYVpxR1cvZjFwQXhlN0ZSRTFGUEREK1hpWFU5OTN1?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3af75dc-6d63-418a-11e6-08dadc703483
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 18:39:30.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75yJb1k1o4Uype4ef81XUcuSHBzMwSyefCogzm8x9WGIXUQUhqBKZkX4o8+qRU4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3345
X-Proofpoint-ORIG-GUID: MptS_YHdlk6IkaA2r_eN2wa36u1fkoMX
X-Proofpoint-GUID: MptS_YHdlk6IkaA2r_eN2wa36u1fkoMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 12/12/22 10:20 AM, Greg KH wrote:
> On Mon, Dec 12, 2022 at 09:52:03AM -0800, Yonghong Song wrote:
>>
>>
>> On 12/12/22 9:02 AM, Benjamin Tissoires wrote:
>>> On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
>>> <benjamin.tissoires@redhat.com> wrote:
>>>>
>>>> Kind of a hack, but works for now:
>>>>
>>>> Instead of listening for any close of eBPF program, we now
>>>> decrement the refcount when we insert it in our internal
>>>> map of fd progs.
>>>>
>>>> This is safe to do because:
>>>> - we listen to any call of destructor of programs
>>>> - when a program is being destroyed, we disable it by removing
>>>>     it from any RCU list used by any HID device (so it will never
>>>>     be called)
>>>> - we then trigger a job to cleanup the prog fd map, but we overwrite
>>>>     the removal of the elements to not do anything on the programs, just
>>>>     remove the allocated space
>>>>
>>>> This is better than previously because we can remove the map of known
>>>> programs and their usage count. We now rely on the refcount of
>>>> bpf, which has greater chances of being accurate.
>>>>
>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>
>>>> ---
>>>
>>> So... I am a little bit embarrassed, but it turns out that this hack
>>> is not safe enough.
>>>
>>> If I compile the kernel with LLVM=1, the function
>>> bpf_prog_put_deferred() is optimized in a weird way: if we are not in
>>> irq, the function is inlined into __bpf_prog_put(), but if we are, the
>>> function is still kept around as it is called in a scheduled work
>>> item.
>>>
>>> This is something I completely overlooked: I assume that if the
>>> function would be inlined, the HID entrypoint BPF preloaded object
>>> would not be able to bind, thus deactivating HID-BPF safely. But if a
>>> function can be both inlined and not inlined, then I have no
>>> guarantees that my cleanup call will be called. Meaning that a HID
>>> device might believe there is still a bpf function to call. And things
>>> will get messy, with kernel crashes and others.
>>
>> You should not rely fentry to a static function. This is unstable
>> as compiler could inline it if that static function is called
>> directly. You could attach to a global function if it is not
>> compiled with lto.
> 
> But now that the kernel does support LTO, how can you be sure this will
> always work properly?  The code author does not know if LTO will kick in
> and optimize this away or not, that's the linker's job.

Ya, that is right. So for in-kernel bpf programs, attaching to global
functions are not safe either. For other not-in-kernel bpf programs, it
may not work but that is user's responsibility to adjust properly
(to different functions based on a particular build, etc.).

> 
> thanks,
> 
> greg k-h
