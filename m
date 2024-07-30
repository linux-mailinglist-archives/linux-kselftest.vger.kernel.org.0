Return-Path: <linux-kselftest+bounces-14477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606329415D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BCB281751
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF51B5839;
	Tue, 30 Jul 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="lPseiuR5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD01BA879
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354753; cv=none; b=IbHeOa5u2UWp2UjjdI1BbdW/Hy/zuU+aMqz8w992KrDBm8gcerqPf6LMSW8SCGb8Vh32WFIJtffAmP9guvEwho26OdHEnNmx54uNdP0VPY744BEbYVrMfvpNXQYIOMafJKT15pYkL0HeZeG3rk5B/upDqqgKu4RxpyNdxoC1wPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354753; c=relaxed/simple;
	bh=7nnrTpVQl5o8iqtbM8SeJvLywzfD17VnoiYWUIk6xso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6ACWaRBI8W1WJ29lDjhWNyHHeVsMUfd8XzRSkhbMowhNuwgZgszwx7Lrv57kevUpNYMRLD/Cw50T/0v/S5J4IvtYC1Qu6mSciCUk+bkzO3UoGnkYvXh9IFPeFvp3q/0efamFJBchlvn0MRM9Hp8VQ/xvVM9lxGb1CLai+nXETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=lPseiuR5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d399da0b5so4024363b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722354751; x=1722959551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw8Qsqd/KZkDjyfWp80nFufRwrNoDRQN85CCZLcmUUU=;
        b=lPseiuR5s0Sa1oDdnqRx1pzB+JOnNBgbS6AXuf5ER+PLGzFms4b1gUiFI69K3eQRjU
         azUgTyUknCu9YPY+R9LYjBmk/fzj67Tshd7XfdihYj8adUR+VoGPidmYh94/34o+vjil
         5daUErurEFlNkr019piMBKteV8wfLV9+7MSKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354751; x=1722959551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw8Qsqd/KZkDjyfWp80nFufRwrNoDRQN85CCZLcmUUU=;
        b=FhGAfoO9BJnQ+IDtyCNlRL8c2NC8WWyF+kmiZDMGJOjCQPBt9soZvEv0Gm0/9esyLD
         NiOIsvZsoeYwbnzV8jL4/i6niVSP/C+DVXkT6EoMLnmOd56g6WkrxFt1wLacfySa5XKE
         LrQZyt3+8poFH2yYbJI0U4ZiP3s4ryF9RwY6S6UzQ0fgAMIBZSac8tTmh+VAbiOjy4Bp
         w04aqTuhVRg7t7M33+AxF0X4Jq6iq392sDgrGA2qLtu0TD/OS7Adnkf/WjggAdlU6uPL
         ZW7c5IWIaRWSMDqDY4+5WIFGlA/9R1rVnOAuyRYjl7bV8kYEeILUHdnWZ3dju75S+SZi
         ToJg==
X-Forwarded-Encrypted: i=1; AJvYcCW10pqmA25lYvzP3L5MwcrINQatIbLBG66QNZJIwY8muYpOKoJXp0MCflk9baqmeLKGwO9cBZAP1TdgMCzJB6yVAX2dRkbv/BLYfCBIhKTU
X-Gm-Message-State: AOJu0Yw7IZdtV7nfgHObsWvd3zm5R5IF2ijJpSyZOGw2ae/lnDFOM6o/
	97vwbvzL3MRi+E7W0+ig0H0F3gV3oNasRviOmQqFBICA/b2uca0Apu3WEXjoaFk3Hui1WCT+76v
	mDC3Y3+nW+guu2mDf9Rw/wti3d4xqfWSNPrql0Q==
X-Google-Smtp-Source: AGHT+IG+hWn0qpzI+yyalb00iWHFGVyVmH4evfniZ+5SoF6jRo3s3Rz7MBI2RP6u3735TGwDrdJVwWS3SMyNdBUpnWc=
X-Received: by 2002:a05:6a20:7fa4:b0:1be:e1e1:d5de with SMTP id
 adf61e73a8af0-1c4a12f7ec1mr14013708637.30.1722354750705; Tue, 30 Jul 2024
 08:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729143743.34236-1-davidf@vimeo.com> <20240729143743.34236-3-davidf@vimeo.com>
 <arkcd6cjf42zq62maqsbjzvimxwozrkukusgxhd54v6eyd6ylq@aurn3mek6hr2>
In-Reply-To: <arkcd6cjf42zq62maqsbjzvimxwozrkukusgxhd54v6eyd6ylq@aurn3mek6hr2>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 30 Jul 2024 11:52:19 -0400
Message-ID: <CAFUnj5O7+kH1bZRs9=AB6hx8hjkygwmGRe3khSK0mFLZc=yehg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm, memcg: cg2 memory{.swap,}.peak write tests
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for checking!

On Tue, Jul 30, 2024 at 11:46=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> Hello.
>
> On Mon, Jul 29, 2024 at 10:37:43AM GMT, David Finkel <davidf@vimeo.com> w=
rote:
> > Extend two existing tests to cover extracting memory usage through the
> > newly mutable memory.peak and memory.swap.peak handlers.
>
> BTW do the tests pass for you?

