Return-Path: <linux-kselftest+bounces-21142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAC9B6933
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A921F222CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A42144A9;
	Wed, 30 Oct 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciSt+G/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF68C1F;
	Wed, 30 Oct 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305882; cv=none; b=R24CKVCdtwZkdxNbpdckRjupd3s1G46RP/f1y+ZpvOfpoiiHnUOk3tjXG5dP105I+5k5OiyMgXzXp9v/wHa5s1miRpoG1tBLS+VeI5UuEAHGzyttpAcoc5AC3yema22sdqkduoAHrkGplbaYwRgy+NxSprxEFPLByTt1JO/66Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305882; c=relaxed/simple;
	bh=oO8e/qytpViysImJ2eTakDtB0b0Ol/dLIvB1fQFw8Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbGJUAlLpeWeqgvxPjJJ8nNSM0AFNyyEcw60/gxRE/lAtVrPyLb8ltPg2cW2L3XLUkaz0jMrpDhOzg2eGNsoAIh9teevjkYkyqTw04iQwCVP0lfgRUHUtHKkQQrvyvD+EKaYTL+8mthg9ruHZRblI5v8S2OaTyEcOFgAazc+hgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciSt+G/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22D6C4CECE;
	Wed, 30 Oct 2024 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730305881;
	bh=oO8e/qytpViysImJ2eTakDtB0b0Ol/dLIvB1fQFw8Ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ciSt+G/CDYMj9JF989JWCb0qe/e8mg9VVp7vv0YPzDMdGPEnYGnb3vRdjoYbJ3qsK
	 mX7HMq6efm2oi5vL5WeKkSgnCnO0BLJ5YhhisDEo/qEGWaNI0EBYrmc3f9Tq18e7UZ
	 xFmIwkD2eYaMil6laBElh9xu7WR2RY67PjK87fVKhWDf7WpiAbyKIBTle3j6p1Fz0B
	 BPSflJ+JP7dvSuxOykFLss1FlY0uCWq0pH2SRvwCOL0DYDyoo4caQfWvzmcOx/deKm
	 GQBx7u/OMRetmRvYmzU3aTjfS4sPuRD8V1XuLo52T0B4+wNo/7y/L4tVzLXQ4n0N7D
	 3aFoUz4CrWJgg==
Message-ID: <9b2b3c98-503b-45ae-bcdd-ac2fcc62e14c@kernel.org>
Date: Wed, 30 Oct 2024 17:31:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP not
 support
Content-Language: en-GB
To: Tao Chen <chen.dylane@gmail.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
References: <20241030100108.2443371-1-chen.dylane@gmail.com>
 <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
 <3bc02b33-421e-4c95-8f69-33ec89782621@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3bc02b33-421e-4c95-8f69-33ec89782621@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tao, BPF maintainers,

On 30/10/2024 12:12, Tao Chen wrote:
> 在 2024/10/30 18:49, Matthieu Baerts 写道:
>> Hi Tao Chen,
>>
>> Thank you for having shared this patch.
>>
>> On 30/10/2024 11:01, Tao Chen wrote:
>>> Fix compile error when MPTCP feature not support, though eBPF core check
>>> already done which seems invalid in this situation, the error info like:
>>> progs/mptcp_sock.c:49:40: error: no member named 'is_mptcp' in 'struct
>>> tcp_sock'
>>>     49 |         is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ?
>>>
>>> The filed created in new definitions with eBPF core feature to solve
>>> this build problem, and test case result still ok in MPTCP kernel.
>>>
>>> 176/1   mptcp/base:OK
>>> 176/2   mptcp/mptcpify:OK
>>> 176     mptcp:OK
>>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>>
>>> Fixes: 8039d353217c ("selftests/bpf: Add MPTCP test base")
>>
>> The commit you mentioned here is more than 2 years old, and as far as I
>> can see, nobody else reported this compilation issue. I guess that's
>> because people used tools/testing/selftests/bpf/config file as expected
>> to populate the kernel config, and I suppose you didn't, right?
>>
> 
> Hi Matt, thank you for your reply, as you said, i did not use tools/
> testing/selftests/bpf/config to compile kernel, i will use this helpful
> feature.
> 
>> I don't think other BPF selftests check for missing kernel config if
>> they are specified in the 'config' file, but even if it is the case, I
>> think it would be better to skip all the MPTCP tests, and not try to
>> have them checking something that doesn't exist: no need to validate
>> these tests if the expected kernel config has not been enabled.
>>
> 
> If i use the kernel not support MPTCP, the compile error still exists,
> and i can not build the bpf test successfully. Maybe skill the test case
> seems better when kernel not support. Now that bpf_core_field_exists
> check already used in the code, i think it is better to use new
> definition mode.

I understand it would be better, but it means more code to maintain to
handle that (and remembering that in future test cases). If that's not
necessary, then no need to do the effort.

@BPF maintainers: do we need to support kernels not respecting the
tools/testing/selftests/bpf/config file? Should we detect when a
required kernel config is not set and skip some tests?

>> But again, please correct me if I'm wrong, but I don't think there is
>> anything to change here to fix your compilation issue: simply make sure
>> to use this tools/testing/selftests/bpf/config file to generate your
>> kernel config, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


