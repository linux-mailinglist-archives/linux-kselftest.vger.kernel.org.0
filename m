Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA318FCA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWSZg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 14:25:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42038 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCWSZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 14:25:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so8632753qto.9
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vz1jTrOHhlau0BRekH82JXjI9Z5PbbRoxtyzM7wcGdk=;
        b=X1CH1GVltCQdj8DdoNqavN4roarwwcB2hsCI+XK3JzbOgASZx+Kj0guGgixCarN8m0
         yF2zg//qewNml70VOfqydcfIUG+A+LDNw/5cOdFrrzvjH2jdApwlKvzNHtKc2IQ64Swd
         mHOw6pLeTWAUiIEPs6ybgnFPu3hBO9khxJylZH+SUZRhIssZwakCeu0K1kh7VrNc51rE
         lMoPT/HMzDOrtYXL2z+uty/6LPVxYustbdL93bBBPzXMnQ8fZQvs7hzC2gHoQS2AwalO
         lUajioxU2lilEs7I3w159QXUk9BYngxYjRdibBQCvubenXNFUK/MoOVOhXgQJwZKJni9
         ZHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vz1jTrOHhlau0BRekH82JXjI9Z5PbbRoxtyzM7wcGdk=;
        b=raU3ETVgtPT5uWHIgLeIYU8DKNk04w0X5Rg4IQ5r+eLLkD0la/Y4nw3NF1aK2xQyIK
         s0sKQZJY7JY1GyVQ/RSQBeUjzvEOZNBpsJowkNG/C7geZ+np99vZxF1eG23FN1fnPdfr
         qylerdKIQIJd0uki36IOgtNCLXWvEn7sEgoRmeFEp6Zl/pfxKOfX9Jfdj2kWTzvB5On/
         naAstSdsfhkMYKF60SpaEGH8EB82YzTBDQnNCJxRJhPFZ58MHFp9chlxWqifhga/rd0M
         O3Mvpq/RIzLC+DAtN1ehOk45Qn8I0RNiOSh+1qJzYvYG7rMQ8/KjKvVrD3GxDSBBEHjV
         J5fA==
X-Gm-Message-State: ANhLgQ02XRHChoM7cY0KTH1hZnpzmx7Rc0FEiFb1A46EQXHAzdimPWyx
        QmGuOWgeHhBeCA2Z+ARjoGdvuw==
X-Google-Smtp-Source: ADFU+vsib7u44SXaJjB6F+7ycgLvU7K9p2KA3EjlB2X4Tm1ey09SO8RfuMz6qlyjf9wDCQFwfID/9g==
X-Received: by 2002:ac8:6b54:: with SMTP id x20mr22673141qts.41.1584987935620;
        Mon, 23 Mar 2020 11:25:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o67sm11050065qka.114.2020.03.23.11.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 11:25:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGRlW-0007K3-F2; Mon, 23 Mar 2020 15:25:34 -0300
Date:   Mon, 23 Mar 2020 15:25:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200323182534.GD20941@ziepe.ca>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200321090047.GM514123@unreal>
 <396f0c30-4a49-6a18-ff02-a73ee1a09883@nvidia.com>
 <20200321215505.GW20941@ziepe.ca>
 <20200322081038.GG650439@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322081038.GG650439@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 22, 2020 at 10:10:38AM +0200, Leon Romanovsky wrote:
> On Sat, Mar 21, 2020 at 06:55:05PM -0300, Jason Gunthorpe wrote:
> > On Sat, Mar 21, 2020 at 10:27:46AM -0700, Ralph Campbell wrote:
> > >
> > > On 3/21/20 2:00 AM, Leon Romanovsky wrote:
> > > > On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> > > > > This series adds basic self tests for HMM and are intended for Jason
> > > > > Gunthorpe's rdma tree which has a number of HMM patches applied.
> > > > >
> > > > > Changes v7 -> v8:
> > > > > Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
> > > > >    "Small hmm_range_fault() cleanups".
> > > > > Applied a number of changes from Jason's comments.
> > > > >
> > > > > Changes v6 -> v7:
> > > > > Rebased to linux-5.6.0-rc6
> > > > > Reverted back to just using mmu_interval_notifier_insert() and making
> > > > >    this series only introduce HMM self tests.
> > > > >
> > > > > Changes v5 -> v6:
> > > > > Rebased to linux-5.5.0-rc6
> > > > > Refactored mmu interval notifier patches
> > > > > Converted nouveau to use the new mmu interval notifier API
> > > > >
> > > > > Changes v4 -> v5:
> > > > > Added mmu interval notifier insert/remove/update callable from the
> > > > >    invalidate() callback
> > > > > Updated HMM tests to use the new core interval notifier API
> > > > >
> > > > > Changes v1 -> v4:
> > > > > https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com
> > > > >
> > > > > Ralph Campbell (3):
> > > > >    mm/hmm/test: add selftest driver for HMM
> > > > >    mm/hmm/test: add selftests for HMM
> > > > >    MAINTAINERS: add HMM selftests
> > > > >
> > > > >   MAINTAINERS                            |    3 +
> > > > >   include/uapi/linux/test_hmm.h          |   59 ++
> > > >
> > > > Isn't UAPI folder supposed to be for user-visible interfaces that follow
> > > > the rule of non-breaking user space and not for selftests?
> > > >
> > > > Thanks
> > > >
> > >
> > > Most of the other kernel module tests seem to invoke the test as part of the
> > > module load/init. I'm open to moving it if there is a more appropriate location.
> >
> > Is it even possible to create a user mm_struct and put crazy things in
> > it soley from a kernel module?
> 
> I didn't look very closely of what Ralph did in his patchsets, but from
> what I know, if you want in-kernel interface, you use in-kernel module,
> if you want to test user visible uapi, you write application. You don't
> create new UAPI just to test something in the kernel.

That works fine as long as the in-kernel interfaces don't require user
created objects like mm_struct and vmas, which is the case here.

So there must be some special uAPI between the kerne/user to make it
work.

Jason
