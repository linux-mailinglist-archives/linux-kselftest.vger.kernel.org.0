Return-Path: <linux-kselftest+bounces-9373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29E8BAE3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A6B22B62
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273D15444B;
	Fri,  3 May 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LrwH/3mn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751051DA21;
	Fri,  3 May 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744567; cv=none; b=fDcX2ymBE0NqDD8i+m45v+5albMtMDb/USJg9eZzQJvG18UpLR983epfbe72xs4/zLrj0rZmYPdIKyXJdRsjOVwq5ErDbdN2JMITM1aJ7XjfC6XUkqnvv6Y1oshjbxaQQm10at8IK52rZOYE1GiHXhAr3LI/kIHbpcxxATG9Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744567; c=relaxed/simple;
	bh=Y96AOJn77GLmUXEHBQutWKub1WKq1hWJmHUqVNR3Y1k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BAbahciPbzsI8MuY+WbxVnXc/nQDia0TYC9tgicebRWrhoQtN0j7Arkt5EKcEfSrfS3MTOiAL3Q6qfoU5LEFZMbH0+DhtRvLwHnYbeYJ/uHEI/MrQgO3sPIL11G5ecY7SpZdFC8Bos5CHDlKHbm3zdinKetz/GQ3ZFiMe3/Seic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LrwH/3mn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714744558;
	bh=Y96AOJn77GLmUXEHBQutWKub1WKq1hWJmHUqVNR3Y1k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=LrwH/3mnfPFWqlO5VtTiuRGi9MobTvoBHFrIB76DM6IOY+OUEJR0aAjTboy988yxP
	 QSMEaZ3YNliz8x2SL9d2ztlpuXyVPx0TUKok84aJeR0FOwlO24eYgbvNLSwPkcfxPG
	 pRCOxnEBERINg0V91bymWGUP03rFYdGMavMztrpWxRtbmoSM+hRbtTmAq6rx4xwvDr
	 J3mNBr0h1epQC8Zio6mZvPLIiBsx75G9tiepMv+ebSGKARKHLP4txvVH+ee64mNfr3
	 4tOdpC/q3rPmtqELML2YsgF4rCCSp86E4EPPbvcu+OoflwW3KnSsogQtvbsVCYas1C
	 JlVqryH+wLruA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A0D33782135;
	Fri,  3 May 2024 13:55:47 +0000 (UTC)
Message-ID: <b4d7ce70-3320-4333-9589-b5df187409fe@collabora.com>
Date: Fri, 3 May 2024 18:55:59 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240401123455.1377896-1-usama.anjum@collabora.com>
 <92e1cce6-5f26-4a49-86b6-81e1e80d1aaa@linux.dev>
 <cfecd6ea-8fa3-477f-bd32-4087aefee2af@collabora.com>
 <0ff5c7d0-d5c5-4b61-ba89-8e7f9f775935@linux.dev>
 <0973bc93-7a8d-451c-9944-d91a77d68755@collabora.com>
 <ff36e8fa-14f4-42a6-8210-cec24a7779a0@linux.dev>
