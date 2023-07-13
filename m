Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A21751741
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 06:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjGMESH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 00:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGMESG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 00:18:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEAF19BE
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 21:18:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so7919a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689221883; x=1691813883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UxHyBln4ogxOOlFEwoM2ylcGD+jdPv+WdcKTjorv1HE=;
        b=WAsawoTmEjaQKCKLIfCptJkRrwfgbXqkKmeiCUK19N4ZIWcK6bC3g21E7bd+9h3Y2y
         55SK4fOWt+EnYezucanyHNmtfQdwMxF+ywpyWhpaJKRpcm8iCVSpPp788DTpO1OTJ2Qe
         1CJip3NeTb68mF6djxM7Cx9hEAi47EoV3A18eIEgzZDjaYtAJ95PxG+/JGwGXeXhx7zW
         WGLAQtDppUNasPuTAiKMes373VqSLD0xpOBQXsSUcvLv/7KMpEqIu3yi4H901jdFKGf+
         3mem7S10+vMuncFZef3IwxW9UeXtZ6B1zKtSMYnUkICGA/ccPpVADZwKzHjVvzjFjWY4
         pboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221883; x=1691813883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxHyBln4ogxOOlFEwoM2ylcGD+jdPv+WdcKTjorv1HE=;
        b=aI0IhgF0wB8eQW0xnizsokKsDb459YEmYg2S5GtW2SVyjeK6gkx5tiYaXi7m3IeTGq
         5t8m7ZP3lR7XQF3RlIgQmPwR5yOlCtD9f0J08/9bARJt+o+pbjr/1pL4nO7xacSZnxsq
         UXQ6ecmXNHeGiijv0HK/aM9bG9ACrzAbKQmlJhIm5WIlxJGCIjsxLv6MLMHZ0jh2VOR/
         u1n81p6cTIj0YQ9SYlucLvS6Gax4SuvvqkMQl1J5gKzWPGcqkeYhCaFY847g2XkhKC4S
         MO6LFToC6m/exAnqUT0E+G0KLwuNu2gy6O9FUuLfsqB9RSrViAsYs2erjBtn5Vty9ju0
         GHKQ==
X-Gm-Message-State: ABy/qLa8jKy1Y5MM9oQbX/AZhQlMPmmlNcv9STx3x2OmTsdb4JgXQNKg
        fq3BMLFFI9lX03u3ii9Y5fzGMlchhAycHE8AF1C+Yw==
X-Google-Smtp-Source: APBJJlFfExe8G13ZlB8gnjM3mSBkA7p1atxW5Jhf4upMxlHzNOtlQPwz8FkvYpMRiMmiJ5oUOpQJTw6tfNSLHK28hFY=
X-Received: by 2002:a50:8a9c:0:b0:51a:1ffd:10e with SMTP id
 j28-20020a508a9c000000b0051a1ffd010emr190568edj.3.1689221883430; Wed, 12 Jul
 2023 21:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-regmap-kunit-enable-v1-1-13e296bd0204@kernel.org>
In-Reply-To: <20230712-regmap-kunit-enable-v1-1-13e296bd0204@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 13 Jul 2023 12:17:50 +0800
Message-ID: <CABVgOSkzui0e_1LhrMAeJG1RMFqyq472XNHod0tS452mUg2m+g@mail.gmail.com>
Subject: Re: [PATCH] regmap: Provide user selectable option to enable regmap
To:     Mark Brown <broonie@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005701b90600569eea"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000005701b90600569eea
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jul 2023 at 07:22, Mark Brown <broonie@kernel.org> wrote:
>
> Since apparently enabling all the KUnit tests shouldn't enable any new
> subsystems it is hard to enable the regmap KUnit tests in normal KUnit
> testing scenarios that don't enable any drivers.  Add a Kconfig option
> to help with this and include it in the KUnit all tests config.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thanks: I wasn't totally convinced of the extra CONFIG_REGMAP_BUILD
option at first, but having thought about it some more (and seen the
ASoC topology one, which has always annoyed me for being a pain to
enable), I've come around.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/base/regmap/Kconfig                  | 12 +++++++++++-
>  tools/testing/kunit/configs/all_tests.config |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 0db2021f7477..b1affac70d5d 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -4,7 +4,7 @@
>  # subsystems should select the appropriate symbols.
>
>  config REGMAP
> -       bool "Register Map support" if KUNIT_ALL_TESTS
> +       bool
>         default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_FSI)
>         select IRQ_DOMAIN if REGMAP_IRQ
>         select MDIO_BUS if REGMAP_MDIO
> @@ -23,6 +23,16 @@ config REGMAP_KUNIT
>         default KUNIT_ALL_TESTS
>         select REGMAP_RAM
>
> +config REGMAP_BUILD
> +       bool "Enable regmap build"
> +       depends on KUNIT
> +       select REGMAP
> +       help
> +         This option exists purely to allow the regmap KUnit tests to
> +         be enabled without having to enable some driver that uses
> +         regmap due to unfortunate issues with how KUnit tests are
> +         normally enabled.
> +
>  config REGMAP_AC97
>         tristate
>
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index 0393940c706a..873f3e06ccad 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -33,5 +33,7 @@ CONFIG_DAMON_PADDR=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_DAMON_DBGFS=y
>
> +CONFIG_REGMAP_BUILD=y
> +
>  CONFIG_SECURITY=y
>  CONFIG_SECURITY_APPARMOR=y
>
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230701-regmap-kunit-enable-a08718e77dd4
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

--0000000000005701b90600569eea
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD9
wrwVthY0C9S0YJ3hYy9opnPigKNPhNBlaORts7fapzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTMwNDE4MDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAC7kb++0HobZNLkNwM1pZ
1zI4kk4LLEaxv73pRDkVMZojMtZjvsRphm1M8p3DirKe1w9pf1UpHkG/H5pZMWAnkDO3j5uuVAmI
t7AU+6Rgcvtop06PdbPMS7OPJEqXOGwrtrd35ZI7HMP6nezJY2KU2foFtWrbUh2DKPDyvTR3WhXq
XvJ3J/gSvoNH6Qz0nXKujv0F2/y5hwbWph8LLwQuvJ/YcB38PSRC6EopX278M1boDDQIZnlG765l
hSAcBUj0zkA0jrGnUMN7hJ0I+ZTkJAvxSsMwiVNX62XVtpiGTZWogptKNdnvS++0HMIufoIjl7Cb
/HfV+y5tWEq18RYhLA==
--0000000000005701b90600569eea--
