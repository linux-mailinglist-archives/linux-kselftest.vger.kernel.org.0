Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090E77CA43
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjHOJSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHOJRm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:17:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4496211C
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:16:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so53375e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692091014; x=1692695814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SZvY3Yf49mHo9rERCLI9vAWWxabrI+TVilzREBE3CQ=;
        b=JCgq12gLqZRNDFAFYHoAMg2AgUy2pAEdfY3dOcikGBG7zKSctl4SHhr3UNVfKEhnJJ
         MRBnassQw2P8+XEWp65TbEPKZtihKaKUzvtYk4LivcDTQ5i8uceW/n4o71k0+lWk6qlg
         YLsw0u34yCCpEvqRgWgX3ubTGlokiX13SdlrJZWxsrQEjlpRkIgLh3jfc0ZDW0UZ8yxK
         a61pLBtFNjJrTYIH1RoEziTDWj+Dg+8Tk5m9NzekVfZfazH0tFZ2EN7guiWlOGrws6ll
         cx6iT1KOIeEjnOfehJ/oGfbvufWohot+i1m7I7O1QbLHlaS2zymuZzFrWj0GCHCOq/Vj
         kxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091014; x=1692695814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SZvY3Yf49mHo9rERCLI9vAWWxabrI+TVilzREBE3CQ=;
        b=gAZunreYgvMqIXZF91tkUKvSJv0tltCgbY4SjK7+6amCFpyz3GD6iVBv8R5hIBQ8jO
         Gc2AUlhiO55hJoYH68uDV8/CP90wzUuTVjFbAov6pxk4nA9Nh2r+/YRrZ47WF9yCmw7P
         PV/+B0qoOR8Mvy/RlvIaTrJOO3LUL1Cu/mPrOyrBmNDxzLotofqSOX35o4x53iLRzuzE
         dv6CqwhvhtH4nESVnUcBmwza3ID4+uEA1H/6Kt7c1WHy1UTPRQ8kYNliADyDxGMWvWfO
         ILTvz1H7K4We1Zo7p+wlVrSXHxa1X2QHOsdBkZuoo4YYOzZg+d9XyeaWsjsL5xBuRVcd
         aisg==
X-Gm-Message-State: AOJu0Ywx2MHKCvrD+x7pGeA4v8wZZ+8j71X8Gl4LEg8DYSQhZkAtPyPk
        53BUjjKC2FkwWLvHxIz2a8Cp90g5W1SSxXJYoG75pw==
X-Google-Smtp-Source: AGHT+IFm9v8q7sltOVO6NgGIbTaGY+17+qBbouUDsyMaf2v2Mr3J6VVBWeWFVDeMCDUiKyDkDsx6mD0fT9aAQ5EpfpE=
X-Received: by 2002:a05:600c:1d84:b0:3f1:73b8:b5fe with SMTP id
 p4-20020a05600c1d8400b003f173b8b5femr368172wms.3.1692091014107; Tue, 15 Aug
 2023 02:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-7-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-7-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:16:42 +0800
Message-ID: <CABVgOS=WoKEpPU=0f=mSfdx1g6AkEtx6QJTiNru1XSTev3sGaQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] kunit: string-stream: Pass struct kunit to string_stream_get_string()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d67c320602f2a324"
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

--000000000000d67c320602f2a324
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Pass a struct kunit* and gfp_t to string_stream_get_string(). Allocate
> the returned buffer using these instead of using the stream->test and
> stream->gfp.
>
> This is preparation for removing the dependence of string_stream on
> struct kunit, so that string_stream can be used for the debugfs log.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Makes sense to me.

I think that, if we weren't going to remove the struct kunit
dependency, we'd want to either keep a version of
string_stream_get_string() which uses it, or, e.g., fall back to it if
the struct passed in is NULL.

The other option is to have a version which doesn't manage the string
at all, so just takes a gfp and requires the caller to free it (or
register an action to do so). If we did that, we could get rid of the
struct kunit pointer totally (though it may be better to keep it and
have both versions).

So -- to switch to some stream-of-consciousness thoughts about this --
basically there are three possible variants of
string_stream_get_string():
- Current version: uses the stream's struct kunit. Useless if this is
NULL, but very convenient otherwise.
- This patch: manage the string using the struct kunit passed as an
argument. Still can't be used directly outside a test, but adds enough
flexibility to get _append to work.
- Totally unmanaged: the generated string is allocated separately, and
must be freed (directly or in a deferred action) by the caller. Works
well outside tests, but less convenient.

Personally, I feel that the design of string_stream is heading towards
the third option. By the end of this series, everything uses
_string_stream_concatenate_to_buf() anyway. There's only one call to
string_stream_get_string() outside of the logging / string_stream
tests, and all that does is log the results (and it has a fallback to
log each fragment separately if the allocation fails).

Then again, if this is only really being used in tests, then we can
probably just stick with string_stream_get_string() as-is, remove the
string_stream->test member totally, and if we need it, we can make
_string_stream_concatenate_to_buf() public, or add an unmanaged
version anyway.

