Return-Path: <linux-kselftest+bounces-34026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B2AC8601
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC231BA523D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901E170A2B;
	Fri, 30 May 2025 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xdkkHen9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634819475;
	Fri, 30 May 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748568602; cv=none; b=ESU3qWpx5tBbbXjKlNBD8+fpRhlIsUWSOOMgk4Kq6bp2cyXpe5k9BJFE1me1NTkjBRru9WqTlhAF0dHUqffwp5Q8OjdMN1x5FXFS6lgXGqAJOPoIpHjvg2cerAVe51Cqidup/aEFwbQsaUJv7cTpsoObohdHSHRK6uhFL6kcgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748568602; c=relaxed/simple;
	bh=+TFmXCqtLZ8kiawumxahT/VHs4zh/m9qAIziG3dAgZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuZKny8ne0zOvf4+rNrARZ3Y+r8RrqP/Af8NBZZ7BuCmh1VwnR92jW6Vj4Rdkdvl48JEpPW6lMuoq5mA/YOlzYYqarOKPQQmIZ2rl8UANm9GNInJ1RdQJrB1aFtfigHbL7X+hYitGIdxKrGpQ9nk2XXGxm4JxzmcdnzB6BvDQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xdkkHen9; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748568593;
	bh=d/Y6VEfM9SurICbLntJEFopmvBrML0o9kXS3a5I2T2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=xdkkHen9UG2KjxWMfMvZ5YARakhb8PatUjAHYFje7i76H7eJT6+Icn++Egrnx39tZ
	 +V1dznCbPlCFgW6cSmxg7w2T6Dhi30Gt27N42POeGCXqQnD4unW7D7LYqMAEKVO7Dv
	 9/mkbpDNpC5hNewiwMIXry9WIQs9MFuN2biB14KU=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 7288748B; Fri, 30 May 2025 09:28:40 +0800
X-QQ-mid: xmsmtpt1748568520tyjwdxpn4
Message-ID: <tencent_C8CF57BAD10D440E8308A19E2C894B341507@qq.com>
X-QQ-XMAILINFO: No4GWyI4cWt6a1L7H8fewm5WKIVIP5BHfKlE5bVXolURhqFbtLdqoSpronad9P
	 1nt257iai3dasHZFj9kwS+xbRum60Y1KIE5k3f8JXobZBQgIgiQtjMwBst+ken4NniB8kRBJuDki
	 0zGqlD1aPCHtrFbF8CaRM1dkWhV3UJ6zAnwUdyCDUis3Za1r/MThHGN3vItxT104WZL5JF+pTMY6
	 7hzBIV0KawuuI90BU5X22AAAHMFW00VEAjBPHIDS9JDVL88xhGmrjPnDqESg+C1YrF9OcpnWgUem
	 FaEAbGpB6gEETDzK9V4qEDwheu7Q8xXfugm0QwTxZnEU/foIEJBAjqWZCQWn/Pl7WoGqgsg4+O1E
	 5Nj3o5kne+KI17XcxTgtJwVeVwKkQRjaqBSW3CJi/8+I7XDy9QEXova7zRaOoEOs4X2/BF0EdXm0
	 fThHL0fKhzplL5EO9yha3uQfPJ5M0cb5UvSDxjS8p7BQxdXT1LnOqwBv7Vgej6BkW3EMCHCI+FxJ
	 j6VDlYnnM7q4C4icf9Og/nDokfwwqf55VRPaE2H4f+YTlC8AGdo4vTWItFuNI8Yxj3lt/ZYALC7s
	 qUWg2gdaurJygWthl0YYoblsGZmsQedhWiAPI1vBy2+WO1nPfGhE1ZY1j5EOoYWTvGi2+Hs+e/Px
	 u0EjoyrsDRheZqrRBtYi2MSSz0rUToiZ8GAe0g6LKLtyDyl7/DNII3Zzh8rwawyEF1dFuztoPiUo
	 I7JTzPjiZafIvNkMLQIJHfpEzQkJzVhCpyPfcd18JIfR2M+ClA62QyNNr0I/fgmfbslFw4X0Xl90
	 Kl425X80hC7pQ1RY8n4wt4TuEv49HFMrTB314ARKX8cWzqzdvAvglitqy8e3qxGyYO862kDADT6K
	 pcs2avJEaN+FQX9+txltkXZv1AmbQb1nfBWzrZ0XD+kKF272NGwkfpgIKRmPUPjv33NTzZx8qDiR
	 3qPfF8n22JUZ9p+Y0tmrPHh1++cFl8xFBqDC+qRg8F5xQld4yqiaUVUZoxvcp/
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <0a5e325f-9567-4cfa-9e34-08e0258a96f0@foxmail.com>
Date: Fri, 30 May 2025 09:28:40 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, rongtao@cestc.cn,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Juntong Deng <juntong.deng@outlook.com>,
 Amery Hung <amery.hung@bytedance.com>,
 Dave Marchevsky <davemarchevsky@fb.com>, Hou Tao <houtao1@huawei.com>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1748488784.git.rtoax@foxmail.com>
 <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>
 <CAADnVQ+hUk2wV3M+9mgv_i5sNt_FuHpAnDpkQJ22D37bxAJHsQ@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAADnVQ+hUk2wV3M+9mgv_i5sNt_FuHpAnDpkQJ22D37bxAJHsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/29/25 13:44, Alexei Starovoitov wrote:
> On Wed, May 28, 2025 at 8:37 PM Rong Tao <rtoax@foxmail.com> wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> It is a bit troublesome to get cwd based on pid in bpf program, such as
>> bpftrace example [1].
>>
>> This patch therefore adds a new bpf_task_cwd_from_pid() kfunc which
>> allows BPF programs to get cwd from a pid.
>>
>> [1] https://github.com/bpftrace/bpftrace/issues/3314
> Yes. This is cumbersome, but adding a very specific kfunc
> to the kernel is not a solution.
> This is tracing, no need for precise cwd. probe_read_kernel
> can do the job. bpftrace needs to have better C interop.
> Once that happens any kind of tracing extraction will be
> easy to write in C. Like this bpf_task_cwd_from_pid()
> can already be written as C bpf program.
Thanks for your reply, Yesterday I tried many ways to implement
the solution of getting cwd from pid/task, but all failed. The basic
idea is to rewrite the d_path() code, but in the bpf program, there
will be various memory security access problems, even if enough
  `if (!ptr)` are added, the program cannot be loaded successfully.

https://github.com/Rtoax/bcc/commit/2ba7a2389fc1183264e5195ff26561d93038886c

     bcc/tools$ sudo ./opensnoop.py -F

     ; if (dentry == vfsmnt->mnt_root || dentry == dentry->d_parent) { @ 
main.c:174
     109: (79) r2 = *(u64 *)(r7 +0)
     R7 invalid mem access 'scalar'

At the same time, bpf_d_path cannot be used because it can only be
applied to functions in btf_allowlist_d_path. Currently, it is
impossible to get cwd from pid/task in user mode. Any suggestions?

In addition, I fully tested this patch yesterday and it performed well.

Rong Tao


