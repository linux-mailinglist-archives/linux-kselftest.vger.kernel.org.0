Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349927A13D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 04:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjIOC1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjIOC1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 22:27:01 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35082134;
        Thu, 14 Sep 2023 19:26:56 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6491907dbc3so9527596d6.2;
        Thu, 14 Sep 2023 19:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694744816; x=1695349616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V+Ej050wtBPVkvgLAURHyBGUEz6TBckGLvBwf0w5ek=;
        b=biaJ2IxunrpxB70Atdrc1R4WoE9HsATB3NyVNjXtZhI6vXfNMuT9x6emDg4VSqyj3b
         T+VeroTjs09eeB3OVFr8TehRrDylmzIlqnsJFOE1if3ipC/HuRkEdy1sqmC/VNB5LRJD
         bOL17MiNyVjQwI3qeAmYjcfNhOmFwGH+rtmBMJFei7FQAfTq330R0w16XZCVCjtkc5ze
         4uR1+lwJsLVM7Zxtz1TDHPZQtTQLQY9IFPVb+XfdtyU33Jcd1nsl9nuS41lIYiIKzgam
         Qgo/v8yY/ACqRAyeNiusFGK5jdNyNXsE1hvqoksyGa7rkRySwabs3GMheuLS7CSGMx3D
         io6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694744816; x=1695349616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V+Ej050wtBPVkvgLAURHyBGUEz6TBckGLvBwf0w5ek=;
        b=MtCc7NcoiLW0kAbEppJfP2v2UIzPL40q9y0LERpDOq50rjLOZlRPBgs49ebFYl3SU4
         WpaNyMkuKtkB+rtnuVejkTdFKjwsSg9aeVczmofnwSYMghwz3rzFuw7GVIMSC3fcBW2y
         Vamv2qhvGljwnpGpw2wf5H0y+bGjgUJE57cl0dVJ8WJ5Kn2z6ev/ZYxyFnbhSNQ+sqNT
         lqbgkQcwM6ppPMyajxeXe1Bx6zXi2Pz6UYXbz5DdsmJk615bUmrp8TDeyyHI4gwusMN6
         rk8S6Cy2g8IMWCo+AleBZN6mE530zBWLpVt2tmojvVk7cipxBUvuQXWtt8EeSinc9YGK
         dVDA==
X-Gm-Message-State: AOJu0YzHdsauoe2e16RFo3QFWxuFipXMdF/uOYlYUa5Rx//mun39edaM
        2ZrVz5sj8ZwFPNKp1XrJ1kGDaCF/zN67SBtxgWg=
X-Google-Smtp-Source: AGHT+IEQIFGBqnwaVx6CYRVwvI75J6PHFp1VzHmY85UfwZyp/hATEeui96erhiU98nairCgDsIa4WHzwKu1kuXTsxbc=
X-Received: by 2002:a0c:e04a:0:b0:631:f9ad:1d43 with SMTP id
 y10-20020a0ce04a000000b00631f9ad1d43mr403460qvk.14.1694744815978; Thu, 14 Sep
 2023 19:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de>
In-Reply-To: <20230913122827.91591-1-gerhorst@amazon.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 15 Sep 2023 10:26:19 +0800
Message-ID: <CALOAHbAswO78gQ+D6yOupi5Hx_i3xqHQFrjGdWR=EhdVvV3ZkA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     gerhorst@cs.fau.de
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        yonghong.song@linux.dev, mykolal@fb.com, shuah@kernel.org,
        gerhorst@amazon.de, iii@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 13, 2023 at 8:30=E2=80=AFPM Luis Gerhorst <gerhorst@amazon.de> =
