Return-Path: <linux-kselftest+bounces-25875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A040A29E4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 02:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA87A1972
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 01:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7238382;
	Thu,  6 Feb 2025 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ6pAlI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70242AD02;
	Thu,  6 Feb 2025 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805315; cv=none; b=RxILStN5zBhr08A1OsEi7esIBrRnbAldxzWrPo8u1NwZC/cADJU4KFMY+eRtnBZpT7LIQjn287W+HbGGaNhv6bCs4JH/uUBAtAAaNulqDn38eKgZ8hKppjqwPts33m6rI6P9Z8u7ex30b+ixCtsCPG9afVlxCT/bquuAgCuVeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805315; c=relaxed/simple;
	bh=clh2tfGXEKkbWkJuVRoDBfayvnFN0owsIXBdxYeNISk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhhqsRPD5uMc36bTql7NljO3XaU0clZLqbD8ha7l7Q/Wd3N2luiNzRABzJm13YPnmjpXHNPdnUyoR0czOtxu3PyYFdkzA1F+65op2PwaSg+omQC94Ih9xWiQV1ZDqP5eeEgn6WodTKIE/owzfXdSKajAh6knn92D4J0QSHdWjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ6pAlI9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166f1e589cso9735625ad.3;
        Wed, 05 Feb 2025 17:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738805313; x=1739410113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRvjh4lUXS/FqYAnsO+QmQYUHjBjCN0Nceh7ZqfHMtQ=;
        b=SQ6pAlI9BkVTkqEVD7VhUlnajP1ySgf3sFAGDCm1Qkja/8bLWXKHkzjs1a9LRE5rIG
         SQeQPR5k7EjWERy+hcJhcs9lJabogecDKUH9+wE+1pOuA0XUKTt+/JaFzQ6qhKRJYMvf
         WcYYLdh2WwjLxO0SA3/h1JitBCnxtiM0tjbo4r+OxmrUImhiyeGp9YQ5xFKSUn6d1VGR
         9tksp+B6zvNV9ZHxI1KPrH6sjqjfknxu+4j2G8P6WUQno/gKl/XgxzPdIQy2L1djcn1q
         HEirOyh1w3V0r+mvmmRas2X8R5DrGV9B4rbIt71dya51+2R9bJ4n9rWW5Vlxai0Mchwq
         QEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738805313; x=1739410113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRvjh4lUXS/FqYAnsO+QmQYUHjBjCN0Nceh7ZqfHMtQ=;
        b=CBRrfuSpuhQ33ouXabseDNxYGzL8dRhsXrpnHzp1+Xbw2+nn7lbg4FSZ+DXHIPhecX
         DOTzN7JZywWKws2k9/SMsE3/Tfv084c4YZ6blqoFWdxzPFmyD/nVvf4X02UqzzpYyWHU
         JDNFMkX8RjANI+Fir7CLf+dMLaycpAtMVJUJxkZtQT0LOcJUw5NyEpzro65Y4FDEzZHQ
         +lBnGbXCcELB5WuBDRj3LGpLVJP1tN9BJeApdKnTBYNWPlMQcyC9SkMgO0lIsm2bWaSq
         9N3x+Aa2yr3Cm68cCkmQrUWm5cbPWn4JAtudsa4FTSqXYByncfypV4QIEvQpwfUFXM05
         6HMg==
