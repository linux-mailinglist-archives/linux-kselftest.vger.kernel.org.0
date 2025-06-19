Return-Path: <linux-kselftest+bounces-35355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10554AE0290
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 12:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6851F1BC1424
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671A222577;
	Thu, 19 Jun 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em0J8tBU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587E2222C5;
	Thu, 19 Jun 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328675; cv=none; b=LMQ5gCdDOx8SFdi6xCa+8eA/gU3vS9k8wnm0vVN1IVr5MNUttGUjOiZ5cL0qUALc7SpqOYMd6zuGi8b7B2azlyeLw1wGv5xF/uQ+WBKn8yH1rcddL7SAobsrQaUiqn6dTJnPZjMO/rUHHwfB3jfIotDrbV9cr6S7Z1mH8dCe9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328675; c=relaxed/simple;
	bh=KBSsy/BlJxV1qwZnyo+C8SN0dRhnb7EWEpJVD7QDyMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFZk9eJqye+ZCQVrdLNyq43pmesGuzB6leS9CNuV3at1LM/QhXn0hAkOM7Wf4HmhO6km1EGOZobcYhWPfCgp5s1dHaX5FOliRX11kPCaEEOp6Jbk+BIcy8OQfkimvjo9of6uYRmNEmksx0pCnKKZBpNcUOC0HbKYTZQ3n7vFL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em0J8tBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3FDC4CEEA;
	Thu, 19 Jun 2025 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328674;
	bh=KBSsy/BlJxV1qwZnyo+C8SN0dRhnb7EWEpJVD7QDyMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=em0J8tBUtud5bznU+lt1PYj2RC2d/Up1tUvdqsRTm6StLJDJDhCQJvvQwsS80WeeP
	 py777ZWC3yHLV6AkkwHNiT4eH6CXZEWV9eMtp8xrGrGafGx/L+tW5igurnx1GYKEZZ
	 z2aplgxELANRFosFbcNj17NXmJ8KBKx/4evwkKiTCTgd9DmGNytWC1CdCQHu0Z6oJo
	 DU3P4HM/YP9+WZIOPewzNdOxDYIlM8aOirJC1r7RRoBuT4nJbKJipBroLPuIDID7uW
	 /lj/T6nXnoWw++tSTCVn41QVVfpwARgByQ4UOz45IB8QYVFJ/juVh/kYYP6z4Tz+eb
	 tfuOEziKsv0mA==
Message-ID: <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org>
Date: Thu, 19 Jun 2025 12:24:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool
 benchmark
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, Ignat Korchagin <ignat@cloudflare.com>
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org>
 <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
 <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/06/2025 06.19, Mina Almasry wrote:
> On Wed, Jun 18, 2025 at 5:46 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>> Something is off with benchmark numbers compared to the OOT version.
>>>>
>>>
>>> I assume you're comparing my results (my kernel config + my hardware +
>>> upstream benchmark) with your results (your kernel config + your
>>> hardware + OOT version). The problem may be in OOT vs upstream but it
>>> may be just different code/config/hardware.
>>
>> True I used OOT version.
>>
>> Just applied this patch, but I get compile error. Because Makefile tries
>> to get kernel headers (net/page_pool/helpers.h) from local Linux
>> installation instead of git tree.  This need to be adjusted for patch,
>> such that it builds with src-local/git tree provided headers.
>>
> 
> I believe the fix to that is to do:
> 
> make KDIR=$(pwd) -C ./tools/testing/selftests/net/bench
> 

Yes, this worked for me.

> I.e. the build files assume you're building the test to run it on the
> current machine, to cross compile it for a different machine under
> test, we need to pass explicit KDIR. I've kinda copy-pasted what other
> TEST_GEN_MODS_DIR= makefiles do. In theory we could do something else
> but I am guessing the way current TEST_GEN_MODS_DIR does it is the way
> to go. Does it work for you if you do that?

Yes.

