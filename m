Return-Path: <linux-kselftest+bounces-45684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B6C5FECA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 03:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6315D3BBD3F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744821E0BB;
	Sat, 15 Nov 2025 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biX5T468"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971F1F4615
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174723; cv=none; b=jTz87dsGTz1XIdUqKuRHNLW+rBh0+KOLG3TvIU2GcZx/ZyNLn2b+hXINMgu/7j8DBSMyfC02u5N4boZmLe++5+UhgZwaIDg0NGfmZwBKrH/qQ9l3p+YcNxGC8E5YEME2+2+lZ8DeTO4Bl4kG9ggRQWLGWxeNJv9qAqs5SgILKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174723; c=relaxed/simple;
	bh=QgQoA1oMCRhoLrz1xB6vwIvr2sOg0pFJdAiGIvKOPdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMPg3P0eh/hcPcsis3l062g3cY8nZ0w41zznBP8tsgeDsbGaqpuxWMoVnTDNA2pSTxDiGfuMvcEqsn5nJIc2AaUdgYewObNlnwradM0pPSjix7mBCLaIKBbI9FZXH5moiJcD72wuzAq2GboG4sQOencVrBBW2oMS6L3jmLNKOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biX5T468; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-787df0d729dso25743507b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 18:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174720; x=1763779520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvCG/LkvighatCxQcwWFOP8i6iT+iOW0XMsHIFsyAJQ=;
        b=biX5T468DtCnyuqLXOBvg/AifzVchKd2RyYf0sfJLDd61OZpcWI37qBFJOZhXFAJtL
         u7+UkGIGiBMF9LE4sC/ppVCKVodk3ipWztDV6S2rotWGD5r2NejsmBC9MgdD/uhbhECy
         WjLVoffZR9HHSFGJLV/5fLT+ln3w/Y2NT9XpLdjpf95rmPUem6hxu6fUVUWWqAlwO8Nh
         mukJHv0jR0q1hguE6XlLXUvHQMHIUjLudmSD7bfQ45kUCo+z2JF1Y0WBxcLLdUHS5pgN
         LxAHfp6BQhhbKphIU3Wjifg1LRedCL68HXBcf+oO3Bm8BgusV2fP/dCFQ+8n6hoWIlhY
         janw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174720; x=1763779520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvCG/LkvighatCxQcwWFOP8i6iT+iOW0XMsHIFsyAJQ=;
        b=tYmJ0X5Y2G/Wni606UuFsz3fS7erue+EM20U9lWAuiFftNIpxwgxhy6afMBRDoT86h
         G6CQJIazWpf2CtpdI1B2E+BSBsVsAfNz82iDY6vUzSt7XR9j9pXlaeH0N+EPfsroATfS
         WqMXu7Utrw8M30BI38Thu6fERoV3tCpJR6bY0MWv39Gvq2sv/A3bpodlTY1QN1plt7lz
         Fg3F77Hs0WtqtwG9LQx1YHKdR7aPmtA87DX8iDBKN2h6eoBhU64lEdJOwFw0URZDY6yi
         X49h5p30rsCjK9RNN9ZkNr+ZPCltkqwr4GrcLvYotNzl0CfRK35dwHdRsdsLC9W04iSO
         1yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUcY13IVdA1pJc3J8LHQmRh5H1kv8hYZrLQeqkfJ+fVysHhbxBNVm7/qWSjQ9QdFK7kycr9rpqSvXHLGzA1BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtwsBiXnQRRLswPHzi64N8k5f1QNbIGXo09jfMwXd6rYL8JOx
	2j4jgqbbioRN4pLYg38yO2xGlyJG0Jt6LpAkcAeOhHJ1i0KwtsZOG6kl7cbvMSBx1ncuQJiIKAZ
	qhmTQC8HoT/K2W+hYAKuoKTrAkZQEoXo=
X-Gm-Gg: ASbGncubBmKwsFLg5ezY4NhkVnigohB0/BaYsZiYe5SFqiqnbBYMZZL3fUd3cKmT1IG
	3dbMXBMloIZ4BkWxI3U81aV0FD0NZ92GhAWCwrT17CatP63C0Jzs6zLN3r0NbS3al+4LkMrrj4q
	OsgJUe/Gx2ac2TkFSSZIKxxU6n6/ijPZPc/K5JAISiFxoGqR3dlDkzHeZV2vj1aXL5B81H9jVSj
	qSLAagXxnmYMd5eX7Hju1s2TyRQBEHfJ9Fj4Unen3rdNdK3ypOBllw0k5Bc
