Return-Path: <linux-kselftest+bounces-10163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC668C4A62
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 02:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA6E282394
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 00:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EC639;
	Tue, 14 May 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmqE/mQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFE365
	for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645870; cv=none; b=tUkRemUW8qO3iv18IAbIZ/bo7CAeFZAe4t7gK+xUdBqk3kiPhP7sE8eM/HjmkuLTtn5QgZM45YbWQ0S1CoQ+eNywTf/tLW2RCyrRMf32xJymDJRYcIjvulsKfMKb5+2tQbluzQar6HLZjXv0nfAL8WUule64IlxfzfNats416kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645870; c=relaxed/simple;
	bh=QQycI1a7NLA6Ms3Nz4nOrZHxIFEg7ZldpgbSIMVs6Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtYDiwBtZpfwgZyvpbxGpc3T4VJzkWUUj16oQmRczlkM3jV05nD+t3qEb+e1A4+8oPAlg9EDKqysXkgfK0b2Q5xIAuXtsNn4yukWgvSpjr4RtTvsUmGOfXBtxiF1Mxl8M/a8AFvCzYBvfQfy2gTyOTIQpIQ3Q0vZoAYsr0/wQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmqE/mQE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43dfa9a98d2so413791cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 17:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715645866; x=1716250666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMTBeUXGTgrJQmo/fvxLgp+AqPMx0tJvAn1frxYsEgw=;
        b=CmqE/mQEt0gyU6mTPehRtTE6sK4waIWoI4CFRLvgJrF4bdF3dgm6mB7Cyv0Deei98o
         VVm/aMZLRJxT8T78md19jF6DSL+G8fenbxmJcP8QM3xbjElSqJF8lV6sbf9/IMGVDJTI
         aJhTqx1eN2fi+2zURGRp3P8T9NosyGN5jmywAPsqPYjRUq7uRNhavRfHaat6iGBu5PJl
         tzdodzHviUabVlxEzjo+wYFnPI88qPUN8IDhujytCHdaeN9xntNWAIKp/x/qtVHgokpl
         OQVV0OP5qFnuecRWVAV7qMS+bjioVi1VwO5l4Vx2+K71o1wi/LMF1hymqs5oVSive/an
         Kk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715645866; x=1716250666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMTBeUXGTgrJQmo/fvxLgp+AqPMx0tJvAn1frxYsEgw=;
        b=KYpYSIOBmUkOg5uTJYzx3MUNGKtqHMROBrmVDIeQOalCRQj1vbMmVvZvmuy8XABGaG
         qM+c9bmSJHJO6f4k7RF6zUDmP20voy0DMOOXSAvp53qUMWtHQSPjmaBMO8i1ifF0Vghs
         CM4Q6LPOwTsoVP0GFfHdSgtp9ph0KHlc2C3YzjayoL9vdv2XUdtNj0dcIdOxwhLpryvc
         5wxt6/DbLiyt0/w+qQktijz3OmeXc0JCkqLjxZ7Vu+Ua7t4HMYW8b+KbYmAb3FB1gr2J
         mr4tmgwSxl+VDI+QCagD4lKbMMz8eA6x1RngyDOA3dkk9JvC/HfVYYppOPekR1J2oDqU
         iHDw==
X-Forwarded-Encrypted: i=1; AJvYcCXkAD/+lp+77FCS/+rkFenameDNvD/YvbyMDvFgX/kjWl8Cgt3KLnL8uweGeQRPGmIKS6E25suiBiX8dfo9uopEcvU3LSERThuwq77KlM+N
X-Gm-Message-State: AOJu0YwjPcJNRAKJrE168uzN+/BSshSrQiV3ziukgnTyV15nja6cYxlO
	Qxvjy1gUYjqqnhN4NwGJmZ1lIw8Zg6C0L1vnF55p2vbmJ3E3Li4WGnquTBW6C/P3l3IO/JXO+fJ
	QIEF+6xyHKobU2HhcvXugBwBD3CLoyhCldmsv
X-Google-Smtp-Source: AGHT+IHtxUS9h95rKgD+PHiXnQ5DDprKLUFUdmebhC5QpULfOTK//AVr05QpHDXXKSPPV6X6ZePT3eNchamWxHj0Nc8=
X-Received: by 2002:a05:622a:4818:b0:43d:9a81:ffac with SMTP id
 d75a77b69052e-43e094d0413mr7789021cf.2.1715645866259; Mon, 13 May 2024
 17:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509090546.944808-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240509090546.944808-1-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 13 May 2024 20:17:33 -0400
