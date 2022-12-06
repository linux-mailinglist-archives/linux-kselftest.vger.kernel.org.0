Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F54643FFA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiLFJlA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 04:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLFJk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 04:40:57 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB21CFDA
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 01:40:56 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id k185so13649040vsc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gE5GPmUD971y2FMze2gTNhiNSkGVcOrXJfqE8NCrGbo=;
        b=qU0NHxB37K9p1KULHa/DzEyu4DRD4lIYd+gE2dlFN+2KKkkQ5oXF6xse1PKJvrhdzL
         mB/JKN1ecz+Lfy+W9yR2naOFKSqjWFiI68TWJ7QY3rObywc/vTUNQ7OLzURepzR1c40h
         dBO0/wamhkve+0VeV7+0CCUT/sa7iwFiTIASsmxQoJyqY9irewJrgiCfm/CuIXD/ze1s
         jjg9mUAlSfVwx+4qBkRA8Fv8Rvwa08FhK3lcg0TN9dBwC9SO2YE919I0lgssbwtHeBqf
         YCRFfoy6ls5Mxn2iq2VqGgGBB2EEOXd97ViHZcksn7FFpLsIr1SoATkF2tyxjqeKGkGS
         zNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gE5GPmUD971y2FMze2gTNhiNSkGVcOrXJfqE8NCrGbo=;
        b=IJ+GQJy4Rif/ZIhVgc7ywhbQGuMIsmSheAChMBpWtNz4GJ2jrSdwMuPpw+ZZ6iKXrP
         XWf+Qib4JmluiovNIS5Cm0jZr2kRH4b7Y1pM9pOLbpF3Jifa5dzKMO6C1ejP6zhbnhXD
         1uW26FVFjtGpdVDitguZy6gO2Y8qfrzsIxa0VHtoke2PO3ajOvwBKgHn11ovejGsdBAT
         74a/xSW4dCVo3AIpgW94S7mOFQzNJNC0EDBgiBp9bEyC1HwbYKarf8I/Gi06CNdrFedD
         yMf/iSfx/+GD6/sI9Ekoz3EeHFeKnGs0q0a26+0PXjJcBK49eCDABdgSw0EA+IAeEyA1
         uKVw==
X-Gm-Message-State: ANoB5pn3kFXU2P3NlS69SIWkxEdw++KhN1EmpXrrRvUaXhgTJk/FmOGg
        pr6H93gmZ5FNPGHFptPxpdAIDxsLDjrlpPnfqrw4nUV/knU8cIly
X-Google-Smtp-Source: AA0mqf4uaj6ut49IBfTywhLtdi/EbmXJ50cLe0Q6W+7kkxX9XAUfm75JBxsTGsRLd4WjjDu90A85nYL9ZTa8L2h6bwE=
X-Received: by 2002:a05:6102:c0d:b0:3af:2b1c:9908 with SMTP id
 x13-20020a0561020c0d00b003af2b1c9908mr50138337vss.18.1670319655918; Tue, 06
 Dec 2022 01:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20221205215058.143688-1-rmoar@google.com> <20221205215058.143688-2-rmoar@google.com>
In-Reply-To: <20221205215058.143688-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 6 Dec 2022 17:40:44 +0800
Message-ID: <CABVgOSkRkN9OGHKcAuG98vV2SeFoSJ6yOUGNoaJ2=8ZFyYBwUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        john.johansen@canonical.com, skhan@linuxfoundation.org,
        tales.aparecida@gmail.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c5126405ef259973"
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

--000000000000c5126405ef259973
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 6, 2022 at 5:51 AM Rae Moar <rmoar@google.com> wrote:
>
> Create two macros:
>
> VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
> is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change to
> the symbol definition.
>
> EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
> EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
> use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
> use symbols.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
>  - Separated the documentation comments for macros.
>  - Changed copyright date and author for new header file.
>

This still looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/visibility.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 include/kunit/visibility.h
>
> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
> new file mode 100644
> index 000000000000..0dfe35feeec6
> --- /dev/null
> +++ b/include/kunit/visibility.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API to allow symbols to be conditionally visible during KUnit
> + * testing
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: Rae Moar <rmoar@google.com>
> + */
> +
> +#ifndef _KUNIT_VISIBILITY_H
> +#define _KUNIT_VISIBILITY_H
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +    /**
> +     * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
> +     * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
> +     * there is no change to the symbol definition.
> +     */
> +    #define VISIBLE_IF_KUNIT
> +    /**
> +     * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
> +     * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
> +     * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
> +     * in test file in order to use symbols.
> +     */
> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
> +           EXPORTED_FOR_KUNIT_TESTING)
> +#else
> +    #define VISIBLE_IF_KUNIT static
> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
> +#endif
> +
> +#endif /* _KUNIT_VISIBILITY_H */
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>

--000000000000c5126405ef259973
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCA
1KYOJESRkGBQRFVCK56rYb4dXo95wJJ2wFokCdeCZDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMDYwOTQwNTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbm+VMjSfGXuMCADuzQQn
yMIPmRO27SfzJ2Z+2p//EXshs5cq3J5sWsepUrR2dB+/Fis5GYnMTlOL7+JV5vy++FAA0lrDV/7k
xz+8aXzmHOxuPeXdAVC7tF2+KwbdOLz7XSnGvO9nmJ5GetiNnXIqI7cxhqdYgXdXHpgE1olOsUpM
rs6JrtAARKOFgB7BGe6Q6nuiNb1ceBgSi0FnkO9IIoftOoJb1I+h6aVW0enxXm1ZYksmh/7qqnIY
K7/gBboRKhweeUyIQ6H4AF3yRPa/OweS3lZPSEO+qC6Rt19ON4LLFevhm5O3/C05e2a50cMq0pFl
iVRUPyRSMrwvq9Uf7w==
--000000000000c5126405ef259973--
