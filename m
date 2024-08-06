Return-Path: <linux-kselftest+bounces-14822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB22394869D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 02:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E44B1F21A0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401F1FA5;
	Tue,  6 Aug 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhMFzdTm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9210F1
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903810; cv=none; b=izYt8cdaHc9t2VLVVxL8Zi2K3MrlSaopd8+nqIntNMAHNt02bG8Ur0p5dQZQ33hn23v4sztBr7gG1ibSnDixaFf8N6IsMO6H5F8Y+CClHGIWK86MMgtYgT77PHtmkpgkQ96GpLsuMAt4Fq3M3jPQHtQKXx2ObNWOy72S7Nc8tpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903810; c=relaxed/simple;
	bh=Y4thmYZAfoMzC1yfRsLinoQGaj8/a37spieo1hFhhfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h15V6itdCgVQXGS8GkJ3ioiok047Wpf03AKQAu8hRcqH+sG5EXm+Y+iU+X5WqAjSlRCkjXhkEk0MApREwSVkpYCZX6ctXq6G+QJnXaY0wl6Wiqf1H3RKYOTeJVeefkCGYWVBeMWbN3GFu43FR6ZbL77WZKnBccxNfgfMRyJX0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhMFzdTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722903807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJlfPXtmMFFW1men+UhmIi3WVByyjRhzXx3BjNaIlwg=;
	b=WhMFzdTmBvlaxxkvJw/Utjb6KXs2tYzXXJy9PztM6JSGlVbPsbp405sN8YyauSKcs7dwzj
	UMCo1J8hkvX/LhmcG3XdTwtdtuoIvn5z57OEEfFvVjoCR0yTSHdI1EeynV1lQsoPaKO006
	/MDChccaAZKOJihh+Izecxi8WQILTyk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-dyxELAZIMGKFDzwHE1DDvw-1; Mon, 05 Aug 2024 20:23:25 -0400
X-MC-Unique: dyxELAZIMGKFDzwHE1DDvw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-68f95e37bbfso2048427b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 17:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903805; x=1723508605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJlfPXtmMFFW1men+UhmIi3WVByyjRhzXx3BjNaIlwg=;
        b=C4yBQZ18yndn8WuybB/pkE573rnWV1lYwhlOF+aR9xpriNDhtlEumnkvAtwU3eATYU
         sQS6bHp+aCq5Z9EHuvvdQ1mA05pD2/gJE2RLFMp6q1sj/NznuS/3/X+22MyfdUUhV69i
         dZT1btLFwA0l3a0VuwySaYmn6ZYCFib27bTrIGf8YyUr19Y1tGscxkBmd7TR1N2YYGkw
         5O1LlkYJ/YTBLFplzjyIna3JRZ/j+8xW1yf0PlwALEF75GPs8tCoeX/PuDZ3WMNmeKo6
         /MaABXr7jvqBn3hvj38LcSLDaHX1JuoestQYU6+atxb3ZBRy2sal8J8F67mszM807AU0
         Jf+g==
X-Forwarded-Encrypted: i=1; AJvYcCUKxWXf3M8/SgPuHcB9YwZ7lFMRvec/ru3HJSzRHlaXW2lqC6tBUgDYrl/6dbQo+9WwIVYfrxAjA33JErwfcyHcZJTUL+2dInO5hC0TNLpR
X-Gm-Message-State: AOJu0YznR3CVBGCNwWxkH+7rq934rp9kfQzFZDqwouGCex3q7KkUtoA3
	5BjoF8dRYprV6b5xlFNJ/PKiwgGRR9pl0GtC1+OiOl3jouPuPs96+BjIS/fG2Brodh+X45RsMZN
	HGmvIoIROGETMCNp5nlrxUk4VGVi3qBn84E10Wic+fKqzJyEfY9PrR6+7gH6TpzfjqqaW9RokYe
	PuLrLza4N1M05/46fs66PoJ6+tbA3JNJM9gCJOJzht
X-Received: by 2002:a81:a210:0:b0:664:f825:93ca with SMTP id 00721157ae682-689613220a2mr139397017b3.25.1722903804897;
        Mon, 05 Aug 2024 17:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEskZB4+QSMqoT5ZJMPRzBqYjfNgH9WZS17PDY7kjDN6AsXY92Yw3o8eQShKFanVEFiTlzK0gohHRG1mkqCWos=
X-Received: by 2002:a81:a210:0:b0:664:f825:93ca with SMTP id
 00721157ae682-689613220a2mr139396567b3.25.1722903803787; Mon, 05 Aug 2024
 17:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731070207.3918687-1-davidgow@google.com>
In-Reply-To: <20240731070207.3918687-1-davidgow@google.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 5 Aug 2024 18:22:57 -0600
Message-ID: <CAA1CXcDKht4vOL-acxrARbm6JhGna8_k8wjYJ-vHONink8aZ=w@mail.gmail.com>
Subject: Re: [PATCH] kunit: Device wrappers should also manage driver name
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:02=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> kunit_driver_create() accepts a name for the driver, but does not copy
> it, so if that name is either on the stack, or otherwise freed, we end
> up with a use-after-free when the driver is cleaned up.
>
> Instead, strdup() the name, and manage it as another KUnit allocation.
> As there was no existing kunit_kstrdup(), we add one. Further, add a
> kunit_ variant of strdup_const() and kfree_const(), so we don't need to
> allocate and manage the string in the majority of cases where it's a
> constant.
>
> This fixes a KASAN splat with overflow.overflow_allocation_test, when
> built as a module.
>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Reported-by: Nico Pache <npache@redhat.com>

