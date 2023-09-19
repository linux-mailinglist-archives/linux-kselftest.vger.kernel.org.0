Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5922B7A57F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjISDoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 23:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjISDoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 23:44:00 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214195;
        Mon, 18 Sep 2023 20:43:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-773b4a711bcso226038185a.0;
        Mon, 18 Sep 2023 20:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695095033; x=1695699833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7QZ7kxSxpJ8sh1sNyqPKUBs2kJJTxYR3nqoT/zoKoQ=;
        b=iauD4NPYFtqGW7tl0RPbGbaNgEiHYtUzLTarK4W/ottmsxTFQGt46LcAtAcd3CWdhp
         rUM/L0FAXqFEwOTdOSJP0OLnXALLO+zVgY/iY1cy9Pr8Jcx4d4HcEeFIUcgkNG9Xp7eB
         0g6I+rxBX+C50DZjC4rukEz8UKJ/jIcdDN/+jTVHwpjG2/W/+BBhlhEASHR0ULfvhfSs
         /cznItLvDkp7YkUQAMH/Rm9EAmokKnkQBO54Kkt76OmsmD6UXvmcbk0Fjuo0a3KO8KYl
         DxDeG+GyYZ6KlLL+dxr+O5aONst+LFqyeZCy0vg0oA/DEcvZooezywJxu5JvtGU15YOD
         kNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095033; x=1695699833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7QZ7kxSxpJ8sh1sNyqPKUBs2kJJTxYR3nqoT/zoKoQ=;
        b=wUDWfEbyQFgnQVocs4JWnjyLfliaaFdAiBOL0X6Cm1YnjR8aU54WiDJjJhbgwDAqJ1
         AnK1otD8o6X1lDgCBLuJCac7UpUHVIeQX0jnw6ScxnAF3aO9ITuNF/kMT3xnElL+13LT
         nh769gOpJ8LaczibMbBhv6Gi1ON3+JyGVbfiI++MPN+VsjQ1xGU5joEw3k1Mqzxrptm4
         z2v0gPXQWb3/MuxuMkTREKr/TjD+dtkuJkVNq8JFFm7hXEvaJcdxSadnPHKED+UgZP/R
         CTBKpkL2010Gdg18QgzzAVMmuWWKwnFNga/07hP0pv2twNCbPFa5b6+iLf6svPD8wj68
         2K5w==
X-Gm-Message-State: AOJu0YyXe6n/s5tmNguMfaneGLrvxAVAsJpdljgwjTOyOxZW3hEmpgT/
        nJUO4p7JBsJJ8Ktlxl93p+w9iWjRckBuUXUYkak=
X-Google-Smtp-Source: AGHT+IFCo8QbAk92bKjhX9+9621149fplt6ilI7Go9xtebM+Ue41qjedUhuVgQxxXlJtnYzLDaByA8Sq28z4FUXrPXo=
X-Received: by 2002:a0c:e113:0:b0:656:49c4:82 with SMTP id w19-20020a0ce113000000b0065649c40082mr7061507qvk.31.1695095033284;
 Mon, 18 Sep 2023 20:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de> <CALOAHbAswO78gQ+D6yOupi5Hx_i3xqHQFrjGdWR=EhdVvV3ZkA@mail.gmail.com>
 <e15dea4b-f6a5-a37d-1660-406bca5a0026@cs.fau.de>
In-Reply-To: <e15dea4b-f6a5-a37d-1660-406bca5a0026@cs.fau.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 19 Sep 2023 11:43:16 +0800
Message-ID: <CALOAHbA3acaZGoxsiahmzh23rzsqGWbATkdF4bK-OUeCWzUYgw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Luis Gerhorst <gerhorst@cs.fau.de>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 7:52=E2=80=AFPM Luis Gerhorst <gerhorst@cs.fau.de> =
wrote:
>
> On 15/09/2023 04:26, Yafang Shao wrote:
> > On Wed, Sep 13, 2023 at 8:30=E2=80=AFPM Luis Gerhorst <gerhorst@amazon.=
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
> >>
> >> To make it clear that the problem is not the pointer comparison but th=
e
> >> missing masking instruction, it can be useful to transform the code
> >> above into the following equivalent pseudocode:
> >>
> >> r2 =3D data
> >> r3 =3D data_end
> >> r6 =3D ... // index to access, constant does not help
> >> r7 =3D data_end - data // only known at runtime, could be [0,PKT_MAX)
> >> if !(r6 < r7) goto exit
> >> // no masking of index in r6 happens
> >> r2 +=3D r6 // addr. to access
> >> r5 =3D *(u8 *)(r2 + 0) // speculatively read secret
> >> // ... leak secret as above
> >>
> >> One idea to resolve this while still allowing for unprivileged packet
> >> access would be to always allocate a power of 2 for the packet data an=
d
> >> then also pass the respective index mask in the skb structure. The
> >> verifier would then have to check that this index mask is always appli=
ed
> >> to the offset before a packet pointer is dereferenced. This patch does
> >> not implement this extension, but only reverts [3].
> >
> > Hi Luis,
> >
> > The skb pointer comparison is a reasonable operation in a networking bp=
f prog.
> > If we just prohibit a reasonable operation to prevent a possible
> > spectre v1 attack, it looks a little weird, right ?
> > Should we figure out a real fix to prevent it ?
> >
>
> I see your point, but this has been the case since Spectre v1 was
> mitigated for BPF. I actually did a few statistics on that in [1] and
>  >50 out of ~350 programs are rejected because of the Spectre v1
> mitigations. However, to repeat: The operation is not completely
> prohibited, only prohibited without CAP_PERFMON.
>
> Maybe it would be possible to expose the allow_ptr_leaks/bpf_spec_vX
> flags in sysfs? It would be helpful for debugging, and you could set it
> to 1 permanently for your purposes. However, I'm not sure if the others
> would like that...

I really appreciate that idea. I actually shared a similar concept earlier.=
[1].
Nonetheless, I believe it would be prudent to align with the system
settings regarding CPU security mitigations within the BPF subsystem
as well. In our production environment, we consistently configure it
with "mitigations=3Doff"[2] to enhance performance, essentially
deactivating all optional CPU mitigations. Consequently, if we
implement a system-wide "mitigations=3Doff" setting, it should also
inherently bypass Spectre v1 and Spectre v4 in the BPF subsystem.

Alexei, Daniel, any comments ?

[1]. https://lore.kernel.org/bpf/CALOAHbDDT=3DpaFEdTb1Jsqu7eGkFXAh6A+f21VTr=
MdAeq5F60kg@mail.gmail.com/
[2]. https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.h=
tml

>
> Another solution I have been working on in [2] is to change the
> mitigations to insert an lfence instead of rejecting the program
> entirely. That would have bad performance, but would still be better
> than completely rejecting the program. However, these patches are far
> from going upstream currently.
>
> A detail: The patches in [2] currently do not support the case we are
> discussing here, they only insert fences when the speculative paths fail
> to verify.
>
> [1]
> https://sys.cs.fau.de/extern/person/gerhorst/23-03_fgbs-spring-2023-prese=
ntation.pdf
> - Slide 9
> [2]
> https://gitlab.cs.fau.de/un65esoq/linux/-/commits/v6.5-rc6-bpf-spectre-no=
spec/
>
> --
> Luis



--
Regards
Yafang
