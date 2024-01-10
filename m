Return-Path: <linux-kselftest+bounces-2778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0144829135
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256471F260B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A9182;
	Wed, 10 Jan 2024 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEOASrjV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54D18A;
	Wed, 10 Jan 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336755f1688so3267452f8f.0;
        Tue, 09 Jan 2024 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704846163; x=1705450963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//4jWgfQ5Fh7VrpoQ0ByJkNQD3sR20k+3Su+DVlmwJ4=;
        b=HEOASrjVxUlKhT9CyG9FuuPat4ArLrdhv/LLju78i5CgQYaUUJ4NwqxS74+pOqeBoQ
         8vH4Gf6nIL0baRAfDm3FXVyLIdbFkmytIjKjE8GqIFwbze75qTGx3tnmBJkm6Py7bxgp
         LaDteFTTKzwfH1bG9cbfvBIYlKP14nA7kk48A1BVDXMtPUutfuoug4BAhMTPSH26bTSD
         98zV2MKWYQn++zOr8K/2FvaA+faNc/xUvoUrcGtD2NqM5/HpJFtsA92PnDYimMGVA4Zf
         08c+DAtDB1vdmNi6YhgnvmM0a8GOEM35nDz26MRSXpp5cZXvqjHZHEyHBh4MIuHph2Wt
         LQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704846163; x=1705450963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//4jWgfQ5Fh7VrpoQ0ByJkNQD3sR20k+3Su+DVlmwJ4=;
        b=K3GSpyQ8yDcEcpKLzotPC3XAJ7u29zfixTGJXlAe7cW7UaWDdnkrJY8EY85dLZPA0t
         HHNuzSsnGPFnByraTST690SW18wfnzC8wzUhDVGEVECJ2ixV+xj5P4rpQBQbNoGRcRhz
         voe+HDCHQAburHPoOgMzaze71GO8euaQcdp4NZNcbvdTUOY+k3+9W5WEvUh5rpp32yE5
         Bmh5Zpq15g7qSHUSWYGvGZgdVwW1r2U+KJ5U5cpDwxBI5SiXbxT3gdwWlfOxxuebhEbA
         D1NjJeoXtBSwg00EGAXHQbsUbJaroNx/zsG35PWwbWOdOH2Qp7s92ULQ16sHgjATXEA5
         PuoA==
X-Gm-Message-State: AOJu0Yz4485okUMp7Q/YtLWWnAQNb31iaawgPuNPX6z0zCrjXFaiBiXJ
	NhiI9fiBwd3+0ztzkLVgpf32cBDMVeQ5aVMk2qM=
X-Google-Smtp-Source: AGHT+IFJu4pcuWWDwwPzsPS+GtYejENavAEoRXZDRagJ95uoP6CMoV93PRbhGbpMGrX34B6cs7g5kdS2u7LfPfOQ19c=
X-Received: by 2002:adf:f34a:0:b0:337:5479:991d with SMTP id
 e10-20020adff34a000000b003375479991dmr75053wrp.71.1704846162827; Tue, 09 Jan
 2024 16:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-15-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-15-maxtram95@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 16:22:30 -0800
Message-ID: <CAEf4BzYizLHHYPg0yKu-no3toMLS3wSyA2V_wtnHAyn6Burofg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/15] bpf: Optimize state pruning for spilled scalars
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
> Changes for scalar ID tracking of spilled unbound scalars lead to
> certain verification performance regression. This commit mitigates the
> regression by exploiting the following properties maintained by
> check_stack_read_fixed_off():
> - a mix of STACK_MISC, STACK_ZERO and STACK_INVALID marks is read as
>   unbounded scalar register;
> - spi with all slots marked STACK_ZERO is read as scalar register with
>   value zero.
>
> This commit modifies stacksafe() to consider situations above
> equivalent.
>
> Veristat results after this patch show significant gains:
>
> $ ./veristat -e file,prog,states -f '!states_pct<10' -f '!states_b<10' -C=
 not-opt after
> File              Program   States (A)  States (B)  States    (DIFF)
> ----------------  --------  ----------  ----------  ----------------
> pyperf180.bpf.o   on_event       10456        8422   -2034 (-19.45%)
> pyperf600.bpf.o   on_event       37319       22519  -14800 (-39.66%)
> strobemeta.bpf.o  on_event       13435        4703   -8732 (-64.99%)
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 83 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index aeb3e198a5ea..cb82f8d4226f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1170,6 +1170,12 @@ static void mark_stack_slot_misc(struct bpf_verifi=
er_env *env, u8 *stype)
>         *stype =3D STACK_MISC;
>  }
>
> +static bool is_spilled_scalar_reg64(const struct bpf_stack_state *stack)
> +{
> +       return stack->slot_type[0] =3D=3D STACK_SPILL &&
> +              stack->spilled_ptr.type =3D=3D SCALAR_VALUE;
> +}
> +
>  static void scrub_spilled_slot(u8 *stype)
>  {
>         if (*stype !=3D STACK_INVALID)
> @@ -16459,11 +16465,45 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
>         }
>  }
>
> +static bool is_stack_zero64(struct bpf_stack_state *stack)
> +{
> +       u32 i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(stack->slot_type); ++i)
> +               if (stack->slot_type[i] !=3D STACK_ZERO)
> +                       return false;
> +       return true;
> +}
> +
> +static bool is_stack_unbound_slot64(struct bpf_verifier_env *env,
> +                                   struct bpf_stack_state *stack)
> +{
> +       u32 i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(stack->slot_type); ++i)
> +               if (stack->slot_type[i] !=3D STACK_ZERO &&
> +                   stack->slot_type[i] !=3D STACK_MISC &&
> +                   (!env->allow_uninit_stack || stack->slot_type[i] !=3D=
 STACK_INVALID))
