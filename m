Return-Path: <linux-kselftest+bounces-36211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F909AF03E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3BF1C2101D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9127EFFF;
	Tue,  1 Jul 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlgQ8Qsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1D214A6E
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398686; cv=none; b=g5XetUqpHYoFfsA5noUJoWPbwlnBeSj7MSS4ktdAgLllwo3G8dHbsb8gXD5FXnXu4p13oQ10ARSptGdc6jGGrgRMx/wWWuGd/YYJMLP72K1VmHZac3s7rXoe2i11MTUUJsvA4Mh+5np+wl5+G8v9qAWCNBsy19DF2O0CMJK2P0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398686; c=relaxed/simple;
	bh=/lK0+qtB+epXNXVi910JA9jCw4TFXXOULdsayjFiHJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLunMrZP1h2QcfToN2b+KGyaSij1mVz8m8G+da22yPqle9kfKOGJQsKdAZIsL5AZ3zr0FLmfuEer8bBp0/QTsykUQuoa0LnIuSAOGDxbr5hBk8ZPZMe4piy/37rU1JMDRMPhWIaE9DIWxIvfCifiVr9mV/An/wRoCmoCo3rus/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlgQ8Qsr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6facba680a1so45530416d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751398683; x=1752003483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27d5UOVKtmUDtEAp0ADASEkYYcjYFsb0lXgD4PRdwFA=;
        b=hlgQ8QsrOQD0tPv6zDbEn83kD1hcRXGTbvpxuWdR2rLuyF77f/Yb2uN+HtuToauRgN
         N/vaL+KirQgHyJsEv6hStP/8VfTkG3wZSJNArHAsQ4Lh2DmvgB3hj9kOsWVWPL8PUl+Y
         OuDoaa76Dc2NshL/EN7IIDsVeBn08tsFKDRZomd9wcVTM0Swrug3nJBB9PuzYXo3gCZo
         smgLXEs+n3qHzB43DTH679uyZe3bDeOKyjpfjvKTfuYALv8DzcIoO2lvywReOO/RwAlf
         OizydkOCiAN055dR0UONTXySryBMZ/pf+3n6SOcywkHPGvwCFSNrIkFMpi9seR4Rl0eD
         z+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398683; x=1752003483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27d5UOVKtmUDtEAp0ADASEkYYcjYFsb0lXgD4PRdwFA=;
        b=KVcjPsIRzYhub7ijRXZRIMQR+NOAy/EGZOOXu1CAFfF6yig0KlcUG1paK1/tVaig7a
         FNaj4NuFRCJS0a2Ph6X1xoHZebwAhITl7AMJbsJxbUWZrrOEpGkNowRZbz+gxmlLERhL
         ZNweEnf0fu3rDj1RpqzKYZ3w5crmrKy2CqJUlTXjrLr8Xk9/GfgLzkiFXlmqNSzFSuvP
         /MzDj0aUiXCbO9ix2f0NPGYUo2Fx2sbWAK/2iKd4q/IP7KIQYsdlk1ciIagnLjxMwD3L
         //kEsecyfMTb9amXaRrUrTwHxb2VLPSmz+IVMrxP7VGDiaXfb7JwWcZSiKdEXDvNEPXh
         mu3A==
X-Forwarded-Encrypted: i=1; AJvYcCVzWTYrUdebvqJKbMAZt28VXls9p0mdGf8kBbMkiAGUjqssc6QBc4rLK6+G3HJJ4J/5sqDBAXa4RHUbTp4SOoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYgOIsSLbCuQD/7VOWkzsU3ZyUrF53xpbHPs+YtoOavHNyUUJ
	qZ0rZt5oQWjEUEsxvNsOYIyUEiAY0vVJJEegApzuHQGwC3heSMPK8aTfW+OuUh00eyAECdYvcdH
	YI4Q2VzOOWRfsn+Lvb0IgWPgoLhEIPYcnt872TfUu
X-Gm-Gg: ASbGncvoPS3szZ6rTNJtodxT5jOJuMjIeKgsgn98FaIhXljTw644lsHJWyS7zuU/h3u
	ugyM+n/D0EAYAmlRXadabh8o3ScK9yzaTNrJTf3Ytm4stwt0qzuyY1F66yZya97pZL4kjs097MS
	RSuB6MimUuSReinAqGfoCrc+moy20ZeQBaY4jfzAXXUG+Y1D1h6IGtkb7uKI41SvLn+/ovnTV+Y
	g==
