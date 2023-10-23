Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A77D3D0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjJWRGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJWRGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 13:06:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6FC10B;
        Mon, 23 Oct 2023 10:06:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e3e7e478bso5348483a12.0;
        Mon, 23 Oct 2023 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698080796; x=1698685596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJnSbiIkK3dVrsPXMQL0xhdSPBzrcP+C+2hGQ/sSqgE=;
        b=jb7T0z8qpVqq2cbORZFsqP6T5XZUJ+a3Q+F66hRAHnI+QOnRIX/FbUWXHN3CqzAJbV
         xY1h1QyMCXp9fAJ/2sPlQMtoF4R5lareAe9sgayhGajizcIt05X08TiprZaAjX/J9xEq
         JnZAnNW3rhCmMyc5Cl063RBtO6lmPdcq4MXyMRjmJH+9nCVMK8TgzkEkX31L506FJyj6
         ChrFeufb1QXNGzHc1+7k7+IIE7ZiGxpHFjC5rMWF32apkpHRYuJ8uxe347OuBc+lL3pj
         XsNBmbE45I5mtba0KjP4wEIkJhb0BXhbV0lY5O5FQVSIZ/V5A5nSWkVwi8CzYUUbPq9D
         RnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698080796; x=1698685596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJnSbiIkK3dVrsPXMQL0xhdSPBzrcP+C+2hGQ/sSqgE=;
        b=FOYP+ZCd5PjYtKpvwzP0ErK2VtamZHtJ4LLdlGcw3WlQyRFK1R8KltvJ1oA2yX3bEf
         tDmj8Zdhqc1S4Cd1SCVH2YmQ7VlGmM6tDtj6TdUhT33KX6BdxFc2zjaU9BO2CIXkKvln
         TMuLrCRMYQ8Hti8RyG+cfC/iS9ndNssoCYsot3YfrTQngrZj76XC6+VyVstPZx1H91XY
         9200gHYPvY+hFjY9k+e9Algw3MjG8BSo447yuzRpazNZxGbgsUCyAUFxJmB0arNdV644
         4QxmDmrB1uw0fGOykhCu8sPRx1SBVJi89t87Y2H5RFZo2dk1AWf3JFQjug+sSCzPvNCP
         WDOQ==
X-Gm-Message-State: AOJu0Ywmv54amzngY6+eRep5jzInRdlO5B8ZgM2KuKnLL6ZaGMS9rPKJ
        UYdxzefSUZ19EWB2WL2FFRqMQVgqYqahpb3zP6U=
X-Google-Smtp-Source: AGHT+IEQE6+bXc56pBFh8wTO2DkHpBKnca5f0xfWp3/i7aZIDB/AtV38Yv6TZ5Gv9detr3xgO/iKKDdgSaakMXqRV+k=
X-Received: by 2002:a50:cc9e:0:b0:53e:fa55:8e0e with SMTP id
 q30-20020a50cc9e000000b0053efa558e0emr8318186edi.24.1698080795692; Mon, 23
 Oct 2023 10:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231020155842.130257-1-tao.lyu@epfl.ch> <CAEf4BzaqOt8DyB781geXYfrosmgQCkzDOCOH8WBVmCAPs+wQBw@mail.gmail.com>
 <966735dbb75c46a5a73cbbaaeb31bc99@epfl.ch>
In-Reply-To: <966735dbb75c46a5a73cbbaaeb31bc99@epfl.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Oct 2023 10:06:24 -0700
Message-ID: <CAEf4BzZ1VWD6BUWpSzf5Ny-6ptgypppvEjcWV68J6N2MJcA3ag@mail.gmail.com>
Subject: Re: [PATCH] Incorrect backtracking for load/store or atomic ops
To:     Tao Lyu <tao.lyu@epfl.ch>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
        "mathias.payer@nebelwelt.net" <mathias.payer@nebelwelt.net>,
        "meng.xu.cs@uwaterloo.ca" <meng.xu.cs@uwaterloo.ca>,
        Kumar Kartikeya Dwivedi <kartikeya.dwivedi@epfl.ch>
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

On Mon, Oct 23, 2023 at 3:12=E2=80=AFAM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> >
> > On Fri, Oct 20, 2023 at 9:06=E2=80=AFAM Tao Lyu <tao.lyu@epfl.ch> wrote=
:
> >>
> >> Hi,
> >>
> >> I found the backtracking logic of the eBPF verifier is flawed
> >> when meeting 1) normal load and store instruction or
> >> 2) atomic memory instructions.
> >>
> >> # Normal load and store
> >>
> >> Here, I show one case about the normal load and store instructions,
> >> which can be exploited to achieve arbitrary read and write with two re=
quirements:
> >> 1) The uploading program should have at least CAP_BPF, which is requir=
ed for most eBPF applications.
> >> 2) Disable CPU mitigations by adding "mitigations=3Doff" in the kernel=
 booting command line. Otherwise,
