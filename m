Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A86BE327
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCQIXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCQIXK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:10 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9863B3DE
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 01:22:43 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id t4so3836504vsq.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679041362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zl5pK+irbQo59NTih19zhiITxE26grR38bxbR0xH7dI=;
        b=ML8NgOzRPrWFDtXbvFFXfytIBzGo501p1OZKahtghwmTM0xtcfFDJHsu4tuJ32hJyQ
         +jcCMKZ8FRgd8sJDqXmedmcbu8e3gvVT+PlKOSTcrUqCUkVUwnSUJkMYm9L2y7d+4EEI
         IeD7LgxGVAn0Kn6lXB/8Livpe0LijP4MmKE2i+Pp/5qkdDVK5jZhuBUnYITlI6N9W+/r
         dLxu85kb8IX4fjLZBsken15/lLxw5kC5kPr738xthlYqfDZoVMbVaA1LV1+9AfZO4VAO
         avwznV3nJCpz6BsEqKcxXD45OSuZPOou3B2B1z0Z2HLq4wbrvHX/ezMa7nLf6ve3hpyB
         HlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zl5pK+irbQo59NTih19zhiITxE26grR38bxbR0xH7dI=;
        b=EEb37Rfpf1lJ5GkFix7W4QqX2S7XG4CmO85PfZsvQk2fnNJ6ihB2GldypO7n4V2t40
         8YURwGC9w2j1MwwKWjldjLFA5RgHDjwQV2xOsYath1wtSYgsBncJtVsveB6sIGMZ5G2c
         18tqragIMrzmVhwwobFwK1Ay5IXF+rKA7awXIaU1V5aTqZk6K9bDpRlx7UJSz+8eAkSf
         yVynE9AMMdqwGfHCN5ulq2KfAZ0YMborDHS+ZoXTbIJCKLx+8NVylvSxZDuIaQzAHkrF
         VsyJs6fEZPumz/wJBkj8gcRYSEm4ljrOKwL2jWYZhuY8urqcnq7l5oJwaIxZrObeIEI3
         ZuWg==
X-Gm-Message-State: AO0yUKWPDwEx+TpwasLJ2oWoII62PTiV/D3r+vIcK5hMjfuaQDYEaCk0
        8FhHpeXikc+DjYYG6RH4lxPrY7DUSIVb1AkeGOrtig==
X-Google-Smtp-Source: AK7set/9AE4RSZxJdKcBAH5kvuNKB5KDURWDDse3moefUQ7EjosATFwsHMtyRxtgDtAo+kXYHGpu6UK8/i7ekNNEf3g=
X-Received: by 2002:a67:dc81:0:b0:422:194a:8566 with SMTP id
 g1-20020a67dc81000000b00422194a8566mr20213687vsk.5.1679041362233; Fri, 17 Mar
 2023 01:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230315183729.2376178-1-sboyd@kernel.org>
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 17 Mar 2023 16:22:30 +0800
Message-ID: <CABVgOS=g6yvNg6xscZqa5fQdyWMEGJ0K9_86R3K7_Fa0wCM_VQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] clk: Add kunit tests for fixed rate and parent data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fb6e7c05f71447f2"
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

