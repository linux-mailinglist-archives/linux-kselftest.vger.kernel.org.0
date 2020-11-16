Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2CB2B4AF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgKPQZY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 11:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKPQZW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 11:25:22 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514BC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 08:25:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so24945736lfh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9xG/1WZ4hUQEniTycexlF0Z4iE3+wzuenU4kk90ywzo=;
        b=fTcQvCZGCknts/NWYoWF0Fs/xydCjDT5R47q5L8XVSIQCtXgnpEvmEMywuwBAXCk2G
         pDUWrW36ijpFhxsKBQ2yprs3ExU7VW+RvmXR+nElMvwqjusEDhygn9d0vPdRGgO78kaG
         A3OhfXTUoMT8EtIxk8rC3XgFytVcCFHI8F63J9Ts9IXVHBsFCBrkRggkJHxGe1GwCmuR
         HHwE4rE5P9LElA0ptK7e6RJFaeaSNACP3m1PvvwNEfaK+R5leph9ahTAaPPHxdakdzli
         8BH8gjargFPpYPjSTIwhXQ7E9wdF9lVeDDDyZia52sP05H+hFj2++7/AYYUKVpFOpwrE
         J30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9xG/1WZ4hUQEniTycexlF0Z4iE3+wzuenU4kk90ywzo=;
        b=XJElTv/+Jlhrse//frshzc0ErcboNb+Ph61YmCfu8sUwT09ovBnetJpE2GVZzN9XA4
         jMZuhHiqgYiuTKFR7g15NyuiNabhuO6IgKYpOaKf/Nlbf09lJoT9Tj79U1QYqUJFXa1B
         NlGX6uNHb6T/XWJTJZbYGl1WPH4m87ZO4NXrA6fNG+cOa2EqVcuztg9moA+QlBallVXq
         5ndfn5ZPmU1n7JI0feGyTsqCmGtyit7rdmJ3SGTQ6IREO2ii+GyJ9DEoyojWVI7wj8ir
         MPtA0ri22U6LVZLqOkOFFA2PvC2ybJVi4Y9a9XT6/xNocusYlLIZLPy29NMjVONxbtqm
         fyiw==
X-Gm-Message-State: AOAM532ZXPtswR2WR+Qm42VNN/Ni1SYD8BM10ZhdSK+OsupAl/tylzN5
        hWxFIwXoa7b9Ub/szPKoZAEFxg==
X-Google-Smtp-Source: ABdhPJznVMQDd/DqjHtRUUctKXYAeZzd9Z0emVAQbGecQckp4yC+zEBPdGaEqNez4ohtfGKWQ92Exw==
X-Received: by 2002:ac2:5199:: with SMTP id u25mr74800lfi.438.1605543920845;
        Mon, 16 Nov 2020 08:25:20 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w199sm2790781lff.91.2020.11.16.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:25:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3A492100F5E; Mon, 16 Nov 2020 19:25:19 +0300 (+03)
Date:   Mon, 16 Nov 2020 19:25:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20201116162519.f4n445yku3dp2fhw@box>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111204008.21332-4-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It adds a new_order parameter to set new page order in page owner.
> It prepares for upcoming changes to support split huge page to any lower
> order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page_owner.h | 7 ++++---
>  mm/huge_memory.c           | 2 +-
>  mm/page_alloc.c            | 2 +-
>  mm/page_owner.c            | 6 +++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 3468794f83d2..215cbb159568 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page *page,
>  		__set_page_owner(page, order, gfp_mask);
>  }
>  
> -static inline void split_page_owner(struct page *page, unsigned int nr)
> +static inline void split_page_owner(struct page *page, unsigned int nr,
> +			unsigned int new_order)
>  {
>  	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, nr);
> +		__split_page_owner(page, nr, new_order);

Hm. Where do you correct __split_page_owner() declaration. I don't see it.

-- 
 Kirill A. Shutemov
