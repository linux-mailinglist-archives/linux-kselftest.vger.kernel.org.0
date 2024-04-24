Return-Path: <linux-kselftest+bounces-8788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2C8B0F7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9221C21C2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70587161308;
	Wed, 24 Apr 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdsA27fi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CB15EFAC;
	Wed, 24 Apr 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975266; cv=none; b=KMlG9ii1UifuTR8C1c4wpGs1ENLzZYV6MBtnir6YjIEDpRxEzO4Mpay+SdQMUht06GO+FgtUE0YZoaOMWnLeH/hf21eqUFmALVhTwctAFz1XNzvesY6bWFTz/+PXMkkzTjjSul1unph90cGM2MmJOCJn7xitmJ7wL63V649N0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975266; c=relaxed/simple;
	bh=9MncDPfJ4lea78B0+wr4TTGFzObzGH+po/TheICAUZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tcm2qLV7KVa7UXFI0wECo+s9vRoOenjGGk9qBSpE6WXDD28pTLVugrY+X+XPD+jxbEOahtX9F1PDTu3bozkRiCmvCL9ERnDkMIuA5CeK9iiAY3/K2t173hF8ZR86/U1nVgGnHJtv42IRJxtcJF+QVf1tg571Dmt3UkpCcy4avws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdsA27fi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34a3e0b31e6so5198332f8f.1;
        Wed, 24 Apr 2024 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975263; x=1714580063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT4y4wU6eakh2letdluSamYpLPEff2M/cXKmxgLn8p0=;
        b=MdsA27fi/zHwOfl6pDfBmkYmCr1qrbFLKzZZ3MhIevUlZY4hCM1MLKZTVSC8YdEIt4
         y7D1ReYo5MbuTBgntTFVX1HH2R4WjYRU6jX1Ou5FbshTpoXo193SGFa0iZ1xlL9GOPfj
         9qlCkutcgGEWRq/TWbQckIS1CNlT6GieOnduGQibu3LrmbDKal2fAtsKjS49tmOVIEcW
         OVdKSOqEmwcmXi7j87+euRQnlLbGp6/4EZAp3IXRf4H4AyUeqe5unfkESx9eiFUnXcTe
         AOxoEnp568SaxgkjKfSqQ93RctAPG9y4l8gvityB1ExAI5dBbx9he3sPF72mSPzoNYKi
         hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975263; x=1714580063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT4y4wU6eakh2letdluSamYpLPEff2M/cXKmxgLn8p0=;
        b=gfMbaP1qsBlJKPXn1SWACo9Wo5g5esnMenEFAGVe7uSICyiBWJrfw33EQS+gvh3/y7
         mKJgyYZlP7KHDltLtU8IewncHXO8qgj0y9hPNmcA8eURL3dRaDXWuPkQJijz4039K/mo
         pr5XXkCr845RPuRzeKw0WUhoaBeo5iNVqDpBeVEy15B74UApUgpv5DFvVERjZDyii5zs
         3BJPVI+C0kewu4hLVgjsSh+Vtwfw8lf2DmPO6EowVuvM8wNvATNzFUfzibQeI9xF8CgJ
         su4w9L5tiGGr91Ps/a/QP2wDhPa1Iwh4lmzxK86fM4sAc14nK/q6NrsjTCijNRiSkJ77
         mz7A==
X-Forwarded-Encrypted: i=1; AJvYcCWg+oIrV4hdV+I16zxJMJiDwhclUq7JGe+f64WudEKYsr6CUHIR0G/+tm//wB5J0hQuxG2YrltEgW7RN0oezZ9coh2jVZQWZQfOJNqO2jMLb/9A4jw9F4Xq8GE632sRrtnRiAQaT/X5DBJ3fRZdeh7iWWxXUlaiGc3DQV6l40YQWLZR
X-Gm-Message-State: AOJu0YyYwuIXt7P9iOc3Pk9PQcjV1mf6h7neVLjLo7kYlW5/Ml2LTJeX
	fubAI+C5kuSBjOhl7v/cxozA8kKW/81jPWCOsonKQl+ZKZIHxYhdJ1tLL7KBOI1TRhBroxyikvB
	vezr0Lehf2f3Xo0BKnMvcbvnU67qnaRpr
