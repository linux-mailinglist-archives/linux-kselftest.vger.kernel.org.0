Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F478173B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHSDiY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 23:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHSDiV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 23:38:21 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE859B;
        Fri, 18 Aug 2023 20:38:19 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bd0a0a675dso1234619a34.2;
        Fri, 18 Aug 2023 20:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692416299; x=1693021099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmTd9LPLzzWYKe3BqlMTtEt2CsxGySX/14bhS+6KcNo=;
        b=g/LRQqKy++m0sndFrKKwqZAMccTOZ0/tvSbN1sxEsR29MIRiyXp0YIHl+DaLSJgklD
         jF5IBX8YLz9/4UUrAGAjTlzoYLSqmW/3AXwn9GekCH4zU0w4yIgBzcV9q8K0cntkSlLm
         2+KSeAhHcAm50zuaY/FIYh+Jc7GCjloxTka1vX9+eFMKS7l0FBvFqiQ+JB3vu3WUsJoR
         hBGRJNjNBnFMG8zJbvvIs8DqRnQKr7G2JlYXeaaq6SAiHb+bhtj3gzb8sSc6CvfcOQBn
         VcDleBIip5m4isw213VzpTshW5/exltZGgpG8mMlO6t+O35WL9nn9jiD8cEcY34ORtkf
         bqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692416299; x=1693021099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmTd9LPLzzWYKe3BqlMTtEt2CsxGySX/14bhS+6KcNo=;
        b=eVQ407k4TO4KegclkXaWftxTMwezIRC4mWgX4jEQ/UCmGiBNeOn7CHrk3xiSdaa9uC
         21259h7XSTl49xJxAOc0ubuVs1qFc6Vba8xzolJ8ydGy9jTLXSNT1JNaxg1eihOroab0
         kEcB8LP3fxTE2tLFKC2+jhgm8oS98Z1IaQaPNMHGqoRu70NE0emygbF8IqZ8sDEbYBoK
         1s8bRg9HDi++BTZkh47wLdDwSMlo09DLALp6/rw41eHkwo0Sbz280j48jnftdPHupXXy
         98Kapu/W1SXlQ7zE7pMFzCxvGUDS5LbtzAzK2nORrcfI8xG9HqVtJgSdj5X6Uo5e8tAV
         qMvA==
X-Gm-Message-State: AOJu0Yx8z+5m+sH8AmkxNORyqJZpFD/YTrJW8jTpnhAlRVPYylwyA/pX
        hlIkQjy+ugP26/RXlRy5NQI=
X-Google-Smtp-Source: AGHT+IHONxuWE7fXMBMP5Zji20fF4bK2e+h+CQmlY3olaUvkTvy4kiBwPWfbYAjc1gzQv7zmLiQdFA==
X-Received: by 2002:a05:6870:2051:b0:1c0:219b:17f4 with SMTP id l17-20020a056870205100b001c0219b17f4mr1437619oad.5.1692416299037;
        Fri, 18 Aug 2023 20:38:19 -0700 (PDT)
Received: from [192.168.1.12] (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00262d6ac0140sm2434749pji.9.2023.08.18.20.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 20:38:18 -0700 (PDT)
Message-ID: <fb6ec982-a0b4-2217-fda3-151cc37ad9a4@gmail.com>
Date:   Sat, 19 Aug 2023 11:38:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop bug
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Yizhou Tang <tangyeechou@gmail.com>, kernel-patches-bot@fb.com,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
 <20230814134147.70289-2-hffilwlqm@gmail.com>
 <20230817223143.jyclrtf3a6kmtgh5@macbook-pro-8.dhcp.thefacebook.com>
 <fea59b79-3f28-c580-185b-8c64dc21a399@gmail.com>
 <CAADnVQKVKPpbMNV9XNc+yJCuaWRupsB5EBjghv++jGqYTnv6QQ@mail.gmail.com>
From:   Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQKVKPpbMNV9XNc+yJCuaWRupsB5EBjghv++jGqYTnv6QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/8/19 03:59, Alexei Starovoitov wrote:
> On Thu, Aug 17, 2023 at 7:10 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 18/8/23 06:31, Alexei Starovoitov wrote:
>>> On Mon, Aug 14, 2023 at 09:41:46PM +0800, Leon Hwang wrote:
>>>> @@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
>>>>      struct module *tgt_mod;
>>>>      const char *tgt_name;
>>>>      const struct btf_type *tgt_type;
>>>> +    bool tail_call_ctx;
>>>
>>> Instead of extra flag here can you check tgt_prog->aux->tail_call_reachable in check_attach_btf_id()
>>> and set tr->flags there?
>>
>> Should we check tgt_prog->aux->func[subprog]->is_func? Or, tgt_prog->aux->tail_call_reachable
>> is enough?
> 
> Please let the thread continue to a logical conclusion before resending
> new version. Will reply there.

Sorry for the new version without logical conclusion.

I'll do it better in the future.

Additionally, I'm looking forward to fix it, and then planning to add a
feature to trace tailcalls with trampoline.

Thanks,
Leon
