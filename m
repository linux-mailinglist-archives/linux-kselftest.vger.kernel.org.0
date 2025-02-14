Return-Path: <linux-kselftest+bounces-26600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930BA35342
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A43ABE48
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4195227;
	Fri, 14 Feb 2025 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY96gbqG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24F3595C;
	Fri, 14 Feb 2025 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494287; cv=none; b=R4yLvpHtqvRXBNwzVyguJGmgrESmzX4ywR5vPS2r9O+8x8OGhmKrW/G4t+WqWvx9R/5j8e3m4Ex46+mOEm7B20dZjzZYHonOS7wIj9nuqgww9apELHhoeF/A3DD1PhL8cLkAQuBRYG83PJlmdJJOtYC0lP0gBjsTn3/s1ooGTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494287; c=relaxed/simple;
	bh=YEWQRyu2N5R3zULdTs4lce/iNreDUskXEtuOzqXScNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey0aZBqNDMYotW+8tjQNMVfLwlXEC3tdaMVQIoXBT6SNhy+5KHf3LNLmBQK+Cmkg+xYFkeC1DeCqkjwQB+gZMe3BuBmpOeDqpv8snSGJHeeCFu/SlEuU0Jabidow9wmj71408Vr1x2fdLnBH249AXaUQrVRIOIYJm8cIZesKocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY96gbqG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439585a067eso15546865e9.3;
        Thu, 13 Feb 2025 16:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494283; x=1740099083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNe7i6RRAcgS6FUQIn8M8mvtZTRYsnLzTdWOgbi9Qek=;
        b=cY96gbqGuVYwLaSVvIZNbHHCXYoOROOE8ycBgqQX5olwEmx3jz0XZa9AN8TiAzYEb0
         TXooT9ylWTjhKahhi4TGyGLOHwslqjg2iyvQIorjdJr6AtRceDC5KKo+oBZ55QuOuR3l
         z+3K3hgXoS2j9fb1V5HcFXofh+oVKyIVv0CAWmKu5p4GlYznBzU0a/kzK8WnkzlQUBa+
         TdSh0dEMIvWQvvzJyjvPzEzuyLlxbKr5+UF/TphamqIk10FNokzyPlHfi9rcifvl8Dev
         Ev1wuX+cHLVvpQF68KUV8sfzHdr3i73Y4wVyMeThuUiPnArI8I4O8KZgU8NwNpPzqJaS
         3fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494283; x=1740099083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNe7i6RRAcgS6FUQIn8M8mvtZTRYsnLzTdWOgbi9Qek=;
        b=kcSrRqkFufYYREgAi5crrEn3yoWc7YS3A+Gr57hN703T/9f2714ycZgGxBDHBinwW+
         3bHUyd3Ka0jBSKO7f8ysEDx0RxGoWVdqagnLbyepVX81/UlcLSdzNEAn0sq1352dyjeu
         pOe87ftVQVvPFvLyz6tsSWbJjxGrV6IgARZJGHZjlIzN3jj/LQuIFyUOC+jiVGkWoQ0U
         89fT4rF7g37XmNeG9oy0cja6NUdjtFHLAKw9DFjOavKWXN56AXHVaqHGCs5hy+yBFfpG
         2PBSbSZolOIU3gwgJQ31Roz0R56w9qRNQI4hkV6auM6ErQh8W7doOWWVmvlZ9oxn2uAK
         4MHg==
X-Forwarded-Encrypted: i=1; AJvYcCVJyWHRUL/VMCZDDbvMcr+7DdmAjXur6ESic3b0/U+MTVI5IhPHLH0je662QLaI/MAItU3JPoOJXwMVHjqZ6CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8wFWesXM3zaJrZAL9Ch0sEP6Jtd4fs1qQEbW9BKhwrproQHY
	WzvlhZggDJrBzTtLgGE1IkYDHP8tu0UKvQWABg3mQpPUs+aEWkQzXeVbxri2oVf3enTkrQHHSV4
	1dLs/t9NrHVLLmIWOls4FLdksYdc=
X-Gm-Gg: ASbGncseB+ImPmciPLW/581olukUUqfDs7YlLXEB3UxBpi4q0w2GWWD6nJt4vJckK3W
	ULP1SDbiAlKx1Y/tOgIu6ysytP4qCc6UflnO4JbQ8ajfUUYCHzsx/i+OuQPeYCC5PT4EOWwiaye
	u0AokEGha8nPL/RFDa7YIg4le2MYz4
