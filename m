Return-Path: <linux-kselftest+bounces-37437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3666DB07841
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D14B56534E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CBD25A2BB;
	Wed, 16 Jul 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0lxSpKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B171C5D44;
	Wed, 16 Jul 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676672; cv=none; b=dq5FyBm/CQnlvYwsk6HdjnHpWlgBDXqvJEmgZ630pjWVO4GgztyR0m2Oo3rbj/khnIvIQ46+dIErViqVleiN0Wc6xjPIKii7yhMlBJ5g5U5Eiyii3g6wY+vaDrR39PYkVP8DT8alPXSTsMsp2t/roQj45oD0kGTBM8UpV/4GiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676672; c=relaxed/simple;
	bh=EY4JWSDCGyxx1eGOtz5OXXZbV4zTumfSnv0toLDHIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0uPv6uCXwf6iCs+f13JDtJgPU6XIVY+DlHpa5BwMwE8Z+u6JUq1KwnLm5BQQffsScKONt6ILDpGDTJ3qkcTD5V1DEBE4anG9czEYt/6L4n2/KdweABbm/v078ntbQbtHNH37ojkJc0iALZklxGDIXcAk3hsm30gkfaeh/drvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0lxSpKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23030C4CEE7;
	Wed, 16 Jul 2025 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676672;
	bh=EY4JWSDCGyxx1eGOtz5OXXZbV4zTumfSnv0toLDHIk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0lxSpKkgIpC87ek53RvnnPF5XsKTuyZwHys6v8IsHE4XLD7IMagRI+BJ5FUGv715
	 0rPsO9OH5A5u7BJmZ7GTCIdLP61AzCjpPqueN6nfj19ttXND0bhWhz06c3igNywZ2b
	 CWzSH0MtqvhRKaTSzISeqskQrgCP/c5o0gxxbvrjj6gH00aERBwxAVNjPURawJM5Pa
	 S1HPImJV6wLKSDx584Yr0Fc4B/aVuL0myZ1Rib9CYAzl8uuVIgL2hpozT7fWiGBXbF
	 39LzZYieH1N+7plV2Ba1Lm+H6wVQxikP7MFORyquP+8pjnhFIZzBFZbasSeQ4xopFZ
	 KsZGYCz7EW3XA==
Date: Wed, 16 Jul 2025 07:37:51 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 4/6] binder: Scaffolding for binder_alloc KUnit tests
Message-ID: <202507160735.C76466BB@keescook>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-5-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714185321.2417234-5-ynaffit@google.com>

