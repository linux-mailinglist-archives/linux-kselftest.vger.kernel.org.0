Return-Path: <linux-kselftest+bounces-3220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD483227D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E842870AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBC81F;
	Fri, 19 Jan 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="bps6f9wA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB97389
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622928; cv=none; b=IolKw8iNhm0Ii46+5/je7CmG2bEJzFSolcOapsM3lvHF6smbzZeAJ8XrIOoRfkfFvdBO53Qcs0D9rhEO53i3tTuEYYvoXYMKNAoCXgA1XhUeA3gassODFhKEmaMKnkY0iyxbWNv6ipP/hZZRFGQvkA65d3TI4ZLdJpArgEVIhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622928; c=relaxed/simple;
	bh=Nl+g4tuaqCxOgaP3Iln3PLlQaui5SCReIL+qHRQfNC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKAkmVv0qV5ADm9L4TRtja5MOSIEoExyDdr8bQHuE1o95p1a6/CnWSlBdoaDpB1HWL+kN3rKK8WjcFhBWEtGA1BVbACrDwlxgELvP+qgrOhx6/aGWyPJn3AhEyZdPaN30ip+lxLjH9YcxioFLbO6QKxatQ3zeGE7kZc5m3PJOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=bps6f9wA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so3092601fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705622924; x=1706227724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkPMMIL6cG9Vww2U8ysDt1UGfqwAexusqourdf/9zpY=;
        b=bps6f9wAA0AU+KQiJVFMFH2DL2v0ct7AR3MMpIcZgczl8cr27GvuWteHqbOaE6k9Vm
         J9Vl6CfqIK7PPOB2wlkMTzzxcUbKSCoX1GJf72LsPgVMObKa2a0rhbIkTnYBHLusxEcT
         JvljttiDLwFuUN+tLjfMQP81YZIQD8+ki8rcy/kHlO74stkbYaJ39iF1F/OOFj4goRST
         vYzFM1/vFCmTKb82GmwdFAqg0NgCSc6y7B5XfhBOkWM0w4Hyj95vlTMwSwXPpBadZKbR
         SvNmXLTGBpplvnuPmFFnc85LMSMocnwcnDMmteVmunkSuvHzh1SL8XS9T4NjQZT7two7
         bu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622924; x=1706227724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkPMMIL6cG9Vww2U8ysDt1UGfqwAexusqourdf/9zpY=;
        b=ZohirhLbiAZYRxIjR9TTJEXqWTvMTuoeP27Z7mM2JMy8dAihm4N6jJ8EQ7lbU2wdCh
         2JMuV3l6NZxgmnqOJamGATIxggtew7BuO/kB62lbk9Upe12D++WPzXTx2PImamKO6t4M
         Ocs++aFAFI2IjT8tNBkl4yujb++X0NhSQbiUjFHiNnx1GTW2G0I6VNcJTepDuuu/CvAD
         dxbJaVVt6IyaOQRZ4nQ9NtvL3MVjapzVvv02C/MpFR5wsln7eDMeCm/WypkRK8nW9p0f
         TYRJKed0Q9DD2hAk01m4xXyb4DUtSwV6+jBGlzz6P1MlkE96Z0LlwbIU/KtkxSw2CIMD
         C8uA==
X-Gm-Message-State: AOJu0Yy8NYhkZxcJRCe2NDArNJI4CrVsp/hAlA40zkV7HvbxfYDXKoar
	jEysU4QPmI5tvls2eaMPW01nu0WjWHNhNRd1UL/nzcw0P9s0a6B7QG1sOjyDWjQ07pOjmeXp097
	zGHppWKTRe41gbnGW//Np6YnuGPZ3GQC+Jezg
