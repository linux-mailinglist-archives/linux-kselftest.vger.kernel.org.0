Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7F3ACDE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhFROwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 10:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234698AbhFROwh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 10:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624027827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbPbuj0msVDGWFUsKqeCrFUb5LMoYgYB88VJeRxprBs=;
        b=CCYulatqXIF7UN47eDnR6yJ8xEJ7DfrOvzoZuPsTwJrgIiq5ldhbQ3NzSiIkQjbyaHgwCj
        6RQNfCqzZa12PyA6uxfFgzMeVWNn9W7WNYqW24JxY8cLx+T1//Av3L1CF6w4BcB0D+1EVS
        b1mzU/U9aDI6nkZ7SuemWjw7BnudFcI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-qALXamKVOvySTuUc1YbMEQ-1; Fri, 18 Jun 2021 10:50:26 -0400
X-MC-Unique: qALXamKVOvySTuUc1YbMEQ-1
Received: by mail-ed1-f72.google.com with SMTP id j3-20020aa7c3430000b0290393f7aad447so1646993edr.18
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 07:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbPbuj0msVDGWFUsKqeCrFUb5LMoYgYB88VJeRxprBs=;
        b=SMgWpv+7wMBJZQP+i3GWOf/ASuqBMtzogc7/CWavMYTKg/zMM42m/k57CQC7tu9Uaw
         RbzCuWUpbwIhKaDHmzXkCmEXLRZgWJ5UA2inojrStoszuosMT152k2Y9I+P7HO5x64PE
         V5ON588+RFUE5Xym2CjVJXiW/E9Q6Dd+f/X11Q16ThzHgFssxp5FAVlbmNLUhtp1rtSO
         Qo4ejuvfleO968xLCz+mmvd0YrgEJc9hRu3/Q2L0mP4iuKgZns6ygMn+085HlaFF+/4I
         rivQCxHy4b8/x4FyZWHOiPr8G/1bHRa8cN/YPTfzcXBcQVGu8yHMqsO63v8KccrB3kmy
         ja0g==
X-Gm-Message-State: AOAM531qvN/t3XwxOkttjQ7pIwj/varTg0kSUUWtRB6S+mpTRdJfpwIE
        ABsRPP++yy5dPwf1PU6/XBSqufj0grQrb6LtzurcfJPGCaxxaS/waTPp2twnDLzps0ChJ4g+3YP
        fbGYwK9ZBXjO8alfEFb+G9UsXf+mK
X-Received: by 2002:a17:906:6d59:: with SMTP id a25mr3271314ejt.83.1624027825310;
        Fri, 18 Jun 2021 07:50:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGMqnaIUeLgzXdL4MB+nq3qWIIQQpHpYHpBobQjDwJLtjovX4eLv3MrjB5uzX9trFvePwGEg==
X-Received: by 2002:a17:906:6d59:: with SMTP id a25mr3271295ejt.83.1624027825049;
        Fri, 18 Jun 2021 07:50:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i10sm1112727eja.3.2021.06.18.07.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:50:24 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] tools: Rename bitmap_alloc() to bitmap_zalloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>