> +                       return false;
> +       return true;
> +}
> +
> +static bool is_spilled_unbound_scalar_reg64(struct bpf_stack_state *stac=
k)
> +{
> +       return is_spilled_scalar_reg64(stack) && __is_scalar_unbounded(&s=
tack->spilled_ptr);
> +}
> +
>  static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_stat=
e *old,
>                       struct bpf_func_state *cur, struct bpf_idmap *idmap=
, bool exact)
>  {
> +       struct bpf_reg_state unbound_reg =3D {};
> +       struct bpf_reg_state zero_reg =3D {};
>         int i, spi;
>
> +       __mark_reg_unknown(env, &unbound_reg);
> +       __mark_reg_const_zero(env, &zero_reg);
> +       zero_reg.precise =3D true;

these are immutable, right? Would it make sense to set them up just
once as static variables instead of initializing on each check?

> +
>         /* walk slots of the explored stack and ignore any additional
>          * slots in the current stack, since explored(safe) state
>          * didn't use them
> @@ -16484,6 +16524,49 @@ static bool stacksafe(struct bpf_verifier_env *e=
nv, struct bpf_func_state *old,
>                         continue;
>                 }
>

we didn't check that cur->stack[spi] is ok to access yet, it's done a
bit later with `if (i >=3D cur->allocated_stack)`, if I'm not mistaken.
So these checks would need to be moved a bit lower, probably.

> +               /* load of stack value with all MISC and ZERO slots produ=
ces unbounded
> +                * scalar value, call regsafe to ensure scalar ids are co=
mpared.
> +                */
> +               if (is_spilled_unbound_scalar_reg64(&old->stack[spi]) &&
> +                   is_stack_unbound_slot64(env, &cur->stack[spi])) {
> +                       i +=3D BPF_REG_SIZE - 1;
> +                       if (!regsafe(env, &old->stack[spi].spilled_ptr, &=
unbound_reg,
> +                                    idmap, exact))
> +                               return false;
> +                       continue;
> +               }
> +
> +               if (is_stack_unbound_slot64(env, &old->stack[spi]) &&
> +                   is_spilled_unbound_scalar_reg64(&cur->stack[spi])) {
> +                       i +=3D BPF_REG_SIZE - 1;
> +                       if (!regsafe(env,  &unbound_reg, &cur->stack[spi]=
.spilled_ptr,
> +                                    idmap, exact))
> +                               return false;
> +                       continue;
> +               }

scalar_old =3D scalar_cur =3D NULL;
if (is_spilled_unbound64(&old->..))
    scalar_old =3D old->stack[spi].slot_type[0] =3D=3D STACK_SPILL ?
&old->stack[spi].spilled_ptr : &unbound_reg;
if (is_spilled_unbound64(&cur->..))
    scalar_cur =3D cur->stack[spi].slot_type[0] =3D=3D STACK_SPILL ?
&cur->stack[spi].spilled_ptr : &unbound_reg;
if (scalar_old && scalar_cur) {
    if (!regsafe(env, scalar_old, scalar_new, idmap, exact)
        return false;
    i +=3D BPF_REG_SIZE - 1;
    continue;
}

where is_spilled_unbound64() would be basically `return
is_spilled_unbound_scalar_reg64(&old->..) ||
is_stack_unbound_slot64(&old->...)`;

Similarly for zero case? Though I'm wondering if zero case should be
checked first, as it's actually a subset of is_spilled_unbound64 when
it comes to STACK_ZERO/STACK_MISC mixes, no?


> +
> +               /* load of stack value with all ZERO slots produces scala=
r value 0,
> +                * call regsafe to ensure scalar ids are compared and pre=
cision
> +                * flags are taken into account.
> +                */
> +               if (is_spilled_scalar_reg64(&old->stack[spi]) &&
> +                   is_stack_zero64(&cur->stack[spi])) {
> +                       if (!regsafe(env, &old->stack[spi].spilled_ptr, &=
zero_reg,
> +                                    idmap, exact))
> +                               return false;
> +                       i +=3D BPF_REG_SIZE - 1;
> +                       continue;
> +               }
> +
> +               if (is_stack_zero64(&old->stack[spi]) &&
> +                   is_spilled_scalar_reg64(&cur->stack[spi])) {
> +                       if (!regsafe(env, &zero_reg, &cur->stack[spi].spi=
lled_ptr,
> +                                    idmap, exact))
> +                               return false;
> +                       i +=3D BPF_REG_SIZE - 1;
> +                       continue;
> +               }
> +
>                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D ST=
ACK_INVALID)
>                         continue;
>
> --
> 2.43.0
>

