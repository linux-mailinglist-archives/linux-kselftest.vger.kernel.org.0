Return-Path: <linux-kselftest+bounces-7645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9EA8A04C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38A71C2153F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A87F9;
	Thu, 11 Apr 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZPkn0pwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB5A20
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795190; cv=none; b=D159TTMeNwj41OgPe5vWsqvAj4jQb6noYi7l2BEh1D3zFxbnRxpjpFgVKwrczCT07Wi6JJqHsboBilLkGcOguTaia4JruIAn0hfljig5oB6WTS4MloMynBTvNynvH+PF3ss6e2NXreHA9Uorn7aKmAidYs85q3c0rhOQ/PzA/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795190; c=relaxed/simple;
	bh=iOxJT8OfTlI2kJRkaXpBe16OPqSDgaEyZ9Me/w385Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhYsP0eyJzWlqwOWladitnF2XS/YINdTnhzp4pbo6DXo4DPNHKmgz0Ub/xxK9nGcGG/4XnRDwx+L/m4/8qwxSmKLkA00q/o8W56ViFbmn/+g1aW1vU/5rLmNa2iVekj/b5xqjtX4DbyZOLTONF2N4U8txN/Ez256SX/B1+AUMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZPkn0pwI; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31904afe-1d8a-4169-a3bd-d6d1c86cac5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712795186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB2Wp3EMMPBhX4wRoJ9ubR900ORB8tJWdO8CVq4jwWQ=;
	b=ZPkn0pwIJRwaHIbkfEkVSdU9ecajbn7zceHnEAJi/o70wwJfHYmj3NZOCeYFMxYXFAXR0C
	Mb9wM84w4gd8qYC/C4KAzd+Vo8BhaVCZm5Bzs0ueih2vvXuPUsPI8hKxnOnEzZJmb0Y8dt
	YrFK1drcLrl96FZP67JFf7ejx+FK/0s=
Date: Wed, 10 Apr 2024 17:26:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Content-Language: en-GB
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Djalal Harouni <tixxdz@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
 <705d7180-aced-46ba-80a6-84ac4e2b96b9@gmail.com>
 <eosbqsdycwdaezg6huqwpjvttxdxgbu6ptjmpxesy6i2rl276i@72w2orzveyes>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <eosbqsdycwdaezg6huqwpjvttxdxgbu6ptjmpxesy6i2rl276i@72w2orzveyes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/9/24 8:32 AM, Michal Koutný wrote:
> Hi.
>
> On Tue, Apr 02, 2024 at 07:20:45PM +0100, Djalal Harouni <tixxdz@gmail.com> wrote:
>> Thanks yes, I would expect freeze to behave like signal, and if one
>> wants to block immediately there is the LSM override return. The
>> selftest attached tries to do exactly that.
> Are you refering to this part:
>
> 	int BPF_PROG(lsm_freeze_cgroup, int cmd, union bpf_attr *attr, unsigned int size)
> 		...
> 		ret = bpf_task_freeze_cgroup(task, 1);
> 		if (!ret) {
> 			ret = -EPERM;
> 			/* reset for next call */
> ?
>
>
>> Could be security signals, reading sensitive files or related to any
>> operation management, for X reasons this user session should be freezed
>> or killed.
> What can be done with a frozen cgroup after anything of that happens?
> Anything besides killing anyway?
>
> Killing of an offending process could be caught by its supervisor (like
> container runtime or systemd) and propagated accordingly to the whole
> cgroup.
>
>> The kill is an effective defense against fork-bombs as an example.
> There are several ways how to prevent fork-bombs in kernel already, it
> looks like a contrived example.
>
>> Today some container/pod operations are performed at bpf level, having
>> the freeze and kill available is straightforward to perform this.
> It seems to me like an extra step when the same operation can be done from
> (the managing) userspace already.
>
>> For generalizing this, haven't thought about it that much. First use
>> case is to try to get freeze and possibly kill support, and use a common
>> interface as requested.
> BTW, I notice that there is bpf_sys_bpf() helper that allows calling an
> arbitrary syscall. Wouldn't that be sufficient for everything?

This is not true. Currently, only 'bpf' and 'close' syscalls are supported.

static const struct bpf_func_proto *
syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
{
         switch (func_id) {
         case BPF_FUNC_sys_bpf:
                 return !bpf_token_capable(prog->aux->token, CAP_PERFMON)
                        ? NULL : &bpf_sys_bpf_proto;
         case BPF_FUNC_btf_find_by_name_kind:
                 return &bpf_btf_find_by_name_kind_proto;
         case BPF_FUNC_sys_close:
                 return &bpf_sys_close_proto;
         case BPF_FUNC_kallsyms_lookup_name:
                 return &bpf_kallsyms_lookup_name_proto;
         default:
                 return tracing_prog_func_proto(func_id, prog);
         }
}

More syscalls can be added (through kfunc) if there is a use case for that.

>
> (Based on how I still understand the problem: either you must respond
> immediately and then the direct return from LSM is appropriate or timing
> is not sensitive but you want act on whole cgroup.)
>
> Thanks,
> Michal

