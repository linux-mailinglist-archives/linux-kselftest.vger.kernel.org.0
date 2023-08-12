Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A4779DFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjHLHtJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjHLHtJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 03:49:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B1F1BE6
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 00:49:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so20895e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691826551; x=1692431351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shAIsJfc/03iH3dFouXBPhXaor1rPmT7lBmh03qDDDE=;
        b=VGnshYEKHkQ/5fk1avSscW7bCeAdkJd1t8uVhrHZsGPS3Fk28dgjbJelMI5uGoM67j
         jqhCdSLqWzMFPa5t8QVowFkB4x/ZtEPhxte6ms3tCe4xo+k9gRjqPcHe41Z6ovXVjNf0
         zXN6nkhg/GnzBdga94LM5ETfQI0IRoTV2pyVYGcbQ2kMtNGDFCxWo2XPGE3+MmrOwlME
         QKTlqnuULE4uEL50asntW4+6H567dQXAMiRYLbk84KILfPy8jkupSFb7ulXvoKtjAvee
         rrPXnJTiUsXkRKkfC/+jJtd/reH9KuiSUtlN0vg1Kehj076n9ssytU4hPwalMdlkJPpR
         xt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691826551; x=1692431351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shAIsJfc/03iH3dFouXBPhXaor1rPmT7lBmh03qDDDE=;
        b=ERcP7vJRMBqxETqqXJqhi/1fyqyBNgffAtOveZzUDmMqMatImhfneyv9R+JJccQuv0
         3lC5FbsF6SnRVP7ytH3hiUwbG4MsMOTZYpniolEESaUgRfr23rcGpjFVq4RnUzh9Qrtg
         EqcITTX1IA9g23XYmvgES/M150+y3FH8xaEADUQLIsI7RnkyMK7+39nEl6JpAVRRJ9RT
         18uRnW2EbRidtoIDqROjdGDMegmidQWc/pB6OFecPkLLdwXgEzlRC6HoinIh1/fEXcSZ
         VA65640PpihwMaCkKpYGfnbGEqXIYUfYGtVAGOfJI2gYKdyqvLyyw+ronNTrBPQT/L+T
         kDsg==
X-Gm-Message-State: AOJu0YyMR/TP/pc8p2OzAGTTqKpDeHyLSGGUeLsXVLzCXmgG1jTu/c9P
        BLZuFHkvGnh1U6r7evX+UcJxBc5JjbHNfhbHgFX1aw==
X-Google-Smtp-Source: AGHT+IELcCp3AkwUHFrZlX+uhVX5qf/ddvOFApiLsPGB4v/8ZmjMUNqjRwynCE6l63jGR6CT+NSRnomlcBYEOIOEXWc=
X-Received: by 2002:a05:600c:2146:b0:3fd:e15:6d5 with SMTP id
 v6-20020a05600c214600b003fd0e1506d5mr185423wml.2.1691826550699; Sat, 12 Aug
 2023 00:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230725172051.2142641-1-shikemeng@huaweicloud.com>
In-Reply-To: <20230725172051.2142641-1-shikemeng@huaweicloud.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 12 Aug 2023 15:48:57 +0800
Message-ID: <CABVgOSn_k=TV4Y7pKTw5LY3su6r0TYi_ci95MKw7-wRHA1+MdA@mail.gmail.com>
Subject: Re: [PATCH] kunit: replace KUNIT_TRIGGER_STATIC_STUB maro with KUNIT_STATIC_STUB_REDIRECT
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009ad5bf0602b51002"
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

--0000000000009ad5bf0602b51002
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 17:20, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>
> We mix up KUNIT_TRIGGER_STATIC_STUB and KUNIT_STATIC_STUB_REDIRECT in
> static_stub header. Just correct KUNIT_TRIGGER_STATIC_STUB to
> KUNIT_STATIC_STUB_REDIRECT which is documented.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---

Thanks for catching this!

Only minor note is that there's a typo in the subject ("maro","macro").

Fixes: e047c5eaa763 ("kunit: Expose 'static stub' API to redirect functions")
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/static_stub.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
> index 9b80150a5d62..85315c80b303 100644
> --- a/include/kunit/static_stub.h
> +++ b/include/kunit/static_stub.h
> @@ -11,7 +11,7 @@
>  #if !IS_ENABLED(CONFIG_KUNIT)
>
>  /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
> -#define KUNIT_TRIGGER_STATIC_STUB(real_fn_name, args...) do {} while (0)
> +#define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>
>  #else
>
> @@ -30,7 +30,7 @@
>   * This is a function prologue which is used to allow calls to the current
>   * function to be redirected by a KUnit test. KUnit tests can call
>   * kunit_activate_static_stub() to pass a replacement function in. The
> - * replacement function will be called by KUNIT_TRIGGER_STATIC_STUB(), which
> + * replacement function will be called by KUNIT_STATIC_STUB_REDIRECT(), which
>   * will then return from the function. If the caller is not in a KUnit context,
>   * the function will continue execution as normal.
>   *
> @@ -87,7 +87,7 @@ void __kunit_activate_static_stub(struct kunit *test,
>   * When activated, calls to real_fn_addr from within this test (even if called
>   * indirectly) will instead call replacement_addr. The function pointed to by
>   * real_fn_addr must begin with the static stub prologue in
> - * KUNIT_TRIGGER_STATIC_STUB() for this to work. real_fn_addr and
> + * KUNIT_STATIC_STUB_REDIRECT() for this to work. real_fn_addr and
>   * replacement_addr must have the same type.
>   *
>   * The redirection can be disabled again with kunit_deactivate_static_stub().
> --
> 2.30.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230725172051.2142641-1-shikemeng%40huaweicloud.com.

--0000000000009ad5bf0602b51002
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC5
R4LxFfsjShqhSGZwFN/+8SdWawp0L3biSrwbGe2uajAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTIwNzQ5MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAhULlGGYjFcAHI1sd6332
2Od0B6tMLWiW5vOo0ncLrGDBH6o24Z4BpHJoWz9ZBfOKBA7J+UM4z0VsHaizez7VV9jNDByBmWkM
CArwxtNdLPCnB+eUqlse0nJXp0bSY53vfuKk302JjLC00QCz18GuyS5JmMjXdhteb/PCEbQtCOqk
gx0rvnwFI8zgZy67ctc4k4KCfTeYg5+8eqn4wPcbKNRcksNzwpKaKi299e1NjvoOnWzgpbyC/Xqf
YcCmPatYsx4vLqKQx38LTI1d5TL1OX31dPGlYxgu7jdVB+q2HqNbCXQATGirhX8CyqGQ750GCMwm
HIRwl2/hZnvOpMAXJg==
--0000000000009ad5bf0602b51002--
