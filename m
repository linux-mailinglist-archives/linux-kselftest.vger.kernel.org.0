Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81B7DE0B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjKAMTC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjKAMTC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 08:19:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364BDC;
        Wed,  1 Nov 2023 05:18:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da2b9234a9fso4386038276.3;
        Wed, 01 Nov 2023 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698841139; x=1699445939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NLvuE8hMShXvppTBTSIa8TeTIaP61N5ISRy0nYOCZU=;
        b=d1Fbbmr+FvdhLT1FtN6VsqoVfEckcnXS17f+VmVKBQvh3rCQo13wrInTSL4y4jmRvO
         xH7f5m4L61NJ5V/EJc0oLC5UlHqLJeAdHVTEJMQin2tMtwdAfGqEOwwGb2K9kAzGR1DV
         XPw33i+X1VMIzp156JlGI6Gyzc+rv7to6mDgNfaYgWtoUnP0l56iABsooGLcscB9xK9y
         qH8xIA40rSuXlD6Mg3pL0MpG9BeHAVNjz7SNf1DCKKjXFrLMTgM1Y5m2uKEnaMwnqYhj
         BHhwhF4b8hNcViv+OIlJKFBLRWk2EfDdDJOzdB1UFl8stNkkjuLw9NwBR9oswZwmDiDK
         eOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698841139; x=1699445939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NLvuE8hMShXvppTBTSIa8TeTIaP61N5ISRy0nYOCZU=;
        b=JDWb+jrcfd7N6aNHWV+8m3hgCsW0I9Nm7LHr6PdlSrNf/a3n5U4N/49ZmvTxhvPmHv
         2fU0g+OVbWNbuNaYi0vWigHsdLY+J1Dju3wTwgSOJ0C5rSf16/vaseSWGYJfac7HuWnN
         K/KgF0GDWT2hbKh2B2N4eWWU8GY1r3ZkGLHZhJTvNjsN2Sex0exgCgXc8NIiK6KNhfXm
         WI0gDWDP4xxFqzCpj1RVKpNwTn1gDNpJwTkIJ/pCAc7VGkjsJuyNrJ6R7FJihf+MJM3t
         33KY9WJm3AL0uw2+qhce8xupHqPyyJgmv7ZQoVU4U31jtutue6kS4SFk7N7kicnHybfh
         smqw==
X-Gm-Message-State: AOJu0Yy+MqPweDFhsbTmB4wU4j9TLvN/FvAnlCZc2Kl3pV5nhqu53dhk
        e6DmMIBcqaPip3AMbRsMoUBEEodObLlo2Pl0yg==
X-Google-Smtp-Source: AGHT+IE7BGTDtp93hL2jxi07tWJW+FENBcpmfXQ2TibaIe1A07FkgwiDBfviEoOzeji0VM29sDtR3nkJBTY8YTimSS4=
X-Received: by 2002:a25:ac07:0:b0:d9a:fd15:82a3 with SMTP id
 w7-20020a25ac07000000b00d9afd1582a3mr14611012ybi.24.1698841138886; Wed, 01
 Nov 2023 05:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
 <20231101-fix-check-stack-write-v2-2-cb7c17b869b0@gmail.com> <4ec86365668f6c3b4242232506e896a17aa2af4c.camel@gmail.com>
