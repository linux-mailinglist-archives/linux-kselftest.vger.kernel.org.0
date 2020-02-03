Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A341507A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2020 14:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBCNqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 08:46:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35970 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgBCNqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 08:46:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so14705125ljg.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 05:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tU9tK10SJbC8EDc1nwVApy1mZDrqz45FwFA9axqWA50=;
        b=XDZxoHhCcK/pGBTHQTPXfmvtfOmM8Qx8aZuUUNp8bBh+ABwsHj6XiY+mvVsbwnG+WK
         J+h9pC9u5JxzLXhuxudUIFZCRY7iVP8GEtrBuMhhajKY2VbUmsOAJOiCHqHSLIAFMP+h
         BAR615hNSp5oNHhpaCb492STJsM7SDPqgTMXh/tEeok0wkcP1Ylg+iooZ4gFg8q/Y7Ce
         HNnXYnWiHsb9v+nFvr/4j0fP3Q9jM4aQgAgHSRau7HUOJrbvHT/VgtzDJn+TmhgIQoP9
         uWYcKYY23Qm56Gdf0De+1ri647PIXY1Br8V0GjmteuTNK7fWj+kV0lWWF0XQYzAPYtEh
         nPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tU9tK10SJbC8EDc1nwVApy1mZDrqz45FwFA9axqWA50=;
        b=ds98+I8TRluU9Mc3tjNfWsuxvE8fuMRfCj6XtXqzNr54ZTd8xGJutqngXdjPh8Vdk9
         Ww9RuEeYO6sIk+uba5n59mkJPo47+DdhCCqF/seZEbbxFCvRJwmF2UAX+MNDCq69XQ62
         IzrAGRcQbQZ9V4dRakfwNbuuPxNcGxfXWxHXX4mAP1A65qerg31b1Mum/3xMow2HZwgG
         h21BXjXvbJsaLQYS2HWyDqF01X78clv90W2LQJs3isQkckjpXBigt6+Pk4jg2OeKwUMV
         MFoIxkYGZIcyMYDVP+NO1WvnEXje14WWv1mGuQ/D0nX/pK7kuzVOjM+8GYdOc5nw7NKx
         KR1A==
X-Gm-Message-State: APjAAAXLdUZcO+wnruy1+KSN1R3XyBPsrroLrOcZHkKXOW9GzO25xyTd
        ym5Ab++YlEa8QKVAPjho4HxEfQ==
X-Google-Smtp-Source: APXvYqyy6A/WwKqfelaaFFwhQh2rUZje06Y/Uu8QUR0CaG7TohoxG9uxfSDbuo3RreSYZYQDJJrQ4Q==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr14214187ljj.157.1580737579039;
        Mon, 03 Feb 2020 05:46:19 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q16sm8810732lfa.12.2020.02.03.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:46:18 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id D207B100DC8; Mon,  3 Feb 2020 16:46:29 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:46:29 +0300
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
Subject: Re: [PATCH v3 09/12] mm: dump_page(): better diagnostics for huge
 pinned pages
Message-ID: <20200203134629.qxkgsso5kksb3ljj@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-10-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-10-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:26PM -0800, John Hubbard wrote:
> As part of pin_user_pages() and related API calls, pages are
> "dma-pinned". For the case of compound pages of order > 1, the per-page
> accounting of dma pins is accomplished via the 3rd struct page in the
> compound page. In order to support debugging of any pin_user_pages()-
> related problems, enhance dump_page() so as to report the pin count
> in that case.
> 
> Documentation/core-api/pin_user_pages.rst is also updated accordingly.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
