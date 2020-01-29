Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DBF14D27B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2020 22:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2V2W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 16:28:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37872 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA2V2V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 16:28:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so460004plz.4
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2020 13:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6QHSV0epbJ5GjLnwh0+RSWrqsLLDJlBBjEbhEIImewk=;
        b=ENiOsZ0f46TX6ufRsYGjsJNC8xCpWbLhi4TIyRcHHUP+Ia4FhbXMIXnWxgTOibbyIY
         8S45r25tALWzmwgpFNbGezbFftN93GkVD4s+qgI8tz+915haHocfcpQAFQEmPcI7aVaj
         kCAZXT1Sxy98pIbdeLlzBTBF6SOrsilyw4s+Fc6lRzaGpSrf0WwbTlquO5FUJ+G1Ma0u
         e9TKZAC7JHJkc6Ua88CdqkK5DfKKLR7mJmLfKGJpNnboOFtnHexCda86j9FhClhQYEIT
         yuyR9rDmK72Zao5ti4A1Ts/Nc9i9md5i/3qGwjAW7jyQ1DW6D0Eh42o12gjW1kH7EDwi
         kAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6QHSV0epbJ5GjLnwh0+RSWrqsLLDJlBBjEbhEIImewk=;
        b=YwaliGg0EXJxcfWsmQnkmKLLFsidxI+firaz3GEJmvjKMxN7aIAzRRnmAb9LfdGjre
         XFsaOZwbbaEihGpt13177jRwC81qWE3iPf9CdT2OkKLznJeGkCHuBnBlFJO2xwRn9Yu6
         pc2Jghu2uNh/2x/pSYJfHUYLeNz0C6y0P9fWPDt6wkRxnhe3oeHVgrly/G2ArMShaTpU
         w9FsusdSAWEteMedSr6g8DkAnVyCsQ+OBG5oSWccs5wtLUfeJmfYQB+r8WMB6z/PoFOs
         bkfE6q8vPBTb6LiEukHYW3Ss5CbkRHitAPpPscpnCuD0Y900F7VSap0DGVvIHKWQTsiN
         s7EQ==
X-Gm-Message-State: APjAAAVL+iazZCfFm2Xw1Mh8BPr5+A52/opC/R0vcycKK8DFNjHBLBGI
        2cE3zSP9j29xz41ewt79bpVADw==
X-Google-Smtp-Source: APXvYqzskV3cOHpvwCbLWBb5kHNV1C8EooS3qoyWLKjCJ0sdJLvE03VvOltGzJUYy3hnunNZOHD3sQ==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr1413243plb.171.1580333300740;
        Wed, 29 Jan 2020 13:28:20 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e6sm3786414pfh.32.2020.01.29.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:28:20 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:28:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shakeelb@google.com, shuah@kernel.org,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
In-Reply-To: <20200115012651.228058-3-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001291323270.175731@chino.kir.corp.google.com>
References: <20200115012651.228058-1-almasrymina@google.com> <20200115012651.228058-3-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 14 Jan 2020, Mina Almasry wrote:

> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index dea6143aa0685..5491932ea5758 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -46,6 +46,16 @@ struct resv_map {
>  	long adds_in_progress;
>  	struct list_head region_cache;
>  	long region_cache_count;
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * On private mappings, the counter to uncharge reservations is stored
> +	 * here. If these fields are 0, then either the mapping is shared, or
> +	 * cgroup accounting is disabled for this resv_map.
> +	 */
> +	struct page_counter *reservation_counter;
> +	unsigned long pages_per_hpage;
> +	struct cgroup_subsys_state *css;
> +#endif
>  };
>  extern struct resv_map *resv_map_alloc(void);
>  void resv_map_release(struct kref *ref);
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index eab8a70d5bcb5..8c320accefe87 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -25,6 +25,33 @@ struct hugetlb_cgroup;
>  #define HUGETLB_CGROUP_MIN_ORDER	2
> 
>  #ifdef CONFIG_CGROUP_HUGETLB
> +enum hugetlb_memory_event {
> +	HUGETLB_MAX,
> +	HUGETLB_NR_MEMORY_EVENTS,
> +};
> +
> +struct hugetlb_cgroup {
> +	struct cgroup_subsys_state css;
> +
> +	/*
> +	 * the counter to account for hugepages from hugetlb.
> +	 */
> +	struct page_counter hugepage[HUGE_MAX_HSTATE];
> +
> +	/*
> +	 * the counter to account for hugepage reservations from hugetlb.
> +	 */
> +	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
> +
> +	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> +	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> +
> +	/* Handle for "hugetlb.events" */
> +	struct cgroup_file events_file[HUGE_MAX_HSTATE];
> +
> +	/* Handle for "hugetlb.events.local" */
> +	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> +};
> 
>  static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
>  							      bool reserved)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 62a4cf3db4090..f1b63946ee95c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -666,6 +666,17 @@ struct resv_map *resv_map_alloc(void)
>  	INIT_LIST_HEAD(&resv_map->regions);
> 
>  	resv_map->adds_in_progress = 0;
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * Initialize these to 0. On shared mappings, 0's here indicate these
> +	 * fields don't do cgroup accounting. On private mappings, these will be
> +	 * re-initialized to the proper values, to indicate that hugetlb cgroup
> +	 * reservations are to be un-charged from here.
> +	 */
> +	resv_map->reservation_counter = NULL;
> +	resv_map->pages_per_hpage = 0;
> +	resv_map->css = NULL;
> +#endif

Might be better to extract out a resv_map_init() that does the 
initialization when CONFIG_CGROUP_HUGETLB is enabled?  Could be used here 
as well as hugetlb_reserve_pages().

> 
>  	INIT_LIST_HEAD(&resv_map->region_cache);
>  	list_add(&rg->link, &resv_map->region_cache);
> @@ -3194,7 +3205,11 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
> 
>  	reserve = (end - start) - region_count(resv, start, end);
> 
> -	kref_put(&resv->refs, resv_map_release);
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
> +					(end - start) * resv->pages_per_hpage,
> +					resv->css);
> +#endif
> 
>  	if (reserve) {
>  		/*

Mike has given is Reviewed-by so likely not a big concern for the generic 
hugetlb code, but I was wondering if we can reduce the number of #ifdef's 
if we defined a CONFIG_CGROUP_HUGETLB helper to take the resv, end, and 
start?  If CONFIG_CGROUP_HUGETLB is defined, it converts into the above, 
otherwise it's a no-op and we don't run into any compile errors because we 
are accessing fields that don't exist without the option.

Otherwise looks good!

Acked-by: David Rientjes <rientjes@google.com>
