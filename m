Return-Path: <linux-kselftest+bounces-18997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12398FB98
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 02:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9056C1F226B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056917FE;
	Fri,  4 Oct 2024 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAgNBxzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069B1849;
	Fri,  4 Oct 2024 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002253; cv=none; b=Xdc31gxXSFBw+idaGcjJoh1PmHIj+LqRG0NamuAhIwhBWcouHYOEHslxwuUF4tP6PR1CdZHxV7O8W9vuOQ8KBl7HdR+vcFpRJlSYV9vBcJc4Dib3Z6qM9+EiMl+OPBUHTaLVls1CWhYRHbCQ+LbMEp/zNDfZFSkFLwTersqPaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002253; c=relaxed/simple;
	bh=iuTIq8azHxkVMYBm+FQ9RzqHxLlTrREuRHlcvEcbUdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1UCSOMUHyEM8h7yZlVotT84EkaV/KGGAsXH+49pnZWAf3vBZOEAmxGss/4mz//r0ncxn8+Q1JE9jrXpqecPA83NHnAkq/0/w2FZrRu4SO5uwOuIWkgnIOBCIqnHgcTzYn+V+II+b9iVaIsJyuELeAwV2GVXRO9v38jXaob24Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAgNBxzu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so1099582f8f.0;
        Thu, 03 Oct 2024 17:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728002250; x=1728607050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpL4nhjHMtPB/hb4YyGjFSchO8APqauV2DpacZ1oo+8=;
        b=HAgNBxzuQmeyjj7l4bVV6wUwpEhGZvDUeTZxi6Piegh3Ds7xDRJzb0Jgw7ZNqr5CP/
         RWc6jNKHYrIuZhsXQ5iTSEHnZUx+ek5KfwdXI5DLuoLuGdzZvwp45eeqTcY7rbf1eZJG
         qR0PXNLVqndVdWy4Y4WeTTFWl6Mj5TLbzQARxJ0wBpdZkeb1iEMBBIDZvnxGBs1/q6kr
         6f2iZgKVxTn5Byn/nIO1EUJVkQFP6LEVUbxvP6hSGMw46Z/1Wg5vBFPMCZiweXHi9WC9
         cwrMRTh1ZhdD1E7R6ZbW+awoRdqdK3sSqzvuAJZgwxQyvDNy7+hvffxNi/ALY6OWLX1M
         mXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728002250; x=1728607050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpL4nhjHMtPB/hb4YyGjFSchO8APqauV2DpacZ1oo+8=;
        b=qO/OUxiAfbpOJoSahWpZAi1T5JDSt++EDHzGZYhtELI7uZt56zVzVrsJkUkn+gx7T6
         5Ubww+J6Q+7k5c5UlhQEhmqxZGlw/p7RmyWH956D6TWatyabdeQK7vDGB/mADOJGPaPt
         WxtFvVSShhGGvdEk4OZxXSxmPYLwJoKiwxOBT0lfQEbnNqwy3vj7GJPslYNz1tbJU6s5
         IMDValdokWK/Xr1RqRG7nHBrycHdVO+o2CfBltllTSll9bQwXWt2gU0U6UIth/wdUJsi
         UMMF/80PKzE5PXKr5H0PFjf1Xr7MDWpQ0ZsqMaEt8KVvfgxx+WU+tmW5ShjCN7bu0JPX
         c/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUg/wYaysJ9C+txXBqXJAWOSsRMjEOuSQRn1FN7jqHtP/WQfukBNdGDWQ2ite2EJsR3CszsiPb7k0LPWxSK@vger.kernel.org, AJvYcCUmCMvoksdPjcCW29s1m/zciGhTAHEwTu50q2W34IVd9wLiNf3EPF8Wht3uU6cTz96pl+Q=@vger.kernel.org, AJvYcCWLuJYNMevNBLRSe8fmVReN5TWWsMuQl6N7zR7V56D+23mkEDSCtXEFcSzRtZEJOCARd+BYEYLe2yV2N4hnqPky@vger.kernel.org