X-Google-Smtp-Source: AGHT+IGUw+pTsjBbMAlHZ+jaW8T/SetCvsWpZGJJCW4qUdfZmiMeYenLvH/2w3ZOI1JsiOKsnXYC6ZG0atSsxzafMdI=
X-Received: by 2002:a5d:5289:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38dea268ac0mr8385076f8f.21.1739494283326; Thu, 13 Feb 2025
 16:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213131214.164982-1-mrpre@163.com> <20250213131214.164982-2-mrpre@163.com>
 <CAADnVQ++goV=Yi=dhXNa5F-h0o7uSNEGiPHh0ArODt3TaEeeQg@mail.gmail.com> <2ec2qjrwsdvdyr2wdo3gakv4hsikmvrhc47k3kii7nzj2e5tfm@zeiedp7wy3kj>
In-Reply-To: <2ec2qjrwsdvdyr2wdo3gakv4hsikmvrhc47k3kii7nzj2e5tfm@zeiedp7wy3kj>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 16:51:12 -0800
X-Gm-Features: AWEUYZmpuvUdCicXsdvRYEUGHzbseHF8YmA-TfwT26zSbnqkCB8FTFm6hH07ACo
Message-ID: <CAADnVQJK_d_pOVmkr6kdo5AYZBnXrH948MFj3xC-1=omf+HOyw@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 9:03=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wrote:
>
> On Thu, Feb 13, 2025 at 08:02:55AM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 13, 2025 at 5:13=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wr=
ote:
> > >
> > > may_goto uses an additional 8 bytes on the stack, which causes the
> > > interpreters[] array to go out of bounds when calculating index by
> > > stack_size.
> > >
> > > 1. If a BPF program is rewritten, re-evaluate the stack size. For non=
-JIT
> > > cases, reject loading directly.
> > >
> > > 2. For non-JIT cases, calculating interpreters[idx] may still cause
> > > out-of-bounds array access, and just warn about it.
> > >
> > > 3. For jit_requested cases, the execution of bpf_func also needs to b=
e
> > > warned. So Move the definition of function __bpf_prog_ret0_warn out o=
f
> > > the macro definition CONFIG_BPF_JIT_ALWAYS_ON
> > >
> [...]
> > > ---
> > >  EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
> > >  EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
> > >  };
> > > +
> > > +#define MAX_INTERPRETERS_CALLBACK (sizeof(interpreters) / sizeof(*in=
terpreters))
> >
> > There is ARRAY_SIZE macro.
> Thanks, I will use it.
> >
> > >  #undef PROG_NAME_LIST
> > >  #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
> > >  static __maybe_unused
> > > @@ -2290,17 +2293,18 @@ void bpf_patch_call_args(struct bpf_insn *ins=
n, u32 stack_depth)
> > >         insn->code =3D BPF_JMP | BPF_CALL_ARGS;
> > >  }
> > >  #endif
> > > -#else
> > > +#endif
> > > +
> > >  static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> > >                                          const struct bpf_insn *insn)
> > >  {
> > >         /* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
> > > -        * is not working properly, so warn about it!
> > > +        * is not working properly, or interpreter is being used when
> > > +        * prog->jit_requested is not 0, so warn about it!
> > >          */
> > >         WARN_ON_ONCE(1);
> > >         return 0;
> > >  }
> > > -#endif
> > >
> > >  bool bpf_prog_map_compatible(struct bpf_map *map,
> > >                              const struct bpf_prog *fp)
> > > @@ -2380,8 +2384,14 @@ static void bpf_prog_select_func(struct bpf_pr=
og *fp)
> > >  {
> > >  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> > >         u32 stack_depth =3D max_t(u32, fp->aux->stack_depth, 1);
> > > +       u32 idx =3D (round_up(stack_depth, 32) / 32) - 1;
> > >
> > > -       fp->bpf_func =3D interpreters[(round_up(stack_depth, 32) / 32=
) - 1];
> > > +       if (!fp->jit_requested) {
> >
> > I don't think above check is necessary.
> > Why not just
> > if (WARN_ON_ONCE(idx >=3D ARRAY_SIZE(interpreters)))
> >   fp->bpf_func =3D __bpf_prog_ret0_warn;
> > else
> >   fp->bpf_func =3D interpreters[idx];
> >
>
> When jit_requested is set 1, the stack_depth can still go above 512,
> and we'd end up executing this function, where the index calculation woul=
d
> overflow, triggering an array out-of-bounds warning from USCAN or WAR().

Ok, then do:
if (!fp->jit_requested && WARN_ON_ONCE(idx >=3D ARRAY_SIZE(interpreters)))

> > > +               WARN_ON_ONCE(idx >=3D MAX_INTERPRETERS_CALLBACK);
> > > +               fp->bpf_func =3D interpreters[idx];

since warning and anyway proceeding to access the array out of bounds
is just wrong.

