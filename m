Return-Path: <linux-kselftest+bounces-26561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922EA348E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CAC188F956
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970331FFC69;
	Thu, 13 Feb 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da2C4UKE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AC1FF7AD;
	Thu, 13 Feb 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462591; cv=none; b=lkFGznd71FYT6WrG0KJi65qPricZVbCL4bvLU+KvECgrGPGD72CYruZ8lKvog5z0FaAtFDZXPiB1MT6Dcb/LfR2DBQWEe1c+YRoVKsvRJo8tKJ03soNK7HakRXUExgWw/ccIw6ZdrG+m0MjChgcMo6dIG2d052gfsPlnyBl1a2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462591; c=relaxed/simple;
	bh=fWJUQ5afGme+TPZBWsI6xPVrEznKOdyt/aClUOkopWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr95FHeEcrHixc6E5IHRhTFtnsoMBWS8IIIxmTJ/4me+dUKMBWG0qZWZb9jU3FWadX7CroSCn5v/oPRCXlMp6gLTq+1rvzYfJ3NQ63nC/I1trkzU5BVvPWLBMV9+CalRbx89ZoYlYTiPUAjJzrhVSo8JokAtmESRPzdHxvLRm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da2C4UKE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so473793f8f.2;
        Thu, 13 Feb 2025 08:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462588; x=1740067388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS6PTAq/FILaPjbGb4r1nnjBpyEP5iLXfjy7SIzK7gI=;
        b=da2C4UKEiKrP6ZcZJp/s5KMiqEpLKBgO2kBB4Rwpf3V8MpU9IlUtQBF0l5BfqML9z3
         Y5g/Z4da1eKy0O0GUm26Z+6eEyxJnmGB2PGqIwtWf5J86jbZYIuNL5uBvGNqJSGEQFSD
         TV4A78maBXfL5RHBZgGCSewIzteuCv6i9Xzqh4/b1t/Y12PjmSzRI3wxFb5gf+xz2eBd
         QMm1W5OZC17V9BMKNIrbUzYrjbh5Ss6lxyOPeRbI3Pmek0nrSzACn4Gv4XIXiGm4YsQe
         x9L+sQgQX2AhkMocYVmgJVdn5lCK83RnhpYhMr0ahMfasSb6JKHIRaa329efLDvWExpp
         YNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462588; x=1740067388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS6PTAq/FILaPjbGb4r1nnjBpyEP5iLXfjy7SIzK7gI=;
        b=JWBvJBFn+etCddp25IIvoXXMgMVZjX+7B49mGGsf6AvmpZH6kuDRvPzzfkzkBKkhWt
         kAet0YuU+5YrAnhJy08jcbSn/UBY97nzsfynSpRvmrLwzOnJCNQ1bxgaBUIJb+/NMAAW
         O5Q5jJcYqdUQ5+RKDlua0ADlG5NVS9hjtcW3L4eH5E9Mo7yK2VpiXoZNG3ggiZarcsxn
         Z9HjwV9NRERjlDlOxWGZJumVIzqhJY+nDG9x0YnV9Ryc+uCrqxYPrDG5Ljbm1YIkUG69
         5gbzeTKVrYU7U2CtPSvwWqFc8MqbuGqDTfHRujr6UvGIo1cit672JXrOrSuXBPA/17fQ
         S6lg==
X-Forwarded-Encrypted: i=1; AJvYcCV3FHIbiZSdtBRhfLmrW54FTg9l+p8riU55fQN6Eqxgm46Co9RW3sIay2M++l0QeCfGi2lN6Ksj0HLTpuXsUw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeE5I6WwPRt4+MIe4b73QA5i58Oi3dGjdv3Z2MdZIki9CdR+9C
	sIjkRWOl5tc+scV2Db5kghrLrpMYHMUqde9TLaSkBhs3jwBoiJaF95ctEt+97BA+5lQY+xSIbDy
	gnWmVDG70V3LmXfaVR9zRh6eHkT4=
X-Gm-Gg: ASbGncuvk/pfnP5NNStFI+9CEMpmXDbKm4GkVuE/LinpYcirfD2+2+qVMzoc+ZQSDMi
	QX0vuso5AEjfkF0vBeqWClzuvwmB42/q9Tfq/7Zzdit3bBtXpBjQel2hERq+zwI/8lWLlQnkfDi
	00b9GxTY9oxlW0oYMbL2KbAqqFFxVd
