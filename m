Return-Path: <linux-kselftest+bounces-2593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E28224F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 23:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4F21F2277D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914B171D9;
	Tue,  2 Jan 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GABLzOHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DD17725;
	Tue,  2 Jan 2024 22:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDBAC433C9;
	Tue,  2 Jan 2024 22:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704235767;
	bh=T55WCsDDBMdV44KiSumuwswipm/mouhybrbqOhV7kkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GABLzOHTEGGqdIiCGunbjc+duSdiwfQMRPKVlMit9ewdi3H+HlL/Kw/sbaR4FAMkY
	 AF4FFcpa2skkuxiGHI7HOHf/kW/O+CM6hPLvPpQOZ+5i6utTUl4wdl5oPqXUSLLLYY
	 CGQfPnmQLLWMWoM2nWjIf8YoufUCISHlPF+x7F7yY1SfFinwZ31zxzN3SxH7Volg+V
	 +iHwhQgvoVZ9OrakOgl/Q4GTqj4zpGTXFJ+iK7gQ7wuHzro27L17bt1fkryw+UfMrG
	 ImxbP2fWoROXbtZCPU/Vx1wqHDimLRR41Xfn1144wl5YFsSOak2SL5RHg+BbR0yqZv
	 GGbyaf2VG5z9g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7aed08f4so6375751e87.0;
        Tue, 02 Jan 2024 14:49:27 -0800 (PST)
X-Gm-Message-State: AOJu0YywjJGIapn3Kl8qbv/9z98UGtP+JD0FwP7Vp1m/GqKsoVatUgkw
	vrahiyCe/jlEvChU/7QlOsUDjC/qZvY2J2wqv9c=
X-Google-Smtp-Source: AGHT+IE4onFQu2m3/yigoFFipvmSg5RKz59Ta3rrI6N6ihY71iQrMqWiWYr7mDijLk2toIJ6FkK8bbsppHiFhIs1/Po=
X-Received: by 2002:a05:6512:398a:b0:50e:15d4:7f8c with SMTP id
 j10-20020a056512398a00b0050e15d47f8cmr86449lfu.27.1704235765634; Tue, 02 Jan
 2024 14:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-5-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-5-khuey@kylehuey.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 14:49:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7EU0nJq3fF_DqB3o7+5fuGZgs-W1jN1e4F4VHVjgj8Cg@mail.gmail.com>
Message-ID: <CAPhsuW7EU0nJq3fF_DqB3o7+5fuGZgs-W1jN1e4F4VHVjgj8Cg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Kyle Huey <me@kylehuey.com>
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

