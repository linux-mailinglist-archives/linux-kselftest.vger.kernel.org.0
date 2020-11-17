Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88222B709E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKQVFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQVFn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:05:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D33FC0613CF;
        Tue, 17 Nov 2020 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RFeeohkz2Cx/D+vXLKhH0do1RFDw2pXSfBePcdf6Zq8=; b=M+do9ccIfreRYCvuhFX2i+cV+S
        Q4YXBNQDOrGUz2802V6jQ7B4IwsEKpIwiGzPwqn6UNsf8fGsARnKy+Os3eMXHnZhfsBAoSrdoriUj
        OcgC9DcoW6OQSsfceAFW4j10Kh0wf18h2ch+LCzNK3Hhkh3kuCeo8Ggvo6R7c9BckJWW77w7qfgtr
        iwr5kKaNZNpjDuybJBqrISx/L1aelBIYJEpkbH6Iuccvc2Jxy9dFJd3pOgpk1+WM9D8cblhsh68Lu
        WhQ2KhsOdIbCjxE+c+PZgdS40amPZJKFE6e0EIgrJGuCnFAOGFdh2ibu91sV9rfHam7wBpSDM9s+9
        1YkvGVHg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf8AO-0003JG-DG; Tue, 17 Nov 2020 21:05:32 +0000
Date:   Tue, 17 Nov 2020 21:05:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20201117210532.GX29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
 <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 13, 2020 at 05:38:01PM -0800, Roman Gushchin wrote:
> On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
> > Matthew recently converted split_page_owner to take nr instead of order.[1]
> > But I am not
> > sure why, since it seems to me that two call sites (__split_huge_page in
> > mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the order
> > information.
> 
> Yeah, I'm not sure why too. Maybe Matthew has some input here?
> You can also pass new_nr, but IMO orders look so much better here.

If only I'd written that information in the changelog ... oh wait, I did!

    mm/page_owner: change split_page_owner to take a count
    
    The implementation of split_page_owner() prefers a count rather than the
    old order of the page.  When we support a variable size THP, we won't
    have the order at this point, but we will have the number of pages.
    So change the interface to what the caller and callee would prefer.

