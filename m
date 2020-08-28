Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020C255979
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Aug 2020 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgH1LiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Aug 2020 07:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgH1Lgl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Aug 2020 07:36:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D28C061232
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Aug 2020 04:13:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so408496qth.5
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Aug 2020 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gQIGUiMIeeIo12Il7bUrjYk58mhEZJndN/EWd9XYIE=;
        b=PioKAFn8fdNLwzxhcOWCr/lhW22EBcVyqYD2T6CTGQZkstnAaUdV1g6cmo/nDhzkFv
         8ivLGloms6Xx44/b/6rT4bCjJUK9+S0HHoMjMfHKpd9eyjbJ3KeKeiPMfDPweuUxJA4U
         N88wCwKGRIP24st+U/LnJWxvhuHvfLGiYqCrmiSaZJAmQZMxoTvUg4h5I9fNFX1Ta3pH
         QkfARA7GGBGCUF9YijF7xzszb2J62whoTNOleglB/edmTYLCnvEV2NtlX9JRvXrOEXsM
         H516mXmB8M2kkvhVWOZLpShcQV3/oUrbrp4eLw3zvTIDO7jL0TPtW8zA/y2UGZZjwRg/
         LUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gQIGUiMIeeIo12Il7bUrjYk58mhEZJndN/EWd9XYIE=;
        b=BYgywXpv5ctBtXu0/ljuXiICXRRJi2vH7ZX3kGWLWln3+17c0aBHbmJQxppnLewJfi
         AsuI0HSVe3kkwOThIIzVIW0u/YRKY/pr8ng+p2TWBGZRc/QvkU70NYiDR+mUvRVHasgq
         p0EkA27fXjQzQpBTUm5QV73B2ztFpi6+6UXKnffGpQwpJO/0LWGJF0nDT1UhTwix/kyx
         +4f61VxWVaz7ip7Om75bh2jNzo6hzimmypWQ1vxAJh+P08IZSkAAlZ57lqPBR5+dRuSW
         pHLiIe0qNS5hH10TJHTu/88esFL+f7su1jUC1L2xh5qH6Hoef3iU/wZWPdW9waYosspb
         2Ayg==
X-Gm-Message-State: AOAM533wmePyeMf4ndoAn9ee69mpuOxQl94/wZ5arRVZZ76yX3ZC+Xqx
        GtQSnU/5OJEh9pIHjoHP/5vpGw==
X-Google-Smtp-Source: ABdhPJzGPBju0yAnoEhn5EAXcBFDqYwo7FFOY5QZTG0TPwuwKj933CaIS8c3I9oJh+7hCv3p9iYf+A==
X-Received: by 2002:ac8:6052:: with SMTP id k18mr1060677qtm.60.1598613206205;
        Fri, 28 Aug 2020 04:13:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i1sm447103qkd.58.2020.08.28.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:13:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBcJw-000OQc-IU; Fri, 28 Aug 2020 08:13:24 -0300
Date:   Fri, 28 Aug 2020 08:13:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/test: use the new SKIP() macro
Message-ID: <20200828111324.GU24045@ziepe.ca>
References: <20200827190400.12608-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827190400.12608-1-rcampbell@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 27, 2020 at 12:04:00PM -0700, Ralph Campbell wrote:
> Some tests might not be able to be run if resources like huge pages are
> not available. Mark these tests as skipped instead of simply passing.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> This applies to linux-mm and is for Andrew Morton's tree.
> 
>  tools/testing/selftests/vm/hmm-tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
