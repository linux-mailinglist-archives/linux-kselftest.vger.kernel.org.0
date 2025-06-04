Return-Path: <linux-kselftest+bounces-34293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1EACDA01
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379DE3A3874
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8128AAE5;
	Wed,  4 Jun 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac7oM1fh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F12638A3;
	Wed,  4 Jun 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026348; cv=none; b=mhYRhfeG9fUidValFUoSpqFO9xG0OylZ8RsR4Da3J3jhR/KjHlByFznWN/BSwKfc1RYdtxa9mHeF/G/T+sTOdJQ+WL6V3zNeLzG76+8GFjNqx1QNGdyfCOEtTJWJbigR0PKnx9BEKSq1WlDaOh6a7aUI7yEa/A0z3ftmG7s2iMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026348; c=relaxed/simple;
	bh=TrSKCb5/EH4IQccVNmxWPdRPEdzJVs8FV7rzgkAQSp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Idt18it3BrcRZR+cGXjxvyj9zynfiy1s42jZ3mTj1A9y2rMbJa31rOD+SuiaW3e0Mn+ZRrE7mv4n6sOqWtnUZe90r8+zccptr414qIVth42kcDbiY17EG4N0QKp5cmeXK86rQRTgjU1alC5WkfDcZMbkK7uCmpSqqgy2h0BXvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac7oM1fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20ADC4CEF0;
	Wed,  4 Jun 2025 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749026348;
	bh=TrSKCb5/EH4IQccVNmxWPdRPEdzJVs8FV7rzgkAQSp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ac7oM1fhdXJ0L3ZiV6VhiB+LtYZ6kj4RDE9hvNN+gsaLUxaBexFI+hQFrv0PJiEzZ
	 CD/cBuNA1n+tvK2tB/CyhKRnS5C+cWt9zER3AhIWTjFIksZ5f09965jSPrWVdeAMz6
	 H7QTMKCBFf+pjbejVmjVvMuaT6vP8330aWNhGuDPvxz+46A2KWF8AERWuRAzLfD6ZG
	 0jW29V47nrRfIJdfa08SXbiPA0a5fZQViexdozardSvVvH4iTEbERSbYuBm0czEyvA
	 bYG1lHKRUHTrkU9h1rW3Yt0X8KRwakMxUiTzDumWT40fgETcT/D3ekEMg8NeYvja0S
	 z8IAVfaP1nopg==
Message-ID: <6fd8b288-2719-424b-92d2-3dcfe03bbaef@kernel.org>
Date: Wed, 4 Jun 2025 10:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool
 benchmark
To: Mina Almasry <almasrymina@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk>
 <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
 <87h615m6cp.fsf@toke.dk>
 <CAHS8izNDSTkmC32aRA9R=phqRfZUyz06Psc=swOpfVW5SW4R_w@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAHS8izNDSTkmC32aRA9R=phqRfZUyz06Psc=swOpfVW5SW4R_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/05/2025 21.46, Mina Almasry wrote:
> On Wed, May 28, 2025 at 2:28 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>>> On Mon, May 26, 2025 at 5:51 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>> Fast path results:
>>>>> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
>>>>>
>>>>> ptr_ring results:
>>>>> no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
>>>>>
>>>>> slow path results:
>>>>> no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
>>>>> ```
>>>>>
>>>>> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>> Cc: Toke Høiland-Jørgensen <toke@toke.dk>
>>>>>
>>>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>>>
>>>> Back when you posted the first RFC, Jesper and I chatted about ways to
>>>> avoid the ugly "load module and read the output from dmesg" interface to
>>>> the test.
>>>>
>>>
>>> I agree the existing interface is ugly.
>>>
>>>> One idea we came up with was to make the module include only the "inner"
>>>> functions for the benchmark, and expose those to BPF as kfuncs. Then the
>>>> test runner can be a BPF program that runs the tests, collects the data
>>>> and passes it to userspace via maps or a ringbuffer or something. That's
>>>> a nicer and more customisable interface than the printk output. And if
>>>> they're small enough, maybe we could even include the functions into the
>>>> page_pool code itself, instead of in a separate benchmark module?
>>>>
>>>> WDYT of that idea? :)
>>>
>>> ...but this sounds like an enormous amount of effort, for something
>>> that is a bit ugly but isn't THAT bad. Especially for me, I'm not that
>>> much of an expert that I know how to implement what you're referring
>>> to off the top of my head. I normally am open to spending time but
>>> this is not that high on my todolist and I have limited bandwidth to
>>> resolve this :(
>>>
>>> I also feel that this is something that could be improved post merge.
>>> I think it's very beneficial to have this merged in some form that can
>>> be improved later. Byungchul is making a lot of changes to these mm
>>> things and it would be nice to have an easy way to run the benchmark
>>> in tree and maybe even get automated results from nipa. If we could
>>> agree on mvp that is appropriate to merge without too much scope creep
>>> that would be ideal from my side at least.
>>
>> Right, fair. I guess we can merge it as-is, and then investigate whether
>> we can move it to BPF-based (or maybe 'perf bench' - Cc acme) later :)
> 
> Thanks for the pliability. Reviewed-bys and comments welcome.
> 
> Additionally Signed-off-by from Jesper is needed I think. Since most
> of this code is his, I retained his authorship. Jesper, whenever this
> looks good to me, a signed-off-by would be good and I would carry it
> to future versions. Changing authorship to me is also fine by me but I
> would think you want to retain the credit.

Okay, I think Ilias'es comment[1] and ACK convinced me, let us merge
this as-is.  We have been asking people to run it over several years
before accepting patches. We shouldn't be pointing people to use
out-of-tree tests for accepting patches.

It is not perfect, but it have served us well for benchmarking in the
last approx 10 years (5 years for page_pool test).  It is isolated as a
selftest under (tools/testing/selftests/net/bench/page_pool/).

Realistically we are all too busy inventing a new "perfect" benchmark
for page_pool. That said, I do encourage others with free cycles to
integrated a better benchmark test into `perf bench`.  Then we can just
remove this module again.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

  [1] 
https://lore.kernel.org/all/CAC_iWjLmO4XZ_+PBaCNxpVCTmGKNBsLGyeeKS2ptRrepn1u0SQ@mail.gmail.com/

Thanks Mina for pushing this forward,
--Jesper

