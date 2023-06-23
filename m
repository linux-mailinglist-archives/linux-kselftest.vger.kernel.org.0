Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8955A73BC91
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFWQao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFWQan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 12:30:43 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE774189;
        Fri, 23 Jun 2023 09:30:42 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-763a2e39b88so70235185a.1;
        Fri, 23 Jun 2023 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687537842; x=1690129842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOqCSC5tdzLCbXq/0sb8wjpcEBb6jV8Uqij3uN10+vw=;
        b=SH3ij7ZuXtZHKhbDD6govfjr+FG0r9arXUnv0FPvMaZin12UfHv31HhDdOJvyfJMy0
         P28e2mPfrzF2WuLmhUGAYogRFD/+6JRtM0bPJC1hxmp2LGnJEbJTAd9gzdcND4WXgbRj
         7BnJjW5KPiFGMvM2nrlmTGD9TkBZq4V+QGzm/c67p8Idp86PM/xxb++8KxUWp/oHKOhx
         UUnV/3ESMJKdAm0tAavtKDHm61qdXu1jG3vm2kc1K5VdzBpBnjvu6s48VeicYNHDoHBw
         7PP1a6W8knOFqWYf0HaTxSHZb2xC3wk/3IXi4QaDg67yZYnrk9IHPo24V9d3xyGF/JkL
         QLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537842; x=1690129842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOqCSC5tdzLCbXq/0sb8wjpcEBb6jV8Uqij3uN10+vw=;
        b=PmX096ptI53O0vVn60yMM7BX3HBIeVg79XSf7KiH40krHKrgaubjvCOWBWWmfPjCLX
         Cnq/vk4GbST4d5paNSIXonMKjlFDhazlxECO1I/OpycHMR8c+xyNOc/+e89JmOj1XDaw
         OQFNGvgQj8Lm+Sj4++RAJZC81H0kAFtdhA4nM9/aEsl/BqXyTnEKCmS0Um0NwvdLGLIy
         /gleUrZ6Nd691RfkQx0kEo8e8riEbyIFRq6aRN6zUTaJJY54pATxNtoGkQiyY+BUSrDQ
         ewsFg5ZGknl6+n4K2Y/cy7Ghw5EonexJdKMLQfX/lk+VSMIeN3goGTAOOw4B2T9Z/L61
         853g==
X-Gm-Message-State: AC+VfDwmp3Rvo+QchYZmgdvGRoCAk41MQES3B3TANd/gWQL5aa1Aobpv
        1myla/wu75mDptkTbROrIRA=
X-Google-Smtp-Source: ACHHUZ4tROgHRgaJvVY7p6iKKZ9z+MnEUvnQc4olJ8rndxgssNUlGVrktQ9Noc4E0uLc8uRQUNQy+w==
X-Received: by 2002:a05:620a:3d90:b0:763:e0bf:535a with SMTP id ts16-20020a05620a3d9000b00763e0bf535amr6905391qkn.57.1687537841859;
        Fri, 23 Jun 2023 09:30:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:fc87:90dc:8d80:e050? ([2600:1700:6cf8:1240:fc87:90dc:8d80:e050])
        by smtp.gmail.com with ESMTPSA id b142-20020a0dd994000000b0056974f4019esm2551405ywe.6.2023.06.23.09.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:30:41 -0700 (PDT)
Message-ID: <89a2cbd5-a448-c588-ba6a-0ca1a4591856@gmail.com>
Date:   Fri, 23 Jun 2023 09:30:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@meta.com>,
        Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, shuah@kernel.org, john.fastabend@gmail.com,
        sdf@google.com, mykolal@fb.com, linux-kselftest@vger.kernel.org,
        jolsa@kernel.org, haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-2-kuifeng@meta.com>
 <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
 <2693aaa4-eb33-553c-291c-3eb555452ea6@gmail.com>
 <94226479-8d79-cc83-9ecf-6db0b376a7fd@meta.com>
 <461e9be3-d533-d727-8ef9-0e20972ae0b4@iogearbox.net>
 <e22923d0-3241-2b2e-6c9e-c41cd6c10997@gmail.com>
 <674a12a9-3776-1637-f132-9c0bf692b18a@iogearbox.net>
