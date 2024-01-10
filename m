Return-Path: <linux-kselftest+bounces-2791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD308293AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 07:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14781B25071
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94233CFD;
	Wed, 10 Jan 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxiSztp7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2BDF56;
	Wed, 10 Jan 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704868033; x=1736404033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iugDvHfNwG8dAREv2UZRL1W+5P3/cnN9oqxxI551/qM=;
  b=HxiSztp7SRHXnlkinueeF8sfUi491dUYBvT8GcFdvj6n6nF/2+ySB+bD
   69CtU0v/utatdkIYh4KKF/54PoawRfL7kN64FKnbD8k8Gi/vIKUczYEWN
   sU0x/JeftKq+sv2xWCARY/LyXs0oKrHZb6naaQjcshUQAK1KtluAYTVwB
   82+heTnWdbBGoMD4U3CCHfI4o+EdCfjsVTbfcmsqDQQiDQeIwr4Gy3vQ7
   2wr4K02Zddp3ho3KKXN8rRRVN5O4SCN10KYEUQ7npH/nSSl/w1p6AYjaW
   QOLSriZcIISF58pgGUb7gQZZFGEdnl8B9sGrdk1+wi6Cr6+pCT+0rpp2u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5783427"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5783427"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 22:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="901029934"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="901029934"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2024 22:27:08 -0800
Date: Wed, 10 Jan 2024 14:27:08 +0800
From: Yuan Yao <yuan.yao@linux.intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	seanjc@google.com, shuah@kernel.org, stevensd@chromium.org
Subject: Re: [RFC PATCH v2 2/3] KVM: selftests: add selftest driver for KVM
 to test memory slots for MMIO BARs
Message-ID: <20240110062708.zf3arjmha5czgpzp@yy-desk-7060>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084457.20086-1-yan.y.zhao@intel.com>
 <20240104081604.ab4uurfoennzy5oj@yy-desk-7060>
 <ZZfP3/pYyPnbgL3P@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZfP3/pYyPnbgL3P@yzhao56-desk.sh.intel.com>
User-Agent: NeoMutt/20171215

