Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E391788041
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbjHYGtx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbjHYGtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:49:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4ED1FEC
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so66115e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946174; x=1693550974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XdpvXI3JerO9huEmX+3MJyDkMRtns3aoW79VkhEAlR4=;
        b=xtblidW4/39L6dUb2oVzWAy0qz4Srg3jWizT9o8OES8Ja4AKPSbMEGviOe0D/nwjBN
         oLJY028Stabawutwk20/H6gGMu/IOS8/KPaYfv6/Z5sJfpbkUO9nOjpGFXFWjyDdsgQj
         Wzvjb3nIuoIiZ2epfxJXiRzmrnq5quZpOoQd6HF6romwG69rwJhr23Gy9DN2k4hsjN6e
         l3zK8RP5yxJ1VUniLBgKJBdOeLjp4WUxCvV3G4z0AFF1D/t5wSb4vIkYVYCmB+k3rrHt
         oSV+TcoBfIDeUWOOG5QcpH8b1wPiIz2BdNk30qBG0MPKenXqVXTcs+BnivU4Q1LsdQGO
         V23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946174; x=1693550974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdpvXI3JerO9huEmX+3MJyDkMRtns3aoW79VkhEAlR4=;
        b=PMMSHS3ovS7msRaJHbIodBfN263h0MrJ7e461bXMFywIFSXn6MnhpQjbCqcGCNz3bC
         MjhnomkFqJl8Q7b9gv+EEy/wQS/4/cb3j30zjHyL2/xKB3SquJ6ZHlo7gFexHWN2/iue
         ETeAcfbKRNBv2713aB+6EzXQAq4lILCYlZ2fI3dnJB59YdjDsFLQnNt1OhaUsh6NBlxi
         2MtycNkscUfrkADZEgAODG3SxOFKKBtLTC5tmYNSvkdcaSjoHO7DSrn+NrdvS20i3L2/
         zmNyU0a6QUbiw9/r7PBpDpbTxesAlkcKJ0xM4D2Sc4nPBVgDkDtb/zSnRQZAlci/4J7V
         dVaA==
X-Gm-Message-State: AOJu0YxwX66MvYabENnNjF4/tzb0Ylo6Q/ovQ+8qL1oou6ZsUYa8o8N9
        dDk5/okglvjU7btAT+TikfgKITDOdB3WAcvOq2d6WvjqLKyy2tSaAwA=
X-Google-Smtp-Source: AGHT+IGJraIU0fZ5/69pyZ8GbcuquzermKaYyruReb+AsR8I8LGh79gXTPGlLm2cC8YBaMekWlv5qT+lCaF4V3hIPVs=
X-Received: by 2002:a05:600c:600b:b0:3f6:f4b:d4a6 with SMTP id
 az11-20020a05600c600b00b003f60f4bd4a6mr99315wmb.7.1692946174748; Thu, 24 Aug
 2023 23:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-4-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-4-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:22 +0800
Message-ID: <CABVgOSkbB2TNTf_TqbpGnw4rOTHjksCYdU=Kh9s-HOpbUmxoeQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] kunit: string-stream: Add option to make all
 lines end with newline
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000623d910603b9bfaa"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000623d910603b9bfaa
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add an optional feature to string_stream that will append a newline to
> any added string that does not already end with a newline. The purpose
> of this is so that string_stream can be used to collect log lines.
>
> This is enabled/disabled by calling string_stream_set_append_newlines().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

This is the same as v4, patch 4, and still looks good.

(In the future, feel free to leave the Reviewed-by: tag from the
previous version, so long as there are no significant changes.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream.c | 28 +++++++++++++++++++++-------
>  lib/kunit/string-stream.h |  7 +++++++
>  2 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index ed24d86af9f5..1dcf6513b692 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -44,32 +44,46 @@ int string_stream_vadd(struct string_stream *stream,
>                        va_list args)
>  {
>         struct string_stream_fragment *frag_container;
> -       int len;
> +       int buf_len, result_len;
>         va_list args_for_counting;
>
>         /* Make a copy because `vsnprintf` could change it */
>         va_copy(args_for_counting, args);
>
>         /* Evaluate length of formatted string */
> -       len = vsnprintf(NULL, 0, fmt, args_for_counting);
> +       buf_len = vsnprintf(NULL, 0, fmt, args_for_counting);
>
>         va_end(args_for_counting);
>
> -       if (len == 0)
> +       if (buf_len == 0)
>                 return 0;
>
> +       /* Reserve one extra for possible appended newline. */
> +       if (stream->append_newlines)
> +               buf_len++;
> +
>         /* Need space for null byte. */
> -       len++;
> +       buf_len++;
>
>         frag_container = alloc_string_stream_fragment(stream->test,
> -                                                     len,
> +                                                     buf_len,
>                                                       stream->gfp);
>         if (IS_ERR(frag_container))
>                 return PTR_ERR(frag_container);
>
> -       len = vsnprintf(frag_container->fragment, len, fmt, args);
> +       if (stream->append_newlines) {
> +               /* Don't include reserved newline byte in writeable length. */
> +               result_len = vsnprintf(frag_container->fragment, buf_len - 1, fmt, args);
> +
> +               /* Append newline if necessary. */
> +               if (frag_container->fragment[result_len - 1] != '\n')
> +                       result_len = strlcat(frag_container->fragment, "\n", buf_len);
> +       } else {
> +               result_len = vsnprintf(frag_container->fragment, buf_len, fmt, args);
> +       }
> +
>         spin_lock(&stream->lock);
> -       stream->length += len;
> +       stream->length += result_len;
>         list_add_tail(&frag_container->node, &stream->fragments);
>         spin_unlock(&stream->lock);
>
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index b669f9a75a94..048930bf97f0 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -25,6 +25,7 @@ struct string_stream {
>         spinlock_t lock;
>         struct kunit *test;
>         gfp_t gfp;
> +       bool append_newlines;
>  };
>
>  struct kunit;
> @@ -47,4 +48,10 @@ bool string_stream_is_empty(struct string_stream *stream);
>
>  void string_stream_destroy(struct string_stream *stream);
>
> +static inline void string_stream_set_append_newlines(struct string_stream *stream,
> +                                                    bool append_newlines)
> +{
> +       stream->append_newlines = append_newlines;
> +}
> +
>  #endif /* _KUNIT_STRING_STREAM_H */
> --
> 2.30.2
>

--000000000000623d910603b9bfaa
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCV
RRQyFtiSamRpVbg7OVzC8f420XR6ev9ZWgMrmJd+LzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjQ5MzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAd0QVybmyXwwidtRPps4H
iipzSZJ2gRKa3Dkb7yXifQEuuum9gcigSA0yFWLGbPxCO+MfEqvh8v237eF4p71UT9B3qXXonpjr
WrMmdnBk4sLA3140fIW+2tPwByYqVEWTAG+BG1aq8Sp51dkYwJ9TVuUB1q+mWitT5lg7nnR8nWAi
QQTrgkcItS3BFSGKxE1+qBxuMioFfOkSlHo7uUnT/fKq02ea7cJ3EJlEttXWvgNvFnOz93eraWMW
3AAzwDcGwKh50iILXSmPmqXtNiFs8mQlclJen2yLsGUnOyKXzK5Sw1otz1K9OdBWsZCFallnWThH
5Opi4f13U00IPFwKRg==
--000000000000623d910603b9bfaa--
