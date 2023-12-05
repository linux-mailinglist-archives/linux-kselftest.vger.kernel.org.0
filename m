Return-Path: <linux-kselftest+bounces-1183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F4805C9D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E20A1F21190
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17FC6A335;
	Tue,  5 Dec 2023 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="KoXk7Z+f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2E418D
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 09:52:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00c200782dso816527666b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 09:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701798732; x=1702403532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rB5zy5FXc2Q0muVk5ePz1qdh/FmI9i/LZX5yd22+Lg=;
        b=KoXk7Z+fzqGYfn0O/Ypf7YmO1vLrTZpWIHq3YD4wIGsCsD54TaQAtavyZdLC6g7pbD
         zs7SBUJ+gBnZXER5o4oOHS+0MbFkf1z3hbFq2FwK7UglGcN2v7MfQ1xC5NM72ThXdeZG
         hWXBWI9Ydkrg0zkzQsOdgq8kTVU1+UltqnmvKZqAad5Q0VZyhJ9VswratbNswP/+BgZw
         0KlZf3MznVvdOhjbGXvsAamQCO31R3R/0kbwE1hKGgDLt6KRb+jRjxU2RQNIKvk2WJpD
         40YDijUpsApDKJrbdjEwsE31oDKv0qwlk5f2ndaPWexzfYjgEm5tmh+tkG3KA6rYlPDT
         otyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798732; x=1702403532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rB5zy5FXc2Q0muVk5ePz1qdh/FmI9i/LZX5yd22+Lg=;
        b=OqxZKo4QcgugcV1+26Rjzb6xARUpk7Bi09WMd2mrFxUL99Ak/a4lq047jtYHHC2JJi
         P2IYEFUNIXLiuJ+whW1kdunxVozJLEL54WZjfp/DGYJP8D/sG0kB7h4OwVi87ZSddS/K
         sQQriWR2tRMDv60zFs/JCGqPoFDZUPI3vutoR5JEuyczJ/jeRIzmrCXVFiguUBkO+Uqs
         QqSA4KLk+yYA0UV57iJQ0xd9lbxXjcKinGqx8rFbW7deqykXr9wAXsA3GKbj7WwOQWxt
         8yTGoZzClzEtu4WfyeecMkNEGSlOeQEGLIOghoFgCckr3jSVrkoBO261jyljzFguA7Tq
         /Qcw==
X-Gm-Message-State: AOJu0YzgU8s+VCqNpQKx3zuLXZ/Dlu0LSsJX2vFTNtF1Bs4AtsUJPbYx
	Q1jXqeLwmIydGExTvR/QjPSkKDZDJu6QKZJYUnOq/g==
X-Google-Smtp-Source: AGHT+IFVsyhC/+ujx3Ezt7cShACO7XA3ohblH2dRVEa35IHf+m7pxUMvMFRoZCGIAYeIT1NsOt3tn8dmN+Az1jIlAms=
X-Received: by 2002:a17:907:7632:b0:a18:7e19:5347 with SMTP id
 jy18-20020a170907763200b00a187e195347mr2274927ejc.47.1701798732114; Tue, 05
 Dec 2023 09:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-3-khuey@kylehuey.com>
 <fb4b856d-601d-4aa9-8526-14e5682f6402@linux.dev>
In-Reply-To: <fb4b856d-601d-4aa9-8526-14e5682f6402@linux.dev>
From: Kyle Huey <me@kylehuey.com>
Date: Tue, 5 Dec 2023 09:52:00 -0800
Message-ID: <CAP045Aos_o2Smeo_9C_LJNvCTKAF5Usatt0RAF-NeL0SjNJEYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftest/bpf: Test returning zero from a perf bpf
 program suppresses SIGIO.
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	"Robert O'Callahan" <robert@ocallahan.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:54=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/4/23 3:14 PM, Kyle Huey wrote:
> > The test sets a hardware breakpoint and uses a bpf program to suppress =
the
> > I/O availability signal if the ip matches the expected value.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > ---
> >   .../selftests/bpf/prog_tests/perf_skip.c      | 95 ++++++++++++++++++=
+
> >   .../selftests/bpf/progs/test_perf_skip.c      | 23 +++++
> >   2 files changed, 118 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools=
/testing/selftests/bpf/prog_tests/perf_skip.c
> > new file mode 100644
> > index 000000000000..b269a31669b7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <test_progs.h>
> > +#include "test_perf_skip.skel.h"
> > +#include <linux/hw_breakpoint.h>
> > +#include <sys/mman.h>
> > +
> > +#define BPF_OBJECT            "test_perf_skip.bpf.o"
> > +
> > +static void handle_sig(int)
>
> I hit a warning here:
> home/yhs/work/bpf-next/tools/testing/selftests/bpf/prog_tests/perf_skip.c=
:10:27: error: omitting the parameter name in a function definition is a C2=
3 extension [-Werror,-Wc23-extensions]

Yeah, Meta's kernel-ci bot sent me off-list email about this one.