X-Google-Smtp-Source: AGHT+IE64metSdWOVEHOcc0NJPo9nPR0omrGmYhpDOoTuMaZoAMoR9YIG9mUuma91uSv8ofk88eiX2inKTjB7kJVMLQ=
X-Received: by 2002:a05:6000:18a5:b0:385:f249:c336 with SMTP id
 ffacd0b85a97d-38dea2f758emr7936739f8f.45.1739462587741; Thu, 13 Feb 2025
 08:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213131214.164982-1-mrpre@163.com> <20250213131214.164982-2-mrpre@163.com>
In-Reply-To: <20250213131214.164982-2-mrpre@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 08:02:55 -0800
X-Gm-Features: AWEUYZkSQnOLywGagd6n9cqyhfyUU7fyqjY14k0x68r039IwDS7XGE86VX0pSr4
Message-ID: <CAADnVQ++goV=Yi=dhXNa5F-h0o7uSNEGiPHh0ArODt3TaEeeQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix array bounds error with may_goto
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:13=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wrote:
>
> may_goto uses an additional 8 bytes on the stack, which causes the
> interpreters[] array to go out of bounds when calculating index by
> stack_size.
>
> 1. If a BPF program is rewritten, re-evaluate the stack size. For non-JIT
> cases, reject loading directly.
>
> 2. For non-JIT cases, calculating interpreters[idx] may still cause
> out-of-bounds array access, and just warn about it.
>
> 3. For jit_requested cases, the execution of bpf_func also needs to be
> warned. So Move the definition of function __bpf_prog_ret0_warn out of
> the macro definition CONFIG_BPF_JIT_ALWAYS_ON
>
> Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/0000000000000f823606139faa5d@google.c=
om/
> Fixes: 011832b97b311 ("bpf: Introduce may_goto instruction")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  kernel/bpf/core.c     | 18 ++++++++++++++----
>  kernel/bpf/verifier.c |  7 +++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index da729cbbaeb9..59291261f825 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2269,6 +2269,9 @@ EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
>  EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
>  EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>  };
> +
> +#define MAX_INTERPRETERS_CALLBACK (sizeof(interpreters) / sizeof(*interp=
reters))

There is ARRAY_SIZE macro.

>  #undef PROG_NAME_LIST
>  #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
>  static __maybe_unused
> @@ -2290,17 +2293,18 @@ void bpf_patch_call_args(struct bpf_insn *insn, u=
32 stack_depth)
>         insn->code =3D BPF_JMP | BPF_CALL_ARGS;
>  }
>  #endif
> -#else
> +#endif
> +
>  static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>                                          const struct bpf_insn *insn)
>  {
>         /* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
> -        * is not working properly, so warn about it!
> +        * is not working properly, or interpreter is being used when
> +        * prog->jit_requested is not 0, so warn about it!
>          */
>         WARN_ON_ONCE(1);
>         return 0;
>  }
> -#endif
>
>  bool bpf_prog_map_compatible(struct bpf_map *map,
>                              const struct bpf_prog *fp)
> @@ -2380,8 +2384,14 @@ static void bpf_prog_select_func(struct bpf_prog *=
fp)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>         u32 stack_depth =3D max_t(u32, fp->aux->stack_depth, 1);
> +       u32 idx =3D (round_up(stack_depth, 32) / 32) - 1;
>
> -       fp->bpf_func =3D interpreters[(round_up(stack_depth, 32) / 32) - =
1];
> +       if (!fp->jit_requested) {

I don't think above check is necessary.
Why not just
if (WARN_ON_ONCE(idx >=3D ARRAY_SIZE(interpreters)))
  fp->bpf_func =3D __bpf_prog_ret0_warn;
else
  fp->bpf_func =3D interpreters[idx];

> +               WARN_ON_ONCE(idx >=3D MAX_INTERPRETERS_CALLBACK);
> +               fp->bpf_func =3D interpreters[idx];
> +       } else {
> +               fp->bpf_func =3D __bpf_prog_ret0_warn;
> +       }
>  #else
>         fp->bpf_func =3D __bpf_prog_ret0_warn;
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..fcd302904ba0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21882,6 +21882,13 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1)=
 {
>                         subprogs[cur_subprog].stack_depth +=3D stack_dept=
h_extra;
>                         subprogs[cur_subprog].stack_extra =3D stack_depth=
_extra;
> +
> +                       stack_depth =3D subprogs[cur_subprog].stack_depth=
;
> +                       if (stack_depth > MAX_BPF_STACK && !prog->jit_req=
uested) {
> +                               verbose(env, "stack size %d(extra %d) is =
too large\n",
> +                                       stack_depth, stack_depth_extra);
> +                               return -EINVAL;
> +                       }
>                         cur_subprog++;
>                         stack_depth =3D subprogs[cur_subprog].stack_depth=
;
>                         stack_depth_extra =3D 0;
> --
> 2.47.1
>

