Return-Path: <linux-kselftest+bounces-1131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C3804D39
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 10:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771751F212AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643B3D98E;
	Tue,  5 Dec 2023 09:07:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9DD3;
	Tue,  5 Dec 2023 01:07:45 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6258222034;
	Tue,  5 Dec 2023 09:07:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4648D136CF;
	Tue,  5 Dec 2023 09:07:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 78bYDl7obmUuSQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 05 Dec 2023 09:07:42 +0000
Date: Tue, 5 Dec 2023 10:07:41 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZW7oXalrpQWdWZNJ@tiehlicka>
References: <20231204194156.2411672-1-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204194156.2411672-1-davidf@vimeo.com>
X-Spamd-Bar: ++++++++++++++++++
X-Spam-Score: 18.31
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 6258222034
X-Spamd-Result: default: False [18.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.19)[-0.965];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Mon 04-12-23 14:41:56, David Finkel wrote:
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms.
> 
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
> 
> This change copies the cgroup v1 behavior so any write to the
> memory.peak and memory.swap.peak pseudo-files reset the high watermark
> to the current usage.
> 
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.

I do not understand the OOM-killer reference here but I do understand
that your worker reuses a cgroup and you want a peak memory consumption
of a single run to better profile/configure the memcg configuration for
the specific worker type. Correct?

> Signed-off-by: David Finkel <davidf@vimeo.com>

