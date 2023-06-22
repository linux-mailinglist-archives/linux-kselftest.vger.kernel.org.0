Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E421573A843
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFVS2d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjFVS2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 14:28:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DFC122;
        Thu, 22 Jun 2023 11:28:30 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MHQTHF027917;
        Thu, 22 Jun 2023 11:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fntdQ/sEPISpqkGfN107BpkMJoD6859V458GBL6LVcI=;
 b=K64F+CxKP9Qsyn8ODdWzlQN6b3G6R8LkWHlhe7HNxiN0d3ezda1DpDfhb1qR4n3D7OGd
 jTVuGQF4G5uqtIQumsVKokHgWHImFQixy9MlyWGeBUj2hbxlAi0MbIXZIcg6xEZjbHF0
 Xn3XUExYBYTkQegWjzPgvvX3LAhGNHGrdUz2upZJALFJuWhA3y4XjPfDnu6ZYRdE8Ul1
 4ZF9n5ZH3Na8F9wVFufbcVWdO9By1a/wbxA3VTzOZSOT00pwTTzSEwxs4mWN4jzu3791
 3fLpNWDPzZTxCzO8cNtOK+r6JvGcI/U1iRCfFDr6JBIHrIKsX8dNZTZQ5neDVMolQg5Q Yg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rby4cwfv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 11:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH5KqmImMWRP3CtKsTvUAMmdawGImJ6MK4BwodLhINCboczkTcZy/9FmZDgBWX7mvcFTyFwXq6FLisEo9m0j4/IBMdDFjVj1iqqkGDNUiCe0NSh9UQjwzFAgMPPFvgTB+Tz85aKEd6DZITec9MtxABaA/3yUsGKtWcM3PnISlX9w+UN3H61yrnGluOSqdn1s0JWjVpvjw88rofFLtaIfis3NIGe4FZpSHilQEMgzww2WWcwN0ZJuFQJDu7d4r2mQU7Rrx3XfAhTeaZzRhajdYGwWN8DTKIORXbiYTygmnUzYpH6biewFz+FcWzLYY7IoPIEZhXBYOXyptUKDq1wxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fntdQ/sEPISpqkGfN107BpkMJoD6859V458GBL6LVcI=;
 b=FIKigpznH5EZvDZK7lUeOAwlMSORqMGM6ORaIFh9oIDM1Jnls5adTR+34OYu/HcMwecJJRIpiKIZSbBeEy/d5aLpAZKbhR0H1y1eeWGAu2Hq4xRr+KQkO3BMnrT1mqVFNKYAYB/LANdfqPVbhz5ycK6ofSLNokIhQWka5Cr93MU77xKEvVe+2wFU43Lug898LH+oS3ibDQS+8Z0JGAg9yPB6rtdC7IoE5mVdR9PfXbWT19+0v459rcN/9dUMj8TTjwinazdc96wMomPqodCK49eRnjc+Gmsfuov8VuDSk1GYp39AwCdsCPvg7TuwBzGG0UHYqFUYtkNugogkJ0qqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5775.namprd15.prod.outlook.com (2603:10b6:208:3f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:28:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 18:28:09 +0000
Message-ID: <94226479-8d79-cc83-9ecf-6db0b376a7fd@meta.com>
Date:   Thu, 22 Jun 2023 11:28:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>,
        Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, kpsingh@kernel.org, shuah@kernel.org,
        john.fastabend@gmail.com, sdf@google.com, mykolal@fb.com,
        linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-2-kuifeng@meta.com>
 <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
 <2693aaa4-eb33-553c-291c-3eb555452ea6@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <2693aaa4-eb33-553c-291c-3eb555452ea6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5955f7-1687-47bb-1b25-08db734e6e35
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1wUoegug3BQ7ysYihOsThHR7Ae1sNW10HCZNWmVOIMEu3r+fUI/x1d+xctxKbf5vfI2QSlbYB9A2Zx9lPqn8J5Sk7zdnj6IBXHjiaSdCMr+KoRysuQNOVAELTUIEvq+wsYFel4bF9fCozNLTihsSUHNrhfoEKrtN8PD7axI+SyOZ8CGhw+4+RWdF9p8HYhS6J440zp6sg2aWDfL1P/b5Awm4o2TdRL5k336gOZpLZBMj16m0UBRUbv7jgIjBrhnqghno4plbExCIRuL+syVw9CKxzs9DHiRn9+uIFWPjKYUuCV6IKNXV7DALlhNXa+eYR4sFWVUWPX/KCMEoLY/2aA19U96/kFMBPaa8MgdMp/1o/ictUTpnrWvNxZCuSlHTIYrCv2qOeO+5eRCgfDBjxn87sIvV/yJ89pV/psn0pBX2v1yodRtn09Nb1hqOSmeYnMrbadnZ7bGAYVGrB3+lbWXlN4R40OCIomc8jFE2QGIl/kl7fZZRwp+EYl7hTxzCSEV+m1RL6BhzPuXB/Gw76+fZWppqgCLjIA/ukTyCg0dev+qEDhr1dsVcaAksacIhuIR2JL/XLwSj7Yw85z/7hCytAkRwezfUbI/n3nT06HgQ2P/Rx46yPjNGp5Vv63AHgytqzMxilVhQeHOWrUCk/wZ01cOEEQlItraqDX0nsTKYz+aOJg1ioyn200+gBrB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(2616005)(86362001)(110136005)(107886003)(478600001)(6666004)(31696002)(186003)(6486002)(966005)(4326008)(41300700001)(316002)(53546011)(31686004)(66556008)(83380400001)(6506007)(66476007)(6512007)(66946007)(8936002)(8676002)(36756003)(7416002)(5660300002)(38100700002)(2906002)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVkxbGg3SDFSNEpTcy93cjVkczdnOHFZWkVJVXM1WXA0OVVZb3BFTGh4NjIx?=
 =?utf-8?B?TUZEbWQxeFBRSkZ2SmNVMEZuOVljZEsxMktGMmE3S0RsMy9Wb3ZwQmlscUlw?=
 =?utf-8?B?UlptWXRacThxMW9nSndsL0ZJNlVXNC9vWktTdXVxWDNPUXVoaFhYV21zSHVo?=
 =?utf-8?B?WE8rdEZtd05TZjFpZXdiczNjbGl2ZTBOaWN2SnJqWDdkdHpGelFVM09YaHA3?=
 =?utf-8?B?VzVtREUzMktyRFI5TElIcWpGRnJTNjc4WDB3clh1Q1JUN1Z2NjFCZ0FtK3RZ?=
 =?utf-8?B?OUVUdHJjeVk1ejlhUCtKWG43T1FwTW9ybEEzRG5wbFFUOEZNVC9lUG11Q3lz?=
 =?utf-8?B?UlluNmdLaEhCeVpiUXN1Tk54RWlTR0thVmN6SEh5MG51WVNMYmtxRXlBMkZ2?=
 =?utf-8?B?dnpNd2NTNkxHcE5FSGlvS1RmZEU2Qy8vZkhlWkU4MU5sU2RpR1lIcUtuRWVn?=
 =?utf-8?B?d0hDaGNQZXNsK1lwcW9LV3NIdGpZeGtEOUlTWUZjZ1J4MWRkNUhEZDhzTlpT?=
 =?utf-8?B?ZlUzbHJpUlcrY05IcWszQ1ozOFZUUjB5OVYyODNyaTlaalVtNU5PYkQwRHNj?=
 =?utf-8?B?RFhIekNURUlpZWFvMjZXbFozWStoc1VoTnc0cGROV2FEYkFpUXNIRWZJVHNK?=
 =?utf-8?B?RHQ3VUs4amFMY2hJNVRyVlBUT3FpaWpFNFVyMTZtSU5VczBuK3JWMGZORDVK?=
 =?utf-8?B?N2Z3ckZQUzYwcTJVR2xJR2p2OXRFS3psR203bnJxMVhsTXZad0hMaGZxT1dM?=
 =?utf-8?B?aHZzM0Y2ZEJQN1dDa0QrS0JhdHdMeXJ2aXF2VmdMNVNEbVR3SlYzSkszRWJ0?=
 =?utf-8?B?TnZTT1hXZ3RNcXJKeTVxNW50cnQyNlc2OTBteUljVjJtQi9pelBBUDFFTE0w?=
 =?utf-8?B?RmNHYkJRRUxnYnVnUkZDUlY4WXp3QWlKYU9FZW9RWXpmRFV3OEg1cGltQUg4?=
 =?utf-8?B?NzB3aXNBTXZPSG54Ry80Um13VjdFUXZTbFNIa0FuZk9ZUmhnNk1OYTlvaVk1?=
 =?utf-8?B?VUNnSXphNE01RlJWKzN6c254MFNONVB2YkRIbE9aRTZqRjZTbDBONWpvL2dQ?=
 =?utf-8?B?ZXBVQnBOU3M2ZHAxbWc3WDZ1b1B0dkFqc2FoalRWNndUNnBjbWxudmZqcDhJ?=
 =?utf-8?B?TmtDb1d3ZlorMWJ5eEduZ1dmZmtCN0J5TFQzQVc4S3Q5S3ByQUZSQ1JnRzFY?=
 =?utf-8?B?dWZyeHJEUEwwUVR6NUNPbzZIdkVPd3AxSkxWVFFHenVWV2gvdUxqQ1hWVUgy?=
 =?utf-8?B?WVEwZGtHbldzbjZXU2dlKzR5dHB5bHAyZE9KT0EraEE3N2FvNndEL2RDMzlz?=
 =?utf-8?B?ZGRFckFpRHpGRmp3UzdIT3ZTYnN3UHdYWkdxQm43YTJiSjV2bWFVNllzdHVt?=
 =?utf-8?B?OWgwY0xiZDBlMFZLdWtLRlp1MFNScFZrY3REUTNFNWFwb2FoVXJqYjhsbm4x?=
 =?utf-8?B?RFd1THpCcnNmODBCdkZnUllWanNqMG91eGVWK3hmTVNQMzZuMS9YM3JWZDBw?=
 =?utf-8?B?dGpqVy9Kdi85aklkbDdvRjRLQW5vTWRGQys3Y1hBYmJFcDBkaUc1U09mbFV1?=
 =?utf-8?B?ZUwyK05NbFk3amx6ZjdPd0ozTEhYekQ3VFoxclBlVG42WXRrMzdmTkVQQURm?=
 =?utf-8?B?dFh5bDlWSGJNVlQ5MTYxdVRCbEVuN0RrVitVMC8vT0pmeUhFZmh6S2Vwd3o4?=
 =?utf-8?B?NExUQ1p6RXBuajZhZFUwa3pGTml6WEpnN0FacHZvNWhwKzQwVU1IbnZudTBm?=
 =?utf-8?B?UWtuYldCT2ovRDBKZnJ5c2JKV1FoY1VXWDIxWU9SMVZHeVpJeFIyWlMzOG53?=
 =?utf-8?B?RCt2Z3MxK0xZUFZ3bHU0aCt3ZnlyQTFzdU9QcEttSmZRWkN0NnB1aU1wMytv?=
 =?utf-8?B?bUw3RXVRaytKb2JLalpPbDdBcXRQQWJoNjVzOEt4RVBuUU9YVEg0MXFSaVNx?=
 =?utf-8?B?OWNoaktjS3NyWDFDelNCaGRoT3B2cmJOc1hTTjRTSmZHTEQwOEQycnk2TU1J?=
 =?utf-8?B?QjIvZWZDc0FkUXpKK2pTamdvQlBGOEUwenk2UTBHeXVSZzlGNFVncWxRM0Rt?=
 =?utf-8?B?eHI1VHZFdktiYmZ2dlNiV2xNR2YxZkJoSTVaei9XSUdrcWExWEt6TlJ1V1hL?=
 =?utf-8?B?dldHb0k3SFExTHUxTUZHcW9XTEZkMEx6MkIzd0NJYzBNZG9XZHk1WHpIajdZ?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5955f7-1687-47bb-1b25-08db734e6e35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:28:09.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSPp6Pg7Nk8n0DJzS1zcRIOl5XInYstxOpESyhGH/kk+o9dX3fxP+KcdYDlhSJiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5775
X-Proofpoint-GUID: tuiRt2roKvIM3pSPg4MD7b0gnH74CoMe
X-Proofpoint-ORIG-GUID: tuiRt2roKvIM3pSPg4MD7b0gnH74CoMe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_14,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/22/23 10:15 AM, Kui-Feng Lee wrote:
> 
> 
> On 6/21/23 20:37, Yonghong Song wrote:
>>
>>
>> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>>> checking skb->sk against sk.
>>>
>>> The filters were called only if skb is owned by the sock that the
>>> skb is sent out through.  In another words, skb->sk should point to
>>> the sock that it is sending through its egress.  However, the filters 
>>> would
>>> miss SYNACK skbs that they are owned by a request_sock but sent through
>>> the listening sock, that is the socket listening incoming connections.
>>> This is an unnecessary restrict.
>>
>> The original patch which introduced 'sk == skb->sk' is
>>    3007098494be  cgroup: add support for eBPF programs
>> There are no mentioning in commit message why 'sk == skb->sk'
>> is needed. So it is possible that this is just restricted
>> for use cases at that moment. Now there are use cases
>> where 'sk != skb->sk' so removing this check can enable
>> the new use case. Maybe you can add this into your commit
>> message so people can understand the history of 'sk == skb->sk'.
> 
> After checking the code and the Alexei's comment[1] again, this check
> may be different from what I thought. In another post[2],
> Daniel Borkmann mentioned
> 
>      Wouldn't that mean however, when you go through stacked devices that
>      you'd run the same eBPF cgroup program for skb->sk multiple times?
> 
> I read this paragraph several times.
> This check ensures the filters are only called for the device on
> the top of a stack.  So, I probably should change the check to
> 
>      sk == skb_to_full_sk(skb)

I think this should work. It exactly covers your use case:
   they are owned by a request_sock but sent through
   the listening sock, that is the socket listening incoming connections
and sk == skb->sk for non request_sock/listening_sock case.

I originally though whether you could do
   sk == skb->sk || skb->sk->sk_state == TCP_NEW_SYN_RECV
but obviously your approach is better.

> 
> instead of removing it.  If we remove the check, egress filters
> could be called multiple times for a skb, just like what Daniel said.
> 
> Does that make sense?
> 
> [1] 
> https://lore.kernel.org/all/CAADnVQKi0c=Mf3b=z43=b6n2xBVhwPw4QoV_au5+pFE29iLkaQ@mail.gmail.com/
> [2] https://lore.kernel.org/all/58193E9D.7040201@iogearbox.net/
> 
>>
>>>
>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>> ---
>>>   include/linux/bpf-cgroup.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>>> index 57e9e109257e..e656da531f9f 100644
>>> --- a/include/linux/bpf-cgroup.h
>>> +++ b/include/linux/bpf-cgroup.h
>>> @@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct 
>>> sock *sk,
>>>   #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)                   \
>>>   ({                                           \
>>>       int __ret = 0;                                   \
>>> -    if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == 
>>> skb->sk) { \
>>> +    if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {               \
>>>           typeof(sk) __sk = sk_to_full_sk(sk);                   \
>>>           if (sk_fullsock(__sk) &&                       \
>>>               cgroup_bpf_sock_enabled(__sk, 
>>> CGROUP_INET_EGRESS))           \
>>
