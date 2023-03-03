Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8E6A9189
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 08:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCCHPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 02:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCCHPT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 02:15:19 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99F36FF2
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Mar 2023 23:15:16 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id f17so1018733uax.7
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Mar 2023 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677827715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S1+yTATtOUVbTJsojzrLMALYJHGGJeiwLWqUmLTKWfA=;
        b=MeIHFYbu9woTfUPB718qPXu7CJPLdQ1OFo8EnbL1bpciz0SuTTKJtSfQD+Hef+1o7p
         X9KFHUkszwACtVKPfVc9RZjbiLoOs/amV1nlX4KPHH/3hWIRGX7+OoInxy207mneJSJy
         AOWr67P6z6l9RFbjIlcCioXpC1dRDFI0/kY0xzj/Np2wxiK+cWllv3kzUdwF5ZrkNNn+
         fI5vpwEuBGQJ65xQRXLJDIGfcGKdfbxtZfmDo8R+TDakldEOGNP6xVlPSOCEsmFnFBOe
         bt2zhf/2wX5ZqGO/bCgsjByDMp7h5qrT05r3xTMIRS0ckiXr9R+ogFPeaZ6rpVhHQY2A
         sKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677827715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1+yTATtOUVbTJsojzrLMALYJHGGJeiwLWqUmLTKWfA=;
        b=CZOBl9S0NdVepIkMynvv3eKbnjaDnEitUuP5OZYDZBrTa+uZr8K4xCXtuyJ9SllbcF
         eykJAJw1cyJNO2BLoUkF0LLydn3jiGSysT2Xxv+uJuoSmxY8+lzq6S2Ac5cfLeKk4zRc
         1sO3lyJKeFBTFNaM5F7Q/SCBlICI3C9fEK5B9py1gRK3uji0K+B0euMyX82LKXkBEajh
         9g6sSfRJbMkSG1zYxRtgs/WXm+8O/o9IpjpvQsNwJc74NqkYRyqXRGGu+lKsObDfa7pg
         1bB6FjwvI9zJ2pJ/+XsVO9SVhVHcsH9zbqlCGAT6h3WyJyzqk29sugCcBTUa3eaBiqkl
         6eTQ==
X-Gm-Message-State: AO0yUKWvhnc0T69N+YOZR3AiKD4BFE81bXCBfWVnwKTUPG3Y1DXL8bUj
        DOnJf6kYIx6tHC8WWsLnyV9rWNvolBwif17YGW2/mw==
X-Google-Smtp-Source: AK7set/zHVMhUm60hLk3g3f0thk5qxAIcbnOGq7QVRaHdVFAIG8JloIE0hQ3x9CqmpICWkL7MzVt5hW2dQiv0/AzaF8=
X-Received: by 2002:ab0:4a12:0:b0:68d:6360:77b with SMTP id
 q18-20020ab04a12000000b0068d6360077bmr278246uae.1.1677827715276; Thu, 02 Mar
 2023 23:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-3-sboyd@kernel.org>
In-Reply-To: <20230302013822.1808711-3-sboyd@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 3 Mar 2023 15:15:04 +0800
Message-ID: <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
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
        boundary="000000000000fcae3c05f5f9b412"
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

--000000000000fcae3c05f5f9b412
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>
> To fully exercise common clk framework code in KUnit we need to
> associate 'struct device' pointers with 'struct device_node' pointers so
> that things like clk_get() can parse DT nodes for 'clocks' and so that
> clk providers can use DT to provide clks; the most common mode of
> operation for clk providers.
>
> Adding support to KUnit so that it loads a DTB is fairly simple after
> commit b31297f04e86 ("um: Add devicetree support"). We can simply pass a
> pre-compiled deviectree blob (DTB) on the kunit.py commandline and UML
> will load it. The problem is that tests won't know that the commandline
> has been modified, nor that a DTB has been loaded. Take a different
> approach so that tests can skip if a DTB hasn't been loaded.
>
> Reuse the Makefile logic from the OF unittests to build a DTB into the
> kernel. This DTB will be for the mythical machine "linux,kunit", i.e.
> the devicetree for the KUnit "board". In practice, it is a dtsi file
> that will gather includes for kunit tests that rely in part on a
> devicetree being loaded. The devicetree should only be loaded if
> CONFIG_OF_KUNIT=y. Make that a choice config parallel to the existing
> CONFIG_OF_UNITTEST so that only one devicetree can be loaded in the
> system at a time. Similarly, the kernel commandline option to load a
> DTB is ignored if CONFIG_OF_KUNIT is enabled so that only one DTB is
> loaded at a time.

