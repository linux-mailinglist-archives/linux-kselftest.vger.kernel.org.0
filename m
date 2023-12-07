Return-Path: <linux-kselftest+bounces-1384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF38095F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 23:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236EA282262
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 22:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078E4EB44;
	Thu,  7 Dec 2023 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ZzL86qJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC45D5B
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 14:56:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so2005103a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 14:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701989797; x=1702594597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8KHLtHH4WNh+QXN6kc7aahYVUG270dPfHT/RdEW5u0=;
        b=ZzL86qJng+3fHmP/aBqy4ekfvfgORNT1Yf2EYqzaIQcq34ywWvWcKN8e2QGlHuYCZ6
         8jonRyPc+HrdC8PewEWFyfp9/lHiMO3Ll+Ho0ytRqizoL1kA0XJUqxFCI8oCElJpngeu
         jr/fpHrS22pIdetomaQ/QVZV4zEm6Bb4T78Bn2W19Y7p8zBlIpHi3DrmNRXShIhZF49n
         DagQ1TaP7NgVwCRsgdPfTgx4Mob+NDQZ6EVpQEa/O1iEUN/1/yolw2NGIgajXVtXUC1K
         LnN9Z3FDKfJqGg7xWhKZun0q//gRsuQTrjRdi6+2ZARtliBhXqCQ4K6q2EuqxW7LAeKY
         XjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989797; x=1702594597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8KHLtHH4WNh+QXN6kc7aahYVUG270dPfHT/RdEW5u0=;
        b=GGckLd5tLS+wSzMZ1Z3e0rzfGGaz2AlTk4Xd5Xes4+aM3RnJ42rSrfUM+LBG8ApDHo
         f4vjO4qUCjHcnzrZl5yrz+1GQQ0YTuPmSRU1amgKJtA7+5jZOd47U9kyQ5hFk6+VmExW
         8RWe5QlF6TNoJ5pc5d6d7rGPeozNYnjjU7yE535G2ps5BGfA6MpnCJKpG1dwjtLhEJTU
         T82F7Qo8RCYmvwI75lg5H6KEx1eeUEHywkCB76pFjw6KTxUYcDyCPfD2tXILWPTjJv5U
         gnbyZTirdZceHPVpl+R//Ci0meO0YUNi2NMZpHcCzG9LJMLXsmctemuzxp8s9IbLu/9O
         ynPA==
X-Gm-Message-State: AOJu0YzTdPxekp8NXpAIdRdf39A0MKRzJUkoW56zNezH3k2XGoWIypC7
	+qDJs7MkEDGdaEiiqAJ9YzlfJHVeTzXcjnHc3X8eu0BWtAifPGIAl4pSKQ==
X-Google-Smtp-Source: AGHT+IEdoF7KAFAaeGCc04wLQPAo395XNvhWmc+nq3HXCLA5Mnhbr4KpyZ344lBtTUjMdBzv10YT7bqoTQvku1ozIok=
X-Received: by 2002:a17:906:a851:b0:9fa:ca0c:ac42 with SMTP id
 dx17-20020a170906a85100b009faca0cac42mr1980630ejb.64.1701989796632; Thu, 07
 Dec 2023 14:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com> <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
In-Reply-To: <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 7 Dec 2023 14:56:24 -0800
Message-ID: <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Marco Elver <elver@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kyle Huey <khuey@kylehuey.com>, 
	linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 11:20=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrot=
e:
> > >
> > > The test sets a hardware breakpoint and uses a bpf program to suppres=
s the
> > > side effects of a perf event sample, including I/O availability signa=
ls,
> > > SIGTRAPs, and decrementing the event counter limit, if the ip matches=
 the
> > > expected value. Then the function with the breakpoint is executed mul=
tiple
> > > times to test that all effects behave as expected.
> > >
> > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++++=
++
> > >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> > >  2 files changed, 160 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.=
c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.=
c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_skip.c
> > > new file mode 100644
> > > index 000000000000..f6fa9bfd9efa
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > @@ -0,0 +1,145 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#define _GNU_SOURCE
> > > +
> > > +/* We need the latest siginfo from the kernel repo. */
> > > +#include <asm/siginfo.h>
> >
> > selftests are built with UAPI headers' copies under tools/include, so
> > CI did catch a real issue, I think. Try copying
> > include/uapi/asm-generic/siginfo.h into
> > tools/include/uapi/asm-generic/siginfo.h ?
>
> I believe parts of this were inspired by
> tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
> kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
> CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
> it's appropriate for this test though, if you don't want to add
> KHDR_INCLUDES for everything.

Yes, that's right. Namhyung's commit message for 91c97b36bd69 leads me
to believe that I should copy siginfo.h over into tools/include and
fix the perf_events self tests too.

- Kyle

