Return-Path: <linux-kselftest+bounces-1092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A513804165
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 23:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510BB1F212F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC13A8CA;
	Mon,  4 Dec 2023 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBcrlt+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D560FF;
	Mon,  4 Dec 2023 14:15:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1a5772b8a5so363454966b.1;
        Mon, 04 Dec 2023 14:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728098; x=1702332898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT5ING78Aw6QvaBr7RPKXeEm1alnh4pQOnp24KNcG6U=;
        b=LBcrlt+MKjEO3c31uU2GKLPLSDABi1fW5KFcLhihgKg3/4NIz0K0I0sn0nT/sIiwe9
         7KhY/zMJWyRWpoCxmZF6Sm84vz6Ie0tWoHIOSR1NVoWHB+8pTnhM+P4f1fkU0lt3qW6v
         B/nMBm3PptrsYM3tlMp+JoK3BBC6d3VH9AP8visDYkeyFtFc0dUoaFpSQmGnOwYpgNmi
         zm05yPVl2uyF1VcRUrUOj3u+Z7zXEO/0N4ZS/XzjfmO8yBIobBKlPV+3DDQs/EhxxqmF
         c+aN7EkQarbEYUkvYqzRnjhlLi0K5I3JMlX720yy4wrh+R7/FrXzj7lFI5Yeeaqhcv5D
         BULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728098; x=1702332898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT5ING78Aw6QvaBr7RPKXeEm1alnh4pQOnp24KNcG6U=;
        b=w/NrVxx3J3XPJaWwZmCON9oTi9CWh/jeaUiHtQmZY1T1GnvJ891gTD8IcY+ciCgLNh
         cf+9srdRa5Rh5SVc1Bqrz8/SqTNaXL7Cql51jhT1BNUEiV6CtgwEW+P9efkOiirPXwbw
         45klZb6z+H6IaAsWcsOO/0tOdEj8ehE65kDyCz+J7KvXDCi079LGueQ3VRDat5GoZjEO
         6ElP++dhI8XBlBkrYhsvB5ThN5X3508SqREFs7hh0WN10VGlQHqaekjphT+LyxpURGET
         jiwEPk1JOMyY9mGUxc642be2Dn3HYSZYhePap/4YONMwJKuFiDGxJTL0ICV5deHetAaW
         dsZg==
X-Gm-Message-State: AOJu0YyQXHWH+sBdOahJXXt2bYEgIkXH+n2Bj9zqG4kEidFejvjOUk22
	F9eJvKylFq5m6FJDajGQTay3kDjf9mfmpi8EkGJWZ8YWyzk=
X-Google-Smtp-Source: AGHT+IFoeGilC7KQ6Unb3jfilMiyCDHGb3JBCgBI+bgOUtA4U8OnYlGMdCUBhy2PrVAbC60n5Rk0rZxYScsgRykKnXE=
X-Received: by 2002:a17:906:74c2:b0:a19:a19b:78ac with SMTP id
 z2-20020a17090674c200b00a19a19b78acmr2117622ejl.111.1701728098257; Mon, 04
 Dec 2023 14:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-3-khuey@kylehuey.com>
In-Reply-To: <20231204201406.341074-3-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 14:14:46 -0800
Message-ID: <CAEf4BzbDKiP7femK5DZ8jeyK0u63KrV+FogEDVPaYS7mc4if7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftest/bpf: Test returning zero from a perf bpf
 program suppresses SIGIO.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	"Robert O'Callahan" <robert@ocallahan.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> The test sets a hardware breakpoint and uses a bpf program to suppress th=
e
> I/O availability signal if the ip matches the expected value.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  .../selftests/bpf/prog_tests/perf_skip.c      | 95 +++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_skip.c      | 23 +++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_skip.c
> new file mode 100644
> index 000000000000..b269a31669b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <test_progs.h>
> +#include "test_perf_skip.skel.h"
> +#include <linux/hw_breakpoint.h>
> +#include <sys/mman.h>
> +
> +#define BPF_OBJECT            "test_perf_skip.bpf.o"

