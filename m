Return-Path: <linux-kselftest+bounces-40392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701FB3D89C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFF43ADA95
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7F23BD02;
	Mon,  1 Sep 2025 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32fTvgch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502623183C
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704137; cv=none; b=QFoiwjpcNT1lX99hlIQXr1mSgEY1FCm1EXnfd/RMkJhxFv7P+cr7Y/RbYLXBFOuR8GIemSRBtarzgTyWJl4zY8LOdXzq36W0NcF35rpHPLxYyj3+V5tupU5VNYtbKDElHulF6Ffd1XZhdzfZOBUX7lq6/jXQcM0d0HDCTKDT/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704137; c=relaxed/simple;
	bh=HLHTsIM34h2bVmSHmK3RHCrjuvZXbEGT2mCQfxSkDgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/s/tDxmL2Kpzrw0gBDNY2P3i1I1COurYEGwRCxiWRiAIRK5BJJMRmfw40S8Tr8b7B/7V7jgtD9shAH6yo7IX8f8Vf5cx2rFK80jj9q5Sp1Qf2bWI/wO2/kK5gtiRj11veLYjOv9NgQtt03vya5bXT18uw0ZjppiC1JMMasyUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32fTvgch; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24ab15b6f09so100105ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Aug 2025 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756704135; x=1757308935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3JUOeI5eLkXAJ0JToqzBrsoZN/dgfdGjoQiuyDHwOA=;
        b=32fTvgchYjmPXtq1AAAWC4Y5IYwEJXlVJSKXb46bVmDgL33G6tTSV3LNppxswOyEMk
         /rt0tsvzYBZV/XSsZZEWRwr7BYQJ/arc2/TojKYCp5oLMdOpZxKeySOe/GpLJKDYiXg9
         NIBmfY3YfUdjzus3fs1nxJTuDiC9xaMFuEnTnKIJrceSoPuj9W7GpORFb1mPvMCpCTb/
         PeewX4PLfI+hH1R6jluQZlbARYprXHEpbjBUlyJSjY6N6pR1z12sskS8PFT/ZVXV0/8t
         SdJBfEHOmw/ZgCtzdqWV2pKOPD+7KnBORi4PzUsN1/v9DI8jJNmrVyM9/IIcvjCQJh8u
         lL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704135; x=1757308935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3JUOeI5eLkXAJ0JToqzBrsoZN/dgfdGjoQiuyDHwOA=;
        b=MzmNmQ1Fk3UxxPIZLBnsB9oD6zuhNwusZA5XUj5gHbsbd0iCNj4XH24Du4wtMrP9cO
         Na28BU76VewNTCqhRHx6xcP1/KhhEsTTwYXxhbwthn6OzAq30gRaqSUZDdfL3nYkBjSv
         Z9EmTgNvxf6SqN6rfB/oknTftXUVeaCbV+Z4teTNJn9jsy8E/Gr0nLb8vAMGg7+4hjOq
         g6AViHxYzUN8TG7aAM0lnr9oWHzbHhP+IMwpqpi5TJaAdA55U6Gaxehx7hAe+psruZgt
         dVZA6WKmWcvwwzAPY/8uDLcCyCny7L2m96/M0XNcPgob+rT2O0LGWvTKMbkVSTrSbTaE
         mBBw==
X-Forwarded-Encrypted: i=1; AJvYcCWsYXx8MgA52Qm5pDBLHabsN5LaBTfSeQUqyXSplcDVXVYkhDfpPVhkBMTktmbdwgBFFE3c+64s8URLLZo1yNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTThadp1Q+QGaPk9PuK7Ap3qzxGGVBZ/y5WjUiQZww+UIcgRC8
	NJXBs5KoUUqZAr2M7WA6ac1/1UwSDNfFUtQzvx5f9/hYfR83+sBjt0n5D81TnycA1QRbxGpaX0A
	uVGMEAhkLCPruZlf31cIWlIK/ih9jLqjHiPAHiSek
