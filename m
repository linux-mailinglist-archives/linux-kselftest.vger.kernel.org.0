Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F019034F2D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhC3VMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 17:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232589AbhC3VLq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 17:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617138705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+d8bP069q3cX6KDAKElLY3IDtJwqKEIFpPeGaA7ygUI=;
        b=Ub2QeqstTBgkHHb4YB71HZcPDcD1D8OBIHluROJwc0lTKlTT54iTTw6gcKuX7hBUKLwSis
        zmbbnOu+4CaddyRyR4gXbBXeOJQxLp4128tfsZbSBwyUzKnQdcpSYyB3kol2UWZxsD3SIp
        SzHw2sWv5u5LkjrjCNOqBKPmxPOkFa8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-1r_4TAmhOkGn1ikc7lLfJg-1; Tue, 30 Mar 2021 17:11:43 -0400
X-MC-Unique: 1r_4TAmhOkGn1ikc7lLfJg-1
Received: by mail-ej1-f69.google.com with SMTP id mj6so7709851ejb.11
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Mar 2021 14:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+d8bP069q3cX6KDAKElLY3IDtJwqKEIFpPeGaA7ygUI=;
        b=PrsAgX4KyrrPOLGCHdg9uG5YaZq9L7xeN0DehCmPd7BxgyVTmicn36/8kUoGOg36xJ
         EiYMLv7opv8j4gn5Z4wCQPAKAh1zxwTPaYwl+XA4C8KUZjTPF2N7GtlOC8zfeRLPQGGK
         stvmcTUXTSR76q5dlJNQAKKP9tpX1kYYebHdLrA8uHS/S5N4e+DjnSkvygjqnR2qbeGM
         vZXlQH7xpyie+XMIG7/tWiwghhLap50vzLvDQ6pORebqJqO+Z1FUjDi21SrQMBgfH6VD
         9A7UR4JrVAdtkHZhPVKYo2WVQiP2u6YXnez4lR8MGp5iY5Pn6ataFD4JkrLyRZ2I5pZr
         CKKg==
X-Gm-Message-State: AOAM531T7mo40rBISgrdEgSbS0PL1B4iBu0e5AtcwTQtLTogWYwJNNiK
        0Ka2ODwlb7chWJH8/QHMBPRB0cj+xkUFNdkE2Od+NGQP4AKPo+MwOsSMTtBWlN3G2PkCeHMSOou
        bLCYNqY5UhNC4v36+mhou4geB4npE
X-Received: by 2002:aa7:dd99:: with SMTP id g25mr35237439edv.230.1617138701930;
        Tue, 30 Mar 2021 14:11:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJpDvPkfF2JvU4Dnt65VbU0gbarBWnEYv0TRLdjJSqirTWJtcNED/HKPIR7ly4a5+Y12tJeA==
X-Received: by 2002:aa7:dd99:: with SMTP id g25mr35237420edv.230.1617138701731;
        Tue, 30 Mar 2021 14:11:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r25sm129891edv.78.2021.03.30.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:11:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8EB42180292; Tue, 30 Mar 2021 23:11:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
In-Reply-To: <CAEf4BzaMsixmrrgGv6Qr68Ytq8k9W+WP6m4Vdb1wDhDFBKStgw@mail.gmail.com>
References: <20210325120020.236504-1-memxor@gmail.com>
 <20210325120020.236504-4-memxor@gmail.com>
 <CAEf4Bzbz9OQ_vfqyenurPV7XRVpK=zcvktwH2Dvj-9kUGL1e7w@mail.gmail.com>
 <20210328080648.oorx2no2j6zslejk@apollo>
 <CAEf4BzaMsixmrrgGv6Qr68Ytq8k9W+WP6m4Vdb1wDhDFBKStgw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Mar 2021 23:11:40 +0200
Message-ID: <87czvgqrcj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sun, Mar 28, 2021 at 1:11 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Sun, Mar 28, 2021 at 10:12:40AM IST, Andrii Nakryiko wrote:
>> > Is there some succinct but complete enough documentation/tutorial/etc
>> > that I can reasonably read to understand kernel APIs provided by TC
>> > (w.r.t. BPF, of course). I'm trying to wrap my head around this and
>> > whether API makes sense or not. Please share links, if you have some.
>> >
>>
>> Hi Andrii,
>>
>> Unfortunately for the kernel API part, I couldn't find any when I was working
>> on this. So I had to read the iproute2 tc code (tc_filter.c, f_bpf.c,
>> m_action.c, m_bpf.c) and the kernel side bits (cls_api.c, cls_bpf.c, act_api.c,
>> act_bpf.c) to grok anything I didn't understand. There's also similar code in
>> libnl (lib/route/{act,cls}.c).
>>
>> Other than that, these resources were useful (perhaps you already went through
>> some/all of them):
>>
>> https://docs.cilium.io/en/latest/bpf/#tc-traffic-control
>> https://qmonnet.github.io/whirl-offload/2020/04/11/tc-bpf-direct-action/
>> tc(8), and tc-bpf(8) man pages
>>
>> I hope this is helpful!
>
> Thanks! I'll take a look. Sorry, I'm a bit behind with all the stuff,
> trying to catch up.
>
> I was just wondering if it would be more natural instead of having
> _dev _block variants and having to specify __u32 ifindex, __u32
> parent_id, __u32 protocol, to have some struct specifying TC
> "destination"? Maybe not, but I thought I'd bring this up early. So
> you'd have just bpf_tc_cls_attach(), and you'd so something like
>
> bpf_tc_cls_attach(prog_fd, TC_DEV(ifindex, parent_id, protocol))
>
> or
>
> bpf_tc_cls_attach(prog_fd, TC_BLOCK(block_idx, protocol))
>
> ? Or it's taking it too far?

Hmm, that's not a bad idea, actually. An earlier version of the series
did have only a single set of functions, but with way too many
arguments, which is why we ended up agreeing to split them. But
encapsulating the destination in a separate struct and combining it with
some helper macros might just make this work! I like it! Kumar, WDYT?

-Toke