> >> the Spectre mitigation in the eBPF verifier will prevent exploitation.
> >>
> >>                                    1: r3 =3D r10 (stack pointer)
> >>                                    3:           if cond
> >>                                                  /           \
> >>                                                /                \
> >>         4: *(u64 *)(r3 -120) =3D 200      6: *(u64 *)(r3 -120) =3D arb=
itrary offset to r2
> >>                  verification state 1                  verification st=
ate 2 (prune point)
> >>                                               \                  /
> >>                                                 \              /
> >>                                       7:  r6 =3D *(u64 *)(r1 -120)
> >>                                                          ...
> >>                                     17:    r7 =3D a map pointer
> >>                                     18:            r7 +=3D r6
> >>                          // Out-of-bound access from the right side pa=
th
> >>
> >> Give an eBPF program (tools/testing/selftests/bpf/test_precise.c)
> >> whose simplified control flow graph looks like the above.
> >> When the verifier goes through the first (left-side) path and reaches =
insn 18,
> >> it will backtrack on register 6 like below.
> >>
> >> 18: (0f) r7 +=3D r6
> >> mark_precise: frame0: last_idx 18 first_idx 17 subseq_idx -1
> >> mark_precise: frame0: regs=3Dr6 stack=3D before 17: (bf) r7 =3D r0
> >> ...
> >> mark_precise: frame0: regs=3Dr6 stack=3D before 7: (79) r6 =3D *(u64 *=
)(r3 -120)
> >>
> >> However, the backtracking process is problematic when it reaches insn =
7.
> >> Insn 7 is to load a value from the stack, but the stack pointer is rep=
resented by r3 instead of r10.
> >> ** In this case, the verifier (as shown below) will reset the precisio=
n on r6 and not mark the precision on the stack. **
> >> Afterward, the backtracking finishes without annotating any registers =
in any verifier states.
> >>
> >>     else if (class =3D=3D BPF_LDX) {
> >>         if (!bt_is_reg_set(bt, dreg))
> >>             return 0;
> >>         bt_clear_reg(bt, dreg);
> >>         if (insn->src_reg !=3D BPF_REG_FP)
> >>             return 0;
> >>         ...
> >>    }
> >>
> >> Finally, when the second (left-side) path reaches insn 7 again,
> >> it will compare the verifier states with the previous one.
> >> However, it realizes these two states are equal because no precision i=
s on r6,
> >> thus the eBPF program an easily pass the verifier
> >> although the second path contains an invalid access offset.
> >> We have successfully exploited this bug for getting the root privilege=
.
> >> If needed, we can share the exploitation.
> >> BTW, when using the similar instructions in sub_prog can also trigger =
an assertion in the verifier:
> >> "[ 1510.165537] verifier backtracking bug
> >> [ 1510.165582] WARNING: CPU: 2 PID: 382 at kernel/bpf/verifier.c:3626 =
__mark_chain_precision+0x4568/0x4e50"
> >>
> >>
> >>
> >> IMO, to fully patch this bug, we need to know whether the insn->src_re=
g is an alias of BPF_REG_FP.
> >
> > Yes!
> >
> >> However, it might need too much code addition.
> >
> > No :) I don't think it's a lot of code. I've been meaning to tackle
> > this for a while, but perhaps the time is now.
> >
> > The plan is to use jmp_history to record an extra flags for some
> > instructions (even if they are not jumps). Like in this case, we can
> > remember for LDX and STX instructions that they were doing register
> > load/spill, and take that into account during backtrack_insn() without
> > having to guess based on r10.
> >
> > I have part of this ready locally, I'll try to finish this up in a
> > next week or two. Stay tuned (unless you want to tackle that
> > yourself).
>
> Great! I'll keep focus on this.
>
> >
> >> Or we just do not clear the precision on the src register.
> >>
> >> # Atomic memory instructions
> >>
> >> Then, I show that the backtracking on atomic load and store is also fl=
awed.
> >> As shown below, when the backtrack_insn() function in the verifier mee=
ts store instructions,
> >> it checks if the stack slot is set with precision or not. If not, just=
 return.
