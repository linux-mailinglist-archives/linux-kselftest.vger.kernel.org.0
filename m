Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1B747950
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGDU6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDU6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC4710C8
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688504278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xoQAy1k59UO+UqvJlN8ZZmc0nx2ezBp5tE6xHVc6K0=;
        b=iV0DQRDEKDPBv/p0zk6qlr0fByaf8SI6loNCI52i/SzdLXp0FRuASHiuEcV/1kXukdS4Im
        NAOVJN+4EdN59LvPr9wweSG6427YSQ74NVNPtWq0alVl0v8fOFC0iGmH0TwiDQez3cyjth
        V2X+dwaO6Fu/TYJI1eyJn+f9X74W9Fw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-uDTTno6UN3iuRg_82LfkeQ-1; Tue, 04 Jul 2023 16:57:57 -0400
X-MC-Unique: uDTTno6UN3iuRg_82LfkeQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so172485185a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688504277; x=1691096277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xoQAy1k59UO+UqvJlN8ZZmc0nx2ezBp5tE6xHVc6K0=;
        b=PhYcg/XMip2y4tNksWDDF1Do859CbYrUaWAcCc3q6DRGlDLvK3zselyfjs4qIuQ9Gx
         Pq4McQCjuE2j+ebYQxlKR56P4fII4fNeq3bNkmECfOHMwv9kfTHv/6eq1DQK7boukhh7
         HVqEZqktxzXKGrDb226zrzNV9bAPTpo8bFZ2X9G+koyXkFErKVixkxDoTust+WjX2oiZ
         Ei4K78usZgNXxNZEFB8vsEJdKa0lLR/zMwEsruQVTJ9/hKFwUa66HYZBDxUdClsNVvTK
         GXQLqSiFUjcl2m6LqIwpZZjeAMctC+nVpy0jx3Sr+tIVwY9672T628ZLueYv+zIpjqJi
         AZFw==
X-Gm-Message-State: AC+VfDwuswy864payVYubqbwzy9Cr3kqmfC29WCFyL7YrK4C3fDT7DSN
        eR3ofoNznSyoPjNJrj/WXEXym4tP7kDTL2ImRKrNuhyuZcnofSGX4YVr21dmWRJOhBm0w//ioZG
        tmuKd1eA3u1nvkJ+pZ+mXt/+yOyPg
X-Received: by 2002:a05:620a:4010:b0:766:3190:8052 with SMTP id h16-20020a05620a401000b0076631908052mr19696464qko.0.1688504277092;
        Tue, 04 Jul 2023 13:57:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xb/vKX4Rf7OqmF2BqOllmu9tYbp/Y6WuIpnjmyfb54972lZs3nKCcbwYgzWdfzXNLzOF8cQ==
X-Received: by 2002:a05:620a:4010:b0:766:3190:8052 with SMTP id h16-20020a05620a401000b0076631908052mr19696444qko.0.1688504276815;
        Tue, 04 Jul 2023 13:57:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a06d300b007621bdc9d98sm91846qky.87.2023.07.04.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:57:56 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:57:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mm: userfaultfd: refactor hugetlb folio
 allocation / lookup code
Message-ID: <ZKSH0pb+asKZ4+s/@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629205040.665834-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 01:50:36PM -0700, Axel Rasmussen wrote:
> At the top of `hugetlb_mfill_atomic_pte`, we need to get the folio we're
> going to be mapping. There are three basic cases we're dealing with
> here:
> 
> 1. We're doing a UFFDIO_CONTINUE, in which case we lookup an existing
>    folio in the pagecache, instead of allocating a new one.
> 2. We need to allocate a new folio.
> 3. We previously failed while populating our new folio, so we "returned"
>    a temporary folio using `foliop` and had our caller retry.
> 
> In a future commit I'm going to add a fourth case for UFFDIO_POISON,
> where we aren't going to map a folio at all (newly allocated or
> otherwise). This end state will be simpler, and we can re-use a bit more
> code, if we stop using `if (...)` to distinguish the cases.
> 
> So, refactor the cases so they share most of the same code, and instead
> switch to `goto` to skip some parts depending on the case at hand.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

I didn't get why this patch is needed..

IIUC you added MFILL_ATOMIC_POISON handling at the entry of
hugetlb_mfill_atomic_pte() anyway.  Maybe it can even have its own
hugetlb_mfill_atomic_poison()?  Did I miss something?

> ---
>  mm/hugetlb.c | 53 +++++++++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bce28cca73a1..38711d49e4db 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6259,22 +6259,32 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  		if (IS_ERR(folio))
>  			goto out;
>  		folio_in_pagecache = true;
> -	} else if (!*foliop) {
> -		/* If a folio already exists, then it's UFFDIO_COPY for
> -		 * a non-missing case. Return -EEXIST.
> -		 */
> -		if (vm_shared &&
> -		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> -			ret = -EEXIST;
> -			goto out;
> +		goto ready;
> +	}
> +
> +	/* If a folio already exists, then it's UFFDIO_COPY for
> +	 * a non-missing case. Return -EEXIST.
> +	 */
> +	if (vm_shared && hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +		ret = -EEXIST;
> +		if (*foliop) {
> +			folio_put(*foliop);
> +			*foliop = NULL;
>  		}
> +		goto out;
> +	}
>  
> -		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
> -		if (IS_ERR(folio)) {
> -			ret = -ENOMEM;
> -			goto out;
> +	folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
> +	if (IS_ERR(folio)) {
> +		ret = -ENOMEM;
> +		if (*foliop) {
> +			folio_put(*foliop);
> +			*foliop = NULL;
>  		}
> +		goto out;
> +	}
>  
> +	if (!*foliop) {
>  		ret = copy_folio_from_user(folio, (const void __user *) src_addr,
>  					   false);
>  
> @@ -6302,22 +6312,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  			 */
>  			goto out;
>  		}
> -	} else {
> -		if (vm_shared &&
> -		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> -			folio_put(*foliop);
> -			ret = -EEXIST;
> -			*foliop = NULL;
> -			goto out;
> -		}
> -
> -		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
> -		if (IS_ERR(folio)) {
> -			folio_put(*foliop);
> -			ret = -ENOMEM;
> -			*foliop = NULL;
> -			goto out;
> -		}
> +	} else { /* Caller retried because we set *foliop previously */
>  		ret = copy_user_large_folio(folio, *foliop, dst_addr, dst_vma);
>  		folio_put(*foliop);
>  		*foliop = NULL;
> @@ -6327,6 +6322,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  		}
>  	}
>  
> +ready: /* `folio` ready to map (non-NULL, populated) */
> +
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * preceding stores to the page contents become visible before
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

-- 
Peter Xu

