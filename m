Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D577CA4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbjHOJS4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjHOJSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:18:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44E2723
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so53385e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692091022; x=1692695822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uevdrw/Zs28+oDlEDJDxsAyeQVjFRNjxq42HLZ9uoM0=;
        b=JXaaGZMots6FCTsxfmdpspfDHn+zGdQBMJHsPX12tkgS++XjbF2gND92qca3XCheUI
         W7Sd2xCQ4W+X/9LwHy3ELSmx76Ri/iDQLCbAURkVdrhGOPYyyNznYvUUkc3bzAcU4jNq
         hYIOi9HlSgzur04ooTl4DnSDx8E9YzI/LZ0ldfbkw2cdJ6wYXAdN9ZDPV0UkC6WbJbT5
         js2udrQADaMHjjjBUcrxxjjBM73X5wg+n5pagvYEjxAElU0W9+fh7buqXVWrYe9n/iOv
         PW33oGtZ+XWlrof+ARVE5Pn4flid6kj54rtiLDfO+CLVrciEVofqk8QByvN/9ndi9ANg
         2zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091022; x=1692695822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uevdrw/Zs28+oDlEDJDxsAyeQVjFRNjxq42HLZ9uoM0=;
        b=YrnWOWeZi267W0nC066hwqtX3d6LKF6VRFJTd/5Nnz1sqJsRLvZYhcu299byDTzEZN
         1lBKUq50ItLYqYtXnSsTqPGL4DR1EHYyAJ0q67lhGmYxh/ztpQ7YH29v3Zo2q33xTm5q
         kxCs6wuRRVKZUExWGagSZlWLsJ2TDAXJRg0i1qK8sIs9GZqS2EPOXRMqvaLNlDrl0rBH
         VEj3CJ1TsgSMA712gPXSLPIw35Xxor5euRJu+QXSQd1hsLq4KGe2OTVzBOPF01Jc3SfE
         /af0h2NmwBMXIE8w33icWgVJFRM3ZUuDM/A1jvN8OJk/r1CagftskEe6WT4+K1S545N2
         cseQ==
X-Gm-Message-State: AOJu0YwFvlQKY9dGyoS1nsJidrNPVUIU6K7Jqs1JFkOKD7cFC+o20J9T
        m82rFIxHyfJhkbtsqdoxEBsY5uKpKDSgsWhKhspfyw==
X-Google-Smtp-Source: AGHT+IEhfAejDkQuFZkGfTpbNVE6RwiXRNgBoxYBZLW4Qv3tJwQdF/+bV8opZMa/HK0g5U2KAuk5AFmRbYefZttgYjE=
X-Received: by 2002:a05:600c:286:b0:3f1:6fe9:4a95 with SMTP id
 6-20020a05600c028600b003f16fe94a95mr395421wmk.4.1692091021953; Tue, 15 Aug
 2023 02:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-8-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-8-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:16:50 +0800
Message-ID: <CABVgOSmBD7zWjn5ovwUAv23r=O5Z6q8+k=vUD6Jh=MZ3prUuDg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] kunit: string-stream: Decouple string_stream
 from kunit
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004e26f30602f2a42c"
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

--0000000000004e26f30602f2a42c
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Re-work string_stream so that it is not tied to a struct kunit. This is
> to allow using it for the log of struct kunit_suite.
>
> Instead of resource-managing individual allocations the whole string_stream
> object can be resource-managed as a single object:
>
>     alloc_string_stream() API is unchanged and takes a pointer to a
>     struct kunit but it now registers the returned string_stream object to
>     be resource-managed.
>
>     raw_alloc_string_stream() is a new function that allocates a
>     bare string_stream without any association to a struct kunit.
>
>     free_string_stream() is a new function that frees a resource-managed
>     string_stream allocated by alloc_string_stream().
>
>     raw_free_string_stream() is a new function that frees a non-managed
>     string_stream allocated by raw_alloc_string_stream().
>
> The confusing function string_stream_destroy() has been removed. This only
> called string_stream_clear() but didn't free the struct string_stream.
> Instead string_stream_clear() has been exported, and the new functions use
> the more conventional naming of "free" as the opposite of "alloc".
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