X-Google-Smtp-Source: AGHT+IFYJ2/DFCYkBHvkGgyTOY/QDa8mebFzcO5f1baR7nsHhNcsvTScfI8nJm0kV8YKUSROcJCXAqFMKxgv51vQ55k=
X-Received: by 2002:a05:690c:8311:10b0:788:1d35:1093 with SMTP id
 00721157ae682-78929effd17mr42849487b3.63.1763174720339; Fri, 14 Nov 2025
 18:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110134858.1664471-1-dongml2@chinatelecom.cn> <CAEf4BzZ3oX-=zX0_HbeUHsPw7AOZVvi_LNkwugQnybpQvZS_Mw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ3oX-=zX0_HbeUHsPw7AOZVvi_LNkwugQnybpQvZS_Mw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:45:09 +0800
X-Gm-Features: AWmQ_blAFJ3hl5eVmRfpa2d2JMXS8aAVn_TR_4yg5YjO_-YeBjxqOcixOgmdshI
Message-ID: <CADxym3ZBmr1USGY08HcbpV6=G0SjZ6khoOb0R+L2R11AEOKzFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: simplify the kernel_count bench trigger
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	mingo@kernel.org, jiang.biao@linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 4:46=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 10, 2025 at 5:49=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Remove the "trigger_count" in trigger_bench.c and reuse trigger_driver(=
)
> > instead for trigger_kernel_count_setup().
> >
> > With the calling to bpf_get_numa_node_id(), the result for "kernel_coun=
t"
> > will become a little more accurate.
>
> "more accurate" is a bit misleading here. I think you meant that it
> will do same amount of helper calls as fentry and other benchmarks,
> and in that sense will be closer as a baseline comparison, is that
> right? Can you clarify that in the next revision, please?

Yeah, this is what I mean. The call to "bpf_get_numa_node_id" should
be considered as the baseline comparison.

>
> >
> > It will also easier if we want to test the performance of livepatch, ju=
st
> > hook the bpf_get_numa_node_id() and run the "kernel_count" bench trigge=
r.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  .../selftests/bpf/benchs/bench_trigger.c        |  5 +----
> >  .../testing/selftests/bpf/progs/trigger_bench.c | 17 +++++------------
> >  2 files changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools=
/testing/selftests/bpf/benchs/bench_trigger.c
> > index 1e2aff007c2a..34fd8fa3b803 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -179,11 +179,8 @@ static void trigger_syscall_count_setup(void)
> >  static void trigger_kernel_count_setup(void)
> >  {
> >         setup_ctx();
> > -       bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false=
);
> > -       bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
> > +       ctx.skel->rodata->kernel_count =3D 1;
> >         load_ctx();
> > -       /* override driver program */
> > -       ctx.driver_prog_fd =3D bpf_program__fd(ctx.skel->progs.trigger_=
count);
> >  }
> >
> >  static void trigger_kprobe_setup(void)
> > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/=
testing/selftests/bpf/progs/trigger_bench.c
> > index 3d5f30c29ae3..6564d1909c7b 100644
> > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > @@ -39,26 +39,19 @@ int bench_trigger_uprobe_multi(void *ctx)
> >         return 0;
> >  }
> >
> > +const volatile int kernel_count =3D 0;
>
> nit: use bool? it's not a counter, no need to use int here
>
> >  const volatile int batch_iters =3D 0;
> >
> > -SEC("?raw_tp")
> > -int trigger_count(void *ctx)
> > -{
> > -       int i;
> > -
> > -       for (i =3D 0; i < batch_iters; i++)
> > -               inc_counter();
> > -
> > -       return 0;
> > -}
> > -
> >  SEC("?raw_tp")
> >  int trigger_driver(void *ctx)
> >  {
> >         int i;
> >
> > -       for (i =3D 0; i < batch_iters; i++)
> > +       for (i =3D 0; i < batch_iters; i++) {
> >                 (void)bpf_get_numa_node_id(); /* attach point for bench=
marking */
> > +               if (kernel_count)
> > +                       inc_counter();
> > +       }
>
>
> tbh, I wouldn't touch trigger_driver() adding unnecessary if
> conditions to it. It's fine, IMO, to have bpf_get_numa_node_id() call
> in trigger_count() for being closer in terms of actual work being
> done, but I'd keep trigger_driver and trigger_count separate (maybe
> renaming trigger_count to trigger_kernel_count would help, I don't
> know)

Ah, OK! I'll add the call to bpf_get_numa_node_id() in trigger_count()
instead. I think the "trigger_kernel_count" makes more sense to me.

Thanks!
Menglong Dong

>
> pw-bot: cr
>
> >
> >         return 0;
> >  }
> > --
> > 2.51.2
> >