wrote:
>
> This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.
>
> To mitigate Spectre v1, the verifier relies on static analysis to deduct
> constant pointer bounds, which can then be enforced by rewriting pointer
> arithmetic [1] or index masking [2]. This relies on the fact that every
> memory region to be accessed has a static upper bound and every date
> below that bound is accessible. The verifier can only rewrite pointer
> arithmetic or insert masking instructions to mitigate Spectre v1 if a
> static upper bound, below of which every access is valid, can be given.
>
> When allowing packet pointer comparisons, this introduces a way for the
> program to effectively construct an accessible pointer for which no
> static upper bound is known. Intuitively, this is obvious as a packet
> might be of any size and therefore 0 is the only statically known upper
> bound below of which every date is always accessible (i.e., none).
>
> To clarify, the problem is not that comparing two pointers can be used
> for pointer leaks in the same way in that comparing a pointer to a known
> scalar can be used for pointer leaks. That is because the "secret"
> components of the addresses cancel each other out if the pointers are
> into the same region.
>
> With [3] applied, the following malicious BPF program can be loaded into
> the kernel without CAP_PERFMON:
>
> r2 =3D *(u32 *)(r1 + 76) // data
> r3 =3D *(u32 *)(r1 + 80) // data_end
> r4 =3D r2
> r4 +=3D 1
> if r4 > r3 goto exit
> r5 =3D *(u8 *)(r2 + 0) // speculatively read secret
> r5 &=3D 1 // choose bit to leak
> // ... side channel to leak secret bit
> exit:
> // ...
>
> This is jited to the following amd64 code which still contains the
> gadget:
>
>    0:   endbr64
>    4:   nopl   0x0(%rax,%rax,1)
>    9:   xchg   %ax,%ax
>    b:   push   %rbp
>    c:   mov    %rsp,%rbp
>    f:   endbr64
>   13:   push   %rbx
>   14:   mov    0xc8(%rdi),%rsi // data
>   1b:   mov    0x50(%rdi),%rdx // data_end
>   1f:   mov    %rsi,%rcx
>   22:   add    $0x1,%rcx
>   26:   cmp    %rdx,%rcx
>   29:   ja     0x000000000000003f // branch to mispredict
>   2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
>   30:   and    $0x1,%r8 // choose bit to leak
>   34:   xor    %ebx,%ebx
>   36:   cmp    %rbx,%r8
>   39:   je     0x000000000000003f // branch based on secret
>   3b:   imul   $0x61,%r8,%r8 // leak using port contention side channel
>   3f:   xor    %eax,%eax
>   41:   pop    %rbx
>   42:   leaveq
>   43:   retq
>
> Here I'm using a port contention side channel because storing the secret
> to the stack causes the verifier to insert an lfence for unrelated
> reasons (SSB mitigation) which would terminate the speculation.
>
> As Daniel already pointed out to me, data_end is even attacker
> controlled as one could send many packets of sufficient length to train
> the branch prediction into assuming data_end >=3D data will never be true=
.
> When the attacker then sends a packet with insufficient data, the
> Spectre v1 gadget leaks the chosen bit of some value that lies behind
> data_end.
>
> To make it clear that the problem is not the pointer comparison but the
> missing masking instruction, it can be useful to transform the code
> above into the following equivalent pseudocode:
>
> r2 =3D data
> r3 =3D data_end
> r6 =3D ... // index to access, constant does not help
> r7 =3D data_end - data // only known at runtime, could be [0,PKT_MAX)
> if !(r6 < r7) goto exit
> // no masking of index in r6 happens
> r2 +=3D r6 // addr. to access
> r5 =3D *(u8 *)(r2 + 0) // speculatively read secret
> // ... leak secret as above
>
> One idea to resolve this while still allowing for unprivileged packet
> access would be to always allocate a power of 2 for the packet data and
> then also pass the respective index mask in the skb structure. The
> verifier would then have to check that this index mask is always applied
> to the offset before a packet pointer is dereferenced. This patch does
> not implement this extension, but only reverts [3].

Hi Luis,

The skb pointer comparison is a reasonable operation in a networking bpf pr=
og.
If we just prohibit a reasonable operation to prevent a possible
spectre v1 attack, it looks a little weird, right ?
Should we figure out a real fix to prevent it ?

--=20
Regards
Yafang
