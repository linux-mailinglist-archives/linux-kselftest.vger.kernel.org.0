Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D10559465
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiFXH4C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFXH4A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 03:56:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0769ABD
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 00:55:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w17so2000580wrg.7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPJm/qNXWJZ9PMgbM6Pwy5cVs7kISxvsadeHgSy00gM=;
        b=c5u3EjMMaWLIpg1gQb40f0gjgKPiF3M6faQUE03t5llwDTnW3FzI2rONHgOHwztvu1
         kOtxFZ4Tr9BAtdfxcPGutymK3FKz9sCCqN8aXYY+/isTJc536EkNZ7Fc4KP+oYjOP5uv
         eOyjy7V17gxfYClph+9m7S3rFCj6N6tsTKOFRaZQxcX0Hvi8TCBubnd+JxfOTmB0b9D5
         5c68GFDtqkmpMJiL2VRReNjSmt7u6UU/eDin4tK+ZCNfRDhrGClrskR4yEhX6jKRqcpm
         KQiXbNgKRm6PbO5aLWSfH+P1H2toksjjzhLAUq6oylx9OCLQxGAwfD8xIa96MNqcgWRk
         h4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPJm/qNXWJZ9PMgbM6Pwy5cVs7kISxvsadeHgSy00gM=;
        b=yRyniMyj35ETSKiyOj01QJ+FH+dwthZLjQMQcW+p/MpXxk4GnqoFdQ9nCRlEMAehTS
         CwcMzmsHhk8CggWvzaiNlPqZr0Rd7SxvRazNXloCIj0PhIEe5nlHGuLgBnVZDpgpGMoH
         dO++2c74CzrH/aBGY0ln73aTwsDnhwWRpmQytpDtLUyJhw6KcLU6+7ocvfavEXRlNzG2
         ZO9siWtkzQXHfMxvKXAIvAXRKMSPCX4WytPiewLYuWbMz9TL6MiQ5s9O09UWd/tPQVhL
         9ZTrKErA7aKy/E7EPaeIKmFh2kJYbd+dlQDFzdR53BspogTw+ZnGs4wJh22YmRGTXRsb
         012g==
X-Gm-Message-State: AJIora/1/h+nodbqhkntqzUWTZMRR2cEaEJwW5625JpI22j7cpjtMJyA
        YE9+uY1RjBXpboptpESqOkDcZ2HLx53BqnKEm7apSQ==
X-Google-Smtp-Source: AGRyM1t6p4mfPpsIIJ76L+72Jh+526eHae4RXFYj2M7Q17EEr6jk9tdRLhvU1GpEfX5RXWodpO1eSl/q1L0F7eeXq1Y=
X-Received: by 2002:a05:6000:1ac8:b0:21b:9239:8f28 with SMTP id
 i8-20020a0560001ac800b0021b92398f28mr11985741wry.517.1656057355961; Fri, 24
 Jun 2022 00:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220624001247.3255978-1-dlatypov@google.com> <20220624001247.3255978-2-dlatypov@google.com>
In-Reply-To: <20220624001247.3255978-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Jun 2022 15:55:45 +0800
Message-ID: <CABVgOSn_v8p2nRaioz2MK0FEV6UmzfHHFipiqy05d54y73XFzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: add coverage_uml.config to enable GCOV on UML
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000072d47a05e22ce6eb"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000072d47a05e22ce6eb
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 24, 2022 at 8:12 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Now that kunit.py's --kunitconfig is repeatable, let's create a file to
> hold the various options needed to enable coverage under UML.
>
> This can be used like so:
> $ ./tools/testing/kunit/kunit.py run \
>   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
>   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config \
>   --make_options=CC=/usr/bin/gcc-6
>
> which on my system is enough to get coverage working [1].
>
> This is still a clunky command, but far better than before.
>
> [1] at the time of this commit, I get:
>   Overall coverage rate:
>     lines......: 11.6% (34112 of 295033 lines)
>     functions..: 15.3% (3721 of 24368 functions)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me: depending on whether or not we do something like
[1], we should add a pci_uml.config as well.

Alas, I don't have a working gcc 6 install anymore, so I wasn't able
to test the coverage here, but I at least got an encouraging-looking
error, and the change looks very sensible, so:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

[1] https://lore.kernel.org/linux-kselftest/20220622035326.759935-1-davidgow@google.com/


>  Documentation/dev-tools/kunit/running_tips.rst  |  3 +--
>  tools/testing/kunit/configs/coverage_uml.config | 11 +++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/kunit/configs/coverage_uml.config
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index c36f6760087d..205ea21c9cca 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -123,8 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
>  .. code-block:: bash
>
>         # Append coverage options to the current config
> -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> -       $ ./tools/testing/kunit/kunit.py run
> +       $ ./tools/testing/kunit/kunit.py run --kunitconfig=.kunit/ --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
>         # Extract the coverage information from the build dir (.kunit/)
>         $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
>
> diff --git a/tools/testing/kunit/configs/coverage_uml.config b/tools/testing/kunit/configs/coverage_uml.config
> new file mode 100644
> index 000000000000..bacb77664fa8
> --- /dev/null
> +++ b/tools/testing/kunit/configs/coverage_uml.config
> @@ -0,0 +1,11 @@
> +# This config fragment enables coverage on UML, which is different from the
> +# normal gcov used in other arches (no debugfs).
> +# Example usage:
> +# ./tools/testing/kunit/kunit.py run \
> +#   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
> +#   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
> +
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> +CONFIG_GCOV=y
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220624001247.3255978-2-dlatypov%40google.com.

--00000000000072d47a05e22ce6eb
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA7
9DkrC60LvAAcaaUuyb2IjWG4gaSFYHowGJ4mZu2UfjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjQwNzU1NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdHH9IDw4uwrAlgfP7zQF
5QYz2Ize8XK0oNurxC7JWgJDzHW6NzTYNuVv1PuZ8cdHzQ8AFO6DPMdmFOseqYdehCNgMz7Toksi
cu8h7PhBQPGQB7MxNfEotQI+42xYYL95Zi/2pCOqWKrZsYhhqpRZzarHRbtJF6/lJkKBUYjhnzKl
wt8FOsIX9llEwziWu/ev+3fa5myR33JRqOq8tKRkhBDgs4U3ebbL+LUBe9jExNkFZzqjPHhPH885
jQK3be1Y+FGj9yvmoaK2v8Qn82ppWoLSatQGKv/eGwwYzrWkNTI7iZtv9v7XzT1rteeanhKCOuQZ
KBreKI5tFU0ojrpN/Q==
--00000000000072d47a05e22ce6eb--