References: <20210618143854.62967-1-andriy.shevchenko@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f159d297-7eed-e054-ae70-e593a42685b5@redhat.com>
Date:   Fri, 18 Jun 2021 16:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618143854.62967-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/06/21 16:38, Andy Shevchenko wrote:
> Rename bitmap_alloc() to bitmap_zalloc() in tools to follow new coming
> bitmap API extension in kernel.
> 
> No functional changes intended.
> 
> Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   tools/include/linux/bitmap.h                            | 4 ++--
>   tools/perf/bench/find-bit-bench.c                       | 2 +-
>   tools/perf/builtin-c2c.c                                | 6 +++---
>   tools/perf/builtin-record.c                             | 2 +-
>   tools/perf/tests/bitmap.c                               | 2 +-
>   tools/perf/tests/mem2node.c                             | 2 +-
>   tools/perf/util/affinity.c                              | 4 ++--
>   tools/perf/util/header.c                                | 4 ++--
>   tools/perf/util/metricgroup.c                           | 2 +-
>   tools/perf/util/mmap.c                                  | 4 ++--
>   tools/testing/selftests/kvm/dirty_log_perf_test.c       | 2 +-
>   tools/testing/selftests/kvm/dirty_log_test.c            | 4 ++--
>   tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c | 2 +-
>   13 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 330dbf7509cc..7eae64eb5c80 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -109,10 +109,10 @@ static inline int test_and_clear_bit(int nr, unsigned long *addr)
>   }
>   
>   /**
> - * bitmap_alloc - Allocate bitmap
> + * bitmap_zalloc - Allocate bitmap
>    * @nbits: Number of bits
>    */
> -static inline unsigned long *bitmap_alloc(int nbits)
> +static inline unsigned long *bitmap_zalloc(int nbits)
>   {
>   	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
>   }
> diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> index 73b5bcc5946a..22b5cfe97023 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -54,7 +54,7 @@ static bool asm_test_bit(long nr, const unsigned long *addr)
>   
>   static int do_for_each_set_bit(unsigned int num_bits)
>   {
> -	unsigned long *to_test = bitmap_alloc(num_bits);
> +	unsigned long *to_test = bitmap_zalloc(num_bits);
>   	struct timeval start, end, diff;
>   	u64 runtime_us;
>   	struct stats fb_time_stats, tb_time_stats;
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e3b9d63077ef..a17726ff85a9 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -137,11 +137,11 @@ static void *c2c_he_zalloc(size_t size)
>   	if (!c2c_he)
>   		return NULL;
>   
> -	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
> +	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
>   	if (!c2c_he->cpuset)
>   		return NULL;
>   
> -	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
> +	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
>   	if (!c2c_he->nodeset)
>   		return NULL;
>   
> @@ -2045,7 +2045,7 @@ static int setup_nodes(struct perf_session *session)
>   		struct perf_cpu_map *map = n[node].map;
>   		unsigned long *set;
>   
> -		set = bitmap_alloc(c2c.cpus_cnt);
> +		set = bitmap_zalloc(c2c.cpus_cnt);
>   		if (!set)
>   			return -ENOMEM;
>   
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 84803abeb942..978b6bbd06e4 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2766,7 +2766,7 @@ int cmd_record(int argc, const char **argv)
>   
>   	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
>   		rec->affinity_mask.nbits = cpu__max_cpu();
> -		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
> +		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
>   		if (!rec->affinity_mask.bits) {
>   			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
>   			err = -ENOMEM;
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 96c137360918..12b805efdca0 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -14,7 +14,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>   	unsigned long *bm = NULL;
>   	int i;
>   
> -	bm = bitmap_alloc(nbits);
> +	bm = bitmap_zalloc(nbits);
>   
>   	if (map && bm) {
>   		for (i = 0; i < map->nr; i++)
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index a258bd51f1a4..e4d0d58b97f8 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -27,7 +27,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>   	unsigned long *bm = NULL;
>   	int i;
>   
> -	bm = bitmap_alloc(nbits);
> +	bm = bitmap_zalloc(nbits);
>   
>   	if (map && bm) {
>   		for (i = 0; i < map->nr; i++) {
> diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
> index a5e31f826828..7b12bd7a3080 100644
> --- a/tools/perf/util/affinity.c
> +++ b/tools/perf/util/affinity.c
> @@ -25,11 +25,11 @@ int affinity__setup(struct affinity *a)
>   {
>   	int cpu_set_size = get_cpu_set_size();
>   
> -	a->orig_cpus = bitmap_alloc(cpu_set_size * 8);
> +	a->orig_cpus = bitmap_zalloc(cpu_set_size * 8);
>   	if (!a->orig_cpus)
>   		return -1;
>   	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
> -	a->sched_cpus = bitmap_alloc(cpu_set_size * 8);
> +	a->sched_cpus = bitmap_zalloc(cpu_set_size * 8);
>   	if (!a->sched_cpus) {
>   		zfree(&a->orig_cpus);
>   		return -1;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index aa1e42518d37..c67c03dd3db2 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -277,7 +277,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
>   	if (ret)
>   		return ret;
>   
> -	set = bitmap_alloc(size);
> +	set = bitmap_zalloc(size);
>   	if (!set)
>   		return -ENOMEM;
>   
> @@ -1259,7 +1259,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
>   
>   	size++;
>   
> -	n->set = bitmap_alloc(size);
> +	n->set = bitmap_zalloc(size);
>   	if (!n->set) {
>   		closedir(dir);
>   		return -ENOMEM;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8336dd8e8098..f24c6998d26c 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -313,7 +313,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>   	struct evsel *evsel, *tmp;
>   	unsigned long *evlist_used;
>   
> -	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
> +	evlist_used = bitmap_zalloc(perf_evlist->core.nr_entries);
>   	if (!evlist_used)
>   		return -ENOMEM;
>   
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..512dc8b9c168 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -106,7 +106,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
>   		data = map->aio.data[idx];
>   		mmap_len = mmap__mmap_len(map);
>   		node_index = cpu__get_node(cpu);
> -		node_mask = bitmap_alloc(node_index + 1);
> +		node_mask = bitmap_zalloc(node_index + 1);
>   		if (!node_mask) {
>   			pr_err("Failed to allocate node mask for mbind: error %m\n");
>   			return -1;
> @@ -258,7 +258,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
>   static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>   {
>   	map->affinity_mask.nbits = cpu__max_cpu();
> -	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
> +	map->affinity_mask.bits = bitmap_zalloc(map->affinity_mask.nbits);
>   	if (!map->affinity_mask.bits)
>   		return -1;
>   
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index 04a2641261be..fbf0c2c1fbc9 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -121,7 +121,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm_get_page_shift(vm);
>   	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
>   	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
> -	bmap = bitmap_alloc(host_num_pages);
> +	bmap = bitmap_zalloc(host_num_pages);
>   
>   	if (dirty_log_manual_caps) {
>   		cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 81edbd23d371..ef641b0ff125 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -750,8 +750,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   
>   	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
>   
> -	bmap = bitmap_alloc(host_num_pages);
> -	host_bmap_track = bitmap_alloc(host_num_pages);
> +	bmap = bitmap_zalloc(host_num_pages);
> +	host_bmap_track = bitmap_zalloc(host_num_pages);
>   
>   	/* Add an extra memory slot for testing dirty logging */
>   	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> index 537de1068554..a2f1bab6c234 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> @@ -111,7 +111,7 @@ int main(int argc, char *argv[])
>   	nested_map(vmx, vm, NESTED_TEST_MEM1, GUEST_TEST_MEM, 4096, 0);
>   	nested_map(vmx, vm, NESTED_TEST_MEM2, GUEST_TEST_MEM, 4096, 0);
>   
> -	bmap = bitmap_alloc(TEST_MEM_PAGES);
> +	bmap = bitmap_zalloc(TEST_MEM_PAGES);
>   	host_test_mem = addr_gpa2hva(vm, GUEST_TEST_MEM);
>   
>   	while (!done) {
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

