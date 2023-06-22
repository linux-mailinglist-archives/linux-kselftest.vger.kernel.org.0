Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED82E73AD7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 01:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFVXz6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 19:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVXz5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 19:55:57 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2418AE2;
        Thu, 22 Jun 2023 16:55:56 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-573491c4deeso53602247b3.0;
        Thu, 22 Jun 2023 16:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687478155; x=1690070155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJzEGwP9r/c1ipPx2kdGU8sYecR5Hh2FoT9ASw78Mr8=;
        b=J4iDIgvPbFQQPXU+NmppUoz2GQupEYaVYiebV6iGOwft/gFXBcdfcOiuZo0MQpC6tF
         TuL/tgMIWRwbzfqmFd1VVYoDWWKnTQfUIqscPnoYBR8cYkGTQt8JvSfmje0SG2Adaf6I
         u7AqDeTeYxFc76NHOXROs/4wfLoUHG9OvlZs3wolu1reCoTJLkXRx1bpQlm3XsJFuT0V
         1dZzHsIbkdzc4wmjgN1Lf/geConCB75dsI5mfVm3mFzN3dVDVC76bGJQbMWFuEWgLRzE
         VULcrPAARm1OOWBPk7rcg8pMaINdHBeSCAr40srz8vL4UzEy56Xq3zQUEyTzgdAWfU6m
         at8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687478155; x=1690070155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJzEGwP9r/c1ipPx2kdGU8sYecR5Hh2FoT9ASw78Mr8=;
        b=YnnPS8R0lcEYxYy/G8TyH/mQsbl3H0GlOUjF6uh2zGbhhfC160W85HiK6DcXSPo8B1
         Kb0YVFJ4ZKyS/AU1MhZmCWqFEP0yKbTx3LNPDSDF1D+Qf9iikkYB63jRZSkhJTtm1rZX
         kuA53lfW1m370aSQygntfVupXY9ZqxzvVV1eOjbUNGkY1lDrUa8i142N29tViSonbnUV
         nlrwXtPgDHWrlEmDjsS3qhIKXwcqObTf3e+43gocecY8IU1XOGRKCprBBO5kjW7eFoiI
         cCmQ/aIdm+tt1X7GlH+vHdSLGP8e87LYCm60XF3AdxGqocPrM1efi35JDLkO/4PLjKgl
         cLRw==
X-Gm-Message-State: AC+VfDx0EoBDSs63da3mYyrFUabMEKix2v3I5lGOyI4xxF79KT4yNbTJ
        3TsfXS46wqH3+462BPs6aj4=
X-Google-Smtp-Source: ACHHUZ6Wq0AJZDNFzxNsO6eKScFweN7fjTYpYoigtpmElFu+zXa16bXm7GCEwpcUr9EJ6QXUyrJSBQ==
X-Received: by 2002:a0d:db90:0:b0:56d:2d67:8f78 with SMTP id d138-20020a0ddb90000000b0056d2d678f78mr18764459ywe.26.1687478155165;
        Thu, 22 Jun 2023 16:55:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:bc01:6003:eb6b:c194? ([2600:1700:6cf8:1240:bc01:6003:eb6b:c194])
        by smtp.gmail.com with ESMTPSA id j127-20020a0df985000000b005612fc707bfsm2127772ywf.120.2023.06.22.16.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 16:55:54 -0700 (PDT)
Message-ID: <e22923d0-3241-2b2e-6c9e-c41cd6c10997@gmail.com>
Date:   Thu, 22 Jun 2023 16:55:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
Content-Language: en-US
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
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <461e9be3-d533-d727-8ef9-0e20972ae0b4@iogearbox.net>
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



On 6/22/23 13:06, Daniel Borkmann wrote:
> On 6/22/23 8:28 PM, Yonghong Song wrote:
>> On 6/22/23 10:15 AM, Kui-Feng Lee wrote:
>>> On 6/21/23 20:37, Yonghong Song wrote:
>>>> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>>>>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>>>>> checking skb->sk against sk.
>>>>>
>>>>> The filters were called only if skb is owned by the sock that the
>>>>> skb is sent out through.  In another words, skb->sk should point to
>>>>> the sock that it is sending through its egress.  However, the 
>>>>> filters would
>>>>> miss SYNACK skbs that they are owned by a request_sock but sent 
>>>>> through
>>>>> the listening sock, that is the socket listening incoming connections.
>>>>> This is an unnecessary restrict.
>>>>
>>>> The original patch which introduced 'sk == skb->sk' is
>>>>    3007098494be  cgroup: add support for eBPF programs
>>>> There are no mentioning in commit message why 'sk == skb->sk'
>>>> is needed. So it is possible that this is just restricted
>>>> for use cases at that moment. Now there are use cases
>>>> where 'sk != skb->sk' so removing this check can enable
>>>> the new use case. Maybe you can add this into your commit
>>>> message so people can understand the history of 'sk == skb->sk'.
>>>
>>> After checking the code and the Alexei's comment[1] again, this check
>>> may be different from what I thought. In another post[2],
>>> Daniel Borkmann mentioned
>>>
>>>      Wouldn't that mean however, when you go through stacked devices 
>>> that
>>>      you'd run the same eBPF cgroup program for skb->sk multiple times?
>>>
>>> I read this paragraph several times.
>>> This check ensures the filters are only called for the device on
>>> the top of a stack.  So, I probably should change the check to
>>>
>>>      sk == skb_to_full_sk(skb)
>>
>> I think this should work. It exactly covers your use case:
>>    they are owned by a request_sock but sent through
>>    the listening sock, that is the socket listening incoming connections
>> and sk == skb->sk for non request_sock/listening_sock case.
> 
> Just a thought, should the test look like the below?
> 
>          int __ret = 
> 0;                                                         \
>          if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) 
> {                    \
>                  typeof(sk) __sk = 
> sk_to_full_sk(sk);                           \
>                  if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) 
> &&        \
>                      cgroup_bpf_sock_enabled(__sk, 
> CGROUP_INET_EGRESS))         \
>                          __ret = __cgroup_bpf_run_filter_skb(__sk, 
> skb,         \
>                                                        
> CGROUP_INET_EGRESS); \
>          
> }                                                                      \
> 
> Iow, we do already convert __sk to full sk, so we should then also use that
> for the test with skb_to_full_sk(skb).

Agree!

> 
> Thanks,
> Daniel
