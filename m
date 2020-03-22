Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72C318E77C
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 09:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCVIKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Mar 2020 04:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgCVIKm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Mar 2020 04:10:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E0E20722;
        Sun, 22 Mar 2020 08:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584864642;
        bh=2Q5vrn72Xm0DFK1rhozsPFjcLu4nBGHSn0WW/B4hy6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L24eYQEHtPNVXBgXPI6F87X2FZP066Z7WvO/y4nzDz8C3IEcAyT7ngAk7oNGA+29i
         ZYi8wigGkqhCS04qXfoeKuTSp6qD+ngU2Zp4KEcDEe8mhHXcAhJQ7aL/yiNNjoQp4z
         66NjEGhMK1JQPwXCQKE7eH+ciL6zOJZqUPgb3rEI=
Date:   Sun, 22 Mar 2020 10:10:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200322081038.GG650439@unreal>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200321090047.GM514123@unreal>
 <396f0c30-4a49-6a18-ff02-a73ee1a09883@nvidia.com>
 <20200321215505.GW20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321215505.GW20941@ziepe.ca>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 21, 2020 at 06:55:05PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 21, 2020 at 10:27:46AM -0700, Ralph Campbell wrote:
> >
> > On 3/21/20 2:00 AM, Leon Romanovsky wrote:
> > > On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> > > > This series adds basic self tests for HMM and are intended for Jason
> > > > Gunthorpe's rdma tree which has a number of HMM patches applied.
> > > >
> > > > Changes v7 -> v8:
> > > > Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
> > > >    "Small hmm_range_fault() cleanups".
> > > > Applied a number of changes from Jason's comments.
> > > >
> > > > Changes v6 -> v7:
> > > > Rebased to linux-5.6.0-rc6
> > > > Reverted back to just using mmu_interval_notifier_insert() and making
> > > >    this series only introduce HMM self tests.
> > > >
> > > > Changes v5 -> v6:
> > > > Rebased to linux-5.5.0-rc6
> > > > Refactored mmu interval notifier patches
> > > > Converted nouveau to use the new mmu interval notifier API
> > > >
> > > > Changes v4 -> v5:
> > > > Added mmu interval notifier insert/remove/update callable from the
> > > >    invalidate() callback
> > > > Updated HMM tests to use the new core interval notifier API
> > > >
> > > > Changes v1 -> v4:
> > > > https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com
> > > >
> > > > Ralph Campbell (3):
> > > >    mm/hmm/test: add selftest driver for HMM
> > > >    mm/hmm/test: add selftests for HMM
> > > >    MAINTAINERS: add HMM selftests
> > > >
> > > >   MAINTAINERS                            |    3 +
> > > >   include/uapi/linux/test_hmm.h          |   59 ++
> > >
> > > Isn't UAPI folder supposed to be for user-visible interfaces that follow
> > > the rule of non-breaking user space and not for selftests?
> > >
> > > Thanks
> > >
> >
> > Most of the other kernel module tests seem to invoke the test as part of the
> > module load/init. I'm open to moving it if there is a more appropriate location.
>
> Is it even possible to create a user mm_struct and put crazy things in
> it soley from a kernel module?

I didn't look very closely of what Ralph did in his patchsets, but from
what I know, if you want in-kernel interface, you use in-kernel module,
if you want to test user visible uapi, you write application. You don't
create new UAPI just to test something in the kernel.

Can kunit help here?
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html

Thanks

>
> Jason
>
