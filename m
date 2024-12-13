Return-Path: <linux-kselftest+bounces-23377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC19F19AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 00:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1825C165FDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700731B0F3D;
	Fri, 13 Dec 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJG7oN41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386711AF0B8;
	Fri, 13 Dec 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131444; cv=none; b=dCPvnzPPZQWOInZUCfIvHmAyAVaf97Y93/bUYlGhzVHnHSSY/yDY12NY0VVupSYkZ3VCZSTOiTPkw9FOZnACBfmc6zsI/hLUE/o/0pWWJrcrGLLhNNaE1/X65FbKg1T8zfCb2oD0Sw2cuIeHqvZm//yXDFy9/vB6Y4tg5dU8fCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131444; c=relaxed/simple;
	bh=qedePOufLiB91e89mYdHZJdZkSUciNNh+1MUO5h5y5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvGz8RbIqS/q9GL/rGtU1p2uGuoxJtih5rsWkfdKHz8C2aajXDRucIFcAU9O21Gt8E91O8e+u8tJp/YYOqMQLv1j0zA+75SYSCpEcbXikXppt6FSomAmID7tNg6s2r9/XL6OPz4lY1ZfADAWwF4yT+oE+o0EUGMzLAinsRVg/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJG7oN41; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so3115921a12.3;
        Fri, 13 Dec 2024 15:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734131440; x=1734736240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4HgsKDBs+Qn+xpS30jWcYSRR5PGzQ6EeNIIK53QvACw=;
        b=SJG7oN41mRuHsYUWEDKcfo+DWy3s2Yzd33w5oxZmCYEbWbBHleIc5/JrPBcwMdhCMt
         DlRz+hZHJ3wAM3zfGMecwDlOoBNzIbMRYrgnWWvAaAaRu9ctQfd9xm0Fz3wjzCiJPeWh
         qQlmQW1RYxsLs0TqvVno1qm8i5OhmnIUkzlOi8gP6zosm/LjACE9prdmA1ScVavY7NUy
         yyjKcAalHVASdsBU/isN37JeZh2QLienxDfP2TgV/6YH4Y3SP1QTq02eQuJ4OkZHALTY
         ad9zHKXQBK+iTU6JHcJ+RNtCWCKkf8qpw3kioSYSoCtpQYC/P7Y0vH+q434DtVy2aYsA
         XqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131440; x=1734736240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HgsKDBs+Qn+xpS30jWcYSRR5PGzQ6EeNIIK53QvACw=;
        b=ncfvwkRKOheQ7Im7NaNHnYKcLB2DADrbYVXpuUzzO55E8CA/eL1lv0C3/2LNTkIT4I
         PpUATJR0SMDgn336L9dBCXbzQ6URF1db8gxwMfQOISLakAEaM4F/aJPYd0DvExWMcY9O
         IDOls0AprJYEvfssFexgPn6OO1OUcUrTda0H9RO8DQcFh2B6RKBngnlqel7zWASNejzu
         TCAC73fFkJ4ASGVs4CJqnbL2yFxm5SVkhW1tk+1RjARe+yCbBYiIUmYflJfY6DATtduW
         aLTvHt3solFd3hY9Raojn6h1UsjuJMPf0o31NMedvyhFsPZYtjgLEUzO2jrzepuyOUQc
         dEEw==
X-Forwarded-Encrypted: i=1; AJvYcCU/wRLBo2anFpnluFMZfhMHnQw3oejvXlsZHB5tS7grBvybtFzOJjcTRyBpKsK2IlPuiIWqgbbM/aJP47uo@vger.kernel.org, AJvYcCURYABq5/e9TVAfm3kESQRFR+EfQadIcq1JA6P/Wwy7+hifDWsvqAUZz2uywH/2aO5Mccxal6XQ@vger.kernel.org, AJvYcCUVG8JLY1/T15lnh+ENqV+uKBaZTwOJ6oozRD/RmMWoNTVpet5Veq+hbbuhktoJi8JvdawhRr429rffv6RZCyd1@vger.kernel.org, AJvYcCUauj5+lFPD+UM+SpcETOtXC6otgLJid5KLYtkGpzZHw03kqmeeCAWj4CNAi8KAJOi3eWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ci4+Lr4TVdsniFbpToHNfcQEaxzJwV2J7cl8SRkUoyRflDm/
	b0wgVFc68Nti9RWfq62s6DmBiZY6cZ+Mc9U8k9GtV2lta7z4s71bMHyRDga+Sj5voQ4ytdlV84b
	Ow7qH7ZqS7F3h38yl62wmvmjeGPXU/STL359EBpgT
