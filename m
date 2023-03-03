Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B376A918E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 08:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCCHPv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 02:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCCHPt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 02:15:49 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69D360A8
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Mar 2023 23:15:47 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id bx14so1064712uab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Mar 2023 23:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677827747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+14TDPDSR+38RF97tCoIIIN5U8Nevq2YL+GWcPP/u4=;
        b=AO7tRfrB6FLQW/c/8G+8MiOY/TdQgZYPMx4apgbYS1bJnVqP1pYtnNjCk+4PLWxMf+
         sd+j3c0hS3XdjhPP3Mse7/Lv2b1PJ9nhTYc6tkfXu99osgyi49ZJlNakfLHCCm2WkQno
         GmeLgrdRU/6CuxlLw1BzQwl6+0L8Q4scy//BeIwVRKKEv3qO+iniCLyS1WPNtps2jb9w
         12YxHiC8Z6UZckSc/a3AddfcIGfP/Z08pOQidbqY9TRmEP7kxE8XVOFGs4UbIPzwAb5U
         gfh8jWfq64Isbof9+13gyieeFuXYgftz8YPh0mmGNv3MU/qw+QzbBljpU8kAWm6r0xXZ
         r2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677827747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+14TDPDSR+38RF97tCoIIIN5U8Nevq2YL+GWcPP/u4=;
        b=w0xJvdmlRRZ1vWK5k4CN1goniZ4Y9EfficnPeglYVi/90ZBhrEWcoYT82HrbxW8HpA
         3ydJtsYBZwZAmZ/Nt3eFYs0k7p8HCFdzKBEUn5vB6ROtkB9GtBaYnv+2gZjIekDDQDlQ
         0hZCsRTu0IM2HSgT928rmrhwFdwlF5GaypQbbfRGhPTdP+8oNByVNU6LQkVn2tRJcnsp
         IvYfxyqIbG8O8TEiIVgWhBhWnl9VuZnV4dL4QVT7PE+qDj1ShWO3oTrYcvNXGuDuzmvI
         u9TtFSLOw6vQbcql5y5HvJgBB96+3Fqgy5GJA5Br2yH3daBqFwK82oAMtcm5fyVCKItq
         LOYQ==
X-Gm-Message-State: AO0yUKXQgrSlgTKMaUFz91OHTtNYebqUQaL97AqSGuuApOYrivGE7gqh
        FwSEAhb7kTCIh9s5BUpz1o6gn0T4OSIHdeNAgXBsyA==
X-Google-Smtp-Source: AK7set/bN9C6HBcxnjApEpQsg3NaD3xIN+2ANP4rH5d9w2F1VZi+ht+kHalYAc57BAdtUaXkq/R/04pPHLyCSsnNFZM=
X-Received: by 2002:a1f:3f8f:0:b0:3ea:b7e1:fb29 with SMTP id
 m137-20020a1f3f8f000000b003eab7e1fb29mr394575vka.0.1677827746715; Thu, 02 Mar
 2023 23:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-5-sboyd@kernel.org>
In-Reply-To: <20230302013822.1808711-5-sboyd@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 3 Mar 2023 15:15:35 +0800
Message-ID: <CABVgOSkahumU6T+rCVx+k7Y9=iMszveseVYE0wfKjXwkNJpFxQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: Add test managed clk provider/consumer APIs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000db548405f5f9b6ca"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000db548405f5f9b6ca
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Unit tests are more ergonomic and simpler to understand if they don't
> have to hoist a bunch of code into the test harness init and exit
> functions. Add some test managed wrappers for the clk APIs so that clk
> unit tests can write more code in the actual test and less code in the
> harness.
>
> Only add APIs that are used for now. More wrappers can be added in the
> future as necessary.
>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Looks good, modulo bikeshedding below.

>  drivers/clk/Makefile    |   5 +
>  drivers/clk/clk-kunit.c | 204 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk-kunit.h |  28 ++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 drivers/clk/clk-kunit.c
>  create mode 100644 drivers/clk/clk-kunit.h
>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..7efce649b0d3 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -17,6 +17,11 @@ ifeq ($(CONFIG_OF), y)
>  obj-$(CONFIG_COMMON_CLK)       += clk-conf.o
>  endif
>
> +# KUnit specific helpers
> +ifeq ($(CONFIG_COMMON_CLK), y)
> +obj-$(CONFIG_KUNIT)            += clk-kunit.o

