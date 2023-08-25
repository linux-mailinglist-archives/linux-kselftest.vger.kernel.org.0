Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6C788050
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbjHYGu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbjHYGuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:50:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F51199E
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:50:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso41765e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946206; x=1693551006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y9/C/iopeAJjCopfQV57qGE6leNtFHY0soKF3us/qvw=;
        b=R2l8xpVgXWYqZC1uZY4LSKK+5PZfXR2zW65dZij04wcpGK6F852RhhWOwhRuRdhX5k
         XaPcrKbjjocvkFdUXu3ND8sQS3fBBguZMQgEpA3efolsTqoubtcwBd5pRly04MBrqgrw
         CcEzq2zupTYspQ8GushtkgK1ZKMLMF7EL1LXznHtPfiMXcRiXTFHSljrMR5M/XCdU0bK
         zOSKVg48fzEuHB4yx4cGfquI0SQ59WXniHpyA6sDugGpNQN2mF8fSJlIGcEtVKMHRPPc
         BeHl9XoRYG1D0F38S4EfetKFER2mgZaWfWEx7E5LEQqCtrErkzEMcQoo6X1PYUHje1pe
         isgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946206; x=1693551006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9/C/iopeAJjCopfQV57qGE6leNtFHY0soKF3us/qvw=;
        b=V7IPAake3e5ub3eRZq478MuLj/lAqtE62KMRU3Zbv5XCIpZnLoIS5X/vipdSdxp19q
         rBW8vHJ8ih4T+nlg1Zi0Nwv+MLHI6/M/dNX2/tvFQHXAipTybfK9ai8J84VK3VZGjxQh
         7lx6TaF17BMhkMMR4escVNvqwo2mBC98QMRWzQjAJqtOP3DK5crDQYdZhL42DJ/rhhsZ
         oSsKNjrFc8TwgGBNgV/ORItQJ+lgimonaeTDTAprM4fbc5u9SDVybukcRMo7QiKZfBdW
         Empug3fiYTgoLHRbUYdq5SDKTpt6uUDRw+qdHtN071xlVGBVvw9PQJtXYi4X8O+/Xv2M
         GV/w==
X-Gm-Message-State: AOJu0YwoQazaKCK3EmxUQeAi0umDu2dojNcXNYv0roXSI2fMsKLHc5B2
        yYJ6fnaOmYbMUk/UW1zgCmuoCRozUc8DF/PGgdHfkw==
X-Google-Smtp-Source: AGHT+IGPw1DUsVc23ouE1ryvPhTWctzZOSKmy3x1UZDdBh5xuAupLXU070NGuWigv9yhvcZ4Obq2xwwxx8J9E66LMUI=
X-Received: by 2002:a05:600c:3b02:b0:401:7c14:948d with SMTP id
 m2-20020a05600c3b0200b004017c14948dmr131113wms.2.1692946206590; Thu, 24 Aug
 2023 23:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-8-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-8-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:54 +0800
Message-ID: <CABVgOSnfkh7Yw=6oCByDCw6w3a2JSeGi2wEPTsFc593KyaNnoQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] kunit: string-stream: Decouple string_stream
 from kunit
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000049b7360603b9c1ed"
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

--00000000000049b7360603b9c1ed
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Re-work string_stream so that it is not tied to a struct kunit. This is
> to allow using it for the log of struct kunit_suite.
>
> Instead of resource-managing individual allocations the whole string_stream
> can be resource-managed, if required.
>
>     alloc_string_stream() now allocates a string stream that is
>     not resource-managed.
>
>     string_stream_destroy() now works on an unmanaged string_stream
>     allocated by alloc_string_stream() and frees the entire
>     string_stream (previously it only freed the fragments).
>
> For resource-managed allocations use kunit_alloc_string_stream()
> and kunit_free_string_stream().
>
> In addition to this, string_stream_get_string() now returns an
> unmanaged buffer that the caller must kfree().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since V4:
> - Adding the kunit_[alloc|free]_string_stream() functions has been split
>   out into the previous patch to reduce the amount of code churn in
>   this patch.
> - string_stream_destroy() has been kept and re-used instead of replacing
>   it with a new function.
> - string_stream_get_string() now returns an unmanaged buffer. This avoids
>   a large code change to string_stream_append().
> - Added wrapper function for resource free to prevent the type warning of
>   passing string_stream_destroy() directly to kunit_add_action_or_reset().
> ---

