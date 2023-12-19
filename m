Return-Path: <linux-kselftest+bounces-2246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6031281946E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 00:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B929B25318
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADED3D0B6;
	Tue, 19 Dec 2023 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzsTN0Z6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79240BE3
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so6775e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703027761; x=1703632561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kahqyf6EB8HB0c0Ey1lJeYZwJGl+WMUYDsC/ZwyeTQc=;
        b=UzsTN0Z6D+M/liSrurBeqyj8Ypt5Uf7FrEZhFlS0KD8KM6j8gmpuajcaraxiWEnofp
         JKD6CKUeEzinEI4nRF0T/0xFlyH64xu971wVzMWG7vlBf8wNmAH7RGoczW2P+Mc9q9VV
         yQp7dINUWME9Z28g2wB9sY/cCbZhA7VNTU+g39myD9evTpk7WjuhCTi5ToNrORsgdUlq
         vxU/SFFwHXCPUTtdoZ9rKLKV2DaEpJlQ4JlCVYmgQWtogP5nRHVZo2/4yvQH0e+HXHlV
         7QgCbAso3uFWa9tkB9Xl3FomvlNm+e8LalL5yJAi6/cpcJInYcrwqKPLh4oVpReR682h
         AH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703027761; x=1703632561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kahqyf6EB8HB0c0Ey1lJeYZwJGl+WMUYDsC/ZwyeTQc=;
        b=uMxaBdi13m1vyUBV4aedHbCnPJya3HCc0ycNNuEZmVngMVd1T4v+DzZociZ4ULT+4k
         fEQwWeVOxt6cZ5S2E4WakzJat/sGGTZmtGmSi/bqO1JhzaaAqFnQZRjQLSxCHT146U7s
         e8LYrGrX4u6QRffXR7SramdhzXIydJ5jW5PWgw5nEwRRO5ASoLOrW22RZ7HxLiFvD56W
         a+0FIUJ3tNgvHfXJnWRJ4dvbzbGPq64lH1hJuORA7Ci6xhVQ7nDpeQnYcYqNzvAaOALe
         +orXP2zXySeWewTFrWXlNOBe3Oyq+K1/sx3MK9fdVpzNSi9dTvqgOo3W7kY5zO1ApR/2
         a9QA==
X-Gm-Message-State: AOJu0YzLqBYc8MJbxNV7bxQx/eIu//kkZYQu/V0O+chDgvmbrp+im0cv
	hoippp8gMbP1tYH1jZ2JSsuz8PQ2ZMOQ3NbEVJzm8hJfHQdi
X-Google-Smtp-Source: AGHT+IF6MI1wVycgHpzsT64FxzIlg02O0Ehd0poLvCBSUiKTOrBvGUK468ckS6AkENtIKk0QfEwLl3Wda81ZivTeuvI=
X-Received: by 2002:a1c:4b19:0:b0:40d:174c:9295 with SMTP id
 y25-20020a1c4b19000000b0040d174c9295mr29772wma.3.1703027760939; Tue, 19 Dec
 2023 15:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218161044.215640-1-rf@opensource.cirrus.com> <20231218161044.215640-2-rf@opensource.cirrus.com>
In-Reply-To: <20231218161044.215640-2-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 19 Dec 2023 18:15:48 -0500
Message-ID: <CA+GJov7jyn461d-wyTMr=kN5TyFP=muox75rtj4M3kYeu4=JfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Add example of kunit_activate_static_stub()
 with pointer-to-function
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:10=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Adds a variant of example_static_stub_test() that shows use of a
> pointer-to-function with kunit_activate_static_stub().
>
> A const pointer to the add_one() function is declared. This
> pointer-to-function is passed to kunit_activate_static_stub() and
> kunit_deactivate_static_stub() instead of passing add_one directly.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

This test looks good to me. However, I had issues applying this patch
so I think it needs rebasing due to the newest additions to
kselftest/kunit. But otherwise this patch looks good other than my
very small comment below.

Thanks!
-Rae

> ---
>  lib/kunit/kunit-example-test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index d2f7a3c62c18..9e57f341dc37 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -168,6 +168,8 @@ static int subtract_one(int i)
>         return i - 1;
>  }
>
> +static int (* const add_one_fn_ptr)(int i) =3D add_one;

This is a bit of a nit but could you add a brief comment above this
pointer definition? This would then match the commenting on the other
functions in kunit-example-test and provide more context for those
looking at the example tests.

> +
>  /*
>   * This test shows the use of static stubs.
>   */
> @@ -187,6 +189,30 @@ static void example_static_stub_test(struct kunit *t=
est)
>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
>  }
>
> +/*
> + * This test shows the use of static stubs when the function being
> + * replaced is provided as a pointer-to-function instead of the
> + * actual function. This is useful for providing access to static
> + * functions in a module by exporting a pointer to that function
> + * instead of having to change the static function to a non-static
> + * exported function.
> + */
> +static void example_static_stub_using_fn_ptr_test(struct kunit *test)
> +{
> +       /* By default, function is not stubbed. */
> +       KUNIT_EXPECT_EQ(test, add_one(1), 2);
> +
> +       /* Replace add_one() with subtract_one(). */
> +       kunit_activate_static_stub(test, add_one_fn_ptr, subtract_one);
> +
> +       /* add_one() is now replaced. */
> +       KUNIT_EXPECT_EQ(test, add_one(1), 0);
> +
> +       /* Return add_one() to normal. */
> +       kunit_deactivate_static_stub(test, add_one_fn_ptr);
> +       KUNIT_EXPECT_EQ(test, add_one(1), 2);
> +}
> +
>  static const struct example_param {
>         int value;
>  } example_params_array[] =3D {
> @@ -245,6 +271,7 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_mark_skipped_test),
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
> +       KUNIT_CASE(example_static_stub_using_fn_ptr_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
> --
> 2.30.2
>

