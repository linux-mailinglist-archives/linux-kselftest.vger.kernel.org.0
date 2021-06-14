Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8DE3A5D33
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jun 2021 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhFNGoL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Jun 2021 02:44:11 -0400
Received: from verein.lst.de ([213.95.11.211]:42971 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhFNGoK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Jun 2021 02:44:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AC2D67373; Mon, 14 Jun 2021 08:42:05 +0200 (CEST)
Date:   Mon, 14 Jun 2021 08:42:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
Subject: Re: [PATCH v3 1/1] lib: Convert UUID runtime test to KUnit
Message-ID: <20210614064205.GA29220@lst.de>
References: <20210610163959.71634-1-andrealmeid@collabora.com> <20210610163959.71634-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610163959.71634-2-andrealmeid@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +config UUID_KUNIT_TEST
> +	tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the UUID unit test.

Does this first help line really add any value if we have this second
line:

> +	  Tests parsing functions for UUID/GUID strings.

?

> +	  If unsure, say N.

Not specific to this case, but IMHO we can drop this line for all kunit
tests as it is completely obvious.

> @@ -354,5 +353,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> +obj-$(CONFIG_UUID_KUNIT_TEST) += test_uuid.o

Another meta-comment on the kunit tests:  Wouldn't it make more sense
to name them all as CONFIG_KUNIT_TEST_FOO to allow for easier grepping?

> -struct test_uuid_data {
> +struct test_data {
>  	const char *uuid;
>  	guid_t le;
>  	uuid_t be;
>  };
>  
> -static const struct test_uuid_data test_uuid_test_data[] = {
> +static const struct test_data correct_data[] = {

What is the reason for these renames?  Is this a pattern used for
other kunit tests?

> +static void uuid_correct_le(struct kunit *test)
>  {
> +	guid_t le;
> +	const struct test_data *data = (const struct test_data *)(test->param_value);

Overly long line.  But as far as I can tell there is no need for the
case that causes this mess anyway given that param_value is a
"const void *".

Same for all the other instances of this.

> +static void uuid_wrong_le(struct kunit *test)
>  {
>  	guid_t le;
> +	const char **data = (const char **)(test->param_value);

No need for the second pair of braces.  Same for various other instances.
