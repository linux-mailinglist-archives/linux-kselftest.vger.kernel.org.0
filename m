Return-Path: <linux-kselftest+bounces-2784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75661829159
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4943B2590C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC6383;
	Wed, 10 Jan 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJddKhGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E23A5A;
	Wed, 10 Jan 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso2658433a12.1;
        Tue, 09 Jan 2024 16:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704846470; x=1705451270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy7+jUvQqoJloYURgKxR3EyjkKVp9Y3cK5plR19wMMg=;
        b=mJddKhGsXsQs2l2b7zygNgzGt+JzuTE4CpJCwsa9Qtq5d0gooRGG4WwNBQddp3Rkza
         uC5/L9Ctigy3gslI5fRa+OrR4fHFK0IvTJ3ac43fOjbKA1eev4bbW8haUK4dEyhHr2KN
         HgkmzxEtIM3ElcGM5M7AHtohtt7lC3SU+i1ZNeLWP9NIS9i882mLS0hB4MGMBMVl6yx7
         YopjpxlUCp1P4ZypzBnqMB54jtfdIRWwRwDRHVqaPZQLQf/Tns/s9d3T/UEM5EpXQaFg
         SaZ3Nd5msS0ak1Ev7ERB2e20pUX75XaYHrgZEO64ZQevj0RSsQfHeLNVh2zyVUFGjPWk
         iwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704846470; x=1705451270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy7+jUvQqoJloYURgKxR3EyjkKVp9Y3cK5plR19wMMg=;
        b=EZRIU5kq5m0yCY41lqn2swJZ5R8kc6pe7FgK06XUnRdEt504e3aY08bA+T02RLUCJH
         m95o4+jjb2zPqTtLuYGJsExGs7+4wlAAPz/4nBv8RTKlFWnlSZ6sqMKxHRCqwqr3tOOl
         XtZ+6+mYyuf5fFrfHO7wHA46l8r26H4MY/QAtJAF7E9hdFhjCuZ4nIeF2VxxVkukWHYm
         NdMvbnev3KfhKiM7jDu/F74Ytg3sR7AttuS9j91xGcEYbQ3YjUsrR1tQU3txHouQtSKr
         Xzu3d3F8FGT4nwFA0950Gtt66n4DbWc1/J8rj2BiJoiK6f5FR0opc7ULTDyDKijbkNta
         GIQg==
X-Gm-Message-State: AOJu0Yzehsl3wS2BkpF7cQzgK5HgBDF5TY/ju0mi0hbnqn1IatEzmamT
	kTiQGxPLKiCmGMGG5DhO1HPRPG8YSvYPaCOg5ik=
X-Google-Smtp-Source: AGHT+IEk5DOXT7M1TFgsCjoko9tnbdQiej14HTFPW5wLCelnSKCdq+bXiQ16vSt5wVZYwU+n+dpOQMLytlytwykmR3M=
X-Received: by 2002:aa7:c9cc:0:b0:558:25a3:145a with SMTP id
 i12-20020aa7c9cc000000b0055825a3145amr105769edt.30.1704846469992; Tue, 09 Jan
 2024 16:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-16-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-16-maxtram95@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 16:27:38 -0800
Message-ID: <CAEf4BzaQzWLJqMuOtBX+wmH4EH43nYjTcuVun5nGUwEY_6E7RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/15] selftests/bpf: states pruning checks
 for scalar vs STACK_{MISC,ZERO}
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:53=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> From: Eduard Zingerman <eddyz87@gmail.com>
>
> Check that stacksafe() considers the following old vs cur stack spill
> state combinations equivalent:
> - spill of unbound scalar vs combination of STACK_{MISC,ZERO,INVALID}
> - STACK_MISC vs spill of unbound scalar
> - spill of scalar 0 vs STACK_ZERO
> - STACK_ZERO vs spill of scalar 0
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_spill_fill.c | 192 ++++++++++++++++++
>  1 file changed, 192 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 3764111d190d..3cd3fe30357f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -1044,4 +1044,196 @@ l0_%=3D:  r1 >>=3D 32;                           =
           \
>         : __clobber_all);
>  }
>
> +/* stacksafe(): check if spill of unbound scalar in old state is
> + * considered equivalent to any state of the spill in the current state.
> + *
> + * On the first verification path an unbound scalar is written for
> + * fp-8 and later marked precise.
> + * On the second verification path a mix of STACK_MISC/ZERO/INVALID is
> + * written to fp-8. These should be considered equivalent.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("10: (79) r0 =3D *(u64 *)(r10 -8)")
> +__msg("10: safe")
> +__msg("processed 16 insns")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void old_unbound_scalar_vs_cur_anything(void)
> +{
> +       asm volatile(
> +       /* get a random value for branching */
> +       "call %[bpf_ktime_get_ns];"
> +       "r7 =3D r0;"
> +       /* get a random value for storing at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "if r7 =3D=3D 0 goto 1f;"
> +       /* unbound scalar written to fp-8 */
> +       "*(u64*)(r10 - 8) =3D r0;"
> +       "goto 2f;"
> +"1:"
> +       /* mark fp-8 as mix of STACK_MISC/ZERO/INVALID */
> +       "r1 =3D 0;"
> +       "*(u8*)(r10 - 8) =3D r0;"

this is actually a spilled register, not STACK_ZERO. Is it important?

