Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27348F941A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLPZZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 10:25:25 -0500
Received: from verein.lst.de ([213.95.11.211]:56403 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLPZZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 10:25:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C20F68BE1; Tue, 12 Nov 2019 16:25:22 +0100 (CET)
Date:   Tue, 12 Nov 2019 16:25:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
Message-ID: <20191112152521.GC12550@lst.de>
References: <20191104222141.5173-1-rcampbell@nvidia.com> <20191104222141.5173-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104222141.5173-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shouldn't this go into mm/ instead? It certainly doesn't seem
like a library.

> +static int dmirror_bounce_copy_from(struct dmirror_bounce *bounce,
> +				    unsigned long addr)
> +{
> +	unsigned long end = addr + bounce->size;
> +	char __user *uptr = (void __user *)addr;
> +	void *ptr = bounce->ptr;
> +
> +	for (; addr < end; addr += PAGE_SIZE, ptr += PAGE_SIZE,
> +					      uptr += PAGE_SIZE) {
> +		int ret;
> +
> +		ret = copy_from_user(ptr, uptr, PAGE_SIZE);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Why does this iterate in page sized chunks?  I don't remember a page
size limit on copy_{from,to}_user.

> +static int dmirror_invalidate_range_start(struct mmu_notifier *mn,
> +				const struct mmu_notifier_range *update)
> +{
> +	struct dmirror *dmirror = container_of(mn, struct dmirror, notifier);
> +
> +	if (mmu_notifier_range_blockable(update))
> +		mutex_lock(&dmirror->mutex);
> +	else if (!mutex_trylock(&dmirror->mutex))
> +		return -EAGAIN;
> +
> +	dmirror_do_update(dmirror, update->start, update->end);
> +	mutex_unlock(&dmirror->mutex);
> +	return 0;
> +}

Can we adopts this to Jasons new interval tree invalidate?

> +static int dmirror_fops_open(struct inode *inode, struct file *filp)
> +{
> +	struct cdev *cdev = inode->i_cdev;
> +	struct dmirror_device *mdevice;
> +	struct dmirror *dmirror;
> +
> +	/* No exclusive opens. */
> +	if (filp->f_flags & O_EXCL)
> +		return -EINVAL;

Device files usually just ignore O_EXCL, I don't see why this one
would be any different.

> +	mdevice = container_of(cdev, struct dmirror_device, cdevice);
> +	dmirror = dmirror_new(mdevice);
> +	if (!dmirror)
> +		return -ENOMEM;
> +
> +	/* Only the first open registers the address space. */
> +	mutex_lock(&mdevice->devmem_lock);
> +	if (filp->private_data)
> +		goto err_busy;
> +	filp->private_data = dmirror;
> +	mutex_unlock(&mdevice->devmem_lock);

->open is only called for the first open of a given file structure..

> +static int dmirror_fops_release(struct inode *inode, struct file *filp)
> +{
> +	struct dmirror *dmirror = filp->private_data;
> +
> +	if (!dmirror)
> +		return 0;

This can't happen if your ->open never returns 0 without setting the
private data.

> +	filp->private_data = NULL;

The file is feed afterwards, no need to clear the private data.
