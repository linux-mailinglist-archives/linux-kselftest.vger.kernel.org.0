Return-Path: <linux-kselftest+bounces-9180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A052C8B8686
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EB4B226BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310B4E1CE;
	Wed,  1 May 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHE71tPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D74D9FB
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550126; cv=none; b=YiyfuFi6IP3uQYJq/aMqjAUleYExlOvEiD4IQzBivTSo7Y0wFY2xW6xb2KDyR8hLWeN7G0UTBiisw7iZnFFdvzpWSjkR0WtQY5gBw/V5DoFOHw8qRYG0MtKI7hn1HYqy3Y0uvnpP0feMcxpJnYoeIRMVeuQXcINNlerXnmZUnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550126; c=relaxed/simple;
	bh=X+WwdH+IAxiUV/wEGrgfiv6/Y7QU+RwT4SDHQQ4AeVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7ElQ5erSuNKP6mI2jkD8RVYQmjumXWwgnr3PFnBBQs5WV972yzMhoo+C7HElSX1IW4JRPev4cb0JYV07+ngDitafIVfOoo1m5ei7UiN1zIUa+5LVh/2Jy088VuBkkPnucVrNUOpZWsLX+lcuJiyThZNVD7w7UNa348a+ko9LWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHE71tPO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-436ed871225so161441cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714550123; x=1715154923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFcd21d1ExBvObMU9qfdNM36k6d/yWkoN7ifxl20W1E=;
        b=ZHE71tPO90sNoa99cSJyu/VE8wcnoqgpNRYxCnWZvH91TtX/PEU/leL3aCiUOgabGl
         55l1mmkEpYrUdILOQzt1g2Uk4JrTfgG5onSgHOy/85gvIzNEgiyO6aSs4KdQSz9EZngM
         Cnr0tjLDTge9kG1uCaWcrLoVF0EwPqqjvdRSSqvfLj3yGWpnUxgaqYUHwU7yT0GDvf8H
         zEnhB+zoD5yujJB6WgxWwcWLjynnLzAV3ZxjMDzHFQX850hByzZtRkANbbeIVc7fMN9N
         vGAVIqxLqZZxgG6hsF7Q9advn6ybnCMecdxZMxSk1M+H6L4KCNNh7k0Ik1S5QwCr1NJo
         OTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714550123; x=1715154923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFcd21d1ExBvObMU9qfdNM36k6d/yWkoN7ifxl20W1E=;
        b=bIqgt7yS+eQ9kUUIZJAtcuFtO9L3HimQRkNPbwDZeyxJEobEJ9nQbcC2HF4r7HURKx
         0QWRUdfWg5jtKOCJqaYQsQKhhKL3xC6g3UpJ1FzhvQEVY+YVaZVe3Bfb1z4+EFUMldFm
         No8nzFTXHA+Pt30Qroewbh577REK911OgsvEiknAkqoPob/+jFV6z2qEaNSXYBCSfD6m
         ZQPVuq8ahdr3tBe7XPy6uxK6dzPLOaQ8zTYnQEeH0DxoWDyJ3PXR88UlgBiDibHeqWXG
         zXxKSsb3BZ941eEcbWL9aAoBKpn2kWmE2aLS4mGgnww5RI+9smAe4UXEY01EHKf49xcP
         bVnA==
X-Forwarded-Encrypted: i=1; AJvYcCUy7hVg9xcMQmGGTbc5FWnLWmf5c+2eQonympi+F/7e6GCpqdpdsDdcDy4qfKZxZxs4zSoICQo+/N9pnElm32zR8oHbgWErXkVCk4R3B1tV
X-Gm-Message-State: AOJu0Yy4AqLdViwhVH+qF1MKdFf2e1qbQ7tI6CLcQcb5BQFFbhZcX4yk
	GoC2aO0I+x+/YrlhSxMbjgPUeuFwZUfEsxeC2PDA/Y6B1pu08SW6O8SjT9MMXsiWmNendsU9ocV
	MAsiWX2XDes4vM1nXwJpjyQocYp8MNgqlwmp5
X-Google-Smtp-Source: AGHT+IGMwZzk/EIf6V6anZuBEWRqkim2oHCNAJVhHHvJN4YYehVVVTmQ94ndRElFJrpzHSjdr06uqWjXUMHdHOdQAX8=
X-Received: by 2002:a05:622a:34b:b0:43a:ccf3:8160 with SMTP id
 r11-20020a05622a034b00b0043accf38160mr205495qtw.14.1714550122597; Wed, 01 May
 2024 00:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-2-sboyd@kernel.org>
