Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58E1507D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2020 14:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBCN6h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 08:58:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43877 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBCN6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 08:58:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so9745034lfq.10
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q7EhG/mHxujJqjIax+tX/L6XnMUCZchWEgmsqcRY8O4=;
        b=qKCSEPA3x8kojnT0VGPWx1REhr2EhqE6i1LsFUAGRHw89eQpMMqBQ9S9OSvrvMREnc
         Kqf2KRHdvRc9eNFj0Fbr8amLlQZMLRlz6zKBMg1WL7/HIA+tXPcqjLVjTQ2R7KakPHd8
         jwLdRMJfSReB3MhMaxEKhmAyNYGue1eXm2uMQreQl/L3J3E4gO+Q1+0WudsQbAd9bkPn
         tpo6FUUIsaQOfmxjgM5AMcQ+fxVRdOxwlQKq6LqAAqxfW9Lb9cGiXiPNFT0E2TvHmN+Z
         vo1cDgpRnH/G5otSfVV8D6MokorSsYfD5tcRiWSrkfw8urfjsB3lWjxMQIv0hsoauceU
         fDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7EhG/mHxujJqjIax+tX/L6XnMUCZchWEgmsqcRY8O4=;
        b=Oor0KYRPeVyBsDxtbajNW0ms+MRM2fe+SM+xhHTeF4CZ/SZdhcABnH5iHA59P5vkvz
         VcTwQ2jGLTC1SJBR+zvFRY7/5hrVgXMyRsDMSX7B41Ep2JxzoR/mXWtl0Eef9K2cTWP4
         0NofpuG3ZGC7IgVsVqANYPBZrb309y1YWJtGpzK751/JdSp3R0M9PpS1XbRn1FMCxrxC
         pWTbvR6Ba7wv2v79i66PFddWYXCqYHoGuNKSUVDIRyOnyFJZ7ZiAbUMC0Nx2aUrBV2w0
         1z7PrIO23Ff9IS7wvZJCTtZGb3pmkF94ENwMIfONhajEhMxJ0cOYH5fIlr9BjLC2lSGf
         w7/Q==
X-Gm-Message-State: APjAAAUpZd6qNIk+gVI1DiiodIPMK9AvGDuNQOFwbenmk5V2dY53cze5
        XUmPG1IE7Pvre8J0O5F+QHSdHA==
X-Google-Smtp-Source: APXvYqwy/AMeACpJx+sRC2T4Q93xcTj2QVF/axvUST/Peo/4AOgO4Rx5SZuMTvzfMfCoqFdSX1vYAA==
X-Received: by 2002:ac2:4246:: with SMTP id m6mr12228504lfl.165.1580738313898;
        Mon, 03 Feb 2020 05:58:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n2sm9868111ljj.1.2020.02.03.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:58:33 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C5259100DC8; Mon,  3 Feb 2020 16:58:45 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:58:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/12] mm/gup_benchmark: support pin_user_pages() and
 related calls
Message-ID: <20200203135845.ymfbghs7rf67awex@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-12-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-12-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:28PM -0800, John Hubbard wrote:
> Up until now, gup_benchmark supported testing of the
> following kernel functions:
> 
> * get_user_pages(): via the '-U' command line option
> * get_user_pages_longterm(): via the '-L' command line option
> * get_user_pages_fast(): as the default (no options required)
> 
> Add test coverage for the new corresponding pin_*() functions:
> 
> * pin_user_pages_fast(): via the '-a' command line option
> * pin_user_pages():      via the '-b' command line option
> 
> Also, add an option for clarity: '-u' for what is now (still) the
> default choice: get_user_pages_fast().
> 
> Also, for the commands that set FOLL_PIN, verify that the pages
> really are dma-pinned, via the new is_dma_pinned() routine.
> Those commands are:
> 
>     PIN_FAST_BENCHMARK     : calls pin_user_pages_fast()
>     PIN_BENCHMARK          : calls pin_user_pages()
> 
> In between the calls to pin_*() and unpin_user_pages(),
> check each page: if page_maybe_dma_pinned() returns false, then
> WARN and return.
> 
> Do this outside of the benchmark timestamps, so that it doesn't
> affect reported times.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup_benchmark.c                         | 71 ++++++++++++++++++++--
>  tools/testing/selftests/vm/gup_benchmark.c | 15 ++++-
>  2 files changed, 80 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index 8dba38e79a9f..447628d0131f 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -8,6 +8,8 @@
>  #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
>  #define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
>  #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
> +#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
> +#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
>  
>  struct gup_benchmark {
>  	__u64 get_delta_usec;
> @@ -19,6 +21,48 @@ struct gup_benchmark {
>  	__u64 expansion[10];	/* For future use */
>  };
>  
> +static void put_back_pages(unsigned int cmd, struct page **pages,
> +			   unsigned long nr_pages)
> +{
> +	int i;
> +
> +	switch (cmd) {
> +	case GUP_FAST_BENCHMARK:
> +	case GUP_LONGTERM_BENCHMARK:
> +	case GUP_BENCHMARK:
> +		for (i = 0; i < nr_pages; i++)

'i' is 'int' and 'nr_pages' is 'unsigned long'.
There's space for trouble :P

> +			put_page(pages[i]);
> +		break;
> +
> +	case PIN_FAST_BENCHMARK:
> +	case PIN_BENCHMARK:
> +		unpin_user_pages(pages, nr_pages);
> +		break;
> +	}
> +}
> +
> +static void verify_dma_pinned(unsigned int cmd, struct page **pages,
> +			      unsigned long nr_pages)
> +{
> +	int i;
> +	struct page *page;
> +
> +	switch (cmd) {
> +	case PIN_FAST_BENCHMARK:
> +	case PIN_BENCHMARK:
> +		for (i = 0; i < nr_pages; i++) {

Ditto.

> +			page = pages[i];
> +			if (WARN(!page_maybe_dma_pinned(page),
> +				 "pages[%d] is NOT dma-pinned\n", i)) {
> +
> +				dump_page(page, "gup_benchmark failure");
> +				break;
> +			}
> +		}
> +		break;
> +	}
> +}
> +
>  static int __gup_benchmark_ioctl(unsigned int cmd,
>  		struct gup_benchmark *gup)
>  {

-- 
 Kirill A. Shutemov
