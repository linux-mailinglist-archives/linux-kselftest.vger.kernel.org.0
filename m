Return-Path: <linux-kselftest+bounces-30879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5CA8A155
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 16:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435151902394
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6C2957C7;
	Tue, 15 Apr 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs2ht0Z1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109932949EB;
	Tue, 15 Apr 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727876; cv=none; b=re+2L6Vjbvk3hn9kZsbN33kPr8udp5PMuq3jAO/IgpjROzZcqUfEtIeBcNBft6xHWe0tMbsPyM+k4Jz7yH/FewMLUOazmY7qARAkr4IwXSdXvi+Qc18qAvMxSEmwVuBR1+EoI1zPG4tP5VXN1ZyuXgLsE3wzP/kn5ooNkqDJf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727876; c=relaxed/simple;
	bh=V/a25hNDB5z+WSFk0T0WLV9zb5V5Bm1HJTIXWRoF3Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJiYoi5CuHMyTbYkaP1tvnQdR16CCww5VvetHT+Lratx1tGYsG9j2RCLIzwmqx/Mi1hL1mFFfnkT0US4GxFu4IQwlgqlDFvNbayN2/p+9TTrGg6D3dj5dH21+azbmGghTNzwQ0O0P+1owp2EG+SX0bTp4IlKCAz1W9fTL0xENj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs2ht0Z1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6febf391132so53012517b3.1;
        Tue, 15 Apr 2025 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744727874; x=1745332674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwIcbrCFSkjJ99K0oqnE440Z8NS7MO6dY71VBSoxwu4=;
        b=gs2ht0Z1D7HKJsnKwjsguX87p00wVQOXeIBr10Tsm8xLfiPrxeFc0cT1ckxP6LhtJo
         vmEYzj08zyQXj/OxsbMQ7h0+OkL5iQJql8XWsiM7SWPHo5M2y9gPy3z6Gy89E2OJYnrw
         sQ8BZR87KSPQDuAzcH2KcUTA9ZBSFQISvOtMZK+FyhFpyijw0QXBoC88zcoMf1M3npOX
         wK6peapQiz5MvMPXSxnUkc2/BYpgTJvKETdoHmTweRHMbTB8LlhdKAED9iZdQPaHtQeT
         g2/dimH8T47MZo2266BbaejYupjRf/UEcV4nPWTENCK8c4dDNEemNsGlda5pWEK879DE
         u+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727874; x=1745332674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwIcbrCFSkjJ99K0oqnE440Z8NS7MO6dY71VBSoxwu4=;
        b=KQWGS1rJPs5epi+z9zCYm0+Q+V59qr4IvWEBsoXKphgm5zyUX5eQfhankMnOHmomgT
         7mF7JGff37aqiYhkOgPjB0oLEojSHj+A9spSrboSaPUWcy5lKR6bFnNWUoBS7phQ++Z9
         R/zxwdAztyU31u82+0w6JF53SP0Q/OYd6fJHIgyEprqzpu3e0RKpKleqs6DeDoUweHaM
         krlT42xTyRn3f3li+Iz9KpxY04dkAWZ/N7qYtIzl3sNFBMZK6b2X0EKKlc6FaZw+8/M8
         loS1DZQSqeHmlenR6y4DkjMQFdhYF210QrcCuQuDmJyFDZZBD3NdMFwY/GNEjSo9Camq
         m+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNHRuhpGQ57friAEfCwbpLUAkG226iK+hf26/4QTX1BBkYxVi0dxWKlqjixFgiuks/iYajeCoMKqpZFIP2@vger.kernel.org, AJvYcCVDjydCm41IMlLScYB2/gqJHtfmZeMSDCg8462GSVpMJ/1rvUf80P8ghtA1X5liSI/dP6Y7BqXCRo9nor7QAde2@vger.kernel.org, AJvYcCWEYbtBq5/ltax2vkIgsDaqRASPicfKQoPo8+zKJ9iiSXsn3qnZi7U4VGH0aGjo5MoQBWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxnK7NxXW9hUkg47sRNa1hWXXeiJMtPBQ1xmgU8IF5iBeGKHC
	M2MnjZlMGEZP70pEWzSboy3mSuaXRp3+K4lpMyBllsTcT4qjgPSUfx54lM8NcbQnlbPlyKuYhN6
	tONIKhuwSakO7Dy45MzrVaaX84TI=
