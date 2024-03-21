Return-Path: <linux-kselftest+bounces-6465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C858C885C6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C10FB22B87
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8EE86250;
	Thu, 21 Mar 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs3LJ04Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1186261
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035860; cv=none; b=jnCxShICRbdwIaVw6OdyDWUbYTZ9N3kgRCnOFIsJ/2Im+OUk8tXx/ZuWrO60cYoQBQlV+nrJnqKJ4feUmOQXNGBpsC3b/4Iwx12IA6Irp/0EQWV61rOPorp+6i9TQ8LT6kV1nV491nQur58dpUibJUGN0p/mJUBNu0MR2Uys69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035860; c=relaxed/simple;
	bh=phrwu6hEFwR3OmRq0xmE0wJeGnZ2XPtxhImxOPSRs8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx3zxbVzO8tyuavryxkOvpWiRv9Ek4lbjE4JmFFHH6n499O/mCZyDqe1nzSCkiOts3QaCOhITs0WfS/JizUHLI3APQTSKC3upbmBvhaUsq3C+t2NkdOvXULVvy+KGJvOIWOy18jJ8c8+namNmBe15OW+FU4vAWfhQTyTC7FG4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fs3LJ04Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711035857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9X/54MANsD/vA3gDB6Zr3YBdoXorm5FGsBGyONKCgo=;
	b=Fs3LJ04ZtiUPGoM1CQnvBJ4It570s9nkn9kisAUcgEMuMstYAWugyVNJhNeaHrBvIRhXdp
	WI8rVkE905v0lUM4B6DJjYnNyIrVn3hPIwldfJklSVPG8Fqcr7sv5Zm5w3irj0dyMJzh2r
	TEeBcKUu3lcYb626Wue3kolOpiJDIRI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Cx_aJ5QvPROW47Md__-peg-1; Thu, 21 Mar 2024 11:44:15 -0400
X-MC-Unique: Cx_aJ5QvPROW47Md__-peg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513def50581so1127829e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 08:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035854; x=1711640654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9X/54MANsD/vA3gDB6Zr3YBdoXorm5FGsBGyONKCgo=;
        b=L4sm4/KgwdVzx4tmdIyfUzG7KuxlcD/L7srF0JW2Abwu+YDjuuBBI4Sr6XutZv3lnJ
         Y2dnpeDMY4k9VbB1/M4O0LuSXur+Coh0lNL3CKlvkPehwNK58xrvF+z8npM6NaJn+Bed
         2cCWNrRbIf9EE1Ly4e52KAur5cokkR5khuDx4MxWsETt0ar228akAhYnZE2NBkKoWNhB
         dUXDk68+hSXUepP+W8MoBz5Bcu1hykSzp8nhsigjFHNPY3AsZ34MFf2EtBsSZYm8ggbm
         aQPxQyJfSj++lPvGY+CVEZ/8/kCVyiVrRshCHR6KOKuKbyDHmYZD2sLq2gvBlGRbn26D
         Qkbg==
X-Forwarded-Encrypted: i=1; AJvYcCU934odrx3cppW1Qq9/COVoCh1hiuTUxFC3pv1ZyyQbKuI0yXCsLXFjCfZkPx548B8z6Z26+Kfwr9v9WS4/MHyeXDhmA+g2+Ftbc7N7ytPF
X-Gm-Message-State: AOJu0YwWn7s4VXAGszn5HQidQ4tdQH6HonbPhWn6hZ2ht4PSrIifWU21
	UU3Bmtx9pgbJrzNK/AB9DeSfzSHTyOS9HDV10HS8Yy+1FUDgVVsknJm9mDibWKxuJfqNa/J0UAR
	bH0CXifNz8Zg+Abdx0bqHgUPX/r0H/MuwQD0I0VOWDvH1CmjN9Y+JrxBI+qFZP7EEgdYYWMbGJa
	EjQjfxC4JrejJaU3b3T+Nd3dKunDhEUAqM/xFxL4Ss
X-Received: by 2002:ac2:5b50:0:b0:513:d82a:8d3a with SMTP id i16-20020ac25b50000000b00513d82a8d3amr2417717lfp.35.1711035854144;
        Thu, 21 Mar 2024 08:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZIKyQs7CyzkABKXj1SHOyLGf1WPq90wMOMnQeFNTWTzKPNsmeP/5JcobJ6xacp+RlyAuScGQ1FCFgg1A4Yk=
X-Received: by 2002:ac2:5b50:0:b0:513:d82a:8d3a with SMTP id
 i16-20020ac25b50000000b00513d82a8d3amr2417696lfp.35.1711035853790; Thu, 21
 Mar 2024 08:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-3-5658f2540564@kernel.org> <70ae8d7d2ed950466a61d118f59c16cb07fc9688.camel@gmail.com>
In-Reply-To: <70ae8d7d2ed950466a61d118f59c16cb07fc9688.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 16:44:01 +0100
Message-ID: <CAO-hwJLqp4Xm20_CDMvr-GJGFShQ1gSmyWr0MqPvh_+icPJVTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
>
> This patch looks good to me, please see two nitpicks below.
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks!

>
> [...]
>
> > @@ -1350,6 +1358,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_ker=
n *, timer, u64, nsecs, u64, fla
> >               goto out;
> >       }
> >
> > +     if (t->is_sleepable && !(flags & BPF_F_TIMER_SLEEPABLE)) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
>
> Nit:
> the BPF_F_TIMER_ABS and BPF_F_TIMER_CPU_PIN don't affect
> sleepable timers, should this check be changed to:
> '(t->is_sleepable && flags !=3D BPF_F_TIMER_SLEEPABLE)' ?

Sounds fair enough. Scheduled this for v5

>
> [...]
>
> > @@ -12151,6 +12175,16 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               }
> >       }
> >
> > +     if (is_async_callback_calling_kfunc(meta.func_id)) {
> > +             err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> > +                                      set_timer_callback_state);
>
> Nit: still think that this fragment would be better as:
>
>         if (is_bpf_timer_set_sleepable_cb_impl_kfunc(meta.func_id)) {
>                 err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
>                                          set_timer_callback_state);
>
> Because of the 'set_timer_callback_state' passed to push_callback_call().

Yeah, sorry I missed that part from the previous reviews.

Fixed in v5

Cheers,
Benjamin

>
> > +             if (err) {
> > +                     verbose(env, "kfunc %s#%d failed callback verific=
ation\n",
> > +                             func_name, meta.func_id);
> > +                     return err;
> > +             }
> > +     }
> > +
> >       rcu_lock =3D is_kfunc_bpf_rcu_read_lock(&meta);
> >       rcu_unlock =3D is_kfunc_bpf_rcu_read_unlock(&meta);
> >
>


