Return-Path: <linux-kselftest+bounces-28665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22994A5A110
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D36B189309C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4E233721;
	Mon, 10 Mar 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNu5b4wF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8422D7A6;
	Mon, 10 Mar 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629416; cv=none; b=T2vxhGYRKGBYwS2UiFLt8iWVO3aiGzmHogCR+3n2rG1JdIXW/rc085dHOY6G6hAbGFNyV0InPkg729ysbmlhcZqJaWkGEoQKfolkmG+geZ1GA8mZa9inyHGAFoxh4M05o6tC72lMZTcSXhgyyiNTWBc8esXrAt5o2CE4VB1/n8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629416; c=relaxed/simple;
	bh=+Ee42bPSCphWoM/msbQaXl0ESu01MyEZ4xTDK819ld4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oufrmES2ZuZsYM0fgn23OZQ+tVjCNGXEQmos8QeAb1rMbo+x5VjnJ+V0qaqn0gGEwn14g4ukQu+QxCzc//jPXBYIvSpLbtgK8OwnOCQAN2BuskCjuaXbHEfjpvRj1AneeVKEkwNXFIMgw92Qd4Ey3ihU26xAfTpHapPuhyTZeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNu5b4wF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A13DC4CEEC;
	Mon, 10 Mar 2025 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741629414;
	bh=+Ee42bPSCphWoM/msbQaXl0ESu01MyEZ4xTDK819ld4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pNu5b4wFQMLaAOi5+3D9kyi5UpvVJpVZjYhybNE828S6AzlYV5Rx79LE2XXqP2pAl
	 Xs2jKkjNNZTOkLfL0OhlaPGpGg0TQjkeGmoOhqhih1+PkW5rU9+sKenVh553JG6+ma
	 IrU/XAuBOKT1VY00dTR78eqe6dR3aLRxcj6UyiXtkUMTFCMRE/W7xR+9xTDwZ+CHGO
	 Iak/lZpupKbBHf+I+rkyDgQZ+Z15REJMB3pN75tzDQ801CfdtIatwQzkwAS6/1yZh5
	 zNad03Q08AYNOAIQsbFTAqxCsa4/390jzVV+fsFiCTdhmng0c6pif2ecrdB6pQU6/z
	 ayCSovBXs3iOA==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d43c972616so13473445ab.0;
        Mon, 10 Mar 2025 10:56:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNPRrdsZPZm+55IvgoooKoOepZgIEyt2lQZ/gpUT6yANDiDPTHbDG5FqnvCv+cCikh6L/IzPFLFMSs7e261gxGmmorjaTC@vger.kernel.org, AJvYcCUfDxVAad6U9x9IAlq/XMadBHkDr/CM4L0E6LrRp5N8TqVR8aYJ3oIFhPqvG5GVSibAhesDxuICPrUfNWpz@vger.kernel.org, AJvYcCVRoOB1QahF8jv4aCm93AM2YWAr6V6vZ+bis5u7F2SoFw+FI8YlukmrHvzfmzWmCGsdK8DCIeVShwl256Y5ctGF@vger.kernel.org, AJvYcCWhHEKPBfm2elCZAvffuTTcpiaLZMiBygFUKToFKNvjTPWtXICa3w6KLGYOxBVZ8mryNXeDTAo06g==@vger.kernel.org, AJvYcCXpbVayBg2kCEYRwmk1/f+VkvJ7WStZapb6taGtx5UzWEdxiQEh7V8CJNePduLnEEXNoTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya70Td2GJwddhk/NL3EYNsnPV/zKvQeOCsfSE1JJAzEILVsyH5
	kBEF/yIzyY/ZrzITfedxMxFU2+FYLNoVeC5ut0NGc7DkWYJTBwUy2E5GztSaCJfaMfs6I1rWalq
	aX4j39IbY1/Le7f1b+OOJ05Lyc1M=
X-Google-Smtp-Source: AGHT+IFSBbfciDnS/lTML5ydfVRyXoWFi0tOtreT94k8qtozrdxMTnmkCL5g0QYxhFGPQVC2bxFMknx2NSsZWjfynnk=
X-Received: by 2002:a05:6e02:1a41:b0:3d3:d1a8:8e82 with SMTP id
 e9e14a558f8ab-3d4691b80fcmr4563215ab.9.1741629413574; Mon, 10 Mar 2025
 10:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
 <20250308013314.719150-3-bboscaccy@linux.microsoft.com> <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
 <87v7sgye6h.fsf@microsoft.com>
