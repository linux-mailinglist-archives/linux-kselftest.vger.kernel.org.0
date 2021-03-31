Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3814934FD75
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhCaJwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 05:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234121AbhCaJvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 05:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617184309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSVEMu/gb4JEhF05TMYdAdHmEbbEjzD0QedOu+4cT4M=;
        b=YPzhK/uRGtIWM4oHLZSrJgD1Y7oP2GCE3//9BZUdA6kqbpejBeMYIAh/a4rwDZfW7RMARv
        xEPZVgT62EsCehzgmPQaq4yy69sbxAh7zfX3I7cHZ/J/ww2KzJXNzgkrGjPU3rBdVs7nmN
        cSzTsYJJ9Os53/m85OJrrZnHbM9Ui94=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-uufBb1v8PWGI1mqewbn1Ug-1; Wed, 31 Mar 2021 05:51:48 -0400
X-MC-Unique: uufBb1v8PWGI1mqewbn1Ug-1
Received: by mail-ed1-f69.google.com with SMTP id bm8so830426edb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 02:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gSVEMu/gb4JEhF05TMYdAdHmEbbEjzD0QedOu+4cT4M=;
        b=hxIjom6BN8Y2/FNfZ4EfpHS7w89m6lSCKrZVmDzo9rmZzfQ8AjWKtVasrd6nXnnOUl
         tGe/5k6GG54IsMQN2ZD12gPZ67h+lz/Emdh2N36Bu0u/LUGusmwa2ipvvuoRp9lCnlJA
         /EqflZh2lt4uxCb4MLzQ3F+XignXjMNdN9PW5/lhTILxk6HmNx0Tyj44MZzOksap2+uu
         n7oqLHSExF3s1rBhcg4/KjikbilFQPcSfMc/3rQcP3bsIuD6Mh13iRJQgimqxw/80vbU
         Ac2TKubL+rp3tsAw8rP5m1CZIgDTHiqJ0nw/Ynfn3PB+QeKByE4W0T/fo3S0eQHsljSn
         1S7w==
X-Gm-Message-State: AOAM531UJU7tdhIO9n75h5ZEmBzN1tAsnnXp4/JWWdueu+hcCmdLdnkN
        mWpwp/F2QwZCN7wnapufCOHE0LtTgISP2jZYSsNPOxNf9+2cWbrI3dkJhMVslJEzaxkOF+WNbG9
        Nq6ZvJh1s7aCZrdcKsMUT8VrQi5T4
X-Received: by 2002:aa7:d954:: with SMTP id l20mr2610480eds.1.1617184306909;
        Wed, 31 Mar 2021 02:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzylwo4hPWcYcmlE62zpzxVfApqIEMleAceptnhOdFIA9MPn6oGC4nNnvquLFXWM5B7Cncu4w==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr2610446eds.1.1617184306509;
        Wed, 31 Mar 2021 02:51:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h17sm1123457eds.26.2021.03.31.02.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:51:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5FCE6181B24; Wed, 31 Mar 2021 11:51:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/5] libbpf: add low level TC-BPF API
In-Reply-To: <48b99ccc-8ef6-4ba9-00f9-d7e71ae4fb5d@iogearbox.net>
References: <20210325120020.236504-1-memxor@gmail.com>
 <20210325120020.236504-4-memxor@gmail.com>
 <CAEf4Bzbz9OQ_vfqyenurPV7XRVpK=zcvktwH2Dvj-9kUGL1e7w@mail.gmail.com>
 <20210328080648.oorx2no2j6zslejk@apollo>
 <CAEf4BzaMsixmrrgGv6Qr68Ytq8k9W+WP6m4Vdb1wDhDFBKStgw@mail.gmail.com>
 <48b99ccc-8ef6-4ba9-00f9-d7e71ae4fb5d@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 31 Mar 2021 11:51:45 +0200
Message-ID: <878s63r6q6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 3/30/21 10:39 PM, Andrii Nakryiko wrote:
>> On Sun, Mar 28, 2021 at 1:11 AM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>>> On Sun, Mar 28, 2021 at 10:12:40AM IST, Andrii Nakryiko wrote:
>>>> Is there some succinct but complete enough documentation/tutorial/etc
>>>> that I can reasonably read to understand kernel APIs provided by TC
>>>> (w.r.t. BPF, of course). I'm trying to wrap my head around this and
>>>> whether API makes sense or not. Please share links, if you have some.
>>>
>>> Hi Andrii,
>>>
>>> Unfortunately for the kernel API part, I couldn't find any when I was working
>>> on this. So I had to read the iproute2 tc code (tc_filter.c, f_bpf.c,
>>> m_action.c, m_bpf.c) and the kernel side bits (cls_api.c, cls_bpf.c, act_api.c,
>>> act_bpf.c) to grok anything I didn't understand. There's also similar code in
>>> libnl (lib/route/{act,cls}.c).
>>>
>>> Other than that, these resources were useful (perhaps you already went through
>>> some/all of them):
>>>
>>> https://docs.cilium.io/en/latest/bpf/#tc-traffic-control
>>> https://qmonnet.github.io/whirl-offload/2020/04/11/tc-bpf-direct-action/
>>> tc(8), and tc-bpf(8) man pages
>>>
>>> I hope this is helpful!
>> 
>> Thanks! I'll take a look. Sorry, I'm a bit behind with all the stuff,
>> trying to catch up.
>> 
>> I was just wondering if it would be more natural instead of having
>> _dev _block variants and having to specify __u32 ifindex, __u32
>> parent_id, __u32 protocol, to have some struct specifying TC
>> "destination"? Maybe not, but I thought I'd bring this up early. So
>> you'd have just bpf_tc_cls_attach(), and you'd so something like
>> 
>> bpf_tc_cls_attach(prog_fd, TC_DEV(ifindex, parent_id, protocol))
>> 
>> or
>> 
>> bpf_tc_cls_attach(prog_fd, TC_BLOCK(block_idx, protocol))
>> 
>> ? Or it's taking it too far?
>> 
>> But even if not, I think detaching can be unified between _dev and
>> _block, can't it?
>
> Do we even need the _block variant? I would rather prefer to take the chance
> and make it as simple as possible, and only iff really needed extend with
> other APIs, for example:
>
>    bpf_tc_attach(prog_fd, ifindex, {INGRESS,EGRESS});
>
> Internally, this will create the sch_clsact qdisc & cls_bpf filter instance
> iff not present yet, and attach to a default prio 1 handle 1, and _always_ in
> direct-action mode. This is /as simple as it gets/ and we don't need to bother
> users with more complex tc/cls_bpf internals unless desired. For example,
> extended APIs could add prio/parent so that multi-prog can be attached to a
> single cls_bpf instance, but even that could be a second step, imho.

While I'm all for simplifying where possible, the question becomes at
what level? I.e., we initially figured we'd expose (most of) the netlink
API in the low-level API (patch 3 in the series) and then have the
bpf_program__* level API be the simple "just attach" one...

We could simplify the low-level one further, of course, for instance by
getting rid of the block stuff entirely, but I don't see much value in
leaving out the support for prio/parent in the bpf_tc_cls_* - we'd have
to make the API extensible so it could be added later anyway, so why not
just include it from the get-go (especially as Kumar has already written
the code?)

-Toke