X-Gm-Message-State: AOJu0YykGqSFSI47tomb+v1xKYaPsWav50vpPfdgObIrkkvgdUDbYo7O
	3ki2FsfmAPwjZB+3/GeeNmxHj1F3FwabFdQ1IYAhVPTv4HmHmp+MJxpr7T0BvKf3OVQeDRuy6o9
	j+yH6A+y/JUy6zptDIGicMBo2j0I=
X-Google-Smtp-Source: AGHT+IFK/lZXz0IHoUgrXllBUT9eLn/Ael0Qb2qyqEG4kyySLrrVw4B9bs8rgZjv/Z6k79wgsQ4OkBzEk1b71P+EW7c=
X-Received: by 2002:a5d:4250:0:b0:37c:d276:f04 with SMTP id
 ffacd0b85a97d-37d0e7d40f1mr588373f8f.45.1728002250056; Thu, 03 Oct 2024
 17:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727914243.git.dxu@dxuuu.xyz> <4ed563d21d1e34508a347a5b91a8089cbbae47c2.1727914243.git.dxu@dxuuu.xyz>
In-Reply-To: <4ed563d21d1e34508a347a5b91a8089cbbae47c2.1727914243.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Oct 2024 17:37:18 -0700
Message-ID: <CAADnVQJdGmZJHURndkB42Fk4KVsr8XPKHSYygN7qAA7HEAbo6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: verifier: Support eliding map lookup nullness
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shuah Khan <shuah@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:12=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit allows progs to elide a null check on statically known map
> lookup keys. In other words, if the verifier can statically prove that
> the lookup will be in-bounds, allow the prog to drop the null check.
>
> This is useful for two reasons:
>
> 1. Large numbers of nullness checks (especially when they cannot fail)
>    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> 2. It forms a tighter contract between programmer and verifier.
>
> For (1), bpftrace is starting to make heavier use of percpu scratch
> maps. As a result, for user scripts with large number of unrolled loops,
> we are starting to hit jump complexity verification errors.  These
> percpu lookups cannot fail anyways, as we only use static key values.
> Eliding nullness probably results in less work for verifier as well.
>
> For (2), percpu scratch maps are often used as a larger stack, as the
> currrent stack is limited to 512 bytes. In these situations, it is
> desirable for the programmer to express: "this lookup should never fail,
> and if it does, it means I messed up the code". By omitting the null
> check, the programmer can "ask" the verifier to double check the logic.
>
> Tests also have to be updated in sync with these changes, as the
> verifier is more efficient with this change. Notable, iters.c tests had
> to be changed to use a map type that still requires null checks, as it's
> exercising verifier tracking logic w.r.t iterators.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  kernel/bpf/verifier.c                         | 73 ++++++++++++++++++-
>  tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
>  .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
>  .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
>  .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
>  5 files changed, 82 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d9b38ffd220..9ee2cd6c0508 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -284,6 +284,7 @@ struct bpf_call_arg_meta {
>         u32 ret_btf_id;
>         u32 subprogno;
>         struct btf_field *kptr_field;
> +       long const_map_key;

key might collide with special -1 on 32-bit archs ?
s64 instead ?

>  };
>
>  struct bpf_kfunc_call_arg_meta {
> @@ -10416,6 +10417,60 @@ static void update_loop_inline_state(struct bpf_=
verifier_env *env, u32 subprogno
>                                  state->callback_subprogno =3D=3D subprog=
no);
>  }
>
> +/* Returns whether or not the given map type can potentially elide
> + * lookup return value nullness check. This is possible if the key
> + * is statically known.
> + */
> +static bool can_elide_value_nullness(enum bpf_map_type type)
> +{
> +       switch (type) {
> +       case BPF_MAP_TYPE_ARRAY:
> +       case BPF_MAP_TYPE_PERCPU_ARRAY:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +/* Returns constant key value if possible, else -1 */
> +static long get_constant_map_key(struct bpf_verifier_env *env,
> +                                struct bpf_reg_state *key)
> +{
> +       struct bpf_func_state *state =3D func(env, key);
> +       struct bpf_reg_state *reg;
> +       int stack_off;
> +       int slot;
> +       int spi;
> +
> +       if (!env->bpf_capable)
> +               return -1;
> +       if (key->type !=3D PTR_TO_STACK)
> +               return -1;
> +       if (!tnum_is_const(key->var_off))
> +               return -1;
> +
> +       stack_off =3D key->off + key->var_off.value;
> +       slot =3D -stack_off - 1;
> +       if (slot < 0)
> +               /* Stack grew upwards. This is properly checked
> +                * as part of helper argument processing, but since
> +                * this runs before those checks, we need to preemptively
> +                * do this here.
> +                */
> +               return -1;
> +       else if (slot >=3D state->allocated_stack)
> +               /* Stack uninitialized */
> +               return -1;
> +
> +       spi =3D slot / BPF_REG_SIZE;
> +       reg =3D &state->stack[spi].spilled_ptr;

reg->type =3D=3D SCALAR
check is missing.
slot->type should also be checked.
spiller_ptr is only correct for STACK_SPILL.

it should also recognize that STACK_ZERO means zero.

> +       if (!tnum_is_const(reg->var_off))
> +               /* Stack value not statically known */
> +               return -1;

I suspect tnum_is_const could pass for pointers and other !scalar.

> +
> +       return reg->var_off.value;

and this will be zero by accident.

Bits of check_stack_read_fixed_off() should probably be
factored out and used here.

> +}
> +
>  static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
>                             const struct bpf_func_proto **ptr)
>  {
> @@ -10513,6 +10568,15 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                         env->insn_aux_data[insn_idx].storage_get_func_ato=
mic =3D true;
>         }
>
> +       /* Logically we are trying to check on key register state before
> +        * the helper is called, so process here. Otherwise argument proc=
essing
> +        * may clobber the spilled key values.
> +        */
> +       regs =3D cur_regs(env);
> +       if (func_id =3D=3D BPF_FUNC_map_lookup_elem)
> +               meta.const_map_key =3D get_constant_map_key(env, &regs[BP=
F_REG_2]);
> +
> +

I think the logic is too specific.
Let's make it more generic.
It probably better to do later in:
case ARG_PTR_TO_MAP_KEY:
after check_helper_mem_access() returns 0
and store into meta.const_map_key.

>         meta.func_id =3D func_id;
>         /* check args */
>         for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> @@ -10773,10 +10837,17 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>                                 "kernel subsystem misconfigured verifier\=
n");
>                         return -EINVAL;
>                 }
> +
> +               if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&

and only here check for func_id.

Saving meta.const_map_key can be unconditional for all ARG_PTR_TO_MAP_KEY.

We can use it in a follow up to optimize lookup/update from arrays.
Currently array_map_gen_lookup() still emits a load from key
and bounds check.
All that can be optimized with const_map_key.

> +                   can_elide_value_nullness(meta.map_ptr->map_type) &&
> +                   meta.const_map_key >=3D 0 &&
> +                   meta.const_map_key < meta.map_ptr->max_entries)
> +                       ret_flag &=3D ~PTR_MAYBE_NULL;
> +
>                 regs[BPF_REG_0].map_ptr =3D meta.map_ptr;
>                 regs[BPF_REG_0].map_uid =3D meta.map_uid;
>                 regs[BPF_REG_0].type =3D PTR_TO_MAP_VALUE | ret_flag;
> -               if (!type_may_be_null(ret_type) &&
> +               if (!type_may_be_null(regs[BPF_REG_0].type) &&

I would use ret_flag here instead of R0.type.

pw-bot: cr

