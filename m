Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E742CF9C94
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 22:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKLVvN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 16:51:13 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12430 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLVvN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 16:51:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcb29500000>; Tue, 12 Nov 2019 13:51:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 13:51:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 13:51:12 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 21:51:11 +0000
Subject: Re: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-3-rcampbell@nvidia.com> <20191112152521.GC12550@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com>
Date:   Tue, 12 Nov 2019 13:51:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191112152521.GC12550@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573595472; bh=o8S1FMOsDYVa7X2xeImNy++Zw7OnjSU0JPm4JtD4kWU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=e+kCCH0wyWLDdWOJ92sd3L9x2p+aCHhnQ2sNerz3oDr7YsSvQq6a9ThaZYshlEc6c
         gfTLtLBSEjrtxWhdBUoTzJ145ZYuE1mDmQC27h1356TyBfEPnpchX72lZjJMgTOkwm
         0aNcmp7Y6js0j9exgwd3/0k6RSDi/TYIand/q72RQE7Ca7yCg+f44yCNiEChVfe72p
         F7LzZ9YGZJ9HIO1dunrf6MFgeDc7LjOO5IE93D3VdDBV+n9cj8BjxcWlA0MwajI7e+
         vpDhOKlQXSiGyTiMBRbtjB3JArbYRKg98Ome+58yJ9GwFirbhFTV84yx1rpZgPvOD8
         5/Vm1wjI3jXAw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/12/19 7:25 AM, Christoph Hellwig wrote:
> Shouldn't this go into mm/ instead? It certainly doesn't seem
> like a library.

I was following the convention for the other vm test kernel modules.
I see a couple of modules in mm/ but I don't have a personal
preference for where to place it.

Andrew, do you have a preference?

>> +static int dmirror_bounce_copy_from(struct dmirror_bounce *bounce,
>> +				    unsigned long addr)
>> +{
>> +	unsigned long end = addr + bounce->size;
>> +	char __user *uptr = (void __user *)addr;
>> +	void *ptr = bounce->ptr;
>> +
>> +	for (; addr < end; addr += PAGE_SIZE, ptr += PAGE_SIZE,
>> +					      uptr += PAGE_SIZE) {
>> +		int ret;
>> +
>> +		ret = copy_from_user(ptr, uptr, PAGE_SIZE);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Why does this iterate in page sized chunks?  I don't remember a page
> size limit on copy_{from,to}_user.

Good point. I'll fix that.

>> +static int dmirror_invalidate_range_start(struct mmu_notifier *mn,
>> +				const struct mmu_notifier_range *update)
>> +{
>> +	struct dmirror *dmirror = container_of(mn, struct dmirror, notifier);
>> +
>> +	if (mmu_notifier_range_blockable(update))
>> +		mutex_lock(&dmirror->mutex);
>> +	else if (!mutex_trylock(&dmirror->mutex))
>> +		return -EAGAIN;
>> +
>> +	dmirror_do_update(dmirror, update->start, update->end);
>> +	mutex_unlock(&dmirror->mutex);
>> +	return 0;
>> +}
> 
> Can we adopts this to Jasons new interval tree invalidate?

Well, it would mean registering for the whole process address space.
I'll give it a try.

>> +static int dmirror_fops_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct cdev *cdev = inode->i_cdev;
>> +	struct dmirror_device *mdevice;
>> +	struct dmirror *dmirror;
>> +
>> +	/* No exclusive opens. */
>> +	if (filp->f_flags & O_EXCL)
>> +		return -EINVAL;
> 
> Device files usually just ignore O_EXCL, I don't see why this one
> would be any different.

OK, I'll remove that test.

>> +	mdevice = container_of(cdev, struct dmirror_device, cdevice);
>> +	dmirror = dmirror_new(mdevice);
>> +	if (!dmirror)
>> +		return -ENOMEM;
>> +
>> +	/* Only the first open registers the address space. */
>> +	mutex_lock(&mdevice->devmem_lock);
>> +	if (filp->private_data)
>> +		goto err_busy;
>> +	filp->private_data = dmirror;
>> +	mutex_unlock(&mdevice->devmem_lock);
> 
> ->open is only called for the first open of a given file structure..
> 
>> +static int dmirror_fops_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct dmirror *dmirror = filp->private_data;
>> +
>> +	if (!dmirror)
>> +		return 0;
> 
> This can't happen if your ->open never returns 0 without setting the
> private data.
> 
>> +	filp->private_data = NULL;
> 
> The file is feed afterwards, no need to clear the private data.

OK, I'll clean that up.
