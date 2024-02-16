Return-Path: <linux-kselftest+bounces-4873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A63858413
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB391C228F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C6B13173A;
	Fri, 16 Feb 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="d0Ilkjcx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEE130ACF;
	Fri, 16 Feb 2024 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104371; cv=none; b=ArBRaWh7lrMSID62IPL1s02kMCm8fFxFHQpI3iBpmM96pXnR+klU3RZzUOaEuzov/O2+5J4I8Bw7aDJUENvL9c7CNp77YTIT4smHcfvDzy/MLnkxEV725stiW8g7mQy1Kkr3osjOLUVHEM01FDWJAGjt3v4EVYBeSaJeHtj3lT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104371; c=relaxed/simple;
	bh=EnAGvR0/eYsnsKTWDYoVaXsElSFy9rLg/H5Yxus1K5g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uT/nRp5ItRRVPYYKBbjMNXfXYoG0oryUj70oXPX1bbEFs+2KqXCdJ1qpJyQfFhhADVkbkkWNEyk8sL+WFsVa6udsaL6GUunnK8jQOf2iDRD5hff9NMaWCYxjLI+mBHJvvW01UPEgQtDLba/CQOe2jY+FoUB41XseuooeqBUcbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=d0Ilkjcx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jTSYqgmQXnfMlKM2Ji03sz4Up9QOJAvMc8kMEp5l0Tk=; b=d0IlkjcxkeGzt/6AyHiyJ4HT9f
	wgavh6aRLrUJkNNeMzcLwNsXjLpHeW9CIAsxy7GZVHbQUHWuaqXeILNogFYsZMkuttHv2mBN2cZFo
	qEpl0xtohs2yIdRGVCDPZUv974awl5z4cfkjOm860EAcZwnJxXr26j5u+RyB4lmCWuveQd1x8+PZF
	GtLtpixdcna9FGE32n2SMHrO+UeFG7wKsblrkTsXPw7NXdUWkhG2hsCfDgbL0LtDdcPQmPli+K0Go
	Y/AsD+c07dnHiFsPWO3yiRFNqETOJ7hDuoPlcEaE3kkLBXUSACKD4jkVAQur3BWZqs0339gk+UhVe
	1NyL+WcQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rb1y6-000HMl-AI; Fri, 16 Feb 2024 18:25:46 +0100
Received: from [178.197.249.30] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rb1y4-000IZc-ND; Fri, 16 Feb 2024 18:25:44 +0100
Subject: Re: [PATCH] selftests/bpf: Move test_dev_cgroup to prog_tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240215120233.308986-1-usama.anjum@collabora.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fa73d34f-e371-cc4b-afd1-c680a2edac56@iogearbox.net>
Date: Fri, 16 Feb 2024 18:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215120233.308986-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27187/Fri Feb 16 10:23:45 2024)

Hi Muhammad,

Small nit, pls use $subj: [PATCH bpf-next]

On 2/15/24 1:01 PM, Muhammad Usama Anjum wrote:
> Move test_dev_cgroup to prog_tests to be able to run it with test_progs.
> Replace dev_cgroup.bpf.o with skel header file, dev_cgroup.skel.h and
> load program from it accourdingly.
> 
>    ./test_progs -t test_dev_cgroup
>    mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>    64+0 records in
>    64+0 records out
>    32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>    dd: failed to open '/dev/full': Operation not permitted
>    dd: failed to open '/dev/random': Operation not permitted
>    #365     test_dev_cgroup:OK
>    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

BPF CI currently fails this with :

https://github.com/kernel-patches/bpf/actions/runs/7924507406/job/21636353124

   [...]
   All error logs:
   test_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
   test_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
   test_test_dev_cgroup:PASS:bpf_attach 0 nsec
   test_test_dev_cgroup:PASS:bpf_query 0 nsec
   test_test_dev_cgroup:PASS:rm 0 nsec
   test_test_dev_cgroup:PASS:mknod 0 nsec
   test_test_dev_cgroup:PASS:rm 0 nsec
   test_test_dev_cgroup:PASS:rm 0 nsec
   test_test_dev_cgroup:FAIL:mknod unexpected mknod on _zero
   test_test_dev_cgroup:PASS:rm 0 nsec
   test_test_dev_cgroup:PASS:dd 0 nsec
   test_test_dev_cgroup:PASS:dd 0 nsec
   test_test_dev_cgroup:PASS:dd 0 nsec
   (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
   #366     test_dev_cgroup:FAIL
   Summary: 517/3837 PASSED, 53 SKIPPED, 1 FAILED

You can also use vmtest.sh tool to check locally :

   # ./vmtest.sh -- ./test_progs -t test_dev_cgroup

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c b/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
> new file mode 100644
> index 0000000000000..ee37ce52dec9f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
> @@ -0,0 +1,67 @@
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
> +void test_test_dev_cgroup(void)

nit: test_dev_cgroup ?

> +{
> +	int cgroup_fd, err, duration = 0;
> +	struct dev_cgroup *skel;
> +	__u32 prog_cnt;
> +
> +	skel = dev_cgroup__open_and_load();
> +	if (CHECK(!skel, "skel_open_and_load", "failed\n"))
> +		goto cleanup;

Nit: please use ASSERT_* macros everywhere, the CHECK() is deprecated.

> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> +	if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "failed: %d\n", cgroup_fd))
> +		goto cleanup;
> +
> +	err = bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1), cgroup_fd,
> +			      BPF_CGROUP_DEVICE, 0);
> +	if (CHECK(err, "bpf_attach", "failed: %d\n", err))
> +		goto cleanup;
> +
> +	err = bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL, &prog_cnt);
> +	if (CHECK(err || prog_cnt != 1, "bpf_query", "failed: %d %d\n", err, prog_cnt))
> +		goto cleanup;
> +
> +	/* All operations with /dev/zero and /dev/urandom are allowed,
> +	 * everything else is forbidden.
> +	 */
> +	CHECK(system("rm -f /tmp/test_dev_cgroup_null"), "rm",
> +	      "unexpected rm on _null\n");
> +	CHECK(!system("mknod /tmp/test_dev_cgroup_null c 1 3"),
> +	      "mknod", "unexpected mknod on _null\n");
> +	CHECK(system("rm -f /tmp/test_dev_cgroup_null"), "rm",
> +	      "unexpected rm on _null\n");
> +
> +	/* /dev/zero is whitelisted */
> +	CHECK(system("rm -f /tmp/test_dev_cgroup_zero"), "rm",
> +	      "unexpected rm on _zero\n");
> +	CHECK(system("mknod /tmp/test_dev_cgroup_zero c 1 5"),
> +	      "mknod", "unexpected mknod on _zero\n");
> +	CHECK(system("rm -f /tmp/test_dev_cgroup_zero"), "rm",
> +	      "unexpected rm on _zero\n");
> +
> +	CHECK(system("dd if=/dev/urandom of=/dev/zero count=64"), "dd",
> +	      "unexpected dd on /dev/zero\n");
> +
> +	/* src is allowed, target is forbidden */
> +	CHECK(!system("dd if=/dev/urandom of=/dev/full count=64"), "dd",
> +	      "unexpected dd on /dev/full\n");
> +
> +	/* src is forbidden, target is allowed */
> +	CHECK(!system("dd if=/dev/random of=/dev/zero count=64"), "dd",
> +	      "unexpected dd on /dev/zero\n");
> +
> +cleanup:
> +	cleanup_cgroup_environment();
> +	dev_cgroup__destroy(skel);
> +}

Thanks,
Daniel

