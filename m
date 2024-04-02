Return-Path: <linux-kselftest+bounces-6990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66638957EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FB61C2150F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A9112C539;
	Tue,  2 Apr 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RBiDW8md"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6412BF26;
	Tue,  2 Apr 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070961; cv=none; b=Kav4utdzQTNGab6reTwQVvepAOlE67j7OpAjZonbfB6vEoRuAJNYQ99NK6IAgUUGWRyw0P0dyMg+gbluCUFWUbXi0VY69FkyH7Yu/gUgMw+gaRBcee3bNNa/tLqmB+MBXtPN62pjFORIAMdBLm0sQtZ2a8dNgGQ8tg5SHRL8QCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070961; c=relaxed/simple;
	bh=GXhvZfSf7YECAxV/84N1Fg6bLWjEnFuy4JkVVvzvWzQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BeToLwTQB7Ya+7p0S+yMSM6bMCAA8bmgNClBplwzjd8pbl0n7HVQ9p2YdIRB967pLWAQUzzrOChbJma6zorz7gx4TDcTBxgzZ2/yiIxqm/aHVEI6M5kXy0Xj6WAano6YUCs5+rjUSSM3ZkRkDVHGFmzyGd25Un2EGRso7LXz6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RBiDW8md; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712070958;
	bh=GXhvZfSf7YECAxV/84N1Fg6bLWjEnFuy4JkVVvzvWzQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RBiDW8mdInVUnysarnambAqLqWtsl+BAL08wH5uMBupCQ30qCIWbw52CF9D7BZ6kv
	 RQTil7RymCSw6D+fWT7D56AqssAyKEC5sKX7cW/OF0/W0NKTYTjwHIqQam8oHfwg6s
	 V7j9+JFaGf00zhjbSR5SS6JHPZwyqsutHN2h7+9Bnd1CrUsp7hDBL+ljqGDrUj+3eR
	 AOooX0th5M2jBtyXavfFBsOt608A59pOFpJv47Sled/ORbaYQrIdRYOfJH61x+k1x4
	 x8/wzhKv3EHE4pa2cjqqQNxiu16gzRDoVMj8MXKAQxEbcVhFyATy+Scl/ikPSdlYcV
	 boiUGJPkZ52Qw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 422FD3780626;
	Tue,  2 Apr 2024 15:15:54 +0000 (UTC)
Message-ID: <cfecd6ea-8fa3-477f-bd32-4087aefee2af@collabora.com>
Date: Tue, 2 Apr 2024 20:16:25 +0500
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
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Move test_dev_cgroup to
 prog_tests
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20240401123455.1377896-1-usama.anjum@collabora.com>
 <92e1cce6-5f26-4a49-86b6-81e1e80d1aaa@linux.dev>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <92e1cce6-5f26-4a49-86b6-81e1e80d1aaa@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Yonghong Song,

Thank you so much for replying. I was missing how to run pipeline manually.
Thanks a ton.

On 4/1/24 11:53 PM, Yonghong Song wrote:
> 
> On 4/1/24 5:34 AM, Muhammad Usama Anjum wrote:
>> Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
>> with test_progs. Replace dev_cgroup.bpf.o with skel header file,
>> dev_cgroup.skel.h and load program from it accourdingly.
>>
>>    ./test_progs -t dev_cgroup
>>    mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>    64+0 records in
>>    64+0 records out
>>    32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>>    dd: failed to open '/dev/full': Operation not permitted
>>    dd: failed to open '/dev/random': Operation not permitted
>>    #72     test_dev_cgroup:OK
>>    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v2:
>> - Replace test_dev_cgroup with serial_test_dev_cgroup as there is
>>    probability that the test is racing against another cgroup test
>> - Minor changes to the commit message above
>>
>> I've tested the patch with vmtest.sh on bpf-next/for-next and linux
>> next. It is passing on both. Not sure why it was failed on BPFCI.
>> Test run with vmtest.h:
>> sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
>> ./test_progs -t dev_cgroup
>> ./test_progs -t dev_cgroup
>> mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>> 64+0 records in
>> 64+0 records out
>> 32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
>> dd: failed to open '/dev/full': Operation not permitted
>> dd: failed to open '/dev/random': Operation not permitted
>>   #69      dev_cgroup:OK
>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> The CI failure:
> 
> 
> Error: #72 dev_cgroup
> serial_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
> serial_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
> serial_test_dev_cgroup:PASS:bpf_attach 0 nsec
> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
> serial_test_dev_cgroup:PASS:rm 0 nsec
> serial_test_dev_cgroup:PASS:mknod 0 nsec
> serial_test_dev_cgroup:PASS:rm 0 nsec
> serial_test_dev_cgroup:PASS:rm 0 nsec
> serial_test_dev_cgroup:FAIL:mknod unexpected mknod: actual 256 != expected 0
> serial_test_dev_cgroup:PASS:rm 0 nsec
> serial_test_dev_cgroup:PASS:dd 0 nsec
> serial_test_dev_cgroup:PASS:dd 0 nsec
> serial_test_dev_cgroup:PASS:dd 0 nsec
> 
> (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
> 
> The error code 256 means mknod execution has some issues. Maybe you need to
> find specific errno to find out what is going on. I think you can do ci
> on-demanding test to debug.
errno is 2 --> No such file or directory

Locally I'm unable to reproduce it until I don't remove
rm -f /tmp/test_dev_cgroup_zero such that the /tmp/test_dev_cgroup_zero
node is present before test execution. The error code is 256 with errno 2.
I'm debugging by placing system("ls /tmp 1>&2"); to find out which files
are already present in /tmp. But ls's output doesn't appear on the CI logs.

> 
> https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst
> 

-- 
BR,
Muhammad Usama Anjum

