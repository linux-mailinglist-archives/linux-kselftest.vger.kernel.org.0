Return-Path: <linux-kselftest+bounces-19518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D822C999DBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A558B21687
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452BC209F2D;
	Fri, 11 Oct 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb9v3+h/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B659209686
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631352; cv=none; b=tadGYR4UWPL2BQjYHl8OggMunPhGEYw/ZYkrQvKr3TFl8XLBHf3wjiPm7vc5BP+H5Bf+N/LU1a4XOQeNzK7AcaqlXMRT/+5ngfDcx2vvAKYIOMVHUlvknegnJu6vMinyvtPuHhz/YABvatvsRZrPyvw7lZbMTAsNdNioavQy94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631352; c=relaxed/simple;
	bh=jhFxU473ZK0WZD9wF2BZbxosBpIT2u70sOo72vmNbKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZCTlxKHQKS9mOIl7Ars7eG6jHD+Nd6IyqIEqfUPPQu93L+ZLCHZO8J4rzeIp+9DsTivJaWi5I7v/9g1I0uBJDXJArnR/0GcCqLv9m4+HSgmqAyX5IZVzezbGldp5k2PwJjPVzRS7+o7W1NdOhM7p8bWYOYe74uZtUsmvlWZrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rb9v3+h/; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so11082666d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631348; x=1729236148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOF6dFsSCfShH5Gj8tlt0flTKVRLkevdJNPOguTUsKE=;
        b=Rb9v3+h/mUn5p/ZHu+oer7/6Qwx0gXJXKdRuN3oFon+5Kp1q7onQpyqhLypmh3eicw
         eWVCDmUVxqa+ZjhfT3y+xe13/xzKpqQuIVeq7U70Q83U2QCfNclbELlJeXh6mTXfnr6S
         Ksc/7DDMmAa+W4afm/RC8HjC+C5Fj1ECcoPX4JcVpa+tfCzEcO9BefPp2tvpBHvRsOGY
         ENhYb8Z6PwJD3DyQfTB0rP3Apu742As3sOGqWveGKJvH+IcIQyEaVZgmrQhPc64UDf6E
         x7Med8wQT7wvFioLnc9SlO+20rpUO3p3wapw8U3f1sxv4+9U7XgqQSF/bTi47qFho1qh
         XBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631348; x=1729236148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOF6dFsSCfShH5Gj8tlt0flTKVRLkevdJNPOguTUsKE=;
        b=Z+7Ex2Cpkju6aUO+r9v0d498HXG2FcydA+wXdye4WDjKqu27SJ4yMRIdLYshg9M/Yx
         WW+jatfMzJeadU30ut1sdo4cFoVtU05Wig3ZDHYmcA6KAyosYbCJuxdeXmukD9383HKR
         ATnBXX+cHb+tPhAHYFRFqZL17xxiDjiucCVNIGm8SM1krUtdDUYKIiT7FDTc3d9I020a
         dslJAbHUPeVlxuHhcTGbi2sgtEBNy+XFixujbY1wIKVNDtTY2MtbJMXxam6dbcIRmkEU
         +K5uoQFfakwL95vFeOimDEpZXm3xy35DZDG+xRKXTI4bddOJxBjP5CmUO/hu0gcEuUGh
         fUsw==
X-Forwarded-Encrypted: i=1; AJvYcCXYOQswzPDJ5pOuJ2JCFo9anuwRMKXO2u43vYQ23wr1BIFNGHcuZvPmcio+LBxh7yAh4IdqbFySuE4DAccWKIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANFivg204cmt7ZjqtbiRhSxT+cF3ZSbG6Mk9kkSOE/Ss59dVp
	RtiD4cSXtl9O2p5X5WrY1Y42l3v6VUOMsJkeNMrlYqoY7sWhLNFyEY1rMJMtM9WQHIneZIN+G4T
	OIf+NFbdglrm7yXwUYs7FLDwjzWtm0xB0tG/l
