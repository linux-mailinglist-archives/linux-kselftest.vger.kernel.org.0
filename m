Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30336751746
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 06:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjGMETd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 00:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjGMETc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 00:19:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ADD19BE
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 21:19:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso1345e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 21:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689221970; x=1691813970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAVqoAkgKdWrHrTSa+iyGqgU6SR6hEY6dTzQdYzP60s=;
        b=UlLwlw/X2kIaItgTezIeTQ93pUtYTZKZ8YcSmf0N77AMg/V6ITwgatghcXE6eqhaXU
         hKruD4TXx8K7OPtpJT7eLeMg4iBifydTOmk/r1Wtw8h0H4pY2jfjRg18eCq7ZElI8TMR
         3tDzv/H5oAxp9MQ+3mw8mnRnId2E/GZLFIMG88n0xHt3NvkULg4KbQLcz+5Uqqz1AJrO
         j2Vh4QhhuPtOcyhgpzFpZgehqVSwy+6W+LdIVngs+aB9Mq9gGAtzOrEGwRblDp37Zd8+
         8UV6mOKW/1p3ILWb1b9uGSI6FcMaaDl4NvkbwDhQlqvtCVxA9WFHg145K4bSLvoRDzX9
         CgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221970; x=1691813970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAVqoAkgKdWrHrTSa+iyGqgU6SR6hEY6dTzQdYzP60s=;
        b=gPDd2y1bZiZ7ShtH0kjHjYMjcpLkQdTSuoawtEtjCc6Ys6N19PpfyAusS0cGhjNdnY
         6PJXpNUOVzC3WHzBiJjiFa36Oxn48SFXSJdpqxlzXwZI+Y+MR3xCWhHeanqQ3bEpxvKx
         Vh51cqbJ4AQdsM72kbHEBpoAPj5iome0X1fvv17EnpoQEkb0ZuZZp2tPXYjDKogOqlMg
         T3kMkEbcG40vEAngGtoKy4cUDLovD7ZV66u+rKpMNNB/AoZrgObmI9/Ol69Uk+zKtPwh
         ZJJ/3zTbZA1ONNihswC+Hg96COd5BKeceHcSYS3yueLAaVw+FzfX8p7fBZfqLddc0lUJ
         50wA==
X-Gm-Message-State: ABy/qLaiDkcHA05dfFPXRS1mhnr7tpt/tqOndPRx50IUKLHwntReIzVw
        aFF1fzutdey1hZ+YvTyZ2LQas7/IX82b+YBCT/HFVg==
X-Google-Smtp-Source: APBJJlGdAvuZx8z9RY9fvcFFO+gWtJz9o0OJLT8tnUU9EmJLzzrXKn0QYq/L/DL4YVlQoULBLwZLBtlhWyPj+km/MCQ=
X-Received: by 2002:ac2:5fe6:0:b0:4f2:7840:e534 with SMTP id
 s6-20020ac25fe6000000b004f27840e534mr117806lfg.0.1689221969815; Wed, 12 Jul
 2023 21:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org> <20230712-asoc-topology-kunit-enable-v1-2-b9f2da9dca23@kernel.org>
In-Reply-To: <20230712-asoc-topology-kunit-enable-v1-2-b9f2da9dca23@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 13 Jul 2023 12:19:18 +0800
Message-ID: <CABVgOSnit7wXsMUvpXUhrHtyegm0KOuvtMrtp47PLTRJr+aFag@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: topology: Add explicit build option
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007bac48060056a324"
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

--0000000000007bac48060056a324
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jul 2023 at 23:40, Mark Brown <broonie@kernel.org> wrote:
>
> The default KUnit build options are not supposed to enable any
> subsystems that were not already enabled but the topology code is a
> library which is generally selected by drivers that want to use it.
> Since KUnit is frequently run in virtual environments with minimal
> driver support this makes it difficult to enable the toplogy tests so
> provide an explicit Kconfig option which can be directly enabled when
> using KUnit, and also include this in the KUnit all_tests.config.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thanks a bunch for this: the topology tests have always been some of
the most annoying to run, and this makes it so much easier.

That being said, it does still break when run with ARCH=um (see the
response to patch 1/2), so we might need to remove it from
all_tests.config or make some other changes.

Having the CONFIG_SND_SOC_TOPOLOGY_BUILD option is definitely much
better, regardless of whether it's default or not.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  sound/soc/Kconfig                            | 11 +++++++++++
>  tools/testing/kunit/configs/all_tests.config |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index bfa9622e1ab1..439fa631c342 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -38,6 +38,17 @@ config SND_SOC_TOPOLOGY
>         bool
>         select SND_DYNAMIC_MINORS
>
> +config SND_SOC_TOPOLOGY_BUILD
> +       bool "Build topology core"
> +       select SND_SOC_TOPOLOGY
> +       depends on KUNIT
> +       help
> +         This option exists to facilitate running the KUnit tests for
> +         the topology core, KUnit is frequently tested in virtual
> +         environments with minimal drivers enabled but the topology
> +         core is usually selected by drivers.  There is little reason
> +         to enable it if not doing a KUnit build.
> +
>  config SND_SOC_TOPOLOGY_KUNIT_TEST
>         tristate "KUnit tests for SoC topology"
>         depends on KUNIT
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index 13d15bc693fb..b8adb59455ef 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -39,3 +39,4 @@ CONFIG_SECURITY_APPARMOR=y
>  CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_TOPOLOGY_BUILD=y
>
> --
> 2.39.2
>

--0000000000007bac48060056a324
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD6
1qUKUli7cUNqI1whY3PFPcDuZIfpmUQw1X0e8EtvvzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTMwNDE5MzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAO18mtowm6y47BaRQPvJr
CslusZYPXaRv20aNq5gAYrHymp3AXR+I8pnEwrDz1MMMu0NfR0L2Y8tgUE9Q00if8RfGq/omf6T2
lOlNQfAK0FBLQqRj4tLvvIphBp0fBC/n7SWUGcXxqCQ+5CnIr5GvdTD3WaeagHzNLAlkpt00l/he
TXRJaYx+cV/owX6/wCz+UiqRvIVyQUf9sh4SxeAlUSguxRTaZS54TMWgJxtSlUrma5ckb218DGBh
SGDxBjHUktRkgSimk2F5+pzFRNoMofrfiz//4Ih/iMvFXApuI7v7gxGwI3F23Vywbz4I+GM0CB6C
Q8lfBdJ3L+tyW1shxg==
--0000000000007bac48060056a324--
