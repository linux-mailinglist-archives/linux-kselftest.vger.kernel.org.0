Return-Path: <linux-kselftest+bounces-28659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE7A59DB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ED53A7C00
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F24233D65;
	Mon, 10 Mar 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpdKT4ht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7823372A;
	Mon, 10 Mar 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627408; cv=none; b=Ix/eyLIsg7yrri33+8vK/H3xbjdPQm8XH0heA6poaFjbrA+AsIqf3929HVeq19a/IqvNgrsSPJMUN6OAdgoS8LBsSLGFANSxhk0cwVfZrbpieelZ7YD+Uzvzsq4Ef0tSkW0gQI8Ti6c+CLtxbuF6/Y2fFzAcNky+V87D+b9U9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627408; c=relaxed/simple;
	bh=Nc9jtCn/YKhYhG6Cz7q/EcH50HSJxU2Q7dJfnYVLYIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0lgGd6eKFkw8Bzvxr53AFpv/nuvrU8+SOecNwHu+DcNRpWbOr3jFFzNHfYBkOsZzzmMFcQY5UYiaYLB0swW2MkR2Pzuvy6NXkUaxbBQ92pCwLIbhpMRUBPVjN/ueXsUIuX6d7mctcOixU11AMOJrvHrJ9LiCQ7YfBn0uEgq0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpdKT4ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450AC4CEF3;
	Mon, 10 Mar 2025 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627408;
	bh=Nc9jtCn/YKhYhG6Cz7q/EcH50HSJxU2Q7dJfnYVLYIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TpdKT4ht7bz3sPycMxo9XFhdBZOJ4FkXWqWs1eHqjhM6VH7gqYQer02grJXlF6Dhk
	 Ca+RfR9kz1DuX/h62eCoLtUM0K1KDoXtNa78Nd2AKzhntKopCbf2Hvr0d6r5baNaKF
	 HnxT0EgaWlPBQNtcJl3LqeugYsT1BvFSvy1wDQxbIYH4r6kx8e8xu8+msAmr1hdsVo
	 0cjIJHUZ1jZl1qssl1AP2A0y2l3HL5k9C56mIBe0l/eVf0llLyA5lSwSvML6By6NIk
	 8Dxnb2OdguBcyiCV4hqK7ICT8noOVARG8/sdv1x9bBNHsQlbDVYW/xteBcahA6IH4s
	 VbTwdKmTtxtXg==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d45f230480so8821575ab.3;
        Mon, 10 Mar 2025 10:23:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8FqyW7Wf+ska+OoGlBsentbBmWzedappW64Q1YMBm1bQNvLbGtYEQ2vFdjMYEqhwCLLNvj0CS28FheqASZAfa@vger.kernel.org, AJvYcCVmGcItS1JnDIxKobv57R4u8mNatYiv6gH1ooIWbC82ILJlOXlJZVQ1rfQ6hLMMboK11UDac20UGw==@vger.kernel.org, AJvYcCW1Iof0Mz8wDTczJcsPDxdjbORGAnZNz/6WZ8rEdylWNsGBAwPsezAh90Bm36p9lZX6U4Q=@vger.kernel.org, AJvYcCWJEsv6Ik2YNCgiw5kd+H1ML7ubjklDm++NolvM4ZhBOZjuUl8+nqTbDO27alI4YXsUVygjsyomRO1zDuT9@vger.kernel.org, AJvYcCX42FFF1qmyS2XzU2bs5OABg6oyuLnAFDuevTozoRi6AQbZeLruOV4KnMV/Y392BaYdY+Au+V68YeyZmuARYn0WumRozGnh@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzMzeFzaCw9qoZJLVpEJOTvu4UBhWLcYrT4xkxohocozzWKnM
	n0ehx8VAIWuu7wD4vVvRYQunrR3UMaEfGj/2qht2idJaO8XCk8BYVX/m+0GHCOI7/bU1FPXFy6k
	bmKItABy7ZliQzXhuAzTZmtg9O60=
