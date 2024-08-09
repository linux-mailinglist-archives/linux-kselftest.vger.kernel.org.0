Return-Path: <linux-kselftest+bounces-15066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B594CF37
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 13:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EB1F21295
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34386192B78;
	Fri,  9 Aug 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="C/ltqUkl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABB174EE7;
	Fri,  9 Aug 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201764; cv=pass; b=smg8WbPQdsHMUSEKxGyBnCljLcr1aKVJ0AL/uEnn7IYiiyRh4XlGivLDaXqI48RVj+XgvTDGP1vUNgy+ZgAX4yQ5jYquwVU2+NKnOBqG8z/48QhgD4HexPmN7ZXMneDST9SqXHfjxlAA5eWEGrWgDewH6e7e6E8rJuf1CLj5Xvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201764; c=relaxed/simple;
	bh=LVGH8pZcHf2mIztLWUnnDNn5tEpjok2zG1Z4WQ9P4cc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=swBeclFHgCzMBCKBG55xwOG+63kPl/zhfGVvXiiMF3t5R4hYdxvvRlzxt4MddzAVo3EK4gV6RaYL41nZsb+bOry+MEIThVZ5HyWJCpKYLNDON7hdcVD0XFqsPiqWY2TIybkwvvNfE9x8+U4VaNE5Xd1cRSzTOX9EagGLMNblQ3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=C/ltqUkl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723201741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E39N1uqaZX3+g+gBivOf970A5u/QU6RL3nhYyxO89/RpUlu/Uv3Y0Ef16oVWMhSzLe8EeGuOefkVuygQ1Uj/AJsvVNUPplk7NElLReTFGvM1JYm0cWer239JcaQvtmHtdrBKD/aDEtDSgxyB936RKGKciajFIigjL7CzvOt6Cd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723201741; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rHyOtbCYhH4xW9p24eAhLIGzkPnru76xN+aYLDcG/xI=; 
	b=DsGigq9xdUr7Hu0eeI72ZdzQcH1IlYb4K9F9mG6jdJH8GGKIdey8jZOK3tVpwcpjOgRdN8RR3WIl17XGQ0quBuJRaG2i26ma56NvNpTyx5jMp65WQYUdblGi0PK2bnZrFcLxJtCdQQzEOds1nsqAZ5rmfFIyZdPrizVLK4qzcr8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723201741;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rHyOtbCYhH4xW9p24eAhLIGzkPnru76xN+aYLDcG/xI=;
	b=C/ltqUklZYdeHBEfbCMOnmzRIXHn5ekf4LXfOl3u+9EyZw+mFj9/NMIzBq0GH/NC
	tbValxXpfACws0bNsLEsWtl8MzHmmZCEIWfgoX9Ze3Nepdx/7rLBHVLz2RGCNdMmc0G
	EZOd8+r/9g0JXR3pvlEqgsaBZnJMc8nVNnQSl2N4=
Received: by mx.zohomail.com with SMTPS id 1723201740148694.8195062997816;
	Fri, 9 Aug 2024 04:09:00 -0700 (PDT)
Message-ID: <0ec39cb0-5213-4468-8e61-2fc349531ae3@collabora.com>
Date: Fri, 9 Aug 2024 16:08:54 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v13 01/14] mm: page_frag: add a test module for
 page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-2-linyunsheng@huawei.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240808123714.462740-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/8/24 5:37 PM, Yunsheng Lin wrote:
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptr_ring
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptr_ring and free the fragment.
> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   2 +
>  tools/testing/selftests/mm/page_frag/Makefile |  18 ++
>  .../selftests/mm/page_frag/page_frag_test.c   | 170 ++++++++++++++++++
Why are you adding a test module in kselftests? Have you considered
adding Kunit instead? Kunit is more suited to test kernel's internal
APIs which aren't exposed to userspace.