Makes sense to me
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  Documentation/admin-guide/cgroup-v2.rst       | 20 +++---
>  mm/memcontrol.c                               | 23 ++++++
>  .../selftests/cgroup/test_memcontrol.c        | 72 ++++++++++++++++---
>  3 files changed, 99 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3f85254f3cef..95af0628dc44 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1305,11 +1305,13 @@ PAGE_SIZE multiple when read back.
>  	reclaim induced by memory.reclaim.
>  
>    memory.peak
> -	A read-only single value file which exists on non-root
> -	cgroups.
> +	A read-write single value file which exists on non-root cgroups.
> +
> +	The max memory usage recorded for the cgroup and its descendants since
> +	either the creation of the cgroup or the most recent reset.
>  
> -	The max memory usage recorded for the cgroup and its
> -	descendants since the creation of the cgroup.
> +	Any non-empty write to this file resets it to the current memory usage.
> +	All content written is completely ignored.
>  
>    memory.oom.group
>  	A read-write single value file which exists on non-root
> @@ -1626,11 +1628,13 @@ PAGE_SIZE multiple when read back.
>  	Healthy workloads are not expected to reach this limit.
>  
>    memory.swap.peak
> -	A read-only single value file which exists on non-root
> -	cgroups.
> +	A read-write single value file which exists on non-root cgroups.
> +
> +	The max swap usage recorded for the cgroup and its descendants since
> +	the creation of the cgroup or the most recent reset.
>  
> -	The max swap usage recorded for the cgroup and its
> -	descendants since the creation of the cgroup.
> +	Any non-empty write to this file resets it to the current swap usage.
> +	All content written is completely ignored.
>  
>    memory.swap.max
>  	A read-write single value file which exists on non-root
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1c1061df9cd1..b04af158922d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -25,6 +25,7 @@
>   * Copyright (C) 2020 Alibaba, Inc, Alex Shi
>   */
>  
> +#include <linux/cgroup-defs.h>
>  #include <linux/page_counter.h>
>  #include <linux/memcontrol.h>
>  #include <linux/cgroup.h>
> @@ -6635,6 +6636,16 @@ static u64 memory_peak_read(struct cgroup_subsys_state *css,
>  	return (u64)memcg->memory.watermark * PAGE_SIZE;
>  }
>  
> +static ssize_t memory_peak_write(struct kernfs_open_file *of,
> +				 char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +
> +	page_counter_reset_watermark(&memcg->memory);
> +
> +	return nbytes;
> +}
> +
>  static int memory_min_show(struct seq_file *m, void *v)
>  {
>  	return seq_puts_memcg_tunable(m,
> @@ -6947,6 +6958,7 @@ static struct cftype memory_files[] = {
>  		.name = "peak",
>  		.flags = CFTYPE_NOT_ON_ROOT,
>  		.read_u64 = memory_peak_read,
> +		.write = memory_peak_write,
>  	},
>  	{
>  		.name = "min",
> @@ -7917,6 +7929,16 @@ static u64 swap_peak_read(struct cgroup_subsys_state *css,
>  	return (u64)memcg->swap.watermark * PAGE_SIZE;
>  }
>  
> +static ssize_t swap_peak_write(struct kernfs_open_file *of,
> +				 char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +
> +	page_counter_reset_watermark(&memcg->swap);
> +
> +	return nbytes;
> +}
> +
>  static int swap_high_show(struct seq_file *m, void *v)
>  {
>  	return seq_puts_memcg_tunable(m,
> @@ -7999,6 +8021,7 @@ static struct cftype swap_files[] = {
>  		.name = "swap.peak",
>  		.flags = CFTYPE_NOT_ON_ROOT,
>  		.read_u64 = swap_peak_read,
> +		.write = swap_peak_write,
>  	},
>  	{
>  		.name = "swap.events",
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index c7c9572003a8..0326c317f1f2 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -161,12 +161,12 @@ static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
>  /*
>   * This test create a memory cgroup, allocates
>   * some anonymous memory and some pagecache
> - * and check memory.current and some memory.stat values.
> + * and checks memory.current, memory.peak, and some memory.stat values.
>   */
> -static int test_memcg_current(const char *root)
> +static int test_memcg_current_peak(const char *root)
>  {
>  	int ret = KSFT_FAIL;
> -	long current;
> +	long current, peak, peak_reset;
>  	char *memcg;
>  
>  	memcg = cg_name(root, "memcg_test");
> @@ -180,12 +180,32 @@ static int test_memcg_current(const char *root)
>  	if (current != 0)
>  		goto cleanup;
>  
> +	peak = cg_read_long(memcg, "memory.peak");
> +	if (peak != 0)
> +		goto cleanup;
> +
>  	if (cg_run(memcg, alloc_anon_50M_check, NULL))
>  		goto cleanup;
>  
> +	peak = cg_read_long(memcg, "memory.peak");
> +	if (peak < MB(50))
> +		goto cleanup;
> +
> +	peak_reset = cg_write(memcg, "memory.peak", "\n");
> +	if (peak_reset != 0)
> +		goto cleanup;
> +
> +	peak = cg_read_long(memcg, "memory.peak");
> +	if (peak > MB(30))
> +		goto cleanup;
> +
>  	if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
>  		goto cleanup;
>  
> +	peak = cg_read_long(memcg, "memory.peak");
> +	if (peak < MB(50))
> +		goto cleanup;
> +
>  	ret = KSFT_PASS;
>  
>  cleanup:
> @@ -815,13 +835,14 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
>  
>  /*
>   * This test checks that memory.swap.max limits the amount of
> - * anonymous memory which can be swapped out.
> + * anonymous memory which can be swapped out. Additionally, it verifies that
> + * memory.swap.peak reflects the high watermark and can be reset.
>   */
> -static int test_memcg_swap_max(const char *root)
> +static int test_memcg_swap_max_peak(const char *root)
>  {
>  	int ret = KSFT_FAIL;
>  	char *memcg;
> -	long max;
> +	long max, peak;
>  
>  	if (!is_swap_enabled())
>  		return KSFT_SKIP;
> @@ -838,6 +859,12 @@ static int test_memcg_swap_max(const char *root)
>  		goto cleanup;
>  	}
>  
> +	if (cg_read_long(memcg, "memory.swap.peak"))
> +		goto cleanup;
> +
> +	if (cg_read_long(memcg, "memory.peak"))
> +		goto cleanup;
> +
>  	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
>  		goto cleanup;
>  
> @@ -860,6 +887,27 @@ static int test_memcg_swap_max(const char *root)
>  	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
>  		goto cleanup;
>  
> +	peak = cg_read_long(memcg, "memory.peak");
> +	if (peak < MB(29))
> +		goto cleanup;
> +
> +	peak = cg_read_long(memcg, "memory.swap.peak");
> +	if (peak < MB(29))
> +		goto cleanup;
> +
> +	if (cg_write(memcg, "memory.swap.peak", "\n"))
> +		goto cleanup;
> +
> +	if (cg_read_long(memcg, "memory.swap.peak") > MB(10))
> +		goto cleanup;
> +
> +
> +	if (cg_write(memcg, "memory.peak", "\n"))
> +		goto cleanup;
> +
> +	if (cg_read_long(memcg, "memory.peak"))
> +		goto cleanup;
> +
>  	if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
>  		goto cleanup;
>  
> @@ -867,6 +915,14 @@ static int test_memcg_swap_max(const char *root)
>  	if (max <= 0)
>  		goto cleanup;
>  
> +	peak = cg_read_long(memcg, "memory.peak");
> +	if (peak < MB(29))
> +		goto cleanup;
> +
> +	peak = cg_read_long(memcg, "memory.swap.peak");
> +	if (peak < MB(19))
> +		goto cleanup;
> +
>  	ret = KSFT_PASS;
>  
>  cleanup:
> @@ -1293,7 +1349,7 @@ struct memcg_test {
>  	const char *name;
>  } tests[] = {
>  	T(test_memcg_subtree_control),
> -	T(test_memcg_current),
> +	T(test_memcg_current_peak),
>  	T(test_memcg_min),
>  	T(test_memcg_low),
>  	T(test_memcg_high),
> @@ -1301,7 +1357,7 @@ struct memcg_test {
>  	T(test_memcg_max),
>  	T(test_memcg_reclaim),
>  	T(test_memcg_oom_events),
> -	T(test_memcg_swap_max),
> +	T(test_memcg_swap_max_peak),
>  	T(test_memcg_sock),
>  	T(test_memcg_oom_group_leaf_events),
>  	T(test_memcg_oom_group_parent_events),
> -- 
> 2.39.2

-- 
Michal Hocko
SUSE Labs

