Return-Path: <linux-kselftest+bounces-18810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB2798C6EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3042834CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002711CC16E;
	Tue,  1 Oct 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7Y8tKT0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356F1BDAA1
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815537; cv=none; b=uvkdoO+W8xnmgaDGr1btVTrQdfE5s9CNaAhZUCY+dIUwaf8T/8/oL5vtgPTU9b5h8zZptY2dNeIv9kehfYamg+NPvwYkrAcn3xNAGzyY0wbvv3cMXCTNfhAAUCeQevBDhMUwHZ6Lxo6bRzV7Xhm6qUcDaEaP3OjX7PgI0b1JIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815537; c=relaxed/simple;
	bh=DaqMDhmshEvOQb4gtdQ4Kfh/R5qL4VEkACPkPtm7qE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+z7U4T/XG8I8flp6/Sl4EriSMq8S1101zak3x4PC5xpx+SE0gjn3xvUKCYzYRnx2TI+BXZysAWIMtzTY2GdcX3FEWPr8N5ioICmcdfzOHa7W42hUlG93/4+I+eXhgmHxc2WoEB7GWM7LUUjtXtPSAmCz05LXfILhBm/Lxlzj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7Y8tKT0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3719606a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727815534; x=1728420334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwRPTaek/XbuOrAV9d5wlcYD2rQwfIa97ZrMdTl+H5A=;
        b=x7Y8tKT0CV9d55ySVx1Tf+bh095FYHQRdNYt+tzYUY5kZbsr+8fxyM8yJanQuHFVK7
         OTuNGTCVLkxRr41Rv0tCZt//T4YoXI7BmlPbPcbhgJ91q15/0px36Oc27ycVQy6/j0Un
         oKwbUcze9/ZsnBwofaHDBomCfIZQAsZ8lkMc5wmPg+0xYTuQai6nsR/jG+6myf5EZg+d
         SYSGY6/p1ckxERkRrQmT2wfzMDtFTNxxjxmONnI9eWEsvy/QX48JtmcRTSrpTYW7RCpw
         zX75l9DMGKw3HJqCMwqtpLpZiCF+sp4+tlHwIxzPvLUZXyuOzSc1U4UlTOvsgO/Uuc8I
         nK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727815534; x=1728420334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwRPTaek/XbuOrAV9d5wlcYD2rQwfIa97ZrMdTl+H5A=;
        b=E8bDCjtcUPqTA8Gt+UckF+lBf6tlfLctuSSllWu6u2Dit3eXFiwFIrvvz4uC3diHec
         ZqMCb4vdKClo7WWqX9kS7E4RsGKL1gGV5ZJWPADBHlMXpK8tSmYm1gU/bcYR3vS4Odg6
         OPfy1qn5QuAnCjf40Ko8vUxgSokXSnJvly5dkL1/1f5Agr7x1QiA0A9w0mQgfgGKFxQA
         Sg+zuIAe07lCTVup7KZNAog9xgpCvd8WozrflRbB8uZLrbdloJ1F04XBPSPTD3bwAwLC
         wN13p5yxiAkN5YiyX51KWYmPKJapUFyUUVMLbfINTV7FcOFvP3ULlzk47Fc3ylYBInK7
         wnsw==
X-Forwarded-Encrypted: i=1; AJvYcCUYLVpQksNp1uiw0jsyahqRLp+1stn8/+Xftb+zmnDYl5UEOK/qSECoZFlnS7qj2JcN2pRkrIK/zPf7EtmGcc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiuYNY3BN2ARDy5B0W3t3A2nUjFJqwhaBiYsMYqAlppmtMCPG
	zGrmrzZ9w/eCJyJtIlS2BqJ7vaBhvamRoO6Xp6mlQ/we4x2cNs3AcLBqSvgpa+jH6EkOe2KK2rS
	W1GNdNoBtcqjlpnekSALrBbPxmVl8fHvbhL80BK5SQndVzQ9ImgCk
X-Google-Smtp-Source: AGHT+IERMCTnuPs3A//WrLBVDWuqb068fOvoImiiBkDsU/pcCdXt5NQgcnmcLfSb/4rp4XE/xZ6CRswZx9bRizO36OU=
X-Received: by 2002:a05:6a21:3a83:b0:1d3:5202:f9a8 with SMTP id
 adf61e73a8af0-1d5db20c0a2mr1572424637.15.1727815534101; Tue, 01 Oct 2024
 13:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903213649.21467-1-diego.daniel.professional@gmail.com> <20240903213649.21467-2-diego.daniel.professional@gmail.com>