> >>
> >>             if (!bt_is_slot_set(bt, spi))
> >>                 return 0;
> >>             bt_clear_slot(bt, spi);
> >>             if (class =3D=3D BPF_STX)
> >>                 bt_set_reg(bt, sreg);
> >>
> >> Assume we have an atomic_fetch_or instruction (tools/testing/selftests=
/bpf/verifier/atomic_precision.c) shown below.
> >>
> >> 7: (4c) w7 |=3D w3
> >> mark_precise: frame1: last_idx 7 first_idx 0 subseq_idx -1
> >> mark_precise: frame1: regs=3Dr7 stack=3D before 6: (c3) r7 =3D atomic_=
fetch_or((u32 *)(r10 -120), r7)
> >> mark_precise: frame1: regs=3Dr7 stack=3D before 5: (bf) r7 =3D r10
> >> mark_precise: frame1: regs=3Dr10 stack=3D before 4: (7b) *(u64 *)(r3 -=
120) =3D r1
> >> mark_precise: frame1: regs=3Dr10 stack=3D before 3: (bf) r3 =3D r10
> >> mark_precise: frame1: regs=3Dr10 stack=3D before 2: (b7) r1 =3D 1000
> >> mark_precise: frame1: regs=3Dr10 stack=3D before 0: (85) call pc+1
> >> BUG regs 400
> >>
> >> Before backtracking to it, r7 has already been marked as precise.
> >> Since the value of r7 after atomic_fecth_or comes from r10-120,
> >> it should propagate the precision to r10-120.
> >> However, because the stack slot r10-120 is not marked,
> >> it doesn't satisfy bt_is_slot_set(bt, spi) condition shown above.
> >> Finally, it just returns without marking r10-120 as precise.
> >
> > this seems like the same issue with not recognizing stack access
> > through any other register but r10?
> >
> > Or is there something specific to atomic instructions here? I'm not
> > very familiar with them, so I'll need to analyse the code first.
>
> The non-recognizing stack access through other non-r10 registers can also=
 affect atomic instructions as atomic instructions are also memory store in=
structions.
>
> But there is another aspect, that atomi ops has much complex/different se=
mantic compared to memory store instructions. However, the backtracking log=
ic didn't take care of it.
>
> For example, insn r7 =3D atomic_fetch_or((u32 *)(r10 -120), r7) will load=
 the original value at r10-120 to the final r7, and store the "or" result o=
f the value at r10-120 and original r7.
>
> Case 1: Assume r7 is marked as precise and then the backtracking code mee=
ts this instruction, it should propagate the precision to the stack slot r1=
0-120.
>
> Case 2: Assume r10-120 is marked as precise, after this instruction, r10-=
120 and r7 should both be marked precise.
>

So generally speaking atomic operation's memory argument can't be
precise as it is supposed to be modified by other CPUs simultaneously,
so we can never be sure about its actual value.

But using stack pointer is kind of a special case where atomicity
doesn't matter because no one should be accessing stack from another
CPU. So perhaps we can special case this.

Either way, I'm going to concentrate on more generally recognize stack
access for any instruction, and we can work on fixing atomic-specific
semantics on top of that separately.

> >
> >>
> >> This bug can lead to the verifier's assertion as well:
> >> "[ 1510.165537] verifier backtracking bug
> >> [ 1510.165582] WARNING: CPU: 2 PID: 382 at kernel/bpf/verifier.c:3626 =
__mark_chain_precision+0x4568/0x4e50"
> >>
> >> I've attached the patch for correctly propagating the precision on ato=
mic instructions.
> >> But it still can't solve the problem that the stack slot is expressed =
with other registers instead of r10.
> >
> > I can try to solve stack access through non-r10, but it would be very
> > useful if you could provide tests that trigger the above situations
> > you described. Your test_precise.c test below is not the right way to
> > add tests, it adds a new binary and generally doesn't fit into
> > existing set of tests inside test_progs. Please see
> > progs/verifier_xadd.c and prog_tests/verifier.c and try to convert
> > your tests into that form (you also will be able to use inline
> > assembly instead of painful BPF_xxx() instruction macros).
> >
> > Thanks.
>
> Sure. I'll re-construct the test case may the end of this week because I'=
m attending a conference SOSP this week.

Sounds good, thanks.

>
> >
> >>
> >> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> >> ---
> >>  kernel/bpf/verifier.c                         |  58 +++++-
> >>  tools/testing/selftests/bpf/Makefile          |   6 +-
> >>  tools/testing/selftests/bpf/test_precise.c    | 186 +++++++++++++++++=
+
> >>  .../selftests/bpf/verifier/atomic_precision.c |  19 ++
> >>  4 files changed, 263 insertions(+), 6 deletions(-)
> >>  create mode 100644 tools/testing/selftests/bpf/test_precise.c
> >>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_precis=
ion.c
> >>
> >
> >[...]
