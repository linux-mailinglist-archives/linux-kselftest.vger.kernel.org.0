Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24064A648
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 18:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiLLRwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 12:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiLLRw0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 12:52:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4C15804;
        Mon, 12 Dec 2022 09:52:18 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCHZDn3001970;
        Mon, 12 Dec 2022 09:52:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=BW8RxOPY4BR32e3X4O5sHtM9JstLJevdNW8v9ImuH1M=;
 b=iq7weq11+Np8qaZkh82kY5sLvE62HmsesiuIBLmMJZdKmM8hHVT+wpEi4ZP5akjIVEgW
 bHZNyqUO4AG0KQ3s66NR2H08+/i25bi5usZhEvsei20oI0HcIGeFvPCmyVbahTub1AbF
 mENDAIre22zzhJMP7yPVmFu2c9Tza6aB4ELtQLpNiTUCkWnhKa1+BU9E3t/dYICZt1PQ
 S1J/ScimNY+fqeo/WW/1NFh18UMBu4FAsko8mD8Ks+RwAb/5zPvQX/i7Hg5k8J9f4u73
 vh4tlFpJNyX/3GXslRuz11eW8F4gw1DJXUd2fikZxwHHSZjxSZODytRdXJhHdb4FgNEA Rw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me494k5by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 09:52:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMHUhMJiOqNr5xjgcj8U+4F9dyRqMDo5NN1HpghW9U8CiP0memh67OUceL9Z2SeY68PXjplnpNRAZ/rv56EJGa8Hwp6vHrA4DwhRVrSMIGKiVc9w91mwXoJ8fRGrNrOwBm6aK81ZBXx/BbpBIWD2eHfpLs7sis+/qsdZgS6F9QbEzzo/rajSDF+44sD9nkk3x6T+ddrehE5HMw02H/T6EC35VmLplHYW17Yx+6WYVFwRLv78KRM/haRA5y5tL/nMJSHxPpp6UP5hLFzo5RmOWZDJT26Lv/Z4G/YKZlkkovPFT3XtnXbn13B/bYn5jdR8QeFz/irTBhfyinBkhUoqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW8RxOPY4BR32e3X4O5sHtM9JstLJevdNW8v9ImuH1M=;
 b=foU1jsXtCGY+IePtdzxncwlMG6rfzU8n4FP0pS+kWBBAErzEtlEqzGJYz0iWtKQjG+qsHJ52k2svU12/CD9HY8l1wTDQO4T8pX2/Zq4bVjoN06mRznm3g5Dvqq2QhlwHkrZriyczzvA6GIQs4XW1RWKmuyywr/N5vgHs0bM0MmfbGEV9T7QVZFGvJ1B4i51SjHyoduKxcV/8QgWInBkooKxAtp6Yyx3Kn7TGESJ3gfvvrg/PHqoLHjTbMNTq2n6AfL22rJeAdx53Lo3RvbBzbMAorGEb9x/2JJw3G3Ye0JJ3UpQvsHsoauNxDvgiqFCSnajkyNW5/x01fR2kjjJZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by IA1PR15MB5396.namprd15.prod.outlook.com (2603:10b6:208:388::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:52:08 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 17:52:08 +0000
Message-ID: <53f21d98-4ee6-c0e9-1c0a-5fae23c1b9a8@meta.com>
Date:   Mon, 12 Dec 2022 09:52:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-6-benjamin.tissoires@redhat.com>
 <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|IA1PR15MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 694a8e57-fb17-4621-b830-08dadc6996bf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5LvU9hzJQ4b4DozLzirTEPYbjZ4+Hl62x1+u54pkw34L+DmbOVx8Lq7f80lXA0FumUg0JTpWTAOLdozVo02GWCyTQ2iCxN+/6eKOybU+tX1uP4mOOwx1ACMZrYByvyWZM5QbuWYxrBL5UK5jz4ZtscPjX8p7HFl8Lhhz40q7PlDpnB1ESnlvcy37/8P//ODokvIlqGUe2wpnx5fhEUrPZctXXCjcA2g7CP7q7zuVgcOQMUC3IUTs7+Awfi1Vbsl85lvuV4121AclXT0azkQvGsOT3hZDjMZV90CveWQaumbfv7kiy5rIFyo6Aw+3LqpJVEnEs+8ytH4r0wU10ionD3eqlMND0qARnyQ7byTNA2XXBQGouHADVp66hVZgCRq3Ho001n6JZW805yfUq5DE6YVn9bpz3nFvdf1f8UMpsZ2/P5/A74LVIevUkqAOHOzw32ITaZ+vURytQ38a5tsPvHVCpIbhjDx/Oa4+pYrNYbhhEns4E6cHEVnpkGdiTzR+ZHIuBEauB+KeMu/KMzhcqGGePusElVUBiwdBcDJHLIYwIeDRxNtkyv9P8gtbgiPUzczksww7AHyCuhdKGnuhwFUnr3jB0TU6qN4M2GUwottEVUp1w5VNNNfiG4J9Zfnr4TRWG/0uH/IzAN3VGRXpgqnyGPYoRz6w5FmvOEJox8s0Zy76u39EFd1mASkcejDVkfpCy7Wc7zUYgeO8RnIxbx6cDMdk0zfH1vGkW1Ojy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(41300700001)(5660300002)(2616005)(7416002)(2906002)(8936002)(36756003)(6512007)(6506007)(186003)(6666004)(53546011)(478600001)(6486002)(316002)(66476007)(66556008)(66946007)(110136005)(4326008)(8676002)(31686004)(38100700002)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhtSm9OWXVZcGdmb29TMUgxM0JOUGlMWmZCcC9vSVA3ZndaSnV1UThJWGZJ?=
 =?utf-8?B?TGtBbXZ4UmQ1UHhoQ0tscjVkQkJLdHlBbHU4ZXVCR2swRlg3V3FyVzVOZGM3?=
 =?utf-8?B?QjVWcTVrWDNqTnZjNEJ5Z1hxbHZtdDBSUGZoWjUrRS81RHdETmpXTmFOcXZN?=
 =?utf-8?B?c0NxanNMOC9yZWxCamIxWTFQM0Joa29ja1o4V2h2aFB5VENweGpvOUFlRWNz?=
 =?utf-8?B?dHQ5SVF1RGc0VEp0ekJJemkvOGw2YmlzcFJ6M1BtdFEvYzdPdnZoMEh4UUtO?=
 =?utf-8?B?UVdKMTZ1UVhMMFJ3V1FSUTBHTGVTeTFjL0o1djFhaEFPUGVvVjRHQUFIOFkr?=
 =?utf-8?B?bGJFdVFLL3pTY2I2dzl5YitoQ0VxQVQrMFUwQldrNEVGK3J2MkJ6aWJYMk82?=
 =?utf-8?B?cEZIOE9UZ3ZONUVMaThaVVJPMG04WDFiczF3VHdVOEhVaG5LZWVwS1VVR1Fr?=
 =?utf-8?B?SjBOdnFOc2xnZUNaejZqaGt4UlMwNGtoN1kwdjlrUXo1MmdtemZsWWs2a1hS?=
 =?utf-8?B?Yk1SMVY0YzlRVlBKZG45bVE3a2g3bEN2aStGdkl2cFZpSGV4NDFsbzhYVGVx?=
 =?utf-8?B?cGhOKy9EWjk4VTY2S1NhY0JYY01RN1RLdEdrbTUyWlF2VTcrR0xiaWxLaFd2?=
 =?utf-8?B?TTZ6d0oybHVPUTYzbCtrN041bWg0a3d1RUxxazJ3OCsvMjUwWXBVL25GZ00w?=
 =?utf-8?B?ZG9XL1o4MEhlbTFwcDhZQnBNZ2ZuQ0dtQTJZOGxWOWJyOTJmblZkdVdmaVUy?=
 =?utf-8?B?RERWQU1qNjlhMTlDVkIzcVo1Z01pUjRtWHJVMTF3MnNndDhZbUJvRjQvdTdW?=
 =?utf-8?B?bVVaRFRlWE85YUF0anh2eTNTRnQvcXlITTRubjlqTW5WWmZMWW83UUwxQ2NV?=
 =?utf-8?B?WEVXNzZoOFhBN0pGQnBtT3NXdDZRVGsxZ3lYU29ZeXdCMEk2czFmZDZ4ME1T?=
 =?utf-8?B?bHUyZzZiMXozc2k0bHdOZ2ViNUpXRE1zREgxVUtwTWVIWGcvY0ZrRkdyNitj?=
 =?utf-8?B?R3U0WFFSdUdKYzA5bUlGYVk1RnJVSXdwdFVZcjQxV2hncHRIU2JyRzF6S2U5?=
 =?utf-8?B?eVV3U2FyNDZBTllvQWRQN1hEZVJPMC9KZUJKclMyNDU3RWkxK1NRUlRvQzNJ?=
 =?utf-8?B?U3UxS1o0QTZrMWNYM0hDR2xuNlB1N3VEb3JXOGJRYS9VUmlCZXBuNTdIKzdV?=
 =?utf-8?B?NVl2ejEySjZFL1h1bU5MMWFMcFg0aGxDU0JYUUhIdzQyaE13SmN2SVZEa2hp?=
 =?utf-8?B?UU1LVEhscjM2S0RBZThRZ1orL25Hc25odC9uVGt2MVNnaXgxOGgzQ0dQblNT?=
 =?utf-8?B?UWx4ZWtKdlhqYXdTbFA1LzVJR1QzWE1MVHJycG1ka2pmZDV1LzBmWHAzSkM3?=
 =?utf-8?B?SkZQSi9wV2RpUnE2Y3RXOFN2eEpEMnFkWHZ3Ui8rUVgydHI4T2kwRzVqcnFO?=
 =?utf-8?B?UEhHQjdDc2NLZ1JsY3dxNXdWbEpLb1RtZzBOUXdNR0JhL1czVHQyM01vZzc3?=
 =?utf-8?B?MXhsR3hyNXZVRHlBOUZYOEgvUUtFd0h2S08xK0RLVlh5ZVRVN216N09PN0d1?=
 =?utf-8?B?dk5oY2k0SE02V0RoeitMcHVVYzVTWnY3bVRzbS9sRXRkWTRkblMweXNWZm9M?=
 =?utf-8?B?UFBlcFd2dnlsSVc1Q1hlWlYzV3JENnl5YXhjdXFreXBZOTlYR3NuZ2tFSEcy?=
 =?utf-8?B?cUtUQklVa2Jwa0phVUN3eWh2c0RBRjZEeHd5L2E1U2p1NUFYMkc1cjVMY1Fs?=
 =?utf-8?B?TkM5dTZEdU1qRTNlQ05pZTJCRWg2c1ZjOHBxMXJTNE9kNG12SzFuWnVOSENR?=
 =?utf-8?B?SkpOdnU4OWpma1FqU3RrRTU4UUZzUkt3VEJsb1orN2Q0SGQvalJtTS9lQXc0?=
 =?utf-8?B?TTdiNXlmcGd6amM3YVp2ZHI3VE9HYzMxb29PSm1xMHMwN0RtdDUzb1M1UDh5?=
 =?utf-8?B?M0NSQXorWFpmenQycEpkbFNDbzVCTEdSTkZoMitjZzVZanNKTkY0VkZEdW4z?=
 =?utf-8?B?RnRPME05c2p5RFl4T1NMUFlWZXB5aTB5OEUzQ041OFpkcHBzZVJzU1B0SEkw?=
 =?utf-8?B?OTRxYmxESWkrbkhxKzlvUTJxUzNXN3dNN3k5dEVlRXVnV21Bd0h3ZEZXcWQv?=
 =?utf-8?B?UktxOXlLcXFsK3F4c3ZkWENLYjZhK05pM3c1QkxwRGgwUjNLQkxKR0hjUnFu?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694a8e57-fb17-4621-b830-08dadc6996bf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:52:08.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPYtoO1MGBBTIxeLkVTT6IWspO5BKPvAUeqzJev71IDhRk5D6ZcVM7AZpXES24sh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5396
X-Proofpoint-GUID: 9C9ik_E1PgQW2jEJgk11QgFG0e1Kgi3K
X-Proofpoint-ORIG-GUID: 9C9ik_E1PgQW2jEJgk11QgFG0e1Kgi3K
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



On 12/12/22 9:02 AM, Benjamin Tissoires wrote:
> On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>>
>> Kind of a hack, but works for now:
>>
>> Instead of listening for any close of eBPF program, we now
>> decrement the refcount when we insert it in our internal
>> map of fd progs.
>>
>> This is safe to do because:
>> - we listen to any call of destructor of programs
>> - when a program is being destroyed, we disable it by removing
>>    it from any RCU list used by any HID device (so it will never
>>    be called)
>> - we then trigger a job to cleanup the prog fd map, but we overwrite
>>    the removal of the elements to not do anything on the programs, just
>>    remove the allocated space
>>
>> This is better than previously because we can remove the map of known
>> programs and their usage count. We now rely on the refcount of
>> bpf, which has greater chances of being accurate.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> ---
> 
> So... I am a little bit embarrassed, but it turns out that this hack
> is not safe enough.
> 
> If I compile the kernel with LLVM=1, the function
> bpf_prog_put_deferred() is optimized in a weird way: if we are not in
> irq, the function is inlined into __bpf_prog_put(), but if we are, the
> function is still kept around as it is called in a scheduled work
> item.
> 
> This is something I completely overlooked: I assume that if the
> function would be inlined, the HID entrypoint BPF preloaded object
> would not be able to bind, thus deactivating HID-BPF safely. But if a
> function can be both inlined and not inlined, then I have no
> guarantees that my cleanup call will be called. Meaning that a HID
> device might believe there is still a bpf function to call. And things
> will get messy, with kernel crashes and others.

You should not rely fentry to a static function. This is unstable
as compiler could inline it if that static function is called
directly. You could attach to a global function if it is not
compiled with lto.

> 
> An easy "fix" would be to tag bpf_prog_put_deferred() with "noinline",
> but it just feels wrong to have that for this specific reason.

This is not a right approach just for this purpose.

> 
> AFAICT, gcc is not doing that optimisation, but nothing prevents it
> from doing it, and suddenly that will be a big whole in the kernel.
> 
> As much as I wish I had another option, I think for the sake of
> everyone (and for my future holidays) I'll postpone HID-BPF to 6.3.
> 
> I actually thought of another way of removing that trampoline call. So
> I'm not entirely going back to the drawing board hopefully.
> 
> [a few hours laters]
> 
> Just as a preview, I am reusing the bpf_link idea: when we call
> hid_bpf_attach_prog(), this creates a bpf_link, and that link is the
> one that needs to be pinned. Whenever all the references of that link
> are dropped, I get called in the link's ->release() function, and I
> can force the unbinding of the hid-device to the program at that time.
> 
> Way safer (no refcount mess up) and no optimisations can interfere,
> now that I am not "tracing" the bpf core code.
> 
> Cheers,
> Benjamin
> 