X-Google-Smtp-Source: AGHT+IFz7T2uE8dy5m5GbgnwVJKSFJA9QIy2PcPgBqOkm6cOGfLOrvTYDxmXiYflYuiPwALuCcLpbxfwruVZMtMFPHU=
X-Received: by 2002:a05:6214:2aae:b0:6fa:c41e:cc6c with SMTP id
 6a1803df08f44-70002dec8ccmr307945216d6.15.1751398682506; Tue, 01 Jul 2025
 12:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627203748.881022-1-ynaffit@google.com> <20250627203748.881022-4-ynaffit@google.com>
In-Reply-To: <20250627203748.881022-4-ynaffit@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 1 Jul 2025 15:37:51 -0400
X-Gm-Features: Ac12FXyiQxpwMy3Ou_goXXRYDwkBDqJMpZvPHPmZb_Q_6w8ri7WriIsTyrmWiGg
Message-ID: <CA+GJov7QJWtWkOj3vg5HD+mibqQ78gyWg34umL1u1FMOfnQBWw@mail.gmail.com>
Subject: Re: [PATCH 3/5] binder: Scaffolding for binder_alloc KUnit tests
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:38=E2=80=AFPM Tiffany Yang <ynaffit@google.com> w=
rote:
>
> Add setup and teardown for testing binder allocator code with KUnit.
> Include minimal test cases to verify that tests are initialized
> correctly.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
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
>  include/kunit/test.h                       |  12 ++
>  lib/kunit/user_alloc.c                     |   4 +-
>  11 files changed, 222 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/android/tests/.kunitconfig
>  create mode 100644 drivers/android/tests/Makefile
>  create mode 100644 drivers/android/tests/binder_alloc_kunit.c
>
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 07aa8ae0a058..b1bc7183366c 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -47,4 +47,15 @@ config ANDROID_BINDER_IPC_SELFTEST
>           exhaustively with combinations of various buffer sizes and
>           alignments.
>
> +config ANDROID_BINDER_ALLOC_KUNIT_TEST
> +       tristate "KUnit Tests for Android Binder Alloc" if !KUNIT_ALL_TES=
TS
> +       depends on ANDROID_BINDER_IPC && KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This feature builds the binder alloc KUnit tests.
> +
> +         Each test case runs using a pared-down binder_alloc struct and
> +         test-specific freelist, which allows this KUnit module to be lo=
aded
> +         for testing without interfering with a running system.
> +
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c99c25..74d02a335d4e 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y +=3D -I$(src)                   # needed for tr=
ace events
>  obj-$(CONFIG_ANDROID_BINDERFS)         +=3D binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)       +=3D binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) +=3D binder_alloc_selftest.o
> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)  +=3D tests/
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
> @@ -5956,10 +5958,11 @@ static void binder_vma_close(struct vm_area_struc=
t *vma)
>         binder_alloc_vma_close(&proc->alloc);
>  }
>
> -static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
> +VISIBLE_IF_KUNIT vm_fault_t binder_vm_fault(struct vm_fault *vmf)
>  {
>         return VM_FAULT_SIGBUS;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_vm_fault);
>
>  static const struct vm_operations_struct binder_vm_ops =3D {
>         .open =3D binder_vma_open,
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
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
> @@ -57,13 +58,14 @@ static struct binder_buffer *binder_buffer_prev(struc=
t binder_buffer *buffer)
>         return list_entry(buffer->entry.prev, struct binder_buffer, entry=
);
>  }
>
> -static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> -                                      struct binder_buffer *buffer)
> +VISIBLE_IF_KUNIT size_t binder_alloc_buffer_size(struct binder_alloc *al=
loc,
> +                                                struct binder_buffer *bu=
ffer)
>  {
>         if (list_is_last(&buffer->entry, &alloc->buffers))
>                 return alloc->vm_start + alloc->buffer_size - buffer->use=
r_data;
>         return binder_buffer_next(buffer)->user_data - buffer->user_data;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_buffer_size);
>
>  static void binder_insert_free_buffer(struct binder_alloc *alloc,
>                                       struct binder_buffer *new_buffer)
> @@ -959,7 +961,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *al=
loc,
>                            failure_string, ret);
>         return ret;
>  }
> -
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_mmap_handler);
>
>  void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  {
> @@ -1028,6 +1030,7 @@ void binder_alloc_deferred_release(struct binder_al=
loc *alloc)
>                      "%s: %d buffers %d, pages %d\n",
>                      __func__, alloc->pid, buffers, page_count);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_deferred_release);
>
>  /**
>   * binder_alloc_print_allocated() - print buffer info
> @@ -1122,6 +1125,7 @@ void binder_alloc_vma_close(struct binder_alloc *al=
loc)
>  {
>         binder_alloc_set_mapped(alloc, false);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(binder_alloc_vma_close);
>
>  /**
>   * binder_alloc_free_page() - shrinker callback to free pages
> @@ -1229,8 +1233,8 @@ binder_shrink_scan(struct shrinker *shrink, struct =
shrink_control *sc)
>
>  static struct shrinker *binder_shrinker;
>
> -static void __binder_alloc_init(struct binder_alloc *alloc,
> -                               struct list_lru *freelist)
> +VISIBLE_IF_KUNIT void __binder_alloc_init(struct binder_alloc *alloc,
> +                                         struct list_lru *freelist)
>  {
>         alloc->pid =3D current->group_leader->pid;
>         alloc->mm =3D current->mm;
> @@ -1239,6 +1243,7 @@ static void __binder_alloc_init(struct binder_alloc=
 *alloc,
>         INIT_LIST_HEAD(&alloc->buffers);
>         alloc->freelist =3D freelist;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(__binder_alloc_init);
>
>  /**
>   * binder_alloc_init() - called by binder_open() for per-proc initializa=
tion
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_allo=
c.h
> index aa05a9df1360..dc8dce2469a7 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -188,5 +188,11 @@ int binder_alloc_copy_from_buffer(struct binder_allo=
c *alloc,
>                                   binder_size_t buffer_offset,
>                                   size_t bytes);
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void __binder_alloc_init(struct binder_alloc *alloc, struct list_lru *fr=
eelist);
> +size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
> +                               struct binder_buffer *buffer);
> +#endif
> +
>  #endif /* _LINUX_BINDER_ALLOC_H */
>
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_i=
nternal.h
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
> diff --git a/drivers/android/tests/.kunitconfig b/drivers/android/tests/.=
kunitconfig
> new file mode 100644
> index 000000000000..a73601231049
> --- /dev/null
> +++ b/drivers/android/tests/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_ANDROID_BINDER_IPC=3Dy
> +CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=3Dy
> diff --git a/drivers/android/tests/Makefile b/drivers/android/tests/Makef=
ile
> new file mode 100644
> index 000000000000..6780967e573b
> --- /dev/null
> +++ b/drivers/android/tests/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)  +=3D binder_alloc_kunit.o
> diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android=
/tests/binder_alloc_kunit.c
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
> +       struct binder_alloc alloc;
> +       struct list_lru binder_test_freelist;
> +       struct file *filp;
> +       unsigned long mmap_uaddr;
> +};
> +
> +static void binder_alloc_test_init_freelist(struct kunit *test)
> +{
> +       struct binder_alloc_test *priv =3D test->priv;
> +
> +       KUNIT_EXPECT_PTR_EQ(test, priv->alloc.freelist,
> +                           &priv->binder_test_freelist);
> +}
> +
> +static void binder_alloc_test_mmap(struct kunit *test)
> +{
> +       struct binder_alloc_test *priv =3D test->priv;
> +       struct binder_alloc *alloc =3D &priv->alloc;
> +       struct binder_buffer *buf;
> +       struct rb_node *n;
> +
> +       KUNIT_EXPECT_EQ(test, alloc->mapped, true);
> +       KUNIT_EXPECT_EQ(test, alloc->buffer_size, BINDER_MMAP_SIZE);
> +
> +       n =3D rb_first(&alloc->allocated_buffers);
> +       KUNIT_EXPECT_PTR_EQ(test, n, NULL);
> +
> +       n =3D rb_first(&alloc->free_buffers);
> +       buf =3D rb_entry(n, struct binder_buffer, rb_node);
> +       KUNIT_EXPECT_EQ(test, binder_alloc_buffer_size(alloc, buf),
> +                       BINDER_MMAP_SIZE);
> +       KUNIT_EXPECT_TRUE(test, list_is_last(&buf->entry, &alloc->buffers=
));
> +}
> +
> +/* =3D=3D=3D=3D=3D End test cases =3D=3D=3D=3D=3D */
> +
> +static void binder_alloc_test_vma_close(struct vm_area_struct *vma)
> +{
> +       struct binder_alloc *alloc =3D vma->vm_private_data;
> +
> +       binder_alloc_vma_close(alloc);
> +}
> +
> +static const struct vm_operations_struct binder_alloc_test_vm_ops =3D {
> +       .close =3D binder_alloc_test_vma_close,
> +       .fault =3D binder_vm_fault,
> +};
> +
> +static int binder_alloc_test_mmap_handler(struct file *filp,
> +                                         struct vm_area_struct *vma)
> +{
> +       struct binder_alloc *alloc =3D filp->private_data;
> +
> +       vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP, VM_MAYWRITE);
> +
> +       vma->vm_ops =3D &binder_alloc_test_vm_ops;
> +       vma->vm_private_data =3D alloc;
> +
> +       return binder_alloc_mmap_handler(alloc, vma);
> +}
> +
> +static const struct file_operations binder_alloc_test_fops =3D {
> +       .mmap =3D binder_alloc_test_mmap_handler,
> +};
> +
> +static int binder_alloc_test_init(struct kunit *test)
> +{
> +       struct binder_alloc_test *priv;
> +       int ret;
> +
> +       priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       test->priv =3D priv;
> +
> +       ret =3D list_lru_init(&priv->binder_test_freelist);
> +       if (ret) {
> +               kunit_err(test, "Failed to initialize test freelist\n");
> +               return ret;
> +       }
> +
> +       /* __binder_alloc_init requires mm to be attached */
> +       ret =3D kunit_attach_mm();
> +       if (ret) {
> +               kunit_err(test, "Failed to attach mm\n");
> +               return ret;
> +       }
> +       __binder_alloc_init(&priv->alloc, &priv->binder_test_freelist);
> +
> +       priv->filp =3D anon_inode_getfile("binder_alloc_kunit",
> +                                       &binder_alloc_test_fops, &priv->a=
lloc,
> +                                       O_RDWR | O_CLOEXEC);
> +       if (IS_ERR_OR_NULL(priv->filp)) {
> +               kunit_err(test, "Failed to open binder alloc test driver =
file\n");
> +               return priv->filp ? PTR_ERR(priv->filp) : -ENOMEM;
> +       }
> +
> +       priv->mmap_uaddr =3D kunit_vm_mmap(test, priv->filp, 0, BINDER_MM=
AP_SIZE,
> +                                        PROT_READ, MAP_PRIVATE | MAP_NOR=
ESERVE,
> +                                        0);
> +       if (!priv->mmap_uaddr) {
> +               kunit_err(test, "Could not map the test's transaction mem=
ory\n");
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void binder_alloc_test_exit(struct kunit *test)
> +{
> +       struct binder_alloc_test *priv =3D test->priv;
> +
> +       /* Close the backing file to make sure binder_alloc_vma_close run=
s */
> +       if (!IS_ERR_OR_NULL(priv->filp))
> +               fput(priv->filp);
> +
> +       if (priv->alloc.mm)
> +               binder_alloc_deferred_release(&priv->alloc);
> +
> +       /* Make sure freelist is empty */
> +       KUNIT_EXPECT_EQ(test, list_lru_count(&priv->binder_test_freelist)=
, 0);
> +       list_lru_destroy(&priv->binder_test_freelist);
> +}
> +
> +static struct kunit_case binder_alloc_test_cases[] =3D {
> +       KUNIT_CASE(binder_alloc_test_init_freelist),
> +       KUNIT_CASE(binder_alloc_test_mmap),
> +       {}
> +};
> +
> +static struct kunit_suite binder_alloc_test_suite =3D {
> +       .name =3D "binder_alloc",
> +       .test_cases =3D binder_alloc_test_cases,
> +       .init =3D binder_alloc_test_init,
> +       .exit =3D binder_alloc_test_exit,
> +};
> +
> +kunit_test_suite(binder_alloc_test_suite);
> +
> +MODULE_AUTHOR("Tiffany Yang <ynaffit@google.com>");
> +MODULE_DESCRIPTION("Binder Alloc KUnit tests");
> +MODULE_LICENSE("GPL");
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..d958ee53050e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -531,6 +531,18 @@ static inline char *kunit_kstrdup(struct kunit *test=
, const char *str, gfp_t gfp
>   */
>  const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp=
_t gfp);
>
> +/**
> + * kunit_attach_mm() - Create and attach a new mm if it doesn't already =
exist.
> + *
> + * Allocates a &struct mm_struct and attaches it to @current. In most ca=
ses, call
> + * kunit_vm_mmap() without calling kunit_attach_mm() directly. Only nece=
ssary when
> + * code under test accesses the mm before executing the mmap (e.g., to p=
erform
> + * additional initialization beforehand).
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int kunit_attach_mm(void);
> +
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
>   * @test: The test context object.
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 46951be018be..b8cac765e620 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -22,8 +22,7 @@ struct kunit_vm_mmap_params {
>         unsigned long offset;
>  };
>
> -/* Create and attach a new mm if it doesn't already exist. */
> -static int kunit_attach_mm(void)
> +int kunit_attach_mm(void)
>  {
>         struct mm_struct *mm;
>
> @@ -49,6 +48,7 @@ static int kunit_attach_mm(void)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(kunit_attach_mm);
>
>  static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
>  {
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

These KUnit changes to include/kunit/test.h and lib/kunit/user_alloc.c
seem ok to me. I also tested this and it seems to be running well.

Tested-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