X-Gm-Gg: ASbGncvnnLOKcO2S+BU5QY4X2Y68aXHDTZWvFjXWdWvsALRWPk6+X7wU9KMtjByAfjq
	SF5ktXCd7CiokjS1iZlqoadoiLjFa3WhbfDynrgbw
X-Google-Smtp-Source: AGHT+IHTXouWxuxa+z+F9xslgCHS2p9l2TaS88XEbP7JWoQQDDbR8rBVpdawNGQyXHEKOINFYvF8fPuoQBmbFTEI35I=
X-Received: by 2002:a05:6402:254e:b0:5d0:d183:cc05 with SMTP id
 4fb4d7f45d1cf-5d63c2e7f89mr4018000a12.5.1734131440219; Fri, 13 Dec 2024
 15:10:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734045451.git.dxu@dxuuu.xyz> <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
In-Reply-To: <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 14 Dec 2024 00:10:04 +0100
Message-ID: <CAP01T76UQgb=Y0kh6bKPABt=p8=JRmDHsFc31rsijXSrK+5+8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map lookup nullness
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 00:24, Daniel Xu <dxu@dxuuu.xyz> wrote:
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
> @@ -9163,6 +9164,53 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> +/* Returns constant key value if possible, else -1 */
> +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> +                               struct bpf_reg_state *key,
> +                               u32 key_size)
> +{
> +       struct bpf_func_state *state = func(env, key);
> +       struct bpf_reg_state *reg;
> +       int zero_size = 0;
> +       int stack_off;
> +       u8 *stype;
> +       int slot;
> +       int spi;
> +       int i;
> +
> +       if (!env->bpf_capable)
> +               return -1;
> +       if (key->type != PTR_TO_STACK)
> +               return -1;
> +       if (!tnum_is_const(key->var_off))
> +               return -1;
> +
> +       stack_off = key->off + key->var_off.value;
> +       slot = -stack_off - 1;
> +       spi = slot / BPF_REG_SIZE;
> +
> +       /* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE */
> +       stype = state->stack[spi].slot_type;
> +       for (i = 0; i < BPF_REG_SIZE && stype[i] == STACK_ZERO; i++)
> +               zero_size++;
> +       if (zero_size == key_size)
> +               return 0;
> +
> +       if (!is_spilled_reg(&state->stack[spi]))
> +               /* Not pointer to stack */
> +               return -1;
> +
> +       reg = &state->stack[spi].spilled_ptr;
> +       if (reg->type != SCALAR_VALUE)
> +               /* Only scalars are valid array map keys */
> +               return -1;
> +       else if (!tnum_is_const(reg->var_off))
> +               /* Stack value not statically known */
> +               return -1;
> +
> +       return reg->var_off.value;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                           struct bpf_call_arg_meta *meta,
>                           const struct bpf_func_proto *fn,
> @@ -9173,6 +9221,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>         enum bpf_arg_type arg_type = fn->arg_type[arg];
>         enum bpf_reg_type type = reg->type;
>         u32 *arg_btf_id = NULL;
> +       u32 key_size;
>         int err = 0;
>         bool mask;
>
> @@ -9307,8 +9356,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                         verbose(env, "invalid map_ptr to access map->key\n");
>                         return -EACCES;
>                 }
> -               err = check_helper_mem_access(env, regno, meta->map_ptr->key_size,
> -                                             BPF_READ, false, NULL);
> +               key_size = meta->map_ptr->key_size;
> +               err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
> +               if (err)
> +                       return err;
> +               meta->const_map_key = get_constant_map_key(env, reg, key_size);
>                 break;
>         case ARG_PTR_TO_MAP_VALUE:
>                 if (type_may_be_null(arg_type) && register_is_null(reg))
> @@ -10833,6 +10885,21 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>                                  state->callback_subprogno == subprogno);
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
>  static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
>                             const struct bpf_func_proto **ptr)
>  {
> @@ -11199,10 +11266,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                                 "kernel subsystem misconfigured verifier\n");
>                         return -EINVAL;
>                 }
> +
> +               if (func_id == BPF_FUNC_map_lookup_elem &&
> +                   can_elide_value_nullness(meta.map_ptr->map_type) &&
> +                   meta.const_map_key >= 0 &&
> +                   meta.const_map_key < meta.map_ptr->max_entries)
> +                       ret_flag &= ~PTR_MAYBE_NULL;

