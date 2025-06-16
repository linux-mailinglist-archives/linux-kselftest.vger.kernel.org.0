Return-Path: <linux-kselftest+bounces-35144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE9ADBB4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B405175F76
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680820B800;
	Mon, 16 Jun 2025 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQUxhmKS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B730136349;
	Mon, 16 Jun 2025 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106456; cv=none; b=D5/sVC3AnO2syrKk9gJTQWnwqibUYD81liXOoOLMyMty4AKlTBEDeKu/JxgqdQaVXvATB1Ikcg0qx8o0XEtDss/wmY7ytZvR1F7BszlwlBZK4zjyMlaqGfng0qK3Vrw/7TiGG0qkKwKxX5xB+OaOOxmAVsrKKAceHLtkYnZX2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106456; c=relaxed/simple;
	bh=VToacuz5C68jjScMIwa6jMdcPhRPipW0PWEYVkfbBp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnY8AWNrPD3Q2cu/a1Ovmp2yG1WrRS2bits64m9AlnOtwLYYYN1Ub6i8GBMnRLRHnr1gpGGAT0S0AB9p1LlcTLIB/NyxClLUoremkanam+qqtnnOBfWBKURIMyCANW5u58nSIYY29fnd8m+vyLAmqkC0MVdEAb+WoOBGyzKtQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQUxhmKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319D3C4CEEA;
	Mon, 16 Jun 2025 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750106455;
	bh=VToacuz5C68jjScMIwa6jMdcPhRPipW0PWEYVkfbBp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KQUxhmKST1yTP9+9MXKhvuAd9dMbhfFbLMwSgtfBTG/VHiSDA8BclseOyJN0yNPqW
	 B9VQk5WyNmanImzwfw/u79o+MWjtzn5tNgXtE6D9XyMnHF/cnAKDnVwoE8WOliJCwE
	 btcGPz+mpoaXJJhyxv/WWFZkkldBmVKq1GZveM+UI6yduqIe9Ej/Jc988uNUYvPcMS
	 GHZXTmUOoanYqZHMmfHFWiCwfsSYbLDPo+Ws60JzzG9D6Vo7gDcc8nlSSE3lRQLTS+
	 HRtj5zbq+mby6xyduOAIHPw7T2BqzlHJD5gaqlUqSS+7qKI1v22KCjphJ37AIQA57q
	 mVlEu5/xaqROw==
Message-ID: <be7149b5-0286-4b39-b6ce-809618354b13@kernel.org>
Date: Mon, 16 Jun 2025 22:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Content-Language: en-GB, fr-BE
To: Petr Machata <petrm@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1749757582.git.petrm@nvidia.com>
 <78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
 <20250613095755.54381628@kernel.org>
 <ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org> <87wm9bu13q.fsf@nvidia.com>
 <426a2c83-38ca-4fa2-9270-b3e600e30d19@kernel.org> <87sejztpvj.fsf@nvidia.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <87sejztpvj.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 21:53, Petr Machata wrote:
> 
> Matthieu Baerts <matttbe@kernel.org> writes:
> 
>> Hi Petr,
>>
>> On 16/06/2025 17:06, Petr Machata wrote:
>>>
>>> Matthieu Baerts <matttbe@kernel.org> writes:
> 
>>>> That what we did with MPTCP, see the top of the mptcp_join.sh file for
>>>> example [2], where we have:
>>>>
>>>>> # ShellCheck incorrectly believes that most of the code here is unreachable
>>>>> # because it's invoked by variable name, see how the "tests" array is used
>>>>> #shellcheck disable=SC2317
>>>>
>>>> If you add this at the top of your new file, followed by an empty line,
>>>> shellcheck will ignore this issue for the whole file.
>>>
>>> The ALL_TESTS issue is not the end of it either. We use helpers that
>>> call stuff indirectly all over the place. defer, in_ns... It would make
>>> sense to me to just disable SC2317 in NIPA runs. Or maybe even put it in
>>> net/forwarding/.shellcheckrc. Pretty much all those tests are written in
>>> a style that will hit these issues.
>>
>> In this case, I think it would be better to add this .shellcheckrc file
>> in net/forwarding. If you modify NIPA, I don't think people will know
>> what is allowed or not, or what command line to use, no?
> 
> Good point. The question then is whether to put it to forwarding/ or
> directly net/, which is has seen more use of lib.sh and therefore the
> same sort of coding style. I'll experiment with it and should be able to
> send it later in the week. I don't want to add it to the MC patchset.

Since Jakub disabled SC2317 in NIPA [1], then I guess we can put this
.shellcheckrc file in net/, no?

>> Note that NIPA's shellcheck reports are currently ignoring all "info"
>> and "style" severities -- so including SC2317 -- except for new files or
>> the ones that were previously shellcheck compliant.
> 
> Yeah, I know, but the result is still very noisy, if you want to verify
> it prior to sending the patchset. It's a bit annoying to have to scroll
> through the report trying to find relevant stuff. I could add
> .shellcheckrc in my own clone, but everybody is going to hit these.

When Shellcheck got introduced, there were some discussions about SC2317
and SC2086 [2]. I don't think they are useless -- maybe a function is
not used by mistake, maybe double quotes are really needed for some
cases, etc. -- but I agree with you: they create a lot of noise.

[1] https://github.com/linux-netdev/nipa/commit/23b74dd
[2] https://github.com/linux-netdev/nipa/pull/51#issuecomment-2939556291

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


