Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07F2139E82
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgANApo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 19:45:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35662 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgANApn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 19:45:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so5709353pfo.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=taoDDoIQd/KDhx/ME1q1/0HEQhaZ03k7OPfFEXTFTWI=;
        b=qdWq8+7ssthCT4ZwYEBV3D7z/AN+fBXHEEyXGCSncOju1fE9W4iIPkkwOOB5UtgY8R
         P5g56E8RpmjWzq7S/YNrb1PyvkpQTIFk77pfELIi9danh9A1eqh/tt3xxgcLolZpH6Yj
         kbkMI75NdT+jKVlH0Fzl1KGJzM2JlESa2RkHsXd41rBKUSakzpaY9MBuO+1zp5PiSdAV
         XP7HySQSrDXb4EXAzSTgAluzOF16em5odoZAJxkE2R+A0hIIQUsy9KroM+FNMjAOzw4B
         lzD6NMomNkQjnwsZZEStVKY65XRgCJ8sFGxxGHOCjuffQPQmOcYaqlkH/kE/oJd1j/XJ
         lHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=taoDDoIQd/KDhx/ME1q1/0HEQhaZ03k7OPfFEXTFTWI=;
        b=sNG9llEbRG7JKghXDIysH+SmVlxWpVatzcy4TlfdM0nYhPXLcmxoOuUO7AXhWWINr2
         8tu9wNFTVrJeStWLAPqCgMdcd9JTK2lMwBnfqrfUwGeOGbluNpo+L/AL28m0N2+a+A9t
         EHkoZ0yl4cbrxY6y3M9SJqgkuH3NAo2o11w2QUUp4fF9Hk6c8uca0VWytLIVbwgsaBvh
         WnxXGcNVgB0zjKwt7jqovwKX2mMTV3WZxP2C9s4jSErSrSPC0M2fKZrVcN+Vj1j2pLA+
         5QvDBSZwKlbWguFD9Vzl0E4wLilitfCi9ld6i1GLm9z+m+anUT6NuekFZxXkuNR0BM+7
         b5hQ==
X-Gm-Message-State: APjAAAXnCqtRZNMo3Q4EHo4JlCcSLzbOg7QoMmV4rDx8HkdB6TWpbrS6
        VaJPkcDNS1nrJvg0T/31Kiri/g==
X-Google-Smtp-Source: APXvYqzlieBjdsA5yjKF+61x1017s2/mWKVZrCIM3a4XhPJ4emBmTB8HB3LH5NMBxJPMyfDX4E1t7A==
X-Received: by 2002:a63:f643:: with SMTP id u3mr22700736pgj.291.1578962742431;
        Mon, 13 Jan 2020 16:45:42 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z19sm15034750pfn.49.2020.01.13.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:45:41 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:45:41 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001131624240.164268@chino.kir.corp.google.com>
References: <20191217231615.164161-1-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 17 Dec 2019, Mina Almasry wrote:

> These counters will track hugetlb reservations rather than hugetlb
> memory faulted in. This patch only adds the counter, following patches
> add the charging and uncharging of the counter.
> 
> This is patch 1 of an 8 patch series.
> 
> Problem:
> Currently tasks attempting to allocate more hugetlb memory than is available get
> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> However, if a task attempts to allocate hugetlb memory only more than its
> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> but will SIGBUS the task when it attempts to fault the memory in.
> 

I think it's subtle, but the use of the word "allocate" instead of using 
"reserve" might be confusing here.  Might want to reword it.

> We have developers interested in using hugetlb_cgroups, and they have expressed
> dissatisfaction regarding this behavior. We'd like to improve this
> behavior such that tasks violating the hugetlb_cgroup limits get an error on
> mmap/shmget time, rather than getting SIGBUS'd when they try to fault
> the excess memory in.
> 

I'm not sure the developers are interested in being restricted by 
hugetlb_cgroups :)  I think users get constrained by hugetlb_cgroup so the 
developers are interested in the failure more: do we want to SIGBUS at 
fault and not be allowed an opportunity to influence that (today) or do we 
want to fallback to non-hugetlbfs memory and just keep going (tomorrow, 
after your patchset).

> The underlying problem is that today's hugetlb_cgroup accounting happens
> at hugetlb memory *fault* time, rather than at *reservation* time.
> Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> the offending task gets SIGBUS'd.
> 
> Proposed Solution:
> A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
> counter has slightly different semantics than
> hugetlb.xMB.[limit|usage]_in_bytes:
> 

Is there a max_usage_in_bytes equivalent?  It's a page_counter so I assume 
it's easy to support.

I'll defer the naming to Mike here, "rsvd" seems to be the hugetlb way of 
saying "reserved".

> - While usage_in_bytes tracks all *faulted* hugetlb memory,
> reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
> hugetlb memory faulted in without a prior reservation.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than reservation_limit_in_bytes, the kernel will fail this
> reservation.
> 
> This proposal is implemented in this patch series, with tests to verify
> functionality and show the usage. We also added cgroup-v2 support to
> hugetlb_cgroup so that the new use cases can be extended to v2.
> 
> Alternatives considered:
> 1. A new cgroup, instead of only a new page_counter attached to
>    the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
>    duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
>    hugetlb_cgroup seemed cleaner as well.
> 
> 2. Instead of adding a new counter, we considered adding a sysctl that modifies
>    the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
>    reservation time rather than fault time. Adding a new page_counter seems
>    better as userspace could, if it wants, choose to enforce different cgroups
>    differently: one via limit_in_bytes, and another via
>    reservation_limit_in_bytes. This could be very useful if you're
>    transitioning how hugetlb memory is partitioned on your system one
>    cgroup at a time, for example. Also, someone may find usage for both
>    limit_in_bytes and reservation_limit_in_bytes concurrently, and this
>    approach gives them the option to do so.
> 
> Testing:
> - Added tests passing.
> - Used libhugetlbfs for regression testing.
> 
> [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Hillf Danton <hdanton@sina.com>