leftover?

> +
> +static void handle_sig(int)
> +{
> +       ASSERT_OK(1, "perf event not skipped");
> +}
> +
> +static noinline int test_function(void)
> +{

please add

asm volatile ("");

here to prevent compiler from actually inlining at the call site

> +       return 0;
> +}
> +
> +void serial_test_perf_skip(void)
> +{
> +       sighandler_t previous;
> +       int duration =3D 0;
> +       struct test_perf_skip *skel =3D NULL;
> +       int map_fd =3D -1;
> +       long page_size =3D sysconf(_SC_PAGE_SIZE);
> +       uintptr_t *ip =3D NULL;
> +       int prog_fd =3D -1;
> +       struct perf_event_attr attr =3D {0};
> +       int perf_fd =3D -1;
> +       struct f_owner_ex owner;
> +       int err;
> +
> +       previous =3D signal(SIGIO, handle_sig);
> +
> +       skel =3D test_perf_skip__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_load"))
> +               goto cleanup;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.handler);
> +       if (!ASSERT_OK(prog_fd < 0, "bpf_program__fd"))
> +               goto cleanup;
> +
> +       map_fd =3D bpf_map__fd(skel->maps.ip);
> +       if (!ASSERT_OK(map_fd < 0, "bpf_map__fd"))
> +               goto cleanup;
> +
> +       ip =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, =
map_fd, 0);
> +       if (!ASSERT_OK_PTR(ip, "mmap bpf map"))
> +               goto cleanup;
> +
> +       *ip =3D (uintptr_t)test_function;
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
> +
> +       perf_fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> +       if (CHECK(perf_fd < 0, "perf_event_open", "err %d\n", perf_fd))

please don't use CHECK() macro, stick to ASSERT_xxx()

also, we are going to run all this on different hardware and VMs, see
how we skip tests if hardware support is not there. See test__skip
usage in prog_tests/perf_branches.c, as one example

> +               goto cleanup;
> +
> +       err =3D fcntl(perf_fd, F_SETFL, O_ASYNC);

I assume this is what will send SIGIO, right? Can you add a small
comment explicitly saying this?

> +       if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
> +               goto cleanup;
> +
> +       owner.type =3D F_OWNER_TID;
> +       owner.pid =3D gettid();
> +       err =3D fcntl(perf_fd, F_SETOWN_EX, &owner);
> +       if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
> +               goto cleanup;
> +
> +       err =3D ioctl(perf_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> +       if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_SET_BPF)"))
> +               goto cleanup;

we have a better way to do this, please use
bpf_program__attach_perf_event() instead

> +
> +       test_function();
> +
> +cleanup:
> +       if (perf_fd >=3D 0)
> +               close(perf_fd);
> +       if (ip)
> +               munmap(ip, page_size);
> +       if (skel)
> +               test_perf_skip__destroy(skel);
> +
> +       signal(SIGIO, previous);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/t=
esting/selftests/bpf/progs/test_perf_skip.c
> new file mode 100644
> index 000000000000..ef01a9161afe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __uint(map_flags, BPF_F_MMAPABLE);
> +       __type(key, uint32_t);
> +       __type(value, uintptr_t);
> +} ip SEC(".maps");

please use global variable:

__u64 ip;

and then access it from user-space side through skeleton

skel->bss.ip =3D &test_function;

> +
> +SEC("perf_event")
> +int handler(struct bpf_perf_event_data *data)
> +{
> +       const uint32_t index =3D 0;
> +       uintptr_t *v =3D bpf_map_lookup_elem(&ip, &index);
> +
> +       return !(v && *v =3D=3D PT_REGS_IP(&data->regs));

and so we the above global var suggestion this will be just:

return ip =3D=3D PT_REGS_IP(&data->regs);

> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>

