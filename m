Return-Path: <linux-kselftest+bounces-4928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7285A37F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 13:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA4B1F22F32
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B872E407;
	Mon, 19 Feb 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PjA+CsTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066921353;
	Mon, 19 Feb 2024 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346037; cv=none; b=iF52DBvfKn5OIYyNOdleP4P32pIqKXlhzKo9+QOLhCT2963Cc82/KckyUgbZ8Q7h3+BTrUsFJzmhZeVJu4NXOy9V2tV6n0QwdElM0+y19SvL2jS40t38A7W+ue1PohoRkBSuGHY7WeRb6mevzQS1/EhNQdkRJcg/av78OaDVYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346037; c=relaxed/simple;
	bh=G10sUI3aurqn2NDIrco+NIvnWRizB/yeIM1LjXv9pGY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OwpWrD9Z1r3dkQYOWWaq/gGJz6ILbL2A/jTuGewuxDMo93059LUA9YspydKs/8fO8bY4Pvxq7j+i41JIIAqXdYtXIFweYCTn03QyQohKwAoOBJLLeiaX/2UKq0toXEZlzHSq2ZL1wR+Rpr09d13e/lRJlRa3g6QQ+W8LGgS2VWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PjA+CsTG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708346033;
	bh=G10sUI3aurqn2NDIrco+NIvnWRizB/yeIM1LjXv9pGY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PjA+CsTGolyEnGplhDrYLWwrTU5UFpkDEnmLxa3JHRW68WPj40CMAqBoMnWgB+40t
	 gMxl0uBjqM5ULJFykVqEtAT0+GV4B72h7rXScdwUv6Vt/sjYm+G/040XjEVOrjs+Fl
	 7BMoh45ZX/1IMknOjn/amX7ybYRY71N1wnPL2lTEcJmqAhZKUK4MFht59ln7NKSNeY
	 xZj0Cq4ikCW/p5QNQojCHHL0EYHnd4HILsGXg5puSn+RnhXClBYYC5ha74NwzFTzgZ
	 Xe3tL9EBbz6MyRXkGkmheGm0KX43wyH98UyHe8HTNMkBnR76sJN13ZZ9GtHKsRzkYw
	 04i483qnSXbhQ==
Received: from [100.72.217.37] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C7EFA3780BFE;
	Mon, 19 Feb 2024 12:33:49 +0000 (UTC)
Message-ID: <4a7926e3-f8b7-4df8-8deb-0dfae067e732@collabora.com>
Date: Mon, 19 Feb 2024 17:34:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Move test_dev_cgroup to prog_tests
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240215120233.308986-1-usama.anjum@collabora.com>
 <fa73d34f-e371-cc4b-afd1-c680a2edac56@iogearbox.net>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <fa73d34f-e371-cc4b-afd1-c680a2edac56@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you for review. I'll fix.

On 2/16/24 10:25 PM, Daniel Borkmann wrote:
> Hi Muhammad,
> 
> Small nit, pls use $subj: [PATCH bpf-next]
Sure, I'll update.