Content-Language: en-US
In-Reply-To: <ff36e8fa-14f4-42a6-8210-cec24a7779a0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/5/24 1:06 AM, Yonghong Song wrote:
> 
> On 4/3/24 5:03 AM, Muhammad Usama Anjum wrote:
>> On 4/3/24 7:36 AM, Yonghong Song wrote:
>>> On 4/2/24 8:16 AM, Muhammad Usama Anjum wrote:
>>>> Yonghong Song,
>>>>
>>>> Thank you so much for replying. I was missing how to run pipeline
>>>> manually.
>>>> Thanks a ton.
>>>>
>>>> On 4/1/24 11:53 PM, Yonghong Song wrote:
>>>>> On 4/1/24 5:34 AM, Muhammad Usama Anjum wrote:
>>>>>> Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
>>>>>> with test_progs. Replace dev_cgroup.bpf.o with skel header file,
>>>>>> dev_cgroup.skel.h and load program from it accourdingly.
>>>>>>
>>>>>>      ./test_progs -t dev_cgroup
>>>>>>      mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>>>>>      64+0 records in
>>>>>>      64+0 records out
>>>>>>      32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
>>>>>>      dd: failed to open '/dev/full': Operation not permitted
>>>>>>      dd: failed to open '/dev/random': Operation not permitted
>>>>>>      #72     test_dev_cgroup:OK
>>>>>>      Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>>> ---
>>>>>> Changes since v2:
>>>>>> - Replace test_dev_cgroup with serial_test_dev_cgroup as there is
>>>>>>      probability that the test is racing against another cgroup test
>>>>>> - Minor changes to the commit message above
>>>>>>
>>>>>> I've tested the patch with vmtest.sh on bpf-next/for-next and linux
>>>>>> next. It is passing on both. Not sure why it was failed on BPFCI.
>>>>>> Test run with vmtest.h:
>>>>>> sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
>>>>>> ./test_progs -t dev_cgroup
>>>>>> ./test_progs -t dev_cgroup
>>>>>> mknod: /tmp/test_dev_cgroup_null: Operation not permitted
>>>>>> 64+0 records in
>>>>>> 64+0 records out
>>>>>> 32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
>>>>>> dd: failed to open '/dev/full': Operation not permitted
>>>>>> dd: failed to open '/dev/random': Operation not permitted
>>>>>>     #69      dev_cgroup:OK
>>>>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>>>> The CI failure:
>>>>>
>>>>>
>>>>> Error: #72 dev_cgroup
>>>>> serial_test_dev_cgroup:PASS:skel_open_and_load 0 nsec
>>>>> serial_test_dev_cgroup:PASS:cgroup_setup_and_join 0 nsec
>>>>> serial_test_dev_cgroup:PASS:bpf_attach 0 nsec
>>>>> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
>>>>> serial_test_dev_cgroup:PASS:bpf_query 0 nsec
>>>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>>>> serial_test_dev_cgroup:PASS:mknod 0 nsec
>>>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>>>> serial_test_dev_cgroup:FAIL:mknod unexpected mknod: actual 256 !=
>>>>> expected 0
>>>>> serial_test_dev_cgroup:PASS:rm 0 nsec
>>>>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>>>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>>>> serial_test_dev_cgroup:PASS:dd 0 nsec
>>>>>
>>>>> (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
>>>>>
>>>>> The error code 256 means mknod execution has some issues. Maybe you
>>>>> need to
>>>>> find specific errno to find out what is going on. I think you can do ci
>>>>> on-demanding test to debug.
>>>> errno is 2 --> No such file or directory
>>>>
>>>> Locally I'm unable to reproduce it until I don't remove
>>>> rm -f /tmp/test_dev_cgroup_zero such that the /tmp/test_dev_cgroup_zero
>>>> node is present before test execution. The error code is 256 with errno 2.
>>>> I'm debugging by placing system("ls /tmp 1>&2"); to find out which files
>>>> are already present in /tmp. But ls's output doesn't appear on the CI
>>>> logs.
>>> errno 2 means ENOENT.
>>>  From mknod man page (https://linux.die.net/man/2/mknod), it means
>>>    A directory component in/pathname/  does not exist or is a dangling
>>> symbolic link.
>>>
>>> It means /tmp does not exist or a dangling symbolic link.
>>> It is indeed very strange. To make the test robust, maybe creating a temp
>>> directory with mkdtemp and use it as the path? The temp directory
>>> creation should be done before bpf prog attach.
>> I've tried following but still no luck:
>> * /tmp is already present. Then I thought maybe the desired file is already
>> present. I've verified that there isn't file of same name is present inside
>> /tmp.
>> * I thought maybe mknod isn't present in the system. But mknod --help
>> succeeds.
>> * I switched from /tmp to current directory to create the mknod. But the
>> result is same error.
>> * I've tried to use the same kernel config as the BPF CI is using. I'm not
>> able to reproduce it.
>>
>> Not sure which edge case or what's going on. The problem is appearing
>> because of some limitation in the rootfs.
> 
> Maybe you could collect /tmp mount options to see whether anything is
> suspicious? In my vm, I have
>   tmpfs on /tmp type tmpfs (rw,nosuid,nodev,size=3501540k,nr_inodes=1048576)
> and the test works fine.
> 
> 
My test system:
tmpfs /tmp tmpfs rw,relatime 0 0

On the CI, /tmp is present. But it isn't tmpfs. Following shows the logs
from /proc/mounts

On CI:
  /dev/root / 9p
rw,relatime,cache=f,access=client,msize=512000,trans=virtio 0 0
  devtmpfs /dev devtmpfs
rw,relatime,size=1998612k,nr_inodes=499653,mode=755 0 0
  tmpfs /dev/shm tmpfs rw,nosuid,nodev,relatime 0 0
  proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
  tmpfs /run tmpfs rw,nosuid,nodev,relatime 0 0
  tmpfs /run/netns tmpfs rw,nosuid,nodev,relatime 0 0
  sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
  debugfs /sys/kernel/debug debugfs rw,relatime 0 0
  tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0
  cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime 0 0
  tmpfs /sys/fs/cgroup tmpfs rw,relatime 0 0
  net_cls /sys/fs/cgroup/net_cls cgroup rw,relatime,net_cls 0 0
  tmpfs /sys/fs/cgroup tmpfs rw,relatime 0 0
  net_cls /sys/fs/cgroup/net_cls cgroup rw,relatime,net_cls 0 0
  tmpfs /sys/fs/cgroup tmpfs rw,relatime 0 0
  net_cls /sys/fs/cgroup/net_cls cgroup rw,relatime,net_cls 0 0
  bpffs /sys/fs/bpf bpf rw,relatime 0 0
  bpf /sys/fs/bpf bpf rw,relatime 0 0
  tmpfs /mnt tmpfs rw,nosuid,nodev,relatime 0 0
  vmtest-shared /mnt/vmtest 9p
rw,relatime,cache=f,access=client,msize=512000,trans=virtio 0 0
  none /mnt cgroup2 rw,relatime 0 0

-- 
BR,
Muhammad Usama Anjum