X-Google-Smtp-Source: AGHT+IFehvEMSN3L9+fb8yyyTr1gCkMM9L5dO+352gMAp4qDg0koqOQLNMQ1nlLdzC4mWiYvJPMsU9PGLIgjnir76Ks=
X-Received: by 2002:a5d:54c2:0:b0:34b:ce32:aa8 with SMTP id
 x2-20020a5d54c2000000b0034bce320aa8mr1288352wrv.7.1713975262790; Wed, 24 Apr
 2024 09:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-11-6c986a5a741f@kernel.org>
 <CAADnVQJ9Qw6Lr644xRTU-n16UkBCyHoTAQs7QqGiniOdsOVAJg@mail.gmail.com> <CAADnVQKfzu1F=xZxyYhiocAn1iM=8f13Ca-2Jfht2dXsXuGu9A@mail.gmail.com>
In-Reply-To: <CAADnVQKfzu1F=xZxyYhiocAn1iM=8f13Ca-2Jfht2dXsXuGu9A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 09:14:11 -0700
Message-ID: <CAADnVQJTyXS--chM61Ysk7sDNXoUqPctprXwZ8DEcJMHa9Uy3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/16] bpf: wq: add bpf_wq_init
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:06=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 23, 2024 at 7:55=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@ker=
nel.org> wrote:
> > >
> > > We need to teach the verifier about the second argument which is decl=
ared
> > > as void * but which is of type KF_ARG_PTR_TO_MAP. We could have dropp=
ed
> > > this extra case if we declared the second argument as struct bpf_map =
*,
> > > but that means users will have to do extra casting to have their prog=
ram
> > > compile.
> > >
> > > We also need to duplicate the timer code for the checking if the map
> > > argument is matching the provided workqueue.
> > >
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > >
> > > ---
> > >
> > > FWIW, I still have one concern with this implementation:
> > > - bpf_wq_work() access ->prog without protection, but I think this mi=
ght
> > >   be racing with bpf_wq_set_callback(): if we have the following:
> > >
> > >   CPU 0                                     CPU 1
> > >   bpf_wq_set_callback()
> > >   bpf_start()
> > >                                             bpf_wq_work():
> > >                                               prog =3D cb->prog;
> > >
> > >   bpf_wq_set_callback()
> > >     cb->prog =3D prog;
> > >     bpf_prog_put(prev)
> > >     rcu_assign_ptr(cb->callback_fn,
> > >                    callback_fn);
> > >                                            callback =3D READ_ONCE(w->=
cb.callback_fn);
> > >
> > >   As I understand callback_fn is fine, prog might be, but we clearly
> > >   have an inconstency between "prog" and "callback_fn" as they can co=
me
> > >   from 2 different bpf_wq_set_callback() calls.
> > >
> > >   IMO we should protect this by the async->lock, but I'm not sure if
> > >   it's OK or not.
> >
> > I see the concern, but I think it's overkill.
> > Here 'prog' is used to pass it into __bpf_prog_enter_sleepable_recur()
> > to keep the standard pattern of calling into sleepable prog.
> > But it won't recurse.
> > We can open code migrate_disable,etc from there except this_cpu_inc_ret=
urn,
> > but it's an overkill.
> > The passed 'prog' is irrelevant.
> > If somebody tries really hard by having two progs sharing the same
> > map with bpf_wq and racing to set_callback... I can see how
> > prog won't match callback, but it won't make a difference.
> > prog is not going trigger recursion check (unless somebody
> > tries is obsessed) and not going to UAF.
> > I imagine it's possible to attach somewhere in core wq callback
> > invocation path with fentry, set_callback to the same prog,
> > and technically it's kinda sorta recursion, but different subprogs,
> > so not a safety issue.
> > The code as-is is fine. imo.
>
> After sleeping on it, I realized that the use of
> __bpf_prog_enter_sleepable_recur() here is very much incorrect :(
> The tests are passing only because we don't inc prog->active
> when we run the prog via prog_run cmd.
> Adding the following:
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index f6aad4ed2ab2..0732dfe22204 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1514,7 +1514,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog=
,
>         }
>
>         rcu_read_lock_trace();
> +       this_cpu_inc_return(*(prog->active));
>         retval =3D bpf_prog_run_pin_on_cpu(prog, ctx);
> +       this_cpu_dec(*(prog->active));
>         rcu_read_unlock_trace();
>
> makes the test fail sporadically.
> Or 100% fail when the kernel is booted with 1 cpu.
>
> Could you send a quick follow up to
> replace __bpf_prog_enter_sleepable_recur() with
>         rcu_read_lock_trace();
>         migrate_disable();
> ?
>
> Or I'll do it in an hour or so.

Considering two broken-build reports already
I've applied the following fix:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3Ddc92febf7b93da5049fe177804e6b1961fcc6bd7

that addresses the build issue on !JIT and fixes this recursion problem.