On Mon, Jul 14, 2025 at 11:53:17AM -0700, Tiffany Yang wrote:
> Add setup and teardown for testing binder allocator code with KUnit.
> Include minimal test cases to verify that tests are initialized
> correctly.
> 
> Tested-by: Rae Moar <rmoar@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
> v2:
> * Added tested-by tag
> v3:
> * Split kunit lib change into separate change
> ---
>  drivers/android/Kconfig                    |  11 ++
>  drivers/android/Makefile                   |   1 +
>  drivers/android/binder.c                   |   5 +-
>  drivers/android/binder_alloc.c             |  15 +-
>  drivers/android/binder_alloc.h             |   6 +
>  drivers/android/binder_internal.h          |   4 +
>  drivers/android/tests/.kunitconfig         |   3 +
>  drivers/android/tests/Makefile             |   3 +
>  drivers/android/tests/binder_alloc_kunit.c | 166 +++++++++++++++++++++
>  9 files changed, 208 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/android/tests/.kunitconfig
>  create mode 100644 drivers/android/tests/Makefile
>  create mode 100644 drivers/android/tests/binder_alloc_kunit.c
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 07aa8ae0a058..b1bc7183366c 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -47,4 +47,15 @@ config ANDROID_BINDER_IPC_SELFTEST
>  	  exhaustively with combinations of various buffer sizes and
>  	  alignments.
>  
> +config ANDROID_BINDER_ALLOC_KUNIT_TEST
> +	tristate "KUnit Tests for Android Binder Alloc" if !KUNIT_ALL_TESTS
> +	depends on ANDROID_BINDER_IPC && KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This feature builds the binder alloc KUnit tests.
> +
> +	  Each test case runs using a pared-down binder_alloc struct and
> +	  test-specific freelist, which allows this KUnit module to be loaded
> +	  for testing without interfering with a running system.
> +
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c99c25..74d02a335d4e 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= tests/
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c463ca4a8fff..9dfe90c284fc 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -68,6 +68,8 @@
>  #include <linux/sizes.h>
>  #include <linux/ktime.h>
>  
> +#include <kunit/visibility.h>
> +
>  #include <uapi/linux/android/binder.h>
>  
>  #include <linux/cacheflush.h>
> @@ -5956,10 +5958,11 @@ static void binder_vma_close(struct vm_area_struct *vma)
>  	binder_alloc_vma_close(&proc->alloc);
>  }
>  
> -static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
> +VISIBLE_IF_KUNIT vm_fault_t binder_vm_fault(struct vm_fault *vmf)
>  {
>  	return VM_FAULT_SIGBUS;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_vm_fault);
>  
>  static const struct vm_operations_struct binder_vm_ops = {
>  	.open = binder_vma_open,
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 2e89f9127883..c79e5c6721f0 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -23,6 +23,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/highmem.h>
>  #include <linux/sizes.h>
> +#include <kunit/visibility.h>
>  #include "binder_alloc.h"
>  #include "binder_trace.h"
>  
> @@ -57,13 +58,14 @@ static struct binder_buffer *binder_buffer_prev(struct binder_buffer *buffer)
>  	return list_entry(buffer->entry.prev, struct binder_buffer, entry);
>  }
>  
> -static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> -				       struct binder_buffer *buffer)
> +VISIBLE_IF_KUNIT size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> +						 struct binder_buffer *buffer)
>  {
>  	if (list_is_last(&buffer->entry, &alloc->buffers))
>  		return alloc->vm_start + alloc->buffer_size - buffer->user_data;
>  	return binder_buffer_next(buffer)->user_data - buffer->user_data;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_buffer_size);
>  
>  static void binder_insert_free_buffer(struct binder_alloc *alloc,
>  				      struct binder_buffer *new_buffer)
> @@ -959,7 +961,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  			   failure_string, ret);
>  	return ret;
>  }
> -
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_mmap_handler);
>  
>  void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  {
> @@ -1028,6 +1030,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  		     "%s: %d buffers %d, pages %d\n",
>  		     __func__, alloc->pid, buffers, page_count);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_deferred_release);
>  
>  /**
>   * binder_alloc_print_allocated() - print buffer info
> @@ -1122,6 +1125,7 @@ void binder_alloc_vma_close(struct binder_alloc *alloc)
>  {
>  	binder_alloc_set_mapped(alloc, false);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_vma_close);
>  
>  /**
>   * binder_alloc_free_page() - shrinker callback to free pages
> @@ -1229,8 +1233,8 @@ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  
>  static struct shrinker *binder_shrinker;
>  
> -static void __binder_alloc_init(struct binder_alloc *alloc,
> -				struct list_lru *freelist)
> +VISIBLE_IF_KUNIT void __binder_alloc_init(struct binder_alloc *alloc,
> +					  struct list_lru *freelist)
>  {
>  	alloc->pid = current->group_leader->pid;
>  	alloc->mm = current->mm;
> @@ -1239,6 +1243,7 @@ static void __binder_alloc_init(struct binder_alloc *alloc,
>  	INIT_LIST_HEAD(&alloc->buffers);
>  	alloc->freelist = freelist;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(__binder_alloc_init);
>  
>  /**
>   * binder_alloc_init() - called by binder_open() for per-proc initialization
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index aa05a9df1360..dc8dce2469a7 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -188,5 +188,11 @@ int binder_alloc_copy_from_buffer(struct binder_alloc *alloc,
>  				  binder_size_t buffer_offset,
>  				  size_t bytes);
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void __binder_alloc_init(struct binder_alloc *alloc, struct list_lru *freelist);
> +size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> +				struct binder_buffer *buffer);
> +#endif
> +
>  #endif /* _LINUX_BINDER_ALLOC_H */
>  
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 1ba5caf1d88d..b5d3014fb4dc 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -592,4 +592,8 @@ void binder_add_device(struct binder_device *device);
>   */
>  void binder_remove_device(struct binder_device *device);
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +vm_fault_t binder_vm_fault(struct vm_fault *vmf);
> +#endif

I'm used to the "#ifdef CONFIG_..." idiom, but looking at the tree, I
see that "#if IS_ENANLED(CONFIG...)" is relatively common too. I don't
think there is a function difference, so I leave the style choice up to
you! ;)