--000000000000fb6e7c05f71447f2
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Mar 2023 at 02:37, Stephen Boyd <sboyd@kernel.org> wrote:
>
> This patch series adds unit tests for the clk fixed rate basic type and
> the clk registration functions that use struct clk_parent_data. To get
> there, we add support for loading device tree overlays onto the live DTB
> along with probing platform drivers to bind to device nodes in the
> overlays. With this series, we're able to exercise some of the code in
> the common clk framework that uses devicetree lookups to find parents
> and the fixed rate clk code that scans device tree directly and creates
> clks. Please review.
>
> I Cced everyone to all the patches so they get the full context. I'm
> hoping I can take the whole pile through the clk tree as they almost all
> depend on each other.
>
> Changes from v1 (https://lore.kernel.org/r/20230302013822.1808711-1-sboyd@kernel.org):
>  * Don't depend on UML, use unittest data approach to attach nodes
>  * Introduce overlay loading API for KUnit
>  * Move platform_device KUnit code to drivers/base/test
>  * Use #define macros for constants shared between unit tests and
>    overlays
>  * Settle on "test" as a vendor prefix
>  * Make KUnit wrappers have "_kunit" postfix
>


Thanks! I like this much better, and it is working fine here under UML
and x86_64.

There are some issues with other architectures (mostly endianness
problems, but I got a refcount underflow in kunit_remove_resource
after platform_device_alloc_kunit_test on sparc64 as well), but
otherwise it's working on most of the things I've tried.

I'll play around with it some more next week and dig into the code in
more detail, but I've not seen anything I dislike about the overall
design so far.

Thanks!
-- David


> Stephen Boyd (11):
>   of: Load KUnit DTB from of_core_init()
>   of: Add test managed wrappers for of_overlay_apply()/of_node_put()
>   dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
>   dt-bindings: test: Add KUnit empty node binding
>   of: Add a KUnit test for overlays and test managed APIs
>   platform: Add test managed platform_device/driver APIs
>   dt-bindings: kunit: Add fixed rate clk consumer test
>   clk: Add test managed clk provider/consumer APIs
>   clk: Add KUnit tests for clk fixed rate basic type
>   dt-bindings: clk: Add KUnit clk_parent_data test
>   clk: Add KUnit tests for clks registered with struct clk_parent_data
>
>  .../clock/test,clk-kunit-parent-data.yaml     |  47 ++
>  .../kunit/test,clk-kunit-fixed-rate.yaml      |  35 ++
>  .../bindings/test/test,kunit-empty.yaml       |  30 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/base/test/Makefile                    |   3 +
>  drivers/base/test/platform_kunit-test.c       | 108 +++++
>  drivers/base/test/platform_kunit.c            | 186 +++++++
>  drivers/clk/.kunitconfig                      |   3 +
>  drivers/clk/Kconfig                           |   7 +
>  drivers/clk/Makefile                          |   9 +-
>  drivers/clk/clk-fixed-rate_test.c             | 299 ++++++++++++
>  drivers/clk/clk-fixed-rate_test.h             |   8 +
>  drivers/clk/clk_kunit.c                       | 219 +++++++++
>  drivers/clk/clk_parent_data_test.h            |  10 +
>  drivers/clk/clk_test.c                        | 459 +++++++++++++++++-
>  drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
>  drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
>  drivers/of/.kunitconfig                       |   5 +
>  drivers/of/Kconfig                            |  23 +
>  drivers/of/Makefile                           |   7 +
>  drivers/of/base.c                             | 182 +++++++
>  drivers/of/kunit.dtso                         |  10 +
>  drivers/of/kunit_overlay_test.dtso            |   9 +
>  drivers/of/of_kunit.c                         | 123 +++++
>  drivers/of/of_private.h                       |   6 +
>  drivers/of/of_test.c                          |  43 ++
>  drivers/of/overlay_test.c                     | 107 ++++
>  drivers/of/unittest.c                         | 101 +---
>  include/kunit/clk.h                           |  28 ++
>  include/kunit/of.h                            |  90 ++++
>  include/kunit/platform_device.h               |  15 +
>  31 files changed, 2119 insertions(+), 102 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/test,clk-kunit-parent-data.yaml
>  create mode 100644 Documentation/devicetree/bindings/kunit/test,clk-kunit-fixed-rate.yaml
>  create mode 100644 Documentation/devicetree/bindings/test/test,kunit-empty.yaml
>  create mode 100644 drivers/base/test/platform_kunit-test.c
>  create mode 100644 drivers/base/test/platform_kunit.c
>  create mode 100644 drivers/clk/clk-fixed-rate_test.c
>  create mode 100644 drivers/clk/clk-fixed-rate_test.h
>  create mode 100644 drivers/clk/clk_kunit.c
>  create mode 100644 drivers/clk/clk_parent_data_test.h
>  create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso
>  create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
>  create mode 100644 drivers/of/.kunitconfig
>  create mode 100644 drivers/of/kunit.dtso
>  create mode 100644 drivers/of/kunit_overlay_test.dtso
>  create mode 100644 drivers/of/of_kunit.c
>  create mode 100644 drivers/of/of_test.c
>  create mode 100644 drivers/of/overlay_test.c
>  create mode 100644 include/kunit/clk.h
>  create mode 100644 include/kunit/of.h
>  create mode 100644 include/kunit/platform_device.h
>
>
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--000000000000fb6e7c05f71447f2
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAm
LD0bzOo1mGqnjDNiyk612P/TmqI26xsS4FiA39NZDjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMTcwODIyNDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAnMvBaiqgwWbHc+GYNLuy
ZzWSji42DQggTYSuJTH6GX49osxY/MC/tgZ6U7aEB5uXnBi4AZKfKB9GMUOWjU1ZsayRtu8PjISE
4WDI+xSidDZUTcQJVo6hho5nQeUmqk2UTSOr5XbFIOyhZlctvn6zYUrqF8/Rjx9RMpEVlKU4KdvD
tPWs4+hzAPy9Ai7aeeWHkZ3IxD7KRyKCwT3cdX4ZWoOFRfZGU7YcJygqd2CWKOCPmhUW7nh8klWn
olpHzCe2mfvwzuBydDC0YG6cYeL9mMDk6k1YS8wlaSU2op9+SDDxL1oighAZxPfDOm9IKqado/Ei
e7nMMLdSLzoUedMCYg==
--000000000000fb6e7c05f71447f2--