In-Reply-To: <20240903213649.21467-2-diego.daniel.professional@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 1 Oct 2024 16:45:21 -0400
Message-ID: <CA+GJov6MHEx=4GH0RDHqrnWL+1whYo+PJDuk8v-Dur8Z5OLuaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lib/tests/kfifo_kunit.c: add tests for the kfifo structure
To: Diego Vieira <diego.daniel.professional@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, n@nfraprado.net, 
	andrealmeid@riseup.net, vinicius@nukelet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:38=E2=80=AFPM Diego Vieira
<diego.daniel.professional@gmail.com> wrote:
>
> Add KUnit tests for the kfifo data structure.
> They test the vast majority of macros defined in the kfifo
> header (include/linux/kfifo.h).
>
> These are inspired by the existing tests for the doubly
> linked list in lib/tests/list-test.c (previously at lib/list-test.c) [1].
>
> Note that this patch depends on the patch that moves the KUnit tests on
> lib/ into lib/tests/ [2].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/lib/list-test.c?h=3Dv6.11-rc6
> [2] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>
> Signed-off-by: Diego Vieira <diego.daniel.professional@gmail.com>

Hello!

Thanks for creating this test suite! The suite is looking good and
passing the tests! Sorry for the delay in reviewing this. We have been
a bit busy due to LPC.

I have some comments, see below.

Thanks again!
-Rae

> ---
>  lib/Kconfig.debug       |  14 +++
>  lib/tests/Makefile      |   1 +
>  lib/tests/kfifo_kunit.c | 224 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 lib/tests/kfifo_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..d7a4b996d731 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2646,6 +2646,20 @@ config SYSCTL_KUNIT_TEST
>
>           If unsure, say N.
>
> +config KFIFO_KUNIT_TEST
> +       tristate "KUnit Test for the generic kernel FIFO implementation" =
if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the generic FIFO implementation KUnit test suite.
> +         It tests that the API and basic functionality of the kfifo type
> +         and associated macros.
> +
> +         For more information on KUnit and unit tests in general please =
refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config LIST_KUNIT_TEST
>         tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT=
_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index c6a14cc8663e..42699c7ee638 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_TEST_IOV_ITER) +=3D kunit_iov_iter.o
>  obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) +=3D is_signed_type_kunit.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) +=3D test_kprobes.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
> +obj-$(CONFIG_KFIFO_KUNIT_TEST) +=3D kfifo_kunit.o
>  obj-$(CONFIG_TEST_LIST_SORT) +=3D test_list_sort.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) +=3D test_linear_ranges.o
>  obj-$(CONFIG_MEMCPY_KUNIT_TEST) +=3D memcpy_kunit.o
> diff --git a/lib/tests/kfifo_kunit.c b/lib/tests/kfifo_kunit.c
> new file mode 100644
> index 000000000000..a85eedc3195a
> --- /dev/null
> +++ b/lib/tests/kfifo_kunit.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the generic kernel FIFO implementation.
> + *
> + * Copyright (C) 2024 Diego Vieira <diego.daniel.professional@gmail.com>
> + */
> +#include <kunit/test.h>
> +
> +#include <linux/kfifo.h>
> +
> +#define KFIFO_SIZE 32

I would prefer if we test on at least one other size of kfifo struct
if possible.

> +#define N_ELEMENTS 5
> +
> +static void kfifo_test_reset_should_clear_the_fifo(struct kunit *test)
> +{
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       kfifo_put(&my_fifo, 1);
> +       kfifo_put(&my_fifo, 2);
> +       kfifo_put(&my_fifo, 3);
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +
> +       kfifo_reset(&my_fifo);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
> +       KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
> +}
> +
> +static void kfifo_test_define_should_define_an_empty_fifo(struct kunit *=
test)

So an overall comment I have is that I notice you are testing specific
situations. Above it is: "define should define an empty fifo".
However, for API test suites like this we tend to structure test cases
by method or groups of methods. So for example, one case testing the
kfifo_peek method and one case testing the initialization functions. I
think I would recommend that for your test suite because it helps to
ensure every method is being checked for correctness and I think it
would help shorten some of the more verbose test case names. As an
example for these API test suites, I recommend looking at the KUnit
list or hashtable test suites.

