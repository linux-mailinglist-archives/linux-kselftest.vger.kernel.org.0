Return-Path: <linux-kselftest+bounces-26272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775BA2FF08
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB03167522
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD061F956;
	Tue, 11 Feb 2025 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue1wDQ8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EB28F5;
	Tue, 11 Feb 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233445; cv=none; b=S0AJEmCoHCssf0yrVKbqfecqZVvU9YOtO2QECBoFM6aLwSHpxBNAXbwflTpNgj7G0goUThr7kQ6Sw0/2J9WkTRLj/OM7SsiYsU+6MA8kk4l5OJL6Yny3mVlIrHhkkYmHQRInH0CkiMdo5yA9gWAj9gY7y2qoYMq5+52Rgo6lkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233445; c=relaxed/simple;
	bh=bceCcMIN51Gw5PTClSGj08g7qSxXrCywSsSa7gJcP+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWvNXk+wow8QmOxlMbU0bGa3bH4N3I7RKgZoaTESgPpMIVhQvkfJd+0xW+e0Ff3sPQ2yaTg0OjggvuVaqnU6tc5roPoGxZ03R9o11k+enQByqJ+G9e0nxQXQ2plh5kG3K0HWAoJtrWgO0tWcqIqUel2zGkxyomw7DxBbDzFFObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue1wDQ8p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso7300195a91.1;
        Mon, 10 Feb 2025 16:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739233443; x=1739838243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR6cs8dSa5KLUpIJfEo/GIzxoLGSX486JQKCBnYkSxk=;
        b=Ue1wDQ8pA1PReVcJoXt3WujYOkKMW5viwxeQ3BkCyeVKsGpFJIFk69m/tHtjLlwQ1H
         4QxjLBTIns5iTVcxaclzLotpKakTsNDS4ard0BA7Oes5XhhrI/L91s9OSS6Vgu4lo4II
         y+12bj8c/297yXOg5pNgQUKfF8at5qFs8IqBqCEHj/US78Z1RM13kwUG9NRXa0qaPu5W
         tqB33ddbttdVK+zrmF2uybGkjgWRNrv8WndPTyLzj8zFPqEPH3Z7gUaQ7GRcMBm8maCv
         pBp4UoU9g1xEnMBcI52gsSr+9l7zfHbxW7kTMPPjT/zZeHnkHZ/rcl+xrNEta1SLqLh4
         LDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739233443; x=1739838243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR6cs8dSa5KLUpIJfEo/GIzxoLGSX486JQKCBnYkSxk=;
        b=mWLAZS8ga11ueIJaWcbnLICrZ390eXkSUClrZ2kwS7MtbCGALWKV0swWvQ0mVATOjR
         LpQuYP6KfdcAdzqSjAITGPTV0/SrxVRPOXG+iC9bh06Uk/NjPceTrmgc2ivDJXytzkxP
         wu4HfmvJpcckZhnDtN2WuxL6WQzcBpRCj2trUA0q+sDyQajEpa+EhAlJ8mIIXpSyNGJH
         6K5+5la1vf6mU3XFwZem7qjMypAzADznnROXwdurDoyZAH8YN2jf6vVWQFVLmzg6LZSi
         uHg+ckaP3ZkMSurKmv+FKtt7l2fIvMnqi7EVq8/g9ea5xmmqRobziMIy3nRyvgVpaomh
         4CPA==
X-Forwarded-Encrypted: i=1; AJvYcCUD86hVXk2lPF+V58HI4vWm3Iw+OUYqpS42TsBc+POtu2HGV/G/h+FORE6gEqDqTVM6bDgO5PVwIPRukZFg@vger.kernel.org, AJvYcCUy0Oc8gql0PQfuqA6k+NtMPRl+YDWCiPNA0KZWPha+I0/Ofo+IQGrTyaeHCCHsrkOcojZ+4t8wNck=@vger.kernel.org, AJvYcCVB9pmTBIDaU995o9b1O6A0EXB43s9GUmGWEcPzTocijzh8FlsP1OK22oOLND0WIy//nGRuaEcGHIjzSKkffiDyrA==@vger.kernel.org, AJvYcCW76svVkUvXSJqv8HdmD5I1hcVOdahqC4UG5AeDcZ1PYxNzsuCNIgHb/kZkpVBZR9IQ9nfQD9Ls5L9SjDmjb4EDudu7@vger.kernel.org, AJvYcCWWo7DNKikWVGwZMm4We7D0XWos7WBHBwgSjVIVYdxi3OeeS5///VH9vxN6x914NczQzKyrdtUPEsy9ROl+R6uK@vger.kernel.org, AJvYcCWc5AZc5PaQNU+Alk0D7Z/VvBpA/5UpYtuvddGpj8mWbk6iXe3QrEoTXHbiBaK4wik3fzM=@vger.kernel.org, AJvYcCXSLkMHFV4zgvunEnwDpYTBGMLoNHqJB8PDNt1T5G7p9/+EGe0Qbyh2v2TsLdM2tyJsDMP4u5NH0Jc/f3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXvQyv6PTIznxpMbCLzKjqr5cce7elgnyCu1RHbE/AzE7X7fm
	T8bl5eRw03BtV28Vds+9cAScj1Bu/nRpsj9OquELiVbOh3Uos/uWo0WqMVTQgtZ6fxk5gDUEwUH
	HNicGTAxp3FvfKhjYhnJRx6MD9ew=
