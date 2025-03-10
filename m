Return-Path: <linux-kselftest+bounces-28666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6AA5A1B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93806188DE0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610023236F;
	Mon, 10 Mar 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="niqcbDyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73E2206BD;
	Mon, 10 Mar 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630303; cv=none; b=CyLP1WCK0soZm3sdoZZ8ykAAjMZglxkmRYeAgRbsku3QA6Pkz5JtqGI3eWqQ7VNfsJ2NaJDzPLhSn/E8k5VEtNhzzPbwO6ElcoSiZWII7WLRDnFnXC+07ZvggFziOAXo0VoJ+fq0xUDMaHEAIwfUl4goIAs0S5EeFM6keugWzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630303; c=relaxed/simple;
	bh=3OxdgUDWK+uFLVvzr/y6KkONgmK1n3ccKZ3Of6DC9m0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hd39uvzUUl4JDdMRJ2LhhhTRbADTtEKyiIOG/gHw50L1T7OSL2gznYw1nrHbV9A4n+rg4I9yO4ZUcfV6nxKWb96RlDMhpPvclCDFvq9IBb91Vy62ZBQec+aqZZtuWtkHvIfozvlj1gSnr5NLXui9RBgIYTUsyFvolcYNhglI3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=niqcbDyx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 190DE2038F4A;
	Mon, 10 Mar 2025 11:11:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 190DE2038F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741630301;
	bh=AObcEA8sw67rEti9TZTsNnLV8M/alL5bqjj3P/yE9RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=niqcbDyxUZZ/tP9cDiXJs0XJDKX5e26H6fSyRgd4xDz4LhAu/nCfDMmMrGrtdhpD0
	 3HyvjFSfj4oA8UjFbzHxQYph+SQ2wATqpqEdGi/FQA40wlk4ZfT6KCcfxqMDYfenz1
	 7hlBqekKb40V6BRdyHMtCijhgfJBuZLX6pLApyeM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Xu Kuohai
 <xukuohai@huawei.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 2/2] selftests/bpf: Add a kernel flag test
 for LSM bpf hook
In-Reply-To: <CAPhsuW41zvcSK8exRT6Ui1jyQ=OhD8BAdV6bU4nhGQGfV14+Cw@mail.gmail.com>
References: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
 <20250308013314.719150-3-bboscaccy@linux.microsoft.com>
 <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
 <87v7sgye6h.fsf@microsoft.com>
 <CAPhsuW41zvcSK8exRT6Ui1jyQ=OhD8BAdV6bU4nhGQGfV14+Cw@mail.gmail.com>