X-Forwarded-Encrypted: i=1; AJvYcCUTxgY6hlNJuwhaRuaNNqmZMLLtTgPE3vtUb57fRtU4TIrvDmUlB8lU4ic5PWHtDsNK0uY=@vger.kernel.org, AJvYcCUsVOGNRNxZPpUKo7xu+TcWxXN+vxmojtI6ajukmiAR9ixp7bx2zcye2/B5LwcmeHBG0DrBVLwiy8bixCr2ZQEZ@vger.kernel.org, AJvYcCWFbB53Zkkwl5xYEWVRgjXn7LLqyNk2MhvQi12tYMhKgTEe7p7nGBA66QLNs6LGKOG+LWhUCly3IOlZRrdT6nBaqA==@vger.kernel.org, AJvYcCWWQR0/RQ2yJe/eyanSdlovSfvNZULBvvGmraT73mnYwWcXnbvEozu+2z+WdGhy8fYKNh2icIGnewtjFkMdsbc7fggT@vger.kernel.org, AJvYcCXCwfA9byXJC2JtL+eNRqDtzdYsLvcOvZqJzyawOhMZ5/V+uxoY3L44mj8iLVwTgSLei0zAeXVRXz14XuU=@vger.kernel.org, AJvYcCXcmMDVmJG6a6q3sf6+9h9mxbN8fnzTaThRyQ+rESAWmguVZSzbS9XTmIG6PXii+fEFVMHGt94j/O7CNiIc@vger.kernel.org, AJvYcCXm4l+FEs5zGxy49SCkD9SYNmn/k21Y3GZiXwJRluz+vbhQVpTKWkc47KbD9pG0R+V+7be0N9liwyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxP8iyNLY/eeUL5tKR9E80pqBh5KjHUm9yIjF9qlym+VPsVxF
	CaFgIFEkW+bbn+N/xfScAD0XRBE1RipIwXYKp9FDVzK4IzIh3NYXtMMFOJkWhDK6bIfkJBng0Oh
	WinPlf/lKFPUlpq9t6zIESeo22As=
X-Gm-Gg: ASbGncttxrELntXGbXo4U4ZGng8uYEIG6+PnmKANHCFubMMFIWxQkCk06ESfx2CJn5i
	G12rvWcYBP8jeCcj9e+Wda2Esb7kjsvkf1A9IBlO6+2+knKLMUmM8Z98BTnA+pFV266k9o1oa3P
	k3rVyAvv4ZtziF
X-Google-Smtp-Source: AGHT+IHbBLU9Yp+KgnLDKo9nDxmvDiMpB2P2eCS3pSqU+ciOVfvltT7NgM9NDohKwcgz1sTHUPwVZ1B1B8ZxWNOrSek=
X-Received: by 2002:a05:6a20:c78d:b0:1e6:5323:58d1 with SMTP id
 adf61e73a8af0-1ede88aa5dcmr8780768637.26.1738805312996; Wed, 05 Feb 2025
 17:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost> <Z6JksXDRh8OSAh-u@google.com> <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
 <Z6Khl1rHIAb7wOXw@ghost>
In-Reply-To: <Z6Khl1rHIAb7wOXw@ghost>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 17:28:19 -0800
X-Gm-Features: AWEUYZlPBcKhnlnzEHzYVL21RVck5Pbw-X3QYTAmjmTe7rjtAGdrSN0T9YRAupA
Message-ID: <CAEf4Bza5nKk6_fVY2vmJjZgPb40zB+R3REy8==ZLc98eg1iHTA@mail.gmail.com>
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

On Tue, Feb 4, 2025 at 3:24=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Tue, Feb 04, 2025 at 11:02:42PM +0000, Alexei Starovoitov wrote:
> > On Tue, Feb 4, 2025 at 7:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hello,
> > >
> > > On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> > > > On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> > > > > On Tue, Feb 4, 2025 at 12:10=E2=80=AFAM Charlie Jenkins <charlie@=
rivosinc.com> wrote:
> > > > > >
> > > > > > The quiet infrastructure was moved out of Makefile.build to acc=
omidate
> > > > > > the new syscall table generation scripts in perf. Syscall table
> > > > > > generation wanted to also be able to be quiet, so instead of ag=
ain
> > > > > > copying the code to set the quiet variables, the code was moved=
 into
> > > > > > Makefile.perf to be used globally. This was not the right solut=
ion. It
> > > > > > should have been moved even further upwards in the call chain.
> > > > > > Makefile.include is imported in many files so this seems like a=
 proper
