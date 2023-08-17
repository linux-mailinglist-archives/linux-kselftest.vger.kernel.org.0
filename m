Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7177F07E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 08:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348207AbjHQG0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348195AbjHQG0Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 02:26:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6B2D57
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 23:26:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so41155e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692253580; x=1692858380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zjpLE7dJMwBGaXg89Sw/1KSxfabalxihPB33v+XQPMo=;
        b=O477YHTOMwrvoyjwkGiTBrrhoLEP4lHNkdVlH1LjWWMXLyrk7j6HwYvTHidaXVyC3X
         1SRHOnQ4NGYhgGwo65aREFXy1aUar2fW4XaX7xNO3He7e3zdSlazJF8wZB6NKMdqZfqy
         pi+f84UzzC4besVY2iYG2HStll69gcKE4x7nrvNU++GWUq0OgkwYaw0HFWB65w16nAMw
         Uv18AF+5htKbz5dB7e+PXF9MTmObbM1rqwEkLFRPVecZUQJ8mzWUTK9UsbCuQ8iaU2Aa
         HukYaYDcCCGVPy71t4BsboEKQnkTIZkZ0fkC+YqtFR+8qGKq5xSt/I9E0vLgO7QnQqDS
         XR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692253580; x=1692858380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjpLE7dJMwBGaXg89Sw/1KSxfabalxihPB33v+XQPMo=;
        b=c6PZ0XzL2tIj510BQq39b2cPF1QiN59Q4sP+fQ6Njp7b2ksD04KcUv1xuW8+kqq0Np
         4LH+B0S3NdCtfHcl1FBC+vf0oawcm1uMA5/vxcgMg0bkfvfYHnpwaMRPhrw4oTXltx5x
         +ooFwP4KzPWKF9gb8BQld1ll8sIperuM7vdNT/2HT1uhcEhdwER8rtkjh3m40EASO8lb
         YtVjKR+GAQ9gk6vHqZdNJeOmQmG2YZmdeTOzGa9SQ4WRwLH4iLFRZGwCFJ1vOektQ8Mx
         9MrtdUvg+5AujwBja7MqMr7mNwlWYozyHszxoJeJV3hOjCCMfc83Ckvqr7cDNrto1Xwo
         1RCA==
X-Gm-Message-State: AOJu0Yy0/9GuI4mGHxBJwSxr5JSM9ANbfOqT3W720RUVkYcGsORC1kNx
        Spsf0lfhiqAMVjD5Rt7+SuIX3H7tgxCY40A/VWfi2w==
X-Google-Smtp-Source: AGHT+IEg9tnwc8WF+mvTDG6+vAeC8VpOwvgKhX+FfrKeFv9eLQ8yKV7f+J7MX85lkvLLa9nRWb42Qq7vM01v7sEB4do=
X-Received: by 2002:a05:600c:524e:b0:3f7:e463:a0d6 with SMTP id
 fc14-20020a05600c524e00b003f7e463a0d6mr78366wmb.0.1692253580404; Wed, 16 Aug
 2023 23:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
 <20230814132309.32641-7-rf@opensource.cirrus.com> <CABVgOS=WoKEpPU=0f=mSfdx1g6AkEtx6QJTiNru1XSTev3sGaQ@mail.gmail.com>
 <a8804709-ee00-d2ea-d55d-f8138bd3a500@opensource.cirrus.com>
In-Reply-To: <a8804709-ee00-d2ea-d55d-f8138bd3a500@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 17 Aug 2023 14:26:08 +0800
Message-ID: <CABVgOSmPqM_zt9jGzYcJN-=AQW3z62cC7dzPJkV-jx6rCcMy=g@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] kunit: string-stream: Pass struct kunit to string_stream_get_string()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008fd8a50603187db7"
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

--0000000000008fd8a50603187db7
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Aug 2023 at 17:57, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 15/8/23 10:16, David Gow wrote:
> > On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Pass a struct kunit* and gfp_t to string_stream_get_string(). Allocate
> >> the returned buffer using these instead of using the stream->test and
> >> stream->gfp.
> >>
> >> This is preparation for removing the dependence of string_stream on
> >> struct kunit, so that string_stream can be used for the debugfs log.
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> ---
> >
> > Makes sense to me.
> >
> > I think that, if we weren't going to remove the struct kunit
> > dependency, we'd want to either keep a version of
> > string_stream_get_string() which uses it, or, e.g., fall back to it if
> > the struct passed in is NULL.
> >
>
> That was my first thought. But I thought that was open to subtle
> accidental bugs in calling code - it might return you a managed
> allocation, or it might return you an unmanaged allocation that you
> must free.
>
> As there weren't many callers of string_stream_get_string() I decided
> to go with changing the API to pass in test and gfp like other managed
> allocations. This makes it more generalized, since the returned buffer
> is not part of the stream itself, it's a temporary buffer owned by the
> caller. It also makes it clearer that what you are getting back is
> likely to be a managed allocation.
>
> If you'd prefer to leave string_stream_get_string() as it was, or make
> it return an unmanged buffer, I can send a new version.
>
> > The other option is to have a version which doesn't manage the string
> > at all, so just takes a gfp and requires the caller to free it (or
>
> I didn't add a companion function to get a raw unmanaged string buffer
> because there's nothing that needs it. It could be added later if
> it's needed.
>

Fair enough.

> > register an action to do so). If we did that, we could get rid of the
> > struct kunit pointer totally (though it may be better to keep it and
> > have both versions).
> >
>
> Another option is to make string_stream_get_string() return a raw
> buffer and add a kunit_string_stream_geT_string() that returns a
> managed buffer. This follows some consistency with the normal mallocs
> where kunit_xxxx() is the managed version.
>

