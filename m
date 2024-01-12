Return-Path: <linux-kselftest+bounces-2924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC6D82C5C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D45E1F23AE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518115AE3;
	Fri, 12 Jan 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAHXqmLp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1F15AD9;
	Fri, 12 Jan 2024 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3376ead25e1so4642558f8f.3;
        Fri, 12 Jan 2024 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705086669; x=1705691469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4DRy7ttUXUGO5+1V+tRm1bpxpWOzdI7OtjpeJ3+j9M=;
        b=SAHXqmLplXBAIJ9sODJDUGwjvcl7jNVe7QxX7dxOFiW5VAJKXFNr94GotIDLkEN4ts
         CVdEvpf3C6knndwDbaR8GADqDayXhLzMUnK0NebKlxVLTuC1FcyUncuEC0NCmNyTpQfX
         ojsni+yUzD06ZmKPljjK2/P1v9nMRIOAGFWjlg9oxkdJYD6ptBamrLZmMF7WRLSfhdLt
         dUKN2FBBYFhq4+7YJF4EmxYQvy/UzAmVBiE9oerE9ruAKpTuZ+/LrV/8xq0KjhyS1hah
         4MvUDo7uixV4vH7pXUiN84DZEWfMtMV1oj4b8MOmTql/LP+qCCBI7X3YemPcy7PTp8dX
         Nw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705086669; x=1705691469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4DRy7ttUXUGO5+1V+tRm1bpxpWOzdI7OtjpeJ3+j9M=;
        b=G4xJU7rYFcFrvXkymScPk6ejPcEYoYxxuQqxnQeV8mOt6IFvEC30BJCwWxFoyd1JdF
         Wvge0UDZEjO4dzX/UkoM8X9bmaWJ5rOJBNxHhpSNcOnCZRRMADPC8qgHf7u4FpnJf1OP
         bFaZnGjGdgsjTme/41RAT8SH3Iz3FT738mYa0mC5ro6KeqCeckcrIPWC5Ya/D4bNUv4G
         ZmyIt9WKkEaQP20Jmtux+ri8D+BFwfv/uVdFNUKEx1KHP9i+DSiCe+Eu7lai0ju6rRmV
         4AIe7WPiTDlJJC7n8xs64XwI/syOio2rrWY4mAgYiLGLc4Ljy6WLe4gotMv0iG4Ak145
         iPxA==
X-Gm-Message-State: AOJu0Yw49/srC3e8gp+YGSzsp1We9g2bshJJu/OBWIk5sTYzKP96Dbj3
	pztVbB1WG7eS7WMRmPRM1BXuoE5gTh1o3zHB8fI=
X-Google-Smtp-Source: AGHT+IG6x/wjPOylVpwcacG6t2ZNNQ+8joa/CuXUc7ye4e2ky9WgagTDTzpk63DNTtyhTdBs3PDCnaifdKiucjWp+kM=
X-Received: by 2002:a05:600c:4f55:b0:40d:7d62:80ab with SMTP id
 m21-20020a05600c4f5500b0040d7d6280abmr877198wmq.117.1705086668813; Fri, 12
 Jan 2024 11:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-11-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-11-maxtram95@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jan 2024 11:10:57 -0800