In-Reply-To: <20240422232404.213174-2-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Wed, 1 May 2024 15:55:10 +0800
Message-ID: <CABVgOSm_Qce1AZQjH8wE4t238hxLYTNswNf1AkEDbWtqDTK7Ow@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000a214606175fcfd4"

--0000000000000a214606175fcfd4
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Add test managed wrappers for of_overlay_apply() that automatically
> removes the overlay when the test is finished. This API is intended for
> use by KUnit tests that test code which relies on 'struct device_node's
> and of_*() APIs.
>
> KUnit tests will call of_overlay_apply_kunit() to load an overlay that's
> been built into the kernel image. When the test is complete, the overlay
> will be removed.
>
> This has a few benefits:
>
>  1) It keeps the tests hermetic because the overlay is removed when the
>     test is complete. Tests won't even be aware that an overlay was
>     loaded in another test.
>
>  2) The overlay code can live right next to the unit test that loads it.
>     The overlay and the unit test can be compiled into one kernel module
>     if desired.
>
>  3) We can test different device tree configurations by loading
>     different overlays. The overlays can be written for a specific test,
>     and there can be many of them loaded per-test without needing to jam
>     all possible combinations into one DTB.
>
>  4) It also allows KUnit to test device tree dependent code on any
>     architecture, not just UML. This allows KUnit tests to test
>     architecture specific device tree code.
>
> There are some potential pitfalls though. Test authors need to be
> careful to not overwrite properties in the live tree. The easiest way to
> do this is to add and remove nodes with a 'kunit-' prefix, almost
> guaranteeing that the same node won't be present in the tree loaded at
> boot.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

This looks good to me. I'm not an expert on Device Tree Overlays, so
can't guarantee it's perfect and/or the most ergonomic solution for
any given use-case, but I definitely like the look of it from a KUnit
point of view.

A few minor naming and config-related thoughts below, but otherwise:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/api/index.rst | 11 +++
>  Documentation/dev-tools/kunit/api/of.rst    | 13 +++
>  drivers/of/Makefile                         |  1 +
>  drivers/of/of_kunit.c                       | 99 +++++++++++++++++++++
>  include/kunit/of.h                          | 94 +++++++++++++++++++
>  5 files changed, 218 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/api/of.rst
>  create mode 100644 drivers/of/of_kunit.c
>  create mode 100644 include/kunit/of.h
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> index 2d8f756aab56..282befa17edf 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -9,11 +9,15 @@ API Reference
>         test
>         resource
>         functionredirection
> +       of
>
>
>  This page documents the KUnit kernel testing API. It is divided into the
>  following sections:
>
> +Core KUnit API
> +==============
> +
>  Documentation/dev-tools/kunit/api/test.rst
>
>   - Documents all of the standard testing API
> @@ -25,3 +29,10 @@ Documentation/dev-tools/kunit/api/resource.rst
>  Documentation/dev-tools/kunit/api/functionredirection.rst
>
>   - Documents the KUnit Function Redirection API
> +
> +Driver KUnit API
> +================

If we're adding a separate 'Driver' section here, it's probably
sensible to move the existing device/driver helper documentation here,
rather than leaving it in resource.rst as-is. I'm happy to do that in
a follow-up patch, though.

> +
> +Documentation/dev-tools/kunit/api/of.rst
> +
> + - Documents the KUnit device tree (OF) API
> diff --git a/Documentation/dev-tools/kunit/api/of.rst b/Documentation/dev-tools/kunit/api/of.rst
> new file mode 100644
> index 000000000000..8587591c3e78
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/api/of.rst
> @@ -0,0 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Device Tree (OF) API
> +====================
> +
> +The KUnit device tree API is used to test device tree (of_*) dependent code.
> +
> +.. kernel-doc:: include/kunit/of.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/of/of_kunit.c
> +   :export:
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 251d33532148..0dfd05079313 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -19,6 +19,7 @@ obj-y += kexec.o
>  endif
>  endif
>
> +obj-$(CONFIG_KUNIT) += of_kunit.o

I'm tempted to have this either live in lib/kunit, or be behind a
separate Kconfig option, particularly since this will end up as a
separate module, as-is.

