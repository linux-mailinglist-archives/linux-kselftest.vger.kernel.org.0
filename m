Return-Path: <linux-kselftest+bounces-5536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627086AFFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0742E1F21623
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36E14D452;
	Wed, 28 Feb 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XYBUPHep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D414A4C9;
	Wed, 28 Feb 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125824; cv=none; b=W0Zx55j6CLsoAR0dFbXwJ7jl4+hNhSwfThwIfjsq3Kfrt2YBqHbavXHgfZCuNhiztkxhoUo+y5cenDZQ2z0l+h52YtJoGXwTJXn01YRi5HQPVU7LSYEulKOpCaq4VsAQUre4CQpH9Ltp1koHoRHOz2moTJf/bMITf93QUwvU5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125824; c=relaxed/simple;
	bh=KK4eUV2BkPuaHFWcsp8DbzSeNW1LjGIibof8skYkCrk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hh+iQCCGrrBzU87ZNmfgMNK9CQYzJ/AGrZw8aqxXDObWkDLdm/fd2BMg8Cdm3EX49W0Ba6I3VG3ZqLW+2YCr814h1EpyRdive8KQsKVxseSiiIY4Wl2Yj5HiUgKEffORobrslYX0g9h/+jcYnbqlfme0d7RjLL3EvB8BREi7r7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XYBUPHep; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709125819;
	bh=KK4eUV2BkPuaHFWcsp8DbzSeNW1LjGIibof8skYkCrk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XYBUPHepFB/FbuXIlOwXGmJFQBd2NtJRtbpn5gJNKX2wbYpzJgyGY7F7OoKKbCTNf
	 AYyHM+vds/M+jc6Z4jd4DnHIMxl4p9IIeDO9Ay/VJmrYBQgq2x1cPt6rTPN3ri1fiL
	 9wN3gnN6i37PANI6HilgOrS2rNplaRR9InQt85+tglY3xxwJhrkqDFItP+9Z4WyO8c
	 mFQtsi2i/W8FXsURb5h0/49sZa6GoRbNwosTS8Dh2M76hqL+n550Ff14beJQlp6Ash
	 Jt9eVc/d00f9QKQIlDJXNktDGmtQ2GiUFAeF7YQ3y1gEXg2EBhxk4KrmhiddslFlwQ
	 PYJTvHT73EqhQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A35D937820D4;
	Wed, 28 Feb 2024 13:10:09 +0000 (UTC)
Message-ID: <765ac086-621e-40b9-bbdf-bc1fbbdebf06@collabora.com>
Date: Wed, 28 Feb 2024 18:10:32 +0500
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
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Move test_dev_cgroup to
 prog_tests
Content-Language: en-US
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240221092248.1945364-1-usama.anjum@collabora.com>
 <a0fb8d9a-ae4d-4fc0-a921-efaa180e1bd7@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a0fb8d9a-ae4d-4fc0-a921-efaa180e1bd7@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 7:06 PM, Muhammad Usama Anjum wrote:
> On 2/21/24 2:22 PM, Muhammad Usama Anjum wrote:
>> Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
>> with test_progs. Replace dev_cgroup.bpf.o with skel header file,
>> dev_cgroup.skel.h and load program from it accourdingly.
>>
>>   ./test_progs -t test_dev_cgroup
>>   mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>   64+0 records in
>>   64+0 records out
>>   32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>>   dd: failed to open '/dev/full': Operation not permitted
>>   dd: failed to open '/dev/random': Operation not permitted
>>   #365     test_dev_cgroup:OK
>>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> I've tested the patch with vmtest.sh on bpf-next/for-next and linux
>> next. It is passing on both. Not sure why it was failed on BPFCI.
>> Test run with vmtest.h:
>> sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh ./test_progs -t dev_cgroup
>> ./test_progs -t dev_cgroup
>> mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>> 64+0 records in
>> 64+0 records out
>> 32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
>> dd: failed to open '/dev/full': Operation not permitted
>> dd: failed to open '/dev/random': Operation not permitted
>>  #69      dev_cgroup:OK
>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> Locally this test passes, but fails on BPFCI:
> https://github.com/kernel-patches/bpf/actions/runs/7986809998/job/21808178301#step:5:9744
The test run results with vmtest.sh and BPFCI are conflicting. What should
we do to debug the problem now? Any ideas are welcome.

I've tried to debug on my end. Not sure why it fails on the BPF CI.

> 
>>
>> Changes since v1:
>> - Rename file from test_dev_cgroup.c to dev_cgroup.c
>> - Use ASSERT_* in-place of CHECK
>> ---
>>  .../selftests/bpf/prog_tests/dev_cgroup.c     | 58 +++++++++++++
>>  tools/testing/selftests/bpf/test_dev_cgroup.c | 85 -------------------
>>  2 files changed, 58 insertions(+), 85 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
>>  delete mode 100644 tools/testing/selftests/bpf/test_dev_cgroup.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
>> new file mode 100644
>> index 0000000000000..980b015a116ff
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
>> @@ -0,0 +1,58 @@
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
>> +void test_dev_cgroup(void)
>> +{
>> +	struct dev_cgroup *skel;
>> +	int cgroup_fd, err;
>> +	__u32 prog_cnt;
>> +
>> +	skel = dev_cgroup__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>> +		goto cleanup;
>> +
>> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
>> +	if (!ASSERT_GT(cgroup_fd, 0, "cgroup_setup_and_join"))
>> +		goto cleanup;
>> +
>> +	err = bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1), cgroup_fd,
>> +			      BPF_CGROUP_DEVICE, 0);
>> +	if (!ASSERT_EQ(err, 0, "bpf_attach"))
>> +		goto cleanup;
>> +
>> +	err = bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL, &prog_cnt);
>> +	if (!ASSERT_EQ(err, 0, "bpf_query") || (!ASSERT_EQ(prog_cnt, 1, "bpf_query")))
>> +		goto cleanup;
>> +
>> +	/* All operations with /dev/zero and /dev/urandom are allowed,
>> +	 * everything else is forbidden.
>> +	 */
>> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_null"), 0, "rm");
>> +	ASSERT_NEQ(system("mknod /tmp/test_dev_cgroup_null c 1 3"), 0, "mknod");
>> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_null"), 0, "rm");
>> +
>> +	/* /dev/zero is whitelisted */
>> +	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_zero"), 0, "rm");
>> +	ASSERT_EQ(system("mknod /tmp/test_dev_cgroup_zero c 1 5"), 0, "mknod");
> Access to major number 1 and minor number 5 is allowed. The return code of
> 0 is expected, but on CI we are getting 256 which indicates error. mknod
> help page mentions the same:
> 
>> An exit status of zero indicates success, and a nonzero value indicates
> failure.
> 

-- 
BR,
Muhammad Usama Anjum