Message-ID: <CAADnVQ+3go895wfmdCDnxt8FHhD9VMhtDZrPfe6i90LEBOonPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/15] bpf: Track spilled unbounded scalars
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:53=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> From: Maxim Mikityanskiy <maxim@isovalent.com>
>
> Support the pattern where an unbounded scalar is spilled to the stack,
> then boundary checks are performed on the src register, after which the
> stack frame slot is refilled into a register.
>
> Before this commit, the verifier didn't treat the src register and the
> stack slot as related if the src register was an unbounded scalar. The
> register state wasn't copied, the id wasn't preserved, and the stack
> slot was marked as STACK_MISC. Subsequent boundary checks on the src
> register wouldn't result in updating the boundaries of the spilled
> variable on the stack.
>
> After this commit, the verifier will preserve the bond between src and
> dst even if src is unbounded, which permits to do boundary checks on src
> and refill dst later, still remembering its boundaries. Such a pattern
> is sometimes generated by clang when compiling complex long functions.
>
> One test is adjusted to reflect the fact that an untracked register is
> marked as precise at an earlier stage, and one more test is adjusted to
> reflect that now unbounded scalars are tracked.
>
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c                                   | 7 +------
>  tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 6 +++---
>  tools/testing/selftests/bpf/verifier/precise.c          | 6 +++---
>  3 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 055fa8096a08..e7fff5f5aa1d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4389,11 +4389,6 @@ static bool __is_scalar_unbounded(struct bpf_reg_s=
tate *reg)
>                reg->u32_min_value =3D=3D 0 && reg->u32_max_value =3D=3D U=
32_MAX;
>  }
>
> -static bool register_is_bounded(struct bpf_reg_state *reg)
> -{
> -       return reg->type =3D=3D SCALAR_VALUE && !__is_scalar_unbounded(re=
g);
> -}
> -
>  static bool __is_pointer_value(bool allow_ptr_leaks,
>                                const struct bpf_reg_state *reg)
>  {
> @@ -4504,7 +4499,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>                 return err;
>
>         mark_stack_slot_scratched(env, spi);
> -       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && e=
nv->bpf_capable) {
> +       if (reg && !(off % BPF_REG_SIZE) && reg->type =3D=3D SCALAR_VALUE=
 && env->bpf_capable) {
>                 bool reg_value_fits;
>
>                 reg_value_fits =3D get_reg_width(reg) <=3D BITS_PER_BYTE =
* size;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index b05aab925ee5..57eb70e100a3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -452,9 +452,9 @@ l0_%=3D:      r1 >>=3D 16;                           =
           \
>  SEC("raw_tp")
>  __log_level(2)
>  __success
> -__msg("fp-8=3D0m??mmmm")
> -__msg("fp-16=3D00mm??mm")
> -__msg("fp-24=3D00mm???m")
> +__msg("fp-8=3D0m??scalar()")
> +__msg("fp-16=3D00mm??scalar()")
> +__msg("fp-24=3D00mm???scalar()")
>  __naked void spill_subregs_preserve_stack_zero(void)
>  {
>         asm volatile (
> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
> index 8a2ff81d8350..0a9293a57211 100644
> --- a/tools/testing/selftests/bpf/verifier/precise.c
> +++ b/tools/testing/selftests/bpf/verifier/precise.c
> @@ -183,10 +183,10 @@
>         .prog_type =3D BPF_PROG_TYPE_XDP,
>         .flags =3D BPF_F_TEST_STATE_FREQ,
>         .errstr =3D "mark_precise: frame0: last_idx 7 first_idx 7\
> -       mark_precise: frame0: parent state regs=3Dr4 stack=3D:\
> +       mark_precise: frame0: parent state regs=3Dr4 stack=3D-8:\
>         mark_precise: frame0: last_idx 6 first_idx 4\
> -       mark_precise: frame0: regs=3Dr4 stack=3D before 6: (b7) r0 =3D -1=
\
> -       mark_precise: frame0: regs=3Dr4 stack=3D before 5: (79) r4 =3D *(=
u64 *)(r10 -8)\
> +       mark_precise: frame0: regs=3Dr4 stack=3D-8 before 6: (b7) r0 =3D =
-1\
> +       mark_precise: frame0: regs=3Dr4 stack=3D-8 before 5: (79) r4 =3D =
*(u64 *)(r10 -8)\
>         mark_precise: frame0: regs=3D stack=3D-8 before 4: (7b) *(u64 *)(=
r3 -8) =3D r0\
>         mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
>         mark_precise: frame0: last_idx 3 first_idx 3\

Yesterday I've applied patches 1 through 11 to bpf-next.
Then Yonghong found that removal of register_is_bounded()
in this patch 10 makes __is_scalar_unbounded() unused which
breaks build.
So I dropped patches 10 and 11.

Today we found out that test_verifier is broken with patches 1 through 9.
Turned out that this hunk for verifier/precise.c in patch 10 should have be=
en
in patch 8.
I manually took it and force pushed bpf-next again.
Please test bisectability of the series more carefully in the future.

As far as register_is_bounded() issue.
Maybe order patch 14 that uses __is_scalar_unbounded() first and
then add this patch 10 ?
Other ideas?