>  obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
>
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/of_kunit.c b/drivers/of/of_kunit.c
> new file mode 100644
> index 000000000000..f63527268a51
> --- /dev/null
> +++ b/drivers/of/of_kunit.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test managed device tree APIs
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +
> +#include <kunit/of.h>
> +#include <kunit/test.h>
> +#include <kunit/resource.h>
> +
> +static void of_overlay_fdt_apply_kunit_exit(void *ovcs_id)
> +{
> +       of_overlay_remove(ovcs_id);
> +}
> +
> +/**
> + * of_overlay_fdt_apply_kunit() - Test managed of_overlay_fdt_apply()
> + * @test: test context
> + * @overlay_fdt: device tree overlay to apply
> + * @overlay_fdt_size: size in bytes of @overlay_fdt
> + * @ovcs_id: identifier of overlay, used to remove the overlay
> + *
> + * Just like of_overlay_fdt_apply(), except the overlay is managed by the test
> + * case and is automatically removed with of_overlay_remove() after the test
> + * case concludes.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> +                              u32 overlay_fdt_size, int *ovcs_id)

We're using kunit_ as a prefix for the device helpers (e.g.
kunit_device_register()), so it may make sense to do that here, too.
It's not as important as with the platform_device helpers, which are
very similar to the existing device ones, but if we want to treat
these as "part of KUnit which deals with of_overlays", rather than
"part of "of_overlay which deals with KUnit", this may fit better.

Thoughts?

> +{
> +       int ret;
> +       int *copy_id;
> +
> +       if (!IS_ENABLED(CONFIG_OF_OVERLAY))
> +               kunit_skip(test, "requires CONFIG_OF_OVERLAY");
> +       if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
> +               kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE for root node");
> +
> +       copy_id = kunit_kmalloc(test, sizeof(*copy_id), GFP_KERNEL);
> +       if (!copy_id)
> +               return -ENOMEM;
> +
> +       ret = of_overlay_fdt_apply(overlay_fdt, overlay_fdt_size,
> +                                  ovcs_id, NULL);
> +       if (ret)
> +               return ret;
> +
> +       *copy_id = *ovcs_id;
> +
> +       return kunit_add_action_or_reset(test, of_overlay_fdt_apply_kunit_exit,
> +                                        copy_id);
> +}
> +EXPORT_SYMBOL_GPL(of_overlay_fdt_apply_kunit);
> +
> +/**
> + * __of_overlay_apply_kunit() - Test managed of_overlay_fdt_apply() variant
> + * @test: test context
> + * @overlay_begin: start address of overlay to apply
> + * @overlay_end: end address of overlay to apply
> + *
> + * This is mostly internal API. See of_overlay_apply_kunit() for the wrapper
> + * that makes this easier to use.
> + *
> + * Similar to of_overlay_fdt_apply(), except the overlay is managed by the test
> + * case and is automatically removed with of_overlay_remove() after the test
> + * case concludes.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int __of_overlay_apply_kunit(struct kunit *test, u8 *overlay_begin,
> +                            const u8 *overlay_end)
> +{
> +       int unused;
> +
> +       return of_overlay_fdt_apply_kunit(test, overlay_begin,
> +                                         overlay_end - overlay_begin,
> +                                         &unused);
> +}
> +EXPORT_SYMBOL_GPL(__of_overlay_apply_kunit);
> +
> +/**
> + * of_node_put_kunit() - Test managed of_node_put()
> + * @test: test context
> + * @node: node to pass to `of_node_put()`
> + *
> + * Just like of_node_put(), except the node is managed by the test case and is
> + * automatically put with of_node_put() after the test case concludes.
> + */
> +void of_node_put_kunit(struct kunit *test, struct device_node *node)
> +{
> +       if (kunit_add_action(test, (kunit_action_t *)&of_node_put, node)) {
> +               KUNIT_FAIL(test,
> +                          "Can't allocate a kunit resource to put of_node\n");
> +       }
> +}
> +EXPORT_SYMBOL_GPL(of_node_put_kunit);
> diff --git a/include/kunit/of.h b/include/kunit/of.h
> new file mode 100644
> index 000000000000..9981442ba578
> --- /dev/null
> +++ b/include/kunit/of.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _KUNIT_OF_H
> +#define _KUNIT_OF_H
> +
> +#include <kunit/test.h>
> +
> +struct device_node;
> +
> +#ifdef CONFIG_OF

