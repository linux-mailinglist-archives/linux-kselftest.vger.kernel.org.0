Return-Path: <linux-kselftest+bounces-23376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E09F198D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 00:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4598D16495F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 23:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A852B1A8F98;
	Fri, 13 Dec 2024 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+tFVfyT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD6189F57;
	Fri, 13 Dec 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130946; cv=none; b=rRyC/5AbJlvJxNODpM/tEoqyWnYKNE43BOOE/TsKerBeBmPNvFN8Z6Qt9X4xfrHUvGfMyE6kWHT4GEbLu8WdUKqEDEDhbWIUicDWDoIDgEAU6u/jmQR/H0DVoNdw7JXlXC8niatsoFIZpfL4HW8FB96B0ajp4TFIXF9R/TusHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130946; c=relaxed/simple;
	bh=0hXPPeazK47KkVCir4tsVhL3yxd1Kary+/TTq7stzMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgpZHQrQGDgVqBPVDO7ATrUh2ZtPqAzCXDGr7ASBIKv3E3BXlbF3UqkTvdqPmJ8KWnbSwnJb+eydsGYwl56eajwdosVLDDK1eYCTaMwmfhAPj6o7aWO2AV5kcwIWJyyZfzAN/+FLW0fXHZd/IUvGw7o9vHmIsPtvcTt7LK2xX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+tFVfyT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-8019f048bc7so1648914a12.1;
        Fri, 13 Dec 2024 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734130944; x=1734735744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKv5XzUh0C4meBPgAZwwhAJ6ZgqRgXN0C8Ta/CNq1Sk=;
        b=m+tFVfyTEDzRCkZOtjXGe7mynSAQmvaCddnRQkg+emjFZnZoJHZnfcAgy0hDSyx7SJ
         LRTo8Q6kA4UVPtvk0Uc0WQkY0rjpAQAI9es7WohJmTdIvT6LAVuJFXZ8/9XzitOSibG4
         3z/FiXyKBOuP7MUxJzaQqoOSEpMEIrWHC6sL/4DreABKPOiAhDCgqRDh2DKUmqbM8Hwv
         LTWM7PM1lYMuvTc+D8GgyKacevhZEXZavtS6hx/MVvYzovRM5NU5H4m1sB82zUCoNqgr
         Zu9En7ZuUIJe7FwMmzWgCTFrz5ooLu3ZFZ2NDm2/8DyomwGsSPMW5kjhQ2Frov1QRskv
         x30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734130944; x=1734735744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKv5XzUh0C4meBPgAZwwhAJ6ZgqRgXN0C8Ta/CNq1Sk=;
        b=L83+JgQKSWYUnK639lb6e/FFfW4Ny2ccr3bOUBuZjiav2RG5vWYBcgtPtgx5DUy+VN
         Gl/kxbl9xT8n660zCC+Kg7HJ2Qq1Ef5SYMO4XJc7Xhwq/puRLplfEdlBdqivyu7S8MgH
         bAM/9SfIz9VX760rtUSrtbh/EjJ5RvCD0PvE3Y+VweMkFqSAHeysuaubI7syQPMviVoD
         fK0OgKnxqplebUjkA3QlOGRramT+MfDE5CRxBBlj4suVrMj++lflvy2AU0vofsMcH8Ec
         xXujpTreWEXIj6Ag1NI6L884IpXbItTyLCXNdO/JRWtbGMXLeRqLcGvu/AHTKNe60YnO
         WW5A==
X-Forwarded-Encrypted: i=1; AJvYcCUaDJCLn+FNV36g53KoPKZGn9Hl1lR9GvRYjpQGXJoWg95Zj4Y4PiG2PhLUHlf3GOcbMTM=@vger.kernel.org, AJvYcCVn13wN4ngknalZgPDrrE/NsXU3v6SJm+W/7Lx4RL3TtlAL/HfpOZ6SG3D0/1U8VzOX1rYvbuPOvJBNyXSrUlqK@vger.kernel.org, AJvYcCW9bykodn6Eud1ruF7Cdm3vDoGsiFlKSp2NitdjNUF8R6KSjJDNZNCLqQ8tvWUwPJo+75WVkmxp1Oy5Ceuj@vger.kernel.org, AJvYcCWWRwlei3zXiqCklISJPJebKFM8uOdbWVI7+BULoXptHUbRZlwjNp3plW08z1mGl+KK2KaJ9C0Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76ADVMN9ivbhXbo2MV+nr6TANEReY9J4pqwzsBJIKGCUTbx4g
	bCeZSeDIHQSGx+1ym8YlDfrqsZDGhTYEg6u1qzEpMFBpdNYkvwf90JnTsAZtxfElzDY6COvmTEe
	U/4Hx+BR0SCESlW3376TnooGJUfI=
