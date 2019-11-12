Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE2F93F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKLPTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 10:19:00 -0500
Received: from verein.lst.de ([213.95.11.211]:56369 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfKLPTA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 10:19:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 02B8368BE1; Tue, 12 Nov 2019 16:18:57 +0100 (CET)
Date:   Tue, 12 Nov 2019 16:18:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/hmm: make full use of walk_page_range()
Message-ID: <20191112151856.GB12550@lst.de>
References: <20191104222141.5173-1-rcampbell@nvidia.com> <20191104222141.5173-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104222141.5173-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although we could clean this up a tidbit more by removing the start
variable:

diff --git a/mm/hmm.c b/mm/hmm.c
index d4984a08ed9b..b5b1ed646c2f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -667,10 +667,9 @@ static const struct mm_walk_ops hmm_walk_ops = {
  */
 long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
-	unsigned long start = range->start;
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
-		.last = start,
+		.last = range->start,
 		.flags = flags,
 	};
 	struct mm_struct *mm = range->notifier->mm;
@@ -682,9 +681,8 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 		/* If range is no longer valid force retry. */
 		if (mmu_range_check_retry(range->notifier, range->notifier_seq))
 			return -EBUSY;
-		ret = walk_page_range(mm, start, range->end, &hmm_walk_ops,
-				      &hmm_vma_walk);
-		start = hmm_vma_walk.last;
+		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
+				      &hmm_walk_ops, &hmm_vma_walk);
 	} while (ret == -EBUSY);
 
 	if (ret)