Yeah, my tests pass when running on top of an ext2 mount.
At least one of the existing tests failed when running out of tmpfs,
so I've been testing with an ext2 mount in UML.
>
> I gave it a try (v6.11-rc1+your patches)
>
> $ grep "not ok 2" -B30 test.strace
>
> ...
> 315   15:19:13.990351 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0"..., 4096) =3D 4096
> 315   15:19:13.994457 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0"..., 4096) =3D 4096
> 315   15:19:13.998562 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0"..., 4096) =3D 4096
> 315   15:19:13.998652 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0"..., 4096) =3D 4096
> 315   15:19:14.002759 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0"..., 4096) =3D 4096
> 315   15:19:14.006864 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
current", O_RDONLY) =3D 7
> 315   15:19:14.006989 read(7, "270336\n", 127) =3D 7
> 315   15:19:14.011114 close(7)          =3D 0
> 315   15:19:14.015262 close(6)          =3D 0
> 315   15:19:14.015448 exit_group(-1)    =3D ?
> 315   15:19:14.019753 +++ exited with 255 +++
> 313   15:19:14.019820 <... wait4 resumed>[{WIFEXITED(s) && WEXITSTATUS(s)=
 =3D=3D 255}], 0, NULL) =3D 315
> 313   15:19:14.019878 --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXIT=
ED, si_pid=3D315, si_uid=3D0, si_status=3D255, si_utime=3D1 /* 0.01 s */, -
> 313   15:19:14.019926 close(3)          =3D 0
> 313   15:19:14.020001 close(5)          =3D 0
> 313   15:19:14.020072 close(4)          =3D 0
> 313   15:19:14.024173 rmdir("/sys/fs/cgroup/memcg_test") =3D 0
> 313   15:19:14.028517 write(1, "not ok 2 test_memcg_current_peak"..., 33)=
 =3D 33
>
> grep "^315 .*read.*4096" -c test.strace
> 12800
>
> Hopefully, unrelated to your changes. I ran this within initrd (rapido
> image) so it may be an issue how rootfs pagecache is undercharged (due
> to sharing?), instead of 50M, there's only ~256k.
>
> To verify, I also tried with memory.peak patch reverted, failing
> differently:
>
> ...
> 238   15:30:29.034623 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
current", O_RDONLY) =3D 3
> 238   15:30:29.034766 read(3, "52801536\n", 127) =3D 9
> 238   15:30:29.038895 close(3)          =3D 0
> 238   15:30:29.043048 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
stat", O_RDONLY) =3D 3
> 238   15:30:29.043230 read(3, "anon 52436992\nfile 0\nkernel 1105"..., 40=
95) =3D 870
> 238   15:30:29.047379 close(3)          =3D 0
> 238   15:30:29.051491 munmap(0x7f2473600000, 52432896) =3D 0
> 238   15:30:29.058516 exit_group(0)     =3D ?
> 238   15:30:29.062992 +++ exited with 0 +++
> 237   15:30:29.067054 <... wait4 resumed>[{WIFEXITED(s) && WEXITSTATUS(s)=
 =3D=3D 0}], 0, NULL) =3D 238
> 237   15:30:29.067136 --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXIT=
ED, si_pid=3D238, si_uid=3D0, si_status=3D0, si_utime=3D1 /* 0.01 s */, si-
> 237   15:30:29.067210 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
peak", O_RDONLY) =3D 3
> 237   15:30:29.071349 read(3, "52805632\n", 127) =3D 9
> 237   15:30:29.075470 close(3)          =3D 0
> 237   15:30:29.075562 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
peak", O_RDWR|O_APPEND|O_CLOEXEC) =3D 3
> 237   15:30:29.079712 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
peak", O_RDWR|O_APPEND|O_CLOEXEC) =3D 4
> 237   15:30:29.083848 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.=
peak", O_RDWR|O_APPEND|O_CLOEXEC) =3D 5
> 237   15:30:29.083970 write(3, "reset\n\0", 7) =3D -1 EINVAL (Invalid arg=
ument)
> 237   15:30:29.088095 close(3)          =3D 0
> 237   15:30:29.092209 close(4)          =3D 0
> 237   15:30:29.092295 close(5)          =3D 0
> 237   15:30:29.096398 close(-1)         =3D -1 EBADF (Bad file descriptor=
)
> 237   15:30:29.100497 rmdir("/sys/fs/cgroup/memcg_test") =3D 0
> 237   15:30:29.100760 write(1, "not ok 2 test_memcg_current_peak"..., 33)=
 =3D 33
>
> This failure makes sense but it reminded me --
> could you please modify the test so that it checks write permission
> of memory.peak and skips the reset testing on old(er) kernels? That'd be
> in accordance with other cgroup selftest that maintain partial backwards
> compatibility when possible.

Sure, I'll add that to the tests in a bit.
>
> Thanks,
> Michal



--=20
David Finkel
Senior Principal Software Engineer, Core Services