X-Google-Smtp-Source: AGHT+IHaXNAM5Zh45iuJmW+Oy8/+JI+xoc/Aj4tD5E9rg5hIBheTogTjToOF9g8cIqeHZy8yzoi6i24BGpyt7eYbwaE=
X-Received: by 2002:a05:6214:5f06:b0:6cb:82f9:ff1 with SMTP id
 6a1803df08f44-6cbefffe842mr24353926d6.7.1728631348035; Fri, 11 Oct 2024
 00:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903213649.21467-1-diego.daniel.professional@gmail.com> <20240903213649.21467-2-diego.daniel.professional@gmail.com>
In-Reply-To: <20240903213649.21467-2-diego.daniel.professional@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 11 Oct 2024 15:22:16 +0800
Message-ID: <CABVgOSksOO6EYJO7vwwZ0d9F7eOMJNpm6mw1Jbs1tWKybC71fQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lib/tests/kfifo_kunit.c: add tests for the kfifo structure
To: Diego Vieira <diego.daniel.professional@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, n@nfraprado.net, 
	andrealmeid@riseup.net, vinicius@nukelet.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007c4a1c06242e59dd"

--0000000000007c4a1c06242e59dd
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 05:38, Diego Vieira
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
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c?h=v6.11-rc6
> [2] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>
> Signed-off-by: Diego Vieira <diego.daniel.professional@gmail.com>
> ---

Hi Diego,

Sorry for the delay: as you surmised, things have been very busy.

I think this patch is pretty good as-is, though (as Rae notes) there
are some places it could be improved and/or extended. It's
nevertheless worth having even in its current state, IMO, so this is:

Reviewed-by: David Gow <davidgow@google.com>

I'd like to accept it as-is for now, though, as I'm collating and
rebasing patches for lib/ tests which depend on the renaming to get
added to mm-nonmm-unstable (so we can avoid merge conflicts). If you
want to add extra test cases (or rearrange them within the file),
those may be best suited as a follow-up patch.