X-Google-Smtp-Source: AGHT+IHB64Q4qh2RWUb4isRnAHtCK6Q9pIxFsYDwb6SY9a/ePbllFsxCV1Z7QOxrOiqE2y//IjAtR3g0wNaljLwkUsI=
X-Received: by 2002:a2e:2e0b:0:b0:2cc:7db2:acb5 with SMTP id
 u11-20020a2e2e0b000000b002cc7db2acb5mr877140lju.93.1705622923687; Thu, 18 Jan
 2024 16:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-5-khuey@kylehuey.com>
 <CAPhsuW7EU0nJq3fF_DqB3o7+5fuGZgs-W1jN1e4F4VHVjgj8Cg@mail.gmail.com>
In-Reply-To: <CAPhsuW7EU0nJq3fF_DqB3o7+5fuGZgs-W1jN1e4F4VHVjgj8Cg@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 18 Jan 2024 16:08:32 -0800
Message-ID: <CAP045ApRRLnKtN69wj32q7pgNGVzFrusoWDJOQzxJs3yUsCekw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Song Liu <song@kernel.org>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:49=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Sun, Dec 10, 2023 at 8:56=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote=
:
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
> >  .../selftests/bpf/prog_tests/perf_skip.c      | 140 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> >  2 files changed, 155 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools=
/testing/selftests/bpf/prog_tests/perf_skip.c
> > new file mode 100644
> > index 000000000000..0200736a8baf
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +
> > +#include <test_progs.h>
> > +#include "test_perf_skip.skel.h"
> > +#include <linux/compiler.h>
> > +#include <linux/hw_breakpoint.h>
> > +#include <sys/mman.h>
> > +
> > +#ifndef TRAP_PERF
> > +#define TRAP_PERF 6
> > +#endif
> > +
> > +int signals_unexpected =3D 1;
> > +int sigio_count, sigtrap_count;
> > +
> > +static void handle_sigio(int sig __always_unused)
> > +{
> > +       ASSERT_OK(signals_unexpected, "perf event not skipped");
>
> ASSERT_OK is a little confusing. Maybe do something like:
>
> static int signals_expected;
> static void handle_sigio(int sig __always_unused)
> {
>     ASSERT_EQ(signals_expected, 1, "expected sig_io");
> }
> serial_test_perf_skip()
> {
> ...
> signals_expected =3D 1;
> }
>

I'll just drop signals_expected. Now that I'm counting the exact
number of signals it's redundant.

> > +       ++sigio_count;
> > +}
> > +
> > +static void handle_sigtrap(int signum __always_unused,
> > +                          siginfo_t *info,
> > +                          void *ucontext __always_unused)
> > +{
> > +       ASSERT_OK(signals_unexpected, "perf event not skipped");
> ditto
>
> > +       ASSERT_EQ(info->si_code, TRAP_PERF, "wrong si_code");
> > +       ++sigtrap_count;
> > +}
> > +
> > +static noinline int test_function(void)
> > +{
> > +       asm volatile ("");
> > +       return 0;
> > +}
> > +
> > +void serial_test_perf_skip(void)
> > +{
> > +       struct sigaction action =3D {};
> > +       struct sigaction previous_sigtrap;
> > +       sighandler_t previous_sigio;
> > +       struct test_perf_skip *skel =3D NULL;
> > +       struct perf_event_attr attr =3D {};
> > +       int perf_fd =3D -1;
> > +       int err;
> > +       struct f_owner_ex owner;
> > +       struct bpf_link *prog_link =3D NULL;
> > +
> > +       action.sa_flags =3D SA_SIGINFO | SA_NODEFER;
> > +       action.sa_sigaction =3D handle_sigtrap;
> > +       sigemptyset(&action.sa_mask);
> > +       if (!ASSERT_OK(sigaction(SIGTRAP, &action, &previous_sigtrap), =
"sigaction"))
> > +               return;
> > +
> > +       previous_sigio =3D signal(SIGIO, handle_sigio);
>
> handle signal() errors here?

Addressed in v4.

> > +
> > +       skel =3D test_perf_skip__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "skel_load"))
> > +               goto cleanup;
> > +
> > +       attr.type =3D PERF_TYPE_BREAKPOINT;
> > +       attr.size =3D sizeof(attr);
> > +       attr.bp_type =3D HW_BREAKPOINT_X;
> > +       attr.bp_addr =3D (uintptr_t)test_function;
> > +       attr.bp_len =3D sizeof(long);
> > +       attr.sample_period =3D 1;
> > +       attr.sample_type =3D PERF_SAMPLE_IP;
> > +       attr.pinned =3D 1;
> > +       attr.exclude_kernel =3D 1;
> > +       attr.exclude_hv =3D 1;
> > +       attr.precise_ip =3D 3;
> > +       attr.sigtrap =3D 1;
> > +       attr.remove_on_exec =3D 1;
> > +
> > +       perf_fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> > +       if (perf_fd < 0 && (errno =3D=3D ENOENT || errno =3D=3D EOPNOTS=
UPP)) {
> > +               printf("SKIP:no PERF_TYPE_BREAKPOINT/HW_BREAKPOINT_X\n"=
);
> > +               test__skip();
> > +               goto cleanup;
> > +       }
> > +       if (!ASSERT_OK(perf_fd < 0, "perf_event_open"))
> > +               goto cleanup;
> > +
> > +       /* Configure the perf event to signal on sample. */
> > +       err =3D fcntl(perf_fd, F_SETFL, O_ASYNC);
> > +       if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
> > +               goto cleanup;
> > +
> > +       owner.type =3D F_OWNER_TID;
> > +       owner.pid =3D syscall(__NR_gettid);
> > +       err =3D fcntl(perf_fd, F_SETOWN_EX, &owner);
> > +       if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
> > +               goto cleanup;
> > +
> > +       /*
> > +        * Allow at most one sample. A sample rejected by bpf should
> > +        * not count against this.
> > +        */
>
> Multi-line comment style should be like

