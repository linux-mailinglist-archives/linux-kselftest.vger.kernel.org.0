Return-Path: <linux-kselftest+bounces-32034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF52AA50E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81ED3A7CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A0325D1F8;
	Wed, 30 Apr 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jEUP/GLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8917CA17
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028510; cv=none; b=gqF6HB8oaQcap6AowpdxquX9s1XzVNhPMynJxi/pke6RztuEUenxPwAeaWXB4h6U95Md4/076AuSUOz6Ys6hadiTAf0KNVH0pyhTgwHNwOP7bbu1holg4ZwIFGjgvxhyZ6cHH+K0cdYCZyjq8uUAijlriWNeJ0UBqnaEpSqOf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028510; c=relaxed/simple;
	bh=itiBlsf6zR4RTlm3hf+QfHFNY4vVsdzz2uVhJ45Z5FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+Osyb9UfH45/jxekEE/S8x7Zp9M8amQBOfpdzqse1hJhxt5t6344M66+lcfK0L//7YpTiDX+9dtKIM7gGLMKcrLqSb8Ba30Xr3/KQSSa6UXUvCPxQoGRmS+JAhNVMBbWPoWaSQzF5QfUZnG6QSV4cO5slqXnvNBQ7i0YoXvN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jEUP/GLo; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f951b81f-1b46-4219-82fd-0839e27ab3f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746028504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x01/YentqQxiWV+z2dsRSAIeIX6UbbCKUGdMPakv0qE=;
	b=jEUP/GLoxJGvhRlAHo8UUY72GYTKU2U7nYQiDnmfjuRerBfvwIZZMpmwdytWhh/xlnA4yk
	jTrmdGlsY2YmIOSEJ+DH24bkZzjHXIG/QOIjHqjNAslgaJR3ZYdM4p74rpLyDEv/HqR/5U
	MM7aIhHbnP3NPMi6VPkKCuFv9s+4YvM=
Date: Wed, 30 Apr 2025 23:54:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Kafai Wan <mannkafai@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20250426160027.177173-1-mannkafai@gmail.com>
 <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
 <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/4/30 20:43, Kafai Wan wrote:
> On Wed, Apr 30, 2025 at 10:46 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sat, Apr 26, 2025 at 9:00 AM KaFai Wan <mannkafai@gmail.com> wrote:
>>>

[...]

>>> @@ -2312,7 +2322,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>>>  #define REPEAT(X, FN, DL, ...)         REPEAT_##X(FN, DL, __VA_ARGS__)
>>>
>>>  #define SARG(X)                u64 arg##X
>>> -#define COPY(X)                args[X] = arg##X
>>> +#define COPY(X)                args[X + 1] = arg##X
>>>
>>>  #define __DL_COM       (,)
>>>  #define __DL_SEM       (;)
>>> @@ -2323,9 +2333,10 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>>>         void bpf_trace_run##x(struct bpf_raw_tp_link *link,             \
>>>                               REPEAT(x, SARG, __DL_COM, __SEQ_0_11))    \
>>>         {                                                               \
>>> -               u64 args[x];                                            \
>>> +               u64 args[x + 1];                                        \
>>> +               args[0] = x;                                            \
>>>                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);                  \
>>> -               __bpf_trace_run(link, args);                            \
>>> +               __bpf_trace_run(link, args + 1);                        \
>>
>> This is neat, but what is this for?
>> The program that attaches to a particular raw_tp knows what it is
>> attaching to and how many arguments are there,
>> so bpf_get_func_arg_cnt() is a 5th wheel.
>>
>> If the reason is "for completeness" then it's not a good reason
>> to penalize performance. Though it's just an extra 8 byte of stack
>> and a single store of a constant.
>>
> If we try to capture all arguments of a specific raw_tp in tracing programs,
> We first obtain the arguments count from the format file in debugfs or BTF
> and pass this count to the BPF program via .bss section or cookie (if
> available).
> 
> If we store the count in ctx and get it via get_func_arg_cnt helper in
> the BPF program，
> a) It's easier and more efficient to get the arguments count in the BPF program.
> b) It could use a single BPF program to capture arguments for multiple raw_tps,
> reduce the number of BPF programs when massive tracing.
> 


bpf_get_func_arg() will be very helpful for bpfsnoop[1] when tracing tp_btf.

In bpfsnoop, it can generate a small snippet of bpf instructions to use
bpf_get_func_arg() for retrieving and filtering arguments. For example,
with the netif_receive_skb tracepoint, bpfsnoop can use
bpf_get_func_arg() to filter the skb argument using pcap-filter(7)[2] or
a custom attribute-based filter. This will allow bpfsnoop to trace
multiple tracepoints using a single bpf program code.

[1] https://github.com/bpfsnoop/bpfsnoop
[2] https://www.tcpdump.org/manpages/pcap-filter.7.html

Thanks,
Leon