Message-ID: <CA+GJov6hq0WsjqX1LrC2m7YS1nD37+zGmO+i1R1OajwYQZXY8w@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: Cover 'assert.c' with tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:05=E2=80=AFAM Ivan Orlov <ivan.orlov0322@gmail.com=
> wrote:
>
> There are multiple assertion formatting functions in the `assert.c`
> file, which are not covered with tests yet. Implement the KUnit test
> for these functions.
>
> The test consists of 11 test cases for the following functions:
>
> 1) 'is_literal'
> 2) 'is_str_literal'
> 3) 'kunit_assert_prologue', test case for multiple assert types
> 4) 'kunit_assert_print_msg'
> 5) 'kunit_unary_assert_format'
> 6) 'kunit_ptr_not_err_assert_format'
> 7) 'kunit_binary_assert_format'
> 8) 'kunit_binary_ptr_assert_format'
> 9) 'kunit_binary_str_assert_format'
> 10) 'kunit_assert_hexdump'
> 11) 'kunit_mem_assert_format'
>
> The test aims at maximizing the branch coverage for the assertion
> formatting functions.
>
> As you can see, it covers some of the static helper functions as
> well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
> and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
> corresponding definitions to `assert.h`.
>
> Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
> how it is done for the string stream test.

Hello!

This looks great to me! Thanks for all your work on this! There is
just one comment I have below. Once that is fixed up, I am happy to
add a reviewed-by.

Thanks!
-Rae