The changes all make sense to me, and work here. Thanks!

The only slight issue is there's one missing spot which still casts
the kunit_action_t function pointer directly, in the test. Up to you
if you want to change that, too (though it may need a helper of its
own.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  lib/kunit/string-stream-test.c |  2 +-
>  lib/kunit/string-stream.c      | 59 ++++++++++++++++++++++------------
>  lib/kunit/string-stream.h      |  4 ++-
>  lib/kunit/test.c               |  2 +-
>  4 files changed, 44 insertions(+), 23 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 89549c237069..45a2d221f1b5 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -16,6 +16,7 @@ static char *get_concatenated_string(struct kunit *test, struct string_stream *s
>         char *str = string_stream_get_string(stream);
>
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> +       kunit_add_action(test, (kunit_action_t *)kfree, (void *)str);

This still directly casts kfree to kunit_action_t, so triggers a
warning. I'm okay with it personally (and at some point we'll probably
implement a public kunit_free_at_end() function to do things like
this, which we already have in some other tests).


>
>         return str;
>  }
> @@ -30,7 +31,6 @@ static void string_stream_init_test(struct kunit *test)
>
>         KUNIT_EXPECT_EQ(test, stream->length, 0);
>         KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> -       KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
>         KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
>         KUNIT_EXPECT_FALSE(test, stream->append_newlines);
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 12ecf15e1f6b..c39f1cba3bcd 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -13,30 +13,28 @@
>  #include "string-stream.h"
>
>
> -static struct string_stream_fragment *alloc_string_stream_fragment(
> -               struct kunit *test, int len, gfp_t gfp)
> +static struct string_stream_fragment *alloc_string_stream_fragment(int len, gfp_t gfp)
>  {
>         struct string_stream_fragment *frag;
>
> -       frag = kunit_kzalloc(test, sizeof(*frag), gfp);
> +       frag = kzalloc(sizeof(*frag), gfp);
>         if (!frag)
>                 return ERR_PTR(-ENOMEM);
>
> -       frag->fragment = kunit_kmalloc(test, len, gfp);
> +       frag->fragment = kmalloc(len, gfp);
>         if (!frag->fragment) {
> -               kunit_kfree(test, frag);
> +               kfree(frag);
>                 return ERR_PTR(-ENOMEM);
>         }
>
>         return frag;
>  }
>
> -static void string_stream_fragment_destroy(struct kunit *test,
> -                                          struct string_stream_fragment *frag)
> +static void string_stream_fragment_destroy(struct string_stream_fragment *frag)
>  {
>         list_del(&frag->node);
> -       kunit_kfree(test, frag->fragment);
> -       kunit_kfree(test, frag);
> +       kfree(frag->fragment);
> +       kfree(frag);
>  }
>
>  int string_stream_vadd(struct string_stream *stream,
> @@ -65,9 +63,7 @@ int string_stream_vadd(struct string_stream *stream,
>         /* Need space for null byte. */
>         buf_len++;
>
> -       frag_container = alloc_string_stream_fragment(stream->test,
> -                                                     buf_len,
> -                                                     stream->gfp);
> +       frag_container = alloc_string_stream_fragment(buf_len, stream->gfp);
>         if (IS_ERR(frag_container))
>                 return PTR_ERR(frag_container);
>
> @@ -111,7 +107,7 @@ static void string_stream_clear(struct string_stream *stream)
>                                  frag_container_safe,
>                                  &stream->fragments,
>                                  node) {
> -               string_stream_fragment_destroy(stream->test, frag_container);
> +               string_stream_fragment_destroy(frag_container);
>         }
>         stream->length = 0;
>         spin_unlock(&stream->lock);
> @@ -123,7 +119,7 @@ char *string_stream_get_string(struct string_stream *stream)
>         size_t buf_len = stream->length + 1; /* +1 for null byte. */
>         char *buf;
>
> -       buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
> +       buf = kzalloc(buf_len, stream->gfp);
>         if (!buf)
>                 return NULL;
>
> @@ -139,13 +135,17 @@ int string_stream_append(struct string_stream *stream,
>                          struct string_stream *other)
>  {
>         const char *other_content;
> +       int ret;
>
>         other_content = string_stream_get_string(other);
>
>         if (!other_content)
>                 return -ENOMEM;
>
> -       return string_stream_add(stream, other_content);
> +       ret = string_stream_add(stream, other_content);
> +       kfree(other_content);
> +
> +       return ret;
>  }
>
>  bool string_stream_is_empty(struct string_stream *stream)
> @@ -153,16 +153,15 @@ bool string_stream_is_empty(struct string_stream *stream)
>         return list_empty(&stream->fragments);
>  }
>
> -static struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
> +struct string_stream *alloc_string_stream(gfp_t gfp)
>  {
>         struct string_stream *stream;
>
> -       stream = kunit_kzalloc(test, sizeof(*stream), gfp);
> +       stream = kzalloc(sizeof(*stream), gfp);
>         if (!stream)
>                 return ERR_PTR(-ENOMEM);
>
>         stream->gfp = gfp;
> -       stream->test = test;
>         INIT_LIST_HEAD(&stream->fragments);
>         spin_lock_init(&stream->lock);
>
> @@ -171,15 +170,35 @@ static struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
>
>  void string_stream_destroy(struct string_stream *stream)
>  {
> +       if (!stream)
> +               return;
> +
>         string_stream_clear(stream);
> +       kfree(stream);
> +}
> +
> +static void resource_free_string_stream(void *p)
> +{
> +       struct string_stream *stream = p;
> +
> +       string_stream_destroy(stream);
>  }
>
>  struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp)
>  {
> -       return alloc_string_stream(test, gfp);
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(gfp);
> +       if (IS_ERR(stream))
> +               return stream;
> +
> +       if (kunit_add_action_or_reset(test, resource_free_string_stream, stream) != 0)
> +               return ERR_PTR(-ENOMEM);
> +
> +       return stream;
>  }
>
>  void kunit_free_string_stream(struct kunit *test, struct string_stream *stream)
>  {
> -       string_stream_destroy(stream);
> +       kunit_release_action(test, resource_free_string_stream, (void *)stream);
>  }
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index 3e70ee9d66e9..c55925a9b67f 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -23,7 +23,6 @@ struct string_stream {
>         struct list_head fragments;
>         /* length and fragments are protected by this lock */
>         spinlock_t lock;
> -       struct kunit *test;
>         gfp_t gfp;
>         bool append_newlines;
>  };
> @@ -33,6 +32,9 @@ struct kunit;
>  struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp);
>  void kunit_free_string_stream(struct kunit *test, struct string_stream *stream);
>
> +struct string_stream *alloc_string_stream(gfp_t gfp);
> +void free_string_stream(struct string_stream *stream);
> +
>  int __printf(2, 3) string_stream_add(struct string_stream *stream,
>                                      const char *fmt, ...);
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 93d9225d61e3..2ad45a4ac06a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -296,7 +296,7 @@ static void kunit_print_string_stream(struct kunit *test,
>                 kunit_err(test, "\n");
>         } else {
>                 kunit_err(test, "%s", buf);
> -               kunit_kfree(test, buf);
> +               kfree(buf);
>         }
>  }
>
> --
> 2.30.2
>

--00000000000049b7360603b9c1ed
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBV
uE6JxvTtBBLqjNN/1v/a81fkVmgsc1QBRTkPG6H1RzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjUwMDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAK0O9vtudfqc0lqDe+FW6
lGD60RyBN9FufrFjIc2TqCg6auMx0Rx+Oqk9+gQqFS3cniVr9850nUGnjJi5BhnCQBk7qPdfRsHp
s0mFYX6FQ7mp78iGagQOV5FZzPJJdTVxZOW/0Qg+2Y30yvqffAXKmmz9auBJxCfxMFkx9+KmYBoL
0uFqkbHOgHyedhUy5UW63KmBOheVq0qawQoYbFDjmjHlesteWAp/9pftkAZXPsSAkPJveBD5bYzL
kt14gXDiYED3Pkt+ahqKf5VmsRVWsaO8CkX/doXXtyLwmO+jS2Wom4rJ+3S6lrQWBZsxPA4iDiTH
XA8LRY9E8DcgTQ0fDQ==
--00000000000049b7360603b9c1ed--
