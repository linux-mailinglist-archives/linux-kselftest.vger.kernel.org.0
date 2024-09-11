Return-Path: <linux-kselftest+bounces-17740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64A9750D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81735282270
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1E185B7F;
	Wed, 11 Sep 2024 11:33:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7A185606;
	Wed, 11 Sep 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054382; cv=none; b=igSqRo2aNaTShgFgyx4esLF+th1TkELSeKShua6oUTSTpjND3E3hrtmAsSaGaddk8kEO9r+f54tTUONNC3N14Z9LgpPAC0EnSOxZ8jEKsjRA0leuzuHhUVO7b/Wss/+zNveQy6vy4ttGa6Qqtgb5bIIq1/+jvRJ8d9Vz4Z7JLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054382; c=relaxed/simple;
	bh=0DIxhEwZg/78wWcSQ5yXLGoyNvQez9CoT8yY1buUSUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nHKm9sB1cgVNySS25wve5XkG48Fg1VJ/jRam3l/V20FbB/IWPKMivKynSFf0FR/Wr0635QqFE2wP3z119CD/aPooLU49tC3pS2g4uFruaI/tXJOI4UQI/1aw0bsQ4iadz3AnDUQhdLGXx4CHGeop0zTNfC0tdxK9wsjsIBm2oD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X3dhp2Rzzz1SB6d;
	Wed, 11 Sep 2024 19:32:26 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4545C180043;
	Wed, 11 Sep 2024 19:32:56 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 19:32:55 +0800
Message-ID: <17df1bfe-4e73-464e-8802-019eb13159e3@huawei.com>
Date: Wed, 11 Sep 2024 19:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: add a test module for page_pool
To: Jesper Dangaard Brouer <hawk@kernel.org>, Mina Almasry
	<almasrymina@google.com>
CC: <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20240909091913.987826-1-linyunsheng@huawei.com>
 <CAHS8izNfLYQFgZYkRPJFonq8LH6SnV70B4pfC_cQ5gyz780cZA@mail.gmail.com>
 <b438256d-a233-4708-9a82-e4f5f4b86a63@huawei.com>
 <fda4dfdc-7ef8-4c75-8d29-a33a621fd703@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <fda4dfdc-7ef8-4c75-8d29-a33a621fd703@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/10 19:27, Jesper Dangaard Brouer wrote:
...

>>
>> The main issue I remembered was that it only support x86:(
>>
> 
> Yes, because I've added ASM code for reading TSC counter in a very
> precise manor. Given we run many iterations, then I don't think we
> need this precise reading.  I guess it can simply be replaced with
> get_cycles() or get_cycles64().  Then it should work on all archs.

Agreed.

> 
> The code already supports wall-clock time via ktime_get() (specifically
> ktime_get_real_ts64()).
> 
> 
>>>
>>> My preference here (for the performance part) is to upstream the
>>> out-of-tree tests that Jesper (and probably others) are using, rather
>>> than adding a new performance test that is not as battle-hardened.
>>
>> I looked through the out-of-tree tests again, it seems we can take the
>> best of them.
>> For Jesper' ko:
>> It seems we can do prefill as something that pp_fill_ptr_ring() does
>> in bench_page_pool_simple.c to avoid the noise from the page allocator.
>>
>>
>> For the ko in this patch:
>> It uses NAPI instead of tasklet mimicking the NAPI context, support
>> PP_FLAG_DMA_MAP flag testing, and return '-EAGAIN' in module_init()
>> to use perf stat for collecting and calculating performance data.
>>
> My bench don't return minus-number on module load, because I used perf
> record, and to see symbols decoded with perf report, I needed the module
> to be loaded.
> 
> I started on reading the PMU counters[1] around the bench loop, it works
> if enabling PMU counters yourself/manually, but I never finished that work.
> 
>  [1] https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/include/linux/time_bench.h#L195-L209
> 
> 
>> Is there other testcase or better practicing that we can learn from
>> Jesper' out of tree ko?
>>
> 
> I created a time_bench.c [2] module that other modules [3] can use to
> easier reuse the benchmarking code in other modules.
> 
>  [2] https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench.c
> 
>  [3] https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c

Will take a look at it, thanks.

> 
> --Jesper