X-Gm-Gg: ASbGncvCcDTGT28xScilMGYPzuKPlNQzd+7pS0xcboo8Rks85pUI74tIh6FADeV54zW
	c9E2u1kUCNnCJibkzYeQ/L/y/8aTkiQdhFcDY+pVLCr/hl4HNDCllNQrk5BnC0i1WbRGab+dVXi
	sjE/Dm8ikRtrUV
X-Google-Smtp-Source: AGHT+IERZ+9//5zkPxR96uNZxxjGAEHB8/WVgkS2kh3WkMzn1dA7yaF0AXbpR1PmTHC4wufSW4hIm6ryLayABtxfVxs=
X-Received: by 2002:a17:90b:4f45:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2fa9eda445fmr2686422a91.18.1739233442539; Mon, 10 Feb 2025
 16:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost> <Z6JksXDRh8OSAh-u@google.com> <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
 <Z6Khl1rHIAb7wOXw@ghost> <CAEf4Bza5nKk6_fVY2vmJjZgPb40zB+R3REy8==ZLc98eg1iHTA@mail.gmail.com>
 <Z6pF5pkH_bqvDwMK@ghost>
In-Reply-To: <Z6pF5pkH_bqvDwMK@ghost>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 16:23:49 -0800
X-Gm-Features: AWEUYZnaccT4BPXNPpNGSeRJBU32zLGw35IDOQ9nXqT4q9nrB0vIZ9VTbwC-L60
Message-ID: <CAEf4BzYqOtfOiYcHWRP44rwkrdzi3aMkjgD1-Td5DVAOLV=2kA@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Quentin Monnet <qmo@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:31=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Wed, Feb 05, 2025 at 05:28:19PM -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 4, 2025 at 3:24=E2=80=AFPM Charlie Jenkins <charlie@rivosin=
c.com> wrote:
> > >
> > > On Tue, Feb 04, 2025 at 11:02:42PM +0000, Alexei Starovoitov wrote:
> > > > On Tue, Feb 4, 2025 at 7:04=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> > > > > > On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wr=
ote:
> > > > > > > On Tue, Feb 4, 2025 at 12:10=E2=80=AFAM Charlie Jenkins <char=
lie@rivosinc.com> wrote:
> > > > > > > >
> > > > > > > > The quiet infrastructure was moved out of Makefile.build to=
 accomidate