Thanks,
-- David




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
> +       tristate "KUnit Test for the generic kernel FIFO implementation" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the generic FIFO implementation KUnit test suite.
> +         It tests that the API and basic functionality of the kfifo type
> +         and associated macros.
> +
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config LIST_KUNIT_TEST
>         tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index c6a14cc8663e..42699c7ee638 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
>  obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
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
> +static void kfifo_test_define_should_define_an_empty_fifo(struct kunit *test)
> +{
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
> +       KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
> +}
> +
> +static void kfifo_test_len_should_ret_n_of_stored_elements(struct kunit *test)
> +{
> +       u8 buffer1[N_ELEMENTS];
> +
> +       for (int i = 0; i < N_ELEMENTS; i++)
> +               buffer1[i] = i + 1;
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
> +static void kfifo_test_put_should_insert_and_get_should_pop(struct kunit *test)
> +{
> +       u8 out_data = 0;
> +       int processed_elements;
> +       u8 elements[] = { 3, 5, 11 };
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       // If the fifo is empty, get returns 0
> +       processed_elements = kfifo_get(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 0);
> +       KUNIT_EXPECT_EQ(test, out_data, 0);
> +
> +       for (int i = 0; i < 3; i++)
> +               kfifo_put(&my_fifo, elements[i]);
> +
> +       for (int i = 0; i < 3; i++) {
> +               processed_elements = kfifo_get(&my_fifo, &out_data);
> +               KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +               KUNIT_EXPECT_EQ(test, out_data, elements[i]);
> +       }
> +}
> +
> +static void kfifo_test_in_should_insert_multiple_elements(struct kunit *test)
> +{
> +       u8 in_buffer[] = { 11, 25, 65 };
> +       u8 out_data;
> +       int processed_elements;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       kfifo_in(&my_fifo, in_buffer, 3);
> +
> +       for (int i = 0; i < 3; i++) {
> +               processed_elements = kfifo_get(&my_fifo, &out_data);
> +               KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +               KUNIT_EXPECT_EQ(test, out_data, in_buffer[i]);
> +       }
> +}
> +
> +static void kfifo_test_out_should_pop_multiple_elements(struct kunit *test)
> +{
> +       u8 in_buffer[] = { 11, 25, 65 };
> +       u8 out_buffer[3];
> +       int copied_elements;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       for (int i = 0; i < 3; i++)
> +               kfifo_put(&my_fifo, in_buffer[i]);
> +
> +       copied_elements = kfifo_out(&my_fifo, out_buffer, 3);
> +       KUNIT_EXPECT_EQ(test, copied_elements, 3);
> +
> +       for (int i = 0; i < 3; i++)
> +               KUNIT_EXPECT_EQ(test, out_buffer[i], in_buffer[i]);
> +       KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
> +}
> +
> +static void kfifo_test_dec_init_should_define_an_empty_fifo(struct kunit *test)
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
> +static void kfifo_test_define_should_equal_declare_init(struct kunit *test)
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
> +static void kfifo_test_alloc_should_initiliaze_a_ptr_fifo(struct kunit *test)
> +{
> +       int ret;
> +       DECLARE_KFIFO_PTR(my_fifo, u8);
> +
> +       INIT_KFIFO(my_fifo);
> +
> +       // kfifo_initialized returns false signaling the buffer pointer is NULL
> +       KUNIT_EXPECT_FALSE(test, kfifo_initialized(&my_fifo));
> +
> +       // kfifo_alloc allocates the buffer
> +       ret = kfifo_alloc(&my_fifo, KFIFO_SIZE, GFP_KERNEL);
> +       KUNIT_EXPECT_EQ_MSG(test, ret, 0, "Memory allocation should succeed");
> +       KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
> +
> +       // kfifo_free frees the buffer
> +       kfifo_free(&my_fifo);
> +}
> +
> +static void kfifo_test_peek_should_not_remove_elements(struct kunit *test)
> +{
> +       u8 out_data;
> +       int processed_elements;
> +
> +       DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
> +
> +       // If the fifo is empty, peek returns 0
> +       processed_elements = kfifo_peek(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 0);
> +
> +       kfifo_put(&my_fifo, 3);
> +       kfifo_put(&my_fifo, 5);
> +       kfifo_put(&my_fifo, 11);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +
> +       processed_elements = kfifo_peek(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +       KUNIT_EXPECT_EQ(test, out_data, 3);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +
> +       // Using peek doesn't remove the element
> +       // so the read element and the fifo length
> +       // remains the same
> +       processed_elements = kfifo_peek(&my_fifo, &out_data);
> +       KUNIT_EXPECT_EQ(test, processed_elements, 1);
> +       KUNIT_EXPECT_EQ(test, out_data, 3);
> +
> +       KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
> +}
> +
> +static struct kunit_case kfifo_test_cases[] = {
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
> +       {},
> +};
> +
> +static struct kunit_suite kfifo_test_module = {
> +       .name = "kfifo",
> +       .test_cases = kfifo_test_cases,
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
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240903213649.21467-2-diego.daniel.professional%40gmail.com.

--0000000000007c4a1c06242e59dd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgCRcn5CX+GwZx3zqRXx6ebNn+rrLf
Om/lqb02gcgA6ngwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDExMDcyMjI4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJu4HCyirdxHH14bZ7en5PBBfhdZqV7o8M/RyLlhYto6NJr9
x79DsCCuyJHiZ6435ARDs+P8UKPHoVyRNE/NjzMVrB4Zv+LyTDsC56YyN/iHnwIBSFuw4FI/1n5p
GySpT4RCdGPI2TW/ds9g5XMKqf3Nod5HgFB3PUGjUNJMQNWQyabcwWPi6yztwSaj30EWTfcORSSI
NMIZ2B58zgM1V4ixwuTokQMcSLTWrN3IYHMJGFA3pTP4Xr2uoe09rhJBSQF5Uss+3Wi4S1A8iXN4
k97/SjQcs1nbBOafgZT22B+JKSyTgphYW4bftbNXz0qB86LnNs0/nFwliKurH+pFhpc=
--0000000000007c4a1c06242e59dd--