Do we want to compile these in whenever KUnit is enabled, or only when
we're building clk tests specifically? I suspect this would be served
better by being under a CLK_KUNIT config option, which all of the
tests then depend on. (Whether that's the existing
CONFIG_CLK_KUNIT_TEST, and all of the clk tests live under the same
config option, or a separate parent option would be up to you).

Equally, this could be a bit interesting if CONFIG_KUNIT=m. Given
CONFIG_COMMON_CLK=y, this would end up as a clk-kunit module, no?

> +endif
> +
>  # hardware specific clock types
>  # please keep this section sorted lexicographically by file path name
>  obj-$(CONFIG_COMMON_CLK_APPLE_NCO)     += clk-apple-nco.o
> diff --git a/drivers/clk/clk-kunit.c b/drivers/clk/clk-kunit.c
> new file mode 100644
> index 000000000000..78d85b3a7a4a
> --- /dev/null
> +++ b/drivers/clk/clk-kunit.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit helpers for clk tests
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include <kunit/resource.h>
> +
> +#include "clk-kunit.h"
> +
> +static void kunit_clk_disable_unprepare(struct kunit_resource *res)

We need to decide on the naming scheme of these, and in particular if
they should be kunit_clk or clk_kunit (or something else).

I'd lean to clk_kunit, if only to match DRM's KUnit helpers being
drm_kunit_helper better, and so that these are more tightly bound to
the subsystem being tested.
(i.e., so I don't have to scroll through every subsystem's helpers
when autocompleting kunit_).


