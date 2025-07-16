Return-Path: <linux-kselftest+bounces-37439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56296B078FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DC67AD33F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A52620FC;
	Wed, 16 Jul 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1qYKzn0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B4199EAD;
	Wed, 16 Jul 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677730; cv=none; b=kyCVrH6mWT2ERHc+4ks2i/ruJV0DeaWilROvElMzsrR66FgHloFtR8Hauuft5xwbYrEXMzj7YXGW9L9tqmfIik4WFfOGpUlgeXKcMqdxX1T8sTP8+HLp/HBSO1h6MwP2OaH1EamypmNYVYbkwmYqrMz8peG2D/Nwh5hkaXZax0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677730; c=relaxed/simple;
	bh=SSReJtbBfV0veA8X/z68WJ/t9z1BMBY8PzraC8gu5yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ/lZPEz3i4An0Uk5TQUWg36DBj2oxqtcG5eJ9SQtNFkIOcKCilRGdkgKpW8ZkM6rql9oeum8pGOiu4rG3J60pehOK9tq0RLKAq605gfLVrMR5IBKTMOdvQkKE3fkVSeQBW6Jg7wHvvO/e0yPTnbX4Gxp3umNiipLU0ZMK1D5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1qYKzn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CF0C4CEE7;
	Wed, 16 Jul 2025 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752677729;
	bh=SSReJtbBfV0veA8X/z68WJ/t9z1BMBY8PzraC8gu5yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n1qYKzn03Wc9+yFw8JqV8ahTpJfCeQG/DtQ5e2WZ88DPzmzCRj+ykJSkoeW+SpwS7
	 JZEDMBT4m7b+zEYGViiu2FcdKozcNKUlVr6w1O8VHOn+eOp0JCcazI01fzJYKP/Xc3
	 MOGB8czviloprHFvxcq2yoBfc4y0ebCHr778FkCfINmVk5/CaRqLp1PufSbRz4ZKEc
	 CRGiwrDGavzrXSO8yV/olz/dVVkZdgueCNxwNY2l6BoEurYqxINmsamtC5rgeKTcFv
	 ZBkHRH3l5k1lHEI+G4O7ZJ0+67vIoGFQ48lRwkkONFTQvaFBOG642e1yUrBb62ajxE
	 j9tSK4qF1O7XA==
Message-ID: <ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
Date: Wed, 16 Jul 2025 16:55:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Christoph Paasch <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
 <20250715185308.2ad30691@kernel.org> <20250716072602.386a8963@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250716072602.386a8963@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 16/07/2025 16:26, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 18:53:08 -0700 Jakub Kicinski wrote:
>> On Tue, 15 Jul 2025 20:43:27 +0200 Matthieu Baerts (NGI0) wrote:
>>> mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C" to
>>> make sure everything works as expected when using "mmap" and "sendfile"
>>> modes instead of "poll", and with the MPTCP checksum support.
>>>
>>> These modes should be validated, but they are not when the selftests are
>>> executed via the kselftest helpers. It means that most CIs validating
>>> these selftests, like NIPA for the net development trees and LKFT for
>>> the stable ones, are not covering these modes.
>>>
>>> To fix that, new test programs have been added, simply calling
>>> mptcp_connect.sh with the right parameters.
>>>
>>> The first patch can be backported up to v5.6, and the second one up to
>>> v5.14.  
>>
>> Looks like the failures that Paolo flagged yesterday:
>>
>> https://lore.kernel.org/all/a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com/
>>
>> are back as soon as this hit NIPA :(
>>
>> https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-07-16--00-00&executor=vmksft-mptcp&pw-n=0&pass=0
>>
>> No idea why TBH, the tests run sequentially and connect.sh run before
>> any of the new ones.

And just to be sure, no CPU or IO overload at that moment? I didn't see
such errors reported by our CI, but I can try to reproduce them locally
in different conditions.

>> I'm gonna leave it in patchwork in case the next run is clean,
>> please use pw-bot to discard them if they keep failing.

Oops, sorry I forgot to reply: when I checked in the morning, the last
two builds were clean. I wanted to check the next one, then I forgot :)

> It failed again on the latest run, in a somewhat more concerning way :(
> 
> # (duration 30279ms) [FAIL] file received by server does not match (in, out):
> # -rw------- 1 root root 5171914 Jul 16 05:24 /tmp/tmp.W2c96hxSIz
> # Trailing bytes are: 
> # w,ѐ)-rw------- 1 root root 5166208 Jul 16 05:24 /tmp/tmp.s33PNcrN6M
> # Trailing bytes are: 
> # (<v /&^<rnFsaC7INFO: with peek mode: saveAfterPeek
> 
> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/211121/4-mptcp-connect-sh/stdout

I see, the error can be a bit scary :)

If I'm not mistaken, there was a poll timeout error before. When it is
detected, the test is stopped. After each test, even in case of errors,
the received file is compared with the sending one. So here, this
concerning error is expected.

Anyway, even if the errors are not caused by this series, I think it is
better to delay these patches while we are investigating that:

pw-bot: cr


> BTW feeding the random data into hexdump-like formatter seems
> advisable? :P

It is just to check that the CIs can correctly parse random data :-D

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


