Return-Path: <linux-kselftest+bounces-26893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652ABA3A5DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B766B1897D26
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692641EB5EB;
	Tue, 18 Feb 2025 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIkr4LKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0922356D6;
	Tue, 18 Feb 2025 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903984; cv=none; b=hcsQZQ/7S3x0RcmmGN7CtUfQwSymljFba9mQppFTvGTyl+5dO5xY/+uu/hircyZo7A+cfm4/GiaGe6M/fkIf4FsCep76/39OOKkJjOVLvrCQEhnT0AW9Cm9RMWkSm0o0/aWpXbS4kyVWTjoWFBm0tyLkt4npPIJUUEdKMsbkNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903984; c=relaxed/simple;
	bh=Ou8KiLZLHzNrLWIVPdXFzquRxMgMgDClrgJgKs9eQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miK+t550iztEXXaXYIqBlcKm3EtDDul/datYPxGO3FxmQbEwm/u00ldIfpd+R7wtIUZDhvOnXKXMBAhCPWLnbAPv8tBgGR8/OVvCTEx759HaELmc8sRGjbYKjOgL+hUuuoSipLPkKp74GDTgXP3EtNzChMwYgn5weHi49NVfiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIkr4LKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7189AC4CEE2;
	Tue, 18 Feb 2025 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903984;
	bh=Ou8KiLZLHzNrLWIVPdXFzquRxMgMgDClrgJgKs9eQE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIkr4LKr95n1sgWF9eEKIJtFMEX2I2pw8roaOiQU1XD153ZTLXDZ/mxRjmNnouq8f
	 hCJAs1u7Lcmk1DsOmrf5X9sqrHdn6+BqgSxvoB9xQ48YhhDZVUkd095jxxSj64Q2A/
	 dE3jGIV9Deg1JrO11Pjdtednrud/M5DAzOcVuvzGlWsSFobWfDsfA609icoCTjThG5
	 H/5ftZ/mejgknk5xj8NRzZnmoBZ5pOHD/RKFznLFZlPXb0HoCZZWt/f/eqU1XMqgJh
	 Ws4wCzl1lxD2gu5weFETthkXl8KvnCMevgDaweHSnsnVdtPAmnXTW9MWORDWIHj5bF
	 MHI/IZhPoLTIw==
Date: Tue, 18 Feb 2025 19:39:40 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z7TT7Jw5QDx2G81v@x1>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost>
 <Z6JksXDRh8OSAh-u@google.com>
 <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
 <Z6Khl1rHIAb7wOXw@ghost>
 <CAEf4Bza5nKk6_fVY2vmJjZgPb40zB+R3REy8==ZLc98eg1iHTA@mail.gmail.com>
 <Z6pF5pkH_bqvDwMK@ghost>
 <CAEf4BzYqOtfOiYcHWRP44rwkrdzi3aMkjgD1-Td5DVAOLV=2kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYqOtfOiYcHWRP44rwkrdzi3aMkjgD1-Td5DVAOLV=2kA@mail.gmail.com>