X-Gm-Gg: ASbGncvGQCGnNinLAXO9sA8Ztvvf6Xqw+v1tR+/hHNbsLN18opGmldSDrsSsBhFtK6Z
	cDm0B2clpTFrMPQjUm1YmrE4M8XKNZ7H5bLeenrFp1kfqhDbTE6aCyMOnnpCJpZ6E9at+5GXlL7
	572eYcwUEUiCvmdNFnvzsjsg==
X-Google-Smtp-Source: AGHT+IHUMxvu/aOeLKk2k5l1s/fZpbZMV26GOgsy8sNTFTBpovDHd4DLx4JmGn+hEKfCP1n08IvUdhwvV3xwn980+GM=
X-Received: by 2002:a05:690c:38b:b0:6ff:1fac:c502 with SMTP id
 00721157ae682-705599819femr253641937b3.6.1744727873793; Tue, 15 Apr 2025
 07:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412170626.3638516-1-kafai.wan@hotmail.com>
 <20250412170626.3638516-2-kafai.wan@hotmail.com> <Z_zk2ZaG5fRRFQio@krava>
In-Reply-To: <Z_zk2ZaG5fRRFQio@krava>
From: Kafai Wan <mannkafai@gmail.com>
Date: Tue, 15 Apr 2025 22:37:42 +0800
X-Gm-Features: ATxdqUFfDAA6h_yahdP12xKT_OlDfjXjxWcEGnJt25PijmtECR6HpfsyjMNRKAw
Message-ID: <CALqUS-76D5ywRC6EUnd2O=L5VLuQBaOJOgnJeOLZxJpArqomtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow access to const void pointer
 arguments in tracing programs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, mykolal@fb.com, shuah@kernel.org, 
	memxor@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kafai.wan@hotmail.com, leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 6:35=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Apr 13, 2025 at 01:06:25AM +0800, KaFai Wan wrote:
> > Adding support to access arguments with const void pointer arguments
> > in tracing programs.
> >
> > Currently we allow tracing programs to access void pointers. If we try =
to
> > access argument which is pointer to const void like 2nd argument in kfr=
ee,
> > verifier will fail to load the program with;
> >
> > 0: R1=3Dctx() R10=3Dfp0
> > ; asm volatile ("r2 =3D *(u64 *)(r1 + 8); ");
> > 0: (79) r2 =3D *(u64 *)(r1 +8)
> > func 'kfree' arg1 type UNKNOWN is not a struct
> >
> > Adding is_void_ptr to generic void  pointer check.
> >
> > Cc: Leon Hwang <leon.hwang@linux.dev>
> > Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
> > ---
> >  kernel/bpf/btf.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 16ba36f34dfa..e11d3afd0562 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6383,6 +6383,14 @@ struct btf *bpf_prog_get_target_btf(const struct=
 bpf_prog *prog)
> >               return prog->aux->attach_btf;
> >  }
> >
> > +static bool is_void_ptr(struct btf *btf, const struct btf_type *t)
> > +{
> > +     /* skip modifiers */
> > +     t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > +
> > +     return t->type =3D=3D 0;
>
> I think you can use btf_type_is_void in here
>

Yes, I will use btf_type_is_void.

> > +}
> > +
> >  static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
> >  {
> >       /* skip modifiers */
> > @@ -6776,7 +6784,7 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >               }
> >       }
> >
> > -     if (t->type =3D=3D 0)
> > +     if (is_void_ptr(btf, t))
>
> lgtm,
>
> nit, the is_void_ptr name suggest there's also ptr check in the helper fu=
nction,
> which is not the case. I understand it follows is_int_ptr name, but perha=
ps we
> could rename both helpers to is_void and is_int ... feel free to ignore ;=
-)

you are right, I will rename it. but I'm not sure if it's possible to merge
these two functions into one like is_void_or_int, they both skip modifiers.

>
> jirka
>
>
> >               /* This is a pointer to void.
> >                * It is the same as scalar from the verifier safety pov.
> >                * No further pointer walking is allowed.
> > --
> > 2.43.0
> >

thanks,
kafai

