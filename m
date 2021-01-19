Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC82FC202
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 22:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbhASVLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 16:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbhASSsn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 13:48:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE31C0613D6
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 10:47:53 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p5so9641276qvs.7
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 10:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQtsb6P16nylvkQXum2zCiAgwE4Ex40JE2Dh9jAvfm4=;
        b=IgbjYkdW3djs51hNlHYO9VNfWTGH7/ufXErYK8Yl5Fx4LHKBiCA5yvBpi5pswU6XFY
         /AvEogrwJhlnPNZo2DNdbX1IOJG2GiYh0+feUZ0R4klG4XZAc6U9+5MmZRBPrQne1eRl
         G452lLO6pY/Fo6fC2F9FCnn3yaLId/rJfFrfTKQLFl8jwdjBqh4zgZXYViW02CW0ANyo
         gowSMDAo7j5F470PRut9ZssTLsH80Q9O/a3ZCQ81CUxtIa7xwCoOseqoXKDb+u9eoT0P
         pwk8Gz6xyifQ5kf4eKKBgt2/ryPGpVG8HJbCHX1/GZ3TSP7EmwIf2GiIvrrzKBXFr4Np
         uIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQtsb6P16nylvkQXum2zCiAgwE4Ex40JE2Dh9jAvfm4=;
        b=UI2whgrRAo6Tm2uiZs9oX5BqD3Hm0GqAuA4EN/McpYmNQcaLLn1+ot+cK9YodS4arB
         nablHFpHGHzJ45nEwmLbYUPpWk5QVWDbJhmWMemQbMsfciJdEm83D952eVgoBkGbG1g7
         Y4H2QfSuXt4YmDrNTu1jKHNjLQLniy259D5LV1QiwLJhcS3r/db6nv3LHgju+/ZouQ3A
         F2288L+dPbNv6rgWxAJPL26lPrnHuRXDEl1yQQ8WgEziFjPY+1T9RJ0RSo13WrGgXHTr
         u+nmD+E7mW8xrS3/ExsMcsNaaLGAO4cx/uqY4DqL1yzSL3yBxjLisdGnNnWngzZ6Eg6i
         KBEg==
X-Gm-Message-State: AOAM530gR3FQiIE7hIxIx/hMT+MyaDIQGZQKBCieaoTQupwX+3rcdKFy
        kogbr8XQyqa1X3d2YcySWJZN4Q==
X-Google-Smtp-Source: ABdhPJzEG7viBlbUZNrXhEySKXWcNrfI5RfoT7MZqwFElxER/T6/kunL+TjK4dW1RsHYnK+4ZN5Vzg==
X-Received: by 2002:ad4:42a5:: with SMTP id e5mr5599059qvr.37.1611082072927;
        Tue, 19 Jan 2021 10:47:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j7sm12802577qtb.87.2021.01.19.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:47:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1w2h-003q3W-Vv; Tue, 19 Jan 2021 14:47:51 -0400
Date:   Tue, 19 Jan 2021 14:47:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
Message-ID: <20210119184751.GD4605@ziepe.ca>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-9-pasha.tatashin@soleen.com>
 <20210119183013.GB4605@ziepe.ca>
 <CA+CK2bBKbht34Hkg9YvhwYAiAjd3NMd_+Eir9wfx+07V-Y2TTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBKbht34Hkg9YvhwYAiAjd3NMd_+Eir9wfx+07V-Y2TTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 01:34:26PM -0500, Pavel Tatashin wrote:
> On Tue, Jan 19, 2021 at 1:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Jan 18, 2021 at 11:39:14PM -0500, Pavel Tatashin wrote:
> > > Zero page should not be used for long term pinned pages. Once pages
> > > are pinned their physical addresses cannot changed until they are unpinned.
> > >
> > > Guarantee to always return real pages when they are pinned by adding
> > > FOLL_WRITE.
> > >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > >  mm/gup.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > No, this will definitely break things
> 
> What will break

Things assuming GUP doesn't break COW, making all GUP WRITE was
already tried and revered for some other reason

> > Why does the zero page have to be movable?
> 
> It is not even about being movable, we can't cow pinned pages returned
> by GUP call, how can we use zero page for that?

The zero page is always zero, it is never written to. What does cow
matter?

Jason
