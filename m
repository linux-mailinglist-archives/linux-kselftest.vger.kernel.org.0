Return-Path: <linux-kselftest+bounces-7450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808AC89D09C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36011C21BB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9254745;
	Tue,  9 Apr 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YflbFw/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853555464A;
	Tue,  9 Apr 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631875; cv=none; b=sPzOeysGwJ0rdbmkYfw9X8cFmdv87pG+OwqwIvdNf5toUMPI+ozLkiFjvoLaENCEZYbp5FH/9M4YcPnFmY4lZLYrFmJVQJvWHS7PexXAU2t4z2l5+48SRYF4QHM8lFbER2GrXKe85gWpBvoK7hVweb1Ah/4XXU4nH9Y1w+zych4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631875; c=relaxed/simple;
	bh=fCm2QjzqZmE57hIW5ALy8jcaYaNfeVyVqC6/smTRYlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmS3OX4UvOQ13Nnp179zto1wS2obzxhUfGFP4LDNzoOIAyF/gnXdEDCwISt6qSJnY5QzHEyk0Fm+ksscoz/A9QMmYOJmtQkMqZPD06uIMttTtloIiGM3Oag817l9HDuOCHVCKTrquFaBHonvrrm3GjERAJkt8zUlRwmaWoPO9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YflbFw/G; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343d7ff2350so2623968f8f.0;
        Mon, 08 Apr 2024 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712631872; x=1713236672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xcSXujIE/jclEFI/AnTD1MfFWS/axn8b5ifK4JkF34=;
        b=YflbFw/Gm7Fx7erRmB4CRkFHkXOS+vTb9VVuSeb624XzjH4FFbua96DKUTdpmWbzlK
         vqd3gK8m7xKtuWV8L9hiHJ9tRpxNkJB5nh9GnfPWOvVFgXQgzQzfmqu9v2mzcLPKefCR
         oYdIuA5AvFRC7xCxd46mQ+rfbzDzGe2OT4wbpyGSwH6dGM7QfhlajcQR+G7WcSmt0rsZ
         Q6L5r+o1jPhDBzajamtHbrVe8utv7k7XVQcQVYgpRhh5jY3bWSU4JAzlAhLRN0pkkRBT
         4TGCF4FAeNFzzDBaYWeZNb3ROJuo2mDRSG4UKgGWeLyCk4PP1+3k0c1/UcGTeYutuJ/S
         eaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712631872; x=1713236672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xcSXujIE/jclEFI/AnTD1MfFWS/axn8b5ifK4JkF34=;
        b=JdDqExDE1UODAf7cqCymtG9Ztb+9B0fI91EgFr8IlcALtrCmVKphdui2Pw3uZH+oAa
         wzXJABqlc0Sw1w5YYf4IsHtxMb4BtP61w/Sr0DMmjeUb3PV9+rQLZpKtq9wTKF3e/nwJ
         b8iMYcFskzZKadpTUvQCTapMOItMCFuxdcB1rU1/RxC4VzobtfRc5uMhPmEqtwBvjc3t
         E72oqgPcGVj9B5Q3WT4LoeZJkqFMvyAFO3EtGMf+Ix/4o7EikaNIMyQi/+nfyYWGgkCZ
         jyraMoiGjSjZ/ht5xVCkTmqGPosb3PLcYhFkOl/PnH7ju1NSnjp2xll8sDdjpiW4axdG
         8mDw==
X-Forwarded-Encrypted: i=1; AJvYcCXwBZm/96sFrK6yG8HTPErQLvhzWSab8J9ZCYFagBUI0i76sODCQDqOhkXJXYdAvZL7O9B3xUO61We+9FpV9fGJRDg6WrUGga9fOg4dkASJVZZDjrlCgAEIhwUvWGNT8rzfwr+MtbrRGZLsn2jn0aMiTdDjaowlySV3Jku+/flMwK+t
X-Gm-Message-State: AOJu0Yx2tvebd8yL6jVydjOEQ6s1H+UGQ2sXaovEw9BN8jeV/HaD/LZa
	aUWEM/yfCpxYUajU/tI+fD+TRCLJ7k4Ayod3slDAEfR26C+91kV5jaLlJPlUzgTt1BYRNe60KBl
	Bixs4BH6hoJoCUyxo55+bmC4mBc0=
