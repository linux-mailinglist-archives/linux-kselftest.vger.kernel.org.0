Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902737CCC1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 21:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbjJQTTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbjJQTTY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 15:19:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E4192
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 12:19:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so3740955a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697570356; x=1698175156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiqh505uiYLILkv7e75NKRYSxfkStnbnu54DlF5oIdE=;
        b=DvTgQ7tiVld8Vll0hS+NuZSfsESJZVVtxMFRmx26FU7a7EVYAa2GcBPDgDB1IpVQ1F
         w4NLcSvb0NFDWWmLLunQIfaqkxL5p6M5INMmaII5LtvRiNVIIQmAqzuHPYwLsJf+OM60
         bDH6bYP8nE01wdKL1+sVg/REJjATDBwazSop4chywjuMAYZhCdJPKnFq0M3nCb8nlKrZ
         1pQZKG0+1OmCzR1/4NxfjnCNZQm9w27OzfV/Qi9xM0zUcR3mO7IaFnIFysm1/3cdtHRd
         zBKsKJhPW7VPoHjQRNBS/K6J0aZOGQunoAg4WNn87fIbHANC7CMUSe02fYrPINxIBvRb
         dNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570356; x=1698175156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiqh505uiYLILkv7e75NKRYSxfkStnbnu54DlF5oIdE=;
        b=tdWXEIKJ1nPcDUOArECMHQO4QQRr9y688QOmqaInEJ8HbiSQ8ia4wI2kO20zAmgazP
         NSk/rPm9ysqwkHOO1/QUjYwhoArAydTEZqqSoO4042Up4pBCBpPbkJEUHFwmSwbXYXbv
         q96PDBvTvrlffPKOlRLzpuZ5TUZ53sf8FyfuA1zHovzDjrXWgleCzBhKL9fhzbI6QhRE
         06YGgZ8fCJuoHA20Qn527jGEjpRbHQJFg8OcyFYobtkOe+XKMLt9WiS7sIo5VYdAZx7n
         WOEP9UrkpyxetUc4DyZaDULiQYxZnQhh6UUrsoL6cFem2jd+NwNjFoanZ3KrctubhVKt
         Z6YQ==
X-Gm-Message-State: AOJu0Yy00KR1MuWhVePzgirCIMZXlCRAY9eU/J4lfi2n9CTUfxowESS5
        AccpPQdffJz7/KjcU88RlvATmA==
X-Google-Smtp-Source: AGHT+IG7ROb2Qof/K92C23vIBr2FOYWMjhe4m0RvFW1/lkFkXCPf1s3mpQvmFy3DS4gIcYQSRAO77g==
X-Received: by 2002:a17:90b:1044:b0:27d:3c1a:3d2d with SMTP id gq4-20020a17090b104400b0027d3c1a3d2dmr3206302pjb.21.1697570355901;
        Tue, 17 Oct 2023 12:19:15 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ab38400b0027d0d4d4128sm1656284pjr.25.2023.10.17.12.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:19:15 -0700 (PDT)
Message-ID: <9a4853ad-5ef4-4b15-a49e-9edb5ae4468e@daynix.com>
Date:   Wed, 18 Oct 2023 04:19:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Andrew Melnychenko <andrew@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
 <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/18 4:03, Alexei Starovoitov wrote:
> On Mon, Oct 16, 2023 at 7:38 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Tue, Oct 17, 2023 at 7:53 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Sun, Oct 15, 2023 at 10:10 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/10/16 1:07, Alexei Starovoitov wrote:
>>>>> On Sun, Oct 15, 2023 at 7:17 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>>> index 0448700890f7..298634556fab 100644
>>>>>> --- a/include/uapi/linux/bpf.h
>>>>>> +++ b/include/uapi/linux/bpf.h
>>>>>> @@ -988,6 +988,7 @@ enum bpf_prog_type {
>>>>>>           BPF_PROG_TYPE_SK_LOOKUP,
>>>>>>           BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>>>>>>           BPF_PROG_TYPE_NETFILTER,
>>>>>> +       BPF_PROG_TYPE_VNET_HASH,
>>>>>
>>>>> Sorry, we do not add new stable program types anymore.
>>>>>
>>>>>> @@ -6111,6 +6112,10 @@ struct __sk_buff {
>>>>>>           __u8  tstamp_type;
>>>>>>           __u32 :24;              /* Padding, future use. */
>>>>>>           __u64 hwtstamp;
>>>>>> +
>>>>>> +       __u32 vnet_hash_value;
>>>>>> +       __u16 vnet_hash_report;
>>>>>> +       __u16 vnet_rss_queue;
>>>>>>    };
>>>>>
>>>>> we also do not add anything to uapi __sk_buff.
>>>>>
>>>>>> +const struct bpf_verifier_ops vnet_hash_verifier_ops = {
>>>>>> +       .get_func_proto         = sk_filter_func_proto,
>>>>>> +       .is_valid_access        = sk_filter_is_valid_access,
>>>>>> +       .convert_ctx_access     = bpf_convert_ctx_access,
>>>>>> +       .gen_ld_abs             = bpf_gen_ld_abs,
>>>>>> +};
>>>>>
>>>>> and we don't do ctx rewrites like this either.
>>>>>
>>>>> Please see how hid-bpf and cgroup rstat are hooking up bpf
>>>>> in _unstable_ way.
>>>>
>>>> Can you describe what "stable" and "unstable" mean here? I'm new to BPF
>>>> and I'm worried if it may mean the interface stability.
>>>>
>>>> Let me describe the context. QEMU bundles an eBPF program that is used
>>>> for the "eBPF steering program" feature of tun. Now I'm proposing to
>>>> extend the feature to allow to return some values to the userspace and
>>>> vhost_net. As such, the extension needs to be done in a way that ensures
>>>> interface stability.
>>>
>>> bpf is not an option then.
>>> we do not add stable bpf program types or hooks any more.
>>
>> Does this mean eBPF could not be used for any new use cases other than
>> the existing ones?
> 
> It means that any new use of bpf has to be unstable for the time being.

Can you elaborate more about making new use unstable "for the time 
being?" Is it a temporary situation? What is the rationale for that? 
Such information will help devise a solution that is best for both of 
the BPF and network subsystems.

I would also appreciate if you have some documentation or link to 
relevant discussions on the mailing list. That will avoid having same 
discussion you may already have done in the past.
