Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79466381F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 05:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjAJEYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 23:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAJEYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 23:24:09 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC640C12
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 20:24:07 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id s127so11037789vsb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jan 2023 20:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8QTCt9yyEzrP6aQZDscqKMtl+hQBPNhmxvh+D4MRoU=;
        b=EJ/sv63qnIcnduXb2hn+L1aNiqUCqPnJ4e+HaYtldnzu0qjUUCfowQsCoBhPLJQ7vF
         Gew1U8FO66t9B2aDaf3F1TDZx2Xkeut0pDCz8ibHAnj/vmRz55I/uVHquBS0LDUHa3Qz
         ehCO7JjH51q41xm99Xio946fkVojPFXJ7hpwHz6dvH81DGdKyJyXUhvz4rpcVOmraH+i
         ikfidOmzEr4XZSGcn38sHkUR1MOUgO3zIT3Tolqvt2dUSoTji7QRvP23eRPcKmBL6gNF
         CTMjCuyd9BIm2Keb2/xl0xu2WrDqiIrCnp1o2SUTe4XaFVRFTEc7PAWzscNTx9nsvXJz
         sGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8QTCt9yyEzrP6aQZDscqKMtl+hQBPNhmxvh+D4MRoU=;
        b=JJNtshgRQUbetYf+5PmrX8tth9UbLNBX3WbVWTkktMnS+jBw+NaslOnD25cpomo4Oj
         kxhFeACaRfM7blNPvDtuVemX7R862HH95JdCsSTJDAQhNv31xwWz3wyFb/cafPff36Be
         72O6voFK4FfgY9rlMgKx8A0fIrm/vvmttVXdX5AdMfdQxXFwF5kn38S5rv+nmlLIyGj2
         gfabSvtOaabjAexq1g3eRrYR+VbsgOGYgSKEM0qZ1P70iV/nfzlrarkYYTz36wB6a50h
         K7TFVqlE5tCJroTJYop6NwWmaDlPikRKaisTiJHjgVGVs4P9hmL618c1XoBf2N2RSZ05
         NrRw==
X-Gm-Message-State: AFqh2kqqzPXQAbD0Iv2KdwOQREa5egBxdLSg3PQSV+OP7tbN7sXOI5OE
        enSmT/bocPVkWd0lmQeS+Hg5y0oB69gJpa09ueXXtQ==
X-Google-Smtp-Source: AMrXdXvgRVvBp/BOFs/VYDEDognOYH/QvR7yPfcvTvzMbgEKgkeTBeUZi0/4hkI7pW6KysaTlZPa+6s+VdF+TwPrX5o=
X-Received: by 2002:a05:6102:94e:b0:3b5:1de3:19fa with SMTP id
 a14-20020a056102094e00b003b51de319famr8010763vsi.35.1673324646358; Mon, 09
 Jan 2023 20:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20221220031023.197178-1-rmoar@google.com>
In-Reply-To: <20221220031023.197178-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 10 Jan 2023 12:23:54 +0800
Message-ID: <CABVgOS=gSOqa4td5ta4Ma85-hHJ0qXp_WFga9z6se80HJC1ayQ@mail.gmail.com>
Subject: Re: [PATCH v1] lib/hashtable_test.c: add test for the hashtable structure
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 20 Dec 2022 at 11:16, Rae Moar <rmoar@google.com> wrote:
>
> Add a KUnit test for the kernel hashtable implementation in
> include/linux/hashtable.h.
>
> Note that this version does not yet test each of the rcu
> alternative versions of functions.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks for completing the triangle (hash, list, hashtable) of
hashtable-related tests!

This looks good to me, save for some nitpicks below. They're mostly
pretty similar to Daniel's comments, so should be pretty
straightforward.

Cheers,
-- David

>
> Note: The check patch script is outputting open brace errors on lines
> 154, 186, 231 of lib/hashtable_test.c but I believe the format of the
> braces on those lines is consistent with the Linux Kernel style guide.
> Will continue to look at these errors.

This is a problem we hit with the list test as well: because these
functions have for_each in their name, checkpatch.pl assumes they're
loops (using the macro), not functions.

As with the list test, we _could_ try to fix this in checkpatch, or
rename the tests, but I suspect it's a special enough case (naming a
function after a macro), that it's best to ignore the warnings,
keeping a note like this in the patch email.