> +{
> +       struct clk *clk = res->data;
> +
> +       clk_disable_unprepare(clk);
> +}
> +
> +/**
> + * kunit_clk_prepare_enable() - Test managed clk_prepare_enable()
> + * @test: The test context
> + * @clk: clk to prepare and enable
> + *
> + * Returns: 0 on success, or negative errno on failure.
> + */
> +int kunit_clk_prepare_enable(struct kunit *test, struct clk *clk)
> +{
> +       if (!kunit_alloc_resource(test, NULL, kunit_clk_disable_unprepare,
> +                                 GFP_KERNEL, clk))
> +               return -EINVAL;
> +
> +       return clk_prepare_enable(clk);
> +}
> +EXPORT_SYMBOL_GPL(kunit_clk_prepare_enable);
> +
> +static void kunit_clk_put(struct kunit_resource *res)
> +{
> +       struct clk *clk = res->data;
> +
> +       clk_put(clk);
> +}
> +
> +/**
> + * kunit_clk_get() - Test managed clk_get()
> + * @test: The test context
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Returns: new clk consumer or ERR_PTR on failure
> + */
> +struct clk *
> +kunit_clk_get(struct kunit *test, struct device *dev, const char *con_id)
> +{
> +       struct clk *clk;
> +
> +       clk = clk_get(dev, con_id);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
> +               clk_put(clk);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return clk;
> +}
> +EXPORT_SYMBOL_GPL(kunit_clk_get);
> +
> +/**
> + * kunit_of_clk_get() - Test managed of_clk_get()
> + * @test: The test context
> + * @np: device_node for clock "consumer"
> + * @index: index in 'clocks' property of @np
> + *
> + * Returns: new clk consumer or ERR_PTR on failure
> + */
> +struct clk *
> +kunit_of_clk_get(struct kunit *test, struct device_node *np, int index)
> +{
> +       struct clk *clk;
> +
> +       clk = of_clk_get(np, index);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
> +               clk_put(clk);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return clk;
> +}
> +EXPORT_SYMBOL_GPL(kunit_of_clk_get);
> +
> +/**
> + * kunit_clk_hw_get_clk() - Test managed clk_hw_get_clk()
> + * @test: The test context
> + * @hw: clk_hw associated with the clk being consumed
> + * @con_id: connection ID string on device
> + *
> + * Returns: new clk consumer or ERR_PTR on failure
> + */
> +struct clk *
> +kunit_clk_hw_get_clk(struct kunit *test, struct clk_hw *hw, const char *con_id)
> +{
> +       struct clk *clk;
> +
> +       clk = clk_hw_get_clk(hw, con_id);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
> +               clk_put(clk);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return clk;
> +}
> +EXPORT_SYMBOL_GPL(kunit_clk_hw_get_clk);
> +
> +/**
> + * kunit_clk_hw_get_clk_prepared_enabled() - Test managed clk_hw_get_clk() + clk_prepare_enable()
> + * @test: The test context
> + * @hw: clk_hw associated with the clk being consumed
> + * @con_id: connection ID string on device
> + *
> + * Returns: new clk consumer that is prepared and enabled or ERR_PTR on failure
> + */
> +struct clk *
> +kunit_clk_hw_get_clk_prepared_enabled(struct kunit *test, struct clk_hw *hw,
> +                                     const char *con_id)
> +{
> +       int ret;
> +       struct clk *clk;
> +
> +       clk = kunit_clk_hw_get_clk(test, hw, con_id);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       ret = kunit_clk_prepare_enable(test, clk);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return clk;
> +}
> +EXPORT_SYMBOL_GPL(kunit_clk_hw_get_clk_prepared_enabled);
> +
> +static void kunit_clk_hw_unregister(struct kunit_resource *res)
> +{
> +       struct clk_hw *hw = res->data;
> +
> +       clk_hw_unregister(hw);
> +}
> +
> +/**
> + * kunit_clk_hw_register() - Test managed clk_hw_register()
> + * @test: The test context
> + * @dev: device that is registering this clock
> + * @hw: link to hardware-specific clock data
> + *
> + * Returns: 0 on success or a negative errno value on failure
> + */
> +int kunit_clk_hw_register(struct kunit *test, struct device *dev, struct clk_hw *hw)
> +{
> +       int ret;
> +
> +       ret = clk_hw_register(dev, hw);
> +       if (ret)
> +               return ret;
> +
> +       if (!kunit_alloc_resource(test, NULL, kunit_clk_hw_unregister, GFP_KERNEL, hw)) {
> +               clk_hw_unregister(hw);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * kunit_of_clk_hw_register() - Test managed of_clk_hw_register()
> + * @test: The test context
> + * @node: device_node of device that is registering this clock
> + * @hw: link to hardware-specific clock data
> + *
> + * Returns: 0 on success or a negative errno value on failure
> + */
> +int kunit_of_clk_hw_register(struct kunit *test, struct device_node *node, struct clk_hw *hw)
> +{
> +       int ret;
> +
> +       ret = of_clk_hw_register(node, hw);
> +       if (ret)
> +               return ret;
> +
> +       if (!kunit_alloc_resource(test, NULL, kunit_clk_hw_unregister, GFP_KERNEL, hw)) {
> +               clk_hw_unregister(hw);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/clk-kunit.h b/drivers/clk/clk-kunit.h
> new file mode 100644
> index 000000000000..153597d69269
> --- /dev/null
> +++ b/drivers/clk/clk-kunit.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _CLK_KUNIT_H
> +#define _CLK_KUNIT_H
> +
> +struct clk;
> +struct clk_hw;
> +struct device;
> +struct device_node;
> +struct kunit;
> +
> +struct clk *
> +kunit_clk_get(struct kunit *test, struct device *dev, const char *con_id);
> +struct clk *
> +kunit_of_clk_get(struct kunit *test, struct device_node *np, int index);
> +
> +struct clk *
> +kunit_clk_hw_get_clk(struct kunit *test, struct clk_hw *hw, const char *con_id);
> +struct clk *
> +kunit_clk_hw_get_clk_prepared_enabled(struct kunit *test, struct clk_hw *hw,
> +                                     const char *con_id);
> +
> +int kunit_clk_prepare_enable(struct kunit *test, struct clk *clk);
> +
> +int kunit_clk_hw_register(struct kunit *test, struct device *dev, struct clk_hw *hw);
> +int kunit_of_clk_hw_register(struct kunit *test, struct device_node *node,
> +                            struct clk_hw *hw);
> +
> +#endif
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--000000000000db548405f5f9b6ca
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD5
86CIRULPEMwUWZV/a7qUqBMFmJMb3MpZWMzCa1wifzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDMwNzE1NDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAXg8QKWbCmPKSbx9mAPkg
XSGrxqlvX0RljB4aUIXjGIeX3QMo3YK5BPWT5c14xEOxCef6Bd9CEPmd23gYoo7Be2vL/x5CDFLZ
YrAohFVv6eDqxkkZdGhScJ5Bj+PN53MGatRg6+eSG9tXepY+AY8LdFil5Jv9UClQOA57IvUnuwBt
Kwkasd/3WK9AJv+VECcUX6TeTTYoEnysvaZj6sqiPs2mLBZKsP0WcdrR2izwfA+0R2VRJmr6FmFP
8PZw6Ns1MZBVwS3unAdfThhssW+8OFzQ4LO38ydVM7cV9gapSDskNEK2snM5aSvHb0aP8ym1jszl
7lD94kHm/oTww4GACg==
--000000000000db548405f5f9b6ca--