> > > > > > place to put it.
> > > > > >
> > > > > > To:
> > > > > >
> > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > ---
> > > > > > Charlie Jenkins (2):
> > > > > >       tools: Unify top-level quiet infrastructure
> > > > > >       tools: Remove redundant quiet setup
> > > > > >
> > > > > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > > > > >  tools/bpf/Makefile                        |  6 -----
> > > > > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > > > > >  tools/bpf/bpftool/Makefile                |  6 -----
> > > > > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > > > > >  tools/bpf/runqslower/Makefile             |  5 +---
> > > > > >  tools/build/Makefile                      |  8 +-----
> > > > > >  tools/lib/bpf/Makefile                    | 13 ----------
> > > > >
> > > > > Nack.
> > > > > libbpf and bpftool are synced independently to github
> > > > > and released from there.
> > > > > This change breaks it.
> > >
> > > Sorry, I overlooked this part and merged a change that touched the
> > > common files into the perf tree.
> > >
> > > f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in Make=
file.perf")
> > >
> > > Unfortunately, it's already in v6.14-rc1.
> > >
> > > >
> > > > Can you explain how it breaks it? Currently bpftool and resolve_btf=
ids
> > > > don't build quietly so this was an attempt to fix that.
> > >
> > > So I think you will need something like this for v6.14.  Again, sorry
> > > about the trouble.
> >
> > Just revert f2868b1a66d4f40f that created this mess.
>
> Why are you opposed to unifying this helpers among the various projects
> in tools? Can you explain what about this breaks the Github syncing flow
> and why it cannot be resolved? It doesn't make sense to duplicate "Q=3D"
> in every Makefile anybody ever wants to add to tools just because bpf
> syncing isn't robust.

Alexei's concern about Github mirrors of bpftool and libbpf isn't
valid. Github versions of those projects use their own independent
Makefiles anyways, so your change doesn't break that aspect.

But your change *does* break both libbpf's and bpftool's make output
*in the kernel repo*. With this patch we basically don't have "quiet"
mode anymore:

$ git co f2868b1a66d4f40f07e985b0beead606b2753602
HEAD is now at f2868b1a66d4 perf tools: Expose quiet/verbose variables
in Makefile.perf
$ git log --oneline -n1
f2868b1a66d4 (HEAD) perf tools: Expose quiet/verbose variables in Makefile.=
perf
$ pwd
/home/andriin/linux/tools/lib/bpf
$ make
  gcc -Wp,-MD,/data/users/andriin/linux/tools/lib/bpf/staticobjs/.libbpf.o.=
d
-Wp,-MT,/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o -g
-O2 -std=3Dgnu89 -Wbad-function-cast -Wdeclaration-after-statement
-Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wno-system-headers
-Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes
-Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat
-Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno-switch-enum -Werror
-Wall -I/data/users/andriin/linux/tools/lib/bpf/
-I/data/users/andriin/linux/tools/include
-I/data/users/andriin/linux/tools/include/uapi
-I/data/users/andriin/linux/tools/arch/x86/include -fvisibility=3Dhidden
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D"BUILD_STR(s)=3D#s" -c -o
/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o libbpf.c
^Cmake[2]: *** [/data/users/andriin/linux/tools/build/Makefile.build:86:
/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o] Interrupt
make[1]: *** [Makefile:165:
/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf-in.o]
Interrupt
make: *** [Makefile:143: all] Interrupt

$ git co HEAD~
Previous HEAD position was f2868b1a66d4 perf tools: Expose
quiet/verbose variables in Makefile.perf
HEAD is now at e9cbc854d8b1 perf config: Add a function to set one
variable in .perfconfig
$ make
  CC      /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o
^C

So, can you please check and fix?

Also, looking at your patch:

a) you removed the `"$(origin V)", "command line"` check from both
perf and libbpf, so that's not really an equivalent change/behavior
now

b) a bit sloppy on assignment:

+ifeq ($(V),1)
+  quiet =3D
+  Q =3D
+else
+  quiet=3Dquiet_
+  Q=3D@
+endif

note the spaces around '=3D', try to keep stuff like this consistent
(and if this was shell, it would bite you as well)

>
> - Charlie
>

