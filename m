Return-Path: <linux-kselftest+bounces-1178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14443805A8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C90281A07
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4961FD9;
	Tue,  5 Dec 2023 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EhGU4wmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D1F1987
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 08:54:12 -0800 (PST)
Message-ID: <fb4b856d-601d-4aa9-8526-14e5682f6402@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701795250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF3HKdpkUYHivvRpAHFn3rEF2x4jY5PYbwjx9JOVu3E=;
	b=EhGU4wmCYyp07Ts+1DE5grTY3Sa7dC6p4b+M8EA50s/cqLKx/tNEewXo2w34DMYWAjXRiG
	dC4LRQhfb7+SuHDbRr+yB8fzOzg6gRYClNgAsob/ctKQNZJbRn9c+Od1gtaJGP3SQEYgVr
	WvgAQYh4Ky+LRbsixpHMKTFloYpDy7Q=
Date: Tue, 5 Dec 2023 08:54:02 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] selftest/bpf: Test returning zero from a perf bpf
 program suppresses SIGIO.
Content-Language: en-GB
To: Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
 linux-kernel@vger.kernel.org
Cc: Robert O'Callahan <robert@ocallahan.org>,
 Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231204201406.341074-1-khuey@kylehuey.com>
 <20231204201406.341074-3-khuey@kylehuey.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231204201406.341074-3-khuey@kylehuey.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/4/23 3:14 PM, Kyle Huey wrote:
> The test sets a hardware breakpoint and uses a bpf program to suppress the
> I/O availability signal if the ip matches the expected value.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>   .../selftests/bpf/prog_tests/perf_skip.c      | 95 +++++++++++++++++++
>   .../selftests/bpf/progs/test_perf_skip.c      | 23 +++++
>   2 files changed, 118 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
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
> +
> +static void handle_sig(int)

I hit a warning here:
home/yhs/work/bpf-next/tools/testing/selftests/bpf/prog_tests/perf_skip.c:10:27: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    10 | static void handle_sig(int)
       |

Add a parameter and marked as unused can resolve the issue.

#define __always_unused         __attribute__((__unused__))

static void handle_sig(int unused __always_unused)
{
         ASSERT_OK(1, "perf event not skipped");
}


> +{
> +	ASSERT_OK(1, "perf event not skipped");
> +}
> +
> +static noinline int test_function(void)
> +{
> +	return 0;
> +}
> +
> +void serial_test_perf_skip(void)
> +{
> +	sighandler_t previous;
> +	int duration = 0;
> +	struct test_perf_skip *skel = NULL;
> +	int map_fd = -1;
> +	long page_size = sysconf(_SC_PAGE_SIZE);
> +	uintptr_t *ip = NULL;
> +	int prog_fd = -1;
> +	struct perf_event_attr attr = {0};
> +	int perf_fd = -1;
> +	struct f_owner_ex owner;
> +	int err;
> +
> +	previous = signal(SIGIO, handle_sig);
> +
> +	skel = test_perf_skip__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_load"))
> +		goto cleanup;
> +
> +	prog_fd = bpf_program__fd(skel->progs.handler);
> +	if (!ASSERT_OK(prog_fd < 0, "bpf_program__fd"))
> +		goto cleanup;
> +
> +	map_fd = bpf_map__fd(skel->maps.ip);
> +	if (!ASSERT_OK(map_fd < 0, "bpf_map__fd"))
> +		goto cleanup;
> +
> +	ip = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
> +	if (!ASSERT_OK_PTR(ip, "mmap bpf map"))
> +		goto cleanup;
> +
> +	*ip = (uintptr_t)test_function;
> +
> +	attr.type = PERF_TYPE_BREAKPOINT;
> +	attr.size = sizeof(attr);
> +	attr.bp_type = HW_BREAKPOINT_X;
> +	attr.bp_addr = (uintptr_t)test_function;
> +	attr.bp_len = sizeof(long);
> +	attr.sample_period = 1;
> +	attr.sample_type = PERF_SAMPLE_IP;
> +	attr.pinned = 1;
> +	attr.exclude_kernel = 1;
> +	attr.exclude_hv = 1;
> +	attr.precise_ip = 3;
> +
> +	perf_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> +	if (CHECK(perf_fd < 0, "perf_event_open", "err %d\n", perf_fd))
> +		goto cleanup;
> +
> +	err = fcntl(perf_fd, F_SETFL, O_ASYNC);
> +	if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
> +		goto cleanup;
> +
> +	owner.type = F_OWNER_TID;
> +	owner.pid = gettid();

I hit a compilation failure here:

/home/yhs/work/bpf-next/tools/testing/selftests/bpf/prog_tests/perf_skip.c:75:14: error: call to undeclared function 'gettid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    75 |         owner.pid = gettid();
       |                     ^

If you looked at some other examples, the common usage is do 'syscall(SYS_gettid)'.
So the following patch should fix the compilation error:

#include <sys/syscall.h>
...
         owner.pid = syscall(SYS_gettid);
...

> +	err = fcntl(perf_fd, F_SETOWN_EX, &owner);
> +	if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
> +		goto cleanup;
> +
> +	err = ioctl(perf_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> +	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_SET_BPF)"))
> +		goto cleanup;
> +
> +	test_function();

As Andrii has mentioned in previous comments, we will have
issue is RELEASE version of selftest is built
   RELEASE=1 make ...

See https://lore.kernel.org/bpf/20231127050342.1945270-1-yonghong.song@linux.dev

> +
> +cleanup:
> +	if (perf_fd >= 0)
> +		close(perf_fd);
> +	if (ip)
> +		munmap(ip, page_size);
> +	if (skel)
> +		test_perf_skip__destroy(skel);
> +
> +	signal(SIGIO, previous);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/testing/selftests/bpf/progs/test_perf_skip.c
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
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__type(key, uint32_t);
> +	__type(value, uintptr_t);
> +} ip SEC(".maps");
> +
> +SEC("perf_event")
> +int handler(struct bpf_perf_event_data *data)
> +{
> +	const uint32_t index = 0;
> +	uintptr_t *v = bpf_map_lookup_elem(&ip, &index);
> +
> +	return !(v && *v == PT_REGS_IP(&data->regs));
> +}
> +
> +char _license[] SEC("license") = "GPL";

