Return-Path: <linux-kselftest+bounces-11834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBA906596
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 09:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AA21F22DC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482713C83A;
	Thu, 13 Jun 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbEZ7zwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E2839FE
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264952; cv=none; b=p3+5uxRKCUgs8G/X7ja2xi3pmQHfgp5XW/ccXZypCZjk1ka6HmJA8gA/JKVZr7Ejeicp3Wm7pGPtL1Hzv8lD7Xi2IbjjmM+x//vlujN0vcJWMXJfD1rpawtLlcu6migmMknx81Wtr06AXCq5I6nk+JpmMGSI01vGGJgS7IvGNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264952; c=relaxed/simple;
	bh=E2XlJsOBfmxuQ1oy3JjZ5Tn8rIFRDVeKk6vceASi7sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwSSEN9u02SKCNATC4py3cB8QEomTL8RtKMH/A9YQT6zln0RTColVLYxPajBJQXZidvQOnsIHFMKNKTesPpn9GAAY6GtwakTQoOizToEDNGYILBoG+5BJ0/GqOhlk3FYvs9xL0JHeag+rltGd4H33EPDeBfvG+qXRmxFrPgEkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbEZ7zwy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4405cf01a7fso213851cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718264949; x=1718869749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfKFcSRF/pKDCb1hFakPevDeKrjo8ZWYZ9X89zwtBDc=;
        b=AbEZ7zwyS+bLvoUqCMBmItY8gL5FjOE5O+BLLs3lKknq4PdejTqizhXEhGgl5ytN0T
         u1gBBHwR3qjEU7boTUVKH0KA+iIfkWvxsrylbZfYM1P0mKnb2hplJqGlxm3Xjx4V1Q4r
         fg8jDFzCwG9h7DJFsvj4OBNc71MCi4dZ5PCQngOkev1OCmyEAO1B7gaw+NtU6d/+E2hh
         qvGIAibqGzfKM/zm1KqQHv7cr7uF/rNgRaKQPVG2fteGm/9mKmaJAU2bD9gvIIwSz2VF
         9z0cIqd8cIGx4IWOuGkX/5WKJhspT6aLy/UyG/alnk+s/17w6mKMbeIIpLBdLFUhvN1C
         kW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264949; x=1718869749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfKFcSRF/pKDCb1hFakPevDeKrjo8ZWYZ9X89zwtBDc=;
        b=HyWmCJpodcpd8oS8l+BDWiZM6x8KWHYHHBjX07PBIdA7kL8wbI0WxF39xLqxqsAOGI
         624NQqKqZV+K+DwD9BBJ7C4SOGDcAmMWMQb0s/vMNJdyxuzcGP2dg6QNN8ZAJvpQ7eQ5
         DCEn4FQIFL1HOD8kETmAeibP6A0LCM07jBibn7/sR/DFrJKPZlmzg16mygwg87EZOmPn
         ffW72K8PeDsW1Eqh6azcX3OqZu7y0PW9RyEKSX9FyJedlX/FmidWYzm3S5dXhTDwMkN4
         G4edQPbZ1HPM7HHuV+es/JkvE8xTQR8RGCijB/9hcG+EmJCImIZPeAPHmhYlRtv7eqcX
         yQTg==
X-Forwarded-Encrypted: i=1; AJvYcCXDEKfXG3fWaTDpSW4rbC70Vry+6AnsyadBTievciRs3Kcm8MNCB0dUq84nZTRkSmAr7eUDmjUUYu+BPqapWym9OKCSl3NnF/GAVWyEcNa8
X-Gm-Message-State: AOJu0YzBDXJDY+1dXk03iHlpawviT4AIkeCfPfx0Ntq1ZS27lAGoKM74
	i6/o2mfKWMdwJxe5BBJa1ktUdCZD8bmURXZ2T9/WwDUZSH6XGneQNG1RRx9VtW4D7GSncHchxF6
	WuOxgtuk1qhB6nTPWrc3H0xp8BTFBoqs4Z03H
X-Google-Smtp-Source: AGHT+IGVf2K9JItY5o0MH8XoG/6sudso0+9bAw4j2SlXlQx+fykZJyFV+yGywOymAJs9eCMqYVdyDdfVz80o73bs6nA=
X-Received: by 2002:a05:622a:4206:b0:43a:aa3f:917a with SMTP id
 d75a77b69052e-441eef3e3a3mr1330781cf.27.1718264948677; Thu, 13 Jun 2024
 00:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-3-sboyd@kernel.org>
In-Reply-To: <20240603223811.3815762-3-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 13 Jun 2024 15:48:54 +0800
Message-ID: <CABVgOS=duqR0Lea0i92pWR-618iRGkvvATk30MJrU7RRDR8LPg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
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
	boundary="000000000000eeeec8061ac0bbad"

--000000000000eeeec8061ac0bbad
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 06:38, Stephen Boyd <sboyd@kernel.org> wrote:
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
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

This looks good to me.

