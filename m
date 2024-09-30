Return-Path: <linux-kselftest+bounces-18676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58398ABA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D1428348D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAB197A98;
	Mon, 30 Sep 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGUXn12M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC5192D7F;
	Mon, 30 Sep 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719659; cv=none; b=INFIxfqttR4NZmJ4aH82gtbnNMDROpV+yzpYxcWaTB8ZcZ/fvSpQA57Wlh+CbV1lIc9e7Wc7/UulNgi8iwxY25aMSrDRAWLMEU80NRpvbs99IkbgdcuOGcym/H2A0+eNYK1F/oGsgU96kvD9REUQBYrHoi0I8TlTr0SNVFgwKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719659; c=relaxed/simple;
	bh=/OQ1KrxkGaM4pmRJR4cp2j2Yxi9P63AE+31ryt6tBH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lc241VLZvKHvUUgaRJ+1mJd6WkdodsqYvG3wn2qoTA1dkR+YXhl/uChIuQMPNom9hRD1Ft2VPdzgA7/ST4Q6Zbl9LB/1vOKoQxbhTeIRjiit0X77xDyi9rnDiHoBKk4v2Vox9HtjsESLqPw+iqVZNK+zmM4wApqbkBU1xMQV0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGUXn12M; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so4539176a12.3;
        Mon, 30 Sep 2024 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719654; x=1728324454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY0iwTLU6dMbnSBlFFGwESeicvDgtQgfBKe38KXMEGc=;
        b=YGUXn12MKoY/2MveT676gci2o0QU0rXRR1R1OebPxjGpVvGpxr4wbO8vUvDFNVIzJ/
         8F0L3Wp8kkdLv0d+2kO5GiSxgAbhhiDpBySQF2GOCVvFBBCqaqqww/bHoR9bon1RyASN
         kG/fEyZs2h6rti2WTtdT6dGTbK6q6fo/wuvRthpa7ncbX0uWFjAJMcKmGYA6befWGupD
         c0Bhs33u2Ydfon8b5+01157zH1gOZYPgRqGRCbSggbGewznZL77rR0BPsM1+mGjig82e
         wv8F3Pr8gcgVfnSeBb1zwFkMOUzLB+Mn9gfTfF7Jqs9b6S17ZR7sCwXPliFm/u6/eLV+
         m0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719654; x=1728324454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY0iwTLU6dMbnSBlFFGwESeicvDgtQgfBKe38KXMEGc=;
        b=JkitAKs+LgXq/K+QORhk8nsw84I/Ao9ltyqHRIWjxsRZ6Ve/JVDEp0HOOIfh8aiB0V
         TQuG+IeeKNdiQ/TkroeUYVsO2XSY12ZlsgQaVDkDzuDzrEHloXZxkDmCFEgUOIS6FXnE
         IL/LVxpND1qr5drNosyZfhiSzbfzB6+uT4iZ3d3zHgHKim752g2s3OCDzHUujAUS2Re5
         XH6Tkl2hLltUS+XmzZOMW4yE2ELwDUmxPN6+XZcyShLv46Lkvdfma4gq13wYx6uUMj0B
         v4Xj/mPq6yXTQOSZJFTjEybqO41vn7cKiO251H1iqGOqNOzsqnT6yzqfCjAsYMT62eEl
         5rNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP0GziB5T4dPsw9m5xFKSDnQk0ztw+Rq19LB9FnMo+e4reNqQ5781xWxWdEUMXCxAl2A5JNWyNJf3hxV2d2J4D@vger.kernel.org, AJvYcCUXsSYpKHsGN/IFFsKfekoma7rbx+purGnDqwlnv2NZ/6E3mRvrBILlcsWU0+zsSxxdDWXVhyBS@vger.kernel.org, AJvYcCWYXWWahiXV/fuQ+4TQMAmVphLc6KfAg2nnLrYe0VZwohwSfr5wr8ydNynLWO2t1j/9poXKKIe0jSuvveCt@vger.kernel.org