> 
> On 2/15/24 1:01 PM, Muhammad Usama Anjum wrote:
>> Move test_dev_cgroup to prog_tests to be able to run it with test_progs.
>> Replace dev_cgroup.bpf.o with skel header file, dev_cgroup.skel.h and
>> load program from it accourdingly.
>>
>>    ./test_progs -t test_dev_cgroup
>>    mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>    64+0 records in
>>    64+0 records out
>>    32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>>    dd: failed to open '/dev/full': Operation not permitted
>>    dd: failed to open '/dev/random': Operation not permitted
>>    #365     test_dev_cgroup:OK
>>    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> BPF CI currently fails this with :
> 
> https://github.com/kernel-patches/bpf/actions/runs/7924507406/job/21636353124
> 
>   [...]
>   All error logs:
>   test_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
>   test_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
>   test_test_dev_cgroup:PASS:bpf_attach 0 nsec
>   test_test_dev_cgroup:PASS:bpf_query 0 nsec
>   test_test_dev_cgroup:PASS:rm 0 nsec
>   test_test_dev_cgroup:PASS:mknod 0 nsec
>   test_test_dev_cgroup:PASS:rm 0 nsec
>   test_test_dev_cgroup:PASS:rm 0 nsec
>   test_test_dev_cgroup:FAIL:mknod unexpected mknod on _zero
>   test_test_dev_cgroup:PASS:rm 0 nsec
>   test_test_dev_cgroup:PASS:dd 0 nsec
>   test_test_dev_cgroup:PASS:dd 0 nsec
>   test_test_dev_cgroup:PASS:dd 0 nsec
>   (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
>   #366     test_dev_cgroup:FAIL
>   Summary: 517/3837 PASSED, 53 SKIPPED, 1 FAILED
> 
> You can also use vmtest.sh tool to check locally :
> 
>   # ./vmtest.sh -- ./test_progs -t test_dev_cgroup
It is passing on my side on next-20240207 and next-20240218. I'll test
again by running all the tests with test_progs. Maybe something else is
making it fail.

> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
>> b/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
>> new file mode 100644
>> index 0000000000000..ee37ce52dec9f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2017 Facebook
>> + */
>> +
>> +#include <test_progs.h>
>> +#include <time.h>
>> +#include "cgroup_helpers.h"
>> +#include "dev_cgroup.skel.h"
>> +
>> +#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
>> +
>> +void test_test_dev_cgroup(void)
> 
> nit: test_dev_cgroup ?
I was trying not to rename the file. I'll rename the file.

> 
>> +{
>> +    int cgroup_fd, err, duration = 0;
>> +    struct dev_cgroup *skel;
>> +    __u32 prog_cnt;
>> +
>> +    skel = dev_cgroup__open_and_load();
>> +    if (CHECK(!skel, "skel_open_and_load", "failed\n"))
>> +        goto cleanup;

> 
> Nit: please use ASSERT_* macros everywhere, the CHECK() is deprecated.
I'd not any deprecated notice/comment. I'll use ASSERT_* from now on.

> 
>> +    cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
>> +    if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "failed: %d\n",
>> cgroup_fd))
>> +        goto cleanup;
>> +
>> +    err = bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1),
>> cgroup_fd,
>> +                  BPF_CGROUP_DEVICE, 0);
>> +    if (CHECK(err, "bpf_attach", "failed: %d\n", err))
>> +        goto cleanup;
>> +
>> +    err = bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL,
>> &prog_cnt);
>> +    if (CHECK(err || prog_cnt != 1, "bpf_query", "failed: %d %d\n", err,
>> prog_cnt))
>> +        goto cleanup;
>> +
>> +    /* All operations with /dev/zero and /dev/urandom are allowed,
>> +     * everything else is forbidden.
>> +     */
>> +    CHECK(system("rm -f /tmp/test_dev_cgroup_null"), "rm",
>> +          "unexpected rm on _null\n");
>> +    CHECK(!system("mknod /tmp/test_dev_cgroup_null c 1 3"),
>> +          "mknod", "unexpected mknod on _null\n");
>> +    CHECK(system("rm -f /tmp/test_dev_cgroup_null"), "rm",
>> +          "unexpected rm on _null\n");
>> +
>> +    /* /dev/zero is whitelisted */
>> +    CHECK(system("rm -f /tmp/test_dev_cgroup_zero"), "rm",
>> +          "unexpected rm on _zero\n");
>> +    CHECK(system("mknod /tmp/test_dev_cgroup_zero c 1 5"),
>> +          "mknod", "unexpected mknod on _zero\n");
>> +    CHECK(system("rm -f /tmp/test_dev_cgroup_zero"), "rm",
>> +          "unexpected rm on _zero\n");
>> +
>> +    CHECK(system("dd if=/dev/urandom of=/dev/zero count=64"), "dd",
>> +          "unexpected dd on /dev/zero\n");
>> +
>> +    /* src is allowed, target is forbidden */
>> +    CHECK(!system("dd if=/dev/urandom of=/dev/full count=64"), "dd",
>> +          "unexpected dd on /dev/full\n");
>> +
>> +    /* src is forbidden, target is allowed */
>> +    CHECK(!system("dd if=/dev/random of=/dev/zero count=64"), "dd",
>> +          "unexpected dd on /dev/zero\n");
>> +
>> +cleanup:
>> +    cleanup_cgroup_environment();
>> +    dev_cgroup__destroy(skel);
>> +}
> 
> Thanks,
> Daniel
> 

-- 
BR,
Muhammad Usama Anjum