> +
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/tests/.kunitconfig b/drivers/android/tests/.kunitconfig
> new file mode 100644
> index 000000000000..a73601231049
> --- /dev/null
> +++ b/drivers/android/tests/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_ANDROID_BINDER_IPC=y
> +CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=y
> diff --git a/drivers/android/tests/Makefile b/drivers/android/tests/Makefile
> new file mode 100644
> index 000000000000..6780967e573b
> --- /dev/null
> +++ b/drivers/android/tests/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= binder_alloc_kunit.o
> diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
> new file mode 100644
> index 000000000000..4b68b5687d33
> --- /dev/null
> +++ b/drivers/android/tests/binder_alloc_kunit.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for binder allocator code
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/err.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/sizes.h>
> +
> +#include "../binder_alloc.h"
> +#include "../binder_internal.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +#define BINDER_MMAP_SIZE SZ_128K
> +
> +struct binder_alloc_test {
> +	struct binder_alloc alloc;
> +	struct list_lru binder_test_freelist;
> +	struct file *filp;
> +	unsigned long mmap_uaddr;
> +};
> +
> +static void binder_alloc_test_init_freelist(struct kunit *test)
> +{
> +	struct binder_alloc_test *priv = test->priv;
> +
> +	KUNIT_EXPECT_PTR_EQ(test, priv->alloc.freelist,
> +			    &priv->binder_test_freelist);
> +}
> +
> +static void binder_alloc_test_mmap(struct kunit *test)
> +{
> +	struct binder_alloc_test *priv = test->priv;
> +	struct binder_alloc *alloc = &priv->alloc;
> +	struct binder_buffer *buf;
> +	struct rb_node *n;
> +
> +	KUNIT_EXPECT_EQ(test, alloc->mapped, true);
> +	KUNIT_EXPECT_EQ(test, alloc->buffer_size, BINDER_MMAP_SIZE);
> +
> +	n = rb_first(&alloc->allocated_buffers);
> +	KUNIT_EXPECT_PTR_EQ(test, n, NULL);
> +
> +	n = rb_first(&alloc->free_buffers);
> +	buf = rb_entry(n, struct binder_buffer, rb_node);
> +	KUNIT_EXPECT_EQ(test, binder_alloc_buffer_size(alloc, buf),
> +			BINDER_MMAP_SIZE);
> +	KUNIT_EXPECT_TRUE(test, list_is_last(&buf->entry, &alloc->buffers));
> +}
> +
> +/* ===== End test cases ===== */
> +
> +static void binder_alloc_test_vma_close(struct vm_area_struct *vma)
> +{
> +	struct binder_alloc *alloc = vma->vm_private_data;
> +
> +	binder_alloc_vma_close(alloc);
> +}
> +
> +static const struct vm_operations_struct binder_alloc_test_vm_ops = {
> +	.close = binder_alloc_test_vma_close,
> +	.fault = binder_vm_fault,
> +};
> +
> +static int binder_alloc_test_mmap_handler(struct file *filp,
> +					  struct vm_area_struct *vma)
> +{
> +	struct binder_alloc *alloc = filp->private_data;
> +
> +	vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP, VM_MAYWRITE);
> +
> +	vma->vm_ops = &binder_alloc_test_vm_ops;
> +	vma->vm_private_data = alloc;
> +
> +	return binder_alloc_mmap_handler(alloc, vma);
> +}
> +
> +static const struct file_operations binder_alloc_test_fops = {
> +	.mmap = binder_alloc_test_mmap_handler,
> +};
> +
> +static int binder_alloc_test_init(struct kunit *test)
> +{
> +	struct binder_alloc_test *priv;
> +	int ret;
> +
> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	test->priv = priv;
> +
> +	ret = list_lru_init(&priv->binder_test_freelist);
> +	if (ret) {
> +		kunit_err(test, "Failed to initialize test freelist\n");
> +		return ret;
> +	}
> +
> +	/* __binder_alloc_init requires mm to be attached */
> +	ret = kunit_attach_mm();
> +	if (ret) {
> +		kunit_err(test, "Failed to attach mm\n");
> +		return ret;
> +	}
> +	__binder_alloc_init(&priv->alloc, &priv->binder_test_freelist);
> +
> +	priv->filp = anon_inode_getfile("binder_alloc_kunit",
> +					&binder_alloc_test_fops, &priv->alloc,
> +					O_RDWR | O_CLOEXEC);
> +	if (IS_ERR_OR_NULL(priv->filp)) {
> +		kunit_err(test, "Failed to open binder alloc test driver file\n");
> +		return priv->filp ? PTR_ERR(priv->filp) : -ENOMEM;
> +	}
> +
> +	priv->mmap_uaddr = kunit_vm_mmap(test, priv->filp, 0, BINDER_MMAP_SIZE,
> +					 PROT_READ, MAP_PRIVATE | MAP_NORESERVE,
> +					 0);
> +	if (!priv->mmap_uaddr) {
> +		kunit_err(test, "Could not map the test's transaction memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void binder_alloc_test_exit(struct kunit *test)
> +{
> +	struct binder_alloc_test *priv = test->priv;
> +
> +	/* Close the backing file to make sure binder_alloc_vma_close runs */
> +	if (!IS_ERR_OR_NULL(priv->filp))
> +		fput(priv->filp);
> +
> +	if (priv->alloc.mm)
> +		binder_alloc_deferred_release(&priv->alloc);
> +
> +	/* Make sure freelist is empty */
> +	KUNIT_EXPECT_EQ(test, list_lru_count(&priv->binder_test_freelist), 0);
> +	list_lru_destroy(&priv->binder_test_freelist);
> +}
> +
> +static struct kunit_case binder_alloc_test_cases[] = {
> +	KUNIT_CASE(binder_alloc_test_init_freelist),
> +	KUNIT_CASE(binder_alloc_test_mmap),
> +	{}
> +};
> +
> +static struct kunit_suite binder_alloc_test_suite = {
> +	.name = "binder_alloc",
> +	.test_cases = binder_alloc_test_cases,
> +	.init = binder_alloc_test_init,
> +	.exit = binder_alloc_test_exit,
> +};
> +
> +kunit_test_suite(binder_alloc_test_suite);
> +
> +MODULE_AUTHOR("Tiffany Yang <ynaffit@google.com>");
> +MODULE_DESCRIPTION("Binder Alloc KUnit tests");
> +MODULE_LICENSE("GPL");

Reviewed-by: Kees Cook <kees@kernel.org>


-- 
Kees Cook