I'm in favour of this. Should we go further and get rid of the struct
kunit member from string_stream totally?

Also, note that the kunit_action_t casting is causing warnings on some
clang configs (and technically isn't valid C). Personally, I still
like it, but expect more emails from the kernel test robot and others.

Reviewed-by: David Gow <davidgow@google.com>

>  lib/kunit/string-stream-test.c |  2 +-
>  lib/kunit/string-stream.c      | 92 +++++++++++++++++++++++-----------
>  lib/kunit/string-stream.h      | 12 ++++-
>  lib/kunit/test.c               |  2 +-
>  4 files changed, 77 insertions(+), 31 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 8a30bb7d5fb7..437aa4b3179d 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -200,7 +200,7 @@ static void string_stream_append_test(struct kunit *test)
>                            combined_content);
>
>         /* Append content of non-empty stream to empty stream */
> -       string_stream_destroy(stream_1);
> +       string_stream_clear(stream_1);
>
>         stream_1 = alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index eb673d3ea3bd..06104a729b45 100644
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
> @@ -102,7 +98,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
>         return result;
>  }
>
> -static void string_stream_clear(struct string_stream *stream)
> +void string_stream_clear(struct string_stream *stream)
>  {
>         struct string_stream_fragment *frag_container, *frag_container_safe;
>
> @@ -111,16 +107,28 @@ static void string_stream_clear(struct string_stream *stream)
>                                  frag_container_safe,
>                                  &stream->fragments,
>                                  node) {
> -               string_stream_fragment_destroy(stream->test, frag_container);
> +               string_stream_fragment_destroy(frag_container);
>         }
>         stream->length = 0;
>         spin_unlock(&stream->lock);
>  }
>
> +static void _string_stream_concatenate_to_buf(struct string_stream *stream,
> +                                             char *buf, size_t buf_len)
> +{
> +       struct string_stream_fragment *frag_container;
> +
> +       buf[0] = '\0';
> +
> +       spin_lock(&stream->lock);
> +       list_for_each_entry(frag_container, &stream->fragments, node)
> +               strlcat(buf, frag_container->fragment, buf_len);
> +       spin_unlock(&stream->lock);
> +}
> +
>  char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
>                                gfp_t gfp)
>  {
> -       struct string_stream_fragment *frag_container;
>         size_t buf_len = stream->length + 1; /* +1 for null byte. */
>         char *buf;
>
> @@ -128,10 +136,7 @@ char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
>         if (!buf)
>                 return NULL;
>
> -       spin_lock(&stream->lock);
> -       list_for_each_entry(frag_container, &stream->fragments, node)
> -               strlcat(buf, frag_container->fragment, buf_len);
> -       spin_unlock(&stream->lock);
> +       _string_stream_concatenate_to_buf(stream, buf, buf_len);
>
>         return buf;
>  }
> @@ -139,13 +144,20 @@ char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
>  int string_stream_append(struct string_stream *stream,
>                          struct string_stream *other)
>  {
> -       const char *other_content;
> +       size_t other_buf_len = other->length + 1; /* +1 for null byte. */
> +       char *other_buf;
> +       int ret;
>
> -       other_content = string_stream_get_string(other->test, other, other->gfp);
> -       if (!other_content)
> +       other_buf = kmalloc(other_buf_len, GFP_KERNEL);
> +       if (!other_buf)
>                 return -ENOMEM;
>
> -       return string_stream_add(stream, other_content);
> +       _string_stream_concatenate_to_buf(other, other_buf, other_buf_len);
> +
> +       ret = string_stream_add(stream, other_buf);
> +       kfree(other_buf);
> +
> +       return ret;
>  }
>
>  bool string_stream_is_empty(struct string_stream *stream)
> @@ -153,23 +165,47 @@ bool string_stream_is_empty(struct string_stream *stream)
>         return list_empty(&stream->fragments);
>  }
>
> -struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
> +void raw_free_string_stream(struct string_stream *stream)
> +{
> +       string_stream_clear(stream);
> +       kfree(stream);
> +}
> +
> +struct string_stream *raw_alloc_string_stream(gfp_t gfp)
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
>         return stream;
>  }
>
> -void string_stream_destroy(struct string_stream *stream)
> +struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
>  {
> -       string_stream_clear(stream);
> +       struct string_stream *stream;
> +
> +       stream = raw_alloc_string_stream(gfp);
> +       if (IS_ERR(stream))
> +               return stream;
> +
> +       stream->test = test;
> +
> +       if (kunit_add_action_or_reset(test, (kunit_action_t *)raw_free_string_stream, stream) != 0)
> +               return ERR_PTR(-ENOMEM);

As the kernel test robot notes, this sort of function pointer casting
is not technically valid C, and some compiler setups are starting to
warn on it.

Personally, I'm still okay with it, but expect a bunch of robot email
complaining about it if it lands. If more compilers / configs start
warning, though, I'll try to fix all callers of the KUnit action
functions which are affected.

> +
> +       return stream;
> +}
> +
> +void free_string_stream(struct kunit *test, struct string_stream *stream)
> +{
> +       if (!stream)
> +               return;
> +
> +       kunit_release_action(test, (kunit_action_t *)raw_free_string_stream, (void *)stream);

(As above.)

>  }
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index 6b4a747881c5..fbeda486382a 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -23,14 +23,24 @@ struct string_stream {
>         struct list_head fragments;
>         /* length and fragments are protected by this lock */
>         spinlock_t lock;
> +
> +       /*
> +        * Pointer to kunit this stream is associated with, or NULL if
> +        * not associated with a kunit.
> +        */
>         struct kunit *test;
> +

Can we just get rid of this totally? I don't think anything's actually
using it now. (Or have I missed something?)


>         gfp_t gfp;
>         bool append_newlines;
>  };
>
>  struct kunit;
>
> +struct string_stream *raw_alloc_string_stream(gfp_t gfp);
> +void raw_free_string_stream(struct string_stream *stream);
> +
>  struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
> +void free_string_stream(struct kunit *test, struct string_stream *stream);
>
>  int __printf(2, 3) string_stream_add(struct string_stream *stream,
>                                      const char *fmt, ...);
> @@ -47,7 +57,7 @@ int string_stream_append(struct string_stream *stream,
>
>  bool string_stream_is_empty(struct string_stream *stream);
>
> -void string_stream_destroy(struct string_stream *stream);
> +void string_stream_clear(struct string_stream *stream);
>
>  static inline void string_stream_set_append_newlines(struct string_stream *stream,
>                                                      bool append_newlines)
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 520e15f49d0d..4b69d12dfc96 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -322,7 +322,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
>
>         kunit_print_string_stream(test, stream);
>
> -       string_stream_destroy(stream);
> +       free_string_stream(test, stream);
>  }
>
>  void __noreturn __kunit_abort(struct kunit *test)
> --
> 2.30.2
>

--0000000000004e26f30602f2a42c
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC9
mZTIv6EGvtONOGTt4Kgo1Pq8KssaS+9xPG6lj8dgdTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE3MDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYlJvdh4KRmhVHrWeGAjS
p7iBYHzMZnSs5Rt3ZvP9zgxK8NXAhLshvnkviQMqnX/LuJ+gJGIsH4dPYlw/867rY48QM24Oh/Wn
0GdYwWex5w7zaa1ilguRaSkEGR5C90sN9nnvmARr8i2WZbR6NQ2CQ9ap3+tYwrufXsDKMy/HwHdE
aPKsncuXQPPyyMKOMyvk5qIaFldbjPCdYq3NiGM/koPy8hZwDoZ0aPCiea9Jjf6mAWSANrr7F/rl
BGl6qF8CTAIbQJ1oq8Q8nO22uD2NmeG/JDuIdCcckeFEW6xTmj4OKrDyjbafAduARy2MC746+aq4
HZONlZ57RkJWa6cvbw==
--0000000000004e26f30602f2a42c--
