Return-Path: <linux-kselftest+bounces-35287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D405ADECF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD5F18836EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362CB2E06FC;
	Wed, 18 Jun 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNf1h64f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070462E06EF;
	Wed, 18 Jun 2025 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250809; cv=none; b=dEmrdUz359GmHWZ1vE1GCdRLt4nkgALqnzZ6H2QxbkNQ88RdkClogkxW7/YQONCL+cZtMxrtHauy2+WGI2IFe9oEtsjJkTuXz41FiUvWrkQYSJZPbi//2coVQTqXH+Y+QpUynbPaYLrA+cH2zSelXcOxncVzyRC1SAvISoNZGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250809; c=relaxed/simple;
	bh=u1fNk4sNonPlV/2H949IVwNt/MR1MgWaifstjaJVxO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5j9xOsuqYiuWEWln37CT1XzPo6uMQBg568PQ+E4GCLiSy3y+80fA1kI6eusx+h6pFhOir1OOACnyuTlSjlLOoo5lvCusSFHXLVzqMPIY+tV/Cd9Uy+xdfMFs09N86UasqaqlulXImEdtjodp0lKZk/eE5PK4oyB5RgVcIRGZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNf1h64f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEB9C4CEE7;
	Wed, 18 Jun 2025 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750250808;
	bh=u1fNk4sNonPlV/2H949IVwNt/MR1MgWaifstjaJVxO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNf1h64fOgTzzyKYLnOG6pt4r/ATOcHrnakMZUTFUdWN76xMAKy/aPjTKRDA7HPk/
	 yLIhIf4Cbd8Sz3HTGEKOiX3lPZb8bP2Dd7yINp58hd6CrSKGuKET8piFkHCz1I+hPM
	 KfsZ1p9Vj5/i4/WsKC+cDp4/tuFawTqwriMhznsrnEh+46SuXpHNf6t0qDr+H5kIx5
	 qS9Z75u3H4D7SCAlvNEpLxF0xUz2Q2snVtxpEoZN/dyNBUNFgOpKan8drS200moqJe
	 BHZZi00AhDnfmsjjuCR6eEzjkkxZNgJyUK+DTpEjL1OKnOw8n8WBVMeHx/FJEnc5ZT
	 zY3JV676s2mlQ==
