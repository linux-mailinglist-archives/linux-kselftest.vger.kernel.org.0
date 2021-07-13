Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC483C6D9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jul 2021 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhGMJkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jul 2021 05:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234971AbhGMJkJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jul 2021 05:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626169039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPjG46riU65B1QbPgnQf9Ll1Hi0RwYxSyS6IyDNzynk=;
        b=f3r9ijr8DJz02LdfkjHLtNDuqc2C2molRazFX/gqJeiFniEWhhIBBWyVHrHn1dmLJsBkfk
        tTOYPvA6orCnSTRsnmMlcloHbDosMJGb3rZbFE73joLA1akoTI7KiWft4+oij1kwGdxDV+
        35r614WBjMJ2S11YLMZBtaCR6u00GDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-1DtBSnBoP8mwAYGDf5CcDA-1; Tue, 13 Jul 2021 05:37:18 -0400
X-MC-Unique: 1DtBSnBoP8mwAYGDf5CcDA-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so8381664wrs.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jul 2021 02:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPjG46riU65B1QbPgnQf9Ll1Hi0RwYxSyS6IyDNzynk=;
        b=CrK0H3PCpanXdP3pnTDvulzl+yFD4rHh2ccAtALcwKy8VcrDt6M3egEfwZw/szO1dN
         Q8sZbkLObk2ibjis1ViakSLEAIB9scALJMcwHgfKe7BDRZQuODbeemz1wgqh+3c6QXF5
         dhE061YB1E9BgiE4qNYnpAoGGriQ+CBhewey1AF+6lbdT0R7t/7O045PlmdIBN1+My2m
         3xQ0FHJNfapeBDy8vnynPK1JtzYXey5EWG6lmE29s7dfV3JEC824hFcgW7Bubo9Xt6Kb
         MuFs/4c6f+yCmlB29rv+aC4sC3oPXpUKNdeujK1tTLWrmYJCFWibMoYmNmxatIRGEBrP
         ypDw==
X-Gm-Message-State: AOAM531KofJ5YrfW2SFd0pg/OUMEZJSHaSg6X5gVQPIl4TRFIZeVIeGr
        2WoayAxM8pbCdBIsue9SYcK5pzmX3brIz8Hg3qpGonXoURBdHAIrRa8Xc6Iraky9bFL6DVge/r8
        efvF+FTHTvCfxXAAghFtlmZxrtopH
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr3929734wmo.40.1626169037012;
        Tue, 13 Jul 2021 02:37:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbTOQQ/tXwFM80Fmihut37444oYzS3AoVsCO+LfGrJql3dTCOZCpui4Ds4K3qO6lSJfrIFsw==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr3929719wmo.40.1626169036846;
        Tue, 13 Jul 2021 02:37:16 -0700 (PDT)
Received: from krava ([5.171.209.239])
        by smtp.gmail.com with ESMTPSA id b16sm17681318wrs.51.2021.07.13.02.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:37:16 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:37:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 1/1] tools: Rename bitmap_alloc() to bitmap_zalloc()
