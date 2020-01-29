Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F114C98B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2020 12:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgA2LZG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 06:25:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42121 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2LZG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 06:25:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so5590ljl.9
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2020 03:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yuCTClL/pM7fgvSlPLx1qB/TzQ5SdJMl6/MOShIA1DQ=;
        b=0W7H46FMjIQyieXPqDTdHmsnT+fVvJJD10f3x0BOMctRvL9MkeTdx4VbdbHlRTBEN3
         b5/NawDAfyQpEhbLgT0rwOvcpevf1CHvRnfPK+nWNiUWSGyImoO0vgtrGmVKW+uZx29r
         bBsFaVwVuNzEQGuzTVKaB1lufIwzDYjD7ErDm/9BiL+5qbFTXQ+Ady+yLKCnGSNAgMd3
         W6mnYQvJTpgMGiYduy+scv4eX7iMsBIwYQPsUNpaNK3OyYiGdeXL9USXqvdYpFTTjSlw
         AraHVZkw1JBmq3Op+CNUrl6EEty11YBA5pwAZqGuiTKUaRJ47uGYaNwZMdUrsfU+3Fw7
         +BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yuCTClL/pM7fgvSlPLx1qB/TzQ5SdJMl6/MOShIA1DQ=;
        b=CWW0exwO7Ul1BTI+NVxj60Y9xESQSsVppMNiCJPBhVNMrMzHsWUNo/v1ZWQZQL7qgA
         43MqYRtAkZt6+Aufrn+9s2lnrgZ+04ehscurDfYGHu5x79K7HkqTWjxey4gXiDw4yI6r
         JdhSclfyFJLukaCTLKknI8AkfGWaiDCYfen7GctLn2aQRKqrHwWluDvkKOuLmaWY5Wem
         xBz+RdCn8jyigSPP7V3vmkeCJCruUiiNcZshsGI42JGgIz+a2ZQ0CVctC8CEnwjGzcqU
         FOighwena7H//TLQy2GbubS3BLBrW2aKqALnR6UW5XNjH/xJ0XgxG6rpPNiw9Xx6N3jX
         ltQA==
X-Gm-Message-State: APjAAAVomBlK1mHSZhqnRl7v1uxhlM5crPn33Hvb3Bagz0fPmsgXjwW9
        esm4minTG/FR+nvq8tO5YIFu6g==
X-Google-Smtp-Source: APXvYqwyL72yG90SI0NWAGgcd0insDnp1IMG7ae6YjG0JpIiyNIWobcDnM8YcTAzCUBn1pD6tZdqCQ==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr16595052ljg.108.1580297103916;
        Wed, 29 Jan 2020 03:25:03 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d9sm778410lja.73.2020.01.29.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:25:03 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 04319100AFE; Wed, 29 Jan 2020 14:25:11 +0300 (+03)
Date:   Wed, 29 Jan 2020 14:25:10 +0300
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
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for
 compound pages
Message-ID: <20200129112510.ulims6u36ofk2qwa@box>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129032417.3085670-2-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 28, 2020 at 07:24:10PM -0800, John Hubbard wrote:
> When debugging a problem that involves compound pages, it is extremely
> helpful if dump_page() reports not only the page->_refcount, but also
> the refcount of the head page of the compound page. That's because the
> head page collects refcounts for the entire compound page.
> 
> Therefore, enhance dump_page() so as to print out the refcount of the
> head page of a compound page.
> 
> This approach (printing information about a struct page that is not the
> struct page that was passed into dump_page()) has a precedent:
> compound_mapcount is already being printed.

refcount on a tail must always be 0. I think we should only print it when
it is non-zero, emphasizing this fact with a standalone message.

-- 
 Kirill A. Shutemov