So, after all that, I think this is probably good as-is. _Maybe_ we
could rename string_stream_get_string() to something like
string_stream_get_managed_string(), now that it's the only function
which is "managed" as a KUnit resource, but we can equally put that
off until we need to add an unmanaged version.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream-test.c | 26 +++++++++++++++-----------
>  lib/kunit/string-stream.c      |  8 ++++----
>  lib/kunit/string-stream.h      |  3 ++-
>  lib/kunit/test.c               |  2 +-
>  4 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 46c2ac162fe8..8a30bb7d5fb7 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -57,7 +57,7 @@ static void string_stream_line_add_test(struct kunit *test)
>         }
>         num_lines = i;
>
> -       concat_string = string_stream_get_string(stream);
> +       concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
>         KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
>
> @@ -113,7 +113,7 @@ static void string_stream_variable_length_line_test(struct kunit *test)
>         }
>         num_lines = i;
>
> -       concat_string = string_stream_get_string(stream);
> +       concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
>         KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
>
> @@ -165,17 +165,18 @@ static void string_stream_append_test(struct kunit *test)
>
>         /* Append content of empty stream to empty stream */
>         string_stream_append(stream_1, stream_2);
> -       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(stream_1)), 0);
> +       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(test, stream_1, GFP_KERNEL)), 0);
>
>         /* Add some data to stream_1 */
>         for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
>                 string_stream_add(stream_1, "%s\n", strings_1[i]);
>
> -       original_content = string_stream_get_string(stream_1);
> +       original_content = string_stream_get_string(test, stream_1, GFP_KERNEL);
>
>         /* Append content of empty stream to non-empty stream */
>         string_stream_append(stream_1, stream_2);
> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), original_content);
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
> +                          original_content);
>
>         /* Add some data to stream_2 */
>         for (i = 0; i < ARRAY_SIZE(strings_2); ++i)
> @@ -188,14 +189,15 @@ static void string_stream_append_test(struct kunit *test)
>          * End result should be the original content of stream_1 plus
>          * the content of stream_2.
>          */
> -       stream_2_content = string_stream_get_string(stream_2);
> +       stream_2_content = string_stream_get_string(test, stream_2, GFP_KERNEL);
>         combined_length = strlen(original_content) + strlen(stream_2_content);
>         combined_length++; /* for terminating \0 */
>         combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
>         snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
>
> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), combined_content);
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
> +                          combined_content);
>
>         /* Append content of non-empty stream to empty stream */
>         string_stream_destroy(stream_1);
> @@ -204,7 +206,8 @@ static void string_stream_append_test(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
>
>         string_stream_append(stream_1, stream_2);
> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
> +                          stream_2_content);
>  }
>
>  /* Adding an empty string should not create a fragment. */
> @@ -224,7 +227,8 @@ static void string_stream_append_empty_string_test(struct kunit *test)
>         string_stream_add(stream, "Add this line");
>         string_stream_add(stream, "%s", "");
>         KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), 1);
> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
> +                          "Add this line");
>  }
>
>  /* Adding strings without automatic newline appending */
> @@ -244,7 +248,7 @@ static void string_stream_no_auto_newline_test(struct kunit *test)
>         string_stream_add(stream, "Two\n");
>         string_stream_add(stream, "%s\n", "Three");
>         string_stream_add(stream, "Four");
> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
>                            "OneTwo\nThree\nFour");
>  }
>
> @@ -271,7 +275,7 @@ static void string_stream_auto_newline_test(struct kunit *test)
>         string_stream_add(stream, "Five\n%s", "Six");
>         string_stream_add(stream, "Seven\n\n");
>         string_stream_add(stream, "Eight");
> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
>                            "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
>  }
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 1dcf6513b692..eb673d3ea3bd 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -117,13 +117,14 @@ static void string_stream_clear(struct string_stream *stream)
>         spin_unlock(&stream->lock);
>  }
>
> -char *string_stream_get_string(struct string_stream *stream)
> +char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
> +                              gfp_t gfp)
>  {
>         struct string_stream_fragment *frag_container;
>         size_t buf_len = stream->length + 1; /* +1 for null byte. */
>         char *buf;
>
> -       buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
> +       buf = kunit_kzalloc(test, buf_len, gfp);
>         if (!buf)
>                 return NULL;
>
> @@ -140,8 +141,7 @@ int string_stream_append(struct string_stream *stream,
>  {
>         const char *other_content;
>
> -       other_content = string_stream_get_string(other);
> -
> +       other_content = string_stream_get_string(other->test, other, other->gfp);
>         if (!other_content)
>                 return -ENOMEM;
>
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index 048930bf97f0..6b4a747881c5 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -39,7 +39,8 @@ int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
>                                       const char *fmt,
>                                       va_list args);
>
> -char *string_stream_get_string(struct string_stream *stream);
> +char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
> +                              gfp_t gfp);
>
>  int string_stream_append(struct string_stream *stream,
>                          struct string_stream *other);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..520e15f49d0d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -286,7 +286,7 @@ static void kunit_print_string_stream(struct kunit *test,
>         if (string_stream_is_empty(stream))
>                 return;
>
> -       buf = string_stream_get_string(stream);
> +       buf = string_stream_get_string(test, stream, GFP_KERNEL);
>         if (!buf) {
>                 kunit_err(test,
>                           "Could not allocate buffer, dumping stream:\n");
> --
> 2.30.2
>

--000000000000d67c320602f2a324
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC0
Ibu4kZvO7M/tNPYbM7c+Rb/Y5Dfg+/MptmHw4EIlvzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE2NTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALXSAS3fhjOyaPBA9da5f
6BrVuzxCCgTjleaa669AsopVswpMS7jEHtvetEHaFgJulXlSsnCXQ7pz3HJ5sWMDu8W6zS5daJ9i
DM29xmFKrUxthEvRtwBdV8x69mxeQs3mWvsb4rso9JZA/MMhQopdyXqOu2sttGhD05rRZeuWA0TZ
v93hEznspnZOgNKgiV2s83JtjgtyZJwXt1odWhS56GBudo9sv/bV2JF3tEV3Utd6+jjERNVwDbi7
kYM0BrSS8whX5qQVKnHvkk0xiBkKX03r76qeR3D592BM/ylx0f3uK/vDgEFe4fjq7B33P5yIyLt1
scCpZYa5/furBBbGBg==
--000000000000d67c320602f2a324--
