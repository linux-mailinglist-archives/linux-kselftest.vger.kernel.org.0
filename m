Return-Path: <linux-kselftest+bounces-34042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54639AC883C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 08:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C11BA787C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C11F4C85;
	Fri, 30 May 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="K5NDaARE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3910E4;
	Fri, 30 May 2025 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586862; cv=none; b=vElofMBtfI8+TrDdUFjyd1SQ7rmnhhw6oNSReR9nEigHL/4DcbJ6GmThm+/1NFyB/wROEJuCQHkDFqwxK2S1GRLlt47AF2qwGIJ9GxHKZKj0aDkJJeHmNUkszYQrYoc1sMUcrwD/Bud34XINDjQJAzcefcpYi/3JtiGDB0YH2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586862; c=relaxed/simple;
	bh=tV4VuMBLa/kEjMITalpMd3xexYEhPloYOUSsa5uWW8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdEaYX2nJo5+2duEgYJZJrLBgQU3gmNtaICqcUP/i6mWCSsWo3IGWNcdro0g/dRPXw6gMdOFwwuk59fV/ideoRp9nEiFzhx30nZM9Bd3vATtRX9ccx4FfXOugimer9B87dkdR7pwEw4+pRAoDv/d22QHyggCNBgZiJ3vBcHsQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=K5NDaARE; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748586846;
	bh=fLRtGI/dkGFjlZENN6WGzEywpI9et7ean0MKT3oN79U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K5NDaAREZgSKHmT+AZ7Zv8iD2RTuYYxTKa7JV/5TVgfMMjQ6v6qkEhCpfQhE+BTLX
	 Hut9GEZh63nRRZF7nCvYBFuVlNgoXDRNTgcD7g7Rr9grZ1ruLFhqfVQajY1TLjAtZz
	 ifam5CN2XpO6OLlQpfthyIe87UPU8ljgqPtJrHaY=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 88210633; Fri, 30 May 2025 14:34:02 +0800
X-QQ-mid: xmsmtpt1748586842t4r3aac12
Message-ID: <tencent_0C1631C5C04C0820EBEE925625E195713405@qq.com>
X-QQ-XMAILINFO: NFcI4DQTV9fmJUZxq503s5HvZwxuwcSCHrJMNC9bWMF/EMerRepCVZNm3TpeJz
	 P6m++hwB9GvtJsp2muycCL/iYZCBnEsrKsdn7SoAYxpXzK4cFeFXRdJUwAixqXMflwJNtOZOqPJN
	 BjMz1dv+roqxDveovyirzSm5Iin+okTdslRBOx+ltn6TsRxyejtR1kM/yK1U1MgHHGJQ52R6C+0s
	 IH+mxvQVFyfE5ogro30FglxT7QgUfEtrl3vBNbV0IhIcLxetpN2EZIjcEIsRgN171wkMaMCjlA9Y
	 K6olgahP19ZTlJNMrwN0at01SfZazM4cKFmcKkiuPdyD1kGkrUiSdPZFKzh53j9R7B5zAhH24IbI
	 XUTHVoBt2spOr5jOy334SfWpQ+jTo/Mckrb4I6d3l+8SFBsBV/6dB8NGuN3gqtOuiGE/m6xTMC7f
	 PwvjTItXbxut0+ktL8tJhf5pDhdJ6uGA+MhI5Wf353hgsxYYpz+0mV30n6c30Xp9FyzOXSE0x5/h
	 EqTidJA+6Fh9abeiWrqd+/JYptzm9eipDsR3k207rcIHTWJ0nzPRD9WgM+exjjngJ5yKdlYKU4pH
	 u+vA2YWOEdHOm+J/TsujWwSq0ZSd7zoUXzhn62PNiqH0of/7/jMeXVK0FNTtDolx/++2umFWeph5
	 KyevxfzqE4deH+SCkfDJx1ckPxAm+IM/cbm0fiEo18BRBF9zg/mzS4F/6Yz/GOZrqD0WJSyknBzc
	 kEZhsudbwCu/SpNGCxG5XauGwwrNEa8pGzesRpYnBrMhN85Q8frgg38Q7qrnvzX7ydld0IhjKzCJ
	 ajlEOxiBwi1dYYTTkG20qyH+4DLj8cj5csJvm7t295wlE4ogWHaH9gpat3vTUPqN+cMkUb+5hNkW
	 W6jraBdcDHAo0ZdkzJ/o+oeKd5E0IrD98b8UsO0mwXPEYWgf7X5RVddKphsoL54y5RLzCXIJvHzs
	 inLFKOmGSriG4bkkLj3yVVcPReFZR2jrdz016lFA4e1oXCHh1sox+zK3ofWWEoCIdk9b+XoEDcag
	 /Uw+ZqzQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <3fbc45fd-5806-495d-bea9-fa7606001a30@foxmail.com>
Date: Fri, 30 May 2025 14:34:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
To: Yonghong Song <yonghong.song@linux.dev>,
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
 <599838d4-7faf-41ce-9a7f-6eebd5173db7@linux.dev>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <599838d4-7faf-41ce-9a7f-6eebd5173db7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/30/25 09:55, Yonghong Song wrote:
>
>
> On 5/29/25 6:28 PM, Rong Tao wrote:
>>
>> On 5/29/25 13:44, Alexei Starovoitov wrote:
>>> On Wed, May 28, 2025 at 8:37 PM Rong Tao <rtoax@foxmail.com> wrote:
>>>> From: Rong Tao <rongtao@cestc.cn>
>>>>
>>>> It is a bit troublesome to get cwd based on pid in bpf program, 
>>>> such as
>>>> bpftrace example [1].
>>>>
>>>> This patch therefore adds a new bpf_task_cwd_from_pid() kfunc which
>>>> allows BPF programs to get cwd from a pid.
>>>>
>>>> [1] https://github.com/bpftrace/bpftrace/issues/3314
>>> Yes. This is cumbersome, but adding a very specific kfunc
>>> to the kernel is not a solution.
>>> This is tracing, no need for precise cwd. probe_read_kernel
>>> can do the job. bpftrace needs to have better C interop.
>>> Once that happens any kind of tracing extraction will be
>>> easy to write in C. Like this bpf_task_cwd_from_pid()
>>> can already be written as C bpf program.
>> Thanks for your reply, Yesterday I tried many ways to implement
>> the solution of getting cwd from pid/task, but all failed. The basic
>> idea is to rewrite the d_path() code, but in the bpf program, there
>> will be various memory security access problems, even if enough
>>  `if (!ptr)` are added, the program cannot be loaded successfully.
>>
>> https://github.com/Rtoax/bcc/commit/2ba7a2389fc1183264e5195ff26561d93038886c 
>>
>>
>>     bcc/tools$ sudo ./opensnoop.py -F
>>
>>     ; if (dentry == vfsmnt->mnt_root || dentry == dentry->d_parent) { 
>> @ main.c:174
>>     109: (79) r2 = *(u64 *)(r7 +0)
>>     R7 invalid mem access 'scalar'
>
> I think you can use bpf_probe_read_kernel() helper to get r2?
Thanks a lot, bpf_probe_read_kernel() works :)
>
>>
>> At the same time, bpf_d_path cannot be used because it can only be
>> applied to functions in btf_allowlist_d_path. Currently, it is
>> impossible to get cwd from pid/task in user mode. Any suggestions?
>>
>> In addition, I fully tested this patch yesterday and it performed well.
>>
>> Rong Tao
>>
>>
>


