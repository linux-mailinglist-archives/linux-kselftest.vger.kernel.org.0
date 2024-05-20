Return-Path: <linux-kselftest+bounces-10419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D58C9A54
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516461C2143A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F911CA87;
	Mon, 20 May 2024 09:29:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2362224D7;
	Mon, 20 May 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197357; cv=none; b=i7ycxY1kYn4bpn/I3gJ6GzugLBMaa78v7Yet+7aTB71rtMSNbZ6CRMRO0wal+Dz4j9YFPtgxPNRIIfKELpVlYXiSJbNOfjJq32F7IiT3fHHJCN7qSZ8qvQ0qg+g9g84QceaFgrSK9v8o5XYJVnwKm7/rMzJnjJk0uzJ1Eo+85gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197357; c=relaxed/simple;
	bh=YYusQLSqoWPggr6hER2c0buyo+1+WOiwP2OT7HerXYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj83L7CPr9Bgpo2nGd6LEiBlLewupmmkEkoyc4szW30fyhRunRfo0UntBEnECjEFOlfWeRvL+V2rkVYXhzMXKx5kkB8s8iDeScl7ycVUmj/UGS2W40Aa6p+dEuiNPoBJTIInOio806SHY4w3W3oIkcqEInIz2T6kQd4u6iGoQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3271063;
	Mon, 20 May 2024 02:29:38 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7189E3F766;
	Mon, 20 May 2024 02:29:12 -0700 (PDT)
Date: Mon, 20 May 2024 10:29:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] kunit: test: Add vm_mmap() allocation resource
 manager
Message-ID: <ZksX4r0a1EGE_VPl@J2N7QTR9R3>
References: <20240519190422.work.715-kees@kernel.org>
 <20240519191254.651865-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519191254.651865-1-keescook@chromium.org>

