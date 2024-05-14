Return-Path: <linux-kselftest+bounces-10194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13C8C5BFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295FEB23186
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB78181CE4;
	Tue, 14 May 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMixjzVb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5372181331
	for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716535; cv=none; b=RQtqQhZVOJgCeJdUYxdWdESBtwhWeJui3kYide/0l/rLi/ZMp6YnpYediXxtuOVcX2b9pizQpxa7VdkvSeJDtnyk3BFAFpbYsaHWt+TRcbsrJRFCVjERYso5V1b/DUA0El4AA5KrsrXgZKm/qSXPY8F3rKSlcVRxowXuvOu3CQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716535; c=relaxed/simple;
	bh=wu4wwn/szGPfBtv9Z733SHGKlpn5NpOmM0MbAmAirrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQctnPuQD+CivAK/xAjixuUssvpy37PY2uQ4Ec82WM9lQ0A/9pWUl5ZBEie000zSQ087FU+svyNpLSWUyW64tNrm+3QAVUxj0PGPeBYhr/oeHen8sqH4jXcdrh7iKvltTAVgis/eGDCCx2C1Nhu+SaUV57w4r03/iBiwkFXz6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMixjzVb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so1609391cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715716532; x=1716321332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkB5N7IwTZgL/DLJyMJXKJLT8toamvuP/cBz435PCxE=;
        b=KMixjzVbsd8pxJAIIxkBkuDb/4L5nben8QgmGX7t4hHolIKqpu7pBkbQC8bDWjuUOT
         R4WxCupfjxcERXxgDcFajvPxkcJjky+rcE67BOqz8B8TKRQyCBQ1vK2uRJrAbmNM8NuJ
         SYdNnMOleZSwtSCx/JfxqKqlkCtwwSHBXhLufN1stSm8VGKBnsLUofu2Dx1G0onJI5CA
         o3CoClsyKI/jpXAmLbSY+uFL45cmELTj0at5mFu+Jh6/iLyVVdjFXin3Wlo8RI6DCMDz
         DeAgVZgS3OPhZW/noPAc+1CyWiTsg3Y4SYzU+2VeSiSy3rziEb/wW8Khy0FkFqw+OxXE
         B+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716532; x=1716321332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkB5N7IwTZgL/DLJyMJXKJLT8toamvuP/cBz435PCxE=;
        b=gdSBYpFAm6WhjoCSn8guOHvba5n2nwF7fEJonHn/15DvY0AYZ6jCkhepWwN+TOssqv
         HIc0bx138sgCGh203bYsHtWoOHJ7CYgq5X66cVl7jBlzVLSwIVmLdxqqRYItEr013Xpt
         r7lDzbTwZLXGVFlKR+DQgccwdblplaFc4I4vFfSOQpRqcH5ZjJC6dOyXIyr6haDxzDYm
         ToO6rX7GMDJ1uIPKBn/fuUX2/dpZMr6GyZwrT+wgqzVDpJ+9g3Pr3DqhrzdRpCxb9R+o
         wyne7z3YNw1b2gh0aI0yTjRs+VFXlfzEdpTQRbH+0ETxV9Z8cQcDbkLMMtV73MFmbW7Q
         /0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXelIgcqZjewwU4YJgA4D5YtfhNMS1TxxqeOIcsJaL70dE/t4lgSS/4FBQNEb0LtW53kDRm5q/oM/IfnKxuSCapx6U+50RFqhBnvfSEFqB7
X-Gm-Message-State: AOJu0Yyze2o560UGE9XskEqL2q7Vw5AS0BsZzFd+23BP4T2HVQPJnFGX
	00dZQpmZP7R+X8jSJuUyYip048dWGNLZVrKdrEKqx/c1MJqU+txkysg5eAdNiiutmPVUgcTigpN
	QXV/q7UbFa/GYsvc08sLmoImBu7TRjbQUH3dl
