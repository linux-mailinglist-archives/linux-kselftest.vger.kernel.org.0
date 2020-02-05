Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9D1529D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 12:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBELXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 06:23:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41825 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBELXc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 06:23:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so1908316ljc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dh5KVm5NVZR7B6kV3CkfPxftpb+A9muCzSxY5f+by0k=;
        b=tFQv4blGi1NukrKVKLKM9a5yWogak2ERntocChs0vWrya9lUNK3FSyatnKS1MLPDrt
         p+3KZiUybS59AUws2x8n3rybFtHSU3qsaP38wMgFaDNTG/usGncV2+gIcDPWZaTihn2x
         IT0s2ZIQkgy6nZw6cmza+jvP3jviAy+EvvnJ4AOSPcmWvi3H07xyPGK9XfmmYHOdOfBr
         i64GsDmqMsxzDMDTMf2POxCYF3RjYkxUsa1AEq/CUhlFdErzLlXMxmx6vvsrYmjq/W1E
         0uNIM8buRrHTOj7xD45gFWXrseGaMzB/dqpGKw77ntg+wPel+osm/zIX+A2PVoNrN2AX
         dPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dh5KVm5NVZR7B6kV3CkfPxftpb+A9muCzSxY5f+by0k=;
        b=Fkf6racRkR9de9GEAy/PNwJEKg70M9a1RwQ+sw3+BwsLUsZFNJBZ+JC2jS7JHrdfZO
         eCug2JHXeJJQAjVFGQmixb+2XmZq2YYxb8wgZUd0mehRbduWvt4nuevqdYDUrwbHM4qR
         bffURGQ/kxxRoruXF04W/xVM2aih/1+efxMQwQAFaePpdGDSBe8a3QhNsZ82rqshYPtF
         gK01a1X2xSPQPZ9D+PP18zULwpw+hiPfLKg+sMjEOzdBAY18GAvY3GHPtyKZ62AHj+ys
         gR/OaxiibBMgqsM9ckgekXlwIF6k+ankNK7XTXhbxxpaL3GCIaX7LUYtJyall1zHHmcC
         gEow==
X-Gm-Message-State: APjAAAW+Ba4nNMYb0L3GjsyC7Fc/jWbQ1C4323+5aR5tub5zNGd5touy
        Jec9bOlTMSOSsFZ0nxKNqLY/6g==
X-Google-Smtp-Source: APXvYqzGnroRbFkq73Du+mrJTZV4pY9s8Imx6qAPmcft4bWsOSpmZpl02xqYNxfUrCA0UHefdOERHw==
X-Received: by 2002:a2e:918c:: with SMTP id f12mr18604844ljg.66.1580901810333;
        Wed, 05 Feb 2020 03:23:30 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y18sm12786085ljm.93.2020.02.05.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:23:29 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AE293100AF6; Wed,  5 Feb 2020 14:23:43 +0300 (+03)
Date:   Wed, 5 Feb 2020 14:23:43 +0300
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
Subject: Re: [PATCH v4 04/12] mm: introduce page_ref_sub_return()
Message-ID: <20200205112343.e2vpcylgrobfcxlo@box>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234117.2974687-5-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 04, 2020 at 03:41:09PM -0800, John Hubbard wrote:
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
>  include/linux/page_ref.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 14d14beb1f7f..a0e171265b79 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -102,6 +102,15 @@ static inline void page_ref_sub(struct page *page, int nr)
>  		__page_ref_mod(page, -nr);
>  }
>  
> +static inline int page_ref_sub_return(struct page *page, int nr)
> +{
> +	int ret = atomic_sub_return(nr, &page->_refcount);
> +
> +	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))

s/__tracepoint_page_ref_mod/__tracepoint_page_ref_mod_and_return/

> +		__page_ref_mod_and_return(page, -nr, ret);
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