>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
> V1 -> V2:
> - Check the output from the string stream for containing the key parts
> instead of comparing the results with expected strings char by char, as
> it was suggested by Rae Moar <rmoar@google.com>. Define two macros to
> make it possible (ASSERT_TEST_EXPECT_CONTAIN and
> ASSERT_TEST_EXPECT_NCONTAIN).
> - Mark the static functions in `assert.c` as VISIBLE_IF_KUNIT and export
> them conditionally if kunit is enabled instead of including the
> `assert_test.c` file in the end of `assert.c`. This way we will decouple
> the test from the implementation (SUT).
> - Update the kunit_assert_hexdump test: now it checks for presense of
> the brackets '<>' around the non-matching bytes, instead of comparing
> the kunit_assert_hexdump output char by char.
> V2 -> V3:
> - Make test case array and test suite definitions static
> - Change the condition in `assert.h`: we should declare VISIBLE_IF_KUNIT
> functions in the header file when CONFIG_KUNIT is enabled, not
> CONFIG_KUNIT_TEST. Otherwise, if CONFIG_KUNIT_TEST is disabled,
> VISIBLE_IF_KUNIT functions in the `assert.c` are not static, and
> prototypes for them can't be found.
> - Add MODULE_LICENSE and MODULE_DESCRIPTION macros
>
>  include/kunit/assert.h  |  11 ++
>  lib/kunit/Makefile      |   1 +
>  lib/kunit/assert.c      |  24 ++-
>  lib/kunit/assert_test.c | 391 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 419 insertions(+), 8 deletions(-)
>  create mode 100644 lib/kunit/assert_test.c
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 24c2b9fa61e8..7e7490a74b13 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -218,4 +218,15 @@ void kunit_mem_assert_format(const struct kunit_asse=
rt *assert,
>                              const struct va_format *message,
>                              struct string_stream *stream);
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void kunit_assert_print_msg(const struct va_format *message,
> +                           struct string_stream *stream);
> +bool is_literal(const char *text, long long value);
> +bool is_str_literal(const char *text, const char *value);
> +void kunit_assert_hexdump(struct string_stream *stream,
> +                         const void *buf,
> +                         const void *compared_buf,
> +                         const size_t len);
> +#endif
> +
>  #endif /*  _KUNIT_ASSERT_H */
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 309659a32a78..be7c9903936f 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -18,6 +18,7 @@ endif
>  obj-y +=3D                               hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
> +obj-$(CONFIG_KUNIT_TEST) +=3D            assert_test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index dd1d633d0fe2..382eb409d34b 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -7,6 +7,7 @@
>   */
>  #include <kunit/assert.h>
>  #include <kunit/test.h>
> +#include <kunit/visibility.h>
>
>  #include "string-stream.h"
>
> @@ -30,12 +31,14 @@ void kunit_assert_prologue(const struct kunit_loc *lo=
c,
>  }
>  EXPORT_SYMBOL_GPL(kunit_assert_prologue);
>
> -static void kunit_assert_print_msg(const struct va_format *message,
> -                                  struct string_stream *stream)
> +VISIBLE_IF_KUNIT
> +void kunit_assert_print_msg(const struct va_format *message,
> +                           struct string_stream *stream)
>  {
>         if (message->fmt)
>                 string_stream_add(stream, "\n%pV", message);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
>
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               const struct va_format *message,
> @@ -89,7 +92,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit=
_assert *assert,
>  EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
>
>  /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
> -static bool is_literal(const char *text, long long value)
> +VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
>  {
>         char *buffer;
>         int len;
> @@ -110,6 +113,7 @@ static bool is_literal(const char *text, long long va=
lue)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(is_literal);
>
>  void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 const struct va_format *message,
> @@ -166,7 +170,7 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
>  /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
>   * Note: `text` will have ""s where as `value` will not.
>   */
> -static bool is_str_literal(const char *text, const char *value)
> +VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value=
)
>  {
>         int len;
>
> @@ -178,6 +182,7 @@ static bool is_str_literal(const char *text, const ch=
ar *value)
>
>         return strncmp(text + 1, value, len - 2) =3D=3D 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
>
>  void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
> @@ -208,10 +213,11 @@ EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
>  /* Adds a hexdump of a buffer to a string_stream comparing it with
>   * a second buffer. The different bytes are marked with <>.
>   */
> -static void kunit_assert_hexdump(struct string_stream *stream,
> -                                const void *buf,
> -                                const void *compared_buf,
> -                                const size_t len)
> +VISIBLE_IF_KUNIT
> +void kunit_assert_hexdump(struct string_stream *stream,
> +                         const void *buf,
> +                         const void *compared_buf,
> +                         const size_t len)
>  {
>         size_t i;
>         const u8 *buf1 =3D buf;
> @@ -229,6 +235,7 @@ static void kunit_assert_hexdump(struct string_stream=
 *stream,
>                         string_stream_add(stream, " %02x ", buf1[i]);
>         }
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
>
>  void kunit_mem_assert_format(const struct kunit_assert *assert,
>                              const struct va_format *message,
> @@ -269,4 +276,5 @@ void kunit_mem_assert_format(const struct kunit_asser=
t *assert,
>                 kunit_assert_print_msg(message, stream);
>         }
>  }
> +
>  EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> new file mode 100644
> index 000000000000..1347a964204b
> --- /dev/null
> +++ b/lib/kunit/assert_test.c
> @@ -0,0 +1,391 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * KUnit test for the assertion formatting functions.
> + * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
> + */
> +#include <kunit/test.h>
> +#include "string-stream.h"
> +
> +#define TEST_PTR_EXPECTED_BUF_SIZE 32
> +#define HEXDUMP_TEST_BUF_LEN 5
> +#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(=
test, strstr(str, substr))
> +#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALS=
E(test, strstr(str, substr))
> +
> +static void kunit_test_is_literal(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
> +       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
> +       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
> +       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
> +       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
> +       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
> +       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
> +       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
> +}
> +
> +static void kunit_test_is_str_literal(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hell=
o, World!"));
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba=
\""));
> +}
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> +
> +/* this function is used to get a "char *" string from the string stream=
 and defer its cleanup  */