X-Gm-Gg: ASbGnctwUmaBIn/U/nGZ4eqyRXs7mHSUGbBMbVWKlBc7yDnNfgr3umuZ8tfcAmDUOG1
	WsyFAcz2IRIkXGGgbLXC064euFtL5dKs4izkSvj6B5VC70BXSiDTvUfIlBaefYf6D0Hs8xbuRYu
	4xrYWd27mLm5wLJrojG5XUA9loqBWEFHEEJUVmlYPRfB5DN5wjgna0reobuHj5sJ/4hvrw4XtaO
	0H9XmetAvNHBp0=
X-Google-Smtp-Source: AGHT+IF8vf/SRj6IG+4XnZ6s0Tr8kDj9KMTcJmMft5w4l8YRI7nwXBYFtazfjQcQUjut7i7ZjJeBJ2Xf14sjuarTmEY=
X-Received: by 2002:a17:902:e802:b0:249:2caa:d5c9 with SMTP id
 d9443c01a7336-2493e95f173mr4689325ad.17.1756704134085; Sun, 31 Aug 2025
 22:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com>
 <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
 <CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com> <466d45ae-ce97-4256-9444-9f25f3328c51@linux.dev>
In-Reply-To: <466d45ae-ce97-4256-9444-9f25f3328c51@linux.dev>
From: Ian Rogers <irogers@google.com>
Date: Sun, 31 Aug 2025 22:22:01 -0700
X-Gm-Features: Ac12FXwcFeRmn2EUEMANe0UmtUpSCzeDlOtFTyoUJR0xvtvmxIWSMqVLvBoTo-Q
Message-ID: <CAP-5=fWQCZ6kC6rg5T1zOcshzEqhraXT5ix9kA=SjimiC4T-ZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Blake Jones <blakejones@google.com>, namhyung@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 9:17=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/29/25 10:19 PM, Ian Rogers wrote:
> > On Thu, Jun 5, 2025 at 2:00=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.=
org> wrote:
> >> Hello:
> >>
> >> This series was applied to bpf/bpf-next.git (master)
> >> by Andrii Nakryiko <andrii@kernel.org>:
> >>
> >> On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
> >>> The BTF dumper code currently displays arrays of characters as just t=
hat -
> >>> arrays, with each character formatted individually. Sometimes this is=
 what
> >>> makes sense, but it's nice to be able to treat that array as a string=
.
> >>>
> >>> This change adds a special case to the btf_dump functionality to allo=
w
> >>> 0-terminated arrays of single-byte integer values to be printed as
> >>> character strings. Characters for which isprint() returns false are
> >>> printed as hex-escaped values. This is enabled when the new ".emit_st=
rings"
> >>> is set to 1 in the btf_dump_type_data_opts structure.
> >>>
> >>> [...]
> >> Here is the summary with links:
> >>    - [v3,1/2] libbpf: add support for printing BTF character arrays as=
 strings
> >>      https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
> >>    - [v3,2/2] Tests for the ".emit_strings" functionality in the BTF d=
umper.
> >>      https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1
> >>
> >> You are awesome, thank you!
> > I believe this patch is responsible for segvs occurring in v6.17 in
> > various perf tests when the perf tests run in parallel. There's lots
>
> Could you share the command line to reproduce this failure?
> This will help debugging. Thanks!