Hi David,

This is failing in the Fedora-ark build process [1] which builds the
KUNIT tests as modules.

+ /usr/bin/make <SNIP> modules
...
ERROR: modpost: "__start_rodata" [lib/kunit/kunit.ko] undefined!
ERROR: modpost: "__end_rodata" [lib/kunit/kunit.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/builddir/build/BUILD/kernel-6.11.0-build/kernel-6.11-rc2/lin=
ux-6.11.0-0.rc2.22.ov.fc41.x86_64/Makefile:1895:
modpost] Error 2
make: *** [Makefile:236: __sub-make] Error 2
+ exit 1

This seems related to

+#include <asm/sections.h>

which defines __<start|end>_rodata.

When I tried exporting these symbols I got:

ERROR: modpost: vmlinux: '__start_rodata' exported twice. Previous
export was in vmlinux

So I'm not sure what the problem is here.

[1] - https://kojipkgs.fedoraproject.org//work/tasks/9116/121539116/build.l=
og

Cheers
-- Nico

> Closes: https://groups.google.com/g/kunit-dev/c/81V9b9QYON0
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---

>
> There's some more serious changes since the RFC I sent, so please take a
> closer look.
>
> Thanks,
> -- David
>
> Changes since RFC:
> https://groups.google.com/g/kunit-dev/c/81V9b9QYON0/m/PFKNKDKAAAAJ
> - Add and use the kunit_kstrdup_const() and kunit_free_const()
>   functions.
> - Fix a typo in the doc comments.
>
>
> ---
>  include/kunit/test.h | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/device.c   |  7 ++++--
>  2 files changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index e2a1f0928e8b..da9e84de14c0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -28,6 +28,7 @@
>  #include <linux/types.h>
>
>  #include <asm/rwonce.h>
> +#include <asm/sections.h>
>
>  /* Static key: true if any KUnit tests are currently running */
>  DECLARE_STATIC_KEY_FALSE(kunit_running);
> @@ -480,6 +481,63 @@ static inline void *kunit_kcalloc(struct kunit *test=
, size_t n, size_t size, gfp
>         return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>
> +
> +/**
> + * kunit_kfree_const() - conditionally free test managed memory
> + * @x: pointer to the memory
> + *
> + * Calls kunit_kfree() only if @x is not in .rodata section.
> + * See kunit_kstrdup_const() for more information.
> + */
> +static inline void kunit_kfree_const(struct kunit *test, const void *x)
> +{
> +       if (!is_kernel_rodata((unsigned long)x))
> +               kunit_kfree(test, x);
> +}
> +
> +/**
> + * kunit_kstrdup() - Duplicates a string into a test managed allocation.
> + *
> + * @test: The test context object.
> + * @str: The NULL-terminated string to duplicate.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * See kstrdup() and kunit_kmalloc_array() for more information.
> + */
> +static inline char *kunit_kstrdup(struct kunit *test, const char *str, g=
fp_t gfp)
> +{
> +       size_t len;
> +       char *buf;
> +
> +       if (!str)
> +               return NULL;
> +
> +       len =3D strlen(str) + 1;
> +       buf =3D kunit_kmalloc(test, len, gfp);
> +       if (buf)
> +               memcpy(buf, str, len);
> +       return buf;
> +}
> +
> +/**
> + * kunit_kstrdup_const() - Conditionally duplicates a string into a test=
 managed allocation.
> + *
> + * @test: The test context object.
> + * @str: The NULL-terminated string to duplicate.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * Calls kunit_kstrdup() only if @str is not in the rodata section. Must=
 be freed with
> + * kunit_free_const() -- not kunit_free().
> + * See kstrdup_const() and kunit_kmalloc_array() for more information.
> + */
> +static inline const char *kunit_kstrdup_const(struct kunit *test, const =
char *str, gfp_t gfp)
> +{
> +       if (is_kernel_rodata((unsigned long)str))
> +               return str;
> +
> +       return kunit_kstrdup(test, str, gfp);
> +}
> +
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
>   * @test: The test context object.
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 25c81ed465fb..520c1fccee8a 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -89,7 +89,7 @@ struct device_driver *kunit_driver_create(struct kunit =
*test, const char *name)
>         if (!driver)
>                 return ERR_PTR(err);
>
> -       driver->name =3D name;
> +       driver->name =3D kunit_kstrdup_const(test, name, GFP_KERNEL);
>         driver->bus =3D &kunit_bus_type;
>         driver->owner =3D THIS_MODULE;
>
> @@ -192,8 +192,11 @@ void kunit_device_unregister(struct kunit *test, str=
uct device *dev)
>         const struct device_driver *driver =3D to_kunit_device(dev)->driv=
er;
>
>         kunit_release_action(test, device_unregister_wrapper, dev);
> -       if (driver)
> +       if (driver) {
> +               const char *driver_name =3D driver->name;
>                 kunit_release_action(test, driver_unregister_wrapper, (vo=
id *)driver);
> +               kunit_kfree_const(test, driver_name);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(kunit_device_unregister);
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>


