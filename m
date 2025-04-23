Return-Path: <linux-kselftest+bounces-31442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC92A997E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32FB1B858A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8728E5EA;
	Wed, 23 Apr 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8jALydd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18704263F54;
	Wed, 23 Apr 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432886; cv=none; b=EYSSCvQgNlXwMKpxMHK1VA7QojPb6eLfQv2JmUFqhRbsEhxk012rLzrkhcoMJUJfr/F6KbilzcjM7+uE5gfAB2JTZGMkEKeFcuydPFPa5juKtSq/RJkr6nVDnMPJIKAk7JGUoUkditNlFnZ3LUGzdcwgaJnHKzjwukforbunXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432886; c=relaxed/simple;
	bh=i7eHnOq25ulKjA9Oo8JHto2f6z++0PCfbt9HfXtPDQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXFlkWjrKDmS59mbSlvc5OVgAT/20qDsXlLRCy4X9uul5deWh+Z+AVHC4BM4cv5cwRvfIw43QDXnxHoBDpA4oATuoFEuTwFfGxmENbq2+YS7C/rLsSatiqNjyDEB72c8KryQ2n4Lnmrh1Ru9ktPebuKCoC37a1ua94AwssM3tKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8jALydd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so1194720b3a.0;
        Wed, 23 Apr 2025 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745432884; x=1746037684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2SR0uKGM0vhthncIe5Y/+JuVpZCEkOEOOgsDc6OPSY=;
        b=m8jALyddW1jhfnYdSjjUYbWQf2cZu5lE2vEgHsKKovatzcuhqygcq05EvmVI1DIBVo
         9ZvD0AzbZM8gTganA1+VibTkwlyrtanRyqRzeJ+QSQ9cS0LQpbAtNeqfOrqXAyXoaJ2D
         AAZ674H0r7ECEbk9tKuxBIlueiQpyVXXJ7tqjw3qmWfRsjEHBVFokHEmBE11VE565IS8
         6OL5tuMa/ZTbwEpC3c/Id745xs7YFRWTFfRH9RGCUyyM0OvWnFLhpCvFvn79bwCNXwWG
         y3Fkcjf4CQCxrZoKJeSH9nMPZjlgsLsxHrxayI+KmIWWMjBy0xRSfHHx2uetJSnLBn/m
         W6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432884; x=1746037684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2SR0uKGM0vhthncIe5Y/+JuVpZCEkOEOOgsDc6OPSY=;
        b=DWILsNyCGf9IkkIO3T9G6KImpwD7dnHrR/LiYr2VThcFMRMenlX+3LxYx33WMT4gZl
         +RxunCFTEnoSFA8C7erSTnkiGRNDYJrwWp0AGF69F79R9KSQj8+uRYKmoFYKT+/kD7qR
         i+DeLTOGt3jOmfHuHaxeIdhQYPEVKuFYeESKLeFUOHsEogg9wF5MGZ3lb0MSsa8qoY+C
         0RAfAu+tnVmY+JCJ0fzRL8eJ0JneRhAVNu0VPCGGf3Ozm1v9aDHFM7HiaGR60OewpLgJ
         je85AOVSDuVLmMraXSwSm7a0I28uZ1oy/M0PhoqS5QGcHjTS2Tq2NPSRdOhsxFEaji85
         AnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkW5l7Cgp7S44Q2WF9BfE6GzM+PFCO6rbEP39Tek20AQefzU7oqKnCJID5/6JNAc6JUGtVuHRY6zy/gCc@vger.kernel.org, AJvYcCVPYMZc2VTq6lCujUR8Uth/4D3Ajln+eIvNfkajgNO7J0IQbcq5YYalZ6sEcxwABTdb/hDidvYJ9lAYfThd520n@vger.kernel.org, AJvYcCVU/MKqLMtVpJT8W4uK8ds2bVBnlGamI6vYdvXOXcIFrj83nB5seVUV6K24M0+DDNF9pLfcmsvg@vger.kernel.org, AJvYcCVxmuvg0k3lZ8uCO9kCW6zFBJqanrfH/MGuaB/o6KY/Wk3xjREdoaVThsOX0IuptWNJSrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBC7jhNPJQJ4A/06UFJjHilVlzzf2CDpwFoYVmiJiKfE5EWsW
	Kx1jGSqLrwHUvhs6kijNvRXd53hNUnY1Qh6BYYgLdZzUpTA0/Ew3HRuHZf1L/YtvW+zuWW+kopS
	26DrO7fgcQmdSpQuGJcGnv0iYY8w=