On Mon, Feb 10, 2025 at 04:23:49PM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2025 at 10:31 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Wed, Feb 05, 2025 at 05:28:19PM -0800, Andrii Nakryiko wrote:
> > > On Tue, Feb 4, 2025 at 3:24 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Tue, Feb 04, 2025 at 11:02:42PM +0000, Alexei Starovoitov wrote:
> > > > > On Tue, Feb 4, 2025 at 7:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> > > > > > > On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> > > > > > > > On Tue, Feb 4, 2025 at 12:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > > > > >
> > > > > > > > > The quiet infrastructure was moved out of Makefile.build to accomidate
> > > > > > > > > the new syscall table generation scripts in perf. Syscall table
> > > > > > > > > generation wanted to also be able to be quiet, so instead of again
> > > > > > > > > copying the code to set the quiet variables, the code was moved into
> > > > > > > > > Makefile.perf to be used globally. This was not the right solution. It
> > > > > > > > > should have been moved even further upwards in the call chain.
> > > > > > > > > Makefile.include is imported in many files so this seems like a proper
> > > > > > > > > place to put it.
> > > > > > > > >
> > > > > > > > > To:
> > > > > > > > >
> > > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > > > ---
> > > > > > > > > Charlie Jenkins (2):
> > > > > > > > >       tools: Unify top-level quiet infrastructure
> > > > > > > > >       tools: Remove redundant quiet setup
> > > > > > > > >
> > > > > > > > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > > > > > > > >  tools/bpf/Makefile                        |  6 -----
> > > > > > > > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > > > > > > > >  tools/bpf/bpftool/Makefile                |  6 -----
> > > > > > > > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > > > > > > > >  tools/bpf/runqslower/Makefile             |  5 +---
> > > > > > > > >  tools/build/Makefile                      |  8 +-----
> > > > > > > > >  tools/lib/bpf/Makefile                    | 13 ----------
> > > > > > > >
> > > > > > > > Nack.
> > > > > > > > libbpf and bpftool are synced independently to github
> > > > > > > > and released from there.
> > > > > > > > This change breaks it.
> > > > > >
> > > > > > Sorry, I overlooked this part and merged a change that touched the
> > > > > > common files into the perf tree.
> > > > > >
> > > > > > f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in Makefile.perf")
> > > > > >
> > > > > > Unfortunately, it's already in v6.14-rc1.
> > > > > >
> > > > > > >
> > > > > > > Can you explain how it breaks it? Currently bpftool and resolve_btfids
> > > > > > > don't build quietly so this was an attempt to fix that.
> > > > > >
> > > > > > So I think you will need something like this for v6.14.  Again, sorry
> > > > > > about the trouble.
> > > > >
> > > > > Just revert f2868b1a66d4f40f that created this mess.
> > > >
> > > > Why are you opposed to unifying this helpers among the various projects
> > > > in tools? Can you explain what about this breaks the Github syncing flow
> > > > and why it cannot be resolved? It doesn't make sense to duplicate "Q="
> > > > in every Makefile anybody ever wants to add to tools just because bpf
> > > > syncing isn't robust.
> > >
> > > Alexei's concern about Github mirrors of bpftool and libbpf isn't
> > > valid. Github versions of those projects use their own independent
> > > Makefiles anyways, so your change doesn't break that aspect.
> > >
> > > But your change *does* break both libbpf's and bpftool's make output
> > > *in the kernel repo*. With this patch we basically don't have "quiet"
> > > mode anymore:
> > >
> > > $ git co f2868b1a66d4f40f07e985b0beead606b2753602
> > > HEAD is now at f2868b1a66d4 perf tools: Expose quiet/verbose variables
> > > in Makefile.perf
> > > $ git log --oneline -n1
> > > f2868b1a66d4 (HEAD) perf tools: Expose quiet/verbose variables in Makefile.perf
> > > $ pwd
> > > /home/andriin/linux/tools/lib/bpf
> > > $ make
> > >   gcc -Wp,-MD,/data/users/andriin/linux/tools/lib/bpf/staticobjs/.libbpf.o.d
> > > -Wp,-MT,/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o -g
> > > -O2 -std=gnu89 -Wbad-function-cast -Wdeclaration-after-statement
> > > -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations
> > > -Wmissing-prototypes -Wnested-externs -Wno-system-headers
> > > -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes
> > > -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat
> > > -Wno-type-limits -Wstrict-aliasing=3 -Wshadow -Wno-switch-enum -Werror
> > > -Wall -I/data/users/andriin/linux/tools/lib/bpf/
> > > -I/data/users/andriin/linux/tools/include
> > > -I/data/users/andriin/linux/tools/include/uapi
> > > -I/data/users/andriin/linux/tools/arch/x86/include -fvisibility=hidden
> > > -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D"BUILD_STR(s)=#s" -c -o
> > > /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o libbpf.c
> > > ^Cmake[2]: *** [/data/users/andriin/linux/tools/build/Makefile.build:86:
> > > /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o] Interrupt
> > > make[1]: *** [Makefile:165:
> > > /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf-in.o]
> > > Interrupt
> > > make: *** [Makefile:143: all] Interrupt
> > >
> > > $ git co HEAD~
> > > Previous HEAD position was f2868b1a66d4 perf tools: Expose
> > > quiet/verbose variables in Makefile.perf
> > > HEAD is now at e9cbc854d8b1 perf config: Add a function to set one
> > > variable in .perfconfig
> > > $ make
> > >   CC      /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o
> > > ^C
> > >
> > > So, can you please check and fix?
> >
> > I think I am misunderstanding what you are saying. The patch that we are
> > discussing on is the patch to fix this? You are showing the output from
> > the patch that is being fixed in this series.
> 
> Ah, it's me getting confused. It was the earlier perf commit that
> broke all this, makes sense. I just double-checked with your patches
> applied locally. It indeed fixes the issue, LGTM.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, b4 didn't pick this one, probably because you provided the Ack
for a previous version of this series, but the patch in it is the same
as in v2, so I'm keeping it, ok?

Also since you applied the patches and tested it, can I promote the tag
to Tested-by you?

Humm, there is a slight difference, checking that in the e-mails
thread...

+  quiet = quiet_
+  Q = @

The above doesn´t  have spaces surrounding the = sign, lemme see...

- Arnaldo