Ooh... I like this best. Let's go with that.


> > So -- to switch to some stream-of-consciousness thoughts about this --
> > basically there are three possible variants of
> > string_stream_get_string():
> > - Current version: uses the stream's struct kunit. Useless if this is
> > NULL, but very convenient otherwise.
> > - This patch: manage the string using the struct kunit passed as an
> > argument. Still can't be used directly outside a test, but adds enough
> > flexibility to get _append to work.
> > - Totally unmanaged: the generated string is allocated separately, and
> > must be freed (directly or in a deferred action) by the caller. Works
> > well outside tests, but less convenient.
> >
> > Personally, I feel that the design of string_stream is heading towards
> > the third option. By the end of this series, everything uses
> > _string_stream_concatenate_to_buf() anyway. There's only one call to
> > string_stream_get_string() outside of the logging / string_stream
> > tests, and all that does is log the results (and it has a fallback to
> > log each fragment separately if the allocation fails).
> >
> > Then again, if this is only really being used in tests, then we can
> > probably just stick with string_stream_get_string() as-is, remove the
> > string_stream->test member totally, and if we need it, we can make
> > _string_stream_concatenate_to_buf() public, or add an unmanaged
> > version anyway.
> >
>
> I didn't remove ->test because there's some existing code in assert.c
> that uses it, and I didn't want to break that.
>

Since it seems the assert stuff isn't too difficult to make unmanaged,
can we go ahead and remove ->test?

If it turns out to be too nasty, let me know and we'll keep it (it's
not worth making major excavations), but I'd prefer to get rid of it
if we can.

Thanks,
-- David

