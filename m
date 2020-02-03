Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95822150711
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2020 14:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgBCNXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 08:23:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46027 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgBCNXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 08:23:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id f25so14569014ljg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yciKij7aZ9IxqsUAs/104yOVBksVOCSAdlwEXkSdpoQ=;
        b=FAiKXrOR692VWEgWF88bI0DjGDu/Sjr0t06eV884FO+vVgwg4SO1uh7Qjl5zLD2Mnt
         6dIaQ6GUVYMIRRdp6Zr3N4HwWQyUE9FJgr/ot760UXFb9ieeuh0y5ihna9xcf2NmLfCx
         ATq82Ac6zbqDRu4VKrwnxbU4xctjK9vueLdVmKNpS6KqzdJvtHV4CLOBxIiZkxMDg+qK
         ecH96G8OHeFmWugtvDrmtXQeUcEyqBTxR9to5bv4yN3DtqJmP2+Xwq+RSXlRUoI+6ri4
         AUdjBjhCj/vULhTNfShatAWSXcd57f3QFCfh0lIhgZ0VEybpMYi20qW77bNE0IKdYCKt
         uSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yciKij7aZ9IxqsUAs/104yOVBksVOCSAdlwEXkSdpoQ=;
        b=S3f5cybV5s3QFG6YwQxROd+rPr/NnISmN03NHcQY81Hk8iw3js1PPv3/a7xXXs/yfF
         WylP0lEadXnRwEMIR6CcHfFnowmAmmlPXFQk5xTmHAB0Brf3YdypWsky3zIsHP6frGMz
         SMwd7Ig0/A4tiopjrwunmbWzAOHPB2vhUoLcaMCn2Q+rezuMigSisd/Gpu2QmWCHrlPe
         XUt/tm+ji04nhOiUxc2K8NZIDKPBaiIPmrKLJDqXspSq1ELujTbWW1MVi94lR3a5W9ST
         dLRNvmepqo8TOEw4Gzvk1poMqarSnJs74ef344kkoBEwMETsZAzRxQcyDs4Zff0JMHok
         bP+A==
X-Gm-Message-State: APjAAAUFDViwu9Uku80rZoDG2mfnZZ2yrojek21lL8NVw+uheUU2Qq2F
        0AKwkBqPdOqCYFhBralkmI2VrLhO0V0=
X-Google-Smtp-Source: APXvYqz6+ASziVfzDtmIfqoBNJGqRDrKpccZCRWjuRMxtwAuDOff2v4nbarQjcGBTnjRDFxC1sKg0Q==
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr13425116ljl.56.1580736196893;
        Mon, 03 Feb 2020 05:23:16 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j7sm8959848lfh.25.2020.02.03.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:23:16 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1306D100DC8; Mon,  3 Feb 2020 16:23:29 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:23:29 +0300
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
Subject: Re: [PATCH v3 04/12] mm: introduce page_ref_sub_return()
Message-ID: <20200203132329.oj32h4ryna4gmkwh@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-5-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:21PM -0800, John Hubbard wrote:
> An upcoming patch requires subtracting a large chunk of refcounts from
> a page, and checking what the resulting refcount is. This is a little
> different than the usual "check for zero refcount" that many of the
> page ref functions already do. However, it is similar to a few other
> routines that (like this one) are generally useful for things such as
> 1-based refcounting.
> 
> Add page_ref_sub_return(), that subtracts a chunk of refcounts
> atomically, and returns an atomic snapshot of the result.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/page_ref.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 14d14beb1f7f..b9cbe553d1e7 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -102,6 +102,16 @@ static inline void page_ref_sub(struct page *page, int nr)
>  		__page_ref_mod(page, -nr);
>  }
>  
> +static inline int page_ref_sub_return(struct page *page, int nr)
> +{
> +	int ret = atomic_sub_return(nr, &page->_refcount);
> +
> +	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
> +		__page_ref_mod(page, -nr);

Shouldn't it be __page_ref_mod_and_return() and relevant tracepoint?

> +
> +	return ret;
> +}
> +
>  static inline void page_ref_inc(struct page *page)
>  {
>  	atomic_inc(&page->_refcount);
> -- 
> 2.25.0
> 

-- 
 Kirill A. Shutemov
