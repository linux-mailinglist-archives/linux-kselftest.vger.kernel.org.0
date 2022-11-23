Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6F6355B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiKWJVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 04:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiKWJUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 04:20:40 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABBD742DC
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 01:20:39 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id u9so6596077vkk.4
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OWmkFV8OIvXMB0LNx+Rfdrv41pOXpwh5PgcyBE49Fak=;
        b=C2k51aEBbBGqsgdUZykWEBbZAzhQJsZreSQf31rX7kC0cQj8ociOtRfbCHF/kMd9to
         FyhF+eoG4a+MwBzkCakZW3CVJ3j/YeTA3VmDAXOkhspSTvMCK+GHfImbbsk01VtWvtac
         mo8RYATwtiApEz8OfTj/DffqAYylsBL60mlZuaRnpVLdZCySfD9c30cLztcElFU8sCUD
         mIY8EtqsbrXUnLH5jDrkq7qAY1UX9uNMTFU3K0CHrm9QNNlW9aLyWdXJEPCTT5VByz0l
         aM26khM/8wuEpnNYrNs3hx+5TvWhv9F/T5nYpDw/bHfzQQPL19sKx7fRc7fNmMu1vcW7
         lm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWmkFV8OIvXMB0LNx+Rfdrv41pOXpwh5PgcyBE49Fak=;
        b=1oaM1q2KgHs5OfP0jSx3PjgorYnkR54rv9pVQxHtSUaYHuQs3++JrXNlwqx9XlkrrP
         UBueYQJ6PXonhePpM9PaklAXZc6sTpOE0trWznUexw+TNp0ZfEmvbvWHTyL+5icubEMB
         n2wNmhNPadLmnTcagqWN9Tp5bgcVDmh1d6F4rDdS4qDi8QqNpZZ7cMQw+e7i3oKCet7A
         KMVCsptN3Q1dNI4mcKAq6OlxdTQPz6FPtUhc4gA6EIrrKbpxznZZmHVapsSPgo6rmFrg
         E6tyWpPy0TU5mZ6WnivZvHUjyfCdmBqo0A2s3p5hzFBg/ERbl6seruHVlSbrwRC30f+v
         6I4w==
X-Gm-Message-State: ANoB5pkwVgBm9iHzaOZ1e69he9GF2IKoDcM7DOSq1XKcchCt77Ah30zN
        VSpISIyMWrWxHyx/nqcu3RDqCpmtE4aHjT7XsLHZRw==
X-Google-Smtp-Source: AA0mqf7LxQSQclcoOBTzJVY+p9DtmqgV0yJC34U6qdy9Xg8iU49XiBqQ1G1IYFVjRhzcXIqq0YVXRtHWVjFymVAydyY=
X-Received: by 2002:a1f:230c:0:b0:3bb:eb08:6ee with SMTP id
 j12-20020a1f230c000000b003bbeb0806eemr4637581vkj.4.1669195238217; Wed, 23 Nov
 2022 01:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20221102175959.2921063-1-rmoar@google.com> <20221102175959.2921063-2-rmoar@google.com>
In-Reply-To: <20221102175959.2921063-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 23 Nov 2022 17:20:27 +0800
Message-ID: <CABVgOS=JHm=pxFbcKDgJ1Ag4vDRTygZjwjp4sUq-_BUTNVgJyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        john.johansen@canonical.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000411b9e05ee1fcdbb"
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

--000000000000411b9e05ee1fcdbb
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 3, 2022 at 2:02 AM Rae Moar <rmoar@google.com> wrote:
>
> Create two macros:
>
> VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
> is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change
> to the symbol definition.
>
> EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
> EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
> use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
> use symbols.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This looks good to me overall.

Two thoughts (though they're not _problems_ with this patch, so
shouldn't necessarily hold it up).

How many KUnit headers do we want for these sorts of things? We've
currently got 'test.h' (for actual tests) and 'test-bug.h' for the
kunit_fail_current_test() style hooks. And there'll be 'static-stub.h'
coming.
Maybe it'd make sense to merge some of these, if it turns out the same
code always needs to access them? On the other hand, I actually quite
like having them separate like this. (Though the split of assertions
into assert.h and perhaps renaming test-bug.h might be worth doing
down the line.) No immediate action item, but something perhaps worth
thinking about.

Secondly, do we want to support individual subsystems and/or tests to
have their own symbol namespaces. Again, not a problem for the moment,
but we may need to deal with this if we need to export multiple copies
of very-generically-named functions. Any thoughts (e.g., an
EXPORT_SYMBOL_IF_KUNIT_NS macro which allows the user to specify the
namespace?)

Regardless, this is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/visibility.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 include/kunit/visibility.h
>
> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
> new file mode 100644
> index 000000000000..eb22c9e6b4eb
> --- /dev/null
> +++ b/include/kunit/visibility.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API to allow symbols to be conditionally visible during KUnit
> + * testing
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>

Please update the date here, and use your name/email for the Author section.


> + */
> +
> +#ifndef _KUNIT_VISIBILITY_H
> +#define _KUNIT_VISIBILITY_H
> +
> +/**
> + * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
> + * is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change
> + * to the symbol definition.
> + *
> + * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
> + * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
> + * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
> + * in test file in order to use symbols.
> + */
> +#if IS_ENABLED(CONFIG_KUNIT)
> +    #define VISIBLE_IF_KUNIT
> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
> +           EXPORTED_FOR_KUNIT_TESTING)
> +#else
> +    #define VISIBLE_IF_KUNIT static
> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
> +#endif
> +
> +#endif /* _KUNIT_VISIBILITY_H */
> --
> 2.38.1.273.g43a17bfeac-goog
>

--000000000000411b9e05ee1fcdbb
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC/
4cIyAN6DZ9w7T8GsRjFqx36icJE9vroyDsoYUgtPMDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjMwOTIwMzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAARCnTCbLXMEUKzW9RvM
r4Re56xmKSG/QHCmNk85dolWzIAj6p+/SX/9oBPLbbAGrj0yocG19xYh90IIhmmLLaFV5076fyRB
G5A8UtiCw9JuVeQmfZQ+Mw/71SRVBp9H9StGnnEiOcjC1XnH+XDiNwxkMOQh8hEwVIooZ2Sovjj7
Hjmb8pBFeWBjIy48pmBiCGvD0GkEw/F/HmnJPZ66hRuzw1eCkuT7tIJN9UgEjgLNEHb5GpAnJ1cB
Qeb2oR0H695NFQttFzTErZQD4O7lcZgRUq847e+fYLhwGpOBnQZL2pPH2G/LwIXyX4KMP+Lrsate
tBYne0HeBrW1VSJZAg==
--000000000000411b9e05ee1fcdbb--
