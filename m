Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6C59F6F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 11:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiHXJ5R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiHXJ5Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 05:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D837C79693
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661335034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67TcKJ9jWGMiEw4kg52hWXxqV/N5/I9VlmIszyd4tqI=;
        b=OIHWLoKm7wf1nS8ZjiOdD+eJg2OxmysSSfUtOEODbCccVUPVPOwVSF0hYFO6TqCYmmT7Bp
        bSK4m6wTIis8hNJbomgRPj9/K6w2/yDVl0N/nABXXTDnIXMD5OjNvxNJfh+8XnqZbJmS8+
        Rj4538yRAoT5Svn0R4yQpYP9IXEqcZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-UKr8xtUoP2ye9dDRiSEz7w-1; Wed, 24 Aug 2022 05:57:10 -0400
X-MC-Unique: UKr8xtUoP2ye9dDRiSEz7w-1
Received: by mail-wr1-f69.google.com with SMTP id c6-20020adfa706000000b00222c3caa23eso2662505wrd.15
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 02:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=67TcKJ9jWGMiEw4kg52hWXxqV/N5/I9VlmIszyd4tqI=;
        b=pGmfgAqMLEFtDePj4+WTLQatnabxwLMze0LaDf4mtRuDvGnI20QBkRgCShqh3oQWSI
         3Tsa4LO9Gaw+X7xAgECr1uTlSM36k74izb4oIMjOBGKaTpFt8iwrQpnwExLj+eg6/acI
         s1ZaNU9tYHwgBJBKOIWg9Kt5P/cyQT5lhFvP7NMV9dOxOeDFhIUJ1zygUFeXJ8zCSmmt
         XzAlcw/qOZU4N+VEzIuXu9zQHZ9j2wq4QZIUOhsiWXh5bCmm2EHlgwrI+bmhkLq6fPHR
         aJHX21/YpH2dlJufqpGu0CN86lNEK6hSrBk9b14OcV/CCCi1r+1un+U75bhVLzSWvIq3
         AVUg==
X-Gm-Message-State: ACgBeo2PzWd9fCjTFeEa9Lq6yzTDSMnxu+fa9Odfj7+oqysOWIkpurBJ
        g2K1cAxBERCHyOfN3YpEIEtASDKNVHxCQ6DGRhoLpBB09po8whF0/VBuatCeN2nhShodqFuPJjt
        uvipotL0pyp1tL/KrjwMD7s7L1lIc
X-Received: by 2002:a05:6000:606:b0:225:7264:8f06 with SMTP id bn6-20020a056000060600b0022572648f06mr985419wrb.27.1661335029398;
        Wed, 24 Aug 2022 02:57:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gyv5u3qg2yLq2zqzn2c9wgxUKEY2z8IPI+Y201XRbuYkIl5QRMnrv7NBI5d1k0Z7rQs+kWw==
X-Received: by 2002:a05:6000:606:b0:225:7264:8f06 with SMTP id bn6-20020a056000060600b0022572648f06mr985403wrb.27.1661335029194;
        Wed, 24 Aug 2022 02:57:09 -0700 (PDT)
Received: from [192.168.110.200] (82-65-22-26.subs.proxad.net. [82.65.22.26])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d44cd000000b00222ed7ea203sm16236679wrr.100.2022.08.24.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 02:57:08 -0700 (PDT)
Message-ID: <5bba0f0e-544e-85ef-627b-6dd35244871a@redhat.com>
Date:   Wed, 24 Aug 2022 11:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v8 02/24] bpf/verifier: allow kfunc to read user
 provided context
Content-Language: en-US
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220721153625.1282007-3-benjamin.tissoires@redhat.com>
 <20220722084556.1342406-1-benjamin.tissoires@redhat.com>
 <CAADnVQLypx8Yd7L4GByGNEJaWgg0R6ukNV9hz0ge1+ZdW4mdgQ@mail.gmail.com>
 <CAO-hwJK5v8An5W48x2TDH=iNb49iEbC8uGwMbdCak0Bjnmea+w@mail.gmail.com>