>
>     10 | static void handle_sig(int)
>        |
>
> Add a parameter and marked as unused can resolve the issue.
>
> #define __always_unused         __attribute__((__unused__))
>
> static void handle_sig(int unused __always_unused)
> {
>          ASSERT_OK(1, "perf event not skipped");
> }
>
>
> > +{
> > +     ASSERT_OK(1, "perf event not skipped");
> > +}
> > +
> > +static noinline int test_function(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +void serial_test_perf_skip(void)
> > +{
> > +     sighandler_t previous;
> > +     int duration =3D 0;
> > +     struct test_perf_skip *skel =3D NULL;
> > +     int map_fd =3D -1;
> > +     long page_size =3D sysconf(_SC_PAGE_SIZE);
> > +     uintptr_t *ip =3D NULL;
> > +     int prog_fd =3D -1;
> > +     struct perf_event_attr attr =3D {0};
> > +     int perf_fd =3D -1;
> > +     struct f_owner_ex owner;
> > +     int err;
> > +
> > +     previous =3D signal(SIGIO, handle_sig);
> > +
> > +     skel =3D test_perf_skip__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_load"))
> > +             goto cleanup;
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.handler);
> > +     if (!ASSERT_OK(prog_fd < 0, "bpf_program__fd"))
> > +             goto cleanup;
> > +
> > +     map_fd =3D bpf_map__fd(skel->maps.ip);
> > +     if (!ASSERT_OK(map_fd < 0, "bpf_map__fd"))
> > +             goto cleanup;
> > +
> > +     ip =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, =
map_fd, 0);
> > +     if (!ASSERT_OK_PTR(ip, "mmap bpf map"))
> > +             goto cleanup;
> > +
> > +     *ip =3D (uintptr_t)test_function;
> > +
> > +     attr.type =3D PERF_TYPE_BREAKPOINT;
> > +     attr.size =3D sizeof(attr);
> > +     attr.bp_type =3D HW_BREAKPOINT_X;
> > +     attr.bp_addr =3D (uintptr_t)test_function;
> > +     attr.bp_len =3D sizeof(long);
> > +     attr.sample_period =3D 1;
> > +     attr.sample_type =3D PERF_SAMPLE_IP;
> > +     attr.pinned =3D 1;
> > +     attr.exclude_kernel =3D 1;
> > +     attr.exclude_hv =3D 1;
> > +     attr.precise_ip =3D 3;
> > +
> > +     perf_fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> > +     if (CHECK(perf_fd < 0, "perf_event_open", "err %d\n", perf_fd))
> > +             goto cleanup;
> > +
> > +     err =3D fcntl(perf_fd, F_SETFL, O_ASYNC);
> > +     if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
> > +             goto cleanup;
> > +
> > +     owner.type =3D F_OWNER_TID;
> > +     owner.pid =3D gettid();
>
> I hit a compilation failure here:
>
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/prog_tests/perf_skip.=
c:75:14: error: call to undeclared function 'gettid'; ISO C99 and later do =
not support implicit function declarations [-Wimplicit-function-declaration=
]
>     75 |         owner.pid =3D gettid();
>        |                     ^
>
> If you looked at some other examples, the common usage is do 'syscall(SYS=
_gettid)'.

Not clear why this works for me but sure I'll change that.

>
> So the following patch should fix the compilation error:
>
> #include <sys/syscall.h>
> ...
>          owner.pid =3D syscall(SYS_gettid);
> ...
>
> > +     err =3D fcntl(perf_fd, F_SETOWN_EX, &owner);
> > +     if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
> > +             goto cleanup;
> > +
> > +     err =3D ioctl(perf_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> > +     if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_SET_BPF)"))
> > +             goto cleanup;
> > +
> > +     test_function();
>
> As Andrii has mentioned in previous comments, we will have
> issue is RELEASE version of selftest is built
>    RELEASE=3D1 make ...
>
> See https://lore.kernel.org/bpf/20231127050342.1945270-1-yonghong.song@li=
nux.dev

Not sure I follow this one. Are you saying adding asm volatile ("") in
test_function() is *not* sufficient?

- Kyle

>
> > +
> > +cleanup:
> > +     if (perf_fd >=3D 0)
> > +             close(perf_fd);
> > +     if (ip)
> > +             munmap(ip, page_size);
> > +     if (skel)
> > +             test_perf_skip__destroy(skel);
> > +
> > +     signal(SIGIO, previous);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools=
/testing/selftests/bpf/progs/test_perf_skip.c
> > new file mode 100644
> > index 000000000000..ef01a9161afe
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_ARRAY);
> > +     __uint(max_entries, 1);
> > +     __uint(map_flags, BPF_F_MMAPABLE);
> > +     __type(key, uint32_t);
> > +     __type(value, uintptr_t);
> > +} ip SEC(".maps");
> > +
> > +SEC("perf_event")
> > +int handler(struct bpf_perf_event_data *data)
> > +{
> > +     const uint32_t index =3D 0;
> > +     uintptr_t *v =3D bpf_map_lookup_elem(&ip, &index);
> > +
> > +     return !(v && *v =3D=3D PT_REGS_IP(&data->regs));
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";