On Fri, Jan 05, 2024 at 05:46:07PM +0800, Yan Zhao wrote:
> On Thu, Jan 04, 2024 at 04:16:04PM +0800, Yuan Yao wrote:
> > On Wed, Jan 03, 2024 at 04:44:57PM +0800, Yan Zhao wrote:
> > > This driver is for testing KVM memory slots for device MMIO BARs that are
> > > mapped to pages serving as device resources.
> > >
> > > This driver implements a mock device whose device resources are pages
> > > array that can be mmaped into user space. It provides ioctl interface to
> > > users to configure whether the pages are allocated as a compound huge page
> > > or not.
> >
> > I just think that it can be used in other scenarios, not only KVM.
> >
> Right. But I just want to make it to serve only KVM specific tests :)
>
> > >
> > > KVM selftest code can then map the mock device resource to KVM memslots
> > > to check if any error encountered. After VM shutdown, mock device
> > > resource's page reference counters are checked to ensure KVM does not hold
> > > extra reference count during memslot add/removal.
> > >
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ...
>
> > > +struct kvm_mock_device {
> > > +	bool compound;
> > > +	struct page *resource;
> > > +	u64 bar_size;
> > > +	int order;
> >
> > Do you have plan to allow user to change the bar_size via IOCTL ?
> > If no "order" and "bar_size" can be removed.
> >
> Currently no. But this structure is private to the test driver.
> What the benefit to remove the two?

It's useless so remove them makes code more easier to understand.

>
> > > +	int *ref_array;
> > > +	struct mutex lock;
> > > +	bool prepared;
> > > +};
> > > +
> > > +static bool opened;
> > > +
> > > +#define BAR_SIZE 0x200000UL
> > > +#define DEFAULT_COMPOUND true
> >
> > "kmdev->compound = true;" is more easy to understand,
> > but "kmdev->compound = DEFAULT_COMPOUND;" not.
> >
> Ok. But I want to make the state that "default compound state is true"
> more explicit and configurable by a macro.
>
>
> > > +
> > > +static vm_fault_t kvm_mock_device_mmap_fault(struct vm_fault *vmf)
> > > +{
> > > +	struct vm_area_struct *vma = vmf->vma;
> > > +	struct kvm_mock_device *kmdev = vma->vm_private_data;
> > > +	struct page *p = kmdev->resource;
> > > +	vm_fault_t ret = VM_FAULT_NOPAGE;
> > > +	unsigned long addr;
> > > +	int i;
> > > +
> > > +	for (addr = vma->vm_start, i = vma->vm_pgoff; addr < vma->vm_end;
> > > +	     addr += PAGE_SIZE, i++) {
> >
> > Just question:
> > Will it be enough if only map the accessed page for the testing purpose ?
> >
> It should be enough.
> But as VFIO usually maps the whole BAR in a single fault, I want to
> keep align with it :)

ah I see, thanks for your answer!

>
> > > +
> > > +		ret = vmf_insert_pfn(vma, addr, page_to_pfn(p + i));
> > > +		if (ret == VM_FAULT_NOPAGE)
> > > +			continue;
> > > +
> > > +		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
> > > +		return ret;
> > > +
> > > +	}
> > > +	return ret;
> > > +}
...
> > > +static int kvm_mock_device_check_resource_ref(struct kvm_mock_device *kmdev)
> > > +{
> > > +	u32 i, count = 1 << kmdev->order;
> > > +	struct page *p = kmdev->resource;
> > > +	int inequal = 0;
> > > +
> > > +	mutex_lock(&kmdev->lock);
> > > +	if (!kmdev->prepared) {
> > > +		mutex_unlock(&kmdev->lock);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		if (kmdev->ref_array[i] == page_ref_count(p + i))
> > > +			continue;
> > > +
> > > +		pr_err("kvm test device check resource page %d old ref=%d new ref=%d\n",
> > > +			i, kmdev->ref_array[i], page_ref_count(p + i));
> >
> > How about just return a bitmap to userspace for each page ineuqal ?
> > Or if inequal number itself is enough then just remove this output, in worst case
> > it prints 512 times for 2MB bar case, which looks just useless.
> >
> Right, print for 512 times is too much though it will only appear in the
> worst failure case.
> But I do think the info of "old ref" and "new ref" are useful for debugging.
> So, instead of printing bitmap, what about only printing the error message
> for once for the first error page?

For you reference:
The driver is designed for testing purpose
so I think just return the inequal should be enough, any one
who want to debug with this can easily change the source
code to see what's wrong there.

>
> > > +		inequal++;
> > > +	}
> > > +	mutex_unlock(&kmdev->lock);
> > > +
> > > +	return inequal;
> > > +}
> > > +
> > > +static int kvm_mock_device_fops_open(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct kvm_mock_device *kmdev;
> > > +
> > > +	if (opened)
> > > +		return -EBUSY;
> >
> > It can't work in case of 2 who open the device file at *real* same time, at least
> > you need atomic helpers for that purpose.
> >
> Ah, right. Will turn it to atomic.
>
> > BTW I saw "kvm_mock_devie" instance is per file level, so maybe not hard
> > to remove this limitation ?
> Yes, but as it's a test driver, I don't see any needs to complicate the code.
>
> > > +
> > > +	kmdev = kzalloc(sizeof(*kmdev), GFP_KERNEL_ACCOUNT);
> > > +	if (!kmdev)
> > > +		return -ENOMEM;
> > > +
> > > +	kmdev->compound = DEFAULT_COMPOUND;
> > > +	kmdev->bar_size = BAR_SIZE;
> > > +	kmdev->order = get_order(kmdev->bar_size);
> > > +	mutex_init(&kmdev->lock);
> > > +	filp->private_data = kmdev;
> > > +
> > > +	opened = true;
> > > +	return 0;
> > > +}
> > > +
> > > +static int kvm_mock_device_fops_release(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct kvm_mock_device *kmdev = filp->private_data;
> > > +
> > > +	if (kmdev->prepared)
> > > +		__free_pages(kmdev->resource, kmdev->order);
> > > +	mutex_destroy(&kmdev->lock);
> > > +	kfree(kmdev->ref_array);
> > > +	kfree(kmdev);
> > > +	opened = false;
> > > +	return 0;
> > > +}
> > > +
> > > +static long kvm_mock_device_fops_unlocked_ioctl(struct file *filp,
> > > +					unsigned int command,
> > > +					unsigned long arg)
> > > +{
> > > +	struct kvm_mock_device *kmdev = filp->private_data;
> > > +	int r;
> > > +
> > > +	switch (command) {
> > > +	case KVM_MOCK_DEVICE_GET_BAR_SIZE: {
> > > +		u64 bar_size;
> > > +
> > > +		bar_size = kmdev->bar_size;
> > > +		r = put_user(bar_size, (u64 __user *)arg);
> > > +		break;
> > > +	}
> > > +	case KVM_MOCK_DEVICE_PREPARE_RESOURCE: {
> > > +		u32 compound;
> > > +
> > > +		r = get_user(compound, (u32 __user *)arg);
> > > +		if (r)
> > > +			return r;
> > > +
> > > +		kmdev->compound = compound;
> > > +		r = kvm_mock_device_prepare_resource(kmdev);
> > > +		break;
> > > +
> > > +	}
> > > +	case KVM_MOCK_DEVICE_CHECK_BACKEND_REF: {
> > > +		int inequal;
> > > +
> > > +		inequal = kvm_mock_device_check_resource_ref(kmdev);
> > > +
> > > +		if (inequal < 0)
> > > +			return inequal;
> > > +
> > > +		r = put_user(inequal, (u32 __user *)arg);
> > > +		break;
> > > +	}
> > > +	default:
> > > +		r = -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	return r;
> > > +}
> > > +
> > > +
> > > +static const struct file_operations kvm_mock_device_fops = {
> > > +	.open		= kvm_mock_device_fops_open,
> > > +	.release	= kvm_mock_device_fops_release,
> > > +	.mmap		= kvm_mock_device_fops_mmap,
> > > +	.unlocked_ioctl = kvm_mock_device_fops_unlocked_ioctl,
> > > +	.llseek		= default_llseek,
> > > +	.owner		= THIS_MODULE,
> > > +};
> > > +
> > > +
> > > +static int __init kvm_mock_device_test_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = alloc_chrdev_region(&kvm_mock_dev.devt, 0, 1, "KVM-MOCK-DEVICE");
> >
> > How about misc_register() ? Like how KVM create /dev/kvm.
> > I think that will be more simpler.
> Ah, right. Will try to use it in next version.
>
> Thanks!
>
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	cdev_init(&kvm_mock_dev.cdev, &kvm_mock_device_fops);
> > > +	kvm_mock_dev.cdev.owner = THIS_MODULE;
> > > +	device_initialize(&kvm_mock_dev.device);
> > > +	kvm_mock_dev.device.devt =  MKDEV(MAJOR(kvm_mock_dev.devt), 0);
> > > +	ret = dev_set_name(&kvm_mock_dev.device, "kvm_mock_device");
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	ret = cdev_device_add(&kvm_mock_dev.cdev, &kvm_mock_dev.device);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +out:
> > > +	return ret;
> > > +}
> > > +
> > > +static void __exit kvm_mock_device_test_exit(void)
> > > +{
> > > +	cdev_device_del(&kvm_mock_dev.cdev, &kvm_mock_dev.device);
> > > +	unregister_chrdev_region(kvm_mock_dev.devt, 1);
> > > +}
> > > +
> > > +module_init(kvm_mock_device_test_init);
> > > +module_exit(kvm_mock_device_test_exit);
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/lib/test_kvm_mock_device_uapi.h b/lib/test_kvm_mock_device_uapi.h
> > > new file mode 100644
> > > index 000000000000..227d0bf1d430
> > > --- /dev/null
> > > +++ b/lib/test_kvm_mock_device_uapi.h
> > > @@ -0,0 +1,16 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +/*
> > > + * This is a module to help test KVM guest access of KVM mock device's BAR,
> > > + * whose backend is mapped to pages.
> > > + */
> > > +#ifndef _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H
> > > +#define _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/ioctl.h>
> > > +
> > > +#define KVM_MOCK_DEVICE_GET_BAR_SIZE _IOR('M', 0x00, u64)
> > > +#define KVM_MOCK_DEVICE_PREPARE_RESOURCE _IOWR('M', 0x01, u32)
> > > +#define KVM_MOCK_DEVICE_CHECK_BACKEND_REF _IOWR('M', 0x02, u32)
> > > +
> > > +#endif /* _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H */
> > > --
> > > 2.17.1
> > >
> > >

