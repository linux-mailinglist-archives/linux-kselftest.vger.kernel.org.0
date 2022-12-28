Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA326571F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 03:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiL1CAd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 21:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiL1CAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 21:00:32 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8767B292
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 18:00:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so9785931pga.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 18:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb8jJPqAsZD3bkiqHrdaFakWJ3w1ushhBL+PrBwDuro=;
        b=Et9I8+HEhgQhnhgHIHWqEipxttx+lPZtqZ1ZZHCONiAst/ULmA73XUWQb+FJtNm6J3
         msTO8MI0Nzdrn6u3KRZ7XP6H+Mq24NyI3tdsQgpnWrq8i30M1O8HJooIQKSQAFV/w/AD
         GGY+dcM0CJvcQrFfFVBZLXaCBR4bWXq+Ox+vMBN/Feqolp4eKIsDDdlYJl94rc1oGaY5
         NkNtcJRdNzSabZHV4pf1GRhOS28+QDHVnXXEtZand5VmtUQsM3SETMhpY9euFTADHDxU
         QU2BYrLOgQM1QVGTp782y4ny7YAExdePylBIJYKBK8mkaUSt0izGnvMGCGQ3+k1yYUeI
         AxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb8jJPqAsZD3bkiqHrdaFakWJ3w1ushhBL+PrBwDuro=;
        b=4AHiR5bYh7TC6/hmm+FLCfzw7nuFHTJ3KW48I2sNijJ3uCcy/xL9W6CcMkuxVz2vum
         poEjRPOFM98Kmnl5JCKEQitVvCrs5GQmDbJx5w8aUb6/kAX5QaOt/Ed3DW3ezAzooKGz
         sxE8fjXYFacn9FsuZ6WPiE7d1MZVrMAH/hpTDt5kE+ZNknIaVYvhquT+WzE8dKoTBWNa
         wS8ka2f78EuWGgcCUr3sczXw6BcumgDcfrMyU+7yhawYFBWDtJjepH0TgYI+3K6Iaxwl
         vH9uejJQ5fv5L/FgxLKZc3/pkxAipzBaoYasuyW+gSY2f/tjE7EJ3vOMX8cfThZ1dUos
         bInQ==
X-Gm-Message-State: AFqh2kpqMqyqJ1icylpIb+Inm/ZGq0yxJTupER99b1+DxSqFKD9ekz2M
        6nB6DzBAupZ3awQkfM64W2CiO+6IO6qG7u2MIQm1NQ==
X-Google-Smtp-Source: AMrXdXsE51z3NvYJCtXjWgC8fIzxdAX8wWhz/lVKCERVTd6SU6/Jyhvn9zWXNd6LMS4K7H+jOB3KeRRqvX2I6lGCrxE=
X-Received: by 2002:a62:1c4d:0:b0:581:1898:93ae with SMTP id
 c74-20020a621c4d000000b00581189893aemr611997pfc.51.1672192829589; Tue, 27 Dec
 2022 18:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20221220031023.197178-1-rmoar@google.com>
In-Reply-To: <20221220031023.197178-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 27 Dec 2022 18:00:18 -0800
Message-ID: <CAGS_qxrp_oT7b_NNP4PfES06QAp-V4B4BAETFd3Wv9x-F8Zhrg@mail.gmail.com>
Subject: Re: [PATCH v1] lib/hashtable_test.c: add test for the hashtable structure
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 19, 2022 at 7:16 PM Rae Moar <rmoar@google.com> wrote:
>
> Add a KUnit test for the kernel hashtable implementation in
> include/linux/hashtable.h.
>
> Note that this version does not yet test each of the rcu
> alternative versions of functions.
>
> Signed-off-by: Rae Moar <rmoar@google.com>

Looks pretty good from a cursory glance.
Had some mostly stylistic nits/suggestions below.

> ---
>
> Note: The check patch script is outputting open brace errors on lines
> 154, 186, 231 of lib/hashtable_test.c but I believe the format of the
> braces on those lines is consistent with the Linux Kernel style guide.
> Will continue to look at these errors.
>
>  lib/Kconfig.debug    |  13 ++
>  lib/Makefile         |   1 +
>  lib/hashtable_test.c | 299 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 313 insertions(+)
>  create mode 100644 lib/hashtable_test.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3fc7abffc7aa..3cf3b6f8cff4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2458,6 +2458,19 @@ config LIST_KUNIT_TEST
>
>           If unsure, say N.
>
> +config HASHTABLE_KUNIT_TEST
> +       tristate "KUnit Test for Kernel Hashtable structures" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the hashtable KUnit test suite.
> +         It tests the API and basic functionality of the functions
> +         and associated macros defined in include/linux/hashtable.h.

