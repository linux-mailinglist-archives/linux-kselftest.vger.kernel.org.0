Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01C7A0E78
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 21:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjINTre (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINTre (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 15:47:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB82698;
        Thu, 14 Sep 2023 12:47:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5007616b756so2215572e87.3;
        Thu, 14 Sep 2023 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694720848; x=1695325648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtprqRWjjPvRfIDAlcNH4nik58BKZh2xiWkpAj29BbM=;
        b=p0IXen1ugDCvaG1uDYqkU6pSr9Ez5MmBpklRdT/HH7qixZeBLQSu2T/6PnIuWRaai+
         TROuPBLdTuqI2S9YQ8AtV4LHoxVIOIWm27reJtcKNN8o3BDuytZR89qpgFBjZR3ZGSTj
         gL7Jk1KJqqJdg87bs75Dn0l73DV1M+z4VkpnRrRQAzm73zJ/bGv5z3qz7ixBhMU8P4tk
         ZSeQCA4r937ir/hZc5+VhLwGxMplVJGmj35wPIMpsAKgJXzX7mJTQz7BdI2l6UsZztlH
         2d8i4rhGmUuCJc3uvdA5Wj5MnvmHfKTHWu4STtT1mCJprJW4ayC4f4rW4GzFYnTotURH
         oTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694720848; x=1695325648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtprqRWjjPvRfIDAlcNH4nik58BKZh2xiWkpAj29BbM=;
        b=TEG0xa6HDU3p7xuCKaodDKMOdErpGQRcyInKwQEfJ5WQxJkXWOvMLbHLIeTYxvrlol
         kdY/qsxym2UcTkrNjX+rdMRAvtY5DJiZ1L9MwcI7CHCSGDW6trXQKt2AOF4FqFWN/SZ8
         eqprvOikx4Fmh0tDlvbYh3cF2hFEUlxwVKLsHRgwoHIAs7XYOQ+GCgmZ1CIAkPV95JSr
         HT6+ZdrIiN7Gvasii3lynfXfM8Clv1qUWXXrNt5k43n3ysZ8ec7FIKx9zYCEppETGfbH
         OOrHA1d9J8mAIQ2zrw//6Z5q8bWz8Hj1CWIRimwLdpd4wFFuInhyMA2EAQbE6nyfFz2y
         AV4A==
X-Gm-Message-State: AOJu0YzWS9NJml6o12BQ64/jDkexB2FWf3NrsUjHKv9BCTV0XW3zgBJM
        k+y8EwiyOZncS3ke+zttJ5ZcJ3cxQmawHpzLz0v9V+7oECw=
X-Google-Smtp-Source: AGHT+IGGsxb29ulva7qi96je+NUvGWwXoUkFSCWbZaM05+K3BskEWVT/4/8Hwu7/CMxfzOXW7W1lKNEJPIb2Gw4w3V8=
X-Received: by 2002:ac2:4248:0:b0:500:adbd:43e9 with SMTP id
 m8-20020ac24248000000b00500adbd43e9mr5205245lfl.15.1694720847696; Thu, 14 Sep
 2023 12:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de> <CAADnVQJsjVf3t0OJCZkc3rNpHMi_ZTtwLa3LBMi6ot3zufnb+A@mail.gmail.com>
 <723a49b4-c4ed-3b0b-2a9d-915b49725411@iogearbox.net>
In-Reply-To: <723a49b4-c4ed-3b0b-2a9d-915b49725411@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Sep 2023 12:47:16 -0700
Message-ID: <CAADnVQJ4Fg-VQ-tVCEqsKLuozT7y_o8pZ1oM3eBW7u-Z0jOk4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Luis Gerhorst <gerhorst@cs.fau.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        gerhorst@amazon.de, Ilya Leoshkevich <iii@linux.ibm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 10:24=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 9/14/23 6:20 PM, Alexei Starovoitov wrote:
> > On Wed, Sep 13, 2023 at 5:30=E2=80=AFAM Luis Gerhorst <gerhorst@amazon.=
de> wrote:
> >>
> >> This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.
> >>
> >> To mitigate Spectre v1, the verifier relies on static analysis to dedu=
ct
> >> constant pointer bounds, which can then be enforced by rewriting point=
er
> >> arithmetic [1] or index masking [2]. This relies on the fact that ever=
y
> >> memory region to be accessed has a static upper bound and every date
> >> below that bound is accessible. The verifier can only rewrite pointer
> >> arithmetic or insert masking instructions to mitigate Spectre v1 if a
> >> static upper bound, below of which every access is valid, can be given=
.
> >>
> >> When allowing packet pointer comparisons, this introduces a way for th=
e
> >> program to effectively construct an accessible pointer for which no
> >> static upper bound is known. Intuitively, this is obvious as a packet
> >> might be of any size and therefore 0 is the only statically known uppe=
r
> >> bound below of which every date is always accessible (i.e., none).
> >>
> >> To clarify, the problem is not that comparing two pointers can be used
> >> for pointer leaks in the same way in that comparing a pointer to a kno=
wn
> >> scalar can be used for pointer leaks. That is because the "secret"
> >> components of the addresses cancel each other out if the pointers are
> >> into the same region.
> >>
> >> With [3] applied, the following malicious BPF program can be loaded in=
to
> >> the kernel without CAP_PERFMON:
> >>
> >> r2 =3D *(u32 *)(r1 + 76) // data
> >> r3 =3D *(u32 *)(r1 + 80) // data_end
> >> r4 =3D r2
> >> r4 +=3D 1
> >> if r4 > r3 goto exit
> >> r5 =3D *(u8 *)(r2 + 0) // speculatively read secret
> >> r5 &=3D 1 // choose bit to leak
> >> // ... side channel to leak secret bit
> >> exit:
> >> // ...
> >>
> >> This is jited to the following amd64 code which still contains the
> >> gadget:
> >>
> >>     0:   endbr64
> >>     4:   nopl   0x0(%rax,%rax,1)
> >>     9:   xchg   %ax,%ax
> >>     b:   push   %rbp
> >>     c:   mov    %rsp,%rbp
> >>     f:   endbr64
> >>    13:   push   %rbx
> >>    14:   mov    0xc8(%rdi),%rsi // data
> >>    1b:   mov    0x50(%rdi),%rdx // data_end
> >>    1f:   mov    %rsi,%rcx
> >>    22:   add    $0x1,%rcx
> >>    26:   cmp    %rdx,%rcx
> >>    29:   ja     0x000000000000003f // branch to mispredict
> >>    2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
> >>    30:   and    $0x1,%r8 // choose bit to leak
> >>    34:   xor    %ebx,%ebx
> >>    36:   cmp    %rbx,%r8
> >>    39:   je     0x000000000000003f // branch based on secret
> >>    3b:   imul   $0x61,%r8,%r8 // leak using port contention side chann=
el
> >>    3f:   xor    %eax,%eax
> >>    41:   pop    %rbx
> >>    42:   leaveq
> >>    43:   retq
> >>
> >> Here I'm using a port contention side channel because storing the secr=
et
> >> to the stack causes the verifier to insert an lfence for unrelated
> >> reasons (SSB mitigation) which would terminate the speculation.
> >>
> >> As Daniel already pointed out to me, data_end is even attacker
> >> controlled as one could send many packets of sufficient length to trai=
n
> >> the branch prediction into assuming data_end >=3D data will never be t=
rue.
> >> When the attacker then sends a packet with insufficient data, the
> >> Spectre v1 gadget leaks the chosen bit of some value that lies behind
> >> data_end.
> >
> > The above analysis is correct, but unlike traditional spec_v1
> > the attacker doesn't control data/data_end.
> > The attack can send many large packets to train that data + X < data_en=
d
> > and then send a small packet where CPU will mispredict that branch
> > and data + X will speculatively read past data_end,
> > so the attacker can extract a bit past data_end,
> > but data/data_end themselves cannot be controlled.
> > So whether this bit 0 or 1 has no bearing.
> > The attack cannot be repeated for the same location.
> > The attacker can read one bit 8 times in a row and all of them
> > will be from different locations in the memory.
> > Same as reading 8 random bits from 8 random locations.
> > Hence I don't think this revert is necessary.
> > I don't believe you can craft an actual exploit.
> >
> > Your patch 3 says:
> >         /* Speculative access to be prevented. */
> > +       char secret =3D *((char *) iph);
> > +
> > +       /* Leak the first bit of the secret value that lies behind data=
_end to a
> > +        * SMP silbling thread that also executes imul instructions. If=
 the bit
> > +        * is 1, the silbling will experience a slowdown. */
> > +       long long x =3D secret;
> > +       if (secret & 1) {
> > +               x *=3D 97;
> > +       }
> >
> > the comment is correct, but speculative access alone is not enough
> > to leak data.
>
> What you write makes sense, it will probably be hard to craft an exploit.
> Where it's a bit more of an unknown to me is whether struct skb_shared_in=
fo
> could have e.g. destructor_arg rather static (at last the upper addr bits=
)
> so that you would leak out kernel addresses.

You mean since skb_shared_info is placed after skb->end
and in zero copy case destructor_arg may be initialized with the same
kernel pointer for multiple skb-s ?
The attacker cannot construct the address from data_end.
The verifier explicitly prohibits any ALU with PTR_TO_PACKET_END.
But the attacker can do skb->data + X.
The idea is that they can train the branch to mispredict with
a large packet and then send a small one so that shared_info
after skb->end has the same uarg pointer in all packets?
So every skb->data+X is a different location, but all of them
point to data that has uarg=3D=3Ddestructor_arg ?

That would be feasible in theory, but in order to speculate the loads
the branch mispredict has to be reliable.
The spec v1 attack requires one of two loads feeding
into compare operation has to be slow.
In this case both data and data_end loads are going to be fast.
The attacker cannot evict skb->data or skb->data_end from cache.
Remember that we rearranged 'max_entries' field in struct bpf_map
specifically to be in the different cache line vs fields
controlled by user space. It was the necessary part of spec v1 attack.

So I still believe this revert is unnecessary and this speculative
execution is not exploitable.
