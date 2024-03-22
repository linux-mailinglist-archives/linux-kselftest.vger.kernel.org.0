Return-Path: <linux-kselftest+bounces-6503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B448870E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051F1283003
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25B5A4EF;
	Fri, 22 Mar 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLpe1wis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307E4411;
	Fri, 22 Mar 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125087; cv=none; b=Lvo3R1r4GwW3/Ds+A2L0W/KR8iD3jYoeIONberTuJWVfZilzBGHA6ai86rR15e5BCcrdyBfuOUPv0Eg4F1xvNcCe49MUmliQ4r6V5PrjhbcbZTzNJ7kWAdmjeOFdvWJKfwpDyyEoF0gSHpfLGebcSx5v7RNY9xTtgq13R8rszxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125087; c=relaxed/simple;
	bh=jv4xl30OffQdBcNiHQX8Jw9miue7Rq0L2m7x+7lmBos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSih7O4VXt9rs3eLPTeARkdfOe7n+GNJvU1Jzbp6I9dVLqQMxZ5IcdofZAaGLWOO0XyHDO34qQKwyopYn/P/GNc1B47jj+vsxGGK6MKvPkfM4X52ThsUiK6xRz4KfQ+bcdlGCTs27/CAMMWm1iijaV7NmKKxQJC/fKS1zdTFnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLpe1wis; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3c36dcb305cso1058020b6e.0;
        Fri, 22 Mar 2024 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125085; x=1711729885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=31Xzl+gdQnZUFvRLDH3yOLlBVWmU9n4CWu1bwRmZ1EY=;
        b=jLpe1wisjOyiSRMK+9OA7/fntUNLoD0yCRmo+LZYjEqkBS3XpOYnGKAtRF2hu2DsL3
         MAu+ZQ/mlAvRgP99VJeASQTC4NWim4bA3t15gnl6guaU3ZFSSLvCyOQBl9rP2mpmElvZ
         eR5iEgatEedbrBEB88vPA3xjjF1tGo4T+I8WN/7kFuDNZHByYrL7wW+nmP04jfGE4fqV
         t/NBsVJgxB4dZug1zzP3BHZ9rnynRhO8KfF1712b9yhKHOi8CCchiGjYgviJUsCiZ8YA
         sophhBFQ9gLzrl5F3uozZ5I+blvWGUhtnorHQS4UjpUA6ufBQrsVNmyRBEKCbrvKSdzq
         gO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125085; x=1711729885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31Xzl+gdQnZUFvRLDH3yOLlBVWmU9n4CWu1bwRmZ1EY=;
        b=ODn5xLfDDo+4Ho74xsnrs/RTPUtmKQh0vFQMPi968ZLvHtAo5BCQtieVOTF37WDLzw
         uxAVZAotdq5d1qYPB7fDjZHb0r62MOGZB4rltNl1q7gDg0RV3jVoFuglp6Bx7fNi/6l5
         i0FCxCkZAc7PxWVMnTC+OeDE+46UUm/OieC6oyUvfV9ddvQaJB8bVR7kcihNcuCeN+rj
         CzTyYHcVjcExi+p0Ed6RI2wadI8ZpK28Bmh1GOP9mfVQH7T8wFOZPg523HH6Ma160XLa
         xzwXihQSPYFIZaR1BBv7usRTXTdl25OTl8dMbr1pP6DjkSh51QHbRlbSxF463PXP0Tf9
         D/8g==
X-Forwarded-Encrypted: i=1; AJvYcCUS6Ls3QwyjBIvANu2up1BoW9QLfO6wZ8RqwNFnkL61kepDxxjd2VJynAH/oPGpU+k3HNw76/9JoYIV/FpMMroBj5EfYx30ML3LpT0HfXSfzuXFhtWX4dvB919QrHSt63fwJxWMQ7Rk47NNjVPjQN1IjCzKt1804zLm52nGOLQxHsBP
X-Gm-Message-State: AOJu0YyqoqqhvREnw0gyE0UC3ChPSjaKcu3Tir8UMF7ii4EiVEsTHvMY
	A2LYgMFa/ZJ2L0cOceQDABrtWCZdbCO56GU3BKiXjF4fbbJEZb4T+8Rldyy1PzaTbaK7cCSDWvK
	I0lM/F3VZFe/Jm2jbp9UOqWRhQkY=