On Sun, May 19, 2024 at 12:12:52PM -0700, Kees Cook wrote:
> For tests that need to allocate using vm_mmap() (e.g. usercopy and
> execve), provide the interface to have the allocation tracked by KUnit
> itself. This requires bringing up a placeholder userspace mm.
> 
> This combines my earlier attempt at this with Mark Rutland's version[1].
> 
> Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
> Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/kunit/test.h |  17 ++++++
>  lib/kunit/test.c     | 139 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 61637ef32302..8c3835a6f282 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -478,6 +478,23 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>  	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>  
> +/**
> + * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
> + * @test: The test context object.
> + * @file: struct file pointer to map from, if any
> + * @addr: desired address, if any
> + * @len: how many bytes to allocate
> + * @prot: mmap PROT_* bits
> + * @flag: mmap flags
> + * @offset: offset into @file to start mapping from.
> + *
> + * See vm_mmap() for more information.
> + */
> +unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
> +			    unsigned long addr, unsigned long len,
> +			    unsigned long prot, unsigned long flag,
> +			    unsigned long offset);
> +
>  void kunit_cleanup(struct kunit *test);
>  
>  void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 1d1475578515..09194dbffb63 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,13 +11,14 @@
>  #include <kunit/test-bug.h>
>  #include <kunit/attributes.h>
>  #include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> -#include <linux/mm.h>
>  
>  #include "debugfs.h"
>  #include "device-impl.h"
> @@ -871,6 +872,142 @@ void kunit_kfree(struct kunit *test, const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>  
> +struct kunit_vm_mmap_resource {
> +	unsigned long addr;
> +	size_t size;
> +};
> +
> +/* vm_mmap() arguments */
> +struct kunit_vm_mmap_params {
> +	struct file *file;
> +	unsigned long addr;
> +	unsigned long len;
> +	unsigned long prot;
> +	unsigned long flag;
> +	unsigned long offset;
> +};
> +
> +/*
> + * Arbitrarily chosen user address for the base allocation.
> + */
> +#define UBUF_ADDR_BASE	SZ_2M
> +
> +/* Create and attach a new mm if it doesn't already exist. */
> +static int kunit_attach_mm(void)
> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +
> +	if (current->mm)
> +		return 0;

My tests deliberately created/destroyed the mm for each test; surely we
don't want to inherit an MM in some arbitrary state? ... or is this just
so the mm can be allocated lazily upon the first mmap() within a test?

> +
> +	mm = mm_alloc();
> +	if (!mm)
> +		return -ENOMEM;
> +
> +	if (mmap_write_lock_killable(mm))
> +		goto out_free;
> +
> +	/* Define the task size. */
> +	mm->task_size = TASK_SIZE;
> +
> +	/* Prepare the base VMA. */
> +	vma = vm_area_alloc(mm);
> +	if (!vma)
> +		goto out_unlock;
> +
> +	vma_set_anonymous(vma);
> +	vma->vm_start = UBUF_ADDR_BASE;
> +	vma->vm_end = UBUF_ADDR_BASE + PAGE_SIZE;
> +	vm_flags_init(vma, VM_READ | VM_MAYREAD | VM_WRITE | VM_MAYWRITE);
> +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +
> +	if (insert_vm_struct(mm, vma))
> +		goto out_free_vma;
> +
> +	mmap_write_unlock(mm);

Why do we need this VMA given you have kunit_vm_mmap()?

This existed in my uaccess tests because I didn't use vm_mmap(), and I
wanted complete control over the addresses used.

Given you add kunit_vm_mmap(), I don't think we want this VMA -- it
doesn't serve any real purpose to tests, and accesses can erroneously
hit it, which is problematic.

UBUF_ADDR_BASE shouldn't be necessary either with kunit_vm_mmap(),
unless you want to use fixed addresses. That was just arbitrarily chosen
to be above NULL and the usual minimum mmap limit.

Mark.

> +
> +	/* Make sure we can allocate new VMAs. */
> +	arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
> +
> +	/* Attach the mm. It will be cleaned up when the process dies. */
> +	kthread_use_mm(mm);
> +
> +	return 0;
> +
> +out_free_vma:
> +	vm_area_free(vma);
> +out_unlock:
> +	mmap_write_unlock(mm);
> +out_free:
> +	mmput(mm);
> +	return -ENOMEM;
> +}
> +
> +static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
> +{
> +	struct kunit_vm_mmap_params *p = context;
> +	struct kunit_vm_mmap_resource vres;
> +	int ret;
> +
> +	ret = kunit_attach_mm();
> +	if (ret)
> +		return ret;
> +
> +	vres.size = p->len;
> +	vres.addr = vm_mmap(p->file, p->addr, p->len, p->prot, p->flag, p->offset);
> +	if (!vres.addr)
> +		return -ENOMEM;
> +	res->data = kmemdup(&vres, sizeof(vres), GFP_KERNEL);
> +	if (!res->data) {
> +		vm_munmap(vres.addr, vres.size);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void kunit_vm_mmap_free(struct kunit_resource *res)
> +{
> +	struct kunit_vm_mmap_resource *vres = res->data;
> +
> +	/*
> +	 * Since this is executed from the test monitoring process,
> +	 * the test's mm has already been torn down. We don't need
> +	 * to run vm_munmap(vres->addr, vres->size), only clean up
> +	 * the vres.
> +	 */
> +
> +	kfree(vres);
> +	res->data = NULL;
> +}
> +
> +unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
> +			    unsigned long addr, unsigned long len,
> +			    unsigned long prot, unsigned long flag,
> +			    unsigned long offset)
> +{
> +	struct kunit_vm_mmap_params params = {
> +		.file = file,
> +		.addr = addr,
> +		.len = len,
> +		.prot = prot,
> +		.flag = flag,
> +		.offset = offset,
> +	};
> +	struct kunit_vm_mmap_resource *vres;
> +
> +	vres = kunit_alloc_resource(test,
> +				    kunit_vm_mmap_init,
> +				    kunit_vm_mmap_free,
> +				    GFP_KERNEL,
> +				    &params);
> +	if (vres)
> +		return vres->addr;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_vm_mmap);
> +
>  void kunit_cleanup(struct kunit *test)
>  {
>  	struct kunit_resource *res;
> -- 
> 2.34.1
> 

