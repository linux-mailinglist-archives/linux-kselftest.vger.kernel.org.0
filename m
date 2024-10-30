Return-Path: <linux-kselftest+bounces-21159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E759B6E15
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DE41F24940
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149921790E;
	Wed, 30 Oct 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f8SEV7M/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DD21503D
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321332; cv=none; b=rL1f5c094XbLKE/Okxrd7BJ0IrK5mDWoeGX5H5tP8cofONgE6GkHHu7exBy3vyMijcs/rD0xc9vHqvSRMKlZNw14WqIsLJ5/Tu/mPnbh8adtn2YA0wDen3/VzANZBJ6GJ0uO+lGQsNyPQmC3XVyK9yeGRhaUfgSmYnNoYuWTaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321332; c=relaxed/simple;
	bh=r7Szs2POrVC2wv7OjarWafvN6De9kKjAB8U9+PxACq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffUTrpuQjP+OsDP+v+iMH6vrrpqr7adKhlahqM2JdSCYA9C7wkusyOAgKPaL4HU7cQsCAaVAqvzpugmSjUG93RD0jI/w9Gky4SRLAGenOeDNIe+HQAbhatLrFHMWKn+MsMljy+ZXoxhuR6j9yPz5YA9HSZ2aCuDVGjBefSB+D58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f8SEV7M/; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82dff21b-0ba0-4823-bd78-d8d2105941f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730321327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUu3R5NznYIAyWQ0FfKhRx6rfEqKBnePWslIEbBLNsY=;
	b=f8SEV7M/wGL9Wa/RFdfrDQLa9WkLgkBKgTq5xQBfVLMld16cK5Ywk0XEu9ByyYJx4T7ljw
	k8pxaqMDbReQUfp+pRE9duT6qKhAjJHDC7gHfzPIfDdZLrJnc6owGXeQA9/Fo5XoaF30tl
	I7gIJM+4b2UWNRWZETrpebVDQY3tFMw=
Date: Wed, 30 Oct 2024 13:48:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP not
 support
To: Matthieu Baerts <matttbe@kernel.org>, Tao Chen <chen.dylane@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
References: <20241030100108.2443371-1-chen.dylane@gmail.com>
 <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
 <3bc02b33-421e-4c95-8f69-33ec89782621@gmail.com>
 <9b2b3c98-503b-45ae-bcdd-ac2fcc62e14c@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9b2b3c98-503b-45ae-bcdd-ac2fcc62e14c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/24 9:31 AM, Matthieu Baerts wrote:
> Hi Tao, BPF maintainers,
> 
> On 30/10/2024 12:12, Tao Chen wrote:
>> 在 2024/10/30 18:49, Matthieu Baerts 写道:
>>> Hi Tao Chen,
>>>
>>> Thank you for having shared this patch.
>>>
>>> On 30/10/2024 11:01, Tao Chen wrote:
>>>> Fix compile error when MPTCP feature not support, though eBPF core check
>>>> already done which seems invalid in this situation, the error info like:
>>>> progs/mptcp_sock.c:49:40: error: no member named 'is_mptcp' in 'struct
>>>> tcp_sock'
>>>>      49 |         is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ?
>>>>
>>>> The filed created in new definitions with eBPF core feature to solve
>>>> this build problem, and test case result still ok in MPTCP kernel.
>>>>
>>>> 176/1   mptcp/base:OK
>>>> 176/2   mptcp/mptcpify:OK
>>>> 176     mptcp:OK
>>>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>>>
>>>> Fixes: 8039d353217c ("selftests/bpf: Add MPTCP test base")
>>>
>>> The commit you mentioned here is more than 2 years old, and as far as I
>>> can see, nobody else reported this compilation issue. I guess that's
>>> because people used tools/testing/selftests/bpf/config file as expected
>>> to populate the kernel config, and I suppose you didn't, right?
>>>
>>
>> Hi Matt, thank you for your reply, as you said, i did not use tools/
>> testing/selftests/bpf/config to compile kernel, i will use this helpful
>> feature.
>>
>>> I don't think other BPF selftests check for missing kernel config if
>>> they are specified in the 'config' file, but even if it is the case, I
>>> think it would be better to skip all the MPTCP tests, and not try to
>>> have them checking something that doesn't exist: no need to validate
>>> these tests if the expected kernel config has not been enabled.
>>>
>>
>> If i use the kernel not support MPTCP, the compile error still exists,
>> and i can not build the bpf test successfully. Maybe skill the test case
>> seems better when kernel not support. Now that bpf_core_field_exists
>> check already used in the code, i think it is better to use new
>> definition mode.
> 
> I understand it would be better, but it means more code to maintain to
> handle that (and remembering that in future test cases). If that's not
> necessary, then no need to do the effort.
> 
> @BPF maintainers: do we need to support kernels not respecting the
> tools/testing/selftests/bpf/config file? Should we detect when a
> required kernel config is not set and skip some tests?

I guess it depends on the CONFIG_. Otherwise, it takes out the goodies of using 
<vmlinux.h> when writing bpf selftests.

If fixing the config is an option and sounds like it is for Tao, then it is 
always good to run everything in test_progs.

There are some "___local" definitions in the selftests. If mptcp test wants to 
go this path, then Matt's request to at least test__skip() makes sense to me.

pw-bot: cr

> 
>>> But again, please correct me if I'm wrong, but I don't think there is
>>> anything to change here to fix your compilation issue: simply make sure
>>> to use this tools/testing/selftests/bpf/config file to generate your
>>> kernel config, no?
> 
> Cheers,
> Matt