X-Google-Smtp-Source: AGHT+IHE3n0KTkYfD8Yj8NNJsSoEmcC2B+raJBYpEdqfWFILSH7LndOJX5ZQH98sJ9VDaqaGMoFzmRcrK7N+VhyrjD8=
X-Received: by 2002:a05:6808:bce:b0:3c3:85f9:550a with SMTP id
 o14-20020a0568080bce00b003c385f9550amr1087400oik.17.1711125084644; Fri, 22
 Mar 2024 09:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org> <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org>
In-Reply-To: <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Mar 2024 17:30:46 +0100
Message-ID: <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 15:57, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> We need to extend the bpf_timer API, but the way forward relies on kfuncs.
> So make bpf_timer known for kfuncs from the verifier PoV
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> changes in v5:
> - also check for the reg offset
>
> changes in v4:
> - enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE
>
> new in v3 (split from v2 02/10)
> ---
>  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 63749ad5ac6b..24a604e26ec7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10826,6 +10826,7 @@ enum {
>         KF_ARG_LIST_NODE_ID,
>         KF_ARG_RB_ROOT_ID,
>         KF_ARG_RB_NODE_ID,
> +       KF_ARG_TIMER_ID,
>  };
>
>  BTF_ID_LIST(kf_arg_btf_ids)
> @@ -10834,6 +10835,7 @@ BTF_ID(struct, bpf_list_head)
>  BTF_ID(struct, bpf_list_node)
>  BTF_ID(struct, bpf_rb_root)
>  BTF_ID(struct, bpf_rb_node)
> +BTF_ID(struct, bpf_timer_kern)
>
>  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
>                                     const struct btf_param *arg, int type)
> @@ -10877,6 +10879,12 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
>         return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
>  }
>
> +static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf_param *arg)
> +{
> +       bool ret = __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID);
> +       return ret;
> +}
> +
>  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
>                                   const struct btf_param *arg)
>  {
> @@ -10946,6 +10954,7 @@ enum kfunc_ptr_arg_type {
>         KF_ARG_PTR_TO_NULL,
>         KF_ARG_PTR_TO_CONST_STR,
>         KF_ARG_PTR_TO_MAP,
> +       KF_ARG_PTR_TO_TIMER,
>  };
>
>  enum special_kfunc_type {
> @@ -11102,6 +11111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>         if (is_kfunc_arg_map(meta->btf, &args[argno]))
>                 return KF_ARG_PTR_TO_MAP;
>
> +       if (is_kfunc_arg_timer(meta->btf, &args[argno]))
> +               return KF_ARG_PTR_TO_TIMER;
> +
>         if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
>                 if (!btf_type_is_struct(ref_t)) {
>                         verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> @@ -11735,6 +11747,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>                 case KF_ARG_PTR_TO_CALLBACK:
>                 case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
>                 case KF_ARG_PTR_TO_CONST_STR:
> +               case KF_ARG_PTR_TO_TIMER:
>                         /* Trusted by default */
>                         break;
>                 default:
> @@ -12021,6 +12034,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>                         if (ret)
>                                 return ret;
>                         break;
> +               case KF_ARG_PTR_TO_TIMER:
> +                       if (reg->type != PTR_TO_MAP_VALUE) {
> +                               verbose(env, "arg#%d doesn't point to a map value\n", i);
> +                               return -EINVAL;
> +                       }
> +                       if (reg->off) {
> +                               verbose(env, "arg#%d offset can not be greater than 0\n", i);
> +                               return -EINVAL;
> +                       }

This won't be correct. You don't really check whether the timer exists
at reg->off (and if you did, this would still restrict it to 0 offset,
and not check the variable offset which would be non-zero). What I
would suggest is calling process_timer_func (see how dynptr calls the
same underlying process_dynptr_func to enforce type invariants). This
would allow sharing the same checks and avoid bugs from creeping in.
It does all checks wrt constant/variable offset and looking up the
timer field offset and matching it against the one in the pointer.

> +                       break;
>                 }
>         }
>
>
> --
> 2.44.0
>
>