I was a little confused at first by some of the wrapper names: in
particular that of_overlay_fdt_apply_kunit() is applying the overlay
immediately, and deferring a cleanup action, but of_node_put_kunit()
is not doing anything immediately, and deferring the put action. My
feeling is that the ideal thing would be to have wrappers for all of
the of_* functions which return a node which needs to be 'put', and
have those wrappers add an of_node_put() action. You could then have
of_node_put_kunit() provide a way to trigger that action early. But
that seems like it'd be a lot of work and generate a lot of wrappers
we otherwise wouldn't need, so this seems an okay compromise to be
able to keep using the existing of_ functions. The documentation /
comments help make this more clear, too.

So, no actual problems. (Assuming you don't want to put the
documentation under the devicetree rather than under KUnit -- it can
go either way.)

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


>  Documentation/dev-tools/kunit/api/index.rst |  11 ++
>  Documentation/dev-tools/kunit/api/of.rst    |  13 +++
>  drivers/of/Makefile                         |   1 +
>  drivers/of/of_kunit_helpers.c               |  74 +++++++++++++
>  include/kunit/of.h                          | 115 ++++++++++++++++++++
>  5 files changed, 214 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/api/of.rst
>  create mode 100644 drivers/of/of_kunit_helpers.c
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
> +
> +Documentation/dev-tools/kunit/api/of.rst
> +
> + - Documents the KUnit device tree (OF) API
> diff --git a/Documentation/dev-tools/kunit/api/of.rst b/Documentation/dev-tools/kunit/api/of.rst
> new file mode 100644
> index 000000000000..cb4193dcddbb
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
> +.. kernel-doc:: drivers/of/of_kunit_helpers.c
> +   :export:
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 251d33532148..2ae909adde49 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -19,6 +19,7 @@ obj-y += kexec.o
>  endif
>  endif
>
> +obj-$(CONFIG_KUNIT) += of_kunit_helpers.o
>  obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
>
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/of_kunit_helpers.c b/drivers/of/of_kunit_helpers.c
> new file mode 100644
> index 000000000000..8a09132e32a8
> --- /dev/null
> +++ b/drivers/of/of_kunit_helpers.c
> @@ -0,0 +1,74 @@
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
> +#if defined(CONFIG_OF_OVERLAY) && defined(CONFIG_OF_EARLY_FLATTREE)
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
> +{
> +       int ret;
> +       int *copy_id;
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
> +#endif
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(of_node_put_wrapper, of_node_put, struct device_node *);
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
> +       if (kunit_add_action(test, of_node_put_wrapper, node)) {
> +               KUNIT_FAIL(test,
> +                          "Can't allocate a kunit resource to put of_node\n");
> +       }
> +}
> +EXPORT_SYMBOL_GPL(of_node_put_kunit);
> diff --git a/include/kunit/of.h b/include/kunit/of.h
> new file mode 100644
> index 000000000000..48d4e70c9666
> --- /dev/null
> +++ b/include/kunit/of.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _KUNIT_OF_H
> +#define _KUNIT_OF_H
> +
> +#include <kunit/test.h>
> +
> +struct device_node;
> +
> +#ifdef CONFIG_OF
> +
> +void of_node_put_kunit(struct kunit *test, struct device_node *node);
> +
> +#else
> +
> +static inline
> +void of_node_put_kunit(struct kunit *test, struct device_node *node)
> +{
> +       kunit_skip(test, "requires CONFIG_OF");
> +}
> +
> +#endif /* !CONFIG_OF */
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_OF_OVERLAY) && defined(CONFIG_OF_EARLY_FLATTREE)
> +
> +int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> +                              u32 overlay_fdt_size, int *ovcs_id);
> +#else
> +
> +static inline int
> +of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> +                          u32 overlay_fdt_size, int *ovcs_id)
> +{
> +       kunit_skip(test, "requires CONFIG_OF and CONFIG_OF_OVERLAY and CONFIG_OF_EARLY_FLATTREE for root node");
> +       return -EINVAL;
> +}
> +
> +#endif
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
> +static inline int __of_overlay_apply_kunit(struct kunit *test,
> +                                          u8 *overlay_begin,
> +                                          const u8 *overlay_end)
> +{
> +       int unused;
> +
> +       return of_overlay_fdt_apply_kunit(test, overlay_begin,
> +                                         overlay_end - overlay_begin,
> +                                         &unused);
> +}
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

--000000000000eeeec8061ac0bbad
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIAbPdDmqRD62gxomP9jWw3ewngMixgQkIRTjsfETZ2hkMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMzA3NDkwOVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBCOMB6
Ib+gn40t89X60Qu9Z5EJDWy1jsRyPpquSOaOJ+FMyjAnAkrvI+sEYhTeW8s+g3ioEfriFpOggVhI
kh2wJAczBepTxZc8y+ehGidSltAOY+QDwnHX/y2ChLQC7QwomOIz1lHC7GculzgTu0V7MdS9BAlp
OoxYI7qti5ni3lWRLmx7ugUmDRpMQFHPLR9zpkx6hnCCenn8qoS123tsldWnAlQxkGBfww9BhLd3
EAwq/L7NemCNlmNXQPCjz0U9oErAwAofSxQywAV/FQ1eoyVhTJbweOGfxbQq7dDOqyDxkJ71BFsD
ORRQL545ZzQ8A09UnDDATzEcOHGqUP1J
--000000000000eeeec8061ac0bbad--

