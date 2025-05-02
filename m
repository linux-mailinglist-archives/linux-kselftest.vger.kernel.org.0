Return-Path: <linux-kselftest+bounces-32137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4690AA67A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 02:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F715A161F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85226645;
	Fri,  2 May 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMkuBXSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF0182;
	Fri,  2 May 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144232; cv=none; b=fUt3HoVvcep0pPPlWi7IF4GACv9zQ+PqEtaSiwoP4UZunk11FMc2RTeHU/+joBbU1Rrkg4DoZp5Ggi4RlxhpdBRgq9xxMTngKwsf/cme76lZ2W0OKwEdpUcarTFeVhfKzI00sg9JmNvT/u7NCxgozqwGDZ+b7rmJmj5CMxm4teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144232; c=relaxed/simple;
	bh=/t8j0f0BABthS00kehdFg8AaafAN7EcCIlYHLPI/pSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8QkpH7QhHz35LmoduBdrVzC9ZZBt3y5bsv6c1FyDTY5Uc1D80EMNfkgdFnYGVdqbUxgcskD+RAn+++3Z/jpnZLC4fXfBIJR8pHLqRvommKx76peSGOstQP5jQsD0W4nfDXrwcZRZsyIgb58WQC1Tlw3YHUE/hLRSJkkTQW7yZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMkuBXSt; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5f4d6d6aaabso2248782a12.2;
        Thu, 01 May 2025 17:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746144229; x=1746749029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAdrSpHVasOUL/GpRMRQtUO4sMi+w7FhQalzllF+FBE=;
        b=UMkuBXStFgEbcig2oayvAKznnU5Au5NZ6mfhVOFMp3ddhndRH1XcEocQ2TExiO2uQA
         v5LVRzqI7PuzJ3G0/oHlYH8XjKhzbLZdrP+Rwfh0AnvSJbyTou4U3M6G/7V1BBeIty8m
         Eek3OFxkIhS8WfFvv95lAnhv5BLzjO88EJupZOMSDatu5VSDpDOWSZDJPksMYpUppk00
         MxwTxwe64+nlwq2pCroAPctvFGFmwOA1kj1sDqyJLAj01e5H8cEFMHjcGzyfXHlxFHl/
         lLMtT241dfftWlnfiIzWdwflfs/VghGYfGtasQAjpbCY7GslO4X/h5EiHbxZEZCMb8gG
         tH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746144229; x=1746749029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAdrSpHVasOUL/GpRMRQtUO4sMi+w7FhQalzllF+FBE=;
        b=Iwar4+sdwfToK877dVkmEH5lLd5BL6aPlDVyKLhZhJ6QE+9hdstgcXfvnhmHX9M3Db
         g8CXPJEAN1f+fkTl9vC72Stjj/ppSh2zO8TGe8C2FcAv4dkR3dY+xAYD4nWv2tqbGxI4
         02BGlzidS2QFvz0AprLLUPZKTCjGSi59X+bygtq7eFvFvx5a2xgkTFdOO2bc9uU+fxut
         AulLDYLqoRxdzAIzhSEPPWUrMoivwLhHHQcVX55tScDOZL/jClOBxIG+RgPsMVtbCYmZ
         AC0SD88Hq3FJ8/KAVC8yVsMjuDBn9Sa1S9z4xrv3t1NIafyYBnQABcozBNYpr9gNqkw/
         71hg==
X-Forwarded-Encrypted: i=1; AJvYcCUEJvKnmyuIgBRzYwabkQQqNj2dtwKKVrOdNS1Z3dOdyIZpA0/fd03QGoA0B+0MYXFm2zBGrowbZrXkWlJEmgPU@vger.kernel.org, AJvYcCVOe4FpqCsW6xH67FmycxoloT5yFjqXPEwfsEHezrTaZR2sUX5kOEaV6RAjXYGD4ERuMyOiuugOP+iWgC5V@vger.kernel.org, AJvYcCWDUYUzdUUDxtJyOhg1EVUAzgQZ1FNlRkwSWPbgPfnAjYxqeAE79KFKmS8biDN9N/QA++w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6y6TqhEOHbjbkpDwutAuwjKn06UTn6RKMfK8TLuxg9YFsCTEz
	wM+d8W6jt90+ujVhrTcFaJuAmeCKq5hE5cpoY5n0iIJiizru1o2EdKIhleI9iWoUAxpHHhZjWHr
	mi2MgZMj94/uESUd7NcyYaGtX6NU=