> > > > > > > > the new syscall table generation scripts in perf. Syscall t=
able
> > > > > > > > generation wanted to also be able to be quiet, so instead o=
f again
> > > > > > > > copying the code to set the quiet variables, the code was m=
oved into
> > > > > > > > Makefile.perf to be used globally. This was not the right s=
olution. It
> > > > > > > > should have been moved even further upwards in the call cha=
in.
> > > > > > > > Makefile.include is imported in many files so this seems li=
ke a proper
> > > > > > > > place to put it.
> > > > > > > >
> > > > > > > > To:
> > > > > > > >
> > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > > ---
> > > > > > > > Charlie Jenkins (2):
> > > > > > > >       tools: Unify top-level quiet infrastructure
> > > > > > > >       tools: Remove redundant quiet setup
> > > > > > > >
> > > > > > > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > > > > > > >  tools/bpf/Makefile                        |  6 -----
> > > > > > > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > > > > > > >  tools/bpf/bpftool/Makefile                |  6 -----
> > > > > > > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > > > > > > >  tools/bpf/runqslower/Makefile             |  5 +---
> > > > > > > >  tools/build/Makefile                      |  8 +-----
> > > > > > > >  tools/lib/bpf/Makefile                    | 13 ----------
> > > > > > >
> > > > > > > Nack.
> > > > > > > libbpf and bpftool are synced independently to github
> > > > > > > and released from there.
> > > > > > > This change breaks it.
> > > > >
> > > > > Sorry, I overlooked this part and merged a change that touched th=
e
> > > > > common files into the perf tree.
> > > > >
> > > > > f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in =
Makefile.perf")
> > > > >
> > > > > Unfortunately, it's already in v6.14-rc1.
> > > > >
> > > > > >
> > > > > > Can you explain how it breaks it? Currently bpftool and resolve=
_btfids
> > > > > > don't build quietly so this was an attempt to fix that.
> > > > >
> > > > > So I think you will need something like this for v6.14.  Again, s=
orry
> > > > > about the trouble.
> > > >
> > > > Just revert f2868b1a66d4f40f that created this mess.
> > >
> > > Why are you opposed to unifying this helpers among the various projec=
ts
> > > in tools? Can you explain what about this breaks the Github syncing f=
low
> > > and why it cannot be resolved? It doesn't make sense to duplicate "Q=
=3D"
> > > in every Makefile anybody ever wants to add to tools just because bpf
> > > syncing isn't robust.
> >
> > Alexei's concern about Github mirrors of bpftool and libbpf isn't
> > valid. Github versions of those projects use their own independent
> > Makefiles anyways, so your change doesn't break that aspect.
> >
> > But your change *does* break both libbpf's and bpftool's make output
> > *in the kernel repo*. With this patch we basically don't have "quiet"
> > mode anymore:
> >
> > $ git co f2868b1a66d4f40f07e985b0beead606b2753602
> > HEAD is now at f2868b1a66d4 perf tools: Expose quiet/verbose variables
> > in Makefile.perf
> > $ git log --oneline -n1
> > f2868b1a66d4 (HEAD) perf tools: Expose quiet/verbose variables in Makef=
ile.perf
> > $ pwd
> > /home/andriin/linux/tools/lib/bpf
> > $ make
> >   gcc -Wp,-MD,/data/users/andriin/linux/tools/lib/bpf/staticobjs/.libbp=
f.o.d
> > -Wp,-MT,/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o -g
> > -O2 -std=3Dgnu89 -Wbad-function-cast -Wdeclaration-after-statement
> > -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations
> > -Wmissing-prototypes -Wnested-externs -Wno-system-headers
> > -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes
> > -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat
> > -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno-switch-enum -Werro=
r
> > -Wall -I/data/users/andriin/linux/tools/lib/bpf/
> > -I/data/users/andriin/linux/tools/include
> > -I/data/users/andriin/linux/tools/include/uapi
> > -I/data/users/andriin/linux/tools/arch/x86/include -fvisibility=3Dhidde=
n
> > -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D"BUILD_STR(s)=3D#s" -c=
 -o
> > /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o libbpf.c
> > ^Cmake[2]: *** [/data/users/andriin/linux/tools/build/Makefile.build:86=
:
> > /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o] Interrupt
> > make[1]: *** [Makefile:165:
> > /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf-in.o]
> > Interrupt
> > make: *** [Makefile:143: all] Interrupt
> >
> > $ git co HEAD~
> > Previous HEAD position was f2868b1a66d4 perf tools: Expose
> > quiet/verbose variables in Makefile.perf
> > HEAD is now at e9cbc854d8b1 perf config: Add a function to set one
> > variable in .perfconfig
> > $ make
> >   CC      /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o
> > ^C
> >
> > So, can you please check and fix?
>
> I think I am misunderstanding what you are saying. The patch that we are
> discussing on is the patch to fix this? You are showing the output from
> the patch that is being fixed in this series.

Ah, it's me getting confused. It was the earlier perf commit that
broke all this, makes sense. I just double-checked with your patches
applied locally. It indeed fixes the issue, LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> >
> > Also, looking at your patch:
> >
> > a) you removed the `"$(origin V)", "command line"` check from both
> > perf and libbpf, so that's not really an equivalent change/behavior
> > now
>
> I don't believe it is required to keep that check.
>
> >
> > b) a bit sloppy on assignment:
> >
> > +ifeq ($(V),1)
> > +  quiet =3D
> > +  Q =3D
> > +else
> > +  quiet=3Dquiet_
> > +  Q=3D@
> > +endif
> >
> > note the spaces around '=3D', try to keep stuff like this consistent
> > (and if this was shell, it would bite you as well)
>
> Yes, I can make that consistent.
>
> >
> > >
> > > - Charlie
> > >