So this case would become kfifo_test_define and would test the
definitions and declarations of the kfifo struct. So you could combine
it with what you test in
kfifo_test_dec_init_should_define_an_empty_fifo and
kfifo_test_define_should_equal_declare_init.  Or for a second example,
the case above would become kfifo_test_reset.

Finally, I would also recommend bringing the tests for
definitions/initilizations to the top of the test suite. I recommend
building from the basics and working up from there (if a complex test
crashes the kernel before simple tests are run you may never see that
the basic test case failed, pointing you to the problem).

I realize this comment requires some reworking and moving around
however, many of your methods are already somewhat structured around a
method. And then I would just recommend thinking through any edge
cases needed to test for each method.

> +{
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
> +       KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
> +}
> +
> +static void kfifo_test_len_should_ret_n_of_stored_elements(struct kunit =
*test)

This could be kfifo_test_len.

> +{
> +       u8 buffer1[N_ELEMENTS];
> +
> +       for (int i =3D 0; i < N_ELEMENTS; i++)
> +               buffer1[i] =3D i + 1;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
> +
> +       kfifo_in(&my_fifo, buffer1, N_ELEMENTS);
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), N_ELEMENTS);
> +
> +       kfifo_in(&my_fifo, buffer1, N_ELEMENTS);
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), N_ELEMENTS * 2);
> +
> +       kfifo_reset(&my_fifo);
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
> +}
> +
> +static void kfifo_test_put_should_insert_and_get_should_pop(struct kunit=
 *test)

This could be split into two test cases for put and get or together as
kfifo_test_put_get.

> +{
> +       u8 out_data =3D 0;
> +       int processed_elements;
> +       u8 elements[] =3D { 3, 5, 11 };
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       // If the fifo is empty, get returns 0
> +       processed_elements =3D kfifo_get(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 0);
> +       KUNIT_EXPECT_EQ(test, out_data, 0);
> +
> +       for (int i =3D 0; i < 3; i++)
> +               kfifo_put(&my_fifo, elements[i]);
> +
> +       for (int i =3D 0; i < 3; i++) {
> +               processed_elements =3D kfifo_get(&my_fifo, &out_data);
> +               KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +               KUNIT_EXPECT_EQ(test, out_data, elements[i]);
> +       }
> +}
> +
> +static void kfifo_test_in_should_insert_multiple_elements(struct kunit *=
test)

This could become kfifo_test_in.

> +{
> +       u8 in_buffer[] =3D { 11, 25, 65 };
> +       u8 out_data;
> +       int processed_elements;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       kfifo_in(&my_fifo, in_buffer, 3);
> +
> +       for (int i =3D 0; i < 3; i++) {
> +               processed_elements =3D kfifo_get(&my_fifo, &out_data);
> +               KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +               KUNIT_EXPECT_EQ(test, out_data, in_buffer[i]);
> +       }
> +}
> +
> +static void kfifo_test_out_should_pop_multiple_elements(struct kunit *te=
st)

This could become kfifo_test_out.

> +{
> +       u8 in_buffer[] =3D { 11, 25, 65 };
> +       u8 out_buffer[3];
> +       int copied_elements;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       for (int i =3D 0; i < 3; i++)
> +               kfifo_put(&my_fifo, in_buffer[i]);
> +
> +       copied_elements =3D kfifo_out(&my_fifo, out_buffer, 3);
> +       KUNIT_EXPECT_EQ(test, copied_elements, 3);
> +
> +       for (int i =3D 0; i < 3; i++)
> +               KUNIT_EXPECT_EQ(test, out_buffer[i], in_buffer[i]);
> +       KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
> +}
> +
> +static void kfifo_test_dec_init_should_define_an_empty_fifo(struct kunit=
 *test)
