Return-Path: <linux-kselftest+bounces-28664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BAA59FE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF73A70EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8E233727;
	Mon, 10 Mar 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V3IjL0ca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302622DFB1;
	Mon, 10 Mar 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628610; cv=none; b=Fe6rDyhHaiuKZmFsW3TiKJyhyWlOE2N3Mi921rt+SiCmCP+nuGf9jwizqcOSsVXKkSut9TP/0nTc5NNrXB0AeqqykWr2mcl6Mx+RD/4m+hQRbbYp9y1qTSNyDyjEwJwGyf2Ah23vmTFoEcMLMu/ThH+ZlemEI0vqWI8ppbHDzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628610; c=relaxed/simple;
	bh=nVu5HN6r55xWpWlJj8oBTLsoBZcAk38gbF4FNnZ7ZFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U97sVm/a9FmA2SQBsj/6QAga8tzz3B5DXdKybbxB4IzNFUic82Kwka+4BBG4InUBNjqwyBe6v0oZ9On3Dd0bWTo65sQU1dz+lws78cRs/MBF8d7eqPWZRLDt9peSG0JHuwPYf6t72dNhUpdgYtouv5y9CsYVpTVXbiooiJVXnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V3IjL0ca; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id A18EC2038F31;
	Mon, 10 Mar 2025 10:43:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A18EC2038F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741628608;
	bh=ggsx2Gq6zrbtpEOFlIbtQA76waAnu6lidjNvvMFeczU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V3IjL0caWZjWbSBABQ34XNSIVJ7jmgbqqeoGaUPq04B6WbaFpIiLfHxOqBFezDIfq
	 kqbjHVvQ2XI9oiVBOf+z0OZIcozNsk4VOj8LjvlXx9qklkgvetClV3iYXgNoYDkS0K
	 FYtHdXFstUZI/9BUpaItT9ACuyGIqsTfktYx7uWc=
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
In-Reply-To: <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
References: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
 <20250308013314.719150-3-bboscaccy@linux.microsoft.com>
 <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
Date: Mon, 10 Mar 2025 10:43:18 -0700
Message-ID: <87v7sgye6h.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> On Fri, Mar 7, 2025 at 5:33=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> This test exercises the kernel flag added to security_bpf by
>> effectively blocking light-skeletons from loading while allowing
>> normal skeletons to function as-is. Since this should work with any
>> arbitrary BPF program, an existing program from LSKELS_EXTRA was
>> used as a test payload.
>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  .../selftests/bpf/prog_tests/kernel_flag.c    | 43 +++++++++++++++++++
>>  .../selftests/bpf/progs/test_kernel_flag.c    | 28 ++++++++++++
>>  2 files changed, 71 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tool=
s/testing/selftests/bpf/prog_tests/kernel_flag.c
>> new file mode 100644
>> index 0000000000000..479ad5de3737e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
>> @@ -0,0 +1,43 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Microsoft */
>> +#include <test_progs.h>
>> +#include "kfunc_call_test.skel.h"
>> +#include "kfunc_call_test.lskel.h"
>> +#include "test_kernel_flag.skel.h"
>> +
>> +void test_kernel_flag(void)
>> +{
>> +       struct test_kernel_flag *lsm_skel;
>> +       struct kfunc_call_test *skel =3D NULL;
>> +       struct kfunc_call_test_lskel *lskel =3D NULL;
>> +       int ret;
>> +
>> +       lsm_skel =3D test_kernel_flag__open_and_load();
>> +       if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
>> +               return;
>> +
>> +       ret =3D test_kernel_flag__attach(lsm_skel);
>> +       if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
>> +               goto close_prog;
>> +
>> +       lsm_skel->bss->monitored_pid =3D getpid();
>
> We usually set monitored_pid before attaching the program.
>

Okay, copy that.=20

>> +
>> +       /* Test with skel. This should pass the gatekeeper */
>> +       skel =3D kfunc_call_test__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "skel"))
>> +               goto close_prog;
>> +
>> +       /* Test with lskel. This should fail due to blocking kernel-base=
d bpf() invocations */
>> +       lskel =3D kfunc_call_test_lskel__open_and_load();
>> +       if (!ASSERT_ERR_PTR(lskel, "lskel"))
>> +               goto close_prog;
>> +
>> +close_prog:
>> +       if (skel)
>> +               kfunc_call_test__destroy(skel);
>> +       if (lskel)
>> +               kfunc_call_test_lskel__destroy(lskel);
>> +
>> +       lsm_skel->bss->monitored_pid =3D 0;
>> +       test_kernel_flag__destroy(lsm_skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_kernel_flag.c b/tool=
s/testing/selftests/bpf/progs/test_kernel_flag.c
>> new file mode 100644
>> index 0000000000000..9ca01aadb6656
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Copyright (C) 2025 Microsoft Corporation
>> + *
>> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> + */
>> +
>> +#include "vmlinux.h"
>> +#include <errno.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> +
>> +__u32 monitored_pid;
>> +
>> +SEC("lsm.s/bpf")
>> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, boo=
l kernel)
>> +{
>> +       __u32 pid;
>> +
>> +       pid =3D bpf_get_current_pid_tgid() >> 32;
>> +       if (!kernel || pid !=3D monitored_pid)
>> +               return 0;
>
> We are blocking lskel load for the pid. This could make
> parallel testing (test_progs -j) flaky. We should probably
> change the logic to filtering on monitored_tiid.
>

Curious on this for my own edification. The

pid =3D bpf_get_current_pid_tgid() >> 32;

is used extensively in the current test suite in a bunch of other
tests. Why does that not cause an issue with the other tests during
parallel testing?=20

> Thanks,
> Song
>
>> +       else
>> +               return -EINVAL;
>> +}
>> --
>> 2.48.1
>>
>>