Do we also need to check for CONFIG_OF_OVERLAY here?

Also, how useful is it to compile but skip tests without
CONFIG_OF{,_OVERLAY} enabled? The other option is a compile error,
which may make it more obvious that these are disabled if it's
unexpected.

Thoughts?

> +
> +int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> +                              u32 overlay_fdt_size, int *ovcs_id);
> +int __of_overlay_apply_kunit(struct kunit *test, u8 *overlay_begin,
> +                            const u8 *overlay_end);
> +
> +void of_node_put_kunit(struct kunit *test, struct device_node *node);
> +
> +#else
> +
> +static inline int
> +of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> +                          u32 overlay_fdt_size, int *ovcs_id)
> +{
> +       kunit_skip(test, "requires CONFIG_OF");
> +       return -EINVAL;
> +}
> +
> +static inline int
> +__of_overlay_apply_kunit(struct kunit *test, u8 *overlay_begin,
> +                        const u8 *overlay_end)
> +{
> +       kunit_skip(test, "requires CONFIG_OF");
> +       return -EINVAL;
> +}
> +
> +static inline
> +void of_node_put_kunit(struct kunit *test, struct device_node *node)
> +{
> +       kunit_skip(test, "requires CONFIG_OF");
> +}
> +
> +#endif /* !CONFIG_OF */
> +
> +/**
> + * of_overlay_apply_kunit() - Test managed of_overlay_fdt_apply() for built-in overlays
> + * @test: test context
> + * @overlay_name: name of overlay to apply
> + *
> + * This macro is used to apply a device tree overlay built with the
> + * cmd_dt_S_dtbo rule in scripts/Makefile.lib that has been compiled into the
> + * kernel image or KUnit test module. The overlay is automatically removed when
> + * the test is finished.
> + *
> + * Unit tests that need device tree nodes should compile an overlay file with
> + * @overlay_name\.dtbo.o in their Makefile along with their unit test and then
> + * load the overlay during their test. The @overlay_name matches the filename
> + * of the overlay without the dtbo filename extension. If CONFIG_OF_OVERLAY is
> + * not enabled, the @test will be skipped.
> + *
> + * In the Makefile
> + *
> + * .. code-block:: none
> + *
> + *     obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) += overlay_test.o kunit_overlay_test.dtbo.o
> + *
> + * In the test
> + *
> + * .. code-block:: c
> + *
> + *     static void of_overlay_kunit_of_overlay_apply(struct kunit *test)
> + *     {
> + *             struct device_node *np;
> + *
> + *             KUNIT_ASSERT_EQ(test, 0,
> + *                             of_overlay_apply_kunit(test, kunit_overlay_test));
> + *
> + *             np = of_find_node_by_name(NULL, "test-kunit");
> + *             KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
> + *             of_node_put(np);
> + *     }
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +#define of_overlay_apply_kunit(test, overlay_name)             \
> +({                                                             \
> +       extern uint8_t __dtbo_##overlay_name##_begin[];         \
> +       extern uint8_t __dtbo_##overlay_name##_end[];           \
> +                                                               \
> +       __of_overlay_apply_kunit((test),                        \
> +                       __dtbo_##overlay_name##_begin,          \
> +                       __dtbo_##overlay_name##_end);           \
> +})
> +
> +#endif
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--0000000000000a214606175fcfd4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIOLYbOVEUj6A0cOtzQozdez4j8lXZvB76frKkLI/2SK7MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwMTA3NTUyM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJQo59
xSakZTvFTsCHQoAzn47CHNWg4e7Zy7bwsCATHRxzvEbSkDNzj9K3HMjXzbhPQDjfrVXpr2q1bK1B
S5+c6DYV0E2LKo82geLkDGNCiBF/GtPOnC9CRHHsSgZwYO9zqCy3c5YNjXoglrh8qB1g84AOtDib
3qIgpUsMhkLz1e+pbciBxQsX4TskvnntQukVsmp5S/XX0YzCl3qU9N6HaW3tbHgdjN8OR+dqEbV8
d9N4316ImfT7AEAjFKs8qu6nqroX4stK7LotnDTlez0YGf0igozF5Kelt4agxUHIkNYSZ6AC0nit
Z3OodwIL3mnXxfBi9NBNCXHyoAxtVEGx
--0000000000000a214606175fcfd4--