> +static char *get_str_from_stream(struct kunit *test, struct string_strea=
m *stream)
> +{
> +       char *str =3D string_stream_get_string(stream);
> +

When trying to make the kernel with this test loaded in, I am getting
an error that string_stream_get_string, string_stream_clear, and
kunit_alloc_string_stream are undefined.

So either these three methods will have to be exported using
EXPORT_SYMBOL_KUNIT or this test cannot be loaded and run as a module.

But once this is fixed up this should be good to go.

> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> +       kunit_add_action(test, kfree_wrapper, (void *)str);
> +
> +       return str;
> +}
> +
> +static void kunit_test_assert_prologue(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       char *str;
> +       const struct kunit_loc location =3D {
> +               .file =3D "testfile.c",
> +               .line =3D 1337,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Test an expectation fail prologue */
> +       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
> +       str =3D get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> +
> +       /* Test an assertion fail prologue */
> +       string_stream_clear(stream);
> +       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
> +       str =3D get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> +}
> +
> +/*
> + * This function accepts an arbitrary count of parameters and generates =
a va_format struct,
> + * which can be used to validate kunit_assert_print_msg function
> + */
> +static void verify_assert_print_msg(struct kunit *test,
> +                                   struct string_stream *stream,
> +                                   char *expected, const char *format, .=
..)
> +{
> +       va_list list;
> +       const struct va_format vformat =3D {
> +               .fmt =3D format,
> +               .va =3D &list,
> +       };
> +
> +       va_start(list, format);
> +       string_stream_clear(stream);
> +       kunit_assert_print_msg(&vformat, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expec=
ted);
> +}
> +
> +static void kunit_test_assert_print_msg(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       verify_assert_print_msg(test, stream, "\nTest", "Test");
> +       verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %=
d %u",
> +                               "Abacaba", -123, 234U);
> +       verify_assert_print_msg(test, stream, "", NULL);
> +}
> +
> +/*
> + * Further code contains the tests for different assert format functions=
.
> + * This helper function accepts the assert format function, executes it =
and
> + * validates the result string from the stream by checking that all of t=
he
> + * substrings exist in the output.
> + */
> +static void validate_assert(assert_format_t format_func, struct kunit *t=
est,
> +                           const struct kunit_assert *assert,
> +                           struct string_stream *stream, int num_checks,=
 ...)
> +{
> +       size_t i;
> +       va_list checks;
> +       char *cur_substr_exp;
> +       struct va_format message =3D { NULL, NULL };
> +
> +       va_start(checks, num_checks);
> +       string_stream_clear(stream);
> +       format_func(assert, &message, stream);
> +
> +       for (i =3D 0; i < num_checks; i++) {
> +               cur_substr_exp =3D va_arg(checks, char *);
> +               ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test=
, stream), cur_substr_exp);
> +       }
> +}
> +
> +static void kunit_test_unary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_unary_assert un_assert =3D {
> +               .assert =3D assert,
> +               .condition =3D "expr",
> +               .expected_true =3D true,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> +                       stream, 2, "true", "is false");
> +
> +       un_assert.expected_true =3D false;
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> +                       stream, 2, "false", "is true");
> +}
> +
> +static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_ptr_not_err_assert not_err_assert =3D {
> +               .assert =3D assert,
> +               .text =3D "expr",
> +               .value =3D NULL,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Value is NULL. The corresponding message should be printed out=
 */
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert,
> +                       stream, 1, "null");
> +
> +       /* Value is not NULL, but looks like an error pointer. Error shou=
ld be printed out */
> +       not_err_assert.value =3D (void *)-12;
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert, stream, 2,
> +                       "error", "-12");
> +}
> +
> +static void kunit_test_binary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "1 + 2",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "2",
> +       };
> +       const struct kunit_binary_assert binary_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D 3,
> +               .right_value =3D 2,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * Printed values should depend on the input we provide: the left=
 text, right text, left
