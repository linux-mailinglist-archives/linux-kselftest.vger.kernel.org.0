Return-Path: <linux-kselftest+bounces-37323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35110B05081
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B5E7B37FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 04:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF252D322E;
	Tue, 15 Jul 2025 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiQcCPQe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD02D29D7
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555157; cv=none; b=HLNh5rMfGyct/EGGWuoUmmDwkyBgfJQQU4/dl634YEpZ8eGVu1lo/+wFfO+pQbSrn1zKWOqOIv+NIQYZmEBQfOwT1lAIGvRbWsBB+fsjvTa9BMECASUJ03rnn4tyUiGySgo9kAX6fntI/63xxOvPNDnNpbfabh5+3+Ot5rdqen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555157; c=relaxed/simple;
	bh=JkaxyeHzZuxCzJgdXQLQ7lGLoi7LnccpJWKZulqQwcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj8fZv4+pkTiBF/BxGV1paxS//IxjJCvJhmjfp11R7Shm6SX+ZaQVmXSKzNtJZwXhB4laJcZRBXqhrslK1SyHLeuA3aJ7y4aYAcUqo9+Q7riC7u3NNaQNoPFXucbb1zFgtA7h0yUMcJ+XY4eEDH5viNNflPANO1nJeOnJ1rOp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiQcCPQe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso237971cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555155; x=1753159955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhLZU4T8oc82ODyYIHfSeZVkndS6t19cTBum9oo+V4A=;
        b=GiQcCPQehuHaCSzb3s6Fj1dGL3atSHUllR8POfYK8iAvcFMAPR2jANlgVt2leOU5x0
         ofF+aZm87IYz1O8B+DHtu5JvSbNFlkLV4i7w5rfZOHAmZelrXmkxaqGhMTi5trylEH5N
         anLMS09pCF6DIlrf3ubhbvzV6BQbrLoY2MgTde7f4Ze8CVyxedvXIJshYxTQUNygLgD5
         M2G/OkJK572Rs+0sY7gdD1wAYn1aCY7n6ZEhYDJ0GtYCuc4FxfEP0VEiK6Yd82alAORH
         v8UETKkoZdyNVnEzQDEiHZf4TPtFbr8o6dGAJ4RzSaYl008uqvoel4DTVncFU8FbpsfZ
         YSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555155; x=1753159955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhLZU4T8oc82ODyYIHfSeZVkndS6t19cTBum9oo+V4A=;
        b=uwta6Ltl9czCfXuIJAibTt0gUKw1xUse+A2lFfzGnlrylqM/FMp92dWhr+s3tf3uEm
         G0e0GS+Dx0r7FfGb3SBXHw6q3cTT9FGPXuCI76VPsjr+i5V41ppxZC7JbrqowM9l+0CD
         5kvTZsgi63IeiKSDKJIeUA0vJ7HUhHIE/VoEb8fFZoewOdOQr6TOQl+i2GWLRwrfiL2c
         E4ISR1ZDSdTojH9s5fPHQA/NKcY2QxETqNxmjPShDj9h/zdO1sRIKK6ErYFH+D/iS3AL
         F2LA4ID3Z33sIXvG6eIRHZ2giPSuEu/miLXX1suuZRoKKWwU3kUsIbRSMrnAuopvcTG5
         6mUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVntUQXt1mIFF6JA7Hgh3Ilj8HJFZA5YU+V/zXn1KI33XTv9L2H945u507yvyYzm8J144wkSAe1DeVUUd4zCXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYCHnR7ctwstD0LkMoiZXQkknoDzMMyXUWmHWy5GYKISwP/GE
	1k23o3G0/w3EO+Nf8FxG+r8Zh7+8/Zw0fOtK5T7nIHrz/wgxeMB/y49pb36RbSyztjeBi5Sb6sS
	phtPHHbt4+VYsqwCRgttkm8Tb7DVI2Z0/BM5JoPuy
X-Gm-Gg: ASbGncvWjlgmG5z1r3arPv1zMLjhwabG0j5QuEMAR9JoZhk47y1oigFC+qProld0QAF
	kf+gMgOQZy8X+zyqL5EIuk7+WfX6XTYPIQ5Lb14wQs6OHT5kSJidpCu5mFf1yUTglBATfsWyqE2
	x7tHBwB5bK7QU5BZm48dL41UHeY1BBxhYD+jJru8+CjC6oBYwqz4Nz95qSH2cfR7tkfCGaOR5eh
	y1YjQ==
X-Google-Smtp-Source: AGHT+IHvey9Hp0YbvtvU++Wj9RMeM2EK50vfB0lcTTC6fjGKp9QHBsZ4UIqCO9O+WPPQf+rNQBzQ/bXeDa2TfIjzPSk=
X-Received: by 2002:a05:622a:830e:b0:4a7:ff6d:e956 with SMTP id
 d75a77b69052e-4ab827a3f63mr1391471cf.3.1752555154400; Mon, 14 Jul 2025
 21:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-5-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-5-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:21 -0700