This feels a little bit like it's just papering over the real problem,
which is that there's no way tests can skip themselves if no DTB is
loaded.

That being said, I do think that there's probably some sense in
supporting the compiled-in DTB as well (it's definitely simpler than
patching kunit.py to always pass the extra command-line option in, for
example).
But maybe it'd be nice to have the command-line option override the
built-in one if present.

>
> Add a simple unit test to confirm that the DTB loading worked. Future
> tests will add to the kunit.dtsi file to include their specific test
> nodes.
>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/um/kernel/dtb.c            | 29 +++++++++++++++--
>  drivers/of/Kconfig              | 26 ++++++++++++++++
>  drivers/of/Makefile             |  1 +
>  drivers/of/kunit/.kunitconfig   |  4 +++
>  drivers/of/kunit/Makefile       |  4 +++
>  drivers/of/kunit/kunit.dtsi     |  8 +++++
>  drivers/of/kunit/kunit.dtso     |  4 +++
>  drivers/of/kunit/uml_dtb_test.c | 55 +++++++++++++++++++++++++++++++++
>  8 files changed, 128 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/of/kunit/.kunitconfig
>  create mode 100644 drivers/of/kunit/Makefile
>  create mode 100644 drivers/of/kunit/kunit.dtsi
>  create mode 100644 drivers/of/kunit/kunit.dtso
>  create mode 100644 drivers/of/kunit/uml_dtb_test.c
>
> diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
> index 484141b06938..ee63951b12df 100644
> --- a/arch/um/kernel/dtb.c
> +++ b/arch/um/kernel/dtb.c
> @@ -15,9 +15,32 @@ void uml_dtb_init(void)
>         long long size;
>         void *area;
>
> -       area = uml_load_file(dtb, &size);
> -       if (!area)
> -               return;
> +       if (IS_ENABLED(CONFIG_OF_KUNIT)) {
> +               /*
> +                * __dtbo_kunit_begin[] and __dtbo_kunit_end[] are magically
> +                * created by cmd_dt_S_dtbo in scripts/Makefile.lib from the
> +                * drivers/of/kunit/kunit.dtsi file.
> +                */
> +               extern uint8_t __dtbo_kunit_begin[];
> +               extern uint8_t __dtbo_kunit_end[];
> +
> +               size = __dtbo_kunit_end - __dtbo_kunit_begin;
> +               if (!size) {
> +                       pr_warn("%s: kunit testcases is empty\n", __func__);
> +                       return;
> +               }
> +
> +               /* creating copy */
> +               area = memblock_alloc(size, 8);
> +               if (!area)
> +                       return;
> +
> +               memcpy(area, __dtbo_kunit_begin, size);
> +       } else {

I think this should probably override the KUnit dtb if present (so,
try to load the dtb, and fallback to the builtin one). If not, I think
we should at least print a warning if a DTB is specified on the
command-line, but we're not using it.


> +               area = uml_load_file(dtb, &size);
> +               if (!area)
> +                       return;
> +       }
>
>         if (!early_init_dt_scan(area)) {
>                 pr_err("invalid DTB %s\n", dtb);
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..1f968b6a3dde 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -12,6 +12,20 @@ menuconfig OF
>
>  if OF
>
> +choice
> +       prompt "Devicetree Runtime Tests"
> +       default OF_UNITTEST
> +
> +config OF_KUNIT
> +       bool "Devicetree KUnit support" if KUNIT
> +       depends on UML
> +       select IRQ_DOMAIN
> +       select OF_EARLY_FLATTREE
> +       help
> +         This option builds in KUnit test cases that rely on device tree infrastructure.
> +         A fake Device Tree Blob (DTB) is loaded on the UML kernel running KUnit so that
> +         KUnit tests can test device tree dependent code.
> +
>  config OF_UNITTEST
>         bool "Device Tree runtime unit tests"
>         depends on !SPARC
> @@ -25,6 +39,18 @@ config OF_UNITTEST
>
>           If unsure, say N here, but this option is safe to enable.
>
> +endchoice
> +
> +config OF_DTB_KUNIT_TEST
> +       tristate "Devicetree KUnit DTB Test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option builds unit tests for the "linux,kunit" DTB built into
> +         the UML kernel image.
> +
> +         If unsure, say N here, but this option is safe to enable.
> +
>  config OF_ALL_DTBS
>         bool "Build all Device Tree Blobs"
>         depends on COMPILE_TEST
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..16eef3fdf60a 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -19,4 +19,5 @@ obj-y += kexec.o
>  endif
>  endif
>
> +obj-y += kunit/
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/kunit/.kunitconfig b/drivers/of/kunit/.kunitconfig
> new file mode 100644
> index 000000000000..1def0ad30d29
> --- /dev/null
> +++ b/drivers/of/kunit/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=y
> +CONFIG_OF=y
> +CONFIG_OF_KUNIT=y
> +CONFIG_OF_DTB_KUNIT_TEST=y
> diff --git a/drivers/of/kunit/Makefile b/drivers/of/kunit/Makefile
> new file mode 100644
> index 000000000000..ffe0447e1ac7
> --- /dev/null
> +++ b/drivers/of/kunit/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_OF_KUNIT) += kunit.dtbo.o
> +
> +obj-$(CONFIG_OF_DTB_KUNIT_TEST) += uml_dtb_test.o
> diff --git a/drivers/of/kunit/kunit.dtsi b/drivers/of/kunit/kunit.dtsi
> new file mode 100644
> index 000000000000..82f6c3e2b8d5
> --- /dev/null
> +++ b/drivers/of/kunit/kunit.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +       model = "KUnit UML";
> +       compatible = "linux,kunit";
> +};
> +
> +/* Include testcase dtsi files below */
> diff --git a/drivers/of/kunit/kunit.dtso b/drivers/of/kunit/kunit.dtso
> new file mode 100644
> index 000000000000..50187e8d1422
> --- /dev/null
> +++ b/drivers/of/kunit/kunit.dtso
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "kunit.dtsi"
> diff --git a/drivers/of/kunit/uml_dtb_test.c b/drivers/of/kunit/uml_dtb_test.c
> new file mode 100644
> index 000000000000..8966c9ebf51f
> --- /dev/null
> +++ b/drivers/of/kunit/uml_dtb_test.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for DTB loading on UML
> + */
> +#include <linux/kconfig.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +
> +#include <kunit/test.h>
> +
> +/*
> + * Test that of_machine_is_compatible() returns positive int when loaded DTB
> + * matches.
> + */
> +static void uml_dtb_of_machine_compatible_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_GT(test, of_machine_is_compatible("linux,kunit"), 0);
> +}
> +
> +/*
> + * Test that of_flat_dt_get_machine_name() returns the expected 'model' from the
> + * loaded DTB.
> + */
> +static void uml_dtb_of_flat_dt_get_machine_name_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_STREQ(test, of_flat_dt_get_machine_name(), "KUnit UML");
> +}
> +
> +static struct kunit_case uml_dtb_test_cases[] = {
> +       KUNIT_CASE(uml_dtb_of_machine_compatible_test),
> +       KUNIT_CASE(uml_dtb_of_flat_dt_get_machine_name_test),
> +       {}
> +};
> +
> +static int uml_dtb_test_init(struct kunit *test)
> +{
> +       if (!IS_ENABLED(CONFIG_OF_KUNIT))
> +               kunit_skip(test, "requires CONFIG_OF_KUNIT");
> +
> +       return 0;
> +}
> +
> +/*
> + * Test suite to confirm DTB is loaded on UML.
> + */
> +static struct kunit_suite uml_dtb_suite = {
> +       .name = "uml_dtb",
> +       .init = uml_dtb_test_init,
> +       .test_cases = uml_dtb_test_cases,
> +};
> +
> +kunit_test_suites(
> +       &uml_dtb_suite,
> +);
> +MODULE_LICENSE("GPL");
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230302013822.1808711-3-sboyd%40kernel.org.

--000000000000fcae3c05f5f9b412
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB1
2LDkj7xKHwubb79xss1GasbEkCyA2CWwxRWwBu/BXDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDMwNzE1MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJDqIz3g1AasnXc44Fe/E
rvoL3ksX/H4f4/zmAe99HOiUwTAEo+BzSyeCezGmTx4u8HP1ZCkQkoHLczcf6EZzvK18f4F6vD/p
6c5vMnrl6a+4E5OKOVe6vM4ebc7qUMr4vHyQB/FVqFNX03sKUiH9eMy9g5W92gd5K/ZTTAeOSEcj
oZRnFe/DSiLjrG2en1k8lqszfEDYrnc05fisYtyv4KE2Q1VKHncIwit6f+7gx5euohyMhUvGo1i1
tldv9FZrphSrQrc4XCFcaAs9iciuBudLYa9uznf3ENFg6b56x/SiZhtt2YeqpEuQ6KDEUEQJ57IJ
1QnqOLx0scDDWOg25Q==
--000000000000fcae3c05f5f9b412--