X-Google-Smtp-Source: AGHT+IFnItE4PtwiTY4fcGc8/A6323DJfi363ghdhDxwpcFG8ZbQN2v7hctOcw6Sgjnitz+bwt19rSoUfMOediG8kw8=
X-Received: by 2002:a05:6e02:12e8:b0:3d4:3fbf:966e with SMTP id
 e9e14a558f8ab-3d44192a9famr145403815ab.14.1741627407796; Mon, 10 Mar 2025
 10:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308013314.719150-1-bboscaccy@linux.microsoft.com> <20250308013314.719150-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250308013314.719150-3-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Mon, 10 Mar 2025 10:23:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo3hqYv29oNUeWZRZdEoRAKqfJQkOSTgnrUhD_eWnsXfFJpbyYPAeAlpyg
Message-ID: <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 5:33=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This test exercises the kernel flag added to security_bpf by
> effectively blocking light-skeletons from loading while allowing
> normal skeletons to function as-is. Since this should work with any
> arbitrary BPF program, an existing program from LSKELS_EXTRA was
> used as a test payload.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  .../selftests/bpf/prog_tests/kernel_flag.c    | 43 +++++++++++++++++++
>  .../selftests/bpf/progs/test_kernel_flag.c    | 28 ++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools=
/testing/selftests/bpf/prog_tests/kernel_flag.c
> new file mode 100644
> index 0000000000000..479ad5de3737e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Microsoft */
> +#include <test_progs.h>
> +#include "kfunc_call_test.skel.h"
> +#include "kfunc_call_test.lskel.h"
> +#include "test_kernel_flag.skel.h"
> +
> +void test_kernel_flag(void)
> +{
> +       struct test_kernel_flag *lsm_skel;
> +       struct kfunc_call_test *skel =3D NULL;
> +       struct kfunc_call_test_lskel *lskel =3D NULL;
> +       int ret;
> +
> +       lsm_skel =3D test_kernel_flag__open_and_load();
> +       if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
> +               return;
> +
> +       ret =3D test_kernel_flag__attach(lsm_skel);
> +       if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
> +               goto close_prog;
> +
> +       lsm_skel->bss->monitored_pid =3D getpid();

We usually set monitored_pid before attaching the program.

> +
> +       /* Test with skel. This should pass the gatekeeper */
> +       skel =3D kfunc_call_test__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel"))
> +               goto close_prog;
> +
> +       /* Test with lskel. This should fail due to blocking kernel-based=
 bpf() invocations */
> +       lskel =3D kfunc_call_test_lskel__open_and_load();
> +       if (!ASSERT_ERR_PTR(lskel, "lskel"))
> +               goto close_prog;
> +
> +close_prog:
> +       if (skel)
> +               kfunc_call_test__destroy(skel);
> +       if (lskel)
> +               kfunc_call_test_lskel__destroy(lskel);
> +
> +       lsm_skel->bss->monitored_pid =3D 0;
> +       test_kernel_flag__destroy(lsm_skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_kernel_flag.c b/tools=
/testing/selftests/bpf/progs/test_kernel_flag.c
> new file mode 100644
> index 0000000000000..9ca01aadb6656
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2025 Microsoft Corporation
> + *
> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> + */
> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +__u32 monitored_pid;
> +
> +SEC("lsm.s/bpf")
> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool=
 kernel)
> +{
> +       __u32 pid;
> +
> +       pid =3D bpf_get_current_pid_tgid() >> 32;
> +       if (!kernel || pid !=3D monitored_pid)
> +               return 0;

We are blocking lskel load for the pid. This could make
parallel testing (test_progs -j) flaky. We should probably
change the logic to filtering on monitored_tiid.

Thanks,
Song

> +       else
> +               return -EINVAL;
> +}
> --
> 2.48.1
>
>