In-Reply-To: <CAO-hwJK5v8An5W48x2TDH=iNb49iEbC8uGwMbdCak0Bjnmea+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 7/25/22 18:36, Benjamin Tissoires wrote:
> On Fri, Jul 22, 2022 at 6:16 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Jul 22, 2022 at 1:46 AM Benjamin Tissoires
>> <benjamin.tissoires@redhat.com> wrote:
>>>
>>> When a kfunc was trying to access data from context in a syscall eBPF
>>> program, the verifier was rejecting the call.
>>> This is because the syscall context is not known at compile time, and
>>> so we need to check this when actually accessing it.
>>>
>>> Check for the valid memory access and allow such situation to happen.
>>>
>>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>
>>> ---
>>>
>>> changes in v8:
>>> - fixup comment
>>> - return -EACCESS instead of -EINVAL for consistency
>>>
>>> changes in v7:
>>> - renamed access_t into atype
>>> - allow zero-byte read
>>> - check_mem_access() to the correct offset/size
>>>
>>> new in v6
>>> ---
>>>   kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 7c1e056624f9..c807c5d7085a 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -248,6 +248,7 @@ struct bpf_call_arg_meta {
>>>          struct bpf_map *map_ptr;
>>>          bool raw_mode;
>>>          bool pkt_access;
>>> +       bool is_kfunc;
>>>          u8 release_regno;
>>>          int regno;
>>>          int access_size;
>>> @@ -5170,6 +5171,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>>>                                     struct bpf_call_arg_meta *meta)
>>>   {
>>>          struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>>> +       enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>          u32 *max_access;
>>>
>>>          switch (base_type(reg->type)) {
>>> @@ -5223,6 +5225,24 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>>>                                  env,
>>>                                  regno, reg->off, access_size,
>>>                                  zero_size_allowed, ACCESS_HELPER, meta);
>>> +       case PTR_TO_CTX:
>>> +               /* in case of a kfunc called in a program of type SYSCALL, the context is
>>> +                * user supplied, so not computed statically.
>>> +                * Dynamically check it now
>>> +                */
>>> +               if (prog_type == BPF_PROG_TYPE_SYSCALL && meta && meta->is_kfunc) {
>>
>> prog_type check looks a bit odd here.
>> Can we generalize with
>> if (!env->ops->convert_ctx_access
> 
> Yep, seems to be working fine for my use case and the test cases I
> have in this series.
> 
>>
>> In other words any program type that doesn't have ctx rewrites can
>> use helpers to access ctx fields ?
>>
>> Also why kfunc only?
>> It looks safe to allow normal helpers as well.
> 
> Well, not sure what is happening here, but if I remove the check for
> kfunc, the test for PTR_TO_CTX == NULL and size == 0 gives me a
> -EINVAL.

I finally managed to track down the issue.

The reason was that if we now call check_mem_access for every function 
check, but also subprogs. And so we ensure that a subprog can access 
context.

This is all fine, but that test now tags the subprog accessing the 
context, even if it is actually null and not accessing it in the code.

So to restore the previous behavior, I am storing 
env->prog->aux->max_ctx_offset in btf_check_subprog_arg_match() and 
restore it after the call to check for the arguments.

See the v9 for the detail in the code.

Cheers,
Benjamin

> 
> The original reason for kfunc only was because I wanted to scope the
> changes to something I can control, but now I am completely out of
> ideas on why the NULL test fails if it enters the if branch.
> 
> Unfortunately I won't have a lot of time this week to tackle this (I
> am on holiday with my family), and next will be tough too (at home but
> doing renovations).
> 
> I can send the fixup to remove the prog_type check as I just made sure
> it works with the selftests. But I won't be able to dig further why it
> fails without the kfunc check, because not enough time and
> concentration.
> 
> Cheers,
> Benjamin

