Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C879FF8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjINJHG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbjINJHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:07:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E21FD5
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:06:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402bec56ca6so59685e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694682415; x=1695287215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNHpTfXTtqAQfiHkPxqTt6BY3EOQDxzaIUvo3Aq/qms=;
        b=odTN4FDR5ZL9JO98jJXi9CIFYzlqxXVa5PHiX/Hv7tlZqjuml5S3wvWbH2bOJrPwsE
         fgZspEIX/i6zzlEUL84mPdO0Q3YrPjPGn8gz0VUjQUmlpkSdRcmYfDty/04KelAmJ3ct
         ZveheVdQRKCUKlO5SQVT53xRZ2Dr2o2Ze6T1gs8H1RH7j0C51YRvE0TpQxFPo8BuFL4h
         BXz9wKcNXCvDPMHY8FLBqKSpRvb2TBXuvHuj1GHXVH9qo7JUHniLteV71ioIUbsKbUSo
         z1uUMXmnyP/kYvO1SmQQQ9g7OHq2WAzTUXZMvyME/CEB2rqxAbkC3rOkuuh8xO+q58zI
         /Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682415; x=1695287215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNHpTfXTtqAQfiHkPxqTt6BY3EOQDxzaIUvo3Aq/qms=;
        b=J84ouYB7RjyIkBiVp3d5fAdI90nzmPFjt1MiyRAawpv6Rvwm/UDQSx3NH3wpLfaQZ3
         qELA5dKCCXmCf45cJLOOzVRX/57kyKMCRzwTMF2M+3VldVGfl90bUjowJSv0szpOSQno
         DZ6kEDffUnAbkiSbDk65uEXcUETauzsDfBSPprQCDAOOPHSTTI240vmHqvUIxlCR8NFY
         UmKFQqgXTuO3MI13I3cVLbm/MKOa8E1RSBAVsZfqE3mnbcdhhEd3quP2H/AFpziE5FTU
         QHVwggf83JjmQLsjiuYZz9QstnaMLtGS7WRxvcuCu87EPgWQiSg0ANf172fYShR08hZ2
         lI+w==
X-Gm-Message-State: AOJu0Yx5YvuuCF5OK3ckKZB31cwFLF8Y/xeLj+FpkX2Agn4oxFdz38vW
        fBpef9gRoInem72hRAlarn29pPgifkbuS50Ja3l68w==
X-Google-Smtp-Source: AGHT+IGpZo7fNoS4nx6ZKxRbzBP6HVGGyALcKDWjdUstPR5czgPSLKTOeRvhQOWF2miRlY9Vd0JqzZUfZutsL91/xRc=
X-Received: by 2002:a7b:c3c8:0:b0:400:fffe:edf6 with SMTP id
 t8-20020a7bc3c8000000b00400fffeedf6mr249723wmj.1.1694682415195; Thu, 14 Sep
 2023 02:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230908213148.3610108-1-rmoar@google.com> <20230908213148.3610108-2-rmoar@google.com>
In-Reply-To: <20230908213148.3610108-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 14 Sep 2023 17:06:43 +0800
Message-ID: <CABVgOS=0coPxNE12EsOb-y-VGQ4hafSiNiVj8sLfCCG8LLz8Vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: Add debugfs docs with run after boot
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000063d21606054dff8f"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000063d21606054dff8f
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Sept 2023 at 05:32, Rae Moar <rmoar@google.com> wrote:
>
> Expand the documentation on the KUnit debugfs filesystem on the
> run_manual.rst page.
>
> Add section describing how to access results using debugfs.
>
> Add section describing how to run tests after boot using debugfs.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Co-developed-by: Sadiya Kazi <sadiyakazi@google.com>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

Looks good to me, a few nitpicks, and the fact that we'll probably
need to add something about init section suites when those are
implemented.

(Also, since you sent the email, your sign off should be at the bottom
of the list above.)

>  Documentation/dev-tools/kunit/run_manual.rst | 45 ++++++++++++++++++--
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
> index e7b46421f247..613385c5ba5b 100644
> --- a/Documentation/dev-tools/kunit/run_manual.rst
> +++ b/Documentation/dev-tools/kunit/run_manual.rst
> @@ -49,9 +49,46 @@ loaded.
>
>  The results will appear in TAP format in ``dmesg``.
>
> +debugfs
> +=======
> +
> +``debugfs`` is a file system that enables user interaction with the files to
> +make kernel information available to user space. A user can interact with
> +the debugfs filesystem using a variety of file operations, such as open,
> +read, and write.
> +
> +By default, only the root user has access to the debugfs directory.

These two paragraphs are probably a bit excessive: we want to focus on
what KUnit can do with debugfs, not describing what debugfs is as a
whole (which is best left to pages like
Documentation/filesystems/debugfs.rst )

> +
> +If ``CONFIG_KUNIT_DEBUGFS`` is enabled, you can use KUnit debugfs
> +filesystem to perform the following actions.
> +
> +Retrieve Test Results
> +=====================
> +
> +You can use debugfs to retrieve KUnit test results. The test results are
> +accessible from the debugfs filesystem in the following read-only file:
> +
> +.. code-block :: bash
> +
> +       /sys/kernel/debug/kunit/<test_suite>/results
> +
> +The test results are available in KTAP format.

We _could_ mention that this is a separate KTAP document (i.e., the
numbering starts at 1), though it may be obvious.

> +
> +Run Tests After Kernel Has Booted
> +=================================
> +
> +You can use the debugfs filesystem to trigger built-in tests to run after
> +boot. To run the test suite, you can use the following command to write to
> +the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
> +
> +.. code-block :: bash
> +
> +       echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
> +
> +As a result, the test suite runs and the results are printed to the kernel
> +log.
> +
>  .. note ::
>
> -       If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
> -       be accessible from the ``debugfs`` filesystem (if mounted).
> -       They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
> -       TAP format.
> +       The contents written to the debugfs file
> +       ``/sys/kernel/debug/kunit/<test_suite>/run`` are not saved.

This is possibly a bit obvious. Maybe it'd be more useful with a bit
more context, e.g., "The contents written to the file ... are
discarded; it is the act of writing which triggers the test, not the
specific contents written."?

It might be worth having a note that tests cannot run concurrently, so
this may block or fail.

Equally, it may be worth having a note for test authors, that their
tests will need to correctly initialise and/or clean up any data, so
the test runs correctly a second time.


> --
> 2.42.0.283.g2d96d420d3-goog
>

--00000000000063d21606054dff8f
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDy
Dj0NN0bCychgwX5Hsr6IrAPjzfCc4qkNB7DU8K6BQzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MTQwOTA2NTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHaaby1hYSQ/ysUYu+Jro
Zpbw4rMia7Wpxq4al0sCSWdhDJIPNM8kzI3rrZwk04nmg7sXqupmoXYbvh/dtJViOxaNBnTB/9DX
0fWO2A0Mc0UutXC+yyycPsXDibFyIPdY+6XeCdD2GSkNIDsL+zKk7iwmIjPFpbl4vGME4sSWhSbW
+wrCzFZHTrdbvipZ+/tfCnrx1Hih7vT67hT9RCcCkTN0Cjk2WJTgk9KA4Jl/UnB7g+59Erf5qD2E
oewXyKOCnDleaorovwNohmzsxbpzpoEgEagmom5fyuY45yu9Sw2bDP3mpmlgjMezvNagqiwaYoMG
1FvWqcNfcsZphUDNMA==
--00000000000063d21606054dff8f--