X-Gm-Gg: ASbGnctJuhXrr6HEJyKhEsRd7guYd5ujZ6qL3FASn3nlZlgJPKOI+2gFC+zh+mww92p
	JFxvwGdABz2w2wQ0UFoQHypk6EQjL7N9Nh222NNxa3Hc3moEaSWwyvkLdEdaLlcdYD8g/EIhgHw
	uPYZtDky+lrGLEYKYfseRvxQhA9rmC5MXczcApYniO8dE=
X-Google-Smtp-Source: AGHT+IEZmaXKlPg2SX6D1Gg4Ct+dglKTu1NfoiUsMrHJ97ikPtGkPZ2woUqGvcz2mbdKYLABZveqW+MvsUkMW/lyo9o=
X-Received: by 2002:a05:6402:51d3:b0:5ec:fb3d:f51f with SMTP id
 4fb4d7f45d1cf-5fa78006329mr578324a12.10.1746144228590; Thu, 01 May 2025
 17:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-11-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-11-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 02:03:12 +0200
X-Gm-Features: ATxdqUHVm1hIS_v_8Z_z0qlxAyMnE3MrBINfcmLce0vU9ymsmOtLw6c47Fn4EGE
Message-ID: <CAP01T76HZ+s5h+_REqRFkRjjoKwnZZn9YswpSVinGicah1pGJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/11] bpf: Allow nospec-protected var-offset
 stack access
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen <mrpre@163.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 10:17, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> Insert a nospec before the access to prevent it from ever using an index
> that is subject to speculative scalar-confusion.
>
> The access itself can either happen directly in the BPF program (reads
> only, check_stack_read_var_off()) or in a helper (read/write,
> check_helper_mem_access()).
>
> This relies on the fact that the speculative scalar confusion that leads
> to the variable-stack access going OOBs must stem from a prior
> speculative store or branch bypass. Adding a nospec before the
> variable-stack access will force all previously bypassed stores/branches
> to complete and cause the stack access to only ever go to the stack slot
> that is accessed architecturally.
>
> Alternatively, the variable-offset stack access might be a write that
> can itself be subject to speculative store bypass (this can happen in
> theory even if this code adds a nospec /before/ the variable-offset
> write). Only indirect writes by helpers might be affected here (e.g.,
> those taking ARG_PTR_TO_MAP_VALUE). (Because check_stack_write_var_off()
> does not use check_stack_range_initialized(), in-program variable-offset
> writes are not affected.) If the in-helper write can be subject to
> Spectre v4 and the helper writes/overwrites pointers on the BPF stack,
> they are already a problem for fixed-offset stack accesses and should be
> subject to Spectre v4 sanitization.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---
>  kernel/bpf/verifier.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db26b477dd45..1fbafea3ed69 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7894,6 +7894,11 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
>         }
>  }
>
> +static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
> +{
> +       return &env->insn_aux_data[env->insn_idx];
> +}
> +
>  /* When register 'regno' is used to read the stack (either directly or through
>   * a helper function) make sure that it's within stack boundary and, depending
>   * on the access type and privileges, that all elements of the stack are
> @@ -7933,18 +7938,18 @@ static int check_stack_range_initialized(
>         if (tnum_is_const(reg->var_off)) {
>                 min_off = max_off = reg->var_off.value + off;
>         } else {
> -               /* Variable offset is prohibited for unprivileged mode for
> +               /* Variable offset requires a nospec for unprivileged mode for
>                  * simplicity since it requires corresponding support in
>                  * Spectre masking for stack ALU.
>                  * See also retrieve_ptr_limit().
>                  */
>                 if (!env->bypass_spec_v1) {
> -                       char tn_buf[48];
> -
> -                       tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -                       verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
> -                               regno, tn_buf);
> -                       return -EACCES;
> +                       /* Allow the access, but prevent it from using a
> +                        * speculative offset using a nospec before the
> +                        * dereference op.
> +                        */
> +                       cur_aux(env)->nospec = true;
> +                       WARN_ON_ONCE(cur_aux(env)->alu_state);
>                 }
>                 /* Only initialized buffer on stack is allowed to be accessed
>                  * with variable offset. With uninitialized buffer it's hard to
> @@ -11172,11 +11177,6 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
>         return -ENOTSUPP;
>  }

Hmm, while reading related code, I noticed that sanitize_check_bounds
returns 0 in case the type is not map_value or stack.
It seems like it should be returning an error, cannot check right now
but I'm pretty sure these are not the two pointer types unprivileged
programs can access?
So smells like a bug?

>
> -static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
> -{
> -       return &env->insn_aux_data[env->insn_idx];
> -}
> -
>  static bool loop_flag_is_zero(struct bpf_verifier_env *env)
>  {
>         struct bpf_reg_state *regs = cur_regs(env);
> --
> 2.49.0
>
>