X-Gm-Gg: ASbGncvjEujjIqs2/6S8pbEFvvIGY/+Im3vKbDjbpg3xg8+DVsipXFpxVfV1rNEYfsg
	eZ1tICsHzt16VUyKxYRX+/NcyF0rwATacJhcOsKTtKK3BcOd6apZ/qO0hLiBQkK4JMwyUaAO/D/
	7Jj/ilEQIuwkE+kLcB6VmUtbQswjPI1oYZvSYPwQ==
X-Google-Smtp-Source: AGHT+IHjIZbdBZmeAwLPdKD6FDavuuiRxmwzDpsEsNPjz/QHrVA/etMXlAiTyFnC/5fOB2UDc4R555MT5LHsZ8I/s0A=
X-Received: by 2002:a05:6a21:6d93:b0:1f3:3864:bbe0 with SMTP id
 adf61e73a8af0-20442da897amr173428637.8.1745432884380; Wed, 23 Apr 2025
 11:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423121329.3163461-1-mannkafai@gmail.com> <20250423121329.3163461-2-mannkafai@gmail.com>
In-Reply-To: <20250423121329.3163461-2-mannkafai@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 11:27:52 -0700
X-Gm-Features: ATxdqUG1OQGWGxprkuBY8mLRZZsqeZGEzZTpl5Cqi_Yfb8QsDm03VOkq41zrZm8
Message-ID: <CAEf4BzYn0xRf6SwKHLbbqsDTueC-r_UxYOAX3+o-jswq7=a8sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Allow access to const void pointer
 arguments in tracing programs
To: KaFai Wan <mannkafai@gmail.com>
Cc: alexei.starovoitov@gmail.com, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, memxor@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:14=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> Adding support to access arguments with const void pointer arguments
> in tracing programs.
>
> Currently we allow tracing programs to access void pointers. If we try to
> access argument which is pointer to const void like 2nd argument in kfree=
,
> verifier will fail to load the program with;
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ("r2 =3D *(u64 *)(r1 + 8); ");
> 0: (79) r2 =3D *(u64 *)(r1 +8)
> func 'kfree' arg1 type UNKNOWN is not a struct
>
> Changing the is_int_ptr to void and generic integer check and renaming
> it to is_void_or_int_ptr.
>
> Cc: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/btf.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16ba36f34dfa..14cdefc15f0e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6383,12 +6383,12 @@ struct btf *bpf_prog_get_target_btf(const struct =
bpf_prog *prog)
>                 return prog->aux->attach_btf;
>  }
>
> -static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
> +static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t=
)
>  {
>         /* skip modifiers */
>         t =3D btf_type_skip_modifiers(btf, t->type, NULL);
>
> -       return btf_type_is_int(t);
> +       return btf_type_is_void(t) || btf_type_is_int(t);
>  }
>
>  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_=
proto,
> @@ -6776,14 +6776,7 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>                 }
>         }
>
> -       if (t->type =3D=3D 0)
> -               /* This is a pointer to void.
> -                * It is the same as scalar from the verifier safety pov.
> -                * No further pointer walking is allowed.

I preserved this comment (with slight rewording to make sense in a
combined check context). Applied to bpf-next, thanks.

> -                */
> -               return true;
> -
> -       if (is_int_ptr(btf, t))
> +       if (is_void_or_int_ptr(btf, t))
>                 return true;
>
>         /* this is a pointer to another type */
> --
> 2.43.0
>