Date: Mon, 10 Mar 2025 11:11:32 -0700
Message-ID: <87senkycvf.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> On Mon, Mar 10, 2025 at 10:43=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> Song Liu <song@kernel.org> writes:
>>
>> > On Fri, Mar 7, 2025 at 5:33=E2=80=AFPM Blaise Boscaccy
>> > <bboscaccy@linux.microsoft.com> wrote:
>> >>
>> >> This test exercises the kernel flag added to security_bpf by
>> >> effectively blocking light-skeletons from loading while allowing
>> >> normal skeletons to function as-is. Since this should work with any
>> >> arbitrary BPF program, an existing program from LSKELS_EXTRA was
>> >> used as a test payload.
>> >>
>> >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> >> ---
>> >>  .../selftests/bpf/prog_tests/kernel_flag.c    | 43 +++++++++++++++++=
++
>> >>  .../selftests/bpf/progs/test_kernel_flag.c    | 28 ++++++++++++
>> >>  2 files changed, 71 insertions(+)
>> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_fla=
g.c
>> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_fla=
g.c
>> >>
>> >> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/t=
ools/testing/selftests/bpf/prog_tests/kernel_flag.c
>> >> new file mode 100644
>> >> index 0000000000000..479ad5de3737e
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
>> >> @@ -0,0 +1,43 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +/* Copyright (c) 2025 Microsoft */
>> >> +#include <test_progs.h>
>> >> +#include "kfunc_call_test.skel.h"
>> >> +#include "kfunc_call_test.lskel.h"
>> >> +#include "test_kernel_flag.skel.h"
>> >> +
>> >> +void test_kernel_flag(void)
>> >> +{
>> >> +       struct test_kernel_flag *lsm_skel;
>> >> +       struct kfunc_call_test *skel =3D NULL;
>> >> +       struct kfunc_call_test_lskel *lskel =3D NULL;
>> >> +       int ret;
>> >> +
>> >> +       lsm_skel =3D test_kernel_flag__open_and_load();
>> >> +       if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
>> >> +               return;
>> >> +
>> >> +       ret =3D test_kernel_flag__attach(lsm_skel);
>> >> +       if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
>> >> +               goto close_prog;
>> >> +
>> >> +       lsm_skel->bss->monitored_pid =3D getpid();
>> >
>> > We usually set monitored_pid before attaching the program.
>> >
>>
>> Okay, copy that.
>>
>> >> +
>> >> +       /* Test with skel. This should pass the gatekeeper */
>> >> +       skel =3D kfunc_call_test__open_and_load();
>> >> +       if (!ASSERT_OK_PTR(skel, "skel"))
>> >> +               goto close_prog;
>> >> +
>> >> +       /* Test with lskel. This should fail due to blocking kernel-b=
ased bpf() invocations */
>> >> +       lskel =3D kfunc_call_test_lskel__open_and_load();
>> >> +       if (!ASSERT_ERR_PTR(lskel, "lskel"))
>> >> +               goto close_prog;
>> >> +
>> >> +close_prog:
>> >> +       if (skel)
>> >> +               kfunc_call_test__destroy(skel);
>> >> +       if (lskel)
>> >> +               kfunc_call_test_lskel__destroy(lskel);
>> >> +
>> >> +       lsm_skel->bss->monitored_pid =3D 0;
>> >> +       test_kernel_flag__destroy(lsm_skel);
>> >> +}
>> >> diff --git a/tools/testing/selftests/bpf/progs/test_kernel_flag.c b/t=
ools/testing/selftests/bpf/progs/test_kernel_flag.c
>> >> new file mode 100644
>> >> index 0000000000000..9ca01aadb6656
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
>> >> @@ -0,0 +1,28 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +
>> >> +/*
>> >> + * Copyright (C) 2025 Microsoft Corporation
>> >> + *
>> >> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> >> + */
>> >> +
>> >> +#include "vmlinux.h"
>> >> +#include <errno.h>
>> >> +#include <bpf/bpf_helpers.h>
>> >> +#include <bpf/bpf_tracing.h>
>> >> +
>> >> +char _license[] SEC("license") =3D "GPL";
>> >> +
>> >> +__u32 monitored_pid;
>> >> +
>> >> +SEC("lsm.s/bpf")
>> >> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, =
bool kernel)
>> >> +{
>> >> +       __u32 pid;
>> >> +
>> >> +       pid =3D bpf_get_current_pid_tgid() >> 32;
>> >> +       if (!kernel || pid !=3D monitored_pid)
>> >> +               return 0;
>> >
>> > We are blocking lskel load for the pid. This could make
>> > parallel testing (test_progs -j) flaky. We should probably
>> > change the logic to filtering on monitored_tiid.
>> >
>>
>> Curious on this for my own edification. The
>>
>> pid =3D bpf_get_current_pid_tgid() >> 32;
>>
>> is used extensively in the current test suite in a bunch of other
>> tests. Why does that not cause an issue with the other tests during
>> parallel testing?
>
> We are blindly blocking all security_bpf() with kernel=3Dtrue here, so
> any lskel load in parallel with this test may fail. On the other hand,
> existing tests only block some operations under certain conditions.
> For example, test_cgroup1_hierarchy.c only blocks operations for
> target_ancestor_cgid.
>
> Does this make sense?
>

Not quite. This is only blocking security_bpf where kernel=3Dtrue and
pid=3Dmonitored_pid.=20


> Thanks,
> Song