Addressed in v4.

>         /* Allow at most one sample. A sample rejected by bpf should
>         * not count against this.
>         */
>
> > +       err =3D ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 1);
> > +       if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
> > +               goto cleanup;
> > +
> > +       prog_link =3D bpf_program__attach_perf_event(skel->progs.handle=
r, perf_fd);
> > +       if (!ASSERT_OK_PTR(prog_link, "bpf_program__attach_perf_event")=
)
> > +               goto cleanup;
> > +
> > +       /* Configure the bpf program to suppress the sample. */
> > +       skel->bss->ip =3D (uintptr_t)test_function;
> > +       test_function();
> > +
> > +       ASSERT_EQ(sigio_count, 0, "sigio_count");
> > +       ASSERT_EQ(sigtrap_count, 0, "sigtrap_count");
> > +
> > +       /* Configure the bpf program to allow the sample. */
> > +       skel->bss->ip =3D 0;
> > +       signals_unexpected =3D 0;
> > +       test_function();
> > +
> > +       ASSERT_EQ(sigio_count, 1, "sigio_count");
> > +       ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
> > +
> > +       /*
> > +        * Test that the sample above is the only one allowed (by perf,=
 not
> > +        * by bpf)
> > +        */
>
> ditto.
>
> > +       test_function();
> > +
> > +       ASSERT_EQ(sigio_count, 1, "sigio_count");
> > +       ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
> > +
> > +cleanup:
> > +       bpf_link__destroy(prog_link);
> > +       if (perf_fd >=3D 0)
> > +               close(perf_fd);
> > +       test_perf_skip__destroy(skel);
> > +
> > +       signal(SIGIO, previous_sigio);
> > +       sigaction(SIGTRAP, &previous_sigtrap, NULL);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools=
/testing/selftests/bpf/progs/test_perf_skip.c
> > new file mode 100644
> > index 000000000000..7eb8b6de7a57
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +uintptr_t ip;
> > +
> > +SEC("perf_event")
> > +int handler(struct bpf_perf_event_data *data)
> > +{
> > +       /* Skip events that have the correct ip. */
> > +       return ip !=3D PT_REGS_IP(&data->regs);
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.34.1
> >

- Kyle