Maybe one day, checkpatch.pl will be able to tell that this is a function..=
.

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
> +       tristate "KUnit Test for Kernel Hashtable structures" if !KUNIT_A=
LL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the hashtable KUnit test suite.
> +         It tests the API and basic functionality of the functions
> +         and associated macros defined in include/linux/hashtable.h.
> +         For more information on KUnit and unit tests in general please =
refer
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
> @@ -370,6 +370,7 @@ obj-$(CONFIG_PLDMFW) +=3D pldmfw/
>  CFLAGS_bitfield_kunit.o :=3D $(DISABLE_STRUCTLEAK_PLUGIN)
>  obj-$(CONFIG_BITFIELD_KUNIT) +=3D bitfield_kunit.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
> +obj-$(CONFIG_HASHTABLE_KUNIT_TEST) +=3D hashtable_test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) +=3D test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) +=3D cmdline_kunit.o
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
> +       a.key =3D 1;
> +       a.data =3D 13;
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
> +       a.key =3D 1;
> +       a.data =3D 13;
> +       b.key =3D 1;
> +       b.data =3D 2;
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
> +       a.key =3D 1;
> +       a.data =3D 13;
> +       a.visited =3D 0;
> +       b.key =3D 2;
> +       b.data =3D 10;
> +       b.visited =3D 0;
> +
> +       hash_add(hash, &a.node, a.key);
> +       hash_add(hash, &b.node, b.key);
> +
> +       hash_for_each(hash, bkt, x, node) {
> +               if (x->key =3D=3D a.key && x->data =3D=3D a.data)
> +                       a.visited +=3D 1;
> +               if (x->key =3D=3D b.key && x->data =3D=3D b.data)
> +                       b.visited +=3D 1;

I think we could improve this by checking 'x->key' is one of {a,b}.
Daniel's suggestions below are good, otherwise perhaps something like:
x->visited++;
if (x->key =3D=3D a.key)
       KUNIT_EXPECT_EQ(x->data, a.data);
else if (x->key =3D=3D b.key)
       KUNIT_EXPECT_EQ(x->data, b.data);
else
       KUNIT_EXPECT_NEQ(x->key, x->key); /* Not an expected key. */

The other, more over-the-top option would be to have an array of
struct hashtable_test_entry, rather than separate a and b variables,
and to loop over them, e.g.
x->visited++;
for (int i =3D 0; i < ARRAY_SIZE(entries); ++i) {
       if (entires[i]->key =3D=3D x->key) {
=E2=80=A6
              break;
       }
       KUNIT_EXPECT_NEQ_MSG(x->key, x->key, "Unexxpected element in hashtab=
le");
}

But I suspect the first is actually cleaner.

> +       }
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
> +       a.key =3D 1;
> +       a.data =3D 13;
> +       b.key =3D 2;
> +       b.data =3D 10;
> +       b.visited =3D 0;
> +
> +       hash_add(hash, &a.node, a.key);
> +       hash_add(hash, &b.node, b.key);
> +
> +       hash_del(&b.node);
> +       hash_for_each_possible(hash, x, node, b.key) {
> +               if (x->key =3D=3D b.key && x->data =3D=3D b.data)
> +                       b.visited +=3D 1;

Again, just increment x->visited here, and possibly add
KUNIT_EXPECT_NEQ(x->key, b.key).

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
> +       for (i =3D 0; i < 3; i++) {
> +               entries[i].key =3D i;
> +               entries[i].data =3D i + 10;
> +               entries[i].visited =3D 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       count =3D 0;
> +       hash_for_each(hash, bkt, x, node) {
> +               if (x->key >=3D 0 && x->key < 3)
> +                       entries[x->key].visited +=3D 1;

Again, let's just increment x->visited, and maybe
KUNIT_EXPECT_GEQ(x->key, 0), ..._LEQ(x->key, 3).

> +               count++;
> +       }
> +
> +       /* Should have visited each entry exactly once. */
> +       KUNIT_EXPECT_EQ(test, count, 3);
> +       for (j =3D 0; j < 3; j++)
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
> +       for (i =3D 0; i < 3; i++) {
> +               entries[i].key =3D i;
> +               entries[i].data =3D i + 10;
> +               entries[i].visited =3D 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       count =3D 0;
> +       hash_for_each_safe(hash, bkt, tmp, x, node) {
> +               if (x->key >=3D 0 && x->key < 3) {
> +                       entries[x->key].visited +=3D 1;
> +                       hash_del(&entries[x->key].node);
> +               }
> +               count++;
> +       }
> +
> +       /* Should have visited each entry exactly once. */
> +       KUNIT_EXPECT_EQ(test, count, 3);
> +       for (j =3D 0; j < 3; j++)
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
> +       /* Initialize a hashtable with three entries with key =3D 1. */
> +       hash_init(hash);
> +       for (i =3D 0; i < 3; i++) {
> +               entries[i].key =3D 1;
> +               entries[i].data =3D i;
> +               entries[i].visited =3D 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       /* Add an entry with key =3D 2. */
> +       entries[3].key =3D 2;
> +       entries[3].data =3D 3;
> +       entries[3].visited =3D 0;
> +       hash_add(hash, &entries[3].node, entries[3].key);
> +
> +       count =3D 0;
> +       hash_for_each_possible(hash, x, node, 1) {
> +               if (x->data >=3D 0 && x->data < 4)
> +                       entries[x->data].visited +=3D 1;
> +               count++;
> +       }
> +
> +       /* Should have visited each entry with key =3D 1 exactly once. */
> +       for (j =3D 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +
> +       /* If entry with key =3D 2 is in the same bucket as the entries w=
ith
> +        * key =3D 1, check it was visited. Otherwise ensure that only th=
ree
> +        * entries were visited.
> +        */
> +       if (hash_min(1, HASH_BITS(hash)) =3D=3D hash_min(2, HASH_BITS(has=
h))) {
> +               KUNIT_EXPECT_EQ(test, count, 4);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
> +       } else {
> +               KUNIT_EXPECT_EQ(test, count, 3);
> +       }

I'm a bit on-the-fence about whether or not this is too
implementation-specific. I think the way the hashtable works here is
supposed to be stable, but given that almost nothing in the actual
kernel seems to rely on hash_min directly, maybe it's better to not
lock it in with a test.

How about reducing this to a KUNIT_EXPECT_GEQ(test, count, 4)?

> +}
> +
> +static void hashtable_test_hash_for_each_possible_safe(struct kunit *tes=
t)
> +{
> +       struct hashtable_test_entry entries[4];
> +       struct hashtable_test_entry *x;
> +       struct hlist_node *tmp;
> +       int i, j, count;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       /* Initialize a hashtable with three entries with key =3D 1. */
> +       hash_init(hash);
> +       for (i =3D 0; i < 3; i++) {
> +               entries[i].key =3D 1;
> +               entries[i].data =3D i;
> +               entries[i].visited =3D 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       /* Add an entry with key =3D 2. */
> +       entries[3].key =3D 2;
> +       entries[3].data =3D 3;
> +       entries[3].visited =3D 0;
> +       hash_add(hash, &entries[3].node, entries[3].key);
> +
> +       count =3D 0;
> +       hash_for_each_possible_safe(hash, x, tmp, node, 1) {
> +               if (x->data >=3D 0 && x->data < 4) {
> +                       entries[x->data].visited +=3D 1;
> +                       hash_del(&entries[x->data].node);
> +               }
> +               count++;
> +       }
> +
> +       /* Should have visited each entry with key =3D 1 exactly once. */
> +       for (j =3D 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +
> +       /* If entry with key =3D 2 is in the same bucket as the entries w=
ith
> +        * key =3D 1, check it was visited. Otherwise ensure that only th=
ree
> +        * entries were visited.
> +        */
> +       if (hash_min(1, HASH_BITS(hash)) =3D=3D hash_min(2, HASH_BITS(has=
h))) {
> +               KUNIT_EXPECT_EQ(test, count, 4);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
> +       } else {
> +               KUNIT_EXPECT_EQ(test, count, 3);
> +       }
> +}
> +
> +static struct kunit_case hashtable_test_cases[] =3D {
> +       KUNIT_CASE(hashtable_test_hash_init),
> +       KUNIT_CASE(hashtable_test_hash_empty),
> +       KUNIT_CASE(hashtable_test_hash_hashed),
> +       KUNIT_CASE(hashtable_test_hash_add),
> +       KUNIT_CASE(hashtable_test_hash_del),
> +       KUNIT_CASE(hashtable_test_hash_for_each),
> +       KUNIT_CASE(hashtable_test_hash_for_each_safe),
> +       KUNIT_CASE(hashtable_test_hash_for_each_possible),
> +       KUNIT_CASE(hashtable_test_hash_for_each_possible_safe),
> +       {},
> +};
> +
> +static struct kunit_suite hashtable_test_module =3D {
> +       .name =3D "hashtable",
> +       .test_cases =3D hashtable_test_cases,
> +};
> +
> +kunit_test_suites(&hashtable_test_module);
> +
> +MODULE_LICENSE("GPL");
>
> base-commit: 054be257f28ca8eeb8e3620766501b81ceb4b293
> --
> 2.39.0.314.g84b9a713c41-goog
>
