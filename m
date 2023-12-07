Return-Path: <linux-kselftest+bounces-1378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03233809128
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45CB2816B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659464F5FE;
	Thu,  7 Dec 2023 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvzcUIHg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C10510DC
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 11:20:55 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4b2d64a368aso619194e0c.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701976854; x=1702581654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0eWtcC0cEcM+29fQ7DEe8bVrVzRsIkhiOsp8oEkDaY=;
        b=rvzcUIHg7wZJ+RvMeE2ejeRbC3cTv5KAPOdFW6HxPWOV7CLTrOhNeeJZukBRjD5cMC
         +wuEQhUMf4JhGwVwH5FYOJrYchfCy7Qz9CY6mpfm8cLdmNkTpQT+MB8eEDk2NKRUqWWu
         Yip8k1+XWTgSNNR76n1+suCRn7PQWK7UR32Sj0+PYSu9gKNAj7wMiGsd3RzcW79koX3J
         tj6jdZNNMCQg+e9gY66GY8Kz2ZqVT1IO42IkaF58M0ua+vclsBxNNu8EFq6lJ3bSbbfV
         gX2KqVkWWE9Ao3I1xNoh8HKce3giuEx/czRGuIPR/ZarpRrkstHpeZsjguCPCB46GVna
         BNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976854; x=1702581654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0eWtcC0cEcM+29fQ7DEe8bVrVzRsIkhiOsp8oEkDaY=;
        b=Qn8DSKVUlUr7E9eqxMdE2hVumdAWm/kFwhb3JaEnfcb/MMm5rbrmh2V5S98FQLyb8M
         5UQDng1S6qF0fhNuJ7US7Br1YHqppBvuydqlLMOMiFe3rWTlaipgA4N0o2pugLyi9gDx
         NzrKvZoWQWkuWlZxj3LwAbVtQIlzkHmupc3IWhjJCvND1iaqM50qTPwXGuJuxTGr4VH0
         a76HcmbCE1iK0y4W1vJM7WJNyIsCN6QWZ9ePNUpuKY6zhAURqZyr1ifuqa3HSp4Pd19/
         Yw+2/i4uqXEeagYvGPMcuVvdPv/8UE6MGlsWuC2vSvbBrecOnSbRR8OrLmn+RJXyexMU
         KnHA==
X-Gm-Message-State: AOJu0YwMaI+LDT8V+tZtYhcLRybnKByxri7M+WMh4kQCxA869pwv2iTy
	B07GErSfdqrVCvDOw8lUAXiLR9DR8ZsNbFXrb4hB8Q==
X-Google-Smtp-Source: AGHT+IFu6WULcTNGRYIvZNfvwgwLiezBZ0ERdRXmVUBophvomj9TjcnmYdxmZIS2cNuz5+rjMogaW8PNinZhFrhPmv0=
X-Received: by 2002:a1f:cc81:0:b0:48d:5be:2868 with SMTP id
 c123-20020a1fcc81000000b0048d05be2868mr2990447vkg.0.1701976854172; Thu, 07
 Dec 2023 11:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Dec 2023 20:20:16 +0100
Message-ID: <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
> >
> > The test sets a hardware breakpoint and uses a bpf program to suppress =
the
> > side effects of a perf event sample, including I/O availability signals=
,
> > SIGTRAPs, and decrementing the event counter limit, if the ip matches t=
he
> > expected value. Then the function with the breakpoint is executed multi=
ple
> > times to test that all effects behave as expected.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > ---
> >  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> >  2 files changed, 160 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools=
/testing/selftests/bpf/prog_tests/perf_skip.c
> > new file mode 100644
> > index 000000000000..f6fa9bfd9efa
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +
> > +/* We need the latest siginfo from the kernel repo. */
> > +#include <asm/siginfo.h>
>
> selftests are built with UAPI headers' copies under tools/include, so
> CI did catch a real issue, I think. Try copying
> include/uapi/asm-generic/siginfo.h into
> tools/include/uapi/asm-generic/siginfo.h ?

I believe parts of this were inspired by
tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
it's appropriate for this test though, if you don't want to add
KHDR_INCLUDES for everything.

