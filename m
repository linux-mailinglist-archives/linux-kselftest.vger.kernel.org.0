Return-Path: <linux-kselftest+bounces-34028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F9AC861B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 03:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775213B7603
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55D190477;
	Fri, 30 May 2025 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MOqa+S2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB062CCC5
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748570180; cv=none; b=J5aJ/D5AD6j+VJNWTPZWzpIy35m/O+0xLA2XlQNsZ3td1rayRbw3ajJ3iqij+6aG7jav9v8fUNlo8puDSPGmpbTdLSpuoN374pZdspd4w1oYqU7+naM1TnLhT36zxMjz9OZasLH7pgXVDI7ofbNyRnCkCtnPKUciEXIyt9GxcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748570180; c=relaxed/simple;
	bh=u7VyUFhkpp3iahCut82BwLg3+2sCvnO38zqnNgASCpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXP+UXH7P9skRvSWtm1ADVgEvtUFdw0R2oFAkT1Gwq2NfqNaev6zY3vg7cw//NFtBubUmqsW5DeOqp5zfkbc5T8IJkaRK4JKPFqGNj3FY5mAzHt5Glk1Z5cvtrjmePe5lqj9ZJBwLmZ5uv+mfYdLXntDHbOKjmZS9Kjq18MNNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MOqa+S2B; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <599838d4-7faf-41ce-9a7f-6eebd5173db7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748570165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9wJXvfCN3kwmaDp7fZIzUrWKt3creevaq+W6CDqyW4=;
	b=MOqa+S2BTvgi6QE6ogqD4uge/Rm/j4oBEMhrH97yjl3kSkpfGECd1sUEHG1E56arwPsoDu
	0oaMn1mT2NjMCDm91Q8Re4F+tDZrG1JsHEzNfofBmLeEKu1yjg0QuFes2mLVodBqfdN2Tr
	HhKCuqZxxN57W6Kppw50A+vHDw+wGyE=
Date: Thu, 29 May 2025 18:55:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
Content-Language: en-GB
To: Rong Tao <rtoax@foxmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, rongtao@cestc.cn,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Juntong Deng <juntong.deng@outlook.com>,
 Amery Hung <amery.hung@bytedance.com>,
 Dave Marchevsky <davemarchevsky@fb.com>, Hou Tao <houtao1@huawei.com>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1748488784.git.rtoax@foxmail.com>
 <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>
 <CAADnVQ+hUk2wV3M+9mgv_i5sNt_FuHpAnDpkQJ22D37bxAJHsQ@mail.gmail.com>
 <tencent_C8CF57BAD10D440E8308A19E2C894B341507@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_C8CF57BAD10D440E8308A19E2C894B341507@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/29/25 6:28 PM, Rong Tao wrote:
>
> On 5/29/25 13:44, Alexei Starovoitov wrote:
>> On Wed, May 28, 2025 at 8:37 PM Rong Tao <rtoax@foxmail.com> wrote:
>>> From: Rong Tao <rongtao@cestc.cn>
>>>
>>> It is a bit troublesome to get cwd based on pid in bpf program, such as
>>> bpftrace example [1].
>>>
>>> This patch therefore adds a new bpf_task_cwd_from_pid() kfunc which
>>> allows BPF programs to get cwd from a pid.
>>>
>>> [1] https://github.com/bpftrace/bpftrace/issues/3314
>> Yes. This is cumbersome, but adding a very specific kfunc
>> to the kernel is not a solution.
>> This is tracing, no need for precise cwd. probe_read_kernel
>> can do the job. bpftrace needs to have better C interop.
>> Once that happens any kind of tracing extraction will be
>> easy to write in C. Like this bpf_task_cwd_from_pid()
>> can already be written as C bpf program.
> Thanks for your reply, Yesterday I tried many ways to implement
> the solution of getting cwd from pid/task, but all failed. The basic
> idea is to rewrite the d_path() code, but in the bpf program, there
> will be various memory security access problems, even if enough
>  `if (!ptr)` are added, the program cannot be loaded successfully.
>
> https://github.com/Rtoax/bcc/commit/2ba7a2389fc1183264e5195ff26561d93038886c 
>
>
>     bcc/tools$ sudo ./opensnoop.py -F
>
>     ; if (dentry == vfsmnt->mnt_root || dentry == dentry->d_parent) { 
> @ main.c:174
>     109: (79) r2 = *(u64 *)(r7 +0)
>     R7 invalid mem access 'scalar'

I think you can use bpf_probe_read_kernel() helper to get r2?

>
> At the same time, bpf_d_path cannot be used because it can only be
> applied to functions in btf_allowlist_d_path. Currently, it is
> impossible to get cwd from pid/task in user mode. Any suggestions?
>
> In addition, I fully tested this patch yesterday and it performed well.
>
> Rong Tao
>
>


