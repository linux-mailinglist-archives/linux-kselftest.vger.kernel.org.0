Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C713DD16
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAPOLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 09:11:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37744 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAPOLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 09:11:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so19216891qky.4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2020 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4TXCvIZZmY4SQCWQzeLR1MFoYNB31lrG2Qln+AaBO4=;
        b=JFr3/SZ3UQPbE6tN0WIDrmGEvvrNPfsLSUjntfSPf4H8CaB9Ec8m1JVzlwKdxQI7bR
         3Wf7o15qkWvfU2BrXgUqDa/P5/s3JU86YwmHmVDJgHJVZpC48Wq+GwpiH70SVGZXzNCW
         tUB0BZs20iU/qGmkxxbEKTg+rfI7uWyRi6HD7SwwKfn6eeOx5NXa2L4khYzmYqdU/Q73
         XJzZwnq1+SkVZNFtHtVAhdji1nJv/bWhk/VqEp4wX7VCiTOc5nBu+Cv/vpBioS4yMhnI
         nFwmiDzAw7e0YnFmBSZ6FJ2C6Eprq+qfGs/8uk/SzOBENKSHugI2ZSccx15T3V2aqTrv
         rb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4TXCvIZZmY4SQCWQzeLR1MFoYNB31lrG2Qln+AaBO4=;
        b=buLQkZL+WjAWfxSjdFH6aWkw/wTtXSl+k9LEPdxNX8OLQ7tTUn3N2AQ/IJ3CEaImEH
         WRxy1iGiBaqdN1b/bspXIj/RX+B0fOyFOC5Xf0eGyVLHa4UGNz2JJk8bW5NlxIPEVOTv
         YHrvXwM9DCUpbl9ToQbuJNSAUdiHZJasmQ5AOBf2HMRmwVJFnWRieD2loC7w3mvYF5RQ
         XYuL/HkeNjeS1ltg4rwXX0M/5bgalLqoJCMqWD3JsD0pBe2xaUyN8puK6tKMd3ASh8U9
         /mReThX8Ena13FhkpPSQGabKuftHwS/JxPWgw+yC8l0Zm56MU/wkvDZP3E7o0pG/Nxz7
         kqUA==
X-Gm-Message-State: APjAAAXm4sHXKqhFx+6qvDOewjocSVnHaIdbsJBJqpyWWfekGix7a0b3
        sXZ1X2KS9toqp7aZE57cMSZDJw==
X-Google-Smtp-Source: APXvYqx6uZpu4GcW1N0sXEyw9K5yx2S6JPwxGtld6dzchDnf5W2zeuoRuG/8THysf1WiLlTh8VyUTg==
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr32372460qkb.271.1579183901908;
        Thu, 16 Jan 2020 06:11:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g53sm11292147qtk.76.2020.01.16.06.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 06:11:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is5s4-0003yp-CZ; Thu, 16 Jan 2020 10:11:40 -0400
Date:   Thu, 16 Jan 2020 10:11:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 4/6] mm/mmu_notifier: add mmu_interval_notifier_find()
Message-ID: <20200116141140.GA10759@ziepe.ca>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-5-rcampbell@nvidia.com>
 <20200114124956.GN20978@mellanox.com>
 <528c1cff-608c-d342-1e72-90d780555204@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528c1cff-608c-d342-1e72-90d780555204@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 15, 2020 at 02:05:24PM -0800, Ralph Campbell wrote:
> 
> On 1/14/20 4:49 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 13, 2020 at 02:47:01PM -0800, Ralph Campbell wrote:
> > > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > > index 47ad9cc89aab..4efecc0f13cb 100644
> > > +++ b/mm/mmu_notifier.c
> > > @@ -1171,6 +1171,39 @@ void mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
> > >   }
> > >   EXPORT_SYMBOL_GPL(mmu_interval_notifier_update);
> > > +struct mmu_interval_notifier *mmu_interval_notifier_find(struct mm_struct *mm,
> > > +				const struct mmu_interval_notifier_ops *ops,
> > > +				unsigned long start, unsigned long last)
> > > +{
> > > +	struct mmu_notifier_mm *mmn_mm = mm->mmu_notifier_mm;
> > > +	struct interval_tree_node *node;
> > > +	struct mmu_interval_notifier *mni;
> > > +	struct mmu_interval_notifier *res = NULL;
> > > +
> > > +	spin_lock(&mmn_mm->lock);
> > > +	node = interval_tree_iter_first(&mmn_mm->itree, start, last);
> > > +	if (node) {
> > > +		mni = container_of(node, struct mmu_interval_notifier,
> > > +				   interval_tree);
> > > +		while (true) {
> > > +			if (mni->ops == ops) {
> > > +				res = mni;
> > > +				break;
> > > +			}
> > > +			node = interval_tree_iter_next(&mni->interval_tree,
> > > +						       start, last);
> > > +			if (!node)
> > > +				break;
> > > +			mni = container_of(node, struct mmu_interval_notifier,
> > > +					   interval_tree);
> > > +		}
> > > +	}
> > > +	spin_unlock(&mmn_mm->lock);
> > 
> > This doesn't seem safe at all, here we are returning a pointer to
> > memory from the interval tree with out any kind of lifetime
> > protection.
> 
> It is memory that the driver has allocated and has full control over
> the lifetime since the driver does all the insertions and removals.
> The driver does have to hold the HW page table lock so lookups are
> synchronized with interval insertions and removals and page table
> entry insertions and removals.

No.. the ->release is async, so having the driver hold a lock around
all the mmu_interval_ APIS still doesn't make it safe. The element
could be on the defered list and it could become freed at any moment.

> > If the interval tree is read it must be left in the read lock state
> > until the caller is done with the pointer.
> > 
> > .. and this poses all sorts of questions about consistency with items
> > on the deferred list. Should find return an item undergoing deletion?
> 
> I don't think so. The deferred operations are all complete when
> mmu_interval_read_begin() returns, and the sequence number check
> with mmu_interval_read_retry() guarantees there have been no changes
> while not holding the driver page table lock and calling hmm_range_fault().

It seems very dangerous to say, on one hand, that the driver is
serialized because it holds a lock around all mmu_interval_* calls,
while on the other saying that on rare edge cases find does not return
a result that matches the serial-program-order sequence.

This seems like a way to create bugs.

For instance, if find is consistent with the defered list then it will
not return any element that has a pending deletion and the above issue
with lifetime wouldn't happen.

However, I'm still not sure that providing an API tha requires the
driver to provide tricky locking is the best idea. This basically says
that if a driver uses find then every single other call to
mmu_interval_* must be serialized with a single lock.

Jason