Message-ID: <YO1eyA2kOszG4xRU@krava>
References: <20210712140423.17836-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712140423.17836-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 12, 2021 at 05:04:23PM +0300, Andy Shevchenko wrote:
> Rename bitmap_alloc() to bitmap_zalloc() in tools to follow the bitmap API
> in the kernel.
> 
> No functional changes intended.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> v2: fixed commit message, Yury's email, added Ack (Yury)
>  tools/include/linux/bitmap.h                            | 4 ++--
>  tools/perf/bench/find-bit-bench.c                       | 2 +-
>  tools/perf/builtin-c2c.c                                | 6 +++---
>  tools/perf/builtin-record.c                             | 2 +-
>  tools/perf/tests/bitmap.c                               | 2 +-
>  tools/perf/tests/mem2node.c                             | 2 +-
>  tools/perf/util/affinity.c                              | 4 ++--
>  tools/perf/util/header.c                                | 4 ++--
>  tools/perf/util/metricgroup.c                           | 2 +-
>  tools/perf/util/mmap.c                                  | 4 ++--
>  tools/testing/selftests/kvm/dirty_log_perf_test.c       | 2 +-
>  tools/testing/selftests/kvm/dirty_log_test.c            | 4 ++--
>  tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c | 2 +-
>  13 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 9d959bc24859..95611df1d26e 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -111,10 +111,10 @@ static inline int test_and_clear_bit(int nr, unsigned long *addr)
>  }
>  
>  /**
> - * bitmap_alloc - Allocate bitmap
> + * bitmap_zalloc - Allocate bitmap
>   * @nbits: Number of bits
>   */
> -static inline unsigned long *bitmap_alloc(int nbits)
> +static inline unsigned long *bitmap_zalloc(int nbits)
>  {
>  	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
>  }
> diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> index 73b5bcc5946a..22b5cfe97023 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -54,7 +54,7 @@ static bool asm_test_bit(long nr, const unsigned long *addr)
>  
>  static int do_for_each_set_bit(unsigned int num_bits)
>  {
> -	unsigned long *to_test = bitmap_alloc(num_bits);
> +	unsigned long *to_test = bitmap_zalloc(num_bits);
>  	struct timeval start, end, diff;
>  	u64 runtime_us;
>  	struct stats fb_time_stats, tb_time_stats;
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 6dea37f141b2..c34d77bee4ef 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -139,11 +139,11 @@ static void *c2c_he_zalloc(size_t size)
>  	if (!c2c_he)
>  		return NULL;
>  
> -	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
> +	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
>  	if (!c2c_he->cpuset)
>  		return NULL;
>  
> -	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
> +	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
>  	if (!c2c_he->nodeset)
>  		return NULL;
>  
> @@ -2047,7 +2047,7 @@ static int setup_nodes(struct perf_session *session)
>  		struct perf_cpu_map *map = n[node].map;
>  		unsigned long *set;
>  
> -		set = bitmap_alloc(c2c.cpus_cnt);
> +		set = bitmap_zalloc(c2c.cpus_cnt);
>  		if (!set)
>  			return -ENOMEM;
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 671a21c9ee4d..f1b30ac094cb 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2786,7 +2786,7 @@ int cmd_record(int argc, const char **argv)
>  
>  	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
>  		rec->affinity_mask.nbits = cpu__max_cpu();
> -		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
> +		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
>  		if (!rec->affinity_mask.bits) {
>  			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
>  			err = -ENOMEM;
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 96c137360918..12b805efdca0 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -14,7 +14,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	unsigned long *bm = NULL;
>  	int i;
>  
> -	bm = bitmap_alloc(nbits);
> +	bm = bitmap_zalloc(nbits);
>  
>  	if (map && bm) {
>  		for (i = 0; i < map->nr; i++)
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index a258bd51f1a4..e4d0d58b97f8 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -27,7 +27,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	unsigned long *bm = NULL;
>  	int i;
>  
> -	bm = bitmap_alloc(nbits);
> +	bm = bitmap_zalloc(nbits);
>  
>  	if (map && bm) {
>  		for (i = 0; i < map->nr; i++) {
> diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
> index a5e31f826828..7b12bd7a3080 100644
> --- a/tools/perf/util/affinity.c
> +++ b/tools/perf/util/affinity.c
> @@ -25,11 +25,11 @@ int affinity__setup(struct affinity *a)
>  {
>  	int cpu_set_size = get_cpu_set_size();
>  
> -	a->orig_cpus = bitmap_alloc(cpu_set_size * 8);
> +	a->orig_cpus = bitmap_zalloc(cpu_set_size * 8);
>  	if (!a->orig_cpus)
>  		return -1;
>  	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
> -	a->sched_cpus = bitmap_alloc(cpu_set_size * 8);
> +	a->sched_cpus = bitmap_zalloc(cpu_set_size * 8);
>  	if (!a->sched_cpus) {
>  		zfree(&a->orig_cpus);
>  		return -1;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 44249027507a..563dec72adeb 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -278,7 +278,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
>  	if (ret)
>  		return ret;
>  
> -	set = bitmap_alloc(size);
> +	set = bitmap_zalloc(size);
>  	if (!set)
>  		return -ENOMEM;
>  
> @@ -1294,7 +1294,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
>  
>  	size++;
>  
> -	n->set = bitmap_alloc(size);
> +	n->set = bitmap_zalloc(size);
>  	if (!n->set) {
>  		closedir(dir);
>  		return -ENOMEM;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 99d047c5ead0..29b747ac31c1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -313,7 +313,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  	struct evsel *evsel, *tmp;
>  	unsigned long *evlist_used;
>  
> -	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
> +	evlist_used = bitmap_zalloc(perf_evlist->core.nr_entries);
>  	if (!evlist_used)
>  		return -ENOMEM;
>  
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..512dc8b9c168 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -106,7 +106,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
>  		data = map->aio.data[idx];
>  		mmap_len = mmap__mmap_len(map);
>  		node_index = cpu__get_node(cpu);
> -		node_mask = bitmap_alloc(node_index + 1);
> +		node_mask = bitmap_zalloc(node_index + 1);
>  		if (!node_mask) {
>  			pr_err("Failed to allocate node mask for mbind: error %m\n");
>  			return -1;
> @@ -258,7 +258,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
>  static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>  {
>  	map->affinity_mask.nbits = cpu__max_cpu();
> -	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
> +	map->affinity_mask.bits = bitmap_zalloc(map->affinity_mask.nbits);
>  	if (!map->affinity_mask.bits)
>  		return -1;
>  
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index 04a2641261be..fbf0c2c1fbc9 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -121,7 +121,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm_get_page_shift(vm);
>  	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
>  	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
> -	bmap = bitmap_alloc(host_num_pages);
> +	bmap = bitmap_zalloc(host_num_pages);
>  
>  	if (dirty_log_manual_caps) {
>  		cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 5fe0140e407e..792c60e1b17d 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -749,8 +749,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  
>  	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
>  
> -	bmap = bitmap_alloc(host_num_pages);
> -	host_bmap_track = bitmap_alloc(host_num_pages);
> +	bmap = bitmap_zalloc(host_num_pages);
> +	host_bmap_track = bitmap_zalloc(host_num_pages);
>  
>  	/* Add an extra memory slot for testing dirty logging */
>  	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> index 06a64980a5d2..68f26a8b4f42 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> @@ -111,7 +111,7 @@ int main(int argc, char *argv[])
>  	nested_map(vmx, vm, NESTED_TEST_MEM1, GUEST_TEST_MEM, 4096);
>  	nested_map(vmx, vm, NESTED_TEST_MEM2, GUEST_TEST_MEM, 4096);
>  
> -	bmap = bitmap_alloc(TEST_MEM_PAGES);
> +	bmap = bitmap_zalloc(TEST_MEM_PAGES);
>  	host_test_mem = addr_gpa2hva(vm, GUEST_TEST_MEM);
>  
>  	while (!done) {
> -- 
> 2.30.2
> 