Sure:
```
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
...
$ cd linux
$ mkdir /tmp/perf
$ make -C tools/perf O=3D/tmp/perf
make: Entering directory 'linux/tools/perf'
 BUILD:   Doing 'make -j28' parallel build
Warning: Kernel ABI header differences:
 diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cput=
ype.h

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

 GEN     /tmp/perf/common-cmds.h
...
  LINK    /tmp/perf/perf
  GEN     /tmp/perf/python/perf.cpython-313-x86_64-linux-gnu.so
make: Leaving directory 'linux/tools/perf'
$ git describe
v6.17-rc4
$ sudo /tmp/perf/perf test -v
  1: vmlinux symtab matches kallsyms                                 : Skip
  2: Detect openat syscall event                                     : Ok
...
 79: build id cache operations                                       : Ok
--- start ---
test child forked, pid 2546565
test daemon list
FAILED: wrong name
FAILED: wrong run
FAILED: wrong base
FAILED: wrong output
FAILED: wrong control
FAILED: wrong ack
test daemon reconfig
FAILED: Timeout waiting for daemon to ping
---- end(-1) ----
80: daemon operations                                               : FAILE=
D!
81: perf diff tests                                                 : Ok
 82: DRM PMU                                                         : Ok
 83: perf ftrace tests                                               : Ok
--- start ---
test child forked, pid 2546573
Test perf header file
perf: Segmentation fault
linux/tools/perf/tests/shell/header.sh: line 51: 2546664 Segmentation
fault      (core dumped
) perf record -o "${perfdata}" -- perf test -w noploop
Unexpected signal in test_file
---- end(-1) ----
84: perf header tests                                               : FAILE=
D!
85: perf list tests                                                 : Ok
...
 92: perf sched tests                                                : Ok
--- start ---
test child forked, pid 2546593
DB test
perf: Segmentation fault
/tmp/x/linux/tools/perf/tests/shell/script.sh: line 35: 2546822
Segmentation fault      (core dumped
) perf record $cmd_flags -o "${perfdatafile}" true
--- Cleaning up ---
---- end(-1) ----
93: perf script tests                                               : FAILE=
D!
...
$ /tmp/perf/perf version --build-options
perf version 6.17.rc4.gb320789d6883
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
        bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
           debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
         dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
             auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
               libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip:
Deprecated, license incompatibility, u
se BUILD_NONDISTRO=3D1 and install binutils-dev[el] )
       libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
          libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
           libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
              libpfm4: [ on  ]  # HAVE_LIBPFM
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
        libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
            libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip:
Deprecated, use LIBUNWIND=3D1 and ins
tall libunwind-dev[el] to build with it )
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
```

Thanks,
Ian

> > of BPF things happening in parallel in the test but the failures are
> > happening in a shell and I did get to attach a debugger. I've not seen
> > this problem earlier as the patches weren't in the perf-tools-next
> > tree. Through bisection I was able to blame the patch and I came up
> > with this minimal fix:
> > ```
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index ccfd905f03df..71e198b30c5f 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -326,10 +326,10 @@ struct btf_dump_type_data_opts {
> >         bool compact;           /* no newlines/indentation */
> >         bool skip_names;        /* skip member/type names */
> >         bool emit_zeroes;       /* show 0-valued fields */
> > -       bool emit_strings;      /* print char arrays as strings */
> > +       //bool emit_strings;    /* print char arrays as strings */
> >         size_t :0;
> > };
> > -#define btf_dump_type_data_opts__last_field emit_strings
> > +#define btf_dump_type_data_opts__last_field emit_zeroes
> >
> > LIBBPF_API int
> > btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index f09f25eccf3c..c7b5a376642f 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -2599,7 +2599,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, =
__u32 id,
> >         d->typed_dump->compact =3D OPTS_GET(opts, compact, false);
> >         d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, false)=
;
> >         d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes, fals=
e);
> > -       d->typed_dump->emit_strings =3D OPTS_GET(opts, emit_strings, fa=
lse);
> > +       d->typed_dump->emit_strings =3D true; // OPTS_GET(opts,
> > emit_strings, false);
> >
> >         ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
> >
> >
> > ```
> > So I think the problem relates to modifying struct
> > btf_dump_type_data_opts. Given I'm statically linking libbpf into perf
> > I'm not sure on the exact route of the segv, no doubt this report will
> > be enough for someone else to figure it out.
> >
> > Given this is a regression what should the fix be?
> >
> > Thanks,
> > Ian
>