On Sun, Dec 10, 2023 at 8:56=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> The test sets a hardware breakpoint and uses a bpf program to suppress th=
e
> side effects of a perf event sample, including I/O availability signals,
> SIGTRAPs, and decrementing the event counter limit, if the ip matches the
> expected value. Then the function with the breakpoint is executed multipl=
e
> times to test that all effects behave as expected.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  .../selftests/bpf/prog_tests/perf_skip.c      | 140 ++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
>  2 files changed, 155 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_skip.c
> new file mode 100644
> index 000000000000..0200736a8baf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <test_progs.h>
> +#include "test_perf_skip.skel.h"
> +#include <linux/compiler.h>
> +#include <linux/hw_breakpoint.h>
> +#include <sys/mman.h>
> +
> +#ifndef TRAP_PERF
> +#define TRAP_PERF 6
> +#endif
> +
> +int signals_unexpected =3D 1;
> +int sigio_count, sigtrap_count;
> +
> +static void handle_sigio(int sig __always_unused)
> +{
> +       ASSERT_OK(signals_unexpected, "perf event not skipped");

ASSERT_OK is a little confusing. Maybe do something like:

static int signals_expected;
static void handle_sigio(int sig __always_unused)
{
    ASSERT_EQ(signals_expected, 1, "expected sig_io");
}
serial_test_perf_skip()
{
...
signals_expected =3D 1;
}

> +       ++sigio_count;
> +}
> +
> +static void handle_sigtrap(int signum __always_unused,
> +                          siginfo_t *info,
> +                          void *ucontext __always_unused)
> +{
> +       ASSERT_OK(signals_unexpected, "perf event not skipped");
ditto

> +       ASSERT_EQ(info->si_code, TRAP_PERF, "wrong si_code");
> +       ++sigtrap_count;
> +}
> +
> +static noinline int test_function(void)
> +{
> +       asm volatile ("");
> +       return 0;
> +}
> +
> +void serial_test_perf_skip(void)
> +{
> +       struct sigaction action =3D {};
> +       struct sigaction previous_sigtrap;
> +       sighandler_t previous_sigio;
> +       struct test_perf_skip *skel =3D NULL;
> +       struct perf_event_attr attr =3D {};
> +       int perf_fd =3D -1;
> +       int err;
> +       struct f_owner_ex owner;
> +       struct bpf_link *prog_link =3D NULL;
> +
> +       action.sa_flags =3D SA_SIGINFO | SA_NODEFER;
> +       action.sa_sigaction =3D handle_sigtrap;
> +       sigemptyset(&action.sa_mask);
> +       if (!ASSERT_OK(sigaction(SIGTRAP, &action, &previous_sigtrap), "s=
igaction"))
> +               return;
> +
> +       previous_sigio =3D signal(SIGIO, handle_sigio);

handle signal() errors here?

> +
> +       skel =3D test_perf_skip__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_load"))
> +               goto cleanup;
> +
> +       attr.type =3D PERF_TYPE_BREAKPOINT;
> +       attr.size =3D sizeof(attr);
> +       attr.bp_type =3D HW_BREAKPOINT_X;
> +       attr.bp_addr =3D (uintptr_t)test_function;
> +       attr.bp_len =3D sizeof(long);
> +       attr.sample_period =3D 1;
> +       attr.sample_type =3D PERF_SAMPLE_IP;
> +       attr.pinned =3D 1;
> +       attr.exclude_kernel =3D 1;
> +       attr.exclude_hv =3D 1;
> +       attr.precise_ip =3D 3;
> +       attr.sigtrap =3D 1;
> +       attr.remove_on_exec =3D 1;
> +
> +       perf_fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> +       if (perf_fd < 0 && (errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUP=
P)) {
> +               printf("SKIP:no PERF_TYPE_BREAKPOINT/HW_BREAKPOINT_X\n");
> +               test__skip();
> +               goto cleanup;
> +       }
> +       if (!ASSERT_OK(perf_fd < 0, "perf_event_open"))
> +               goto cleanup;
> +
> +       /* Configure the perf event to signal on sample. */
> +       err =3D fcntl(perf_fd, F_SETFL, O_ASYNC);
> +       if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
> +               goto cleanup;
> +
> +       owner.type =3D F_OWNER_TID;
> +       owner.pid =3D syscall(__NR_gettid);
> +       err =3D fcntl(perf_fd, F_SETOWN_EX, &owner);
> +       if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
> +               goto cleanup;
> +
> +       /*
> +        * Allow at most one sample. A sample rejected by bpf should
> +        * not count against this.
> +        */

Multi-line comment style should be like

        /* Allow at most one sample. A sample rejected by bpf should
        * not count against this.
        */

> +       err =3D ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 1);
> +       if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
> +               goto cleanup;
> +
> +       prog_link =3D bpf_program__attach_perf_event(skel->progs.handler,=
 perf_fd);
> +       if (!ASSERT_OK_PTR(prog_link, "bpf_program__attach_perf_event"))
> +               goto cleanup;
> +
> +       /* Configure the bpf program to suppress the sample. */
> +       skel->bss->ip =3D (uintptr_t)test_function;
> +       test_function();
> +
> +       ASSERT_EQ(sigio_count, 0, "sigio_count");
> +       ASSERT_EQ(sigtrap_count, 0, "sigtrap_count");
> +
> +       /* Configure the bpf program to allow the sample. */
> +       skel->bss->ip =3D 0;
> +       signals_unexpected =3D 0;
> +       test_function();
> +
> +       ASSERT_EQ(sigio_count, 1, "sigio_count");
> +       ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
> +
> +       /*
> +        * Test that the sample above is the only one allowed (by perf, n=
ot
> +        * by bpf)
> +        */

ditto.

> +       test_function();
> +
> +       ASSERT_EQ(sigio_count, 1, "sigio_count");
> +       ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
> +
> +cleanup:
> +       bpf_link__destroy(prog_link);
> +       if (perf_fd >=3D 0)
> +               close(perf_fd);
> +       test_perf_skip__destroy(skel);
> +
> +       signal(SIGIO, previous_sigio);
> +       sigaction(SIGTRAP, &previous_sigtrap, NULL);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/t=
esting/selftests/bpf/progs/test_perf_skip.c
> new file mode 100644
> index 000000000000..7eb8b6de7a57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +uintptr_t ip;
> +
> +SEC("perf_event")
> +int handler(struct bpf_perf_event_data *data)
> +{
> +       /* Skip events that have the correct ip. */
> +       return ip !=3D PT_REGS_IP(&data->regs);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>

