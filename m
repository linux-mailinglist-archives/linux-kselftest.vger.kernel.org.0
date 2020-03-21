Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4027C18DEEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Mar 2020 10:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCUJAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 05:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgCUJAw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 05:00:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C226820739;
        Sat, 21 Mar 2020 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584781251;
        bh=vLSdl/mc3zsd4nCLy4M6ojbC+JVBPuYFqgT7LG6glCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwTpCNY6QD6ZmwiZ0j/0OyrLMcyYsNlxtW9evMU0dfJuWr105KcFFdZQoDZHHivtx
         ewk+EGzRSsBaeIVmLnYBZflBWSnznK+5hLsYWBoneOQOqW/dH5iXqRxgzqCFpCuXLp
         shPA/gsNpFOGWSdygU3CVrjfg2Z1BoDoqVhgNO1A=
Date:   Sat, 21 Mar 2020 11:00:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200321090047.GM514123@unreal>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321003108.22941-1-rcampbell@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> This series adds basic self tests for HMM and are intended for Jason
> Gunthorpe's rdma tree which has a number of HMM patches applied.
>
> Changes v7 -> v8:
> Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
>   "Small hmm_range_fault() cleanups".
> Applied a number of changes from Jason's comments.
>
> Changes v6 -> v7:
> Rebased to linux-5.6.0-rc6
> Reverted back to just using mmu_interval_notifier_insert() and making
>   this series only introduce HMM self tests.
>
> Changes v5 -> v6:
> Rebased to linux-5.5.0-rc6
> Refactored mmu interval notifier patches
> Converted nouveau to use the new mmu interval notifier API
>
> Changes v4 -> v5:
> Added mmu interval notifier insert/remove/update callable from the
>   invalidate() callback
> Updated HMM tests to use the new core interval notifier API
>
> Changes v1 -> v4:
> https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com
>
> Ralph Campbell (3):
>   mm/hmm/test: add selftest driver for HMM
>   mm/hmm/test: add selftests for HMM
>   MAINTAINERS: add HMM selftests
>
>  MAINTAINERS                            |    3 +
>  include/uapi/linux/test_hmm.h          |   59 ++

Isn't UAPI folder supposed to be for user-visible interfaces that follow
the rule of non-breaking user space and not for selftests?

Thanks