X-Gm-Message-State: AOJu0YykH+k3hixp+GWXxV9CeGuuyaYAY1VEHGE1FTNarwRDjK7t81a0
	Tu1CJ/6e5YMpUboQo5qrgugyssSkx/zpOKqcUEkC5avclkEWtO5mdzY1t3a8CwR9X963ZY/f11B
	sMgF7XfT+tYRqWIxUx/Tx5JgLAJI=
X-Google-Smtp-Source: AGHT+IFP6WDNQPZ9jjVjlI/4U88hFaj1AgY82DAJT5+4CxUr5/y7oYHvgbttXNKqqMeFnisx/Fdz1kFN0xEIbYzbO7Y=
X-Received: by 2002:a05:6402:2713:b0:5c8:9ee6:379a with SMTP id
 4fb4d7f45d1cf-5c89ee6397dmr1926054a12.30.1727719653955; Mon, 30 Sep 2024
 11:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-3-joshua.hahnjy@gmail.com> <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
In-Reply-To: <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Mon, 30 Sep 2024 14:07:22 -0400
Message-ID: <CAN+CAwO8XEAkoBDc03Zveaci9hASaFvk8ybQ2Mwoy_VacqgRfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	lizefan.x@bytedance.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:10=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Sep 23, 2024 at 07:20:06AM GMT, Joshua Hahn <joshua.hahnjy@gmail.=
com> wrote:
> > +/*
> > + * Creates a nice process that consumes CPU and checks that the elapse=
d
> > + * usertime in the cgroup is close to the expected time.
> > + */
> > +     user_usec =3D cg_read_key_long(cpucg, "cpu.stat", "user_usec");
> > +     nice_usec =3D cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
> > +     if (user_usec !=3D 0 || nice_usec !=3D 0)
> > +             goto cleanup;
>
> Can you please distinguish a check between non-zero nice_usec and
> non-existent nice_usec (KSFT_FAIL vs KSFT_SKIP)? So that the selftest is
> usable on older kernels too.

Yes, this sounds good to me -- I will include it in a v4, which I am
hoping to send out soon.

> > +
> > +     /*
> > +      * We fork here to create a new process that can be niced without
> > +      * polluting the nice value of other selftests
> > +      */
> > +     pid =3D fork();
> > +     if (pid < 0) {
> > +             goto cleanup;
> > +     } else if (pid =3D=3D 0) {
> > +             struct cpu_hog_func_param param =3D {
> > +                     .nprocs =3D 1,
> > +                     .ts =3D {
> > +                             .tv_sec =3D usage_seconds,
> > +                             .tv_nsec =3D 0,
> > +                     },
> > +                     .clock_type =3D CPU_HOG_CLOCK_PROCESS,
> > +             };
> > +
> > +             /* Try to keep niced CPU usage as constrained to hog_cpu =
as possible */
> > +             nice(1);
> > +             cg_run(cpucg, hog_cpus_timed, (void *)&param);
>
> Notice that cg_run() does fork itself internally.
> So you can call hog_cpus_timed(cpucg, (void *)&param) directly, no
> need for the fork with cg_run(). (Alternatively substitute fork in this
> test with the fork in cg_run() but with extension of cpu_hog_func_params
> with the nice value.)
>
> Thanks,
> Michal

Thank you for your feedback, Michal.
The reason I used a fork in the testing is so that I could isolate the nice=
d
portion of the test to only the CPU hog. If I were to nice(1) --> cg_hog()
in a single process without forking, this would mean that the cleanup porti=
on
of the test would also be run as a niced process, contributing to the stat =
and
potentially dirtying the value (which is tested for accuracy via
`values_close`).

The other thing that I considered when writing this was that while it is
possible to make a process nicer, it is impossible to make a process less
nice. This would mean that the comparison & cleanup portions would also be
run nicely if I do not call fork().

What do you think? Do you think that this increase in granularity /
accuracy is worth the increase in code complexity? I do agree that it
would be much easier to read if there was no fork.

Alternatively, I can add a new parameter to cpu_hog_func_param that
takes in a nice value. For this however, I am afraid of changing the
function signature of existing utility functions, since it would mean
breaking support for older functions or others currently working on this.

Thank you for your detailed feedback again -- I will also change up the
diffstat and indentation issues you brought up from the first part of the p=
atch.

Joshua

