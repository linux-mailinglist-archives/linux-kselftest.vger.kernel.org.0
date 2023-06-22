Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564D73A709
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjFVRQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 13:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVRQD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 13:16:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4610F8;
        Thu, 22 Jun 2023 10:16:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-570808d8ddeso72940157b3.0;
        Thu, 22 Jun 2023 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687454161; x=1690046161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEnAlh0A1rSWWfeD+1Qy14fcJjs4y6p0u8wAzS5Zevk=;
        b=kCDPeH5GLPLUABiTrOFsKoF1oP4qb7vxRBFMKqtz7BFaOHiCEfcDXc+Ay6veL93e73
         mgPka4er5laatRQXQRRTmhMKv1OzygI+3CEUd0ZNq+vpgIfDR2TfkC1CdDsi9odJaAQI
         7tMDuMQRhbMkAgVrB8153sHC98t2v44ufBJCFIxFp4Iv6wUOgAyeK/xG7a5OVWpUH0Rn
         T1V/9k7lhH4Xk+H4XZdwOz/yoDoUHnbGBP3ZVwkDnSF3v3JPSWo1hmMOrGogdisRclRh
         GIygBqHaiKKpBvj1gDH63XYxYc8uhK+GrJ1aaUq7bumsZ2IkQPtdDe8PYnfLlHaokLTP
         qzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454161; x=1690046161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEnAlh0A1rSWWfeD+1Qy14fcJjs4y6p0u8wAzS5Zevk=;
        b=ecPlPHj1lfN3JUxonevfyzHuyIuwUPYUq3zqvtdqCDAQuG+qjEy9+C4/83OMMumHPK
         oqtWlogKEEXa41lMQOXC+tEfP1p9PfGtobIUaYGOgpXBTQEomyocngkOBpE4H0Ol/R26
         +NkABQPaXrccESKYiy08EU2mcpVhrkuZDPE6Snb/+YtkFmiK45Qe2VOsEl3eHdL7LAM0
         OT7Ljxs9Uu3w57Evg2txaXW+fpfju0dDDJ72GFH2xLSp9uce8ala1G0PuqyhqoRH9VPJ
         iDDsjKQgp3KsEG6B0E47p4GyVxIZvIDhcsX9o0gXkGuri9GejNuk1BNHBPbj+uJwSDjF
         8ydg==
X-Gm-Message-State: AC+VfDymyYZDdWHjxcQSn5mDU1JetwQAfm1Bk4G4+Ga6JtmQ+sr4wpFl
        6Zy7c3vCUfFnMVx76rHBLKE=
X-Google-Smtp-Source: ACHHUZ6wllZbiJyF2Efoxd1nUYC7vkzT0xcpxhZwihGL3jUQKSFdPTzcO0F25rmTSuY7b/E9kb1DUg==
X-Received: by 2002:a0d:d0c2:0:b0:570:4842:a59d with SMTP id s185-20020a0dd0c2000000b005704842a59dmr22090007ywd.22.1687454161344;
        Thu, 22 Jun 2023 10:16:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9e96:aa3:eeff:a087? ([2600:1700:6cf8:1240:9e96:aa3:eeff:a087])
        by smtp.gmail.com with ESMTPSA id n187-20020a0dfdc4000000b005731dbd4928sm1915619ywf.69.2023.06.22.10.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 10:16:00 -0700 (PDT)
Message-ID: <2693aaa4-eb33-553c-291c-3eb555452ea6@gmail.com>
Date:   Thu, 22 Jun 2023 10:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, Kui-Feng Lee <thinker.li@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-2-kuifeng@meta.com>
 <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
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



On 6/21/23 20:37, Yonghong Song wrote:
> 
> 
> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>> checking skb->sk against sk.
>>
>> The filters were called only if skb is owned by the sock that the
>> skb is sent out through.  In another words, skb->sk should point to
>> the sock that it is sending through its egress.  However, the filters 
>> would
>> miss SYNACK skbs that they are owned by a request_sock but sent through
>> the listening sock, that is the socket listening incoming connections.
>> This is an unnecessary restrict.
> 
> The original patch which introduced 'sk == skb->sk' is
>    3007098494be  cgroup: add support for eBPF programs
> There are no mentioning in commit message why 'sk == skb->sk'
> is needed. So it is possible that this is just restricted
> for use cases at that moment. Now there are use cases
> where 'sk != skb->sk' so removing this check can enable
> the new use case. Maybe you can add this into your commit
> message so people can understand the history of 'sk == skb->sk'.

After checking the code and the Alexei's comment[1] again, this check
may be different from what I thought. In another post[2],
Daniel Borkmann mentioned

     Wouldn't that mean however, when you go through stacked devices that
     you'd run the same eBPF cgroup program for skb->sk multiple times?

I read this paragraph several times.
This check ensures the filters are only called for the device on
the top of a stack.  So, I probably should change the check to

     sk == skb_to_full_sk(skb)

instead of removing it.  If we remove the check, egress filters
could be called multiple times for a skb, just like what Daniel said.

Does that make sense?

[1] 
https://lore.kernel.org/all/CAADnVQKi0c=Mf3b=z43=b6n2xBVhwPw4QoV_au5+pFE29iLkaQ@mail.gmail.com/
[2] https://lore.kernel.org/all/58193E9D.7040201@iogearbox.net/

> 
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf-cgroup.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 57e9e109257e..e656da531f9f 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct 
>> sock *sk,
>>   #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)                   \
>>   ({                                           \
>>       int __ret = 0;                                   \
>> -    if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == 
>> skb->sk) { \
>> +    if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {               \
>>           typeof(sk) __sk = sk_to_full_sk(sk);                   \
>>           if (sk_fullsock(__sk) &&                       \
>>               cgroup_bpf_sock_enabled(__sk, 
>> CGROUP_INET_EGRESS))           \
> 