> > So, after all that, I think this is probably good as-is. _Maybe_ we
> > could rename string_stream_get_string() to something like
> > string_stream_get_managed_string(), now that it's the only function
> > which is "managed" as a KUnit resource, but we can equally put that
> > off until we need to add an unmanaged version.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> >
> >>   lib/kunit/string-stream-test.c | 26 +++++++++++++++-----------
> >>   lib/kunit/string-stream.c      |  8 ++++----
> >>   lib/kunit/string-stream.h      |  3 ++-
> >>   lib/kunit/test.c               |  2 +-
> >>   4 files changed, 22 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> >> index 46c2ac162fe8..8a30bb7d5fb7 100644
> >> --- a/lib/kunit/string-stream-test.c
> >> +++ b/lib/kunit/string-stream-test.c
> >> @@ -57,7 +57,7 @@ static void string_stream_line_add_test(struct kunit *test)
> >>          }
> >>          num_lines = i;
> >>
> >> -       concat_string = string_stream_get_string(stream);
> >> +       concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
> >>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
> >>          KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
> >>
> >> @@ -113,7 +113,7 @@ static void string_stream_variable_length_line_test(struct kunit *test)
> >>          }
> >>          num_lines = i;
> >>
> >> -       concat_string = string_stream_get_string(stream);
> >> +       concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
> >>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
> >>          KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
> >>
> >> @@ -165,17 +165,18 @@ static void string_stream_append_test(struct kunit *test)
> >>
> >>          /* Append content of empty stream to empty stream */
> >>          string_stream_append(stream_1, stream_2);
> >> -       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(stream_1)), 0);
> >> +       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(test, stream_1, GFP_KERNEL)), 0);
> >>
> >>          /* Add some data to stream_1 */
> >>          for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
> >>                  string_stream_add(stream_1, "%s\n", strings_1[i]);
> >>
> >> -       original_content = string_stream_get_string(stream_1);
> >> +       original_content = string_stream_get_string(test, stream_1, GFP_KERNEL);
> >>
> >>          /* Append content of empty stream to non-empty stream */
> >>          string_stream_append(stream_1, stream_2);
> >> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), original_content);
> >> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
> >> +                          original_content);
> >>
> >>          /* Add some data to stream_2 */
> >>          for (i = 0; i < ARRAY_SIZE(strings_2); ++i)
> >> @@ -188,14 +189,15 @@ static void string_stream_append_test(struct kunit *test)
> >>           * End result should be the original content of stream_1 plus
> >>           * the content of stream_2.
> >>           */
> >> -       stream_2_content = string_stream_get_string(stream_2);
> >> +       stream_2_content = string_stream_get_string(test, stream_2, GFP_KERNEL);
> >>          combined_length = strlen(original_content) + strlen(stream_2_content);
> >>          combined_length++; /* for terminating \0 */
> >>          combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
> >>          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
> >>          snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
> >>
> >> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), combined_content);
> >> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
> >> +                          combined_content);
> >>
> >>          /* Append content of non-empty stream to empty stream */
> >>          string_stream_destroy(stream_1);
> >> @@ -204,7 +206,8 @@ static void string_stream_append_test(struct kunit *test)
> >>          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> >>
> >>          string_stream_append(stream_1, stream_2);
> >> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
> >> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
> >> +                          stream_2_content);
> >>   }
> >>
> >>   /* Adding an empty string should not create a fragment. */
> >> @@ -224,7 +227,8 @@ static void string_stream_append_empty_string_test(struct kunit *test)
> >>          string_stream_add(stream, "Add this line");
> >>          string_stream_add(stream, "%s", "");
> >>          KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), 1);
> >> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
> >> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
> >> +                          "Add this line");
> >>   }
> >>
> >>   /* Adding strings without automatic newline appending */
> >> @@ -244,7 +248,7 @@ static void string_stream_no_auto_newline_test(struct kunit *test)
> >>          string_stream_add(stream, "Two\n");
> >>          string_stream_add(stream, "%s\n", "Three");
> >>          string_stream_add(stream, "Four");
> >> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
> >> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
> >>                             "OneTwo\nThree\nFour");
> >>   }
> >>
> >> @@ -271,7 +275,7 @@ static void string_stream_auto_newline_test(struct kunit *test)
> >>          string_stream_add(stream, "Five\n%s", "Six");
> >>          string_stream_add(stream, "Seven\n\n");
> >>          string_stream_add(stream, "Eight");
> >> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
> >> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
> >>                             "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
> >>   }
> >>
> >> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> >> index 1dcf6513b692..eb673d3ea3bd 100644
> >> --- a/lib/kunit/string-stream.c
> >> +++ b/lib/kunit/string-stream.c
> >> @@ -117,13 +117,14 @@ static void string_stream_clear(struct string_stream *stream)
> >>          spin_unlock(&stream->lock);
> >>   }
> >>
> >> -char *string_stream_get_string(struct string_stream *stream)
> >> +char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
> >> +                              gfp_t gfp)
> >>   {
> >>          struct string_stream_fragment *frag_container;
> >>          size_t buf_len = stream->length + 1; /* +1 for null byte. */
> >>          char *buf;
> >>
> >> -       buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
> >> +       buf = kunit_kzalloc(test, buf_len, gfp);
> >>          if (!buf)
> >>                  return NULL;
> >>
> >> @@ -140,8 +141,7 @@ int string_stream_append(struct string_stream *stream,
> >>   {
> >>          const char *other_content;
> >>
> >> -       other_content = string_stream_get_string(other);
> >> -
> >> +       other_content = string_stream_get_string(other->test, other, other->gfp);
> >>          if (!other_content)
> >>                  return -ENOMEM;
> >>
> >> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> >> index 048930bf97f0..6b4a747881c5 100644
> >> --- a/lib/kunit/string-stream.h
> >> +++ b/lib/kunit/string-stream.h
> >> @@ -39,7 +39,8 @@ int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
> >>                                        const char *fmt,
> >>                                        va_list args);
> >>
> >> -char *string_stream_get_string(struct string_stream *stream);
> >> +char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
> >> +                              gfp_t gfp);
> >>
> >>   int string_stream_append(struct string_stream *stream,
> >>                           struct string_stream *other);
> >> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> >> index 49698a168437..520e15f49d0d 100644
> >> --- a/lib/kunit/test.c
> >> +++ b/lib/kunit/test.c
> >> @@ -286,7 +286,7 @@ static void kunit_print_string_stream(struct kunit *test,
> >>          if (string_stream_is_empty(stream))
> >>                  return;
> >>
> >> -       buf = string_stream_get_string(stream);
> >> +       buf = string_stream_get_string(test, stream, GFP_KERNEL);
> >>          if (!buf) {
> >>                  kunit_err(test,
> >>                            "Could not allocate buffer, dumping stream:\n");
> >> --
> >> 2.30.2
> >>

--0000000000008fd8a50603187db7
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB1
7LI+N8AYIM+sM7JjozqEbTEe6b6dtDxbw5uJq9rX3TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTcwNjI2MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQoAgbRp8h/aRo/59/gho
oG07uHrJDbtBeBH4Ja2rIgzJQdXFiEW6Qak/XsZKlvQovJbqxZcMjhFq0kL1+Hcvf+Jljhv3pMGz
Q5NpWITygr9PCaRE7ZK7AzO4yHg35H+z3+zbCYOtwGVzVQRY8ECqYiXxxqrfWrs7lxFloAvnLePN
B5Q+89ZhsEEJ4v4zz8FiKl4HTxRtIsqOR9E2KttxgQss8fJW1Px6jkfYkMzMVBhPRWVKYVqf44dY
5JNuVUnZnD3xGwAnM4EKcOxjutlcHU3CgXfuQaTqV4wgR7tM6AIEAIGb9PayFY3C3Y3Kjn7UIrXx
GQGcpXk8gyQxfzVSUg==
--0000000000008fd8a50603187db7--
