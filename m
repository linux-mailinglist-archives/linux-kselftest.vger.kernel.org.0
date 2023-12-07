Return-Path: <linux-kselftest+bounces-1376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A381C809113
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 20:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56811C20934
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0B4F5E9;
	Thu,  7 Dec 2023 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMWAIfXo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6E10F9;
	Thu,  7 Dec 2023 11:12:59 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso14529441fa.3;
        Thu, 07 Dec 2023 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701976377; x=1702581177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7L52bButApvPAe1l+vSFfVbgaHr8LHhwAbqHXZCi2I=;
        b=VMWAIfXoi1i7HFkBSZPZSpjFVb29QjWZFeQdCEiDhBsBM2oyOXFXd6+Jqyg7GrX7B+
         pobFwrlbsaFsJ6HtRAn262TSdiriJNEmNFtdgTkAVvrDhO8WQRUechtHxxXvlDoDXjP/
         12ICOAYkqEaWL6Oe6JFmmcqsSTRtru9NI4jrst/9yiQa9xIfU+k4cvDaRxePIZs4lm0D
         yGOT3J+pVeCr7UIV9QryfVA/94NA2S2UOT+n94m6Znt3hbGOOD1vj4uWy3MO51aahRdh
         RNHreeTslveH+HJ5mIr+k2XlHOhksItrAoaS+lQ/0C+hJjxvqfwMxwoP/wfs9UghUwwN
         IXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976377; x=1702581177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7L52bButApvPAe1l+vSFfVbgaHr8LHhwAbqHXZCi2I=;
        b=UlqIBOCuZEFYwW522C78E+9yC5XMBBNfoLR8YuPhKF9KytbOa0/QrjulrCzy/xeAas
         n8j62lxYKuYqQQTwMVCopgeOIaeg8QnDO8ykbniOZ9mstU3HJZU9H3hwNxPZF63Qul1B
         t2+NAyt4KvUTXVF7fxDjKwQeSo+NVKI+LAUi81Ur5lbCR40N3Ffg7dKRIg5s9jbpNles
         ANFVWXBl/VPvfr/c+emDVxFXQJ5o4w+Ruy7JdIxcKxhBDOZMatVFG2HSXXWXwUw0DfcH
         0XTaMJEXus0waq6DVsgppgW86sm2ybwO+bfU8hlMlCMa1KD9GA7U7Duu77QVxEYWOa+V
         U7gw==
X-Gm-Message-State: AOJu0YwPWWielJeZMvPegCLu5TZ49UDZD8rNKno8sd3rwxYUnSkCiwdH
	R6Bn8bIBVOQgIO214XE1ZlunrtzsoEzy/39hUs0=
X-Google-Smtp-Source: AGHT+IG1tPh8nbBAXvNAo40dCFKvu65nxH9hKddanqzjbPMoW+28Rh/cdC2azbaAgSR+xHsIuJQbhiLTTXKQYelmZws=
X-Received: by 2002:a2e:901a:0:b0:2c9:f776:e28f with SMTP id
 h26-20020a2e901a000000b002c9f776e28fmr928562ljg.120.1701976377304; Thu, 07
 Dec 2023 11:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
In-Reply-To: <20231207163458.5554-4-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Dec 2023 11:12:45 -0800
Message-ID: <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
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
>  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
>  2 files changed, 160 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_skip.c
> new file mode 100644
> index 000000000000..f6fa9bfd9efa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +/* We need the latest siginfo from the kernel repo. */
> +#include <asm/siginfo.h>

selftests are built with UAPI headers' copies under tools/include, so
CI did catch a real issue, I think. Try copying
include/uapi/asm-generic/siginfo.h into
tools/include/uapi/asm-generic/siginfo.h ?

> +#define __have_siginfo_t 1
> +#define __have_sigval_t 1
> +#define __have_sigevent_t 1
> +#define __siginfo_t_defined
> +#define __sigval_t_defined
> +#define __sigevent_t_defined
> +#define _BITS_SIGINFO_CONSTS_H 1
> +#define _BITS_SIGEVENT_CONSTS_H 1
> +
> +#include <test_progs.h>
> +#include "test_perf_skip.skel.h"
> +#include <linux/compiler.h>
> +#include <linux/hw_breakpoint.h>
> +#include <sys/mman.h>
> +
> +int signals_unexpected =3D 1;
> +int sigio_count, sigtrap_count;
> +
> +static void handle_sigio(int sig __always_unused)
> +{
> +       ASSERT_OK(signals_unexpected, "perf event not skipped");
> +       ++sigio_count;
> +}
> +
> +static void handle_sigtrap(int signum __always_unused,
> +                          siginfo_t *info,
> +                          void *ucontext __always_unused)
> +{
> +       ASSERT_OK(signals_unexpected, "perf event not skipped");
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
> +       // Configure the perf event to signal on sample.

please don't use C++ style comments

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
> +       // Allow at most one sample. A sample rejected by bpf should
> +       // not count against this.
> +       err =3D ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 1);
> +       if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
> +               goto cleanup;
> +
> +       prog_link =3D bpf_program__attach_perf_event(skel->progs.handler,=
 perf_fd);
> +       if (!ASSERT_OK_PTR(prog_link, "bpf_program__attach_perf_event"))
> +               goto cleanup;
> +
> +       // Configure the bpf program to suppress the sample.
> +       skel->bss->ip =3D (uintptr_t)test_function;
> +       test_function();
> +
> +       ASSERT_EQ(sigio_count, 0, "sigio_count");
> +       ASSERT_EQ(sigtrap_count, 0, "sigtrap_count");
> +
> +       // Configure the bpf program to allow the sample.
> +       skel->bss->ip =3D 0;
> +       signals_unexpected =3D 0;
> +       test_function();
> +
> +       ASSERT_EQ(sigio_count, 1, "sigio_count");
> +       ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
> +
> +       // Test that the sample above is the only one allowed (by perf, n=
ot
> +       // by bpf)
> +       test_function();
> +
> +       ASSERT_EQ(sigio_count, 1, "sigio_count");
> +       ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
> +
> +cleanup:
> +       if (prog_link)

nit: no need for a check, bpf_link__destroy() handles NULLs just fine

> +               bpf_link__destroy(prog_link);
> +       if (perf_fd >=3D 0)
> +               close(perf_fd);
> +       if (skel)
> +               test_perf_skip__destroy(skel);

same, no need for NULL check

> +
> +       signal(SIGIO, previous_sigio);
> +       sigaction(SIGTRAP, &previous_sigtrap, NULL);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/t=
esting/selftests/bpf/progs/test_perf_skip.c
> new file mode 100644
> index 000000000000..417a9db3b770
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
> +       // Skip events that have the correct ip.

C++ comments


> +       return ip !=3D PT_REGS_IP(&data->regs);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>

