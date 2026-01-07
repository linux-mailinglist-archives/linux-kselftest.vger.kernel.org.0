Return-Path: <linux-kselftest+bounces-48379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F9CFC1EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 06:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC913061B23
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558815A86D;
	Wed,  7 Jan 2026 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g6g6HHH8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148A13B7A3
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765205; cv=none; b=QwkRNhtldTt89eorwxTL6Hbobhbw4ZdJiBCxJo6CXWre1DyqeLWv+QhSoQk9ua/claCMAIQ0mJwQnXWGSt3wobTMVCgizemne3HwQRsXgm1IHt+RYkNzd4GA90cChgm98G9h07N0SrAw0g4FBhmXEuMUV35Dj0/4q0V1/ym/d30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765205; c=relaxed/simple;
	bh=HcjLGWYieERxNzxeV0f3JCGMow367byA2J+B+qDXz7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbJ1rni47IGAFsF/YlXcycAjN2P5ZPffCnISXZJr4fUz23VV69VExr3MUzlWwLlStt1Umx8vHxJAvSIbqOk5/fqxNtanXUEdBScz+TH/JWmkyCVk7CrXu5SMzscMQTSAzHOSGNrwhwjrIdW33EjNO4oYh3OkBtMrDtIGoiP3v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g6g6HHH8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <372fbef8-6f47-4167-8568-eb39f9332d49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767765189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLKVDqRUS0hVmv/xMmhO9alAau2LJVz5FvvBuelJ1hc=;
	b=g6g6HHH8Nmr4Bf0ZFQBcsiU/8GdDUIRCx+VUYdcYzDjzZexcgsEKy2RkO1M5kjiTUfKnFS
	RqqdG/bWULRoifxWmoHASKGEmsADf3HGa8iYoRMzME5+SS2z5TUT2tb90n5Gl8m1K6w6kx
	qT3HVPNvhoag/rt9FjO+D8gnXmpeEU8=
Date: Wed, 7 Jan 2026 13:52:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v4 3/9] bpf: Refactor reporting
 log_true_size for prog_load
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 brauner@kernel.org, oleg@redhat.com, sforshee@kernel.org,
 yuichtsu@amazon.com, aalbersh@redhat.com, willemb@google.com,
 kerneljasonxing@gmail.com, paul.chaignon@gmail.com, yatsenko@meta.com,
 memxor@gmail.com, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 rongtao@cestc.cn, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260106172018.57757-4-leon.hwang@linux.dev>
 <53542ad28c0d27ffcfcf9ea325fb6a77eeb3d569e17a6fad9d95685b5ea25467@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <53542ad28c0d27ffcfcf9ea325fb6a77eeb3d569e17a6fad9d95685b5ea25467@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/1/26 01:44, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 8f464b847405..1739601fb7bd 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
>> @@ -6160,12 +6160,22 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
>>  	return ret;
>>  }
>>
>> +static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
>> +{
>> +	if (size >= offsetofend(union bpf_attr, log_true_size) &&
>> +	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
>> +				  &attr->log_true_size, sizeof(attr->log_true_size)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>  static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>  		     bpfptr_t uattr_common, unsigned int size_common)
>>  {
>>  	struct bpf_common_attr common_attrs;
>>  	union bpf_attr attr;
>> -	int err;
>> +	int err, ret;
> 
> [ ... ]
> 
>> @@ -6215,7 +6225,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>  		err = map_freeze(&attr);
>>  		break;
>>  	case BPF_PROG_LOAD:
>> -		err = bpf_prog_load(&attr, uattr, size);
>> +		attr.log_true_size = 0;
>> +		err = bpf_prog_load(&attr, uattr);
>> +		ret = copy_prog_load_log_true_size(&attr, uattr, size);
>> +		err = ret ? ret : err;
>                     ^^^^^^^^^^^^^^^^^^^^
> 
> If bpf_prog_load() succeeds, it returns a positive file descriptor.
> Then if copy_prog_load_log_true_size() fails with -EFAULT, this line
> overwrites err with -EFAULT, losing the FD value.
> 
> The BPF program has already been loaded and the FD allocated at this
> point. Since the FD is never returned to userspace, the program
> remains loaded but unreachable - could this leak the BPF program?
> 

Indeed, the normal FD could be leaked if 'ret == -EFAULT'.

I'll address it in the next revision.

Thanks,
Leon

> In the previous code, the copy_to_bpfptr_offset() happened inside
> bpf_check() before the program was fully committed:
> 
>     if (uattr_size >= offsetofend(...) &&
>         copy_to_bpfptr_offset(...)) {
>             ret = -EFAULT;
>             goto err_release_maps;
>         }
> 
> This goto caused bpf_check() to return an error, preventing the FD
> allocation in bpf_prog_load(). Moving the copy outside changes the
> semantics - the FD can now be allocated before a copy failure occurs.
> 
>> +		break;
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20756616585