X-Google-Smtp-Source: AGHT+IGp41Cfuwq20B11xn8kWbTSIlrKYpIGB+tSGSBsGBTpF/qFVRzLEx0Dgq2MGYlXQ3lVJuI2UiF26VWt6AOFzFc=
X-Received: by 2002:a5d:4b02:0:b0:341:b9dc:eb03 with SMTP id
 v2-20020a5d4b02000000b00341b9dceb03mr8491804wrq.3.1712631871629; Mon, 08 Apr
 2024 20:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-1-0499ddd91b94@kernel.org> <65c249a6af45bfa5fe0f6c2331dcc1771a6f0b05.camel@gmail.com>
 <CAO-hwJ+0erX3iJcOh9KBG3f01UiYvGk_Gx+-zyFc4Vb5LCcHxA@mail.gmail.com>
In-Reply-To: <CAO-hwJ+0erX3iJcOh9KBG3f01UiYvGk_Gx+-zyFc4Vb5LCcHxA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 20:04:20 -0700
Message-ID: <CAADnVQJRGgmBN+2wi9rKsLaVbBw5RuNtLN-pOBq-Pv3TC0-dww@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 10:20=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Mon, Apr 8, 2024 at 7:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 9234174ccb21..fd05d4358b31 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1096,12 +1096,19 @@ const struct bpf_func_proto bpf_snprintf_prot=
o =3D {
> > >   * freeing the timers when inner map is replaced or deleted by user =
space.
> > >   */
> > >  struct bpf_hrtimer {
> > > -     struct hrtimer timer;
> > > +     union {
> > > +             struct hrtimer timer;
> > > +             struct work_struct work;
> > > +     };
> > >       struct bpf_map *map;
> > >       struct bpf_prog *prog;
> > >       void __rcu *callback_fn;
> > >       void *value;
> > > -     struct rcu_head rcu;
> > > +     union {
> > > +             struct rcu_head rcu;
> > > +             struct work_struct sync_work;
> >
> > Nit:
> > I find this name very confusing, the field is used to cancel timer
> > execution, is it a convention to call such things '...sync...'?
> >
> > > +     };
> > > +     u64 flags;
> > >  };
> > >
> >
> > [...]
> >
> > > +static void bpf_timer_sync_work_cb(struct work_struct *work)
> > > +{
> > > +     struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer=
, sync_work);
> > > +
> > > +     cancel_work_sync(&t->work);
> > > +
> > > +     kfree_rcu(t, rcu);
> >
> > Sorry, I might be wrong, but this looks suspicious.
> > The 'rcu' field of 'bpf_hrtimer' is defined as follows:
> >
> > struct bpf_hrtimer {
> >         ...
> >         union {
> >                 struct rcu_head rcu;
> >                 struct work_struct sync_work;
> >         };
> >         ...
> > };
> >
> > And for sleepable timers the 'sync_work' field is set as follows:
> >
> > BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_m=
ap *, map,
> >            u64, flags)
> > {
> >         ...
> >         INIT_WORK(&t->sync_work, bpf_timer_sync_work_cb);
> >         ...
> > }
> >
> > So, it looks like 'kfree_rcu' would be called for a non-rcu pointer.
>
> That was my initial assumption too, but Alexei told me it was fine.
> And I think he is correct because kfree_rcu doesn't need the rcu_head
> to be initialized.
>
> So in the end, we initialize the memory as a work_struct, and when
> that work kicks in, we reuse that exact same memory as the rcu_head.
> This is fine because that work will never be reused.
>
> If I understand correctly, this is to save a few bytes as this is a
> critical struct used in programs with a high rate usage, and every
> byte counts.

Yes. All correct.
Probably makes sense to add a comment before kfree_rcu()
line in bpf_timer_sync_work_cb() that
kfree_rcu will wait for bpf_timer_cancel() to finish
as was done in
commit 0281b919e175 ("bpf: Fix racing between
bpf_timer_cancel_and_free and bpf_timer_cancel").

I suspect that's what confused Eduard.

The patch 1 looks great overall.

If we're going to keep this combined bpf_timer_* api for both wq
and timer we'd need to add flags compatibility check
to bpf_timer_start() too.
We can disallow this flag in 'flags' argument and use one from t->flags.
Which kinda makes sense to make bpf_timer_start() less verbose.
Alternatively we can allow bpf_timer_start() to have it,
but then we'd need to check that it is actually passed.
Either way the patch needs an extra check in bpf_timer_start().
Just ignoring BPF_F_TIMER_SLEEPABLE in bpf_timer_start() doesn't look right=
.