I think we probably need mark_chain_precision applied on the constant
key since its concrete value is made use of here to prevent pruning on
it. If it's already happening and I missed it, I think we should
atleast add a comment.

For context of a similar case with tail calls, see commit
cc52d9140aa9 ("bpf: Fix record_func_key to perform backtracking on r3")
for what happens when it is missed.

> +
>                 regs[BPF_REG_0].map_ptr = meta.map_ptr;
>                 regs[BPF_REG_0].map_uid = meta.map_uid;
>                 regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
> -               if (!type_may_be_null(ret_type) &&
> +               if (!type_may_be_null(ret_flag) &&
>                     btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
>                         regs[BPF_REG_0].id = ++env->id_gen;
>                 }
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> index 7c969c127573..190822b2f08b 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -524,11 +524,11 @@ int iter_subprog_iters(const void *ctx)
>  }
>
>  struct {
> -       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(type, BPF_MAP_TYPE_HASH);
>         __type(key, int);
>         __type(value, int);
>         __uint(max_entries, 1000);
> -} arr_map SEC(".maps");
> +} hash_map SEC(".maps");
>
>  SEC("?raw_tp")
>  __failure __msg("invalid mem access 'scalar'")
> @@ -539,7 +539,7 @@ int iter_err_too_permissive1(const void *ctx)
>
>         MY_PID_GUARD();
>
> -       map_val = bpf_map_lookup_elem(&arr_map, &key);
> +       map_val = bpf_map_lookup_elem(&hash_map, &key);
>         if (!map_val)
>                 return 0;
>
> @@ -561,12 +561,12 @@ int iter_err_too_permissive2(const void *ctx)
>
>         MY_PID_GUARD();
>
> -       map_val = bpf_map_lookup_elem(&arr_map, &key);
> +       map_val = bpf_map_lookup_elem(&hash_map, &key);
>         if (!map_val)
>                 return 0;
>
>         bpf_repeat(1000000) {
> -               map_val = bpf_map_lookup_elem(&arr_map, &key);
> +               map_val = bpf_map_lookup_elem(&hash_map, &key);
>         }
>
>         *map_val = 123;
> @@ -585,7 +585,7 @@ int iter_err_too_permissive3(const void *ctx)
>         MY_PID_GUARD();
>
>         bpf_repeat(1000000) {
> -               map_val = bpf_map_lookup_elem(&arr_map, &key);
> +               map_val = bpf_map_lookup_elem(&hash_map, &key);
>                 found = true;
>         }
>
> @@ -606,7 +606,7 @@ int iter_tricky_but_fine(const void *ctx)
>         MY_PID_GUARD();
>
>         bpf_repeat(1000000) {
> -               map_val = bpf_map_lookup_elem(&arr_map, &key);
> +               map_val = bpf_map_lookup_elem(&hash_map, &key);
>                 if (map_val) {
>                         found = true;
>                         break;
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index c2a6bd392e48..4c0ff01f1a96 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -345,7 +345,7 @@ int reject_indirect_global_func_access(struct __sk_buff *ctx)
>  }
>
>  SEC("?tc")
> -__failure __msg("Unreleased reference id=5 alloc_insn=")
> +__failure __msg("Unreleased reference id=4 alloc_insn=")
>  int kptr_xchg_ref_state(struct __sk_buff *ctx)
>  {
>         struct prog_test_ref_kfunc *p;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> index 4eaab1468eb7..7d088ba99ea5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> @@ -47,7 +47,7 @@ l0_%=:        r0 = 0;                                         \
>
>  SEC("xdp")
>  __description("map in map state pruning")
> -__success __msg("processed 26 insns")
> +__success __msg("processed 15 insns")
>  __log_level(2) __retval(0) __flag(BPF_F_TEST_STATE_FREQ)
>  __naked void map_in_map_state_pruning(void)
>  {
> diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
> index f420c0312aa0..4b39f8472f9b 100644
> --- a/tools/testing/selftests/bpf/verifier/map_kptr.c
> +++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
> @@ -373,7 +373,7 @@
>         .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>         .fixup_map_kptr = { 1 },
>         .result = REJECT,
> -       .errstr = "Unreleased reference id=5 alloc_insn=20",
> +       .errstr = "Unreleased reference id=4 alloc_insn=20",
>         .fixup_kfunc_btf_id = {
>                 { "bpf_kfunc_call_test_acquire", 15 },
>         }
> --
> 2.46.0
>
>

