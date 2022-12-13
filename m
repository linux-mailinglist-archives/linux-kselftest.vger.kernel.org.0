Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01A264BBAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 19:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiLMSNh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 13:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiLMSNb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BEEDF04;
        Tue, 13 Dec 2022 10:13:30 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDHlGqa007666;
        Tue, 13 Dec 2022 10:13:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zEzBYA7W9NA4htJza6Dh8FCHT6tr7txAJ6Nk3ELLdnA=;
 b=H/AN1KjVgNeuFOPdmkfo0RFjU0cZxeknytrp9bz+9fhKF6CAmYecJ639sZ69Aa1TVo16
 RMWTizoAz0OhZu7aR70ZeoFziiw2j6OXqEE8tFdpcamUdUt4HGILnWOAIzJRz3Dc8J7y
 KDajK67Dcka/5mTiaODAavdsl81wzII4JBSySaRKHBMAHaHal5x39/cuwQbDco0U7joh
 bUP0jmcjHyWaiHs2HkQBva3x2sVqv6F04U33bO+raU0aGW2c6B73TbyPvaNxgT/MO/qC
 CuRwOUcff5ho4nkpq5Ui9dDtCa2dg5YA3guqme76+OirAC9Z6vOTuwAjzFs+IGXuuY93 OQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4h3nv27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:13:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjU43JTxIps+S5xUVkKB370mPDK7jQ7Oj+PRrrQQMBOY/ffa0vCCh6pTXTcieRaiT6anQX70sRNtuRjRDvJzGgHsDQo5WXuLvqYe9va8jEIolupQ/cEVpEc0MilTQ4hSuyDcg4pepctHMdxUA36vIrK8ZbObKeLnNRBWlGzUHPmdVSr1mIYWktlhlaa0Wo7fAy8TmbmFyE+gpv2CvkX3MROjLj7DCXnPxFCsYjPr9Td3ZJh89uiWnBls4gP4vbQhbb9n/dRBbpv7RWe4JCs4Unpqm75awjiADXU3HM1ZW6ePSE11Fw24qU6g3vZXIkmKGdElW80E6Yl/hmyBlHkqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEzBYA7W9NA4htJza6Dh8FCHT6tr7txAJ6Nk3ELLdnA=;
 b=RihFQO8o2Wah6wxoRlym4/UK4RfXvR7LTzlNVQQ7LD/XjxWaMXtGHuQFrDGF6gyY37QcQldOC/m83knpfmUjCIGoQGdJmrwGwe4hkV1NqljkRM/i4ugPcjPx6aehjVBzrm8ETnNCJFWsTEqIxeN7DMjsUviVKUrH29spzefStN7eyI2FEmaMtw7umk8XCvY2YNo73Ug+8tfl5JXbp8J0k/hRRh1/5wmRVuxRkPekMjIX/3tzfHbQEQZxEI/9McqKLTE1an1j7hhdlZ8D1/HaJIaQ9WDFFXkMPi/q1dZyaHgiJ5sqiAC3BYetDxuRcP1++H/vv2bFk8Dlq/W8KJwkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3741.namprd15.prod.outlook.com (2603:10b6:208:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 18:13:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 18:13:18 +0000
Message-ID: <6d1042d4-fa51-7e9b-42f0-af75ddb705de@meta.com>
Date:   Tue, 13 Dec 2022 10:13:14 -0800
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
 <43e6e9ec-3a0c-7238-30b2-daa7e71b169b@meta.com> <Y5gbg820K5LHI7K6@kroah.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y5gbg820K5LHI7K6@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdfe7eb-2a51-47ac-9ba6-08dadd35b61a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hXhvolYB1tgJfeAnIef1QiXZONDAAny6f5fnjwHraJ3MizErZRG+Jvq+z4w66uWVRlOGjY1T6UfUYv3C4mxzCzhAQwdr1Rqo00BxNw62tkaX7hP8K7L4iTfC7eKSm9elbJFEpexk0ksJxEAUQ8ul9tFwCjHmXIA3w8u/M6BzDXnuzQA8xmQw4eMeFEtZyPrRzg0Ilp9/px3MxoS0br7ehVlq0ZQ0ejUFPYt6vY1rUdWsUhh7xYUuosVD0HkJoKqYSop4CvSrS98nOWKXGTldCjZmV7jUuHAtvO2NOTmpnLcAqtoZ8P2z9B9zWOYi7/6lnVRzlsoFmQ+PqaQnPJQ8nZwuisWJNjkmx7GcAU4xRY+T3Ahzf/TZfn8e8S/8tmlZ3UitRV4t9Fior1Xuzvi/UN5b6ZI3v91w4NaOLpiyC2XHhdn1oJ00p3xDnobjudlepFiY/c3BFWlNKpWyEwKyWGLkTHTgjKO5IsrrYrYTT5NZpZtMwjz5H+pUUMnUlBZkygNdGsN0fCDduIP7F+wWTdSa72iLlvDoZaY37HMkBSlHrK4YfQKEFwM9ngerM7kn69nKHZohXhIGybjBotRAhA7ENZKSOhfY3BxNk24LOTTCvKjZhg1Y4eSB3fPjlD5Cj4z+3hnOFLw8qxtWKwDF+YLhqmRQVSJZ53WnwGLKugYh9CH6b+dmZHfZakCCauMqmRKD48y34mKeDn3b9qP8eLPuP3BQfohTt+PXIemwtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(8936002)(41300700001)(36756003)(54906003)(2906002)(5660300002)(7416002)(186003)(6666004)(53546011)(6512007)(38100700002)(2616005)(4326008)(83380400001)(66476007)(31696002)(86362001)(6486002)(66556008)(8676002)(478600001)(6916009)(316002)(66946007)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDkwcGZsLzBKczQ5enQrNW9qQWhIR1lOS09QczZweU1scDZIQkUveUVIY3R2?=
 =?utf-8?B?NlN6dE9uS0VVMmlNVmVvZWpFcHdHTXduUGZ6T1FGZWovcGRobmNLWVN4M0xO?=
 =?utf-8?B?cWRKaHVtdXZMWlVjMm5DOW5lZFBJNGxOWUx1bGN3SkpaVmZ3YW4yS0lndmc4?=
 =?utf-8?B?Vnp4c2ZBM1JFdmxwK2tOeUNoWmVZOGJUOE1GYVpFOUhUajcraHN4Vy9GQ3VF?=
 =?utf-8?B?RUtrdmkyNXRSbTNzNnNXNXlnTVVJcFowVTFlc1liY1hxWStrenFmOUxIVXdP?=
 =?utf-8?B?ck8xUjVGKzZnTk9jUjMrTHVSWGE4T1JnV0xscVI5L080MDNTZGJhakdERThk?=
 =?utf-8?B?Q1pKQXNOR1h0Q2lDaGlxTy93dGxxazZIelFvOEFrczdCRUN3V2swSDNtdTMx?=
 =?utf-8?B?bDBON2NhNmhWVUVUcE5TYURQSUdEaFFuNG1sbmtsL1lCMmFpNEp2R0J6SHlm?=
 =?utf-8?B?VEJONmQxOUZTZ1ZqQXdxRXZPbjBvMHBBdXZwOVZyK21vVFU1amRBREVqY3ZK?=
 =?utf-8?B?WDJ4UG51Y1RZZDlaV2wwZ2p0VHRaRnRzNlFsR2NtN24rb0t6WUJtbmlFa2F5?=
 =?utf-8?B?d2g5TWVacnJxRWNQK00rNnM3dkJMMTJMTUgzc1FCb24wckFrMGZuU3NhZFZq?=
 =?utf-8?B?WWVQVXlRTnByd1RwNFZPMEUweHF5cWdzRlkyM2kzdUxmeERXVmV5Q2d5dUg3?=
 =?utf-8?B?R2pSTzNlTUlSWkFHSmV3RnhhQjlqM0xsZ3d5UkJMZC9hTVd3VGZPdVcvMmF2?=
 =?utf-8?B?Y1cxNjVtM0ZXMkR2a1IvdUIydkxwbjhvRkhTcE5rTllBRmo3M0RCR2FWOTVR?=
 =?utf-8?B?RUttcHVnZlhJSDltZjNIMnZNUDZGRDB3NXhJUEhiYzNsb29RU2xXOHlFNnJ5?=
 =?utf-8?B?RUhOQ3JjN09YYndxR2R1b0FSVWxxcVZ0aWQ0aXgwYTVhajk2OUdzUTBBVGlS?=
 =?utf-8?B?Yk1ieWhNQk1QNXA2M010VXJKaS9ZNk8vaGRJWjlUKzRPQmpIdERacXd0U2d0?=
 =?utf-8?B?UnFhUllUbEpzcUtmZXBHSXRITmM3UWY5Sy9hUUFSN0FUSlBmMWZZVTZxRnlW?=
 =?utf-8?B?YVNsTEl0cHNRYVJmVTh4d3JmZ29mb2RTZmJRbnEyNWw0TlI2ci9HUDVCd1ly?=
 =?utf-8?B?dlNvQmlVY2p0bkpJRUJZRGg2KzNzK2hwdGxzMGRpMEpUTnVVa3VNYkc1dHQ1?=
 =?utf-8?B?UmFlSXRVcmtxeEJRMkR2ZExqU2dnTC93Uks5eDN0WW5HbFhmMEZibUNoQjZl?=
 =?utf-8?B?SGl3cUlzc2pnOHc3NWgyNEx0SnA5a29ZZzk2bENOM29MVm9zTDRFWHFQUE9u?=
 =?utf-8?B?eVNKNnZLemh6eUROaXUwa1dvZFZSNElGaTZySUlKZ2lvcTV3QkVGZWNIZ2pV?=
 =?utf-8?B?ZERZWlA0Uk9mSUF6blpiRkFJZFJCdVgvU2k4cmRUSkttWVRJOWZoZS9WWXVm?=
 =?utf-8?B?c3RUN2VLOUVhK2lYaDM1WG5BeHU2ZXNwTGsxaHI2WHBvQ3BsUzMvTFAySWQ2?=
 =?utf-8?B?a2NLRTFLZlhDSHBrWTFZaEpoWFR4TmpWRXFEQVhxd3FpNXIrNStod2dNck5O?=
 =?utf-8?B?SGRMUDFDcjR2UWExbGtRemF5clpCMklDVnhXczdQYkRDS29ZSWRnazA1dFdU?=
 =?utf-8?B?NFNVanlXQ3ZuL3dJSjJsRUxyOHkrUXZvLzJGUTNVUThKVmxiZlpOMEV5Yko1?=
 =?utf-8?B?RTc2K041ZEUybHJwS0tTNmdydTFMYjRhRldyN05MUVNIZkh4aFNVeDRmdmtr?=
 =?utf-8?B?MnZoUXJhN3d2Y1cwS3VtL01YOExMQlFJRkptTzNvajNGWkkzMWdXdmEyQThB?=
 =?utf-8?B?Yk5IdEJjL0J2ZTdyUFRMUEkyTWI1ZHJWMTVkbWROUWcrOHhMS1N2T1lkNXFu?=
 =?utf-8?B?M3pVNlZYTGNlSjdJQWRSTkpseG0rS1VjNGIrdmdxVEJ4VkNwV0hGK2VwZEti?=
 =?utf-8?B?QnUxVFFDdUMrOFpEMGNBNFUyc3lMK1drVlZPVGNYOW9xcGlnaU84S0t1WTdu?=
 =?utf-8?B?US9FcjB5ZEdmcjBNcjNSNzF6OG9PejNSa2hIVGMzT011N3Q3aDBrcFlnWUZN?=
 =?utf-8?B?QzFRTDlpemZlVnhlM3RGSzhHRnloM1N6a2RheGQwZjN5c2Q2UTBySk1XYll3?=
 =?utf-8?B?TGN2ZDhWMXBCRG1Vd1dxYVlmUHFpSTJ4MTNpdnNXKzRSSXhsQ1NreE9MZ1BD?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdfe7eb-2a51-47ac-9ba6-08dadd35b61a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 18:13:18.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sOeCDOeuq06XlcEVTvUvU5kEoIOMqsyQGfl3T5n6mIcO7U9gBOapMGFCknXfb8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3741
X-Proofpoint-GUID: DjEvUJj5fBNP7-5MMzy2TGvxo50skXWq
X-Proofpoint-ORIG-GUID: DjEvUJj5fBNP7-5MMzy2TGvxo50skXWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 12/12/22 10:28 PM, Greg KH wrote:
> On Mon, Dec 12, 2022 at 10:39:26AM -0800, Yonghong Song wrote:
>>
>>
>> On 12/12/22 10:20 AM, Greg KH wrote:
>>> On Mon, Dec 12, 2022 at 09:52:03AM -0800, Yonghong Song wrote:
>>>>
>>>>
>>>> On 12/12/22 9:02 AM, Benjamin Tissoires wrote:
>>>>> On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
>>>>> <benjamin.tissoires@redhat.com> wrote:
>>>>>>
>>>>>> Kind of a hack, but works for now:
>>>>>>
>>>>>> Instead of listening for any close of eBPF program, we now
>>>>>> decrement the refcount when we insert it in our internal
>>>>>> map of fd progs.
>>>>>>
>>>>>> This is safe to do because:
>>>>>> - we listen to any call of destructor of programs
>>>>>> - when a program is being destroyed, we disable it by removing
>>>>>>      it from any RCU list used by any HID device (so it will never
>>>>>>      be called)
>>>>>> - we then trigger a job to cleanup the prog fd map, but we overwrite
>>>>>>      the removal of the elements to not do anything on the programs, just
>>>>>>      remove the allocated space
>>>>>>
>>>>>> This is better than previously because we can remove the map of known
>>>>>> programs and their usage count. We now rely on the refcount of
>>>>>> bpf, which has greater chances of being accurate.
>>>>>>
>>>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>>>
>>>>>> ---
>>>>>
>>>>> So... I am a little bit embarrassed, but it turns out that this hack
>>>>> is not safe enough.
>>>>>
>>>>> If I compile the kernel with LLVM=1, the function
>>>>> bpf_prog_put_deferred() is optimized in a weird way: if we are not in
>>>>> irq, the function is inlined into __bpf_prog_put(), but if we are, the
>>>>> function is still kept around as it is called in a scheduled work
>>>>> item.
>>>>>
>>>>> This is something I completely overlooked: I assume that if the
>>>>> function would be inlined, the HID entrypoint BPF preloaded object
>>>>> would not be able to bind, thus deactivating HID-BPF safely. But if a
>>>>> function can be both inlined and not inlined, then I have no
>>>>> guarantees that my cleanup call will be called. Meaning that a HID
>>>>> device might believe there is still a bpf function to call. And things
>>>>> will get messy, with kernel crashes and others.
>>>>
>>>> You should not rely fentry to a static function. This is unstable
>>>> as compiler could inline it if that static function is called
>>>> directly. You could attach to a global function if it is not
>>>> compiled with lto.
>>>
>>> But now that the kernel does support LTO, how can you be sure this will
>>> always work properly?  The code author does not know if LTO will kick in
>>> and optimize this away or not, that's the linker's job.
>>
>> Ya, that is right. So for in-kernel bpf programs, attaching to global
>> functions are not safe either. For other not-in-kernel bpf programs, it
>> may not work but that is user's responsibility to adjust properly
>> (to different functions based on a particular build, etc.).
> 
> So if in-kernel bpf programs will not work or are not safe, how will
> in-kernel bpf programs properly attach?

Currently, there is no tracepoint in bpf subsystem to avoid various
'recursion' issues. So the best approach might be providing a
callback call in related func. e.g., bpf_prog_put_deferred(),
and this callback call will provide a facility to invoke an
hid in-kernel bpf programs. This is similar to tracepoint, but it is
not exposed as a tracepoint and only available to kernel internal users.

But I didn't study the bpf usage in this patch set, but typically
bpf prog is hooked to run in a particular kernel place with bpf prog
reference count inceased so the program won't go away. So I think
once hid layer explicit removes bpf program from that hook and
decrease the reference count, hid layer might do some cleanup
work as prog might be freed anyway already or could be due to
other factors like user space closing prog fd.

> 
> confused,
> 
> greg k-h