> [...]
>>>
>>> Yeah, I actually just checked and I have CONFIG_DEBUG_NET on in my
>>> build, and a lot of other debug configs are turned on.
>>>
>>
>> The CONFIG_DEBUG_NET should be low overhead, so I don't expect this to
>> be the root-cause.  Other CONFIG options are more likely the issue.
>>
> 
> Thank you very much for the tips. Perf report showed the locking was
> taking forever on my kernel... I had locking debug configs enabled in
> my build... sorry... with those disabled, I get much more sane
> results:
> 
> [  185.557293] bench_page_pool: time_bench_page_pool01_fast_path():
> Cannot use page_pool fast-path
> [  185.607873] bench_page_pool: Type:no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.177 ns (step:0) - (measurement period
> time:0.041772642 sec time_interval:41772642) - (invoke count:10000000 tsc_interval:112778487)
> [  185.627090] bench_page_pool: time_bench_page_pool02_ptr_ring():
> Cannot use page_pool fast-path
> [  185.826991] bench_page_pool: Type:no-softirq-page_pool02 Per elem: 51 cycles(tsc) 19.117 ns (step:0) - (measurement period
> time:0.191178107 sec time_interval:191178107) - (invoke count:10000000 tsc_interval:516173586)
> [  185.846380] bench_page_pool: time_bench_page_pool03_slow(): Cannot
> use page_pool fast-path
> [  186.479432] bench_page_pool: Type:no-softirq-page_pool03 Per elem: 168 cycles(tsc) 62.469 ns (step:0) - (measurement period
> time:0.624690697 sec time_interval:624690697) - (invoke count:10000000 tsc_interval:1686656879)


My results with this patch:

$ sudo ./test_bench_page_pool.sh
rmmod: ERROR: Module bench_page_pool is not currently loaded
[268960.638885] bench_page_pool: Loaded
[268960.684603] bench_page_pool: Type:for_loop Per elem: 1 cycles(tsc) 
0.420 ns (step:0) - (measurement period time:0.042037752 sec 
time_interval:42037752) - (invoke count:100000000 tsc_interval:151336355)
[268961.203806] bench_page_pool: Type:atomic_inc Per elem: 18 
cycles(tsc) 5.010 ns (step:0) - (measurement period time:0.501077936 sec 
time_interval:501077936) - (invoke count:100000000 tsc_interval:1803899823)
[268961.332771] bench_page_pool: Type:lock Per elem: 39 cycles(tsc) 
11.041 ns (step:0) - (measurement period time:0.110410468 sec 
time_interval:110410468) - (invoke count:10000000 tsc_interval:397481145)
[268961.350718] bench_page_pool: time_bench_page_pool01_fast_path(): 
Cannot use page_pool fast-path
[268961.425335] bench_page_pool: Type:no-softirq-page_pool01 Per elem: 
23 cycles(tsc) 6.571 ns (step:0) - (measurement period time:0.065719390 
sec time_interval:65719390) - (invoke count:10000000 tsc_interval:236591475)
[268961.444666] bench_page_pool: time_bench_page_pool02_ptr_ring(): 
Cannot use page_pool fast-path
[268961.622103] bench_page_pool: Type:no-softirq-page_pool02 Per elem: 
60 cycles(tsc) 16.862 ns (step:0) - (measurement period time:0.168626201 
sec time_interval:168626201) - (invoke count:10000000 
tsc_interval:607060218)
[268961.641608] bench_page_pool: time_bench_page_pool03_slow(): Cannot 
use page_pool fast-path
[268962.387479] bench_page_pool: Type:no-softirq-page_pool03 Per elem: 
265 cycles(tsc) 73.739 ns (step:0) - (measurement period 
time:0.737399722 sec time_interval:737399722) - (invoke count:10000000 
tsc_interval:2654665224)

Fast path results:
no-softirq-page_pool01 Per elem: 23 cycles(tsc) 6.571 ns

ptr_ring results:
no-softirq-page_pool02 Per elem: 60 cycles(tsc) 16.862 ns

slow path results:
no-softirq-page_pool03 Per elem: 265 cycles(tsc) 73.739 ns


> Does this alleviate your concern? Or do you still see an issue here?
> There is still a delta between our results, on different
> hardware/configs but results are in a sane range now.

Now the results a sane and in range :-)

--Jesper



