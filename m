Return-Path: <linux-kselftest+bounces-17576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313EC97354E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 12:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F431C24E1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023318FC65;
	Tue, 10 Sep 2024 10:46:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B414D431;
	Tue, 10 Sep 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965173; cv=none; b=kQkNqeX6U8dTOa3XxiM7okUF6c4KIQHLYsOyAzB3FyjPSn4gZM8/Tw2scvCL1/eH/qBq2TfAhgZk55nghMMk8vO7odpmgxblY6is6HAakVFIewpriyhP9tHqNYm1oGJo32rMCz+T5fR5zYYdvHv+couOtjEs8n0YzBsgPLXGIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965173; c=relaxed/simple;
	bh=4+n+yhtKq/1EmKfGojZXbzM1JsjV8W6GtUOG1tc04HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YjM0l8BVTWuSa1q9GSJtnKSNTO5v7tve5Zeo5q//DdKRwqGKk9or2D2ExpAwc/vbIG1Ctcv/6pFr+V/G23oHbwB4hvAPWo8amYCNbIdcE8xwdC7P7qeJHwblZrLTAZIVcLK9fIezaObrNP45PUAonCilidaXgYTvDGyVvTVZhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X30jK1L8lz2DbkM;
	Tue, 10 Sep 2024 18:45:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F8F11A0188;
	Tue, 10 Sep 2024 18:46:09 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 18:46:08 +0800
Message-ID: <b438256d-a233-4708-9a82-e4f5f4b86a63@huawei.com>
Date: Tue, 10 Sep 2024 18:46:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: add a test module for page_pool
To: Mina Almasry <almasrymina@google.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20240909091913.987826-1-linyunsheng@huawei.com>
 <CAHS8izNfLYQFgZYkRPJFonq8LH6SnV70B4pfC_cQ5gyz780cZA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAHS8izNfLYQFgZYkRPJFonq8LH6SnV70B4pfC_cQ5gyz780cZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/10 1:28, Mina Almasry wrote:
> On Mon, Sep 9, 2024 at 2:25 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> The testing is done by ensuring that the page allocated from
>> the page_pool instance is pushed into a ptr_ring instance in
>> a kthread/napi binded to a specified cpu, and a kthread/napi
>> binded to a specified cpu will pop the page from the ptr_ring
>> and free it back to the page_pool.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> It seems this test is has a correctness part and a performance part.
> For the performance test, Jesper has out of tree tests for the
> page_pool:
> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c
> 
> I have these rebased on top of net-next and use them to verify devmem
> & memory-provider performance:
> https://github.com/mina/linux/commit/07fd1c04591395d15d83c07298b4d37f6b56157f

Yes, I used that testing ko too when adding frag API support for
page_pool.

The main issue I remembered was that it only support x86:(

> 
> My preference here (for the performance part) is to upstream the
> out-of-tree tests that Jesper (and probably others) are using, rather
> than adding a new performance test that is not as battle-hardened.

I looked through the out-of-tree tests again, it seems we can take the
best of them.
For Jesper' ko:
It seems we can do prefill as something that pp_fill_ptr_ring() does
in bench_page_pool_simple.c to avoid the noise from the page allocator.


For the ko in this patch:
It uses NAPI instead of tasklet mimicking the NAPI context, support
PP_FLAG_DMA_MAP flag testing, and return '-EAGAIN' in module_init()
to use perf stat for collecting and calculating performance data.

Is there other testcase or better practicing that we can learn from
Jesper' out of tree ko?

> 
> --
> Thanks,
> Mina
> 

