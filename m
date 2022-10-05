Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE75F5B28
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJEUmQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEUmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9461729
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665002532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHrx4ZNF6Q9JTs4QbO6KR9zUQ7s8TQSOd7bK/WolviI=;
        b=jWxmja4FpWO3E0zc9cu2NK4ZOlk1QDHxCKPCap54yuqB0XvEAtCuPQIGaDEOc66T0kwov6
        +kPk2D49VDwMyWVdXIN+xyxPMLJV7nqD/kWN7QtEI1SJhmBo1JOWtUk0cbL/IrvXK1hNVf
        AF8LEQ+ZfduWk08oGFkY1ji2HFtX7jA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-JbDvSvaJOMKTSRQPtecpTA-1; Wed, 05 Oct 2022 16:42:11 -0400
X-MC-Unique: JbDvSvaJOMKTSRQPtecpTA-1
Received: by mail-qv1-f71.google.com with SMTP id q6-20020a0cf5c6000000b004b1999f94bcso5026809qvm.15
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KHrx4ZNF6Q9JTs4QbO6KR9zUQ7s8TQSOd7bK/WolviI=;
        b=qtrvV4fHEPxAzh5rf8B8keWThOEZ3C9vD5WA1BN2vSSnht+QuE/9UnqT1sMB/xcx8C
         SX3hmUG/db1lGEDvNFh49g2XFH+sPpYqONg/hPbT13p90eFooFn/Mv/95hjNZoDrURtb
         cGJPIxHcYkJ9d8Q49JeXZoeFNvZ6kt/C7/ajX77hgJIt+Mr+d8OIrUF126q2oLz1Zh1q
         ihsUWt7p1eDKdHzVarrzUDM+WlJ5TuFTP1ku4ITAryEBCptMqgavy/pNw/A3gNzVctlr
         qjMtl9WwcYdeyd7S1pKAqSBp8p7d6MJmzgYB2DOIgYUcaIui8KlK5IaD2nvzO4WDJvmS
         0tdg==
X-Gm-Message-State: ACrzQf0K15GB1gzh+icctuLVgFBajz6oj/ZUery9unCNXjBQF/bG/COR
        +x3sDLG0uy75vCM7zYy5TLVXUZK2cNrSaDRtaSHe4UGswmBR6SJFO85aEAOqm7pNEJbYCe3pFYx
        IbNBJjFZOUAkG+Lp9nvSxhD9A44OT
X-Received: by 2002:a05:622a:1248:b0:35b:b5fa:5e25 with SMTP id z8-20020a05622a124800b0035bb5fa5e25mr1041836qtx.215.1665002531453;
        Wed, 05 Oct 2022 13:42:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VIUcXTqhgXvpzJkX75ZmoU7Lo+ixxEfdl/3WdVWfbQmY8WVE4OWUXjeUt4C2zlipy5Q6F5A==
X-Received: by 2002:a05:622a:1248:b0:35b:b5fa:5e25 with SMTP id z8-20020a05622a124800b0035bb5fa5e25mr1041822qtx.215.1665002531239;
        Wed, 05 Oct 2022 13:42:11 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i10-20020ac8764a000000b0031f41ea94easm15639632qtr.28.2022.10.05.13.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:42:10 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:42:09 -0400
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
Subject: Re: [PATCH v1 5/7] mm/pagewalk: add walk_page_range_vma()
Message-ID: <Yz3sIY5Njzda3XSA@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-6-david@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:29PM +0200, David Hildenbrand wrote:
> +int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
> +			unsigned long end, const struct mm_walk_ops *ops,
> +			void *private)
> +{
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.mm		= vma->vm_mm,
> +		.vma		= vma,
> +		.private	= private,
> +	};
> +	int err;
> +
> +	if (start >= end || !walk.mm)
> +		return -EINVAL;
> +	if (start < vma->vm_start || end > vma->vm_end)
> +		return -EINVAL;
> +
> +	mmap_assert_locked(walk.mm);
> +
> +	err = walk_page_test(start, end, &walk);

According to test_walk():

 * @test_walk:		caller specific callback function to determine whether
 *			we walk over the current vma or not. Returning 0 means
 *			"do page table walk over the current vma", returning
 *			a negative value means "abort current page table walk
 *			right now" and returning 1 means "skip the current vma"

Since this helper has vma passed in, not sure whether this is needed at
all?

walk_page_vma_range() sounds slightly better to me as it does look more
like an extension of walk_page_vma(), rather than sister version of
walk_page_range_novma() (which works for "no backing VMA" case).  But no
strong opinion.

-- 
Peter Xu