In-Reply-To: <4ec86365668f6c3b4242232506e896a17aa2af4c.camel@gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 1 Nov 2023 13:18:47 +0100
Message-ID: <CACkBjsbu2aMUrhMazvVnJw9MBuOrapv2vYaJEnjCg-BEuFPh4g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for immediate spilled
 to stack
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 1, 2023 at 12:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-11-01 at 08:33 +0100, Hao Sun wrote:
> > Add a test to check if the verifier correctly reason about the sign
> > of an immediate spilled to stack by BPF_ST instruction.
> >
> > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++=
++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/=
testing/selftests/bpf/verifier/bpf_st_mem.c
> > index 3af2501082b2..0ba23807c46c 100644
> > --- a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
> > +++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
> > @@ -65,3 +65,35 @@
> >       .expected_attach_type =3D BPF_SK_LOOKUP,
> >       .runs =3D -1,
> >  },
> > +{
> > +     "BPF_ST_MEM stack imm sign",
> > +     /* Check if verifier correctly reasons about sign of an
> > +      * immediate spilled to stack by BPF_ST instruction.
> > +      *
> > +      *   fp[-8] =3D -44;
> > +      *   r0 =3D fp[-8];
> > +      *   if r0 s< 0 goto ret0;
> > +      *   r0 =3D -1;
> > +      *   exit;
> > +      * ret0:
> > +      *   r0 =3D 0;
> > +      *   exit;
> > +      */
> > +     .insns =3D {
> > +     BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, -44),
> > +     BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
> > +     BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
> > +     BPF_MOV64_IMM(BPF_REG_0, -1),
> > +     BPF_EXIT_INSN(),
> > +     BPF_MOV64_IMM(BPF_REG_0, 0),
> > +     BPF_EXIT_INSN(),
> > +     },
> > +     /* Use prog type that requires return value in range [0, 1] */
> > +     .prog_type =3D BPF_PROG_TYPE_SK_LOOKUP,
> > +     .expected_attach_type =3D BPF_SK_LOOKUP,
> > +     .result =3D VERBOSE_ACCEPT,
> > +     .runs =3D -1,
> > +     .errstr =3D "0: (7a) *(u64 *)(r10 -8) =3D -44        ; R10=3Dfp0 =
fp-8_w=3D-44\
> > +     2: (c5) if r0 s< 0x0 goto pc+2\
> > +     2: R0_w=3D-44",
> > +},
> >
>
> Please note that this test case fails on CI [0], full log below:
>
> 2023-11-01T07:49:51.2841702Z #116/p BPF_ST_MEM stack imm sign FAIL
> 2023-11-01T07:49:51.2843456Z Unexpected verifier log!
> 2023-11-01T07:49:51.2844968Z EXP: 2: R0_w=3D-44
> 2023-11-01T07:49:51.2845583Z RES:
> 2023-11-01T07:49:51.2846693Z func#0 @0
> 2023-11-01T07:49:51.2848932Z 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 2023-11-01T07:49:51.2853045Z 0: (7a) *(u64 *)(r10 -8) =3D -44        ; R1=
0=3Dfp0 fp-8_w=3D-44
> 2023-11-01T07:49:51.2857391Z 1: (79) r0 =3D *(u64 *)(r10 -8)         ; R0=
_w=3D-44 R10=3Dfp0 fp-8_w=3D-44
> 2023-11-01T07:49:51.2859127Z 2: (c5) if r0 s< 0x0 goto pc+2
> 2023-11-01T07:49:51.2862943Z mark_precise: frame0: last_idx 2 first_idx 0=
 subseq_idx -1
> 2023-11-01T07:49:51.2867511Z mark_precise: frame0: regs=3Dr0 stack=3D bef=
ore 1: (79) r0 =3D *(u64 *)(r10 -8)
> 2023-11-01T07:49:51.2872217Z mark_precise: frame0: regs=3D stack=3D-8 bef=
ore 0: (7a) *(u64 *)(r10 -8) =3D -44
> 2023-11-01T07:49:51.2872816Z 5: R0_w=3D-44
> 2023-11-01T07:49:51.2875653Z 5: (b7) r0 =3D 0                        ; R0=
_w=3D0
> 2023-11-01T07:49:51.2876493Z 6: (95) exit
>
> I suspect that after recent logging fixes instruction number printed
> after jump changed and that's why test case no longer passes.
>

Yes, so I guess we can just drop the line number there, will send patch v3.

> Note: you can check CI status for submitted patch-sets using link [1].
>
> [0] https://github.com/kernel-patches/bpf/actions/runs/6717053909/job/182=
54330860
> [1] https://patchwork.kernel.org/project/netdevbpf/list/

Thanks.
