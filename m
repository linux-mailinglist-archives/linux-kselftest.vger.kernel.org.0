Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5538C75775B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjGRJEB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGRJD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 05:03:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD610EF
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 02:03:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so69975e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689671032; x=1692263032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqM14CIuzwGpcGIYxRgFKt02PLcjClZQZKc9WyW+QUo=;
        b=Na7NLrMGnok2MHH5pxIblxq51b/F3tuqm1Jft2AJQhMho8vwuCP+5qya+wf58V55DT
         bvjkr27KfY+WaE3DgC4M5ttKlbC0U6JqfITY2ggGdb7+W/ewaXz/+r+64xXy5T7yxuIE
         pmUSRPPa0JdB31UyS7ZjqcviL+qlHQ8eKk8VHZVkPjw0CNnKBCZms5MqfrSQS8TpO6Qg
         ddh7pDGy+G0jqecP22E6x/dz5204VQY5AdPggEctwMAsd2zZkvLulxY81MbEZnSdxxah
         VP/eevAK1KXSJyhMCENO1cUa3nRP3huj4Ar0XQwZtoLj69oTD+LJ7RUQpibHxKhXCP5s
         o+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671032; x=1692263032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqM14CIuzwGpcGIYxRgFKt02PLcjClZQZKc9WyW+QUo=;
        b=cc+vu/Q8rMwCTzuZuzUyVFwsnDeW+dJuGdvvx5acp6avO6N1dJAlBjAYvjghn/1Yy6
         YoMoEWNt5bVSM23j0JGsMDaIpWcLyw71myGrFpCWRSXLFUAIbPIs0Q0CfLOLr/XwaYzG
         JRVLBHTvlsndYsOEFFZC6KvcPeJbvRGOZclocZbisqhcDyScXVpTZ6an2JAXK/z9hOQA
         WesL5BEf6YNagRLDNBUDeT7pbWIoHBCPoaT+VFSttYvp5X2er64v+pH0fj9cJ8bgW6gf
         zHGMsq2A2rfY3yBlUYiFbDpBSq56DrdCykhBpQjPBgcnI3jY7nSp19Az6MJIO0UEkA9y
         Txhg==
X-Gm-Message-State: ABy/qLZiAzYMDv625a1BeC/98FlaqlLldg2k01fs9kRsUCga2owpnTYv
        Fi8+IuCzqR1nUCC4nSPGd0fWfWGuB7D2MYjNZno9Sw==
X-Google-Smtp-Source: APBJJlHzArV2QXKYgA0t/tMpHektEc9XvleJFYO5Jycq9SutDVZ7cVY0PIL4w5F/KfUe0rAC0x+iTEAq8f0TIrcvl10=
X-Received: by 2002:a05:600c:a39e:b0:3fb:ccae:cd4b with SMTP id
 hn30-20020a05600ca39e00b003fbccaecd4bmr80956wmb.2.1689671032449; Tue, 18 Jul
 2023 02:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org> <20230718-asoc-topology-kunit-enable-v2-4-0ee11e662b92@kernel.org>
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-4-0ee11e662b92@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 17:03:41 +0800
Message-ID: <CABVgOSkJ9KASn9zxWMr23xh0U61er0WUPwQprjq1ADY67oxX8g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kunit: Enable ASoC in all_tests.config
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b1b0e70600bf3153"
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

--000000000000b1b0e70600bf3153
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jul 2023 at 08:30, Mark Brown <broonie@kernel.org> wrote:
>
> There are KUnit tests for some of the ASoC utility functions which are
> not enabled in the KUnit all_tests.config, do so.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

If the other patches go through, this is great for me. (I've already
used it to test some in-progress changes with the struct device
handling.)

I'm happy to take this via the KUnit tree, but if it's easier to take
all of these via ALSA or another tree, let me know.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/configs/all_tests.config | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index 0393940c706a..13d15bc693fb 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -35,3 +35,7 @@ CONFIG_DAMON_DBGFS=y
>
>  CONFIG_SECURITY=y
>  CONFIG_SECURITY_APPARMOR=y
> +
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
>
> --
> 2.39.2
>

--000000000000b1b0e70600bf3153
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCF
sYO2UYX/gHmix0YPXh2VEw4AHvbkwusegwfPsgnKmjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwOTAzNTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALG6ZrOhvkpDokYbc2aaz
YqAZZIWcv+jZTYOhpKrQREFA1XDaRxDFsN+HKaycw+KrXpHU4z1uWym7CoE5sT67oStrV/xQdoOK
pMialboDhCoxibS80ei0IwQZZyIC+lzHINy4P3aQtIpZ+k/m+C4AgFOk8dHw8r8MGOSwu8Q5lcZS
qL7aAAebTmWd8XVD+ExJ64ZD16ew1pW5iQBqH645S+Q3VDvkg1n6noYBmRn8nQFZ282Zx22GzYOu
J7Vp1Apzuy1hOaof9KGdoBU/g5/G5pRkJmqF3MrrhQusEShSWUg4Q3l2gky5HJMPdkQMwBX+k5vi
eN+3Mx43UvxSlZeW3g==
--000000000000b1b0e70600bf3153--
