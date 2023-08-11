Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9349C7788EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjHKI2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjHKI2Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 04:28:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A152728
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 01:28:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so41175e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691742491; x=1692347291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cf+vh3ewEogguvH/K23GhS6rzvDU1gT6vWLVKl6qJc=;
        b=rLHa4uXFSQJA+REazu1DuYDqc9IgzdGFWQarxz0C5bK/AvlkYkQgsabc8xvMSZMTTh
         1Td21ublC5/le07BAiBle5Nk1VClYSYswW6Uv08VzMH4ZbtufEbOnFtD+hHCdZqkcI/y
         iS6ezf96qNYQt1JbHe+jBzXFEzj6vp8kM87Ln0jeju5b8ndYlt8iVLdxN+yKFVGbZoUM
         T0J8JekUUe6fWnyoLMmmvneikG57CeD/k/IVinoU+nHOPI4nNOb0YRRxNnc1UhHmvb5y
         vG8dbQxIdfM5k0EfRWYPrJwJrefXPRuh5kn0/r6Q30hy9wCnQkV7OWw32oWVnM/MKa3b
         R0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691742491; x=1692347291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Cf+vh3ewEogguvH/K23GhS6rzvDU1gT6vWLVKl6qJc=;
        b=Gt1PBYiRnOM4ZYhR6Z2QXt0NPaNwwpzckbs211azg3tgvpsN8+poblLZ1KJteLx7q3
         iOH80dl1kKNEnfajUUoA+wz8EnyEg1U3V8zyDSA50+Afrct8lodhYUu331XNP+vaIiHJ
         RHlJqAhW+TknDwCZiAO/3KwellLwfduTDh7cdJ8Mx8qHx2KNz4ysGRBIMdmMZL4NMCw7
         UnH29a6WEXEmnWR76nSgo9C8NjBg28483WT8zWbU/Of3VWj/V0nkE63ViqlnTy1mX0YU
         2Z8PqH8KSLqS3dwNu8S90sLP6e01CJ1sIBFzDNX9vX7bmSDy6rKTXvTHGwCFGoHQO/9x
         9blw==
X-Gm-Message-State: AOJu0Yzax1f9r7T0DufaOsI0smZPFDDmh8bum0XBtmphiTFlFdr8vHNw
        Wkepyl/jv3X+XLQ7HfKyYKMQObZ9j7sgVm3MQqtPmA==
X-Google-Smtp-Source: AGHT+IE2eWYXeNUeYIHJEs+J5noBvsEcIrEygSyaP1VSzaLWMd3GaKsw2TBEA51D83UUQ4WDEEsibcIv0H4C7NwMkxs=
X-Received: by 2002:a1c:7901:0:b0:3fc:75d:8f85 with SMTP id
 l1-20020a1c7901000000b003fc075d8f85mr82690wme.6.1691742491163; Fri, 11 Aug
 2023 01:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-8-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-8-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 11 Aug 2023 16:27:59 +0800
Message-ID: <CABVgOSnDF=Cfmf-4Fr67fJVEm5yS98Dh+LKCOLR4L3Bz+VzWdg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] kunit: Don't waste first attempt to format string
 in kunit_log_append()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000416f5e0602a17e0f"
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

--000000000000416f5e0602a17e0f
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Aug 2023 at 23:54, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> It's wasteful to call vsnprintf() only to figure out the length of the
> string. The string might fit in the available buffer space but we have to
> vsnprintf() again to do that.
>
> Instead, attempt to format the string to the available buffer at the same
> time as finding the string length. Only if the string didn't fit the
> available space is it necessary to extend the log and format the string
> again to a new fragment buffer.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

This looks good.

The only case I'm not totally convinced about is the last one, where
the message doesn't fit in the current log fragment, but is not a
whole fragment itself. I'm not sure if the added efficiency of not
doing a second vsprintf() is worth the memory fragmentation of always
starting a new fragment: the worst case where a log message is just
over half the length of frag->buf would result in every message being
in its own fragment (which would not necessarily have a consistent
size), and memory use would be ~doubled.

But I could accept it either way: until there's a real-world example
which strongly benefits from either implementation, let's go with
whatever we have working.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  lib/kunit/test.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 28d0048d6171..230ec5e9824f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -196,11 +196,21 @@ void kunit_log_append(struct list_head *log, const char *fmt, ...)
>         if (!log)
>                 return;
>
> -       /* Evaluate length of line to add to log */
> +       frag = list_last_entry(log, struct kunit_log_frag, list);
> +       log_len = strlen(frag->buf);
> +       len_left = sizeof(frag->buf) - log_len - 1;
> +
> +       /* Attempt to print formatted line to current fragment */
>         va_start(args, fmt);
> -       len = vsnprintf(NULL, 0, fmt, args) + 1;
> +       len = vsnprintf(frag->buf + log_len, len_left, fmt, args) + 1;
>         va_end(args);
>
> +       if (len <= len_left)
> +               goto out_newline;
> +
> +       /* Abandon the truncated result of vsnprintf */
> +       frag->buf[log_len] = '\0';
> +
>         if (len > sizeof(frag->buf) - 1) {
>                 va_start(args, fmt);
>                 tmp = kvasprintf(GFP_KERNEL, fmt, args);
> @@ -212,24 +222,15 @@ void kunit_log_append(struct list_head *log, const char *fmt, ...)
>                 return;
>         }
>
> -       frag = list_last_entry(log, struct kunit_log_frag, list);
> -       log_len = strlen(frag->buf);
> -       len_left = sizeof(frag->buf) - log_len - 1;
> -
> -       if (len > len_left) {
> -               frag = kunit_log_extend(log);
> -               if (!frag)
> -                       return;
> -
> -               len_left = sizeof(frag->buf) - 1;
> -               log_len = 0;
> -       }
> +       frag = kunit_log_extend(log);
> +       if (!frag)
> +               return;
>
>         /* Print formatted line to the log */
>         va_start(args, fmt);
> -       vsnprintf(frag->buf + log_len, min(len, len_left), fmt, args);
> +       vsnprintf(frag->buf, sizeof(frag->buf) - 1, fmt, args);
>         va_end(args);
> -
> +out_newline:
>         /* Add newline to end of log if not already present. */
>         kunit_log_newline(frag);
>  }
> --
> 2.30.2
>

--000000000000416f5e0602a17e0f
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCw
w0PQL44ncIPesOEv/c865ruoYDcfXIejyyMWZteMGzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTEwODI4MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdZcjK5Gsw+0mFZMxf8qh
MxOGtphrAopWerokvZGqwmypIopGjybioeXPw+OH8/ESMy7Yjjl24E1rZl5IIzcAJQ7akrmLmJtR
CCNw+VNUtntjuSD03fTM94D8qR4bwQVI85Ixl5Q3jPmY40j2IeZ9EC/smgzqyyUdQXZDGM6MyjSl
qP5rydarehuIJeCl9U8yKBvxsfH4MBz0Qjn4zOlms34BaN56r4XRpGGnXL4ebbCWFaN/2EXTnh6A
bLj64RvrRbHJ/dY+q4x2asHTRrBSTUoBqkRZGGC47a7TGBD/kdON6CJ85wAqbX+8IEoEpN9el37E
gpbfPwnNVeqsLGJgYw==
--000000000000416f5e0602a17e0f--
