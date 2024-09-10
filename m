Return-Path: <linux-kselftest+bounces-17577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC597362D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C01C210C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E018DF99;
	Tue, 10 Sep 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoPILwgs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB21552FD;
	Tue, 10 Sep 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967626; cv=none; b=Gx4ZBdC5I6qqIWVdPTiVP4GQSr1AsepjZ0DuYoBv4G6ow2Q2r3pXNtwaVNKikd1r3xfzgGUL1LtQnGUpkX394sCWnbmSB5EA/qRS8A77Sg5guAVTdpjNqI6sK2/QMN22elYelqX29t4xeR7BzbKeX6afn9UlsSj3so0gZLJD1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967626; c=relaxed/simple;
	bh=EQQbxIJXXp4pwQwmDYZYIFCY6zHk/BzbetUtiAaBRIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKjmygripjJkRbuqHZ3yr8Nj+xjoaGxmbfxxSDvJn7V5KJYXlK/PWHSf8DWB7+Q4lJnI08xO52NOCMitCakvKCekWls4pMTOsY/FiRD2HzgRb6eEEgWFZGf/1qtbV5Gzzn8lMa9THdXRD/o36q4SmYrk7kr4kOSQQjBQEk9JrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoPILwgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1089FC4CEC3;
	Tue, 10 Sep 2024 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725967626;
	bh=EQQbxIJXXp4pwQwmDYZYIFCY6zHk/BzbetUtiAaBRIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BoPILwgsGkujskwywOlk0IgrmPyBHAggOtpnXAylGh0lqjRUwrWdROfBQKU/Sqjeb
	 LOm1YXofGtMEryqR1sdaiVJfp3W7k8s67daKv3GDJbctk4Z8jC6d9VQEihH3xbLIsX
	 ch5mLI4sN2D6Un6+nfqReuxeG8kr+yHIh8wmU3gxQomCbsO8BE62l3jqals9/2g2gc
	 1YPS7TA/aS/KZzZvtQQHj6aFaNJKZitkXoRs5ydwdypxia2f7srnpOiLoSj0L6Qbi/
	 vDgKleOanA2tWFEta4Yuw9I00vvpjdr3ux8Me9lS/8npjTXstyC4KoDnPpaCtiHpx7
	 EPfYXp+oGCE6Q==
Message-ID: <fda4dfdc-7ef8-4c75-8d29-a33a621fd703@kernel.org>
Date: Tue, 10 Sep 2024 13:27:02 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: add a test module for page_pool
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Mina Almasry <almasrymina@google.com>
Cc: ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20240909091913.987826-1-linyunsheng@huawei.com>
 <CAHS8izNfLYQFgZYkRPJFonq8LH6SnV70B4pfC_cQ5gyz780cZA@mail.gmail.com>
 <b438256d-a233-4708-9a82-e4f5f4b86a63@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <b438256d-a233-4708-9a82-e4f5f4b86a63@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/09/2024 12.46, Yunsheng Lin wrote:
> On 2024/9/10 1:28, Mina Almasry wrote:
>> On Mon, Sep 9, 2024 at 2:25 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>
>>> The testing is done by ensuring that the page allocated from
>>> the page_pool instance is pushed into a ptr_ring instance in
>>> a kthread/napi binded to a specified cpu, and a kthread/napi
>>> binded to a specified cpu will pop the page from the ptr_ring
>>> and free it back to the page_pool.
>>>
>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>
>> It seems this test is has a correctness part and a performance part.
>> For the performance test, Jesper has out of tree tests for the
>> page_pool:
>> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c
>>
>> I have these rebased on top of net-next and use them to verify devmem
>> & memory-provider performance:
>> https://github.com/mina/linux/commit/07fd1c04591395d15d83c07298b4d37f6b56157f
> 
> Yes, I used that testing ko too when adding frag API support for
> page_pool.
> 
> The main issue I remembered was that it only support x86:(
> 

Yes, because I've added ASM code for reading TSC counter in a very
precise manor. Given we run many iterations, then I don't think we
need this precise reading.  I guess it can simply be replaced with
get_cycles() or get_cycles64().  Then it should work on all archs.

The code already supports wall-clock time via ktime_get() (specifically
ktime_get_real_ts64()).


>>
>> My preference here (for the performance part) is to upstream the
>> out-of-tree tests that Jesper (and probably others) are using, rather
>> than adding a new performance test that is not as battle-hardened.
> 
> I looked through the out-of-tree tests again, it seems we can take the
> best of them.
> For Jesper' ko:
> It seems we can do prefill as something that pp_fill_ptr_ring() does
> in bench_page_pool_simple.c to avoid the noise from the page allocator.
> 
> 
> For the ko in this patch:
> It uses NAPI instead of tasklet mimicking the NAPI context, support
> PP_FLAG_DMA_MAP flag testing, and return '-EAGAIN' in module_init()
> to use perf stat for collecting and calculating performance data.
> 
My bench don't return minus-number on module load, because I used perf
record, and to see symbols decoded with perf report, I needed the module
to be loaded.

I started on reading the PMU counters[1] around the bench loop, it works
if enabling PMU counters yourself/manually, but I never finished that work.

  [1] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/include/linux/time_bench.h#L195-L209


> Is there other testcase or better practicing that we can learn from
> Jesper' out of tree ko?
> 

I created a time_bench.c [2] module that other modules [3] can use to
easier reuse the benchmarking code in other modules.

  [2] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench.c

  [3] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c

--Jesper

