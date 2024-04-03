Return-Path: <linux-kselftest+bounces-7042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D429896297
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8AE1C226B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E41946B;
	Wed,  3 Apr 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E5M+NuBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EF8F5C
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111797; cv=none; b=ZNhScQ8FdPcFZ+m/evvLtms7bUXB4XBv6mvtiWrPc+V8qSNvFl1OQ/MI0tnDMVvy2TrwGBz5Bc2nAOehirvnROBK2dkP4C1X2SrFKBiCiYmPMS1wxeC4KenIoHZApDeFb53SFbrwta994h9uUkMbXgFoH7xJN0KMrbmV7BeRgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111797; c=relaxed/simple;
	bh=v1FwLXD50NO9luX+AI1VLN7M8+i7rdVy2kSk3KTuBsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT/rxRC2BzXap4XJL2fMnKEO/IAqvnn8zug3O6NNfDl+P4iBskD9Mxd+GWtGtdhxczs+UoYAX/iXVNVQuEs5qkWtZbu9YwiyNOB0COnzxjAdeC/C2gxD4sAEqASGAmcUv4no027D681PxMun+wYtfeQ1fbZbKX1OLJ/wvN6TTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E5M+NuBA; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ff5c7d0-d5c5-4b61-ba89-8e7f9f775935@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712111792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfHvT/jVYTAVwJfVnK1fJm36xybc1LXtp2oO10me4iA=;
	b=E5M+NuBAigl3MEzyNZp/UeTECwdAAUVoj//2JZ4JgM6nj5WVaHI3DkrE/gomqaVgObwVxK
	YtdxhjJu4Bq6FLnD85jUSWtI6+W7GxFru1lAZHE+69LWvVmC6C+fhgxXRpNnXgr0oQ1s3w
	f1V/Pofb9JlmRQDU9EzUP955YnZKJvw=
Date: Tue, 2 Apr 2024 19:36:25 -0700
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
 <92e1cce6-5f26-4a49-86b6-81e1e80d1aaa@linux.dev>
 <cfecd6ea-8fa3-477f-bd32-4087aefee2af@collabora.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cfecd6ea-8fa3-477f-bd32-4087aefee2af@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/2/24 8:16 AM, Muhammad Usama Anjum wrote:
> Yonghong Song,
>
> Thank you so much for replying. I was missing how to run pipeline manually.
> Thanks a ton.
>
> On 4/1/24 11:53 PM, Yonghong Song wrote:
>> On 4/1/24 5:34 AM, Muhammad Usama Anjum wrote:
>>> Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
>>> with test_progs. Replace dev_cgroup.bpf.o with skel header file,
>>> dev_cgroup.skel.h and load program from it accourdingly.
>>>
>>>     ./test_progs -t dev_cgroup
>>>     mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>>     64+0 records in
>>>     64+0 records out
>>>     32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>>>     dd: failed to open '/dev/full': Operation not permitted
>>>     dd: failed to open '/dev/random': Operation not permitted
>>>     #72     test_dev_cgroup:OK
>>>     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v2:
>>> - Replace test_dev_cgroup with serial_test_dev_cgroup as there is
>>>     probability that the test is racing against another cgroup test
>>> - Minor changes to the commit message above
>>>
>>> I've tested the patch with vmtest.sh on bpf-next/for-next and linux
>>> next. It is passing on both. Not sure why it was failed on BPFCI.
>>> Test run with vmtest.h:
>>> sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
>>> ./test_progs -t dev_cgroup
>>> ./test_progs -t dev_cgroup
>>> mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>> 64+0 records in
>>> 64+0 records out
>>> 32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
>>> dd: failed to open '/dev/full': Operation not permitted
>>> dd: failed to open '/dev/random': Operation not permitted
>>>    #69      dev_cgroup:OK
>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>> The CI failure:
>>
>>
>> Error: #72 dev_cgroup
>> serial_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
>> serial_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
>> serial_test_dev_cgroup:PASS:bpf_attach 0 nsec
>> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
>> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
>> serial_test_dev_cgroup:PASS:rm 0 nsec
>> serial_test_dev_cgroup:PASS:mknod 0 nsec
>> serial_test_dev_cgroup:PASS:rm 0 nsec
>> serial_test_dev_cgroup:PASS:rm 0 nsec
>> serial_test_dev_cgroup:FAIL:mknod unexpected mknod: actual 256 != expected 0
>> serial_test_dev_cgroup:PASS:rm 0 nsec
>> serial_test_dev_cgroup:PASS:dd 0 nsec
>> serial_test_dev_cgroup:PASS:dd 0 nsec
>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>
>> (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
>>
>> The error code 256 means mknod execution has some issues. Maybe you need to
>> find specific errno to find out what is going on. I think you can do ci
>> on-demanding test to debug.
> errno is 2 --> No such file or directory
>
> Locally I'm unable to reproduce it until I don't remove
> rm -f /tmp/test_dev_cgroup_zero such that the /tmp/test_dev_cgroup_zero
> node is present before test execution. The error code is 256 with errno 2.
> I'm debugging by placing system("ls /tmp 1>&2"); to find out which files
> are already present in /tmp. But ls's output doesn't appear on the CI logs.

errno 2 means ENOENT.
 From mknod man page (https://linux.die.net/man/2/mknod), it means
   A directory component in/pathname/  does not exist or is a dangling symbolic link.

It means /tmp does not exist or a dangling symbolic link.
It is indeed very strange. To make the test robust, maybe creating a temp
directory with mkdtemp and use it as the path? The temp directory
creation should be done before bpf prog attach.

>
>> https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst
>>