>  tools/testing/selftests/mm/run_vmtests.sh     |   9 +-
>  4 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
>  create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 901e0d07765b..e91ed29378fc 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -36,6 +36,8 @@ MAKEFLAGS += --no-builtin-rules
>  CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>  LDLIBS = -lrt -lpthread -lm
>  
> +TEST_GEN_MODS_DIR := page_frag
> +
>  TEST_GEN_FILES = cow
>  TEST_GEN_FILES += compaction_test
>  TEST_GEN_FILES += gup_longterm
> diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
> new file mode 100644
> index 000000000000..58dda74d50a3
> --- /dev/null
> +++ b/tools/testing/selftests/mm/page_frag/Makefile
> @@ -0,0 +1,18 @@
> +PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> +KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
> +
> +ifeq ($(V),1)
> +Q =
> +else
> +Q = @
> +endif
> +
> +MODULES = page_frag_test.ko
> +
> +obj-m += page_frag_test.o
> +
> +all:
> +	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) modules
> +
> +clean:
> +	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) clean
> diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
> new file mode 100644
> index 000000000000..0e803db1ad79
> --- /dev/null
> +++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test module for page_frag cache
> + *
> + * Copyright: linyunsheng@huawei.com
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/cpumask.h>
> +#include <linux/completion.h>
> +#include <linux/ptr_ring.h>
> +#include <linux/kthread.h>
> +
> +static struct ptr_ring ptr_ring;
> +static int nr_objs = 512;
> +static atomic_t nthreads;
> +static struct completion wait;
> +static struct page_frag_cache test_frag;
> +
> +static int nr_test = 5120000;
> +module_param(nr_test, int, 0);
> +MODULE_PARM_DESC(nr_test, "number of iterations to test");
> +
> +static bool test_align;
> +module_param(test_align, bool, 0);
> +MODULE_PARM_DESC(test_align, "use align API for testing");
> +
> +static int test_alloc_len = 2048;
> +module_param(test_alloc_len, int, 0);
> +MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
> +
> +static int test_push_cpu;
> +module_param(test_push_cpu, int, 0);
> +MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
> +
> +static int test_pop_cpu;
> +module_param(test_pop_cpu, int, 0);
> +MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
> +
> +static int page_frag_pop_thread(void *arg)
> +{
> +	struct ptr_ring *ring = arg;
> +	int nr = nr_test;
> +
> +	pr_info("page_frag pop test thread begins on cpu %d\n",
> +		smp_processor_id());
> +
> +	while (nr > 0) {
> +		void *obj = __ptr_ring_consume(ring);
> +
> +		if (obj) {
> +			nr--;
> +			page_frag_free(obj);
> +		} else {
> +			cond_resched();
> +		}
> +	}
> +
> +	if (atomic_dec_and_test(&nthreads))
> +		complete(&wait);
> +
> +	pr_info("page_frag pop test thread exits on cpu %d\n",
> +		smp_processor_id());
> +
> +	return 0;
> +}
> +
> +static int page_frag_push_thread(void *arg)
> +{
> +	struct ptr_ring *ring = arg;
> +	int nr = nr_test;
> +
> +	pr_info("page_frag push test thread begins on cpu %d\n",
> +		smp_processor_id());
> +
> +	while (nr > 0) {
> +		void *va;
> +		int ret;
> +
> +		if (test_align) {
> +			va = page_frag_alloc_align(&test_frag, test_alloc_len,
> +						   GFP_KERNEL, SMP_CACHE_BYTES);
> +
> +			WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
> +				  "unaligned va returned\n");
> +		} else {
> +			va = page_frag_alloc(&test_frag, test_alloc_len, GFP_KERNEL);
> +		}
> +
> +		if (!va)
> +			continue;
> +
> +		ret = __ptr_ring_produce(ring, va);
> +		if (ret) {
> +			page_frag_free(va);
> +			cond_resched();
> +		} else {
> +			nr--;
> +		}
> +	}
> +
> +	pr_info("page_frag push test thread exits on cpu %d\n",
> +		smp_processor_id());
> +
> +	if (atomic_dec_and_test(&nthreads))
> +		complete(&wait);
> +
> +	return 0;
> +}
> +
> +static int __init page_frag_test_init(void)
> +{
> +	struct task_struct *tsk_push, *tsk_pop;
> +	ktime_t start;
> +	u64 duration;
> +	int ret;
> +
> +	test_frag.va = NULL;
> +	atomic_set(&nthreads, 2);
> +	init_completion(&wait);
> +
> +	if (test_alloc_len > PAGE_SIZE || test_alloc_len <= 0 ||
> +	    !cpu_active(test_push_cpu) || !cpu_active(test_pop_cpu))
> +		return -EINVAL;
> +
> +	ret = ptr_ring_init(&ptr_ring, nr_objs, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	tsk_push = kthread_create_on_cpu(page_frag_push_thread, &ptr_ring,
> +					 test_push_cpu, "page_frag_push");
> +	if (IS_ERR(tsk_push))
> +		return PTR_ERR(tsk_push);
> +
> +	tsk_pop = kthread_create_on_cpu(page_frag_pop_thread, &ptr_ring,
> +					test_pop_cpu, "page_frag_pop");
> +	if (IS_ERR(tsk_pop)) {
> +		kthread_stop(tsk_push);
> +		return PTR_ERR(tsk_pop);
> +	}
> +
> +	start = ktime_get();
> +	wake_up_process(tsk_push);
> +	wake_up_process(tsk_pop);
> +
> +	pr_info("waiting for test to complete\n");
> +	wait_for_completion(&wait);
> +
> +	duration = (u64)ktime_us_delta(ktime_get(), start);
> +	pr_info("%d of iterations for %s testing took: %lluus\n", nr_test,
> +		test_align ? "aligned" : "non-aligned", duration);
> +
> +	ptr_ring_cleanup(&ptr_ring, NULL);
> +	page_frag_cache_drain(&test_frag);
> +
> +	return -EAGAIN;
> +}
> +
> +static void __exit page_frag_test_exit(void)
> +{
> +}
> +
> +module_init(page_frag_test_init);
> +module_exit(page_frag_test_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yunsheng Lin <linyunsheng@huawei.com>");
> +MODULE_DESCRIPTION("Test module for page_frag");
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 03ac4f2e1cce..3636d984b786 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -75,6 +75,8 @@ separated by spaces:
>  	read-only VMAs
>  - mdwe
>  	test prctl(PR_SET_MDWE, ...)
> +- page_frag
> +	test handling of page fragment allocation and freeing
>  
>  example: ./run_vmtests.sh -t "hmm mmap ksm"
>  EOF
> @@ -231,7 +233,8 @@ run_test() {
>  		("$@" 2>&1) | tap_prefix
>  		local ret=${PIPESTATUS[0]}
>  		count_total=$(( count_total + 1 ))
> -		if [ $ret -eq 0 ]; then
> +		# page_frag_test.ko returns 11(EAGAIN) when insmod'ing to avoid rmmod
> +		if [ $ret -eq 0 ] | [ $ret -eq 11 -a ${CATEGORY} == "page_frag" ]; then
>  			count_pass=$(( count_pass + 1 ))
>  			echo "[PASS]" | tap_prefix
>  			echo "ok ${count_total} ${test}" | tap_output
> @@ -453,6 +456,10 @@ CATEGORY="mkdirty" run_test ./mkdirty
>  
>  CATEGORY="mdwe" run_test ./mdwe_test
>  
> +CATEGORY="page_frag" run_test insmod ./page_frag/page_frag_test.ko
> +
> +CATEGORY="page_frag" run_test insmod ./page_frag/page_frag_test.ko test_alloc_len=12 test_align=1
> +
You are loading the test module. How will we verify if the test passed
or failed? There must be a way to mark the test passed or failed after
running it. You can definitely parse the dmesg to get results. But it
would be complex to do it. KUnit is way to go as all such tools are
already present there.

>  echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
>  echo "1..${count_total}" | tap_output
>  

-- 
BR,
Muhammad Usama Anjum


