Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A371B8056
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 22:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgDXUQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 16:16:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729597AbgDXUQC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 16:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587759361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mijZ0deIMv+7N52HZ2/oeSJuKxO51O9zwfYwlf/bvUU=;
        b=C9EhOtkKREEANxg/I6/rDMkFVNyFTBOwMguXh8xELPmqp2IYZmKwfgjC3qKD5rOf1GzDRD
        5oe8YGsGIL8Ny3b5yEIsD+QFyXkdJ12nLytC/oO0CkQNdrqiLRu6GfrEb3ylwvwOL2HO9O
        XkairqiZupaYBPN+4ixb1euUX/4RJRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-D4Qq4ngMOX6rlbMg-FH6uw-1; Fri, 24 Apr 2020 16:15:56 -0400
X-MC-Unique: D4Qq4ngMOX6rlbMg-FH6uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A496D107BEFE;
        Fri, 24 Apr 2020 20:15:53 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2F531002380;
        Fri, 24 Apr 2020 20:15:51 +0000 (UTC)
Date:   Fri, 24 Apr 2020 14:15:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Ira Weiny" <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [regression] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200424141548.5afdd2bb@w520.home>
In-Reply-To: <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
        <20200211001536.1027652-7-jhubbard@nvidia.com>
        <20200424121846.5ee2685f@w520.home>
        <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 24 Apr 2020 12:20:03 -0700
John Hubbard <jhubbard@nvidia.com> wrote:

> On 2020-04-24 11:18, Alex Williamson wrote:
> ...
> > Hi John,
> > 
> > I'm seeing a regression bisected back to this commit (3faa52c03f44
> > mm/gup: track FOLL_PIN pages).  I've attached some vfio-pci test code
> > that reproduces this by mmap'ing a page of MMIO space of a device and
> > then tries to map that through the IOMMU, so this should be attempting
> > a gup/pin of a PFNMAP page.  Previously this failed gracefully (-EFAULT),
> > but now results in:  
> 
> 
> Hi Alex,
> 
> Thanks for this report, and especially for source code to test it, 
> seeing as how I can't immediately spot the problem just from the crash
> data so far.  I'll get set up and attempt a repro.
> 
> Actually this looks like it should be relatively easier than the usual 
> sort of "oops, we leaked a pin_user_pages() or unpin_user_pages() call,
> good luck finding which one" report that I fear the most. :) This one 
> looks more like a crash that happens directly, when calling into the 
> pin_user_pages_remote() code. Which should be a lot easier to solve...
> 
> btw, if you are set up for it, it would be nice to know what source file 
> and line number corresponds to the RIP (get_pfnblock_flags_mask+0x22) 
> below. But if not, no problem, because I've likely got to do the repro 
> in any case.

Hey John,

TBH I'm feeling a lot less confident about this bisect.  This was
readily reproducible to me on a clean tree a bit ago, but now it
eludes me.  Let me go back and figure out what's going on before you
spend any more time on it.  Thanks,

Alex

