Return-Path: <linux-kselftest+bounces-25742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7350A27F39
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 00:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645F118878C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 23:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC821C183;
	Tue,  4 Feb 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUk8M4eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11341FF7A5;
	Tue,  4 Feb 2025 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710177; cv=none; b=a9rHeG1jir3xBbmRh4SF7FD1FuyJD3hdh3AdTJ1wU/mleYi+cJultz7LJIm0AV/iqX1u8xBSVKmFasW/pkJv6S3HB9IXiaZHLJs8psh/Sxvzt01bOmEaP1zOEnXRE4UCivzAGCMMqM6XI2nC9prhoY8lDJse3wslLfj2VpoDS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710177; c=relaxed/simple;
	bh=4chpXDmqz5lXX5/+XxyEMN/H71iHm9gxiF5XFQT7cTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lo4pojSp+KSSj6KBxczUz3a0cMhaunv7JC70dnvJGjZpRTI24+lXhIgXOwV4IxzcWb5OfXa9ofH8FgAg314t8Z3FPxat0wfDG6+sDzXN4yspUaK1e1gXAqzYriv0QD+KLRymPM2AeF10Kjo9S2MjC3mUAyNKfsVxvR2l0qYgido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUk8M4eu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38db10ab86cso570510f8f.3;
        Tue, 04 Feb 2025 15:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738710174; x=1739314974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhWUg+d3sCFwJhzK5U92SB6xZl56i8PiqJiND+AD1bg=;
        b=dUk8M4eu1llzfiD1mVJ6Ij7draREF0DbUyY0v2MifbdaN9pfJ1+id0C9F8RBENijmR
         Lde0wrIb1iMsfbPIQ30jSp8aAlyuJrUu4YcLODXbmkNTrXeY+jCqf+hjBg7Emj4/tLy2
         iZPhITz8DnKBUwsgb86Y8/VHKNa9XAUrfCJkMAiH/3nsCRIZK0v5etZBA+xL3vLv7sKh
         TYI5DYYfgDJtvfhiN3KRe+D7Ngz7wVgNh2PP2icoOCWFRP4w2Gufo599ikK74FhwsVI+
         q/bbYXdb9vbRRaIkOa1+2fHNmolurGOcZ7ueDLSL8vwB09GAaU6hMKe238SMFRhYbz4S
         yZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738710174; x=1739314974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhWUg+d3sCFwJhzK5U92SB6xZl56i8PiqJiND+AD1bg=;
        b=BpScS6wa6YJRZWtOEY0csTwsg4fwINdiTT75V7F3LN6V4jALuK4nNrWhDcnLbYiGNl
         zXNpv9uRrYsqs7MHF9z8x8JraNQiUISOSAYnrrgvrXQxkvyApe/B24GWaudccvv8Nvrb
         zer1uPzJjjVJEgfFeQL4EMGXQEqALgr56LhXGOMbJmDRkAM6iPhr3wBa0QU4DsnoPl0d
         MvMEL0xaFCkBzFj12oivU/UEefiqSA1TO2oFHZxQzsGqqEynwiWrwYDgvIDvcMiy7S+8
         SMhXR7MJFdee8ngsIaj8wGEAZp1aZ65li822BVEKb31n6PXd3qaqB0YBgxzNYBxrRg4+
         UqSg==