Content-Language: en-US
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <674a12a9-3776-1637-f132-9c0bf692b18a@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/23/23 01:50, Daniel Borkmann wrote:
> On 6/23/23 1:55 AM, Kui-Feng Lee wrote:
>> On 6/22/23 13:06, Daniel Borkmann wrote:
>>> On 6/22/23 8:28 PM, Yonghong Song wrote:
>>>> On 6/22/23 10:15 AM, Kui-Feng Lee wrote:
>>>>> On 6/21/23 20:37, Yonghong Song wrote:
>>>>>> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>>>>>>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>>>>>>> checking skb->sk against sk.
>>>>>>>
>>>>>>> The filters were called only if skb is owned by the sock that the
>>>>>>> skb is sent out through.  In another words, skb->sk should point to
>>>>>>> the sock that it is sending through its egress.  However, the 
>>>>>>> filters would
>>>>>>> miss SYNACK skbs that they are owned by a request_sock but sent 
>>>>>>> through
>>>>>>> the listening sock, that is the socket listening incoming 
>>>>>>> connections.
>>>>>>> This is an unnecessary restrict.
>>>>>>
>>>>>> The original patch which introduced 'sk == skb->sk' is
>>>>>>    3007098494be  cgroup: add support for eBPF programs
>>>>>> There are no mentioning in commit message why 'sk == skb->sk'
>>>>>> is needed. So it is possible that this is just restricted
>>>>>> for use cases at that moment. Now there are use cases
>>>>>> where 'sk != skb->sk' so removing this check can enable
>>>>>> the new use case. Maybe you can add this into your commit
>>>>>> message so people can understand the history of 'sk == skb->sk'.
>>>>>
>>>>> After checking the code and the Alexei's comment[1] again, this check
>>>>> may be different from what I thought. In another post[2],
>>>>> Daniel Borkmann mentioned
>>>>>
>>>>>      Wouldn't that mean however, when you go through stacked 
>>>>> devices that
>>>>>      you'd run the same eBPF cgroup program for skb->sk multiple 
>>>>> times?
>>>>>
>>>>> I read this paragraph several times.
>>>>> This check ensures the filters are only called for the device on
>>>>> the top of a stack.  So, I probably should change the check to
>>>>>
>>>>>      sk == skb_to_full_sk(skb)
>>>>
>>>> I think this should work. It exactly covers your use case:
>>>>    they are owned by a request_sock but sent through
>>>>    the listening sock, that is the socket listening incoming 
>>>> connections
>>>> and sk == skb->sk for non request_sock/listening_sock case.
>>>
>>> Just a thought, should the test look like the below?
>>>
>>>          int __ret = 
>>> 0;                                                         \
>>>          if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) 
>>> {                    \
>>>                  typeof(sk) __sk = 
>>> sk_to_full_sk(sk);                           \
>>>                  if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) 
>>> &&        \
>>>                      cgroup_bpf_sock_enabled(__sk, 
>>> CGROUP_INET_EGRESS))         \
>>>                          __ret = __cgroup_bpf_run_filter_skb(__sk, 
>>> skb,         \
>>> CGROUP_INET_EGRESS); \
>>> }                                                                      \
>>>
>>> Iow, we do already convert __sk to full sk, so we should then also 
>>> use that
>>> for the test with skb_to_full_sk(skb).
>>
>> Agree!
> 
> It would also be useful to do an in-depth analysis for the commit msg in 
> which
> cases the sk == skb->sk matches and sk was not a full sock (but __sk is) 
> given
> the __sk = sk_to_full_sk(sk) exists in the code to document which 
> situation this
> is covering in the existing code (... perhaps it used to work back then for
> synack just that later changes altered it without anyone noticing until 
> now).

I did a test that trace how a packet going through L2TP
devices. I am going to include the analysis of the test and other
related links of discussions in the commit log.