X-Gm-Gg: ASbGncsO5EAuodpXuiV7Ff2rnC1k8nExSyTwHIjc/crl/+k9oTIQu6XEbuiYJ46LxeF
	zziF4uAXiNtAEMtsv9/XOrGR61/hhDtPMIwB/udh0aUFCNkLQENm3UQ==
X-Google-Smtp-Source: AGHT+IEgTN9e12AHmnF7HTjA1lax9Frb1p24w1dpS+ljzdVozwO5C+WHDrmStzbx4j/IoTB4mh2jvLb24bzCZlZyNZI=
X-Received: by 2002:a17:90b:1a92:b0:2ee:c4f2:a77d with SMTP id
 98e67ed59e1d1-2f28fd6e7d2mr5785464a91.21.1734130944218; Fri, 13 Dec 2024
 15:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734045451.git.dxu@dxuuu.xyz> <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
In-Reply-To: <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 15:02:11 -0800
Message-ID: <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map lookup nullness
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:23=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
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
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  kernel/bpf/verifier.c                         | 80 ++++++++++++++++++-
>  tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
>  .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
>  .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
>  .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
>  5 files changed, 87 insertions(+), 13 deletions(-)
>

Eduard has great points. I've added a few more comments below.

pw-bot: cr

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 58b36cc96bd5..4947ef884a18 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -287,6 +287,7 @@ struct bpf_call_arg_meta {
>         u32 ret_btf_id;
>         u32 subprogno;
>         struct btf_field *kptr_field;
> +       s64 const_map_key;
>  };
>
>  struct bpf_kfunc_call_arg_meta {
> @@ -9163,6 +9164,53 @@ static int check_reg_const_str(struct bpf_verifier=
_env *env,
>         return 0;
>  }
>
> +/* Returns constant key value if possible, else -1 */
> +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> +                               struct bpf_reg_state *key,
> +                               u32 key_size)
> +{
> +       struct bpf_func_state *state =3D func(env, key);
> +       struct bpf_reg_state *reg;
> +       int zero_size =3D 0;
> +       int stack_off;
> +       u8 *stype;
> +       int slot;
> +       int spi;
> +       int i;
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
> +       spi =3D slot / BPF_REG_SIZE;
> +
> +       /* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE =
*/
> +       stype =3D state->stack[spi].slot_type;
> +       for (i =3D 0; i < BPF_REG_SIZE && stype[i] =3D=3D STACK_ZERO; i++=
)

it's Friday and I'm lazy, but please double-check that this works for
both big-endian and little-endian :)

with Eduard's suggestion this also becomes interesting when you have
000mmm mix (as one example), because that gives you a small range, and
all values might be valid keys for arrays

> +               zero_size++;
> +       if (zero_size =3D=3D key_size)
> +               return 0;
> +
> +       if (!is_spilled_reg(&state->stack[spi]))
> +               /* Not pointer to stack */

!is_spilled_reg and "Not pointer to stack" seem to be not exactly the
same things?

btw, we also have is_spilled_scalar_reg() which you can use here
instead of two separate checks?

> +               return -1;
> +
> +       reg =3D &state->stack[spi].spilled_ptr;
> +       if (reg->type !=3D SCALAR_VALUE)
> +               /* Only scalars are valid array map keys */
> +               return -1;
> +       else if (!tnum_is_const(reg->var_off))
> +               /* Stack value not statically known */
> +               return -1;
> +
> +       return reg->var_off.value;
> +}
> +

[...]