X-Forwarded-Encrypted: i=1; AJvYcCVAnqCiaGVWifGgKYoB7x0gPXtO320m4pqcVol0p13/YpS6aapXP+M174AN2/i7WfPfe49Z8Z1R+A/II7aa@vger.kernel.org, AJvYcCW+aenhEO1n4RP9C1dUOxI1aWouTSN08kzUcI9g6x97Q90Cv/QwoZDg82TYbwIeuuIVLuGplnxXvZI9GCB6Bn96gD8p@vger.kernel.org, AJvYcCWNE8e38yv8wWzFJzoV/VjwG4mmNYLvLtvoN5w/TXGYUfpuwrrUN0wFmToYlyG4MmWVsE0oj08/0EY=@vger.kernel.org, AJvYcCWQjQKMWeFHjdyU6SwWuizR6nGKzjnbms51D13USRj7drF1es7dd1BpqXEFdGwiA8CU/OY=@vger.kernel.org, AJvYcCWYg2xlEOlBmTmp4fETDPmxigchcYB1vmLR1/5ho1xDh+9kbwL7OK7PubYDlOkOnZlbrDhlvd8tkXp6Dp6MC55q@vger.kernel.org, AJvYcCXFRfdv7qTzU9MjbaagtfI1PXvCCnCniPn1Oq0vJ+2jqB1sUFPRXBSN9n/UDGv1dMz1bfECq11kZWW4Uf1BkkXQqQ==@vger.kernel.org, AJvYcCXqkSQdQYBluuTHTrmrFVE7KGTREFyeS4iRQ3oIN9/0uFYYrG8ykQB2y9ZYOtIMnY5M6gedbUxMav27lmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydjOCPiah1msFc729uQoKSoVZFoTanL8+9y1AV4SQJIXD+e8z5
	Sydwq4vueWnJ5841tSBFBgJgeBoRM8WTPejTo1fzv+J75oC42FWqVRnKAZOhHtARJMPQE+vPNcS
	TuNFchsJ0XZCEwkMcpwGGANri5jM=
X-Gm-Gg: ASbGnctPPPItwq0EVanpqJGT0frvj3gXJtv4oDmYFIF4giQTq/vF/JBBMXVVS50FWv1
	wbDvidjBukLfLrIDUhPzD6ITkn6I9BrmAo3misoKiRSdN2oNwwprcvuwk7SEhCltw3ZB2RSCK
X-Google-Smtp-Source: AGHT+IGyAesYgSc23Slj9Jv3XtZGRWcCp0H3F9Kqsj8a9rDodsyQAVoifJDYZlGi89eBGwL+TzarCw79qmfJ114u8NM=
X-Received: by 2002:a5d:69c8:0:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-38db48f3787mr319907f8f.33.1738710173606; Tue, 04 Feb 2025
 15:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost> <Z6JksXDRh8OSAh-u@google.com>
In-Reply-To: <Z6JksXDRh8OSAh-u@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 23:02:42 +0000
X-Gm-Features: AWEUYZlmDbliSpI2sm1GIy7yJu4eHOxWwrFAjie_1pp1QQTtFuZzNJaDrMgxEhU
Message-ID: <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
To: Namhyung Kim <namhyung@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Tue, Feb 4, 2025 at 7:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> > On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> > > On Tue, Feb 4, 2025 at 12:10=E2=80=AFAM Charlie Jenkins <charlie@rivo=
sinc.com> wrote:
> > > >
> > > > The quiet infrastructure was moved out of Makefile.build to accomid=
ate
> > > > the new syscall table generation scripts in perf. Syscall table
> > > > generation wanted to also be able to be quiet, so instead of again
> > > > copying the code to set the quiet variables, the code was moved int=
o
> > > > Makefile.perf to be used globally. This was not the right solution.=
 It
> > > > should have been moved even further upwards in the call chain.
> > > > Makefile.include is imported in many files so this seems like a pro=
per
> > > > place to put it.
> > > >
> > > > To:
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > > Charlie Jenkins (2):
> > > >       tools: Unify top-level quiet infrastructure
> > > >       tools: Remove redundant quiet setup
> > > >
> > > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > > >  tools/bpf/Makefile                        |  6 -----
> > > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > > >  tools/bpf/bpftool/Makefile                |  6 -----
> > > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > > >  tools/bpf/runqslower/Makefile             |  5 +---
> > > >  tools/build/Makefile                      |  8 +-----
> > > >  tools/lib/bpf/Makefile                    | 13 ----------
> > >
> > > Nack.
> > > libbpf and bpftool are synced independently to github
> > > and released from there.
> > > This change breaks it.
>
> Sorry, I overlooked this part and merged a change that touched the
> common files into the perf tree.
>
> f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in Makefile=
.perf")
>
> Unfortunately, it's already in v6.14-rc1.
>
> >
> > Can you explain how it breaks it? Currently bpftool and resolve_btfids
> > don't build quietly so this was an attempt to fix that.
>
> So I think you will need something like this for v6.14.  Again, sorry
> about the trouble.

Just revert f2868b1a66d4f40f that created this mess.