X-Google-Smtp-Source: AGHT+IGtcx05O4q8YAEmuiNgXLzq2h1G5K2WbFqAjjyNqzUiPZ6FBrj3MReSP+NvB/i9vJBT7N9r8plg4S4fUfTNYtQ=
X-Received: by 2002:a05:622a:98f:b0:43c:554e:b81 with SMTP id
 d75a77b69052e-43e0a28c3c5mr9978891cf.23.1715716532332; Tue, 14 May 2024
 12:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509090546.944808-1-ivan.orlov0322@gmail.com>
 <CA+GJov6hq0WsjqX1LrC2m7YS1nD37+zGmO+i1R1OajwYQZXY8w@mail.gmail.com> <44b5b31f-ac98-4c5c-8bc4-ebff9579b4d7@gmail.com>
In-Reply-To: <44b5b31f-ac98-4c5c-8bc4-ebff9579b4d7@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 14 May 2024 15:55:20 -0400
Message-ID: <CA+GJov7O9Hj1g3mMRjdnkcUCORofkxsqtn06t_JGOkNRBhfGCg@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: Cover 'assert.c' with tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:31=E2=80=AFAM Ivan Orlov <ivan.orlov0322@gmail.c=
om> wrote:
>
> On 5/14/24 01:17, Rae Moar wrote:
> > On Thu, May 9, 2024 at 5:05=E2=80=AFAM Ivan Orlov <ivan.orlov0322@gmail=
.com> wrote:
> >>
> >> There are multiple assertion formatting functions in the `assert.c`
> >> file, which are not covered with tests yet. Implement the KUnit test
> >> for these functions.
> >>
> >> The test consists of 11 test cases for the following functions:
> >>
> >> 1) 'is_literal'
> >> 2) 'is_str_literal'
> >> 3) 'kunit_assert_prologue', test case for multiple assert types
> >> 4) 'kunit_assert_print_msg'
> >> 5) 'kunit_unary_assert_format'
> >> 6) 'kunit_ptr_not_err_assert_format'
> >> 7) 'kunit_binary_assert_format'
> >> 8) 'kunit_binary_ptr_assert_format'
> >> 9) 'kunit_binary_str_assert_format'
> >> 10) 'kunit_assert_hexdump'
> >> 11) 'kunit_mem_assert_format'
> >>
> >> The test aims at maximizing the branch coverage for the assertion
> >> formatting functions.
> >>
> >> As you can see, it covers some of the static helper functions as
> >> well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
> >> and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
> >> corresponding definitions to `assert.h`.
> >>
> >> Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
> >> how it is done for the string stream test.
> >
> > Hello!
> >
> > This looks great to me! Thanks for all your work on this! There is
> > just one comment I have below. Once that is fixed up, I am happy to
> > add a reviewed-by.
> >
> > Thanks!
> > -Rae
> >
> >>
> >> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> >> ---
> >> V1 -> V2:
> >> - Check the output from the string stream for containing the key parts
> >> instead of comparing the results with expected strings char by char, a=
s
> >> it was suggested by Rae Moar <rmoar@google.com>. Define two macros to
> >> make it possible (ASSERT_TEST_EXPECT_CONTAIN and
> >> ASSERT_TEST_EXPECT_NCONTAIN).
> >> - Mark the static functions in `assert.c` as VISIBLE_IF_KUNIT and expo=
rt
> >> them conditionally if kunit is enabled instead of including the
> >> `assert_test.c` file in the end of `assert.c`. This way we will decoup=
le
> >> the test from the implementation (SUT).
> >> - Update the kunit_assert_hexdump test: now it checks for presense of
> >> the brackets '<>' around the non-matching bytes, instead of comparing
> >> the kunit_assert_hexdump output char by char.
> >> V2 -> V3:
> >> - Make test case array and test suite definitions static
> >> - Change the condition in `assert.h`: we should declare VISIBLE_IF_KUN=
IT
> >> functions in the header file when CONFIG_KUNIT is enabled, not
> >> CONFIG_KUNIT_TEST. Otherwise, if CONFIG_KUNIT_TEST is disabled,
> >> VISIBLE_IF_KUNIT functions in the `assert.c` are not static, and
> >> prototypes for them can't be found.
> >> - Add MODULE_LICENSE and MODULE_DESCRIPTION macros
> >>
> >>   include/kunit/assert.h  |  11 ++
> >>   lib/kunit/Makefile      |   1 +
> >>   lib/kunit/assert.c      |  24 ++-
> >>   lib/kunit/assert_test.c | 391 ++++++++++++++++++++++++++++++++++++++=
++
> >>   4 files changed, 419 insertions(+), 8 deletions(-)
> >>   create mode 100644 lib/kunit/assert_test.c
> >>
> >> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> >> index 24c2b9fa61e8..7e7490a74b13 100644
> >> --- a/include/kunit/assert.h
> >> +++ b/include/kunit/assert.h
> >> @@ -218,4 +218,15 @@ void kunit_mem_assert_format(const struct kunit_a=
ssert *assert,
> >>                               const struct va_format *message,
> >>                               struct string_stream *stream);
> >>
> >> +#if IS_ENABLED(CONFIG_KUNIT)
> >> +void kunit_assert_print_msg(const struct va_format *message,
> >> +                           struct string_stream *stream);
> >> +bool is_literal(const char *text, long long value);
> >> +bool is_str_literal(const char *text, const char *value);
> >> +void kunit_assert_hexdump(struct string_stream *stream,
> >> +                         const void *buf,
> >> +                         const void *compared_buf,
> >> +                         const size_t len);
> >> +#endif
> >> +
> >>   #endif /*  _KUNIT_ASSERT_H */
> >> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> >> index 309659a32a78..be7c9903936f 100644
> >> --- a/lib/kunit/Makefile
> >> +++ b/lib/kunit/Makefile
> >> @@ -18,6 +18,7 @@ endif
> >>   obj-y +=3D                               hooks.o
> >>
> >>   obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
> >> +obj-$(CONFIG_KUNIT_TEST) +=3D            assert_test.o
> >>
> >>   # string-stream-test compiles built-in only.
> >>   ifeq ($(CONFIG_KUNIT_TEST),y)
> >> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> >> index dd1d633d0fe2..382eb409d34b 100644
> >> --- a/lib/kunit/assert.c
> >> +++ b/lib/kunit/assert.c
> >> @@ -7,6 +7,7 @@
> >>    */
> >>   #include <kunit/assert.h>
> >>   #include <kunit/test.h>
> >> +#include <kunit/visibility.h>
> >>
> >>   #include "string-stream.h"
> >>
> >> @@ -30,12 +31,14 @@ void kunit_assert_prologue(const struct kunit_loc =
*loc,
> >>   }
> >>   EXPORT_SYMBOL_GPL(kunit_assert_prologue);
> >>
> >> -static void kunit_assert_print_msg(const struct va_format *message,
> >> -                                  struct string_stream *stream)
> >> +VISIBLE_IF_KUNIT
> >> +void kunit_assert_print_msg(const struct va_format *message,
> >> +                           struct string_stream *stream)
> >>   {
> >>          if (message->fmt)
> >>                  string_stream_add(stream, "\n%pV", message);
> >>   }
> >> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
> >>
> >>   void kunit_fail_assert_format(const struct kunit_assert *assert,
> >>                                const struct va_format *message,
> >> @@ -89,7 +92,7 @@ void kunit_ptr_not_err_assert_format(const struct ku=
nit_assert *assert,
> >>   EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
> >>
> >>   /* Checks if `text` is a literal representing `value`, e.g. "5" and =
5 */
> >> -static bool is_literal(const char *text, long long value)
> >> +VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
> >>   {
> >>          char *buffer;
> >>          int len;
> >> @@ -110,6 +113,7 @@ static bool is_literal(const char *text, long long=
 value)
> >>
> >>          return ret;
> >>   }
> >> +EXPORT_SYMBOL_IF_KUNIT(is_literal);
> >>
> >>   void kunit_binary_assert_format(const struct kunit_assert *assert,
> >>                                  const struct va_format *message,
> >> @@ -166,7 +170,7 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
> >>   /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
> >>    * Note: `text` will have ""s where as `value` will not.
> >>    */
> >> -static bool is_str_literal(const char *text, const char *value)
> >> +VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *va=
lue)
> >>   {
> >>          int len;
> >>
> >> @@ -178,6 +182,7 @@ static bool is_str_literal(const char *text, const=
 char *value)
> >>
> >>          return strncmp(text + 1, value, len - 2) =3D=3D 0;
> >>   }
> >> +EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
> >>
> >>   void kunit_binary_str_assert_format(const struct kunit_assert *asser=
t,
> >>                                      const struct va_format *message,
> >> @@ -208,10 +213,11 @@ EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format=
);
> >>   /* Adds a hexdump of a buffer to a string_stream comparing it with
> >>    * a second buffer. The different bytes are marked with <>.
> >>    */
> >> -static void kunit_assert_hexdump(struct string_stream *stream,
> >> -                                const void *buf,
> >> -                                const void *compared_buf,
> >> -                                const size_t len)
> >> +VISIBLE_IF_KUNIT
> >> +void kunit_assert_hexdump(struct string_stream *stream,
> >> +                         const void *buf,
> >> +                         const void *compared_buf,
> >> +                         const size_t len)
> >>   {
> >>          size_t i;
> >>          const u8 *buf1 =3D buf;
> >> @@ -229,6 +235,7 @@ static void kunit_assert_hexdump(struct string_str=
eam *stream,
> >>                          string_stream_add(stream, " %02x ", buf1[i]);
> >>          }
> >>   }
> >> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
> >>
> >>   void kunit_mem_assert_format(const struct kunit_assert *assert,
> >>                               const struct va_format *message,
> >> @@ -269,4 +276,5 @@ void kunit_mem_assert_format(const struct kunit_as=
sert *assert,
> >>                  kunit_assert_print_msg(message, stream);
> >>          }
> >>   }
> >> +
> >>   EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
> >> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> >> new file mode 100644
> >> index 000000000000..1347a964204b
> >> --- /dev/null
> >> +++ b/lib/kunit/assert_test.c
> >> @@ -0,0 +1,391 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * KUnit test for the assertion formatting functions.
> >> + * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
> >> + */
> >> +#include <kunit/test.h>
> >> +#include "string-stream.h"
> >> +
> >> +#define TEST_PTR_EXPECTED_BUF_SIZE 32
> >> +#define HEXDUMP_TEST_BUF_LEN 5
> >> +#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TR=
UE(test, strstr(str, substr))
> >> +#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_F=
ALSE(test, strstr(str, substr))
> >> +
> >> +static void kunit_test_is_literal(struct kunit *test)
> >> +{
> >> +       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
> >> +       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
> >> +       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
> >> +       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890)=
);
> >> +       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
> >> +       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
> >> +       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
> >> +       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
> >> +}
> >> +
> >> +static void kunit_test_is_str_literal(struct kunit *test)
> >> +{
> >> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "H=
ello, World!"));
> >> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> >> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> >> +       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> >> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> >> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"=
));
> >> +       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"=
));
> >> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abac=
aba\""));
> >> +}
> >> +
> >> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> >> +
> >> +/* this function is used to get a "char *" string from the string str=
eam and defer its cleanup  */
> >> +static char *get_str_from_stream(struct kunit *test, struct string_st=
ream *stream)
> >> +{
> >> +       char *str =3D string_stream_get_string(stream);
> >> +
> >
> > When trying to make the kernel with this test loaded in, I am getting
> > an error that string_stream_get_string, string_stream_clear, and
> > kunit_alloc_string_stream are undefined.
> >
> > So either these three methods will have to be exported using
> > EXPORT_SYMBOL_KUNIT or this test cannot be loaded and run as a module.
> >
> > But once this is fixed up this should be good to go.
>
> Hi Rae,
>
> Thank you so much for the review.
>
> At the moment, I believe the best approach would be to make this test
> depend on CONFIG_KUNIT_TEST=3Dy (as it is done for string-stream-test).
>
> However, I assume that every (standalone) test should be able to run as
> a module, and I'd like to add EXPORT_SYMBOL_IF_KUNIT to all of the
> non-static string-stream functions in a separate patch series. It will
> require updating string-stream-test.c as well (adding MODULE_IMPORT_NS).
> What do you think?
>
> Thank you once again,
> --
> Kind regards,
> Ivan Orlov

Hello!

This sounds like a great approach! Happy to review the new patch
series when it comes in.

Thanks,
Rae

>