Message-ID: <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
Date: Wed, 18 Jun 2025 14:46:43 +0200
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/06/2025 23.11, Mina Almasry wrote:
> On Mon, Jun 16, 2025 at 2:29 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>> On 15/06/2025 22.59, Mina Almasry wrote:
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> We frequently consult with Jesper's out-of-tree page_pool benchmark to
>>> evaluate page_pool changes.
>>>
>>> Import the benchmark into the upstream linux kernel tree so that (a)
>>> we're all running the same version, (b) pave the way for shared
>>> improvements, and (c) maybe one day integrate it with nipa, if possible.
>>>
>>> Import bench_page_pool_simple from commit 35b1716d0c30 ("Add
>>> page_bench06_walk_all"), from this repository:
>>> https://github.com/netoptimizer/prototype-kernel.git
>>>
>>> Changes done during upstreaming:
>>> - Fix checkpatch issues.
>>> - Remove the tasklet logic not needed.
>>> - Move under tools/testing
>>> - Create ksft for the benchmark.
>>> - Changed slightly how the benchmark gets build. Out of tree, time_bench
>>>     is built as an independent .ko. Here it is included in
>>>     bench_page_pool.ko
>>>
>>> Steps to run:
>>>
>>> ```
>>> mkdir -p /tmp/run-pp-bench
>>> make -C ./tools/testing/selftests/net/bench
>>> make -C ./tools/testing/selftests/net/bench install INSTALL_PATH=/tmp/run-pp-bench
>>> rsync --delete -avz --progress /tmp/run-pp-bench mina@$SERVER:~/
>>> ssh mina@$SERVER << EOF
>>>     cd ~/run-pp-bench && sudo ./test_bench_page_pool.sh
>>> EOF
>>> ```
>>>
>>> Output:
>>>
>>> ```
>>> (benchmrk dmesg logs)
>>>
>>
>> Something is off with benchmark numbers compared to the OOT version.
>>
> 
> I assume you're comparing my results (my kernel config + my hardware +
> upstream benchmark) with your results (your kernel config + your
> hardware + OOT version). The problem may be in OOT vs upstream but it
> may be just different code/config/hardware.

True I used OOT version.

Just applied this patch, but I get compile error. Because Makefile tries
to get kernel headers (net/page_pool/helpers.h) from local Linux
installation instead of git tree.  This need to be adjusted for patch,
such that it builds with src-local/git tree provided headers.

$ make -C ./tools/testing/selftests/net/bench/page_pool/
make: Entering directory 
'/home/jbrouer/git/kernel/net/tools/testing/selftests/net/bench/page_pool'
make[1]: Entering directory '/usr/src/kernels/6.5.12-100.fc37.x86_64'
   CC [M] 
/home/jbrouer/git/kernel/net/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.o
/home/jbrouer/git/kernel/net/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c:12:10: 
fatal error: net/page_pool/helpers.h: No such file or directory
    12 | #include <net/page_pool/helpers.h>
       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:243: 
/home/jbrouer/git/kernel/net/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.o] 
Error 1
make[2]: *** [/usr/src/kernels/6.5.12-100.fc37.x86_64/Makefile:2046: 
/home/jbrouer/git/kernel/net/tools/testing/selftests/net/bench/page_pool] 
Error 2
make[1]: *** [Makefile:246: __sub-make] Error 2
make[1]: Leaving directory '/usr/src/kernels/6.5.12-100.fc37.x86_64'
make: *** [Makefile:14: all] Error 2
make: Leaving directory 
'/home/jbrouer/git/kernel/net/tools/testing/selftests/net/bench/page_pool'


>> Adding my numbers below, they were run on my testlab with:
>>    - CPU E5-1650 v4 @ 3.60GHz
>>    - kernel: net.git v6.15-12438-gd9816ec74e6d
>>
>>> Fast path results:
>>> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
>>>
>>
>> Fast-path on your CPU is faster (22 cycles(tsc) 6.128 ns) than my CPU.
>> What CPU is this?
> 
> My test setup is a Gcloud A3 VM (so virtualized). The CPU is:
> 
> cat /proc/cpuinfo
> ...
> model name      : Intel(R) Xeon(R) Platinum 8481C CPU @ 2.70GHz
> 
>>
>> Type:no-softirq-page_pool01 Per elem: 22 cycles(tsc) 6.128 ns (step:0)
>>    - (measurement period time:0.061282924 sec time_interval:61282924)
>>    - (invoke count:10000000 tsc_interval:220619745)
>>
>>> ptr_ring results:
>>> no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
>>
>> I'm surprised that ptr_ring benchmark is very slow, compared to my
>> result (below) 60 cycles(tsc) 16.853 ns.
>>
>> Type:no-softirq-page_pool02 Per elem: 60 cycles(tsc) 16.853 ns (step:0)
>>    - (measurement period time:0.168535760 sec time_interval:168535760)
>>    - (invoke count:10000000 tsc_interval:606734160)
>>
>> Maybe your kernel is compiled with some CONFIG debug thing that makes it
>> slower?
>>
> 
> Yeah, I actually just checked and I have CONFIG_DEBUG_NET on in my
> build, and a lot of other debug configs are turned on.
> 

The CONFIG_DEBUG_NET should be low overhead, so I don't expect this to
be the root-cause.  Other CONFIG options are more likely the issue.

> Let me investigate here. Maybe trimming the debug configs and double
> checking my tree for debug logs I added would point to the difference.
>

The perf record trick below will help you identify overhead more rabidly 
IMHO.


> I could also try to put both the OOT version and upstream version in
> my tree and do a proper A/B comparison that way.
> 
> If you do get chance to run this upstream version from your exact tree
> and config, that would be a good A/B comparison as well.
> 
>> You can troubleshoot like this:
>>    - select the `no-softirq-page_pool02` test via run_flags=$((2#100)).
>>
>>    # perf record -g modprobe bench_page_pool_simple run_flags=$((2#100))
>> loops=$((100*10**6))
>>    # perf report --no-children
>>
> 
> Thanks, will do.

With a micro-benchmark like this, the perf report should help you to
quickly indentify the kernel debug CONFIG that adds the overhead.

--Jesper


