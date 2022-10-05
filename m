Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573725F5B56
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 23:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJEVAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 17:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJEVAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 17:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321580F6B
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665003636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxjNtwOtJYr7Ap1Thb18UVXDvZENMtx4lxtXJfDuLn8=;
        b=eT/5nypuPOomML8eZjpp44Wr7DcIVCd/9dK6375Kyevndf/0Uf1e4nJer8ynHn6lO9DlB5
        DQ9h4SDfL/OIsm+mJH/GVrpAdBJzNnOVNQvFvMm4VU7QdLgSBIXPDLzl7dllGY6UTN3XGm
        sYWVc1oOY2WRb7oxLcL1qf00WpNbK+Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-hAnZahrTPzKa_pxZ4QTpTA-1; Wed, 05 Oct 2022 17:00:35 -0400
X-MC-Unique: hAnZahrTPzKa_pxZ4QTpTA-1
Received: by mail-qk1-f197.google.com with SMTP id m16-20020a05620a291000b006e2b66fd93fso2284039qkp.12
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 14:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bxjNtwOtJYr7Ap1Thb18UVXDvZENMtx4lxtXJfDuLn8=;
        b=oTlXQXOZ23bvXjFBlkwspjlXT8J4ANxjQ55xjdt96xhINNMAmMKW1srxlp7SPqyDPj
         QzMNvOQJr74lU1Pl8VOUfQc6VSV/AXEpH1V7IrGl8U9OLxXI6H/mbgdsCfR7DIcBQoIJ
         3Ict9UVrcLK7YU57qJaas+koaSE01CSHsD7MTJwl39glewy3BSO0PMUPNjShCjFkOsPt
         K+AqU+h7CDEFCuUdko5srkwBbqOdrO4cyRVrp+iTBF+dOw1ndmCwzQHGlYtX0XJ+rpym
         PyXxJCq/QY0ky8jLBdHA/BrWzFjr7AF+nLsUB4pxmE7JEgZctz9uhj6fIVUbSXXiMXh3
         p8+Q==
X-Gm-Message-State: ACrzQf2I4GSSukdVS3f7qiXvPc4UoqwqI0b6EsG2MZSIY8Qibis5WWLJ
        6sfc/xFu/uyCrIJMFofo+08wN7eQdRAvko3pTu5IWED21RpLOvvwqZCU3rMvh3mVyFR1dAxPIg3
        MnTkhvSbzemjcUHBarV/Ltztha+xX
X-Received: by 2002:a05:620a:22db:b0:6ce:4e82:5cc7 with SMTP id o27-20020a05620a22db00b006ce4e825cc7mr1023708qki.29.1665003634459;
        Wed, 05 Oct 2022 14:00:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6WRvK3gEOhihmoFanKnOif3yzMLKCR7MYDIPihW7KP3HSKBLvonz45HUyg9WkbjDcr0jqQog==
X-Received: by 2002:a05:620a:22db:b0:6ce:4e82:5cc7 with SMTP id o27-20020a05620a22db00b006ce4e825cc7mr1023685qki.29.1665003634222;
        Wed, 05 Oct 2022 14:00:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i25-20020ac84899000000b0039351b26714sm876918qtq.7.2022.10.05.14.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 14:00:33 -0700 (PDT)
Date:   Wed, 5 Oct 2022 17:00:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 6/7] mm/ksm: convert break_ksm() to use
 walk_page_range_vma()
Message-ID: <Yz3wcDZPFvKBmnet@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-7-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:30PM +0200, David Hildenbrand wrote:
> FOLL_MIGRATION exists only for the purpose of break_ksm(), and
> actually, there is not even the need to wait for the migration to
> finish, we only want to know if we're dealing with a KSM page.
> 
> Using follow_page() just to identify a KSM page overcomplicates GUP
> code. Let's use walk_page_range_vma() instead, because we don't actually
> care about the page itself, we only need to know a single property --
> no need to even grab a reference on the page.
> 
> In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test unmerge
> performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in
> a performance degradation of ~4% (old: ~5010 MiB/s, new: ~4800 MiB/s).
> I don't think we particularly care for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

[...]

> +int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
> +			struct mm_walk *walk)
> +{
> +	/* We only care about page tables to walk to a single base page. */
> +	if (pud_leaf(*pud) || !pud_present(*pud))
> +		return 1;
> +	return 0;
> +}

Is this needed?  I thought the pgtable walker handlers this already.

[...]

>  static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	struct page *page;
>  	vm_fault_t ret = 0;
>  
> +	if (WARN_ON_ONCE(!IS_ALIGNED(addr, PAGE_SIZE)))
> +		return -EINVAL;
> +
>  	do {
>  		bool ksm_page = false;
>  
>  		cond_resched();
> -		page = follow_page(vma, addr,
> -				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> -		if (IS_ERR_OR_NULL(page))
> -			break;
> -		if (PageKsm(page))
> -			ksm_page = true;
> -		put_page(page);
> +		ret = walk_page_range_vma(vma, addr, addr + PAGE_SIZE,
> +					  &break_ksm_ops, &ksm_page);
> +		if (WARN_ON_ONCE(ret < 0))
> +			return ret;

I'm not sure this would be worth it, especially with a 4% degrade.  The
next patch will be able to bring 50- LOC, but this patch does 60+ anyway,
based on another new helper just introduced...

I just don't see whether there's strong enough reason to do so to drop
FOLL_MIGRATE.  It's different to the previous VM_FAULT_WRITE refactor
because of the unshare approach was much of a good reasoning to me.

Perhaps I missed something?

-- 
Peter Xu