X-Gm-Features: Ac12FXyx7S6bOnI_GL57P5Et4O7RQgNZQ3kD3EjyR_larfLfGwSUuYz6loxz07c
Message-ID: <CAFuZdDLD=3CBOLSWw3VxCf7Nkf884SSNmt1wresQgxgBwED=eQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] binder: Scaffolding for binder_alloc KUnit tests
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

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
>         exhaustively with combinations of various buffer sizes and
>         alignments.
>
> +config ANDROID_BINDER_ALLOC_KUNIT_TEST

I think is OK to have "alloc" in the name. However, this is probably
going to grow into just "binder" at some point (hopefully). Then we can
just rename the kunit config as such.

> +     tristate "KUnit Tests for Android Binder Alloc" if !KUNIT_ALL_TESTS
> +     depends on ANDROID_BINDER_IPC && KUNIT
> +     default KUNIT_ALL_TESTS
> +     help
> +       This feature builds the binder alloc KUnit tests.
> +
> +       Each test case runs using a pared-down binder_alloc struct and
> +       test-specific freelist, which allows this KUnit module to be loaded
> +       for testing without interfering with a running system.
> +
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c99c25..74d02a335d4e 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)                 # needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)               += binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)     += binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)        += tests/
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
>       binder_alloc_vma_close(&proc->alloc);
>  }
>
> -static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
> +VISIBLE_IF_KUNIT vm_fault_t binder_vm_fault(struct vm_fault *vmf)
>  {
>       return VM_FAULT_SIGBUS;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_vm_fault);
>
>  static const struct vm_operations_struct binder_vm_ops = {
>       .open = binder_vma_open,
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
>       return list_entry(buffer->entry.prev, struct binder_buffer, entry);
>  }
>
> -static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> -                                    struct binder_buffer *buffer)
> +VISIBLE_IF_KUNIT size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> +                                              struct binder_buffer *buffer)
>  {
>       if (list_is_last(&buffer->entry, &alloc->buffers))
>               return alloc->vm_start + alloc->buffer_size - buffer->user_data;
>       return binder_buffer_next(buffer)->user_data - buffer->user_data;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_buffer_size);
>
>  static void binder_insert_free_buffer(struct binder_alloc *alloc,
>                                     struct binder_buffer *new_buffer)
> @@ -959,7 +961,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>                          failure_string, ret);
>       return ret;
>  }
> -
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_mmap_handler);
>
>  void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  {
> @@ -1028,6 +1030,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>                    "%s: %d buffers %d, pages %d\n",
>                    __func__, alloc->pid, buffers, page_count);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_deferred_release);
>
>  /**
>   * binder_alloc_print_allocated() - print buffer info
> @@ -1122,6 +1125,7 @@ void binder_alloc_vma_close(struct binder_alloc *alloc)
>  {
>       binder_alloc_set_mapped(alloc, false);
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
> -                             struct list_lru *freelist)
> +VISIBLE_IF_KUNIT void __binder_alloc_init(struct binder_alloc *alloc,
> +                                       struct list_lru *freelist)
>  {
>       alloc->pid = current->group_leader->pid;
>       alloc->mm = current->mm;
> @@ -1239,6 +1243,7 @@ static void __binder_alloc_init(struct binder_alloc *alloc,
>       INIT_LIST_HEAD(&alloc->buffers);
>       alloc->freelist = freelist;
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
>                                 binder_size_t buffer_offset,
>                                 size_t bytes);
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void __binder_alloc_init(struct binder_alloc *alloc, struct list_lru *freelist);
> +size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> +                             struct binder_buffer *buffer);
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

All the new files need the copyright notice. Something like:
        "Copyright 2025 Google LCC"

> +
> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)        += binder_alloc_kunit.o
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
> +     struct binder_alloc alloc;
> +     struct list_lru binder_test_freelist;
> +     struct file *filp;
> +     unsigned long mmap_uaddr;
> +};
> +
> +static void binder_alloc_test_init_freelist(struct kunit *test)
> +{
> +     struct binder_alloc_test *priv = test->priv;
> +
> +     KUNIT_EXPECT_PTR_EQ(test, priv->alloc.freelist,
> +                         &priv->binder_test_freelist);
> +}
> +
> +static void binder_alloc_test_mmap(struct kunit *test)
> +{
> +     struct binder_alloc_test *priv = test->priv;
> +     struct binder_alloc *alloc = &priv->alloc;
> +     struct binder_buffer *buf;
> +     struct rb_node *n;
> +
> +     KUNIT_EXPECT_EQ(test, alloc->mapped, true);
> +     KUNIT_EXPECT_EQ(test, alloc->buffer_size, BINDER_MMAP_SIZE);
> +
> +     n = rb_first(&alloc->allocated_buffers);
> +     KUNIT_EXPECT_PTR_EQ(test, n, NULL);
> +
> +     n = rb_first(&alloc->free_buffers);
> +     buf = rb_entry(n, struct binder_buffer, rb_node);
> +     KUNIT_EXPECT_EQ(test, binder_alloc_buffer_size(alloc, buf),
> +                     BINDER_MMAP_SIZE);
> +     KUNIT_EXPECT_TRUE(test, list_is_last(&buf->entry, &alloc->buffers));
> +}
> +
> +/* ===== End test cases ===== */
> +
> +static void binder_alloc_test_vma_close(struct vm_area_struct *vma)
> +{
> +     struct binder_alloc *alloc = vma->vm_private_data;
> +
> +     binder_alloc_vma_close(alloc);
> +}
> +
> +static const struct vm_operations_struct binder_alloc_test_vm_ops = {
> +     .close = binder_alloc_test_vma_close,
> +     .fault = binder_vm_fault,
> +};
> +
> +static int binder_alloc_test_mmap_handler(struct file *filp,
> +                                       struct vm_area_struct *vma)
> +{
> +     struct binder_alloc *alloc = filp->private_data;
> +
> +     vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP, VM_MAYWRITE);
> +
> +     vma->vm_ops = &binder_alloc_test_vm_ops;
> +     vma->vm_private_data = alloc;
> +
> +     return binder_alloc_mmap_handler(alloc, vma);
> +}
> +
> +static const struct file_operations binder_alloc_test_fops = {
> +     .mmap = binder_alloc_test_mmap_handler,
> +};
> +
> +static int binder_alloc_test_init(struct kunit *test)
> +{
> +     struct binder_alloc_test *priv;
> +     int ret;
> +
> +     priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +     if (!priv)
> +             return -ENOMEM;
> +     test->priv = priv;
> +
> +     ret = list_lru_init(&priv->binder_test_freelist);
> +     if (ret) {
> +             kunit_err(test, "Failed to initialize test freelist\n");
> +             return ret;
> +     }
> +
> +     /* __binder_alloc_init requires mm to be attached */
> +     ret = kunit_attach_mm();
> +     if (ret) {
> +             kunit_err(test, "Failed to attach mm\n");
> +             return ret;
> +     }
> +     __binder_alloc_init(&priv->alloc, &priv->binder_test_freelist);
> +
> +     priv->filp = anon_inode_getfile("binder_alloc_kunit",
> +                                     &binder_alloc_test_fops, &priv->alloc,
> +                                     O_RDWR | O_CLOEXEC);
> +     if (IS_ERR_OR_NULL(priv->filp)) {
> +             kunit_err(test, "Failed to open binder alloc test driver file\n");
> +             return priv->filp ? PTR_ERR(priv->filp) : -ENOMEM;
> +     }
> +
> +     priv->mmap_uaddr = kunit_vm_mmap(test, priv->filp, 0, BINDER_MMAP_SIZE,
> +                                      PROT_READ, MAP_PRIVATE | MAP_NORESERVE,
> +                                      0);
> +     if (!priv->mmap_uaddr) {
> +             kunit_err(test, "Could not map the test's transaction memory\n");
> +             return -ENOMEM;
> +     }
> +
> +     return 0;
> +}
> +
> +static void binder_alloc_test_exit(struct kunit *test)
> +{
> +     struct binder_alloc_test *priv = test->priv;
> +
> +     /* Close the backing file to make sure binder_alloc_vma_close runs */
> +     if (!IS_ERR_OR_NULL(priv->filp))
> +             fput(priv->filp);
> +
> +     if (priv->alloc.mm)
> +             binder_alloc_deferred_release(&priv->alloc);
> +
> +     /* Make sure freelist is empty */
> +     KUNIT_EXPECT_EQ(test, list_lru_count(&priv->binder_test_freelist), 0);
> +     list_lru_destroy(&priv->binder_test_freelist);
> +}
> +
> +static struct kunit_case binder_alloc_test_cases[] = {
> +     KUNIT_CASE(binder_alloc_test_init_freelist),
> +     KUNIT_CASE(binder_alloc_test_mmap),
> +     {}
> +};
> +
> +static struct kunit_suite binder_alloc_test_suite = {
> +     .name = "binder_alloc",
> +     .test_cases = binder_alloc_test_cases,
> +     .init = binder_alloc_test_init,
> +     .exit = binder_alloc_test_exit,
> +};
> +
> +kunit_test_suite(binder_alloc_test_suite);
> +
> +MODULE_AUTHOR("Tiffany Yang <ynaffit@google.com>");
> +MODULE_DESCRIPTION("Binder Alloc KUnit tests");
> +MODULE_LICENSE("GPL");
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

Aside from the missing Copyright, feel free to add:

Acked-by: Carlos Llamas <cmllamas@google.com>

