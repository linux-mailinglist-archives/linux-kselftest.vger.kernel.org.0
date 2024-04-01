Return-Path: <linux-kselftest+bounces-6954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10F894508
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 20:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5C21C21368
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7C524DD;
	Mon,  1 Apr 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OaRiiBOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D914CDE0
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997606; cv=none; b=GWg4SIFqqqqY6MTee4h5LJJ+OmHnkc/9t9nGXgSj6bSDirFs5YYreehl99KPj+W1qV2q/GlU0KsnwG4PlLm1F8WDsiCiXkvgoHaujword3NR4OLSRuxdE1QNw3LBlvZOhl1SuRqMe/4yfj/pcJAz5vFS5x7FtUEfvAHdE2/336k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997606; c=relaxed/simple;
	bh=yV8aLM1BNUJXdq5Dblt4rHJNCh3gARz7lOjjZ2L1VFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5qO6/Yq6Nw30TITDZ+QEXbwGznXdIBdoFw2OBKhMfTbpFeji2Ma5ysrs3iYGlkkSEHDsT1H4H3qDFPKSzte0mcXYRo7zCJjEXaJoLh7ecZf3QkRDrrXenT4TKdHhOBTurWlOSduswVP29pNzcHBSfCGd4ZdQg0gCEqIIYkbMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OaRiiBOJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <92e1cce6-5f26-4a49-86b6-81e1e80d1aaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711997601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6IGwiIpHA7QsaURG4tae7nD5mxWT/YzxPrg7GR5D+c=;
	b=OaRiiBOJgFCE0wYI9dhleD9ZIa4TX4nJMSZ0Zrh4dVGdq3hlxMeKqQUKgrLlvXobUbQOx2
	9xqFLo5Lkfx3uK+BRotZLUHn+PWpkFOmb6Bfs0VTEca9uHsYg7i5YP2p9V4pZwRaPYOekg
	hU1J71miUIJ/nkjXqH5mgSh33C7gDP0=
Date: Mon, 1 Apr 2024 11:53:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Move test_dev_cgroup to
 prog_tests
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240401123455.1377896-1-usama.anjum@collabora.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240401123455.1377896-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 5:34 AM, Muhammad Usama Anjum wrote:
> Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
> with test_progs. Replace dev_cgroup.bpf.o with skel header file,
> dev_cgroup.skel.h and load program from it accourdingly.
>
>    ./test_progs -t dev_cgroup
>    mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>    64+0 records in
>    64+0 records out
>    32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>    dd: failed to open '/dev/full': Operation not permitted
>    dd: failed to open '/dev/random': Operation not permitted
>    #72     test_dev_cgroup:OK
>    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v2:
> - Replace test_dev_cgroup with serial_test_dev_cgroup as there is
>    probability that the test is racing against another cgroup test
> - Minor changes to the commit message above
>
> I've tested the patch with vmtest.sh on bpf-next/for-next and linux
> next. It is passing on both. Not sure why it was failed on BPFCI.
> Test run with vmtest.h:
> sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh ./test_progs -t dev_cgroup
> ./test_progs -t dev_cgroup
> mknod: /tmp/test_dev_cgroup_null: Operation not permitted
> 64+0 records in
> 64+0 records out
> 32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
> dd: failed to open '/dev/full': Operation not permitted
> dd: failed to open '/dev/random': Operation not permitted
>   #69      dev_cgroup:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

The CI failure:


Error: #72 dev_cgroup
serial_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
serial_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
serial_test_dev_cgroup:PASS:bpf_attach 0 nsec
serial_test_dev_cgroup:PASS:bpf_query 0 nsec
serial_test_dev_cgroup:PASS:bpf_query 0 nsec
serial_test_dev_cgroup:PASS:rm 0 nsec
serial_test_dev_cgroup:PASS:mknod 0 nsec
serial_test_dev_cgroup:PASS:rm 0 nsec
serial_test_dev_cgroup:PASS:rm 0 nsec
serial_test_dev_cgroup:FAIL:mknod unexpected mknod: actual 256 != 
expected 0
serial_test_dev_cgroup:PASS:rm 0 nsec
serial_test_dev_cgroup:PASS:dd 0 nsec
serial_test_dev_cgroup:PASS:dd 0 nsec
serial_test_dev_cgroup:PASS:dd 0 nsec

(cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2

The error code 256 means mknod execution has some issues. Maybe you need 
to find specific errno to find out what is going on. I think you can do 
ci on-demanding test to debug.

https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst

>
> Changes since v1:
> - Rename file from test_dev_cgroup.c to dev_cgroup.c
> - Use ASSERT_* in-place of CHECK
> ---
>   .../selftests/bpf/prog_tests/dev_cgroup.c     | 58 +++++++++++++
>   tools/testing/selftests/bpf/test_dev_cgroup.c | 85 -------------------
>   2 files changed, 58 insertions(+), 85 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
>   delete mode 100644 tools/testing/selftests/bpf/test_dev_cgroup.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
> new file mode 100644
> index 0000000000000..da0bc209d6a21
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2017 Facebook
> + */
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "cgroup_helpers.h"
> +#include "dev_cgroup.skel.h"
> +
> +#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
> +
> +void serial_test_dev_cgroup(void)
> +{
> +	struct dev_cgroup *skel;
> +	int cgroup_fd, err;
> +	__u32 prog_cnt;
> +
> +	skel = dev_cgroup__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		goto cleanup;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> +	if (!ASSERT_GT(cgroup_fd, 0, "cgroup_setup_and_join"))
> +		goto cleanup;
> +
> +	err = bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1), cgroup_fd,
> +			      BPF_CGROUP_DEVICE, 0);
> +	if (!ASSERT_EQ(err, 0, "bpf_attach"))
> +		goto cleanup;
> +
> +	err = bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL, &prog_cnt);
> +	if (!ASSERT_EQ(err, 0, "bpf_query") || (!ASSERT_EQ(prog_cnt, 1, "bpf_query")))
> +		goto cleanup;
> +
> +	/* All operations with /dev/zero and /dev/urandom are allowed,
> +	 * everything else is forbidden.
> +	 */
> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_null"), 0, "rm");
> +	ASSERT_NEQ(system("mknod /tmp/test_dev_cgroup_null c 1 3"), 0, "mknod");
> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_null"), 0, "rm");
> +
> +	/* /dev/zero is whitelisted */
> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_zero"), 0, "rm");
> +	ASSERT_EQ(system("mknod /tmp/test_dev_cgroup_zero c 1 5"), 0, "mknod");
> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_zero"), 0, "rm");
> +
> +	ASSERT_EQ(system("dd if=/dev/urandom of=/dev/zero count=64"), 0, "dd");
> +
> +	/* src is allowed, target is forbidden */
> +	ASSERT_NEQ(system("dd if=/dev/urandom of=/dev/full count=64"), 0, "dd");
> +
> +	/* src is forbidden, target is allowed */
> +	ASSERT_NEQ(system("dd if=/dev/random of=/dev/zero count=64"), 0, "dd");
> +
> +cleanup:
> +	cleanup_cgroup_environment();
> +	dev_cgroup__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
> deleted file mode 100644
> index adeaf63cb6fa3..0000000000000
> --- a/tools/testing/selftests/bpf/test_dev_cgroup.c
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2017 Facebook
> - */
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <assert.h>
> -#include <sys/time.h>
> -
> -#include <linux/bpf.h>
> -#include <bpf/bpf.h>
> -#include <bpf/libbpf.h>
> -
> -#include "cgroup_helpers.h"
> -#include "testing_helpers.h"
> -
> -#define DEV_CGROUP_PROG "./dev_cgroup.bpf.o"
> -
> -#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
> -
> -int main(int argc, char **argv)
> -{
> -	struct bpf_object *obj;
> -	int error = EXIT_FAILURE;
> -	int prog_fd, cgroup_fd;
> -	__u32 prog_cnt;
> -
> -	/* Use libbpf 1.0 API mode */
> -	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> -
> -	if (bpf_prog_test_load(DEV_CGROUP_PROG, BPF_PROG_TYPE_CGROUP_DEVICE,
> -			  &obj, &prog_fd)) {
> -		printf("Failed to load DEV_CGROUP program\n");
> -		goto out;
> -	}
> -
> -	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> -	if (cgroup_fd < 0) {
> -		printf("Failed to create test cgroup\n");
> -		goto out;
> -	}
> -
> -	/* Attach bpf program */
> -	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_DEVICE, 0)) {
> -		printf("Failed to attach DEV_CGROUP program");
> -		goto err;
> -	}
> -
> -	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL,
> -			   &prog_cnt)) {
> -		printf("Failed to query attached programs");
> -		goto err;
> -	}
> -
> -	/* All operations with /dev/zero and and /dev/urandom are allowed,
> -	 * everything else is forbidden.
> -	 */
> -	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
> -	assert(system("mknod /tmp/test_dev_cgroup_null c 1 3"));
> -	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
> -
> -	/* /dev/zero is whitelisted */
> -	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
> -	assert(system("mknod /tmp/test_dev_cgroup_zero c 1 5") == 0);
> -	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
> -
> -	assert(system("dd if=/dev/urandom of=/dev/zero count=64") == 0);
> -
> -	/* src is allowed, target is forbidden */
> -	assert(system("dd if=/dev/urandom of=/dev/full count=64"));
> -
> -	/* src is forbidden, target is allowed */
> -	assert(system("dd if=/dev/random of=/dev/zero count=64"));
> -
> -	error = 0;
> -	printf("test_dev_cgroup:PASS\n");
> -
> -err:
> -	cleanup_cgroup_environment();
> -
> -out:
> -	return error;
> -}

