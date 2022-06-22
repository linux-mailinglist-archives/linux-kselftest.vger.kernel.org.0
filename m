Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3D554453
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jun 2022 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352541AbiFVHQT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jun 2022 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352562AbiFVHQS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jun 2022 03:16:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8BB36E21
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 00:16:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m1so14263162wrb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLDYmE+xsTENkEahYNzL5VBtWKlvkCPWhFvcQjZU9fg=;
        b=bOIyecfci3LKu/nWBculxcxmnLFceyXRemh6IFsh5FL/VfcMGaMTGd9dxo8+qp00e4
         /tqa4TRp0uicoElY9zSyMFez2vSsHmvGYkr9gD2Ly50rZNOdBPJbxK1Rgo7oGWYhfKfE
         ZJTg44XB7DIBRZHwN+T+MFKcDUJZJA7czsnLXjJPlpv5S5zqCe3xbMGbJ/ZBNvkoRcOg
         HLy9kW7pHYhcIQ8U5XlPWi8DPhzYprEukqLH1Pj+WJmlYChVtQgBoSdXETUJm+E79KmX
         Oi3NDg29u8weYp6GfwBcnGg9AjZk/Q6rtW7z3dQzvxfhZ76ldmj0v6WoiY/JccRGbH51
         gWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLDYmE+xsTENkEahYNzL5VBtWKlvkCPWhFvcQjZU9fg=;
        b=0iJm2Oc3lIPqpLoiP6KDeKEh/H3eEzQ2TFn5L0J/MAUBw3Y+3REL+Lzsv2T0t45os5
         p5AhWPKYja0msaH4+vPrmRMLgVZ9j+Pi4DIIxk5A5MJEf7JKtxSTd+CVozYHUJx8EOUq
         TAUKrIz0bzilLGhGtDtukHn+4pizc+aE34DdmUfQSqDePBgyVO3O4hWq8YYdws6PMTyS
         nQ9zUDK2lCMQczQgqbTxVe6pZN+oeYFsYUUST4I+NAi5kPy/uyETHOOY97fOKzTS97yk
         NjWr5v5Ey1UBNuxxc0oowAkcU8lvPPqg8z+4BTYSew+K/59/nn/5JxDlH2Btu6YIAhhj
         EvHA==
X-Gm-Message-State: AJIora9TENdfYbXo2SwUFtBX65ChNau7z9EjuOLBr05sS7orvTZMUKLd
        MgFVttVXT8i2MZZLsbXgttP4xhYL6BBUNdSknal0bA==
X-Google-Smtp-Source: AGRyM1tCZmF74NPe0ihlmXBCpgdH9Z16UD41QxdqlzJg3ptuyeQtd337BFOBJWJ5yCJ2w6VfBacRyIn19z00N7AB3LY=
X-Received: by 2002:a5d:570e:0:b0:21b:9610:2dd7 with SMTP id
 a14-20020a5d570e000000b0021b96102dd7mr1682277wrv.337.1655882173160; Wed, 22
 Jun 2022 00:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-4-davidgow@google.com>
In-Reply-To: <20220621085345.603820-4-davidgow@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 22 Jun 2022 15:16:01 +0800
Message-ID: <CABVgOSm-bgjTzeWjEtDZ+3f-zJLxjywtgVSqWu2-cK_ScRLHwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thunderbolt: test: Use kunit_test_suite() macro
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-usb@vger.kernel.org, linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000be716305e2041c45"
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

--000000000000be716305e2041c45
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 21, 2022 at 4:54 PM David Gow <davidgow@google.com> wrote:
>
> The new implementation of kunit_test_suite() for modules no longer
> conflicts with module_init, so can now be used by the thunderbolt tests.
>
> Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
> enabled.
>
> This means that kunit_tool can now successfully run and parse the test
> results with, for example:
>         ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
>         'thunderbolt'
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220618090310.1174932-4-davidgow@google.com/
> - Actually include the Kconfig changes, which were mistakenly added to
>   the next patch in the series in v1.
> - Add Acked-by tag from Mika Westerberg
>
> ---
>  drivers/thunderbolt/Kconfig  |  5 +++--
>  drivers/thunderbolt/domain.c |  3 ---
>  drivers/thunderbolt/tb.h     |  8 --------
>  drivers/thunderbolt/test.c   | 12 +-----------
>  4 files changed, 4 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> index 4bfec8a28064..2a063d344b94 100644
> --- a/drivers/thunderbolt/Kconfig
> +++ b/drivers/thunderbolt/Kconfig
> @@ -28,8 +28,9 @@ config USB4_DEBUGFS_WRITE
>           this for production systems or distro kernels.
>
>  config USB4_KUNIT_TEST
> -       bool "KUnit tests"
> -       depends on KUNIT=y
> +       bool "KUnit tests" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
>

FYI: It turns out we can't just replace the "depends on KUNIT=y" with
"depends on KUNIT" here, as it's still possible to have CONFIG_USB4=y
and CONFIG_KUNIT=m, which would lead to missing KUnit symbols during
link.

What does work is adding, in addition to "depends on KUNIT":
depends on (USB4=m || KUNIT=y)

Which will prevent the tests from being enabled in this situation.

I'll wait another day or so before sending out a v3 with this fixed,
in case there are any other issues which arise.

Cheers,
-- David

--000000000000be716305e2041c45
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB1
Mdw9axuh90nzbVhFE5gRjx4/lShMFfC1KFUOOrHCszAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjIwNzE2MTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAf3I8xG1SnEmHZXnfmfTP
awx1EH5au/l8uN//Zd4fylWYSxYSgJo/cDHyaiEdxFh4eqZZbMIYSPyk+1mZeBofz1sEkYvpIYhb
IIoD1CBjrtM3ihfZDjiT7XnH1y/dusUcAmJlVZh9JrpH7zd9ZUqgM3I7KXMHSyjXK1B0yGxZMVIq
7PTfM0fVQQPfrlndAtyQ3TFAWaYFzcT4eRIvoBMlSR/GpPEuew8n0LOI5I9TfKGvS9xEgCpHJDvr
2cesuzmSjZaASJusIbCMZq/ZI/GRrqtN8+p2GgDD+8MXqiCnlFZlNuUMF55ZMctJgWghGx9oOCM+
3OaLc/IGlqK8cowXmg==
--000000000000be716305e2041c45--
