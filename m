Return-Path: <linux-kselftest+bounces-14730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA24946268
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2021C21A0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497D515C12A;
	Fri,  2 Aug 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSqngSBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F901537C5
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619708; cv=none; b=qaiQfYVNHXWiSB6j5jy+ROu/Lj0MMTwpFw/n79vx0SJItb2QFDJ6XJBZkZq21hH5oVcSSBIDLS48XWM1oPzIsdnfERPtyeywySVAawJrE+24nJvqki0u2ODmvC7axC1VhBg06bp60ENC/NGhDARiYm0zfI4m/bti65vUZmFNG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619708; c=relaxed/simple;
	bh=F3g430AFcd5fktOgTWAO9/9FNUn0gfLYsMRiXbuhse8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS6mMpnmw3QuhtxpmV4yWm6Ha7a50X52cmfU+IoQcX8RXBaihrxvsd1xXHMySp4BqoS4ETOBh/Aj7ZF9rkA0qj8YG1VPceIliV/POYgJRBRVEPukRXIk3TYQZpKtWcKrDgHpW2GEWLxTjT1aUP1q7DawScU6C3jsWwttdWQ8Q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSqngSBM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fdc70e695so1470691cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722619705; x=1723224505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSSS4E3zuKvWBv0XQ9yYM+WcI7zxzF47G/3hGsx+ctc=;
        b=kSqngSBMVj6W9IFzwsBH29Gnz+3M9sMiToP98yqb6OxuQHL585EIBYoa3ToRCGJJwg
         tE15mjhdlDO42yOXFS8jQR9KO/toQEQKifkziTeWMHxK3Vheen9bnmha8F0D5woA2kx+
         jRnbuHUAVF1chU7uGJQt2dlF+7MbDdDfJmH08JCBlZVctbKpc78Ojkg4+lJ3b8tcqKoe
         1rnzFN5KBu1vMsnLN4lIF9s3aLnJfkk+FoUVV0BMF7Ar3f3LEYzmATc8sY4yX97KHiUl
         KiMS5Y4m/XmhIXxVFhiv656y8eiDTY4ZLiYupBOO/6gF1ezZdczydFycAa5UEw30okfK
         rZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722619705; x=1723224505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSSS4E3zuKvWBv0XQ9yYM+WcI7zxzF47G/3hGsx+ctc=;
        b=kLXZHENwjm8D/TGBs1RP8jPuxrBrrP6RzF+7Zs1BBA3dh8WYW3gpDdHuYs1GwCxo4m
         C8fyL68USfSRcT2w31SvfS84w0bb3GB2TyIHrImAkL7IVzlkphA7pk75HVbFg4YIGes2
         1dCwzbfh6mGVFnpnjLpsnknHV02ky+WxGlbo3ULTSOg2Jxv/Z4OxZmWRMSKg26Ufu6Dq
         g9Yvk3VfP9v594yjxE7K893DdQc+NJ0iU4jjzLzDnJt21IsX/TJIP6MpCjdFz67yDv6W
         vRZcqR/TNzQdLchHxb/Me1IYGEz2sByCunWGOWrF1Qgt0HVCGW4nr0fLQVTvHdbnpMzv
         Cdqg==
X-Forwarded-Encrypted: i=1; AJvYcCUBO95enzRuxCtmIDg0uaBceKeU9+weSy7YEF6+MCC6LAPepXvrhJItMDLTPFI9ggvUndedsTD/+Q4hc5R9MkANnRJECQtDeZqL4r5+nhK1
X-Gm-Message-State: AOJu0YyD1ECncUcNhwevgb5JMd6R9zolWddGh/0ArrMUVShjo4OEidzI
	xYRfBCUaZ0dd8PMJIeJKxjKqh9g2uzelNk9tILsukMcWl2ZRaY8ja7Fk/WC7akGViscJwxNBJkS
	xdHqdiJVu0gK61FQMy9VdFwzD6ejE63rFpyqu
X-Google-Smtp-Source: AGHT+IEW8VIhs9YamiW05dBEhB7BQ3Do4tGZnbt1vWnlgmGeqasRzyUtOO85UW1YZdi4lv8hQmL5M3LA+U1y8BvQHY8=
X-Received: by 2002:ac8:5a01:0:b0:447:f958:ab83 with SMTP id
 d75a77b69052e-4518ccc2c8dmr3261391cf.21.1722619705228; Fri, 02 Aug 2024
 10:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731070207.3918687-1-davidgow@google.com>
In-Reply-To: <20240731070207.3918687-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 2 Aug 2024 13:28:13 -0400
Message-ID: <CA+GJov5k2a6OEj-E2ULbimeMcY9Rq2Lh58-juBm=AMbPy0s4sA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Device wrappers should also manage driver name
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>, Nico Pache <npache@redhat.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:02=E2=80=AFAM David Gow <davidgow@google.com> wro=
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

Hello!

These changes look good to me. Fun patch to review! Only comment is
that we could potentially add tests for these functions in a future
patch.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

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