> +{
> +       DECLARE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       INIT_KFIFO(my_fifo);
> +
> +       // my_fifo is a struct with an inplace buffer
> +       KUNIT_EXPECT_FALSE(test, __is_kfifo_ptr(&my_fifo));
> +
> +       KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
> +}
> +
> +static void kfifo_test_define_should_equal_declare_init(struct kunit *te=
st)
> +{
> +       // declare a variable my_fifo of type struct kfifo of u8
> +       DECLARE_KFIFO(my_fifo1, u8, KFIFO_SIZE);
> +       // initialize the my_fifo variable
> +       INIT_KFIFO(my_fifo1);
> +
> +       // DEFINE_KFIFO declares the variable with the initial value
> +       // essentially the same as calling DECLARE_KFIFO and INIT_KFIFO
> +       DEFINE_KFIFO(my_fifo2, u8, KFIFO_SIZE);
> +
> +       // my_fifo1 and my_fifo2 have the same size
> +       KUNIT_EXPECT_EQ(test, sizeof(my_fifo1), sizeof(my_fifo2));
> +       KUNIT_EXPECT_EQ(test, kfifo_initialized(&my_fifo1),
> +                       kfifo_initialized(&my_fifo2));
> +       KUNIT_EXPECT_EQ(test, kfifo_is_empty(&my_fifo1),
> +                       kfifo_is_empty(&my_fifo2));
> +}
> +
> +static void kfifo_test_alloc_should_initiliaze_a_ptr_fifo(struct kunit *=
test)

This could become kfifo_test_alloc or kfifo_test_declare_ptr.

> +{
> +       int ret;
> +       DECLARE_KFIFO_PTR(my_fifo, u8);
> +
> +       INIT_KFIFO(my_fifo);
> +
> +       // kfifo_initialized returns false signaling the buffer pointer i=
s NULL
> +       KUNIT_EXPECT_FALSE(test, kfifo_initialized(&my_fifo));
> +
> +       // kfifo_alloc allocates the buffer
> +       ret =3D kfifo_alloc(&my_fifo, KFIFO_SIZE, GFP_KERNEL);
> +       KUNIT_EXPECT_EQ_MSG(test, ret, 0, "Memory allocation should succe=
ed");
> +       KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
> +
> +       // kfifo_free frees the buffer
> +       kfifo_free(&my_fifo);
> +}
> +
> +static void kfifo_test_peek_should_not_remove_elements(struct kunit *tes=
t)

So this could become kfifo_test_peek.

> +{
> +       u8 out_data;
> +       int processed_elements;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       // If the fifo is empty, peek returns 0
> +       processed_elements =3D kfifo_peek(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 0);
> +
> +       kfifo_put(&my_fifo, 3);
> +       kfifo_put(&my_fifo, 5);
> +       kfifo_put(&my_fifo, 11);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +
> +       processed_elements =3D kfifo_peek(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +       KUNIT_EXPECT_EQ(test, out_data, 3);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +
> +       // Using peek doesn't remove the element
> +       // so the read element and the fifo length
> +       // remains the same
> +       processed_elements =3D kfifo_peek(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +       KUNIT_EXPECT_EQ(test, out_data, 3);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +}
> +
> +static struct kunit_case kfifo_test_cases[] =3D {
> +       KUNIT_CASE(kfifo_test_reset_should_clear_the_fifo),
> +       KUNIT_CASE(kfifo_test_define_should_define_an_empty_fifo),
> +       KUNIT_CASE(kfifo_test_len_should_ret_n_of_stored_elements),
> +       KUNIT_CASE(kfifo_test_put_should_insert_and_get_should_pop),
> +       KUNIT_CASE(kfifo_test_in_should_insert_multiple_elements),
> +       KUNIT_CASE(kfifo_test_out_should_pop_multiple_elements),
> +       KUNIT_CASE(kfifo_test_dec_init_should_define_an_empty_fifo),
> +       KUNIT_CASE(kfifo_test_define_should_equal_declare_init),
> +       KUNIT_CASE(kfifo_test_alloc_should_initiliaze_a_ptr_fifo),
> +       KUNIT_CASE(kfifo_test_peek_should_not_remove_elements),

Just a final comment here: I notice that you are missing some of the
methods from the API. I would love it if you could include a case on
the size methods (kfifo_size, esize, recsize), the other length
methods (kfifo_avail, kfifo_is_full), kfifo_skip, kfifo_peek_len, and
kfifo_out_peek.

> +       {},
> +};
> +
> +static struct kunit_suite kfifo_test_module =3D {
> +       .name =3D "kfifo",
> +       .test_cases =3D kfifo_test_cases,
> +};
> +
> +kunit_test_suites(&kfifo_test_module);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Diego Vieira <diego.daniel.professional@gmail.com>");
> +MODULE_DESCRIPTION("KUnit test for the kernel FIFO");
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240903213649.21467-2-diego.daniel.professional%40gmail.com.