In-Reply-To: <87v7sgye6h.fsf@microsoft.com>
From: Song Liu <song@kernel.org>
Date: Mon, 10 Mar 2025 10:56:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW41zvcSK8exRT6Ui1jyQ=OhD8BAdV6bU4nhGQGfV14+Cw@mail.gmail.com>
X-Gm-Features: AQ5f1JoxpWk18Uo1J5s6TmkZY2-nnM2HqP1r1sRtOjDyuVHg7BUG2Cme3PK5Fd0
Message-ID: <CAPhsuW41zvcSK8exRT6Ui1jyQ=OhD8BAdV6bU4nhGQGfV14+Cw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/2] selftests/bpf: Add a kernel flag test for
 LSM bpf hook
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:43=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > On Fri, Mar 7, 2025 at 5:33=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> This test exercises the kernel flag added to security_bpf by
> >> effectively blocking light-skeletons from loading while allowing
> >> normal skeletons to function as-is. Since this should work with any
> >> arbitrary BPF program, an existing program from LSKELS_EXTRA was
> >> used as a test payload.
> >>
> >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> >> ---
> >>  .../selftests/bpf/prog_tests/kernel_flag.c    | 43 ++++++++++++++++++=
+
> >>  .../selftests/bpf/progs/test_kernel_flag.c    | 28 ++++++++++++
> >>  2 files changed, 71 insertions(+)
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag=
.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag=
.c
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/to=
ols/testing/selftests/bpf/prog_tests/kernel_flag.c
> >> new file mode 100644
> >> index 0000000000000..479ad5de3737e
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> >> @@ -0,0 +1,43 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (c) 2025 Microsoft */
> >> +#include <test_progs.h>
> >> +#include "kfunc_call_test.skel.h"
> >> +#include "kfunc_call_test.lskel.h"
> >> +#include "test_kernel_flag.skel.h"
> >> +
> >> +void test_kernel_flag(void)
> >> +{
> >> +       struct test_kernel_flag *lsm_skel;
> >> +       struct kfunc_call_test *skel =3D NULL;
> >> +       struct kfunc_call_test_lskel *lskel =3D NULL;
> >> +       int ret;
> >> +
> >> +       lsm_skel =3D test_kernel_flag__open_and_load();
> >> +       if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
> >> +               return;
> >> +
> >> +       ret =3D test_kernel_flag__attach(lsm_skel);
> >> +       if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
> >> +               goto close_prog;
> >> +
> >> +       lsm_skel->bss->monitored_pid =3D getpid();
> >
> > We usually set monitored_pid before attaching the program.
> >
>
> Okay, copy that.
>
> >> +
> >> +       /* Test with skel. This should pass the gatekeeper */
> >> +       skel =3D kfunc_call_test__open_and_load();
> >> +       if (!ASSERT_OK_PTR(skel, "skel"))
> >> +               goto close_prog;
> >> +
> >> +       /* Test with lskel. This should fail due to blocking kernel-ba=
sed bpf() invocations */
> >> +       lskel =3D kfunc_call_test_lskel__open_and_load();
> >> +       if (!ASSERT_ERR_PTR(lskel, "lskel"))
> >> +               goto close_prog;
> >> +
> >> +close_prog:
> >> +       if (skel)
> >> +               kfunc_call_test__destroy(skel);
> >> +       if (lskel)
> >> +               kfunc_call_test_lskel__destroy(lskel);
> >> +
> >> +       lsm_skel->bss->monitored_pid =3D 0;
> >> +       test_kernel_flag__destroy(lsm_skel);
> >> +}
> >> diff --git a/tools/testing/selftests/bpf/progs/test_kernel_flag.c b/to=
ols/testing/selftests/bpf/progs/test_kernel_flag.c
> >> new file mode 100644
> >> index 0000000000000..9ca01aadb6656
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
> >> @@ -0,0 +1,28 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +/*
> >> + * Copyright (C) 2025 Microsoft Corporation
> >> + *
> >> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> >> + */
> >> +
> >> +#include "vmlinux.h"
> >> +#include <errno.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +#include <bpf/bpf_tracing.h>
> >> +
> >> +char _license[] SEC("license") =3D "GPL";
> >> +
> >> +__u32 monitored_pid;
> >> +
> >> +SEC("lsm.s/bpf")
> >> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, b=
ool kernel)
> >> +{
> >> +       __u32 pid;
> >> +
> >> +       pid =3D bpf_get_current_pid_tgid() >> 32;
> >> +       if (!kernel || pid !=3D monitored_pid)
> >> +               return 0;
> >
> > We are blocking lskel load for the pid. This could make
> > parallel testing (test_progs -j) flaky. We should probably
> > change the logic to filtering on monitored_tiid.
> >
>
> Curious on this for my own edification. The
>
> pid =3D bpf_get_current_pid_tgid() >> 32;
>
> is used extensively in the current test suite in a bunch of other
> tests. Why does that not cause an issue with the other tests during
> parallel testing?

We are blindly blocking all security_bpf() with kernel=3Dtrue here, so
any lskel load in parallel with this test may fail. On the other hand,
existing tests only block some operations under certain conditions.
For example, test_cgroup1_hierarchy.c only blocks operations for
target_ancestor_cgid.

Does this make sense?

Thanks,
Song

