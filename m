Return-Path: <linux-kselftest+bounces-7074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F76896E9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A64B2883EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005214389D;
	Wed,  3 Apr 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bpE9DVA1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03128143891;
	Wed,  3 Apr 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145803; cv=none; b=unJ6CfDnW69Qd0xxsHBXmXhB7ZcKZxa1KtpYPzWywfKQxkg9X7RYQLYt3UsEHfgNBU+6TjsEj+sFwvsiEf0SVglGlqH/cA2pgBDkUquYMzJFMKJnC/WZrkaETMUB2Bqlpa8quPpUBhi5g7VScbdg/UO0snYzBiV8RDf83BUZp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145803; c=relaxed/simple;
	bh=D8JcvGnos85x/xHOg2VRBE+/AMYBGSruLas7Gv8Wl3M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eBzlNMsOd9UyzYGHkbPObT3tfaMpkiTeHu9Ha4VkjQuYtsaQcer6gEZqFW7iQoeOfgudvbEqwAuUV5V2JhPDf5sa1Nq5HYJE9xq2LjxUuNRb5McEPrjt32ghFlNC150vIAKLTevMdfw/1WWhS9zNOZz+nh+7C/Zf8RPTZMxqrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bpE9DVA1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712145800;
	bh=D8JcvGnos85x/xHOg2VRBE+/AMYBGSruLas7Gv8Wl3M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bpE9DVA1wVE+ONFOew3o8FPKy/OBkzhFc9BPiU+mJuojFnKOcgJVcZ44AkGpiamvM
	 mwcrjf1SqA352rdfGrHW9gHIwdfYMsqeZhowDfyxMwusVfQ+DGF8kPiKMMLZ8i4T6u
	 0eRNqtIIOIO5d2ZCSFpIrIggW3p7h5nk7BlZQ2PIfY9Sw1oNM6zMjlFhgSFJSD9hqe
	 3c920tvSsFh8ip918CWZYe7YGTiGO0vP7g9V+6p3a+WNVw0jZtOvW/CrmZxvRYPUhf
	 O0qIt7NPQFuZtmSWEe7amev2bL0Z9dVGF/PHu16AHeQfI+4txkRh3K6yPoLWn03F0U
	 bIzOu/8+Vy3aA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45EEF37820E7;
	Wed,  3 Apr 2024 12:03:14 +0000 (UTC)
Message-ID: <0973bc93-7a8d-451c-9944-d91a77d68755@collabora.com>
Date: Wed, 3 Apr 2024 17:03:34 +0500
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
 <cfecd6ea-8fa3-477f-bd32-4087aefee2af@collabora.com>
 <0ff5c7d0-d5c5-4b61-ba89-8e7f9f775935@linux.dev>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0ff5c7d0-d5c5-4b61-ba89-8e7f9f775935@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/24 7:36 AM, Yonghong Song wrote:
> 
> On 4/2/24 8:16 AM, Muhammad Usama Anjum wrote:
>> Yonghong Song,
>>
>> Thank you so much for replying. I was missing how to run pipeline manually.
>> Thanks a ton.
>>
>> On 4/1/24 11:53 PM, Yonghong Song wrote:
>>> On 4/1/24 5:34 AM, Muhammad Usama Anjum wrote:
>>>> Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
>>>> with test_progs. Replace dev_cgroup.bpf.o with skel header file,
>>>> dev_cgroup.skel.h and load program from it accourdingly.
>>>>
>>>>     ./test_progs -t dev_cgroup
>>>>     mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>>>     64+0 records in
>>>>     64+0 records out
>>>>     32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>>>>     dd: failed to open '/dev/full': Operation not permitted
>>>>     dd: failed to open '/dev/random': Operation not permitted
>>>>     #72     test_dev_cgroup:OK
>>>>     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> Changes since v2:
>>>> - Replace test_dev_cgroup with serial_test_dev_cgroup as there is
>>>>     probability that the test is racing against another cgroup test
>>>> - Minor changes to the commit message above
>>>>
>>>> I've tested the patch with vmtest.sh on bpf-next/for-next and linux
>>>> next. It is passing on both. Not sure why it was failed on BPFCI.
>>>> Test run with vmtest.h:
>>>> sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
>>>> ./test_progs -t dev_cgroup
>>>> ./test_progs -t dev_cgroup
>>>> mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>>> 64+0 records in
>>>> 64+0 records out
>>>> 32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
>>>> dd: failed to open '/dev/full': Operation not permitted
>>>> dd: failed to open '/dev/random': Operation not permitted
>>>>    #69      dev_cgroup:OK
>>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>> The CI failure:
>>>
>>>
>>> Error: #72 dev_cgroup
>>> serial_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
>>> serial_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
>>> serial_test_dev_cgroup:PASS:bpf_attach 0 nsec
>>> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
>>> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>> serial_test_dev_cgroup:PASS:mknod 0 nsec
>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>> serial_test_dev_cgroup:FAIL:mknod unexpected mknod: actual 256 !=
>>> expected 0
>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>>
>>> (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
>>>
>>> The error code 256 means mknod execution has some issues. Maybe you need to
>>> find specific errno to find out what is going on. I think you can do ci
>>> on-demanding test to debug.
>> errno is 2 --> No such file or directory
>>
>> Locally I'm unable to reproduce it until I don't remove
>> rm -f /tmp/test_dev_cgroup_zero such that the /tmp/test_dev_cgroup_zero
>> node is present before test execution. The error code is 256 with errno 2.
>> I'm debugging by placing system("ls /tmp 1>&2"); to find out which files
>> are already present in /tmp. But ls's output doesn't appear on the CI logs.
> 
> errno 2 means ENOENT.
> From mknod man page (https://linux.die.net/man/2/mknod), it means
>   A directory component in/pathname/  does not exist or is a dangling
> symbolic link.
> 
> It means /tmp does not exist or a dangling symbolic link.
> It is indeed very strange. To make the test robust, maybe creating a temp
> directory with mkdtemp and use it as the path? The temp directory
> creation should be done before bpf prog attach.
I've tried following but still no luck:
* /tmp is already present. Then I thought maybe the desired file is already
present. I've verified that there isn't file of same name is present inside
/tmp.
* I thought maybe mknod isn't present in the system. But mknod --help succeeds.
* I switched from /tmp to current directory to create the mknod. But the
result is same error.
* I've tried to use the same kernel config as the BPF CI is using. I'm not
able to reproduce it.

Not sure which edge case or what's going on. The problem is appearing
because of some limitation in the rootfs.

-- 
BR,
Muhammad Usama Anjum