> +        * value and the right value.
> +        */
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 4, "1 + 2", "2", "3", "=3D=3D");
> +
> +       text.right_text =3D "4 - 2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 3, "=3D=3D", "1 + 2", "4 - 2");
> +
> +       text.left_text =3D "3";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 4, "3", "4 - 2", "2", "=3D=3D");
> +
> +       text.right_text =3D "2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 3, "3", "2", "=3D=3D");
> +}
> +
> +static void kunit_test_binary_ptr_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       char *addr_var_a, *addr_var_b;
> +       static const void *var_a =3D (void *)0xDEADBEEF;
> +       static const void *var_b =3D (void *)0xBADDCAFE;
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "var_a",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "var_b",
> +       };
> +       struct kunit_binary_ptr_assert binary_ptr_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D var_a,
> +               .right_value =3D var_b,
> +       };
> +
> +       addr_var_a =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GF=
P_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
> +       addr_var_b =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GF=
P_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
> +       /*
> +        * Print the addresses to the buffers first.
> +        * This is necessary as we may have different count of leading ze=
ros in the pointer
> +        * on different architectures.
> +        */
> +       snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
> +       snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr=
_assert.assert,
> +                       stream, 3, addr_var_a, addr_var_b, "=3D=3D");
> +}
> +
> +static void kunit_test_binary_str_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       static const char *var_a =3D "abacaba";
> +       static const char *var_b =3D "kernel";
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "var_a",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "var_b",
> +       };
> +       struct kunit_binary_str_assert binary_str_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D var_a,
> +               .right_value =3D var_b,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_binary_str_assert_format, test,
> +                       &binary_str_assert.assert,
> +                       stream, 5, "var_a", "var_b", "\"abacaba\"",
> +                       "\"kernel\"", "=3D=3D");
> +
> +       text.left_text =3D "\"abacaba\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> +                       stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", =
"=3D=3D");
> +
> +       text.right_text =3D "\"kernel\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> +                       stream, 3, "\"abacaba\"", "\"kernel\"", "=3D=3D")=
;
> +}
> +
> +static const u8 hex_testbuf1[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0xd6, 0x47,
> +                                  0x2,  0x89, 0x8c, 0x81, 0x94,
> +                                  0x12, 0xfe, 0x01 };
> +static const u8 hex_testbuf2[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0x21, 0x47,
> +                                  0xcd, 0x89, 0x24, 0x50, 0x94,
> +                                  0x12, 0xba, 0x01 };
> +static void kunit_test_assert_hexdump(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       char *str;
> +       size_t i;
> +       char buf[HEXDUMP_TEST_BUF_LEN];
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       /* Check that we are getting output like <xx> for non-matching nu=
mbers. */
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(h=
ex_testbuf1));
> +       str =3D get_str_from_stream(test, stream);
> +       for (i =3D 0; i < sizeof(hex_testbuf1); i++) {
> +               snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf=
1[i]);
> +               if (hex_testbuf1[i] !=3D hex_testbuf2[i])
> +                       ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
> +       }
> +       /* We shouldn't get any <xx> numbers when comparing the buffer wi=
th itself. */
> +       string_stream_clear(stream);
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(h=
ex_testbuf1));
> +       str =3D get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
> +       ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
> +}
> +
> +static void kunit_test_mem_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct string_stream *expected_stream;
> +       struct kunit_assert assert =3D {};
> +       static const struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "hex_testbuf1",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "hex_testbuf2",
> +       };
> +       struct kunit_mem_assert mem_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D NULL,
> +               .right_value =3D hex_testbuf2,
> +               .size =3D sizeof(hex_testbuf1),
> +       };
> +
> +       expected_stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* The left value is NULL */
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       stream, 2, "hex_testbuf1", "is not null");
> +
> +       /* The right value is NULL, the left value is not NULL */
> +       mem_assert.left_value =3D hex_testbuf1;
> +       mem_assert.right_value =3D NULL;
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       stream, 2, "hex_testbuf2", "is not null");
> +
> +       /* Both arguments are not null */
> +       mem_assert.left_value =3D hex_testbuf1;
> +       mem_assert.right_value =3D hex_testbuf2;
> +
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       stream, 3, "hex_testbuf1", "hex_testbuf2", "=3D=
=3D");
> +}
> +
> +static struct kunit_case assert_test_cases[] =3D {
> +       KUNIT_CASE(kunit_test_is_literal),
> +       KUNIT_CASE(kunit_test_is_str_literal),
> +       KUNIT_CASE(kunit_test_assert_prologue),
> +       KUNIT_CASE(kunit_test_assert_print_msg),
> +       KUNIT_CASE(kunit_test_unary_assert_format),
> +       KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
> +       KUNIT_CASE(kunit_test_binary_assert_format),
> +       KUNIT_CASE(kunit_test_binary_ptr_assert_format),
> +       KUNIT_CASE(kunit_test_binary_str_assert_format),
> +       KUNIT_CASE(kunit_test_assert_hexdump),
> +       KUNIT_CASE(kunit_test_mem_assert_format),
> +       {}
> +};
> +
> +static struct kunit_suite assert_test_suite =3D {
> +       .name =3D "kunit-assert",
> +       .test_cases =3D assert_test_cases,
> +};
> +
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +kunit_test_suites(&assert_test_suite);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Test for the KUnit assertion format functions.");
> --
> 2.34.1
>

