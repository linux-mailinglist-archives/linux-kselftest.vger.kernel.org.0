Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5379B423283
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhJEVAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhJEVAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 17:00:30 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434FC061749;
        Tue,  5 Oct 2021 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0oxTH1mltzxv2kpZ9e/Nb63q0lm9Q7e253v367zsV3Y=; b=RrdK9zAeGnsu0eMFyd5QmGfGIn
        6Os8KeZT2X2FY48lNSSZw6chr2YMSNaRXq8dEeEQbykqI6yl0gUHLs606/b2p3vxETaZHUGpMquBK
        /3zZZKmqM+iUklMJJqXA8/yAe9JUoyy6InzyAEwpN/QFQMRILDm8g9/j2ixnVmYCk2Bx3vec6Z+pd
        D4YdJb0/aA0M9LCRSv5to6wBs6aDc+OXsSlDSN37lAUYyNz1hLKbtdJcP3DrqMq3nul6iw7HmEOe4
        D9pA6/DnIubuIb205ewUiLukQVUuzdYqi2vVexdo707EBmZPxtzfOtOA0uq/1Akwc/EsCSChAvUr3
        B10zHUZg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXrWI-00BsZI-SR; Tue, 05 Oct 2021 20:58:38 +0000
Subject: Re: [PATCH] kunit: fix kernel-doc warnings due to mismatched arg
 names
To:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
References: <20211005204632.3132652-1-dlatypov@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e20d43eb-c72e-c297-65a8-76e52437b83c@infradead.org>
Date:   Tue, 5 Oct 2021 13:58:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005204632.3132652-1-dlatypov@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/5/21 1:46 PM, Daniel Latypov wrote:
> Commit 7122debb4367 ("kunit: introduce
> kunit_kmalloc_array/kunit_kcalloc() helpers") added new functions but
> called last arg `flags`, unlike the existing code that used `gfp`.
> This only is an issue in test.h, test.c still used `gfp`.
> 
> But the documentation was copy-pasted with the old names, leading to
> kernel-doc warnings.
> 
> Do s/flags/gfp to make the names consistent and fix the warnings.
> 
> Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>   include/kunit/test.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 24b40e5c160b..018e776a34b9 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -613,7 +613,7 @@ void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
>    * and is automatically cleaned up after the test case concludes. See &struct
>    * kunit_resource for more information.
>    */
> -void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
> +void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp);
>   
>   /**
>    * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
> @@ -657,9 +657,9 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>    *
>    * See kcalloc() and kunit_kmalloc_array() for more information.
>    */
> -static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
> +static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t gfp)
>   {
> -	return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
> +	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>   }
>   
>   void kunit_cleanup(struct kunit *test);
> 
> base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
> 


-- 
~Randy
