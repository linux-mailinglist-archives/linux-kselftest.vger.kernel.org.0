Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2177773A523
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFVPfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjFVPe4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 11:34:56 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736D8135;
        Thu, 22 Jun 2023 08:34:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5700e993f37so11700547b3.0;
        Thu, 22 Jun 2023 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687448094; x=1690040094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNO1bZUUdZQncZNLhfTqahVoegQD9v3GiW3j87Muoio=;
        b=Zzu0hv6LxduhsPHh4hO0E/FOmqAwA/BUWfWKxBy5fzme3qwLxwRc3xJ2z3J5R64xzQ
         XwltgpM7zao+n2e8jHZFW0ocwxXQFiXC0Nvbg/mjUk0Fvuqx3glo9L5TJSVphNxiKmAQ
         xf6GnrcuxklZI8b3Bm91t5c1XytjF7z8faz/FphcIP3jhz7S7050IU3OoG3eJXEXsJ5J
         wceM1zJvXcT9LNw+hC8U1FupUSIkcRa5sW05UjyhXa0qeOEUsnqdayYMrscw1Fe/cgWy
         q1yykU4mnuqP7BnTdJrhgac+rDbpZIhNIp2bLk27hJVKyaZuaxujJ4x7as2JIaqB7CKe
         IbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687448094; x=1690040094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNO1bZUUdZQncZNLhfTqahVoegQD9v3GiW3j87Muoio=;
        b=duDQXrEh1l47tOOiMpUYarnz6O4xRmwABM7QNhBUT2qfjGtjJPgwLk2UVudNQOaaOS
         Y4Z17v1KzwfgavXamg/xUon0ZPnv32srDcWwHDtV+59GgN8zYZEycgJ0JVVSMsodtmOH
         OHieUTxvIylfHWj9BYXSAb0NS+nYozgY0kayGNeR/Snun0X4qPxGZBr6dT4WhhO2/KKf
         81e+pi3RFcImNbnnXSCnuPfQD5kePWWHQFeIhjwOB/hGNHjeNk6TWvuG9s72j/0eA47E
         p+Oj/Hfe/6cxVw2kqmml8bi0JyWoamYXFK/5mGDbahsAX2LkZ8qSokr0GXSYdl/ho5bl
         LWeA==
X-Gm-Message-State: AC+VfDwaBRYWXmvhJdyK0r8p1Ily4IvE5ZDSOrB+FvGobA95nxUe+Q9M
        76TC0DcRa82lwxwPwa1se+w=
X-Google-Smtp-Source: ACHHUZ4dyb4tOrqPXK+4oI7F2fvLfPHeOsdGIDkcv7LfRpvrJSauP1lMoQQyD2de6BFzhNbg74GBuA==
X-Received: by 2002:a81:4e91:0:b0:56f:ecda:b519 with SMTP id c139-20020a814e91000000b0056fecdab519mr21906513ywb.9.1687448094614;
        Thu, 22 Jun 2023 08:34:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9e96:aa3:eeff:a087? ([2600:1700:6cf8:1240:9e96:aa3:eeff:a087])
        by smtp.gmail.com with ESMTPSA id x62-20020a814a41000000b00570253fc3e5sm1846242ywa.105.2023.06.22.08.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:34:54 -0700 (PDT)
Message-ID: <6066b072-b78f-7e8e-6a0b-3ed15349b873@gmail.com>
Date:   Thu, 22 Jun 2023 08:34:52 -0700
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

I will put it down on the next version.

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
