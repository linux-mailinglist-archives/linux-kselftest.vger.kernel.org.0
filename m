Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761E2309CD2
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Jan 2021 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhAaOWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Jan 2021 09:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhAaNg6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Jan 2021 08:36:58 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D0C061573;
        Sun, 31 Jan 2021 05:09:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s23so8865440pgh.11;
        Sun, 31 Jan 2021 05:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/V2tGtr+bCLDJTd3aEP/IuoxjXSD6eA0eKBRMu2p2A=;
        b=QbmylOo0OtLe4dn6JVMd10mCJuzRfmFI7DX8/SlsjVnrYf6uktmTQfoB6aYh79gn/y
         xVbjGkHqbF9Kayp+6PfGa3RdgtM0NveQzSPBQHqEwcZeVeJWXCaVEEOLrKj5cph+cBiK
         iQ8emuMoQl+826VhPxl9MKA9v1BFLfOIM98vERIy3+DXEp3bIFqJ3/X+ODaB/WKI6ttZ
         2SLGSv0oxHBn5hQBdDQ0B9xc+Usx5mbF2EQNMyE0E4HhowVsMDIbtIUgVupU6I556MYA
         ZExqAEf3XI1dOXXl52BWbAFSn7XBLHR5UqKixW3g1+r8hoDeS3+Yc+rkbqimub2cIwSJ
         TeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/V2tGtr+bCLDJTd3aEP/IuoxjXSD6eA0eKBRMu2p2A=;
        b=lvnyFnns3OiU4jWBv4no3FzxXAtgSL8fgsh30Yccs2XUfIe9SBVi3uXyih5XSHQNOe
         UGod7byNuFVCfkFSLkxQZQf6Uf+/okKw3/gUvK1VcA9z+wSO2iW8M54lN9zD/NTjl1iz
         VnrL6oZ76Cgn4Wy+JWUUZr3rhuxL7QYU/L9Kcj4mmUY2JjzbdnsZVjwLCyVrwmwGQ5LH
         B0rqpT7k+7mggZQafovJOTt1VjuOO0024qfJi34wZhKwQRU5L7s7tclHxEbkouR2s0P4
         DtRLnNG/eL/A7LwJAh+aWI7cZxJVvjfQY9gNpyNiERN5D6TkTcZ9TCKoXiPzx8zwfR0x
         F8zQ==
X-Gm-Message-State: AOAM531Z/nz0kjbELvKX5x+2eez8gWQqbdF3dV4G93Y5F0KNUSZkD5hs
        fzs0eWyzg4nAOs2I1QcU0WY=
X-Google-Smtp-Source: ABdhPJy5Bj9B6ThZcmUmkKVFx4aN2gyowzN/68vCGFPclx2pR1xMqulHzf5IVaBMwzzXz/G4mOeOtQ==
X-Received: by 2002:aa7:83c2:0:b029:1a5:daa9:f22f with SMTP id j2-20020aa783c20000b02901a5daa9f22fmr11803948pfn.48.1612098560072;
        Sun, 31 Jan 2021 05:09:20 -0800 (PST)
Received: from localhost.localdomain (61-230-46-104.dynamic-ip.hinet.net. [61.230.46.104])
        by smtp.gmail.com with ESMTPSA id s65sm15037095pfc.95.2021.01.31.05.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 05:09:19 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     pasha.tatashin@soleen.com
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com, iamjoonsoo.kim@lge.com, ira.weiny@intel.com,
        jgg@ziepe.ca, jhubbard@nvidia.com, jmorris@namei.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mgorman@suse.de, mhocko@suse.com, mike.kravetz@oracle.com,
        mingo@redhat.com, osalvador@suse.de, peterz@infradead.org,
        rientjes@google.com, rostedt@goodmis.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com, vbabka@suse.cz, willy@infradead.org
Subject: Re: [PATCH v8 07/14] mm: honor PF_MEMALLOC_PIN for all movable pages
Date:   Sun, 31 Jan 2021 21:09:03 +0800
Message-Id: <20210131130903.4875-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-8-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-8-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi,

[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c93e801a45e9..3f17c73ad582 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3807,16 +3807,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>  	return alloc_flags;
>  }
>  
> -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> -					unsigned int alloc_flags)
> +/* Must be called after current_gfp_context() which can change gfp_mask */
> +static inline unsigned int gpf_to_alloc_flags(gfp_t gfp_mask,
> +					      unsigned int alloc_flags)
>  {
>  #ifdef CONFIG_CMA
> -	unsigned int pflags = current->flags;
> -
> -	if (!(pflags & PF_MEMALLOC_PIN) &&
> -	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>  		alloc_flags |= ALLOC_CMA;
> -
>  #endif
>  	return alloc_flags;
>  }
> @@ -4472,7 +4469,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  	} else if (unlikely(rt_task(current)) && !in_interrupt())
>  		alloc_flags |= ALLOC_HARDER;
>  
> -	alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
> +	alloc_flags = gpf_to_alloc_flags(gfp_mask, alloc_flags);
>  
>  	return alloc_flags;
>  }
> @@ -4774,7 +4771,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  
>  	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
>  	if (reserve_flags)
> -		alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
> +		alloc_flags = gpf_to_alloc_flags(gfp_mask, reserve_flags);
>  
>  	/*
>  	 * Reset the nodemask and zonelist iterators if memory policies can be
> @@ -4943,7 +4940,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>  	if (should_fail_alloc_page(gfp_mask, order))
>  		return false;
>  
> -	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
> +	*alloc_flags = gpf_to_alloc_flags(gfp_mask, *alloc_flags);

I have a question, what is the abbreviation of "gpf" in the function
name gpf_to_alloc_flags()?

It seems that this function still use gfp_mask, is this supposed
to be gfp (Get Free Page)?

Thanks,
Lecopzer