nit: the "functions and associated macros" == "the API", so perhaps we
can shorten this a bit.

> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config LINEAR_RANGES_TEST
>         tristate "KUnit test for linear_ranges"
>         depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 161d6a724ff7..9036d3aeee0a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -370,6 +370,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
>  CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
>  obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
> new file mode 100644
> index 000000000000..7907df66a8e7
> --- /dev/null
> +++ b/lib/hashtable_test.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the Kernel Hashtable structures.
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: Rae Moar <rmoar@google.com>
> + */
> +#include <kunit/test.h>
> +
> +#include <linux/hashtable.h>
> +
> +struct hashtable_test_entry {
> +       int key;
> +       int data;
> +       struct hlist_node node;
> +       int visited;
> +};
> +
> +static void hashtable_test_hash_init(struct kunit *test)
> +{
> +       /* Test the different ways of initialising a hashtable. */
> +       DEFINE_HASHTABLE(hash1, 3);
> +       DECLARE_HASHTABLE(hash2, 3);
> +
> +       hash_init(hash1);
> +       hash_init(hash2);
> +
> +       KUNIT_EXPECT_TRUE(test, hash_empty(hash1));
> +       KUNIT_EXPECT_TRUE(test, hash_empty(hash2));
> +}
> +
> +static void hashtable_test_hash_empty(struct kunit *test)
> +{
> +       struct hashtable_test_entry a;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       hash_init(hash);
> +       KUNIT_EXPECT_TRUE(test, hash_empty(hash));
> +
> +       a.key = 1;
> +       a.data = 13;
> +       hash_add(hash, &a.node, a.key);
> +
> +       /* Hashtable should no longer be empty. */
> +       KUNIT_EXPECT_FALSE(test, hash_empty(hash));
> +}
> +
> +static void hashtable_test_hash_hashed(struct kunit *test)
> +{
> +       struct hashtable_test_entry a, b;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       hash_init(hash);
> +       a.key = 1;
> +       a.data = 13;
> +       b.key = 1;
> +       b.data = 2;
> +
> +       hash_add(hash, &a.node, a.key);
> +       hash_add(hash, &b.node, b.key);
> +
> +       KUNIT_EXPECT_TRUE(test, hash_hashed(&a.node));
> +       KUNIT_EXPECT_TRUE(test, hash_hashed(&b.node));
> +}
> +
> +static void hashtable_test_hash_add(struct kunit *test)
> +{
> +       struct hashtable_test_entry a, b, *x;
> +       int bkt;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       hash_init(hash);
> +       a.key = 1;
> +       a.data = 13;
> +       a.visited = 0;
> +       b.key = 2;
> +       b.data = 10;
> +       b.visited = 0;
> +
> +       hash_add(hash, &a.node, a.key);
> +       hash_add(hash, &b.node, b.key);
> +
> +       hash_for_each(hash, bkt, x, node) {
> +               if (x->key == a.key && x->data == a.data)
> +                       a.visited += 1;
> +               if (x->key == b.key && x->data == b.data)
> +                       b.visited += 1;
> +       }

  x->visited += 1;
or
  x->visited++;
also do the same thing.

Note: given x is supposed to point to a or b, I don't know if checking
against a.data does us much good.
If we're trying to check that hash_add() doesn't mutate the keys and
data, this code won't catch it.
We'd have to instead do something like
  if(x->key != 1 && x->key != 2) KUNIT_FAIL(test, ...);

> +
> +       /* Both entries should have been visited exactly once. */
> +       KUNIT_EXPECT_EQ(test, a.visited, 1);
> +       KUNIT_EXPECT_EQ(test, b.visited, 1);
> +}
> +
> +static void hashtable_test_hash_del(struct kunit *test)
> +{
> +       struct hashtable_test_entry a, b, *x;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       hash_init(hash);
> +       a.key = 1;
> +       a.data = 13;
> +       b.key = 2;
> +       b.data = 10;
> +       b.visited = 0;
> +
> +       hash_add(hash, &a.node, a.key);
> +       hash_add(hash, &b.node, b.key);
> +
> +       hash_del(&b.node);
> +       hash_for_each_possible(hash, x, node, b.key) {
> +               if (x->key == b.key && x->data == b.data)
> +                       b.visited += 1;

Similarly to above, x->visited += 1 (or ++) is probably better.

> +       }
> +
> +       /* The deleted entry should not have been visited. */
> +       KUNIT_EXPECT_EQ(test, b.visited, 0);
> +
> +       hash_del(&a.node);
> +
> +       /* The hashtable should be empty. */
> +       KUNIT_EXPECT_TRUE(test, hash_empty(hash));
> +}
> +
> +static void hashtable_test_hash_for_each(struct kunit *test)
> +{
> +       struct hashtable_test_entry entries[3];
> +       struct hashtable_test_entry *x;
> +       int bkt, i, j, count;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       /* Initialize a hashtable with three entries. */
> +       hash_init(hash);
> +       for (i = 0; i < 3; i++) {
> +               entries[i].key = i;
> +               entries[i].data = i + 10;
> +               entries[i].visited = 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       count = 0;
> +       hash_for_each(hash, bkt, x, node) {
> +               if (x->key >= 0 && x->key < 3)
> +                       entries[x->key].visited += 1;

Would this be better using an assert to fail the test if we see unexpected keys?
E.g. like
  if (x->key < 0 || x->key > 3) KUNIT_ASSERT_FAILURE(test, ...);
  x->visited++;
  count++;
or
  KUNIT_ASSERT_GE(test, x->key, 0);
  KUNIT_ASSERT_LT(test, x->key, 3);

> +               count++;
> +       }
> +
> +       /* Should have visited each entry exactly once. */
> +       KUNIT_EXPECT_EQ(test, count, 3);
> +       for (j = 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +}
> +
> +static void hashtable_test_hash_for_each_safe(struct kunit *test)
> +{
> +       struct hashtable_test_entry entries[3];
> +       struct hashtable_test_entry *x;
> +       struct hlist_node *tmp;
> +       int bkt, i, j, count;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       /* Initialize a hashtable with three entries. */
> +       hash_init(hash);
> +       for (i = 0; i < 3; i++) {
> +               entries[i].key = i;
> +               entries[i].data = i + 10;
> +               entries[i].visited = 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       count = 0;
> +       hash_for_each_safe(hash, bkt, tmp, x, node) {
> +               if (x->key >= 0 && x->key < 3) {
> +                       entries[x->key].visited += 1;
> +                       hash_del(&entries[x->key].node);
> +               }
> +               count++;
> +       }
> +
> +       /* Should have visited each entry exactly once. */
> +       KUNIT_EXPECT_EQ(test, count, 3);
> +       for (j = 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +}
> +
> +static void hashtable_test_hash_for_each_possible(struct kunit *test)
> +{
> +       struct hashtable_test_entry entries[4];
> +       struct hashtable_test_entry *x;
> +       int i, j, count;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       /* Initialize a hashtable with three entries with key = 1. */
> +       hash_init(hash);
> +       for (i = 0; i < 3; i++) {
> +               entries[i].key = 1;
> +               entries[i].data = i;
> +               entries[i].visited = 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       /* Add an entry with key = 2. */
> +       entries[3].key = 2;
> +       entries[3].data = 3;
> +       entries[3].visited = 0;
> +       hash_add(hash, &entries[3].node, entries[3].key);
> +
> +       count = 0;
> +       hash_for_each_possible(hash, x, node, 1) {
> +               if (x->data >= 0 && x->data < 4)
> +                       entries[x->data].visited += 1;
> +               count++;
> +       }
> +
> +       /* Should have visited each entry with key = 1 exactly once. */
> +       for (j = 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +
> +       /* If entry with key = 2 is in the same bucket as the entries with
> +        * key = 1, check it was visited. Otherwise ensure that only three
> +        * entries were visited.
> +        */
> +       if (hash_min(1, HASH_BITS(hash)) == hash_min(2, HASH_BITS(hash))) {

nit: this feels like we might be a bit too tied to the impl (not sure
if it'll change anytime soon, but still).

Could we check the bucket using hash_for_each?
E.g.

// assume we change the keys from {1,2} to {0,1}
int buckets[2];
hash_for_each(hash, bkt, x, node) {
  buckets[x->key] = bkt;
}

if (buckets[0] == buckets[1]) { // all in the same bucket
  ...
} else { ... }

> +               KUNIT_EXPECT_EQ(test, count, 4);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
> +       } else {
> +               KUNIT_EXPECT_EQ(test, count, 3);

should we also check that entries[3].visited == 0?

Daniel