> +       "*(u8*)(r10 - 7) =3D r1;"
> +       /* fp-2..fp-6 remain STACK_INVALID */
> +       "*(u8*)(r10 - 1) =3D r0;"
> +"2:"
> +       /* read fp-8 and force it precise, should be considered safe
> +        * on second visit
> +        */
> +       "r0 =3D *(u64*)(r10 - 8);"
> +       "r0 &=3D 0xff;"
> +       "r1 =3D r10;"
> +       "r1 +=3D r0;"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* stacksafe(): check if STACK_MISC in old state is considered
> + * equivalent to stack spill of unbound scalar in cur state.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("8: (79) r0 =3D *(u64 *)(r10 -8)         ; R0_w=3Dscalar(id=3D1) R=
10=3Dfp0 fp-8=3Dscalar(id=3D1)")
> +__msg("8: safe")
> +__msg("processed 11 insns")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void old_unbound_scalar_vs_cur_stack_misc(void)
> +{
> +       asm volatile(
> +       /* get a random value for branching */
> +       "call %[bpf_ktime_get_ns];"
> +       "if r0 =3D=3D 0 goto 1f;"
> +       /* conjure unbound scalar at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "*(u64*)(r10 - 8) =3D r0;"
> +       "goto 2f;"
> +"1:"
> +       /* conjure STACK_MISC at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "*(u64*)(r10 - 8) =3D r0;"
> +       "*(u32*)(r10 - 4) =3D r0;"
> +"2:"
> +       /* read fp-8, should be considered safe on second visit */
> +       "r0 =3D *(u64*)(r10 - 8);"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* stacksafe(): check if stack spill of unbound scalar in old state is
> + * considered equivalent to STACK_MISC in cur state.
> + */
> +SEC("socket")
> +__success  __log_level(2)
> +__msg("8: (79) r0 =3D *(u64 *)(r10 -8)         ; R0_w=3Dscalar() R10=3Df=
p0 fp-8=3Dmmmmmmmm")
> +__msg("8: safe")
> +__msg("processed 11 insns")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void old_stack_misc_vs_cur_unbound_scalar(void)
> +{
> +       asm volatile(
> +       /* get a random value for branching */
> +       "call %[bpf_ktime_get_ns];"
> +       "if r0 =3D=3D 0 goto 1f;"
> +       /* conjure STACK_MISC at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "*(u64*)(r10 - 8) =3D r0;"
> +       "*(u32*)(r10 - 4) =3D r0;"
> +       "goto 2f;"
> +"1:"
> +       /* conjure unbound scalar at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "*(u64*)(r10 - 8) =3D r0;"
> +"2:"
> +       /* read fp-8, should be considered safe on second visit */
> +       "r0 =3D *(u64*)(r10 - 8);"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* stacksafe(): check if spill of register with value 0 in old state
> + * is considered equivalent to STACK_ZERO.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("9: (79) r0 =3D *(u64 *)(r10 -8)")
> +__msg("9: safe")
> +__msg("processed 15 insns")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void old_spill_zero_vs_stack_zero(void)
> +{
> +       asm volatile(
> +       /* get a random value for branching */
> +       "call %[bpf_ktime_get_ns];"
> +       "r7 =3D r0;"
> +       /* get a random value for storing at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "if r7 =3D=3D 0 goto 1f;"
> +       /* conjure spilled register with value 0 at fp-8 */
> +       "*(u64*)(r10 - 8) =3D r0;"
> +       "if r0 !=3D 0 goto 3f;"
> +       "goto 2f;"
> +"1:"
> +       /* conjure STACK_ZERO at fp-8 */
> +       "r1 =3D 0;"
> +       "*(u64*)(r10 - 8) =3D r1;"

this is not STACK_ZERO, it's full register spill

> +"2:"
> +       /* read fp-8 and force it precise, should be considered safe
> +        * on second visit
> +        */
> +       "r0 =3D *(u64*)(r10 - 8);"
> +       "r1 =3D r10;"
> +       "r1 +=3D r0;"
> +"3:"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* stacksafe(): similar to old_spill_zero_vs_stack_zero() but the
> + * other way around: check if STACK_ZERO is considered equivalent to
> + * spill of register with value 0.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("8: (79) r0 =3D *(u64 *)(r10 -8)")
> +__msg("8: safe")
> +__msg("processed 14 insns")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void old_stack_zero_vs_spill_zero(void)
> +{
> +       asm volatile(
> +       /* get a random value for branching */
> +       "call %[bpf_ktime_get_ns];"
> +       "if r0 =3D=3D 0 goto 1f;"
> +       /* conjure STACK_ZERO at fp-8 */
> +       "r1 =3D 0;"
> +       "*(u64*)(r10 - 8) =3D r1;"

same, please double check this STACK_xxx assumptions, as now we spill
registers instead of STACK_ZERO in a lot of cases

> +       "goto 2f;"
> +"1:"
> +       /* conjure spilled register with value 0 at fp-8 */
> +       "call %[bpf_ktime_get_ns];"
> +       "*(u64*)(r10 - 8) =3D r0;"
> +       "if r0 !=3D 0 goto 3f;"
> +"2:"
> +       /* read fp-8 and force it precise, should be considered safe
> +        * on second visit
> +        */
> +       "r0 =3D *(u64*)(r10 - 8);"
> +       "r1 =3D r10;"
> +       "r1 +=3D r0;"
> +"3:"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>

