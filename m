Return-Path: <linux-kselftest+bounces-4188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6884B29F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C6F1C24184
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA592487A1;
	Tue,  6 Feb 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5BrUhbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF51EA7F;
	Tue,  6 Feb 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215962; cv=none; b=ToCPp+cS71O0OpMqYPBSLXjuVqkr7hwcy2zgoSJ0nYn9vgjuawitKTn7l/7dor6UQtIhNxEDsL24YmZd0I/3pNMVXbvafo7TDIpknAnjRpSqe/waHl07aoFVFGoP3HZMXQTZz+wt9nmv7yMQMEjEuTt0OVbPVaRi+IITNk9ytz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215962; c=relaxed/simple;
	bh=8hLhnndyxUSDCrbFEOGm0osgEsk+27nFrTG5+McF3xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erzdUM1KXp3LZR+35Yu6T9sjlt+N/xFNnubfvpTbZ1Bxh+WUkuawF8sbDxkplZ6U+k+C2f0dNFNXmY4Nxq0gXCO8ldrcF9SAhVtJQpm1+nLdZE4cvymngxBpXjq8UJJfoK8QE+zmegvF1D3DOQBSmgRoCxRJ3wZIx5wPc3z2zbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5BrUhbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C4AC433C7;
	Tue,  6 Feb 2024 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707215962;
	bh=8hLhnndyxUSDCrbFEOGm0osgEsk+27nFrTG5+McF3xA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s5BrUhbri3kR6DKzEWcb9pq0zPwrL/uuKW/tu9PRhLTgD0xyCwXAF3iQjUR0RRcma
	 7qLhzVHTiybKPVele1AoKNNT9OEVef10MpCWF1uGWDJXGhz7pHZHQsVVlgj6Ysp7Oj
	 9TTWRGUHJyEZU6Bkd1L+11WvEthVzSpja7No7MByic4Z6ASafQMkfOkw2ZGEfPW2el
	 eEtN0JoJHX6p5Ufe8BiP/bk6D82SkkdJ9CIFdXZl6jVpc66HSZWRnhIP2uKL1wLM6g
	 SEFCSiEaI3iswswlOVDg+8dPXwQ96/udpveboj9PuIEys1kSO4BPZjqL8SxW031wek
	 IAUpKF9r1slTw==
Message-ID: <15cc2bc2-4db9-4209-9c06-207bf613ea5a@kernel.org>
Date: Tue, 6 Feb 2024 11:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: ignore timing errors in so_txtime
 if KSFT_MACHINE_SLOW
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
References: <20240201162130.2278240-1-willemdebruijn.kernel@gmail.com>
 <20240202153909.79c08063@kernel.org>
 <65bd894de7b93_38e921294a9@willemb.c.googlers.com.notmuch>
 <cc2ac7cb99e09a3898f033690fd0b7978d0b120d.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cc2ac7cb99e09a3898f033690fd0b7978d0b120d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Willem, Jakub,

On 06/02/2024 10:18, Paolo Abeni wrote:
> On Fri, 2024-02-02 at 19:31 -0500, Willem de Bruijn wrote:
>> Jakub Kicinski wrote:
>>> On Thu,  1 Feb 2024 11:21:19 -0500 Willem de Bruijn wrote:
>>>> This test is time sensitive. It may fail on virtual machines and for
>>>> debug builds.
>>>>
>>>> Continue to run in these environments to get code coverage. But
>>>> optionally suppress failure for timing errors (only). This is
>>>> controlled with environment variable KSFT_MACHINE_SLOW.
>>>>
>>>> The test continues to return 0 (KSFT_PASS), rather than KSFT_XFAIL
>>>> as previously discussed. Because making so_txtime.c return that and
>>>> then making so_txtime.sh capture runs that pass that vs KSFT_FAIL
>>>> and pass it on added a bunch of (fragile bash) boilerplate, while the
>>>> result is interpreted the same as KSFT_PASS anyway.
>>>
>>> FWIW another idea that came up when talking to Matthieu -
>>> isolate the VMs which run time-sensitive tests to dedicated
>>> CPUs. Right now we kick off around 70 4 CPU VMs and let them 
>>> battle for 72 cores. The machines don't look overloaded but
>>> there can be some latency spikes (CPU use diagram attached).
>>>
>>> So the idea would be to have a handful of special VMs running 
>>> on dedicated CPUs without any CPU time competition. That could help 
>>> with latency spikes. But we'd probably need to annotate the tests
>>> which need some special treatment.
>>>
>>> Probably too much work both to annotate tests and set up env,
>>> but I thought I'd bring it up here in case you had an opinion.
>>
>> I'm not sure whether the issue with timing in VMs is CPU affinity.
>> Variance may just come from expensive hypercalls, even with a
>> dedicated CPU. Though tests can tell.
> 
> FTR, I think the CPU affinity setup is a bit too complex, and hard to
> reproduce for 3rd parties willing to investigate eventual future CI
> failures, I think the current env-variable-based approach would help
> with reproducibility.

I agree with you. Initially, with 70 VMs with 4 CPU cores, I thought it
would have taken more CPU resources, especially when KVM is not used.

Looking at the screenshot provided by Jakub, the host doesn't seem
overloaded, and the VM isolation is probably enough. Maybe only the
first test(s) can be impacted?

At the end, now that the runner without KVM is no longer there, the
situation should be improved :)

>> There's still the debug builds, as well.

For one MPTCP selftest checking the time to transfer some data, we
increase the tolerance by looking at kallsyms:

  grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\|
prove_locking$' /proc/kallsyms

We can also look at KSFT_MACHINE_SLOW if it is the new standard.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

